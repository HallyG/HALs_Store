#include "defines.hpp"
#include "idcs.hpp"
#include "sizes.hpp"

#define GRID 2
#define SCALEFACTOR getNumber (configFile >> "uiScaleFactor")
#define GRID_X(gridType, gridScale, num) (pixelW * gridType * (((num) * (gridScale)) / SCALEFACTOR))
#define GRID_Y(gridType, gridScale, num) (pixelH * gridType * (((num) * (gridScale)) / SCALEFACTOR))
#define FONT(num) (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * num)

#define MAIN_W 110
#define MAIN_H 90
#define COMBO_W 35
#define LIST_W 54
#define BAR_H 3
#define BAR_W 3
#define SPACE_W 1
#define SPACE_H 1

class RscDisplayStore {
	idd = 85999;
	onLoad = "['onLoad', _this] call HALs_store_fnc_main";
	onUnload = "['onUnload', _this] call HALs_store_fnc_main";

	class controls {
		class HALs_store_dialog: HALsControlsGroupNoScrollbars {
			idc = IDD_RscDisplayStore;
			x = safeZoneX + (safeZoneW / 2) - GRID_X(pixelGridNoUIScale, 2, MAIN_W/2);
			y = safeZoneY + (safeZoneH / 2) - GRID_Y(pixelGridNoUIScale, 2, MAIN_H/2);
			w = GRID_X(pixelGridNoUIScale, 2, MAIN_W);
			h = GRID_Y(pixelGridNoUIScale, 2, MAIN_H);

			class controls {
				class TitleBackground: RscItemText {
					idc = -1;
					x = 0;
					y = 0;
					w = GRID_X(pixelGridNoUIScale, 2, MAIN_W);
					h = GRID_Y(pixelGridNoUIScale, 2, BAR_H);
					colorBackground[] = {0, 0, 0, 0.7};
				};

				class StoreBackground: RscItemText {
					idc = -1;
					x = 0;
					y = GRID_Y(pixelGridNoUIScale, 2, BAR_H + SPACE_H);
					w = GRID_X(pixelGridNoUIScale, 2, MAIN_W);
					h = GRID_Y(pixelGridNoUIScale, 2, MAIN_H - (BAR_H + SPACE_H));
					colorBackground[] = {0, 0, 0, 0.7};
				};

				class TitleFunds: RscItemStructuredText {
					idc = IDC_FUNDS;
					x = GRID_X(pixelGridNoUIScale, 2, MAIN_W - BAR_W - 20);
					y = 0;
					w = GRID_X(pixelGridNoUIScale, 2, 20);
					h = GRID_Y(pixelGridNoUIScale, 2, BAR_H);

					class Attributes {
						align = "right";
						font = "PuristaLight";
					};

					sizeEx = FONT(0.8);
				};

				class TitleText: RscItemText {
					idc = IDC_TITLE;
					x = 0;
					y = 0;
					w = GRID_X(pixelGridNoUIScale, 2, MAIN_W);
					h = GRID_Y(pixelGridNoUIScale, 2, BAR_H);
					colorText[] = {0.95, 0.95, 0.95, 1};
					sizeEx = FONT(1);
					style = 0;
				};

				class CloseButton: HALsStore_ctrlButtonPictureKeepAspect {
					idc = IDC_BUTTON_CLOSE;
					x = GRID_X(pixelGridNoUIScale, 2, MAIN_W - BAR_W);
					y = 0;
					w = GRID_X(pixelGridNoUIScale, 2, BAR_W);
					h = GRID_Y(pixelGridNoUIScale, 2, BAR_H);
					text = "\a3\3DEN\Data\ControlsGroups\Tutorial\close_ca.paa";
					tooltip = "Close";
					action = "['onUnload'] call HALs_store_fnc_main;";
					colorText[] = {1, 1, 1, 1};
					colorActive[] = {1, 1, 1, 1};
					color[] = {1, 1, 1, 0.5};
					colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R', 0])","(profilenamespace getvariable ['GUI_BCG_RGB_G',0])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0])", 0};
				};

				class ComboCategories: HALsStore_ctrlComboItem {
					idc = IDC_COMBO_CATEGORY;
					x = GRID_X(pixelGridNoUIScale, 2, SPACE_W);
					y = GRID_Y(pixelGridNoUIScale, 2, BAR_H + SPACE_H + SPACE_H);
					w = GRID_X(pixelGridNoUIScale, 2, COMBO_W);
					h = GRID_Y(pixelGridNoUIScale, 2, BAR_H);
					sizeEx = FONT(1);
					colorBackground[] = {0, 0, 0, 0.85};
				};

				class ItemCheckbox1: RscCtrlCheckboxGreen {
					idc = IDC_CHECKBOX1;
					x = GRID_X(pixelGridNoUIScale, 2, LIST_W - 2 - BAR_H*2 - SPACE_H*2);
					y = GRID_Y(pixelGridNoUIScale, 2, BAR_H + SPACE_H + SPACE_H);
					w = GRID_X(pixelGridNoUIScale, 2, BAR_W);
					h = GRID_Y(pixelGridNoUIScale, 2, BAR_H);
				};

				class ItemCheckbox2: RscCtrlCheckboxGreen {
					idc = IDC_CHECKBOX2;
					x = GRID_X(pixelGridNoUIScale, 2, LIST_W - 2 - BAR_H - SPACE_H);
					y = GRID_Y(pixelGridNoUIScale, 2, BAR_H + SPACE_H + SPACE_H);
					w = GRID_X(pixelGridNoUIScale, 2, BAR_W);
					h = GRID_Y(pixelGridNoUIScale, 2, BAR_H);
				};

				class ItemCheckbox3: RscCtrlCheckboxGreen {
					idc = IDC_CHECKBOX3;
					x = GRID_X(pixelGridNoUIScale, 2, LIST_W - 2);
					y = GRID_Y(pixelGridNoUIScale, 2, BAR_H + SPACE_H + SPACE_H);
					w = GRID_X(pixelGridNoUIScale, 2, BAR_W);
					h = GRID_Y(pixelGridNoUIScale, 2, BAR_H);
				};

				class ItemListbox: RscItemListBox {
					idc = IDC_LISTBOX;
					x = GRID_X(pixelGridNoUIScale, 2, SPACE_W);
					y = GRID_Y(pixelGridNoUIScale, 2, BAR_H*2 + SPACE_H*2 + SPACE_H);
					w = GRID_X(pixelGridNoUIScale, 2, LIST_W);
					h = GRID_Y(pixelGridNoUIScale, 2, MAIN_H - 10);
					sizeEx = FONT(0.8);
					font = "PuristaMedium";
				};

				class ItemPictureBackground: RscItemText {
					idc = -1;
					x = GRID_X(pixelGridNoUIScale, 2, LIST_W + 3);
					y = GRID_Y(pixelGridNoUIScale, 2, BAR_H*2 + SPACE_H*2 + SPACE_H);
					w = GRID_X(pixelGridNoUIScale, 2, 40 + 12);
					h = GRID_Y(pixelGridNoUIScale, 2, 21);
					colorBackground[] = {1, 1, 1, 0.2};
				};

				class ItemPicture: HALsStore_ctrlStaticPictureKeepAspect {
					idc = IDC_ITEM_PICTURE;
					x = GRID_X(pixelGridNoUIScale, 2, LIST_W + 3);
					y = GRID_Y(pixelGridNoUIScale, 2, BAR_H*2 + SPACE_H*2 + SPACE_H);
					w = GRID_X(pixelGridNoUIScale, 2, 40 + 12);
					h = GRID_Y(pixelGridNoUIScale, 2, 21);
				};

				class ItemDescriptionBackground: RscItemText {
					idc = -1;
					x = GRID_X(pixelGridNoUIScale, 2, LIST_W + 3);
					y = GRID_Y(pixelGridNoUIScale, 2, 30 + SPACE_H);
					w = GRID_X(pixelGridNoUIScale, 2, 40 + 12);
					h = GRID_Y(pixelGridNoUIScale, 2, MAIN_H - 31 - SPACE_H);
					colorBackground[] = {0.05, 0.05, 0.05, 0.3};
				};

				class ItemDescriptionGroup: HALsControlsGroup {
					idc = IDC_ITEM_TEXT_GROUP;
					x = GRID_X(pixelGridNoUIScale, 2, LIST_W + 3);
					y = GRID_Y(pixelGridNoUIScale, 2, 30 + SPACE_H);
					w = GRID_X(pixelGridNoUIScale, 2, 40 + 12);
					h = GRID_Y(pixelGridNoUIScale, 2, MAIN_H - 31 - SPACE_H);

					class controls {
						class ItemText: RscItemStructuredText {
							idc = IDC_ITEM_TEXT;
							x = 0;
							y = 0;
							w = GRID_X(pixelGridNoUIScale, 2, 40 + 12);
							h = GRID_Y(pixelGridNoUIScale, 2, 21);
							//size = FONT(0.9);
							shadow = 0;
						};

						class ItemDescripton: RscItemStructuredText {
							idc = IDC_ITEM_TEXT_DES;
							x = 0;
							y = 0;
							w = GRID_X(pixelGridNoUIScale, 2, 40 + 12);
							h = GRID_Y(pixelGridNoUIScale, 2, 21);
							size = FONT(0.9);

							class Attributes {
								align = "left";
								color = "#ffffff";
								shadow = 1;
								font = "PuristaMedium";
							};
						};

						class ProgressBar1: RscItemStatProgress {
							idc = IDC_STATS_PROGRESS_1;
							x = GRID_X(pixelGridNoUIScale, 2, SPACE_W);
							y = GRID_Y(pixelGridNoUIScale, 2, SPACE_H);
							w = GRID_X(pixelGridNoUIScale, 2, 40 + 12 - 2);
							h = GRID_Y(pixelGridNoUIScale, 2, BAR_H);
						};
						class ProgressBarText1: RscItemStatText {
							idc = IDC_STATS_PROGRESS_TEXT_1;
							x = GRID_X(pixelGridNoUIScale, 2, SPACE_W);
							y = GRID_Y(pixelGridNoUIScale, 2, SPACE_H);
							w = GRID_X(pixelGridNoUIScale, 2, 40 + 12 - 2);
							h = GRID_Y(pixelGridNoUIScale, 2, BAR_H);
							sizeEx = FONT(0.8);
						};
						class ProgressBar2: RscItemStatProgress {
							idc = IDC_STATS_PROGRESS_2;
							x = GRID_X(pixelGridNoUIScale, 2, SPACE_W);
							y = GRID_Y(pixelGridNoUIScale, 2, 4);
							w = GRID_X(pixelGridNoUIScale, 2, 40 + 12 - 2);
							h = GRID_Y(pixelGridNoUIScale, 2, BAR_H);
						};
						class ProgressBarText2: RscItemStatText {
							idc = IDC_STATS_PROGRESS_TEXT_2;
							x = GRID_X(pixelGridNoUIScale, 2, SPACE_W);
							y = GRID_Y(pixelGridNoUIScale, 2, 4);
							w = GRID_X(pixelGridNoUIScale, 2, 40 + 12 - 2);
							h = GRID_Y(pixelGridNoUIScale, 2, BAR_H);
							sizeEx = FONT(0.8);
						};
						class ProgressBar3: RscItemStatProgress {
							idc = IDC_STATS_PROGRESS_3;
							x = GRID_X(pixelGridNoUIScale, 2, SPACE_W);
							y = GRID_Y(pixelGridNoUIScale, 2, 7);
							w = GRID_X(pixelGridNoUIScale, 2, 40 + 12 - 2);
							h = GRID_Y(pixelGridNoUIScale, 2, BAR_H);
						};
						class ProgressBarText3: RscItemStatText {
							idc = IDC_STATS_PROGRESS_TEXT_3;
							x = GRID_X(pixelGridNoUIScale, 2, SPACE_W);
							y = GRID_Y(pixelGridNoUIScale, 2, 7);
							w = GRID_X(pixelGridNoUIScale, 2, 40 + 12 - 2);
							h = GRID_Y(pixelGridNoUIScale, 2, BAR_H);
							sizeEx = FONT(0.8);
						};
						class ProgressBar4: RscItemStatProgress {
							idc = IDC_STATS_PROGRESS_4;
							x = GRID_X(pixelGridNoUIScale, 2, SPACE_W);
							y = GRID_Y(pixelGridNoUIScale, 2, 10);
							w = GRID_X(pixelGridNoUIScale, 2, 40 + 12 - 2);
							h = GRID_Y(pixelGridNoUIScale, 2, BAR_H);
						};
						class ProgressBarText4: RscItemStatText {
							idc = IDC_STATS_PROGRESS_TEXT_4;
							x = GRID_X(pixelGridNoUIScale, 2, SPACE_W);
							y = GRID_Y(pixelGridNoUIScale, 2, 10);
							w = GRID_X(pixelGridNoUIScale, 2, 40 + 12 - 2);
							h = GRID_Y(pixelGridNoUIScale, 2, BAR_H);
							sizeEx = FONT(0.8);
						};
						class ProgressBar5: RscItemStatProgress {
							idc = IDC_STATS_PROGRESS_5;
							x = GRID_X(pixelGridNoUIScale, 2, SPACE_W);
							y = GRID_Y(pixelGridNoUIScale, 2, 13);
							w = GRID_X(pixelGridNoUIScale, 2, 40 + 12 - 2);
							h = GRID_Y(pixelGridNoUIScale, 2, BAR_H);
						};
						class ProgressBarText5: RscItemStatText {
							idc = IDC_STATS_PROGRESS_TEXT_5;
							x = GRID_X(pixelGridNoUIScale, 2, SPACE_W);
							y = GRID_Y(pixelGridNoUIScale, 2, 13);
							w = GRID_X(pixelGridNoUIScale, 2, 40 + 12 - 2);
							h = GRID_Y(pixelGridNoUIScale, 2, BAR_H);
							sizeEx = FONT(0.8);
						};
					};
				};


























































				class PurchaseButton: HALsStore_ctrlButton {
					idc = IDC_BUTTON_BUY;
					x = GRIDX(37.3);
					y = GRIDY(13.4) + BUFFER_Y; //12.3
					w = GRIDW(4.9);
					h = 1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25);
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
				class PurchaseInfo: RscItemStructuredText {
					idc = IDC_ITEM;
					x = GRIDX(36.2);
					y = GRIDY(9.2) + BUFFER_Y; //9.2
					w = GRIDW(6);
					h = GRIDH(6);
					font = "PuristaMedium";

					colorBackground[] = {0.05,0.05,0.05,0.7};
					size="(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.9)";
				};
				class TraderBackground1: RscItemText {
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
				class TraderBackground2: RscItemText {
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

				class TraderStatsBackground: RscItemText {
					idc = -1;
					x = GRIDX(36.2) - 0*pixelW;
					y = GRIDY(8.5) + BUFFER_Y;
					w = GRIDW(6) + 0*(pixelW * 3);
					h = GRIDH(0.5) - 0*(pixelH * 3); //0.2 gap width plus 1 border

					colorBackground[]={0.05,0.05,0.05,0.7};
				};

				class TraderProgressNew: RscItemProgress {
					idc = IDC_PROGRESS_NEWLOAD;
					x = GRIDX(36.2) + 0*pixelW;//36.25
					y = GRIDY(8.5) + BUFFER_Y;
					w = GRIDW(6);
					h = GRIDH(0.5); //0.2 gap width plus 1 border

					colorBar[]={0.9,0,0,0.6};
					colorExtBar[]={1,1,1,0};
					colorFrame[]={0,0,0,0};
					//colorBackground[]={0,0,0,0.5}
					//colorBackground[]={0,0,0,0.3};
				};

				class TraderProgressOld: RscItemProgress {
					idc = IDC_PROGRESS_LOAD;
					x = GRIDX(36.2) + 0*pixelW;
					y = GRIDY(8.5) + BUFFER_Y;
					w = GRIDW(6);
					h = GRIDH(0.5);

					colorBar[]={0.9,0.9,0.9,0.9};
					colorExtBar[]={1,1,1,0};
					colorFrame[]={0,0,0,0};
				};
			};
		};
	};
};
