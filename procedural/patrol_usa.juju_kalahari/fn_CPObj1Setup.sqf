//BIS_CP_supportClasses = switch (BIS_CP_enemySide) do {
//	case WEST: {["B_Truck_01_ammo_F", "B_Truck_01_fuel_F", "B_Truck_01_Repair_F"]};
//	case EAST: {["O_Truck_03_ammo_F", "O_Truck_03_fuel_F", "O_Truck_03_repair_F"]};
//	case RESISTANCE: {["I_Truck_02_ammo_F", "I_Truck_02_fuel_F", "I_Truck_02_box_F"]};
//};

_roads = BIS_CP_targetLocationPos nearRoads BIS_CP_radius_core;
_pos = [];
_dir = 0;
_vehType = BIS_CP_supportClasses select 1;
if (count _roads > 0) then {
	_road = selectRandom _roads;
	_connectedRoads = roadsConnectedTo _road;
	_pos = position _road;
	if (count _connectedRoads > 0) then {
		_dir = _road getDir ((roadsConnectedTo _road) select 0);
	} else {
		_dir = random 360;
	};
} else {
	_pos = [BIS_CP_targetLocationPos, random BIS_CP_radius_core, random 360] call BIS_fnc_relPos;
	_pos = [_pos, _vehType] call BIS_fnc_CPFindEmptyPosition;
	_dir = random 360;
};
_tgt = createVehicle [_vehType, _pos, [], 0, "CAN_COLLIDE"];
_tgt setDir _dir;
_tgt setVehicleLock "LOCKED";
missionNamespace setVariable ["BIS_CP_objective_vehicle1", _tgt, TRUE];

_roads = (BIS_CP_targetLocationPos nearRoads BIS_CP_radius_core) select {_x distance BIS_CP_objective_vehicle1 > 150};
_pos = [];
_dir = 0;
_vehType = BIS_CP_supportClasses select 0;
if (count _roads > 0) then {
	_road = selectRandom _roads;
	_pos = position _road;
	if (count roadsConnectedTo _road > 0) then {_dir = _road getDir ((roadsConnectedTo _road) select 0)} else {_dir = random 360};
} else {
	_pos = [BIS_CP_targetLocationPos, random BIS_CP_radius_core, random 360] call BIS_fnc_relPos;
	_pos = [_pos, _vehType] call BIS_fnc_CPFindEmptyPosition;
	_dir = random 360;
};
_tgt = createVehicle [_vehType, _pos, [], 0, "CAN_COLLIDE"];
_tgt setDir _dir;
_tgt setVehicleLock "LOCKED";
_tgt addMagazineCargoGlobal ["DemoCharge_Remote_Mag", 2];
missionNamespace setVariable ["BIS_CP_objective_vehicle2", _tgt, TRUE];