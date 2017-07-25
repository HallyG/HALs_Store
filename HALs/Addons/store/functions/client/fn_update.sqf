/*
	todo
	Function: HALs_store_fnc_update
	Author: HallyG
	Update client's store dialog after global purchase.
	
	Argument(s):
	0: Buyer 					<OBJECT>
	1: Trader 					<OBJECT>
	2: Item category to update 	<STRING>
	
	Return Value:
	None
	
	Example:
	[BUYER, TRADER, "hgun_P07_F", "handguns"] call HALs_store_fnc_update;
__________________________________________________________________*/
params ["_unit", "_trader", "_category"];

if !(hasInterface) exitWith {};
disableSerialization;

private _display = uiNameSpace getVariable ["HALs_store_display", controlNull];

if (!isNull _display) then {
	if ((player getVariable ["HALs_store_trader_current", objNull]) isEqualTo _trader) then {
		private _dropDown = _display controlsGroupCtrl 75020;
		private _categoryActive = toLower (_dropDown lbData (lbCurSel _dropDown));	

		if (_categoryActive in _category) then {
				["UPDATE", ["CLIENT", [false]]] call HALs_store_fnc_main;
			
			if (_unit != player) then {
				[["Listings updated."], "readoutClick"] remoteExecCall ["HALs_store_fnc_systemChat", _unit];
			};
		};
	};
};