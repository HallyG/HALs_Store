/*
	Function: HALs_fnc_getModuleRoot
	Author: HallyG
	
	Example:
	["HALs_money"] call HALs_fnc_getModuleRoot;
__________________________________________________________________*/
private _root = param [0, "", [""]];

private _functionsPath = getText (missionConfigFile >> "CfgFunctions" >> _root >> "init" >> "file");
private _functionsPathArray = _functionsPath splitString "\";
_functionsPathArray deleteAt (count _functionsPathArray - 1);
_functionsPathArray joinString "\"