/*
	Function: HALs_money_fnc_init
	Author: HallyG

	Example:
	[] spawn HALs_money_fnc_initModule;
__________________________________________________________________*/
if (!hasInterface) exitWith {};
if (!isNil "HALs_money_moduleRoot") exitWith {};

HALs_money_moduleRoot = ["HALs_money"] call HALs_fnc_getModuleRoot;
HALs_money_startingFunds = ([missionConfigFile >> "cfgHALsMoney" >> "startingFunds", 0] call HALs_fnc_getConfigValue) max 0 min 999999;

[player, HALs_money_startingFunds] call HALs_money_fnc_addFunds;
