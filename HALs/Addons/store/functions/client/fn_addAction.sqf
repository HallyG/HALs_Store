/*
	Function: HALs_store_fnc_addAction
	Author: HallyG
	Add addAction on client.

	Argument(s):
	0: Trader <OBJECT>

	Return Value:
	None

	Example:
	[TRADER] call HALs_store_fnc_addAction;
__________________________________________________________________*/
params [
	["_trader", objNull, [objNull]]
];

if (!hasInterface) exitWith {};
if (isNull _trader) exitWith {};
if (isNil {_trader getVariable "HALs_store_trader_type"}) exitWith {};

[
	_trader,
	localize "STR_HALS_STORE_ACTION",
	"\a3\Ui_F_Oldman\Data\IGUI\Cfg\HoldActions\holdAction_market_ca.paa",
	"\a3\Ui_F_Oldman\Data\IGUI\Cfg\HoldActions\holdAction_market_ca.paa",
	"alive _target && _this distance _target < 3 && isNull objectParent _this",
	"_this distance _target < 3",
	{},
	{},
	{
		params ["_trader", "_unit", "_actionId", "_arguments"];
			
		_unit setVariable ["HALs_store_trader_current", _trader, true];

		private _vehicles = nearestObjects [_trader, HALs_store_containerTypes, HALs_store_containerRadius, true];
		_vehicles = _vehicles select {local _x && {speed _x < 1} && {alive _x}};
		_vehicles = _vehicles select {isNil {_x getVariable "HALs_store_trader_type"}};

		HALs_store_vehicles = _vehicles apply {
			[
				typeOf _x,
				format [
					"%1 (%2m)",
					getText(configFile >> "cfgVehicles" >> typeOf _x >> "displayName"),
					round (_x distance2D _trader)
				], ""/*"a3\ui_f\data\gui\Rsc\RscDisplayGarage\car_ca.paa"*/, _x
			]
		};

		createDialog "RscDisplayStore";
	}, {}, [], 0.5, nil, false, false
] call BIS_fnc_holdActionAdd;










