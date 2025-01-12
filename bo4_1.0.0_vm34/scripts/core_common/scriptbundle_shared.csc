#namespace scriptbundle;

// Namespace scriptbundle
// Method(s) 6 Total 6
class cscriptbundleobjectbase {

    var _e_array;
    var _n_clientnum;
    var _o_scene;
    var _s;

    // Namespace cscriptbundleobjectbase/scriptbundle_shared
    // Params 1, eflags: 0x0
    // Checksum 0xf5057245, Offset: 0x378
    // Size: 0x18
    function get_ent(localclientnum) {
        return _e_array[localclientnum];
    }

    // Namespace cscriptbundleobjectbase/scriptbundle_shared
    // Params 2, eflags: 0x0
    // Checksum 0xf5035d11, Offset: 0x248
    // Size: 0x128
    function error(condition, str_msg) {
        if (condition) {
            if ([[ _o_scene ]]->is_testing()) {
                scriptbundle::error_on_screen(str_msg);
            } else {
                assertmsg([[ _o_scene ]]->get_type() + "<dev string:x4e>" + function_15979fa9(_o_scene._str_name) + "<dev string:x50>" + (isdefined("<dev string:x55>") ? "<dev string:x54>" + "<dev string:x55>" : isdefined(_s.name) ? "<dev string:x54>" + _s.name : "<dev string:x54>") + "<dev string:x5d>" + str_msg);
            }
            thread [[ _o_scene ]]->on_error();
            return true;
        }
        return false;
    }

    // Namespace cscriptbundleobjectbase/scriptbundle_shared
    // Params 1, eflags: 0x0
    // Checksum 0xc2821ecd, Offset: 0x170
    // Size: 0xcc
    function log(str_msg) {
        println([[ _o_scene ]]->get_type() + "<dev string:x4e>" + function_15979fa9(_o_scene._str_name) + "<dev string:x50>" + (isdefined("<dev string:x55>") ? "<dev string:x54>" + "<dev string:x55>" : isdefined(_s.name) ? "<dev string:x54>" + _s.name : "<dev string:x54>") + "<dev string:x5d>" + str_msg);
    }

    // Namespace cscriptbundleobjectbase/scriptbundle_shared
    // Params 4, eflags: 0x0
    // Checksum 0x7880692e, Offset: 0x98
    // Size: 0xca
    function init(s_objdef, o_bundle, e_ent, localclientnum) {
        _s = s_objdef;
        _o_scene = o_bundle;
        if (isdefined(e_ent)) {
            assert(!isdefined(localclientnum) || e_ent.localclientnum == localclientnum, "<dev string:x30>");
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
    // Params 0, eflags: 0x8
    // Checksum 0xad9d1e43, Offset: 0x500
    // Size: 0x1a
    constructor() {
        _a_objects = [];
        _testing = 0;
    }

    // Namespace cscriptbundlebase/scriptbundle_shared
    // Params 2, eflags: 0x0
    // Checksum 0xe21aac3e, Offset: 0x710
    // Size: 0x9c
    function error(condition, str_msg) {
        if (condition) {
            if (_testing) {
            } else {
                assertmsg(_s.type + "<dev string:x4e>" + function_15979fa9(_str_name) + "<dev string:x60>" + str_msg);
            }
            thread on_error();
            return true;
        }
        return false;
    }

    // Namespace cscriptbundlebase/scriptbundle_shared
    // Params 1, eflags: 0x0
    // Checksum 0xacd8964d, Offset: 0x6b0
    // Size: 0x54
    function log(str_msg) {
        println(_s.type + "<dev string:x4e>" + _str_name + "<dev string:x60>" + str_msg);
    }

    // Namespace cscriptbundlebase/scriptbundle_shared
    // Params 1, eflags: 0x0
    // Checksum 0x585fa478, Offset: 0x680
    // Size: 0x24
    function remove_object(o_object) {
        arrayremovevalue(_a_objects, o_object);
    }

    // Namespace cscriptbundlebase/scriptbundle_shared
    // Params 1, eflags: 0x0
    // Checksum 0x297b82d2, Offset: 0x600
    // Size: 0x76
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
    // Checksum 0xb28a7584, Offset: 0x5e8
    // Size: 0xa
    function is_testing() {
        return _testing;
    }

    // Namespace cscriptbundlebase/scriptbundle_shared
    // Params 0, eflags: 0x0
    // Checksum 0x94610aea, Offset: 0x5c8
    // Size: 0x12
    function get_objects() {
        return _s.objects;
    }

    // Namespace cscriptbundlebase/scriptbundle_shared
    // Params 0, eflags: 0x0
    // Checksum 0x18bf41a9, Offset: 0x5a8
    // Size: 0x12
    function get_vm() {
        return _s.vmtype;
    }

    // Namespace cscriptbundlebase/scriptbundle_shared
    // Params 0, eflags: 0x0
    // Checksum 0xf640902d, Offset: 0x588
    // Size: 0x12
    function get_type() {
        return _s.type;
    }

    // Namespace cscriptbundlebase/scriptbundle_shared
    // Params 3, eflags: 0x0
    // Checksum 0xb95ea16f, Offset: 0x538
    // Size: 0x42
    function init(str_name, s, b_testing) {
        _s = s;
        _str_name = str_name;
        _testing = b_testing;
    }

    // Namespace cscriptbundlebase/scriptbundle_shared
    // Params 1, eflags: 0x0
    // Checksum 0xe45ea8a8, Offset: 0x4e8
    // Size: 0xc
    function on_error(e) {
        
    }

}

// Namespace scriptbundle/scriptbundle_shared
// Params 1, eflags: 0x0
// Checksum 0x69765e9c, Offset: 0xa28
// Size: 0x16c
function error_on_screen(str_msg) {
    if (str_msg != "") {
        if (!isdefined(level.scene_error_hud)) {
            level.scene_error_hud = createluimenu(0, "HudElementText");
            setluimenudata(0, level.scene_error_hud, #"alignment", 1);
            setluimenudata(0, level.scene_error_hud, #"x", 0);
            setluimenudata(0, level.scene_error_hud, #"y", 10);
            setluimenudata(0, level.scene_error_hud, #"width", 1920);
            openluimenu(0, level.scene_error_hud);
        }
        setluimenudata(0, level.scene_error_hud, #"text", str_msg);
        self thread _destroy_error_on_screen();
    }
}

// Namespace scriptbundle/scriptbundle_shared
// Params 0, eflags: 0x0
// Checksum 0x26a0fd8, Offset: 0xba0
// Size: 0x6e
function _destroy_error_on_screen() {
    level notify(#"_destroy_error_on_screen");
    level endon(#"_destroy_error_on_screen");
    self waittilltimeout(5, #"stopped");
    closeluimenu(0, level.scene_error_hud);
    level.scene_error_hud = undefined;
}

