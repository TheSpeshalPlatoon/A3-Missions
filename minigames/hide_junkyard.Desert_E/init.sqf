tsp_fnc_time = {timeServer = time; publicVariable "timeServer"};  //-- For clients to get current server time.

tsp_fnc_server = {
    zones = ((getMissionLayerEntities "mission")#0) select {_x isKindOf "EmptyDetector"}; publicVariable "zones";
    waitUntil {count playableUnits > 1}; [[], tsp_fnc_seeker] remoteExec ["spawn", selectRandom playableUnits];  //-- Select first seeker randomly
    while {sleep 3; true} do {  //-- Ending conditions
        _alive = playableUnits select {!isObjectHidden _x};
        if (count (_alive select {_x getVariable ["seeker", false]}) == 0) exitWith {[[], {"HIDER" call BIS_fnc_endMission}] remoteExec ["spawn", 0]};       //-- Hiders win if all seekers left
        if (count (_alive select {!(_x getVariable ["seeker", false])}) == 0) exitWith {[[], {"SEEKER" call BIS_fnc_endMission}] remoteExec ["spawn", 0]};  //-- Seekers win if no hiders left
        if (time > totalTime) exitWith {[[], {"HIDER" call BIS_fnc_endMission}] remoteExec ["spawn", 0]};                                                  //-- Hiders win if time limit reached
    };
    [[], {player switchMove "Acts_Dance_01"}] remoteExec ["spawn", 0];  //-- Dance
};

tsp_fnc_client = {
    params [["_unit", player]];
    cutText ["Waiting for players...", "BLACK OUT", 0.001];  //-- Start with black screen
    [] remoteExec ["tsp_fnc_time", 2]; waitUntil {!isNull _unit && !isNil "timeServer"};  //-- Get server time
    if (timeServer > 20) exitWith {["Initialize", [_unit, []]] call BIS_fnc_EGSpectator; [_unit, true] remoteExec ["hideObjectGlobal", 2]};  //-- Late joiners
    waitUntil {count (playableUnits select {_x getVariable ["seeker", false]}) > 0};  //-- Wait until there is a seeker selected
    [_unit, zones, "You are out of bounds!", {[_this, zones] spawn tsp_fnc_zone_launch}, {alive _this}, 2, 2] spawn tsp_fnc_zone_create;  //-- Zone   
    cutText ["", "BLACK IN", 1];
    while {sleep 1; (timeServer + time) < hideTime} do {
        if (_unit getVariable ["seeker", false]) then {cutText [("You are seeking, you will be released in... " + str round (hideTime - (timeServer + time))), "BLACK OUT", 0.001]; continue};
        hintSilent parseText ("<t size='2'>Hiding Time: " + ([hideTime - (timeServer + time), "MM:SS"] call BIS_fnc_secondsToString) + "</t>");
    };
    cutText ["", "BLACK IN", 1];
    while {sleep 1; (timeServer + time) < totalTime} do {hintSilent parseText ("<t size='2'>" + ([(totalTime - (timeServer + time)), "MM:SS"] call BIS_fnc_secondsToString) + "</t>")};
};

tsp_fnc_seeker = {
    params ["_seeker"];
    _seeker setVariable ["seeker", true, true]; _seeker addUniform "U_C_Man_casual_6_F"; _seeker enableFatigue false;
    playSound3D ["A3\Sounds_F\sfx\blip1.wss", _seeker, false, getPosASL _seeker, 3, 1, 50];
    while {sleep 1; alive _seeker} do {
        {
            [_x] params ["_hider"]; _seeker playAction "tsp_animate_tap";
            _hider setVariable ["seeker", true, true]; [_hider, tsp_fnc_seeker] remoteExec ["spawn", _hider];
            [name _hider + " was found by " + name _seeker] remoteExec ["systemChat"]; 
        } forEach (playableUnits select {!(_x getVariable ["seeker", false]) && _x distance _seeker < 2.5});
    };
};

hideTime = ["hideTime", -1] call BIS_fnc_getParamValue; 
totalTime = hideTime + (["totalTime", -1] call BIS_fnc_getParamValue); 
if (isServer) then {[] spawn tsp_fnc_server}; [] spawn tsp_fnc_client;