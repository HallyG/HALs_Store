/*
	Function: HALs_store_fnc_hashGet
	Author: HallyG
	

	Argument(s):
	0: None

	Return Value:
	None

	Example:
	[] call HALs_store_fnc_hashGet;
__________________________________________________________________*/
#include "script_component.hpp"

params ["_c", "_k"];
GET_HASH;

(((_c select _h) select 1) select (((_c select _h) select 0) find _k))