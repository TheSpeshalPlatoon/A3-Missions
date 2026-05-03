
onEachFrame
{
	_beg = ASLToAGL eyePos player;
	_endE = _beg vectorAdd (eyeDirection player vectorMultiply 100);
	drawLine3D [_beg, _endE, [0,1,0,1]];
	_endW = _beg vectorAdd (player weaponDirection currentWeapon player vectorMultiply 100);
	drawLine3D [_beg, _endW, [1,0,0,1]]; 
};