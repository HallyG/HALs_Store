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
if (!isNil "HALs_store_moduleRoot") exitWith {};

HALs_store_moduleRoot = ["HALs_store"] call HALs_fnc_getModuleRoot;
["HALs_store",
	[
		["containerRadius", 10, {_this max 1}],
		["containerTypes", ["LandVehicle", "Air", "Ship"], {_this}],
		["currencySymbol", "¢", {_this}],
		["debug", 0, {_this isEqualTo 1}]
	]
] call HALs_fnc_getModuleSettings;

[] call HALs_store_fnc_getItemStats;
