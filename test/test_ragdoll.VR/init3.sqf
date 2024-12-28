tsp_ragdoll_currentlyRagdolling = false;
	//sleep 1;  
tsp_fnc_ragdoll = {
	if (tsp_ragdoll_currentlyRagdolling) exitWith {};
	tsp_ragdoll_currentlyRagdolling = true;
	if (_this call tsp_fnc_isFalling) then {
		systemChat "WEFALLING";
		_this call tsp_fnc_ragdoll_blocker;		
	} else {
		_this call tsp_fnc_ragdoll_collision;
	};
	sleep 0.5;  //-- Cause blood and sound may be triggered to early (before leaving edge for example)
	_this spawn tsp_fnc_ragdoll_blood;
	_this spawn tsp_fnc_ragdoll_scream;
	_this spawn tsp_fnc_ragdoll_impact;
	sleep 6;  //-- Cause collision method lasts a good amount of time, so no need to loop uncon yet
	waitUntil {isTouchingGround _this && !([_this,0.05] call tsp_fnc_getVelocityMoreThan)};  //-- Only do uncon loop when stationary
	while {tsp_ragdoll_currentlyRagdolling && speed _this < 1 && alive _this} do {_this call tsp_fnc_ragdoll_unconscious};  //-- uncon loop
};

tsp_fnc_ragdoll_getUp = {
	if ((!isTouchingGround _this) || (speed _this > 0.1)) exitWith {};  //-- Only allow getUp when stationary
	_this setPosASL (getPosASL _this);
	tsp_ragdoll_currentlyRagdolling = false;
	systemChat "GETUP";
};

tsp_fnc_ragdoll_collision = {
	systemChat "COLLISION METHOD";	
	_allowDmgStore = isDamageAllowed _this;  //-- Save damage allowed in case unit is supposed to be invincible
	_this allowDamage false;  //-- Prevent damage

	//-- SLAM THAT BOI
	_slammer = "tsp_slammer" createVehicleLocal [0,0,0];
	_slammer attachTo [_this, [0,0,0], "Spine3"];
	_slammer setMass 1e10;
	_slammer setVelocity [0,0,-6];
	detach _slammer;
	sleep 0.1;  //-- Needed to make sure player gets dropped
	deleteVehicle _slammer;	

	_this allowdamage _allowDmgStore;  //-- Allow damage
};

tsp_fnc_ragdoll_unconscious = {
	systemChat "UNCON METHOD";
	_this setUnconscious true;
	sleep 3;
	_this setUnconscious false;
	sleep 0.01;
};

tsp_fnc_ragdoll_blocker = {
	systemChat "CREATE BLOCKER";
	_saveVelocity = velocity _this;  //-- Save velocity to set it back later

	//-- Create blocker to stop player
	_blocker = "tsp_invisibox" createVehicleLocal ((position _this)); 
	_blocker attachTo [_this, [0,0,-1.8]];
	detach _blocker;

	_this setVelocity [0,0,0];  //-- Stop that boi in his tracks
	sleep 0.05;  //-- Needed to make sure player gets dropped and doesnt bounce on blocker
	_this setVelocity _saveVelocity;  //-- Return velocity
	_this spawn tsp_fnc_ragdoll_collision;
	sleep 0.01;
	deleteVehicle _blocker;
};

tsp_fnc_isFalling = {
	_return = false;
	if (["halofreefall", animationState _this] call BIS_fnc_inString) exitWith {true};
	if ((velocity _this#2) < 0) then {if (_this call tsp_fnc_distanceFromSurface > 3) exitWith {_return = true}};
	_return
};

tsp_fnc_distanceFromSurface = {
	_distanceVar = (getPosATL _this)#2;
	_intersectVar = lineIntersectsSurfaces [getPosASL _this, getPos _this, _this, objNull, true, 1, "GEOM", "GEOM"];
	if (count _intersectVar > 0) then {_distanceVar = (_intersectVar#0#0) distance getPosASL _this};
	_distanceVar
};

tsp_fnc_getHighestVelocity = {
	params ["_unit","_velocityCap"];
	_vu = velocity _unit;
	_biggestV = 0;
	{
		if ((0 - _x) > _biggestV) then {
			_biggestV = 0 - _x;
		};
	} forEach [_vu#0,_vu#1,_vu#3]
	
	_x = (velocity _unit)#0 > _velocityCap || (velocity _unit)#0 < -_velocityCap;
	_y = (velocity _unit)#1 > _velocityCap || (velocity _unit)#1 < -_velocityCap;
	_z = (velocity _unit)#2 > _velocityCap || (velocity _unit)#2 < -_velocityCap;
	if (_x || _y || _z) then {true} else {false};
};

tsp_fnc_ragdoll_blood = {	
	while {tsp_ragdoll_currentlyRagdolling} do {
		waitUntil {_this call tsp_fnc_distanceFromSurface < 0.01};
		if ([_this,4] call tsp_fnc_getVelocityMoreThan) then {
			_blood = selectRandom ["BloodSplatter_01_Medium_New_F", "BloodSpray_01_New_F", "BloodPool_01_Medium_New_F"] createVehicle (getpos _this);
			_blood attachto [_this, [0,0,1]];detach _blood;
			_blood setVehiclePosition [_blood, [], 0, 'CAN_COLLIDE'];
			systemChat "BIGGO";
		};
		sleep 0.5;		
	};
	systemChat "BLOODONE"
};

tsp_fnc_ragdoll_impact = {
	while {tsp_ragdoll_currentlyRagdolling} do { //sleep 1;[_this,0.01] call tsp_fnc_getVelocityMoreThan
		waitUntil {isTouchingGround _this};
		if ([_this,0.1] call tsp_fnc_getVelocityMoreThan) then {
			_sound = selectRandom ["tsp_ragdoll\sounds\impact1.ogg", "tsp_ragdoll\sounds\impact2.ogg", "tsp_ragdoll\sounds\impact3.ogg"];
			systemChat _sound;			 
			playSound3D [_sound, _this];
		};
		sleep 1;
	};
	systemChat "IMPACTDONE"
};

tsp_fnc_ragdoll_scream = {
	_emitter = "tsp_slammer" createVehicleLocal [0,0,0];
	_emitter attachTo [_this, [0,0,0]];	
	_this setRandomLip true;
	_emitter spawn {
		while {getPos _this#2 > 1} do {
			_randomScream = selectRandom [
				["scream_long1",8],
				["scream_long2",18],
				["scream_short1",6],
				["scream_short2",8],
				["zeus_loadout",3],
				["nolodut",3]
			];
			[_this, _randomScream#0] remoteExec ["say3D"];
			uiSleep (_randomScream#1);
		};
	};
	waitUntil {!alive _this || (isTouchingGround _this && !([_this,0.1] call tsp_fnc_getVelocityMoreThan))};
	systemChat "SCREAMDONE";
	deleteVehicle _emitter;	
	_this setRandomLip false;
};
//-- Controls	
#include "\a3\editor_f\Data\Scripts\dikCodes.h";
disableSerialization;
[
	"[TSP] Ragdoll-on-Command", 
	"tsp_ragdoll_cba_ragdollKey", 
	"Ragdoll", 
	{
		if (tsp_ragdoll_currentlyRagdolling) then {player spawn tsp_fnc_ragdoll_getUp} else {player spawn tsp_fnc_ragdoll};
	},
	{}, 
	[DIK_SPACE, [true, false, false]]
] call CBA_fnc_addKeybind;

//-- Freefall
player addEventHandler ["animChanged", {
	params ["_unit","_anim"];
	if (getText(configFile >> 'CfgVehicles' >> (backpack _unit) >> 'parachuteClass') != "") exitWith {};  //-- Dont freefall if you have a parachute
	_unit spawn {sleep 0.2;if (_this call tsp_fnc_isFalling) then {_this spawn tsp_fnc_ragdoll}};
}];