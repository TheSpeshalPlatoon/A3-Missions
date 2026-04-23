// Player, Zombie Types, Triggers, Zombie Side, Condition, Code, Distance, Max Zombie Count, Interval, Despawn Distance
[player, [
"rhsgref_ins_squadleader",
"rhsgref_ins_machinegunner",
"rhsgref_ins_grenadier",
"rhsgref_ins_grenadier_rpg",
"rhsgref_ins_rifleman_RPG26",
"rhsgref_ins_machinegunner",
"rhsgref_ins_rifleman",
"rhsgref_ins_rifleman_aks74",
"UK3CB_CHD_O_Datsun_Pkm",
"UK3CB_CHD_O_Hilux_Dshkm"
], [zone_zombie], east, {true}, {}, 200, 6, 15, 400] spawn tsp_fnc_zombience;

if (!isServer) exitWith {};

[
    Spectre_1, ["ch47"], "Destroy CH-47", "Prevent the chDKZ from getting the chinook", 
    "Destroy", getpos task_ch47, {true}, {!alive task_ch47}
] spawn tsp_fnc_task;
[
    Spectre_1, ["assist"], "Provide Air support", "Timberwolf is deep in enemy territory and their exract got shot down, Provide air cover untill High command can task a new helo to them.", 
    "Defend", getpos zone_hold, {true}, {triggerActivated exfil_done}
] spawn tsp_fnc_task;
[
    Spectre_1, ["Rtb"], "Return To Base", "Thanks to your efforts, Timberwolf has successfully exracted from the AO. Good work Spectre RTB.", 
    "Move", getpos rtb_1, {triggerActivated exfil_done}, {triggerActivated rtb1}
] spawn tsp_fnc_task;
[
    [T1, T2, T3], ["run"], "Head to the Farm", "The Chinook will be swarmed soon, Get out of the AO quick.", 
    "Move", getpos zone_hold, {true}, {triggerActivated farm}
] spawn tsp_fnc_task;
[
    [T1, T2, T3], ["hold"], "Hold out until Exfil arrives", "Other Helos are currently tasked elsewhere. Dig in and defend the farm.", 
    "Defend", getpos zone_hold, {triggerActivated farm}, {!isNil "wavesFinished"}
] spawn tsp_fnc_task;
[
    [T1, T2, T3], ["exfil"], "Get to the Heli", "High command is able to task a heli to you, Callsign Ugly 1 is ETA 1 mike out.", 
    "Heli", getpos zone_exract, {!isNil "wavesFinished"}, {triggerActivated exfil_done}
] spawn tsp_fnc_task;
[
    [T1, T2, T3], ["hvt"], "Bring Militia Officer back", "Bring the HVT back alive.", "Meet", objnull, 
    {true}, {count ([Hvt1] select {alive _x && (_x inArea hvt_out)}) > 0}, 
    {count ([Hvt1] select {alive _x}) == 0}
] spawn tsp_fnc_task;