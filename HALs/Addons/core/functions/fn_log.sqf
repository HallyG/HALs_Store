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
	["_msg", "", [""]],
	["_line", -1, [0]]
];

private _scriptName = if (isNil "_fnc_scriptName") then {""} else {_fnc_scriptName};
private _log = if (isMultiplayer) then {profileName + "/" + _scriptName} else {_scriptName};
_log = if (_line > -1) then {format ["%1(%2)", _scriptName, _line]} else {_scriptName};

if (count _log > 0) then {
	diag_log format ["[%1]: %2", _log, _msg];
} else {
	diag_log format ["%1", _msg];
}
