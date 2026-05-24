[] spawn {  //-- Client
	waitUntil {time > 5};
	if (side player == east) exitWith {[player, [zone_east], "You are out of bounds!", {[_this, [zone_east]] spawn tsp_fnc_zone_launch}] spawn tsp_fnc_zone};	
	if (side player == west) exitWith {[player, [zone_station], "You cannot leave yet!", {[_this, [zone_station]] spawn tsp_fnc_zone_launch, {isNil "countdown"}}] spawn tsp_fnc_zone};
	if (side player == civilian) exitWith {[player, [zone_civilian], "You cannot leave yet!", {[_this, [zone_civilian]] spawn tsp_fnc_zone_launch}, {isNil "countdown"}] spawn tsp_fnc_zone};
	waitUntil {sleep 1; !isNil "countdown"};
	if (side player == west) exitWith {[player, [zone_west], "You are out of bounds!", {[_this, [zone_west]] spawn tsp_fnc_zone_launch}] spawn tsp_fnc_zone};
};

[] spawn {  //-- Server
	if (!isServer) exitWith {};
	waitUntil {time > 1};
	//[10, 60] spawn tsp_fnc_countDown;
	while {sleep 5; true} do {  //-- Win conditions
		if (count (playableUnits select {!isObjectHidden _x && side group _x == west}) == 0) exitWith {[[], {"east" call BIS_fnc_endMission}] remoteExec ["spawn", 0]};  //-- All BLUFOR dead, RESISTANCE wins
		if (count (playableUnits select {!isObjectHidden _x && side group _x == east}) == 0) exitWith {[[], {"west" call BIS_fnc_endMission}] remoteExec ["spawn", 0]};  //-- All EAST dead, BLUFOR wins
		//if (count (playableUnits select {!isObjectHidden _x && side group _x == west}) == 0) exitWith {[[], {"east" call BIS_fnc_endMission}] remoteExec ["spawn", 0]};  //-- All RESISTANCE dead, OPFOR wins
		if (toiletpaper distance2D getMarkerPos "hideout" < 20) exitWith {[[], {"east" call BIS_fnc_endMission}] remoteExec ["spawn", 0]};  //-- Toilet paper stolen
	};
};

tsp_fnc_toiletpaper = { 
    if (!isServer) exitWith {}; 
    ["The supermarket is being robbed!"] remoteExec ["systemchat", 0]; countdown = 100; publicVariable "countdown";
    while {countdown > 0} do {[[], {if (side player == east) then {systemChat (str countdown+" seconds remaining!")}}] remoteExec ["call", 0];sleep 10; countdown = countdown - 10; publicVariable "countdown"};
	[[], {if (side player == east) then {systemChat "Toilet paper boxed! Load the box in a car, and get to the hideout!"}}] remoteExec ["call", 0];
	toiletpaper attachto [toiletpaper_pos, [0,0,1]]; detach toiletpaper; 
};   
    
cashdesk_action = cashdesk addAction ["Steal all the Toilet Paper", {[cashdesk, cashdesk_action] remoteExec ["removeAction", 0]; [] remoteExec ["tsp_fnc_toiletpaper", 2]}, nil, 1, true, true, "", "side player == east"];