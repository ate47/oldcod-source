#using scripts\core_common\flag_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace namespace_7a142a23;

// Namespace namespace_7a142a23/namespace_7a142a23
// Params 0, eflags: 0x2
// Checksum 0xfd0e950c, Offset: 0xa8
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"hash_18ce058ad321248f", &__init__, undefined, undefined);
}

// Namespace namespace_7a142a23/namespace_7a142a23
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0xf0
// Size: 0x4
function __init__() {
    
}

// Namespace namespace_7a142a23/event_57a8880c
// Params 1, eflags: 0x40
// Checksum 0x5388963c, Offset: 0x100
// Size: 0x64
function event_handler[event_57a8880c] function_565a245e(eventstruct) {
    if (eventstruct.ent.targetname === "asylum_toilet") {
        if (eventstruct.state == 3) {
            wait 3;
            eventstruct.ent thread toilet_ee_play();
        }
    }
}

// Namespace namespace_7a142a23/namespace_7a142a23
// Params 0, eflags: 0x0
// Checksum 0x7df665d6, Offset: 0x170
// Size: 0x6c
function toilet_ee_play() {
    if (isdefined(self.target)) {
        s_sound = struct::get(self.target, "targetname");
        playsound(0, #"hash_7672866383ae1956", s_sound.origin);
    }
}

