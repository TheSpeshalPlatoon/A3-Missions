params ["_map"];
if (tsp_currentlySpectating) then {
	//-- Close both cameras
	["Terminate"] call BIS_fnc_EGSpectator;
	["Terminate", [0,0,0]] call tsp_fnc_butter;

	//-- Remove spectator chat
	if (isClass(configFile >> "CfgPatches" >> "acre_sys_radio")) then {[false] call acre_api_fnc_setSpectator};
	tsp_chat_spectator radioChannelRemove [player];

	tsp_currentlySpectating = false;

	//-- Unhide player and show spawn map
	[player,false] remoteExec ["hideObjectGlobal", 2];
	if (_map) then {[true] call tsp_fnc_map_open};
};