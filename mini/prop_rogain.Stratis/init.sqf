//-- FUNCTIONS
    prop_fnc_becomeObject = {
        params ["_unit", ["_type", typeOf cursorObject]];

        if (_type == "") exitWith {};
        if !(_type in prop_whitelist) exitWith {["", "You cannot become that object."] spawn BIS_fnc_showSubtitle};

        ["", "You have become: " + (getText (configFile >> "CfgVehicles" >> _type >> "displayName")) + "."] spawn BIS_fnc_showSubtitle;
        _oldProp = _unit getVariable ["prop", "NOTHING"];
        if !(_oldProp isEqualTo "NOTHING") then {deleteVehicle _oldProp};         //-- If already a prop, delete it
        _object = createVehicle [_type, getPosATL _unit, [], 0, "CAN_COLLIDE"];  //-- Create prop
        _unit addUniform "a2_invisible";                                        //-- Hide unit
        _unit addItem "ACRE_PRC343";                                           //-- Give back radio
        _object attachTo [_unit];                                             //-- Attach prop to unit
        _unit setVariable ["prop", _object, true];                           //-- Declare prop for later use
        _unit allowDamage false;                                            //-- We have our own damage system for props
        [_object, ["HitPart", {(_this#0) remoteExec ["prop_fnc_hit", _this#0#0]}]] remoteExec ["addEventHandler", 0];
    };

    prop_fnc_hit = {
        params ["_object", "_shooter", "_projectile", "_position", "_velocity", "_selection", "_ammo", "_vector", "_radius", "_surfaceType", "_isDirect"];
        _unit = player;
        _unit setVariable ["health", (_unit getVariable ["health", 1]) - prop_damageProp];
        if (!alive _unit || (_unit getVariable ["health", 1]) < 0.1) then {
            _unit setDamage 1;
            _unit setVariable ["health", 999, true];
            deleteVehicle _object;
            (name _unit + " was found by " + name _shooter + ".") remoteExec ["systemChat", 0];
        };
    };

    prop_fnc_serverTime = {serverTimeOnJoining = time; publicVariable "serverTimeOnJoining"};



//-- DECLARATIONS
    prop_whitelist = [
        "Land_CncBarrier_F",
        "Land_BarrelEmpty_F",
        "Land_Wreck_Hunter_F",
        "Land_MetalBarrel_empty_F",
        "Land_Cargo20_military_green_F",
        "Land_GarbageContainer_closed_F",
        "Land_TyreBarrier_01_F",
        "Windsock_01_F",
        "Land_JunkPile_F",
        "Land_Pallets_F",
        "Land_GarbageContainer_open_F",
        "Land_PlasticCase_01_large_olive_F",
        "land_gm_euro_furniture_bed_02",
        "Land_Wreck_Hunter_F",
        "Land_WaterBarrel_F",
        "Box_NATO_AmmoOrd_F",
        "B_supplyCrate_F",
        "Box_NATO_Grenades_F",
        "Land_PortableCabinet_01_4drawers_olive_F",
        "Land_TripodScreen_01_large_F",
        "Land_PortableCabinet_01_closed_olive_F",
        "Land_CampingChair_V1_F",
        "Land_PortableDesk_01_olive_F",
        "Land_MultiScreenComputer_01_black_F",
        "Land_PortableGenerator_01_F",
        "Land_TripodScreen_01_dual_v2_F",
        "MapBoard_stratis_F",
        "MapBoard_altis_F",
        "Land_CampingTable_F",
        "Land_CampingChair_V2_F"
    ];
    prop_releaseTime = ["hideTime", -1] call BIS_fnc_getParamValue;
    prop_runTime = prop_releaseTime + (["seekTime", -1] call BIS_fnc_getParamValue);
    prop_damageProp = (["damage_prop", -1] call BIS_fnc_getParamValue)/100;
    prop_damageMan = (["damage_man", -1] call BIS_fnc_getParamValue)/100;


//-- INIT
    createMarker ["respawn_civ", getPos prop_zone];  //-- Required for respawn type

    //-- SERVER
        if (isServer) then {
            prop_spawns = ((getMissionLayerEntities "prop")#0) select {_x isKindOf "Land_HelipadEmpty_F"}; publicVariable "prop_spawns";  //-- Only server can run getMissionLayerEntites, give spawn list to everyone
            prop_propable = ((getMissionLayerEntities "prop_propable")#0); publicVariable "prop_propable";

            [] spawn {  //-- Win/lose conditions
                while {sleep 1; true} do {
                    _allPlayers = playableUnits;
                    _allAlivePlayers = _allPlayers select {_x getVariable ["alive", true]}; 
                    _allProps = _allAlivePlayers select {side _x == civilian};
                    _allSeekers = _allAlivePlayers select {side _x == west};
                    if (count _allProps < 1) exitWith {[[], {"SEEKER" call BIS_fnc_endMission}] remoteExec ["spawn", 0]};
                    if (count _allSeekers < 1) exitWith {[[], {"PROP2" call BIS_fnc_endMission}] remoteExec ["spawn", 0]};
                    if (time > prop_runTime) exitWith {[[], {"PROP" call BIS_fnc_endMission}] remoteExec ["spawn", 0]};
                };
                [[], {player switchMove "Acts_Dance_01"}] remoteExec ["spawn", 0];
            };
        };

    //-- CLIENT
    [] spawn {
        cutText ["", "BLACK OUT", 0.000001];                                                   //-- Start black
        waitUntil {!isNull player && time > 3};                                               //-- Cause init.sqf executes too early for JIP players
        [] remoteExec ["prop_fnc_serverTime", 2]; waitUntil {!isNil "serverTimeOnJoining"};  //-- Get time elapsed since mission start and joining
            
        //-- LATE JOINERS JUST SPECTATE
            if ((serverTimeOnJoining + time) > 29) exitWith {
                cutText ["", "BLACK IN", 1];
                [player, true] remoteExec ["hideObjectGlobal", 2];
                ["Initialize", [player, [], false, true, true, true, true, true, true, true]] call BIS_fnc_EGSpectator;
            };
            
        //-- STUFF FOR EVERYONE            
            player addMPEventHandler ["MPRespawn", {
                if (side player == west) then {[name player + " couldn't handle the pressure"] remoteExec ["systemChat", 0]};  //-- Death message
                [player, true] remoteExec ["hideObjectGlobal", 2];                                                            //-- Declare not alive
                player setVariable ["alive", false, true];                                                                   //-- Hide after spawning
            }];
            addMissionEventHandler ["EntityKilled", {if (_this#0 == player) then {["Initialize", [player, [], false, true, true, true, true, true, true, true]] call BIS_fnc_EGSpectator}}];  //-- Spectate when killed
            [player, [prop_zone], "You are out of bounds!", {[_this, [prop_zone]] spawn tsp_fnc_zone_launch}, 2, 2] spawn tsp_fnc_zone_create;                                               //-- Zone              
            {   //-- Damage on shooting lame objects
                _x addEventHandler ["HitPart", {
                    player setHitPointDamage ["hitHead", ((player getHitPointDamage "hitHead") + prop_damageMan)]; 
                    player setVariable ["health", (1 - (player getHitPointDamage "hitHead"))];
                }]
            } forEach prop_propable;

            ace_medical_disabled = true;
            tsp_cba_fps = false;   
            
            //-- HEALTH BAR
            _bottomRight = (findDisplay 46) ctrlCreate ["RscText", 9998]; 
            _bottomRight ctrlSetPosition [safeZoneX + safeZoneW - 0.4, safeZoneY + safeZoneH - 0.3, 0.5, 0.3];    
            _bottomRight ctrlSetFont "PuristaMedium"; 
            _bottomRight ctrlSetText "Health: xx%";
            _bottomRight ctrlSetFontHeight 0.07;
            _bottomRight ctrlSetTextColor [0.988,0.729,0.012,1];
            _bottomRight ctrlCommit 0;
            [_bottomRight] spawn {
                params ["_bottomRight"];                 while {sleep 0.1; alive player} do {_bottomRight ctrlSetText ("Health: " + str ((player getVariable ["health", 1])*100) + "%")}};

        //-- STUFF THAT DEPENDS ON ROLE
            if (side player == west) then {  //-- SEEKER
                while {(serverTimeOnJoining + time) < prop_releaseTime} do {cutText [("Waiting for props to hide... " + str round (prop_releaseTime - (serverTimeOnJoining + time))), "BLACK OUT", 0.001]; sleep 0.25};
                cutText ["", "BLACK IN", 3];
            };

            if (side player == civilian) then {  //-- PROPS
                cutText ["", "BLACK IN", 1];
                player attachTo [selectRandom prop_spawns, [0,0,0]]; detach player;  //-- Spawn
                sleep 2;
                tsp_cba_fps = false; 
                ["", "Press T while aiming at an object to become it."] spawn BIS_fnc_showSubtitle;
                (findDisplay 46) displayAddEventHandler ["KeyDown", {params ["_displayorcontrol", "_key", "_shift", "_ctrl", "_alt"]; if (_key == 20) then {[player] call prop_fnc_becomeObject}}];
                while {(serverTimeOnJoining + time) < prop_releaseTime} do {hintSilent parseText ("<t size='2' color='#a83232'>" + ([(prop_releaseTime - (serverTimeOnJoining + time)), "MM:SS"] call BIS_fnc_secondsToString) + "</t>"); sleep 1};
                hint parseText ("<t size='2' color='#a83232'>SEEKERS RELEASED</t>");
                sleep 2;
            };

            while {(serverTimeOnJoining + time) < prop_runTime} do {hintSilent parseText ("<t size='2'>" + ([(prop_runTime - (serverTimeOnJoining + time)), "MM:SS"] call BIS_fnc_secondsToString) + "</t>"); sleep 1};
    };

