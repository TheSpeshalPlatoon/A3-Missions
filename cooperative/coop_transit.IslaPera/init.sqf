if (!isServer) exitWith {};

[
    west, ["cache"], "Destroy weapons cache", "Find and Destory any caches that can be found in the camps.",
    "destroy", objnull, {true}, {!alive cache_1 && !alive cache_2 && !alive cache_3}
] spawn tsp_fnc_task;
[
    West, ["clear_camp_A"], "Secure Dig camp A", "Clear out the camp.",
    "Attack", objnull, {true}, { (count (allUnits select {_x inArea secure_camp_A && side _x == East}) < 1)}
] spawn tsp_fnc_task;
[
    West, ["clear_camp_B"], "Secure Dig camp B", "Clear out the camp.",
    "Attack", objnull, {true}, { (count (allUnits select {_x inArea secure_camp_B && side _x == East}) < 1)}
] spawn tsp_fnc_task;