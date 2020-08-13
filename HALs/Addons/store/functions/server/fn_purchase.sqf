/*
	Function: HALs_store_fnc_purchase
	Author: HallyG
	Handles the purchase transcations on the server.

	Argument(s):
	0: Player <OBJECT>
	1: Item Classname <STRING>
	3: Item price <NUMBER>
	4: Number of items <NUMBER>
	5: Container <OBJECT>
	6: Equip on purchase <BOOLEAN>

	Return Value:
	None

	Example:
	[player, "hgun_P07_F", 100, 5, vestContainer player] call HALs_store_fnc_purchase;
__________________________________________________________________*/
params [
	["_unit", objNull, [objNull]],
	["_classname", "", [""]],
	["_price", 0, [0]],
	["_amt", 0, [0]],
	["_container", objNull, [objNull]],
	["_equip", false, [true]]
];

if (!isServer) exitWith {};
if (isNull _unit) exitWith {};
if (!alive _unit) exitWith {};
if (_amt < 1) exitWith {};
if (_price < 0) exitWith {};

try {
	// Fetch current trader
	private _trader = _unit getVariable ["HALs_store_trader_current", objNull];
	if (isNull _trader) then {throw [""]};

	// Fetch stock
	private _stock = [_trader, _classname] call HALs_store_fnc_getTraderStock;
	if (_stock < 1) then {throw [localize "STR_HALS_STORE_ITEM_UNAVALIABLE"]};

	// Calculate how many items the container can actually hold
	private _amtMax = [_container, _classname, _amt, true] call HALs_store_fnc_canAddItem;
	if (_amtMax > _stock) then {throw [localize "STR_HALS_STORE_ITEM_OUTOFSTOCK"]};

	// Calculate predicted cost
	private _price = _price max 0;
	private _money = [_unit] call HALs_money_fnc_getFunds;
	private _sale = 0 max (1 - (_trader getVariable ["HALs_store_trader_sale", 0])) min 1;
	private _total = _price * _sale * _amt;
	if (_total > _money) then {throw [localize "STR_HALS_STORE_ITEM_TOOEXPENSIVE"]};

	// Variable to track how many items were added
	private _amtAdded = 0;

	// Equip item as required
	if (_equip && {[_unit, _classname] call HALs_store_fnc_canEquipItem}) then {
		private _equipped = [_unit, _classname] call HALs_store_fnc_equipItem;

		// Item was equipped
		if (_equipped) then {
			_amtAdded = _amtAdded + 1;

			// Additional items were requested
			if ((_amt - 1) > 0) then {
				// Can't add the additional items
				if (_amtMax isEqualTo 0) then {
					private _msg = format ["%1 %2", localize "STR_HALS_STORE_ITEM_NOCARGOSPACE", "for additional items!"];

					[_msg, "FD_CP_NOT_CLEAR_F"] remoteExecCall ["HALs_store_fnc_systemChat", _unit];
				} else {
					private _amtToAdd = _amtMax min (_amt - 1);
					_amtAdded = _amtAdded + _amtToAdd;

					[_container, _classname, _amtToAdd] call HALs_store_fnc_addItemCargo;
				};
			};
		} else {
			throw [localize "STR_HALS_STORE_ITEM_NOEQUIP"]
		};
	} else {
		if (_amtMax isEqualTo 0) then {
			throw [localize "STR_HALS_STORE_ITEM_NOCARGOSPACE"]
		} else {
			_amtAdded = _amtAdded + _amtMax;
			[_container, _classname, _amtMax] call HALs_store_fnc_addItemCargo;
		};
	};

	// Calculate actual cost
	_total = _price * _sale * _amtAdded;

	// Update unit's funds and trader's stock
	[_trader, _classname, -_amtAdded] call HALs_store_fnc_updateStock;
	[_unit, -_total] call HALs_money_fnc_addFunds;

	// Create message to display to _unit
	private _message = format [
		"x%1 %2(s) %3 for %4 %5.", _amtAdded,
		[(_classname call HALs_fnc_getConfigClass) >> "displayName", ""] call HALs_fnc_getConfigValue,
		localize "STR_HALS_STORE_ITEM_PURCHASED",
		_total, HALs_store_currencySymbol
	];
	
	// Log purchase
	if (HALs_store_debug) then {
		private _log = format ["%2(%1) %3 from (%4).", name _unit, getPlayerUID _unit, _message, _trader];
		[_log] call HALs_fnc_log;
	};

	throw [_message, "FD_CP_CLEAR_F"];
} catch {
	_exception params [
		["_message", ""],
		["_sound", "FD_CP_NOT_CLEAR_F", [""]]
	];

	if (count _message > 0) then {
		[_message, _sound] remoteExecCall ["HALs_store_fnc_systemChat", _unit];
	};
};
