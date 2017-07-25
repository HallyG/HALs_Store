/*
	Function: HALs_fnc_Log
	Author: HallyG
	Logs an error message to the .rpt file.

	Argument(s):
	0: Prefix <STRING>
	1: Component <STRING>
	2: Title <STRING>
	3: File name <STRING>
	4: Line number <NUMBER>

	Return Value:
	None

	Example:
	[
		"HALs",
		"STORE",
		"Money Value",
		__FILE__,
		__LINE__
	] call HALs_fnc_log;
__________________________________________________________________*/
params [
	["_prefix", "PREFIX", [""]],
	["_component", "COMPONENT", [""]],
	["_title", "", [""]],
	["_file", "", [""]],
	["_lineNum", -1, [0]]
];

diag_log format ["[%1] (%2) ## ERROR ##  (%3) @ %4:%5", _prefix, _component, _title, _file, _lineNum];