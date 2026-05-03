createMarker ["respawn_civ", getPos mrdr_zone];  //-- Required for respawn type

if (isServer) then {  //-- SERVER
    mrdr_spawns = ((getMissionLayerEntities "mrdr")#0) select {_x isKindOf "Land_HelipadEmpty_F"}; publicVariable "mrdr_spawns";  //-- Only server can run getMissionLayerEntites, give spawn list to everyone
    
    [] spawn {  //-- Murderer/detective selection and win/lose conditions
        waitUntil {time > 5 && count playableUnits > 1};//
        _allPlayers = playableUnits;                                                    //-- Get all players
        mrdr_murderer = selectRandom _allPlayers; publicVariable "mrdr_murderer";      //-- Select murderer randomly
        _allPlayers deleteAt (_allPlayers findIf {_x == mrdr_murderer});              //-- Remove murderer from _allPlayers
        mrdr_detective = selectRandom _allPlayers; publicVariable "mrdr_detective";  //-- Select detective randomly
        _winner = "";
        while {sleep 3; true} do {
            _allPlayers = playableUnits select {!isObjectHidden _x};
            _allPlayers deleteAt (_allPlayers findIf {_x == mrdr_murderer});  //-- Remove murderer from _allPlayers
            if (count _allPlayers < 1) exitWith {_winner = "MURDERER"};
            if (!alive mrdr_murderer) exitWith {_winner = "BYSTANDERS"};
        };
        [[], {player switchMove "Acts_Dance_01"}] remoteExec ["spawn", 0]; sleep 5;
        if (_winner == "MURDERER") then {[[], {"MURDERER" call BIS_fnc_endMission}] remoteExec ["spawn", 0]} else {[[], {"BYSTANDERS" call BIS_fnc_endMission}] remoteExec ["spawn", 0]};
    };
};

[] spawn {  //-- CLIENT
    cutText ["Waiting for players...", "BLACK OUT", 0.001];  //-- Start with black screen
    waitUntil {!isNil "mrdr_murderer" && !isNull player};   //-- Cause init.sqf executes too early for JIP players
    
    if (time > 20) exitWith {  //-- LATE JOINERS JUST SPECTATE
        cutText ["", "BLACK IN", 1]; [player, true] remoteExec ["hideObjectGlobal", 2];
        ["Initialize", [player, [], false, true, true, true, true, true, true, true]] call BIS_fnc_EGSpectator;
    };
        
    //-- STUFF FOR EVERYONE
    addMissionEventHandler ["EntityKilled", {params ["_killed"]; if (_killed == player) then {["Initialize", [player, [], false, true, true, true, true, true, true, true]] call BIS_fnc_EGSpectator}}];  //-- Spectate when killed
    player addMPEventHandler ["MPRespawn", {[player, true] remoteExec ["hideObjectGlobal", 2]}];                                         //-- Hide new body
    [player, [mrdr_zone], "You are out of bounds!", {[_this, [mrdr_zone]] spawn tsp_fnc_zone_launch}, {alive _this}, 2, 2] spawn tsp_fnc_zone_create;  //-- Zone    
    player attachTo [selectRandom mrdr_spawns, [0,0,0]]; detach player;                                                                //-- Spawn
    player addEventHandler ["Fired", {player setAmmo ["RH_python", 0]}];                                                              //-- One shot magnum
    ace_medical_disabled = true;                                                                                                     //-- No medical

    //-- STUFF THAT DEPENDS ON ROLE
    _bottomRightColour = "";
    _bottomRightText = "";

    //-- Murderer
    if (mrdr_murderer == player) then {
        cutText ["<t color='#ff0000' size='4'>You are the murderer</t> <br/><br/><br/><br/><br/><br/><br/><br/><br/> <t color='#ff0000' size='2'>Kill everyone <br/> Don't get caught</t>", "BLACK OUT", 0.001, true, true];
        _bottomRightColour = [1,0,0,1];
        _bottomRightText = "Murderer";
        player addItemToUniform "tsp_meleeWeapon_kabar";
        [] spawn {while {sleep 1; alive player} do {if (currentWeapon player == "RH_python") then {player call ACE_hitreactions_fnc_throwWeapon}}};  //-- No pistol for murderer
        ["tsp_melee_damageMan", {
            params ["_unit", "_victim"];
            if (currentWeapon _unit != "tsp_meleeWeapon_kabar") exitWith {};  //-- Only with knife
            [_victim, [(sin (getDir _unit))*30, (cos (getDir _unit))*30, 5]] remoteExec ["setVelocity", _victim];
            _victim spawn {sleep 0.2; _this setDamage 1};
        }] call CBA_fnc_addEventHandler;
    };

    //-- Everyone else            
    if (mrdr_murderer != player) then {
        _bottomRightColour = [0.055,0.071,0.91,1];
        if (mrdr_detective == player) then {
            cutText ["<t color='#0E12E8' size='4'>You are the detective</t> <br/><br/><br/><br/><br/><br/><br/><br/><br/> <t color='#0E12E8' size='2'>There is a murderer on the loose <br/> Find and kill him</t>", "BLACK OUT", 0.001, true, true];
            _bottomRightText = "Detective";
            player addItemToUniform "RH_python"; 
            player addMagazine "RH_6Rnd_357_Mag";
        } else {
            cutText ["<t color='#0E12E8' size='4'>You are a bystander</t> <br/><br/><br/><br/><br/><br/><br/><br/><br/> <t color='#0E12E8' size='2'>There is a murderer on the loose <br/> Don't get killed</t>", "BLACK OUT", 0.001, true, true];
            _bottomRightText = "Bystander";
        };
        [] spawn {while {sleep 1; alive player} do {if (currentWeapon player == "RH_python") then {player addMagazine "RH_6Rnd_357_Mag"}}};  //-- No pistol for murderer
        addMissionEventHandler ["EntityKilled", {  //-- Shooting bysyanders is bad
            params ["_killed", "_killer", "_instigator"];
            if (_killed != mrdr_murderer && _killer == player) then {
                player call ACE_hitreactions_fnc_throwWeapon;  //-- Throw weapon
                [] spawn {                                    //-- Blur
                    _blur = ppEffectCreate ["DynamicBlur", 500]; 
                    _blur ppEffectEnable true;
                    _blur ppEffectAdjust [2];
                    _blur ppEffectCommit 1;
                    _timeToStop = time + 30;
                    waitUntil {time > _timeToStop || !alive player};  //-- Remove blur after death or 30 seconds
                    _blur ppEffectAdjust [0];
                    _blur ppEffectCommit 5;
                    sleep 5;
                    _blur ppEffectEnable false;
                };
            };
        }];
    };

    sleep 5;
    cutText ["", "BLACK IN", 1];
    _bottomRight = (findDisplay 46) ctrlCreate ["RscText", 9998]; 
    _bottomRight ctrlSetPosition [safeZoneX + safeZoneW - 0.4, safeZoneY + safeZoneH - 0.3, 0.5, 0.3];    
    _bottomRight ctrlSetFont "PuristaMedium"; 
    _bottomRight ctrlSetText _bottomRightText;
    _bottomRight ctrlSetFontHeight 0.1;
    _bottomRight ctrlSetTextColor _bottomRightColour;
    _bottomRight ctrlCommit 0;
};