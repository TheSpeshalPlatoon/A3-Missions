if (!isNil "tsp_start") exitWith {["Initialize"] call BIS_fnc_EGSpectator};  //-- Late joiners go to spectate

waitUntil {!isNull findDisplay 46 && !isNil "tsp_start"};  //-- Wait until loaded in

player addEventHandler ["Killed", {["Initialize"] call BIS_fnc_EGSpectator}];

[player, [zone_play], "You are out of bounds!", {
	_this attachTo [if (side _this == west) then {start_west} else {start_east}, [0,1,0]]; 
	detach _this; _this spawn {sleep 2; [_this] call tsp_fnc_heal};
}, {alive _this}, 1, 1] spawn tsp_fnc_zone;

_grenades = []; 
{_grenades = _grenades + getArray(configFile >> "CfgWeapons" >> "Throw" >> _x >> "magazines")} forEach (getArray(configFile >> "CfgWeapons" >> "Throw" >> "muzzles"));
{_this removeMagazines _x} forEach _grenades;

systemChat "NO FRAGS";
systemChat "NO EXPLOSIVES";
systemChat "NO ROCKETS";
systemChat "NO AUTORIFLES";