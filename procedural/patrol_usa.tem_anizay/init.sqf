BIS_CP_grpMain = WEST;

BIS_CP_enemySide = EAST;
BIS_CP_enemySideTrigger = "EAST D";
BIS_CP_distance = 2000;

BIS_CP_enemyGrp_sentry = configFile >> "CfgGroups" >> "East" >> "o_tsp_tkm" >> "Infantry" >> "o_tsp_tkm_sentry";
BIS_CP_enemyGrp_fireTeam = configFile >> "CfgGroups" >> "East" >> "o_tsp_tkm" >> "Infantry" >> "o_tsp_tkm_team";
BIS_CP_enemyGrp_rifleSquad = configFile >> "CfgGroups" >> "East" >> "o_tsp_tkm" >> "Infantry" >> "o_tsp_tkm_squad";
BIS_CP_enemyTroops = []; {BIS_CP_enemyTroops pushBack getText (_x >> "vehicle")} forEach ("TRUE" configClasses BIS_CP_enemyGrp_rifleSquad);

BIS_CP_enemyVeh_MRAP = selectRandom ["UK3CB_TKM_O_Hilux_Dshkm","UK3CB_TKM_O_Hilux_Pkm","UK3CB_TKM_O_Hilux_Zu23_Front","UK3CB_TKM_O_Hilux_GMG"];
BIS_CP_enemyVeh_Truck = configFile >> "CfgGroups" >> "East" >> "o_tsp_tkm" >> "Infantry" >> "o_tsp_tkm_atteam";
BIS_CP_enemyVeh_UAV_big = selectRandom ["UK3CB_TKM_O_Pickup_DSHKM","UK3CB_TKM_O_Pickup_M2"];
BIS_CP_enemyVeh_UAV_small = selectRandom ["UK3CB_TKM_O_Datsun_Pkm"];

BIS_CP_enemyVeh_reinf1 = selectRandom ["UK3CB_TKM_O_BMP1","UK3CB_TKM_O_MTLB_KPVT","UK3CB_TKM_O_MTLB_BMP","UK3CB_TKM_O_MTLB_PKT"];
BIS_CP_enemyVeh_reinf2 = selectRandom ["UK3CB_TKM_O_BMP1","UK3CB_TKM_O_MTLB_KPVT","UK3CB_TKM_O_MTLB_BMP","UK3CB_TKM_O_MTLB_PKT"];
BIS_CP_enemyVeh_reinfAir = selectRandom ["UK3CB_TKM_O_T34","UK3CB_TKM_O_T55"];
BIS_CP_supportClasses = ["UK3CB_TKM_O_V3S_Reammo", "UK3CB_TKM_O_V3S_Refuel", "UK3CB_TKM_O_V3S_Repair"];

BIS_CP_HVT = "tsp_tkm_warlord";
BIS_CP_Guard = "tsp_tkm_akm";

tsp_fnc_combatpatrol = {
	// --- parameters input init
	if (count (missionNamespace getVariable ["paramsArray", []]) == 0) then {paramsArray = [1, 1, 0, 0, 0, 10, 2, 0, -1]};
	_parent = missionConfigFile >> "Params";
	_paramsClasses = "TRUE" configClasses _parent;
	_defaults = ["BIS_CP_startingDaytime",-2,"BIS_CP_weather",-2,"BIS_CP_garrison",0,"BIS_CP_reinforcements",0,"BIS_CP_showInsertion",0,"BIS_CP_tickets",20,"BIS_CP_enemyFaction",0,"BIS_CP_locationSelection",0,"BIS_CP_objective",-1];
	{if (_forEachIndex % 2 == 0) then {_class = (_parent >> _x); _i = _paramsClasses find _class; missionNamespace setVariable [_x, if (_i >= 0) then {paramsArray select _i} else {_defaults select (_forEachIndex + 1)}]}} forEach _defaults;

	BIS_CP_preset_garrison = BIS_CP_garrison;
	BIS_CP_preset_reinforcements = BIS_CP_reinforcements;
	BIS_CP_preset_showInsertion = BIS_CP_showInsertion;
	BIS_CP_preset_tickets = BIS_CP_tickets;
	BIS_CP_preset_enemyFaction = BIS_CP_enemyFaction;
	BIS_CP_preset_locationSelection = BIS_CP_locationSelection;
	if (isServer) then {BIS_CP_preset_objective = if (BIS_CP_objective > 0) then {BIS_CP_objective} else {selectRandom [1, 2, 3]}; publicVariable "BIS_CP_preset_objective"} else {waitUntil {!isNil "BIS_CP_preset_objective"}};

	// --- variables init (static)
	_specific_side_friendly = getText (missionConfigFile >> "BIS_CP_customSide_friendly");
	_specific_side_enemy = getText (missionConfigFile >> "BIS_CP_customSide_enemy");

	BIS_CP_initModule = _this select 0;
	BIS_CP_votingTimer = 15;
	BIS_CP_playerSide = if (_specific_side_friendly == "") then {WEST} else {call compile _specific_side_friendly};
	BIS_CP_moreReinforcements = if (BIS_CP_preset_reinforcements == 2) then {TRUE} else {FALSE};
	BIS_CP_lessReinforcements = if (BIS_CP_preset_reinforcements == 0) then {TRUE} else {FALSE};
	BIS_lateJIP = FALSE;
	BIS_CP_protocolSuffix = getText (missionConfigFile >> "BIS_CP_customProtocolSuffix");

	// --- register proper objective-related functions		
	BIS_fnc_CPObjSetup = compile preprocessFileLineNumbers format ["fn_CPObj%1Setup.sqf", BIS_CP_preset_objective];
	BIS_fnc_CPObjSetupClient = compile preprocessFileLineNumbers format ["\A3\Functions_F_Patrol\CombatPatrol\Objectives\fn_CPObj%1SetupClient.sqf", BIS_CP_preset_objective];
	BIS_fnc_CPObjTasksSetup = compile preprocessFileLineNumbers format ["\A3\Functions_F_Patrol\CombatPatrol\Objectives\fn_CPObj%1TasksSetup.sqf", BIS_CP_preset_objective];
	BIS_fnc_CPObjBriefingSetup = compile preprocessFileLineNumbers format ["\A3\Functions_F_Patrol\CombatPatrol\Objectives\fn_CPObj%1BriefingSetup.sqf", BIS_CP_preset_objective];
	BIS_fnc_CPObjHandle = compile preprocessFileLineNumbers format ["A3\Functions_F_Patrol\CombatPatrol\Objectives\fn_CPObj%1Handle.sqf", BIS_CP_preset_objective];
	BIS_fnc_CPObjHeavyLosses = compile preprocessFileLineNumbers format ["A3\Functions_F_Patrol\CombatPatrol\Objectives\fn_CPObj%1HeavyLosses.sqf", BIS_CP_preset_objective];

	if (isServer) then {
		// --- standard initial server settings
		{createCenter _x} forEach [WEST, EAST, RESISTANCE, CIVILIAN];
		EAST setFriend [RESISTANCE, 0];
		RESISTANCE setFriend [EAST, 0];
		WEST setFriend [RESISTANCE, 0];
		RESISTANCE setFriend [WEST, 0];
		missionNamespace setVariable ["BIS_CP_targetLocationID", -1, TRUE];

		waitUntil {count ((playableUnits + switchableUnits) select {isPlayer _x}) > 0};
		
		// --- spawn a copy of the playable group to calculate insertion positions (uneven terrain etc.)
		_slots = playableSlotsNumber BIS_CP_playerSide; BIS_copyGrp = createGroup CIVILIAN;
		for [{_i = 1}, {_i <= _slots}, {_i = _i + 1}] do {_newUnit = BIS_copyGrp createUnit ["B_Soldier_F", [100,100,0], [], 0, "FORM"]; _newUnit stop TRUE; _newUnit allowDamage FALSE};
	} else {
		if (didJIP) then {if (BIS_CP_targetLocationID >= 0) then {BIS_lateJIP = TRUE}};		
		waitUntil {{isNil _x} count ["BIS_CP_targetLocationID"] == 0};
	};

	_terminate = FALSE;

	if !(isDedicated) then {
		waitUntil {sleep 1; !isNull player && isPlayer player};
		if (didJIP) then {player setPosATL (if (leader player == player) then {markerPos "insertion_pos"} else {formationPosition player})};
		if (!BIS_lateJIP && BIS_CP_preset_locationSelection != 1) then {openMap [TRUE, TRUE]};
	};

	if (_terminate) exitWith {["System terminated for %1 (%2) - player not in patrol group", name player, player] call BIS_fnc_CPLog};

	_sampleTimerScope = scriptNull;	_clickEH = -1; _hoverEH = -1; _leaveEH = -1;

	BIS_CP_usableLocationTypes = ["NameVillage", "NameCity", "NameCityCapital"];
	_addedLocations = +allMissionObjects "ModuleCombatPatrol_LocationAdd_F";  // --- register locations added by modules
	_grabbedLocations = "getText (_x >> 'type') in BIS_CP_usableLocationTypes" configClasses (configFile >> "CfgWorlds" >> worldName >> "Names");  // --- register all suitable locations on the map
	BIS_CP_locationArrFinal = [];  // --- compose final locations list
	{
		_location = _x;
		_coords = getArray (_location >> "position");
		_i = -1;
		if (_i >= 0) then {_coords = _newCoords select _i};
		BIS_CP_locationArrFinal pushBack [_coords, getText (_x >> "name"), [0.75, 1, 1.5] select (BIS_CP_usableLocationTypes find getText (_x >> "type"))];
	} forEach _grabbedLocations;

	_locationNameID = 1;
	{
		_locationName = _x getVariable ["BIS_CP_param_locationName", ""];
		if (_locationName == "") then {_locationName = format [localize "STR_A3_combatpatrol_mission_40", _locationNameID]; _locationNameID = _locationNameID + 1} 
		else {if (isLocalized _locationName) then {_locationName = localize _locationName}};
		_pos = position _x; _pos resize 2;
		BIS_CP_locationArrFinal pushBack [_pos, _locationName, _x getVariable ["BIS_CP_param_locationSize", 1]];
	} forEach _addedLocations;

	if (BIS_CP_targetLocationID == -1) then {  // --- skip if already selected (JIP) or random selection is enabled
		if (isServer) then {  // --- register blacklisted azimuths
			BIS_CP_dummyGrps = [];
			{
				_dummy = (createGroup CIVILIAN) createUnit ["Logic", _x select 0, [], 0, "CAN_COLLIDE"];
				_azimuthBlacklistModulesArr = _dummy nearObjects ["ModuleCombatPatrol_LocationAzimuthBlacklist_F", 1000];
				if (count _azimuthBlacklistModulesArr > 0) then {
					_module = _azimuthBlacklistModulesArr select 0;
					_blacklistArr = call compile (_module getVariable "BIS_CP_param_locationAzimuthBlacklist");
					if (typeName _blacklistArr == typeName []) then {_dummy setVariable ["BIS_azimuthBlacklistArr", _blacklistArr]};
				};
				BIS_CP_dummyGrps pushBack group _dummy;
			} forEach BIS_CP_locationArrFinal;
		};
		if (BIS_CP_preset_locationSelection == 1) exitWith {  // --- center map on target location
			if !(isDedicated) then {
				[] spawn {sleep 0.001; titleCut ["", "BLACK FADED", 100]; waitUntil {visibleMap && !isNil "BIS_CP_targetLocationPos"}; mapAnimAdd [0, 0.05, BIS_CP_targetLocationPos]; mapAnimCommit};
			};			
			if (isServer) then {missionNamespace setVariable ["BIS_CP_targetLocationID", floor random count BIS_CP_locationArrFinal, TRUE]} else {waitUntil {BIS_CP_targetLocationID > -1}};
		};
		
		if !(isDedicated) then {
			{  // --- add clickable icons on locations
				_pos = _x select 0;
				waitUntil {count ((_pos nearObjects ["Logic", 10]) select {typeOf _x == "Logic"}) > 0};
				_dummyGrp = group (((_pos nearObjects ["Logic", 10]) select {typeOf _x == "Logic"}) select 0);
				_dummyGrp setVariable ["BIS_CP_locationName", _x select 1];
				_dummyGrp setVariable ["BIS_CP_locationID", _forEachIndex];
				_dummyGrp addGroupIcon ["selector_selectable", [0,0]];
				_dummyGrp setGroupIconParams [[0,0.8,0,1], "", 1, TRUE];
			} forEach BIS_CP_locationArrFinal;
			
			setGroupIconsVisible [TRUE, FALSE];
			setGroupIconsSelectable TRUE;
			
			// --- sound effect on icon hover		
			BIS_CP_currentIconID = -1; _sampleTimerScope = [] spawn {while {BIS_CP_targetLocationID == -1} do {waitUntil {BIS_CP_currentIconID != -1}; playSound "clickSoft"; waitUntil {BIS_CP_currentIconID == -1}}};
			
			// --- location selection UI handle			
			[] spawn {
				_locationsCnt = count BIS_CP_locationArrFinal;
				while {BIS_CP_targetLocationID == -1} do {
					_text = localize "STR_A3_combatpatrol_mission_34";
					if ((missionNamespace getVariable ["BIS_CP_voting_countdown_end", 0]) > 0) then {
						_votesArr = [];
						{_votesArr pushBack (_x getVariable ["BIS_CP_votedFor", -1])} forEach playableUnits;
						_mostVoted = 0;
						_mostVotes = 0;
						for [{_i = 0}, {_i < _locationsCnt}, {_i = _i + 1}] do {_votes = {_x == _i} count _votesArr; if (_votes > _mostVotes) then {_mostVotes = _votes; _mostVoted = _i}};
						_text = _text + "<br/><br/>";
						if ((player getVariable ["BIS_CP_votedFor", -1]) >= 0) then {_text = _text + format [(localize "STR_A3_combatpatrol_mission_35") + ":<br/>%1<br/><br/>", toUpper ((BIS_CP_locationArrFinal select (player getVariable "BIS_CP_votedFor")) select 1)]};
						_text = _text + format [(localize "STR_A3_combatpatrol_mission_36") + ":<br/>%1", toUpper ((BIS_CP_locationArrFinal select _mostVoted) select 1)];
						_timeLeft = ((BIS_CP_voting_countdown_end - daytime) * 3600)*10;
						if (_timeLeft < 0) then {_timeLeft = 0};
						_timeLeft = ceil _timeLeft;
						_text = _text + format ["<br/><br/>" + (localize "STR_A3_combatpatrol_mission_37") + ":<br/>%1", _timeLeft];
					};
					hintSilent parseText _text;
					sleep 0.1;
				};
				hintSilent "";
			};
			
			// --- set up the click action to vote for the assigned location		
			_clickEH = addMissionEventHandler ["GroupIconClick", {
				player setVariable ["BIS_CP_votedFor", (_this select 1) getVariable ["BIS_CP_locationID", -1], TRUE];
				if ((missionNamespace getVariable ["BIS_CP_voting_countdown_end", 0]) == 0) then {missionNamespace setVariable ["BIS_CP_voting_countdown_end", daytime + (BIS_CP_votingTimer / 3600), TRUE]};
				(_this select 1) setGroupIconParams [[0.8,0,0,1], "", 1, TRUE];
				playSound "AddItemOK";
				(_this select 1) spawn {
					waitUntil {(player getVariable ["BIS_CP_votedFor", -1]) != (_this getVariable ["BIS_CP_locationID", -1]) || isNull _this};
					if !(isNull _this) then {_this setGroupIconParams [[0,0.8,0,1], "", 1, TRUE]};
				};
			}];
			
			// --- set up the icon hover action			
			_hoverEH = addMissionEventHandler ["GroupIconOverEnter", {
				BIS_CP_currentIconID = (_this select 1) getVariable ["BIS_CP_locationID", -1];
				if ((player getVariable ["BIS_CP_votedFor", -1]) != BIS_CP_currentIconID) then {(_this select 1) setGroupIconParams [[0,0,0.8,1], "", 1, TRUE]};
			}];
			
			// --- set up the icon leave action			
			_leaveEH = addMissionEventHandler ["GroupIconOverLeave", {
				BIS_CP_currentIconID = -1;
				if ((player getVariable ["BIS_CP_votedFor", -1]) != ((_this select 1) getVariable ["BIS_CP_locationID", -1])) then {(_this select 1) setGroupIconParams [[0,0.8,0,1], "", 1, TRUE]};
			}];
		};
		
		// --- evaluate the most voted for location
		if (isServer) then {
			waitUntil {missionNamespace getVariable ["BIS_CP_voting_countdown_end", 0] > 0};
			if (((BIS_CP_voting_countdown_end - daytime) * 3600) > BIS_CP_votingTimer) then {missionNamespace setVariable ["BIS_CP_voting_countdown_end", daytime + (BIS_CP_votingTimer / 3600), TRUE]};
			waitUntil {daytime >= BIS_CP_voting_countdown_end};
			_votesArr = [];
			{_votesArr pushBack (_x getVariable ["BIS_CP_votedFor", -1])} forEach playableUnits;
			_mostVoted = 0;
			_mostVotes = 0;
			_locationsCnt = count BIS_CP_locationArrFinal;
			for [{_i = 0}, {_i < _locationsCnt}, {_i = _i + 1}] do {_votes = {_x == _i} count _votesArr; if (_votes > _mostVotes) then {_mostVotes = _votes; _mostVoted = _i}};
			missionNamespace setVariable ["BIS_CP_targetLocationID", _mostVoted, TRUE];
		} else {waitUntil {BIS_CP_targetLocationID >= 0}};
	};

	// --- location selected
	BIS_CP_targetLocationPos = (BIS_CP_locationArrFinal select BIS_CP_targetLocationID) select 0;
	BIS_CP_targetLocationName = (BIS_CP_locationArrFinal select BIS_CP_targetLocationID) select 1;
	BIS_CP_targetLocationSize = (BIS_CP_locationArrFinal select BIS_CP_targetLocationID) select 2;

	if !(BIS_lateJIP) then {
		{terminate _x} forEach [_sampleTimerScope];
		removeMissionEventHandler ["GroupIconClick", _clickEH];
		removeMissionEventHandler ["GroupIconOverEnter", _hoverEH];
		removeMissionEventHandler ["GroupIconOverLeave", _leaveEH];
	};

	if (isServer) then {
		waitUntil {(missionNamespace getVariable ["BIS_CP_targetLocationID", -1] != -1)};
		BIS_CP_targetLocationAzimuthBlacklistArr = (leader (BIS_CP_dummyGrps select BIS_CP_targetLocationID)) getVariable ["BIS_azimuthBlacklistArr", []];
		["Location selected: %1", BIS_CP_targetLocationName] call BIS_fnc_CPLog;
	};

	// --- black out
	if !(BIS_lateJIP) then {
		if !(isDedicated) then {if (BIS_CP_preset_locationSelection != 1) then {titleCut ["", "BLACK OUT", 1]}};
		sleep 1;
		if !(isDedicated) then {					
			openMap [FALSE, FALSE];
			if !(isNil "BIS_blackoutHandle") then {terminate BIS_blackoutHandle};
			_null = [format [(localize "STR_A3_combatpatrol_mission_38") + "<br/>%1<br/><br/>" + (localize "STR_A3_combatpatrol_mission_39"), toUpper BIS_CP_targetLocationName], 0, 0.5, 5, 0.5, 0] spawn BIS_fnc_dynamicText;	//TODO: localize
			playSound "RscDisplayCurator_ping05";
		};
		sleep 0.5;
	} else {if (BIS_CP_preset_locationSelection != 1) then {titleCut ["", "BLACK FADED", 100]}};

	_tLoading = time + 5;

	if (isServer) then {
		// --- location areas are scaled based on their config properties
		BIS_CP_radius_insertion = BIS_CP_distance * BIS_CP_targetLocationSize;  //DINOWASHERE
		BIS_CP_radius_core = 200 * BIS_CP_targetLocationSize;
		BIS_CP_radius_reinforcements = BIS_CP_radius_insertion * 1.5;

		BIS_CP_landDirsArr = [BIS_CP_distance, FALSE] call BIS_fnc_CPSafeAzimuths;  // --- identify land (get rid of angles leading into water)
		BIS_CP_landDirsArr_insertion = [BIS_CP_radius_insertion, TRUE] call BIS_fnc_CPSafeAzimuths;  // --- filter usable insertin angles
		BIS_CP_landDirsArr_exfil = [BIS_CP_radius_insertion * 1.5, TRUE] call BIS_fnc_CPSafeAzimuths;  // --- filter usable exfil angles

		BIS_CP_reinf_approach_roads = [];
		for [{_i = 0}, {_i <= 360}, {_i = _i + 1}] do {
			private ["_pos"];
			_pos = [BIS_CP_targetLocationPos, BIS_CP_radius_reinforcements, _i] call BIS_fnc_relPos;
			_roads = (_pos nearRoads 50) select {((boundingBoxReal _x) select 0) distance2D ((boundingBoxReal _x) select 1) >= 25};
			if (count _roads > 0) then {_road = _roads select 0; if ({_x distance _road < 100} count BIS_CP_reinf_approach_roads == 0) then {BIS_CP_reinf_approach_roads pushBackUnique _road}};
		};
		
		// --- pick insertion & exfiltration positions
		_insDir = missionNamespace getVariable ["BIS_forcerInsertionDir", [1] call BIS_fnc_CPPickSafeDir];
		BIS_CP_insertionPos = [BIS_CP_targetLocationPos, BIS_CP_radius_insertion, _insDir] call BIS_fnc_relPos;
		_extDir = [2] call BIS_fnc_CPPickSafeDir;
		BIS_CP_exfilPos = [BIS_CP_targetLocationPos, 600 min (BIS_CP_radius_insertion * 1.5), _extDir] call BIS_fnc_relPos;
		_exfilBuilding = nearestBuilding BIS_CP_exfilPos;
		if !(isNull _exfilBuilding && _exfilBuilding distance BIS_CP_exfilPos < 200 && _exfilBuilding distance BIS_CP_targetLocationPos <= ((BIS_CP_exfilPos distance BIS_CP_targetLocationPos) + 50) && _exfilBuilding distance BIS_CP_targetLocationPos > ((BIS_CP_exfilPos distance BIS_CP_targetLocationPos) - 50)) then {if (_exfilBuilding distance BIS_CP_exfilPos < 200) then {BIS_CP_exfilPos = position _exfilBuilding}};
		
		// --- insertion marker		
		_mrkr = createMarker ["insertion_pos", BIS_CP_insertionPos];
		if (BIS_CP_preset_showInsertion == 1) then {"insertion_pos" setMarkerType "mil_start"; "insertion_pos" setMarkerColor (switch (BIS_CP_playerSide) do {case WEST: {"colorBLUFOR"}; case EAST: {"colorOPFOR"}; case RESISTANCE: {"colorIndependent"}})};
		
		// --- AO marker		
		_mrkr = createMarker ["ao_marker", BIS_CP_targetLocationPos];		
		"ao_marker" setMarkerShape "ELLIPSE";
		"ao_marker" setMarkerSize [BIS_CP_radius_core, BIS_CP_radius_core];
		"ao_marker" setMarkerBrush "SolidBorder";
		"ao_marker" setMarkerColor (switch (BIS_CP_enemySide) do {case WEST: {"colorBLUFOR"}; case EAST: {"colorOPFOR"}; case RESISTANCE: {"colorIndependent"}});
		"ao_marker" setMarkerAlpha 0.25;
		
		// --- prepare insertion position array		
		BIS_finalInsertionPosArr = [];
		BIS_copyGrp setFormDir (BIS_CP_insertionPos getDir BIS_CP_targetLocationPos);
		{
			_pos = if (leader _x == _x) then {BIS_CP_insertionPos} else {formationPosition _x};
			_pos set [2, 0];
			_x setPos (_pos vectorAdd [0,0,100]);
			_zDiff = ((getPosATL _x) select 2) - ((position _x) select 2);
			_pos set [2, abs _zDiff];
			BIS_finalInsertionPosArr pushBack _pos;
		} forEach units BIS_copyGrp;
		{deleteVehicle _x} forEach units BIS_copyGrp;
		deleteGroup BIS_copyGrp;
		
		// --- move the squad to the insertion
		{_pos = BIS_finalInsertionPosArr select _forEachIndex; _x setPosATL _pos; if (_x distance _pos > 10) then {_x setPosATL _pos}; _x allowDamage TRUE} forEach playableUnits;
		
		//-- spawn garrison
		[BIS_CP_enemyGrp_sentry, {random 600}, 12] call BIS_fnc_CPSpawnGarrisonGrp;
		if (BIS_CP_preset_garrison == 0) then {[BIS_CP_enemyGrp_sentry, {random 400}, 6] call BIS_fnc_CPSpawnGarrisonGrp} 
		else {[BIS_CP_enemyGrp_fireTeam, {random 400}, 6] call BIS_fnc_CPSpawnGarrisonGrp};
		if (BIS_CP_preset_garrison == 2) then {[BIS_CP_enemyGrp_rifleSquad, {random 200}, 3] call BIS_fnc_CPSpawnGarrisonGrp};
		
		// --- spawn enemies in buldings
		_allBuildings = BIS_CP_targetLocationPos nearObjects ["Building", BIS_CP_radius_insertion];
		_allUsableBuildings = _allBuildings select {count (_x buildingPos -1) > 2};
		_allUsableBuildings_cnt = count _allUsableBuildings;
		_unusedBuildings = +_allUsableBuildings;
		for [{_i = 1}, {_i <= ceil (_allUsableBuildings_cnt / 2) && _i <= (5*BIS_CP_targetLocationSize)}, {_i = _i + 1}] do {
			_building = selectRandom _unusedBuildings;
			_unusedBuildings = _unusedBuildings - [_building];
			if (_building distance BIS_CP_insertionPos > 250) then {
				_building setVariable ["BIS_occupied", TRUE];
				_buldingPosArr = _building buildingPos -1;
				_newGrp = createGroup BIS_CP_enemySide;
				_unitsCnt = ceil random 4;
				_emptyBuildingPosArr = [];
				{_emptyBuildingPosArr pushBack _forEachIndex} forEach _buldingPosArr;
				for [{_j = 1}, {_j <= _unitsCnt}, {_j = _j + 1}] do {
					_buildingPosID = selectRandom _emptyBuildingPosArr;
					_emptyBuildingPosArr = _emptyBuildingPosArr - [_buildingPosID];
					_buildingPos = _buldingPosArr select _buildingPosID;
					_newUnit = _newGrp createUnit [selectRandom BIS_CP_enemyTroops, _buildingPos, [], 0, "NONE"];
					_newUnit setPosATL _buildingPos;
					_newUnit setUnitPos "UP";
					_newUnit allowFleeing 0;
					doStop _newUnit;
				};
			};
		};
		
		call BIS_fnc_CPObjSetup;  // --- objective server setup	
		
		// --- trigger for players being detected by enemy		
		BIS_CP_detectedTrg = createTrigger ["EmptyDetector", BIS_CP_targetLocationPos, FALSE];
		BIS_CP_detectedTrg setTriggerArea [BIS_CP_radius_insertion, BIS_CP_radius_insertion, 0, FALSE];
		BIS_CP_detectedTrg setTriggerActivation [str BIS_CP_playerSide, BIS_CP_enemySideTrigger, FALSE];  //DINOWaSHERE
		BIS_CP_detectedTrg setTriggerTimeout [5, 5, 5, TRUE];
		BIS_CP_detectedTrg setTriggerStatements ["this", "", ""];
		
		{deleteVehicle leader _x; deleteGroup _x} forEach BIS_CP_dummyGrps;  // --- delete dummy entities
		
		missionNamespace setVariable ["BIS_CP_initDone", TRUE, TRUE]; BIS_missionStartT = time;  // --- location prepared, stop loading
	};

	waitUntil {time > _tLoading && !isNil "BIS_CP_initDone"};

	if !(isDedicated) then {
		player setDir (player getDir BIS_CP_targetLocationPos);
		call BIS_fnc_CPObjSetupClient;		
		player enableSimulation TRUE;
		player setAmmo [currentWeapon player, 1000];
		debuglog format ["DEBUG :: #6 (%1)", name player];
		titleCut ["", "BLACK IN", 1];
		0 fadeSound 0;
		1 fadeSound 1;
	};

	if (isServer) then {
		call BIS_fnc_CPObjTasksSetup;
		[] spawn {  // --- players revealed - send reinforcements based on no. of players
			[{triggerActivated BIS_CP_detectedTrg || (missionNamespace getVariable ["BIS_CP_alarm", FALSE])}, 1] call BIS_fnc_CPWaitUntil;
			deleteVehicle BIS_CP_detectedTrg;
			{_x setBehaviour "COMBAT"; _x setSpeedMode "NORMAL"} forEach (allGroups select {side _x == BIS_CP_enemySide && (leader _x) distance BIS_CP_targetLocationPos <= BIS_CP_radius_insertion});
			if !(missionNamespace getVariable ["BIS_CP_alarm", FALSE]) then {_t = time + 300; [{(missionNamespace getVariable ["BIS_CP_alarm", FALSE]) || time > _t}, 1] call BIS_fnc_CPWaitUntil};  // --- timeout if the objective hasn't been destroyed yet
			_tNextWave = time + 300;			
			[BIS_CP_enemyVeh_UAV_small, 1] call BIS_fnc_CPSendReinforcements;
			[BIS_CP_enemyVeh_MRAP, if (BIS_CP_lessReinforcements) then {1} else {2}] call BIS_fnc_CPSendReinforcements;
			if (BIS_CP_moreReinforcements) then {[BIS_CP_enemyVeh_Truck, 1] call BIS_fnc_CPSendReinforcements};
            [{time > _tNextWave}, 1] call BIS_fnc_CPWaitUntil;				
			_tNextWave = time + 600;			
			[BIS_CP_enemyVeh_UAV_small, 1] call BIS_fnc_CPSendReinforcements;
			if (BIS_CP_moreReinforcements) then {[BIS_CP_enemyVeh_reinfAir, 1] call BIS_fnc_CPSendReinforcements};
			[BIS_CP_enemyVeh_MRAP, if (BIS_CP_lessReinforcements) then {0} else {1}] call BIS_fnc_CPSendReinforcements;
			[BIS_CP_enemyVeh_Truck, 1] call BIS_fnc_CPSendReinforcements;
			[{time > _tNextWave}, 1] call BIS_fnc_CPWaitUntil;			
			[BIS_CP_enemyVeh_UAV_big, 1] call BIS_fnc_CPSendReinforcements;
			[BIS_CP_enemyVeh_MRAP, 1] call BIS_fnc_CPSendReinforcements;
			[BIS_CP_enemyVeh_Truck, if (BIS_CP_lessReinforcements) then {1} else {2}] call BIS_fnc_CPSendReinforcements;
			if (BIS_CP_moreReinforcements) then {[BIS_CP_enemyVeh_reinf2, 1] call BIS_fnc_CPSendReinforcements};
		};
		
		// --- zero casualties handle (AI)
		[] spawn {while {sleep 3; isNil "BIS_CP_death"} do {{if !(alive _x) then {_x spawn {if (!alive _this) then {missionNamespace setVariable ["BIS_CP_death", TRUE, TRUE]}}}} forEach (playableUnits select {!isPlayer _x})}};
		
		// --- zero casaulties task handle
		[] spawn {waitUntil {!isNil "BIS_CP_death"}; if !(["BIS_CP_taskSurvive"] call BIS_fnc_taskCompleted) then {["BIS_CP_taskSurvive", "Failed"] call BIS_fnc_taskSetState}};

		// --- heavy losses handle
		//[] spawn {[{([BIS_CP_grpMain] call BIS_fnc_respawnTickets) <= floor (BIS_CP_preset_tickets / 2)}, 1] call BIS_fnc_CPWaitUntil; call BIS_fnc_CPObjHeavyLosses};
	};

	if !(isDedicated) then {
		call BIS_fnc_CPObjBriefingSetup;
		[] spawn {waitUntil {!alive player}; if !(alive player) then {missionNamespace setVariable ["BIS_CP_death", TRUE, TRUE]}};  // --- zero casualties handle (player)		
		if (!(missionNamespace getVariable ["BIS_CP_objectiveDone", FALSE]) && !(missionNamespace getVariable ["BIS_CP_objectiveFailed", FALSE])) then {  //-- mission start msg
			[] spawn {sleep 1; playSound ((selectRandom ["cp_mission_start_1", "cp_mission_start_2", "cp_mission_start_3"]) + BIS_CP_protocolSuffix)};
		};	
		if (!(missionNamespace getVariable ["BIS_CP_objectiveDone", FALSE]) && !(missionNamespace getVariable ["BIS_CP_objectiveFailed", FALSE])) then {  //-- heavy losses msg
			[] spawn {
				waitUntil {missionNamespace getVariable ["BIS_CP_objectiveFailed", FALSE]}; sleep 1;
				if !(missionNamespace getVariable ["BIS_CP_objectiveTimeout", FALSE]) then {playSound ((selectRandom ["cp_casualties_induced_exfil_1", "cp_casualties_induced_exfil_2", "cp_casualties_induced_exfil_3"]) + BIS_CP_protocolSuffix)};
			};
		};
		if (!(missionNamespace getVariable ["BIS_CP_objectiveDone", FALSE]) && !(missionNamespace getVariable ["BIS_CP_objectiveFailed", FALSE])) then {  //-- objective done msg
			[] spawn {waitUntil {missionNamespace getVariable ["BIS_CP_objectiveDone", FALSE]}; playSound ((selectRandom ["cp_mission_accomplished_1", "cp_mission_accomplished_2", "cp_mission_accomplished_3"]) + BIS_CP_protocolSuffix)};
		};
	};
	
	if (isServer) then {_null = [] spawn {call BIS_fnc_CPObjHandle}};  // --- main objective handle
	
	[] spawn {  // --- mission end handle
		if (isServer) then {
			[{missionNamespace getVariable ["BIS_CP_objectiveDone", FALSE] || missionNamespace getVariable ["BIS_CP_objectiveFailed", FALSE] || !isNil "BIS_CP_missionFail_death"}, 1] call BIS_fnc_CPWaitUntil;
			[{!isNil "BIS_CP_missionFail_death" || ({_x distance BIS_CP_exfilPos < 30 && !isObjectHidden _x} count playableUnits == ({!isObjectHidden _x} count playableUnits) && {!isObjectHidden _x} count playableUnits > 0)}, 1] call BIS_fnc_CPWaitUntil;
			if !(isNil "BIS_CP_missionFail_death") exitWith {if (missionNamespace getVariable ["BIS_CP_objectiveDone", FALSE]) then {missionNamespace setVariable ["BIS_CP_ending", 5, TRUE]} else {missionNamespace setVariable ["BIS_CP_ending", 4, TRUE]}};
			["BIS_CP_taskExfil", "Succeeded"] call BIS_fnc_taskSetState;
			if (isNil "BIS_CP_death") then {["BIS_CP_taskSurvive", "Succeeded"] call BIS_fnc_taskSetState};
			if (missionNamespace getVariable ["BIS_CP_objectiveDone", FALSE]) then {missionNamespace setVariable ["BIS_CP_ending", 1, TRUE]} 
			else {
				if ({isHidden _x} count playableUnits > 0) then {missionNamespace setVariable ["BIS_CP_ending", 3, TRUE]} 
				else {missionNamespace setVariable ["BIS_CP_ending", 2, TRUE]};
			};
		} else {[{(missionNamespace getVariable ["BIS_CP_ending", 0]) > 0}, 1] call BIS_fnc_CPWaitUntil};
		if !(isDedicated) then {setPlayerRespawnTime 9999};
		switch (BIS_CP_ending) do {
			case 1: {playSound ((selectRandom ["cp_exfil_successful_primary_done_1", "cp_exfil_successful_primary_done_2", "cp_exfil_successful_primary_done_3"]) + BIS_CP_protocolSuffix); sleep 3; ["CPEndTotalVictory"] call BIS_fnc_endMission};
			case 2: {playSound ((selectRandom ["cp_exfil_successful_primary_failed_1", "cp_exfil_successful_primary_failed_2", "cp_exfil_successful_primary_failed_3"]) + BIS_CP_protocolSuffix); sleep 3; ["CPEndFullExfil"] call BIS_fnc_endMission};
			case 3: {["CPEndPartialExfil", FALSE] call BIS_fnc_endMission};
			case 4: {["CPEndAllDeadMissionFail", FALSE] call BIS_fnc_endMission};
			case 5: {["CPEndAllDeadMissionSuccess", FALSE] call BIS_fnc_endMission};
		};
	};
};

[arsenal] spawn tsp_fnc_combatpatrol;
if (isServer) then {skipTime (random 24); 0 setOvercast random 1; 0 setFog random 0.2; 0 setRain random 0.7; forceWeatherChange};
waitUntil {sleep 1; !isNil "BIS_CP_initDone"};
if (hasInterface) then {[false] call tsp_fnc_role};
if (isServer) then {sleep 1; arsenal setPos (getPos (playableUnits#0))};
if (isServer) then {garage setPos ([arsenal, 2, 30, 3, 0, 90, 0] call BIS_fnc_findSafePos)};