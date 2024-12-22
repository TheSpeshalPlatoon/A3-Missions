if (!isNil "playa") exitWith {};  //-- So that this stuff ony runs once (race condition between addon and mission)

playa = player; player addEventHandler ["Respawn", {params ["_unit", "_corpse"]; playa = _unit}];  //-- Playa variable
if (!isNil "CBA_fnc_addPlayerEventHandler") then {["unit", {playa = _this#0}, true] call CBA_fnc_addPlayerEventHandler};  //-- CBA does it better, gets Zeus RC too

tsp_path = if (isClass (configFile >> 'CfgPatches' >> 'tsp_core')) then {"\tsp_core\"} else {""};
tsp_mission = (getMissionConfigValue ["tsp_param_mission", false]) isEqualTo "true";  //-- desciption.ext param to load mission scripts
tsp_addons = (getMissionConfigValue ["tsp_param_addons", false]) isEqualTo "true";   //-- desciption.ext param to load addon scripts
tsp_debug = createVehicleLocal ["Land_HelipadEmpty_F", getPos player];

if (fileExists (tsp_path+'scripts\common.sqf')) then {[] call compileScript [tsp_path+'scripts\common.sqf']};
if (fileExists (tsp_path+'scripts\utility.sqf')) then {[] call compileScript [tsp_path+'scripts\utility.sqf']};
if (fileExists (tsp_path+'scripts\faction.sqf')) then {[] call compileScript [tsp_path+'scripts\faction.sqf']};
if (fileExists (tsp_path+'scripts\action.sqf')) then {[] call compileScript [tsp_path+'scripts\action.sqf']};
if (fileExists (tsp_path+'scripts\butter.sqf')) then {[] call compileScript [tsp_path+'scripts\butter.sqf']};
if (fileExists (tsp_path+'scripts\chvd.sqf')) then {[] call compileScript [tsp_path+'scripts\chvd.sqf']};
if (fileExists (tsp_path+'scripts\pause.sqf')) then {[] spawn compileScript [tsp_path+'scripts\pause.sqf']};

if (tsp_mission && fileExists (tsp_path+'scripts\environment.sqf')) then {[] spawn compileScript [tsp_path+'scripts\environment.sqf']};
if (tsp_mission && fileExists (tsp_path+'scripts\role.sqf')) then {[] spawn compileScript [tsp_path+'scripts\role.sqf']};
if (tsp_mission && fileExists (tsp_path+'scripts\sector.sqf')) then {[] spawn compileScript [tsp_path+'scripts\sector.sqf']};
if (tsp_mission && fileExists (tsp_path+'scripts\skill.sqf')) then {[] spawn compileScript [tsp_path+'scripts\skill.sqf']};
if (tsp_mission && fileExists (tsp_path+'scripts\spawn.sqf')) then {[] spawn compileScript [tsp_path+'scripts\spawn.sqf']};
if (tsp_mission && fileExists (tsp_path+'scripts\killhouse.sqf')) then {[] spawn compileScript [tsp_path+'scripts\killhouse.sqf']};

if (tsp_addons || isClass (configFile >> 'CfgPatches' >> 'tsp_earplug') && fileExists (tsp_path+'scripts\earplug.sqf')) then {[] spawn compileScript [tsp_path+'scripts\earplug.sqf']};
if (tsp_addons || isClass (configFile >> 'CfgPatches' >> 'tsp_crash') && fileExists (tsp_path+'scripts\crash.sqf')) then {[] spawn compileScript [tsp_path+'scripts\crash.sqf']};
if (tsp_addons || isClass (configFile >> 'CfgPatches' >> 'tsp_flare') && fileExists (tsp_path+'scripts\flare.sqf')) then {[] spawn compileScript [tsp_path+'scripts\flare.sqf']};
if (tsp_addons || isClass (configFile >> 'CfgPatches' >> 'tsp_ragdoll') && fileExists (tsp_path+'scripts\ragdoll.sqf')) then {[] spawn compileScript [tsp_path+'scripts\ragdoll.sqf']};
if (tsp_addons || isClass (configFile >> 'CfgPatches' >> 'tsp_immerse') && fileExists (tsp_path+'scripts\immerse.sqf')) then {[] spawn compileScript [tsp_path+'scripts\immerse.sqf']};