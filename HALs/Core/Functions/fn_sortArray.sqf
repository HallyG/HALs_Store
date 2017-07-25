/*
	Function: HALs_fnc_sortArray
	Author: HallyG
	Sorts an array by applying given code to each element.

	Argument(s):
	0: Unsorted array <ARRAY>
	1: Sorting code (returns NUMBER or STRING) <CODE>
	2: Ascending? <BOOL>

	Return Value:
	Sorted array <ARRAY>

	Example:
	[[player, ammo1], {_x distance [0,0,0]}, true] call HALs_fnc_sortArray;
__________________________________________________________________*/
params [
	["_array", [], [[]]],
	["_function", {}, [{}]],
	["_order", true, [true]]
];

if !(_function isEqualTo {}) exitWith {
	_newArray = _array apply {
		[call _function, _x]
	};

	_newArray sort _order;
	_newArray apply {_x select 1}
};

_array = +_array;
_array sort _order;
_array
