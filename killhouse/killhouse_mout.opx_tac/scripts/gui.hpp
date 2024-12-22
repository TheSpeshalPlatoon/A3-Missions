class tsp_earplug_progress {
	type = 8;
	style = 0;
	colorFrame[] = {0,0,0,0};
	colorBar[] = {
		"(profileNameSpace getVariable ['GUI_BCG_RGB_R',0.13])",
		"(profileNameSpace getVariable ['GUI_BCG_RGB_G',0.54])",
		"(profileNameSpace getVariable ['GUI_BCG_RGB_B',0.21])",
		"(profileNameSpace getVariable ['GUI_BCG_RGB_A',0.8])"
	};
  	x = 0.344;
	y = 0.7;
	w = 0.313726;
	h = 0.0261438;
	texture = "#(argb,8,8,3)color(1,1,1,1)";
};
class tsp_earplug_background {
	idc = -1;
	type = 0;
	style = 0x00;
	SizeEx = 1;
	colorText[] = {1,1,1,1};
	colorBackground[] = {1,1,1,0.2};
	colorShadow[] = {0,0,0,0.5};
  	x = 0.344;
	y = 0.7;
	w = 0.313726;
	h = 0.0261438;
	shadow = true;
	text = "";
	font = "RobotoCondensed";
	linespacing = 1;
};
class tsp_treeview {
    type = 12;
    text = "";
    idc = 696969;
    style = 2;
    x = 0;
    y = 0;
    w = 0.045;
    h = 1;
	font = "PuristaMedium";
	sizeEx = 0.04;
	maxHistoryDelay = 1;
	forceDrawCaret = false;
	multiselectEnabled = 1;
	idcSearch = 6969;

	class ScrollBar {
		color[] = {1,1,1,0.6};
		colorActive[] = {1,1,1,1};
		colorDisabled[] = {1,1,1,0.3};
		thumb = "\A3\ui_f\data\gui\cfg\scrollbar\thumb_ca.paa";
		arrowEmpty = "\A3\ui_f\data\gui\cfg\scrollbar\arrowEmpty_ca.paa";
		arrowFull =	"\A3\ui_f\data\gui\cfg\scrollbar\arrowFull_ca.paa";
		border = "\A3\ui_f\data\gui\cfg\scrollbar\border_ca.paa";
		shadow = 0;
		scrollSpeed = 0.06;
		width = 0;
		height = 0;
		autoScrollEnabled = 0;
		autoScrollSpeed = -1;
		autoScrollDelay = 5;
		autoScrollRewind = 0;
	};

	colorText[] = {1,1,1,1};
	colorBackground[] = {0,0,0,0.8};
	colorDisabled[] = {1,1,1,0.25};

	colorSelect[] = {1,1,1,0.7};
	colorSelectText[] = {0,0,0,1};
	colorBorder[] = {0,0,0,0};
	colorSearch[] = {0,0,0,1};
	colorMarked[] = {1,1,1,1};
	colorMarkedText[] = {0,0,0,1};
	colorMarkedSelected[] = {1,1,1,1};
	
	colorPicture[] = {1,1,1,1};
	colorPictureSelected[] = {0,0,0,1};
	colorPictureDisabled[] = {1,1,1,0.25};
	colorPictureRight[] = {1,1,1,1};
	colorPictureRightSelected[] = {0,0,0,1};
	colorPictureRightDisabled[] = {1,1,1,0.25};
	colorArrow[] = {1,1,1,1};
	
	colorSelectBackground[] = {0,0,0,0.5};
	colorLines[] = {1,1,1,1};

	expandedTexture = "A3\ui_f\data\gui\rsccommon\rsctree\expandedTexture_ca.paa";
	hiddenTexture = "A3\ui_f\data\gui\rsccommon\rsctree\hiddenTexture_ca.paa";
};
class tsp_invisible {
	access = 0;
	type = 1;
	text = "";
	colorText[] = {0,0,0,0};
	colorDisabled[] = {0,0,0,0};
	colorBackground[] = {0,0,0,0};
	colorBackgroundDisabled[] = {0,0,0,0};
	colorBackgroundActive[] = {1,1,1,0.1};
	colorFocused[] = {0,0,0,0};
	colorShadow[] = {0,0,0,0};
	colorBorder[] = {0,0,0,0};
	soundClick[] = {"\A3\ui_f\data\sound\RscButtonMenu\soundClick",0.09,1};
	soundEnter[] = {"\A3\ui_f\data\sound\RscButtonMenu\soundEnter",0.09,1};
	soundEscape[] = {"\A3\ui_f\data\sound\RscButtonMenu\soundEscape",0.09,1};
	soundPush[] = {"\A3\ui_f\data\sound\RscButtonMenu\soundPush",0.09,1};
	style = 2;
	x = 0;
	y = 0;
	w = 0.095589;
	h = 0.039216;
	shadow = 2;
	font = "PuristaLight";
	sizeEx = 0.03921;
	offsetX = 0.003;
	offsetY = 0.003;
	offsetPressedX = 0.002;
	offsetPressedY = 0.002;
	borderSize = 0;
};