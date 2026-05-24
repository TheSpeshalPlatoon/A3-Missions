//-- Initial Mission Settings
#include "mission\parameters.sqf";
publicVariable "tsp_param_spectate";
publicVariable "tsp_param_loadout";
publicVariable "tsp_param_crew";
publicVariable "tsp_param_gear";
publicVariable "tsp_param_jointime";
publicVariable "tsp_spawnOnStart";

["Initialize", [true]] call BIS_fnc_dynamicGroups;  //-- Dynamic Groups

//-- Skill
["CAManBase","init",{
	[
		_this,
		tsp_general,
		tsp_commanding,
		tsp_courage,
		tsp_aimingAccuracy,
		tsp_aimingShake,
		tsp_aimingSpeed,
		tsp_reloadSpeed,
		tsp_spotDistance,
		tsp_spotTime
	] call tsp_fnc_setskill;
},true,[],true] call CBA_fnc_addClassEventHandler;
{	
	[_this,tsp_general,tsp_commanding,tsp_courage,tsp_aimingAccuracy,tsp_aimingShake,tsp_aimingSpeed,tsp_reloadSpeed,tsp_spotDistance,tsp_spotTime] call tsp_fnc_setskill;
} forEach allUnits;

//-- Chat
tsp_chat_spectator = radioChannelCreate [[0.92, 0.25, 0.2, 1], "Spectator", "%UNIT_NAME", [], false];
tsp_chat_help = radioChannelCreate [[0.42, 0.5, 0.44, 1], "Technical Help", "%UNIT_NAME", [], false];
publicVariable "tsp_chat_spectator";
publicVariable "tsp_chat_help";