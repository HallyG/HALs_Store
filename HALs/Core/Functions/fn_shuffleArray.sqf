/*
	Function: HALs_fnc_shuffleArray
	Author: Killzone_Kid
	Shuffles an array's contents into a random order.

	Argument(s):
	0: Array to shuffle <ARRAY>
	
	Return Value:
	Shuffled Array <ARRAY>
	
	Example:
	[1,2,3,4] call HALs_fnc_shuffleArray;
__________________________________________________________________*/
private _count = count _this;

for "_n" from 1 to _count do {
	_this pushBack (_this deleteAt floor random _count);
};

_this 