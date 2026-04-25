if (!isServer) exitWith {};

[
    west, ["coastal"], "Destroy coastal guns", "Take out these guns to allow AAVs and LAVs to beach safely.",
    "destroy", objnull, {true}, {!alive coast1 && !alive coast2 && !alive coast3 && !alive coast4 && !alive coast5}
] spawn tsp_fnc_task;
[
    west, ["officer"], "Kill HVT", "A Officer with a red cap is known to be around svetloyarsk.", 
    "Kill", objnull, {true}, {!alive Hvt1}
] spawn tsp_fnc_task;
[
    west, ["Depo"], "Destroy Vehicle Depo", "Around the portside of svet, we have reason to belive the CHDKZ are storing their assets in the warehouses.", 
    "Destroy", getpos task_destroy1, {true}, {!alive task_destroy1}
] spawn tsp_fnc_task;
[
    West, ["Town"], "Secure Svetloyarsk", "The Town is under CHDKZ control, eliminate all hostiles in the AO to secure a LZ for landing Crafts.",
    "Attack", getpos Secure1, {true}, { (count (allunits select {_x inArea Secure_svet && side _x == East}) <1)}
] spawn tsp_fnc_task;
[
    West, ["Checkpoint"], "Secure Checkpoint", "Take Control of the checkpoint just outside of svet and delay any QRF from reinforcing the town.",
    "Attack", getpos Secure2, {true}, { (count (allunits select {_x inArea Secure_checkpoint && side _x == East}) <1)}
] spawn tsp_fnc_task;
[
    west, ["Artillery"], "Destroy Artillery", "We know they have at least 4 2S1s artillery pieces. They most likely have deployed these outside of svet.",
    "destroy", objnull, {true}, {!alive task_arty1 && !alive task_arty2 && !alive task_arty3 && !alive task_arty4}
] spawn tsp_fnc_task;
[
    west, ["Defense"], "Hold Off Enemy QRF", "The CHDKZ is sending a wave of QRF from novo. Stop them from breaking into Svet.", "Defend", getPos Secure2, 
    {"Town" call BIS_fnc_taskState in ["SUCCEEDED","FAILED"] && "Checkpoint" call BIS_fnc_taskState in ["SUCCEEDED","FAILED"] && "Artillery" call BIS_fnc_taskState in ["SUCCEEDED","FAILED"]},
    { (count (allUnits select {_x inArea Svet_QRF && side _x == East}) < 1)}, {false}, {false},
    {["Svet QRF"] spawn tsp_fnc_sector_load;},
    {},{"end1" remoteExec ["BIS_fnc_endMission", 0]}
] spawn tsp_fnc_task;