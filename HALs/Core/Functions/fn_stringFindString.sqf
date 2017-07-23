/*
	Function: HALs_fnc_stringFindString
	Author: HallyG
	Find a string within another string.
	
	Argument(s):
	0: String in which to search <STRING>
	1: String to search for <STRING>
	2: Case sensitive <BOOL>, optional
	
	Return Value:
	String Found <BOOL>
	
	Example:
	["ABCDEF", "h", true] call HALs_fnc_stringFindString;
__________________________________________________________________*/
params [
	["_haystack", "", [""]],
	["_needle", "", [""]],
	["_caseSensitive", false, [true]]
];

[
	(((toUpper _haystack) find (toUpper _needle)) > -1), 
	((_haystack find _needle) > -1) 
] select _caseSensitive;

