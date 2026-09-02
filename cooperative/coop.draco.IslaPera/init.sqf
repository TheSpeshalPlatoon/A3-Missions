tsp_fnc_justmove = {  //-- justfuckinggotothewaypointyouretaredcantbelievebohemiacantevengetthisright
    params ["_vehicle", "_position", ["_brake", false], ["_speed", 20], ["_acceleration", 4], ["_turn", 1], ["_duration", 240], ["_turnU", 1]]; _timeStop = time + _duration;
	(driver _vehicle) disableAI "PATH";
    while {sleep 0.3; alive _vehicle && _vehicle distance2D _position > 7 && time < _timeStop} do {
        if !(isTouchingGround _vehicle || surfaceIsWater position _vehicle) then {continue};

        _vehicle disableBrakes true; _vehicle engineOn true;
        _targetDir = (_vehicle getRelDir _position) + getDir _vehicle;
        _vehicle setVelocityModelSpace [0, (((velocityModelSpace _vehicle)#1) + _acceleration) min _speed, 0.2];
           
        if ([getPos _vehicle, getDir _vehicle, 5, _position] call BIS_fnc_inAngleSector) then {continue};
        if ([getPos _vehicle, getDir _vehicle, 360, _position] call BIS_fnc_inAngleSector) then {_turnU = _turn*5};
        if ([getPos _vehicle, getDir _vehicle, 270, _position] call BIS_fnc_inAngleSector) then {_turnU = _turn*4};
        if ([getPos _vehicle, getDir _vehicle, 180, _position] call BIS_fnc_inAngleSector) then {_turnU = _turn*3};
        if ([getPos _vehicle, getDir _vehicle, 120, _position] call BIS_fnc_inAngleSector) then {_turnU = _turn*2};
        if ([getPos _vehicle, getDir _vehicle, 90, _position] call BIS_fnc_inAngleSector) then {_turnU = _turn*1};
        if ([getPos _vehicle, getDir _vehicle, 50, _position] call BIS_fnc_inAngleSector) then {_turnU = _turn*0.5};
        if ([getPos _vehicle, getDir _vehicle, 10, _position] call BIS_fnc_inAngleSector) then {_turnU = _turn*0.1};
	    [_targetDir - getDir _vehicle, (360 - _targetDir) + getDir _vehicle] params ["_clockwise", "_counterClockwise"];     
        _vehicle setAngularVelocity [0,0,if (_clockwise > _counterClockwise) then {-_turnU} else {_turnU}];
    };    
	if (_brake) then {_vehicle disableBrakes false; sleep 2; _vehicle setVelocityModelSpace [0,0,0]};
	(driver _vehicle) enableAI "PATH";
};

if (!isServer) exitWith {};

[
    West, ["cp"], "Run the checkpoint", "conduct routine checkpoint and ensure no contraband makes it through.",
    "defend", getpos sector, {true}, {(count (allUnits select {_x inArea secure_checkpoint && side _x == East}) < 1)}
] spawn tsp_fnc_task;
[
    West, ["c1"], "Defend Drako", "Cartels have made a bold decision to attack the installation, Defend the facility.",
    "defend", getpos sector_1, 
    {"cp" call BIS_fnc_taskState == "SUCCEEDED"}, {false}, {false}, {triggerActivated myTrigga},
    {["drako_attacked"] spawn tsp_fnc_sector_load;}
] spawn tsp_fnc_task;
[
    west, ["boat"], "Chase the Boats!", "The cartels have taken back their contraband caches and chemical bombs. Stop the boats without blowing them up if possible.",
    "boat", objnull, {"c1" call BIS_fnc_taskState in ["CANCELED"]}, {!alive boat1 && !alive boat2 && !alive boat3 && !alive boat4}
] spawn tsp_fnc_task;
