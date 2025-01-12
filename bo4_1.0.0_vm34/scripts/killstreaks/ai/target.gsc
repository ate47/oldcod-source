#using scripts\core_common\targetting_delay;

#namespace ai_target;

// Namespace ai_target/target
// Params 1, eflags: 0x0
// Checksum 0x6f0a6cb5, Offset: 0x88
// Size: 0x154
function is_target_valid(target) {
    if (!isdefined(target)) {
        return false;
    }
    if (!isalive(target)) {
        return false;
    }
    if (isplayer(target) && target.sessionstate == "spectator") {
        return false;
    }
    if (isplayer(target) && target.sessionstate == "intermission") {
        return false;
    }
    if (isdefined(level.intermission) && level.intermission) {
        return false;
    }
    if (isdefined(target.ignoreme) && target.ignoreme) {
        return false;
    }
    if (target isnotarget()) {
        return false;
    }
    if (issentient(target) && self function_cf6a62c(target)) {
        return false;
    }
    if (self.team == target.team) {
        return false;
    }
    return true;
}

// Namespace ai_target/target
// Params 0, eflags: 0x0
// Checksum 0x3223f32c, Offset: 0x1e8
// Size: 0x130
function get_targets() {
    targets = [];
    targets = arraycombine(getplayers(), getactorarray(), 0, 0);
    valid_targets = [];
    foreach (target in targets) {
        if (!is_target_valid(target)) {
            continue;
        }
        if (!isdefined(valid_targets)) {
            valid_targets = [];
        } else if (!isarray(valid_targets)) {
            valid_targets = array(valid_targets);
        }
        valid_targets[valid_targets.size] = target;
    }
    return valid_targets;
}

// Namespace ai_target/target
// Params 2, eflags: 0x0
// Checksum 0x608b3c2a, Offset: 0x320
// Size: 0x318
function function_a8f13fc2(attack_origin, var_38aa2f7a) {
    targets = self get_targets();
    var_8fbca9d8 = var_38aa2f7a * var_38aa2f7a;
    least_hunted = undefined;
    closest_target_dist_squared = undefined;
    foreach (target in targets) {
        if (!isdefined(target.hunted_by)) {
            target.hunted_by = 0;
        }
        attackedrecently = 0;
        if (issentient(target)) {
            attackedrecently = target attackedrecently(self, 3);
            if (isdefined(attackedrecently) && attackedrecently) {
                return target;
            }
        }
        if (self function_cf6a62c(target)) {
            continue;
        }
        if (isplayer(target) && target isgrappling()) {
            continue;
        }
        if (!isdefined(getclosestpointonnavmesh(target.origin, 200, 1.2 * self getpathfindingradius()))) {
            continue;
        }
        dist_squared = distancesquared(attack_origin, target.origin);
        var_59ee2e8a = isplayer(target) ? target function_b212bfdb() : 1;
        var_28983dc2 = var_8fbca9d8 * var_59ee2e8a;
        if (dist_squared > var_28983dc2) {
            continue;
        }
        if (!self is_target_valid(least_hunted)) {
            least_hunted = target;
        }
        if (target.hunted_by <= least_hunted.hunted_by && (!isdefined(closest_target_dist_squared) || dist_squared < closest_target_dist_squared)) {
            least_hunted = target;
            closest_target_dist_squared = dist_squared;
        }
    }
    if (!self is_target_valid(least_hunted)) {
        return undefined;
    }
    least_hunted.hunted_by += 1;
    return least_hunted;
}

// Namespace ai_target/target
// Params 2, eflags: 0x0
// Checksum 0xf6d6c975, Offset: 0x640
// Size: 0x152
function function_6d248fa0(attack_origin, var_38aa2f7a) {
    targets = self get_targets();
    valid_targets = [];
    var_8fbca9d8 = var_38aa2f7a * var_38aa2f7a;
    foreach (target in targets) {
        dist_squared = distancesquared(attack_origin, target.origin);
        if (dist_squared > var_8fbca9d8) {
            continue;
        }
        if (self function_cf6a62c(target)) {
            continue;
        }
        if (self is_target_valid(target)) {
            valid_targets[valid_targets.size] = target;
        }
    }
    if (valid_targets.size) {
        return valid_targets[0];
    }
    return undefined;
}

