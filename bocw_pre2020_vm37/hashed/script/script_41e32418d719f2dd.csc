#using script_359683f0ff3b3fbb;
#using script_427cc4c66630a8dc;
#using script_55772e8c48402596;
#using script_67bdb54dcccc5c6b;
#using scripts\core_common\system_shared;

#namespace namespace_77bd50da;

// Namespace namespace_77bd50da/namespace_77bd50da
// Params 0, eflags: 0x6
// Checksum 0x3248472b, Offset: 0x88
// Size: 0x4c
function private autoexec __init__system__() {
    system::register(#"hash_7b30b3878fc15536", &function_70a657d8, &postinit, undefined, undefined);
}

// Namespace namespace_77bd50da/namespace_77bd50da
// Params 0, eflags: 0x1 linked
// Checksum 0x5017c217, Offset: 0xe0
// Size: 0x64
function function_70a657d8() {
    sr_message_box::register();
    if (!isdefined(level.var_352498c6)) {
        prototype_hud::register();
        level.var_352498c6 = 1;
    }
    prototype_self_revive::register();
    namespace_84845aec::register();
}

// Namespace namespace_77bd50da/namespace_77bd50da
// Params 0, eflags: 0x1 linked
// Checksum 0x80f724d1, Offset: 0x150
// Size: 0x4
function postinit() {
    
}

