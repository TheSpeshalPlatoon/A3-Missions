if (!isServer) exitWith {};

[
	west, "villa", "Secure Villa", "Secure the main compound which consists of multiple residential structures.", 
	"Attack", "sector_villa", {true}, {["villa", "villa", sector_villa, 0, 1, [west,east]] call tsp_fnc_sector_clear}
] spawn tsp_fnc_task;
[
	west, "port", "Secure Port", "Secure the port's few industrial structures and surrounding area.", 
	"Attack", "sector_port", {true}, {["port", "port", sector_port, 0, 1, [west,east]] call tsp_fnc_sector_clear}
] spawn tsp_fnc_task;
[
	west, "temple", "Secure Temple", "Secure the area around the temple.", 
	"Attack", "sector_temple", {true}, {["temple", "temple", sector_temple, 0, 1, [west,east]] call tsp_fnc_sector_clear}
] spawn tsp_fnc_task;
[
	west, "cave", "Secure Cave", "Secure the cave underneath the temple.", 
	"Attack", objNull, {"temple" call BIS_fnc_taskState == "SUCCEEDED"}, {["cave", "cave", sector_cave, 0, 0, [west,east]] call tsp_fnc_sector_clear}
] spawn tsp_fnc_task;
[
	west, ["hvt"], "Kill/Capture Epstein", "Kill or capture Jeffrey Epstein, he could be hiding anywhere on the island.", 
	"Kill", objNull, {true}, {task_hvt distance ssgn < 100 || !alive task_hvt}, {false}
] spawn tsp_fnc_task;
[
	west, ["intel"], "Secure the Files", "Find and secure the Epstein files somewhere in the AO.", 
	"Download", objNull, {true}, {!isNil "tsp_epstein_files"}, {false}
] spawn tsp_fnc_task;

addMissionEventHandler ["EntityCreated", {  //-- Change group sides of enemies to EAST
	params ["_entity"];
	if !("_ion_" in typeOf _entity) exitWith {};
	_entity enableSimulation false;	_entity spawn {sleep 3; _this enableSimulation true};
	_entity spawn {
		sleep 1;
		_old = group _this;
		if (_this != leader _old) exitWith {};
		_new = createGroup [east, true];
		_new setGroupId [groupId _old];
		_new copyWaypoints _old;
		_new setBehaviour "SAFE";
		_new setSpeedMode "LIMITED";
		units _old joinSilent _new;
	};
}];