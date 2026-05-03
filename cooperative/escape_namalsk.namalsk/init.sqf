z_towns = [
	"tsp_civilian_secretary","tsp_civilian_sportswoman","tsp_civilian_hooker","tsp_civilian_workwoman",
	"tsp_civilian_madam","tsp_civilian_valentina","tsp_civilian_mechanic","tsp_civilian_functionary",
	"tsp_civilian_citizen","tsp_civilian_worker","tsp_civilian_profiteer","tsp_civilian_woodlander",
	"tsp_civilian_villager","tsp_civilian_rocker","tsp_civilian_priest","tsp_civilian_policeman",
	"tsp_civilian_teacher"
];
z_rural = ["tsp_civilian_worker","tsp_civilian_woodlander","tsp_civilian_villager","tsp_civilian_workwoman","tsp_civilian_farmwife","tsp_civilian_housewife"];
z_industrial = [
	"RDS_Worker1",
	"RDS_Worker2",
	"RDS_Worker3",
	"RDS_Worker4",
	"RDS_Woodlander1",
	"RDS_Woodlander2",
	"RDS_Woodlander3",
	"RDS_Woodlander4",
	"RDS_Villager1",
	"RDS_Villager2",
	"RDS_Villager3",
	"RDS_Villager4",
	"tsp_civilian_workwoman1",
	"tsp_civilian_workwoman2",
	"tsp_civilian_workwoman3",
	"tsp_civilian_workwoman4",
	"tsp_civilian_workwoman5",
	"C_Man_ConstructionWorker_01_Black_F",
	"C_Man_ConstructionWorker_01_Blue_F",
	"C_Man_ConstructionWorker_01_Red_F"];
z_medical = ["tsp_civilian_doctor", "tsp_civilian_teacher"];
z_military = ["rhs_msv_rifleman"];
z_militaryB = ["rhs_msv_crew"];
z_militaryO = ["rhs_msv_efreitor"];
z_chemical = ["rhs_msv_engineer"];
z_max_low = 1; z_max_medium = 2; z_max_high = 3;
z_time_low = 60; z_time_medium = 20; z_time_high = 10;
[
	player, z_towns, [
		z_zone_town_1, z_zone_medical_1,
		z_zone_rural_1, z_zone_rural_2, z_zone_rural_3, z_zone_rural_4, z_zone_rural_5, z_zone_rural_6, z_zone_rural_7, z_zone_rural_8, z_zone_rural_9, z_zone_rural_10, z_zone_rural_11, z_zone_rural_12, 
		z_zone_industrial_1, z_zone_industrial_2, z_zone_industrial_3, z_zone_industrial_4, z_zone_industrial_5, z_zone_industrial_6, z_zone_industrial_7, z_zone_industrial_8, z_zone_industrial_9, z_zone_industrial_10, z_zone_industrial_11, z_zone_industrial_12,
		z_zone_military_1, z_zone_military_2, z_zone_military_3, z_zone_military_4, z_zone_military_5, z_zone_military_6, z_zone_military_7, z_zone_military_8, z_zone_military_9, z_zone_military_10, z_zone_military_11, z_zone_military_12, z_zone_military_13, z_zone_military_14, z_zone_military_15, z_zone_military_16, z_zone_military_17
	], east,{true}, {
		if (typeOf _this == "rhs_msv_rifleman") then {_this setUnitLoadout (selectRandom [  //-- Soldiers
			[["rhs_weap_ak74","rhs_acc_dtk1983","","",["rhs_30Rnd_545x39_7N6M_AK",30],[],""],[],[],["rhs_uniform_afghanka_winter_boots_vsr_2",[["FirstAidKit",1],["ACE_EarPlugs",1],[["tsp_meleeWeapon_ak","","","",[],[],""],1]]],["rhs_chicom",[["rhs_30Rnd_545x39_7N6M_AK",3,30],["rhs_mag_rgd5",2,1],["rhs_mag_rdg2_white",2,1]]],[],"rhs_ssh68_2","",[],["","","ItemRadioAcreFlagged","ItemCompass","ItemWatch",""]],
			[["rhs_weap_ak74","rhs_acc_dtk1983","","",["rhs_30Rnd_545x39_7N6M_AK",30],[],""],[],[],["rhs_uniform_afghanka_winter_vsr_2",[["FirstAidKit",1],["ACE_EarPlugs",1],[["tsp_meleeWeapon_ak","","","",[],[],""],1]]],["rhs_6b5",[["rhs_30Rnd_545x39_7N6M_AK",3,30],["rhs_mag_rgd5",2,1],["rhs_mag_rdg2_white",2,1]]],[],"rhs_ssh68_2","",[],["","","ItemRadioAcreFlagged","ItemCompass","ItemWatch",""]],
			[["rhs_weap_ak74","rhs_acc_dtk1983","","",["rhs_30Rnd_545x39_7N6M_AK",30],[],""],[],[],["rhs_uniform_afghanka_para_vsr_2",[["FirstAidKit",1],["ACE_EarPlugs",1],[["tsp_meleeWeapon_ak","","","",[],[],""],1]]],["rhs_chicom",[["rhs_30Rnd_545x39_7N6M_AK",3,30],["rhs_mag_rgd5",2,1],["rhs_mag_rdg2_white",2,1]]],[],"rhs_ssh68_2","",[],["","","ItemRadioAcreFlagged","ItemCompass","ItemWatch",""]],
			[["rhs_weap_ak74","rhs_acc_dtk1983","","",["rhs_30Rnd_545x39_7N6M_AK",30],[],""],[],[],["rhs_uniform_afghanka_para_vsr_2",[["FirstAidKit",1],["ACE_EarPlugs",1],[["tsp_meleeWeapon_ak","","","",[],[],""],1]]],["rhs_6b5",[["rhs_30Rnd_545x39_7N6M_AK",3,30],["rhs_mag_rgd5",2,1],["rhs_mag_rdg2_white",2,1]]],[],"rhs_ssh68_2","",[],["","","ItemRadioAcreFlagged","ItemCompass","ItemWatch",""]],
			[["rhs_weap_ak74","rhs_acc_dtk1983","","",["rhs_30Rnd_545x39_7N6M_AK",30],[],""],[],[],["rhs_uniform_afghanka_winter_boots_vsr_2",[["FirstAidKit",1],["ACE_EarPlugs",1],[["tsp_meleeWeapon_ak","","","",[],[],""],1]]],["rhs_chicom",[["rhs_30Rnd_545x39_7N6M_AK",3,30],["rhs_mag_rgd5",2,1],["rhs_mag_rdg2_white",2,1]]],[],"rhs_fieldcap_vsr","",[],["","","ItemRadioAcreFlagged","ItemCompass","ItemWatch",""]],
			[["rhs_weap_ak74","rhs_acc_dtk1983","","",["rhs_30Rnd_545x39_7N6M_AK",30],[],""],[],[],["rhs_uniform_afghanka_winter_boots_vsr_2",[["FirstAidKit",1],["ACE_EarPlugs",1],[["tsp_meleeWeapon_ak","","","",[],[],""],1]]],["rhs_chicom",[["rhs_30Rnd_545x39_7N6M_AK",3,30],["rhs_mag_rgd5",2,1],["rhs_mag_rdg2_white",2,1]]],[],"rhs_fieldcap_vsr","",[],["","","ItemRadioAcreFlagged","ItemCompass","ItemWatch",""]],
			[["rhs_weap_ak74","rhs_acc_dtk1983","","",["rhs_30Rnd_545x39_7N6M_AK",30],[],""],[],[],["rhs_uniform_afghanka_winter_boots_vsr_2",[["FirstAidKit",1],["ACE_EarPlugs",1],[["tsp_meleeWeapon_ak","","","",[],[],""],1]]],["rhs_chicom",[["rhs_30Rnd_545x39_7N6M_AK",3,30],["rhs_mag_rgd5",2,1],["rhs_mag_rdg2_white",2,1]]],[],"rhs_beanie_green","",[],["","","ItemRadioAcreFlagged","ItemCompass","ItemWatch",""]],
			[["rhs_weap_aks74","rhs_acc_dtk1983","","",["rhs_30Rnd_545x39_7N6M_AK",30],[],""],[],[],["rhs_uniform_afghanka_winter_vsr_2",[["FirstAidKit",1],["ACE_EarPlugs",1],[["tsp_meleeWeapon_ak","","","",[],[],""],1]]],["rhs_chicom_khk",[["rhs_mag_rgd5",2,1],["rhs_mag_rdg2_white",2,1],["rhs_30Rnd_545x39_7N6M_AK",3,30]]],[],"rhs_ushanka","",["Binocular","","","",[],[],""],["ItemMap","","ItemRadioAcreFlagged","ItemCompass","ItemWatch",""]],	
			[["rhs_weap_aks74","rhs_acc_dtk1983","","",["rhs_30Rnd_545x39_7N6M_AK",30],[],""],[],[],["rhs_uniform_afghanka_winter_vsr_2",[["FirstAidKit",1],["ACE_EarPlugs",1],[["tsp_meleeWeapon_ak","","","",[],[],""],1]]],["rhs_chicom_khk",[["rhs_mag_rgd5",2,1],["rhs_mag_rdg2_white",2,1],["rhs_30Rnd_545x39_7N6M_AK",3,30]]],[],"rhs_ushanka","",["Binocular","","","",[],[],""],["ItemMap","","ItemRadioAcreFlagged","ItemCompass","ItemWatch",""]],
			[["rhs_weap_ak74_gp25","rhs_acc_dtk1983","","",["rhs_30Rnd_545x39_7N6M_AK",30],[],""],[],[],["rhs_uniform_afghanka_winter_boots_vsr_2",[["FirstAidKit",1],["ACE_EarPlugs",1],[["tsp_meleeWeapon_ak","","","",[],[],""],1]]],["rhs_6b5",[["rhs_mag_rgd5",2,1],["rhs_mag_rdg2_white",2,1],["rhs_VOG25",4,1],["rhs_30Rnd_545x39_7N6M_AK",2,30],["rhs_45Rnd_545X39_AK_Green",1,45]]],[],"rhs_ssh68_2","",[],["","","ItemRadioAcreFlagged","ItemCompass","ItemWatch",""]],
			[["rhs_weap_aks74u","rhs_acc_dtk1983","","",["rhs_30Rnd_545x39_7N6M_AK",30],[],""],[],[],["rhs_uniform_afghanka_winter_vsr_2",[["FirstAidKit",1],["ACE_EarPlugs",1],[["tsp_meleeWeapon_ak","","","",[],[],""],1]]],["rhs_chicom",[["rhs_mag_rgd5",2,1],["rhs_mag_rdg2_white",2,1],["rhs_30Rnd_545x39_7N6M_AK",2,30]]],[],"rhs_tsh4","",[],["","","ItemRadioAcreFlagged","ItemCompass","ItemWatch",""]],
			[["rhs_weap_ak74","rhs_acc_dtk1983","","",["rhs_30Rnd_545x39_7N6M_AK",30],[],""],[],[],["rhs_uniform_afghanka_winter_vsr_2",[["FirstAidKit",1],["ACE_EarPlugs",1],[["tsp_meleeWeapon_ak","","","",[],[],""],1]]],["rhs_chicom",[["rhs_30Rnd_545x39_7N6M_AK",2,30],["rhs_mag_rgd5",2,1],["rhs_mag_rdg2_white",2,1]]],["rhs_rd54_flora1",[["Medikit",1],["dev_enzymeCapsule",2]]],"rhs_ssh68_2","",[],["","","ItemRadioAcreFlagged","ItemCompass","ItemWatch",""]]
		])};
		if (typeOf _this == "rhs_msv_crew") then {_this setUnitLoadout (selectRandom [  //-- Pilots and Officers
			[[],[],[],["rhs_uniform_afghanka",[["FirstAidKit",1],["ACE_EarPlugs",1],[["tsp_meleeWeapon_ak","","","",[],[],""],1]]],["rhs_vest_pistol_holster",[[["rhs_weap_makarov_pm","","","",[],[],""],1]]],[],"rhs_pilotka","",[],["ItemMap","","ItemRadioAcreFlagged","ItemCompass","ItemWatch",""]],
			[[],[],[],["rhs_uniform_df15",[["FirstAidKit",1],["ACE_EarPlugs",1],[["tsp_meleeWeapon_ak","","","",[],[],""],1]]],["rhs_vest_pistol_holster",[[["rhs_weap_makarov_pm","","","",[],[],""],1]]],[],"rhs_zsh7a_mike","",[],["ItemMap","","ItemRadioAcreFlagged","ItemCompass","ItemWatch",""]],
			[[],[],[],["rhs_uniform_afghanka_winter_vsr_2",[["FirstAidKit",1],["ACE_EarPlugs",1],[["tsp_meleeWeapon_ak","","","",[],[],""],1]]],["rhs_gear_OFF",[["rhs_mag_9x18_8_57N181S",1,8],[["rhs_weap_makarov_pm","","","",[],[],""],1]]],[],"rhs_cossack_visor_cap_tan","",["Binocular","","","",[],[],""],["ItemMap","","ItemRadioAcreFlagged","ItemCompass","ItemWatch",""]]
		])};
		if (typeOf _this == "rhs_msv_efreitor") then {_this setUnitLoadout (selectRandom [  //-- Police
			[["rhs_weap_ak74m","rhs_acc_dtk1983","","",["rhs_30Rnd_545x39_7N10_AK",30],[],""],[],[],["rhs_uniform_omon",[["FirstAidKit",1],["ACE_EarPlugs",1],[["tsp_meleeWeapon_ak","","","",[],[],""],1]]],["rhs_belt_sks",[["rhs_30Rnd_545x39_7N10_AK",2,30]]],[],"rhs_omon_cap","",[],["","","ItemRadioAcreFlagged","ItemCompass","ItemWatch",""]]
		])};
		if (typeOf _this == "rhs_msv_engineer") then {_this setUnitLoadout (selectRandom [  //-- Chemical
			[[],[],[],["U_C_CBRN_Suit_01_Blue_F",[["dev_enzymeCapsule_refined",1]]],[],[],"","gm_gc_army_facewear_schm41m",[],["","","ItemRadioAcreFlagged","","",""]],
			[[],[],[],["U_C_CBRN_Suit_01_White_F",[["dev_enzymeCapsule_refined",1]]],[],[],"","gm_gc_army_facewear_schm41m",[],["","","ItemRadioAcreFlagged","","",""]],
			[[],[],[],["U_C_CBRN_Suit_01_Blue_F",[["dev_enzymeCapsule_refined",1]]],[],[],"","",[],["","","ItemRadioAcreFlagged","","",""]],
			[[],[],[],["U_C_CBRN_Suit_01_White_F",[["dev_enzymeCapsule_refined",1]]],[],[],"","",[],["","","ItemRadioAcreFlagged","","",""]]
		])};
		_this removeWeapon (primaryWeapon _this);
		_this removeWeapon (handgunWeapon _this);
		_this removeWeapon (secondaryWeapon _this);
		[_this] remoteExec ["dev_fnc_zombie_init", _this];
	}, 50, 2, 60, 120
] spawn tsp_fnc_zombience;

[] execVM "lootsystem\init.sqf";

tsp_fnc_startAnim = {
	params ["_unit", "_in", "_inTime", "_loop", "_outTime", "_out", "_weapon"];
	if (!local _unit && player != _unit) exitWith {}; waitUntil {!isNil "tsp_missionStarted"}; _unit selectWeapon _weapon;
	[_unit, _in] remoteExec ["switchMove", 0]; [_unit, _in] remoteExec ["playMove", 0];	sleep _inTime;
	[_unit, _loop] remoteExec ["switchMove", 0]; [_unit, _loop] remoteExec ["playMove", 0];	sleep _outTime;
	[_unit, _out] remoteExec ["switchMove", 0]; [_unit, _out] remoteExec ["playMove", 0];
};

waitUntil {!isNull player};
cutText ["...", "BLACK OUT", 0.000001];	
if (time < 30 && side player == east) then {
	cutText ["You are a member of an elite Spetsnaz team, sent in to locate sensitive documents.", "BLACK OUT", 0.001]; sleep 7;
	cutText ["These documents are likely located at Object A1 and A2.", "BLACK OUT", 0.001]; sleep 7;
	cutText ["Additionally, you are to eliminate any other life form, be it friendly, enemy or civilian. No witnesses.", "BLACK OUT", 0.001]; sleep 7;
};
if (time < 30 && side player == west) then {
	cutText ["You are a member of an elite SEAL team, sent in to investigate a secret Russian island.", "BLACK OUT", 0.001]; sleep 7;
	cutText ["You are to locate sensitive documents located at Object A1 and A2.", "BLACK OUT", 0.001]; sleep 7;
	cutText ["Additionally, you are to eliminate any other life form, be it enemy or civilian. No witnesses.", "BLACK OUT", 0.001]; sleep 7;
};
if (time < 30 && side player == civilian) then {
	cutText ["Your plane crashed on a flight to a concert in Ukraine.", "BLACK OUT", 0.001]; sleep 7;
	cutText ["You should have went down in Black Sea, but you have crash landed on an island that is not located on any maps.", "BLACK OUT", 0.001]; sleep 7;
	cutText ["You must do whatever you can to survive.", "BLACK OUT", 0.001]; sleep 7;
};		
tsp_missionStarted = true; cutText ["", "BLACK IN", 6];	
sleep 6; ["Unknown Island", "Black Sea", str(date#0)] spawn BIS_fnc_infoText;