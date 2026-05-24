missionNamespace setVariable ["Retained_Loadout",getUnitLoadout player];    //-- Save loadout

tsp_killedCount = tsp_killedCount + 1;

titleCut ["", "BLACK OUT", 2.9];uisleep 3; 

if (tsp_param_spectate != "Disabled") then {call tsp_fnc_spectate_open};

sleep 0.5;