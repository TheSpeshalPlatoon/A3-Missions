dev_fnc_aura = {  //-- Kill all players in radius of objects
	params ["_types", "_radius", "_code"];
	while {sleep 0.01; true} do {
		_nearObjects = nearestObjects [player, _types, _radius];
		if (count _nearObjects > 0) then {[player, _nearObjects] spawn _code; sleep 3};
	};
};

dev_fnc_translate = {  //-- Translate in multiplayer
    [_this,{
        _this params ["_object", "_endPos", ["_speed", 1]];
        _eh = call compile format [
            "addMissionEventHandler ['eachFrame', { 
                %1 setVelocityTransformation [  
                    getPosASL %1,   
                    getPosASL %1 vectorAdd (((getPosASL %1) vectorFromTo %2) vectorMultiply %3),
                    [0,0,0], [0,0,0],  
                    vectorDir %1, vectorDir %1,
                    vectorUp %1, vectorUp %1,
                    0.1
                ];  
            }];", _object, _endPos, _speed  
        ];
        waitUntil {sleep 0.1; _object distance2D _endPos < 1};
        removeMissionEventHandler ["eachFrame", _eh];  
    }] remoteExec ["spawn", 0];
};

dev_fnc_leftright = {  //-- Move object left and right between 2 spots
    params ["_object", "_startPos", "_endPos", ["_speed", 1], ["_radius", 5]];
    while {alive _object} do {
		[_object, _endPos, _speed] spawn dev_fnc_translate;
		waitUntil {sleep 0.01; _object distance2D _endPos < 1}; sleep 0.5;
        [_object, _startPos, _speed] spawn dev_fnc_translate;
		waitUntil {sleep 0.01; _object distance2D _startPos < 1}; sleep 0.5;
    };
};

tsp_fnc_decal = {
	params ["_pos", ["_decals", ["BloodPool_01_Medium_New_F","BloodSplatter_01_Small_New_F","BloodSplatter_01_Medium_New_F","BloodSpray_01_New_F","BloodSplatter_01_Large_New_F"]], ["_radius", 2]];
	if (count ((ASLtoATL _pos nearObjects _radius) select {_x getVariable ["tsp_decal", false]}) > 0) exitWith {}; 
	_decal = (selectRandom _decals) createVehicle [0,0,0]; _decal setDir (random 360); _decal setPosASL (_pos vectorAdd [0,0,3]); 
	_decal setVehiclePosition [_decal, [], 0, "CAN_COLLIDE"]; _decal setVariable ["tsp_decal", true]; 
	_decal
};

tsp_fnc_blood_blood = {
	params ["_unit", "_selection", "_class", ["_interval", 0.1], ["_duration", 1], ["_dispersion", 0], ["_life", 0.5], ["_weight", 40], ["_size", [1,1,1]], ["_model", ["\a3\Data_f\ParticleEffects\Universal\Universal", "Billboard"]]];
	_blood = createVehicle ["#particlesource", position _unit, [], 0, "CAN_COLLIDE"]; _blood attachTo [_unit, [0,0,0], _selection];
	if (_class == "") then {_blood setParticleParams [  //-- Parameters
		[_model#0, 16, 13, 1],                         //-- Shape 
		"",                                           //-- Animation Name 
		_model#1,                                    //-- Particle Type 
		1,                                          //-- Time Period 
		_life,                                     //-- Life Time 
		[0,0,0],                                  //-- Position 
		[0,0,0],                                 //-- Velocity 
		10,                                     //-- Rotation Velocity 
		_weight,                               //-- Weight 
		1,                                    //-- Volume 
		0.2,                                 //-- Rubbing 
		_size,                              //-- Size 
		[[0.2,0,0.1,1], [0.3,0,0.1,1]],    //-- Color 
		[0.1],                            //-- AnimationPhase 
		0,                               //-- Random Direction Period 
		0,                              //-- Random Direction Intensity 
		"",                            //-- OnTimer 
		"",                           //-- Before Destroy 
		[0,0,0]                      //-- Object 
	]} else {_blood setParticleClass _class};
	_blood setParticleRandom [0, [0,0,0], [_dispersion/2, _dispersion/2, _dispersion], 5, 0, [0.1, 0.1, 0.1, 0.1], 0, _dispersion*10, _dispersion*10, 0.1];  //-- Randomization (life, pos, velo, rotat, size, color, dir, dir intensity, angle, bounce)
	_blood setDropInterval _interval; sleep _duration; deleteVehicle _blood;
};

tsp_fnc_blood_combust = {
	params ["_unit"]; if !(alive _unit) exitWith {};
	playSound3D [getMissionPath "hit1.ogg", _unit, false, getPosASL _unit, 4.9, 1, 300]; _unit setDamage 1; 
	[_unit, "pelvis", "blood2", 0.01, 0.5, 20] remoteExec ["tsp_fnc_blood_blood", 0];
	[_unit, "pelvis", "blood2", 0.01, 0.5, 20] remoteExec ["tsp_fnc_blood_blood", 0];
	[_unit, "pelvis", "", 0.05, 0.5, 2, 1, 20] remoteExec ["tsp_fnc_blood_blood", 0];  //-- Splosion
	if (selectMax (velocity _unit apply {abs _x}) < 2) then {_unit addForce [[(random 1000)-700,(random 1000)-700,random 1500], [random 1,0,0]]};
	[_unit, true] remoteExec ["hideObjectGlobal", 2]; [getPosASL _unit, ["BloodSplatter_01_Large_New_F"]] spawn tsp_fnc_decal;
};

tsp_fnc_balls = {
	params ["_launcher", "_velocity", ["_offset", [0,1,0]], ["_rate", 3], ["_random", 2], ["_types", ["Land_Football_01_F","Land_Rugbyball_01_F","Land_Volleyball_01_F","Land_Basketball_01_F","Land_Baseball_01_F"]], ["_life", 5]];
	while {sleep (random _rate) + random _random; alive _launcher} do {
		_ball = (selectRandom _types) createVehicle position _launcher;
		_ball attachTo [_launcher, _offset]; detach _ball;
		_ball setVelocityModelSpace [(_velocity#0) + (random _random), (_velocity#1) + (random _random), (_velocity#2) + (random _random)];
		[_ball, _life] spawn {params ["_ball", "_life"]; sleep _life; deleteVehicle _ball};
	};
};

tsp_fnc_boulders = {
	params ["_launcher", "_velocity", ["_offset", [0,1,0]], ["_rate", 1], ["_random", 2], ["_types", ["Land_Bare_boulder_01_F","Land_Bare_boulder_02_F","Land_Bare_boulder_03_F"]]];
	while {sleep (_rate + (random _random)); true} do {
		_boulder = "Box_NATO_Equip_F" createVehicle position _launcher; _boulder attachTo [_launcher, _offset]; detach _boulder; _boulder allowDamage false;
		_boulder setObjectMaterialGlobal [0, "empty.rvmat"];
		_boulder setVelocity [(_velocity#0) + (random _random) - (random _random), (_velocity#1) + (random _random), (_velocity#2) + (random _random)];		
		_visual = (selectRandom _types) createVehicle position _launcher; _visual attachTo [_boulder, [0,0,0]];
		[_launcher, _boulder, _visual] spawn {params ["_launcher", "_boulder", "_visual"]; _stop = time + 15; waitUntil {sleep 1; _boulder distance _launcher > 90 || time > _stop}; deleteVehicle _boulder; deleteVehicle _visual};
	};
};

tsp_fnc_guns = {
	params ["_white", "_guns"];
	_red = "VR_Sector_01_60deg_50_red_F" createVehicle [0,0,0];
	_red attachTo [_white, [0,0,0]]; detach _red;
	while {true} do {
		{_x setVehicleAmmo 0} forEach _guns; _white hideObjectGlobal false; _red hideObjectGlobal true;
		sleep (3 + (random 3));
		{_x setVehicleAmmo 1} forEach _guns; _white hideObjectGlobal true; _red hideObjectGlobal false;
		sleep (3 + (random 3));
	};
};

tsp_fnc_glass = {
	_glass = _this apply {selectRandom _x};  //-- Take left or right randomlys
	while {sleep 0.1; true} do {{if (count (_x nearEntities 1.5) > 0) then {{deleteVehicle _x} forEach (attachedObjects _x); deleteVehicle _x}} forEach _glass};
};

[] spawn {if (hasInterface) then {
	waitUntil {!isNull (findDisplay 46) && player distance spawnPos > 3}; ace_medical_disabled = true;
	player addMPEventHandler ["MPRespawn", {player attachTo [spawnPos, [0,0,0]]; detach player; player switchCamera "External"}];  //-- Respawns
	(findDisplay 46) displaySetEventHandler ["KeyDown","if (_this#1 == 57 && isTouchingGround player) then {player setVelocityModelSpace [0, (speed player)*0.3, 4]};"];  //-- Jumping
	[["Land_VR_Target_MRAP_01_F"], 2.1, {[player] spawn tsp_fnc_blood_combust}] spawn dev_fnc_aura;
	[["Box_NATO_Equip_F", "Land_VR_Block_04_F"], 1.6, {[player] spawn tsp_fnc_blood_combust}] spawn dev_fnc_aura;
	[["Land_Football_01_F","Land_Rugbyball_01_F","Land_Volleyball_01_F","Land_Basketball_01_F","Land_Baseball_01_F"], 1.5, {player addForce [(((velocity (_this#1#0)) vectorMultiply 5000)), [1,0,0]]; sleep 1; player setDamage 1}] spawn dev_fnc_aura;
	waitUntil {sleep 5; player distance crowe < 150};
    [name player + " has completed the course!"] remoteExec ["systemChat", 0];
	["TaskSucceeded", ["", "Course Complete"]] call BIS_fnc_showNotification;    
	sleep 5; hideObjectGlobal player; player setPos (getPos crowe);
	["Initialize", [player, [], false, true, true, true, true, true, true, true]] call BIS_fnc_EGSpectator;  
}};

[] spawn {if (isServer) then {
	waitUntil {time > 1};
	[mrap1, getPosASL mrap1, getPosASL mrap1_end, 3, 4] spawn dev_fnc_leftright;
	[mrap2, getPosASL mrap2, getPosASL mrap2_end, 5, 4] spawn dev_fnc_leftright;
	[mrap3, getPosASL mrap3, getPosASL mrap3_end, 7, 4] spawn dev_fnc_leftright;
	[mrap4, getPosASL mrap4, getPosASL mrap4_end, 8, 4] spawn dev_fnc_leftright;
	[ball1, [0,10,5]] spawn tsp_fnc_balls;
	[ball2, [0,10,5]] spawn tsp_fnc_balls;
	[ball3, [0,10,5]] spawn tsp_fnc_balls;
	[ball4, [0,10,5]] spawn tsp_fnc_balls;
	[ball5, [0,10,5]] spawn tsp_fnc_balls;
	[ball6, [0,10,5]] spawn tsp_fnc_balls;
	[gun_sector, [gun1, gun2, gun3]] spawn tsp_fnc_guns;
	[[glass1L, glass1R], [glass2L, glass2R], [glass3L, glass3R], [glass4L, glass4R]] spawn tsp_fnc_glass;
	[boulder1, [0,5,0]] spawn tsp_fnc_boulders;
	[boulder2, [0,5,0]] spawn tsp_fnc_boulders;
	[boulder3, [0,5,0]] spawn tsp_fnc_boulders;
	waitUntil {sleep 5; count ((call BIS_fnc_listPlayers) select {_x distance crowe < 150}) == count (call BIS_fnc_listPlayers)};
	sleep 5; ["END"] remoteExec ["BIS_fnc_endMission", 0];
}};