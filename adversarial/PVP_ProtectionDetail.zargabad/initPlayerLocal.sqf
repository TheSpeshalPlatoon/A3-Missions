tsp_currentlySpectating = false;
tsp_killedCount = 0;

//-- Create Fake Respawns at mapPos
createMarker ["respawn_west", [0,0,0]];
createMarker ["respawn_east", [0,0,0]];
createMarker ["respawn_guer", [0,0,0]];
createMarker ["respawn_civ", [0,0,0]];

#include "events\pause.sqf";  //-- ESC Menu

["InitializePlayer", [player, true]] call BIS_fnc_dynamicGroups;  //-- Dynamic Groups

[
	["B_Officer_F","O_Officer_F"],
	["B_Helipilot_F","O_Helipilot_F"],
	["B_Pilot_F", "O_Pilot_F"],
	["B_crew_F", "O_crew_F"],
	["B_APC_Wheeled_01_cannon_F","CUP_B_LAV25_USMC"],
	["Steerable_Parachute_F"]
] call tsp_fnc_restrict_crew;