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
function autoexec __init__sytem__() {
    system::register("replay_gun", &__init__, undefined, undefined);
}

// Namespace replay_gun/replay_gun
// Params 0, eflags: 0x0
// Checksum 0x77ca5db8, Offset: 0x260
// Size: 0x24
function __init__() {
    callback::on_spawned(&watch_for_replay_gun);
}

// Namespace replay_gun/replay_gun
// Params 0, eflags: 0x0
// Checksum 0x88f76736, Offset: 0x290
// Size: 0xb0
function watch_for_replay_gun() {
    self endon(#"disconnect");
    self endon(#"death");
    self endon(#"spawned_player");
    self endon(#"killReplayGunMonitor");
    while (true) {
        waitresult = self waittill("weapon_change_complete");
        if (isdefined(waitresult.weapon.usespivottargeting) && waitresult.weapon.usespivottargeting) {
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
                target = self get_a_target(weapon);
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
function get_a_target(weapon) {
    origin = self getweaponmuzzlepoint();
    forward = self getweaponforwarddir();
    targets = self get_potential_targets();
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
        testorigin = get_target_lock_on_origin(testtarget);
        test_range = distance(origin, testorigin);
        if (test_range > weapon.lockonmaxrange || test_range < weapon.lockonminrange) {
            continue;
        }
        normal = vectornormalize(testorigin - origin);
        dot = vectordot(forward, normal);
        if (0 > dot) {
            continue;
        }
        if (!self inside_screen_crosshair_radius(testorigin, weapon)) {
            continue;
        }
        cansee = self can_see_projected_crosshair(testtarget, testorigin, origin, forward, test_range);
        should_wait = 1;
        if (cansee) {
            validtargets[validtargets.size] = testtarget;
        }
    }
    return pick_a_target_from(validtargets);
}

// Namespace replay_gun/replay_gun
// Params 0, eflags: 0x0
// Checksum 0x1efe321f, Offset: 0x730
// Size: 0x106
function get_potential_targets() {
    str_opposite_team = "axis";
    if (self.team == "axis") {
        str_opposite_team = "allies";
    }
    potentialtargets = [];
    aitargets = getaiteamarray(str_opposite_team);
    if (aitargets.size > 0) {
        potentialtargets = arraycombine(potentialtargets, aitargets, 1, 0);
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
function pick_a_target_from(targets) {
    if (!isdefined(targets)) {
        return undefined;
    }
    besttarget = undefined;
    besttargetdistancesquared = undefined;
    for (i = 0; i < targets.size; i++) {
        target = targets[i];
        if (is_valid_target(target)) {
            targetdistancesquared = distancesquared(self.origin, target.origin);
            if (!isdefined(besttarget) || !isdefined(besttargetdistancesquared)) {
                besttarget = target;
                besttargetdistancesquared = targetdistancesquared;
                continue;
            }
            if (targetdistancesquared < besttargetdistancesquared) {
                besttarget = target;
                besttargetdistancesquared = targetdistancesquared;
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
function can_see_projected_crosshair(target, target_origin, player_origin, player_forward, distance) {
    crosshair = player_origin + player_forward * distance;
    collided = target trace(target_origin, crosshair);
    if (distance2dsquared(crosshair, collided) > 9) {
        return false;
    }
    collided = self trace(player_origin, crosshair);
    if (distance2dsquared(crosshair, collided) > 9) {
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
function inside_screen_crosshair_radius(testorigin, weapon) {
    radius = weapon.lockonscreenradius;
    return self inside_screen_radius(testorigin, radius);
}

// Namespace replay_gun/replay_gun
// Params 1, eflags: 0x0
// Checksum 0xacc4ffff, Offset: 0xb38
// Size: 0x4a
function inside_screen_lockon_radius(targetorigin) {
    radius = self getlockonradius();
    return self inside_screen_radius(targetorigin, radius);
}

// Namespace replay_gun/replay_gun
// Params 2, eflags: 0x0
// Checksum 0xf2d2f8a1, Offset: 0xb90
// Size: 0x3a
function inside_screen_radius(targetorigin, radius) {
    return target_originisincircle(targetorigin, self, 65, radius);
}

// Namespace replay_gun/replay_gun
// Params 1, eflags: 0x0
// Checksum 0x2f8d3c6c, Offset: 0xbd8
// Size: 0x22
function get_target_lock_on_origin(target) {
    return self getlockonorigin(target);
}

