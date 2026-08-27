if (!isServer) exitWith {};

[
    west, ["raid"], "Rural Village", "Raid the Village.", 
    "Attack", getPos laptop_intel, {true}, {"intel" call BIS_fnc_taskState in ["SUCCEEDED"] && "cache" call BIS_fnc_taskState in ["SUCCEEDED"]}
] spawn tsp_fnc_task;
[
	west, ["intel","raid"], "Find Intel", "They are using this village as a small logistics hub. Look for any files either digital or physical.", 
	"Download", objNull, {true}, {!isNil "tsp_laptop_intel"}, {false}
] spawn tsp_fnc_task;
[
    west, ["cache","raid"], "Secure contraband items", "Its a logistics hub, Find and seize any caches.",
    "Box", objnull, {true}, {!isNil "tsp_contraband"}, {false}
] spawn tsp_fnc_task;
[
    west, ["meetup"], "drop off intel", "head to camp zulu and talk to officer petros and await further orders.", 
    "Meet", getPos petros, {"raid" call BIS_fnc_taskState == "SUCCEEDED"}, {!isNil "tsp_petros"}, {false}
] spawn tsp_fnc_task;
[
    West, ["coraros"], "Take back the town", "Regain control of coraros and bring order to chaos.",
    "Attack", objnull, {"meetup" call BIS_fnc_taskState == "SUCCEEDED"}, {"bomb1" call BIS_fnc_taskState in ["SUCCEEDED"] && "bomb2" call BIS_fnc_taskState in ["SUCCEEDED"]  && "secure" call BIS_fnc_taskState in ["SUCCEEDED"]}
] spawn tsp_fnc_task;
[
    West, ["bomb1","coraros"], "Bomb threat", "The militia has planted bombs in the town, Find and defuse the bomb.",
    "Intel", objnull, {"meetup" call BIS_fnc_taskState == "SUCCEEDED"}, {!isNil "tsp_bomb_A"}, {false}
] spawn tsp_fnc_task;
[
    West, ["bomb2","coraros"], "Bomb threat", "The militia has planted bombs in the town, Find and defuse the bomb.",
    "Intel", objnull, {"meetup" call BIS_fnc_taskState == "SUCCEEDED"}, {!isNil "tsp_bomb_B"}, {false}
] spawn tsp_fnc_task;
[
    West, ["secure","coraros"], "Secure coraros", "The town is under militia control, Eliminate them and take the town.",
    "Attack", objnull, {"meetup" call BIS_fnc_taskState == "SUCCEEDED"}, {(count (allunits select {_x inArea secure_coraros && side _x == East}) <1)}
] spawn tsp_fnc_task;
[
    West, ["port"], "Prava Port", "Raid the port.",
    "Attack", objnull, {"coraros" call BIS_fnc_taskState == "SUCCEEDED"}, {"chem1" call BIS_fnc_taskState in ["SUCCEEDED"] && "chem2" call BIS_fnc_taskState in ["SUCCEEDED"]  && "control" call BIS_fnc_taskState in ["SUCCEEDED"]}
] spawn tsp_fnc_task;
[
    West, ["chem1","port"], "Secure chemical bomb", "Find and Secure the chemical bomb.",
    "Box", objnull, {"coraros" call BIS_fnc_taskState == "SUCCEEDED"}, {!isNil "tsp_chemical_A"}, {false}
] spawn tsp_fnc_task;
[
    West, ["chem2","port"], "Secure chemical bomb", "Find and Secure the chemical bomb.",
    "Box", objnull, {"coraros" call BIS_fnc_taskState == "SUCCEEDED"}, {!isNil "tsp_chemical_B"}, {false}
] spawn tsp_fnc_task;
[
    West, ["control","port"], "Secure coraros", "The town is under militia control, Eliminate them and take the town.",
    "Attack", objnull, {"coraros" call BIS_fnc_taskState == "SUCCEEDED"}, {(count (allunits select {_x inArea secure_coraros && side _x == East}) <1)}
] spawn tsp_fnc_task;

