["tsp_param_faction", "CHECKBOX", "Faction", "Custom faction loadouts", "TSP Core", false] call tsp_fnc_setting;

tsp_fnc_faction = {  //-- Check if type exists in CfgLoadouts and apply it
	params ["_unit", "_type", ["_force", false], ["_anim", animationState (_this#0)], ["_goggles", ""]]; //sleep 0.01;
	if (_unit isEqualTo (missionnamespace getvariable ["BIS_fnc_arsenal_center", objNull])) exitWith {};
	if (!_force && (_unit get3DENAttribute 'ReceiveRemoteTargets' isEqualTo [true] || vehicleReceiveRemoteTargets _unit)) exitWith {};
	if (getText (configFile >> "CfgLoadouts" >> _type) != "") then {_unit setUnitLoadout (_unit call compile getText (configFile >> "CfgLoadouts" >> _type))};  //-- Config
	if (getText (missionConfigFile >> _type) != "") then {_unit setUnitLoadout (_unit call compile getText (missionConfigFile >> _type)); _goggles = goggles _unit};  //-- Description
	if (vehicle _unit == _unit && is3DEN) then {_unit switchMove _anim}; 
	//if (_goggles != "") then {[_unit, _goggles] spawn {sleep 0.1; (_this#0) addGoggles (_this#1)}}
};

[missionNamespace, 'arsenalPreOpen', {(_this#1) set3DENAttribute ['ReceiveRemoteTargets', true]}] call BIS_fnc_addScriptedEventHandler;  //-- If loadout edited, set flag so it doesn't get changed back

//-- Apply to all existing and new units
if (tsp_param_faction) then {[player, typeOf player] call tsp_fnc_faction};
if (tsp_param_faction) then {{[_x, typeOf _x] call tsp_fnc_faction} forEach (allUnits select {local _x})};
addMissionEventHandler ["EntityCreated", {params ["_unit"]; if (isServer && _unit isKindOf "CAManBase" && tsp_param_faction) then {[_unit, typeOf _unit] call tsp_fnc_faction}}];