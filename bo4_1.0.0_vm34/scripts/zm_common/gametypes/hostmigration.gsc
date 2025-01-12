#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\hud_shared;
#using scripts\core_common\hud_util_shared;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\zm_common\zm;
#using scripts\zm_common\zm_player;
#using scripts\zm_common\zm_utility;

#namespace hostmigration;

/#

    // Namespace hostmigration/hostmigration
    // Params 0, eflags: 0x0
    // Checksum 0x1dfc71ff, Offset: 0x1b0
    // Size: 0x134
    function debug_script_structs() {
        if (isdefined(level.struct)) {
            println("<dev string:x30>" + level.struct.size);
            println("<dev string:x41>");
            for (i = 0; i < level.struct.size; i++) {
                struct = level.struct[i];
                if (isdefined(struct.targetname)) {
                    println("<dev string:x42>" + i + "<dev string:x46>" + struct.targetname);
                    continue;
                }
                println("<dev string:x42>" + i + "<dev string:x46>" + "<dev string:x4a>");
            }
            return;
        }
        println("<dev string:x4f>");
    }

#/

// Namespace hostmigration/hostmigration
// Params 0, eflags: 0x0
// Checksum 0x3d7c70cc, Offset: 0x2f0
// Size: 0x9e
function updatetimerpausedness() {
    shouldbestopped = isdefined(level.hostmigrationtimer);
    if (!level.timerstopped && shouldbestopped) {
        level.timerstopped = 1;
        level.timerpausetime = gettime();
        return;
    }
    if (level.timerstopped && !shouldbestopped) {
        level.timerstopped = 0;
        level.discardtime += gettime() - level.timerpausetime;
    }
}

// Namespace hostmigration/hostmigration
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x398
// Size: 0x4
function callback_hostmigrationsave() {
    
}

// Namespace hostmigration/hostmigration
// Params 0, eflags: 0x0
// Checksum 0x939476e3, Offset: 0x3a8
// Size: 0x106
function callback_prehostmigrationsave() {
    zm_utility::undo_link_changes();
    if (isdefined(level._hm_should_pause_spawning) && level._hm_should_pause_spawning) {
        level flag::set("spawn_zombies");
    }
    for (i = 0; i < level.players.size; i++) {
        level.players[i] val::set(#"host_migration", "takedamage", 0);
        level.players[i] stats::set_stat(#"afteractionreportstats", #"lobbypopup", #"summary");
    }
}

// Namespace hostmigration/hostmigration
// Params 0, eflags: 0x0
// Checksum 0xcb08c24f, Offset: 0x4b8
// Size: 0x12
function pausetimer() {
    level.migrationtimerpausetime = gettime();
}

// Namespace hostmigration/hostmigration
// Params 0, eflags: 0x0
// Checksum 0xac48c0dc, Offset: 0x4d8
// Size: 0x2a
function resumetimer() {
    level.discardtime += gettime() - level.migrationtimerpausetime;
}

// Namespace hostmigration/hostmigration
// Params 0, eflags: 0x0
// Checksum 0x7ca7d882, Offset: 0x510
// Size: 0x86
function locktimer() {
    level endon(#"host_migration_begin");
    level endon(#"host_migration_end");
    for (;;) {
        currtime = gettime();
        waitframe(1);
        if (!level.timerstopped && isdefined(level.discardtime)) {
            level.discardtime += gettime() - currtime;
        }
    }
}

// Namespace hostmigration/hostmigration
// Params 0, eflags: 0x0
// Checksum 0x2e323ad4, Offset: 0x5a0
// Size: 0x810
function callback_hostmigration() {
    zm_utility::redo_link_changes();
    setslowmotion(1, 1, 0);
    level.hostmigrationreturnedplayercount = 0;
    if (level.gameended) {
        println("<dev string:x67>" + gettime() + "<dev string:x83>");
        return;
    }
    sethostmigrationstatus(1);
    level notify(#"host_migration_begin");
    for (i = 0; i < level.players.size; i++) {
        if (isdefined(level.hostmigration_link_entity_callback)) {
            if (!isdefined(level.players[i]._host_migration_link_entity)) {
                level.players[i]._host_migration_link_entity = level.players[i] [[ level.hostmigration_link_entity_callback ]]();
            }
        }
        level.players[i] thread hostmigrationtimerthink();
    }
    if (isdefined(level.hostmigration_ai_link_entity_callback)) {
        zombies = getaiteamarray(level.zombie_team);
        if (isdefined(zombies) && zombies.size > 0) {
            foreach (zombie in zombies) {
                if (!isdefined(zombie._host_migration_link_entity)) {
                    zombie._host_migration_link_entity = zombie [[ level.hostmigration_ai_link_entity_callback ]]();
                }
            }
        }
    } else {
        zombies = getaiteamarray(level.zombie_team);
        if (isdefined(zombies) && zombies.size > 0) {
            foreach (zombie in zombies) {
                zombie.no_powerups = 1;
                zombie.marked_for_recycle = 1;
                zombie.has_been_damaged_by_player = 0;
                zombie dodamage(zombie.health + 1000, zombie.origin, zombie);
            }
        }
    }
    if (level.inprematchperiod) {
        level waittill(#"prematch_over");
    }
    println("<dev string:x67>" + gettime());
    level.hostmigrationtimer = 1;
    thread locktimer();
    if (isdefined(level.b_host_migration_force_player_respawn) && level.b_host_migration_force_player_respawn) {
        foreach (player in level.players) {
            if (zm_utility::is_player_valid(player, 0, 0)) {
                player host_migration_respawn();
            }
        }
    }
    zombies = getaiteamarray(level.zombie_team);
    if (isdefined(zombies) && zombies.size > 0) {
        foreach (zombie in zombies) {
            if (isdefined(zombie._host_migration_link_entity)) {
                ent = spawn("script_origin", zombie.origin);
                ent.angles = zombie.angles;
                zombie linkto(ent);
                ent linkto(zombie._host_migration_link_entity, "tag_origin", zombie._host_migration_link_entity worldtolocalcoords(ent.origin), ent.angles + zombie._host_migration_link_entity.angles);
                zombie._host_migration_link_helper = ent;
                zombie linkto(zombie._host_migration_link_helper);
            }
        }
    }
    level endon(#"host_migration_begin");
    should_pause_spawning = level flag::get("spawn_zombies");
    if (should_pause_spawning) {
        level flag::clear("spawn_zombies");
    }
    hostmigrationwait();
    foreach (player in level.players) {
        player thread post_migration_invulnerability();
    }
    zombies = getaiteamarray(level.zombie_team);
    if (isdefined(zombies) && zombies.size > 0) {
        foreach (zombie in zombies) {
            if (isdefined(zombie._host_migration_link_entity)) {
                zombie unlink();
                zombie._host_migration_link_helper delete();
                zombie._host_migration_link_helper = undefined;
                zombie._host_migration_link_entity = undefined;
            }
        }
    }
    if (should_pause_spawning) {
        level flag::set("spawn_zombies");
    }
    level.hostmigrationtimer = undefined;
    level._hm_should_pause_spawning = undefined;
    sethostmigrationstatus(0);
    println("<dev string:xaa>" + gettime());
    level notify(#"host_migration_end");
}

// Namespace hostmigration/hostmigration
// Params 0, eflags: 0x0
// Checksum 0xdd6a8663, Offset: 0xdb8
// Size: 0x18
function post_migration_become_vulnerable() {
    self endon(#"disconnect");
}

// Namespace hostmigration/hostmigration
// Params 0, eflags: 0x0
// Checksum 0x7754994a, Offset: 0xdd8
// Size: 0x2c
function post_migration_invulnerability() {
    self thread val::set_for_time(3, "host_migration", "takedamage", 0);
}

// Namespace hostmigration/hostmigration
// Params 0, eflags: 0x0
// Checksum 0x6ff7a494, Offset: 0xe10
// Size: 0x100
function host_migration_respawn() {
    println("<dev string:xc6>");
    new_origin = undefined;
    if (isdefined(level.var_75eda423)) {
        new_origin = [[ level.var_75eda423 ]](self);
    }
    if (!isdefined(new_origin)) {
        new_origin = zm_player::check_for_valid_spawn_near_team(self, 1);
    }
    if (isdefined(new_origin)) {
        if (!isdefined(new_origin.angles)) {
            angles = (0, 0, 0);
        } else {
            angles = new_origin.angles;
        }
        self dontinterpolate();
        self setorigin(new_origin.origin);
        self setplayerangles(angles);
    }
    return true;
}

// Namespace hostmigration/hostmigration
// Params 1, eflags: 0x0
// Checksum 0x22ebf395, Offset: 0xf18
// Size: 0x72
function matchstarttimerconsole_internal(counttime) {
    waittillframeend();
    level endon(#"match_start_timer_beginning");
    luinotifyevent(#"create_prematch_timer", 2, gettime() + int(counttime * 1000), 1);
    wait counttime;
}

// Namespace hostmigration/hostmigration
// Params 2, eflags: 0x0
// Checksum 0x8d5fefc5, Offset: 0xf98
// Size: 0xac
function matchstarttimerconsole(type, duration) {
    level notify(#"match_start_timer_beginning");
    waitframe(1);
    counttime = int(duration);
    var_8ad39a91 = counttime >= 2;
    if (var_8ad39a91) {
        matchstarttimerconsole_internal(counttime);
    }
    luinotifyevent(#"prematch_timer_ended", 1, var_8ad39a91);
}

// Namespace hostmigration/hostmigration
// Params 1, eflags: 0x0
// Checksum 0x2ec87dd6, Offset: 0x1050
// Size: 0x8a
function function_ea08959e(duration) {
    array::thread_all(getplayers(), &zm::initialblack);
    fade_time = 4;
    n_black_screen = duration - fade_time;
    level thread zm::fade_out_intro_screen_zm(n_black_screen, fade_time, 1);
    wait fade_time;
}

// Namespace hostmigration/hostmigration
// Params 0, eflags: 0x0
// Checksum 0x2fb27e25, Offset: 0x10e8
// Size: 0x92
function hostmigrationwait() {
    level endon(#"game_ended");
    if (level.hostmigrationreturnedplayercount < level.players.size * 2 / 3) {
        thread matchstarttimerconsole("waiting_for_teams", 20);
        hostmigrationwaitforplayers();
    }
    thread matchstarttimerconsole("match_starting_in", 9);
    wait 5;
}

// Namespace hostmigration/hostmigration
// Params 0, eflags: 0x0
// Checksum 0xb132dd4a, Offset: 0x1188
// Size: 0x20
function hostmigrationwaitforplayers() {
    level endon(#"hostmigration_enoughplayers");
    wait 15;
}

// Namespace hostmigration/hostmigration
// Params 0, eflags: 0x0
// Checksum 0xbfa76b80, Offset: 0x11b0
// Size: 0x1ec
function hostmigrationtimerthink_internal() {
    level endon(#"host_migration_begin");
    level endon(#"host_migration_end");
    self.hostmigrationcontrolsfrozen = 0;
    while (!isalive(self)) {
        self waittill(#"spawned");
    }
    if (isdefined(self._host_migration_link_entity)) {
        ent = spawn("script_origin", self.origin);
        ent.angles = self.angles;
        self linkto(ent);
        ent linkto(self._host_migration_link_entity, "tag_origin", self._host_migration_link_entity worldtolocalcoords(ent.origin), ent.angles + self._host_migration_link_entity.angles);
        self._host_migration_link_helper = ent;
        println("<dev string:xf8>" + self._host_migration_link_entity.targetname);
    }
    self.hostmigrationcontrolsfrozen = 1;
    self val::set(#"host_migration", "freezecontrols");
    self val::set(#"host_migration", "disablegadgets");
    level waittill(#"host_migration_end");
}

// Namespace hostmigration/hostmigration
// Params 0, eflags: 0x0
// Checksum 0x89c3e284, Offset: 0x13a8
// Size: 0x13e
function hostmigrationtimerthink() {
    self endon(#"disconnect");
    level endon(#"host_migration_begin");
    hostmigrationtimerthink_internal();
    if (self.hostmigrationcontrolsfrozen) {
        self val::reset(#"host_migration", "freezecontrols");
        self val::reset(#"host_migration", "disablegadgets");
        self.hostmigrationcontrolsfrozen = 0;
        println("<dev string:x10f>");
    }
    if (isdefined(self._host_migration_link_entity)) {
        self unlink();
        self._host_migration_link_helper delete();
        self._host_migration_link_helper = undefined;
        if (isdefined(self._host_migration_link_entity._post_host_migration_thread)) {
            self thread [[ self._host_migration_link_entity._post_host_migration_thread ]](self._host_migration_link_entity);
        }
        self._host_migration_link_entity = undefined;
    }
}

// Namespace hostmigration/hostmigration
// Params 0, eflags: 0x0
// Checksum 0x55bfcf49, Offset: 0x14f0
// Size: 0x44
function waittillhostmigrationdone() {
    if (!isdefined(level.hostmigrationtimer)) {
        return 0;
    }
    starttime = gettime();
    level waittill(#"host_migration_end");
    return gettime() - starttime;
}

// Namespace hostmigration/hostmigration
// Params 1, eflags: 0x0
// Checksum 0xa0b88e18, Offset: 0x1540
// Size: 0x38
function waittillhostmigrationstarts(duration) {
    if (isdefined(level.hostmigrationtimer)) {
        return;
    }
    level endon(#"host_migration_begin");
    wait duration;
}

// Namespace hostmigration/hostmigration
// Params 1, eflags: 0x0
// Checksum 0xfbed498b, Offset: 0x1580
// Size: 0x114
function waitlongdurationwithhostmigrationpause(duration) {
    if (duration == 0) {
        return;
    }
    assert(duration > 0);
    starttime = gettime();
    for (endtime = gettime() + duration * 1000; gettime() < endtime; endtime += timepassed) {
        waittillhostmigrationstarts((endtime - gettime()) / 1000);
        if (isdefined(level.hostmigrationtimer)) {
            timepassed = waittillhostmigrationdone();
        }
    }
    if (gettime() != endtime) {
        println("<dev string:x131>" + gettime() + "<dev string:x14e>" + endtime);
    }
    waittillhostmigrationdone();
    return gettime() - starttime;
}

// Namespace hostmigration/hostmigration
// Params 1, eflags: 0x0
// Checksum 0x724a4f3a, Offset: 0x16a0
// Size: 0x16e
function waitlongdurationwithgameendtimeupdate(duration) {
    if (duration == 0) {
        return;
    }
    assert(duration > 0);
    starttime = gettime();
    endtime = gettime() + duration * 1000;
    while (gettime() < endtime) {
        waittillhostmigrationstarts((endtime - gettime()) / 1000);
        while (isdefined(level.hostmigrationtimer)) {
            endtime += 1000;
            setgameendtime(int(endtime));
            wait 1;
        }
    }
    /#
        if (gettime() != endtime) {
            println("<dev string:x131>" + gettime() + "<dev string:x14e>" + endtime);
        }
    #/
    while (isdefined(level.hostmigrationtimer)) {
        endtime += 1000;
        setgameendtime(int(endtime));
        wait 1;
    }
    return gettime() - starttime;
}

// Namespace hostmigration/hostmigration
// Params 5, eflags: 0x0
// Checksum 0x61be9ffe, Offset: 0x1818
// Size: 0x288
function find_alternate_player_place(v_origin, min_radius, max_radius, max_height, ignore_targetted_nodes) {
    found_node = undefined;
    a_nodes = getnodesinradiussorted(v_origin, max_radius, min_radius, max_height, "pathnodes");
    if (isdefined(a_nodes) && a_nodes.size > 0) {
        a_player_volumes = getentarray("player_volume", "script_noteworthy");
        index = a_nodes.size - 1;
        for (i = index; i >= 0; i--) {
            n_node = a_nodes[i];
            if (ignore_targetted_nodes == 1) {
                if (isdefined(n_node.target)) {
                    continue;
                }
            }
            if (!positionwouldtelefrag(n_node.origin)) {
                if (zm_utility::check_point_in_enabled_zone(n_node.origin, 1, a_player_volumes)) {
                    v_start = (n_node.origin[0], n_node.origin[1], n_node.origin[2] + 30);
                    v_end = (n_node.origin[0], n_node.origin[1], n_node.origin[2] - 30);
                    trace = bullettrace(v_start, v_end, 0, undefined);
                    if (trace[#"fraction"] < 1) {
                        override_abort = 0;
                        if (isdefined(level._whoswho_reject_node_override_func)) {
                            override_abort = [[ level._whoswho_reject_node_override_func ]](v_origin, n_node);
                        }
                        if (!override_abort) {
                            found_node = n_node;
                            break;
                        }
                    }
                }
            }
        }
    }
    return found_node;
}

// Namespace hostmigration/hostmigration
// Params 0, eflags: 0x0
// Checksum 0xa4653a8d, Offset: 0x1aa8
// Size: 0x344
function hostmigration_put_player_in_better_place() {
    spawnpoint = undefined;
    spawnpoint = find_alternate_player_place(self.origin, 50, 150, 64, 1);
    if (!isdefined(spawnpoint)) {
        spawnpoint = find_alternate_player_place(self.origin, 150, 400, 64, 1);
    }
    if (!isdefined(spawnpoint)) {
        spawnpoint = find_alternate_player_place(self.origin, 50, 400, 256, 0);
    }
    if (!isdefined(spawnpoint)) {
        spawnpoint = zm_player::check_for_valid_spawn_near_team(self, 1);
    }
    if (!isdefined(spawnpoint)) {
        match_string = "";
        location = level.scr_zm_map_start_location;
        if ((location == "default" || location == "") && isdefined(level.default_start_location)) {
            location = level.default_start_location;
        }
        match_string = level.scr_zm_ui_gametype + "_" + location;
        spawnpoints = [];
        structs = struct::get_array("initial_spawn", "script_noteworthy");
        if (isdefined(structs)) {
            foreach (struct in structs) {
                if (isdefined(struct.script_string)) {
                    tokens = strtok(struct.script_string, " ");
                    foreach (token in tokens) {
                        if (token == match_string) {
                            spawnpoints[spawnpoints.size] = struct;
                        }
                    }
                }
            }
        }
        if (!isdefined(spawnpoints) || spawnpoints.size == 0) {
            spawnpoints = struct::get_array("initial_spawn_points", "targetname");
        }
        assert(isdefined(spawnpoints), "<dev string:x167>");
        spawnpoint = zm_player::getfreespawnpoint(spawnpoints, self);
    }
    if (isdefined(spawnpoint)) {
        self setorigin(spawnpoint.origin);
    }
}

