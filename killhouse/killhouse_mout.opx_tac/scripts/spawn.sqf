["tsp_param_spawn", "CHECKBOX", "Spawn Screen", "", ["TSP Core", "Mission"], true] call tsp_fnc_setting;
["tsp_param_spawnStart", "CHECKBOX", "Spawn Screen on Start", "", ["TSP Core", "Mission"], true] call tsp_fnc_setting;
["tsp_param_spawnScale", "SLIDER", "Spawn Screen Scale", "", ["TSP Core", "Mission"], [0,1,0.1]] call tsp_fnc_setting;
["tsp_param_spawnLoadout", "LIST", "Loadout", "", ["TSP Core", "Mission"], [["Retain","Original","Saved"],[],1]] call tsp_fnc_setting;
["tsp_param_spectate", "LIST", "Spectate", "", ["TSP Core", "Mission"], [["Disabled","Dynamic","Forced"],[],1], {systemChat ("Spectate: "+tsp_param_spectate)}] call tsp_fnc_setting;
["tsp_param_spectateTime", "SLIDER", "Spectate Join Time", "", ["TSP Core", "Mission"], [30,240,120]] call tsp_fnc_setting;

tsp_fnc_spawn = {
	{_x#0 enableChannel [false, _x#1]} forEach [[0,true],[1,true],[2,false]];  //-- Disable global completely, disable chat for side, command and group, leave voice on so we can place markers
	if (isNil "tsp_loadout_original") then {  //-- First spawn
		[] spawn {sleep 1; tsp_loadout_original = getUnitLoadout player; tsp_loadout_saved = getUnitLoadout player};
		if (tsp_param_roleStart) then {[true] call tsp_fnc_role};
		if (time > tsp_param_spectateTime && tsp_param_spectate == "Forced") exitWith {[true] call tsp_fnc_spectate};  //-- Late joiners go to spectate
		if (tsp_param_spawnStart && tsp_param_spawn) then {[] spawn tsp_fnc_spawn_map};
	} else {  //-- Next spawns
		if (tsp_param_spectate == "Disabled" && tsp_param_spawn) then {[] spawn tsp_fnc_spawn_map};  //-- If spectate disabled, show spawn map
		player setUnitLoadout (missionNameSpace getVariable "tsp_loadout_" + tsp_param_spawnLoadout);
	};
};

tsp_fnc_spawn_killed = {
	tsp_loadout_retain = getUnitLoadout player;
	titleCut ["", "BLACK OUT", 1.5]; sleep 1.5; titleCut ["", "BLACK IN", 3];
	if (tsp_param_spectate in ["Dynamic", "Forced"]) then {[true] call tsp_fnc_spectate};		
};

tsp_fnc_spawn_map = {
	params [["_force", true], ["_spawns", []], ["_center", if (!isNil "tsp_spawnCenter") then {tsp_spawnCenter} else {tsp_debug}], ["_unit", player]]; titleCut ["", "BLACK IN", 3];	
	{
		_name = _x getVariable ["name", ([_unit, true] call BIS_fnc_getRespawnPositions) select _forEachIndex];
		_desc = _x getVariable ["description", ""];
		_code = _x getVariable ["code", {_this#9 params ["_unit", "_spawn"]; _unit attachTo [_spawn, [0,0,0]]; detach _unit;}];
		_spawns pushBack [getPos _x, _code, _name, _desc, "", "", 1, [_unit, _x]];
	} forEach ([_unit] call BIS_fnc_getRespawnPositions) + ((entities [["Respawn_TentDome_F", "B_Patrol_Respawn_tent_F"], []]) select {side (_x getVariable "group") == side _unit});
	[call bis_fnc_displayMission, position _center, _spawns, [], [], [], overcast, if (daytime > 19.5 || daytime < 4.75) then {true} else {false}, 2, true, "Spawns"] call bis_fnc_map_mod;  //-- Create map
	if (_force) then {findDisplay 506 displayCtrl 2 ctrlEnable false};  //-- Disable close button
	if (_force) then {findDisplay 506 displayAddEventHandler ["KeyDown", "if (_this#1 == 1) then {[] spawn tsp_fnc_spawn_map}"]};  //-- prevent using ESC button, open again
	if (_force) then {findDisplay 506 displayAddEventHandler ["KeyDown", "if (_this#1 == 11) then {[false] spawn tsp_fnc_spawn_map}"]};  //-- 0 button will open escapable map	
};

tsp_fnc_spectate = {
	params ["_spectate"];
	[if (_spectate) then {"Initialize"} else {"Terminate"}, [player, [], false, true, true, true, true, true, true, true]] call BIS_fnc_EGSpectator; waitUntil {alive player};
	if (_spectate) then {tsp_chat_spectator radioChannelAdd [player]} else {tsp_chat_spectator radioChannelRemove [player]};
	if !(isNil "acre_api_fnc_setSpectator") then {[_spectate] call acre_api_fnc_setSpectator};
	[player, _spectate] remoteExec ["hideObjectGlobal", 2];
};

//-- Modified BIS functions below
bis_fnc_map_mod = { //\\// Indicates me
	private ["_parentDisplayDefault","_parentDisplay","_mapCenter","_missions","_ORBAT","_markers","_images","_overcast","_scale","_defaultScale","_simulationEnabled","_displayClass","_display","_playerIcon","_playerColor","_cloudTextures","_cloudsGrid","_cloudsMax","_cloudsSize","_map","_fade","_actionText","_missionIcon","_showIconText"];
	disableserialization;

	_parentDisplayDefault = switch false do {
		case isnull (finddisplay 37): {finddisplay 37}; //--- GetReady
		case isnull (finddisplay 52): {finddisplay 52}; //--- ServerGetReady
		case isnull (finddisplay 53): {finddisplay 53}; //--- ClientGetReady
		default {[] call bis_fnc_displayMission}; //--- Mission
	};
	_parentDisplay = _this param [0,_parentDisplayDefault,[displaynull]];
	_mapCenter = _this param [1,position player];
	_mapCenter = _mapCenter call bis_fnc_position;
	_missions = _this param [2,[],[[]]];
	_ORBAT = _this param [3,[],[[]]];
	_markers = _this param [4,[],[[]]];
	_images = _this param [5,[],[[]]];
	_overcast = (_this param [6,overcast,[0]]) max 0 min 1;
	_isNight = _this param [7,false,[false]];
	_defaultScale = _this param [8,1,[0]];
	_simulationEnabled = _this param [9,false,[false]];
	_actionText = _this param [10,localize "str_a3_rscdisplaystrategicmap_missions",[""]];
	_showIconText = _this param [11,true,[true]];
	_missionIcon = _this param [12,"\A3\Ui_f\data\Map\GroupIcons\badge_rotate_%1_gs.paa",[""]];

	BIS_fnc_strategicMapOpen_showIconText = _showIconText;
	BIS_fnc_strategicMapOpen_missionIcon = _missionIcon;

	//--- Calculate terrain size and outside color
	//\\//_mapSize = [] call bis_fnc_mapSize;
	_mapSize = tsp_param_spawnScale;  //\\//-- Use my value instead of BIS Map Size
	BIS_fnc_strategicMapOpen_mapSize = _mapSize;
	BIS_fnc_strategicMapOpen_isNight = _isNight;

	//\\//_scale = 3500 / _mapSize / safezoneH;
	//\\//_scale = _scale * (_defaultScale max 0 min 1);
	_scale = tsp_param_spawnScale;  //\\//-- Use my value
	_maxSatelliteAlpha = if (_isNight) then {0.75} else {1};

	_colorOutside = configfile >> "CfgWorlds" >> worldname >> "OutsideTerrain" >> "colorOutside";
	_colorOutside = if (isarray _colorOutside) then {
		_colorOutside call bis_fnc_colorCOnfigToRGBA;
	} else {
		["colorOutside param is mission in ""CfgWorlds"" >> ""%1"" >> ""OutsideTerrain""",worldname] call bis_fnc_error;
		[0,0,0,1]
	};

	with uinamespace do {
		RscDisplayStrategicMap_scaleMin = 0;  //\\//-- So we have more zoomage
		RscDisplayStrategicMap_scaleMax = 1;  //\\//-- So we have more zoomage
		//\\//RscDisplayStrategicMap_scaleMin = _scale;
		//\\//RscDisplayStrategicMap_scaleMax = _scale;
		RscDisplayStrategicMap_scaleDefault = _scale;
		RscDisplayStrategicMap_maxSatelliteAlpha = _maxSatelliteAlpha;

		RscDisplayStrategicMap_colorOutside_R = _colorOutside select 0;
		RscDisplayStrategicMap_colorOutside_G = _colorOutside select 1;
		RscDisplayStrategicMap_colorOutside_B = _colorOutside select 2;
	};

	//--- Create the viewer
	_displayClass = if (_simulationEnabled) then {"RscDisplayStrategicMapSimulation"} else {"RscDisplayStrategicMap"};
	_parentDisplay createdisplay _displayClass;
	_display = finddisplay 506;
	if (isnull _display) exitwith {"Unable to create 'RscDisplayStrategicMap' display." call (uinamespace getvariable "bis_fnc_error"); displaynull};

	//--- Life, calculations and everything
	startloadingscreen ["","RscDisplayLoadingBlack"];

	BIS_fnc_strategicMapOpen_player = player;
	//selectnoplayer;

	//--- Process ORBAT
	BIS_fnc_strategicMapOpen_ORBAT = [];
	_onClick = [];
	{
		private ["_pos","_class","_parent","_tags","_tiers","_classParams","_text","_texture","_size","_color","_sizeLocal","_sizeParams","_sizeTexture"];
		_pos = _x param [0,player];
		_pos = _pos call bis_fnc_position;

		_class = _x param [1,configfile >> "CfgORBAT",[configfile]];
		_parent = _x param [2,_class,[configfile]];
		_tags = _x param [3,[],[[]]];
		_tiers = _x param [4,-1,[0]];

		_classParams = _class call bis_fnc_ORBATGetGroupParams;
		_text = _classParams select ("text" call bis_fnc_ORBATGetGroupParams);
		_texture = _classParams select ("texture" call bis_fnc_ORBATGetGroupParams);
		_size = _classParams select ("size" call bis_fnc_ORBATGetGroupParams);
		_color = _classParams select ("color" call bis_fnc_ORBATGetGroupParams);

		_iconSize = sqrt (_size + 1) * 32;

		//--- Group size
		//_sizeLocal = _size max 0 min (count (BIS_fnc_ORBATGetGroupParams_sizes) - 1);
		//_sizeParams = BIS_fnc_ORBATGetGroupParams_sizes select _sizeLocal;
		//_sizeTexture = _sizeParams select 0;

		BIS_fnc_strategicMapOpen_ORBAT set [
			count BIS_fnc_strategicMapOpen_ORBAT,
			[
				_class,
				[_parent,_tags,_tiers],
				[
					_texture,
					_color,
					_pos,
					_iconSize,
					_iconSize,
					0,
					"",
					false
				],
				_classParams
			]
		];

		//--- Create shortcut from ORBAT viewer
		_onClick set [count _onClick,_class];
		_onClick set [count _onClick,{[_this select 0,1] spawn bis_fnc_strategicMapAnimate; true}];
	} foreach _ORBAT;
	BIS_fnc_strategicMapOpen_ORBATonClick = _onClick;

	//--- Process Missions
	BIS_fnc_strategicMapOpen_missions = [];
	if (count _missions > 0) then {
		_playerIcon = gettext (configfile >> "CfgInGameUI" >> "IslandMap" >> "iconPlayer");
		_playerColor = (getarray (configfile >> "cfgingameui" >> "islandmap" >> "colorMe")) call BIS_fnc_colorRGBAtoHTML;

		_ctrlBackground = _display displayctrl 1000;
		_ctrlBackground ctrlshow false;

		_ctrlMissions = _display displayctrl 1500;
		_lbadd = _ctrlMissions lbadd _actionText;
		_ctrlMissions lbsetvalue [_lbadd,-1];
		_ctrlMissions lbsetcolor [_lbadd,[1,1,1,0.5]];
		{
			private ["_pos","_code","_title","_description","_player","_picture","_iconSize","_infoText","_codeParams"];
			_pos = _x param [0,player];
			_pos = _pos call bis_fnc_position;

			_code = _x param [1,{},[{}]];
			_title = _x param [2,"ERROR: MISSING TITLE",[""]];
			_description = _x param [3,"",[""]];
			_player = _x param [4,"",[""]];
			_picture = _x param [5,"",[""]];
			_iconSize = _x param [6,1,[1]];
			_codeParams = _x param [7,[],[[]]];

			_infoText = _title;
			if (_player != "") then {_infoText = _infoText + format ["<br /><t size='0.2' color='#00000000'>-<br /></t><img size='1' image='%2' color='%3'/><t size='0.8'> %1</t>",_player,_playerIcon,_playerColor];};
			if (_description != "") then {_infoText = _infoText + format ["<br /><t size='0.5' color='#00000000'>-<br /></t><t size='0.8'>%1</t>",_description];};
			//if (_picture != "") then {_infoText = _infoText + format ["<br /><img size='5.55' image='%1' />",_picture];};

			BIS_fnc_strategicMapOpen_missions set [
				count BIS_fnc_strategicMapOpen_missions,
				[
					_pos,
					_code,
					_title,
					_iconSize,
					_picture,
					0,
					0,
					0,
					_infoText,
					_codeParams
				]
			];

			_lbadd = _ctrlMissions lbadd format ["%1 (%2/%3)",_title,_foreachindex + 1,count _missions];
			_ctrlMissions lbsetvalue [_lbAdd,_foreachindex];

		} foreach _missions;

		_ctrlMissions lbsetcursel 0;
		_ctrlMissions ctrladdeventhandler [
			"lbselchanged",
			"
				_ctrlMissions = _this select 0;
				_cursel = _this select 1;
				if ((_ctrlMissions lbvalue 0) < 0) exitwith {_ctrlMissions lbdelete 0; _ctrlMissions lbsetcursel 0;};
				_mission = BIS_fnc_strategicMapOpen_missions select (_ctrlMissions lbvalue _cursel);
				[_mission select 0,1] spawn bis_fnc_strategicmapanimate;
			"
		];
	};

	//--- Process Images
	BIS_fnc_strategicMapOpen_images = [];
	{
		private ["_texture","_color","_pos","_w","_h","_dir","_text","_shadow"];
		_texture = _x param [0,"#(argb,8,8,3)color(0,0,0,0)",[""]];
		_color = _x param [1,[1,1,1,1],[[]]];
		_pos = _x param [2,position player];
		_w = _x param [3,0,[0]];
		_h = _x param [4,0,[0]];
		_dir = _x param [5,0,[0]];
		_text = _x param [6,"",[""]];
		_shadow = _x param [7,false,[false]];

		_pos = _pos call bis_fnc_position;
		_color = _color call bis_fnc_colorConfigToRGBA;
		_coef = (0.182 * safezoneH); //--- Magic constant to make kilometer a kilometer
		_w = _w * _coef;
		_h = _h * _coef;

		BIS_fnc_strategicMapOpen_images set [
			count BIS_fnc_strategicMapOpen_images,
			[_texture,_color,_pos,_w,_h,_dir,_text,_shadow]
		];
	} foreach _images;

	//--- Random clouds
	_cloudTextures = [
		"\A3\data_f\mrak_01_ca.paa",
		"\A3\data_f\mrak_02_ca.paa",
		"\A3\data_f\mrak_03_ca.paa",
		"\A3\data_f\mrak_04_ca.paa"
	];
	_cloudsGrid = 500;
	_cloudsMax = (_mapSize / _cloudsGrid) * _overcast;
	_cloudsSize = (_cloudsGrid / 2) + (_cloudsGrid * _overcast);
	BIS_fnc_strategicMapOpen_overcast = _overcast;
	BIS_fnc_strategicMapOpen_clouds = [];

	for "_i" from 1 to (_cloudsMax) do {
		BIS_fnc_strategicMapOpen_clouds set [
			count BIS_fnc_strategicMapOpen_clouds,
			[
				_cloudTextures call bis_fnc_selectrandom,
				(random _mapSize),
				((_mapSize / _cloudsMax) * _i),
				random 360,
				_cloudsSize + (_cloudsSize * _overcast),
				[1,1,1,0.25]
			]
		];
	};


	BIS_fnc_strategicMapOpen_indexSizeTexture =	("sizeTexture" call bis_fnc_ORBATGetGroupParams);
	BIS_fnc_strategicMapOpen_indexTextureSize =	("textureSize" call bis_fnc_ORBATGetGroupParams);

	BIS_fnc_strategicMapOpen_draw = {
		scriptname "bis_fnc_strategicMapOpen - Draw";
		_map = _this select 0;
		_mapSize = BIS_fnc_strategicMapOpen_mapSize / 2;
		_display = ctrlparent _map;
		_time = diag_ticktime;

		//_tooltip = (ctrlparent _map) displayctrl 2350;
		//_tooltip ctrlsetfade 1;
		//_tooltip ctrlcommit 0;

		_mousePos = _map ctrlmapscreentoworld BIS_fnc_strategicMapOpen_mousePos;
		//_mouseLimit = BIS_fnc_strategicMapOpen_mapSize / 3400;
		_mouseLimit = 2.5 / safezoneh;
		_selected = [];

		//--- Cross grid
		_map drawRectangle [
			[_mapSize,_mapSize,0],
			_mapSize,
			_mapSize,
			0,
			[1,1,1,0.42],
			"\A3\Ui_f\data\GUI\Rsc\RscDisplayStrategicMap\cross_ca.paa"
		];

		//--- Images
		{
			_map drawicon _x;
		} foreach BIS_fnc_strategicMapOpen_images;

		//--- ORBAT groups
		{
			_class = _x select 0;
			_iconParams = +(_x select 2);
			_classParams = +(_x select 3);

			_pos = _iconParams select 2;
			_iconSize = _iconParams select 3;

			if (((_iconParams select 2) distance _mousePos) < (_mouseLimit * _iconSize)) then {
				_iconParams set [3,(_iconParams select 3) * 1.2];
				_iconParams set [4,(_iconParams select 4) * 1.2];
				_selected = _x;
			};

			_textureSize = _classParams select BIS_fnc_strategicMapOpen_indexTextureSize;
			_iconSizeParams = +_iconParams;
			_iconParams set [3,(_iconParams select 3) * _textureSize];
			_iconParams set [4,(_iconParams select 4) * _textureSize];

			_map drawIcon _iconParams;

			//--- Draw size texture
			_size = _classParams select 5;
			if (_size >= 0) then {
				_sizeTexture = _classParams select BIS_fnc_strategicMapOpen_indexSizeTexture;
				_iconSizeParams set [0,_sizeTexture];
				_map drawIcon _iconSizeParams;
			};

		} foreach BIS_fnc_strategicMapOpen_ORBAT;

		//--- Clouds
		_cloudSpeed = sin _time * (1138 + 2000 * BIS_fnc_strategicMapOpen_overcast);
		{
			_texture = _x select 0;
			_posX = _x select 1;
			_posY = _x select 2;
			_dir = _x select 3;
			_size = _x select 4;
			_color = _x select 5;

			_map drawIcon [
				_texture,
				_color,
				[
					_posX + _cloudSpeed,
					_posY
				],
				_size,
				_size,
				_dir + (_time * _foreachindex) / (count BIS_fnc_strategicMapOpen_clouds * 3),
				"",
				false
			];
		} foreach BIS_fnc_strategicMapOpen_clouds;

		//--- Missions
		_textureAnimPhase = abs(6 - floor (_time * 16) % 12);
		{
			_pos = _x select 0;
			_title = _x select 2;
			_size = (_x select 3) * 32;
			_dir = 0;
			_alpha = 0.75;
			_texture = format [BIS_fnc_strategicMapOpen_missionIcon,_textureAnimPhase,_foreachindex + 1];

			//--- Icon is under cursor
			if ((_pos distance _mousePos) < (_mouseLimit * _size)) then {
				_size = _size * 1.2;
				_alpha = 1;
				_selected = _x;
			};

			//--- Outside of the screen area
			_mappos = _map ctrlmapworldtoscreen _pos;
			_mapposX = _mappos select 0;
			_mapposY = _mappos select 1;

			_borderLeft = safezoneX;
			_borderRight = safezoneX + safezoneW;
			_borderTop = safezoneY;
			_borderBottom = safezoneY + safezoneH;

			if (
				_mapposX < _borderLeft || _mapposX > _borderRight
				||
				_mapposY < _borderTop || _mapposY > _borderBottom
			) then {
				_texture = gettext (configfile >> "CfgInGameUI" >> "Cursor" >> "outArrow");
				_mapposX = _mapposX max safezoneX min (safezoneX + safezoneW);
				_mapposY = _mapposY max safezoneY min (safezoneY + safezoneH);
				_title = "";

				_offset = (_size / 1200);
				_offsetDefX = _offset;
				_offsetDefY = _offset * 4/3;
				_offsetX = 0;
				_offsetY = 0;
				_dir = -([[0.5,0.5],_mappos] call bis_fnc_dirto) - 90;

				switch (true) do {
					case (_mapposX <= _borderLeft): {
						_offsetX = +_offsetDefX;
						_mapposY = _mapposY min (_borderBottom - _offsetDefY) max (_borderTop + _offsetDefY);
					};
					case (_mapposX >= _borderRight): {
						_offsetX = -_offsetDefX;
						_mapposY = _mapposY min (_borderBottom - _offsetDefY) max (_borderTop + _offsetDefY);
					};
					case (_mapposY <= _borderTop): {
						_offsetY = +_offsetDefY;
						_mapposX = _mapposX min (_borderRight - _offsetDefX) max (_borderLeft + _offsetDefX);
					};
					case (_mapposY >= _borderBottom): {
						_offsetY = -_offsetDefY;
						_mapposX = _mapposX min (_borderRight - _offsetDefX) max (_borderLeft + _offsetDefX);
					};
				};

				_pos = _map ctrlmapscreentoworld [
					_mapposX + _offsetX,
					_mapposY + _offsetY
				];
			};

			_map drawIcon [
				_texture,
				[1,1,1,_alpha],
				_pos,
				_size,
				_size,
				_dir,
				if (BIS_fnc_strategicMapOpen_showIconText) then {" " + _title} else {""},
				2,
				0.08,
				"PuristaBold"
			];
		} foreach BIS_fnc_strategicMapOpen_missions;

		//--- Night
		if (BIS_fnc_strategicMapOpen_isNight) then {
			_map drawRectangle [
				[_mapSize,_mapSize,0],
				99999,
				99999,
				0,
				[0,0.05,0.2,0.42],
				"#(argb,8,8,3)color(1,1,1,1)"
			];
		};

		//--- Tooltip
		if (count _selected > 0 && !BIS_fnc_strategicMapOpen_mouseClickDisable) then {
			switch (count _selected) do {

				//--- ORBAT
				case 4: {
					_class = _selected select 0;
					_classParams = _selected select 3;

					[_classParams,_display,BIS_fnc_strategicMapOpen_mousePos] call bis_fnc_ORBATTooltip;
				};

				//--- Mission
				case 10;
				case 9: {
					[_selected,_display,BIS_fnc_strategicMapOpen_mousePos] call bis_fnc_ORBATTooltip;
				};
			};
		} else {
			[[],_display] call bis_fnc_ORBATTooltip;
		};
		_info ctrlcommit 0;
		BIS_fnc_strategicMapOpen_selected = _selected;
	};

	//--- Mouse click on icon
	BIS_fnc_strategicMapOpen_mouseClickDisable = false;
	BIS_fnc_strategicMapOpen_selected = [];
	BIS_fnc_strategicMapOpen_mousePos = [0,0];
	BIS_fnc_strategicMapOpen_mouse = {
		BIS_fnc_strategicMapOpen_mousePos = [_this select 1,_this select 2];
	};

	#define DIK_H               0x23
	#define DIK_NUMPAD5         0x4C

	BIS_fnc_strategicMapOpen_keyDown = {
		_display = _this select 0;
		_key = _this select 1;

		//--- H
		switch _key do {
			case DIK_H: {
				_fade = ceil ctrlfade (_display displayctrl 2);
				_fade = (_fade + 1) % 2;
				{
					(_display displayctrl _x) ctrlsetfade _fade;
					(_display displayctrl _x) ctrlcommit 0.3;
				} foreach [2,1000,1500,2350,2301];
			};
			case DIK_NUMPAD5: {
				[BIS_fnc_strategicMapOpen_mapCenter,1] spawn bis_fnc_strategicMapAnimate;
			};
		};
		false
	};


	_map = _display displayctrl 51;
	_map ctrlmapanimadd [0,_scale,_mapCenter];
	ctrlmapanimcommit _map;
	BIS_fnc_strategicMapOpen_mapCenter = _mapCenter;

	_map ctrladdeventhandler ["draw","_this call BIS_fnc_strategicMapOpen_draw;"];
	_map ctrladdeventhandler ["mousemoving","_this call BIS_fnc_strategicMapOpen_mouse;"];
	_map ctrladdeventhandler ["mouseholding","_this call BIS_fnc_strategicMapOpen_mouse;"];
	_map ctrladdeventhandler ["mousebuttonclick","[nil,_this] spawn bis_fnc_click_mod;"];
	_display displayaddeventhandler ["keydown","_this call BIS_fnc_strategicMapOpen_keyDown"];

	if (_isNight) then {
		_map ctrlsetbackgroundcolor [0,0,0,1];
		_map ctrlcommit 0;
	};

	//--- Measure
		//\\// FUCKIT

	//--- Show markers
	{
		_x setmarkeralpha 1;
	} foreach _markers;
	BIS_fnc_strategicMapOpen_markers = _markers;

	//--- Fade in
	_fade = _display displayctrl 1099;
	_fade ctrlsetfade 1;
	_fade ctrlcommit 0.5;

	//--- Create upward looking camera (increases FPS, as no scene is drawn)
	//\\//BIS_fnc_strategicMapOpen_camera = if (count allmissionobjects "Camera" == 0) then {
	//\\//	_camera = "camera" camcreate position player;
	//\\//	_camera cameraeffect ["internal","back"];
	//\\//	_camera campreparepos [position player select 0,position player select 1,(position player select 2) + 10];
	//\\//	_camera campreparetarget [position player select 0,(position player select 1) + 1,(position player select 2) + 1000];
	//\\//	_camera campreparefov 0.1;
	//\\//	_camera camcommitprepared 0;
	//\\//	_camera
	//\\//} else {
	//\\//	objnull
	//\\//};

	//--- Garbage collector
	_display displayaddeventhandler [
		"unload",
		"
			{
				_x setmarkeralpha 0;
			} foreach BIS_fnc_strategicMapOpen_markers;

			BIS_fnc_strategicMapOpen_camera cameraeffect ['terminate','back'];
			camdestroy BIS_fnc_strategicMapOpen_camera;

			BIS_fnc_strategicMapOpen_camera = nil;
			BIS_fnc_strategicMapOpen_player = nil;
			BIS_fnc_strategicMapOpen_mapSize = nil;
			BIS_fnc_strategicMapOpen_mapCenter = nil;
			BIS_fnc_strategicMapOpen_isNight = nil;
			BIS_fnc_strategicMapOpen_ORBAT = nil;
			BIS_fnc_strategicMapOpen_ORBATOverlay = nil;
			BIS_fnc_strategicMapOpen_missions = nil;
			BIS_fnc_strategicMapOpen_markers = nil;
			BIS_fnc_strategicMapOpen_images = nil;
			BIS_fnc_strategicMapOpen_draw = nil;
			BIS_fnc_strategicMapOpen_clouds = nil;
			BIS_fnc_strategicMapOpen_mousePos = nil;
			BIS_fnc_strategicMapOpen_mouseClickDisable = nil;
			BIS_fnc_strategicMapOpen_selected = nil;
			BIS_fnc_strategicMapOpen_indexSizeTexture = nil;
			BIS_fnc_strategicMapOpen_indexTextureSize = nil;
			with uinamespace do {
				RscDisplayStrategicMap_scaleMin = nil;
				RscDisplayStrategicMap_scaleMax = nil;
				RscDisplayStrategicMap_scaleDefault = nil;

				RscDisplayStrategicMap_colorOutside_R = nil;
				RscDisplayStrategicMap_colorOutside_G = nil;
				RscDisplayStrategicMap_colorOutside_B = nil;
			};
		"
	];

	//\\//cuttext ["","black in"];
	endloadingscreen;

	_display
};

bis_fnc_click_mod = {
	_var = _this param [0,"BIS_fnc_strategicMapOpen",[""]];
	_this = _this param [1,[controlnull],[[]]];

	//--- Accept only LMB
	_button = _this select 1;
	if (_button != 0) exitwith {};

	_varMouseDisable = format ["%1_mouseClickDisable",_var];
	_varORBATonClick = format ["%1_ORBATonClick",_var];
	_varSelected = format ["%1_selected",_var];
	_varDisplay = format ["%1_display",_var];

	if !(missionnamespace getvariable [_varMouseDisable,true]) then {
		disableserialization;
		_display = ctrlparent (_this select 0);
		_isMainMap = _display == finddisplay 12 && {getmissionconfigvalue ["pauseInORBATViewer",0] > 0};
		if (_isMainMap) then {_display = [] call bis_fnc_displayMission;};
		_selected = missionnamespace getvariable [_varSelected,[]];
		switch (count _selected) do {

			//--- ORBAT
			case 4;
			case 5: {
				missionnamespace setvariable [_varMouseDisable,true];
				_class = _selected select 0;
				_input = _selected select 1;
				_parent = _input select 0;
				_tags = _input select 1;
				_tiers = _input select 2;

				_fade = _display displayctrl 1099;
				_fade ctrlsetfade 0;
				_fade ctrlcommit 0.3;
				uisleep 0.3;
				if (isnull _display) exitwith {};

				//--- Show and animate ORBAT
				missionnamespace setvariable [_varDisplay,[_display]];
				_ORBATonClick = missionnamespace getvariable [_varORBATonClick,{}];
				_displayORBAT = [_parent,_display,_tags,_tiers,_ORBATonClick] call bis_fnc_ORBATOpen;
				if (_isMainMap) then {
					//--- Re-enable the main map after closing
					(finddisplay 12 displayctrl 51) ctrlenable false; //--- Disable the map to prevent cursor blinking
					_displayORBAT displayaddeventhandler ["unload","(finddisplay 12 displayctrl 51) ctrlenable true;"];
				};
				if (_class != _parent) then {
					[_class,0,1] call bis_fnc_ORBATanimate;
				};

				//--- Fade back
				waituntil {isnull _displayORBAT};
				_fade ctrlsetfade 1;
				_fade ctrlcommit 0.3;
				uisleep 0.1; //--- Delay to prevent double-clicking
				missionnamespace setvariable [_varMouseDisable,false];
			};

			//--- Mission
			case 10;
			case 9: {
				missionnamespace setvariable [_varMouseDisable,true];
				_code = _selected select 1;
				_title = _selected select 2;
				_start = [
					format [localize "str_a3_bis_fnc_strategicmapmousebuttonclick_prompt",_title],
					"",
					true,
					true,
					_display,
					true
				] call bis_fnc_guimessage;
				if (_start) then {
					missionnamespace setvariable [_varMouseDisable,true];
					_fade = _display displayctrl 1099;
					_fade ctrlsetfade 0;
					_fade ctrlcommit 0.5;
					uisleep 0.5;
					_selected spawn _code;
					titleCut ['', 'BLACK IN', 0.5];
					uisleep 0.1;
					_display closedisplay 2;
				} else {
					missionnamespace setvariable [_varMouseDisable,false];
				};
			};
		};
	};
};

if (isServer) then {tsp_chat_spectator = radioChannelCreate [[0.92, 0.25, 0.2, 1], "Spectator", "%UNIT_NAME", [], false]; publicVariable "tsp_chat_spectator"};
waitUntil {!isNull (findDisplay 46) || !isNull (findDisplay 53) || !isNull (findDisplay 52)}; 
player selectDiarySubject "Diary"; 
{_x setMarkerAlpha 0} forEach (allMapMarkers select {"bis" in _x && "respawn" in markerType _x});
waitUntil {!isNull (findDisplay 46)}; [] spawn tsp_fnc_spawn; 
{createMarkerLocal ["respawn_" + _x, player]} forEach ["west", "east", "resistance", "civilian"]; 
{_x setMarkerAlpha 0} forEach (allMapMarkers select {"bis" in _x && "respawn" in markerType _x});
player addEventHandler ["Respawn", {[] spawn tsp_fnc_spawn}]; 
player addEventHandler ["Killed", {[] spawn tsp_fnc_spawn_killed}];
player addEventHandler ["WeaponAssembled", {  //-- Respawn tents
	params ["_unit", "_tent"]; 
	if !(["respawn", typeOf _tent] call BIS_fnc_inString) exitWith {};
	_rally = (group _unit) getVariable ["rally", objNull]; if (_rally != objNull) then {deleteVehicle _rally}; 	(group _unit) setVariable ["rally", _tent];
	{_x params ["_name", "_data"]; _tent setVariable [_name, _data, true]} forEach [["name", "Rally Point"], ["description", "Placed by: " + groupid group _unit], ["group", group _unit]];
}];