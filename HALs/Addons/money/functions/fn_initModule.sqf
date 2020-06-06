/*
	Function: HALs_money_fnc_init
	Author: HallyG

	Example:
	[] spawn HALs_money_fnc_initModule;
__________________________________________________________________*/
if (!hasInterface) exitWith {};
if (!isNil "HALs_money_moduleInit") exitWith {};
HALs_money_moduleInit = true;

["HALs_money",
	[
		["startingFunds", 1000, {_this max 0 min 999999}],
		["startingBalance", 0, {_this max 0 min 999999}],
		["debug", 0, {_this isEqualTo 1}]
	]
] call HALs_fnc_getModuleSettings;

[player, HALs_money_startingFunds] call HALs_money_fnc_addFunds;

player addEventHandler ["Take", {
	params ["_unit", "_container", "_item"];
	
	private _money = 0;
	switch (_item) do {
		case "Money_bunch": {_money = 50};
		case "Money_roll": {_money = 150};
		case "Money_stack": {_money = 300};
		case "Money": {_money = 600};
	};

	if (_money > 0) then {
		player removeItem _item;
		[player, _money] call HALs_money_fnc_addFunds;
	};
	
	systemChat format ["%1 %2", _this, _money];
}];