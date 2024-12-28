tsp_ragdoll_currentlyRagdolling = false;

tsp_fnc_ragdollKey = {
	if (!tsp_ragdoll_cba_ragdoll) exitWith {};  //-- Exit if mod disabled
	if (vehicle _this != _this) exitWith {};  //-- Exit if in vehicle
	if (_this getVariable ["ACE_isUnconscious", false]) exitWith {};  //-- Exit if uncon

	_unit = _this call tsp_fnc_getRemoteControlUnit;  //-- If remote controlling in zeus, use that unit
	
	//-- Ragdoll or getup flipflop
	if (tsp_ragdoll_currentlyRagdolling) then {
		//-- Get up if stationary
		if (isTouchingGround _unit && speed _unit < 0.1) then {_unit spawn tsp_fnc_ragdoll_stop};
	} else {
		//-- If running and standing, launch unit
		if (getPosATL _unit#2 < 4.5 && speed _unit > 17 && stance _unit == "STAND") then {
			_unit setVelocityModelSpace [0,(speed _unit)*0.22,4.5];
			[_unit,"amovpercmsprslowwrfldf_amovppnemstpsraswrfldnon"] remoteExec ["switchmove",0];
			sleep 0.6;
		};
		_this spawn tsp_fnc_ragdoll;  //-- Ragdoll unit
	};
};

tsp_fnc_ragdoll = {	
	if (tsp_ragdoll_currentlyRagdolling) exitWith {};  //-- Exit if already ragdolling
	tsp_ragdoll_currentlyRagdolling = true;

	//-- Decide whether to use freefall or collision method
	if (_this call tsp_fnc_isFalling && tsp_ragdoll_cba_freefall) then {_this call tsp_fnc_ragdoll_freefall} else 
	{_this call tsp_fnc_ragdoll_collision};

	sleep 0.5;  //-- Cause blood and sound may be triggered to early (before leaving edge for example)	
	_this spawn tsp_fnc_ragdoll_blood;
	_this spawn tsp_fnc_ragdoll_scream;
	_this spawn tsp_fnc_ragdoll_impact;

	waitUntil {_postionPast = (getPos _this)#1; sleep 1; [_this, _postionPast] call tsp_fnc_ragdoll_shouldStop};  //-- Only do uncon loop when stationaryRAGDOLLSHOULDENDISTRUE
	while {tsp_ragdoll_currentlyRagdolling && alive _this} do {_this call tsp_fnc_ragdoll_unconscious};  //-- Uncon loop
};

tsp_fnc_ragdoll_stop = {
	tsp_ragdoll_currentlyRagdolling = false;
	_oldLifeState = lifeState _this;  //-- Need to watch for life state change later as that rotates playa
	_rightToeBasePos = _this modelToWorld (_this selectionPosition "RightToeBase"); 
	_rightFootPos = _this modelToWorld (_this selectionPosition "RightFoot"); 
	_this setPosASL (getPosASL _this);
	_this setUnconscious false;  //-- If left unconscious, animation may not play immediately
	sleep 0.01;  //-- SetUnconscious command is slow to work its magic
	if (_rightFootPos#2 > _rightToeBasePos#2) then {  //-- Decide whether to do back or belly animation
		_this switchMove "amovppnemstpsnonwnondnon";
	} else {
		if (_oldLifeState == "HEALTHY") then {_this setDir (getDir _this) - 180};  //-- Needed as back animation rotates playa
		_this switchMove "unconsciousOutProne";		
	};
};

tsp_fnc_ragdoll_collision = {
	_allowDmgStore = isDamageAllowed _this;  //-- Save damageAllowed in case unit is supposed to be invincible
	_this allowDamage false;  //-- Prevent damage

	//-- SLAM THAT BOI
	_slammer = "tsp_slammer" createVehicleLocal [0,0,0];
	_slammer attachTo [_this, [0,0,0], "Spine3"];
	_slammer setMass 1e10;
	_slammer setVelocity [0,0,-6];
	detach _slammer;
	sleep 0.1;  //-- Needed to make sure playa gets dropped
	deleteVehicle _slammer;	

	_this allowDamage _allowDmgStore;  //-- Return original value to damageAllowed
};

tsp_fnc_ragdoll_unconscious = {
	_startPos = getPos _this;  //-- Save position before ragdoll to check later
	_this setUnconscious true;
	sleep 3;
	_this setUnconscious false;
	sleep 0.01;
	if (_this distance _startPos > 1 && tsp_ragdoll_currentlyRagdolling) exitWith {_this spawn tsp_fnc_ragdoll_stop};  //-- Check if playa got launnched by the ragdoll
};

tsp_fnc_ragdoll_freefall = {
	_saveVelocity = velocity _this;  //-- Save velocity to set it back later

	//-- Create blocker to stop playa
	_blocker = "tsp_invisibox" createVehicleLocal (position _this); 
	_blocker attachTo [_this, [0,0,-1.8]];
	detach _blocker;

	_this setVelocity [0,0,0];  //-- Stop that boi in his tracks
	sleep 0.05;  //-- Needed to make sure playa gets dropped and doesnt bounce on blocker
	_this setVelocity _saveVelocity;  //-- Return velocity
	_this spawn tsp_fnc_ragdoll_collision;
	sleep 0.01;
	deleteVehicle _blocker;
};

//-- EFFECTS
tsp_fnc_ragdoll_blood = {	
	if (!tsp_ragdoll_cba_blood) exitWith {};
	while {tsp_ragdoll_currentlyRagdolling} do {
		waitUntil {_this call tsp_fnc_getHighestVelocity > 5 || !tsp_ragdoll_currentlyRagdolling};
		waitUntil {isTouchingGround _this || !tsp_ragdoll_currentlyRagdolling};
		if (!tsp_ragdoll_currentlyRagdolling) exitWith {};
		_blood = selectRandom ["BloodSplatter_01_Small_New_F", "BloodSplatter_01_Medium_New_F", "BloodSpray_01_New_F"] createVehicle (getpos _this);
		_blood attachto [_this, [0,0,1]];detach _blood;
		_blood setVehiclePosition [_blood, [], 0, 'CAN_COLLIDE'];
		waitUntil {!isTouchingGround _this || !tsp_ragdoll_currentlyRagdolling};
		sleep 0.5;  //-- To prevent spam
	};
};

tsp_fnc_ragdoll_impact = {
	while {tsp_ragdoll_currentlyRagdolling} do {
		waitUntil {_this call tsp_fnc_getHighestVelocity > 0.01 || !tsp_ragdoll_currentlyRagdolling};
		waitUntil {isTouchingGround _this || !tsp_ragdoll_currentlyRagdolling};
		if (!tsp_ragdoll_currentlyRagdolling) exitWith {};  //-- Prevent sound from playing when getting up
		_sound = selectRandom ["tsp_ragdoll\sounds\impact1.ogg", "tsp_ragdoll\sounds\impact2.ogg", "tsp_ragdoll\sounds\impact3.ogg"];
		playSound3D [_sound, _this];
		waitUntil {!isTouchingGround _this || !tsp_ragdoll_currentlyRagdolling};
		sleep 0.5;  //-- To prevent spam
	};
};

tsp_fnc_ragdoll_scream = {
	if (!tsp_ragdoll_cba_screaming) exitWith {};  //-- Exit if screaming disabled
	_emitter = "tsp_slammer" createVehicle [0,0,0];
	_emitter attachTo [_this, [0,0,0]];	
	_this setRandomLip true;
	_emitter spawn {
		while {!isNull _this} do {
			_randomScream = selectRandom [["scream_long1",8],["scream_long2",18],
				["scream_short1",6],["scream_short2",8],["zeus_loadout",3],["nolodut",3]
			];
			[_this, _randomScream#0] remoteExec ["say3D",0];
			uiSleep (_randomScream#1);
		};
	};
	[_this, _emitter] spawn {
		params ["_unit", "_emitter"];
		waitUntil {!alive _unit || getPosATL _unit#2 < 0.5};
		deleteVehicle _emitter;	
		_unit setRandomLip false;
	};
	waitUntil {_postionPast = (getPos _this)#1; sleep 0.5; [_this, _postionPast] call tsp_fnc_ragdoll_shouldStop};//RAGDOLLSHOULDENDISTRUE
	deleteVehicle _emitter;	
	_this setRandomLip false;
};

tsp_fnc_ragdoll_shouldStop = {
	params ["_unit","_getPosPast"];
	if (
		speed _unit == 0
		&&
		isTouchingGround _unit
		&&
		_unit call tsp_fnc_getHighestVelocity < 0.1
		&& 
		_unit call tsp_fnc_distanceFromSurface < 0.1
		&&
		!(_unit call tsp_fnc_isFalling)
		&&
		(getPos _unit)#1 - _getPosPast < 0.25
		&&
		(getPos _unit)#1 - _getPosPast > -0.25
	) exitWith {true};
	false
};

//--GENERIC FUNCTIONS
tsp_fnc_isFalling = {	
	if (["halofreefall", animationState _this] call BIS_fnc_inString) exitWith {true};
	if (velocity _this#2 < 0 && _this call tsp_fnc_distanceFromSurface > 3) exitWith {true};
	false
};

tsp_fnc_getRemoteControlUnit = {
	_unit = _this;
	if (!isNull (getAssignedCuratorLogic _this)) then {
		_unitsBeingControlled = curatorEditableObjects (getAssignedCuratorLogic _this) select {_x getVariable "bis_fnc_moduleremotecontrol_owner" isEqualTo _this};
		if (count _unitsBeingControlled == 1) then {_unit = _unitsBeingControlled#0};
	};
	_unit
};

tsp_fnc_distanceFromSurface = {
	_intersectVar = lineIntersectsSurfaces [getPosASL _this, getPos _this, _this, objNull, true, 1, "GEOM", "GEOM"];
	if (count _intersectVar > 0) exitWith {(_intersectVar#0#0) distance getPosASL _this};
	getPosATL _this#2;
};

tsp_fnc_getHighestVelocity = {
	_velocity = velocity _this;
	_highestV = 0;
	{if ((0 - _x) > _highestV) then {_highestV = 0 - _x}} forEach [_velocity#0, _velocity#1, _velocity#2];
	_highestV
};

//-- FREEFALL EVENTHANDLER
player addEventHandler ["animChanged", {
	params ["_unit","_anim"];
	if (!tsp_ragdoll_cba_freefall) exitWith {};
	if (getText(configFile >> 'CfgVehicles' >> (backpack _unit) >> 'parachuteClass') != "") exitWith {};  //-- Dont freefall if you have a parachute
	_unit spawn {sleep 0.2;if (_this call tsp_fnc_isFalling) then {_this spawn tsp_fnc_ragdoll}};
}];