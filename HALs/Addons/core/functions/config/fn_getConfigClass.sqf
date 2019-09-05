/*
	Function: HALs_fnc_getConfigClass
	Author: HallyG
	Returns the config of an item.
	
	Argument(s):
	0: Item classname <STRING>
	
	Return Value:
	Item config path <CONFIG>
	
	Example:
	(primaryWeapon player) call HALs_fnc_getConfigClass;
__________________________________________________________________*/
call {
	if (isClass (configFile >> "CfgWeapons" >> _this)) exitWith {configFile >> "CfgWeapons" >> _this};
	if (isClass (configFile >> "CfgMagazines" >> _this)) exitWith {configFile >> "CfgMagazines" >> _this};
	if (isClass (configFile >> "CfgGlasses" >> _this)) exitWith {configFile >> "CfgGlasses" >> _this};
	if (isClass (configFile >> "CfgVehicles" >> _this)) exitWith {configFile >> "CfgVehicles" >> _this};
	configNull 
};