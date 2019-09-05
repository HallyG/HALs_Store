/*
	Function: HALs_store_fnc_addTrader
	Author: HallyG
	Creates an addaction for a store on a unit.

	Argument(s):
	0: Trader object <OBJECT>
	1: Trader type <STRING>

	Return Value:
	<BOOLEAN>

	Example:
	[player, "Navigation"] call HALs_store_fnc_addTrader;
__________________________________________________________________*/
if (!isServer) exitWith {false};

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

	private _type = {
		typeOf _trader isKindOf [_x, configFile >> "cfgVehicles"]
	} count ["CAManBase", "Car_F", "ReammoBox_F"];
	if (_type isEqualto 0) then {
		throw ["Trader is not TypeOf:  ['CAManBase', 'Car_F', 'ReammoBox_F']", "fn_addTrader", __LINE__]
	};

	if (_traderType isEqualTo "") then {
		throw ["No Trader type provided", "fn_addTrader", __LINE__]
	};

	if (!isClass (missionConfigFile >> "cfgHALsAddons" >> "cfgHALsStore" >> "stores" >> _traderType)) then {
		throw ["Invalid Trader type provided", "fn_addTrader", __LINE__]
	};

	if (!isNil {_trader getVariable "HALs_store_trader_type"}) then {
		throw ["Trader already initialised", "fn_addTrader", __LINE__]
	};

	// Verify store config
	private _categories = [
		getArray (missionConfigFile >> "cfgHALsAddons" >> "cfgHALsStore" >> "stores" >> _traderType >> "categories"),
		{getText (missionConfigFile >> "cfgHALsAddons" >> "cfgHALsStore" >> "categories" >> _x >> "displayname")},
		true
	] call HALs_fnc_sortArray;

	private _classes = [];
	private _stocks = [];
	{
		private _category = _x;
		private _configCategory = missionConfigFile >> "cfgHALsAddons" >> "cfgHALsStore" >> "categories" >> _category;
		private _items = "true" configClasses (_configCategory) apply {toLower configName _x};
		private _duplicateClass = {_classes find _x > -1} count _items > 0;
		private _duplicateItem = !(count (_items arrayIntersect _items) isEqualTo count _items);

		if (_duplicateClass || _duplicateItem) then {
			throw [format ["Duplicate items  [category: %1, type: %2]", toUpper _x, toUpper _traderType], "fn_addTrader", __LINE__];
		};


		_items = _items apply {
			_config = _x call HALs_fnc_getConfigClass;
			_stock = 0 max getNumber (_configCategory >> _x >> "stock") min 999999;

			_classes pushback _x;
			_stocks pushback _stock;
			[
				_x, getText (_config >> "displayName"), getText (_config >> "picture"),
				0 max getNumber (_configCategory >> _x >> "price") min 999999,
				_stock
			]
		};

		_trader setVariable [
			format ["HALs_store_%1_items", _category],
			_items, true
		];
	} forEach _categories;

	if !(typeOf _trader isKindOf ["CAManBase", configFile >> "cfgVehicles"]) then {
		clearMagazineCargoGlobal _trader;
		clearWeaponCargoGlobal _trader;
		clearItemCargoGlobal _trader;
		clearBackpackCargoGlobal _trader;
	};

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
