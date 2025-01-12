#using script_19367cd29a4485db;
#using script_1cc417743d7c262d;
#using script_27347f09888ad15;
#using script_3357acf79ce92f4b;
#using script_3411bb48d41bd3b;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\laststand_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;

#namespace namespace_2c949ef8;

// Namespace namespace_2c949ef8/namespace_2c949ef8
// Params 0, eflags: 0x0
// Checksum 0x4e6814e6, Offset: 0x190
// Size: 0x1c
function init() {
    level thread main();
}

// Namespace namespace_2c949ef8/namespace_2c949ef8
// Params 0, eflags: 0x1 linked
// Checksum 0xdc2086a9, Offset: 0x1b8
// Size: 0x34
function main() {
    level thread function_5e62ed5c();
    /#
        init_devgui();
    #/
}

// Namespace namespace_2c949ef8/namespace_2c949ef8
// Params 0, eflags: 0x1 linked
// Checksum 0xde96b1af, Offset: 0x1f8
// Size: 0x538
function function_5e62ed5c() {
    level endon(#"game_ended", #"hash_745d15f8fa0daab0");
    while (true) {
        if (!isdefined(level.var_cf15d540)) {
            level.var_cf15d540 = 300;
        }
        if (!isdefined(level.var_f535b5f0)) {
            level.var_f535b5f0 = 480;
        }
        level.var_49f4fe8e = undefined;
        var_7f729179 = level waittilltimeout(randomfloatrange(level.var_cf15d540, level.var_f535b5f0), #"start_ambush", #"objective_locked");
        if (level flag::get("objective_locked")) {
            level flag::wait_till_clear("objective_locked");
            continue;
        }
        a_players = namespace_85745671::function_347f7d34();
        a_ai_zombies = getaiarray();
        var_571f5454 = undefined;
        e_target = undefined;
        if (var_7f729179._notify === "start_ambush") {
            if (!isdefined(level.var_49f4fe8e)) {
                level.var_49f4fe8e = 1;
            }
            if (isdefined(var_7f729179.player)) {
                e_target = var_7f729179.player;
                var_571f5454 = e_target.origin;
            } else if (isdefined(var_7f729179.location)) {
                var_571f5454 = var_7f729179.location;
                if (a_players.size > 0) {
                    e_target = arraygetclosest(var_571f5454, a_players);
                }
            }
        } else if (getdvarint(#"hash_21e1866f0c677ab8", 1)) {
            return;
        }
        if (isdefined(e_target)) {
            var_120d0570 = array::get_all_closest(e_target.origin, a_ai_zombies, undefined, undefined, 1200);
        } else if (a_players.size > 0) {
            var_5502295b = function_8af8f660();
            var_df053feb = array::get_all_farthest(var_5502295b, a_players);
            foreach (player in var_df053feb) {
                var_120d0570 = array::get_all_closest(player.origin, a_ai_zombies, undefined, undefined, 1200);
                if (var_120d0570.size <= 10) {
                    var_571f5454 = player.origin;
                    break;
                }
            }
        }
        if (isdefined(var_571f5454)) {
            v_loc = getclosestpointonnavmesh(var_571f5454, 4000);
        }
        if (isdefined(v_loc)) {
            foreach (safehouse in struct::get_array("safehouse", "content_script_name")) {
                if (isdefined(safehouse.origin) && distance2dsquared(v_loc, safehouse.origin) <= function_a3f6cdac(2000)) {
                    v_loc = undefined;
                    break;
                }
            }
        }
        if (isdefined(v_loc)) {
            level function_47838885(var_120d0570);
            var_76913854 = array::get_all_closest(v_loc, a_players, undefined, undefined, 4000);
            array::thread_all(var_76913854, &function_f4413120);
            level function_156560eb(v_loc, var_76913854.size, level.var_49f4fe8e, 1);
            level thread function_39925c0d();
        }
    }
}

// Namespace namespace_2c949ef8/namespace_2c949ef8
// Params 0, eflags: 0x1 linked
// Checksum 0x5c47637, Offset: 0x738
// Size: 0x58
function function_39925c0d() {
    level endon(#"game_ended", #"hash_51e64b5183e4c028", #"hash_745d15f8fa0daab0");
    wait 240;
    level notify(#"hash_51e64b5183e4c028");
}

// Namespace namespace_2c949ef8/namespace_2c949ef8
// Params 0, eflags: 0x1 linked
// Checksum 0xd2aedbe0, Offset: 0x798
// Size: 0x44
function function_f4413120() {
    self playsoundtoplayer(#"hash_177c25d969608d58", self);
    self thread globallogic_audio::leader_dialog_on_player("ambush");
}

// Namespace namespace_2c949ef8/namespace_2c949ef8
// Params 1, eflags: 0x1 linked
// Checksum 0xae5559e3, Offset: 0x7e8
// Size: 0xb8
function function_be6ec6c(var_2b43a4c4) {
    if (!isdefined(var_2b43a4c4)) {
        level notify(#"start_ambush");
        return;
    }
    if (isplayer(var_2b43a4c4)) {
        level notify(#"start_ambush", {#player:var_2b43a4c4});
        return;
    }
    if (isvec(var_2b43a4c4)) {
        level notify(#"start_ambush", {#location:var_2b43a4c4});
    }
}

// Namespace namespace_2c949ef8/namespace_2c949ef8
// Params 1, eflags: 0x1 linked
// Checksum 0xc3a934ff, Offset: 0x8a8
// Size: 0xc8
function function_47838885(var_120d0570) {
    if (isarray(var_120d0570)) {
        foreach (ai_zombie in var_120d0570) {
            if (ai_zombie.team === #"axis") {
                ai_zombie thread namespace_85745671::function_9456addc(60);
            }
        }
    }
}

// Namespace namespace_2c949ef8/namespace_2c949ef8
// Params 9, eflags: 0x1 linked
// Checksum 0x702fac44, Offset: 0x978
// Size: 0x5ec
function function_156560eb(var_cf21a49f, n_players, var_e2c6e83b = 0, var_d2bf5986 = 0, var_437c9d8d = 2000, var_f24d0052 = 4000, var_8aa4c024 = 2000, var_fb65d2df, var_6cd49f50) {
    level endon(#"game_ended", #"hash_51e64b5183e4c028", #"hash_745d15f8fa0daab0");
    n_spawns = 0;
    var_5b660261 = undefined;
    if (is_true(var_d2bf5986)) {
        if (math::cointoss()) {
            var_58a6f31e = 1;
            var_e2c6e83b = 1;
        }
    }
    switch (n_players) {
    case 1:
        n_delay = 5;
        var_69020c4a = randomintrangeinclusive(8, 10);
        break;
    case 2:
        n_delay = 4;
        var_69020c4a = randomintrangeinclusive(12, 15);
        break;
    case 3:
        n_delay = 3;
        var_69020c4a = randomintrangeinclusive(16, 20);
        break;
    default:
        n_delay = 1.5;
        var_69020c4a = randomintrangeinclusive(21, 25);
        break;
    }
    if (isdefined(var_fb65d2df)) {
        n_delay = var_fb65d2df;
    }
    while (true) {
        var_bb956a6c = [];
        var_bb956a6c = array::randomize(namespace_85745671::function_e4791424(var_cf21a49f, 12, 80, var_f24d0052, var_437c9d8d));
        if (var_bb956a6c.size == 0) {
            a_players = namespace_85745671::function_347f7d34();
            if (a_players.size > 0) {
                e_target = arraygetclosest(var_cf21a49f, a_players);
            }
            if (isdefined(e_target)) {
                var_bb956a6c = array::randomize(namespace_85745671::function_e4791424(e_target.origin, 12, 80, var_f24d0052, var_437c9d8d));
            }
        }
        if (!var_e2c6e83b) {
            if (!isdefined(var_5b660261) && isdefined(var_bb956a6c[0])) {
                var_5b660261 = array::randomize(namespace_85745671::function_e4791424(var_bb956a6c[0].origin, 12, 80, var_8aa4c024, 8));
            }
            if (isdefined(var_5b660261)) {
                var_bb956a6c = var_5b660261;
            }
        }
        v_spawn = var_bb956a6c[0].origin;
        if (!isdefined(v_spawn)) {
            wait 1;
            continue;
        }
        for (i = 0; i < var_bb956a6c.size; i++) {
            var_663d8b4e = randomintrangeinclusive(3, 5);
            v_dir = vectornormalize(var_cf21a49f - v_spawn);
            v_dir = (v_dir[0], v_dir[1], 0);
            v_angles = vectortoangles(v_dir);
            for (j = 0; j < var_663d8b4e; j++) {
                if (n_spawns >= var_69020c4a) {
                    level notify(#"hash_51e64b5183e4c028");
                }
                if (is_true(var_58a6f31e)) {
                    var_283596b4 = #"hash_42cbb8cb19ae56dd";
                } else {
                    var_283596b4 = namespace_679a22ba::function_ca209564("default_zombies_realm_" + level.realm).var_990b33df;
                }
                if (isdefined(v_spawn) && isdefined(var_283596b4) && isdefined(v_angles)) {
                    ai_spawned = namespace_85745671::function_9d3ad056(var_283596b4, v_spawn + (0, 0, 32), v_angles, "ambush_zombie");
                }
                if (isdefined(ai_spawned)) {
                    ai_spawned.var_9602c8b2 = &function_12db74f8;
                    ai_spawned thread function_1c491c2b(var_6cd49f50);
                    n_spawns++;
                }
                v_spawn = var_bb956a6c[j + 1].origin;
                if (!isdefined(v_spawn)) {
                    v_spawn = var_bb956a6c[0].origin;
                    break;
                }
                wait 0.5;
            }
            wait n_delay;
        }
        wait 0.5;
    }
}

// Namespace namespace_2c949ef8/namespace_2c949ef8
// Params 1, eflags: 0x1 linked
// Checksum 0x970d4df1, Offset: 0xf70
// Size: 0xa6
function function_1c491c2b(var_6cd49f50 = 60) {
    self endon(#"death");
    self thread namespace_85745671::function_9456addc(var_6cd49f50);
    while (true) {
        if (getplayers("all", self.origin, 6000).size == 0) {
            self callback::callback(#"hash_10ab46b52df7967a");
        }
        wait 5;
    }
}

// Namespace namespace_2c949ef8/namespace_2c949ef8
// Params 0, eflags: 0x1 linked
// Checksum 0x1cb9ca86, Offset: 0x1020
// Size: 0x84
function function_12db74f8() {
    if (self.aitype != #"hash_46c917a1b5ed91e7" && randomint(100) > 60) {
        var_53c97e88 = #"super_sprint";
    } else {
        var_53c97e88 = #"sprint";
    }
    self namespace_85745671::function_9758722(var_53c97e88);
}

// Namespace namespace_2c949ef8/namespace_2c949ef8
// Params 0, eflags: 0x5 linked
// Checksum 0x28f7c312, Offset: 0x10b0
// Size: 0xf2
function private function_8af8f660() {
    var_657dc854 = (0, 0, 0);
    a_players = getplayers();
    foreach (player in a_players) {
        if (player.sessionstate === "spectator") {
            continue;
        }
        var_657dc854 += function_b5c91b37(player);
    }
    if (a_players.size > 1) {
        var_657dc854 /= a_players.size;
    }
    return var_657dc854;
}

// Namespace namespace_2c949ef8/namespace_2c949ef8
// Params 1, eflags: 0x5 linked
// Checksum 0x1e271651, Offset: 0x11b0
// Size: 0x82
function private function_b5c91b37(player) {
    if (player isinvehicle()) {
        velocity = player getvehicleoccupied() getvelocity();
    } else {
        velocity = player getvelocity();
    }
    return player.origin + velocity * 5;
}

// Namespace namespace_2c949ef8/namespace_2c949ef8
// Params 1, eflags: 0x1 linked
// Checksum 0x2051f584, Offset: 0x1240
// Size: 0x1b8
function function_c0966bb1(destination) {
    a_triggers = array::randomize(getentarray("ambush_trigger", "targetname"));
    if (!a_triggers.size) {
        return;
    }
    level flag::set(#"hash_44074059e3987765");
    n_max = a_triggers.size * 0.5;
    n_count = 0;
    /#
        if (getdvarint(#"hash_11ff4ccbba6b40f6", 0)) {
            n_max = a_triggers.size;
        }
    #/
    foreach (trigger in a_triggers) {
        trigger.var_83523415 = undefined;
        if (n_count < n_max && trigger.destination === destination.targetname) {
            trigger callback::on_trigger(&function_39ee3b21);
            n_count++;
            continue;
        }
        trigger callback::remove_on_trigger(&function_39ee3b21);
    }
}

// Namespace namespace_2c949ef8/namespace_2c949ef8
// Params 1, eflags: 0x1 linked
// Checksum 0xe5a3e60, Offset: 0x1400
// Size: 0x280
function function_39ee3b21(eventstruct) {
    if (!is_true(self.var_83523415) && isplayer(eventstruct.activator) && level flag::get(#"hash_44074059e3987765")) {
        self.var_83523415 = 1;
        self callback::remove_on_trigger(&function_39ee3b21);
        str_bundle = "default_zombies_realm_" + level.realm;
        a_spawns = array::randomize(struct::get_array(self.target));
        foreach (spawn in a_spawns) {
            if (getaicount() < getailimit()) {
                var_4bf95f4c = namespace_679a22ba::function_ca209564(str_bundle);
                if (!isdefined(var_4bf95f4c)) {
                    break;
                }
                ai = spawnactor(var_4bf95f4c.var_990b33df, spawn.origin, spawn.angles, undefined, 1, 1);
                if (isdefined(ai)) {
                    if (isdefined(spawn.var_90d0c0ff)) {
                        ai.var_c9b11cb3 = spawn.var_90d0c0ff;
                    }
                    ai thread awareness::function_c241ef9a(ai, eventstruct.activator, 10);
                    ai callback::function_d8abfc3d(#"hash_4afe635f36531659", &function_5c3d1f);
                }
            }
            waitframe(randomintrange(2, 5));
        }
    }
}

// Namespace namespace_2c949ef8/namespace_2c949ef8
// Params 0, eflags: 0x1 linked
// Checksum 0xe2df65fd, Offset: 0x1688
// Size: 0x114
function function_5c3d1f() {
    self notify("29ccb61bea4c3154");
    self endon("29ccb61bea4c3154");
    self endon(#"death");
    if (self.current_state.name !== #"wander" && self.current_state.name !== #"idle") {
        return;
    }
    while (self.birthtime + int(15 * 1000) > gettime()) {
        wait 1;
    }
    if (self.current_state.name === #"wander" || self.current_state.name === #"idle") {
        self callback::callback(#"hash_10ab46b52df7967a");
    }
}

/#

    // Namespace namespace_2c949ef8/namespace_2c949ef8
    // Params 0, eflags: 0x0
    // Checksum 0xd77e03ba, Offset: 0x17a8
    // Size: 0x1d4
    function init_devgui() {
        mapname = util::get_map_name();
        adddebugcommand("<dev string:x38>" + mapname + "<dev string:x49>");
        adddebugcommand("<dev string:x38>" + mapname + "<dev string:x83>");
        adddebugcommand("<dev string:x38>" + mapname + "<dev string:xbf>");
        adddebugcommand("<dev string:x38>" + mapname + "<dev string:xf7>");
        adddebugcommand("<dev string:x38>" + mapname + "<dev string:x141>");
        adddebugcommand("<dev string:x38>" + mapname + "<dev string:x191>");
        adddebugcommand("<dev string:x38>" + mapname + "<dev string:x1d9>");
        adddebugcommand("<dev string:x38>" + mapname + "<dev string:x221>");
        adddebugcommand("<dev string:x38>" + mapname + "<dev string:x275>");
        level thread function_2ebea850();
        level thread function_cfc99c9e();
        level thread function_986ead58();
    }

    // Namespace namespace_2c949ef8/namespace_2c949ef8
    // Params 0, eflags: 0x0
    // Checksum 0xd7ad179a, Offset: 0x1988
    // Size: 0x268
    function function_2ebea850() {
        while (true) {
            if (getdvarint(#"hash_21e1866f0c677ab8", 0)) {
                level notify(#"hash_745d15f8fa0daab0");
                setdvar(#"hash_21e1866f0c677ab8", 0);
            } else if (getdvarint(#"hash_606c763dd8de6def", 0)) {
                level notify(#"hash_745d15f8fa0daab0");
                level thread function_5e62ed5c();
                setdvar(#"hash_606c763dd8de6def", 0);
            } else if (getdvarint(#"hash_56ab9987e62df113", 0)) {
                level notify(#"hash_51e64b5183e4c028");
                array::run_all(getaiarray("<dev string:x2d0>", "<dev string:x2e1>"), &kill);
                setdvar(#"hash_56ab9987e62df113", 0);
            } else if (getdvarint(#"hash_94d12ce1eee7e5a", 0)) {
                level.var_49f4fe8e = 1;
                level thread function_be6ec6c();
                setdvar(#"hash_94d12ce1eee7e5a", 0);
            } else if (getdvarint(#"hash_3139027e2331e6b6", 0)) {
                level.var_49f4fe8e = 0;
                level thread function_be6ec6c();
                setdvar(#"hash_3139027e2331e6b6", 0);
            }
            wait 0.1;
        }
    }

    // Namespace namespace_2c949ef8/namespace_2c949ef8
    // Params 0, eflags: 0x0
    // Checksum 0x2459549, Offset: 0x1bf8
    // Size: 0x138
    function function_cfc99c9e() {
        while (true) {
            if (getdvarint(#"hash_6c7a7cb80d06cc72", 0)) {
                level notify(#"hash_745d15f8fa0daab0");
                level.var_cf15d540 = 30;
                level.var_f535b5f0 = 40;
                level thread function_5e62ed5c();
                setdvar(#"hash_6c7a7cb80d06cc72", 0);
            } else if (getdvarint(#"hash_4ca0f239aa5ff2d7", 0)) {
                level notify(#"hash_745d15f8fa0daab0");
                level.var_cf15d540 = 300;
                level.var_f535b5f0 = 480;
                level thread function_5e62ed5c();
                setdvar(#"hash_4ca0f239aa5ff2d7", 0);
            }
            wait 0.1;
        }
    }

    // Namespace namespace_2c949ef8/namespace_2c949ef8
    // Params 0, eflags: 0x0
    // Checksum 0xbf0e14c8, Offset: 0x1d38
    // Size: 0x120
    function function_986ead58() {
        while (true) {
            if (getdvarint(#"hash_35d97c59a1cbade9", 0)) {
                spawns = function_10c88d2e();
                level thread namespace_420b39d3::function_46997bdf(&spawns, "<dev string:x2ef>");
                setdvar(#"hash_35d97c59a1cbade9", 0);
            } else if (getdvarint(#"hash_2fcac2478bfe37f7", 0)) {
                spawns = function_10c88d2e();
                namespace_420b39d3::function_70e877d7(&spawns);
                setdvar(#"hash_2fcac2478bfe37f7", 0);
            }
            wait 0.1;
        }
    }

    // Namespace namespace_2c949ef8/namespace_2c949ef8
    // Params 0, eflags: 0x0
    // Checksum 0x9da98001, Offset: 0x1e60
    // Size: 0x138
    function function_10c88d2e() {
        spawns = [];
        if (isdefined(level.var_7d45d0d4.currentdestination)) {
            destination = level.var_7d45d0d4.currentdestination;
            a_triggers = getentarray("<dev string:x2f9>", "<dev string:x2e1>");
            foreach (trigger in a_triggers) {
                if (trigger.destination === destination.targetname) {
                    a_spawns = struct::get_array(trigger.target);
                    spawns = arraycombine(a_spawns, spawns);
                }
            }
        }
        return spawns;
    }

#/
