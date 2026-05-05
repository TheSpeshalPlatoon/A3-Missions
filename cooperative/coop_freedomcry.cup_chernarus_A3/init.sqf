if (!isServer) exitWith {};

[
    west, ["hostage"], "Rescue hostages", "locations marked on your map is roughly where their holding our boys captive, Find and Bring them home.",
    "Meet", objnull, {true},  {count ([hostage1,hostage2,hostage3,hostage4,hostage4,hostage5,hostage6,hostage7,hostage8,hostage9,hostage10,hostage11,hostage12] select {alive _x && (_x inArea hostage_out)}) > 0}, 
    {count ([hostage1,hostage2,hostage3,hostage4,hostage4,hostage5,hostage6,hostage7,hostage8,hostage9,hostage10,hostage11,hostage12] select {alive _x}) == 0}
] spawn tsp_fnc_task;
[
    west, ["depo"], "Destroy Ammo cache", "We have reason to believe their using the sawmil as a small logistics hub, Find and Destory any caches.",
    "destroy", objnull, {true}, {!alive ammo1 && !alive ammo2}
] spawn tsp_fnc_task;
[
    west, ["officer"], "Capture Ivan Petrikov", "He has been seen around the marked locations on your map, We believe hes responsible for torturing and exracting information. Our HVT is known to be wearing a ushanka and black tracksuit", "Meet", objnull, 
    {true}, {count ([hvt1] select {alive _x && (_x inArea hvt_out)}) > 0}, 
    {count ([hvt1] select {alive _x}) == 0}
] spawn tsp_fnc_task;