#using script_113dd7f0ea2a1d4f;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\gameobjects_shared;
#using scripts\core_common\scoreevents_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\zm_stats;
#using scripts\zm_common\zm_utility;

#namespace zm_sq;

// Namespace zm_sq/zm_sq
// Params 0, eflags: 0x6
// Checksum 0x89d4617f, Offset: 0x138
// Size: 0x84
function private autoexec init() {
    /#
        if (getdvarint(#"hash_7919e37cd5d57659", 0)) {
            adddebugcommand("<dev string:x38>");
        }
    #/
    callback::on_disconnect(&on_player_disconnect);
    callback::on_connect(&on_player_connect);
}

// Namespace zm_sq/zm_sq
// Params 0, eflags: 0x1 linked
// Checksum 0x19c6a6e6, Offset: 0x1c8
// Size: 0x44
function on_player_disconnect() {
    /#
        if (getdvarint(#"zm_debug_ee", 0)) {
            self thread function_fa5a5bfd();
        }
    #/
}

// Namespace zm_sq/zm_sq
// Params 0, eflags: 0x1 linked
// Checksum 0xa49e4018, Offset: 0x218
// Size: 0x1a
function on_player_connect() {
    self.var_4fcae9dc = [];
    self.var_e453e8a5 = [];
}

// Namespace zm_sq/zm_sq
// Params 10, eflags: 0x1 linked
// Checksum 0x14cc6203, Offset: 0x240
// Size: 0x694
function register(name, step_name, var_e788cdd7, setup_func, cleanup_func, var_d6ca4caf, var_27465eb4, var_6cc77d4e, a_targets, var_441061cd) {
    /#
        assert(ishash(name), "<dev string:x7e>");
        assert(ishash(step_name), "<dev string:x98>");
        assert(ishash(var_e788cdd7), "<dev string:xb4>");
        if (!isdefined(name)) {
            if (getdvarint(#"hash_7919e37cd5d57659", 0)) {
                iprintlnbold("<dev string:xd4>");
                println("<dev string:xd4>");
            }
            return;
        }
        if (!isdefined(step_name)) {
            if (getdvarint(#"hash_7919e37cd5d57659", 0)) {
                iprintlnbold("<dev string:x118>");
                println("<dev string:x118>");
            }
            return;
        }
        if (!isdefined(setup_func)) {
            if (getdvarint(#"hash_7919e37cd5d57659", 0)) {
                iprintlnbold("<dev string:x161>");
                println("<dev string:x161>");
            }
            return;
        }
        if (!isdefined(cleanup_func)) {
            if (getdvarint(#"hash_7919e37cd5d57659", 0)) {
                iprintlnbold("<dev string:x1ab>");
                println("<dev string:x1ab>");
            }
            return;
        }
        if (isdefined(self._ee) && isdefined(self._ee[name]) && isdefined(var_d6ca4caf) && isdefined(self._ee[name].record_stat)) {
            if (getdvarint(#"hash_7919e37cd5d57659", 0)) {
                iprintlnbold("<dev string:x1f7>");
                println("<dev string:x1f7>");
            }
            return;
        }
    #/
    if (!isdefined(self._ee)) {
        self._ee = [];
    }
    if (!isdefined(self._ee[name])) {
        self._ee[name] = {#name:name, #completed:0, #steps:[], #current_step:0, #started:0, #owner:self, #skip_to_step:-1};
        /#
            if (getdvarint(#"zm_debug_ee", 0)) {
                thread function_28aee167(name);
            }
        #/
    }
    ee = self._ee[name];
    if (!isdefined(ee.record_stat)) {
        ee.record_stat = var_d6ca4caf;
    }
    if (!isdefined(ee.var_35ccab99)) {
        ee.var_35ccab99 = var_27465eb4;
    }
    new_step = {#name:step_name, #ee:ee, #var_e788cdd7:var_e788cdd7, #setup_func:setup_func, #cleanup_func:cleanup_func, #started:0, #completed:0, #cleaned_up:0, #var_6cc77d4e:var_6cc77d4e, #a_targets:a_targets, #var_441061cd:var_441061cd};
    previous_step = ee.steps[self._ee[name].steps.size - 1];
    if (isdefined(previous_step)) {
        previous_step.next_step = new_step;
    }
    if (!isdefined(ee.steps)) {
        ee.steps = [];
    } else if (!isarray(ee.steps)) {
        ee.steps = array(ee.steps);
    }
    ee.steps[ee.steps.size] = new_step;
    self flag::init(var_e788cdd7 + "_completed");
    if (!self flag::exists(ee.name + "_completed")) {
        self flag::init(ee.name + "_completed");
    }
    /#
        if (getdvarint(#"zm_debug_ee", 0)) {
            thread function_b3da1a16(ee.name, new_step.name);
            thread devgui_think();
        }
    #/
}

// Namespace zm_sq/zm_sq
// Params 2, eflags: 0x1 linked
// Checksum 0x39b71f99, Offset: 0x8e0
// Size: 0x244
function start(name, var_9d8cf7f = 0) {
    if (!zm_utility::is_ee_enabled() && !var_9d8cf7f) {
        return;
    }
    assert(ishash(name), "<dev string:x7e>");
    assert(isdefined(self._ee[name]), "<dev string:x253>" + function_9e72a96(name) + "<dev string:x25a>");
    if (self._ee[name].started) {
        /#
            if (getdvarint(#"hash_7919e37cd5d57659", 0)) {
                iprintlnbold("<dev string:x253>" + function_9e72a96(name) + "<dev string:x276>");
                println("<dev string:x253>" + function_9e72a96(name) + "<dev string:x276>");
            }
        #/
        return;
    }
    ee = self._ee[name];
    var_5ea5c94d = 0;
    /#
        if (ee.skip_to_step > -1) {
            assert(0 <= ee.skip_to_step, "<dev string:x293>");
            if (0 < ee.skip_to_step) {
                var_5ea5c94d = 1;
            } else if (0 == ee.skip_to_step) {
                ee.skip_to_step = -1;
            }
        }
    #/
    self thread run_step(ee, ee.steps[0], var_5ea5c94d);
}

// Namespace zm_sq/zm_sq
// Params 1, eflags: 0x0
// Checksum 0xfa466731, Offset: 0xb30
// Size: 0x9e
function is_complete(name) {
    assert(ishash(name), "<dev string:x7e>");
    assert(isdefined(self._ee[name]), "<dev string:x253>" + function_9e72a96(name) + "<dev string:x25a>");
    return self._ee[name].completed;
}

// Namespace zm_sq/zm_sq
// Params 2, eflags: 0x0
// Checksum 0x31630b34, Offset: 0xbd8
// Size: 0x142
function function_9212ff4d(ee_name, step_name) {
    assert(ishash(ee_name), "<dev string:x7e>");
    assert(ishash(step_name), "<dev string:x98>");
    assert(isdefined(self._ee[ee_name]), "<dev string:x253>" + ee_name + "<dev string:x2b8>");
    foreach (ee_index, ee_step in self._ee[ee_name].steps) {
        if (step_name == ee_step.name) {
            return ee_index;
        }
    }
    return -1;
}

// Namespace zm_sq/zm_sq
// Params 3, eflags: 0x5 linked
// Checksum 0xfff9253, Offset: 0xd28
// Size: 0x8ec
function private run_step(ee, step, var_5ea5c94d) {
    var_4ef8d79b = isentity(self);
    if (var_4ef8d79b) {
        self endon(#"death");
        self endon(#"disconnect");
    }
    self endon(#"game_ended");
    /#
        if (getdvarint(#"hash_7919e37cd5d57659", 0)) {
            iprintlnbold(function_9e72a96(ee.name) + "<dev string:x2d8>" + function_9e72a96(step.name) + "<dev string:x2dd>");
            println(function_9e72a96(ee.name) + "<dev string:x2d8>" + function_9e72a96(step.name) + "<dev string:x2dd>");
        }
    #/
    ee.started = 1;
    step.started = 1;
    self thread function_3f795dc3(ee, step, var_5ea5c94d);
    if (!step.completed) {
        waitresult = self waittill(step.var_e788cdd7 + "_setup_completed", step.var_e788cdd7 + "_ended_early");
    }
    /#
        if (getdvarint(#"hash_7919e37cd5d57659", 0)) {
            iprintlnbold(function_9e72a96(ee.name) + "<dev string:x2d8>" + function_9e72a96(step.name) + "<dev string:x2f0>");
            println(function_9e72a96(ee.name) + "<dev string:x2d8>" + function_9e72a96(step.name) + "<dev string:x2f0>");
        }
    #/
    if (game.state === "postgame") {
        return;
    }
    ended_early = isdefined(waitresult) && waitresult._notify == step.var_e788cdd7 + "_ended_early";
    [[ step.cleanup_func ]](var_5ea5c94d, ended_early);
    /#
        if (getdvarint(#"hash_7919e37cd5d57659", 0)) {
            iprintlnbold(function_9e72a96(ee.name) + "<dev string:x2d8>" + function_9e72a96(step.name) + "<dev string:x306>");
            println(function_9e72a96(ee.name) + "<dev string:x2d8>" + function_9e72a96(step.name) + "<dev string:x306>");
        }
    #/
    step.cleaned_up = 1;
    if (game.state === "postgame") {
        return;
    }
    self flag::set(step.var_e788cdd7 + "_completed");
    if (ee.current_step === 0 && is_true(ee.record_stat)) {
        if (var_4ef8d79b) {
            self.var_897fa11b = 1;
        } else {
            players = getplayers();
            foreach (player in players) {
                player.var_897fa11b = 1;
            }
        }
    }
    if (isdefined(step.next_step)) {
        var_5ea5c94d = 0;
        /#
            if (ee.skip_to_step > -1) {
                var_7f1ec3f3 = ee.current_step + 1;
                assert(var_7f1ec3f3 <= ee.skip_to_step, "<dev string:x293>");
                if (var_7f1ec3f3 < ee.skip_to_step) {
                    var_5ea5c94d = 1;
                } else if (var_7f1ec3f3 == ee.skip_to_step) {
                    ee.skip_to_step = -1;
                }
                wait 0.5;
            }
        #/
        ee.current_step++;
        self thread run_step(ee, step.next_step, var_5ea5c94d);
        return;
    }
    ee.completed = 1;
    self flag::set(ee.name + "_completed");
    if (sessionmodeisonlinegame() && is_true(ee.record_stat)) {
        players = [];
        if (var_4ef8d79b) {
            players[0] = self;
        } else {
            players = getplayers();
        }
        foreach (player in players) {
            if (is_true(player.var_897fa11b)) {
                player zm_stats::set_map_stat(#"main_quest_completed", 1);
                player zm_stats::function_a6efb963(#"main_quest_completed", 1);
                player zm_stats::function_9288c79b(#"main_quest_completed", 1);
                n_time_elapsed = gettime() - level.var_21e22beb;
                player zm_stats::function_366b6fb9("FASTEST_QUEST_COMPLETION_TIME", n_time_elapsed);
                scoreevents::processscoreevent(#"main_ee", player);
                if (isdefined(ee.var_35ccab99)) {
                    player thread [[ ee.var_35ccab99 ]]();
                }
            }
        }
        zm_stats::set_match_stat(#"main_quest_completed", 1);
        zm_stats::function_ea5b4947();
    }
    /#
        if (getdvarint(#"hash_7919e37cd5d57659", 0)) {
            iprintlnbold("<dev string:x253>" + function_9e72a96(ee.name) + "<dev string:x31e>");
            println("<dev string:x253>" + function_9e72a96(ee.name) + "<dev string:x31e>");
        }
    #/
}

// Namespace zm_sq/zm_sq
// Params 3, eflags: 0x5 linked
// Checksum 0x8d706341, Offset: 0x1620
// Size: 0x154
function private function_3f795dc3(*ee, step, var_5ea5c94d) {
    if (isentity(self)) {
        self endon(#"death");
        self endon(#"disconnect");
    }
    self endon(#"game_ended");
    step endoncallback(&function_df365859, #"end_early");
    self notify(step.var_e788cdd7 + "_started");
    if (isdefined(step.var_6cc77d4e)) {
        level objective_set(step.var_6cc77d4e, step.a_targets, undefined, step.var_441061cd);
    }
    [[ step.setup_func ]](var_5ea5c94d);
    step.completed = 1;
    if (isdefined(step.var_6cc77d4e)) {
        level objective_complete(step.var_6cc77d4e, step.a_targets);
    }
    self notify(step.var_e788cdd7 + "_setup_completed");
}

// Namespace zm_sq/zm_sq
// Params 1, eflags: 0x5 linked
// Checksum 0x4e60861b, Offset: 0x1780
// Size: 0x174
function private function_df365859(*notifyhash) {
    /#
        if (getdvarint(#"hash_7919e37cd5d57659", 0)) {
            iprintlnbold(function_9e72a96(self.ee.name) + "<dev string:x2d8>" + function_9e72a96(self.name) + "<dev string:x32f>");
            println(function_9e72a96(self.ee.name) + "<dev string:x2d8>" + function_9e72a96(self.name) + "<dev string:x32f>");
        }
    #/
    self.completed = 1;
    if (isdefined(self.var_6cc77d4e)) {
        level objective_complete(self.var_6cc77d4e, self.a_targets);
    }
    waittillframeend();
    self.ee.owner notify(self.var_e788cdd7 + "_ended_early");
    self.ee.owner notify(self.var_e788cdd7 + "_setup_completed");
}

// Namespace zm_sq/zm_sq
// Params 5, eflags: 0x1 linked
// Checksum 0x3ae91097, Offset: 0x1900
// Size: 0x598
function objective_set(var_6cc77d4e, var_54829af, var_8c7ec5ce = 1, var_441061cd, var_4cfa0710 = var_6cc77d4e) {
    var_7f05db6 = [];
    if (isplayer(self)) {
        a_players = array(self);
    } else {
        a_players = getplayers();
    }
    if (isdefined(var_54829af)) {
        if (!isdefined(var_54829af)) {
            var_54829af = [];
        } else if (!isarray(var_54829af)) {
            var_54829af = array(var_54829af);
        }
        foreach (var_ff48959 in var_54829af) {
            n_obj_id = gameobjects::get_next_obj_id();
            if (!isdefined(var_7f05db6)) {
                var_7f05db6 = [];
            } else if (!isarray(var_7f05db6)) {
                var_7f05db6 = array(var_7f05db6);
            }
            if (!isinarray(var_7f05db6, n_obj_id)) {
                var_7f05db6[var_7f05db6.size] = n_obj_id;
            }
            if (isentity(var_ff48959)) {
                var_ff48959.var_e453e8a5[var_4cfa0710] = n_obj_id;
                if (var_8c7ec5ce) {
                    var_ff48959 thread function_8a11442f(var_4cfa0710);
                }
            } else if (isstruct(var_ff48959)) {
                var_ff48959.var_e453e8a5[var_4cfa0710] = n_obj_id;
                var_ff48959 = var_ff48959.origin;
            }
            foreach (player in a_players) {
                player.var_e453e8a5[var_4cfa0710] = n_obj_id;
            }
            objective_add(n_obj_id, "active", var_ff48959, var_6cc77d4e);
            function_6da98133(n_obj_id);
        }
    } else {
        n_obj_id = gameobjects::get_next_obj_id();
        if (!isdefined(var_7f05db6)) {
            var_7f05db6 = [];
        } else if (!isarray(var_7f05db6)) {
            var_7f05db6 = array(var_7f05db6);
        }
        if (!isinarray(var_7f05db6, n_obj_id)) {
            var_7f05db6[var_7f05db6.size] = n_obj_id;
        }
        foreach (player in a_players) {
            player.var_e453e8a5[var_4cfa0710] = n_obj_id;
        }
        objective_add(n_obj_id, "active", (0, 0, 0), var_6cc77d4e);
        function_4339912c(n_obj_id);
        assert(isdefined(var_441061cd), "<dev string:x33f>" + function_9e72a96(var_6cc77d4e) + "<dev string:x359>");
    }
    if (isdefined(var_441061cd)) {
        foreach (player in a_players) {
            foreach (n_obj_id in var_7f05db6) {
                player.var_4fcae9dc[n_obj_id] = var_441061cd;
                level.var_31028c5d prototype_hud::set_active_objective_string(player, var_441061cd);
                level.var_31028c5d prototype_hud::function_817e4d10(player, 2);
            }
        }
    }
    return var_7f05db6;
}

// Namespace zm_sq/zm_sq
// Params 2, eflags: 0x1 linked
// Checksum 0xb194597e, Offset: 0x1ea0
// Size: 0x7e4
function objective_complete(var_7f440703, a_targets) {
    var_6261674 = [];
    if (isplayer(self)) {
        a_players = array(self);
    } else {
        a_players = getplayers();
    }
    if (isdefined(a_targets)) {
        if (!isdefined(a_targets)) {
            a_targets = [];
        } else if (!isarray(a_targets)) {
            a_targets = array(a_targets);
        }
        foreach (target in a_targets) {
            if (!isentity(target) && !isstruct(target)) {
                if (isvec(target)) {
                    n_obj_id = function_e883632(a_players, var_7f440703);
                    if (isdefined(n_obj_id)) {
                        if (!isdefined(var_6261674)) {
                            var_6261674 = [];
                        } else if (!isarray(var_6261674)) {
                            var_6261674 = array(var_6261674);
                        }
                        if (!isinarray(var_6261674, n_obj_id)) {
                            var_6261674[var_6261674.size] = n_obj_id;
                        }
                    }
                }
                continue;
            }
            n_obj_id = target.var_e453e8a5[var_7f440703];
            if (!isdefined(n_obj_id)) {
                println("<dev string:x3a4>" + function_9e72a96(var_7f440703) + "<dev string:x3cc>");
                continue;
            }
            if (!isdefined(var_6261674)) {
                var_6261674 = [];
            } else if (!isarray(var_6261674)) {
                var_6261674 = array(var_6261674);
            }
            if (!isinarray(var_6261674, n_obj_id)) {
                var_6261674[var_6261674.size] = n_obj_id;
            }
            foreach (player in a_players) {
                objective_setinvisibletoplayer(n_obj_id, player);
                if (isarray(player.var_e453e8a5)) {
                    player.var_e453e8a5[var_7f440703] = undefined;
                }
            }
            var_e3ee5414 = 0;
            foreach (player in getplayers()) {
                if (isdefined(player.var_e453e8a5[var_7f440703])) {
                    var_e3ee5414 = 1;
                    break;
                }
            }
            if (!var_e3ee5414) {
                objective_setstate(n_obj_id, "done");
                gameobjects::release_obj_id(n_obj_id);
                target.var_e453e8a5[var_7f440703] = undefined;
                target notify("complete_objective_" + var_7f440703);
            }
        }
    } else {
        foreach (player in a_players) {
            n_obj_id = player.var_e453e8a5[var_7f440703];
            if (!isdefined(n_obj_id)) {
                println("<dev string:x402>" + player getentitynumber() + "<dev string:x423>" + function_9e72a96(var_7f440703) + "<dev string:x3cc>");
                continue;
            }
            if (!isdefined(var_6261674)) {
                var_6261674 = [];
            } else if (!isarray(var_6261674)) {
                var_6261674 = array(var_6261674);
            }
            if (!isinarray(var_6261674, n_obj_id)) {
                var_6261674[var_6261674.size] = n_obj_id;
            }
            player.var_e453e8a5[var_7f440703] = undefined;
            objective_setinvisibletoplayer(n_obj_id, player);
        }
        var_e3ee5414 = 0;
        foreach (player in getplayers()) {
            if (isdefined(player.var_e453e8a5[var_7f440703])) {
                var_e3ee5414 = 1;
                break;
            }
        }
        if (isdefined(n_obj_id) && !var_e3ee5414) {
            objective_setstate(n_obj_id, "done");
            gameobjects::release_obj_id(n_obj_id);
        }
    }
    foreach (player in a_players) {
        foreach (n_obj_id in var_6261674) {
            if (isarray(player.var_4fcae9dc)) {
                arrayremoveindex(player.var_4fcae9dc, n_obj_id, 1);
                if (!player.var_4fcae9dc.size) {
                    level.var_31028c5d prototype_hud::function_817e4d10(player, 0);
                }
            }
        }
    }
}

// Namespace zm_sq/zm_sq
// Params 1, eflags: 0x5 linked
// Checksum 0x829d825a, Offset: 0x2690
// Size: 0x64
function private function_8a11442f(str_objective) {
    self endon(#"deleted", "complete_objective_" + str_objective);
    self waittill(#"death", #"hash_26d74c393e63d809");
    thread objective_complete(str_objective, self);
}

// Namespace zm_sq/zm_sq
// Params 2, eflags: 0x5 linked
// Checksum 0xc161985b, Offset: 0x2700
// Size: 0x1d0
function private function_e883632(a_players, var_7f440703) {
    foreach (player in a_players) {
        n_obj_id = player.var_e453e8a5[var_7f440703];
        if (isdefined(n_obj_id)) {
            objective_setinvisibletoplayer(n_obj_id, player);
            if (isarray(player.var_e453e8a5)) {
                player.var_e453e8a5[var_7f440703] = undefined;
            }
        }
    }
    var_e3ee5414 = 0;
    foreach (player in getplayers()) {
        if (isdefined(player.var_e453e8a5[var_7f440703])) {
            var_e3ee5414 = 1;
            break;
        }
    }
    if (!var_e3ee5414 && isdefined(n_obj_id)) {
        objective_setstate(n_obj_id, "done");
        gameobjects::release_obj_id(n_obj_id);
    }
    return n_obj_id;
}

// Namespace zm_sq/zm_sq
// Params 2, eflags: 0x1 linked
// Checksum 0x799f576f, Offset: 0x28d8
// Size: 0x174
function function_aee0b4b4(var_7f440703, a_targets) {
    if (isplayer(self)) {
        a_players = array(self);
    } else {
        a_players = getplayers();
    }
    var_8861fa85 = function_407dcc8d(var_7f440703, a_targets);
    foreach (n_obj_id in var_8861fa85) {
        foreach (player in a_players) {
            objective_setvisibletoplayer(n_obj_id, player);
        }
    }
}

// Namespace zm_sq/zm_sq
// Params 2, eflags: 0x1 linked
// Checksum 0x5d24f850, Offset: 0x2a58
// Size: 0x174
function function_3029d343(var_7f440703, a_targets) {
    if (isplayer(self)) {
        a_players = array(self);
    } else {
        a_players = getplayers();
    }
    var_8861fa85 = function_407dcc8d(var_7f440703, a_targets);
    foreach (n_obj_id in var_8861fa85) {
        foreach (player in a_players) {
            objective_setinvisibletoplayer(n_obj_id, player);
        }
    }
}

// Namespace zm_sq/zm_sq
// Params 2, eflags: 0x1 linked
// Checksum 0xfaf94790, Offset: 0x2bd8
// Size: 0x290
function function_407dcc8d(var_7f440703, a_targets) {
    a_n_objective_ids = [];
    if (isdefined(a_targets)) {
        if (!isdefined(a_targets)) {
            a_targets = [];
        } else if (!isarray(a_targets)) {
            a_targets = array(a_targets);
        }
        foreach (target in a_targets) {
            if (isdefined(target.var_e453e8a5[var_7f440703])) {
                if (!isdefined(a_n_objective_ids)) {
                    a_n_objective_ids = [];
                } else if (!isarray(a_n_objective_ids)) {
                    a_n_objective_ids = array(a_n_objective_ids);
                }
                if (!isinarray(a_n_objective_ids, target.var_e453e8a5[var_7f440703])) {
                    a_n_objective_ids[a_n_objective_ids.size] = target.var_e453e8a5[var_7f440703];
                }
            }
        }
    } else {
        foreach (player in getplayers()) {
            if (isdefined(player.var_e453e8a5[var_7f440703])) {
                if (!isdefined(a_n_objective_ids)) {
                    a_n_objective_ids = [];
                } else if (!isarray(a_n_objective_ids)) {
                    a_n_objective_ids = array(a_n_objective_ids);
                }
                if (!isinarray(a_n_objective_ids, player.var_e453e8a5[var_7f440703])) {
                    a_n_objective_ids[a_n_objective_ids.size] = player.var_e453e8a5[var_7f440703];
                }
            }
        }
    }
    return a_n_objective_ids;
}

/#

    // Namespace zm_sq/zm_sq
    // Params 2, eflags: 0x0
    // Checksum 0xeb30ed2f, Offset: 0x2e70
    // Size: 0x1d6
    function function_f09763fd(ee_name, step_name) {
        assert(ishash(ee_name), "<dev string:x7e>");
        assert(isdefined(self._ee[ee_name]), "<dev string:x253>" + ee_name + "<dev string:x2b8>");
        var_da601d7f = function_44e256d8(ee_name);
        index = function_9212ff4d(ee_name, step_name);
        if (index == -1) {
            if (getdvarint(#"hash_7919e37cd5d57659", 0)) {
                iprintlnbold("<dev string:x253>" + function_9e72a96(ee_name) + "<dev string:x433>" + function_9e72a96(step_name));
                println("<dev string:x253>" + function_9e72a96(ee_name) + "<dev string:x433>" + function_9e72a96(step_name));
            }
            return;
        }
        return var_da601d7f + "<dev string:x44e>" + function_9e72a96(step_name) + "<dev string:x458>" + index + "<dev string:x45d>";
    }

    // Namespace zm_sq/zm_sq
    // Params 1, eflags: 0x0
    // Checksum 0x8b439cd9, Offset: 0x3050
    // Size: 0xd6
    function function_44e256d8(ee_name) {
        assert(ishash(ee_name), "<dev string:x7e>");
        owner = "<dev string:x462>";
        if (isentity(self)) {
            entitynum = self getentitynumber();
            owner = "<dev string:x46c>" + entitynum + "<dev string:x45d>";
        }
        return "<dev string:x478>" + owner + function_9e72a96(ee_name) + "<dev string:x45d>";
    }

    // Namespace zm_sq/zm_sq
    // Params 1, eflags: 0x0
    // Checksum 0x6b580551, Offset: 0x3130
    // Size: 0x114
    function function_28aee167(ee_name) {
        assert(ishash(ee_name), "<dev string:x7e>");
        ee_path = function_44e256d8(ee_name);
        owner = "<dev string:x482>";
        if (isentity(self)) {
            owner = self getentitynumber();
        }
        util::waittill_can_add_debug_command();
        adddebugcommand("<dev string:x48b>" + ee_path + "<dev string:x49b>" + owner + "<dev string:x2d8>" + function_9e72a96(ee_name) + "<dev string:x4bf>");
    }

    // Namespace zm_sq/zm_sq
    // Params 2, eflags: 0x0
    // Checksum 0xa2e1d81f, Offset: 0x3250
    // Size: 0x1e4
    function function_b3da1a16(ee_name, step_name) {
        assert(ishash(ee_name), "<dev string:x7e>");
        assert(ishash(step_name), "<dev string:x98>");
        step_path = function_f09763fd(ee_name, step_name);
        index = function_9212ff4d(ee_name, step_name);
        owner = "<dev string:x482>";
        if (isentity(self)) {
            owner = self getentitynumber();
        }
        util::waittill_can_add_debug_command();
        adddebugcommand("<dev string:x48b>" + step_path + "<dev string:x4c5>" + owner + "<dev string:x2d8>" + function_9e72a96(ee_name) + "<dev string:x2d8>" + index + "<dev string:x4bf>");
        adddebugcommand("<dev string:x48b>" + step_path + "<dev string:x4ed>" + owner + "<dev string:x2d8>" + function_9e72a96(ee_name) + "<dev string:x2d8>" + index + "<dev string:x4bf>");
    }

    // Namespace zm_sq/zm_sq
    // Params 0, eflags: 0x0
    // Checksum 0x37329249, Offset: 0x3440
    // Size: 0x8c
    function function_fa5a5bfd() {
        if (isdefined(self._ee)) {
            playernum = self getentitynumber();
            path = "<dev string:x517>" + playernum;
            util::waittill_can_add_debug_command();
            adddebugcommand("<dev string:x529>" + path + "<dev string:x4bf>");
        }
    }

    // Namespace zm_sq/zm_sq
    // Params 2, eflags: 0x0
    // Checksum 0x26c5828f, Offset: 0x34d8
    // Size: 0xca
    function function_87306f8a(ee_name, step_name) {
        ee = self._ee[ee_name];
        step_index = function_9212ff4d(ee_name, step_name);
        if (ee.started && step_index <= ee.current_step) {
            return 0;
        }
        ee.skip_to_step = step_index;
        if (ee.started) {
            function_614612f(ee_name);
        } else {
            level start(ee.name);
        }
        return 1;
    }

    // Namespace zm_sq/zm_sq
    // Params 1, eflags: 0x0
    // Checksum 0x3ee0caf7, Offset: 0x35b0
    // Size: 0x14c
    function function_614612f(ee_name) {
        ee = self._ee[ee_name];
        if (ee.started) {
            ee.steps[ee.current_step] notify(#"end_early");
            return;
        }
        if (getdvarint(#"hash_7919e37cd5d57659", 0)) {
            iprintlnbold("<dev string:x53c>" + function_9e72a96(ee_name) + "<dev string:x2d8>" + function_9e72a96(ee.steps[ee.current_step].name) + "<dev string:x553>");
            println("<dev string:x53c>" + function_9e72a96(ee_name) + "<dev string:x2d8>" + function_9e72a96(ee.steps[ee.current_step].name) + "<dev string:x553>");
        }
    }

    // Namespace zm_sq/zm_sq
    // Params 2, eflags: 0x0
    // Checksum 0xe8666867, Offset: 0x3708
    // Size: 0x324
    function function_f2dd8601(ee_name, var_f2c264bb) {
        if (isentity(self)) {
            self endon(#"death");
            self endon(#"disconnect");
        }
        self endon(#"game_ended");
        ee = self._ee[ee_name];
        step = ee.steps[var_f2c264bb];
        if (function_87306f8a(ee_name, step.name)) {
            if (!step.started) {
                wait_time = 10 * ee.steps.size;
                waitresult = self waittilltimeout(wait_time, step.var_e788cdd7 + "<dev string:x571>");
                if (waitresult._notify == #"timeout") {
                    if (getdvarint(#"hash_7919e37cd5d57659", 0)) {
                        iprintlnbold("<dev string:x57d>" + function_9e72a96(ee_name) + "<dev string:x2d8>" + function_9e72a96(ee.steps[ee.current_step].name));
                        println("<dev string:x57d>" + function_9e72a96(ee_name) + "<dev string:x2d8>" + function_9e72a96(ee.steps[ee.current_step].name));
                    }
                    return;
                }
            }
            wait 1;
        }
        if (getdvarint(#"hash_7919e37cd5d57659", 0)) {
            iprintlnbold("<dev string:x5a8>" + function_9e72a96(ee.name) + "<dev string:x2d8>" + function_9e72a96(ee.steps[ee.current_step].name) + "<dev string:x5b7>");
            println("<dev string:x5a8>" + function_9e72a96(ee.name) + "<dev string:x2d8>" + function_9e72a96(ee.steps[ee.current_step].name) + "<dev string:x5b7>");
        }
        function_614612f(ee_name);
    }

    // Namespace zm_sq/zm_sq
    // Params 0, eflags: 0x0
    // Checksum 0x2bdbb604, Offset: 0x3a38
    // Size: 0x8de
    function devgui_think() {
        self notify(#"hash_6d8b1a4c632ecc9");
        self endon(#"hash_6d8b1a4c632ecc9");
        while (true) {
            wait 1;
            cmd = getdvarstring(#"hash_319d902ea18eb39");
            setdvar(#"hash_319d902ea18eb39", "<dev string:x5be>");
            cmd = strtok(cmd, "<dev string:x2d8>");
            if (cmd.size == 0) {
                continue;
            }
            var_48909105 = cmd[1];
            target = undefined;
            if (var_48909105 == "<dev string:x482>") {
                target = level;
            } else {
                foreach (player in getplayers()) {
                    if (player getentitynumber() == var_48909105) {
                        target = player;
                        break;
                    }
                }
            }
            assert(isdefined(target));
            switch (cmd[0]) {
            case #"skip_to":
                ee = target._ee[cmd[2]];
                if (!isdefined(ee)) {
                    continue;
                }
                var_f2c264bb = int(cmd[3]);
                step_name = ee.steps[var_f2c264bb].name;
                if (var_f2c264bb < ee.current_step) {
                    if (getdvarint(#"hash_7919e37cd5d57659", 0)) {
                        iprintlnbold("<dev string:x5c2>" + function_9e72a96(ee.name) + "<dev string:x2d8>" + function_9e72a96(ee.steps[ee.current_step].name) + "<dev string:x5f3>" + var_48909105);
                        println("<dev string:x5c2>" + function_9e72a96(ee.name) + "<dev string:x2d8>" + function_9e72a96(ee.steps[ee.current_step].name) + "<dev string:x5f3>" + var_48909105);
                    }
                } else if (var_f2c264bb == ee.current_step) {
                    if (getdvarint(#"hash_7919e37cd5d57659", 0)) {
                        iprintlnbold("<dev string:x5fc>" + function_9e72a96(ee.name) + "<dev string:x2d8>" + function_9e72a96(step_name) + "<dev string:x5f3>" + var_48909105);
                        println("<dev string:x5fc>" + function_9e72a96(ee.name) + "<dev string:x2d8>" + function_9e72a96(step_name) + "<dev string:x5f3>" + var_48909105);
                    }
                } else {
                    if (getdvarint(#"hash_7919e37cd5d57659", 0)) {
                        iprintlnbold("<dev string:x610>" + function_9e72a96(ee.name) + "<dev string:x2d8>" + function_9e72a96(step_name) + "<dev string:x5f3>" + var_48909105 + "<dev string:x5b7>");
                        println("<dev string:x610>" + function_9e72a96(ee.name) + "<dev string:x2d8>" + function_9e72a96(step_name) + "<dev string:x5f3>" + var_48909105 + "<dev string:x5b7>");
                    }
                    target function_87306f8a(ee.name, step_name);
                }
                break;
            case #"complete":
                ee = target._ee[cmd[2]];
                if (!isdefined(ee)) {
                    continue;
                }
                var_f2c264bb = int(cmd[3]);
                if (var_f2c264bb < ee.current_step) {
                    if (getdvarint(#"hash_7919e37cd5d57659", 0)) {
                        iprintlnbold("<dev string:x620>" + function_9e72a96(ee.name) + "<dev string:x2d8>" + function_9e72a96(ee.steps[ee.current_step].name) + "<dev string:x5f3>" + var_48909105);
                        println("<dev string:x620>" + function_9e72a96(ee.name) + "<dev string:x2d8>" + function_9e72a96(ee.steps[ee.current_step].name) + "<dev string:x5f3>" + var_48909105);
                    }
                } else {
                    target thread function_f2dd8601(ee.name, var_f2c264bb);
                }
                break;
            case #"start":
                if (isdefined(target._ee[cmd[2]])) {
                    target start(hash(cmd[2]));
                }
                break;
            case #"show_status":
                if (is_true(level.var_7f2ca392)) {
                    function_c1d3567c();
                } else {
                    function_5df75220();
                    level thread function_9bee49bf();
                }
                break;
            case #"outro":
                if (cmd.size < 2 || !isdefined(target._ee[cmd[2]])) {
                    break;
                }
                ee = target._ee[cmd[2]];
                if (isdefined(ee)) {
                    target waittill(#"start_zombie_round_logic");
                    step_name = ee.steps[ee.steps.size - 1].name;
                    target function_87306f8a(ee.name, step_name);
                }
                break;
            }
        }
    }

    // Namespace zm_sq/zm_sq
    // Params 2, eflags: 0x4
    // Checksum 0xea674e13, Offset: 0x4320
    // Size: 0xa4
    function private create_hudelem(y, x) {
        if (!isdefined(x)) {
            x = 0;
        }
        var_aa917a22 = newdebughudelem();
        var_aa917a22.alignx = "<dev string:x652>";
        var_aa917a22.horzalign = "<dev string:x652>";
        var_aa917a22.aligny = "<dev string:x65a>";
        var_aa917a22.vertalign = "<dev string:x664>";
        var_aa917a22.y = y;
        var_aa917a22.x = x;
        return var_aa917a22;
    }

    // Namespace zm_sq/zm_sq
    // Params 0, eflags: 0x0
    // Checksum 0x21948be4, Offset: 0x43d0
    // Size: 0x248
    function function_5df75220() {
        current_y = 30;
        foreach (ee in level._ee) {
            current_x = 30;
            if (!isdefined(ee.debug_hudelem)) {
                ee.debug_hudelem = create_hudelem(current_y, current_x);
            }
            ee.debug_hudelem settext(function_9e72a96(ee.name));
            ee.debug_hudelem.fontscale = 1.5;
            current_x += 5;
            step_string = "<dev string:x66b>";
            foreach (step in ee.steps) {
                current_y += 15;
                if (!isdefined(step.debug_hudelem)) {
                    step.debug_hudelem = create_hudelem(current_y, current_x);
                }
                step.debug_hudelem settext(step_string + function_9e72a96(step.name));
                step.debug_hudelem.fontscale = 1.5;
            }
            current_y += 30;
        }
        level.var_7f2ca392 = 1;
    }

    // Namespace zm_sq/zm_sq
    // Params 0, eflags: 0x0
    // Checksum 0x64b9db33, Offset: 0x4620
    // Size: 0x172
    function function_c1d3567c() {
        level notify(#"hash_21c0567b0010f696");
        foreach (ee in level._ee) {
            if (isdefined(ee.debug_hudelem)) {
                ee.debug_hudelem destroy();
            }
            ee.debug_hudelem = undefined;
            foreach (step in ee.steps) {
                if (isdefined(step.debug_hudelem)) {
                    step.debug_hudelem destroy();
                }
                step.debug_hudelem = undefined;
            }
        }
        level.var_7f2ca392 = undefined;
    }

    // Namespace zm_sq/zm_sq
    // Params 0, eflags: 0x0
    // Checksum 0x393c8903, Offset: 0x47a0
    // Size: 0x156
    function function_9bee49bf() {
        level endon(#"hash_21c0567b0010f696");
        while (true) {
            waitframe(1);
            foreach (ee in level._ee) {
                ee.debug_hudelem.color = function_1091b2a0(ee);
                foreach (step in ee.steps) {
                    step.debug_hudelem.color = function_1091b2a0(step);
                }
            }
        }
    }

    // Namespace zm_sq/zm_sq
    // Params 1, eflags: 0x0
    // Checksum 0x95a9a29d, Offset: 0x4900
    // Size: 0x64
    function function_1091b2a0(var_4f1c1316) {
        if (!var_4f1c1316.started) {
            color = (0.75, 0.75, 0.75);
        } else if (!var_4f1c1316.completed) {
            color = (1, 0, 0);
        } else {
            color = (0, 1, 0);
        }
        return color;
    }

#/
