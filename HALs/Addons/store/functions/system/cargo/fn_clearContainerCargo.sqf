/*
	Function: HALs_store_fnc_clearContainerCargo
	Author: HallyG
	Removes all items from a container.

	Argument(s):
	0: Container object <OBJECT>

	Return Value:
	None

	Example:
	[_container] call HALs_store_fnc_clearContainerCargo;
__________________________________________________________________*/
params [
    ["_container", objNull, [objNull]]
];

if (isNull _container) exitWith {};

clearItemCargoGlobal _container;
clearMagazineCargoGlobal _container;
clearWeaponCargoGlobal _container;
clearBackpackCargoGlobal _container;
