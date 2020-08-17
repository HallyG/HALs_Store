// This is for the demo mission
if (!isDedicated) then {
	// Give the player 10,000 starting money
	[player, 10000] call HALs_money_fnc_addFunds;
};

private _trader1 = trader1;
if (isServer) then {
	[_trader1, "weapon"] call HALs_store_fnc_addTrader; 
	
	_trader1 enableSimulationGlobal false; 
	_trader1 allowDamage false; 
	_trader1 setUnitLoadout [
		[], [], [],
		["U_I_C_Soldier_Para_1_F", []],
		[], [], "H_MilCap_grn", "", [],
		["ItemMap", "", "", "ItemCompass", "ItemWatch", ""]
	];   

	[_trader1, "LEAN_ON_TABLE", "ASIS", pointer] remoteExecCall ["BIS_fnc_ambientAnim", 0, true];
};

private _trader2 = trader2;
if (isServer) then {
	[_trader2, "navigation"] call HALs_store_fnc_addTrader; 
	_trader2 enableSimulationGlobal false; 
	_trader2 allowDamage false;
	_trader2 setCaptive true;

	[_trader2, "GUARD", "ASIS"] remoteExecCall ["BIS_fnc_ambientAnim", 0, true];
};