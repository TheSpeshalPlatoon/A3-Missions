[] spawn {
    while {sleep 1; true} do {
        if (player inArea zone_banana && random 1 < 0.25 && speed player > 5) then {
            playSound3D ["tsp_core\data\sounds\slip.ogg", player, false, getPosASL player, 5, 1, 10];
            [player, [player]] spawn tsp_fnc_zone_launch;
        };
    };
};

if (!isServer) exitWith {}; 

[west, "primary", ["Main objective is to Recover the Comanche.", "Primary Objectives"], objNull, "CREATED", -1, true, "meet"] call BIS_fnc_taskCreate;
[west, "secondary", ["Secondary objective is to Arrest the perpetrator behind all of this.", "Secondary Objective"], objNull, "CREATED", -1, true, "Target"] call BIS_fnc_taskCreate;

[
    west, ["comanche", "primary"], "Recover The Comanche", "Recover the Comanche from the rogue faction and take it to the <marker name='marker_37'>Rendezvous Point</marker> then switch with the other helicopter provided to extract the element.", 
    "Heli",objNull,{"radar2" call BIS_fnc_taskState == "SUCCEEDED"},{[task_comanche, [zone_rendezvous]] call tsp_fnc_zone_triggers},{!alive task_comanche}
] spawn tsp_fnc_task;

[
    west, ["shorad", "primary"], "Destroy SHORAD", "Destroy the SHORAD in the form of 2 Linebacker Bradleys (M6A2). they each have 4 stinger launchers that can devistate any helicopter.", 
    "Destroy", getPos task_shorad, {true}, {!alive task_shorad1 && !alive task_shorad2}
] spawn tsp_fnc_task;

[
    west, ["radar1", "primary"], "Eliminate Big Radar", "Eliminate the big radar by tampering with the power switch inside the building.", "interact", getPos task_lever, 
    {true}, {!isNil "switchPulled"}
] spawn tsp_fnc_task;

[
    west, ["radar2", "primary"], "Destroy Airfield Radar", "Destroy the Radar at the airfield before letting the pilot fly out of the base.", 
    "Destroy", getPos task_radar2, {count (["shorad","radar1"] select {_x call BIS_fnc_taskState == "SUCCEEDED"}) == 2}, {!alive task_radar2}
] spawn tsp_fnc_task;

[
	west, ["officer", "secondary"], "Arrest Colonel Jack", "SIGINT sources say the main orchestrator of the Comanche heist is Colonel Dallas Jack. He will be giving a speech in one of the hangars at the <marker name='marker_47'>Airfield</marker>. The target will wear a beret and his prized aviators. We need him alive for questioning.", 
	"Kill", objNull, {true}, {!(task_jack inArea trigger_extract)}, {!alive task_jack}
] spawn tsp_fnc_task;

[
    west, ["extract", "primary"], "Exfiltrate", "Exfiltrate out of the hot zone by chopper. Defend your positions until the heli arrives.", "run", objNull, 
    {count (["shorad","radar1","radar2","comanche"] select {_x call BIS_fnc_taskState == "SUCCEEDED"}) == 4}, {count (allPlayers select {_x inArea trigger_extract}) == 0}
] spawn tsp_fnc_task;


[
	east, ["mission"], "x", "x", "Attack", objNull, 
	{true}, {count (["comanche","extract"] select {_x call BIS_fnc_taskState == "SUCCEEDED"}) == 2}, 
	{false}, {false}, {}, {"end1" remoteExec ["BIS_fnc_endMission", 0]}
] spawn tsp_fnc_task;

[
	east, ["faildestroy"], "x", "x", "Attack", objNull, 
	{true}, {count (["comanche"] select {_x call BIS_fnc_taskState == "FAILED"}) == 1}, 
	{false}, {false}, {}, {["end2", false] remoteExec ["BIS_fnc_endMission", 0]}
] spawn tsp_fnc_task;