if (!isServer) exitWith {};

tsp_cond_prep = {count (["radio", "aaa", "port", "heli", "prison"] select {_x call BIS_fnc_taskState in ["SUCCEEDED", "FAILED"]}) == 5};
tsp_cond_prep = {true};
tsp_cond_airfield = {count (["airfield_checkpoint", "airfield_hangars", "airfield_terminal", "airfield_fob", "airfield_atc", "airfield_defend"] select {_x call BIS_fnc_taskState in ["SUCCEEDED", "FAILED"]}) == 6};
tsp_cond_airfield2 = {count (["airfield_checkpoint", "airfield_hangars", "airfield_terminal", "airfield_fob", "airfield_atc"] select {_x call BIS_fnc_taskState in ["SUCCEEDED", "FAILED"]}) == 5};
tsp_cond_airfield = {true};
tsp_cond_airfield2 = {true};
tsp_cond_green = {count (["green_embassy", "green_palace", "green_mansion", "green_parade", "green_checkpoint", "green_hvt"] select {_x call BIS_fnc_taskState in ["SUCCEEDED", "FAILED"]}) == 6};

[west, ["radio"], "Destroy Radio Tower", "Destroy a radio tower to deny the enemy comms.", "Destroy", "sector_radio", {true}, {!alive ("task_radio" call tsp_fnc_sector_variable)}] spawn tsp_fnc_task;
[west, ["aaa"], "Destroy AAA", "Destroy a AAA asset hiding somewhere in Karkanak.", "Destroy", "sector_karkanak", {true}, {!alive ("task_aaa" call tsp_fnc_sector_variable)}] spawn tsp_fnc_task;
[west, ["port"], "Secure Port", "Secure the port area.", "Attack", "sector_port", {true}, {["port", "", sector_port, 500] call tsp_fnc_sector_clear}] spawn tsp_fnc_task;
[west, ["heli"], "Rescue Crew","Rescue the crew of a downed AH-1Z somewhere along the Kahak river.", "Heli", objNull, {true}, {count ([lpd, cvn] select {("task_heli" call tsp_fnc_sector_variable) distance _x < 100}) > 0}, {!alive ("task_heli" call tsp_fnc_sector_variable)}] spawn tsp_fnc_task;
[west, ["prison"], "Investigate Prison", "Investigate the prison, there are reports that all inmates were released.", "Search", "sector_prison", {true}, {["prison", "", sector_prison] call tsp_fnc_sector_clear}] spawn tsp_fnc_task;

[west, ["airfield"], "Airfield", "Secure the airfield.", "Plane", objNull, {call tsp_cond_prep}, {call tsp_cond_airfield}] spawn tsp_fnc_task;
[west, ["airfield_checkpoint","airfield"], "Checkpoint", "Secure the checkpoint.", "Attack", "sector_airfield_gate_close", {call tsp_cond_prep}, {["airfield_gate", "", sector_airfield_gate_close] call tsp_fnc_sector_clear}] spawn tsp_fnc_task;
[west, ["airfield_hangars","airfield"], "Hangars", "Secure the hangars.", "Attack", "sector_airfield_hangars", {call tsp_cond_prep}, {["airfield_hangars", "", sector_airfield_hangars, 200] call tsp_fnc_sector_clear}] spawn tsp_fnc_task;
[west, ["airfield_terminal","airfield"], "Terminal", "Secure the terminal.", "Attack", "sector_airfield_terminal", {call tsp_cond_prep}, {["airfield_terminal", "", sector_airfield_terminal, 100] call tsp_fnc_sector_clear}] spawn tsp_fnc_task;
[west, ["airfield_fob","airfield"], "FOB", "Secure the FOB.", "Attack", "sector_airfield_fob_close", {call tsp_cond_prep}, {["airfield_fob_close", "", sector_airfield_fob_close] call tsp_fnc_sector_clear}] spawn tsp_fnc_task;
[west, ["airfield_atc","airfield"], "ATC", "Secure the ATC.", "Attack", "sector_airfield_central", {call tsp_cond_prep}, {["airfield_central", "", sector_airfield_central, 100] call tsp_fnc_sector_clear}] spawn tsp_fnc_task;
[west, ["airfield_defend","airfield"], "Defend", "Defend the airfield from reinforcments.", "Defend", "sector_airfield_terminal", {call tsp_cond_airfield2}, {["airfield_reinf", "airfield_reinf", sector_airfield, 2000, 8] call tsp_fnc_sector_clear}] spawn tsp_fnc_task;

[west, ["green"], "Green Zone", "Secure the green zone.", "Attack", objNull, {call tsp_cond_airfield}, {call tsp_cond_green}] spawn tsp_fnc_task;
[west, ["green_embassy","green"], "Embassy", "Secure the embassy compound.", "Attack", "sector_green_embassy_close", {call tsp_cond_airfield}, {["green_embassy_close", "", sector_green_embassy_close] call tsp_fnc_sector_clear}] spawn tsp_fnc_task;
[west, ["green_palace","green"], "Palace", "Secure the presidential palace.", "Attack", "sector_green_palace_close", {call tsp_cond_airfield}, {["green_palace_inside", "", sector_green_palace_close] call tsp_fnc_sector_clear}] spawn tsp_fnc_task;
[west, ["green_mansion","green"], "Mansion", "Secure the presidential mansion.", "Attack", "sector_green_mansion_close", {call tsp_cond_airfield}, {["green_mansion_close", "", sector_green_mansion_close] call tsp_fnc_sector_clear}] spawn tsp_fnc_task;
[west, ["green_parade","green"], "Parade Grounds", "Secure the parade grounds.", "Attack", "sector_green_parade", {call tsp_cond_airfield}, {["green_parade", "", sector_green_parade, 100] call tsp_fnc_sector_clear}] spawn tsp_fnc_task;
[west, ["green_checkpoint","green"], "Checkpoint", "Secure the military checkpoint.", "Attack", "sector_green_checkpoint_close", {call tsp_cond_airfield}, {["green_checkpoint_close", "", sector_green_checkpoint_close] call tsp_fnc_sector_clear}] spawn tsp_fnc_task;
[west, ["green_hvt","green"], "Kill/Capture President", "Kill/Capture the President.", "Kill", objNull, {call tsp_cond_airfield}, {!alive ("task_hvt" call tsp_fnc_sector_variable) || ("task_hvt" call tsp_fnc_sector_variable) distance lpd < 100 || ("task_hvt" call tsp_fnc_sector_variable) distance cvn < 100}] spawn tsp_fnc_task;