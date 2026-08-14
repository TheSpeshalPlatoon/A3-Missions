[player, [
"rhsgref_ins_squadleader",
"rhsgref_ins_machinegunner",
"rhsgref_ins_grenadier",
"rhsgref_ins_grenadier_rpg",
"rhsgref_ins_rifleman_RPG26",
"rhsgref_ins_machinegunner",
"rhsgref_ins_rifleman",
"rhsgref_ins_rifleman_aks74"
], [zone_zombie, zone_zombie1], east, {true}, {}, 80, 6, 8, 200] spawn tsp_fnc_zombience;

if (fileExists 'defuse\functions.sqf') then {
    [] call compileScript ['defuse\functions.sqf'];
    [bomb1, 8, "Bomb_03_F", "6969"] spawn TFB_fnc_defuse_generateBomb;
    [bomb2, 4, "Bomb_03_F", "69420"] spawn TFB_fnc_defuse_generateBomb;
    [bomb3, 4, "Bomb_03_F", "124576"] spawn TFB_fnc_defuse_generateBomb;
};

if (!isServer) exitWith {};

[
    west, ["sawmill_hvt"], "Capture cell leader", "Possible location at the sawmill.", "Meet", getpos task_officer, 
    {true}, {count ([hvt_sawmil] select {alive _x && (_x inArea hvt_captured)}) > 0}, 
    {count ([hvt_sawmil] select {alive _x}) == 0}
] spawn tsp_fnc_task;
[
    west, ["hostages"], "Rescue IDAP workers", "2 IDAP workers was taken hostage, they were last seen at valimaki.", "Meet", getpos task_hostage, 
    {true}, {count ([hostage1, hostage2] select {alive _x && (_x inArea hvt_captured)}) > 0}, 
    {count ([hostage1, hostage2] select {alive _x}) == 0}
] spawn tsp_fnc_task;
[
    west, ["bunker"], "Tunnel Network", "We have a rough position marked on your map, This could lead you into their underground bunker.", 
    "Attack", objnull, {true}, { (count (allUnits select {_x inArea bunker_attack && side _x == East}) < 1)}
] spawn tsp_fnc_task;
[
    west, ["ammo_bunker","bunker"], "Destroy Ammo cache", "We have reasaon to believe thier ammo is being stored in a makeshift underground bunker.", 
    "Destroy", objnull, {true}, {!alive task_ammo1}
] spawn tsp_fnc_task;
[
    west, ["construction"], "Construction Site", "An abandon building project, turned nest for the militia.", 
    "Attack", getPos milita_base, {true}, { (count (allUnits select {_x inArea construct_attack && side _x == East}) < 1)}
] spawn tsp_fnc_task;
[
    west, ["ammo_construction","construction"], "Destroy Equipment cache", "Might be located at the construction site, Bring Demo for these caches..", 
    "Destroy", objnull, {true}, {!alive task_ammo2}
] spawn tsp_fnc_task;
[
    west, ["construction_hvt","construction"], "Capture cell leader", "Last known location is the construction site.", "Meet", objnull, 
    {true}, {count ([hvt_construction] select {alive _x && (_x inArea hvt_captured)}) > 0}, 
    {count ([hvt_construction] select {alive _x}) == 0}
] spawn tsp_fnc_task;
[
    West, ["bomb1"], "Defuse Bomb", "The militia has planted bombs. Find and Defuse bomb.",
    "Destroy", getpos defuse_bomb1, {"construction" call BIS_fnc_taskState == "SUCCEEDED"}, {bomb1 getVariable ["defused", false]}, {bomb1 getVariable ["exploded", false]}
] spawn tsp_fnc_task;
[
    West, ["bomb2"], "Defuse Bomb", "The militia has planted bombs. Find and Defuse bomb.",
    "Destroy", getpos defuse_bomb2, {"construction" call BIS_fnc_taskState == "SUCCEEDED"}, {bomb2, bomb3 getVariable ["defused", false]}, {bomb2, bomb3 getVariable ["exploded", false]}
] spawn tsp_fnc_task;
[
    west, ["hotel_hvt"], "Capture Officers", "Thanks to the HVTs you brougt back alive, They kindly gave us intel on their commanding officer.
     He's at a hotel down south, head down there and bring him back alive. Russians are likely in play so keep an eye out for any russian officer.", "Meet", getpos task_commander, 
    {"bomb1" call BIS_fnc_taskState in ["SUCCEEDED","FAILED"] && "bomb2" call BIS_fnc_taskState in ["SUCCEEDED","FAILED"] && "bomb3" call BIS_fnc_taskState in ["SUCCEEDED","FAILED"]}, 
    {count ([hotel_hvt1, hotel_hvt2] select {alive _x && (_x inArea hvt_captured)}) > 0}, 
    {count ([hotel_hvt1, hotel_hvt2] select {alive _x}) == 0}
] spawn tsp_fnc_task;
