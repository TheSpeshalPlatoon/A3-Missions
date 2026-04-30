[
    heliRip,                                                                           // Object the action is attached to
    "Pay respects",                                                                       // Title of the action
    "\a3\ui_f\data\IGUI\Cfg\actions\take_ca.paa",                      // Idle icon shown on screen
    "\a3\ui_f\data\IGUI\Cfg\actions\ico_cpt_thtl_IDL_ca.paa",                      // Progress icon shown on screen
    "_this distance _target < 10",                                                        // Condition for the action to be shown
    "_caller distance _target < 10",                                                      // Condition for the action to progress
    {_caller playActionNow "Salute"},                                                                                  // Code executed when action starts
    {},                                                                                  // Code executed on every progress tick
    {hint "R.I.P"},                                                // Code executed on completion
    {},                                                                                  // Code executed on interrupted
    [],                                                                                  // Arguments passed to the scripts as _this select 3
    3,                                                                                  // Action duration [s]
    1,                                                                                   // Priority
    false,                                                                                // Remove on completion
    false                                                                                // Show in unconscious state 
] remoteExec ["BIS_fnc_holdActionAdd",[0,-2]select isDedicated, true];                                  // example for MP compatible implementation