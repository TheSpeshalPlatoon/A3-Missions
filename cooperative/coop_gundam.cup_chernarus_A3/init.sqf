[[
    [4,{  //-- 4 Seconds total
        [30,0,"Chernarus, 2015", [0.50,0.50],5,[207/255,207/255,207/255,1],0,1.5,0,"PuristaBold"] call BIS_fnc_AnimatedScreen;
        [31,0,1,nil,nil,1] call BIS_fnc_AnimatedScreen;  //-- Mode, layer, fade in
        uiSleep 3;  //-- Wait 3 seconds
        [3,1,false] call bis_fnc_animatedScreen;  //-- fade out, 1 seconds long
    }], [8,{
        [4,0.5,false] call bis_fnc_animatedScreen;
		[true, ["Post Operation 'Harvest Red', U.S. Troops are stationed in Chernarus to help stabilize the country, train CDF forces, and help hunt down the last remnants of the ChDKZ."], 4] spawn BIS_fnc_OM_AS_ShowStaticText;
        uiSleep 5; [3,2,false] call bis_fnc_animatedScreen;
	}], [7,{
        [4,2,false] call bis_fnc_animatedScreen;
		[true, ["Meanwhile, under the pretext of a ‘training exercise’, the Russian Federation began amassing large battlegroups near Chernarus."], 4] spawn BIS_fnc_OM_AS_ShowStaticText;
        uiSleep 5; [3,2,false] call bis_fnc_animatedScreen;
    }], [5,{
        [4,2,false] call bis_fnc_animatedScreen;
		[5,1,"data\01_b.paa",nil,nil,1] call bis_fnc_animatedScreen; [6,1,8,nil,1.1] call bis_fnc_animatedScreen;
		[5,2,"data\01_b.paa",nil,nil,1] call bis_fnc_animatedScreen; [6,2,8,nil,1.2] call bis_fnc_animatedScreen;
        uiSleep 3; [3,2,false] call bis_fnc_animatedScreen;
	}], [7,{
        [4,2,false] call bis_fnc_animatedScreen;
		[true, ["Russia then crossed into Chernarus with the goal of 'restoring order', in support of the ChDKZ and declaring the CDF government illegitimate."], 4] spawn BIS_fnc_OM_AS_ShowStaticText;
        uiSleep 5; [3,1,false] call bis_fnc_animatedScreen;
    }], [7,{
        [4,2,false] call bis_fnc_animatedScreen;
		[true, ["Striking from Takistan, the Green Sea and the Russian border. Quickly overwhelming CDF and U.S. positions."], 4] spawn BIS_fnc_OM_AS_ShowStaticText;
        uiSleep 4.5; [3,2,false] call bis_fnc_animatedScreen;
    }], [11,{
        [4,2,false] call bis_fnc_animatedScreen;
		[5,1,"data\02_b.paa",nil,nil,1] call bis_fnc_animatedScreen; [6,1,8,nil,1.1] call bis_fnc_animatedScreen;
		[5,2,"data\02_b.paa",nil,nil,1] call bis_fnc_animatedScreen; [6,2,8,nil,1.2] call bis_fnc_animatedScreen;
        uiSleep 8; [3,2,false] call bis_fnc_animatedScreen;
	}], [5,{
        [4,2,false] call bis_fnc_animatedScreen;
		[true, ["The U.S. forces were caught by surprise."], 4] spawn BIS_fnc_OM_AS_ShowStaticText;
        uiSleep 4; [3,1,false] call bis_fnc_animatedScreen;
	}], [6,{
        [4,1,false] call bis_fnc_animatedScreen;
		[true, ["Outnumbered and cut off, desperately holding key terrain to buy time for the CDF to reorganize."], 4] spawn BIS_fnc_OM_AS_ShowStaticText;
        uiSleep 4; [3,1,false] call bis_fnc_animatedScreen;
	}], [5,{
        [4,2,false] call bis_fnc_animatedScreen;
		[5,1,"data\03_b.paa",nil,nil,1] call bis_fnc_animatedScreen; [6,1,8,nil,1.1] call bis_fnc_animatedScreen;
		[5,2,"data\03_f.paa",nil,nil,1] call bis_fnc_animatedScreen; [6,2,8,nil,1.2] call bis_fnc_animatedScreen;
        uiSleep 3; [3,2,false] call bis_fnc_animatedScreen;
	}], [6,{
        [4,1,false] call bis_fnc_animatedScreen;
		[true, ["As Chernarus began to fall, its government issued an emergency request for military assistance."], 4] spawn BIS_fnc_OM_AS_ShowStaticText;
        uiSleep 3; [3,2,false] call bis_fnc_animatedScreen;
	}], [4,{  //-- 4 Seconds total
        [30,0,"The 27th MEU will redeploy.", [0.50,0.50],5,[207/255,207/255,207/255,1],0,1.5,0,"PuristaBold"] call BIS_fnc_AnimatedScreen;
        [31,0,1,nil,nil,1] call BIS_fnc_AnimatedScreen;  //-- Mode, layer, fade in
        uiSleep 3;  //-- Wait 3 seconds
        [3,1,false] call bis_fnc_animatedScreen;  //-- fade out, 1 seconds long
    }]
], "darkreach", {[true] call tsp_fnc_role; [] spawn tsp_fnc_spawn_map}] spawn tsp_fnc_intro;  //-- Slides, music, code to run at the end

[player, [
"rhsgref_ins_spotter", "rhsgref_ins_squadleader", "tsp_chdkz_radio", "rhsgref_ins_sniper", "rhsgref_ins_saboteur", "rhsgref_ins_rifleman_aks74", "rhsgref_ins_rifleman_akm", "rhsgref_ins_rifleman_RPG26", "rhsgref_ins_grenadier", "rhsgref_ins_rifleman"
], [zone_zombie], east, {true}, {}, 250, 2, 25, 350] spawn tsp_fnc_zombience;

if (!isServer) exitWith {}; 

[west, "primary", ["Main objective is to Destroy two artillery guns.", "Primary Objectives"], objNull, "CREATED", -1, true, "meet"] call BIS_fnc_taskCreate;
[west, "secondary", ["Secondary objective is to kill or capture a High Value Target.", "Secondary Objective"], objNull, "CREATED", -1, true, "Target"] call BIS_fnc_taskCreate;

[
    west, ["arty", "primary"], "Destroy Artillery", "Your primary objective is to destroy two enemy artillery guns positioned behind the dam. These guns are actively targeting friendly positions at Zelenogorsk and must be eliminated.", 
    "Destroy", getPos task_arties, {true}, {!alive task_arty1 && !alive task_arty2}
] spawn tsp_fnc_task;

[
	west, ["officer", "secondary"], "Kill or Capture HVT", "SIGINT recently picked up radio chatter coming from a VDV officer. Locate and capture or eliminate the guy. Be on the lookout for any important looking blue berets.", 
	"Kill", objNull, {true}, {[task_officer, [zone_capture]] call tsp_fnc_zone_triggers || !alive task_officer}
] spawn tsp_fnc_task;

[
    west, ["extract", "primary"], "Exfiltrate.", "Exfiltrate out of the hot zone before the enemy overwhelms you!", "run", objNull, 
    {count (["arty", "officer"] select {_x call BIS_fnc_taskState == "SUCCEEDED"}) == 2}, {count (allPlayers select {_x inArea trigger_extract}) == 0}, {false}, {false}, 
	{["reinf_air"] spawn tsp_fnc_sector_load; ["reinf_groun"] spawn tsp_fnc_sector_load;}
] spawn tsp_fnc_task;

[
	east, ["mission"], "x", "x", "Attack", objNull, 
	{true}, {count (["arty","extract"] select {_x call BIS_fnc_taskState == "SUCCEEDED"}) == 2}, 
	{false}, {false}, {}, {"end1" remoteExec ["BIS_fnc_endMission", 0]}
] spawn tsp_fnc_task;