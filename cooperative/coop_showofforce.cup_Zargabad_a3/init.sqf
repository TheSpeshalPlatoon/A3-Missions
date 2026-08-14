[player, [  //-- Player, Zombie Types, Triggers, Zombie Side, Condition, Code, Distance, Max Zombie Count, Interval, Despawn Distance
	"tsp_tka_teamlead",
	"tsp_tka_medic",
	"tsp_tka_grenadier",
	"tsp_tka_autorifleman",
	"tsp_tka_antitank",
	"tsp_tka_rifleman",
	"tsp_tka_rifleman_akm",
	"tsp_tka_rifleman_lite"
], [zone_zombie], independent, {true}, {}, 40, 6, 30, 250] spawn tsp_fnc_zombience;


if (fileExists 'defuse\functions.sqf') then { 
    [] call compileScript ['defuse\functions.sqf'];
    [bomb1, 4, "Bomb_03_F", "6969"] spawn TFB_fnc_defuse_generateBomb;
    [bomb2, 6, "Bomb_03_F", "69420"] spawn TFB_fnc_defuse_generateBomb;
    [bomb3, 8, "Bomb_03_F", "124576"] spawn TFB_fnc_defuse_generateBomb;
};

if (!isServer) exitWith {};

[
    west, ["s1"], "Sector 1", "Complete the objectives and clear the area.", 
    "Defend", getPos C1, {true}, {"cache" call BIS_fnc_taskState in ["SUCCEEDED"] && "bomb1" call BIS_fnc_taskState in ["SUCCEEDED","FAILED"]}
] spawn tsp_fnc_task;
[
    west, ["cache","s1"], "Destroy weapons cache", "They have a cache located somewhere in the construction zone.",
    "destroy", objnull, {true}, {!alive task_cache1 && !alive task_cache2}
] spawn tsp_fnc_task;
[
    West, ["bomb1", "s1"], "Defuse Bomb", "Find and Defuse bomb.",
    "intel", objnull, {true}, {bomb1 getVariable ["defused", false]}, {bomb1 getVariable ["exploded", false]}
] spawn tsp_fnc_task;
[
    west, ["s2"], "Sector 2", "Complete the objectives and clear the area.", 
    "Defend", getPos C2, {true}, {"officer" call BIS_fnc_taskState in ["SUCCEEDED"] && "bomb2" call BIS_fnc_taskState in ["SUCCEEDED","FAILED"]}
] spawn tsp_fnc_task;
[
    west, ["officer","s2"], "Kill 3 Officers", "Their in an apartment and its fully garrisoned, We know their in Sector 2.",
    "destroy", objnull, {true}, {!alive task_officer1 && !alive task_officer2 && !alive task_officer3}
] spawn tsp_fnc_task;
[
    West, ["bomb2", "s2"], "Defuse Bomb", "Find and Defuse bomb.",
    "intel", objnull, {true}, {bomb2 getVariable ["defused", false]}, {bomb2 getVariable ["exploded", false]}
] spawn tsp_fnc_task;
[
    west, ["s3"], "Sector 3", "Complete the objectives and clear the area.", 
    "Defend", getPos C3, {true}, {"clear" call BIS_fnc_taskState in ["SUCCEEDED"] && "bomb3" call BIS_fnc_taskState in ["SUCCEEDED","FAILED"]}
] spawn tsp_fnc_task;
[
    West, ["clear","s3"], "Secure the area", "Kill the remaining syrian forces.",
    "Attack", objnull, {true}, { (count (allunits select {_x inArea secure_S3 && side _x == Independent}) <1)}
] spawn tsp_fnc_task;
[
    West, ["bomb3", "s3"], "Defuse Bomb", "Find and Defuse bomb.",
    "intel", objnull, {true}, {bomb3 getVariable ["defused", false]}, {bomb3 getVariable ["exploded", false]}
] spawn tsp_fnc_task;
[
    west, ["defend"], "Defend Zargabad", "Assist 1st Armored Brigade in defending Zargabad against an enemy counterattack.", "Defend", getPos zargabad_defense, 
    {"s1" call BIS_fnc_taskState in ["SUCCEEDED"] && "s2" call BIS_fnc_taskState in ["SUCCEEDED"] && "s3" call BIS_fnc_taskState in ["SUCCEEDED"]},
    { (count (allUnits select {_x inArea defend_zargabad && side _x == independent}) < 2)}, {false}, {false},
    {["zargabad_defend"] spawn tsp_fnc_sector_load;},
    {},{"end1" remoteExec ["BIS_fnc_endMission", 0]}
] spawn tsp_fnc_task;