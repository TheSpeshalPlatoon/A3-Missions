class CfgPatches {
	class tsp_faction_hidf {
		requiredAddons[] = {};
        units[] = {
            "tsp_hidf_sf_scout",
            "tsp_hidf_sf_scout_m72",
            "tsp_hidf_sf_scout_mosin",
            "tsp_hidf_sf_scout_suppressor",
            "tsp_hidf_sf_grenadier",
            "tsp_hidf_sf_autorifleman",
            "tsp_hidf_sf_marksman",
            "tsp_hidf_sf_sniper",
            "tsp_hidf_sf_teamlead",
            "tsp_hidf_sf_medic",
            "tsp_hidf_sf_engineer"
        };
	};
};

class CfgEditorSubCategories {class tsp_inf_sf {displayName = "Infantry (Special Forces)";};};

class CfgVehicles {
    class rhsgref_hidf_rifleman;
    class tsp_hidf_sf_scout: rhsgref_hidf_rifleman {displayName = "Scout"; identityTypes[] = {"LanguageENGFRE_F","Head_TK_camo_lush"}; editorSubcategory = "tsp_inf_sf";};
    class tsp_hidf_sf_scout_m72: tsp_hidf_sf_scout {displayName = "Scout (M72)"; icon = "iconManAT";};
    class tsp_hidf_sf_scout_mosin: tsp_hidf_sf_scout {displayName = "Scout (Mosin)";};
    class tsp_hidf_sf_scout_suppressor: tsp_hidf_sf_scout {displayName = "Scout (Suppressed)";};
    class tsp_hidf_sf_grenadier: tsp_hidf_sf_scout {displayName = "Grenadier";};
    class tsp_hidf_sf_autorifleman: tsp_hidf_sf_scout {displayName = "Autorifleman"; icon = "iconManMG";};
    class tsp_hidf_sf_marksman: tsp_hidf_sf_scout {displayName = "Marksman";};
    class tsp_hidf_sf_sniper: tsp_hidf_sf_scout {displayName = "Sniper";};
    class tsp_hidf_sf_teamlead: tsp_hidf_sf_scout {displayName = "Team Leader"; icon = "iconManLeader";};
    class tsp_hidf_sf_medic: tsp_hidf_sf_scout {displayName = "Medic"; icon = "iconManMedic";};    
    class tsp_hidf_sf_engineer: tsp_hidf_sf_scout {displayName = "Engineer"; icon = "iconManEngineer";};
};

class CfgLoadouts {  //-- QT allows for using #definitions within a string
    #define QT "

    #define ITEMS ['ACE_EarPlugs',1],['ACE_Flashlight_MX991',1],['ACRE_BF888S',1],['tsp_ifak',1],['tsp_sling',1]
    #define ITEMS_SL ['ACE_MapTools',1],['ACE_PlottingBoard',1],['acex_intelitems_notepad',1,1]
    #define ITEMS_SNIPER ['ACE_Kestrel4500',1],['ACE_RangeCard',1]

    #define KNIFE ['tsp_meleeWeapon_kabar','','','',[],[],'']
    
    #define HEAD selectRandom['rhsgref_helmet_M1_erdl','rhsgref_helmet_M1_erdl','rhsgref_helmet_M1_erdl','rhsgref_helmet_M1_erdl','rhsgref_helmet_M1_erdl','rhsgref_helmet_M1_bare','rhsgref_helmet_M1_bare_alt01','rhsgref_helmet_M1_painted','rhsgref_helmet_M1_painted_alt01']
    #define HATS selectRandom['rhsgref_hat_M1951']    

    rhsgref_hidf_rifleman = QT[['rhs_weap_m16a2','','rhs_acc_m16_handguard','',['rhs_mag_30Rnd_556x45_M855A1_Stanag',30],[],'rhs_acc_m16_norail'],[],KNIFE,['rhs_uniform_bdu_erdl',[ITEMS]],['rhsgref_alice_webbing',[[HATS,1],['rhs_mag_30Rnd_556x45_M855A1_Stanag',4,30],['rhs_mag_30Rnd_556x45_M855A1_Stanag_Tracer_Red',4,30],['rhs_grenade_anm8_mag',1,1],['rhs_grenade_mkii_mag',2,1]]],[],HEAD,'',[],['ItemMap','','','ItemCompass','ItemWatch','']]QT;
    rhsgref_hidf_rifleman_m72 = QT[[selectRandom['rhs_weap_l1a1','rhs_weap_l1a1_wood'],'rhsgref_acc_falMuzzle_l1a1','','',['rhs_mag_20Rnd_762x51_m80_fnfal',20],[],''],['rhs_weap_m72a7','','','',['rhs_m72a7_mag',1],[],''],KNIFE,['rhs_uniform_bdu_erdl',[ITEMS]],['rhsgref_alice_webbing',[[HATS,1],['rhs_mag_20Rnd_762x51_m80_fnfal',3,20],['rhs_mag_20Rnd_762x51_m62_fnfal',3,20],['rhs_grenade_anm8_mag',1,1],['rhs_grenade_mkii_mag',2,1]]],[],HEAD,'',[],['ItemMap','','','ItemCompass','ItemWatch','']]QT;
    rhsgref_hidf_grenadier = QT[['rhs_weap_m16a2_m203','','rhs_acc_m16_handguard_m203_norail','',['rhs_mag_30Rnd_556x45_M855A1_Stanag',30],['rhs_mag_M441_HE',1],''],[],KNIFE,['rhs_uniform_bdu_erdl',[ITEMS]],['rhsgref_alice_webbing',[[HATS,1],['rhs_mag_30Rnd_556x45_M855A1_Stanag',3,30],['rhs_mag_30Rnd_556x45_M855A1_Stanag_Tracer_Red',3,30],['rhs_mag_M441_HE',6,1],['rhs_mag_m714_White',2,1],['rhs_mag_m713_Red',1,1],['rhs_mag_m715_Green',1,1],['rhs_mag_m662_red',5,1],['rhs_grenade_mkii_mag',2,1]]],[],HEAD,'',[],['ItemMap','','','ItemCompass','ItemWatch','']]QT;
    rhsgref_hidf_grenadier_m79 = QT[['rhs_weap_m79','','','',['rhs_mag_M441_HE',1],[],''],[],['rhsusf_weap_m1911a1','','','',['rhsusf_mag_7x45acp_MHP',7],[],''],['rhs_uniform_bdu_erdl',[ITEMS,[KNIFE,1]]],['rhsgref_alice_webbing',[[HATS,1],['rhs_mag_M441_HE',8,1],['rhs_mag_m662_red',4,1],['rhs_mag_m715_Green',2,1],['rhs_mag_m714_White',2,1],['rhsusf_mag_7x45acp_MHP',2,7],['rhs_grenade_anm8_mag',1,1],['rhs_grenade_mkii_mag',1,1]]],[],HEAD,'',[],['ItemMap','','','ItemCompass','ItemWatch','']]QT;

    rhsgref_hidf_autorifleman = QT[['rhs_weap_m249','','','',['rhsusf_200Rnd_556x45_box',200],[],'rhsusf_acc_saw_bipod'],[],KNIFE,['rhs_uniform_bdu_erdl',[ITEMS]],['rhsgref_alice_webbing',[[HATS,1],['rhsusf_200Rnd_556x45_box',1,200],['rhsusf_200rnd_556x45_mixed_box',1,200],['rhs_grenade_anm8_mag',1,1],['rhs_grenade_mkii_mag',1,1]]],[],HEAD,'',[],['ItemMap','','','ItemCompass','ItemWatch','']]QT;
    rhsgref_hidf_autorifleman_assist = QT[['rhs_weap_m16a2','','rhs_acc_m16_handguard','',['rhs_mag_30Rnd_556x45_M855A1_Stanag',30],[],'rhs_acc_m16_norail'],[],KNIFE,['rhs_uniform_bdu_erdl',[ITEMS]],['rhsgref_alice_webbing',[[HATS,1],['rhs_mag_30Rnd_556x45_M855A1_Stanag',4,30],['rhs_mag_30Rnd_556x45_M855A1_Stanag_Tracer_Red',4,30],['rhs_grenade_anm8_mag',1,1],['rhs_grenade_mkii_mag',1,1]]],['rhssaf_alice_md2camo',[['rhsusf_200Rnd_556x45_box',2,200],['rhsusf_200rnd_556x45_mixed_box',2,200]]],HEAD,'',[],['ItemMap','','','ItemCompass','ItemWatch','']]QT;
    rhsgref_hidf_machinegunner = QT[['rhs_weap_fnmag','','','',['rhsusf_100Rnd_762x51',100],[],''],[],KNIFE,['rhs_uniform_bdu_erdl',[ITEMS]],['rhsgref_alice_webbing',[[HATS,1],['rhsusf_100Rnd_762x51',1,100],['rhsusf_100Rnd_762x51_m62_tracer',2,100],['rhs_grenade_anm8_mag',1,1],['rhs_grenade_mkii_mag',1,1]]],[],HEAD,'',[],['ItemMap','','','ItemCompass','ItemWatch','']]QT;
    rhsgref_hidf_machinegunner_assist = QT[[selectRandom['rhs_weap_l1a1','rhs_weap_l1a1_wood'],'rhsgref_acc_falMuzzle_l1a1','','',['rhs_mag_20Rnd_762x51_m80_fnfal',20],[],''],[],KNIFE,['rhs_uniform_bdu_erdl',[ITEMS]],['rhsgref_alice_webbing',[[HATS,1],['rhs_mag_20Rnd_762x51_m80_fnfal',3,20],['rhs_mag_20Rnd_762x51_m62_fnfal',2,20],['rhs_grenade_anm8_mag',1,1],['rhs_grenade_mkii_mag',1,1]]],['rhssaf_alice_md2camo',[['rhsusf_100Rnd_762x51_m62_tracer',2,100],['rhsusf_100Rnd_762x51',2,100]]],HEAD,'',['Binocular','','','',[],[],''],['ItemMap','','','ItemCompass','ItemWatch','']]QT;

    rhsgref_hidf_marksman = QT[['rhs_weap_m14_rail','','','rhsusf_acc_LEUPOLDMK4',['rhsusf_20Rnd_762x51_m80_Mag',20],[],''],[],KNIFE,['rhs_uniform_bdu_erdl',[ITEMS]],['rhsgref_alice_webbing',[[HATS,1],['rhsusf_20Rnd_762x51_m80_Mag',3,20],['rhsusf_20Rnd_762x51_m62_Mag',2,20],['rhs_grenade_anm8_mag',1,1],['rhs_grenade_mkii_mag',1,1]]],[],HEAD,'',['rhsusf_bino_leopold_mk4','','','',[],[],''],['ItemMap','','','ItemCompass','ItemWatch','']]QT;
    rhsgref_hidf_sniper = QT[['rhs_weap_m24sws','','','rhsusf_acc_LEUPOLDMK4',['rhsusf_5Rnd_762x51_m118_special_Mag',5],[],'rhsusf_acc_harris_swivel'],[],['rhsusf_weap_m1911a1','','','',['rhsusf_mag_7x45acp_MHP',7],[],''],['rhs_uniform_bdu_erdl',[ITEMS,ITEMS_SL,ITEMS_SNIPER,[KNIFE,1]]],['rhsgref_alice_webbing',[['ACRE_PRC148',1],['rhsusf_5Rnd_762x51_m993_Mag',10,5],['rhsusf_5Rnd_762x51_m62_Mag',10,5],['rhsusf_mag_7x45acp_MHP',6,7],['rhs_grenade_anm8_mag',1,1],['rhs_grenade_mkii_mag',1,1]]],[],HATS,'',['ACE_Yardage450','','','',[],[],''],['ItemMap','','','ItemCompass','ItemWatch','']]QT;

    rhsgref_hidf_squadleader = QT[['rhs_weap_m4_handguard_car','','rhs_acc_m4_car_pointer','',['rhs_mag_30Rnd_556x45_M855A1_Stanag',30],[],'rhs_acc_m4_handguard'],[],KNIFE,['rhs_uniform_bdu_erdl',[ITEMS,ITEMS_SL]],['rhsgref_alice_webbing',[[HATS,1],['ACRE_PRC148',1],['rhs_mag_30Rnd_556x45_M855A1_Stanag',4,30],['rhs_mag_30Rnd_556x45_M855A1_Stanag_Tracer_Red',4,30],['rhs_mag_m18_green',1,1],['rhs_grenade_anm8_mag',1,1],['rhs_grenade_mkii_mag',1,1]]],[],'rhsgref_helmet_M1_erdl','',['Binocular','','','',[],[],''],['ItemMap','','','ItemCompass','ItemWatch','']]QT;
    rhsgref_hidf_teamleader = QT[[selectRandom['rhs_weap_l1a1','rhs_weap_l1a1_wood'],'rhsgref_acc_falMuzzle_l1a1','','',['rhs_mag_20Rnd_762x51_m80_fnfal',20],[],''],[],KNIFE,['rhs_uniform_bdu_erdl',[ITEMS,ITEMS_SL]],['rhsgref_alice_webbing',[[HATS,1],['rhs_mag_20Rnd_762x51_m80_fnfal',3,20],['rhs_mag_20Rnd_762x51_m62_fnfal',2,20],['rhs_mag_m18_green',1,1],['rhs_grenade_anm8_mag',1,1],['rhs_grenade_mkii_mag',1,1]]],[],HEAD,'',[],['ItemMap','','','ItemCompass','ItemWatch','']]QT;
    rhsgref_hidf_medic = QT[['rhs_weap_m16a2','','rhs_acc_m16_handguard','',['rhs_mag_30Rnd_556x45_M855A1_Stanag',30],[],'rhs_acc_m16_norail'],[],KNIFE,['rhs_uniform_bdu_erdl',[ITEMS]],['rhsgref_alice_webbing',[[HATS,1],['rhs_mag_30Rnd_556x45_M855A1_Stanag',4,30],['rhs_mag_30Rnd_556x45_M855A1_Stanag_Tracer_Red',4,30],['rhs_grenade_anm8_mag',1,1],['rhs_grenade_mkii_mag',1,1]]],['rhssaf_alice_md2camo',[['Medikit',1],['ACE_salineIV',4],['tsp_ifak',2],['ACE_bodyBag',4]]],'rhsgref_helmet_M1_erdl','',[],['ItemMap','','','ItemCompass','ItemWatch','']]QT;
    
    rhsgref_hidf_boat_driver = QT[['rhs_weap_m4_handguard_car','','rhs_acc_m4_car_pointer','',['rhs_mag_30Rnd_556x45_M855A1_Stanag',30],[],'rhs_acc_m4_handguard'],[],KNIFE,['rhs_uniform_bdu_erdl',[ITEMS]],['rhsgref_alice_webbing',[[HATS,1],['ACRE_PRC148',1],['rhs_mag_30Rnd_556x45_M855A1_Stanag',4,30],['rhs_mag_30Rnd_556x45_M855A1_Stanag_Tracer_Red',4,30],['rhs_grenade_anm8_mag',1,1],['rhs_grenade_mkii_mag',1,1]]],[],selectRandom[HATS,'rhsgref_helmet_M1_liner'],'',[],['ItemMap','','','ItemCompass','ItemWatch','']]QT;
    rhsgref_hidf_crewman = QT[['rhs_weap_m3a1','','','',['rhsgref_30rnd_1143x23_M1911B_SMG',30],[],''],[],KNIFE,['rhs_uniform_bdu_erdl',[ITEMS]],['rhsgref_TacVest_ERDL',[[HATS,1],['ACRE_PRC148',1],['rhsgref_30rnd_1143x23_M1911B_SMG',2,30],['rhsgref_30rnd_1143x23_M1T_SMG',1,30],['rhs_grenade_anm8_mag',1,1],['rhs_grenade_mkii_mag',1,1]]],[],'rhsusf_cvc_green_alt_helmet','',[],['ItemMap','','','ItemCompass','ItemWatch','']]QT;
    rhsgref_hidf_helipilot = QT[['a2_mp5','','','',['30Rnd_9x21_Mag_SMG_02',30],[],''],[],['rhsusf_weap_m1911a1','','','',['rhsusf_mag_7x45acp_MHP',7],[],''],['rhs_uniform_bdu_erdl',[ITEMS,ITEMS_SL,[KNIFE,1]]],['UK3CB_V_Pilot_Vest',[['ACRE_PRC148',1],['30Rnd_9x21_Mag_SMG_02',4,30],['rhsusf_mag_7x45acp_MHP',2,7],[['hgun_Pistol_Signal_F','','','',['6Rnd_GreenSignal_F',6],[],''],1],['6Rnd_GreenSignal_F',2,6],['rhs_grenade_anm8_mag',1,1],['rhs_mag_m18_green',1,1],['rhs_mag_m18_purple',1,1],['rhs_mag_m18_red',1,1],	['Chemlight_green',2,1],['ACE_HandFlare_Green',1,1],['ACE_HandFlare_Red',1,1]]],[],'UK3CB_H_Pilot_Helmet','tsp_gear_floatation_grey',[],['ItemMap','','','ItemCompass','ItemWatch','']]QT;

    #define SF_ITEMS ITEMS,ITEMS_SL,['ACE_CableTie',2]
    #define SF_HEAD selectRandom  ['rhssaf_booniehat_md2camo','rhssaf_booniehat_md2camo','rhssaf_booniehat_woodland',selectRandom['rhs_headband','rhssaf_bandana_md2camo','rhssaf_bandana_oakleaf','rhssaf_bandana_smb','H_Bandanna_khk','H_Bandanna_sgg','H_Bandanna_camo']]
    #define SF_EYE selectRandom['','','rhs_scarf']
    #define SF_VESTS selectRandom['assaultVest_olive','assaultVest_dpm']

    tsp_hidf_sf_scout = QT[[selectRandom['rhs_weap_l1a1','rhs_weap_l1a1_wood_para'],'rhsgref_acc_falMuzzle_l1a1','','',['rhs_mag_20Rnd_762x51_m80_fnfal',20],[],''],[],KNIFE,['rhsgref_uniform_og107_erdl',[SF_ITEMS]],[SF_VESTS,[['rhs_mag_20Rnd_762x51_m80_fnfal',3,20],['rhs_mag_20Rnd_762x51_m62_fnfal',3,20],['rhs_grenade_anm8_mag',1,1],['rhs_grenade_mkii_mag',2,1],['Chemlight_green',2,1]]],[],'rhssaf_booniehat_md2camo',SF_EYE,[],['ItemMap','','','ItemCompass','ItemWatch','']]QT;
    tsp_hidf_sf_scout_m72 = QT[['rhs_weap_l1a1_wood_para','rhsgref_acc_falMuzzle_l1a1','','',['rhs_mag_20Rnd_762x51_m80_fnfal',20],[],''],['rhs_weap_m72a7','','','',['rhs_m72a7_mag',1],[],''],KNIFE,['rhsgref_uniform_og107_erdl',[SF_ITEMS]],[SF_VESTS,[['rhs_mag_20Rnd_762x51_m80_fnfal',3,20],['rhs_mag_20Rnd_762x51_m62_fnfal',3,20],['rhs_grenade_anm8_mag',1,1],['rhs_grenade_mkii_mag',2,1],['Chemlight_green',2,1]]],[],'rhssaf_booniehat_md2camo',SF_EYE,[],['ItemMap','','','ItemCompass','ItemWatch','']]QT;
    tsp_hidf_sf_scout_mosin = QT[['rhs_weap_mosin_sbr','rhsgref_sdn6_suppressor','','',['rhsgref_5Rnd_762x54_m38',5],[],''],[],['rhsusf_weap_m1911a1','','','',['rhsusf_mag_7x45acp_MHP',7],[],''],['rhsgref_uniform_og107_erdl',[SF_ITEMS,[KNIFE,1]]],['rhsgref_alice_webbing',[['rhsgref_5Rnd_762x54_m38',15,5],['rhsusf_mag_7x45acp_MHP',6,7],['rhs_grenade_anm8_mag',1,1],['rhs_grenade_mkii_mag',2,1],['Chemlight_green',2,1]]],[],'rhssaf_booniehat_md2camo',SF_EYE,[],['ItemMap','','','ItemCompass','ItemWatch','']]QT;
    tsp_hidf_sf_scout_suppressor = QT[['rhs_weap_l1a1_wood_para','rhsgref_sdn6_suppressor','','',['rhs_mag_20Rnd_762x51_m80_fnfal',20],[],''],[],KNIFE,['rhsgref_uniform_og107_erdl',[SF_ITEMS]],[SF_VESTS,[['rhs_mag_20Rnd_762x51_m80_fnfal',3,20],['rhs_mag_20Rnd_762x51_m62_fnfal',3,20],['rhs_grenade_anm8_mag',1,1],['rhs_grenade_mkii_mag',2,1],['Chemlight_green',2,1]]],[],'rhssaf_booniehat_md2camo',SF_EYE,[],['ItemMap','','','ItemCompass','ItemWatch','']]QT;
    tsp_hidf_sf_grenadier = QT[['rhs_weap_m16a2_m203','','rhs_acc_m16_handguard_m203_norail','',['rhs_mag_30Rnd_556x45_M855A1_Stanag',30],['rhs_mag_M441_HE',1],''],[],KNIFE,['rhsgref_uniform_ERDL',[SF_ITEMS]],[SF_VESTS,[['rhs_mag_30Rnd_556x45_M855A1_Stanag',3,30],['rhs_mag_30Rnd_556x45_M855A1_Stanag_Tracer_Red',3,30],['rhs_mag_M441_HE',8,1],['rhs_mag_m662_red',3,1],['rhs_mag_m714_White',3,1],['rhs_grenade_anm8_mag',1,1],['rhs_grenade_mkii_mag',2,1],['Chemlight_green',2,1]]],[],'rhssaf_booniehat_md2camo','',[],['ItemMap','','','ItemCompass','ItemWatch','']]QT;

    tsp_hidf_sf_autorifleman = QT[['rhs_weap_m249','','','',['rhsusf_200Rnd_556x45_box',200],[],'rhsusf_acc_saw_bipod'],[],KNIFE,['rhsgref_uniform_og107_erdl',[SF_ITEMS]],[SF_VESTS,[['rhsusf_200Rnd_556x45_box',1,200],['rhsusf_200rnd_556x45_mixed_box',1,200],['rhs_grenade_anm8_mag',1,1],['rhs_grenade_mkii_mag',1,1],['Chemlight_green',2,1]]],[],SF_HEAD,'',[],['ItemMap','','','ItemCompass','ItemWatch','']]QT;
    tsp_hidf_sf_marksman = QT[['rhs_weap_m14_rail_wd','rhsgref_sdn6_suppressor','','rhs_acc_dh520x56',['rhsusf_20Rnd_762x51_m80_Mag',20],[],'rhsusf_acc_harris_swivel'],[],KNIFE,['rhsgref_uniform_og107_erdl',[SF_ITEMS]],[SF_VESTS,[['rhsusf_20Rnd_762x51_m80_Mag',4,20],['rhsusf_20Rnd_762x51_m62_Mag',3,20],['rhs_grenade_anm8_mag',1,1],['rhs_grenade_mkii_mag',1,1],['Chemlight_green',2,1]]],[],'rhssaf_booniehat_md2camo',SF_EYE,['rhsusf_bino_leopold_mk4','','','',[],[],''],['ItemMap','','','ItemCompass','ItemWatch','']]QT;
    tsp_hidf_sf_sniper = QT[['rhs_weap_m24sws_wd','rhsgref_sdn6_suppressor','','rhsusf_acc_LEUPOLDMK4_wd',['rhsusf_5Rnd_762x51_m118_special_Mag',5],[],'rhs_acc_ghillie_m24'],[],['rhsusf_weap_m1911a1','','','',['rhsusf_mag_7x45acp_MHP',7],[],''],['rhsgref_uniform_ERDL',[SF_ITEMS,ITEMS_SNIPER,[KNIFE,1]]],[SF_VESTS,[['ACRE_PRC148',1],['rhsusf_5Rnd_762x51_m993_Mag',9,5],['rhsusf_5Rnd_762x51_m62_Mag',10,5],['rhsusf_mag_7x45acp_MHP',5,7],['rhs_grenade_anm8_mag',1,1],['rhs_grenade_mkii_mag',1,1],['Chemlight_green',2,1]]],[],SF_HEAD,'sniper_od',['ACE_Yardage450','','','',[],[],''],['ItemMap','','','ItemCompass','ItemWatch','']]QT;

    tsp_hidf_sf_teamlead = QT[['rhs_weap_m4_handguard_car','','rhs_acc_m4_car_pointer','',['rhs_mag_30Rnd_556x45_M855A1_Stanag',20],[],'rhs_acc_m4_handguard'],[],KNIFE,['rhsgref_uniform_ERDL',[SF_ITEMS]],[SF_VESTS,[['ACRE_PRC148',1],['rhs_mag_30Rnd_556x45_M855A1_Stanag',3,20],['rhs_mag_30Rnd_556x45_M855A1_Stanag_Tracer_Red',3,20],['rhs_mag_m18_green',1,1],['rhs_grenade_anm8_mag',1,1],['rhs_grenade_mkii_mag',1,1],['Chemlight_green',2,1]]],[],'rhssaf_booniehat_md2camo','',['Binocular','','','',[],[],''],['ItemMap','','','ItemCompass','ItemWatch','']]QT;
    tsp_hidf_sf_medic = QT[['rhs_weap_m4_handguard_car','','rhs_acc_m4_car_pointer','',['rhs_mag_30Rnd_556x45_M855A1_Stanag',30],[],'rhs_acc_m4_handguard'],[],KNIFE,['rhsgref_uniform_og107_erdl',[SF_ITEMS]],[SF_VESTS,[['rhs_mag_30Rnd_556x45_M855A1_Stanag',4,30],['rhs_mag_30Rnd_556x45_M855A1_Stanag_Tracer_Red',4,30],['rhs_grenade_anm8_mag',2,1],['rhs_grenade_mkii_mag',1,1],['Chemlight_green',2,1]]],['rhsgref_hidf_alicepack',[['Medikit',1],['ACE_salineIV',4],['tsp_ifak',2],['ACE_bodyBag',4]]],SF_HEAD,'',[],['ItemMap','','','ItemCompass','ItemWatch','']]QT;
    tsp_hidf_sf_engineer = QT[['rhs_weap_m3a1_specops','','','',['rhsgref_30rnd_1143x23_M1911B_SMG',30],[],''],['tsp_meleeWeapon_sledge_red','','','',[],[],''],['tsp_meleeWeapon_etool','','','',[],[],''],['rhsgref_uniform_og107_erdl',[SF_ITEMS,[KNIFE,1]]],[SF_VESTS,[['rhsgref_30rnd_1143x23_M1911B_SMG',3,30],['rhsgref_30rnd_1143x23_M1T_SMG',3,30],['rhs_grenade_anm8_mag',1,1],['rhs_grenade_mkii_mag',1,1],['Chemlight_green',2,1]]],['rhsgref_hidf_alicepack',[        ['ToolKit',1],['MineDetector',1],['ACE_DefusalKit',1],['ACE_wirecutter',1],['ACE_Fortify',1],['ACE_M26_Clacker',1],['rhsusf_m112_mag',2,1],['rhsusf_m112x4_mag',1,1],['rhs_mag_an_m14_th3',1,1],['tsp_breach_shock',1],['tsp_breach_block_mag',2,1],['tsp_breach_linear_mag',2,1],['rhsusf_mine_m14_mag',2,1],['rhs_mine_Mk2_tripwire_mag',1,1],['rhs_mine_mk2_pressure_mag',1,1]]],SF_HEAD,SF_EYE,[],['ItemMap','','','ItemCompass','ItemWatch','']]QT;
};