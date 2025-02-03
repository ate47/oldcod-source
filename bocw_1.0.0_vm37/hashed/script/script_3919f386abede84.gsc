#using scripts\core_common\array_shared;
#using scripts\core_common\doors_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\gameobjects_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\cp_common\util;

#namespace windows;

// Namespace windows
// Method(s) 3 Total 49
class class_e500a966 : cdoor {

    var m_s_bundle;
    var m_str_type;
    var var_a2f96f78;

    // Namespace class_e500a966/namespace_23507db6
    // Params 0, eflags: 0x8
    // Checksum 0x1fa715b3, Offset: 0x408
    // Size: 0x22
    constructor() {
        m_str_type = "window";
    }

    // Namespace namespace_e500a966/namespace_23507db6
    // Params 2, eflags: 0x0
    // Checksum 0xd757b10c, Offset: 0x458
    // Size: 0x52
    function init(var_82b05767, s_instance) {
        m_s_bundle = var_82b05767;
        var_a2f96f78 = s_instance;
        s_instance.c_door = doors::setup_door_info(m_s_bundle, s_instance, self);
    }

}

// Namespace windows/namespace_23507db6
// Params 0, eflags: 0x6
// Checksum 0x57b00650, Offset: 0x138
// Size: 0x4c
function private autoexec __init__system__() {
    system::register(#"windows", &preinit, &postinit, undefined, undefined);
}

// Namespace windows/namespace_23507db6
// Params 0, eflags: 0x4
// Checksum 0x61fae76f, Offset: 0x190
// Size: 0x20
function private preinit() {
    if (!isdefined(level.var_e97fadd5)) {
        level.var_e97fadd5 = [];
    }
}

// Namespace windows/namespace_23507db6
// Params 0, eflags: 0x0
// Checksum 0x76229fbd, Offset: 0x1b8
// Size: 0x6e
function init_window() {
    if (isdefined(self.scriptbundlename)) {
        var_82b05767 = getscriptbundle(self.scriptbundlename);
    }
    var_9bff4cd8 = new class_e500a966();
    var_9bff4cd8 = [[ var_9bff4cd8 ]]->init(var_82b05767, self);
    return var_9bff4cd8;
}

// Namespace windows/namespace_23507db6
// Params 0, eflags: 0x4
// Checksum 0x55649db9, Offset: 0x230
// Size: 0x1ce
function private postinit() {
    level flag::wait_till("radiant_gameobjects_initialized");
    level.var_e97fadd5 = struct::get_array("scriptbundle_windows", "classname");
    foreach (s_instance in level.var_e97fadd5) {
        c_door = s_instance init_window();
        if (isdefined(c_door)) {
            s_instance.c_door = c_door;
        }
    }
    foreach (s_instance in level.var_e97fadd5) {
        if (isdefined(s_instance.linkname)) {
            var_d5700a96 = struct::get_array(s_instance.linkname, "linkto");
            if (isdefined(var_d5700a96[0])) {
                s_instance.c_door.var_d1c4f848 = var_d5700a96[0];
                var_d5700a96[0].c_door.var_d1c4f848 = s_instance;
            }
        }
    }
}

// Namespace windows/namespace_23507db6
// Params 2, eflags: 0x0
// Checksum 0x40d4a6e9, Offset: 0xe70
// Size: 0x2c
function open(str_value, str_key) {
    self doors::open(str_value, str_key);
}

// Namespace windows/namespace_23507db6
// Params 2, eflags: 0x0
// Checksum 0x72495662, Offset: 0xea8
// Size: 0x2c
function close(str_value, str_key) {
    self doors::close(str_value, str_key);
}

// Namespace windows/namespace_23507db6
// Params 3, eflags: 0x0
// Checksum 0x4b05a7e, Offset: 0xee0
// Size: 0x5c
function lock(str_value, str_key = "targetname", b_do_close = 1) {
    self doors::lock(str_value, str_key, b_do_close);
}

// Namespace windows/namespace_23507db6
// Params 3, eflags: 0x0
// Checksum 0x3901ed36, Offset: 0xf48
// Size: 0x5c
function unlock(str_value, str_key = "targetname", b_do_open = 1) {
    self doors::unlock(str_value, str_key, b_do_open);
}

// Namespace windows/namespace_23507db6
// Params 2, eflags: 0x0
// Checksum 0xa87a00dd, Offset: 0xfb0
// Size: 0x116
function function_d216984f(str_value, str_key = "targetname") {
    var_e97fadd5 = [];
    if (isdefined(str_value)) {
        a_structs = struct::get_array(str_value, str_key);
        foreach (struct in a_structs) {
            if (isinarray(level.var_e97fadd5, struct)) {
                array::add(var_e97fadd5, struct, 0);
            }
        }
    } else {
        var_e97fadd5 = level.var_e97fadd5;
    }
    return var_e97fadd5;
}

