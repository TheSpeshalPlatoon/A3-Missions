["tsp_cba_core_chvd", "CHECKBOX", "Enable CHVD", "Enables CHVD menu.", "TSP Core", tsp_mission] call tsp_fnc_setting;
chvd_fnc_fovViewDistance = {
	private ["_ret"];
	_minViewDistance = [_this, 0, 0, [0]] call BIS_fnc_param;
	_ret = _minViewDistance;

	_zoom = call CHVD_fnc_trueZoom;
	if (_zoom >= 1) then {
		_ret = _minViewDistance + ((12000 / 74) * (_zoom - 1)) min viewDistance;	
	};

	//systemChat str _ret;
	_ret
};
chvd_fnc_init = {
	if (!hasInterface) exitWith {};
	//Wait for mission init, in case there are variables defined some place else
	waitUntil {time > 0};
	
	//Define variables, load from profileNamespace
	CHVD_allowNoGrass = if (isNil "CHVD_allowNoGrass") then {true} else {CHVD_allowNoGrass};
	CHVD_maxView = if (isNil "CHVD_maxView") then {12000} else {CHVD_maxView};
	CHVD_maxObj = if (isNil "CHVD_maxObj") then {12000} else {CHVD_maxObj};
	
	CHVD_footSyncMode = profileNamespace getVariable ["CHVD_footSyncMode",0];
	CHVD_footSyncPercentage = profileNamespace getVariable ["CHVD_footSyncPercentage",0.8];	
	CHVD_carSyncMode = profileNamespace getVariable ["CHVD_carSyncMode",0];
	CHVD_carSyncPercentage = profileNamespace getVariable ["CHVD_carSyncPercentage",0.8];	
	CHVD_airSyncMode = profileNamespace getVariable ["CHVD_airSyncMode",0];
	CHVD_airSyncPercentage = profileNamespace getVariable ["CHVD_airSyncPercentage",0.8];

	CHVD_foot = (profileNamespace getVariable ["CHVD_foot",viewDistance]) min CHVD_maxView;
	CHVD_car = (profileNamespace getVariable ["CHVD_car",viewDistance]) min CHVD_maxView;
	CHVD_air = (profileNamespace getVariable ["CHVD_air",viewDistance]) min CHVD_maxView;

	CHVD_footObj = (profileNamespace getVariable ["CHVD_footObj",viewDistance]) min CHVD_maxObj min CHVD_maxView;
	CHVD_footObj = if (CHVD_footSyncMode isEqualTo 1) then {CHVD_foot * CHVD_footSyncPercentage} else {CHVD_footObj};	
	CHVD_carObj = (profileNamespace getVariable ["CHVD_carObj",viewDistance]) min CHVD_maxObj min CHVD_maxView;
	CHVD_carObj = if (CHVD_carSyncMode isEqualTo 1) then {CHVD_car * CHVD_carSyncPercentage} else {CHVD_carObj};	
	CHVD_airObj = (profileNamespace getVariable ["CHVD_airObj",viewDistance]) min CHVD_maxObj min CHVD_maxView;
	CHVD_airObj = if (CHVD_airSyncMode isEqualTo 1) then {CHVD_air * CHVD_airSyncPercentage} else {CHVD_airObj};

	CHVD_footTerrain = if (CHVD_allowNoGrass) then {profileNamespace getVariable ["CHVD_footTerrain",25]} else {(profileNamespace getVariable ["CHVD_footTerrain",25]) min 48.99 max 3.125};
	CHVD_carTerrain = if (CHVD_allowNoGrass) then {profileNamespace getVariable ["CHVD_carTerrain",25]} else {(profileNamespace getVariable ["CHVD_carTerrain",25]) min 48.99 max 3.125};
	CHVD_airTerrain = if (CHVD_allowNoGrass) then {profileNamespace getVariable ["CHVD_airTerrain",25]} else {(profileNamespace getVariable ["CHVD_airTerrain",25]) min 48.99 max 3.125};
	
	CHVD_vehType = 0; // 0 = foot, 1 = car, 2 = air

	//Begin initialization
	waitUntil {!isNull player};
	waitUntil {!isNull findDisplay 46};

	if (isClass (configfile >> "CfgPatches" >> "cba_keybinding")) then {
		call CHVD_fnc_keyBindings;
	} else {
		_actionText = if (isLocalized "STR_chvd_title") then {localize "STR_chvd_title"} else {"View Distance Settings"};
		//--player addAction [_actionText, CHVD_fnc_openDialog, [], -99, false, true, '', '_target isEqualTo _this'];
		//--player addEventHandler ["Respawn", format ["player addAction ['%1', CHVD_fnc_openDialog, [], -99, false, true, '', '_target isEqualTo _this']", _actionText]];
	};
	(findDisplay 46) displayAddEventHandler ["Unload", {call CHVD_fnc_updateSettings}]; // Reset obj view distance so game doesn't lag when browsing menues and so on, if FOV method was used during the game
	
	[] call CHVD_fnc_updateVehType;
	[] call CHVD_fnc_updateSettings;

	//Detect when to change setting type
	[] spawn {
		for "_i" from 0 to 1 step 0 do {
			_currentVehicle = vehicle player;			
			waitUntil {_currentVehicle != vehicle player};			
			[] call CHVD_fnc_updateVehType;
			if (
				(CHVD_vehType isEqualTo 0 && CHVD_footSyncMode isEqualTo 2) || 
				(CHVD_vehType isEqualTo 1 && CHVD_carSyncMode isEqualTo 2) || 
				(CHVD_vehType isEqualTo 2 && CHVD_airSyncMode isEqualTo 2)
			) then {
				[1] call CHVD_fnc_updateSettings;
				[] call CHVD_fnc_updateTerrain;
				[4] call CHVD_fnc_updateSettings
			} else {				
				[] call CHVD_fnc_updateSettings;
			};
		};
	};
	
	[] spawn {
		for "_i" from 0 to 1 step 0 do {
			_UAVstatus = call CHVD_fnc_UAVstatus;			
			waitUntil {_UAVstatus != call CHVD_fnc_UAVstatus};			
			[] call CHVD_fnc_updateVehType;
			if (
				(CHVD_vehType isEqualTo 0 && CHVD_footSyncMode isEqualTo 2) || 
				(CHVD_vehType isEqualTo 1 && CHVD_carSyncMode isEqualTo 2) || 
				(CHVD_vehType isEqualTo 2 && CHVD_airSyncMode isEqualTo 2)
			) then {
				[1] call CHVD_fnc_updateSettings;
				[] call CHVD_fnc_updateTerrain;
				[4] call CHVD_fnc_updateSettings
			} else {
				[] call CHVD_fnc_updateSettings;
			};
		};
	};
	
	[] spawn {
		for "_i" from 0 to 1 step 0 do {
			_currentZoom = call CHVD_fnc_trueZoom;			
			waitUntil {_currentZoom != call CHVD_fnc_trueZoom};			
			if (
				(CHVD_vehType isEqualTo 0 && CHVD_footSyncMode isEqualTo 2) || 
				(CHVD_vehType isEqualTo 1 && CHVD_carSyncMode isEqualTo 2) || 
				(CHVD_vehType isEqualTo 2 && CHVD_airSyncMode isEqualTo 2)
			) then {[4] call CHVD_fnc_updateSettings};
		};
	};
};
chvd_fnc_keyBindings = {
	#include "\a3\editor_f\Data\Scripts\dikCodes.h"

	_textDecreaseVD = if (isLocalized "STR_chvd_decreaseVD") then {localize "STR_chvd_decreaseVD"} else {"Decrease view distance"};
	_decViewdistKey = ["CH View Distance", "dec_viewdistance", _textDecreaseVD, {[0] call CHVD_fnc_keyDown}, "", [DIK_LBRACKET, [false, true, false]], true] call CBA_fnc_addKeybind;

	_textIncreaseVD = if (isLocalized "STR_chvd_increaseVD") then {localize "STR_chvd_increaseVD"} else {"Increase view distance"};
	_incViewdistKey = ["CH View Distance", "inc_viewdistance", _textIncreaseVD, {[1] call CHVD_fnc_keyDown}, "", [DIK_RBRACKET, [false, true, false]], true] call CBA_fnc_addKeybind;

	_textOpenSettings = if (isLocalized "STR_chvd_openSettings") then {localize "STR_chvd_openSettings"} else {"Open view distance settings"};
	_openSettingsKey = ["CH View Distance", "open_settings", _textOpenSettings, {call CHVD_fnc_openDialog}, "", [DIK_BACKSLASH, [false, true, false]], false] call CBA_fnc_addKeybind;

	_textDecreaseTerrain = if (isLocalized "STR_chvd_decreaseTerrain") then {localize "STR_chvd_decreaseTerrain"} else {"Decrease terrain quality"};
	_decTerrainKey = ["CH View Distance", "dec_terrain_quality", _textDecreaseTerrain, {[-1] call CHVD_fnc_keyDownTerrain}, "", [DIK_LBRACKET, [true, false, false]], true] call CBA_fnc_addKeybind;

	_textIncreaseTerrain = if (isLocalized "STR_chvd_increaseTerrain") then {localize "STR_chvd_increaseTerrain"} else {"Increase terrain quality"};
	_incTerrainKey = ["CH View Distance", "inc_terrain_quality", _textIncreaseTerrain, {[1] call CHVD_fnc_keyDownTerrain}, "", [DIK_RBRACKET, [true, false, false]], true] call CBA_fnc_addKeybind;

	_useShift = _openSettingsKey select 1 select 0;
	_useCtrl = _openSettingsKey select 1 select 1;
	_useAlt = _openSettingsKey select 1 select 2;

	_SCAstring = (if (_useShift) then {"Shift + "} else {""}) + (if (_useCtrl) then {"Ctrl + "} else {""}) + (if (_useAlt) then {"Alt + "} else {""});

	//systemChat format ["CH View Distance: CBA Keybindings activated. Press <%1%2> to open settings.", _SCAstring, [[_openSettingsKey select 0] call BIS_fnc_keyCode] call CBA_fnc_capitalize];
};
chvd_fnc_keyDown = {
	if (CHVD_keyDown) exitWith {};
	CHVD_keyDown = true;

	private ["_vehTypeString"];
	_updateType = [_this, 0, 0, [0]] call BIS_fnc_param; // 0 - decrease VD, 1 - increase VD
	_updateValue = if (_updateType isEqualTo 0) then {-500} else {500};

	if (!isNull (findDisplay 2900)) then {call CHVD_fnc_openDialog};

	switch (CHVD_vehType) do {
		case 1: {
			_vehTypeString = "car";
		};
		case 2: {
			_vehTypeString = "air";
		};
		default {
			_vehTypeString = "foot";
		};
	};

	_updateMode = call compile ("CHVD_" + _vehTypeString + "SyncMode");
	_viewDistVar = "CHVD_" + _vehTypeString;
	_viewDist = call compile _viewDistVar;
	_objViewDistVar = "CHVD_" + _vehTypeString + "Obj";
	_objViewDist = call compile _objViewDistVar;
	_vdDiff = _viewDist - _objViewDist;

	switch (_updateMode) do {
		case 1: {
			_viewDistValue = _viewDist + _updateValue min CHVD_maxView max 500;		
			
			_percentVar = "CHVD_" + _vehTypeString + "SyncPercentage";
			_percentValue = call compile _percentVar;
			
			_objViewDistValue = _viewDistValue * _percentValue min CHVD_maxObj;
			
			if (_objViewDistValue >= 500) then {
				call compile format ["%1 = %2", _viewDistVar, _viewDistValue];
				call compile format ["profileNamespace setVariable ['%1',%1]", _viewDistVar];
				call compile format ["%1 = %2", _objViewDistVar, _objViewDistValue];
				call compile format ["profileNamespace setVariable ['%1',%1]", _objViewDistVar];
				
				[3] call CHVD_fnc_updateSettings;
			};
		};
		case 2: {		
			_objViewDistValue = _objViewDist + _updateValue min _viewDist min CHVD_maxObj max 500;
			call compile format ["%1 = %2", _objViewDistVar, _objViewDistValue];
			call compile format ["profileNamespace setVariable ['%1',%1]", _objViewDistVar];
			
			[4] call CHVD_fnc_updateSettings;
		};
		default {
			_viewDistValue = _viewDist + _updateValue min CHVD_maxView max (500 + _vdDiff);
			_objViewDistValue = _objViewDist + _updateValue min (_viewDistValue - _vdDiff) min CHVD_maxObj max 500;
			call compile format ["%1 = %2", _viewDistVar, _viewDistValue];
			call compile format ["profileNamespace setVariable ['%1',%1]", _viewDistVar];
			
			call compile format ["%1 = %2", _objViewDistVar, _objViewDistValue];
			call compile format ["profileNamespace setVariable ['%1',%1]", _objViewDistVar];
					
			[3] call CHVD_fnc_updateSettings;	
		};
	};

	_vdString = "";
	for "_i" from 1 to (35) step 1 do {
		if ((call compile _viewDistVar) < CHVD_maxView / 35 * _i) then {
			_vdString = _vdString + "·";
		} else {	
			_vdString = _vdString + "I";
		};
	};

	_ovdString = "";
	for "_i" from 1 to (35) step 1 do {
		if ((call compile _objViewDistVar) < CHVD_maxObj / 35 * _i) then {
			_ovdString = _ovdString + "·";
		} else {	
			_ovdString = _ovdString + "I";
		};
	};

	_textViewDistance = if (isLocalized "STR_chvd_viewDistance") then {localize "STR_chvd_viewDistance"} else {"View Distance"};
	_textObjViewDistance = if (isLocalized "STR_chvd_objViewDistance") then {localize "STR_chvd_objViewDistance"} else {"View Distance"};

	hintSilent parseText format ["<t align='left' size='1.33'>
	%2:	<t align='right'>%3</t>
	<br /> 
	<t size='2' shadow='0' color='%1'>%4</t>
	<br /> 
	%5: <t align='right'>%6</t>
	<br /> 
	<t size='2' shadow='0' color='%1'>%7</t>
	</t>", 
	[profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843], profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019], profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862], profilenamespace getvariable ['GUI_BCG_RGB_A',0.7]] call BIS_fnc_colorRGBAtoHTML,
	_textViewDistance,
	call compile _viewDistVar, 
	_vdString, 
	_textObjViewDistance,
	call compile _objViewDistVar, 
	_ovdString
	];

	terminate (missionNamespace getVariable ["CHVD_hintHandle", scriptNull]);
	CHVD_hintHandle = [] spawn {
		uiSleep 2;
		hintSilent "";
	};

	[] spawn {
		uiSleep 0.05;
		CHVD_keyDown = false;
	};
};
chvd_fnc_keyDownTerrain = {
	if (CHVD_keyDown) exitWith {};
	CHVD_keyDown = true;

	private ["_vehTypeString"];
	_updateType = [_this, 0, 0, [0]] call BIS_fnc_param; 
	if (_updateType isEqualTo 0) exitWith {};
	_terrainGridArray = [50, 48.99, 25, 12.5, 3.125];

	if (!isNull (findDisplay 2900)) then {call CHVD_fnc_openDialog};

	switch (CHVD_vehType) do {
		case 1: {
			_vehTypeString = "car";
		};
		case 2: {
			_vehTypeString = "air";
		};
		default {
			_vehTypeString = "foot";
		};
	};

	_terrainGridVar = "CHVD_" + _vehTypeString + "Terrain";
	_terrainGrid = call compile _terrainGridVar;
	_terrainIndex = switch (true) do {
		case (_terrainGrid >= 49): {0};
		case (_terrainGrid >= 48.99): {1};
		case (_terrainGrid >= 25): {2};
		case (_terrainGrid >= 12.5): {3};
		case (_terrainGrid >= 3.125): {4};
		default {1};
	};
	_terrainIndex = (_terrainIndex + _updateType) max 0 min 4;
	_terrainGrid = _terrainGridArray select _terrainIndex;

	if (!CHVD_allowNoGrass) then {
		_terrainIndex = _terrainIndex max 1;
		_terrainGrid = _terrainGrid min 48.99;
	};

	call compile format ["%1 = %2", _terrainGridVar, _terrainGrid];
	call compile format ["profileNamespace setVariable ['%1',%1]", _terrainGridVar];

	call CHVD_fnc_updateTerrain;

	_terrainString = "";
	for "_i" from (37.125) to 3.125 step -1 do {
		if (round ((sqrt _terrainGrid) * 10) -18  >= 53 / 37.125 * _i) then {
			_terrainString = _terrainString + "·";
		} else {	
			_terrainString = _terrainString + "I";
		};
	};

	_terrainQualityArray = [
		["Low", localize "STR_chvd_low"] select (isLocalized "STR_chvd_low"),
		["Standart", localize "STR_chvd_standard"] select (isLocalized "STR_chvd_standard"),
		["High", localize "STR_chvd_high"] select (isLocalized "STR_chvd_high"),
		["Very High", localize "STR_chvd_veryHigh"] select (isLocalized "STR_chvd_veryHigh"),
		["Ultra", localize "STR_chvd_ultra"] select (isLocalized "STR_chvd_ultra")
	];
	_terrainQuality = _terrainQualityArray select _terrainIndex;
	_textTerrainQuality = if (isLocalized "STR_chvd_terrainQuality") then {localize "STR_chvd_terrainQuality"} else {"Terrain Quality"};
	_textTerrainGrid = if (isLocalized "STR_chvd_terrainGrid") then {localize "STR_chvd_terrainGrid"} else {"Terrain Grid"};

	hintSilent parseText format ["<t align='left' size='1.33'>
	%2: <t align='right'>%3</t>
	<br /> 
	%4: <t align='right'>%5</t>
	<br /> 
	<t size='2' shadow='0' color='%1'>%6</t>
	</t>", 
	[profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843], profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019], profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862], profilenamespace getvariable ['GUI_BCG_RGB_A',0.7]] call BIS_fnc_colorRGBAtoHTML,
	_textTerrainQuality,
	_terrainQuality,
	_textTerrainGrid,
	_terrainGrid,
	_terrainString
	];

	terminate (missionNamespace getVariable ["CHVD_hintHandle", scriptNull]);
	CHVD_hintHandle = [] spawn {
		uiSleep 2;
		hintSilent "";
	};

	[] spawn {
		uiSleep 0.05;
		CHVD_keyDown = false;
	};
};
chvd_fnc_localize = {
	_display = (_this select 0) select 0;

	if (isLocalized "STR_chvd_title") then {
		(_display displayCtrl 1000) ctrlSetText (toUpper (localize "STR_chvd_title"));
	};
	if (isLocalized "STR_chvd_foot") then {
		(_display displayCtrl 1001) ctrlSetText (localize "STR_chvd_foot");
	};
	if (isLocalized "STR_chvd_car") then {
		(_display displayCtrl 1008) ctrlSetText (localize "STR_chvd_car");
	};
	if (isLocalized "STR_chvd_air") then {
		(_display displayCtrl 1015) ctrlSetText (localize "STR_chvd_air");
	};
	if (isLocalized "STR_chvd_view") then {
		(_display displayCtrl 1002) ctrlSetText (localize "STR_chvd_view");
		(_display displayCtrl 1010) ctrlSetText (localize "STR_chvd_view");
		(_display displayCtrl 1016) ctrlSetText (localize "STR_chvd_view");
	};
	if (isLocalized "STR_chvd_object") then {
		(_display displayCtrl 1003) ctrlSetText (localize "STR_chvd_object");
		(_display displayCtrl 1011) ctrlSetText (localize "STR_chvd_object");
		(_display displayCtrl 1021) ctrlSetText (localize "STR_chvd_object");
	};
	if (isLocalized "STR_chvd_terrain") then {
		(_display displayCtrl 1005) ctrlSetText (localize "STR_chvd_terrain");
		(_display displayCtrl 1012) ctrlSetText (localize "STR_chvd_terrain");
		(_display displayCtrl 1019) ctrlSetText (localize "STR_chvd_terrain");
	};
	if (isLocalized "STR_chvd_sync") then {
		(_display displayCtrl 1403) ctrlSetText (localize "STR_chvd_sync");
		(_display displayCtrl 1405) ctrlSetText (localize "STR_chvd_sync");
		(_display displayCtrl 1407) ctrlSetText (localize "STR_chvd_sync");
	};
	if (isLocalized "STR_chvd_close") then {
		(_display displayCtrl 1612) ctrlSetText (localize "STR_chvd_close");
	};
};
chvd_fnc_onEBinput_syncmode = {
	_textBoxCtrl = [_this, 0, controlNull, [0, controlNull]] call BIS_fnc_param;
	_varString = [_this, 1, "", [""]] call BIS_fnc_param; // type of variable to use: foot/car/air
	_sliderCtrl = [_this, 2, controlNull, [0, controlNull]] call BIS_fnc_param;
	_sliderTextboxCtrl = [_this, 3, controlNull, [0, controlNull]] call BIS_fnc_param;

	_inputValue = [ctrlText _textBoxCtrl, "0123456789"] call BIS_fnc_filterString;
	_inputValue = if (_inputValue == "") then {1} else {call compile _inputValue min 100 max 1};

	ctrlSetText [_textBoxCtrl, (str _inputValue + "%")];

	_percentageVar = "CHVD_" + _varString + "SyncPercentage";
	_percentage = _inputValue / 100;
	call compile format ["%1 = %2", _percentageVar, _percentage];
	call compile format ["profileNamespace setVariable ['%1',%1]", _percentageVar];

	_viewDistVar = "CHVD_" + _varString;
	_viewDist = call compile _viewDistVar;
	_objVDVar = "CHVD_" + _varString + "Obj";
	_objVD = _viewDist * _percentage min CHVD_maxObj;

	sliderSetPosition [_sliderCtrl, _objVD];
	ctrlSetText [_sliderTextboxCtrl, str round _objVD];
			
	call compile format ["%1 = %2", _objVDVar, _objVD];
	call compile format ["profileNamespace setVariable ['%1',%1]", _objVDVar];

	[2] call CHVD_fnc_updateSettings;
};
chvd_fnc_onEBinput = {
	private ["_textValue","_updateType"];
	_varType1 = [_this, 0, "", [""]] call BIS_fnc_param;
	_slider1 = [_this, 1, controlNull, [0, controlNull]] call BIS_fnc_param;
	_text1 = [_this, 2, controlNull, [0, controlNull]] call BIS_fnc_param;
	_varType2 = [_this, 3, "", [""]] call BIS_fnc_param;
	_slider2 = [_this, 4, controlNull, [0, controlNull]] call BIS_fnc_param;
	_text2 = [_this, 5, controlNull, [0, controlNull]] call BIS_fnc_param;
	_modeVar = [_this, 6, "", [""]] call BIS_fnc_param;
	_percentVar = [_this, 7, "", [""]] call BIS_fnc_param;

	if (count _this < 7) then {
		_updateType = 2;
	} else {
		_modeVar = call compile _modeVar;
		switch (_modeVar) do {
			case 1: {
				_updateType = 3;
			};
			default {
				_updateType = 1;		
			};	
		};
	};


	_textValue = [ctrlText _text1, "0123456789"] call BIS_fnc_filterString;
	_textValue = if (_textValue == "") then {1} else {call compile _textValue min 12000 max 0};

	_viewDistValue = _textValue min CHVD_maxView;
	_objViewDistValue = if (_modeVar isEqualTo 1) then {_textValue  * (call compile _percentVar) min CHVD_maxObj} else {_textValue min CHVD_maxObj};  // Check if percentage sync mode is used, if so use a percentage coefficient

	switch (_updateType) do {  // 1 - VIEW, 2 - OBJ, 3 - BOTH, 0 - BOTH AND TERRAIN
		case 1: {
			sliderSetPosition [_slider1, _viewDistValue];
			sliderSetRange [_slider2, 0, _viewDistValue];
				
			call compile format ["%1 = %2", _varType1, _viewDistValue];
			call compile format ["profileNamespace setVariable ['%1',%1]", _varType1];
			
			if ((call compile _varType2) > _viewDistValue) then { // Update object VD slider and text so it doesn't stay at higher value than VD slider
				sliderSetPosition [_slider2, _objViewDistValue];
				ctrlSetText [_text2, str round _objViewDistValue];

				call compile format ["%1 = %2", _varType2, _objViewDistValue];
				call compile format ["profileNamespace setVariable ['%1',%1]", _varType2];
			};
			
			[_updateType] call CHVD_fnc_updateSettings;
		};
		case 2: {
			sliderSetPosition [_slider1, _objViewDistValue];
				
			call compile format ["%1 = %2", _varType1, _objViewDistValue];
			call compile format ["profileNamespace setVariable ['%1',%1]", _varType1];
				
			[_updateType] call CHVD_fnc_updateSettings;
		};
		case 3: {
			sliderSetPosition [_slider1, _viewDistValue];
			sliderSetRange [_slider2, 0, _viewDistValue];
				
			call compile format ["%1 = %2", _varType1, _viewDistValue];
			call compile format ["profileNamespace setVariable ['%1',%1]", _varType1];
			
			if ((call compile _varType2) > _viewDistValue) then {  // Update object VD slider and text so it doesn't stay at higher value than VD slider
				sliderSetPosition [_slider2, _objViewDistValue];
				ctrlSetText [_text2, str round _objViewDistValue];

				call compile format ["%1 = %2", _varType2, _objViewDistValue];
				call compile format ["profileNamespace setVariable ['%1',%1]", _varType2];
			};
			
			sliderSetPosition [_slider2, _objViewDistValue];
			ctrlSetText [_text2, str round _objViewDistValue];	
			
			call compile format ["%1 = %2", _varType2, _objViewDistValue];
			call compile format ["profileNamespace setVariable ['%1',%1]", _varType2];
			
			[_updateType] call CHVD_fnc_updateSettings;
		};	
	};
};
chvd_fnc_onEBterrainInput = {
	private ["_textValue","_updateType"];
	_varType1 = [_this, 0, "", [""]] call BIS_fnc_param;
	_slider1 = [_this, 1, controlNull, [0, controlNull]] call BIS_fnc_param;
	_text1 = [_this, 2, controlNull, [0, controlNull]] call BIS_fnc_param;
	_varType2 = [_this, 3, "", [""]] call BIS_fnc_param;
	_slider2 = [_this, 4, controlNull, [0, controlNull]] call BIS_fnc_param;
	_text2 = [_this, 5, controlNull, [0, controlNull]] call BIS_fnc_param;
	_modeVar = [_this, 6, "", [""]] call BIS_fnc_param;
	_percentVar = [_this, 7, "", [""]] call BIS_fnc_param;

	if (count _this < 7) then {
		_updateType = 2;
	} else {
		_modeVar = call compile _modeVar;
		switch (_modeVar) do {
			case 1: {
				_updateType = 3;
			};
			default {
				_updateType = 1;		
			};	
		};
	};


	_textValue = [ctrlText _text1, "0123456789"] call BIS_fnc_filterString;
	_textValue = if (_textValue == "") then {1} else {call compile _textValue min 12000 max 0};

	_viewDistValue = _textValue min CHVD_maxView;
	_objViewDistValue = if (_modeVar isEqualTo 1) then {_textValue  * (call compile _percentVar) min CHVD_maxObj} else {_textValue min CHVD_maxObj};  // Check if percentage sync mode is used, if so use a percentage coefficient

	switch (_updateType) do {  // 1 - VIEW, 2 - OBJ, 3 - BOTH, 0 - BOTH AND TERRAIN
		case 1: {
			sliderSetPosition [_slider1, _viewDistValue];
			sliderSetRange [_slider2, 0, _viewDistValue];
				
			call compile format ["%1 = %2", _varType1, _viewDistValue];
			call compile format ["profileNamespace setVariable ['%1',%1]", _varType1];
			
			if ((call compile _varType2) > _viewDistValue) then { // Update object VD slider and text so it doesn't stay at higher value than VD slider
				sliderSetPosition [_slider2, _objViewDistValue];
				ctrlSetText [_text2, str round _objViewDistValue];

				call compile format ["%1 = %2", _varType2, _objViewDistValue];
				call compile format ["profileNamespace setVariable ['%1',%1]", _varType2];
			};
			
			[_updateType] call CHVD_fnc_updateSettings;
		};
		case 2: {
			sliderSetPosition [_slider1, _objViewDistValue];
				
			call compile format ["%1 = %2", _varType1, _objViewDistValue];
			call compile format ["profileNamespace setVariable ['%1',%1]", _varType1];
				
			[_updateType] call CHVD_fnc_updateSettings;
		};
		case 3: {
			sliderSetPosition [_slider1, _viewDistValue];
			sliderSetRange [_slider2, 0, _viewDistValue];
				
			call compile format ["%1 = %2", _varType1, _viewDistValue];
			call compile format ["profileNamespace setVariable ['%1',%1]", _varType1];
			
			if ((call compile _varType2) > _viewDistValue) then {  // Update object VD slider and text so it doesn't stay at higher value than VD slider
				sliderSetPosition [_slider2, _objViewDistValue];
				ctrlSetText [_text2, str round _objViewDistValue];

				call compile format ["%1 = %2", _varType2, _objViewDistValue];
				call compile format ["profileNamespace setVariable ['%1',%1]", _varType2];
			};
			
			sliderSetPosition [_slider2, _objViewDistValue];
			ctrlSetText [_text2, str round _objViewDistValue];	
			
			call compile format ["%1 = %2", _varType2, _objViewDistValue];
			call compile format ["profileNamespace setVariable ['%1',%1]", _varType2];
			
			[_updateType] call CHVD_fnc_updateSettings;
		};	
	};
};
chvd_fnc_onLBSelChanged_syncmode = {
	private ["_varString"];
	_mode = _this select 0;
	_varString = [_this, 1, "", [""]] call BIS_fnc_param; // type of variable to use: foot/car/air
	_textBoxCtrl = [_this, 2, controlNull, [0, controlNull]] call BIS_fnc_param;
	_sliderCtrl = [_this, 3, controlNull, [0, controlNull]] call BIS_fnc_param;
	_sliderTextboxCtrl = [_this, 4, controlNull, [0, controlNull]] call BIS_fnc_param;

	switch (_mode) do {
		case 1: {
			ctrlEnable [_textBoxCtrl, true];
			_percentageVar = "CHVD_" + _varString + "SyncPercentage";
			_percentage = call compile _percentageVar;
			ctrlSetText [_textBoxCtrl, format ["%1",_percentage * 100] + "%"];	
			
			_viewDistVar = "CHVD_" + _varString;
			_viewDist = call compile _viewDistVar;
			_objVDVar = "CHVD_" + _varString + "Obj";
			_objVD = _viewDist * _percentage min CHVD_maxObj;
			
			//disable VD slider and textbox because they are not in use
			ctrlEnable [_sliderCtrl, false];
			sliderSetPosition [_sliderCtrl, _objVD];
			ctrlEnable [_sliderTextboxCtrl, false];		
			ctrlSetText [_sliderTextboxCtrl, str round _objVD];
			
			call compile format ["%1 = %2", _objVDVar, _objVD];
			call compile format ["profileNamespace setVariable ['%1',%1]", _objVDVar];
		};
		default {
			ctrlEnable [_textBoxCtrl, false];
			ctrlSetText [_textBoxCtrl, ""];
			
			//enable VD slider and textbox in case they are disabled
			ctrlEnable [_sliderCtrl, true];
			ctrlEnable [_sliderTextboxCtrl, true];		
		};	
	};

	_modeVar = "CHVD_" + _varString + "SyncMode";
	call compile format ["%1 = %2", _modeVar, _mode];
	call compile format ["profileNamespace setVariable ['%1',%1]", _modeVar];

	[2] call CHVD_fnc_updateSettings;
};
chvd_fnc_onLBSelChanged = {
	private ["_index","_terrainGrid"];
	_index = _this select 0;
	_varType = _this select 1;
	_text = _this select 2;

	if (!CHVD_allowNoGrass) then {
		_index = _index + 1;
	};

	switch (_index) do {
		case 0: {_terrainGrid = 50};
		case 1: {_terrainGrid = 48.99};
		case 2: {_terrainGrid = 25};
		case 3: {_terrainGrid = 12.5};
		case 4: {_terrainGrid = 3.125};
	};

	if (!CHVD_allowNoGrass) then {
		_terrainGrid = _terrainGrid min 48.99;
	};
	ctrlSetText [_text, str _terrainGrid];
	call compile format ["%1 = %2",_varType, _terrainGrid];
	call compile format ["profileNamespace setVariable ['%1',%1]", _varType];
	[] call CHVD_fnc_updateTerrain;
};
chvd_fnc_onSliderChange = {
	private ["_sliderPos","_updateType"];
	_varType1 = [_this, 0, "", [""]] call BIS_fnc_param;
	_slider1 = ctrlIDC ([_this, 1, 0, [0, controlNull]] call BIS_fnc_param);
	_sliderPos = [_this, 2, 0, [0]] call BIS_fnc_param;
	_text1 = [_this, 3, 0, [0, controlNull]] call BIS_fnc_param;
	_varType2 = [_this, 4, "", [""]] call BIS_fnc_param;
	_slider2 = [_this, 5, 0, [0, controlNull]] call BIS_fnc_param;
	_text2 = [_this, 6, 0, [0, controlNull]] call BIS_fnc_param;
	_modeVar = [_this, 7, "", [""]] call BIS_fnc_param;
	_percentVar = [_this, 8, "", [""]] call BIS_fnc_param;

	if (count _this < 8) then {
		_updateType = 2;
	} else {
		_modeVar = call compile _modeVar;
		switch (_modeVar) do {
			case 1: {
				_updateType = 3;
			};
			default {
				_updateType = 1;		
			};	
		};
	};


	_viewDistValue = _sliderPos min CHVD_maxView max 0;
	_objViewDistValue = if (_modeVar isEqualTo 1) then {_sliderPos  * (call compile _percentVar) min CHVD_maxObj} else {_sliderPos min CHVD_maxObj};  // Check if percentage sync mode is used, if so use a percentage coefficient


	switch (_updateType) do { // 1 - VIEW, 2 - OBJ, 3 - BOTH, 0 - BOTH AND TERRAIN
		case 1: {
			sliderSetPosition [_slider1, _viewDistValue];
			ctrlSetText [_text1, str round _viewDistValue];
			sliderSetRange [_slider2, 0, _viewDistValue];
				
			call compile format ["%1 = %2", _varType1, _viewDistValue];
			call compile format ["profileNamespace setVariable ['%1',%1]", _varType1];
			
			if ((call compile _varType2) > _viewDistValue) then {  // Update object VD slider and text so it doesn't stay at higher value than VD slider
				sliderSetPosition [_slider2, _objViewDistValue];
				ctrlSetText [_text2, str round _objViewDistValue];

				call compile format ["%1 = %2", _varType2, _objViewDistValue];
				call compile format ["profileNamespace setVariable ['%1',%1]", _varType2];
			};
			
			[_updateType] call CHVD_fnc_updateSettings;
		};
		case 2: {
			sliderSetPosition [_slider1, _objViewDistValue];
			ctrlSetText [_text1, str round _objViewDistValue];
				
			call compile format ["%1 = %2", _varType1, _objViewDistValue];
			call compile format ["profileNamespace setVariable ['%1',%1]", _varType1];
				
			[_updateType] call CHVD_fnc_updateSettings;
		};
		case 3: {		
			sliderSetPosition [_slider1, _viewDistValue];
			ctrlSetText [_text1, str round _viewDistValue];
			sliderSetRange [_slider2, 0, _viewDistValue];
				
			call compile format ["%1 = %2", _varType1, _viewDistValue];
			call compile format ["profileNamespace setVariable ['%1',%1]", _varType1];
			
			if ((call compile _varType2) > _viewDistValue) then {  // Update object VD slider and text so it doesn't stay at higher value than VD slider
				sliderSetPosition [_slider2, _objViewDistValue];
				ctrlSetText [_text2, str round _objViewDistValue];

				call compile format ["%1 = %2", _varType2, _objViewDistValue];
				call compile format ["profileNamespace setVariable ['%1',%1]", _varType2];
			};
			
			sliderSetPosition [_slider2, _objViewDistValue];
			ctrlSetText [_text2, str round _objViewDistValue];	
			
			call compile format ["%1 = %2", _varType2, _objViewDistValue];
			call compile format ["profileNamespace setVariable ['%1',%1]", _varType2];
			
			[_updateType] call CHVD_fnc_updateSettings;
		};	
	};
};
chvd_fnc_openDialog = {
	[] spawn {
	if (missionNamespace getVariable ["CHVD_loadingDialog",false]) exitWith {true};

	if (isNull (findDisplay 2900)) then {
		_dialog = createDialog "CHVD_dialog";
		if (!_dialog) exitWith {systemChat "CH View Distance: Error: can't open dialog."};
	};

	disableSerialization;
	CHVD_loadingDialog = true;

	{
		ctrlSetText _x;
	} forEach [[1006, str round CHVD_foot],[1007, str round CHVD_footObj],[1013, str round CHVD_car],[1014, str round CHVD_carObj],[1017, str round CHVD_air],[1018, str round CHVD_airObj],[1400, str CHVD_footTerrain],[1401, str CHVD_carTerrain],[1402, str CHVD_airTerrain]];

	{
		sliderSetRange [_x select 0, 0, _x select 2];
		sliderSetRange [_x select 3, 0, (_x select 5) min (_x select 1)];
		sliderSetSpeed [_x select 0, 500, 500];
		sliderSetSpeed [_x select 3, 500, 500];
		sliderSetPosition [_x select 0, _x select 1];
		sliderSetPosition [_x select 3, (_x select 4) min (_x select 1)];
	} forEach [[1900,CHVD_foot,CHVD_maxView,1901,CHVD_footObj,CHVD_maxObj],[1902,CHVD_car,CHVD_maxView,1903,CHVD_carObj,CHVD_maxObj],[1904,CHVD_air,CHVD_maxView,1905,CHVD_airObj,CHVD_maxObj]];

	{
		_ctrl = ((findDisplay 2900) displayCtrl (_x select 0));
		
		_textDisabled = if (isLocalized "STR_chvd_disabled") then {localize "STR_chvd_disabled"} else {"Disabled"};
		_ctrl lbAdd _textDisabled;
		
		_textDynamic = if (isLocalized "STR_chvd_dynamic") then {localize "STR_chvd_dynamic"} else {"Dynamic"};
		_ctrl lbAdd _textDynamic;
		
		_textFov = if (isLocalized "STR_chvd_fov") then {localize "STR_chvd_fov"} else {"FOV"};
		_ctrl lbAdd _textFov;
		
		_mode = call compile ("CHVD_" + (_x select 1) + "SyncMode");
		_ctrl lbSetCurSel _mode;
		//call compile format ["systemChat '%1 %2'",_ctrl, _x select 1];
		
		_handle = _ctrl ctrlSetEventHandler ["LBSelChanged", 
			format ["[_this select 1, '%1',%2,%3,%4] call CHVD_fnc_onLBSelChanged_syncmode", _x select 1, _x select 2, _x select 3, _x select 4]
		];
	} forEach [[1404,"foot",1410,1901,1007], [1406,"car",1409,1903,1014], [1408,"air",1411,1905,1018]];

	{
		_ctrl = _x select 0;
		_mode = call compile ("CHVD_" + (_x select 1) + "SyncMode");

		switch (_mode) do {
			case 1: {
				_percentage = call compile ("CHVD_" + (_x select 1) + "SyncPercentage");
				ctrlSetText [_ctrl, format ["%1",_percentage * 100] + "%"];
				ctrlEnable [_ctrl, true];
			};
			default {
				ctrlEnable [_ctrl, false];
			};
			
		};
		_ctrlDisplay = (findDisplay 2900) displayCtrl _ctrl;
		_handle = _ctrlDisplay ctrlSetEventHandler ["keyDown", 
			format ["[_this select 0, '%1',%2,%3] call CHVD_fnc_onEBinput_syncmode", _x select 1, _x select 2, _x select 3]
		];
	} forEach [[1410,"foot",1901,1007], [1409,"car",1903,1014], [1411,"air",1905,1018]];

	{
		_ctrl = ((findDisplay 2900) displayCtrl (_x select 0));
		if (CHVD_allowNoGrass) then {
			_textLow = if (isLocalized "STR_chvd_low") then {localize "STR_chvd_low"} else {"Low"};
			_ctrl lbAdd _textLow;
		};
		_textStandard = if (isLocalized "STR_chvd_standard") then {localize "STR_chvd_standard"} else {"Standard"};
		_ctrl lbAdd _textStandard;
		_textHigh = if (isLocalized "STR_chvd_high") then {localize "STR_chvd_high"} else {"High"};
		_ctrl lbAdd _textHigh;
		_textVeryHigh = if (isLocalized "STR_chvd_veryHigh") then {localize "STR_chvd_veryHigh"} else {"Very High"};
		_ctrl lbAdd _textVeryHigh;
		_textUltra = if (isLocalized "STR_chvd_ultra") then {localize "STR_chvd_ultra"} else {"Ultra"};
		_ctrl lbAdd _textUltra;
		
		_sel = [_x select 1] call CHVD_fnc_selTerrainQuality;
		if (CHVD_allowNoGrass) then {
			_ctrl lbSetCurSel _sel;
		} else {
			_ctrl lbSetCurSel (_sel - 1);
		};
	} forEach [[1500,CHVD_footTerrain],[1501,CHVD_carTerrain],[1502,CHVD_airTerrain]];

	{
		_ctrl = ((findDisplay 2900) displayCtrl (_x select 0));
		_handle = _ctrl ctrlSetEventHandler ["LBSelChanged", 
			format ["[_this select 1, '%1', %2] call CHVD_fnc_onLBSelChanged", _x select 1, _x select 2]
		];
	} forEach [[1500,"CHVD_footTerrain",1400],[1501,"CHVD_carTerrain",1401],[1502,"CHVD_airTerrain",1402]];

	if (CHVD_footSyncMode isEqualTo 1) then {
		ctrlEnable [1901,false];
		ctrlEnable [1007,false];
	} else {	
		ctrlEnable [1901,true];
		ctrlEnable [1007,true];
	};

	if (CHVD_carSyncMode isEqualTo 1) then {
		ctrlEnable [1903,false];
		ctrlEnable [1014,false];
	} else {	
		ctrlEnable [1903,true];
		ctrlEnable [1014,true];
	};

	if (CHVD_airSyncMode isEqualTo 1) then {
		ctrlEnable [1905,false];
		ctrlEnable [1018,false];
	} else {	
		ctrlEnable [1905,true];
		ctrlEnable [1018,true];
	};

	CHVD_loadingDialog = false;
	};
};
chvd_fnc_selTerrainQuality = {
	private ["_output"];
	_terrainGrid = _this select 0;
	_output = switch (true) do {
		case (_terrainGrid >= 49): {0};
		case (_terrainGrid >= 48.99): {1};
		case (_terrainGrid >= 25): {2};
		case (_terrainGrid >= 12.5): {3};
		case (_terrainGrid >= 3.125): {4};
		default {1};
	};
	_output
};
chvd_fnc_trueZoom = {
	// Thanks to Killzone_Kid :*
	// http://killzonekid.com/arma-scripting-tutorials-get-zoom/

	round (
		(
			[0.5,0.5] 
			distance2D  
			worldToScreen 
			positionCameraToWorld 
			[0,3,4]
		) * (
			getResolution 
			select 5
		) / 2 * 30
	) / 10
};
chvd_fnc_UAVstatus = {
	private ["_status"];
	_status = 0;

	switch (UAVControl (getConnectedUAV player) select 1) do {
		case (""): {
			_status = 0;
		};
		default {
			_status = 1;
		};
	};

	_status
};
chvd_fnc_updateSettings = {
	private ["_updateType"];
	_updateType = [_this, 0, 0, [0]] call BIS_fnc_param; // 1 - view, 2 - obj, 3 - both, 4 - FOV, 0 - both and terrain

	switch (_updateType) do {
		case 1: {
			switch (CHVD_vehType) do {
				case 0: {setViewDistance CHVD_foot};
				case 1: {setViewDistance CHVD_car};
				case 2: {setViewDistance CHVD_air};
			};
		};
		case 2: {
			switch (CHVD_vehType) do {
				case 0: {setObjectViewDistance CHVD_footObj};
				case 1: {setObjectViewDistance CHVD_carObj};
				case 2: {setObjectViewDistance CHVD_airObj};
			};
		};
		case 4: {
			switch (CHVD_vehType) do {
				case 0: {setObjectViewDistance ([CHVD_footObj] call CHVD_fnc_fovViewDistance)};
				case 1: {setObjectViewDistance ([CHVD_carObj] call CHVD_fnc_fovViewDistance)};
				case 2: {setObjectViewDistance ([CHVD_airObj] call CHVD_fnc_fovViewDistance)};
			};
		};
		default {
			switch (CHVD_vehType) do {
				case 0: {setViewDistance CHVD_foot; setObjectViewDistance CHVD_footObj};
				case 1: {setViewDistance CHVD_car; setObjectViewDistance CHVD_carObj};
				case 2: {setViewDistance CHVD_air; setObjectViewDistance CHVD_airObj};
			};
		};
	};

	if (_updateType isEqualTo 0) then {
		[] call CHVD_fnc_updateTerrain;
	};
};
chvd_fnc_updateTerrain = {
	switch (CHVD_vehType) do {
		case 0: {setTerrainGrid CHVD_footTerrain};
		case 1: {setTerrainGrid CHVD_carTerrain};
		case 2: {setTerrainGrid CHVD_airTerrain};
	};
};
chvd_fnc_updateVehType = {
	CHVD_inUAV = if ((call CHVD_fnc_UAVstatus) isEqualTo 0) then {false} else {true};

	if (CHVD_inUAV) then {
		switch (true) do {
			case (getConnectedUAV player isKindOf "LandVehicle" || getConnectedUAV player isKindOf "Ship"): {
				CHVD_vehType = 1;
			};
			case (getConnectedUAV player isKindOf "Man"): {
				CHVD_vehType = 0;
			};
			default {
				CHVD_vehType = 2;
			};
		};
	} else {
		switch (true) do {
			case (vehicle player isKindOf "LandVehicle" || vehicle player isKindOf "Ship"): {
				CHVD_vehType = 1;
			};
			case (vehicle player isKindOf "Air"): {
				CHVD_vehType = 2;
			};
			default {
				CHVD_vehType = 0;
			};
		};
	};
};
if (tsp_cba_core_chvd) then {[] spawn chvd_fnc_init};