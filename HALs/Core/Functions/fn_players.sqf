/*
	Function: HALs_fnc_players
	Author: HallyG
	Returns all players. Excludes headless client entities.

	Argument(s):
	None

	Return Value:
	<ARRAY>

	Example:
	[] call HALs_fnc_players;
__________________________________________________________________*/
(allUnits + allDead) select {isPlayer _x && {!(_x isKindOf "HeadlessClient_F")}}
