
//params["_player"];
babyLength=10;
babyRange=10;
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
	_end= _beg vectorAdd (_dir vectorMultiply babyRange);

	{
		
		_obj=_x#2;
		if ((_obj isKindOf "CAManBase") and (_obj in allUnits)) then
		{
			//_unit disableCollisionWith _obj;
			//_obj setObjectScale 0.2;
			_babyList pushBackUnique _obj;
			_obj setVariable ["babyTime",time];
			[_obj,_unit] spawn { 
						params["_obj","_unit"];
						
						_dummy=(typeOf _obj) createVehicle (position _obj);
						_dummy attachTo [_obj,[0,0,0]];
						_dummy setUnitLoadout (getUnitLoadout _obj);
						_dummy setObjectScale 0.6;
						//_unit disableCollisionWith _dummy;

						[_dummy,{player disableCollisionWith _this}] remoteExec ["spawn",0];
						[_obj, true] remoteExec ["hideObjectGlobal", 2];
					while {time - (_obj getVariable "babyTime")< babyLength}do
					{
						_nearby=nearestObjects [_dummy, ["Man"], 1];
						_dummy switchMove (animationState _obj);
						if (count _nearby >2) then{
							if  (isPlayer (_nearby#2)) then{
								deleteVehicle _dummy;
								_obj setAmmo [currentWeapon _obj,0];
								[_obj, false] remoteExec ["hideObjectGlobal", 2];
								[[_unit,player],{_this#1 disableCollisionWith _this#0}] remoteExec ["spawn",0];
								//_unit disableCollisionWith _obj;
								_soundList=["wee.ogg","wohoo.ogg","yay.ogg"];
								[[_soundList,_obj],{params["_soundList", "_obj"];playSound3D [getMissionPath "sounds\"+(selectRandom _soundList), _obj]}] remoteExecCall ["call"];
								_vel= vectorNormalized((velocity (_nearby#2)));
								[_obj,[0,0,10]] remoteExec ["setVelocity",_obj];
								
								sleep 0.2;
								[_obj,((_vel vectorMultiply 15) vectorAdd [0,0,5])] remoteExec ["setVelocity",_obj];
								sleep 0.1;
								_obj setDamage 1;
								[_unit,1] remoteExec ["addScore",2];
							}

							};
					sleep 0.2;
					
					};
					[_obj, false] remoteExec ["hideObjectGlobal", 2];
					deleteVehicle _dummy;
					
					
					

				}; 
		};
		//_obj setDamage 1;
	}forEach lineIntersectsSurfaces [_beg,_end,_unit,objNull,true,-1];

	//beg=_beg;
	//end=_end;

}];



//[[],
//{
/*

_eh= addMissionEventHandler ["EachFrame",{
	_list=missionNamespace getVariable "babyList";
	systemChat (str(_list));
	if  (count _list > 0) then
	{
		_deleteList=[];
		{
			//_x setObjectScale 0.6 ;
			if ( time - (_x getVariable "babyTime")> babyLength) then {
				_deleteList pushBack _forEachIndex;
			}
		}forEach _list;
		{
			
			_list deleteAt _x;
			missionNamespace setVariable ["babyList",_list,true];
		}forEach _deleteList
		
	};


} ];

[_eh] spawn {params["_eh"];waitUntil {(alive player)==false};  removeMissionEventHandler _eh;};
*/
//}]remoteExec["spawn",0];



/*
onEachFrame
{
	//beg = ASLToAGL eyePos player;
	//end = beg vectorAdd (eyeDirection player vectorMultiply 100);
	drawLine3D [ASLtoAGL beg,ASLtoAGL end, [0,1,0,1]];

};*/