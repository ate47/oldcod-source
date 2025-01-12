#using scripts\core_common\clientfield_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\zm_common\zm_utility;
#using scripts\zm_common\zm_weapons;

#namespace zm_weap_cymbal_monkey;

// Namespace zm_weap_cymbal_monkey/zm_weap_cymbal_monkey
// Params 0, eflags: 0x6
// Checksum 0xd48f3c58, Offset: 0xc8
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"zm_weap_cymbal_monkey", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace zm_weap_cymbal_monkey/zm_weap_cymbal_monkey
// Params 0, eflags: 0x5 linked
// Checksum 0x733205ad, Offset: 0x110
// Size: 0x44
function private function_70a657d8() {
    if (is_true(level.legacy_cymbal_monkey)) {
        level.cymbal_monkey_model = "weapon_zombie_monkey_bomb";
        return;
    }
    level.cymbal_monkey_model = "wpn_t7_zmb_monkey_bomb_world";
}

