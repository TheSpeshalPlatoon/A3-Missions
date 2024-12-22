["tsp_cba_flare_altitude", "SLIDER", "Cutoff Altitude", "Kill flare when this close to the ground.", "TSP Flare", [-10, 100, 10]] call tsp_fnc_setting;
["tsp_cba_flare_size", "SLIDER", "Size", "Size of the lens flare.", "TSP Flare", [0, 1000, 10]] call tsp_fnc_setting;
["tsp_cba_flare_intensity", "SLIDER", "Intensity", "How intense the flare is.", "TSP Flare", [0, 1000000, 200000]] call tsp_fnc_setting;
["tsp_cba_flare_fluctuation", "SLIDER", "Fluctuation", "How much the intensity fluctuates over time.", "TSP Flare", [0, 1000000, 100000]] call tsp_fnc_setting;
["tsp_cba_flare_distance", "SLIDER", "Distance", "How far the lens flare can been seen from.", "TSP Flare", [0, 12000, 4000]] call tsp_fnc_setting;
["tsp_cba_flare_time", "SLIDER", "Time", "How long the flare will last in seconds.", "TSP Flare", [0, 600, 300]] call tsp_fnc_setting;
["tsp_cba_flare_velocity", "SLIDER", "Velocity", "How slowly the flare descends.", "TSP Flare", [0, 10, 1]] call tsp_fnc_setting;
["tsp_cba_flare_jitter", "SLIDER", "Jitter", "Flare movement in air.", "TSP Flare", [0, 10, 1]] call tsp_fnc_setting;
["tsp_cba_flare_sound", "CHECKBOX", "Sound", "Enables pop and burning sounds.", "TSP Flare", true] call tsp_fnc_setting;

tsp_fnc_flare = {  //-- Should only be run on flare owner
	params ["_flare", ["_timeStop", time + tsp_cba_flare_time], ["_altitudeStop", tsp_cba_flare_altitude], ["_jitter", tsp_cba_flare_jitter], ["_velocity", tsp_cba_flare_velocity], ["_sound", tsp_cba_flare_sound]];
	if (getNumber(configFile >> 'CfgAmmo' >> (typeOf _flare) >> 'brightness') < 10) exitWith {}; sleep 2.5;
	[createVehicle ["Land_PencilGreen_F", getPos _flare, [], 0, "CAN_COLLIDE"], "#lightpoint" createVehicle [0,0,0], (getPos _flare)#2] params ["_fake", "_light", "_startHeight"];
	[_light, _fake, getArray(configFile >> "CfgAmmo" >> typeOf _flare >> "lightColor")] remoteExec ["tsp_fnc_flare_client", 0, true]; _flare attachTo [_fake, [0,0,0]];
	if ((getPos _fake)#2 < _altitudeStop) then {_altitudeStop = -1};  //-- Dont kill flare if shot at ground
	if (_sound) then {playSound3D [tsp_path + "data\sounds\pop.ogg", _fake, false, getPosASL _fake, 3, 1, 5000]};
	if (_sound) then {_fake spawn {while {sleep 10; alive _this} do {playSound3D [tsp_path + "data\sounds\burn.ogg", _this, false, getPosASL _this, 1, 1, 50]}}};
	waitUntil {sleep 0.1; _fake setVelocity [random selectRandom [_jitter, -_jitter], random selectRandom [_jitter, -_jitter], -_velocity]; !alive _fake || time > _timeStop || (getPos _fake)#2 < _altitudeStop};
	{if (!isNull _light) then {_x setPos [0,0,0]; deleteVehicle _x}} forEach [_fake, _light, _flare];  //-- Set pos to stop/move the sound instantly
};

tsp_fnc_flare_client = {  //-- Should be run on all clients
	params ["_light", "_fake", "_colour"]; _colour params ["_r","_g","_b","_a"];
	_light lightAttachObject [_fake, [0, 0, 0]]; _light setLightAmbient [_r,_g,_b]; _light setLightColor [_r,_g,_b];
	_light setLightUseFlare true; _light setLightFlareMaxDistance tsp_cba_flare_distance;
	while {sleep 0.1 + random 0.1; !isNull _light} do {_light setLightIntensity tsp_cba_flare_intensity + random tsp_cba_flare_fluctuation; _light setLightFlareSize tsp_cba_flare_size};
};	

{if (local _x) then {_x addEventHandler ["Fired", {[_this#6] spawn tsp_fnc_flare}]}} forEach allUnits; 
addMissionEventHandler ["EntityCreated", {params ["_entity"]; if (local _entity) then {_entity addEventHandler ["Fired", {[_this#6] spawn tsp_fnc_flare}]}}];