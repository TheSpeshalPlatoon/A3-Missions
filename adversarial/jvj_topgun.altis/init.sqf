tsp_fnc_countdown = {  //-- Run on the server
	params [["_total", 25], ["_setup", 60], ["_gap", 5], ["_code", {}]]; 
	["Mission starts in " + str _setup+" seconds.", "Countdown ended! " + str _total + " minutes have elapsed!"] params ["_start","_end"];
	if (_setup > 0) then {_start remoteExec ["systemChat", 0]; 
	waitUntil {sleep 1; time > _setup}}; ["Mission Start!"] remoteExec ["systemChat", 0];
	for "_i" from _total to 1 step -_gap do {[str _i + (if (_i == 1) then {" minute"} else {" minutes"}) + " remaining!"] remoteExec ["systemChat", 0]; uiSleep (_gap*60)};
	_end remoteExec ["systemChat", 0]; [] call _code;
};

tsp_fnc_zone = {
	params ["_unit", "_zones", "_messageLeave", "_messageReturn", ["_codeLeave", {}], ["_codeReturn", {}], ["_condition", {alive _this}], ["_timeout", 5], ["_interval", 2]];
	while {sleep _interval; _unit call _condition} do {
		if (_unit distance (missionNameSpace getVariable ["tsp_debug", objNull]) < 50) then {continue};  //-- Debug
		if ([_unit, _zones] call tsp_fnc_zone_inTriggers) then {continue};  //-- If not in zone
		systemChat _messageLeave; sleep _timeout;  //-- Turn around time
		if ([_unit, _zones] call tsp_fnc_zone_inTriggers) then {continue};  //-- If not back, then run code
		_unit call _codeLeave;
		waitUntil {!(_unit call _condition) || [_unit, _zones] call tsp_fnc_zone_inTriggers};
		systemChat _messageReturn; _unit call _codeReturn;
	};
};

tsp_fnc_zone_inTriggers = {
	params ["_unit", ["_triggers", []]];
	if (count (_triggers select {_unit inArea _x}) > 0) exitWith {true};
	false
};

tsp_fnc_zone_launch = {  //-- [player, [_zones, player] call BIS_fnc_nearestPosition] spawn tsp_fnc_zone_launch;
	params ["_unit", "_towards"];
	(vehicle _unit) setDir (_towards getRelDir _unit) - 180;   
	(vehicle _unit) setVelocityModelSpace [0, 35, 10];
	if (vehicle _unit != _unit) exitWith {};
	_unit allowDamage false; _unit setUnconscious true; 
	waitUntil {sleep 2; isTouchingGround _unit && speed _unit == 0};
	_unit allowDamage true; _unit setUnconscious false;
	_unit switchMove "UnconsciouOutProne";
};

tsp_fnc_vehicleLoadoutInit = {
	params ["_vehicle"];
	_vehicle setPylonLoadout ["pylon1", "PylonMissile_Missile_BIM9X_x1"];
	_vehicle setPylonLoadout ["pylon2", "PylonMissile_Missile_BIM9X_x1"];
	_vehicle setPylonLoadout ["pylon3", "PylonMissile_Missile_BIM9X_x1"];
	_vehicle setPylonLoadout ["pylon4", "PylonMissile_Missile_BIM9X_x1"];
	_vehicle setPylonLoadout ["pylon5", "PylonMissile_Missile_BIM9X_x1"];
	_vehicle setPylonLoadout ["pylon6", "PylonMissile_Missile_BIM9X_x1"];
	_vehicle setPylonLoadout ["pylon7", ""];
	_vehicle setPylonLoadout ["pylon8", ""];
	_vehicle setPylonLoadout ["pylon9", ""];
	_vehicle setPylonLoadout ["pylon10", ""];
	if (_vehicle distance spawn_west < 1000) exitWith {[_vehicle, [0, "js_jc_fa18_contrib_squads\data\vfa177_fa18e_hull_co.paa"]] remoteExec ["setObjectTexture", 0]};
	[_vehicle, [0, "js_jc_fa18_contrib_squads\data\vfa176_fa18e_hull_co.paa"]] remoteExec ["setObjectTexture", 0];
	[_vehicle, [1, "js_jc_fa18_contrib_squads\data\vfa176_fa18_misc_co.paa"]] remoteExec ["setObjectTexture", 0];
};

tsp_fnc_score = {hint parseText ("<t size='2' color='#2445bd'>" + str points_west + "</t> - <t size='2' color='#db1f1f'>" + str points_east + "</t>")};

waitUntil {!isNil "missionStarted"};
sleep 3; systemChat "Side with the most points after 10 minutes wins!";
sleep 3; systemChat "Fighting can only happen within the marked AO, you cannot leave once entering.";
sleep 3; systemChat "Destroy the enemy helicopter to gain an additional point.";