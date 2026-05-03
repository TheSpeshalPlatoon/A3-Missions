[] spawn {  //-- Client
	player addEventHandler ["OpticsSwitch", {params ["_unit", "_ads"]; if (_ads) then {[_unit, true] spawn tsp_fnc_ragdoll_start; _unit switchCamera "INTERNAL";}}];
	waitUntil {time > 5};
	if (side player == west) then {[player, [zone_west], "You are out of bounds!", {[_this, [zone_west]] spawn tsp_fnc_zone_launch}] spawn tsp_fnc_zone};
	if (side player == east) then {[player, [zone_east], "You are out of bounds!", {[_this, [zone_east]] spawn tsp_fnc_zone_launch}] spawn tsp_fnc_zone};
	if (side player == resistance) then {[player, [zone_resistance], "You are out of bounds!", {[_this, [zone_resistance]] spawn tsp_fnc_zone_launch}] spawn tsp_fnc_zone};
	systemChat "AIMING DOWN SIGHTS WILL MAKE YOU RAGDOLL!!!";
	ace_medical_disabled = true;  //-- No medical       
};

[] spawn {  //-- Server
	if (!isServer) exitWith {};
	waitUntil {time > 1};
	//[10, 60] spawn tsp_fnc_countDown;
	while {sleep 5; true} do {  //-- Win conditions
		if (count (playableUnits select {!isObjectHidden _x && side group _x == west}) == 0) exitWith {[[], {"east" call BIS_fnc_endMission}] remoteExec ["spawn", 0]};  //-- All BLUFOR dead, RESISTANCE wins
		if (count (playableUnits select {!isObjectHidden _x && side group _x == east}) == 0) exitWith {[[], {"west" call BIS_fnc_endMission}] remoteExec ["spawn", 0]};  //-- All EAST dead, BLUFOR wins
		//if (count (playableUnits select {!isObjectHidden _x && side _x == resistance}) == 0) exitWith {[[], {"west" call BIS_fnc_endMission}] remoteExec ["spawn", 0]};  //-- All RESISTANCE dead, BLUFOR wins
	};
};

[] spawn {
	if (!isServer) exitWith {};
	sleep (60*5);
	["RPGs are now available!"] remoteExec ["systemChat", 0];
	box1 addItemCargoGlobal ["rhs_weap_rpg7", 5];
	box2 addItemCargoGlobal ["rhs_weap_rpg7", 5];
	box1 addItemCargoGlobal ["rhs_rpg7_PG7VL_mag", 50];
	box2 addItemCargoGlobal ["rhs_rpg7_PG7VL_mag", 50];
};