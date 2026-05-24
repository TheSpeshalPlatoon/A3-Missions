gg_fnc_kill = {
    params ["_unit"];
    _unit setVariable ["gg_kills", (_unit getVariable ["gg_kills", 0]) + 1, true];  //-- Increment
    if (_unit getVariable ["gg_kills", 0] == count loadouts) exitWith {[_unit] remoteExec ["gg_fnc_end", 2]};  //-- Win
    if (_unit == missionNameSpace getVariable ["dave", objNull]) exitWith {};  //-- Dave doesnt need stuff
    _unit setUnitLoadout (loadouts#(_unit getVariable ["gg_kills", 0]));  //-- Gib new loadout
};

gg_fnc_end = {  //-- Run on server
    params ["_winner", ["_leaderBoard", []]]; if (!isNil "gg_over") exitWith {}; gg_over = true;  //-- Only call this function once

    {_leaderBoard pushBack [_x getVariable ["gg_kills", 0], name _x]} forEach allPlayers; _leaderBoard sort false;  //-- Create leaderboard array, sort by kills

    _endingMessage = "<t size='2' color='#d4af37'>Winner: </t><br/>" + _leaderBoard#0#1 + "<br/>";  //-- 1st place
    if (count _leaderBoard > 1) then {_endingMessage = _endingMessage + "<t size='1.7' color='#d3d3d3'>Second: </t><br/>" + _leaderBoard#1#1 + "<br/>"};  //-- 2nd place
    if (count _leaderBoard > 2) then {_endingMessage = _endingMessage + "<t size='1.5' color='#cd7f32'>Third: </t><br/>" + _leaderBoard#2#1 + "<br/>"};  //-- 3rd place  
    [parseText _endingMessage] remoteExec ["hint", 0];  //-- Do the hint for everyone
    
    [[], {player switchMove "Acts_Dance_01"; sleep 5; "WIN" call BIS_fnc_endMission}] remoteExec ["spawn", _winner];  //-- Do for winner
    [[], {player switchMove "Acts_Stunned_Unconscious"; sleep 5; "LOSE" call BIS_fnc_endMission}] remoteExec ["spawn", -owner _winner];  //-- Do for everyone else
};

gg_fnc_spawn = {
    params ["_unit", ["_allSpawns", []], ["_safeSpawns", []], ["_spawnsToUse", []]];

    {if (_x nearEntities ["Man", 15] isEqualTo []) then {_safeSpawns pushBack _x}} forEach _allSpawns;  //-- Find safe spawns
    if (_safeSpawns isEqualTo []) then {_spawnsToUse = _allSpawns} else {_spawnsToUse = _safeSpawns};  //-- Use safe spawns if available
    _unit attachTo [selectRandom _spawnsToUse, [0,0,0]]; detach _unit;
    
    titleCut ["", "BLACK IN", 1]; [true] call acre_api_fnc_setSpectator; 
    if (_unit == missionNameSpace getVariable ["dave", objNull]) exitWith {_unit setUnitLoadout gg_dave};  //-- Dave doesnt want the loadouts
    _unit setUnitLoadout (loadouts#(_unit getVariable ["gg_kills", 0]));  //-- Return correct loadout on respawn
    _unit spawn {sleep 0.25; _this playAction "GestureNo"};  //-- Cancel pull out weapon gesture
};

createMarker ["respawn_civ", getPos player];  //-- Required for respawn type

if (isServer) then {  //-- Only server can run getMissionLayerEntites
    gg_spawns = ((getMissionLayerEntities "gg")#0) select {_x isKindOf "Land_HelipadEmpty_F"}; publicVariable "gg_spawns";
    gg_zones = ((getMissionLayerEntities "gg")#0) select {_x isKindOf "EmptyDetector"}; publicVariable "gg_zones";
};

waitUntil {sleep 1;	!isNull player && !isNil "loadouts"};  //-- Cause init.sqf executes too early for JIP players
ace_medical_disabled = true; STHud_UIMode = 0; STHud_SettingsAllUnits = false;

[player, gg_spawns] call gg_fnc_spawn; player addMPEventHandler ["MPRespawn", {[player, gg_spawns] call gg_fnc_spawn}];
[player, gg_zones, "You are out of bounds!", {[_this, gg_zones] spawn tsp_fnc_zone_launch}, {alive _this}, 2, 2] spawn tsp_fnc_zone;
player addMPEventHandler ["MPRespawn", {[player, gg_zones, "You are out of bounds!", {[_this, gg_zones] spawn tsp_fnc_zone_launch}, {alive _this}, 2, 2] spawn tsp_fnc_zone}];

addMissionEventHandler ["EntityKilled", {params ["_killed", "_killer"]; if (_killed == player) then {titleCut ["", "BLACK OUT", 1]}}];
addMissionEventHandler ["EntityKilled", {params ["_killed", "_killer"]; if (_killed != player && _killer == player) then {[player] call gg_fnc_kill};}];

["tsp_melee_damageMan", {params ["_unit", "_victim"]; if (alive _victim) then {_victim setDamage 1; [_unit] call gg_fnc_kill}}] call CBA_fnc_addEventHandler;  //-- Runs when you kill someone with melee