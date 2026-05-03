tsp_fnc_halo_godzilla = {
	params ["_unit"]; sleep 1;
	//_chem = createVehicle ["Chemlight_red", getpos _unit, [], 0, "CAN_COLLIDE"];
	//_chem attachTo [_unit, [0,0,0], "LeftFoot"];

	_light = "#lightpoint" createVehicleLocal (getPos _unit);
	_light setLightColor [1,0.1,0.1]; _light setLightAmbient [1,0,0];
	_light setLightUseFlare true; _light setLightFlareSize 3; 
	_light setLightFlareMaxDistance 1000; _light setLightBrightness 0.5;
	_light attachTo [_unit, [0,0,0.2], "LeftFoot"];

	_smoke = "#particleSource" createVehicleLocal (getPos _unit);
	_smoke setParticleRandom [5,[0.2,0.2,0.2],[0.2,0.2,0.2],90,1,[0.1,0.1,0.1,0.1],90,0];
	_smoke setDropInterval 0.01;
	_smoke setParticleParams [
		["\A3\data_f\cl_basic.p3d",1,0,1,0],  //--Shape
		"",                                  //-- Animation Name
		"Billboard",                        //-- Particle Type
		1,                                 //-- Time Period
		2.5,                              //-- Life Time
		[0,0,0],                         //-- Position
		[0,0,0],                        //-- Velocity
		0,                             //-- Rotation Velocity
		1.3,                          //-- Weight
		1,                           //-- Volume
		0.05,                       //-- Rubbing
		[2,2,2],                   //-- Size
		[[1,0,0,0.5]],            //-- Color
		[1],                     //-- AnimationPhase
		0,                      //-- Random Direction Period
		0,                     //-- Random Direction Intensity
		"",                   //-- OnTimer
		"",    		         //-- Before Destroy
		[0,0,0]             //-- Object
	];
	_smoke attachTo [_unit, [0,0,0], "LeftFoot"];

	waitUntil {sleep 1; (getPosATL _unit)#2 < 100};
	deleteVehicle _light;
	deleteVehicle _smoke;
	//detach _chem;
};

tsp_fnc_halo = {
	params ["_unit", ["_zone", c130_zone], ["_godzilla", false]];
	while {sleep 0.5; _unit inArea _zone} do {addCamShake [1, 5, 5]};
	_freefall = selectMax (velocity _unit apply {abs _x}) > 2 && "halo" in animationState _unit;
	if (_freefall && _godzilla) then {[_unit] remoteExec ["tsp_fnc_halo_godzilla", 0]};
	if (_freefall) then {for "_i" from 1 to 2 do {_unit setVelocity [0,10,0]; sleep 0.5}};
};

button1 setVariable ["isActivated", false]; button1 addAction ["Activate Button 1", "scripts\activateButton.sqf", bunker_door];
button2 setVariable ["isActivated", false]; button2 addAction ["Activate Button 2", "scripts\activateButton.sqf", bunker_door];
button3 setVariable ["isActivated", false]; button3 addAction ["Activate Button 3", "scripts\activateButton.sqf", bunker_door];

if ((!isServer) && (player != player)) then {waitUntil {player == player};};

/*
================================================================================================================================
>>>>> SNOW STORM Parameters =======================
================================================================================================================================
null = ["_snowfall","_duration_storm","_ambient_sounds_al","_breath_vapors","_snow_burst","_effect_on_objects","_vanilla_fog","_no_snow_indoor","_local_fog","_intensifywind","_unitsneeze"] execvm "AL_snowstorm\al_snow.sqf";

snowfall			- boolean, if true snowflakes made out of particles will be created
duration_storm		- number, life time of the SNOW STORM expressed in seconds
ambient_sounds_al	- seconds/number, a random number will be generated based on your input value and used to set the frequency for played ambient sounds
					- if is negative NO custom ambient sounds will be played
breath_vapors		- boolean, if true you will see breath vapors for all units, however if you have many units in your mission you should set this false to diminish the impact on frames
snow_burst			- seconds/number, if higher than 0 burst of snow will be generated at intervals based on your value
effect_on_objects	- boolean, if is true occasionally a random object will be pushed by the wind during the snow burst if the later is enabled
vanilla_fog			- boolean, vanilla fog will be managed by the script if true, otherwise the values you set in editor will be used 
local_fog			- boolean, if true particles will be used to create sort of waves of fog and snow
intensifywind		- boolean, if is true the wind will blow with force otherwise default value from Eden or other script will be used
unitsneeze			- boolean, if is true the at random units will sneeze/caugh and will shiver when snow burst occurs
*/
[true,60*120,15,true,5,false,true,false,false,false] execvm "AL_snowstorm\al_snow.sqf";