#using scripts\core_common\callbacks_shared;
#using scripts\core_common\system_shared;
#using scripts\wz_common\character_unlock;

#namespace character_unlock_battery;

// Namespace character_unlock_battery/character_unlock_battery
// Params 0, eflags: 0x2
// Checksum 0xce1ff7c5, Offset: 0x80
// Size: 0x44
function autoexec __init__system__() {
    system::register(#"character_unlock_battery", &__init__, undefined, #"character_unlock");
}

// Namespace character_unlock_battery/character_unlock_battery
// Params 0, eflags: 0x0
// Checksum 0x42282a25, Offset: 0xd0
// Size: 0x74
function __init__() {
    character_unlock::register_character_unlock(#"battery_unlock", #"hash_7f410b145dce17bd", #"warmachine_wz_item", undefined, #"hash_c5713430b8fb888");
    callback::on_player_killed_with_params(&on_player_killed);
}

// Namespace character_unlock_battery/character_unlock_battery
// Params 1, eflags: 0x0
// Checksum 0x7c695c51, Offset: 0x150
// Size: 0x134
function on_player_killed(params) {
    attacker = params.eattacker;
    weapon = params.weapon;
    if (!isplayer(attacker) || !isdefined(weapon)) {
        return;
    }
    if (weapon.name != #"hero_pineapple_grenade") {
        return;
    }
    if (attacker.team === self.team) {
        return;
    }
    if (!attacker character_unlock::function_97763910(#"battery_unlock")) {
        return;
    }
    if (!isdefined(attacker.var_4f329e13)) {
        attacker.var_4f329e13 = 0;
    }
    attacker.var_4f329e13++;
    if (attacker.var_4f329e13 == 2) {
        attacker character_unlock::function_4c582a05(#"battery_unlock", #"hash_c5713430b8fb888");
    }
}

