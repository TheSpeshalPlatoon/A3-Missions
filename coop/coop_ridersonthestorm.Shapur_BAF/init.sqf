
[
	west, ["airfield"], "Capture Airfield", "Assault and clear the enemy airfield.", "Attack", getPos task_airfield, 
	{true}, {"airfield_close" call tsp_fnc_sector_check && (count (allUnits select {_x inArea task_airfield && side _x == resistance}) < 2)}
] spawn tsp_fnc_task;
[
	west, ["ammo"], "Capture Ammo Storage", "Assault and clear the ammo storage facility.", "Attack", getPos task_ammo, 
	{true}, {"ammo_close" call tsp_fnc_sector_check && (count (allUnits select {_x inArea task_ammo && side _x == resistance}) < 2)}
] spawn tsp_fnc_task;
[
	west, ["aircraft"], "Destroy Aircraft", "Destroy at least 3 Mig-21s stationed at the airfield.", 
	"Destroy", objNull, {true}, {!alive task_mig1 && !alive task_mig2 && !alive task_mig3}
] spawn tsp_fnc_task;
[
	west, ["radar"], "Destroy Radars", "Destroy 2 enemy radar units in the AO.", 
	"Destroy", objNull, {true}, {!alive task_radar1 && !alive task_radar2}
] spawn tsp_fnc_task;

tsp_dust = true;
while {tsp_dust} do {_duration = (random 120) max 60; [10, _duration, false, false, false, 0.3] execVM "AL_dust_storm\al_duststorm.sqf"; uiSleep ((random 300) max 150)};