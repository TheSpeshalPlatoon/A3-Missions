if (!isNil "loadout") then {player setUnitLoadout loadout}; 

action_start = [   
	player, "Start", "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_takeOff1_ca.paa", "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_takeOff1_ca.paa",   
	"serverCommandAvailable '#kick' && isNil 'missionStarted'", "true", {}, {}, {missionStarted = true; publicVariable "missionStarted"}, {}, [], 3, 1000
] call BIS_fnc_holdActionAdd;

player allowDamage false; 

waitUntil {!isNil "missionStarted" || !alive player}; 
if (missionStarted) then {
    player allowDamage true;
    player attachTo [(if (side player == west) then {spawn_west} else {spawn_east}), [0,0,0]]; detach player;
    player addEventHandler ["GetInMan", {  //-- Handle vehicle loss
        params ["_unit", "_role", "_vehicle", "_turret"];
        _vehicle spawn {while {sleep 1; alive _this} do {if (!(alive driver _this) || (getPosATL _this)#2 < 5) then {if (driver _this isEqualTo objNull) exitWith {}; driver _this setDamage 1; _this setDamage 1}}};
        [_vehicle, false] remoteExec ["allowDamage", 0];
        _vehicle removeAllEventHandlers "Killed";
        _vehicle addEventHandler ["Killed", {
            params ["_vehicle", "_killer", "_instigator", "_useEffects"];
            if (_killer in playableUnits) then {_killer setVariable ["kills", _killer getVariable ["_kills", 0] + 1]}; [] remoteExec ["tsp_fnc_score", 0];
            if (side group _vehicle == west) then {points_east = points_east + 1; publicVariable "points_east"};
            if (side group _vehicle == east) then {points_west = points_west + 1; publicVariable "points_west"};
            if (driver _killer isEqualTo driver _vehicle && driver _vehicle isNotEqualTo objNull) exitWith {["["+str side group _vehicle+"] "+name _vehicle+" crashed."] remoteExec ["systemChat", 0]};
            ["["+str side group _vehicle+"] "+name _vehicle+" was shot down by ["+str side group _killer+"] "+name _killer+"."] remoteExec ["systemChat", 0];
        }];
    }];
};

waitUntil {player inArea AO || !alive player};
if (player inArea AO) then {
    [player, [AO], "You are leaving the AO!", "You are back in the AO!", {vehicle _this setFuel 0}, {vehicle _this setFuel 1}, {alive _this}, 1, 5] spawn tsp_fnc_zone;
    ["["+str side player+"] "+name player+" has entered the AO!"] remoteExec ["systemChat", 0];
    [vehicle player, true] remoteExec ["allowDamage", 0];
};

