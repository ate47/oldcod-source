#using scripts\core_common\callbacks_shared;
#using scripts\core_common\player\player_role;
#using scripts\core_common\system_shared;
#using scripts\wz_common\character_unlock;

#namespace character_unlock_nomad;

// Namespace character_unlock_nomad/character_unlock_nomad
// Params 0, eflags: 0x2
// Checksum 0x6295eaad, Offset: 0x88
// Size: 0x44
function autoexec __init__system__() {
    system::register(#"character_unlock_nomad", &__init__, undefined, #"character_unlock");
}

// Namespace character_unlock_nomad/character_unlock_nomad
// Params 0, eflags: 0x0
// Checksum 0xb26e0641, Offset: 0xd8
// Size: 0x74
function __init__() {
    character_unlock::register_character_unlock(#"nomad_unlock", #"hash_4b77f84c47802222", #"hash_62d37ab78285f393", undefined, #"hash_7eb32c4c67ae13fe");
    callback::on_player_killed_with_params(&on_player_killed);
}

// Namespace character_unlock_nomad/character_unlock_nomad
// Params 1, eflags: 0x0
// Checksum 0x37f51626, Offset: 0x158
// Size: 0x21c
function on_player_killed(params) {
    attacker = params.eattacker;
    if (!isplayer(attacker)) {
        return;
    }
    if (attacker.team === self.team) {
        return;
    }
    if (!attacker character_unlock::function_97763910(#"nomad_unlock")) {
        return;
    }
    characterassetname = getcharacterassetname(self getcharacterbodytype(), currentsessionmode());
    if (characterassetname === #"hash_25d901b2845affb5" || characterassetname === #"hash_34c5e1c04823489d" || characterassetname === #"hash_35abb557417d97bc" || characterassetname === #"hash_271546989f2b39c0" || characterassetname === #"hash_17c8471ad085983b" || characterassetname === #"hash_215efce6af8d9a10" || characterassetname === #"hash_265a8bfe9e6a3a8f" || characterassetname === #"hash_641d42086962443d" || characterassetname === #"hash_74a7b1f09eb77129" || characterassetname === #"hash_bac19a8a93f750a") {
        if (!isdefined(attacker.var_d2cc6271)) {
            attacker.var_d2cc6271 = 0;
        }
        attacker.var_d2cc6271++;
    }
    if (attacker.var_d2cc6271 >= 3) {
        attacker character_unlock::function_4c582a05(#"nomad_unlock", #"hash_7eb32c4c67ae13fe");
    }
}

