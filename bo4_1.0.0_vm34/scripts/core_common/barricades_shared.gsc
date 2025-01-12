#using scripts\core_common\doors_shared;
#using scripts\core_common\flagsys_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\values_shared;

#namespace barricades;

// Namespace barricades
// Method(s) 6 Total 45
class cbarricade : cdoor {

    var m_e_door;
    var m_s_bundle;
    var m_str_type;
    var var_ccdffe96;

    // Namespace cbarricade/barricades_shared
    // Params 0, eflags: 0x8
    // Checksum 0x83db209e, Offset: 0x328
    // Size: 0x22
    constructor() {
        m_str_type = "barricade";
    }

    // Namespace cbarricade/barricades_shared
    // Params 0, eflags: 0x0
    // Checksum 0x2a0f1c7f, Offset: 0x988
    // Size: 0x12c
    function function_54b2dc67() {
        m_e_door endon(#"delete", #"barricade_removed");
        while (true) {
            m_e_door endon(#"delete");
            m_e_door waittill(#"hash_923096b653062ea");
            if (isdefined(var_ccdffe96.target)) {
                var_e812b2a0 = struct::get_array(var_ccdffe96.target, "targetname");
                foreach (s_door in var_e812b2a0) {
                    s_door.c_door.var_6bf45197 = 0;
                }
            }
            waitframe(1);
        }
    }

    // Namespace cbarricade/barricades_shared
    // Params 0, eflags: 0x0
    // Checksum 0xd25e5117, Offset: 0x838
    // Size: 0x142
    function function_3a4b3631() {
        m_e_door endon(#"delete", #"barricade_removed");
        while (true) {
            m_e_door waittill(#"hash_7166c13e79b73f9");
            if (isdefined(var_ccdffe96.target)) {
                var_e812b2a0 = struct::get_array(var_ccdffe96.target, "targetname");
                foreach (s_door in var_e812b2a0) {
                    s_door.c_door.var_6bf45197 = 1;
                    if ([[ s_door.c_door ]]->is_open()) {
                        [[ s_door.c_door ]]->close();
                    }
                }
            }
            waitframe(1);
        }
    }

    // Namespace cbarricade/barricades_shared
    // Params 0, eflags: 0x0
    // Checksum 0xf105a3a1, Offset: 0x5b0
    // Size: 0x280
    function function_3f9279d2() {
        m_e_door endon(#"delete");
        if (!isdefined(m_s_bundle.var_2b3572af)) {
            m_s_bundle.var_2b3572af = 0;
        }
        var_83b2f1d4 = m_s_bundle.var_2b3572af;
        while (true) {
            m_e_door waittill(#"damage");
            if (cdoor::is_open()) {
                var_83b2f1d4--;
                if (var_83b2f1d4 < 0) {
                    var_e812b2a0 = struct::get_array(var_ccdffe96.target, "targetname");
                    foreach (s_door in var_e812b2a0) {
                        s_door.c_door.var_6bf45197 = 0;
                    }
                    if (isdefined(m_s_bundle.var_6fc1d1b7) && m_s_bundle.var_6fc1d1b7) {
                        if (isdefined(m_s_bundle.var_16a5f800)) {
                            m_e_door scene::play(m_s_bundle.var_16a5f800, m_e_door);
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
                        var_83b2f1d4 = m_s_bundle.var_2b3572af;
                    }
                }
            }
            waitframe(1);
        }
    }

    // Namespace cbarricade/barricades_shared
    // Params 2, eflags: 0x0
    // Checksum 0x1883ad75, Offset: 0x378
    // Size: 0x22c
    function init(var_2de1362b, s_instance) {
        m_s_bundle = var_2de1362b;
        var_ccdffe96 = s_instance;
        m_s_bundle.door_start_open = s_instance.door_start_open;
        s_instance.c_door = doors::setup_door_info(m_s_bundle, s_instance, self);
        if (isdefined(m_s_bundle.door_start_open) && m_s_bundle.door_start_open) {
            if (isdefined(var_ccdffe96.target)) {
                var_e812b2a0 = struct::get_array(var_ccdffe96.target, "targetname");
                foreach (s_door in var_e812b2a0) {
                    s_door.c_door.var_6bf45197 = 1;
                    if ([[ s_door.c_door ]]->is_open()) {
                        [[ s_door.c_door ]]->close();
                    }
                }
            }
        }
        if (isdefined(m_s_bundle.var_b2834f39) && m_s_bundle.var_b2834f39) {
            m_e_door setcandamage(1);
            m_e_door val::set(#"hash_25bedd86747e41e1", "allowdeath", 0);
            thread function_3f9279d2();
        }
        thread function_3a4b3631();
        thread function_54b2dc67();
    }

}

// Namespace barricades/barricades_shared
// Params 0, eflags: 0x2
// Checksum 0x9f3dc6e4, Offset: 0x128
// Size: 0x44
function autoexec __init__system__() {
    system::register(#"barricades", &__init__, &__main__, undefined);
}

// Namespace barricades/barricades_shared
// Params 0, eflags: 0x0
// Checksum 0x65ac63ce, Offset: 0x178
// Size: 0xea
function __init__() {
    if (!isdefined(level.a_s_barricades)) {
        level.a_s_barricades = [];
    }
    level.a_s_barricades = struct::get_array("scriptbundle_barricades", "classname");
    foreach (s_instance in level.a_s_barricades) {
        c_door = s_instance function_1e1c822f();
        if (isdefined(c_door)) {
            s_instance.c_door = c_door;
        }
    }
}

// Namespace barricades/barricades_shared
// Params 0, eflags: 0x0
// Checksum 0xf7088b64, Offset: 0x270
// Size: 0x7a
function function_1e1c822f() {
    if (isdefined(self.scriptbundlename)) {
        var_37dc750a = struct::get_script_bundle("barricades", self.scriptbundlename);
    }
    var_5914d8cc = new cbarricade();
    var_5914d8cc = [[ var_5914d8cc ]]->init(var_37dc750a, self);
    return var_5914d8cc;
}

// Namespace barricades/barricades_shared
// Params 0, eflags: 0x0
// Checksum 0x6968ca87, Offset: 0x2f8
// Size: 0x24
function __main__() {
    level flagsys::wait_till("radiant_gameobjects_initialized");
}

