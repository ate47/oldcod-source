#using script_1cc417743d7c262d;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\player\player_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\zm_common\zm_utility;

#namespace namespace_d0ab5955;

// Namespace namespace_d0ab5955/namespace_d0ab5955
// Params 0, eflags: 0x6
// Checksum 0x24b89de7, Offset: 0x218
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"hash_d07e35f920d16a8", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace namespace_d0ab5955/namespace_d0ab5955
// Params 0, eflags: 0x1 linked
// Checksum 0x53dcec0e, Offset: 0x260
// Size: 0x1c2
function function_70a657d8() {
    if (!zm_utility::is_survival()) {
        return;
    }
    clientfield::register("scriptmover", "fogofwarflag", 1, 1, "int");
    clientfield::register("toplayer", "fogofwareffects", 1, 2, "int");
    clientfield::register("toplayer", "fogofwartimer", 1, 1, "int");
    clientfield::register("allplayers", "outsidetile", 1, 1, "int");
    clientfield::register("world", "tile_id", 1, 6, "int");
    if (!is_true(getgametypesetting(#"hash_59854c1f30538261"))) {
        return;
    }
    level.var_ac22a760 = struct::get_array(#"hash_3460aae6bb799a99", "content_key");
    for (index = 1; index <= level.var_ac22a760.size; index++) {
        level.var_ac22a760[index - 1].id = index;
    }
}

// Namespace namespace_d0ab5955/namespace_d0ab5955
// Params 0, eflags: 0x0
// Checksum 0x6604257, Offset: 0x430
// Size: 0x14c
function init() {
    if (!is_true(getgametypesetting(#"hash_59854c1f30538261"))) {
        return;
    }
    level.var_3814eac9 = getentarray("trigger_within_bounds", "classname");
    foreach (var_df0c0b31 in level.var_3814eac9) {
        var_df0c0b31.activated = 0;
    }
    level.var_f2211522 = getentarray("survival_fow", "script_noteworthy");
    callback::on_connect(&on_connect);
    callback::on_game_playing(&start);
}

// Namespace namespace_d0ab5955/namespace_d0ab5955
// Params 0, eflags: 0x5 linked
// Checksum 0x8a60061b, Offset: 0x588
// Size: 0x42
function private on_connect() {
    self val::set(#"hash_794019c675d0ae10", "disable_oob", 1);
    self.oob_start_time = -1;
}

// Namespace namespace_d0ab5955/namespace_d0ab5955
// Params 0, eflags: 0x1 linked
// Checksum 0x920a48b1, Offset: 0x5d8
// Size: 0x34
function start() {
    level thread function_dc15ad60();
    level thread function_e568ca74();
}

// Namespace namespace_d0ab5955/namespace_d0ab5955
// Params 0, eflags: 0x1 linked
// Checksum 0x6a008fc0, Offset: 0x618
// Size: 0x8c
function function_e568ca74() {
    level endon(#"hash_1c6770a6f6ea06b6");
    level flag::wait_till_clear(#"hash_4930756571725d11");
    var_123dc898 = getent("fow_border_all", "targetname");
    if (isdefined(var_123dc898)) {
        var_123dc898 clientfield::set("fogofwarflag", 1);
    }
}

// Namespace namespace_d0ab5955/namespace_d0ab5955
// Params 2, eflags: 0x0
// Checksum 0x2ce75a0e, Offset: 0x6b0
// Size: 0x86
function function_1c5219e4(var_6874207, var_d001b56c) {
    var_df0c0b31 = getent(var_6874207, "targetname");
    var_9bdd487c = getent(var_d001b56c, "targetname");
    if (isdefined(var_df0c0b31) && isdefined(var_9bdd487c)) {
        var_df0c0b31.var_9bdd487c = var_9bdd487c;
    }
}

// Namespace namespace_d0ab5955/namespace_d0ab5955
// Params 2, eflags: 0x1 linked
// Checksum 0xa2b5f06, Offset: 0x740
// Size: 0x1cc
function function_d4dec4e8(destination, var_d0c31a32 = 0) {
    level flag::wait_till_clear(#"hash_4930756571725d11");
    level.var_973f0101 = 1;
    if (isdefined(destination.var_fe2612fe[#"hash_3460aae6bb799a99"])) {
        var_6c486d1a = destination.var_fe2612fe[#"hash_3460aae6bb799a99"][0];
        if (isdefined(var_6c486d1a)) {
            var_6c486d1a.activated = 1;
            var_f6b2bc6f = getent(var_6c486d1a.targetname, "target");
            if (isdefined(var_f6b2bc6f)) {
                var_f6b2bc6f.activated = 1;
            }
            level clientfield::set("tile_id", var_6c486d1a.id);
            if (!isdefined(var_6c486d1a.var_5d62d655)) {
                var_6c486d1a.var_5d62d655 = util::spawn_model(var_6c486d1a.model);
            } else {
                var_6c486d1a.var_5d62d655 show();
            }
            var_6c486d1a.var_5d62d655 clientfield::set("fogofwarflag", 1);
        }
    }
    if (var_d0c31a32) {
        level thread util::delay(4, "end_game", &globallogic_audio::leader_dialog, "fogOfWarMoving");
    }
}

// Namespace namespace_d0ab5955/namespace_d0ab5955
// Params 1, eflags: 0x1 linked
// Checksum 0xb7d8664a, Offset: 0x918
// Size: 0xcc
function function_f1ad7968(destination) {
    if (isdefined(destination.var_fe2612fe[#"hash_3460aae6bb799a99"])) {
        var_6c486d1a = destination.var_fe2612fe[#"hash_3460aae6bb799a99"][0];
        if (isdefined(var_6c486d1a)) {
            var_6c486d1a.activated = 0;
            var_f6b2bc6f = getent(var_6c486d1a.targetname, "target");
            if (isdefined(var_f6b2bc6f)) {
                var_f6b2bc6f.activated = 0;
            }
            if (isdefined(var_6c486d1a.var_5d62d655)) {
                var_6c486d1a.var_5d62d655 hide();
            }
        }
    }
}

// Namespace namespace_d0ab5955/namespace_d0ab5955
// Params 2, eflags: 0x0
// Checksum 0xfeed71a9, Offset: 0x9f0
// Size: 0x1dc
function function_ac8a88de(var_6874207, var_d0c31a32 = 0) {
    level.var_973f0101 = 1;
    var_df0c0b31 = getent(var_6874207, "targetname");
    if (isdefined(var_df0c0b31)) {
        var_df0c0b31.activated = 1;
        foreach (var_ea0ed69c in level.var_ac22a760) {
            if (var_ea0ed69c.target == var_df0c0b31.targetname) {
                level clientfield::set("tile_id", var_ea0ed69c.id);
            }
        }
        if (isdefined(var_df0c0b31.var_9bdd487c)) {
            var_62567791 = getent(var_df0c0b31.var_9bdd487c.target, "targetname");
            if (isdefined(var_62567791)) {
                var_62567791 clientfield::set("fogofwarflag", 1);
            }
        }
        if (var_d0c31a32) {
            level thread util::delay(4, "end_game", &globallogic_audio::leader_dialog, "fogOfWarMoving");
        }
        var_df0c0b31 thread function_fcf7c9c8();
    }
}

// Namespace namespace_d0ab5955/namespace_d0ab5955
// Params 0, eflags: 0x5 linked
// Checksum 0xdcc23700, Offset: 0xbd8
// Size: 0x6c
function private function_fcf7c9c8() {
    self endon(#"death");
    move_origin = self.origin + (0, 0, -20000);
    self moveto(move_origin, 3);
    wait 5;
    self delete();
}

// Namespace namespace_d0ab5955/namespace_d0ab5955
// Params 0, eflags: 0x1 linked
// Checksum 0xba073cea, Offset: 0xc50
// Size: 0xba
function function_3824d2dc() {
    foreach (var_df0c0b31 in level.var_3814eac9) {
        if (!is_true(var_df0c0b31.activated)) {
            continue;
        }
        if (var_df0c0b31 istouching(self.origin)) {
            return true;
        }
    }
    return false;
}

// Namespace namespace_d0ab5955/namespace_d0ab5955
// Params 0, eflags: 0x1 linked
// Checksum 0x3e7af1b6, Offset: 0xd18
// Size: 0x4ba
function function_dc15ad60() {
    level endoncallback(&cleanup_feedback, #"game_ended");
    while (true) {
        if (is_true(level.var_973f0101)) {
            break;
        }
        waitframe(1);
    }
    var_f4d9a132 = gettime() + int(1 * 1000);
    while (true) {
        dodamage = gettime() >= var_f4d9a132;
        time = gettime();
        foreach (player in getplayers()) {
            if (!isdefined(player.var_6a2e2f41)) {
                player.var_6a2e2f41 = gettime();
            }
            if (!isalive(player)) {
                player clientfield::set("outsidetile", 0);
                player hide_effects();
                continue;
            }
            var_d9242372 = int(1 * 1000);
            if (!player function_3824d2dc() && !is_true(player.b_ignore_fow_damage)) {
                if (!isdefined(player.var_35a2ac8a)) {
                    player.var_35a2ac8a = time + var_d9242372;
                }
                damage = 3;
                if (!isdefined(player.var_d650cd6e)) {
                    player.var_d650cd6e = 0;
                }
                if (time >= player.var_35a2ac8a) {
                    player.var_d650cd6e += 1;
                    player.var_35a2ac8a = time + var_d9242372;
                }
                player.var_9d778583 = damage + player.var_d650cd6e;
                if (player.var_9d778583 >= 20) {
                    intensity = 3;
                } else if (player.var_9d778583 >= 10) {
                    intensity = 2;
                } else {
                    intensity = 1;
                }
                intensity = 3;
                player clientfield::set("outsidetile", 1);
                player show_effects(intensity);
                cur_time = gettime();
                elapsed_time = cur_time - player.oob_start_time;
                if (elapsed_time > level.oob_timelimit_ms && player.oob_start_time != -1) {
                    player.laststand = undefined;
                    if (isdefined(player.revivetrigger)) {
                        player.revivetrigger delete();
                    }
                    player suicide();
                }
                if (dodamage) {
                    if (gettime() >= player.var_6a2e2f41) {
                        player thread globallogic_audio::play_taacom_dialog("fogOfWarTrappedPlayer");
                        player.var_6a2e2f41 = gettime() + int(240 * 1000);
                    }
                }
                continue;
            }
            player clientfield::set("outsidetile", 0);
            player hide_effects();
            player.var_d650cd6e = 0;
            player.var_35a2ac8a = time + var_d9242372;
        }
        if (dodamage) {
            var_f4d9a132 = gettime() + int(1 * 1000);
        }
        waitframe(1);
    }
}

// Namespace namespace_d0ab5955/namespace_d0ab5955
// Params 1, eflags: 0x5 linked
// Checksum 0x92c5459f, Offset: 0x11e0
// Size: 0x98
function private cleanup_feedback(*notifyhash) {
    foreach (player in getplayers()) {
        player hide_effects();
    }
}

// Namespace namespace_d0ab5955/namespace_d0ab5955
// Params 1, eflags: 0x1 linked
// Checksum 0xf70635, Offset: 0x1280
// Size: 0xa4
function show_effects(intensity) {
    if (self clientfield::get_to_player("fogofwareffects") == 0 && !self isinmovemode("ufo", "noclip")) {
        self.oob_start_time = gettime();
        self clientfield::set_to_player("fogofwartimer", 1);
    }
    self clientfield::set_to_player("fogofwareffects", intensity);
}

// Namespace namespace_d0ab5955/namespace_d0ab5955
// Params 0, eflags: 0x1 linked
// Checksum 0xf35a2650, Offset: 0x1330
// Size: 0x74
function hide_effects() {
    if (self clientfield::get_to_player("fogofwareffects") != 0) {
        self.oob_start_time = -1;
        self clientfield::set_to_player("fogofwartimer", 0);
    }
    self clientfield::set_to_player("fogofwareffects", 0);
}

