/*
	Function: HALs_store_fnc_initModule;
	Author: HallyG
	Init function for the Store module.
	
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
HALs_store_debug = ([missionConfigFile >> "cfgHALsStore" >> "serverDebug", 0] call HALs_fnc_getConfigValue) isEqualTo 1;

HALs_store_containerRadius = ([missionConfigFile >> "cfgHALsStore" >> "containerRadius", 10] call HALs_fnc_getConfigValue) max 1;
HALs_store_containerTypes = ([missionConfigFile >> "cfgHALsStore" >> "containerTypes", ["LandVehicle", "Air", "Ship"]] call HALs_fnc_getConfigValue);
	
HALs_store_gui_blur = ppEffectCreate ["DynamicBlur", 999];
HALs_store_gui_blur ppEffectEnable true;

