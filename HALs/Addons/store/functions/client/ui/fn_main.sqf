/*
	Function: HALs_store_fnc_main
	Author: HallyG
	Handles the functionality of RscDisplayStore.

	Argument(s):
	0: Mode <STRING>
	1: Additional Arguments <ARRAY>

	Return Value:
	None

	Example:
	["init"] call HALs_store_fnc_main;
__________________________________________________________________*/
#include "..\..\script_component.hpp"

params [
	["_mode", "onload", [""]],
	["_this", [], [[]]]
];

private _trader = player getVariable ["HALs_store_trader_current", objNull];

switch (toLower _mode) do {
	case ("onload"): {
		params [
			["_display", displayNull, [displayNull]]
		];

		disableSerialization;
		uiNamespace setVariable ["HALs_store_display", _display];
		_display setVariable ["ctrl_group_items", _display displayCtrl IDC_GROUP_ITEMS];
		_display setVariable ["ctrl_group_trader", _display displayCtrl IDC_GROUP_TRADER];

		["oninit"] call HALs_store_fnc_main;
		["listbox", ["init", []]] call  HALs_store_fnc_main;
		["combobox", ["init", []]] call  HALs_store_fnc_main;
		["edit", ["init", []]] call  HALs_store_fnc_main;
		["text", ["init", []]] call  HALs_store_fnc_main;
		["combobox", ["update", []]] call  HALs_store_fnc_main;
		["update", ["init", []]] call  HALs_store_fnc_main;
	};

	case ("onunload"): {
		closeDialog 2;
		uiNamespace setVariable ["HALs_store_display", displayNull];
		player setVariable ["HALs_store_trader_current", objNull, true];
		HALs_store_blur ppEffectAdjust [0];
		HALs_store_blur ppEffectCommit 0.3;
	};

	case ("oninit"): {
		if (isNil "HALs_store_gui_blur") then {
			HALs_store_blur = ppEffectCreate ["DynamicBlur", 999];
			HALs_store_blur ppEffectEnable true;
		};

		HALs_store_blur ppEffectAdjust [8];
		HALs_store_blur ppEffectCommit 0.2;

		CTRL(IDC_TITLE) ctrlSetText format ["%1", getText (missionConfigFile >> "cfgHALsAddons" >> "cfgHALsStore" >> "stores" >> _trader getVariable ["HALs_store_trader_type", ""] >> "displayName")];

		{
			_x params ["_ctrl", "_tooltip"];

			_ctrl ctrlSetTooltip (localize _tooltip);
			_ctrl ctrlAddEventHandler ["CheckedChanged", {["listbox", ["update", []]] call  HALs_store_fnc_main}];
		} forEach [
			[CTRL(IDC_CHECKBOX + 1), "STR_HALS_STORE_CHECKBOX_AFFORD"],
			[CTRL(IDC_CHECKBOX + 2), "STR_HALS_STORE_CHECKBOX_STOCK"],
			[CTRL(IDC_CHECKBOX + 3), "STR_HALS_STORE_CHECKBOX_COMPATIBLE"]
		];

		CTRLT(IDC_CHECKBOX_BUY) ctrlAddEventHandler ["CheckedChanged", {["button", ["enabled", []]] call HALs_store_fnc_main}];
	};

	case ("listbox"): {
		params ["_mode", "_this"];

		switch (toLower _mode) do {
			params ["_mode", "_this"];

			case ("init"): {
				private _ctrlList = CTRL(IDC_LISTBOX);
				ctrlSetFocus _ctrlList;

				_ctrlList ctrlAddEventHandler ["LBSelChanged", {
					params ["_ctrl", "_idx"];

					_data = _ctrl lbData _idx;
					_value = _ctrl lbValue _idx;
					_amt = CTRLT(IDC_EDIT) getVariable ["amt", 1];

					_ctrl setVariable ["idx", _idx];
					_ctrl setVariable ["data", _data];
					_ctrl setVariable ["value", _value];

					["progress", ["stats", [_data]]] call  HALs_store_fnc_main;
					["text", ["update", ["item", []]]] call  HALs_store_fnc_main;
					["text", ["update", ["buy", [_value, _amt]]]] call HALs_store_fnc_main;
					["progress", ["update", [CTRLT(IDC_BUY_ITEM_COMBO) getVariable "data", _data, _amt]]] call  HALs_store_fnc_main;
					["edit", ["update", []]] call  HALs_store_fnc_main;
					["button", ["enabled", []]] call  HALs_store_fnc_main;
				}];
			};

			case ("update"): {
				private _ctrlList = CTRL(IDC_LISTBOX);
				lbClear _ctrlList;

				private _money = [player] call HALs_money_fnc_getFunds;
				private _items = _trader getVariable [format ["HALs_store_%1_items", CTRL(IDC_COMBO_CATEGORY) getVariable ["data", ""]], []];

				if (cbChecked CTRL(IDC_CHECKBOX + 3)) then {
					_filterItems = [];

					{_filterItems append (_x call HALs_store_fnc_getCompatibleItems)} forEach [primaryWeapon player, handgunWeapon player, secondaryWeapon player];

					_items = _items select {(_x select 0) in _filterItems};
				};

				{
					_x params ["_classname", "_displayName", "_picture", "_price"];

					private _stock = [_trader, _classname] call HALs_store_fnc_getTraderStock;
					_showAffordable = not (cbChecked CTRL(IDC_CHECKBOX + 1) && {_price > _money});
					_showAvaliable = not (cbChecked CTRL(IDC_CHECKBOX + 2) && {_stock < 1});

					if (_showAffordable && _showAvaliable) then {
						private _idx = _ctrlList lbAdd _displayName;
						_ctrlList lbSetData [_idx, _classname];
						_ctrlList lbSetValue [_idx, _price];
						_ctrlList lbSetPicture [_idx, _picture];
						_ctrlList lbSetTextRight [_idx, format ["%2%1", _price call HALs_fnc_numberToString, HALs_store_currencySymbol]];
						//_ctrlList lbSetTooltip [_idx, _displayName];

						if (_price > _money) then {
							//_ctrlList lbSetTooltip [_idx, format [localize "STR_HALS_STORE_LISTBOX_NOMONEY", (_price - _money) call HALs_fnc_numberToString]];
							_ctrlList lbSetColorRight [_idx, [0.91, 0, 0, 1]];
							_ctrlList lbSetSelectColorRight [_idx, [0.91, 0, 0, 1]];
						} else {
							_ctrlList lbSetColorRight [_idx, [0.666667, 1, 0.666667, 1]];
							_ctrlList lbSetSelectColorRight [_idx, [0.666667, 1, 0.666667, 1]];
						};
					};
				} count _items;

				_ctrlList lbSetCurSel ((_ctrlList getVariable ["idx", -1]) max 0);
			};
		};
	};

	case ("combobox"): {
		params ["_mode", "_this"];

		switch (toLower _mode) do {
			params ["_mode", "_this"];

			case ("init"): {
				private _ctrlCategory = CTRL(IDC_COMBO_CATEGORY);
				_ctrlCategory ctrlAddEventHandler ["LBSelChanged", {
					params ["_ctrl", "_idx"];

					_ctrl setVariable ["data", _ctrl lbData _idx];
					["listbox", ["update", []]] call  HALs_store_fnc_main
				}];
				{
					_ctrlCategory lbAdd (getText (missionConfigFile >> "cfgHALsAddons" >> "cfgHALsStore" >> "categories" >> _x >> "displayName"));
					_ctrlCategory lbSetData [_forEachIndex, _x];
				} forEach (_trader getVariable ["HALs_store_trader_categories", []]);

				if (lbSize _ctrlCategory > 0) then {_ctrlCategory lbSetCurSel 0};

				private _ctrlPurchase = CTRLT(IDC_BUY_ITEM_COMBO);
				_ctrlPurchase ctrlAddEventHandler ["LBSelChanged", {
					params ["_ctrl", "_idx"];

					_data = _ctrl lbData _idx;
					_ctrl setVariable ["idx", _idx];
					_ctrl setVariable ["data", _data];
					_ctrl setVariable ["text", _ctrl lbText _idx];

					["text", ["update", ["cargo", [_data]]]] call HALs_store_fnc_main;
					["progress", ["update", [_data, CTRL(IDC_LISTBOX) getVariable "data", CTRLT(IDC_EDIT) getVariable "amt"]]] call  HALs_store_fnc_main;
					["button", ["enabled", []]] call  HALs_store_fnc_main;
				}];
			};

			case ("update"): {
				private _ctrlPurchase = CTRLT(IDC_BUY_ITEM_COMBO);
				lbClear _ctrlPurchase;

				private _containers = [
					[
						[typeOf _trader, "Trader", "a3\ui_f\data\gui\Rsc\RscDisplayArsenal\face_ca.paa", _trader],
						[]
					] select (_trader isKindOf "Man"),
					[uniform player, "Uniform", "a3\ui_f\data\gui\Rsc\RscDisplayArsenal\uniform_ca.paa", uniformContainer player],
					[vest player, "Vest", "a3\ui_f\data\gui\Rsc\RscDisplayArsenal\vest_ca.paa", vestContainer player],
					[backpack player, "Backpack", "a3\ui_f\data\gui\Rsc\RscDisplayArsenal\backpack_ca.paa", backpackContainer player]
				];
				_containers append HALs_store_vehicles;

				{
					_x params ["_classname", "_displayName", "_picture", "_object"];

					if (count _x > 0 && !isNull _object && {_classname != ""}) then {
						_idx = _ctrlPurchase lbAdd _displayName;
						_ctrlPurchase lbSetPicture [_idx, _picture];
						_ctrlPurchase lbSetData [_idx, _object call BIS_fnc_netId];
						_ctrlPurchase lbSetTooltip [_idx, format ["Purchase to %1", _displayName]];
					};
				} count _containers;

				_ctrlPurchase lbSetCurSel ((_ctrlPurchase getVariable ["idx", -1]) max 0);
			};
		};
	};

	case ("edit"): {
		params ["_mode", "_this"];

		switch (toLower _mode) do {
			params ["_mode", "_this"];

			case ("init"): {
				private _ctrlEdit = CTRLT(IDC_EDIT);
				_ctrlEdit setVariable ["amt", 1];
				_ctrlEdit ctrlAddEventHandler ["KeyUp", {
					_ctrl = _this select 0;
					_amt = 1 max (floor parseNumber ctrlText _ctrl);

					_ctrl setVariable ["amt", _amt];

					// HERE CTRLT
					_listbox = CTRL(IDC_LISTBOX);
					["progress", ["update", [CTRLT(IDC_BUY_ITEM_COMBO) getVariable "data", _listbox getVariable "data", _amt]]] call  HALs_store_fnc_main;
					["text", ["update", ["buy", [_listbox getVariable "value", _amt]]]] call  HALs_store_fnc_main;
					["button", ["enabled", []]] call  HALs_store_fnc_main;
				}];

				["edit", ["update", []]] call  HALs_store_fnc_main;
			};

			case ("update"): {
				private _ctrlEdit = CTRLT(IDC_EDIT);
				private _idx = CTRL(IDC_LISTBOX) getVariable ["idx", -1];

				_ctrlEdit ctrlEnable (_idx > -1);
				if (_idx > -1) then {
					_ctrlEdit ctrlSetText format ["%1", _ctrlEdit getVariable "amt"];
				} else {
					_ctrlEdit ctrlSetText "";
				};
			};
		};
	};

	case ("button"): {
		params ["_mode", "_this"];

		switch (toLower _mode) do {
			params ["_mode", "_this"];

			case ("enabled"): {
				private _ctrlButton = CTRLT(IDC_BUTTON_BUY);
				private _ctrlList = CTRL(IDC_LISTBOX);
				private _idx = _ctrlList getVariable ["idx", -1];

				if (_idx isEqualTo -1) exitWith {
					_ctrlButton ctrlEnable false;
				};

				_price = _ctrlList getVariable "value";
				_amount = CTRLT(IDC_EDIT) getVariable "amt";
				_sale = (1 - (_trader getVariable ["HALs_store_trader_sale", 0])) min 1 max 0;
				_money = [player] call HALs_money_fnc_getFunds;

				_classname = _ctrlList getVariable "data";
				_stock = [_trader, _classname] call HALs_store_fnc_getTraderStock;

				//--- Check if purchase is valid
				_canBuy = !((_price * _amount * _sale > _money) || _stock < 1 || _amount > _stock || _amount < 1);

				//--- Check if the item can be equipped
				_doEquip = cbChecked CTRLT(IDC_CHECKBOX_BUY);
				_canEquipPlayer = [player, _classname] call HALs_store_fnc_canEquipItem;
				_container = (CTRLT(IDC_BUY_ITEM_COMBO) getVariable "data") call BIS_fnc_objectFromNetId;

				//--- Player can equip item and can add the rest of the items to the container
				_canEquip = _doEquip && {_canEquipPlayer && {!isNull _container && {_container canAdd [_classname, _amount - 1]}}};
				//--- Player can equip item
				_canEquipEmpty = _doEquip && {_canEquipPlayer} && {_amount isEqualTo 1};
				//--- Can add all items to container
				_canAdd = !(isNull _container) && {_container canAdd [_classname, _amount]};

				_ctrlButton ctrlEnable ((_canBuy && _canAdd || _canBuy && _canEquip) || _canBuy && _canEquipEmpty);
			};

			case ("buy"): {
				private _list = CTRL(IDC_LISTBOX);
				private _container = CTRLT(IDC_BUY_ITEM_COMBO) getVariable "data";

				[player, _list getVariable "data", _list getVariable "value", CTRLT(IDC_EDIT) getVariable "amt", _container call BIS_fnc_objectFromNetId, cbChecked CTRLT(IDC_CHECKBOX_BUY)] remoteExecCall ["HALs_store_fnc_purchase", 2];
			};

			case ("sell"): {


			};
		};
	};

	case ("text"): {
		params ["_mode", "_this"];

		switch (toLower _mode) do {
			params ["_mode", "_this"];

			case ("init"): {
				["text", ["update", ["buy", [CTRL(IDC_LISTBOX) getVariable "value", CTRLT(IDC_EDIT) getVariable "amt"]]]] call HALs_store_fnc_main;
				["text", ["update", ["cargo", []]]] call  HALs_store_fnc_main;
				["text", ["update", ["funds", []]]] call  HALs_store_fnc_main;
				["text", ["update", ["item", []]]] call  HALs_store_fnc_main;
			};

			case ("update"): {
				params ["_mode", "_this"];

				switch (toLower _mode) do {
					params ["_mode", "_this"];

					case ("buy"): {
						params [
							["_price", 0, [0]],
							["_amount", 0, [0]]
						];

						private _ctrlList = CTRL(IDC_LISTBOX);
						private _ctrlText = CTRLT(IDC_ITEM);
						private _index = _ctrlList getVariable ["idx", -1];
						if !(_amount > 0 && _index > -1) exitWith {
							_ctrlText ctrlSetStructuredText parseText "";
							_ctrlText ctrlSetTooltip "";
						};

						private _money = [player] call HALs_money_fnc_getFunds;
						private _stock = [_trader, _ctrlList getVariable "data"] call HALs_store_fnc_getTraderStock;
						private _sale = (_trader getVariable ["HALs_store_trader_sale", 0]) min 1 max 0;
						private _total = parseNumber ((_amount * _price * (1 - _sale)) toFixed 0);


						_ctrlText ctrlSetStructuredText parseText format ["<t font ='PuristaMedium' align='right' shadow='2'>%1<br/>%3%2%4</t>",
							format [
								"<t align='left' shadow='2' color='#%3'>x%2</t><t align='right' color='#aaffaa' shadow='1'>%4%1</t>", //<t color='#aaffaa'>%2 %1</t>
								_price call HALs_fnc_numberToString, _amount, ['b2ec00', 'ea0000'] select (_amount > _stock), HALs_store_currencySymbol
							],
							"", [format ["<t size='1' shadow='1'>- %1%2</t><br/>", _sale * 100, "%"], ""] select (_sale in [0]),
							format ["<t size='1.1' color='#%2'>- %3%1</t>", _total call HALs_fnc_numberToString, ['b2ec00', 'ea0000'] select (_total > _money), HALs_store_currencySymbol]
						];

						//Update positions of controls
						_ctrlText ctrlSetPositionH ctrlTextHeight _ctrlText;
						_ctrlText ctrlSetTooltip format ["Total cost: %1%2", HALs_store_currencySymbol, _total call HALs_fnc_numberToString];
						_ctrlText ctrlCommit 0;

						private _ctrlEdit = CTRLT(IDC_EDIT);
						private _pos = ctrlPosition _ctrlText;
						private _y = (_pos select 1) + (_pos select 3) + 3 * pixelH;
						_ctrlEdit ctrlSetPositionY _y;
						_ctrlEdit ctrlCommit 0;

						private _ctrlButton = CTRLT(IDC_BUTTON_BUY);
						private _ctrlCheckbox = CTRLT(IDC_CHECKBOX_BUY);
						_y = _y + ((ctrlPosition _ctrlEdit) select 3) + 3 * pixelH;
						_ctrlButton ctrlSetPositionY _y;
						_ctrlCheckbox ctrlSetPositionY _y;
						_ctrlButton ctrlCommit 0;
						_ctrlCheckbox ctrlCommit 0;

						private _ctrlButtonSell = CTRLT(IDC_BUTTON_SELL);
						_y = _y + ((ctrlPosition _ctrlEdit) select 3) + 3 * pixelH;
						_ctrlButtonSell ctrlSetPositionY _y;
						_ctrlButtonSell ctrlCommit 0;
					};

					case ("cargo"): {
						private _classname = typeOf ((CTRLT(IDC_BUY_ITEM_COMBO) getVariable "data") call BIS_fnc_objectFromNetId);
						if (_classname find "Supply" isEqualTo 0) then {
							_text = CTRLT(IDC_BUY_ITEM_COMBO) getVariable ["text", ""];
							_classname = [uniform player, vest player, backpack player] select (["Uniform", "Vest", "Backpack"] find _text);
						};

						private _type = (_classname call BIS_fnc_itemType) select 0;
						private _cargo = ["editorPreview", "picture"] select (_type == "equipment");
						if (isClass (configFile >> "cfgVehicles" >> _classname)) then {
							CTRLT(IDC_BUY_PICTURE) ctrlSetText (getText (configFile >> "cfgVehicles" >> _classname >> _cargo));
						} else {
							CTRLT(IDC_BUY_PICTURE) ctrlSetText (getText (configFile >> "cfgWeapons" >> _classname >> _cargo));
						};
					};

					case ("funds"): {
						private _money = ([player] call HALs_money_fnc_getFunds) toFixed 0;
						CTRL(IDC_FUNDS) ctrlSetStructuredText parseText format["<t color='#aaffaa'>%2 %1</t>", (parseNumber _money) call HALs_fnc_numberToString, HALs_store_currencySymbol];
					};

					case ("item"): {
						private _idx = CTRL(IDC_LISTBOX) getVariable ["idx", -1];
						private _pictureCtrl = CTRL(IDC_ITEM_PICTURE);
						private _titleCtrl = CTRL(IDC_ITEM_TEXT);
						private _textCtrl = CTRL(IDC_ITEM_TEXT_DES);

						if (_idx isEqualTo -1) exitWith {
							_pictureCtrl ctrlSetText "";
							_titleCtrl ctrlSetStructuredText parseText "";
							_textCtrl ctrlSetStructuredText parseText "";
						};

						private _ctrlListbox = CTRL(IDC_LISTBOX);
						private _classname = _ctrlListbox lbData _idx;
						private _stock = [_trader, _classname] call HALs_store_fnc_getTraderStock;
						private _config = _classname call HALs_fnc_getConfigClass;

						private _description = [
							getText (missionConfigFile >> "cfgHALsAddons" >> "cfgHALsStore" >> "categories" >>  CTRL(IDC_COMBO_CATEGORY) getVariable "data" >> _classname >> "description"),
							[_config >> "Library" >> "libTextDesc", ""] call HALs_fnc_getConfigValue,
							[_config >> "descriptionShort", ""] call HALs_fnc_getConfigValue
						] select {_x != ""} select 0;

						_pictureCtrl ctrlSetText (_ctrlListbox lbPicture _idx);
						_textCtrl ctrlSetStructuredText parseText format ["%1", _description];
						_titleCtrl ctrlSetStructuredText parseText format [
							"<t size='1.3' shadow='2' font ='PuristaMedium'>%1</t><br/><t shadow='2' font ='PuristaMedium'>%3</t>:  <t color='#aaffaa'>%5 %2</t><br/>%4",
							_ctrlListbox lbText _idx, (_ctrlListbox lbValue _idx) call HALs_fnc_numberToString, toUpper localize "STR_HALS_STORE_TEXT_PRICE",
							[
								format ["<t shadow='2' font ='PuristaMedium' color='#DD2626'>%1</t>", localize "STR_HALS_STORE_TEXT_NOSTOCK"],
								format ["<t shadow='2' font ='PuristaMedium' color='#A0DF3B'>%1</t>:  %2", localize "STR_HALS_STORE_TEXT_INSTOCK", _stock call HALs_fnc_numberToString]
							] select (_stock > 0), HALs_store_currencySymbol
						];

						_titleCtrl ctrlSetPositionH ctrlTextHeight _titleCtrl;
						_titleCtrl ctrlCommit 0;

						private _y = ((ctrlPosition _titleCtrl) select 1) + ((ctrlPosition _titleCtrl) select 3) + pixelH * 4;
						{
							_x params ["_ctrlBar", "_ctrlBarText"];

							_ctrlBar ctrlSetPositionY _y;
							_ctrlBarText ctrlSetPositionY _y;
							_ctrlBar ctrlCommit 0;
							_ctrlBarText ctrlCommit 0;

							_y = _y + ((ctrlPosition _ctrlBar) select 3) + pixelH * 3;
						} count (STAT_BARS select {ctrlFade (_x select 0) < 1});

						_textCtrl ctrlSetPositionY _y;
						_textCtrl ctrlSetPositionH (ctrlTextHeight _textCtrl);
						_textCtrl ctrlCommit 0;
					};
				};
			};
		};
	};

	case ("update"): {
		params ["_mode", "_this"];

		switch (toLower _mode) do {
			params ["_mode", "_this"];

			case ("init"): {
				HALs_store_oldMoney = [player] call HALs_money_fnc_getFunds;
				HALs_store_oldPlayerContainers = [uniform player, vest player, backpack player];
				HALs_store_updated = false;
				HALs_store_nextUpdateTick = diag_tickTime;

				addMissionEventHandler ["EachFrame", {
					if (isNull (uiNamespace getVariable ["HALs_store_display", displayNull])) exitWith {
						removeMissionEventHandler ["EachFrame", _thisEventHandler];
						HALs_store_updated = nil;
						HALs_store_nextUpdateTick = nil;
						HALs_store_oldPlayerContainers = nil;
						HALs_store_oldMoney = nil;
					};

					if (HALs_store_updated) then {
						["text", ["update", ["funds", []]]] call  HALs_store_fnc_main;
						["listbox", ["update", []]] call  HALs_store_fnc_main;
						["combobox", ["update", []]] call  HALs_store_fnc_main;

						HALs_store_oldMoney = [player] call HALs_money_fnc_getFunds;
						HALs_store_oldPlayerContainers = [uniform player, vest player, backpack player];
						HALs_store_updated = false;
					};

					if (diag_tickTime > HALs_store_nextUpdateTick) then {
						_trader = player getVariable ["HALs_store_trader_current", objNull];
						_container = (CTRLT(IDC_BUY_ITEM_COMBO) getVariable "data") call BIS_fnc_objectFromNetId;
						_playerContainers = [uniform player, vest player, backpack player];
						_money = [player] call HALs_money_fnc_getFunds;

						if (_money != HALs_store_oldMoney) then {
							HALs_store_oldMoney = _money;
							HALs_store_updated = true;
						};

						if !(_playerContainers isEqualTo HALs_store_oldPlayerContainers) then {
							HALs_store_oldPlayerContainers = _playerContainers;
							HALs_store_updated = true;
						};

						HALs_store_nextUpdateTick = diag_tickTime + 0.1;
					};
				}];
			};
		};
	};

	case ("progress"): {
		params ["_mode", "_this"];

		switch (toLower _mode) do {
			params ["_mode", "_this"];

			case ("stats"): {
				params [
					["_classname", "", [""]]
				];

				private _stats = [_classname call HALs_fnc_getConfigClass] call HALs_store_fnc_getItemStats;
				{
					_x params ["_ctrlBar", "_ctrlBarText"];

					_progress = 0;
					_fade = 1;
					_text = "";
					if (count (_stats select _forEachIndex) > 0) then {
						_progress = _stats select _forEachIndex select 0;
						_text = _stats select _forEachIndex select 1;
						_fade = 0;
					};

					_ctrlBar progressSetPosition _progress;
					_ctrlBarText ctrlSetText _text;
					_ctrlBar ctrlSetFade _fade;
					_ctrlBarText ctrlSetFade _fade;
					_ctrlBar ctrlCommit 0;
					_ctrlBarText ctrlCommit 0;
				} forEach STAT_BARS;
			};

			case ("update"): {
				params [
					["_container", "", [""]],
					["_classname", "", [""]],
					["_amount", 1, [1]]
				];

				private _bar = CTRLT(IDC_PROGRESS_LOAD);
				private _barNew = CTRLT(IDC_PROGRESS_NEWLOAD);

				_container = _container call BIS_fnc_objectFromNetId;
				if (_container isEqualTo objNull) exitWith {
					_bar progressSetPosition 0;
					_barNew progressSetPosition 0;
				};

				private _currentLoad = [_container] call HALs_store_fnc_getCargoMass;
				private _maxLoad = 1 max getNumber (configFile >> "CfgVehicles" >> typeOf _container >> "maximumLoad");
				if (_classname isEqualTo "") exitWith {
					_bar progressSetPosition (_currentLoad / _maxLoad);
					_barNew progressSetPosition 0;
				};

				private _load = _classname call HALs_store_fnc_getItemMass;

				// Check if it's a backpack with items
				private _type = [_classname] call HALs_store_fnc_getItemType;
				if (_type isEqualTo 3) then {
					_arrayCargo = [];

					{
						_arrayCargo append (("true" configClasses _x) apply {[(configName _x) select [4], getNumber (_x >> "count")]});;
					} forEach ("true" configClasses (configFile >> "CfgVehicles" >> _classname));

					_arrayCargo apply {
						_load = _load + ((_x select 0) call HALs_store_fnc_getItemMass) * (_x select 1);
					};
				};

				private _progress = linearConversion [0, _maxLoad, _currentLoad + (_load * _amount), 0, 1, true];
				private _canAdd = _container canAdd [_classname, _amount];
				private _colour = [0, 0.9, 0, 0.6];

				if (not _canAdd || _progress > 1) then {
					_progress = 1;
					_colour = [0.9, 0, 0, 0.6];
				};

				_bar progressSetPosition (_currentLoad / _maxLoad);
				_barNew progressSetPosition _progress;
				_barNew ctrlSetTextColor _colour;
			};
		};
	};
};
