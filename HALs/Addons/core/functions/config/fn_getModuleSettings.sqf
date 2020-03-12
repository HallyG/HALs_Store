/*
	Function: HALs_fnc_getModuleSettings
	Author: HallyG
	Returns and sets the settings for a module.
	
	Argument(s):
	0: Component name. <STRING>
	
	Return Value:
	File path <STRING>
	
	Example:
	[
		"HALs_money",
		[
			["multiplierDawn", 9, {_this max 1}],
			["multiplierDay", 18, {_this max 1}],
			["multiplierDusk", 9, {_this max 1}],
			["multiplierNight", 30, {_this max 1}]
		]
	] call HALs_fnc_getModuleSettings;
__________________________________________________________________*/
params [
	["_component", "", [""]],
	["_settings", [], [[]]]
];

private _configname = format ["cfg%1", (_component splitString "_") joinstring ""];

{
	_x params ["_setting", "_default", "_code"];
	
	private _value = [missionConfigFile >> "cfgHALsAddons" >> _configname >> _setting, _default] call HALs_fnc_getConfigValue;
	missionNamespace setVariable [
		format ["%1_%2", _component, _setting],
		_value call _code
	];
} count _settings