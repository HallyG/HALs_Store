/*
	Function: HALs_money_fnc_init
	Author: HallyG

	Example:
	[] spawn HALs_money_fnc_initModule;
__________________________________________________________________*/
if (!hasInterface) exitWith {};
if (!isNil "HALs_money_moduleRoot") exitWith {};

HALs_money_moduleRoot = ["HALs_money"] call HALs_fnc_getModuleRoot;
["HALs_money",
	[
		["startingFunds", 1000, {_this max 0 min 999999}],
		["startingBalance", 0, {_this max 0 min 999999}],
		["debug", 0, {_this isEqualTo 1}]
	]
] call HALs_fnc_getModuleSettings;

[player, HALs_money_startingFunds] call HALs_money_fnc_addFunds;
