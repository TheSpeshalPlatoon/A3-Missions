[] spawn {
    waitUntil {sleep 1; !isNull findDisplay 46};  //-- Wait until loaded in
    player addEventHandler ["Killed", {tsp_loadout_retain = getUnitLoadout player}];  //-- Save loadout after death
    player addEventHandler ["Respawn", {player setUnitLoadout tsp_loadout_retain}];  //-- Restore loadout after respawn
    while {sleep 1; true} do {
        1 fadeEnvironment (if (player inArea zone_inside_1 || player inArea zone_inside_2) then {0.25} else {1});
        player setCaptive (player inArea zone_captive);  //-- Captive on the catwalk
        if !(player inArea zone_play) then {  //-- Thou shalt not leave plato's cave
            (vehicle player) setDir (player getDir ([[zone_play, zone_captive], player] call BIS_fnc_nearestPosition));   
            (vehicle player) allowDamage false;
            (vehicle player) addForce [player vectorModelToWorld [0,5000,0], [1,0,0]]; sleep 3;
            (vehicle player) allowDamage true; player setUnconscious false;	
        };
    };
};