player createDiaryRecord ["Diary", ["Mission", "
ChDKZ has stretched their forces thin to achieve this offensive and is at the current time, unable to push further. Unified CDF-USMC command has decided that now is the best time to perform a counter-offensive before ChDKZ have the time to dig in and be reinforced.<br/><br/>	
A USMC task force aboard the USS Khe Sanh will assist CDF in the operation to retake the area.<br/><br/>	
- Recapture Zeleno MB. A majority of ChDKZ forces are likely digging in here, expect a heavy infantry presence backed up by armoured vehicles.<br/><br/>  
- Recapture Green Mountain. The radio station at Green Mountain is a small compound at the top of the hill, surrounded by forest.<br/><br/>  
- CDF reports a heavy concentration of ChDKZ forces at the school in Zelenogorsk, possibly with civilian hostages - neutralise all ChDKZ forces and secure the area.<br/><br/>
- Find and rescue a USMC squad that was stationed in MB Zelenogorsk, as per the last radio contact with the squad, they are five strong and fled into the city.<br/><br/>
- Find and destroy artillery guns.<br/><br/>
- Rescue and render aid to any surviving CDF personnel.<br/><br/>
NAPA cells are also operating in the mountains to the west, so watch your fire.
"]];
player createDiaryRecord ["Diary", ["Enemy", "
ChDKZ have struck a back alley deal with the Russian Federation to back their military actions against the Chernarussian government, to that end, the Russian Federation have supplied the ChDKZ with small arms, munitions and armoured vehicles.<br/><br/>    
They will be likely be using Soviet-era weapons and vehicles, ranging from BMPs to MBTs and even some aircraft.
"]];
player createDiaryRecord ["Diary", ["Situation", "
Following the collapse of the Soviet Union in 1991, Chernarus was among one of the many ex-Soviet territories to regain its independence.
<br/><br/>
However it wasn't without problem; pro-Russian citizens would unite to form an opposition party, the Chernarussian Movement of the Red Star (ChDKZ).
<br/><br/>
ChDKZ and its supporters vowed to challenge the ruling pro-west Party; their ultimate goal being full re-integration with Russia.
<br/><br/>
In response, anti-ChDKZ radicals rallied together to form the National Party (NAPA), vowing to stamp out ChDKZ and its supporters. NAPA rose up in defiance of the spreading pro-Russian sentiment in Chernarus, vandalising, looting and destroying businesses with supposed ties to the ChDKZ.
<br/><br/>
Four months ago, ChDKZ surprised the Chernarussian government by rising in force, using weapons and military vehicles likely supplied by the Russian Federation.
<br/><br/>	
The conflict intensified in rural northern Chernarus as skirmishes between ChDKZ, NAPA and the government escalated into bloody civil war.
<br/><br/>
In the early hours of the morning, ChDKZ forces performed a surprise major offensive into South Zagoria, capturing CDF facilities, routing CDF forces and taking hostages in and around Zelenogorsk.

In 2015, Russia launched a full scale invasion with the goal of 'restoring order', in support of the ChDKZ. Russian soldiers crossed the border into Chernarus from all sides, striking from Takistan, the Green Sea and the Russian border.
"]];

[[
	[5,{
		[4,1,false] call bis_fnc_animatedScreen;
		[true, ["The Green Sea, 2015"]] spawn BIS_fnc_OM_AS_ShowStaticText;
		uiSleep 4; [3,1,false] call bis_fnc_animatedScreen;
	}],	[10,{
		[4,2,false] call bis_fnc_animatedScreen;
		[true, ["Following the collapse of the Soviet Union in 1991, Chernarus was among one of the many ex-Soviet territories to regain its independence."], 4] spawn BIS_fnc_OM_AS_ShowStaticText;
		uiSleep 8; [3,2,false] call bis_fnc_animatedScreen;
	}], [8,{
		[4,2,false] call bis_fnc_animatedScreen;
		[5,1,"tsp_core\data\greensea\statue_b.paa",nil,nil,1] call bis_fnc_animatedScreen; [6,1,8,nil,1.1] call bis_fnc_animatedScreen;
		[5,2,"tsp_core\data\greensea\statue_f.paa",nil,nil,1] call bis_fnc_animatedScreen; [6,2,8,nil,1.2] call bis_fnc_animatedScreen;
		uiSleep 6; [3,2,false] call bis_fnc_animatedScreen;
	}], [10,{
		[4,2,false] call bis_fnc_animatedScreen;
		[true, ["However it wasn't without problem; pro-Russian citizens would unite to form an opposition party, the Chernarussian Movement of the Red Star (ChDKZ)."], 4] spawn BIS_fnc_OM_AS_ShowStaticText;
		uiSleep 8; [3,2,false] call bis_fnc_animatedScreen;
	}], [10,{
		[4,2,false] call bis_fnc_animatedScreen;
		[true, ["ChDKZ and its supporters vowed to challenge the ruling pro-west Party; their ultimate goal being full re-integration with Russia."], 4] spawn BIS_fnc_OM_AS_ShowStaticText;
		uiSleep 8; [3,2,false] call bis_fnc_animatedScreen;
	}], [8,{
		[4,2,false] call bis_fnc_animatedScreen;
		[5,1,"tsp_core\data\greensea\tank_b.paa",nil,nil,1] call bis_fnc_animatedScreen; [6,1,8,nil,1.1] call bis_fnc_animatedScreen;
		[5,2,"tsp_core\data\greensea\tank_f.paa",nil,nil,1] call bis_fnc_animatedScreen; [6,2,8,nil,1.2] call bis_fnc_animatedScreen;
		uiSleep 6; [3,2,false] call bis_fnc_animatedScreen;
	}], [10,{
		[4,2,false] call bis_fnc_animatedScreen;
		[true, ["In response, anti-ChDKZ radicals rallied together to form the National Party (NAPA), vowing to stamp out ChDKZ and its supporters."], 4] spawn BIS_fnc_OM_AS_ShowStaticText;
		uiSleep 8; [3,2,false] call bis_fnc_animatedScreen;
	}],	[8,{
		[4,2,false] call bis_fnc_animatedScreen;
		[5,1,"tsp_core\data\greensea\napa_b.paa",nil,nil,1] call bis_fnc_animatedScreen; [6,1,8,nil,1.1] call bis_fnc_animatedScreen;
		[5,2,"tsp_core\data\greensea\napa_f.paa",nil,nil,1] call bis_fnc_animatedScreen; [6,2,8,nil,1.2] call bis_fnc_animatedScreen;
		uiSleep 6; [3,2,false] call bis_fnc_animatedScreen;
	}], [10,{
		[4,2,false] call bis_fnc_animatedScreen;
		[true, ["Skirmishes between both sides, including Government forces would gradually escalate into bloody civil war."], 4] spawn BIS_fnc_OM_AS_ShowStaticText;
		uiSleep 8; [3,2,false] call bis_fnc_animatedScreen;
	}], [8,{
		[4,2,false] call bis_fnc_animatedScreen;
		[5,1,"tsp_core\data\greensea\cdf.paa",nil,nil,1] call bis_fnc_animatedScreen; [6,1,8,nil,1.1] call bis_fnc_animatedScreen;
		uiSleep 6; [3,2,false] call bis_fnc_animatedScreen;
	}], [10,{
		[4,2,false] call bis_fnc_animatedScreen;
		[true, ["The conflicts were small and limited to rural areas. Until 2015, where ChDKZ grew in both strength and capability, suspected of being supplied by Russia."], 4] spawn BIS_fnc_OM_AS_ShowStaticText;
		uiSleep 8; [3,2,false] call bis_fnc_animatedScreen;
	}], [8,{
		[4,2,false] call bis_fnc_animatedScreen;
		[true, ["In the early hours of the morning, ChDKZ forces performed a surprise major offensive into South Zagoria Taking, capturing CDF facilities and taking hostages."], 4] spawn BIS_fnc_OM_AS_ShowStaticText;
		uiSleep 6; [3,2,false] call bis_fnc_animatedScreen;
	}], [6,{
		[4,2,false] call bis_fnc_animatedScreen;
		[5,1,"tsp_core\data\greensea\zeleno.paa",nil,nil,1] call bis_fnc_animatedScreen; [6,1,8,nil,1.1] call bis_fnc_animatedScreen;
		uiSleep 4; [3,2,false] call bis_fnc_animatedScreen;
	}]
], "balalaika", {}] spawn tsp_fnc_intro;

if (!isServer) exitWith {};

[
	west, ["zeleno"], "Zeleno MB", "Recapture Zeleno MB. A majority of ChDKZ forces are likely digging in here, expect a heavy infantry presence backed up by armoured vehicles.", "Attack", "sector_mb", 
	{true}, {["mb_close", "", sector_mb, 100] call tsp_fnc_sector_clear}
] spawn tsp_fnc_task;
[
	west, ["green"], "Green Mountain", "Recapture Green Mountain. The radio station at Green Mountain is a small compound at the top of the hill, surrounded by forest, ChDKZ took the location but it is unknown what garrison may currenty be present there.", "Attack", "sector_green", 
	{true}, {["green", "", sector_green, 100] call tsp_fnc_sector_clear}
] spawn tsp_fnc_task;
[
	west, ["school"], "School", "CDF reports a heavy concentration of ChDKZ forces at the school in Zelenogorsk, possibly with civilian hostages - neutralise all ChDKZ forces and secure the area.", "Attack", "sector_school", 
	{true}, {["school", "", sector_school, 100] call tsp_fnc_sector_clear}
] spawn tsp_fnc_task;
[
	west, ["usmc"], "Find USMC Squad", " Find and rescue a USMC squad that was stationed in MB Zelenogorsk, as per the last radio contact with the squad, they are five strong and fled into the city.", "meet", "sector_police_close", 
	{true}, {["police_close", "", sector_police_close, 100] call tsp_fnc_sector_clear}
] spawn tsp_fnc_task;
[
	west, ["radar"], "Destroy Artillery", "ChDKZ could not have executed this offensive without artillery support, there are civilian reports of 3 artillery guns around the Tishina dam, find and destroy them. A NAPA cell is also operating in the area, so watch your fire.", "Destroy", "sector_dam", 
	{true}, {!alive task_arti1 && !alive task_arti2 && !alive task_arti3}
] spawn tsp_fnc_task;