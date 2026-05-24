//-- Example: [[this],general,commanding,courage,accuracy,shake,speed,reload,distane,time] call tsp_fnc_setskill
_unitArray = _this select 0;

//-- Update skill variables
tsp_general = _this select 1;
tsp_commanding = _this select 2;
tsp_courage = _this select 3;
tsp_aimingAccuracy = _this select 4;
tsp_aimingShake = _this select 5;
tsp_aimingSpeed = _this select 6;
tsp_reloadSpeed = _this select 7;
tsp_spotDistance = _this select 8;
tsp_spotTime = _this select 9;

//-- Set units in _unitArray to new skill values
{
    _x setSkill ["general", tsp_general]; 
	_x setSkill ["commanding", tsp_commanding];
	_x setSkill ["courage", tsp_courage]; 
    _x setSkill ["aimingAccuracy", tsp_aimingAccuracy]; 
    _x setSkill ["aimingShake", tsp_aimingShake]; 
    _x setSkill ["aimingSpeed", tsp_aimingSpeed]; 
	_x setSkill ["reloadSpeed", tsp_reloadSpeed]; 
    _x setSkill ["spotDistance", tsp_spotDistance]; 
    _x setSkill ["spotTime", tsp_spotTime]; 
    _x allowFleeing 0;
} forEach _unitArray;