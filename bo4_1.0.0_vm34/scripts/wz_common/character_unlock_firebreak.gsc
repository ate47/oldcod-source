#using scripts\core_common\callbacks_shared;
#using scripts\core_common\system_shared;
#using scripts\wz_common\character_unlock;

#namespace character_unlock_firebreak;

// Namespace character_unlock_firebreak/character_unlock_firebreak
// Params 0, eflags: 0x2
// Checksum 0x79190a29, Offset: 0x80
// Size: 0x44
function autoexec __init__system__() {
    system::register(#"character_unlock_firebreak", &__init__, undefined, #"character_unlock");
}

// Namespace character_unlock_firebreak/character_unlock_firebreak
// Params 0, eflags: 0x0
// Checksum 0x136c2b1, Offset: 0xd0
// Size: 0x74
function __init__() {
    character_unlock::register_character_unlock(#"firebreak_unlock", #"hash_8596bc069593313", #"hash_1eadabf1e107ba54", undefined, #"hash_48b3b84fe88578f2");
    callback::on_player_killed_with_params(&on_player_killed);
}

// Namespace character_unlock_firebreak/character_unlock_firebreak
// Params 1, eflags: 0x0
// Checksum 0xd021d975, Offset: 0x150
// Size: 0x174
function on_player_killed(params) {
    attacker = params.eattacker;
    weapon = params.weapon;
    if (!isplayer(attacker) || !isdefined(weapon)) {
        return;
    }
    if (attacker.team === self.team) {
        return;
    }
    if (!attacker character_unlock::function_97763910(#"firebreak_unlock")) {
        return;
    }
    if (weapon.name === #"eq_molotov" || weapon.name === #"molotov_fire" || weapon.name === #"wraith_fire_fire" || weapon.name === #"eq_wraith_fire" || weapon.name === #"hero_flamethrower") {
        attacker character_unlock::function_4c582a05(#"firebreak_unlock", #"hash_48b3b84fe88578f2");
    }
}

