#include "..\mission\gear_library.sqf";   
#include "..\mission\gear_select.sqf";   

[] spawn {
	while {true} do {
		sleep 2;
		if (tsp_param_gear == "Enabled") then {
			//-- Uniform
			if !(uniform player in tsp_allowedstuff) then {
				removeUniform player;
				systemchat "Removed Restricted Uniform.";
				player addUniform tsp_default_uniform;
			};

			//-- Vest
			if !(vest player in tsp_allowedstuff) then {
				removeVest player;
				systemchat "Removed Restricted Vest.";
			};

			//-- Scopes
			if !((primaryWeaponItems player select 2) in tsp_allowedstuff) then {
				player removePrimaryWeaponItem (primaryWeaponItems player select 2);
				systemchat "Removed Restricted Weapon Attachment.";
			};

			//-- NVG Helmet Situation
			if (hmd player != "") then {
				_cond1 = (getNumber (configFile >> "CfgWeapons" >> (headgear player) >> "itemInfo" >> "HitpointsProtectionInfo" >> "Head" >> "armor") > 5);
				_cond2 = (getNumber (configFile >> "CfgWeapons" >> (headgear player) >> "itemInfo" >> "armor") > 5);
				if !(_cond1 || _cond2) then {
					systemchat "Detached NVG since you dont have a helmet.";			
					_nvg = hmd player;
					player unassignItem _nvg;
					if !(player canAdd _nvg) then {  //-- If no space in inventory for NVG, drop it on the ground
						container = createVehicle["GroundWeaponHolder_Scripted", [(getPos player) select 0, (getPos player) select 1, ((getPos player) select 2)+0.1], [], 0, "CAN_COLLIDE"];
						container addItemCargoGlobal [_nvg,1];
					};
				};
			};		

			//--- Only continue rest of script when player is near arsenal, else sleep longer
			_nearArsenal = false;
			{
				_distance = player distance (getPos _x);
				if (_distance < tsp_arsenal_distance) then {_nearArsenal = true};		
			} forEach tsp_arsenals;
			if (!_nearArsenal) exitWith {sleep 10};

			//-- Headgear
			if (headgear player in tsp_allowedstuff) then {} else {
				removeHeadgear player;
				systemchat "Removed Restricted Headgear.";
			};
			
			//-- Facewear
			if !(goggles player in tsp_allowedstuff) then {
				removeGoggles player;
				systemchat "Removed Restricted Facewear.";
			};

			//-- Weapon
			if !(primaryWeapon player in tsp_allowedstuff) then {
				player removeWeapon (primaryWeapon player);
				systemchat "Removed Restricted Weapon.";
			};

			//--- Rocket
			if !(secondaryWeapon player in tsp_allowedstuff) then {
				player removeWeapon (secondaryWeapon player);
				systemchat "Removed Restricted Launcher.";
			};

			//--- Pistol
			if !(handgunWeapon player in tsp_allowedstuff) then {
				player removeWeapon (handgunWeapon player);
				systemchat "Removed Restricted Pistol.";
			};

			//-- Backpack
			if !(backpack player in tsp_allowedstuff) then {
				removeBackpack player;
				systemchat "Removed Restricted Backpack.";
			};

			//-- NVGs
			if !(hmd player in tsp_allowedstuff) then {
				player unassignItem (hmd player);
				player removeItem (hmd player);
				systemchat "Removed Restricted Night Vision Goggles.";
			};

			//-- Binoculars
			if !(binocular player in tsp_allowedstuff) then {
				player removeweapon (binocular player);
				systemchat "Removed Restricted Binoculars.";
			};
		};	
	};
};