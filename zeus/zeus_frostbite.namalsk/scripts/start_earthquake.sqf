// start_earthquake.sqf

params ["_target", "_actionId"]; // _target = skull, _actionId = ID of the action
private _caller = _this select 1; // Player interacting with the skull

// Remove the action so it can't be used again
_target removeAction _actionId;

// Hint for feedback
hint "The artifacts combine, and the ground begins to shake...";

// Optional: Play a sound
playSound3D ["sounds/earthquake.ogg", _caller];

// Trigger the earthquake
[10] spawn BIS_fnc_Earthquake; // Earthquake for 10 seconds

// Optional: Add additional effects here, such as spawning enemies
