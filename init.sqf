// This is for the demo mission
if (!isDedicated) then {
	// Give the player 10,000 starting money
	[player, 10000] call HALs_money_fnc_addFunds;
};

if (isServer) then {
	private _trader1 = trader1;
 	[_trader1, "weapon"] call HALs_store_fnc_addTrader; 
  
 	_trader1 enableSimulationGlobal false; 
 	_trader1 allowDamage false; 
 	_trader1 setUnitLoadout [
		[], [], [],
		["U_I_C_Soldier_Para_1_F", []],
		[], [], "H_MilCap_grn", "", [],
		["ItemMap", "", "", "ItemCompass", "ItemWatch", ""]
	];   
 	_trader1 setName "Dembe Inouyie"; 
 	_trader1 setFace "AfricanHead_03"; 
 	_trader1 setPitch 1;
	[_trader1,"LEAN_ON_TABLE", "ASIS", pointer] call BIS_fnc_ambientAnim;

	private _trader2 = trader2;
 	[_trader2, "navigation"] call HALs_store_fnc_addTrader; 
 	_trader2 enableSimulationGlobal false; 
 	_trader2 allowDamage false;
	_trader2 setCaptive true;
	[_trader2, "GUARD", "ASIS"] call BIS_fnc_ambientAnim;
};