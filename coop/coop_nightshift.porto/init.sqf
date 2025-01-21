[[
	[3,{}], [5,{
		[4,2,false] call bis_fnc_animatedScreen;
		[true, ["Sahrani Islands, 2015"]] spawn BIS_fnc_OM_AS_ShowStaticText;
		uiSleep 3; [3,2,false] call bis_fnc_animatedScreen;
	}],	[5,{
		[4,2,false] call bis_fnc_animatedScreen;
		[5,1,"\tsp_core\data\sahrani\01_b.paa",nil,nil,1] call bis_fnc_animatedScreen; [6,1,8,nil,1.1] call bis_fnc_animatedScreen;
		[5,2,"\tsp_core\data\sahrani\01_f.paa",nil,nil,1] call bis_fnc_animatedScreen; [6,2,8,nil,1.2] call bis_fnc_animatedScreen;
		uiSleep 3; [3,2,false] call bis_fnc_animatedScreen;
	}],	[8,{
		[4,2,false] call bis_fnc_animatedScreen;
		[true, ["The Sahrani islands are divided into two factions; the pro-U.S. Southern monarchy and the formerly Soviet-backed North."], 4] spawn BIS_fnc_OM_AS_ShowStaticText;
		uiSleep 6; [3,2,false] call bis_fnc_animatedScreen;
	}],	[5,{
		[4,2,false] call bis_fnc_animatedScreen;
		[5,1,"\tsp_core\data\sahrani\02_b.paa",nil,nil,1] call bis_fnc_animatedScreen; [6,1,8,nil,1.1] call bis_fnc_animatedScreen;
		[5,2,"\tsp_core\data\sahrani\02_f.paa",nil,nil,1] call bis_fnc_animatedScreen; [6,2,8,nil,1.2] call bis_fnc_animatedScreen;
		uiSleep 3; [3,2,false] call bis_fnc_animatedScreen;
	}], [8,{
		[4,2,false] call bis_fnc_animatedScreen;
		[true, ["After a 4 year long training deployment, the U.S. Army advisory force packed up and left the South."], 4] spawn BIS_fnc_OM_AS_ShowStaticText;
		uiSleep 6; [3,2,false] call bis_fnc_animatedScreen;
	}],	[5,{
		[4,2,false] call bis_fnc_animatedScreen;
		[5,1,"\tsp_core\data\sahrani\03_b.paa",nil,nil,1] call bis_fnc_animatedScreen; [6,1,8,nil,1.1] call bis_fnc_animatedScreen;
		[5,2,"\tsp_core\data\sahrani\03_f.paa",nil,nil,1] call bis_fnc_animatedScreen; [6,2,8,nil,1.2] call bis_fnc_animatedScreen;
		uiSleep 3; [3,2,false] call bis_fnc_animatedScreen;
	}], [8,{
		[4,2,false] call bis_fnc_animatedScreen;
		[true, ["At that same time however, the North readied its entire army to conduct a full-scale invasion of the South."], 4] spawn BIS_fnc_OM_AS_ShowStaticText;
		uiSleep 6; [3,2,false] call bis_fnc_animatedScreen;
	}], [10,{
		[4,2,false] call bis_fnc_animatedScreen;
		[true, ["Barely a few days after the bulk of U.S. forces leave the country, the Sahrani Liberation Army launches its invasion, striking across the border directly into Southern territories."], 4] spawn BIS_fnc_OM_AS_ShowStaticText;
		uiSleep 8; [3,2,false] call bis_fnc_animatedScreen;
	}],	[5,{
		[4,2,false] call bis_fnc_animatedScreen;
		[5,1,"\tsp_core\data\sahrani\04_b.paa",nil,nil,1] call bis_fnc_animatedScreen; [6,1,8,nil,1.1] call bis_fnc_animatedScreen;
		[5,2,"\tsp_core\data\sahrani\04_b.paa",nil,nil,1] call bis_fnc_animatedScreen; [6,2,8,nil,1.2] call bis_fnc_animatedScreen;
		uiSleep 3; [3,2,false] call bis_fnc_animatedScreen;
	}], [8,{
		[4,2,false] call bis_fnc_animatedScreen;
		[true, ["The US 5th Fleet has been assigned to assisting the southern Royal Army Corps in retaking the islands."], 4] spawn BIS_fnc_OM_AS_ShowStaticText;
		uiSleep 6; [3,2,false] call bis_fnc_animatedScreen;
	}], [5,{
		[4,2,false] call bis_fnc_animatedScreen;
		[5,1,"\tsp_core\data\sahrani\05_b.paa",nil,nil,1] call bis_fnc_animatedScreen; [6,1,8,nil,1.1] call bis_fnc_animatedScreen;
		[5,2,"\tsp_core\data\sahrani\05_f.paa",nil,nil,1] call bis_fnc_animatedScreen; [6,2,8,nil,1.2] call bis_fnc_animatedScreen;
		uiSleep 3; [3,2,false] call bis_fnc_animatedScreen;
	}]
], "Music_FreeRoam_Russian_Theme", {[true] call tsp_fnc_role; [] spawn tsp_fnc_spawn_map}] spawn tsp_fnc_intro;

if (!isServer) exitWith {};

tsp_fnc_lcu = {
	params ["_lcu"];
    while {sleep 0.1; alive _lcu && !(_lcu inArea dismountZone)} do {_lcu setVelocityModelSpace [0,5,0]};
    _lcu animate ["ramp_front", 1]; sleep 5; {[_x] allowGetIn false; moveOut _x; sleep 1} forEach crew _lcu;
    {
		detach _x; while {sleep 0.1; _x inArea dismountZone} do {_x sendSimpleCommand "FORWARD"};
		sleep 2; _x forceSpeed 2; (group driver _x) copyWaypoints (group driver _x); 
	} forEach attachedObjects _lcu;
};

tsp_cond_invade = {count (["radio", "radar", "scud", "beach", "pilot"] select {_x call BIS_fnc_taskState in ["SUCCEEDED", "FAILED"]}) == 5};

[] spawn {
	{_x hideObjectGlobal true; _x enableSimulation false} forEach ((getMissionLayerEntities "racs")#0); 	
	waitUntil {sleep 5; dayTime > 4 || call tsp_cond_invade};
	if (dayTime > 4)  then {[west, "HQ"] sideChat "The invasion will begin on schedule despite the setbacks."};
	if !(dayTime > 4) then {[west, "HQ"] sideChat "Good job taking out their defences! Invasion will begin on schedule at 4AM."; tsp_param_time_night = 3; tsp_param_time_day = 3};
	waitUntil {sleep 5; dayTime > 4}; [west, "HQ"] sideChat "All units, move off your staging points, operation is a go."; 
	{_x hideObjectGlobal false; _x enableSimulation true} forEach ((getMissionLayerEntities "racs")#0); 
	[lcu1] spawn tsp_fnc_lcu; [lcu2] spawn tsp_fnc_lcu; [lcu3] spawn tsp_fnc_lcu; 
	boat1 setFuel 1; boat2 setFuel 1;
};

[west, "preparation", ["Preparation stage of the invasion. A USMC Recon will dismantle key SLA defences prior to main invasion force.", "Preparation"], objNull, "CREATED", -1, true, "Scout"] call BIS_fnc_taskCreate;
[west, "invasion", ["At 4AM, the invasion task force will move on key objects on Porto.", "Invasion"], objNull, "CREATED", -1, true, "Meet"] call BIS_fnc_taskCreate;

[
	west, ["radio", "preparation"], "Destroy Radio Tower", "Destroy the communications tower to prevent the garrisons on Porto from communicating with the main islands. Recommend to do this first to maintain the element of surprise.", 
	"Radio", getPos task_radio, {alive task_radio}, {!alive task_radio}, {false}, {dayTime > 4}
] spawn tsp_fnc_task;
[
	west, ["radar", "preparation"], "Destroy Radar", "Destroy the SLA radar and capture the nearby observation post.", 
	"Destroy", getPos task_radar, {alive task_radar}, {!alive task_radar}, {false}, {dayTime > 4}
] spawn tsp_fnc_task;
[
	west, ["beach", "preparation"], "Secure Beachhead", "Clear the beach in preparation for the landing force's arrival. Eliminate any enemy positions that could affect the landing.", 
	"GetIn", getPos task_lz, {true}, {(tsp_sector_info select {_x#0 == "bunkers"})#0#1 && (count (allUnits select {_x inArea trigger_bunkers && side _x == east}) < 2)}, {false}, {dayTime > 4}
] spawn tsp_fnc_task;
[
	west, ["scud", "preparation"], "Destroy Scud Launcher", "The SLA has 2 scud missile launchers in their inventory, one is known to be destroyed, and the other is believed to be somewhere on Porto, find and destroy it.", 
	"Destroy", objNull, {alive task_scud}, {!alive task_scud}, {false}, {dayTime > 4}
] spawn tsp_fnc_task;
[
	west, ["pilot", "preparation"], "Rescue Crew", "A RACS scout helicopter got lost at sea and was shot down on Porto somewhere on the eastern side of Porto, if time permits, search for the wreck and rescue the crew.", 
	"Heli", objNull, {true}, {task_pilot distance lpd < 100}, {!alive task_pilot}, {dayTime > 4}
] spawn tsp_fnc_task;

[
	west, ["ramirez", "invasion"], "Kill/Capture Ramirez", "Former president Ramirez is believed to be hiding out on Porto somewhere, intel indicates that he gave the order to invade of the south, find him and bring him in.", 
	"Kill", objNull, {dayTime > 4 || call tsp_cond_invade}, {task_ramirez distance lpd < 100 || !alive task_ramirez}, {false}
] spawn tsp_fnc_task;
[
	west, ["port", "invasion"], "Capture Port Area", "Capture all naval installations on the port, including the port itself. Make sure to eliminate all enemies.", 
	"Attack", getPos task_port, {dayTime > 4 || call tsp_cond_invade}, {(tsp_sector_info select {_x#0 == "port"})#0#1 && (count (allUnits select {_x distance task_port < 100 && side _x == east}) < 2)}
] spawn tsp_fnc_task;
[
	west, ["largo", "invasion"], "Capture Largo", "Largo is a small civilian settlement on Porto, scout the settlement for any SLA troops and secure it.", 
	"Attack", getPos task_largo, {dayTime > 4 || call tsp_cond_invade}, {(tsp_sector_info select {_x#0 == "largo"})#0#1 && (count (allUnits select {_x inArea trigger_largo && side _x == east}) < 2)}
] spawn tsp_fnc_task;	
[
	west, ["army", "invasion"], "Capture Army Barracks", "This is the main SLA Army garrison on Porto, most of the Army garrision should be over on Sahrani so the remaining guard troops should be relatively light and concentrated within the compound.", 
	"Attack", getPos task_army, {dayTime > 4 || call tsp_cond_invade}, {(tsp_sector_info select {_x#0 == "army_in"})#0#1 && (count (allUnits select {_x inArea trigger_army_in && side _x == east}) < 2)}
] spawn tsp_fnc_task;
[
	west, ["ship", "invasion"], "Board Landing Ship", "The Navy sank an SLA landing ship in the port before it could depart for Sahrani.", 
	"Navigate", getPos task_ship, {dayTime > 4 || call tsp_cond_invade}, {!alive task_assets && task_intel isEqualTo objNull}
] spawn tsp_fnc_task;
	[
		west, ["intel", "ship"], "Find Invasion Plans", "Search the ship for any useful intel that could help fight back againt the SLA's invasion of Sahrani.", 
		"Search", objNull, {dayTime > 4 || call tsp_cond_invade}, {task_intel isEqualTo objNull}
	] spawn tsp_fnc_task;
	[
		west, ["assets", "ship"], "Destroy Assets", "Destroy any vehicles and other assets on the ship to prevent the enemy from using them.", 
		"Destroy", objNull, {dayTime > 4 || call tsp_cond_invade}, {!alive task_assets}
	] spawn tsp_fnc_task;