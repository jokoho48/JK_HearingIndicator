#include "script_component.hpp"
class CfgPatches {
    class ADDON {
        name = COMPONENT_NAME;
        units[] = {};
        weapons[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {"cba_main", "acre_main", "acre_api"};
        author = "joko // Jonas";
        VERSION_CONFIG;
    };
};

#include "CfgEventHandlers.hpp"
