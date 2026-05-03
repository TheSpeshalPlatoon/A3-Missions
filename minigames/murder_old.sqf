tsp_fnc_time = {timeServer = time; publicVariable "timeServer"};

tsp_fnc_server = {
    zones = ((getMissionLayerEntities "mrdr")#0) select {_x isKindOf "EmptyDetector"}; publicVariable "zones";
    spawns = ((getMissionLayerEntities "mrdr")#0) select {_x isKindOf "Land_HelipadEmpty_F"}; publicVariable "spawns";
    waitUntil {time > 5};
    [[], {murderer = player; publicVariable "murderer"; murderer addItemToUniform "tsp_meleeWeapon_kabar"}] remoteExec ["call", selectRandom playableUnits]; waitUntil {!isNil "murderer"};
    [[], {detective = player; publicVariable "detective"; detective addItemToUniform "RH_python"; detective addMagazine "RH_6Rnd_357_Mag"}] remoteExec ["call", selectRandom playableUnits select {_x != murderer}];
    while {sleep 1; true} do {  //-- Ending conditions
        if (!alive murderer) exitWith {[[], {"BYSTANDERS" call BIS_fnc_endMission}] remoteExec ["spawn", 0]};                                                          //-- Bystanders win if murderer dead
        if (count (playableUnits select {!isObjectHidden _x && _x != murderer}) == 0) exitWith {[[], {"MURDERER" call BIS_fnc_endMission}] remoteExec ["spawn", 0]};  //-- Murderer win if everyone else dead
        if (time > totalTime) exitWith {[[], {"BYSTANDERS" call BIS_fnc_endMission}] remoteExec ["spawn", 0]};                                                       //-- Bystanders win if time limit reached
    };
    [[], {player switchMove "Acts_Dance_01"}] remoteExec ["spawn", 0];  //-- Dance
};

tsp_fnc_client = {
    params [["_unit", player], ["_text", "Bystander"], ["_colour", [0.05,0.07,0.9,1]], ["_intro", "<t color='#0E12E8' size='4'>You are a bystander</t> <br/><br/><br/><br/><br/><br/><br/><br/><br/> <t color='#0E12E8' size='2'>There is a murderer on the loose <br/> Don't get killed</t>"]];
    
    cutText ["Waiting for players...", "BLACK OUT", 0.001]; [] remoteExec ["tsp_fnc_time", 2]; waitUntil {!isNull _unit && !isNil "timeServer" && !isNil "murderer" && !isNil "detective"};
    if (timeServer > 20) exitWith {["Initialize", [_unit, [], false, true, true, true, true, true, true, true]] call BIS_fnc_EGSpectator; [_unit, true] remoteExec ["hideObjectGlobal", 2]};  //-- Late joiners

    if (_unit == murderer) then {_text = "Murderer"; _colour = [1,0,0,1]; _intro = "<t color='#ff0000' size='4'>You are the murderer</t> <br/><br/><br/><br/><br/><br/><br/><br/><br/> <t color='#ff0000' size='2'>Kill everyone <br/> Don't get caught</t>"};
    if (_unit == detective) then {_text = "Detective"; _intro = "<t color='#0E12E8' size='4'>You are the detective</t> <br/><br/><br/><br/><br/><br/><br/><br/><br/> <t color='#0E12E8' size='2'>There is a murderer on the loose <br/> Find and kill him</t>"};
    cutText [_intro, "BLACK OUT", 0.001, true, true]; sleep 5; cutText ["", "BLACK IN", 1];
    _bottomRight = (findDisplay 46) ctrlCreate ["RscText", 9998]; _bottomRight ctrlSetPosition [safeZoneX + safeZoneW - 0.4, safeZoneY + safeZoneH - 0.3, 0.5, 0.3];    
    _bottomRight ctrlSetFont "PuristaMedium"; _bottomRight ctrlSetText _text; _bottomRight ctrlSetFontHeight 0.1; _bottomRight ctrlSetTextColor _colour; _bottomRight ctrlCommit 0;

    [_unit, zones, "You are out of bounds!", {[_this, zones] spawn tsp_fnc_zone_launch}, {alive _this}, 2, 2] spawn tsp_fnc_zone_create;
    _unit attachTo [selectRandom spawns, [0,0,0]]; detach _unit;
    _unit addEventHandler ["Fired", {player setAmmo ["RH_python", 0]}];
    addMissionEventHandler ["EntityKilled", {  //-- Shooting bysyanders is bad
        params ["_killed", "_killer", "_instigator"];
        if (_killed == murderer || _killer != player) exitWith {};
        _killer call ACE_hitreactions_fnc_throwWeapon;
        _killer spawn {
            _blur = ppEffectCreate ["DynamicBlur", 500]; _blur ppEffectEnable true;
            _blur ppEffectAdjust [2]; _blur ppEffectCommit 1;
            _timeToStop = time + 30; waitUntil {time > _timeToStop || !alive _this};
            _blur ppEffectAdjust [0]; _blur ppEffectCommit 5;
        };
        
    }];
    ["tsp_melee_damageMan", {  //-- Fly away
        params ["_unit", "_victim", "_wasAlive"];
        if (currentWeapon _unit != "tsp_meleeWeapon_kabar") exitWith {};
        [_victim, [(sin (getDir _unit))*30, (cos (getDir _unit))*30, 5]] remoteExec ["setVelocity", _victim];
        _victim spawn {sleep 0.2; _this setDamage 1};
    }] call CBA_fnc_addEventHandler;
    while {sleep 1; (timeServer + time) < totalTime} do {hintSilent parseText ("<t size='2'>" + ([(totalTime - (timeServer + time)), "MM:SS"] call BIS_fnc_secondsToString) + "</t>")};
};

//ace_medical_disabled = true;
totalTime = hideTime + (["totalTime", -1] call BIS_fnc_getParamValue); 
if (isServer) then {[] spawn tsp_fnc_server}; [] spawn tsp_fnc_client;