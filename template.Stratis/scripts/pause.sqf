["tsp_cba_core_pause", "CHECKBOX", "Enable Pause Menu", "Enables pause menu.", "TSP Core", tsp_mission] call tsp_fnc_setting;

tsp_fnc_pause_zeus = {
	params ["_unit"];
	_zoos = (createGroup sideLogic) createUnit ["ModuleCurator_F", [0,0,0], [], 0, "NONE"]; 
	{_zoos addCuratorEditableObjects [_x, true]} forEach [allUnits, vehicles];
	_zoos addCuratorPoints 1; _unit assignCurator _zoos;
};

tsp_fnc_pause_view = {  //-- Replaces continue button with view distance button
	_viewDistanceButton = (findDisplay 49) displayCtrl 2; _viewDistanceButton ctrlSetText "View Distance";
	_viewDistanceButton ctrlAddEventHandler ["buttonClick", {call CHVD_fnc_openDialog}];
};

tsp_fnc_pause_leave = {
	_leaveSpectateButton = (findDisplay 49) displayctrl 122; _leaveSpectateButton ctrlSetText "Leave Spectate"; 
	_leaveSpectateButton ctrlSetTooltip "If spectating is set to Dynamic, this button will allow you to exit the spectator screen.";
	if (tsp_param_spectate == "Forced") exitWith {_leaveSpectateButton ctrlEnable false};  //-- If forced, no leaving
	_leaveSpectateButton ctrlAddEventHandler ["buttonClick", {[false] spawn tsp_fnc_spectate; if (tsp_param_spawn) then {[] spawn tsp_fnc_spawn_map}}]; 
};

tsp_fnc_pause_teleport = {
	params ["_unit", "_to", ["_cursor", false]];
	[false] remoteExec ["tsp_fnc_spectate", _unit];  //-- Leave spectate
	if (vehicle _unit != _unit) then {moveOut _unit; sleep 1};       //-- Dismount
	if (_cursor) exitWith {_unit setpos screenToWorld [0.5, 0.5]};  //-- If cursor - do it and exit
	if (vehicle _to != _to) then {_unit moveInAny vehicle _to};    //-- Teleport into vehicle
	_unit attachTo [_to, [0, 0, 0]]; _unit setVelocity [0,0,0]; detach _unit;  //-- Attach, prevent fall damage, detach
};

tsp_fnc_pause_admin = {
	_title = (findDisplay 49) ctrlCreate ["RscText", 9998]; _title ctrlSetPosition [(safezoneX + safeZoneW - 0.55 * 3 / 4) - 0.025, safezoneY + 0.05, 0.4, 0.042];			
	_title ctrlSetFont "PuristaMedium"; _title ctrlSetText "ADMIN MENU"; _title ctrlSetBackgroundColor [11/100,50/100,20/100,0.9]; _title ctrlCommit 0;	

	_actions = (findDisplay 49) ctrlCreate ["RscCombo", 9999]; _actions ctrlSetPosition [(safezoneX + safeZoneW - 0.55 * 3 / 4) - 0.025, safezoneY + 0.1, 0.4, 0.045];
	{_actions lbSetData [_actions lbAdd format [_x#0], str (_x#1)]} forEach [
		["Heal", {{[_x] remoteExec ["tsp_fnc_heal", _x]; "You have been healed" remoteExec ["systemChat", _x]} forEach _this}],
		["Wake", {{[_x] remoteExec ["tsp_fnc_wake", _x]} forEach _this}],
		["Kill", {{_x setDamage 1} forEach _this}],
		["Teleport: Cursor", {{[_x, player, true] spawn tsp_fnc_pause_teleport} forEach _this}],
		["Teleport: Me", {{[_x, player] spawn tsp_fnc_pause_teleport} forEach _this}],
		["Teleport: To", {{[player, _x] spawn tsp_fnc_pause_teleport} forEach _this}],
		["Give Admin", {{[_x, "COLONEL"] remoteExec ["setRank", 0]; "You are now an Admin!" remoteExec ["systemChat", _x]} forEach _this}],
		["Give Zeus", {{[_x] remoteExec ["tsp_fnc_pause_zeus", 2]; "You are now a Zeus!" remoteExec ["systemChat", _x]} forEach _this}]
	]; 
	if (!isNil "tsp_actionSelected") then {_actions lbSetCurSel tsp_actionSelected#0}; _actions ctrlCommit 0;
	_actions ctrlAddEventHandler ["LBSelChanged", {params ["_control", "_selectedIndex"]; tsp_actionSelected = [_selectedIndex, _control lbData (lbCurSel _control)]}];
	
	_tree = (findDisplay 49) ctrlCreate ["tsp_treeview", -1]; _tree ctrlSetPosition [(safezoneX + safeZoneW - 0.55 * 3 / 4) - 0.025, safezoneY + 0.15,0.4,0.945];
	_tree ctrlSetBackgroundColor [0,0,0,0.7]; _tree ctrlCommit 0;
	{  //-- Add groups and players to tree
		_group = _tree tvAdd [[], groupId _x];  //-- Add group
		{  //-- For all players in group
			_unit = _tree tvAdd [[_group], name _x]; _tree tvSetData [[_group, _unit], [_x] call BIS_fnc_objectVar];  //-- Add player under his group and set data to player variable (for MP)
			if (lifeState _x == "UNCONSCIOUS" || _x getVariable ["ACE_isUnconscious", false]) then {_tree tvSetColor [[_group, _unit], [0.9,0.7,0.1,1]]};  //-- Change colour if uncon
			if (isObjectHidden _x || !alive _x) then {_tree tvSetColor [[_group, _unit], [1,0,0,1]]};  //-- Change colour if dead
		} forEach (units _x);
	} forEach (allGroups select {count (units _x select {isPlayer _x}) > 0});
	tvExpandAll _tree;  //-- So all the groups are opened by default
	_tree ctrlAddEventHandler ["TreeSelChanged", {params ["_control"]; tsp_playersSelected = []; {tsp_playersSelected pushBack (call compile (_control tvData _x))} forEach tvSelection _control}];

	_run = (findDisplay 49) ctrlCreate ["RscButtonMenu", 9998]; _run ctrlSetPosition [(safezoneX + safeZoneW - 0.55 * 3 / 4) - 0.025, safezoneY + 1.1, 0.4, 0.045];			
	_run ctrlSetText "RUN"; _run ctrlSetFont "PuristaLight"; _run ctrlCommit 0;
	_run ctrlAddEventHandler ["buttonClick", {tsp_playersSelected spawn (call compile (tsp_actionSelected#1))}];

	_butter = (findDisplay 49) ctrlCreate ["RscButtonMenu", 9998]; _butter ctrlSetPosition [(safezoneX + safeZoneW - 0.55 * 3 / 4) - 0.025, safezoneY + 1.15, 0.4, 0.041];			
	_butter ctrlSetText "BUTTER"; _butter ctrlSetFont "PuristaLight"; _butter ctrlCommit 0;
	_butter ctrlAddEventHandler ["buttonClick", {[] spawn tsp_fnc_butter}];

	_options = (findDisplay 49) ctrlCreate ["RscButtonMenu", 9998]; _options ctrlSetPosition [(safezoneX + safeZoneW - 0.55 * 3 / 4) - 0.025, safezoneY + 1.195, 0.4, 0.041];			
	_options ctrlSetText "OPTIONS"; _options ctrlSetFont "PuristaLight"; _options ctrlCommit 0;
	_options ctrlAddEventHandler ["buttonClick", {findDisplay 49 spawn cba_settings_fnc_openSettingsMenu}];
	if (isNil "cba_settings_fnc_openSettingsMenu") then {_options ctrlEnable false};
};

tsp_fnc_pause_sector = {
	_title = (findDisplay 49) ctrlCreate ["RscText", 9998]; _title ctrlSetPosition [(safezoneX + safeZoneW - 0.93 * 3 / 4) - 0.025, safezoneY + 0.05, 0.27, 0.042];       
	_title ctrlSetFont "PuristaMedium"; _title ctrlSetText "SECTOR MENU"; _title ctrlSetBackgroundColor [11/100,50/100,20/100,0.9]; _title ctrlCommit 0;     
	
	_tree = (findDisplay 49) ctrlCreate ["tsp_treeview", -1]; _tree ctrlSetPosition [(safezoneX + safeZoneW - 0.93 * 3 / 4) - 0.025, safezoneY + 0.1,0.27,1.09];    
	_tree ctrlSetBackgroundColor [0,0,0,0.7]; _tree ctrlCommit 0;    
	{  //-- Add sectors to tree   
		_x params ["_layer", "_state"];    
		_sector = _tree tvAdd [[], _layer];    
		_tree tvSetData [[_sector], str _layer];   
		_tree tvSetColor [[_sector], if (_state) then {[0,1,0,1]} else {[1,0,0,1]}];   
	} forEach (missionNameSpace getVariable ["tsp_sector_info", []]);    
	_tree ctrlAddEventHandler ["TreeSelChanged", {params ["_control"]; tsp_sectorsSelected = []; {tsp_sectorsSelected pushBack (call compile (_control tvData _x))} forEach tvSelection _control}];   
	
	_load = (findDisplay 49) ctrlCreate ["RscButtonMenu",9998]; _load ctrlSetPosition [(safezoneX + safeZoneW - 0.93 * 3 / 4) - 0.025, safezoneY + 1.195, 0.133, 0.044];    
	_load ctrlSetText "LOAD"; _load ctrlSetFont "PuristaLight"; _load ctrlCommit 0;    
	_load ctrlAddEventHandler ["buttonClick", {{[_x, true] remoteExec ["tsp_fnc_sector_load", 2]} forEach tsp_sectorsSelected}];    
	
	_save = (findDisplay 49) ctrlCreate ["RscButtonMenu",9998]; _save ctrlSetPosition [(safezoneX + safeZoneW - 0.93 * 3 / 4) +0.113, safezoneY + 1.195, 0.133, 0.044];       
	_save ctrlSetText "UNLOAD"; _save ctrlSetFont "PuristaLight"; _save ctrlCommit 0;    
	_save ctrlAddEventHandler ["buttonClick", {{[_x] remoteExec ["tsp_fnc_sector_save", 2]} forEach tsp_sectorsSelected}];    
};

while {tsp_cba_core_pause} do {  //-- Add interface when escape menu is opened
	waitUntil {!isNull (findDisplay 49)};  //-- Wait for pause screen to open
	call tsp_fnc_pause_view;  //-- View distance button
	if (!isNil "BIS_EGSpectatorCamera_camera") then {((findDisplay 49) displayCtrl 1010) ctrlEnable false};  //-- Disable respawn button
	if (!isNil "BIS_EGSpectatorCamera_camera" && !isNil "tsp_param_spectate") then {call tsp_fnc_pause_leave};  //-- Leave spectate button
	if (isServer || serverCommandAvailable "#kick" || rank player == "COLONEL") then {call tsp_fnc_pause_admin; call tsp_fnc_pause_sector} 
	else {(findDisplay 49 displayctrl 13184) ctrlShow false};  //-- If not admin, hide original debug console
	waitUntil {isNull (findDisplay 49)};  //-- Wait for pause screen to close
};