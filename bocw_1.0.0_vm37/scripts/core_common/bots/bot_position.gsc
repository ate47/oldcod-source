#using scripts\core_common\ai_shared;
#using scripts\core_common\bots\bot;
#using scripts\core_common\callbacks_shared;

#namespace bot_position;

// Namespace bot_position/bot_position
// Params 0, eflags: 0x0
// Checksum 0xf64d0b11, Offset: 0xe0
// Size: 0x54
function preinit() {
    callback::on_spawned(&on_player_spawned);
    callback::add_callback(#"hash_6efb8cec1ca372dc", &function_7291a729);
}

// Namespace bot_position/bot_position
// Params 0, eflags: 0x4
// Checksum 0xabf8a113, Offset: 0x140
// Size: 0x44
function private on_player_spawned() {
    if (!isbot(self)) {
        return;
    }
    self.bot.var_aa94cd1b = undefined;
    self thread handle_path_failed();
}

// Namespace bot_position/bot_position
// Params 0, eflags: 0x4
// Checksum 0x8eb93562, Offset: 0x190
// Size: 0x1c
function private function_7291a729() {
    self thread handle_path_failed();
}

// Namespace bot_position/bot_position
// Params 0, eflags: 0x4
// Checksum 0x21227e8a, Offset: 0x1b8
// Size: 0x164
function private handle_path_failed() {
    self endon(#"death", #"hash_6280ac8ed281ce3c");
    level endon(#"game_ended");
    while (true) {
        params = self waittill(#"bot_path_failed");
        switch (params.reason) {
        case 1:
        case 2:
        case 3:
            self function_5c6265b3();
            break;
        case 4:
        case 5:
        case 6:
            self function_ea3bf04e();
            break;
        case 7:
        case 8:
        default:
            self function_f894a675();
            break;
        }
        waitframe(1);
    }
}

// Namespace bot_position/bot_position
// Params 0, eflags: 0x4
// Checksum 0x69833b99, Offset: 0x328
// Size: 0x9c
function private function_5c6265b3() {
    clamped = self function_96f55844();
    /#
        if (clamped) {
            self function_b39b0b55(self.origin, (1, 1, 0), #"hash_759d0bab7057dad5");
            return;
        }
        self function_b39b0b55(self.origin, (1, 0, 0), #"hash_4470e824a8beb9f");
    #/
}

// Namespace bot_position/bot_position
// Params 0, eflags: 0x4
// Checksum 0xd30f3269, Offset: 0x3d0
// Size: 0xbc
function private function_ea3bf04e() {
    info = self function_4794d6a3();
    if (isdefined(info.overridegoalpos)) {
        self function_d4c687c9();
        /#
            self function_b39b0b55(self.origin, (1, 0, 0), #"hash_66a35a43ea2dfb1a");
        #/
        return;
    }
    /#
        self function_b39b0b55(self.origin, (1, 0, 0), #"hash_3d76685a084ca723");
    #/
}

// Namespace bot_position/bot_position
// Params 0, eflags: 0x4
// Checksum 0xa13bd708, Offset: 0x498
// Size: 0xbc
function private function_f894a675() {
    info = self function_4794d6a3();
    if (isdefined(info.overridegoalpos)) {
        self function_d4c687c9();
        /#
            self function_b39b0b55(self.origin, (1, 0, 0), #"hash_65622b578ee28d25");
        #/
        return;
    }
    /#
        self function_b39b0b55(self.origin, (1, 0, 0), #"hash_5ff132f70af932cc");
    #/
}

// Namespace bot_position/bot_position
// Params 0, eflags: 0x0
// Checksum 0xc52f0449, Offset: 0x560
// Size: 0x54e
function think() {
    pixbeginevent(#"");
    if (self.spawntime >= gettime() || self botundermanualcontrol()) {
        profilestop();
        return;
    }
    info = self function_4794d6a3();
    if (info.goalforced) {
        profilestop();
        return;
    }
    if (is_true(self.bot.var_6bea1d82) || self.bot.flashed || self isinexecutionvictim() || self isinexecutionattack() || self isplayinganimscripted() || self arecontrolsfrozen() || self function_5972c3cf()) {
        if (!is_true(info.var_9e404264)) {
            self set_position(self.origin, #"hold");
        }
        profilestop();
        return;
    }
    if (self bot::function_e5d7f472()) {
        trigger = self bot::function_85bfe6d3();
        if (!self function_794e2efa(trigger, info.overridegoalpos)) {
            self function_f14a768c(trigger, #"revive");
        }
    } else if (isdefined(self.bot.var_538135ed)) {
        trigger = self.bot.var_538135ed.gameobject.trigger;
        if (!self function_794e2efa(trigger, info.overridegoalpos)) {
            self function_f14a768c(trigger, #"hash_1dff7a8b83fc563c");
        }
    } else if (isdefined(info.overridegoalpos) && self function_e6f05ab6(info.overridegoalpos)) {
        self function_d4c687c9();
        self.bot.var_aa94cd1b = undefined;
    } else if (self.bot.var_e8c84f98) {
        if (!self function_e8a55078(info.overridegoalpos, info) || is_true(info.var_9e404264)) {
            if (!self function_7832483e(info)) {
                self function_d45bace(info);
            }
        } else {
            goalpoint = getclosesttacpoint(info.overridegoalpos);
            if (isdefined(goalpoint)) {
                if (!self function_de0e95b7(goalpoint)) {
                    self function_7832483e(info);
                }
            }
        }
    } else if (!self function_e8a55078(info.overridegoalpos, info)) {
        self function_d45bace(info);
    } else if (is_true(info.var_9e404264)) {
        if (!isdefined(self.bot.var_aa94cd1b)) {
            self.bot.var_aa94cd1b = gettime() + int(randomfloatrange(3, 7) * 1000);
        } else if (!isdefined(self.bot.var_aa94cd1b) || self.bot.var_aa94cd1b <= gettime()) {
            self function_d4c687c9();
            self.bot.var_aa94cd1b = undefined;
        }
    }
    /#
        info = self function_4794d6a3();
        if (isdefined(info.overridegoalpos) && isdefined(self.bot.var_8cfb4a08)) {
            self function_b39b0b55(info.overridegoalpos, (1, 0, 1), self.bot.var_8cfb4a08);
        }
    #/
    profilestop();
}

// Namespace bot_position/bot_position
// Params 2, eflags: 0x4
// Checksum 0x8f933273, Offset: 0xab8
// Size: 0x134
function private function_e8a55078(point, info) {
    if (!isdefined(point)) {
        return 0;
    }
    if (isdefined(info.regionid)) {
        tpoint = getclosesttacpoint(point);
        return (isdefined(tpoint) && info.regionid == tpoint.region);
    }
    if (isdefined(info.goalvolume)) {
        return self function_794e2efa(info.goalvolume, point);
    }
    goalorigin = info.goalpos;
    distsq = distance2dsquared(point, goalorigin);
    return distsq < info.goalradius * info.goalradius && point[2] < goalorigin[2] + info.goalheight && point[2] > goalorigin[2] - info.goalheight;
}

// Namespace bot_position/bot_position
// Params 2, eflags: 0x4
// Checksum 0x2366e61c, Offset: 0xbf8
// Size: 0xe2
function private function_794e2efa(trigger, point) {
    if (!isdefined(point)) {
        return false;
    }
    midpoint = point + (0, 0, 36);
    if (!isdefined(point) || !trigger istouching(midpoint, (0, 0, 36))) {
        return false;
    }
    if (trigger.classname != #"trigger_radius_use") {
        return true;
    }
    radius = trigger getmaxs()[0] + -32;
    return distance2dsquared(trigger.origin, point) < radius * radius;
}

// Namespace bot_position/bot_position
// Params 1, eflags: 0x4
// Checksum 0x631f65ab, Offset: 0xce8
// Size: 0xf4
function private function_de0e95b7(tpoint) {
    var_63e5d5aa = self.enemy getcentroid();
    if (issentient(self.enemy)) {
        var_63e5d5aa = self.enemy geteye();
    }
    if (!function_96c81b85(tpoint, var_63e5d5aa)) {
        /#
            if (self function_b39b0b55(tpoint.origin, (1, 0, 0), #"hash_53dde4c9c6077ed0")) {
                recordline(tpoint.origin + (0, 0, 70), var_63e5d5aa, (1, 0, 0), "<dev string:x38>", self);
            }
        #/
        return false;
    }
    return true;
}

// Namespace bot_position/bot_position
// Params 0, eflags: 0x4
// Checksum 0x99651838, Offset: 0xde8
// Size: 0xc0
function private function_96f55844() {
    navmeshpoint = function_13796beb(self.origin);
    if (!isdefined(navmeshpoint)) {
        return false;
    }
    var_5245725e = (navmeshpoint[0], navmeshpoint[1], self.origin[2]);
    self setorigin(var_5245725e);
    velocity = self getvelocity();
    self setvelocity((0, 0, velocity[2]));
    return true;
}

// Namespace bot_position/bot_position
// Params 1, eflags: 0x0
// Checksum 0x7a10ae82, Offset: 0xeb0
// Size: 0x3a
function function_13796beb(point) {
    return getclosestpointonnavmesh(point, 64, 16);
}

// Namespace bot_position/bot_position
// Params 2, eflags: 0x4
// Checksum 0xdc78f7ec, Offset: 0xef8
// Size: 0x1be
function private function_f14a768c(trigger, var_e125ba43) {
    pixbeginevent(#"");
    dir = trigger.origin - self.origin;
    dist = distance2d(trigger.origin, self.origin);
    radius = self getpathfindingradius();
    tracepoint = checknavmeshdirection(self.origin, dir, dist, radius);
    if (isdefined(tracepoint) && self function_794e2efa(trigger, tracepoint)) {
        self set_position(tracepoint, var_e125ba43);
        profilestop();
        return;
    }
    var_1ccbeeaa = self function_13796beb(trigger.origin);
    if (isdefined(var_1ccbeeaa) && self function_794e2efa(trigger, var_1ccbeeaa)) {
        self set_position(var_1ccbeeaa, var_e125ba43);
        profilestop();
        return;
    }
    /#
        self function_b39b0b55(trigger.origin, (1, 0, 0), var_e125ba43 + function_9e72a96(#"hash_7d1aa4caccc3dd42"));
    #/
    profilestop();
}

// Namespace bot_position/bot_position
// Params 1, eflags: 0x4
// Checksum 0x7be6626a, Offset: 0x10c0
// Size: 0xaa
function private function_7832483e(info) {
    pixbeginevent(#"");
    points = self function_7b48fb52(info);
    if (points.size <= 0) {
        profilestop();
        return false;
    }
    point = points[randomint(points.size)];
    self set_position(point.origin, #"hash_3d15ff2161690e3c");
    profilestop();
    return true;
}

// Namespace bot_position/bot_position
// Params 1, eflags: 0x4
// Checksum 0x5b06fa2b, Offset: 0x1178
// Size: 0xaa
function private function_d45bace(info) {
    pixbeginevent(#"");
    points = self function_a59f8a5d(info);
    if (points.size <= 0) {
        profilestop();
        return false;
    }
    point = points[randomint(points.size)];
    self set_position(point.origin, #"goal");
    profilestop();
    return true;
}

// Namespace bot_position/bot_position
// Params 2, eflags: 0x4
// Checksum 0x86df535c, Offset: 0x1230
// Size: 0xba
function private set_position(point, var_e125ba43) {
    navmeshpoint = function_13796beb(point);
    if (!isdefined(navmeshpoint)) {
        /#
            self function_b39b0b55(point, (1, 0, 0), var_e125ba43 + function_9e72a96(#"hash_7d1aa4caccc3dd42"));
        #/
        return;
    }
    /#
        self.bot.var_8cfb4a08 = var_e125ba43;
    #/
    self function_a57c34b7(navmeshpoint);
    self.bot.var_aa94cd1b = undefined;
}

// Namespace bot_position/bot_position
// Params 1, eflags: 0x4
// Checksum 0x8a46d818, Offset: 0x12f8
// Size: 0x170
function private function_a59f8a5d(info) {
    points = undefined;
    if (isdefined(info.regionid)) {
        points = tacticalquery(#"hash_5c2d9f19faff9f7", info.regionid, self);
    } else if (isdefined(info.goalvolume)) {
        points = tacticalquery(#"hash_4a8bfda269e51b5a", info.goalvolume, self);
    } else {
        center = ai::t_cylinder(info.goalpos, info.goalradius, info.goalheight);
        points = tacticalquery(#"hash_4a8bfda269e51b5a", center, self);
    }
    /#
        if (points.size > 0) {
            self function_70eeee8d(points, (0, 1, 0));
        } else {
            self function_b39b0b55(info.goalpos, (1, 0, 0), #"hash_519149e897eccbb");
        }
    #/
    return points;
}

// Namespace bot_position/bot_position
// Params 1, eflags: 0x4
// Checksum 0xb8287190, Offset: 0x1470
// Size: 0x170
function private function_7d01d83b(info) {
    points = undefined;
    if (isdefined(info.regionid)) {
        points = tacticalquery(#"hash_db073a01c2b4177", info.regionid, self);
    } else if (isdefined(info.goalvolume)) {
        points = tacticalquery(#"hash_17e23e3f768245da", info.goalvolume, self);
    } else {
        center = ai::t_cylinder(info.goalpos, info.goalradius, info.goalheight);
        points = tacticalquery(#"hash_17e23e3f768245da", center, self);
    }
    /#
        if (points.size > 0) {
            self function_70eeee8d(points, (0, 1, 0));
        } else {
            self function_b39b0b55(info.goalpos, (1, 0, 0), #"hash_10472c83480d9e82");
        }
    #/
    return points;
}

// Namespace bot_position/bot_position
// Params 1, eflags: 0x4
// Checksum 0x6d78710, Offset: 0x15e8
// Size: 0x1b8
function private function_7b48fb52(info) {
    points = undefined;
    enemytarget = self.enemy;
    if (!issentient(enemytarget)) {
        enemytarget = enemytarget getcentroid();
    }
    if (isdefined(info.regionid)) {
        points = tacticalquery(#"hash_74a4ccc745696184", info.regionid, self, enemytarget);
    } else if (isdefined(info.goalvolume)) {
        points = tacticalquery(#"hash_187dca4a1ed267ab", info.goalvolume, self, enemytarget);
    } else {
        center = ai::t_cylinder(info.goalpos, info.goalradius, info.goalheight);
        points = tacticalquery(#"hash_187dca4a1ed267ab", center, self, enemytarget);
    }
    /#
        if (points.size > 0) {
            self function_70eeee8d(points, (0, 1, 0));
        } else {
            self function_b39b0b55(info.goalpos, (1, 0, 0), #"hash_531b7e55313019f3");
        }
    #/
    return points;
}

/#

    // Namespace bot_position/bot_position
    // Params 3, eflags: 0x4
    // Checksum 0xd568fd8f, Offset: 0x17a8
    // Size: 0xe2
    function private function_b39b0b55(origin, color, label) {
        if (!self bot::should_record(#"hash_6356356a050dc83d")) {
            return 0;
        }
        top = origin + (0, 0, 128);
        recordline(origin, top, color, "<dev string:x38>", self);
        if (isdefined(label)) {
            record3dtext(function_9e72a96(label), top, (1, 1, 1), "<dev string:x38>", self, 0.5);
        }
        return 1;
    }

    // Namespace bot_position/bot_position
    // Params 2, eflags: 0x4
    // Checksum 0x5ae40374, Offset: 0x1898
    // Size: 0xd0
    function private function_70eeee8d(points, color) {
        if (!self bot::should_record(#"hash_6356356a050dc83d")) {
            return;
        }
        foreach (point in points) {
            recordstar(point.origin, color, "<dev string:x38>", self);
        }
    }

#/
