#using script_2595527427ea71eb;
#using scripts\core_common\array_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\laststand_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\zm_trial;
#using scripts\zm_common\zm_trial_util;
#using scripts\zm_common\zm_utility;
#using scripts\zm_common\zm_zonemgr;

#namespace zm_trial_defend_area;

// Namespace zm_trial_defend_area/zm_trial_defend_area
// Params 0, eflags: 0x2
// Checksum 0x3c4652f4, Offset: 0xd8
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"zm_trial_defend_area", &__init__, undefined, undefined);
}

// Namespace zm_trial_defend_area/zm_trial_defend_area
// Params 0, eflags: 0x0
// Checksum 0xf6a585c6, Offset: 0x120
// Size: 0x5c
function __init__() {
    if (!zm_trial::is_trial_mode()) {
        return;
    }
    zm_trial::register_challenge(#"defend_area", &on_begin, &on_end);
}

// Namespace zm_trial_defend_area/zm_trial_defend_area
// Params 8, eflags: 0x4
// Checksum 0x8cc57f64, Offset: 0x188
// Size: 0x214
function private on_begin(var_13600a2c, var_5f384eee, var_be4cfafb, zone1, zone2, zone3, zone4, zone5) {
    zones = array::remove_undefined(array(zone1, zone2, zone3, zone4, zone5), 0);
    level.var_401917a4 = [];
    foreach (zone in zones) {
        level.var_401917a4[zone] = 1;
    }
    self.var_d98bfbe9 = zm_utility::function_6e3c4e7b(var_13600a2c, #"hash_28d5f57c2309090", 0);
    self.var_98662fd4 = var_13600a2c;
    self thread function_deabba21();
    foreach (player in getplayers()) {
        player thread zone_watcher(self, var_5f384eee, var_be4cfafb);
        player thread damage_watcher();
    }
    if (isdefined(level.var_2d7d4aab)) {
        self [[ level.var_2d7d4aab ]]();
    }
}

// Namespace zm_trial_defend_area/zm_trial_defend_area
// Params 1, eflags: 0x4
// Checksum 0x4e335581, Offset: 0x3a8
// Size: 0x130
function private on_end(round_reset) {
    zm_utility::function_a6a6b4cc(self.var_d98bfbe9, self.var_98662fd4);
    if (isdefined(level.var_920cc8e7)) {
        self [[ level.var_920cc8e7 ]]();
    }
    foreach (player in getplayers()) {
        if (level.var_bb57ff69 zm_trial_timer::is_open(player)) {
            level.var_bb57ff69 zm_trial_timer::close(player);
            player zm_trial_util::stop_timer();
        }
        player clientfield::set_to_player("zm_zone_out_of_bounds", 0);
    }
}

// Namespace zm_trial_defend_area/zm_trial_defend_area
// Params 0, eflags: 0x4
// Checksum 0x227d975e, Offset: 0x4e0
// Size: 0x3c
function private function_deabba21() {
    level endon(#"hash_7646638df88a3656");
    wait 12;
    zm_utility::function_ebffa94b(self.var_98662fd4, 1);
}

// Namespace zm_trial_defend_area/zm_trial_defend_area
// Params 2, eflags: 0x4
// Checksum 0xdce7760, Offset: 0x528
// Size: 0x8c
function private start_timer(timeout, var_be4cfafb) {
    if (!level.var_bb57ff69 zm_trial_timer::is_open(self)) {
        level.var_bb57ff69 zm_trial_timer::open(self);
        level.var_bb57ff69 zm_trial_timer::set_timer_text(self, var_be4cfafb);
        self zm_trial_util::start_timer(timeout);
    }
}

// Namespace zm_trial_defend_area/zm_trial_defend_area
// Params 0, eflags: 0x4
// Checksum 0xec64f82e, Offset: 0x5c0
// Size: 0x5c
function private stop_timer() {
    if (level.var_bb57ff69 zm_trial_timer::is_open(self)) {
        level.var_bb57ff69 zm_trial_timer::close(self);
        self zm_trial_util::stop_timer();
    }
}

// Namespace zm_trial_defend_area/zm_trial_defend_area
// Params 0, eflags: 0x4
// Checksum 0x8eef1bec, Offset: 0x628
// Size: 0x68
function private function_e9f94a38() {
    zone = self zm_zonemgr::get_player_zone();
    assert(isdefined(level.var_401917a4));
    return isdefined(zone) && isdefined(level.var_401917a4[zone]);
}

// Namespace zm_trial_defend_area/zm_trial_defend_area
// Params 3, eflags: 0x4
// Checksum 0x42f560d, Offset: 0x698
// Size: 0x286
function private zone_watcher(challenge, var_5f384eee, var_be4cfafb) {
    self endon(#"disconnect");
    level endon(#"hash_7646638df88a3656");
    self.var_e17d0db8 = 0;
    self zm_utility::function_447e7c95(challenge.var_d98bfbe9, 0);
    wait 12;
    self zm_utility::function_447e7c95(challenge.var_d98bfbe9, 1);
    self start_timer(45, var_5f384eee);
    var_2bdd0abc = level.time + 45000;
    while (true) {
        zone_valid = self function_e9f94a38();
        if (zone_valid) {
            self.var_e17d0db8 = 1;
            self stop_timer();
            self zm_utility::function_447e7c95(challenge.var_d98bfbe9, 0);
            var_2bdd0abc = level.time + 5000;
        } else if (level.time > var_2bdd0abc) {
            self stop_timer();
        } else if (!level.var_bb57ff69 zm_trial_timer::is_open(self)) {
            self start_timer(5, var_be4cfafb);
            self zm_utility::function_447e7c95(challenge.var_d98bfbe9, 1);
        }
        if (isdefined(self.var_e17d0db8) && self.var_e17d0db8 && !zone_valid && isalive(self) && !self laststand::player_is_in_laststand()) {
            self clientfield::set_to_player("zm_zone_out_of_bounds", 1);
        } else {
            self clientfield::set_to_player("zm_zone_out_of_bounds", 0);
        }
        waitframe(1);
    }
}

// Namespace zm_trial_defend_area/zm_trial_defend_area
// Params 0, eflags: 0x4
// Checksum 0x3712d4b8, Offset: 0x928
// Size: 0x1d0
function private damage_watcher() {
    self endon(#"disconnect");
    level endon(#"hash_7646638df88a3656");
    wait 12;
    while (true) {
        /#
            if (isgodmode(self) || self isinmovemode("<dev string:x30>", "<dev string:x37>")) {
                waitframe(1);
                continue;
            }
        #/
        if (!self function_e9f94a38() && !level.var_bb57ff69 zm_trial_timer::is_open(self) && self.sessionstate != "spectator" && !self laststand::player_is_in_laststand() && !(isdefined(self.var_e99541c5) && self.var_e99541c5)) {
            var_b32f7076 = int(self.maxhealth * 0.0667);
            if (self.health <= var_b32f7076) {
                if (zm_utility::is_magic_bullet_shield_enabled(self)) {
                    self util::stop_magic_bullet_shield();
                }
                self dodamage(self.health + 1000, self.origin);
            } else {
                self.health -= var_b32f7076;
            }
        }
        wait 1;
    }
}

