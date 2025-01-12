#using scripts\core_common\clientfield_shared;
#using scripts\core_common\util_shared;

#namespace zm_escape_util;

// Namespace zm_escape_util/zm_escape_util
// Params 0, eflags: 0x0
// Checksum 0x13532dfa, Offset: 0xa0
// Size: 0x13a
function init_clientfields() {
    clientfield::register("scriptmover", "" + #"hash_7327d0447d656234", 1, 1, "int", &function_44d9a167, 0, 0);
    clientfield::register("item", "" + #"hash_76662556681a502c", 1, 1, "int", &function_b31fba2a, 0, 0);
    clientfield::register("scriptmover", "" + #"hash_59be891b288663cc", 1, 1, "int", &function_2d50e9fe, 0, 0);
    level._effect[#"hash_7e0daf8faf89bbcf"] = #"hash_1f101b4b415639bb";
}

// Namespace zm_escape_util/zm_escape_util
// Params 7, eflags: 0x0
// Checksum 0x7502947e, Offset: 0x1e8
// Size: 0x176
function function_44d9a167(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    if (newval == 1) {
        if (!isdefined(level.var_6da26c79)) {
            level.var_6da26c79 = [];
        } else if (!isarray(level.var_6da26c79)) {
            level.var_6da26c79 = array(level.var_6da26c79);
        }
        if (!isinarray(level.var_6da26c79, self)) {
            level.var_6da26c79[level.var_6da26c79.size] = self;
        }
        self.show_function = &function_75245fb8;
        self.hide_function = &function_48da1129;
        self hide();
        return;
    }
    arrayremovevalue(level.var_6da26c79, self);
    self show();
    self notify(#"hash_6ab654a4c018818c");
}

// Namespace zm_escape_util/zm_escape_util
// Params 1, eflags: 0x4
// Checksum 0x9331cf0c, Offset: 0x368
// Size: 0x36
function private function_75245fb8(localclientnum) {
    self show();
    self notify(#"set_visible");
}

// Namespace zm_escape_util/zm_escape_util
// Params 1, eflags: 0x4
// Checksum 0x3b04fa83, Offset: 0x3a8
// Size: 0x36
function private function_48da1129(localclientnum) {
    self hide();
    self notify(#"set_invisible");
}

// Namespace zm_escape_util/zm_escape_util
// Params 7, eflags: 0x0
// Checksum 0x396741da, Offset: 0x3e8
// Size: 0x112
function function_b31fba2a(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    if (isdefined(self.n_fx_id)) {
        stopfx(localclientnum, self.n_fx_id);
        self.n_fx_id = undefined;
    }
    if (isdefined(self.var_1bfe429b)) {
        self stoploopsound(self.var_1bfe429b);
        self.var_1bfe429b = undefined;
    }
    if (newval) {
        self.n_fx_id = util::playfxontag(localclientnum, level._effect[#"hash_4d2e5c87bde94856"], self, "tag_origin");
        self.var_1bfe429b = self playloopsound(#"hash_2f017f6ef4550155");
    }
}

// Namespace zm_escape_util/zm_escape_util
// Params 7, eflags: 0x0
// Checksum 0x3b546542, Offset: 0x508
// Size: 0xba
function function_2d50e9fe(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    if (isdefined(self.var_7cfa9f2b)) {
        stopfx(localclientnum, self.var_7cfa9f2b);
        self.var_7cfa9f2b = undefined;
    }
    if (newval == 1) {
        self.var_7cfa9f2b = util::playfxontag(localclientnum, level._effect[#"hash_7e0daf8faf89bbcf"], self, "tag_origin");
    }
}

