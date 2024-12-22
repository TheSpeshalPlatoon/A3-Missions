["tsp_cba_crash", "CHECKBOX", "Enable Crash Landings", "Enable/disable addon.", "TSP Crash", true] call tsp_fnc_setting;
["tsp_cba_crash_force", "SLIDER", "Survivable Impact Force", "Amount of force helicopter can endure.", "TSP Crash", [0, 10000, 3000]] call tsp_fnc_setting;

tsp_fnc_crash_handler = {
	params ["_vehicle"];
	if !(tsp_cba_crash && local _vehicle && (_vehicle isKindOf 'Helicopter' || _vehicle isKindOf 'Plane')) exitWith {};
	{_vehicle removeAllEventHandlers _x} forEach ["EpeContactStart", "HandleDamage"];  //-- Remove handlers so we don't double add
	_vehicle addEventHandler ["EpeContactStart", {_this#0 setVariable ["tsp_crash_lastImpactForce", _this#4]}];  //-- Handle PhysX contact, save force to vehicle
	_vehicle addEventHandler ["HandleDamage", {  //-- Handle damage
		params ["_vehicle", "_selection", "_damage", "_source"];
		if !(_source == driver _vehicle && !alive _vehicle) exitWith {}; _vehicle removeAllEventHandlers "HandleDamage";       //-- Only continue if vehicle crashed and is dead
		{[_x, false] remoteExec ["allowDamage", 0]} forEach crew _vehicle; _vehicle allowDamage false; _vehicle setDamage 0;  //-- Save crew and vehicle
		_vehicle spawn {
			waitUntil {_this getVariable ["tsp_crash_lastImpactForce", 0] > 0}; _this removeAllEventHandlers "EpeContactStart";       //-- Wait until we have impact force
			_this spawn {sleep 1; {[_x, true] remoteExec ["allowDamage", 0]} forEach crew _this};                                    //-- Enable damage on members again
			if (_this getVariable "tsp_crash_lastImpactForce" < tsp_cba_crash_force) exitWith {[_this] spawn tsp_fnc_crash_wreck};  //-- Replace vehicle with wreck version
			{_x setDamage 1} forEach crew _this; _this setDamage 1;                                                                //-- Fatal damage, do normal thing
		};
	}];
};

tsp_fnc_crash_wreck = {
	params ["_vehicle"];

 	_vehicle setDamage 0.8; _vehicle setFuel 0;
	_vehicle addEventHandler ["EpeContactStart", {_this#0 spawn {if (isNil "tsp_crash_spam") then {tsp_crash_spam = true; playSound3D ["A3\Sounds_F\air\UAV_01\Quad_crash_"+str ((floor random 8)+1)+".wss", _this, false, getPosASL _this, 4.9, 1, 150]; sleep 0.5; tsp_crash_spam = nil}}}];	

	if (_vehicle isKindOf "Helicopter") then {  //-- Destroy rotor
		[getPosASL _vehicle, [vectorDir _vehicle, vectorUp _vehicle], velocity _vehicle] params ["_pos", "_vec", "_vel"];
		_vehicle setVehiclePosition [[0, 0, 1000], [], 0, "FLY"];
		_destroyer = createVehicle ["Land_Pier_Box_F", [0,0,0], [], 0, "CAN_COLLIDE"];
		_destroyer attachTo [_vehicle, [12, 0, 0], "main rotor"]; detach _destroyer;
		_vehicle allowDamage true; sleep 1; _vehicle allowDamage false; deleteVehicle _destroyer;
		_vehicle setPosASL _pos; _vehicle setVectorDirAndUp _vec; _vehicle setVelocity _vel;
	};

	_smoke = "test_EmptyObjectForSmoke" createVehicle (getPos _vehicle); _smoke attachTo [_vehicle, [0, 0, 0], "main rotor"];  //-- Smoke
	waitUntil {isTouchingGround _vehicle || !alive _vehicle};                                                   //-- Effects that should happen on touching ground
	playSound3D ["A3\Sounds_F\air\noises\crash-heli2.wss", _vehicle, false, getPosASL _vehicle, 4.9, 1, 150];  //-- BIG impact noise
	[_vehicle] spawn BIS_fnc_effectKilledAirDestructionStage2;                                                //-- BIS craters and dust
	waitUntil {speed _vehicle < 0.1 || !alive _vehicle};  //-- Only do cleanup when vehicle has settled
	_vehicle removeAllEventHandlers "EpeContactStart";   //-- Remove the PhysX handler responsible for impact noises	
	sleep 60; deleteVehicle _smoke;                     //-- Dont want the smoke to disapate just yet
	_vehicle allowDamage ((vectorUp _vehicle)#2 > 0);  //-- If not upside down, allowDamage again so it can be detonated, else dont cause ArmA will just blow it up
};

BIS_fnc_effectKilledAirDestructionStage2 = {  //--  Modified by DINO
	params ["_vehicle"];

	//-- Added by DINO
	_shards = '#particlesource' createVehicleLocal [0,0,0]; _shards setParticleClass 'HeliDestructionShards1'; _shards attachto [_vehicle, [0,0,0]];
	_dust = '#particlesource' createVehicleLocal [0,0,0]; _dust setParticleClass 'HouseDestrSmokeLong'; _dust attachto [_vehicle, [0,0,0]];
	_shards spawn {sleep 1.5; deleteVehicle _this}; _dust spawn {waitUntil {speed _this < 0.1}; sleep 10; deleteVehicle _this};
	//-- Added by DINO

	private _pos = getpos _vehicle;
	private _createCraters = true;

	//particle effects
	private _smoke = createVehicle ["#particlesource", getpos _vehicle, [], 0, "CAN_COLLIDE"];
	_smoke attachto [_vehicle,[0,0,0],"destructionEffect1"];
	_smoke setParticleParams [
		["\A3\data_f\ParticleEffects\Universal\Universal_02", 8, 0, 40],
		"", "Billboard", 1, 14, [0, 0, 0], [0, 0, 0], 1, 1.275, 1, 0, [10,18,24],
		[[0.1,0.1,0.1,0.6],[0.1,0.1,0.1,0.35],[0.1,0.1,0.1,0.01]], [0.5], 0.1, 0.1, "", "", _vehicle
	];
	_smoke setParticleRandom [2, [2, 2, 2], [1.5, 1.5, 3.5], 0, 0, [0, 0, 0, 0], 0, 0];
	_smoke setDropInterval 0.02;

	private _dirt = createVehicle ["#particlesource", getpos _vehicle, [], 0, "CAN_COLLIDE"];
	_dirt attachto [_vehicle,[0,0,0],"destructionEffect1"];
	_dirt setParticleParams [
		["\A3\data_f\ParticleEffects\Universal\Universal",16,12,9,0], 
		"", "Billboard", 1, 5, [0, 0, 0], [0, 0, 5], 0, 5, 1, 0, [7,12], 
		[[0.1,0.1,0.1,0.6],[0.1,0.1,0.1,0.35],[0.1,0.1,0.1,0.01]], [1000], 0, 0, "", "", _vehicle,360
	];
	_dirt setParticleRandom [0, [1, 1, 1], [1, 1, 2.5], 0, 0, [0, 0, 0, 0.5], 0, 0];
	_dirt setDropInterval 0.05;

	private ["_pos","_speed","_dir","_tv","_dr","_craterType"];

	while {abs(speed _vehicle) > 0.1} do
	{
		//wait for the vehicle to get down to the ground
		_pos = getpos _vehicle;

		if (_pos select 2 >= 3) then
		{
			private _timeout = time + 60;

			waitUntil
			{
				sleep 0.05;
				_pos = getpos _vehicle;

				_pos select 2 < 3 || {time > _timeout}
			};
		};

		//exit if timeout and still not on the ground
		if (_pos select 2 >= 3) exitWith {};

		//set crater position to ground
		_pos set [2, 0];

		//create and repos the crater
		(velocity _vehicle) params ["_xv","_yv","_zv"];
		_dir = abs(_xv atan2 _yv);
		_speed = abs speed _vehicle;

		if (_createCraters) then
		{
			_craterType = if (_speed > 60) then {"CraterLong"} else {"CraterLong_small"};

			private _crater = createVehicle [_craterType, _pos, [], 0, "CAN_COLLIDE"];

			if (random 1 > 0.5) then
			{
				_crater setdir (_dir + 170 + (random 20));
			}
			else
			{
				_crater setdir (_dir - 10 + (random 20));
			};
			_crater setPos _pos;
		};

		//update the particle effects
		_tv = abs(_xv) + abs(_yv) + abs(_zv);
		_dr = if (_tv > 2) then {1/_tv} else {1};
		_smoke setDropInterval _dr * 1.5;
		_dirt setDropInterval _dr;

		sleep (0.25 - (_speed / 1000));
	};

	deleteVehicle _smoke;
	deleteVehicle _dirt;
};

{[_x] call tsp_fnc_crash_handler} forEach vehicles; 
addMissionEventHandler ["EntityCreated", {params ["_entity"]; [_entity] call tsp_fnc_crash_handler}];
