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
// Checksum 0x7426f8c4, Offset: 0xb0
// Size: 0x54
function private autoexec __init__system__() {
    system::register(#"ac130", &function_70a657d8, undefined, &function_3675de8b, #"killstreaks");
}

// Namespace ac130_mp/ac130
// Params 0, eflags: 0x5 linked
// Checksum 0xc67d4f8b, Offset: 0x110
// Size: 0x5e
function private function_70a657d8() {
    profilestart();
    player::function_cf3aa03d(&function_d45a1f8d, 1);
    level.var_f987766c = &spawnac130;
    namespace_2d34cefc::function_70a657d8("killstreak_ac130");
    profilestop();
}

// Namespace ac130_mp/ac130
// Params 0, eflags: 0x5 linked
// Checksum 0xbfcd272, Offset: 0x178
// Size: 0x14
function private function_3675de8b() {
    namespace_2d34cefc::function_3675de8b();
}

// Namespace ac130_mp/ac130
// Params 0, eflags: 0x5 linked
// Checksum 0x5dddbb65, Offset: 0x198
// Size: 0x108
function private spawnac130() {
    player = self;
    player endon(#"disconnect");
    level endon(#"game_ended");
    assert(!isdefined(level.ac130));
    var_b0b764aa = namespace_2d34cefc::spawnac130();
    if (var_b0b764aa && isbot(player)) {
        player thread function_3939b657(level.ac130);
    }
    util::function_a3f7de13(21, player.team, player getentitynumber(), level.killstreaks[#"ac130"].uiname);
    return var_b0b764aa;
}

// Namespace ac130_mp/ac130
// Params 9, eflags: 0x1 linked
// Checksum 0xb8a4a32f, Offset: 0x2a8
// Size: 0x15c
function function_d45a1f8d(einflictor, attacker, *idamage, *smeansofdeath, weapon, *vdir, *shitloc, *psoffsettime, *deathanimduration) {
    if (!isdefined(shitloc) || !isdefined(shitloc.owner) || !isdefined(psoffsettime) || !isdefined(deathanimduration)) {
        return;
    }
    if (shitloc.owner == psoffsettime && (deathanimduration == getweapon(#"hash_17df39d53492b0bf") || deathanimduration == getweapon(#"hash_7b24d0d0d2823bca"))) {
        isprimaryweapon = deathanimduration == getweapon(#"hash_17df39d53492b0bf") ? 1 : 0;
        if (isdefined(level.ac130)) {
            level.ac130 namespace_2d34cefc::function_631f02c5(isprimaryweapon);
        }
    }
}

// Namespace ac130_mp/ac130
// Params 1, eflags: 0x1 linked
// Checksum 0x35d9fae3, Offset: 0x410
// Size: 0x2bc
function function_3939b657(vehicle) {
    vehicle endon(#"ac130_shutdown");
    self endon(#"disconnect");
    waitframe(1);
    while (self isremotecontrolling()) {
        enemy = undefined;
        enemies = self teams::getenemyplayers();
        enemies = array::randomize(enemies);
        foreach (var_607bb54c in enemies) {
            if (isalive(var_607bb54c) && !var_607bb54c hasperk(#"hash_37f82f1d672c4870")) {
                enemy = var_607bb54c;
                break;
            }
        }
        if (isdefined(enemy)) {
            vectorfromenemy = vectornormalize(((vehicle.origin - enemy.origin)[0], (vehicle.origin - enemy.origin)[1], 0));
            vehicle turretsettarget(0, enemy);
            vehicle waittilltimeout(1, #"turret_on_target");
            vehicle vehicle_ai::fire_for_time(2 + randomfloat(0.8), 0, enemy);
            vehicle vehicle_ai::fire_for_rounds(1, 1, enemy);
            vehicle turretcleartarget(0);
            vehicle turretsettargetangles(0, (15, 0, 0));
            if (isdefined(enemy)) {
                wait 2 + randomfloat(0.5);
            }
        }
        wait 0.1;
    }
}

