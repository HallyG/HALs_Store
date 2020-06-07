/*
	Function: HALs_store_fnc_addActionTrader
	Author: HallyG
	RemoteExec BIS_fnc_holdActionAdd to all clients.

	Argument(s):
	0: Trader <OBJECT>

	Return Value:
	None

	Example:
	[unit1] call HALs_store_fnc_addActionTrader;
__________________________________________________________________*/
params [
	["_trader", objNull, [objNull]]
];

if (!isServer) exitWith {};
if (isNull _trader) exitWith {};
if (isNil {_trader getVariable "HALs_store_trader_type"}) exitWith {};

[
	_trader,
	_trader getVariable ["HALs_store_name", localize "STR_HALS_STORE_ACTION"],
	"\a3\Ui_F_Oldman\Data\IGUI\Cfg\HoldActions\holdAction_market_ca.paa",
	"\a3\Ui_F_Oldman\Data\IGUI\Cfg\HoldActions\holdAction_market_ca.paa",
	"alive _target && _this distance _target < 3 && isNull objectParent _this",
	"_this distance _target < 3",
	{},
	{},
	{
		params ["_trader", "_caller", "_actionId", "_arguments"];
		[_trader, _caller] call HALs_store_fnc_openStore;
	}, {}, [], 0.5, nil, false, false
] remoteExecCall ["BIS_fnc_holdActionAdd", 0, _trader];










