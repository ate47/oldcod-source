#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace namespace_a5ef5769;

// Namespace namespace_a5ef5769/namespace_a5ef5769
// Params 0, eflags: 0x6
// Checksum 0xd64a36dc, Offset: 0xb0
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"hash_52556758a0c8acfe", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace namespace_a5ef5769/namespace_a5ef5769
// Params 0, eflags: 0x5 linked
// Checksum 0x5ec1de44, Offset: 0xf8
// Size: 0xb4
function private function_70a657d8() {
    clientfield::register("scriptmover", "" + #"hash_47e7d5219a26a786", 1, 2, "int", &function_dd46bc90, 0, 0);
    clientfield::register("actor", "" + #"hash_3a47820a21ce3170", 1, 1, "int", &function_219213be, 0, 0);
}

// Namespace namespace_a5ef5769/namespace_a5ef5769
// Params 7, eflags: 0x1 linked
// Checksum 0xcbfed884, Offset: 0x1b8
// Size: 0x1ce
function function_dd46bc90(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    if (bwastimejump == 1) {
        self.var_4334046f = util::playfxontag(fieldname, #"hash_749cccc5aca020a9", self, "tag_origin");
        return;
    }
    if (bwastimejump == 2) {
        self.var_3b5344ab = util::playfxontag(fieldname, #"hash_5b10352ebf3b48f0", self, "tag_origin");
        return;
    }
    if (bwastimejump == 3) {
        util::playfxontag(fieldname, #"hash_26d0dc927aee6793", self, "tag_origin");
        if (isdefined(self.var_4334046f)) {
            killfx(fieldname, self.var_4334046f);
            self.var_4334046f = undefined;
        }
        if (isdefined(self.var_3b5344ab)) {
            killfx(fieldname, self.var_3b5344ab);
            self.var_3b5344ab = undefined;
        }
        return;
    }
    if (isdefined(self.var_4334046f)) {
        killfx(fieldname, self.var_4334046f);
        self.var_4334046f = undefined;
    }
    if (isdefined(self.var_3b5344ab)) {
        killfx(fieldname, self.var_3b5344ab);
        self.var_3b5344ab = undefined;
    }
}

// Namespace namespace_a5ef5769/namespace_a5ef5769
// Params 7, eflags: 0x1 linked
// Checksum 0xae0b53a, Offset: 0x390
// Size: 0x64
function function_219213be(*localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    if (bwastimejump) {
        self playrenderoverridebundle(#"hash_16d59f099e418f4f");
    }
}

