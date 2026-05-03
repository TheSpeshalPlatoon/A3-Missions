
removeAllWeapons player;
player removeAllEventHandlers "Fired";
removeAllMagazines player;
player addMagazines ["rhs_mag_30Rnd_556x45_M200_Stanag", 11];
player addWeapon "rhs_weap_mk18_KAC";
player addWeaponItem["rhs_weap_mk18_KAC","rhsusf_acc_EOTECH"];

player addEventHandler ["Fired",{
	params ["_unit", "_weapon", "_muzzle", "_mode", "_ammo", "_magazine", "_projectile", "_gunner"];

	_unit setAmmo [currentWeapon _unit,0];
	_dir=_unit weaponDirection currentWeapon _unit;
	_beg =  eyePos _unit;
	_end= _beg vectorAdd (_dir vectorMultiply 150);
	//systemChat(str(_beg) + "  " +str(_end));
		
	_obj=(lineIntersectsSurfaces [_beg,_end,_unit,objNull,true,-1])#0#2;
	if (not isNull _obj)then {
		if (_obj isKindOf "CAManBase") then
		{
		_obj setDamage 0;
		[_obj]execVM "freestylo.sqf";			
		[_unit,1] remoteExec ["addScore",2];
			
		};
		//_obj setDamage 1;
	
	};

}];