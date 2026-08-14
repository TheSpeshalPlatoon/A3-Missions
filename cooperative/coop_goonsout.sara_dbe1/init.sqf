if (!isServer) exitWith {};

[
	east, "ixel", "Secure Ixel", "RACS forces have a checkpoint in Ixel, secure it.", 
	"Attack", "sector_ixel", {true}, {["ixel", "", sector_ixel, 50] call tsp_fnc_sector_clear}
] spawn tsp_fnc_task;
[
	east, "masbete", "Secure Masbete", "RACS forces have occupied Masbete, secure it.", 
	"Attack", "sector_masbete", {true}, {["masbete", "", sector_masbete] call tsp_fnc_sector_clear}
] spawn tsp_fnc_task;
[
	east, "arti", "Destroy Artillery", "The scouts report at least 2 M109 howitzers operating out of Masbete, find and destroy them.", 
	"Destroy", objNull, {true}, {!alive task_arti1 && !alive task_arti2}
] spawn tsp_fnc_task;