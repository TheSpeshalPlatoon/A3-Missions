//-- Update start spawns each time in case they move or something
#include "..\mission\spawns.sqf";   

//-- Decide which spawns to use based on player's side
_spawnsToUse = [];
_dynamicSpawnsToUse = [];
switch (side player) do {
	case west: {_spawnsToUse = tsp_Spawns_West};
	case east: {_spawnsToUse = tsp_Spawns_East};
	case civilian: {_spawnsToUse = tsp_Spawns_Civ};
	case resistance: {_spawnsToUse = tsp_Spawns_Guer};
};

//-- Clean up _spawnsToUse and add a few items
_actualSpawns=[];
{
	_pos = _x select 0;
	_code = "titleCut ['', 'BLACK OUT', 0.1];sleep 0.5;titleCut ['', 'BLACK IN', 1.5];" + (_x select 1);
	_name = _x select 2;
	_desc = _x select 3;
	_tempSpawn = [  [ _pos, compile _code, _name, _desc, "", "", 1, [] ]  ];
	_actualSpawns = _actualSpawns + _tempSpawn;
} forEach _spawnsToUse;

//-- Decide whether map should be day or night
_night = false;
if ( (daytime > 19.5) || (daytime < 4.75) ) then {_night = true};

//-- Open the map
[
	call bis_fnc_displayMission,
	[((getPos tsp_mapPosition) select 0),((getPos tsp_mapPosition) select 1)],
	_actualSpawns,
	[],
	[],
	[],
	overcast,
	_night,
	2,
	true, 
	"Select Spawn Point"
] call tsp_fnc_map_bis;

//-- Remove buttons if "lock" parameter is true
if (_this select 0) then {
	((findDisplay 506) displayCtrl 2) ctrlEnable false;   //-- Disable close button
	//-- Reopen map if ESC is pressed to close it
	(findDisplay 506) displayAddEventHandler ["KeyDown", "if ((_this select 1) == 1) then {[] spawn {[true] call tsp_fnc_map_open}}"];   //-- ESC Button
	(findDisplay 506) displayAddEventHandler ["KeyDown", "if ((_this select 1) == 11) then {[] spawn {[false] call tsp_fnc_map_open}}"]; //-- 0 Button
};