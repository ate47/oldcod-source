#using scripts\core_common\ai_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\gameobjects_shared;
#using scripts\core_common\util_shared;
#using scripts\killstreaks\ai\state;
#using scripts\killstreaks\ai\target;
#using scripts\killstreaks\ai\tracking;

#namespace ai_escort;

// Namespace ai_escort/escort
// Params 0, eflags: 0x0
// Checksum 0xaa9028d5, Offset: 0xa0
// Size: 0x74
function init() {
    ai_state::function_7014801d(1, &function_5bff774e, &update_escort, undefined, &update_enemy, &function_c1aee63, &function_7c8eb77, &update_debug);
}

// Namespace ai_escort/escort
// Params 5, eflags: 0x4
// Checksum 0xde92a3da, Offset: 0x120
// Size: 0xc2
function private init_escort(var_3a647eb2, var_38aa2f7a, var_b840f010, var_cf18ddfa, var_126d810e) {
    assert(isdefined(self.ai));
    self.ai.escort = {#state:2, #var_3a647eb2:var_3a647eb2, #var_38aa2f7a:var_38aa2f7a, #var_b840f010:var_b840f010, #var_cf18ddfa:var_cf18ddfa, #var_126d810e:var_126d810e};
}

// Namespace ai_escort/escort
// Params 1, eflags: 0x0
// Checksum 0xe6d034e4, Offset: 0x1f0
// Size: 0x84
function function_a137177d(bundle) {
    self.ai.bundle = bundle;
    init_escort(isdefined(bundle.var_2b2da48f) ? bundle.var_2b2da48f : 100, bundle.var_2f820a57, bundle.var_ed6f73a, bundle.var_d7d5f215, bundle.var_ef2fc081);
}

// Namespace ai_escort/escort
// Params 0, eflags: 0x0
// Checksum 0x6db51fa9, Offset: 0x280
// Size: 0x22
function function_5bff774e() {
    self.goalradius = self.ai.escort.var_3a647eb2;
}

// Namespace ai_escort/escort
// Params 0, eflags: 0x0
// Checksum 0xb1f219, Offset: 0x2b0
// Size: 0x4e
function function_c1aee63() {
    if (self function_4b46be84()) {
        return self.ai.escort.var_38aa2f7a;
    }
    return self.ai.escort.var_b840f010;
}

// Namespace ai_escort/escort
// Params 0, eflags: 0x0
// Checksum 0x91d80325, Offset: 0x308
// Size: 0xa
function function_7c8eb77() {
    return self.origin;
}

// Namespace ai_escort/escort
// Params 0, eflags: 0x0
// Checksum 0x75e5a389, Offset: 0x320
// Size: 0x2c
function function_4b46be84() {
    if (self.ai.escort.state == 1) {
        return true;
    }
    return false;
}

// Namespace ai_escort/escort
// Params 0, eflags: 0x0
// Checksum 0x9c2776e4, Offset: 0x358
// Size: 0x4e
function function_9128a0d3() {
    if (self.ai.escort.state == 1 || self.ai.escort.state == 2) {
        return true;
    }
    return false;
}

// Namespace ai_escort/escort
// Params 3, eflags: 0x4
// Checksum 0x808c3b8c, Offset: 0x3b0
// Size: 0x12c
function private function_35c5535b(current_point, var_fc7660d5, points) {
    new_points = [];
    var_766dbae3 = 10000;
    foreach (point in points) {
        dist = distancesquared(current_point, point.origin);
        if (dist < var_766dbae3) {
            continue;
        }
        dist = distancesquared(var_fc7660d5, point.origin);
        if (dist < var_766dbae3) {
            continue;
        }
        new_points[new_points.size] = point;
    }
    if (new_points.size == 0) {
        return points;
    }
    return new_points;
}

// Namespace ai_escort/escort
// Params 2, eflags: 0x0
// Checksum 0xf2bf4f74, Offset: 0x4e8
// Size: 0x2c
function function_ff40ba08(left, right) {
    return left.dot > right.dot;
}

// Namespace ai_escort/escort
// Params 1, eflags: 0x4
// Checksum 0xa106f366, Offset: 0x520
// Size: 0xda
function private function_8f3bc0a2(points) {
    if (points.size < 5) {
        new_points = arraycopy(points);
    } else {
        new_points = [];
        for (i = 0; i < points.size / 2 + 1; i++) {
            if (!isdefined(new_points)) {
                new_points = [];
            } else if (!isarray(new_points)) {
                new_points = array(new_points);
            }
            new_points[new_points.size] = points[i];
        }
    }
    return array::randomize(new_points);
}

// Namespace ai_escort/escort
// Params 0, eflags: 0x0
// Checksum 0x626ef928, Offset: 0x608
// Size: 0x4a
function function_afbb679d() {
    if (!isdefined(self.script_owner) || !isalive(self.script_owner)) {
        return self.origin;
    }
    return self.script_owner.origin;
}

// Namespace ai_escort/escort
// Params 0, eflags: 0x0
// Checksum 0x67560a93, Offset: 0x660
// Size: 0x1a2
function get_point_of_interest() {
    targets = self ai_target::get_targets();
    ai_target = arraygetclosest(self.origin, targets);
    var_555c60d2 = function_afbb679d();
    objective_target = gameobjects::function_90353b55(var_555c60d2);
    if (!isdefined(ai_target) && !isdefined(objective_target)) {
        return level.mapcenter;
    } else if (!isdefined(objective_target)) {
        return ai_target.origin;
    } else if (!isdefined(ai_target)) {
        return objective_target.origin;
    }
    ai_distance = distance(ai_target.origin, var_555c60d2);
    var_efcd2058 = distance(objective_target.origin, var_555c60d2);
    if (ai_distance + var_efcd2058 == 0) {
        return level.mapcenter;
    }
    coef = ai_distance / (ai_distance + var_efcd2058);
    origin = vectorlerp(ai_target.origin, objective_target.origin, coef);
    return origin;
}

// Namespace ai_escort/escort
// Params 0, eflags: 0x0
// Checksum 0x88079511, Offset: 0x810
// Size: 0x60e
function function_7045146a() {
    if (!function_9128a0d3()) {
        return;
    }
    var_555c60d2 = self function_afbb679d();
    if (!isdefined(var_555c60d2)) {
        return;
    }
    if (!ispointonnavmesh(var_555c60d2, self)) {
        return;
    }
    if (isdefined(self.isarriving) && self.isarriving) {
        return;
    }
    if (isactor(self) && (self asmistransdecrunning() || self asmistransitionrunning())) {
        return;
    }
    velocity = self.script_owner tracking::get_velocity();
    var_8ae0cb70 = self.script_owner getvelocity();
    cylinder = ai::t_cylinder(var_555c60d2, self.ai.escort.var_3a647eb2, 30);
    tacpoints = undefined;
    if (lengthsquared(var_8ae0cb70) > 20 && isdefined(velocity) && !(isdefined(self.ai.var_1bf4a5cc) && self.ai.var_1bf4a5cc)) {
        var_60b8e47f = var_555c60d2 + vectorscale(vectornormalize(velocity), 100);
        var_60b8e47f = getclosestpointonnavmesh(var_60b8e47f, 100);
        if (isdefined(var_60b8e47f) && isdefined(self.ai.escort.var_126d810e)) {
            var_60b8e47f = checknavmeshdirection(var_555c60d2, var_60b8e47f - var_555c60d2, 100, 0);
            if (isdefined(var_60b8e47f)) {
                /#
                    recordsphere(var_60b8e47f, 8, (0, 1, 1), "<dev string:x30>");
                #/
                var_692d78b9 = ai::t_cylinder(var_555c60d2, 80, 30);
                assert(isdefined(var_692d78b9.origin));
                tacpoints = tacticalquery(self.ai.escort.var_126d810e, cylinder, self, var_692d78b9, var_60b8e47f, var_555c60d2);
            }
        }
    } else {
        var_60b8e47f = var_555c60d2 + vectorscale(anglestoforward((0, self.script_owner.angles[1], 0)), 300);
        var_60b8e47f = getclosestpointonnavmesh(var_60b8e47f, 200);
        if (isdefined(var_60b8e47f) && isdefined(self.ai.escort.var_126d810e)) {
            var_60b8e47f = checknavmeshdirection(var_555c60d2, var_60b8e47f - var_555c60d2, 300, 0);
            if (isdefined(var_60b8e47f)) {
                /#
                    recordsphere(var_60b8e47f, 8, (1, 0.5, 0), "<dev string:x30>");
                #/
                cylinder = ai::t_cylinder(var_60b8e47f, self.ai.escort.var_3a647eb2, 30);
                var_db1ad975 = ai::t_cylinder(self.origin, 200, 30);
                assert(isdefined(var_db1ad975.origin));
                tacpoints = tacticalquery(self.ai.escort.var_126d810e, cylinder, self, var_db1ad975, var_60b8e47f, var_555c60d2);
            } else {
                /#
                    recordsphere(var_60b8e47f, 8, (1, 0, 0), "<dev string:x30>");
                #/
            }
        }
    }
    if (!isdefined(tacpoints) || tacpoints.size == 0) {
        tacpoints = tacticalquery(self.ai.escort.var_cf18ddfa, cylinder, self);
    }
    if (isdefined(tacpoints) && tacpoints.size != 0) {
        self.var_df93a596 = tacpoints;
        newpos = tacpoints[0].origin;
        if (isdefined(newpos)) {
            self.ai.escort.var_684108fb = var_555c60d2;
            self.ai.escort.var_329c2fe9 = gettime();
            self setgoal(newpos);
            self function_3c8dce03(newpos);
            if (isdefined(self.ai.var_1bf4a5cc) && self.ai.var_1bf4a5cc) {
                self.ai.var_1bf4a5cc = 0;
            }
        }
    }
}

// Namespace ai_escort/escort
// Params 0, eflags: 0x0
// Checksum 0x5c778451, Offset: 0xe28
// Size: 0x54
function function_48637ea5() {
    goalinfo = self function_e9a79b0e();
    if (!isdefined(goalinfo.var_7e7e6ebb) || goalinfo.var_7e7e6ebb) {
        return true;
    }
    return false;
}

// Namespace ai_escort/escort
// Params 0, eflags: 0x0
// Checksum 0x3f1aaedc, Offset: 0xe88
// Size: 0x32e
function function_f37de7e0() {
    var_555c60d2 = self function_afbb679d();
    goalinfo = self function_e9a79b0e();
    if (isdefined(self.ai.var_41ac9f40) && self.ai.var_41ac9f40) {
        self.ai.var_41ac9f40 = 0;
        return true;
    }
    if (isdefined(self.ai.escort.var_684108fb)) {
        if (distancesquared(self.ai.escort.var_684108fb, var_555c60d2) >= self.ai.escort.var_3a647eb2 * self.ai.escort.var_3a647eb2) {
            return true;
        }
    } else if (distancesquared(self.origin, var_555c60d2) >= self.ai.escort.var_3a647eb2 * self.ai.escort.var_3a647eb2) {
        return true;
    }
    var_555c60d2 = self function_afbb679d();
    if (isdefined(var_555c60d2) && isdefined(self.ai.escort.var_329c2fe9) && gettime() > self.ai.escort.var_329c2fe9 + randomintrange(3000, 4000)) {
        if (isdefined(self.script_owner) && isdefined(self.script_owner.angles)) {
            if (!util::within_fov(var_555c60d2, self.script_owner.angles, self.origin, cos(50))) {
                return true;
            }
        }
    }
    if (isdefined(self.ai.escort.var_684108fb) && isdefined(self.ai.escort.var_329c2fe9) && !self haspath()) {
        if (isdefined(var_555c60d2) && gettime() > self.ai.escort.var_329c2fe9 + randomintrange(10000, 12000)) {
            if (distancesquared(self.ai.escort.var_684108fb, var_555c60d2) <= 350 * 350) {
                self.ai.var_1bf4a5cc = 1;
                return true;
            }
        }
    }
    return false;
}

// Namespace ai_escort/escort
// Params 0, eflags: 0x0
// Checksum 0xfa7817b, Offset: 0x11c0
// Size: 0x2c
function update_escort() {
    if (function_f37de7e0()) {
        self function_7045146a();
    }
}

// Namespace ai_escort/escort
// Params 0, eflags: 0x0
// Checksum 0xbd79043a, Offset: 0x11f8
// Size: 0x86
function update_enemy() {
    if (isdefined(self.ai.hasseenfavoriteenemy) && self.ai.hasseenfavoriteenemy) {
        self.ai.escort.state = 0;
        return;
    }
    if (self.ai.escort.state == 0) {
        self.ai.escort.state = 2;
    }
}

// Namespace ai_escort/escort
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x1288
// Size: 0x4
function update_debug() {
    
}

