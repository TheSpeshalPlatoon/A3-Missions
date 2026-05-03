///Game phasing server and music
//Mission started
sleep 2;
["GetOnTheCars", true, ["Get on the Humvee .50 to start the mission", "Man the .50 cal", "car"] , [5784.63,11310.8,4.55938], "ASSIGNED", 0, true, true, "car", true] call BIS_fnc_setTask;
sleep 2;
waitUntil { 
	if ((count playableUnits >= 1) AND (({isPlayer _x} count crew car_4 + crew car_3 + crew car_2 + crew car_1 + crew heli1 + crew heli2) isEqualTo (count playableUnits))) exitWith {
		[["","BLACK",1]] remoteExec['cutText',0]; 
		[ 
			[["Marka Village, Jubba Valley","<t align = 'center' shadow = '1' size = '1.0'>%1</t><br/>"], 
			["1 hour later","<t align = 'center' shadow = '1' size = '0.7'>%1</t><br/>"]] 
		] remoteExec ['BIS_fnc_typeText',0]; 
		titleFadeOut 1;
		sleep 2;
		["GetOnTheCars", "SUCCEEDED",true] spawn BIS_fnc_taskSetState;
		[["","BLACK IN",2]] remoteExec ['cutText',0];
		{_x lockCargo false} forEach synchronizedObjects car_0;
		car_0 setDir 211;
		car_0 setPos [4568.6,12283.4,0];
		car_1 setDir 211;
		car_1 setPos [4573.47,12289.3,0.000781059];
		car_2 setDir 211;
		car_2 setPos [4577.77,12294.6,0];
		car_3 setDir 211;
		car_3 setPos [4582.34,12301.4,0];
		car_4 setDir 211;
		car_4 setPos [4588.09,12309.4,0.00638676];
		{_x moveInGunner car_1} forEach units playersslots;
		{_x moveInGunner car_2} forEach units playersslots;
		{_x moveInGunner car_3} forEach units playersslots;
		{_x moveInGunner car_4} forEach units playersslots;
		sleep 5;
		["RegroupUN", true, ["One of the trucks got damaged on an ambush, your team needs to secure it and protect the trucks until they can move", "Regroup with the UN convoy", ""] , [3802.24,11071.6,6.91244], "ASSIGNED", 0, true, true, "truck", true] call BIS_fnc_setTask;
		remoteExec ["GameStartedDub"];
		sleep 2;
		PLayMarkaMusic = "Marka" remoteExec ["playmusic"];
		publicVariable "PLayMarkaMusic";
		driver_0 enableAI "move";
		[car_0, Car_0_Path_1] spawn BIS_fnc_UnitPlay;
		sleep 1;
		[car_1, Car_1_Path_1] spawn BIS_fnc_UnitPlay;
		sleep 1;
		[car_2, Car_2_Path_1] spawn BIS_fnc_UnitPlay;
		sleep 1;
		[car_3, Car_3_Path_1] spawn BIS_fnc_UnitPlay;
		sleep 1;
		[car_4, Car_4_Path_1] spawn BIS_fnc_UnitPlay;
		{deleteVehicle _X} forEach synchronizedObjects Un_Soldier_3;
		{deleteVehicle _X} forEach units propUN;
		{deleteVehicle _X} forEach synchronizedObjects delet_1;
		deleteVehicle delet_1;
		{_x spawn SpawnUnit_No_PATH_ambush
		} forEach synchronizedObjects Spawn_Area_abush;
		{_x spawn SpawnUnit_RPG_No_PATH_ambush
		} forEach synchronizedObjects Spawn_Area_abush_RPG;
		sleep 55;
		remoteExec ["Ambushed"];
		true
	};
	false;
};

waitUntil {
 if (triggerActivated CarsComeIn) exitWith {
		remoteExec ["UNconvoyReached"];
		{deleteVehicle _X} forEach synchronizedObjects UN_OP_AREA_START;
		{deleteVehicle _X} forEach synchronizedObjects Spawn_Area_abush;
		{deleteVehicle _X} forEach synchronizedObjects Spawn_Area_abush_RPG;
		sleep 2;
		{_x spawn SpawnUnit_truck
		} forEach synchronizedObjects Spawn_Area_test_truck;
		{_x spawn SpawnUnit
		} forEach synchronizedObjects Spawn_Area_test;
		{_x spawn SpawnUnit_RPG
		} forEach synchronizedObjects Spawn_Area_test_RPG;
		truckRaid_1D enableAI "move";
		techRaidDriver enableAI "move";
		heli1 engineOn true;
		heli2 engineOn true;
		{_x spawn SpawnUnit_No_PATH
		} forEach synchronizedObjects Spawn_Area_Enemy_OP;
		["RegroupUN", "SUCCEEDED",true] spawn BIS_fnc_taskSetState;
		sleep 3;
		["DefendUN", true, ["Repeal the enemy raid on your possition", "Defend the area", ""] , [3763.99,11074,7.16564], "ASSIGNED", 0, true, true, "defend", true] call BIS_fnc_setTask;
		sleep 1;
		missionNamespace setVariable ["PLayMarkaMusic", nil, true];
		Loop = addMusicEventHandler ["MusicStop", {"loop" remoteExec ["playmusic"];}];
		"loop" remoteExec ["playmusic"];
		publicVariable "loop";
		sleep 26;
		{_x spawn SpawnUnit
		} forEach synchronizedObjects Spawn_Area_test;
		[heli1, Path1] spawn BIS_fnc_UnitPlay;
		sleep 4; 
		[heli2, Path2] spawn BIS_fnc_UnitPlay;
	 true};
 false;
 };
 
[] spawn {
sleep 50;
{_x setDammage 1} forEach list raidover select {side group _x isEqualTo east};
};

 waitUntil { 
 if (triggerActivated RaidOver) exitWith {
		["DefendUN", "SUCCEEDED",true] spawn BIS_fnc_taskSetState;
		sleep 2;
		"marker_Enemy_OP" setMarkerAlpha 0.3;
		["ClearTheOP", true, ["The enemy Command post is here, clear the zone of all enemies and Golf-3 will land and extract you", "Clear Enemy Command Post", ""] , [3606.46,11270.5,18.8036], "ASSIGNED", 0, true, true, "attack", true] call BIS_fnc_setTask;
		remoteExec ["AttackOP"];
		{moveOut _x} forEach units playersslots;
		Victor_1_Leader enableAI "move";
		sleep 3;
	true};
 false;
 };
 
waitUntil {
 if (triggerActivated EnemyHQclear) exitWith {
		["ClearTheOP", "SUCCEEDED",true] spawn BIS_fnc_taskSetState;
		remoteExec ["LzClear"];
		"marker_Enemy_OP" setMarkerAlpha 0;
		[heli1, path1land] spawn BIS_fnc_UnitPlay;
		sleep 4; 
		[heli2, path2land] spawn BIS_fnc_UnitPlay;
		sleep 2;
		{_x lockCargo false} forEach synchronizedObjects car_0;
		deleteVehicle repairguy;
		Victor_1_Leader enableAI "move";
		sleep 5;
		["GetInChoper", true, ["Mount up on the minigun and cover the convoy", "Mount up on the Minigun", ""] , heli1, "ASSIGNED", 0, true, true, "heli", true] call BIS_fnc_setTask;
		["GetInCars", true, ["Mount up on the .50 and cover the convoy", "(Optional) Mount back up on the 50 cal", ""] , car_3, "CREATED", 1, true, true, "car", true] call BIS_fnc_setTask;
		true};
 false;
 };
 
waitUntil {
 if (({isPlayer _x} count crew car_4 + crew car_3 + crew car_2 + crew car_1 + crew heli1 + crew heli2) isEqualTo (count playableUnits) AND (count playableUnits >= 1))
	exitWith {
		 {_x lockCargo false} forEach [heli1, heli2];
		 {_x spawn SpawnUnit_No_PATH_ambush 
		} forEach nearestObjects [test_area, ["logic"], 600];
		{_x spawn SpawnUnit_RPG_No_PATH
		} forEach nearestObjects [test_area, ["sign_arrow_f"], 600];
		heli1 land "NONE";
		heli2 land "NONE";
		{_x assignAsCargo UN_TRUCK_2} forEach units victor_1;
		{_x moveInCargo UN_TRUCK_2} forEach units victor_1;
		{_x moveInGunner heli1} forEach units playersslots;
		{_x moveInGunner heli2} forEach units playersslots;
		{_x moveInGunner car_1} forEach units playersslots;
		{_x moveInGunner car_2} forEach units playersslots;
		{_x moveInGunner car_3} forEach units playersslots;
		{_x moveInGunner car_4} forEach units playersslots;
		{_x enableAI "move"} forEach units untrucks;
		units untrucks joinSilent cars;
		{_x enableAI "move"} forEach units cars;
		{_x setFuel 1} forEach [car_0, car_1, car_2, car_3, car_4];
		[car_0, Car_0_Path_2] spawn BIS_fnc_UnitPlay;
		[car_1, Car_1_Path_2] spawn BIS_fnc_UnitPlay;
		[car_2, Car_2_Path_2] spawn BIS_fnc_UnitPlay;
		[car_3, Car_3_Path_2] spawn BIS_fnc_UnitPlay;
		[car_4, Car_4_Path_2] spawn BIS_fnc_UnitPlay;
		[UN_TRUCK_1, UN_TRUCK_1_path_1,[], true, false,false ,0] spawn BIS_fnc_UnitPlay;
		[UN_TRUCK_2, UN_TRUCK_2_path_1,[], true, false,false ,0] spawn BIS_fnc_UnitPlay;
		[heli1, heli1fly] spawn BIS_fnc_UnitPlay;
		[heli2, heli2fly] spawn BIS_fnc_UnitPlay;
		heli1 engineOn true;
		heli2 engineOn true;
		helipilot_1 enableAI "move";
		helipilot_2 enableAI "move";
		//{_x setVehicleLock "LOCKED"} forEach synchronizedObjects car_0;
		//{_x setVehicleLock "LOCKED"} forEach [heli1, heli2];
		sleep 1;
		 remoteExec ["PlayersReady"];
		 removeMusicEventHandler ["MusicStop", Loop];
		 missionNamespace setVariable ["Loop", nil, true];
		 helirideMusic = "heliride" remoteExec ["playmusic"];
		 publicVariable "helirideMusic";
		  sleep 1;
		 ["GetInCars", "SUCCEEDED",true] spawn BIS_fnc_taskSetState;
		  sleep 1;
		 ["GetInChoper", "SUCCEEDED",true] spawn BIS_fnc_taskSetState;
		  sleep 1;
		 ["DefendTrucks", true, ["Cover the convoy back to safety", "Defend the UN trucks", ""] , UN_TRUCK_1, "ASSIGNED", 0, true, true, "defend", true] call BIS_fnc_setTask;
		 sleep 30;
		 remoteExec ["CommandTalkToGolf3"];
	true};
false;
};
 
 waitUntil { if (
triggerActivated win)
exitWith {
["DefendTrucks", "SUCCEEDED",true] spawn BIS_fnc_taskSetState;
{_x spawn SpawnUnit_CIV_No_PATH
} forEach nearestObjects [Cut_Food_guy, ["sign_arrow_f"], 100];
{_x allowdamage false} forEach units playersslots;
{_x setDamage 0} forEach units playersslots;
sleep 1;
remoteExec ["Ending"];
{moveOut _x} forEach units playersslots;
"" remoteExec ["playmusic"]; 
[[], "scene.sqf"] remoteExec ["execVM", 0, true];
sleep 8;
"win" remoteExec ["playmusic"]; 
sleep 3; 
["end_unsafe",true,true,false] remoteExec ["BIS_fnc_endMission"]; 
 true};
 false;
 };

