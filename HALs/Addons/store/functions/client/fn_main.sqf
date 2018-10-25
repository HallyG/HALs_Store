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
	["INIT"] call HALs_store_fnc_main;
__________________________________________________________________*/
#include "..\script_component.hpp"

if (!hasInterface) exitWith {};

params [
	["_mode", "onLoad", [""]],
	["_this", [], [[]]]
];

private _trader = player getVariable ["HALs_store_trader_current", objNull];

switch (_mode) do {
	case ("onLoad"): {
		params [
			["_control", controlNull, [controlNull]]
		];

		disableSerialization;

		uiNamespace setVariable ["HALs_store_display", _control];
		uiNamespace setVariable ["HALs_store_lbIndex", -1];
		uiNamespace setVariable ["HALs_store_buyIndex", -1];

		["onInit"] call HALs_store_fnc_main;
		["LISTBOX", ["INIT", []]] call  HALs_store_fnc_main;
		["COMBOBOX", ["INIT", []]] call  HALs_store_fnc_main;
		["EDIT", ["INIT", []]] call  HALs_store_fnc_main;
		["TEXT", ["INIT", []]] call  HALs_store_fnc_main;
		["UPDATE", ["INIT", []]] call  HALs_store_fnc_main;
	};
	case ("onUnload"): {
		closeDialog 2;

		false call HALs_store_fnc_blur;
		player setVariable ["HALs_store_trader_current", objNull, true];

		uiNamespace setVariable ["HALs_store_display", controlNull];
		uiNamespace setVariable ["HALs_store_lbIndex", -1];
		uiNamespace setVariable ["HALs_store_buyIndex", -1];
	};
	case ("onInit"): {
		//--- Blur Screen
		true call HALs_store_fnc_blur;

		//--- Set Store title
		_storeName = [missionConfigFile >> "cfgHALsAddons" >> "cfgHALsStore" >> "stores" >> (_trader getVariable ["HALs_store_trader_type", ""]) >> "displayName", ""] call HALs_fnc_getConfigValue;
		UICTRL(IDC_RscDisplayStore_TITLE) ctrlSetText format ["%1", toUpper _storeName];

		//--- Reset Progress-bars
		_progressCurrent = UICTRL(IDC_RscDisplayStore_PROGRESS_LOAD);
		_progressNew = UICTRL(IDC_RscDisplayStore_PROGRESS_NEWLOAD);
		_progressCurrent progressSetPosition 0;
		_progressNew progressSetPosition 0;
		_progressNew ctrlSetTextColor [0.9,0,0,0.6];

		//--- Setup check-boxes
		{
			_x params ["_ctrl", "_tooltip"];

			_ctrl ctrlSetTooltip (localize _tooltip);
			_ctrl ctrlAddEventHandler ["CheckedChanged", {
				["LISTBOX", ["UPDATE", []]] call  HALs_store_fnc_main;
			}];
		} forEach [
			[UICTRL(IDC_RscDisplayStore_CHECKBOX1), "STR_HALS_STORE_CHECKBOX_AFFORD"],
			[UICTRL(IDC_RscDisplayStore_CHECKBOX2), "STR_HALS_STORE_CHECKBOX_STOCK"],
			[UICTRL(IDC_RscDisplayStore_CHECKBOX3), "STR_HALS_STORE_CHECKBOX_COMPATIBLE"]
		];

		UICTRL(IDC_RscDisplayStore_CHECKBOX_BUY) ctrlAddEventHandler ["CheckedChanged", {
			["BUTTON", ["ENABLED", []]] call HALs_store_fnc_main;
		}];
	};
	case ("LISTBOX"): {
		params ["_mode", "_this"];

		switch (toUpper _mode) do {
			params ["_mode", "_this"];
			case ("INIT"): {
				_ctrlListbox = UICTRL(IDC_RscDisplayStore_LISTBOX);
				ctrlSetFocus _ctrlListbox;

				_ctrlListbox ctrlAddEventHandler ["LBSelChanged", {
					params ["_ctrl", "_index"];

					uiNamespace setVariable ["HALs_store_lbIndex", _index];
					_amount = (floor (parseNumber ctrlText UICTRL(IDC_RscDisplayStore_EDIT))) max 0;

					["PROGRESS", 	["STATS", 	[_ctrl lbData _index]]] call  HALs_store_fnc_main;
					["TEXT", 		["UPDATE", 	["ITEM", []]]] call  HALs_store_fnc_main;
					["TEXT", 		["UPDATE", 	["BUY", [_ctrl lbValue _index, _amount]]]] call HALs_store_fnc_main;
					["PROGRESS", 	["UPDATE", 	[UIDATA(IDC_RscDisplayStore_BUY_ITEM_COMBO), _ctrl lbData _index, _amount]]] call  HALs_store_fnc_main;
					["EDIT", 		["UPDATE", 	[]]] call  HALs_store_fnc_main;
					["BUTTON", 		["ENABLED", []]] call  HALs_store_fnc_main;
				}];

				_ctrlListbox ctrlSetFontHeight (1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8);
			};
			case ("UPDATE"): {
				_ctrlListbox = UICTRL(IDC_RscDisplayStore_LISTBOX);
				lbClear _ctrlListbox;

				_ctrlCheckbox1 = UICTRL(IDC_RscDisplayStore_CHECKBOX1);
				_ctrlCheckbox2 = UICTRL(IDC_RscDisplayStore_CHECKBOX2);
				_ctrlCheckbox3 = UICTRL(IDC_RscDisplayStore_CHECKBOX3);

				_filterItems = [];
				if (cbChecked _ctrlCheckbox3) then {
					{
						_filterItems append (_x call HALs_fnc_getCompatibleItems);
					} forEach [primaryWeapon player, handgunWeapon player, secondaryWeapon player];
				};

				_money = [player] call HALs_money_fnc_getFunds;
				_configPath = (missionConfigFile >> "cfgHALsAddons" >> "cfgHALsStore" >> "categories" >> UIDATA(IDC_RscDisplayStore_COMBO_CATEGORY));
				_items = ("true" configClasses _configPath) apply {configName _x};

				//--- Add all items
				{
					private _config = _x call HALs_fnc_getConfigClass;
					private _price = (getNumber (_configPath >> _x >> "price")) max 0 min 999999;
					private _stock = [_trader, _x] call HALs_store_fnc_getTraderStock;

					if !(cbChecked _ctrlCheckbox1 && {_price > _money}) then {
						if !(cbChecked _ctrlCheckbox2 && {_stock isEqualTo 0}) then {
							if !(cbChecked _ctrlCheckbox3 && {!(_x in _filterItems)}) then {
								_displayName = [_config >> "displayName", ""] call HALs_fnc_getConfigValue;
								_index = _ctrlListbox lbAdd _displayName;

								_ctrlListbox lbSetData [_index, _x];
								_ctrlListbox lbSetValue [_index, _price];
								_ctrlListbox lbSetPicture [_index, [_config >> "picture", ""] call HALs_fnc_getConfigValue];
								_ctrlListbox lbSetTextRight [_index, format ["%1%2", _price call HALs_fnc_numberToString, HALs_store_currencySymbol]];

								if (_price > _money) then {
									_ctrlListbox lbSetColorRight [_index, [0.91, 0, 0, 1]];
									_ctrlListbox lbSetSelectColorRight [_index, [0.91, 0, 0, 1]];
									_ctrlListbox lbSetTooltip [_index, format [localize "STR_HALS_STORE_LISTBOX_NOMONEY", (_price - _money) call HALs_fnc_numberToString]];
								} else {
									_ctrlListbox lbSetTooltip [_index, _displayName];
									_ctrlListbox lbSetColorRight [_index, [0.666667, 1, 0.666667, 1]];
									_ctrlListbox lbSetSelectColorRight [_index, [0.666667, 1, 0.666667, 1]];
								};
							};
						};
					};
					true;
				} count _items;

				private _index = uiNamespace getVariable ["HALs_store_lbIndex", -1];
				_ctrlListbox lbSetCurSel ([_index, 0] select (_index isEqualTo -1));

				["PROGRESS", ["UPDATE", [UIDATA(IDC_RscDisplayStore_BUY_ITEM_COMBO), UIDATA(IDC_RscDisplayStore_LISTBOX),(floor (parseNumber ctrlText UICTRL(IDC_RscDisplayStore_EDIT))) max 0]]] call  HALs_store_fnc_main;
				["TEXT", ["UPDATE", ["BUY", [UIVALUE(IDC_RscDisplayStore_LISTBOX), (floor (parseNumber ctrlText UICTRL(IDC_RscDisplayStore_EDIT))) max 0]]]] call  HALs_store_fnc_main;
			};
		};
	};
	case ("COMBOBOX"): {
		params ["_mode", "_this"];

		switch (toUpper _mode) do {
			params ["_mode", "_this"];

			case ("INIT"): {
				//---  Category combo-box
				_ctrlCategory = UICTRL(IDC_RscDisplayStore_COMBO_CATEGORY);

				//--- Update Item listbox if category changes
				_ctrlCategory ctrlAddEventHandler ["LBSelChanged", {["LISTBOX", ["UPDATE", []]] call  HALs_store_fnc_main}];

				//--- Add categories
				{
					_ctrlCategory lbAdd (getText (missionConfigFile >> "cfgHALsAddons" >> "cfgHALsStore" >> "categories" >> _x >> "displayName"));
					_ctrlCategory lbSetPicture [_forEachIndex, "" /*getText (missionConfigFile >> "cfgHALsStore" >> "categories" >> _x >> "picture")*/];
					_ctrlCategory lbSetData [_forEachIndex, _x];
					_ctrlCategory lbSetTooltip [_forEachIndex, "Store category"];
				} forEach (_trader getVariable ["HALs_store_trader_categories", []]);

				if (lbSize _ctrlCategory > 0) then {
					_ctrlCategory lbSetCurSel 0;
				};

				//---  Purchase combo-box
				_ctrlPurchase = UICTRL(IDC_RscDisplayStore_BUY_ITEM_COMBO);

				//--- Update container picture
				_ctrlPurchase ctrlAddEventHandler ["LBSelChanged", {
					params ["_ctrl", "_index"];

					uiNamespace setVariable ["HALs_store_buyIndex", _index];
					["TEXT", ["UPDATE", ["CARGO", [UIDATA(IDC_RscDisplayStore_BUY_ITEM_COMBO)]]]] call HALs_store_fnc_main;
				}];

				["COMBOBOX", ["UPDATE", []]] call  HALs_store_fnc_main;
			};
			case ("UPDATE"): {
				_ctrlPurchase = UICTRL(IDC_RscDisplayStore_BUY_ITEM_COMBO);
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

				private _index = uiNamespace getVariable ["HALs_store_buyIndex", -1];
				_ctrlPurchase lbSetCurSel ([_index, 0] select (_index isEqualTo -1));
			};
		};
	};
	case ("EDIT"): {
		params ["_mode", "_this"];

		switch (toUpper _mode) do {
			params ["_mode", "_this"];

			case ("INIT"): {
				private _ctrlEdit = UICTRL(IDC_RscDisplayStore_EDIT);
				{
					_ctrlEdit ctrlAddEventHandler [_x, {
						_amount = (floor parseNumber ctrlText (_this select 0)) max 0;
						["PROGRESS", ["UPDATE", [UIDATA(IDC_RscDisplayStore_BUY_ITEM_COMBO), UIDATA(IDC_RscDisplayStore_LISTBOX), _amount]]] call  HALs_store_fnc_main;
						["TEXT", ["UPDATE", ["BUY", [UIVALUE(IDC_RscDisplayStore_LISTBOX), _amount]]]] call  HALs_store_fnc_main;
						["BUTTON", ["ENABLED", []]] call  HALs_store_fnc_main;
					}];
				} forEach ["KeyUp", "KeyDown"];

				["EDIT", ["UPDATE", []]] call  HALs_store_fnc_main;
			};
			case ("UPDATE"): {
				private _ctrlEdit = UICTRL(IDC_RscDisplayStore_EDIT);
				private _index = uiNamespace getVariable ["HALs_store_lbIndex", -1];
				private _amount = (floor (parseNumber ctrlText _ctrlEdit)) max 1;

				_ctrlEdit ctrlEnable (_index > -1);

				if (_index > -1) then {
					_ctrlEdit ctrlSetText format ["%1", _amount];
				} else {
					_ctrlEdit ctrlSetText "";
				};
			};
		};
	};
	case ("BUTTON"): {
		params ["_mode", "_this"];

		switch (toUpper _mode) do {
			params ["_mode", "_this"];

			case ("ENABLED"): {
				_ctrlButton = UICTRL(IDC_RscDisplayStore_BUTTON_BUY);

				if ((uiNamespace getVariable ["HALs_store_lbIndex", -1]) isEqualTo -1) exitWith {
					_ctrlButton ctrlEnable false;
				};

				_price = UIVALUE(IDC_RscDisplayStore_LISTBOX);
				_amount = floor (parseNumber ctrlText UICTRL(IDC_RscDisplayStore_EDIT));
				_sale = (1 - (_trader getVariable ["HALs_store_trader_sale", 0])) min 1 max 0;
				_money = [player] call HALs_money_fnc_getFunds;

				_classname = UIDATA(IDC_RscDisplayStore_LISTBOX);
				_stock = [_trader, _classname] call HALs_store_fnc_getTraderStock;

				//--- Check if purchase is valid
				_canBuy = !((_price * _amount * _sale > _money) || _stock < 1 || _amount > _stock || _amount < 1);

				//--- Check if the item can be equipped
				_doEquip = cbChecked UICTRL(IDC_RscDisplayStore_CHECKBOX_BUY);
				_canEquipPlayer = [player, _classname] call HALs_store_fnc_canEquipItem;
				_container = (UIDATA(IDC_RscDisplayStore_BUY_ITEM_COMBO)) call BIS_fnc_objectFromNetId;

				//--- Player can equip item and can add the rest of the items to the container
				_canEquip = _doEquip && {_canEquipPlayer && {!isNull _container && {_container canAdd [_classname, _amount - 1]}}};
				//--- Player can equip item
				_canEquipEmpty = _doEquip && {_canEquipPlayer} && {_amount isEqualTo 1};
				//--- Can add all items to container
				_canAdd = !(isNull _container) && {_container canAdd [_classname, _amount]};

				_ctrlButton ctrlEnable ((_canBuy && _canAdd || _canBuy && _canEquip) || _canBuy && _canEquipEmpty);
			};
			case ("BUY"): {
				_amount = floor ((parseNumber ctrlText UICTRL(IDC_RscDisplayStore_EDIT)) max 0);
				_price = UIVALUE(IDC_RscDisplayStore_LISTBOX);
				_classname = UIDATA(IDC_RscDisplayStore_LISTBOX);
				_container = (UIDATA(IDC_RscDisplayStore_BUY_ITEM_COMBO)) call BIS_fnc_objectFromNetId;

				[player, _classname, _price, _amount, _container, cbChecked UICTRL(IDC_RscDisplayStore_CHECKBOX_BUY)] remoteExecCall ["HALs_store_fnc_purchase", 2];
			};
		};
	};
	case ("TEXT"): /* DONE */ {
		params ["_mode", "_this"];

		switch (toUpper _mode) do {
			params ["_mode", "_this"];

			case ("INIT"): {
				["TEXT", ["UPDATE", ["BUY", [UICTRL(IDC_RscDisplayStore_LISTBOX) lbValue CTRLSEL(IDC_RscDisplayStore_LISTBOX), (floor (parseNumber ctrlText UICTRL(IDC_RscDisplayStore_EDIT))) max 0]]]] call HALs_store_fnc_main;
				["TEXT", ["UPDATE", ["CARGO", []]]] call  HALs_store_fnc_main;
				["TEXT", ["UPDATE", ["FUNDS", []]]] call  HALs_store_fnc_main;
				["TEXT", ["UPDATE", ["ITEM", []]]] call  HALs_store_fnc_main;
			};
			case ("UPDATE"): {
				params ["_mode", "_this"];

				switch (toUpper _mode) do {
					params ["_mode", "_this"];

					case ("BUY"): {
						params [
							["_price", 0, [0]],
							["_amount", 0, [0]]
						];

						private _index = uiNamespace getVariable ["HALs_store_lbIndex", -1];
						if !(_amount > 0 && _index > -1) exitWith {
							UICTRL(IDC_RscDisplayStore_ITEM) ctrlSetStructuredText parseText format [""];
						};

						_ctrlText = UICTRL(IDC_RscDisplayStore_ITEM);
						_ctrlEdit = UICTRL(IDC_RscDisplayStore_EDIT);
						_ctrlButton = UICTRL(IDC_RscDisplayStore_BUTTON_BUY);
						_ctrlCheckbox = UICTRL(IDC_RscDisplayStore_CHECKBOX_BUY);

						_money = [player] call HALs_money_fnc_getFunds;
						_stock = [_trader, UIDATA(IDC_RscDisplayStore_LISTBOX)] call HALs_store_fnc_getTraderStock;
						_sale = (_trader getVariable ["HALs_store_trader_sale", 0]) min 1 max 0;
						_saleModifier = (1 - _sale) min 1 max 0;
						_total = _amount * _price * _saleModifier;

						_ctrlText ctrlSetStructuredText parseText format [
							"<t font ='PuristaMedium' align='right' shadow='0'>%1%3%2%4</t>",
							format [
								"<t size='1'>%1%4</t> <t size ='1' shadow='1' color='#%3'>x%2</t><br/>",
								_price call HALs_fnc_numberToString,
								_amount,
								['b2ec00', 'ea0000'] select (_amount > _stock),
								HALs_store_currencySymbol
							], "",
							[
								format ["<t size='0.95'>- %1%2</t><br/>", _sale * 100, "%"],
								""
							] select (_sale in [0]),
							format [
								"<t size='1.1' color='#%2'>- %1%3</t>",
								_total call HALs_fnc_numberToString,
								['b2ec00', 'ea0000'] select (_total > _money),
								HALs_store_currencySymbol
							]
						];

						//--- Update positions of controls
						_ctrlTextHeight = [_ctrlText, 4 * pixelH] call BIS_fnc_ctrlFitToTextHeight;
						_margin = (safeZoneY + (safeZoneH * (((0.0357143 * 0.1) - safeZoneY)/safeZoneH))) + 4 * pixelH;

						_ctrlPosition = ctrlPosition _ctrlText;
						_ctrlPosEdit = ctrlPosition _ctrlEdit;
						_ctrlPosEdit set [1, (_ctrlPosition select 1) + _ctrlTextHeight + _margin];
						_ctrlEdit ctrlSetPosition _ctrlPosEdit;
						_ctrlEdit ctrlCommit 0;

						_ctrlPosition = ctrlPosition _ctrlButton;
						_ctrlPosition set [1, (_ctrlPosEdit select 1) + (ctrlTextHeight _ctrlEdit) + _margin];
						_ctrlButton ctrlSetPosition _ctrlPosition;
						_ctrlButton ctrlCommit 0;

						_ctrlPosition = ctrlPosition _ctrlCheckbox;
						_ctrlPosition set [1, (_ctrlPosEdit select 1) + (ctrlTextHeight _ctrlEdit) + _margin];
						_ctrlCheckbox ctrlSetPosition _ctrlPosition;
						_ctrlCheckbox ctrlCommit 0;
					};
					case ("CARGO"): {
						private _classname = typeOf (UIDATA(IDC_RscDisplayStore_BUY_ITEM_COMBO) call BIS_fnc_objectFromNetId);

						if (_classname find "Supply" isEqualTo 0) then {
							_classname = [uniform player, vest player, backpack player] select (["Uniform", "Vest", "Backpack"] find (UITEXT(IDC_RscDisplayStore_BUY_ITEM_COMBO)));
						};

						private _type = (_classname call BIS_fnc_itemType) select 0;
						private _cargo = ["editorPreview", "picture"] select (_type == "equipment");

						if (isClass (configFile >> "cfgVehicles" >> _classname)) then {
							UICTRL(IDC_RscDisplayStore_BUY_PICTURE) ctrlSetText (getText (configFile >> "cfgVehicles" >> _classname >> _cargo));
						} else {
							UICTRL(IDC_RscDisplayStore_BUY_PICTURE) ctrlSetText (getText (configFile >> "cfgWeapons" >> _classname >> _cargo));
						};
					};
					case ("FUNDS"): {
						UICTRL(IDC_RscDisplayStore_FUNDS) ctrlSetText format ["%1%2", ([player] call HALs_money_fnc_getFunds) call HALs_fnc_numberToString, HALs_store_currencySymbol];
					};
					case ("ITEM"): {
						private _index = uiNamespace getVariable ["HALs_store_lbIndex", -1];
						private _pictureCtrl = UICTRL(IDC_RscDisplayStore_ITEM_PICTURE);
						private _titleCtrl = UICGCTRL(IDC_RscDisplayStore_ITEM_TEXT);//;UICTRL(IDC_RscDisplayStore_ITEM_TEXT);
						private _textCtrl = UICGCTRL(IDC_RscDisplayStore_ITEM_TEXT_DES);//;UICTRL(IDC_RscDisplayStore_ITEM_TEXT);

						if (_index isEqualTo -1) exitWith {
							_pictureCtrl ctrlSetText "";
							_titleCtrl ctrlSetStructuredText parseText format [""];
							_textCtrl ctrlSetStructuredText parseText format [""];
						};

						_ctrlListbox = UICTRL(IDC_RscDisplayStore_LISTBOX);
						private _classname = _ctrlListbox lbData _index;
						private _stock = [_trader, _classname] call HALs_store_fnc_getTraderStock;
						private _config = _classname call HALs_fnc_getConfigClass;

						private _description = [
							[missionConfigFile >> "cfgHALsAddons" >> "cfgHALsStore" >> "categories" >> UIDATA(IDC_RscDisplayStore_COMBO_CATEGORY) >> _classname >> "description", ""] call HALs_fnc_getConfigValue,
							[_config >> "Library" >> "libTextDesc", ""] call HALs_fnc_getConfigValue,
							[_config >> "descriptionShort", ""] call HALs_fnc_getConfigValue
						] select {_x != ""} select 0;

						_pictureCtrl ctrlSetText (_ctrlListbox lbPicture _index);
						_textCtrl ctrlSetStructuredText parseText format ["<t font = 'PuristaMedium'>%1</t>", _description];
						_titleCtrl ctrlSetStructuredText parseText format [
							"<t size='1.3' font ='PuristaMedium'>%1</t><br/>%3:  <t color='#aaffaa'>%2%5</t><br/>%4",
							_ctrlListbox lbText _index, (_ctrlListbox lbValue _index) call HALs_fnc_numberToString, localize "STR_HALS_STORE_TEXT_PRICE",
							[
								format ["<t color='#DD2626'>%1</t>", localize "STR_HALS_STORE_TEXT_NOSTOCK"],
								format ["<t color='#A0DF3B'>%1</t>:  %2", localize "STR_HALS_STORE_TEXT_INSTOCK", _stock call HALs_fnc_numberToString]
							] select (_stock > 0), HALs_store_currencySymbol
						];


						//--- Update positions of controls
						[_titleCtrl] call BIS_fnc_ctrlTextHeight;

						_posPrevious = ctrlPosition _titleCtrl;

						{
							_x params ["_ctrlProgress", "_ctrlProgressText"];

							_ctrlProgress = UICTRL(_ctrlProgress);
							_ctrlProgressText = UICTRL(_ctrlProgressText);


							if ((ctrlFade _ctrlProgress) < 1) then {
								private _pos1 = ctrlPosition _ctrlProgress;


								if (_forEachIndex isEqualTo 0) then {
									_posPrevious set [0, _pos1 select 0];
									_posPrevious set [1, (_posPrevious select 1) + (_posPrevious select 3) + pixelH*4];
									_posPrevious set [2, _pos1 select 2];
									_posPrevious set [3, _pos1 select 3];
								} else {
									_posPrevious set [1, (_posPrevious select 1) + (_pos1 select 3) + (0.1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)) + ([0, pixelH] select (_forEachIndex isEqualTo 2))];
								};

								_ctrlProgress ctrlSetPosition _posPrevious;
								_ctrlProgress ctrlCommit 0;
								_ctrlProgressText ctrlSetPosition _posPrevious;
								_ctrlProgressText ctrlCommit 0;
							};
						} forEach PGBARS;

						private _posText = ctrlPosition _textCtrl;
						_posText set [1, (_posPrevious select 1) + (_posPrevious select 3) + 4 * pixelH];
						_posText set [3, (ctrlTextHeight _textCtrl)];
						_textCtrl ctrlSetPosition _posText;
						_textCtrl ctrlCommit 0;
					};
				};
			};
		};
	};
	case ("UPDATE"): /* DONE */ {
		params ["_mode", "_this"];

		switch (toUpper _mode) do {
			params ["_mode", "_this"];

			case ("INIT"): {
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
						_containerString = UIDATA(IDC_RscDisplayStore_BUY_ITEM_COMBO);
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
							HALs_store_oldContainerMass = [_container] call HALs_fnc_getCargoMass;
							HALs_store_changed = true;
							["PROGRESS", ["UPDATE", [_containerString, UIDATA(IDC_RscDisplayStore_LISTBOX), (floor (parseNumber ctrlText UICTRL(IDC_RscDisplayStore_EDIT))) max 0]]] call  HALs_store_fnc_main;
						} else {
							_mass = [_container] call HALs_fnc_getCargoMass;
							if (_mass != HALs_store_oldContainerMass) then {
								HALs_store_oldContainerMass = _mass;
								HALs_store_changed = true;
								["PROGRESS", ["UPDATE", [_containerString, UIDATA(IDC_RscDisplayStore_LISTBOX), (floor (parseNumber ctrlText UICTRL(IDC_RscDisplayStore_EDIT))) max 0]]] call  HALs_store_fnc_main;
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
				["PROGRESS", ["UPDATE", [UIDATA(IDC_RscDisplayStore_BUY_ITEM_COMBO), UIDATA(IDC_RscDisplayStore_LISTBOX), (floor (parseNumber ctrlText UICTRL(IDC_RscDisplayStore_EDIT))) max 0]]] call  HALs_store_fnc_main;
				["TEXT", ["INIT", []]] call  HALs_store_fnc_main;
			};
		};
	};
	case ("PROGRESS"): /* DONE */ {
		params ["_mode", "_this"];

		switch (toUpper _mode) do {
			params ["_mode", "_this"];

			case ("STATS"): {
				params [
					["_classname", "", [""]]
				];

				if (_classname isEqualTo "") exitWith {
					{
						_x params ["_progressCtrl", "_progressTextCtrl"];

						private _ctrlProgress = UICGCTRL(_progressCtrl);
						private _ctrlProgressText = UICGCTRL(_progressTextCtrl);

						_ctrlProgress progressSetPosition 0;
						_ctrlProgress ctrlSetFade 1;
						_ctrlProgress ctrlCommit 0;
						_ctrlProgressText ctrlSetText "";
						_ctrlProgressText ctrlSetFade 1;
						_ctrlProgressText ctrlCommit 0;
					} count PGBARS;
				};

				//--- Return stats for item
				private _config = _classname call HALs_fnc_getConfigClass;
				private _statsArray = [_config] call HALs_store_fnc_getItemStats;

				{
					_x params ["_progressCtrl", "_progressTextCtrl"];

					private _ctrlProgress = UICGCTRL(_progressCtrl);
					private _ctrlProgressText = UICGCTRL(_progressTextCtrl);

					if (count (_statsArray select _forEachIndex) > 0) then {
						(_statsArray select _forEachIndex) params ["_progress", "_text"];

						_ctrlProgress progressSetPosition _progress;
						_ctrlProgress ctrlSetFade 0;
						_ctrlProgress ctrlCommit 0;
						_ctrlProgressText ctrlSetText toUpper _text;
						_ctrlProgressText ctrlSetFade 0;
						_ctrlProgressText ctrlCommit 0;

					} else {
						_ctrlProgress progressSetPosition 0;
						_ctrlProgress ctrlSetFade 1;
						_ctrlProgress ctrlCommit 0;
						_ctrlProgressText ctrlSetText "";
						_ctrlProgressText ctrlSetFade 1;
						_ctrlProgressText ctrlCommit 0;
					};
				} forEach PGBARS;
			};
			case ("UPDATE"): {
				params [
					["_container", ""],
					["_classname", "", [""]],
					["_amount", 1, [1]]
				];

				_container = _container call BIS_fnc_objectFromNetId;

				if (_container isEqualTo objNull) exitWith {
					UICTRL(IDC_RscDisplayStore_PROGRESS_LOAD) progressSetPosition 0;
					UICTRL(IDC_RscDisplayStore_PROGRESS_NEWLOAD) progressSetPosition 0;
					UICTRL(IDC_RscDisplayStore_PROGRESS_NEWLOAD) ctrlSetTextColor [0.9,0,0,0.6];
				};

				_maxLoad = getNumber (configFile >> "CfgVehicles" >> typeOf _container >> "maximumLoad");
				_currentLoad = [_container] call HALs_fnc_getCargoMass;

				if (_classname isEqualTo "") exitWith {
					UICTRL(IDC_RscDisplayStore_PROGRESS_LOAD) progressSetPosition (_currentLoad / (_maxLoad max 1));
					UICTRL(IDC_RscDisplayStore_PROGRESS_NEWLOAD) progressSetPosition 0;
					UICTRL(IDC_RscDisplayStore_PROGRESS_NEWLOAD) ctrlSetTextColor [0.9,0,0,0.6];
				};

				_load = _classname call HALs_store_fnc_getItemMass;

				//--- Check if backpack as predefined items in it
				_itemType = [_classname] call HALs_store_fnc_getItemType;
				if (_itemType isEqualTo 3) then {
					_config = "true" configClasses (configFile >> "CfgVehicles" >> _classname);
					_arrayCargo = [];

					{
						_arrayCargo append (("true" configClasses _x) apply {[(configName _x) select [4], getNumber (_x >> "count")]});;
					} forEach _config;

					{
						_x params ["_itemclassname", "_count"];
						_load = _load + (_itemclassname call HALs_store_fnc_getItemMass) * _count;
					} forEach _arrayCargo;
				};

				_progress = linearConversion [0, _maxLoad, _currentLoad + (_load * _amount), 0, 1, true];
				_canAdd = _container canAdd [_classname, _amount];
				_colour = call {
					if (!_canAdd) exitWith {
						[0.9,0,0,0.6]
					};
					if (_progress > 1) exitWith {
						[0.9,0,0,0.6]
					};
					[0,0.9,0,0.6]
				};

				UICTRL(IDC_RscDisplayStore_PROGRESS_LOAD) progressSetPosition (_currentLoad / (_maxLoad max 1));
				UICTRL(IDC_RscDisplayStore_PROGRESS_NEWLOAD) progressSetPosition ([1, _progress] select (_canAdd));
				UICTRL(IDC_RscDisplayStore_PROGRESS_NEWLOAD) ctrlSetTextColor _colour;
			};
		};
	};
};
