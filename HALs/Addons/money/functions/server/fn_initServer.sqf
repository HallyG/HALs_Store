/*
	Function: HALs_money_fnc_initServer
	Author: HallyG
	Server initialisation.

	Arguments(s):
	0: None

	Return Value:
	None

	Example:
	[] call HALs_money_fnc_initServer;
__________________________________________________________________*/
if (!isServer) exitWith {};
if (!isNil "HALs_money_debug") exitWith {};

[
	["CfgHALsMoney"],
	"HALs_money_",
	[
		["startingFunds", 1000, {_this max 0}, true],
		["oldManItemsPrice", [50, 150, 300, 600], {_this apply {_x max 0}}, true],
		["debug", 0, {_this isEqualTo 1}]
	]
] call HALs_fnc_getModuleSettings;
