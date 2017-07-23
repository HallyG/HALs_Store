/*
	Function: HALs_fnc_roundNumber
	Author: HallyG
	Rounds a number to the desired decimal place.
	
	Argument(s):
	0: Number <NUMBER>
	1: Decimal place <NUMBER>

	Return Value:
	<NUMBER>

	Example:
	[-1.233, 1] call HALs_fnc_roundNumber;
__________________________________________________________________*/
params [
    ["_number", 1, [0]],
    ["_decimalPlaces", 1, [0]]
];

parseNumber (_number toFixed _decimalPlaces);