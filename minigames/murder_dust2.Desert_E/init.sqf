mrdr_fnc_server = {
    mrdr_spawns = ((getMissionLayerEntities "mrdr")#0) select {_x isKindOf "Land_HelipadEmpty_F"}; publicVariable "mrdr_spawns";  //-- Only server can run getMissionLayerEntites
    mrdr_zones = ((getMissionLayerEntities "mrdr")#0) select {_x isKindOf "EmptyDetector"}; publicVariable "mrdr_zones";

    waitUntil {time > 5 && count playableUnits > 1};
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
    [[], {player switchMove "Acts_Dance_01"}] remoteExec ["spawn", 0]; sleep 2;
    if (_winner == "MURDERER") then {[[], {"MURDERER" call BIS_fnc_endMission}] remoteExec ["spawn", 0]} else {[[], {"BYSTANDERS" call BIS_fnc_endMission}] remoteExec ["spawn", 0]};
};

mrdr_fnc_client = {
    if (!isNil "mrdr_murderer") exitWith {["Initialize", [player, [], false, true, true, true, true, true, true, true]] call BIS_fnc_EGSpectator; [player, true] remoteExec ["hideObjectGlobal", 2]};  //-- Late joiners
    cutText ["Waiting for players...", "BLACK OUT", 0.001];  //-- Start with black screen
    waitUntil {!isNil "mrdr_murderer" && !isNull player};   //-- Cause init.sqf executes too early for JIP players
        
    player addMPEventHandler ["MPKilled", {params ["_unit"]; if (_unit == player) then {["Initialize", [player, [], false, true, true, true, true, true, true, true]] call BIS_fnc_EGSpectator}}];
    player addMPEventHandler ["MPRespawn", {params ["_unit"]; if (_unit == player) then {[player, true] remoteExec ["hideObjectGlobal", 2]}}];  //-- Hide new body
    [player, mrdr_zones, "You are out of bounds!", {[_this, mrdr_zones] spawn tsp_fnc_zone_launch}, {alive _this}, 2, 2] spawn tsp_fnc_zone;
    player addEventHandler ["Fired", {player setAmmo ["RH_python", 0]; if (currentWeapon player == "RH_python") then {player addMagazine "RH_6Rnd_357_Mag"}}];  //-- One shot magnum
    player attachTo [selectRandom mrdr_spawns, [0,0,0]]; detach player;  //-- Spawn
    STHud_UIMode = 0; STHud_SettingsAllUnits = false; ace_medical_disabled = true;

    _bottomRightColour = "";
    _bottomRightText = "";
    if (player == mrdr_murderer) then {  //-- Murderer
        cutText ["<t color='#ff0000' size='4'>You are the murderer</t> <br/><br/><br/><br/><br/><br/><br/><br/><br/> <t color='#ff0000' size='2'>Kill everyone <br/> Don't get caught</t>", "BLACK OUT", 0.001, true, true];
        _bottomRightColour = [1,0,0,1];
        _bottomRightText = "Murderer";
        player addItemToUniform "tsp_meleeWeapon_kitchen";
        [] spawn {while {sleep 1; alive player} do {if (currentWeapon player == "RH_python") then {player call ACE_hitreactions_fnc_throwWeapon}}};  //-- No pistol for murderer
        ["tsp_melee_damageMan", {
            params ["_unit", "_victim"];
            if (currentWeapon _unit != "tsp_meleeWeapon_kitchen") exitWith {};  //-- Only with knife
            [_victim, [(sin (getDir _unit))*30, (cos (getDir _unit))*30, 5]] remoteExec ["setVelocity", _victim];
            _victim spawn {sleep 0.2; _this setDamage 1};
        }] call CBA_fnc_addEventHandler;
    } else {  //-- Everyone else
        _bottomRightColour = [0.055,0.07,0.9,1];
        if (mrdr_detective == player) then {
            cutText ["<t color='#0E12E8' size='4'>You are the detective</t> <br/><br/><br/><br/><br/><br/><br/><br/><br/> <t color='#0E12E8' size='2'>There is a murderer on the loose <br/> Find and kill him</t>", "BLACK OUT", 0.001, true, true];
            _bottomRightText = "Detective";
            player addItemToUniform "RH_python"; player addMagazine "RH_6Rnd_357_Mag";
        } else {
            cutText ["<t color='#0E12E8' size='4'>You are a bystander</t> <br/><br/><br/><br/><br/><br/><br/><br/><br/> <t color='#0E12E8' size='2'>There is a murderer on the loose <br/> Don't get killed</t>", "BLACK OUT", 0.001, true, true];
            _bottomRightText = "Bystander";
        };
        addMissionEventHandler ["EntityKilled", {  //-- Shooting bysyanders is bad
            params ["_killed", "_killer", "_instigator"];
            if (_killer == player && _killed == mrdr_murderer) exitWith {};
            player call ACE_hitreactions_fnc_throwWeapon;  //-- Throw weapon
            [] spawn {                                    //-- Blur
                _blur = ppEffectCreate ["DynamicBlur", 500]; _blur ppEffectEnable true; 
                _blur ppEffectAdjust [2]; _blur ppEffectCommit 1;
                _timeToStop = time + 30; waitUntil {time > _timeToStop || !alive player};  //-- Remove blur after death or 30 seconds
                _blur ppEffectAdjust [0]; _blur ppEffectCommit 5;
                sleep 5; _blur ppEffectEnable false;
            };
        }];
    };

    cutText ["", "BLACK IN", 1];
    _bottomRight = (findDisplay 46) ctrlCreate ["RscText", 9998]; 
    _bottomRight ctrlSetPosition [safeZoneX + safeZoneW - 0.4, safeZoneY + safeZoneH - 0.3, 0.5, 0.3];    
    _bottomRight ctrlSetFont "PuristaMedium"; 
    _bottomRight ctrlSetText _bottomRightText;
    _bottomRight ctrlSetFontHeight 0.1;
    _bottomRight ctrlSetTextColor _bottomRightColour;
    _bottomRight ctrlCommit 0;
};

createMarker ["respawn_civ", getPos player];  //-- Required for respawn type

if (isServer) then {[] spawn mrdr_fnc_server}; [] spawn mrdr_fnc_client;