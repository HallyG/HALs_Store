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
			idc = IDD_RscDisplayStore_DIALOG;
			x = 0;
			y = 0;
			w = GRIDW(MAIN_WIDTH +0.1);
			h = GRIDH(MAIN_HEIGHT+0.7);
			onLoad = "['onLoad', _this] call HALs_store_fnc_main";
				
			class controls {
				class main_background: HALsStore_RscText {
					idc = -1;
					x = 0;
					y = BUFFER_Y;
					w = GRIDW(MAIN_WIDTH);
					h = GRIDH(MAIN_HEIGHT);
					
					colorBackground[] = {0,0,0,0.7};
					colorShadow[] = {0,0,0,0.5};
				};
				class main_title_background: HALsStore_RscText {
					idc = -1;
					x = 0;
					y = 0;
					w = GRIDW(MAIN_WIDTH);
					h = GRIDH(1);
					
					colorBackground[] = {0,0,0,0.7};
					colorShadow[] = {0,0,0,0.5};
				};
				class main_title: HALsStore_RscText {
					idc = IDC_RscDisplayStore_TITLE;
					x = 0;
					y = 0;
					w = GRIDW(MAIN_WIDTH);
					h = GRIDH(1);
					
					text = "EQUIPMENT STORE";
					font = "PuristaMedium";
					sizeEx = UITXTSIZE(1.75);
				};
				class main_title_right: HALsStore_RscText {
					idc = IDC_RscDisplayStore_FUNDS;
					style = 0x01;
					x = GRIDX(30);
					y = 0;
					w = GRIDW(5);
					h = GRIDH(1);
					
					font = "PuristaMedium";
					tooltip = "Funds";
					sizeEx = UITXTSIZE(1.75);
					shadow = 1;
					colorText[]={0.666667,1,0.666667,1};
				};
				class main_button_close: HALsStore_ctrlButtonPictureKeepAspect {
					idc = IDC_RscDisplayStore_BUTTON_CLOSE;
					x = GRIDX(35);
					y = 0;
					w = GRIDW(1);
					h = GRIDH(1);
	
					text = "\a3\3DEN\Data\ControlsGroups\Tutorial\close_ca.paa";
					tooltip = "Close";
					action = "['UNLOAD'] call HALs_store_fnc_main;";
					colorText[]={1,1,1,1};
					colorActive[]={1,1,1,1};
					color[] = {1,1,1,0.5};
					colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R', 0])","(profilenamespace getvariable ['GUI_BCG_RGB_G',0])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0])", 0};
				};				
				class main_listbox: HALsStore_RscListBox {
					idc = IDC_RscDisplayStore_LISTBOX;
					x = GRIDX(1);
					y = GRIDY(2) + BUFFER_Y;
					w = GRIDW(16);
					h = GRIDH(23);
					shadow = 0;
					font = "PuristaMedium";
					sizeEx = "0.8 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)"; //0.03;//sizeEx="(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.85)";
				};		
				class main_combo_categories: HALsStore_ctrlCombo {
					idc = IDC_RscDisplayStore_COMBO_CATEGORY;
					x = GRIDX(1);
					y = GRIDY(0.8) + BUFFER_Y;
					w = GRIDW(12.7);
					h = GRIDH(1);

					colorBackground[] = {0, 0, 0, 0.7};
					wholeHeight = 0.45;
					sizeEx = 0.03;
					tooltip = "Store category";	
				};
				class main_checkbox_1: HALsStore_ctrlCheckboxGreen {
					idc = IDC_RscDisplayStore_CHECKBOX1;
					x = GRIDX(13.8);
					y = GRIDY(0.8) + BUFFER_Y;
					w = GRIDW(1);
					h = GRIDH(1);
					
					sizeEx = UITXTSIZE(2);
				};
				class main_checkbox_2: HALsStore_ctrlCheckboxGreen {
					idc = IDC_RscDisplayStore_CHECKBOX2;
					x = GRIDX(14.9);
					y = GRIDY(0.8) + BUFFER_Y;
					w = GRIDW(1);
					h = GRIDH(1);
					
					sizeEx = UITXTSIZE(2);
				};
				class main_checkbox_3: HALsStore_ctrlCheckboxGreen {
					idc = IDC_RscDisplayStore_CHECKBOX3;
					x = GRIDX(16);
					y = GRIDY(0.8) + BUFFER_Y;
					w = GRIDW(1);
					h = GRIDH(1);
	
					sizeEx = UITXTSIZE(2);
				};
				class purchase_checkbox: HALsStore_ctrlCheckbox {
					idc = IDC_RscDisplayStore_CHECKBOX_BUY;
					x = GRIDX(36.2);
					y = GRIDY(13.4) + BUFFER_Y; //12.3
					w = GRIDW(1);
					h = GRIDH(1);
					tooltip = "$STR_HALS_STORE_CHECKBOX_EQUIP";
					colorBackground[] = {0, 0, 0, 0.8};
					checked = 0;
				};
				class cargo_background: HALsStore_RscText {
					idc = -1;
					x = GRIDX(36.2);
					y = GRIDY(1.8) + BUFFER_Y;
					w = GRIDW(6);
					h = GRIDH(7.2); //0.2 gap width plus 1 border
					
					colorBackground[] = {0,0,0,0.4};
				};	
				class cargo_combo: HALsStore_ctrlCombo {
					idc = IDC_RscDisplayStore_BUY_ITEM_COMBO;
					x = GRIDX(36.2);
					y = GRIDY(1.8) + BUFFER_Y;
					w = GRIDW(6);
					h = GRIDH(1);

					colorBackground[] = {0, 0, 0, 0.7};
					tooltip = "Purchase item to";
					wholeHeight = 0.45;
					sizeEx = 0.03;
				};
				class cargo_picture_background: HALsStore_RscText {
					idc = -1;
					x = GRIDX(36.2);
					y = GRIDY(2.9) + BUFFER_Y;
					w = GRIDW(6);
					h = GRIDH(6.1);
					
					colorBackground[]={1,1,1,0.2};
				};	
				class cargo_picture: HALsStore_ctrlStaticPictureKeepAspect {
					idc = IDC_RscDisplayStore_BUY_PICTURE;
					x = GRIDX(36.2);
					y = GRIDY(2.9) + BUFFER_Y;
					w = GRIDW(6);
					h = GRIDH(6.1);
					
					colorBackground[]={0.05,0.05,0.05,0.7};
				};
				class cargo_progress_background: HALsStore_RscText {
					idc = -1;
					x = GRIDX(36.2);
					y = GRIDY(8.5) + BUFFER_Y;
					w = GRIDW(6);
					h = GRIDH(0.5); //0.2 gap width plus 1 border
					
					colorBackground[]={0.05,0.05,0.05,0.7};
				};	
				class cargo_progressNewLoad: HALsStore_ctrlProgress {
					idc = IDC_RscDisplayStore_PROGRESS_NEWLOAD;
					x = GRIDX(36.25) - pixelW;
					y = GRIDY(8.5) + BUFFER_Y;
					w = GRIDW(5.975);
					h = GRIDH(0.5); //0.2 gap width plus 1 border
					
					colorBar[]={0.9,0,0,0.6};
					colorExtBar[]={1,1,1,1};
					colorFrame[]={1,1,1,1};
					colorBackground[]={0,0,0,0.8};
				};
				class cargo_progressLoad: HALsStore_ctrlProgress {
					idc = IDC_RscDisplayStore_PROGRESS_LOAD;
					x = GRIDX(36.25) - pixelW;
					y = GRIDY(8.5) + BUFFER_Y;
					w = GRIDW(5.975);
					h = GRIDH(0.5); //0.2 gap width plus 1 border
					
					colorBar[]={0.9,0.9,0.9,0.9};
					colorExtBar[]={1,1,1,1};
					colorFrame[]={1,1,1,1};
					colorBackground[]={0,0,0,0.8};
				};
				class purchase_button: HALsStore_ctrlButton {
					idc = IDC_RscDisplayStore_BUTTON_BUY;
					x = GRIDX(37.3);
					y = GRIDY(13.4) + BUFFER_Y; //12.3
					w = GRIDW(4.9);
					h = GRIDH(1);
	
					sizeEx = UITXTSIZE(1.75);
					tooltip = "$STR_HALS_STORE_BUTTON_PURCHASE";
					tooltipColorShade[] = {0,0,0,0.65};
					tooltipColorText[] = {1,1,1,1};
					tooltipColorBox[] = {0,0,0,0};
					text = "$STR_HALS_STORE_BUTTON_PURCHASE";
					colorText[] = {"(profilenamespace getvariable ['IGUI_TEXT_RGB_R',0])","(profilenamespace getvariable ['IGUI_TEXT_RGB_G',1])","(profilenamespace getvariable ['IGUI_TEXT_RGB_B',1])","(profilenamespace getvariable ['IGUI_TEXT_RGB_A',0.8])"};
					colorBackground[] = {0, 0, 0, 0.8};
					action = "['BUTTON', ['BUY', []]] call HALs_store_fnc_main;";
				};
				class purchase_edit: HALsStore_ctrlEdit {
					idc = IDC_RscDisplayStore_EDIT;
					x = GRIDX(36.2);
					y = GRIDY(12.3) + BUFFER_Y;
					w = GRIDW(6);
					h = GRIDH(1);

					maxChars = 6;
					style = "16 + 512 + 0x01";
					colorBackground[] = {0.05,0.05,0.05,0.7};
					tooltip = "Number of items to buy";
					sizeEx = UITXTSIZE(1.75);
				};
				class purchase_text: HALsStore_RscStructuredText {
					idc = IDC_RscDisplayStore_ITEM;
					x = GRIDX(36.2);
					y = GRIDY(9.2) + BUFFER_Y; //9.2
					w = GRIDW(6);
					h = GRIDH(6);
					font = "PuristaMedium";

					colorBackground[] = {0.05,0.05,0.05,0.7};
					size="(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.9)";
				};
				// class main_purchase_text_equip: HALsStore_RscStructuredText {
					// idc = IDC_RscDisplayStore_ITEM_CANEQUIP;

					// x = GRIDX(36.2)
					// y = GRIDY(9.2) + BUFFER_Y; //9.2
					// w = GRIDW(6);
					// h = GRIDH(6);
										// y = GRIDY(13.4) + BUFFER_Y; //12.3
					// w = GRIDW(4.9);
					// h = GRIDH(1);
				
					// font = "PuristaMedium";
					// text = "";
					// sizeEx = UITXTSIZE(1.75);
					// colorBackground[] = {0.05,0.05,0.05,0.7};
					// shadow = 0;
				// };
				class main_picture_background: HALsStore_RscText {
					idc = -1;
					x = GRIDX(18);
					y = GRIDY(2) + BUFFER_Y;
					w = GRIDW(17);
					h = GRIDH(7);
					colorBackground[] = {1, 1, 1, 0.2};
				};		
				class main_picture: HALsStore_ctrlStaticPictureKeepAspect {
					idc = IDC_RscDisplayStore_ITEM_PICTURE;
					x = GRIDX(18);
					y = GRIDY(2) + BUFFER_Y;
					w = GRIDW(17);
					h = GRIDH(7); //0.2 gap width plus 1 border
					color[] = {1,1,1,1};
				};		
				class main_picture_text_background: HALsStore_RscText {
					idc = -1;
					x = GRIDX(18);
					y = GRIDY(9.2) + BUFFER_Y;
					w = GRIDW(17);
					h = GRIDH(15.8);
					
					colorBackground[] = {0, 0, 0, 0.3};
				};
				class main_picture_text: HALsStore_ctrlControlsGroup {
					idc = IDC_RscDisplayStore_ITEM_TEXT_GROUP;
					x = GRIDX(18);
					y = GRIDY(9.2) + BUFFER_Y; // X + H + 0.1
					w = GRIDW(17);
					h = GRIDH(15.8);
					
					colorBackground[] = {0, 0, 0, 0.3};
					color[] = {1,1,1,1};
					shadow = 0;
					
					class controls {
						class main_item_picture_text: HALsStore_RscStructuredText {
							idc = IDC_RscDisplayStore_ITEM_TEXT;
							x = 0;
							y = 0;
							w = GRIDW(16.8);
							h = GRIDH(15);
							size="(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.9)";
							shadow = 1;
							font = "PuristaMedium";
						};		
						
						class main_item_picture_desc: HALsStore_RscStructuredText {
							idc = IDC_RscDisplayStore_ITEM_TEXT_DES;
							x = 0;
							y = 0;
							w = GRIDW(16.8);
							h = GRIDH(15);
							size="(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.9)";
							shadow = 1;
							font = "PuristaMedium";
						};
						
						class main_item_progressbar_1: HALsStore_ctrlProgress {
							idc = IDC_RscDisplayStore_ITEM_STATS_PROGRESS_1;
							x = GRIDX(0.4);
							y = GRIDY(1);
							w = GRIDW(16);
							h = "0.9 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
							colorBar[]={0.9,0.9,0.9,1};
							colorFrame[]={0,0,0,0};
							fade = 1;
						};
						class main_item_progressbar_1_text: HALsStore_RscText {
							idc = IDC_RscDisplayStore_ITEM_STATS_PROGRESS_TEXT_1;
							x = GRIDX(0.4);
							y = GRIDY(1);
							w = GRIDW(16);
							h = "0.9 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
							shadow = 0;
							colorShadow[]={1,1,1,1};
							colorText[]={0,0,0,1};
							colorBackground[]={1,1,1,0.1};
							sizeEx="0.8 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
							fade = 1;
						};
						class main_item_progressbar_2: main_item_progressbar_1 {
							idc = IDC_RscDisplayStore_ITEM_STATS_PROGRESS_2;
							x = GRIDX(0.4);
							y = GRIDY(2.5);
							w = GRIDW(16);
							h = "0.9 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
						};
						class main_item_progressbar_2_text: main_item_progressbar_1_text {
							idc = IDC_RscDisplayStore_ITEM_STATS_PROGRESS_TEXT_2;
							x = GRIDX(0.4);
							y = GRIDY(2.5);
							w = GRIDW(16);
							h = "0.9 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
						};
						class main_item_progressbar_3: main_item_progressbar_1 {
							idc = IDC_RscDisplayStore_ITEM_STATS_PROGRESS_3;
							x = GRIDX(0.4);
							y = GRIDY(4);
							w = GRIDW(16);
							h = "0.9 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
						};
						class main_item_progressbar_3_text: main_item_progressbar_1_text {
							idc = IDC_RscDisplayStore_ITEM_STATS_PROGRESS_TEXT_3;
							x = GRIDX(0.4);
							y = GRIDY(4);
							w = GRIDW(16);
							h = "0.9 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
						};						
						class main_item_progressbar_4: main_item_progressbar_1 {
							idc = IDC_RscDisplayStore_ITEM_STATS_PROGRESS_4;
							x = GRIDX(0.4);
							y = GRIDY(7);
							w = GRIDW(16);
							h = "0.9 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
						};
						class main_item_progressbar_4_text: main_item_progressbar_1_text {
							idc = IDC_RscDisplayStore_ITEM_STATS_PROGRESS_TEXT_4;
							x = GRIDX(0.4);
							y = GRIDY(7);
							w = GRIDW(16);
							h = "0.9 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
						};						
						class main_item_progressbar_5: main_item_progressbar_1 {
							idc = IDC_RscDisplayStore_ITEM_STATS_PROGRESS_5;
							x = GRIDX(0.4);
							y = GRIDY(10);
							w = GRIDW(16);
							h = "0.9 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
						};
						class main_item_progressbar_5_text: main_item_progressbar_1_text {
							idc = IDC_RscDisplayStore_ITEM_STATS_PROGRESS_TEXT_5;
							x = GRIDX(0.4);
							y = GRIDY(10);
							w = GRIDW(16);
							h = "0.9 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
						};						
					};
				};
			};
		};
	};
};
