#using scripts\core_common\callbacks_shared;
#using scripts\core_common\util_shared;
#using scripts\killstreaks\ai\state;

#namespace ai_leave;

// Namespace ai_leave/leave
// Params 0, eflags: 0x0
// Checksum 0x30a01b1d, Offset: 0x88
// Size: 0x64
function init() {
    ai_state::function_e9b061a8(2, &make_leave, &update_leave, undefined, &update_enemy, &function_4af1ff64, &function_a78474f2);
}

// Namespace ai_leave/leave
// Params 1, eflags: 0x0
// Checksum 0x1b6c343b, Offset: 0xf8
// Size: 0x62
function init_leave(var_edc20efd) {
    assert(isdefined(self.ai));
    self.ai.leave = {#state:0, #var_edc20efd:var_edc20efd};
}

// Namespace ai_leave/leave
// Params 0, eflags: 0x0
// Checksum 0xedf7ee7c, Offset: 0x168
// Size: 0x1a
function function_4af1ff64() {
    return self.ai.leave.var_edc20efd;
}

// Namespace ai_leave/leave
// Params 0, eflags: 0x0
// Checksum 0x6fc39dab, Offset: 0x190
// Size: 0xa
function function_a78474f2() {
    return self.origin;
}

// Namespace ai_leave/leave
// Params 0, eflags: 0x0
// Checksum 0xd44bdec1, Offset: 0x1a8
// Size: 0x7c
function update_enemy() {
    if (is_true(self.ai.hasseenfavoriteenemy)) {
        self.ai.leave.state = 2;
        return;
    }
    if (self.ai.leave.state != 1) {
        self thread make_leave();
    }
}

// Namespace ai_leave/leave
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x230
// Size: 0x4
function update_leave() {
    
}

// Namespace ai_leave/leave
// Params 0, eflags: 0x0
// Checksum 0xe59163d8, Offset: 0x240
// Size: 0x138
function function_e35eee4d() {
    self endon(#"death");
    level endon(#"game_ended");
    while (true) {
        players = getplayers();
        canbeseen = 0;
        foreach (player in players) {
            if (sighttracepassed(self geteye(), player geteye(), 0, undefined)) {
                canbeseen = 1;
                break;
            }
        }
        if (!canbeseen) {
            self delete();
        }
        wait 0.5;
    }
}

// Namespace ai_leave/leave
// Params 0, eflags: 0x0
// Checksum 0x7f12ed7f, Offset: 0x380
// Size: 0x164
function make_leave() {
    self endon(#"death");
    self notify(#"make_leave");
    self endon(#"make_leave");
    self callback::callback(#"hash_c3f225c9fa3cb25");
    self.ai.leave.state = 1;
    if (!isdefined(self.exit_spawn)) {
        util::wait_network_frame(2);
        self delete();
    }
    self thread function_e35eee4d();
    self function_d4c687c9();
    self pathmode("move allowed");
    self setgoal(self.exit_spawn.origin, 0, 32);
    self waittilltimeout(10, #"goal");
    waittillframeend();
    self delete();
}

// Namespace ai_leave/leave
// Params 2, eflags: 0x0
// Checksum 0xcd55089c, Offset: 0x4f0
// Size: 0xfe
function function_233ddd28(origin, team) {
    spawns = level.spawn_start[team];
    closest = undefined;
    closest_dist = 10000000;
    foreach (spawn in spawns) {
        dist = distancesquared(spawn.origin, origin);
        if (dist < closest_dist) {
            closest_dist = dist;
            closest = spawn;
        }
    }
    return closest;
}

