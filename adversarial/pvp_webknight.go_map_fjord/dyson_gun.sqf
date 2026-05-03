

player removeAllEventHandlers "Fired";
removeAllWeapons player;
removeAllMagazines player;
player addMagazines ["rhs_mag_M781_Practice", 11];
player addWeapon "rhs_weap_M320";


player addEventHandler ["Fired",{
	params ["_unit", "_weapon", "_muzzle", "_mode", "_ammo", "_magazine", "_projectile", "_gunner"];


	[_projectile,_unit]spawn{
		params["_projectile","_unit"];
		if (typeOf _projectile =="rhsusf_40mm_Practice") then
		{
			_bullet= "Land_GasCanister_F" createVehicle position player;
			_bullet attachTo [_projectile,[0,0,0] ];
			[_bullet, true] remoteExec ["hideObjectGlobal", 2];
			waitUntil { isNull _projectile};

			_soundList=["dyson1.ogg","dyson2.ogg","dyson3.ogg"];
			[[_soundList,_bullet],{params["_soundList", "_obj"];playSound3D [getMissionPath "sounds\"+(selectRandom _soundList), _obj]}] remoteExecCall ["call"];
			[_bullet,0,5,_unit] execVM "dyson.sqf";
			sleep 2;
			deleteVehicle _bullet;
		}


	};


}];