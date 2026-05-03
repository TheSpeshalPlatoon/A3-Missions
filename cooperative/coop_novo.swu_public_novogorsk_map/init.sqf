[[
	[3,{}], [5,{
        playMusic "balalaika";
		[4,2,false] call bis_fnc_animatedScreen;
		[true, ["Chernarus-Takistan Border, 2015"]] spawn BIS_fnc_OM_AS_ShowStaticText;
		uiSleep 3; [3,2,false] call bis_fnc_animatedScreen;
	}],	[10,{
		[4,2,false] call bis_fnc_animatedScreen;
		[true, ["Following the collapse of the Soviet Union in 1991, Chernarus was amongst one of the many ex-Soviet territories to regain its independence."], 4] spawn BIS_fnc_OM_AS_ShowStaticText;
		uiSleep 8; [3,2,false] call bis_fnc_animatedScreen;
	}], [5,{
		[4,2,false] call bis_fnc_animatedScreen;
		[5,1,"data\01_b.paa",nil,nil,1] call bis_fnc_animatedScreen; [6,1,8,nil,1.1] call bis_fnc_animatedScreen;
		[5,2,"data\01_f.paa",nil,nil,1] call bis_fnc_animatedScreen; [6,2,8,nil,1.2] call bis_fnc_animatedScreen;
		uiSleep 3; [3,2,false] call bis_fnc_animatedScreen;
	}], [10,{
		[4,2,false] call bis_fnc_animatedScreen;
		[true, ["However, pro-Russian citizens would unite to form an opposition party as the so-called Chernarussian Movement of the Red Star (ChDKZ)."], 4] spawn BIS_fnc_OM_AS_ShowStaticText;
		uiSleep 8; [3,2,false] call bis_fnc_animatedScreen;
	}], [10,{
		[4,2,false] call bis_fnc_animatedScreen;
		[true, ["The ChDKZ and its supporters vowed to challenge the ruling pro-West Party; their ultimate goal being full integration with Russia."], 4] spawn BIS_fnc_OM_AS_ShowStaticText;
		uiSleep 8; [3,2,false] call bis_fnc_animatedScreen;
	}], [6,{
		[4,2,false] call bis_fnc_animatedScreen;
		[5,1,"data\02_b.paa",nil,nil,1] call bis_fnc_animatedScreen; [6,1,8,nil,1.1] call bis_fnc_animatedScreen;
		[5,2,"data\02_f.paa",nil,nil,1] call bis_fnc_animatedScreen; [6,2,8,nil,1.2] call bis_fnc_animatedScreen;
		uiSleep 4; [3,2,false] call bis_fnc_animatedScreen;
	}], [10,{
		[4,2,false] call bis_fnc_animatedScreen;
		[true, ["In response to its rise, anti-ChDKZ radicals rallied together to form the National Party (NAPA), vowing to stamp out the ChDKZ and its supporters."], 4] spawn BIS_fnc_OM_AS_ShowStaticText;
		uiSleep 8; [3,2,false] call bis_fnc_animatedScreen;
	}],	[6,{
		[4,2,false] call bis_fnc_animatedScreen;
		[5,1,"data\03_b.paa",nil,nil,1] call bis_fnc_animatedScreen; [6,1,8,nil,1.1] call bis_fnc_animatedScreen;
		[5,2,"data\03_f.paa",nil,nil,1] call bis_fnc_animatedScreen; [6,2,8,nil,1.2] call bis_fnc_animatedScreen;
		uiSleep 4; [3,2,false] call bis_fnc_animatedScreen;
	}], [10,{
		[4,2,false] call bis_fnc_animatedScreen;
		[true, ["Skirmishes between supporters on both sides, including Government forces would gradually escalate into bloody civil war."], 4] spawn BIS_fnc_OM_AS_ShowStaticText;
		uiSleep 8; [3,2,false] call bis_fnc_animatedScreen;
	}], [6,{
		[4,2,false] call bis_fnc_animatedScreen;
		[5,1,"data\04_b.paa",nil,nil,1] call bis_fnc_animatedScreen; [6,1,8,nil,1.1] call bis_fnc_animatedScreen;
		[5,2,"data\04_b.paa",nil,nil,1] call bis_fnc_animatedScreen; [6,2,8,nil,1.2] call bis_fnc_animatedScreen;
		uiSleep 4; [3,2,false] call bis_fnc_animatedScreen;
	}], [8,{
		[4,2,false] call bis_fnc_animatedScreen;
		[true, ["In 2015, Russia launched a full scale invasion with the goal of 'restoring order', in support of the ChDKZ."], 4] spawn BIS_fnc_OM_AS_ShowStaticText;
		uiSleep 6; [3,2,false] call bis_fnc_animatedScreen;
	}], [10,{
		[4,2,false] call bis_fnc_animatedScreen;
		[true, ["Russian soldiers crossed the border into Chernarus from all sides, striking from Takistan, the Green Sea and the Russian border."], 4] spawn BIS_fnc_OM_AS_ShowStaticText;
		uiSleep 8; [3,2,false] call bis_fnc_animatedScreen;
	}], [8,{
		[4,2,false] call bis_fnc_animatedScreen;
		[5,1,"data\05_b.paa",nil,nil,1] call bis_fnc_animatedScreen; [6,1,8,nil,1.1] call bis_fnc_animatedScreen;
		[5,2,"data\05_f.paa",nil,nil,1] call bis_fnc_animatedScreen; [6,2,8,nil,1.2] call bis_fnc_animatedScreen;
		uiSleep 6; [3,2,false] call bis_fnc_animatedScreen;
	}]
], {[true] call tsp_fnc_map; 5 fadeMusic 0; sleep 5; playMusic ""; 5 fadeMusic 1}] spawn tsp_fnc_intro;

if (!isServer) exitWith {};

tsp_fnc_arti = {
	params ["_unit", "_area", ["_time", 30]];
	while {sleep ((random _time) + _time); alive _unit} do {
		_pos = _area call BIS_fnc_randomPosTrigger;
		if (count ((_pos nearEntities ["Man", 200]) select {isPlayer _x}) > 0) then {continue};
		_unit doArtilleryFire [_pos, "rhs_mag_3of56_10", 3];
		_unit setVehicleAmmo 1;
	};
};

[arti1, area1] spawn tsp_fnc_arti;
[arti2, area2] spawn tsp_fnc_arti;