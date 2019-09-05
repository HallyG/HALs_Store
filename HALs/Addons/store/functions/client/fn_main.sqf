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
#include "..\script_component.hpp"

params [
	["_mode", "onload", [""]],
	["_this", [], [[]]]
];

if (!hasInterface) exitWith {};

private _trader = player getVariable ["HALs_store_trader_current", objNull];

switch (toLower _mode) do {
	case ("onload"): {
		params [
			["_display", controlNull, [controlNull]]
		];

		disableSerialization;

		uiNamespace setVariable ["HALs_store_display", _display];
		uiNamespace setVariable ["HALs_store_buyIndex", -1];

		["oninit"] call HALs_store_fnc_main;
		["listbox", 	["init", []]] call  HALs_store_fnc_main;
		["combobox", 	["init", []]] call  HALs_store_fnc_main;
		["edit", 		["init", []]] call  HALs_store_fnc_main;
		["text", 		["init", []]] call  HALs_store_fnc_main;
		["update", 		["init", []]] call  HALs_store_fnc_main;
	};

	case ("onunload"): {
		closeDialog 2;

		HALs_store_blur ppEffectAdjust [0];
		HALs_store_blur ppEffectCommit 0.3;

		player setVariable ["HALs_store_trader_current", objNull, true];

		uiNamespace setVariable ["HALs_store_display", controlNull];
		uiNamespace setVariable ["HALs_store_buyIndex", -1];
	};

	case ("oninit"): {
		if (isNil "HALs_store_gui_blur") then {
			HALs_store_blur = ppEffectCreate ["DynamicBlur", 999];
			HALs_store_blur ppEffectEnable true;
		};

		HALs_store_blur ppEffectAdjust [8];
		HALs_store_blur ppEffectCommit 0.2;

		UICTRL(IDC_TITLE) ctrlSetText format ["%1", toUpper getText (missionConfigFile >> "cfgHALsAddons" >> "cfgHALsStore" >> "stores" >> _trader getVariable ["HALs_store_trader_type", ""] >> "displayName")];

		{
			_x params ["_ctrl", "_tooltip"];

			_ctrl ctrlSetTooltip (localize _tooltip);
			_ctrl ctrlAddEventHandler ["CheckedChanged", {["listbox", ["update", []]] call  HALs_store_fnc_main}];
		} forEach [
			[UICTRL(IDC_CHECKBOX1), "STR_HALS_STORE_CHECKBOX_AFFORD"],
			[UICTRL(IDC_CHECKBOX2), "STR_HALS_STORE_CHECKBOX_STOCK"],
			[UICTRL(IDC_CHECKBOX3), "STR_HALS_STORE_CHECKBOX_COMPATIBLE"]
		];

		UICTRL(IDC_CHECKBOX_BUY) ctrlAddEventHandler ["CheckedChanged", {["BUTTON", ["ENABLED", []]] call HALs_store_fnc_main}];
	};

	case ("listbox"): {
		params ["_mode", "_this"];

		switch (toLower _mode) do {
			params ["_mode", "_this"];

			case ("init"): {
				private _ctrlList = UICTRL(IDC_LISTBOX);
				ctrlSetFocus _ctrlList;

				_ctrlList ctrlAddEventHandler ["LBSelChanged", {
					params ["_ctrl", "_idx"];

					_data = _ctrl lbData _idx;
					_value = _ctrl lbValue _idx;
					_amt = UICTRL(IDC_EDIT) getVariable ["amt", 1];

					_ctrl setVariable ["idx", _idx];
					_ctrl setVariable ["data", _data];
					_ctrl setVariable ["value", _value];

					["PROGRESS", 	["STATS", 	[_data]]] call  HALs_store_fnc_main;
					["TEXT", 		["UPDATE", 	["ITEM", []]]] call  HALs_store_fnc_main;
					["TEXT", 		["UPDATE", 	["BUY", [_value, _amt]]]] call HALs_store_fnc_main;
					["PROGRESS", 	["UPDATE", 	[UIDATA(IDC_BUY_ITEM_COMBO), _data, _amt]]] call  HALs_store_fnc_main;
					["EDIT", 		["UPDATE", 	[]]] call  HALs_store_fnc_main;
					["BUTTON", 		["ENABLED", []]] call  HALs_store_fnc_main;
				}];
			};

			case ("update"): {
				private _ctrlList = UICTRL(IDC_LISTBOX);
				lbClear _ctrlList;

				private _money = [player] call HALs_money_fnc_getFunds;
				private _items = _trader getVariable [format ["HALs_store_%1_items", UIDATA(IDC_COMBO_CATEGORY)], []];

				if (cbChecked UICTRL(IDC_CHECKBOX3)) then {
					_filterItems = [];

					{_filterItems append (_x call HALs_store_fnc_getCompatibleItems)} forEach [primaryWeapon player, handgunWeapon player, secondaryWeapon player];

					_items = _items select {(_x select 0) in _filterItems};
				};

				{
					_x params ["_classname", "_displayName", "_picture", "_price"];

					private _stock = [_trader, _classname] call HALs_store_fnc_getTraderStock;
					_showAffordable = not (cbChecked UICTRL(IDC_CHECKBOX1) && {_price > _money});
					_showAvaliable = not (cbChecked UICTRL(IDC_CHECKBOX2) && {_stock < 1});

					if (_showAffordable && _showAvaliable) then {
						private _idx = _ctrlList lbAdd _displayName;
						_ctrlList lbSetData [_idx, _classname];
						_ctrlList lbSetValue [_idx, _price];
						_ctrlList lbSetPicture [_idx, _picture];
						_ctrlList lbSetTextRight [_idx, format ["%2%1", _price call HALs_fnc_numberToString, HALs_store_currencySymbol]];
						_ctrlList lbSetTooltip [_idx, _displayName];

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
				private _ctrlCategory = UICTRL(IDC_COMBO_CATEGORY);
				_ctrlCategory ctrlAddEventHandler ["LBSelChanged", {["listbox", ["update", []]] call  HALs_store_fnc_main}];
				{
					_ctrlCategory lbAdd (getText (missionConfigFile >> "cfgHALsAddons" >> "cfgHALsStore" >> "categories" >> _x >> "displayName"));
					_ctrlCategory lbSetData [_forEachIndex, _x];
				} forEach (_trader getVariable ["HALs_store_trader_categories", []]);

				if (lbSize _ctrlCategory > 0) then {_ctrlCategory lbSetCurSel 0};

				private _ctrlPurchase = UICTRL(IDC_BUY_ITEM_COMBO);
				_ctrlPurchase ctrlAddEventHandler ["LBSelChanged", {
					params ["_ctrl", "_idx"];

					_ctrl setVariable ["idx", _idx];

					uiNamespace setVariable ["HALs_store_buyIndex", _idx];
					["text", ["update", ["cargo", [_ctrl lbData _idx]]]] call HALs_store_fnc_main;
				}];
			};

			case ("update"): {
				private _ctrlPurchase = UICTRL(IDC_BUY_ITEM_COMBO);
				lbClear _ctrlPurchase;

				{
					_x params [
						["_classname", ""],
						["_displayName", ""],
						["_picture", ""],
						["_object", objNull]
					];

					if (!isNull _object && {_classname != ""}) then {
						_index = _ctrlPurchase lbAdd _displayName;
						_ctrlPurchase lbSetPicture [_index, _picture];
						_ctrlPurchase lbSetData [_index, _object call BIS_fnc_netId];
						_ctrlPurchase lbSetTooltip [_index, format ["Purchase to %1%2", _displayName, ""/*toString [10,13]*/]];
					};
				} forEach ([
					[[typeOf _trader, "Trader", "a3\ui_f\data\gui\Rsc\RscDisplayArsenal\face_ca.paa", _trader], []] select (_trader isKindOf "Man"),
					[uniform player, "Uniform", "a3\ui_f\data\gui\Rsc\RscDisplayArsenal\uniform_ca.paa", uniformContainer player],
					[vest player, "Vest", "a3\ui_f\data\gui\Rsc\RscDisplayArsenal\vest_ca.paa", vestContainer player],
					[backpack player, "Backpack", "a3\ui_f\data\gui\Rsc\RscDisplayArsenal\backpack_ca.paa", backpackContainer player]
				] + HALs_store_vehicles);

				_ctrlPurchase lbSetCurSel ((_ctrlPurchase getVariable ["idx", -1]) max 0);
			};
		};
	};

	case ("edit"): {
		params ["_mode", "_this"];

		switch (toLower _mode) do {
			params ["_mode", "_this"];

			case ("init"): {
				private _ctrlEdit = UICTRL(IDC_EDIT);
				_ctrlEdit ctrlAddEventHandler ["KeyUp", {
					_ctrl = _this select 0;
					_amt = 1 max (floor parseNumber ctrlText _ctrl);

					_ctrl setVariable ["amt", _amt];

					["progress", ["update", [UIDATA(IDC_BUY_ITEM_COMBO), UIDATA(IDC_LISTBOX), _amt]]] call  HALs_store_fnc_main;
					["text", ["update", ["buy", [UIVALUE(IDC_LISTBOX), _amt]]]] call  HALs_store_fnc_main;
					["button", ["enabled", []]] call  HALs_store_fnc_main;
				}];

				["edit", ["update", []]] call  HALs_store_fnc_main;
			};

			case ("update"): {
				private _ctrlEdit = UICTRL(IDC_EDIT);
				private _idx = UICTRL(IDC_LISTBOX) getVariable ["idx", -1];

				_ctrlEdit ctrlEnable (_idx > -1);
				if (_idx > -1) then {
					_ctrlEdit ctrlSetText format ["%1", _ctrlEdit getVariable ["amt", 1]];
				} else {
					_ctrlEdit ctrlSetText "";
				};
			};
		};
	};

	case ("button"): {
		params ["_mode", "_this"];

		switch (toUpper _mode) do {
			params ["_mode", "_this"];

			case ("ENABLED"): {
				_ctrlButton = UICTRL(IDC_BUTTON_BUY);
				_idx = UICTRL(IDC_LISTBOX) getVariable ["idx", -1];

				if (_idx isEqualTo -1) exitWith {
					_ctrlButton ctrlEnable false;
				};

				_price = UIVALUE(IDC_LISTBOX);
				_amount = UICTRL(IDC_EDIT) getVariable ["amt", 1];
				_sale = (1 - (_trader getVariable ["HALs_store_trader_sale", 0])) min 1 max 0;
				_money = [player] call HALs_money_fnc_getFunds;

				_classname = UIDATA(IDC_LISTBOX);
				_stock = [_trader, _classname] call HALs_store_fnc_getTraderStock;

				//--- Check if purchase is valid
				_canBuy = !((_price * _amount * _sale > _money) || _stock < 1 || _amount > _stock || _amount < 1);

				//--- Check if the item can be equipped
				_doEquip = cbChecked UICTRL(IDC_CHECKBOX_BUY);
				_canEquipPlayer = [player, _classname] call HALs_store_fnc_canEquipItem;
				_container = (UIDATA(IDC_BUY_ITEM_COMBO)) call BIS_fnc_objectFromNetId;

				//--- Player can equip item and can add the rest of the items to the container
				_canEquip = _doEquip && {_canEquipPlayer && {!isNull _container && {_container canAdd [_classname, _amount - 1]}}};
				//--- Player can equip item
				_canEquipEmpty = _doEquip && {_canEquipPlayer} && {_amount isEqualTo 1};
				//--- Can add all items to container
				_canAdd = !(isNull _container) && {_container canAdd [_classname, _amount]};

				_ctrlButton ctrlEnable ((_canBuy && _canAdd || _canBuy && _canEquip) || _canBuy && _canEquipEmpty);
			};
			case ("BUY"): {
				_amount = UICTRL(IDC_EDIT) getVariable ["amt", 1];
				_price = UIVALUE(IDC_LISTBOX);
				_classname = UIDATA(IDC_LISTBOX);
				_container = (UIDATA(IDC_BUY_ITEM_COMBO)) call BIS_fnc_objectFromNetId;

				[player, _classname, _price, _amount, _container, cbChecked UICTRL(IDC_CHECKBOX_BUY)] remoteExecCall ["HALs_store_fnc_purchase", 2];
			};
		};
	};

	case ("text"): {
		params ["_mode", "_this"];

		switch (toLower _mode) do {
			params ["_mode", "_this"];

			case ("init"): {
				["text", ["update", ["buy", [UICTRL(IDC_LISTBOX) lbValue CTRLSEL(IDC_LISTBOX), UICTRL(IDC_EDIT) getVariable ["amt", 1]]]]] call HALs_store_fnc_main;
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

						private _index = UICTRL(IDC_LISTBOX) getVariable ["idx", -1];
						if !(_amount > 0 && _index > -1) exitWith {
							UICTRL(IDC_ITEM) ctrlSetStructuredText parseText "";
						};

						private _money = [player] call HALs_money_fnc_getFunds;
						private _stock = [_trader, UIDATA(IDC_LISTBOX)] call HALs_store_fnc_getTraderStock;
						private _sale = (_trader getVariable ["HALs_store_trader_sale", 0]) min 1 max 0;
						private _total = _amount * _price * (1 - _sale);

						private _ctrlText = UICTRL(IDC_ITEM);
						_ctrlText ctrlSetStructuredText parseText format ["<t font ='PuristaMedium' align='right' shadow='0'>%1%3%2%4</t>",
							format ["<t size='1'>%4%1</t> <t size ='1' shadow='1' color='#%3'>x%2</t><br/>", _price call HALs_fnc_numberToString, _amount, ['b2ec00', 'ea0000'] select (_amount > _stock), HALs_store_currencySymbol], "", [format ["<t size='0.95'>- %1%2</t><br/>", _sale * 100, "%"], ""] select (_sale in [0]),
							format ["<t size='1.1' color='#%2'>- %3%1</t>", _total call HALs_fnc_numberToString, ['b2ec00', 'ea0000'] select (_total > _money), HALs_store_currencySymbol]
						];

						//Update positions of controls
						_ctrlText ctrlSetPositionH ctrlTextHeight _ctrlText;
						_ctrlText ctrlCommit 0;

						private _ctrlEdit = UICTRL(IDC_EDIT);
						private _pos = ctrlPosition _ctrlText;
						private _y = (_pos select 1) + (_pos select 3) + 4 * pixelH;
						_ctrlEdit ctrlSetPositionY _y;
						_ctrlEdit ctrlCommit 0;

						private _ctrlButton = UICTRL(IDC_BUTTON_BUY);
						private _ctrlCheckbox = UICTRL(IDC_CHECKBOX_BUY);
						_y = _y + ctrlTextHeight _ctrlEdit + 4 * pixelH;
						_ctrlButton ctrlSetPositionY _y;
						_ctrlCheckbox ctrlSetPositionY _y;
						_ctrlButton ctrlCommit 0;
						_ctrlCheckbox ctrlCommit 0;
					};

					case ("cargo"): {
						private _classname = typeOf (UIDATA(IDC_BUY_ITEM_COMBO) call BIS_fnc_objectFromNetId);
						if (_classname find "Supply" isEqualTo 0) then {
							_classname = [uniform player, vest player, backpack player] select (["Uniform", "Vest", "Backpack"] find (UITEXT(IDC_BUY_ITEM_COMBO)));
						};

						private _type = (_classname call BIS_fnc_itemType) select 0;
						private _cargo = ["editorPreview", "picture"] select (_type == "equipment");
						if (isClass (configFile >> "cfgVehicles" >> _classname)) then {
							UICTRL(IDC_BUY_PICTURE) ctrlSetText (getText (configFile >> "cfgVehicles" >> _classname >> _cargo));
						} else {
							UICTRL(IDC_BUY_PICTURE) ctrlSetText (getText (configFile >> "cfgWeapons" >> _classname >> _cargo));
						};
					};

					case ("funds"): {
						UICTRL(IDC_FUNDS) ctrlSetText format ["%2%1", ([player] call HALs_money_fnc_getFunds) call HALs_fnc_numberToString, HALs_store_currencySymbol];
					};

					case ("item"): {
						private _idx = UICTRL(IDC_LISTBOX) getVariable ["idx", -1];
						private _pictureCtrl = UICTRL(IDC_ITEM_PICTURE);
						private _titleCtrl = UICGCTRL(IDC_ITEM_TEXT);
						private _textCtrl = UICGCTRL(IDC_ITEM_TEXT_DES);

						if (_idx isEqualTo -1) exitWith {
							_pictureCtrl ctrlSetText "";
							_titleCtrl ctrlSetStructuredText parseText "";
							_textCtrl ctrlSetStructuredText parseText "";
						};

						private _ctrlListbox = UICTRL(IDC_LISTBOX);
						private _classname = _ctrlListbox lbData _idx;
						private _stock = [_trader, _classname] call HALs_store_fnc_getTraderStock;
						private _config = _classname call HALs_fnc_getConfigClass;

						private _description = [
							getText (missionConfigFile >> "cfgHALsAddons" >> "cfgHALsStore" >> "categories" >> UIDATA(IDC_COMBO_CATEGORY) >> _classname >> "description"),
							[_config >> "Library" >> "libTextDesc", ""] call HALs_fnc_getConfigValue,
							[_config >> "descriptionShort", ""] call HALs_fnc_getConfigValue
						] select {_x != ""} select 0;

						_pictureCtrl ctrlSetText (_ctrlListbox lbPicture _idx);
						_textCtrl ctrlSetStructuredText parseText format ["<t font='PuristaMedium'>%1</t>", _description];
						_titleCtrl ctrlSetStructuredText parseText format [
							"<t size='1.3' font ='PuristaMedium'>%1</t><br/>%3:  <t color='#aaffaa'>%2%5</t><br/>%4",
							_ctrlListbox lbText _idx, (_ctrlListbox lbValue _idx) call HALs_fnc_numberToString, localize "STR_HALS_STORE_TEXT_PRICE",
							[
								format ["<t color='#DD2626'>%1</t>", localize "STR_HALS_STORE_TEXT_NOSTOCK"],
								format ["<t color='#A0DF3B'>%1</t>:  %2", localize "STR_HALS_STORE_TEXT_INSTOCK", _stock call HALs_fnc_numberToString]
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

							_y = _y + ((ctrlPosition _ctrlBar) select 3) + pixelH * 2;
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
				HALs_store_oldContainer = objNull;
				HALs_store_oldContainerMass = -1;
				HALs_store_oldContainers = [];
				HALs_store_oldPlayerContainers = [];
				HALs_store_oldMoney = 0;
				HALs_store_changed = false;
				HALs_store_nextUpdate = diag_tickTime;

				addMissionEventHandler ["EachFrame", {
					if (isNull (uiNamespace getVariable ["HALs_store_display", controlNull])) exitWith {
						removeMissionEventHandler ["EachFrame", _thisEventHandler];
					};

					if (diag_tickTime > HALs_store_nextUpdate) then {
						_containerString = UIDATA(IDC_BUY_ITEM_COMBO);
						_container = _containerString call BIS_fnc_objectFromNetId;
						_trader = (player getVariable ["HALs_store_trader_current", objNull]);
						_containers = vehicles select {
							private _vehicle = _x;
							({_vehicle isKindOf _x} count HALs_store_containerTypes) > 0
							&& ((_vehicle getVariable ["HALs_store_trader_type", ""]) isEqualTo "")
							&& {_x distance2D _trader <= HALs_store_containerRadius && {speed _x < 1} && {local _x} && {alive _x}}};
						_playerContainers = [uniformContainer player, vestContainer player, backpackContainer player];
						_money = [player] call HALs_money_fnc_getFunds;

						if (_container != HALs_store_oldContainer) then {
							HALs_store_oldContainer = _container;
							HALs_store_oldContainerMass = [_container] call HALs_store_fnc_getCargoMass;
							HALs_store_changed = true;
							["PROGRESS", ["UPDATE", [_containerString, UIDATA(IDC_LISTBOX), UICTRL(IDC_EDIT) getVariable ["amt", 1]]]] call  HALs_store_fnc_main;
						} else {
							_mass = [_container] call HALs_store_fnc_getCargoMass;
							if (_mass != HALs_store_oldContainerMass) then {
								HALs_store_oldContainerMass = _mass;
								HALs_store_changed = true;
								["PROGRESS", ["UPDATE", [_containerString, UIDATA(IDC_LISTBOX), UICTRL(IDC_EDIT) getVariable ["amt", 1]]]] call  HALs_store_fnc_main;
							};
						};
						if (_money != HALs_store_oldMoney) then {
							HALs_store_oldMoney = _money;
							HALs_store_changed = true;
							["TEXT", ["UPDATE", ["FUNDS", []]]] call  HALs_store_fnc_main;
						};
						if !(_containers isEqualTo HALs_store_oldContainers) then {
							HALs_store_oldContainers = _containers;
							HALs_store_vehicles = HALs_store_oldContainers apply {
								[typeOf _x, format ["%1 (%2m)", [(configFile >> "cfgVehicles" >> typeOf _x >> "displayName"), ""] call HALs_fnc_getConfigValue, round (_x distance2D _trader)], "", _x]
							};
							HALs_store_changed = true;
							["COMBOBOX", ["UPDATE", []]] call  HALs_store_fnc_main;
						};
						if !(_playerContainers isEqualTo HALs_store_oldPlayerContainers) then {
							HALs_store_oldPlayerContainers = _playerContainers;
							HALs_store_changed = true;
							["COMBOBOX", ["UPDATE", []]] call  HALs_store_fnc_main;
						};

						if (HALs_store_changed) then {
							["LISTBOX", ["UPDATE", []]] call  HALs_store_fnc_main;
							["BUTTON", ["ENABLED", []]] call  HALs_store_fnc_main;
							HALs_store_changed = false;
						};

						HALs_store_nextUpdate = diag_tickTime + 0.05;
					};
				}];
			};

			case ("CLIENT"): {
				["BUTTON", ["ENABLED", []]] call  HALs_store_fnc_main;
				["EDIT", ["UPDATE", []]] call  HALs_store_fnc_main;
				["LISTBOX", ["UPDATE", []]] call  HALs_store_fnc_main;
				["PROGRESS", ["UPDATE", [UIDATA(IDC_BUY_ITEM_COMBO), UIDATA(IDC_LISTBOX), UICTRL(IDC_EDIT) getVariable ["amt", 1]]]] call  HALs_store_fnc_main;
				["TEXT", ["INIT", []]] call  HALs_store_fnc_main;
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

				private _bar = UICTRL(IDC_PROGRESS_LOAD);
				private _barNew = UICTRL(IDC_PROGRESS_NEWLOAD);

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
