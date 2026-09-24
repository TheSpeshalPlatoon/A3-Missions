if (!isServer) exitWith {};

[
	west, ["zeleno"], "Zeleno MB", "Recapture Zeleno MB from the ChDKZ and rescue any surviving CDF personnel.", "Attack", "sector_mb", 
	{true}, {["mb_close", "", sector_mb, 100] call tsp_fnc_sector_clear}
] spawn tsp_fnc_task;
[
	west, ["green"], "Green Mountain", "Recapture Green Mountain from the ChDKZ and rescue any surviving CDF personnel.", "Attack", "sector_green", 
	{true}, {["green", "", sector_green, 100] call tsp_fnc_sector_clear}
] spawn tsp_fnc_task;
[
	west, ["school"], "School", "CDF reports indicate a heavy ChDKZ concentration at the school, secure it and neutralize any enemies.", "Attack", "sector_school", 
	{true}, {["school", "", sector_school, 100] call tsp_fnc_sector_clear}
] spawn tsp_fnc_task;
[
	west, ["usmc"], "Find USMC Squad", "A USMC squad was stationed at Zeleno MB with the CDF, locate any survivors. Our last contact with them indicates that at least 5 of them fled into town.", "meet", "sector_police_close", 
	{true}, {["police_close", "", sector_police_close, 100] call tsp_fnc_sector_clear}
] spawn tsp_fnc_task;
