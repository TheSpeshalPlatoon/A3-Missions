if (!isServer) exitWith {};

[east, "main", ["Primary objective is to capture the warlord and find the missing supply convoy.", "Main Objectives"], objNull, "CREATED", -1, true, "Scout"] call BIS_fnc_taskCreate;

[
	east, ["convoy", "main"], "Find Supply Convoy", "A supply convoy went missing very recently, possible locations are marked on your map. We cannot start the assault until we find the convoy and secure it.", 
	"Truck", objNull, {true}, {["missingconvoy", "", sector_missingconvoy, 0, 2, [resistance]] call tsp_fnc_sector_clear}
] spawn tsp_fnc_task;
[
	east, ["warlord1", "main"], "Capture the Warlord", "The target is held up in a house just north of the airfield. If he's not present, collect any intel that would pinpoint his current whereabouts.", "Kill", getPos task_intel, 
	{"convoy" call BIS_fnc_taskState == "SUCCEEDED"},{false}, {false}, {!isNil "IntelGet"}, 
	{["secondplt"] spawn tsp_fnc_sector_load;}
] spawn tsp_fnc_task;

[
	east, ["warlord1_ambush", "main"], "Secure the area", "GRU Intelligence are trying to piece together the intel you found, secure your position in the meantime.", 
	"Defend", getPos task_intel, {"warlord1" call BIS_fnc_taskState == "CANCELED"},
	{["airfield", "", sector_airfield, 0, 2, [resistance]] call tsp_fnc_sector_clear}, {false}, {false}, 
	{["poiwarlord1"] spawn tsp_fnc_sector_load;}
] spawn tsp_fnc_task;
[
	east, ["bridge_kinney", "main"], "Secure the bridge", "GRU located a safehouse belonging to the warlord. We must block all avenues of escape before going in for the capture.", 
	"Attack", getPos brifge, {"warlord1_ambush" call BIS_fnc_taskState == "SUCCEEDED"}, {["kinney", "", sector_kinney, 0, 2, [resistance]] call tsp_fnc_sector_clear}
] spawn tsp_fnc_task;
[
	east, ["warlord2", "main"], "Capture the Warlord... again", "Now that the bridge is secure, we can start tightening the noose. Capture that warlord! Third platoon is inbound to support.", 
	"Kill", getPos hous, {"bridge_kinney" call BIS_fnc_taskState == "SUCCEEDED"}, {false}, {false}, {!alive houseblowup}
] spawn tsp_fnc_task;
[
	east, ["mortar", "main"], "Destroy Mortar", "It was a ruse! We've taken too many losses and division is ordering us to pull back. However, third platoon came under heavy fire from the Dam. They report mortars landing. We've pinpointed a suspected position nearby, find and destroy that mortar.", 
	"Destroy", getPos task_mortar, {"warlord2" call BIS_fnc_taskState == "CANCELED"}, {!alive task_mortar}, {false}
] spawn tsp_fnc_task;
[
	east, ["helpthem", "main"], "Assist Third Platoon", "Now we need to help third platoon. Clear out the industrial site next to the Dam!", 
	"Help", objNull, {"mortar" call BIS_fnc_taskState == "SUCCEEDED"}, {["dam_inner", "", sector_dam_inner, 0, 2, [resistance]] call tsp_fnc_sector_clear}
] spawn tsp_fnc_task;



[
	west, ["mission"], "x", "x", "Attack", objNull, 
	{true}, {count (["helpthem"] select {_x call BIS_fnc_taskState == "SUCCEEDED"}) == 1}, 
	{false}, {false}, {}, {"end1" remoteExec ["BIS_fnc_endMission", 0]}
] spawn tsp_fnc_task;