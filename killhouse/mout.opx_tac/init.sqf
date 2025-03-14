tsp_enemies = [
	"tsp_syn_thug1", "tsp_syn_thug2", "tsp_syn_thug3", "tsp_syn_thug4",	"tsp_syn_machinegunner", "tsp_syn_marksman",
	"I_C_Soldier_Bandit_1_F", "I_C_Soldier_Bandit_2_F", "I_C_Soldier_Bandit_3_F", "I_C_Soldier_Bandit_4_F", "I_C_Soldier_Bandit_5_F", "I_C_Soldier_Bandit_6_F",	"I_C_Soldier_Bandit_7_F", "I_C_Soldier_Bandit_8_F",
	"I_C_Soldier_Para_1_F",	"I_C_Soldier_Para_2_F",	"I_C_Soldier_Para_3_F",	"I_C_Soldier_Para_4_F",	"I_C_Soldier_Para_5_F",	"I_C_Soldier_Par_6_F","I_C_Soldier_Para_7_F", "I_C_Soldier_Para_8_F", "I_C_Soldier_Camo_F"
];

tsp_civilians = [
	"tsp_civilian_secretary", "tsp_civilian_sportswoman", "tsp_civilian_hooker", "tsp_civilian_baker", "tsp_civilian_ensler", "tsp_civilian_euro", "tsp_civilian_valentina",
	"tsp_civilian_mechanic", "tsp_civilian_firefighter", "tsp_civilian_paramedic", "tsp_civilian_pilot", "tsp_civilian_functionary",
	"tsp_civilian_citizen", "tsp_civilian_worker", "tsp_civilian_profiteer", "tsp_civilian_woodlander", "tsp_civilian_villager", "tsp_civilian_rocker",
	"tsp_civilian_priest", "tsp_civilian_doctor", "tsp_civilian_teacher", "tsp_civilian_assistant"
];

tsp_fnc_killhouse = {
	params ["_caller", "_triggers", ["_chance", 0.7], ["_typesBad", tsp_enemies], ["_typesCiv", tsp_civilians], ["_units", []], ["_groups", []]];

	//-- Hints
	_units = allUnits select {[_x, _triggers] call tsp_fnc_zone_triggers};
	if (count (_units select {isPlayer _x}) > 0) exitWith {["", "Killhouse still has players inside."] remoteExec ["BIS_fnc_showSubtitle", _caller]};
	if (count (_units select {side _x != civilian}) > 0) exitWith {["", "Killhouse still has enemies inside."] remoteExec ["BIS_fnc_showSubtitle", _caller]};
	["", "Killhouse populated with live targets."] remoteExec ["BIS_fnc_showSubtitle", _caller];

	//-- Replace targets with units
	_targets = (allMissionObjects "") select {[_x, _triggers] call tsp_fnc_zone_triggers && (_x isKindOf "TargetE" || _x isKindOf "Target_F")}; 
	{
		[_x, true] remoteExec ["hideObjectGlobal", 2];
		if (random 1 > _chance) then {continue};
		_group = createGroup resistance; _group deleteGroupWhenEmpty true; 
		_unit = _group createUnit [selectRandom (if (_x isKindOf "TargetE") then {_typesCiv} else {_typesBad}), getPos _x, [], 1, "CAN_COLLIDE"];
		if (_x isKindOf "TargetE") then {[_unit, true] call ACE_captives_fnc_setSurrendered};
		_unit setUnitPos (selectRandom ["UP", "MIDDLE"]); _unit attachTo [_x, [0,0,0]]; detach _unit; _groups pushBack _group; _units pushBack _unit;
	} forEach _targets;

	//-- Cleanup
	waitUntil {sleep 5; (count (allPlayers select {[_x, _triggers] call tsp_fnc_zone_triggers})) > 0};
	waitUntil {sleep 5; (count (allPlayers select {[_x, _triggers] call tsp_fnc_zone_triggers})) < 1};
	{_x setDamage 0} forEach ((allMissionObjects "") select {[_x, _triggers] call tsp_fnc_zone_triggers});
	{{deleteVehicle _x} forEach units _x} forEach _groups; {deleteVehicle _x} forEach _units;
	{[_x, false] remoteExec ["hideObjectGlobal", 2]} forEach _targets; 
};

tsp_fnc_fastrope = {
	params ["_vehicle"];

	private _deployedRopes = _vehicle getVariable ["ace_fastroping_deployedRopes", []];
	private _hookAttachment = _vehicle getVariable ["ace_fastroping_FRIES", _vehicle];

	_ropeLength = 10;

	_ropeOrigin = [0,0,0];
	_hook = "ace_fastroping_helper" createVehicle [0, 0, 0];
	_hook allowDamage false;
	if (_ropeOrigin isEqualType []) then {
		_hook attachTo [_hookAttachment, _ropeOrigin];
	} else {
		_hook attachTo [_hookAttachment, [0, 0, 0], _ropeOrigin];
	};

	private _origin = getPosATL _hook;

	private _dummy = createVehicle ["ace_fastroping_helper", _origin vectorAdd [0, 0, -1], [], 0, "CAN_COLLIDE"];
	_dummy allowDamage false;
	_dummy disableCollisionWith _vehicle;

	private _ropeTop = ropeCreate [_dummy, [0, 0, 0], _hook, [0, 0, 0], 0.5];
	private _ropeBottom = ropeCreate [_dummy, [0, 0, 0], 1];
	ropeUnwind [_ropeBottom, 30, _ropelength, false];
	_ropeTop allowDamage false;
	_ropeBottom allowDamage false;
    
    _deployedRopes pushBack [_ropeOrigin, _ropeTop, _ropeBottom, _dummy, _hook, false, false];

	_vehicle setVariable ["ace_fastroping_deployedRopes", _deployedRopes, true];
	_vehicle setVariable ["ace_fastroping_deploymentStage", 3, true];
	_vehicle setVariable ["ace_fastroping_ropeLength", _ropeLength, true];
};

tsp_fnc_lightswitch = {
	params ["_lights", ["_sound", true]];
	{
		_x setDamage (if (damage _x > 0.1) then {0} else {0.99});
		if (_sound) then {playSound3D [if (damage _x > 0.1) then {"tsp_core\data\mout\off.ogg"} else {"tsp_core\data\mout\on.ogg"}, _x, false, getPosASL _x, 5, random 2 max 0.5 min 2, 550]};		
		sleep (random 1 + 0.5);
	} forEach _lights;
};

tsp_fnc_skeet = {
	params ["_machine"];
	_machine setVariable ["skeeting", true, true];
	while {sleep 3; _machine getVariable ["skeeting", true]} do {
		_pigeon = "Skeet_Clay_F" createVehicle position _machine;
		_pigeon attachto [_machine, [1, -1, 0]]; detach _pigeon; 
		_pigeon setVelocityModelSpace [-(random 8 max 5 min 8), -(random 8 max 5 min 8), 12]; _pigeon setdamage 0.99;
		_pigeon spawn {sleep 10; deleteVehicle _this};
		playSound3D ["A3\Sounds_F_Kart\Weapons\starting_pistol_1.wss", _pigeon, false, getPosASL _pigeon, 5, 1, 100];
	};
};

tsp_fnc_cof = {
	params ["_unit", ["_originalTargets", (allMissionObjects "") select {_x getVariable ["course", false]}], ["_actualTargets", []], ["_startTime", time]];	
	if (missionNameSpace getVariable ["cof_inUse", false]) exitWith {["", "Course is still being used."] spawn BIS_fnc_showSubtitle}; missionNameSpace setVariable ["cof_inUse", true, true];
	playSound3D ["A3\Missions_F_Oldman\Data\sound\beep.ogg", _unit, false, getPosASL _unit, 5, 1, 100];  //-- BEEP	
	{_actual = (typeOf _x) createVehicle [0,0,0]; _actual attachTo [_x, [0,0,0]]; _actual setVectorDirAndUp [vectorDir _x, vectorUp _x]; _actualTargets pushBack _actual} forEach _originalTargets;  //-- Copy actual targets
	_unit setVariable ["shotsFired", 0]; _shoot = _unit addEventHandler ["Fired", {player setVariable ["shotsFired", (player getVariable "shotsFired") + 1]}];  //-- Shot counter	
	while {uiSleep 1; alive _unit && _unit distance cof_end > 3} do {hint parseText ("<t size='2' color='#a83232'>" + ([time - _startTime, "MM:SS"] call BIS_fnc_secondsToString) + "</t>")};  //-- Timer hint
	[name _unit + " finished the course with a time of " + ([time - _startTime, "MM:SS"] call BIS_fnc_secondsToString) + ". " + str (_unit getVariable "shotsFired") + " shots fired. " + str (count (_actualTargets select {!alive _x})) + "/" + str (count _actualTargets) + " targets hit."] remoteExec ["systemChat", 0];
	playSound3D ["\rhsusf\addons\rhsusf_uav\sounds\watchBeep_single.ogg", _unit, false, getPosASL _unit, 5, 1, 100];  //-- BEEP
	{deleteVehicle _x} forEach _actualTargets; _unit removeEventHandler ["Fired", _shoot];	
	missionNameSpace setVariable ["cof_inUse", false, true];	
};

[] spawn {while {sleep 3; true} do {  //-- Safezones
	[[player, [inside_trigger]] call tsp_fnc_zone_triggers, [player, [killhouse1_trigger, killhouse1_trigger2, killhouse2_trigger, killhouse3_trigger, killhouse4_trigger]] call tsp_fnc_zone_triggers] params ["_base", "_killhouse"];
	if (captive player && (!_base || _killhouse)) then {["", "You are now outside the wire."] spawn BIS_fnc_showSubtitle; player setCaptive false};
	if (!captive player && (_base && !_killhouse)) then {["", "You are now inside the wire."] spawn BIS_fnc_showSubtitle; player setCaptive true};
}};

_action = ["Sit","Sit","\z\ace\addons\sitting\UI\sit_ca.paa", {[_target, player] call ace_sitting_fnc_sit; player attachTo [_target, [0,0,-1]]; player spawn {sleep 0.1; detach _this}}, {[_target, player] call ace_sitting_fnc_canSit}] call ace_interact_menu_fnc_createAction;
["Land_HelipadEmpty_F", 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToClass;
[player, tsp_enemies, [outside_trigger], resistance, {true}, {}, 100, 2, 30, 200] spawn tsp_fnc_zombience;
if (!isServer) exitWith {}; 

[west,"crash","Rescue Pilot","Pilots stuck at crash site need to be evacuated.","Heli",getPos task_pilot,{true},{[task_pilot, [inside_trigger]] call tsp_fnc_zone_triggers},{!alive task_pilot}] spawn tsp_fnc_task;
[west,"hvt","Kill/Capture","Dead or alive.","Kill",getPos task_hvt,{true},{[task_hvt, [inside_trigger]] call tsp_fnc_zone_triggers || !alive task_hvt}] spawn tsp_fnc_task;
[west,"cache","Destroy Cache","Destroy ammo cache containing IEDs.","Rifle",getPos task_cache,{true},{!alive task_cache}] spawn tsp_fnc_task;
[ropePoint] call tsp_fnc_fastrope;