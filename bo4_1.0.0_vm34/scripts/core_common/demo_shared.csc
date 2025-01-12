#using scripts\core_common\callbacks_shared;
#using scripts\core_common\filter_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\flagsys_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace demo;

// Namespace demo/demo_shared
// Params 0, eflags: 0x2
// Checksum 0x9e33fa61, Offset: 0x98
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"demo", &__init__, undefined, undefined);
}

// Namespace demo/demo_shared
// Params 0, eflags: 0x0
// Checksum 0xd508c36c, Offset: 0xe0
// Size: 0x18
function __init__() {
    if (!isdemoplaying()) {
        return;
    }
}

