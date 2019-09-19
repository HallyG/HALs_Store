params [
    ["_container", objNull, [objNull]],
    ["_classname", "", [""]]
];

if (isNull _container) exitWith {false};
if (_classname isEqualTo "") exitWith {false};

private _found = false;
private _data = (_container call HALs_store_fnc_getContainerCargo);
_data params ["_magazines", "_items", "_weapons", "_containers"];

try {
    {
        if ((_x select 0) isEqualTo _classname) then {
            _magazines deleteAt _forEachIndex;
            throw true;
        };
    } forEach _magazines;

    private _curIndex = 0;
    {
        _curIndex = _forEachIndex;
        _weapon = _x;
        {
            private _wepClassname = if (_x isEqualType []) then {_x select 0} else {_x};

            if (_classname isEqualTo _wepClassname) then {
                if (_forEachIndex isEqualTo 0) then {
                    _weapon set [_forEachIndex, ""];

                    /*private _items = _weapon select [1, count _weapon - 1];

                    {
                            systemCHat str _x;
                        //if (_forEachIndex in [3, 4]) then {
                        //    if (count _x > 0) then {
                        //        _magazines pushBack _x
                        //    };
                        //} else {
                            if (count _x > 0) then {
                                _items pushBack [_x, 1];
                            };
                        //}
                    } forEach _items;*/

                    _weapons set [_curIndex, []];
                } else {
                    _weapon set [_forEachIndex, ""];
                };

                throw true;
            };
        } forEach _weapon;
    } forEach _weapons;

    {
        if ((_x select 0) isEqualTo _classname) then {
            private _amt = _x select 1;

            if (_amt isEqualTo 1) then {
                _items deleteAt _forEachIndex;
            } else {
                (_items select _forEachIndex) set [1, _amt - 1];
            };

            throw true;
        };
    } forEach _items;
} catch {
    [_container] call HALs_store_fnc_clearContainerCargo;
    [_container, _data] call HALs_store_fnc_addContainerCargo;

    _found = _exception;
};

_found
