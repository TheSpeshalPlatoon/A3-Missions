tsp_fnc_butter_gui = {
	_butter_gui_display = uiNameSpace setVariable ["butter_gui_display", (findDisplay 46) createDisplay "RscDisplayEmpty"];
	_butter_gui_keyDown = uiNameSpace getVariable "butter_gui_display" displayAddEventHandler ["KeyDown", {if ((_this#1) != 15) exitWith {}; uiNameSpace getVariable "butter_gui_display" closeDisplay 1}];

	_butter_gui_search = uiNameSpace getVariable "butter_gui_display" ctrlCreate ["RscEdit", 6969];
	_butter_gui_search ctrlSetPosition [(safezoneX + safeZoneW - 0.5 * 3 / 4), safezoneY, 0.4, 0.045];
	_butter_gui_search ctrlSetBackgroundColor [0,0,0,0.7];
	_butter_gui_search ctrlCommit 0;

	_butter_gui_units = uiNameSpace getVariable "butter_gui_display" ctrlCreate ["tsp_treeview", -1];
	_butter_gui_units ctrlSetPosition [(safezoneX + safeZoneW - 0.5 * 3 / 4), safezoneY + 0.045, 0.4, 1.5];
	_butter_gui_units ctrlSetBackgroundColor [0,0,0,0.7];
	_butter_gui_units ctrlCommit 0;

	{  //-- For all sides
		_sideSave = _x;
		_side = _butter_gui_units tvAdd [[], _sideSave call BIS_fnc_sideNameUnlocalized];
		_butter_gui_units tvSetColor [[_side], [_sideSave, false] call BIS_fnc_sideColor];
		{  //-- For all groups of side
			_group = _butter_gui_units tvAdd [[_side], groupId _x];
			{
				_unit = _butter_gui_units tvAdd [[_side, _group], name _x];
				_butter_gui_units tvSetData [[_side, _group, _unit], [_x] call BIS_fnc_objectVar];
			} forEach units _x;  //-- For all units in group
		} forEach (allGroups select {side _x isEqualTo _sideSave && count (units _x select {isPlayer _x}) > 0});
	} forEach [west, east, resistance, civilian];

	tvExpandAll _butter_gui_units;
	_butter_gui_units ctrlAddEventHandler ["TreeSelChanged", {params ["_control", "_selectionPath"]; butter_tripod attachTo [call compile (_control tvData _selectionPath), [0, 0, 1.8]]; detach butter_tripod}];
};

tsp_fnc_butter_markers = {
	params [["_terminate", false], ["_distance", 5000]]; 
	if (_terminate || !isNil "butter_markers_draw") exitWith {removeMissionEventHandler ["Draw3D", missionNameSpace getVariable ["butter_markers_draw", 0]]; butter_markers_draw = nil};  //-- Toggle
	cameraEffectEnableHUD true;	butter_markers_distance = _distance;
	butter_markers_draw = addMissionEventHandler ["Draw3D", {
		{
			_dist = (player distance (getMarkerPos _x)) / butter_markers_distance;
			drawIcon3D [
				getText (configfile >> "CfgMarkers" >> getMarkerType _x >> "icon"), 
				(configfile >> "CfgMarkerColors" >> markerColor _x >> "color") call BIS_fnc_colorConfigToRGBA,
				[(getMarkerPos _x) select 0, (getMarkerPos _x) select 1, 1],  //-- Pos
				1.4 - _dist, 1.4 - _dist,  //-- Size
				0, markerText _x, 0, 0.06 - _dist/20, 'PuristaBold'
			];
		} forEach allMapMarkers;
	}];
};

tsp_fnc_butter_names = {
	params [["_terminate", false], ["_distance", 5000]]; 
	if (_terminate || !isNil "butter_names_draw") exitWith {removeMissionEventHandler ["Draw3D", missionNameSpace getVariable ["butter_names_draw", 0]]; butter_names_draw = nil};  //-- Toggle
	cameraEffectEnableHUD true;	butter_names_distance = _distance;
	butter_names_draw = addMissionEventHandler ["Draw3D", {
		{
			_dist = (player distance _x) / butter_names_distance;
			drawIcon3D [
				"A3\ui_f\data\map\markers\military\triangle_CA.paa",
				[side _x, false] call BIS_fnc_sideColor,
				[(visiblePosition _x)#0, (visiblePosition _x)#1, ((visiblePosition _x)#2) + ((_x modelToWorld (_x selectionPosition 'head'))#2) + 0.5],
				0.75 - _dist, 0.75 - _dist,  //-- Size
				180,
				if (_dist < 0.1) then {name _x} else {""},
				0,
				0.03,
				'PuristaBold'
			];
		} forEach (allPlayers select {!(isObjectHidden _x)});
	}];
};

tsp_fnc_butter = {
	params [
		["_position", getPos player], ["_speed_default", 0.7], ["_speed_slow", 0.4], ["_speed_fast", 3], ["_sensitivity", 1],
		["_ctrlW", 17], ["_ctrlA", 30], ["_ctrlS", 31], ["_ctrlD", 32], ["_ctrlQ", 16], ["_ctrlZ", 44],
		["_ctrlALT", 56], ["_ctrlCTRL", 29], ["_ctrlSHIFT", 42], ["_ctrlBACKSPACE", 14], ["_ctrlCAPS", 58], ["_ctrlTAB", 15]
	];
	{missionNameSpace setVariable ["butter"+_x, call compile _x]} forEach ["_position","_speed_default","_speed_slow","_speed_fast","_sensitivity","_ctrlW","_ctrlA","_ctrlS","_ctrlD","_ctrlQ","_ctrlZ","_ctrlALT","_ctrlCTRL","_ctrlSHIFT","_ctrlBACKSPACE","_ctrlCAPS","_ctrlTAB"];

	if !(isNil "butter_camera") exitWith {  //-- Toggle
		if !(isNil "acre_api_fnc_setSpectator") then {[false] call acre_api_fnc_setSpectator};
		(findDisplay 46) displayRemoveEventHandler ["KeyDown", butter_keyDown]; (findDisplay 46) displayRemoveEventHandler ["KeyUp", butter_keyUp];
		(findDisplay 46) displayRemoveEventHandler ["MouseZChanged", butter_fovZ]; (findDisplay 46) displayRemoveEventHandler ["MouseZChanged", butter_speedZ];
		(findDisplay 46) displayRemoveEventHandler ["MouseMoving", butter_mouseMove];
		butter_camera cameraEffect ["TERMINATE", "BACK"]; camDestroy butter_camera; butter_camera = nil;
		[true] call tsp_fnc_butter_markers; [true] call tsp_fnc_butter_names;
	};
	
	if !(isNil "BIS_EGSpectatorCamera_camera") then {butter_position = getPos BIS_EGSpectatorCamera_camera; [false] call tsp_fnc_spectate; sleep 0.1};
	if !(isNil "acre_api_fnc_setSpectator") then {[true] call acre_api_fnc_setSpectator};

	////-- CAMERA
		butter_tripod = "camera" camCreate butter_position;  //-- Using a "tripod" so that pitch doesnt change movement direction, tripod gets moved around, camera gets rotated
		butter_camera = "camera" camCreate butter_position;
		butter_camera cameraEffect ["INTERNAL", "BACK"]; 
		showCinemaBorder false;

	////-- FOV
		butter_fov_actual = 0.75;  butter_fov_chaser = butter_fov_actual;
		butter_fovZ = (findDisplay 46) displayAddEventHandler ["MouseZChanged", {if !(isNil "butter_speed_alt") exitWith {}; butter_fov_actual = (butter_fov_actual - (_this#1/60)) min 8.5 max 0.01; false}];

	////-- MOUSE
		butter_yaw_actual   = 0;  butter_yaw_chaser   = butter_yaw_actual;
		butter_pitch_actual = 0;  butter_pitch_chaser = butter_pitch_actual;
		butter_mouseMove = (findDisplay 46) displayAddEventHandler ["MouseMoving", {
			butter_yaw_actual = butter_yaw_actual + (((_this#1)*butter_fov_actual)*butter_sensitivity); 
			butter_pitch_actual = (butter_pitch_actual + -( ((_this#2)*butter_fov_actual))*butter_sensitivity) min 90 max -90
		}];

	////-- SPEED
		butter_speed_modifier = butter_speed_default; butter_speed_actual = butter_speed_default; butter_speed_chaser = butter_speed_default;
		butter_speedZ = (findDisplay 46) displayAddEventHandler ["MouseZChanged", {if (isNil "butter_speed_alt") exitWith {}; butter_speed_actual = (butter_speed_actual + (_this#1/10)) min 25 max 0.1; false}];

	////-- KEYS
		butter_leftright_actual = 0;  butter_leftright_chaser = 0;
		butter_frontback_actual = 0;  butter_frontback_chaser = 0;
		butter_updown_actual    = 0;  butter_updown_chaser    = 0;
		butter_keyDown = (findDisplay 46) displayAddEventHandler ["KeyDown", {
			params ["", "_key"];
			if (_key == butter_ctrlW) exitWith {butter_frontback_actual = 1};
			if (_key == butter_ctrlS) exitWith {butter_frontback_actual = -1};
			if (_key == butter_ctrlD) exitWith {butter_leftright_actual = 1};
			if (_key == butter_ctrlA) exitWith {butter_leftright_actual = -1};
			if (_key == butter_ctrlQ) exitWith {butter_updown_actual = 1};
			if (_key == butter_ctrlZ) exitWith {butter_updown_actual = -1};
			if (_key == butter_ctrlALT) exitWith {butter_speed_alt = true};
			if (_key == butter_ctrlCTRL) exitWith {butter_speed_modifier = butter_speed_slow};
			if (_key == butter_ctrlSHIFT) exitWith {butter_speed_modifier = butter_speed_fast};
			if (_key == butter_ctrlBACKSPACE) exitWith {[] call tsp_fnc_butter_markers};
			if (_key == butter_ctrlCAPS) exitWith {[] call tsp_fnc_butter_names};
			if (_key == butter_ctrlTAB) exitWith {[] call tsp_fnc_butter_gui};
		}];
		butter_keyUp = (findDisplay 46) displayAddEventHandler ["keyUp", {
			params ["", "_key"];
			if (_key == butter_ctrlW) exitWith {butter_frontback_actual = 0};
			if (_key == butter_ctrlS) exitWith {butter_frontback_actual = 0};
			if (_key == butter_ctrlD) exitWith {butter_leftright_actual = 0};
			if (_key == butter_ctrlA) exitWith {butter_leftright_actual = 0};
			if (_key == butter_ctrlQ) exitWith {butter_updown_actual = 0};
			if (_key == butter_ctrlZ) exitWith {butter_updown_actual = 0};
			if (_key == butter_ctrlALT) exitWith {butter_speed_alt = nil};
			if (_key == butter_ctrlCTRL) exitWith {butter_speed_modifier = butter_speed_default};
			if (_key == butter_ctrlSHIFT) exitWith {butter_speed_modifier = butter_speed_default};
		}];

	while {sleep (1 / (diag_fps * 20)); !isNil "butter_camera"} do {
		//-- FOV
			butter_fov_chaser = butter_fov_chaser + ((butter_fov_actual - butter_fov_chaser)/25); 
			butter_camera camPrepareFov butter_fov_chaser; 
			butter_camera camCommit 0.25;	

		//-- MOUSE
			butter_yaw_chaser = butter_yaw_chaser + ((butter_yaw_actual - butter_yaw_chaser)/25);  //-- Create "chaser" position that trails behind where cursor is (Makes the movement all lethargic and stuff) (Good example @ https://p5js.org/examples/input-easing.html)	
			butter_pitch_chaser = butter_pitch_chaser + ((butter_pitch_actual - butter_pitch_chaser)/25);

			{_x setDir (butter_yaw_chaser)} forEach [butter_tripod, butter_camera];
			[butter_camera, butter_pitch_chaser, 0] call bis_fnc_setPitchBank;  //-- Only on camera, not tripod

		//-- KEYS
			//-- Create "chaser" camera position that trails behind where the camera should actually be if raw inputs were used (Makes the movement all lethargic and stuff)
			butter_leftright_chaser = butter_leftright_chaser + ((butter_leftright_actual - butter_leftright_chaser)/25);
			butter_frontback_chaser = butter_frontback_chaser + ((butter_frontback_actual - butter_frontback_chaser)/25);
			butter_updown_chaser    = butter_updown_chaser    + ((butter_updown_actual - butter_updown_chaser)/25);
			butter_speed_chaser     = butter_speed_chaser     + (((butter_speed_actual * butter_speed_modifier) - butter_speed_chaser)/25);  //-- SPEED

			//-- Normalize movement vector so now overflow. So that like when you move diagonally, you don't move faster that you should be able to or whatever, u know?
			butter_magnitude = vectorMagnitude [butter_leftright_chaser,butter_frontback_chaser,butter_updown_chaser];
			if (butter_magnitude > 1) then {
				butter_leftright_chaser = butter_leftright_chaser/butter_magnitude;
				butter_frontback_chaser = butter_frontback_chaser/butter_magnitude;
				butter_updown_chaser = butter_updown_chaser/butter_magnitude;
			};

			butter_tripod camSetRelPos (butter_tripod modelToWorldWorld [
				butter_leftright_chaser * butter_speed_chaser, 
				butter_frontback_chaser * butter_speed_chaser, 
				butter_updown_chaser * butter_speed_chaser
			]);
			butter_tripod camCommit 0.15;
			butter_camera camSetPos (getPos butter_tripod);
			butter_camera camCommit 0.15;
	};
};

tsp_fnc_capture = {  // [player, 60] spawn tsp_fnc_capture; // player getVariable "data";
    params ["_unit", "_timeStop", ["_precision", 0.1]]; _timeStop = time + _timeStop; systemChat "RECORDING STARTED";
    _unit setVariable ["timeStart", time]; 
    _unit setVariable ["_move", []]; 
    _unit setVariable ["_target", []];
    _unit setVariable ["_anim",  [[time - (_unit getVariable "timeStart"), animationState _unit]]]; 
    _unit setVariable ["_gesture", [[time - (_unit getVariable "timeStart"), gestureState _unit]]]; 
    _unit setVariable ["_fire", []];
    _unit setVariable ["_weap", [[time - (_unit getVariable "timeStart"), (weaponState _unit)#0, (weaponState _unit)#1, (weaponState _unit)#2]]];
	_loadout = getUnitLoadout _unit;
    _anim = _unit addEventHandler ["AnimStateChanged", {
        params ["_unit", "_anim"]; 
        _anim = [time - (_unit getVariable "timeStart"), _anim];
        _unit setVariable ["_anim", (_unit getVariable "_anim") + [_anim]];
    }];
    _gesture = _unit addEventHandler ["GestureChanged", {
        params ["_unit", "_gesture"];
        _gesture = [time - (_unit getVariable "timeStart"), _gesture];
        _unit setVariable ["_gesture", (_unit getVariable "_gesture") + [_gesture]];
    }];
    _fired = _unit addEventHandler ["Fired", {
        params ["_unit", "_weapon", "_muzzle", "_mode", "_ammo", "_magazine", "_projectile", "_gunner"];
        _fire = [time - (_unit getVariable "timeStart"), _muzzle, (getArray (configFile >> "CfgWeapons" >> currentWeapon _unit >> "modes"))#0];
        _unit setVariable ["_fire", (_unit getVariable "_fire") + [_fire]];
    }];
    _weapon = currentWeapon _unit; recordingEnd = false;
    while {uiSleep _precision; alive _unit && time < _timeStop || recordingEnd} do {
        _move = [time - (_unit getVariable "timeStart"), getPosASL _unit, vectorDir _unit, vectorUp _unit, velocity _unit];
        _unit setVariable ["_move", (_unit getVariable "_move") + [_move]];
        _weap = [time - (_unit getVariable "timeStart"), (weaponState _unit)#0, (weaponState _unit)#1, (weaponState _unit)#2];
		[eyePos _unit, (eyePos _unit) vectorAdd (getCameraViewDirection _unit vectorMultiply 100)] params ["_start", "_end"];
		_target = [time - (_unit getVariable "timeStart"), lineIntersectsSurfaces [_start, _end, _unit, objNull, true, -1, "FIRE", "FIRE", false]];
		_unit setVariable ["_target", (_unit getVariable "_target") + [_target]];
    };
    _unit setVariable ["data", [_unit getVariable "_move", [], _unit getVariable "_anim", _unit getVariable "_gesture", _unit getVariable "_fire", _unit getVariable "_weap", _loadout]];
    _unit removeEventHandler ["AnimStateChanged", _anim]; _unit removeEventHandler ["GestureChanged", _gesture]; _unit removeEventHandler ["Fired", _fired];
    systemChat "RECORDING DONE";
};

tsp_fnc_capture_play = {
    params ["_unit", "_data", ["_precision", 0.15]]; _data params ["_move", "_target", "_anim", "_gesture", "_fire", "_weap", "_loadout"]; _timeStart = time;  //-- Precision lower than .2 results in missing shots
    _unit disableAI "MOVE"; _unit disableAI "ANIM"; _unit setUnitLoadout _loadout;
    [_unit, _move] spawn BIS_fnc_unitPlay;
	//_enemy = "Sign_Arrow_Blue_F" createVehicle position _unit;
	_enemy = (createGroup west) createUnit ["CBA_O_InvisibleTarget", getPos _unit, [], 0, "NONE"]; _unit doTarget _enemy;  //CBA_O_InvisibleTarget
    while {uiSleep _precision; alive _unit} do {
        if ((time - _timeStart) > _target#0#0) then {_enemy setPosASL (_target#0#1#0#0); _target deleteAt 0};  //_enemy setPosASL _target#0#1#0; 
        if ((time - _timeStart) > _anim#0#0) then {_unit playMoveNow _anim#0#1; _anim deleteAt 0};
        if ((time - _timeStart) > _gesture#0#0) then {_unit playAction _gesture#0#1; _gesture deleteAt 0};
        if ((time - _timeStart) > _weap#0#0) then {_unit selectWeapon [_weap#0#1, _weap#0#2, _weap#0#3]; _weap deleteAt 0};
        if ((time - _timeStart) > _fire#0#0) then { _unit setvehicleammo 1; _unit forceWeaponFire [_fire#0#2, _fire#0#2]; _fire deleteAt 0}; //_fire#0#2
    };
	deleteVehicle _enemy;
};

if (true) exitWith {};  //-- Notes below
[] spawn {
	_time = 7; _allData = [];
	{[_x, _time] spawn tsp_fnc_capture} forEach allPlayers;	sleep (_time+1);
	{_allData pushBack [typeOf _x, face _x, _x getVariable "data"]} forEach allPlayers;
	{
		_x params ["_type", "_face", "_data"];
		_replicant = (createGroup west) createUnit [_type, [0,0,0], [], 0, "NONE"]; _replicant setFace _face;
		[_replicant, _data] spawn tsp_fnc_capture_play; [_replicant, _time] spawn {sleep ((_this#1)+2); deleteVehicle (_this#0)};
	} forEach _allData;
};