/*
	Function: HALs_store_fnc_addTrader
	Author: HallyG
	Creates an addaction for a store on a unit.
	
	Argument(s):
	0: Trader object <OBJECT>
	1: Trader type <STRING>
	
	Return Value:
	<BOOL>
	
	Example:
	[player, "Navigation"] call HALs_store_fnc_addTrader;
__________________________________________________________________*/
if !(isServer) exitWith {false};

params [
	["_trader", objNull, [objNull]],
	["_traderType", "", [""]]
];

try {
	if (isNull _trader) then {
		throw ["Trader is null", "fn_addTrader", __LINE__]
	};
	if (!alive _trader) then {
		throw ["Trader is dead", "fn_addTrader", __LINE__]
	};
	
	if !(typeOf _trader isKindOf ["CargoNet_01_base_F", configFile >> "cfgVehicles"]) then {
		throw ["Trader is not TypeOf:  CargoNet", "fn_addTrader", __LINE__]
	};
	
	if (_traderType isEqualTo "") then {
		throw ["No Trader type provided", "fn_addTrader", __LINE__]
	};
	
	if (!isClass (missionConfigFile >> "cfgHALsStore" >> "stores" >> _traderType)) then {
		throw ["Invalid Trader type provided", "fn_addTrader", __LINE__]
	};
	
	if ((_trader getVariable ["HALs_store_trader_type", ""]) != "") then {
		throw ["Trader already initialised", "fn_addTrader", __LINE__]
	};

	private _classes = [];
	private _stocks = [];
	private _categories = [
		getArray (missionConfigFile >> "cfgHALsStore" >> "stores" >> _traderType >> "categories"),
		{getText (configFile >> "cfgHALsStore" >> "categories" >> _x >> "displayname")},
		true
	] call HALs_fnc_sortArray;


	{
		private _category = _x;
		private _items = "true" configClasses (missionConfigFile >> "cfgHALsStore" >> "categories" >> _category) apply {toLower configName _x};
		private _duplicateClass = {_classes find _x > -1} count _items > 0;
		private _duplicateItem = !(count (_items arrayIntersect _items) isEqualTo count _items);
		
		if (_duplicateClass || _duplicateItem) then {
			throw [format ["Duplicate items  [category: %1, type: %2]", toUpper _x, toUpper _traderType], "fn_addTrader", __LINE__];
		};
		
		_classes append _items;
		_stocks append (_items apply {(getNumber (missionConfigFile >> "cfgHALsStore" >> "categories" >> _category >> _x >> "stock"))});
	} forEach _categories;


	_trader setVariable ["HALs_store_trader_type", _traderType, true];
	_trader setVariable ["HALs_store_trader_categories", _categories, true];
	_trader setVariable ["HALs_store_trader_classes", _classes, true];
	_trader setVariable ["HALs_store_trader_stocks", _stocks apply {_x max 0 min 999999}, true];
	[_trader] remoteExec ["HALs_store_fnc_addAction", 0, true];
	true 
} catch {
	["HALs", "STORE", _exception select 0, _exception select 1, _exception select 2] call HALs_fnc_log;
	[_exception select 0] call BIS_fnc_error;
	false
};