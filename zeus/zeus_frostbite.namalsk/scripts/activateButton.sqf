params ["_button", "_door"];

// Check if the button is already activated
if (_button getVariable ["isActivated", false]) exitWith {
    hint "This button is already activated!";
};

// Mark the button as activated
_button setVariable ["isActivated", true];
hint format ["%1 activated!", _button];

// Check if all buttons are activated
private _allButtons = [button1, button2, button3];
private _allActivated = true;

// Loop through all buttons to verify activation
{
    if (!(_x getVariable ["isActivated", false])) then {
        _allActivated = false;
    };
} forEach _allButtons;

// If all buttons are activated, open the door
if (_allActivated) then {
    hint "All buttons activated! Unlocking and opening the gate...";
    
    // Unlock the gate
    bunker_door setVariable ["bis_disabled_Door_1", 0, true]; // Removes the locked state
    bunker_door enableSimulation true; // Ensure the gate is interactable

    // Open the gate
    [bunker_door, 1, 1] call BIS_fnc_Door; // Replace "Door_1_move" with the correct animation name
    
    
} else {
    hint "Not all buttons are activated!";
};
