#include "script_component.hpp"

["acre_remoteStartedSpeaking", {
    params ["_unit"];
    if (_unit isEqualTo player) exitWith {
        private _currentVolumeLevel = (player getVariable [QGVAR(volumeLevel), -1]);
        if (_currentVolumeLevel != (acre_sys_gui_volumeLevel + 0.25)) then {
            player setVariable [QGVAR(volumeLevel), acre_sys_gui_volumeLevel + 0.25, true];
        };
    };
    private _netId = _unit call BIS_fnc_netId;
    if !(_netId in GVAR(PlayerList)) exitWith {};
    (GVAR(PlayerList select _netId) set [2, true];
}] call CBA_fnc_addEventHandler;

["acre_remoteStoppedSpeaking", {
    params ["_unit"];
    private _netId = _unit call BIS_fnc_netId;
    if !(_netId in GVAR(PlayerList)) exitWith {};
    (GVAR(PlayerList select _netId) set [2, true];
}] call CBA_fnc_addEventHandler;

addMissionEventHandler ["Draw3D", { call FUNC(onDraw3d); }];
