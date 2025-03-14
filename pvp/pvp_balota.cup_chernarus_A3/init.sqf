[] spawn {  //-- Client
	waitUntil {time > 5};
	if (side player == west) exitWith {[player, [zone_west], "You are out of bounds!", {[_this, [zone_west]] spawn tsp_fnc_zone_launch}] spawn tsp_fnc_zone};
	if (side player == east) exitWith {[player, [zone_east], "You are out of bounds!", {[_this, [zone_east]] spawn tsp_fnc_zone_launch}] spawn tsp_fnc_zone};
	if (side player == resistance) exitWith {[player, [zone_resistance], "You are out of bounds!", {[_this, [zone_resistance]] spawn tsp_fnc_zone_launch}] spawn tsp_fnc_zone};
};

[] spawn {  //-- Server
	if (!isServer) exitWith {};
	waitUntil {time > 1};
	[10, 60] spawn tsp_fnc_countDown;
	while {sleep 5; true} do {  //-- Win conditions
		if (count (playableUnits select {!isObjectHidden _x && side _x == west}) == 0) exitWith {[[], {"east" call BIS_fnc_endMission}] remoteExec ["spawn", 0]};  //-- All BLUFOR dead, RESISTANCE wins
		if (count (playableUnits select {!isObjectHidden _x && side _x == east}) == 0) exitWith {[[], {"west" call BIS_fnc_endMission}] remoteExec ["spawn", 0]};  //-- All EAST dead, BLUFOR wins
		//if (count (playableUnits select {!isObjectHidden _x && side _x == resistance}) == 0) exitWith {[[], {"west" call BIS_fnc_endMission}] remoteExec ["spawn", 0]};  //-- All RESISTANCE dead, BLUFOR wins
	};
};