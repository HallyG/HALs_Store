/*
	Function: HALs_store_fnc_canAddItem
	Author: HallyG
	Checks if the given item(s) can be added to a container.

	Argument(s):
	0: Container to check <OBJECT>
	1: Item Classname <STRING>
	2: Number of items to add <NUMBER>
	3: Return maximum items which can be added <BOOL>, optional

	Return Value:
	<BOOLEAN>

	Example:
	[player, "acc_flashlight", 1] call HALs_store_fnc_canAddItem;
__________________________________________________________________*/
params [
	["_container", objNull, [objNull]],
	["_classname", "", [""]],
	["_amount", 1, [1]],
	["_findMax", false, [false]]
];

if (_findMax) exitWith {
	if (isNull _container) exitWith {0};
	if (_classname isEqualTo "") exitWith {0};
	if (_amount < 1) exitWith {0};

	private _amtToAdd = 0;
	for [{private _i = 1}, {_container canAdd [_classname, _i] && {_i <= _amount}}, {_i = _i + 1}] do {
		_amtToAdd = _i;
	};

	_amtToAdd
};

if (isNull _container) exitWith {false};
if (_classname isEqualTo "") exitWith {false};
if (_amount < 1) exitWith {false};

_container canAdd [_classname, _amount]
