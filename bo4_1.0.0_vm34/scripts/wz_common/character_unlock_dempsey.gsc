#using scripts\core_common\callbacks_shared;
#using scripts\core_common\system_shared;
#using scripts\wz_common\character_unlock;

#namespace character_unlock_dempsey;

// Namespace character_unlock_dempsey/character_unlock_dempsey
// Params 0, eflags: 0x2
// Checksum 0x5b6548be, Offset: 0x80
// Size: 0x44
function autoexec __init__system__() {
    system::register(#"character_unlock_dempsey", &__init__, undefined, #"character_unlock");
}

// Namespace character_unlock_dempsey/character_unlock_dempsey
// Params 0, eflags: 0x0
// Checksum 0xb574c8c7, Offset: 0xd0
// Size: 0x74
function __init__() {
    character_unlock::register_character_unlock(#"dempsey_unlock", #"hash_23d5f8566508f9f5", #"hash_3f7e1cc8b92797ab", undefined, #"hash_557b228047615fb0");
    callback::on_player_killed_with_params(&on_player_killed);
}

// Namespace character_unlock_dempsey/character_unlock_dempsey
// Params 1, eflags: 0x0
// Checksum 0xbb41db1, Offset: 0x150
// Size: 0x194
function on_player_killed(params) {
    attacker = params.eattacker;
    weapon = params.weapon;
    if (!isplayer(attacker) || !isdefined(weapon)) {
        return;
    }
    if (attacker.team === self.team) {
        return;
    }
    if (!attacker character_unlock::function_97763910(#"dempsey_unlock")) {
        return;
    }
    if (weapon.name != #"eq_acid_bomb" && weapon.name != #"frag_grenade" && weapon.name != #"eq_cluster_semtex_grenade" && weapon.name != #"hash_66401df7cd6bf292") {
        return;
    }
    if (!isdefined(attacker.var_cdbbf834)) {
        attacker.var_cdbbf834 = 0;
    }
    attacker.var_cdbbf834++;
    if (attacker.var_cdbbf834 == 1) {
        attacker character_unlock::function_4c582a05(#"dempsey_unlock", #"hash_557b228047615fb0");
    }
}

