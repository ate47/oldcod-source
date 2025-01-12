#using scripts\core_common\callbacks_shared;
#using scripts\core_common\system_shared;
#using scripts\wz_common\character_unlock;

#namespace character_unlock_reznov;

// Namespace character_unlock_reznov/character_unlock_reznov
// Params 0, eflags: 0x2
// Checksum 0xd293216b, Offset: 0x80
// Size: 0x44
function autoexec __init__system__() {
    system::register(#"character_unlock_reznov", &__init__, undefined, #"character_unlock");
}

// Namespace character_unlock_reznov/character_unlock_reznov
// Params 0, eflags: 0x0
// Checksum 0x502647ac, Offset: 0xd0
// Size: 0x84
function __init__() {
    character_unlock::register_character_unlock(#"reznov_unlock", #"hash_44599132bf7320e8", #"hash_10b2f2bb5f8a590b", &function_5882300, #"hash_1cd3eb5d2d22f647");
    callback::on_player_killed_with_params(&on_player_killed);
}

// Namespace character_unlock_reznov/character_unlock_reznov
// Params 1, eflags: 0x0
// Checksum 0x779ca3f0, Offset: 0x160
// Size: 0xf4
function on_player_killed(params) {
    attacker = params.eattacker;
    if (!isplayer(attacker)) {
        return;
    }
    if (attacker.team === self.team) {
        return;
    }
    if (!attacker character_unlock::function_97763910(#"reznov_unlock")) {
        return;
    }
    dist_to_target_sq = distancesquared(attacker.origin, self.origin);
    if (dist_to_target_sq < 11811 * 11811) {
        return;
    }
    attacker character_unlock::function_4c582a05(#"reznov_unlock", #"hash_1cd3eb5d2d22f647");
}

// Namespace character_unlock_reznov/character_unlock_reznov
// Params 0, eflags: 0x0
// Checksum 0x2fba9ef9, Offset: 0x260
// Size: 0xd4
function function_5882300() {
    aliveplayers = 0;
    players = getplayers();
    foreach (player in players) {
        if (self == player) {
            continue;
        }
        if (isalive(player)) {
            aliveplayers++;
        }
    }
    if (aliveplayers + 1 <= 10) {
        return true;
    }
    return false;
}

