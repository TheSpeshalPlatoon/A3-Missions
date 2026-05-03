sus=0;
_spawns=[spawn_point,spawn_point_1,spawn_point_2,spawn_point_3,spawn_point_4,spawn_point_5,spawn_point_6,spawn_point_7,spawn_point_8,spawn_point_9];
player setPos (getPos  (selectRandom _spawns));
player setVariable ["freestyloed",false,true];
player setUnitLoadout [[],[],[],["U_C_FormalSuit_01_khaki_F",[]],[],["tsp_gear_zip_tan",[]],"UK3CB_H_WideBrim_Hat","G_Balaclava_Flames1",[],["","","","","",""]];
findDisplay 46 displayRemoveEventHandler ["MouseButtonDown",sus];
findDisplay 46 displayRemoveAllEventHandlers "MouseButtonDown";


_condition=floor(random(5));
switch (_condition) do
{
	case 0: {systemChat "You got the Dyson!"; execVM "dyson_gun.sqf"};
	case 1: {systemChat "You got the Freestylo Gun!"; execVM "freestylo_gun.sqf" };
	case 2: {systemChat "You got the Babymaker!";execVM "babymaker.sqf"};
	case 3: {systemChat "You got the Dade Gun!";execVM "dadegun.sqf"};
	case 4: {systemChat "You got the Wingardium Wand!";execVM "wingardium.sqf"};
	
};


{
if (score _x > 9) then{
    "PlayerScore" call BIS_fnc_endMissionServer;
};
}forEach allPlayers;