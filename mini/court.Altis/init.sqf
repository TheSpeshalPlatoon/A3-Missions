player setCaptive true;
[] spawn {
	_action = [
		"Sit","Sit","\z\ace\addons\sitting\UI\sit_ca.paa",
		{[_target, ace_player] call ace_sitting_fnc_sit},
		{[_target, ace_player] call ace_sitting_fnc_canSit}
	] call ace_interact_menu_fnc_createAction;
	["Land_HelipadEmpty_F", 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToClass;
	makeSound = true; while {makeSound} do {/*playMusic "city";*/ sleep 63};
};