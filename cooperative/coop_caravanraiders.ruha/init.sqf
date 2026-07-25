[player, [
	"rhs_vdv_arifleman_rpk","rhs_vdv_arifleman","rhs_vdv_engineer","rhs_vdv_efreitor",
	"rhs_vdv_grenadier_rpg","rhs_vdv_strelok_rpg_assist","rhs_vdv_machinegunner_assistant","rhs_vdv_junior_sergeant",
	"rhs_vdv_machinegunner","rhs_vdv_marksman","rhs_vdv_medic","rhs_vdv_marksman_asval",
	"rhs_vdv_rifleman_asval","rhs_vdv_grenadier","rhs_vdv_LAT","rhs_vdv_rifleman",
	"rhs_vdv_rifleman_alt","rhs_vdv_grenadier_alt","rhs_vdv_RShG2","rhs_vdv_sergeant",
	"rhs_vdv_recon_arifleman_rpk","rhs_vdv_recon_arifleman","rhs_vdv_recon_efreitor","rhs_vdv_recon_machinegunner_assistant",
	"rhs_vdv_recon_marksman_vss","rhs_vdv_recon_marksman","rhs_vdv_recon_rifleman","rhs_vdv_recon_marksman_asval",
	"rhs_vdv_recon_medic","rhs_vdv_recon_rifleman_ak103","rhs_vdv_recon_rifleman_akms","rhs_vdv_recon_rifleman_l",
	"rhs_vdv_recon_rifleman_asval","rhs_vdv_recon_grenadier","rhs_vdv_recon_grenadier_scout","rhs_vdv_recon_arifleman_scout",
	"rhs_vdv_recon_arifleman_rpk_scout","rhs_vdv_recon_sergeant","rhs_vdv_recon_rifleman_lat","rhs_vdv_recon_rifleman_scout_akm",
	"rhs_vdv_recon_rifleman_scout"
], [zone_zombie], east, {true}, {}, 400, 1, 30, 600] spawn tsp_fnc_zombience;

if (!isServer) exitWith {};

[west, ["bridge_south"], "Destroy South Bridge", "Disable the rails on the southern bridge to prevent the train from escaping.", "Destroy", getPos task_bridge_south1, {true}, {!alive task_bridge_south1 && !alive task_bridge_south2}] spawn tsp_fnc_task;
[west, ["bridge_north"], "Destroy North Bridge", "Disable the rails on the northern bridge to prevent the train from escaping.", "Destroy", getPos task_bridge_north1, {true}, {!alive task_bridge_north1 && !alive task_bridge_north2}] spawn tsp_fnc_task;
[west, ["cargo"], "Destroy Cargo", "Destroy the ammo, fuel and vehicles.", "Destroy", getPos task_cargo8, {"bridge_south" call BIS_fnc_taskState in ["SUCCEEDED","FAILED"] && "bridge_north" call BIS_fnc_taskState in ["SUCCEEDED","FAILED"]}, {count ([task_cargo1,task_cargo2,task_cargo3,task_cargo4,task_cargo5,task_cargo6,task_cargo7,task_cargo8] select {!alive _x}) > 6}] spawn tsp_fnc_task;
[west, ["engine"], "Destroy Engine", "Destroy the train engine to prevent its future use.", "Destroy", getPos task_train, {"bridge_north" call BIS_fnc_taskState in ["SUCCEEDED","FAILED"] && "bridge_north" call BIS_fnc_taskState in ["SUCCEEDED","FAILED"]}, {!alive task_train}] spawn tsp_fnc_task;