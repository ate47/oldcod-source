#using script_40114edfb27a2dd9;
#using scripts\core_common\system_shared;

#namespace hud;

// Namespace hud/hud_shared
// Params 0, eflags: 0x6
// Checksum 0xd31b3636, Offset: 0x70
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"hud", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace hud/hud_shared
// Params 0, eflags: 0x5 linked
// Checksum 0x7a3fff14, Offset: 0xb8
// Size: 0x14
function private function_70a657d8() {
    scavenger_icon::register();
}

