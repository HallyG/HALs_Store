/*
	Function: HALs_fnc_getModuleRoot
	Author: HallyG
	Returns the file path to the component's folder.
	
	Argument(s):
	0: Component name. <STRING>
	
	Return Value:
	File path <STRING>
	
	Example:
	["HALs_money"] call HALs_fnc_getModuleRoot;
__________________________________________________________________*/
params [
	["_component", "", [""]]
];

private _functionsPathArray = getText (missionConfigFile >> "CfgFunctions" >> _component >> "init" >> "file") splitString "\";
_functionsPathArray deleteAt (count _functionsPathArray - 1);
_functionsPathArray joinString "\"
