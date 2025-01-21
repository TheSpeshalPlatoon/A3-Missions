if (!isServer) exitWith {};

[west, "primary", ["Main objectives are to capture/kill 2 high ranking Syndikat cell leaders, as well as rescue the crew of Atlas Bravo", "Primary Objectives"], objNull, "CREATED", -1, true, "Meet"] call BIS_fnc_taskCreate;
[west, "secondary", ["Secondary objectives are to help the HIDF defeat the 2 remaining Syndikat cells on the mainland of Tanoa.", "Secondary Objectives"], objNull, "CREATED", -1, true, "Intel"] call BIS_fnc_taskCreate;

[
	west, ["hostages", "primary"], "Rescue Hostages", "Syndikat have taken over 1 of the 2 rigs in Darwin field; the Atlas Bravo, secure it and extract the 7 man skeleton crew. The crew of the Altas Alpha has already been evactuated.", 
	"Takeoff", objNull, {true}, 
	{
		count ([task_civ1,task_civ2,task_civ3,task_civ4,task_civ5,task_civ6,task_civ7] select {_x distance garage_heli < 100}) > 0 && 
		count ([task_civ1,task_civ2,task_civ3,task_civ4,task_civ5,task_civ6,task_civ7] select {_x distance garage_heli < 100 || !alive _x}) == 7
	}, 
	{count ([task_civ1,task_civ2,task_civ3,task_civ4,task_civ5,task_civ6,task_civ7] select {!alive _x}) == 7}
] spawn tsp_fnc_task;
[
	west, ["solomon", "primary"], "Kill/Capture Solomon Maru", "Solomon Maru is the leader of a well armed and organised sub faction within Syndikat, over the years his force has grown to become quite the fighting force, able to stand up to the HIDF in direct conflict.<br/><img image='solomon.paa' width='200' height='200'/>", 
	"Kill", objNull, {true}, {task_solomon distance garage_heli < 100 || !alive task_solomon}, {false}
] spawn tsp_fnc_task;
[
	west, ["bari", "primary"], "Kill/Capture Bari Molia", "Bari Molia runs a cell of Syndikat that has extremist values, intel indicates that he is most likely responsible for the Atlas Bravo, search Syndikat territory for him.<br/><img image='bari.paa' width='200' height='200'/>", 
	"Kill", objNull, {true}, {task_bari distance garage_heli < 100 || !alive task_bari}, {false}
] spawn tsp_fnc_task;
[
	west, ["ambush", "secondary"], "Assist HIDF", "The HIDF assault force was stopped just outside Oumere, assist them.", 
	"Destroy", objNull, {true}, {(tsp_sector_info select {_x#0 == "ambush"})#0#1 && (count (allUnits select {_x distance task_ambush < 300 && side _x == resistance}) < 2)}
] spawn tsp_fnc_task;
[
	west, ["newyork", "secondary"], "New York", "Secure the objective area.", 
	"Attack", objNull, {true}, {(tsp_sector_info select {_x#0 == "newyork"})#0#1 && (count (allUnits select {_x distance task_newyork < 100 && side _x == resistance}) < 2)}
] spawn tsp_fnc_task;
[
	west, ["copenhagen", "secondary"], "Copenhagen", "Secure the objective area.", 
	"Attack", objNull, {true}, {(tsp_sector_info select {_x#0 == "copenhagen"})#0#1 && (count (allUnits select {_x distance task_copenhagen < 100 && side _x == resistance}) < 2)}
] spawn tsp_fnc_task;
[
	west, ["glasgow", "secondary"], "Glasgow", "Secure the objective area.", 
	"Attack", objNull, {true}, {(tsp_sector_info select {_x#0 == "glasgow"})#0#1 && (count (allUnits select {_x distance task_glasgow < 100 && side _x == resistance}) < 2)}
] spawn tsp_fnc_task;
[
	west, ["michigan", "secondary"], "Michigan", "Secure the objective area.", 
	"Attack", objNull, {true}, {(tsp_sector_info select {_x#0 == "michigan"})#0#1 && (count (allUnits select {_x distance task_michigan < 100 && side _x == resistance}) < 2)}
] spawn tsp_fnc_task;
[
	west, ["michigan", "secondary"], "Michigan", "Secure the objective area.", 
	"Attack", objNull, {true}, {(tsp_sector_info select {_x#0 == "michigan"})#0#1 && (count (allUnits select {_x distance task_michigan < 100 && side _x == resistance}) < 2)}
] spawn tsp_fnc_task;
[
	west, ["moscow", "secondary"], "Moscow", "Secure the objective area.", 
	"Attack", objNull, {true}, {(tsp_sector_info select {_x#0 == "moscow_inside"})#0#1 && (count (allUnits select {_x distance task_moscow < 100 && side _x == resistance}) < 2)}
] spawn tsp_fnc_task;
[
	west, ["sydney", "secondary"], "Sydney", "Secure the objective area.", 
	"Attack", objNull, {true}, {(tsp_sector_info select {_x#0 == "sydney"})#0#1 && (count (allUnits select {_x distance task_sydney < 100 && side _x == resistance}) < 2)}
] spawn tsp_fnc_task;
[
	west, ["warsaw", "secondary"], "Warsaw", "Secure the objective area.", 
	"Attack", objNull, {true}, {(tsp_sector_info select {_x#0 == "warsaw"})#0#1 && (count (allUnits select {_x distance task_warsaw < 100 && side _x == resistance}) < 2)}
] spawn tsp_fnc_task;