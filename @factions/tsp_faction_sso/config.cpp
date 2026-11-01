class CfgPatches {
	class tsp_faction_sso {
		requiredAddons[] = {};
        units[] = {
            "tsp_sso_operator","tsp_sso_operator_ak103","tsp_sso_operator_asval","tsp_sso_operator_RShG2","tsp_sso_operator_lat",
            "tsp_sso_grenadier","tsp_sso_grenadier_alt","tsp_sso_grenadier_rpg","tsp_sso_strelok_rpg_assist",
            "tsp_sso_medic",
            "tsp_sso_arifleman_rpk","tsp_sso_arifleman","tsp_sso_machinegunner","tsp_sso_machinegunner_assistant",
            "tsp_sso_teamlead","tsp_sso_officer","tsp_sso_officer_armored",
            "tsp_sso_marksman","tsp_sso_marksman_asval","tsp_sso_marksman_vss",
            "tsp_sso_breacher","tsp_sso_engineer","tsp_sso_at",
            "rhs_tigr_sso","rhs_tigr_3camo_sso","rhs_tigr_sts_sso","rhs_tigr_sts_3camo_sso","rhs_tigr_m_sso","rhs_tigr_m_3camo_sso",
            
            "UK3CB_SSO_B_Urban_SUV","UK3CB_SSO_B_Urban_SUV_Armed","UK3CB_SSO_B_Urban_SUV_Armoured",
            
            "O_SSO_LSV_02_armed_F","O_SSO_LSV_02_unarmed_F","O_SSO_LSV_02_AT_F"
        };
	};
};

class CfgFactionClasses {class tsp_sso {displayName = "Russia (SSO)"; side = 0; flag = ''; icon = ''; priority = 0;};};

class CfgGroups {
    class East {
        class o_tsp_sso {
            name = "Russia (SSO)";
            class Infantry {name = "Infantry";};
            class SpecOps {name = "Special Forces";
                class o_tsp_sso_squad {
                    name = "Squad"; side = 0; faction = "tsp_sso"; icon = "\A3\ui_f\data\map\markers\nato\n_inf.paa";
                    class Unit0 {side = 0; position[] = {0,0,0}; rank = "SERGEANT"; vehicle = "tsp_sso_teamlead";};
                    class Unit1: Unit0 {position[] = {5,-5,0}; rank = "PRIVATE"; vehicle = "tsp_sso_medic";};
                    class Unit2: Unit0 {position[] = {-5,-5,0}; rank = "PRIVATE"; vehicle = "tsp_sso_operator";};
                    class Unit3: Unit0 {position[] = {10,-10,0}; rank = "PRIVATE"; vehicle = "tsp_sso_operator_asval";};
                    class Unit4: Unit0 {position[] = {-10,-10,0}; rank = "CORPORAL"; vehicle = "tsp_sso_operator_lat";};
                    class Unit5: Unit0 {position[] = {-15,-15,0}; rank = "PRIVATE"; vehicle = "tsp_sso_arifleman";};
                    class Unit6: Unit0 {position[] = {20,-20,0}; rank = "PRIVATE"; vehicle = "tsp_sso_machinegunner_assistant";};
                    class Unit7: Unit0 {position[] = {-15,-25,0}; rank = "PRIVATE"; vehicle = "tsp_sso_grenadier";};
                };
                class o_tsp_sso_team: o_tsp_sso_squad {
                    name = "Team";
                    class Unit0: Unit0 {position[] = {0,0,0}; rank = "SERGEANT"; vehicle = "tsp_sso_teamlead";};
                    class Unit1: Unit0 {position[] = {5,-5,0}; rank = "PRIVATE"; vehicle = "tsp_sso_arifleman_rpk";};
                    class Unit2: Unit0 {position[] = {-5,-5,0}; rank = "PRIVATE"; vehicle = "tsp_sso_operator_RShG2";};
                    class Unit3: Unit0 {position[] = {10,-10,0}; rank = "PRIVATE"; vehicle = "tsp_sso_operator";};
                };
                class o_tsp_sso_saboteurs: o_tsp_sso_squad {
                    name = "Saboteurs";
                    class Unit0: Unit0 {position[] = {0,0,0}; rank = "SERGEANT"; vehicle = "tsp_sso_operator_asval";};
                    class Unit1: Unit0 {position[] = {5,-5,0}; rank = "PRIVATE"; vehicle = "tsp_sso_engineer";};
                };
                class o_tsp_sso_mgteam: o_tsp_sso_squad {
                    name = "MG Team"; icon = "\A3\ui_f\data\map\markers\nato\n_support.paa";
                    class Unit0: Unit0 {position[] = {0,0,0}; rank = "SERGEANT"; vehicle = "tsp_sso_teamlead";};
                    class Unit1: Unit0 {position[] = {5,-5,0}; rank = "PRIVATE"; vehicle = "tsp_sso_machinegunner";};
                    class Unit2: Unit0 {position[] = {-5,-5,0}; rank = "PRIVATE"; vehicle = "tsp_sso_machinegunner_assistant";};
                };
                class o_tsp_sso_atteam: o_tsp_sso_mgteam {
                    name = "AT Team";
                    class Unit0: Unit0 {position[] = {0,0,0}; rank = "SERGEANT"; vehicle = "tsp_sso_teamlead";};
                    class Unit1: Unit0 {position[] = {5,-5,0}; rank = "PRIVATE"; vehicle = "tsp_sso_at";};
                    class Unit2: Unit0 {position[] = {-5,-5,0}; rank = "PRIVATE"; vehicle = "tsp_sso_strelok_rpg_assist";};
                };
            };
        };
    };
};

class CfgVehicles {
    class rhs_msv_rifleman;
    class tsp_sso_operator: rhs_msv_rifleman {displayName = "Operator"; faction = "tsp_sso"; editorSubcategory = "tsp_inf_sf";};
    class tsp_sso_operator_ak103: tsp_sso_operator {displayName = "Operator (AK-103)";};
    class tsp_sso_operator_asval: tsp_sso_operator {displayName = "Operator (AS Val)";};
    class tsp_sso_operator_RShG2: tsp_sso_operator {displayName = "Operator (RShG2)";};
    class tsp_sso_operator_lat: tsp_sso_operator {displayName = "Operator (RPG-26)";};
    class tsp_sso_grenadier: tsp_sso_operator {displayName = "Operator (GP-25)";};
    class tsp_sso_grenadier_alt: tsp_sso_operator {displayName = "Operator (GP-25) 2";};
    class tsp_sso_grenadier_rpg: tsp_sso_operator {displayName = "Grenadier (RPG-7V2)";};
    class tsp_sso_strelok_rpg_assist: tsp_sso_operator {displayName = "Grenadier Assistant";};
    class tsp_sso_medic: tsp_sso_operator {displayName = "Medic";};
    class tsp_sso_arifleman_rpk: tsp_sso_operator {displayName = "Automatic Rifleman";};
    class tsp_sso_arifleman: tsp_sso_operator {displayName = "Automatic Rifleman (PKP)";};
    class tsp_sso_machinegunner: tsp_sso_operator {displayName = "Machine Gunner";};
    class tsp_sso_machinegunner_assistant: tsp_sso_operator {displayName = "Machine Gunner Assistant";};
    class tsp_sso_teamlead: tsp_sso_operator {displayName = "Team Leader";};
    class tsp_sso_officer: tsp_sso_operator {displayName = "Officer";};
    class tsp_sso_officer_armored: tsp_sso_operator {displayName = "Officer (Armored)";};
    class tsp_sso_sniper: tsp_sso_operator {displayName = "Sniper";};
    class tsp_sso_marksman: tsp_sso_operator {displayName = "Marksman";};
    class tsp_sso_marksman_asval: tsp_sso_operator {displayName = "Marksman (AS Val)";};
    class tsp_sso_marksman_vss: tsp_sso_operator {displayName = "Marksman (VSS)";};
    class tsp_sso_breacher: tsp_sso_operator {displayName = "Breacher";};
    class tsp_sso_engineer: tsp_sso_operator {displayName = "Engineer";};
    class tsp_sso_at: tsp_sso_operator {displayName = "AT Specialist";};
    
//-- VEHICLES
    class rhs_tigr_msv;
	class rhs_tigr_sso: rhs_tigr_msv {faction = "tsp_sso"; crew = "tsp_sso_operator"; typicalCargo[] = {"tsp_sso_operator"};};

    class rhs_tigr_3camo_msv;
    class rhs_tigr_3camo_sso: rhs_tigr_3camo_msv {faction = "tsp_sso"; crew = "tsp_sso_operator"; typicalCargo[] = {"tsp_sso_operator"};};

    class rhs_tigr_vdv;
    class rhs_tigr_sts_vdv: rhs_tigr_vdv {class Turrets;}; class rhs_tigr_sts_msv: rhs_tigr_sts_vdv {class Turrets: Turrets{class MainTurret;class AGS_Turret;};};
    class rhs_tigr_sts_sso: rhs_tigr_sts_msv {
        crew = "tsp_sso_operator"; typicalCargo[] = {"tsp_sso_operator"}; faction = "tsp_sso";
        class Turrets: Turrets {class MainTurret: MainTurret {gunnerType = "tsp_sso_grenadier";}; class AGS_Turret: AGS_Turret{gunnerType = "tsp_sso_grenadier";};};
    };
    class rhs_tigr_sts_3camo_vdv: rhs_tigr_sts_vdv {}; class rhs_tigr_sts_3camo_msv: rhs_tigr_sts_3camo_vdv {class Turrets: Turrets{class MainTurret;class AGS_Turret;};};
    class rhs_tigr_sts_3camo_sso: rhs_tigr_sts_3camo_msv {
		crew = "tsp_sso_operator"; typicalCargo[] = {"tsp_sso_operator"}; faction = "tsp_sso";
        class Turrets: Turrets {class MainTurret: MainTurret {gunnerType = "tsp_sso_grenadier";};class AGS_Turret: AGS_Turret{gunnerType = "tsp_sso_grenadier";};};
	};
    class rhs_tigr_m_vdv: rhs_tigr_vdv {class Turrets;}; class rhs_tigr_m_msv: rhs_tigr_m_vdv {class Turrets: Turrets{class CargoTurret_01;};};
    class rhs_tigr_m_sso: rhs_tigr_m_msv {
		crew = "tsp_sso_operator"; typicalCargo[] = {"tsp_sso_operator"}; faction = "tsp_sso";
        class Turrets: Turrets {class CargoTurret_01: CargoTurret_01 {gunnerType = "tsp_sso_machinegunner";};};
	};
    class rhs_tigr_m_3camo_vdv: rhs_tigr_m_vdv {}; class rhs_tigr_m_3camo_msv: rhs_tigr_m_3camo_vdv {class Turrets: Turrets{class CargoTurret_01;};};
    class rhs_tigr_m_3camo_sso: rhs_tigr_m_3camo_msv {
		crew = "tsp_sso_operator"; typicalCargo[] = {"tsp_sso_operator"}; faction = "tsp_sso";
        class Turrets: Turrets {class CargoTurret_01: CargoTurret_01 {gunnerType = "tsp_sso_machinegunner";};};
	};

    class UK3CB_ION_B_Urban_SUV;
    class UK3CB_SSO_B_Urban_SUV: UK3CB_ION_B_Urban_SUV {faction = "tsp_sso"; editorSubcategory = "rhs_EdSubcat_car"; side = 0; crew = "tsp_sso_operator"; typicalCargo[] = {"tsp_sso_operator"};};

    class UK3CB_ION_B_Urban_SUV_Armed;
    class UK3CB_SSO_B_Urban_SUV_Armed: UK3CB_ION_B_Urban_SUV_Armed {faction = "tsp_sso"; editorSubcategory = "rhs_EdSubcat_car"; side = 0; crew = "tsp_sso_operator"; typicalCargo[] = {"tsp_sso_operator"};};

    class UK3CB_ION_B_Urban_SUV_Armoured;
    class UK3CB_SSO_B_Urban_SUV_Armoured: UK3CB_ION_B_Urban_SUV_Armoured {faction = "tsp_sso"; editorSubcategory = "rhs_EdSubcat_car"; side = 0; crew = "tsp_sso_operator"; typicalCargo[] = {"tsp_sso_operator"};};

    class O_LSV_02_armed_F;
    class O_SSO_LSV_02_armed_F : O_LSV_02_armed_F {
        faction = "tsp_sso"; editorSubcategory = "rhs_EdSubcat_car"; crew = "tsp_sso_operator"; typicalCargo[] = {"tsp_sso_operator"};
        textureList[] = {"Black", 1, "GreenHex", 0, "Arid", 0};
        hiddenSelectionsTextures[] = {
            "\A3\Soft_F_Exp\LSV_02\Data\CSAT_LSV_01_black_CO.paa",
            "\A3\Soft_F_Exp\LSV_02\Data\CSAT_LSV_02_black_CO.paa",
            "\A3\Soft_F_Exp\LSV_02\Data\CSAT_LSV_03_black_CO.paa"
        };
        class TransportMagazines {
            class _xx_rhs_30Rnd_545x39_7N10_AK {magazine = "rhs_30Rnd_545x39_7N10_AK"; count = 4;};
            class _xx_rhs_100Rnd_762x54mmR {magazine = "rhs_100Rnd_762x54mmR"; count = 8;};
            class _xx_rhs_mag_rdg2_white {magazine = "rhs_mag_rdg2_white"; count = 2;};
            class _xx_rhs_mag_rgd5 {magazine = "rhs_mag_rgd5"; count = 6;};
            class _xx_rhs_rpg26_mag {magazine = "rhs_rpg26_mag"; count = 4;};
        };
        class TransportWeapons {class _xx_rhs_weap_rpg26 {weapon = "rhs_weap_rpg26"; count = 4;};};
        class TransportItems {
            class _xx_FirstAidKit {name = "FirstAidKit"; count = 10;};
            class _xx_Medikit {name = "Medikit"; count = 1;};
            class _xx_Toolkit {name = "Toolkit"; count = 1;};
        };
    };

    class O_LSV_02_unarmed_F;
    class O_SSO_LSV_02_unarmed_F : O_LSV_02_unarmed_F {
        faction = "tsp_sso"; editorSubcategory = "rhs_EdSubcat_car"; crew = "tsp_sso_operator"; typicalCargo[] = {"tsp_sso_operator"};
        textureList[] = {"Black", 1, "GreenHex", 0, "Arid", 0};
        hiddenSelectionsTextures[] = {
            "\A3\Soft_F_Exp\LSV_02\Data\CSAT_LSV_01_black_CO.paa",
            "\A3\Soft_F_Exp\LSV_02\Data\CSAT_LSV_02_black_CO.paa",
            "\A3\Soft_F_Exp\LSV_02\Data\CSAT_LSV_03_black_CO.paa"
        };
        class TransportMagazines {
            class _xx_rhs_30Rnd_545x39_7N10_AK {magazine = "rhs_30Rnd_545x39_7N10_AK"; count = 4;};
            class _xx_rhs_100Rnd_762x54mmR {magazine = "rhs_100Rnd_762x54mmR"; count = 8;};
            class _xx_rhs_mag_rdg2_white {magazine = "rhs_mag_rdg2_white"; count = 2;};
            class _xx_rhs_mag_rgd5 {magazine = "rhs_mag_rgd5"; count = 6;};
            class _xx_rhs_rpg26_mag {magazine = "rhs_rpg26_mag"; count = 4;};
        };
        class TransportWeapons {class _xx_rhs_weap_rpg26 {weapon = "rhs_weap_rpg26"; count = 4;};};
        class TransportItems {
            class _xx_FirstAidKit {name = "FirstAidKit"; count = 10;};
            class _xx_Medikit {name = "Medikit"; count = 1;};
            class _xx_Toolkit {name = "Toolkit"; count = 1;};
        };
    };

    class O_LSV_02_AT_F;
    class O_SSO_LSV_02_AT_F : O_LSV_02_AT_F {
        faction = "tsp_sso"; editorSubcategory = "rhs_EdSubcat_car"; crew = "tsp_sso_operator"; typicalCargo[] = {"tsp_sso_operator"};
        textureList[] = {"Black", 1, "GreenHex", 0, "Arid", 0};
        hiddenSelectionsTextures[] = {
            "\A3\Soft_F_Exp\LSV_02\Data\CSAT_LSV_01_black_CO.paa",
            "\A3\Soft_F_Exp\LSV_02\Data\CSAT_LSV_02_black_CO.paa",
            "\A3\Soft_F_Exp\LSV_02\Data\CSAT_LSV_03_black_CO.paa"
        };
        class TransportMagazines {
            class _xx_rhs_30Rnd_545x39_7N10_AK {magazine = "rhs_30Rnd_545x39_7N10_AK"; count = 4;};
            class _xx_rhs_100Rnd_762x54mmR {magazine = "rhs_100Rnd_762x54mmR"; count = 8;};
            class _xx_rhs_mag_rdg2_white {magazine = "rhs_mag_rdg2_white"; count = 2;};
            class _xx_rhs_mag_rgd5 {magazine = "rhs_mag_rgd5"; count = 6;};
            class _xx_rhs_rpg26_mag {magazine = "rhs_rpg26_mag"; count = 4;};
        };
        class TransportWeapons {class _xx_rhs_weap_rpg26 {weapon = "rhs_weap_rpg26"; count = 4;};};
        class TransportItems {
            class _xx_FirstAidKit {name = "FirstAidKit"; count = 10;};
            class _xx_Medikit {name = "Medikit"; count = 1;};
            class _xx_Toolkit {name = "Toolkit"; count = 1;};
        };
    };
};

class CfgLoadouts {  //-- QT allows for using #definitions within a string
    #define QT "

    #define ITEMS [selectRandom['tsp_sling','tsp_sling_1point','tsp_sling_3point'],1],[CAPS,1],['ACE_EarPlugs',1],['ACE_CableTie',8],['tsp_ifak',1],['ACRE_R168',1],['Chemlight_green',2,1],['ACE_Flashlight_KSF1',1],[[selectRandom['tsp_meleeWeapon_ak','tsp_meleeWeapon_sog','tsp_meleeWeapon_socp'],'','','',[],[],''],1]

    #define UNIFORMS selectRandom['rhs_uniform_g3_atacsau','rhs_uniform_g3_atacsauaor1','rhs_uniform_g3_atacsauaor2','rhs_uniform_g3_atacsaufg','rhs_uniform_g3_atacsaumc','rhs_uniform_g3_atacsaurgr','rhs_uniform_g3_atacsautan','rhs_uniform_g3_atacsfgaor1','rhs_uniform_g3_atacsfgaor2','rhs_uniform_g3_atacsfgau','rhs_uniform_g3_atacsfgmc','rhs_uniform_g3_atacsfgrgr','rhs_uniform_g3_atacsfgtan','rhs_uniform_g3_rgratacsau','rhs_uniform_g3_rgratacsfg','rhs_uniform_g3_tanatacsau','rhs_uniform_g3_tanatacsfg','rhs_uniform_g3_rgrtan','rhs_uniform_g3_tanrgr']
    #define CAPS selectRandom['rhs_beanie_black','rhs_beanie_green','H_Bandanna_khk','H_Bandanna_sgg','H_Bandanna_gry','H_Bandanna_sand','H_Bandanna_cbr','H_Booniehat_khk','H_Booniehat_tan','H_Booniehat_oli']

    #define VESTS_74 selectRandom['CPC_LBT','CPC_LBTcoy','CPC_LBTrgr','AK_LBT','AK_LBTcoy','AK_LBTrg']
    #define VESTS_74belt selectRandom['CPC_belt_LBT','CPC_belt_LBTcoy','CPC_belt_LBTrgr','AK_LBT_belt','AK_LBT_beltcoy','AK_LBT_beltrg','tactec','tactecFG','tactecAU']
    #define VESTS_545 selectRandom[VESTS_74belt,VESTS_74]
    #define VESTS_103 selectRandom['CPC_103','CPC_103coy','CPC_103rgr','AK_LBT762','AK_LBT762coy','AK_LBT762rg']
    #define VESTS_103belt selectRandom['tactec762','tactec762FG','tactec762AU','CPC_belt_762','CPC_belt_762coy','CPC_belt_762rgr','AK_LBT_belt762','AK_LBT_belt762coy','AK_LBT_belt762rg']
    #define VESTS_762 selectRandom[VESTS_103belt,VESTS_103]
    #define VESTS_PK selectRandom['tactecpkp','tactecpkpFG','tactecpkpAU','tactecfullpkp','tactecfullpkpFG','tactecfullpkpAU','CPC_PK','CPC_PKcoy','CPC_PKrgr','PK_LBT_belt','PK_LBT_beltcoy','PK_LBT_beltrg']
    #define VESTS_SVD selectRandom['tactecSVD','tactecSVDFG','tactecSVDAU','SVD_LBT','SVD_LBTcoy','SVD_LBTrg','SVD_LBT_belt','SVD_LBT_beltcoy','SVD_LBT_beltrg']
    #define VESTS_GP74 selectRandom['CPC_LBTgp','CPC_LBTgpcoy','CPC_LBTgprgr','AK_LBTgp','AK_LBTgpcoy','AK_LBTgprg']
    #define VESTS_GP74belt selectRandom['CPC_belt_LBTgp','CPC_belt_LBTgpcoy','CPC_belt_LBTgprgr','AK_LBT_beltgp','AK_LBT_beltgpcoy','AK_LBT_beltgprg','tactecgp','tactecgpFG','tactecgpAU']
    #define VESTS_GP545 selectRandom[VESTS_GP74belt,VESTS_GP74]
    #define VESTS_GP103 selectRandom['CPC_103gp','CPC_103gpcoy','CPC_103gprgr','AK_LBT762gp','AK_LBT762gpcoy','AK_LBT762gprg']
    #define VESTS_GP103belt selectRandom['CPC_belt_762gp','CPC_belt_762gpcoy','CPC_belt_762gprgr','AK_LBT_belt762gp','AK_LBT_belt762gpcoy','AK_LBT_belt762gprg','tactec762gp','tactec762gpFG','tactec762gpAU']
    #define VESTS_GP762 selectRandom[VESTS_GP103belt,VESTS_GP103]

    #define HEAD selectRandom['rhs_lshz','rhs_lshz_pelt','rhs_lshz_camo','rhs_lshz_camo_pelt','rhs_lshz_mc_cover','rhs_lshz_mc_cover_cam','rhs_lshz_mc_cover_pelt','rhs_lshz_mc_cover_pelt_cam','rhs_lshz_bk_mc_cover','rhs_lshz_bk_mc_cover_cam','rhs_lshz_bk_mc_cover_pelt','rhs_lshz_bk_mc_cover_pelt_cam']
    #define EYE selectRandom['','rhs_balaclava','rhs_balaclava_black','rhs_scarf','G_Shades_Black','G_Bandanna_khk','G_Bandanna_oli','G_Bandanna_shades','G_Bandanna_Skull2','G_Bandanna_beast','G_Bandanna_Skull1','G_Bandanna_Syndikat1','rhs_googles_clear','rhs_googles_black']
    #define NVG selectRandom['rhs_1PN138_hide','rhs_1PN138']

    #define OPTICS_SHORT selectRandom['rhs_acc_rakursPM','rhs_acc_1p87','Tier1_EXPS3_0_Black','Tier1_EXPS3_0_G33_Black_Down','Tier1_MicroT1_Leap_Black','Tier1_MicroT1_Low_Black','Tier1_MicroT2_Black','Tier1_MicroT2_G33_Black_Down','Tier1_MicroT2_Leap_Black','Tier1_MicroT2_Leap_G33_Black_Down','Tier1_MicroT2_Low_Black','Tier1_Eotech553_Black','rhsusf_acc_T1_high','rhsusf_acc_T1_low','rhsusf_acc_RM05','rhsusf_acc_mrds']
    #define OPTICS_LONG selectRandom['rhsusf_acc_su230a']

    #define MUZZLE_74 selectRandom['rhs_acc_dtk4short','rhs_acc_dtk','rhs_acc_dtk1','rhs_acc_dtk2','rhs_acc_dtk3','rhs_acc_uuk','rhs_acc_ak5']
    #define AK74 selectRandom['rhs_weap_ak105_zenitco01_npz','rhs_weap_ak74m_zenitco01_ak100_npz','rhs_weap_ak74m_zenitco01_npz','rhs_weap_ak105_zenitco01_b33','rhs_weap_ak74m_npz','rhs_weap_ak74m_zenitco01_b33','rhs_weap_ak74mr','rhs_weap_ak74m_camo_npz','rhs_weap_ak74m_desert_npz']
    #define AK74nos selectRandom['rhs_weap_ak74m_zenitco01_ak100','rhs_weap_ak74m_zenitco01','rhs_weap_ak74m','rhs_weap_ak105_zenitco01','rhs_weap_ak105','rhs_weap_ak74m_desert','rhs_weap_ak74m_camo']

    #define GP74 selectRandom['rhs_weap_ak74m_gp25_npz','rhs_weap_ak74mr_gp25']
    #define SVD selectRandom['rhs_weap_svdp','rhs_weap_svdp_wd','rhs_weap_svds']

    #define MUZZLE_103 selectRandom['rhs_acc_dtk','rhs_acc_dtk1','rhs_acc_dtk4long','rhs_acc_dtk2','rhs_acc_dtk3','rhs_acc_ak5']
    #define AK103 selectRandom['rhs_weap_ak104_zenitco01_npz','rhs_weap_ak103_zenitco01_pt1_npz','rhs_weap_ak103_npz','rhs_weap_ak103_zenitco01_b33','rhs_weap_ak104_zenitco01_b33']
    #define AK103nos selectRandom['rhs_weap_ak103_zenitco01_pt1','rhs_weap_ak103','rhs_weap_ak104','rhs_weap_ak104_zenitco01']

    tsp_sso_operator = QT[[AK74,MUZZLE_74,'',OPTICS_SHORT,['bas_30Rnd_545x39_PMAG_Black_7n10',30],[],''],[],['rhs_weap_pya','','','',['rhs_mag_9x19_17',17],[],''],[UNIFORMS,[ITEMS]],[VESTS_545,[['rhs_mag_rgd5',2,1],['rhs_mag_rdg2_white',2,1],[selectRandom['rhs_mag_plamyam','tsp_flashbang_fakels'],2,1],['bas_30Rnd_545x39_PMAG_Black_7n10',3,30],['bas_30Rnd_545x39_PMAG_FDE_7t3m',3,30],['rhs_30Rnd_545x39_7N22_AK',2,30],['rhs_mag_9x19_17',2,17]]],[],HEAD,EYE,[],['ItemMap','','','ItemCompass','ItemWatch',NVG]]QT;
    tsp_sso_operator_ak103 = QT[[AK103,MUZZLE_103,'',OPTICS_SHORT,['rhs_30Rnd_762x39mm_polymer',30],[],''],[],['rhs_weap_pya','','','',['rhs_mag_9x19_17',17],[],''],[UNIFORMS,[ITEMS]],[VESTS_762,[['rhs_mag_rgd5',2,1],['rhs_mag_rdg2_white',2,1],[selectRandom['rhs_mag_plamyam','tsp_flashbang_fakels'],2,1],['rhs_mag_9x19_17',2,17],['rhs_30Rnd_762x39mm_polymer',5,30],['rhs_30Rnd_762x39mm_polymer_tracer',3,30]]],[],HEAD,EYE,[],['ItemMap','','','ItemCompass','ItemWatch',NVG]]QT;
    tsp_sso_operator_asval = QT[['rhs_weap_asval_grip1','',selectRandom['rhs_acc_2dpZenit_ris','','rhs_acc_perst1ik_ris'],selectRandom['rhs_acc_pkas','rhs_acc_okp7_dovetail',''],['rhs_20rnd_9x39mm_SP6',20],[],'rhs_acc_grip_ffg2'],[],['rhs_weap_pya','','','',['rhs_mag_9x19_17',17],[],''],[UNIFORMS,[ITEMS]],[VESTS_762,[['rhs_mag_rgd5',2,1],['rhs_mag_rdg2_white',2,1],[selectRandom['rhs_mag_plamyam','tsp_flashbang_fakels'],2,1],['rhs_mag_9x19_17',2,17],['rhs_20rnd_9x39mm_SP6',9,20]]],[],HEAD,EYE,[],['ItemMap','','','ItemCompass','ItemWatch',NVG]]QT;
    tsp_sso_operator_RShG2 = QT[[AK74nos,MUZZLE_74,'','',['bas_30Rnd_545x39_PMAG_Black_7n10',30],[],''],['rhs_weap_rshg2','','','',['rhs_rshg2_mag',1],[],''],['rhs_weap_pya','','','',['rhs_mag_9x19_17',17],[],''],[UNIFORMS,[ITEMS]],[VESTS_545,[['rhs_mag_rgd5',2,1],['rhs_mag_rdg2_white',2,1],[selectRandom['rhs_mag_plamyam','tsp_flashbang_fakels'],2,1],['rhs_mag_9x19_17',2,17],['bas_30Rnd_545x39_PMAG_Black_7n10',3,30],['bas_30Rnd_545x39_PMAG_FDE_7t3m',3,30],['rhs_30Rnd_545x39_7N22_AK',2,30]]],[],HEAD,EYE,[],['ItemMap','','','ItemCompass','ItemWatch',NVG]]QT;
    tsp_sso_operator_lat = QT[[AK74nos,MUZZLE_74,'','',['bas_30Rnd_545x39_PMAG_Black_7n10',30],[],''],['rhs_weap_rpg26','','','',[],[],''],['rhs_weap_pya','','','',['rhs_mag_9x19_17',17],[],''],[UNIFORMS,[ITEMS]],[VESTS_545,[['rhs_mag_rgd5',2,1],['rhs_mag_rdg2_white',2,1],[selectRandom['rhs_mag_plamyam','tsp_flashbang_fakels'],2,1],['rhs_mag_9x19_17',2,17],['bas_30Rnd_545x39_PMAG_Black_7n10',3,30],['bas_30Rnd_545x39_PMAG_FDE_7t3m',3,30],['rhs_30Rnd_545x39_7N22_AK',2,30]]],[],HEAD,EYE,[],['ItemMap','','','ItemCompass','ItemWatch',NVG]]QT;
    tsp_sso_grenadier = QT[[GP74,MUZZLE_74,'',OPTICS_SHORT,['bas_30Rnd_545x39_PMAG_Black_7n10',30],['rhs_VOG25',1],''],[],['rhs_weap_pya','','','',['rhs_mag_9x19_17',17],[],''],[UNIFORMS,[ITEMS]],[VESTS_GP545,[['rhs_mag_rgd5',1,1],['rhs_mag_rdg2_white',1,1],[selectRandom['rhs_mag_plamyam','tsp_flashbang_fakels'],1,1],['rhs_mag_9x19_17',2,17],['bas_30Rnd_545x39_PMAG_Black_7n10',3,30],['bas_30Rnd_545x39_PMAG_FDE_7t3m',3,30],['rhs_30Rnd_545x39_7N22_AK',2,30],['rhs_VOG25',9,1],['rhs_GRD40_White',3,1],['rhs_VG40OP_red',3,1]]],[],HEAD,EYE,[],['ItemMap','','','ItemCompass','ItemWatch',NVG]]QT;
    tsp_sso_grenadier_alt = QT[['rhs_weap_ak103_gp25',MUZZLE_103,'','',['rhs_30Rnd_762x39mm_polymer',30],['rhs_VOG25',1],''],[],['rhs_weap_pya','','','',['rhs_mag_9x19_17',17],[],''],[UNIFORMS,[ITEMS]],[VESTS_GP762,[['rhs_mag_rgd5',1,1],['rhs_mag_rdg2_white',1,1],[selectRandom['rhs_mag_plamyam','tsp_flashbang_fakels'],1,1],['rhs_mag_9x19_17',2,17],['rhs_VOG25',10,1],['rhs_GRD40_White',3,1],['rhs_VG40OP_red',3,1],['rhs_30Rnd_762x39mm_polymer',4,30],['rhs_30Rnd_762x39mm_polymer_tracer',2,30]]],[],HEAD,EYE,[],['ItemMap','','','ItemCompass','ItemWatch',NVG]]QT;
    tsp_sso_grenadier_rpg = QT[[AK74nos,MUZZLE_74,'','',['bas_30Rnd_545x39_PMAG_Black_7n10',30],[],''],['rhs_weap_rpg7_pgo','','','',['rhs_rpg7_PG7VL_mag',1],[],''],['rhs_weap_pya','','','',['rhs_mag_9x19_17',17],[],''],[UNIFORMS,[ITEMS]],[VESTS_74,[['rhs_mag_rgd5',2,1],['rhs_mag_rdg2_white',2,1],[selectRandom['rhs_mag_plamyam','tsp_flashbang_fakels'],2,1],['rhs_mag_9x19_17',2,17],['bas_30Rnd_545x39_PMAG_Black_7n10',3,30],['bas_30Rnd_545x39_PMAG_FDE_7t3m',3,30]]],['rhs_rpg',[['rhs_rpg7_PG7VL_mag',1,1],['rhs_rpg7_OG7V_mag',1,1],['rhs_rpg7_TBG7V_mag',1,1]]],HEAD,EYE,[],['ItemMap','','','ItemCompass','ItemWatch',NVG]]QT;
    tsp_sso_strelok_rpg_assist = QT[[AK74,MUZZLE_74,'',OPTICS_SHORT,['bas_30Rnd_545x39_PMAG_Black_7n10',30],[],''],[],['rhs_weap_pya','','','',['rhs_mag_9x19_17',17],[],''],[UNIFORMS,[ITEMS]],[VESTS_545,[['rhs_mag_rgd5',2,1],['rhs_mag_rdg2_white',2,1],[selectRandom['rhs_mag_plamyam','tsp_flashbang_fakels'],2,1],['rhs_mag_9x19_17',2,17],['bas_30Rnd_545x39_PMAG_Black_7n10',3,30],['bas_30Rnd_545x39_PMAG_FDE_7t3m',3,30]]],['rhs_rpg',[]],HEAD,EYE,[],['ItemMap','','','ItemCompass','ItemWatch',NVG]]QT;
    tsp_sso_medic = QT[[AK103nos,MUZZLE_103,'','',['rhs_30Rnd_762x39mm_polymer',30],[],''],[],['rhs_weap_pya','','','',['rhs_mag_9x19_17',17],[],''],[UNIFORMS,[ITEMS]],[VESTS_762,[['rhs_mag_rgd5',2,1],['rhs_mag_rdg2_white',2,1],[selectRandom['rhs_mag_plamyam','tsp_flashbang_fakels'],2,1],['rhs_mag_9x19_17',2,17],['rhs_30Rnd_762x39mm_polymer_tracer',3,30],['rhs_30Rnd_762x39mm_polymer',5,30]]],['B_CivilianBackpack_01_Everyday_Black_F',[['Medikit',1],['ACE_elasticBandage',10],['ACE_salineIV_500',1]]],HEAD,EYE,[],['ItemMap','','','ItemCompass','ItemWatch',NVG]]QT;
    tsp_sso_arifleman_rpk = QT[['rhs_weap_rpk74m','rhs_acc_dtkrpk','','',['rhs_45Rnd_545X39_7N6M_AK',45],[],''],[],['rhs_weap_pya','','','',['rhs_mag_9x19_17',17],[],''],[UNIFORMS,[ITEMS]],[VESTS_545,[['rhs_mag_rgd5',2,1],['rhs_mag_rdg2_white',2,1],[selectRandom['rhs_mag_plamyam','tsp_flashbang_fakels'],2,1],['rhs_mag_9x19_17',2,17],['rhs_45Rnd_545X39_AK_Green',3,45],['rhs_45Rnd_545X39_7N6M_AK',3,45]]],[],HEAD,EYE,[],['ItemMap','','','ItemCompass','ItemWatch',NVG]]QT;
    tsp_sso_arifleman = QT[['rhs_weap_pkp','','','',['rhs_100Rnd_762x54mmR',100],[],''],[],['rhs_weap_pya','','','',['rhs_mag_9x19_17',17],[],''],[UNIFORMS,[['tsp_sling',1],[CAPS,1],['ACE_EarPlugs',1],['ACE_CableTie',8],['tsp_ifak',1],['ACRE_R168',1],['Chemlight_green',2,1],[[selectRandom['tsp_meleeWeapon_ak','tsp_meleeWeapon_sog','tsp_meleeWeapon_socp'],'','','',[],[],''],1]]],[VESTS_PK,[['rhs_mag_9x19_17',2,17],['rhs_100Rnd_762x54mmR_green',1,100],['rhs_100Rnd_762x54mmR',1,100],['rhs_mag_rgd5',2,1],['rhs_mag_rdg2_white',2,1]]],[],HEAD,EYE,[],['ItemMap','','','ItemCompass','ItemWatch',NVG]]QT;
    tsp_sso_machinegunner = QT[['rhs_weap_pkm','','','',['rhs_100Rnd_762x54mmR_7N26',100],[],''],[],['rhs_weap_pya','','','',['rhs_mag_9x19_17',17],[],''],[UNIFORMS,[['tsp_sling',1],[CAPS,1],['ACE_EarPlugs',1],['ACE_CableTie',8],['tsp_ifak',1],['ACRE_R168',1],['Chemlight_green',2,1],[[selectRandom['tsp_meleeWeapon_ak','tsp_meleeWeapon_sog','tsp_meleeWeapon_socp'],'','','',[],[],''],1]]],[VESTS_PK,[['rhs_mag_9x19_17',2,17],['rhs_100Rnd_762x54mmR_green',1,100],['rhs_100Rnd_762x54mmR_7N26',1,100],['rhs_mag_rgd5',2,1],['rhs_mag_rdg2_white',2,1]]],[],HEAD,EYE,[],['ItemMap','','','ItemCompass','ItemWatch',NVG]]QT;
    tsp_sso_machinegunner_assistant = QT[[AK74,MUZZLE_74,'',OPTICS_SHORT,['bas_30Rnd_545x39_PMAG_Black_7n10',30],[],''],[],['rhs_weap_pya','','','',['rhs_mag_9x19_17',17],[],''],[UNIFORMS,[ITEMS]],[VESTS_545,[['rhs_mag_rgd5',2,1],['rhs_mag_rdg2_white',2,1],[selectRandom['rhs_mag_plamyam','tsp_flashbang_fakels'],2,1],['rhs_mag_9x19_17',2,17],['bas_30Rnd_545x39_PMAG_Black_7n10',3,30],['bas_30Rnd_545x39_PMAG_FDE_7t3m',3,30],['rhs_30Rnd_545x39_7N22_AK',2,30]]],[selectRandom['rhs_rk_sht_30_emr','rhs_rk_sht_30_olive','rhs_assault_umbts'],[['rhs_100Rnd_762x54mmR_green',1,100],['rhs_100Rnd_762x54mmR_7N26',2,100]]],HEAD,EYE,[],['ItemMap','','','ItemCompass','ItemWatch',NVG]]QT;
    tsp_sso_teamlead = QT[[AK74,MUZZLE_74,'',selectRandom[OPTICS_SHORT,OPTICS_LONG],['bas_30Rnd_545x39_PMAG_Black_7n10',30],[],''],[],['Tier1_Glock22','','','',['Tier1_15Rnd_40SW_FMJ',15],[],''],[UNIFORMS,[ITEMS]],[VESTS_545,[['ACRE_R187',1],['ACE_MapTools',1],['rhs_mag_rgd5',2,1],['rhs_mag_rdg2_white',2,1],[selectRandom['rhs_mag_plamyam','tsp_flashbang_fakels'],2,1],['Tier1_15Rnd_40SW_FMJ',2,15],['bas_30Rnd_545x39_PMAG_Black_7n10',3,30],['bas_30Rnd_545x39_PMAG_FDE_7t3m',3,30],['rhs_30Rnd_545x39_7N22_AK',2,30],['rhs_mag_rdg2_black',2,1]]],[],HEAD,EYE,['rhssaf_zrak_rd7j','','','',[],[],''],['ItemMap','tsp_track24','','ItemCompass','ItemWatch',NVG]]QT;
    tsp_sso_officer = QT[[AK103nos,MUZZLE_103,'','',['rhs_30Rnd_762x39mm_polymer',30],[],''],[],['Tier1_Glock22','','','',['Tier1_15Rnd_40SW_FMJ',15],[],''],[UNIFORMS,[[selectRandom['tsp_sling','tsp_sling_1point','tsp_sling_3point'],1],['ACE_EarPlugs',1],['ACE_CableTie',8],['tsp_ifak',1],['ACRE_R168',1],['Chemlight_green',2,1],['acex_intelitems_notepad',1,1],[[selectRandom['tsp_meleeWeapon_ak','tsp_meleeWeapon_sog','tsp_meleeWeapon_socp'],'','','',[],[],''],1]]],['Warbelt_AK_2',[['ACE_MapTools',1],['ACRE_R187',1],['rhs_mag_rgd5',1,1],['rhs_mag_rdg2_white',1,1],[selectRandom['rhs_mag_plamyam','tsp_flashbang_fakels'],1,1],['rhs_30Rnd_762x39mm_bakelite_tracer',2,30],['rhs_30Rnd_762x39mm_polymer',3,30],['Tier1_15Rnd_40SW_FMJ',2,15]]],[],CAPS,'',['rhs_pdu4','','','',[],[],''],['ItemMap','tsp_track24','','ItemCompass','ItemWatch','']]QT;
    tsp_sso_officer_armored = QT[[AK103nos,MUZZLE_103,'','',['rhs_30Rnd_762x39mm_polymer',30],[],''],[],['Tier1_Glock22','','','',['Tier1_15Rnd_40SW_FMJ',15],[],''],[UNIFORMS,[[selectRandom['tsp_sling','tsp_sling_1point','tsp_sling_3point'],1],['ACE_EarPlugs',1],['ACE_CableTie',8],['tsp_ifak',1],['ACRE_R168',1],['Chemlight_green',2,1],['acex_intelitems_notepad',1,1],[[selectRandom['tsp_meleeWeapon_ak','tsp_meleeWeapon_sog','tsp_meleeWeapon_socp'],'','','',[],[],''],1]]],[VESTS_103,[['ACE_MapTools',1],['ACRE_R187',1],['rhs_mag_rgd5',1,1],['rhs_mag_rdg2_white',1,1],[selectRandom['rhs_mag_plamyam','tsp_flashbang_fakels'],1,1],['rhs_30Rnd_762x39mm_polymer',3,30],['Tier1_15Rnd_40SW_FMJ',2,15],['rhs_30Rnd_762x39mm_polymer_tracer',3,30]]],[],CAPS,'',['rhs_pdu4','','','',[],[],''],['ItemMap','tsp_track24','','ItemCompass','ItemWatch','']]QT;
    tsp_sso_sniper = QT[['rhs_weap_t5000','','','rhs_acc_dh520x56',['rhs_5Rnd_338lapua_t5000',5],[],'rhs_acc_harris_swivel'],[],['rhs_weap_pya','','','',['rhs_mag_9x19_17',17],[],''],[UNIFORMS,[ITEMS]],[VESTS_SVD,[['rhs_mag_rgd5',2,1],['rhs_mag_rdg2_white',2,1],[selectRandom['rhs_mag_plamyam','tsp_flashbang_fakels'],2,1],['rhs_mag_9x19_17',2,17],['rhs_5Rnd_338lapua_t5000',10,5]]],[],HEAD,EYE,['rhs_pdu4','','','',[],[],''],['ItemMap','','','ItemCompass','ItemWatch',NVG]]QT;
    tsp_sso_marksman = QT[[SVD,'','','rhs_acc_pso1m21_svd',['rhs_10Rnd_762x54mmR_7N1',10],[],''],[],['rhs_weap_pya','','','',['rhs_mag_9x19_17',17],[],''],[UNIFORMS,[ITEMS]],[VESTS_SVD,[['rhs_mag_rgd5',2,1],['rhs_mag_rdg2_white',2,1],[selectRandom['rhs_mag_plamyam','tsp_flashbang_fakels'],2,1],['rhs_mag_9x19_17',2,17],['rhs_10Rnd_762x54mmR_7N1',4,10],['rhs_10Rnd_762x54mmR_7N14',2,10]]],[],HEAD,EYE,['rhssaf_zrak_rd7j','','','',[],[],''],['ItemMap','','','ItemCompass','ItemWatch',NVG]]QT;
    tsp_sso_marksman_asval = QT[['rhs_weap_asval','','','rhs_acc_pso1m21',['rhs_20rnd_9x39mm_SP5',20],[],''],[],['rhs_weap_pya','','','',['rhs_mag_9x19_17',17],[],''],[UNIFORMS,[ITEMS]],[VESTS_SVD,[['rhs_mag_rgd5',2,1],['rhs_mag_rdg2_white',2,1],[selectRandom['rhs_mag_plamyam','tsp_flashbang_fakels'],2,1],['rhs_mag_9x19_17',2,17],['rhs_20rnd_9x39mm_SP5',7,20]]],[],HEAD,EYE,['rhssaf_zrak_rd7j','','','',[],[],''],['ItemMap','','','ItemCompass','ItemWatch',NVG]]QT;
    tsp_sso_marksman_vss = QT[['rhs_weap_vss','','','rhs_acc_pso1m21',['rhs_10rnd_9x39mm_SP5',10],[],''],[],['rhs_weap_pya','','','',['rhs_mag_9x19_17',17],[],''],[UNIFORMS,[ITEMS]],[VESTS_SVD,[['rhs_mag_rgd5',2,1],['rhs_mag_rdg2_white',2,1],[selectRandom['rhs_mag_plamyam','tsp_flashbang_fakels'],2,1],['rhs_mag_9x19_17',2,17],['rhs_10rnd_9x39mm_SP5',14,10]]],[],HEAD,EYE,['rhssaf_zrak_rd7j','','','',[],[],''],['ItemMap','','','ItemCompass','ItemWatch',NVG]]QT;
    tsp_sso_breacher = QT[[AK74,MUZZLE_74,'',OPTICS_SHORT,['bas_30Rnd_545x39_PMAG_Black_7n10',30],[],''],['tsp_meleeWeapon_sledge_red','','','',[],[],''],['rhs_weap_pya','','','',['rhs_mag_9x19_17',17],[],''],[UNIFORMS,[ITEMS]],[VESTS_545,[['rhs_mag_rgd5',2,1],['rhs_mag_rdg2_white',2,1],[selectRandom['rhs_mag_plamyam','tsp_flashbang_fakels'],2,1],['rhs_mag_9x19_17',2,17],['bas_30Rnd_545x39_PMAG_Black_7n10',3,30],['bas_30Rnd_545x39_PMAG_FDE_7t3m',3,30],['rhs_30Rnd_545x39_7N22_AK',2,30]]],[selectRandom['rhs_rk_sht_30_emr','rhs_rk_sht_30_olive','rhs_assault_umbts'],[['ACE_DefusalKit',1],['tsp_lockpick',1],['ACE_M26_Clacker',1],['ToolKit',1],['ACE_wirecutter',1],['rhs_ec200_mag',1,1],['tsp_breach_package_mag',2,1],['tsp_breach_stick_mag',5,1]]],HEAD,EYE,[],['ItemMap','','','ItemCompass','ItemWatch',NVG]]QT;
    tsp_sso_engineer = QT[[AK74,MUZZLE_74,'',OPTICS_SHORT,['bas_30Rnd_545x39_PMAG_Black_7n10',30],[],''],['tsp_meleeWeapon_halligan','','','',[],[],''],['rhs_weap_pya','','','',['rhs_mag_9x19_17',17],[],''],[UNIFORMS,[ITEMS]],[VESTS_545,[['rhs_mag_rgd5',2,1],['rhs_mag_rdg2_white',2,1],[selectRandom['rhs_mag_plamyam','tsp_flashbang_fakels'],2,1],['rhs_mag_9x19_17',2,17],['bas_30Rnd_545x39_PMAG_Black_7n10',3,30],['bas_30Rnd_545x39_PMAG_FDE_7t3m',3,30],['rhs_30Rnd_545x39_7N22_AK',2,30]]],[selectRandom['rhs_rk_sht_30_emr_engineer_empty','rhs_rk_sht_30_olive_engineer_empty','rhs_assault_umbts_engineer_empty'],[['ACE_DefusalKit',1],['tsp_meleeWeapon_mpl50',1],['ACE_Fortify',1],['tsp_lockpick',1],['ACE_M26_Clacker',1],['MineDetector',1],['ToolKit',1],['ACE_wirecutter',1],['rhs_mine_pmn2_mag',2,1],['rhs_ec200_mag',4,1]]],HEAD,EYE,[],['ItemMap','','','ItemCompass','ItemWatch',NVG]]QT;
    tsp_sso_at = QT[[AK74nos,MUZZLE_74,'','',['bas_30Rnd_545x39_PMAG_Black_7n10',30],[],''],['rhs_weap_rpg7_pgo','','','rhs_acc_pgo7v3',['rhs_rpg7_PG7VL_mag',1],[],''],['rhs_weap_pya','','','',['rhs_mag_9x19_17',17],[],''],[UNIFORMS,[ITEMS]],[VESTS_74,[['rhs_mag_rgd5',2,1],['rhs_mag_rdg2_white',2,1],[selectRandom['rhs_mag_plamyam','tsp_flashbang_fakels'],2,1],['rhs_mag_9x19_17',2,17],['bas_30Rnd_545x39_PMAG_Black_7n10',3,30],['bas_30Rnd_545x39_PMAG_FDE_7t3m',3,30]]],['rhs_rpg_at',[['rhs_rpg7_PG7VR_mag',2,1],['rhs_rpg7_PG7VL_mag',1,1]]],HEAD,EYE,[],['ItemMap','','','ItemCompass','ItemWatch',NVG]]QT;
};