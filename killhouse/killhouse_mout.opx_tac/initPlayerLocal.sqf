[] spawn {
    waitUntil {sleep 1; !isNull findDisplay 46};  //-- Wait until loaded in
    //[player, [zone_play], "You are out of bounds!", {[_this, [zone_play, zone_captive]] spawn tsp_fnc_zone_launch}] spawn tsp_fnc_zone;
    player addEventHandler ["Killed", {tsp_loadout_retain = getUnitLoadout player}];  //-- Save loadout after death
    player addEventHandler ["Respawn", {player setUnitLoadout tsp_loadout_retain}];  //-- Restore loadout after respawn
    while {sleep 1; true} do {
        1 fadeEnvironment (if (player inArea zone_inside_1 || player inArea zone_inside_2) then {0.25} else {1});
        player setCaptive (player inArea zone_captive);  //-- Captive on the catwalk
        if (player inArea zone_banana && speed player > 5 && random 1 < 0.25) then {
            playSound3D ["data\slip.ogg", player, true, getPosASL player, 5, 5];
            (vehicle player) addForce [player vectorModelToWorld [0,1000,0], [1,0,0]]; 
            sleep 3; player setUnconscious false;	
        };
    };
};