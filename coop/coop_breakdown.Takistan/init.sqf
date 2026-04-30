0 fadeRadio 0;
enableRadio false;
enableSentences false;
if (isMultiplayer) then {enableSaving [ false,  false ]}; 
if (local player) then { 
  player enableFatigue false; 
  player addEventhandler ["Respawn", {player enableFatigue false}]; 
};

if(!isMultiplayer) then 
{

{
if(! (isPlayer _x) ) then
{
 deleteVehicle _x;
};
} foreach switchableUnits;
};
{_x enableFatigue false;} forEach playableUnits;
{ _x enableFatigue false; } forEach (units group player);