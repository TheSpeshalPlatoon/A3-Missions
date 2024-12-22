tsp_fnc_earplug_open = {
    if (!tsp_earplug_insert || !(isNil "tsp_earplug_mouseZ")) exitWith {};  //-- Only do if you have earplugs in
	uiNamespace setVariable ["tsp_earplug_background", findDisplay 46 ctrlCreate ["tsp_earplug_background", -1]];
	uiNamespace setVariable ["tsp_earplug_progress", findDisplay 46 ctrlCreate ["tsp_earplug_progress", -1]];
	uiNameSpace getVariable "tsp_earplug_progress" progressSetPosition ((soundVolume - 0.1)*1.7);          //-- Set GUI level to "soundVolume" (math is due to min max below)	
	tsp_earplug_mouseZ = (findDisplay 46) displayAddEventHandler ["mouseZChanged", {                      //-- Scroll wheel should affect GUI and fadeSound to new volume
		(uiNameSpace getVariable "tsp_earplug_progress") progressSetPosition ((tsp_earplug_volume - 0.1)*1.7);  //-- Reflect changes on GUI
		tsp_earplug_volume = (soundVolume + ((_this#1) / 20)) min 0.7 max 0.1; 0 fadeSound tsp_earplug_volume;  //-- Change volume
		false
	}];
};

tsp_fnc_earplug_close = {
    if (isNil "tsp_earplug_mouseZ") exitWith {};  //-- Only allow closing if menu is open
	{ctrlDelete (uiNameSpace getVariable [_x, 999])} forEach ["tsp_earplug_background", "tsp_earplug_progress"];
	(findDisplay 46) displayRemoveEventHandler ["mouseZChanged", missionNamespace getVariable ["tsp_earplug_mouseZ", 999]]; tsp_earplug_mouseZ = nil;
};

tsp_fnc_earplug_toggle = {
	if (!tsp_earplug_insert && [] call tsp_fnc_earplug_has) exitWith {["EARPLUGS INSERTED", "Hold [CTRL + TAB + SCROLL] to adjust volume"] spawn tsp_fnc_hint; tsp_earplug_insert = true; 0.1 fadeSound tsp_earplug_volume};
	if (tsp_earplug_insert) exitWith {tsp_earplug_insert = false; 0.1 fadeSound 1; ["", "EARPLUGS REMOVED."] spawn tsp_fnc_hint};
};

tsp_fnc_earplug_has = {
	params [["_unit", player], ["_items", ["ACE_EarPlugs","peltor","amp"]]];
	if !(isClass(configFile >> 'CfgPatches' >> 'ace_hearing')) exitWith {true};
	if (count (_items select {_x in (str getUnitLoadout _unit)}) > 0) exitWith {true};
	false
};

waitUntil {!isNull (findDisplay 46)};
tsp_earplug_insert = false; tsp_earplug_volume = 0.25;
player addEventHandler ["InventoryClosed", {if (tsp_earplug_insert && !([] call tsp_fnc_earplug_has)) then {tsp_earplug_insert = false; 0 fadeSound 1}}];  //-- When dropping earplugs
player addEventHandler ["AnimStateChanged", {if (tsp_earplug_insert && soundVolume != tsp_earplug_volume) then {tsp_earplug_insert = true; 0 fadeSound tsp_earplug_volume}}];
["tsp_earplug_adjust", ["TSP Core", "Earplug"], "Adjust Earplug Volume", 15, false, true, false, {[] call tsp_fnc_earplug_open}, {[] call tsp_fnc_earplug_close}] spawn tsp_fnc_keybind;
["tsp_earplug_insert", ["TSP Core", "Earplug"], "Insert/Remove Earplugs", 210, false, false, false, {[] call tsp_fnc_earplug_toggle}] spawn tsp_fnc_keybind;
if (!isNil "CBA_fnc_addPlayerEventHandler") then {
	["featureCamera", {if (tsp_earplug_insert && soundVolume != tsp_earplug_volume) then {tsp_earplug_insert = true; 0 fadeSound tsp_earplug_volume}}] call CBA_fnc_addPlayerEventHandler;
};