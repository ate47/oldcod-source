#using script_590bc513b5881751;
#using scripts\core_common\array_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\vehicle_ai_shared;
#using scripts\mp_common\player\player_utils;
#using scripts\mp_common\teams\teams;
#using scripts\mp_common\util;

#namespace ac130_mp;

// Namespace ac130_mp/ac130
// Params 0, eflags: 0x6
// Checksum 0xf9c2a9b8, Offset: 0xb0
// Size: 0x54
function private autoexec __init__system__() {
    system::register(#"ac130", &preinit, undefined, &function_3675de8b, #"killstreaks");
}

// Namespace ac130_mp/ac130
// Params 0, eflags: 0x4
// Checksum 0xcf0c9be2, Offset: 0x110
// Size: 0x5e
function private preinit() {
    profilestart();
    player::function_cf3aa03d(&function_d45a1f8d, 1);
    level.var_f987766c = &spawnac130;
    ac130_shared::preinit("killstreak_ac130");
    profilestop();
}

// Namespace ac130_mp/ac130
// Params 0, eflags: 0x4
// Checksum 0x761092b, Offset: 0x178
// Size: 0x14
function private function_3675de8b() {
    ac130_shared::function_3675de8b();
}

// Namespace ac130_mp/ac130
// Params 0, eflags: 0x4
// Checksum 0x7923bcda, Offset: 0x198
// Size: 0x108
function private spawnac130() {
    player = self;
    player endon(#"disconnect");
    level endon(#"game_ended");
    assert(!isdefined(level.ac130));
    var_b0b764aa = ac130_shared::spawnac130();
    if (var_b0b764aa && isbot(player)) {
        level.ac130 thread ac130_shared::function_a514a080(player);
    }
    util::function_a3f7de13(21, player.team, player getentitynumber(), level.killstreaks[#"ac130"].uiname);
    return var_b0b764aa;
}

// Namespace ac130_mp/ac130
// Params 9, eflags: 0x0
// Checksum 0x1e5f0676, Offset: 0x2a8
// Size: 0x15c
function function_d45a1f8d(einflictor, attacker, *idamage, *smeansofdeath, weapon, *vdir, *shitloc, *psoffsettime, *deathanimduration) {
    if (!isdefined(shitloc) || !isdefined(shitloc.owner) || !isdefined(psoffsettime) || !isdefined(deathanimduration)) {
        return;
    }
    if (shitloc.owner == psoffsettime && (deathanimduration == getweapon(#"hash_17df39d53492b0bf") || deathanimduration == getweapon(#"hash_7b24d0d0d2823bca"))) {
        isprimaryweapon = deathanimduration == getweapon(#"hash_17df39d53492b0bf") ? 1 : 0;
        if (isdefined(level.ac130)) {
            level.ac130 ac130_shared::function_631f02c5(isprimaryweapon);
        }
    }
}

// Namespace ac130_mp/ac130
// Params 1, eflags: 0x0
// Checksum 0x357700aa, Offset: 0x410
// Size: 0x64
function function_6b26dd0c(player) {
    self endon(#"death", #"ac130_shutdown");
    player endon(#"disconnect");
    wait 2;
    player thread ac130_shared::function_8721028e(player, 0, 1);
}

