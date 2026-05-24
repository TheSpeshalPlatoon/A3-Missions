//-- Handle scroll actions on interactable objects
params ["_object","_type"];

fn_HoldAction = {
	[
        _this select 0,                                                                      // Object the action is attached to
        _this select 1,                                                                     // Title of the action
        _this select 2,                                                                    // Idle icon shown on screen
        _this select 2,                                                                   // Progress icon shown on screen
        "_this distance _target < 6",                                                    // Condition for the action to be shown
        [_this select 3, ";_this distance _target < 6"] joinString "",                   // Condition for the action to progress
        {},                                                                            // Code executed when action starts 
        {},                                                                           // Code executed on every progress tick
        _this select 4,                                                              // Code executed on completion
        {},                                                                         // Code executed on interrupted
        [],                                                                        // Arguments passed to the scripts as _this select 3
        0.2,                                                                      // Action duration [s]
        1,                                                                       // Priority
        false,                                                                  // Remove on Completion
        false                                                                  // Show on Window
    ] call BIS_fnc_holdActionAdd;
};

switch (_type) do {
	case "Spectate": {
		[
			_object, 
			"Spectate", 
			"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_forceRespawn_ca.paa", 
			"tsp_param_spectate == 'Dynamic'", 
			{call tsp_fnc_spectate_open}
		] call fn_HoldAction;
	};
	case "Teleport": {
		[
			_object, 
			"Teleport", 
			"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_takeOff1_ca.paa", 
			"", 
			{titleCut ["", "BLACK OUT", 0.5];sleep 0.5;call tsp_fnc_map_open}
		] call fn_HoldAction;
	};
	case "ResetLoadout": {
		[
			_object, 
			"Reset Loadout",
			"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_passLeadership_ca.paa", 
			"", 
			{player setUnitLoadout (missionNamespace getVariable ["Original_Loadout",[]])}
		] call fn_HoldAction;
	};
	case "Arsenal": {
		if (isNil "tsp_arsenals") then {tsp_arsenals = []};
		tsp_arsenals = tsp_arsenals + [_object];
		
		[_object, "Arsenal", "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_requestLeadership_ca.paa", "", {
			[_object, tsp_allowedstuff_arsenal, false] call BIS_fnc_addVirtualWeaponCargo;
			[_object, tsp_allowedstuff_arsenal, false] call BIS_fnc_addVirtualMagazineCargo;
			[_object, tsp_allowedstuff_arsenal, false] call BIS_fnc_addVirtualItemCargo;
			[_object, tsp_allowedstuff_arsenal, false] call BIS_fnc_addVirtualBackpackCargo;		
			["Open", false] spawn BIS_fnc_arsenal;
		}] call fn_HoldAction;
	};
	case "Arsenal_HUD": {
		if (isNil "tsp_arsenals_disabled") then {tsp_arsenals_disabled = []};
		tsp_arsenals_disabled = tsp_arsenals_disabled + [_object];

		[missionnamespace, "arsenalOpened", {
			disableSerialization;
			{
				if ((player distance _x) < 5) then {
					_display = _this select 0;
					_display displayAddEventHandler ["keydown", "_this select 3"];
					{(_display displayCtrl _x) ctrlShow false} forEach [44151, 44150, 44146, 44147, 44148, 44149, 44346];
				};
			} forEach tsp_arsenals_disabled;       
		}] call BIS_fnc_addScriptedEventHandler;
	};
	case "Heal": {
		[
			_object, 
			"Heal", 
			"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_revive_ca.paa", 
			"", 
			{
				titleCut ["", "BLACK OUT", 0.2];
				sleep 0.25;
				[player, player] call ACE_medical_fnc_treatmentAdvanced_fullHealLocal;
				titleCut ["", "BLACK IN", 0.2];
			}
		] call fn_HoldAction;
	};
	case "Physics": {
		if (isDedicated) then { 
			_pos = "Land_HelipadEmpty_F" createVehicle position _object;
			_pos allowdamage false;
			_pos attachto [_object, [0,0,0]];
			detach _pos;
			_object attachTo [_pos]; 
			_object allowdamage false;
		};
	};
};