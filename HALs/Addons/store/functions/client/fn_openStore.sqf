/*
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

private _vehicles = nearestObjects [_trader, HALs_store_containerTypes, HALs_store_containerRadius, true];
_vehicles = _vehicles select {local _x && {speed _x < 1} && {alive _x}};
_vehicles = _vehicles select {isNil {_x getVariable "HALs_store_trader_type"}};

HALs_store_vehicles = _vehicles apply {
	[
		typeOf _x,
		format ["%1 (%2m)", getText(configFile >> "cfgVehicles" >> typeOf _x >> "displayName"), round (_x distance2D _trader)],
		""/*"a3\ui_f\data\gui\Rsc\RscDisplayGarage\car_ca.paa"*/,
		_x
	]
};

createDialog "RscDisplayStore";










