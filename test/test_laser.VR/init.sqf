dev_fnc_moveObjectSpooky = {
    params ["_object", "_startObject", "_endObject", "_attachObject", ["_speed", 10], ["_radius", 3]];
    if (!isServer) exitWith {};
	//[_attachObject] spawn dev_fnc_hideUnhide;
    while {alive _object} do {            
		[_this,{  //-- To
    		params ["_object", "_startObject", "_endObject", "_attachObject", ["_speed", 10], ["_radius", 3]];
    		_attachOrientation = [vectorDir _attachObject, vectorUp _attachObject];
			_id = call compile format [
				"addMissionEventHandler ['eachFrame', {
					%4 setPos (getPos %1);
					%4 setVectorDirAndUp %5;
					%1 setVelocityTransformation [
						getPosASL %1,
						(getPosASL %1) vectorAdd (((getPosASL %1) vectorFromTo (getPosASL %3)) vectorMultiply %6),
						[0,0,0], [0,0,0], vectorDir %1, vectorDir %1, vectorUp %1, vectorUp %1, 0.1
					]
				}]",
				_object, _startObject, _endObject, _attachObject, _attachOrientation, _speed
			];
			waitUntil {sleep 0.1; _object distance2D _endObject < 5};  
			removeMissionEventHandler ["eachFrame", _id];
		}] remoteExec ["spawn", 0];

		//(getPosASL _object) vectorAdd (((getPosASL _object) vectorFromTo (getPosASL _endObject)) vectorMultiply _speed)

		waitUntil {sleep 0.1; [getPos _object, _radius] call dev_fnc_killRadius; _object distance2D _endObject < 5};  
        
		[_this,{  //-- From
    		params ["_object", "_startObject", "_endObject", "_attachObject", ["_speed", 10], ["_radius", 3]];
    		_attachOrientation = [vectorDir _attachObject, vectorUp _attachObject];
			_id = call compile format [
				"addMissionEventHandler ['eachFrame', {
					%4 setPos (getPos %1);
					%4 setVectorDirAndUp %5;
					%1 setVelocityTransformation [
						getPosASL %1,
						(getPosASL %1) vectorAdd (((getPosASL %1) vectorFromTo (getPosASL %2)) vectorMultiply %6),
						[0,0,0], [0,0,0], vectorDir %1, vectorDir %1, vectorUp %1, vectorUp %1, 0.1
					]
				}]",
				_object, _startObject, _endObject, _attachObject, _attachOrientation, _speed
			];
			waitUntil {sleep 0.1; _object distance2D _startObject < 5};  
			removeMissionEventHandler ["eachFrame", _id];
		}] remoteExec ["spawn", 0];

		waitUntil {sleep 0.1; [getPos _object, _radius] call dev_fnc_killRadius; _object distance2D _endObject < 5};  
    };  
};

dev_fnc_killRadius = {
	params ["_position", "_radius"];
	{_x setDamage 1} forEach (allPlayers select {_x distance _position < _radius});
};

dev_fnc_hideUnhide = {
	params ["_object", ["_time", 1], ["_chance", 0.3]];
	while {sleep _time; alive _object} do {
		if (random 1 < _chance) then {_object hideObjectGlobal true} else {_object hideObjectGlobal false};
	};
};

[myObject, myStart, myStop, myLaser, 2, 3] spawn dev_fnc_moveObjectSpooky;

//((_object distance _endObject)^2) - ((_object distance2D _endObject)^2)
//[myObject, myStart, myStop, myLaser, 10, 3] spawn dev_fnc_moveObjectSpooky;
//[] spawn {waitUntil {time > 1};[myObject, myStart, myStop, myLaser, 10, 3] spawn dev_fnc_moveObjectSpooky};
//[] spawn {waitUntil {time > 1};[myObject, myStart, myStop, myLaser, 2, 3] spawn dev_fnc_moveObjectSpooky};