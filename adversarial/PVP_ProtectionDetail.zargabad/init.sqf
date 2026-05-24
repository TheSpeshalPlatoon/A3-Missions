//-- Per-side Markers
if (side player == east) then {
	"bluforbase" setMarkerAlphaLocal 0;
};
if (side player == west) then {
	"opforbase" setMarkerAlphaLocal 0;
	//"cache1" setMarkerAlphaLocal 0;
	//"cache2" setMarkerAlphaLocal 0;
};

while {true} do {	
    if (vest player == "C4_belt") then {
		if (isNil "boomboomaction") then {
			boomboomaction = player addAction ["1 Way Trip to Paradise", {
				if (vest player == "C4_belt") then {
					params ["_target", "_caller", "_actionId", "_arguments"];
					_demochage = "DemoCharge_Remote_Ammo_Scripted" createVehicle (getPos _target);  
					_demochage attachto [_target,[0,0,0]]; 
					detach _demochage;
					removeVest _target;
					_demochage setdamage 1;  
					_target setdamage 1;	
					_target removeAction boomboomaction;				
				};
			}];
		};
    } else {        
		if (!isNil "boomboomaction") then {			
			player removeAction boomboomaction;
			boomboomaction = nil;
		};
    };
    sleep 5;
};