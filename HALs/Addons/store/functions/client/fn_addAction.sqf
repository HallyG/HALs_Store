/*
	Function: HALs_store_fnc_addAction
	Author: HallyG
	Adds the "STORE" action to a client.
	
	Argument(s):
	0: Trader <OBJECT>
	
	Return Value:
	None
	
	Example:
	[BUYER, TRADER, "hgun_P07_F", "handguns"] call HALs_store_fnc_addAction;
__________________________________________________________________*/
params [
	["_trader", objNull, [objNull]],
	["_type", ""]
];

if (isNull _trader) exitWith {};

_trader addAction [
	(localize "STR_HALS_STORE_ACTION"), {
		private _trader = param [0, objNull];
		player setVariable ["HALs_store_trader_current", _trader, true];
			
		HALs_store_vehicles = vehicles select {
			typeof _x isKindOf "Car" && 
			{(_x getVariable ["HALs_store_trader_type", ""]) isEqualTo ""} &&
			{_x distance2d _trader <= HALs_store_containerRadius} &&
			{speed _x < 1} && {alive _x} && {local _x}
		};
		HALs_store_vehicles = HALs_store_vehicles apply {
			[typeOf _x, format ["%1 (%2m)", [(configFile >> "cfgVehicles" >> typeOf _x >> "displayName"), ""] call HALs_fnc_getConfigValue, round (_x distance2D _trader)], ""/*"a3\ui_f\data\gui\Rsc\RscDisplayGarage\car_ca.paa"*/, _x]
		};

		createDialog "RscDisplayStore";
	}, [], 10, true, true, "", "alive _target && isNull objectParent _this", 5
];
