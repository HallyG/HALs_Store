#include "defines.hpp"
#include "idcs.hpp"

#define SCALEFACTOR getNumber (configFile >> "uiScaleFactor")
#define GRID_X(gridType, gridScale, num) (pixelW * gridType * (((num) * (gridScale)) / SCALEFACTOR))
#define GRID_Y(gridType, gridScale, num) (pixelH * gridType * (((num) * (gridScale)) / SCALEFACTOR))
#define FONT(num) (1.5 * pixelH * pixelGridNoUIScale * num) //(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * num)

#define DIALOG_W (128)
#define DIALOG_H (80)
#define DIALOG_X (safeZoneX + (safeZoneW / 2) - GRID_X(pixelGridNoUIScale, 2, DIALOG_W/2))
#define DIALOG_Y (safeZoneY + (safeZoneH / 2) - GRID_Y(pixelGridNoUIScale, 2, DIALOG_H/2))

// General MACROs
#define BAR_W 3
#define BAR_H 3
#define SPACE_W 1
#define SPACE_H 1

// Item selection/information MACROs
#define STORE_W (110)
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

// Trader ctrl MACROS
#define COMBO_W 35
#define LIST_W 54
#define ITEM_W 52
#define CARGO_W 18

class RscDisplayStore {
	idd = IDD_DISPLAY_STORE;
	onLoad = "['onLoad', _this] call HALs_store_fnc_main";
	onUnload = "['onUnload', _this] call HALs_store_fnc_main";

	class controls {
		class ContainerGroup: HALsControlsGroupNoScrollbars {
			idc = IDC_GROUP_TRADER;
			x = TRADER_X;
			y = TRADER_Y;
			w = GRID_X(pixelGridNoUIScale, 2, TRADER_W);
			h = GRID_Y(pixelGridNoUIScale, 2, TRADER_H);

			class controls {
				class ContainerCombo: HALsStore_ctrlComboItem {
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

				class ContainerPicture: HALsStore_ctrlStaticPictureKeepAspect {
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

				class PurchaseCheckbox: RscCtrlCheckboxGreen {
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

				class PurchaseAmountEdit: HALsStore_ctrlEdit {
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

				class PurchaseButton: RscCtrlButtonAction {
				    idc = IDC_BUTTON_BUY;
				    x = GRID_X(pixelGridNoUIScale, 2, BAR_W + SPACE_W);
				    y = GRID_Y(pixelGridNoUIScale, 2, TRADER_PIC_H + SPACE_H + BAR_H);
				    w = GRID_X(pixelGridNoUIScale, 2, TRADER_W - BAR_W - SPACE_W);
				    h = GRID_Y(pixelGridNoUIScale, 2, BAR_H);
					text = "$STR_HALS_STORE_BUTTON_PURCHASE";
					action = "['BUTTON', ['BUY', []]] call HALs_store_fnc_main;";
				};

				class SellButton: RscCtrlButtonAction {
					idc = IDC_BUTTON_SELL;
					x = GRID_X(pixelGridNoUIScale, 2, BAR_W + SPACE_W);
					y = GRID_Y(pixelGridNoUIScale, 2, TRADER_PIC_H + SPACE_H + BAR_H + SPACE_H + BAR_H);
					w = GRID_X(pixelGridNoUIScale, 2, TRADER_W - BAR_W - SPACE_W);
					h = GRID_Y(pixelGridNoUIScale, 2, BAR_H);
					text = "SELL"; //"$STR_HALS_STORE_BUTTON_SELL";
					action = "['BUTTON', ['SELL', []]] call HALs_store_fnc_main;";
				};
			};
		};

		class HALs_store_dialog: HALsControlsGroupNoScrollbars {
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

				class CloseButton: RscButtonClose {
					idc = -1;
					x = GRID_X(pixelGridNoUIScale, 2, STORE_W - BAR_W);
					y = 0;
					w = GRID_X(pixelGridNoUIScale, 2, BAR_W);
					h = GRID_Y(pixelGridNoUIScale, 2, BAR_H);
					text = "\a3\3DEN\Data\ControlsGroups\Tutorial\close_ca.paa";
					action = "['onUnload'] call HALs_store_fnc_main;";
				};

				class ComboCategories: HALsStore_ctrlComboItem {
					idc = IDC_COMBO_CATEGORY;
					x = GRID_X(pixelGridNoUIScale, 2, SPACE_W);
					y = GRID_Y(pixelGridNoUIScale, 2, BAR_H + SPACE_H + SPACE_H);
					w = GRID_X(pixelGridNoUIScale, 2, COMBO_W);
					h = GRID_Y(pixelGridNoUIScale, 2, BAR_H);
					sizeEx = FONT(1);
					colorBackground[] = {0, 0, 0, 0.95};
				};

				class ItemCheckbox1: RscCtrlCheckboxGreen {
					idc = IDC_CHECKBOX + 1;
					x = GRID_X(pixelGridNoUIScale, 2, LIST_W - 2 - BAR_H*2 - SPACE_H*2);
					y = GRID_Y(pixelGridNoUIScale, 2, BAR_H + SPACE_H + SPACE_H);
					w = GRID_X(pixelGridNoUIScale, 2, BAR_W);
					h = GRID_Y(pixelGridNoUIScale, 2, BAR_H);
				};

				class ItemCheckbox2: RscCtrlCheckboxGreen {
					idc = IDC_CHECKBOX + 2;
					x = GRID_X(pixelGridNoUIScale, 2, LIST_W - 2 - BAR_H - SPACE_H);
					y = GRID_Y(pixelGridNoUIScale, 2, BAR_H + SPACE_H + SPACE_H);
					w = GRID_X(pixelGridNoUIScale, 2, BAR_W);
					h = GRID_Y(pixelGridNoUIScale, 2, BAR_H);
				};

				class ItemCheckbox3: RscCtrlCheckboxGreen {
					idc = IDC_CHECKBOX + 3;
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
					h = GRID_Y(pixelGridNoUIScale, 2, STORE_H - (BAR_H*2 + SPACE_H*4));
					sizeEx = FONT(0.8);
					font = "PuristaMedium";
				};

				class ItemPictureBackground: RscItemText {
					idc = -1;
					x = GRID_X(pixelGridNoUIScale, 2, LIST_W + 3);
					y = GRID_Y(pixelGridNoUIScale, 2, BAR_H*2 + SPACE_H*2 + SPACE_H);
					w = GRID_X(pixelGridNoUIScale, 2, ITEM_W);
					h = GRID_Y(pixelGridNoUIScale, 2, 21);
					colorBackground[] = {1, 1, 1, 0.2};
				};

				class ItemPicture: HALsStore_ctrlStaticPictureKeepAspect {
					idc = IDC_ITEM_PICTURE;
					x = GRID_X(pixelGridNoUIScale, 2, LIST_W + 3);
					y = GRID_Y(pixelGridNoUIScale, 2, BAR_H*2 + SPACE_H*2 + SPACE_H);
					w = GRID_X(pixelGridNoUIScale, 2, ITEM_W);
					h = GRID_Y(pixelGridNoUIScale, 2, 21);
				};

				class ItemDescriptionBackground: RscItemText {
					idc = -1;
					x = GRID_X(pixelGridNoUIScale, 2, LIST_W + 3);
					y = GRID_Y(pixelGridNoUIScale, 2, 30 + SPACE_H);
					w = GRID_X(pixelGridNoUIScale, 2, ITEM_W);
					h = GRID_Y(pixelGridNoUIScale, 2, STORE_H - 31 - SPACE_H);
					colorBackground[] = {0.05, 0.05, 0.05, 0.3};
				};

				class ItemDescriptionGroup: HALsControlsGroup {
					idc = -1;
					x = GRID_X(pixelGridNoUIScale, 2, LIST_W + 3);
					y = GRID_Y(pixelGridNoUIScale, 2, 30 + SPACE_H);
					w = GRID_X(pixelGridNoUIScale, 2, ITEM_W);
					h = GRID_Y(pixelGridNoUIScale, 2, STORE_H - 31 - SPACE_H);

					class controls {
						class ItemText: RscItemStructuredText {
							idc = IDC_ITEM_TEXT;
							x = 0;
							y = 0;
							w = GRID_X(pixelGridNoUIScale, 2, ITEM_W);
							h = GRID_Y(pixelGridNoUIScale, 2, 21);
							shadow = 0;
						};

						class ItemDescripton: RscItemStructuredText {
							idc = IDC_ITEM_TEXT_DES;
							x = 0;
							y = 0;
							w = GRID_X(pixelGridNoUIScale, 2, ITEM_W - 1);
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
