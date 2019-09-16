/*
	Function: HALs_store_fnc_getPlayerCargo
	Author: HallyG
	Returns the items equipped by a unit and those stored in its uniform, vest
    and backpack.

	Argument(s):
	0: Unit <OBJECT>

	Return Value:
	<ARRAY>

	Example:
	[_unit] call HALs_store_fnc_getPlayerCargo;
__________________________________________________________________*/
params [
    ["_unit", objNull, []]
];

private _list = [];
if (isNull _unit) exitWith {_list};

_list append ([_unit] call HALs_store_fnc_getPlayerItems);
_list append ([uniformContainer _unit] call HALs_store_fnc_getContainerItems);
_list append ([vestContainer _unit] call HALs_store_fnc_getContainerItems);
_list append ([backpackContainer _unit] call HALs_store_fnc_getContainerItems);

_list
