if (!isServer) exitWith {};

[
	west, ["zeleno"], "Zeleno MB", "Recapture Zeleno MB from the ChDKZ and rescue any surviving CDF personnel.", "Attack", getPos task_mb, 
	{true}, {"mb_close" call tsp_fnc_sector_check && (count (allUnits select {_x distance task_mb < 100 && side _x == east}) < 2)}
] spawn tsp_fnc_task;
[
	west, ["green"], "Green Mountain", "Recapture Green Mountain from the ChDKZ and rescue any surviving CDF personnel.", "Attack", getPos task_green, 
	{true}, {"green" call tsp_fnc_sector_check && (count (allUnits select {_x distance task_green < 100 && side _x == east}) < 2)}
] spawn tsp_fnc_task;
[
	west, ["school"], "School", "CDF reports indicate a heavy ChDKZ concentration at the school, secure it and neutralize any enemies.", "Attack", getPos task_school, 
	{true}, {"school" call tsp_fnc_sector_check && (count (allUnits select {_x distance task_school < 100 && side _x == east}) < 2)}
] spawn tsp_fnc_task;
[
	west, ["usmc"], "Find USMC Squad", "A USMC squad was stationed at Zeleno MB with the CDF, locate any survivors. Our last contact with them indicates that at least 5 of them fled into town.", "meet", getPos task_police, 
	{true}, {"police_close" call tsp_fnc_sector_check && (count (allUnits select {_x distance task_police < 100 && side _x == east}) < 2)}
] spawn tsp_fnc_task;
