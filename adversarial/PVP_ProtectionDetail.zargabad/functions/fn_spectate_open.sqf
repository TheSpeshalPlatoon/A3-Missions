//-- Open spectator camera
["Initialize", [player, [], false, true, true, true, true, true, true, true]] call BIS_fnc_EGSpectator;   
titleCut ["", "BLACK IN", 1.5];

waitUntil {alive player};

//-- Open spectator chat
if (isClass(configFile >> "CfgPatches" >> "acre_sys_radio")) then {[true] call acre_api_fnc_setSpectator};
tsp_chat_spectator radioChannelAdd [player];

[player,true] remoteExec ["hideObjectGlobal", 2];
tsp_currentlySpectating = true;