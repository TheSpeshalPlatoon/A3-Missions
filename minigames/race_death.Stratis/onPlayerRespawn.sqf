if (player getVariable ["pilot", false]) exitWith {};  //-- Helicopter pilot doesn't need any scrrripts

[] spawn {
	[[], {race_zones = ((getMissionLayerEntities "zones")#0) select {_x isKindOf "EmptyDetector"}; publicVariable "race_zones"}] remoteExec ["call", 2];  //-- Server
	waitUntil {!isNil "race_zones"}; [player, race_zones, "You are off the track!", {(vehicle _this) setDamage 1; _this setDamage 1}, {alive _this}, 1, 1] spawn tsp_fnc_zone;  //-- Zones
	waitUntil {player distance tsp_start < 5}; waitUntil {player distance tsp_start > 10};
	_startTime = time;
	while {sleep 1; alive player} do {
		hint parseText ("<t size='2' color='#a83232'>" + ([time - _startTime, "MM:SS"] call BIS_fnc_secondsToString) + "</t>");  //-- Show time elapsed
		if (player inArea tsp_finish) exitWith {[player, time - _startTime] remoteExec ["tsp_fnc_time", 2]};
	};
};

action_start = [   
	player, "Start", "\a3\ui_f_oldman\data\IGUI\Cfg\holdactions\refuel_ca.paa", "\a3\ui_f_oldman\data\IGUI\Cfg\holdactions\refuel_ca.paa",   
	"serverCommandAvailable '#kick'", "true", {}, {}, {[[], {{_x setFuel 1} forEach vehicles}] remoteExec ["call",0]; ["RACE STARTED!"] remoteExec ["systemChat", 0]}, {}, [], 3, 1000
] call BIS_fnc_holdActionAdd;

action_repair = [
    player, "Repair", "\a3\ui_f_oldman\data\IGUI\Cfg\holdactions\repair_ca.paa", "\a3\ui_f_oldman\data\IGUI\Cfg\holdactions\repair_ca.paa",   
    "vehicle player != player", "true", {}, {}, {vehicle player setDamage 0}, {}, [], 3, 1000, false
] call BIS_fnc_holdActionAdd;

action_flip = [
    player, "Unflip", "\a3\data_f_destroyer\data\UI\IGUI\Cfg\holdactions\holdAction_loadVehicle_ca.paa", "\a3\data_f_destroyer\data\UI\IGUI\Cfg\holdactions\holdAction_loadVehicle_ca.paa",   
    "vehicle player != player", "true", {}, {}, {vehicle player setVectorUp [0,0,1]; vehicle player setposATL [getposATL (vehicle player)#0, getposATL (vehicle player)#1, (getposATL (vehicle player)#2) + 2]}, {}, [], 3, 1000, false
] call BIS_fnc_holdActionAdd;

player addEventHandler ["GetInMan", {params ["_unit", "_role", "_vehicle", "_turret"]; _vehicle allowDamage false}];  //-- No damage
player addEventHandler ["Respawn", {params ["_unit", "_corpse"]; _unit attachTo [spawnPos, [0,0,0]]; detach _unit}];