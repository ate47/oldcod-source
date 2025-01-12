#using scripts\core_common\callbacks_shared;
#using scripts\killstreaks\ai\state;

#namespace ai_leave;

// Namespace ai_leave/leave
// Params 0, eflags: 0x0
// Checksum 0x26505488, Offset: 0x88
// Size: 0x64
function init() {
    ai_state::function_7014801d(2, &make_leave, &update_leave, undefined, &update_enemy, &function_c1aee63, &function_7c8eb77);
}

// Namespace ai_leave/leave
// Params 1, eflags: 0x0
// Checksum 0x28d4e3c1, Offset: 0xf8
// Size: 0x62
function init_leave(var_38aa2f7a) {
    assert(isdefined(self.ai));
    self.ai.leave = {#state:0, #var_38aa2f7a:var_38aa2f7a};
}

// Namespace ai_leave/leave
// Params 0, eflags: 0x0
// Checksum 0x14764865, Offset: 0x168
// Size: 0x1a
function function_c1aee63() {
    return self.ai.leave.var_38aa2f7a;
}

// Namespace ai_leave/leave
// Params 0, eflags: 0x0
// Checksum 0xc7964971, Offset: 0x190
// Size: 0xa
function function_7c8eb77() {
    return self.origin;
}

// Namespace ai_leave/leave
// Params 0, eflags: 0x0
// Checksum 0x15244358, Offset: 0x1a8
// Size: 0x7c
function update_enemy() {
    if (isdefined(self.ai.hasseenfavoriteenemy) && self.ai.hasseenfavoriteenemy) {
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
// Checksum 0xca26c483, Offset: 0x240
// Size: 0x130
function function_d0a7ccf3() {
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
// Checksum 0x14752290, Offset: 0x378
// Size: 0x164
function make_leave() {
    self endon(#"death");
    self notify(#"make_leave");
    self endon(#"make_leave");
    self callback::callback(#"hash_c3f225c9fa3cb25");
    self.ai.leave.state = 1;
    if (!isdefined(self.exit_spawn)) {
        self.exit_spawn = function_d87651b5(self.origin, self.team);
    }
    if (isdefined(self.exit_spawn)) {
        self thread function_d0a7ccf3();
        self function_9f59031e();
        self pathmode("move allowed");
        self setgoal(self.exit_spawn.origin, 0, 32);
        self waittilltimeout(10, #"goal");
    }
    waittillframeend();
    self delete();
}

// Namespace ai_leave/leave
// Params 2, eflags: 0x0
// Checksum 0x49ac2d59, Offset: 0x4e8
// Size: 0xfa
function function_d87651b5(origin, team) {
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

