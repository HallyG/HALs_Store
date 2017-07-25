/*
	Function: HALs_store_fnc_setTraderStock
	Author: HallyG
	Sets a trader's stock.
	
	Argument(s):
	0: Trader <OBJECT>
	1: Item Classname <STRING>
	2: Stock change <NUMBER>
	
	Return Value:
	<NUMBER>
	
	Example:
	[_trader, _item, 1] call HALs_store_fnc_setTraderStock;
__________________________________________________________________*/
if (!isServer) exitWith {};

params [
	["_trader", objNull, [objNull]],
	["_classname", "", [""]],
	["_amount", 0, [0]]
];

private _stocks = _trader getVariable ["HALs_store_trader_stocks", []];
private _classes = _trader getVariable ["HALs_store_trader_classes", []];
private _selection = _classes find toLower _classname;

if (_selection isEqualTo -1) exitWith {};
private _stock = _stocks select _selection;

_stocks set [_selection, ((_stock + _amount) max 0) min 999999];
_trader setVariable ["HALs_store_trader_stocks", _stocks, true];