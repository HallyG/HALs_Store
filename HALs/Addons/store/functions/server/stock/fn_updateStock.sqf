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

private _stockAdded = [_trader, _classname, _amount] call HALs_store_fnc_setTraderStock;
if (_stockAdded) then {
	// Fetch all players using the store
	private _players = allPlayers select {(_x getVariable ["HALs_store_trader_current", objNull]) isEqualTo _trader} apply {owner _x};

	[] remoteExecCall ["HALs_store_fnc_update", _players, false];
};
