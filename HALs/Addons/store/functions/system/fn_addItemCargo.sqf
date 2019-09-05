/*
	Function: HALs_store_fnc_addItemCargo
	Author: HallyG
	Creates new items and stores them in given container.

	Argument(s):
	0: Classname of the item to store in container <STRING>
	1: Container object <OBJECT>

	Return Value:
	None

	Example:
	[_holder, "acc_flashlight", 1] call HALs_store_fnc_addItemCargo;
__________________________________________________________________*/
params [
	["_container", objNull, [objNull]],
	["_classname", "", [""]],
	["_amount", 1, [0]]
];

if (!isServer) exitWith {};
if (isNull _container) exitWith {};
if (_classname isEqualTo "") exitWith {};
if (_amount < 1) exitWith {};

switch ([_classname] call HALs_store_fnc_getItemType) do {
	case 1: {_container addMagazineCargoGlobal [_classname, _amount]};
	case 2: {_container addWeaponCargoGlobal [_classname, _amount]};
	case 3: {_container addBackpackCargoGlobal [_classname, _amount]};
	case 4: {_container addItemCargoGlobal [_classname, _amount]};
	default {};
};
