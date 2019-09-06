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

// Default grid
#define GUI_GRID_WAbs		((safezoneW / safezoneH) min 1.2)
#define GUI_GRID_HAbs		(GUI_GRID_WAbs / 1.2)
#define GUI_GRID_W			(GUI_GRID_WAbs / 40)
#define GUI_GRID_H			(GUI_GRID_HAbs / 25)
#define GUI_GRID_X			(safezoneX)
#define GUI_GRID_Y			(safezoneY + safezoneH - GUI_GRID_HAbs)

// Default text sizes
#define GUI_TEXT_SIZE_SMALL		(GUI_GRID_H * 0.8)
#define GUI_TEXT_SIZE_MEDIUM	(GUI_GRID_H * 1)
#define GUI_TEXT_SIZE_LARGE		(GUI_GRID_H * 1.2)

// Pixel grid
#define pixelScale	0.50
#define GRID_W (pixelW * pixelGrid * pixelScale)
#define GRID_H (pixelH * pixelGrid * pixelScale)


class ScrollBar {
	color[] = {1, 1, 1, 0.6};
	colorActive[] = {1, 1, 1, 1};
	colorDisabled[] = {1, 1, 1, 0.3};
	thumb = "\A3\ui_f\data\gui\cfg\scrollbar\thumb_ca.paa";
	arrowEmpty = "\A3\ui_f\data\gui\cfg\scrollbar\arrowEmpty_ca.paa";
	arrowFull = "\A3\ui_f\data\gui\cfg\scrollbar\arrowFull_ca.paa";
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

class RscItemListBox {
	deletable = 0;
	fade = 0;
	access = 0;
	type = CT_LISTBOX;
	rowHeight = "4.32 * (1 / (getResolution select 3)) * pixelGrid * 1.5"; //0; //"1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
	colorText[] = {1, 1, 1, 1};
	colorDisabled[] = {1, 1, 1, 0.25};
	colorScrollbar[] = {1, 0, 0, 0};
	colorSelect[] = {0, 0, 0, 1};
	colorSelect2[] = {0, 0, 0, 1};
	colorSelectBackground[] = {0.95, 0.95, 0.95, 1};
	colorSelectBackground2[] = {1, 1, 1, 0.5};
	colorBackground[] = {1, 1, 1, 0.15};
	soundSelect[] = {
		"\A3\ui_f\data\sound\RscListbox\soundSelect",
		0.09,
		1
	};
	autoScrollSpeed = -1;
	autoScrollDelay = 5;
	autoScrollRewind = 0;
	arrowEmpty = "\A3\ui_f\data\gui\cfg\scrollbar\arrowEmpty_ca.paa";
	arrowFull = "\A3\ui_f\data\gui\cfg\scrollbar\arrowFull_ca.paa";
	colorPicture[] = {1, 1, 1, 1};
	colorPictureSelected[] = {1, 1, 1, 1};
	colorPictureDisabled[] = {1, 1, 1, 0.25};
	colorPictureRight[] = {1, 1, 1, 1};
	colorPictureRightSelected[] = {1, 1, 1, 1};
	colorPictureRightDisabled[] = {1, 1, 1, 0.25};
	colorTextRight[] = {1, 1, 1, 1};
	colorSelectRight[] = {0, 0, 0, 1};
	colorSelect2Right[] = {0, 0, 0, 1};
	tooltipColorText[] = {1, 1, 1, 1};
	tooltipColorBox[] = {1, 1, 1, 1};
	tooltipColorShade[] = {0, 0, 0, 0.65};

	class ListScrollBar: ScrollBar {
		color[] = {1, 1, 1, 1};
		autoScrollEnabled = 1;
	};

	x = 0;
	y = 0;
	w = 0.3;
	h = 0.3;
	style = 16; //LB_TEXTURES
	font = "RobotoCondensedLight";
	shadow = 0;
	colorShadow[] = {0, 0, 0, 0.5};
	period = 0;
	maxHistoryDelay = 1;
	itemSpacing = 0; //"(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
	itemBackground[] = {0, 1, 1, 1};
};


class HALsStore_RscText {
	deletable = 0;
	fade = 0;
	access = 0;
	type = CT_STATIC;
	idc = -1;
	colorBackground[] = {0,0,0,0};
	colorText[] = {1,1,1,1};
	text = "";
	fixedWidth = 0;
	x = 0;
	y = 0;
	h = 0.037;
	w = 0.3;
	style = ST_LEFT;
	shadow = 1;
	colorShadow[] = {0,0,0,0.5};
	font = "RobotoCondensed";
	SizeEx="(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
	linespacing = 1;
	tooltipColorShade[] = {0,0,0,0.65};
	tooltipColorText[] = {1,1,1,1};
	tooltipColorBox[] = {0,0,0,0};
};

class HALsStore_RscStructuredText {
	type = 13;
	style = 0;
	colorText[] = {1,1,1,1};
	class Attributes {
		font = "PuristaLight";
		color = "#ffffff";
		colorLink = "#D09B43";
		align = "left";
		shadow = 1;
	};
	x = 0;
	y = 0;
	h = 0.035;
	w = 0.1;
	text = "";
	size="(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.9)";
	shadow = 1;
};


class HALsStore_ctrlDefault {
	access = 0;
	idc = -1;
	style = ST_LEFT;
	default = 0;
	show = 1;
	fade = 0;
	blinkingPeriod = 0;
	deletable = 0;
	x = 0;
	y = 0;
	w = 0;
	h = 0;
	tooltip = "";
	tooltipMaxWidth = 0.5;
	tooltipColorShade[] = {0,0,0,0.65};
	tooltipColorText[] = {1,1,1,1};
	tooltipColorBox[] = {0,0,0,0};
	class ScrollBar {
		width = 0;
		height = 0;
		scrollSpeed = 0.06;
		arrowEmpty = "\a3\3DEN\Data\Controls\ctrlDefault\arrowEmpty_ca.paa";
		arrowFull = "\a3\3DEN\Data\Controls\ctrlDefault\arrowFull_ca.paa";
		border = "\a3\3DEN\Data\Controls\ctrlDefault\border_ca.paa";
		thumb = "\a3\3DEN\Data\Controls\ctrlDefault\thumb_ca.paa";
		color[] = {1,1,1,1};
	};
};
class HALsStore_ctrlDefaultText: HALsStore_ctrlDefault {
	sizeEx = "4.32 * (1 / (getResolution select 3)) * pixelGrid * 0.5";
	font = "RobotoCondensedLight";
	shadow = 1;
};
class HALsStore_ctrlDefaultButton: HALsStore_ctrlDefaultText {
	soundClick[] =
	{
		"\A3\ui_f\data\sound\RscButton\soundClick",
		0.09,
		1
	};
	soundEnter[] =
	{
		"\A3\ui_f\data\sound\RscButton\soundEnter",
		0.09,
		1
	};
	soundPush[] =
	{
		"\A3\ui_f\data\sound\RscButton\soundPush",
		0.09,
		1
	};
	soundEscape[] =
	{
		"\A3\ui_f\data\sound\RscButton\soundEscape",
		0.09,
		1
	};
};
class HALsStore_ctrlStatic: HALsStore_ctrlDefaultText {
	type = CT_STATIC;
	colorBackground[] = {0,0,0,0};
	text = "";
	lineSpacing = 1;
	fixedWidth = 0;
	colorText[] = {1,1,1,1};
	colorShadow[] = {0,0,0,1};
	moving = 0;
	autoplay = 0;
	loops = 0;
	tileW = 1;
	tileH = 1;
	onCanDestroy = "";
	onDestroy = "";
	onMouseEnter = "";
	onMouseExit = "";
	onSetFocus = "";
	onKillFocus = "";
	onKeyDown = "";
	onKeyUp = "";
	onMouseButtonDown = "";
	onMouseButtonUp = "";
	onMouseButtonClick = "";
	onMouseButtonDblClick = "";
	onMouseZChanged = "";
	onMouseMoving = "";
	onMouseHolding = "";
	onVideoStopped = "";
};
class HALsStore_ctrlStaticPictureKeepAspect: HALsStore_ctrlStatic {
	style = ST_MULTI + ST_TITLE_BAR + ST_KEEP_ASPECT_RATIO;
};
class HALsStore_ctrlButton: HALsStore_ctrlDefaultButton {
	type = CT_BUTTON;
	style = ST_CENTER + ST_FRAME + ST_HUD_BACKGROUND;
	colorBackground[] = {0,0,0,1};
	colorBackgroundDisabled[] = {0,0,0,0.5};
	colorBackgroundActive[] = {
		"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.77])",
		"(profilenamespace getvariable ['GUI_BCG_RGB_G',0.51])",
		"(profilenamespace getvariable ['GUI_BCG_RGB_B',0.08])",
		1
	};
	colorFocused[] = {
		"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.77])",
		"(profilenamespace getvariable ['GUI_BCG_RGB_G',0.51])",
		"(profilenamespace getvariable ['GUI_BCG_RGB_B',0.08])",
		1
	};
	font = "PuristaLight";
	text = "";
	colorText[] = {1,1,1,1};
	colorDisabled[] = {1,1,1,0.25};
	borderSize = 0;
	colorBorder[] = {0,0,0,0};
	colorShadow[] = {0,0,0,0};
	offsetX = 0;
	offsetY = 0;
	offsetPressedX = "pixelW";
	offsetPressedY = "pixelH";
	period = 0;
	periodFocus = 2;
	periodOver = 0.5;
};
class HALsStore_ctrlButtonPictureKeepAspect: HALsStore_ctrlButton {
	style = ST_CENTER + ST_MULTI + ST_TITLE_BAR + ST_KEEP_ASPECT_RATIO;
};
class HALsStore_ctrlEdit: HALsStore_ctrlDefaultText {
	w = 0.12;
	h = 0.035;
	type = CT_EDIT;
	style=0x00+0x40;
	colorBackground[] = {0,0,0,0.5};
	colorText[] = {1,1,1,1};
	colorDisabled[] = {1,1,1,0.25};
	colorSelection[]={"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])","(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])","(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])",1};
	sizeEx="(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
	shadow = 1;
	font="PuristaMedium";
	autocomplete=0;
	canModify = 1;
	text = "";
	tooltipColorShade[] = {0,0,0,0.65};
	tooltipColorText[] = {1,1,1,1};
	tooltipColorBox[] = {0,0,0,0};
};

class HALsStore_ctrlCombo {
	type = 4;
	style = ST_LEFT + LB_TEXTURES + ST_NO_RECT;
	blinkingPeriod = 0;
	deletable = 0;
	x = 0;
	y = 0;
	w = 0;
	h = 0;
	shadow = 0;
	maxHistoryDelay = 1;
	wholeHeight=0.44999999;
	colorSelect[]={0,0,0,1};
	colorText[]={1,1,1,1};
	colorBackground[]={0,0,0,1};
	colorSelectBackground[]={1,1,1,0.69999999};
	colorScrollbar[]={1,0,0,1};
	colorSelectRight[]={0,0,0,1};
	colorSelect2Right[]={0,0,0,1};
	colorActive[]={1,0,0,1};
	colorDisabled[]={1,1,1,0.25};
	colorPicture[]={1,1,1,1};
	colorPictureSelected[]={1,1,1,1};
	colorPictureDisabled[]={1,1,1,0.25};
	colorPictureRight[]={1,1,1,1};
	colorPictureRightSelected[]={1,1,1,1};
	colorPictureRightDisabled[]={1,1,1,0.25};
	tooltipColorShade[] = {0,0,0,0.65};
	tooltipColorText[] = {1,1,1,1};
	tooltipColorBox[] = {0,0,0,0};
	arrowEmpty="\A3\ui_f\data\GUI\RscCommon\rsccombo\arrow_combo_ca.paa";
	arrowFull="\A3\ui_f\data\GUI\RscCommon\rsccombo\arrow_combo_active_ca.paa";
	font="RobotoCondensed";
	sizeEx="(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";

	soundSelect[]= {
		"\A3\ui_f\data\sound\RscCombo\soundSelect",
		0.1,
		1
	};
	soundExpand[]= {
		"\A3\ui_f\data\sound\RscCombo\soundExpand",
		0.1,
		1
	};
	soundCollapse[]= {
		"\A3\ui_f\data\sound\RscCombo\soundCollapse",
		0.1,
		1
	};

	class ComboScrollBar {
		width = 0;
		height = 0;
		scrollSpeed = 0.01;
		color[]= {1,1,1,1};
		thumb = "\A3\ui_f\data\gui\cfg\scrollbar\thumb_ca.paa";
		arrowFull = "\A3\ui_f\data\gui\cfg\scrollbar\arrowFull_ca.paa";
		arrowEmpty = "\A3\ui_f\data\gui\cfg\scrollbar\arrowEmpty_ca.paa";
		border = "\A3\ui_f\data\gui\cfg\scrollbar\border_ca.paa";
	};
};
class HALsStore_ctrlComboItem: HALsStore_ctrlCombo {
	access = 0;
	arrowEmpty = "\A3\ui_f\data\GUI\RscCommon\rsccombo\arrow_combo_ca.paa";
	arrowFull = "\A3\ui_f\data\GUI\RscCommon\rsccombo\arrow_combo_active_ca.paa";
	colorActive[] = {1,0,0,1};
	colorBackground[] = {0,0,0,0.7};
	colorDisabled[] = {1,1,1,0.25};
	colorPicture[] = {1,1,1,1};
	colorPictureDisabled[] = {1,1,1,0.25};
	colorPictureRight[] = {1,1,1,1};
	colorPictureRightDisabled[] = {1,1,1,0.25};
	colorPictureRightSelected[] = {1,1,1,1};
	colorPictureSelected[] = {1,1,1,1};
	colorScrollbar[] = {1,0,0,1};
	colorSelect[] = {0,0,0,1};
	colorSelect2Right[] = {0,0,0,1};
	colorSelectBackground[] = {1,1,1,0.7};
	colorSelectRight[] = {0,0,0,1};
	colorText[] = {1,1,1,1};
	colorTextRight[] = {1,1,1,1};
	font = "RobotoCondensed";
	h = "((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
	maxHistoryDelay = 1;
	shadow = 0;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
	soundCollapse[] = {"\A3\ui_f\data\sound\RscCombo\soundCollapse",0.1,1};
	soundExpand[] = {"\A3\ui_f\data\sound\RscCombo\soundExpand",0.1,1};
	soundSelect[] = {"\A3\ui_f\data\sound\RscCombo\soundSelect",0.1,1};
	tooltipColorText[] = {1,1,1,1};
	tooltipColorBox[] = {1,1,1,1};
	tooltipColorShade[] = {0,0,0,0.65};
	wholeHeight = 0.45;

	class ComboScrollBar {
		arrowEmpty = "\A3\ui_f\data\gui\cfg\scrollbar\arrowEmpty_ca.paa";
		arrowFull = "\A3\ui_f\data\gui\cfg\scrollbar\arrowFull_ca.paa";
		autoScrollDelay = 5;
		autoScrollEnabled = 0;
		autoScrollRewind = 0;
		autoScrollSpeed = -1;
		border = "\A3\ui_f\data\gui\cfg\scrollbar\border_ca.paa";
		color[] = {1,1,1,1};
		colorActive[] = {1,1,1,1};
		colorDisabled[] = {1,1,1,0.3};
		height = 0;
		scrollSpeed = 0.06;
		shadow = 0;
		thumb = "\A3\ui_f\data\gui\cfg\scrollbar\thumb_ca.paa";
		width = 0;
	};
};
class HALsStore_ctrlProgress {
	deletable = 0;
	fade = 0;
	access = 0;
	type = CT_PROGRESS;
	style = ST_HORIZONTAL;
	colorFrame[] = {0,0,0,0};
	colorBar[] = {1,1,1,1};
	shadow = 2;
	texture = "#(argb,8,8,3)color(1,1,1,1)";
};
class HALsStore_ctrlStat: HALsStore_ctrlProgress {
	colorBar[] = {1,1,1,1};
	colorFrame[] = {0,0,0,0};
	texture = "#(argb,8,8,3)color(1,1,1,1)";
};
class HALsStore_ctrlCheckbox {
	idc = -1;
	type = CT_CHECKBOX;
	deletable = 0;
	style = ST_LEFT;
	checked = 0;
	x = "0.375 * safezoneW + safezoneX";
	y = "0.36 * safezoneH + safezoneY";
	w = "0.025 * safezoneW";
	h = "0.04 * safezoneH";
	color[] = {1,1,1,0.7};
	colorFocused[] = {1,1,1,1};
	colorHover[] = {1,1,1,1};
	colorPressed[] = {1,1,1,1};
	colorDisabled[] = {1,1,1,0.2};
	colorBackground[] = {0,0,0,0.8};
	colorBackgroundFocused[] = {0,0,0,0.8};
	colorBackgroundHover[] = {0,0,0,0.8};
	colorBackgroundPressed[] = {0,0,0,0.8};
	colorBackgroundDisabled[] = {0,0,0,0};
	textureChecked = "A3\Ui_f\data\GUI\RscCommon\RscCheckBox\CheckBox_checked_ca.paa";
	textureUnchecked = "A3\Ui_f\data\GUI\RscCommon\RscCheckBox\CheckBox_unchecked_ca.paa";
	textureFocusedChecked = "A3\Ui_f\data\GUI\RscCommon\RscCheckBox\CheckBox_checked_ca.paa";
	textureFocusedUnchecked = "A3\Ui_f\data\GUI\RscCommon\RscCheckBox\CheckBox_unchecked_ca.paa";
	textureHoverChecked = "A3\Ui_f\data\GUI\RscCommon\RscCheckBox\CheckBox_checked_ca.paa";
	textureHoverUnchecked = "A3\Ui_f\data\GUI\RscCommon\RscCheckBox\CheckBox_unchecked_ca.paa";
	texturePressedChecked = "A3\Ui_f\data\GUI\RscCommon\RscCheckBox\CheckBox_checked_ca.paa";
	texturePressedUnchecked = "A3\Ui_f\data\GUI\RscCommon\RscCheckBox\CheckBox_unchecked_ca.paa";
	textureDisabledChecked = "A3\Ui_f\data\GUI\RscCommon\RscCheckBox\CheckBox_checked_ca.paa";
	textureDisabledUnchecked = "A3\Ui_f\data\GUI\RscCommon\RscCheckBox\CheckBox_unchecked_ca.paa";
	tooltipColorShade[] = {0,0,0,0.65};
	tooltipColorText[] = {1,1,1,1};
	tooltipColorBox[] = {0,0,0,0};
	soundClick[] = {
		"\A3\ui_f\data\sound\RscButton\soundClick",
		0.09,
		1
	};
	soundEnter[] = {
		"\A3\ui_f\data\sound\RscButton\soundEnter",
		0.09,
		1
	};
	soundPush[] = {
		"\A3\ui_f\data\sound\RscButton\soundPush",
		0.09,
		1
	};
	soundEscape[] = {
		"\A3\ui_f\data\sound\RscButton\soundEscape",
		0.09,
		1
	};
};

class RscCtrlCheckboxGreen: HALsStore_ctrlCheckbox {
	color[] = {0.627451, 0.87451, 0.231373,1 };
	colorFocused[] = {0.627451, 0.87451, 0.231373, 1};
	colorPressed[] = {0.627451, 0.87451, 0.231373, 1};
	colorBackground[] = {0, 0, 0, 0};
	colorBackgroundHover[] = {0, 0, 0, 0};
	colorBackgroundFocused[] = {0, 0, 0, 0};
	colorBackgroundPressed[] = {0, 0, 0, 0};
	/*textureChecked = "\a3\3DEN\Data\Controls\ctrlCheckbox\textureChecked_ca.paa";
	textureUnchecked = "\a3\3DEN\Data\Controls\ctrlCheckbox\textureUnchecked_ca.paa";
	textureFocusedChecked = "\a3\3DEN\Data\Controls\ctrlCheckbox\textureChecked_ca.paa";
	textureFocusedUnchecked = "\a3\3DEN\Data\Controls\ctrlCheckbox\textureUnchecked_ca.paa";
	textureHoverChecked = "\a3\3DEN\Data\Controls\ctrlCheckbox\textureChecked_ca.paa";
	textureHoverUnchecked = "\a3\3DEN\Data\Controls\ctrlCheckbox\textureUnchecked_ca.paa";
	texturePressedChecked = "\a3\3DEN\Data\Controls\ctrlCheckbox\textureChecked_ca.paa";
	texturePressedUnchecked = "\a3\3DEN\Data\Controls\ctrlCheckbox\textureUnchecked_ca.paa";
	textureDisabledChecked = "\a3\3DEN\Data\Controls\ctrlCheckbox\textureChecked_ca.paa";
	textureDisabledUnchecked = "\a3\3DEN\Data\Controls\ctrlCheckbox\textureUnchecked_ca.paa";*/
};


class HALsControlsGroup: HALsStore_ctrlDefault {
	type = CT_CONTROLS_GROUP;
	style = ST_MULTI;
	x = 0;
	y = 0;
	w = 1;
	h = 1;
	class VScrollBar: ScrollBar {
		width = 2 * GRID_W;
		height = 0;
		autoScrollEnabled = 0;
		autoScrollDelay = 1;
		autoScrollRewind = 1;
		autoScrollSpeed = 1;
	};
	class HScrollBar: ScrollBar {
		width = 0;
		height = 0;//2 * GRID_H;
	};
};

class HALsControlsGroupNoScrollbars: HALsControlsGroup {
	class VScrollbar: VScrollBar {
		width = 0;
	};
	class HScrollbar: HScrollBar {
		height = 0;
	};
};
