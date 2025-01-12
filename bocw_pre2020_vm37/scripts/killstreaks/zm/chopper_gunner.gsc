#using script_72d96920f15049b8;
#using scripts\core_common\array_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\values_shared;
#using scripts\core_common\vehicle_ai_shared;
#using scripts\zm_common\zm_player;
#using scripts\zm_common\zm_zonemgr;

#namespace chopper_gunner;

// Namespace chopper_gunner/chopper_gunner
// Params 0, eflags: 0x6
// Checksum 0x113e0e91, Offset: 0xd0
// Size: 0x54
function private autoexec __init__system__() {
    system::register(#"chopper_gunner", &function_70a657d8, undefined, &function_3675de8b, #"killstreaks");
}

// Namespace chopper_gunner/chopper_gunner
// Params 0, eflags: 0x5 linked
// Checksum 0xaeaff2e1, Offset: 0x130
// Size: 0x56
function private function_70a657d8() {
    profilestart();
    level.var_2d4792e7 = &function_5160bb1e;
    namespace_e8c18978::function_70a657d8("killstreak_chopper_gunner");
    zm_player::register_player_damage_callback(&function_728f72a5);
    profilestop();
}

// Namespace chopper_gunner/chopper_gunner
// Params 0, eflags: 0x5 linked
// Checksum 0xe5280449, Offset: 0x190
// Size: 0x14
function private function_3675de8b() {
    namespace_e8c18978::function_3675de8b();
}

// Namespace chopper_gunner/chopper_gunner
// Params 0, eflags: 0x5 linked
// Checksum 0x4b7754cf, Offset: 0x1b0
// Size: 0x158
function private function_5160bb1e() {
    player = self;
    player endon(#"disconnect");
    level endon(#"end_game");
    assert(!isdefined(level.chopper_gunner));
    player thread function_48170f5e();
    player.chopper_zone = player zm_zonemgr::function_e6d10d94();
    var_d6940e18 = namespace_e8c18978::function_5160bb1e();
    if (var_d6940e18) {
        player thread function_8afd7b25();
        if (isbot(player)) {
            player thread function_25d9a09f(level.chopper_gunner);
        }
    } else {
        player notify(#"hash_44a9bac1e035f9a3");
        player val::reset(#"chopper_gunner", "ignoreme");
    }
    return var_d6940e18;
}

// Namespace chopper_gunner/chopper_gunner
// Params 0, eflags: 0x1 linked
// Checksum 0x1f9fefc5, Offset: 0x310
// Size: 0xfc
function function_48170f5e() {
    level endon(#"end_game");
    self endon(#"disconnect", #"hash_44a9bac1e035f9a3");
    waitresult = self waittilltimeout(2, #"gunner_left");
    if (waitresult._notify != "timeout") {
        return;
    }
    self val::set(#"chopper_gunner", "ignoreme", 1);
    self waittill(#"gunner_left");
    wait 2;
    self val::reset(#"chopper_gunner", "ignoreme");
}

// Namespace chopper_gunner/chopper_gunner
// Params 0, eflags: 0x1 linked
// Checksum 0xfe303b5f, Offset: 0x418
// Size: 0x8c
function function_8afd7b25() {
    level endon(#"end_game");
    self endon(#"disconnect", #"gunner_left");
    if (!is_true(self.laststand)) {
        self waittill(#"player_downed");
    }
    level thread namespace_e8c18978::function_cf58dcdd(self, 1);
}

// Namespace chopper_gunner/chopper_gunner
// Params 1, eflags: 0x1 linked
// Checksum 0x80009d62, Offset: 0x4b0
// Size: 0x27c
function function_25d9a09f(vehicle) {
    vehicle endon(#"hash_6668be249f2eab45");
    self endon(#"disconnect");
    waitframe(1);
    while (self isremotecontrolling()) {
        enemy = undefined;
        enemies = array::randomize(enemies);
        foreach (var_607bb54c in enemies) {
            if (isalive(var_607bb54c)) {
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

// Namespace chopper_gunner/chopper_gunner
// Params 10, eflags: 0x5 linked
// Checksum 0x88291cd8, Offset: 0x738
// Size: 0x94
function private function_728f72a5(*einflictor, eattacker, *idamage, *idflags, *smeansofdeath, weapon, *vpoint, *vdir, *shitloc, *psoffsettime) {
    if (shitloc === self && psoffsettime == getweapon(#"hash_1734871fef9c0549")) {
        return 20;
    }
    return -1;
}

