#using script_2595527427ea71eb;
#using scripts\core_common\array_shared;
#using scripts\core_common\bots\bot_util;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\laststand_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\zm_laststand;
#using scripts\zm_common\zm_trial;
#using scripts\zm_common\zm_trial_util;
#using scripts\zm_common\zm_utility;
#using scripts\zm_common\zm_zonemgr;

#namespace zm_trial_defend_area;

// Namespace zm_trial_defend_area/zm_trial_defend_area
// Params 0, eflags: 0x6
// Checksum 0x9129028c, Offset: 0x128
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"zm_trial_defend_area", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace zm_trial_defend_area/zm_trial_defend_area
// Params 0, eflags: 0x4
// Checksum 0x66d2f412, Offset: 0x170
// Size: 0x5c
function private function_70a657d8() {
    if (!zm_trial::is_trial_mode()) {
        return;
    }
    zm_trial::register_challenge(#"defend_area", &on_begin, &on_end);
}

// Namespace zm_trial_defend_area/zm_trial_defend_area
// Params 8, eflags: 0x4
// Checksum 0xb6ea48c, Offset: 0x1d8
// Size: 0x36c
function private on_begin(var_7720abf7, var_2d5ebf67, var_530e040f, zone1, zone2, zone3, zone4, zone5) {
    callback::add_callback(#"on_host_migration_end", &function_ff66b979);
    zones = [zone1, zone2, zone3, zone4, zone5];
    arrayremovevalue(zones, undefined, 0);
    level.var_c8b84806 = [];
    foreach (zone in zones) {
        level.var_c8b84806[zone] = 1;
    }
    self.var_df62490a = zm_utility::function_d7db256e(var_7720abf7, #"hash_28d5f57c2309090", 0);
    self.var_f7f308cd = var_7720abf7;
    self thread function_492f4c79();
    var_144cd915 = 0;
    foreach (str_zone in zones) {
        if (zm_zonemgr::zone_is_enabled(str_zone)) {
            var_144cd915 = 1;
            break;
        }
    }
    if (var_144cd915) {
        self thread function_5a68cb9f();
    }
    foreach (player in getplayers()) {
        player thread zone_watcher(self, var_2d5ebf67, var_530e040f);
        player thread damage_watcher(1);
        if (isbot(player)) {
            player thread function_dae80de6();
        }
    }
    if (isdefined(level.var_adca35c8)) {
        self [[ level.var_adca35c8 ]]();
    }
}

// Namespace zm_trial_defend_area/zm_trial_defend_area
// Params 0, eflags: 0x0
// Checksum 0x427c6dfa, Offset: 0x550
// Size: 0xa6
function function_5a68cb9f() {
    level flag::clear("spawn_zombies");
    level.disable_nuke_delay_spawning = 1;
    level notify(#"disable_nuke_delay_spawning");
    level waittill(#"hash_7646638df88a3656", #"hash_715188521b564b16", #"end_game");
    level flag::set("spawn_zombies");
    level.disable_nuke_delay_spawning = undefined;
}

// Namespace zm_trial_defend_area/zm_trial_defend_area
// Params 1, eflags: 0x4
// Checksum 0x75463655, Offset: 0x600
// Size: 0x1a8
function private on_end(*round_reset) {
    zm_utility::function_b1f3be5c(self.var_df62490a, self.var_f7f308cd);
    callback::remove_callback(#"on_host_migration_end", &function_ff66b979);
    if (isdefined(level.var_a975ca2c)) {
        self [[ level.var_a975ca2c ]]();
    }
    foreach (player in getplayers()) {
        if (level.var_f995ece6 zm_trial_timer::is_open(player)) {
            level.var_f995ece6 zm_trial_timer::close(player);
            player zm_trial_util::stop_timer();
        }
        player clientfield::set_to_player("zm_zone_out_of_bounds", 0);
        player.var_e5cde66 = undefined;
        if (isbot(player)) {
            player bot_util::function_33834a13();
        }
    }
}

// Namespace zm_trial_defend_area/zm_trial_defend_area
// Params 0, eflags: 0x4
// Checksum 0x25fbb4f1, Offset: 0x7b0
// Size: 0x3c
function private function_492f4c79() {
    level endon(#"hash_7646638df88a3656");
    wait 12;
    zm_utility::function_75fd65f9(self.var_f7f308cd, 1);
}

// Namespace zm_trial_defend_area/zm_trial_defend_area
// Params 2, eflags: 0x4
// Checksum 0x61d3917d, Offset: 0x7f8
// Size: 0xac
function private start_timer(timeout, var_530e040f) {
    if (!level.var_f995ece6 zm_trial_timer::is_open(self)) {
        level.var_f995ece6 zm_trial_timer::open(self);
        level.var_f995ece6 zm_trial_timer::set_timer_text(self, var_530e040f);
        level.var_f995ece6 zm_trial_timer::set_under_round_rules(self, 1);
        self zm_trial_util::start_timer(timeout);
    }
}

// Namespace zm_trial_defend_area/zm_trial_defend_area
// Params 0, eflags: 0x4
// Checksum 0xba14929b, Offset: 0x8b0
// Size: 0x5c
function private stop_timer() {
    if (level.var_f995ece6 zm_trial_timer::is_open(self)) {
        level.var_f995ece6 zm_trial_timer::close(self);
        self zm_trial_util::stop_timer();
    }
}

// Namespace zm_trial_defend_area/zm_trial_defend_area
// Params 0, eflags: 0x4
// Checksum 0xf42a2e66, Offset: 0x918
// Size: 0x68
function private function_2191cc5d() {
    zone = self zm_zonemgr::get_player_zone();
    assert(isdefined(level.var_c8b84806));
    return isdefined(zone) && isdefined(level.var_c8b84806[zone]);
}

// Namespace zm_trial_defend_area/zm_trial_defend_area
// Params 4, eflags: 0x4
// Checksum 0x606d54c8, Offset: 0x988
// Size: 0x306
function private function_1802ad1e(challenge, var_2d5ebf67, var_530e040f, timeout) {
    self endon(#"disconnect");
    level endon(#"hash_7646638df88a3656", #"host_migration_begin");
    self.var_e5cde66 = {#start_time:level.time, #timeout:timeout, #challenge:challenge, #var_2d5ebf67:var_2d5ebf67, #var_530e040f:var_530e040f};
    self start_timer(timeout, var_2d5ebf67);
    var_2bf2b5dd = level.time + timeout * 1000;
    while (true) {
        zone_valid = self function_2191cc5d();
        if (zone_valid) {
            level notify(#"hash_715188521b564b16", {#player:self});
            self.var_4cb0b91f = 1;
            self.var_ccee13fc = 1;
            self stop_timer();
            self zm_utility::function_ba39d198(challenge.var_df62490a, 0);
            var_2bf2b5dd = level.time + 0;
        } else if (level.time > var_2bf2b5dd) {
            self stop_timer();
        } else if (!level.var_f995ece6 zm_trial_timer::is_open(self)) {
            self start_timer(0, var_530e040f);
            self zm_utility::function_ba39d198(challenge.var_df62490a, 1);
        }
        if (is_true(self.var_4cb0b91f) && !zone_valid && isalive(self) && !self laststand::player_is_in_laststand() && !is_true(level.intermission)) {
            self clientfield::set_to_player("zm_zone_out_of_bounds", 1);
            self.var_ccee13fc = undefined;
        } else {
            self clientfield::set_to_player("zm_zone_out_of_bounds", 0);
        }
        waitframe(1);
    }
}

// Namespace zm_trial_defend_area/zm_trial_defend_area
// Params 3, eflags: 0x4
// Checksum 0x4208631d, Offset: 0xc98
// Size: 0xfc
function private zone_watcher(challenge, var_2d5ebf67, var_530e040f) {
    self endon(#"disconnect");
    level endon(#"hash_7646638df88a3656");
    self.var_4cb0b91f = 0;
    self zm_utility::function_ba39d198(challenge.var_df62490a, 0);
    wait 12;
    self zm_utility::function_ba39d198(challenge.var_df62490a, 1);
    if (getgametypesetting("zmTrialsVariant") && level.round_number > 20) {
        var_d4862226 = 90;
    } else {
        var_d4862226 = 45;
    }
    self thread function_1802ad1e(challenge, var_2d5ebf67, var_530e040f, var_d4862226);
}

// Namespace zm_trial_defend_area/zm_trial_defend_area
// Params 1, eflags: 0x4
// Checksum 0xe52d42cd, Offset: 0xda0
// Size: 0x23e
function private damage_watcher(var_a4a28ac7) {
    self endon(#"disconnect");
    level endon(#"hash_7646638df88a3656", #"host_migration_begin");
    if (is_true(var_a4a28ac7)) {
        wait 12;
    }
    while (true) {
        /#
            if (isgodmode(self) || self isinmovemode("<dev string:x38>", "<dev string:x42>")) {
                waitframe(1);
                continue;
            }
        #/
        if (!self function_2191cc5d() && !level.var_f995ece6 zm_trial_timer::is_open(self) && self.sessionstate != "spectator" && !self laststand::player_is_in_laststand() && !is_true(self.var_eb319d10) && !is_true(level.intermission) && !is_true(self.var_16735873)) {
            var_16e6b8ea = self zm_utility::function_7618c8ef(0.0667);
            if (self.health <= var_16e6b8ea) {
                if (zm_utility::is_magic_bullet_shield_enabled(self)) {
                    self util::stop_magic_bullet_shield();
                }
                self dodamage(self.health + 1000, self.origin);
            } else {
                self dodamage(var_16e6b8ea, self.origin);
            }
        }
        wait 1;
    }
}

// Namespace zm_trial_defend_area/zm_trial_defend_area
// Params 0, eflags: 0x4
// Checksum 0x12dea531, Offset: 0xfe8
// Size: 0x240
function private function_ff66b979() {
    level endon(#"end_of_round");
    foreach (player in getplayers()) {
        if (!isdefined(player.var_e5cde66)) {
            continue;
        }
        player stop_timer();
    }
    var_a0328dd5 = gettime();
    wait 5;
    foreach (player in getplayers()) {
        if (!isdefined(player.var_e5cde66)) {
            player thread damage_watcher(0);
            continue;
        }
        timer_delta = var_a0328dd5 - player.var_e5cde66.start_time;
        timeout = int(max(player.var_e5cde66.timeout - float(timer_delta) / 1000, 0));
        player thread function_1802ad1e(player.var_e5cde66.challenge, player.var_e5cde66.var_2d5ebf67, player.var_e5cde66.var_530e040f, timeout);
        player thread damage_watcher(0);
    }
}

// Namespace zm_trial_defend_area/zm_trial_defend_area
// Params 0, eflags: 0x4
// Checksum 0xb920a2a, Offset: 0x1230
// Size: 0x370
function private function_dae80de6() {
    self endon(#"disconnect");
    level endon(#"hash_7646638df88a3656");
    wait 5;
    s_challenge = zm_trial::function_a36e8c38(#"defend_area");
    s_defend_area = struct::get(s_challenge.var_f7f308cd);
    s_result = positionquery_source_navigation(s_defend_area.origin, 64, 1500, 100, 32);
    a_str_zones = getarraykeys(level.var_c8b84806);
    zm_zonemgr::function_8caa21df(a_str_zones);
    var_3dbf02b9 = [];
    s_result.data = array::randomize(s_result.data);
    foreach (var_c310df8c in s_result.data) {
        foreach (str_zone in a_str_zones) {
            if (zm_zonemgr::function_adc70eee(var_c310df8c.origin, str_zone)) {
                if (!isdefined(var_3dbf02b9)) {
                    var_3dbf02b9 = [];
                } else if (!isarray(var_3dbf02b9)) {
                    var_3dbf02b9 = array(var_3dbf02b9);
                }
                var_3dbf02b9[var_3dbf02b9.size] = var_c310df8c.origin;
            }
        }
        if (var_3dbf02b9.size >= 10) {
            break;
        }
    }
    while (var_3dbf02b9.size) {
        if (!function_e1378d07()) {
            self bot_util::function_33834a13();
            wait 1;
            continue;
        }
        v_position = array::random(var_3dbf02b9);
        self bot_util::function_23cbc6c1(v_position, 1);
        self waittilltimeout(10, #"goal");
        if (!function_e1378d07()) {
            self bot_util::function_33834a13();
        }
        wait randomintrange(5, 10);
    }
}

// Namespace zm_trial_defend_area/zm_trial_defend_area
// Params 0, eflags: 0x4
// Checksum 0xe1c8597f, Offset: 0x15a8
// Size: 0xce
function private function_e1378d07() {
    foreach (player in getplayers()) {
        if (isalive(player) && !isbot(player) && !player laststand::player_is_in_laststand()) {
            return true;
        }
    }
    return false;
}

// Namespace zm_trial_defend_area/zm_trial_defend_area
// Params 0, eflags: 0x0
// Checksum 0xe788b1d4, Offset: 0x1680
// Size: 0x32
function is_active() {
    s_challenge = zm_trial::function_a36e8c38(#"defend_area");
    return isdefined(s_challenge);
}

