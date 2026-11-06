class CfgPatches {class tsp_faction_loot {requiredAddons[] = {}; units[] = {};};};

class CfgLoadouts {  //-- QT allows for using #definitions within a string
    #define QT "

    #define ITEMS ['ACE_EarPlugs',1],['FirstAidKit',1]

    #define KNIFE ['tsp_meleeWeapon_kitchen','','','',[],[],'']

    #define HEAD selectRandom['','','','','','','','','H_Bandanna_gry','H_Bandanna_blu','H_Bandanna_cbr','H_Bandanna_khk','H_Bandanna_sgg','H_Bandanna_sand','H_Bandanna_surfer','H_Bandanna_surfer_blk','H_Bandanna_surfer_grn','H_Bandanna_camo','rhs_beanie_green','H_Cap_blk','H_Cap_blu','H_Cap_grn','H_Cap_oli','H_Cap_red','H_Cap_surfer','H_Cap_tan']
    #define HEAD_HUNTER selectRandom['','','','H_Hat_Safari_olive_F','H_Hat_Safari_sand_F','UK3CB_H_Safari_Hat_Brown','rhssaf_booniehat_woodland','rhssaf_booniehat_md2camo','H_Booniehat_khk','H_Booniehat_mgrn','H_Booniehat_oli','H_Booniehat_tan']
    #define EYE selectRandom['','','','','','','','','G_Aviator','G_Bandanna_aviator','G_Bandanna_beast','G_Bandanna_blk','G_Bandanna_BlueFlame1','G_Bandanna_BlueFlame2','G_Bandanna_CandySkull','G_Bandanna_khk','G_Bandanna_oli','G_Bandanna_OrangeFlame1','G_Bandanna_RedFlame1','G_Bandanna_shades','G_Bandanna_Skull1','G_Bandanna_Syndikat1','G_Bandanna_Skull2','G_Bandanna_sport','G_Bandanna_tan','G_Bandanna_Vampire_01','G_Bandanna_Syndikat2','rhs_scarf','G_Shades_Black','G_Shades_Blue','G_Shades_Green','G_Shades_Red','G_Spectacles','G_Sport_Red','G_Sport_Blackyellow','G_Sport_BlackWhite','G_Sport_Checkered','G_Sport_Blackred','G_Sport_Greenblack','G_Squares_Tinted','G_Squares']
    #define EYE_GANG selectRandom['','','','G_Balaclava_blk','G_Balaclava_BlueStrips','G_Balaclava_Flecktarn','G_Balaclava_Halloween_01','G_Balaclava_oli','G_Balaclava_Flames1','G_Balaclava_Scarecrow_01','G_Balaclava_Skull1','G_Balaclava_Tropentarn']
    #define HEAD_EYE selectRandom[[HEAD,EYE],['',EYE_GANG]]

    #define UNIFORMS selectRandom['U_C_E_LooterJacket_01_F','U_I_L_Uniform_01_tshirt_black_F','U_I_L_Uniform_01_tshirt_olive_F','U_I_L_Uniform_01_tshirt_skull_F','U_I_L_Uniform_01_tshirt_sport_F','UK3CB_CHC_C_U_COACH_04','UK3CB_CHC_C_U_COACH_01','UK3CB_CHC_C_U_COACH_03','UK3CB_CHC_C_U_COACH_05','UK3CB_CHC_C_U_COACH_02','U_I_C_Soldier_Bandit_2_F','U_I_C_Soldier_Bandit_3_F']
    
    #define BAGS selectRandom['B_Messenger_Black_F','B_Messenger_Coyote_F','B_Messenger_Gray_F','B_Messenger_Olive_F','B_CivilianBackpack_01_Sport_Blue_F','B_CivilianBackpack_01_Sport_Green_F','B_CivilianBackpack_01_Sport_Red_F','B_CivilianBackpack_01_Everyday_Astra_F','B_CivilianBackpack_01_Everyday_Black_F','B_CivilianBackpack_01_Everyday_Vrana_F','B_CivilianBackpack_01_Everyday_IDAP_F']

    I_L_Hunter_F = QT[['rhs_weap_Izh18','','','',['rhsgref_1Rnd_00Buck',1],[],''],[],['tsp_meleeWeapon_kabar','','','',[],[],''],['U_C_HunterBody_grn',[ITEMS,['ACRE_BF888S',1],['rhsgref_1Rnd_00Buck',13,1]]],[],[],HEAD_HUNTER,'',[],['ItemMap','','','ItemCompass','ItemWatch','']]QT;

    I_L_Criminal_SG_F = QT(HEAD_EYE) params ['_head','_eye'];[['sgun_HunterShotgun_01_sawedoff_F','','','',['2Rnd_12Gauge_Pellets',2],[],''],[],KNIFE,['U_C_E_LooterJacket_01_F',[ITEMS,['2Rnd_12Gauge_Pellets',3,2]]],[],[],_head,_eye,[],['ItemMap','','','ItemCompass','ItemWatch','']]QT;
    I_L_Criminal_SMG_F = QT(HEAD_EYE) params ['_head','_eye'];[[],[],['RH_muzi','','','',['RH_30Rnd_9x19_UZI',30],[],''],['UK3CB_CHC_C_U_COACH_04',[ITEMS,['RH_30Rnd_9x19_UZI',1,30]]],[],[BAGS,[]],_head,_eye,[],['ItemMap','','','ItemCompass','ItemWatch','']]QT;
    
    I_L_Looter_Rifle_F = QT[['rhs_weap_m14','','','',['rhsusf_20Rnd_762x51_m80_Mag',20],[],''],[],KNIFE,['U_BG_Guerilla3_1',[ITEMS,['rhsusf_20Rnd_762x51_m118_special_Mag',2,20]]],[],[],HEAD,EYE,[],['ItemMap','','','ItemCompass','ItemWatch','']]QT;
    I_L_Looter_SMG_F = QT[[],[],['RH_muzi','','','',['RH_30Rnd_9x19_UZI',30],[],''],[UNIFORMS,[ITEMS,['RH_30Rnd_9x19_UZI',3,30]]],[],[],HEAD,EYE,[],['ItemMap','','','ItemCompass','ItemWatch','']]QT;
    I_L_Looter_SG_F = QT[['sgun_HunterShotgun_01_F','','','',['2Rnd_12Gauge_Pellets',2],[],''],[],KNIFE,[UNIFORMS,[ITEMS,['2Rnd_12Gauge_Pellets',4,2]]],[],[BAGS,[]],HEAD,EYE,[],['ItemMap','','','ItemCompass','ItemWatch','']]QT;
    I_L_Looter_Pistol_F = QT[[],[],['a2_tracker','','','',['6Rnd_45ACP_Cylinder',6],[],''],[UNIFORMS,[ITEMS,['6Rnd_45ACP_Cylinder',3,6]]],[],[BAGS,[]],HEAD,EYE,[],['ItemMap','','','ItemCompass','ItemWatch','']]QT;
};