#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\zm_common\zm_loadout;
#using scripts\zm_common\zm_maptable;
#using scripts\zm_common\zm_melee_weapon;
#using scripts\zm_common\zm_weapons;

#namespace zm_weap_bowie;

// Namespace zm_weap_bowie/zm_weap_bowie
// Params 0, eflags: 0x6
// Checksum 0xabb51586, Offset: 0x130
// Size: 0x4c
function private autoexec __init__system__() {
    system::register(#"bowie_knife", &function_70a657d8, &postinit, undefined, undefined);
}

// Namespace zm_weap_bowie/zm_weap_bowie
// Params 0, eflags: 0x5 linked
// Checksum 0x2ec211e4, Offset: 0x188
// Size: 0x24
function private function_70a657d8() {
    zm_loadout::register_melee_weapon_for_level(#"bowie_knife");
}

// Namespace zm_weap_bowie/zm_weap_bowie
// Params 0, eflags: 0x5 linked
// Checksum 0x82bf50f1, Offset: 0x1b8
// Size: 0x15c
function private postinit() {
    if (isdefined(level.bowie_cost)) {
        cost = level.bowie_cost;
    } else {
        cost = 3000;
    }
    prompt = #"hash_60606b68e93a29c8";
    level.var_8e4168e9 = "bowie_knife";
    level.var_63af3e00 = "bowie_flourish";
    var_57858dd5 = "zombie_fists_bowie";
    if (zm_maptable::get_story() == 1) {
        level.var_8e4168e9 = "bowie_knife_story_1";
        level.var_63af3e00 = "bowie_flourish_story_1";
        var_57858dd5 = "zombie_fists_bowie_story_1";
    }
    zm_melee_weapon::init(level.var_8e4168e9, level.var_63af3e00, cost, "bowie_upgrade", prompt, "bowie", undefined);
    zm_melee_weapon::set_fallback_weapon(level.var_8e4168e9, var_57858dd5);
    level.w_bowie_knife = getweapon(hash(level.var_8e4168e9));
}

// Namespace zm_weap_bowie/zm_weap_bowie
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x320
// Size: 0x4
function init() {
    
}

