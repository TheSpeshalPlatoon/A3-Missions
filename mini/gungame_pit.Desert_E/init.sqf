//-- FUNCTIONS
    tsp_fnc_zone = {
        params ["_unit", "_zones", "_warning", ["_code", {}], ["_condition", {alive _this}], ["_timeout", 5], ["_interval", 2]];
        while {sleep _interval; _unit call _condition} do {
            if (_unit distance (missionNameSpace getVariable ["tsp_debug", objNull]) < 50) then {continue};  //-- Debug
            if ([_unit, _zones] call tsp_fnc_zone_triggers) then {continue};  //-- If not in zone
            systemChat _warning; sleep _timeout;  //-- Turn around time
            if ([_unit, _zones] call tsp_fnc_zone_triggers) then {continue};  //-- If not back, then run code
            _unit call _code
        };
    };

    tsp_fnc_zone_triggers = {
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

    gg_fnc_kill = {
        params ["_unit"];
        _unit setVariable ["gg_kills", (_unit getVariable ["gg_kills", 0]) + 1, true];  //-- Increment
        if (_unit getVariable ["gg_kills", 0] == count gg_loadouts) exitWith {[_unit] remoteExec ["gg_fnc_end", 2]};  //-- Win
        if (_unit getVariable ["dave", false]) exitWith {};  //-- Dave doesnt need stuff
        _unit setUnitLoadout (gg_loadouts#(_unit getVariable ["gg_kills", 0]));  //-- Gib new loadout
    };

    gg_fnc_end = {  //-- Run on server
        params ["_winner", ["_leaderBoard", []]]; if (!isNil "gg_over") exitWith {}; gg_over = true;  //-- Only call this function once

        {_leaderBoard pushBack [_x getVariable ["gg_kills", 0], name _x]} forEach allPlayers; _leaderBoard sort false;  //-- Create leaderboard array, sort by kills

        //-- Ending hint
        _endingMessage = "<t size='2' color='#d4af37'>Winner: </t><br/>" + _leaderBoard#0#1 + "<br/>";  //-- 1st place
        if (count _leaderBoard > 1) then {_endingMessage = _endingMessage + "<t size='1.7' color='#d3d3d3'>Second: </t><br/>" + _leaderBoard#1#1 + "<br/>"};  //-- 2nd place
        if (count _leaderBoard > 2) then {_endingMessage = _endingMessage + "<t size='1.5' color='#cd7f32'>Third: </t><br/>" + _leaderBoard#2#1 + "<br/>"};  //-- 3rd place  
        [parseText _endingMessage] remoteExec ["hint", 0];  //-- Do the hint for everyone
        
        //-- Ending
        [[], {player switchMove "Acts_Dance_01"; sleep 5; "WIN" call BIS_fnc_endMission}] remoteExec ["spawn", _winner];                //-- Do for winner
        [[], {player switchMove "Acts_Stunned_Unconscious"; sleep 5; "LOSE" call BIS_fnc_endMission}] remoteExec ["spawn", -owner _winner];  //-- Do for everyone else
    };

    gg_fnc_spawn = {
        params ["_unit", ["_allSpawns", []], ["_safeSpawns", []], ["_spawnsToUse", []]];

        {if (_x nearEntities ["Man", 15] isEqualTo []) then {_safeSpawns pushBack _x}} forEach _allSpawns;  //-- Find safe spawns
        if (_safeSpawns isEqualTo []) then {_spawnsToUse = _allSpawns} else {_spawnsToUse = _safeSpawns};  //-- Use safe spawns if available
        _unit attachTo [selectRandom _spawnsToUse, [0,0,0]]; detach _unit;  //-- Move _unit there
        
        titleCut ["", "BLACK IN", 1];                                                      //-- Fade in      
        [true] call acre_api_fnc_setSpectator;                                            //-- Spectator audio  
        if (_unit getVariable ["dave", false]) exitWith {_unit setUnitLoadout gg_dave};  //-- Dave doesnt want the loadouts
        _unit setUnitLoadout (gg_loadouts#(_unit getVariable ["gg_kills", 0]));         //-- Return correct loadout on respawn
        _unit spawn {sleep 0.25; _this playAction "GestureNo"};                        //-- Cancel pull out weapon gesture
    };

//-- INIT
    createMarker ["respawn_civ", getPos gg_zone];  //-- Required for respawn type
    
    if (isServer) then {  //-- Only server can run getMissionLayerEntites
        gg_spawns = ((getMissionLayerEntities "gg")#0) select {_x isKindOf "Land_HelipadEmpty_F"}; publicVariable "gg_spawns";
        gg_zones = ((getMissionLayerEntities "gg")#0) select {_x isKindOf "EmptyDetector"}; publicVariable "gg_zones";
    };
    
    [] spawn {
        ace_medical_disabled = true;                                   //-- No medical       
        waitUntil {sleep 1;	!isNull player && !isNil "gg_loadouts"};  //-- Cause init.sqf executes too early for JIP players

        [player, gg_spawns] call gg_fnc_spawn;  //-- First spawn
        [player, gg_zones, "You are out of bounds!", {[_this, gg_zones] spawn tsp_fnc_zone}, {alive _this}, 2, 2] spawn tsp_fnc_zone;  //-- Zone

        player addMPEventHandler ["MPRespawn", {
            [player, gg_zones, "You are out of bounds!", {[_this, gg_zones] spawn tsp_fnc_zone}, {alive _this}, 2, 2] spawn tsp_fnc_zone;  //-- Zone
            [player, gg_spawns] call gg_fnc_spawn;
        }];

        addMissionEventHandler ["EntityKilled", {  //-- Runs when you kill someone
            params ["_killed", "_killer", "_instigator"];
            if (_killed == player) exitWith {titleCut ["", "BLACK OUT", 1]};  //-- Exit with fade if i am the one who died
            if (_killer == player) exitWith {[player] call gg_fnc_kill};     //-- Exit if i didnt kill
        }];

        ["tsp_melee_damageMan", {params ["_unit", "_victim", "_wasAlive"]; _victim setDamage 1; [_unit] call gg_fnc_kill}] call CBA_fnc_addEventHandler;  //-- Runs when you kill someone with melee
    };