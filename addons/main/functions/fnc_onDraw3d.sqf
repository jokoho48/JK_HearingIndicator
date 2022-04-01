#include "script_component.hpp"
/*
    JK HearingIndicator

    Author: joko // Jonas

    Description:
    Draw Routine

    Parameter(s):
    None

    Returns:
    None
*/
private _deleted = [];
{
    _y params ["_unit", "_color", "_taking"];
    if (isNull _unit) then {
        _deleted pushback _x;
        continue;
    };
    if (!_taking) then { continue; };
    private _position = _unit modelToWorldVisual (_unit selectionPosition "Head");
    private _distance = (_position distance (positionCameraToWorld [0, 0, 0]))
        * (_unit getVariable [QGVAR(volumeLevel), acre_sys_gui_volumeLevel])
        * ACRE_api_selectableCurveScale;
    if (_distance > GVAR(maxDistance)) then { continue; };
    private _screenPos = worldToScreen _position;
    if ([_screenPos] call FUNC(isOnScreen)) then { continue; };
    _color set [3, (GVAR(maxDistance) - _distance) / GVAR(maxDistance)];
    drawIcon3D ["\A3\3den\data\cfg3den\comment\texture_ca.paa", _color, _position, 2, 2, 0, name _unit, 2, 0.025, "PuristaMedium", "center", true];
} forEach GVAR(PlayerList);

{
    GVAR(PlayerList) deleteAt _x;
} forEach _deleted;
