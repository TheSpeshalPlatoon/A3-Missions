[[  //-- Intro
	[5,{
		[4,2,false] call bis_fnc_animatedScreen;
		[true, ["Takistan, 2015"]] spawn BIS_fnc_OM_AS_ShowStaticText;
		uiSleep 3; [3,2,false] call bis_fnc_animatedScreen;
	}], [7,{
		[4,2,false] call bis_fnc_animatedScreen;
		[true, ["The middle east is on the verge of all out war due to tensions between Takistan and it's neighbours."], 4] spawn BIS_fnc_OM_AS_ShowStaticText;
		uiSleep 5; [3,2,false] call bis_fnc_animatedScreen;
	}], [5,{
		[4,2,false] call bis_fnc_animatedScreen;
		[5,1,"data\01_b.paa",nil,nil,1] call bis_fnc_animatedScreen; [6,1,8,nil,1.1] call bis_fnc_animatedScreen;
		[5,2,"data\01_f.paa",nil,nil,1] call bis_fnc_animatedScreen; [6,2,8,nil,1.2] call bis_fnc_animatedScreen;  //burning t72
		uiSleep 3; [3,2,false] call bis_fnc_animatedScreen;
	}], [7,{
		[4,2,false] call bis_fnc_animatedScreen;
		[true, ["Takistani forces increased military activity along the borders."], 4] spawn BIS_fnc_OM_AS_ShowStaticText;
		uiSleep 5; [3,2,false] call bis_fnc_animatedScreen;
	}], [5,{
		[4,2,false] call bis_fnc_animatedScreen;
		[5,1,"data\01_b.paa",nil,nil,1] call bis_fnc_animatedScreen; [6,1,8,nil,1.1] call bis_fnc_animatedScreen;  //takistan formation
		[5,2,"data\01_f.paa",nil,nil,1] call bis_fnc_animatedScreen; [6,2,8,nil,1.2] call bis_fnc_animatedScreen;
		uiSleep 3; [3,2,false] call bis_fnc_animatedScreen;
	}], [7,{
		[4,2,false] call bis_fnc_animatedScreen;
		[true, ["While disputes over the oil-rich Sharig Plateau have brought relations between Takistan and Karzeghistan to the breaking point."], 4] spawn BIS_fnc_OM_AS_ShowStaticText;
		uiSleep 5; [3,2,false] call bis_fnc_animatedScreen;
	}], [5,{
		[4,2,false] call bis_fnc_animatedScreen;
		[5,1,"data\01_b.paa",nil,nil,1] call bis_fnc_animatedScreen; [6,1,8,nil,1.1] call bis_fnc_animatedScreen;  //burning oil fields, destroyed tanks
		[5,2,"data\01_f.paa",nil,nil,1] call bis_fnc_animatedScreen; [6,2,8,nil,1.2] call bis_fnc_animatedScreen;
		uiSleep 3; [3,2,false] call bis_fnc_animatedScreen;
	}],	[7,{
		[4,2,false] call bis_fnc_animatedScreen;
		[true, ["Diplomatic efforts have failed, and neighboring states have requested international assistance."], 4] spawn BIS_fnc_OM_AS_ShowStaticText;
		uiSleep 5; [3,2,false] call bis_fnc_animatedScreen;
	}], [5,{
		[4,2,false] call bis_fnc_animatedScreen;
		[5,1,"data\03_b.paa",nil,nil,1] call bis_fnc_animatedScreen; [6,1,8,nil,1.1] call bis_fnc_animatedScreen;  //AN security council argument
		[5,2,"data\03_f.paa",nil,nil,1] call bis_fnc_animatedScreen; [6,2,8,nil,1.2] call bis_fnc_animatedScreen;
		uiSleep 3; [3,2,false] call bis_fnc_animatedScreen;
	}],	[7,{
		[4,2,false] call bis_fnc_animatedScreen;
		[true, ["Coalition forces are now entering the region to neutralize the threat and prevent the conflict from spreading."]] spawn BIS_fnc_OM_AS_ShowStaticText;
		uiSleep 5; [3,2,false] call bis_fnc_animatedScreen;
	}], [5,{
		[4,2,false] call bis_fnc_animatedScreen;
		[5,1,"data\04_b.paa",nil,nil,1] call bis_fnc_animatedScreen; [6,1,8,nil,1.1] call bis_fnc_animatedScreen;  //LAR
		[5,2,"data\04_f.paa",nil,nil,1] call bis_fnc_animatedScreen; [6,2,8,nil,1.2] call bis_fnc_animatedScreen;
		uiSleep 3; [3,2,false] call bis_fnc_animatedScreen;
	}]
], "shellac", {[] spawn tsp_fnc_spawn}] spawn tsp_fnc_intro;

[
	west, ["airfield"], "Capture Airfield", "Assault and clear the enemy airfield.", "Attack", "sector_airfield_close", 
	{true}, {["airfield_close", "", sector_airfield_close, 0, 1] call tsp_fnc_sector_clear}
] spawn tsp_fnc_task;
[
	west, ["ammo"], "Capture Ammo Storage", "Assault and clear the ammo storage facility.", "Attack", "sector_ammo_close", 
	{true}, {["ammo_close", "", sector_ammo_close, 0, 1] call tsp_fnc_sector_clear}
] spawn tsp_fnc_task;
[
	west, ["aircraft", "airfield"], "Destroy Aircraft", "Destroy at least 3 Mig-21s stationed at the airfield.", 
	"Destroy", objNull, {true}, {!alive task_mig1 && !alive task_mig2 && !alive task_mig3}
] spawn tsp_fnc_task;
[
	west, ["radar"], "Destroy Radars", "Destroy 2 enemy radar units in the AO.", 
	"Destroy", objNull, {true}, {!alive task_radar1 && !alive task_radar2}
] spawn tsp_fnc_task;

tsp_dust = true;
while {tsp_dust} do {_duration = (random 120) max 60; [10, _duration, false, false, false, 0.3] execVM "AL_dust_storm\al_duststorm.sqf"; uiSleep ((random 300) max 150)};