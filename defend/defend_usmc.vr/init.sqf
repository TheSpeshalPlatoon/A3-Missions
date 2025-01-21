tsp_fnc_defend_select = {
	params ["_center"];
	if !(isServer || serverCommandAvailable "#kick") exitWith {systemChat "Only Admin can select position."};
	[player, _center] remoteExec ["setPos", 0];	[_center] remoteExec ["tsp_fnc_defend", 2];
	[""] remoteExec ["onMapSingleClick", 0]; [[false, false]] remoteExec ["openMap", 0];
	tsp_defend_start = true; publicVariable "tsp_defend_start";
	[[side group player, "PAPA_BEAR"], "Enemies are moving quick on your location! Fortify the area and get ready to hold!"] remoteExec ["sideChat"]; sleep 3;
	[[side group player, "PAPA_BEAR"], "You have approximately 3 minutes before they arrive!"] remoteExec ["sideChat"];
	_arsenal = createVehicle ["CargoNet_01_box_F", [_center#0, _center#1, 100], [], 0, "FLY"];
	[objnull, _arsenal] call BIS_fnc_curatorobjectedited;
	[_arsenal, "Arsenal"] call tsp_fnc_action; sleep 180; _arsenal setDamage 1;
};

tsp_fnc_defend = {
	params ["_center", ["_rounds", 5], ["_round", 0]];
	while {sleep 60; _round <= _rounds && count (playableUnits select {alive _x && !isObjectHidden _x}) > 0} do {
		systemChat ("Round " + str _round + " starting.");
		for "_i" from 0 to (tsp_defend_arti#0) do {
			_position = [_center, 10, 100, 5, 0, 90, 0, [], [0,0,0]] call BIS_fnc_findSafePos;
			_arti = createVehicle [selectRandom (tsp_defend_arti#1), [_position#0, _position#1, 500], [], 0, "NONE"]; 
			_arti setVectorDirandUp [[0,0,-1], [0.1,0.1,1]]; _arti setVelocity [0,0,-100];
			sleep 2;
		};
		{  //-- For each item in faction
			_x params ["_required", "_minimum", "_increment", "_units"];
			if (_round < _required) then {continue};
			for "_i" from 0 to (round (_minimum + (_increment * (_round - _required)))) do {  //-- Create x groups based on _base and _increment
				_group = createGroup tsp_defend_side; _position = [_center, 500, 700, 5, 0, 45, 0, [], [0,0,0]] call BIS_fnc_findSafePos;
				{
					if (_x isKindOf "CAManBase") then {_unit = _group createUnit [_x, _position, [], 1, "NONE"]; units _group doMove _center} 
					else {_vehicle = createVehicle [_x, _position, [], 0, "NONE"]; createVehicleCrew _vehicle; _vehicle doMove _center; _vehicle forceSpeed 4};
				} forEach _units;  //-- For each unit in group
			};
		} forEach tsp_defend_faction;
		waitUntil {sleep 5; count (allUnits select {side group _x == tsp_defend_side}) < 3 || count (playableUnits select {alive _x && !isObjectHidden _x}) == 0};
		systemChat ("Round " + str _round + " complete.");
		_round = _round + 1;
	};
	_message = if (count (playableUnits select {alive _x && !isObjectHidden _x}) == 0) then {"This is HQ to any unit, does anybody copy?"} else {"Seems like that's the last of them, good job!"};
	[if (count (playableUnits select {alive _x && !isObjectHidden _x}) == 0) then {"WIN"} else {"LOSE"}] remoteExec ["BIS_fnc_endMission"];
	[[side group player, "PAPA_BEAR"], _message] remoteExec ["sideChat"]; 
};

tsp_defend_arti = [6, ["Smoke_120mm_AMOS_White", "Sh_82mm_AMOS", "Sh_82mm_AMOS"]];
tsp_defend_side = east;
tsp_defend_faction = [  //-- Required, minimum, increment, group
	[0, 1, 0, ["rhs_vdv_recon_marksman_asval","rhs_vdv_recon_sergeant","rhs_vdv_recon_rifleman_lat","rhs_vdv_recon_arifleman_rpk"]],
	[1, 1, 1, ["rhs_vdv_rifleman","rhs_vdv_grenadier","rhs_vdv_RShG2","rhs_vdv_grenadier_rpg","rhs_vdv_sergeant","rhs_vdv_marksman","rhs_vdv_machinegunner","rhs_vdv_machinegunner_assistant"]],
	[2, 1, 0, ["rhs_btr80a_vdv"]],	[3, 1, 0, ["rhs_btr80_vdv"]],
	[3, 1, 0, ["rhs_bmp2d_vdv"]],	[4, 1, 0, ["rhs_bmp2k_vdv"]],
	[4, 1, 0, ["rhs_t72ba_tv"]], [5, 1, 0, ["rhs_t80u"]],
	[5, 1, 0, ["RHS_Mi24V_vdv"]]
];


[] spawn {
	waitUntil {!isNull (findDisplay 46)};
	[true] call tsp_fnc_role;  //-- Wait until role selector is closed
	if !(isNil "tsp_defend_start") exitWith {};  //-- If location already selected
	openMap [true, false]; onMapSingleClick {[_pos] spawn tsp_fnc_defend_select};
	[side (playableUnits#0), 2000, [
        ["Land_Razorwire_F", 50],
        ["Land_BagFence_Corner_F", 50],
        ["Land_BagFence_End_F", 50],    
        ["Land_BagFence_Long_F", 100],    
        ["Land_BagFence_Round_F", 100],
        ["Land_BagFence_Short_F", 50],
        ["CamoNet_BLUFOR_open_F", 100],
        ["Land_CzechHedgehog_01_old_F", 20],
        ["Land_Barricade_01_4m_F", 50],    
        ["Land_Barricade_01_10m_F", 150],
        ["Land_SandbagBarricade_01_half_F", 100],
        ["Land_SandbagBarricade_01_F", 150],
        ["Land_SandbagBarricade_01_hole_F", 150],
        ["Land_HBarrier_3_F", 100],
        ["Land_HBarrier_5_F", 200],
        ["Land_HBarrier_1_F", 50],
        ["Land_ConcreteHedgehog_01_F", 50],
        ["Land_DragonsTeeth_01_1x1_old_F", 50],
        ["Land_DragonsTeeth_01_4x2_old_F", 400],
        ["Land_BagBunker_Small_F", 500]
	]] call acex_fortify_fnc_registerObjects;
};
