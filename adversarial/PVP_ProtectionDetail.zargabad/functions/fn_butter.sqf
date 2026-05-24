fnButter = {
	params ["_position"];
	butter_camera = "camera" camCreate _position;
	butter_camera cameraEffect ["INTERNAL", "BACK"];
	showCinemaBorder false;	

	////-- FIELD OF VIEW
	//-- Variables
	butter_fov_actualPos = 0.75;
	butter_fov_chaserPos = 0.75;
	butter_fov_distance = 0;

	//-- Inputs
	butterEH_MouseZ = (findDisplay 46) displayAddEventHandler ["MouseZChanged", {	
		butter_fov_actualPos = butter_fov_actualPos - ((_this select 1)/70) min 8.5 max 0.01;
		false
	}];

	////-- DIRECTION
	//-- Variables
	butter_yaw_actualPos = 0;
	butter_yaw_chaserPos = 0;
	butter_yaw_distance = 0;
	butter_pitch_actualPos = 0;
	butter_pitch_chaserPos = 0;
	butter_pitch_distance = 0;

	//-- Inputs
	butterEH_MouseMove = (findDisplay 46) displayAddEventHandler ["MouseMoving", {		
		butter_yaw_actualPos = butter_yaw_actualPos + (_this select 1);
		butter_pitch_actualPos = (butter_pitch_actualPos + -(_this select 2)) min 90 max -90;  //-- So that you can only look so far up and down as to not do loops
	}];

	////-- MOVEMENT
	//-- Variables
	butter_leftright_actualPos = 0;
	butter_leftright_chaserPos = 0;
	butter_leftright_distance = 0;
	butter_frontback_actualPos = 0;
	butter_frontback_chaserPos = 0;
	butter_frontback_distance = 0;
	butter_updown_actualPos = 0;
	butter_updown_chaserPos = 0;
	butter_updown_distance = 0;
	butter_speed_default = 10;
	butter_speed_shift = 5;
	butter_speed_alt = 1;
	butter_speed_ctrl = 15;
	butter_speed_actual = butter_speed_default;
	butter_speed_chaser = butter_speed_default;
	butter_speed_modifer_distance = 0;

	//-- Inputs
	butterEH_KeyDown = (findDisplay 46) displayAddEventHandler ["KeyDown", {	
		switch (_this select 1) do {
			case 32:{butter_leftright_actualPos = 1};                              //-- D
			case 30:{butter_leftright_actualPos = -1};                            //-- A
			case 17:{butter_frontback_actualPos = 1};	                         //-- W
			case 31:{butter_frontback_actualPos = -1};                          //-- S
			case 16:{butter_updown_actualPos = 1};                             //-- Q
			case 44:{butter_updown_actualPos = -1};                           //-- Z
			case 42:{butter_speed_actual = butter_speed_shift};              //-- SHIFT
			case 56:{butter_speed_actual = butter_speed_alt};               //-- ALT
			case 29:{butter_speed_actual = butter_speed_ctrl};             //-- CTRL
			if (isNil "butter_flipFlop") then {butter_flipFlop = true};
			case 15:{                                                    //-- Backspace
				if (butter_flipFlop) then {
					butter_flipFlop = false;
					call fnButterTags;
				} else {
					butter_flipFlop = true;
					call fnKillButterTags;
				};
			};
		};
		false
	}];
	butterEH_keyUp = (findDisplay 46) displayAddEventHandler ["keyUp", {	
		switch (_this select 1) do {
			case 32:{butter_leftright_actualPos = 0};
			case 30:{butter_leftright_actualPos = 0};
			case 17:{butter_frontback_actualPos = 0};
			case 31:{butter_frontback_actualPos = 0};
			case 16:{butter_updown_actualPos = 0};
			case 44:{butter_updown_actualPos = 0};
			case 42:{butter_speed_actual = butter_speed_default};
			case 56:{butter_speed_actual = butter_speed_default};
			case 29:{butter_speed_actual = butter_speed_default};
		};
		false
	}];

	////-- TICKS
	butterEH_Tick = addMissionEventHandler ["EachFrame", {
		//--Field of View
			butter_fov_distance = butter_fov_actualPos - butter_fov_chaserPos;
			butter_fov_chaserPos = butter_fov_chaserPos + (butter_fov_distance/25);	

			butter_camera camPrepareFov butter_fov_chaserPos;
			butter_camera camCommit 0.25;	

		//-- Direction
			//-- Create "chaser" position that trails behind where cursor is (Makes the movement all lethargic and stuff) (Good example @ https://p5js.org/examples/input-easing.html)
			butter_yaw_distance = butter_yaw_actualPos - butter_yaw_chaserPos;
			butter_yaw_chaserPos = butter_yaw_chaserPos + (butter_yaw_distance/25);		

			butter_pitch_distance = butter_pitch_actualPos - butter_pitch_chaserPos;
			butter_pitch_chaserPos = butter_pitch_chaserPos + (butter_pitch_distance/25);

			//-- Set camera angle to those "chaser" positions
			butter_camera setDir butter_yaw_chaserPos;
			[butter_camera, butter_pitch_chaserPos, 0] call bis_fnc_setpitchbank;

		//-- Movement
			//-- Create "chaser" camera position that trails behind where the camera should actually be if raw inputs were used (Makes the movement all lethargic and stuff)
			butter_leftright_distance = butter_leftright_actualPos - butter_leftright_chaserPos;
			butter_leftright_chaserPos = (butter_leftright_chaserPos + (butter_leftright_distance/25)) min 1 max -1;

			butter_frontback_distance = butter_frontback_actualPos - butter_frontback_chaserPos;
			butter_frontback_chaserPos = (butter_frontback_chaserPos + (butter_frontback_distance/25)) min 1 max -1;
			
			butter_updown_distance = butter_updown_actualPos - butter_updown_chaserPos;
			butter_updown_chaserPos = (butter_updown_chaserPos + (butter_updown_distance/25)) min 1 max -1;
			
			butter_speed_modifer_distance = butter_speed_actual - butter_speed_chaser;
			butter_speed_chaser = (butter_speed_chaser + (butter_speed_modifer_distance/50));

			//-- Normalize movement vector so now overflow. So that like when you move diagonally, you don't move faster that you should be able to or whatever, u know?
			magnitude = vectorMagnitude [butter_leftright_chaserPos,butter_frontback_chaserPos,butter_updown_chaserPos];
			if (magnitude > 1) then {
				butter_leftright_chaserPos = butter_leftright_chaserPos/magnitude;
				butter_frontback_chaserPos = butter_frontback_chaserPos/magnitude;
				butter_updown_chaserPos = butter_updown_chaserPos/magnitude;
			};

			butter_camera camSetRelPos (butter_camera modelToWorldWorld [butter_leftright_chaserPos/butter_speed_chaser,butter_frontback_chaserPos/butter_speed_chaser,butter_updown_chaserPos/butter_speed_chaser]);
			butter_camera camCommit 0.05;
	}];
};

fnUnButter = {
	(findDisplay 46) displayRemoveEventHandler ["KeyDown", butterEH_KeyDown];  
	(findDisplay 46) displayRemoveEventHandler ["KeyUp", butterEH_KeyUp];  
	(findDisplay 46) displayRemoveEventHandler ["MouseZChanged", butterEH_MouseZ]; 
	(findDisplay 46) displayRemoveEventHandler ["MouseMoving", butterEH_MouseMove]; 
	removeMissionEventHandler ["EachFrame", butterEH_Tick];
	butter_camera cameraEffect ["terminate", "back"];
	camDestroy butter_camera;
};

fnButterTags = {
	butterEH_Tags = addMissionEventHandler ["Draw3D", {
		{
			if (alive _x) then {	
				_dist = (butter_camera distance _x) / 150;			
				_color = [side _x, false] call BIS_fnc_sideColor;
				_color set [3, 1 - _dist];
				_text = "";
				if ((isPlayer _x) && (_dist<0.1)) then {_text = name _x};
				drawIcon3D [
					"A3\ui_f\data\map\markers\military\triangle_CA.paa",
					_color,
					[
						visiblePosition _x select 0,
						visiblePosition _x select 1,
						(visiblePosition _x select 2) + ((_x modelToWorld (_x selectionPosition 'head')) select 2) + 0.5
					],
					0.75-_dist, 
					0.75-_dist, 
					180,
					_text,
					0,
					0.03,
					'PuristaBold'
				];

			};
		} forEach allUnits;
	}];
	cameraEffectEnableHUD true;
};

fnKillButterTags = {
	removeMissionEventHandler ["Draw3D", butterEH_Tags];
	cameraEffectEnableHUD false;
};

params ["_action","_position"];

switch (_action) do {
	case "Terminate": {
		call fnUnButter;
		call fnKillButterTags;
		Buttered = nil;
	};
	case "Start": {
		call fnUnButter;
		call fnKillButterTags;
		sleep 1;
		[_position] call fnButter;
		Buttered = true;
	};
};