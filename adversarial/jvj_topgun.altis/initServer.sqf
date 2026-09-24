points_east = 0; publicVariable "points_east";
points_west = 0; publicVariable "points_west";
waitUntil {!isNil "missionStarted"};
heli_west addEventHandler ["Killed", {
	params ["_unit", "_killer", "_instigator", "_useEffects"];
    points_east = points_east + 1; publicVariable "points_east"; [] remoteExec ["tsp_fnc_score", 0];
    ["Blufor's helicopter was destroyed by ["+str side _killer+"] "+name _killer+"."] remoteExec ["systemChat", 0];
}];
heli_east addEventHandler ["Killed", {
	params ["_unit", "_killer", "_instigator", "_useEffects"];
    points_west = points_west + 1; publicVariable "points_west"; [] remoteExec ["tsp_fnc_score", 0];
    ["Opfor's helicopter was destroyed by ["+str side _killer+"] "+name _killer+"."] remoteExec ["systemChat", 0];
}];
[10, 0, 1, {[[], {
    _highest = 0; _winner = objNull;
    {if (_x getVariable ["kills", 0] > _highest) then {_highest = _x getVariable ["kills", 0]; _winner = _x}} forEach playableUnits;
    systemChat ("["+str side _winner+"] "+name _winner+" got the most kills: "+str _highest+".");
    [] remoteExec ["tsp_fnc_score", 0]; sleep 2;
    if (points_west == points_east) then {"TIE" call BIS_fnc_endMission};
    if (points_west > points_east) then {"WEST" call BIS_fnc_endMission};
    if (points_west > points_east) then {"EAST" call BIS_fnc_endMission};
}] remoteExec ["spawn", 0]}] spawn tsp_fnc_countDown;