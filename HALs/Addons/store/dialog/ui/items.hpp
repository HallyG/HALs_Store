#define CURRENT_Y GRID_Y(0)

class ComboCategories: RscItemComboBox {
	idc = IDC_COMBO_CATEGORY;
	x = GRID_X(SPACE_W2);
	y = CURRENT_Y;
	w = GRID_X(COMBO_W);
	h = GRID_Y(BAR_H);
	sizeEx = FONT(1);
	colorBackground[] = {0.1, 0.1, 0.1, 1};
};

class ItemListboxSortButton: RscItemButtonSort {
	idc = IDC_LISTBOX_SORT;
	x = GRID_X(SPACE_W2 + COMBO_W + SPACE_W);
	y = CURRENT_Y;
	w = GRID_X(BAR_W);
	h = GRID_Y(BAR_H);
	action = "['button', ['sort', []]] call HALs_store_fnc_main;";
	sizeEx = FONT(1);
	color[] = {1, 1, 1, 0.7};
	colorActive[] = {1, 1, 1, 1};
	colorBackground[] = {1, 1, 1, 1};
};

class ItemCheckbox1: RscItemCheckboxGreen {
	idc = IDC_CHECKBOX + 1;
	x = GRID_X(SPACE_W2 + COMBO_W + SPACE_W*2 + BAR_W);
	y = CURRENT_Y;
	w = GRID_X(BAR_W);
	h = GRID_Y(BAR_H);
};

class ItemCheckbox2: RscItemCheckboxGreen {
	idc = IDC_CHECKBOX + 2;
	x = GRID_X(SPACE_W2 + COMBO_W + SPACE_W*3 + BAR_W*2);
	y = CURRENT_Y;
	w = GRID_X(BAR_W);
	h = GRID_Y(BAR_H);
};

class ItemCheckbox3: RscItemCheckboxGreen {
	idc = IDC_CHECKBOX + 3;
	x = GRID_X(SPACE_W2 + COMBO_W + SPACE_W*4 + BAR_W*3);
	y = CURRENT_Y;
	w = GRID_X(BAR_W);
	h = GRID_Y(BAR_H);
	onCheckedChanged = "['button', ['change', []]] call HALs_store_fnc_main;";
};

class ItemListbox: RscItemListBox {
	idc = IDC_LISTBOX;
	x = GRID_X(SPACE_W2);
	y = GRID_Y(LIST_Y);
	w = GRID_X(LIST_W); 
	h = GRID_Y(LIST_H);
	sizeEx = FONT(0.8);
	font = "PuristaMedium";
	colorTextRight[] = {0.666667, 1, 0.666667, 1};
	colorSelectRight[] = {0.666667, 1, 0.666667, 1};
	colorSelect[] = {1, 0.7, 0.09, 1};
	colorSelectBackground[] = {1, 1, 1, 0.2};
	colorSelectBackground2[] = {1, 1, 1, 0.2};
};