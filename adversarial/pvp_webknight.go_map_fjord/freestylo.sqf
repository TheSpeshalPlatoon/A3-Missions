params["_player"];
if (not alive _player)exitWith{};
if (_player getVariable "freestyloed")exitWith{};
_player setVariable ["freestyloed",true,true];
/*

"kka3_robotdance",
"kka3_crazy_dance",
"kka3_nightclubdance",
"kka3_crazydrunkdance",
"kka3_dubstepdance",
"kka3_duoivan",
"kka3_hiphopdance",
"kka3_russiandance",*/


_dances=[
"acts_dance_01",
"acts_dance_02"];

_audio=["sickrap.ogg","wakamak.ogg","free.ogg"];
_audioLength=[25,23,23];





//disableUserInput false;
//sleep 1;
//playSound3D [getMissionPath (format["sounds\%1","freestylo.ogg"]), _player];
[_player,{playSound3D [getMissionPath "sounds\freestylo.ogg", _this]}] remoteExec ["spawn"];
_stereo="Land_FMradio_F" createVehicle (position _player);
//disableUserInput true;

sleep 3;
[_player,"jet_noface"]remoteExec ["setFace", 0, true];

if (not local _player)then {
	[[],{

		_cam = "camera" camCreate (player modelToWorld [0,2,1.5]);

		//_cam CamSetTarget player; 
		_cam cameraEffect ["internal", "BACK"]; 
		_cam attachTo [player, [0,2,1.5]] ;
		_cam setDir (180);
		switchCamera _cam; 
		waitUntil {not alive player};
		camDestroy _cam;
		_cam cameraEffect ['terminate', 'BACK']; 



	}] remoteExec["spawn",_player,false];

	[true]remoteExec ["disableUserInput", _player, false];
};

_player setFace "jet_noface";
_outfits=["jet_tiger","jet_zebra","jet_dragon","jet_wolf"];
_player setUnitLoadout [[],[],[],[selectRandom _outfits,[]],[],[],"","",[],["","","","","",""]];
_index=floor(random (count _audio -1));




[[_player],{

	params["_player"];
	_rave={
		params["_light"];
		[_light]spawn {
			params["_light"];
			_step=0.006;
			_dLerp=0.01;
			_startVal= [0,0,0];

			while {true} do{

					


			_endVal=[random 125,random 125,random 125];
			for [{_i=0},{_i<=1/_dLerp},{ _i = _i + 1}] do
			{

			_rgbSet=[[_startVal select 0,_endVal select 0,_i*_dLerp] call BIS_fnc_lerp, [_startVal select 1,_endVal select 1,_i*_dLerp] call BIS_fnc_lerp    , [_startVal select 2,_endVal select 2,_i*_dLerp] call BIS_fnc_lerp   ];
			_light setLightAmbient _rgbSet;
			_light setLightColor _rgbSet;
			_light setLightIntensity 4;
			//systemChat (str(_rgbSet));
			sleep _step;

			};
			_startVal=_endVal;
			};



		};



	};

	_light = "#lightpoint" createVehicle (position _player);
	_light setLightBrightness 1.0; 
	_light attachTo [_player,[0,0,0],"head"];
	[_light]spawn _rave;
	waitUntil{not alive _player};
	deleteVehicle _light;
}]remoteExec["spawn",0];



[[_audio,_index,_stereo],{params["_audio", "_index","_stereo"];playSound3D [getMissionPath (format["sounds\%1",_audio select _index]), _stereo]}] remoteExecCall ["call"];




//playSound3D [getMissionPath (format["sounds\%1",_audio select _index]), _stereo];


[_player,_audioLength,_dances,_index,_stereo]spawn{
	params["_player","_audioLength","_dances","_index","_stereo"];




	//_player action ["SwitchWeapon", _player, _player, -1];  
	//_player switchMove (selectRandom _dances ) ;

	[_player,selectRandom _dances] remoteExec["switchMove",0,true];
	//execVM "cancer.sqf";
	//disableUserInput true;

	sleep (_audioLength select _index);


	_player switchMove ""; 
	[false]remoteExec ["disableUserInput", _player, false];
	deleteVehicle _stereo;
	
	//disableUserInput false;
	sleep 0.1;
	_player setVariable ["freestyloed",false,true];
	_player setDamage 1;

	//_player setVelocity [0,0,100];

};
