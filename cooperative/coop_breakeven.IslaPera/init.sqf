//-- Player, Zombie Types, Triggers, Zombie Side, Condition, Code, Distance, Max Zombie Count, Interval, Despawn Distance
[player, [
    "tsp_afr_thug_m21",
    "tsp_afr_thug_ak",
    "tsp_afr_thug_k98",
    "tsp_afr_para_m21",
    "tsp_afr_para_ak",
    "tsp_afr_para_rpk"
], [zone_zombie], east, {true}, {}, 100, 2, 20, 350] spawn tsp_fnc_zombience;

if (!isServer) exitWith {};

[
    west, ["raid1"], "Stop Arms Deal", "we got a call for a possible arms deal. head to the village and stop it.", 
    "Attack", getPos contraband, {true}, {"cache" call BIS_fnc_taskState in ["SUCCEEDED"] && "secure" call BIS_fnc_taskState in ["SUCCEEDED"]}
] spawn tsp_fnc_task;
[
    west, ["cache","raid1"], "Secure Illegal Weapons", "They must have a cache somewhere in the town. Find and Secure it!",
    "Box", objnull, {true}, {!isNil "tsp_contraband"}, {false}
] spawn tsp_fnc_task;
[
    West, ["secure","raid1"], "Secure the village", "Eliminate all hostiles within the AO. If some surrendered, take them in.",
    "Attack", objnull, {true}, {(count (allunits select {_x inArea secure_village && side _x == East}) <1)}
] spawn tsp_fnc_task;
[
    west, ["seco"], "Destroy cache", "we know they use this small village as another means of logistics. Find and destory any caches.",
    "destroy", getpos rio_seco_cache, {"raid1" call BIS_fnc_taskState == "SUCCEEDED"}, {!alive rio_seco_cache}
] spawn tsp_fnc_task;
[
    West, ["raid2"], "Secure the logging camp", "Eliminate all hostiles and ensure no caches are hidden here.",
    "Attack", getpos logger, {"raid1" call BIS_fnc_taskState == "SUCCEEDED"}, {(count (allunits select {_x inArea secure_logging_camp && side _x == East}) <1)}
] spawn tsp_fnc_task;
[
    West, ["raid3"], "Secure the southern cartel camp", "The camps are mostly used to smuggle drugs and weapons. Destroy any vechicles you can find.",
    "Attack", getpos campA, {"raid1" call BIS_fnc_taskState == "SUCCEEDED"}, {(count (allunits select {_x inArea secure_camp_A && side _x == East}) <1)}
] spawn tsp_fnc_task;
[
    West, ["raid4"], "Secure the northen cartel camp", "The camps are mostly used to smuggle drugs and weapons. Destroy any vechicles you can find.",
    "Attack", getpos campB, {"raid1" call BIS_fnc_taskState == "SUCCEEDED"}, {(count (allunits select {_x inArea secure_camp_B && side _x == East}) <1)}
] spawn tsp_fnc_task;
[
    west, ["antiair"], "Destroy ZSU trucks", "there's AA trucks placed along the airstrip. Find and destroy them to allow for easier exfil.",
    "destroy", getpos airfield, {"raid1" call BIS_fnc_taskState == "SUCCEEDED"}, {!alive zsu_1 && !alive zsu_2 && !alive zsu_3 && !alive zsu_4}
] spawn tsp_fnc_task;
[
    West, ["resort"], "secure the resort", "This should be their main HQ for weapons making and distribution.",
    "Attack", getpos hotel, {"raid1" call BIS_fnc_taskState == "SUCCEEDED"}, {"workshop" call BIS_fnc_taskState in ["SUCCEEDED"] && "secure_hotel" call BIS_fnc_taskState in ["SUCCEEDED"] && "storage" call BIS_fnc_taskState in ["SUCCEEDED"]}
] spawn tsp_fnc_task;
[
    West, ["secure_hotel","resort"], "Secure the Resort", "The militia is most likely using the abandonded hotel as a housing. Expect multiple platoons worth of contact.",
    "Attack", objnull, {"raid1" call BIS_fnc_taskState == "SUCCEEDED"}, {(count (allunits select {_x inArea secure_north && side _x == East}) <1)}
] spawn tsp_fnc_task;
[
    west, ["workshop","resort"], "Destroy weapons workshop", "Find and Destory the weapon making hub.",
    "destroy", objnull, {"raid1" call BIS_fnc_taskState == "SUCCEEDED"}, {!alive workshop_cache}
] spawn tsp_fnc_task;
[
    west, ["storage","resort"], "Destroy weapons cache", "Find and Destory any caches that can be found at the resort.",
    "destroy", objnull, {"raid1" call BIS_fnc_taskState == "SUCCEEDED"}, {!alive storage_cache}
] spawn tsp_fnc_task;
[
    West, ["exract"], "RTB", "job well done! A huey is inbound sit tight and wait for exract.",
    "heli", getpos airfield, 
    {"resort" call BIS_fnc_taskState == "SUCCEEDED"}, {false}, {false}, {triggerActivated survive},
    {["ION_attack"] spawn tsp_fnc_sector_load;}
] spawn tsp_fnc_task;
[
    west, ["survive"], "Survive", "A PMC force has launched an attack on us. The huey was shot down on its way to the airfield, Hold out as long as you can!",
    "defend", objnull, {"exract" call BIS_fnc_taskState in ["CANCELED"]}, {["player", "", alive_player, 0] call tsp_fnc_sector_clear}
] spawn tsp_fnc_task;