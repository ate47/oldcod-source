#using scripts\core_common\ai_shared;
#using scripts\core_common\bots\bot;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\util_shared;

#namespace bot_position;

// Namespace bot_position/bot_position
// Params 0, eflags: 0x1 linked
// Checksum 0x2dc45dd4, Offset: 0x80
// Size: 0x54
function function_70a657d8() {
    callback::on_spawned(&on_player_spawned);
    callback::add_callback(#"hash_6efb8cec1ca372dc", &function_7291a729);
}

// Namespace bot_position/bot_position
// Params 0, eflags: 0x5 linked
// Checksum 0x765d7efe, Offset: 0xe0
// Size: 0x34
function private on_player_spawned() {
    if (!isbot(self)) {
        return;
    }
    self thread handle_path_failed();
}

// Namespace bot_position/bot_position
// Params 0, eflags: 0x5 linked
// Checksum 0x645103a8, Offset: 0x120
// Size: 0x3c
function private function_7291a729() {
    self set_position(self.origin);
    self thread handle_path_failed();
}

// Namespace bot_position/bot_position
// Params 0, eflags: 0x5 linked
// Checksum 0x3bbe2a7b, Offset: 0x168
// Size: 0x144
function private handle_path_failed() {
    self endon(#"death", #"hash_6280ac8ed281ce3c");
    level endon(#"game_ended");
    while (isdefined(self.bot)) {
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
            break;
        case 7:
        case 8:
        default:
            break;
        }
        waitframe(1);
    }
}

// Namespace bot_position/bot_position
// Params 0, eflags: 0x5 linked
// Checksum 0xa5dccf26, Offset: 0x2b8
// Size: 0x8c
function private function_5c6265b3() {
    clamped = self function_96f55844();
    /#
        if (clamped) {
            self function_b39b0b55(self.origin, (1, 1, 0), "<dev string:x38>");
            return;
        }
        self function_b39b0b55(self.origin, (1, 0, 0), "<dev string:x5c>");
    #/
}

// Namespace bot_position/bot_position
// Params 0, eflags: 0x4
// Checksum 0x5a679430, Offset: 0x350
// Size: 0xb8
function private function_2bcdf566() {
    self endon(#"death", #"hash_6280ac8ed281ce3c");
    level endon(#"game_ended");
    while (isdefined(self.bot)) {
        params = self waittill(#"grenade danger");
        if (!isdefined(params.projectile) || !util::function_fbce7263(params.projectile.team, self.team)) {
            continue;
        }
        waitframe(1);
    }
}

// Namespace bot_position/bot_position
// Params 0, eflags: 0x1 linked
// Checksum 0x2c6a6b10, Offset: 0x410
// Size: 0x23c
function think() {
    if (self.spawntime >= gettime()) {
        return;
    }
    info = self function_4794d6a3();
    if (info.goalforced) {
        return;
    }
    if (is_true(self.bot.var_8f612e75)) {
        set_position(self.origin);
    } else if (self bot::function_e5d7f472()) {
        trigger = self bot::function_85bfe6d3();
        if (!self function_cd62e960(info.overridegoalpos, trigger)) {
            self function_f14a768c(trigger);
        }
    } else if (self bot::function_dd750ead()) {
        trigger = self bot::function_bba89736();
        if (!self function_cd62e960(info.overridegoalpos, trigger)) {
            self function_f14a768c(trigger);
        }
    }
    if (function_9093c235(info.overridegoalpos, info)) {
        return;
    }
    points = self function_c56261dc(info);
    if (points.size <= 0) {
        /#
            self function_b39b0b55(info.goalpos, (1, 0, 0), "<dev string:x85>");
        #/
        return;
    }
    /#
        self function_70eeee8d(points, (0, 1, 1));
    #/
    point = points[randomint(points.size)];
    self set_position(point);
}

// Namespace bot_position/bot_position
// Params 0, eflags: 0x1 linked
// Checksum 0xa114ecce, Offset: 0x658
// Size: 0x16
function hold() {
    self.bot.var_8f612e75 = 1;
}

// Namespace bot_position/bot_position
// Params 0, eflags: 0x1 linked
// Checksum 0x76e05541, Offset: 0x678
// Size: 0x12
function clear() {
    self.bot.var_8f612e75 = undefined;
}

// Namespace bot_position/bot_position
// Params 2, eflags: 0x5 linked
// Checksum 0xb83f4f74, Offset: 0x698
// Size: 0x140
function private function_9093c235(pos, info) {
    if (!isdefined(pos)) {
        return false;
    }
    if (isdefined(info.regionid)) {
        tpoint = getclosesttacpoint(pos);
        return (isdefined(tpoint) && info.regionid == tpoint.region);
    }
    if (isdefined(info.goalvolume)) {
        istouching(pos, info.goalvolume);
    }
    goalpos = info.goalpos;
    distsq = distance2dsquared(pos, goalpos);
    if (distsq > info.goalradius * info.goalradius) {
        return false;
    }
    if (pos[2] > goalpos[2] + info.goalheight || pos[2] < goalpos[2] - info.goalheight) {
        return false;
    }
    return true;
}

// Namespace bot_position/bot_position
// Params 2, eflags: 0x5 linked
// Checksum 0x21c8f02d, Offset: 0x7e0
// Size: 0x3a
function private function_cd62e960(pos, trigger) {
    if (!isdefined(pos)) {
        return 0;
    }
    return istouching(pos, trigger);
}

// Namespace bot_position/bot_position
// Params 1, eflags: 0x5 linked
// Checksum 0xea11c3a6, Offset: 0x828
// Size: 0x152
function private function_c56261dc(info) {
    if (isdefined(info.regionid)) {
        regioninfo = function_b507a336(info.regionid);
        points = [];
        if (isdefined(regioninfo)) {
            foreach (i, tpoint in regioninfo.tacpoints) {
                points[i] = tpoint.origin;
            }
        }
        return points;
    } else if (isdefined(info.goalvolume)) {
        return self function_f60678a8(info.goalvolume);
    }
    center = ai::t_cylinder(info.goalpos, info.goalradius, info.goalheight);
    return self function_f60678a8(center);
}

// Namespace bot_position/bot_position
// Params 1, eflags: 0x5 linked
// Checksum 0x60fdc28e, Offset: 0x988
// Size: 0xd0
function private function_f60678a8(center) {
    tacpoints = tacticalquery(#"hash_5c2d9f19faff9f7", center, self);
    points = [];
    foreach (i, tpoint in tacpoints) {
        points[i] = tpoint.origin;
    }
    return points;
}

// Namespace bot_position/bot_position
// Params 0, eflags: 0x5 linked
// Checksum 0xcdef263d, Offset: 0xa60
// Size: 0xc0
function private function_96f55844() {
    navmeshpoint = function_1700c874(self.origin);
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
// Params 1, eflags: 0x1 linked
// Checksum 0x84c093ed, Offset: 0xb28
// Size: 0x2a
function function_1700c874(origin) {
    return getclosestpointonnavmesh(origin, 64, 16);
}

// Namespace bot_position/bot_position
// Params 1, eflags: 0x5 linked
// Checksum 0x8ca1423d, Offset: 0xb60
// Size: 0xc4
function private function_f14a768c(trigger) {
    point = self function_1700c874(trigger.origin);
    if (isdefined(point)) {
        set_position(point);
        return;
    }
    set_position(self.origin);
    /#
        self function_7ddf9883(trigger.origin, trigger.mins, trigger.maxs, trigger.angles[2], (1, 0, 0), "<dev string:x9a>");
    #/
}

// Namespace bot_position/bot_position
// Params 2, eflags: 0x5 linked
// Checksum 0xaf3165cb, Offset: 0xc30
// Size: 0x13c
function private set_position(position, claimnode = undefined) {
    radius = self getpathfindingradius();
    if (ispathnode(position)) {
        if (ispointonnavmesh(position.origin, radius)) {
            self function_a57c34b7(position);
            return;
        } else {
            position = position.origin;
        }
    }
    if (isvec(position)) {
        self usecovernode(claimnode);
        navmeshpoint = function_1700c874(position);
        if (isdefined(navmeshpoint)) {
            self function_a57c34b7(navmeshpoint);
            return;
        }
        /#
            self function_b39b0b55(position, (1, 0, 0), "<dev string:xb1>");
        #/
    }
}

/#

    // Namespace bot_position/bot_position
    // Params 3, eflags: 0x4
    // Checksum 0x3c6f817d, Offset: 0xd78
    // Size: 0xb4
    function private function_b39b0b55(origin, color, label) {
        if (!self bot::should_record("<dev string:xc8>")) {
            return;
        }
        top = origin + (0, 0, 128);
        recordline(origin, top, color, "<dev string:xde>", self);
        if (isdefined(label)) {
            record3dtext(label, top, (1, 1, 1), "<dev string:xde>", self, 0.5);
        }
    }

    // Namespace bot_position/bot_position
    // Params 6, eflags: 0x4
    // Checksum 0xcd782bee, Offset: 0xe38
    // Size: 0xac
    function private function_7ddf9883(origin, mins, maxs, yaw, color, label) {
        if (!self bot::should_record("<dev string:xc8>")) {
            return;
        }
        record3dtext(label, origin, (1, 1, 1), "<dev string:xde>", self, 0.5);
        function_af72dbc5(origin, mins, maxs, yaw, color, "<dev string:xde>", self);
    }

    // Namespace bot_position/bot_position
    // Params 2, eflags: 0x4
    // Checksum 0xe016b080, Offset: 0xef0
    // Size: 0xe0
    function private function_70eeee8d(points, color) {
        if (!self bot::should_record("<dev string:xc8>")) {
            return;
        }
        if (self bot::should_record("<dev string:xc8>")) {
            foreach (point in points) {
                recordstar(point, color, "<dev string:xde>", self);
            }
        }
    }

#/
