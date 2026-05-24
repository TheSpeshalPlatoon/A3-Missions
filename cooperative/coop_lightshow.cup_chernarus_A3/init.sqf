[player, [  //-- Player, Zombie Types, Triggers, Zombie Side, Condition, Code, Distance, Max Zombie Count, Interval, Despawn Distance
"rhsgref_ins_squadleader",
"rhsgref_ins_grenadier",
"rhsgref_ins_grenadier_rpg",
"rhsgref_ins_rifleman_RPG26",
"rhsgref_ins_machinegunner",
"rhsgref_ins_rifleman",
"rhsgref_ins_rifleman_aks74",
"rhsgref_ins_saboteur"
], [zone_zombie], east, {true}, {}, 150, 8, 10, 200] spawn tsp_fnc_zombience;

if (!isServer) exitWith {};

[
    West, ["svet"], "Secure Svetloyarsk", "The Town is under CHDKZ control, eliminate all hostiles in the AO to secure a LZ for landing Crafts.",
    "Attack", getpos Secure1, {true}, { (count (allunits select {_x inArea Secure_svet && side _x == East}) <1)}
] spawn tsp_fnc_task;
[
    west, ["coastal","svet"], "Destroy coastal guns", "Take out these guns to allow AAVs and LAVs to beach safely.",
    "destroy", objnull, {true}, {!alive coast1 && !alive coast2 && !alive coast3 && !alive coast4 && !alive coast5}, {false}, {false},
    {}, {["USMC"] spawn tsp_fnc_sector_load}
] spawn tsp_fnc_task;
[
    west, ["officer","svet"], "Kill HVT", "A Officer with a red cap is known to be around svetloyarsk.", 
    "Kill", objnull, {true}, {!alive Hvt1}
] spawn tsp_fnc_task;
[
    West, ["Checkpoint"], "Secure Checkpoint", "Take Control of the checkpoint just outside of svet and delay any QRF from reinforcing the town.",
    "Attack", getpos Secure2, {true}, { (count (allunits select {_x inArea Secure_checkpoint && side _x == East}) <1)}
] spawn tsp_fnc_task;
[
    west, ["Artillery","Checkpoint"], "Destroy Artillery", "We know they have at least 4 2S1s artillery pieces. They most likely have deployed these outside of svet.",
    "destroy", objnull, {true}, {!alive task_arty1 && !alive task_arty2 && !alive task_arty3 && !alive task_arty4}
] spawn tsp_fnc_task;
[
    west, ["Defense"], "Hold Off Enemy QRF", "The CHDKZ is sending a wave of QRF from novo. Stop them from breaking into Svet.", "Defend", getPos Secure2, 
    {"svet" call BIS_fnc_taskState in ["SUCCEEDED"] && "Checkpoint" call BIS_fnc_taskState in ["SUCCEEDED"] && "Artillery" call BIS_fnc_taskState in ["SUCCEEDED"]},
    { (count (allUnits select {_x inArea defend_svet && side _x == East}) < 1)}, {false}, {false},
    {["svet_qrf"] spawn tsp_fnc_sector_load;}
] spawn tsp_fnc_task;