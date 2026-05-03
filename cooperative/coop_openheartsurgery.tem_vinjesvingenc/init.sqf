if (!isServer) exitWith {};

[
	west, ["fob"], "Secure FOB", "Secure the enemy-held FOB.", 
	"Attack", getPos task_base_close, {true}, {"base_close" call tsp_fnc_sector_check && (count (allUnits select {_x inArea task_base_close && side _x == east}) < 2)}, {false}, {false},
	{}, {["reinf"] call tsp_fnc_sector_load}
] spawn tsp_fnc_task;
[
	west, ["hvt", "fob"], "Kill/Capture Officer", "Kill/capture high ranking MSV officer.", 
	"Kill", objNull, {true}, {task_hvt distance campPos < 100 || !alive task_hvt}, {false}
] spawn tsp_fnc_task;
[
	west, ["radar1"], "Destroy Radar", "Destroy the secondary radar near Smorklepp.", 
	"Destroy", objNull, {true}, {!alive task_radar1}, {false}
] spawn tsp_fnc_task;
[
	west, ["radar2","fob"], "Destroy Radar", "Destroy the secondary radar in the enemy FOB.", 
	"Destroy", objNull, {true}, {!alive task_radar2}, {false}
] spawn tsp_fnc_task;
