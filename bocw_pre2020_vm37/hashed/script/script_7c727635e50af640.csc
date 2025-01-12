#using script_4e53735256f112ac;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\postfx_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\zm_utility;

#namespace namespace_1fd59e39;

// Namespace namespace_1fd59e39/namespace_1fd59e39
// Params 0, eflags: 0x6
// Checksum 0x424234ca, Offset: 0xc0
// Size: 0x44
function private autoexec __init__system__() {
    system::register(#"hash_7fd3c8de50685459", &function_70a657d8, undefined, undefined, #"hash_13a43d760497b54d");
}

// Namespace namespace_1fd59e39/namespace_1fd59e39
// Params 0, eflags: 0x5 linked
// Checksum 0x23ce8d0e, Offset: 0x110
// Size: 0x5c
function private function_70a657d8() {
    clientfield::register("allplayers", "" + #"hash_59400ab6cbfaec5d", 1, 1, "int", &function_3d1947be, 0, 0);
}

// Namespace namespace_1fd59e39/namespace_1fd59e39
// Params 7, eflags: 0x1 linked
// Checksum 0x93cd3b1a, Offset: 0x178
// Size: 0x3b6
function function_3d1947be(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    if (bwastimejump) {
        if (zm_utility::function_f8796df3(fieldname)) {
            self playrenderoverridebundle(#"hash_6ec5fcc31672bb85");
            self postfx::playpostfxbundle(#"hash_5bcfd80691463dec");
            self.var_6ebc510f = playfxoncamera(fieldname, #"hash_7fcde6a254a7228", (0, 0, 0), (1, 0, 0), (0, 0, 1));
        } else {
            self playrenderoverridebundle(#"hash_733f9eb274c33ff8");
            self.var_afd98b5 = util::playfxontag(fieldname, #"hash_803ea6a2550a53a", self, "j_head");
            self.var_895c513a = util::playfxontag(fieldname, #"hash_ee42b8ead6d79d1", self, "j_spine4");
        }
        if (!isdefined(self.var_631ff0ad)) {
            self playsound(fieldname, #"hash_6f1e98cba03ff12a", self.origin + (0, 0, 75));
            self.var_631ff0ad = self playloopsound(#"hash_493bcaf7ad0973e", undefined, (0, 0, 75));
        }
        return;
    }
    if (self function_d2503806(#"hash_6ec5fcc31672bb85")) {
        self stoprenderoverridebundle(#"hash_6ec5fcc31672bb85");
    }
    if (self function_d2503806(#"hash_733f9eb274c33ff8")) {
        self stoprenderoverridebundle(#"hash_733f9eb274c33ff8");
    }
    if (self postfx::function_556665f2(#"hash_5bcfd80691463dec")) {
        self postfx::exitpostfxbundle(#"hash_5bcfd80691463dec");
    }
    if (isdefined(self.var_6ebc510f)) {
        stopfx(fieldname, self.var_6ebc510f);
        self.var_6ebc510f = undefined;
    }
    if (isdefined(self.var_afd98b5)) {
        stopfx(fieldname, self.var_afd98b5);
        self.var_afd98b5 = undefined;
    }
    if (isdefined(self.var_895c513a)) {
        stopfx(fieldname, self.var_895c513a);
        self.var_895c513a = undefined;
    }
    if (isdefined(self.var_631ff0ad)) {
        self playsound(fieldname, #"hash_5a6fa72d8d9f935f", self.origin + (0, 0, 75));
        self stoploopsound(self.var_631ff0ad);
        self.var_631ff0ad = undefined;
    }
}

