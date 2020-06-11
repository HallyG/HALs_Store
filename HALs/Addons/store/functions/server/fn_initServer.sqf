/*
	Function: HALs_store_fnc_initServer
	Author: HallyG
	Server initialisation.

	Argument(s):
	0: None

	Return Value:
	None

	Example:
	[] call HALs_store_fnc_initServer;
__________________________________________________________________*/
if (!isServer) exitWith {};

[
	["CfgHALsStore"],
	"HALs_store_",
	[
		["containerRadius", 10, {_this max 0}, true],
		["containerTypes", ["LandVehicle", "Air", "Ship"], {_this}, true],
		["currencySymbol", "¢", {_this}, true],
		["sellFactor", 1, {_this max 0 min 1}, true],
		["debug", 0, {_this isEqualTo 1}]
	]
] call HALs_fnc_getModuleSettings;

/*missionNamespace setVariable ["HALs_store_getNearbyVehicles", compileFinal '
	params [
		["_trader", objNull, [objNull]],
		["_types", HALs_store_containerTypes, [[]]],
		["_radius", HALs_store_containerRadius, [0]],
	];

	private _vehicles = nearestObjects [_this, _types, _radius, true];
	_vehicles = _vehicles select {local _x && {abs speed _x < 1 && {alive _x && isNil {_x getVariable "HALs_store_trader_type"}}}};

	_vehicles apply {
		_type = typeOf _x;
		//"a3\ui_f\data\gui\Rsc\RscDisplayGarage\car_ca.paa"
		[_type, format ["%1 (%2m)", getText(configFile >> "cfgVehicles" >> _type >> "displayName"), (_x distance2D _trader) toFixed 0], "", _x]	
	}
', true];*/