#using scripts/core_common/abilities/ability_util;
#using scripts/core_common/array_shared;
#using scripts/core_common/callbacks_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/flagsys_shared;
#using scripts/core_common/hud_util_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;

#namespace replay_gun;

// Namespace replay_gun/replay_gun
// Params 0, eflags: 0x2
// Checksum 0x8a05b806, Offset: 0x220
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("replay_gun", &__init__, undefined, undefined);
}

// Namespace replay_gun/replay_gun
// Params 0, eflags: 0x0
// Checksum 0x77ca5db8, Offset: 0x260
// Size: 0x24
function __init__() {
    callback::on_spawned(&function_c0abd95b);
}

// Namespace replay_gun/replay_gun
// Params 0, eflags: 0x0
// Checksum 0x88f76736, Offset: 0x290
// Size: 0xb0
function function_c0abd95b() {
    self endon(#"disconnect");
    self endon(#"death");
    self endon(#"spawned_player");
    self endon(#"hash_23671b0c");
    while (true) {
        waitresult = self waittill("weapon_change_complete");
        if (isdefined(waitresult.weapon.var_c426fec0) && waitresult.weapon.var_c426fec0) {
            self thread watch_lockon(waitresult.weapon);
        }
    }
}

// Namespace replay_gun/replay_gun
// Params 1, eflags: 0x0
// Checksum 0x1508b2a0, Offset: 0x348
// Size: 0xf0
function watch_lockon(weapon) {
    self endon(#"disconnect");
    self endon(#"death");
    self endon(#"spawned_player");
    self endon(#"weapon_change_complete");
    while (true) {
        waitframe(1);
        if (!isdefined(self.lockonentity)) {
            ads = self playerads() == 1;
            if (ads) {
                target = self function_43c5e4e9(weapon);
                if (is_valid_target(target)) {
                    self weaponlockfree();
                    self.lockonentity = target;
                }
            }
        }
    }
}

// Namespace replay_gun/replay_gun
// Params 1, eflags: 0x0
// Checksum 0x7ef21edb, Offset: 0x440
// Size: 0x2e2
function function_43c5e4e9(weapon) {
    origin = self getweaponmuzzlepoint();
    forward = self getweaponforwarddir();
    targets = self function_42a6831f();
    if (!isdefined(targets)) {
        return undefined;
    }
    if (!isdefined(weapon.lockonscreenradius) || weapon.lockonscreenradius < 1) {
        return undefined;
    }
    validtargets = [];
    should_wait = 0;
    for (i = 0; i < targets.size; i++) {
        if (should_wait) {
            waitframe(1);
            origin = self getweaponmuzzlepoint();
            forward = self getweaponforwarddir();
            should_wait = 0;
        }
        testtarget = targets[i];
        if (!is_valid_target(testtarget)) {
            continue;
        }
        testorigin = function_9a6421f8(testtarget);
        var_58ef943 = distance(origin, testorigin);
        if (var_58ef943 > weapon.lockonmaxrange || var_58ef943 < weapon.lockonminrange) {
            continue;
        }
        normal = vectornormalize(testorigin - origin);
        dot = vectordot(forward, normal);
        if (0 > dot) {
            continue;
        }
        if (!self function_891f41a2(testorigin, weapon)) {
            continue;
        }
        cansee = self function_e96cb1d5(testtarget, testorigin, origin, forward, var_58ef943);
        should_wait = 1;
        if (cansee) {
            validtargets[validtargets.size] = testtarget;
        }
    }
    return function_c0064c09(validtargets);
}

// Namespace replay_gun/replay_gun
// Params 0, eflags: 0x0
// Checksum 0x1efe321f, Offset: 0x730
// Size: 0x106
function function_42a6831f() {
    var_ce588222 = "axis";
    if (self.team == "axis") {
        var_ce588222 = "allies";
    }
    potentialtargets = [];
    var_4174f437 = getaiteamarray(var_ce588222);
    if (var_4174f437.size > 0) {
        potentialtargets = arraycombine(potentialtargets, var_4174f437, 1, 0);
    }
    playertargets = self getenemies();
    if (playertargets.size > 0) {
        potentialtargets = arraycombine(potentialtargets, playertargets, 1, 0);
    }
    if (potentialtargets.size == 0) {
        return undefined;
    }
    return potentialtargets;
}

// Namespace replay_gun/replay_gun
// Params 1, eflags: 0x0
// Checksum 0xfff3acb5, Offset: 0x840
// Size: 0x120
function function_c0064c09(targets) {
    if (!isdefined(targets)) {
        return undefined;
    }
    besttarget = undefined;
    var_3cc7953c = undefined;
    for (i = 0; i < targets.size; i++) {
        target = targets[i];
        if (is_valid_target(target)) {
            var_a9b83e1e = distancesquared(self.origin, target.origin);
            if (!isdefined(besttarget) || !isdefined(var_3cc7953c)) {
                besttarget = target;
                var_3cc7953c = var_a9b83e1e;
                continue;
            }
            if (var_a9b83e1e < var_3cc7953c) {
                besttarget = target;
                var_3cc7953c = var_a9b83e1e;
            }
        }
    }
    return besttarget;
}

// Namespace replay_gun/replay_gun
// Params 2, eflags: 0x0
// Checksum 0x678c0c8b, Offset: 0x968
// Size: 0x3c
function trace(from, to) {
    return bullettrace(from, to, 0, self)["position"];
}

// Namespace replay_gun/replay_gun
// Params 5, eflags: 0x0
// Checksum 0xe23b5a02, Offset: 0x9b0
// Size: 0xec
function function_e96cb1d5(target, target_origin, player_origin, player_forward, distance) {
    crosshair = player_origin + player_forward * distance;
    var_ab69552f = target trace(target_origin, crosshair);
    if (distance2dsquared(crosshair, var_ab69552f) > 9) {
        return false;
    }
    var_ab69552f = self trace(player_origin, crosshair);
    if (distance2dsquared(crosshair, var_ab69552f) > 9) {
        return false;
    }
    return true;
}

// Namespace replay_gun/replay_gun
// Params 1, eflags: 0x0
// Checksum 0xc989a1ae, Offset: 0xaa8
// Size: 0x2a
function is_valid_target(ent) {
    return isdefined(ent) && isalive(ent);
}

// Namespace replay_gun/replay_gun
// Params 2, eflags: 0x0
// Checksum 0xc43cb479, Offset: 0xae0
// Size: 0x4a
function function_891f41a2(testorigin, weapon) {
    radius = weapon.lockonscreenradius;
    return self function_9814bbcd(testorigin, radius);
}

// Namespace replay_gun/replay_gun
// Params 1, eflags: 0x0
// Checksum 0xacc4ffff, Offset: 0xb38
// Size: 0x4a
function function_2718edba(targetorigin) {
    radius = self getlockonradius();
    return self function_9814bbcd(targetorigin, radius);
}

// Namespace replay_gun/replay_gun
// Params 2, eflags: 0x0
// Checksum 0xf2d2f8a1, Offset: 0xb90
// Size: 0x3a
function function_9814bbcd(targetorigin, radius) {
    return target_originisincircle(targetorigin, self, 65, radius);
}

// Namespace replay_gun/replay_gun
// Params 1, eflags: 0x0
// Checksum 0x2f8d3c6c, Offset: 0xbd8
// Size: 0x22
function function_9a6421f8(target) {
    return self getlockonorigin(target);
}

