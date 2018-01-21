/*
	Function: HALs_fnc_log
	Author: HallyG
	Logs an message, from a function, to the .rpt file.

	Argument(s):
	0: Message <STRING>

	Return Value:
	None

	Example:
	["TEST"] call HALs_fnc_log;
__________________________________________________________________*/
params [
	["_message", "", [""]]
];

_scriptName = if (isNil "_fnc_scriptName") then {""} else {_fnc_scriptName};

diag_log format [
	"%1/HALs_fnc_log:%2~ %3",
	profileName,
	format [[" [%1] ", " "] select (_scriptName isEqualTo ""), _scriptName],
	_message
];
