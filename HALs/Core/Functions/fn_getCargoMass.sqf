/*
	Function: HALs_fnc_getCargoMass
	Author: L-H, edited by commy2, rewritten by joko // Jonas
	Calculates the mass of an item or of all the items in a container.

	Argument(s):
	0: Container <OBJECT>

	Return Value:
	<NUMBER>

	Example:
	(vestContainer player) call HALs_fnc_getCargoMass;
__________________________________________________________________*/
params [
	["_object", objNull, [objNull]]
];

private _totalWeight = 0;
{
	_x params ["_items", "_getConfigCode"];
	_items params ["_item", "_count"];
	{
		_totalWeight = _totalWeight + (getNumber ((call _getConfigCode) >> "mass") * (_count select _forEachIndex));
	} forEach _item;
	true
} count [
	[getMagazineCargo _object, {configFile >> "CfgMagazines" >> _x}],
	[getBackpackCargo _object, {configFile >> "CfgVehicles" >> _x}],
	[getItemCargo _object, {configFile >> "CfgWeapons" >> _x >> "ItemInfo"}],
	[getWeaponCargo _object, {configFile >> "CfgWeapons" >> _x >> "WeaponSlotsInfo"}]
];

_totalWeight
