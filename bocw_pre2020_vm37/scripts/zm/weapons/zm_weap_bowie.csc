#using scripts\core_common\system_shared;
#using scripts\zm_common\zm_maptable;

#namespace zm_weap_bowie;

// Namespace zm_weap_bowie/zm_weap_bowie
// Params 0, eflags: 0x6
// Checksum 0x871c7866, Offset: 0xf8
// Size: 0x4c
function private autoexec __init__system__() {
    system::register(#"bowie_knife", &function_70a657d8, &postinit, undefined, undefined);
}

// Namespace zm_weap_bowie/zm_weap_bowie
// Params 0, eflags: 0x5 linked
// Checksum 0x80f724d1, Offset: 0x150
// Size: 0x4
function private function_70a657d8() {
    
}

// Namespace zm_weap_bowie/zm_weap_bowie
// Params 0, eflags: 0x5 linked
// Checksum 0x6697fb99, Offset: 0x160
// Size: 0xb4
function private postinit() {
    level.var_8e4168e9 = "bowie_knife";
    level.var_63af3e00 = "bowie_flourish";
    var_57858dd5 = "zombie_fists_bowie";
    if (zm_maptable::get_story() == 1) {
        level.var_8e4168e9 = "bowie_knife_story_1";
        level.var_63af3e00 = "bowie_flourish_story_1";
        var_57858dd5 = "zombie_fists_bowie_story_1";
    }
    level.w_bowie_knife = getweapon(hash(level.var_8e4168e9));
}

