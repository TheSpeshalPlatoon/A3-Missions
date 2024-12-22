tsp_fnc_killhouse = {
    params [
        "_start", "_end", "_area", "_width", "_height", ["_size", 4], ["_sleep", 0],  //0.001
        ["_wallTypes", ["Bro_MSW_2m"]], ["_outerWallType", "Bro_MSW_2m_conc"], ["_wallLength", 2],
        ["_doorTypes", ["Bro_MSW_2m_d", "Bro_MSW_2m_d", "Bro_MSW_2m_de"]], ["_outerDoorType", "Bro_MSW_2m_d_conc"], ["_openingChance", 0.2], ["_doorChance", 0.95], ["_lockChance", 0.5], 
        ["_unitsMin", 5], ["_unitsMax", 16], ["_hostageChance", 0.05],
        ["_enemyChance", 0.7], ["_enemySide", resistance], ["_enemyTypes", enemy_altis],
        ["_civilChance", 0.05], ["_civilTypes", civ_altis],
        ["_targetChance", 0], ["_targetTypes", ["Target_F"]],
        ["_furnitureChance", 0.5], ["_furnitureTypes", furniture_altis],
        ["_deadType", "Sign_Pointer_Yellow_F"], ["_helperTypes", [
            "Sign_Arrow_F","Sign_Arrow_Blue_F","Sign_Arrow_Cyan_F","Sign_Arrow_Green_F","Sign_Arrow_Pink_F","Sign_Arrow_Yellow_F",
            "Sign_Arrow_Large_F","Sign_Arrow_Large_Yellow_F","Sign_Arrow_Large_Pink_F","Sign_Arrow_Large_Green_F","Sign_Arrow_Large_Cyan_F","Sign_Arrow_Large_Blue_F",
            "Sign_Arrow_Direction_F","Sign_Arrow_Direction_Blue_F","Sign_Arrow_Direction_Cyan_F","Sign_Arrow_Direction_Green_F","Sign_Arrow_Direction_Pink_F","Sign_Arrow_Direction_Yellow_F",
            "Sign_Pointer_Blue_F","Sign_Pointer_Cyan_F","Sign_Pointer_Green_F","Sign_Pointer_Pink_F","Sign_Pointer_F","Sign_Pointer_Yellow_F"
        ]], 
        ["_units", []], ["_usedCells", []], ["_helpers", []], ["_openings", []], ["_relations", []], ["_index", 0], ["_doors", []], ["_walls", []], ["_furniture", []]
    ];

    //-- Check if killhouse is clear of players before generating, set reset to true to delete old killhouse
	if (count (allPlayers select {alive _x && _x inArea _area}) > 0) exitWith {["", "Killhouse is still occupied."] spawn "BIS_fnc_showSubtitle", _x};
	{[_x,1,0] call bis_fnc_door} forEach ((_start nearObjects [_outerDoorType, 5]) + (_end nearObjects [_outerDoorType, 5]));  //-- Close outer doors
    _blocker = createSimpleObject ["A3\structures_f\data\DoorLocks\planks_1.p3d", getPosASL _start]; _blocker attachTo [(_start nearObjects [_outerDoorType, 5])#0, [0,-0.2,-1.3]];
    playSound3D ["a3\sounds_f\ambient\quakes\earthquake"+str (round random 3 + 1)+".wss", _blocker, false, getPosASL _blocker, 5, 1, 50];
    _blocker spawn {while {sleep 1; alive _this} do {playSound3D ["a3\sounds_f\vehicles\armor\noises\tank_building_0"+str (round random 3 + 1)+".wss", _this, false, getPosASL _this, 5, random 2 max 0.5 min 2, 25]}};
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
    }}; 

    //-- Create vertical walls
    for "_h" from 1 to _height do {for "_w" from 1 to _width-1 do {sleep _sleep;
        _pos = _start getPos [(_wallLength*_h)-(_wallLength/2), getDir _start] getPos [_wallLength*_w, getDir _start + 90]; 
        _wall = createVehicle [selectRandom _wallTypes, _pos, [], 0, "CAN_COLLIDE"]; 
		_wall allowDamage false; _wall setDir (getDir _start+90); _walls pushBack _wall;
    }}; 

    //-- Create helpers to represent rooms
    for "_h" from 1 to _height do {for "_w" from 1 to _width do {  //-- For each cell
        [_h + round random _size max (_h+1) min _height, _w + round random _size max (_w+1) min _width, false] params ["_hR", "_wR", "_used"];  //-- Random height and width of each room (Min so it doesnt leave bounds)
        for "_hC" from _h to _hR do {for "_wC" from _w to _wR do {if ([_hC, _wC] in _usedCells) exitWith {_used = true}}}; if (_used) then {continue};  //-- For each cell in room, check if used
        for "_hC" from _h to _hR do {for "_wC" from _w to _wR do {sleep _sleep;  //-- For each cell in room, create a helper
            _pos = (_start getPos [(_wallLength*_hC)-(_wallLength/2), getDir _start]) getPos [(_wallLength*_wC)-(_wallLength/2), getDir _start + 90];
            _helpers pushBack createVehicleLocal [_helperTypes#_index, [_pos#0,_pos#1,0.1], [], 0, "CAN_COLLIDE"]; _usedCells pushBack [_hC, _wC];  //-- Create helper, declared coordinates as used to check above
        }};
        _index = _index + 1;  //-- Used to create unique helper objects for each room
    }}; 

    //-- Create helpers in dead spaces (not rooms)
    for "_h" from 1 to _height do {for "_w" from 1 to _width do {sleep _sleep;  //-- For each cell
        if ([_h, _w] in _usedCells) then {continue};  //-- If used in rooms, skip, else create _helper:
        _pos = (_start getPos [(_wallLength*_h)-(_wallLength/2), getDir _start]) getPos [(_wallLength*_w)-(_wallLength/2), getDir _start + 90];
        _helper = createVehicleLocal [_deadType, [_pos#0,_pos#1,0.1], [], 0, "CAN_COLLIDE"]; _helpers pushBack _helper;
    }};

    _wallLength = _wallLength + 0.2;  //-- Floating point fun

    //-- Merge adjacent, visible helpers into rooms
    {_helper = _x; {deleteVehicle ((lineIntersectsSurfaces [getPosASL _helper, getPosASL _x])#0#2)} forEach (_helper nearObjects _wallLength select {typeOf _x == typeOf _helper}); sleep _sleep} forEach _helpers;

    //-- Random openings
    {
        [_x] params ["_helper"];
        _different = (_helper nearObjects _wallLength) select {typeOf _x != typeOf _helper && typeOf _x in _helperTypes};  //-- Get different type adjacent helpers
        if (count _different > 0 && random 1 < _openingChance && count (_relations select {typeOf _helper in _x}) == 0) then {    //-- If there are any, maybe create opening 
            _different = _different#0; _wall = (lineIntersectsSurfaces [getPosASL _helper, getPosASL _different, _helper, _different])#0#2; 
            hideObjectGlobal _wall; _openings pushBack _wall; _relations pushBack [typeOf _helper, typeOf _different]; sleep _sleep;
        };
    } forEach _helpers;

    //-- Flood fill rooms to reach the end, if no ending found - make hole
    _usedTypes = [];
    {
        [_x] params ["_helper"]; if (typeOf _x in _usedTypes) then {continue}; _usedTypes pushBack typeOf _helper;
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
        _door = createVehicle [selectRandom _doorTypes, [0,0,0], [], 0, "CAN_COLLIDE"]; _door attachTo [_x, [0,0,0]]; detach _door; _door allowDamage false;
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
            if (typeOf _target == "Target_F") then {_target addEventHandler ["HitPart", {playSound3D [getMissionPath "gong.ogg", (_this#0#0), false, getPosASL (_this#0#0), 5, random 3 max 1, 50]}]};
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
                _item setPos [(getPos _item)#0,(getPos _item)#1, _offsetVert]; _item setDir ((getDir _item) + random _randomDir);
                if (_wall) then {_item setPos (getPos _item vectorAdd (((getPosASL _item) vectorDiff (getPosASL (_nearestWalls#0))) vectorMultiply _offset)); _item setDir (_helper getDir _nearestWalls#0) + _rotate};
                if (_cornerDir && count _nearestWalls == 2) then {_item setDir (_helper getDir _furthest) + _rotate};
                [_item, getDir _item] remoteExec ["setDir", 0]; [_item, getPos _item] remoteExec ["setPos", 0];
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

enemy_altis = ["O_G_Soldier_AR_F","O_G_medic_F","O_G_Soldier_GL_F","O_G_Soldier_M_F","O_G_officer_F","O_G_Soldier_F","O_G_Soldier_lite_F","O_G_Soldier_SL_F","O_G_Soldier_TL_F"];
enemy_tanoa = ["I_C_Soldier_Bandit_7_F","I_C_Soldier_Bandit_3_F","I_C_Soldier_Bandit_5_F","I_C_Soldier_Bandit_1_F","I_C_Soldier_Bandit_4_F","I_C_Soldier_Bandit_8_F","I_C_Soldier_Para_7_F","I_C_Soldier_Para_2_F","I_C_Soldier_Para_4_F","I_C_Soldier_Para_1_F"];
enemy_livonia = ["I_L_Criminal_SG_F","I_L_Criminal_SMG_F","I_L_Hunter_F","I_L_Looter_Rifle_F","I_L_Looter_Pistol_F","I_L_Looter_SG_F","I_L_Looter_SMG_F"];
civ_altis = ["C_man_polo_1_F","C_man_polo_2_F","C_man_polo_3_F","C_man_polo_4_F","C_man_polo_5_F","C_man_polo_6_F","C_Man_Fisherman_01_F","C_man_p_fugitive_F"];
civ_tanoa = ["C_Man_casual_1_F_tanoan","C_Man_casual_2_F_tanoan","C_Man_casual_3_F_tanoan","C_man_sport_1_F_tanoan","C_man_sport_2_F_tanoan","C_man_sport_3_F_tanoan","C_Man_casual_4_F_tanoan","C_Man_casual_5_F_tanoan","C_Man_casual_6_F_tanoan"];
civ_livonia = ["C_Man_1_enoch_F","C_Man_2_enoch_F","C_Man_3_enoch_F","C_Man_4_enoch_F","C_Man_5_enoch_F","C_Man_6_enoch_F","C_Farmer_01_enoch_F"];
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
    ["a3\structures_f_enoch\furniture\beds\postel_panelak1.p3d",1,3,0,0.18,0,true,false,false,false,0], 
    ["a3\structures_f_enoch\furniture\beds\postel_panelak2.p3d",1,3,0,0.18,-0.1,true,false,false,false,0], 
    ["Land_WoodenBed_01_F",1,4,0,0.5,0,true,false,false,false,0], 

    ["a3\structures_f_enoch\furniture\decoration\piano\piano.p3d",1,4,0,0,0.9,false,true,false,false,20],
    ["a3\structures_f_enoch\furniture\various\carpet_2_dz.p3d",1,2,0,0,0.2,false,true,false,false,30],
    ["Land_TableBig_01_F",1,3,0,0,0,false,true,false,false,30],
    ["Land_WoodenCrate_01_F",1,2,90,-0.5,0,true,false,false,false,30],
    ["Land_WoodenCrate_01_stack_x3_F",1,2,90,0,0,false,true,true,false,30],
    ["Land_WoodenCrate_01_stack_x5_F",1,2,0,0,0,false,true,true,false,30]
];

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
		playSound3D [if (damage _x > 0.1) then {getMissionPath "off.ogg"} else {getMissionPath "on.ogg"}, _x, false, getPosASL _x, 5, random 2 max 0.5 min 2, _distance];		
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

tsp_fnc_pause_heal = {
	params ["_unit"];
	if (!isNil "ACE_medical_fnc_treatmentAdvanced_fullHeal") then {[_unit, _unit] call ACE_medical_fnc_treatmentAdvanced_fullHeal};
	if (!isNil "ACE_medical_treatment_fullHealLocal") then {[_unit, _unit] call ACE_medical_treatment_fullHealLocal};
	if (!isNil "ace_medical_treatment_fnc_fullHeal") then {[_unit, _unit] call ace_medical_treatment_fnc_fullHeal};
	_unit setDamage 0;
};

tsp_fnc_action_sleep = {
    params [["_anim", true]]; sleep 0.2; findDisplay 46 createDisplay "RscDisplayAttributesModuleSkiptime";
    waitUntil {isNull (uiNamespace getVariable "RscDisplayAttributesModuleSkiptime")}; _dayTime = dayTime; sleep 3; 
    if (_anim && abs (_dayTime - dayTime) > 1) then {[player, "Acts_UnconsciousStandUp_part1"] remoteExec ["switchMove", 0]};
};

tsp_fnc_action_hold = {
	params ["_object", "_title", "_icon", "_code", ["_condition", "true"], ["_once", false], ["_duration", 0.2], ["_args", []], ["_priority", 10]];
	[_object, _title, _icon, _icon, _condition + " && _this distance _target < 6", _condition, {}, {}, _code, {}, _args, _duration, _priority, _once, false] call BIS_fnc_holdActionAdd;
};

tsp_fnc_action = {  //-- Changes for public release in here
	params ["_object", "_type", ["_conditon", "true"], ["_params", []]];	
	if (_type == "Physics") then {if (isServer) then {_pos = "Land_HelipadEmpty_F" createVehicle position _object; _pos attachto [_object, [0, 0, 0]]; detach _pos; _object attachTo [_pos]; _object allowdamage false}};
	if (_type == "Heal") then {[_object, "Heal", "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_revive_ca", {[player] call tsp_fnc_pause_heal}] call tsp_fnc_action_hold};
	if (_type == "Spectate") then {[_object, "Spectate", "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_forceRespawn_ca.paa", {[true] call tsp_fnc_spectate}, "tsp_param_spectate != 'Disabled'"] call tsp_fnc_action_hold};
	if (_type == "Teleport") then {[_object, "Teleport", "\a3\ui_f_oldman\data\IGUI\Cfg\holdactions\map_ca.paa", {titleCut ["", "BLACK OUT", 0.5]; sleep 0.5; [false] spawn tsp_fnc_spawn_map}] call tsp_fnc_action_hold};
	if (_type == "Role") then {[_object, "Select Role", "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_requestLeadership_ca.paa", {[] spawn tsp_fnc_role}, "tsp_param_role"] call tsp_fnc_action_hold};
	if (_type == "Arsenal") then {
		[_object, "Arsenal", "\a3\missions_f_oldman\data\img\holdactions\holdAction_box_ca.paa", {["Open", [true]] call BIS_fnc_arsenal}] call tsp_fnc_action_hold;
		[_object, "Arsenal (ACE)", "\a3\missions_f_oldman\data\img\holdactions\holdAction_box_ca.paa", {[player, player, true] call ace_arsenal_fnc_openBox}, "!isNil 'ace_arsenal_fnc_openBox'"] call tsp_fnc_action_hold;
	};
	if (_type == "Weather") then {[_object, "Weather", "hold_weather.paa", {[] spawn {sleep 0.2; findDisplay 46 createDisplay "RscDisplayAttributesModuleWeather"}}, "true"] call tsp_fnc_action_hold};
	if (_type == "Music") then {[_object, "Music", "hold_music.paa", {[] spawn {sleep 0.2; findDisplay 46 createDisplay "RscDisplayAttributesModuleMusic"}}, "true"] call tsp_fnc_action_hold};
	if (_type == "Sleep") then {
		[
			_object, "Sleep", "\a3\ui_f_oldman\data\IGUI\Cfg\holdactions\holdAction_sleep2_ca.paa", {[] spawn tsp_fnc_action_sleep}, 
			"{([[_x] call BIS_fnc_getRespawnPositions, _x] call BIS_fnc_nearestPosition) distance _x > 50} count allPlayers > 0"
		] call tsp_fnc_action_hold;
	};	
	if (_type == "Garage") then {[_object, "Garage", "\a3\data_f_destroyer\data\UI\IGUI\Cfg\holdactions\holdAction_loadVehicle_ca.paa", {_this#3 spawn tsp_fnc_action_garage}, _conditon, false, 1, _params] call tsp_fnc_action_hold};
};

tsp_fnc_replace = {
    params ["_base", "_class", ["_model", ""], ["_scale", 1], ["_obj", _this#0], ["_hide", true]]; if (canSuspend) then {sleep 1};
    if (isClass (configFile >> "CfgVehicles" >> _class)) then {_obj = createVehicle [_class, getPosASL _base, [], 0, "CAN_COLLIDE"]; _base hideObjectGlobal _hide}; 
    if (_model != "") then {_obj = createSimpleObject [_model, getPosASL _base, true]};
    _obj setPosASL (getPosASL _base); _obj setObjectScale _scale;
    _obj setVectorDirAndUp [vectorDir _base, vectorUp _base];
    _obj
};

if (true) exitWith {};  //-- Notes below

//-- O&T Trees
    //-- APPLE
    _obj = createSimpleObject ["\a3\vegetation_f_enoch\Tree\t_malusDomestica_2s.p3d", getPosASL this, true];  
    _obj setVectorDirAndUp [vectorDir this, vectorUp this]; _obj setPosASL (getPosASL this); hideObject this;

    //-- APPLE BIG
    _obj = createSimpleObject ["\a3\vegetation_f_enoch\Tree\t_malusDomestica_3s.p3d", getPosASL this, true];  
    _obj setVectorDirAndUp [vectorDir this, vectorUp this]; _obj setPosASL (getPosASL this); hideObject this;

    //-- BIRCH FALLEN
    _obj = createSimpleObject ["\a3\vegetation_f_enoch\Tree\D_Betula_pendula_stem.p3d", getPosASL this, true];  
    _obj setVectorDirAndUp [vectorDir this, vectorUp this]; _obj setPosASL (getPosASL this); hideObject this;

    //-- PINUS
    _obj = createSimpleObject ["\a3\vegetation_f_enoch\Tree\t_PinusSylvestris_3d.p3d", getPosASL this, true];  
    _obj setVectorDirAndUp [vectorDir this, vectorUp this]; _obj setPosASL (getPosASL this); hideObject this;

    //-- BIRCH
    _obj = createSimpleObject ["\a3\vegetation_f_enoch\Tree\T_Betula_pendula_2f.p3d", getPosASL this, true];  
    _obj setVectorDirAndUp [vectorDir this, vectorUp this]; _obj setPosASL (getPosASL this); hideObject this;

    //-- MAPLE
    _obj = createSimpleObject ["\a3\vegetation_f_enoch\Tree\t_acer2s.p3d", getPosASL this, true];  
    _obj setVectorDirAndUp [vectorDir this, vectorUp this]; _obj setPosASL (getPosASL this); hideObject this;

    //-- PEAR
    _obj = createSimpleObject ["\a3\vegetation_f_enoch\Tree\t_pyrusCommunis_3s.p3d", getPosASL this, true];  
    _obj setVectorDirAndUp [vectorDir this, vectorUp this]; _obj setPosASL (getPosASL this); hideObject this;

    //-- SPRUCE
    _obj = createSimpleObject ["\a3\vegetation_f_enoch\Tree\t_PiceaAbies_1f.p3d", getPosASL this, true];  
    _obj setVectorDirAndUp [vectorDir this, vectorUp this]; _obj setPosASL (getPosASL this); hideObject this;

    //-- SPRUCE BIG
    _obj = createSimpleObject ["\a3\vegetation_f_enoch\Tree\t_PiceaAbies_3s.p3d", getPosASL this, true];  
    _obj setVectorDirAndUp [vectorDir this, vectorUp this]; _obj setPosASL (getPosASL this); hideObject this;

    //-- SPRICE LOW
    _obj = createSimpleObject ["\a3\vegetation_f_enoch\Tree\t_piceaabies_2d.p3d", getPosASL this, true];  
    _obj setVectorDirAndUp [vectorDir this, vectorUp this]; _obj setPosASL (getPosASL this); hideObject this;

    //-- SPRUCE MEDIUM
    _obj = createSimpleObject ["\a3\vegetation_f_enoch\Tree\t_PiceaAbies_2f.p3d", getPosASL this, true];  
    _obj setVectorDirAndUp [vectorDir this, vectorUp this]; _obj setPosASL (getPosASL this); hideObject this;

    //-- SPRUCE TALL
    _obj = createSimpleObject ["\a3\vegetation_f_enoch\Tree\t_piceaabies_3d.p3d", getPosASL this, true];  
    _obj setVectorDirAndUp [vectorDir this, vectorUp this]; _obj setPosASL (getPosASL this); hideObject this;

    //-- SPRUCE FALLEN
    _obj = createSimpleObject ["\a3\vegetation_f_enoch\Tree\D_Picea_stem2.p3d", getPosASL this, true];  
    _obj setVectorDirAndUp [vectorDir this, vectorUp this]; _obj setPosASL (getPosASL this); hideObject this;

    //-- SPRUCE STUMP
    _obj = createSimpleObject ["\a3\vegetation_f_enoch\Tree\t_stub_picea.p3d", getPosASL this, true];  
    _obj setVectorDirAndUp [vectorDir this, vectorUp this]; _obj setPosASL (getPosASL this); hideObject this;

    //-- SPRUCE V1
    _obj = createSimpleObject ["\a3\vegetation_f_enoch\Tree\t_PiceaAbies_2s.p3d", getPosASL this, true];  
    _obj setVectorDirAndUp [vectorDir this, vectorUp this]; _obj setPosASL (getPosASL this); hideObject this;

    //-- SPRUCE V2
    _obj = createSimpleObject ["\a3\vegetation_f_enoch\Tree\t_PiceaAbies_2sb.p3d", getPosASL this, true];  
    _obj setVectorDirAndUp [vectorDir this, vectorUp this]; _obj setPosASL (getPosASL this); hideObject this;

//-- O&T P3DS
    _obj = createSimpleObject ["\A3\Structures_F\Training\Shoot_House_Panels_F.p3d", getPosASL this, true]; _obj setDir (getDir this); _obj setObjectScale 0.5; 
    _obj setObjectTexture [0,"\a3\missions_f_beta\data\img\decals\decal_kneel3_ca.paa"]; hideObject this;
    
    /*
    "\A3\structures_f_enoch\furniture\decoration\lekarnicka\lekarnicka.p3d"
    "\A3\structures_f_enoch\furniture\various\workbench_DZ.p3d"
    "\A3\weapons_f\Ammoboxes\Proxy_UsBasicAmmoBoxBig.p3d"
    "\A3\weapons_f\Ammoboxes\Proxy_UsBasicAmmoBoxSmall.p3d"
    "\A3\structures_f_enoch\furniture\school_equipment\long_bench.p3d"
    "a3\Props_F_Decade\Military\Decorative\BattlefieldCross_01_F.p3d"
    "a3\Props_F_Decade\Military\Decorative\BattlefieldCross_01_F.p3d"
    "\A3\armor_f_tank\AFV_Wheeled_01\M2.p3d"
    "\A3\armor_f_gamma\APC_Wheeled_03\data\m240_Vehicle.p3d"
    "\A3\structures_f\data\DoorLocks\lock_8.p3d"
    "\A3\structures_f_enoch\furniture\Cases\locker\locker_closed_v1.p3d"
    "\A3\structures_f_enoch\furniture\Cases\locker\locker_open_v1.p3d"
    "\A3\soft_f\Offroad_01\Backpacks_F.p3d"
    "\A3\structures_f_enoch\furniture\school_equipment\wall_hanger.p3d"
    "\A3\structures_f_enoch\furniture\various\Workbench.p3d"
    "\A3\structures_f_enoch\furniture\various\workbench_DZ.p3d"

    "\a3\vegetation_f_enoch\Tree\T_Betula_pendula_2f.p3d"
    "\a3\vegetation_f_enoch\Tree\t_acer2s.p3d"
    "\a3\vegetation_f_enoch\Tree\t_pyrusCommunis_3s.p3d"
    "\a3\vegetation_f_enoch\Tree\t_PiceaAbies_1f.p3d"
    "\a3\vegetation_f_enoch\Tree\t_PiceaAbies_3s.p3d"
    "\a3\vegetation_f_enoch\Tree\t_PiceaAbies_1s.p3d"
    "\a3\vegetation_f_enoch\Tree\t_stub_picea.p3d"
    "\a3\vegetation_f_enoch\Tree\t_piceaabies_2d.p3d"
    "\a3\vegetation_f_enoch\Tree\t_PiceaAbies_2f.p3d"
    "\a3\vegetation_f_enoch\Tree\t_piceaabies_3d.p3d"
    "\a3\vegetation_f_enoch\Tree\t_PiceaAbies_2s.p3d"
    "\a3\vegetation_f_enoch\Tree\t_PiceaAbies_2sb.p3d"

    "\A3\Structures_F_Exp\Civilian\Accessories\ConcreteBlock_01_F.p3d"
    "\a3\roads_f\runway\runway_main_f.p3d"
    "\A3\Structures_F_EXP\Infrastructure\Runways\Runway_01_30m_F.p3d"
    "\A3\Roads_F\Roads_New\city_w10_l9.p3d"
    "\A3\Roads_F\Roads_New\highway_w14_a0_152_r5000.p3d"
    "\A3\Roads_F\Roads_New\highway_w14_l14_term.p3d"
    */
