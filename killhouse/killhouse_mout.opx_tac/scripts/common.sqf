//-- Spacial
	tsp_fnc_vector = {  //-- Rotates around a vector
		params ["_unit", "_vec", "_an"];
		_angle = (_vec#2)*70;  //-- Get up down angle
		_axis = [-cos (getDir _unit + 90), sin (getDir _unit + 90), (tan (_angle + 90))];  //-- Rotate up by 90 degrees and use "_angle" to match head pitch
		(vectorNormalized _axis) params ["_ux", "_uy", "_uz"];
		_rotationMatrix = [
			[cos _an + (_ux*_ux) * (1 - cos _an), _ux * _uy * (1 - cos _an) - _uz * sin _an, _ux * _uz * (1 - cos _an) + _uy * sin _an],
			[_uy * _ux * (1 - cos _an) + _uz * sin _an, cos _an + (_uy*_uy) * (1 - cos _an), _uy * _uz * (1 - cos _an) - _ux * sin _an],
			[_uz * _ux * (1 - cos _an) - _uy * sin _an, _uz * _uy * (1 - cos _an) + _ux * sin _an, cos _an + (_uz*_uz) * (1 - cos _an)]
		];
		([_vec] matrixMultiply _rotationMatrix)#0;
	};
	tsp_fnc_rotate = {  //-- Rotate that works with attached objects
		params ["_object", "_rotations", ["_dirX", 0], ["_dirY", 1], ["_dirZ", 0], ["_upX", 0], ["_upY", 0], ["_upZ", 1]];
		[] params [["_aroundX", _rotations#0], ["_aroundY", _rotations#1], ["_aroundZ", (360 - (_rotations#2)) - 360]];
		if (_aroundX != 0) then {_dirY = cos _aroundX; _dirZ = sin _aroundX; _upY = -sin _aroundX; _upZ = cos _aroundX};
		if (_aroundY != 0) then {_dirX = _dirZ * sin _aroundY; _dirZ = _dirZ * cos _aroundY; _upX = _upZ * sin _aroundY; _upZ = _upZ * cos _aroundY};
		if (_aroundZ != 0) then {
			[_dirX, _upX] params ["_dirXTemp", "_upXTemp"];
			_dirX = (_dirXTemp* cos _aroundZ) - (_dirY * sin _aroundZ);
			_dirY = (_dirY * cos _aroundZ) + (_dirXTemp * sin _aroundZ);
			_upX = (_upXTemp * cos _aroundZ) - (_upY * sin _aroundZ);
			_upY = (_upY * cos _aroundZ) + (_upXTemp * sin _aroundZ);
		};
		_object setVectorDirAndUp [[_dirX, _dirY, _dirZ],[_upX, _upY, _upZ]];
	};
	tsp_fnc_height = {  //-- Gets distance from ground
		params ["_unit"]; 
		_intersect = lineIntersectsSurfaces [getPosASL _unit vectorAdd [0,0,1], getPosASL _unit vectorAdd [0,0,-5], _unit, objNull, true, 1, "ROADWAY", "GEOM"];
		if (count _intersect > 0) exitWith {(_intersect#0#0) distance getPosASL _unit};   //-- If line intersects something below, return that
		getPosATL _unit#2  //-- else, just give height from ground
	};
	tsp_fnc_outsideness = {  //-- Determines how "outside" a position is with an "outsideness" score
		params ["_pos", "_ignore", ["_outsideness", 0]];
		for "_i" from 0 to 360 step 10 do {
			_ray = lineIntersectsSurfaces [_pos, _pos vectorAdd ([[-1,0.5,0], _i, 2] call BIS_fnc_rotateVector3D vectorMultiply 30), _ignore, objNull, true, 1];
			//drawLine3D [ASLtoATL _pos, (ASLtoATL _pos) vectorAdd ([[-1,0.5,0], _i, 2] call BIS_fnc_rotateVector3D vectorMultiply 30), [1,0,0,1]];
			if (_ray isEqualTo []) then {_outsideness = _outsideness + 30; continue};
			(_ray#0) params ["_intersectPos", "_normal", "_object"]; 
			_outsideness = _outsideness + (_pos distance _intersectPos);
		};
		_outsideness/10
	};
	tsp_fnc_obstruction = {  //-- ([player, eyePos player, [0,45,90], 2, getCameraViewDirection player] call tsp_fnc_obstruction) select {_x#0 isKindOf "CAManBase"};
		params ["_unit", "_start", "_angles", "_reach", "_vector", ["_obstructions", []]];
		{  //-- Raycast
			[_start, _start vectorAdd (([_unit, _vector, _x] call tsp_fnc_vector) vectorMultiply _reach)] params ["_start", "_end"];  
			//drawLine3D [ASLtoATL _start, ASLtoATL _end, [1,0,0,1]];
			{
				_x params ["_intersect", "_normal", "_object", "_parent", "_selections", "_bisurf"]; 
				if (count (_obstructions select {_x#0 == _object}) == 0) then {_obstructions pushBack [_object, _intersect, _selections]};
			} forEach (lineIntersectsSurfaces [_start, _end, _unit, objNull, true, -1, "FIRE", "FIRE", false]);
		} forEach _angles;
		_obstructions
	};

//-- Gestures
    //-- Note to self: don't try to improve this, working with ArmA's gesture system is a bad idea - this works well enough, dont touch
	tsp_fnc_gesture_looped = {getNumber (configFile >> "CfgGesturesMale" >> "States" >> _this >> "looped") == 1};
	tsp_fnc_gesture_duration = {abs (1/(getNumber (configFile >> "CfgGesturesMale" >> "States" >> _this >> "speed")+0.01))-0.1};  //-- 0.01 for zero divisor
	tsp_fnc_gesture_stop = {
		params ["_unit"]; _unit setVariable ["tsp_gestureStop", true]; 
		if (tsp_cba_compat) then {[_unit, gestureState _unit] spawn {sleep 0.2; if ((_this#1) in gestureState (_this#0)) then {(_this#0) playAction "tsp_common_stop"}}};
	};
	tsp_fnc_gesture_sanitize = {
		params ["_input"];
		if ("reload" in _input) exitWith {"reload"}; if ("switch" in _input || "amovpercmstpsraswrfldnon" in _input || "amovpercmstpsraswpstdnon" in _input) exitWith {"switch"};
		if ({_x in _input} count ["stop", "<none>", "aidl", "amov", "rcc", "disable_gesture", "passenger"] > 0) exitWith {""};
		_input
	};
	tsp_fnc_gesture_variant = {  //-- This function assumes input to be wnon for weapon, laut for level and perc for stance
		params ["_unit", "_gesture"];
		if ("laut" in _gesture) then {
			if ("lhig" in gestureState _unit) exitWith {_gesture = _gesture regexReplace ["laut", "lhig"]}; 
			if ("llow" in gestureState _unit) exitWith {_gesture = _gesture regexReplace ["laut", "llow"]};
			if (isClass (configFile >> "CfgGesturesMale" >> "States" >> _gesture regexReplace ["laut", "lnon"])) exitWith {_gesture = _gesture regexReplace ["laut", "lnon"]};
			_gesture = _gesture regexReplace ["laut", if ((getCameraViewDirection _unit)#2 > tsp_cba_angle) then {"lhig"} else {"llow"}]
		};		
		if (primaryWeapon _unit != "" && currentWeapon _unit == primaryWeapon _unit && isClass (configFile >> "CfgGesturesMale" >> "States" >> _gesture regexReplace ["wnon", "wrfl"])) then {_gesture = _gesture regexReplace ["wnon", "wrfl"]};
		if (secondaryWeapon _unit != "" && currentWeapon _unit == secondaryWeapon _unit && isClass (configFile >> "CfgGesturesMale" >> "States" >> _gesture regexReplace ["wnon", "wlnr"])) then {_gesture = _gesture regexReplace ["wnon", "wlnr"]};
		if (handgunWeapon _unit != "" && currentWeapon _unit == handgunWeapon _unit && isClass (configFile >> "CfgGesturesMale" >> "States" >> _gesture regexReplace ["wnon", "wpst"])) then {_gesture = _gesture regexReplace ["wnon", "wpst"]};
		if (stance _unit == "MIDDLE" && isClass (configFile >> "CfgGesturesMale" >> "States" >> _gesture regexReplace ["perc", "pknl"])) then {_gesture = _gesture regexReplace ["perc", "pknl"]};
		if (stance _unit == "PRONE" && isClass (configFile >> "CfgGesturesMale" >> "States" >> _gesture regexReplace ["perc", "ppne"])) then {_gesture = _gesture regexReplace ["perc", "ppne"]};
		_gesture
	};
	tsp_fnc_gesture_play = {  //-- unit,in,loop,out,interupt,instant,return,returnable,toggle,lower,code
		params ["_unit", "_in", "_loop", ["_out", "tsp_common_stop"], ["_interupt", false], ["_instant", false], ["_return", false], ["_returnable", false], ["_toggle", false], ["_lower", false], ["_code", {}], ["_timeStop", time + 999]]; 
		[[_unit, _in] call tsp_fnc_gesture_variant, [_unit, _loop] call tsp_fnc_gesture_variant, [_unit, _out] call tsp_fnc_gesture_variant, _unit getVariable ["tsp_gestureReturn", []]] params ["_in", "_loop", "_out", "_previous"]; 		
		
		if (gestureState _unit == _loop) exitWith {_unit setVariable ["tsp_gestureStop", _toggle]};  //-- Don't continue if gesture already on, toggle gesture if required
		if (!_interupt && [gestureState _unit] call tsp_fnc_gesture_sanitize != "") exitWith {};    //-- Do not interupt current gesture
		if (!_instant && [gestureState _unit] call tsp_fnc_gesture_sanitize != "") then {[_unit] call tsp_fnc_gesture_stop; waitUntil {sleep 0.2; [gestureState _unit] call tsp_fnc_gesture_sanitize == ""}};  //-- Wait for old to finish
		if (_lower && !weaponLowered _unit) then {_unit action ["WeaponOnBack", _unit]; sleep 0.2; if (!weaponLowered _unit) then {_lower = false}};  //-- Try to lower weapon, else; screw it
		if (_returnable) then {_unit setVariable ["tsp_gestureReturn", _this]};  //-- Returnable

		if (_in != "") then {_unit playActionNow _in; sleep (_in call tsp_fnc_gesture_duration)};  //-- Play in gesture
		if (_in != "" && gestureState _unit != _in) exitWith {};  //-- Interupted during _in gesture

		_unit playActionNow _loop; _this call _code; _unit setVariable ["tsp_gestureStop", false];  //-- Play loop gesture
		if !(_loop call tsp_fnc_gesture_looped) then {_timeStop = time + (_loop call tsp_fnc_gesture_duration)};  //-- Use this method as opposed to sleep as it allows for exiting animation early
		waitUntil {!alive _unit || _unit getVariable ["tsp_gestureStop", false] || gestureState _unit != _loop || _lower && !weaponLowered _unit || time > _timeStop};  //-- Wait to stop

		_return = _return && _previous isNotEqualTo _this && count _previous > 0;
      	if (gestureState _unit == _loop) then {  //-- Only play out if still doing loop
			if ("stop" in _out && getArray (configFile >> "CfgGesturesMale" >> "States" >> _loop >> "leftHandIKCurve")#0 == 0) then {_out = "tsp_common_stop_left"};
			if ("stop" in _out && getArray (configFile >> "CfgGesturesMale" >> "States" >> _loop >> "rightHandIKCurve")#0 == 0) then {_out = "tsp_common_stop_right"};
			if ("_out" in _out || ("stop" in _out && !_return)) then {_unit setVariable ["tsp_gestureReturn", []]; _unit playActionNow _out; sleep ((_out call tsp_fnc_gesture_duration))};
			if (_return) then {_previous spawn tsp_fnc_gesture_play};  //-- Return if theres something to return to
		};
	};
	tsp_fnc_gesture_item = {  //-- tsp_object attachto [player, [0.02,0.25,0], "leftHand", true]; [tsp_object, [-90,-90,0]] remoteExec ["tsp_fnc_rotate", 0];
        params ["_unit", ["_in", ""], ["_loop", ""], ["_object", ""], ["_pos", [-0.02,0,-0.03]], ["_rot", [50,190,-120]], ["_exit", {sleep 0.5}], ["_lower", false]];
        [_unit, _in, _loop, "tsp_common_stop", "tsp" in gestureState _unit || "ainv" in gestureState _unit, true, true, false, false, _lower] spawn tsp_fnc_gesture_play;
        _object = createSimpleObject [_object, [0,0,0]]; [vehicle _unit, _object] remoteExec ["disableCollisionWith", 0]; sleep 0.2; 
		if !(vehicle _unit isKindOf "Helicopter") then {_object attachto [_unit, _pos, "leftHand", true]}; [_object, _rot] remoteExec ["tsp_fnc_rotate", 0]; 
        tsp_object = _object; sleep 0.3; waitUntil _exit; deleteVehicle _object;
		if (gestureState _unit in [[_unit, _in] call tsp_fnc_gesture_variant, [_unit, _loop] call tsp_fnc_gesture_variant]) then {[_unit] call tsp_fnc_gesture_stop}; 
    };

//-- Damage
	tsp_fnc_hitpoint_get = {
		params ["_input"]; _input = toLower _input;  //-- Find ACE bodypart equivelant of memory point
		if ("head" in _input || "neck" in _input) exitWith {["hitHead", "head"]};
		if ("arm" in _input) exitWith {["hitHands", if ("right" in _input) then {"rightarm"} else {"leftarm"}]};
		if ("leg" in _input) exitWith {["hitLegs", if ("right" in _input) then {"rightarm"} else {"leftarm"}]};
		["hitBody", "body"]
	};
	tsp_fnc_hitpoint_damage = {
		params ["_unit", ["_bodypart", "body"], ["_damage", 0], ["_damageType", "stab"], ["_knockout", false], ["_effects", true]];
		if (!isDamageAllowed _unit) exitWith {}; ([_bodypart] call tsp_fnc_hitpoint_get) params ["_hitpoint", "_bodypart"];
		if (isPlayer _unit && _effects) then {[300*_damage] call BIS_fnc_bloodEffect; [] call BIS_fnc_indicateBleeding; [5, 0.5, 5] spawn tsp_fnc_shake;};  //-- Show hit effect on victim
		if (isNil "ace_medical_fnc_setUnconscious") exitWith {_unit setHitPointDamage [_hitPoint, (_unit getHitPointDamage _hitPoint) + _damage]};         //-- Vanilla damage   
		["ace_medical_woundReceived", [_unit, [[_damage, _bodypart, _damage]], objNull, _damageType]] call CBA_fnc_localEvent;                            //-- ACE damage    
		if (_knockout) then {[_unit, true, 10, true] call ace_medical_fnc_setUnconscious};                                                               //-- ACE unconscious
	};
	tsp_fnc_hitpoint_armor = {
		params ["_item"];
		_head = getNumber (configFile >> "CfgWeapons" >> _item >> "itemInfo" >> "HitpointsProtectionInfo" >> "Head" >> "armor"); if (_head > 0) exitWith {_head};
		_chest = getNumber (configFile >> "CfgWeapons" >> _item >> "itemInfo" >> "HitpointsProtectionInfo" >> "Chest" >> "armor"); if (_chest > 0) exitWith {_chest};	
		getNumber (configFile >> "CfgWeapons" >> _item >> "itemInfo" >> "armor");
	};

//-- Misc
	tsp_fnc_throw = {
		params ["_unit", "_weapon", ["_orient", true]]; if (_weapon == "") exitWith {};
		_dir = vectorNormalized ((_unit weaponDirection _weapon) vectorCrossProduct [0, 0, 1]);
		_up = _dir vectorCrossProduct (_unit weaponDirection _weapon);
		_pos = _unit modelToWorldWorld (_unit selectionPosition "RightHand") vectorAdd (_dir vectorMultiply 0.7);
		_holder = createVehicle ["tsp_WeaponHolderSimulated", [0, 0, 0], [], 0, "CAN_COLLIDE"];
		_holder addWeaponWithAttachmentsCargoGlobal [weaponsItems _unit select {_x select 0 == _weapon} select 0, 1];
		if (_orient) then {_holder setPosWorld _pos; _holder setVectorDirAndUp [_up, _dir]};
		_unit removeWeapon _weapon; _holder
	};
	tsp_fnc_decal = {
		params ["_pos", ["_decals", ["BloodPool_01_Medium_New_F","BloodSplatter_01_Small_New_F","BloodSplatter_01_Medium_New_F","BloodSpray_01_New_F","BloodSplatter_01_Large_New_F"]], ["_radius", 2]];
		if (count ((ASLtoATL _pos nearObjects _radius) select {_x getVariable ["tsp_decal", false]}) > 0) exitWith {}; 
		_decal = (selectRandom _decals) createVehicle [0,0,0]; _decal setDir (random 360); _decal setPosASL (_pos vectorAdd [0,0,3]); 
		_decal setVehiclePosition [_decal, [], 0, "CAN_COLLIDE"]; _decal setVariable ["tsp_decal", true]; 
		_decal
	};
	tsp_fnc_undrop = {  //-- Remove item from container if dropped
		params ["_unit", "_container", "_item", "_blacklist", ["_condition", {false}], ["_replace", true]];
		if !(_item in _blacklist || _item call _condition) exitWith {};
		if (_replace) then {_unit addPrimaryWeaponItem _item}; 
		[_container, _item] call cba_fnc_removeItemCargo; _unit removeItems _item;
	};
	tsp_fnc_shake = {params ["_power", "_duration", "_frequency"]; resetCamShake; tsp_shake = true; addCamShake _this; sleep (_duration+0.1); tsp_shake = nil};
	tsp_fnc_notify = {
		params ["_unit", "_text", ["_distance", tsp_cba_hint_distance]];
		_units = allPlayers select {[side _x, side _unit] call BIS_fnc_sideIsFriendly && _x distance2D _unit < tsp_cba_hint_distance && count lineIntersectsSurfaces [eyePos _x, eyePos _unit, _x, _unit, true, -1] == 0};
		{[name _unit, (_text regexReplace ["_x", name _x]) regexReplace ["_unit", name _unit]] remoteExec ["tsp_fnc_hint", _x]} forEach _units;
	};
	tsp_fnc_hint = {
		params ["_name", "_text", ["_style", if (isNil "tsp_cba_hint") then {if (isNil "ace_common_fnc_displayTextStructured") then {"Hint"} else {"ACE"}} else {tsp_cba_hint}]]; 
		if (_style == "Subtitle") exitWith {[_name, _text] spawn BIS_fnc_showSubtitle};
		if (_style == "SystemChat") exitWith {systemChat ((if (_name != "") then {_name + ": "} else {""}) + _text)};
		if (_style == "Hint") exitWith {hint parseText ((if (_name != "") then {"<t size='1.2'>" + _name + ":</t><br/>"} else {""}) + _text)};
		if (_style == "ACE") exitWith {[(if (_name != "") then {_name + ": "} else {""}) + _text] call ace_common_fnc_displayTextStructured};
	};
	tsp_fnc_visionModes = {  //-- Gets vision modes from current optic/weapon with integrated optic
		params ["_unit", ["_return", false]];
		_visionModesClass = ("true" configClasses (configFile >> "CfgWeapons" >> (primaryWeaponItems player)#2 >> "ItemInfo" >> "OpticsModes"))#0;
		//if (isClass (configFile >> "CfgWeapons" >> (primaryWeaponItems _unit)#2 >> "ItemInfo" >> "OpticsModes")) exitWith {true};
		if (!isNil "_visionModesClass") then {if (count (getArray (_visionModesClass >> "visionMode")) > 1) then {_return = true}};
		if (isClass (configFile >> "CfgWeapons" >> currentWeapon _unit >> "OpticsModes")) then {_return = true};
		if (isArray (configFile >> "CfgWeapons" >> currentWeapon _unit >> "VisionMode")) then {_return = true};
		_return
	};
	tsp_fnc_length = { 
		params ["_unit", ["_suppressor", 0.3]]; 
		_barrel = getNumber (configFile >> "CfgWeapons" >> currentWeapon _unit >> "ACE_barrelLength"); 
		_inertia = getNumber (configFile >> "CfgWeapons" >> currentWeapon _unit >> "inertia"); 
		_suppressed = getNumber (configFile >> "CfgWeapons" >> (_unit weaponAccessories currentWeapon _unit)#0 >> "ItemInfo" >> "soundTypeIndex"); 
		(if (_barrel > 0) then {_barrel/400} else {_inertia*1.7}) + (_suppressed*_suppressor); 
	}; 

//-- Settings
	tsp_fnc_setting = {  //-- _variable, _type, _name, description, _category, _setting, _script, _global
		params ["_variable", "_type", "_name", "_description", "_category", "_setting", ["_script", {}], ["_global", true]];
		[getMissionConfigValue [_variable, -1], missionNameSpace getVariable [_variable, -1]] params ["_mission", "_current"];
		_script = compile ("if (isNil '"+_variable+"_flag') exitWith {"+_variable+"_flag = 0}; [] call " + str _script);  //-- So that _script only runs once
		if (!isNil "CBA_fnc_addSetting") then {[_variable, _type, [_name, _description], _category, _setting, _global, _script] call CBA_fnc_addSetting};  //-- Initialize setting - don't run script
		if (isServer && _mission isNotEqualTo -1) then {missionNamespace setVariable [_variable, if (_mission in ["true", "false"]) then {call compile _mission} else {_mission}, true]};  //-- If mission.hpp has the variable
		if (isServer && _current isNotEqualTo -1) then {missionNamespace setVariable [_variable, _current, true]};  //-- If variable already exists
		if (isServer && !isNil "CBA_settings_fnc_set") then {[_variable, call compile _variable, 1, "server"] call CBA_settings_fnc_set};
	};
	tsp_fnc_keybind = {
		params ["_variable", "_addon", "_title", "_key", ["_shift", false], ["_ctrl", false], ["_alt", false], ["_codeDown", {}], ["_codeUp", {}]];
		if (!isNil "CBA_fnc_addKeybind") exitWith {[_addon, _variable, _title, _codeDown, _codeUp, [_key, [_shift,_ctrl,_alt]]] call CBA_fnc_addKeybind};
		if (isNil "tsp_controls") then {tsp_controls = []; waitUntil {!(isNull (findDisplay 46))}};
		if (isNil "tsp_controls") then {(findDisplay 46) displayAddEventHandler ["KeyDown", {(_this+[true]) call tsp_fnc_keybind_event}]};
		if (isNil "tsp_controls") then {(findDisplay 46) displayAddEventHandler ["keyUp", {(_this+[false]) call tsp_fnc_keybind_event}]};	
		tsp_controls pushBack _this;
	};
	tsp_fnc_keybind_event = {
		params ["_display", "_keyEH", "_shiftEH", "_ctrlEH", "_altEH", "_down"];
		{
			_x params ["_variable", "_name", "_key", ["_shift", false], ["_ctrl", false], ["_alt", false], ["_codeDown", {}], ["_codeUp", {}]];
			if (_key != _keyEH) then {continue};
			if (_shift && !_shiftEH) then {continue};
			if (_ctrl && !_ctrlEH) then {continue};
			if (_alt && !_altEH) then {continue};
			if (_down) then {call _codeDown} else {call _codeUp};
		} forEach tsp_controls;
	};
	tsp_fnc_scroll = {  //-- Making UI events stackable ["systemChat 'AH';"] spawn tsp_fnc_scroll;
		params [["_code", ""], ["_show", true], ["_type", "Action"], ["_first", isNil "tsp_scroll"], ["_poll", 10], ["_hud", shownHUD]];
		{inGameUISetEventHandler [_x, str !_show]} forEach ["PrevAction", "NextAction"]; _hud set [7, _show]; showHUD _hud;  //-- Hide scroll menu
		tsp_scroll = (missionNameSpace getVariable ["tsp_scroll", ""]) + _code;  //-- Add new code onto variable with each call
		if (_first) then {while {sleep _poll; true} do {inGameUISetEventHandler ["Action", "_returnVar = false;" + tsp_scroll + "_returnVar"]}};  //-- Continually add handler
	};

//-- Legussy
	tsp_fnc_weaponGesture = {  //-- Custom hold gesute for weapons
		params ["_unit", "_weapons", "_restAnim", "_cba"];
		_cba params ["_unit", "_new", "_old"];	
		if (_new in _weapons) then {
			waitUntil {_unit getVariable ["tsp_gestureState", ""] == ""};
			while {alive _unit && currentWeapon _unit == _new} do {
				if (_unit getVariable ["tsp_gestureState", ""] == "") then {[_unit, "", 0, _restAnim, "tsp_common_stop"] spawn tsp_fnc_gesture_play};
				sleep 0.2;
			};
		};
	};
	tsp_fnc_lookAt = {
		params ["_unit", "_targetDir", ["_duration", 1], ["_step", 4]];
		[_targetDir - getDir _unit, (360 - _targetDir) + getDir _unit] params ["_clockwise", "_counterClockwise"];
		_amountToRotate = if (_clockwise > _counterClockwise) then {_counterClockwise} else {_clockwise};
		_step = if (_clockwise > _counterClockwise) then {-_step} else {_step};	
		_unit disableAI "ANIM";
		for "_i" from 1 to ((abs _amountToRotate)/abs _step) do {_unit setDir ((getDir _unit) + _step); sleep (_duration/((abs _amountToRotate)/abs _step))};
		_unit enableAI "ANIM"; 
	}; 

["tsp_cba_compat", "CHECKBOX", "Gesture Compatibility Mode", "Makes gesture system compatible with other gesture mods.", "TSP Core", false] call tsp_fnc_setting;
["tsp_cba_angle", "SLIDER", "Gesture Angle", "Used to determine high/low ready.", "TSP Core", [-1, 1, -0.1], {}, false] call tsp_fnc_setting;
["tsp_cba_hint", "LIST", "Hint Style", "Type of hint to use.", "TSP Core", [["None","Subtitle","SystemChat","Hint","ACE"], ["None","Subtitle","SystemChat","Hint","ACE"], 0], {}, false] call tsp_fnc_setting;
["tsp_cba_hint_distance", "SLIDER", "Hint Distance", "How close you have to be to an see hint.", "TSP Core", [0, 50, 20]] call tsp_fnc_setting;