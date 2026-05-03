["tsp_param_faction", "CHECKBOX", "Faction", "Custom faction loadouts", "TSP Core", false] call tsp_fnc_setting;

tsp_fnc_faction = {  //-- Check if type exists in CfgLoadouts and apply it
	params ["_unit", "_type", ["_force", false], ["_anim", animationState (_this#0)], ["_goggles", ""]]; //sleep 0.01;
	if (_unit isEqualTo (missionnamespace getvariable ["BIS_fnc_arsenal_center", objNull])) exitWith {};
	if (_unit isEqualTo (missionnamespace getvariable ["ace_arsenal_center", objNull])) exitWith {};
	if (!_force && (_unit get3DENAttribute 'ReceiveRemoteTargets' isEqualTo [true] || vehicleReceiveRemoteTargets _unit)) exitWith {};
	if (getText (configFile >> "CfgLoadouts" >> _type) != "") then {_unit setUnitLoadout (_unit call compile getText (configFile >> "CfgLoadouts" >> _type))};  //-- Config
	if (getText (missionConfigFile >> _type) != "") then {_unit setUnitLoadout (_unit call compile getText (missionConfigFile >> _type)); _goggles = goggles _unit};  //-- Description
	if (_force && getText (missionConfigFile >> _type) == "" && getText (configFile >> "CfgLoadouts" >> _type) == "") then {_unit setUnitLoadout _type};  //-- Class
	if (vehicle _unit == _unit && is3DEN) then {_unit switchMove _anim};
	//if (_goggles != "") then {[_unit, _goggles] spawn {sleep 0.1; (_this#0) addGoggles (_this#1)}}
	_unit spawn {sleep 0.1; _this setSpeaker "NoVoice"};
};

if (!tsp_param_faction) exitWith {};
[missionNamespace, 'arsenalPreOpen', {(_this#1) set3DENAttribute ['ReceiveRemoteTargets', true]}] call BIS_fnc_addScriptedEventHandler;  //-- If loadout edited, set flag so it doesn't get changed back
["ace_arsenal_displayOpened", {ace_arsenal_center set3DENAttribute ['ReceiveRemoteTargets', true]}] call CBA_fnc_addEventHandler;
if (isServer) then {addMissionEventHandler ["EntityCreated", {params ["_unit"]; if (_unit isKindOf "CAManBase") then {[_unit, typeOf _unit] call tsp_fnc_faction}}]};
if (isServer) then {{[_x, typeOf _x] call tsp_fnc_faction} forEach (allUnits select {!isPlayer _x})};
[] spawn {waitUntil {!isNull (findDisplay 46) && time > 1}; [player, typeOf player] call tsp_fnc_faction};