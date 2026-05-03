// orb_interact.sqf
params ["_target", "_caller", "_actionId"];

// Play sound
playSound3D ["OrbSound", _target];

// Hide the orb
_target hideObject true;
_target enableSimulation false;

// Remove the interaction
_target removeAction _actionId;

// Hint for feedback (optional)
hint "You've grabbed the Artifact";
