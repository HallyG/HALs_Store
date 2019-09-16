/*
	Function: HALs_store_fnc_getPlayerItems
	Author: HallyG
	Returns an equipped item from the unit.

	Argument(s):
	0: Unit <OBJECT>
    1: Classname <STRING>

	Return Value:
	None

	Example:
	[_unit] call HALs_store_fnc_getPlayerItems;
__________________________________________________________________*/
params [
    ["_unit", objNull, []],
    ["_classname", "", [""]]
];

if (isNull _unit) exitWith {false};
if (_classname isEqualTo "") exitWith {false};

private _classnameLower = toLower _classname;

if (_classnameLower isEqualTo toLower uniform _unit) exitWith {
    removeUniform _unit; true
};

if (_classnameLower isEqualTo toLower vest _unit) exitWith {
    removeVest _unit; true
};

if (_classnameLower isEqualTo toLower backpack _unit) exitWith {
    removeBackpackGlobal _unit; true
};

if (_classnameLower isEqualTo toLower goggles _unit) exitWith {
    removeGoggles _unit; true
};

if (_classnameLower isEqualTo toLower headgear _unit) exitWith {
    removeHeadgear _unit; true
};

if (_classnameLower isEqualTo toLower binocular _unit) exitWith {
    _unit removeWeaponGlobal _classname; true;
};

if (_classnameLower isEqualTo toLower primaryWeapon _unit) exitWith {
    _unit removeWeaponGlobal _classname; true
};

if (_classnameLower isEqualTo toLower secondaryWeapon _unit) exitWith {
    _unit removeWeaponGlobal _classname; true
};

if (_classnameLower isEqualTo toLower handgunWeapon _unit) exitWith {
    _unit removeWeaponGlobal _classname; true
};

// Check item arrays
if (_classnameLower in ((assignedItems _unit) apply {tolower _x})) exitWith {
    _unit unlinkItem _classname; true;
};

// Primary weapon
if (_classnameLower in ((primaryWeaponItems _unit) apply {tolower _x})) exitWith {
    _unit removePrimaryWeaponItem _classname; true;
};

if (_classnameLower in ((primaryWeaponMagazine _unit) apply {tolower _x})) exitWith {
    _unit removePrimaryWeaponItem _classname; true;
};

// Handgun Weapon
if (_classnameLower in ((handgunItems _unit) apply {tolower _x})) exitWith {
    _unit removeHandgunItem _classname; true;
};

if (_classnameLower in ((handgunMagazine _unit) apply {tolower _x})) exitWith {
    _unit removeHandgunItem _classname; true;
};

// Secondary Weapon
if (_classnameLower in ((secondaryWeaponItems _unit) apply {tolower _x})) exitWith {
    _unit removeSecondaryWeaponItem _classname; true;
};

if (_classnameLower in ((secondaryWeaponMagazine _unit) apply {tolower _x})) exitWith {
    _unit removeSecondaryWeaponItem _classname; true;
};



false
