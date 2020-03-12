/*
	Function: HALs_fnc_numberToString
	Author: Karel Moricky, modified by HallyG
	Converts the provided number in to a string (avoiding scientific notation).

	Argument(s):
	0: Integer <NUMBER>

	Return Value:
	<STRING>

	Example:
	123400 call HALs_fnc_numberToString;
__________________________________________________________________*/
params [
	["_number", 0, [0]]
];

private _digits = [_number] call BIS_fnc_numberDigits;
private _digitsCount = count _digits - 1;
private _modBase = _digitsCount % 3;

{
	_digits set [
		_forEachIndex,
		format [
			["%1", "%1,"] select ((_forEachIndex - _modBase) % 3 isEqualTo 0 && {_forEachIndex != _digitsCount}),
			_x
		]
	];
} forEach _digits;

_digits joinString ""
