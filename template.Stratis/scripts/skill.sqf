["tsp_param_skill", "SLIDER", "AI Skill", "", ["TSP Core", "Skill"], [0,1,1]] call tsp_fnc_setting;
["tsp_param_dispersion", "SLIDER", "AI Dispersion", "", ["TSP Core", "Skill"], [0,300,20]] call tsp_fnc_setting;
["tsp_param_spotting", "SLIDER", "AI Spotting", "", ["TSP Core", "Skill"], [0,1,0.5]] call tsp_fnc_setting;

tsp_fnc_skill = {
	params ["_unit", ["_skill", tsp_param_skill], ["_dispersion", tsp_param_dispersion], ["_spotting", tsp_param_spotting]];
    _unit setSkill _skill; {_unit setSkill [_x, _spotting]} forEach ["spotTime", "spotDistance"]; _unit allowFleeing 0;
    if (_dispersion != tsp_param_dispersion) then {_unit setVariable ["dispersion", _dispersion, true]};
    _unit addEventHandler ["FiredMan", {
        params ["_unit", "_weapon", "_muzzle", "_mode", "_ammo", "_magazine", "_projectile", "_vehicle"]; 
        if (isPlayer _unit) exitWith {}; _rand = _unit getVariable ["dispersion", tsp_param_dispersion];
        _projectile setVelocityModelSpace [random (selectRandom [_rand, -_rand]), (velocityModelSpace _projectile)#1, random (selectRandom [_rand, -_rand])];
    }];
};

//-- SET SKILL ON EACH NEW UNIT
{[_x] call tsp_fnc_skill} forEach allUnits; 
addMissionEventHandler ["EntityCreated", {params ["_entity"]; if (local _entity && _entity isKindOf "CAManBase") then {[_entity] call tsp_fnc_skill}}];