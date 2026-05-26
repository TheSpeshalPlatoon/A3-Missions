// Player, Zombie Types, Triggers, Zombie Side, Condition, Code, Distance, Max Zombie Count, Interval, Despawn Distance
[player, [
"rhsgref_ins_squadleader",
"rhsgref_ins_machinegunner",
"rhsgref_ins_grenadier",
"rhsgref_ins_grenadier_rpg",
"rhsgref_ins_rifleman_RPG26",
"rhsgref_ins_machinegunner",
"rhsgref_ins_rifleman",
"rhsgref_ins_rifleman_aks74"
], [zone_zombie], east, {true}, {}, 200, 6, 15, 400] spawn tsp_fnc_zombience;

if (!isServer) exitWith {};

[
    [Spectre_1, Hog_1], ["CAS"], "Provide Air support", "Get online with the A10 or AC130 and assist Timberwolf",
    "Defend", objnull, {true}, {triggerActivated exfil_done}
] spawn tsp_fnc_task;
[
    [Spectre_1, Hog_1], ["ch47", "CAS"], "Destroy CH-47", "Prevent the chDKZ from getting the chinook", 
    "Destroy", getpos task_ch47, {true}, {!alive task_ch47}
] spawn tsp_fnc_task;
[
    [Spectre_1, Hog_1], ["defend_timberwolf", "CAS"], "Defend Timberwolf", "Timberwolf is stuck behind enemy lines, Provide air cover until they can exract.", 
    "Defend", getpos zone_hold, {triggerActivated farm}, {triggerActivated exfil_done}
] spawn tsp_fnc_task;
[
    [Spectre_1, Hog_1], ["Rtb"], "Return To Base", "Thanks to your efforts, Timberwolf has successfully exracted from the AO. Good work Spectre, RTB.", 
    "Move", getpos rtb_1, {triggerActivated exfil_done}, {triggerActivated rtb1}
] spawn tsp_fnc_task;
[
    [T1, T2, T3], ["run"], "Head to the designated area", "High command has designated a farm as a sutiable location to hold out, head there ASAP.", 
    "Move", getpos zone_hold, {true}, {triggerActivated farm}
] spawn tsp_fnc_task;
[
    [T1, T2, T3], ["hold"], "Hold out until Exfil arrives", "Dig in and hold out until an exract arrives.", 
    "Defend", getpos zone_hold, {triggerActivated farm}, {!isNil "exfilArrive"}
] spawn tsp_fnc_task;
[
    [T1, T2, T3], ["exfil"], "Exract", "Exract heli is inbound.", 
    "Heli", getpos zone_exract, {!isNil "exfilArrive"}, {triggerActivated exfil_done}
] spawn tsp_fnc_task;
[
    [T1, T2, T3], ["hvt"], "Bring Militia Officer back", "Bring the HVT back alive.", "Meet", objnull, 
    {true}, {count ([Hvt1] select {alive _x && (_x inArea hvt_out)}) > 0}, 
    {count ([Hvt1] select {alive _x}) == 0}
] spawn tsp_fnc_task;