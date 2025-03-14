tsp_fnc_time = {  //-- Run on server
	params ["_unit", "_time"]; (uiNamespace getVariable [missionName, ["No Name", 999999]]) params ["_fastestName", "_fastestTime"];
	if (_fastestTime != 999999) then {[_fastestName + " holds the record with a time of " + ([_fastestTime, "MM:SS"] call BIS_fnc_secondsToString) + "."] remoteExec ["systemChat", 0]};
	if (_time < _fastestTime) then {
		[name _unit + " set a new record with a time of " + ([_time, "MM:SS"] call BIS_fnc_secondsToString) + "."] remoteExec ["systemChat", 0];
		uiNamespace setVariable [missionName, [name _unit, _time]];
	} else {
		[name _unit + " finished the stage with a time of " + ([_time, "MM:SS"] call BIS_fnc_secondsToString) + "."] remoteExec ["systemChat", 0];
	};
};
