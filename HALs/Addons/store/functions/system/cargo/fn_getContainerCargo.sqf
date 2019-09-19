/*
	Function: HALs_store_fnc_getContainerCargo
	Author: HallyG
	Returns all items in the inventory of a container.

	Argument(s):
	0: Container object <OBJECT>

	Return Value:
	<ARRAY>

	Example:
	[_container] call HALs_store_fnc_getContainerCargo;
__________________________________________________________________*/
params [
    ["_container", objNull, [objNull]]
];

if (isNull _container) exitWith {
    [[], [], [], []]
};

private _magazines = magazinesAmmoCargo _container;
private _weapons = weaponsItemsCargo _container;
private _itemsCargo = getItemCargo _container;
private _containerClassNames = (everyContainer _container) apply {_x select 0};
private _items = [];

if (count _itemsCargo > 0) then {
    {
        if !(_x in _containerClassNames) then {
            _items pushBack [_x, (_itemsCargo select 1) select _forEachIndex];
        };
    } forEach (_itemsCargo select 0);
};

private _containerItems = [];
private _everyContainer = everyContainer _container;
{
    _x params ["_classname", "_obj"];

    _containerItems pushBack [_classname, _obj call HALs_store_fnc_getContainerCargo];
} forEach _everyContainer;

[_magazines, _items, _weapons, _containerItems]
