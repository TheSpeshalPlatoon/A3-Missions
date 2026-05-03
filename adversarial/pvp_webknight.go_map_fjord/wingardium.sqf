findDisplay 46 displayRemoveEventHandler ["MouseButtonDown",sus];
removeAllWeapons player;
removeAllMagazines player;
player addWeapon "rhs_weap_rsp30_white";//"hgun_esd_01_F";
sleep 0.5;
player setAmmo [currentWeapon player,0];



wing_orbSpeed=5;
wing_lastFire=0;
wing_cooldown=1;
orbGenerator={
	params["_obj"];
	
	_particleSource = "#particlesource" createVehicleLocal position _obj;
	_particleSource attachTo [_obj,[0,0,0]];
	_particleSource setParticleParams
		[
			["\A3\data_f\ParticleEffects\Universal\Universal", 16, 12, 0, 8],
			"", "Billboard", 1, 0.4,						// animationName, type, timerPeriod, lifeTime
			[0,0,0],									// position relative to referenceObject
			[0,0,0],									// velocity
			0, 0.005, 0.003925, 0.1, [1, 1],		// rotation, weight, volume, rubbing, size
			[[0,0,1,1]],	// colors
			[1],										// animationPhase
			0, 0,										// randomDirectionPeriod, randomDirectionIntensity
			"", "",										// onTimer, beforeDestroy
			_obj,										// referenceObject
			0, false,									// angle, bounces
			-1, [],										// bounceOnSurface, emissiveColor
			[0,1,0]										// vectorDir - CANNOT be [0,0,0]
		];
	_particleSource setDropInterval 0.05;
	waitUntil {isNull _obj};
	deleteVehicle _particleSource;


};

sus=(findDisplay 46) displayAddEventHandler ["MouseButtonDown",{
	params ["_displayOrControl", "_button", "_xPos", "_yPos", "_shift", "_ctrl", "_alt"];
	if ((_button == 0) and (time -wing_lastFire>wing_cooldown) )then  {
		wing_lastFire=time;
		

		_dir=getCameraViewDirection player;
		_beg =  eyePos player;
		_end= _beg vectorAdd (_dir vectorMultiply 50);

		
		_target=((lineIntersectsSurfaces [_beg,_end,player,objNull,true,-1])#0)#2; //(nearestObjects [player, ["Man"], 30])#1;
		if (not isNull _target)then {
			if ((_target isKindOf "CAManBase") and (_target in allUnits)) then{
				[player,{playSound3D [getMissionPath "sounds\wingardium.ogg", _this]}] remoteExec ["spawn"];
				
				//systemChat str(_target);
				
				[_target]spawn{
					params["_target"];
					sleep 2;
					_bullet= "Land_GasCanister_F" createVehicle ((position player));//(ASLToAGL eyePos player);\
					_bullet setPosASL (  (player modelToWorldWorld [0,1,1.5]) ); //vectorAdd AGLToASL(player modelToWorldWorld [0,2,0])
					_t0=time;
					_height=[0,0,1.5];
					[[_bullet],orbGenerator]remoteExec["spawn",0];
					
					//hideObjectGlobal _bullet;

					while {(not (_target in nearestObjects [(position _bullet )vectorDiff _height, [], 0.5]) ) and (time-_t0)<10 } do{
						//systemChat str((position _target vectorAdd _height) distance _bullet);
						//systemChat str(nearestObjects [(position _bullet )vectorAdd _height, [], _height#2]);
						_bullet setVelocity ((position _bullet vectorFromTo (position _target vectorAdd _height))vectorMultiply wing_orbSpeed);

						sleep 0.1;
					};
					deleteVehicle _bullet;
					if ( (time-_t0)<10) then{
						[_target,{playSound3D [getMissionPath "sounds\boing.ogg", _this]}] remoteExec ["spawn"];
						[_target,[0,0,12]] remoteExec ["setVelocity",_target];
						systemChat str(_target);
						sleep 0.2;
						_target setUnconscious true;
						sleep 2.5;
						_target setUnconscious false;
						sleep 0.2;
						_target switchMove "amovpercmstpsraswpstdnon";
						sleep 1;
						if (not alive _target) then {[player,1] remoteExec ["addScore",2]};
					}

					
				};
			};
		};
		
		
	};
}]; 


player addEventHandler ["SlotItemChanged", {
	params ["_unit", "_name", "_slot", "_assigned", "_weapon"];
	if (_weapon !="rhs_weap_rsp30_white") then {

		findDisplay 46 displayRemoveEventHandler ["MouseButtonDown",sus];
	}
}];