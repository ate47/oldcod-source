#using script_4e53735256f112ac;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace namespace_2ab93693;

// Namespace namespace_2ab93693/namespace_2ab93693
// Params 0, eflags: 0x6
// Checksum 0x182514d, Offset: 0xc0
// Size: 0x44
function private autoexec __init__system__() {
    system::register(#"hash_662c938bd03bd1ad", &function_70a657d8, undefined, undefined, #"hash_13a43d760497b54d");
}

// Namespace namespace_2ab93693/namespace_2ab93693
// Params 0, eflags: 0x5 linked
// Checksum 0x7ee7ed6f, Offset: 0x110
// Size: 0xb4
function private function_70a657d8() {
    clientfield::register("scriptmover", "" + #"hash_142ed640bf2e09b9", 1, 1, "int", &function_9ab6532, 0, 0);
    clientfield::register("actor", "" + #"hash_717ed5a81b281ebd", 1, 1, "counter", &function_49585088, 0, 0);
}

// Namespace namespace_2ab93693/namespace_2ab93693
// Params 7, eflags: 0x1 linked
// Checksum 0x89423b65, Offset: 0x1d0
// Size: 0xbe
function function_9ab6532(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    if (bwastimejump) {
        if (!isdefined(self.var_2d4a2068)) {
            self.var_2d4a2068 = util::playfxontag(fieldname, #"hash_612c96cf772b0fff", self, "tag_origin");
        }
        return;
    }
    if (isdefined(self.var_2d4a2068)) {
        stopfx(fieldname, self.var_2d4a2068);
        self.var_2d4a2068 = undefined;
    }
}

// Namespace namespace_2ab93693/namespace_2ab93693
// Params 7, eflags: 0x1 linked
// Checksum 0xa7b04b39, Offset: 0x298
// Size: 0x64
function function_49585088(localclientnum, *oldval, *newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    util::playfxontag(bwastimejump, #"hash_1c001d6fb3eddb07", self, "tag_origin");
}

