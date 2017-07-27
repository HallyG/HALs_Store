/*
	Function: HALs_store_fnc_purchase
	Author: HallyG
	Handles item purchasing.
	
	Argument(s):
	0: Buyer 			<OBJECT>
	2: Category 		<STRING>
	3: Item classname	<STRING>
	4: Item Price 		<NUMBER>
	5: Number of items 	<NUMBER>
	
	Return Value:
	None
	
	Example:
	[player, "hgun_P07_F", 50, 10, vestContainer player] call HALs_store_fnc_purchase;
__________________________________________________________________*/
if !(isServer) exitWith {};
params [
	["_unit", objNull, [objNull]],
	["_classname", "", [""]],
	["_price", 0, [0]],
	["_amount", 0, [0]],
	["_container", objNull, [objNull]],
	["_equip", false, [true]]
];

if (isNull _unit) exitWith {}; 
if (!alive _unit) exitWith {}; 
if (isNull _container) exitWith {}; 
if (isNull (_unit getVariable ["HALs_store_trader_current", objNull])) exitWith {};
if (isNull (_classname call HALs_fnc_getConfigClass)) exitWith {};
if (_amount <= 0) exitWith {};

try {
	private _trader = _unit getVariable ["HALs_store_trader_current", objNull];
	private _stock = [_trader, _classname] call HALs_store_fnc_getTraderStock;
	private _money = [_unit] call HALs_money_fnc_getFunds;
	private _amount = ([_container, _classname, _amount, true] call HALs_store_fnc_canAddItem);
	private _categories = (_trader getVariable ["HALs_store_trader_categories", []]) select {isClass (missionConfigFile >> "cfgHALsStore" >> "categories" >> _x >> _classname)};
	private _sale = (1 - (_trader getVariable ["HALs_store_trader_sale", 0])) min 1 max 0;

	if (_stock <= 0) then {
		throw [localize "STR_HALS_STORE_ITEM_UNAVALIABLE"] //["Item unavaliable."]
	};
	
	if (_amount > _stock) then {
		throw [localize "STR_HALS_STORE_ITEM_OUTOFSTOCK"] // throw ["Insufficient stock."]
	};
	
	if (_price * _sale * _amount > _money) then {
		throw [localize "STR_HALS_STORE_ITEM_TOOEXPENSIVE"] //throw ["Insufficient funds."]
	};
	
	if (_amount isEqualTo 0) then {
		throw [localize "STR_HALS_STORE_ITEM_NOCARGOSPACE"] //throw ["Insufficient cargo space."]
	};
	
	if (_equip && {[_unit, _classname] call HALs_store_fnc_canEquipItem}) then {
		_added = [_unit, _classname] call HALs_store_fnc_equipItem;
		
		if (!_added) then {
			throw [localize "STR_HALS_STORE_ITEM_NOEQUIP"];
		};
		
		[_container, _classname, _amount - 1] call HALs_store_fnc_addItemCargo;
	} else {
		[_container, _classname, _amount] call HALs_store_fnc_addItemCargo;
	};
	
	[_trader, _classname, -_amount] call HALs_store_fnc_setTraderStock;
	[_unit, - (_price * _amount * _sale)] call HALs_money_fnc_addFunds;	
	[_unit, _trader, _categories] remoteExecCall ["HALs_store_fnc_update", 0];
	
	
	private _message = format ["x%1 %2(s)", _amount, [(_classname call HALs_fnc_getConfigClass) >> "displayName", ""] call HALs_fnc_getConfigValue];
	
	if (HALs_store_debug) then {
		diag_log format ["[HALs] (STORE) ## PURCHASE ## (%4)  %1 (%2)  %3", getPlayerUID _unit, name _unit, _message, _trader];
	};
	throw [_message + " " + localize "STR_HALS_STORE_ITEM_PURCHASED", "FD_CP_CLEAR_F"];
	
} catch {
	_exception params [
		"_message",
		["_sound", "FD_CP_NOT_CLEAR_F", [""]]
	];
	
	[_message, _sound] remoteExecCall ["HALs_store_fnc_systemChat", _unit];
};
