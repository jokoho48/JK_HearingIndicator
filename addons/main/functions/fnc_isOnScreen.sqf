#include "script_component.hpp"
/*
    JK HearingIndicator

    Author: joko // Jonas

    Description:
    Checks if a ScreenPos is on Screen

    Parameter(s):
    0: Screen Position <Vector2>

    Returns:
    On Screen <Boolean>
*/
params ["_screenPos"];
if (_screenPos isEqualTo []) exitWith {false};
_screenPos params ["_screenPosX", "_screenPosY"];
!(_screenPosX < SafeZoneX || _screenPosX > SafeZoneW + SafeZoneX || _screenPosY < SafeZoneY || _screenPosY > SafeZoneH + SafeZoneY);
