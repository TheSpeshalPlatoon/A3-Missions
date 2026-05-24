//-- Defines
params ["_god", "_helipilots", "_jetpilots", "_crewmen", "_apcs", "_parachutes"];

//-- Decide permissions based on role
if (({player isKindOf _x} count _god) == 1) then {isCrewman = 1;isHeliPilot = 1;isJetPilot = 1};
if (({player isKindOf _x} count _helipilots) == 1) then {isHeliPilot = 1};
if (({player isKindOf _x} count _jetpilots) == 1) then {isJetPilot = 1};
if (({player isKindOf _x} count _crewmen) == 1) then {isCrewman = 1};

//-- Script
while {true} do {
    waituntil {sleep 1;vehicle player != player};  //--- Wait until player is in a vehicle
    
    if (tsp_param_crew == "Enabled") then {
        _vehicle = vehicle player;
        _copilotseat = [_vehicle turretUnit [0]];

        //-- Parachute Exception
        if (typeOf _vehicle in _parachutes) exitWith {};

        //-- Helicopters
        if (   (isNil "isHeliPilot") && (_vehicle isKindOf "Helicopter") && ((driver _vehicle == player) || (player in _copilotseat))   ) then {
            player action ["GetOut", _vehicle];
            systemchat "You must be a helicopter pilot to fly a helicopter.";
        };

        //-- Jets
        if (   (isNil "isJetPilot") && (_vehicle isKindOf "Plane") && ((driver _vehicle == player) || (player in _copilotseat))   ) then {
            player action ["GetOut", _vehicle];
            systemchat "You must be a jet pilot to fly a jet.";
        };

        //-- Tanks
        if (   (isNil "isCrewman") && ((_vehicle isKindOf "Tank") || (typeOf _vehicle in _apcs)) && (driver _vehicle == player)   ) then {
            player action ["GetOut", _vehicle];
            systemchat "You must be a crewman to drive a tank.";
        };
    };

    sleep 2;
};