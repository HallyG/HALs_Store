/*
	Function: HALs_store_fnc_updateStock
	Author: HallyG
	Updates a store's stock for the desired item.

	Argument(s):
	0: Trader <OBJECT>
	1: Item classname <STRING>
	2: Stock change <NUMBER>

	Return Value:
	None

	Example:
	[ammo1, "ItemMap", 1] call HALs_store_fnc_updateStock;
__________________________________________________________________*/
params [
	["_trader", objNull, [objNull]],
	["_classname", "", [""]],
	["_amount", 0, [0]]
];

if (!isServer) exitWith {};
if (isNull _trader) exitWith {};
if (_classname isEqualTo "") exitWith {};

private _stock = [_trader, _classname] call HALs_store_fnc_getTraderStock;
private _categories = getArray (missionConfigFile >> "cfgHALsAddons" >> "cfgHALsStore" >> "stores" >> _trader getVariable ["HALs_store_trader_type", ""] >> "categories");
if (_stock < 0) exitWith {};

[_trader, _classname, _amount] call HALs_store_fnc_setTraderStock;
[objNull, _trader, _categories] remoteExecCall ["HALs_store_fnc_update", 0];

if (HALs_store_debug) then {
	diag_log format ["[HALs] (STORE) ## STOCK UPDATED ## (%4)  %1%2 %3", ["+", ""] select (_amount < 0), _amount, _classname, _trader];
};
