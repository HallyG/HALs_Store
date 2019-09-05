/*
	Function: HALs_fnc_getCompatibleItems
	Author: HallyG
	Returns all items and magazines compatible with a weapon.

	Argument(s):
	0: Weapon classname <STRING>

	Return Value:
	<ARRAY>

	Example:
	(primaryWeapon player) call HALs_fnc_getCompatibleItems;
__________________________________________________________________*/
private _weaponClassName = param [0, "", [""]];
private _weaponConfig = configFile >> "CfgWeapons" >> _weaponClassName;
private _compatibleItems = getArray (_weaponConfig >> "magazines");

{
	if (isClass (_weaponConfig >> "WeaponSlotsInfo" >> _x)) then {
		_compatibleItems append getArray (_weaponConfig >> "WeaponSlotsInfo" >> _x >> "compatibleItems");
	};
} forEach ["CowsSlot", "PointerSlot", "MuzzleSlot", "UnderBarrelSlot"];


{
	if !(_x isEqualTo "this") then {
		_compatibleItems append getArray (_weaponConfig >> _x >> "magazines");
	};
} forEach getArray (_weaponConfig >> "muzzles");

_compatibleItems 