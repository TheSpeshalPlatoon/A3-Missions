class CfgPatches {
	class tsp_faction_syn {
		requiredAddons[] = {};
        units[] = {"tsp_syn_thug1","tsp_syn_thug2","tsp_syn_thug3","tsp_syn_thug4","tsp_syn_machinegunner","tsp_syn_marksman"};
	};
};

class CfgEditorSubCategories {class tsp_men_thug {displayName = "Men (Thug)";};};

class CfgVehicles {
    class I_C_Soldier_Para_1_F;
    class tsp_syn_thug1: I_C_Soldier_Para_1_F {displayName = "Thug 1"; editorSubcategory = "tsp_men_thug";};
    class tsp_syn_thug2: tsp_syn_thug1 {displayName = "Thug 2";};
    class tsp_syn_thug3: tsp_syn_thug1 {displayName = "Thug 3";};
    class tsp_syn_thug4: tsp_syn_thug1 {displayName = "Thug 4";};
    class tsp_syn_machinegunner: I_C_Soldier_Para_1_F {displayName = "Machine Gunner"; icon = "iconManMG";};
    class tsp_syn_marksman: I_C_Soldier_Para_1_F {displayName = "Marksman";};
};

class CfgLoadouts {  //-- QT allows for using #definitions within a string
    #define QT "

    #define ITEMS ['ACE_EarPlugs',1],['ACE_Cellphone',1],['FirstAidKit',1]

    #define KNIFE [selectRandom['','','tsp_meleeWeapon_kitchen','tsp_meleeWeapon_kabar'],'','','',[],[],'']
        
    #define HEAD selectRandom['','H_Bandanna_gry','H_Bandanna_blu','H_Bandanna_cbr','H_Bandanna_khk','H_Bandanna_sgg','H_Bandanna_sand','H_Bandanna_surfer','H_Bandanna_surfer_blk','H_Bandanna_surfer_grn','H_Bandanna_camo','H_Bandanna_cbr','h_cap_blk','h_cap_blu','h_cap_grn','h_cap_oli','h_cap_red','h_cap_tan','H_Booniehat_oli','H_Booniehat_khk']
    #define EYE selectRandom['','G_Bandanna_beast','G_Bandanna_aviator','G_Bandanna_shades','G_Bandanna_blk','G_Bandanna_khk','G_Bandanna_oli','G_Bandanna_khk']

    #define UNIFORMS_BANDIT selectRandom['U_I_C_Soldier_Bandit_1_F','U_I_C_Soldier_Bandit_2_F','U_I_C_Soldier_Bandit_3_F','U_I_C_Soldier_Bandit_4_F','U_I_C_Soldier_Bandit_5_F']
    #define UNIFORMS_PARA selectRandom['U_I_C_Soldier_Para_1_F','U_I_C_Soldier_Para_2_F','U_I_C_Soldier_Para_3_F','U_I_C_Soldier_Para_4_F','U_I_C_Soldier_Camo_F'] 
    
    #define RIGS selectRandom['rhs_chicom','rhs_chicom_khk']
    #define VESTS selectRandom['tacticalvest_black','tacticalvest_brown','tacticalvest_olive'] 

    tsp_syn_thug1 = QT[[],[],['rhs_weap_makarov_pm','','','',['rhs_mag_9x18_8_57N181S',8],[],''],[UNIFORMS_BANDIT,[ITEMS,['rhs_mag_9x18_8_57N181S',4,8]]],[],[],HEAD,'',[],['ItemMap','','','ItemCompass','ItemWatch','']]QT;
    tsp_syn_thug2 = QT[[],[],['a2_tracker','','','',['a2_tracker_mag',6],[],''],[UNIFORMS_BANDIT,[ITEMS,['a2_tracker_mag',2,6]]],[],[],HEAD,'',[],['ItemMap','','','ItemCompass','ItemWatch','']]QT;
    tsp_syn_thug3 = QT[[],[],['RH_muzi','','','',['RH_30Rnd_9x19_UZI',30],[],''],[UNIFORMS_BANDIT,[ITEMS,['RH_30Rnd_9x19_UZI',2,30]]],[],[],HEAD,'',[],['ItemMap','','','ItemCompass','ItemWatch','']]QT;
    tsp_syn_thug4 = QT[['rhs_weap_Izh18','','','',['rhsgref_1Rnd_00Buck',1],[],''],[],KNIFE,[UNIFORMS_BANDIT,[ITEMS,['rhsgref_1Rnd_00Buck',10,1]]],[],[],HEAD,'',[],['ItemMap','','','ItemCompass','ItemWatch','']]QT;
        
    //MED//RPG//MG//WATCHER//SCOUT//UGL//DEALER//MINES
    I_C_Soldier_Bandit_1_F = QT[['rhs_weap_m3a1','','','',['rhsgref_30rnd_1143x23_M1911B_SMG',30],[],''],[],KNIFE,[UNIFORMS_BANDIT,[ITEMS]],['rhs_belt_RPK',[['rhsgref_30rnd_1143x23_M1911B_SMG',2,30],['rhsgref_30rnd_1143x23_M1T_SMG',1,30],['rhs_grenade_mkii_mag',1,1]]],['B_CivilianBackpack_01_Everyday_Black_F',[['Medikit',1]]],HEAD,'',[],['ItemMap','','','ItemCompass','ItemWatch','']]QT;
    I_C_Soldier_Bandit_2_F = QT[['rhs_weap_m1garand_sa43','','','',['rhsgref_8Rnd_762x63_M2B_M1rifle',8],[],''],['rhs_weap_rpg7','','','',['rhs_rpg7_PG7V_mag',1],[],''],[],[UNIFORMS_BANDIT,[ITEMS]],[RIGS,[['rhsgref_8Rnd_762x63_M2B_M1rifle',6,8],['rhsgref_8Rnd_762x63_Tracer_M1T_M1rifle',6,8],['rhs_grenade_mkii_mag',1,1]]],['B_CivilianBackpack_01_Everyday_Black_F',[['rhs_rpg7_PG7V_mag',2,1],['rhs_rpg7_OG7V_mag',2,1]]],HEAD,'G_Bandanna_oli',[],['ItemMap','','','ItemCompass','ItemWatch','']]QT;
    I_C_Soldier_Bandit_3_F = QT[['rhs_weap_rpk_wood','','rhs_acc_rpk','',['rhs_75Rnd_762x39mm',75],[],''],[],KNIFE,[UNIFORMS_BANDIT,[ITEMS]],[RIGS,[['rhs_75Rnd_762x39mm',1,75],['rhs_75Rnd_762x39mm_tracer',1,75],['rhs_grenade_mkii_mag',1,1]]],[],HEAD,'',[],['ItemMap','','','ItemCompass','ItemWatch','']]QT;
    I_C_Soldier_Bandit_4_F = QT[['rhs_weap_m14','','','',['rhsusf_20Rnd_762x51_m80_Mag',20],[],''],[],KNIFE,[UNIFORMS_BANDIT,[ITEMS]],[RIGS,[['rhsusf_20Rnd_762x51_m80_Mag',2,20],['rhsusf_20Rnd_762x51_m62_Mag',2,20],['rhs_grenade_mkii_mag',1,1]]],[],HEAD,'',[],['ItemMap','','','ItemCompass','ItemWatch','']]QT;
    I_C_Soldier_Bandit_5_F = QT[[selectRandom['rhs_weap_akm','rhs_weap_akms'],'rhs_acc_dtkakm','','',['rhs_30Rnd_762x39mm',30],[],''],[],KNIFE,[UNIFORMS_BANDIT,[ITEMS]],[RIGS,[['rhs_30Rnd_762x39mm',3,30],['rhs_30Rnd_762x39mm_tracer',3,30],['rhs_grenade_mkii_mag',1,1]]],[],HEAD,'',[],['ItemMap','','','ItemCompass','ItemWatch','']]QT;
    I_C_Soldier_Bandit_6_F = QT[['rhs_weap_m79','','','',['rhs_mag_M441_HE',1],[],''],[],['rhs_weap_makarov_pm','','','',['rhs_mag_9x18_8_57N181S',8],[],''],[UNIFORMS_BANDIT,[ITEMS]],['rhs_belt_AK_GL',[['rhs_mag_M441_HE',8,1],['rhs_mag_m662_red',4,1],['rhs_mag_9x18_8_57N181S',4,8]]],[],HEAD,'',[],['ItemMap','','','ItemCompass','ItemWatch','']]QT;
    I_C_Soldier_Bandit_7_F = QT[['rhs_weap_m3a1','','','',['rhsgref_30rnd_1143x23_M1911B_SMG',30],[],''],[],KNIFE,[UNIFORMS_BANDIT,[ITEMS]],['rhs_belt_RPK',[['rhsgref_30rnd_1143x23_M1911B_SMG',2,30],['rhsgref_30rnd_1143x23_M1T_SMG',1,30],['rhs_grenade_mkii_mag',1,1]]],[],HEAD,'',[],['ItemMap','','','ItemCompass','ItemWatch','']]QT;
    I_C_Soldier_Bandit_8_F = QT[['rhs_weap_aks74u','rhs_acc_dtk1983','','',['rhs_30Rnd_545x39_7N6M_AK',30],[],''],[],KNIFE,[UNIFORMS_BANDIT,[ITEMS]],[RIGS,[['rhs_30Rnd_545x39_7N6M_AK',3,30],['rhs_30Rnd_545x39_AK_green',3,30],['rhs_grenade_mkii_mag',1,1]]],['B_CivilianBackpack_01_Everyday_Black_F',[['ToolKit',1],['tsp_paperclip',8],['ACE_Cellphone',1],['IEDLandSmall_Remote_Mag',1,1],['IEDUrbanBig_Remote_Mag',1,1],['rhs_mine_Mk2_tripwire_mag',4,1]]],HEAD,EYE,[],['ItemMap','','','','ItemWatch','']]QT;
    
    #define PARA_ITEMS ['ACE_EarPlugs',1],['ACE_Cellphone',1],['ACRE_BF888S',1],['FirstAidKit',1],['tsp_sling',1]    
    #define PARA_HEAD selectRandom['','H_Bandanna_khk','H_Bandanna_camo','h_cap_grn','h_cap_oli','H_Booniehat_oli','H_Booniehat_khk']
    //UNARMED//SOLDIER//ENFORCER//MED//MG//RPG//UGL//DESERTER//EXP
    I_C_Soldier_base_unarmed_F = QT[[],[],[],[UNIFORMS_PARA,[PARA_ITEMS]],[RIGS,[]],[],PARA_HEAD,EYE,[],['ItemMap','','','ItemCompass','ItemWatch','']]QT;
    I_C_Soldier_Para_1_F = QT[[selectRandom['rhs_weap_akm','rhs_weap_akms'],'rhs_acc_dtkakm','','',['rhs_30Rnd_762x39mm',30],[],''],[],KNIFE,[UNIFORMS_PARA,[PARA_ITEMS]],[RIGS,[['rhs_30Rnd_762x39mm',3,30],['rhs_30Rnd_762x39mm_tracer',3,30],['rhs_grenade_mkii_mag',1,1]]],[],PARA_HEAD,EYE,[],['ItemMap','','','ItemCompass','ItemWatch','']]QT;
    I_C_Soldier_Para_2_F = QT[['rhs_weap_l1a1_wood','rhsgref_acc_falMuzzle_l1a1','','',['rhs_mag_20Rnd_762x51_m80_fnfal',20],[],''],[],KNIFE,[UNIFORMS_PARA,[PARA_ITEMS]],['rhsgref_alice_webbing',[['rhs_mag_20Rnd_762x51_m80_fnfal',3,20],['rhs_mag_20Rnd_762x51_m62_fnfal',3,20],['rhs_grenade_mkii_mag',1,1]]],[],PARA_HEAD,EYE,[],['ItemMap','','','ItemCompass','ItemWatch','']]QT;
    I_C_Soldier_Para_3_F = QT[['rhs_weap_akms','rhs_acc_dtkakm','','',['rhs_30Rnd_762x39mm',30],[],''],[],KNIFE,[UNIFORMS_PARA,[PARA_ITEMS]],[RIGS,[['rhs_30Rnd_762x39mm',3,30],['rhs_30Rnd_762x39mm_tracer',3,30],['rhs_grenade_mkii_mag',1,1]]],['B_CivilianBackpack_01_Everyday_Black_F',[['Medikit',1]]],PARA_HEAD,EYE,[],['ItemMap','','','ItemCompass','ItemWatch','']]QT;
    I_C_Soldier_Para_4_F = QT[['rhs_weap_rpk_wood','','rhs_acc_rpk','',['rhs_75Rnd_762x39mm',75],[],''],[],KNIFE,[UNIFORMS_PARA,[PARA_ITEMS]],['assaultVest_olive',[['rhs_75Rnd_762x39mm',2,75],['rhs_75Rnd_762x39mm_tracer',2,75],['rhs_grenade_mkii_mag',1,1]]],[],PARA_HEAD,EYE,[],['ItemMap','','','ItemCompass','ItemWatch','']]QT;
    I_C_Soldier_Para_5_F = QT[[selectRandom['rhs_weap_ak74n','rhs_weap_aks74n'],'rhs_acc_dtk1983','','',['rhs_30Rnd_545x39_7N6M_AK',30],[],''],['rhs_weap_rpg7','','','',['rhs_rpg7_PG7V_mag',1],[],''],KNIFE,[UNIFORMS_PARA,[PARA_ITEMS,['rhs_30Rnd_545x39_7N6M_AK',1,30]]],[RIGS,[['rhs_30Rnd_545x39_7N6M_AK',4,30],['rhs_30Rnd_545x39_AK_green',4,30],['rhs_grenade_mkii_mag',1,1]]],['rhs_rpg_2',[['rhs_rpg7_PG7V_mag',2,1],['rhs_rpg7_OG7V_mag',2,1]]],PARA_HEAD,EYE,[],['ItemMap','','','ItemCompass','ItemWatch','']]QT;
    I_C_Soldier_Para_6_F = QT[[selectRandom['rhs_weap_akm_gp25','rhs_weap_akms_gp25'],'rhs_acc_dtkakm','','',['rhs_30Rnd_762x39mm_bakelite',30],['rhs_VOG25',1],''],[],KNIFE,[UNIFORMS_PARA,[PARA_ITEMS,['rhs_VOG25',2,1]]],['assaultVest_olive',[['rhs_30Rnd_762x39mm_bakelite',3,30],['rhs_30Rnd_762x39mm_bakelite_tracer',3,30],['rhs_VOG25',6,1]]],[],PARA_HEAD,EYE,[],['ItemMap','','','ItemCompass','ItemWatch','']]QT;
    I_C_Soldier_Para_7_F = QT[['rhs_weap_m16a2','','rhs_acc_m16_handguard','',['rhs_mag_30Rnd_556x45_M855A1_Stanag',30],[],'rhs_acc_m16_norail'],[],KNIFE,[UNIFORMS_PARA,[PARA_ITEMS,['rhs_mag_30Rnd_556x45_M855A1_Stanag',1,30]]],[VESTS,[['rhs_mag_30Rnd_556x45_M855A1_Stanag',4,30],['rhs_mag_30Rnd_556x45_M855A1_Stanag_Tracer_Red',4,30],['rhs_mag_20Rnd_556x45_M196_2MAG_Stanag_Tracer_Red',2,20],['rhs_mag_20Rnd_556x45_M193_2MAG_Stanag',2,20],['rhs_grenade_mkii_mag',1,1]]],[],PARA_HEAD,EYE,[],['ItemMap','','','ItemCompass','ItemWatch','']]QT;
    I_C_Soldier_Para_7_F_unused = QT[[selectRandom['rhs_weap_ak74n','rhs_weap_aks74n'],'rhs_acc_dtk1983','','',['rhs_30Rnd_545x39_7N6M_AK',30],[],''],[],KNIFE,[UNIFORMS_PARA,[PARA_ITEMS,['rhs_30Rnd_545x39_7N6M_AK',1,30]]],[RIGS,[['rhs_30Rnd_545x39_7N6M_AK',4,30],['rhs_30Rnd_545x39_AK_green',4,30],['rhs_grenade_mkii_mag',1,1]]],[],PARA_HEAD,EYE,[],['ItemMap','','','ItemCompass','ItemWatch','']]QT;
    I_C_Soldier_Para_8_F = QT[['rhs_weap_aks74u','rhs_acc_dtk1983','','',['rhs_30Rnd_545x39_7N6M_AK',30],[],''],[],['tsp_meleeWeapon_etool','','','',[],[],''],[UNIFORMS_PARA,[PARA_ITEMS]],[RIGS,[['rhs_30Rnd_545x39_7N6M_AK',3,30],['rhs_30Rnd_545x39_AK_green',3,30],['rhs_grenade_mkii_mag',1,1]]],['rhs_rd54_flora1',[['ToolKit',1],['tsp_paperclip',8],['ACE_Cellphone',1],['IEDLandSmall_Remote_Mag',1,1],['IEDUrbanBig_Remote_Mag',1,1],['rhs_mine_Mk2_tripwire_mag',4,1]]],PARA_HEAD,EYE,[],['ItemMap','','','ItemCompass','ItemWatch','']]QT;
    
    #define PARA_HEAD_SNIPER selectRandom['','H_Bandanna_khk','H_Bandanna_camo','h_cap_grn','h_cap_oli','H_Booniehat_oli','H_Booniehat_khk','H_Hat_Safari_olive_F','H_Hat_Safari_sand_F']
    tsp_syn_machinegunner = QT[['rhs_weap_pkm','','','',['rhs_100Rnd_762x54mmR',100],[],''],[],KNIFE,[UNIFORMS_PARA,[ITEMS,['rhs_grenade_mkii_mag',1,1]]],['RPS_Smersh6',[['rhs_100Rnd_762x54mmR',2,100],['rhs_100Rnd_762x54mmR_green',1,100]]],[],PARA_HEAD,EYE,[],['ItemMap','','','ItemCompass','ItemWatch','']]QT;
    tsp_syn_marksman = QT[['rhs_weap_m14_rail','','','rhs_acc_dh520x56',['rhsusf_20Rnd_762x51_m80_Mag',20],[],''],[],KNIFE,[UNIFORMS_PARA,[PARA_ITEMS]],[VESTS,[['rhsusf_20Rnd_762x51_m80_Mag',3,20],['rhsusf_20Rnd_762x51_m62_Mag',3,20],['rhs_grenade_mkii_mag',1,1]]],[],PARA_HEAD_SNIPER,EYE,[],['ItemMap','','','ItemCompass','ItemWatch','']]QT;
   
    //PILOT//HELI//OFFICER
    I_C_Pilot_F = QT[['rhs_weap_savz61','','','',['rhsgref_20rnd_765x17_vz61',20],[],''],[],[],['U_I_C_Soldier_Bandit_3_F',[PARA_ITEMS,['rhsgref_20rnd_765x17_vz61',2,20]]],[],KNIFE,'H_Cap_marshal','',[],['ItemMap','','','ItemCompass','ItemWatch','']]QT;
    I_C_Helipilot_F = QT[['rhs_weap_aks74u','rhs_acc_dtk1983','','',['rhs_30Rnd_545x39_7N6M_AK',30],[],''],[],KNIFE,[UNIFORMS_PARA,[PARA_ITEMS]],[VESTS,[['rhs_30Rnd_545x39_7N6M_AK',3,30],['rhs_30Rnd_545x39_AK_green',3,30]]],[],'H_Cap_headphones','',[],['ItemMap','','','ItemCompass','ItemWatch','']]QT;
    I_C_Soldier_Camo_F = QT[[],[],['rhs_weap_makarov_pm','','','',['rhs_mag_9x18_8_57N181S',8],[],''],['U_I_C_Soldier_Camo_F',[PARA_ITEMS,['rhs_mag_9x18_8_57N181S',2,8]]],[],[],'H_MilCap_gry','G_Aviator',['Binocular','','','',[],[],''],['ItemMap','','','ItemCompass','ItemWatch','']]QT;

    //HIDDEN
    SyndikatSoldier_Default = QT[[selectRandom['rhs_weap_akm','rhs_weap_akms'],'rhs_acc_dtkakm','','',['rhs_30Rnd_762x39mm',30],[],''],[],KNIFE,[UNIFORMS_PARA,[PARA_ITEMS]],[RIGS,[['rhs_30Rnd_762x39mm',3,30],['rhs_30Rnd_762x39mm_tracer',3,30],['rhs_grenade_mkii_mag',1,1]]],[],PARA_HEAD,EYE,[],['ItemMap','','','ItemCompass','ItemWatch','']]QT;
    I_C_Soldier_universal_F = QT[[selectRandom['rhs_weap_akm','rhs_weap_akms'],'rhs_acc_dtkakm','','',['rhs_30Rnd_762x39mm',30],[],''],[],KNIFE,[UNIFORMS_PARA,[PARA_ITEMS]],[RIGS,[['rhs_30Rnd_762x39mm',3,30],['rhs_30Rnd_762x39mm_tracer',3,30],['rhs_grenade_mkii_mag',1,1]]],[],PARA_HEAD,EYE,[],['ItemMap','','','ItemCompass','ItemWatch','']]QT;
};