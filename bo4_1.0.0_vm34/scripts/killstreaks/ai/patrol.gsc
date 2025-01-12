#using scripts\core_common\ai_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\entityheadicons_shared;
#using scripts\killstreaks\ai\state;
#using scripts\killstreaks\ai\target;

#namespace ai_patrol;

// Namespace ai_patrol/patrol
// Params 0, eflags: 0x0
// Checksum 0x410d0a59, Offset: 0xa0
// Size: 0x74
function init() {
    ai_state::function_7014801d(0, &function_ac06c6a8, &update_patrol, &function_60f371d, &update_enemy, &function_c1aee63, &function_7c8eb77);
}

// Namespace ai_patrol/patrol
// Params 10, eflags: 0x0
// Checksum 0x8c74dbcb, Offset: 0x120
// Size: 0x13a
function function_dc593858(patrol_radius, var_38aa2f7a, var_b840f010, marker_fx, marker_objective, var_6ca74c95, var_766dbae3, var_b9f3a1f7, var_cf18ddfa, var_50b67125) {
    assert(isdefined(self.ai));
    self.ai.patrol = {#state:2, #patrol_radius:patrol_radius, #var_38aa2f7a:var_38aa2f7a, #var_b840f010:var_b840f010, #marker_fx:marker_fx, #marker_objective:marker_objective, #var_6ca74c95:var_6ca74c95, #var_766dbae3:var_766dbae3, #var_b9f3a1f7:var_b9f3a1f7, #var_cf18ddfa:var_cf18ddfa, #var_50b67125:var_50b67125};
}

// Namespace ai_patrol/patrol
// Params 1, eflags: 0x0
// Checksum 0x3473b1cb, Offset: 0x268
// Size: 0x94
function function_8c3ba57b(bundle) {
    function_dc593858(bundle.var_390a3bd1, bundle.var_a92347f9, bundle.var_4e0ca4c0, bundle.var_7ebf0f38, bundle.objective, bundle.var_3d0b8c83, bundle.var_354df974, bundle.var_2ce74e8b, bundle.var_e95fd747, bundle.var_7fe16081);
}

// Namespace ai_patrol/patrol
// Params 0, eflags: 0x0
// Checksum 0xab5ac8ac, Offset: 0x308
// Size: 0xc4
function function_ac06c6a8() {
    self.ai.patrol.var_ed56a2f8 = gettime();
    self.goalradius = self.ai.patrol.patrol_radius;
    self function_9f59031e();
    self.ai.patrol.state = 2;
    if (isdefined(self.script_owner)) {
        self function_dd3cad1f(self.script_owner.origin);
        return;
    }
    self function_dd3cad1f(self.origin);
}

// Namespace ai_patrol/patrol
// Params 0, eflags: 0x0
// Checksum 0xe653bd8c, Offset: 0x3d8
// Size: 0x1c
function function_60f371d() {
    self function_333c5cf();
}

// Namespace ai_patrol/patrol
// Params 0, eflags: 0x0
// Checksum 0xf128e015, Offset: 0x400
// Size: 0x4e
function function_c1aee63() {
    if (self function_dbee156a()) {
        return self.ai.patrol.var_38aa2f7a;
    }
    return self.ai.patrol.var_b840f010;
}

// Namespace ai_patrol/patrol
// Params 0, eflags: 0x0
// Checksum 0x7ac6317e, Offset: 0x458
// Size: 0x3e
function function_7c8eb77() {
    if (self function_dbee156a()) {
        return self.ai.patrol.var_dc04218d;
    }
    return self.origin;
}

// Namespace ai_patrol/patrol
// Params 0, eflags: 0x0
// Checksum 0xf0f42255, Offset: 0x4a0
// Size: 0x2c
function function_dbee156a() {
    if (self.ai.patrol.state == 1) {
        return true;
    }
    return false;
}

// Namespace ai_patrol/patrol
// Params 0, eflags: 0x0
// Checksum 0xef21dd27, Offset: 0x4d8
// Size: 0x4e
function function_2dcd5bb1() {
    if (self.ai.patrol.state == 1 || self.ai.patrol.state == 2) {
        return true;
    }
    return false;
}

// Namespace ai_patrol/patrol
// Params 2, eflags: 0x4
// Checksum 0x448202c, Offset: 0x530
// Size: 0x110
function private function_92ef8279(current_point, points) {
    new_points = [];
    var_7d4b347b = self.ai.patrol.var_766dbae3 * self.ai.patrol.var_766dbae3;
    foreach (point in points) {
        dist2 = distancesquared(current_point, point.origin);
        if (dist2 < var_7d4b347b) {
            continue;
        }
        new_points[new_points.size] = point;
    }
    return new_points;
}

// Namespace ai_patrol/patrol
// Params 2, eflags: 0x0
// Checksum 0x80f3f47e, Offset: 0x648
// Size: 0x2c
function function_ff40ba08(left, right) {
    return left.dot > right.dot;
}

// Namespace ai_patrol/patrol
// Params 3, eflags: 0x4
// Checksum 0xd45491b6, Offset: 0x680
// Size: 0xe2
function private function_658f3508(origin, angles, points) {
    foreach (point in points) {
        point.dot = vectordot(self.var_ed839d0, vectornormalize(point.origin - origin));
    }
    return array::merge_sort(points, &function_ff40ba08);
}

// Namespace ai_patrol/patrol
// Params 1, eflags: 0x0
// Checksum 0xc34fe423, Offset: 0x770
// Size: 0x330
function function_a71d626d(var_dc04218d) {
    var_eb3f1bff = undefined;
    if (isdefined(self.script_owner) && isalive(self.script_owner)) {
        var_eb3f1bff = ai::t_cylinder(self.script_owner.origin, 200, self.ai.patrol.var_b9f3a1f7);
    } else {
        var_eb3f1bff = ai::t_cylinder(var_dc04218d, 200, self.ai.patrol.var_b9f3a1f7);
    }
    var_7b718f0 = ai_target::function_6d248fa0(var_dc04218d, self.ai.patrol.patrol_radius * 1.5);
    tacpoints = undefined;
    if (isdefined(var_7b718f0) && isdefined(self.ai.patrol.var_50b67125)) {
        closesttacpoint = getclosesttacpoint(var_7b718f0.origin);
        if (isdefined(closesttacpoint)) {
            cylinder = ai::t_cylinder(closesttacpoint.origin, 150, self.ai.patrol.var_b9f3a1f7);
            tacpoints = tacticalquery(self.ai.patrol.var_50b67125, cylinder, self, var_7b718f0, var_eb3f1bff);
            if (isdefined(tacpoints) && tacpoints.size) {
                self.ai.patrol.var_7b718f0 = var_7b718f0;
            }
        }
    }
    if (!isdefined(tacpoints) || tacpoints.size == 0) {
        cylinder = ai::t_cylinder(var_dc04218d, self.ai.patrol.patrol_radius, self.ai.patrol.var_b9f3a1f7);
        tacpoints = tacticalquery(self.ai.patrol.var_cf18ddfa, cylinder, self, var_eb3f1bff);
    }
    if (isdefined(tacpoints) && tacpoints.size) {
        tacpoints = function_92ef8279(self.origin, tacpoints);
        if (!isdefined(var_7b718f0) && isdefined(tacpoints) && tacpoints.size) {
            tacpoints = function_658f3508(self.origin, self.angles, tacpoints);
        }
    }
    if (!isdefined(tacpoints) || tacpoints.size == 0) {
        return undefined;
    }
    return tacpoints;
}

// Namespace ai_patrol/patrol
// Params 1, eflags: 0x0
// Checksum 0xe66cabcb, Offset: 0xaa8
// Size: 0x102
function function_6b476734(var_dc04218d) {
    if (!isdefined(self.var_ed839d0)) {
        self.var_ed839d0 = anglestoforward(self.angles);
    }
    tacpoints = self function_a71d626d(var_dc04218d);
    if (isdefined(tacpoints) && tacpoints.size > 0) {
        self.var_df93a596 = tacpoints;
        newpos = getclosestpointonnavmesh(tacpoints[0].origin, self.goalradius, self.ai.patrol.var_6ca74c95);
        if (isdefined(newpos)) {
            self.var_ed839d0 = vectornormalize(newpos - self.origin);
            return newpos;
        }
    }
    return undefined;
}

/#

    // Namespace ai_patrol/patrol
    // Params 1, eflags: 0x4
    // Checksum 0x427fb41d, Offset: 0xbb8
    // Size: 0x38
    function private is_debugging(dvar) {
        if (getdvarint(dvar, 0)) {
            return 1;
        }
        return 0;
    }

#/

// Namespace ai_patrol/patrol
// Params 0, eflags: 0x0
// Checksum 0x4718a9ae, Offset: 0xbf8
// Size: 0x54
function function_2bd82ccb() {
    goalinfo = self function_e9a79b0e();
    if (!isdefined(goalinfo.var_7e7e6ebb) || goalinfo.var_7e7e6ebb) {
        return true;
    }
    return false;
}

// Namespace ai_patrol/patrol
// Params 1, eflags: 0x0
// Checksum 0x5a08a7c7, Offset: 0xc58
// Size: 0xbc
function function_621865b2(radius) {
    if (self function_2bd82ccb()) {
        return true;
    }
    goalinfo = self function_e9a79b0e();
    if (isdefined(goalinfo.overridegoalpos)) {
        var_a5e16211 = radius;
        var_22e780cc = var_a5e16211 * var_a5e16211;
        if (distancesquared(goalinfo.overridegoalpos, self.origin) <= var_22e780cc) {
            return true;
        }
    }
    return false;
}

// Namespace ai_patrol/patrol
// Params 0, eflags: 0x0
// Checksum 0x6f24836f, Offset: 0xd20
// Size: 0x464
function update_patrol() {
    if (!self function_2dcd5bb1()) {
        return;
    }
    if (isdefined(self.isarriving) && self.isarriving) {
        return;
    }
    assert(isdefined(self.ai.patrol.var_dc04218d));
    goalinfo = self function_e9a79b0e();
    if (self.ai.patrol.state == 2) {
        self.goalradius = 150;
        if (!isdefined(goalinfo.overridegoalpos)) {
            newpos = getclosestpointonnavmesh(self.ai.patrol.var_dc04218d, self.goalradius, self.ai.patrol.var_6ca74c95);
            if (isdefined(newpos)) {
                self.ai.patrol.var_ed56a2f8 = gettime() + randomintrange(3000, 4500);
                self function_3c8dce03(newpos);
            }
        }
        var_6f78725e = function_621865b2(self.goalradius);
        if (var_6f78725e) {
            self.ai.patrol.var_ed56a2f8 = gettime() + randomintrange(2000, 3500);
            self.goalradius = self.ai.patrol.patrol_radius;
            self.ai.patrol.state = 1;
        }
    } else if (self.ai.patrol.state == 1) {
        var_5dc8bf06 = 0;
        var_6f78725e = function_621865b2(20);
        var_7b718f0 = ai_target::function_6d248fa0(self.ai.patrol.var_dc04218d, self.ai.patrol.patrol_radius * 1.5);
        var_ace27ca3 = 0;
        if (isdefined(var_7b718f0)) {
            if (!isdefined(self.ai.patrol.var_7b718f0) || self.ai.patrol.var_7b718f0 != var_7b718f0) {
                var_ace27ca3 = 1;
            }
        }
        if (!isdefined(goalinfo.overridegoalpos) || var_ace27ca3) {
            var_5dc8bf06 = 1;
        } else if (var_6f78725e) {
            if (gettime() >= self.ai.patrol.var_ed56a2f8) {
                var_5dc8bf06 = 1;
            }
        }
        if (var_5dc8bf06) {
            newpos = self function_6b476734(self.ai.patrol.var_dc04218d);
            if (isdefined(newpos)) {
                self function_3c8dce03(newpos);
            }
        }
    }
    /#
        recordcircle(self.ai.patrol.var_dc04218d, self.ai.patrol.patrol_radius, (0, 0, 1), "<dev string:x30>");
        recordcircle(self.ai.patrol.var_dc04218d, self.ai.patrol.var_38aa2f7a, (1, 0, 0), "<dev string:x30>");
    #/
}

// Namespace ai_patrol/patrol
// Params 0, eflags: 0x0
// Checksum 0x14c1fab6, Offset: 0x1190
// Size: 0x86
function update_enemy() {
    if (isdefined(self.ai.hasseenfavoriteenemy) && self.ai.hasseenfavoriteenemy) {
        self.ai.patrol.state = 0;
        return;
    }
    if (self.ai.patrol.state == 0) {
        self.ai.patrol.state = 2;
    }
}

// Namespace ai_patrol/patrol
// Params 1, eflags: 0x4
// Checksum 0x287b3e57, Offset: 0x1220
// Size: 0x10c
function private function_c9ebe475(origin) {
    if (isdefined(self.ai.patrol.marker_objective)) {
        owner = self.script_owner;
        self.var_e1311aea = spawn("script_model", origin);
        self.var_e1311aea.origin = origin;
        self.var_e1311aea entityheadicons::setentityheadicon(owner.team, owner, self.ai.patrol.marker_objective);
        headiconobjectiveid = self.var_e1311aea.entityheadobjectives[self.var_e1311aea.entityheadobjectives.size - 1];
        objective_setinvisibletoall(headiconobjectiveid);
        objective_setvisibletoplayer(headiconobjectiveid, owner);
    }
}

// Namespace ai_patrol/patrol
// Params 0, eflags: 0x4
// Checksum 0xda69fd4, Offset: 0x1338
// Size: 0x2c
function private function_8a011b59() {
    if (isdefined(self.var_e1311aea)) {
        self.var_e1311aea delete();
    }
}

// Namespace ai_patrol/patrol
// Params 1, eflags: 0x4
// Checksum 0xc63fede6, Offset: 0x1370
// Size: 0x11c
function private function_56c6681c(origin) {
    if (isdefined(self.script_owner) && isdefined(self.ai.patrol.marker_fx)) {
        self.var_2e80b1ad = spawnfx(self.ai.patrol.marker_fx, origin + (0, 0, 3), (0, 0, 1), (1, 0, 0));
        self.var_2e80b1ad.team = self.team;
        triggerfx(self.var_2e80b1ad);
        self.var_2e80b1ad setinvisibletoall();
        self.var_2e80b1ad setvisibletoplayer(self.script_owner);
        self.script_owner playsoundtoplayer(#"uin_mp_combat_bot_guard", self.script_owner);
    }
}

// Namespace ai_patrol/patrol
// Params 0, eflags: 0x4
// Checksum 0x1996aea6, Offset: 0x1498
// Size: 0x36
function private function_3166fa30() {
    if (isdefined(self.var_2e80b1ad)) {
        self.var_2e80b1ad delete();
        self.var_2e80b1ad = undefined;
    }
}

// Namespace ai_patrol/patrol
// Params 1, eflags: 0x4
// Checksum 0x4d4b4796, Offset: 0x14d8
// Size: 0x64
function private function_6ff15c73(origin) {
    self endon(#"death");
    self function_56c6681c(origin);
    self function_c9ebe475(origin);
    waitframe(1);
    self thread function_9146fe95();
}

// Namespace ai_patrol/patrol
// Params 0, eflags: 0x4
// Checksum 0x821fb601, Offset: 0x1548
// Size: 0x34
function private function_333c5cf() {
    self function_3166fa30();
    self function_8a011b59();
}

// Namespace ai_patrol/patrol
// Params 0, eflags: 0x4
// Checksum 0x9e1432fe, Offset: 0x1588
// Size: 0xcc
function private function_9146fe95() {
    self notify(#"hash_5824b020cde66d5");
    self endon(#"hash_5824b020cde66d5");
    fx_marker = self.var_2e80b1ad;
    hud_marker = self.var_e1311aea;
    self waittill(#"death", #"state_changed");
    if (isdefined(self)) {
        self function_333c5cf();
        return;
    }
    if (isdefined(fx_marker)) {
        fx_marker delete();
    }
    if (isdefined(hud_marker)) {
        hud_marker delete();
    }
}

// Namespace ai_patrol/patrol
// Params 1, eflags: 0x0
// Checksum 0x45920e77, Offset: 0x1660
// Size: 0x7c
function function_dd3cad1f(origin) {
    assert(isdefined(self.ai.patrol));
    self.ai.patrol.var_dc04218d = origin;
    self function_333c5cf();
    self thread function_6ff15c73(origin);
}

