#include "defines.hpp"
#include "idcs.hpp"
#include "sizes.hpp"

class RscDisplayStore {
	idd = IDD_DISPLAY_STORE;
	onLoad = "['onLoad', _this] call HALs_store_fnc_main";
	onUnload = "['onUnload', _this] call HALs_store_fnc_main";
	
	class controlsBackground { 
		class TitleBackground: RscItemText {
			x = DIALOG_X;
			y = DIALOG_Y;
			w = GRID_X(STORE_W);
			h = GRID_Y(BAR_H);
			colorBackground[] = {0.1, 0.1, 0.1, 1};
		};

		class StoreBackground: RscItemText {
			x = DIALOG_X;
			y = DIALOG_Y + GRID_Y(BAR_H + SPACE_H2);
			w = GRID_X(STORE_W);
			h = GRID_Y(STORE_H - (BAR_H + SPACE_H2));
			colorBackground[] = {0.05, 0.05, 0.05, 0.7};
		};
	};

	class controls {
		class ContainerGroup: RscItemCtrlGroupNoScrollbars {
			idc = IDC_GROUP_TRADER;
			x = TRADER_X;
			y = TRADER_Y;
			w = GRID_X(TRADER_W);
			h = GRID_Y(TRADER_H);
			
			class controls {
				#include "ui\container.hpp"
			};
		};
			
		class HALs_store_dialog: RscItemCtrlGroupNoScrollbars {
			idc = IDC_GROUP_ITEMS;
			x = DIALOG_X;
			y = DIALOG_Y;
			w = GRID_X(BUFFER_W + LIST_W);
			h = GRID_Y(STORE_H);

			class controls {
				class TitleFunds: RscItemStructuredText {
					idc = IDC_FUNDS;
					
					x = GRID_X(FUNDS_X);
					y = 0;
					w = GRID_X(FUNDS_W);
					h = GRID_Y(FUNDS_H);

					class Attributes {
						align = "right";
						font = "PuristaMedium";
						valign = "bottom";
						shadow='0';
					};
				};

				class TitleText: RscItemText {
					idc = IDC_TITLE;
					
					x = 0;
					y = 0;
					w = GRID_X(STORE_W);
					h = GRID_Y(BAR_H);
					
					colorText[] = {0.95, 0.95, 0.95, 1};
					colorShadow[] = {0, 0, 0, 0.5};
					sizeEx = FONT(1);
					font = "RobotoCondensed";
					style = 0;
					shadow = 1;
				};

				class CloseButton: RscItemButtonClose {
					idc = -1;
					
					x = GRID_X(STORE_W - BAR_W);
					y = 0;
					w = GRID_X(BAR_W);
					h = GRID_Y(BAR_H);
					
					action = "['onUnload'] call HALs_store_fnc_main;";
					colorText[] = {1, 1, 1, 0.7};
					color[] = {1, 1, 1, 0.7};
				};

				class ComboCategories: RscItemComboBox {
					idc = IDC_COMBO_CATEGORY;
					x = GRID_X(BUFFER_W);
					y = GRID_Y(BAR_H + SPACE_H + SPACE_H);
					w = GRID_X(COMBO_W);
					h = GRID_Y(BAR_H);
					sizeEx = FONT(1);
					colorBackground[] = {0.1,0.1,0.1,1};
				};

				class ItemListboxSortButton: RscItemButtonSort {
					idc = IDC_LISTBOX_SORT;
					x = GRID_X(BUFFER_W + COMBO_W + SPACE_W);
					y = GRID_Y(BAR_H + SPACE_H + SPACE_H);
					w = GRID_X(BAR_W);
					h = GRID_Y(BAR_H);
					action = "['button', ['sort', []]] call HALs_store_fnc_main;";
					sizeEx = FONT(1);
					color[] = {1, 1, 1, 0.7};
					colorActive[] = {1, 1, 1, 1};
				};

				class ItemCheckbox1: RscItemCheckboxGreen {
					idc = IDC_CHECKBOX + 1;
					x = GRID_X(BUFFER_W + COMBO_W + SPACE_W*2 + BAR_W);
					y = GRID_Y(BAR_H + SPACE_H + SPACE_H);
					w = GRID_X(BAR_W);
					h = GRID_Y(BAR_H);
				};

				class ItemCheckbox2: RscItemCheckboxGreen {
					idc = IDC_CHECKBOX + 2;
					x = GRID_X(BUFFER_W + COMBO_W + SPACE_W*3 + BAR_W*2);
					y = GRID_Y(BAR_H + SPACE_H + SPACE_H);
					w = GRID_X(BAR_W);
					h = GRID_Y(BAR_H);
				};

				class ItemCheckbox3: RscItemCheckboxGreen {
					idc = IDC_CHECKBOX + 3;
					x = GRID_X(BUFFER_W + COMBO_W + SPACE_W*4 + BAR_W*3);
					y = GRID_Y(BAR_H + SPACE_H + SPACE_H);
					w = GRID_X(BAR_W);
					h = GRID_Y(BAR_H);
					onCheckedChanged = "['button', ['change', []]] call HALs_store_fnc_main;";
				};

				class ItemListbox: RscItemListBox {
					idc = IDC_LISTBOX;
					x = GRID_X(BUFFER_W);
					y = GRID_Y(BAR_H*2 + SPACE_H*2 + SPACE_H);
					w = GRID_X(LIST_W); 
					h = GRID_Y(STORE_H - (BAR_H*2 + SPACE_H*3 + BUFFER_H));
					sizeEx = FONT(0.8);
					font = "PuristaMedium";
					colorTextRight[] = {0.666667, 1, 0.666667, 1};
					colorSelectRight[] = {0.666667, 1, 0.666667, 1};
					colorSelect[] = {1, 0.7, 0.09, 1};
					colorSelectBackground[] = {1, 1, 1, 0.2};
					colorSelectBackground2[] = {1, 1, 1, 0.2};
				};
			};
		};
	
		class SelectedItemGroup: RscItemCtrlGroupNoScrollbars {
			idc = IDC_GROUP_SELECTED;
			
			x = DIALOG_X + GRID_X(ITEM_X);
			y = DIALOG_Y + GRID_Y(ITEM_Y);
			w = GRID_X(ITEM_W);
			h = GRID_Y(STORE_H);

			class controls {
				#include "ui\itemStats.hpp"
			};
		};
	};
};
