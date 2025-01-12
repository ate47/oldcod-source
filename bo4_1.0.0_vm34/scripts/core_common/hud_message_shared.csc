#using script_61ec16c9c8ab8dcc;
#using scripts\core_common\system_shared;

#namespace hud_message;

// Namespace hud_message/hud_message_shared
// Params 0, eflags: 0x2
// Checksum 0x1401db5e, Offset: 0x88
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"hud_message", &__init__, undefined, undefined);
}

// Namespace hud_message/hud_message_shared
// Params 0, eflags: 0x0
// Checksum 0x2b324e30, Offset: 0xd0
// Size: 0x26
function __init__() {
    level.lower_message = lower_message::register("lower_message");
}

