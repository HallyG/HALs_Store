/*
	todo
	Function: HALs_store_fnc_canEquipItem
	Author: Exile Mod, HallyG
	Checks if an item can be equipped by a unit.

	Argument(s):
	0: Unit <OBJECT>
	1: Item Classname <STRING>

	Return Value:
	<BOOL>

	Example:
	[player, "acc_flashlight"] call HALs_store_fnc_canEquipItem;
__________________________________________________________________*/
params [
	["_unit", objNull],
	["_classname", ""]
];

private _classname = toLower _classname;
private _canAdd = false;
([_classname] call BIS_fnc_itemType) params ["_itemCategory", "_itemType"];

switch (_itemCategory) do {
	case "Weapon": {
		_weaponType = getNumber( configFile >> "CfgWeapons" >> _classname >> "type");
		switch (_weaponType) do {
			case 1: {_canAdd = ((primaryWeapon _unit) isEqualTo "");};
			case 4: {_canAdd = ((secondaryWeapon _unit) isEqualTo "");};
			case 2: {_canAdd = ((handgunWeapon _unit) isEqualTo "");};
		};
	};
	case "Equipment": {
		switch (_itemType) do {
			case "Glasses": {_canAdd = ((goggles _unit isEqualTo ""));};
			case "Headgear": {_canAdd = ((headgear _unit) isEqualTo "");};
			case "Vest": {_canAdd = ((vest _unit) isEqualTo "");};
			case "Uniform": {_canAdd = ((uniform _unit) isEqualTo "");};
			case "Backpack": {_canAdd = ((backpack _unit) isEqualTo "");};
		};
	};
	case "Magazine": {
		{
			if !((_x select 0) isEqualTo "") then {
				if ((_x select 1) isEqualTo []) then {
					_compatibleWeaponItems = ((_x select 0) call HALs_store_fnc_getCompatibleItems) apply {toLower _x};
					if (_classname in _compatibleWeaponItems) then {
						_canAdd = true;
					};
				};
			};
			if (_canAdd) exitWith {};
		} forEach [
			[primaryWeapon _unit, primaryWeaponMagazine _unit],
			[secondaryWeapon _unit, secondaryWeaponMagazine _unit],
			[handgunWeapon _unit, handgunMagazine _unit]
		];
	};
	case "Item": {
		switch (_itemType) do {
			case "AccessoryMuzzle",
			case "AccessoryPointer",
			case "AccessorySights",
			case "AccessoryBipod": {
				_attachmentSlotIndex = switch (_itemType) do {
					case "AccessoryMuzzle": {0};
					case "AccessoryPointer": {1};
					case "AccessorySights": {2};
					case "AccessoryBipod": {3};
				};
				{
					if !((_x select 0) isEqualTo "") then {
						if (((_x select 1) select _attachmentSlotIndex) isEqualTo "") then {
							_compatibleWeaponItems = ((_x select 0) call HALs_store_fnc_getCompatibleItems) apply {toLower _x};
							if (_classname in _compatibleWeaponItems) then {
								_canAdd = true;
							};
						};
					};
					if (_canAdd) exitWith {};
				} forEach [
					[primaryWeapon _unit, primaryWeaponItems _unit],
					[secondaryWeapon _unit, secondaryWeaponItems _unit],
					[handgunWeapon _unit, handgunItems _unit]
				];
			};
			case "NVGoggles": {
				if ((hmd _unit) isEqualTo "") then {
					_canAdd = true;
				};
			};
			case "Glasses",
			case "LaserDesignator",
			case "Binocular": {
				if ((binocular _unit) isEqualTo "") then {
					_canAdd = true;
				};
			};
			default {
				if !(_classname in ((assignedItems _unit) apply {toLower _x})) then {
					_canAdd = true;
				};
			};
		};
	};
};

_canAdd
