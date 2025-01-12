#using script_40114edfb27a2dd9;
#using scripts\core_common\system_shared;

#namespace hud;

// Namespace hud/hud_shared
// Params 0, eflags: 0x2
// Checksum 0x327bd5cb, Offset: 0x90
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"hud", &__init__, undefined, undefined);
}

// Namespace hud/hud_shared
// Params 0, eflags: 0x0
// Checksum 0xc035fb09, Offset: 0xd8
// Size: 0x1c
function __init__() {
    scavenger_icon::register("scavenger_pickup");
}

