/*
	Function: HALs_store_fnc_addMoneyOnOpen
	Author: HallyG
	Player can collect the money stored on a unit/ in a box if they
	open them. As soon as the container is opened, the money is gone.
	Add money to an object using:
		[<object>, <funds>] call HALs_money_fnc_addFunds;

	Argument(s):
	0: None

	Return Value:
	None

	Example:
	[player] call HALs_store_fnc_addMoneyOnOpen;
__________________________________________________________________*/
if (!hasInterface) exitWith {};
if (!isNil {player getVariable "HALs_store_addMoneyOnOpenID"}) exitWith {};

player setVariable ["HALs_store_addMoneyOnOpenID",
	player addEventHandler ["InventoryOpened", {
		params ["", "_obj", ""];

		// Check that the object is either an ammobox or a dead unit and if it has not already been looted.
		if ((_obj isKindOf "ReammoBox_F" || {_obj isKindOf "Man" && {!alive _obj}}) && {!(_obj getVariable ["HALs_money_isLooted", false])}) then {
			// Mark unit as looted
			_obj setVariable ["HALs_money_isLooted", true, true];

			// Get money on obj
			private _money = [_obj] call HALs_money_fnc_getFunds;

			// Add money to player
			[player, _money] call HALs_money_fnc_addFunds;

			// Remove funds from unit
			[_obj, -_money] call HALs_money_fnc_addFunds;
		};
	}]
];
