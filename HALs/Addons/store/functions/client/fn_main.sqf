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
disableSerialization;

params [
	["_mode", "ONLOAD", [""]],
	["_this", [], [[]]]
];

private _trader = player getVariable ["HALs_store_trader_current", objNull];
switch (toUpper _mode) do {
	case ("ONLOAD"): /* DONE */ {
		params [
			["_control", controlNull, [controlNull]]
		];
		
		true call HALs_store_fnc_blur;	
		uiNamespace setVariable ["HALs_store_display", _control];
		uiNamespace setVariable ["HALs_store_lbIndex", -1];
		uiNamespace setVariable ["HALs_store_buyIndex", -1];
		
		_control ctrlSetFade 1;
		_control ctrlCommit 0;
		_control ctrlSetFade 0;
		_control ctrlCommit 0.2;
		
		(ctrlParent _control) displayAddEventHandler ["KeyDown", {
			params ["_ctrl", "_keyCode"];
	
			if (_keyCode isEqualTo DIK_ESCAPE) then {
				["UNLOAD"] call HALs_store_fnc_main;
			};
		}];
		
		["LISTBOX", ["INIT", []]] call  HALs_store_fnc_main;
		["COMBOBOX", ["INIT", []]] call  HALs_store_fnc_main;
		["PROGRESS", ["INIT", []]] call  HALs_store_fnc_main;
		//["BUTTON", ["ENABLED", []]] call  HALs_store_fnc_main;
		["CHECKBOX", ["INIT", []]] call  HALs_store_fnc_main;
		["EDIT", ["INIT", []]] call  HALs_store_fnc_main;
		["TEXT", ["INIT", []]] call  HALs_store_fnc_main;
		["UPDATE", ["INIT", []]] call  HALs_store_fnc_main;
	};
	case ("UNLOAD"): /* DONE */ {
		closeDialog 2;
		false call HALs_store_fnc_blur;

		uiNamespace setVariable ["HALs_store_display", controlNull];
		uiNamespace setVariable ["HALs_store_lbIndex", -1];
		uiNamespace setVariable ["HALs_store_buyIndex", -1];
		player setVariable ["HALs_store_trader_current", objNull];
	};
	case ("LISTBOX"): /* DONE */ {
		params ["_mode", "_this"];

		switch (toUpper _mode) do {
			params ["_mode", "_this"];
			case ("INIT"): {	
				ctrlSetFocus UICTRL(IDC_RscDisplayStore_LISTBOX);
				UICTRL(IDC_RscDisplayStore_LISTBOX) ctrlAddEventHandler ["LBSelChanged", {
					params ["_ctrl", "_index"];
					
					uiNamespace setVariable ["HALs_store_lbIndex", _index];		
					_amount = (floor (parseNumber ctrlText UICTRL(IDC_RscDisplayStore_EDIT))) max 0;
					
					["PROGRESS", ["STATS", [_ctrl lbData _index]]] call  HALs_store_fnc_main;
					["TEXT", ["UPDATE", ["ITEM", []]]] call  HALs_store_fnc_main;
					["TEXT", ["UPDATE", ["BUY", [_ctrl lbValue _index, _amount]]]] call  HALs_store_fnc_main;
					["PROGRESS", ["UPDATE", [UIDATA(IDC_RscDisplayStore_BUY_ITEM_COMBO), _ctrl lbData _index, _amount]]] call  HALs_store_fnc_main;
					["EDIT", ["UPDATE", []]] call  HALs_store_fnc_main;
					["BUTTON", ["ENABLED", []]] call  HALs_store_fnc_main;
				}];
			};
			case ("UPDATE"): {
				private _listbox = UICTRL(IDC_RscDisplayStore_LISTBOX);
				lbClear _listbox;
				
				private _money = [player] call HALs_money_fnc_getFunds;
				private _category = UIDATA(IDC_RscDisplayStore_COMBO_CATEGORY);
				private _items = "true" configClasses (missionConfigFile >> "cfgHALsStore" >> "categories" >> _category) apply {configName _x};
				private _filterItems = [];
				
				if (cbChecked UICTRL(IDC_RscDisplayStore_CHECKBOX3)) then {
					if !((primaryWeapon player) isEqualTo "") then {
						_filterItems append ((primaryWeapon player) call HALs_fnc_getCompatibleItems);
					};
					if !((handgunWeapon player) isEqualTo "") then {
						_filterItems append ((handgunWeapon player) call HALs_fnc_getCompatibleItems);
					};
					if !((secondaryWeapon player) isEqualTo "") then {
						_filterItems append ((secondaryWeapon player) call HALs_fnc_getCompatibleItems);
					};
				};
				
				{
					private _config = _x call HALs_fnc_getConfigClass;
					private _displayName = [_config >> "displayName", ""] call HALs_fnc_getConfigValue;
					private _picture = [_config >> "picture", ""] call HALs_fnc_getConfigValue;
					private _price = (getNumber (missionConfigFile >> "cfgHALsStore" >> "categories" >> _category >> _x >> "price")) max 0 min 999999;	

					if !(_price > _money && cbChecked UICTRL(IDC_RscDisplayStore_CHECKBOX1)) then {
						if !(cbChecked UICTRL(IDC_RscDisplayStore_CHECKBOX2) && {([_trader, _x] call HALs_store_fnc_getTraderStock) isEqualTo 0}) then {
							if !(cbChecked UICTRL(IDC_RscDisplayStore_CHECKBOX3) && {!(_x in _filterItems)}) then {
								private _index = _listbox lbAdd _displayName;
								_listbox lbSetData [_index, _x];
								_listbox lbSetValue [_index, _price];
								_listbox lbSetPicture [_index, _picture];
								_listbox lbSetTextRight [_index, format ["%1¢", _price call HALs_fnc_numberToString]];
								
								if (_price > _money) then {
									_listbox lbSetColorRight [_index, [0.91, 0, 0, 1]];
									_listbox lbSetSelectColorRight [_index, [0.91, 0, 0, 1]];
									_listbox lbSetTooltip [_index, format [localize "STR_HALS_STORE_LISTBOX_NOMONEY", (_price - _money) call HALs_fnc_numberToString]];	
								} else {
									_listbox lbSetTooltip [_index, _displayName];							
									_listbox lbSetColorRight [_index, [0.666667, 1, 0.666667, 1]];	
									_listbox lbSetSelectColorRight [_index, [0.666667, 1, 0.666667, 1]];																		
								};
							};
						};
					};
					true;
				} count _items;
				
				private _index = uiNamespace getVariable ["HALs_store_lbIndex", -1];
				_listbox lbSetCurSel ([_index, 0] select (_index isEqualTo -1));
				
				["PROGRESS", ["UPDATE", [UIDATA(IDC_RscDisplayStore_BUY_ITEM_COMBO), UIDATA(IDC_RscDisplayStore_LISTBOX),(floor (parseNumber ctrlText UICTRL(IDC_RscDisplayStore_EDIT))) max 0]]] call  HALs_store_fnc_main;
				["TEXT", ["UPDATE", ["BUY", [UIVALUE(IDC_RscDisplayStore_LISTBOX), (floor (parseNumber ctrlText UICTRL(IDC_RscDisplayStore_EDIT))) max 0]]]] call  HALs_store_fnc_main;
			};	
		};
	};
	case ("COMBOBOX"): /* DONE */ {
		params ["_mode", "_this"];

		switch (toUpper _mode) do {
			params ["_mode", "_this"];

			case ("INIT"): {
				private _category = UICTRL(IDC_RscDisplayStore_COMBO_CATEGORY);
				private _purchase = UICTRL(IDC_RscDisplayStore_BUY_ITEM_COMBO);
			
				_category ctrlAddEventHandler ["LBSelChanged", {
					["LISTBOX", ["UPDATE", []]] call  HALs_store_fnc_main;
				}];
				
				{
					_category lbAdd (getText (missionConfigFile >> "cfgHALsStore" >> "categories" >> _x >> "displayName"));	
					_category lbSetPicture [_forEachIndex, "" /*getText (missionConfigFile >> "cfgHALsStore" >> "categories" >> _x >> "picture")*/];	
					_category lbSetData [_forEachIndex, _x];
					_category lbSetTooltip [_forEachIndex, "Store category"];
				} forEach (_trader getVariable ["HALs_store_trader_categories", []]);
				_category lbSetCurSel 0;
				
				_purchase ctrlAddEventHandler ["LBSelChanged", {
					params ["_ctrl", "_index"];
					
					uiNamespace setVariable ["HALs_store_buyIndex", _index];
					["TEXT", ["UPDATE", ["CARGO", [UIDATA(IDC_RscDisplayStore_BUY_ITEM_COMBO)]]]] call HALs_store_fnc_main;
				}];
				
				["COMBOBOX", ["UPDATE", []]] call  HALs_store_fnc_main;		
			};	
			case ("UPDATE"): {
				private _purchase = UICTRL(IDC_RscDisplayStore_BUY_ITEM_COMBO);
				lbClear _purchase;

				{
					_x params [
						["_classname", ""],
						["_displayName", ""],
						["_picture", ""],
						["_object", objNull]
					];

					if (!isNull _object && {_classname != ""}) then {
						_index = _purchase lbAdd _displayName;
						_purchase lbSetPicture [_index, _picture];
						_purchase lbSetData [_index, _object call BIS_fnc_netId];
						_purchase lbSetTooltip [_index, format ["Purchase to %1%2", _displayName, toString [10,13]]];
					};
				} forEach ([
					[[typeOf _trader, "Trader", "a3\ui_f\data\gui\Rsc\RscDisplayArsenal\face_ca.paa", _trader], []] select (_trader isKindOf "Man"),
					[uniform player, "Uniform", "a3\ui_f\data\gui\Rsc\RscDisplayArsenal\uniform_ca.paa", uniformContainer player],
					[vest player, "Vest", "a3\ui_f\data\gui\Rsc\RscDisplayArsenal\vest_ca.paa", vestContainer player],
					[backpack player, "Backpack", "a3\ui_f\data\gui\Rsc\RscDisplayArsenal\backpack_ca.paa", backpackContainer player]
				] + HALs_store_vehicles);
		
				private _index = uiNamespace getVariable ["HALs_store_buyIndex", -1];
				_purchase lbSetCurSel ([_index, 0] select (_index isEqualTo -1));
			};
		};
	};
	case ("EDIT"): /* DONE */ {
		params ["_mode", "_this"];
		
		switch (toUpper _mode) do {
			params ["_mode", "_this"];
	
			case ("INIT"): {
				private _edit = UICTRL(IDC_RscDisplayStore_EDIT);
				{
					_edit ctrlAddEventHandler [_x, {
						_amt = (floor parseNumber ctrlText (_this select 0)) max 0;			
						["PROGRESS", ["UPDATE", [UIDATA(IDC_RscDisplayStore_BUY_ITEM_COMBO), UIDATA(IDC_RscDisplayStore_LISTBOX), _amt]]] call  HALs_store_fnc_main;
						["TEXT", ["UPDATE", ["BUY", [UIVALUE(IDC_RscDisplayStore_LISTBOX), _amt]]]] call  HALs_store_fnc_main;
						["BUTTON", ["ENABLED", []]] call  HALs_store_fnc_main;
					}];	
				} forEach ["KeyUp", "KeyDown"];

				["EDIT", ["UPDATE", []]] call  HALs_store_fnc_main;
			};
			case ("UPDATE"): {
				private _edit = UICTRL(IDC_RscDisplayStore_EDIT);
				private _index = uiNamespace getVariable ["HALs_store_lbIndex", -1];
				private _amount = (floor (parseNumber ctrlText _edit)) max 1;

				_edit ctrlEnable (_index > -1);
				
				if (_index > -1) then {
					_edit ctrlSetText format ["%1", _amount];
				} else {
					_edit ctrlSetText "";
				};
			};
		};
	};
	case ("CHECKBOX"): /* DONE */ {
		params ["_mode", "_this"];

		switch (toUpper _mode) do {
			params ["_mode", "_this"];
	
			case ("INIT"): {
				{
					_x params ["_idc", "_tooltip"];

					UICTRL(_idc) ctrlSetTooltip _tooltip;
					UICTRL(_idc) ctrlAddEventHandler ["CheckedChanged", {
						["LISTBOX", ["UPDATE", []]] call  HALs_store_fnc_main;
					}];
				} forEach [
					[IDC_RscDisplayStore_CHECKBOX1, localize "STR_HALS_STORE_CHECKBOX_AFFORD"],
					[IDC_RscDisplayStore_CHECKBOX2, localize "STR_HALS_STORE_CHECKBOX_STOCK"],
					[IDC_RscDisplayStore_CHECKBOX3, localize "STR_HALS_STORE_CHECKBOX_COMPATIBLE"]
				];
				UICTRL(IDC_RscDisplayStore_CHECKBOX_BUY) ctrlAddEventHandler ["CheckedChanged", {
					["BUTTON", ["ENABLED", []]] call  HALs_store_fnc_main;
				}];
			};
		};
	};
	case ("BUTTON"): /* DONE */ {
		params ["_mode", "_this"];
		
		switch (toUpper _mode) do {
			params ["_mode", "_this"];

			case ("ENABLED"): {
				if ((uiNamespace getVariable ["HALs_store_lbIndex", -1]) isEqualTo -1) exitWith {
					UICTRL(IDC_RscDisplayStore_BUTTON_BUY) ctrlEnable false;
				};
				
				_amount = floor (parseNumber ctrlText UICTRL(IDC_RscDisplayStore_EDIT));
				_classname = UIDATA(IDC_RscDisplayStore_LISTBOX);
				_container = (UIDATA(IDC_RscDisplayStore_BUY_ITEM_COMBO)) call BIS_fnc_objectFromNetId;
				_money = [player] call HALs_money_fnc_getFunds;
				_price = UIVALUE(IDC_RscDisplayStore_LISTBOX);
				_sale = (1 - (_trader getVariable ["HALs_store_trader_sale", 0])) min 1 max 0;
				_stock = [_trader, _classname] call HALs_store_fnc_getTraderStock;
				
				_canBuy = !((_price * _amount * _sale > _money) || _stock < 1 || _amount > _stock || _amount < 1);
				_canEquip = cbChecked UICTRL(IDC_RscDisplayStore_CHECKBOX_BUY) && {([player, _classname] call HALs_store_fnc_canEquipItem) && {!(isNull _container) && {(_container canAdd [_classname, _amount - 1])}}};
				_canEquipEmpty = cbChecked UICTRL(IDC_RscDisplayStore_CHECKBOX_BUY) && {([player, _classname] call HALs_store_fnc_canEquipItem)} && {_amount isEqualTo 1};
				_canAdd = !(isNull _container) && {(_container canAdd [_classname, _amount])};
				
				UICTRL(IDC_RscDisplayStore_BUTTON_BUY) ctrlEnable (((_canBuy && _canAdd) || (_canBuy && _canEquip)) || (_canBuy && _canEquipEmpty));
			};
			case ("BUY"): {
				private _amount = floor ((parseNumber ctrlText UICTRL(IDC_RscDisplayStore_EDIT)) max 0);
				private _price = UIVALUE(IDC_RscDisplayStore_LISTBOX);
				private _classname = UIDATA(IDC_RscDisplayStore_LISTBOX);
				private _container = (UIDATA(IDC_RscDisplayStore_BUY_ITEM_COMBO)) call BIS_fnc_objectFromNetId;
				
				[player, _classname, _price, _amount, _container, cbChecked UICTRL(IDC_RscDisplayStore_CHECKBOX_BUY)] remoteExecCall ["HALs_store_fnc_purchase", 0];
			};
		};
	};
	case ("TEXT"): /* DONE */ {
		params ["_mode", "_this"];

		switch (toUpper _mode) do {
			params ["_mode", "_this"];	
		
			case ("INIT"): {
				["TEXT", ["UPDATE", ["BUY", [UICTRL(IDC_RscDisplayStore_LISTBOX) lbValue CTRLSEL(IDC_RscDisplayStore_LISTBOX), (floor (parseNumber ctrlText UICTRL(IDC_RscDisplayStore_EDIT))) max 0]]]] call  HALs_store_fnc_main;
				["TEXT", ["UPDATE", ["CARGO", []]]] call  HALs_store_fnc_main;
				["TEXT", ["UPDATE", ["FUNDS", []]]] call  HALs_store_fnc_main;
				["TEXT", ["UPDATE", ["ITEM", []]]] call  HALs_store_fnc_main;
				
				UICTRL(IDC_RscDisplayStore_TITLE) ctrlSetText format ["%1", toUpper getText (missionConfigFile >> "cfgHALsStore" >> "stores" >> (_trader getVariable ["HALs_store_trader_type", ""]) >> "displayName")]; 
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
						
						private _text = UICTRL(IDC_RscDisplayStore_ITEM);
						private _edit = UICTRL(IDC_RscDisplayStore_EDIT);
						private _button = UICTRL(IDC_RscDisplayStore_BUTTON_BUY);
						private _checkbox = UICTRL(IDC_RscDisplayStore_CHECKBOX_BUY);
						private _textEquip = UICTRL(IDC_RscDisplayStore_ITEM_CANEQUIP);
						
						private _money = [player] call HALs_money_fnc_getFunds;
						private _sale = (_trader getVariable ["HALs_store_trader_sale", 0]) min 1 max 0;
						private _saleModifier = (1 - _sale) min 1 max 0;
						private _total = _amount * _price;
						private _stock = [_trader, UIDATA(IDC_RscDisplayStore_LISTBOX)] call HALs_store_fnc_getTraderStock;
						
						// _textEquip ctrlSetStructuredText parseText format ["<t size = '1' color='#%2' font = 'PuristaMedium' align='center'>%1</t>",
							// ["CANNOT EQUIP", "CAN EQUIP"] select ([player, UIDATA(IDC_RscDisplayStore_LISTBOX)] call HALs_store_fnc_canEquipItem),
							// ['ea0000', 'b2ec00'] select ([player, UIDATA(IDC_RscDisplayStore_LISTBOX)] call HALs_store_fnc_canEquipItem)
						// ];

						_text ctrlSetStructuredText parseText format ["%1%3%2%4",
							format ["<t size='1' font ='PuristaMedium' shadow='0' align='right'>%1¢<br/></t>", _price call HALs_fnc_numberToString],
							format ["<t size='1' font ='PuristaMedium' shadow='0' align='right'></t><t size = '0.97' font = 'PuristaMedium' shadow='0' align='right'>x </t><t size = '0.97' color='#%2' font = 'PuristaMedium' shadow='0' align='right'>%1</t><br/>", _amount, ['b2ec00', 'ea0000'] select (_amount > _stock)],
							/*color='#b2ec00'*/[format ["<t size = '0.95' shadow='0'  font = 'PuristaMedium' align='right'>- %1</t><br/>", format ["%1%2", _sale * 100, "%"]], ""] select (_sale in [1,0]),
							format ["<t size = '1.1' color='#%2' shadow='0' font = 'PuristaMedium' valign='middle' align='right'>- %1¢</t>", (_total * _saleModifier) call HALs_fnc_numberToString, ['b2ec00', 'ea0000'] select (_total > _money)]
						];

						private _pos = ctrlPosition _text;
						_pos set [3, (ctrlTextHeight _text)];
						_text ctrlSetPosition _pos;
						_text ctrlCommit 0;
							
						private _posEdit = ctrlPosition _edit;
						_posEdit set [1, (_pos select 1) + (ctrlTextHeight _text) + 4 * pixelH + (safeZoneY + (safeZoneH * (((0.0357143 * 0.1) - safeZoneY)/safeZoneH)))];
						_edit ctrlSetPosition _posEdit;
						_edit ctrlCommit 0;
							
						_pos = ctrlPosition _button;
						_pos set [1, (_posEdit select 1) + (ctrlTextHeight _edit) + 4 * pixelH + (safeZoneY + (safeZoneH * (((0.0357143 * 0.1) - safeZoneY)/safeZoneH)))];
						_button ctrlSetPosition _pos;
						_button ctrlCommit 0;
						
						_pos = ctrlPosition _checkbox;
						_pos set [1, (_posEdit select 1) + (ctrlTextHeight _edit) + 4 * pixelH + (safeZoneY + (safeZoneH * (((0.0357143 * 0.1) - safeZoneY)/safeZoneH)))];
						_checkbox ctrlSetPosition _pos;
						_checkbox ctrlCommit 0;
						
						// _posEdit = ctrlPosition _textEquip;
						// _posEdit set [1, (_pos select 1) + 4 * pixelH + (ctrlTextHeight _textEquip) + (safeZoneY + (safeZoneH * (((0.0357143 * 0.1) - safeZoneY)/safeZoneH)))];
						// _posEdit set [3, (ctrlTextHeight _textEquip) + 4 * pixelH];
						// _textEquip ctrlSetPosition _posEdit;
						// _textEquip ctrlEnable (ctrlEnabled _button);
						// _textEquip ctrlShow (ctrlEnabled _button);
						// _textEquip ctrlCommit 0;

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
						UICTRL(IDC_RscDisplayStore_FUNDS) ctrlSetText format ["%1¢", ([player] call HALs_money_fnc_getFunds) call HALs_fnc_numberToString];
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

						private _listbox = UICTRL(IDC_RscDisplayStore_LISTBOX);
						private _classname = _listbox lbData _index;
						private _stock = [_trader, _classname] call HALs_store_fnc_getTraderStock;
						private _config = (_classname call HALs_fnc_getConfigClass);
						private _description = [
							[missionConfigFile >> "cfgHALsStore" >> "categories" >> UIDATA(IDC_RscDisplayStore_COMBO_CATEGORY) >> _classname >> "description", ""] call HALs_fnc_getConfigValue,
							[_config >> "Library" >> "libTextDesc", ""] call HALs_fnc_getConfigValue,
							[_config >> "descriptionShort", ""] call HALs_fnc_getConfigValue
						] select {_x != ""} select 0;
					
						_pictureCtrl ctrlSetText (_listbox lbPicture _index);
						_textCtrl ctrlSetStructuredText parseText format ["<t font = 'PuristaMedium'>%1</t>", _description];
						_titleCtrl ctrlSetStructuredText parseText format [
							"<t size='1.3' font ='PuristaMedium'>%1</t><br/>%4:  <t color='#aaffaa'>%2¢</t><br/>%3",
							_listbox lbText _index,
							(_listbox lbValue _index) call HALs_fnc_numberToString,
							[
								format ["<t color='#DD2626'>%1</t>", localize "STR_HALS_STORE_TEXT_NOSTOCK"],
								format ["<t color='#A0DF3B'>%1</t>:  %2", localize "STR_HALS_STORE_TEXT_INSTOCK", _stock call HALs_fnc_numberToString]
							] select (_stock > 0),
							localize "STR_HALS_STORE_TEXT_PRICE"
						];

						private _control = controlNull;
						private _pos = ctrlPosition _titleCtrl;
						_pos set [3, ctrlTextHeight _titleCtrl];
						_titleCtrl ctrlSetPosition _pos;
						_titleCtrl ctrlCommit 0;
						_textCtrl ctrlCommit 0;
						
						_pos = ctrlPosition _titleCtrl;
						
						{	
							_x params ["_progressCtrl", "_progressTextCtrl"];
							
							if ((ctrlFade UICTRL(_progressCtrl)) < 1) then {
								private _pos1 = ctrlPosition UICTRL(_progressCtrl);
								_control = UICTRL(_progressCtrl);
								
								if (_forEachIndex isEqualTo 0) then {
									_pos set [0, _pos1 select 0];
									_pos set [1, (_pos select 1) + (_pos select 3)];
									_pos set [2, _pos1 select 2];
									_pos set [3, _pos1 select 3];
								};

								_pos set [1, (_pos select 1) + ([_pos1 select 3, 4 * pixelH] select (_forEachIndex isEqualTo 0)) + 4 * pixelH];

								UICTRL(_progressCtrl) ctrlSetPosition _pos;
								UICTRL(_progressCtrl) ctrlCommit 0;
								UICTRL(_progressTextCtrl) ctrlSetPosition _pos;
								UICTRL(_progressTextCtrl) ctrlCommit 0;
							};
						} forEach PGBARS;
						
						private _posText = ctrlPosition _textCtrl;
						_posText set [1, (_pos select 1) + (_pos select 3) + 8 * pixelH];
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
	case ("PROGRESS"):  {
		params ["_mode", "_this"];
		
		switch (toUpper _mode) do {
			params ["_mode", "_this"];
			
			case ("INIT"): {
				UICTRL(IDC_RscDisplayStore_PROGRESS_LOAD) progressSetPosition 0;
				UICTRL(IDC_RscDisplayStore_PROGRESS_NEWLOAD) progressSetPosition 0;
				UICTRL(IDC_RscDisplayStore_PROGRESS_NEWLOAD) ctrlSetTextColor [0.9,0,0,0.6];
			};
			case ("STATS"): {
				params [
					["_classname", "", [""]]
				];

				if (_classname isEqualTo "") exitWith {
					{
						_x params ["_progressCtrl", "_progressTextCtrl"];
						
						UICGCTRL(_progressCtrl) progressSetPosition 0;
						UICGCTRL(_progressCtrl) ctrlSetFade 1;
						UICGCTRL(_progressCtrl) ctrlCommit 0;
						UICGCTRL(_progressTextCtrl) ctrlSetText "";
						UICGCTRL(_progressTextCtrl) ctrlSetFade 1;
						UICGCTRL(_progressTextCtrl) ctrlCommit 0;
					} count PGBARS;
				};
				
				private _config = _classname call HALs_fnc_getConfigClass;
				private _statsArray = [_config] call HALs_store_fnc_getItemStats;


				{
					_x params ["_progressCtrl", "_progressTextCtrl"];
					
					if (count (_statsArray select _forEachIndex) > 0) then {
						(_statsArray select _forEachIndex) params ["_progress", "_text"];
						
						UICGCTRL(_progressCtrl) progressSetPosition _progress;
						UICGCTRL(_progressCtrl) ctrlSetFade 0;
						UICGCTRL(_progressCtrl) ctrlCommit 0;
						UICGCTRL(_progressTextCtrl) ctrlSetText _text;
						UICGCTRL(_progressTextCtrl) ctrlSetFade 0;
						UICGCTRL(_progressTextCtrl) ctrlCommit 0;
						
					} else {
						UICGCTRL(_progressCtrl) progressSetPosition 0;
						UICGCTRL(_progressCtrl) ctrlSetFade 1;
						UICGCTRL(_progressCtrl) ctrlCommit 0;
						UICGCTRL(_progressTextCtrl) ctrlSetText "";
						UICGCTRL(_progressTextCtrl) ctrlSetFade 1;
						UICGCTRL(_progressTextCtrl) ctrlCommit 0;
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

				private _maxLoad = getNumber (configFile >> "CfgVehicles" >> typeOf _container >> "maximumLoad");
				private _currentLoad = [_container] call HALs_fnc_getCargoMass;
		
				if (_classname isEqualTo "") exitWith {	
					UICTRL(IDC_RscDisplayStore_PROGRESS_LOAD) progressSetPosition (_currentLoad / (_maxLoad max 1));
					UICTRL(IDC_RscDisplayStore_PROGRESS_NEWLOAD) progressSetPosition 0;
					UICTRL(IDC_RscDisplayStore_PROGRESS_NEWLOAD) ctrlSetTextColor [0.9,0,0,0.6];
				};	
				
				private _load = _classname call HALs_store_fnc_getItemMass;
				private _progress = linearConversion [0, _maxLoad, _currentLoad + (_load * _amount), 0, 1, true];
				private _canAdd = _container canAdd [_classname, _amount];
				private _colour = call {
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
