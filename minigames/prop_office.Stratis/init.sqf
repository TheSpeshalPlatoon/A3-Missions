prop_fnc_time = {prop_time_server = time; publicVariable "prop_time_server"};

prop_fnc_posses = {
    params ["_unit", ["_type", typeOf cursorObject]]; if (_type == "") exitWith {}; 
    if !(_type in prop_whitelist) exitWith {["", "You cannot become that object."] spawn BIS_fnc_showSubtitle};
    ["", "You have become: " + (getText (configFile >> "CfgVehicles" >> _type >> "displayName")) + "."] spawn BIS_fnc_showSubtitle;
    deleteVehicle (_unit getVariable ["prop", objNull]);                    //-- If already a prop, delete it
    _prop = createVehicle [_type, getPosATL _unit, [], 0, "CAN_COLLIDE"];  //-- Create prop
    _unit setVariable ["prop", _prop, true]; _prop attachTo [_unit];
    _unit addUniform "a2_invisible"; _unit addItem "ACRE_PRC343"; _unit allowDamage false;
    [_prop, ["HitPart", {(_this#0) remoteExec ["prop_fnc_hit", attachedTo (_this#0#0)]}]] remoteExec ["addEventHandler", 0];  //-- Damage handler
};

prop_fnc_hit = {
    params ["_object", "_shooter", "_projectile", "_position", "_velocity", "_selection", "_ammo", "_vector", "_radius", "_surfaceType", "_isDirect"];
    _damage = (1 / (((boundingBoxReal _object)#0 distance (boundingBoxReal _object)#1) min 10)) * prop_damage_prop;
    player setVariable ["health", ((player getVariable ["health", 1]) - _damage) max 0, true];
    if (!alive player || player getVariable "health" == 0) then {player setDamage 1; deleteVehicle _object; (name player + " was found by " + name _shooter + ".") remoteExec ["systemChat", 0]};
};

prop_fnc_server = {
    prop_zones = ((getMissionLayerEntities "prop")#0) select {_x isKindOf "EmptyDetector"}; publicVariable "prop_zones";
    prop_propable = ((getMissionLayerEntities "propable")#0); publicVariable "prop_propable";
    prop_whitelist = prop_propable apply {typeOf _x}; publicVariable "prop_whitelist";
    createMarker ["respawn_west", getPos (prop_zones#0)];
    createMarker ["respawn_civilian", getPos (prop_zones#0)];
    sleep 20; while {sleep 1; true} do {
        _props = playableUnits select {!isObjectHidden _x && side _x == civilian};
        _seekers = playableUnits select {!isObjectHidden _x && side _x == west};
        if (count _props < 1) exitWith {[[], {"SEEKER" call BIS_fnc_endMission}] remoteExec ["spawn", 0]};
        if (count _seekers < 1) exitWith {[[], {"PROP2" call BIS_fnc_endMission}] remoteExec ["spawn", 0]};
        if (time > prop_time_total) exitWith {[[], {"PROP" call BIS_fnc_endMission}] remoteExec ["spawn", 0]};
    };
    [[], {player switchMove "Acts_Dance_01"}] remoteExec ["spawn", 0];
};

prop_fnc_client = {    
    cutText ["", "BLACK OUT", 0.000001];
    [] remoteExec ["prop_fnc_time", 2]; waitUntil {sleep 1; !isNull player && !isNil "prop_time_server"};  //-- Get time elapsed since mission start and joining
    if (prop_time_server > 30) exitWith {["Initialize", [player, [], false, true, true, true, true, true, true, true]] call BIS_fnc_EGSpectator; [player, true] remoteExec ["hideObjectGlobal", 2]; cutText ["", "BLACK IN", 1]};  //-- Late joiners
        
    [player, prop_zones, "You are out of bounds!", {[_this, prop_zones] spawn tsp_fnc_zone_launch}, {alive _this}, 2, 2] spawn tsp_fnc_zone;
    player addEventHandler ["Killed", {["Initialize", [player, [], false, true, true, true, true, true, true, true]] call BIS_fnc_EGSpectator}];
    player addEventHandler ["Respawn", {player setPos (getPos (prop_zones#0)); [player, true] remoteExec ["hideObjectGlobal", 2]}];
    player addEventHandler ["Respawn", {if (side player == west) then {[name player + " couldn't handle the pressure"] remoteExec ["systemChat", 0]}}];
     
    if (side player == west) then {player allowDamage false; player enableStamina false};
    
    {_x addEventHandler ["HitPart", {   //-- Damage on shooting lame objects
        (_this#0) params ["_target", "_shooter", "_projectile", "_position", "_velocity", "_selection", "_ammo", "_vector", "_radius", "_surfaceType", "_isDirect", "_instigator"];
        if (isNull attachedTo _target) then {player setVariable ["health", ((player getVariable ["health", 1]) - prop_damage_man) max 0]};
        if (side player == west && player getVariable "health" == 0) then {player setDamage 1};
    }]} forEach prop_propable;

    ace_medical_disabled = true; acex_viewrestriction_mode = 0; ace_medical_gui_enableMedicalMenu = 0; ace_nametags_showPlayerNames = 0; ace_advanced_fatigue_enabled = false;
    tsp_cba_breach_lock_door = 0; tsp_cba_breach_lock_house = 0; tsp_fnc_melee_action = {}; tsp_fnc_animate_tap = {};
    STHud_UIMode = 0; STHud_SettingsAllUnits = false; 
    
    ["ACE3 Common", "ace_interact_menu_InteractKey", "DISABLED", {systemChat "DISABLED"}, {false}, [219, [false, false, false]], false] call CBA_fnc_addKeybind;
    
    while {sleep 0.25; side player == west && (prop_time_server + time) < prop_time_release} do {cutText ["Waiting for props to hide... " + str round (prop_time_release - (prop_time_server + time)), "BLACK OUT", 0.001]};
    cutText ["", "BLACK IN", 3];

    _bottomRight = (findDisplay 46) ctrlCreate ["RscText", 9998]; 
    _bottomRight ctrlSetPosition [safeZoneX + safeZoneW - 0.4, safeZoneY + safeZoneH - 0.3, 0.5, 0.3];    
    _bottomRight ctrlSetFont "PuristaMedium"; 
    _bottomRight ctrlSetText "Health: xx%";
    _bottomRight ctrlSetFontHeight 0.07;
    _bottomRight ctrlSetTextColor [0.988,0.729,0.012,1];
    _bottomRight ctrlCommit 0;
    _bottomRight spawn {while {sleep 0.1; true} do {_this ctrlSetText ("Health: " + str round ((player getVariable ["health", 1])*100) + "%")}};

    if (side player == civilian) then {  //-- PROPS
        cutText ["", "BLACK IN", 1];
        ["", "Press T while aiming at an object to become it."] spawn BIS_fnc_showSubtitle;
        (findDisplay 46) displayAddEventHandler ["KeyDown", {params ["_display", "_key"]; if (_key == 20) then {[player] call prop_fnc_posses}}];
        while {sleep 1; (prop_time_server + time) < prop_time_release} do {hintSilent parseText ("<t size='2' color='#a83232'>" + ([prop_time_release - (prop_time_server + time), "MM:SS"] call BIS_fnc_secondsToString) + "</t>")};
        hint parseText ("<t size='2' color='#a83232'>SEEKERS RELEASED</t>"); sleep 3;
    };

    while {(prop_time_server + time) < prop_time_total} do {hintSilent parseText ("<t size='2'>" + ([prop_time_total - (prop_time_server + time), "MM:SS"] call BIS_fnc_secondsToString) + "</t>"); sleep 1};
};

prop_time_release = ["time_hide", -1] call BIS_fnc_getParamValue;
prop_time_total = prop_time_release + (["time_seek", -1] call BIS_fnc_getParamValue);
prop_damage_prop = (["damage_prop", -1] call BIS_fnc_getParamValue)/100;
prop_damage_man = (["damage_man", -1] call BIS_fnc_getParamValue)/100;

if (isServer) then {[] spawn prop_fnc_server}; [] spawn prop_fnc_client;