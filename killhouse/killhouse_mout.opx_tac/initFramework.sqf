if (!isNil "playa") exitWith {};  //-- So that this stuff ony runs once

playa = player; player addEventHandler ["Respawn", {params ["_unit", "_corpse"]; playa = _unit}];  //-- Playa variable
if (!isNil "CBA_fnc_addPlayerEventHandler") then {["unit", {playa = _this#0}, true] call CBA_fnc_addPlayerEventHandler};  //-- CBA does it better, gets Zeus RC too

tsp_path = if (fileExists "scripts\common.sqf") then {""} else {"\tsp_core\"};
tsp_debug = createVehicleLocal ["Land_HelipadEmpty_F", getPos player];
tsp_mission = getMissionConfigValue ["tsp_param_spawn", 0] isNotEqualTo 0;
tsp_addons = getMissionConfigValue ["tsp_param_addons", 0] isNotEqualTo 0;

[] call compileScript [tsp_path+'scripts\common.sqf'];
[] call compileScript [tsp_path+'scripts\utility.sqf'];
[] call compileScript [tsp_path+'scripts\faction.sqf'];
[] call compileScript [tsp_path+'scripts\action.sqf'];
[] call compileScript [tsp_path+'scripts\butter.sqf'];
[] call compileScript [tsp_path+'scripts\chvd.sqf'];
[] spawn compileScript [tsp_path+'scripts\pause.sqf'];
if (tsp_mission && !is3DEN) then {[] spawn compileScript [tsp_path+'scripts\environment.sqf']};
if (tsp_mission) then {[] spawn compileScript [tsp_path+'scripts\role.sqf']};
if (tsp_mission) then {[] spawn compileScript [tsp_path+'scripts\sector.sqf']};
if (tsp_mission) then {[] spawn compileScript [tsp_path+'scripts\skill.sqf']};
if (tsp_mission) then {[] spawn compileScript [tsp_path+'scripts\spawn.sqf']};
if (tsp_mission) then {[] spawn compileScript [tsp_path+'scripts\killhouse.sqf'];};
if (tsp_addons || isClass (configFile >> 'CfgPatches' >> 'tsp_earplug')) then {[] spawn compileScript [tsp_path+'scripts\earplug.sqf']};
if (tsp_addons || isClass (configFile >> 'CfgPatches' >> 'tsp_crash')) then {[] spawn compileScript [tsp_path+'scripts\crash.sqf']};
if (tsp_addons || isClass (configFile >> 'CfgPatches' >> 'tsp_flare')) then {[] spawn compileScript [tsp_path+'scripts\flare.sqf']};
if (tsp_addons || isClass (configFile >> 'CfgPatches' >> 'tsp_ragdoll')) then {[] spawn compileScript [tsp_path+'scripts\ragdoll.sqf']};
if (tsp_addons || isClass (configFile >> 'CfgPatches' >> 'tsp_immerse')) then {[] spawn compileScript [tsp_path+'scripts\immerse.sqf']};
//if (tsp_addons || isClass (configFile >> 'CfgPatches' >> 'tsp_tracker')) then {call compileScript [tsp_path+'scripts\tracker.sqf']};