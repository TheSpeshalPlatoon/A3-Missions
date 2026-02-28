if (!isServer) exitWith {};

[west, "primary", ["Main objective is to Secure all hijacked vessels.", "Primary Objectives"], objNull, "CREATED", -1, true, "Boat"] call BIS_fnc_taskCreate;

[
	west, ["liberty", "primary"], "Secure USS Liberty", "<marker name='marker_11'>Board this vessel</marker> and secure it.", 
	"Defend", getPos DDliberty, {true}, {"liberty" call tsp_fnc_sector_check && (count (allUnits select {_x inArea task_liberty && side _x == independent}) < 1)}
] spawn tsp_fnc_task;
[
	west, ["virtuous", "primary"], "Secure USS Virtuous", "Find the vessel and secure it.", 
	"Defend", objNull, {true}, {"virtuous" call tsp_fnc_sector_check && (count (allUnits select {_x inArea task_virtuous && side _x == independent}) < 1)}
] spawn tsp_fnc_task;
[
	west, ["hysilens", "primary"], "Secure LST Hysilens", "<marker name='marker_10'>Board this vessel</marker> and secure it.", 
	"Defend", getPos CChysilens, {true}, {"hysilens" call tsp_fnc_sector_check && (count (allUnits select {_x inArea task_hysilens && side _x == independent}) < 1)}
] spawn tsp_fnc_task;
[
	east, ["mission"], "x", "x", "Attack", objNull, 
	{true}, {count (["liberty","virtuous","hysilens"] select {_x call BIS_fnc_taskState == "SUCCEEDED"}) == 3}, 
	{false}, {false}, {}, {"end2" remoteExec ["BIS_fnc_endMission", 0]}
] spawn tsp_fnc_task;