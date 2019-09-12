#include "defines.hpp"
#include "idcs.hpp"

#define SCALEFACTOR getNumber (configFile >> "uiScaleFactor")
#define GRID_X(gridType, gridScale, num) (pixelW * gridType * (((num) * (gridScale)) / SCALEFACTOR))
#define GRID_Y(gridType, gridScale, num) (pixelH * gridType * (((num) * (gridScale)) / SCALEFACTOR))
#define FONT(num) (1.5 * pixelH * pixelGridNoUIScale * num) //(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * num)

// General MACROs
#define BAR_W 3
#define BAR_H 3
#define BUFFER_W 2
#define BUFFER_H 2
#define SPACE_W 1
#define SPACE_H 1

// Trader ctrl MACROS
#define COMBO_W 35
#define CARGO_W 18
#define LIST_W (COMBO_W + SPACE_W*4 + BAR_W*4) //54

#define ITEM_W 52
#define ITEM_X (LIST_W + BUFFER_W + BUFFER_W)
#define ITEM_Y (BAR_H*2 + SPACE_H*2 + SPACE_H)
#define PIC_H 21

#define DIALOG_W (128)
#define DIALOG_H (80)
#define DIALOG_X (safeZoneX + (safeZoneW / 2) - GRID_X(pixelGridNoUIScale, 2, DIALOG_W/2))
#define DIALOG_Y (safeZoneY + (safeZoneH / 2) - GRID_Y(pixelGridNoUIScale, 2, DIALOG_H/2))

// Item selection/information MACROs
#define STORE_W (109)
#define STORE_H (DIALOG_H)

#define FUNDS_W (20)
#define FUNDS_H (BAR_H)
#define FUNDS_X (STORE_W - BAR_W - FUNDS_W)

// Trader/Purchase information
#define TRADER_W (DIALOG_W - STORE_W)
#define TRADER_H (DIALOG_H)
#define TRADER_Y (DIALOG_Y + GRID_Y(pixelGridNoUIScale, 2, BAR_H + SPACE_H/*BAR_H*2 + SPACE_H*3*/))
#define TRADER_X (DIALOG_X + GRID_X(pixelGridNoUIScale, 2, STORE_W + SPACE_W))
#define TRADER_PIC_H 21

class RscDisplayStore {
	idd = IDD_DISPLAY_STORE;
	onLoad = "['onLoad', _this] call HALs_store_fnc_main";
	onUnload = "['onUnload', _this] call HALs_store_fnc_main";

	class controls {
		class ContainerGroup: RscItemCtrlGroupNoScrollbars {
			idc = IDC_GROUP_TRADER;
			x = TRADER_X;
			y = TRADER_Y;
			w = GRID_X(pixelGridNoUIScale, 2, TRADER_W);
			h = GRID_Y(pixelGridNoUIScale, 2, TRADER_H);

			class controls {
				class ContainerCombo: RscItemComboBox {
				    idc = IDC_BUY_ITEM_COMBO;
				    x = 0;
				    y = 0;
				    w = GRID_X(pixelGridNoUIScale, 2, TRADER_W);
				    h = GRID_Y(pixelGridNoUIScale, 2, BAR_H);
				    sizeEx = FONT(1);
				};

				class ContainerPictureBackground: RscItemText {
				    idc = -1;
				    x = 0;
				    y = GRID_Y(pixelGridNoUIScale, 2, BAR_H);
				    w = GRID_X(pixelGridNoUIScale, 2, TRADER_W);
				    h = GRID_Y(pixelGridNoUIScale, 2, TRADER_PIC_H - BAR_H);
				    colorBackground[] = {0, 0, 0, 0.4};
				};

				class ContainerPicture: RscItemCtrlStaticPictureKeepAspect {
				    idc = IDC_BUY_PICTURE;
				    x = 0;
				    y = GRID_Y(pixelGridNoUIScale, 2, BAR_H);
				    w = GRID_X(pixelGridNoUIScale, 2, TRADER_W);
				    h = GRID_Y(pixelGridNoUIScale, 2, TRADER_PIC_H - BAR_H);
				    colorBackground[] = {0, 0, 0, 0.7};
				};

				class ContainerLoadBackground: RscItemText {
				    idc = -1;
				    x = 0;
				    y = GRID_Y(pixelGridNoUIScale, 2, TRADER_PIC_H - SPACE_H);
				    w = GRID_X(pixelGridNoUIScale, 2, TRADER_W);
				    h = GRID_Y(pixelGridNoUIScale, 2, SPACE_H);
				    colorBackground[] = {0.05, 0.05, 0.05, 0.7};
				};

				class ContainerLoadNew: RscItemProgress {
				    idc = IDC_PROGRESS_NEWLOAD;
				   	x = 0;
				    y = GRID_Y(pixelGridNoUIScale, 2, TRADER_PIC_H - SPACE_H);
				    w = GRID_X(pixelGridNoUIScale, 2, TRADER_W);
				    h = GRID_Y(pixelGridNoUIScale, 2, SPACE_H);
				    colorBar[] = {0.9, 0, 0, 0.6};
				    colorExtBar[] = {1, 1, 1, 0};
				    colorFrame[] = {0, 0, 0, 0};
				};

				class ContainerLoadPrev: RscItemProgress {
				    idc = IDC_PROGRESS_LOAD;
				    x = 0;
				    y = GRID_Y(pixelGridNoUIScale, 2, TRADER_PIC_H - SPACE_H);
				    w = GRID_X(pixelGridNoUIScale, 2, TRADER_W);
				    h = GRID_Y(pixelGridNoUIScale, 2, SPACE_H);
				    colorBar[] = {0.9, 0.9, 0.9, 0.9};
				    colorExtBar[] = {1, 1, 1, 0};
				    colorFrame[] = {0, 0, 0, 0};
				};

				class PurchaseSummary: RscItemStructuredText {
				    idc = IDC_ITEM;
				    x = 0; //GRID_X(pixelGridNoUIScale, 2, MAIN_W + SPACE_W); //GRIDX(36.2);
				    y = GRID_Y(pixelGridNoUIScale, 2, TRADER_PIC_H + SPACE_H);
				    w = GRID_X(pixelGridNoUIScale, 2, TRADER_W);
				    h = GRID_Y(pixelGridNoUIScale, 2, BAR_H);

				    class Attributes {
				        align = "right";
				        color = "#ffffff";
				        shadow = 1;
				        font = "PuristaMedium";
				    };

				    colorBackground[] = {0, 0, 0, 0.7};
				    size = FONT(0.9);
				};

				class PurchaseCheckbox: RscItemCheckboxGreen {
				    idc = IDC_CHECKBOX_BUY;
				    x = 0;
				    y = GRID_Y(pixelGridNoUIScale, 2, TRADER_PIC_H + SPACE_H + BAR_H);
				    w = GRID_X(pixelGridNoUIScale, 2, BAR_W);
				    h = GRID_Y(pixelGridNoUIScale, 2, BAR_H);
				    tooltip = "$STR_HALS_STORE_CHECKBOX_EQUIP";
					colorBackground[] = {0, 0, 0, 0.7};
					colorBackgroundHover[] = {0, 0, 0, 0.7};
					colorBackgroundFocused[] = {0, 0, 0, 0.7};
					colorBackgroundPressed[] = {0, 0, 0, 0.7};
				};

				class PurchaseAmountEdit: RscItemEdit {
				    idc = IDC_EDIT;
				    x = 0;
				    y = GRID_Y(pixelGridNoUIScale, 2, TRADER_PIC_H + SPACE_H + BAR_H);
				    w = GRID_X(pixelGridNoUIScale, 2, TRADER_W);
				    h = GRID_Y(pixelGridNoUIScale, 2, BAR_H);
				    maxChars = 4;
				    style = "16 + 512 + 0x01";
				    colorBackground[] = {0, 0, 0, 0.7};
					colorText[] = {1, 1, 1, 1};
				    tooltip = "Number of items to buy";
				    sizeEx = FONT(0.9);
				};

				class PurchaseButton: RscItemButtonAction {
				    idc = IDC_BUTTON_BUY;
				    x = GRID_X(pixelGridNoUIScale, 2, BAR_W + SPACE_W);
				    y = GRID_Y(pixelGridNoUIScale, 2, TRADER_PIC_H + SPACE_H + BAR_H);
				    w = GRID_X(pixelGridNoUIScale, 2, TRADER_W - BAR_W - SPACE_W);
				    h = GRID_Y(pixelGridNoUIScale, 2, BAR_H);
					text = "$STR_HALS_STORE_BUTTON_PURCHASE";
					sizeEx = FONT(1);
					action = "['button', ['buy', []]] call HALs_store_fnc_main;";
				};

				class SellButton: RscItemButtonAction {
					idc = IDC_BUTTON_SELL;
					fade = 1;
					x = GRID_X(pixelGridNoUIScale, 2, BAR_W + SPACE_W);
					y = GRID_Y(pixelGridNoUIScale, 2, TRADER_PIC_H + SPACE_H + BAR_H + SPACE_H + BAR_H);
					w = GRID_X(pixelGridNoUIScale, 2, TRADER_W - BAR_W - SPACE_W);
					h = GRID_Y(pixelGridNoUIScale, 2, BAR_H);
					text = "SELL"; //"$STR_HALS_STORE_BUTTON_SELL";
					sizeEx = FONT(1);
					action = "['button', ['sell', []]] call HALs_store_fnc_main;";
				};
			};
		};

		class HALs_store_dialog: RscItemCtrlGroupNoScrollbars {
			idc = IDC_GROUP_ITEMS;
			x = DIALOG_X;
			y = DIALOG_Y;
			w = GRID_X(pixelGridNoUIScale, 2, STORE_W);
			h = GRID_Y(pixelGridNoUIScale, 2, STORE_H);

			class controls {
				class TitleBackground: RscItemText {
					idc = -1;
					x = 0;
					y = 0;
					w = GRID_X(pixelGridNoUIScale, 2, STORE_W);
					h = GRID_Y(pixelGridNoUIScale, 2, BAR_H);
					colorBackground[] = {0, 0, 0, 0.7};
				};

				class StoreBackground: RscItemText {
					idc = -1;
					x = 0;
					y = GRID_Y(pixelGridNoUIScale, 2, BAR_H + SPACE_H);
					w = GRID_X(pixelGridNoUIScale, 2, STORE_W);
					h = GRID_Y(pixelGridNoUIScale, 2, STORE_H - (BAR_H + SPACE_H));
					colorBackground[] = {0, 0, 0, 0.7};
				};

				class TitleFunds: RscItemStructuredText {
					idc = IDC_FUNDS;
					x = GRID_X(pixelGridNoUIScale, 2, FUNDS_X);
					y = 0;
					w = GRID_X(pixelGridNoUIScale, 2, FUNDS_W);
					h = GRID_Y(pixelGridNoUIScale, 2, FUNDS_H);

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
					w = GRID_X(pixelGridNoUIScale, 2, STORE_W);
					h = GRID_Y(pixelGridNoUIScale, 2, BAR_H);
					colorText[] = {0.95, 0.95, 0.95, 1};
					sizeEx = FONT(1);
					style = 0;
				};

				class CloseButton: RscItemButtonClose {
					idc = -1;
					x = GRID_X(pixelGridNoUIScale, 2, STORE_W - BAR_W);
					y = 0;
					w = GRID_X(pixelGridNoUIScale, 2, BAR_W);
					h = GRID_Y(pixelGridNoUIScale, 2, BAR_H);
					text = "\a3\3DEN\Data\ControlsGroups\Tutorial\close_ca.paa";
					action = "['onUnload'] call HALs_store_fnc_main;";
				};

				class ComboCategories: RscItemComboBox {
					idc = IDC_COMBO_CATEGORY;
					x = GRID_X(pixelGridNoUIScale, 2, BUFFER_W);
					y = GRID_Y(pixelGridNoUIScale, 2, BAR_H + SPACE_H + SPACE_H);
					w = GRID_X(pixelGridNoUIScale, 2, COMBO_W);
					h = GRID_Y(pixelGridNoUIScale, 2, BAR_H);
					sizeEx = FONT(1);
					colorBackground[] = {0, 0, 0, 0.95};
				};

				class ItemListboxSortButton: RscItemButtonAction {
					idc = IDC_LISTBOX_SORT;
					x = GRID_X(pixelGridNoUIScale, 2, BUFFER_W + COMBO_W + SPACE_W);
					y = GRID_Y(pixelGridNoUIScale, 2, BAR_H + SPACE_H + SPACE_H);
					w = GRID_X(pixelGridNoUIScale, 2, BAR_W);
					h = GRID_Y(pixelGridNoUIScale, 2, BAR_H);
					text = "↑";
					action = "['button', ['sort', []]] call HALs_store_fnc_main;";
					colorBackground[] = {0, 0, 0, 0};
					colorBorder[] = {0, 0, 0, 1};
					colorFocused[] = {0, 0, 0, 0};
					colorShadow[] = {0, 0, 0, 0};
					colorBackgroundFocused[] = {1, 1, 1, 0};
					shadow = 2;
					sizeEx = FONT(1);
					font = "PuristaMedium";
					tooltip = "Alphabetise the listbox";
				};

				class ItemCheckbox1: RscItemCheckboxGreen {
					idc = IDC_CHECKBOX + 1;
					x = GRID_X(pixelGridNoUIScale, 2, BUFFER_W + COMBO_W + SPACE_W*2 + BAR_W);
					y = GRID_Y(pixelGridNoUIScale, 2, BAR_H + SPACE_H + SPACE_H);
					w = GRID_X(pixelGridNoUIScale, 2, BAR_W);
					h = GRID_Y(pixelGridNoUIScale, 2, BAR_H);
				};

				class ItemCheckbox2: RscItemCheckboxGreen {
					idc = IDC_CHECKBOX + 2;
					x = GRID_X(pixelGridNoUIScale, 2, BUFFER_W + COMBO_W + SPACE_W*3 + BAR_W*2);
					y = GRID_Y(pixelGridNoUIScale, 2, BAR_H + SPACE_H + SPACE_H);
					w = GRID_X(pixelGridNoUIScale, 2, BAR_W);
					h = GRID_Y(pixelGridNoUIScale, 2, BAR_H);
				};

				class ItemCheckbox3: RscItemCheckboxGreen {
					idc = IDC_CHECKBOX + 3;
					x = GRID_X(pixelGridNoUIScale, 2, BUFFER_W + COMBO_W + SPACE_W*4 + BAR_W*3);
					y = GRID_Y(pixelGridNoUIScale, 2, BAR_H + SPACE_H + SPACE_H);
					w = GRID_X(pixelGridNoUIScale, 2, BAR_W);
					h = GRID_Y(pixelGridNoUIScale, 2, BAR_H);
				};

				class ItemListbox: RscItemListBox {
					idc = IDC_LISTBOX;
					x = GRID_X(pixelGridNoUIScale, 2, BUFFER_W);
					y = GRID_Y(pixelGridNoUIScale, 2, BAR_H*2 + SPACE_H*2 + SPACE_H);
					w = GRID_X(pixelGridNoUIScale, 2, LIST_W);
					h = GRID_Y(pixelGridNoUIScale, 2, STORE_H - (BAR_H*2 + SPACE_H*3 + BUFFER_H));
					sizeEx = FONT(0.8);
					font = "PuristaMedium";
					colorTextRight[] = {0.666667, 1, 0.666667, 1};
					colorSelectRight[] = {0.666667, 1, 0.666667, 1};
					colorSelect[] = {1, 0.7, 0.09, 1};
					colorSelectBackground[] = {1, 1, 1, 0.2};
					colorSelectBackground2[] = {1, 1, 1, 0.2};
				};

				class ItemPictureBackground: RscItemText {
					idc = -1;
					x = GRID_X(pixelGridNoUIScale, 2, ITEM_X);
					y = GRID_Y(pixelGridNoUIScale, 2, ITEM_Y);
					w = GRID_X(pixelGridNoUIScale, 2, ITEM_W);
					h = GRID_Y(pixelGridNoUIScale, 2, PIC_H);
					colorBackground[] = {1, 1, 1, 0.2};
				};

				class ItemPicture: RscItemCtrlStaticPictureKeepAspect {
					idc = IDC_ITEM_PICTURE;
					x = GRID_X(pixelGridNoUIScale, 2, ITEM_X);
					y = GRID_Y(pixelGridNoUIScale, 2, ITEM_Y);
					w = GRID_X(pixelGridNoUIScale, 2, ITEM_W);
					h = GRID_Y(pixelGridNoUIScale, 2, PIC_H);
				};

				class ItemDescriptionBackground: RscItemText {
					idc = -1;
					x = GRID_X(pixelGridNoUIScale, 2, ITEM_X);
					y = GRID_Y(pixelGridNoUIScale, 2, ITEM_Y + PIC_H + SPACE_H);
					w = GRID_X(pixelGridNoUIScale, 2, ITEM_W);
					h = GRID_Y(pixelGridNoUIScale, 2, STORE_H - (ITEM_Y + PIC_H + SPACE_H + BUFFER_H));
					colorBackground[] = {0.05, 0.05, 0.05, 0.3};
				};

				class ItemDescriptionGroup: RscItemCtrlGroup {
					idc = -1;
					x = GRID_X(pixelGridNoUIScale, 2, ITEM_X);
					y = GRID_Y(pixelGridNoUIScale, 2, ITEM_Y + PIC_H + SPACE_H);
					w = GRID_X(pixelGridNoUIScale, 2, ITEM_W);
					h = GRID_Y(pixelGridNoUIScale, 2, STORE_H - (ITEM_Y + PIC_H + SPACE_H + BUFFER_H));

					class controls {
						class ItemText: RscItemStructuredText {
							idc = IDC_ITEM_TEXT;
							x = 0;
							y = 0;
							w = GRID_X(pixelGridNoUIScale, 2, ITEM_W);
							h = GRID_Y(pixelGridNoUIScale, 2, PIC_H);
							shadow = 0;
						};

						class ItemDescripton: RscItemStructuredText {
							idc = IDC_ITEM_TEXT_DES;
							x = 0;
							y = 0;
							w = GRID_X(pixelGridNoUIScale, 2, ITEM_W - 1);
							h = GRID_Y(pixelGridNoUIScale, 2, PIC_H);
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
							w = GRID_X(pixelGridNoUIScale, 2, ITEM_W - 2);
							h = GRID_Y(pixelGridNoUIScale, 2, BAR_H);
						};
						class ProgressBarText1: RscItemStatText {
							idc = IDC_STATS_PROGRESS_TEXT_1;
							x = GRID_X(pixelGridNoUIScale, 2, SPACE_W);
							y = GRID_Y(pixelGridNoUIScale, 2, SPACE_H);
							w = GRID_X(pixelGridNoUIScale, 2, ITEM_W - 2);
							h = GRID_Y(pixelGridNoUIScale, 2, BAR_H);
							sizeEx = FONT(0.8);
						};
						class ProgressBar2: RscItemStatProgress {
							idc = IDC_STATS_PROGRESS_2;
							x = GRID_X(pixelGridNoUIScale, 2, SPACE_W);
							y = GRID_Y(pixelGridNoUIScale, 2, 4);
							w = GRID_X(pixelGridNoUIScale, 2, ITEM_W - 2);
							h = GRID_Y(pixelGridNoUIScale, 2, BAR_H);
						};
						class ProgressBarText2: RscItemStatText {
							idc = IDC_STATS_PROGRESS_TEXT_2;
							x = GRID_X(pixelGridNoUIScale, 2, SPACE_W);
							y = GRID_Y(pixelGridNoUIScale, 2, 4);
							w = GRID_X(pixelGridNoUIScale, 2, ITEM_W - 2);
							h = GRID_Y(pixelGridNoUIScale, 2, BAR_H);
							sizeEx = FONT(0.8);
						};
						class ProgressBar3: RscItemStatProgress {
							idc = IDC_STATS_PROGRESS_3;
							x = GRID_X(pixelGridNoUIScale, 2, SPACE_W);
							y = GRID_Y(pixelGridNoUIScale, 2, 7);
							w = GRID_X(pixelGridNoUIScale, 2, ITEM_W - 2);
							h = GRID_Y(pixelGridNoUIScale, 2, BAR_H);
						};
						class ProgressBarText3: RscItemStatText {
							idc = IDC_STATS_PROGRESS_TEXT_3;
							x = GRID_X(pixelGridNoUIScale, 2, SPACE_W);
							y = GRID_Y(pixelGridNoUIScale, 2, 7);
							w = GRID_X(pixelGridNoUIScale, 2, ITEM_W - 2);
							h = GRID_Y(pixelGridNoUIScale, 2, BAR_H);
							sizeEx = FONT(0.8);
						};
						class ProgressBar4: RscItemStatProgress {
							idc = IDC_STATS_PROGRESS_4;
							x = GRID_X(pixelGridNoUIScale, 2, SPACE_W);
							y = GRID_Y(pixelGridNoUIScale, 2, 10);
							w = GRID_X(pixelGridNoUIScale, 2, ITEM_W - 2);
							h = GRID_Y(pixelGridNoUIScale, 2, BAR_H);
						};
						class ProgressBarText4: RscItemStatText {
							idc = IDC_STATS_PROGRESS_TEXT_4;
							x = GRID_X(pixelGridNoUIScale, 2, SPACE_W);
							y = GRID_Y(pixelGridNoUIScale, 2, 10);
							w = GRID_X(pixelGridNoUIScale, 2, ITEM_W - 2);
							h = GRID_Y(pixelGridNoUIScale, 2, BAR_H);
							sizeEx = FONT(0.8);
						};
						class ProgressBar5: RscItemStatProgress {
							idc = IDC_STATS_PROGRESS_5;
							x = GRID_X(pixelGridNoUIScale, 2, SPACE_W);
							y = GRID_Y(pixelGridNoUIScale, 2, 13);
							w = GRID_X(pixelGridNoUIScale, 2, ITEM_W - 2);
							h = GRID_Y(pixelGridNoUIScale, 2, BAR_H);
						};
						class ProgressBarText5: RscItemStatText {
							idc = IDC_STATS_PROGRESS_TEXT_5;
							x = GRID_X(pixelGridNoUIScale, 2, SPACE_W);
							y = GRID_Y(pixelGridNoUIScale, 2, 13);
							w = GRID_X(pixelGridNoUIScale, 2, ITEM_W - 2);
							h = GRID_Y(pixelGridNoUIScale, 2, BAR_H);
							sizeEx = FONT(0.8);
						};
					};
				};
			};
		};
	};
};
