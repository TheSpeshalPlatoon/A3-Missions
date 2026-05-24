switch (tsp_param_Loadout) do {
	case "Original": {player setUnitLoadout (missionNamespace getVariable ["Original_Loadout",[]])};
	case "Retain": {player setUnitLoadout (missionNamespace getVariable ["Retained_Loadout",[]])};
};

tsp_chat_help radioChannelAdd [player];

//-- Initial spawn
if (tsp_killedCount == 0) then {
	missionNamespace setVariable ["Original_Loadout", getUnitLoadout player]; //-- Save original loadout	
	{_x enableChannel [false, false]} forEach [0,1,2,3];
	if ( (time > tsp_param_jointime) && (tsp_param_spectate == "Forced") ) exitWith {call tsp_fnc_spectate_open};
	if (tsp_spawnOnStart) then {[true] call tsp_fnc_map_open};	
};

//-- Release immediately with map if spectate is disabled
if (tsp_killedCount > 0 && tsp_param_spectate == "Disabled") then {
	[true] call tsp_fnc_map_open;
};