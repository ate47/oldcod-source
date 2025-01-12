#using scripts\core_common\callbacks_shared;
#using scripts\core_common\system_shared;
#using scripts\wz_common\character_unlock;

#namespace character_unlock_menendez;

// Namespace character_unlock_menendez/character_unlock_menendez
// Params 0, eflags: 0x2
// Checksum 0xe8a45264, Offset: 0xa0
// Size: 0x44
function autoexec __init__system__() {
    system::register(#"character_unlock_menendez", &__init__, undefined, #"character_unlock");
}

// Namespace character_unlock_menendez/character_unlock_menendez
// Params 0, eflags: 0x0
// Checksum 0x894e6770, Offset: 0xf0
// Size: 0x74
function __init__() {
    character_unlock::register_character_unlock(#"menendez_unlock", #"hash_77118b5dbb73e0b6", #"hash_46ee40479a819166", undefined, #"hash_3a0d4ebe6575c259");
    callback::on_player_killed_with_params(&on_player_killed);
}

// Namespace character_unlock_menendez/character_unlock_menendez
// Params 1, eflags: 0x0
// Checksum 0xe5b8c2c5, Offset: 0x170
// Size: 0x1dc
function on_player_killed(params) {
    attacker = params.eattacker;
    weapon = params.weapon;
    means = params.smeansofdeath;
    if (!isplayer(attacker) || !isdefined(weapon)) {
        return;
    }
    if (attacker.team === self.team) {
        return;
    }
    if (!attacker character_unlock::function_97763910(#"menendez_unlock")) {
        return;
    }
    if (means === "MOD_MELEE" || means === "MOD_MELEE_WEAPON_BUTT") {
        if (!isdefined(attacker.var_a31ccd55)) {
            attacker.var_a31ccd55 = 0;
        }
        attacker.var_a31ccd55++;
    } else if (weapon.name === #"shotgun_semiauto_t8" || weapon.name === #"shotgun_pump_t8") {
        if (!isdefined(attacker.var_656ed757)) {
            attacker.var_656ed757 = 0;
        }
        attacker.var_656ed757++;
    } else {
        return;
    }
    if (attacker.var_a31ccd55 === 1 && attacker.var_656ed757 === 1) {
        attacker character_unlock::function_4c582a05(#"menendez_unlock", #"hash_3a0d4ebe6575c259");
    }
}

