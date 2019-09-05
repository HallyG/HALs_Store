/*
	Function: HALs_fnc_getConfigClass
	Author: HallyG
	Returns the config path of an item.

	Argument(s):
	0: Item classname <STRING>

	Return Value:
	Config path <CONFIG>

	Example:
	(primaryWeapon player) call HALs_fnc_getConfigClass;
__________________________________________________________________*/
params [
	["_configName", "", [""]]
];

call {
	if (isClass (configFile >> "CfgWeapons" >> _configName)) exitWith {configFile >> "CfgWeapons" >> _this};
	if (isClass (configFile >> "CfgMagazines" >> _configName)) exitWith {configFile >> "CfgMagazines" >> _this};
	if (isClass (configFile >> "CfgGlasses" >> _configName)) exitWith {configFile >> "CfgGlasses" >> _this};
	if (isClass (configFile >> "CfgVehicles" >> _configName)) exitWith {configFile >> "CfgVehicles" >> _this};
	configNull
};
