#using scripts\core_common\doors_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\values_shared;

#namespace barricades;

// Namespace barricades
// Method(s) 6 Total 52
class cbarricade : cdoor {

    var m_e_door;
    var m_s_bundle;
    var m_str_type;
    var var_a2f96f78;

    // Namespace cbarricade/barricades_shared
    // Params 0, eflags: 0x8
    // Checksum 0x1db25e7e, Offset: 0x328
    // Size: 0x22
    constructor() {
        m_str_type = "barricade";
    }

    // Namespace cbarricade/barricades_shared
    // Params 0, eflags: 0x0
    // Checksum 0x8dfc0549, Offset: 0x988
    // Size: 0x138
    function function_6c15ac46() {
        m_e_door endon(#"delete", #"barricade_removed");
        while (true) {
            m_e_door endon(#"delete");
            m_e_door waittill(#"hash_923096b653062ea");
            if (isdefined(var_a2f96f78.target)) {
                var_59746f25 = struct::get_array(var_a2f96f78.target, "targetname");
                foreach (s_door in var_59746f25) {
                    s_door.c_door.var_7d28591d = 0;
                }
            }
            waitframe(1);
        }
    }

    // Namespace cbarricade/barricades_shared
    // Params 2, eflags: 0x0
    // Checksum 0x353e0b79, Offset: 0x378
    // Size: 0x224
    function init(var_4a686ff8, s_instance) {
        m_s_bundle = var_4a686ff8;
        var_a2f96f78 = s_instance;
        m_s_bundle.door_start_open = s_instance.door_start_open;
        s_instance.c_door = doors::setup_door_info(m_s_bundle, s_instance, self);
        if (is_true(m_s_bundle.door_start_open)) {
            if (isdefined(var_a2f96f78.target)) {
                var_59746f25 = struct::get_array(var_a2f96f78.target, "targetname");
                foreach (s_door in var_59746f25) {
                    s_door.c_door.var_7d28591d = 1;
                    if ([[ s_door.c_door ]]->is_open()) {
                        [[ s_door.c_door ]]->close();
                    }
                }
            }
        }
        if (is_true(m_s_bundle.var_ccc6dafc)) {
            m_e_door setcandamage(1);
            m_e_door val::set(#"hash_25bedd86747e41e1", "allowdeath", 0);
            thread function_b4a1f06a();
        }
        thread function_da5abae9();
        thread function_6c15ac46();
    }

    // Namespace cbarricade/barricades_shared
    // Params 0, eflags: 0x0
    // Checksum 0x3c0121ec, Offset: 0x5a8
    // Size: 0x280
    function function_b4a1f06a() {
        m_e_door endon(#"delete");
        if (!isdefined(m_s_bundle.var_89af4052)) {
            m_s_bundle.var_89af4052 = 0;
        }
        var_1913ccf5 = m_s_bundle.var_89af4052;
        while (true) {
            m_e_door waittill(#"damage");
            if (cdoor::is_open()) {
                var_1913ccf5--;
                if (var_1913ccf5 < 0) {
                    var_59746f25 = struct::get_array(var_a2f96f78.target, "targetname");
                    foreach (s_door in var_59746f25) {
                        s_door.c_door.var_7d28591d = 0;
                    }
                    if (is_true(m_s_bundle.var_170e4611)) {
                        if (isdefined(m_s_bundle.var_8124c17f)) {
                            m_e_door scene::play(m_s_bundle.var_8124c17f, m_e_door);
                        }
                        m_e_door notify(#"gameobject_deleted");
                        m_e_door notify(#"barricade_removed");
                        waitframe(1);
                        m_e_door.mdl_gameobject delete();
                        m_e_door delete();
                        break;
                    } else {
                        if (cdoor::is_open()) {
                            cdoor::close();
                        }
                        var_1913ccf5 = m_s_bundle.var_89af4052;
                    }
                }
            }
            waitframe(1);
        }
    }

    // Namespace cbarricade/barricades_shared
    // Params 0, eflags: 0x0
    // Checksum 0xa233e0e4, Offset: 0x830
    // Size: 0x14e
    function function_da5abae9() {
        m_e_door endon(#"delete", #"barricade_removed");
        while (true) {
            m_e_door waittill(#"hash_7166c13e79b73f9");
            if (isdefined(var_a2f96f78.target)) {
                var_59746f25 = struct::get_array(var_a2f96f78.target, "targetname");
                foreach (s_door in var_59746f25) {
                    s_door.c_door.var_7d28591d = 1;
                    if ([[ s_door.c_door ]]->is_open()) {
                        [[ s_door.c_door ]]->close();
                    }
                }
            }
            waitframe(1);
        }
    }

}

// Namespace barricades/barricades_shared
// Params 0, eflags: 0x6
// Checksum 0x9784226f, Offset: 0x130
// Size: 0x4c
function private autoexec __init__system__() {
    system::register(#"barricades", &function_70a657d8, &postinit, undefined, undefined);
}

// Namespace barricades/barricades_shared
// Params 0, eflags: 0x4
// Checksum 0x4e3c475b, Offset: 0x188
// Size: 0xee
function private function_70a657d8() {
    if (!isdefined(level.a_s_barricades)) {
        level.a_s_barricades = [];
    }
    level.a_s_barricades = struct::get_array("scriptbundle_barricades", "classname");
    foreach (s_instance in level.a_s_barricades) {
        c_door = s_instance function_14354831();
        if (isdefined(c_door)) {
            s_instance.c_door = c_door;
        }
    }
}

// Namespace barricades/barricades_shared
// Params 0, eflags: 0x0
// Checksum 0x9253d702, Offset: 0x280
// Size: 0x6e
function function_14354831() {
    if (isdefined(self.scriptbundlename)) {
        var_9fecaae1 = getscriptbundle(self.scriptbundlename);
    }
    var_2a44a7ed = new cbarricade();
    var_2a44a7ed = [[ var_2a44a7ed ]]->init(var_9fecaae1, self);
    return var_2a44a7ed;
}

// Namespace barricades/barricades_shared
// Params 0, eflags: 0x4
// Checksum 0x9e46e9d, Offset: 0x2f8
// Size: 0x24
function private postinit() {
    level flag::wait_till("radiant_gameobjects_initialized");
}

