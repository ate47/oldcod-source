#using scripts\core_common\callbacks_shared;
#using scripts\core_common\status_effects\status_effect_util;
#using scripts\core_common\system_shared;
#using scripts\killstreaks\killstreaks_shared;
#using scripts\weapons\weapons;

#namespace namespace_e039b91b;

// Namespace namespace_e039b91b/namespace_e039b91b
// Params 0, eflags: 0x6
// Checksum 0x69ca8408, Offset: 0xe0
// Size: 0x44
function private autoexec __init__system__() {
    system::register(#"hash_2f57ca5f4826ec5b", &__init__, undefined, undefined, #"killstreaks");
}

// Namespace namespace_e039b91b/namespace_e039b91b
// Params 0, eflags: 0x1 linked
// Checksum 0xc7068102, Offset: 0x130
// Size: 0x4c
function __init__() {
    killstreaks::register_killstreak("killstreak_sparrow", &killstreaks::function_fc82c544);
    callback::on_player_damage(&onplayerdamage);
}

// Namespace namespace_e039b91b/missile_fire
// Params 1, eflags: 0x40
// Checksum 0xd313ab0d, Offset: 0x188
// Size: 0xac
function event_handler[missile_fire] function_8cd77cf6(eventstruct) {
    if (!isplayer(self)) {
        return;
    }
    missile = eventstruct.projectile;
    weapon = eventstruct.weapon;
    if (function_119a2a90(weapon)) {
        missile.soundmod = "player";
        missile thread weapons::check_stuck_to_player(1, 0, weapon);
    }
    missile thread function_a252eaf0(self, weapon);
}

// Namespace namespace_e039b91b/namespace_e039b91b
// Params 2, eflags: 0x1 linked
// Checksum 0x1dee5539, Offset: 0x240
// Size: 0x50
function function_a252eaf0(player, weapon) {
    self waittill(#"death");
    if (isdefined(level.var_f5c624c2)) {
        self [[ level.var_f5c624c2 ]](player, weapon);
    }
}

// Namespace namespace_e039b91b/namespace_e039b91b
// Params 1, eflags: 0x5 linked
// Checksum 0xdae6edad, Offset: 0x298
// Size: 0xac
function private onplayerdamage(params) {
    weapon = params.weapon;
    if (!function_119a2a90(weapon)) {
        return;
    }
    if (params.smeansofdeath == "MOD_DOT") {
        return;
    }
    statuseffect = getstatuseffect("dot_sig_bow_flame");
    self status_effect::status_effect_apply(statuseffect, weapon, params.eattacker, 0, undefined, undefined, params.vpoint);
}

// Namespace namespace_e039b91b/namespace_e039b91b
// Params 1, eflags: 0x5 linked
// Checksum 0x391b5714, Offset: 0x350
// Size: 0x20
function private function_119a2a90(weapon) {
    return weapon.statname == "sig_bow_flame";
}

