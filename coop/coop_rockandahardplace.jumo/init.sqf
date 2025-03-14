if (!isServer) exitWith {};

[west, "primary", ["Main objectives are to destroy 2 radars on the island ahead of the invasion.", "Primary Objectives"], objNull, "CREATED", -1, true, "Target"] call BIS_fnc_taskCreate;
[west, "secondary", ["Secondary objectives are to clear the shorelines of enemy defenses whether it'd be bunkers, tanks, or AAA. There's also an officer awaiting capture or death", "Secondary Objectives"], objNull, "CREATED", -1, true, "Scout"] call BIS_fnc_taskCreate;

[
	west, ["aa", "primary"], "Destroy Anti-Air Radar", "The Russians have an <marker name='marker_2'>Anti-Air radar close to the shore</marker>, we need it destroyed before the Air Force and Navy start their strikes.", 
	"Destroy", getPos task_aa, {alive task_aa}, {!alive task_aa}, {false}
] spawn tsp_fnc_task;
[
	west, ["as", "primary"], "Destroy Anti-Ship Radar", "Russian navy has an Anti-Ship radar that allows them to find and track ships for its Anti-Ship Missile Launchers, we cannot allow them to discover us but we cannot scrub tomorrow's landing neither, so any evasive action from our fleet is not an option. <marker name='marker_3'>Destroy it</marker>.", 
	"Destroy", getPos task_as, {alive task_as}, {!alive task_as}, {false}
] spawn tsp_fnc_task;
[
	west, ["officer", "secondary"], "Kill/Capture HVT Officer", "SIGINT sources say that a VDV officer is currently residing inside <marker name='marker_6'>a ranch</marker> somewhere, make it his last holiday or get him back to the boats for us to interrogate.", 
	"Kill", objNull, {true}, {task_officer distance trigger_captivezone < 100 || !alive task_officer}, {false}
] spawn tsp_fnc_task;
[
	west, ["tanktanktank", "secondary"], "Destroy Tanks", "Satellite imagery showed 2 tanks entering the AO, destroy their force multiplier before they can use it on our boys tomorrow. Be careful if the crew is still inside the tank, you never know these days.", 
	"Destroy", objNull, {true}, {!alive task_tank1 && !alive task_tank2}, {false}
] spawn tsp_fnc_task;
[
	west, ["bunkers", "secondary"], "Clear Bunkers", "HUMINT and SIGINT reports say that the Russians have occupied pillboxes and bunkers on the shores of Kaska, burn 'em out, and the rest of the MAGTF will have an easier day tomorrow. We only need 3 of these bunkers be cleared out. (Tip: look for any out of place structure markers hidden in the woods on the map or any pillboxes by the shoreline)", 
	"Attack", objNull, {true}, {count (["bunker1", "bunker2", "bunker3", "bunker4"] select {_x call BIS_fnc_taskState in ["SUCCEEDED", "FAILED"]}) == 3}
] spawn tsp_fnc_task;
[
	east, ["bunker1", "secondary"], "Bunker1", "", 
	"Attack", objNull, {true}, {(tsp_sector_info select {_x#0 == "bunker1"})#0#1 && (count (allUnits select {_x inArea trigger_bunker1 && side _x == east}) < 1)}
] spawn tsp_fnc_task;
[
	east, ["bunker2", "secondary"], "Bunker2", "", 
	"Attack", objNull, {true}, {(tsp_sector_info select {_x#0 == "bunker2"})#0#1 && (count (allUnits select {_x inArea trigger_bunker2 && side _x == east}) < 1)}
] spawn tsp_fnc_task;
[
	east, ["bunker3", "secondary"], "Bunker3", "", 
	"Attack", objNull, {true}, {(tsp_sector_info select {_x#0 == "bunker3"})#0#1 && (count (allUnits select {_x inArea trigger_bunker3 && side _x == east}) < 1)}
] spawn tsp_fnc_task;
[
	east, ["bunker4", "secondary"], "Bunker4", "", 
	"Attack", objNull, {true}, {(tsp_sector_info select {_x#0 == "aaradar"})#0#1 && (count (allUnits select {_x inArea trigger_bunker4 && side _x == east}) < 1)}
] spawn tsp_fnc_task;
[
	west, ["supplies", "secondary"], "Destroy Supplies", "Supply convoys have been going in and out of the AO recently, we need to see if that ammo is up to condition, blow it all up. We don't know their exact locations as of now but SIGINT and HUMINT sources say that some of them might be hidden inside a warehouse or are on their way outside the AO", 
	"Truck", objNull, {true}, {!alive task_supply1 && !alive task_supply2 && !alive task_supply3}, {false}
] spawn tsp_fnc_task;
[
	west, ["aaa", "secondary"], "Destroy AAA", "The Russians have a ZU-23 setup on the shore and another hidden inside a warehouse, destroy these so that we can send choppers for CAS and MEDEVAC tomorrow.", 
	"Destroy", objNull, {alive task_as}, {!alive task_zu1 && !alive task_zu2}, {false}
] spawn tsp_fnc_task;