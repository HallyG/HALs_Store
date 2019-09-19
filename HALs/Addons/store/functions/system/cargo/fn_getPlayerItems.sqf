/*
	Function: HALs_store_fnc_getPlayerItems
	Author: ExileMod, HallyG
	Returns all items equipped by a unit.

	Argument(s):
	0: Unit <OBJECT>

	Return Value:
	<ARRAY>

	Example:
	[_unit] call HALs_store_fnc_getPlayerItems;
__________________________________________________________________*/
params [
    ["_unit", objNull, []]
];

private _items = [];
if (isNull _unit) exitWith {_items};

private _slots = [];
_slots pushBack [uniform _unit, vest _unit, backpack _unit];
_slots pushBack [primaryWeapon _unit];
_slots pushBack primaryWeaponMagazine _unit;
_slots pushBack primaryWeaponItems _unit;
_slots pushBack [secondaryWeapon _unit];
_slots pushBack secondaryWeaponMagazine _unit;
_slots pushBack secondaryWeaponItems _unit;
_slots pushBack [handgunWeapon _unit];
_slots pushBack handgunMagazine _unit;
_slots pushBack handgunItems _unit;
_slots pushBack [goggles _unit, headgear _unit];
_slots pushBack assignedItems _unit;
{
	{_items pushBack _x} forEach (_x select {count _x > 0});
} forEach _slots;

_items
