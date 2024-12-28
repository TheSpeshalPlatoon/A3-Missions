tsp_ragdoll_currentlyRagdolling = false;

tsp_fnc_ragdoll = {
	if (tsp_ragdoll_currentlyRagdolling) exitWith {};
	tsp_ragdoll_currentlyRagdolling = true;
	_this call tsp_fnc_ragdoll_collision;
	sleep 1;
	[_this, animationState _this] call tsp_fnc_ragdoll_freefallHandler;
	sleep 6;  //-- Cause collision method lasts a good amount of time, so no need to loop uncon yet
	waitUntil {isTouchingGround _this && speed _this < 0.1};  //-- Only do uncon loop when stationary
	while {tsp_ragdoll_currentlyRagdolling && (speed _this) < 1 && alive _this} do {_this call tsp_fnc_ragdoll_uncon};  //-- uncon loop
};

tsp_fnc_ragdoll_getUp = {
	if ((!isTouchingGround _this) || (speed _this > 0.1)) exitWith {};  //-- Only allow getUp when stationary
	_this setPosASL (getPosASL _this);
	tsp_ragdoll_currentlyRagdolling = false;	
	systemChat "GETUP";
};

tsp_fnc_ragdoll_uncon = {
	systemChat "UNCON METHOD";
	_this setUnconscious true;
	sleep 3;
	_this setUnconscious false;
	sleep 0.01;
};

tsp_fnc_ragdoll_collision = {	
	systemChat "COLLISION METHOD";
	//-- Prevent damage
	_allowDmgStore = isDamageAllowed _this;
	_this allowDamage false;

	//-- SLAM THAT BOI
	_obj = "tsp_slammer" createVehicleLocal [0,0,0];
	_obj setMass 1e10;
	_obj attachTo [_this, [0,0,0], "Spine3"];
	_obj setVelocity [0,0,-6];
	detach _obj;
	sleep 0.1;  //-- Needed to make sure player gets dropped
	deletevehicle _obj;

	//-- Allow damage
	_this allowdamage _allowDmgStore;
};

tsp_fnc_ragdoll_freefall = {
	systemChat "FREEFALL METHOD";

	if (!tsp_ragdoll_currentlyRagdolling) then {
		_saveVelocity = velocity _this;  //-- Save velocity to set it back later

		//-- Create blocker to stop player
		_blocker = "tsp_invisibox" createVehicleLocal ((position _this)); 
		_blocker attachTo [_this, [0,0,-1.8]];
		detach _blocker;

		_this setVelocity [0,0,0];  //-- Stop that boi in his tracks
		sleep 0.05;  //-- Needed to make sure player gets dropped and doesnt bounce on blocker
		_this setVelocity _saveVelocity;  //-- Return velocity
		_this spawn tsp_fnc_ragdoll;  //-- Ragdoll player
		sleep 0.01;
		deleteVehicle _blocker;
	};
	
	sleep 1;
	_this spawn tsp_fnc_ragdoll_scream;
	_this spawn tsp_fnc_ragdoll_blood;
};

tsp_fnc_ragdoll_scream = {
	_emitter = "tsp_slammer" createVehicleLocal [0,0,0];
	_emitter attachTo [_this, [0,0,0]];
	[_this, _emitter] spawn {waitUntil {isTouchingGround (_this#0)};deleteVehicle (_this#1)};
	while {!isTouchingGround _this} do {
		_randomScream = selectRandom [
			["scream_long1",8],
			["scream_long2",18],
			["scream_short1",6],
			["scream_short2",8],
			["zeus_loadout",3],
			["nolodut",3]
		];
		[_emitter, _randomScream#0] remoteExec ["say3D"];
		_this setRandomLip true;
		uiSleep (_randomScream#1);		
		_this setRandomLip false;
	};	
};

tsp_fnc_ragdoll_blood = {	
	//-- Impact blood
	waitUntil {isTouchingGround _this};
	_blood = "BloodSplatter_01_Large_New_F" createVehicle (getpos _this);
	_blood attachto [_this, [0,0,0]];detach _blood;
	_blood setPosATL [getPosATL _blood#0, getPosATL _blood#1, 0.01];
	_blood setVectorUp surfaceNormal position _blood;

	sleep 2;
	
	//-- Final blood
	waitUntil {speed _this == 0};
	_blood = "BloodSplatter_01_Large_New_F" createVehicle (getpos _this);
	_blood attachto [player, [0,0,0]];detach _blood;
	_blood setPosATL [getPosATL _blood#0, getPosATL _blood#1, 0.01];
	_blood setVectorUp surfaceNormal position _blood;
};

//-- Freefall
player addEventHandler ["animChanged", {
	params ["_unit", "_anim"];
	if (tsp_ragdoll_currentlyRagdolling) exitWith {};  //-- If already ragdolling, dont attempt to freefall again	
	if (getText(configFile >> 'CfgVehicles' >> (backpack player) >> 'parachuteClass') != "") exitWith {};  //-- Dont freefall if you have a parachute
	[_unit, _anim] spawn tsp_fnc_ragdoll_freefallHandler;
}];

tsp_fnc_ragdoll_freefallHandler = {
	params ["_unit", "_anim"];

	if (["halofreefall", _anim] call BIS_fnc_inString) then {
		_unit spawn tsp_fnc_ragdoll_freefall;
	} else {
		sleep 0.2;  //-- Needed wait time to make sure player gets up to speed before checking velocity
		//-- If player has downwards velocity/is doing the falling animation
		if (["afal", _anim] call BIS_fnc_inString || (velocity _unit#2) < 0) then {  
			//-- Calculate distance from nearset surface/ground
			_distanceVar = (getPosATL _unit)#2;
			_intersectVar = lineIntersectsSurfaces [getPosASL _unit, getPos _unit, objNull, objNull, true, 1, "GEOM", "GEOM"];
			if (count _intersectVar > 0) then {_distanceVar = (_intersectVar#0#0) distance getPosASL _unit};
			if (_distanceVar > 3 && !tsp_ragdoll_currentlyRagdolling) then {_unit spawn tsp_fnc_ragdoll_freefall};  //-- If high enough, drop that boiO
		};	
	};
};

//-- Controls	
#include "\a3\editor_f\Data\Scripts\dikCodes.h";
disableSerialization;
[
	"[TSP] Ragdoll-on-Command", 
	"tsp_ragdoll_cba_ragdollKey", 
	"Ragdoll", 
	{
		if (tsp_ragdoll_currentlyRagdolling) then {
			player spawn tsp_fnc_ragdoll_getUp;
		} else {
			player spawn tsp_fnc_ragdoll;
		}
	},
	{}, 
	[DIK_SPACE, [true, false, false]]
] call CBA_fnc_addKeybind;
