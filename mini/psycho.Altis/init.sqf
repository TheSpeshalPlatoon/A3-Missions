psy_fnc_civilian = {
	params ["_location"];
	_unit = (createGroup civilian) createUnit ["C_man_1", _location, [], 0, "NONE"]; [_unit] call psy_fnc_identity;
	_unit spawn {sleep 2; if (!isNil "ace_medical_treatment_fnc_fullHeal") then {[_this, _this] call ace_medical_treatment_fnc_fullHeal}; _this setDamage 0};  //-- Cause sometimes that take damage
	_unit
};

psy_fnc_identity = {
	params ["_unit", ["_items", uniformItems (_this#0)]];
	[_unit, selectRandom ["GreekHead_A3_1","GreekHead_A3_02","GreekHead_A3_03","GreekHead_A3_04","GreekHead_A3_05"]] remoteExec ["setFace", 0];
	_unit addUniform selectRandom ["U_C_Poloshirt_redwhite","U_C_Poloshirt_stripped","U_C_Poloshirt_tricolour","U_C_Poloshirt_blue","U_C_Poloshirt_burgundy"];
	{_unit addItemToUniform _x} forEach _items;
};

psy_fnc_movement = {
	params ["_unit", "_zone"];
	while {alive _unit} do {
		(group _unit) setBehaviour "CARELESS";
		(group _unit) setSpeedMode "LIMITED";
		(group _unit) move ([_zone] call BIS_fnc_randomPosTrigger);
		sleep 30;
	};
};

//-- CLIENT
[] spawn {
	waitUntil {sleep 1; !isNil "psy_unit"};
	player addEventHandler ["Killed", {["Initialize", [player, [], false, true, true, true, true, true, true, true]] call BIS_fnc_EGSpectator}];
	[player, [psy_zone], "You are out of bounds!", {[_this, [psy_zone]] spawn tsp_fnc_zone_launch}, {alive psy_witness1 || alive psy_witness2 || alive psy_witness3}] spawn tsp_fnc_zone;
	if (side group player == civilian) then {[player] call psy_fnc_identity};
	if (player == psy_unit) then {  //-- Jaiy
		{createMarkerLocal [str _x, position _x]; (str _x) setMarkerTypeLocal "mil_triangle"; (str _x) setMarkerColorLocal "ColorYellow"} forEach [psy_switch1, psy_switch2, psy_switch3];
		sleep 8; ["", "Hide among the civilians and eliminate all the witnesses."] spawn BIS_fnc_showSubtitle;
		sleep 8; ["", "After all witnesses are dead, escape the scene."] spawn BIS_fnc_showSubtitle;
		sleep 8; ["", "Do not attempt to escape until all witnesses are dead!"] spawn BIS_fnc_showSubtitle;
		_witnessMarkers = [];	
		while {sleep 1; alive psy_witness1 || alive psy_witness2 || alive psy_witness3} do {
			{deleteMarker _x} forEach _witnessMarkers; _witnessMarkers = [];
			{
				createMarkerLocal [str _x, position _x];
				(str _x) setMarkerTypeLocal "mil_dot";
				(str _x) setMarkerColorLocal "ColorEAST";
				_witnessMarkers pushBack str _x;
			} forEach ([psy_witness1, psy_witness2, psy_witness3] select {alive _x});
		};
		{deleteMarker _x} forEach _witnessMarkers;
		{_x setVehicleLock "UNLOCKED"} forEach (vehicles inAreaArray psy_zone);
		["", "Escape!"] spawn BIS_fnc_showSubtitle;
	};
	if (side group player == west) then {  //-- Detectives
		_random = round (random 8 max 1); [player, "Acts_AidlPercMstpSloWWpstDnon_warmup_"+str _random+"_loop"] remoteExec ["switchMove"];
		["tsp_melee_damageMan", {params ["_unit", "_victim"]; _victim setDamage 1; if (_victim != psy_unit) then {_unit setDamage 1}}] call CBA_fnc_addEventHandler;
		sleep 8; ["", "Find 'TTV/VerifiedPsycho' among the civilians before he kills all the witnesses and escapes."] spawn BIS_fnc_showSubtitle;
		sleep 8; ["", "If you shoot a innocent civilian, you will die!"] spawn BIS_fnc_showSubtitle;
		waitUntil {!isNil "psy_start"}; [player, "Acts_AidlPercMstpSloWWpstDnon_warmup_"+str _random+"_out"] remoteExec ["switchMove"];
		["ACE3 Common", "ace_medical_gui_openMedicalMenuKey", "Medical Menu", {systemChat "Medical menu disabled"}, {}, [150, [false, false, false]], false, 0] call CBA_fnc_addKeybind;
		["ACE3 Common", "ace_interact_menu_InteractKey", "Interact", {
			if (count (allUnits select {side group _x == civilian && _x distance player < 5}) > 0) exitWith {[0] call ACE_interact_menu_fnc_keyUp; systemChat "Interact disabled near civilians"};
			[0] call ACE_interact_menu_fnc_keyDown;
		},{[0] call ACE_interact_menu_fnc_keyUp},[219, [false, false, false]], false] call CBA_fnc_addKeybind;
		while {sleep 0.1; alive player} do {if (count (allUnits select {side group _x == civilian && _x distance player < 5}) > 0) then {[0] call ACE_interact_menu_fnc_keyUp}};
	};
};

//-- SERVER
if (isServer) then {
	addMissionEventHandler ["EntityKilled", {  //-- Any time something dies
		params ["_killed", "_killer", "_instigator"];
		if (side _killer == west && !isPlayer _killed) then {_killer spawn {sleep 4; _this setDamage 1}; [player, "Acts_Stunned_Unconscious"] remoteExec ["switchMove"]};
		if (_killed == psy_unit) then {["WIN"] remoteExec ["BIS_fnc_endMission"]};             //-- If psy_unit is killed, game is won
		if (_killed == psy_unit) then {[player, "Acts_Dance_02"] remoteExec ["switchMove"]};  //-- If psy_unit is killed, game is won
		if (_killed == psy_witness1 || _killed == psy_witness2 || _killed == psy_witness3) then {  //-- If witnesses killed, then:
			"F_20mm_Red" createvehicle ([getPos _killed select 0, getPos _killed select 1, 25]);  //-- Launch flare
			if (count ([psy_witness1, psy_witness2, psy_witness3] select {alive _x}) > 0) exitWith {["", "A witness has been killed!"] remoteExec ["BIS_fnc_showSubtitle", 0]};
			["", "All witnesses are dead, VerifiedPsycho is trying to escape!"] remoteExec ["BIS_fnc_showSubtitle", 0];
		};
	}];
	psy_witness1 = [[psy_zone] call BIS_fnc_randomPosTrigger] call psy_fnc_civilian; publicVariable "psy_witness1";
	psy_witness2 = [[psy_zone] call BIS_fnc_randomPosTrigger] call psy_fnc_civilian; publicVariable "psy_witness2";
	psy_witness3 = [[psy_zone] call BIS_fnc_randomPosTrigger] call psy_fnc_civilian; publicVariable "psy_witness3";
	for "_i" from 1 to 25 do {[[[psy_zone] call BIS_fnc_randomPosTrigger] call psy_fnc_civilian, psy_zone] spawn psy_fnc_movement};  //-- Create NPC civilians
	waitUntil {sleep 1; !isNil "psy_unit"}; _startPos = getPos psy_unit; 
	waitUntil {sleep 1; time > 30 || psy_unit distance _startPos > 10}; psy_start = true; publicVariable "psy_start";
	waitUntil {sleep 1; psy_unit distance psy_zone > 150}; ["LOSE"] remoteExec ["BIS_fnc_endMission"]; 
	{[_x, "Acts_Stunned_Unconscious"] remoteExec ["switchMove"]} forEach (allUnits select {side _x == west});
};
