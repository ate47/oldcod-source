#using scripts\core_common\callbacks_shared;
#using scripts\core_common\system_shared;
#using scripts\wz_common\character_unlock;

#namespace character_unlock_ruin;

// Namespace character_unlock_ruin/character_unlock_ruin
// Params 0, eflags: 0x2
// Checksum 0xf2084672, Offset: 0x80
// Size: 0x44
function autoexec __init__system__() {
    system::register(#"character_unlock_ruin", &__init__, undefined, #"character_unlock");
}

// Namespace character_unlock_ruin/character_unlock_ruin
// Params 0, eflags: 0x0
// Checksum 0x7d2ba0a5, Offset: 0xd0
// Size: 0x74
function __init__() {
    character_unlock::register_character_unlock(#"ruin_unlock", #"hash_63b894fa4d634238", #"hash_7076cec9aa956bec", undefined, #"hash_4e9ba934add76371");
    callback::on_player_killed_with_params(&on_player_killed);
}

// Namespace character_unlock_ruin/character_unlock_ruin
// Params 1, eflags: 0x0
// Checksum 0x4d4293cc, Offset: 0x150
// Size: 0xf4
function on_player_killed(params) {
    attacker = params.eattacker;
    if (!isplayer(attacker)) {
        return;
    }
    if (attacker.team === self.team) {
        return;
    }
    if (!attacker character_unlock::function_97763910(#"ruin_unlock")) {
        return;
    }
    dist_to_target_sq = distancesquared(attacker.origin, self.origin);
    if (dist_to_target_sq > 196.85 * 196.85) {
        return;
    }
    attacker character_unlock::function_4c582a05(#"ruin_unlock", #"hash_4e9ba934add76371");
}

