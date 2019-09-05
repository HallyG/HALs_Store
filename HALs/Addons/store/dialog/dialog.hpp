#include "defines.hpp"
#include "idcs.hpp"
#include "sizes.hpp"

class RscDisplayStore {
	idd = 85999;
	x = safeZoneX;
	y = safeZoneY;
	w = safeZoneWAbs;
	h = safeZoneH;
	onUnload = "['onUnload', _this] call HALs_store_fnc_main";

	class controls {
		class HALs_store_dialog: HALsStore_ctrlControlsGroupNoScrollbars {
			idc = IDD_RscDisplayStore;
			x = 0;
			y = 0;
			w = GRIDW(MAIN_WIDTH +0.1);
			h = GRIDH(MAIN_HEIGHT+0.7);
			onLoad = "['onLoad', _this] call HALs_store_fnc_main";
				
			class controls {
				class StoreBackground: HALsStore_RscText {
					idc = -1;
					x = 0;
					y = BUFFER_Y;
					w = GRIDW(MAIN_WIDTH);
					h = GRIDH(MAIN_HEIGHT);
					
					colorBackground[] = {0,0,0,0.7};
					colorShadow[] = {0,0,0,0.5};
				};
				class TitleBackground: HALsStore_RscText {
					idc = -1;
					x = 0;
					y = 0;
					w = GRIDW(MAIN_WIDTH);
					h = GRIDH(1);
					
					colorBackground[] = {0,0,0,0.7};
					colorShadow[] = {0,0,0,0.5};
				};
				class TitleFunds: HALsStore_RscText {
					idc = IDC_FUNDS;
					style = 0x01;
					x = GRIDX(30);
					y = 0;
					w = GRIDW(5);
					h = GRIDH(1);
					
					font = "PuristaMedium";
					tooltip = "Funds";
					sizeEx = GRIDH(0.9);
					shadow = 1;
					colorText[]={0.666667,1,0.666667,1};
				};				
				class TitleText: HALsStore_RscText {
					idc = IDC_TITLE;
					x = 0;
					y = 0;
					w = GRIDW(MAIN_WIDTH);
					h = GRIDH(1);
					
					text = "EQUIPMENT STORE";
					font = "PuristaMedium";
					sizeEx = GRIDH(0.9);
				};
				class CloseButton: HALsStore_ctrlButtonPictureKeepAspect {
					idc = IDC_BUTTON_CLOSE;
					x = GRIDX(35);
					y = 0;
					w = GRIDW(1);
					h = GRIDH(1);
	
					text = "\a3\3DEN\Data\ControlsGroups\Tutorial\close_ca.paa";
					tooltip = "Close";
					action = "['onUnload'] call HALs_store_fnc_main;";
					colorText[]={1,1,1,1};
					colorActive[]={1,1,1,1};
					color[] = {1,1,1,0.5};
					colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R', 0])","(profilenamespace getvariable ['GUI_BCG_RGB_G',0])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0])", 0};
				};				
				class ComboCategories: HALsStore_ctrlComboItem {
					idc = IDC_COMBO_CATEGORY;
					x = GRIDX(1);
					y = GRIDY(0.8) + BUFFER_Y;
					w = GRIDW(12.7);
					h = GRIDH(1);

					sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)"; //sizeEx = 0.03; //
					tooltip = "Store category";	
				};					
				class ItemCheckbox1: HALsStore_ctrlCheckboxGreen {
					idc = IDC_CHECKBOX1;
					x = GRIDX(13.8);
					y = GRIDY(0.8) + BUFFER_Y;
					w = GRIDW(1);
					h = GRIDH(1);
					
					sizeEx = UITXTSIZE(2);
				};
				class ItemCheckbox2: HALsStore_ctrlCheckboxGreen {
					idc = IDC_CHECKBOX2;
					x = GRIDX(14.9);
					y = GRIDY(0.8) + BUFFER_Y;
					w = GRIDW(1);
					h = GRIDH(1);
					
					sizeEx = UITXTSIZE(2);
				};
				class ItemCheckbox3: HALsStore_ctrlCheckboxGreen {
					idc = IDC_CHECKBOX3;
					x = GRIDX(16);
					y = GRIDY(0.8) + BUFFER_Y;
					w = GRIDW(1);
					h = GRIDH(1);
	
					sizeEx = UITXTSIZE(2);
				};
				class ItemListbox: HALsStore_RscListBox {
					idc = IDC_LISTBOX;
					x = GRIDX(1);
					y = GRIDY(2) + BUFFER_Y;
					w = GRIDW(16);
					h = GRIDH(23);
					shadow = 1;
					colorShadow[] = {0,0,0,0};
					sizeEx = "1.4 * ( ( ((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
					font = "PuristaMedium"; //"RobotoCondensed";
				};					
				class PurchaseButton: HALsStore_ctrlButton {
					idc = IDC_BUTTON_BUY;
					x = GRIDX(37.3);
					y = GRIDY(13.4) + BUFFER_Y; //12.3
					w = GRIDW(4.9);
					h = "1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";//GRIDH(1); 
					colorBackground[] = {0,0,0,0.8};
					colorBackground2[] = {0.75,0.75,0.75,1};
					colorBackgroundFocused[] = {1,1,1,1};
					colorFocused[] = {0,0,0,1};
					colorFocusedSecondary[] = {0,0,0,1};
					colorSecondary[] = {1,1,1,1};
					colorText[] = {1,1,1,1};
					font = "PuristaLight";
					fontSecondary = "PuristaLight";
					size = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)"; // UITXTSIZE(1.75);
					sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)"; // UITXTSIZE(1.75);
					sizeSecondary = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)"; // UITXTSIZE(1.75);
					period = 1.2;
					periodFocus = 1.2;
					periodOver = 1.2;
					text = "$STR_HALS_STORE_BUTTON_PURCHASE";
					textSecondary = "";
					tooltip = "$STR_HALS_STORE_BUTTON_PURCHASE";
					tooltipColorShade[] = {0,0,0,0.65};
					tooltipColorText[] = {1,1,1,1};
					tooltipColorBox[] = {0,0,0,0};
					action = "['BUTTON', ['BUY', []]] call HALs_store_fnc_main;";
				};
				class PurchaseCheckbox: HALsStore_ctrlCheckbox {
					idc = IDC_CHECKBOX_BUY;
					x = GRIDX(36.2);
					y = GRIDY(13.4) + BUFFER_Y; //12.3
					w = GRIDW(1);
					h = GRIDH(1);
					tooltip = "$STR_HALS_STORE_CHECKBOX_EQUIP";
					colorBackground[] = {0, 0, 0, 0.8};
					checked = 0;
				};				
				class PurchaseEdit: HALsStore_ctrlEdit {
					idc = IDC_EDIT;
					x = GRIDX(36.2);
					y = GRIDY(12.3) + BUFFER_Y;
					w = GRIDW(6);
					h = GRIDH(1);

					maxChars = 6;
					style = "16 + 512 + 0x01";
					colorBackground[] = {0.05,0.05,0.05,0.7};
					tooltip = "Number of items to buy";
					sizeEx = GRIDH(0.9);
				};
				class PurchaseInfo: HALsStore_RscStructuredText {
					idc = IDC_ITEM;
					x = GRIDX(36.2);
					y = GRIDY(9.2) + BUFFER_Y; //9.2
					w = GRIDW(6);
					h = GRIDH(6);
					font = "PuristaMedium";

					colorBackground[] = {0.05,0.05,0.05,0.7};
					size="(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.9)";
				};
				class TraderBackground1: HALsStore_RscText {
					idc = -1;
					x = GRIDX(36.2);
					y = GRIDY(1.8) + BUFFER_Y;
					w = GRIDW(6);
					h = GRIDH(7.2); //0.2 gap width plus 1 border
					
					colorBackground[] = {0,0,0,0.4};
				};	
				class TraderCombo: HALsStore_ctrlComboItem {
					idc = IDC_BUY_ITEM_COMBO;
					x = GRIDX(36.2);
					y = GRIDY(1.8) + BUFFER_Y;
					w = GRIDW(6);
					h = GRIDH(1);
					sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)"; //sizeEx = 0.03; //
					tooltip = "Purchase item to";
				};
				class TraderBackground2: HALsStore_RscText {
					idc = -1;
					x = GRIDX(36.2);
					y = GRIDY(2.9) + BUFFER_Y;
					w = GRIDW(6);
					h = GRIDH(6.1);
					
					colorBackground[]={1,1,1,0.2};
				};	
				class TraderPicture: HALsStore_ctrlStaticPictureKeepAspect {
					idc = IDC_BUY_PICTURE;
					x = GRIDX(36.2);
					y = GRIDY(2.9) + BUFFER_Y;
					w = GRIDW(6);
					h = GRIDH(6.1);
					
					colorBackground[]={0.05,0.05,0.05,0.7};
				};
				class TraderStatsBackground: HALsStore_RscText {
					idc = -1;
					x = GRIDX(36.2) - 0*pixelW;
					y = GRIDY(8.5) + BUFFER_Y;
					w = GRIDW(6) + 0*(pixelW * 3);
					h = GRIDH(0.5) - 0*(pixelH * 3); //0.2 gap width plus 1 border
					
					colorBackground[]={0.05,0.05,0.05,0.7};
				};	
				class TraderProgressNew: HALsStore_ctrlProgress {
					idc = IDC_PROGRESS_NEWLOAD;
					x = GRIDX(36.2) + 0*pixelW;//36.25
					y = GRIDY(8.5) + BUFFER_Y;
					w = GRIDW(6);
					h = GRIDH(0.5); //0.2 gap width plus 1 border
					
					colorBar[]={0.9,0,0,0.6};
					colorExtBar[]={1,1,1,0};
					colorFrame[]={0,0,0,0};
					//colorBackground[]={0,0,0,0.3};
				};
				class TraderProgressOld: HALsStore_ctrlProgress {
					idc = IDC_PROGRESS_LOAD;
					x = GRIDX(36.2) + 0*pixelW;
					y = GRIDY(8.5) + BUFFER_Y;
					w = GRIDW(6);
					h = GRIDH(0.5);
					
					colorBar[]={0.9,0.9,0.9,0.9};
					colorExtBar[]={1,1,1,0};
					colorFrame[]={0,0,0,0};
				};
				class ItemPictureBackground: HALsStore_RscText {
					idc = -1;
					x = GRIDX(18);
					y = GRIDY(2) + BUFFER_Y;
					w = GRIDW(17);
					h = GRIDH(7);
					colorBackground[] = {1, 1, 1, 0.2};
				};		
				class main_picture: HALsStore_ctrlStaticPictureKeepAspect {
					idc = IDC_ITEM_PICTURE;
					x = GRIDX(18);
					y = GRIDY(2) + BUFFER_Y;
					w = GRIDW(17);
					h = GRIDH(7); //0.2 gap width plus 1 border
					color[] = {1,1,1,1};
				};		
				class ItemDescriptionBackground: HALsStore_RscText {
					idc = -1;
					x = GRIDX(18);
					y = GRIDY(9.2) + BUFFER_Y;
					w = GRIDW(17);
					h = GRIDH(15.8);
					
					colorBackground[] = {0, 0, 0, 0.3};
					colorShadow[] = {0,0,0,0.5};
				};
				class ItemDescription: HALsStore_ctrlControlsGroup {
					idc = IDC_ITEM_TEXT_GROUP;
					x = GRIDX(18);
					y = GRIDY(9.2) + BUFFER_Y; // X + H + 0.1
					w = GRIDW(17);
					h = GRIDH(15.8);
					
					colorBackground[] = {0, 0, 0, 0.3};
					color[] = {1,1,1,1};
					shadow = 0;
					
					class controls {
						class ItemPicture: HALsStore_RscStructuredText {
							idc = IDC_ITEM_TEXT;
							x = 0;
							y = 0;
							w = GRIDW(16.8);
							h = GRIDH(15);
							size = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.9)";
							shadow = 1;
							font = "PuristaMedium";
						};		
						class ItemDescriptionText: HALsStore_RscStructuredText {
							idc = IDC_ITEM_TEXT_DES;
							x = 0;
							y = 0;
							w = GRIDW(16.8);
							h = GRIDH(15);
							size = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.9)";
							shadow = 1;
							font = "RobotoCondensed";
						};
						class ProgressBar1: HALsStore_ctrlProgress {
							idc = IDC_ITEM_STATS_PROGRESS_1;
							x = GRIDX(0.4);
							y = GRIDY(1);
							w = GRIDW(16);
							h = GRIDH(0.9);
							colorBar[] = {1,1,1,1};
							colorFrame[]={0,0,0,0};
							fade = 1;
						};
						class ProgressBarText1: HALsStore_RscText {
							idc = IDC_ITEM_STATS_PROGRESS_TEXT_1;
							x = GRIDX(0.4);
							y = GRIDY(1);
							w = GRIDW(16);
							h = GRIDH(0.9);
							
							sizeEx = "0.8 *((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
							colorBackground[] = {1,1,1,0.1};
							colorText[] = {0,0,0,1};
							colorShadow[]={1,1,1,1};
							linespacing = 1;
							shadow = 0;
							fade = 1;
							font = "RobotoCondensed";
						};
						class ProgressBar2: ProgressBar1 {
							idc = IDC_ITEM_STATS_PROGRESS_2;
							x = GRIDX(0.4);
							y = GRIDY(2.5);
							w = GRIDW(16);
							h = GRIDH(0.9);
						};
						class ProgressBarText2: ProgressBarText1 {
							idc = IDC_ITEM_STATS_PROGRESS_TEXT_2;
							x = GRIDX(0.4);
							y = GRIDY(2.5);
							w = GRIDW(16);
							h = GRIDH(0.9);
						};
						class ProgressBar3: ProgressBar1 {
							idc = IDC_ITEM_STATS_PROGRESS_3;
							x = GRIDX(0.4);
							y = GRIDY(4);
							w = GRIDW(16);
							h = GRIDH(0.9);
						};
						class ProgressBarText3: ProgressBarText1 {
							idc = IDC_ITEM_STATS_PROGRESS_TEXT_3;
							x = GRIDX(0.4);
							y = GRIDY(4);
							w = GRIDW(16);
							h = GRIDH(0.9);
						};						
						class ProgressBar4: ProgressBar1 {
							idc = IDC_ITEM_STATS_PROGRESS_4;
							x = GRIDX(0.4);
							y = GRIDY(7);
							w = GRIDW(16);
							h = GRIDH(0.9);
						};
						class ProgressBarText4: ProgressBarText1 {
							idc = IDC_ITEM_STATS_PROGRESS_TEXT_4;
							x = GRIDX(0.4);
							y = GRIDY(7);
							w = GRIDW(16);
							h = GRIDH(0.9);
						};						
						class ProgressBar5: ProgressBar1 {
							idc = IDC_ITEM_STATS_PROGRESS_5;
							x = GRIDX(0.4);
							y = GRIDY(10);
							w = GRIDW(16);
							h = GRIDH(0.9);
						};
						class ProgressBarText5: ProgressBarText1 {
							idc = IDC_ITEM_STATS_PROGRESS_TEXT_5;
							x = GRIDX(0.4);
							y = GRIDY(10);
							w = GRIDW(16);
							h = GRIDH(0.9);
						};						
					};
				};
			};
		};
	};
};
