/*In For a Penny

Situation
The year is 2019, Sefrou-Ramal, a region of Sefrawi is firmly under the Tura's control, and vital economic interests in the region are at risk of falling into the hands of non-state actors. United Nations peacekeepers and the local military, understrength and overburdened by the humanitarian crisis, can do little to stop the fighting.

In the midst of this chaos, an IoN security team was hired by the Sefrawi government to protect regional assets owned by the Daltgreen Mining & Exploration company. However, this contract pales in comparison of IoN's secret and more profitable venture; smuggling blood diamonds out of the county. 

Enemy
One of the many tribes of the Sefrawi Desert, the Tura were historically nomads and caravan raiders. Due to the effects of climate change resulting in water shortages and poor economic conditions throughout the region, the Tura have begun to adopt modern lifestyles, and assimilating themselves into the region's urban centres.

However, following their successful armed uprising, the Tura have managed to wrestle control of the Sefrou-Ramal region from the local government. With the assistance of other non-state actor groups, they have solidified their grip over much of the region.

They are led by Arib Said, the chief and leader of the Tura tribes. Little is known about his past, save for rumours that he may have ties to the notorious (former) leader of the Tanoan criminal organisation, the Syndikat, and that he was directly involved in the failed Red Tiger coup d'etat many years ago. Under his leadership, the Tura have been steadily gaining influence, having since become a major player in regional affairs.

Additionally, tensions between IoN and the local mlitary are at an all time high. Be wary around them as there have been numerous "friendly fire" incidents prior, their ranks aren't to be trusted, especially within their paramilitary force. 

Mission
Tura forces have leveraged the current sandstorm to sneak up on multiple Daltgreen locations.

The mining site at grid [XXX] is currently under siege by a large contingent of Tura forces, Team Shield are already on location but require immediate reinforcement to avoid being overrrun.

Simultaneously, contact was lost with a joined UN/IoN convoy escorting boxxite trucks at grid [XXX], the convoy was also secretly smuggling $10,000,000 dollars worth in blood diamonds out of the country in an IoN marked KAMAZ.

Your mission is to first support Team Sword in securing the drilling site, once secured, you need to locate the IoN truck and safely extract the diamonds. Word about this can't get out, if any of UN soldiers from the convoy find out about the diamonds, they must be eliminated. Extraction of the 2 IoN personnel is secondary and optional.
*/

[[
	[3,{}], [5,{
		[4,2,false] call bis_fnc_animatedScreen;
		[true, ["Sefrawi, 2019"]] spawn BIS_fnc_OM_AS_ShowStaticText;
		uiSleep 3; [3,2,false] call bis_fnc_animatedScreen;
	}],	[8,{
		[4,2,false] call bis_fnc_animatedScreen;
		[true, ["Sefrou-Ramal is firmly under the Tura's control, and vital economic interests in the region are at risk of falling into the hands of non-state actors."], 4] spawn BIS_fnc_OM_AS_ShowStaticText;
		uiSleep 6; [3,2,false] call bis_fnc_animatedScreen;
	}],	[5,{
		[4,2,false] call bis_fnc_animatedScreen;
		[5,1,"\tsp_core\data\sahara\01_b.paa",nil,nil,1] call bis_fnc_animatedScreen; [6,1,8,nil,1.1] call bis_fnc_animatedScreen;
		[5,2,"\tsp_core\data\sahara\01_f.paa",nil,nil,1] call bis_fnc_animatedScreen; [6,2,8,nil,1.2] call bis_fnc_animatedScreen;
		uiSleep 3; [3,2,false] call bis_fnc_animatedScreen;
	}], [8,{
		[4,2,false] call bis_fnc_animatedScreen;
		[true, ["United Nations peacekeepers and the local military, understrength and overburdened by the humanitarian crisis, can do little to stop the fighting."], 4] spawn BIS_fnc_OM_AS_ShowStaticText;
		uiSleep 6; [3,2,false] call bis_fnc_animatedScreen;
	}], [5,{
		[4,2,false] call bis_fnc_animatedScreen;
		[5,1,"\tsp_core\data\sahara\02_b.paa",nil,nil,1] call bis_fnc_animatedScreen; [6,1,8,nil,1.1] call bis_fnc_animatedScreen;
		[5,2,"\tsp_core\data\sahara\02_f.paa",nil,nil,1] call bis_fnc_animatedScreen; [6,2,8,nil,1.2] call bis_fnc_animatedScreen;
		uiSleep 3; [3,2,false] call bis_fnc_animatedScreen;
	}], [8,{
		[4,2,false] call bis_fnc_animatedScreen;
		[true, ["In the midst of this chaos, an IoN security team was hired by the Sefrawi government to protect regional assets owned by the Daltgreen Mining & Exploration company."], 4] spawn BIS_fnc_OM_AS_ShowStaticText;
		uiSleep 6; [3,2,false] call bis_fnc_animatedScreen;
	}],	[5,{
		[4,2,false] call bis_fnc_animatedScreen;
		[5,1,"\tsp_core\data\sahara\03_b.paa",nil,nil,1] call bis_fnc_animatedScreen; [6,1,8,nil,1.1] call bis_fnc_animatedScreen;
		[5,2,"\tsp_core\data\sahara\03_f.paa",nil,nil,1] call bis_fnc_animatedScreen; [6,2,8,nil,1.2] call bis_fnc_animatedScreen;
		uiSleep 3; [3,2,false] call bis_fnc_animatedScreen;
	}], [8,{
		[4,2,false] call bis_fnc_animatedScreen;
		[true, ["However, this contract pales in comparison of IoN's secret and more profitable venture; smuggling blood diamonds out of the county."], 4] spawn BIS_fnc_OM_AS_ShowStaticText;
		uiSleep 6; [3,2,false] call bis_fnc_animatedScreen;
	}], [5,{
		[4,2,false] call bis_fnc_animatedScreen;
		[5,1,"\tsp_core\data\sahara\04_b.paa",nil,nil,1] call bis_fnc_animatedScreen; [6,1,8,nil,1.1] call bis_fnc_animatedScreen;
		[5,2,"\tsp_core\data\sahara\04_f.paa",nil,nil,1] call bis_fnc_animatedScreen; [6,2,8,nil,1.2] call bis_fnc_animatedScreen;
		uiSleep 3; [3,2,false] call bis_fnc_animatedScreen;
	}]
], "Music_FreeRoam_Russian_Theme", {[true] call tsp_fnc_role; [] spawn tsp_fnc_spawn_map}] spawn tsp_fnc_intro;

if (!isServer) exitWith {};
[west, ["doors"], "Close Doors", "The latest weather report indicates that a severe sandstorm is rolling in, close up the barracks before it arrives.", 
"Radio", getPos task_radio, {alive task_radio}, {false}, {false}, {true}] spawn tsp_fnc_task;
[west, ["radio"], "Fix Antenna", "The radio at the top of the hill is acting up again, go and have a look, we need to re-establish comms with the convoy.", 
"Radio", getPos task_radio, {alive task_radio}, {false}, {false}, {true}] spawn tsp_fnc_task;
[west, ["bravo"], "Defend Site Bravo", "The mining site at grid [XXX] is currently under siege by a large contingent of Tura forces and they require assistance.", 
"Radio", getPos task_bravo, {false}, {false}, {false}, {true}] spawn tsp_fnc_task;
[west, ["shield","bravo"], "Reinforce Team Shield", "Team Shield are already on location but require immediate reinforcement to avoid being overrrun.", 
"Radio", getPos task_shield, {alive task_shield}, {!alive task_shield}, {false}, {true}] spawn tsp_fnc_task;
[west, ["mortar","bravo"], "Find and Destroy Mortar Team", "Site Bravo is taking accurate mortar fire, find and destroy the mortar team before they can do any more damage.", 
"Radio", getPos task_mortar, {!alive task_mortar}, {false}, {false}, {true}] spawn tsp_fnc_task;
[west, ["convoy"], "Locate Convoy", "Contact was lost with the joined UN/IoN convoy escorting boxxite trucks at grid [XXX], the convoy was also secretly smuggling $10,000,000 dollars worth in blood diamonds out of the country in an IoN marked KAMAZ. Investigate their last known location.", 
"Radio", getPos task_bravo, {false}, {false}, {false}, {true}] spawn tsp_fnc_task;
[west, ["truck"], "Find IoN Truck", "The IoN truck isn't at the ambush site, search for and pursue any clues as to it's whereabouts.", 
"Radio", getPos task_bravo, {false}, {false}, {false}, {true}] spawn tsp_fnc_task;
[west, ["diamonds"], "Locate the Diamonds", "It seems the Tura went South with the diamonds, head South and find them. Talk to the locals if you have to.", 
"Radio", getPos task_bravo, {false}, {false}, {false}, {true}] spawn tsp_fnc_task;
[west, ["diamonds2"], "Extract the Diamonds", "Return the diamonds safely back to base.", 
"Radio", getPos task_bravo, {false}, {false}, {false}, {true}] spawn tsp_fnc_task;

tsp_fnc_say = {
	params ["_unit", ["_type", "AUTO"]];
	RADIO MESSAGE || SUBTITLE
	DEAD SHOULD CANCEL
};