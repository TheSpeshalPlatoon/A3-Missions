//____________________________________________
// LSS Config.cpp
// Author: Dodzh
//____________________________________________

class CfgLootSettings
{
	spawnAtStart = 1; //if 1 will will created a task that spawn loot on an interval based on lootInterval to every player
	lootInterval = 20; //time in seconds how often loot is created, only used if spawnAtStart = 1
	spawnRange = 80; //in meters, this is only used if spawnAtStart is 1, a manual range can bet set if [<pos>,<range>] spawn LSS_fnc_spawn_loot; is used
	maxLootTime = 60*15; //time in seconds the loot will last at any given spot
	maxPleyerSpeed = 50; //only used only used if spawnAtStart is 1, determines if loot should be spawned based on the speed of player 

	cleanAtStart = 1; //starts a thread cleaning every "cleanupInterval", if 0 then manual cleanup is required [] spawn LSS_fnc_cleanup;
	cleanupInterval = 20; //time in seconds how often is check to deleted expired loot, only used if cleanAtStart = 1

	useModelPositions = 1; //if the building is not defined under CfgBuildings will try to spawn loot on predefined points on building model
	fillBackPacks = 1; //if true backpacks will be filled with items from the items[] section. values 0=false 1=true 
	
	maxLootPositions = 7; //max loot position per building
	maxLootPercentile = 0.40; //porcentage based on the maxed loot spots per building
	minLootPerSpot = 1;
    maxLootPerSpot = 8; //max items per loot position
	
	minMagazinesPerWeapon = 1;
	maxMagazinesPerWeapon = 3;
	
	debug = 0; //if 1 will create marker and helpers on the map
};

class CfgLootTables
{
    class Military
    {
        ratio[] = 
		{
			"weapons",10,
			"backpacks",1,
			"uniforms",1,
			"items",1
		};
		weapons[] = 
		{
			"rhs_weap_ak74",10,
			"rhs_weap_ak74_gp25",2,
			"rhs_weap_ak74_2",1,
			"rhs_weap_ak74n",1,
			"rhs_weap_akm",1,
			"rhs_weap_akm_gp25",1,
			"rhs_weap_akms",1,
			"rhs_weap_akms_gp25",1,
			"rhs_weap_aks74",5,
			"rhs_weap_aks74_gp25",2,
			"rhs_weap_aks74_2",1,
			"rhs_weap_aks74u",1,
			"rhs_weap_aks74un",1,
			"rhs_weap_pkm",2,
			"rhs_weap_pm63",0.5,
			"rhs_weap_scorpion",0.5,
			"rhs_weap_savz61",0.5,
			"rhs_weap_svdo",0.5,
			"rhs_weap_igla",0.5,
			"rhs_weap_rpg18",1,
			"rhs_weap_rpg26",5,
			"rhs_weap_rpg7",5,
			"rhs_weap_rshg2",1,
			"rhs_weap_6p53",0.5,
			"rhs_weap_pb_6p9",0.5,
			"rhs_weap_makarov_pm",5,
			"rhs_weap_savz61_folded",0.5,
			"tsp_meleeWeapon_ak",5,
			"tsp_meleeWeapon_mpl50_black",5,
			"tsp_meleeWeapon_mpl50",5
        };
		backpacks[] = 
		{
			"rhs_medic_bag",5,
			"rhs_rd54_flora1",15,
			"rhs_rd54_flora2",15,
			"rhs_rpg_2",5,
			"rhs_rpg_empty",5,
			"rhs_sidor",15
        };        
		items[] = 
		{
			"FirstAidKit",2,
			"ToolKit",1,			
			"ACE_fieldDressing",1,
			"ACE_bodyBag",1,
			"ACE_CableTie",1,
			"ACE_Cellphone",1,
			"dev_enzyme",1,
			"ACE_epinephrine",1,
			"tsp_fire_canister",1,
			"tsp_lockpick",1,
			"ACE_morphine",1,
			"ACE_Humanitarian_Ration",1,
			"tsp_paperclip",1,
			"ACE_wirecutter",1,
			"ItemMap",1,
			"ItemCompass",1,
			"ItemWatch",1,			

			"rhs_beanie_green",1,
			"rhs_ushanka",1,
			"rhs_beanie_green",1,
			"rhs_beret_milp",1,
			"rhs_cossack_visor_cap_tan",1,
			"rhs_fieldcap_vsr",1,
			"rhs_headband",1,
			"rhs_ssh68_2",1,
			"rhs_tsh4",1,
			"G_Balaclava_oli",1,
			"rhs_scarf",1,

			//"G_LEN_BCG",1,
			"G_Spectacles",1,
			//"G_Squares",1,
			"Binocular",1,

			"rhs_6b3",15,
			"rhs_6b3_holster",1,
			"rhs_6b3_off",1,
			"rhs_6b3_R148",1,
			"rhs_6b3_AK",15,
			"rhs_6b3_AK_2",1,
			"rhs_6b3_AK_3",1,
			"rhs_6b3_VOG",1,
			"rhs_6b3_VOG_2",1,
			"rhs_6b5_khaki",15,
			"rhs_6b5_rifleman_khaki",1,
			"rhs_6b5_medic_khaki",1,
			"rhs_6b5_officer_khaki",1,
			"rhs_6b5_sniper_khaki",1,
			"rhs_6b5",15,
			"rhs_6b5_rifleman",15,
			"rhs_6b5_medic",1,
			"rhs_6b5_officer",1,
			"rhs_6b5_sniper",1,
			"rhs_6b5_vsr",1,
			"rhs_6b5_rifleman_vsr",1,
			"rhs_6b5_medic_vsr",1,
			"rhs_6b5_officer_vsr",1,
			"rhs_6b5_sniper_vsr",1,
			"rhs_chicom",25,
			"rhs_chicom_khk",25,
			"rhs_lifchik_NCO",1,
			"rhs_lifchik_vog",1,
			"rhs_lifchik",1,
			"rhs_lifchik_light",1,
			"rhs_vest_commander",1,
			"rhs_gear_OFF",1,
			"rhs_vest_pistol_holster",1,
			"rhs_vydra_3m",5
        };
		uniforms[] = 
		{
			"rhs_uniform_df15",1,
			"rhs_uniform_gorka_1_a",1,
			"rhs_uniform_klmk_oversuit",1,
			"rhs_uniform_afghanka_klmk",1,
			"rhs_uniform_afghanka_vsr_2",10,
			"rhs_uniform_afghanka_para_vsr_2",10,
			"rhs_uniform_afghanka_winter_vsr_2",10,
			"rhs_uniform_afghanka_winter_boots_vsr_2",10,
			"rhs_uniform_omon",1
        };
    };

	class Medical
    {
        ratio[] = 
		{
			"weapons",1,
			"backpacks",1,
			"uniforms",1,
			"items",4
		};
		weapons[] = 
		{
			"sgun_HunterShotgun_01_F",4,
			"sgun_HunterShotgun_01_sawedoff_F",4,
			"rhs_weap_Izh18",4,
			"rhs_weap_kar98k",1,
			"rhs_weap_m38",1,
			"rhs_weap_savz61",1,
			"rhs_weap_scorpion",1,
			"hgun_Pistol_Signal_F",1,
			"hgun_Pistol_01_F",1,
			"RH_python",1,
			"RH_cz75",1,
			"RH_Deagles",0.5,
			"RH_Deagleg",0.5,
			"RH_ttracker",0.5,
			"RH_ttracker_g",0.5,
			"rhs_weap_makarov_pm",4,
			"rhs_weap_rsp30_white",1,
			"rhs_weap_rsp30_green",1,
			"rhs_weap_rsp30_red",1,
			"rhs_weap_savz61_folded",2,
			"rhs_weap_tt33",1,
			"tsp_meleeWeapon_kabar",4,
			"tsp_meleeWeapon_fireaxe",1
        };
		backpacks[] = 
		{
			"B_CivilianBackpack_01_Everyday_Black_F",1,
			"B_CivilianBackpack_01_Sport_Blue_F",1,
			"B_CivilianBackpack_01_Sport_Green_F",1,
			"B_CivilianBackpack_01_Sport_Red_F",1
        };
		items[] = 
		{
			"FirstAidKit",10,
			"Medikit",10,
			"ACE_adenosine",1,
			"ACE_atropine",1,
			"ACE_fieldDressing",1,
			"ACE_elasticBandage",1,
			"ACE_quikclot",1,
			"ACE_bloodIV",1,
			"ACE_bloodIV_250",1,
			"ACE_bloodIV_500",1,
			"ACE_bodyBag",1,
			"ACE_Cellphone",1,
			"dev_enzyme",1,
			"dev_enzyme_refined",1,
			"ACE_epinephrine",1,
			"tsp_fire_canister",1,
			"ACE_morphine",1,
			"ACE_Humanitarian_Ration",1,
			"tsp_paperclip",1,
			"ACE_WaterBottle",1,
			"ACE_WaterBottle_Empty",1,
			"ACE_WaterBottle_Half",1,
			
			"H_HeadBandage_clean_F",1,
			"H_HeadBandage_stained_F",1,
			"H_HeadBandage_bloody_F",1,
			"tsp_gear_horse",1,
			
			"G_Respirator_white_F",1,
			"G_Respirator_yellow_F",1,
			"G_Respirator_blue_F",1
        };
		uniforms[] = 
		{
			"U_Marshal",1,
			"a2_hladik",1,
			"a2_harris2",1,
			"a2_harris",1,
			"a2_pilot",1,
			"a2_hladik2",1,
			"UK3CB_CHC_C_U_DOC_02",1,
			"UK3CB_CHC_C_U_DOC_01",1,
			"a2_baker",1,
			"a2_euro1",1,
			"U_C_FormalSuit_01_tshirt_black_F",1,
			"U_C_FormalSuit_01_tshirt_gray_F",1
        };
    };

	class Emergency
    {
        ratio[] = 
		{
			"weapons",5,
			"backpacks",1,
			"uniforms",1,
			"items",5
		};
		weapons[] = 
		{
			"rhs_weap_makarov_pm",4,
			"rhs_weap_rsp30_white",1,
			"rhs_weap_rsp30_green",1,
			"rhs_weap_rsp30_red",1,
			"rhs_weap_savz61_folded",2,
			"rhs_weap_tt33",1,
			"tsp_meleeWeapon_fireaxe",20
        };
		backpacks[] = 
		{
			"B_CivilianBackpack_01_Everyday_Black_F",1,
			"B_CivilianBackpack_01_Sport_Blue_F",1,
			"B_CivilianBackpack_01_Sport_Green_F",1,
			"B_CivilianBackpack_01_Sport_Red_F",1
        };
		items[] = 
		{
			"FirstAidKit",10,
			"Medikit",10,
			"ACE_adenosine",1,
			"ACE_atropine",1,
			"ACE_fieldDressing",1,
			"ACE_elasticBandage",1,
			"ACE_quikclot",1,
			"ACE_bloodIV",1,
			"ACE_bloodIV_250",1,
			"ACE_bloodIV_500",1,
			"ACE_bodyBag",1,
			"ACE_Cellphone",1,
			"dev_enzyme",1,
			"dev_enzyme_refined",1,
			"ACE_epinephrine",1,
			"tsp_fire_canister",1,
			"ACE_morphine",1,
			"ACE_Humanitarian_Ration",1,
			"tsp_paperclip",1,
			"ACE_WaterBottle",1,
			"ACE_WaterBottle_Empty",1,
			"ACE_WaterBottle_Half",1,
			
			"H_HeadBandage_clean_F",1,
			"H_HeadBandage_stained_F",1,
			"H_HeadBandage_bloody_F",1,
			
			"G_Respirator_white_F",1,
			"G_Respirator_yellow_F",1,
			"G_Respirator_blue_F",1
        };
		uniforms[] = 
		{
			"UK3CB_CHC_C_U_DOC_01",20,
			"UK3CB_CHC_C_U_DOC_02",1
        };
    };

	class Industrial
    {
        ratio[] = 
		{
			"weapons",4,
			"backpacks",1,
			"uniforms",1,
			"items",4
		};
		weapons[] = 
		{
			"sgun_HunterShotgun_01_F",4,
			"sgun_HunterShotgun_01_sawedoff_F",4,
			"rhs_weap_Izh18",4,
			"rhs_weap_kar98k",1,
			"rhs_weap_m38",1,
			"rhs_weap_savz61",1,
			"rhs_weap_scorpion",1,
			"hgun_Pistol_Signal_F",1,
			"hgun_Pistol_01_F",1,
			"RH_python",1,
			"RH_cz75",1,
			"RH_Deagles",0.5,
			"RH_Deagleg",0.5,
			"RH_ttracker",0.5,
			"RH_ttracker_g",0.5,
			"rhs_weap_makarov_pm",4,
			"rhs_weap_rsp30_white",1,
			"rhs_weap_rsp30_green",1,
			"rhs_weap_rsp30_red",1,
			"rhs_weap_savz61_folded",2,
			"rhs_weap_tt33",1,
			"tsp_meleeWeapon_kabar",4,
			"tsp_meleeWeapon_splittingaxe",4
        };
		backpacks[] = 
		{
			"B_CivilianBackpack_01_Everyday_Black_F",1,
			"B_CivilianBackpack_01_Sport_Blue_F",1,
			"B_Messenger_Black_F",1,
			"B_Messenger_Coyote_F",1,
			"B_Messenger_Gray_F",1,
			"B_CivilianBackpack_01_Everyday_Black_F",1
        };
		items[] = 
		{
			"FirstAidKit",2,
			"ToolKit",10,			
			"ACE_fieldDressing",1,
			"ACE_CableTie",1,
			"ACE_Can_Franta",1,
			"ACE_Can_RedGull",1,
			"ACE_Can_Spirit",1,
			"dev_enzyme",1,
			"tsp_fire_canister",1,
			"tsp_lockpick",1,
			"ACE_morphine",1,
			"tsp_paperclip",1,
			"ACE_WaterBottle_Empty",1,
			"ACE_WaterBottle_Half",1,
			"ACE_wirecutter",1,
			
			"H_Bandanna_gry",1,
			"H_Bandanna_blu",1,
			"H_Bandanna_cbr",1,
			"H_Bandanna_khk",1,
			"H_Bandanna_sgg",1,
			"H_Bandanna_sand",1,
			"H_Bandanna_surfer",1,
			"H_Bandanna_surfer_blk",1,
			"H_Bandanna_surfer_grn",1,
			"H_Bandanna_camo",1,
			"H_Cap_blk",1,
			"H_Cap_blu",1,
			"H_Cap_grn",1,
			"H_Cap_oli",1,
			"H_Cap_red",1,
			"H_Cap_tan",1,
			"UK3CB_H_Worker_Cap_04",1,
			"UK3CB_H_Worker_Cap_02",1,
			"UK3CB_H_Worker_Cap_03",1,
			"UK3CB_H_Worker_Cap_01",1,
			"rhs_beanie_green",1,
			"rhs_ushanka",1,
			"H_Construction_basic_white_F",50,
			"H_Construction_basic_yellow_F",50,

			"G_Aviator",1,
			"G_Spectacles",1,
			"G_Squares_Tinted",1,
			"G_Squares",1
        };
		uniforms[] = 
		{
			"U_BG_Guerrilla_6_1",1,
			"U_BG_Guerilla2_2",1,
			"U_BG_Guerilla2_1",1,
			"U_BG_Guerilla2_3",1,
			"U_BG_Guerilla3_1",1,
			"U_C_Poor_1",1,
			"U_I_C_Soldier_Bandit_2_F",1,
			"U_C_Man_casual_1_F",1,
			"U_C_Man_casual_2_F",1,
			"U_C_Man_casual_3_F",1,
			"U_C_Mechanic_01_F",1,
			"UK3CB_CHC_C_U_CIT_05",1,
			"UK3CB_CHC_C_U_CIT_01",1,
			"UK3CB_CHC_C_U_CIT_04",1,
			"UK3CB_CHC_C_U_CIT_02",1,
			"UK3CB_CHC_C_U_COACH_01",1,
			"UK3CB_CHC_C_U_VILL_01",1,
			"UK3CB_CHC_C_U_VILL_02",1,
			"UK3CB_CHC_C_U_VILL_03",1,
			"UK3CB_CHC_C_U_VILL_04",1,
			"UK3CB_CHC_C_U_WOOD_01",1,
			"UK3CB_CHC_C_U_WOOD_02",1,
			"UK3CB_CHC_C_U_WOOD_03",1,
			"UK3CB_CHC_C_U_WOOD_04",1,
			"U_C_ConstructionCoverall_Red_F",1,
			"U_C_ConstructionCoverall_Blue_F",1,
			"U_C_ConstructionCoverall_Black_F",1
        };
    };

	class defaults //dont delete this table as any building not defined will spawn items based on this table
    {
        ratio[] = 
		{
			"weapons",4,
			"backpacks",1,
			"uniforms",1,
			"items",4
		};
		weapons[] = 
		{
			"sgun_HunterShotgun_01_F",4,
			"sgun_HunterShotgun_01_sawedoff_F",4,
			"rhs_weap_Izh18",4,
			"rhs_weap_kar98k",1,
			"rhs_weap_m38",1,
			"rhs_weap_savz61",1,
			"rhs_weap_scorpion",1,
			"hgun_Pistol_Signal_F",1,
			"hgun_Pistol_01_F",1,
			"RH_python",1,
			"RH_cz75",1,
			"RH_Deagles",0.5,
			"RH_Deagleg",0.5,
			"RH_ttracker",0.5,
			"RH_ttracker_g",0.5,
			"rhs_weap_makarov_pm",4,
			"rhs_weap_rsp30_white",1,
			"rhs_weap_rsp30_green",1,
			"rhs_weap_rsp30_red",1,
			"rhs_weap_savz61_folded",2,
			"rhs_weap_tt33",1,
			"tsp_meleeWeapon_kabar",4,
			"tsp_acoustic",1,
			"tsp_meleeWeapon_splittingaxe",4
        };
		backpacks[] = 
		{
			"B_CivilianBackpack_01_Everyday_Black_F",1,
			"B_CivilianBackpack_01_Sport_Blue_F",1,
			"B_Messenger_Black_F",1,
			"B_Messenger_Coyote_F",1,
			"B_Messenger_Gray_F",1,
			"B_CivilianBackpack_01_Everyday_Black_F",1
        };
		items[] = 
		{
			"FirstAidKit",2,
			"ToolKit",1,			
			"ACE_fieldDressing",1,
			"ACE_bodyBag",1,
			"ACE_CableTie",1,
			"ACE_Can_Franta",1,
			"ACE_Can_RedGull",1,
			"ACE_Can_Spirit",1,
			"ACE_Cellphone",1,
			"dev_enzyme",1,
			"ACE_epinephrine",1,
			"tsp_fire_canister",1,
			"tsp_lockpick",1,
			"ACE_morphine",1,
			"ACE_Humanitarian_Ration",1,
			"tsp_paperclip",1,
			"ACE_WaterBottle",1,
			"ACE_WaterBottle_Empty",1,
			"ACE_WaterBottle_Half",1,
			"ACE_wirecutter",1,
			"ItemMap",1,
			"ItemCompass",1,
			"ItemWatch",1,
			
			"H_Bandanna_gry",1,
			"H_Bandanna_blu",1,
			"H_Bandanna_cbr",1,
			"H_Bandanna_khk",1,
			"H_Bandanna_sgg",1,
			"H_Bandanna_sand",1,
			"H_Bandanna_surfer",1,
			"H_Bandanna_surfer_blk",1,
			"H_Bandanna_surfer_grn",1,
			"H_Bandanna_camo",1,
			"H_Cap_blk",1,
			"H_Cap_blu",1,
			"H_Cap_grn",1,
			"H_Cap_oli",1,
			"H_Cap_red",1,
			"H_Cap_tan",1,
			"H_Hat_blue",1,
			"H_Hat_brown",1,
			"H_Hat_camo",1,
			"H_Hat_checker",1,
			"H_Hat_grey",1,
			"H_Hat_tan",1,
			"H_StrawHat_dark",1,
			"rds_Woodlander_cap1",1,
			"rds_Woodlander_cap2",1,
			"rds_Woodlander_cap3",1,
			"rds_Woodlander_cap4",1,
			"rds_Villager_cap1",1,
			"rds_Villager_cap2",1,
			"rds_Villager_cap3",1,
			"rds_Villager_cap4",1,
			"rds_worker_cap1",1,
			"rds_worker_cap2",1,
			"rds_worker_cap3",1,
			"rds_worker_cap4",1,
			"rhs_beanie_green",1,
			"rhs_ushanka",1,
			"rhs_xmas_antlers",1,
			"H_Hat_Safari_sand_F",1,
			"H_Hat_Safari_olive_F",1,
			"tsp_horse",1,

			"G_Aviator",1,
			"G_LEN_BCG",1,
			"G_Lady_Blue",1,
			"G_Shades_Black",1,
			"G_Shades_Blue",1,
			"G_Shades_Green",1,
			"G_Shades_Red",1,
			"G_Spectacles",1,
			"G_Sport_Red",1,
			"G_Sport_Blackyellow",1,
			"G_Sport_BlackWhite",1,
			"G_Sport_Checkered",1,
			"G_Sport_Blackred",1,
			"G_Sport_Greenblack",1,
			"G_Squares_Tinted",1,
			//"G_Squares",1,
			"G_Spectacles_Tinted",1,
			"Binocular",1
        };
		uniforms[] = 
		{
			"UK3CB_CHC_C_U_CIT_05",1,
			"UK3CB_CHC_C_U_CIT_01",1,
			"UK3CB_CHC_C_U_CIT_04",1,
			"UK3CB_CHC_C_U_CIT_02",1,
			"UK3CB_CHC_C_U_CIT_03",1,
			"UK3CB_CHC_C_U_ACTIVIST_03",1,
			"UK3CB_CHC_C_U_ACTIVIST_05",1,
			"UK3CB_CHC_C_U_ACTIVIST_01",1,
			"UK3CB_CHC_C_U_ACTIVIST_04",1,
			"UK3CB_CHC_C_U_ACTIVIST_02",1,
			"UK3CB_CHC_C_U_COACH_04",1,
			"UK3CB_CHC_C_U_COACH_01",1,
			"UK3CB_CHC_C_U_COACH_03",1,
			"UK3CB_CHC_C_U_COACH_05",1,
			"UK3CB_CHC_C_U_COACH_02",1,
			"UK3CB_CHC_C_U_WORK_03",1,
			"UK3CB_CHC_C_U_WORK_04",1,
			"UK3CB_CHC_C_U_WORK_02",1,
			"UK3CB_CHC_C_U_WORK_01",1,
			"UK3CB_CHC_C_U_PROF_04",1,
			"UK3CB_CHC_C_U_PROF_03",1,
			"UK3CB_CHC_C_U_PROF_01",1,
			"UK3CB_CHC_C_U_PROF_02",1,
			"UK3CB_CHC_C_U_VILL_01",1,
			"UK3CB_CHC_C_U_VILL_03",1,
			"UK3CB_CHC_C_U_VILL_04",1,
			"UK3CB_CHC_C_U_VILL_02",1,
			"UK3CB_CHC_C_U_WOOD_04",1,
			"UK3CB_CHC_C_U_WOOD_01",1,
			"UK3CB_CHC_C_U_WOOD_02",1,
			"UK3CB_CHC_C_U_WOOD_03",1,
			"U_BG_Guerrilla_6_1",1,
			"U_BG_Guerilla2_2",1,
			"U_BG_Guerilla2_1",1,
			"U_BG_Guerilla2_3",1,
			"U_BG_Guerilla3_1",1,
			"U_C_HunterBody_grn",1,
			"U_Marshal",1,
			"U_C_Poor_1",1,
			"U_I_C_Soldier_Bandit_2_F",1,
			"U_C_Man_casual_1_F",1,
			"U_C_Man_casual_2_F",1,
			"U_C_Man_casual_3_F",1,
			"a2_mechanic1",1,
			"a2_mechanic2",1,
			"a2_pilot",1,
			"U_C_FormalSuit_01_black_F",1,
			"U_C_FormalSuit_01_gray_F",1,
			"U_C_FormalSuit_01_blue_F",1,
			"U_C_FormalSuit_01_khaki_F",1,
			"U_C_FormalSuit_01_tshirt_black_F",1,
			"U_C_FormalSuit_01_tshirt_gray_F",1
        };
    };
};

class CfgBuildings //custom position relative the the model, some buildings dont have positions defined on the model or simply you want your own spots
{
	class land_pozorovatelna {table = "Military";};
	class land_AII_last_floor {table = "Military";};
	class land_AII_middle_floor {table = "Military";};
	class land_AII_upper_part {table = "Military";};
	class Land_Hlidac_budka {table = "Military";};
	class land_x_skladiste_low_tex {table = "Military";};
	class land_Tovarna1 {table = "Military";};
	class Land_ns_Jbad_Mil_House {table = "Military";};
	class Land_ns_Jbad_Mil_ControlTower {table = "Military";};
	class Land_vys_budova_p1 {table = "Military";};
	class Land_ns_Jbad_Mil_Guardhouse_winter {table = "Military";};
	class Land_budova4_winter {table = "Military";};
	class land_x_vetraci_komin {table = "Military";};
	class Land_Mil_Barracks_i {table = "Military";};
	class land_st_vez {table = "Military";};
	class land_x_vez_tex {table = "Military";};
	class Land_vez {table = "Military";};
	class Land_vys_budova_p2 {table = "Military";};
	class Land_ns_Jbad_Mil_Guardhouse {table = "Military";};
	class land_terain_velke_panely {table = "Military";};
	class land_terain_base_a {table = "Military";};
	class land_seb_rozvodna {table = "Military";};
	class land_seb_bouda3 {table = "Military";};
	class Land_bouda2_vnitrek {table = "Military";};
	class land_vstup {table = "Military";};

	class Land_A_Office01 {table = "Medical";};
	class Land_A_Office02 {table = "Medical";};
	class Land_A_Hospital {table = "Medical";};
	class Land_ns_Jbad_A_Stationhouse {table = "Emergency";};

	class Land_A_CraneCon {table = "Industrial";};
	class Land_Misc_Cargo1Ao {table = "Industrial";};
	class Land_Ind_Workshop01_04 {table = "Industrial";};
	class Land_Ind_Workshop01_02 {table = "Industrial";};
	class Land_Ind_Workshop01_01 {table = "Industrial";};
	class land_f_b1 {table = "Industrial";};
	class Land_ns_jbad_hangar_2 {table = "Industrial";};
	class land_hala1 {table = "Industrial";};
	class land_provoz2 {table = "Industrial";};
	class land_sklad2 {table = "Industrial";};
	class Land_leseni4x {table = "Industrial";};
	class land_seb_main_fac {table = "Industrial";};
	class land_seb_near_fac {table = "Industrial";};
	class Land_WIP_F {table = "Industrial";};
	class land_part2 {table = "Industrial";};
	class land_garaze {table = "Industrial";};
	class land_cast1 {table = "Industrial";};
	class land_cast2 {table = "Industrial";};
	class Land_Ind_Pec_03b {table = "Industrial";};
	class Land_Ind_Pec_03a {table = "Industrial";};
	class Land_Tovarna2 {table = "Industrial";};
	class Land_Shed_Ind02 {table = "Industrial";};
};