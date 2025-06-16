if (!isServer) exitWith {};

[
	west, ["radar1"], "Destroy Radar", "Destroy the secondary radar at near Smorklepp.", 
	"Destroy", objNull, {true}, {!alive task_radar1}, {false}
] spawn tsp_fnc_task;
[
	west, ["radar2"], "Destroy Radar", "Destroy the secondary radar in the enemy FOB.", 
	"Destroy", objNull, {true}, {!alive task_radar2}, {false}
] spawn tsp_fnc_task;
[
	west, ["fob"], "Secure FOB", "Secure the enemy-held FOB.", 
	"Attack", getPos task_base_close, {true}, {(tsp_sector_info select {_x#0 == "task_base_close"})#0#1 && (count (allUnits select {_x inArea task_base_close && side _x == east}) < 2)}, {false}
] spawn tsp_fnc_task;