/*
	@todo
	Function: HALs_store_fnc_openStore
	Author: HallyG
	Open store action addAction on client.

	Argument(s):
	0: Trader <OBJECT>
	1: Player <OBJECT>

	Return Value:
	None

	Example:
	[unit1, player] call HALs_store_fnc_openStore;
__________________________________________________________________*/
params [
	["_trader", objNull, [objNull]],
	["_caller", objNull, [objNull]]
];

if (!hasInterface) exitWith {};
if (isNull _trader || isNull _caller) exitWith {};
if (isNil {_trader getVariable "HALs_store_trader_type"}) exitWith {};

_caller setVariable ["HALs_store_trader_current", _trader, true];

createDialog "RscDisplayStore";










