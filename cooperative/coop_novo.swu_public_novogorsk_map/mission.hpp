author = "TheSpeshalPlatoon"; 
onLoadName = "Novo";	
loadScreen = __EVAL(selectRandom["data\overview.jpg"]); 
class Header {gameType = COOP}; 

tsp_param_spectate = "Dynamic";    //-- "Disabled", "Dynamic", "Forced"
tsp_param_joinTime = 60;          //-- Users that join after this many seconds, will be put into spectate if set to "Forced"
tsp_param_map = "true";          //-- Show spawn map at all
tsp_param_mapStart = "false";   //-- Show spawn screen on initial spawn
tsp_param_mapScale = 0.4;      //-- Map scale
tsp_param_loadout = "Retained"; //-- Retain loadouts
tsp_param_gear = "false";    //-- Gear checking
tsp_param_dispersion = 10;  //-- AI weapon dispersion
tsp_param_skill[] = {1,1,1,1,1,1,1,1,1};

class Params {
    #define TIMEACCELERATION_DEFAULT 1
    #include "\a3\Functions_F_MP_Mark\Params\paramTimeAcceleration.hpp"
    #define GUERFRIENDLY_DEFAULT -1
	#include "\a3\functions_f\Params\paramGuerFriendly.hpp"
};

respawnButton = 1;
forceRotorLibSimulation = 0;
disabledAI = 1;
briefing = 1;

minPlayerDistance = 300;  //-- Garbage collector despawn distance

corpseManagerMode = 1;
corpseLimit = 20;
corpseRemovalMinTime = 60; 
corpseRemovalMaxTime = 120;

wreckManagerMode = 2;
wreckLimit = 10;
wreckRemovalMinTime = 300; 
wreckRemovalMaxTime = 600;
 
reviveMode = 0;
reviveUnconsciousStateMode = 1;
reviveRequiredTrait = 0;
reviveRequiredItems = 0;
reviveRequiredItemsFakConsumed = 1;
reviveMedicSpeedMultiplier = 2;
reviveDelay = 10;
reviveForceRespawnDelay = 5;
reviveBleedOutDelay = 240;

class CfgMusic {class balalaika {name = "balalaika"; sound[] = { "\data\balalaika.ogg", db+20, 1.0};};};

class CfgORBAT {
    class cdf {
        id = 1; idType = 0; side = "West"; 
		text = "Chernarus Defence Forces"; textShort = "Chernarus Defence Forces"; type = "Infantry"; size = "Squad"; commander = "Begunov"; commanderRank = "General";  
        description = "The CDF are the primary land, sea, and air defence force of Chernarus. Though they lack the advanced equipment of modern Western armies, they retain a significant stockpile of hardware from their days as a former Soviet territory.";
        subordinates[] = {"cdf_ground","cdf_navy","cdf_air"}; 
        assets[] = {}; 
    };
			class cdf_ground: cdf {
				text = "Ground Forces"; textShort = "Ground Forces"; type = "Infantry"; size = "Brigade"; commander = "Andrey Zykov"; commanderRank = "Major"; 
				description = "The CDF's main conventional combat unit.";
				subordinates[] = {"21inf","22inf","23inf","31mot","32mot","2armor","1defence","1artillery","1service","52air"}; assets[] = {};  
			};
					class 21inf: cdf {
						text = "21st Infantry Battalion"; textShort = "21inf Infantry"; type = "Infantry"; size = "Battalion"; commander = "German Kamenev"; commanderRank = "Captain";         
						description = "Stationed at Vybor airfield, this is the premiere infantry battalion of the CDF.";
						subordinates[] = {}; assets[] = {{"rhsgref_cdf_reg_uaz",10},{"rhsgref_cdf_ural",40}};  
					};
					class 22inf: cdf {
						text = "22nd Infantry Battalion"; textShort = "22inf Infantry"; type = "Infantry"; size = "Battalion"; commander = "Grigoriy Khrushchev"; commanderRank = "Captain";         
						description = "infantry battalion of career soldiers.";
						subordinates[] = {}; assets[] = {{"rhsgref_cdf_reg_uaz",10},{"rhsgref_cdf_b_gaz66",40}};  
					};
					class 23inf: cdf {
						text = "22nd Infantry Battalion (Reserves)"; textShort = "22nd Infantry"; type = "Infantry"; size = "Battalion"; commander = "Sergei Yagudin"; commanderRank = "Captain";         
						description = "Stationed all over Chernarus, made up of civilians conducting their mandatory service.";
						subordinates[] = {}; assets[] = {{"rhsgref_cdf_reg_uaz",10},{"rhsgref_cdf_b_gaz66",40}};
					};
					class 31mot: cdf {
						text = "31st Motor Battalion"; textShort = "31st Motor"; type = "MotorizedInfantry"; size = "Battalion"; commander = "German Gusakov"; commanderRank = "Captain";         
						description = "Stationed in southern Chernarus, made up of well trained soldiers and light-armoured units.";
						subordinates[] = {}; assets[] = {{"rhsgref_cdf_b_btr70",10},{"rhsgref_cdf_b_btr60",20},{"UK3CB_B_MTLB_PKT_cdf",20}};  
					};
					class 32mot: cdf {
						text = "32nd Motor Battalion"; textShort = "32nd Motor"; type = "MotorizedInfantry"; size = "Battalion"; commander = "Anatoli Zhukov"; commanderRank = "Captain";         
						description = "Stationed in westen Chernarus, made up of well trained soldiers and light-armoured units.";
						subordinates[] = {}; assets[] = {{"rhsgref_cdf_b_btr70",10},{"rhsgref_cdf_b_btr60",20},{"UK3CB_B_MTLB_PKT_cdf",20}};  
					};
					class 2armor: cdf {
						text = "2nd Armor Battalion"; textShort = "2nd Armor"; type = "Armored"; size = "Battalion"; commander = "Leonid Zverev"; commanderRank = "Major"; 
						description = "The CDF's armored force, consists of heavy armoured vehicles including T-80s, T-72s, T-55s and BMPs.";
						subordinates[] = {}; assets[] = {{"rhsgref_cdf_b_t80b_tv",20},{"rhsgref_cdf_b_t72ba_tv",25},{"UK3CB_O_T55_CHK",20},{"rhsgref_cdf_b_bmp2d",40}};  
					};
					class 1defence: cdf {
						text = "1st Air Defence Company"; textShort = "1st Defence"; type = "Mortar"; size = "Company"; commander = "Ilya Soloveychik"; commanderRank = "Captain"; 
						description = "The CDF's air defence units, consists of ZSUs and radar units.";
						subordinates[] = {}; assets[] = {{"rhsgref_cdf_b_gaz66_r142",10},{"rhsgref_cdf_b_zsu234",10},{"UK3CB_B_MTLB_ZU23_cdf",10},{"rhsgref_cdf_reg_uaz",10}};  
					};
					class 1artillery: cdf {
						text = "1st Artilery Company"; textShort = "1st Artilery"; type = "Artillery"; size = "Company"; commander = "Ilya Shcherbakov"; commanderRank = "Captain"; 
						description = "The CDF's artillery units, consists of BM-21s and howitzers.";
						subordinates[] = {}; assets[] = {{"RHS_BM21_cdf",20},{"rhsgref_cdf_b_reg_d30",20},{"rhsgref_cdf_b_2s1_at",10},{"rhsgref_cdf_b_gaz66",10},{"rhsgref_cdf_reg_uaz",10}};  
					};
					class 1service: cdf {
						text = "1st Service Company"; textShort = "1st Service"; type = "Service"; size = "Company"; commander = "German Shcherbakov"; commanderRank = "Captain"; 
						description = "The backbone of the CDF. Contains engineering units and general logistics. Stationed in the north of Sahrani and on Porto";
						subordinates[] = {}; assets[] = {{"rhsgref_BRDM2_b",10},{"rhsgref_cdf_ural",20},{"UK3CB_B_MTLB_PKT_cdf",20},{"rhsgref_cdf_reg_uaz",10}};  
					};
					class 52air: cdf {
						text = "52nd Airborne Battalion"; textShort = "52nd Airborne"; type = "CombatAviation"; size = "Battalion"; commander = "Anatoli Potapenko"; commanderRank = "Captain";         
						description = "Stationed in southern Chernarus, made up of well trained soldiers, considered to be special forces.";
						subordinates[] = {}; assets[] = {{"rhsgref_BRDM2_b",20},{"UK3CB_B_LandRover_Closed_CDF",20},{"rhsgref_cdf_b_gaz66",20}};  
					};
			class cdf_navy: cdf {
				text = "Navy"; textShort = "Navy"; type = "Maritime"; size = "Battalion"; commander = "Igor Dobryakov"; commanderRank = "Major";         
				description = "Stationed on southern coast, the CDF navy is very small and mainly operates in the Black Sea.";
				subordinates[] = {"1mar","2guard"}; assets[] = {};  
			};
					class 1mar: cdf {
						text = "1st Maritime Company"; textShort = "1st Maritime"; type = "Infantry"; size = "Company"; commander = "Vyacheslav Yagudin"; commanderRank = "Captain";         
						description = "Sailors of the CDF navy.";
						subordinates[] = {};
						assets[] = {{"CUP_Type072_Main",5},{"I_C_Boat_Transport_02_F",6}};  
					};
					class 2guard: cdf {
						text = "2nd Guard Company"; textShort = "2nd Guard"; type = "Infantry"; size = "Company"; commander = "Nikolay Pushkin"; commanderRank = "Captain";         
						description = "Infantry units of the CDF navy, designated to guarding navy installations and conducting logistics operations.";
						subordinates[] = {}; assets[] = {{"UK3CB_I_MTLB_PKT_CDF",10},{"rhsgref_BRDM2",10},{"rhsgref_cdf_reg_uaz",10},{"UK3CB_I_G_V3S_Open",20}};  
					};
			class cdf_air: cdf {
				text = "Air Force"; textShort = "Air Force"; type = "AviationSupport"; size = "Company"; commander = "Mikhail Sudakov"; commanderRank = "Major";         
				description = "The CDF airforce consists of many older planes and helicopters but is relatively large and spread out across multiple airfields.";
				subordinates[] = {"1rot","2rot","1fix"}; assets[] = {{"RHS_Mi8MT_cdf",4},{"RHS_Mi8MTV3_cdf",2},{"rhsgref_cdf_b_mig29s",10},{"rhsgref_cdf_su25",10},{"UK3CB_I_Mig21_CDF_AT1",10},{"RHS_AN2_B",5}};  
			};
					class 1rot: cdf {
						text = "1st Rotor Wing"; textShort = "1st Rotor"; type = "Helicopter"; size = "Squadron"; commander = "Ilya Naryshkin"; commanderRank = "Captain";         
						description = "Helicoper units of the CDF Air Force, consists of transport and logistics helicopters.";
						subordinates[] = {}; assets[] = {{"rhsgref_cdf_b_reg_Mi8amt",15}};  
					};
					class 2rot: cdf {
						text = "1nd Rotor Wing"; textShort = "2nd Rotor"; type = "Helicopter"; size = "Squadron"; commander = "Mikhail Smirnov"; commanderRank = "Captain";         
						description = "Helicoper units of the CDF Air Force, consists of ground support helicopters. Armed Mi-8s and Mi-24s";
						subordinates[] = {}; assets[] = {{"rhsgref_cdf_b_reg_Mi17Sh",10},{"rhsgref_cdf_b_Mi24D",10}};  
					};
					class 1fix: cdf {
						text = "1st Fixed Wing"; textShort = "1st Fixed"; type = "Fighter"; size = "Squadron"; commander = "Anatoli Soloveychik"; commanderRank = "Captain";         
						description = "Fixed wing units of the CDF Air Force, consists of SU-25s and Mig-21's.";
						subordinates[] = {}; assets[] = {{"rhsgref_cdf_b_mig29s",10},{"rhsgref_cdf_su25",10},{"UK3CB_I_Mig21_CDF_AT1",10},{"RHS_AN2_B",5}};  
					};

};

