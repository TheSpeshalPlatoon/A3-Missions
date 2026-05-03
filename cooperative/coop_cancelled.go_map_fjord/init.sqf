tsp_fnc_elves = {
	params ["_unit", ["_items", uniformItems (_this#0)]]; sleep 1;
	removeUniform _unit; _unit forceAddUniform "rhs_uniform_gorka_1_klyaksa";
    {_unit addItemToUniform _x} forEach _items;
	_unit addHeadgear (selectRandom ["TC_Helmet_Hat_Santa1_BluePattern1","TC_Helmet_Hat_Santa1_Buffalo1","TC_Helmet_Hat_Santa1_Camo_Aus1","TC_Helmet_Hat_Santa1_Camo_Cadpat1","TC_Helmet_Hat_Santa1_Camo_Tigerstripe1","TC_Helmet_Hat_Santa1_FestivePattern1","TC_Helmet_Hat_Santa1_Garf1","TC_Helmet_Hat_Santa1_Missing1","TC_Helmet_Hat_Santa1_Nb1","TC_Helmet_Hat_Santa1_Pink1","TC_Helmet_Hat_Santa1_Pride1","TC_Helmet_Hat_Santa1","TC_Helmet_Hat_Santa1_Stealth1","TC_Helmet_Hat_Santa1_Trans1","TC_Helmet_Hat_Santa1_Bi1","rhs_xmas_antlers"]);
};
{[_x] spawn tsp_fnc_elves} forEach (allUnits select {side _x == EAST && _x != task_santa});
addMissionEventHandler ["EntityCreated", {params ["_entity"]; if (side _entity == EAST && _entity != task_santa) then {[_entity] spawn tsp_fnc_elves}}];

//"_snowfall","_duration_storm","_ambient_sounds_al","_breath_vapors","_snow_burst","_effect_on_objects","_vanilla_fog","_local_fog","_intensifywind","_unitsneeze"
[true, 6000, 15, true, 10, false, true, true, true, false] execVM "AL_snowstorm\al_snow.sqf";

if (!isServer) exitWith {};

[
	west, ["sleigh"], "Destroy Santa's Sleigh", "We must destroy Santa's sleigh to prevent him from making a daring escape.", "Destroy", task_sleigh, 
	{true}, {!alive task_sleigh}
] spawn tsp_fnc_task;

[
	west, ["santa"], "Kill/Capture Santa Claus", "Santa is likely hiding out in his lake cabin, it may appear a simple objective on the outside, but be careful as it is likely heavily fortified.", "Kill", task_santa, 
	{true}, {task_santa distance christmas_hats < 100 || !alive task_santa}, {false}, {false},
	{false}, {["house_reinf"] spawn tsp_fnc_sector_load}
] spawn tsp_fnc_task;