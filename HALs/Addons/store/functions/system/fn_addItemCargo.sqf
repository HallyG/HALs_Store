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
if (!isServer) exitWith {};

params [
	["_container", objNull, [objNull]],
	["_classname", "", [""]],
	["_amount", 1, [0]]
];

if (_amount < 1) exitWith {};
if (isNull _container) exitWith {};

switch (toUpper (([_classname] call BIS_fnc_itemType) select 0)) do {
	case "MINE";
	case "MAGAZINE": {
		_container addMagazineCargoGlobal [_classname, _amount];
	};
	case "ITEM": {
		_container addItemCargoGlobal [_classname, _amount];
	};
	case "WEAPON": {
		_container addWeaponCargoGlobal [_classname, _amount];
	};
	case "EQUIPMENT": {
		if (isClass (configFile >> "CfgVehicles" >> _classname)) then {
			_container addBackpackCargoGlobal [_classname, _amount];
		} else {
			_container addItemCargoGlobal [_classname, _amount];
		};
	};
};