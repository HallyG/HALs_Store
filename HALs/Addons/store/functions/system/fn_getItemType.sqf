/*
	Function: HALs_store_fnc_getItemType
	Author: HallyG
	
	
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

private _itemType = [_classname] call BIS_fnc_itemType;
switch (_itemType select 0) do {
	case "Weapon": {2};
	case "Mine": {1};
	case "Magazine": {1};
	case "Item": {4};
	case "Equipment": {if ((_itemType select 1) == "Backpack") then {3} else {4}};
	default {4};
};