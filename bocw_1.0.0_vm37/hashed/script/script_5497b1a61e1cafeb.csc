#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;

#namespace high_value_target;

// Namespace high_value_target/high_value_target
// Params 0, eflags: 0x6
// Checksum 0x94f3c0e0, Offset: 0xa0
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"high_value_target", &preinit, undefined, undefined, undefined);
}

// Namespace high_value_target/high_value_target
// Params 0, eflags: 0x4
// Checksum 0xe0a24de3, Offset: 0xe8
// Size: 0x3c
function private preinit() {
    clientfield::register("allplayers", "high_value_target", 1, 1, "int", undefined, 0, 0);
}

