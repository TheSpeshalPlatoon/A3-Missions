[] spawn {  //-- Client
	[false, true] call acre_api_fnc_setupMission;
	if (!isNil "svs_start") exitWith {[player, true] remoteExec ["hideObjectGlobal", 2]; ["Initialize", [player, [], false, true, true, true, true, true, true, true]] call BIS_fnc_EGSpectator};
	cutText ["Waiting for players...", "BLACK OUT", 0.001];  //-- Start with black screen
	waitUntil {!isNil "svs_start"};
	cutText ["", "BLACK IN", 1];
	[player, [zone_player], "You are out of bounds!", {[_this, [zone_player]] spawn tsp_fnc_zone_launch}, {alive _this}, 15] spawn tsp_fnc_zone;
	player addMPEventHandler ["MPRespawn", {[player, true] remoteExec ["hideObjectGlobal", 2]}];  //-- Hide new body
};

if (isServer) then {  //-- Server
	waitUntil {time > 15};

	_spawns = allMissionObjects "Land_HelipadEmpty_F";
	_allGroupsWithPlayers = [];	{_allGroupsWithPlayers pushBackUnique group _x} forEach allPlayers;
	{_spawn = selectRandom _spawns; _spawns deleteAt (_spawns find _spawn); {_x setPos getPos _spawn} forEach (units _x)} forEach _allGroupsWithPlayers;
	svs_start = true; publicVariable "svs_start";

	sleep (60*5);
	["The zone has started shrinking!"] remoteExec ["systemChat"];

	_size = (triggerArea zone_player)#0;
	_final = 100;
	_duration = 10;
	_step = (_size - _final)/((_duration-(_duration/2))*60);
	[_duration, 0] spawn tsp_fnc_countDown;

	while {sleep 1; true} do {
		if (_size > _final && time > (_duration/2)*60) then {_size = _size - _step};
		"zone_player_mrk" setMarkerSize [_size, _size];
		[zone_player, [_size, _size, 0, false]] remoteExec ["setTriggerArea", 0];

		_aliveTeams = [];
		{_aliveTeams pushBackUnique (_x getVariable "Team")} forEach (playableUnits select {!isObjectHidden _x});
		if (count _aliveTeams == 1) exitWith {[(_aliveTeams#0), {if (player getVariable "Team" == _this) then {"WIN"} else {"LOSE"} call BIS_fnc_endMission}] remoteExec ["call", 0]};
	};
};