author = "Dino"; 
onLoadName = "House to House";	
loadScreen = "tsp_mission\images\overview.jpg";   
class Header {gameType = COOP}; 

class Params {
    #define TIMEACCELERATION_DEFAULT 1
    #include "\a3\Functions_F_MP_Mark\Params\paramTimeAcceleration.hpp"
    #define GUERFRIENDLY_DEFAULT -1
	#include "\a3\functions_f\Params\paramGuerFriendly.hpp"
};

respawnButton = 1;
forceRotorLibSimulation = 0;
disabledAI = 1;
briefing = 1;

corpseManagerMode = 3;
corpseLimit = 20;
corpseRemovalMinTime = 120; 
corpseRemovalMaxTime = 240;

wreckManagerMode = 2;
wreckLimit = 10;
wreckRemovalMinTime = 300; 
wreckRemovalMaxTime = 600;
 
reviveMode = 0;
reviveUnconsciousStateMode = 1;
reviveRequiredTrait = 0;
reviveRequiredItems = 0;
reviveRequiredItemsFakConsumed = 1;
reviveMedicSpeedMultiplier = 2;
reviveDelay = 10;
reviveForceRespawnDelay = 5;
reviveBleedOutDelay = 240;