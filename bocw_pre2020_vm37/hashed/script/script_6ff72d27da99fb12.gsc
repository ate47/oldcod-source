#using script_2595527427ea71eb;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\system_shared;
#using scripts\zm_common\zm_laststand;
#using scripts\zm_common\zm_loadout;
#using scripts\zm_common\zm_score;
#using scripts\zm_common\zm_trial;
#using scripts\zm_common\zm_trial_util;

#namespace namespace_8cefe82f;

// Namespace namespace_8cefe82f/namespace_8cefe82f
// Params 0, eflags: 0x6
// Checksum 0xf30599f5, Offset: 0xb0
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"hash_71a1297844fdf28e", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace namespace_8cefe82f/namespace_8cefe82f
// Params 0, eflags: 0x4
// Checksum 0x5415127d, Offset: 0xf8
// Size: 0x5c
function private function_70a657d8() {
    if (!zm_trial::is_trial_mode()) {
        return;
    }
    zm_trial::register_challenge(#"hash_163077e21e01f4a7", &on_begin, &on_end);
}

// Namespace namespace_8cefe82f/namespace_8cefe82f
// Params 1, eflags: 0x4
// Checksum 0x895ab41e, Offset: 0x160
// Size: 0x110
function private on_begin(n_timer) {
    n_timer = zm_trial::function_5769f26a(n_timer);
    level.var_f7236c66 = n_timer;
    callback::on_spawned(&on_player_spawned);
    callback::add_callback(#"on_host_migration_end", &function_ff66b979);
    foreach (player in getplayers()) {
        player thread function_7650d9fb(n_timer);
    }
}

// Namespace namespace_8cefe82f/namespace_8cefe82f
// Params 1, eflags: 0x4
// Checksum 0x9d733878, Offset: 0x278
// Size: 0xf0
function private on_end(*round_reset) {
    level.var_f7236c66 = undefined;
    callback::remove_on_spawned(&on_player_spawned);
    callback::remove_callback(#"on_host_migration_end", &function_ff66b979);
    foreach (player in getplayers()) {
        player stop_timer();
    }
}

// Namespace namespace_8cefe82f/namespace_8cefe82f
// Params 2, eflags: 0x4
// Checksum 0x71b92db9, Offset: 0x370
// Size: 0x198
function private function_7650d9fb(n_timer, var_f97d1a30) {
    self endon(#"disconnect");
    level endon(#"hash_7646638df88a3656", #"hash_6223843ef1e3c6de", #"host_migration_begin");
    if (!is_true(var_f97d1a30)) {
        wait 12;
    }
    while (true) {
        while (!isalive(self)) {
            self waittill(#"spawned");
            wait 2;
        }
        self start_timer(n_timer, var_f97d1a30);
        s_waitresult = self waittilltimeout(n_timer + 1, #"fasttravel_bought");
        self stop_timer();
        if (s_waitresult._notify == "timeout") {
            zm_trial::fail(#"hash_4e619a0715198f72", array(self));
            level notify(#"hash_6223843ef1e3c6de");
            return;
        }
        s_waitresult = self waittill(#"fasttravel_finished");
    }
}

// Namespace namespace_8cefe82f/namespace_8cefe82f
// Params 0, eflags: 0x4
// Checksum 0xf0f99b8, Offset: 0x510
// Size: 0x5c
function private on_player_spawned() {
    self endon(#"disconnect");
    level endon(#"host_migration_begin");
    wait 2;
    if (isdefined(self.n_time_remaining)) {
        self start_timer(self.n_time_remaining);
    }
}

// Namespace namespace_8cefe82f/namespace_8cefe82f
// Params 2, eflags: 0x4
// Checksum 0x38f089d6, Offset: 0x578
// Size: 0xcc
function private start_timer(timeout, var_f97d1a30) {
    if (!level.var_f995ece6 zm_trial_timer::is_open(self)) {
        level.var_f995ece6 zm_trial_timer::open(self);
        level.var_f995ece6 zm_trial_timer::set_timer_text(self, #"hash_459951bdd5145bf0");
        level.var_f995ece6 zm_trial_timer::set_under_round_rules(self, 1);
        self zm_trial_util::start_timer(timeout);
        self thread function_a0f0109f(timeout, var_f97d1a30);
    }
}

// Namespace namespace_8cefe82f/namespace_8cefe82f
// Params 2, eflags: 0x0
// Checksum 0x861a8fdf, Offset: 0x650
// Size: 0xd0
function function_a0f0109f(timeout, var_f97d1a30) {
    if (isdefined(self.n_time_remaining) && !is_true(var_f97d1a30)) {
        return;
    }
    self endon(#"disconnect", #"hash_2a79adac1fd03c09");
    level endon(#"hash_7646638df88a3656", #"end_game", #"host_migration_begin");
    if (!isdefined(self.n_time_remaining)) {
        self.n_time_remaining = timeout;
    }
    while (self.n_time_remaining > 0) {
        wait 1;
        self.n_time_remaining--;
    }
}

// Namespace namespace_8cefe82f/namespace_8cefe82f
// Params 0, eflags: 0x4
// Checksum 0xddfe3c06, Offset: 0x728
// Size: 0x76
function private stop_timer() {
    if (level.var_f995ece6 zm_trial_timer::is_open(self)) {
        level.var_f995ece6 zm_trial_timer::close(self);
        self zm_trial_util::stop_timer();
    }
    self notify(#"hash_2a79adac1fd03c09");
    self.n_time_remaining = undefined;
}

// Namespace namespace_8cefe82f/namespace_8cefe82f
// Params 0, eflags: 0x4
// Checksum 0x7beb6060, Offset: 0x7a8
// Size: 0x1b0
function private function_ff66b979() {
    level endon(#"end_round", #"host_migration_begin");
    foreach (player in getplayers()) {
        if (level.var_f995ece6 zm_trial_timer::is_open(player)) {
            level.var_f995ece6 zm_trial_timer::close(player);
            player zm_trial_util::stop_timer();
        }
    }
    wait 5;
    foreach (player in getplayers()) {
        player thread function_7650d9fb(isdefined(player.n_time_remaining) ? player.n_time_remaining : level.var_f7236c66, 1);
    }
}

