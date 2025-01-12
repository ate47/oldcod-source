#using scripts/core_common/flag_shared;
#using scripts/core_common/flagsys_shared;
#using scripts/core_common/gameobjects_shared;
#using scripts/core_common/hud_util_shared;
#using scripts/core_common/scene_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/trigger_shared;
#using scripts/core_common/util_shared;

#namespace doors;

// Namespace doors
// Method(s) 28 Total 28
class cdoor {

    var m_door_open_delay_time;
    var m_e_door;
    var m_e_trigger;
    var m_e_trigger_player;
    var m_n_door_connect_paths;
    var m_n_trigger_height;
    var m_s_bundle;
    var m_v_close_pos;
    var m_v_open_pos;
    var var_133df857;
    var var_1484043e;
    var var_7e16e483;
    var var_b4d34742;
    var var_d6ef8c9d;

    // Namespace cdoor/doors_shared
    // Params 1, eflags: 0x0
    // Checksum 0x773e467c, Offset: 0x1ee8
    // Size: 0x1c
    function function_4facda28(delay_time) {
        m_door_open_delay_time = delay_time;
    }

    // Namespace cdoor/doors_shared
    // Params 0, eflags: 0x0
    // Checksum 0xd5478332, Offset: 0x1e90
    // Size: 0x4c
    function function_ad665f20() {
        if (isdefined(var_b4d34742)) {
            angle = var_b4d34742;
        } else {
            angle = m_s_bundle.door_swing_angle;
        }
        return angle;
    }

    // Namespace cdoor/doors_shared
    // Params 1, eflags: 0x0
    // Checksum 0x2c320fe8, Offset: 0x1e68
    // Size: 0x1c
    function function_207f7798(angle) {
        var_b4d34742 = angle;
    }

    // Namespace cdoor/doors_shared
    // Params 3, eflags: 0x0
    // Checksum 0x84bedc40, Offset: 0x1d48
    // Size: 0x118
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
    // Checksum 0x4559303c, Offset: 0x1d20
    // Size: 0x1c
    function set_door_paths(n_door_connect_paths) {
        m_n_door_connect_paths = n_door_connect_paths;
    }

    // Namespace cdoor/doors_shared
    // Params 0, eflags: 0x0
    // Checksum 0x426635cf, Offset: 0x1c58
    // Size: 0xbe
    function init_player_spawns() {
        if (isdefined(var_7e16e483)) {
            a_structs = struct::get_array(var_7e16e483, "target");
            foreach (struct in a_structs) {
                struct.c_door = self;
            }
        }
    }

    // Namespace cdoor/doors_shared
    // Params 2, eflags: 0x0
    // Checksum 0x6ce30b75, Offset: 0x1b38
    // Size: 0x118
    function init_movement(str_slide_dir, n_slide_amount) {
        if (m_s_bundle.door_open_method == "slide") {
            switch (str_slide_dir) {
            case #"x":
                v_offset = (n_slide_amount, 0, 0);
                break;
            case #"y":
                v_offset = (0, n_slide_amount, 0);
                break;
            case #"z":
                v_offset = (0, 0, n_slide_amount);
                break;
            default:
                v_offset = (0, 0, n_slide_amount);
                break;
            }
            m_v_open_pos = calculate_offset_position(m_e_door.origin, m_e_door.angles, v_offset);
            m_v_close_pos = m_e_door.origin;
        }
    }

    // Namespace cdoor/doors_shared
    // Params 1, eflags: 0x0
    // Checksum 0x6c6bbd22, Offset: 0x1a30
    // Size: 0xfa
    function set_script_flags(b_set) {
        if (isdefined(var_d6ef8c9d)) {
            a_flags = strtok(var_d6ef8c9d, ",");
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
    // Checksum 0x93d14bfc, Offset: 0x1730
    // Size: 0x2f4
    function init_trigger(v_offset, n_radius) {
        v_pos = calculate_offset_position(m_e_door.origin, m_e_door.angles, v_offset);
        v_pos = (v_pos[0], v_pos[1], v_pos[2] + 50);
        if (isdefined(m_s_bundle.door_trigger_at_target) && m_s_bundle.door_trigger_at_target && isdefined(var_1484043e)) {
            e_target = getent(var_1484043e, "targetname");
            if (isdefined(e_target)) {
                if (e_target trigger::is_trigger_of_type("trigger_multiple", "trigger_radius", "trigger_box")) {
                    t_radius_or_multiple = e_target;
                } else if (e_target trigger::is_trigger_of_type("trigger_use", "trigger_use_touch")) {
                    t_use = e_target;
                    m_s_bundle.door_use_trigger = 1;
                }
                v_pos = e_target.origin;
            }
        }
        if (isdefined(m_s_bundle.door_use_trigger) && m_s_bundle.door_use_trigger) {
            if (isdefined(t_use)) {
                m_e_trigger = t_use;
            } else {
                m_e_trigger = spawn("trigger_radius_use", v_pos, 0, n_radius, m_n_trigger_height);
            }
            m_e_trigger triggerignoreteam();
            m_e_trigger setvisibletoall();
            m_e_trigger setteamfortrigger("none");
            m_e_trigger usetriggerrequirelookat();
            m_e_trigger setcursorhint("HINT_NOICON");
            return;
        }
        if (isdefined(t_radius_or_multiple)) {
            m_e_trigger = t_radius_or_multiple;
            return;
        }
        m_e_trigger = spawn("trigger_radius", v_pos, 0, n_radius, m_n_trigger_height);
    }

    // Namespace cdoor/doors_shared
    // Params 0, eflags: 0x0
    // Checksum 0xc0b7f0ea, Offset: 0x1588
    // Size: 0x1a0
    function function_34d8f8a5() {
        str_hint = "";
        if (isdefined(m_s_bundle.door_trigger_at_target) && m_s_bundle.door_trigger_at_target) {
            str_hint = "This door is controlled elsewhere";
        } else if (m_s_bundle.door_unlock_method === "hack") {
            str_hint = "This door is electronically locked";
        }
        while (true) {
            var_133df857 sethintstring(str_hint);
            if (isdefined(m_s_bundle.door_trigger_at_target) && m_s_bundle.door_trigger_at_target) {
                self flag::wait_till("open");
            } else {
                self flag::wait_till_clear("locked");
            }
            var_133df857 sethintstring("");
            if (isdefined(m_s_bundle.door_trigger_at_target) && m_s_bundle.door_trigger_at_target) {
                self flag::wait_till_clear("open");
                continue;
            }
            self flag::wait_till("locked");
        }
    }

    // Namespace cdoor/doors_shared
    // Params 0, eflags: 0x0
    // Checksum 0x2d5a5b0c, Offset: 0x1330
    // Size: 0x250
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
                e_fx setmodel("tag_origin");
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
                e_fx setmodel("tag_origin");
                e_fx.angles = v_angles;
                playfxontag(m_s_bundle.door_unlocked_fx, e_fx, "tag_origin");
            }
        }
    }

    // Namespace cdoor/doors_shared
    // Params 0, eflags: 0x0
    // Checksum 0x580aa507, Offset: 0x11e8
    // Size: 0x13a
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
        if (m_s_bundle.door_unlock_method === "key") {
            return;
        }
        if (self flag::get("locked")) {
        }
    }

    // Namespace cdoor/doors_shared
    // Params 0, eflags: 0x0
    // Checksum 0x4990da54, Offset: 0xdd0
    // Size: 0x40c
    function open_internal() {
        self flag::set("animating");
        m_e_door notify(#"door_opening");
        if (isdefined(m_s_bundle.door_start_sound) && m_s_bundle.door_start_sound != "") {
            m_e_door playsound(m_s_bundle.door_start_sound);
        }
        if (isdefined(m_s_bundle.b_loop_sound) && m_s_bundle.b_loop_sound) {
            sndent = spawn("script_origin", m_e_door.origin);
            sndent linkto(m_e_door);
            sndent playloopsound(m_s_bundle.door_loop_sound, 1);
        }
        if (m_s_bundle.door_open_method == "slide") {
            m_e_door moveto(m_v_open_pos, m_s_bundle.door_open_time);
            m_e_door waittill("movedone");
        } else if (m_s_bundle.door_open_method == "swing") {
            angle = function_ad665f20();
            v_angle = (m_e_door.angles[0], m_e_door.angles[1] + angle, m_e_door.angles[2]);
            m_e_door rotateto(v_angle, m_s_bundle.door_open_time);
            m_e_door waittill("rotatedone");
        } else if (m_s_bundle.door_open_method == "animated") {
            m_e_door scene::play(m_s_bundle.door_animated_open_bundle, m_e_door);
        }
        if (isdefined(m_n_door_connect_paths) && m_n_door_connect_paths) {
            m_e_door connectpaths();
        }
        m_e_door notify(#"door_opened");
        if (isdefined(m_s_bundle.b_loop_sound) && m_s_bundle.b_loop_sound) {
            sndent delete();
        }
        if (isdefined(m_s_bundle.door_stop_sound) && m_s_bundle.door_stop_sound != "") {
            m_e_door playsound(m_s_bundle.door_stop_sound);
        }
        flag::clear("animating");
        set_script_flags(1);
        update_use_message();
    }

    // Namespace cdoor/doors_shared
    // Params 0, eflags: 0x0
    // Checksum 0x3d9d1532, Offset: 0xda0
    // Size: 0x24
    function close() {
        self flag::clear("open");
    }

    // Namespace cdoor/doors_shared
    // Params 0, eflags: 0x0
    // Checksum 0xdf3efe22, Offset: 0x968
    // Size: 0x42c
    function close_internal() {
        self flag::clear("open");
        set_script_flags(0);
        self flag::set("animating");
        m_e_door notify(#"door_closing");
        if (isdefined(m_s_bundle.b_loop_sound) && m_s_bundle.b_loop_sound) {
            m_e_door playsound(m_s_bundle.door_start_sound);
            sndent = spawn("script_origin", m_e_door.origin);
            sndent linkto(m_e_door);
            sndent playloopsound(m_s_bundle.door_loop_sound, 1);
        } else if (isdefined(m_s_bundle.door_stop_sound) && m_s_bundle.door_stop_sound != "") {
            m_e_door playsound(m_s_bundle.door_stop_sound);
        }
        if (m_s_bundle.door_open_method == "slide") {
            m_e_door moveto(m_v_close_pos, m_s_bundle.door_open_time);
            m_e_door waittill("movedone");
        } else if (m_s_bundle.door_open_method == "swing") {
            angle = function_ad665f20();
            v_angle = (m_e_door.angles[0], m_e_door.angles[1] - angle, m_e_door.angles[2]);
            m_e_door rotateto(v_angle, m_s_bundle.door_open_time);
            m_e_door waittill("rotatedone");
        } else if (m_s_bundle.door_open_method == "animated") {
            m_e_door scene::play(m_s_bundle.door_animated_close_bundle, m_e_door);
        }
        m_e_door notify(#"door_closed");
        if (isdefined(m_n_door_connect_paths) && m_n_door_connect_paths) {
            m_e_door disconnectpaths();
        }
        if (isdefined(m_s_bundle.b_loop_sound) && m_s_bundle.b_loop_sound) {
            sndent delete();
            m_e_door playsound(m_s_bundle.door_stop_sound);
        }
        flag::clear("animating");
        update_use_message();
    }

    // Namespace cdoor/doors_shared
    // Params 0, eflags: 0x0
    // Checksum 0xc1238647, Offset: 0x930
    // Size: 0x2c
    function remove_door_trigger() {
        if (isdefined(m_e_trigger)) {
            m_e_trigger delete();
        }
    }

    // Namespace cdoor/doors_shared
    // Params 0, eflags: 0x0
    // Checksum 0xfe44622a, Offset: 0x900
    // Size: 0x22
    function is_open() {
        return self flag::get("open");
    }

    // Namespace cdoor/doors_shared
    // Params 1, eflags: 0x0
    // Checksum 0x11bc274e, Offset: 0x8d8
    // Size: 0x1c
    function set_player_who_opened(e_player) {
        m_e_trigger_player = e_player;
    }

    // Namespace cdoor/doors_shared
    // Params 0, eflags: 0x0
    // Checksum 0x9f453161, Offset: 0x8a8
    // Size: 0x24
    function open() {
        self flag::set("open");
    }

    // Namespace cdoor/doors_shared
    // Params 0, eflags: 0x0
    // Checksum 0xbd7fdd13, Offset: 0x840
    // Size: 0x60
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
    // Checksum 0x9dfde2cb, Offset: 0x810
    // Size: 0x24
    function unlock() {
        self flag::clear("locked");
    }

    // Namespace cdoor/doors_shared
    // Params 0, eflags: 0x0
    // Checksum 0xa1926dbc, Offset: 0x7d0
    // Size: 0x34
    function lock() {
        self flag::set("locked");
        update_use_message();
    }

    // Namespace cdoor/doors_shared
    // Params 0, eflags: 0x0
    // Checksum 0xe914c9c8, Offset: 0x6a0
    // Size: 0x122
    function init_hint_trigger() {
        if (m_s_bundle.door_unlock_method === "default" && !(isdefined(m_s_bundle.door_trigger_at_target) && m_s_bundle.door_trigger_at_target)) {
            return;
        }
        if (m_s_bundle.door_unlock_method === "key") {
            return;
        }
        v_offset = m_s_bundle.v_trigger_offset;
        n_radius = m_s_bundle.door_trigger_radius;
        v_pos = calculate_offset_position(m_e_door.origin, m_e_door.angles, v_offset);
        v_pos = (v_pos[0], v_pos[1], v_pos[2] + 50);
    }

    // Namespace cdoor/doors_shared
    // Params 0, eflags: 0x0
    // Checksum 0x34f99a09, Offset: 0x618
    // Size: 0x7c
    function get_hack_angles() {
        v_angles = m_e_door.angles;
        if (isdefined(var_1484043e)) {
            e_target = getent(var_1484043e, "targetname");
            if (isdefined(e_target)) {
                return e_target.angles;
            }
        }
        return v_angles;
    }

    // Namespace cdoor/doors_shared
    // Params 0, eflags: 0x0
    // Checksum 0x9b535892, Offset: 0x520
    // Size: 0xec
    function get_hack_pos() {
        v_trigger_offset = m_s_bundle.v_trigger_offset;
        v_pos = calculate_offset_position(m_e_door.origin, m_e_door.angles, v_trigger_offset);
        v_pos = (v_pos[0], v_pos[1], v_pos[2] + 50);
        if (isdefined(var_1484043e)) {
            e_target = getent(var_1484043e, "targetname");
            if (isdefined(e_target)) {
                return e_target.origin;
            }
        }
        return v_pos;
    }

    // Namespace cdoor/doors_shared
    // Params 4, eflags: 0x0
    // Checksum 0x12b66075, Offset: 0x468
    // Size: 0xac
    function init_door_model(e_or_str_model, connect_paths, v_origin, v_angles) {
        if (isentity(e_or_str_model)) {
            m_e_door = e_or_str_model;
            return;
        } else if (!isdefined(e_or_str_model)) {
            e_or_str_model = "tag_origin";
        }
        m_e_door = util::spawn_model(e_or_str_model, v_origin, v_angles);
        if (connect_paths) {
            m_e_door disconnectpaths();
        }
    }

    // Namespace cdoor/doors_shared
    // Params 0, eflags: 0x0
    // Checksum 0x95ed808b, Offset: 0x430
    // Size: 0x2c
    function __destructor() {
        if (isdefined(m_e_trigger)) {
            m_e_trigger delete();
        }
    }

    // Namespace cdoor/doors_shared
    // Params 0, eflags: 0x0
    // Checksum 0xcd9fa1e3, Offset: 0x3f0
    // Size: 0x38
    function __constructor() {
        m_n_trigger_height = 80;
        var_b4d34742 = undefined;
        m_door_open_delay_time = 0;
        m_e_trigger_player = undefined;
    }

}

// Namespace doors/doors_shared
// Params 0, eflags: 0x2
// Checksum 0xe04c0150, Offset: 0x2480
// Size: 0x3c
function autoexec __init__sytem__() {
    system::register("doors", &__init__, &__main__, undefined);
}

// Namespace doors/doors_shared
// Params 0, eflags: 0x0
// Checksum 0x7ebed86e, Offset: 0x24c8
// Size: 0x112
function __init__() {
    a_doors = struct::get_array("scriptbundle_doors", "classname");
    a_doors = arraycombine(a_doors, getentarray("smart_object_door", "script_noteworthy"), 0, 0);
    foreach (s_instance in a_doors) {
        c_door = s_instance init();
        if (isdefined(c_door)) {
            s_instance.c_door = c_door;
        }
    }
}

// Namespace doors/doors_shared
// Params 0, eflags: 0x0
// Checksum 0x46b5abbc, Offset: 0x25e8
// Size: 0x1c
function __main__() {
    level thread init_door_panels();
}

// Namespace doors/doors_shared
// Params 0, eflags: 0x0
// Checksum 0x83bef2f7, Offset: 0x2610
// Size: 0x152
function init_door_panels() {
    a_door_panels = struct::get_array("smart_object_door_panel", "script_noteworthy");
    a_door_panels = arraycombine(a_door_panels, getentarray("smart_object_door_panel", "script_noteworthy"), 0, 0);
    foreach (door_panel in a_door_panels) {
        if (isdefined(door_panel.script_gameobject)) {
            if (!isdefined(door_panel.mdl_gameobject)) {
                door_panel gameobjects::init_game_objects(door_panel.script_gameobject);
            }
            door_panel setup_doors_with_panel();
            door_panel thread door_panel_interact();
        }
    }
}

// Namespace doors/doors_shared
// Params 0, eflags: 0x0
// Checksum 0x539eee1d, Offset: 0x2770
// Size: 0x12e
function setup_doors_with_panel() {
    if (isdefined(self.target)) {
        a_e_doors = getentarray(self.target, "targetname");
        a_e_doors = arraycombine(a_e_doors, struct::get_array(self.target, "targetname"), 0, 0);
        foreach (e_door in a_e_doors) {
            if (isdefined(e_door) && isdefined(e_door.c_door)) {
                door = e_door.c_door;
                [[ door ]]->remove_door_trigger();
            }
        }
    }
}

// Namespace doors/doors_shared
// Params 0, eflags: 0x0
// Checksum 0xe30ccf2, Offset: 0x28a8
// Size: 0x33a
function door_panel_interact() {
    self endon(#"death");
    b_is_panel_reusable = self.mdl_gameobject.b_reusable;
    while (true) {
        self.mdl_gameobject gameobjects::enable_object(1);
        waitresult = self.mdl_gameobject waittill("gameobject_end_use_player");
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
                continue;
            }
            return;
        }
    }
}

// Namespace doors/doors_shared
// Params 0, eflags: 0x0
// Checksum 0x8b9ef1d2, Offset: 0x2bf0
// Size: 0x7a
function init() {
    if (!isdefined(self.angles)) {
        self.angles = (0, 0, 0);
    }
    if (isdefined(self.scriptbundlename)) {
        s_door_bundle = struct::get_script_bundle("doors", self.scriptbundlename);
    }
    return setup_door_info(s_door_bundle, self);
}

// Namespace doors/doors_shared
// Params 2, eflags: 0x0
// Checksum 0x7e527a32, Offset: 0x2c78
// Size: 0xc30
function setup_door_info(s_door_bundle, s_door_instance) {
    [[ new cdoor ]]->__constructor();
    c_door = <error pop>;
    c_door flag::init("locked", 0);
    c_door flag::init("open", 0);
    c_door flag::init("animating", 0);
    if (!isdefined(s_door_bundle)) {
        s_door_bundle = spawnstruct();
        s_door_bundle.door_open_method = s_door_instance.door_open_method;
        s_door_bundle.door_slide_horizontal = s_door_instance.door_slide_horizontal;
        s_door_bundle.door_slide_horizontal_y = s_door_instance.door_slide_horizontal_y;
        s_door_bundle.door_open_time = s_door_instance.door_open_time;
        s_door_bundle.door_slide_open_units = s_door_instance.door_slide_open_units;
        s_door_bundle.door_swing_angle = s_door_instance.door_swing_angle;
        s_door_bundle.door_closes = s_door_instance.door_closes;
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
        s_door_bundle.model = s_door_instance;
        s_door_instance.door_open_method = undefined;
        s_door_instance.door_slide_horizontal = undefined;
        s_door_instance.door_slide_horizontal_y = undefined;
        s_door_instance.door_open_time = undefined;
        s_door_instance.door_slide_open_units = undefined;
        s_door_instance.door_swing_angle = undefined;
        s_door_instance.door_closes = undefined;
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
    }
    c_door.m_s_bundle = s_door_bundle;
    c_door.var_7e16e483 = s_door_instance.targetname;
    c_door.var_1484043e = s_door_instance.target;
    c_door.var_d6ef8c9d = s_door_instance.script_flag;
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
    if (c_door.m_s_bundle.door_unlock_method === "key") {
        if (isdefined(c_door.m_s_bundle.var_96a4595f)) {
            level.var_96a4595f = c_door.m_s_bundle.var_96a4595f;
        }
        if (isdefined(c_door.m_s_bundle.var_10ac440b)) {
            level.var_10ac440b = c_door.m_s_bundle.var_10ac440b;
        }
        if (isdefined(c_door.m_s_bundle.var_3d706ff2)) {
            level.var_3d706ff2 = c_door.m_s_bundle.var_3d706ff2;
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
    if (isdefined(c_door.m_s_bundle.door_start_open) && c_door.m_s_bundle.door_start_open) {
        c_door flag::set("open");
    }
    if (isdefined(c_door.var_d6ef8c9d)) {
        a_flags = strtok(c_door.var_d6ef8c9d, ",");
        foreach (str_flag in a_flags) {
            level flag::init(str_flag);
        }
    }
    [[ c_door ]]->init_door_model(e_or_str_door_model, n_door_connect_paths, s_door_instance.origin, s_door_instance.angles);
    [[ c_door ]]->init_trigger(v_trigger_offset, n_trigger_radius, c_door.m_s_bundle);
    [[ c_door ]]->init_player_spawns();
    [[ c_door ]]->init_hint_trigger();
    thread [[ c_door ]]->run_lock_fx();
    [[ c_door ]]->init_movement(str_slide_dir, n_slide_amount);
    if (!isdefined(c_door.m_s_bundle.door_open_time)) {
        c_door.m_s_bundle.door_open_time = 0.4;
    }
    [[ c_door ]]->set_door_paths(n_door_connect_paths);
    c_door.m_s_bundle.b_loop_sound = isdefined(c_door.m_s_bundle.door_loop_sound) && c_door.m_s_bundle.door_loop_sound != "";
    level thread door_update(c_door);
    return c_door;
}

// Namespace doors/doors_shared
// Params 1, eflags: 0x0
// Checksum 0x6a00c5ff, Offset: 0x38b0
// Size: 0x440
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
    b_manual_close = isdefined(c_door.m_s_bundle.door_closes) && isdefined(c_door.m_s_bundle.door_use_trigger) && c_door.m_s_bundle.door_use_trigger && c_door.m_s_bundle.door_closes;
    while (true) {
        waitresult = c_door.m_e_trigger waittill("trigger");
        e_who = waitresult.activator;
        c_door.m_e_trigger_player = e_who;
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
                } else if (str_unlock_method == "key") {
                    if (e_who function_8aa55a3b("door")) {
                        e_who function_1835b0fc("door");
                        [[ c_door ]]->open();
                    } else {
                        iprintlnbold("You need a key.");
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
// Checksum 0xcc0a3105, Offset: 0x3cf8
// Size: 0x28a
function door_update(c_door) {
    str_unlock_method = "default";
    if (isdefined(c_door.m_s_bundle.door_unlock_method)) {
        str_unlock_method = c_door.m_s_bundle.door_unlock_method;
    }
    if (isdefined(c_door.m_s_bundle.door_locked) && c_door.m_s_bundle.door_locked && str_unlock_method != "key") {
        c_door flag::set("locked");
        if (isdefined(c_door.var_7e16e483)) {
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
// Checksum 0x52365606, Offset: 0x3f90
// Size: 0x98
function door_update_lock_scripted(c_door) {
    door_str = c_door.var_7e16e483;
    c_door.m_e_trigger.targetname = door_str + "_trig";
    c_door.m_e_trigger endon(#"death");
    while (true) {
        c_door.m_e_trigger waittill("unlocked");
        [[ c_door ]]->unlock();
    }
}

// Namespace doors/doors_shared
// Params 1, eflags: 0x0
// Checksum 0x6bde07ba, Offset: 0x4030
// Size: 0x124
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
        self.freeze_origin setmodel("tag_origin");
        self.freeze_origin.angles = self.angles;
        self playerlinktodelta(self.freeze_origin, "tag_origin", 1, 45, 45, 45, 45);
    }
}

// Namespace doors/doors_shared
// Params 1, eflags: 0x0
// Checksum 0x7fa38339, Offset: 0x4160
// Size: 0xec
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
        dt = (time - last_trigger_time) / 1000;
        if (dt >= 0.3) {
            break;
        }
        waitframe(1);
    }
    self notify(str_kill_trigger_notify);
}

// Namespace doors/doors_shared
// Params 3, eflags: 0x0
// Checksum 0x2d38aa27, Offset: 0x4258
// Size: 0xfe
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
// Checksum 0x5e1a39ae, Offset: 0x4360
// Size: 0xbc
function door_wait_until_clear(c_door, e_triggerer) {
    e_trigger = c_door.m_e_trigger;
    if (isdefined(c_door.m_s_bundle.door_use_hold) && isplayer(e_triggerer) && c_door.m_s_bundle.door_use_hold) {
        c_door.m_e_trigger door_wait_until_user_release(c_door, e_triggerer);
    }
    e_trigger trigger_wait_until_clear(c_door);
}

// Namespace doors/doors_shared
// Params 1, eflags: 0x0
// Checksum 0x55717f38, Offset: 0x4428
// Size: 0x4c
function trigger_check_for_ents_touching(str_kill_trigger_notify) {
    self endon(#"death");
    self endon(str_kill_trigger_notify);
    while (true) {
        self waittill("trigger");
        self.ents_in_trigger = 1;
    }
}

// Namespace doors/doors_shared
// Params 1, eflags: 0x0
// Checksum 0x17883362, Offset: 0x4480
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
// Params 1, eflags: 0x0
// Checksum 0xb1ed8a9e, Offset: 0x4520
// Size: 0x56
function function_8aa55a3b(var_b48f50dd) {
    if (!isdefined(self.var_1166c5fc)) {
        return false;
    }
    if (!isdefined(self.var_1166c5fc[var_b48f50dd])) {
        return false;
    }
    return self.var_1166c5fc[var_b48f50dd].num_keys > 0;
}

// Namespace doors/doors_shared
// Params 1, eflags: 0x0
// Checksum 0x3c855b76, Offset: 0x4580
// Size: 0xc6
function function_1835b0fc(var_b48f50dd) {
    if (!function_8aa55a3b(var_b48f50dd)) {
        return;
    }
    self.var_1166c5fc[var_b48f50dd].num_keys--;
    if (self.var_1166c5fc[var_b48f50dd].num_keys <= 0 && isdefined(self.var_1166c5fc[var_b48f50dd].hudelem)) {
        self.var_1166c5fc[var_b48f50dd].hudelem destroy();
        self.var_1166c5fc[var_b48f50dd].hudelem = undefined;
    }
}

// Namespace doors/doors_shared
// Params 0, eflags: 0x0
// Checksum 0x249f1dd5, Offset: 0x4650
// Size: 0x48
function function_522fd170() {
    self endon(#"death");
    while (true) {
        self rotateyaw(180, 3);
        wait 2.5;
    }
}

// Namespace doors/doors_shared
// Params 3, eflags: 0x0
// Checksum 0x2bf5978a, Offset: 0x46a0
// Size: 0x174
function function_a7e476f0(var_3501c4df, e_trigger, e_model) {
    e_trigger endon(#"death");
    if (var_3501c4df < 5) {
        var_3501c4df = 5 + 1;
    }
    wait var_3501c4df - 5;
    var_2bc4d9d5 = 0.5;
    b_on = 1;
    for (f = 0; f < 5; f += var_2bc4d9d5) {
        if (b_on) {
            e_model hide();
        } else {
            e_model show();
        }
        b_on = !b_on;
        wait var_2bc4d9d5;
        if (var_2bc4d9d5 > 0.15) {
            var_2bc4d9d5 *= 0.9;
        }
    }
    level notify(#"hash_20175e");
    e_model delete();
    e_trigger delete();
}

// Namespace doors/doors_shared
// Params 2, eflags: 0x0
// Checksum 0x980c21da, Offset: 0x4820
// Size: 0x2cc
function function_380dd131(var_3501c4df, var_b48f50dd) {
    v_pos = self.origin;
    e_model = spawn("script_model", v_pos + (0, 0, 80));
    e_model.angles = (10, 0, 10);
    e_model setmodel(level.var_96a4595f);
    if (isdefined(level.var_3d706ff2)) {
        playfxontag(level.var_3d706ff2, e_model, "tag_origin");
    }
    while (isalive(self)) {
        e_model moveto(self.origin + (0, 0, 80), 0.2);
        e_model rotateyaw(30, 0.2);
        wait 0.1;
    }
    e_model movez(-60, 1);
    wait 1;
    e_model thread function_522fd170();
    e_trigger = spawn("trigger_radius", e_model.origin, 0, 25, 100);
    if (isdefined(var_3501c4df)) {
        level thread function_a7e476f0(var_3501c4df, e_trigger, e_model);
    }
    e_trigger endon(#"death");
    while (true) {
        waitresult = e_trigger waittill("trigger");
        e_who = waitresult.activator;
        if (isplayer(e_who)) {
            e_who function_fc201a7a(var_b48f50dd);
            break;
        }
    }
    e_model delete();
    e_trigger delete();
}

// Namespace doors/doors_shared
// Params 2, eflags: 0x0
// Checksum 0xc9ec1fb3, Offset: 0x4af8
// Size: 0x8c
function function_4c16e397(var_3501c4df, var_b48f50dd) {
    if (!isdefined(var_3501c4df)) {
        var_3501c4df = undefined;
    }
    if (!isdefined(var_b48f50dd)) {
        var_b48f50dd = "door";
    }
    /#
        assert(isdefined(level.var_96a4595f), "<dev string:x28>");
    #/
    self thread function_380dd131(var_3501c4df, var_b48f50dd);
}

// Namespace doors/doors_shared
// Params 1, eflags: 0x0
// Checksum 0xbfd34656, Offset: 0x4b90
// Size: 0x238
function function_fc201a7a(var_b48f50dd) {
    if (!isdefined(var_b48f50dd)) {
        var_b48f50dd = "door";
    }
    /#
        assert(isdefined(level.var_10ac440b), "<dev string:x81>");
    #/
    if (!isdefined(self.var_1166c5fc)) {
        self.var_1166c5fc = [];
    }
    if (!isdefined(self.var_1166c5fc[var_b48f50dd])) {
        self.var_1166c5fc[var_b48f50dd] = spawnstruct();
        self.var_1166c5fc[var_b48f50dd].num_keys = 0;
        self.var_1166c5fc[var_b48f50dd].type = var_b48f50dd;
    }
    hudelem = self.var_1166c5fc[var_b48f50dd].hudelem;
    if (!isdefined(hudelem)) {
        hudelem = newclienthudelem(self);
    }
    hudelem.alignx = "right";
    hudelem.aligny = "bottom";
    hudelem.horzalign = "right";
    hudelem.vertalign = "bottom";
    hudelem.hidewheninmenu = 1;
    hudelem.hidewhenindemo = 1;
    hudelem.y = -75;
    hudelem.x = -25;
    hudelem setshader(level.var_10ac440b, 16, 16);
    self.var_1166c5fc[var_b48f50dd].hudelem = hudelem;
    self.var_1166c5fc[var_b48f50dd].num_keys++;
}

// Namespace doors/doors_shared
// Params 3, eflags: 0x0
// Checksum 0xf5c8efbf, Offset: 0x4dd0
// Size: 0x12a
function unlock(str_value, str_key, b_do_open) {
    if (!isdefined(str_key)) {
        str_key = "targetname";
    }
    if (!isdefined(b_do_open)) {
        b_do_open = 1;
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
// Checksum 0xe2ba7183, Offset: 0x4f08
// Size: 0x3c
function unlock_all(b_do_open) {
    if (!isdefined(b_do_open)) {
        b_do_open = 1;
    }
    unlock(undefined, undefined, b_do_open);
}

// Namespace doors/doors_shared
// Params 3, eflags: 0x0
// Checksum 0x9b80fef3, Offset: 0x4f50
// Size: 0x12a
function lock(str_value, str_key, b_do_close) {
    if (!isdefined(str_key)) {
        str_key = "targetname";
    }
    if (!isdefined(b_do_close)) {
        b_do_close = 1;
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
// Checksum 0x4871dcd5, Offset: 0x5088
// Size: 0x3c
function lock_all(b_do_close) {
    if (!isdefined(b_do_close)) {
        b_do_close = 1;
    }
    lock(undefined, undefined, b_do_close);
}

// Namespace doors/doors_shared
// Params 2, eflags: 0x0
// Checksum 0xcc2082fb, Offset: 0x50d0
// Size: 0xea
function open(str_value, str_key) {
    if (!isdefined(str_key)) {
        str_key = "targetname";
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
// Checksum 0xf40e7d0, Offset: 0x51c8
// Size: 0x14
function open_all() {
    open();
}

// Namespace doors/doors_shared
// Params 2, eflags: 0x0
// Checksum 0x23a239d7, Offset: 0x51e8
// Size: 0xea
function close(str_value, str_key) {
    if (!isdefined(str_key)) {
        str_key = "targetname";
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
// Checksum 0xd9f2c7c7, Offset: 0x52e0
// Size: 0x14
function close_all() {
    close();
}

// Namespace doors/doors_shared
// Params 0, eflags: 0x0
// Checksum 0xdb8e0dde, Offset: 0x5300
// Size: 0x22
function is_open() {
    return self.c_door flag::get("open");
}

// Namespace doors/doors_shared
// Params 0, eflags: 0x0
// Checksum 0xba3ca827, Offset: 0x5330
// Size: 0x24
function waittill_door_opened() {
    self.c_door flag::wait_till("open");
}

// Namespace doors/doors_shared
// Params 0, eflags: 0x0
// Checksum 0xf261b141, Offset: 0x5360
// Size: 0x44
function waittill_door_closed() {
    self.c_door flag::wait_till_clear("open");
    self.c_door flag::wait_till_clear("animating");
}

// Namespace doors/doors_shared
// Params 2, eflags: 0x0
// Checksum 0x24c50ac4, Offset: 0x53b0
// Size: 0xfc
function get_doors(str_value, str_key) {
    if (!isdefined(str_key)) {
        str_key = "targetname";
    }
    if (isdefined(str_value)) {
        a_e_doors = struct::get_array(str_value, str_key);
        a_e_doors = arraycombine(a_e_doors, getentarray(str_value, str_key), 0, 0);
    } else {
        a_e_doors = struct::get_array("scriptbundle_doors", "classname");
        a_e_doors = arraycombine(a_e_doors, getentarray("smart_object_door", "script_noteworthy"), 0, 0);
    }
    return a_e_doors;
}

