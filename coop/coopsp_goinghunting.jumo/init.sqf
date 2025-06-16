if (!isServer) exitWith {};

[west, "primary", ["Main objective is to Advance And Secure towards the main bridge.", "Primary Objectives"], objNull, "CREATED", -1, true, "Rifle"] call BIS_fnc_taskCreate;
[west, "secondary", ["Secondary objectives are optional but you should still try to complete them. You won't fail the mission if you ignore them, but promotions and other rewards might be slow in coming.", "Secondary Objectives"], objNull, "CREATED", -1, true, "Target"] call BIS_fnc_taskCreate;

[
    west, ["algonquin", "primary"], "Advance to Algonquin", "Advance And Report if <marker name='marker_13'>Algonquin</marker> is secure.", 
    "Move", getPos algo, {true}, {false}, {false}, {count (playableUnits select {_x inArea albonquin}) > 0}
] spawn tsp_fnc_task;
[
	west, ["westminster", "primary"], "Advance to Westminster", "Advance And Report if <marker name='marker_16'>Westminster</marker> is secure.", 
	"Move", getPos wesstm, {true},  {(tsp_sector_info select {_x#0 == "gasstation"})#0#1 && (count (allUnits select {_x inArea trigger_wetsmister && side _x == east}) < 1)}
] spawn tsp_fnc_task;
[
	west, ["alderney", "primary"], "Advance to Alderney", "Advance And Report if <marker name='marker_12'>Alderney</marker> is secure.", 
	"Move", getPos alder, {true}, {(tsp_sector_info select {_x#0 == "mansion_in"})#0#1 && (count (allUnits select {_x inArea trigger_alderney && side _x == east}) < 1)}
] spawn tsp_fnc_task;
[
	west, ["schottler", "primary"], "Secure Schottler", "Advance And Secure <marker name='marker_14'>Schottler</marker>.", 
	"Attack", getPos scjte, {true}, {(tsp_sector_info select {_x#0 == "jumo"})#0#1 && (count (allUnits select {_x inArea trigger_schottler && side _x == east}) < 1)}
] spawn tsp_fnc_task;
[
	west, ["schottler_defend", "primary"], "Defend Schottler", "Enemy reinforcements have been spotted, hold Schottler!", "Defend", getPos steinwa, 
	{"schottler" call BIS_fnc_taskState == "SUCCEEDED"},{!isNil "task_schott_bool" && (count (allUnits select {_x inArea trigger_schottler && side _x == east}) < 2)}, {false}, {false}, 
	{["qrf_jumo"] spawn tsp_fnc_sector_load; [] spawn {sleep 120; task_schott_bool = true}}
] spawn tsp_fnc_task;
[
	west, ["steinway", "primary"], "Secure Steinway", "Advance And Secure <marker name='marker_15'>Steinway</marker>.", 
	"Attack", getPos steinwa, {true}, {(tsp_sector_info select {_x#0 == "staging"})#0#1 && (count (allUnits select {_x inArea trigger_steinway && side _x == east}) < 1)}
] spawn tsp_fnc_task;
[
	west, ["crashsite", "secondary"], "Locate Crashsite", "A C-130 was shot down carrying a stryker attached to our battalion, apparently it crash landed somewhere near one of our objectives but we weren't able to get anymore info. Find the crash site and survivors if there are any.", 
	"Scout", objNull, {true}, {count (playableUnits select {_x inArea trigger_crash}) > 0}
] spawn tsp_fnc_task;
[
	west, ["crashsite_defend", "secondary"], "Defend Crashsite", "Enemy reinforcements have been spotted, hold the crashsite!", "Defend", getPos bracshs, 
	{"crashsite" call BIS_fnc_taskState == "SUCCEEDED"},{!isNil "task_crash_bool" && (count (allUnits select {_x inArea carshusity && side _x == east}) < 2)}, {false}, {false}, 
	{["qrf_crash"] spawn tsp_fnc_sector_load; [] spawn {sleep 30; task_crash_bool = true}}
] spawn tsp_fnc_task;
[
	west, ["aa", "secondary"], "Destroy Anti-Air", "Two ZU-23s are harassing our CAS aircraft in the AO, they're both located along the western coastline and one of them is reported to be rearming to a nearby supply depot that the other gun is stationed at. Destroy the guns and their transport if they're being carried. We need these two destroyed ASAP.", 
	"Destroy", objNull, {true}, {!alive task_aa1 && !alive task_aa2}
] spawn tsp_fnc_task;
[
	west, ["officer", "secondary"], "Eliminate Officer", "Our drones show that a high ranking officer is currently in <marker name='marker_15'>Steinway</marker>, he is wearing a field cap and has a helmet slung on his vest.", 
	"Kill", objNull, {true}, {!alive task_officer}
] spawn tsp_fnc_task;
[
	east, ["mission"], "x", "x", "Attack", objNull, 
	{true}, {count (["westminster","alderney","schottler","schottler_defend","steinway"] select {_x call BIS_fnc_taskState == "SUCCEEDED"}) == 5}, 
	{false}, {false}, {}, {"end1" remoteExec ["BIS_fnc_endMission", 0]}
] spawn tsp_fnc_task;