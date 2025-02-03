#namespace scriptbundle;

// Namespace scriptbundle
// Method(s) 6 Total 6
class cscriptbundleobjectbase {

    var _e_array;
    var _n_clientnum;
    var _o_scene;
    var _s;

    // Namespace cscriptbundleobjectbase/scriptbundle_shared
    // Params 2, eflags: 0x0
    // Checksum 0xcc8ec503, Offset: 0x230
    // Size: 0x128
    function error(condition, str_msg) {
        if (condition) {
            if ([[ _o_scene ]]->is_testing()) {
                scriptbundle::error_on_screen(str_msg);
            } else {
                assertmsg([[ _o_scene ]]->get_type() + "<dev string:x59>" + function_9e72a96(_o_scene._str_name) + "<dev string:x5e>" + (isdefined("<dev string:x69>") ? "<dev string:x65>" + "<dev string:x69>" : isdefined(_s.name) ? "<dev string:x65>" + _s.name : "<dev string:x65>") + "<dev string:x74>" + str_msg);
            }
            thread [[ _o_scene ]]->on_error();
            return true;
        }
        return false;
    }

    // Namespace cscriptbundleobjectbase/scriptbundle_shared
    // Params 1, eflags: 0x0
    // Checksum 0x3ddfd646, Offset: 0x360
    // Size: 0x18
    function get_ent(localclientnum) {
        return _e_array[localclientnum];
    }

    // Namespace cscriptbundleobjectbase/scriptbundle_shared
    // Params 4, eflags: 0x0
    // Checksum 0xb2e46a61, Offset: 0x88
    // Size: 0xc6
    function init(s_objdef, o_bundle, e_ent, localclientnum) {
        _s = s_objdef;
        _o_scene = o_bundle;
        if (isdefined(e_ent)) {
            assert(!isdefined(localclientnum) || e_ent.localclientnum == localclientnum, "<dev string:x38>");
            _n_clientnum = e_ent.localclientnum;
            _e_array[_n_clientnum] = e_ent;
            return;
        }
        _e_array = [];
        if (isdefined(localclientnum)) {
            _n_clientnum = localclientnum;
        }
    }

    // Namespace cscriptbundleobjectbase/scriptbundle_shared
    // Params 1, eflags: 0x0
    // Checksum 0x83285078, Offset: 0x158
    // Size: 0xcc
    function log(str_msg) {
        println([[ _o_scene ]]->get_type() + "<dev string:x59>" + function_9e72a96(_o_scene._str_name) + "<dev string:x5e>" + (isdefined("<dev string:x69>") ? "<dev string:x65>" + "<dev string:x69>" : isdefined(_s.name) ? "<dev string:x65>" + _s.name : "<dev string:x65>") + "<dev string:x74>" + str_msg);
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
    // Checksum 0x48887fc8, Offset: 0x4e0
    // Size: 0x1a
    constructor() {
        _a_objects = [];
        _testing = 0;
    }

    // Namespace cscriptbundlebase/scriptbundle_shared
    // Params 2, eflags: 0x0
    // Checksum 0xf4e06553, Offset: 0x6f0
    // Size: 0x9c
    function error(condition, str_msg) {
        if (condition) {
            if (_testing) {
            } else {
                assertmsg(_s.type + "<dev string:x59>" + function_9e72a96(_str_name) + "<dev string:x7a>" + str_msg);
            }
            thread on_error();
            return true;
        }
        return false;
    }

    // Namespace cscriptbundlebase/scriptbundle_shared
    // Params 0, eflags: 0x0
    // Checksum 0xc08b1c46, Offset: 0x588
    // Size: 0x12
    function get_vm() {
        return _s.vmtype;
    }

    // Namespace cscriptbundlebase/scriptbundle_shared
    // Params 0, eflags: 0x0
    // Checksum 0xdbe32ab2, Offset: 0x568
    // Size: 0x12
    function get_type() {
        return _s.type;
    }

    // Namespace cscriptbundlebase/scriptbundle_shared
    // Params 1, eflags: 0x0
    // Checksum 0xef0df279, Offset: 0x5e0
    // Size: 0x74
    function add_object(o_object) {
        if (!isdefined(_a_objects)) {
            _a_objects = [];
        } else if (!isarray(_a_objects)) {
            _a_objects = array(_a_objects);
        }
        _a_objects[_a_objects.size] = o_object;
    }

    // Namespace cscriptbundlebase/scriptbundle_shared
    // Params 1, eflags: 0x0
    // Checksum 0x1e09ddaf, Offset: 0x4c8
    // Size: 0xc
    function on_error(*e) {
        
    }

    // Namespace cscriptbundlebase/scriptbundle_shared
    // Params 0, eflags: 0x0
    // Checksum 0x62491c33, Offset: 0x5c8
    // Size: 0xa
    function is_testing() {
        return _testing;
    }

    // Namespace cscriptbundlebase/scriptbundle_shared
    // Params 1, eflags: 0x0
    // Checksum 0x1ad137ee, Offset: 0x660
    // Size: 0x24
    function remove_object(o_object) {
        arrayremovevalue(_a_objects, o_object);
    }

    // Namespace cscriptbundlebase/scriptbundle_shared
    // Params 3, eflags: 0x0
    // Checksum 0x6864541f, Offset: 0x518
    // Size: 0x42
    function init(str_name, s, b_testing) {
        _s = s;
        _str_name = str_name;
        _testing = b_testing;
    }

    // Namespace cscriptbundlebase/scriptbundle_shared
    // Params 0, eflags: 0x0
    // Checksum 0x10f6e60, Offset: 0x5a8
    // Size: 0x12
    function get_objects() {
        return _s.objects;
    }

    // Namespace cscriptbundlebase/scriptbundle_shared
    // Params 1, eflags: 0x0
    // Checksum 0x6af9bad7, Offset: 0x690
    // Size: 0x54
    function log(str_msg) {
        println(_s.type + "<dev string:x59>" + _str_name + "<dev string:x7a>" + str_msg);
    }

}

// Namespace scriptbundle/scriptbundle_shared
// Params 1, eflags: 0x0
// Checksum 0x1166f4a2, Offset: 0xa00
// Size: 0x34
function error_on_screen(str_msg) {
    if (str_msg != "") {
        errormsg(str_msg);
    }
}

