tsp_fnc_defend_select = {
	params ["_center"];
	if !(isServer || serverCommandAvailable "#kick") exitWith {systemChat "Only Admin can select position."};
	systemChat "Position selected.";
	{_x setPos _center} forEach playableUnits;
	[""] remoteExec ["onMapSingleClick", 0]; [[false, false]] remoteExec ["openMap", 0];
	tsp_defend_start = true; publicVariable "tsp_defend_start";
	_arsenal = createVehicle ["CargoNet_01_box_F", [_center#0, _center#1, 60], [], 0, "NONE"];
	[objnull, _arsenal] call BIS_fnc_curatorobjectedited;
	[_arsenal, "Arsenal"] remoteExec ["tsp_fnc_action"];
	[[side group player, "PAPA_BEAR"], "Enemies are moving quick on your location! Fortify the area and get ready to hold!"] remoteExec ["sideChat"]; sleep 3;
	[[side group player, "PAPA_BEAR"], "You have approximately 3 minutes before they arrive!"] remoteExec ["sideChat"]; sleep 3;
	[[side group player, "PAPA_BEAR"], "An airdrop is inbound on your current location!"] remoteExec ["sideChat"];
	sleep 120; [_arsenal] remoteExec ["removeAllActions"]; [_center] remoteExec ["tsp_fnc_defend", 2];
};

tsp_fnc_defend = {
	params ["_center", ["_rounds", 5], ["_round", 0]];
	while {sleep 30; _round <= _rounds && count (playableUnits select {alive _x && !isObjectHidden _x}) > 0} do {
		systemChat ("Round " + str _round + " starting.");
		{  //-- For each item in faction
			_x params ["_required", "_minimum", "_increment", "_units"];
			if (_round < _required) then {continue};
			for "_i" from 0 to (round (_minimum + (_increment * (_round - _required)))) do {  //-- Create x groups based on _base and _increment
				_group = createGroup tsp_defend_side; _position = [_center, 500, 700, 5, 0, 45, 0, [], [0,0,0]] call BIS_fnc_findSafePos;
				{
					_entity = if (_x isKindOf "CAManBase") then {_group createUnit [_x, _position, [], 1, "NONE"]} else {createVehicle [_x, _position, [], 0, "NONE"]; _group createVehicleCrew _vehicle};
					_entity allowFleeing 0; {_entity disableAI _x} forEach ["AUTOCOMBAT","FSM","RADIOPROTOCOL","COVER","SUPPRESSION"];
					if !(_x isKindOf "CAManBase") then {_entity forceSpeed 4};
				} forEach _units;  //-- For each unit in group
				_group setSpeedMode "FULL";
				_move = _group addWaypoint [_center, 100]; _move setWaypointPosition [_center, -1]; [_group, 0] setWaypointCompletionRadius 30;
				_destroy = _group addWaypoint [_center, 10]; _destroy setWaypointPosition [_center, -1]; _destroy setWaypointType "SAD";
				//{_x doMove _center} forEach units _group;
			};
		} forEach tsp_defend_faction;
		for "_i" from 0 to (tsp_defend_arti#0) do {sleep 2;
			_position = [_center, 10, 100, 5, 0, 90, 0, [], [0,0,0]] call BIS_fnc_findSafePos;
			_arti = createVehicle [selectRandom (tsp_defend_arti#1), [_position#0, _position#1, 500], [], 0, "NONE"]; 
			_arti setVectorDirandUp [[0,0,-1], [0.1,0.1,1]]; _arti setVelocity [0,0,-100];
		};
		waitUntil {sleep 5; count (allUnits select {side group _x == tsp_defend_side}) < 3 || count (playableUnits select {alive _x && !isObjectHidden _x}) == 0};
		if (count (playableUnits select {alive _x && !isObjectHidden _x}) == 0) exitWith {};
		systemChat ("Round " + str _round + " complete."); _round = _round + 1;
	};
	_message = if (count (playableUnits select {alive _x && !isObjectHidden _x}) == 0) then {"This is HQ to any unit, does anybody copy?"} else {"Seems like that's the last of them, good job!"};
	[if (count (playableUnits select {alive _x && !isObjectHidden _x}) == 0) then {"LOSE"} else {"WIN"}] remoteExec ["BIS_fnc_endMission"];
	[[side group player, "PAPA_BEAR"], _message] remoteExec ["sideChat"]; 
};

[] spawn {
	waitUntil {!isNull (findDisplay 46) || time > 0};
	if (isServer) then {skipTime (random 24)}; player addItem "ACE_Fortify";
	if !(isNil "tsp_defend_start") exitWith {[true] call tsp_fnc_spectate};  //-- If location already selected
	systemChat "Shift + click to select a position.";
	openMap [true, false]; onMapSingleClick {if (_shift) then {[_pos] spawn tsp_fnc_defend_select}};
};

tsp_defend_arti = [6, ["Smoke_120mm_AMOS_White", "Sh_82mm_AMOS", "Sh_82mm_AMOS"]];
tsp_defend_side = east;
tsp_defend_faction = [  //-- Required, minimum, increment, group
	[0, 1, 0, ["rhs_vdv_recon_sergeant","rhs_vdv_recon_marksman_asval","rhs_vdv_recon_rifleman_lat","rhs_vdv_recon_arifleman_rpk"]],
	[1, 1, 1, ["rhs_vdv_sergeant","rhs_vdv_rifleman","rhs_vdv_grenadier","rhs_vdv_RShG2","rhs_vdv_grenadier_rpg","rhs_vdv_marksman","rhs_vdv_machinegunner","rhs_vdv_machinegunner_assistant"]],
	[2, 1, 0, ["rhs_btr80a_vdv"]],	[3, 1, 0, ["rhs_btr80_vdv"]],
	[3, 1, 0, ["rhs_bmp2d_vdv"]],	[4, 1, 0, ["rhs_bmp2k_vdv"]],
	[4, 1, 0, ["rhs_t72ba_tv"]], [5, 1, 0, ["rhs_t80u"]],
	[5, 1, 0, ["RHS_Mi24V_vdv"]]
];

[side (playableUnits#0), 1000, [
	["Land_Razorwire_F", 1],
	["Land_BagFence_End_F", 2],
	["Land_BagFence_Corner_F", 5],
	["Land_BagFence_Short_F", 5], 
	["Land_BagFence_Long_F", 10],    
	["Land_BagFence_Round_F", 10],
	["CamoNet_BLUFOR_open_F", 10],
	["Land_CzechHedgehog_01_old_F", 10],
	["Land_Barricade_01_4m_F", 10],    
	["Land_Barricade_01_10m_F", 10],
	["Land_SandbagBarricade_01_half_F", 15],
	["Land_SandbagBarricade_01_F", 20],
	["Land_SandbagBarricade_01_hole_F", 20],
	["Land_HBarrier_1_F", 10],
	["Land_HBarrier_3_F", 30],
	["Land_HBarrier_5_F", 50],
	["Land_CncBarrierMedium_F", 30],
	["Land_CncShelter_F", 30],
	["Land_DragonsTeeth_01_1x1_old_F", 5],
	["Land_DragonsTeeth_01_4x2_old_F", 40],
	["Land_BagBunker_Small_F", 50],
	["Land_BagBunker_Tower_F", 100],
	["Land_BagBunker_Large_F", 200]
]] call acex_fortify_fnc_registerObjects;