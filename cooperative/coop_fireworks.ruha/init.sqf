if (!isServer) exitWith {};

[
    west, ["Arty"], "Destroy Artillery Piece", "Local milita has 3 artillery guns, we got a rough location on where its hidden.", 
    "Destroy", objnull, {true}, {!alive task_arty}
] spawn tsp_fnc_task;
[
    west, ["IED"], "Destroy IED shelter", "The milita is making IED's and we got a beat on where its being produced.", 
    "Destroy", objnull, {true}, {!alive task_IED}
] spawn tsp_fnc_task;
[
    west, ["Vehicle_Depo"], "Destroy Vehicle Depot", "locals in the town, revealed where some of the milita's mobile artillery and ammo trucks.", 
    "Destroy", getPos task_vehicledepo, {true}, {!alive task_vehicledepo}
] spawn tsp_fnc_task;
[
    west, ["Bunker"], "Tunnel Network", "Intel suggests the milita has underground access, It's used as an ammo cache and there could be an officer in there.", 
    "Attack", objnull, {true}, { (count (allUnits select {_x inArea Bunker1 && side _x == East}) < 1)}
] spawn tsp_fnc_task;
[
    west, ["ammo_bunker"], "Destroy Ammo cache", "Possible known location is in the underground network.", 
    "Destroy", objnull, {true}, {!alive task_ammo1}
] spawn tsp_fnc_task;
[
    west, ["Construction"], "Construction Site", "An abandon building project, turned into a nest for the milita.", 
    "Attack", getPos milita_base, {true}, { (count (allUnits select {_x inArea Construct1 && side _x == East}) < 1)}
] spawn tsp_fnc_task;
[
    west, ["ammo_construciton"], "Destroy Ammo cache", "Possible known location is in the construction site turned nest for the milita.", 
    "Destroy", objnull, {true}, {!alive task_ammo2}
] spawn tsp_fnc_task;
[
    west, ["officer"], "Capture cell leader", "Possible known location is at the construction site turned nest for the milita.", "Meet", objnull, 
    {true}, {count ([ofi] select {alive _x && (_x inArea ofi_out)}) > 0}, 
    {count ([ofi] select {alive _x}) == 0}
] spawn tsp_fnc_task;
[
    west, ["hos"], "Rescue Hostages", "3 American IDAP workers was kidnapped and detained. We only got a rough location on wehre they're being held. Find them and bring them home.", "Meet", objnull, 
    {true}, {count ([hos1,hos2,hos3] select {alive _x && (_x inArea hostage_out)}) > 0}, 
    {count ([hos1,hos2,hos3] select {alive _x}) == 0}
] spawn tsp_fnc_task;
[
    west, ["officer1"], "Capture cell leader", "Possible location is at the sawmill.", "Meet", getpos offi, 
    {true}, {count ([offi] select {alive _x && (_x inArea lieu_out)}) > 0}, 
    {count ([offi] select {alive _x}) == 0}
] spawn tsp_fnc_task;
[
    west, ["hotel_officer"], "Capture Officers", "We just got a report from the lithuanians, A russian officer and militan commander is meeting up at the abandon hotel. Find and bring them back alive!", "Meet", getpos koman1, 
    {"officer1" call BIS_fnc_taskState in ["SUCCEEDED","FAILED"] && "Construction" call BIS_fnc_taskState in ["SUCCEEDED","FAILED"] && "Bunker" call BIS_fnc_taskState in ["SUCCEEDED","FAILED"]}, 
    {count ([koman1, koman2] select {alive _x && (_x inArea komandir_out)}) > 0}, 
    {count ([koman1, koman2] select {alive _x}) == 0}
] spawn tsp_fnc_task;