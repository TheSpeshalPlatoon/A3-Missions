["tsp_param_role", "CHECKBOX", "Role Selection", "", ["TSP Core", "Mission"], true] call tsp_fnc_setting;
["tsp_param_roleStart", "CHECKBOX", "Role Selection on Start", "", ["TSP Core", "Mission"], true] call tsp_fnc_setting;
["tsp_param_roleCheck", "CHECKBOX", "Role Gear Checking", "", ["TSP Core", "Mission"], false] call tsp_fnc_setting;

tsp_fnc_role = {
	params [["_force", false], ["_roles", missionNameSpace getVariable ["tsp_roles", getMissionConfigValue "tsp_roles"]], ["_display", findDisplay 46 createDisplay "RscDisplayEmpty"]];
	if (_force && count _roles > 0) then {_display displayAddEventHandler ["KeyDown", {_this#1 == 1 && !(_this#3)}]; titleCut ["", "BLACK OUT", 0.01]};  //-- Prevent ESC

	_title = _display ctrlCreate ["RscText", 9998]; _w = 0.6; _h = 0.042; _y = 0.6; _title ctrlSetPosition [(1.0-_w)*0.5,((1.0-_h)*0.5)-_y,_w,_h];
	_title ctrlSetFont "PuristaMedium"; _title ctrlSetText "ROLE SELECTION"; _title ctrlSetBackgroundColor [11/100,50/100,20/100,0.9]; _title ctrlCommit 0;	
	
	_box = _display ctrlCreate ["RscText", 9998]; _w = 0.6; _h = 0.1; _y = 0.525; _box ctrlSetPosition [(1.0-_w)*0.5,((1.0-_h)*0.5)-_y,_w,_h];
	_box ctrlSetBackgroundColor [0,0,0,0.7]; _box ctrlCommit 0;
	
	tsp_role_roles = []; tsp_role_trees = []; tsp_role_pictures = []; _offset = 0.33;
	{  //-- Create tree, picture and invisible button for each faction, hide all but the first
		_x params ["_name", "_icon", "_side", "_children"]; if (playerSide != call compile _side) then {continue}; _offset = _offset - 0.075;

		_tree = _display ctrlCreate ["tsp_treeview", 9998]; _w = 0.6; _h = 1.05; _y = -0.053; _tree ctrlSetPosition [(1.0-_w)*0.5,((1.0-_h)*0.5)-_y,_w,_h];
		_tree ctrlSetBackgroundColor [0,0,0,0.7]; if (_forEachIndex != 0) then {_tree ctrlShow false}; _tree ctrlCommit 0; tsp_role_trees pushBack _tree;
		
		_picture = _display ctrlCreate ["RscPicture", -1]; _w = 0.051; _h = 0.07; _y = 0.525; _picture ctrlSetPosition [((1.0-_w)*0.5)-_offset,((1.0-_h)*0.5)-_y,_w,_h];
		_picture ctrlSetText _icon; if (_forEachIndex != 0) then {_picture ctrlSetFade 0.5}; _picture ctrlCommit 0; tsp_role_pictures pushBack _picture;

		_button = _display ctrlCreate ["tsp_invisible", 9998]; _w = 0.061; _h = 0.08; _y = 0.525; _button ctrlSetPosition [((1.0-_w)*0.5)-_offset,((1.0-_h)*0.5)-_y,_w,_h];
		_button ctrlSetBackgroundColor [0,0,0,0]; _button ctrlSetTooltip _name; _button ctrlCommit 0; _button setVariable ["tree", _tree]; _button setVariable ["picture", _picture];
		_button ctrlAddEventHandler ["buttonClick", {
			params ["_control", ["_tree", _this#0 getVariable "tree"], ["_picture", _this#0 getVariable "picture"]]; 
			{_x ctrlSetFade 0.5; _x ctrlCommit 0} forEach tsp_role_pictures; _picture ctrlSetFade 0; _picture ctrlCommit 0;  //-- Picture opacity
			{_x ctrlShow false; _x tvSetCurSel [-1]} forEach tsp_role_trees; _tree ctrlShow true;                           //-- Hide/show trees
		}];

		{[_tree, _x] call tsp_fnc_role_recursive} forEach _children; tvExpandAll _tree;  //-- Populate the tree
	} forEach _roles;

	_button = _display ctrlCreate ["RscButtonMenu", 9998]; _w = 0.6; _h = 0.042; _y = -0.602; _button ctrlSetPosition [(1.0-_w)*0.5,((1.0-_h)*0.5)-_y,_w,_h];
	_button ctrlSetText "CONTINUE"; _button ctrlSetFont "PuristaLight"; _button ctrlEnable false; _button ctrlCommit 0;
	_button setVariable ["display", _display]; _button ctrlAddEventHandler ["buttonClick", {params ["_control"]; _control getVariable "display" closeDisplay 1}];

	while {_display isNotEqualTo displayNull} do {{_x call tsp_fnc_role_poll} forEach tsp_role_roles; if (missionNameSpace getVariable ["role", ""] != "") then {_button ctrlEnable true}};
	if (_force) then {titleCut ["", "BLACK IN", 3]};
};

tsp_fnc_role_recursive = {
	params ["_tree", "_item", ["_parent", []], ["_parentName", ""], ["_index", 0]];
	if (count _item == 3) then {  //-- If item is a category
		_item params ["_name", "_icon", "_children"];
		_branch = _tree tvAdd [_parent, _name]; _tree tvSetPicture [_parent+[_branch], if ("marker" in _icon) then {"\A3\ui_f\data\map\"+_icon} else {_icon}]; 
		if ("marker" in _icon) then {_tree tvSetPictureColor [_parent+[_branch], [playerSide] call BIS_fnc_sideColor]};
		{[_tree, _x, _parent+[_branch], _name, _forEachIndex] call tsp_fnc_role_recursive} forEach _children;
	} else {  //-- If item is a role
		_item params ["_name", "_loadout", "_arsenal", "_icon", ["_uid", (_parentName+(_item#0)+(str count tsp_role_roles)) regexReplace [" ",""]]]; 
		if (_index == 0) then {tsp_role_leader = _uid};  //-- Make first unit leader
		_leaf = _tree tvAdd [_parent, _name]; _tree tvSetPicture [_parent+[_leaf], "\A3\ui_f\data\map\vehicleicons\"+_icon];
		tsp_role_roles pushBack [_tree, _parent+[_leaf], _name, _loadout, _arsenal, _uid, tsp_role_leader, _parentName];
	};
};

tsp_fnc_role_poll = {  //-- Select role if available and selected, also poll stuff
	params ["_tree", "_leaf", "_name", "_loadout", "_arsenal", "_roleId", "_leadId", "_parentName"];
	if (tvCurSel _tree isEqualTo _leaf && [_roleId, _leadId] call tsp_fnc_role_available) then {  //-- If selected and available
		missionNameSpace setVariable [missionNameSpace getVariable ["role", "doesntmatterwhatshere"], nil, true];
		missionNameSpace setVariable [_roleId, player, true]; missionNameSpace setVariable ["role", _roleId];
		[player, _loadout, true] spawn tsp_fnc_faction; tsp_arsenal = [player, _arsenal] call tsp_fnc_role_arsenal;
		_groups = allGroups select {groupId _x == _parentName};
		if (count _groups > 0) exitWith {[player] join (_groups#0); ["AddGroupMember", [_groups#0, player]] remoteExec ["BIS_fnc_dynamicGroups", 0]};	
		_group = createGroup [playerSide, true]; _group setGroupId [_parentName]; [player] join _group;
		["RegisterGroup", [_group, leader _group, [nil, _parentName, false]]] remoteExec ["BIS_fnc_dynamicGroups", 0];
	};
	_tree tvSetText [_leaf, _name+(if ([_roleId, _roleId] call tsp_fnc_role_available) then {""} else {" ["+name(missionNameSpace getVariable _roleId)+"]"})];  //-- If occupied
	_tree tvSetColor [_leaf, [1,1,1, if ([_roleId, _leadId] call tsp_fnc_role_available) then {1} else {0.5}]];  //-- Opacity based on availability
};

tsp_fnc_role_available = {  //-- Check if fole is available
	params ["_roleId", "_leadId", ["_occupant", missionNameSpace getVariable [_this#0, objNull]], ["_leader", missionNameSpace getVariable [_this#1, objNull]]];
	if (_roleId != _leadId && !(_leader in (allPlayers+playableUnits))) exitWith {false};  //-- No leader
	if (_occupant in (allPlayers+playableUnits)) exitWith {false};  //-- Occupied
	true
};

tsp_fnc_role_arsenal = {  //-- [player, ["soc_raider","west_leader","myGun"]] call tsp_fnc_role_arsenal;
	params ["_unit", ["_data", []], ["_data1", []], ["_data2", []], ["_data3", []]]; if (!local _unit) exitWith {};   //-- _data1, _data2 and _data3 - poor man's recursion
	{if ("ACE" in _x) then {_data3 pushBack _x; continue}; _data1 = _data1+(missionNameSpace getVariable [_x, getMissionConfigValue [_x, [_x]]])} forEach _data;    //-- If _x is variable/config, get data, else just add the item [_x]
	{if ("ACE" in _x) then {_data3 pushBack _x; continue}; _data2 = _data2+(missionNameSpace getVariable [_x, getMissionConfigValue [_x, [_x]]])} forEach _data1;  //-- If _x is variable/config, get data, else just add the item [_x]
	{if ("ACE" in _x) then {_data3 pushBack _x; continue}; _data3 = _data3+(missionNameSpace getVariable [_x, getMissionConfigValue [_x, [_x]]])} forEach _data2; //-- If _x is variable/config, get data, else just add the item [_x]
	flatten _data3;
};

tsp_fnc_role_check = {  //-- Gear restriction
	params ["_unit", ["_distance", 50], ["_arsenal", missionNameSpace getVariable ["tsp_arsenal", []]]];
	if (hmd _unit != "" && [headgear _unit] call tsp_fnc_hitpoint_armor < 5) then {(createVehicle ["GroundWeaponHolder_Scripted", getPos _unit]) addItemCargoGlobal [hmd _unit, 1]; _unit unlinkItem hmd _unit; systemchat "You dropped your NVG."};
	if !(((primaryWeaponItems _unit)#2) in _arsenal) then {_unit removePrimaryWeaponItem ((primaryWeaponItems _unit)#2); systemchat "Removed Attachment."};  //-- Scopes
	if !(uniform _unit in _arsenal) then {removeUniform _unit; systemchat "Removed Uniform."};  //-- Uniform			
	if !(vest _unit in _arsenal) then {removeVest _unit; systemchat "Removed Vest."};          //-- Vest
	if (([[_unit] call BIS_fnc_getRespawnPositions, _unit] call BIS_fnc_nearestPosition) distance _unit > _distance) then {continue};
	if !(hmd _unit in _arsenal) then {_unit unassignItem (hmd _unit); _unit removeItem (hmd _unit); systemchat "Removed NVG."};   //-- NVGs			
	if !(primaryWeapon _unit in _arsenal) then {_unit removeWeapon (primaryWeapon _unit); systemchat "Removed Weapon."};         //-- Weapon		
	if !(secondaryWeapon _unit in _arsenal) then {_unit removeWeapon (secondaryWeapon _unit); systemchat "Removed Launcher."};  //-- Rocket
	if !(handgunWeapon _unit in _arsenal) then {_unit removeWeapon (handgunWeapon _unit); systemchat "Removed Pistol."};       //-- Pistol		
	if !(binocular _unit in _arsenal) then {_unit removeweapon (binocular _unit); systemchat "Removed Binoculars."};          //-- Binoculars
	if !(headgear _unit in _arsenal) then {removeHeadgear _unit; systemchat "Removed Headgear."};                            //-- Headgear
	if !(goggles _unit in _arsenal) then {removeGoggles _unit; systemchat "Removed Facewear."};                             //-- Facewear	
	if !(backpack _unit in _arsenal) then {removeBackpack _unit; systemchat "Removed Restricted Backpack."};               //-- Backpack	
};

tsp_fnc_role_vehicle = {  //-- Vehicle restriction
	params ["_vehicle", ["_condition", {true}]]; _vehicle setVariable ["role_condition", _condition];
	_vehicle addEventHandler ["GetIn", {
		params ["_vehicle", "_role", "_unit", "_turret"];
		if (_role != "driver" || (_unit call (_vehicle getVariable "role_condition"))) exitWith {};
		moveOut _x; "You are not allowed to operate this vehicle." remoteExec ["systemChat", _unit];
	}];
};

waitUntil {!isNull (findDisplay 46) && time > 5};
player addEventHandler ["Take", {params ["_unit"]; if (tsp_param_roleCheck) then {[_unit] call tsp_fnc_role_check}}];
[missionNamespace, "arsenalClosed", {if (tsp_param_roleCheck) then {[_unit] call tsp_fnc_role_check}}] call BIS_fnc_addScriptedEventHandler;
if (isServer) then {["Initialize", [true]] call BIS_fnc_dynamicGroups};
if (hasInterface) then {["InitializePlayer", [player, true]] call BIS_fnc_dynamicGroups};