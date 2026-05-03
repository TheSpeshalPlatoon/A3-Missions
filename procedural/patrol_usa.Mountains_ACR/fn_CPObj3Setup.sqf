_roads = (BIS_CP_targetLocationPos nearRoads BIS_CP_radius_core) select {count roadsConnectedTo _x > 0};
_pos = [];
_dir = 0;
_vehType = BIS_CP_enemyVeh_MRAP;
if (count _roads > 0) then {
	_road = selectRandom _roads;
	_pos = position _road;
	if (count roadsConnectedTo _road > 0) then {_dir = _road getDir ((roadsConnectedTo _road) select 0)} else {_dir = random 360};
} else {
	_pos = [BIS_CP_targetLocationPos, random BIS_CP_radius_core, random 360] call BIS_fnc_relPos;
	_pos = [_pos, _vehType] call BIS_fnc_CPFindEmptyPosition;
	_dir = random 360;
};
BIS_HVTVehicle = createVehicle [_vehType, _pos, [], 0, "CAN_COLLIDE"];
BIS_HVTVehicle setDir _dir;
BIS_HVTVehicle setVehicleLock "LOCKED";

_HVTGrp = createGroup BIS_CP_enemySide;

_pos = [_pos, 50 + random 100, _pos getDir BIS_CP_targetLocationPos] call BIS_fnc_relPos;

BIS_HVT = _HVTGrp createUnit [BIS_CP_HVT, _pos, [], 0, "FORM"];
_guard1 = _HVTGrp createUnit [BIS_CP_Guard, _pos, [], 0, "FORM"];
_guard2 = _HVTGrp createUnit [BIS_CP_Guard, _pos, [], 0, "FORM"];

{
	_x setSpeedMode "LIMITED";
	_x setBehaviour "SAFE";
} forEach units _HVTGrp;

_newWP = _HVTGrp addWaypoint [_pos, 0];
_newWP = _HVTGrp addWaypoint [_pos, 100];
_newWP = _HVTGrp addWaypoint [_pos, 100];
_newWP = _HVTGrp addWaypoint [_pos, 100];
_newWP = _HVTGrp addWaypoint [_pos, 100];
_newWP = _HVTGrp addWaypoint [_pos, 0];
_newWP setWaypointType "CYCLE";

_areaMrkr = createMarker ["BIS_HVTRad", _pos];
"BIS_HVTRad" setMarkerShape "ELLIPSE";
"BIS_HVTRad" setMarkerSize [100,100];
"BIS_HVTRad" setMarkerBrush "SolidBorder";
"BIS_HVTRad" setMarkerColor (if (BIS_CP_enemySide == EAST) then {"colorOPFOR"} else {"colorIndependent"});
"BIS_HVTRad" setMarkerAlpha 0.45;

_neighbor = [0,0,0];

{
	_pos = _x select 0;
	if (_pos distance BIS_CP_targetLocationPos > 500 && _pos distance BIS_CP_targetLocationPos < (_neighbor distance BIS_CP_targetLocationPos)) then {
		_neighbor = _pos;
	};
} forEach BIS_CP_locationArrFinal;

_escapeMrkr = createMarker ["BIS_HVTEscape", _neighbor];
"BIS_HVTEscape" setMarkerColor (if (BIS_CP_enemySide == EAST) then {"colorOPFOR"} else {"colorIndependent"});
"BIS_HVTEscape" setMarkerType "mil_end";

BIS_escapeRoute = _neighbor;