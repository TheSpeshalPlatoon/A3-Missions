if (!isServer) exitWith {};
tsp_cond_prep = {true};
tsp_cond_airfield = {true};
tsp_cond_airfield_defend = {true};
tsp_cond_road = {true};
tsp_cond_green = {true};
tsp_cond_infra = {true};

tsp_cond_prep = {count (["radio","aaa","port","heli","prison"] select {_x call BIS_fnc_taskState in ["SUCCEEDED","FAILED"]}) == 5};
tsp_cond_airfield = {count (["airfield_checkpoint","airfield_fob","airfield_hangars","airfield_atc","airfield_terminal","airfield_defend"] select {_x call BIS_fnc_taskState in ["SUCCEEDED","FAILED"]}) == 6};
tsp_cond_airfield_defend = {count (["airfield_checkpoint","airfield_fob","airfield_hangars","airfield_atc","airfield_terminal"] select {_x call BIS_fnc_taskState in ["SUCCEEDED","FAILED"]}) == 5};
tsp_cond_road = {count (["overpass","highway","hill"] select {_x call BIS_fnc_taskState in ["SUCCEEDED","FAILED"]}) == 3};
tsp_cond_green = {count (["green_checkpoint","green_embassy","green_palace","green_parade","green_mansion","green_hvt"] select {_x call BIS_fnc_taskState in ["SUCCEEDED","FAILED"]}) == 6};
tsp_cond_infra = {count (["power","refinery"] select {_x call BIS_fnc_taskState in ["SUCCEEDED","FAILED"]}) == 2};
tsp_cond_mountains = {count (["military","almawt", "kandah"] select {_x call BIS_fnc_taskState in ["SUCCEEDED","FAILED"]}) == 3};

[west,["prep"],"Preparation","Prepare the AO around the airfield and along the beach.","Move",objNull,{true},{call tsp_cond_prep}] spawn tsp_fnc_task;
[west,["radio","prep"],"Destroy Radio Tower","Destroy a radio tower to deny the enemy comms.","Destroy","sector_radio",{["prep"] call BIS_fnc_taskExists},{!alive ("task_radio" call tsp_fnc_sector_variable)}] spawn tsp_fnc_task;
[west,["aaa","prep"],"Destroy AAA","Destroy a AAA asset hiding somewhere in Karkanak.","Destroy","sector_karkanak",{["prep"] call BIS_fnc_taskExists},{!alive ("task_aaa" call tsp_fnc_sector_variable)}] spawn tsp_fnc_task;
[west,["port","prep"],"Secure Port","Secure the port area.","Attack","sector_port",{["prep"] call BIS_fnc_taskExists},{["port","",sector_port,500,2] call tsp_fnc_sector_clear}] spawn tsp_fnc_task;
[west,["heli","prep"],"Rescue Crew","Rescue the crew of a downed AH-1Z somewhere along the Kahak river.","Heli",objNull,{["prep"] call BIS_fnc_taskExists},{count ([lpd,cvn] select {("task_heli" call tsp_fnc_sector_variable) distance _x < 100}) > 0},{!alive ("task_heli" call tsp_fnc_sector_variable)}] spawn tsp_fnc_task;
[west,["prison","prep"],"Investigate Prison","Investigate the prison, there are reports that all inmates were released.","Search","sector_prison",{["prep"] call BIS_fnc_taskExists},{["prison","",sector_prison] call tsp_fnc_sector_clear}] spawn tsp_fnc_task;

[west,["airfield"],"Airfield","Secure the airfield.","Move1",objNull,{call tsp_cond_prep},{call tsp_cond_airfield},{false},{false},
	{["%usmc_airfield"] spawn tsp_fnc_sector_load; {_x setMarkerAlpha 1} forEach (getMissionLayerEntities "%usmc_airfield")#1; [west, "HQ"] sideChat "HQ to all callsigns, the invasion force is in the water!"},
	{[] spawn {waitUntil {sleep 1; count (playableUnits select {_x inArea usmc_airfield_despawn}) == 0}; ["%usmc_airfield"] spawn tsp_fnc_sector_save; {_x setMarkerAlpha 0} forEach (getMissionLayerEntities "%usmc_green")#1}}
] spawn tsp_fnc_task;
[west,["airfield_checkpoint","airfield"],"Checkpoint","Secure the checkpoint.","Attack","sector_airfield_gate_close",{["airfield"] call BIS_fnc_taskExists},{["airfield_gate_close","",sector_airfield_gate_close] call tsp_fnc_sector_clear}] spawn tsp_fnc_task;
[west,["airfield_fob","airfield"],"FOB","Secure the FOB.","Attack","sector_airfield_fob_close",{["airfield"] call BIS_fnc_taskExists},{["airfield_fob_close","",sector_airfield_fob_close] call tsp_fnc_sector_clear}] spawn tsp_fnc_task;
[west,["airfield_hangars","airfield"],"Hangars","Secure the hangars.","Plane","sector_airfield_hangars",{["airfield"] call BIS_fnc_taskExists},{["airfield_hangars","",sector_airfield_hangars,200] call tsp_fnc_sector_clear}] spawn tsp_fnc_task;
[west,["airfield_atc","airfield"],"ATC","Secure the ATC.","Attack","sector_airfield_central",{["airfield"] call BIS_fnc_taskExists},{["airfield_central","",sector_airfield_central,100] call tsp_fnc_sector_clear}] spawn tsp_fnc_task;
[west,["airfield_terminal","airfield"],"Terminal","Secure the terminal.","Search","sector_airfield_terminal",{["airfield"] call BIS_fnc_taskExists},{["airfield_terminal","",sector_airfield_terminal,100] call tsp_fnc_sector_clear}] spawn tsp_fnc_task;
[west,["airfield_defend","airfield"],"Defend","Defend the airfield from reinforcments.","Defend","sector_airfield_terminal",{call tsp_cond_airfield_defend},{["airfield_reinf","airfield_reinf",sector_airfield,2000,8] call tsp_fnc_sector_clear}] spawn tsp_fnc_task;

[west,["road"],"Secure Road","Clear the road and surrounding area up to Farabad.","Move2",objNull,{call tsp_cond_airfield},{call tsp_cond_road}] spawn tsp_fnc_task;
[west,["overpass","road"],"Clear Overpass","Clear the overpass.","Attack","sector_overpass",{["road"] call BIS_fnc_taskExists},{["overpass","overpass",sector_overpass,0,1] call tsp_fnc_sector_clear}] spawn tsp_fnc_task;
[west,["highway","road"],"Clear Road","Clear the road up to Farabad.","Attack","sector_highway",{["road"] call BIS_fnc_taskExists},{["highway","highway",sector_highway,0,2] call tsp_fnc_sector_clear}] spawn tsp_fnc_task;
[west,["hill","road"],"Secure Hilltop","Intel suggests that TKA special forces have set up artillery and ATGM positions on this hill, secure it so we can move into Farabad safely.","Attack","sector_hill_close",{["road"] call BIS_fnc_taskExists},{["hill_close","",sector_hill_close,0,1] call tsp_fnc_sector_clear}] spawn tsp_fnc_task;

[west,["green"],"Green Zone","Secure the green zone.","Move3",objNull,{call tsp_cond_road},{call tsp_cond_green},{false},{false},
	{["%usmc_green"] spawn tsp_fnc_sector_load; {_x setMarkerAlpha 1} forEach (getMissionLayerEntities "%usmc_green")#1; [west, "HQ"] sideChat "All units be advised, friendly units are moving on Green Zone."},
	{
		[] spawn {waitUntil {sleep 1; count (playableUnits select {_x inArea usmc_green_despawn}) == 0}}; 
		["%usmc_green"] spawn tsp_fnc_sector_save; 
		{_x setMarkerAlpha 0} forEach (getMissionLayerEntities "%usmc_green")#1;
		{_x setMarkerAlpha 1} forEach (getMissionLayerEntities "%FARP")#1;
		[west, "HQ"] sideChat "Be advised, a FARP has been established at Karkanak";
	}
] spawn tsp_fnc_task;
[west,["green_checkpoint","green"],"Checkpoint","Secure the military checkpoint.","Attack","sector_green_checkpoint_close",{["green"] call BIS_fnc_taskExists},{["green_checkpoint_close","",sector_green_checkpoint_close] call tsp_fnc_sector_clear}] spawn tsp_fnc_task;
[west,["green_embassy","green"],"Embassy","Secure the embassy compound.","Attack","sector_green_embassy_close",{["green"] call BIS_fnc_taskExists},{["green_embassy_close","",sector_green_embassy_close,0,2] call tsp_fnc_sector_clear}] spawn tsp_fnc_task;
[west,["green_palace","green"],"Palace","Secure the presidential palace.","Attack","sector_green_palace_close",{["green"] call BIS_fnc_taskExists},{["green_palace_inside","",sector_green_palace_close,0,1] call tsp_fnc_sector_clear}] spawn tsp_fnc_task;
[west,["green_parade","green"],"Parade Grounds","Secure the parade grounds.","Attack","sector_green_parade",{["green"] call BIS_fnc_taskExists},{["green_parade","",sector_green_parade,100,1] call tsp_fnc_sector_clear}] spawn tsp_fnc_task;
[west,["green_mansion","green"],"Mansion","Secure the presidential mansion.","Attack","sector_green_mansion_close",{["green"] call BIS_fnc_taskExists},{["green_mansion_close","",sector_green_mansion_close] call tsp_fnc_sector_clear}] spawn tsp_fnc_task;
[west,["green_hvt","green"],"Kill/Capture President","Kill/Capture the President.","Kill",objNull,{["green"] call BIS_fnc_taskExists},{!alive ("task_hvt" call tsp_fnc_sector_variable) || ("task_hvt" call tsp_fnc_sector_variable) distance lpd < 100 || ("task_hvt" call tsp_fnc_sector_variable) distance cvn < 100}] spawn tsp_fnc_task;

[west,["infra"],"Infrastructure","Secure the green zone.","Move4",objNull,{call tsp_cond_green},{call tsp_cond_infra}] spawn tsp_fnc_task;
[west,["resovoir","infra"],"Secure Resovoir","Secure the Resovoir.","Attack","sector_resovoir",{["infra"] call BIS_fnc_taskExists},{["resovoir","",sector_resovoir,0,2] call tsp_fnc_sector_clear}] spawn tsp_fnc_task;
[west,["refinery","infra"],"Secure Refinery","Secure the oil refinery.","Attack","sector_refinery",{["infra"] call BIS_fnc_taskExists},{["refinery","",sector_refinery,0,2] call tsp_fnc_sector_clear}] spawn tsp_fnc_task;

[west,["mountains"],"Mountains","Secure the mountains north of Farabad.","Move5",objNull,{call tsp_cond_infra},{call tsp_cond_mountains}] spawn tsp_fnc_task;
[west,["military","mountains"],"Secure Military Base","Secure the military base.","Attack","sector_military_close",{["mountains"] call BIS_fnc_taskExists},{["military","",sector_military,0,4] call tsp_fnc_sector_clear}] spawn tsp_fnc_task;
[west,["almawt","mountains"],"Secure Almawt Pass","TKA SF and insurgents are gathering in the mountains to the north, flush them out before they can organize.","Attack","sector_almawt",{["mountains"] call BIS_fnc_taskExists},{["almawt","",sector_almawt,0,8] call tsp_fnc_sector_clear}] spawn tsp_fnc_task;
[west,["kandah","mountains"],"Destroy Caches","Insurgents are gathering supplies in and around Kandah, secure the area and destroy and weapons caches.","Destroy","sector_kandah",{["mountains"] call BIS_fnc_taskExists},{!alive ("task_cache1" call tsp_fnc_sector_variable) && !alive ("task_cache2" call tsp_fnc_sector_variable) && !alive ("task_cache3" call tsp_fnc_sector_variable) && !alive ("task_cache4" call tsp_fnc_sector_variable)}] spawn tsp_fnc_task;

/*
briefing
intro
