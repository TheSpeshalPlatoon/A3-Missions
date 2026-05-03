params["_player","_minDistance","_maxDistance","_firer"];

_zuccSpeed=20;
_radius=_maxDistance;
{
	if (_x distance _player > _minDistance) then{
		//systemChat ("Zuccing "+str(_x));
		[_x,_player,_zuccSpeed,_radius,_firer] spawn {

			_soundList=["zucc1.ogg","zucc2.ogg","zucc2.ogg","zucc3.ogg","zucc4.ogg","zucc5.ogg","zucc6.ogg","zucc7.ogg","zucc8.ogg","zucc9.ogg","zucc10.ogg","zucc11.ogg","zucc12.ogg"];
			params["_x","_player","_zuccSpeed","_radius","_firer"];
			_t0=time;
			if (getText (configFile >> "CfgVehicles" >> typeOf _x >> "simulation") == "house") exitWith{};
			_x allowDamage false;
			_player disableCollisionWith _x;
			_zuccVec= vectorNormalized(position _player vectorDiff position _x) vectorMultiply _zuccSpeed;
			if (_x isKindOf "CAManBase") then {_x setVelocity( _zuccVec vectorAdd [0,0,1]); sleep 0.1;_x setUnconscious true;};
			while {(_x distance _player > 1)} do {
				_zuccVec= vectorNormalized(position _player vectorDiff position _x) vectorMultiply _zuccSpeed;
				[_x,_zuccVec] remoteExec ["setVelocity",_x];
				if (_x distance _player >  _radius)  exitWith {};
				
				if (time - _t0 > 3) exitWith{};//systemChat(str(time - _t0));
				sleep 0.1;		
			};
			[[_soundList,_x],{params["_soundList", "_obj"];playSound3D [getMissionPath "sounds\"+(selectRandom _soundList), _obj]}] remoteExecCall ["call"];
			//playSound3D [getMissionPath "sounds\"+(selectRandom _soundList), _x];
			if (_x isKindOf "CAManBase") then
			{
				if ((damage _x !=1) and (_x !=_firer ))then{[_firer,1] remoteExec ["addScore",2]};
				_x setDamage 1;
				_x spawn {sleep 0.1;deleteVehicle _this;};
				
			}
			else
			{
				deleteVehicle _x;
			};
			
			
		};
		


	};

}forEach nearestObjects [_player, [], _radius];