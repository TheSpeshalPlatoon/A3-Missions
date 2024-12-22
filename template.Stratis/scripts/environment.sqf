["tsp_param_time_day", "SLIDER", "Time Acceleration (Day)", "", "TSP Environment", [0,120,6], {}] call tsp_fnc_setting;
["tsp_param_time_night", "SLIDER", "Time Acceleration (Night)", "", "TSP Environment", [0,120,12], {}] call tsp_fnc_setting;
["tsp_param_brightness", "SLIDER", "Brighter Night", "", "TSP Environment", [0,1,0.3], {if (isServer) then {[] call tsp_fnc_environment_bright}}] call tsp_fnc_setting;

["tsp_param_sun", "SLIDER", "Light Shafts", "", "TSP Environment", [0,5,1], {"LightShafts" ppEffectAdjust [0.1*tsp_param_sun,0.5*tsp_param_sun,0.5*tsp_param_sun,0.9*tsp_param_sun]}] call tsp_fnc_setting;

["tsp_param_weather", "CHECKBOX", "Dynamic Weather", "Changes weather dynamically", "TSP Environment", true] call tsp_fnc_setting;
["tsp_param_weatherTime", "SLIDER", "Dynamic Weather Time", "Measured in minutes.", "TSP Environment", [1,90,15]] call tsp_fnc_setting;
["tsp_param_weatherChange", "CHECKBOX", "Update Weather", "Change setting to initiate weather change.", "TSP Environment", true, {if (isServer) then {[] spawn tsp_fnc_environment_weather}}] call tsp_fnc_setting;

["tsp_param_overcast", "SLIDER", "Overcast", "", "TSP Environment", [0,1,1]] call tsp_fnc_setting;
["tsp_param_overcastMin", "SLIDER", "Overcast (Min)", "", "TSP Environment", [0,1,0]] call tsp_fnc_setting;
["tsp_param_overcastMax", "SLIDER", "Overcast (Max)", "", "TSP Environment", [0,1,1]] call tsp_fnc_setting;

["tsp_param_lightning", "SLIDER", "Lightning", "", "TSP Environment", [0,1,1]] call tsp_fnc_setting;
["tsp_param_lightningMin", "SLIDER", "Lightning (Min)", "", "TSP Environment", [0,1,0]] call tsp_fnc_setting;
["tsp_param_lightningMax", "SLIDER", "Lightning (Max)", "", "TSP Environment", [0,1,1]] call tsp_fnc_setting;

["tsp_param_rain", "SLIDER", "Rain", "", "TSP Environment", [0,1,0.5]] call tsp_fnc_setting;
["tsp_param_rainMin", "SLIDER", "Rain (Min)", "", "TSP Environment", [0,1,0]] call tsp_fnc_setting;
["tsp_param_rainMax", "SLIDER", "Rain (Max)", "", "TSP Environment", [0,1,1]] call tsp_fnc_setting;

["tsp_param_fog", "SLIDER", "Fog", "", "TSP Environment", [0,1,0.5]] call tsp_fnc_setting;
["tsp_param_fogMin", "SLIDER", "Fog (Min)", "", "TSP Environment", [0,1,0]] call tsp_fnc_setting;
["tsp_param_fogMax", "SLIDER", "Fog (Max)", "", "TSP Environment", [0,1,0.01]] call tsp_fnc_setting;

["tsp_param_wave", "SLIDER", "Wave", "", "TSP Environment", [0,1,0.5]] call tsp_fnc_setting;
["tsp_param_waveMin", "SLIDER", "Wave (Min)", "", "TSP Environment", [0,1,0]] call tsp_fnc_setting;
["tsp_param_waveMax", "SLIDER", "Wave (Max)", "", "TSP Environment", [0,1,1]] call tsp_fnc_setting;

["tsp_param_wind", "SLIDER", "Wind", "", "TSP Environment", [0,1,1]] call tsp_fnc_setting;
["tsp_param_windMin", "SLIDER", "Wind (Min)", "", "TSP Environment", [0,1,0]] call tsp_fnc_setting;
["tsp_param_windMax", "SLIDER", "Wind (Max)", "", "TSP Environment", [0,1,1]] call tsp_fnc_setting;

tsp_fnc_environment_bright = {  //tsp_param_brightness = 1; [] call tsp_fnc_environment_bright;
	params [["_brightness", tsp_param_brightness],["_colour", [0.5,0.7,1]]];
	if (isNil "tsp_night_light") then {tsp_night_light = "#lightpoint" createVehicle [0,0,0]};  //-- Initial call only
	tsp_night_light setLightAttenuation [1e+011,150,4.31918e-005,4.31918e-005];
	tsp_night_light setLightBrightness _brightness; 
	tsp_night_light setLightDayLight false;
	tsp_night_light setLightAmbient _colour;
};

tsp_fnc_environment_weather = {
	params [
		["_force",false],["_instant",false],["_speed",tsp_param_weatherTime*60],
		["_overcastChance",tsp_param_overcast],["_overcastMin",tsp_param_overcastMin],["_overcastMax",tsp_param_overcastMax],
		["_rainChance",tsp_param_rain],["_rainMin",tsp_param_rainMin],["_rainMax",tsp_param_overcastMax],
		["_lightningChance",tsp_param_lightning],["_lightningMin",tsp_param_lightningMin],["_lightningMax",tsp_param_lightningMax],
		["_fogChance",tsp_param_fog],["_fogMin",tsp_param_fogMin],["_fogMax",tsp_param_fogMax],
		["_waveChance",tsp_param_wave],["_waveMin",tsp_param_waveMin],["_waveMax",tsp_param_waveMax],
		["_windChance",tsp_param_wind],["_windMin",tsp_param_windMin],["_windMax",tsp_param_windMax]
	];

	systemChat "----==== CURRENT ====----";	
	{systemChat ((_x#0)+": "+str(_x#1))} forEach [["OVERCAST",overcast],["RAIN",rain],["LIGHTNING",lightnings],["FOG",fog],["WAVE",waves],["WIND",wind]];

	_overcast = [_overcastMin,_overcastMax] call BIS_fnc_randomNum;
	_rain = [_rainMin,_rainMax] call BIS_fnc_randomNum;
	_lightning = [_lightningMin,_lightningMax] call BIS_fnc_randomNum;
	_fog = [_fogMin,_fogMax] call BIS_fnc_randomNum;
	_wave = [_waveMin,_waveMax] call BIS_fnc_randomNum;
	_wind = [_windMin,_windMax] call BIS_fnc_randomNum;

	systemChat "----==== FORECAST ====----";
	if (_instant) then {_speed = 0};
	if (isNil "tsp_overcastTime") then {tsp_overcastTime = -9999};
	if (random 1 < _overcastChance && (time > (tsp_overcastTime + (60/timeMultiplier)*60) || _force)) then {0 setOvercast _overcast; tsp_overcastTime = time; systemChat ("OVERCAST: "+str _overcast)};
	if (random 1 < _rainChance) then {_speed setRain _rain; systemChat ("RAIN: "+str _rain)};
	if (random 1 < _lightningChance) then {_speed setLightnings _lightning; systemChat ("LIGHTNING: "+str _lightning)};
	if (random 1 < _fogChance) then {_speed setFog _fog; systemChat ("FOG: "+str _fog)}; if (fog > _fogMax) then {60 setFog _fog};  //-- If fog is running out of control, fix it
	if (random 1 < _waveChance) then {_speed setWaves _wave; systemChat ("WAVE: "+str _wave)};
	if (random 1 < _windChance) then {setWind [_wind,_wind,true]; systemChat ("WIND: "+str _wind)};
	if (_instant) then {sleep 0.1; forceWeatherChange};	
};

[] call tsp_fnc_environment_bright;
[] spawn {while {sleep (tsp_param_weatherTime*60); isServer && !is3DEN && tsp_param_weather} do {[] spawn tsp_fnc_environment_weather}};

(date call BIS_fnc_sunriseSunsetTime) params ["_sunrise", "_sunset"];
while {sleep 10; isServer && !is3DEN} do {setTimeMultiplier (if (daytime < _sunrise || daytime > _sunset) then {tsp_param_time_night} else {tsp_param_time_day})};
