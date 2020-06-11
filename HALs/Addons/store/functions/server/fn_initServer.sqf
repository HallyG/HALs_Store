/*
	Function: HALs_store_fnc_initServer
	Author: HallyG
	Server initialisation.

	Argument(s):
	0: None

	Return Value:
	None

	Example:
	[] call HALs_store_fnc_initServer;
__________________________________________________________________*/
if (!isServer) exitWith {};

[
	["CfgHALsStore"],
	"HALs_store_",
	[
		["containerRadius", 10, {_this max 1}, true],
		["containerTypes", ["LandVehicle", "Air", "Ship"], {_this}, true],
		["currencySymbol", "¢", {_this}, true],
		["sellFactor", 1, {_this max 0 min 1}, true],
		["debug", 0, {_this isEqualTo 1}]
	]
] call HALs_fnc_getModuleSettings;