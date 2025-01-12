#using scripts\core_common\callbacks_shared;
#using scripts\core_common\system_shared;
#using scripts\wz_common\character_unlock;

#namespace character_unlock_stanton;

// Namespace character_unlock_stanton/character_unlock_stanton
// Params 0, eflags: 0x2
// Checksum 0x15ab0802, Offset: 0x80
// Size: 0x44
function autoexec __init__system__() {
    system::register(#"character_unlock_stanton", &__init__, undefined, #"character_unlock");
}

// Namespace character_unlock_stanton/character_unlock_stanton
// Params 0, eflags: 0x0
// Checksum 0x22867fb5, Offset: 0xd0
// Size: 0x74
function __init__() {
    character_unlock::register_character_unlock(#"stanton_unlock", #"hash_4f0c567012b33fd9", #"hash_7b68c2ad890a1566", undefined, #"hash_5495584ec5e9f348");
    callback::on_player_killed_with_params(&on_player_killed);
}

// Namespace character_unlock_stanton/character_unlock_stanton
// Params 1, eflags: 0x0
// Checksum 0xdba06820, Offset: 0x150
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
    if (!attacker character_unlock::function_97763910(#"stanton_unlock")) {
        return;
    }
    if (weapon.name != #"eq_acid_bomb" && weapon.name != #"wraith_fire_fire" && weapon.name != #"eq_wraith_fire") {
        return;
    }
    if (!isdefined(attacker.var_51603a96)) {
        attacker.var_51603a96 = 0;
    }
    attacker.var_51603a96++;
    if (attacker.var_51603a96 == 1) {
        attacker character_unlock::function_4c582a05(#"stanton_unlock", #"hash_5495584ec5e9f348");
    }
}

