if (!isServer) exitWith {};

[
    west, ["radar"], "Destroy Radar and S400", "Russians have supplied the militia with an S400 along with an active radar, destroy both or take the radar out of commision.", 
    "Destroy",getpos task_AA, {true}, {!alive task_AA}
] spawn tsp_fnc_task;
[
    west, ["officer"], "Enemy Officer", "The officer should be wearing a ballistic face mask along with heavy armor, known location is within the vicinity of pavlovo MB.", 
    "Kill",getpos officer, {true}, {!alive officer}
] spawn tsp_fnc_task;
[
    west, ["arty"], "Destroy Coastline Artillery", "The militia have some artillery set up close to to the sea, destroy it to allow friendly LCU to reach the shore.", 
    "Destroy", getpos task_Arty, {true}, {!alive task_Arty}
] spawn tsp_fnc_task;
[
    west, ["alpha"], "Field Camp", "ChDKZ militia have set up a field camp just outside kamenka, Clear it out.", 
    "Attack", getpos task_alpha, {true}, { (count (allUnits select {_x inArea Area1 && side _x == East}) < 1)}
] spawn tsp_fnc_task;
[
    west, ["airfield"], "Capture Airfield", "Secure the airfield.", 
    "Attack", getPos task_airfield, {true}, { (count (allUnits select {_x inArea Area3 && side _x == East}) < 1)}, {false}, {false},
    {}, {["qrf_balota"] spawn tsp_fnc_sector_load}
] spawn tsp_fnc_task;
[
    west, ["Defense"], "Defend Airfield", "Enemy QRF inbound, hold the airfield!", "Defend", getPos defend_balota, 
    {"airfield" call BIS_fnc_taskState == "SUCCEEDED"},{ (count (allUnits select {_x inArea balota_qrf && side _x == East}) < 2)}, {false}, {false}
] spawn tsp_fnc_task;

