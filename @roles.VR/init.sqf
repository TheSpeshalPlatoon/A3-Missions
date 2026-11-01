{  //-- Pose the units, add copy loadouts
	_x setCaptive true; 
	_x disableAI "MOVE";
	_x disableAI "ANIM";
	_x switchMove "amovpknlmstpslowwrfldnon";
	if (currentWeapon _x == handgunWeapon _x && handgunWeapon _x != "") then {_x switchMove "amovpknlmstpslowwpstdnon"};
	[_x, us_all, true] call BIS_fnc_attachToRelative;
	_x setDir 90;
	[_x, "Copy Loadout", "\a3\missions_f_oldman\data\img\holdactions\holdAction_box_ca.paa", {
		player setUnitLoadout (getUnitLoadout (_this#0));
		copyToClipboard str (getUnitLoadout (_this#0));
	}, "true", false, 0.2, [_x], 100, 10] call tsp_fnc_action_hold;
	_x setUnitLoadout (missionNamespace getVariable [typeOf _x, []]);
} forEach (allUnits select {!isPlayer _x});

[] spawn {
	sleep 1;
	
	_superString = '';

	//-- Get unit loadouts
	{_superString = _superString + typeOf _x + " = " + str getUnitLoadout _x + ";
	"} forEach ([(allUnits select {!isPlayer _x}), [], {_x distance medic}, "ASCEND"] call BIS_fnc_sortBy);

	{  //-- Get the roles
		_items = (missionNameSpace getVariable [vehicleVarName _x, objNull]) call ace_arsenal_fnc_getVirtualItems;
		_itemsString = str (_items apply {_x});
		_itemsString = _itemsString select [1, (count _itemsString) - 2];  //-- Trim front and back

		_dependencies = _x getVariable ["dependencies", []];
		_dependencyString = "";
		{_dependencyString = _dependencyString + str _x + ","} forEach _dependencies;

		_superString = _superString + vehicleVarName _x + '[] = {' + _dependencyString + _itemsString + '};
		';

		_list = _dependencies + (_items apply {_x regexReplace ["ace_", "ACE_"]});
		missionNamespace setVariable [vehicleVarName _x, _list];  //-- Set variables
	} forEach ([(allMissionObjects "") select {vehicleVarName _x != "" && !(_x isKindOf "Man")}, [], {_x distance medic}, "ASCEND"] call BIS_fnc_sortBy);

	copyToClipboard ((toLower _superString) regexReplace ["ace_", "ACE_"]);
	systemChat "COPIED TO CLIPBOARD";
};