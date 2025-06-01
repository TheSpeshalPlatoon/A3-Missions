//-- Initial Spawn Settings
tsp_spawns_scale = 0.2;        //-- Map zoom level. 0 to 1, smaller value means more zoomed in
tsp_spawns_west = [
	[getPos spawnPos,                                          //-- Position
    "player attachTo [spawnPos, [0, 0, 0]]; detach player;",  //-- Code
    "Airfield",                                                  //-- Name
    "US Miltary Airfield."]                                         //-- Description
];
tsp_spawns_east = [
    [getPos spawnPos,                                          //-- Position
    "player attachTo [spawnPos, [0, 0, 0]]; detach player;",  //-- Code
    "Name",                                                  //-- Name
    "Description."]                                         //-- Description
];
tsp_spawns_resistance = [];
tsp_spawns_civilian = [];