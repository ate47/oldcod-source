#using scripts/core_common/util_shared;

#namespace scriptbundle;

// Namespace scriptbundle
// Method(s) 6 Total 6
class cscriptbundleobjectbase {

    var _e_array;
    var _n_clientnum;
    var _s;
    var var_190b1ea2;

    // Namespace cscriptbundleobjectbase/scriptbundle_shared
    // Params 1, eflags: 0x0
    // Checksum 0xf7ac0e4e, Offset: 0x3f0
    // Size: 0x1c
    function get_ent(localclientnum) {
        return _e_array[localclientnum];
    }

    // Namespace cscriptbundleobjectbase/scriptbundle_shared
    // Params 2, eflags: 0x0
    // Checksum 0x446a79a8, Offset: 0x2c0
    // Size: 0x128
    function error(condition, str_msg) {
        if (condition) {
            if ([[ var_190b1ea2 ]]->is_testing()) {
                scriptbundle::error_on_screen(str_msg);
            } else {
                assertmsg([[ var_190b1ea2 ]]->get_type() + "<dev string:x46>" + var_190b1ea2._str_name + "<dev string:x48>" + (isdefined("<dev string:x4d>") ? "<dev string:x4c>" + "<dev string:x4d>" : isdefined(_s.name) ? "<dev string:x4c>" + _s.name : "<dev string:x4c>") + "<dev string:x55>" + str_msg);
            }
            thread [[ var_190b1ea2 ]]->on_error();
            return true;
        }
        return false;
    }

    // Namespace cscriptbundleobjectbase/scriptbundle_shared
    // Params 1, eflags: 0x0
    // Checksum 0x4e61779c, Offset: 0x1f0
    // Size: 0xc4
    function log(str_msg) {
        println([[ var_190b1ea2 ]]->get_type() + "<dev string:x46>" + var_190b1ea2._str_name + "<dev string:x48>" + (isdefined("<dev string:x4d>") ? "<dev string:x4c>" + "<dev string:x4d>" : isdefined(_s.name) ? "<dev string:x4c>" + _s.name : "<dev string:x4c>") + "<dev string:x55>" + str_msg);
    }

    // Namespace cscriptbundleobjectbase/scriptbundle_shared
    // Params 4, eflags: 0x0
    // Checksum 0xa68d9dba, Offset: 0x100
    // Size: 0xe8
    function init(s_objdef, o_bundle, e_ent, localclientnum) {
        _s = s_objdef;
        var_190b1ea2 = o_bundle;
        if (isdefined(e_ent)) {
            assert(!isdefined(localclientnum) || e_ent.localclientnum == localclientnum, "<dev string:x28>");
            _n_clientnum = e_ent.localclientnum;
            _e_array[_n_clientnum] = e_ent;
            return;
        }
        _e_array = [];
        if (isdefined(localclientnum)) {
            _n_clientnum = localclientnum;
        }
    }

}

// Namespace scriptbundle
// Method(s) 12 Total 12
class cscriptbundlebase {

    var _a_objects;
    var _s;
    var _str_name;
    var _testing;

    // Namespace cscriptbundlebase/scriptbundle_shared
    // Params 0, eflags: 0x0
    // Checksum 0xb05f4042, Offset: 0x580
    // Size: 0x1c
    function constructor() {
        _a_objects = [];
        _testing = 0;
    }

    // Namespace cscriptbundlebase/scriptbundle_shared
    // Params 2, eflags: 0x0
    // Checksum 0xc767ac04, Offset: 0x7b8
    // Size: 0x94
    function error(condition, str_msg) {
        if (condition) {
            if (_testing) {
            } else {
                assertmsg(_s.type + "<dev string:x46>" + _str_name + "<dev string:x58>" + str_msg);
            }
            thread on_error();
            return true;
        }
        return false;
    }

    // Namespace cscriptbundlebase/scriptbundle_shared
    // Params 1, eflags: 0x0
    // Checksum 0x935a0056, Offset: 0x758
    // Size: 0x54
    function log(str_msg) {
        println(_s.type + "<dev string:x46>" + _str_name + "<dev string:x58>" + str_msg);
    }

    // Namespace cscriptbundlebase/scriptbundle_shared
    // Params 1, eflags: 0x0
    // Checksum 0xea939dc7, Offset: 0x720
    // Size: 0x2c
    function remove_object(o_object) {
        arrayremovevalue(_a_objects, o_object);
    }

    // Namespace cscriptbundlebase/scriptbundle_shared
    // Params 1, eflags: 0x0
    // Checksum 0x7fe0c832, Offset: 0x688
    // Size: 0x8a
    function add_object(o_object) {
        if (!isdefined(_a_objects)) {
            _a_objects = [];
        } else if (!isarray(_a_objects)) {
            _a_objects = array(_a_objects);
        }
        _a_objects[_a_objects.size] = o_object;
    }

    // Namespace cscriptbundlebase/scriptbundle_shared
    // Params 0, eflags: 0x0
    // Checksum 0xefb3a1c3, Offset: 0x670
    // Size: 0xe
    function is_testing() {
        return _testing;
    }

    // Namespace cscriptbundlebase/scriptbundle_shared
    // Params 0, eflags: 0x0
    // Checksum 0x965ca52c, Offset: 0x650
    // Size: 0x16
    function get_objects() {
        return _s.objects;
    }

    // Namespace cscriptbundlebase/scriptbundle_shared
    // Params 0, eflags: 0x0
    // Checksum 0x16e87639, Offset: 0x630
    // Size: 0x16
    function get_vm() {
        return _s.vmtype;
    }

    // Namespace cscriptbundlebase/scriptbundle_shared
    // Params 0, eflags: 0x0
    // Checksum 0xad7cb1a1, Offset: 0x610
    // Size: 0x16
    function get_type() {
        return _s.type;
    }

    // Namespace cscriptbundlebase/scriptbundle_shared
    // Params 3, eflags: 0x0
    // Checksum 0x223cbead, Offset: 0x5b8
    // Size: 0x4c
    function init(str_name, s, b_testing) {
        _s = s;
        _str_name = str_name;
        _testing = b_testing;
    }

    // Namespace cscriptbundlebase/scriptbundle_shared
    // Params 1, eflags: 0x0
    // Checksum 0xfdd3d25a, Offset: 0x568
    // Size: 0xc
    function on_error(e) {
        
    }

}

// Namespace scriptbundle/scriptbundle_shared
// Params 1, eflags: 0x0
// Checksum 0x230c4ed1, Offset: 0xac8
// Size: 0x174
function error_on_screen(str_msg) {
    if (str_msg != "") {
        if (!isdefined(level.scene_error_hud)) {
            level.scene_error_hud = createluimenu(0, "HudElementText");
            setluimenudata(0, level.scene_error_hud, "alignment", 1);
            setluimenudata(0, level.scene_error_hud, "x", 0);
            setluimenudata(0, level.scene_error_hud, "y", 10);
            setluimenudata(0, level.scene_error_hud, "width", 1920);
            openluimenu(0, level.scene_error_hud);
        }
        setluimenudata(0, level.scene_error_hud, "text", str_msg);
        self thread _destroy_error_on_screen();
    }
}

// Namespace scriptbundle/scriptbundle_shared
// Params 0, eflags: 0x0
// Checksum 0x179a68cf, Offset: 0xc48
// Size: 0x5e
function _destroy_error_on_screen() {
    level notify(#"_destroy_error_on_screen");
    level endon(#"_destroy_error_on_screen");
    self waittilltimeout(5, "stopped");
    closeluimenu(0, level.scene_error_hud);
    level.scene_error_hud = undefined;
}

