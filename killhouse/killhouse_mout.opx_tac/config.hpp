enableDebugConsole = 2;
saving = 0;
respawn = "BASE";
respawnDelay = 2;
respawnDialog = 0;

//-- Addon mode needs full path (\tsp_core\)
class CfgFunctions {class tsp_core {class functions {class init {file = "initFramework.sqf"; preInit = true};};};};
#include "\a3\ui_f\hpp\definecommongrids.inc"
#include "scripts\chvd.hpp"
#include "scripts\gui.hpp"