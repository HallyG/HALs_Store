/*
	Function: HALs_store_fnc_setTraderStock
	Author: HallyG
	Sets a trader's stock.

	Argument(s):
	0: Trader <OBJECT>
	1: Item Classname <STRING>
	2: Stock change <NUMBER>

	Return Value:
	None

	Example:
	[_trader, _item, 1] call HALs_store_fnc_setTraderStock;
__________________________________________________________________*/
params [
	["_trader", objNull, [objNull]],
	["_classname", "", [""]],
	["_amount", 0, [0]]
];

if (!isServer) exitWith {};
if (_classname isEqualTo "") exitWith {};
if (_amount isEqualTo 0) exitWith {};

private _stocks = _trader getVariable ["HALs_store_trader_stocks", []];
private _idx = _stocks find (toLower _classname);

if (_idx isEqualTo -1) exitWith {};
private _stock = _stocks select (_idx + 1);
_stocks set [(_idx + 1), 0 max (_stock + _amount) min 999999];

_trader setVariable ["HALs_store_trader_stocks", _stocks, true];
