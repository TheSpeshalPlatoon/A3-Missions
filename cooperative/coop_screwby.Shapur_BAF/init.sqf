if (!isServer) exitWith {};

[
	west, ["shapur1"], "Shapur-1", "Alpha 1 reports a large Takistani Army presence inside the industrial complex of Shapur-1, clear the area of enemies.", 
	"Attack", "sector_shapur1", {true}, {["shapur1", "", sector_shapur1, 0, 0] call tsp_fnc_sector_clear}
] spawn tsp_fnc_task;

[
	west, ["shapur2"], "Shapur-2", "Drone surveillance picked up Takistan Army presence inside the complex aswell as the workers being taken hostage and put inside a building, secure the complex and save the workers.", 
	"Attack", "sector_shapur2", {true}, {["shapur2", "", sector_shapur2, 0, 0] call tsp_fnc_sector_clear}
] spawn tsp_fnc_task;

[
	west, ["mb"], "Military Base", "The Karzeghistan Royal Guard previously occupied the military base until the Takistani mechanized division rolled on top of them, last report confirmed that the Takistani Army have breached the base. Assault the base and retake it.", 
	"Attack", "sector_mb", {true}, {["mb", "", sector_mb, 0, 0] call tsp_fnc_sector_clear}
] spawn tsp_fnc_task;

[
	west, ["airfield"], "Airfield", "Drone surveillance picked up a large composition of Takistani armor and air on the airfield, use the violence of action to your advantage and secure the airfield.", 
	"Attack", "sector_airfield", {true}, {["airfield", "", sector_airfield, 0, 0] call tsp_fnc_sector_clear}
] spawn tsp_fnc_task;

[
	west, ["oli"], "Oil Storage Facility", "Debriefed evacuees report seeing Takistani special forces consolidating at the Oil Storage facility, eliminate them before they get a chance to step off.", 
	"Attack", "sector_oli", {true}, {["oli", "", sector_oli, 0, 0] call tsp_fnc_sector_clear}
] spawn tsp_fnc_task;