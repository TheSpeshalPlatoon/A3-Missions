if !("tsp_gear_fast" in activatedAddons) then {
    soc_all = getMissionConfigValue ["soc_all", [""]] + ["rhsusf_opscore_coy_cover","rhsusf_opscore_coy_cover_pelt","rhsusf_opscore_fg","rhsusf_opscore_fg_pelt","rhsusf_opscore_fg_pelt_cam","rhsusf_opscore_fg_pelt_nsw","rhsusf_opscore_mc_cover","rhsusf_opscore_mc_cover_pelt","rhsusf_opscore_mc_cover_pelt_nsw","rhsusf_opscore_mc_cover_pelt_cam","rhsusf_opscore_mc","rhsusf_opscore_mc_pelt","rhsusf_opscore_mc_pelt_nsw","rhsusf_opscore_paint","rhsusf_opscore_paint_pelt","rhsusf_opscore_paint_pelt_nsw","rhsusf_opscore_paint_pelt_nsw_cam","rhsusf_opscore_rg_cover","rhsusf_opscore_rg_cover_pelt","rhsusf_opscore_ut","rhsusf_opscore_ut_pelt","rhsusf_opscore_ut_pelt_cam","rhsusf_opscore_ut_pelt_nsw","rhsusf_opscore_ut_pelt_nsw_cam","rhsusf_opscore_mar_fg","rhsusf_opscore_mar_fg_pelt","rhsusf_opscore_mar_ut","rhsusf_opscore_mar_ut_pelt"];
    soc_seal = getMissionConfigValue ["soc_seal", [""]] + ["rhsusf_opscore_aor1","rhsusf_opscore_aor1_pelt","rhsusf_opscore_aor1_pelt_nsw","rhsusf_opscore_aor2","rhsusf_opscore_aor2_pelt","rhsusf_opscore_aor2_pelt_nsw"];
};

[] spawn {
    waitUntil {sleep 1; !isNull findDisplay 46};  //-- Wait until loaded in
    [player, [zone_play], "You are out of bounds!", {[_this, [zone_play, zone_captive]] spawn tsp_fnc_zone_launch}, {alive _this}, 1, 1] spawn tsp_fnc_zone;
    player addEventHandler ["Respawn", {[player, [zone_play], "You are out of bounds!", {[_this, [zone_play, zone_captive]] spawn tsp_fnc_zone_launch}, {alive _this}, 1, 1] spawn tsp_fnc_zone}];
    while {sleep 1; true} do {
        1 fadeEnvironment (if (player inArea zone_inside_1 || player inArea zone_inside_2) then {0.25} else {1});
        player setCaptive (player inArea zone_captive || "Oppos" in (player getVariable ["role", ""]));  //-- Captive on the catwalk
        if (player inArea zone_banana && random 1 < 0.25 && speed player > 5) then {playSound3D ["tsp_core\data\sounds\slip.ogg", player, true, getPosASL player, 5, 1, 10]; [player, [player]] spawn tsp_fnc_zone_launch};
    };
};

[player, ["rhsgref_ins_grenadier_rpg","rhsgref_ins_arifleman_rpk","rhsgref_ins_crew","rhsgref_ins_machinegunner","rhsgref_ins_medic","rhsgref_ins_militiaman_mosin","rhsgref_ins_rifleman","rhsgref_ins_rifleman_akm","rhsgref_ins_rifleman_aks74","rhsgref_ins_rifleman_aksu","rhsgref_ins_grenadier","rhsgref_ins_rifleman_RPG26","rhsgref_ins_saboteur","rhsgref_ins_engineer","rhsgref_ins_sniper","rhsgref_ins_spotter"], [zone_zombie], east, {true}, {}, 200, 2, 30, 400] spawn tsp_fnc_zombience;

if (!isServer) exitWith {}; 

[west,"pilot","Rescue Pilot","Pilots stuck at the crash site need to be evacuated.","Heli",getPos task_pilot,{true},{[task_pilot, [zone_capture]] call tsp_fnc_zone_triggers},{!alive task_pilot}] spawn tsp_fnc_task;
[west,"hvt1","Kill/Capture","Dead or alive.","Kill",getPos task_hvt1,{true},{[task_hvt1, [zone_capture]] call tsp_fnc_zone_triggers || !alive task_hvt1}] spawn tsp_fnc_task;
[west,"hvt2","Kill/Capture","Dead or alive.","Kill",getPos task_hvt2,{true},{[task_hvt2, [zone_capture]] call tsp_fnc_zone_triggers || !alive task_hvt2}] spawn tsp_fnc_task;
[west,"hvt3","Kill/Capture","Dead or alive.","Kill",getPos task_hvt3,{true},{[task_hvt3, [zone_capture]] call tsp_fnc_zone_triggers || !alive task_hvt3}] spawn tsp_fnc_task;
[west,"cache1","Destroy Cache","Destroy ammo cache containing IEDs.","Rifle",getPos task_cache1,{true},{!alive task_cache1}] spawn tsp_fnc_task;
[west,"cache2","Destroy Cache","Destroy ammo cache containing IEDs.","Rifle",getPos task_cache2,{true},{!alive task_cache2}] spawn tsp_fnc_task;