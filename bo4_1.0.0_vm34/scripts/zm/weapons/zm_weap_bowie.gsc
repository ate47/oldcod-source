#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\zm_common\zm_loadout;
#using scripts\zm_common\zm_melee_weapon;
#using scripts\zm_common\zm_weapons;

#namespace zm_weap_bowie;

// Namespace zm_weap_bowie/zm_weap_bowie
// Params 0, eflags: 0x2
// Checksum 0x5984453b, Offset: 0x108
// Size: 0x44
function autoexec __init__system__() {
    system::register(#"bowie_knife", &__init__, &__main__, undefined);
}

// Namespace zm_weap_bowie/zm_weap_bowie
// Params 0, eflags: 0x4
// Checksum 0xc77e1077, Offset: 0x158
// Size: 0x24
function private __init__() {
    zm_loadout::register_melee_weapon_for_level(#"bowie_knife");
}

// Namespace zm_weap_bowie/zm_weap_bowie
// Params 0, eflags: 0x4
// Checksum 0x782e0b96, Offset: 0x188
// Size: 0xec
function private __main__() {
    if (isdefined(level.bowie_cost)) {
        cost = level.bowie_cost;
    } else {
        cost = 3000;
    }
    prompt = #"hash_60606b68e93a29c8";
    zm_melee_weapon::init("bowie_knife", "bowie_flourish", "knife_ballistic_bowie", "knife_ballistic_bowie_upgraded", cost, "bowie_upgrade", prompt, "bowie", undefined);
    zm_melee_weapon::set_fallback_weapon("bowie_knife", "zombie_fists_bowie");
    zm_weapons::function_94719ba3("knife_ballistic_bowie");
    zm_weapons::function_94719ba3("knife_ballistic_bowie_upgraded");
}

// Namespace zm_weap_bowie/zm_weap_bowie
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x280
// Size: 0x4
function init() {
    
}

