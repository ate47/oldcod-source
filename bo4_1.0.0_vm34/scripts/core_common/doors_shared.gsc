#using scripts\core_common\animation_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\flagsys_shared;
#using scripts\core_common\gameobjects_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\trigger_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;

#namespace doors;

// Namespace doors
// Method(s) 41 Total 41
class cdoor {

    var angles;
    var m_door_open_delay_time;
    var m_e_door;
    var m_e_trigger;
    var m_e_trigger_player;
    var m_n_door_connect_paths;
    var m_n_trigger_height;
    var m_s_bundle;
    var m_str_type;
    var m_v_close_pos;
    var m_v_open_pos;
    var origin;
    var v_trigger_offset;
    var var_333a0956;
    var var_67ba89f5;
    var var_6bf45197;
    var var_8c831ea3;
    var var_9cf7e32;
    var var_b6094b49;
    var var_b733ac06;
    var var_c9a68002;
    var var_ccdffe96;
    var var_fcfd2647;

    // Namespace cdoor/doors_shared
    // Params 0, eflags: 0x8
    // Checksum 0x6d4540d5, Offset: 0x370
    // Size: 0x5e
    constructor() {
        m_n_trigger_height = 80;
        m_door_open_delay_time = 0;
        m_e_trigger_player = undefined;
        m_str_type = "door";
        var_333a0956 = [];
        var_c9a68002 = [];
        var_6bf45197 = 0;
    }

    // Namespace cdoor/doors_shared
    // Params 0, eflags: 0x10
    // Checksum 0xf76672e7, Offset: 0x3d8
    // Size: 0x2c
    destructor() {
        if (isdefined(m_e_trigger)) {
            m_e_trigger delete();
        }
    }

    // Namespace cdoor/doors_shared
    // Params 0, eflags: 0x0
    // Checksum 0xf7aedd84, Offset: 0x3f28
    // Size: 0x80
    function function_9a01f62f() {
        self endon(#"death");
        var_67ba89f5 = [];
        while (true) {
            waitresult = self waittill(#"grenade_stuck");
            if (isdefined(waitresult.projectile)) {
                array::add(var_67ba89f5, waitresult.projectile);
            }
        }
    }

    // Namespace cdoor/doors_shared
    // Params 1, eflags: 0x0
    // Checksum 0xe5a113e6, Offset: 0x3f00
    // Size: 0x1a
    function function_5eee5687(delay_time) {
        m_door_open_delay_time = delay_time;
    }

    // Namespace cdoor/doors_shared
    // Params 5, eflags: 0x0
    // Checksum 0xf84b2bb8, Offset: 0x3a68
    // Size: 0x490
    function function_5a9680fb(b_malfunction = 0, b_open_door = 1, b_reverse = 0, var_f7941cd1 = 0, var_439911a3 = 0) {
        if (b_malfunction) {
            if (b_open_door) {
                var_faa0d5b5 = isdefined(m_s_bundle.var_28576fe0) ? m_s_bundle.var_28576fe0 : 0;
                var_e5822e1b = isdefined(m_s_bundle.var_9354e53e) ? m_s_bundle.var_9354e53e : 0;
            } else {
                var_faa0d5b5 = isdefined(m_s_bundle.var_b327196e) ? m_s_bundle.var_b327196e : 0;
                var_e5822e1b = isdefined(m_s_bundle.var_45af3b10) ? m_s_bundle.var_45af3b10 : 0;
            }
            if (var_faa0d5b5 == 0 && var_e5822e1b == 0) {
                var_cb633488 = 0;
            } else if (var_e5822e1b > var_faa0d5b5) {
                var_cb633488 = randomfloatrange(var_faa0d5b5, var_e5822e1b);
            } else {
                assertmsg("<dev string:x87>");
            }
            if (b_open_door) {
                if (isdefined(var_6bf45197) && var_6bf45197) {
                    var_e8986b59 = m_s_bundle.var_38cbf3c2 + var_cb633488;
                } else {
                    var_e8986b59 = m_s_bundle.door_swing_angle + var_cb633488;
                }
            } else {
                var_e8986b59 = var_cb633488;
            }
        } else if (b_open_door) {
            if (isdefined(var_6bf45197) && var_6bf45197) {
                var_e8986b59 = m_s_bundle.var_38cbf3c2;
            } else {
                var_e8986b59 = m_s_bundle.door_swing_angle;
            }
        } else {
            var_e8986b59 = 0;
        }
        if (b_reverse) {
            if (var_f7941cd1) {
                v_angle = (var_9cf7e32.angles[0], var_9cf7e32.angles[1], var_9cf7e32.angles[2] - var_e8986b59);
            } else if (var_439911a3) {
                v_angle = (var_9cf7e32.angles[0] - var_e8986b59, var_9cf7e32.angles[1], var_9cf7e32.angles[2]);
            } else {
                v_angle = (var_9cf7e32.angles[0], var_9cf7e32.angles[1] - var_e8986b59, var_9cf7e32.angles[2]);
            }
            return v_angle;
        }
        if (var_f7941cd1) {
            v_angle = (var_9cf7e32.angles[0], var_9cf7e32.angles[1], var_9cf7e32.angles[2] + var_e8986b59);
        } else if (var_439911a3) {
            v_angle = (var_9cf7e32.angles[0] + var_e8986b59, var_9cf7e32.angles[1], var_9cf7e32.angles[2]);
        } else {
            v_angle = (var_9cf7e32.angles[0], var_9cf7e32.angles[1] + var_e8986b59, var_9cf7e32.angles[2]);
        }
        return v_angle;
    }

    // Namespace cdoor/doors_shared
    // Params 3, eflags: 0x0
    // Checksum 0x52a2b197, Offset: 0x3958
    // Size: 0x104
    function calculate_offset_position(v_origin, v_angles, v_offset) {
        v_pos = v_origin;
        if (v_offset[0]) {
            v_side = anglestoforward(v_angles);
            v_pos += v_offset[0] * v_side;
        }
        if (v_offset[1]) {
            v_dir = anglestoright(v_angles);
            v_pos += v_offset[1] * v_dir;
        }
        if (v_offset[2]) {
            v_up = anglestoup(v_angles);
            v_pos += v_offset[2] * v_up;
        }
        return v_pos;
    }

    // Namespace cdoor/doors_shared
    // Params 1, eflags: 0x0
    // Checksum 0xc967e875, Offset: 0x3930
    // Size: 0x1a
    function set_door_paths(n_door_connect_paths) {
        m_n_door_connect_paths = n_door_connect_paths;
    }

    // Namespace cdoor/doors_shared
    // Params 0, eflags: 0x0
    // Checksum 0x2085bebe, Offset: 0x3868
    // Size: 0xba
    function init_player_spawns() {
        if (isdefined(var_ccdffe96.targetname)) {
            a_structs = struct::get_array(var_ccdffe96.targetname, "target");
            foreach (struct in a_structs) {
                struct.c_door = self;
            }
        }
    }

    // Namespace cdoor/doors_shared
    // Params 2, eflags: 0x0
    // Checksum 0x7bceab52, Offset: 0x37b0
    // Size: 0xaa
    function init_movement(str_slide_dir, n_slide_amount) {
        if (m_s_bundle.door_open_method == "slide") {
            v_offset = function_e98a9071(str_slide_dir, n_slide_amount);
            m_v_open_pos = calculate_offset_position(m_e_door.origin, m_e_door.angles, v_offset);
            m_v_close_pos = m_e_door.origin;
        }
    }

    // Namespace cdoor/doors_shared
    // Params 1, eflags: 0x0
    // Checksum 0x3c786f51, Offset: 0x3618
    // Size: 0x18a
    function function_f4e217f2(var_8b54a365 = 1) {
        if (var_8b54a365) {
            m_v_close_pos = m_e_door.origin;
            v_offset = function_e98a9071(undefined, m_s_bundle.door_slide_open_units);
            m_v_open_pos = calculate_offset_position(m_v_close_pos, m_e_door.angles, v_offset);
            var_9cf7e32.origin = m_e_door.origin;
            var_9cf7e32.angles = m_e_door.angles;
            return;
        }
        m_v_open_pos = m_e_door.origin;
        v_offset = function_e98a9071(undefined, m_s_bundle.door_slide_open_units * -1);
        m_v_close_pos = calculate_offset_position(m_v_open_pos, m_e_door.angles, v_offset);
        var_9cf7e32.origin = m_v_close_pos;
        var_9cf7e32.angles = m_e_door.angles;
    }

    // Namespace cdoor/doors_shared
    // Params 2, eflags: 0x0
    // Checksum 0x95ff81bc, Offset: 0x34f0
    // Size: 0x11e
    function function_e98a9071(var_803339a5, n_slide_amount) {
        str_slide_dir = isdefined(var_b6094b49) ? var_b6094b49 : var_803339a5;
        switch (str_slide_dir) {
        case #"x":
            v_offset = (n_slide_amount, 0, 0);
            var_b6094b49 = "X";
            break;
        case #"y":
            v_offset = (0, n_slide_amount, 0);
            var_b6094b49 = "Y";
            break;
        case #"z":
            v_offset = (0, 0, n_slide_amount);
            var_b6094b49 = "Z";
            break;
        default:
            v_offset = (0, 0, n_slide_amount);
            var_b6094b49 = "Z";
            break;
        }
        return v_offset;
    }

    // Namespace cdoor/doors_shared
    // Params 1, eflags: 0x0
    // Checksum 0x31ba10eb, Offset: 0x33f0
    // Size: 0xf8
    function set_script_flags(b_set) {
        if (isdefined(var_ccdffe96.script_flag)) {
            a_flags = strtok(var_ccdffe96.script_flag, ",");
            foreach (str_flag in a_flags) {
                if (b_set) {
                    level flag::set(str_flag);
                    continue;
                }
                level flag::clear(str_flag);
            }
        }
    }

    // Namespace cdoor/doors_shared
    // Params 2, eflags: 0x0
    // Checksum 0x34160f87, Offset: 0x3018
    // Size: 0x3cc
    function init_trigger(v_offset, n_radius) {
        if (isdefined(m_s_bundle.var_1080d584)) {
            thread function_ae94ff39();
        } else if (isdefined(m_s_bundle.door_interact)) {
            thread function_a518e0c8();
        } else {
            v_pos = calculate_offset_position(m_e_door.origin, m_e_door.angles, v_offset);
            v_pos = (v_pos[0], v_pos[1], v_pos[2] + 50);
            if (isdefined(m_s_bundle.door_trigger_at_target) && m_s_bundle.door_trigger_at_target && isdefined(var_ccdffe96.target)) {
                a_e_targets = getentarray(var_ccdffe96.target, "targetname");
                e_target = a_e_targets[0];
                if (isdefined(e_target)) {
                    if (e_target trigger::is_trigger_of_type("trigger_multiple", "trigger_radius", "trigger_box", "trigger_multiple_new", "trigger_radius_new", "trigger_box_new")) {
                        t_radius_or_multiple = e_target;
                        v_pos = e_target.origin;
                    } else if (e_target trigger::is_trigger_of_type("trigger_use", "trigger_use_touch")) {
                        t_use = e_target;
                        m_s_bundle.door_use_trigger = 1;
                    }
                }
            }
            if (isdefined(m_s_bundle.door_use_trigger) && m_s_bundle.door_use_trigger) {
                if (isdefined(t_use)) {
                    m_e_trigger = t_use;
                } else {
                    m_e_trigger = spawn("trigger_radius_use", v_pos, 16384 | 4096, n_radius, m_n_trigger_height);
                }
                m_e_trigger triggerignoreteam();
                m_e_trigger setvisibletoall();
                m_e_trigger setteamfortrigger(#"none");
                m_e_trigger usetriggerrequirelookat();
                m_e_trigger setcursorhint("HINT_NOICON");
            } else if (isdefined(t_radius_or_multiple)) {
                m_e_trigger = t_radius_or_multiple;
            } else {
                m_e_trigger = spawn("trigger_radius", v_pos, 16384 | 4096 | 16 | 512, n_radius, m_n_trigger_height);
            }
        }
        if (isdefined(m_s_bundle.var_91f4939c) && m_s_bundle.var_91f4939c) {
            m_e_door setcandamage(1);
            thread function_9c72a02b();
        }
    }

    // Namespace cdoor/doors_shared
    // Params 0, eflags: 0x0
    // Checksum 0x4b48a2fa, Offset: 0x2f90
    // Size: 0x7c
    function function_ae94ff39() {
        m_e_door makeusable();
        m_e_door setcursorhint("HINT_NOICON");
        m_e_door sethintstring(#"hash_1cc0220a2ef3e6d6");
        thread function_2658346(1, 0);
    }

    // Namespace cdoor/doors_shared
    // Params 0, eflags: 0x0
    // Checksum 0xc875e2a3, Offset: 0x2e90
    // Size: 0xf4
    function function_a518e0c8() {
        level flagsys::wait_till("radiant_gameobjects_initialized");
        m_e_door.func_custom_gameobject_position = &function_64b09fdd;
        m_e_door.v_trigger_offset = m_s_bundle.v_trigger_offset;
        m_e_door gameobjects::init_game_objects(m_s_bundle.door_interact);
        m_e_door.mdl_gameobject.t_interact usetriggerrequirelookat();
        thread function_2658346(isdefined(m_s_bundle.door_closes) && m_s_bundle.door_closes, 1);
    }

    // Namespace cdoor/doors_shared
    // Params 0, eflags: 0x0
    // Checksum 0x322a81f7, Offset: 0x2cd8
    // Size: 0x1ae
    function function_9c72a02b() {
        m_e_trigger endon(#"death");
        while (true) {
            m_e_door waittill(#"damage");
            if (!is_open() && !self flag::get("animating")) {
                open();
                flag::wait_till_clear("animating");
                if (isdefined(m_s_bundle.var_843a701) && m_s_bundle.var_843a701) {
                    wait isdefined(m_s_bundle.var_5d638a25) ? m_s_bundle.var_5d638a25 : 0;
                    if (isdefined(m_e_trigger_player)) {
                        var_ceffd1f4 = m_e_trigger.maxs[0] * m_e_trigger.maxs[0];
                        while (isdefined(m_e_trigger_player) && m_e_trigger_player istouching(m_e_trigger)) {
                            waitframe(1);
                        }
                        close();
                    } else {
                        close();
                    }
                }
            }
            waitframe(1);
        }
    }

    // Namespace cdoor/doors_shared
    // Params 2, eflags: 0x0
    // Checksum 0x2376edc9, Offset: 0x2970
    // Size: 0x35e
    function function_2658346(b_reusable, var_fd18560d) {
        m_e_door endon(#"hash_190d72393c0a8869", #"delete", #"gameobject_deleted");
        while (true) {
            if (var_fd18560d) {
                waitresult = m_e_door.mdl_gameobject waittill(#"gameobject_end_use_player");
                e_player = waitresult.player;
            } else {
                waitresult = m_e_door waittill(#"trigger");
                e_player = waitresult.activator;
            }
            if (!self flag::get("animating")) {
                if (!b_reusable) {
                    m_e_door notify(#"hash_190d72393c0a8869");
                }
                unlock();
                set_player_who_opened(e_player);
                e_player playrumbleonentity("damage_light");
                if (is_open()) {
                    if (isdefined(m_s_bundle.var_a58334b3)) {
                        var_82c9cd4f = float(isdefined(m_s_bundle.var_b3a7af07) ? m_s_bundle.var_b3a7af07 : 0);
                        var_4f25f5ea = float(isdefined(m_s_bundle.var_ec786062) ? m_s_bundle.var_ec786062 : 0);
                        thread function_f5eb2a93(e_player, m_s_bundle.var_a58334b3, var_82c9cd4f, var_4f25f5ea);
                    }
                    m_e_door notify(#"hash_923096b653062ea");
                    close();
                } else {
                    if (isdefined(m_s_bundle.var_5636ef6f)) {
                        var_82c9cd4f = float(isdefined(m_s_bundle.var_40c05a93) ? m_s_bundle.var_40c05a93 : 0);
                        var_4f25f5ea = float(isdefined(m_s_bundle.var_6398a34e) ? m_s_bundle.var_6398a34e : 0);
                        thread function_f5eb2a93(e_player, m_s_bundle.var_5636ef6f, var_82c9cd4f, var_4f25f5ea);
                    }
                    m_e_door notify(#"hash_7166c13e79b73f9");
                    open();
                }
            }
            waitframe(1);
        }
    }

    // Namespace cdoor/doors_shared
    // Params 4, eflags: 0x0
    // Checksum 0xa65a5785, Offset: 0x2910
    // Size: 0x54
    function function_f5eb2a93(e_player, str_anim, var_82c9cd4f, n_start_time) {
        e_player thread animation::play(str_anim, e_player, undefined, var_82c9cd4f, 0.2, 0, 0, n_start_time);
    }

    // Namespace cdoor/doors_shared
    // Params 0, eflags: 0x0
    // Checksum 0x404996e6, Offset: 0x27e8
    // Size: 0x11c
    function function_64b09fdd() {
        v_angles = angles;
        v_offset = v_trigger_offset;
        v_pos = origin;
        if (isdefined(v_offset)) {
            if (v_offset[0]) {
                v_side = anglestoforward(v_angles);
                v_pos += v_offset[0] * v_side;
            }
            if (v_offset[1]) {
                v_dir = anglestoright(v_angles);
                v_pos += v_offset[1] * v_dir;
            }
            if (v_offset[2]) {
                v_up = anglestoup(v_angles);
                v_pos += v_offset[2] * v_up;
            }
        }
        return v_pos;
    }

    // Namespace cdoor/doors_shared
    // Params 0, eflags: 0x0
    // Checksum 0x631dc02f, Offset: 0x25b8
    // Size: 0x228
    function run_lock_fx() {
        if (!isdefined(m_s_bundle.door_locked_fx) && !isdefined(m_s_bundle.door_unlocked_fx)) {
            return;
        }
        e_fx = undefined;
        v_pos = get_hack_pos();
        v_angles = get_hack_angles();
        while (true) {
            self flag::wait_till("locked");
            if (isdefined(e_fx)) {
                e_fx delete();
                e_fx = undefined;
            }
            if (isdefined(m_s_bundle.door_locked_fx)) {
                e_fx = spawn("script_model", v_pos);
                e_fx setmodel(#"tag_origin");
                e_fx.angles = v_angles;
                playfxontag(m_s_bundle.door_locked_fx, e_fx, "tag_origin");
            }
            self flag::wait_till_clear("locked");
            if (isdefined(e_fx)) {
                e_fx delete();
                e_fx = undefined;
            }
            if (isdefined(m_s_bundle.door_unlocked_fx)) {
                e_fx = spawn("script_model", v_pos);
                e_fx setmodel(#"tag_origin");
                e_fx.angles = v_angles;
                playfxontag(m_s_bundle.door_unlocked_fx, e_fx, "tag_origin");
            }
        }
    }

    // Namespace cdoor/doors_shared
    // Params 0, eflags: 0x0
    // Checksum 0x497ee022, Offset: 0x24a0
    // Size: 0x10a
    function update_use_message() {
        if (!(isdefined(m_s_bundle.door_use_trigger) && m_s_bundle.door_use_trigger)) {
            return;
        }
        if (self flag::get("open")) {
            if (!(isdefined(m_s_bundle.door_closes) && m_s_bundle.door_closes)) {
            }
            return;
        }
        if (isdefined(m_s_bundle.door_open_message) && m_s_bundle.door_open_message != "") {
            return;
        }
        if (isdefined(m_s_bundle.door_use_hold) && m_s_bundle.door_use_hold) {
            return;
        }
        if (self flag::get("locked")) {
        }
    }

    // Namespace cdoor/doors_shared
    // Params 2, eflags: 0x0
    // Checksum 0xca4805e8, Offset: 0x1b28
    // Size: 0x96c
    function open_internal(b_malfunction = 0, var_4ab09caa) {
        var_6f73aca0 = isdefined(var_4ab09caa) ? var_4ab09caa : m_s_bundle.door_open_time;
        self flag::set("animating");
        if (isdefined(var_ccdffe96.groupname)) {
            a_door_structs = struct::get_array(var_ccdffe96.groupname, "groupname");
            foreach (s_door_struct in a_door_structs) {
                b_animating = s_door_struct.c_door flag::get("animating");
                if (s_door_struct.c_door.m_e_door != m_e_door) {
                    if (![[ s_door_struct.c_door ]]->is_open() && !b_animating) {
                        s_door_struct.c_door.m_e_trigger_player = m_e_trigger_player;
                        [[ s_door_struct.c_door ]]->open();
                    }
                }
            }
        }
        m_e_door notify(#"door_opening");
        m_e_door function_4f8d1fe7();
        self flag::clear("door_fully_closed");
        if (isdefined(m_s_bundle.door_start_sound) && m_s_bundle.door_start_sound != "") {
            m_e_door playsound(m_s_bundle.door_start_sound);
        }
        if (isdefined(m_s_bundle.b_loop_sound) && m_s_bundle.b_loop_sound) {
            sndent = spawn("script_origin", m_e_door.origin);
            sndent linkto(m_e_door);
            sndent playloopsound(m_s_bundle.door_loop_sound, 1);
        }
        if (m_s_bundle.door_open_method == "slide") {
            if (!b_malfunction) {
                function_f4e217f2(1);
            }
            var_2ed65283 = function_f22f7c49(b_malfunction, 1);
            m_e_door moveto(var_2ed65283, var_6f73aca0);
            m_e_door waittill(#"movedone");
        } else if (m_s_bundle.door_open_method == "swing_away_from_player") {
            if (!isdefined(m_e_trigger_player)) {
                if (isdefined(var_ccdffe96.groupname)) {
                    a_door_structs = struct::get_array(var_ccdffe96.groupname, "groupname");
                    foreach (s_door_struct in a_door_structs) {
                        if (s_door_struct.c_door.m_e_door != m_e_door) {
                            if (isdefined(s_door_struct.c_door.m_e_trigger_player)) {
                                m_e_trigger_player = s_door_struct.c_door.m_e_trigger_player;
                                break;
                            }
                        }
                    }
                }
            }
            v_player_forward = anglestoforward(m_e_trigger_player.angles);
            upvec = anglestoup(m_e_trigger_player.angles);
            var_c83eebfa = anglestoforward(m_e_door.angles);
            var_431adfdc = var_c83eebfa;
            if (isdefined(m_s_bundle.var_7dd88209) && m_s_bundle.var_7dd88209) {
                var_431adfdc = vectorcross(var_c83eebfa, upvec);
            }
            var_4dd9f5d2 = vectordot(var_431adfdc, v_player_forward);
            if (var_4dd9f5d2 > 0) {
                v_angle = function_5a9680fb(b_malfunction, 1, 0, m_s_bundle.var_522f6941, m_s_bundle.var_9e345e13);
                m_e_door rotateto(v_angle, var_6f73aca0);
                m_e_door waittill(#"rotatedone");
            } else {
                v_angle = function_5a9680fb(b_malfunction, 1, 1, m_s_bundle.var_522f6941, m_s_bundle.var_9e345e13);
                m_e_door rotateto(v_angle, var_6f73aca0);
                m_e_door waittill(#"rotatedone");
            }
        } else if (m_s_bundle.door_open_method == "swing") {
            v_angle = function_5a9680fb(b_malfunction, 1, 0, m_s_bundle.var_522f6941, m_s_bundle.var_9e345e13);
            m_e_door rotateto(v_angle, var_6f73aca0);
            m_e_door waittill(#"rotatedone");
        } else if (m_s_bundle.door_open_method == "animated" && isdefined(m_s_bundle.door_animated_open_bundle)) {
            if (scene::get_player_count(m_s_bundle.door_animated_open_bundle) > 0) {
                m_e_door scene::play(m_s_bundle.door_animated_open_bundle, array(m_e_door, m_e_trigger_player));
            } else {
                m_e_door scene::play(m_s_bundle.door_animated_open_bundle, m_e_door);
            }
        }
        if (isdefined(m_n_door_connect_paths) && m_n_door_connect_paths && m_s_bundle.door_open_method !== "swing") {
            if (isdefined(m_s_bundle.var_e06cac33) && m_s_bundle.var_e06cac33) {
                m_e_door function_493935fc();
            } else {
                m_e_door function_7da936d3();
            }
        }
        m_e_door notify(#"door_opened");
        if (isdefined(m_s_bundle.b_loop_sound) && m_s_bundle.b_loop_sound) {
            sndent delete();
        }
        flag::clear("animating");
        set_script_flags(1);
        function_91c5f477(1);
        update_use_message();
    }

    // Namespace cdoor/doors_shared
    // Params 0, eflags: 0x0
    // Checksum 0x1543ac5a, Offset: 0x1a70
    // Size: 0xb0
    function function_4f8d1fe7() {
        if (!isdefined(var_b733ac06)) {
            return;
        }
        foreach (var_55e2e87a in var_b733ac06) {
            if (!isdefined(var_55e2e87a)) {
                continue;
            }
            var_55e2e87a dodamage(500, origin, undefined, undefined, undefined, "MOD_EXPLOSIVE");
        }
    }

    // Namespace cdoor/doors_shared
    // Params 2, eflags: 0x0
    // Checksum 0xc2385a12, Offset: 0x17a0
    // Size: 0x2c2
    function function_f22f7c49(b_malfunction = 0, b_open_door = 1) {
        if (b_malfunction) {
            if (b_open_door) {
                var_ec8a212c = isdefined(m_s_bundle.var_d2d0f3bb) ? m_s_bundle.var_d2d0f3bb : 0;
                var_d76b7992 = isdefined(m_s_bundle.var_a83ee875) ? m_s_bundle.var_a83ee875 : 0;
            } else {
                var_ec8a212c = isdefined(m_s_bundle.var_e18b9ec7) ? m_s_bundle.var_e18b9ec7 : 0;
                var_d76b7992 = isdefined(m_s_bundle.var_86e5c039) ? m_s_bundle.var_86e5c039 : 0;
            }
            if (var_ec8a212c == 0 && var_d76b7992 == 0) {
                var_1428f485 = 0;
            } else if (var_d76b7992 > var_ec8a212c) {
                var_1428f485 = randomfloatrange(var_ec8a212c, var_d76b7992);
            } else {
                assertmsg("<dev string:x30>");
            }
            switch (var_b6094b49) {
            case #"x":
                v_offset = (var_1428f485, 0, 0);
                break;
            case #"y":
                v_offset = (0, var_1428f485, 0);
                break;
            case #"z":
                v_offset = (0, 0, var_1428f485);
                break;
            default:
                v_offset = (0, 0, 0);
                break;
            }
            if (b_open_door) {
                var_652cd19d = calculate_offset_position(m_v_open_pos, var_9cf7e32.angles, v_offset);
            } else {
                var_652cd19d = calculate_offset_position(m_v_close_pos, var_9cf7e32.angles, v_offset);
            }
        } else if (b_open_door) {
            var_652cd19d = m_v_open_pos;
        } else {
            var_652cd19d = m_v_close_pos;
        }
        return var_652cd19d;
    }

    // Namespace cdoor/doors_shared
    // Params 1, eflags: 0x0
    // Checksum 0xb39f127, Offset: 0x1520
    // Size: 0x274
    function function_f2f2f202(b_enable) {
        self notify(#"hash_50b9293fc24e2756");
        self endon(#"hash_50b9293fc24e2756");
        m_e_door endon(#"death");
        if (b_enable) {
            self notify(#"end_door_update");
        }
        n_delay_min = isdefined(m_s_bundle.var_c5880ac2) ? m_s_bundle.var_c5880ac2 : 0.1;
        n_delay_max = isdefined(m_s_bundle.var_8823ffac) ? m_s_bundle.var_8823ffac : 1;
        if (m_s_bundle.door_open_method === "slide" || m_s_bundle.door_open_method === "swing") {
            if (b_enable) {
                while (true) {
                    open_internal(b_enable, randomfloatrange(n_delay_min, n_delay_max));
                    wait randomfloatrange(n_delay_min, n_delay_max);
                    close_internal(b_enable, randomfloatrange(n_delay_min, n_delay_max));
                }
            } else {
                close_internal(b_enable);
                level thread doors::door_update(self);
            }
            return;
        }
        if (m_s_bundle.door_open_method == "animated" && isdefined(m_s_bundle.var_d25d1b03)) {
            if (b_enable) {
                var_9cf7e32 thread scene::play(m_s_bundle.var_d25d1b03, m_e_door);
                return;
            }
            var_9cf7e32 thread scene::stop(m_s_bundle.var_d25d1b03);
        }
    }

    // Namespace cdoor/doors_shared
    // Params 0, eflags: 0x0
    // Checksum 0xc7e08351, Offset: 0x14f0
    // Size: 0x24
    function close() {
        self flag::clear("open");
    }

    // Namespace cdoor/doors_shared
    // Params 0, eflags: 0x0
    // Checksum 0x1beae9c7, Offset: 0x1468
    // Size: 0x80
    function function_25db1aca() {
        self flag::wait_till("door_fully_closed");
        while (isdefined(m_e_trigger_player) && distance2d(m_e_trigger_player.origin, m_e_door.origin) < 16) {
            waitframe(1);
        }
    }

    // Namespace cdoor/doors_shared
    // Params 2, eflags: 0x0
    // Checksum 0x60cb5648, Offset: 0xce0
    // Size: 0x77c
    function close_internal(b_malfunction = 0, var_4ab09caa) {
        if (self flag::get("door_fully_closed")) {
            return;
        } else {
            self flag::clear("open");
        }
        if (isdefined(var_ccdffe96.groupname)) {
            a_door_structs = struct::get_array(var_ccdffe96.groupname, "groupname");
            foreach (s_door_struct in a_door_structs) {
                b_animating = s_door_struct.c_door flag::get("animating");
                if (s_door_struct.c_door.m_e_door != m_e_door) {
                    if ([[ s_door_struct.c_door ]]->is_open() && !b_animating) {
                        [[ s_door_struct.c_door ]]->close();
                    }
                }
            }
        }
        var_6f73aca0 = isdefined(var_4ab09caa) ? var_4ab09caa : m_s_bundle.door_open_time;
        set_script_flags(0);
        self flag::set("animating");
        m_e_door notify(#"door_closing");
        self thread function_25db1aca();
        if (isdefined(m_s_bundle.b_loop_sound) && m_s_bundle.b_loop_sound) {
            m_e_door playsound(m_s_bundle.door_start_sound);
            sndent = spawn("script_origin", m_e_door.origin);
            sndent linkto(m_e_door);
            sndent playloopsound(m_s_bundle.door_loop_sound, 1);
        } else if (isdefined(m_s_bundle.door_stop_sound) && m_s_bundle.door_stop_sound != "") {
            m_e_door playsound(m_s_bundle.door_stop_sound);
        }
        if (m_s_bundle.door_open_method == "slide") {
            if (!b_malfunction) {
                function_f4e217f2(0);
            }
            var_a4c9d177 = function_f22f7c49(b_malfunction, 0);
            m_e_door moveto(var_a4c9d177, var_6f73aca0);
            m_e_door waittill(#"movedone");
        } else if (m_s_bundle.door_open_method == "swing_away_from_player") {
            v_angle = function_5a9680fb(b_malfunction, 0, 0, m_s_bundle.var_522f6941, m_s_bundle.var_9e345e13);
            m_e_door rotateto(v_angle, var_6f73aca0);
            m_e_door waittill(#"rotatedone");
        } else if (m_s_bundle.door_open_method == "swing") {
            v_angle = function_5a9680fb(b_malfunction, 0, 0, m_s_bundle.var_522f6941, m_s_bundle.var_9e345e13);
            m_e_door rotateto(v_angle, var_6f73aca0);
            m_e_door waittill(#"rotatedone");
        } else if (m_s_bundle.door_open_method == "animated" && isdefined(m_s_bundle.door_animated_close_bundle)) {
            if (scene::get_player_count(m_s_bundle.door_animated_close_bundle) > 0) {
                m_e_door notify(#"hash_3803c0c576f1982b", {#player:m_e_trigger_player});
                m_e_door scene::play(m_s_bundle.door_animated_close_bundle, array(m_e_door, m_e_trigger_player));
            } else {
                m_e_door scene::play(m_s_bundle.door_animated_close_bundle, m_e_door);
            }
        }
        m_e_door notify(#"door_closed");
        self flag::set("door_fully_closed");
        if (isdefined(m_n_door_connect_paths) && m_n_door_connect_paths) {
            if (isdefined(m_s_bundle.var_e06cac33) && m_s_bundle.var_e06cac33) {
                m_e_door function_7da936d3();
            } else {
                m_e_door function_493935fc();
            }
        }
        if (isdefined(m_s_bundle.b_loop_sound) && m_s_bundle.b_loop_sound) {
            sndent delete();
            m_e_door playsound(m_s_bundle.door_stop_sound);
        }
        flag::clear("animating");
        function_91c5f477(0);
        update_use_message();
    }

    // Namespace cdoor/doors_shared
    // Params 1, eflags: 0x0
    // Checksum 0x6b9560f5, Offset: 0xae0
    // Size: 0x1f8
    function function_91c5f477(b_opened = 1) {
        if (b_opened) {
            foreach (node in var_333a0956) {
                setenablenode(node, 1);
            }
            foreach (node in var_c9a68002) {
                setenablenode(node, 0);
            }
            return;
        }
        foreach (node in var_333a0956) {
            setenablenode(node, 0);
        }
        foreach (node in var_c9a68002) {
            setenablenode(node, 1);
        }
    }

    // Namespace cdoor/doors_shared
    // Params 0, eflags: 0x0
    // Checksum 0x30aa3e88, Offset: 0xaa8
    // Size: 0x2c
    function remove_door_trigger() {
        if (isdefined(m_e_trigger)) {
            m_e_trigger delete();
        }
    }

    // Namespace cdoor/doors_shared
    // Params 0, eflags: 0x0
    // Checksum 0xe751b3dc, Offset: 0xa78
    // Size: 0x22
    function is_open() {
        return self flag::get("open");
    }

    // Namespace cdoor/doors_shared
    // Params 1, eflags: 0x0
    // Checksum 0xc2943a05, Offset: 0xa50
    // Size: 0x1a
    function set_player_who_opened(e_player) {
        m_e_trigger_player = e_player;
    }

    // Namespace cdoor/doors_shared
    // Params 0, eflags: 0x0
    // Checksum 0xed5052e3, Offset: 0x9d0
    // Size: 0x74
    function open() {
        if (m_str_type === "breach" && !(isdefined(var_fcfd2647) && var_fcfd2647)) {
            self notify(#"hash_722c5466076f75cf");
            var_fcfd2647 = 1;
            return;
        }
        self flag::set("open");
    }

    // Namespace cdoor/doors_shared
    // Params 0, eflags: 0x0
    // Checksum 0xc25988d8, Offset: 0x970
    // Size: 0x56
    function delete_door() {
        m_e_door delete();
        m_e_door = undefined;
        if (isdefined(m_e_trigger)) {
            m_e_trigger delete();
            m_e_trigger = undefined;
        }
    }

    // Namespace cdoor/doors_shared
    // Params 0, eflags: 0x0
    // Checksum 0x835ad120, Offset: 0x940
    // Size: 0x24
    function unlock() {
        self flag::clear("locked");
    }

    // Namespace cdoor/doors_shared
    // Params 0, eflags: 0x0
    // Checksum 0x634861d7, Offset: 0x900
    // Size: 0x34
    function lock() {
        self flag::set("locked");
        update_use_message();
    }

    // Namespace cdoor/doors_shared
    // Params 0, eflags: 0x0
    // Checksum 0xec996463, Offset: 0x7f0
    // Size: 0x106
    function init_hint_trigger() {
        if (isdefined(m_s_bundle.door_interact)) {
            return;
        }
        if (m_s_bundle.door_unlock_method === "default" && !(isdefined(m_s_bundle.door_trigger_at_target) && m_s_bundle.door_trigger_at_target)) {
            return;
        }
        v_offset = m_s_bundle.v_trigger_offset;
        n_radius = m_s_bundle.door_trigger_radius;
        v_pos = calculate_offset_position(m_e_door.origin, m_e_door.angles, v_offset);
        v_pos = (v_pos[0], v_pos[1], v_pos[2] + 50);
    }

    // Namespace cdoor/doors_shared
    // Params 0, eflags: 0x0
    // Checksum 0xaca4802b, Offset: 0x768
    // Size: 0x80
    function get_hack_angles() {
        v_angles = m_e_door.angles;
        if (isdefined(var_ccdffe96.target)) {
            e_target = getent(var_ccdffe96.target, "targetname");
            if (isdefined(e_target)) {
                return e_target.angles;
            }
        }
        return v_angles;
    }

    // Namespace cdoor/doors_shared
    // Params 0, eflags: 0x0
    // Checksum 0x17f9e2bb, Offset: 0x678
    // Size: 0xe8
    function get_hack_pos() {
        v_trigger_offset = m_s_bundle.v_trigger_offset;
        v_pos = calculate_offset_position(m_e_door.origin, m_e_door.angles, v_trigger_offset);
        v_pos = (v_pos[0], v_pos[1], v_pos[2] + 50);
        if (isdefined(var_ccdffe96.target)) {
            e_target = getent(var_ccdffe96.target, "targetname");
            if (isdefined(e_target)) {
                return e_target.origin;
            }
        }
        return v_pos;
    }

    // Namespace cdoor/doors_shared
    // Params 3, eflags: 0x0
    // Checksum 0x30fadb40, Offset: 0x428
    // Size: 0x244
    function init_door_model(e_or_str_model, connect_paths, s_door_instance) {
        if (isentity(e_or_str_model)) {
            m_e_door = e_or_str_model;
        } else if (!isdefined(e_or_str_model) && !isdefined(s_door_instance.model)) {
            e_or_str_model = "tag_origin";
        }
        if (!isdefined(m_e_door)) {
            m_e_door = util::spawn_model(e_or_str_model, s_door_instance.origin, s_door_instance.angles);
        }
        m_e_door function_fd08f849(33, 1);
        if (connect_paths) {
            m_e_door function_493935fc();
        }
        m_e_door.script_objective = s_door_instance.script_objective;
        var_9cf7e32 = {#origin:m_e_door.origin, #angles:m_e_door.angles};
        m_e_door thread doors::function_2e7830eb(self);
        if (isdefined(s_door_instance.linkname)) {
            var_8c831ea3 = getentarray(s_door_instance.linkname, "linkto");
            if (isdefined(s_door_instance.script_tag)) {
                array::run_all(var_8c831ea3, &linkto, m_e_door, s_door_instance.script_tag);
            } else {
                array::run_all(var_8c831ea3, &linkto, m_e_door);
            }
        }
        m_e_door thread function_9a01f62f();
    }

    // Namespace cdoor/doors_shared
    // Params 0, eflags: 0x0
    // Checksum 0xf2480051, Offset: 0x410
    // Size: 0xa
    function function_686b219() {
        return m_v_close_pos;
    }

}

// Namespace doors/doors_shared
// Params 0, eflags: 0x2
// Checksum 0xcd950042, Offset: 0x4790
// Size: 0x44
function autoexec __init__system__() {
    system::register(#"doors", &__init__, &__main__, undefined);
}

// Namespace doors/doors_shared
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x47e0
// Size: 0x4
function __init__() {
    
}

// Namespace doors/doors_shared
// Params 0, eflags: 0x0
// Checksum 0x28aba15d, Offset: 0x47f0
// Size: 0x1bc
function __main__() {
    level flagsys::wait_till("radiant_gameobjects_initialized");
    var_1a50de1c = getgametypesetting(#"use_doors");
    var_5ed54377 = getdvarint(#"disabledoors", 0);
    if (!(isdefined(var_1a50de1c) && var_1a50de1c) || isdefined(var_5ed54377) && var_5ed54377) {
        return;
    }
    a_doors = struct::get_array("scriptbundle_doors", "classname");
    a_doors = arraycombine(a_doors, getentarray("smart_object_door", "script_noteworthy"), 0, 0);
    foreach (s_instance in a_doors) {
        c_door = s_instance init();
        if (isdefined(c_door)) {
            s_instance.c_door = c_door;
        }
    }
    level thread init_door_panels();
}

// Namespace doors/doors_shared
// Params 0, eflags: 0x0
// Checksum 0xa38e80c2, Offset: 0x49b8
// Size: 0x168
function init_door_panels() {
    a_door_panels = struct::get_array("smart_object_door_panel", "script_noteworthy");
    a_door_panels = arraycombine(a_door_panels, getentarray("smart_object_door_panel", "script_noteworthy"), 0, 0);
    a_door_panels = arraycombine(a_door_panels, struct::get_array("scriptbundle_gameobject", "classname"), 0, 0);
    foreach (door_panel in a_door_panels) {
        if (isdefined(door_panel.script_gameobject) || isdefined(door_panel.mdl_gameobject)) {
            if (!isdefined(door_panel.mdl_gameobject)) {
                door_panel gameobjects::init_game_objects(door_panel.script_gameobject);
            }
            door_panel setup_doors_with_panel();
        }
    }
}

// Namespace doors/doors_shared
// Params 0, eflags: 0x0
// Checksum 0x81d7e4b6, Offset: 0x4b28
// Size: 0x198
function setup_doors_with_panel() {
    var_f20f3baf = 0;
    if (isdefined(self.target)) {
        a_e_doors = getentarray(self.target, "targetname");
        a_e_doors = arraycombine(a_e_doors, struct::get_array(self.target, "targetname"), 0, 0);
        foreach (e_door in a_e_doors) {
            if (isdefined(e_door) && isdefined(e_door.c_door)) {
                door = e_door.c_door;
                [[ door ]]->remove_door_trigger();
                if (!var_f20f3baf) {
                    if (isdefined(door.m_s_bundle.door_closes) && door.m_s_bundle.door_closes) {
                        var_4a20f9ea = 1;
                    } else {
                        var_4a20f9ea = 0;
                    }
                    var_f20f3baf = 1;
                    self thread door_panel_interact(var_4a20f9ea);
                }
            }
        }
    }
}

// Namespace doors/doors_shared
// Params 1, eflags: 0x0
// Checksum 0x5d421b63, Offset: 0x4cc8
// Size: 0x396
function door_panel_interact(b_is_panel_reusable) {
    self endon(#"death");
    self.mdl_gameobject endon(#"death");
    while (true) {
        waitresult = self.mdl_gameobject waittill(#"gameobject_end_use_player");
        e_player = waitresult.player;
        self.mdl_gameobject gameobjects::disable_object(1);
        if (isdefined(self.target)) {
            a_e_doors = getentarray(self.target, "targetname");
            a_e_doors = arraycombine(a_e_doors, struct::get_array(self.target, "targetname"), 0, 0);
            foreach (e_door in a_e_doors) {
                if (isdefined(e_door) && isdefined(e_door.c_door)) {
                    door = e_door.c_door;
                    [[ door ]]->unlock();
                    [[ door ]]->set_player_who_opened(e_player);
                    if ([[ door ]]->is_open()) {
                        [[ door ]]->close();
                        if (!(isdefined(door.m_s_bundle.door_closes) && door.m_s_bundle.door_closes) && isdefined(door.m_s_bundle.var_b4742012) && door.m_s_bundle.var_b4742012) {
                            door notify(#"set_destructible", {#player:e_player});
                        }
                        continue;
                    }
                    [[ door ]]->open();
                }
            }
            waitframe(1);
            if (isdefined(b_is_panel_reusable) && b_is_panel_reusable) {
                while (true) {
                    b_door_animating = 0;
                    foreach (e_door in a_e_doors) {
                        if (isdefined(e_door) && isdefined(e_door.c_door)) {
                            door = e_door.c_door;
                            if (door flag::get("animating")) {
                                b_door_animating = 1;
                                break;
                            }
                        }
                    }
                    if (!b_door_animating) {
                        break;
                    }
                    waitframe(1);
                }
                self.mdl_gameobject gameobjects::enable_object(1);
                continue;
            }
            return;
        }
    }
}

// Namespace doors/doors_shared
// Params 0, eflags: 0x0
// Checksum 0x1d17f121, Offset: 0x5068
// Size: 0x92
function init() {
    if (!isdefined(self.angles)) {
        self.angles = (0, 0, 0);
    }
    s_door_bundle = struct::get_script_bundle("doors", isdefined(self.var_df1e88e4) ? self.var_df1e88e4 : self.scriptbundlename);
    c_door = new cdoor();
    return setup_door_info(s_door_bundle, self, c_door);
}

// Namespace doors/doors_shared
// Params 3, eflags: 0x0
// Checksum 0x9944dcac, Offset: 0x5108
// Size: 0xc30
function setup_door_info(s_door_bundle, s_door_instance, c_door) {
    c_door flag::init("locked");
    c_door flag::init("open");
    c_door flag::init("animating");
    c_door flag::init("door_fully_closed");
    if (!isdefined(s_door_bundle)) {
        s_door_bundle = spawnstruct();
        s_door_bundle.door_open_method = s_door_instance.door_open_method;
        s_door_bundle.var_7dd88209 = s_door_instance.var_7dd88209;
        s_door_bundle.door_slide_horizontal = s_door_instance.door_slide_horizontal;
        s_door_bundle.door_slide_horizontal_y = s_door_instance.door_slide_horizontal_y;
        s_door_bundle.door_open_time = s_door_instance.door_open_time;
        s_door_bundle.door_slide_open_units = s_door_instance.door_slide_open_units;
        s_door_bundle.door_swing_angle = s_door_instance.door_swing_angle;
        s_door_bundle.var_38cbf3c2 = s_door_instance.var_38cbf3c2;
        s_door_bundle.door_closes = s_door_instance.door_closes;
        s_door_bundle.var_b4742012 = s_door_instance.var_b4742012;
        s_door_bundle.door_start_open = s_door_instance.door_start_open;
        s_door_bundle.door_triggeroffsetx = s_door_instance.door_triggeroffset[0];
        s_door_bundle.door_triggeroffsety = s_door_instance.door_triggeroffset[1];
        s_door_bundle.door_triggeroffsetz = s_door_instance.door_triggeroffset[2];
        s_door_bundle.door_trigger_radius = s_door_instance.door_trigger_radius;
        s_door_bundle.door_start_sound = s_door_instance.door_start_sound;
        s_door_bundle.door_loop_sound = s_door_instance.door_loop_sound;
        s_door_bundle.door_stop_sound = s_door_instance.door_stop_sound;
        s_door_bundle.door_animated_open_bundle = s_door_instance.door_animated_open_bundle;
        s_door_bundle.door_animated_close_bundle = s_door_instance.door_animated_close_bundle;
        s_door_bundle.var_86036ab7 = s_door_instance.var_86036ab7;
        s_door_bundle.model = s_door_instance;
        s_door_instance.door_open_method = undefined;
        s_door_instance.var_7dd88209 = undefined;
        s_door_instance.door_slide_horizontal = undefined;
        s_door_instance.door_slide_horizontal_y = undefined;
        s_door_instance.door_open_time = undefined;
        s_door_instance.door_slide_open_units = undefined;
        s_door_instance.door_swing_angle = undefined;
        s_door_instance.var_38cbf3c2 = undefined;
        s_door_instance.door_closes = undefined;
        s_door_instance.var_b4742012 = undefined;
        s_door_instance.door_start_open = undefined;
        s_door_instance.door_triggeroffsetx = undefined;
        s_door_instance.door_triggeroffsety = undefined;
        s_door_instance.door_triggeroffsetz = undefined;
        s_door_instance.door_trigger_radius = undefined;
        s_door_instance.door_start_sound = undefined;
        s_door_instance.door_loop_sound = undefined;
        s_door_instance.door_stop_sound = undefined;
        s_door_instance.door_animated_open_bundle = undefined;
        s_door_instance.door_animated_close_bundle = undefined;
        s_door_instance.var_86036ab7 = undefined;
        s_door_instance.var_afe6dd40 = undefined;
        s_door_instance.var_b14ce3e8 = undefined;
        s_door_instance.var_522f6941 = undefined;
        s_door_instance.var_9e345e13 = undefined;
    }
    c_door.m_s_bundle = s_door_bundle;
    c_door.var_ccdffe96 = s_door_instance;
    if (isdefined(s_door_instance.target)) {
        a_target_ents = getentarray(s_door_instance.target, "targetname");
        foreach (ent in a_target_ents) {
            if (ent.objectid === "clip_player_doorway") {
                if (isdefined(ent.script_door_enable_player_clip) && ent.script_door_enable_player_clip) {
                    ent.targetname = undefined;
                    c_door.m_e_player_clip = ent;
                } else {
                    ent delete();
                }
                continue;
            }
            if (ent trigger::is_trigger_of_type()) {
                c_door.m_s_bundle.door_trigger_at_target = 1;
            }
        }
    }
    if (c_door.m_s_bundle.door_unlock_method === "hack" && !(isdefined(level.door_hack_precached) && level.door_hack_precached)) {
        level.door_hack_precached = 1;
    }
    e_or_str_door_model = c_door.m_s_bundle.model;
    if (isdefined(c_door.m_s_bundle.door_triggeroffsetx)) {
        n_xoffset = c_door.m_s_bundle.door_triggeroffsetx;
    } else {
        n_xoffset = 0;
    }
    if (isdefined(c_door.m_s_bundle.door_triggeroffsety)) {
        n_yoffset = c_door.m_s_bundle.door_triggeroffsety;
    } else {
        n_yoffset = 0;
    }
    if (isdefined(c_door.m_s_bundle.door_triggeroffsetz)) {
        n_zoffset = c_door.m_s_bundle.door_triggeroffsetz;
    } else {
        n_zoffset = 0;
    }
    v_trigger_offset = (n_xoffset, n_yoffset, n_zoffset);
    c_door.m_s_bundle.v_trigger_offset = v_trigger_offset;
    n_trigger_radius = c_door.m_s_bundle.door_trigger_radius;
    if (isdefined(c_door.m_s_bundle.door_slide_horizontal) && c_door.m_s_bundle.door_slide_horizontal) {
        if (isdefined(c_door.m_s_bundle.door_slide_horizontal_y) && c_door.m_s_bundle.door_slide_horizontal_y) {
            str_slide_dir = "Y";
        } else {
            str_slide_dir = "X";
        }
    } else {
        str_slide_dir = "Z";
    }
    n_open_time = c_door.m_s_bundle.door_open_time;
    n_slide_amount = c_door.m_s_bundle.door_slide_open_units;
    if (!isdefined(c_door.m_s_bundle.door_swing_angle)) {
        c_door.m_s_bundle.door_swing_angle = 0;
    }
    if (!isdefined(c_door.m_s_bundle.var_38cbf3c2)) {
        c_door.m_s_bundle.var_38cbf3c2 = 0;
    }
    if (isdefined(c_door.m_s_bundle.door_closes) && c_door.m_s_bundle.door_closes) {
        n_door_closes = 1;
    } else {
        n_door_closes = 0;
    }
    if (isdefined(c_door.m_s_bundle.door_connect_paths) && c_door.m_s_bundle.door_connect_paths) {
        n_door_connect_paths = 1;
    } else {
        n_door_connect_paths = 0;
    }
    if (isdefined(s_door_instance.script_obstruction_cover_open)) {
        c_door.var_333a0956 = getnodearray(s_door_instance.script_obstruction_cover_open, "script_obstruction_cover_open");
    }
    if (isdefined(s_door_instance.script_obstruction_cover_close)) {
        c_door.var_c9a68002 = getnodearray(s_door_instance.script_obstruction_cover_close, "script_obstruction_cover_close");
    }
    [[ c_door ]]->function_91c5f477(0);
    if (isdefined(c_door.m_s_bundle.door_start_open) && c_door.m_s_bundle.door_start_open) {
        c_door flag::set("open");
    }
    if (isdefined(c_door.var_ccdffe96.script_flag)) {
        a_flags = strtok(c_door.var_ccdffe96.script_flag, ",");
        foreach (str_flag in a_flags) {
            level flag::init(str_flag);
        }
    }
    [[ c_door ]]->init_door_model(e_or_str_door_model, n_door_connect_paths, s_door_instance);
    [[ c_door ]]->init_trigger(v_trigger_offset, n_trigger_radius, c_door.m_s_bundle);
    [[ c_door ]]->init_player_spawns();
    [[ c_door ]]->init_hint_trigger();
    thread [[ c_door ]]->run_lock_fx();
    [[ c_door ]]->init_movement(str_slide_dir, n_slide_amount);
    if (!isdefined(c_door.m_s_bundle.door_open_time)) {
        c_door.m_s_bundle.door_open_time = 0.4;
    }
    [[ c_door ]]->set_door_paths(n_door_connect_paths);
    if (isdefined(s_door_instance.script_delay)) {
        [[ c_door ]]->function_5eee5687(s_door_instance.script_delay);
    }
    c_door.m_s_bundle.b_loop_sound = isdefined(c_door.m_s_bundle.door_loop_sound) && c_door.m_s_bundle.door_loop_sound != "";
    if (isdefined(s_door_instance.var_fa656f24) && s_door_instance.var_fa656f24) {
        c_door thread function_ef30ff59(1);
    } else {
        level thread door_update(c_door);
    }
    if (isdefined(c_door.m_s_bundle.var_b4742012) && c_door.m_s_bundle.var_b4742012) {
        level thread function_8deeb6b7(c_door);
    }
    return c_door;
}

// Namespace doors/doors_shared
// Params 1, eflags: 0x0
// Checksum 0x4b47a716, Offset: 0x5d40
// Size: 0x3f8
function door_open_update(c_door) {
    if (!isdefined(c_door.m_e_trigger)) {
        return;
    }
    c_door.m_e_trigger endon(#"death");
    str_unlock_method = "default";
    if (isdefined(c_door.m_s_bundle.door_unlock_method)) {
        str_unlock_method = c_door.m_s_bundle.door_unlock_method;
    }
    b_auto_close = isdefined(c_door.m_s_bundle.door_closes) && c_door.m_s_bundle.door_closes && !(isdefined(c_door.m_s_bundle.door_use_trigger) && c_door.m_s_bundle.door_use_trigger);
    b_hold_open = isdefined(c_door.m_s_bundle.door_use_hold) && c_door.m_s_bundle.door_use_hold;
    b_manual_close = isdefined(c_door.m_s_bundle.door_use_trigger) && c_door.m_s_bundle.door_use_trigger && isdefined(c_door.m_s_bundle.door_closes) && c_door.m_s_bundle.door_closes;
    while (true) {
        waitresult = c_door.m_e_trigger waittill(#"trigger");
        e_who = waitresult.activator;
        c_door.m_e_trigger_player = e_who;
        if (c_door.var_ccdffe96.script_team !== #"any" && !c_door.m_e_trigger_player util::is_on_side(c_door.var_ccdffe96.script_team)) {
            continue;
        }
        if (!c_door flag::get("open")) {
            if (!c_door flag::get("locked")) {
                if (b_hold_open || b_auto_close) {
                    [[ c_door ]]->open();
                    if (b_hold_open) {
                        if (isplayer(e_who)) {
                            e_who player_freeze_in_place(1);
                            e_who disableweapons();
                            e_who disableoffhandweapons();
                        }
                    }
                    door_wait_until_clear(c_door, e_who);
                    [[ c_door ]]->close();
                    if (b_hold_open) {
                        waitframe(1);
                        c_door flag::wait_till_clear("animating");
                        if (isplayer(e_who)) {
                            e_who player_freeze_in_place(0);
                            e_who enableweapons();
                            e_who enableoffhandweapons();
                        }
                    }
                } else {
                    [[ c_door ]]->open();
                }
            }
            continue;
        }
        if (b_manual_close) {
            [[ c_door ]]->close();
        }
    }
}

// Namespace doors/doors_shared
// Params 1, eflags: 0x0
// Checksum 0x131e6d65, Offset: 0x6140
// Size: 0x2f6
function door_update(c_door) {
    c_door notify(#"end_door_update");
    c_door endon(#"end_door_update");
    str_unlock_method = "default";
    if (isdefined(c_door.m_s_bundle.door_unlock_method)) {
        str_unlock_method = c_door.m_s_bundle.door_unlock_method;
    }
    if (isdefined(c_door.m_s_bundle.door_locked) && c_door.m_s_bundle.door_locked) {
        c_door flag::set("locked");
        if (isdefined(c_door.var_ccdffe96.targetname)) {
            thread door_update_lock_scripted(c_door);
        }
    }
    thread door_open_update(c_door);
    [[ c_door ]]->update_use_message();
    while (true) {
        if (c_door flag::get("locked")) {
            c_door flag::wait_till_clear("locked");
        }
        c_door flag::wait_till("open");
        if (c_door.m_door_open_delay_time > 0) {
            c_door.m_e_door notify(#"door_waiting_to_open", {#player:c_door.m_e_trigger_player});
            wait c_door.m_door_open_delay_time;
        }
        [[ c_door ]]->open_internal();
        c_door flag::wait_till_clear("open");
        [[ c_door ]]->close_internal();
        if (!(isdefined(c_door.m_s_bundle.door_closes) && c_door.m_s_bundle.door_closes)) {
            if (isdefined(c_door.m_s_bundle.var_b4742012) && c_door.m_s_bundle.var_b4742012) {
                c_door notify(#"set_destructible", {#player:c_door.m_e_trigger_player});
            }
            break;
        }
        waitframe(1);
    }
    if (isdefined(c_door.m_e_trigger)) {
        c_door.m_e_trigger delete();
        c_door.m_e_trigger = undefined;
    }
}

// Namespace doors/doors_shared
// Params 1, eflags: 0x0
// Checksum 0xc305cbeb, Offset: 0x6440
// Size: 0xa8
function door_update_lock_scripted(c_door) {
    door_str = c_door.var_ccdffe96.targetname;
    c_door.m_e_trigger.targetname = door_str + "_trig";
    c_door.m_e_trigger endon(#"death");
    while (true) {
        c_door.m_e_trigger waittill(#"unlocked");
        [[ c_door ]]->unlock();
    }
}

// Namespace doors/doors_shared
// Params 1, eflags: 0x0
// Checksum 0x13fee8ec, Offset: 0x64f0
// Size: 0x498
function function_8deeb6b7(c_door) {
    e_door = c_door.m_e_door;
    e_door endon(#"door_cleared", #"delete");
    assert(isdefined(e_door), "<dev string:xdf>");
    e_door setcandamage(0);
    waitresult = c_door waittill(#"set_destructible");
    e_door waittill(#"door_closed");
    e_door setcandamage(1);
    e_door setteam(waitresult.player.team);
    if (isdefined(c_door.var_ccdffe96) && isdefined(c_door.var_ccdffe96.script_make_full_sentient) && c_door.var_ccdffe96.script_make_full_sentient) {
        e_door makesentient();
        e_door.canbemeleed = 0;
    } else {
        e_door util::function_e831de44();
    }
    target_set(e_door);
    level notify(#"hash_9db88375ef038b", {#c_door:c_door, #player:waitresult.player});
    e_door val::set(#"hash_25bedd86747e41e1", "takedamage", 1);
    e_door val::set(#"hash_25bedd86747e41e1", "allowdeath", 1);
    if (isdefined(c_door.m_s_bundle.var_62ef0903)) {
        e_door.health = c_door.m_s_bundle.var_62ef0903;
    } else {
        e_door.health = 10000;
    }
    if (isdefined(c_door.m_s_bundle.var_49170749)) {
        e_door.script_health = e_door.health;
        e_door thread scene::init(c_door.m_s_bundle.var_49170749, e_door);
        e_door waittill(#"hash_18be12558bc58fe");
    } else {
        while (e_door.health > 0) {
            e_door waittill(#"damage");
        }
        e_door ghost();
    }
    target_remove(e_door);
    if (issentient(e_door)) {
        e_door function_32aff240();
    } else if (function_a5354464(e_door)) {
        e_door function_139eb72b();
    }
    e_door val::reset(#"hash_25bedd86747e41e1", "takedamage");
    e_door val::reset(#"hash_25bedd86747e41e1", "allowdeath");
    e_door.health = 0;
    if (isdefined(c_door.m_s_bundle.var_a6e14a23)) {
        playfxontag(c_door.m_s_bundle.var_a6e14a23, e_door, "tag_origin");
    }
    e_door notsolid();
    e_door function_7da936d3();
    e_door notify(#"door_cleared");
}

// Namespace doors/doors_shared
// Params 1, eflags: 0x0
// Checksum 0xb49ce22c, Offset: 0x6990
// Size: 0x11c
function player_freeze_in_place(b_do_freeze) {
    if (!b_do_freeze) {
        if (isdefined(self.freeze_origin)) {
            self unlink();
            self.freeze_origin delete();
            self.freeze_origin = undefined;
        }
        return;
    }
    if (!isdefined(self.freeze_origin)) {
        self.freeze_origin = spawn("script_model", self.origin);
        self.freeze_origin setmodel(#"tag_origin");
        self.freeze_origin.angles = self.angles;
        self playerlinktodelta(self.freeze_origin, "tag_origin", 1, 45, 45, 45, 45);
    }
}

// Namespace doors/doors_shared
// Params 1, eflags: 0x0
// Checksum 0x32473416, Offset: 0x6ab8
// Size: 0xe2
function function_fb969e9b(c_door) {
    allentities = getentitiesinradius([[ c_door ]]->function_686b219(), 30);
    entcount = 0;
    foreach (entity in allentities) {
        if (isplayer(entity)) {
            continue;
        }
        if (!isdefined(entity.weapon)) {
            continue;
        }
        entcount++;
    }
    return entcount == 0;
}

// Namespace doors/doors_shared
// Params 1, eflags: 0x0
// Checksum 0x68a3cd2f, Offset: 0x6ba8
// Size: 0x126
function trigger_wait_until_clear(c_door) {
    self endon(#"death");
    last_trigger_time = gettime();
    self.ents_in_trigger = 1;
    str_kill_trigger_notify = "trigger_now_clear";
    self thread trigger_check_for_ents_touching(str_kill_trigger_notify);
    while (true) {
        time = gettime();
        if (self.ents_in_trigger == 1) {
            self.ents_in_trigger = 0;
            last_trigger_time = time;
        }
        var_8cd0e281 = 0;
        dt = float(time - last_trigger_time) / 1000;
        if (dt >= 0.3) {
            var_8cd0e281 = 1;
        }
        if (var_8cd0e281 && function_fb969e9b(c_door)) {
            break;
        }
        waitframe(1);
    }
    self notify(str_kill_trigger_notify);
}

// Namespace doors/doors_shared
// Params 3, eflags: 0x0
// Checksum 0xfc9ffdfe, Offset: 0x6cd8
// Size: 0xee
function door_wait_until_user_release(c_door, e_triggerer, str_kill_on_door_notify) {
    if (isdefined(str_kill_on_door_notify)) {
        c_door endon(str_kill_on_door_notify);
    }
    wait 0.25;
    max_dist_sq = c_door.m_s_bundle.door_trigger_radius * c_door.m_s_bundle.door_trigger_radius;
    b_pressed = 1;
    n_dist = 0;
    do {
        waitframe(1);
        b_pressed = e_triggerer usebuttonpressed();
        n_dist = distancesquared(e_triggerer.origin, self.origin);
    } while (b_pressed && n_dist < max_dist_sq);
}

// Namespace doors/doors_shared
// Params 2, eflags: 0x0
// Checksum 0x36975a64, Offset: 0x6dd0
// Size: 0xac
function door_wait_until_clear(c_door, e_triggerer) {
    e_trigger = c_door.m_e_trigger;
    if (isplayer(e_triggerer) && isdefined(c_door.m_s_bundle.door_use_hold) && c_door.m_s_bundle.door_use_hold) {
        c_door.m_e_trigger door_wait_until_user_release(c_door, e_triggerer);
    }
    e_trigger trigger_wait_until_clear(c_door);
}

// Namespace doors/doors_shared
// Params 1, eflags: 0x0
// Checksum 0xe371b1d9, Offset: 0x6e88
// Size: 0x5a
function trigger_check_for_ents_touching(str_kill_trigger_notify) {
    self endon(#"death");
    self endon(str_kill_trigger_notify);
    while (true) {
        self waittill(#"trigger");
        self.ents_in_trigger = 1;
    }
}

// Namespace doors/doors_shared
// Params 1, eflags: 0x0
// Checksum 0x6005ed98, Offset: 0x6ef0
// Size: 0x98
function door_debug_line(v_origin) {
    self endon(#"death");
    while (true) {
        v_start = v_origin;
        v_end = v_start + (0, 0, 1000);
        v_col = (0, 0, 1);
        /#
            line(v_start, v_end, (0, 0, 1));
        #/
        wait 0.1;
    }
}

// Namespace doors/doors_shared
// Params 3, eflags: 0x0
// Checksum 0x7ff780e2, Offset: 0x6f90
// Size: 0x144
function unlock(str_value, str_key = "targetname", b_do_open = 1) {
    if (isdefined(self.c_door)) {
        [[ self.c_door ]]->unlock();
        if (b_do_open) {
            [[ self.c_door ]]->open();
        }
        return;
    }
    a_e_doors = get_doors(str_value, str_key);
    foreach (e_door in a_e_doors) {
        if (isdefined(e_door.c_door)) {
            [[ e_door.c_door ]]->unlock();
            if (b_do_open) {
                [[ e_door.c_door ]]->open();
            }
        }
    }
}

// Namespace doors/doors_shared
// Params 1, eflags: 0x0
// Checksum 0xc29b28c2, Offset: 0x70e0
// Size: 0x34
function unlock_all(b_do_open = 1) {
    unlock(undefined, undefined, b_do_open);
}

// Namespace doors/doors_shared
// Params 3, eflags: 0x0
// Checksum 0xb4404d20, Offset: 0x7120
// Size: 0x144
function lock(str_value, str_key = "targetname", b_do_close = 1) {
    if (isdefined(self.c_door)) {
        if (b_do_close) {
            [[ self.c_door ]]->close();
        }
        [[ self.c_door ]]->lock();
        return;
    }
    a_e_doors = get_doors(str_value, str_key);
    foreach (e_door in a_e_doors) {
        if (isdefined(e_door.c_door)) {
            if (b_do_close) {
                [[ e_door.c_door ]]->close();
            }
            [[ e_door.c_door ]]->lock();
        }
    }
}

// Namespace doors/doors_shared
// Params 1, eflags: 0x0
// Checksum 0xaf77b195, Offset: 0x7270
// Size: 0x34
function lock_all(b_do_close = 1) {
    lock(undefined, undefined, b_do_close);
}

// Namespace doors/doors_shared
// Params 2, eflags: 0x0
// Checksum 0xd5aeb08c, Offset: 0x72b0
// Size: 0xf0
function open(str_value, str_key = "targetname") {
    if (isdefined(self.c_door)) {
        [[ self.c_door ]]->open();
        return;
    }
    a_e_doors = get_doors(str_value, str_key);
    foreach (e_door in a_e_doors) {
        if (isdefined(e_door.c_door)) {
            [[ e_door.c_door ]]->open();
        }
    }
}

// Namespace doors/doors_shared
// Params 0, eflags: 0x0
// Checksum 0x5a858ff3, Offset: 0x73a8
// Size: 0x14
function open_all() {
    open();
}

// Namespace doors/doors_shared
// Params 2, eflags: 0x0
// Checksum 0xa870ce37, Offset: 0x73c8
// Size: 0xf0
function close(str_value, str_key = "targetname") {
    if (isdefined(self.c_door)) {
        [[ self.c_door ]]->open();
        return;
    }
    a_e_doors = get_doors(str_value, str_key);
    foreach (e_door in a_e_doors) {
        if (isdefined(e_door.c_door)) {
            [[ e_door.c_door ]]->close();
        }
    }
}

// Namespace doors/doors_shared
// Params 0, eflags: 0x0
// Checksum 0xdba167f1, Offset: 0x74c0
// Size: 0x14
function close_all() {
    close();
}

// Namespace doors/doors_shared
// Params 0, eflags: 0x0
// Checksum 0xd1124282, Offset: 0x74e0
// Size: 0x22
function is_open() {
    return self.c_door flag::get("open");
}

// Namespace doors/doors_shared
// Params 2, eflags: 0x0
// Checksum 0x4394a97f, Offset: 0x7510
// Size: 0x138
function waittill_door_opened(str_value, str_key = "targetname") {
    if (isdefined(self.c_door)) {
        self.c_door flag::wait_till("open");
        return;
    }
    a_e_doors = get_doors(str_value, str_key);
    while (true) {
        var_c22d57ea = 1;
        foreach (e_door in a_e_doors) {
            if (!e_door.c_door flag::get("open")) {
                var_c22d57ea = 0;
                break;
            }
        }
        if (var_c22d57ea) {
            return;
        }
        waitframe(1);
    }
}

// Namespace doors/doors_shared
// Params 2, eflags: 0x0
// Checksum 0x9cd6970e, Offset: 0x7650
// Size: 0x182
function waittill_door_closed(str_value, str_key = "targetname") {
    if (isdefined(self.c_door)) {
        self.c_door flag::wait_till_clear("open");
        self.c_door flag::wait_till_clear("animating");
        return;
    }
    a_e_doors = get_doors(str_value, str_key);
    while (true) {
        var_cfb1692e = 1;
        foreach (e_door in a_e_doors) {
            if (e_door.c_door flag::get("open") || e_door.c_door flag::get("animating")) {
                var_cfb1692e = 0;
                break;
            }
        }
        if (var_cfb1692e) {
            return;
        }
        waitframe(1);
    }
}

// Namespace doors/doors_shared
// Params 2, eflags: 0x0
// Checksum 0x64915041, Offset: 0x77e0
// Size: 0x11a
function get_doors(str_value, str_key = "targetname") {
    if (isdefined(str_value)) {
        a_e_doors = struct::get_array(str_value, str_key);
        a_e_doors = arraycombine(a_e_doors, getentarray(str_value, str_key), 0, 0);
    } else {
        a_e_doors = struct::get_array("scriptbundle_doors", "classname");
        a_e_doors = arraycombine(a_e_doors, struct::get_array("scriptbundle_obstructions", "classname"), 0, 0);
        a_e_doors = arraycombine(a_e_doors, getentarray("smart_object_door", "script_noteworthy"), 0, 0);
    }
    return a_e_doors;
}

// Namespace doors/doors_shared
// Params 2, eflags: 0x0
// Checksum 0x14132fcd, Offset: 0x7908
// Size: 0xe0
function function_5a3c5056(str_value, str_key = "targetname") {
    if (isdefined(self.c_door)) {
        [[ self.c_door ]]->delete_door();
        return;
    }
    a_e_doors = get_doors(str_value, str_key);
    foreach (e_door in a_e_doors) {
        [[ e_door.c_door ]]->delete_door();
    }
}

// Namespace doors/doors_shared
// Params 3, eflags: 0x0
// Checksum 0x9aa0b629, Offset: 0x79f0
// Size: 0x138
function function_ef30ff59(b_enable, str_value, str_key = "targetname") {
    if (isclass(self)) {
        self thread function_cdb5742a(b_enable);
        return;
    }
    if (isdefined(self.c_door)) {
        self.c_door thread function_cdb5742a(b_enable);
        return;
    }
    a_e_doors = get_doors(str_value, str_key);
    foreach (e_door in a_e_doors) {
        if (isdefined(e_door.c_door)) {
            e_door.c_door thread function_cdb5742a(b_enable);
        }
    }
}

// Namespace doors/doors_shared
// Params 1, eflags: 0x4
// Checksum 0x3edbe574, Offset: 0x7b30
// Size: 0x68
function private function_cdb5742a(b_enable) {
    self.m_e_door endon(#"death");
    self notify(#"hash_50b9293fc24e2756");
    self endon(#"hash_50b9293fc24e2756");
    [[ self ]]->close_internal();
    thread [[ self ]]->function_f2f2f202(b_enable);
}

// Namespace doors/doors_shared
// Params 1, eflags: 0x4
// Checksum 0x6bf126cf, Offset: 0x7ba0
// Size: 0x28
function private function_2e7830eb(c_door) {
    self waittill(#"death");
    c_door = undefined;
}

// Namespace doors/doors_shared
// Params 2, eflags: 0x0
// Checksum 0xedc01585, Offset: 0x7bd0
// Size: 0x88
function function_9878d670(str_value, str_key = "targetname") {
    if (isdefined(self.c_door)) {
        return self.c_door.m_e_door;
    }
    a_e_doors = get_doors(str_value, str_key);
    return a_e_doors[0].c_door.m_e_door;
}

