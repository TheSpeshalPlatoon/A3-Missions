//-- Only Server can Create Zeus
_zoos = (createGroup sideLogic) createUnit ["ModuleCurator_F", [0,0,0], [], 0, "NONE"]; 
_zoos setvariable ['BIS_fnc_initModules_disableAutoActivation', false, true]; 
(_this select 0) assignCurator _zoos;