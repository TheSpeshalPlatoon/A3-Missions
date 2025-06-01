if (time > 40) exitWith {["Initialize"] call BIS_fnc_EGSpectator};  //-- Late joiners go to spectate
waitUntil {sleep 1; !isNull findDisplay 46 && !isNil "tsp_start"};  //-- Wait until loaded in
player addEventHandler ["Killed", {["Initialize"] call BIS_fnc_EGSpectator}];
[player, [zone_play], "You are out of bounds!", {_this attachTo [if (side _this == west) then {start_west} else {start_east}, [0,0,0]]; detach _this}, {alive _this}, 1, 1] spawn tsp_fnc_zone;
