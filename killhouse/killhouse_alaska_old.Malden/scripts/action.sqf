tsp_fnc_action_hold = {
	params ["_object", "_title", "_icon", "_code", ["_condition", "true"], ["_once", false], ["_duration", 0.2], ["_args", []], ["_priority", 10]];
	[_object, _title, _icon, _icon, _condition + " && _this distance _target < 6", _condition, {}, {}, _code, {}, _args, _duration, _priority, _once, false] call BIS_fnc_holdActionAdd;
};

tsp_fnc_action_arsenal = {
	params ["_unit", ["_data", tsp_arsenal]];
	{[_unit, _data, false, false] call _x} forEach [BIS_fnc_addVirtualWeaponCargo, BIS_fnc_addVirtualMagazineCargo, BIS_fnc_addVirtualItemCargo, BIS_fnc_addVirtualBackpackCargo];	
	[missionnamespace, "arsenalOpened", {params ["_display"]; uiNameSpace setVariable ["BIS_fnc_arsenal_display", _display]}] call BIS_fnc_addScriptedEventHandler;
	["Open", [false, _unit]] call BIS_fnc_arsenal; waitUntil {uiNameSpace getVariable ["BIS_fnc_arsenal_display", displayNull] isNotEqualTo displayNull};
	{(uiNameSpace getVariable "BIS_fnc_arsenal_display" displayCtrl _x) ctrlShow false} forEach [44151,44150,44146,44147,44148,44149,44346];
	uiNameSpace getVariable "BIS_fnc_arsenal_display" displayAddEventHandler ["keydown", "_this#3"]; 
};

tsp_fnc_action_garage = { 
	params ["_center", ["_distance", 10], ["_data", {[]}], ["_dataFormat", []], ["_pos", getPosASL (_this#0)], ["_dir", getDir (_this#0)]]; titleCut ["", "BLACK OUT", 0.5]; sleep 0.5; 
	{deleteVehicle _x} forEach (vehicles select {_x distance _center < _distance});  //-- Clear area
	_data = (call _data) select {isClass (configfile >> "CfgVehicles" >> _x)};  //-- Only for classes that exist
	{_dataFormat pushBack getText(configFile >> "CfgVehicles" >> _x >> "model"); _dataFormat pushBack [configFile >> "CfgVehicles" >> _x]} forEach _data;
	[missionNamespace, "garageOpened", {params["_display"]; uiNameSpace setVariable ["BIS_fnc_garage_display", _display]}] call BIS_fnc_addScriptedEventHandler;               //-- Get display
	["Open", [true, createVehicle ["Land_HelipadEmpty_F", getPos _center, [], 0, "CAN_COLLIDE"]]] call BIS_fnc_garage;                                                        //-- Open garage
	waitUntil {uiNameSpace getVariable ["BIS_fnc_garage_display", displayNull] isNotEqualTo displayNull}; _display = uiNameSpace getVariable "BIS_fnc_garage_display";       //-- Wait for garage
	missionNamespace setVariable ["bis_fnc_garage_data", [_dataFormat,[],[],[],[],[]]]; {lbClear (_display displayctrl (960 + _forEachIndex))} forEach bis_fnc_garage_data; //-- Set garage data
	missionNamespace setVariable ["bis_fnc_garage_centerType", _dataFormat#0]; ["ListAdd", [_display]] call BIS_fnc_garage;                                                //-- Set default, refresh list
	{_display displayCtrl _x ctrlShow false} forEach [44151,44150,44146,44147,44148,44149,44346,44347,931,932,933,934,935];                                               //-- Remove buttons 
	_display displayCtrl 930 ctrlSetText "\a3\Missions_F_Orange\Data\Img\Showcase_LawsOfWar\action_exit_CA.paa"; _display displayCtrl 930 ctrlSetTooltip "Vehicles";     //-- Edit button
	while {uiNameSpace getVariable ["BIS_fnc_arsenal_cam", -1] isNotEqualTo -1} do {BIS_fnc_arsenal_center setPosASL _pos; BIS_fnc_arsenal_center setDir _dir};         //-- Set pos and directSay
	_vehicle = createVehicle [typeOf BIS_fnc_garage_center, [0,0,0], [], 0, "CAN_COLLIDE"]; _vehicle attachTo [BIS_fnc_garage_center, [0,0,0]];                        //-- Create global vehicle
	[_vehicle, ([BIS_fnc_garage_center] call BIS_fnc_getVehicleCustomization)#0, ([BIS_fnc_garage_center] call BIS_fnc_getVehicleCustomization)#1] call BIS_fnc_initVehicle;  //-- Copy look
	{deleteVehicle _x} forEach (allUnits select {"B_Soldier_VR_F" in typeOf _x}); deleteVehicle BIS_fnc_garage_center;                                               //-- Delete VR and local vehicle
};

tsp_fnc_action_sleep = {
    params [["_anim", true]]; sleep 0.2; findDisplay 46 createDisplay "RscDisplayAttributesModuleSkiptime";
    waitUntil {isNull (uiNamespace getVariable "RscDisplayAttributesModuleSkiptime")}; _dayTime = dayTime; sleep 3; 
    if (_anim && abs (_dayTime - dayTime) > 1) then {[player, "Acts_UnconsciousStandUp_part1"] remoteExec ["switchMove", 0]};
};

tsp_fnc_action_teleport = {params ["_unit", "_location"]; cutText ["", "BLACK OUT", 1]; sleep 1; _unit attachTo [_location,[0,0,0]]; detach _unit; cutText ["", "BLACK IN", 1]};

tsp_fnc_action = {  //-- Changes for public release in here
	params ["_object", "_type", ["_conditon", "true"], ["_params", []], ["_icon", "\a3\data_f_destroyer\data\UI\IGUI\Cfg\holdactions\holdAction_loadVehicle_ca.paa"]];	
	if (_type == "Physics") then {if (isServer) then {_pos = "Land_HelipadEmpty_F" createVehicle position _object; _pos attachto [_object, [0, 0, 0]]; detach _pos; _object attachTo [_pos]; _object allowdamage false}};
	if (_type == "Heal") then {[_object, "Heal", "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_revive_ca", {[player] call tsp_fnc_heal}] call tsp_fnc_action_hold};
	if (_type == "Spectate") then {[_object, "Spectate", "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_forceRespawn_ca.paa", {[true] call tsp_fnc_spectate}, "tsp_param_spectate != 'Disabled'"] call tsp_fnc_action_hold};
	if (_type == "Teleport") then {[_object, "Teleport", "\a3\ui_f_oldman\data\IGUI\Cfg\holdactions\map_ca.paa", {titleCut ["", "BLACK OUT", 0.5]; sleep 0.5; [false] spawn tsp_fnc_spawn_map}] call tsp_fnc_action_hold};
	if (_type == "Role") then {[_object, "Select Role", "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_requestLeadership_ca.paa", {[] spawn tsp_fnc_role}, "tsp_param_role"] call tsp_fnc_action_hold};
	if (_type == "Arsenal") then {
		_params params [["_full", false]];
		if (_full) then {
			[_object, "Arsenal", "\a3\missions_f_oldman\data\img\holdactions\holdAction_box_ca.paa", {["Open", [true]] call BIS_fnc_arsenal}] call tsp_fnc_action_hold;
			[_object, "Arsenal (ACE)", "\a3\missions_f_oldman\data\img\holdactions\holdAction_box_ca.paa", {[player, player, true] call ace_arsenal_fnc_openBox}, "!isNil 'ace_arsenal_fnc_openBox'"] call tsp_fnc_action_hold;
		} else {				
			[_object, "Arsenal", "\a3\missions_f_oldman\data\img\holdactions\holdAction_box_ca.paa", {[player] spawn tsp_fnc_action_arsenal}] call tsp_fnc_action_hold;
			[_object, "Arsenal (ACE)", "\a3\missions_f_oldman\data\img\holdactions\holdAction_box_ca.paa", {[player, true, false] call ace_arsenal_fnc_removeVirtualItems; [player, tsp_arsenal] call ace_arsenal_fnc_addVirtualItems; [player, player] call ace_arsenal_fnc_openBox}, "!isNil 'ace_arsenal_fnc_openBox'"] call tsp_fnc_action_hold;
		};
		[_object, "Save", "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_unloaddevice_ca.paa", {tsp_loadout_saved = getUnitLoadout player; ["", "Loadout Saved"] spawn (missionNameSpace getVariable ["tsp_fnc_hint", BIS_fnc_showSubtitle])}] call tsp_fnc_action_hold;		
		[_object, "Load", "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_loaddevice_ca.paa", {player setUnitLoadout tsp_loadout_saved; ["", "Loadout Loaded"] spawn (missionNameSpace getVariable ["tsp_fnc_hint", BIS_fnc_showSubtitle])}, "!isNil 'tsp_loadout_saved'"] call tsp_fnc_action_hold;
		[_object, "Reset", "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_unbind_ca.paa", {player setUnitLoadout tsp_loadout_original; ["", "Loadout Original"] spawn (missionNameSpace getVariable ["tsp_fnc_hint", BIS_fnc_showSubtitle])}, "!isNil 'tsp_loadout_original'"] call tsp_fnc_action_hold
	};
	if (_type == "Weather") then {[_object, "Weather", "data\actions\weather.paa", {[] spawn {sleep 0.2; findDisplay 46 createDisplay "RscDisplayAttributesModuleWeather"}}, "true"] call tsp_fnc_action_hold};
	if (_type == "Music") then {[_object, "Music", "data\actions\music.paa", {[] spawn {sleep 0.2; findDisplay 46 createDisplay "RscDisplayAttributesModuleMusic"}}, "true"] call tsp_fnc_action_hold};
	if (_type == "Sleep") then {
		[
			_object, "Sleep", "\a3\ui_f_oldman\data\IGUI\Cfg\holdactions\holdAction_sleep_ca.paa", {[] spawn tsp_fnc_action_sleep}, 
			"{([[_x] call BIS_fnc_getRespawnPositions, _x] call BIS_fnc_nearestPosition) distance _x > 50} count allPlayers > 0"
		] call tsp_fnc_action_hold;
	};	
	if (_type == "Garage") then {[_object, "Garage", _icon, {_this#3 spawn tsp_fnc_action_garage}, _conditon, false, 1, _params] call tsp_fnc_action_hold};
};

//[this,"Garage",[garage_center,["B_Quadbike_01_F","B_MRAP_01_F","B_MRAP_01_gmg_F","B_MRAP_01_hmg_F","B_LSV_01_AT_F","B_LSV_01_armed_F","B_LSV_01_unarmed_F","B_Truck_01_mover_F","B_Truck_01_ammo_F","B_Truck_01_box_F","B_Truck_01_cargo_F","B_Truck_01_flatbed_F","B_Truck_01_fuel_F","B_Truck_01_medical_F","B_Truck_01_Repair_F","B_Truck_01_transport_F","B_Truck_01_covered_F","B_Heli_Light_01_F"]]] call tsp_fnc_action;