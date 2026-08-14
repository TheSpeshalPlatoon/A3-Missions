
if (fileExists 'defuse\functions.sqf') then {
    [] call compileScript ['defuse\functions.sqf'];
    [wall1, 3, "Bomb_03_F", "6969"] spawn TFB_fnc_defuse_generateBomb;
    [wall2, 6, "Bomb_03_F", "69420"] spawn TFB_fnc_defuse_generateBomb;
    [wall3, 8, "Bomb_03_F", "124576"] spawn TFB_fnc_defuse_generateBomb;
    [wall4, 10, "Bomb_03_F", "1256482"] spawn TFB_fnc_defuse_generateBomb;
};

if (!isServer) exitWith {};

[
    West, ["svet"], "Secure Svetloyarsk", "The Town is under CHDKZ control, eliminate all hostiles in the AO to secure a LZ for landing Crafts.",
    "Attack", getpos Secure1, {true}, { (count (allunits select {_x inArea Secure_svet && side _x == East}) <1)}
] spawn tsp_fnc_task;
[
    west, ["coastal","svet"], "Destroy coastal guns", "Take out these guns to allow AAVs and LAVs to beach safely.",
    "destroy", objnull, {true}, {!alive coast1 && !alive coast2 && !alive coast3 && !alive coast4 && !alive coast5}
] spawn tsp_fnc_task;
[
    west, ["officer","svet"], "Capture Officer", "High ranking officer is known to be in svet, known to be wearing a red cap.", 
    "Meet", objnull, {true}, {count ([hvt_officer] select {alive _x && (_x inArea hvt_captured)}) > 0}, 
    {count ([hvt_officer] select {alive _x}) == 0}
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
    west, ["defend_svet"], "Hold Off Enemy QRF", "The CHDKZ is sending a wave of QRF from novo. Stop them from breaking into Svet.", "Defend", getPos Secure2, 
    {"svet" call BIS_fnc_taskState in ["SUCCEEDED","FAILED"] && "Checkpoint" call BIS_fnc_taskState in ["SUCCEEDED","FAILED"] && "Artillery" call BIS_fnc_taskState in ["SUCCEEDED","FAILED"]},
    { (count (allUnits select {_x inArea defend_svet && side _x == East}) < 1)}, {false}, {false},
    {["svet_qrf"] spawn tsp_fnc_sector_load;}
] spawn tsp_fnc_task;
[
    West, ["airfield"], "Secure Airfield", "Take the airfield with minimum damage to the buildings, Centcom wants USAF to operate the airfield.",
    "Attack", getpos Secure3, {"defend_svet" call BIS_fnc_taskState == "SUCCEEDED"}, { (count (allunits select {_x inArea Secure_krasnoaf && side _x == East}) <1)}
] spawn tsp_fnc_task;
[
    west, ["komandir","airfield"], "Capture komandir", "We know there's a high ranking individual at the airfield. known to be wearing a white camo pattern uniform and ushanka.", 
    "Meet", objnull, {"defend_svet" call BIS_fnc_taskState == "SUCCEEDED"}, {count ([hvt_commander] select {alive _x && (_x inArea hvt_captured)}) > 0}, 
    {count ([hvt_commander] select {alive _x}) == 0}
] spawn tsp_fnc_task;
[
    west, ["defend_krasno"], "Hold Off Enemy QRF", "The CHDKZ is launching a counter attack, Hold the airfield!", "Defend", getPos Secure3, 
    {"airfield" call BIS_fnc_taskState in ["SUCCEEDED"]},
    { (count (allUnits select {_x inArea defend_krasno && side _x == East}) < 1)}, {false}, {false},
    {["krasno_qrf"] spawn tsp_fnc_sector_load;}
] spawn tsp_fnc_task;
[
    West, ["chenaya"], "Secure Chenaya", "We got movement in the town of chenaya, There's a platoons worth of CHDKZ setting up defenses and a bomb should they fail. Eliminate the threat and defuse the bomb.",
    "Attack", getpos Secure4, {"defend_krasno" call BIS_fnc_taskState == "SUCCEEDED"}, {(count (allunits select {_x inArea Secure_chenaya && side _x == East}) <1)}
] spawn tsp_fnc_task;
[
    West, ["bomb1","chenaya"], "Defuse Bomb", "Find and Defuse bomb.",
    "Destroy", objnull, {"defend_krasno" call BIS_fnc_taskState == "SUCCEEDED"}, {wall1 getVariable ["defused", false]}, {wall1 getVariable ["exploded", false]}
] spawn tsp_fnc_task;
[
    West, ["novo"], "Secure Novodmitrovsk", "The Chdkz are prepping bombs in the town of novo. Take control of the town and defuse the bombs.",
    "Attack", getpos Secure5, {"chenaya" call BIS_fnc_taskState == "SUCCEEDED"}, {(count (allunits select {_x inArea Secure_novo && side _x == East}) <1)}
] spawn tsp_fnc_task;
[
    West, ["bomb2","novo"], "Defuse Bomb", "Find and Defuse bomb.",
    "Destroy", objnull, {"chenaya" call BIS_fnc_taskState == "SUCCEEDED"}, {wall2 getVariable ["defused", false]}, {wall2 getVariable ["exploded", false]}
] spawn tsp_fnc_task;
[
    West, ["bomb3","novo"], "Defuse Bomb", "Find and Defuse bomb.",
    "Destroy", objnull, {"chenaya" call BIS_fnc_taskState == "SUCCEEDED"}, {wall3 getVariable ["defused", false]}, {wall3 getVariable ["exploded", false]}
] spawn tsp_fnc_task;
[
    West, ["bomb4","novo"], "Defuse Bomb", "Find and Defuse bomb.",
    "Destroy", objnull, {"chenaya" call BIS_fnc_taskState == "SUCCEEDED"}, {wall4 getVariable ["defused", false]}, {wall4 getVariable ["exploded", false]}
] spawn tsp_fnc_task;
