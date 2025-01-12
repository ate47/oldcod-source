#using scripts\core_common\aat_shared;
#using scripts\core_common\ai\zombie_death;
#using scripts\core_common\ai\zombie_utility;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\util;
#using scripts\zm_common\zm_bgb;
#using scripts\zm_common\zm_laststand;
#using scripts\zm_common\zm_powerups;
#using scripts\zm_common\zm_score;
#using scripts\zm_common\zm_utility;

#namespace namespace_33edc64c;

// Namespace namespace_33edc64c/namespace_33edc64c
// Params 0, eflags: 0x2
// Checksum 0x6b1ab82d, Offset: 0xd0
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"hash_6119ea2d427fdf8a", &__init__, undefined, undefined);
}

// Namespace namespace_33edc64c/namespace_33edc64c
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x118
// Size: 0x4
function __init__() {
    
}

// Namespace namespace_33edc64c/namespace_33edc64c
// Params 1, eflags: 0x0
// Checksum 0x214e1aa, Offset: 0x128
// Size: 0x44
function function_17d42a38(player) {
    player zm_utility::function_d7a33664(self.hint);
    level thread function_c50ccadc(player);
}

// Namespace namespace_33edc64c/namespace_33edc64c
// Params 1, eflags: 0x0
// Checksum 0xa79e6b3c, Offset: 0x178
// Size: 0x74
function function_c50ccadc(player) {
    if (isdefined(player.lives) && player.lives < 5) {
        player.lives++;
        return;
    }
    if (player zm_laststand::function_d75050c0() < 5) {
        player zm_laststand::function_1cc4ccbf();
    }
}

