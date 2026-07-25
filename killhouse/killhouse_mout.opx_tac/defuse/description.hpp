#ifndef HG_CustomControlClassesh
	#define HG_CustomControlClassesh 1  //Create a header guard to prevent duplicate include.
#endif

//-- Defines
	//Defines.hpp

	// Control types
	#define CT_STATIC           0
	#define CT_BUTTON           1
	#define CT_EDIT             2
	#define CT_SLIDER           3
	#define CT_COMBO            4
	#define CT_LISTBOX          5
	#define CT_TOOLBOX          6
	#define CT_CHECKBOXES       7
	#define CT_PROGRESS         8
	#define CT_HTML             9
	#define CT_STATIC_SKEW      10
	#define CT_ACTIVETEXT       11
	#define CT_TREE             12
	#define CT_STRUCTURED_TEXT  13
	#define CT_CONTEXT_MENU     14
	#define CT_CONTROLS_GROUP   15
	#define CT_SHORTCUTBUTTON   16
	#define CT_HITZONES         17
	#define CT_XKEYDESC         40
	#define CT_XBUTTON          41
	#define CT_XLISTBOX         42
	#define CT_XSLIDER          43
	#define CT_XCOMBO           44
	#define CT_ANIMATED_TEXTURE 45
	#define CT_OBJECT           80
	#define CT_OBJECT_ZOOM      81
	#define CT_OBJECT_CONTAINER 82
	#define CT_OBJECT_CONT_ANIM 83
	#define CT_LINEBREAK        98
	#define CT_USER             99
	#define CT_MAP              100
	#define CT_MAP_MAIN         101
	#define CT_LISTNBOX         102
	#define CT_ITEMSLOT         103
	#define CT_CHECKBOX         77

	// Static styles
	#define ST_POS            0x0F
	#define ST_HPOS           0x03
	#define ST_VPOS           0x0C
	#define ST_LEFT           0x00
	#define ST_RIGHT          0x01
	#define ST_CENTER         0x02
	#define ST_DOWN           0x04
	#define ST_UP             0x08
	#define ST_VCENTER        0x0C

	#define ST_TYPE           0xF0
	#define ST_SINGLE         0x00
	#define ST_MULTI          0x10
	#define ST_TITLE_BAR      0x20
	#define ST_PICTURE        0x30
	#define ST_FRAME          0x40
	#define ST_BACKGROUND     0x50
	#define ST_GROUP_BOX      0x60
	#define ST_GROUP_BOX2     0x70
	#define ST_HUD_BACKGROUND 0x80
	#define ST_TILE_PICTURE   0x90
	#define ST_WITH_RECT      0xA0
	#define ST_LINE           0xB0
	#define ST_UPPERCASE      0xC0
	#define ST_LOWERCASE      0xD0

	#define ST_SHADOW         0x100
	#define ST_NO_RECT        0x200
	#define ST_KEEP_ASPECT_RATIO  0x800

	#define ST_TITLE          ST_TITLE_BAR + ST_CENTER

	// Slider styles
	#define SL_DIR            0x400
	#define SL_VERT           0
	#define SL_HORZ           0x400

	#define SL_TEXTURES       0x10

	// progress bar 
	#define ST_VERTICAL       0x01
	#define ST_HORIZONTAL     0

	// Listbox styles
	#define LB_TEXTURES       0x10
	#define LB_MULTI          0x20

	// Tree styles
	#define TR_SHOWROOT       1
	#define TR_AUTOCOLLAPSE   2

	// MessageBox styles
	#define MB_BUTTON_OK      1
	#define MB_BUTTON_CANCEL  2
	#define MB_BUTTON_USER    4
	#define MB_ERROR_DIALOG   8

	// Xbox buttons
	#define KEY_XINPUT                0x00050000
	#define KEY_XBOX_A                KEY_XINPUT + 0
	#define KEY_XBOX_B                KEY_XINPUT + 1
	#define KEY_XBOX_X                KEY_XINPUT + 2
	#define KEY_XBOX_Y                KEY_XINPUT + 3
	#define KEY_XBOX_Up               KEY_XINPUT + 4
	#define KEY_XBOX_Down             KEY_XINPUT + 5
	#define KEY_XBOX_Left             KEY_XINPUT + 6
	#define KEY_XBOX_Right            KEY_XINPUT + 7
	#define KEY_XBOX_Start            KEY_XINPUT + 8
	#define KEY_XBOX_Back             KEY_XINPUT + 9
	#define KEY_XBOX_LeftBumper       KEY_XINPUT + 10
	#define KEY_XBOX_RightBumper      KEY_XINPUT + 11
	#define KEY_XBOX_LeftTrigger      KEY_XINPUT + 12
	#define KEY_XBOX_RightTrigger     KEY_XINPUT + 13
	#define KEY_XBOX_LeftThumb        KEY_XINPUT + 14
	#define KEY_XBOX_RightThumb       KEY_XINPUT + 15
	#define KEY_XBOX_LeftThumbXRight  KEY_XINPUT + 16
	#define KEY_XBOX_LeftThumbYUp     KEY_XINPUT + 17
	#define KEY_XBOX_RightThumbXRight KEY_XINPUT + 18
	#define KEY_XBOX_RightThumbYUp    KEY_XINPUT + 19
	#define KEY_XBOX_LeftThumbXLeft   KEY_XINPUT + 20
	#define KEY_XBOX_LeftThumbYDown   KEY_XINPUT + 21
	#define KEY_XBOX_RightThumbXLeft  KEY_XINPUT + 22
	#define KEY_XBOX_RightThumbYDown  KEY_XINPUT + 23

	// Fonts
	#define GUI_FONT_NORMAL			PuristaMedium
	#define GUI_FONT_BOLD			PuristaSemibold
	#define GUI_FONT_THIN			PuristaLight
	#define GUI_FONT_MONO			EtelkaMonospacePro
	#define GUI_FONT_NARROW			EtelkaNarrowMediumPro
	#define GUI_FONT_CODE			LucidaConsoleB
	#define GUI_FONT_SYSTEM			TahomaB

//-- Controls
class RscStructuredText;
class RscControlsgroup  
{
	type = CT_CONTROLS_GROUP;
	idc = -1;
	style = ST_MULTI;
	x = (safeZoneX + (SafezoneW * 0.0163));  // scalability code which resizes correctly no matter what gui size or screen dimensions is used
	y = (safeZoneY + (SafezoneH * 0.132));   
	w = (SafezoneW  * 0.31);                 
	h = (SafezoneH  * 0.752);              

	class VScrollbar 
	{
		color[] = {0.5, 0.5, 0.5, 1};
		width = 0.015;
		autoScrollSpeed = -1;
		autoScrollDelay = 0;
		autoScrollRewind = 0;
	 arrowEmpty = "\A3\ui_f\data\gui\cfg\scrollbar\arrowEmpty_ca.paa"; // Arrow 
	 arrowFull = "\A3\ui_f\data\gui\cfg\scrollbar\arrowFull_ca.paa"; // Arrow when clicked on 
	 border = "\A3\ui_f\data\gui\cfg\scrollbar\border_ca.paa"; // Slider background (stretched vertically) 
	 thumb = "\A3\ui_f\data\gui\cfg\scrollbar\thumb_ca.paa"; // Dragging element (stretched vertically) 
	};

	class HScrollbar 
	{
		color[] = {1, 1, 1, 1};
		height = 0.028;
	};

	class ScrollBar
	{
		color[] = {1,1,1,0.6};
		colorActive[] = {1,1,1,1};
		colorDisabled[] = {1,1,1,0.3};
	 arrowEmpty = "\A3\ui_f\data\gui\cfg\scrollbar\arrowEmpty_ca.paa"; // Arrow 
	 arrowFull = "\A3\ui_f\data\gui\cfg\scrollbar\arrowFull_ca.paa"; // Arrow when clicked on 
	 border = "\A3\ui_f\data\gui\cfg\scrollbar\border_ca.paa"; // Slider background (stretched vertically) 
	 thumb = "\A3\ui_f\data\gui\cfg\scrollbar\thumb_ca.paa"; // Dragging element (stretched vertically) 
	};

	class Controls {};
};
class BadgerDefuse
{
	idd = 6700;
	onLoad = "[{ !isNull findDisplay 6700 }, { [] call TFB_fnc_defuse_bombDialog; }, [], 2] call CBA_fnc_waitUntilAndExecute;";
	
	class ControlsBackground
	{
		
		class device_img
		{
			type = 0;
			idc = -1;
			x = safeZoneX + safeZoneW * 0.104375;
			y = safeZoneY + safeZoneH * 0.19666667;
			w = safeZoneW * 0.3925;
			h = safeZoneH * 0.70333334;
			style = 0+48;
			text = "defuse\device.paa";
			colorBackground[] = {0,0,0,0};
			colorText[] = {1,1,1,1};
			font = "PuristaMedium";
			sizeEx = 1;
			
		};
		class clipboard_img
		{
			type = 0;
			idc = -1;
			x = safeZoneX + safeZoneW * 0.42125;
			y = safeZoneY + safeZoneH * 0.15444445;
			w = safeZoneW * 0.45625;
			h = safeZoneH * 0.81888889;
			style = 0+48;
			text = "defuse\clipboard3.paa";
			colorBackground[] = {0,0,0,0};
			colorText[] = {1,1,1,1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			
		};
		class slot_wire1
		{
			type = 0;
			idc = 101;
			x = safeZoneX + safeZoneW * 0.2375;
			y = safeZoneY + safeZoneH * 0.16777778;
			w = safeZoneW * 0.08625;
			h = safeZoneH * 0.13444445;
			style = 0+48;
			text = "";
			colorBackground[] = {0,0,0,0};
			colorText[] = {1,1,1,1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			
		};
		class slot_wire2
		{
			type = 0;
			idc = 102;
			x = safeZoneX + safeZoneW * 0.255;
			y = safeZoneY + safeZoneH * 0.16777778;
			w = safeZoneW * 0.08625;
			h = safeZoneH * 0.13444445;
			style = 0+48;
			text = "";
			colorBackground[] = {0,0,0,0};
			colorText[] = {1,1,1,1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			
		};
		class slot_wire3
		{
			type = 0;
			idc = 103;
			x = safeZoneX + safeZoneW * 0.2725;
			y = safeZoneY + safeZoneH * 0.16777778;
			w = safeZoneW * 0.08625;
			h = safeZoneH * 0.13444445;
			style = 0+48;
			text = "";
			colorBackground[] = {0,0,0,0};
			colorText[] = {1,1,1,1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			
		};
		class slot_wire4
		{
			type = 0;
			idc = 104;
			x = safeZoneX + safeZoneW * 0.2895;
			y = safeZoneY + safeZoneH * 0.16777778;
			w = safeZoneW * 0.08625;
			h = safeZoneH * 0.13444445;
			style = 0+48;
			text = "";
			colorBackground[] = {0,0,0,0};
			colorText[] = {1,1,1,1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			
		};
		class slot_wire5
		{
			type = 0;
			idc = 105;
			x = safeZoneX + safeZoneW * 0.307;
			y = safeZoneY + safeZoneH * 0.16777778;
			w = safeZoneW * 0.08625;
			h = safeZoneH * 0.13444445;
			style = 0+48;
			text = "";
			colorBackground[] = {0,0,0,0};
			colorText[] = {1,1,1,1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			
		};
		class slot_wire6
		{
			type = 0;
			idc = 106;
			x = safeZoneX + safeZoneW * 0.3245;
			y = safeZoneY + safeZoneH * 0.16777778;
			w = safeZoneW * 0.08625;
			h = safeZoneH * 0.13444445;
			style = 0+48;
			text = "";
			colorBackground[] = {0,0,0,0};
			colorText[] = {1,1,1,1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			
		};
		class slot_wire7
		{
			type = 0;
			idc = 107;
			x = safeZoneX + safeZoneW * 0.342;
			y = safeZoneY + safeZoneH * 0.16777778;
			w = safeZoneW * 0.08625;
			h = safeZoneH * 0.13444445;
			style = 0+48;
			text = "";
			colorBackground[] = {0,0,0,0};
			colorText[] = {1,1,1,1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			
		};
		class slot_wire8
		{
			type = 0;
			idc = 108;
			x = safeZoneX + safeZoneW * 0.359;
			y = safeZoneY + safeZoneH * 0.16777778;
			w = safeZoneW * 0.08625;
			h = safeZoneH * 0.13444445;
			style = 0+48;
			text = "";
			colorBackground[] = {0,0,0,0};
			colorText[] = {1,1,1,1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			
		};
		class clipboard_header
		{
			type = 0;
			idc = 0;
			x = safeZoneX + safeZoneW * 0.5075;
			y = safeZoneY + safeZoneH * 0.22888889;
			w = safeZoneW * 0.280625;
			h = safeZoneH * 0.03333334;
			style = 2;
			text = "Defusal Instructions";
			colorBackground[] = {0,0,0,0};
			colorText[] = {0,0,0,1};
			font = "PuristaSemibold";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			
		};
		class keypad_display1
		{
			type = 0;
			idc = 211;
			x = safeZoneX + safeZoneW * 0.29;
			y = safeZoneY + safeZoneH * 0.4175;
			w = safeZoneW * 0.009375;
			h = safeZoneH * 0.035555;
			style = 0+2;
			text = "";
			colorBackground[] = {0,0,0,0};
			colorText[] = {0.2353,0.2353,0.2431,1};
			font = "EtelkaMonospacePro";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1.35);
			
		};
		class keypad_display2
		{
			type = 0;
			idc = 212;
			x = safeZoneX + safeZoneW * 0.304375;
			y = safeZoneY + safeZoneH * 0.41777778;
			w = safeZoneW * 0.009375;
			h = safeZoneH * 0.035555;
			style = 0+2;
			text = "";
			colorBackground[] = {0,0,0,0};
			colorText[] = {0.2353,0.2353,0.2431,1};
			font = "EtelkaMonospacePro";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1.35);
			
		};
		class keypad_display3
		{
			type = 0;
			idc = 213;
			x = safeZoneX + safeZoneW * 0.31875;
			y = safeZoneY + safeZoneH * 0.41777778;
			w = safeZoneW * 0.009375;
			h = safeZoneH * 0.035555;
			style = 0+2;
			text = "";
			colorBackground[] = {0,0,0,0};
			colorText[] = {0.2353,0.2353,0.2431,1};
			font = "EtelkaMonospacePro";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1.35);
			
		};
		class keypad_display4
		{
			type = 0;
			idc = 214;
			x = safeZoneX + safeZoneW * 0.333125;
			y = safeZoneY + safeZoneH * 0.41777778;
			w = safeZoneW * 0.009375;
			h = safeZoneH * 0.035555;
			style = 0+2;
			text = "";
			colorBackground[] = {0,0,0,0};
			colorText[] = {0.2353,0.2353,0.2431,1};
			font = "EtelkaMonospacePro";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1.35);
			
		};
		class keypad_display5
		{
			type = 0;
			idc = 215;
			x = safeZoneX + safeZoneW * 0.3475;
			y = safeZoneY + safeZoneH * 0.41777778;
			w = safeZoneW * 0.009375;
			h = safeZoneH * 0.035555;
			style = 0+2;
			text = "";
			colorBackground[] = {0,0,0,0};
			colorText[] = {0.2353,0.2353,0.2431,1};
			font = "EtelkaMonospacePro";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1.35);
			
		};
		class keypad_display6
		{
			type = 0;
			idc = 216;
			x = safeZoneX + safeZoneW * 0.361875;
			y = safeZoneY + safeZoneH * 0.41777778;
			w = safeZoneW * 0.009375;
			h = safeZoneH * 0.035555;
			style = 0+2;
			text = "";
			colorBackground[] = {0,0,0,0};
			colorText[] = {0.2353,0.2353,0.2431,1};
			font = "EtelkaMonospacePro";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1.35);
			
		};
		class keypad_display7
		{
			type = 0;
			idc = 217;
			x = safeZoneX + safeZoneW * 0.375;
			y = safeZoneY + safeZoneH * 0.41777778;
			w = safeZoneW * 0.009375;
			h = safeZoneH * 0.035555;
			style = 0+2;
			text = "";
			colorBackground[] = {0,0,0,0};
			colorText[] = {0.2353,0.2353,0.2431,1};
			font = "EtelkaMonospacePro";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1.35);
			
		};
		class keypad_display8
		{
			type = 0;
			idc = 218;
			x = safeZoneX + safeZoneW * 0.389;
			y = safeZoneY + safeZoneH * 0.41777778;
			w = safeZoneW * 0.009375;
			h = safeZoneH * 0.035555;
			style = 0+2;
			text = "";
			colorBackground[] = {0,0,0,0};
			colorText[] = {0.2353,0.2353,0.2431,1};
			font = "EtelkaMonospacePro";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1.35);
			
		};
		class keypad_display9
		{
			type = 0;
			idc = 219;
			x = safeZoneX + safeZoneW * 0.4025;
			y = safeZoneY + safeZoneH * 0.41777778;
			w = safeZoneW * 0.009375;
			h = safeZoneH * 0.035555;
			style = 0+2;
			text = "";
			colorBackground[] = {0,0,0,0};
			colorText[] = {0.2353,0.2353,0.2431,1};
			font = "EtelkaMonospacePro";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1.35);
			
		};
		class keypad_display10
		{
			type = 0;
			idc = 220;
			x = safeZoneX + safeZoneW * 0.4175;
			y = safeZoneY + safeZoneH * 0.41777778;
			w = safeZoneW * 0.009375;
			h = safeZoneH * 0.035555;
			style = 0+2;
			text = "";
			colorBackground[] = {0,0,0,0};
			colorText[] = {0.2353,0.2353,0.2431,1};
			font = "EtelkaMonospacePro";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1.35);
			
		};
		class keypad_display
		{
			type = 13;
			idc = 100;
			x = safeZoneX + safeZoneW * 0.2875;
			y = safeZoneY + safeZoneH * 0.4175;
			w = safeZoneW * 0.15;
			h = safeZoneH * 0.0388;
			style = 0;
			text = "";
			size = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 2.2);
			colorBackground[] = {1,1,1,0};
			class Attributes
			{
				color = "#3c3c3e";
				font = "EtelkaMonospaceProBold";
				size = 0.774;
				shadow = 1;
				valign='top';
				align='left';
			};
			
		};
		class clipboard_text_header2
		{
			type = 0;
			idc = 0;
			x = safeZoneX + safeZoneW * 0.51625;
			y = safeZoneY + safeZoneH * 0.27111112;
			w = safeZoneW * 0.265;
			h = safeZoneH * 0.02111112;
			style = 0;
			text = "Battery wires don't count, don't disconnect the battery!";
			colorBackground[] = {0,0,0,0};
			colorText[] = {0,0,0,1};
			font = "PuristaMedium";
			sizeEx = (safeZoneW * 0.265 / 25 * 1.6);
			
		};
		
		class clipboardgroup: RscControlsGroup {
			idc = 221;
			x = safeZoneX + safeZoneW * 0.51625;
			y = safeZoneY + safeZoneH * 0.31222223;
			w = safeZoneW * 0.265;
			h = safeZoneH * 0.50333334;
			sizeEx = (safeZoneW * 0.265 / 25 * 0.1);
			class Controls
			{
				class clipboard_text: RscStructuredText
				{
					type = 13;
					idc = 222;
					x = 0;
					y = 0;
					w = 0.595;
					h = 1;
					style = 0;
					text = "Test string one <br/> Test string 2";
					colorBackground[] = {0,0,0,0};
					colorText[] = {1,1,1,1};
					class Attributes
					{
						font = "PuristaMedium";
						color = "#000000";
						align = "left";
						shadow = false;
						shadowColor = "#FFFFFF";
					};
					size = (safeZoneW * 0.265 / 25 * 1.6);
				};
			};
		};
		
		class light_1
		{
			type = 0;
			idc = -1;
			x = safeZoneX + safeZoneW * 0.261;
			y = safeZoneY + safeZoneH * 0.3495;
			w = safeZoneW * 0.02;
			h = safeZoneH * 0.03555556;
			style = 0+48;
			text = "";
			colorBackground[] = {0,0,0,0};
			colorText[] = {1,1,1,1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			
		};
		class light_2
		{
			type = 0;
			idc = -1;
			x = safeZoneX + safeZoneW * 0.282;
			y = safeZoneY + safeZoneH * 0.3495;
			w = safeZoneW * 0.02;
			h = safeZoneH * 0.03555556;
			style = 0+48;
			text = "";
			colorBackground[] = {0,0,0,0};
			colorText[] = {1,1,1,1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			
		};
		class light_3
		{
			type = 0;
			idc = -1;
			x = safeZoneX + safeZoneW * 0.3033;
			y = safeZoneY + safeZoneH * 0.3495;
			w = safeZoneW * 0.02;
			h = safeZoneH * 0.03555556;
			style = 0+48;
			text = "";
			colorBackground[] = {0,0,0,0};
			colorText[] = {1,1,1,1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			
		};
		class light_4
		{
			type = 0;
			idc = -1;
			x = safeZoneX + safeZoneW * 0.323;
			y = safeZoneY + safeZoneH * 0.3495;
			w = safeZoneW * 0.02;
			h = safeZoneH * 0.03555556;
			style = 0+48;
			text = "";
			colorBackground[] = {0,0,0,0};
			colorText[] = {1,1,1,1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			
		};
		class light_5
		{
			type = 0;
			idc = -1;
			x = safeZoneX + safeZoneW * 0.3445;
			y = safeZoneY + safeZoneH * 0.3495;
			w = safeZoneW * 0.02;
			h = safeZoneH * 0.03555556;
			style = 0+48;
			text = "";
			colorBackground[] = {0,0,0,0};
			colorText[] = {1,1,1,1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			
		};
		class light_6
		{
			type = 0;
			idc = -1;
			x = safeZoneX + safeZoneW * 0.3645;
			y = safeZoneY + safeZoneH * 0.3495;
			w = safeZoneW * 0.02;
			h = safeZoneH * 0.03555556;
			style = 0+48;
			text = "";
			colorBackground[] = {0,0,0,0};
			colorText[] = {1,1,1,1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			
		};
		class light_7
		{
			type = 0;
			idc = -1;
			x = safeZoneX + safeZoneW * 0.384375;
			y = safeZoneY + safeZoneH * 0.3495;
			w = safeZoneW * 0.02;
			h = safeZoneH * 0.03555556;
			style = 0+48;
			text = "";
			colorBackground[] = {0,0,0,0};
			colorText[] = {1,1,1,1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			
		};
		class light_8
		{
			type = 0;
			idc = -1;
			x = safeZoneX + safeZoneW * 0.405625;
			y = safeZoneY + safeZoneH * 0.3495;
			w = safeZoneW * 0.02;
			h = safeZoneH * 0.03555556;
			style = 0+48;
			text = "";
			colorBackground[] = {0,0,0,0};
			colorText[] = {1,1,1,1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			
		};
		
	};
	class Controls
	{
		class battery
		{
			type = 1;
			idc = -1;
			x = safeZoneX + safeZoneW * 0.1525;
			y = safeZoneY + safeZoneH * 0.30444445;
			w = safeZoneW * 0.01875;
			h = safeZoneH * 0.14;
			style = 0;
			text = "";
			borderSize = 0;
			colorBackground[] = {0,0,0,0.05};
			colorBackgroundActive[] = {1,1,1,0.2};
			colorBackgroundDisabled[] = {0,0,0,0};
			colorBorder[] = {0,0,0,0};
			colorDisabled[] = {0,0,0,0};
			colorFocused[] = {0,0,0,0};
			colorShadow[] = {0,0,0,0};
			colorText[] = {0,0,0,0};
			font = "PuristaMedium";
			offsetPressedX = 0.0;
			offsetPressedY = 0.01;
			offsetX = 0.01;
			offsetY = 0.01;
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			soundClick[] = {"\A3\ui_f\data\sound\RscButton\soundClick",0.09,1.0};
			soundEnter[] = {"\A3\ui_f\data\sound\RscButton\soundEnter",0.09,1.0};
			soundEscape[] = {"\A3\ui_f\data\sound\RscButton\soundEscape",0.09,1.0};
			soundPush[] = {"\A3\ui_f\data\sound\RscButton\soundPush",0.09,1.0};
			tooltip = "Remove Battery";
			tooltipColorBox[] = {0.6,0.6,0.6,1};
			tooltipColorShade[] = {0.302,0.302,0.302,1};
			tooltipColorText[] = {1,1,1,1};
			onMouseButtonClick = "[tfb_active_defusal] call TFB_fnc_defuse_detonate;";
			
		};
		class slot_button1
		{
			type = 1;
			idc = -1;
			x = safeZoneX + safeZoneW * 0.275625;
			y = safeZoneY + safeZoneH * 0.16888889;
			w = safeZoneW * 0.011875;
			h = safeZoneH * 0.13555556;
			style = 0;
			text = "";
			borderSize = 0;
			colorBackground[] = {0,0,0,0.05};
			colorBackgroundActive[] = {1,1,1,0.2};
			colorBackgroundDisabled[] = {0,0,0,0};
			colorBorder[] = {0,0,0,0};
			colorDisabled[] = {0,0,0,0};
			colorFocused[] = {0,0,0,0};
			colorShadow[] = {0,0,0,0};
			colorText[] = {0,0,0,0};
			font = "PuristaMedium";
			offsetPressedX = 0.0;
			offsetPressedY = 0.01;
			offsetX = 0.01;
			offsetY = 0.01;
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			soundClick[] = {"\A3\ui_f\data\sound\RscButton\soundClick",0.09,1.0};
			soundEnter[] = {"\A3\ui_f\data\sound\RscButton\soundEnter",0.09,1.0};
			soundEscape[] = {"\A3\ui_f\data\sound\RscButton\soundEscape",0.09,1.0};
			soundPush[] = {"\A3\ui_f\data\sound\RscButton\soundPush",0.09,1.0};
			onMouseButtonClick = "[101, 1, _this select 0] call TFB_fnc_defuse_cutWire;";
			
		};
		class slot_button2
		{
			type = 1;
			idc = -1;
			x = safeZoneX + safeZoneW * 0.291875;
			y = safeZoneY + safeZoneH * 0.16888889;
			w = safeZoneW * 0.011875;
			h = safeZoneH * 0.13555556;
			style = 0;
			text = "";
			borderSize = 0;
			colorBackground[] = {0,0,0,0.05};
			colorBackgroundActive[] = {1,1,1,0.2};
			colorBackgroundDisabled[] = {0,0,0,0};
			colorBorder[] = {0,0,0,0};
			colorDisabled[] = {0,0,0,0};
			colorFocused[] = {0,0,0,0};
			colorShadow[] = {0,0,0,0};
			colorText[] = {0,0,0,0};
			font = "PuristaMedium";
			offsetPressedX = 0.0;
			offsetPressedY = 0.01;
			offsetX = 0.01;
			offsetY = 0.01;
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			soundClick[] = {"\A3\ui_f\data\sound\RscButton\soundClick",0.09,1.0};
			soundEnter[] = {"\A3\ui_f\data\sound\RscButton\soundEnter",0.09,1.0};
			soundEscape[] = {"\A3\ui_f\data\sound\RscButton\soundEscape",0.09,1.0};
			soundPush[] = {"\A3\ui_f\data\sound\RscButton\soundPush",0.09,1.0};
			onMouseButtonClick = "[102, 2, _this select 0] call TFB_fnc_defuse_cutWire;";
			
		};
		class slot_button3
		{
			type = 1;
			idc = -1;
			x = safeZoneX + safeZoneW * 0.309375;
			y = safeZoneY + safeZoneH * 0.16888889;
			w = safeZoneW * 0.011875;
			h = safeZoneH * 0.13555556;
			style = 0;
			text = "";
			borderSize = 0;
			colorBackground[] = {0,0,0,0.05};
			colorBackgroundActive[] = {1,1,1,0.2};
			colorBackgroundDisabled[] = {0,0,0,0};
			colorBorder[] = {0,0,0,0};
			colorDisabled[] = {0,0,0,0};
			colorFocused[] = {0,0,0,0};
			colorShadow[] = {0,0,0,0};
			colorText[] = {0,0,0,0};
			font = "PuristaMedium";
			offsetPressedX = 0.0;
			offsetPressedY = 0.01;
			offsetX = 0.01;
			offsetY = 0.01;
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			soundClick[] = {"\A3\ui_f\data\sound\RscButton\soundClick",0.09,1.0};
			soundEnter[] = {"\A3\ui_f\data\sound\RscButton\soundEnter",0.09,1.0};
			soundEscape[] = {"\A3\ui_f\data\sound\RscButton\soundEscape",0.09,1.0};
			soundPush[] = {"\A3\ui_f\data\sound\RscButton\soundPush",0.09,1.0};
			onMouseButtonClick = "[103, 3, _this select 0] call TFB_fnc_defuse_cutWire;";
			
		};
		class slot_button4
		{
			type = 1;
			idc = -1;
			x = safeZoneX + safeZoneW * 0.325625;
			y = safeZoneY + safeZoneH * 0.16888889;
			w = safeZoneW * 0.011875;
			h = safeZoneH * 0.13555556;
			style = 0;
			text = "";
			borderSize = 0;
			colorBackground[] = {0,0,0,0.05};
			colorBackgroundActive[] = {1,1,1,0.2};
			colorBackgroundDisabled[] = {0,0,0,0};
			colorBorder[] = {0,0,0,0};
			colorDisabled[] = {0,0,0,0};
			colorFocused[] = {0,0,0,0};
			colorShadow[] = {0,0,0,0};
			colorText[] = {0,0,0,0};
			font = "PuristaMedium";
			offsetPressedX = 0.0;
			offsetPressedY = 0.01;
			offsetX = 0.01;
			offsetY = 0.01;
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			soundClick[] = {"\A3\ui_f\data\sound\RscButton\soundClick",0.09,1.0};
			soundEnter[] = {"\A3\ui_f\data\sound\RscButton\soundEnter",0.09,1.0};
			soundEscape[] = {"\A3\ui_f\data\sound\RscButton\soundEscape",0.09,1.0};
			soundPush[] = {"\A3\ui_f\data\sound\RscButton\soundPush",0.09,1.0};
			onMouseButtonClick = "[104, 4, _this select 0] call TFB_fnc_defuse_cutWire;";
			
		};
		class slot_button5
		{
			type = 1;
			idc = -1;
			x = safeZoneX + safeZoneW * 0.34375;
			y = safeZoneY + safeZoneH * 0.16888889;
			w = safeZoneW * 0.011875;
			h = safeZoneH * 0.13555556;
			style = 0;
			text = "";
			borderSize = 0;
			colorBackground[] = {0,0,0,0.05};
			colorBackgroundActive[] = {1,1,1,0.2};
			colorBackgroundDisabled[] = {0,0,0,0};
			colorBorder[] = {0,0,0,0};
			colorDisabled[] = {0,0,0,0};
			colorFocused[] = {0,0,0,0};
			colorShadow[] = {0,0,0,0};
			colorText[] = {0,0,0,0};
			font = "PuristaMedium";
			offsetPressedX = 0.0;
			offsetPressedY = 0.01;
			offsetX = 0.01;
			offsetY = 0.01;
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			soundClick[] = {"\A3\ui_f\data\sound\RscButton\soundClick",0.09,1.0};
			soundEnter[] = {"\A3\ui_f\data\sound\RscButton\soundEnter",0.09,1.0};
			soundEscape[] = {"\A3\ui_f\data\sound\RscButton\soundEscape",0.09,1.0};
			soundPush[] = {"\A3\ui_f\data\sound\RscButton\soundPush",0.09,1.0};
			onMouseButtonClick = "[105, 5, _this select 0] call TFB_fnc_defuse_cutWire;";
			
		};
		class slot_button6
		{
			type = 1;
			idc = -1;
			x = safeZoneX + safeZoneW * 0.360625;
			y = safeZoneY + safeZoneH * 0.16888889;
			w = safeZoneW * 0.011875;
			h = safeZoneH * 0.13555556;
			style = 0;
			text = "";
			borderSize = 0;
			colorBackground[] = {0,0,0,0.05};
			colorBackgroundActive[] = {1,1,1,0.2};
			colorBackgroundDisabled[] = {0,0,0,0};
			colorBorder[] = {0,0,0,0};
			colorDisabled[] = {0,0,0,0};
			colorFocused[] = {0,0,0,0};
			colorShadow[] = {0,0,0,0};
			colorText[] = {0,0,0,0};
			font = "PuristaMedium";
			offsetPressedX = 0.0;
			offsetPressedY = 0.01;
			offsetX = 0.01;
			offsetY = 0.01;
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			soundClick[] = {"\A3\ui_f\data\sound\RscButton\soundClick",0.09,1.0};
			soundEnter[] = {"\A3\ui_f\data\sound\RscButton\soundEnter",0.09,1.0};
			soundEscape[] = {"\A3\ui_f\data\sound\RscButton\soundEscape",0.09,1.0};
			soundPush[] = {"\A3\ui_f\data\sound\RscButton\soundPush",0.09,1.0};
			onMouseButtonClick = "[106, 6, _this select 0] call TFB_fnc_defuse_cutWire;";
			
		};
		class slot_button7
		{
			type = 1;
			idc = -1;
			x = safeZoneX + safeZoneW * 0.378125;
			y = safeZoneY + safeZoneH * 0.16888889;
			w = safeZoneW * 0.011875;
			h = safeZoneH * 0.13555556;
			style = 0;
			text = "";
			borderSize = 0;
			colorBackground[] = {0,0,0,0.05};
			colorBackgroundActive[] = {1,1,1,0.2};
			colorBackgroundDisabled[] = {0,0,0,0};
			colorBorder[] = {0,0,0,0};
			colorDisabled[] = {0,0,0,0};
			colorFocused[] = {0,0,0,0};
			colorShadow[] = {0,0,0,0};
			colorText[] = {0,0,0,0};
			font = "PuristaMedium";
			offsetPressedX = 0.0;
			offsetPressedY = 0.01;
			offsetX = 0.01;
			offsetY = 0.01;
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			soundClick[] = {"\A3\ui_f\data\sound\RscButton\soundClick",0.09,1.0};
			soundEnter[] = {"\A3\ui_f\data\sound\RscButton\soundEnter",0.09,1.0};
			soundEscape[] = {"\A3\ui_f\data\sound\RscButton\soundEscape",0.09,1.0};
			soundPush[] = {"\A3\ui_f\data\sound\RscButton\soundPush",0.09,1.0};
			onMouseButtonClick = "[107, 7, _this select 0] call TFB_fnc_defuse_cutWire;";
			
		};
		class slot_button8
		{
			type = 1;
			idc = -1;
			x = safeZoneX + safeZoneW * 0.395;
			y = safeZoneY + safeZoneH * 0.16888889;
			w = safeZoneW * 0.011875;
			h = safeZoneH * 0.13555556;
			style = 0;
			text = "";
			borderSize = 0;
			colorBackground[] = {0,0,0,0.05};
			colorBackgroundActive[] = {1,1,1,0.2};
			colorBackgroundDisabled[] = {0,0,0,0};
			colorBorder[] = {0,0,0,0};
			colorDisabled[] = {0,0,0,0};
			colorFocused[] = {0,0,0,0};
			colorShadow[] = {0,0,0,0};
			colorText[] = {0,0,0,0};
			font = "PuristaMedium";
			offsetPressedX = 0.0;
			offsetPressedY = 0.01;
			offsetX = 0.01;
			offsetY = 0.01;
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			soundClick[] = {"\A3\ui_f\data\sound\RscButton\soundClick",0.09,1.0};
			soundEnter[] = {"\A3\ui_f\data\sound\RscButton\soundEnter",0.09,1.0};
			soundEscape[] = {"\A3\ui_f\data\sound\RscButton\soundEscape",0.09,1.0};
			soundPush[] = {"\A3\ui_f\data\sound\RscButton\soundPush",0.09,1.0};
			onMouseButtonClick = "[108, 8, _this select 0] call TFB_fnc_defuse_cutWire;";
			
		};
		class keypad_star
		{
			type = 1;
			idc = -1;
			x = safeZoneX + safeZoneW * 0.286875;
			y = safeZoneY + safeZoneH * 0.79777778;
			w = safeZoneW * 0.0175;
			h = safeZoneH * 0.02666667;
			style = 0;
			text = "Reset Code";
			borderSize = 0;
			colorBackground[] = {0,0,0,0};
			colorBackgroundActive[] = {1,1,1,0.25};
			colorBackgroundDisabled[] = {0,0,0,0};
			colorBorder[] = {0,0,0,0};
			colorDisabled[] = {0.2,0.2,0.2,1};
			colorFocused[] = {0,0,0,0};
			colorShadow[] = {0,0,0,0};
			colorText[] = {0,0,0,0};
			font = "PuristaMedium";
			offsetPressedX = 0.0015;
			offsetPressedY = 0.0025;
			offsetX = 0;
			offsetY = 0;
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			soundClick[] = {"\A3\Sounds_F\arsenal\Tools\MineDetector_Beep_01.wss",0.75,0.75};
			soundEnter[] = {"\A3\ui_f\data\sound\RscButton\soundEnter",0.09,1.0};
			soundEscape[] = {"\A3\ui_f\data\sound\RscButton\soundEscape",0.09,1.0};
			soundPush[] = {"\A3\ui_f\data\sound\RscButton\soundPush",0.09,1.0};
			tooltip = "Reset Code";
			tooltipColorBox[] = {0.6,0.6,0.6,1};
			tooltipColorShade[] = {0.302,0.302,0.302,1};
			tooltipColorText[] = {1,1,1,1};
			onMouseButtonClick = "['reset'] call TFB_fnc_defuse_inputKeypad;";
			onMouseButtonDblClick = "['reset'] call TFB_fnc_defuse_inputKeypad;";
			
		};
		class keypad_0
		{
			type = 1;
			idc = -1;
			x = safeZoneX + safeZoneW * 0.31625;
			y = safeZoneY + safeZoneH * 0.79777778;
			w = safeZoneW * 0.0175;
			h = safeZoneH * 0.02666667;
			style = 0;
			text = "";
			borderSize = 0;
			colorBackground[] = {0,0,0,0};
			colorBackgroundActive[] = {1,1,1,0.25};
			colorBackgroundDisabled[] = {0,0,0,0};
			colorBorder[] = {0,0,0,0};
			colorDisabled[] = {0.2,0.2,0.2,1};
			colorFocused[] = {0,0,0,0};
			colorShadow[] = {0,0,0,0};
			colorText[] = {0.9765,0.8118,0.2902,1};
			font = "PuristaMedium";
			offsetPressedX = 0.0015;
			offsetPressedY = 0.0025;
			offsetX = 0;
			offsetY = 0;
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			soundClick[] = {"\A3\Sounds_F\arsenal\Tools\MineDetector_Beep_01.wss",0.75,0.55};
			soundEnter[] = {"\A3\ui_f\data\sound\RscButton\soundEnter",0.09,1.0};
			soundEscape[] = {"\A3\ui_f\data\sound\RscButton\soundEscape",0.09,1.0};
			soundPush[] = {"\A3\ui_f\data\sound\RscButton\soundPush",0.09,1.0};
			onMouseButtonClick = "['0'] call TFB_fnc_defuse_inputKeypad;";
			onMouseButtonDblClick = "['0'] call TFB_fnc_defuse_inputKeypad; ['0'] call TFB_fnc_defuse_inputKeypad;";
			
		};
		class keypad_hex
		{
			type = 1;
			idc = -1;
			x = safeZoneX + safeZoneW * 0.34625;
			y = safeZoneY + safeZoneH * 0.79777778;
			w = safeZoneW * 0.0175;
			h = safeZoneH * 0.02666667;
			style = 0;
			text = "";
			borderSize = 0;
			colorBackground[] = {0,0,0,0};
			colorBackgroundActive[] = {1,1,1,0.25};
			colorBackgroundDisabled[] = {0,0,0,0};
			colorBorder[] = {0,0,0,0};
			colorDisabled[] = {0.2,0.2,0.2,1};
			colorFocused[] = {0,0,0,0};
			colorShadow[] = {0,0,0,0};
			colorText[] = {0.9765,0.8118,0.2902,1};
			font = "PuristaMedium";
			offsetPressedX = 0.0015;
			offsetPressedY = 0.0025;
			offsetX = 0;
			offsetY = 0;
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			soundClick[] = {"\A3\Sounds_F\arsenal\Tools\MineDetector_Beep_01.wss",0.75,0.75};
			soundEnter[] = {"\A3\ui_f\data\sound\RscButton\soundEnter",0.09,1.0};
			soundEscape[] = {"\A3\ui_f\data\sound\RscButton\soundEscape",0.09,1.0};
			soundPush[] = {"\A3\ui_f\data\sound\RscButton\soundPush",0.09,1.0};
			tooltip = "Enter";
			tooltipColorBox[] = {0.6,0.6,0.6,1};
			tooltipColorShade[] = {0.302,0.302,0.302,1};
			tooltipColorText[] = {1,1,1,1};
			onMouseButtonClick = "['enter'] call TFB_fnc_defuse_inputKeypad;";
			onMouseButtonDblClick = "['enter'] call TFB_fnc_defuse_inputKeypad;";
			
		};
		class keypad_1
		{
			type = 1;
			idc = -1;
			x = safeZoneX + safeZoneW * 0.2875;
			y = safeZoneY + safeZoneH * 0.74222223;
			w = safeZoneW * 0.0175;
			h = safeZoneH * 0.02666667;
			style = 0;
			text = "Reset Code";
			borderSize = 0;
			colorBackground[] = {0,0,0,0};
			colorBackgroundActive[] = {1,1,1,0.25};
			colorBackgroundDisabled[] = {0,0,0,0};
			colorBorder[] = {0,0,0,0};
			colorDisabled[] = {0.2,0.2,0.2,1};
			colorFocused[] = {0,0,0,0};
			colorShadow[] = {0,0,0,0};
			colorText[] = {0,0,0,0};
			font = "PuristaMedium";
			offsetPressedX = 0.0015;
			offsetPressedY = 0.0025;
			offsetX = 0;
			offsetY = 0;
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			soundClick[] = {"\A3\Sounds_F\arsenal\Tools\MineDetector_Beep_01.wss",0.75,0.50};
			soundEnter[] = {"\A3\ui_f\data\sound\RscButton\soundEnter",0.09,1.0};
			soundEscape[] = {"\A3\ui_f\data\sound\RscButton\soundEscape",0.09,1.0};
			soundPush[] = {"\A3\ui_f\data\sound\RscButton\soundPush",0.09,1.0};
			tooltip = "";
			tooltipColorBox[] = {0,0,0,0};
			tooltipColorShade[] = {0,0,0,0};
			tooltipColorText[] = {0,0,0,0};
			onMouseButtonClick = "['1'] call TFB_fnc_defuse_inputKeypad;";
			onMouseButtonDblClick = "['11'] call TFB_fnc_defuse_inputKeypad;";
			
		};
		class keypad_2
		{
			type = 1;
			idc = -1;
			x = safeZoneX + safeZoneW * 0.316875;
			y = safeZoneY + safeZoneH * 0.74222223;
			w = safeZoneW * 0.0175;
			h = safeZoneH * 0.02666667;
			style = 0;
			text = "";
			borderSize = 0;
			colorBackground[] = {0,0,0,0};
			colorBackgroundActive[] = {1,1,1,0.25};
			colorBackgroundDisabled[] = {0,0,0,0};
			colorBorder[] = {0,0,0,0};
			colorDisabled[] = {0.2,0.2,0.2,1};
			colorFocused[] = {0,0,0,0};
			colorShadow[] = {0,0,0,0};
			colorText[] = {0.9765,0.8118,0.2902,1};
			font = "PuristaMedium";
			offsetPressedX = 0.0015;
			offsetPressedY = 0.0025;
			offsetX = 0;
			offsetY = 0;
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			soundClick[] = {"\A3\Sounds_F\arsenal\Tools\MineDetector_Beep_01.wss",0.75,0.55};
			soundEnter[] = {"\A3\ui_f\data\sound\RscButton\soundEnter",0.09,1.0};
			soundEscape[] = {"\A3\ui_f\data\sound\RscButton\soundEscape",0.09,1.0};
			soundPush[] = {"\A3\ui_f\data\sound\RscButton\soundPush",0.09,1.0};
			onMouseButtonClick = "['2'] call TFB_fnc_defuse_inputKeypad;";
			onMouseButtonDblClick = "['22'] call TFB_fnc_defuse_inputKeypad;";
			
		};
		class keypad_3
		{
			type = 1;
			idc = -1;
			x = safeZoneX + safeZoneW * 0.345625;
			y = safeZoneY + safeZoneH * 0.74333334;
			w = safeZoneW * 0.0175;
			h = safeZoneH * 0.02666667;
			style = 0;
			text = "";
			borderSize = 0;
			colorBackground[] = {0,0,0,0};
			colorBackgroundActive[] = {1,1,1,0.25};
			colorBackgroundDisabled[] = {0,0,0,0};
			colorBorder[] = {0,0,0,0};
			colorDisabled[] = {0.2,0.2,0.2,1};
			colorFocused[] = {0,0,0,0};
			colorShadow[] = {0,0,0,0};
			colorText[] = {0.9765,0.8118,0.2902,1};
			font = "PuristaMedium";
			offsetPressedX = 0.0015;
			offsetPressedY = 0.0025;
			offsetX = 0;
			offsetY = 0;
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			soundClick[] = {"\A3\Sounds_F\arsenal\Tools\MineDetector_Beep_01.wss",0.75,0.60};
			soundEnter[] = {"\A3\ui_f\data\sound\RscButton\soundEnter",0.09,1.0};
			soundEscape[] = {"\A3\ui_f\data\sound\RscButton\soundEscape",0.09,1.0};
			soundPush[] = {"\A3\ui_f\data\sound\RscButton\soundPush",0.09,1.0};
			tooltip = "";
			tooltipColorBox[] = {0,0,0,0};
			tooltipColorShade[] = {0,0,0,0};
			tooltipColorText[] = {0,0,0,0};
			onMouseButtonClick = "['3'] call TFB_fnc_defuse_inputKeypad;";
			onMouseButtonDblClick = "['33'] call TFB_fnc_defuse_inputKeypad;";
			
		};
		class keypad_4
		{
			type = 1;
			idc = -1;
			x = safeZoneX + safeZoneW * 0.286875;
			y = safeZoneY + safeZoneH * 0.68666667;
			w = safeZoneW * 0.0175;
			h = safeZoneH * 0.02666667;
			style = 0;
			text = "Reset Code";
			borderSize = 0;
			colorBackground[] = {0,0,0,0};
			colorBackgroundActive[] = {1,1,1,0.25};
			colorBackgroundDisabled[] = {0,0,0,0};
			colorBorder[] = {0,0,0,0};
			colorDisabled[] = {0.2,0.2,0.2,1};
			colorFocused[] = {0,0,0,0};
			colorShadow[] = {0,0,0,0};
			colorText[] = {0,0,0,0};
			font = "PuristaMedium";
			offsetPressedX = 0.0015;
			offsetPressedY = 0.0025;
			offsetX = 0;
			offsetY = 0;
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			soundClick[] = {"\A3\Sounds_F\arsenal\Tools\MineDetector_Beep_01.wss",0.75,0.65};
			soundEnter[] = {"\A3\ui_f\data\sound\RscButton\soundEnter",0.09,1.0};
			soundEscape[] = {"\A3\ui_f\data\sound\RscButton\soundEscape",0.09,1.0};
			soundPush[] = {"\A3\ui_f\data\sound\RscButton\soundPush",0.09,1.0};
			tooltip = "";
			tooltipColorBox[] = {0,0,0,0};
			tooltipColorShade[] = {0,0,0,0};
			tooltipColorText[] = {0,0,0,0};
			onMouseButtonClick = "['4'] call TFB_fnc_defuse_inputKeypad;";
			onMouseButtonDblClick = "['44'] call TFB_fnc_defuse_inputKeypad;";
			
		};
		class keypad_5
		{
			type = 1;
			idc = -1;
			x = safeZoneX + safeZoneW * 0.31625;
			y = safeZoneY + safeZoneH * 0.68666667;
			w = safeZoneW * 0.0175;
			h = safeZoneH * 0.02666667;
			style = 0;
			text = "";
			borderSize = 0;
			colorBackground[] = {0,0,0,0};
			colorBackgroundActive[] = {1,1,1,0.25};
			colorBackgroundDisabled[] = {0,0,0,0};
			colorBorder[] = {0,0,0,0};
			colorDisabled[] = {0.2,0.2,0.2,1};
			colorFocused[] = {0,0,0,0};
			colorShadow[] = {0,0,0,0};
			colorText[] = {0.9765,0.8118,0.2902,1};
			font = "PuristaMedium";
			offsetPressedX = 0.0015;
			offsetPressedY = 0.0025;
			offsetX = 0;
			offsetY = 0;
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			soundClick[] = {"\A3\Sounds_F\arsenal\Tools\MineDetector_Beep_01.wss",0.75,0.70};
			soundEnter[] = {"\A3\ui_f\data\sound\RscButton\soundEnter",0.09,1.0};
			soundEscape[] = {"\A3\ui_f\data\sound\RscButton\soundEscape",0.09,1.0};
			soundPush[] = {"\A3\ui_f\data\sound\RscButton\soundPush",0.09,1.0};
			onMouseButtonClick = "['5'] call TFB_fnc_defuse_inputKeypad;";
			onMouseButtonDblClick = "['55'] call TFB_fnc_defuse_inputKeypad;";
			
		};
		class keypad_6
		{
			type = 1;
			idc = -1;
			x = safeZoneX + safeZoneW * 0.345625;
			y = safeZoneY + safeZoneH * 0.68666667;
			w = safeZoneW * 0.0175;
			h = safeZoneH * 0.02666667;
			style = 0;
			text = "";
			borderSize = 0;
			colorBackground[] = {0,0,0,0};
			colorBackgroundActive[] = {1,1,1,0.25};
			colorBackgroundDisabled[] = {0,0,0,0};
			colorBorder[] = {0,0,0,0};
			colorDisabled[] = {0.2,0.2,0.2,1};
			colorFocused[] = {0,0,0,0};
			colorShadow[] = {0,0,0,0};
			colorText[] = {0.9765,0.8118,0.2902,1};
			font = "PuristaMedium";
			offsetPressedX = 0.0015;
			offsetPressedY = 0.0025;
			offsetX = 0;
			offsetY = 0;
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			soundClick[] = {"\A3\Sounds_F\arsenal\Tools\MineDetector_Beep_01.wss",0.75,0.75};
			soundEnter[] = {"\A3\ui_f\data\sound\RscButton\soundEnter",0.09,1.0};
			soundEscape[] = {"\A3\ui_f\data\sound\RscButton\soundEscape",0.09,1.0};
			soundPush[] = {"\A3\ui_f\data\sound\RscButton\soundPush",0.09,1.0};
			tooltip = "";
			tooltipColorBox[] = {0,0,0,0};
			tooltipColorShade[] = {0,0,0,0};
			tooltipColorText[] = {0,0,0,0};
			onMouseButtonClick = "['6'] call TFB_fnc_defuse_inputKeypad;";
			onMouseButtonDblClick = "['66'] call TFB_fnc_defuse_inputKeypad;";
			
		};
		class keypad_7
		{
			type = 1;
			idc = -1;
			x = safeZoneX + safeZoneW * 0.286875;
			y = safeZoneY + safeZoneH * 0.63;
			w = safeZoneW * 0.0175;
			h = safeZoneH * 0.02666667;
			style = 0;
			text = "Reset Code";
			borderSize = 0;
			colorBackground[] = {0,0,0,0};
			colorBackgroundActive[] = {1,1,1,0.25};
			colorBackgroundDisabled[] = {0,0,0,0};
			colorBorder[] = {0,0,0,0};
			colorDisabled[] = {0.2,0.2,0.2,1};
			colorFocused[] = {0,0,0,0};
			colorShadow[] = {0,0,0,0};
			colorText[] = {0,0,0,0};
			font = "PuristaMedium";
			offsetPressedX = 0.0015;
			offsetPressedY = 0.0025;
			offsetX = 0;
			offsetY = 0;
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			soundClick[] = {"\A3\Sounds_F\arsenal\Tools\MineDetector_Beep_01.wss",0.75,0.80};
			soundEnter[] = {"\A3\ui_f\data\sound\RscButton\soundEnter",0.09,1.0};
			soundEscape[] = {"\A3\ui_f\data\sound\RscButton\soundEscape",0.09,1.0};
			soundPush[] = {"\A3\ui_f\data\sound\RscButton\soundPush",0.09,1.0};
			tooltip = "";
			tooltipColorBox[] = {0,0,0,0};
			tooltipColorShade[] = {0,0,0,0};
			tooltipColorText[] = {0,0,0,0};
			onMouseButtonClick = "['7'] call TFB_fnc_defuse_inputKeypad;";
			onMouseButtonDblClick = "['77'] call TFB_fnc_defuse_inputKeypad;";
			
		};
		class keypad_8
		{
			type = 1;
			idc = -1;
			x = safeZoneX + safeZoneW * 0.31625;
			y = safeZoneY + safeZoneH * 0.63;
			w = safeZoneW * 0.0175;
			h = safeZoneH * 0.02666667;
			style = 0;
			text = "";
			borderSize = 0;
			colorBackground[] = {0,0,0,0};
			colorBackgroundActive[] = {1,1,1,0.25};
			colorBackgroundDisabled[] = {0,0,0,0};
			colorBorder[] = {0,0,0,0};
			colorDisabled[] = {0.2,0.2,0.2,1};
			colorFocused[] = {0,0,0,0};
			colorShadow[] = {0,0,0,0};
			colorText[] = {0.9765,0.8118,0.2902,1};
			font = "PuristaMedium";
			offsetPressedX = 0.0015;
			offsetPressedY = 0.0025;
			offsetX = 0;
			offsetY = 0;
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			soundClick[] = {"\A3\Sounds_F\arsenal\Tools\MineDetector_Beep_01.wss",0.75,0.85};
			soundEnter[] = {"\A3\ui_f\data\sound\RscButton\soundEnter",0.09,1.0};
			soundEscape[] = {"\A3\ui_f\data\sound\RscButton\soundEscape",0.09,1.0};
			soundPush[] = {"\A3\ui_f\data\sound\RscButton\soundPush",0.09,1.0};
			onMouseButtonClick = "['8'] call TFB_fnc_defuse_inputKeypad;";
			onMouseButtonDblClick = "['88'] call TFB_fnc_defuse_inputKeypad;";
			
		};
		class keypad_9
		{
			type = 1;
			idc = -1;
			x = safeZoneX + safeZoneW * 0.345625;
			y = safeZoneY + safeZoneH * 0.63;
			w = safeZoneW * 0.0175;
			h = safeZoneH * 0.02666667;
			style = 0;
			text = "";
			borderSize = 0;
			colorBackground[] = {0,0,0,0};
			colorBackgroundActive[] = {1,1,1,0.25};
			colorBackgroundDisabled[] = {0,0,0,0};
			colorBorder[] = {0,0,0,0};
			colorDisabled[] = {0.2,0.2,0.2,1};
			colorFocused[] = {0,0,0,0};
			colorShadow[] = {0,0,0,0};
			colorText[] = {0.9765,0.8118,0.2902,1};
			font = "PuristaMedium";
			offsetPressedX = 0.0015;
			offsetPressedY = 0.0025;
			offsetX = 0;
			offsetY = 0;
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			soundClick[] = {"\A3\Sounds_F\arsenal\Tools\MineDetector_Beep_01.wss",0.75,0.90};
			soundEnter[] = {"\A3\ui_f\data\sound\RscButton\soundEnter",0.09,1.0};
			soundEscape[] = {"\A3\ui_f\data\sound\RscButton\soundEscape",0.09,1.0};
			soundPush[] = {"\A3\ui_f\data\sound\RscButton\soundPush",0.09,1.0};
			tooltip = "";
			tooltipColorBox[] = {0,0,0,0};
			tooltipColorShade[] = {0,0,0,0};
			tooltipColorText[] = {0,0,0,0};
			onMouseButtonClick = "['9'] call TFB_fnc_defuse_inputKeypad;";
			onMouseButtonDblClick = "['99'] call TFB_fnc_defuse_inputKeypad;";
			
		};
		class clipboard_next
		{
			type = 1;
			idc = -1;
			x = safeZoneX + safeZoneW * 0.716875;
			y = safeZoneY + safeZoneH * 0.81666667;
			w = safeZoneW * 0.075;
			h = safeZoneH * 0.03222223;
			style = 0+2;
			text = "Next Page";
			borderSize = 0;
			colorBackground[] = {0,0,0,0};
			colorBackgroundActive[] = {0,0,0,0.35};
			colorBackgroundDisabled[] = {0,0,0,0};
			colorBorder[] = {0,0,0,0};
			colorDisabled[] = {0,0,0,0};
			colorFocused[] = {0,0,0,0};
			colorShadow[] = {0,0,0,0};
			colorText[] = {0,0,0,1};
			font = "PuristaMedium";
			offsetPressedX = 0.01;
			offsetPressedY = 0.01;
			offsetX = 0.01;
			offsetY = 0.01;
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			soundClick[] = {"\A3\ui_f\data\sound\RscButton\soundClick",0.09,1.0};
			soundEnter[] = {"\A3\ui_f\data\sound\RscButton\soundEnter",0.09,1.0};
			soundEscape[] = {"\A3\ui_f\data\sound\RscButton\soundEscape",0.09,1.0};
			soundPush[] = {"\A3\ui_f\data\sound\RscButton\soundPush",0.09,1.0};
			onMouseButtonClick = "[true] call TFB_fnc_defuse_updateClipboard;";
			
		};
		class clipboard_prev
		{
			type = 1;
			idc = -1;
			x = safeZoneX + safeZoneW * 0.505;
			y = safeZoneY + safeZoneH * 0.81666667;
			w = safeZoneW * 0.075;
			h = safeZoneH * 0.03222223;
			style = 0+2;
			text = "Prev Page";
			borderSize = 0;
			colorBackground[] = {0,0,0,0};
			colorBackgroundActive[] = {0,0,0,0.35};
			colorBackgroundDisabled[] = {0,0,0,0};
			colorBorder[] = {0,0,0,0};
			colorDisabled[] = {0,0,0,0};
			colorFocused[] = {0,0,0,0};
			colorShadow[] = {0,0,0,0};
			colorText[] = {0,0,0,1};
			font = "PuristaMedium";
			offsetPressedX = 0.01;
			offsetPressedY = 0.01;
			offsetX = 0.01;
			offsetY = 0.01;
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			soundClick[] = {"\A3\ui_f\data\sound\RscButton\soundClick",0.09,1.0};
			soundEnter[] = {"\A3\ui_f\data\sound\RscButton\soundEnter",0.09,1.0};
			soundEscape[] = {"\A3\ui_f\data\sound\RscButton\soundEscape",0.09,1.0};
			soundPush[] = {"\A3\ui_f\data\sound\RscButton\soundPush",0.09,1.0};
			onMouseButtonClick = "[false] call TFB_fnc_defuse_updateClipboard;";
			
		};
		class button_black
		{
			type = 1;
			idc = -1;
			x = safeZoneX + safeZoneW * 0.1925;
			y = safeZoneY + safeZoneH * 0.294;
			w = safeZoneW * 0.02375;
			h = safeZoneH * 0.04555556;
			style = 0;
			text = "";
			borderSize = 0;
			colorBackground[] = {0,0,0,0};
			colorBackgroundActive[] = {1,1,1,0.25};
			colorBackgroundDisabled[] = {0,0,0,0};
			colorBorder[] = {0,0,0,0};
			colorDisabled[] = {0.2,0.2,0.2,1};
			colorFocused[] = {0,0,0,0};
			colorShadow[] = {0,0,0,0};
			colorText[] = {0.9765,0.8118,0.2902,1};
			font = "PuristaMedium";
			offsetPressedX = 0.02;
			offsetPressedY = 0.02;
			offsetX = 0.01;
			offsetY = 0.01;
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			soundClick[] = {"\A3\ui_f\data\sound\RscButton\soundClick",0.09,1.0};
			soundEnter[] = {"\A3\ui_f\data\sound\RscButton\soundEnter",0.09,1.0};
			soundEscape[] = {"\A3\ui_f\data\sound\RscButton\soundEscape",0.09,1.0};
			soundPush[] = {"\A3\ui_f\data\sound\RscButton\soundPush",0.09,1.0};
			onMouseButtonClick = "['buttonBlack'] call TFB_fnc_defuse_inputKeypad;";
			tooltip = "Change Mode";
			tooltipColorBox[] = {0.6,0.6,0.6,1};
			tooltipColorShade[] = {0.302,0.302,0.302,1};
			tooltipColorText[] = {1,1,1,1};
			
		};
		class button_red
		{
			type = 1;
			idc = -1;
			x = safeZoneX + safeZoneW * 0.1925;
			y = safeZoneY + safeZoneH * 0.349;
			w = safeZoneW * 0.02375;
			h = safeZoneH * 0.04555556;
			style = 0;
			text = "";
			borderSize = 0;
			colorBackground[] = {0,0,0,0};
			colorBackgroundActive[] = {1,1,1,0.25};
			colorBackgroundDisabled[] = {0,0,0,0};
			colorBorder[] = {0,0,0,0};
			colorDisabled[] = {0.2,0.2,0.2,1};
			colorFocused[] = {0,0,0,0};
			colorShadow[] = {0,0,0,0};
			colorText[] = {0.9765,0.8118,0.2902,1};
			font = "PuristaMedium";
			offsetPressedX = 0.02;
			offsetPressedY = 0.02;
			offsetX = 0.01;
			offsetY = 0.01;
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			soundClick[] = {"\A3\ui_f\data\sound\RscButton\soundClick",0.09,1.0};
			soundEnter[] = {"\A3\ui_f\data\sound\RscButton\soundEnter",0.09,1.0};
			soundEscape[] = {"\A3\ui_f\data\sound\RscButton\soundEscape",0.09,1.0};
			soundPush[] = {"\A3\ui_f\data\sound\RscButton\soundPush",0.09,1.0};
			onMouseButtonClick = "['buttonRed'] call TFB_fnc_defuse_inputKeypad;";
			onMouseButtonDblClick = "[tfb_active_defusal] call TFB_fnc_defuse_detonate;";
			tooltip = "Arm";
			tooltipColorBox[] = {0.6,0.6,0.6,1};
			tooltipColorShade[] = {0.302,0.302,0.302,1};
			tooltipColorText[] = {1,1,1,1};
			
		};
	};
	
};