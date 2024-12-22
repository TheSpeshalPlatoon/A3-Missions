tsp_fnc_sector_automate = {
	{
		if !(triggerText _x in getMissionLayers) then {continue};
		[triggerText _x] call tsp_fnc_sector_save;
		_x setTriggerActivation [triggerActivation _x#0, triggerActivation _x#1, true];
		_x setTriggerStatements [triggerStatements _x#0 + " && isServer", "['" + triggerText _x + "'] call tsp_fnc_sector_load", "['" + triggerText _x + "'] call tsp_fnc_sector_save"];
	} forEach allMissionObjects "EmptyDetector";
};

tsp_fnc_sector_save = {	
	params ["_layer", ["_sectorData", []]];	

	{_x setVariable ["layer", _layer]} foreach (getMissionLayerEntities _layer#0);  //-- Set variable on each object
	{{_x setVariable ["layer", "!"]} foreach (getMissionLayerEntities _x#0)} foreach (getMissionLayers select {"!" in _x});  //-- !Exceptions

	//-- Sector info
	if (tsp_sector_info findIf {_x#0 == _layer} == -1) then {tsp_sector_info pushBack [_layer, true]};
	if (count (tsp_sector_info select {_x#0 == _layer && _x#1}) == 0) exitWith {};  //-- CANT SAVE CAUSE ITS NOT LOADED
	tsp_sector_info set [tsp_sector_info findIf {_x#0 == _layer}, [_layer, false]]; publicVariable "tsp_sector_info";  //-- Set status to false

	_entities = allMissionObjects "All" select {_x getVariable "layer" == _layer && alive _x && vehicle _x == _x};	
	if !("@" in _layer) then {{_sectorData pushback ([_x] call tsp_fnc_sector_saveEntity)} foreach _entities};
	if ("@" in _layer) then {{_return = [_x, simulationEnabled _x]; _x enableSimulation false; _x hideObjectGlobal true; _sectorData pushback _return} foreach _entities};  //-- Simple layers

	missionNamespace setVariable ["layer_" + _layer, _sectorData];  //-- Create variable named after sector and save data to sector variable
};

tsp_fnc_sector_load = {
	params ["_layer", ["_force", false]];
	if ((count (tsp_sector_info select {_x#0 == _layer && _x#1}) > 0) && !_force) exitWith {};  //-- CANT LOAD CAUSE IT ALREADY EXISTS
	tsp_sector_info set [tsp_sector_info findIf {_x#0 == _layer}, [_layer, true]]; publicVariable "tsp_sector_info";  //-- Set status to true
	if !("@" in _layer) then {{([_x] call tsp_fnc_sector_loadEntity) setVariable ["layer", _layer]} foreach (missionNameSpace getVariable "layer_" + _layer)};  //-- Create stuffs, reassign layer variable
	if ("@" in _layer) exitWith {{_x params ["_unit", "_sim"]; _unit enableSimulation _sim; _unit hideObjectGlobal false} foreach (missionNameSpace getVariable "layer_" + _layer)};  //-- Simple layers
};

tsp_fnc_sector_saveEntity = {
	params ["_entity", ["_seatData", []], ["_crewData", []]];
	{  //-- For all live crew
		_x params ["_unit", "_role", "_cargoIndex", "_turretIndex"];
		_crewData pushback ([_unit, [_role, _cargoIndex, _turretIndex]] call tsp_fnc_sector_saveEntity);
	} forEach ((fullCrew _entity) select {alive (_x#0)});
	private _entityData = [
		typeOf _entity,                   					      //-- 0:  Classname
		getPosWorld _entity,                   					  //-- 1:  Position
		[vectorDir _entity, vectorUp _entity],  				  //-- 2:  Direction
		simulationEnabled _entity,       					      //-- 3:  Simulation
		isDamageAllowed _entity,                                  //-- 4:  Damage
		getUnitLoadout _entity,                                   //-- 5:  Loadout
		unitPos _entity,                                          //-- 6:  Stance
		group _entity,									          //-- 7:  Group
		leader group _entity == _entity,                          //-- 8:  Leader?
		_entity getVariable ["init", {}],                         //-- 0:  Init Code
		behaviour _entity,                                        //-- 10: Behaviour
		getAllHitPointsDamage _entity,                            //-- 11: Hitpoints
		[_entity] call BIS_fnc_getVehicleCustomization,           //-- 12: Vehicle Appearence
		locked _entity,                                           //-- 13: Vehicle Locks
		face _entity,                                             //-- 14: Face
		speaker _entity,                                          //-- 15: Voice
		name _entity,                                             //-- 16: Name
		vehicleVarName _entity,                                   //-- 17: Variable
		_seatData,                                                //-- 18: Seat
		_crewData                                                 //-- 19: Crew
	];
	{deletevehicle _x} forEach crew _entity; deletevehicle _entity;
	_entityData
};

tsp_fnc_sector_loadEntity = {
	params ["_entityData", ["_vehicle", objNull], ["_entity", objNull]];
	_entityData params ["_classname", "_position", "_direction", "_simulation", "_damage", "_loadout", "_stance", "_group", "_leader", "_init", "_behaviour", "_hitpoints", "_vehicleAppearence", "_vehicleLock", "_face", "_voice", "_name", "_varName", "_seatData", "_crewData"];

	if (_classname isKindOf "Man") then {  //-- For dudes
		_entity = _group createUnit [_classname, [0,0,0], [], 0, "CAN_COLLIDE"];
		_entity setUnitPos _stance;
		_entity setBehaviour _behaviour;
		_entity setSpeaker _voice;
		_entity setName _name;
		[_entity, _face] remoteExec ["setFace", 0, _entity];
		if (_leader) then {group _entity selectLeader _entity; group _entity copyWaypoints group _entity};	
	} else {  //-- For vehicles
		_entity = createVehicle [_classname, [0,0,0], [], 0, "CAN_COLLIDE"];		
		[_entity, _vehicleAppearence#0, _vehicleAppearence#1] call BIS_fnc_initVehicle;
		_entity lock _vehicleLock;
	};	
	
	//-- Shared Properties (Dudes and vehicles)
	_entity setVectorDirAndUp _direction;
	_entity setPosWorld _position; //-- So That We Get That 100% Placement Accuracy Boii
	{_entity setHitPointDamage [_x, (_hitpoints#2) select _forEachIndex]} forEach (_hitpoints#0);  //-- Set health
	[_entity, _loadout] spawn {sleep 0.1; _this#0 setUnitLoadout _this#1};  //-- So that this loadout overwrites any other script that sets loadout (like faction.sqf)
	_entity enableSimulation _simulation;	
	_entity allowDamage _damage;
	if (_varName != "") then {missionNamespace setVariable [_varName, _entity, true]};
	_entity setVariable ["init", _init];  //-- Return init code to unit so we can take it again later
	_entity spawn _init;  //-- Run init code

	//-- Passengers and drivers and stuff
	if (_seatData isNotEqualTo []) then {
		_seatData params ["_role", "_cargoIndex", "_turretPath"];
		if (_role == "driver") then {_entity moveInDriver _vehicle};
		if (_role == "commander") then {_entity moveInCommander _vehicle};
		if (_role == "gunner") then {_entity moveInGunner _vehicle};
		if (_role in ["turret", "Turret"]) then {_entity moveInTurret [_vehicle, _turretPath]};
		if (_role == "cargo") then {_entity moveInCargo [_vehicle, _cargoIndex]};
	};
	if (_crewData isNotEqualTo []) then {{[_x, _entity] call tsp_fnc_sector_loadEntity} foreach _crewData};	
	
	_entity  //-- Return Unit Variable Name
};

tsp_fnc_sector_variable = {if (missionNameSpace getVariable [_this, objNull] isEqualTo objNull) then {tsp_debug} else {missionNameSpace getVariable _this}};
tsp_fnc_sector_check = {(tsp_sector_info select {_x#0 == _this})#0#1};

[] spawn {
	waitUntil {!isNull (findDisplay 46)};
	tsp_sector_info = [];
	if (isServer) then {call tsp_fnc_sector_automate};  //-- Only server can create sectors
	player addEventHandler ["GetInMan", {params ["_unit", "_role", "_vehicle", "_turret"]; _vehicle setVariable ["layer", nil, true]}];  //-- Legitimate salvage
};