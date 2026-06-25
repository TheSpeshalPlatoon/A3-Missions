if (!isServer) exitWith {};

[
	west, ["radio"], "Destroy Communications Truck", "There is a GAZ communications vehicle somewhere in the AO. Destroy it to impede the CHDKZ's ability to communicate.", "Destroy", objNull, 
	{true}, {!alive task_radio}
] spawn tsp_fnc_task;
[
	west, ["aaa"], "Destroy ZSU", "There is a ZSU-23 somewhere in the AO, likely around Staroye. Find it and destroy it.", "Destroy", objNull, 
	{true}, {!alive task_aaa}
] spawn tsp_fnc_task;
[
	west, ["pilot"], "Rescue Crew", "A CDF attack helicopter was shot down by AA somewhere in the AO, if possible, extract the 2 man crew to friendly territory.", "Heli", objNull, 
	{true}, {((!alive task_pilot1 || task_pilot1 inArea task_hostage) && (!alive task_pilot2 || task_pilot2 inArea task_hostage) && (alive task_pilot1 || alive task_pilot2))}, {!alive task_pilot1 && !alive task_pilot2}
] spawn tsp_fnc_task;
[
	west, ["castle"], "Capture Castle", "The castle is a known CHDKZ position. Raid the castle.", "Attack", getPos task_castle, 
	{true}, {"castle" call tsp_fnc_sector_check && (count (allUnits select {_x inArea task_castle && side _x == east}) < 2)}
] spawn tsp_fnc_task;