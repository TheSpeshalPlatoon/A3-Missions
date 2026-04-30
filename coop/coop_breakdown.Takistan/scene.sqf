titlecut [" ","BLACK IN",3];
_camera = "camera" camcreate [0,0,0];
_camera cameraeffect ["internal", "back"];
;comment "ending1";

_camera camPrepareTarget [3120.4,9921.5,0.865002];
_camera camPreparePos [3114.57,9961.85,11.3241];
_camera camPrepareFOV 0.700;
_camera camCommitPrepared 0;
{moveOut _x} forEach units playersslots;
{_x disableAI "move"} forEach units playersslots;
[] spawn {
while {true} do {
{_x setDir 257.115} forEach units playersslots;
};
{_x setVelocity [0, 0, 0]} forEach units playersslots;
};

[player, (selectrandom ["Acts_AidlPercMstpSloWWrflDnon_warmup_3_loop","Acts_AidlPercMstpSloWWrflDnon_warmup_1_loop","Acts_AidlPercMstpSloWWrflDnon_warmup_2_loop"])] remoteExec ["switchmove",0];

if (count units playersslots >= 1) then {units playersslots select 0 setpos getpos Cut_player_Possition_1; units playersslots select 0 setDir 247.344};
if (count units playersslots >= 2) then {units playersslots select 1 setpos getpos Cut_player_Possition_2; units playersslots select 1 setDir 247.344};
if (count units playersslots >= 3) then {units playersslots select 2 setpos getpos Cut_player_Possition_3; units playersslots select 2 setDir 247.344};
if (count units playersslots >= 4) then {units playersslots select 3 setpos getpos Cut_player_Possition_4; units playersslots select 3 setDir 247.344};

sleep 0;

;comment "ending2";
_camera camPrepareTarget [3120.4,9921.5,0.865002];
_camera camPreparePos [3074.75,9952.04,20.6572];
_camera camPrepareFOV 0.700;
_camera camCommitPrepared 5;

sleep 3;

_camera camPrepareTarget [3120.4,9921.5,0.865002];
_camera camPreparePos [3124.55,9926.33,6.82523];
_camera camPrepareFOV 0.700;
_camera camCommitPrepared 0;

sleep 0;

;comment "ending2";
_camera camPrepareTarget [3120.4,9921.5,0.865002];
_camera camPreparePos [3116.17,9922.07,0];
_camera camPrepareFOV 0.700;
_camera camCommitPrepared 5;

sleep 3;

;comment "ending2";
_camera camPrepareTarget [3135.59,9920.62,0];
_camera camPreparePos [3117.78,9922.59,1.09658];
_camera camPrepareFOV 0.700;
_camera camCommitPrepared 0;
Civ_get_food action ["TakeBag", Civ_get_food];
sleep 2;
deleteVehicle Food_cut;
Civ_get_food enableAI "move";
Civ_get_food addBackpack "rhs_sidor";

sleep 15;


_camera cameraeffect ["terminate", "back"];
camdestroy _camera;
