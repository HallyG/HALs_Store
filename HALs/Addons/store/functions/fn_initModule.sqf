/*
	Function: HALs_store_fnc_initModule;
	Author: HallyG
	Store Module init.

	Argument(s):
	None

	Return Value:
	None

	Example:
	[] call HALs_store_fnc_initModule;
__________________________________________________________________*/
if (!hasInterface) exitWith {};
if (!isNil "HALs_store_moduleInit") exitWith {};
HALs_store_moduleInit = true;

["HALs_store",
	[
		["containerRadius", 10, {_this max 1}],
		["containerTypes", ["LandVehicle", "Air", "Ship"], {_this}],
		["currencySymbol", "¢", {_this}],
		["sellFactor", 1, {_this max 0 min 1}],
		["debug", 0, {_this isEqualTo 1}]
	]
] call HALs_fnc_getModuleSettings;

[] call HALs_store_fnc_getItemStats;
