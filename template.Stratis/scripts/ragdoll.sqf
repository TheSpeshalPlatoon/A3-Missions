["tsp_cba_ragdoll", "CHECKBOX", "Enable Ragdolling", "Enables ragdolling on button press.", "TSP Ragdoll", true] call tsp_fnc_setting;
["tsp_cba_ragdoll_freefall", "CHECKBOX", "Enable Free Falling", "Enables free falling when jumping from height.", "TSP Ragdoll", true] call tsp_fnc_setting;
["tsp_cba_ragdoll_blood", "CHECKBOX", "Enable Blood", "Enables blood decal when impacting surfaces.", "TSP Ragdoll", true] call tsp_fnc_setting;

tsp_fnc_ragdoll_start = {
	params ["_unit", ["_launch", false]];
	if (_unit getVariable ["tsp_ragdoll", false] || lifeState _unit == "INCAPACITATED" || vehicle _unit != _unit) exitWith {}; _unit setVariable ["tsp_ragdoll", true];
	if (_launch && speed _unit > 17 && stance _unit == "STAND") then {_unit setVelocityModelSpace [0, (speed _unit) * 0.22, 4.5]; [_unit, "AmovPercMsprSlowWrflDf_AmovPpneMstpSrasWrflDnon"] remoteExec ["switchMove", 0]; sleep 0.6};
	[_unit] spawn tsp_fnc_ragdoll_collision;  //-- Collision ragdoll
	[_unit] spawn tsp_fnc_ragdoll_effects;
	sleep 3; waitUntil {(vectorMagnitude velocity _unit) < 0.1 && [_unit] call tsp_fnc_height < 0.2};  //-- Only start uncon loop when stationary	
	_startPos = getPos _unit;  //-- Save position before uncon ragdoll to check later
	while {_unit getVariable "tsp_ragdoll" && alive _unit} do {  //-- Unconscious ragdoll loop
		_unit setUnconscious true; sleep 3; _unit setUnconscious false; sleep 0.01;
		if (getPos _unit distance _startPos > 2) exitWith {[_unit] spawn tsp_fnc_ragdoll_stop};  //-- Emergency exit if playa got launched by the ragdoll as the camera doesnt move with him
	};
};

tsp_fnc_ragdoll_stop = {
	params ["_unit", ["_check", true], ["_out", ""]]; [((_unit selectionPosition "camera")#2) < ((_unit selectionPosition "head")#2)] params ["_facingUp"];
	if (_check && !(_unit getVariable ["tsp_ragdoll", false])) exitWith {}; _unit setVariable ["tsp_ragdoll", false]; 
	playSound3D ["A3\Sounds_F\characters\movements\bodyfalls\bodyfall_concrete_1.wss", _unit, true, getPosASL _unit, 0.1, 1];
	_unit setPosASL (getPosASL _unit);  //-- Forgot why this is needed but it is 	
	if (currentWeapon _unit == primaryWeapon _unit) then {_out = "ainvppnemstpsraswrfldnon_amovppnemstpsraswrfldnon"};
	if (currentWeapon _unit == "") then {_out = "AmovPpneMstpSnonWnonDnon"};
	if (_facingUp) then {_unit setDir (getDir _unit - 180); _out = "UnconsciousOutProne"};
	[_unit, false] remoteExec ["setUnconscious", 0]; sleep 0.1; [_unit, _out] remoteExec ["switchMove", 0]; 
	if (!isServer) then {sleep 2; [_unit, animationState _unit] remoteExec ["switchMove", -clientOwner]};
};

tsp_fnc_ragdoll_collision = {
	params ["_unit"]; [velocity _unit, isDamageAllowed _unit] params ["_oldVelocity", "_isDamageAllowed"];  //-- Save velocity to set it back later
	_unit allowDamage false;
	_blocker = createSimpleObject [tsp_path + "data\blocker.p3d", [0,0,0], true];
	_blocker attachTo [_unit, [0, 0, 0]]; detach _blocker;
	_unit attachTo [_blocker, [0, 0, 0]]; detach _unit;
	_unit setVelocity [0, 0, 0]; _unit setVelocity _oldVelocity;  //-- Stop that boi in his tracks, then return velocity (idk why this works)
	sleep 0.05;	deleteVehicle _blocker;
	_slammer = "Land_WheelChock_01_F" createVehicleLocal [0, 0, 0]; _slammer setObjectTextureGlobal [0, ""];  //-- "tsp_slammer"
	_slammer attachTo [_unit, [0, 0, 0], "Pelvis"];	_slammer setMass 1e10; _slammer setVelocity [0, 0, 10]; detach _slammer;
	sleep 0.05; deleteVehicle _slammer;	 //-- Needed to make sure unit gets dropped by slammer before deleting
	if (true) then {_unit allowDamage true};  //_isDamageAllowed
};

tsp_fnc_ragdoll_effects = {  //-- Detect violent deceleration
	params ["_unit"]; sleep 0.5;  //-- Dont start immediatly
	while {_unit getVariable "tsp_ragdoll" && (lifeState _unit == "HEALTHY" || !alive _unit)} do {  //-- Only do for collision ragdoll, not for uncon (stationary) ragdoll
		[selectMax (velocity _unit apply {abs _x}), damage _unit, vectorMagnitude (_unit getVariable ["ace_medical_bodyPartStatus", []])] params ["_oldVelocity", "_oldDamage", "_oldDamageACE"]; 
		sleep 0.1;
		[selectMax (velocity _unit apply {abs _x}), damage _unit, vectorMagnitude (_unit getVariable ["ace_medical_bodyPartStatus", []])] params ["_newVelocity", "_newDamage", "_newDamageACE"]; 
		if ((_oldVelocity - _newVelocity) > 0.15) then {playSound3D ["A3\Sounds_F\characters\footsteps\concrete\concrete_run_HPF_" + str (round random 8 max 1) + ".wss", _unit, true, getPosASL _unit, 3, 0]; sleep 0.5};
		if (tsp_cba_ragdoll_blood && (_newDamage > _oldDamage || _newDamageACE > _oldDamageACE || !alive _unit)) then {
			[_unit modelToWorld (_unit selectionPosition "spine3"), ["BloodSplatter_01_Small_New_F", "BloodSplatter_01_Medium_New_F", "BloodSpray_01_New_F"]] call tsp_fnc_decal;
			sleep 1;
		};
	};
};

["tsp_ragdoll_ragdollKeyDouble", ["TSP Core", "Ragdoll"], "Ragdoll (Double Tap)", 57, true, false, false, {	
	if (playa getVariable ["tsp_ragdoll", false]) exitWith {[playa] spawn tsp_fnc_ragdoll_stop};	
	if (isNil "tsp_ragdoll_firstTap") exitWith {[] spawn {tsp_ragdoll_firstTap = true; sleep 0.5; tsp_ragdoll_firstTap = nil}};  //-- Double tap
	if (tsp_cba_ragdoll) then {[playa, true] spawn tsp_fnc_ragdoll_start};
}] call tsp_fnc_keybind;