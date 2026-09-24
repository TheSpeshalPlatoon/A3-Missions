if (!isServer) exitWith {};

[
	west, ["bridge"], "Pontoon Bridge", "The Russian's are getting their vehicles across somehow, command believes there is a pontoon bridge in this area, find and destroy it.", 
	"Destroy", getPos task_bridge, {true}, {["bridge1", "", sector_bridge1, 0, 2] call tsp_fnc_sector_clear}
] spawn tsp_fnc_task;
[
	west, ["aaa"], "Destroy AAA", "Intel indicates that there may be anti-air at the airfield, search for it and destroy it.", 
	"Destroy", "sector_airfield", {true}, {!alive task_aaa}
] spawn tsp_fnc_task;
[
	west, ["factory"], "Disrupt Operations", "There is a large Russian concentration around this factory, command beleives they are using it as a staging area for an eventual assault, make some noise and delay their plans.", 
	"Attack", "sector_factory", {true}, {["factory", "", sector_factory, 0, 8] call tsp_fnc_sector_clear}
] spawn tsp_fnc_task;
[
	west, ["hq"], "Headquarters", "There is possibly a Russian command unit at this location, find it and capture it.", 
	"Attack", "sector_hq", {true}, {["hq", "", sector_hq, 0, 4] call tsp_fnc_sector_clear}
] spawn tsp_fnc_task;