[] spawn {
    waitUntil {sleep 1; !isNull findDisplay 46};  //-- Wait until loaded in
    [player, [zone_play], "You are out of bounds!", {[_this, [zone_play, zone_captive]] spawn tsp_fnc_zone_launch}, {alive _this}, 1, 1] spawn tsp_fnc_zone;
    player addEventHandler ["Respawn", {[player, [zone_play], "You are out of bounds!", {[_this, [zone_play, zone_captive]] spawn tsp_fnc_zone_launch}, {alive _this}, 1, 1] spawn tsp_fnc_zone}];
    player addEventHandler ["Killed", {tsp_loadout_retain = getUnitLoadout player}];  //-- Save loadout after death
    player addEventHandler ["Respawn", {player setUnitLoadout tsp_loadout_retain}];  //-- Restore loadout after respawn
    while {sleep 1; true} do {
        1 fadeEnvironment (if (player inArea zone_inside_1 || player inArea zone_inside_2) then {0.25} else {1});
        player setCaptive (player inArea zone_captive);  //-- Captive on the catwalk
        if (player inArea zone_banana && random 1 < 0.25 && speed player > 5) then {
            playSound3D ["tsp_core\data\sounds\slip.ogg", player, false, getPosASL player, 5, 1, 10];
            [player, [player]] spawn tsp_fnc_zone_launch;
        };
    };
};

[player, [
	"tsp_syn_thug1", "tsp_syn_thug2", "tsp_syn_thug3", "tsp_syn_thug4",	"tsp_syn_machinegunner", "tsp_syn_marksman",
	"I_C_Soldier_Bandit_1_F", "I_C_Soldier_Bandit_2_F", "I_C_Soldier_Bandit_3_F", "I_C_Soldier_Bandit_4_F", "I_C_Soldier_Bandit_5_F", "I_C_Soldier_Bandit_6_F",	"I_C_Soldier_Bandit_7_F", "I_C_Soldier_Bandit_8_F",
	"I_C_Soldier_Para_1_F",	"I_C_Soldier_Para_2_F",	"I_C_Soldier_Para_3_F",	"I_C_Soldier_Para_4_F",	"I_C_Soldier_Para_5_F",	"I_C_Soldier_Par_6_F","I_C_Soldier_Para_7_F", "I_C_Soldier_Para_8_F", "I_C_Soldier_Camo_F"
], [zone_zombie], resistance, {true}, {}, 250, 2, 30, 350] spawn tsp_fnc_zombience;

if (!isServer) exitWith {}; 

[west,"pilot","Rescue Pilot","Pilots stuck at the crash site need to be evacuated.","Heli",getPos task_pilot,{true},{[task_pilot, [zone_inside]] call tsp_fnc_zone_triggers},{!alive task_pilot}] spawn tsp_fnc_task;
[west,"hvt1","Kill/Capture","Dead or alive.","Kill",getPos task_hvt1,{true},{[task_hvt1, [zone_inside]] call tsp_fnc_zone_triggers || !alive task_hvt1}] spawn tsp_fnc_task;
[west,"hvt2","Kill/Capture","Dead or alive.","Kill",getPos task_hvt2,{true},{[task_hvt2, [zone_inside]] call tsp_fnc_zone_triggers || !alive task_hvt2}] spawn tsp_fnc_task;
[west,"hvt3","Kill/Capture","Dead or alive.","Kill",getPos task_hvt3,{true},{[task_hvt3, [zone_inside]] call tsp_fnc_zone_triggers || !alive task_hvt3}] spawn tsp_fnc_task;
[west,"cache1","Destroy Cache","Destroy ammo cache containing IEDs.","Rifle",getPos task_cache1,{true},{!alive task_cache1}] spawn tsp_fnc_task;
[west,"cache2","Destroy Cache","Destroy ammo cache containing IEDs.","Rifle",getPos task_cache2,{true},{!alive task_cache2}] spawn tsp_fnc_task;