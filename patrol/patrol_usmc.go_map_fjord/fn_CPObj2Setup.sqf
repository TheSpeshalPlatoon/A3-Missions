_vehType = "Land_DataTerminal_01_F";
_allBuildings = BIS_CP_targetLocationPos nearObjects ["Building", BIS_CP_radius_core];
_allUsableBuildings = _allBuildings select {count (_x buildingPos -1) > 4};
_objBuilding = selectRandom _allUsableBuildings;
_buldingPosArr = _objBuilding buildingPos -1;
_buildingPos = _buldingPosArr select floor random count _buldingPosArr;
_tgt = createVehicle [_vehType, _buildingPos, [], 0, "CAN_COLLIDE"];
_tgt setPosATL _buildingPos;
_tgt setDir (direction _objBuilding) - 90;
//_tgt setPosATL ((getPosATL _tgt) vectorAdd [0,0,-((position _tgt) select 2)]);
_tgt2 = "Land_Laptop_unfolded_scripted_F" createVehicle position _tgt;
_tgt2 setPosATL ((getPosATL _tgt) vectorAdd [0,0,0.48]);
_tgt2 setDir direction _tgt;
_tgt2 enableSimulationGlobal FALSE;
missionNamespace setVariable ["BIS_comms", _tgt2, TRUE];

_null = _tgt2 spawn {
	sleep 10;
	_this addEventHandler ["Hit", {(_this select 0) setDamage 1; (_this select 0) removeAllEventHandlers "Hit"; (_this select 0) setObjectTextureGlobal [0, "A3\Modules_F_MP_Mark\Objectives\images\BrokenLaptopMonitor2.paa"]}];
};

_antenna = "Land_TTowerSmall_1_F" createVehicle [100,100,0];
_pos = position _objBuilding;
_pos vectorAdd [-2 + random 4, -2 + random 4, 0];
_pos set [2, 100];
_antenna setPosATL _pos;
_zDiff = ((getPosATL _antenna) select 2) - ((position _antenna) select 2);
_pos set [2, (abs _zDiff) + 2.25];
_antenna setPosATL _pos;

_allBuildings = BIS_comms nearObjects ["Building", 50];
_allUsableBuildings = _allBuildings select {count (_x buildingPos -1) > 4 && !(_x getVariable ["BIS_occupied", FALSE])};
_allUsableBuildings = _allUsableBuildings - [_objBuilding];
_allUsableBuildings_cnt = count _allUsableBuildings;
_unusedBuildings = +_allUsableBuildings;
_cntIndex = 4 + round random 4;
for [{_i = 1}, {_i <= ceil (_allUsableBuildings_cnt / 2) && _i <= _cntIndex}, {_i = _i + 1}] do {
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
		["        %1 occupied by %2", getText (configFile >> "CfgVehicles" >> typeOf _building >> "displayName"), groupId _newGrp] call BIS_fnc_CPLog;
	};
};