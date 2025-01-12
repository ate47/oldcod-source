#using scripts\core_common\ai\zombie_utility;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\zm_common\zm_utility;
#using scripts\zm_common\zm_zonemgr;

#namespace zm_cleanup;

// Namespace zm_cleanup/zm_cleanup_mgr
// Params 0, eflags: 0x2
// Checksum 0xa577d074, Offset: 0xc0
// Size: 0x44
function autoexec __init__system__() {
    system::register(#"zm_cleanup", &__init__, &__main__, undefined);
}

// Namespace zm_cleanup/zm_cleanup_mgr
// Params 0, eflags: 0x0
// Checksum 0xe3479b73, Offset: 0x110
// Size: 0x36
function __init__() {
    level.n_cleanups_processed_this_frame = 0;
    level.var_1ffbf287 = 0;
    level.cleanup_zombie_func = &delete_zombie_noone_looking;
}

// Namespace zm_cleanup/zm_cleanup_mgr
// Params 0, eflags: 0x0
// Checksum 0x53f20895, Offset: 0x150
// Size: 0x1c
function __main__() {
    level thread cleanup_main();
}

// Namespace zm_cleanup/zm_cleanup_mgr
// Params 0, eflags: 0x0
// Checksum 0x4832f1b9, Offset: 0x178
// Size: 0x18
function force_check_now() {
    level notify(#"pump_distance_check");
}

// Namespace zm_cleanup/zm_cleanup_mgr
// Params 2, eflags: 0x0
// Checksum 0xcc250d3c, Offset: 0x198
// Size: 0xd8
function function_fa058f7e(archetype, func) {
    if (!isdefined(level.var_b1c632de)) {
        level.var_b1c632de = [];
    }
    if (!isdefined(level.var_b1c632de[archetype])) {
        level.var_b1c632de[archetype] = [];
    } else if (!isarray(level.var_b1c632de[archetype])) {
        level.var_b1c632de[archetype] = array(level.var_b1c632de[archetype]);
    }
    level.var_b1c632de[archetype][level.var_b1c632de[archetype].size] = func;
}

// Namespace zm_cleanup/zm_cleanup_mgr
// Params 0, eflags: 0x4
// Checksum 0x38a56ba0, Offset: 0x278
// Size: 0x244
function private cleanup_main() {
    n_next_eval = 0;
    while (true) {
        util::wait_network_frame();
        n_time = gettime();
        if (n_time < n_next_eval) {
            continue;
        }
        if (isdefined(level.n_cleanup_manager_restart_time)) {
            n_current_time = gettime() / 1000;
            n_delta_time = n_current_time - level.n_cleanup_manager_restart_time;
            if (n_delta_time < 0) {
                continue;
            }
            level.n_cleanup_manager_restart_time = undefined;
        }
        n_round_time = (n_time - level.round_start_time) / 1000;
        if (level.round_number <= 5 && n_round_time < 30) {
            continue;
        } else if (level.round_number > 5 && n_round_time < 20) {
            continue;
        }
        n_override_cleanup_dist_sq = undefined;
        if (level.zombie_total == 0 && zombie_utility::get_current_zombie_count() < 3) {
            n_override_cleanup_dist_sq = 2250000;
        }
        n_next_eval += 3000;
        a_ai_enemies = getaiteamarray(#"axis");
        foreach (ai_enemy in a_ai_enemies) {
            if (level.n_cleanups_processed_this_frame >= 1) {
                level.n_cleanups_processed_this_frame = 0;
                util::wait_network_frame();
            }
            ai_enemy do_cleanup_check(n_override_cleanup_dist_sq);
        }
    }
}

// Namespace zm_cleanup/zm_cleanup_mgr
// Params 1, eflags: 0x0
// Checksum 0x44ef9c76, Offset: 0x4c8
// Size: 0x334
function do_cleanup_check(n_override_cleanup_dist) {
    if (!isalive(self)) {
        return;
    }
    if (self.b_ignore_cleanup === 1) {
        return;
    }
    n_time_alive = gettime() - self.spawn_time;
    if (n_time_alive < 5000) {
        return;
    }
    if (isdefined(self.var_4507e122) && self.var_4507e122) {
        return;
    }
    if (self.archetype === "zombie") {
        if (n_time_alive < 45000 && self.script_string !== "find_flesh" && self.completed_emerging_into_playable_area !== 1) {
            return;
        }
    }
    b_in_active_zone = self zm_zonemgr::entity_in_active_zone();
    if (isdefined(level.var_fe52218) && level.var_fe52218) {
        var_334f2464 = self zm_zonemgr::get_zone_from_position(self.origin);
        if (isdefined(var_334f2464) && zm_zonemgr::get_players_in_zone(var_334f2464) == 0) {
            b_in_active_zone = 0;
        }
    }
    level.n_cleanups_processed_this_frame++;
    if (!b_in_active_zone) {
        n_dist_sq_min = 10000000;
        players = getplayers();
        e_closest_player = players[0];
        foreach (player in players) {
            if (!isalive(player)) {
                continue;
            }
            n_dist_sq = distancesquared(self.origin, player.origin);
            if (n_dist_sq < n_dist_sq_min) {
                n_dist_sq_min = n_dist_sq;
                e_closest_player = player;
            }
        }
        if (isdefined(n_override_cleanup_dist)) {
            n_cleanup_dist_sq = n_override_cleanup_dist;
        } else if (isdefined(e_closest_player) && player_ahead_of_me(e_closest_player)) {
            n_cleanup_dist_sq = isdefined(level.var_11a34219) ? level.var_11a34219 : 189225;
        } else {
            n_cleanup_dist_sq = isdefined(level.var_1aa29bc2) ? level.var_1aa29bc2 : 250000;
        }
        if (n_dist_sq_min >= n_cleanup_dist_sq) {
            self thread function_9048ffb1();
        }
    }
}

// Namespace zm_cleanup/zm_cleanup_mgr
// Params 0, eflags: 0x4
// Checksum 0xf9ba1622, Offset: 0x808
// Size: 0x36
function private function_9048ffb1() {
    self.var_4507e122 = 1;
    self delete_zombie_noone_looking();
    if (isdefined(self)) {
        self.var_4507e122 = undefined;
    }
}

// Namespace zm_cleanup/zm_cleanup_mgr
// Params 0, eflags: 0x4
// Checksum 0x92189924, Offset: 0x848
// Size: 0xdc
function private delete_zombie_noone_looking() {
    if (isdefined(self.in_the_ground) && self.in_the_ground) {
        return;
    }
    if (!self.allowdeath) {
        return;
    }
    foreach (player in level.players) {
        if (player.sessionstate == "spectator") {
            continue;
        }
        if (self player_can_see_me(player)) {
            return;
        }
    }
    self cleanup_zombie();
}

// Namespace zm_cleanup/zm_cleanup_mgr
// Params 0, eflags: 0x0
// Checksum 0x3b5fdb9e, Offset: 0x930
// Size: 0xe4
function cleanup_zombie() {
    if (isdefined(self.var_aaea343e)) {
        b_success = self [[ self.var_aaea343e ]]();
        if (isdefined(b_success) && b_success) {
            return;
        }
    }
    self function_9d243698();
    self zombie_utility::reset_attack_spot();
    self.var_4d11bb60 = 1;
    self.var_4470ae57 = 1;
    self kill();
    waitframe(1);
    if (isdefined(self)) {
        /#
            debugstar(self.origin, 1000, (1, 1, 1));
        #/
        self delete();
    }
}

// Namespace zm_cleanup/zm_cleanup_mgr
// Params 1, eflags: 0x4
// Checksum 0x325d4615, Offset: 0xa20
// Size: 0x34
function private player_can_see_me(player) {
    return !player function_aa4d7ad1(self, 0.766, 1);
}

// Namespace zm_cleanup/zm_cleanup_mgr
// Params 1, eflags: 0x4
// Checksum 0x73922869, Offset: 0xa60
// Size: 0xb0
function private player_ahead_of_me(player) {
    v_player_angles = player getplayerangles();
    v_player_forward = anglestoforward(v_player_angles);
    v_dir = player getorigin() - self.origin;
    n_dot = vectordot(v_player_forward, v_dir);
    if (n_dot < 0) {
        return false;
    }
    return true;
}

// Namespace zm_cleanup/zm_cleanup_mgr
// Params 0, eflags: 0x0
// Checksum 0x47480d26, Offset: 0xb18
// Size: 0xba
function get_escape_position() {
    self endon(#"death");
    if (isdefined(self.zone_name)) {
        str_zone = self.zone_name;
    } else {
        str_zone = self zm_utility::get_current_zone();
    }
    if (isdefined(str_zone)) {
        a_zones = get_adjacencies_to_zone(str_zone);
        a_wait_locations = get_wait_locations_in_zones(a_zones);
        s_farthest = self get_farthest_wait_location(a_wait_locations);
    }
    return s_farthest;
}

// Namespace zm_cleanup/zm_cleanup_mgr
// Params 1, eflags: 0x0
// Checksum 0xeeabd05a, Offset: 0xbe0
// Size: 0x104
function get_adjacencies_to_zone(str_zone) {
    a_adjacencies = [];
    a_adjacencies[0] = str_zone;
    a_adjacent_zones = getarraykeys(level.zones[str_zone].adjacent_zones);
    for (i = 0; i < a_adjacent_zones.size; i++) {
        if (level.zones[str_zone].adjacent_zones[a_adjacent_zones[i]].is_connected) {
            if (!isdefined(a_adjacencies)) {
                a_adjacencies = [];
            } else if (!isarray(a_adjacencies)) {
                a_adjacencies = array(a_adjacencies);
            }
            a_adjacencies[a_adjacencies.size] = a_adjacent_zones[i];
        }
    }
    return a_adjacencies;
}

// Namespace zm_cleanup/zm_cleanup_mgr
// Params 1, eflags: 0x4
// Checksum 0xbe3c67e4, Offset: 0xcf0
// Size: 0x154
function private get_wait_locations_in_zones(a_zones) {
    a_wait_locations = [];
    foreach (zone in a_zones) {
        if (isdefined(level.zones[zone].a_loc_types) && isdefined(level.zones[zone].a_loc_types[#"wait_location"])) {
            a_wait_locations = arraycombine(a_wait_locations, level.zones[zone].a_loc_types[#"wait_location"], 0, 0);
            continue;
        }
        /#
            println("<dev string:x30>" + zone + "<dev string:x41>");
            iprintln("<dev string:x30>" + zone + "<dev string:x41>");
        #/
    }
    return a_wait_locations;
}

// Namespace zm_cleanup/zm_cleanup_mgr
// Params 1, eflags: 0x4
// Checksum 0xce915ce, Offset: 0xe50
// Size: 0x60
function private get_farthest_wait_location(a_wait_locations) {
    if (!isdefined(a_wait_locations) || a_wait_locations.size == 0) {
        return undefined;
    }
    var_9a5ec027 = arraysortclosest(a_wait_locations, self.origin);
    return var_9a5ec027[var_9a5ec027.size - 1];
}

// Namespace zm_cleanup/zm_cleanup_mgr
// Params 1, eflags: 0x4
// Checksum 0x8783e4b6, Offset: 0xeb8
// Size: 0x8e
function private get_wait_locations_in_zone(zone) {
    if (isdefined(level.zones[zone].a_loc_types[#"wait_location"])) {
        a_wait_locations = [];
        a_wait_locations = arraycombine(a_wait_locations, level.zones[zone].a_loc_types[#"wait_location"], 0, 0);
        return a_wait_locations;
    }
    return undefined;
}

// Namespace zm_cleanup/zm_cleanup_mgr
// Params 0, eflags: 0x0
// Checksum 0xee39336c, Offset: 0xf50
// Size: 0x92
function get_escape_position_in_current_zone() {
    self endon(#"death");
    str_zone = self.zone_name;
    if (!isdefined(str_zone)) {
        str_zone = self.zone_name;
    }
    if (isdefined(str_zone)) {
        a_wait_locations = get_wait_locations_in_zone(str_zone);
        if (isdefined(a_wait_locations)) {
            s_farthest = self get_farthest_wait_location(a_wait_locations);
        }
    }
    return s_farthest;
}

// Namespace zm_cleanup/zm_cleanup_mgr
// Params 1, eflags: 0x0
// Checksum 0xd17cc7d, Offset: 0xff0
// Size: 0xdc
function no_target_override(ai_zombie) {
    if (!isdefined(ai_zombie.var_b52b26b9)) {
        ai_zombie.var_b52b26b9 = ai_zombie get_escape_position();
        ai_zombie val::set(#"zm_cleanup_mgr", "ignoreall", 1);
    }
    if (isdefined(ai_zombie.var_b52b26b9)) {
        self setgoal(ai_zombie.var_b52b26b9.origin, 0, 0, 200);
        return;
    }
    self setgoal(ai_zombie.origin, 0, 0, 200);
}

// Namespace zm_cleanup/zm_cleanup_mgr
// Params 1, eflags: 0x0
// Checksum 0xe58a0770, Offset: 0x10d8
// Size: 0x3c
function function_f86a6db6(ai_zombie) {
    ai_zombie.var_b52b26b9 = undefined;
    ai_zombie val::reset(#"zm_cleanup_mgr", "ignoreall");
}

// Namespace zm_cleanup/zm_cleanup_mgr
// Params 1, eflags: 0x0
// Checksum 0x275aa4fa, Offset: 0x1120
// Size: 0x196
function function_c831bc22(b_timeout = 0) {
    a_ai_enemies = getaiteamarray(#"axis");
    foreach (ai_enemy in a_ai_enemies) {
        if (!isalive(ai_enemy)) {
            continue;
        } else if (b_timeout && isdefined(ai_enemy.var_2e8cef76) && ai_enemy.var_2e8cef76) {
            continue;
        } else if (!b_timeout && isdefined(ai_enemy.b_ignore_cleanup) && ai_enemy.b_ignore_cleanup) {
            continue;
        }
        if (!ai_enemy.allowdeath) {
            continue;
        }
        ai_enemy function_9d243698(1);
        ai_enemy zombie_utility::reset_attack_spot();
        ai_enemy.var_4d11bb60 = 1;
        ai_enemy kill();
        waitframe(1);
    }
}

// Namespace zm_cleanup/zm_cleanup_mgr
// Params 1, eflags: 0x0
// Checksum 0x9466b1d5, Offset: 0x12c0
// Size: 0x26e
function function_9d243698(var_f740655c = 0) {
    if (!(isdefined(self.exclude_cleanup_adding_to_total) && self.exclude_cleanup_adding_to_total)) {
        if (var_f740655c) {
            level.var_1ffbf287++;
        } else {
            level.zombie_total++;
            level.zombie_respawns++;
            level.zombie_total_subtract++;
        }
        if (!isdefined(self.maxhealth)) {
            self.maxhealth = self.health;
        }
        if (self.health > 0 && self.health < self.maxhealth || isdefined(self.var_e4ccc825) && self.var_e4ccc825) {
            var_6ecee90e = {#n_health:self.health, #var_d766c1dc:self.var_d766c1dc};
            if (!isdefined(level.var_831bfaed[self.archetype])) {
                level.var_831bfaed[self.archetype] = [];
            } else if (!isarray(level.var_831bfaed[self.archetype])) {
                level.var_831bfaed[self.archetype] = array(level.var_831bfaed[self.archetype]);
            }
            level.var_831bfaed[self.archetype][level.var_831bfaed[self.archetype].size] = var_6ecee90e;
        }
        if (isdefined(level.var_b1c632de) && isdefined(level.var_b1c632de[self.archetype])) {
            foreach (func in level.var_b1c632de[self.archetype]) {
                self [[ func ]](var_f740655c);
            }
        }
    }
}

// Namespace zm_cleanup/zm_cleanup_mgr
// Params 0, eflags: 0x0
// Checksum 0x585e737c, Offset: 0x1538
// Size: 0x11c
function function_3944eecb() {
    if (isdefined(level.var_831bfaed[self.archetype]) && level.var_831bfaed[self.archetype].size > 0) {
        var_6ecee90e = level.var_831bfaed[self.archetype][0];
        self.health = var_6ecee90e.n_health;
        if (isdefined(var_6ecee90e.var_d766c1dc)) {
            foreach (var_d4ef00bc in var_6ecee90e.var_d766c1dc) {
                self [[ var_d4ef00bc ]]();
            }
        }
        arrayremovevalue(level.var_831bfaed[self.archetype], var_6ecee90e);
    }
}

