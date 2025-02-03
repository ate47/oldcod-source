#using script_40114edfb27a2dd9;
#using scripts\core_common\system_shared;

#namespace hud;

// Namespace hud/hud_shared
// Params 0, eflags: 0x6
// Checksum 0x1a23dcf8, Offset: 0x70
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"hud", &preinit, undefined, undefined, undefined);
}

// Namespace hud/hud_shared
// Params 0, eflags: 0x4
// Checksum 0xe5be9593, Offset: 0xb8
// Size: 0x14
function private preinit() {
    scavenger_icon::register();
}

