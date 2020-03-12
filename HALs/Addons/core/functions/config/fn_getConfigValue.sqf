/*
	Function: HALs_fnc_getConfigValue
	Author: HallyG
	Returns the config entry from the provided config path.
	
	Argument(s):
	0: Config path <CONFIG>
	1: Default value <ANY>, optional
	
	Return Value:
	Config Entry <NUMBER, STRING, ARRAY>
	
	Example:
	[(configFile >> "CfgWeapons" >> primaryWeapon player), ""] call HALs_fnc_getConfigValue;
__________________________________________________________________*/
params [
	["_class", configNull, [configNull]],
	["_return", nil]
];

call {
	if (isText _class) exitWith {getText _class};
	if (isNumber _class) exitWith {getNumber _class};
	if (isArray _class) exitWith  {getArray _class};
	_return
};
