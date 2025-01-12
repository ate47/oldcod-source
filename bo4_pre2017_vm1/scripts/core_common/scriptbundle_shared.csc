#using scripts/core_common/util_shared;

#namespace cscriptbundleobjectbase;

// Namespace cscriptbundleobjectbase/scriptbundle_shared
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0xe0
// Size: 0x4
function __constructor() {
    
}

// Namespace cscriptbundleobjectbase/scriptbundle_shared
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0xf0
// Size: 0x4
function __destructor() {
    
}

// Namespace cscriptbundleobjectbase/scriptbundle_shared
// Params 4, eflags: 0x0
// Checksum 0xa68d9dba, Offset: 0x100
// Size: 0xe8
function init(s_objdef, o_bundle, e_ent, localclientnum) {
    self._s = s_objdef;
    self.var_190b1ea2 = o_bundle;
    if (isdefined(e_ent)) {
        /#
            assert(!isdefined(localclientnum) || e_ent.localclientnum == localclientnum, "<dev string:x28>");
        #/
        self._n_clientnum = e_ent.localclientnum;
        self._e_array[self._n_clientnum] = e_ent;
        return;
    }
    self._e_array = [];
    if (isdefined(localclientnum)) {
        self._n_clientnum = localclientnum;
    }
}

// Namespace cscriptbundleobjectbase/scriptbundle_shared
// Params 1, eflags: 0x0
// Checksum 0x4e61779c, Offset: 0x1f0
// Size: 0xc4
function log(str_msg) {
    /#
        println([[ self.var_190b1ea2 ]]->get_type() + "<dev string:x46>" + self.var_190b1ea2._str_name + "<dev string:x48>" + (isdefined("<dev string:x4d>") ? "<dev string:x4c>" + "<dev string:x4d>" : isdefined(self._s.name) ? "<dev string:x4c>" + self._s.name : "<dev string:x4c>") + "<dev string:x55>" + str_msg);
    #/
}

// Namespace cscriptbundleobjectbase/scriptbundle_shared
// Params 2, eflags: 0x0
// Checksum 0x446a79a8, Offset: 0x2c0
// Size: 0x128
function error(condition, str_msg) {
    if (condition) {
        if ([[ self.var_190b1ea2 ]]->is_testing()) {
            scriptbundle::error_on_screen(str_msg);
        } else {
            /#
                assertmsg([[ self.var_190b1ea2 ]]->get_type() + "<dev string:x46>" + self.var_190b1ea2._str_name + "<dev string:x48>" + (isdefined("<dev string:x4d>") ? "<dev string:x4c>" + "<dev string:x4d>" : isdefined(self._s.name) ? "<dev string:x4c>" + self._s.name : "<dev string:x4c>") + "<dev string:x55>" + str_msg);
            #/
        }
        thread [[ self.var_190b1ea2 ]]->on_error();
        return true;
    }
    return false;
}

// Namespace cscriptbundleobjectbase/scriptbundle_shared
// Params 1, eflags: 0x0
// Checksum 0xf7ac0e4e, Offset: 0x3f0
// Size: 0x1c
function get_ent(localclientnum) {
    return self._e_array[localclientnum];
}

#namespace scriptbundle;

// Namespace scriptbundle/scriptbundle_shared
// Params 0, eflags: 0x6
// Checksum 0x6501aba0, Offset: 0x418
// Size: 0x146
function private autoexec cscriptbundleobjectbase() {
    classes.cscriptbundleobjectbase[0] = spawnstruct();
    classes.cscriptbundleobjectbase[0].__vtable[964891661] = &cscriptbundleobjectbase::get_ent;
    classes.cscriptbundleobjectbase[0].__vtable[-32002227] = &cscriptbundleobjectbase::error;
    classes.cscriptbundleobjectbase[0].__vtable[1621988813] = &cscriptbundleobjectbase::log;
    classes.cscriptbundleobjectbase[0].__vtable[-1017222485] = &cscriptbundleobjectbase::init;
    classes.cscriptbundleobjectbase[0].__vtable[1606033458] = &cscriptbundleobjectbase::__destructor;
    classes.cscriptbundleobjectbase[0].__vtable[-1690805083] = &cscriptbundleobjectbase::__constructor;
}

#namespace cscriptbundlebase;

// Namespace cscriptbundlebase/scriptbundle_shared
// Params 1, eflags: 0x0
// Checksum 0xfdd3d25a, Offset: 0x568
// Size: 0xc
function on_error(e) {
    
}

// Namespace cscriptbundlebase/scriptbundle_shared
// Params 0, eflags: 0x0
// Checksum 0xb05f4042, Offset: 0x580
// Size: 0x1c
function __constructor() {
    self._a_objects = [];
    self._testing = 0;
}

// Namespace cscriptbundlebase/scriptbundle_shared
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x5a8
// Size: 0x4
function __destructor() {
    
}

// Namespace cscriptbundlebase/scriptbundle_shared
// Params 3, eflags: 0x0
// Checksum 0x223cbead, Offset: 0x5b8
// Size: 0x4c
function init(str_name, s, b_testing) {
    self._s = s;
    self._str_name = str_name;
    self._testing = b_testing;
}

// Namespace cscriptbundlebase/scriptbundle_shared
// Params 0, eflags: 0x0
// Checksum 0xad7cb1a1, Offset: 0x610
// Size: 0x16
function get_type() {
    return self._s.type;
}

// Namespace cscriptbundlebase/scriptbundle_shared
// Params 0, eflags: 0x0
// Checksum 0x16e87639, Offset: 0x630
// Size: 0x16
function get_vm() {
    return self._s.vmtype;
}

// Namespace cscriptbundlebase/scriptbundle_shared
// Params 0, eflags: 0x0
// Checksum 0x965ca52c, Offset: 0x650
// Size: 0x16
function get_objects() {
    return self._s.objects;
}

// Namespace cscriptbundlebase/scriptbundle_shared
// Params 0, eflags: 0x0
// Checksum 0xefb3a1c3, Offset: 0x670
// Size: 0xe
function is_testing() {
    return self._testing;
}

// Namespace cscriptbundlebase/scriptbundle_shared
// Params 1, eflags: 0x0
// Checksum 0x7fe0c832, Offset: 0x688
// Size: 0x8a
function add_object(o_object) {
    if (!isdefined(self._a_objects)) {
        self._a_objects = [];
    } else if (!isarray(self._a_objects)) {
        self._a_objects = array(self._a_objects);
    }
    self._a_objects[self._a_objects.size] = o_object;
}

// Namespace cscriptbundlebase/scriptbundle_shared
// Params 1, eflags: 0x0
// Checksum 0xea939dc7, Offset: 0x720
// Size: 0x2c
function remove_object(o_object) {
    arrayremovevalue(self._a_objects, o_object);
}

// Namespace cscriptbundlebase/scriptbundle_shared
// Params 1, eflags: 0x0
// Checksum 0x935a0056, Offset: 0x758
// Size: 0x54
function log(str_msg) {
    /#
        println(self._s.type + "<dev string:x46>" + self._str_name + "<dev string:x58>" + str_msg);
    #/
}

// Namespace cscriptbundlebase/scriptbundle_shared
// Params 2, eflags: 0x0
// Checksum 0xc767ac04, Offset: 0x7b8
// Size: 0x94
function error(condition, str_msg) {
    if (condition) {
        if (self._testing) {
        } else {
            /#
                assertmsg(self._s.type + "<dev string:x46>" + self._str_name + "<dev string:x58>" + str_msg);
            #/
        }
        thread [[ self ]]->on_error();
        return true;
    }
    return false;
}

#namespace scriptbundle;

// Namespace scriptbundle/scriptbundle_shared
// Params 0, eflags: 0x6
// Checksum 0x96d170e9, Offset: 0x858
// Size: 0x266
function private autoexec cscriptbundlebase() {
    classes.cscriptbundlebase[0] = spawnstruct();
    classes.cscriptbundlebase[0].__vtable[-32002227] = &cscriptbundlebase::error;
    classes.cscriptbundlebase[0].__vtable[1621988813] = &cscriptbundlebase::log;
    classes.cscriptbundlebase[0].__vtable[713694985] = &cscriptbundlebase::remove_object;
    classes.cscriptbundlebase[0].__vtable[178798596] = &cscriptbundlebase::add_object;
    classes.cscriptbundlebase[0].__vtable[1440274456] = &cscriptbundlebase::is_testing;
    classes.cscriptbundlebase[0].__vtable[-512051494] = &cscriptbundlebase::get_objects;
    classes.cscriptbundlebase[0].__vtable[575565049] = &cscriptbundlebase::get_vm;
    classes.cscriptbundlebase[0].__vtable[1872615990] = &cscriptbundlebase::get_type;
    classes.cscriptbundlebase[0].__vtable[-1017222485] = &cscriptbundlebase::init;
    classes.cscriptbundlebase[0].__vtable[1606033458] = &cscriptbundlebase::__destructor;
    classes.cscriptbundlebase[0].__vtable[-1690805083] = &cscriptbundlebase::__constructor;
    classes.cscriptbundlebase[0].__vtable[-498584435] = &cscriptbundlebase::on_error;
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

