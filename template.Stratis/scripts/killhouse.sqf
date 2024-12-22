tsp_fnc_killhouse = {
    params [
        "_start", "_end", "_area", "_width", "_height", "_size", 

        ["_unitsMin", 5], ["_unitsMax", 16], ["_hostageChance", 0.05],
        ["_enemyChance", 0.7], ["_enemySide", resistance], ["_enemyTypes", enemy_altis],
        ["_civilChance", 0.05], ["_civilTypes", civilian_altis],
        ["_targetChance", 0], ["_targetTypes", ["Target_F"]],
        ["_furnitureChance", 0.5], ["_furnitureTypes", furniture_altis],

        ["_lockChance", 0.5], ["_openingChance", 0.2], ["_doorChance", 0.95], 
        ["_wallTypes", ["Bro_MSW_2m"]], ["_outerWallType", "Bro_MSW_2m_conc"], ["_wallLength", 2],
        ["_doorTypes", ["Bro_MSW_2m_d", "Bro_MSW_2m_d", "Bro_MSW_2m_de"]], ["_openDoorTypes", ["Bro_MSW_2m_de"]], ["_outerDoorType", "Bro_MSW_2m_d_conc"], 

        ["_units", []], ["_usedCells", []], ["_helpers", []], ["_openings", []], ["_relations", []], ["_index", 0], ["_doors", []], ["_walls", []], ["_furniture", []], ["_sleep", 0],  //0.001
        ["_deadType", "Sign_Pointer_Yellow_F"], ["_helperTypes", [
            "Sign_Arrow_F","Sign_Arrow_Blue_F","Sign_Arrow_Cyan_F","Sign_Arrow_Green_F","Sign_Arrow_Pink_F","Sign_Arrow_Yellow_F",
            "Sign_Arrow_Large_F","Sign_Arrow_Large_Yellow_F","Sign_Arrow_Large_Pink_F","Sign_Arrow_Large_Green_F","Sign_Arrow_Large_Cyan_F","Sign_Arrow_Large_Blue_F",
            "Sign_Arrow_Direction_F","Sign_Arrow_Direction_Blue_F","Sign_Arrow_Direction_Cyan_F","Sign_Arrow_Direction_Green_F","Sign_Arrow_Direction_Pink_F","Sign_Arrow_Direction_Yellow_F",
            "Sign_Pointer_Blue_F","Sign_Pointer_Cyan_F","Sign_Pointer_Green_F","Sign_Pointer_Pink_F","Sign_Pointer_F","Sign_Pointer_Yellow_F"
        ]] 
    ];

    //-- Check if killhouse is clear of players before generating, set reset to true to delete old killhouse
	if (count (allPlayers select {alive _x && _x inArea _area}) > 0) exitWith {["", "Killhouse is still occupied."] spawn "BIS_fnc_showSubtitle", _x};
	{[_x,1,0] call bis_fnc_door} forEach ((_start nearObjects [_outerDoorType, 5]) + (_end nearObjects [_outerDoorType, 5]));  //-- Close outer doors
    _enterance = (_start nearObjects [_outerDoorType, 5])#0;
    _blocker = createSimpleObject ["A3\structures_f\data\DoorLocks\planks_1.p3d", getPosASL _start]; _blocker attachTo [_enterance, [0,-0.2,-1.3]];
    _blocker spawn {while {sleep 1; alive _this} do {playSound3D ["a3\sounds_f\vehicles\armor\noises\tank_building_0"+str (round random 3 + 1)+".wss", _this, false, getPosASL _this, 5, random 2 max 0.5 min 2, 25]}};
    playSound3D ["a3\sounds_f\ambient\quakes\earthquake"+str (round random 3 + 1)+".wss", _blocker, false, getPosASL _blocker, 5, 1, 50];
    {["", "Generating Killhouse..."] remoteExec ["BIS_fnc_showSubtitle", _x]} forEach (allPlayers select {_x distance _start < _height});
    _start setVariable ["reset", true, true]; _start setVariable ["generating", true, true]; sleep 2;  //-- Sleep so old killhouse has time to delete
    {deleteVehicle _x} forEach (nearestObjects [_area, [], sqrt(_width^2 + _height^2)] select {!(typeOf _x in [_outerWallType, _outerDoorType, "Land_ConnectorTent_01_floor_light_F"]) && !(isPlayer _x) && !(_x == _area) && (_x inArea _area)});  //-- Remove objects
    {deleteVehicle _x} forEach (allDeadMen inAreaArray _area);  //-- Remove dead bodies
    {["", "Generating Killhouse..."] remoteExec ["BIS_fnc_showSubtitle", _x]} forEach (allPlayers select {_x distance _start < _height});

    //-- Create horizontal walls
    for "_h" from 1 to _height-1 do {for "_w" from 0 to _width-1 do {sleep _sleep;
        _pos = _start getPos [_wallLength*_h, getDir _start] getPos [(_wallLength*_w)+(_wallLength/2), getDir _start + 90];
        _wall = createVehicle [selectRandom _wallTypes, _pos, [], 0, "CAN_COLLIDE"];
		_wall allowDamage false; _wall setDir (getDir _start); _walls pushBack _wall;
        _wall setPosASL [(getPosASL _wall)#0, (getPosASL _wall)#1, (getPosASL _enterance)#2];
    }}; 

    //-- Create vertical walls
    for "_h" from 1 to _height do {for "_w" from 1 to _width-1 do {sleep _sleep;
        _pos = _start getPos [(_wallLength*_h)-(_wallLength/2), getDir _start] getPos [_wallLength*_w, getDir _start + 90]; 
        _wall = createVehicle [selectRandom _wallTypes, _pos, [], 0, "CAN_COLLIDE"]; 
		_wall allowDamage false; _wall setDir (getDir _start+90); _walls pushBack _wall;
        _wall setPosASL [(getPosASL _wall)#0, (getPosASL _wall)#1, (getPosASL _enterance)#2];
    }}; 

    //-- Create helpers to represent rooms
    for "_h" from 1 to _height do {for "_w" from 1 to _width do {  //-- For each cell
        [_h + round random _size max (_h+1) min _height, _w + round random _size max (_w+1) min _width, false] params ["_hR", "_wR", "_used"];  //-- Random height and width of each room (Min so it doesnt leave bounds)
        for "_hC" from _h to _hR do {for "_wC" from _w to _wR do {if ([_hC, _wC] in _usedCells) exitWith {_used = true}}}; if (_used) then {continue};  //-- For each cell in room, check if used
        for "_hC" from _h to _hR do {for "_wC" from _w to _wR do {sleep _sleep;  //-- For each cell in room, create a helper
            _pos = (_start getPos [(_wallLength*_hC)-(_wallLength/2), getDir _start]) getPos [(_wallLength*_wC)-(_wallLength/2), getDir _start + 90];
            _helper = createVehicleLocal [_helperTypes#_index, [_pos#0,_pos#1,0.1], [], 0, "CAN_COLLIDE"];  
            _helper setPosASL [(getPosASL _helper)#0, (getPosASL _helper)#1, (getPosASL _start)#2];
           _helpers pushBack _helper; _usedCells pushBack [_hC, _wC];  //-- Create helper, declared coordinates as used to check above
        }};
        _index = _index + 1;  //-- Used to create unique helper objects for each room
    }};

    //-- Create helpers in dead spaces (not rooms)
    for "_h" from 1 to _height do {for "_w" from 1 to _width do {sleep _sleep;  //-- For each cell
        if ([_h, _w] in _usedCells) then {continue};  //-- If used in rooms, skip, else create _helper:
        _pos = (_start getPos [(_wallLength*_h)-(_wallLength/2), getDir _start]) getPos [(_wallLength*_w)-(_wallLength/2), getDir _start + 90];
        _helper = createVehicleLocal [_deadType, [_pos#0,_pos#1,0.1], [], 0, "CAN_COLLIDE"];
        _helper setPosASL [(getPosASL _helper)#0, (getPosASL _helper)#1, (getPosASL _start)#2];
        _helpers pushBack _helper;
    }};

    _wallLength = _wallLength + 0.2;  //-- Floating point fun

    //-- Merge adjacent, visible helpers into rooms
    {_helper = _x; {deleteVehicle ((lineIntersectsSurfaces [getPosASL _helper, getPosASL _x])#0#2)} forEach (_helper nearObjects _wallLength select {typeOf _x == typeOf _helper}); sleep _sleep} forEach _helpers;

    //-- Random openings
    {
        [_x] params ["_helper"];
        _different = (_helper nearObjects _wallLength) select {typeOf _x != typeOf _helper && typeOf _x in _helperTypes};  //-- Get different type adjacent helpers
        if (count _different > 0 && random 1 < _openingChance && count (_relations select {typeOf _helper in _x}) == 0) then {  //-- If there are any, maybe create opening 
            _different = _different#0; _wall = (lineIntersectsSurfaces [getPosASL _helper, getPosASL _different, _helper, _different])#0#2; 
            hideObjectGlobal _wall; _openings pushBack _wall; _relations pushBack [typeOf _helper, typeOf _different]; sleep _sleep;
        };
    } forEach _helpers;

    //-- Flood fill rooms to reach the end, if no ending found - make hole
    _usedTypes = [];
    {
        [_x] params ["_helper"]; if (typeOf _x in _usedTypes) then {continue}; if (typeOf _x != _deadType) then {_usedTypes pushBack typeOf _helper};
        while {true} do {  //-- While helper cannot reach the end
            tsp_kh_found = false; tsp_kh_hits = []; tsp_kh_close = objNull; {_x hideObjectGlobal false} forEach _helpers;
            [_helper, _helperTypes, _wallLength, _end, _sleep] call tsp_fnc_killhouse_flood; if (tsp_kh_found) exitWith {};
            _intersect = lineIntersectsSurfaces [getPosASL tsp_kh_close, getPosASL _end];  //-- Get walls between helper closest to exit and exit
            hideObjectGlobal (_intersect#0#2); _openings pushBack (_intersect#0#2);       //-- Open first wall between closest helper and end
        };
    } forEach _helpers;
    {hideObjectGlobal _x} forEach _helpers; 
 
    //-- Fill some of the holes with doors
    {if (random 1 < _doorChance) then {sleep _sleep;
        _opening = _x;
        _doorType = selectRandom (if (count (_doors select {_x distance2D _opening < _wallLength}) == 0) then {_doorTypes} else {_openDoorTypes});
        _door = createVehicle [_doorType, [0,0,0], [], 0, "CAN_COLLIDE"]; _door attachTo [_opening, [0,0,0]]; detach _door; _door allowDamage false;
        if (random 1 < _lockChance) then {_door setVariable ["bis_disabled_Door_1", 1, true]};
        if (random 1 > 0.5) then {_door setDir (getDir _door + 180)};
        _doors pushBack _door; 
    }} forEach _openings;

    _rooms = [];
    {_rooms pushBack (nearestObjects[_start, [_x], (_width max _height)*_wallLength + 20])} forEach _helperTypes;  //-- Create array from _helpers but ordered by room

    //-- Populate
    {  //-- For For each cell
        _helper = _x; 
        _furthest = _helpers select {typeOf _x == typeOf _helper}; _furthest = _furthest apply {[_x distance2D _helper, _x]}; _furthest sort false; _furthest = _furthest#0#1;  //-- Get furthest cell in room
        _nearestWalls = (nearestObjects [_helper, [], _wallLength]) select {!isObjectHidden _x && typeOf _x in _wallTypes + [_outerWallType]};     //-- Get all nearby walls   
        _nearestOpenings = (nearestObjects [_helper, [_outerDoorType], _wallLength+1] + _openings) select {_x distance2D _helper < _wallLength};  //-- Get all nearby openings
        _nearestHelpers = (nearestObjects [_helper, [], _wallLength+1.7]) select {typeOf _x in [typeOf _helper]};                                //-- Get cell count around helper
        _nearestUnits = _units select {_x distance2D _helper < _wallLength};                                                                    //-- Get all nearyby units

        //-- Targets
        _unitCommon = count _nearestWalls > 1 && count _nearestOpenings == 0 && count _nearestUnits == 0 && count _units < _unitsMax;
        if (count _nearestHelpers != 3 && _unitCommon && _targetChance > 0 && (random 1 < _targetChance || count _units < _unitsMin)) exitWith {  //-- Targets
            _target = createVehicle [selectRandom _targetTypes, getPos _helper, [], 0, "CAN_COLLIDE"]; _target setVehiclePosition [_target, [], 0, "CAN_COLLIDE"];
            //if (typeOf _target == "Target_F") then {_target addEventHandler ["HitPart", {playSound3D [getMissionPath "gong.ogg", (_this#0#0), false, getPosASL (_this#0#0), 5, random 3 max 1, 50]}]};
            _target setDir (_furthest getDir _helper); _units pushBack _target; sleep _sleep;
            continue
        };
        if (_unitCommon && _enemyChance > 0 && (random 1 < _enemyChance || count _units < _unitsMin)) exitWith {  //-- Enemies
            _group = createGroup _enemySide; _group deleteGroupWhenEmpty true; 
            _enemy = _group createUnit [selectRandom _enemyTypes, getPos _helper, [], 1, "CAN_COLLIDE"]; 
            _enemy attachTo [_helper, [0,0,0]]; detach _enemy; _enemy disableAI "PATH";
            _enemy setFormDir (_helper getDir _furthest); _enemy setDir (_helper getDir _furthest); 
            _enemy setUnitPos (selectRandom ["UP", "MIDDLE"]); 
            _units pushBack _enemy; sleep _sleep;
            if (random 1 < _hostageChance) then {  //-- Hostages
                _group = createGroup civilian; _group deleteGroupWhenEmpty true;
                _hostage = _group createUnit [selectRandom _civilTypes, getPos _helper, [], 1, "CAN_COLLIDE"]; _hostage attachTo [_enemy, [0,0.5,0]]; detach _hostage; 
                _hostage setUnitPos (unitPos _enemy); _hostage disableAI "MOVE"; _hostage setFormDir (_helper getDir _furthest); _units pushBack _hostage; sleep _sleep;
            };
            continue
        };
        if (_unitCommon && _civilChance > 0 && (random 1 < _civilChance || count _units < _unitsMin)) exitWith {  //-- Civilians
            _group = createGroup civilian; _group deleteGroupWhenEmpty true; 
            _civilian = _group createUnit [selectRandom _civilTypes, getPos _helper, [], 1, "CAN_COLLIDE"]; _civilian attachTo [_helper, [0,0,0]]; detach _civilian; 
            _civilian setFormDir (_helper getDir _furthest); _civilian setUnitPos (selectRandom ["UP", "MIDDLE", "DOWN"]); _civilian disableAI "MOVE"; 
            _units pushBack _civilian; sleep _sleep;
            continue
        };

        //-- Furniture
        if (random 1 > _furnitureChance) then {continue};
        {  //-- For each class, see if appropriate
            _x params ["_class", "_max", "_radius", "_rotate", "_offset", "_offsetVert", "_wall", "_open", "_corner", "_cornerDir", "_randomDir"];
            _nearestFurniture = _furniture select {_x distance2D _helper < _radius};  //-- Get all nearby furniture
            if (count (_furniture select {typeOf _x == _class || (getModelInfo _x)#0 in _class}) == _max) then {continue};  //-- Too many of this type already
            if (count (_nearestOpenings + _nearestFurniture) > 0) then {continue};        //-- If next to door, or position already occupied
            if ((_wall && count _nearestWalls > 0 && count _nearestWalls == 1) || (_corner && count _nearestHelpers == 4) || (_open && count _nearestWalls == 0)) then {
                _item = if ("p3d" in _class) then {createSimpleObject [_class, getPosASL _helper]} else {createVehicle [_class, getPos _helper, [], 0, "CAN_COLLIDE"]}; 
                _item setPosASL [(getPosASL _item)#0,(getPosASL _item)#1, ((getPosASL _enterance)#2) + _offsetVert]; _item setDir ((getDir _item) + random _randomDir);
                if (_wall) then {_item setPosASL (getPosASL _item vectorAdd (((getPosASL _item) vectorDiff (getPosASL (_nearestWalls#0))) vectorMultiply _offset)); _item setDir (_helper getDir _nearestWalls#0) + _rotate};
                if (_cornerDir && count _nearestWalls == 2) then {_item setDir (_helper getDir _furthest) + _rotate};
                [_item, getDir _item] remoteExec ["setDir", 0]; [_item, getPosASL _item] remoteExec ["setPosASL", 0];
                _furniture pushBack _item; sleep (_sleep*100); //break;  //-- Added furniture to cell, no need to check the rest
            };
        } forEach (_furnitureTypes call BIS_fnc_arrayShuffle);  //-- Diversity innit
    } forEach _helpers;

    //-- Wait until killhouse is clear or has been replaced
    _start setVariable ["generating", false, true]; _start setVariable ["reset", false, true];
    {["", "Killhouse Generated!"] remoteExec ["BIS_fnc_showSubtitle", _x]} forEach (allPlayers select {_x distance _start < _height}); deleteVehicle _blocker;
	waitUntil {sleep 0.5; (count (allUnits select {alive _x && side _x == _enemySide && _x inArea _area}) + _targetChance == 0) || _start getVariable "reset"};  //-- Wait until killhouse is clear or new house generated
    if !(_start getVariable "reset") then {{["", "Killhouse Clear!"] remoteExec ["BIS_fnc_showSubtitle", _x]} forEach (allPlayers select {_x distance _end < (_height*2)})};
    if !(_start getVariable "reset") then {playSound3D ["A3\Missions_F_Oldman\Data\sound\beep.ogg", _end, false, getPosASL _end, 5, 1, 100]};  //-- BEEP	
	waitUntil {sleep 0.5; count (allPlayers select {alive _x && _x inArea _area}) == 0 || _start getVariable "reset"};  //-- Wait until all players are out or new house generated
	{[_x,1,0] call bis_fnc_door} forEach ((_start nearObjects [_outerDoorType, 5]) + (_end nearObjects [_outerDoorType, 5]));  //-- Close outer doors
    {deleteVehicle _x} forEach (_helpers + _units + _doors + _walls + _furniture);  //-- Bye bye
    {["", "Killhouse Reset."] remoteExec ["BIS_fnc_showSubtitle", _x]} forEach (allPlayers select {_x distance _end < (_height*2)});
};

tsp_fnc_killhouse_flood = {  //-- Fucky wucky recursive stuff below
    params ["_helper", "_helperTypes", "_wallLength", "_end", "_sleep"]; _helper hideObjectGlobal true; sleep _sleep;
    if (tsp_kh_close distance2D _end > _helper distance2D _end) then {tsp_kh_close = _helper};
    if (_helper distance2D _end < _wallLength) exitWith {tsp_kh_found = true}; tsp_kh_hits pushBackUnique _helper;  //-- If found, exit
    _neighbours = (_helper nearObjects _wallLength) select {(typeOf _x) in _helperTypes && count (lineIntersectsSurfaces [getPosASL _helper, getPosASL _x, _helper, _x]) == 0};  //-- Get unhit neighbours
    {if !(_x in tsp_kh_hits) then {[_x, _helperTypes, _wallLength, _end, _sleep] call tsp_fnc_killhouse_flood}} forEach _neighbours;  //-- Recursion on neighbours
};

tsp_fnc_killhouse_menu = {
	params ["_start", "_end", "_area", "_width", "_height", "_size", ["_display", findDisplay 46 createDisplay "RscDisplayEmpty"]]; tsp_killhouse_params = _this;

	_title = _display ctrlCreate ["RscText", 9998]; _w = 0.4; _h = 0.042; _y = 0.375; _title ctrlSetPosition [(1.0-_w)*0.5,((1.0-_h)*0.5)-_y,_w,_h];
	_title ctrlSetFont "PuristaMedium"; _title ctrlSetText "GENERATE KILLHOUSE"; _title ctrlSetBackgroundColor [11/100,50/100,20/100,0.9]; _title ctrlCommit 0;	
	
	_box = _display ctrlCreate ["RscText", 9998]; _w = 0.4; _h = 0.7; _y = 0.00; _box ctrlSetPosition [(1.0-_w)*0.5,((1.0-_h)*0.5)-_y,_w,_h];
	_box ctrlSetBackgroundColor [0,0,0,0.7]; _box ctrlCommit 0;

	_theme = _display ctrlCreate ["RscCombo", 9999]; _w = 0.38; _h = 0.045; _y = 0.3; _theme ctrlSetPosition [(1.0-_w)*0.5,((1.0-_h)*0.5)-_y,_w,_h];
	{_theme lbSetData [_theme lbAdd _x, _x]} forEach tsp_killhouse_themes; _theme lbSetCurSel 0; _theme ctrlCommit 0;
	_theme ctrlAddEventHandler ["LBSelChanged", {params ["_control", "_selectedIndex"]; tsp_killhouse_theme = _control lbData lbCurSel _control}];

	_enemies = _display ctrlCreate ["RscText", 9998]; _w = 0.39; _h = 0.042; _y = 0.25; _enemies ctrlSetPosition [(1.0-_w)*0.5,((1.0-_h)*0.5)-_y,_w,_h];
	_enemies ctrlSetFont "PuristaLight"; _enemies ctrlSetText "ENEMIES:"; _enemies ctrlCommit 0;
	_enemies = _display ctrlCreate ["RscXSliderH", 9999]; _w = 0.38; _h = 0.045; _y = 0.2; _enemies ctrlSetPosition [(1.0-_w)*0.5,((1.0-_h)*0.5)-_y,_w,_h];
	_enemies ctrlAddEventHandler ["SliderPosChanged", {params ["_control", "_newValue"]; tsp_killhouse_enemies = _newValue}];
	_enemies sliderSetRange [0, 1]; _enemies sliderSetPosition tsp_killhouse_enemies; _enemies ctrlCommit 0;

	_targets = _display ctrlCreate ["RscText", 9998]; _w = 0.39; _h = 0.042; _y = 0.15; _targets ctrlSetPosition [(1.0-_w)*0.5,((1.0-_h)*0.5)-_y,_w,_h];
	_targets ctrlSetFont "PuristaLight"; _targets ctrlSetText "TARGETS:"; _targets ctrlCommit 0;
	_targets = _display ctrlCreate ["RscXSliderH", 9999]; _w = 0.38; _h = 0.045; _y = 0.1; _targets ctrlSetPosition [(1.0-_w)*0.5,((1.0-_h)*0.5)-_y,_w,_h];
	_targets ctrlAddEventHandler ["SliderPosChanged", {params ["_control", "_newValue"]; tsp_killhouse_targets = _newValue}];
	_targets sliderSetRange [0, 1]; _targets sliderSetPosition tsp_killhouse_targets; _targets ctrlCommit 0;

	_civilians = _display ctrlCreate ["RscText", 9998]; _w = 0.39; _h = 0.042; _y = 0.05; _civilians ctrlSetPosition [(1.0-_w)*0.5,((1.0-_h)*0.5)-_y,_w,_h];
	_civilians ctrlSetFont "PuristaLight"; _civilians ctrlSetText "CIVILIANS:"; _civilians ctrlCommit 0;
	_civilians = _display ctrlCreate ["RscXSliderH", 9999]; _w = 0.38; _h = 0.045; _y = 0.00; _civilians ctrlSetPosition [(1.0-_w)*0.5,((1.0-_h)*0.5)-_y,_w,_h];
	_civilians ctrlAddEventHandler ["SliderPosChanged", {params ["_control", "_newValue"]; tsp_killhouse_civilians = _newValue}];
	_civilians sliderSetRange [0, 0.1]; _civilians sliderSetPosition tsp_killhouse_civilians; _civilians ctrlCommit 0;

	_hostages = _display ctrlCreate ["RscText", 9998]; _w = 0.39; _h = 0.042; _y = -0.05; _hostages ctrlSetPosition [(1.0-_w)*0.5,((1.0-_h)*0.5)-_y,_w,_h];
	_hostages ctrlSetFont "PuristaLight"; _hostages ctrlSetText "HOSTAGES:"; _hostages ctrlCommit 0;
	_hostages = _display ctrlCreate ["RscXSliderH", 9999]; _w = 0.38; _h = 0.045; _y = -0.10; _hostages ctrlSetPosition [(1.0-_w)*0.5,((1.0-_h)*0.5)-_y,_w,_h];
	_hostages ctrlAddEventHandler ["SliderPosChanged", {params ["_control", "_newValue"]; tsp_killhouse_hostages = _newValue}];
	_hostages sliderSetRange [0, 0.1]; _hostages sliderSetPosition tsp_killhouse_hostages; _hostages ctrlCommit 0;

	_locks = _display ctrlCreate ["RscText", 9998]; _w = 0.39; _h = 0.042; _y = -0.15; _locks ctrlSetPosition [(1.0-_w)*0.5,((1.0-_h)*0.5)-_y,_w,_h];
	_locks ctrlSetFont "PuristaLight"; _locks ctrlSetText "LOCKED:"; _locks ctrlCommit 0;
	_locks = _display ctrlCreate ["RscXSliderH", 9999]; _w = 0.38; _h = 0.045; _y = -0.20; _locks ctrlSetPosition [(1.0-_w)*0.5,((1.0-_h)*0.5)-_y,_w,_h];
	_locks ctrlAddEventHandler ["SliderPosChanged", {params ["_control", "_newValue"]; tsp_killhouse_locks = _newValue}];
	_locks sliderSetRange [0, 1]; _locks sliderSetPosition tsp_killhouse_locks; _locks ctrlCommit 0;

	_furniture = _display ctrlCreate ["RscText", 9998]; _w = 0.39; _h = 0.042; _y = -0.25; _furniture ctrlSetPosition [(1.0-_w)*0.5,((1.0-_h)*0.5)-_y,_w,_h];
	_furniture ctrlSetFont "PuristaLight"; _furniture ctrlSetText "FURNITURE:"; _furniture ctrlCommit 0;
	_furniture = _display ctrlCreate ["RscXSliderH", 9999]; _w = 0.38; _h = 0.045; _y = -0.30; _furniture ctrlSetPosition [(1.0-_w)*0.5,((1.0-_h)*0.5)-_y,_w,_h];
	_furniture ctrlAddEventHandler ["SliderPosChanged", {params ["_control", "_newValue"]; tsp_killhouse_furniture = _newValue}];
	_furniture sliderSetRange [0, 0.7]; _furniture sliderSetPosition tsp_killhouse_furniture; _furniture ctrlCommit 0;

	_button = _display ctrlCreate ["RscButtonMenu", 9998]; _w = 0.4; _h = 0.042; _y = - 0.373; _button ctrlSetPosition [(1.0-_w)*0.5,((1.0-_h)*0.5)-_y,_w,_h];
	_button ctrlSetText "GENERATE"; _button ctrlSetFont "PuristaLight"; _button ctrlCommit 0; _button setVariable ["display", _display]; 
	_button ctrlAddEventHandler ["buttonClick", {
		params ["_control"]; tsp_killhouse_params params ["_start", "_end", "_area", ["_width", 6], ["_height", 18], ["_size", 5]]; 
        _side = if (tsp_killhouse_theme in ["Tanoa", "Livonia"]) then {resistance} else {east};
		[
            _start, _end, _area, _width, _height, _size,  //-- Width, height, room size
			5, 20, tsp_killhouse_hostages,  //-- Min, max, hostage chance
			tsp_killhouse_enemies, _side, missionNameSpace getVariable ["enemy_"+tsp_killhouse_theme, []],  //-- Enemy chance, side, type
			tsp_killhouse_civilians, missionNameSpace getVariable ["civilian_"+tsp_killhouse_theme, []],  //-- Civil chance, type
			tsp_killhouse_targets, missionNameSpace getVariable ["target_"+tsp_killhouse_theme, ["Target_F"]],  //-- Target chance, type
			tsp_killhouse_furniture, missionNameSpace getVariable ["furniture_"+tsp_killhouse_theme, []],  //-- Furniture chance, type
            tsp_killhouse_locks, 0.5, 0.95  //--  Locked, openings, doors
        ] remoteExec ["tsp_fnc_killhouse", 2];
		_control getVariable "display" closeDisplay 1;
	}];
    while {_display isNotEqualTo displayNull} do {if (kh1_start getVariable ['generating', false]) exitWith {_display closeDisplay 1;}};
};

tsp_killhouse_themes = ["Altis", "Tanoa", "Livonia"];
if (isClass (configFile >> "CfgPatches" >> "CUP_StandaloneTerrains_Core") && isClass (configFile >> "CfgPatches" >> "UK3CB_Factions_Common")) then {tsp_killhouse_themes pushBack "Takistan"};
if (isClass (configFile >> "CfgPatches" >> "CUP_StandaloneTerrains_Core") && isClass (configFile >> "CfgPatches" >> "rhsgref_infantry")) then {tsp_killhouse_themes pushBack "Chernarus"};
tsp_killhouse_theme = "Altis";
tsp_killhouse_enemies = 0.5;
tsp_killhouse_hostages = 0.01;
tsp_killhouse_civilians = 0.05;
tsp_killhouse_furniture = 0.2;
tsp_killhouse_targets = 0;
tsp_killhouse_locks = 0.5;
enemy_altis = ["O_G_Soldier_AR_F","O_G_medic_F","O_G_Soldier_GL_F","O_G_Soldier_M_F","O_G_officer_F","O_G_Soldier_F","O_G_Soldier_lite_F","O_G_Soldier_SL_F","O_G_Soldier_TL_F"];
enemy_tanoa = ["I_C_Soldier_Bandit_7_F","I_C_Soldier_Bandit_3_F","I_C_Soldier_Bandit_5_F","I_C_Soldier_Bandit_1_F","I_C_Soldier_Bandit_4_F","I_C_Soldier_Bandit_8_F","I_C_Soldier_Para_7_F","I_C_Soldier_Para_2_F","I_C_Soldier_Para_4_F","I_C_Soldier_Para_1_F"];
enemy_livonia = ["I_L_Criminal_SG_F","I_L_Criminal_SMG_F","I_L_Hunter_F","I_L_Looter_Rifle_F","I_L_Looter_Pistol_F","I_L_Looter_SG_F","I_L_Looter_SMG_F"];
enemy_chernarus = ["rhsgref_ins_arifleman_rpk","rhsgref_ins_commander","rhsgref_ins_machinegunner","rhsgref_ins_medic","rhsgref_ins_squadleader","rhsgref_ins_rifleman","rhsgref_ins_rifleman_akm","rhsgref_ins_rifleman_aks74","rhsgref_ins_rifleman_aksu","rhsgref_ins_grenadier","rhsgref_ins_saboteur","rhsgref_ins_engineer"];
enemy_takistan = if (isClass (configFile >> "CfgPatches" >> "tsp_faction_tkm")) then {
    ["tsp_tkm_mg42","tsp_tkm_pkm","tsp_tkm_rpk","tsp_tkm_doctor","tsp_tkm_ak74","tsp_tkm_akm","tsp_tkm_gp25","tsp_tkm_k98","tsp_tkm_l1a1","tsp_tkm_m1","tsp_tkm_m16","tsp_tkm_mosin","tsp_tkm_sapper","tsp_tkm_warlord"]
} else {
    ["UK3CB_TKM_O_AR","UK3CB_TKM_O_GL","UK3CB_TKM_O_LMG","UK3CB_TKM_O_MG","UK3CB_TKM_O_MG_ASST","UK3CB_TKM_O_MK","UK3CB_TKM_O_MD","UK3CB_TKM_O_RIF_3","UK3CB_TKM_O_RIF_1","UK3CB_TKM_O_RIF_2","UK3CB_TKM_O_WAR"]
};
civilian_altis = ["C_man_polo_1_F","C_man_polo_2_F","C_man_polo_3_F","C_man_polo_4_F","C_man_polo_5_F","C_man_polo_6_F","C_Man_Fisherman_01_F","C_man_p_fugitive_F"];
civilian_tanoa = ["C_Man_casual_1_F_tanoan","C_Man_casual_2_F_tanoan","C_Man_casual_3_F_tanoan","C_man_sport_1_F_tanoan","C_man_sport_2_F_tanoan","C_man_sport_3_F_tanoan","C_Man_casual_4_F_tanoan","C_Man_casual_5_F_tanoan","C_Man_casual_6_F_tanoan"];
civilian_livonia = ["C_Man_1_enoch_F","C_Man_2_enoch_F","C_Man_3_enoch_F","C_Man_4_enoch_F","C_Man_5_enoch_F","C_Man_6_enoch_F","C_Farmer_01_enoch_F"];
civilian_chernarus = ["tsp_civilian_citizen","tsp_civilian_farmwife","tsp_civilian_hooker","tsp_civilian_housewife","tsp_civilian_madam","tsp_civilian_pilot","tsp_civilian_priest","tsp_civilian_profiteer","tsp_civilian_rocker","tsp_civilian_secretary","tsp_civilian_sportswoman","tsp_civilian_teacher","tsp_civilian_woodlander","tsp_civilian_workwoman","tsp_civilian_worker"];
civilian_takistan = ["tsp_civilian_tak1","tsp_civilian_tak2","tsp_civilian_tak3","tsp_civilian_tak6","tsp_civilian_takwoman2","tsp_civilian_takwoman1","tsp_civilian_takwoman3"];
furniture_altis = [
    ["Land_ArmChair_01_F",2,2,0,-0.1,0,false,false,true,true,0],  //-- Class // max, radius, rotation, offset, vertical // wall, open, corner, cornerDir, randomDir

    ["Land_ShelvesWooden_F",2,2,90,-0.6,0,true,false,true,false,0], 
    ["OfficeTable_01_old_F",1,2,0,-0.5,0,true,false,false,false,0],
    ["Land_Bench_F",1,2,90,-0.6,0,true,false,false,false,0], 
    ["Land_OfficeCabinet_02_F",2,2,0,-0.6,0,true,false,true,false,0], 
    ["Land_Metal_rack_Tall_F",2,2,0,-0.5,0,true,false,true,false,0], 
    ["Land_Metal_wooden_rack_F",1,2,0,-0.5,0,true,false,true,false,0], 
    ["Land_Rack_F",2,3,90,-0.6,0,true,false,true,false,0], 
    ["Land_Sofa_01_F",1,4,180,-0.2,0,true,false,false,false,0], 
    ["Land_WoodenBed_01_F",1,4,0,0.5,0,true,false,false,false,0], 

    ["Land_WoodenTable_large_F",1,3,0,0,0,false,true,false,false,0],
    ["Land_WoodenTable_small_F",1,3,0,0,0,false,true,false,false,0],
    ["Land_Rug_01_F",1,4,0,0,0,false,true,false,false,20],
    ["Land_Rug_01_Traditional_F",1,4,0,0,0,false,true,false,false,20],
    ["Land_CratesWooden_F",2,2,0,0,0,true,true,false,false,10]
];
furniture_tanoa = [
    ["Land_RattanChair_01_F",2,2,180,0.1,0,false,false,true,true,10],  //-- Class // max, radius, rotation, offset, vertical // wall, open, corner, cornerDir, randomDir
    ["Land_ChairPlastic_F",2,2,-90,0.1,0,false,false,true,true,10],

    ["Land_ShelvesWooden_F",2,2,90,-0.6,0,true,false,true,false,0], 
    ["Land_WoodenCounter_01_F",1,2,0,-0.4,0,true,false,false,false,0],
    ["Land_OfficeCabinet_02_F",2,2,0,-0.6,0,true,false,true,false,0],
    ["Land_Metal_rack_Tall_F",2,2,0,-0.5,0,true,false,true,false,0], 
    ["Land_Metal_wooden_rack_F",1,2,0,-0.5,0,true,false,true,false,0], 
    ["Land_Rack_F",2,3,90,-0.6,0,true,false,true,false,0], 
    ["\A3\structures_f_enoch\furniture\Chairs\vojenska_palanda\vojenska_palanda.p3d",1,4,0,0,-0.22,true,false,false,false,0], 

    ["Land_RattanTable_01_F",1,4,0,0,0,false,true,false,false,30],
    ["Land_TablePlastic_01_F",1,4,0,0,0,false,true,false,false,30],
    ["Land_WoodenTable_large_F",1,4,0,0,0,false,true,false,false,30],
    ["Land_WoodenTable_small_F",1,4,0,0,0,false,true,false,false,30],
    ["Land_Garbage_square3_F",1,2,0,0,0,false,true,false,false,360],
    ["Land_Garbage_square5_F",1,2,0,0,0,false,true,false,false,360],
    ["Land_WoodenCrate_01_F",1,2,90,-0.5,0,true,false,false,false,50],
    ["Land_WoodenCrate_01_stack_x3_F",1,2,90,0,0,false,true,true,false,50],
    ["Land_WoodenCrate_01_stack_x5_F",1,2,0,0,0,false,true,true,false,50]
];
furniture_livonia = [
    ["Land_ArmChair_01_F",2,2,0,-0.1,0,false,false,true,true,0],  //-- Class // max, radius, rotation, offset, vertical // wall, open, corner, cornerDir, randomDir
    ["Land_ChairPlastic_F",2,2,-90,0.1,0,false,false,true,true,10],
    ["a3\structures_f_enoch\furniture\cases\locker\locker_closed_v1.p3d",1,2,0,-0.6,0,true,false,true,false,0],
    ["a3\structures_f_enoch\furniture\cases\locker\locker_open_v1.p3d",1,2,0,-0.6,0,true,false,true,false,0],

    ["Land_Sofa_01_F",1,4,180,-0.2,0,true,false,false,false,0], 
    ["a3\structures_f_enoch\furniture\cases\library_a\library_a.p3d",1,3,180,-0.7,0,true,false,true,false,0], 
    ["a3\structures_f_enoch\furniture\cases\library_a\library_a_open.p3d",1,3,180,-0.7,0,true,false,true,false,0], 
    ["a3\structures_f_enoch\furniture\school_equipment\class_case_b_closed.p3d",1,3,0,-0.4,0,true,false,true,false,0], 
    ["a3\structures_f_enoch\furniture\school_equipment\class_case_b_open.p3d",1,3,0,-0.4,0,true,false,true,false,0], 
    ["a3\structures_f_enoch\furniture\school_equipment\class_case_a_closed.p3d",1,3,0,-0.5,0,true,false,true,false,0], 
    ["a3\structures_f_enoch\furniture\school_equipment\class_case_a_open.p3d",1,3,0,-0.5,0,true,false,true,false,0], 
    ["a3\structures_f_enoch\furniture\cases\dhangar_borwnskrin\dhangar_brownskrin.p3d",1,3,0,-0.5,0,true,false,false,false,0], 
    ["a3\structures_f_enoch\furniture\cases\dhangar_borwnskrin\dhangar_brownskrin_open.p3d",1,3,0,-0.5,0,false,true,false,false,360], 
    ["Land_WoodenBed_01_F",1,4,0,0.5,0,true,false,false,false,0], 

    ["a3\structures_f_enoch\furniture\decoration\piano\piano.p3d",1,4,0,0,0.9,false,true,false,false,20],
    ["a3\structures_f_enoch\furniture\various\carpet_2_dz.p3d",1,2,0,0,0.2,false,true,false,false,30],
    ["Land_TableBig_01_F",1,3,0,0,0,false,true,false,false,30],
    ["Land_WoodenCrate_01_F",1,2,90,-0.5,0,true,false,false,false,30],
    ["Land_WoodenCrate_01_stack_x3_F",1,2,90,0,0,false,true,true,false,30],
    ["Land_WoodenCrate_01_stack_x5_F",1,2,0,0,0,false,true,true,false,30]
];
furniture_chernarus = furniture_livonia;
furniture_takistan = [
    ["Land_ArmChair_01_F",2,2,0,-0.1,0,false,false,true,true,0],  //-- Class // max, radius, rotation, offset, vertical // wall, open, corner, cornerDir, randomDir
    ["Land_CratesPlastic_F",2,2,0,-0.1,0,false,false,true,true,0],
    ["Land_CratesShabby_F",2,2,0,-0.1,0,false,false,true,true,0],

    ["Land_Cabinet_EP1",2,2,90,-0.4,0,true,false,true,false,0], 
    ["Land_Bench_F",1,2,90,-0.6,0,true,false,false,false,0], 
    ["Land_Rack_F",2,3,90,-0.6,0,true,false,true,false,0], 
    ["Land_Sofa_01_F",1,4,180,-0.2,0,true,false,false,false,0], 
    ["a3\structures_f_enoch\furniture\cases\library_a\library_a.p3d",1,3,180,-0.7,0,true,false,true,false,0], 
    ["a3\structures_f_enoch\furniture\cases\library_a\library_a_open.p3d",1,3,180,-0.7,0,true,false,true,false,0], 
    ["a3\structures_f_enoch\furniture\school_equipment\class_case_b_closed.p3d",1,3,0,-0.4,0,true,false,true,false,0], 
    ["a3\structures_f_enoch\furniture\school_equipment\class_case_b_open.p3d",1,3,0,-0.4,0,true,false,true,false,0], 
    ["a3\structures_f_enoch\furniture\school_equipment\class_case_a_closed.p3d",1,3,0,-0.5,0,true,false,true,false,0], 
    ["a3\structures_f_enoch\furniture\school_equipment\class_case_a_open.p3d",1,3,0,-0.5,0,true,false,true,false,0], 
    ["a3\structures_f_enoch\furniture\cases\dhangar_borwnskrin\dhangar_brownskrin.p3d",1,3,0,-0.5,0,true,false,false,false,0], 
    ["a3\structures_f_enoch\furniture\cases\dhangar_borwnskrin\dhangar_brownskrin_open.p3d",1,3,0,-0.5,0,false,true,false,false,360], 
    ["a3\structures_f_enoch\furniture\beds\postel_panelak1.p3d",1,3,0,0.18,0,true,false,false,false,0], 
    ["a3\structures_f_enoch\furniture\beds\postel_panelak2.p3d",1,3,0,0.18,-0.1,true,false,false,false,0], 

    ["Land_Table_EP1",1,3,0,0,0,false,true,false,false,0],
    ["Land_Table_small_EP1",1,3,0,0,0,false,true,false,false,0],
    ["Land_Blankets_EP1",1,4,0,0,0,false,true,false,false,20],
    ["Land_Carpet_2_EP1",1,4,0,0,0,false,true,false,false,20],
    ["Land_CratesWooden_F",2,2,0,0,0,true,true,false,false,10]
];