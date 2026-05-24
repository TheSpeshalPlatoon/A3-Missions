[] spawn {	
    while {true} do {
        waitUntil {!isNull (findDisplay 49)};  //-- Wait until ESC menu is open

		//-- View Distance Button
		_viewDistance = (findDisplay 49) displayCtrl 2;
		_viewDistance ctrlRemoveAllEventHandlers "buttonClick";
		_viewDistance ctrlSetText "View Distance";
		_viewDistance ctrlAddEventHandler ["buttonClick", {call CHVDAddon_fnc_openDialog}];

		//-- Spectator Stuff
		if (tsp_currentlySpectating) then {
			//-- Leave Spectate Button	
			_leaveSpectate = (finddisplay 49) displayctrl 122; 
			_leaveSpectate ctrlRemoveAllEventHandlers "buttonClick";
			_leaveSpectate ctrlSetText "Leave Spectate";
			_leaveSpectate ctrlAddEventHandler ["buttonClick", {[] spawn {[true] call tsp_fnc_spectate_close}}]; 
			_leaveSpectate ctrlSetTooltip "If spectating is set to Dynamic, this button will allow you to exit the spectator screen.";
        	if (tsp_param_spectate == "Forced") then {_leaveSpectate ctrlEnable false};

			//-- Toggle Camera Button
			_toggleCamera = (findDisplay 49) displayCtrl 103;
			_toggleCamera ctrlRemoveAllEventHandlers "buttonClick";
			_toggleCamera ctrlSetText "Toggle Spectator Camera";
			_toggleCamera ctrlEnable true;
			_toggleCamera ctrlAddEventHandler ["buttonClick", {
				[] spawn {
					titleCut ["", "BLACK OUT", 0.25];
					sleep 0.25;
					if (isNil "Buttered") then {						
						campos = getpos(["GetCamera"] call BIS_fnc_EGSpectatorCamera);
						["Terminate"] call BIS_fnc_EGSpectator;
						sleep 0.1;
						["Start", campos] call tsp_fnc_butter;
					} else {
						campos = getpos butter_camera;
						["Terminate"] call tsp_fnc_butter;
						sleep 0.1;
						["Initialize", [player, [], false, true, true, true, true, true, true, true]] call BIS_fnc_EGSpectator;  
						(["GetCamera"] call BIS_fnc_EGSpectatorCamera) setPos campos; 
					};
					titleCut ["", "BLACK IN", 0.25];
				};
			}];			

		};
		
		//-- Admin Stuff		
		if (!serverCommandAvailable "#kick") then {(finddisplay 49 displayctrl 13184) ctrlShow false};  //-- Hide original debug console

		_cond1 = (rank player == "COLONEL");
		_cond2 = (serverCommandAvailable "#kick");
		_cond3 = (!isNull getAssignedCuratorLogic player);
		_cond4 = (getPlayerUID player in ["76561198078356498"]);
        if ( _cond1 || _cond2 || _cond3 || _cond4 ) then {	
			//-- Title
				_adminTitle = (findDisplay 49) ctrlCreate ["RscText", 9998];
				_adminTitle ctrlSetPosition [safezoneX + 0.028, safezoneY + 0.040, 0.45, 0.042];			
				_adminTitle ctrlSetFont "PuristaMedium";
				_adminTitle ctrlSetText "ADMIN PANEL";
				_adminTitle ctrlSetBackgroundColor [11/100,50/100,20/100,0.9];  
				_adminTitle ctrlCommit 0;				

			//-- Player Combobox (Returns "tsp_playerSelected")
				_playerList = (findDisplay 49) ctrlCreate ["RscCombo", 10000];
				_playerList ctrlSetPosition [safezoneX + 0.028, safezoneY + 0.09, 0.45, 0.045];
				_playerList ctrlCommit 0;

				//-- Add "All Players" entry to combobox
				_index = _playerList lbAdd "All Players"; 
				_playerList lbSetData [_index, "allplayers"]; 

				//-- Add all the actual players to combobox				
				{
					_index = _playerList lbAdd format ["%1 (%2)",name _x,groupid group _x];
					if (_x distance [0,0,0] < 5) then {_playerList lbSetColor [_index,[1,0,0,1]]};
					_playerList lbSetData [_index, [_x] call BIS_fnc_objectVar];
				} forEach allplayers;

				//-- Eventhandler to determine which person selected
				_playerList ctrlAddEventHandler ["LBSelChanged", {
					params ["_control", "_selectedIndex"];
					tsp_playerSelected = [call compile (_control lbData (lbCurSel _control))];  //-- Get current selected player data
					//-- If current selected player data is "allplayers", that means that "All Players" entry is selected
					if (_control lbData (lbCurSel _control) == "allplayers") then {  
						tsp_playerSelected = allplayers;
					};
				}];

			//-- Action Combobox (Returns "tsp_actionSelected")
				_actionList = (findDisplay 49) ctrlCreate ["RscCombo", 9999];
				_actionList ctrlSetPosition [safezoneX + 0.028, safezoneY + 0.14, 0.45, 0.045];
				_actionList ctrlCommit 0;

				//-- Add actions to combobox
				{
					_index = _actionList lbAdd format [_x];
					_actionList lbSetData [_index,_x];
				} forEach [
					"Heal", 
					"Kill",
					"Teleport: Cursor", 
					"Teleport: Me",
					"Teleport: Map", 
					"Spectate: Force", 
					"Spectate: Release", 
					"Gear Checking: Enable", 
					"Gear Checking: Disable", 
					"Crew Checking: Enable", 
					"Crew Checking: Disable",
					"Loadouts: Retain",
					"Loadouts: Original",
					"Give Admin",
					"Give Zeus"
				];

				//-- Eventhandler to determine which action is selected
				_actionList ctrlAddEventHandler ["LBSelChanged", {
					params ["_control", "_selectedIndex"];
					tsp_actionSelected = _control lbData (lbCurSel _control);
				}];

			//-- Run Button
				_run = (findDisplay 49) ctrlCreate ["RscButtonMenu",9998];
				_run ctrlSetPosition [safezoneX + 0.028, safezoneY + 0.19, 0.45, 0.045];
				_run ctrlCommit 0;
				_run ctrlSetText "RUN";
				_run ctrlSetFont "PuristaLight";
				_run ctrlAddEventHandler ["buttonClick", {    
					switch (tsp_actionSelected) do {
						//-- Player display names (Used in the messageLog)
						playerSelectedDisplayNames = [];
						{
							playerSelectedDisplayNames = playerSelectedDisplayNames + [name _x];
						} forEach tsp_playerSelected;
						if (count playerSelectedDisplayNames > 1) then {playerSelectedDisplayNames = "All Players"};

						case "Heal": {{[_x, _x] call ACE_medical_fnc_treatmentAdvanced_fullHealLocal} forEach tsp_playerSelected};

						case "Kill": {{_x setdamage 1} forEach tsp_playerSelected};

						case "Teleport: Cursor": {
							{
								[[false], "tsp_fnc_spectate_close", _x] call BIS_fnc_MP;
								_x setpos screenToWorld [0.5, 0.5];
							} forEach tsp_playerSelected;
						};

						case  "Teleport: Me": {
							{
								[[false], "tsp_fnc_spectate_close", _x] call BIS_fnc_MP;
								_x attachTo [player, [0, 0, 0] ];detach _x;
							} forEach tsp_playerSelected;
						};

						case "Teleport: Map": {
							findDisplay 49 closeDisplay 1;  //-- Close ESC menu    
							openMap [true, true];  //-- Force open map
							onMapSingleClick {
								onMapSingleClick {};
								openMap [false, false];
								{
									[[false], "tsp_fnc_spectate_close", _x] call BIS_fnc_MP;
									_x setpos _pos;
								} forEach tsp_playerSelected;								
							};
						};

						case "Spectate: Force": {
							{[[], "tsp_fnc_spectate_open", _x] call BIS_fnc_MP} forEach tsp_playerSelected; 
							(uinamespace getVariable "messageLog") ctrlSetText format["Players put into Spectate: %1",playerSelectedDisplayNames]; //-- Admin Message
						};

						case "Spectate: Release": {
							{[[true], "tsp_fnc_spectate_close", _x] call BIS_fnc_MP} forEach tsp_playerSelected; 							
							(uinamespace getVariable "messageLog") ctrlSetText format["Players Released: %1",playerSelectedDisplayNames]; //-- Admin Message
						};

						case "Gear Checking: Enable": {
							{
								[{
									tsp_param_gear = "Enabled";
									systemchat "Gear Checking: Enabled."
								},"call",_x] call BIS_fnc_MP;
							} forEach tsp_playerSelected;
							if (count tsp_playerSelected > 1) then {publicVariable "tsp_param_gear"};  //-- JIP if set to all players
							(uinamespace getVariable "messageLog") ctrlSetText format["Gear Checking Enabled for: %1",playerSelectedDisplayNames]; //-- Admin Message
						};

						case "Gear Checking: Disable": {
							{
								[{
									tsp_param_gear = "Disabled";
									systemchat "Gear Checking: Disabled."
								},"call",_x] call BIS_fnc_MP;
							} forEach tsp_playerSelected;
							if (count tsp_playerSelected > 1) then {publicVariable "tsp_param_gear"};  //-- JIP if set to all players
							(uinamespace getVariable "messageLog") ctrlSetText format["Gear Checking Disabled for: %1",playerSelectedDisplayNames]; //-- Admin Message
						};

						case "Crew Checking: Enable": {
							{
								[{
									tsp_param_crew = "Enabled";
									systemchat "Crew Checking: Enabled."
								},"call",_x] call BIS_fnc_MP;
							} forEach tsp_playerSelected;
							if (count tsp_playerSelected > 1) then {publicVariable "tsp_param_crew"};  //-- JIP if set to all players
							(uinamespace getVariable "messageLog") ctrlSetText format["Crew Checking Enabled for: %1",playerSelectedDisplayNames]; //-- Admin Message
						};

						case "Crew Checking: Disable": {
							{
								[{
									tsp_param_crew = "Disabled";
									systemchat "Crew Checking: Disabled."
								},"call",_x] call BIS_fnc_MP;
							} forEach tsp_playerSelected;
							if (count tsp_playerSelected > 1) then {publicVariable "tsp_param_crew"};  //-- JIP if set to all players
							(uinamespace getVariable "messageLog") ctrlSetText format["Crew Checking Disabled for: %1",playerSelectedDisplayNames]; //-- Admin Message
						};

						case "Loadouts: Retain": {
							{
								[{
									tsp_param_loadout = "Retain";
									systemchat "Loadouts: Retained."
								},"call",_x] call BIS_fnc_MP;
							} forEach tsp_playerSelected;
							if (count tsp_playerSelected > 1) then {publicVariable "tsp_param_loadout"};  //-- JIP if set to all players
							(uinamespace getVariable "messageLog") ctrlSetText format["Loadouts Retained for: %1",playerSelectedDisplayNames]; //-- Admin Message
						};

						case "Loadouts: Original": {
							{
								[{
									tsp_param_loadout = "Original";
									systemchat "Loadouts: Original."
								},"call",_x] call BIS_fnc_MP;
							} forEach tsp_playerSelected;
							if (count tsp_playerSelected > 1) then {publicVariable "tsp_param_loadout"};  //-- JIP if set to all players
							(uinamespace getVariable "messageLog") ctrlSetText format["Loadouts Original for: %1",playerSelectedDisplayNames]; //-- Admin Message  
						};

						case "Give Admin": {		
							if (count tsp_playerSelected == 1) then {	
								{
									[{
										player setRank "COLONEL";
										systemchat "You are now Admin!"
									},"call",_x] call BIS_fnc_MP;
								} forEach tsp_playerSelected;
								(uinamespace getVariable "messageLog") ctrlSetText format["Promoted to Admin: %1",playerSelectedDisplayNames]; //-- Admin Message  
							};    
						};

						case "Give Zeus": {
							if (count tsp_playerSelected == 1) then {	
								{[_x] remoteExec ["tsp_fnc_give_zeus",2]} forEach tsp_playerSelected; 
								{[["You have Zeus!"],"systemchat",_x] call BIS_fnc_MP} forEach tsp_playerSelected; 						
								(uinamespace getVariable "messageLog") ctrlSetText format["Promoted to Zeus: %1",playerSelectedDisplayNames]; //-- Admin Message
							};    
						};
					};
				}]; 

			//-- Toggle Spectate Button
				_toggleSpectate = (findDisplay 49) ctrlCreate ["RscButtonMenu",9998];
				_toggleSpectate ctrlSetPosition [safezoneX + 0.028, safezoneY + 0.24, 0.45, 0.041];
				_toggleSpectate ctrlSetText "TOGGLE SPECTATE MODE";
				_toggleSpectate ctrlSetFont "PuristaLight";
				_toggleSpectate ctrlCommit 0;
				_toggleSpectate ctrlAddEventHandler ["buttonClick", {
					switch (tsp_param_spectate) do {
						case "Disabled": {tsp_param_spectate = "Dynamic"};
						case "Dynamic": {tsp_param_spectate = "Forced"};
						case "Forced": {tsp_param_spectate = "Disabled"};
					};
					publicvariable "tsp_param_spectate";  //-- JIP 
					(format ["Spectating is %1!",tsp_param_spectate]) remoteExec ["systemchat", 0]; 
					(uinamespace getVariable "messageLog") ctrlSetText format["Spectating is: %1",tsp_param_spectate];      
				}];

			//-- Debug Console Button
				_console = (findDisplay 49) ctrlCreate ["RscButtonMenu",9998];
				_console ctrlSetPosition [safezoneX + 0.028, safezoneY + 0.285, 0.45, 0.041];
				_console ctrlCommit 0;
				_console ctrlSetText "CONSOLE";
				_console ctrlSetFont "PuristaLight";
				_console ctrlAddEventHandler ["buttonClick", {createDialog "RscDisplayDebugPublic"}];

			//-- Message Log
				_messageLog = (findDisplay 49) ctrlCreate ["RscText",9998];
				_messageLog ctrlSetPosition [safezoneX + 0.028, safezoneY + 0.32, 0.85, 0.1];
				_messageLog ctrlCommit 0;
				_messageLog ctrlSetFont "PuristaMedium";	
				uiNameSpace setVariable ["messageLog", _messageLog];	
		};

		waitUntil{isNull (findDisplay 49)};	 //-- Wait until ESC menu is closed		
	};
};