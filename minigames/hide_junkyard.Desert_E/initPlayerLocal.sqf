tsp_dust = true;
while {tsp_dust} do {_duration = (random 120) max 60; [10, _duration, false, false, false, 0.3] execVM "AL_dust_storm\al_duststorm.sqf"; uiSleep ((random 300) max 150)};