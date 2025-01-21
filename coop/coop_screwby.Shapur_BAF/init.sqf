if (!isServer) exitWith {};

[
	west, ["shapur1"], "Shapur-1", "Alpha 1 reports a large Takistani Army presence inside the industrial complex of Shapur-1, clear the area of enemies.", 
	"Attack", getPos task_shapur1, {true}, {(tsp_sector_info select {_x#0 == "shapur1"})#0#1 && (count (allUnits select {_x inArea trigger_shapur1 && side _x == resistance}) < 2)}
] spawn tsp_fnc_task;

[
	west, ["shapur2"], "Shapur-2", "Drone surveillance picked up Takistan Army presence inside the complex aswell as the workers being taken hostage and put inside a building, secure the complex and save the workers.", 
	"Attack", getPos task_shapur2, {true}, {(tsp_sector_info select {_x#0 == "shapur2"})#0#1 && (count (allUnits select {_x inArea trigger_shapur2 && side _x == resistance}) < 2)}
] spawn tsp_fnc_task;

[
	west, ["mb"], "Military Base", "The Karzeghistan Royal Guard previously occupied the military base until the Takistani mechanized division rolled on top of them, last report confirmed that the Takistani Army have breached the base. Assault the base and retake it.", 
	"Attack", getPos task_mb, {true}, {(tsp_sector_info select {_x#0 == "mb"})#0#1 && (count (allUnits select {_x inArea trigger_mb && side _x == resistance}) < 2)}
] spawn tsp_fnc_task;

[
	west, ["airfield"], "Airfield", "Drone surveillance picked up a large composition of Takistani armor and air on the airfield, use the violence of action to your advantage and secure the airfield.", 
	"Attack", getPos task_airfield, {true}, {(tsp_sector_info select {_x#0 == "airfield"})#0#1 && (count (allUnits select {_x inArea trigger_airfield && side _x == resistance}) < 2)}
] spawn tsp_fnc_task;

[
	west, ["oli"], "Oil Storage Facility", "Debriefed evacuees report seeing Takistani special forces consolidating at the Oil Storage facility, eliminate them before they get a chance to step off.", 
	"Attack", getPos task_oli, {true}, {(tsp_sector_info select {_x#0 == "oli"})#0#1 && (count (allUnits select {_x inArea trigger_oli && side _x == resistance}) < 2)}
] spawn tsp_fnc_task;