if (!isServer) exitWith {};

[
	west, ["bridge"], "Pontoon Bridge", "The Russian's are getting their vehicles across somehow, command beleives there is a pontoon bridge in this area, find and destroy it.", 
	"Destroy", getPos task_bridge1, {true}, {"bridge1" call tsp_fnc_sector_check && (count (allUnits select {_x inArea task_bridge1 && side _x == east}) < 2)}
] spawn tsp_fnc_task;
[
	west, ["aaa"], "Destroy AAA", "Intel indicates that there may be anti-air at the airfield, search for it and destroy it.", 
	"Destroy", getPos task_aaa, {true}, {!alive task_aaa}
] spawn tsp_fnc_task;
[
	west, ["factory"], "Disrupt Operations", "There is a large Russian concentration around this factory, command beleives they are using it as a staging area for an eventual assault, make some noise and delay their plans.", 
	"Attack", getPos task_factory, {true}, {"factory" call tsp_fnc_sector_check && (count (allUnits select {_x inArea task_factory && side _x == east}) < 8)}
] spawn tsp_fnc_task;
[
	west, ["hq"], "Headquarters", "There is possibly a Russian command unit at this location, find it and capture it.", 
	"Attack", getPos task_hq, {true}, {"hq" call tsp_fnc_sector_check && (count (allUnits select {_x inArea task_hq && side _x == east}) < 6)}
] spawn tsp_fnc_task;