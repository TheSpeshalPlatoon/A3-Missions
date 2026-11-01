class CfgPatches {
	class tsp_faction_usn {
		requiredAddons[] = {"UK3CB_Factions_Common_Editor","UK3CB_Factions_Equipment_Backpack","UK3CB_Factions_Equipment_Vests","UK3CB_Factions_Equipment_CW_Backpack_Soviet","UK3CB_Factions_Equipment_CW_Backpack_US","UK3CB_Factions_Equipment_CW_Soviet_Uniforms","UK3CB_Factions_Equipment_CW_SOV_Vests","UK3CB_Factions_Headgear","UK3CB_Factions_Uniforms","UK3CB_Factions_Equipment_CW_Headgear_Soviet","UK3CB_Factions_Equipment_CW_Headgear_US","UK3CB_Factions_Common","UK3CB_Factions_Equipment","UK3CB_Factions_Equipment_CW","UK3CB_Factions_Vehicles_Common","UK3CB_Factions_Vehicles_Armed_Boat","UK3CB_Factions_Vehicles_Fishing_Boat","UK3CB_Factions_Vehicles_Fishing_Vessel","UK3CB_Factions_Vehicles_Motorboat_Police","UK3CB_Factions_Vehicles_Rhib","UK3CB_Factions_Vehicles_Rubber_Rhib","UK3CB_Factions_Vehicles_Seafox","UK3CB_Factions_Vehicles_Skiff","UK3CB_Factions_Vehicles_Small_Boat","UK3CB_Factions_Vehicles_Bicycles","UK3CB_Factions_Vehicles_BRDM","UK3CB_Factions_Vehicles_BTR","UK3CB_Factions_Vehicles_BTR40","UK3CB_Factions_Vehicles_BTR60","UK3CB_Factions_Vehicles_BTR70","UK3CB_Factions_Vehicles_BTR80","UK3CB_Factions_Vehicles_Datsun","UK3CB_Factions_Vehicles_Forklift","UK3CB_Factions_Vehicles_GAZ_TIGR","UK3CB_Factions_Vehicles_Hilux","UK3CB_Factions_Vehicles_Ikarus","UK3CB_Factions_Vehicles_kraz255","UK3CB_Factions_Vehicles_Landcruiser","UK3CB_Factions_Vehicles_LandRover","UK3CB_Factions_Vehicles_M939","UK3CB_Factions_Vehicles_MaxxPro","UK3CB_Factions_Vehicles_Motorbikes","UK3CB_Factions_Vehicles_Octavia","UK3CB_Factions_Vehicles_Pickup","UK3CB_Factions_Vehicles_Quadbike","UK3CB_Factions_Vehicles_S1203","UK3CB_Factions_Vehicles_Scud","UK3CB_Factions_Vehicles_Sedan","UK3CB_Factions_Vehicles_Skoda","UK3CB_Factions_Vehicles_SUV","UK3CB_Factions_Vehicles_T810","UK3CB_Factions_Vehicles_Tractor","UK3CB_Factions_Vehicles_Transit","UK3CB_Factions_Vehicles_Typhoon","UK3CB_Factions_Vehicles_UAZ","UK3CB_Factions_Vehicles_Ural","UK3CB_Factions_Vehicles_V3S","UK3CB_Factions_Vehicles_Vodnik","UK3CB_Factions_Vehicles_Volha","UK3CB_Factions_Vehicles_VWGolf","UK3CB_Factions_Vehicles_Jeeps","UK3CB_Factions_Static_Searchlight","UK3CB_Factions_Vehicles_AC500","UK3CB_Factions_Vehicles_Antonov_An2","UK3CB_Factions_Vehicles_Bell412","UK3CB_Factions_Vehicles_C130J","UK3CB_Factions_Vehicles_C400","UK3CB_Factions_Vehicles_Cessna","UK3CB_Factions_Vehicles_DC3","UK3CB_Factions_Vehicles_MELB","UK3CB_Factions_Vehicles_Mi24","UK3CB_Factions_Vehicles_Mi8","UK3CB_Factions_Vehicles_Mig21","UK3CB_Factions_Vehicles_Mystere","UK3CB_Factions_Vehicles_Orca","UK3CB_Factions_Vehicles_Osprey","UK3CB_Factions_Vehicles_Shahed","UK3CB_Factions_Vehicles_SU25","UK3CB_Factions_Vehicles_Trojan","UK3CB_Factions_Vehicles_Shilka","UK3CB_Factions_Vehicles_AAV","UK3CB_Factions_Vehicles_BMP","UK3CB_Factions_Vehicles_LAV25","UK3CB_Factions_Vehicles_M1117","UK3CB_Factions_Vehicles_MTLB","UK3CB_Factions_Vehicles_M270","UK3CB_Factions_Vehicles_M60","UK3CB_Factions_Vehicles_Tseries","UK3CB_Factions_Vehicles_Lada","UK3CB_Factions_Vehicles_Civilian_Loadorder","UK3CB_Factions_Vehicles_Militia_LoadOrder","UK3CB_Factions_Vehicles_Military_LoadOrder","UK3CB_Factions_Vehicles_Police_LoadOrder"};
        units[] = {
            "tsp_usn_sailor",

            "tsp_usn_deck",
            "tsp_usn_deck_blue",
            "tsp_usn_deck_brown",
            "tsp_usn_deck_green",
            "tsp_usn_deck_red",
            "tsp_usn_deck_violet",
            "tsp_usn_deck_white",
            "tsp_usn_deck_yellow",

            "tsp_usn_pilot",
            "tsp_usn_jetpilot",
            
            "tsp_usn_helipilot",
            "tsp_usn_helicrew",

            "tsp_usn_seal_operator",
            "tsp_usn_seal_operatorat",
            "tsp_usn_seal_autorifleman",
            "tsp_usn_seal_marksman",
            "tsp_usn_seal_engineer",
            "tsp_usn_seal_breacher",
            "tsp_usn_seal_teamlead",
            "tsp_usn_seal_medic",

            "UK3CB_B_RHIB_USN",
            "UK3CB_B_RHIB_Gunboat_USN"
        };
	};
};

class CfgEditorSubCategories {class tsp_inf_crew {displayName = "Infantry (Crew)";}; class tsp_inf_seal {displayName = "Infantry (SEAL)"};};

class CfgVehicles {
    class rhsusf_navy_marpat_d_medic;
    class tsp_usn_sailor: rhsusf_navy_marpat_d_medic {displayName = "Sailor"; editorSubcategory = "tsp_inf_crew"; icon = "iconMan";};

    class tsp_usn_deck: tsp_usn_sailor {displayName = "Deck Crew";};
    class tsp_usn_deck_blue: tsp_usn_sailor {displayName = "Deck Crew (Blue)";};
    class tsp_usn_deck_brown: tsp_usn_sailor {displayName = "Deck Crew (Brown)";};
    class tsp_usn_deck_green: tsp_usn_sailor {displayName = "Deck Crew (Green)";};
    class tsp_usn_deck_red: tsp_usn_sailor {displayName = "Deck Crew (Red)";};
    class tsp_usn_deck_violet: tsp_usn_sailor {displayName = "Deck Crew (Violet)";};
    class tsp_usn_deck_white: tsp_usn_sailor {displayName = "Deck Crew (White)";};
    class tsp_usn_deck_yellow: tsp_usn_sailor {displayName = "Deck Crew (Yellow)";};

    class tsp_usn_pilot: tsp_usn_sailor {displayName = "Pilot";};
    class tsp_usn_jetpilot: tsp_usn_sailor {displayName = "Jet Pilot";};

    class tsp_usn_helipilot: tsp_usn_sailor {displayName = "Helicopter Pilot";};
    class tsp_usn_helicrew: tsp_usn_sailor {displayName = "Helicopter Crew";};

    class rhsusf_socom_swcc_crewman;
    class tsp_usn_seal_operator: rhsusf_socom_swcc_crewman {scopeCurator = 2; displayName = "Seal"; editorSubcategory = "tsp_inf_seal";};
    class tsp_usn_seal_operatorat: tsp_usn_seal_operator {displayName = "Seal (AT)"; icon = "iconManAT";};
    class tsp_usn_seal_autorifleman: tsp_usn_seal_operator {displayName = "Autorifleman"; icon = "iconManMG";};
    class tsp_usn_seal_marksman: tsp_usn_seal_operator {displayName = "Marksman";};
    class tsp_usn_seal_engineer: tsp_usn_seal_operator {displayName = "Engineer"; icon = "iconManEngineer";};
    class tsp_usn_seal_breacher: tsp_usn_seal_operator {displayName = "Breacher"; icon = "iconManExplosive";};
    class tsp_usn_seal_teamlead: tsp_usn_seal_operator {displayName = "Team Leader"; icon = "iconManLeader";}; 
    class tsp_usn_seal_medic: tsp_usn_seal_operator {displayName = "Medic"; icon = "iconManMedic";};

    class UK3CB_B_RHIB; 
    class UK3CB_B_RHIB_USN: UK3CB_B_RHIB {scope = 2; scopeCurator = 2; crew = "tsp_usn_sailor"; typicalCargo[] = {"tsp_usn_sailor"}; faction = "rhs_faction_usn";};
    class UK3CB_B_RHIB_Gunboat; 
    class UK3CB_B_RHIB_Gunboat_USN: UK3CB_B_RHIB_Gunboat {scope = 2; scopeCurator = 2; crew = "tsp_usn_sailor"; typicalCargo[] = {"tsp_usn_sailor"}; faction = "rhs_faction_usn";};
};

class CfgLoadouts {  //-- QT allows for using #definitions within a string  
    #define QT "  

    #define ITEMS ['tsp_ifak',1],['ACRE_PRC154',1],['ACE_CableTie',1],['ACE_EarPlugs',1],['tsp_gear_ess_tan',1],['tsp_gear_manta',1],['ACE_Flashlight_XL50',1]
    #define ITEMS_SL ['ACE_MapTools',1],['ACE_PlottingBoard',1],['acex_intelitems_notepad',1,1]
    #define ITEMS_SNIPER ['ACE_Kestrel4500',1],['ACE_RangeCard',1]

    #define KNIFE ['tsp_meleeWeapon_okc','','','',[],[],'']

    tsp_usn_sailor = QT[[],[],[],['rhs_uniform_acu_nwu',[ITEMS]],[],[],'rhs_8point_nwu','',[],['','','','','','']]QT;

    tsp_usn_deck = QT[[],[],[],['rhs_uniform_acu_nwu',[ITEMS]],['V_Safety_yellow_F',[]],[],'tsp_gear_peltor_green',selectRandom['','rhs_ess_black'],[],['','','','','','']]QT;
    tsp_usn_deck_blue = QT[[],[],[],['a2_crew_blue',[ITEMS]],['a2_vest_lhd1',[]],[],'a2_crew_helmet_blue',selectRandom['','rhs_ess_black'],[],['','','','','','']]QT;
    tsp_usn_deck_brown = QT[[],[],[],['a2_crew_brown',[ITEMS]],['a2_vest_lhd2',[]],[],'a2_crew_helmet_brown',selectRandom['','rhs_ess_black'],[],['','','','','','']]QT;
    tsp_usn_deck_green = QT[[],[],[],['a2_crew_green',[ITEMS]],['a2_vest_lhd3',[]],[],'a2_crew_helmet_green',selectRandom['','rhs_ess_black'],[],['','','','','','']]QT;
    tsp_usn_deck_red = QT[[],[],[],['a2_crew_red',[ITEMS]],['a2_vest_lhd4',[]],[],'a2_crew_helmet_red',selectRandom['','rhs_ess_black'],[],['','','','','','']]QT;
    tsp_usn_deck_violet = QT[[],[],[],['a2_crew_violet',[ITEMS]],['a2_vest_lhd5',[]],[],'a2_crew_helmet_violet',selectRandom['','rhs_ess_black'],[],['','','','','','']]QT;
    tsp_usn_deck_white = QT[[],[],[],['a2_crew_white',[ITEMS]],['a2_vest_lhd6',[]],[],'a2_crew_helmet_white',selectRandom['','rhs_ess_black'],[],['','','','','','']]QT;
    tsp_usn_deck_yellow = QT[[],[],[],['a2_crew_yellow',[ITEMS]],['a2_vest_lhd7',[]],[],'a2_crew_helmet_yellow',selectRandom['','rhs_ess_black'],[],['','','','','','']]QT;

    tsp_usn_jetpilot = QT[[],[],['rhsusf_weap_m9','','','',['rhsusf_mag_15Rnd_9x19_JHP',15],[],''],['cinco_uniform_nomex_green_m',[ITEMS,ITEMS_SL,[KNIFE,1]]],['UK3CB_V_Pilot_Vest',[['ACRE_PRC152',1],['rhsusf_mag_15Rnd_9x19_FMJ',2,15],[['hgun_Pistol_Signal_F','','','',['6Rnd_GreenSignal_F',6],[],''],1],['6Rnd_RedSignal_F',2,6],['rhs_mag_an_m8hc',1,1],['rhs_mag_m18_green',1,1],['rhs_mag_m18_purple',1,1],['rhs_mag_m18_red',1,1],['Chemlight_green',2,1],['ACE_HandFlare_Green',1,1],['ACE_HandFlare_Red',1,1]]],['rhsusf_eject_Parachute_backpack',[]],'sab_ma_pilot_helmet','tsp_gear_floatation_grey',[],['ItemMap','tsp_trijatta','','ItemCompass','ItemWatch','rhsusf_anvis_nvg_bc_caps_hide']]QT;
    tsp_usn_pilot = QT[[],[],['rhsusf_weap_m9','','','',['rhsusf_mag_15Rnd_9x19_JHP',15],[],''],['cinco_uniform_nomex_green_m',[ITEMS,ITEMS_SL,[KNIFE,1]]],['UK3CB_V_Pilot_Vest',[['ACRE_PRC152',1],['rhsusf_mag_15Rnd_9x19_FMJ',2,15],[['hgun_Pistol_Signal_F','','','',['6Rnd_GreenSignal_F',6],[],''],1],['6Rnd_RedSignal_F',2,6],['rhs_mag_an_m8hc',1,1],['rhs_mag_m18_green',1,1],['rhs_mag_m18_purple',1,1],['rhs_mag_m18_red',1,1],['Chemlight_green',2,1],['ACE_HandFlare_Green',1,1],['ACE_HandFlare_Red',1,1]]],[],selectRandom['H_HeadSet_black_F','H_HeadSet_white_F'],'tsp_gear_floatation_grey',[],['ItemMap','tsp_trijatta','','ItemCompass','ItemWatch','rhsusf_anvis_nvg_bc_caps_hide']]QT;

    tsp_usn_helipilot = QT[['a2_mp5','','','',['30Rnd_9x21_Mag_SMG_02',30],[],''],[],['rhsusf_weap_m9','','','',['rhsusf_mag_15Rnd_9x19_JHP',15],[],''],['cinco_uniform_nomex_tan_m',[ITEMS,ITEMS_SL,['tsp_sling_1point',1],[KNIFE,1]]],['UK3CB_V_Pilot_Vest_COY',[['ACRE_PRC152',1],['30Rnd_9x21_Mag_SMG_02',2,30],['rhsusf_mag_15Rnd_9x19_FMJ',2,15],[['hgun_Pistol_Signal_F','','','',['6Rnd_GreenSignal_F',6],[],''],1],['6Rnd_RedSignal_F',2,6],['rhs_mag_an_m8hc',1,1],['rhs_mag_m18_green',1,1],['rhs_mag_m18_purple',1,1],['rhs_mag_m18_red',1,1],['Chemlight_green',2,1],['ACE_HandFlare_Green',1,1],['ACE_HandFlare_Red',1,1]]],[],'rhsusf_hgu56p_visor_white','tsp_gear_floatation_coyote',[],['ItemMap','tsp_trijatta','','ItemCompass','ItemWatch','rhsusf_anvis_nvg_bc_caps_hide']]QT;   
    tsp_usn_helicrew = QT[['rhs_weap_m4','','','',['rhs_mag_30Rnd_556x45_M855A1_Stanag',30],[],''],[],KNIFE,['cinco_uniform_nomex_tan_m',[ITEMS,ITEMS_SL,['tsp_sling_1point',1]]],['UK3CB_V_Pilot_Vest_COY',[['ACRE_PRC152',1],['rhs_mag_30Rnd_556x45_M855A1_Stanag',2,30],[['hgun_Pistol_Signal_F','','','',['6Rnd_GreenSignal_F',6],[],''],1],['6Rnd_RedSignal_F',2,6],['rhs_mag_an_m8hc',1,1],['rhs_mag_m18_green',1,1],['rhs_mag_m18_purple',1,1],['rhs_mag_m18_red',1,1],['Chemlight_green',2,1],['ACE_HandFlare_Green',1,1],['ACE_HandFlare_Red',1,1]]],[],'rhsusf_hgu56p_white','tsp_gear_floatation_coyote',[],['ItemMap','','','ItemCompass','ItemWatch','rhsusf_anvis_nvg_bc_caps_hide']]QT;

    #define SEAL_ITEMS ['ACE_MapTools',1],['ACE_PlottingBoard',1],['acex_intelitems_notepad',1,1],['ACE_CableTie',2],['ACE_EarPlugs',1],['ACRE_PRC154',1],['tsp_ifak',1],['tsp_gear_tec',1],['tsp_gear_ess_tan',1],[selectRandom['tsp_gear_manta','tsp_gear_helstar'],1],[['tsp_meleeWeapon_socp','','','',[],[],''],1]

    #define SEAL_OPTICS_SHORT selectRandom['tsp_acc_t2_unity_tan','tsp_acc_xps3_black','tsp_acc_xps3_tan',selectRandom['Tier1_MicroT1_Leap_Black','Tier1_MicroT1_Leap_Desert','Tier1_MicroT1_Leap_Riser_Black','Tier1_MicroT1_Leap_Riser_Desert','Tier1_MicroT2_Black','Tier1_MicroT2_Tan','Tier1_MicroT2_Leap_Riser_Black','Tier1_MicroT2_Leap_Riser_Tan','Tier1_MicroT2_Riser_Black','Tier1_MicroT2_Riser_Tan']]
    #define SEAL_OPTICS_LONG selectRandom['tsp_acc_xps3_tan_unity_tan_g33_black_flip','tsp_acc_xps3_tan_unity_tan_g33_tan_flip',selectRandom['Tier1_ATACR18_ADM_Black','Tier1_ATACR18_ADM_Desert','Tier1_Razor_Gen2_16']]
    #define SEAL_SUPRESSORS selectRandom['Tier1_SandmanS_Desert','Tier1_SandmanS_Black','Tier1_KAC_556_QDC_Black','Tier1_KAC_556_QDC_Tan','Tier1_KAC_556_QDC_CQB_Black','Tier1_KAC_556_QDC_CQB_Tan','rhsusf_acc_rotex5_grey']
    #define SEAL_LASERS selectRandom['tsp_acc_ngal_front_tan','Tier1_M4BII_NGAL_M300C_Black_FL','Tier1_M4BII_NGAL_M300C_FL']

    #define SEAL_HATS selectRandom['H_Cap_usblack','H_Cap_tan_specops_US','rhs_booniehat2_marpatd']
    #define SEAL_EYE selectRandom['','G_Bandanna_tan','G_Bandanna_khk','rhs_googles_yellow','rhs_googles_clear','rhs_googles_orange']
    #define SEAL_NVG selectRandom['3DMA_WD_ANPVS31_v1','3DMA_WD_ANPVS31_v2','JAS_GPNVG18_Tan']

    tsp_usn_seal_operator = QT[['rhs_weap_mk18_nsr_tan','rhsusf_acc_SF3P556',SEAL_LASERS,selectRandom[SEAL_OPTICS_SHORT,SEAL_OPTICS_LONG],['rhs_mag_30Rnd_556x45_M855A1_PMAG_Tan',30],[],selectRandom['rhs_acc_nsr9_tan','rhs_acc_nsr9_bcm_tan']],[],['rhsusf_weap_glock17g4','','Tier1_X300U','',['rhsusf_mag_17Rnd_9x19_FMJ',17],[],''],['rhs_uniform_g3_aor1',[SEAL_ITEMS,['tsp_sling_1point',1]]],['lbt_operator_aor1',[[SEAL_HATS,1],[SEAL_NVG,1],[SEAL_SUPRESSORS,1],['rhs_mag_30Rnd_556x45_M855A1_PMAG_Tan',4,30],['rhs_mag_30Rnd_556x45_M855A1_Stanag_Tracer_Red',4,30],['rhsusf_mag_17Rnd_9x19_FMJ',2,17],['rhs_mag_an_m8hc',2,1],['rhs_mag_m67',2,1],['tsp_flashbang_cts',2,1],['Chemlight_green',2,1]]],[],'tsp_gear_fast_mt_aor1',SEAL_EYE,[],['ItemMap','','','ItemCompass','ItemWatch','']]QT;
    tsp_usn_seal_operatorat = QT[['rhs_weap_mk18_nsr_tan','rhsusf_acc_SF3P556',SEAL_LASERS,SEAL_OPTICS_SHORT,['rhs_mag_30Rnd_556x45_M855A1_PMAG_Tan',30],[],'rhs_acc_nsr9_tan'],['rhs_weap_M136','','','',[],[],''],['rhsusf_weap_glock17g4','','Tier1_X300U','',['rhsusf_mag_17Rnd_9x19_FMJ',17],[],''],['rhs_uniform_g3_aor1',[SEAL_ITEMS,['tsp_sling_1point',1]]],['lbt_operator_aor1',[[SEAL_HATS,1],[SEAL_NVG,1],[SEAL_SUPRESSORS,1],['rhs_mag_30Rnd_556x45_M855A1_PMAG_Tan',4,30],['rhs_mag_30Rnd_556x45_M855A1_Stanag_Tracer_Red',4,30],['rhsusf_mag_17Rnd_9x19_FMJ',2,17],['rhs_mag_an_m8hc',2,1],['rhs_mag_m67',2,1],['tsp_flashbang_cts',2,1],['Chemlight_green',2,1]]],[],'tsp_gear_fast_mt_aor1_peltor',SEAL_EYE,[],['ItemMap','','','ItemCompass','ItemWatch','']]QT;
    tsp_usn_seal_autorifleman = QT[['Tier1_MK46_Mod1_Savit_Desert','rhsgref_sdn6_suppressor','Tier1_Mk46Mod1_LA5','tsp_acc_xps3_tan',['rhsusf_100Rnd_556x45_mixed_soft_pouch',100],[],'rhsusf_acc_kac_grip_saw_bipod'],[],['rhsusf_weap_glock17g4','','Tier1_X300U','',['rhsusf_mag_17Rnd_9x19_FMJ',17],[],''],['rhs_uniform_g3_aor1',[SEAL_ITEMS,['tsp_sling',1]]],['rhsusf_mbav_mg',[[SEAL_HATS,1],[SEAL_NVG,1],[SEAL_SUPRESSORS,1],['rhsusf_100Rnd_556x45_mixed_soft_pouch',2,100],['rhsusf_100Rnd_556x45_soft_pouch',2,100],['rhsusf_mag_17Rnd_9x19_FMJ',2,17],['rhs_mag_an_m8hc',1,1],['rhs_mag_m67',1,1],['tsp_flashbang_cts',1,1],['Chemlight_green',2,1]]],['NutRuck',[['rhsusf_100Rnd_556x45_soft_pouch',2,100],['rhsusf_100Rnd_556x45_mixed_soft_pouch',2,100]]],'tsp_gear_fast_mt_aor1_peltor',SEAL_EYE,[],['ItemMap','','','ItemCompass','ItemWatch','']]QT;
    tsp_usn_seal_marksman = QT[['Tier1_M110k5_ACS','rhsgref_sdn6_suppressor','Tier1_URX4_LA5_Top','Tier1_LeupoldM3A_ADM_T2_Tan',['Tier1_20Rnd_762x51_M993_SR25_Mag',20],[],'Tier1_Harris_Bipod_MLOK_Tan'],[],['rhsusf_weap_glock17g4','','Tier1_X300U','',['rhsusf_mag_17Rnd_9x19_FMJ',17],[],''],['rhs_uniform_g3_aor1',[SEAL_ITEMS,ITEMS_SNIPER,['tsp_sling',1]]],['lbt_comms_aor1',[[SEAL_HATS,1],[SEAL_NVG,1],['Tier1_20Rnd_762x51_M993_SR25_Mag',4,20],['Tier1_20Rnd_762x51_M62_SR25_Mag',3,20],['rhsusf_mag_17Rnd_9x19_FMJ',2,17],['rhs_mag_an_m8hc',1,1],['rhs_mag_m67',1,1],['tsp_flashbang_cts',1,1],['Chemlight_green',2,1]]],[],'tsp_gear_fast_mt_greenCover',SEAL_EYE,['rhsusf_bino_m24_ARD','','','',[],[],''],['ItemMap','','','ItemCompass','ItemWatch','']]QT;
    tsp_usn_seal_breacher = QT[['rhs_weap_mk18_nsr_tan','rhsusf_acc_SF3P556',SEAL_LASERS,SEAL_OPTICS_SHORT,['rhs_mag_30Rnd_556x45_M855A1_PMAG_Tan',30],[],selectRandom['rhs_acc_nsr9_tan','rhs_acc_nsr9_bcm_tan']],['tsp_meleeWeapon_halligan','','','',[],[],''],['rhsusf_weap_glock17g4','','Tier1_X300U','',['rhsusf_mag_17Rnd_9x19_FMJ',17],[],''],['rhs_uniform_g3_aor1',[SEAL_ITEMS,['tsp_sling_1point',1]]],['lbt_comms_aor1',[[SEAL_HATS,1],[SEAL_NVG,1],[SEAL_SUPRESSORS,1],['rhs_mag_30Rnd_556x45_M855A1_PMAG_Tan',4,30],['rhs_mag_30Rnd_556x45_M855A1_Stanag_Tracer_Red',4,30],['rhsusf_mag_17Rnd_9x19_FMJ',2,17],['rhs_mag_an_m8hc',1,1],['rhs_mag_m67',2,1],['tsp_flashbang_cts',2,1],['Chemlight_green',2,1]]],['3DAP',[['rhsusf_5Rnd_Slug',4,5],[['rhs_weap_M590_5RD','','','',[],[],''],1],['tsp_breach_shock',1],['ACE_Clacker',1],['ACE_DefusalKit',1],['tsp_lockpick',1],['ToolKit',1],['ACE_wirecutter',1],['tsp_breach_block_mag',4,1],['tsp_breach_linear_mag',4,1],['rhsusf_m112_mag',1,1],['rhsusf_m112x4_mag',1,1]]],'tsp_gear_fast_mt_aor1_peltor',SEAL_EYE,[],['ItemMap','','','ItemCompass','ItemWatch','']]QT;
    tsp_usn_seal_engineer = QT[['rhs_weap_mk18_nsr_tan','rhsusf_acc_SF3P556',SEAL_LASERS,SEAL_OPTICS_SHORT,['rhs_mag_30Rnd_556x45_M855A1_PMAG_Tan',30],[],'rhs_acc_nsr9_tan'],['tsp_meleeWeapon_sledge_black','','','',[],[],''],['ACE_VMH3','','','',[],[],''],['rhs_uniform_g3_aor1',[SEAL_ITEMS,['tsp_sling_1point',1]]],['lbt_tl_aor1',[[SEAL_HATS,1],[SEAL_NVG,1],[SEAL_SUPRESSORS,1],['rhs_mag_30Rnd_556x45_M855A1_PMAG_Tan',4,30],['rhs_mag_30Rnd_556x45_M855A1_Stanag_Tracer_Red',4,30],['rhs_mag_an_m8hc',1,1],['rhs_mag_m67',1,1],['tsp_flashbang_cts',2,1],['Chemlight_green',2,1]]],['3DAP',[['ToolKit',1],['MineDetector',1],['ACE_DefusalKit',1],['ACE_wirecutter',1],['ACE_Fortify',1],['ACE_M26_Clacker',1],['rhsusf_m112_mag',2,1],['rhsusf_m112x4_mag',1,1],['rhs_mag_an_m14_th3',1,1],['ClaymoreDirectionalMine_Remote_Mag',2,1]]],'tsp_gear_fast_mt_aor1_peltor',SEAL_EYE,[],['ItemMap','','','ItemCompass','ItemWatch','']]QT;
    tsp_usn_seal_teamlead = QT[['rhs_weap_m4a1_nsr_tan','rhsusf_acc_SF3P556',SEAL_LASERS,SEAL_OPTICS_LONG,['rhs_mag_30Rnd_556x45_M855A1_PMAG_Tan',30],[],'rhs_acc_nsr_tan'],[],['RH_p226','','RH_X300','',['RH_15Rnd_9x19_SIG',17],[],''],['rhs_uniform_g3_aor1',[SEAL_ITEMS,['tsp_sling_1point',1]]],['lbt_comms_aor1',[[SEAL_HATS,1],[SEAL_NVG,1],[SEAL_SUPRESSORS,1],['ACRE_PRC152',1],['rhs_mag_30Rnd_556x45_M855A1_PMAG_Tan',3,30],['rhs_mag_30Rnd_556x45_M855A1_Stanag_Tracer_Red',3,30],['RH_15Rnd_9x19_SIG',2,17],['rhs_mag_m18_yellow',1,1],['rhs_mag_m18_purple',1,1],['rhs_mag_an_m8hc',1,1],['rhs_mag_m67',2,1],['tsp_flashbang_cts',2,1],['Chemlight_green',2,1]]],[],'tsp_gear_fast_mt_aor1_peltor',SEAL_EYE,['rhsusf_bino_m24_ARD','','','',[],[],''],['ItemMap','tsp_trijatta','','ItemCompass','ItemWatch','']]QT;
    tsp_usn_seal_medic = QT[['rhs_weap_mk18_nsr_tan','rhsusf_acc_SF3P556',SEAL_LASERS,SEAL_OPTICS_SHORT,['rhs_mag_30Rnd_556x45_M855A1_PMAG_Tan',30],[],'rhs_acc_nsr9_tan'],[],['RH_p226','','RH_X300','',['RH_15Rnd_9x19_SIG',17],[],''],['rhs_uniform_g3_aor1',[SEAL_ITEMS,['tsp_sling_1point',1]]],['lbt_medical_aor1',[[SEAL_HATS,1],[SEAL_NVG,1],[SEAL_SUPRESSORS,1],['rhs_mag_30Rnd_556x45_M855A1_PMAG_Tan',4,30],['rhs_mag_30Rnd_556x45_M855A1_Stanag_Tracer_Red',4,30],['RH_15Rnd_9x19_SIG',2,17],['rhs_mag_an_m8hc',2,1],['rhs_mag_m67',1,1],['tsp_flashbang_cts',1,1],['Chemlight_green',2,1]]],['RATS',[['Medikit',1],['ACE_salineIV',4],['tsp_ifak',2],['ACE_bodyBag',4]]],'tsp_gear_fast_mt_aor1',SEAL_EYE,[],['ItemMap','','','ItemCompass','ItemWatch','']]QT;

    rhsusf_socom_swcc_crewman = QT[['rhs_weap_mk18','rhsusf_acc_SF3P556','Tier1_M4BII_LA5_M300C_Black','tsp_acc_xps3_black',['rhs_mag_30Rnd_556x45_M855A1_PMAG',30],[],''],[],['RH_p226s','','','',['RH_15Rnd_9x19_SIG',15],[],''],['rhs_uniform_g3_aor2',[SEAL_ITEMS,['tsp_sling_1point',1]]],['lbt_operator_aor2',[[SEAL_HATS,1],['3DMA_WD_ANPVS31_v2',1],['Tier1_SandmanS_Desert',1],['rhs_mag_30Rnd_556x45_M855A1_PMAG',3,30],['rhs_mag_30Rnd_556x45_M855A1_PMAG_Tracer_Red',3,30],['RH_15Rnd_9x19_SIG',2,17],['rhs_mag_an_m8hc',1,1],['rhs_mag_m67',1,1],['tsp_flashbang_m84',2,1],['Chemlight_green',2,1]]],[],'tsp_gear_fast_mt_aor2_peltor_manta_tec','tsp_gear_floatation_coyote',[],['ItemMap','','','ItemCompass','ItemWatch','']]QT;
    rhsusf_socom_swcc_officer = QT[['rhs_weap_mk18','rhsusf_acc_SF3P556','Tier1_M4BII_LA5_M300C_Black','tsp_acc_xps3_black',['rhs_mag_30Rnd_556x45_M855A1_PMAG',30],[],''],[],['RH_p226s','','','',['RH_15Rnd_9x19_SIG',15],[],''],['rhs_uniform_g3_aor2',[SEAL_ITEMS,['tsp_sling_1point',1]]],['lbt_operator_aor2',[[SEAL_HATS,1],['3DMA_WD_ANPVS31_v2',1],['Tier1_SandmanS_Desert',1],['ACRE_PRC152',1],['rhs_mag_30Rnd_556x45_M855A1_PMAG',3,30],['rhs_mag_30Rnd_556x45_M855A1_PMAG_Tracer_Red',3,30],['RH_15Rnd_9x19_SIG',2,17],['rhs_mag_m18_purple',1,1],['rhs_mag_m18_yellow',1,1],['rhs_mag_an_m8hc',1,1],['rhs_mag_m67',1,1],['tsp_flashbang_m84',2,1],['Chemlight_green',2,1]]],[],'tsp_gear_fast_mt_aor2_manta_tec','tsp_gear_floatation_coyote',['rhsusf_bino_m24_ARD','','','',[],[],''],['ItemMap','tsp_trijatta','','ItemCompass','ItemWatch','']]QT;
};