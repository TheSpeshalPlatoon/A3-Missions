if (!isServer) exitWith {};

[
	west, ["pilot"], "Rescue Crew", "A UH-60 went down in the AO, rescue 4 crewmen.", 
	"Heli", objNull, {true}, {(!alive task_pilot1 || task_pilot1 distance tsp_spawnCenter < 1000) && (!alive task_pilot2 || task_pilot2 distance tsp_spawnCenter < 1000) && (!alive task_pilot3 || task_pilot3 distance tsp_spawnCenter < 1000) && (!alive task_pilot4 || task_pilot4 distance tsp_spawnCenter < 1000)}, {!alive task_pilot1 && !alive task_pilot2 && !alive task_pilot3 && !alive task_pilot4}
] spawn tsp_fnc_task;
[
	west, ["sawmill"], "Secure Sawmill", "Search and secure the sawmill.", 
	"Attack", getPos task_sawmill, {true}, {"sawmill" call tsp_fnc_sector_check && (count (allUnits select {_x inArea task_sawmill && side _x == east}) < 2)}
] spawn tsp_fnc_task;	
[
	west, ["kamensk"], "Secure Kamensk MB", "Search and secure Kamensk MB.", 
	"Attack", getPos task_kamensk, {true}, {"kamensk" call tsp_fnc_sector_check && (count (allUnits select {_x inArea task_kamensk && side _x == east}) < 2)}
] spawn tsp_fnc_task;