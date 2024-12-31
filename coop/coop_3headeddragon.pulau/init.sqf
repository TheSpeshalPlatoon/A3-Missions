tsp_fnc_intel_submit = {  //-- When submitting intel at base, remove items and call update
	params ["_unit", ["_intel", 0], ["_money", 0]];
	{if (_x in ["Files", "FlashDisk"]) then {_unit removeMagazine _x; _intel = _intel + 2}} forEach (magazines _unit);
	{if (_x in ["FileTopSecret", "MobilePhone"]) then {_unit removeMagazine _x; _intel = _intel + 4}} forEach (magazines _unit);
	{if (_x in ["Money", "Money_bunch", "Money_roll", "Money_stack"]) then {_unit removeMagazine _x; _money = _money + 4}} forEach (magazines _unit);
	if (_intel == 0 && _money == 0) exitWith {["Laptop", "You have no intel or money to submit."] spawn BIS_fnc_showSubtitle};
	[_intel, _money] call tsp_fnc_intel_update;
};

tsp_fnc_intel_update = {  //-- Update global intel and money variables, show notification
	params [["_intel", 0], ["_money", 0]];
	if (_intel > 0) then {tsp_totalIntel = tsp_totalIntel + _intel; publicVariable "tsp_totalIntel"; ["AddIntel", [tsp_totalIntel, _intel]] remoteExec ["BIS_fnc_showNotification", 0]};
	if (_money > 0) then {tsp_totalMoney = tsp_totalMoney + _money; publicVariable "tsp_totalMoney"; ["AddMoney", [tsp_totalMoney, _money]] remoteExec ["BIS_fnc_showNotification", 0]};
	[true] remoteExec ["tsp_fnc_upgrade", 0];
};

tsp_fnc_upgrade = {  //-- Add items to arsenal (call on submitting money or when opening arsenal)
	params [["_nofitication", false], ["_money", tsp_totalMoney]];	if (isNil "tsp_unlocked") then {tsp_unlocked = []};
	{
		_x params ["_moneyRequired", "_text", "_items"];
		if (_money < _moneyRequired || (_items#0) in tsp_unlocked) then {continue};
		if (_nofitication) then {["ItemUnlocked", [_text]] call BIS_fnc_showNotification};
		tsp_unlocked append _items;
	} forEach [
		[10, "Suppressors", ["rhs_acc_tgpa", "rhsusf_acc_aac_762sdn6_silencer", "rhsgref_sdn6_suppressor", "rhs_acc_pbs1", "rhsusf_acc_nt4_black", "Tier1_AAC_M42000_Black"]], 
		[20, "FAL Optics", ["rhsgref_acc_l1a1_l2a2", "rhsgref_acc_l1a1_anpvs2"]], 
		[30, "Ballistic Helmet", ["rhsusf_ach_bare","rhsgref_helmet_pasgt_erdl_rhino"]], 
		[40, "Tactical Helmets", ["tsp_gear_fast_pj_black","tsp_gear_fast_pj_green"]], 
		[50, "GPS", ["ItemGPS"]], 
		[60, "Night Vision", ["rhsusf_anvis_nvg_bc_caps","rhsusf_ANPVS_14", "rhsusf_Rhino"]]
	];	
	tsp_arsenal = tsp_arsenal + tsp_unlocked;	
};

tsp_fnc_talk = {
	params ["_unit", ["_chance", tsp_chanceTalk]];
	if (side _unit == west) exitWith {[name _unit, selectRandom ["Hey man", "Whats up"]] spawn BIS_fnc_showSubtitle};	
	if (_unit getVariable ["talked", "first"] == "first" && random 1 > _chance) exitWith {[name _unit, "Here you go"] spawn BIS_fnc_showSubtitle; _unit setVariable ["talked", "intel", true]; [2] call tsp_fnc_intel_update};
	if (_unit getVariable ["talked", "first"] == "intel") exitWith {[name _unit, "Thats all I know"] spawn BIS_fnc_showSubtitle};
	[name _unit, "I don't know anything"] spawn BIS_fnc_showSubtitle; _unit setVariable ["talked", "idk", true];
};

//-- CLIENT
[missionNamespace, "arsenalOpened", {[] call tsp_fnc_upgrade}] call BIS_fnc_addScriptedEventHandler;  //-- Arsenal unlocks

[[  //-- Intro
	[5,{
		[4,2,false] call bis_fnc_animatedScreen;
		[true, ["Horizon Islands, 2017"]] spawn BIS_fnc_OM_AS_ShowStaticText;
		uiSleep 3; [3,2,false] call bis_fnc_animatedScreen;
	}], [7,{
		[4,2,false] call bis_fnc_animatedScreen;
		[true, ["After 3 years of struggle,","the criminal organization, known as Syndikat, has become a full-on insurgency."], 4] spawn BIS_fnc_OM_AS_ShowStaticText;
		uiSleep 5; [3,2,false] call bis_fnc_animatedScreen;
	}], [5,{
		[4,2,false] call bis_fnc_animatedScreen;
		[5,1,"data\01_b.paa",nil,nil,1] call bis_fnc_animatedScreen; [6,1,8,nil,1.1] call bis_fnc_animatedScreen;
		[5,2,"data\01_f.paa",nil,nil,1] call bis_fnc_animatedScreen; [6,2,8,nil,1.2] call bis_fnc_animatedScreen;
		uiSleep 3; [3,2,false] call bis_fnc_animatedScreen;
	}],	[7,{
		[4,2,false] call bis_fnc_animatedScreen;
		[true, ["Syndikat conducted a large offensive on the peaceful islands of Pulau Monyet and Pulau Gurun.","They managed to push back and corner local security forces..."], 4] spawn BIS_fnc_OM_AS_ShowStaticText;
		uiSleep 5; [3,2,false] call bis_fnc_animatedScreen;
	}], [5,{
		[4,2,false] call bis_fnc_animatedScreen;
		[5,1,"data\02_b.paa",nil,nil,1] call bis_fnc_animatedScreen; [6,1,8,nil,1.1] call bis_fnc_animatedScreen;
		[5,2,"data\02_f.paa",nil,nil,1] call bis_fnc_animatedScreen; [6,2,8,nil,1.2] call bis_fnc_animatedScreen;
		uiSleep 3; [3,2,false] call bis_fnc_animatedScreen;
	}],	[5,{
		[4,2,false] call bis_fnc_animatedScreen;
		[true, ["...while leaving a wake of destruction in their path."]] spawn BIS_fnc_OM_AS_ShowStaticText;
		uiSleep 3; [3,2,false] call bis_fnc_animatedScreen;
	}], [5,{
		[4,2,false] call bis_fnc_animatedScreen;
		[5,1,"data\03_b.paa",nil,nil,1] call bis_fnc_animatedScreen; [6,1,8,nil,1.1] call bis_fnc_animatedScreen;
		[5,2,"data\03_f.paa",nil,nil,1] call bis_fnc_animatedScreen; [6,2,8,nil,1.2] call bis_fnc_animatedScreen;
		uiSleep 3; [3,2,false] call bis_fnc_animatedScreen;
	}],	[7,{
		[4,2,false] call bis_fnc_animatedScreen;
		[true, ["Any retaliation by government forces proved to be fruitless against the now organized Syndikat."]] spawn BIS_fnc_OM_AS_ShowStaticText;
		uiSleep 5; [3,2,false] call bis_fnc_animatedScreen;
	}], [5,{
		[4,2,false] call bis_fnc_animatedScreen;
		[5,1,"data\04_b.paa",nil,nil,1] call bis_fnc_animatedScreen; [6,1,8,nil,1.1] call bis_fnc_animatedScreen;
		[5,2,"data\04_f.paa",nil,nil,1] call bis_fnc_animatedScreen; [6,2,8,nil,1.2] call bis_fnc_animatedScreen;
		uiSleep 3; [3,2,false] call bis_fnc_animatedScreen;
	}],	[5,{
		[4,2,false] call bis_fnc_animatedScreen;
		[true, ["Task Force Naga was formed in response to the crisis..."]] spawn BIS_fnc_OM_AS_ShowStaticText;
		uiSleep 3; [3,2,false] call bis_fnc_animatedScreen;
	}], [5,{
		[4,2,false] call bis_fnc_animatedScreen;
		[5,1,"data\05_b.paa",nil,nil,1] call bis_fnc_animatedScreen; [6,1,8,nil,1.1] call bis_fnc_animatedScreen;
		[5,2,"data\05_f.paa",nil,nil,1] call bis_fnc_animatedScreen; [6,2,8,nil,1.2] call bis_fnc_animatedScreen;
		uiSleep 3; [3,2,false] call bis_fnc_animatedScreen;
	}],	[4,{
		[4,2,false] call bis_fnc_animatedScreen;
		[true, ["...with the goal of dismantling Syndikat leadership."]] spawn BIS_fnc_OM_AS_ShowStaticText;
		uiSleep 2; [3,2,false] call bis_fnc_animatedScreen;
	}], [5,{
		[4,2,false] call bis_fnc_animatedScreen;
		[5,1,"data\06_b.paa",nil,nil,1] call bis_fnc_animatedScreen; [6,1,8,nil,1.1] call bis_fnc_animatedScreen;
		[5,2,"data\06_f.paa",nil,nil,1] call bis_fnc_animatedScreen; [6,2,8,nil,1.2] call bis_fnc_animatedScreen;
		uiSleep 3; [3,2,false] call bis_fnc_animatedScreen;
	}]
], "LeadTrack01_F_EXP", {[true] call tsp_fnc_role; [] spawn tsp_fnc_spawn_map}] spawn tsp_fnc_intro;

["CAManBase", "init", {  //-- Talking to civilians
	params ["_unit"]; 
	[_unit, localize "STR_TALK", "\a3\ui_f_oldman\data\IGUI\Cfg\holdactions\meet_ca.paa", {[(_this#0)] call tsp_fnc_talk}, "alive _target && !(isPlayer _target) && (side _target in [west, civilian])"] call tsp_fnc_action_hold;
}, true, [], true] call CBA_fnc_addClassEventHandler;

//-- SERVER
if (!isServer) exitWith {};
tsp_totalIntel = 0; tsp_totalMoney = 0; tsp_chanceIntel = 0.5; tsp_chanceTalk = 0.5; 
{publicVariable _x} forEach ["tsp_totalIntel", "tsp_totalMoney", "tsp_chanceIntel", "tsp_chanceTalk"];

["CAManBase", "init", {  //-- Intel drop
	params ["_unit"]; 
	if (side _unit != resistance || random 1 > tsp_chanceIntel) exitWith {};
	_unit spawn {sleep 2; _this addMagazine (selectRandom ["Files", "FileTopSecret", "Keys", "MobilePhone", "FlashDisk", "Money", "Money_bunch", "Money_roll", "Money_stack"])};
}, true, [], true] call CBA_fnc_addClassEventHandler;

[west, "main", [localize "STR_TASK_MAIN_DESC", localize "STR_TASK_MAIN_TITLE"], objNull, "CREATED", -1, true, "Meet"] call BIS_fnc_taskCreate;
[west, "side", [localize "STR_TASK_SIDE_DESC", localize "STR_TASK_SIDE_TITLE"], objNull, "CREATED", -1, true, "Intel"] call BIS_fnc_taskCreate;

[west, ["general", "main"], [localize "STR_TASK_GENERAL_DESC", localize "STR_TASK_GENERAL_TITLE"], objNull, "CREATED", -1, true, "Target"] call BIS_fnc_taskCreate;
[west, ["general_locate", "general"], [localize "STR_TASK_GENERAL_LOCATE_DESCRIPTION", "Locate"], objNull, "CREATED", -1, true, "Scout"] call BIS_fnc_taskCreate;

[west, ["warlord", "main"], [localize "STR_TASK_WARLORD_DESC", localize "STR_TASK_WARLORD_TITLE"], objNull, "CREATED", -1, true, "Target"] call BIS_fnc_taskCreate;
[west, ["warlord_locate", "warlord"], [localize "STR_TASK_WARLORD_LOCATE_DESCRIPTION", localize "STR_TASK_LOCATE_TITLE"], objNull, "CREATED", -1, true, "Scout"] call BIS_fnc_taskCreate;

[west, ["dealer", "main"], [localize "STR_TASK_DEALER_DESC", localize "STR_TASK_DEALER_TITLE"], objNull, "CREATED", -1, true, "Target"] call BIS_fnc_taskCreate;
[west, ["dealer_locate", "dealer"], [localize "STR_TASK_DEALER_LOCATE_DESCRIPTION", localize "STR_TASK_LOCATE_TITLE"], objNull, "CREATED", -1, true, "Scout"] call BIS_fnc_taskCreate;

[west, ["journo", "main"], [localize "STR_TASK_JOURNO_DESC", localize "STR_TASK_JOURNO_TITLE"], objNull, "CREATED", -1, true, "Armor"] call BIS_fnc_taskCreate;
[west, ["journo_locate", "journo"], [localize "STR_TASK_JOURNO_LOCATE_DESCRIPTION", localize "STR_TASK_LOCATE_TITLE"], objNull, "CREATED", -1, true, "Scout"] call BIS_fnc_taskCreate;

[  //-- Camp2
	west, ["camp2", "side"], localize "STR_TASK_CAMP_TITLE", localize "STR_TASK_CAMP_DESC", "Attack", getPos camp2_t, 
	{tsp_totalIntel >= 5}, {"camp2" call tsp_fnc_sector_check && (count (allUnits select {_x distance camp2_t < 25 && side _x == independent}) == 0)}
] spawn tsp_fnc_task;

[  //-- Camp3
	west, ["camp3", "side"], localize "STR_TASK_CAMP_TITLE", localize "STR_TASK_CAMP_DESC", "Attack", getPos camp3_t, 
	{tsp_totalIntel >= 6}, {"camp3" call tsp_fnc_sector_check && (count (allUnits select {_x distance camp3_t < 25 && side _x == independent}) == 0)}
] spawn tsp_fnc_task;

[  //-- Camp1
	west, ["camp1", "side"], localize "STR_TASK_CAMP_TITLE", localize "STR_TASK_CAMP_DESC", "Attack", getPos camp1_t, 
	{tsp_totalIntel >= 10}, {"camp1" call tsp_fnc_sector_check && (count (allUnits select {_x distance camp1_t < 25 && side _x == independent}) == 0)}
] spawn tsp_fnc_task;

[  //-- AAA1
	west, ["aaa1", "side"], localize "STR_TASK_AAA1_TITLE", localize "STR_TASK_AAA1_DESC", "Destroy", getPos aaa1_t, 
	{tsp_totalIntel >= 12}, {!alive ("task_aaa1" call tsp_fnc_sector_variable)}
] spawn tsp_fnc_task;

[  //-- Pow1
	west, ["pow1", "side"], localize "STR_TASK_POW_TITLE", localize "STR_TASK_POW1_DESC", "Meet", getPos pow1_t, 
	{tsp_totalIntel >= 15}, {(count ([spawnPos_airfield, spawnPos_monyet, spawnPos_seliu] select {_x distance ("task_pow1" call tsp_fnc_sector_variable) < 50}) > 0)}, 
	{!alive ("task_pow1" call tsp_fnc_sector_variable)}
] spawn tsp_fnc_task;

[  //-- Arti1
	west, ["arti1", "side"], localize "STR_TASK_ARTI1_TITLE", localize "STR_TASK_ARTI1_DESC", "Destroy", getPos arti1_t, 
	{tsp_totalIntel >= 18}, {!alive ("task_arti1" call tsp_fnc_sector_variable)}
] spawn tsp_fnc_task;

[  //-- Crash
	west, ["crash", "side"], localize "STR_TASK_CRASH_TITLE", localize "STR_TASK_CRASH_DESC", "Heli", getPos crash_t, 
	{tsp_totalIntel >= 20}, {count ([spawnPos_airfield, spawnPos_monyet, spawnPos_seliu] select {_x distance ("task_crash1" call tsp_fnc_sector_variable) < 50}) > 0}, 
	{!alive ("task_crash1" call tsp_fnc_sector_variable)}
] spawn tsp_fnc_task;

[  //-- Cache1
	west, ["cache1", "side"], localize "STR_TASK_CACHE_TITLE", localize "STR_TASK_CACHE1_DESC", "Rifle", getPos cache1_t, 
	{tsp_totalIntel >= 22}, {!alive ("task_cache1" call tsp_fnc_sector_variable)}
] spawn tsp_fnc_task;

[  //-- Camp5
	west, ["camp5", "side"], localize "STR_TASK_CAMP_TITLE", localize "STR_TASK_CAMP_DESC", "Attack", getPos camp5_t,  
	{tsp_totalIntel >= 24}, {"camp5" call tsp_fnc_sector_check && (count (allUnits select {_x distance camp5_t < 25 && side _x == independent}) == 0)}
] spawn tsp_fnc_task;

[  //-- Pow2
	west, ["pow2", "side"], localize "STR_TASK_POW_TITLE", localize "STR_TASK_POW2_DESC", "Meet", getPos pow2_t, 
	{tsp_totalIntel >= 27}, {count ([spawnPos_airfield, spawnPos_monyet, spawnPos_seliu] select {_x distance ("task_pow1" call tsp_fnc_sector_variable) < 50}) > 0}, 
	{!alive ("task_pow2" call tsp_fnc_sector_variable)}
] spawn tsp_fnc_task;

[  //-- Camp4
	west, ["camp4", "side"], localize "STR_TASK_CAMP_TITLE", localize "STR_TASK_CAMP_DESC", "Attack", getPos camp4_t, 
	{tsp_totalIntel >= 30}, {"camp4" call tsp_fnc_sector_check && (count (allUnits select {_x distance camp4_t < 25 && side _x == independent}) == 0)}
] spawn tsp_fnc_task;

[  //-- Cache2
	west, ["cache2", "side"], localize "STR_TASK_CACHE_TITLE", localize "STR_TASK_CACHE2_DESC", "Rifle", getPos cache2_t,  
	{tsp_totalIntel >= 32}, {!alive ("task_cache2" call tsp_fnc_sector_variable)}
] spawn tsp_fnc_task;

[  //-- Camp6
	west, ["camp6", "side"], localize "STR_TASK_CAMP_TITLE", localize "STR_TASK_CAMP_DESC", "Attack", getPos camp6_t, 
	{tsp_totalIntel >= 35}, {"camp6" call tsp_fnc_sector_check && (count (allUnits select {_x distance camp6_t < 25 && side _x == independent}) == 0)}
] spawn tsp_fnc_task;

[  //-- General
	west, ["general_kill", "general"], localize "STR_TASK_KILL_TITLE", localize "STR_TASK_GENERAL_KILL_DESC", "Kill", getPos general_out_t,  
	{tsp_totalIntel >= 42 && ["dealer_kill"] call BIS_fnc_taskExists && ["warlord_kill"] call BIS_fnc_taskExists}, 
	{count ([spawnPos_airfield, spawnPos_monyet, spawnPos_seliu] select {_x distance ("task_general" call tsp_fnc_sector_variable) < 50}) > 0 || !alive ("task_general" call tsp_fnc_sector_variable)}, 
	{false}, {false}, {["general_locate", "SUCCEEDED"] call BIS_fnc_taskSetState}
] spawn tsp_fnc_task;

[  //-- Dealer
	west, ["dealer_kill", "dealer"], localize "STR_TASK_KILL_TITLE", localize "STR_TASK_DEALER_KILL_DESC", "Kill", getPos dealer_t, 
	{tsp_totalIntel >= 37}, 
	{count ([spawnPos_airfield, spawnPos_monyet, spawnPos_seliu] select {_x distance ("task_dealer" call tsp_fnc_sector_variable) < 50}) > 0 || !alive ("task_dealer" call tsp_fnc_sector_variable)}, 
	{false}, {false},{["dealer_locate", "SUCCEEDED"] call BIS_fnc_taskSetState}
] spawn tsp_fnc_task;

[  //-- Warlord
	west, ["warlord_kill", "warlord"], localize "STR_TASK_KILL_TITLE", localize "STR_TASK_WARLORD_KILL_DESC", "Kill", getPos warlord_t, 
	{tsp_totalIntel >= 40}, 
	{count ([spawnPos_airfield, spawnPos_monyet, spawnPos_seliu] select {_x distance ("task_warlord" call tsp_fnc_sector_variable) < 50}) > 0 || !alive ("task_warlord" call tsp_fnc_sector_variable)}, 
	{false}, {false}, {["warlord_locate", "SUCCEEDED"] call BIS_fnc_taskSetState}
] spawn tsp_fnc_task;

[  //-- Journo
	west, ["journo_rescue", "journo"], localize "STR_TASK_JOURNO_RESCUE_TITLE", localize "STR_TASK_JOURNO_RESCUE_DESC", "Meet", getPos journo_t, 
	{tsp_totalIntel >= 35}, 
	{count ([spawnPos_airfield, spawnPos_monyet, spawnPos_seliu] select {_x distance ("task_journo1" call tsp_fnc_sector_variable) < 50}) > 0 || count ([spawnPos_airfield, spawnPos_monyet, spawnPos_seliu] select {_x distance ("task_journo2" call tsp_fnc_sector_variable) < 50}) > 0}, 
	{!alive ("task_journo1" call tsp_fnc_sector_variable) && !alive ("task_journo2" call tsp_fnc_sector_variable)}, 
	{false}, {["journo_locate", "SUCCEEDED"] call BIS_fnc_taskSetState}
] spawn tsp_fnc_task;