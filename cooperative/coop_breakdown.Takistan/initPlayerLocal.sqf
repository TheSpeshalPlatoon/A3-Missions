///call the Dub
[] spawn compile preprocessfilelinenumbers "Dub.sqf";
///Player init
enableRadio true;
0 fadeRadio 0;
enableSentences false;
showSubtitles false;
player enableFatigue false;
///music on load fix
if(!isMultiplayer) then {
addMissionEventHandler ["Loaded",{
if (PLayMarkaMusic == PLayMarkaMusic) then {"Marka" remoteExec ["playmusic"];};
if (Loop == Loop) then {Loop = addMusicEventHandler ["MusicStop", {"loop" remoteExec ["playmusic"];}];
"loop" remoteExec ["playmusic"];};
if (helirideMusic == helirideMusic) then {"heliride" remoteExec ["playmusic"];};
 }];
};

/// death, Friendly fire and Civilian killed

    player addEventHandler [
        'Killed',
        {
            params ['_killed','_killer','_instigator','_usedEffects'];
            if (currentWeapon vehicle player == "RHS_M2") then {
"cnvy067" remoteExec ["playSound"];
            };
        }
    ];

if ((!isMultiplayer)) then {
    player addEventHandler [
        'Killed',
        {
            params ['_killed','_killer','_instigator','_usedEffects'];
            if (((side (group _killer)) == EAST) OR ((side (group _killer)) == sideUnknown)) then {
                [] spawn {
                    sleep 2; 
                   if (true) then {playSound selectRandom ["playerkilled","playerkilled2","playerkilled3","playerkilled4"]};
                };
            };
        }
    ];
};
/*/ Civilian Killed/*/
addMissionEventHandler [
    'EntityKilled',
    {
        params ['_killed','_killer','_instigator','_effectsUsed'];
        if ((side (group _killed)) isequalto CIVILIAN) then {
            if (!isNull _instigator) then {
                if (_instigator isEqualTo player) then {
                    if (diag_tickTime > (missionNamespace getVariable ['tag_var_killedCivSound',-1])) then {
                        _delay = 1;
                        missionNamespace setVariable ['tag_var_killedCivSound',(diag_tickTime + _delay),FALSE];                      
if (side player == west AND [west, 0] call BIS_fnc_respawnTickets > 1) then {playSound selectRandom["civkill","civkill2","civkill3","civkill4","civkill5","civkill6","civkill7"];};
if (side player == sideEnemy AND [west, 0] call BIS_fnc_respawnTickets > 1) then {playSound selectRandom["Berserk1","Berserk2", "MissionFailedBeserkCIVs", "MissionFailedBeserkCIVs2"]};  
[[west, -1] call BIS_fnc_respawnTickets] spawn BIS_fnc_MP;            
[if ([west, 0] call BIS_fnc_respawnTickets ==0) then {playSound selectRandom ["MissionFailedCivsDead","MissionFailedCivsDead2"]}] spawn BIS_fnc_MP;                       
["civkilled",["-1 respawn tickets",""]] remoteExecCall ["BIS_fnc_showNotification"]; 
[if ([west, 0] call BIS_fnc_respawnTickets ==1) then {["warning",["If you kill more Civilians the mission will fail!",""]] remoteExecCall ["BIS_fnc_showNotification"]}];                                         
                    };
                };
            };
        };
    }
];

/*/ Friendlyfire/*/
addMissionEventHandler [
    'EntityKilled',
    {
        params ['_killed','_killer','_instigator','_effectsUsed'];
        if ((side (group _killed)) isequalto west) then {
            if (!isNull _instigator) then {
                if (_instigator isEqualTo player) then {
                    if (diag_tickTime > (missionNamespace getVariable ['tag_var_killedCivSound',-1])) then {
                        _delay = 3;
                        missionNamespace setVariable ['tag_var_killedCivSound',(diag_tickTime + _delay),FALSE];  						
if (side player == sideEnemy) then {playSound selectRandom["Berserk1","Berserk2","MissionFailedFF", "MissionFailedFF2", "MissionFailedBeserk"]};                        
if (side player == west) then {playSound selectRandom["ff1","ff2","ff3","ff4"]};                    
                        
                    };
                };
            };
        };
    }
];

///Car teleporter
[] spawn {
while {true} do {
if (player distance teleport <= 15 AND !alive delet_1) then {
if (!triggerActivated CarsComeIn) then {     
if (!alive gunner car_1) then {player moveInCargo car_1};    
if (!alive gunner car_2) then {player moveInCargo car_2}; 
if (!alive gunner car_3) then {player moveInCargo car_3};  
if (!alive gunner car_4) then {player moveInCargo car_4}; 
};     
     
if (triggerActivated heliland) then{    
if ({alive _x} count crew heli1 == 2) then {player moveInCargo heli1};  
if ({alive _x} count crew heli2 == 2) then {player moveInCargo heli2};    
if (!alive gunner car_1) then {player moveInCargo car_1};  
if (!alive gunner car_2) then {player moveInCargo car_2}; 
if (!alive gunner car_3) then {player moveInCargo car_3};  
if (!alive gunner car_4) then {player moveInCargo car_4}; 
sleep 1; 
   };
  }; 
 }; 
};   
     

///CombatArea
[] spawn {
while {true AND !triggerActivated AboutToEnd} do {
Sleep 1;
If (player distance [10,10,10] >= 200 AND Alive player AND player distance [5802.16,11294.8,0.0807266] >= 50 AND player distance [3687.18,11165.9,7.62939e-006] >= 180 AND player distance [3124.24,9927.46,0]>= 300 AND !(currentWeapon vehicle player == "RHS_M2") AND !(currentWeapon vehicle player == "rhs_weap_m134_minigun_1"))
then {
_this = vehicle player;
moveout player;
player moveInGunner _this;
Hint "Desertion in not tolerated in the US Army. Return now or you will be executed";
playSound [selectRandom ["CombatArea","CombatArea2","CombatArea3"], true];
Sleep 5;
If (player distance [10,10,10] >= 200 AND Alive player AND player distance [5802.16,11294.8,0.0807266] >= 50 AND player distance [3687.18,11165.9,7.62939e-006] >= 180 AND player distance [3124.24,9927.46,0]>= 300 AND !(currentWeapon vehicle player == "RHS_M2") AND !(currentWeapon vehicle player == "rhs_weap_m134_minigun_1"))
then {
Hint "Desertion in not tolerated in the US Army. Return now or you will be executed";
playSound [selectRandom ["CombatArea","CombatArea2","CombatArea3"], true];
  };
sleep 5;
hint "";
  };
 };
};
[] spawn {
while {true AND !triggerActivated AboutToEnd} do {
Sleep 1;
If (player distance [10,10,10] >= 200 AND Alive player AND player distance [5802.16,11294.8,0.0807266] >= 50 AND player distance [3687.18,11165.9,7.62939e-006] >= 180 AND player distance [3124.24,9927.46,0]>= 300 AND !(currentWeapon vehicle player == "RHS_M2") AND !(currentWeapon vehicle player == "rhs_weap_m134_minigun_1"))
then {
Sleep 10;
If (player distance [10,10,10] >= 200 AND Alive player AND player distance [5802.16,11294.8,0.0807266] >= 50 AND player distance [3687.18,11165.9,7.62939e-006] >= 180 AND player distance [3124.24,9927.46,0]>= 300 AND !(currentWeapon vehicle player == "RHS_M2") AND !(currentWeapon vehicle player == "rhs_weap_m134_minigun_1"))
then {
player setdamage (damage player + 1);
   };
  };
 };
};