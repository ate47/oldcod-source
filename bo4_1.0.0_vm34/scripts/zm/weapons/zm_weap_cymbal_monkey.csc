#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\zm_common\zm_utility;
#using scripts\zm_common\zm_weapons;

#namespace zm_weap_cymbal_monkey;

// Namespace zm_weap_cymbal_monkey/zm_weap_cymbal_monkey
// Params 0, eflags: 0x2
// Checksum 0x5f1fd1dd, Offset: 0xc0
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"zm_weap_cymbal_monkey", &__init__, undefined, undefined);
}

// Namespace zm_weap_cymbal_monkey/zm_weap_cymbal_monkey
// Params 0, eflags: 0x0
// Checksum 0x5622ef7b, Offset: 0x108
// Size: 0x88
function __init__() {
    if (isdefined(level.legacy_cymbal_monkey) && level.legacy_cymbal_monkey) {
        level.cymbal_monkey_model = "weapon_zombie_monkey_bomb";
    } else {
        level.cymbal_monkey_model = "wpn_t7_zmb_monkey_bomb_world";
    }
    if (!zm_weapons::is_weapon_included(getweapon(#"cymbal_monkey"))) {
        return;
    }
}

