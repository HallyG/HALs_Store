/*
	Function: HALs_store_fnc_addTrader
	Author: HallyG
	Initialises a trader.

	Argument(s):
	0: Trader object <OBJECT>
	1: Trader type <STRING>
	2: Trader target (Default: 0) <ARRAY, GROUP, NUMBER, OBJECT, SIDE, STRING>
		The trader is avaliable to all of these targets.

	Return Value:
	<BOOLEAN>

	Example:
	[obj2, "Navigation"] call HALs_store_fnc_addTrader;
__________________________________________________________________*/
params [
	["_trader", objNull, [objNull]],
	["_traderType", "", [""]],
	["_target", 0, [0, objNull, "", sideUnknown, grpNull, []]]
];

if (!isServer) exitWith {false};

try {
	if (!isNil {_trader getVariable "HALs_store_trader_type"}) then {throw ["Trader already initialised", __LINE__]};
	if (isNull _trader) then {throw ["Trader cannot be null", __LINE__]};
	if (!alive _trader) then {throw ["Trader cannot be dead", __LINE__]};
	if (isPlayer _trader) then {throw ["Trader cannot be a player", __LINE__]};
	if (_traderType isEqualTo "") then {throw ["No Trader type", __LINE__]};
	if (!isClass (missionConfigFile >> "cfgHALsAddons" >> "cfgHALsStore" >> "stores" >> _traderType)) then {throw ["Invalid Trader type", __LINE__]};

	//private _type = {typeOf _trader isKindOf [_x, configFile >> "cfgVehicles"]} count ["CAManBase", "Car_F", "ReammoBox_F"];
	//if (_type isEqualto 0) then {throw ["Trader is not TypeOf: ['CAManBase', 'Car_F', 'ReammoBox_F']", __LINE__]};

	private _categories = [
		getArray (missionConfigFile >> "cfgHALsAddons" >> "cfgHALsStore" >> "stores" >> _traderType >> "categories"),
		{getText (missionConfigFile >> "cfgHALsAddons" >> "cfgHALsStore" >> "categories" >> _x >> "displayname")},
		true
	] call HALs_fnc_sortArray;

	private _classes = [];
	private _stocks = [];
	{
		private _category = _x;
		_configCategory = missionConfigFile >> "cfgHALsAddons" >> "cfgHALsStore" >> "categories" >> _category;
		_items = "true" configClasses (_configCategory) apply {configName _x};

		_duplicateClass = {_classes find _x > -1} count _items > 0;
		_duplicateItem = !(count (_items arrayIntersect _items) isEqualTo count _items);
		if (_duplicateClass || _duplicateItem) then {
			throw [format ["Duplicate items  [category: %1, type: %2]", toUpper _x, toUpper _traderType], __LINE__];
		};

		{
			_classes pushBack _x;
			_stocks pushBack toLower _x;
			_stocks pushBack (getNumber (_configCategory >> _x >> "stock") max 0);
		} forEach _items;
	} forEach _categories;

	_trader setVariable ["HALs_store_trader_type", _traderType, true];
	_trader setVariable ["HALs_store_trader_stocks", _stocks, true];

	if !(typeOf _trader isKindOf ["CAManBase", configFile >> "cfgVehicles"]) then {
		clearMagazineCargoGlobal _trader;
		clearWeaponCargoGlobal _trader;
		clearItemCargoGlobal _trader;
		clearBackpackCargoGlobal _trader;
	};

	_trader setVariable ["HALs_store_name", getText (missionConfigFile >> "cfgHALsAddons" >> "cfgHALsStore" >> "stores" >> _traderType >> "displayName"), true];
	[_trader, _target] call HALs_store_fnc_addActionTrader;
	true
} catch {
	[_exception] call HALs_fnc_log;
	[_exception select 0] call BIS_fnc_error;
	false
};
