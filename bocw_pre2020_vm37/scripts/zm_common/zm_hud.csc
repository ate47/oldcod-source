#using script_4990d85086acf096;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\zm_utility;

#namespace zm_hud;

// Namespace zm_hud/zm_hud
// Params 0, eflags: 0x6
// Checksum 0xfb97899f, Offset: 0x90
// Size: 0x54
function private autoexec __init__system__() {
    system::register(#"zm_hud", &function_70a657d8, &postinit, undefined, #"zm_crafting");
}

// Namespace zm_hud/zm_hud
// Params 0, eflags: 0x5 linked
// Checksum 0x9bf2312, Offset: 0xf0
// Size: 0x14
function private function_70a657d8() {
    zm_location::register();
}

// Namespace zm_hud/zm_hud
// Params 0, eflags: 0x5 linked
// Checksum 0x80f724d1, Offset: 0x110
// Size: 0x4
function private postinit() {
    
}

