author = Dino; 
onLoadName = "Protection Detail";	
loadScreen = "images\overview.jpg";				           
class header {gameType = TDM}; 

class Params {
    #define TIMEACCELERATION_DEFAULT 2
    #include "\a3\Functions_F_MP_Mark\Params\paramTimeAcceleration.hpp"
    #define GUERFRIENDLY_DEFAULT -1
	#include "\a3\functions_f\Params\paramGuerFriendly.hpp"
};

respawnButton = 0;
forceRotorLibSimulation = 0;
disabledAI = 1;
//-- briefing = 0; //-- Skips map screen

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