GamePhasing = execVM "GamePhasing.sqf";
AllVehiclesPath = execVM "AllVehiclesPath.sqf";
RIP = execVM "prank.sqf";
///Sides Array
allWestUnitsAray = (allUnits) select {side group _x isEqualTo west}; 
allEastUnitsAray = (allUnits) select {side group _x isEqualTo east}; 
allCivilianUnitsAray = (allUnits) select {side group _x isEqualTo civilian};

//Unit spawn
SpawnUnit = {_Objectpos = position _this;
"O_G_SOLDIER_F" createUnit [position _this, Opfour, "
this setPos _Objectpos; 
[this] join grpNull;
group this addWaypoint [position car_1, 0];
this setUnitPos 'UP';
this getSpeed FAST;
this setSkill ['aimingAccuracy', 0.1];
this setSkill ['aimingShake', 0.1];
this setSkill ['aimingSpeed', 0.1];
this setSkill ['spotTime', 0.1];
this setUnitLoadout getUnitLoadout selectRandom units loadout;
lockIdentity this;
[this, Face selectRandom units loadout] remoteExec ['setFace', 0, this]"
 ];
};
SpawnUnit_No_PATH = {_Objectpos = position _this; "O_G_SOLDIER_F" createUnit [position _this, Opfour, "
this setPos _Objectpos; 
[this] join grpNull;
this setUnitPos 'UP';
this getSpeed FAST;
this setSkill ['aimingAccuracy', 0.1];
this setSkill ['aimingShake', 0.1];
this setSkill ['aimingSpeed', 0.1];
this setSkill ['spotTime', 0.1];
this setUnitLoadout getUnitLoadout selectRandom units loadout;
lockIdentity this;
[this, Face selectRandom units loadout] remoteExec ['setFace', 0, this];
this disableAI 'PATH';
"];
};

SpawnUnit_No_PATH_ambush = {_Objectpos = position _this; "O_G_SOLDIER_F" createUnit [position _this, Opfour, "
this setPos _Objectpos;
this synchronizeObjectsAdd [Spawn_Area_abush];
[this] join grpNull;
group this addWaypoint [position car_1, 0];
this setUnitPos 'UP';
this getSpeed FAST;
this setSkill ['aimingAccuracy', 0.1];
this setSkill ['aimingShake', 0.1];
this setSkill ['aimingSpeed', 0.1];
this setSkill ['spotTime', 0.1];
this setUnitLoadout getUnitLoadout selectRandom units loadout;
lockIdentity this;
[this, Face selectRandom units loadout] remoteExec ['setFace', 0, this];
this disableAI 'PATH';
"];
};

SpawnUnit_RPG = {_Objectpos = position _this; "O_G_SOLDIER_F" createUnit [position _this, Opfour, "
this selectWeapon 'rhs_weap_rpg7';
this setPos _Objectpos; 
[this] join grpNull;
group this addWaypoint [position car_1, 0];
this setUnitPos 'UP';
this getSpeed FAST;
this setSkill ['aimingAccuracy', 0.1];
this setSkill ['aimingShake', 0.1];
this setSkill ['aimingSpeed', 0.1];
this setSkill ['spotTime', 0.1];
this setUnitLoadout getUnitLoadout selectRandom units loadout_RPG;
lockIdentity this;
[this, Face selectRandom units loadout] remoteExec ['setFace', 0, this];
this addEventHandler  
[  
 'Fired',  
 { 
  _mag = _this select 5;  
  _unit = _this select 0;  
   
  if ({_x isEqualTo _mag} count magazines _unit < 2) then  
  { 
   _unit addMagazines [_mag, 3];  
  };  
 } 
]; 
"];
};

SpawnUnit_RPG_No_PATH_ambush = {_Objectpos = position _this; "O_G_SOLDIER_F" createUnit [position _this, Opfour, "
this selectWeapon 'rhs_weap_rpg7';
this setPos _Objectpos; 
this synchronizeObjectsAdd [Spawn_Area_abush];
[this] join grpNull;
this disableAI 'PATH';
this setUnitPos 'UP';
this getSpeed FAST;
this setSkill ['aimingAccuracy', 0.1];
this setSkill ['aimingShake', 0.1];
this setSkill ['aimingSpeed', 0.1];
this setSkill ['spotTime', 0.1];
this setUnitLoadout getUnitLoadout selectRandom units loadout_RPG;
lockIdentity this;
[this, Face selectRandom units loadout] remoteExec ['setFace', 0, this];
this addEventHandler  
[  
 'Fired',  
 { 
  _mag = _this select 5;  
  _unit = _this select 0;  
   
  if ({_x isEqualTo _mag} count magazines _unit < 2) then  
  { 
   _unit addMagazines [_mag, 3];  
  };  
 } 
]; 
"];
};

SpawnUnit_RPG_No_PATH = {_Objectpos = position _this; "O_G_SOLDIER_F" createUnit [position _this, Opfour, "
this selectWeapon 'rhs_weap_rpg7';
this setPos _Objectpos; 
[this] join grpNull;
this disableAI 'PATH';
this setUnitPos 'UP';
this getSpeed FAST;
this setSkill ['aimingAccuracy', 0.1];
this setSkill ['aimingShake', 0.1];
this setSkill ['aimingSpeed', 0.1];
this setSkill ['spotTime', 0.1];
this setUnitLoadout getUnitLoadout selectRandom units loadout_RPG;
lockIdentity this;
[this, Face selectRandom units loadout] remoteExec ['setFace', 0, this];
this addEventHandler  
[  
 'Fired',  
 { 
  _mag = _this select 5;  
  _unit = _this select 0;  
   
  if ({_x isEqualTo _mag} count magazines _unit < 2) then  
  { 
   _unit addMagazines [_mag, 3];  
  };  
 } 
]; 
"];
};

SpawnUnit_truck = {
"O_G_SOLDIER_F" createUnit [position _this, Opfour, "
[this] join grpNull;
group this addWaypoint [position car_1, 0];
this moveInAny truckRaid_1;
this setUnitPos 'UP';
this getSpeed FAST;
this setSkill ['aimingAccuracy', 0.1];
this setSkill ['aimingShake', 0.1];
this setSkill ['aimingSpeed', 0.1];
this setSkill ['spotTime', 0.1];
this setUnitLoadout getUnitLoadout selectRandom units loadout;
lockIdentity this;
[this, Face selectRandom units loadout] remoteExec ['setFace', 0, this];"
 ];
};

SpawnUnit_CIV_No_PATH = {_Objectpos = position _this; selectRandom ["C_man_p_beggar_F_afro","C_Man_casual_1_F_afro", "C_man_polo_1_F_afro", "C_man_polo_2_F_afro", "C_man_polo_3_F_afro", "C_man_polo_4_F_afro", "C_man_polo_5_F_afro", "C_man_polo_6_F_afro"] createUnit [position _this, Bluefor, "
this setPos _Objectpos; 
[this] join grpNull;
this setUnitPos 'UP';
this getSpeed FAST;
lockIdentity this;
this setFace Face selectRandom units loadout;
this disableAI 'move';
this setDir getDir Civ_get_food;
"];
};

//Gunner GAP in case player did not connected and spawns
timing = time;
addMissionEventHandler ["EachFrame", {
if (abs(timing - time) < 3) exitWith {};
timing = time;
{_x engineOn false} forEach [car_1, car_2, car_3, car_4];
If (isNull player_1) then {GunnerGAP_3 assignAsGunner car_3; GunnerGAP_3 moveInGunner car_3} else{moveOut GunnerGAP_3; GunnerGAP_3 setPos getPos bot_area};
If (isNull player_2) then {GunnerGAP_2 assignAsGunner car_2; GunnerGAP_2 moveInGunner car_2} else{moveOut GunnerGAP_2; GunnerGAP_2 setPos getPos bot_area};
If (isNull player_3) then {GunnerGAP_1 assignAsGunner car_1; GunnerGAP_1 moveInGunner car_1} else{moveOut GunnerGAP_1; GunnerGAP_1 setPos getPos bot_area};
If (isNull player_4) then {GunnerGAP_4 assignAsGunner car_4; GunnerGAP_4 moveInGunner car_4} else{moveOut GunnerGAP_4; GunnerGAP_4 setPos getPos bot_area};
}];

{
//revive for victor 1
_x addEventHandler ["HitPart", {
	(_this select 0) params ["_target", "_shooter", "_projectile", "_position", "_velocity", "_selection", "_ammo", "_vector", "_radius", "_surfaceType", "_isDirect"];
_surface = (_this select 0) select 5 select 0;
_LastHit = "chest";
if (_surface in ["leftfoot", "rightfoot","leftleg","rightleg","rightupleg","leftupleg"]) then {_LastHit = "Legs"};
if (_surface in ["rightarm", "rightforearm","leftforearm","leftarm"]) then {_LastHit = "Arm"};
if (_surface in ["spine3", "spine2", "spine1"]) then {_LastHit = "chest"};
if (_surface in ["head"]) then {_LastHit = "head"};
_target setVariable ["lasthit",_LastHit,false];
	}];

_x addEventHandler ["HandleDamage", {
	params ["_unit", "_selection", "_damage", "_source", "_projectile", "_hitIndex", "_instigator", "_hitPoint"];
	
	if (abs((_unit getVariable "IsUnconsciou") - time) > 3) exitWith {};
	
	_thehighdamage = selectMax (getAllHitPointsDamage _unit select 2);
	_index = (getAllHitPointsDamage _unit select 2) find _thehighdamage;
	_mostDamagedPart = (getAllHitPointsDamage _unit select 1 select _index);
	
	if ((damage _unit) >= 0.9) then {_unit setDamage ((damage _unit) /1.01)};
	
	if (getdammage _unit >= 0.9 and (lifeState _unit) != "INCAPACITATED") then {
	moveOut _unit;
	_unit setVariable ["IsUnconsciou", time,true]; 
	_unit setUnconscious true;
	_LastHit = _hitPoint;
	[_unit,_mostDamagedPart] spawn {
		_unit = _this select 0;
		_mostDamagedPart = (_unit getVariable "lasthit");
			if (!Alive _unit) exitWith {};
			_unit setCaptive true;
			_unit disableAI "ANIM";
			_unit removeItems "FirstAidKit";
			_amouttoaddback = count ((backpackItems player + vestItems player + uniformItems player) select {_x isEqualto "FirstAidKit"});
			_unit setVariable ["amouttoaddbackFAKs",_amouttoaddback,false];
			_amouttoaddbackmed = count ((backpackItems player + vestItems player + uniformItems player) select {_x isEqualto "Medikit"});
			_unit setVariable ["amouttoaddbackMEDs",_amouttoaddbackmed,false];
		waitUntil {animationState _unit in ["unconsciousrevivedefault","unconsciousfaceup","unconsciousfaceright","unconsciousfaceleft","unconsciousfacedown"]};
		if (!Alive _unit) exitWith {};
		_unit setUnconscious false;
		[_unit, ""] remoteExec ["switchmove", 0];
		if (alive _unit AND _mostDamagedPart in ["Legs"]) then {
		[_unit, (selectrandom ["UnconsciousReviveLegs_A","UnconsciousReviveLegs_B"])] remoteExec ["switchmove", 0]
		};
		if (alive _unit AND _mostDamagedPart in ["Arm"]) then {
		[_unit, (selectrandom ["UnconsciousReviveArms_A","UnconsciousReviveArms_B"])] remoteExec ["switchmove", 0]
		};
		if (alive _unit AND _mostDamagedPart in ["chest"]) then {
		[_unit, (selectrandom ["UnconsciousReviveBody_A","UnconsciousReviveBody_B"])] remoteExec ["switchmove", 0]
		};
		if (alive _unit AND _mostDamagedPart in ["head"]) then {
		[_unit, (selectrandom ["UnconsciousReviveHead_A","UnconsciousReviveHead_B"])] remoteExec ["switchmove", 0]
		};
		sleep 0.5;
		_unit setVariable ["CurrentAnimationState", (animationstate _unit),false]; 
		
		_unit addEventHandler ["AnimDone", {
		params ["_unit", "_anim"];
		if (!alive _unit or isnil {(_unit getVariable "IsUnconsciou")}) exitWith {_unit removeAllEventHandlers "AnimDone"};
		[_unit, (_unit getVariable "CurrentAnimationState")] remoteExec ["switchmove", 0];
		}];
		
		[_unit, ["HandleHeal", {
		params ["_unit", "_healer", "_isMedic"];
		[[_unit,_healer,_thisEventHandler], {
		_unit = _this select 0;
		_healer = _this select 1;
		_thisEventHandler = _this select 2;
		sleep 5;
		if (!alive _healer) exitWith {};
		[_unit, "UnconsciousOutProne"] remoteExec ["switchmove", 0];
		(unitbackpack _unit) addItemCargoGlobal ["Medikit", (_unit getVariable "amouttoaddbackMEDs")];
		(unitbackpack _unit) addItemCargoGlobal ["FirstAidKit", (_unit getVariable "amouttoaddbackFAKs")];
		_unit enableAI "ANIM";
		_unit removeEventHandler ["HandleHeal", _thisEventHandler];
		_unit setVariable ["IsUnconsciou", nil,true]; 
		}] remoteExec ["spawn",(owner _unit)];
		}] ] remoteExec ["addEventHandler",0,true];
	};
	
};


}];

} forEach (units victor_1);