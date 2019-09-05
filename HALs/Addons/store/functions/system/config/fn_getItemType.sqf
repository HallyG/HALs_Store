/*
	Function: HALs_store_fnc_getItemType
	Author: HallyG
	Returns an item's enumerated type.

	Argument(s):
	0: Item Classname <STRING>

	Return Value:
	<NUMBER>

	Example:
	[_item] call HALs_store_fnc_getItemType;
__________________________________________________________________*/
params [
	['_classname', "", [""]]
];

private _type = [_classname] call BIS_fnc_itemType;
switch (_type select 0) do {
	case "Weapon": {2};
	case "Mine": {1};
	case "Magazine": {1};
	case "Item": {4};
	case "Equipment": {[4, 3] select ((_type#1) isEqualTo "Backpack")};
	default {4};
};
