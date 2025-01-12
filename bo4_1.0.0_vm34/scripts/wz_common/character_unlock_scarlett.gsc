#using scripts\core_common\callbacks_shared;
#using scripts\core_common\system_shared;
#using scripts\wz_common\character_unlock;

#namespace character_unlock_scarlett;

// Namespace character_unlock_scarlett/character_unlock_scarlett
// Params 0, eflags: 0x2
// Checksum 0xfa14d36, Offset: 0xf8
// Size: 0x44
function autoexec __init__system__() {
    system::register(#"character_unlock_scarlett", &__init__, undefined, #"character_unlock");
}

// Namespace character_unlock_scarlett/character_unlock_scarlett
// Params 0, eflags: 0x0
// Checksum 0xd4831225, Offset: 0x148
// Size: 0x74
function __init__() {
    character_unlock::register_character_unlock(#"scarlett_unlock", #"hash_6f105a897d64112", #"hash_6de9ca4c359f93b", undefined, #"hash_698918780b4406f1");
    callback::on_player_killed_with_params(&on_player_killed);
}

// Namespace character_unlock_scarlett/character_unlock_scarlett
// Params 1, eflags: 0x0
// Checksum 0xc433648c, Offset: 0x1c8
// Size: 0x13c
function on_player_killed(params) {
    attacker = params.eattacker;
    weapon = params.weapon;
    if (!isplayer(attacker) || !isdefined(weapon)) {
        return;
    }
    if (weapon.name != "atv_camera_turret" && weapon.name != "turret_vehicle_boct_mil_truck_cargo" && weapon.name != "player_air_vehicle1_main_turret_3rd_person" && weapon.name != "turret_vehicle_zodiac") {
        return;
    }
    if (attacker.team === self.team) {
        return;
    }
    if (!attacker character_unlock::function_97763910(#"scarlett_unlock")) {
        return;
    }
    attacker character_unlock::function_4c582a05(#"scarlett_unlock", #"hash_698918780b4406f1");
}

