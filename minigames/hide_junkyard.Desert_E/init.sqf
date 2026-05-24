hide_fnc_time = {hide_time_server = time; publicVariable "hide_time_server"};  //-- For clients to get current server time (for countdown)

hide_fnc_server = {
    zones = ((getMissionLayerEntities "mission")#0) select {_x isKindOf "EmptyDetector"}; publicVariable "zones";
    waitUntil {sleep 3; count playableUnits > 1}; [[], hide_fnc_seeker] remoteExec ["spawn", selectRandom playableUnits];  //-- Select first seeker randomly
    while {sleep 3; true} do {  //-- Ending conditions
        _alive = playableUnits select {!isObjectHidden _x};
        if (time > hide_time_total) exitWith {[[], {"HIDER" call BIS_fnc_endMission}] remoteExec ["spawn", 0]};  //-- Hiders win if time limit reached
        if (count (_alive select {_x getVariable ["seeker", false]}) == 0) exitWith {[[], {"HIDER" call BIS_fnc_endMission}] remoteExec ["spawn", 0]};  //-- Hiders win if all seekers left
        if (count (_alive select {!(_x getVariable ["seeker", false])}) == 0) exitWith {[[], {"SEEKER" call BIS_fnc_endMission}] remoteExec ["spawn", 0]};  //-- Seekers win if no hiders left
    };
    [[], {player switchMove "Acts_Dance_01"}] remoteExec ["spawn", 0];
};

hide_fnc_client = {
    params [["_unit", player]];
    cutText ["Waiting for players...", "BLACK OUT", 0.001];  //-- Start with black screen
    [] remoteExec ["hide_fnc_time", 2]; waitUntil {!isNull _unit && !isNil "hide_time_server"};  //-- Get server time
    ace_medical_disabled = true; STHud_UIMode = 0; STHud_SettingsAllUnits = false;
    if (hide_time_server > hide_time_hide) exitWith {["Initialize", [_unit, []]] call BIS_fnc_EGSpectator; [_unit, true] remoteExec ["hideObjectGlobal", 2]; cutText ["", "BLACK IN", 1]};  //-- Late joiners
    [_unit, zones, "You are out of bounds!", {[_this, zones] spawn tsp_fnc_zone_launch}, {alive _this}, 2, 2] spawn tsp_fnc_zone_create; 
    waitUntil {count (playableUnits select {_x getVariable ["seeker", false]}) > 0};  //-- Wait until there is a seeker selected
    cutText ["", "BLACK IN", 1];
    while {sleep 1; (hide_time_server + time) < hide_time_hide} do {
        if (_unit getVariable ["seeker", false]) then {cutText ["You are seeking, you will be released in... " + str round (hide_time_hide - (hide_time_server + time)), "BLACK OUT", 0.001]; continue};
        hintSilent parseText ("<t size='2'>Hiding Time: " + ([hide_time_hide - (hide_time_server + time), "MM:SS"] call BIS_fnc_secondsToString) + "</t>");
    };
    cutText ["", "BLACK IN", 1];
    while {sleep 1; (hide_time_server + time) < hide_time_total} do {hintSilent parseText ("<t size='2'>" + ([hide_time_total - (hide_time_server + time), "MM:SS"] call BIS_fnc_secondsToString) + "</t>")};
};

hide_fnc_seeker = {
    params ["_seeker"];
    _seeker setVariable ["seeker", true, true]; 
    playSound3D ["A3\Sounds_F\sfx\blip1.wss", _seeker, false, getPosASL _seeker, 3, 1, 50];
    _seeker addUniform "U_C_Man_casual_6_F"; 
    _seeker enableFatigue false;
    while {sleep 1; alive _seeker} do {
        { 
            _seeker playAction "tsp_animate_tap";
            _x setVariable ["seeker", true, true];  //-- Race condition
            [_x] remoteExec ["hide_fnc_seeker", _x];
            [name _x + " was found by " + name _seeker] remoteExec ["systemChat"]; 
        } forEach (playableUnits select {!(_x getVariable ["seeker", false]) && _x distance _seeker < 2.5});
    };
};

hide_time_hide = ["hide_time_hide", -1] call BIS_fnc_getParamValue; 
hide_time_total = hide_time_hide + (["hide_time_total", -1] call BIS_fnc_getParamValue); 
if (isServer) then {[] spawn hide_fnc_server}; [] spawn hide_fnc_client;