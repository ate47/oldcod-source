#using script_305d57cf0618009d;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\death_circle;
#using scripts\core_common\flag_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\system_shared;

#namespace bot_insertion;

// Namespace bot_insertion/bot_insertion
// Params 0, eflags: 0x6
// Checksum 0x42b7f850, Offset: 0xa8
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"bot_insertion", &preinit, undefined, undefined, undefined);
}

// Namespace bot_insertion/bot_insertion
// Params 0, eflags: 0x4
// Checksum 0x5278c3cb, Offset: 0xf0
// Size: 0x34
function private preinit() {
    callback::add_callback(#"freefall", &function_c9a18304);
}

// Namespace bot_insertion/bot_insertion
// Params 0, eflags: 0x4
// Checksum 0xb5b95149, Offset: 0x130
// Size: 0x10e
function private function_b7de760d() {
    foreach (insertion in level.insertions) {
        player_insertion::function_a5fd9aa8(insertion);
        foreach (player in insertion.players) {
            if (player == self) {
                return true;
            }
        }
    }
    return false;
}

// Namespace bot_insertion/bot_insertion
// Params 0, eflags: 0x4
// Checksum 0x31d96a31, Offset: 0x248
// Size: 0xe4
function private function_58a44f22() {
    teammates = getplayers(self.team);
    foreach (player in teammates) {
        if (isplayer(player) && !isbot(player) && player function_b7de760d()) {
            return true;
        }
    }
    return false;
}

// Namespace bot_insertion/bot_insertion
// Params 0, eflags: 0x4
// Checksum 0x716aacd9, Offset: 0x338
// Size: 0xe4
function private function_9ea8f9d6() {
    teammates = getplayers(self.team);
    foreach (player in teammates) {
        if (isplayer(player) && !isbot(player) && player function_b7de760d()) {
            return player;
        }
    }
    return undefined;
}

// Namespace bot_insertion/bot_insertion
// Params 0, eflags: 0x0
// Checksum 0x53560cfa, Offset: 0x428
// Size: 0x18c
function function_a4f516ef() {
    self endon(#"death", #"disconnect");
    /#
        if (getdvarint(#"scr_disable_infiltration", 0)) {
            return;
        }
    #/
    if (!self flag::get(#"hash_287397edba8966f9")) {
        var_f9664338 = [#"hash_287397edba8966f9", #"hash_224cb97b8f682317"];
        self flag::wait_till_any(var_f9664338);
    }
    if (function_58a44f22()) {
        waitresult = self waittill(#"hash_3a41cbe85bdb81e1", #"hash_224cb97b8f682317");
        if (waitresult._notify != #"hash_224cb97b8f682317") {
            self flag::wait_till_timeout(function_8ed212d(), #"hash_224cb97b8f682317");
        }
        return;
    }
    if (isdefined(self.var_33a2e995)) {
        self flag::wait_till_timeout(self.var_33a2e995, #"hash_224cb97b8f682317");
    }
}

// Namespace bot_insertion/bot_insertion
// Params 1, eflags: 0x0
// Checksum 0x5b173a95, Offset: 0x5c0
// Size: 0x40
function function_2ed2a1bb(max) {
    random = randomfloat(1);
    return random * random * random * max;
}

// Namespace bot_insertion/bot_insertion
// Params 1, eflags: 0x0
// Checksum 0x1c84f472, Offset: 0x608
// Size: 0x22
function function_9526ce62(max) {
    return function_2ed2a1bb(max);
}

// Namespace bot_insertion/bot_insertion
// Params 0, eflags: 0x0
// Checksum 0x49535203, Offset: 0x638
// Size: 0x24
function function_8ed212d() {
    return 1 + function_2ed2a1bb(3);
}

// Namespace bot_insertion/bot_insertion
// Params 1, eflags: 0x0
// Checksum 0x4c662c99, Offset: 0x668
// Size: 0x31e
function function_24ca8ecf(insertion) {
    assert(isstruct(insertion));
    if (!isdefined(insertion.start_point) || !isdefined(insertion.end_point)) {
        return;
    }
    bots = [];
    foreach (player in insertion.players) {
        if (isbot(player)) {
            if (!isdefined(bots[player.team])) {
                bots[player.team] = [];
            }
            if (!isdefined(bots[player.team])) {
                bots[player.team] = [];
            } else if (!isarray(bots[player.team])) {
                bots[player.team] = array(bots[player.team]);
            }
            bots[player.team][bots[player.team].size] = player;
        }
    }
    distance = distance2d(insertion.start_point, insertion.end_point);
    var_5d59bc67 = 17.6 * level.var_c7f8ccf6;
    var_ef4bfcd8 = distance / var_5d59bc67;
    foreach (team in bots) {
        var_28cd9792 = function_9526ce62(var_ef4bfcd8);
        foreach (bot in team) {
            bot.var_33a2e995 = var_28cd9792 + function_8ed212d();
        }
    }
}

// Namespace bot_insertion/bot_insertion
// Params 0, eflags: 0x0
// Checksum 0xbfc3f4bc, Offset: 0x990
// Size: 0x32
function function_d7ba3d0b() {
    self thread function_39c5371e();
    return function_9526ce62(5);
}

// Namespace bot_insertion/bot_insertion
// Params 0, eflags: 0x0
// Checksum 0x168790e4, Offset: 0x9d0
// Size: 0x1c
function function_9699dc95() {
    self thread function_39c5371e();
}

// Namespace bot_insertion/bot_insertion
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x9f8
// Size: 0x4
function function_39c5371e() {
    
}

// Namespace bot_insertion/bot_insertion
// Params 0, eflags: 0x4
// Checksum 0x74b75683, Offset: 0xa08
// Size: 0x8a
function private function_8f2f3bcd() {
    center = death_circle::function_b980b4ca();
    radius = death_circle::function_f8dae197() * 0.75;
    goal = center + anglestoforward((0, randomint(360), 0)) * radius;
    return goal;
}

// Namespace bot_insertion/bot_insertion
// Params 2, eflags: 0x0
// Checksum 0x34d7369d, Offset: 0xaa0
// Size: 0xc4
function function_d26744ff(target_point, *lead_player) {
    direction = vectornormalize(lead_player - self.origin);
    goal_angles = vectortoangles(direction);
    if (goal_angles[0] < 45) {
        distance = distance(lead_player, self.origin);
        if (distance > 20000) {
            goal_angles = (0, goal_angles[1], 0);
        }
    }
    return goal_angles;
}

// Namespace bot_insertion/bot_insertion
// Params 2, eflags: 0x0
// Checksum 0x32486c2d, Offset: 0xb70
// Size: 0x66
function function_233a1027(*target_point, lead_player) {
    if (lead_player isonground()) {
        return self function_d26744ff(lead_player.origin, lead_player);
    }
    goal_angles = lead_player.angles;
    return goal_angles;
}

// Namespace bot_insertion/bot_insertion
// Params 3, eflags: 0x0
// Checksum 0x7e8740a7, Offset: 0xbe0
// Size: 0x1d0
function function_13ba9cec(target_point, lead_player, var_282c0a8e) {
    assert(isdefined(var_282c0a8e));
    if (self isonground()) {
        return false;
    }
    goal_angles = [[ var_282c0a8e ]](target_point, lead_player);
    var_8fbb46cd = vectornormalize(self getvelocity());
    var_e0db94ca = vectortoangles(var_8fbb46cd);
    angle_delta = goal_angles - var_e0db94ca;
    var_ce2f4ce0 = function_dac81c9a(angleclamp180(angle_delta[0]));
    angle_yaw = function_dac81c9a(angleclamp180(angle_delta[1]));
    angles = var_e0db94ca + (var_ce2f4ce0, angle_yaw, 0);
    angles = (angleclamp180(angles[0]), angleclamp180(angles[1]), 0);
    self botsetmoveangles(angles);
    self botsetlookangles(angles);
    return true;
}

// Namespace bot_insertion/bot_insertion
// Params 1, eflags: 0x0
// Checksum 0x90e01498, Offset: 0xdb8
// Size: 0x254
function function_c9a18304(params) {
    if (!isarray(level.insertions)) {
        return;
    }
    if (!isbot(self)) {
        return;
    }
    if (params.freefall === 1) {
        self notify("11c4495a170177d9");
        self endon("11c4495a170177d9");
        self endon(#"death", #"disconnect");
        waitframe(1);
        self botsetmovemagnitude(1);
        target_point = function_8f2f3bcd();
        direction = vectornormalize(target_point - self.origin);
        angles = vectortoangles(direction);
        angles = (90, angles[1], 0);
        self botsetmoveangles(angles);
        self botsetlookangles(angles);
        while (true) {
            if (length(self getvelocity()) * 0.0568182 > 110) {
                break;
            }
            wait 1;
        }
        var_26a66f9d = &function_d26744ff;
        var_2706b530 = function_9ea8f9d6();
        if (isdefined(var_2706b530)) {
            var_26a66f9d = &function_233a1027;
        }
        while (true) {
            if (!self function_13ba9cec(target_point, var_2706b530, var_26a66f9d)) {
                return;
            }
            waitframe(1);
        }
        return;
    }
    self botsetmovemagnitude(0);
}

// Namespace bot_insertion/bot_insertion
// Params 1, eflags: 0x4
// Checksum 0x525cd82a, Offset: 0x1018
// Size: 0x92
function private function_dac81c9a(angle_delta) {
    max_delta = getdvarint(#"hash_11e45cd7d81b76c", 30);
    if (angle_delta > 0) {
        return math::clamp(max_delta, angle_delta * -1, angle_delta);
    }
    return math::clamp(max_delta * -1, angle_delta, angle_delta * -1);
}

