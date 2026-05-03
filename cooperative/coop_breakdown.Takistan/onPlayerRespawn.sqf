if (isMultiplayer) then {removeAllWeapons player};
if (isMultiplayer) then {removeGoggles player};
if (isMultiplayer) then {removeHeadgear player};
if (isMultiplayer) then {removeVest player};
if (isMultiplayer) then {removeUniform player};
if (isMultiplayer) then {removeAllAssignedItems player};
if (isMultiplayer) then {clearAllItemsFromBackpack player};
if (isMultiplayer) then {removeBackpack player};
///player setUnitLoadout(player getVariable["Saved_Loadout",[]]);
if(isMultiplayer) then {[player, [missionNamespace, "inventory_var"]] call BIS_fnc_loadInventory;};
if (local player) then { 
  player enableFatigue false; 
  player addEventhandler ["Respawn", {player enableFatigue false}]; 
};
player enableFatigue false;      
player addAction ["View Distance settings", CHVD_fnc_openDialog, [], -99, false, true,"","alive _target"];

[if ([west, 0] call BIS_fnc_respawnTickets ==1) then {["warning",["No more spawn tickets! if some one die the mission will fail",""]] call BIS_fnc_showNotification}] spawn BIS_fnc_MP;
if (isNil "delet_1" OR !alive delet_1 OR didJIP) then {["TaskAssigned",["Leave the Base to teleport"]] call bis_fnc_showNotification;};

///Fix music to jips

if (didJIP) then{
if (!isNil "PLayMarkaMusic") then {"Marka" remoteExec ["playmusic"];};
if (!isNil "Loop") then {Loop = addMusicEventHandler ["MusicStop", {"loop" remoteExec ["playmusic"];}];
"loop" remoteExec ["playmusic"];};
if (!isNil "helirideMusic") then {"heliride" remoteExec ["playmusic"];};
};