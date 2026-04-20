if (!isServer) exitWith {};

[
    west, ["Bunker"], "Tunnel Network", "Intel suggests the milita has underground access, It's used as an ammo cache and there could be an officer in there.", 
    "Attack", objnull, {true}, { (count (allUnits select {_x inArea Bunker1 && side _x == East}) < 1)}
] spawn tsp_fnc_task;
[
    west, ["ammo_bunker"], "Destroy Ammo cache", "Possible known location is in the underground network.", 
    "Destroy", objnull, {true}, {!alive task_ammo1}
] spawn tsp_fnc_task;
[
    west, ["Construction"], "Construction Site", "An abandon building project, turned into a nest for the militia.", 
    "Attack", getPos milita_base, {true}, { (count (allUnits select {_x inArea Construct1 && side _x == East}) < 1)}
] spawn tsp_fnc_task;
[
    west, ["ammo_construciton"], "Destroy Ammo cache", "Possible known location is in the construction site turned nest for the militia.", 
    "Destroy", objnull, {true}, {!alive task_ammo2}
] spawn tsp_fnc_task;
[
    west, ["Cache"], "Destroy Weapon Cache", "We have a rough idea on where they keep their weapon cache, Find and destroy it.", 
    "Destroy", objnull, {true}, {!alive task_ammo3}
] spawn tsp_fnc_task;
[
    west, ["officer2"], "Capture cell leader", "Possible known location is at the construction site turned nest for the militia.", "Meet", objnull, 
    {true}, {count ([HVT2] select {alive _x && (_x inArea HVT2_out)}) > 0}, 
    {count ([HVT2] select {alive _x}) == 0}
] spawn tsp_fnc_task;
[
    west, ["officer1"], "Capture cell leader", "Possible location is at the sawmill.", "Meet", getpos HVT1, 
    {true}, {count ([HVT1] select {alive _x && (_x inArea HVT1_out)}) > 0}, 
    {count ([HVT1] select {alive _x}) == 0}
] spawn tsp_fnc_task;
[
    west, ["hotel_officer"], "Capture Officers", "We just got a report from the lithuanians, A russian officer and militan commander is meeting up at the abandon hotel. Find and bring them back alive!", "Meet", getpos koman1, 
    {"officer1" call BIS_fnc_taskState in ["SUCCEEDED","FAILED"] && "Construction" call BIS_fnc_taskState in ["SUCCEEDED","FAILED"] && "Bunker" call BIS_fnc_taskState in ["SUCCEEDED","FAILED"]}, 
    {count ([koman1, koman2] select {alive _x && (_x inArea komandir_out)}) > 0}, 
    {count ([koman1, koman2] select {alive _x}) == 0}
] spawn tsp_fnc_task;