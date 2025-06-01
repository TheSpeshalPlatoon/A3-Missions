sleep 1; [] execVM "scripts\killhouse.sqf"; 

([
	kh1_start, kh1_end, kh1_area, 9, 33, 10,  //-- Width, height, room size
	1, 1, 0,  //-- Min, max, hostage chance
	0, east, [],  //-- Enemy chance, side, type
	0, civilian_chernarus,  //-- Civil chance, type
	1, ["Target_F"],  //-- Target chance, type
	0.1, furniture_livonia,  //-- Furniture chance, type
	0.5, 0.2, 0.8  //--  Locked, openings, doors
] + tsp_killhouse_walls) remoteExec ["tsp_fnc_killhouse", 2];

sleep 10; "Game starts in 30 seconds!" remoteExec ["systemChat"];
sleep 30; "Game start!" remoteExec ["systemChat"]; tsp_start = true; publicVariable "tsp_start";

while {sleep 5; true} do {  //-- Win conditions
	//if (count (playableUnits select {!isObjectHidden _x && side _x == west}) == 0) exitWith {[[], {"east" call BIS_fnc_endMission}] remoteExec ["spawn", 0]};  //-- All BLUFOR dead, RESISTANCE wins
	//if (count (playableUnits select {!isObjectHidden _x && side _x == east}) == 0) exitWith {[[], {"west" call BIS_fnc_endMission}] remoteExec ["spawn", 0]};  //-- All EAST dead, BLUFOR wins
	//if (count (playableUnits select {!isObjectHidden _x && side _x == resistance}) == 0) exitWith {[[], {"west" call BIS_fnc_endMission}] remoteExec ["spawn", 0]};  //-- All RESISTANCE dead, BLUFOR wins
};