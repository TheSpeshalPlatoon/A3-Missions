tsp_fnc_helmet = {_this spawn {sleep 1; _this addHeadgear (selectRandom ["UK3CB_H_HSAT_MKIII","UK3CB_H_HSAT_PTYPE"])}};

if (!isServer) exitWith {};

[
	west, ["hvt"], "Capture General Duarte Pereira", "Locate and capture General Duarte Pereira, the leader of the military junta, alive to stand trial. Navy airstrikes have been careful not to damage any structures as to not risk killing him.", 
	"Kill", objNull, {true}, {task_hvt distance lpd < 100}, {!alive task_hvt}
] spawn tsp_fnc_task;
[
	west, ["airfield"], "Airfield", "Secure the airfield on Isla Pera. This airstrip is the primary operating base for the regime's remaining aircraft and must be taken to prevent further sorties.", 
	"Attack", "sector_airfield_close", {true}, {["airfield_close", "", sector_airfield_close, 0, 3] call tsp_fnc_sector_clear}
] spawn tsp_fnc_task;
[
	west, ["mig", "airfield"], "Destroy Mig-21s", "Intel indicates at least three MiG-21 fighters are stationed at the airfield. All aircraft must be destroyed or otherwise rendered inoperable to eliminate Isla Pera's air capability.", 
	"Destroy", objNull, {true}, {!alive task_mig}
] spawn tsp_fnc_task;
[
	west, ["dam"], "Secure Dam Area", "Take control of the dam and surrounding facilities. The structure provides power and strategic control over the region and cannot remain in hostile hands.", 
	"Attack", "sector_dam", {true}, {["dam", "", sector_dam, 200, 2] call tsp_fnc_sector_clear}
] spawn tsp_fnc_task;
[
	west, ["radar"], "Radar Facility", "Capture the radar installation overlooking the region. This site provides early warning and airspace monitoring for the regime and must be secured to blind their defenses.", 
	"Attack", "sector_radar_close", {true}, {["radar_close", "", sector_radar_close, 0, 1] call tsp_fnc_sector_clear}
] spawn tsp_fnc_task;
[
	west, ["military"], "Military Outpost", "Secure the military outpost near the dam. Enemy forces are using this location as a staging area for patrols and reinforcements.", 
	"Attack", "sector_military", {true}, {["military", "", sector_military, 100, 1] call tsp_fnc_sector_clear}
] spawn tsp_fnc_task;