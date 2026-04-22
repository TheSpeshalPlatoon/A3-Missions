// Player, Zombie Types, Triggers, Zombie Side, Condition, Code, Distance, Max Zombie Count, Interval, Despawn Distance
[player, [
"tsp_tka_teamlead",
"tsp_tka_medic",
"tsp_tka_grenadier",
"tsp_tka_autorifleman",
"tsp_tka_antitank",
"tsp_tka_rifleman",
"tsp_tka_rifleman_akm",
"tsp_tka_rifleman_lite"
], [zone_zombie], east, {true}, {}, 200, 4, 30, 400] spawn tsp_fnc_zombience;

//-- Bomb Script from TFB
tfb_debug = false;
tfb_fnc_defuse_add = {
	_bomb = _this;
	_action = _bomb addAction ["Begin Defusal", {
		params ["_target", "_caller", "_actionId", "_arguments"];
		TFB_active_defusal = _target;
		createDialog "BadgerDefuse";
	}, nil, 6, true, true, "", "true", 2.5];
	_bomb setVariable ["TFB_BombAction", _action];
};
tfb_fnc_defuse_blackbox = {ace_minedetector_detectableClasses setVariable ["Land_BatteryPack_01_battery_black_F", true]};
tfb_fnc_defuse_bombbeep = {
	_bomb = _this select 0;
	_arr = _bomb getVariable ["TFB_BombTime", [false , 0]];
	_arr params ["_armed", "_time"];
	if (_armed) then {
		if (_time < 0) exitWith {[_bomb] call TFB_fnc_defuse_detonate};
		_nextTime = ((_time * 0.05) min 3 max 0.2);
		_time = _time - _nextTime;
		_bomb setVariable ["TFB_BombTime", [_armed, _time], true];
		_vol = 1 - (1 min (_time / 30));
		playSound3D ["\A3\Sounds_F\arsenal\Tools\MineDetector_Beep_01.wss", _bomb, false, getPosASL _bomb, 2 + (3 * _vol), 1 + (0.5 * _vol), 75 + (50 * _vol)];
		[{[_this] call TFB_fnc_defuse_bombBeep}, _bomb, _nextTime] call CBA_fnc_waitAndExecute;
	} else {
		if (_time > 0) then {
			playSound3D ["\A3\Sounds_F\arsenal\Tools\MineDetector_Beep_01.wss", _bomb, false, getPosASL _bomb, 2, 1, 75];
			[{[_this] call TFB_fnc_defuse_bombBeep}, _bomb, 5] call CBA_fnc_waitAndExecute;
		};
	};
};
tfb_fnc_defuse_bombdialog = {
	_displayOrControl = findDisplay 6700;
	_colorArrays = TFB_active_defusal getVariable "TFB_BombColors";
	_colorArrays params ["_bomb_wires", "_correctTypes", "_correctInputs", "_display_outputs", "_code", "_ammo", "_mode_sequence", "_current_input"];
	{  // set up colors of wires
		if (_x != "BLANK") then {
			_imageTxt = "fx\" + "wire_" + (toLower  _x) + ".paa";
			ctrlSetText [(100 + (_bomb_wires find _x) + 1), _imageTxt];
		} else {
			ctrlSetText [(100 + (_bomb_wires find _x) + 1), ""];
		};
	} foreach _bomb_wires;
	_keypadText = _displayOrControl displayCtrl 100;
	if !(isNil {_display_outputs select 0}) then {[_display_outputs select 0] spawn TFB_fnc_defuse_updateKeypad};
	TFB_BombPage = 0;
	TFB_BombPageScroll = [0,0,0,0];
	[true, true] spawn TFB_fnc_defuse_updateClipboard;
};
tfb_fnc_defuse_cutwire = {
	_displayOrControl = _this select 0;
	_slot = (_this select 1) - 1;
	_control = _this select 2;
	_colorArrays = TFB_active_defusal getVariable "TFB_BombColors";
	_colorArrays params ["_bomb_wires", "_correctTypes", "_correctInputs", "_display_outputs", "_code", "_ammo", "_mode_sequence", "_current_input"];
	if (isNil "_bomb_wires") exitWith {[TFB_active_defusal] call TFB_fnc_defuse_detonate};
	_color = _bomb_wires select _slot;
	if (count _correctInputs == 0) exitWith {systemchat "All inputs cleared, disarmed."};  // exit if no other instructions to clear (means disarmed)	
	if (_color find "cut" != -1) exitWith {systemchat "Wire already cut."};  // exit if wire already cut 	
	if (_color == "BLANK") exitWith {systemchat "No wire to cut."};  // exit if cut an empty wire	
	if (_color != (_correctInputs select 0)) exitWith {[TFB_active_defusal] call TFB_fnc_defuse_detonate};  // exit if cut a wrong wire	
	_imageTxt = "fx\" + "wire_cut_" + (toLower _color) + ".paa"; ctrlSetText [_displayOrControl, _imageTxt];  // set new cut wire image	
	_correctInputs deleteAt 0; _display_outputs deleteAt 0;	_correctTypes deleteAt 0; _bomb_wires set [_slot, ("cut_" + _color)];  // update bomb
	TFB_active_defusal setVariable ["TFB_BombColors", [_bomb_wires, _correctTypes, _correctInputs, _display_outputs, _code, _ammo, _mode_sequence, _current_input], true];
	playsound "WeaponRestedOn";
	if (count _correctInputs == 0) then {  // exit if no other colors to cut
		["DISARMED!"] call TFB_fnc_defuse_updateKeypad;		
		[{playSound3D ["\A3\Sounds_F\arsenal\Tools\MineDetector_Beep_01.wss", player];}, nil, 0.1] call CBA_fnc_waitAndExecute;
		[{playSound3D ["\A3\Sounds_F\arsenal\Tools\MineDetector_Beep_01.wss", player];}, nil, 0.2] call CBA_fnc_waitAndExecute;
		[{playSound3D ["\A3\Sounds_F\arsenal\Tools\MineDetector_Beep_01.wss", player];}, nil, 0.3] call CBA_fnc_waitAndExecute;
		private _bomb_defused = TFB_active_defusal;
		_bomb_defused remoteExec ["TFB_fnc_defuse_remove", 0, true];
		_bomb_defused setVariable ["TFB_BombColors", nil, true];
		_bomb_defused setVariable ["TFB_BombTime", [false , 0], true];
	} else {
		if (isNil {_display_outputs select 0}) then {["          "] call TFB_fnc_defuse_updateKeypad} else {[_display_outputs select 0] call TFB_fnc_defuse_updateKeypad};
	};
};
tfb_fnc_defuse_detonate = {
	_bomb = _this select 0;
	_colorArrays = _bomb getVariable "TFB_BombColors";
	if !(isNil "_colorArrays") then {if (count (_colorArrays select 0) < 1) exitWith {}};
	closeDialog 2;
	deleteVehicle _bomb;
	_munition = "Bomb_03_F" createVehicle (_bomb modelToWorld [0,0,0]);
	triggerAmmo _munition;
};
tfb_fnc_defuse_dialog = {
	params ["_areaUnderCursor", "_unitUnderCursor"];
	if (isPlayer _unitUnderCursor) exitWith { [objNull, "Cannot spawn on a player."] call bis_fnc_showCuratorFeedbackMessage};
	if (isNull _unitUnderCursor) exitWith { [objNull, "Must be placed on an object."] call bis_fnc_showCuratorFeedbackMessage};
	[
		"Bomb Defusal",
		[
			["COMBO", "Number of Instructions", [[3, 6, 9, 12, 15, 18, 21, 24], [], 3]],
			["COMBO", "Bomb Size", [["GrenadeHand","R_80mm_HE","Bomb_03_F"],[["Grenade","","",[1,1,1,1]], ["Mortar","","",[1,1,1,1]], ["GBU","","",[1,1,1,1]]],0]],
			["EDIT", "Defuse Code (Max 10 Digits)", [""]]
		],
		{
			params ["_output1", "_output2"];
			_output1 params ["_difficulty","_ammo","_code"];
			_output2 params ["_areaUnderCursor", "_unitUnderCursor"];			
			// come up with a disarm code or cut down codes that are too long
			if (_code == "") then {_code = str round random 999999} else {if (count _code > 10) then {_code = _code select [0, 10]}};			
			[_unitUnderCursor, _difficulty, _ammo, _code] spawn TFB_fnc_defuse_generateBomb;			
			[objNull, format ["Object set as bomb. Defusal code: %1", _code]] call bis_fnc_showCuratorFeedbackMessage;
		},
		{},
		[_areaUnderCursor,_unitUnderCursor]
	] call zen_dialog_fnc_create;
};
tfb_fnc_defuse_generatebomb = {
	params ["_bomb", "_instNo", "_ammo", "_code"];

	// set up starting variables
	_serial = (str round (random 99999) + str round (random 99999));
	_last_valid = [nil, nil, nil];
	_time = 60;
	_timePerArg = 15;
	_timePerComplex = 0;
	_instructions = [];
	_correctInputs = [];
	_correctTypes = [];
	_display_outputs = []; //used for showing outputs on display when required, checked each correct step

	//set up to 20% of instructions as false instructions
	_instFalse = 0 max (round (_instNo * ((random 0) / 100))); //all true for now
	_instTrue = _instNo - _instFalse;
	_instBoolOrder = [];

	//randomly distribute false instructions into list [true, false, true]
	for "_i" from 1 to _instTrue do {_instBoolOrder pushBack true};
	for "_i" from 1 to _instFalse do {_instBoolOrder pushBack false};
	_instBoolOrder = _instBoolOrder call BIS_fnc_arrayShuffle;

	//create types of instructions for number of instructions needed:
	//1 = wire, 2 = button, 3 = keypad
	_instType = [selectRandom [1,2,3]];
	if (_instNo > 1) then {
		for "_i" from 2 to _instNo do {
			switch (_instType select -1) do {
				case 1: {_instType pushBack (selectRandom [3,2,1])};
				case 2: {_instType pushBack (selectRandom [1,3])};
				case 3: {_instType pushBack (selectRandom [1,2])};
			};
		};
	};

	//set up wires (required wires + up to 4 random wires)
	_wireNum = 8 min (({_x == 1} count _instType) + (ceil random 3));
	_color_available = ["RED", "GREEN", "YELLOW", "BLUE", "WHITE", "BLACK", "PURPLE", "ORANGE"];
	_color_remaining = [] + _color_available;
	_color_original = [];
	_color_order = [];

	for "_i" from 1 to _wireNum do {
		_arraySize = count _color_remaining; 
		_randomIndex = round (random (_arraySize - 1));
		_color_original pushBack (_color_remaining select _randomIndex); 
		_color_remaining deleteAt _randomIndex;
	};

	//generate wire breakdown
	_color_unused = [] + _color_remaining; // shift remaining colors over to excluded
	_color_remaining = [] + _color_original;
	_color_cut = [];

	// create bomb wire array
	_color_temp = [] + _color_original;
	_bomb_wires = [];
	_bomb_wire_slots = 8;
	while {count _bomb_wires < _bomb_wire_slots} do {
		if (random 1 > 0.5) then {
			if (_bomb_wire_slots - (count _bomb_wires) > count _color_temp) then { _bomb_wires pushback "BLANK";};
		} else {
			if (count _color_temp > 0) then {
				_bomb_wires pushback (_color_temp select 0);
				_color_temp deleteAt 0;
			};
		};
	};

	//generate bomb maker name
	_maker = selectRandom [
		"Ashton",
		"Aeriyn",
		"KingOfWar117",
		"Jayhawk",
		"Campo",
		"sernwei01",
		"Sin_Puay_Loo",
		"ASUS",
		"BigBear",
		"chickin",
		"Salty",
		"GasChamber",
		"Bronze",
		"A-san",
		"Noodle",
		"NocturnalEagle",
		"Prorune117",
		"Davidddd",
		"NIGEL",
		"Artyom",
		"Viper",
		"PlantShooter",
		"Des506",
		"Fusion",
		"Rish",
		"Nico",
		"cra"
	];

	//generate mode breakdown
	_mode_en = [
		"DISARM",
		"ENTRY",
		"INPUT",
		"SECURITY",
		"SEQUENCE",
		"OVERRIDE",
		"ACTIVATE",
		"CAUTION",
		"TRIGGER",
		"FORMULA",
		"PASSWORD",
		"KEYCODE",
		"CONTROL",
		"TIMER",
		"HAZARD",
		"CIRCUIT",
		"LOCKED"
	];

	//Swedish
	_mode_se = [
		"AVVAPNA",
		"INTRADE",
		"INMATNING",
		"SAKERHET",
		"SEKVENS",
		"ASIDOSATTA",
		"AKTIVERA",
		"VARNING",
		"TRIGGER",
		"FORMEL",
		"LOSENORD",
		"NYCKEL",
		"KONTROLL",
		"TIMER",
		"FARA",
		"KRETS",
		"LASTAD"
	];

	//German
	_mode_de = [
		"ENTWAFFNEN",
		"EINTRAG",
		"EINGANG",
		"SICHERHEIT",
		"ABFOLGE",
		"AUFHEBEN",
		"AKTIVIEREN",
		"WARNUNG",
		"AUSLOSEN",
		"FORMEL",
		"PASSWORT",
		"SCHLUSSEL",
		"KONTROLLE",
		"ZEITMESSER",
		"GEFAHR",
		"SCHALTUNG",
		"GESPERRT"
	];

	//Dutch
	_mode_nl = [
		"ONTWAPEN",
		"TOEGANG",
		"VOER",
		"BEVEILIGD",
		"REEKS",
		"TEGANBEVEL",
		"ACTIVEREN",
		"LET OP",
		"TREKKER",
		"FORMULE",
		"WACHTWOORD",
		"CIJFERCODE",
		"CONTROLE",
		"TIMER",
		"GEVAAR",
		"CIRCUIT",
		"OP SLOT"
	];

	//French
	_mode_fr = [
		"DESARMER",
		"ENTREE",
		"SAISIR",
		"SECURITE",
		"SEQUENCE",
		"SUPPLANTER",
		"ACTIVER",
		"PRUDENCE",
		"GACHETTE",
		"FORMULE",
		"MOTDEPASSE",
		"CLE",
		"CONTROLE",
		"MINUTEUR",
		"DANGER",
		"CIRCUIT",
		"FERMEACLE"
	];

	//Filipino
	_mode_ph = [
		"DISARMAHAN",
		"PUMASOK",
		"INPUTAN",
		"SEGURIDAD",
		"KASUNOD",
		"OVERRIDE",
		"ACTIVATE",
		"MAG-INGAT",
		"ARMAHAN",
		"FORMULA",
		"PASSWORD",
		"KEYCODE",
		"KONTROL",
		"ORAS",
		"PANGANIB",
		"SIRKITO",
		"NAKALOCK"
	];

	_mode_translation = selectRandom [_mode_en, _mode_se, _mode_de, _mode_nl, _mode_fr, _mode_ph];
	_mode_sequence = _mode_translation call BIS_fnc_arrayShuffle;
	_mode_sequence resize [(6 + round random 8), ""];

	//array to lookup number strings
	_numToStr = ["first", "second", "third", "fourth", "fifth", "sixth", "seventh", "eighth"];

	//vars to check what the previous type of instructions were
	_usedVerWire = [];
	_usedVerMode = [];
	_usedVerKey = [];

	//begin populating instructions
	for "_i" from 1 to (count _instType) do {
		_index = _i - 1;
		_typeSelected = _instType select _index;
		_inst = "";
		_display_output = "nil";
		_input = _code;
		
		//get whether it is a true/false instruction
		_bool = _instBoolOrder select _index; _bool = true;
		
		//decide if it is a 'complex' instruction. False instructions are always complex.
		_complex = ((random 100 > 50) OR !(_bool)); _complex = false;
		
		//wire instructions
		if (_typeSelected == 1) then {
			
			//select a random type of instruction (reselect if more than 1 wire required)
			private _sel = [1,2,3,4,5,6,7];
			_sel = _sel - _usedVerWire;
			if (count _sel < 1) then {
				_sel = [1,2,3,4,5,6,7];
				_usedVerWire = [];
			};
			private _instVersion = selectRandom _sel;
			if ((_bool) AND (count _color_remaining == 1)) then {_instVersion = 1};
			_usedVerWire = _usedVerWire + [_instVersion];

			//set top level variables
			private _cutwire = "";
			
			_inst = switch (_instVersion) do {
				//Cut the X wire
				case 1: {
					_cutwire = selectRandom _color_remaining;
					
					format ["Cut the %1 wire", _cutwire]
				};
				
				//Cut the wire to the left/right of X
				case 2: {
					//decide if left (true) or right (false)
					private _side = selectRandom ["left", "right"];
					
					//new var to avoid affecting original array
					private _middleWires = [] + _color_remaining; 
					private _modwire = "";
					
					//select wire in the middle of the pack
					if (_side == "left") then {
						_middleWires deleteAt 0;
						_modwire = selectRandom _middleWires;
						_cutwire = _color_remaining select ((_color_remaining find _modwire) - 1);
					} else {
						_middleWires = _middleWires - [_middleWires select -1];
						_modwire = selectRandom _middleWires;
						_cutwire = _color_remaining select ((_color_remaining find _modwire) + 1);
					};
					//systemchat str [_color_remaining, _middleWires, _modwire, _cutwire];
					format ["Cut the first uncut wire to the %1 of %2", _side, _modwire]
				};
				
				//Cut the wire Y wires to the left/right of X
				case 3: {
				
					_cutwire = selectRandom _color_remaining;
					private _middleWires = _color_original - [_cutwire];
					_modwire = selectRandom _middleWires;
					//decide if left or right
					private _side = "";
					private _sideNum = 0;
					if ((_color_original find _modwire) > (_color_original find _cutwire)) then { 
						_side = "left"; 
						_sideNum = (_color_original find _modwire) - (_color_original find _cutwire) - 1; 
						} else { 
						_side = "right"; 
						_sideNum = (_color_original find _cutwire) - (_color_original find _modwire) - 1; 
					};
					
					format ["Cut the %3 wire to the %1 of %2", _side, _modwire, (_numToStr select (_sideNum))]
				};
				
				//Cut the leftmost/rightmost uncut wire
				case 4: {
					//decide if left or right
					private _side = selectRandom ["left", "right"];
					
					if (_side == "left") then {
						_cutwire = _color_remaining select 0;
					} else {
						_cutwire = _color_remaining select -1;
					};
					
					format ["Cut the %1most uncut wire", _side]
				};
				
				//Cut the X wire from the left/right
				case 5: {
					//decide if left or right
					private _side = selectRandom ["left", "right"];
					
					_cutwire = selectRandom _color_remaining;
					private _sideNum = 0;
					
					if (_side == "left") then {
						_sideNum = ((_color_original find _cutwire));
					} else {
						_sideNum = (((count _color_original) - (_color_original find _cutwire) - 1));
					};
					
					format ["Cut the %1 wire from the %2", (_numToStr select (_sideNum)), _side]
				};
				
				//Cut the X uncut wire from the left/right
				case 6: {
					//decide if left or right
					private _side = selectRandom ["left", "right"];
					
					_cutwire = selectRandom _color_remaining;
					private _sideNum = 0;
					
					if (_side == "left") then {
						_sideNum = ((_color_remaining find _cutwire));
					} else {
						_sideNum = (((count _color_remaining) - (_color_remaining find _cutwire)) - 1);
					};
					
					format ["Cut the %1 uncut wire from the %2", (_numToStr select (_sideNum)), _side]
				};
				
				//Cut the wire shown on the display
				case 7: {
					_cutwire = selectRandom _color_remaining;
					_display_output = _cutwire;
					
					"Cut the wire displayed on the display"
				};
				
				// Cut the wire left/right of the wire displayed
				case 8: {
					_cutwire = selectRandom _color_remaining;
					private _middleWires = _color_original - [_cutwire];
					_modwire = selectRandom _middleWires;
					//decide if left or right
					private _side = "";
					private _sideNum = 0;
					if ((_color_original find _modwire) > (_color_original find _cutwire)) then { 
						_side = "left"; 
						_sideNum = (_color_original find _modwire) - (_color_original find _cutwire) - 1; 
						} else { 
						_side = "right"; 
						_sideNum = (_color_original find _cutwire) - (_color_original find _modwire) - 1; 
					};
					
					_display_output = _modwire;
					
					format ["Cut the %3 wire to the %1 of the wire on the display", _side, (_numToStr select (_sideNum))]

				};
			};

			//update wire data if this is a real instruction
			if (_bool) then {
				_color_remaining = _color_remaining - [_cutwire];
				_color_cut pushBack _cutwire;
			};
			//systemchat str [_typeSelected, _instVersion, _cutwire];
			_input = _cutwire;
			
		};


		//mode instructions
		if (_typeSelected == 2) then {
			//select a random type of instruction
			private _sel = [1,2];
			if (count _sel < 1) then {
				_sel = [1,2];
				_usedVerMode = [];
			};
			private _instVersion = selectRandom _sel;
			_usedVerMode = _usedVerMode + [_instVersion];
			
			//set top level variables
			private _modeSelected = "";
			
			_inst = switch (_instVersion) do {
				//Press black button until mode X selected and press #
				case 1: {
					_modeSelected = selectRandom _mode_sequence;
					
					format ["Press the BLACK button until Mode: %1 is displayed and press #", (_mode_en select (_mode_translation find _modeSelected))];
				};
				
				//Press red button X times
				case 2: {
					private _num = ceil random 8;
					_modeSelected = [];
					_modeSelected resize [_num, "buttonRed"];
					
					format ["Press the RED button SLOWLY %1 times", _num];
				};
				
				//Press red button times shown on display
				case 3: {
					private _num = ceil random 8;
					_modeSelected = [];
					_modeSelected resize [_num, "buttonRed"];
					
					_display_output = str _num;
					
					format ["Press the RED button SLOWLY the number of times shown on the display", _num];
				};
				
				//Press red button number of cut wires
				case 4: {
					private _num = count _color_remaining;
					_modeSelected = [];
					_modeSelected resize [_num, "buttonRed"];
					
					format ["Press the RED button SLOWLY %1 times", _num];
				};
				
				//Press red button number of uncut wires
				case 5: {
					private _num = count _color_cut;
					_modeSelected = [];
					_modeSelected resize [_num, "buttonRed"];
					
					format ["Press the RED button SLOWLY %1 times", _num];
				};
				
				//Press button number the same number of times as the # digit of number
				
			};
			//systemchat str [_typeSelected, _instVersion, _modeSelected];
			_input = _modeSelected;
			
		};

		//key instructions
		if (_typeSelected == 3) then {
			//select a random type of instruction
			private _sel = [1,2,3,4,5,6,7,8];
			if (count _sel < 1) then {
				_sel = [1,2,3,4,5,6,7,8];
				_usedVerKey = [];
			};
			private _instVersion = selectRandom _sel;
			_usedVerKey = _usedVerKey + [_instVersion];

			//set top level variables
			private _keyInput = "";
			
			_inst = switch (_instVersion) do {
				//Key in the total number of wires on the bomb and press #
				case 1: {
					_keyInput = str count _color_original;
					"Input the number of wires total and press #"
				};
				
				//Key in number of cut wires and press #
				case 2: {
					_keyInput = str count _color_cut;
					"Input the number of currently cut wires and press #"
				};
				
				//Key in number of uncut wires and press #
				case 3: {
					_keyInput = str count _color_remaining;
					"Input the number of currently uncut wires and press #"
				};
				
				//Key in the numbers shown on the display and press #
				case 4: {
					private _digitCount = round random [2, 6, 10];
					private _num = "";
					for "i" from 1 to _digitCount do {
						_num = _num + (str floor (random 10));
					};
					_keyInput = _num;
					_display_output = _keyInput;
					"Input the full number sequence being displayed and press #"
				};
				
				//Key in first/last X numbers shown on the display and press #
				case 5: {
					// generate display number
					private _endNum = (round random [4, 7, 10] - 1);
					private _fullNum = (str round (random 99999) + str round (random 99999));
					_fullNum = _fullNum select [0, _endNum - 1];
					_display_output = _fullNum;
					
					//decide if left (true) or right (false)
					private _side = selectRandom ["left", "right"];
					
					private _midNum = (ceil random [1, (count _fullNum) * 0.5, count _fullNum]);
					private _side = selectRandom ["left", "right"];
					if (_side == "left") then {
						_keyInput = (_fullNum select [0, _midNum]);
					} else {
						_keyInput = (_fullNum select [(_endNum - _midNum - 1), _endNum]);
					};
					
					format ["Input the %1 %2most digits being displayed and press #", _midNum, _side];
				};
				
				//Key in all the numbers of the S/N and press #
				case 6: {
					_keyInput = _serial;
					
					"Input all digits of the bomb's serial number written on the notepad"
				};
				
				//Key in the first/last X numbers of S/N and press #
				case 7: {
					//decide if count from start or back of S/N
					private _side = selectRandom ["first", "last"];
					private _fullNum = _serial;
					private _digitCount = count _fullNum;
					private _digitNum = ceil random _digitCount;
					if (_side == "first") then {
						_keyInput = (_fullNum select [0, _digitNum]);
					} else {
						_keyInput = (_fullNum select [(_digitCount - _digitNum), (_digitCount - 1)]);
					};
					
					format ["Input the %2 %1 digits of the serial number written on the notepad and press #", _digitNum, _side];
				};
				
				//Key in the number of letters or digits on the display and press #
				case 8: {
					private _digitCount = round random [4, 7, 10];
					private _num = (str round (random 99999) + str round (random 99999));
					_num = _num select [0, _digitCount];
					_display_output = _num;
					_keyInput = str count _num;
					
					"Input the number of digits in the number sequence being displayed and press #"
				};
				
				// multiplication
				// addition
				
			};
			//systemchat str [_typeSelected, _instVersion, _keyInput];
			_input = _keyInput;
			
		};
		
		//todo: create complexity
		if (_complex) then {
			_inst = _inst + ", there are supposed to be extra instructions here but I haven't added them yet.";
		} else {
			_inst = _inst + ".";
		};
		
		//add instruction to the instruction array
		_instructions pushBack _inst;
		_instructions pushback "<br/>";
		_instructions pushback "<br/>";
		_time = _time + _timePerArg;
		
		//update button data if this is a real instruction
		if (_bool) then {
			//if input came in an array then just add the array directly
			if ((typeName _input) == "ARRAY") then {
				_correctInputs = _correctInputs + _input;
			} else {
				_correctInputs pushBack _input;
			};
			_correctTypes resize [count _correctInputs, _typeSelected];
			//overwrite any display currently for this index if it is correct
			_display_outputs resize (count _correctInputs);
			if (_display_output != "nil") then {
				_display_outputs set [(count _correctInputs - 1), _display_output];
			};
			//if first item in display list is nil, change to "ARMED"
			if ((count _display_outputs == 1) AND (_display_output == "nil")) then {_display_outputs set [0, "ARMED"]};
		} else {
			//only add display if last display is currently nil
			if ((_display_output != "nil") AND (isNil (_display_outputs select -1))) then {
				_display_outputs set [(count _correctInputs - 1), _display_output];
			};
		};	
	};

	// add addaction to bomb
	_bomb remoteExec ["TFB_fnc_defuse_add", 0, true];

	//export variables
	_bomb setVariable ["TFB_BombColors", [_bomb_wires, _correctTypes, _correctInputs, _display_outputs, _code, _ammo, _mode_sequence, ""], true];
	_bomb setVariable ["TFB_BombTime", [false, _time], true];
	_bomb setVariable ["TFB_BombInst", [_instructions, str _serial, _maker], true];
	[_bomb] call TFB_fnc_defuse_bombBeep;
};
tfb_fnc_defuse_inputkeypad = {
	_keyPressed = _this select 0;

	_colorArrays = TFB_active_defusal getVariable "TFB_BombColors";

	if (isNil "_colorArrays") exitWith {};

	_colorArrays params ["_bomb_wires", "_correctTypes", "_correctInputs", "_display_outputs", "_code", "_ammo", "_mode_sequence", "_current_input"];
	_notDisarmed = true;
	_defaultArr = ["ERROR", "CONFIRMED", "INCORRECT", "DISARMED!", "ARMED"] + _mode_sequence;

	//if reset button was pressed reset to blank if nothing being shown or back to hint if one exists
	if (_keyPressed == "reset") then {
		_current_input = "";
		_output = (_display_outputs select 0);
		if (isNil "_output") then {
			["          "] call TFB_fnc_defuse_updateKeypad;
		} else {
			[_output] call TFB_fnc_defuse_updateKeypad;
		};
	};

	//if buttonBlack is pressed
	if (_keyPressed == "buttonBlack") then {
		playsound "OMLightSwitch";
		playsound "OMLightSwitch";
		if (_current_input in _mode_sequence) then {
			//already toggling modes, set current input to next mode
			_currMode = _mode_sequence find _current_input;
			_nextMode = _currMode + 1;
			//go back to start if last mode is reached
			if (_current_input == _mode_sequence select -1) then {_nextMode = 0};
			_current_input = _mode_sequence select _nextMode;
		} else {
			//not yet started, set current input to first mode
			_current_input = _mode_sequence select 0;
		};
		//display current mode
		[_current_input] call TFB_fnc_defuse_updateKeypad;
	};

	//if buttonRed is pressed
	if (_keyPressed == "buttonRed") then {
		//if matches the next correct input
		playsound "OMLightSwitch";
		playsound "OMLightSwitch";
		//update bomb and display if correct, else explode
		if (_keyPressed == (_correctInputs select 0)) then {
			
			//update bomb
			_current_input = "";
			_correctInputs deleteAt 0;
			_display_outputs deleteAt 0;
			_correctTypes deleteAt 0;
			
			//update display
			if (count _correctInputs == 0) then {
				_notDisarmed = false;
			} else {
				if (isNil {_display_outputs select 0}) then {
					["          "] call TFB_fnc_defuse_updateKeypad;
				} else {
					[_display_outputs select 0] call TFB_fnc_defuse_updateKeypad;
				};
			};
		} else {[TFB_active_defusal] call TFB_fnc_defuse_detonate;};
	};

	//if enter button is pressed check what is being entered
	if (_keyPressed == "enter") then {

		switch (true) do {
			//if input entered matches disarm code
			case (_current_input == _code) : {
				_notDisarmed = false;
			};
			
			//if input entered matches next correct answer
			case (_current_input == (_correctInputs select 0)) : {
				
				//update bomb
				_current_input = "";
				_correctInputs deleteAt 0;
				_display_outputs deleteAt 0;
				_correctTypes deleteAt 0;
				
				if (count _correctInputs == 0) then {
					_notDisarmed = false;
				} else {
					[{playSound3D ["\A3\Sounds_F\arsenal\Tools\MineDetector_Beep_01.wss", player];}, nil, 0.1] call CBA_fnc_waitAndExecute;
					[{playSound3D ["\A3\Sounds_F\arsenal\Tools\MineDetector_Beep_01.wss", player];}, nil, 0.2] call CBA_fnc_waitAndExecute;
					
					["CONFIRMED"] call TFB_fnc_defuse_updateKeypad;
					
					if (isNil {_display_outputs select 0}) then {
						[{["          "] call TFB_fnc_defuse_updateKeypad;}, [], 1] call CBA_fnc_waitAndExecute;
					} else {
						[{_this call TFB_fnc_defuse_updateKeypad;}, [_display_outputs select 0], 1] call CBA_fnc_waitAndExecute;
					};
				};
			};
			
			default {
				["INCORRECT"] call TFB_fnc_defuse_updateKeypad;
				//[{["          "] call TFB_fnc_defuse_updateKeypad;}, [], 1] call CBA_fnc_waitAndExecute;
				_current_input = "";
				[{playSound3D ["\A3\Sounds_F\arsenal\Tools\MineDetector_Beep_01.wss", player];}, nil, 0.1] call CBA_fnc_waitAndExecute;
				[{playSound3D ["\A3\Sounds_F\arsenal\Tools\MineDetector_Beep_01.wss", player];}, nil, 0.2] call CBA_fnc_waitAndExecute;
				[{playSound3D ["\A3\Sounds_F\arsenal\Tools\MineDetector_Beep_01.wss", player];}, nil, 0.3] call CBA_fnc_waitAndExecute;
			};
		};
	};

	//for all other keypresses except the reset or enter keys
	if !((_keyPressed in ["reset", "enter", "buttonBlack", "buttonRed"])) then {

		//start from blank and then add key being pressed if we're currently showing some kind of hint
		if (_current_input in _defaultArr) then {
			_current_input = "";
		};
		_current_input = _current_input + _keyPressed;
		[_current_input] call TFB_fnc_defuse_updateKeypad;

	};

	if (_notDisarmed) then {
		TFB_active_defusal setVariable ["TFB_BombColors", [_bomb_wires, _correctTypes, _correctInputs, _display_outputs, _code, _ammo, _mode_sequence, _current_input], true];
	} else {
		["DISARMED!"] call TFB_fnc_defuse_updateKeypad;
		[{playSound3D ["\A3\Sounds_F\arsenal\Tools\MineDetector_Beep_01.wss", player];}, nil, 0.1] call CBA_fnc_waitAndExecute;
		[{playSound3D ["\A3\Sounds_F\arsenal\Tools\MineDetector_Beep_01.wss", player];}, nil, 0.2] call CBA_fnc_waitAndExecute;
		[{playSound3D ["\A3\Sounds_F\arsenal\Tools\MineDetector_Beep_01.wss", player];}, nil, 0.3] call CBA_fnc_waitAndExecute;
		private _bomb_defused = TFB_active_defusal;
		_bomb_defused remoteExec ["TFB_fnc_defuse_remove", 0, true];
		_bomb_defused setVariable ["TFB_BombColors", nil, true];
		_bomb_defused setVariable ["TFB_BombTime", [false , 0], true];
	};
};
tfb_fnc_defuse_remove = {
	_bomb = _this;
	if !(isNull _bomb) then {
		_action = _bomb getVariable "TFB_BombAction";
		_bomb removeAction _action;
	};
};
tfb_fnc_defuse_updateclipboard = {
	playSound "Orange_Leaflet_Investigate_02";
	playSound "Orange_Leaflet_Investigate_02";

	params [["_forward", true, [true]], ["_ignore", false, [true]]];

	_parentDisplay = findDisplay 6700;
	_displayOrControl = _parentDisplay displayCtrl 221;

	// get and store current scroll value
	TFB_BombPageScroll set [TFB_BombPage, (ctrlScrollValues _displayOrControl) select 0];

	// figure out what next page should be (currently only 2 pages)
	_displayText = "";
	_nextPage = TFB_BombPage;
	if !(_ignore) then {
		
		// Start timer
		if (TFB_BombPage == 0) then {
			_timeArr = TFB_active_defusal getVariable "TFB_BombTime";
			if !(_timeArr select 0) then {
				_timeArr set [0, true];
				TFB_active_defusal setVariable ["TFB_BombTime", _timeArr, true];
				[{playSound3D ["\A3\Sounds_F\arsenal\Tools\MineDetector_Beep_01.wss", player];}, nil, 0.1] call CBA_fnc_waitAndExecute;
				[{playSound3D ["\A3\Sounds_F\arsenal\Tools\MineDetector_Beep_01.wss", player];}, nil, 0.2] call CBA_fnc_waitAndExecute;
			};
		};
		
		if (_forward) then {
			_nextPage = TFB_BombPage + 1;
			if (_nextPage > 3) then {TFB_BombPage = 1;} else {TFB_BombPage = _nextPage};
		} else {
			_nextPage = TFB_BombPage - 1;
			if (_nextPage < 1) then {TFB_BombPage = 3;} else {TFB_BombPage = _nextPage};
		};
	};

	if (TFB_BombPage == 0) then {
	_displayText = "
	<br/>
	//// INSTRUCTIONS - READ BEFORE CONTINUING ////<br/>
	<br/><br/>
	BOMB WILL BEGIN DETONATION COUNTDOWN WHEN YOU TURN THE PAGE<br/>
	<br/>
	COMPLETE ALL INSTRUCTIONS ON THE NEXT PAGE IN SEQUENCE<br/><br/>
	YOU HAVE AN AVERAGE OF 60 SECONDS PLUS 15 SECONDS PER INSTRUCTION<br/><br/>
	YOU CAN RESET THE KEYPAD USING *<br/><br/>
	DO NOT REMOVE THE BATTERY POWERING THE DETONATION DEVICE UNDER ANY CIRCUMSTANCES!<br/>
	<br/>
	GOOD LUCK!
	";
	};

	if (TFB_BombPage == 1) then {
		_instructions = (TFB_active_defusal getVariable "TFB_BombInst") select 0;
		if (isNil "_instructions") exitWith {};
		
		// fill instructions
		if (TFB_BombPage == 1) then {
			_displayText = _instructions joinstring "";
		};
	};

	if (TFB_BombPage == 2) then {
		_serial = (TFB_active_defusal getVariable "TFB_BombInst") select 1;
		_maker = (TFB_active_defusal getVariable "TFB_BombInst") select 2;
		_displayText = ["SERIAL NUMBER: ", _serial, "<br/><br/>BOMB MAKER: ", str _maker] joinstring "";
	};

	if (TFB_BombPage == 3) then {
	_displayText = 
	"TRANSLATIONS:<br/>
	<br/>
	////Swedish////<br/>
	DISARM - AVVÄPNA<br/>
	ENTRY - INTRÄDE<br/>
	INPUT - INMATNING<br/>
	SECURITY - SÄKERHET<br/>
	SEQUENCE - SEKVENS<br/>
	OVERRIDE - ÅSIDOSÄTTA<br/>
	ACTIVATE - AKTIVERA<br/>
	CAUTION - VARNING<br/>
	TRIGGER - TRIGGER<br/>
	FORMULA - FORMEL<br/>
	PASSWORD - LÖSENORD<br/>
	KEYCODE - NYCKEL<br/>
	CONTROL - KONTROLL<br/>
	TIMER - TIMER<br/>
	HAZARD - FARA<br/>
	CIRCUIT - KRETS<br/>
	LOCKED - LÅSTAD<br/>
	<br/>
	////German////<br/>
	DISARM - ENTWAFFNEN<br/>
	ENTRY - EINTRAG<br/>
	INPUT - EINGANG<br/>
	SECURITY - SICHERHEIT<br/>
	SEQUENCE - ABFOLGE<br/>
	OVERRIDE - AUFHEBEN<br/>
	ACTIVATE - AKTIVIEREN<br/>
	CAUTION - WARNUNG<br/>
	TRIGGER - AUSLÖSEN<br/>
	FORMULA - FORMEL<br/>
	PASSWORD - PASSWORT<br/>
	KEYCODE - SCHLÜSSEL<br/>
	CONTROL - KONTROLLE<br/>
	TIMER - ZEITMESSER<br/>
	HAZARD - GEFAHR<br/>
	CIRCUIT - SCHALTUNG<br/>
	LOCKED - GESPERRT<br/>
	<br/>
	////Dutch////<br/>
	DISARM - ONTWAPEN<br/>
	ENTRY - TOEGANG<br/>
	INPUT - VOER<br/>
	SECURITY - BEVEILIGD<br/>
	SEQUENCE - REEKS<br/>
	OVERRIDE - TEGANBEVEL<br/>
	ACTIVATE - ACTIVEREN<br/>
	CAUTION - LET OP<br/>
	TRIGGER - TREKKER<br/>
	FORMULA - FORMULE<br/>
	PASSWORD - WACHTWOORD<br/>
	KEYCODE - CIJFERCODE<br/>
	CONTROL - CONTROLE<br/>
	TIMER - TIMER<br/>
	HAZARD - GEVAAR<br/>
	CIRCUIT - CIRCUIT<br/>
	LOCKED - OP SLOT<br/>
	<br/>
	////French////<br/>
	DISARM - DÉSARMER<br/>
	ENTRY - ENTRÉE<br/>
	INPUT - SAISIR<br/>
	SECURITY - SÉCURITÉ<br/>
	SEQUENCE - SÉQUENCE<br/>
	OVERRIDE - SUPPLANTER<br/>
	ACTIVATE - ACTIVER<br/>
	CAUTION - PRUDENCE<br/>
	TRIGGER - GÂCHETTE<br/>
	FORMULA - FORMULE<br/>
	PASSWORD - MOTDEPASSE<br/>
	KEYCODE - CLÉ<br/>
	CONTROL - CONTRÔLE<br/>
	TIMER - MINUTEUR<br/>
	HAZARD - DANGER<br/>
	CIRCUIT - CIRCUIT<br/>
	LOCKED - FERMÉÀCLÉ<br/>
	<br/>
	////Tagalog////<br/>
	DISARM - DISARMAHAN<br/>
	ENTRY - PUMASOK<br/>
	INPUT - INPUTAN<br/>
	SECURITY - SEGURIDAD<br/>
	SEQUENCE - KASUNOD<br/>
	OVERRIDE - OVERRIDE<br/>
	ACTIVATE - ACTIVATE<br/>
	CAUTION - MAG-INGAT<br/>
	TRIGGER - ARMAHAN<br/>
	FORMULA - FORMULA<br/>
	PASSWORD - PASSWORD<br/>
	KEYCODE - KEYCODE<br/>
	CONTROL - KONTROL<br/>
	TIMER - ORAS<br/>
	HAZARD - PANGANIB<br/>
	CIRCUIT - SIRKITO<br/>
	LOCKED - NAKALOCK<br/>";
	};

	// adjust structuredtext in control group to new height to make scroll bar appear correctly
	_clipboardText = _displayOrControl controlsGroupCtrl 222;
	_oldpos = ctrlPosition _clipboardText;
	_clipboardText ctrlSetStructuredText parsetext _displayText;
	_h = ctrlTextHeight _clipboardText;

	_clipboardText ctrlSetPosition [_oldpos select 0,_oldpos select 1,_oldpos select 2, _h];
	_clipboardText ctrlCommit 0;

	// obtain previous scroll val and set
	[{
		_scrollVal = TFB_BombPageScroll select TFB_BombPage;
		_parentDisplay = findDisplay 6700;
		_displayOrControl = _parentDisplay displayCtrl 221;
		_displayOrControl ctrlSetScrollValues [_scrollVal, -1];
	}, [], 0.2] call CBA_fnc_waitAndExecute;
};
tfb_fnc_defuse_updatekeypad = {
	_displayOrControl = findDisplay 6700;
	_string = _this select 0;
	if (TFB_debug) then {systemchat str _this};
	_charCount = ((count _string) min 10);

	if (_charCount < 10) then {
		_add = 10 - _charCount;
		for "_i" from 0 to _add do {
			_string = _string + " ";
		};
	};

	_charCount = ((count _string) min 10);

	for "_i" from 0 to _charCount do {
		private _keypadText = _displayOrControl displayCtrl (211 + _i);
		_char = _string select [_i, 1];
		_keypadText ctrlSetText _char;
		//_keypadText ctrlSetStructuredText parsetext _char;
	};
};
//[bomb, bomb] call tfb_fnc_defuse_dialog;
[bomb1, 4, "Bomb_03_F", "6969"] spawn TFB_fnc_defuse_generateBomb;
[bomb2, 6, "Bomb_03_F", "69420"] spawn TFB_fnc_defuse_generateBomb;
[bomb3, 8, "Bomb_03_F", "124576"] spawn TFB_fnc_defuse_generateBomb;

if (!isServer) exitWith {};

[
    west, ["S1"], "Sector 1", "Eliminate all hostiles in this sector and Defuse Dirty Bomb", 
    "Attack", getPos C1, {true}, { (count (allUnits select {_x inArea Zone1 && side _x == independent}) < 1)}
] spawn tsp_fnc_task;
[
    west, ["S2"], "Sector 2", "Eliminate all hostiles in this sector and Defuse Dirty Bomb", 
    "Attack", getPos C2, {true}, { (count (allUnits select {_x inArea Zone2 && side _x == independent}) < 1)}
] spawn tsp_fnc_task;
[
    west, ["S3"], "Sector 3", "Eliminate all hostiles in this sector and Defuse Dirty Bomb", 
    "Attack", getPos C3, {true}, { (count (allUnits select {_x inArea Zone3 && side _x == independent}) < 1)}
] spawn tsp_fnc_task;
[
    west, ["Defense"], "Defend Zargabad", "Assist 1st Armored Brigade in defending Zargabad against an enemy counterattack.", "Defend", getPos marker1, 
    {"S1" call BIS_fnc_taskState in ["SUCCEEDED","FAILED"] && "S2" call BIS_fnc_taskState in ["SUCCEEDED","FAILED"] && "S3" call BIS_fnc_taskState in ["SUCCEEDED","FAILED"]},
    { (count (allUnits select {_x inArea Zargabad_defend && side _x == independent}) < 2)}, {false}, {false},
    {["Defense"] spawn tsp_fnc_sector_load;},
    {},{"end1" remoteExec ["BIS_fnc_endMission", 0]}
] spawn tsp_fnc_task;