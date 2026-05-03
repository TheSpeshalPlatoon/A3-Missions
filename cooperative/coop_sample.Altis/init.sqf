if (!isServer) exitWith {};

[
	west, ["helicopter"], "Destroy Helicopter", "Destroy the WY-55 Hellcat stationed at the enemy FOB.", "Destroy", getPos task_helicopter, 
	{true}, {!alive ("task_helicopter" call tsp_fnc_sector_variable)}
] spawn tsp_fnc_task;
[
	west, ["fob"], "Capture FOB", "This FOB is a prominent AAF position on Altis. Capture it and clear the surrounding area of enemy combatants.", "Attack", getPos task_fob, 
	{true}, {"fob_close" call tsp_fnc_sector_check && (count (allUnits select {_x inArea task_fob && side _x == resistance}) < 2)}
] spawn tsp_fnc_task;
[
	west, ["fob_defend"], "Defend FOB", "Enemy reinforcements have been spotted, hold the FOB!", "Defend", getPos task_fob, 
	{"fob" call BIS_fnc_taskState == "SUCCEEDED"},{!isNil "task_fob_bool" && (count (allUnits select {_x inArea task_fob_defend && side _x == resistance}) < 2)}, {false}, {false}, 
	{["fob_reinf"] spawn tsp_fnc_sector_load; [] spawn {sleep 30; task_fob_bool = true}}
] spawn tsp_fnc_task;
[
	west, ["pow"], "Rescue POW", "There is a possibilty that a friendly POW is being held at the site, return them him friendly lines if possible", "Meet", objNull, 
	{true}, {count ([spawn_camp] select {_x distance ("task_pow" call tsp_fnc_sector_variable) < 50}) > 0}, 
	{!alive ("task_pow" call tsp_fnc_sector_variable)}
] spawn tsp_fnc_task;
[
	east, ["mission"], "x", "x", "Attack", getPos task_fob,
	{true}, {"pow" call BIS_fnc_taskState in ["SUCCEEDED", "FAILED"] && count (["helicopter","fob","fob_defend"] select {_x call BIS_fnc_taskState == "SUCCEEDED"}) == 3}, 
	{count (playableUnits select {!isObjectHidden _x}) == 0}, {false}, 
	{}, {"end1" remoteExec ["BIS_fnc_endMission", 0]}, {"end2" remoteExec ["BIS_fnc_endMission", 0]}
] spawn tsp_fnc_task;