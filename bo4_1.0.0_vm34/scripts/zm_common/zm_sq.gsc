#using scripts\core_common\flag_shared;
#using scripts\zm_common\zm_stats;
#using scripts\zm_common\zm_utility;

#namespace zm_sq;

/#

    // Namespace zm_sq/zm_sq
    // Params 0, eflags: 0x6
    // Checksum 0x74b0f8f3, Offset: 0xc0
    // Size: 0x44
    function private autoexec init() {
        if (getdvarint(#"hash_7919e37cd5d57659", 0)) {
            adddebugcommand("<dev string:x30>");
        }
    }

#/

// Namespace zm_sq/zm_sq
// Params 7, eflags: 0x0
// Checksum 0x26409a00, Offset: 0x110
// Size: 0x674
function register(name, step_name, var_f666dbd9, setup_func, cleanup_func, var_c53b6b76, var_42a80075) {
    /#
        assert(ishash(name), "<dev string:x6d>");
        assert(ishash(step_name), "<dev string:x84>");
        assert(ishash(var_f666dbd9), "<dev string:x9d>");
        if (!isdefined(name)) {
            if (getdvarint(#"hash_7919e37cd5d57659", 0)) {
                iprintlnbold("<dev string:xba>");
                println("<dev string:xba>");
            }
            return;
        }
        if (!isdefined(step_name)) {
            if (getdvarint(#"hash_7919e37cd5d57659", 0)) {
                iprintlnbold("<dev string:xfb>");
                println("<dev string:xfb>");
            }
            return;
        }
        if (!isdefined(setup_func)) {
            if (getdvarint(#"hash_7919e37cd5d57659", 0)) {
                iprintlnbold("<dev string:x141>");
                println("<dev string:x141>");
            }
            return;
        }
        if (!isdefined(cleanup_func)) {
            if (getdvarint(#"hash_7919e37cd5d57659", 0)) {
                iprintlnbold("<dev string:x188>");
                println("<dev string:x188>");
            }
            return;
        }
        if (isdefined(level._ee) && isdefined(level._ee[name]) && isdefined(var_c53b6b76) && isdefined(level._ee[name].record_stat)) {
            if (getdvarint(#"hash_7919e37cd5d57659", 0)) {
                iprintlnbold("<dev string:x1d1>");
                println("<dev string:x1d1>");
            }
            return;
        }
    #/
    if (!isdefined(level._ee)) {
        level._ee = [];
    }
    if (!isdefined(level._ee[name])) {
        level._ee[name] = {#name:name, #completed:0, #steps:[], #current_step:0, #started:0, #skip_to_step:-1};
        /#
            if (getdvarint(#"zm_debug_ee", 0)) {
                function_953a8cb6(name);
            }
        #/
    }
    ee = level._ee[name];
    if (!isdefined(ee.record_stat)) {
        ee.record_stat = var_c53b6b76;
    }
    if (!isdefined(ee.var_eb9d2c97)) {
        ee.var_eb9d2c97 = var_42a80075;
    }
    new_step = {#name:step_name, #ee:ee, #var_f666dbd9:var_f666dbd9, #setup_func:setup_func, #cleanup_func:cleanup_func, #started:0, #completed:0, #cleaned_up:0};
    previous_step = ee.steps[level._ee[name].steps.size - 1];
    if (isdefined(previous_step)) {
        previous_step.next_step = new_step;
    }
    if (!isdefined(ee.steps)) {
        ee.steps = [];
    } else if (!isarray(ee.steps)) {
        ee.steps = array(ee.steps);
    }
    ee.steps[ee.steps.size] = new_step;
    level flag::init(var_f666dbd9 + "_completed");
    if (!level flag::exists(ee.name + "_completed")) {
        level flag::init(ee.name + "_completed");
    }
    /#
        if (getdvarint(#"zm_debug_ee", 0)) {
            function_f71a1762(ee.name, new_step.name);
            thread devgui_think();
        }
    #/
}

// Namespace zm_sq/zm_sq
// Params 2, eflags: 0x0
// Checksum 0x996b7a5a, Offset: 0x790
// Size: 0x28c
function start(name, var_ba0f5b18 = 0) {
    if (isdefined(level.var_690a4ac9) && level.var_690a4ac9 && !var_ba0f5b18) {
        return;
    }
    if (!getdvarint(#"zm_ee_enabled", 0) && !var_ba0f5b18) {
        return;
    }
    assert(ishash(name), "<dev string:x6d>");
    assert(isdefined(level._ee[name]), "<dev string:x22a>" + function_15979fa9(name) + "<dev string:x22e>");
    if (level._ee[name].started) {
        /#
            if (getdvarint(#"hash_7919e37cd5d57659", 0)) {
                iprintlnbold("<dev string:x22a>" + function_15979fa9(name) + "<dev string:x247>");
                println("<dev string:x22a>" + function_15979fa9(name) + "<dev string:x247>");
            }
        #/
        return;
    }
    ee = level._ee[name];
    var_758116d = 0;
    if (ee.skip_to_step > -1) {
        assert(0 <= ee.skip_to_step, "<dev string:x261>");
        if (0 < ee.skip_to_step) {
            var_758116d = 1;
        } else if (0 == ee.skip_to_step) {
            ee.skip_to_step = -1;
        }
    }
    level thread run_step(ee, ee.steps[0], var_758116d);
}

// Namespace zm_sq/zm_sq
// Params 1, eflags: 0x0
// Checksum 0xa4f4b84f, Offset: 0xa28
// Size: 0xa2
function is_complete(name) {
    assert(ishash(name), "<dev string:x6d>");
    assert(isdefined(level._ee[name]), "<dev string:x22a>" + function_15979fa9(name) + "<dev string:x22e>");
    return level._ee[name].completed;
}

// Namespace zm_sq/zm_sq
// Params 2, eflags: 0x0
// Checksum 0x6d85c54, Offset: 0xad8
// Size: 0x142
function function_aac2f689(ee_name, step_name) {
    assert(ishash(ee_name), "<dev string:x6d>");
    assert(ishash(step_name), "<dev string:x84>");
    assert(isdefined(level._ee[ee_name]), "<dev string:x22a>" + ee_name + "<dev string:x283>");
    foreach (ee_index, ee_step in level._ee[ee_name].steps) {
        if (step_name == ee_step.name) {
            return ee_index;
        }
    }
    return -1;
}

// Namespace zm_sq/zm_sq
// Params 3, eflags: 0x4
// Checksum 0xd8c795ce, Offset: 0xc28
// Size: 0x7cc
function private run_step(ee, step, var_758116d) {
    level endon(#"game_ended");
    /#
        if (getdvarint(#"hash_7919e37cd5d57659", 0)) {
            iprintlnbold(function_15979fa9(ee.name) + "<dev string:x2a0>" + function_15979fa9(step.name) + "<dev string:x2a2>");
            println(function_15979fa9(ee.name) + "<dev string:x2a0>" + function_15979fa9(step.name) + "<dev string:x2a2>");
        }
    #/
    ee.started = 1;
    step.started = 1;
    level thread function_f018ad07(ee, step, var_758116d);
    if (!step.completed) {
        waitresult = level waittill(step.var_f666dbd9 + "_setup_completed", step.var_f666dbd9 + "_ended_early");
    }
    /#
        if (getdvarint(#"hash_7919e37cd5d57659", 0)) {
            iprintlnbold(function_15979fa9(ee.name) + "<dev string:x2a0>" + function_15979fa9(step.name) + "<dev string:x2b2>");
            println(function_15979fa9(ee.name) + "<dev string:x2a0>" + function_15979fa9(step.name) + "<dev string:x2b2>");
        }
    #/
    if (game.state === "postgame") {
        return;
    }
    ended_early = isdefined(waitresult) && waitresult._notify == step.var_f666dbd9 + "_ended_early";
    [[ step.cleanup_func ]](var_758116d, ended_early);
    /#
        if (getdvarint(#"hash_7919e37cd5d57659", 0)) {
            iprintlnbold(function_15979fa9(ee.name) + "<dev string:x2a0>" + function_15979fa9(step.name) + "<dev string:x2c5>");
            println(function_15979fa9(ee.name) + "<dev string:x2a0>" + function_15979fa9(step.name) + "<dev string:x2c5>");
        }
    #/
    step.cleaned_up = 1;
    if (game.state === "postgame") {
        return;
    }
    level flag::set(step.var_f666dbd9 + "_completed");
    if (ee.current_step === 0 && isdefined(ee.record_stat) && ee.record_stat) {
        players = getplayers();
        foreach (player in players) {
            player.var_d126d527 = 1;
        }
    }
    if (isdefined(step.next_step)) {
        var_758116d = 0;
        if (ee.skip_to_step > -1) {
            var_d6d4ed2a = ee.current_step + 1;
            assert(var_d6d4ed2a <= ee.skip_to_step, "<dev string:x261>");
            if (var_d6d4ed2a < ee.skip_to_step) {
                var_758116d = 1;
            } else if (var_d6d4ed2a == ee.skip_to_step) {
                ee.skip_to_step = -1;
            }
            wait 0.5;
        }
        ee.current_step++;
        level thread run_step(ee, step.next_step, var_758116d);
        return;
    }
    ee.completed = 1;
    level flag::set(ee.name + "_completed");
    if (zm_utility::function_35f92ae2() && isdefined(ee.record_stat) && ee.record_stat) {
        players = getplayers();
        foreach (player in players) {
            if (isdefined(player.var_d126d527) && player.var_d126d527) {
                player zm_stats::set_map_stat(#"main_quest_completed", 1);
                if (isdefined(ee.var_eb9d2c97)) {
                    player thread [[ ee.var_eb9d2c97 ]]();
                }
            }
        }
        zm_stats::set_match_stat(#"main_quest_completed", 1);
    }
    /#
        if (getdvarint(#"hash_7919e37cd5d57659", 0)) {
            iprintlnbold("<dev string:x22a>" + function_15979fa9(ee.name) + "<dev string:x2da>");
            println("<dev string:x22a>" + function_15979fa9(ee.name) + "<dev string:x2da>");
        }
    #/
}

// Namespace zm_sq/zm_sq
// Params 3, eflags: 0x4
// Checksum 0x68b545e3, Offset: 0x1400
// Size: 0xb6
function private function_f018ad07(ee, step, var_758116d) {
    level endon(#"game_ended");
    step endoncallback(&function_1e1f6d83, #"end_early");
    level notify(step.var_f666dbd9 + "_started");
    [[ step.setup_func ]](var_758116d);
    step.completed = 1;
    level notify(step.var_f666dbd9 + "_setup_completed");
}

// Namespace zm_sq/zm_sq
// Params 1, eflags: 0x4
// Checksum 0x13eddb30, Offset: 0x14c0
// Size: 0x12a
function private function_1e1f6d83(notifyhash) {
    /#
        if (getdvarint(#"hash_7919e37cd5d57659", 0)) {
            iprintlnbold(function_15979fa9(self.ee.name) + "<dev string:x2a0>" + function_15979fa9(self.name) + "<dev string:x2e8>");
            println(function_15979fa9(self.ee.name) + "<dev string:x2a0>" + function_15979fa9(self.name) + "<dev string:x2e8>");
        }
    #/
    self.completed = 1;
    level notify(self.var_f666dbd9 + "_ended_early");
    level notify(self.var_f666dbd9 + "_setup_completed");
}

/#

    // Namespace zm_sq/zm_sq
    // Params 2, eflags: 0x0
    // Checksum 0xcb047c02, Offset: 0x15f8
    // Size: 0x1de
    function function_baa2756d(ee_name, step_name) {
        assert(ishash(ee_name), "<dev string:x6d>");
        assert(isdefined(level._ee[ee_name]), "<dev string:x22a>" + ee_name + "<dev string:x283>");
        var_98c8fc2e = function_766a2aad(ee_name);
        index = function_aac2f689(ee_name, step_name);
        if (index == -1) {
            if (getdvarint(#"hash_7919e37cd5d57659", 0)) {
                iprintlnbold("<dev string:x22a>" + function_15979fa9(ee_name) + "<dev string:x2f5>" + function_15979fa9(step_name));
                println("<dev string:x22a>" + function_15979fa9(ee_name) + "<dev string:x2f5>" + function_15979fa9(step_name));
            }
            return;
        }
        return var_98c8fc2e + "<dev string:x30d>" + function_15979fa9(step_name) + "<dev string:x314>" + index + "<dev string:x316>";
    }

    // Namespace zm_sq/zm_sq
    // Params 1, eflags: 0x0
    // Checksum 0xb160a9ef, Offset: 0x17e0
    // Size: 0x66
    function function_766a2aad(ee_name) {
        assert(ishash(ee_name), "<dev string:x6d>");
        return "<dev string:x318>" + function_15979fa9(ee_name) + "<dev string:x316>";
    }

    // Namespace zm_sq/zm_sq
    // Params 1, eflags: 0x0
    // Checksum 0x49a5795c, Offset: 0x1850
    // Size: 0xac
    function function_953a8cb6(ee_name) {
        assert(ishash(ee_name), "<dev string:x6d>");
        ee_path = function_766a2aad(ee_name);
        adddebugcommand("<dev string:x31f>" + ee_path + "<dev string:x32c>" + function_15979fa9(ee_name) + "<dev string:x34d>");
    }

    // Namespace zm_sq/zm_sq
    // Params 2, eflags: 0x0
    // Checksum 0x3c1cedc7, Offset: 0x1908
    // Size: 0x16c
    function function_f71a1762(ee_name, step_name) {
        assert(ishash(ee_name), "<dev string:x6d>");
        assert(ishash(step_name), "<dev string:x84>");
        step_path = function_baa2756d(ee_name, step_name);
        index = function_aac2f689(ee_name, step_name);
        adddebugcommand("<dev string:x31f>" + step_path + "<dev string:x350>" + function_15979fa9(ee_name) + "<dev string:x2a0>" + index + "<dev string:x34d>");
        adddebugcommand("<dev string:x31f>" + step_path + "<dev string:x375>" + function_15979fa9(ee_name) + "<dev string:x2a0>" + index + "<dev string:x34d>");
    }

    // Namespace zm_sq/zm_sq
    // Params 2, eflags: 0x0
    // Checksum 0xcd760595, Offset: 0x1a80
    // Size: 0xda
    function function_c039ebe1(ee_name, step_name) {
        ee = level._ee[ee_name];
        step_index = function_aac2f689(ee_name, step_name);
        if (ee.started && step_index <= ee.current_step) {
            return 0;
        }
        ee.skip_to_step = step_index;
        if (ee.started) {
            function_84462f9f(ee_name);
        } else {
            start(ee.name);
        }
        return 1;
    }

    // Namespace zm_sq/zm_sq
    // Params 1, eflags: 0x0
    // Checksum 0x19d45799, Offset: 0x1b68
    // Size: 0x16c
    function function_84462f9f(ee_name) {
        ee = level._ee[ee_name];
        if (ee.started) {
            ee.steps[ee.current_step] notify(#"end_early");
            return;
        }
        if (getdvarint(#"hash_7919e37cd5d57659", 0)) {
            iprintlnbold("<dev string:x39c>" + function_15979fa9(ee_name) + "<dev string:x2a0>" + function_15979fa9(ee.steps[ee.current_step].name) + "<dev string:x3b0>");
            println("<dev string:x39c>" + function_15979fa9(ee_name) + "<dev string:x2a0>" + function_15979fa9(ee.steps[ee.current_step].name) + "<dev string:x3b0>");
        }
    }

    // Namespace zm_sq/zm_sq
    // Params 2, eflags: 0x0
    // Checksum 0x7b4780fc, Offset: 0x1ce0
    // Size: 0x31c
    function function_52b39489(ee_name, var_2b549ab) {
        level endon(#"game_ended");
        ee = level._ee[ee_name];
        step = ee.steps[var_2b549ab];
        if (function_c039ebe1(ee_name, step.name)) {
            if (!step.started) {
                wait_time = 10 * ee.steps.size;
                waitresult = level waittilltimeout(wait_time, step.var_f666dbd9 + "<dev string:x3cb>");
                if (waitresult._notify == #"timeout") {
                    if (getdvarint(#"hash_7919e37cd5d57659", 0)) {
                        iprintlnbold("<dev string:x3d4>" + function_15979fa9(ee_name) + "<dev string:x2a0>" + function_15979fa9(ee.steps[ee.current_step].name));
                        println("<dev string:x3d4>" + function_15979fa9(ee_name) + "<dev string:x2a0>" + function_15979fa9(ee.steps[ee.current_step].name));
                    }
                    return;
                }
            }
            wait 1;
        }
        if (getdvarint(#"hash_7919e37cd5d57659", 0)) {
            iprintlnbold("<dev string:x3fc>" + function_15979fa9(ee.name) + "<dev string:x2a0>" + function_15979fa9(ee.steps[ee.current_step].name) + "<dev string:x408>");
            println("<dev string:x3fc>" + function_15979fa9(ee.name) + "<dev string:x2a0>" + function_15979fa9(ee.steps[ee.current_step].name) + "<dev string:x408>");
        }
        function_84462f9f(ee_name);
    }

    // Namespace zm_sq/zm_sq
    // Params 0, eflags: 0x0
    // Checksum 0x75a0ac87, Offset: 0x2008
    // Size: 0x796
    function devgui_think() {
        level notify(#"hash_6d8b1a4c632ecc9");
        level endon(#"hash_6d8b1a4c632ecc9");
        while (true) {
            wait 1;
            cmd = getdvarstring(#"hash_319d902ea18eb39");
            setdvar(#"hash_319d902ea18eb39", "<dev string:x40c>");
            cmd = strtok(cmd, "<dev string:x2a0>");
            if (cmd.size == 0) {
                continue;
            }
            switch (cmd[0]) {
            case #"skip_to":
                ee = level._ee[cmd[1]];
                var_2b549ab = int(cmd[2]);
                step_name = ee.steps[var_2b549ab].name;
                if (var_2b549ab < ee.current_step) {
                    if (getdvarint(#"hash_7919e37cd5d57659", 0)) {
                        iprintlnbold("<dev string:x40d>" + function_15979fa9(ee.name) + "<dev string:x2a0>" + function_15979fa9(ee.steps[ee.current_step].name));
                        println("<dev string:x40d>" + function_15979fa9(ee.name) + "<dev string:x2a0>" + function_15979fa9(ee.steps[ee.current_step].name));
                    }
                } else if (var_2b549ab == ee.current_step) {
                    if (getdvarint(#"hash_7919e37cd5d57659", 0)) {
                        iprintlnbold("<dev string:x43b>" + function_15979fa9(ee.name) + "<dev string:x2a0>" + function_15979fa9(step_name));
                        println("<dev string:x43b>" + function_15979fa9(ee.name) + "<dev string:x2a0>" + function_15979fa9(step_name));
                    }
                } else {
                    if (getdvarint(#"hash_7919e37cd5d57659", 0)) {
                        iprintlnbold("<dev string:x44c>" + function_15979fa9(ee.name) + "<dev string:x2a0>" + function_15979fa9(step_name) + "<dev string:x408>");
                        println("<dev string:x44c>" + function_15979fa9(ee.name) + "<dev string:x2a0>" + function_15979fa9(step_name) + "<dev string:x408>");
                    }
                    function_c039ebe1(ee.name, step_name);
                }
                break;
            case #"complete":
                ee = level._ee[cmd[1]];
                var_2b549ab = int(cmd[2]);
                if (var_2b549ab < ee.current_step) {
                    if (getdvarint(#"hash_7919e37cd5d57659", 0)) {
                        iprintlnbold("<dev string:x459>" + function_15979fa9(ee.name) + "<dev string:x2a0>" + function_15979fa9(ee.steps[ee.current_step].name));
                        println("<dev string:x459>" + function_15979fa9(ee.name) + "<dev string:x2a0>" + function_15979fa9(ee.steps[ee.current_step].name));
                    }
                } else {
                    level thread function_52b39489(ee.name, var_2b549ab);
                }
                break;
            case #"start":
                if (isdefined(level._ee[cmd[1]])) {
                    start(hash(cmd[1]));
                }
                break;
            case #"show_status":
                if (isdefined(level.var_84aa5129) && level.var_84aa5129) {
                    function_317d16bd();
                } else {
                    function_9a0cd464();
                    level thread function_2642d1a2();
                }
                break;
            case #"outro":
                if (cmd.size < 2 || !isdefined(level._ee[cmd[1]])) {
                    break;
                }
                ee = level._ee[cmd[1]];
                if (isdefined(ee)) {
                    level waittill(#"start_zombie_round_logic");
                    step_name = ee.steps[ee.steps.size - 1].name;
                    function_c039ebe1(ee.name, step_name);
                }
                break;
            }
        }
    }

    // Namespace zm_sq/zm_sq
    // Params 2, eflags: 0x4
    // Checksum 0x706f2dad, Offset: 0x27a8
    // Size: 0xbc
    function private create_hudelem(y, x) {
        if (!isdefined(x)) {
            x = 0;
        }
        var_587f26ea = newdebughudelem();
        var_587f26ea.alignx = "<dev string:x488>";
        var_587f26ea.horzalign = "<dev string:x488>";
        var_587f26ea.aligny = "<dev string:x48d>";
        var_587f26ea.vertalign = "<dev string:x494>";
        var_587f26ea.y = y;
        var_587f26ea.x = x;
        return var_587f26ea;
    }

    // Namespace zm_sq/zm_sq
    // Params 0, eflags: 0x0
    // Checksum 0x33cc4ebb, Offset: 0x2870
    // Size: 0x24a
    function function_9a0cd464() {
        current_y = 30;
        foreach (ee in level._ee) {
            current_x = 30;
            if (!isdefined(ee.debug_hudelem)) {
                ee.debug_hudelem = create_hudelem(current_y, current_x);
            }
            ee.debug_hudelem settext(function_15979fa9(ee.name));
            ee.debug_hudelem.fontscale = 1.5;
            current_x += 5;
            step_string = "<dev string:x498>";
            foreach (step in ee.steps) {
                current_y += 15;
                if (!isdefined(step.debug_hudelem)) {
                    step.debug_hudelem = create_hudelem(current_y, current_x);
                }
                step.debug_hudelem settext(step_string + function_15979fa9(step.name));
                step.debug_hudelem.fontscale = 1.5;
            }
            current_y += 30;
        }
        level.var_84aa5129 = 1;
    }

    // Namespace zm_sq/zm_sq
    // Params 0, eflags: 0x0
    // Checksum 0xf9fdf7e7, Offset: 0x2ac8
    // Size: 0x162
    function function_317d16bd() {
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
        level.var_84aa5129 = undefined;
    }

    // Namespace zm_sq/zm_sq
    // Params 0, eflags: 0x0
    // Checksum 0x3452b234, Offset: 0x2c38
    // Size: 0x142
    function function_2642d1a2() {
        level endon(#"hash_21c0567b0010f696");
        while (true) {
            waitframe(1);
            foreach (ee in level._ee) {
                ee.debug_hudelem.color = function_d4123e44(ee);
                foreach (step in ee.steps) {
                    step.debug_hudelem.color = function_d4123e44(step);
                }
            }
        }
    }

    // Namespace zm_sq/zm_sq
    // Params 1, eflags: 0x0
    // Checksum 0xa1e75eb, Offset: 0x2d88
    // Size: 0x64
    function function_d4123e44(var_8fcf2dde) {
        if (!var_8fcf2dde.started) {
            color = (0.75, 0.75, 0.75);
        } else if (!var_8fcf2dde.completed) {
            color = (1, 0, 0);
        } else {
            color = (0, 1, 0);
        }
        return color;
    }

#/
