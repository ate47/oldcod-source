#using scripts/core_common/array_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/flag_shared;
#using scripts/core_common/flagsys_shared;
#using scripts/core_common/lui_shared;
#using scripts/core_common/math_shared;
#using scripts/core_common/music_shared;
#using scripts/core_common/scene_shared;
#using scripts/core_common/spawner_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/values_shared;

#namespace util;

// Namespace util/util_shared
// Params 0, eflags: 0x2
// Checksum 0x89539bc4, Offset: 0xb90
// Size: 0x3c
function autoexec function_2dc19561() {
    system::register("util_shared", &__init__, &__main__, undefined);
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0x5e2d362c, Offset: 0xbd8
// Size: 0x14
function __init__() {
    register_clientfields();
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0x77ee02cc, Offset: 0xbf8
// Size: 0x3c
function __main__() {
    system::wait_till("all");
    set_team_mapping("allies", "axis");
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0x4f8c78c6, Offset: 0xc40
// Size: 0x34
function register_clientfields() {
    clientfield::register("world", "cf_team_mapping", 1, 1, "int");
}

// Namespace util/util_shared
// Params 5, eflags: 0x0
// Checksum 0x618af292, Offset: 0xc80
// Size: 0x2c
function empty(a, b, c, d, e) {
    
}

// Namespace util/util_shared
// Params 1, eflags: 0x0
// Checksum 0x8f79fa77, Offset: 0xcb8
// Size: 0xfe
function wait_network_frame(n_count) {
    if (!isdefined(n_count)) {
        n_count = 1;
    }
    if (numremoteclients()) {
        for (i = 0; i < n_count; i++) {
            snapshot_ids = getsnapshotindexarray();
            acked = undefined;
            for (n_tries = 0; !isdefined(acked) && n_tries < 5; n_tries++) {
                level waittill("snapacknowledged");
                acked = snapshotacknowledged(snapshot_ids);
            }
        }
        return;
    }
    wait 0.1 * n_count;
}

// Namespace util/util_shared
// Params 3, eflags: 0x0
// Checksum 0xbf12c041, Offset: 0xdc0
// Size: 0x2b0
function streamer_wait(n_stream_request_id, n_wait_frames, n_timeout) {
    if (!isdefined(n_wait_frames)) {
        n_wait_frames = 0;
    }
    if (!isdefined(n_timeout)) {
        n_timeout = 15;
    }
    level endon(#"hash_b28e9639");
    /#
        if (getdvarint("<dev string:x28>", 1) != 0) {
            n_timeout = 1;
        }
    #/
    if (n_wait_frames > 0) {
        wait_network_frame(n_wait_frames);
    }
    timeout = gettime() + n_timeout * 1000;
    if (self == level) {
        n_num_streamers_ready = 0;
        do {
            wait_network_frame();
            n_num_streamers_ready = 0;
            foreach (player in getplayers()) {
                if (isdefined(n_stream_request_id) ? player isstreamerready(n_stream_request_id) : player isstreamerready()) {
                    n_num_streamers_ready++;
                }
            }
            if (n_timeout > 0 && gettime() > timeout) {
                /#
                    if (n_timeout > 5) {
                        iprintln("<dev string:x33>");
                    }
                #/
                break;
            }
        } while (n_num_streamers_ready < max(1, getplayers().size));
        return;
    }
    self endon(#"disconnect");
    do {
        wait_network_frame();
        if (n_timeout > 0 && gettime() > timeout) {
            break;
        }
    } while (!(isdefined(n_stream_request_id) ? self isstreamerready(n_stream_request_id) : self isstreamerready()));
}

/#

    // Namespace util/util_shared
    // Params 3, eflags: 0x0
    // Checksum 0xde3f9130, Offset: 0x1078
    // Size: 0x84
    function draw_debug_line(start, end, timer) {
        for (i = 0; i < timer * 20; i++) {
            line(start, end, (1, 1, 0.5));
            waitframe(1);
        }
    }

    // Namespace util/util_shared
    // Params 6, eflags: 0x0
    // Checksum 0x389d150b, Offset: 0x1108
    // Size: 0xb4
    function debug_line(start, end, color, alpha, depthtest, duration) {
        if (!isdefined(color)) {
            color = (1, 1, 1);
        }
        if (!isdefined(alpha)) {
            alpha = 1;
        }
        if (!isdefined(depthtest)) {
            depthtest = 0;
        }
        if (!isdefined(duration)) {
            duration = 100;
        }
        line(start, end, color, alpha, depthtest, duration);
    }

    // Namespace util/util_shared
    // Params 8, eflags: 0x0
    // Checksum 0x6d69056e, Offset: 0x11c8
    // Size: 0xdc
    function debug_spherical_cone(origin, domeapex, angle, slices, color, alpha, depthtest, duration) {
        if (!isdefined(slices)) {
            slices = 10;
        }
        if (!isdefined(color)) {
            color = (1, 1, 1);
        }
        if (!isdefined(alpha)) {
            alpha = 1;
        }
        if (!isdefined(depthtest)) {
            depthtest = 0;
        }
        if (!isdefined(duration)) {
            duration = 100;
        }
        sphericalcone(origin, domeapex, angle, slices, color, alpha, depthtest, duration);
    }

    // Namespace util/util_shared
    // Params 5, eflags: 0x0
    // Checksum 0xc07e493, Offset: 0x12b0
    // Size: 0xcc
    function debug_sphere(origin, radius, color, alpha, time) {
        if (!isdefined(time)) {
            time = 1000;
        }
        if (!isdefined(color)) {
            color = (1, 1, 1);
        }
        sides = int(10 * (1 + int(radius) % 100));
        sphere(origin, radius, color, alpha, 1, sides, time);
    }

#/

// Namespace util/util_shared
// Params 1, eflags: 0x0
// Checksum 0x29fd57e3, Offset: 0x1388
// Size: 0x40
function track(spot_to_track) {
    if (isdefined(self.current_target)) {
        if (spot_to_track == self.current_target) {
            return;
        }
    }
    self.current_target = spot_to_track;
}

// Namespace util/util_shared
// Params 2, eflags: 0x0
// Checksum 0xb186a4db, Offset: 0x13d0
// Size: 0x68
function waittill_string(msg, ent) {
    if (msg != "death") {
        self endon(#"death");
    }
    ent endon(#"die");
    self waittill(msg);
    ent notify(#"returned", {#msg:msg});
}

// Namespace util/util_shared
// Params 3, eflags: 0x0
// Checksum 0x394966dd, Offset: 0x1440
// Size: 0x64
function waittill_level_string(msg, ent, otherent) {
    otherent endon(#"death");
    ent endon(#"die");
    level waittill(msg);
    ent notify(#"returned", {#msg:msg});
}

// Namespace util/util_shared
// Params 1, eflags: 0x20 variadic
// Checksum 0x3d21588e, Offset: 0x14b0
// Size: 0xac
function waittill_multiple(...) {
    s_tracker = spawnstruct();
    s_tracker._wait_count = 0;
    for (i = 0; i < vararg.size; i++) {
        self thread _waitlogic(s_tracker, vararg[i]);
    }
    if (s_tracker._wait_count > 0) {
        s_tracker waittill("waitlogic_finished");
    }
}

// Namespace util/util_shared
// Params 2, eflags: 0x0
// Checksum 0x657b6530, Offset: 0x1568
// Size: 0x2a
function waittill_either(msg1, msg2) {
    self endon(msg1);
    self waittill(msg2);
}

// Namespace util/util_shared
// Params 1, eflags: 0x0
// Checksum 0xace25bae, Offset: 0x15a0
// Size: 0xbc
function break_glass(n_radius) {
    if (!isdefined(n_radius)) {
        n_radius = 50;
    }
    n_radius = float(n_radius);
    if (n_radius == -1) {
        v_origin_offset = (0, 0, 0);
        n_radius = 100;
    } else {
        v_origin_offset = (0, 0, 40);
    }
    glassradiusdamage(self.origin + v_origin_offset, n_radius, 500, 500);
}

// Namespace util/util_shared
// Params 1, eflags: 0x20 variadic
// Checksum 0x2410bc4c, Offset: 0x1668
// Size: 0x1e4
function waittill_multiple_ents(...) {
    a_ents = [];
    a_notifies = [];
    for (i = 0; i < vararg.size; i++) {
        if (i % 2) {
            if (!isdefined(a_notifies)) {
                a_notifies = [];
            } else if (!isarray(a_notifies)) {
                a_notifies = array(a_notifies);
            }
            a_notifies[a_notifies.size] = vararg[i];
            continue;
        }
        if (!isdefined(a_ents)) {
            a_ents = [];
        } else if (!isarray(a_ents)) {
            a_ents = array(a_ents);
        }
        a_ents[a_ents.size] = vararg[i];
    }
    s_tracker = spawnstruct();
    s_tracker._wait_count = 0;
    for (i = 0; i < a_ents.size; i++) {
        ent = a_ents[i];
        if (isdefined(ent)) {
            ent thread _waitlogic(s_tracker, a_notifies[i]);
        }
    }
    if (s_tracker._wait_count > 0) {
        s_tracker waittill("waitlogic_finished");
    }
}

// Namespace util/util_shared
// Params 2, eflags: 0x0
// Checksum 0x74ed214c, Offset: 0x1858
// Size: 0xc4
function _waitlogic(s_tracker, notifies) {
    s_tracker._wait_count++;
    if (!isdefined(notifies)) {
        notifies = [];
    } else if (!isarray(notifies)) {
        notifies = array(notifies);
    }
    notifies[notifies.size] = "death";
    self waittill(notifies);
    s_tracker._wait_count--;
    if (s_tracker._wait_count == 0) {
        s_tracker notify(#"waitlogic_finished");
    }
}

// Namespace util/util_shared
// Params 7, eflags: 0x0
// Checksum 0x89a6464, Offset: 0x1928
// Size: 0x1ce
function waittill_level_any_timeout(n_timeout, otherent, string1, string2, string3, string4, string5) {
    otherent endon(#"death");
    ent = spawnstruct();
    if (isdefined(string1)) {
        level thread waittill_level_string(string1, ent, otherent);
    }
    if (isdefined(string2)) {
        level thread waittill_level_string(string2, ent, otherent);
    }
    if (isdefined(string3)) {
        level thread waittill_level_string(string3, ent, otherent);
    }
    if (isdefined(string4)) {
        level thread waittill_level_string(string4, ent, otherent);
    }
    if (isdefined(string5)) {
        level thread waittill_level_string(string5, ent, otherent);
    }
    if (isdefined(otherent)) {
        otherent thread waittill_string("death", ent);
    }
    ent thread _timeout(n_timeout);
    waitresult = ent waittill("returned");
    ent notify(#"die");
    return waitresult.msg;
}

// Namespace util/util_shared
// Params 1, eflags: 0x0
// Checksum 0xd6c6ffce, Offset: 0x1b00
// Size: 0x3e
function _timeout(delay) {
    self endon(#"die");
    wait delay;
    self notify(#"returned", {#msg:"timeout"});
}

// Namespace util/util_shared
// Params 14, eflags: 0x0
// Checksum 0xc018a977, Offset: 0x1b48
// Size: 0x182
function waittill_any_ents(ent1, string1, ent2, string2, ent3, string3, ent4, string4, ent5, string5, ent6, string6, ent7, string7) {
    /#
        assert(isdefined(ent1));
    #/
    /#
        assert(isdefined(string1));
    #/
    if (isdefined(ent2) && isdefined(string2)) {
        ent2 endon(string2);
    }
    if (isdefined(ent3) && isdefined(string3)) {
        ent3 endon(string3);
    }
    if (isdefined(ent4) && isdefined(string4)) {
        ent4 endon(string4);
    }
    if (isdefined(ent5) && isdefined(string5)) {
        ent5 endon(string5);
    }
    if (isdefined(ent6) && isdefined(string6)) {
        ent6 endon(string6);
    }
    if (isdefined(ent7) && isdefined(string7)) {
        ent7 endon(string7);
    }
    ent1 waittill(string1);
}

// Namespace util/util_shared
// Params 4, eflags: 0x0
// Checksum 0x35bbbfa6, Offset: 0x1cd8
// Size: 0x92
function waittill_any_ents_two(ent1, string1, ent2, string2) {
    /#
        assert(isdefined(ent1));
    #/
    /#
        assert(isdefined(string1));
    #/
    if (isdefined(ent2) && isdefined(string2)) {
        ent2 endon(string2);
    }
    ent1 waittill(string1);
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0x5b188063, Offset: 0x1d78
// Size: 0x24
function isflashed() {
    if (!isdefined(self.flashendtime)) {
        return false;
    }
    return gettime() < self.flashendtime;
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0x438bf46e, Offset: 0x1da8
// Size: 0x24
function isstunned() {
    if (!isdefined(self.flashendtime)) {
        return false;
    }
    return gettime() < self.flashendtime;
}

// Namespace util/util_shared
// Params 3, eflags: 0x20 variadic
// Checksum 0xcca82579, Offset: 0x1dd8
// Size: 0x3a
function single_func(entity, func, ...) {
    return _single_func(entity, func, vararg);
}

// Namespace util/util_shared
// Params 3, eflags: 0x0
// Checksum 0x466189a4, Offset: 0x1e20
// Size: 0x3a
function single_func_argarray(entity, func, a_vars) {
    return _single_func(entity, func, a_vars);
}

// Namespace util/util_shared
// Params 3, eflags: 0x0
// Checksum 0xc54b477a, Offset: 0x1e68
// Size: 0x372
function _single_func(entity, func, a_vars) {
    _clean_up_arg_array(a_vars);
    switch (a_vars.size) {
    case 6:
        if (isdefined(entity)) {
            return entity [[ func ]](a_vars[0], a_vars[1], a_vars[2], a_vars[3], a_vars[4], a_vars[5]);
        } else {
            return [[ func ]](a_vars[0], a_vars[1], a_vars[2], a_vars[3], a_vars[4], a_vars[5]);
        }
        break;
    case 5:
        if (isdefined(entity)) {
            return entity [[ func ]](a_vars[0], a_vars[1], a_vars[2], a_vars[3], a_vars[4]);
        } else {
            return [[ func ]](a_vars[0], a_vars[1], a_vars[2], a_vars[3], a_vars[4]);
        }
        break;
    case 4:
        if (isdefined(entity)) {
            return entity [[ func ]](a_vars[0], a_vars[1], a_vars[2], a_vars[3]);
        } else {
            return [[ func ]](a_vars[0], a_vars[1], a_vars[2], a_vars[3]);
        }
        break;
    case 3:
        if (isdefined(entity)) {
            return entity [[ func ]](a_vars[0], a_vars[1], a_vars[2]);
        } else {
            return [[ func ]](a_vars[0], a_vars[1], a_vars[2]);
        }
        break;
    case 2:
        if (isdefined(entity)) {
            return entity [[ func ]](a_vars[0], a_vars[1]);
        } else {
            return [[ func ]](a_vars[0], a_vars[1]);
        }
        break;
    case 1:
        if (isdefined(entity)) {
            return entity [[ func ]](a_vars[0]);
        } else {
            return [[ func ]](a_vars[0]);
        }
        break;
    case 0:
        if (isdefined(entity)) {
            return entity [[ func ]]();
        } else {
            return [[ func ]]();
        }
        break;
    default:
        /#
            assertmsg("<dev string:x88>");
        #/
        break;
    }
}

// Namespace util/util_shared
// Params 1, eflags: 0x0
// Checksum 0x8bafbc9, Offset: 0x21e8
// Size: 0x76
function _clean_up_arg_array(&a_vars) {
    for (i = a_vars.size - 1; i >= 0; i--) {
        if (a_vars[i] === undefined) {
            arrayremoveindex(a_vars, i, 0);
            continue;
        }
        break;
    }
}

// Namespace util/util_shared
// Params 7, eflags: 0x0
// Checksum 0x98a1a52b, Offset: 0x2268
// Size: 0xe8
function new_func(func, arg1, arg2, arg3, arg4, arg5, arg6) {
    s_func = spawnstruct();
    s_func.func = func;
    s_func.arg1 = arg1;
    s_func.arg2 = arg2;
    s_func.arg3 = arg3;
    s_func.arg4 = arg4;
    s_func.arg5 = arg5;
    s_func.arg6 = arg6;
    return s_func;
}

// Namespace util/util_shared
// Params 1, eflags: 0x0
// Checksum 0x9ec8e9c5, Offset: 0x2358
// Size: 0x72
function call_func(s_func) {
    return single_func(self, s_func.func, s_func.arg1, s_func.arg2, s_func.arg3, s_func.arg4, s_func.arg5, s_func.arg6);
}

// Namespace util/util_shared
// Params 3, eflags: 0x20 variadic
// Checksum 0x7fc02679, Offset: 0x23d8
// Size: 0x3c
function single_thread(entity, func, ...) {
    _single_thread(entity, func, vararg);
}

// Namespace util/util_shared
// Params 3, eflags: 0x0
// Checksum 0x227d114c, Offset: 0x2420
// Size: 0x3c
function single_thread_argarray(entity, func, &a_vars) {
    _single_thread(entity, func, a_vars);
}

// Namespace util/util_shared
// Params 3, eflags: 0x0
// Checksum 0x3a87f23e, Offset: 0x2468
// Size: 0x222
function _single_thread(entity, func, &a_vars) {
    /#
        assert(isdefined(entity), "<dev string:x97>");
    #/
    _clean_up_arg_array(a_vars);
    switch (a_vars.size) {
    case 6:
        entity thread [[ func ]](a_vars[0], a_vars[1], a_vars[2], a_vars[3], a_vars[4], a_vars[5]);
        break;
    case 5:
        entity thread [[ func ]](a_vars[0], a_vars[1], a_vars[2], a_vars[3], a_vars[4]);
        break;
    case 4:
        entity thread [[ func ]](a_vars[0], a_vars[1], a_vars[2], a_vars[3]);
        break;
    case 3:
        entity thread [[ func ]](a_vars[0], a_vars[1], a_vars[2]);
        break;
    case 2:
        entity thread [[ func ]](a_vars[0], a_vars[1]);
        break;
    case 1:
        entity thread [[ func ]](a_vars[0]);
        break;
    case 0:
        entity thread [[ func ]]();
        break;
    default:
        /#
            assertmsg("<dev string:x88>");
        #/
        break;
    }
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0x6e382747, Offset: 0x2698
// Size: 0x9c
function script_delay() {
    if (isdefined(self.script_delay)) {
        wait self.script_delay;
        return true;
    } else if (isdefined(self.script_delay_min) && isdefined(self.script_delay_max)) {
        if (self.script_delay_max > self.script_delay_min) {
            wait randomfloatrange(self.script_delay_min, self.script_delay_max);
        } else {
            wait self.script_delay_min;
        }
        return true;
    }
    return false;
}

// Namespace util/util_shared
// Params 8, eflags: 0x0
// Checksum 0xe8c0e4d7, Offset: 0x2740
// Size: 0xcc
function timeout(n_time, func, arg1, arg2, arg3, arg4, arg5, arg6) {
    if (isdefined(n_time)) {
        __s = spawnstruct();
        __s endon(#"timeout");
        __s delay_notify(n_time, "timeout");
    }
    single_func(self, func, arg1, arg2, arg3, arg4, arg5, arg6);
}

// Namespace util/util_shared
// Params 1, eflags: 0x0
// Checksum 0x219c9990, Offset: 0x2818
// Size: 0xb2
function create_flags_and_return_tokens(flags) {
    tokens = strtok(flags, " ");
    for (i = 0; i < tokens.size; i++) {
        if (!level flag::exists(tokens[i])) {
            level flag::init(tokens[i], undefined, 1);
        }
    }
    return tokens;
}

/#

    // Namespace util/util_shared
    // Params 1, eflags: 0x0
    // Checksum 0xaf58885b, Offset: 0x28d8
    // Size: 0x70
    function fileprint_start(file) {
        filename = file;
        file = openfile(filename, "<dev string:xa9>");
        level.fileprint = file;
        level.fileprintlinecount = 0;
        level.fileprint_filename = filename;
    }

    // Namespace util/util_shared
    // Params 1, eflags: 0x0
    // Checksum 0x32468fd4, Offset: 0x2950
    // Size: 0x6c
    function fileprint_map_start(file) {
        file = "<dev string:xaf>" + file + "<dev string:xbb>";
        fileprint_start(file);
        level.fileprint_mapentcount = 0;
        fileprint_map_header(1);
    }

    // Namespace util/util_shared
    // Params 2, eflags: 0x0
    // Checksum 0x46d4c588, Offset: 0x29c8
    // Size: 0x74
    function fileprint_chk(file, str) {
        level.fileprintlinecount++;
        if (level.fileprintlinecount > 400) {
            waitframe(1);
            level.fileprintlinecount++;
            level.fileprintlinecount = 0;
        }
        fprintln(file, str);
    }

#/

// Namespace util/util_shared
// Params 1, eflags: 0x0
// Checksum 0x9c77405b, Offset: 0x2a48
// Size: 0x10c
function fileprint_map_header(binclude_blank_worldspawn) {
    if (!isdefined(binclude_blank_worldspawn)) {
        binclude_blank_worldspawn = 0;
    }
    /#
        assert(isdefined(level.fileprint));
    #/
    /#
        fileprint_chk(level.fileprint, "<dev string:xc0>");
        fileprint_chk(level.fileprint, "<dev string:xc8>");
        fileprint_chk(level.fileprint, "<dev string:xe3>");
        if (!binclude_blank_worldspawn) {
            return;
        }
        fileprint_map_entity_start();
        fileprint_map_keypairprint("<dev string:xf3>", "<dev string:xfd>");
        fileprint_map_entity_end();
    #/
}

/#

    // Namespace util/util_shared
    // Params 2, eflags: 0x0
    // Checksum 0x951d111d, Offset: 0x2b60
    // Size: 0x7c
    function fileprint_map_keypairprint(key1, key2) {
        /#
            assert(isdefined(level.fileprint));
        #/
        fileprint_chk(level.fileprint, "<dev string:x108>" + key1 + "<dev string:x10a>" + key2 + "<dev string:x108>");
    }

    // Namespace util/util_shared
    // Params 0, eflags: 0x0
    // Checksum 0x5438ea7d, Offset: 0x2be8
    // Size: 0xc8
    function fileprint_map_entity_start() {
        /#
            assert(!isdefined(level.fileprint_entitystart));
        #/
        level.fileprint_entitystart = 1;
        /#
            assert(isdefined(level.fileprint));
        #/
        fileprint_chk(level.fileprint, "<dev string:x10e>" + level.fileprint_mapentcount);
        fileprint_chk(level.fileprint, "<dev string:x119>");
        level.fileprint_mapentcount++;
    }

    // Namespace util/util_shared
    // Params 0, eflags: 0x0
    // Checksum 0xbe99a1e9, Offset: 0x2cb8
    // Size: 0x84
    function fileprint_map_entity_end() {
        /#
            assert(isdefined(level.fileprint_entitystart));
        #/
        /#
            assert(isdefined(level.fileprint));
        #/
        level.fileprint_entitystart = undefined;
        fileprint_chk(level.fileprint, "<dev string:x11b>");
    }

    // Namespace util/util_shared
    // Params 0, eflags: 0x0
    // Checksum 0x529459c2, Offset: 0x2d48
    // Size: 0x26a
    function fileprint_end() {
        /#
            assert(!isdefined(level.fileprint_entitystart));
        #/
        saved = closefile(level.fileprint);
        if (saved != 1) {
            println("<dev string:x11d>");
            println("<dev string:x141>");
            println("<dev string:x143>");
            println("<dev string:x156>" + level.fileprint_filename);
            println("<dev string:x167>");
            println("<dev string:x19e>");
            println("<dev string:x1da>");
            println("<dev string:x216>");
            println("<dev string:x25c>");
            println("<dev string:x141>");
            println("<dev string:x276>");
            println("<dev string:x2b9>");
            println("<dev string:x2fd>");
            println("<dev string:x339>");
            println("<dev string:x37d>");
            println("<dev string:x3ba>");
            println("<dev string:x3f9>");
            println("<dev string:x141>");
            println("<dev string:x11d>");
            println("<dev string:x43c>");
        }
        level.fileprint = undefined;
        level.fileprint_filename = undefined;
    }

    // Namespace util/util_shared
    // Params 1, eflags: 0x0
    // Checksum 0x69df3574, Offset: 0x2fc0
    // Size: 0x64
    function fileprint_radiant_vec(vector) {
        string = "<dev string:x468>" + vector[0] + "<dev string:x141>" + vector[1] + "<dev string:x141>" + vector[2] + "<dev string:x468>";
        return string;
    }

#/

// Namespace util/util_shared
// Params 2, eflags: 0x0
// Checksum 0x3717017c, Offset: 0x3030
// Size: 0x66
function death_notify_wrapper(attacker, damagetype) {
    level notify(#"face", {#face_notify:"death", #entity:self});
    self notify(#"death", {#attacker:attacker, #mod:damagetype});
}

// Namespace util/util_shared
// Params 9, eflags: 0x0
// Checksum 0x5fdcb094, Offset: 0x30a0
// Size: 0xf2
function damage_notify_wrapper(damage, attacker, direction_vec, point, type, modelname, tagname, partname, idflags) {
    level notify(#"face", {#face_notify:"damage", #entity:self});
    self notify(#"damage", {#amount:damage, #attacker:attacker, #direction:direction_vec, #position:point, #mod:type, #model_name:modelname, #tag_name:tagname, #part_name:partname, #flags:idflags});
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0xbc5abcb7, Offset: 0x31a0
// Size: 0x3e
function explode_notify_wrapper() {
    level notify(#"face", {#face_notify:"explode", #entity:self});
    self notify(#"explode");
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0xfc83f7ba, Offset: 0x31e8
// Size: 0x3e
function alert_notify_wrapper() {
    level notify(#"face", {#face_notify:"alert", #entity:self});
    self notify(#"alert");
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0x155e6338, Offset: 0x3230
// Size: 0x3e
function shoot_notify_wrapper() {
    level notify(#"face", {#face_notify:"shoot", #entity:self});
    self notify(#"shoot");
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0xfa461440, Offset: 0x3278
// Size: 0x3e
function melee_notify_wrapper() {
    level notify(#"face", {#face_notify:"melee", #entity:self});
    self notify(#"melee");
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0x4f3a7450, Offset: 0x32c0
// Size: 0x10
function isusabilityenabled() {
    return !self.disabledusability;
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0x67d256cc, Offset: 0x32d8
// Size: 0x24
function _disableusability() {
    self.disabledusability++;
    self disableusability();
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0x47d546dc, Offset: 0x3308
// Size: 0x54
function _enableusability() {
    self.disabledusability--;
    /#
        assert(self.disabledusability >= 0);
    #/
    if (!self.disabledusability) {
        self enableusability();
    }
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0xd337456e, Offset: 0x3368
// Size: 0x24
function resetusability() {
    self.disabledusability = 0;
    self enableusability();
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0x49752321, Offset: 0x3398
// Size: 0x44
function function_f9e9f0f0() {
    if (!isdefined(self.disabledweapon)) {
        self.disabledweapon = 0;
    }
    self.disabledweapon++;
    self disableweapons();
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0xf9c429e, Offset: 0x33e8
// Size: 0x44
function function_ee182f5d() {
    if (self.disabledweapon > 0) {
        self.disabledweapon--;
        if (!self.disabledweapon) {
            self enableweapons();
        }
    }
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0x5752eb2f, Offset: 0x3438
// Size: 0x10
function function_31827fe8() {
    return !self.disabledweapon;
}

// Namespace util/util_shared
// Params 1, eflags: 0x0
// Checksum 0x74232822, Offset: 0x3450
// Size: 0xf4
function orient_to_normal(normal) {
    hor_normal = (normal[0], normal[1], 0);
    hor_length = length(hor_normal);
    if (!hor_length) {
        return (0, 0, 0);
    }
    hor_dir = vectornormalize(hor_normal);
    neg_height = normal[2] * -1;
    tangent = (hor_dir[0] * neg_height, hor_dir[1] * neg_height, hor_length);
    plant_angle = vectortoangles(tangent);
    return plant_angle;
}

// Namespace util/util_shared
// Params 9, eflags: 0x0
// Checksum 0xbc4f83ac, Offset: 0x3550
// Size: 0x84
function delay(time_or_notify, str_endon, func, arg1, arg2, arg3, arg4, arg5, arg6) {
    self thread _delay(time_or_notify, str_endon, func, arg1, arg2, arg3, arg4, arg5, arg6);
}

// Namespace util/util_shared
// Params 9, eflags: 0x0
// Checksum 0x1d00b689, Offset: 0x35e0
// Size: 0xcc
function _delay(time_or_notify, str_endon, func, arg1, arg2, arg3, arg4, arg5, arg6) {
    self endon(#"death");
    if (isdefined(str_endon)) {
        self endon(str_endon);
    }
    if (isstring(time_or_notify)) {
        self waittill(time_or_notify);
    } else {
        wait time_or_notify;
    }
    single_thread(self, func, arg1, arg2, arg3, arg4, arg5, arg6);
}

// Namespace util/util_shared
// Params 9, eflags: 0x0
// Checksum 0x8f81a83, Offset: 0x36b8
// Size: 0x84
function delay_network_frames(n_frames, str_endon, func, arg1, arg2, arg3, arg4, arg5, arg6) {
    self thread _delay_network_frames(n_frames, str_endon, func, arg1, arg2, arg3, arg4, arg5, arg6);
}

// Namespace util/util_shared
// Params 9, eflags: 0x0
// Checksum 0x71ef25d0, Offset: 0x3748
// Size: 0xb4
function _delay_network_frames(n_frames, str_endon, func, arg1, arg2, arg3, arg4, arg5, arg6) {
    self endon(#"death");
    if (isdefined(str_endon)) {
        self endon(str_endon);
    }
    wait_network_frame(n_frames);
    single_func(self, func, arg1, arg2, arg3, arg4, arg5, arg6);
}

// Namespace util/util_shared
// Params 4, eflags: 0x0
// Checksum 0xc9a95b93, Offset: 0x3808
// Size: 0x4c
function delay_notify(time_or_notify, str_notify, str_endon, arg1) {
    self thread _delay_notify(time_or_notify, str_notify, str_endon, arg1);
}

// Namespace util/util_shared
// Params 4, eflags: 0x0
// Checksum 0x39ce8c66, Offset: 0x3860
// Size: 0x82
function _delay_notify(time_or_notify, str_notify, str_endon, arg1) {
    self endon(#"death");
    if (isdefined(str_endon)) {
        self endon(str_endon);
    }
    if (isstring(time_or_notify)) {
        self waittill(time_or_notify);
    } else {
        wait time_or_notify;
    }
    self notify(str_notify, arg1);
}

// Namespace util/util_shared
// Params 2, eflags: 0x0
// Checksum 0x4cf34aca, Offset: 0x38f0
// Size: 0x74
function get_closest_player(org, str_team) {
    str_team = get_team_mapping(str_team);
    players = getplayers(str_team);
    return arraysort(players, org, 1, 1)[0];
}

// Namespace util/util_shared
// Params 1, eflags: 0x0
// Checksum 0x1455dbe2, Offset: 0x3970
// Size: 0x100
function registerclientsys(ssysname) {
    if (!isdefined(level._clientsys)) {
        level._clientsys = [];
    }
    if (level._clientsys.size >= 32) {
        /#
            /#
                assertmsg("<dev string:x469>");
            #/
        #/
        return;
    }
    if (isdefined(level._clientsys[ssysname])) {
        /#
            /#
                assertmsg("<dev string:x48a>" + ssysname);
            #/
        #/
        return;
    }
    level._clientsys[ssysname] = spawnstruct();
    level._clientsys[ssysname].sysid = clientsysregister(ssysname);
}

// Namespace util/util_shared
// Params 3, eflags: 0x0
// Checksum 0xe8a17b36, Offset: 0x3a78
// Size: 0x124
function setclientsysstate(ssysname, ssysstate, player) {
    if (!isdefined(level._clientsys)) {
        /#
            /#
                assertmsg("<dev string:x4b2>");
            #/
        #/
        return;
    }
    if (!isdefined(level._clientsys[ssysname])) {
        /#
            /#
                assertmsg("<dev string:x4ef>" + ssysname);
            #/
        #/
        return;
    }
    if (isdefined(player)) {
        player clientsyssetstate(level._clientsys[ssysname].sysid, ssysstate);
        return;
    }
    clientsyssetstate(level._clientsys[ssysname].sysid, ssysstate);
    level._clientsys[ssysname].sysstate = ssysstate;
}

// Namespace util/util_shared
// Params 1, eflags: 0x0
// Checksum 0x98f2de14, Offset: 0x3ba8
// Size: 0xd6
function getclientsysstate(ssysname) {
    if (!isdefined(level._clientsys)) {
        /#
            /#
                assertmsg("<dev string:x520>");
            #/
        #/
        return "";
    }
    if (!isdefined(level._clientsys[ssysname])) {
        /#
            /#
                assertmsg("<dev string:x560>" + ssysname + "<dev string:x56f>");
            #/
        #/
        return "";
    }
    if (isdefined(level._clientsys[ssysname].sysstate)) {
        return level._clientsys[ssysname].sysstate;
    }
    return "";
}

// Namespace util/util_shared
// Params 1, eflags: 0x0
// Checksum 0x612786e0, Offset: 0x3c88
// Size: 0x6c
function clientnotify(event) {
    if (level.clientscripts) {
        if (isplayer(self)) {
            setclientsysstate("levelNotify", event, self);
            return;
        }
        setclientsysstate("levelNotify", event);
    }
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0xa5da95db, Offset: 0x3d00
// Size: 0x42
function coopgame() {
    return sessionmodeisonlinegame() || sessionmodeissystemlink() || issplitscreen();
}

// Namespace util/util_shared
// Params 4, eflags: 0x0
// Checksum 0x1a9b282d, Offset: 0x3d50
// Size: 0x1da
function is_looking_at(ent_or_org, n_dot_range, do_trace, v_offset) {
    if (!isdefined(n_dot_range)) {
        n_dot_range = 0.67;
    }
    if (!isdefined(do_trace)) {
        do_trace = 0;
    }
    /#
        assert(isdefined(ent_or_org), "<dev string:x59c>");
    #/
    v_point = isvec(ent_or_org) ? ent_or_org : ent_or_org.origin;
    if (isvec(v_offset)) {
        v_point += v_offset;
    }
    b_can_see = 0;
    b_use_tag_eye = 0;
    if (isplayer(self) || isai(self)) {
        b_use_tag_eye = 1;
    }
    n_dot = self math::get_dot_direction(v_point, 0, 1, "forward", b_use_tag_eye);
    if (n_dot > n_dot_range) {
        if (do_trace) {
            v_eye = self get_eye();
            b_can_see = sighttracepassed(v_eye, v_point, 0, ent_or_org);
        } else {
            b_can_see = 1;
        }
    }
    return b_can_see;
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0x67e8ae1b, Offset: 0x3f38
// Size: 0xc4
function get_eye() {
    if (isplayer(self)) {
        linked_ent = self getlinkedent();
        if (isdefined(linked_ent) && getdvarint("cg_cameraUseTagCamera") > 0) {
            camera = linked_ent gettagorigin("tag_camera");
            if (isdefined(camera)) {
                return camera;
            }
        }
    }
    pos = self geteye();
    return pos;
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0x16d42d01, Offset: 0x4008
// Size: 0x24
function is_ads() {
    return self playerads() > 0.5;
}

// Namespace util/util_shared
// Params 5, eflags: 0x0
// Checksum 0x863c5aa7, Offset: 0x4038
// Size: 0xec
function spawn_model(model_name, origin, angles, n_spawnflags, b_throttle) {
    if (!isdefined(n_spawnflags)) {
        n_spawnflags = 0;
    }
    if (!isdefined(b_throttle)) {
        b_throttle = 0;
    }
    if (b_throttle) {
        spawner::global_spawn_throttle(4);
    }
    if (!isdefined(origin)) {
        origin = (0, 0, 0);
    }
    model = spawn("script_model", origin, n_spawnflags);
    model setmodel(model_name);
    if (isdefined(angles)) {
        model.angles = angles;
    }
    return model;
}

// Namespace util/util_shared
// Params 5, eflags: 0x0
// Checksum 0xe433f1f3, Offset: 0x4130
// Size: 0xa4
function spawn_anim_model(model_name, origin, angles, n_spawnflags, b_throttle) {
    if (!isdefined(n_spawnflags)) {
        n_spawnflags = 0;
    }
    model = spawn_model(model_name, origin, angles, n_spawnflags, b_throttle);
    model useanimtree(#generic);
    model.animtree = "generic";
    return model;
}

// Namespace util/util_shared
// Params 5, eflags: 0x0
// Checksum 0xdee42a5, Offset: 0x41e0
// Size: 0xa4
function spawn_anim_player_model(model_name, origin, angles, n_spawnflags, b_throttle) {
    if (!isdefined(n_spawnflags)) {
        n_spawnflags = 0;
    }
    model = spawn_model(model_name, origin, angles, n_spawnflags, b_throttle);
    model useanimtree(#all_player);
    model.animtree = "all_player";
    return model;
}

// Namespace util/util_shared
// Params 4, eflags: 0x0
// Checksum 0x42c3b842, Offset: 0x4290
// Size: 0xc0
function waittill_player_looking_at(origin, arc_angle_degrees, do_trace, e_ignore) {
    if (!isdefined(arc_angle_degrees)) {
        arc_angle_degrees = 90;
    }
    self endon(#"death");
    arc_angle_degrees = absangleclamp360(arc_angle_degrees);
    dot = cos(arc_angle_degrees * 0.5);
    while (!is_player_looking_at(origin, dot, do_trace, e_ignore)) {
        waitframe(1);
    }
}

// Namespace util/util_shared
// Params 3, eflags: 0x0
// Checksum 0x1365d53f, Offset: 0x4358
// Size: 0x50
function waittill_player_not_looking_at(origin, dot, do_trace) {
    self endon(#"death");
    while (is_player_looking_at(origin, dot, do_trace)) {
        waitframe(1);
    }
}

// Namespace util/util_shared
// Params 4, eflags: 0x0
// Checksum 0x59447055, Offset: 0x43b0
// Size: 0x1d8
function is_player_looking_at(v_origin, n_dot, b_do_trace, e_ignore) {
    if (!isdefined(n_dot)) {
        n_dot = 0.7;
    }
    if (!isdefined(b_do_trace)) {
        b_do_trace = 1;
    }
    /#
        assert(isplayer(self), "<dev string:x5d4>");
    #/
    if (isdefined(self.hijacked_vehicle_entity)) {
        v_eye = self.hijacked_vehicle_entity gettagorigin("tag_player");
        v_view = anglestoforward(self.hijacked_vehicle_entity gettagangles("tag_player"));
    } else {
        v_eye = self get_eye();
        v_view = anglestoforward(self getplayerangles());
    }
    v_delta = vectornormalize(v_origin - v_eye);
    n_new_dot = vectordot(v_delta, v_view);
    if (n_new_dot >= n_dot) {
        if (b_do_trace) {
            return bullettracepassed(v_origin, v_eye, 0, e_ignore);
        } else {
            return 1;
        }
    }
    return 0;
}

// Namespace util/util_shared
// Params 5, eflags: 0x0
// Checksum 0xde2c0fa4, Offset: 0x4590
// Size: 0x7c
function wait_endon(waittime, endonstring, endonstring2, endonstring3, endonstring4) {
    self endon(endonstring);
    if (isdefined(endonstring2)) {
        self endon(endonstring2);
    }
    if (isdefined(endonstring3)) {
        self endon(endonstring3);
    }
    if (isdefined(endonstring4)) {
        self endon(endonstring4);
    }
    wait waittime;
    return true;
}

// Namespace util/util_shared
// Params 5, eflags: 0x0
// Checksum 0x76e5d5b8, Offset: 0x4618
// Size: 0x8e
function waittillendonthreaded(waitcondition, callback, endcondition1, endcondition2, endcondition3) {
    if (isdefined(endcondition1)) {
        self endon(endcondition1);
    }
    if (isdefined(endcondition2)) {
        self endon(endcondition2);
    }
    if (isdefined(endcondition3)) {
        self endon(endcondition3);
    }
    self waittill(waitcondition);
    if (isdefined(callback)) {
        [[ callback ]](waitcondition);
    }
}

// Namespace util/util_shared
// Params 1, eflags: 0x0
// Checksum 0x90b95874, Offset: 0x46b0
// Size: 0x50
function new_timer(n_timer_length) {
    s_timer = spawnstruct();
    s_timer.n_time_created = gettime();
    s_timer.n_length = n_timer_length;
    return s_timer;
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0x62b6e744, Offset: 0x4708
// Size: 0x24
function get_time() {
    t_now = gettime();
    return t_now - self.n_time_created;
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0xec75525c, Offset: 0x4738
// Size: 0x18
function get_time_in_seconds() {
    return get_time() / 1000;
}

// Namespace util/util_shared
// Params 1, eflags: 0x0
// Checksum 0x78d8ff91, Offset: 0x4758
// Size: 0x52
function get_time_frac(n_end_time) {
    if (!isdefined(n_end_time)) {
        n_end_time = self.n_length;
    }
    return lerpfloat(0, 1, get_time_in_seconds() / n_end_time);
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0xb0bf63ef, Offset: 0x47b8
// Size: 0x58
function get_time_left() {
    if (isdefined(self.n_length)) {
        n_current_time = get_time_in_seconds();
        return max(self.n_length - n_current_time, 0);
    }
    return -1;
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0xe140f62e, Offset: 0x4818
// Size: 0x16
function is_time_left() {
    return get_time_left() != 0;
}

// Namespace util/util_shared
// Params 1, eflags: 0x0
// Checksum 0x3a4e4f5, Offset: 0x4838
// Size: 0x74
function timer_wait(n_wait) {
    if (isdefined(self.n_length)) {
        n_wait = min(n_wait, get_time_left());
    }
    wait n_wait;
    n_current_time = get_time_in_seconds();
    return n_current_time;
}

// Namespace util/util_shared
// Params 1, eflags: 0x0
// Checksum 0x95a8fd36, Offset: 0x48b8
// Size: 0x34
function is_primary_damage(meansofdeath) {
    if (meansofdeath == "MOD_RIFLE_BULLET" || meansofdeath == "MOD_PISTOL_BULLET") {
        return true;
    }
    return false;
}

// Namespace util/util_shared
// Params 1, eflags: 0x0
// Checksum 0xc39aef38, Offset: 0x48f8
// Size: 0x4c
function delete_on_death(ent) {
    ent endon(#"death");
    self waittill("death");
    if (isdefined(ent)) {
        ent delete();
    }
}

// Namespace util/util_shared
// Params 3, eflags: 0x0
// Checksum 0xa81fed32, Offset: 0x4950
// Size: 0xac
function delete_on_death_or_notify(e_to_delete, str_notify, str_clientfield) {
    if (!isdefined(str_clientfield)) {
        str_clientfield = undefined;
    }
    e_to_delete endon(#"death");
    self waittill_either("death", str_notify);
    if (isdefined(e_to_delete)) {
        if (isdefined(str_clientfield)) {
            e_to_delete clientfield::set(str_clientfield, 0);
            wait 0.1;
        }
        e_to_delete delete();
    }
}

// Namespace util/util_shared
// Params 2, eflags: 0x0
// Checksum 0x50920ca2, Offset: 0x4a08
// Size: 0xa8
function wait_till_not_touching(e_to_check, e_to_touch) {
    /#
        assert(isdefined(e_to_check), "<dev string:x602>");
    #/
    /#
        assert(isdefined(e_to_touch), "<dev string:x640>");
    #/
    e_to_check endon(#"death");
    e_to_touch endon(#"death");
    while (e_to_check istouching(e_to_touch)) {
        waitframe(1);
    }
}

// Namespace util/util_shared
// Params 2, eflags: 0x0
// Checksum 0xab7658cb, Offset: 0x4ab8
// Size: 0xec
function any_player_is_touching(ent, str_team) {
    str_team = get_team_mapping(str_team);
    foreach (player in getplayers(str_team)) {
        if (isalive(player) && player istouching(ent)) {
            return true;
        }
    }
    return false;
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0x80a523c, Offset: 0x4bb0
// Size: 0x114
function set_console_status() {
    if (!isdefined(level.console)) {
        level.console = getdvarstring("consoleGame") == "true";
    } else {
        /#
            assert(level.console == getdvarstring("<dev string:x67e>") == "<dev string:x68a>", "<dev string:x68f>");
        #/
    }
    if (!isdefined(level.consolexenon)) {
        level.xenon = getdvarstring("xenonGame") == "true";
        return;
    }
    /#
        assert(level.xenon == getdvarstring("<dev string:x6b2>") == "<dev string:x68a>", "<dev string:x6bc>");
    #/
}

// Namespace util/util_shared
// Params 2, eflags: 0x0
// Checksum 0x9cbc1b11, Offset: 0x4cd0
// Size: 0x14
function waittill_asset_loaded(str_type, str_name) {
    
}

// Namespace util/util_shared
// Params 1, eflags: 0x0
// Checksum 0xc6a7755f, Offset: 0x4cf0
// Size: 0x1b8
function script_wait(var_bfefeedc) {
    if (!isdefined(var_bfefeedc)) {
        var_bfefeedc = 0;
    }
    var_714358d = 1;
    if (var_bfefeedc) {
        players = getplayers();
        if (players.size == 2) {
            var_714358d = 0.7;
        } else if (players.size == 3) {
            var_714358d = 0.4;
        } else if (players.size == 4) {
            var_714358d = 0.1;
        }
    }
    starttime = gettime();
    if (isdefined(self.script_wait)) {
        wait self.script_wait * var_714358d;
        if (isdefined(self.script_wait_add)) {
            self.script_wait += self.script_wait_add;
        }
    } else if (isdefined(self.script_wait_min) && isdefined(self.script_wait_max)) {
        wait randomfloatrange(self.script_wait_min, self.script_wait_max) * var_714358d;
        if (isdefined(self.script_wait_add)) {
            self.script_wait_min += self.script_wait_add;
            self.script_wait_max += self.script_wait_add;
        }
    }
    return gettime() - starttime;
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0xd5ad3882, Offset: 0x4eb0
// Size: 0x1e
function is_killstreaks_enabled() {
    return isdefined(level.killstreaksenabled) && level.killstreaksenabled;
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0x6ea23591, Offset: 0x4ed8
// Size: 0x20
function is_flashbanged() {
    return isdefined(self.flashendtime) && gettime() < self.flashendtime;
}

// Namespace util/util_shared
// Params 1, eflags: 0x0
// Checksum 0xd58d3397, Offset: 0x4f00
// Size: 0x120
function magic_bullet_shield(ent) {
    if (!isdefined(ent)) {
        ent = self;
    }
    ent val::set("magic_bullet_shield", "allowdeath", 0);
    ent.magic_bullet_shield = 1;
    /#
        ent notify(#"_stop_magic_bullet_shield_debug");
        level thread debug_magic_bullet_shield_death(ent);
    #/
    /#
        assert(isalive(ent), "<dev string:x6dd>");
    #/
    if (isai(ent)) {
        if (isactor(ent)) {
            ent bloodimpact("hero");
        }
        ent.attackeraccuracy = 0.1;
    }
}

// Namespace util/util_shared
// Params 1, eflags: 0x0
// Checksum 0xc8b7c55a, Offset: 0x5028
// Size: 0xa4
function debug_magic_bullet_shield_death(guy) {
    targetname = "none";
    if (isdefined(guy.targetname)) {
        targetname = guy.targetname;
    }
    guy endon(#"stop_magic_bullet_shield");
    guy endon(#"_stop_magic_bullet_shield_debug");
    guy waittill("death");
    /#
        assert(!isdefined(guy), "<dev string:x719>" + targetname);
    #/
}

// Namespace util/util_shared
// Params 2, eflags: 0x0
// Checksum 0xd84d58bd, Offset: 0x50d8
// Size: 0x258
function spawn_player_clone(player, animname) {
    playerclone = spawn("script_model", player.origin);
    playerclone.angles = player.angles;
    bodymodel = player getcharacterbodymodel();
    playerclone setmodel(bodymodel);
    headmodel = player getcharacterheadmodel();
    if (isdefined(headmodel)) {
        playerclone attach(headmodel, "");
    }
    var_f1a3fa15 = player getcharacterhelmetmodel();
    if (isdefined(var_f1a3fa15)) {
        playerclone attach(var_f1a3fa15, "");
    }
    var_6f30937d = player getcharacterbodyrenderoptions();
    playerclone setbodyrenderoptions(var_6f30937d, var_6f30937d, var_6f30937d);
    playerclone useanimtree(#all_player);
    if (isdefined(animname)) {
        playerclone animscripted("clone_anim", playerclone.origin, playerclone.angles, animname);
    }
    playerclone.health = 100;
    playerclone setowner(player);
    playerclone.team = player.team;
    playerclone solid();
    return playerclone;
}

// Namespace util/util_shared
// Params 1, eflags: 0x0
// Checksum 0xfa3a9027, Offset: 0x5338
// Size: 0xc8
function stop_magic_bullet_shield(ent) {
    if (!isdefined(ent)) {
        ent = self;
    }
    ent val::reset("magic_bullet_shield", "allowdeath");
    ent.magic_bullet_shield = undefined;
    if (isai(ent)) {
        if (isactor(ent)) {
            ent bloodimpact("normal");
        }
        ent.attackeraccuracy = 1;
    }
    ent notify(#"stop_magic_bullet_shield");
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0xf9627e5b, Offset: 0x5408
// Size: 0x20
function function_7e983921() {
    if (level.roundlimit == 1) {
        return true;
    }
    return false;
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0xc2aa2d25, Offset: 0x5430
// Size: 0x32
function function_d2c2af67() {
    if (level.roundlimit > 1 && game.roundsplayed == 0) {
        return true;
    }
    return false;
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0xdb07ccd8, Offset: 0x5470
// Size: 0x42
function function_43686c3c() {
    if (level.roundlimit > 1 && game.roundsplayed >= level.roundlimit - 1) {
        return true;
    }
    return false;
}

// Namespace util/util_shared
// Params 1, eflags: 0x0
// Checksum 0x500a68c5, Offset: 0x54c0
// Size: 0x42
function get_rounds_won(str_team) {
    str_team = get_team_mapping(str_team);
    return game.stat["roundswon"][str_team];
}

// Namespace util/util_shared
// Params 1, eflags: 0x0
// Checksum 0x79e5e978, Offset: 0x5510
// Size: 0xe8
function function_cfde690(str_skip_team) {
    str_skip_team = get_team_mapping(str_skip_team);
    roundswon = 0;
    foreach (str_team in level.teams) {
        if (str_team == str_skip_team) {
            continue;
        }
        roundswon += game.stat["roundswon"][str_team];
    }
    return roundswon;
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0x99b0bdd0, Offset: 0x5600
// Size: 0xe
function get_rounds_played() {
    return game.roundsplayed;
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0x6396fd2c, Offset: 0x5618
// Size: 0x34
function function_b8a26ad8() {
    if (level.roundlimit != 1 && level.roundwinlimit != 1) {
        return true;
    }
    return false;
}

// Namespace util/util_shared
// Params 4, eflags: 0x0
// Checksum 0xcbe1ae6e, Offset: 0x5658
// Size: 0xa2
function within_fov(start_origin, start_angles, end_origin, fov) {
    normal = vectornormalize(end_origin - start_origin);
    forward = anglestoforward(start_angles);
    dot = vectordot(forward, normal);
    return dot >= fov;
}

// Namespace util/util_shared
// Params 1, eflags: 0x0
// Checksum 0x3a84ef90, Offset: 0x5708
// Size: 0x124
function button_held_think(which_button) {
    self endon(#"disconnect");
    if (!isdefined(self._holding_button)) {
        self._holding_button = [];
    }
    self._holding_button[which_button] = 0;
    time_started = 0;
    while (true) {
        if (self._holding_button[which_button]) {
            if (!self [[ level._button_funcs[which_button] ]]()) {
                self._holding_button[which_button] = 0;
            }
        } else if (self [[ level._button_funcs[which_button] ]]()) {
            if (time_started == 0) {
                time_started = gettime();
            }
            if (gettime() - time_started > 250) {
                self._holding_button[which_button] = 1;
            }
        } else if (time_started != 0) {
            time_started = 0;
        }
        waitframe(1);
    }
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0x8e5671bb, Offset: 0x5838
// Size: 0x58
function use_button_held() {
    init_button_wrappers();
    if (!isdefined(self._use_button_think_threaded)) {
        self thread button_held_think(0);
        self._use_button_think_threaded = 1;
    }
    return self._holding_button[0];
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0x3767017c, Offset: 0x5898
// Size: 0x5c
function stance_button_held() {
    init_button_wrappers();
    if (!isdefined(self._stance_button_think_threaded)) {
        self thread button_held_think(1);
        self._stance_button_think_threaded = 1;
    }
    return self._holding_button[1];
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0xaf61f2b4, Offset: 0x5900
// Size: 0x5c
function ads_button_held() {
    init_button_wrappers();
    if (!isdefined(self._ads_button_think_threaded)) {
        self thread button_held_think(2);
        self._ads_button_think_threaded = 1;
    }
    return self._holding_button[2];
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0xe1499d6d, Offset: 0x5968
// Size: 0x5c
function attack_button_held() {
    init_button_wrappers();
    if (!isdefined(self._attack_button_think_threaded)) {
        self thread button_held_think(3);
        self._attack_button_think_threaded = 1;
    }
    return self._holding_button[3];
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0xdaa9629e, Offset: 0x59d0
// Size: 0x5c
function button_right_held() {
    init_button_wrappers();
    if (!isdefined(self._dpad_right_button_think_threaded)) {
        self thread button_held_think(6);
        self._dpad_right_button_think_threaded = 1;
    }
    return self._holding_button[6];
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0x89676a84, Offset: 0x5a38
// Size: 0x28
function waittill_use_button_pressed() {
    while (!self usebuttonpressed()) {
        waitframe(1);
    }
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0xc0738ec8, Offset: 0x5a68
// Size: 0x28
function waittill_use_button_held() {
    while (!self use_button_held()) {
        waitframe(1);
    }
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0x39c8d7e, Offset: 0x5a98
// Size: 0x28
function waittill_stance_button_pressed() {
    while (!self stancebuttonpressed()) {
        waitframe(1);
    }
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0x2c9e6e73, Offset: 0x5ac8
// Size: 0x28
function waittill_stance_button_held() {
    while (!self stance_button_held()) {
        waitframe(1);
    }
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0xa47f79a8, Offset: 0x5af8
// Size: 0x28
function waittill_attack_button_pressed() {
    while (!self attackbuttonpressed()) {
        waitframe(1);
    }
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0xf5555dea, Offset: 0x5b28
// Size: 0x28
function waittill_ads_button_pressed() {
    while (!self adsbuttonpressed()) {
        waitframe(1);
    }
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0xe9e93342, Offset: 0x5b58
// Size: 0x28
function waittill_vehicle_move_up_button_pressed() {
    while (!self vehiclemoveupbuttonpressed()) {
        waitframe(1);
    }
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0xf3a08dff, Offset: 0x5b88
// Size: 0xfe
function init_button_wrappers() {
    if (!isdefined(level._button_funcs)) {
        level._button_funcs[0] = &usebuttonpressed;
        level._button_funcs[2] = &adsbuttonpressed;
        level._button_funcs[3] = &attackbuttonpressed;
        level._button_funcs[1] = &stancebuttonpressed;
        level._button_funcs[6] = &actionslotfourbuttonpressed;
        /#
            level._button_funcs[4] = &up_button_pressed;
            level._button_funcs[5] = &down_button_pressed;
        #/
    }
}

/#

    // Namespace util/util_shared
    // Params 0, eflags: 0x0
    // Checksum 0xf3fccfd1, Offset: 0x5c90
    // Size: 0x66
    function up_button_held() {
        init_button_wrappers();
        if (!isdefined(self._up_button_think_threaded)) {
            self thread button_held_think(4);
            self._up_button_think_threaded = 1;
        }
        return self._holding_button[4];
    }

    // Namespace util/util_shared
    // Params 0, eflags: 0x0
    // Checksum 0x3e8f9159, Offset: 0x5d00
    // Size: 0x66
    function down_button_held() {
        init_button_wrappers();
        if (!isdefined(self._down_button_think_threaded)) {
            self thread button_held_think(5);
            self._down_button_think_threaded = 1;
        }
        return self._holding_button[5];
    }

    // Namespace util/util_shared
    // Params 0, eflags: 0x0
    // Checksum 0xa0667526, Offset: 0x5d70
    // Size: 0x44
    function up_button_pressed() {
        return self buttonpressed("<dev string:x750>") || self buttonpressed("<dev string:x758>");
    }

    // Namespace util/util_shared
    // Params 0, eflags: 0x0
    // Checksum 0xc1eed5c1, Offset: 0x5dc0
    // Size: 0x28
    function waittill_up_button_pressed() {
        while (!self up_button_pressed()) {
            waitframe(1);
        }
    }

    // Namespace util/util_shared
    // Params 0, eflags: 0x0
    // Checksum 0x5c0fed84, Offset: 0x5df0
    // Size: 0x44
    function down_button_pressed() {
        return self buttonpressed("<dev string:x760>") || self buttonpressed("<dev string:x76a>");
    }

    // Namespace util/util_shared
    // Params 0, eflags: 0x0
    // Checksum 0xd2f05101, Offset: 0x5e40
    // Size: 0x28
    function waittill_down_button_pressed() {
        while (!self down_button_pressed()) {
            waitframe(1);
        }
    }

#/

// Namespace util/util_shared
// Params 1, eflags: 0x0
// Checksum 0x25dcedbc, Offset: 0x5e70
// Size: 0xac
function freeze_player_controls(b_frozen) {
    if (!isdefined(b_frozen)) {
        b_frozen = 1;
    }
    if (isdefined(level.hostmigrationtimer)) {
        b_frozen = 1;
    }
    if (b_frozen || !level.gameended) {
        if (b_frozen) {
            self val::set("freeze_player_controls", "freezecontrols", 1);
            return;
        }
        self val::reset("freeze_player_controls", "freezecontrols");
    }
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0x302d576c, Offset: 0x5f28
// Size: 0x1e
function ishacked() {
    return isdefined(self.hacked) && self.hacked;
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0x46274d57, Offset: 0x5f50
// Size: 0x98
function getlastweapon() {
    last_weapon = undefined;
    if (isdefined(self.lastnonkillstreakweapon) && self hasweapon(self.lastnonkillstreakweapon)) {
        last_weapon = self.lastnonkillstreakweapon;
    } else if (isdefined(self.lastdroppableweapon) && self hasweapon(self.lastdroppableweapon)) {
        last_weapon = self.lastdroppableweapon;
    }
    return last_weapon;
}

// Namespace util/util_shared
// Params 1, eflags: 0x0
// Checksum 0x3b2ac00c, Offset: 0x5ff0
// Size: 0x90
function isenemyplayer(player) {
    /#
        assert(isdefined(player));
    #/
    if (!isplayer(player)) {
        return false;
    }
    if (level.teambased) {
        if (player.team == self.team) {
            return false;
        }
    } else if (player == self) {
        return false;
    }
    return true;
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0x412c0535, Offset: 0x6088
// Size: 0x30
function waittillslowprocessallowed() {
    while (level.lastslowprocessframe == gettime()) {
        waitframe(1);
    }
    level.lastslowprocessframe = gettime();
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0xbd041181, Offset: 0x60c0
// Size: 0x12
function get_start_time() {
    return getmicrosecondsraw();
}

// Namespace util/util_shared
// Params 2, eflags: 0x0
// Checksum 0x340731db, Offset: 0x60e0
// Size: 0x104
function note_elapsed_time(start_time, label) {
    if (!isdefined(label)) {
        label = "unspecified";
    }
    /#
        elapsed_time = get_elapsed_time(start_time, getmicrosecondsraw());
        if (!isdefined(start_time)) {
            return;
        }
        elapsed_time *= 0.001;
        if (!level.orbis) {
            elapsed_time = int(elapsed_time);
        }
        msg = label + "<dev string:x774>" + elapsed_time + "<dev string:x784>";
        profileprintln(msg);
        iprintln(msg);
    #/
}

// Namespace util/util_shared
// Params 2, eflags: 0x0
// Checksum 0x643c43a0, Offset: 0x61f0
// Size: 0xa2
function record_elapsed_time(start_time, &elapsed_time_array) {
    elapsed_time = get_elapsed_time(start_time, getmicrosecondsraw());
    if (!isdefined(elapsed_time_array)) {
        elapsed_time_array = [];
    } else if (!isarray(elapsed_time_array)) {
        elapsed_time_array = array(elapsed_time_array);
    }
    elapsed_time_array[elapsed_time_array.size] = elapsed_time;
}

// Namespace util/util_shared
// Params 2, eflags: 0x0
// Checksum 0xb3c06c52, Offset: 0x62a0
// Size: 0x2cc
function note_elapsed_times(&elapsed_time_array, label) {
    if (!isdefined(label)) {
        label = "unspecified";
    }
    /#
        if (!isarray(elapsed_time_array)) {
            return;
        }
        msg = label + "<dev string:x788>" + elapsed_time_array.size;
        profileprintln(msg);
        if (elapsed_time_array.size == 0) {
            return;
        }
        total_elapsed_time = 0;
        smallest_elapsed_time = 2147483647;
        largest_elapsed_time = 0;
        foreach (elapsed_time in elapsed_time_array) {
            elapsed_time *= 0.001;
            total_elapsed_time += elapsed_time;
            if (elapsed_time < smallest_elapsed_time) {
                smallest_elapsed_time = elapsed_time;
            }
            if (elapsed_time > largest_elapsed_time) {
                largest_elapsed_time = elapsed_time;
            }
            if (!level.orbis) {
                elapsed_time = int(elapsed_time);
            }
            msg = label + "<dev string:x774>" + elapsed_time + "<dev string:x784>";
            profileprintln(msg);
        }
        average_elapsed_time = total_elapsed_time / elapsed_time_array.size;
        msg = label + "<dev string:x793>" + average_elapsed_time + "<dev string:x784>";
        profileprintln(msg);
        iprintln(msg);
        msg = label + "<dev string:x7ab>" + largest_elapsed_time + "<dev string:x784>";
        profileprintln(msg);
        msg = label + "<dev string:x7c3>" + smallest_elapsed_time + "<dev string:x784>";
        profileprintln(msg);
    #/
}

// Namespace util/util_shared
// Params 2, eflags: 0x0
// Checksum 0x9889c6bf, Offset: 0x6578
// Size: 0x82
function get_elapsed_time(start_time, end_time) {
    if (!isdefined(end_time)) {
        end_time = getmicrosecondsraw();
    }
    if (!isdefined(start_time)) {
        return undefined;
    }
    elapsed_time = end_time - start_time;
    if (elapsed_time < 0) {
        elapsed_time += -2147483648;
    }
    return elapsed_time;
}

// Namespace util/util_shared
// Params 1, eflags: 0x0
// Checksum 0x181a13ba, Offset: 0x6608
// Size: 0x7c
function note_raw_time(label) {
    if (!isdefined(label)) {
        label = "unspecified";
    }
    now = getmicrosecondsraw();
    msg = "us = " + now + " -- " + label;
    profileprintln(msg);
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0x1f703c15, Offset: 0x6690
// Size: 0x52
function mayapplyscreeneffect() {
    /#
        assert(isdefined(self));
    #/
    /#
        assert(isplayer(self));
    #/
    return !isdefined(self.viewlockedentity);
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0xd1d2af80, Offset: 0x66f0
// Size: 0xa0
function waittillnotmoving() {
    if (self ishacked()) {
        waitframe(1);
        return;
    }
    if (self.classname == "grenade") {
        self waittill("stationary");
        return;
    }
    for (prevorigin = self.origin; true; prevorigin = self.origin) {
        wait 0.15;
        if (self.origin == prevorigin) {
            break;
        }
    }
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0xa5569e5c, Offset: 0x6798
// Size: 0x5a
function waittillrollingornotmoving() {
    if (self ishacked()) {
        waitframe(1);
        return "stationary";
    }
    movestate = self waittill("stationary", "rolling");
    return movestate._notify;
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0xf4b0544d, Offset: 0x6800
// Size: 0x4c
function function_bc37a245() {
    if (sessionmodeiscampaigngame()) {
        return "gamedata/stats/cp/cp_statstable.csv";
    }
    if (sessionmodeiszombiesgame()) {
        return "gamedata/stats/zm/zm_statstable.csv";
    }
    return "gamedata/stats/mp/mp_statstable.csv";
}

// Namespace util/util_shared
// Params 1, eflags: 0x0
// Checksum 0x777a663, Offset: 0x6858
// Size: 0x17a
function getweaponclass(weapon) {
    if (weapon == level.weaponnone) {
        return undefined;
    }
    if (!weapon.isvalid) {
        return undefined;
    }
    if (!isdefined(level.weaponclassarray)) {
        level.weaponclassarray = [];
    }
    if (isdefined(level.weaponclassarray[weapon])) {
        return level.weaponclassarray[weapon];
    }
    baseweaponparam = [[ level.var_2453cf4a ]](weapon);
    baseweaponindex = getbaseweaponitemindex(baseweaponparam);
    weaponclass = "";
    if (sessionmodeismultiplayergame()) {
        weaponinfo = getunlockableiteminfofromindex(baseweaponindex);
        if (isdefined(weaponinfo)) {
            weaponclass = weaponinfo.itemgroupname;
        }
    } else {
        weaponclass = tablelookup(function_bc37a245(), 0, baseweaponindex, 2);
    }
    level.weaponclassarray[weapon] = weaponclass;
    return weaponclass;
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0x9d9b9b15, Offset: 0x69e0
// Size: 0x10
function isusingremote() {
    return isdefined(self.usingremote);
}

// Namespace util/util_shared
// Params 1, eflags: 0x0
// Checksum 0x64479e46, Offset: 0x69f8
// Size: 0x84
function deleteaftertime(time) {
    /#
        assert(isdefined(self));
    #/
    /#
        assert(isdefined(time));
    #/
    /#
        assert(time >= 0.05);
    #/
    self thread deleteaftertimethread(time);
}

// Namespace util/util_shared
// Params 1, eflags: 0x0
// Checksum 0xcc40778d, Offset: 0x6a88
// Size: 0x34
function deleteaftertimethread(time) {
    self endon(#"death");
    wait time;
    self delete();
}

// Namespace util/util_shared
// Params 1, eflags: 0x0
// Checksum 0xfc66ed00, Offset: 0x6ac8
// Size: 0x3a
function waitfortime(time) {
    if (!isdefined(time)) {
        time = 0;
    }
    if (time > 0) {
        wait time;
    }
}

// Namespace util/util_shared
// Params 1, eflags: 0x0
// Checksum 0x1f30f30a, Offset: 0x6b10
// Size: 0x8c
function waitfortimeandnetworkframe(time) {
    if (!isdefined(time)) {
        time = 0;
    }
    start_time_ms = gettime();
    wait_network_frame();
    elapsed_time = (gettime() - start_time_ms) * 0.001;
    remaining_time = time - elapsed_time;
    if (remaining_time > 0) {
        wait remaining_time;
    }
}

// Namespace util/util_shared
// Params 1, eflags: 0x0
// Checksum 0xb45ecbc8, Offset: 0x6ba8
// Size: 0x54
function deleteaftertimeandnetworkframe(time) {
    /#
        assert(isdefined(self));
    #/
    waitfortimeandnetworkframe(time);
    self delete();
}

/#

    // Namespace util/util_shared
    // Params 7, eflags: 0x0
    // Checksum 0x6313f56b, Offset: 0x6c08
    // Size: 0x84
    function drawcylinder(pos, rad, height, duration, stop_notify, color, alpha) {
        if (!isdefined(duration)) {
            duration = 0;
        }
        level thread drawcylinder_think(pos, rad, height, duration, stop_notify, color, alpha);
    }

    // Namespace util/util_shared
    // Params 7, eflags: 0x0
    // Checksum 0xe98cf71, Offset: 0x6c98
    // Size: 0x310
    function drawcylinder_think(pos, rad, height, seconds, stop_notify, color, alpha) {
        if (isdefined(stop_notify)) {
            level endon(stop_notify);
        }
        stop_time = gettime() + seconds * 1000;
        currad = rad;
        curheight = height;
        if (!isdefined(color)) {
            color = (1, 1, 1);
        }
        if (!isdefined(alpha)) {
            alpha = 1;
        }
        for (;;) {
            if (seconds > 0 && stop_time <= gettime()) {
                return;
            }
            for (r = 0; r < 20; r++) {
                theta = r / 20 * 360;
                theta2 = (r + 1) / 20 * 360;
                line(pos + (cos(theta) * currad, sin(theta) * currad, 0), pos + (cos(theta2) * currad, sin(theta2) * currad, 0), color, alpha);
                line(pos + (cos(theta) * currad, sin(theta) * currad, curheight), pos + (cos(theta2) * currad, sin(theta2) * currad, curheight), color, alpha);
                line(pos + (cos(theta) * currad, sin(theta) * currad, 0), pos + (cos(theta) * currad, sin(theta) * currad, curheight), color, alpha);
            }
            waitframe(1);
        }
    }

#/

// Namespace util/util_shared
// Params 1, eflags: 0x0
// Checksum 0x125abd39, Offset: 0x6fb0
// Size: 0xec
function function_c664826a(str_teamname) {
    str_teamname = get_team_mapping(str_teamname);
    var_8461c9aa = spawn_array_struct();
    if (isdefined(str_teamname) && isdefined(level.aliveplayers) && isdefined(level.aliveplayers[str_teamname])) {
        for (i = 0; i < level.aliveplayers[str_teamname].size; i++) {
            var_8461c9aa.a[var_8461c9aa.a.size] = level.aliveplayers[str_teamname][i];
        }
    }
    return var_8461c9aa;
}

// Namespace util/util_shared
// Params 1, eflags: 0x0
// Checksum 0xb635142, Offset: 0x70a8
// Size: 0x18e
function function_a791434c(var_6a1bc72e) {
    var_6a1bc72e = get_team_mapping(var_6a1bc72e);
    var_8461c9aa = spawn_array_struct();
    if (isdefined(var_6a1bc72e) && isdefined(level.aliveplayers)) {
        foreach (str_team in level.teams) {
            if (str_team == var_6a1bc72e) {
                continue;
            }
            foreach (player in level.aliveplayers[str_team]) {
                var_8461c9aa.a[var_8461c9aa.a.size] = player;
            }
        }
    }
    return var_8461c9aa;
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0x4b91b6a8, Offset: 0x7240
// Size: 0x10a
function function_1edbd8() {
    var_93bfc6ee = spawn_array_struct();
    if (isdefined(level.aliveplayers)) {
        keys = getarraykeys(level.aliveplayers);
        for (i = 0; i < keys.size; i++) {
            team = keys[i];
            for (j = 0; j < level.aliveplayers[team].size; j++) {
                var_93bfc6ee.a[var_93bfc6ee.a.size] = level.aliveplayers[team][j];
            }
        }
    }
    return var_93bfc6ee;
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0x40d9a99c, Offset: 0x7358
// Size: 0x34
function spawn_array_struct() {
    s = spawnstruct();
    s.a = [];
    return s;
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0x4b4fde6f, Offset: 0x7398
// Size: 0x74
function gethostplayer() {
    players = getplayers();
    for (index = 0; index < players.size; index++) {
        if (players[index] ishost()) {
            return players[index];
        }
    }
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0xc735b5fb, Offset: 0x7418
// Size: 0x74
function gethostplayerforbots() {
    players = getplayers();
    for (index = 0; index < players.size; index++) {
        if (players[index] ishostforbots()) {
            return players[index];
        }
    }
}

// Namespace util/util_shared
// Params 5, eflags: 0x0
// Checksum 0x8fad5a1d, Offset: 0x7498
// Size: 0x328
function get_array_of_closest(org, array, excluders, max, maxdist) {
    if (!isdefined(max)) {
        max = array.size;
    }
    if (!isdefined(excluders)) {
        excluders = [];
    }
    maxdists2rd = undefined;
    if (isdefined(maxdist)) {
        maxdists2rd = maxdist * maxdist;
    }
    dist = [];
    index = [];
    for (i = 0; i < array.size; i++) {
        if (!isdefined(array[i])) {
            continue;
        }
        if (isinarray(excluders, array[i])) {
            continue;
        }
        if (isvec(array[i])) {
            length = distancesquared(org, array[i]);
        } else {
            length = distancesquared(org, array[i].origin);
        }
        if (isdefined(maxdists2rd) && maxdists2rd < length) {
            continue;
        }
        dist[dist.size] = length;
        index[index.size] = i;
    }
    for (;;) {
        change = 0;
        for (i = 0; i < dist.size - 1; i++) {
            if (dist[i] <= dist[i + 1]) {
                continue;
            }
            change = 1;
            temp = dist[i];
            dist[i] = dist[i + 1];
            dist[i + 1] = temp;
            temp = index[i];
            index[i] = index[i + 1];
            index[i + 1] = temp;
        }
        if (!change) {
            break;
        }
    }
    newarray = [];
    if (max > dist.size) {
        max = dist.size;
    }
    for (i = 0; i < max; i++) {
        newarray[i] = array[index[i]];
    }
    return newarray;
}

// Namespace util/util_shared
// Params 1, eflags: 0x0
// Checksum 0xe8bdf691, Offset: 0x77c8
// Size: 0x154
function set_lighting_state(n_state) {
    if (isdefined(n_state)) {
        self.lighting_state = n_state;
    } else {
        self.lighting_state = level.lighting_state;
    }
    if (isdefined(self.lighting_state)) {
        if (self == level) {
            if (isdefined(level.activeplayers)) {
                foreach (player in level.activeplayers) {
                    player set_lighting_state(level.lighting_state);
                }
            }
            return;
        }
        if (isplayer(self)) {
            self setlightingstate(self.lighting_state);
            return;
        }
        /#
            assertmsg("<dev string:x7dc>");
        #/
    }
}

// Namespace util/util_shared
// Params 1, eflags: 0x0
// Checksum 0x94e083f9, Offset: 0x7928
// Size: 0x154
function set_sun_shadow_split_distance(f_distance) {
    if (isdefined(f_distance)) {
        self.sun_shadow_split_distance = f_distance;
    } else {
        self.sun_shadow_split_distance = level.sun_shadow_split_distance;
    }
    if (isdefined(self.sun_shadow_split_distance)) {
        if (self == level) {
            if (isdefined(level.activeplayers)) {
                foreach (player in level.activeplayers) {
                    player set_sun_shadow_split_distance(level.sun_shadow_split_distance);
                }
            }
            return;
        }
        if (isplayer(self)) {
            self setsunshadowsplitdistance(self.sun_shadow_split_distance);
            return;
        }
        /#
            assertmsg("<dev string:x80e>");
        #/
    }
}

// Namespace util/util_shared
// Params 4, eflags: 0x0
// Checksum 0x12bad319, Offset: 0x7a88
// Size: 0x4d4
function auto_delete(n_mode, n_min_time_alive, n_dist_horizontal, n_dist_vertical) {
    if (!isdefined(n_mode)) {
        n_mode = 1;
    }
    if (!isdefined(n_min_time_alive)) {
        n_min_time_alive = 0;
    }
    if (!isdefined(n_dist_horizontal)) {
        n_dist_horizontal = 0;
    }
    if (!isdefined(n_dist_vertical)) {
        n_dist_vertical = 0;
    }
    self endon(#"death");
    self notify(#"__auto_delete__");
    self endon(#"__auto_delete__");
    level flag::wait_till("all_players_spawned");
    if (isdefined(level.heroes) && isinarray(level.heroes, self)) {
        return;
    }
    if (n_mode & 16 || n_mode == 1 || n_mode == 8) {
        n_mode |= 2;
        n_mode |= 4;
    }
    n_think_time = 1;
    n_tests_to_do = 2;
    n_dot_check = 0;
    if (n_mode & 16) {
        n_think_time = 0.2;
        n_tests_to_do = 1;
        n_dot_check = 0.4;
    }
    n_test_count = 0;
    n_dist_horizontal_sq = n_dist_horizontal * n_dist_horizontal;
    while (true) {
        do {
            wait randomfloatrange(n_think_time - n_think_time / 3, n_think_time + n_think_time / 3);
        } while (isdefined(self.birthtime) && (gettime() - self.birthtime) / 1000 < n_min_time_alive);
        n_tests_passed = 0;
        foreach (player in level.players) {
            if (n_dist_horizontal && distance2dsquared(self.origin, player.origin) < n_dist_horizontal_sq) {
                continue;
            }
            if (n_dist_vertical && abs(self.origin[2] - player.origin[2]) < n_dist_vertical) {
                continue;
            }
            v_eye = player geteye();
            b_behind = 0;
            if (n_mode & 2) {
                v_facing = anglestoforward(player getplayerangles());
                v_to_ent = vectornormalize(self.origin - v_eye);
                n_dot = vectordot(v_facing, v_to_ent);
                if (n_dot < n_dot_check) {
                    b_behind = 1;
                    if (!(n_mode & 1)) {
                        n_tests_passed++;
                        continue;
                    }
                }
            }
            if (n_mode & 4) {
                if (!self sightconetrace(v_eye, player)) {
                    if (b_behind || !(n_mode & 1)) {
                        n_tests_passed++;
                    }
                }
            }
        }
        if (n_tests_passed == level.players.size) {
            n_test_count++;
            if (n_test_count < n_tests_to_do) {
                continue;
            }
            self notify(#"_disable_reinforcement");
            self delete();
            continue;
        }
        n_test_count = 0;
    }
}

// Namespace util/util_shared
// Params 5, eflags: 0x0
// Checksum 0x7f67e2eb, Offset: 0x7f68
// Size: 0x48a
function query_ents(&a_kvps_match, b_match_all, &a_kvps_ingnore, b_ignore_spawners, b_match_substrings) {
    if (!isdefined(b_match_all)) {
        b_match_all = 1;
    }
    if (!isdefined(b_ignore_spawners)) {
        b_ignore_spawners = 0;
    }
    if (!isdefined(b_match_substrings)) {
        b_match_substrings = 0;
    }
    a_ret = [];
    if (b_match_substrings) {
        a_all_ents = arraycombine(getentarray(), level.struct, 0, 0);
        b_first = 1;
        foreach (k, v in a_kvps_match) {
            a_ents = _query_ents_by_substring_helper(a_all_ents, v, k, b_ignore_spawners);
            if (b_first) {
                a_ret = a_ents;
                b_first = 0;
                continue;
            }
            if (b_match_all) {
                a_ret = arrayintersect(a_ret, a_ents);
                continue;
            }
            a_ret = arraycombine(a_ret, a_ents, 0, 0);
        }
        if (isdefined(a_kvps_ingnore)) {
            foreach (k, v in a_kvps_ingnore) {
                a_ents = _query_ents_by_substring_helper(a_all_ents, v, k, b_ignore_spawners);
                a_ret = array::exclude(a_ret, a_ents);
            }
        }
    } else {
        b_first = 1;
        foreach (k, v in a_kvps_match) {
            a_ents = arraycombine(getentarray(v, k, b_ignore_spawners), struct::get_array(v, k), 0, 0);
            if (b_first) {
                a_ret = a_ents;
                b_first = 0;
                continue;
            }
            if (b_match_all) {
                a_ret = arrayintersect(a_ret, a_ents);
                continue;
            }
            a_ret = arraycombine(a_ret, a_ents, 0, 0);
        }
        if (isdefined(a_kvps_ingnore)) {
            foreach (k, v in a_kvps_ingnore) {
                a_ents = arraycombine(getentarray(v, k, b_ignore_spawners), struct::get_array(v, k), 0, 0);
                a_ret = array::exclude(a_ret, a_ents);
            }
        }
    }
    return a_ret;
}

// Namespace util/util_shared
// Params 4, eflags: 0x0
// Checksum 0x4cdcf504, Offset: 0x8400
// Size: 0x19c
function _query_ents_by_substring_helper(&a_ents, str_value, str_key, b_ignore_spawners) {
    if (!isdefined(str_key)) {
        str_key = "targetname";
    }
    if (!isdefined(b_ignore_spawners)) {
        b_ignore_spawners = 0;
    }
    a_ret = [];
    foreach (ent in a_ents) {
        if (b_ignore_spawners && isspawner(ent)) {
            continue;
        }
        if (isstring(ent.(str_key)) && issubstr(ent.(str_key), str_value)) {
            if (!isdefined(a_ret)) {
                a_ret = [];
            } else if (!isarray(a_ret)) {
                a_ret = array(a_ret);
            }
            a_ret[a_ret.size] = ent;
        }
    }
    return a_ret;
}

// Namespace util/util_shared
// Params 1, eflags: 0x0
// Checksum 0xa4e22682, Offset: 0x85a8
// Size: 0x34e
function get_weapon_by_name(weapon_name) {
    split = strtok(weapon_name, "+");
    switch (split.size) {
    case 1:
    default:
        weapon = getweapon(split[0]);
        break;
    case 2:
        weapon = getweapon(split[0], split[1]);
        break;
    case 3:
        weapon = getweapon(split[0], split[1], split[2]);
        break;
    case 4:
        weapon = getweapon(split[0], split[1], split[2], split[3]);
        break;
    case 5:
        weapon = getweapon(split[0], split[1], split[2], split[3], split[4]);
        break;
    case 6:
        weapon = getweapon(split[0], split[1], split[2], split[3], split[4], split[5]);
        break;
    case 7:
        weapon = getweapon(split[0], split[1], split[2], split[3], split[4], split[5], split[6]);
        break;
    case 8:
        weapon = getweapon(split[0], split[1], split[2], split[3], split[4], split[5], split[6], split[7]);
        break;
    case 9:
        weapon = getweapon(split[0], split[1], split[2], split[3], split[4], split[5], split[6], split[7], split[8]);
        break;
    }
    return weapon;
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0x6d79ab2, Offset: 0x8900
// Size: 0x72
function is_female() {
    gender = self getplayergendertype(currentsessionmode());
    b_female = 0;
    if (isdefined(gender) && gender == "female") {
        b_female = 1;
    }
    return b_female;
}

// Namespace util/util_shared
// Params 6, eflags: 0x0
// Checksum 0x991b9c5f, Offset: 0x8980
// Size: 0x196
function positionquery_pointarray(origin, minsearchradius, maxsearchradius, halfheight, innerspacing, reachableby_ent) {
    if (isdefined(reachableby_ent)) {
        queryresult = positionquery_source_navigation(origin, minsearchradius, maxsearchradius, halfheight, innerspacing, reachableby_ent);
    } else {
        queryresult = positionquery_source_navigation(origin, minsearchradius, maxsearchradius, halfheight, innerspacing);
    }
    pointarray = [];
    foreach (pointstruct in queryresult.data) {
        if (!isdefined(pointarray)) {
            pointarray = [];
        } else if (!isarray(pointarray)) {
            pointarray = array(pointarray);
        }
        pointarray[pointarray.size] = pointstruct.origin;
    }
    return pointarray;
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0x1d369b0, Offset: 0x8b20
// Size: 0xaa
function totalplayercount() {
    count = 0;
    foreach (team in level.teams) {
        count += level.playercount[team];
    }
    return count;
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0xadc06ce6, Offset: 0x8bd8
// Size: 0x1e
function isrankenabled() {
    return isdefined(level.rankenabled) && level.rankenabled;
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0xa7d7b114, Offset: 0x8c00
// Size: 0x20
function isoneround() {
    if (level.roundlimit <= 1) {
        return true;
    }
    return false;
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0x77edec75, Offset: 0x8c28
// Size: 0x32
function isfirstround() {
    if (level.roundlimit > 1 && game.roundsplayed == 0) {
        return true;
    }
    return false;
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0xb6ade9c6, Offset: 0x8c68
// Size: 0x42
function islastround() {
    if (level.roundlimit > 1 && game.roundsplayed >= level.roundlimit - 1) {
        return true;
    }
    return false;
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0x2b696725, Offset: 0x8cb8
// Size: 0xbe
function waslastround() {
    if (level.forcedend) {
        return true;
    }
    if (isdefined(level.shouldplayovertimeround)) {
        if ([[ level.shouldplayovertimeround ]]()) {
            level.nextroundisovertime = 1;
            return false;
        } else if (isdefined(game.overtime_round)) {
            return true;
        }
    }
    if (hitroundlimit() || hitscorelimit() || hitroundwinlimit()) {
        return true;
    }
    return false;
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0xcd90b312, Offset: 0x8d80
// Size: 0x38
function hitroundlimit() {
    if (level.roundlimit <= 0) {
        return false;
    }
    return getroundsplayed() >= level.roundlimit;
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0xaa58d70a, Offset: 0x8dc0
// Size: 0xaa
function anyteamhitroundwinlimit() {
    foreach (team in level.teams) {
        if (getroundswon(team) >= level.roundwinlimit) {
            return true;
        }
    }
    return false;
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0xff15682c, Offset: 0x8e78
// Size: 0xd6
function anyteamhitroundlimitwithdraws() {
    tie_wins = game.stat["roundswon"]["tie"];
    foreach (team in level.teams) {
        if (getroundswon(team) + tie_wins >= level.roundwinlimit) {
            return true;
        }
    }
    return false;
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0x1d71b86a, Offset: 0x8f58
// Size: 0x124
function function_daaaa3c1() {
    var_43ba493d = 0;
    winning_team = undefined;
    foreach (team in level.teams) {
        wins = getroundswon(team);
        if (!isdefined(winning_team)) {
            var_43ba493d = wins;
            winning_team = team;
            continue;
        }
        if (wins == var_43ba493d) {
            winning_team = "tie";
            continue;
        }
        if (wins > var_43ba493d) {
            var_43ba493d = wins;
            winning_team = team;
        }
    }
    return winning_team;
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0x3753178, Offset: 0x9088
// Size: 0x88
function hitroundwinlimit() {
    if (!isdefined(level.roundwinlimit) || level.roundwinlimit <= 0) {
        return false;
    }
    if (anyteamhitroundwinlimit()) {
        return true;
    }
    if (anyteamhitroundlimitwithdraws()) {
        if (function_daaaa3c1() != "tie") {
            return true;
        }
    }
    return false;
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0xc71b9a94, Offset: 0x9118
// Size: 0xae
function any_team_hit_score_limit() {
    foreach (team in level.teams) {
        if (game.stat["teamScores"][team] >= level.scorelimit) {
            return true;
        }
    }
    return false;
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0x7889c7f3, Offset: 0x91d0
// Size: 0xea
function hitscorelimit() {
    if (level.scoreroundwinbased) {
        return false;
    }
    if (level.scorelimit <= 0) {
        return false;
    }
    if (level.teambased) {
        if (any_team_hit_score_limit()) {
            return true;
        }
    } else {
        for (i = 0; i < level.players.size; i++) {
            player = level.players[i];
            if (isdefined(player.pointstowin) && player.pointstowin >= level.scorelimit) {
                return true;
            }
        }
    }
    return false;
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0x949c808a, Offset: 0x92c8
// Size: 0x22
function get_current_round_score_limit() {
    return level.roundscorelimit * (game.roundsplayed + 1);
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0xbe9b94c6, Offset: 0x92f8
// Size: 0xc2
function any_team_hit_round_score_limit() {
    round_score_limit = get_current_round_score_limit();
    foreach (team in level.teams) {
        if (game.stat["teamScores"][team] >= round_score_limit) {
            return true;
        }
    }
    return false;
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0x26d328bc, Offset: 0x93c8
// Size: 0xea
function hitroundscorelimit() {
    if (level.roundscorelimit <= 0) {
        return false;
    }
    if (level.teambased) {
        if (any_team_hit_round_score_limit()) {
            return true;
        }
    } else {
        roundscorelimit = get_current_round_score_limit();
        for (i = 0; i < level.players.size; i++) {
            player = level.players[i];
            if (isdefined(player.pointstowin) && player.pointstowin >= roundscorelimit) {
                return true;
            }
        }
    }
    return false;
}

// Namespace util/util_shared
// Params 1, eflags: 0x0
// Checksum 0xcb7f5ecb, Offset: 0x94c0
// Size: 0x42
function getroundswon(str_team) {
    str_team = get_team_mapping(str_team);
    return game.stat["roundswon"][str_team];
}

// Namespace util/util_shared
// Params 1, eflags: 0x0
// Checksum 0x8b6272f8, Offset: 0x9510
// Size: 0xe8
function getotherteamsroundswon(str_skip_team) {
    str_skip_team = get_team_mapping(str_skip_team);
    roundswon = 0;
    foreach (str_team in level.teams) {
        if (str_team == str_skip_team) {
            continue;
        }
        roundswon += game.stat["roundswon"][str_team];
    }
    return roundswon;
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0x1979f42c, Offset: 0x9600
// Size: 0xe
function getroundsplayed() {
    return game.roundsplayed;
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0x9a54fdbc, Offset: 0x9618
// Size: 0x34
function isroundbased() {
    if (level.roundlimit != 1 && level.roundwinlimit != 1) {
        return true;
    }
    return false;
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0x93f643dc, Offset: 0x9658
// Size: 0x2e
function getcurrentgamemode() {
    if (gamemodeismode(6)) {
        return "leaguematch";
    }
    return "publicmatch";
}

// Namespace util/util_shared
// Params 6, eflags: 0x0
// Checksum 0xc95233a3, Offset: 0x9690
// Size: 0x13c
function ground_position(v_start, n_max_dist, n_ground_offset, e_ignore, b_ignore_water, b_ignore_glass) {
    if (!isdefined(n_max_dist)) {
        n_max_dist = 5000;
    }
    if (!isdefined(n_ground_offset)) {
        n_ground_offset = 0;
    }
    if (!isdefined(b_ignore_water)) {
        b_ignore_water = 0;
    }
    if (!isdefined(b_ignore_glass)) {
        b_ignore_glass = 0;
    }
    v_trace_start = v_start + (0, 0, 5);
    v_trace_end = v_trace_start + (0, 0, (n_max_dist + 5) * -1);
    a_trace = groundtrace(v_trace_start, v_trace_end, 0, e_ignore, b_ignore_water, b_ignore_glass);
    if (a_trace["surfacetype"] != "none") {
        return (a_trace["position"] + (0, 0, n_ground_offset));
    }
    return v_start;
}

// Namespace util/util_shared
// Params 2, eflags: 0x0
// Checksum 0xcc2b77f1, Offset: 0x97d8
// Size: 0x2c
function delayed_notify(str_notify, f_delay_seconds) {
    wait f_delay_seconds;
    if (isdefined(self)) {
        self notify(str_notify);
    }
}

// Namespace util/util_shared
// Params 1, eflags: 0x0
// Checksum 0x501d8f49, Offset: 0x9810
// Size: 0x6c
function delayed_delete(f_delay_seconds) {
    /#
        assert(isentity(self));
    #/
    wait f_delay_seconds;
    if (isdefined(self) && isentity(self)) {
        self delete();
    }
}

// Namespace util/util_shared
// Params 1, eflags: 0x0
// Checksum 0xbf7b31bc, Offset: 0x9888
// Size: 0x14c
function function_46d3a558(mode) {
    if (!isdefined(mode)) {
        mode = 1;
    }
    level.chyron_text_active = 1;
    level flagsys::set("chyron_active");
    music::setmusicstate("cp_load_exit");
    foreach (player in level.players) {
        if (!player isbot()) {
            player thread function_be5e647c(mode);
        }
    }
    level waittill("chyron_menu_closed");
    level.chyron_text_active = undefined;
    level flagsys::clear("chyron_active");
}

// Namespace util/util_shared
// Params 1, eflags: 0x0
// Checksum 0xcecc78e7, Offset: 0x99e0
// Size: 0x2b4
function function_be5e647c(mode) {
    self endon(#"disconnect");
    var_c2dc2b72 = self openluimenu("CPChyron");
    self setluimenudata(var_c2dc2b72, "mapMode", mode);
    self val::set("chyron", "takedamage", 0);
    self val::set("chyron", "freezecontrols", 1);
    waittillframeend();
    if (self flagsys::get("kill_fullscreen_black")) {
        self closemenu("InitialBlack");
        self openmenu("InitialBlack");
    }
    self flagsys::set("chyron_menu_open");
    level notify(#"chyron_menu_open");
    self thread function_5aa3b9f4();
    do {
        waitresult = self waittill("menuresponse");
        menu = waitresult.menu;
        response = waitresult.response;
    } while (menu != "CPChyron" || response != "closed");
    self notify(#"chyron_menu_closed");
    level notify(#"chyron_menu_closed");
    self flagsys::clear("chyron_menu_open");
    waitframe(1);
    level flagsys::wait_till_clear("waitting_for_igc_ready");
    self closemenu("InitialBlack");
    self val::reset("chyron", "takedamage");
    self val::reset("chyron", "freezecontrols");
    wait 5;
    self closeluimenu(var_c2dc2b72);
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0x2eee0460, Offset: 0x9ca0
// Size: 0x6c
function function_5aa3b9f4() {
    self endon(#"disconnect");
    self val::set("chyron", "freezecontrols", 1);
    self waittill("chyron_menu_closed");
    self val::reset("chyron", "freezecontrols");
}

// Namespace util/util_shared
// Params 1, eflags: 0x0
// Checksum 0xac27d072, Offset: 0x9d18
// Size: 0x2e
function function_3eb32a89(str_next_map) {
    switch (str_next_map) {
    case #"cp_mi_sing_biodomes":
    case #"cp_mi_sing_blackstation":
    case #"cp_mi_sing_sgen":
        return "cp_sh_singapore";
    case #"cp_mi_cairo_aquifer":
    case #"cp_mi_cairo_infection":
    case #"cp_mi_cairo_lotus":
        return "cp_sh_cairo";
    default:
        return "cp_sh_mobile";
    }
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0x325a95e3, Offset: 0x9d90
// Size: 0x70
function is_safehouse() {
    mapname = tolower(getdvarstring("mapname"));
    if (mapname == "cp_sh_cairo" || mapname == "cp_sh_mobile" || mapname == "cp_sh_singapore") {
        return true;
    }
    return false;
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0x1283ed7f, Offset: 0x9e08
// Size: 0x44
function is_new_cp_map() {
    mapname = tolower(getdvarstring("mapname"));
    switch (mapname) {
    default:
        return false;
    }
}

/#

    // Namespace util/util_shared
    // Params 1, eflags: 0x0
    // Checksum 0x2887165a, Offset: 0x9e68
    // Size: 0x64
    function add_queued_debug_command(cmd) {
        if (!isdefined(level.dbg_cmd_queue)) {
            level thread queued_debug_commands();
        }
        if (isdefined(level.dbg_cmd_queue)) {
            array::push(level.dbg_cmd_queue, cmd, 0);
        }
    }

    // Namespace util/util_shared
    // Params 0, eflags: 0x0
    // Checksum 0xb205d12c, Offset: 0x9ed8
    // Size: 0xb8
    function queued_debug_commands() {
        self notify(#"queued_debug_commands");
        self endon(#"queued_debug_commands");
        if (!isdefined(level.dbg_cmd_queue)) {
            level.dbg_cmd_queue = [];
        }
        while (true) {
            waitframe(1);
            if (level.dbg_cmd_queue.size == 0) {
                level.dbg_cmd_queue = undefined;
                return;
            }
            cmd = array::pop_front(level.dbg_cmd_queue, 0);
            adddebugcommand(cmd);
        }
    }

#/

// Namespace util/util_shared
// Params 1, eflags: 0x0
// Checksum 0xcc5c7e7a, Offset: 0x9f98
// Size: 0x42
function array_copy_if_array(any_var) {
    return isarray(any_var) ? arraycopy(any_var) : any_var;
}

// Namespace util/util_shared
// Params 1, eflags: 0x0
// Checksum 0xc2d5990c, Offset: 0x9fe8
// Size: 0x6a
function is_item_purchased(ref) {
    itemindex = getitemindexfromref(ref);
    return itemindex < 0 || itemindex >= 256 ? 0 : self isitempurchased(itemindex);
}

// Namespace util/util_shared
// Params 1, eflags: 0x0
// Checksum 0x23ebf1fd, Offset: 0xa060
// Size: 0x3a
function has_purchased_perk_equipped(ref) {
    return self hasperk(ref) && self is_item_purchased(ref);
}

// Namespace util/util_shared
// Params 2, eflags: 0x0
// Checksum 0xf8cb817, Offset: 0xa0a8
// Size: 0x64
function has_purchased_perk_equipped_with_specific_stat(single_perk_ref, stats_table_ref) {
    if (isplayer(self)) {
        return (self hasperk(single_perk_ref) && self is_item_purchased(stats_table_ref));
    }
    return 0;
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0x703d55e4, Offset: 0xa118
// Size: 0x1a
function has_flak_jacket_perk_purchased_and_equipped() {
    return has_purchased_perk_equipped("specialty_flakjacket");
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0x6082f181, Offset: 0xa140
// Size: 0x2a
function has_blind_eye_perk_purchased_and_equipped() {
    return self has_purchased_perk_equipped_with_specific_stat("specialty_nottargetedbyairsupport", "specialty_nottargetedbyairsupport|specialty_nokillstreakreticle");
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0x32ab7e81, Offset: 0xa178
// Size: 0x1a
function has_ghost_perk_purchased_and_equipped() {
    return has_purchased_perk_equipped("specialty_gpsjammer");
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0x71c6cae4, Offset: 0xa1a0
// Size: 0x2a
function has_tactical_mask_purchased_and_equipped() {
    return self has_purchased_perk_equipped_with_specific_stat("specialty_stunprotection", "specialty_stunprotection|specialty_flashprotection|specialty_proximityprotection");
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0xcab634ff, Offset: 0xa1d8
// Size: 0x2a
function has_hacker_perk_purchased_and_equipped() {
    return self has_purchased_perk_equipped_with_specific_stat("specialty_showenemyequipment", "specialty_showenemyequipment|specialty_showscorestreakicons|specialty_showenemyvehicles");
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0x6db5a0f6, Offset: 0xa210
// Size: 0x2a
function has_cold_blooded_perk_purchased_and_equipped() {
    return self has_purchased_perk_equipped_with_specific_stat("specialty_nottargetedbyaitank", "specialty_nottargetedbyaitank|specialty_nottargetedbyraps|specialty_nottargetedbysentry|specialty_nottargetedbyrobot|specialty_immunenvthermal");
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0x98d2c99c, Offset: 0xa248
// Size: 0x2a
function has_hard_wired_perk_purchased_and_equipped() {
    return self has_purchased_perk_equipped_with_specific_stat("specialty_immunecounteruav", "specialty_immunecounteruav|specialty_immuneemp|specialty_immunetriggerc4|specialty_immunetriggershock|specialty_immunetriggerbetty|specialty_sixthsensejammer|specialty_trackerjammer|specialty_immunesmoke");
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0x85370d2f, Offset: 0xa280
// Size: 0x2a
function has_gung_ho_perk_purchased_and_equipped() {
    return self has_purchased_perk_equipped_with_specific_stat("specialty_sprintfire", "specialty_sprintfire|specialty_sprintgrenadelethal|specialty_sprintgrenadetactical|specialty_sprintequipment");
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0xf1075ecc, Offset: 0xa2b8
// Size: 0x2a
function has_fast_hands_perk_purchased_and_equipped() {
    return self has_purchased_perk_equipped_with_specific_stat("specialty_fastweaponswitch", "specialty_fastweaponswitch|specialty_sprintrecovery|specialty_sprintfirerecovery");
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0x38a4a87d, Offset: 0xa2f0
// Size: 0x1a
function has_scavenger_perk_purchased_and_equipped() {
    return has_purchased_perk_equipped("specialty_scavenger");
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0xae14fcdc, Offset: 0xa318
// Size: 0x2a
function has_jetquiet_perk_purchased_and_equipped() {
    return self has_purchased_perk_equipped_with_specific_stat("specialty_jetquiet", "specialty_jetnoradar|specialty_jetquiet");
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0x6030bf46, Offset: 0xa350
// Size: 0x1a
function has_awareness_perk_purchased_and_equipped() {
    return has_purchased_perk_equipped("specialty_loudenemies");
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0xc19695ed, Offset: 0xa378
// Size: 0x1a
function has_ninja_perk_purchased_and_equipped() {
    return has_purchased_perk_equipped("specialty_quieter");
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0x4db8db2c, Offset: 0xa3a0
// Size: 0x1a
function has_toughness_perk_purchased_and_equipped() {
    return has_purchased_perk_equipped("specialty_bulletflinch");
}

// Namespace util/util_shared
// Params 1, eflags: 0x0
// Checksum 0x911c086f, Offset: 0xa3c8
// Size: 0x58
function str_strip_lh(str) {
    if (strendswith(str, "_lh")) {
        return getsubstr(str, 0, str.size - 3);
    }
    return str;
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0xe01d5bbc, Offset: 0xa428
// Size: 0x184
function trackwallrunningdistance() {
    self endon(#"disconnect");
    self.movementtracking.wallrunning = spawnstruct();
    self.movementtracking.wallrunning.distance = 0;
    self.movementtracking.wallrunning.count = 0;
    self.movementtracking.wallrunning.time = 0;
    while (true) {
        self waittill("wallrun_begin");
        startpos = self.origin;
        starttime = gettime();
        self.movementtracking.wallrunning.count++;
        self waittill("wallrun_end");
        self.movementtracking.wallrunning.distance += distance(startpos, self.origin);
        self.movementtracking.wallrunning.time += gettime() - starttime;
    }
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0x65061112, Offset: 0xa5b8
// Size: 0x184
function tracksprintdistance() {
    self endon(#"disconnect");
    self.movementtracking.sprinting = spawnstruct();
    self.movementtracking.sprinting.distance = 0;
    self.movementtracking.sprinting.count = 0;
    self.movementtracking.sprinting.time = 0;
    while (true) {
        self waittill("sprint_begin");
        startpos = self.origin;
        starttime = gettime();
        self.movementtracking.sprinting.count++;
        self waittill("sprint_end");
        self.movementtracking.sprinting.distance += distance(startpos, self.origin);
        self.movementtracking.sprinting.time += gettime() - starttime;
    }
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0xa7fb48ac, Offset: 0xa748
// Size: 0x184
function trackdoublejumpdistance() {
    self endon(#"disconnect");
    self.movementtracking.doublejump = spawnstruct();
    self.movementtracking.doublejump.distance = 0;
    self.movementtracking.doublejump.count = 0;
    self.movementtracking.doublejump.time = 0;
    while (true) {
        self waittill("doublejump_begin");
        startpos = self.origin;
        starttime = gettime();
        self.movementtracking.doublejump.count++;
        self waittill("doublejump_end");
        self.movementtracking.doublejump.distance += distance(startpos, self.origin);
        self.movementtracking.doublejump.time += gettime() - starttime;
    }
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0xc1962fce, Offset: 0xa8d8
// Size: 0x70
function getplayspacecenter() {
    minimaporigins = getentarray("minimap_corner", "targetname");
    if (minimaporigins.size) {
        return math::find_box_center(minimaporigins[0].origin, minimaporigins[1].origin);
    }
    return (0, 0, 0);
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0xd6d3d55e, Offset: 0xa950
// Size: 0xf6
function getplayspacemaxwidth() {
    minimaporigins = getentarray("minimap_corner", "targetname");
    if (minimaporigins.size) {
        x = abs(minimaporigins[0].origin[0] - minimaporigins[1].origin[0]);
        y = abs(minimaporigins[0].origin[1] - minimaporigins[1].origin[1]);
        return max(x, y);
    }
    return 0;
}

// Namespace util/util_shared
// Params 1, eflags: 0x0
// Checksum 0xa9c66020, Offset: 0xaa50
// Size: 0x90
function getteammask(str_team) {
    str_team = get_team_mapping(str_team);
    if (!level.teambased || !isdefined(str_team) || !isdefined(level.spawnsystem.ispawn_teammask[str_team])) {
        return level.spawnsystem.ispawn_teammask_free;
    }
    return level.spawnsystem.ispawn_teammask[str_team];
}

// Namespace util/util_shared
// Params 1, eflags: 0x0
// Checksum 0xde54de, Offset: 0xaae8
// Size: 0x8c
function getotherteam(str_team) {
    str_team = get_team_mapping(str_team);
    if (str_team == "allies") {
        return "axis";
    } else if (str_team == "axis") {
        return "allies";
    } else {
        return "allies";
    }
    /#
        assertmsg("<dev string:x84b>" + str_team);
    #/
}

// Namespace util/util_shared
// Params 1, eflags: 0x0
// Checksum 0x4bceef0b, Offset: 0xab80
// Size: 0xe4
function getotherteamsmask(str_skip_team) {
    str_skip_team = get_team_mapping(str_skip_team);
    mask = 0;
    foreach (str_team in level.teams) {
        if (str_team == str_skip_team) {
            continue;
        }
        mask |= getteammask(str_team);
    }
    return mask;
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0xe03c7f1f, Offset: 0xac70
// Size: 0x20
function waittill_can_add_debug_command() {
    while (!canadddebugcommand()) {
        waitframe(1);
    }
}

// Namespace util/util_shared
// Params 1, eflags: 0x0
// Checksum 0xdda5fb14, Offset: 0xac98
// Size: 0xfc
function get_players(str_team) {
    if (!isdefined(str_team)) {
        str_team = "any";
    }
    if (str_team == "any") {
        return arraycopy(level.players);
    }
    str_team = get_team_mapping(str_team);
    /#
        assert(isarray(level.aliveplayers[str_team]), "<dev string:x867>" + str_team + "<dev string:x869>");
    #/
    return arraycombine(level.aliveplayers[str_team], level.deadplayers[str_team], 0, 0);
}

// Namespace util/util_shared
// Params 1, eflags: 0x0
// Checksum 0x612012ce, Offset: 0xada0
// Size: 0xec
function get_active_players(str_team) {
    if (!isdefined(str_team)) {
        str_team = "any";
    }
    if (str_team == "any") {
        return arraycopy(level.activeplayers);
    }
    str_team = get_team_mapping(str_team);
    /#
        assert(isarray(level.aliveplayers[str_team]), "<dev string:x867>" + str_team + "<dev string:x869>");
    #/
    return arraycopy(level.aliveplayers[str_team]);
}

// Namespace util/util_shared
// Params 1, eflags: 0x0
// Checksum 0x615e654d, Offset: 0xae98
// Size: 0xfc
function get_human_players(str_team) {
    if (!isdefined(str_team)) {
        str_team = "any";
    }
    if (str_team == "any") {
        return arraycopy(level.humanplayers);
    }
    str_team = get_team_mapping(str_team);
    /#
        assert(isarray(level.var_da5bd44f[str_team]), "<dev string:x867>" + str_team + "<dev string:x869>");
    #/
    return arraycombine(level.var_da5bd44f[str_team], level.var_5a314964[str_team], 0, 0);
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0xde0a34b8, Offset: 0xafa0
// Size: 0x22
function is_game_solo() {
    if (level.humanplayers.size == 1) {
        return true;
    }
    return false;
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0xa7e6c48, Offset: 0xafd0
// Size: 0x84
function is_game_coop() {
    if (level.humanplayercount["axis"] > 1 && (level.humanplayercount["allies"] > 1 && level.humanplayercount["axis"] == 0 || level.humanplayercount["allies"] == 0)) {
        return true;
    }
    return false;
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0x6af3effb, Offset: 0xb060
// Size: 0x44
function function_e960e0c5() {
    if (level.humanplayercount["allies"] > 0 && level.humanplayercount["axis"] > 0) {
        return true;
    }
    return false;
}

// Namespace util/util_shared
// Params 1, eflags: 0x0
// Checksum 0x80c62b5c, Offset: 0xb0b0
// Size: 0x6a
function function_ae77b898(str_team) {
    if (!isdefined(str_team)) {
        str_team = "all";
    }
    if (str_team == "any") {
        str_team = "all";
    }
    return getplayers(get_team_mapping(str_team));
}

// Namespace util/util_shared
// Params 1, eflags: 0x0
// Checksum 0x2a73f099, Offset: 0xb128
// Size: 0xfc
function function_bb1c6fbf(str_team) {
    if (!isdefined(str_team)) {
        str_team = "any";
    }
    if (str_team == "any") {
        return arraycopy(level.companions);
    }
    str_team = get_team_mapping(str_team);
    /#
        assert(isarray(level.var_1eee4099[str_team]), "<dev string:x867>" + str_team + "<dev string:x869>");
    #/
    return arraycombine(level.var_1eee4099[str_team], level.var_28e3515a[str_team], 0, 0);
}

// Namespace util/util_shared
// Params 1, eflags: 0x0
// Checksum 0xc1704dcf, Offset: 0xb230
// Size: 0xec
function function_12a66d92(str_team) {
    if (!isdefined(str_team)) {
        str_team = "any";
    }
    if (str_team == "any") {
        return arraycopy(level.var_4f19f362);
    }
    str_team = get_team_mapping(str_team);
    /#
        assert(isarray(level.var_1eee4099[str_team]), "<dev string:x867>" + str_team + "<dev string:x869>");
    #/
    return arraycopy(level.var_1eee4099[str_team]);
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0x1977fc20, Offset: 0xb328
// Size: 0x86
function function_4f5dd9d2() {
    if (!isplayer(self)) {
        return false;
    }
    if (self iscompanion()) {
        return true;
    }
    if (level.gametype === "pvp") {
        n_entnum = self getentitynumber();
        return (n_entnum >= 4);
    }
    return false;
}

// Namespace util/util_shared
// Params 1, eflags: 0x0
// Checksum 0x6570edb4, Offset: 0xb3b8
// Size: 0x116
function function_89423e7e(var_d06300f4) {
    var_a71713a9 = self;
    if (isplayer(self) && !self function_4f5dd9d2()) {
        var_a71713a9 = self.companion;
    }
    var_f4bbe3ff = var_a71713a9 getcharacterbodytype();
    switch (var_f4bbe3ff) {
    case 2:
        return "Ruin";
    case 3:
        return "Outrider";
    case 4:
        return "Prophet";
    case 5:
        return "Battery";
    case 6:
        return "Seraph";
    case 7:
        return "Nomad";
    case 8:
        return "Spectre";
    case 9:
        return "Firebreak";
    }
    return var_d06300f4;
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0x86adb45, Offset: 0xb4d8
// Size: 0x3e
function function_fbea772b() {
    if (!isplayer(self)) {
        return false;
    }
    if (self islobbybot()) {
        return true;
    }
    return false;
}

// Namespace util/util_shared
// Params 1, eflags: 0x0
// Checksum 0x2fa64c9f, Offset: 0xb520
// Size: 0x1c
function timesince(starttimeinmilliseconds) {
    return (gettime() - starttimeinmilliseconds) * 0.001;
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0xcc0f2300, Offset: 0xb548
// Size: 0x20
function cooldowninit() {
    if (!isdefined(self._cooldown)) {
        self._cooldown = [];
    }
}

// Namespace util/util_shared
// Params 2, eflags: 0x0
// Checksum 0xecd824a5, Offset: 0xb570
// Size: 0x42
function cooldown(name, time_seconds) {
    cooldowninit();
    self._cooldown[name] = gettime() + time_seconds * 1000;
}

// Namespace util/util_shared
// Params 1, eflags: 0x0
// Checksum 0xd09d8afe, Offset: 0xb5c0
// Size: 0x58
function getcooldowntimeraw(name) {
    cooldowninit();
    if (!isdefined(self._cooldown[name])) {
        self._cooldown[name] = gettime() - 1;
    }
    return self._cooldown[name];
}

// Namespace util/util_shared
// Params 1, eflags: 0x0
// Checksum 0x14653e9b, Offset: 0xb620
// Size: 0x40
function getcooldownleft(name) {
    cooldowninit();
    return (getcooldowntimeraw(name) - gettime()) * 0.001;
}

// Namespace util/util_shared
// Params 2, eflags: 0x0
// Checksum 0xbbf4290f, Offset: 0xb668
// Size: 0x72
function iscooldownready(name, timeforward_seconds) {
    cooldowninit();
    if (!isdefined(timeforward_seconds)) {
        timeforward_seconds = 0;
    }
    cooldownreadytime = self._cooldown[name];
    return !isdefined(cooldownreadytime) || gettime() + timeforward_seconds * 1000 > cooldownreadytime;
}

// Namespace util/util_shared
// Params 1, eflags: 0x0
// Checksum 0xf9570d64, Offset: 0xb6e8
// Size: 0x36
function clearcooldown(name) {
    cooldowninit();
    self._cooldown[name] = gettime() - 1;
}

// Namespace util/util_shared
// Params 2, eflags: 0x0
// Checksum 0xe59e66d4, Offset: 0xb728
// Size: 0x56
function addcooldowntime(name, time_seconds) {
    cooldowninit();
    self._cooldown[name] = getcooldowntimeraw(name) + time_seconds * 1000;
}

// Namespace util/util_shared
// Params 0, eflags: 0x0
// Checksum 0xf236f6f9, Offset: 0xb788
// Size: 0xa0
function clearallcooldowns() {
    if (isdefined(self._cooldown)) {
        foreach (str_name, cooldown in self._cooldown) {
            self._cooldown[str_name] = gettime() - 1;
        }
    }
}

// Namespace util/util_shared
// Params 2, eflags: 0x0
// Checksum 0x2b98ef0, Offset: 0xb830
// Size: 0x2c4
function set_team_mapping(str_team_for_sidea, str_team_for_sideb) {
    if (tolower(str_team_for_sidea) == "wun") {
        str_team_for_sidea = "allies";
    } else if (tolower(str_team_for_sidea) == "fpa") {
        str_team_for_sidea = "axis";
    }
    if (tolower(str_team_for_sideb) == "fpa") {
        str_team_for_sideb = "axis";
    } else if (tolower(str_team_for_sideb) == "wun") {
        str_team_for_sideb = "allies";
    }
    /#
        assert(str_team_for_sidea != str_team_for_sideb, "<dev string:x884>");
    #/
    level.team_mapping["sidea"] = str_team_for_sidea;
    level.team_mapping["sideb"] = str_team_for_sideb;
    if (level.gametype === "pvp") {
        game.attackers = level.team_mapping["sidea"];
        game.defenders = level.team_mapping["sideb"];
    }
    level.team_mapping["wun"] = "allies";
    level.team_mapping["fpa"] = "axis";
    level.team_mapping["teama"] = level.team_mapping["sidea"];
    level.team_mapping["teamb"] = level.team_mapping["sideb"];
    level.team_mapping["side3"] = "team3";
    if (level.team_mapping["sidea"] == "allies" && level.team_mapping["sideb"] == "axis") {
        level clientfield::set("cf_team_mapping", 1);
        return;
    }
    level clientfield::set("cf_team_mapping", 0);
}

// Namespace util/util_shared
// Params 1, eflags: 0x0
// Checksum 0xb734ade3, Offset: 0xbb00
// Size: 0xe0
function get_team_mapping(str_team) {
    if (isdefined(str_team)) {
        if (isdefined(level.team_mapping)) {
            str_team = tolower(str_team);
            a_keys = getarraykeys(level.team_mapping);
            if (isinarray(a_keys, str_team)) {
                return level.team_mapping[str_team];
            }
        } else if (str_team == "sideA") {
            str_team = "allies";
        } else if (str_team == "sideB") {
            str_team = "axis";
        }
    }
    return str_team;
}

// Namespace util/util_shared
// Params 1, eflags: 0x0
// Checksum 0x31c665da, Offset: 0xbbe8
// Size: 0x3c
function is_on_side(str_team) {
    return self getteam() == get_team_mapping(str_team);
}

