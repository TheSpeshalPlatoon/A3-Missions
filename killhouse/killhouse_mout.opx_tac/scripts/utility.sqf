tsp_fnc_countdown = {  //-- PVP mission countdown (run on the server)
	params [["_total", 25], ["_setup", 60], ["_gap", 5], ["_code", {}]]; 
	["Mission starts in " + str _setup+" seconds.", "Countdown ended! " + str _total + " minutes have elapsed!"] params ["_start","_end"];
	if (_setup > 0) then {_start remoteExec ["systemChat", 0]; 
	waitUntil {sleep 1; time > _setup}}; ["Mission Start!"] remoteExec ["systemChat", 0];
	for "_i" from _total to 1 step -_gap do {[str _i + (if (_i == 1) then {" minute"} else {" minutes"}) + " remaining!"] remoteExec ["systemChat", 0]; uiSleep (_gap*60)};
	_end remoteExec ["systemChat", 0]; [] call _code;
};

tsp_fnc_zone = {  //-- Zone restriction
	params ["_unit", "_zones", "_warning", ["_code", {}], ["_condition", {alive _this}], ["_timeout", 5], ["_interval", 2]];
	while {sleep _interval; _unit call _condition} do {
		if (_unit distance (missionNameSpace getVariable ["tsp_debug", objNull]) < 50) then {continue};  //-- Debug
		if ([_unit, _zones] call tsp_fnc_zone_triggers) then {continue};  //-- If not in zone
		systemChat _warning; sleep _timeout;  //-- Turn around time
		if ([_unit, _zones] call tsp_fnc_zone_triggers) then {continue};  //-- If not back, then run code
		_unit call _code;
	};
};

tsp_fnc_zone_triggers = {params ["_unit", ["_triggers", []]]; if (count (_triggers select {_unit inArea _x}) > 0) exitWith {true}; false};

tsp_fnc_zone_launch = {  //-- Ragdoll launch towards [player, [_zones, player] call BIS_fnc_nearestPosition] spawn tsp_fnc_zone_launch;
	params ["_unit", ["_towards", []]];
	(vehicle _unit) setDir (_unit getDir ([_towards, _unit] call BIS_fnc_nearestPosition));   
	(vehicle _unit) allowDamage false;
	(vehicle _unit) addForce [_unit vectorModelToWorld [0,5000,0], [1,0,0]]; sleep 3;
	(vehicle _unit) allowDamage true; _unit setUnconscious false;	
};

tsp_fnc_anim = {  //-- Ambient AI animations
	params ["_unit", ["_loops", []], ["_outs", []], ["_react", true], ["_exit", {false}], ["_loop", ""], ["_out", ""]];	
	_unit removeAllEventHandlers "HandleDamage";
	_unit addEventHandler ["HandleDamage", {
		params ["_unit", "_selection", "_damage"]; group _unit setBehaviour "COMBAT";
		if (!("amov" in animationState _unit)) then {_unit spawn {_this setUnconscious true; sleep 3; if (alive _this) then {_this setUnconscious false}}};
		if !(isNil "ace_medical_engine_fnc_handleDamage") then {_this spawn {sleep 0.1; _this call ace_medical_engine_fnc_handleDamage}};
		_this spawn {params ["_unit", "_selection", "_damage"]; sleep 0.1; _unit setHitPointDamage [_selection, (_unit getHitPointDamage _selection) + _damage]}; 0
	}];
	_unit addEventHandler ["AnimDone", {params ["_unit", "_anim"]; _unit setVariable ["animDone", true]}];  //-- So we know when an anim ends
	while {local _unit && lifeState _unit == "HEALTHY"} do {
		_unit disableAI "ANIM"; 
        while {count _loops > 0 && lifeState _unit == "HEALTHY"} do {  //-- While chilling, loop through _loop array
			_loop = selectRandom _loops; [_unit, _loop] remoteExec ["playMoveNow", 0]; if (animationState _unit != _out) then {[_unit, _loop] remoteExec ["switchMove", 0]};
			_unit setVariable ["animDone", false]; waitUntil {sleep 0.1; _unit call _exit || lifeState _unit != "HEALTHY" || (_react && behaviour _unit == "COMBAT") || _unit getVariable ["animDone", true]};
			if (_unit call _exit || lifeState _unit != "HEALTHY" || (_react && behaviour _unit == "COMBAT")) exitWith {};
        };
		_unit enableAI "ANIM";
		if (count _outs > 0 && lifeState _unit == "HEALTHY") then {  //-- Out animation
			_out = selectRandom _outs; [_unit, _out] remoteExec ["playMoveNow", 0]; if (animationState _unit != _out) then {[_unit, _out] remoteExec ["switchMove", 0]};
			sleep (abs(1/(getNumber (configFile >> "CfgMovesMaleSdr" >> "States" >> _out >> "speed"))))+0.1;
			if (animationState _unit == _out) then {[_unit, ""] remoteExec ["switchMove", 0]};  //-- If out doesn't work
		};
		if (_unit call _exit) exitWith {};
		waitUntil {sleep 5; behaviour _unit != "COMBAT"};  //-- Go back to loop
	};
};

tsp_fnc_zombience = {  //-- Constant reinforcements
    params ["_unit", "_zombies", "_zones", ["_side", east], ["_condition", {true}], ["_init", {}], ["_dist", 100], ["_max", 3], ["_time", 10], ["_despawnDistance", 200]];    
    z_zombies = _zombies; z_dist = _dist; z_max = _max; z_time = _time;  //-- So that we can change it on the fly
    while {uiSleep z_time; call _condition} do {
        if ([_unit, _zones] call tsp_fnc_zone_triggers) then {
            if (count (units (missionNameSpace getVariable ["zGroup", group objNull])) < 1) then {zGroup = createGroup _side; zGroup setGroupId ["ZGroup"]};  //-- Create/recreate group            
            if (count (units zGroup select {alive _x}) < z_max) then {  //-- If group not full, create new guy and give waypoint
                _spawnPos = [((getpos player)#0) + (sin (random 360)) * (z_dist + random z_dist), ((getpos player)#1) + (cos (random 360)) * (z_dist + random z_dist), 0];
                _zUnit = zGroup createUnit [selectRandom z_zombies, _spawnPos, [], 1, "NONE"];  //-- Make guy
                _zUnit spawn _init; {_x doMove position _unit} forEach (units zGroup);         //-- Custom code and waypoint
            };            
            {if ((_unit distance2D _x) > _despawnDistance) then {deletevehicle _x}} forEach units zGroup;  //-- If any member of zGroup is too far away, delete him
        };
    };
};

tsp_fnc_underground = {  //-- Underground area lighting (Use in triggers)
	params ["_unit", ["_dark", false], ["_attach", _this#0]];
	titleCut ["", "BLACK OUT", 0.5]; sleep 0.5; _unit attachTo [_attach, [0,0,0]]; detach _unit;
	if (_dark && isNil "dark_eh") then {dark_eh = [{setDate [2015, 12, 31, 0, 0]}, 0, []] call CBA_fnc_addPerFrameHandler};
	if (!_dark) then {[dark_eh] call CBA_fnc_removePerFrameHandler};  
	sleep 0.5; titleCut ["", "BLACK IN", 0.5];
};

tsp_fnc_intro = {  //-- Custom slideshow intro
	params ["_timeline", ["_music", ""], ["_exit", {}]];
	waitUntil {time > 0}; 
	titleCut ["", "BLACK OUT", 0.01]; 0 fadeSound 0; playMusic _music; 5 fadeMusic 1; sleep 1; ["", "Press [SPACE] to Skip"] spawn BIS_fnc_showSubtitle; 
	tsp_skipped = false; tsp_skipEH = (findDisplay 46) displayAddEventHandler ["KeyDown", "if ((_this#1) == 57) exitWith {0 fadeSound 1; playSound 'OMCameraPhoto'; tsp_skipped = true}; true"];
	{if (tsp_skipped) exitWith {}; _x params ["_time", "_code"]; {_x call bis_fnc_animatedScreen} forEach [[1],[0,[15,5,1],1.05]]; [] spawn _code; uiSleep _time} forEach _timeline;
	(findDisplay 46) displayRemoveEventHandler ["keyDown", tsp_skipEH];	{_x call bis_fnc_animatedScreen} forEach [[0],[1]];  //-- INIT, DESTROY
	titleCut ["", "BLACK IN", 3]; 2 fadeSound 1; 5 fadeMusic 0; [] spawn _exit; sleep 5; playMusic "";
};

tsp_fnc_intro_guide = {  //-- The numbers Mason, what do they mean!?
	#include "\a3\Functions_F_Tacops\Systems\fn_animatedScreen.inc"
	systemChat (str MODE_INIT);            //-- 0
	systemChat (str MODE_DESTROY);         //-- 1
	systemChat (str MODE_RESET);           //-- 2
	systemChat (str MODE_BLACKOUT);        //-- 3
	systemChat (str MODE_BLACKIN);         //-- 4
	systemChat (str MODE_LAYER_CREATE);    //-- 5
	systemChat (str MODE_LAYER_ANIMATE);   //-- 6
	systemChat (str MODE_LAYER_FADE);      //-- 7
	systemChat (str MODE_LAYER_PULSE);     //-- 8
	systemChat (str MODE_LAYER_ROTATE);    //-- 9
	systemChat (str MODE_TEXT_CREATE);     //-- 30
	systemChat (str MODE_TEXT_ANIMATE);    //-- 31
	systemChat (str MODE_OVERLAY_CREATE);  //-- 40
};

tsp_fnc_guide = {  //-- Helicopter hand signal guidance
    params ["_unit", ["_area", [heli_far,heli_center,heli_left,heli_right]]];
    _unit disableAI "ANIM"; _unit disableAI "MOVE"; _unit switchMove "Acts_JetsCrewaidR_idle";
	_unit addEventHandler ["AnimDone", {params ["_unit", "_anim"]; _unit setVariable ["animDone", true]}];  //-- So we know when an anim ends
    while {sleep 1; alive _unit} do {
        _helis = vehicles select {_veh = _x; _veh isKindOf "Helicopter" && isEngineOn _veh && count (_area select {_veh inArea _x}) > 0};
        if (count _helis == 0) then {continue}; _heli = _helis#0; _depart = isTouchingGround _heli;
        while {isEngineOn _heli && count (_area select {_heli inArea _x}) > 0} do {
            if (!_depart && isTouchingGround _heli) exitWith {[_unit, "Acts_JetsMarshallingEmergencyStop", {false}] call tsp_fnc_guide_anim};
            if (!_depart && _heli inArea heli_far) then {[_unit, "Acts_JetsMarshallingStraight", {!_depart && _heli inArea heli_far && count (_area select {_heli inArea _x}) > 0}] call tsp_fnc_guide_anim; continue};
            if (!_depart && _heli inArea heli_center && !isTouchingGround _heli) then {[_unit, "Acts_JetsMarshallingSlow", {!_depart && _heli inArea heli_center  && !isTouchingGround _heli && count (_area select {_heli inArea _x}) > 0}] call tsp_fnc_guide_anim; continue};
            if (!_depart && _heli inArea heli_left) then {[_unit, "Acts_JetsMarshallingLeft", {!_depart && _heli inArea heli_left && count (_area select {_heli inArea _x}) > 0}] call tsp_fnc_guide_anim; continue};
            if (!_depart && _heli inArea heli_right) then {[_unit, "Acts_JetsMarshallingRight", {!_depart && _heli inArea heli_right && count (_area select {_heli inArea _x}) > 0}] call tsp_fnc_guide_anim; continue};
            if (_depart && isTouchingGround _heli) then {[_unit, "Acts_JetsMarshallingEnginesOn", {_depart && isTouchingGround _heli && count (_area select {_heli inArea _x}) > 0}] call tsp_fnc_guide_anim; continue};
            if (_depart && !isTouchingGround _heli) then {[_unit, "Acts_JetsMarshallingStraight", {_depart && !isTouchingGround _heli && count (_area select {_heli inArea _x}) > 0}] call tsp_fnc_guide_anim; continue};
        };
        _unit switchMove "Acts_JetsCrewaidR_idle";
    };
};

tsp_fnc_guide_anim = {
    params ["_unit", "_anim", "_stop"]; if (toLower _anim in toLower animationState _unit) exitWith {};
    _unit switchMove (_anim + "_in"); _unit setVariable ["animDone", false]; waitUntil {_unit getVariable "animDone"};
    _unit switchMove (_anim + "_loop"); _unit setVariable ["animDone", false]; waitUntil {_unit getVariable "animDone"};
    _unit setVariable ["stop", false]; waitUntil {!(call _stop)};
    _unit switchMove (_anim + "_out"); _unit setVariable ["animDone", false]; waitUntil {_unit getVariable "animDone"};
};

tsp_fnc_suppress = {  //-- Suppress target ([this, player, {triggerActivated suppress}, currentWeapon this] spawn tsp_fnc_suppress)
	params ["_unit", "_target", ["_condition", {triggerActivated suppress}], ["_weap", currentWeapon (_this#0)], ["_mode", "Close"], ["_dir", getDir (_this#0)]];
    (group _unit) setBehaviour "COMBAT"; 
    while {sleep random 0.3 max 0.1; alive _unit} do {
		if (call _condition) then {_unit lookAt _target; _unit setDir _dir; vehicle _unit setVehicleAmmo 1; _unit setAmmo [_weap, 30]; _unit forceWeaponFire [_weap, _mode]} else {sleep 2};
	};
};

tsp_fnc_fastrope = {  //-- Static ACE fastrope
	params ["_vehicle", ["_length", 10], ["_origin", [0,0,0]]];
	_deployedRopes = _vehicle getVariable ["ace_fastroping_deployedRopes", []];
	_hookAttachment = _vehicle getVariable ["ace_fastroping_FRIES", _vehicle];
	_hook = "ace_fastroping_helper" createVehicle [0, 0, 0]; _hook allowDamage false;
	if (_origin isEqualType []) then {_hook attachTo [_hookAttachment, _origin]};
	if !(_origin isEqualType []) then {_hook attachTo [_hookAttachment, [0, 0, 0], _origin]};
	_dummy = createVehicle ["ace_fastroping_helper", getPosATL _hook vectorAdd [0, 0, -1], [], 0, "CAN_COLLIDE"];
	_dummy allowDamage false; _dummy disableCollisionWith _vehicle;
	_ropeTop = ropeCreate [_dummy, [0, 0, 0], _hook, [0, 0, 0], 0.5]; _ropeTop allowDamage false;
	_ropeBottom = ropeCreate [_dummy, [0, 0, 0], 1]; _ropeBottom allowDamage false;
	ropeUnwind [_ropeBottom, 30, _length, false];
    _deployedRopes pushBack [_origin, _ropeTop, _ropeBottom, _dummy, _hook, false, false];
	_vehicle setVariable ["ace_fastroping_deployedRopes", _deployedRopes, true];
	_vehicle setVariable ["ace_fastroping_deploymentStage", 3, true];
	_vehicle setVariable ["ace_fastroping_ropeLength", _length, true];
};

tsp_fnc_lights = {  //-- Toggle lights on/off
	params ["_lights", ["_sleep", 1], ["_distance", 550]]; 
	tsp_fnc_lights_wait = true;
	{
		_x hideObjectGlobal !isObjectHidden _x;
		if (tsp_path == "") then {playSound3D [if (isObjectHidden _x) then {getMissionPath "data\off.ogg"} else {getMissionPath "data\on.ogg"}, _x, false, getPosASL _x, 5, random 2 max 0.5 min 2, _distance]};
		if (tsp_path != "") then {playSound3D [if (isObjectHidden _x) then {tsp_path + "data\off.ogg"} else {tsp_path + "data\on.ogg"}, _x, false, getPosASL _x, 5, random 2 max 0.5 min 2, _distance]};
		sleep (random _sleep + (_sleep/2));
	} forEach _lights;
	tsp_fnc_lights_wait = nil;
};

tsp_fnc_skeet = {  //-- Skeet machine
	params ["_machine"];
    if (_machine getVariable ["skeeting", false]) then {playSound3D ["A3\Sounds_F\weapons\Other\dry5-rifle.wss", _machine, false, getPosASL _machine, 5, 1, 30]};
    if (_machine getVariable ["skeeting", false]) exitWith {_machine setVariable ["skeeting", false, true]}; _machine setVariable ["skeeting", true, true];
    playSound3D ["A3\Sounds_F\weapons\Closure\firemode_changer_1.wss", _machine, false, getPosASL _machine, 5, 1, 30];
	while {sleep 3; _machine getVariable ["skeeting", true]} do {
		playSound3D ["A3\Sounds_F_Kart\Weapons\starting_pistol_1.wss", _machine, false, getPosASL _machine, 5, 1, 100];
		_pigeon = "Skeet_Clay_F" createVehicle [0,0,0]; _pigeon attachto [_machine, [0, -1, 0]]; detach _pigeon; 
		_pigeon setVelocityModelSpace [0, -(random 12 max 10 min 12), 12]; _pigeon setdamage 0.99;
		_pigeon spawn {sleep 10; deleteVehicle _this};
	};
};

tsp_fnc_cof = {  //-- Course of fire
	params ["_unit", "_end", ["_original", []], ["_targets", []], ["_startTime", time]];
	if (_original#0 getVariable ["cof", false]) exitWith {["", "Course is still being used."] spawn BIS_fnc_showSubtitle}; 
	_original#0 setVariable ["cof", true, true]; playSound3D ["A3\Missions_F_Oldman\Data\sound\beep.ogg", _unit, false, getPosASL _unit, 5, 1, 100];  //-- BEEP
	{_new = typeOf _x createVehicle [0,0,0]; _new attachTo [_x, [0,0,0]]; _new setVectorDirAndUp [vectorDir _x, vectorUp _x]; _targets pushBack _new} forEach _original;
	_unit setVariable ["fired", 0]; _fired = _unit addEventHandler ["Fired", {player setVariable ["fired", (player getVariable "fired") + 1]}];  //-- Shot counter	
	while {sleep 1; alive _unit && _unit distance _end > 3} do {hint parseText ("<t size='2' color='#a83232'>" + ([time - _startTime, "MM:SS"] call BIS_fnc_secondsToString) + "</t>")};  //-- Timer hint
	[name _unit + " finished the course with a time of " + ([time - _startTime, "MM:SS"] call BIS_fnc_secondsToString) + ". " + str (_unit getVariable "fired") + " shots fired. " + str (count (_targets select {!alive _x})) + "/" + str (count _targets) + " targets hit."] remoteExec ["systemChat", 0];
	{deleteVehicle _x} forEach _targets; _unit removeEventHandler ["Fired", _fired];	
	_original#0 setVariable ["cof", false, true]; playSound3D ["A3\Missions_F_Oldman\Data\sound\beep.ogg", _unit, false, getPosASL _unit, 5, 1, 100];  //-- BEEP
};

tsp_fnc_task = {  //-- Custom task framework, see below
	params [
		"_owner", "_task", "_name", "_description", "_type", "_pos",
		["_conditionCreate", {true}], ["_conditionSuccess", {false}], ["_conditionFail", {false}], ["_conditionCancel", {false}],
		["_codeCreate", {}], ["_codeSucceed", {}], ["_codeFail", {}], ["_codeCancel", {}], ["_codeDelete", {}], 
		["_poll", 5], ["_state", 0]
	]; _id = if (typeName _task == "ARRAY") then {_task#0} else {_task};

	waitUntil {uiSleep _poll; call _conditionCreate};
	[_owner, _task, [_description, _name], _pos, "CREATED", -1, true, _type] call BIS_fnc_taskCreate;  //-- Alright we exist now
	[] call _codeCreate;
	while {sleep _poll; !(_id call BIS_fnc_taskState in ["SUCCEEDED", "FAILED", "CANCELED"])} do {  //-- While task active
		_state = missionNameSpace getVariable ["task_save_" + _id, 0];  //-- For loading purposes
		if ([] call _conditionSuccess || _state == 1) exitWith {_state = 1; [_id, "SUCCEEDED"] call BIS_fnc_taskSetState; call _codeSucceed};  //-- Success state
		if ([] call _conditionFail || _state == 2) exitWith {_state = 2; [_id, "FAILED"] call BIS_fnc_taskSetState; call _codeFail};          //-- Fail state
		if ([] call _conditionCancel || _state == 3) exitWith {_state = 3; [_id, "CANCELED"] call BIS_fnc_taskSetState; call _codeCancel};   //-- Cancel state
	};
	call _codeDelete;
	if (isNil "tsp_tasks") then {tsp_tasks = []}; tsp_tasks pushBack ["task_save_" + _id, _state]; publicVariable "tsp_tasks";  //-- For saving purposes
};

tsp_fnc_simple = {  //-- Create simple objects (Used for hidden arma models)
    params ["_base", "_model", ["_scale", 1]]; sleep 1;
    _obj = createSimpleObject [_model, getPosASL _base, true]; 
    _obj setPosASL (getPosASL _base); _obj setObjectScale _scale;
    _obj setVectorDirAndUp [vectorDir _base, vectorUp _base];
};

tsp_fnc_replace = {
    params ["_base", "_class", ["_model", ""], ["_scale", 1], ["_obj", _this#0], ["_hide", true]]; if (canSuspend) then {sleep 1};
    if (isClass (configFile >> "CfgVehicles" >> _class)) then {_obj = createVehicle [_class, getPosASL _base, [], 0, "CAN_COLLIDE"]; [_base, _hide] remoteExec ["hideObjectGlobal", 2]}; 
    if (_model != "") then {_obj = createSimpleObject [_model, getPosASL _base, true]};
    _obj setPosASL (getPosASL _base); _obj setObjectScale _scale;
    _obj setVectorDirAndUp [vectorDir _base, vectorUp _base];
    _obj
};

tsp_fnc_heal = {  //-- Can i get a healy wealy pls mr zeusy
	params ["_unit"];
	if (!isNil "ACE_medical_fnc_treatmentAdvanced_fullHeal") then {[_unit, _unit] call ACE_medical_fnc_treatmentAdvanced_fullHeal};
	if (!isNil "ACE_medical_treatment_fullHealLocal") then {[_unit, _unit] call ACE_medical_treatment_fullHealLocal};
	if (!isNil "ace_medical_treatment_fnc_fullHeal") then {[_unit, _unit] call ace_medical_treatment_fnc_fullHeal};
	_unit setDamage 0;
};

tsp_fnc_wake = {  //-- https://www.youtube.com/watch?v=7vObEK3Lbp4
	params ["_unit", ["_blood", true], ["_cardiac", true], ["_heart", true], ["_bloodlossThreshhold", -1], ["_bloodThreshold", ace_medical_const_stableVitalsBloodThreshold]];
	if (_blood && _unit getVariable "ace_medical_bloodVolume" < _bloodThreshold) then {_unit setVariable ["ace_medical_bloodVolume", _bloodThreshold + 1]};
	if (_cardiac && _unit getVariable "ace_medical_inCardiacArrest") then {_unit setVariable ["ace_medical_inCardiacArrest", false]};
	if (_heart && _unit getVariable "ace_medical_heartRate" < 40) then {["ace_medical_CPRSucceeded", _unit] call CBA_fnc_localEvent};
	if (_bloodlossThreshhold != -1) then {ace_medical_const_bloodLossKnockOutThreshold = _bloodlossThreshhold};
	sleep 3; ["ace_medical_WakeUp", _unit] call CBA_fnc_localEvent;
};

if (true) exitWith {};  //-- Notes past this point

//-- Fun faces: Adams,Conway,Hladas,Dwarden,Ivan,Jay,Miller,Nikos,Pettka,kerry_B2

[
	west, ["bari", "primary"], "Kill Bari", "Kill that boi.", 
	"Kill", objNull, 
	{true},  //-- Condition create
	{!alive task_bari},  //-- Condition succeed
	{false},  //-- Condition fail
	{task_bari distance task_location > 100}  //-- Condition cancel
] spawn tsp_fnc_task;

profileNamespace setVariable ["tsp_tasks", tsp_tasks];  //-- Save
{missionNameSpace setVariable [_x#0, _x#1, 0]} forEach (profileNameSpace getVariable "tsp_tasks");  //-- Load

/*
	Acts_Watching_Fire_Loop,
	Acts_AidlPercMstpSnonWnonDnon_warmup_1_loop,
	Acts_AidlPercMstpSnonWnonDnon_warmup_2_loop,
	Acts_AidlPercMstpSnonWnonDnon_warmup_3_loop,
	Acts_AidlPercMstpSnonWnonDnon_warmup_7_loop,
	Acts_AidlPercMstpSnonWnonDnon_warmup_8_loop,
	Acts_Commenting_On_Fight_loop
	Acts_A_M01_briefing
	Acts_Injured_Driver_Loop
	Acts_listeningToRadio_Loop
	Acts_SittingWounded_loop
	Acts_AidlPercMstpSnonWnonDnon_warmup_4_loop 
	Acts_AidlPercMstpSnonWnonDnon_warmup_5_loop
	Acts_AidlPercMstpSnonWnonDnon_warmup_6_loop
	Acts_JetsCrewaidFCrouch_loop
	Acts_CivilListening_1
	Acts_CivilListening_2
	Acts_CivilTalking_1
	Acts_CivilTalking_2
	Acts_CivilShocked_1
	hubstanding_idle2
	Acts_listeningToRadio_Loop
	Acts_Peering_Front
	AmovPsitMstpSrasWrflDnon_Smoking
	inbasemoves_patrolling1
	AmovPsitMstpSrasWrflDnon_WeaponCheck2
	inbasemoves_handsbehindback2
	Acts_TreatingWounded01
	Acts_LyingWounded_loop1
	boundCaptive_loop1
	kka3_unc_1
	kka3_unc_2
	kka3_unc_5
	kka3_unc_4
	kka3_unc_8_1
	Acts_SittingWounded_out
	kka3_unc_5_1
	kka3_unc_4
	boundCaptive_loop1
*/

//-- UNARMED
this setVariable ["init",{_n=str(round random 7+1);[_this,["Acts_AidlPercMstpSnonWnonDnon_warmup_"+_n+"_loop"],["Acts_AidlPercMstpSnonWnonDnon_warmup_"+_n+"_out"]] spawn tsp_fnc_anim}];  //-- Warmup
this setVariable ["init",{[_this,["Acts_Kore_IdleNoWeapon_loop"],["apanpercmstpsnonwnondnon"]] spawn tsp_fnc_anim}];
this setVariable ["init",{[_this,["Acts_CivilIdle_"+str(round random 1+1)],["apanpercmstpsnonwnondnon"]] spawn tsp_fnc_anim}];
this setVariable ["init",{[_this,["inbasemoves_handsbehindback2"],["apanpercmstpsnonwnondnon"]] spawn tsp_fnc_anim}];
this setVariable ["init",{[_this,["Acts_CivilListening_"+str(round random 1+1)],["apanpercmstpsnonwnondnon"]] spawn tsp_fnc_anim}];  //-- Talking
this setVariable ["init",{[_this,["Acts_CivilTalking_"+str(round random 1+1)],["apanpercmstpsnonwnondnon"]] spawn tsp_fnc_anim}];  //-- Talking
this setVariable ["init",{[_this,["Acts_Kore_TalkingOverRadio_loop"],["Acts_Kore_TalkingOverRadio_out"]] spawn tsp_fnc_anim}];  //-- Radio
this setVariable ["init",{[_this,["Acts_CivilShocked_"+str(round random 1+1)],[],false] spawn tsp_fnc_anim}];  //-- Sitting
this setVariable ["init",{[_this,[selectRandom ["Acts_CivilInjured"+selectRandom["Arms","Chest","General","Head","Legs"]+"_1"]],[],false] spawn tsp_fnc_anim}];  //-- Wounded

//-- PISTOL
this setVariable ["init",{_n=str(round random 7+1);[_this,["Acts_AidlPercMstpSloWWpstDnon_warmup_"+_n+"_loop"],["Acts_AidlPercMstpSlowWpstDnon_warmup_"+_n+"_out"]] spawn tsp_fnc_anim}];

//-- RIFLE
this setVariable ["init",{_n=str(round random 7+1);[_this,["Acts_AidlPercMstpSloWWrflDnon_warmup_"+_n+"_loop"],["Acts_AidlPercMstpSlowWrflDnon_warmup_"+_n+"_out"]] spawn tsp_fnc_anim}];  //-- Warmup
this setVariable ["init",{[_this,["inbasemoves_patrolling1"]] spawn tsp_fnc_anim}];  //-- Watch
this setVariable ["init",{[_this,[
    "Acts_Rifle_Operations_Back","Acts_Rifle_Operations_Front","Acts_Rifle_Operations_Left","Acts_Rifle_Operations_Right",    
    "Acts_Rifle_Operations_Zeroing","Acts_Rifle_Operations_Checking_Chamber","Acts_Rifle_Operations_Barrel",
    "Acts_Ambient_Relax_1","Acts_Ambient_Relax_2","Acts_Ambient_Relax_3","Acts_Ambient_Relax_4","Acts_Peering_Back","Acts_Peering_Down","Acts_Peering_Front","Acts_Peering_Left","Acts_Peering_Right",
    "Acts_Ambient_Cleaning_Nose","Acts_Ambient_Gestures_Sneeze","Acts_Ambient_Gestures_Tired","Acts_Ambient_Gestures_Yawn"
]] spawn tsp_fnc_anim}];  //-- Funny
this setVariable ["init",{[_this,[
    "Acts_Ambient_Relax_1","Acts_Ambient_Relax_2","Acts_Ambient_Relax_3","Acts_Ambient_Relax_4","Acts_Peering_Back","Acts_Peering_Down","Acts_Peering_Front","Acts_Peering_Left","Acts_Peering_Right",
    "Acts_Ambient_Cleaning_Nose","Acts_Ambient_Gestures_Sneeze","Acts_Ambient_Gestures_Tired","Acts_Ambient_Gestures_Yawn",
    "Acts_Ambient_Rifle_Drop","Acts_Ambient_Picking_Up","Acts_Ambient_Shoelaces","Acts_Ambient_Stretching"
],["","Acts_Shocked_1_Loop","Acts_Shocked_3"]] spawn tsp_fnc_anim}];  //-- Funny
this setVariable ["init",{[_this,[
    selectRandom ["Acts_Ambient_Facepalm_1","Acts_Ambient_Facepalm_2"],
    "Acts_Ambient_Aggressive","Acts_Ambient_Agreeing","Acts_Ambient_Approximate","Acts_Ambient_Defensive","Acts_Ambient_Dismissing",
    "Acts_Ambient_Disagreeing","Acts_Ambient_Disagreeing_with_pointing","Acts_Ambient_Huh",
    "Acts_Ambient_Relax_1","Acts_Ambient_Relax_2","Acts_Ambient_Relax_3","Acts_Ambient_Relax_4"
],["Acts_Shocked_1_Loop","Acts_Shocked_3","Acts_Shocked_4_Loop"]] spawn tsp_fnc_anim}];  //-- Talking
this setVariable ["init",{[_this,["Acts_Commenting_On_Fight_loop"],["Acts_Shocked_1_Loop","Acts_Shocked_3","Acts_Shocked_4_Loop"]] spawn tsp_fnc_anim}];  //-- Talking
this setVariable ["init",{[_this,["Acts_RU_Briefing_Move","Acts_RU_Briefing_Point","Acts_RU_Briefing_Point_TL","Acts_RU_Briefing_Speaking"],["amovpercmstpsnonwnondnon"]] spawn tsp_fnc_anim}];  //-- Briefing
this setVariable ["init",{[_this,["Acts_listeningToRadio_Loop"],["Acts_listeningToRadio_Out"]] spawn tsp_fnc_anim}];  //-- Radio
this setVariable ["init",{[_this,["Acts_ShieldFromSun_loop"],["Acts_ShieldFromSun_out"]] spawn tsp_fnc_anim}];  //-- Shield from sun
this setVariable ["init",{[_this,["Acts_TreatingWounded0"+str(round random 5+1)],["Acts_TreatingWounded_Out"]] spawn tsp_fnc_anim}];  //-- Treating wounded
this setVariable ["init",{[_this,["Acts_LyingWounded_loop1","Acts_LyingWounded_loop2","Acts_LyingWounded_loop3"],[],false] spawn tsp_fnc_anim}];  //-- Wounded