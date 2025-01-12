#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;

#namespace namespace_fd45d8e1;

// Namespace namespace_fd45d8e1/namespace_fd45d8e1
// Params 0, eflags: 0x2
// Checksum 0x9c1fa43b, Offset: 0xc0
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"hash_411c8f5d7f8749b9", &__init__, undefined, undefined);
}

// Namespace namespace_fd45d8e1/namespace_fd45d8e1
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x108
// Size: 0x4
function __init__() {
    
}

// Namespace namespace_fd45d8e1/event_57a8880c
// Params 1, eflags: 0x40
// Checksum 0x27fafb68, Offset: 0x118
// Size: 0x8c
function event_handler[event_57a8880c] function_565a245e(eventstruct) {
    if (eventstruct.ent.targetname === "blast_door") {
        if (eventstruct.state == 0) {
            eventstruct.ent thread function_61d57db8("red");
            return;
        }
        eventstruct.ent thread function_61d57db8("green");
    }
}

// Namespace namespace_fd45d8e1/namespace_fd45d8e1
// Params 1, eflags: 0x0
// Checksum 0xaf2ecf2, Offset: 0x1b0
// Size: 0x11a
function function_61d57db8(color) {
    var_aa5cae14 = struct::get_array("blast_door_light", "targetname");
    foreach (s_light in var_aa5cae14) {
        var_62861828 = s_light.origin;
        if (isdefined(s_light.var_e4d78d14)) {
            stopfx(0, s_light.var_e4d78d14);
            s_light.var_e4d78d14 = undefined;
        }
        s_light.var_e4d78d14 = playfx(0, #"hash_787d9cfa8f97976a" + color, var_62861828);
    }
}

