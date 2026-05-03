
player removeAllEventHandlers "Fired";
removeAllWeapons player;
removeAllMagazines player;
player addMagazines ["rhs_mag_M781_Practice", 11];
player addWeapon "rhs_weap_M320";




player addEventHandler ["Fired", { 
 params ["_unit", "_weapon", "_muzzle", "_mode", "_ammo", "_magazine", "_projectile", "_vehicle"]; 
	if (typeOf _projectile =="rhsusf_40mm_Practice") then {
		[_projectile,_unit]spawn 
		{ 
		
			params["_projectile","_unit"]; 


			_bullet= "Land_GasCanister_F" createVehicle position player;

			_bullet attachTo [_projectile,[0,0,0] ];
			_bullet setObjectScale 0.001;
			_bullet setVelocityModelSpace [0,0,0];
			
			waitUntil { isNull _projectile}; 

			
			_bullet1 = "C_Story_EOD_01_F" createVehicle [0,0,0];//createGroup EAST createUnit ["C_Story_EOD_01_F", [0,0,0], [], 0, "FORM"]; 
			_bullet1 switchMove "acts_dance_01"; 
			_bullet1 attachTo [_bullet,[0,0,0]]; 
			_bullet1 allowDamage false;

			//[[_bullet1],{params["_bullet1"];_bullet1 say3D "what"}] remoteExec ["spawn", 0];
			
			[_bullet1,{playSound3D [getMissionPath "sounds\what.ogg", _this]}] remoteExec ["spawn"];
			sleep 2.45; 

			_boom="R_PG7_F" createVehicle position _bullet1; 
			_boom attachTo [_bullet1,[0,0,0]]; 
			//systemChat (str(nearestObjects [_boom, ["Man"], 10]));
			{
				
				if ((_x != _bullet1) and (_x != player)) then{
					[_x,_boom,_unit] spawn {
						params["_x","_boom","_unit"];

						waitUntil{(not alive _boom)};
						sleep 0.2;
						if (not alive _x)then{[_unit,1] remoteExec ["addScore",2]};
					};
				};


			}forEach nearestObjects [_boom, ["Man"], 10];
			deleteVehicle _bullet;
			deleteVehicle _bullet1; 
			_boom setDamage 1;
			
			sleep 3;



			



		};
	};

}
];

