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
		if (count (playableUnits select {!isObjectHidden _x && side group _x == west}) == 0) exitWith {[[], {"east" call BIS_fnc_endMission}] remoteExec ["spawn", 0]};  //-- All BLUFOR dead, RESISTANCE wins
		if (count (playableUnits select {!isObjectHidden _x && side group _x == east}) == 0) exitWith {[[], {"west" call BIS_fnc_endMission}] remoteExec ["spawn", 0]};  //-- All EAST dead, BLUFOR wins
		//if (count (playableUnits select {!isObjectHidden _x && side group _x == resistance}) == 0) exitWith {[[], {"west" call BIS_fnc_endMission}] remoteExec ["spawn", 0]};  //-- All RESISTANCE dead, BLUFOR wins
	};
};

while {false} do {
    if (vest player == "C4_belt") then {
		if (isNil "boomboomaction") then {
			boomboomaction = player addAction ["1 Way Trip to Paradise", {
				if (vest player == "C4_belt") then {
					params ["_target", "_caller", "_actionId", "_arguments"];
					_demochage = "DemoCharge_Remote_Ammo_Scripted" createVehicle (getPos _target);  
					_demochage attachto [_target,[0,0,0]]; 
					detach _demochage;
					removeVest _target;
					_demochage setdamage 1;  
					_target setdamage 1;	
					_target removeAction boomboomaction;				
				};
			}];
		};
    } else {        
		if (!isNil "boomboomaction") then {			
			player removeAction boomboomaction;
			boomboomaction = nil;
		};
    };
    sleep 5;
};