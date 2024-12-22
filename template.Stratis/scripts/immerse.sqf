["tsp_cba_immerse", "CHECKBOX", "Enable Immerse", "", "TSP Immerse", true] call tsp_fnc_setting;

["tsp_cba_immerse_vignette_multiplier", "SLIDER", "Vignette Multiplier", "", "TSP Immerse", [0,1,1]] call tsp_fnc_setting;
["tsp_cba_immerse_blur_multiplier", "SLIDER", "Blur Multiplier", "", "TSP Immerse", [0,10,1]] call tsp_fnc_setting;
["tsp_cba_immerse_sway", "SLIDER", "Sway Base", "", "TSP Immerse", [0,10,0.5]] call tsp_fnc_setting;
["tsp_cba_immerse_sway_multiplier", "SLIDER", "Sway Multiplier", "", "TSP Immerse", [0,10,1]] call tsp_fnc_setting;
["tsp_cba_immerse_align", "SLIDER", "Alignment Base", "", "TSP Immerse", [0,10,0.5]] call tsp_fnc_setting;
["tsp_cba_immerse_align_multiplier", "SLIDER", "Alignment Multiplier", "", "TSP Immerse", [0,10,1]] call tsp_fnc_setting;
["tsp_cba_immerse_bipod_multiplier", "SLIDER", "Bipod Multiplier", "", "TSP Immerse", [0,1,0.1]] call tsp_fnc_setting;

["tsp_cba_immerse_intensity", "SLIDER", "Intensity", "", ["TSP Immerse", "Suppression"], [0,1,0.3]] call tsp_fnc_setting;
["tsp_cba_immerse_distance", "SLIDER", "Distance", "", ["TSP Immerse", "Suppression"], [0,30,10]] call tsp_fnc_setting;
["tsp_cba_immerse_cqb", "SLIDER", "CQB Distance", "", ["TSP Immerse", "Suppression"], [0,30,20]] call tsp_fnc_setting;
["tsp_cba_immerse_cqb_multiplier", "SLIDER", "CQB Multiplier", "", ["TSP Immerse", "Suppression"], [0,1,0.1]] call tsp_fnc_setting;
["tsp_cba_immerse_decay", "SLIDER", "Decay", "", ["TSP Immerse", "Suppression"], [0,1,0.2]] call tsp_fnc_setting;
["tsp_cba_immerse_blur_suppression", "SLIDER", "Blur Multiplier", "", ["TSP Immerse", "Suppression"], [0,10,1]] call tsp_fnc_setting;

["tsp_immerse_hud", ["TSP Core", "HUD"], "Toggle HUD", 41, false, false, false, {[false] call tsp_fnc_immerse_hud}] call tsp_fnc_keybind;
["tsp_immerse_hud_st", ["TSP Core", "HUD"], "Toggle ShackTac HUD", 41, true, false, false, {[true] call tsp_fnc_immerse_hud}] call tsp_fnc_keybind;

tsp_fnc_immerse_hud = {
	params [["_shacktac", false], ["_ace", false]];  //-- Hud, Info, Radar, Veh Compass, Direction, Command Menu, Group, Crosshair, Vehicle, Logs -- Never show group bar
	if (isNil "tsp_hud_shacktac") then {tsp_hud_shacktac = missionNameSpace getVariable ["STHud_UIMode", 0]};
	if (_shacktac) exitWith {if (STHud_UIMode == 0) then {STHud_UIMode = tsp_hud_shacktac} else {STHud_UIMode = 0}};  //-- If shacktac mode, then only hide shacktac
	if (isNil "tsp_hud_ace") then {tsp_hud_ace = missionNameSpace getVariable ["ace_nametags_showPlayerNames", 0]};
	if (_ace) exitWith {if (ace_nametags_showPlayerNames == 0) then {ace_nametags_showPlayerNames = tsp_hud_ace} else {ace_nametags_showPlayerNames = 0}};  //-- If shacktac mode, then only hide shacktac
	if (shownHUD#3) then {
		STHud_UIMode = 0;
		ace_nametags_showPlayerNames = 0;
		showHUD [
			true,            //-- ScriptedHUD
			false,          //-- Info
			false,         //-- Radar
			false,        //-- Compass
			false,       //-- Direction
			false,      //-- Menu
			false,     //-- Group
			true,     //-- Cursors
			false,   //-- Panels
			false,  //-- Kills
			false  //-- ShowIcon3D
		];
	} else {
		STHud_UIMode = tsp_hud_shacktac;
		ace_nametags_showPlayerNames = tsp_hud_ace;
		showHUD [
			true,           //-- ScriptedHUD
			true,          //-- Info
			true,         //-- Radar
			true,        //-- Compass
			true,       //-- Direction
			true,      //-- Menu
			false,    //-- Group
			true,    //-- Cursors
			true,   //-- Panels
			true,  //-- Kills
			true  //-- ShowIcon3D
		];
	};
};

tsp_fnc_immerse_suppress = {  //-- Need to use "player" in while loop cause dying during suppression changes definition of "_unit"
	params ["_unit", "_distance", "_shooter", "_instigator", "_ammoObject", "_ammoClassName", "_ammoConfig"];
	[((tsp_cba_immerse_distance - _distance) / tsp_cba_immerse_distance)*tsp_cba_immerse_intensity, _unit getVariable ["suppression", 0]] params ["_amount", "_saved"];
	if (_shooter distance _unit < tsp_cba_immerse_cqb) then {_amount = _amount * tsp_cba_immerse_cqb_multiplier};
	if (_distance < tsp_cba_immerse_distance) then {_unit setVariable ["suppression", _saved+_amount min 3]};
};

tsp_fnc_immerse_poll = {
	params ["_unit", ["_ignoreGunnerState", false], ["_blur", uiNameSpace getVariable "tsp_immerse_blur"], ["_vignette", uiNameSpace getVariable "tsp_immerse_vignette"]];
	[getFatigue _unit, (speed _unit min 15)/15, _unit getVariable ["suppression", 0]] params ["_fatigue", "_speed", "_suppression"];
	_rotor = selectMax ([0] + ((getPos _unit nearEntities [["Helicopter"], 15] select {isEngineOn _x && vehicle _unit == _unit}) apply {15-(_unit distance _x)}));
	_gogle = 1 - ([configFile >> "CfgGlasses" >> goggles _unit, "ACE_Resistance", if ("goggle" in goggles _unit || "glass" in goggles _unit) then {1} else {0}] call BIS_fnc_returnConfigEntry);
	_water = if (surfaceIsWater getPos _unit) then {(10-(abs((getPosASL _unit)#2) min 10))/10} else {0};
	_bipod = if (isWeaponDeployed _unit) then {tsp_cba_immerse_bipod_multiplier} else {1};
	
	_vignette ctrlSetFade ((3 - (_suppression*tsp_cba_immerse_vignette_multiplier))/3); _vignette ctrlCommit 1;
	_blur ppEffectAdjust [(((_suppression*_bipod*tsp_cba_immerse_blur_suppression)+(_water*_gogle)+(_rotor*_gogle))/10)*tsp_cba_immerse_blur_multiplier]; _blur ppEffectCommit 1;
	_unit setCustomAimCoef (tsp_cba_immerse_sway+((_fatigue+_suppression+_speed)*_bipod*tsp_cba_immerse_sway_multiplier));
	if ((_ignoreGunnerState || cameraView == "GUNNER") && isNil "tsp_shake" && vehicle _unit == _unit) then {addCamshake [tsp_cba_immerse_align+((_fatigue+_suppression+_speed)*_bipod*tsp_cba_immerse_align_multiplier), 4, 0.3+(_suppression/6)]};
	if (!isNil "ace_common_fnc_addSwayFactor") then {["multiplier", {tsp_cba_immerse_sway+((_fatigue+_suppression+_speed)*_bipod*tsp_cba_immerse_sway_multiplier)}, "tsp_immerse"] call ace_common_fnc_addSwayFactor};
	if (_suppression > 0) then {_unit setVariable ["suppression", (_suppression - tsp_cba_immerse_decay) max 0]};  //-- Suppression decay
};

waitUntil {!isNull (findDisplay 46)}; if (!tsp_cba_immerse) exitWith {};
with uiNameSpace do {tsp_immerse_blur = ppEffectCreate ["DynamicBlur", 500]; tsp_immerse_blur ppEffectEnable true};
with uiNameSpace do {tsp_immerse_vignette = findDisplay 46 ctrlCreate ["RscPicture", -1]; tsp_immerse_vignette ctrlSetPosition [safeZoneX, safezoneY, safeZoneW, safezoneH]};
with uiNameSpace do {tsp_immerse_vignette ctrlSetTextColor [0,0,0,1]; tsp_immerse_vignette ctrlSetText ((missionNameSpace getVariable "tsp_path")+"data\vignette.paa"); tsp_immerse_vignette ctrlCommit 0};
player addEventHandler ["OpticsSwitch", {params ["_unit", "_ads"]; if (_ads) then {[_unit, true] call tsp_fnc_immerse_poll} else {[] spawn {sleep 0.1; resetCamShake}}}];
player addEventHandler ["Suppressed", {_this spawn tsp_fnc_immerse_suppress}];
while {sleep 1; tsp_cba_immerse} do {[player] call tsp_fnc_immerse_poll}; 