[player, [
"rhsgref_ins_squadleader",
"rhsgref_ins_machinegunner",
"rhsgref_ins_grenadier",
"rhsgref_ins_grenadier_rpg",
"rhsgref_ins_rifleman_RPG26",
"rhsgref_ins_machinegunner",
"rhsgref_ins_rifleman",
"rhsgref_ins_rifleman_aks74"
], [zone_zombie, zone_zombie1], east, {true}, {}, 200, 6, 15, 400] spawn tsp_fnc_zombience;if (!isServer) exitWith {};

[
    west, ["Bunker"], "Tunnel Network", "We have a rough position marked on your map, This could lead you into their underground bunker.", 
    "Attack", objnull, {true}, { (count (allUnits select {_x inArea Bunker1 && side _x == East}) < 1)}
] spawn tsp_fnc_task;
[
    west, ["ammo_bunker"], "Destroy Ammo cache", "We have reasaon to believe thier ammo is being stored in a makeshift underground bunker.", 
    "Destroy", objnull, {true}, {!alive task_ammo1}
] spawn tsp_fnc_task;
[
    west, ["Construction"], "Construction Site", "An abandon building project, turned nest for the militia.", 
    "Attack", getPos milita_base, {true}, { (count (allUnits select {_x inArea Construct1 && side _x == East}) < 1)}
] spawn tsp_fnc_task;
[
    west, ["ammo_construciton"], "Destroy Equipment cache", "Might be located at the construction site, Bring Demo for these caches..", 
    "Destroy", objnull, {true}, {!alive task_ammo2}
] spawn tsp_fnc_task;
[
    west, ["Cache"], "Destroy Weapon Cache", "We have a rough idea on where they keep their weapon cache, Find and destroy it.", 
    "Destroy", objnull, {true}, {!alive task_ammo3}
] spawn tsp_fnc_task;
[
    west, ["officer2"], "Capture cell leader", "Last known location is the construction site.", "Meet", objnull, 
    {true}, {count ([HVT2] select {alive _x && (_x inArea HVT2_out)}) > 0}, 
    {count ([HVT2] select {alive _x}) == 0}
] spawn tsp_fnc_task;
[
    west, ["officer1"], "Capture cell leader", "Possible location at the sawmill.", "Meet", getpos HVT1, 
    {true}, {count ([HVT1] select {alive _x && (_x inArea HVT1_out)}) > 0}, 
    {count ([HVT1] select {alive _x}) == 0}
] spawn tsp_fnc_task;
[
    west, ["hotel_officer"], "Capture Officers", "Thanks to the HVTs you brougt back alive, They kindly gave us intel on their commanding officer.
     He's at a hotel down south, head down there and bring him back alive. Russians are likely in play so keep an eye out for any russian officer.", "Meet", getpos koman1, 
    {"officer1" call BIS_fnc_taskState in ["SUCCEEDED","FAILED"] && "Construction" call BIS_fnc_taskState in ["SUCCEEDED","FAILED"] && "Bunker" call BIS_fnc_taskState in ["SUCCEEDED","FAILED"]}, 
    {count ([koman1, koman2] select {alive _x && (_x inArea komandir_out)}) > 0}, 
    {count ([koman1, koman2] select {alive _x}) == 0}
] spawn tsp_fnc_task;
