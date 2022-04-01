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
    (GVAR(PlayerList) select _netId) set [2, true];
}] call CBA_fnc_addEventHandler;

["acre_remoteStoppedSpeaking", {
    params ["_unit"];
    private _netId = _unit call BIS_fnc_netId;
    if !(_netId in GVAR(PlayerList)) exitWith {};
    (GVAR(PlayerList) select _netId) set [2, true];
}] call CBA_fnc_addEventHandler;


if !(isNil "ace_interact_menu_fnc_createAction") then {
    private _range = 10;

    _action = [QGVAR(main), "Hearing Indicator", ["\A3\3den\data\cfg3den\comment\texture_ca.paa", "#ffffff"], {},{
        true
    }, {}, [], [0,0,0], _range, nil, {
        (_this select 3) set [2,
            ["\A3\3den\data\cfg3den\comment\texture_ca.paa", (_this select 0) getVariable [QGVAR(color), "#ffffff"]]
        ];
    }] call ace_interact_menu_fnc_createAction;

    ["CAManBase", 0, ["ACE_MainActions"], _action, true] call ace_interact_menu_fnc_addActionToClass;

    {
        _x params ["_color", "_name"];
        _action = [QGVAR(add), format ["Set Color %1", _name], ["\A3\3den\data\cfg3den\comment\texture_ca.paa", _color call BIS_fnc_colorRGBAtoHTML], {
            params ["_target", "_player", "_color"];
            GVAR(PlayerList) set [_target call BIS_fnc_netId, [_target, _color, false]];
            _target setVariable [QGVAR(color), _color call BIS_fnc_colorRGBAtoHTML];
        },{
            params ["_target", "_player"];
            true
        }, {}, _color, [0,0,0], _range] call ace_interact_menu_fnc_createAction;

        ["CAManBase", 0, ["ACE_MainActions", QGVAR(main)], _action, true] call ace_interact_menu_fnc_addActionToClass;
    } forEach [
        [[1,0,0,1], "Red"],
        [[0,1,0,1], "Green"],
        [[0,0,1,1], "Blue"],
        [[0.6,0,1,1], "Purple"],
        [[1,0,0.6,1], "Pink"]
    ];
    _action = [QGVAR(remove), "Remove", ["\A3\3den\data\cfgwaypoints\dismiss_ca.paa", "#ff0000"], {
        params ["_target", "_player"];
        GVAR(PlayerList) deleteAt (_target call BIS_fnc_netId);
        _target setVariable [QGVAR(color), "#ffffff"];
    },{
        params ["_target", "_player"];
        (_target call BIS_fnc_netId) in GVAR(PlayerList)
    },{},[], [0,0,0], _range] call ace_interact_menu_fnc_createAction;

    ["CAManBase", 0, ["ACE_MainActions", QGVAR(main)], _action, true] call ace_interact_menu_fnc_addActionToClass;
};

addMissionEventHandler ["Draw3D", { call FUNC(onDraw3d); }];
