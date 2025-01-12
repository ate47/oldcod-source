#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace namespace_9d3ef6c5;

// Namespace namespace_9d3ef6c5/namespace_9d3ef6c5
// Params 0, eflags: 0x6
// Checksum 0x62384b39, Offset: 0xc0
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"hash_3c412421c33b7764", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace namespace_9d3ef6c5/namespace_9d3ef6c5
// Params 0, eflags: 0x1 linked
// Checksum 0x27b220a4, Offset: 0x108
// Size: 0x14
function function_70a657d8() {
    init_clientfields();
}

// Namespace namespace_9d3ef6c5/namespace_9d3ef6c5
// Params 0, eflags: 0x1 linked
// Checksum 0x6dbe0093, Offset: 0x128
// Size: 0x5c
function init_clientfields() {
    clientfield::register("scriptmover", "" + #"hash_56ce10c39906bf70", 1, 1, "int", &function_1fad5dd0, 0, 0);
}

// Namespace namespace_9d3ef6c5/namespace_9d3ef6c5
// Params 7, eflags: 0x1 linked
// Checksum 0xcc8478d1, Offset: 0x190
// Size: 0x116
function function_1fad5dd0(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    if (bwastimejump == 1) {
        self.fx = util::playfxontag(fieldname, #"hash_46b64b63ec916fb0", self, "tag_origin");
        self.sfx = self playloopsound("zmb_darkaether_portal_lp");
        return;
    }
    if (bwastimejump == 0) {
        if (isdefined(self.fx)) {
            stopfx(fieldname, self.fx);
            self.fx = undefined;
        }
        if (isdefined(self.sfx)) {
            self stoploopsound(self.sfx);
            self.sfx = undefined;
        }
    }
}

