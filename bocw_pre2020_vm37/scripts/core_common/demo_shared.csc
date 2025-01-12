#using scripts\core_common\callbacks_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace demo;

// Namespace demo/demo_shared
// Params 0, eflags: 0x6
// Checksum 0xb18ad9a8, Offset: 0x80
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"demo", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace demo/demo_shared
// Params 0, eflags: 0x5 linked
// Checksum 0x835dcf6e, Offset: 0xc8
// Size: 0x18
function private function_70a657d8() {
    if (!isdemoplaying()) {
        return;
    }
}

