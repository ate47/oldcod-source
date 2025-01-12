#using scripts\core_common\clientfield_shared;
#using scripts\core_common\util_shared;

#namespace zm_escape_catwalk_event;

// Namespace zm_escape_catwalk_event/zm_escape_catwalk_event
// Params 0, eflags: 0x0
// Checksum 0xa02cba33, Offset: 0xa0
// Size: 0x32
function init_fx() {
    level._effect[#"hash_46085f7d2bcd82c5"] = #"hash_404575a78667befd";
}

// Namespace zm_escape_catwalk_event/zm_escape_catwalk_event
// Params 0, eflags: 0x0
// Checksum 0x478f37ec, Offset: 0xe0
// Size: 0xb4
function init_clientfields() {
    clientfield::register("scriptmover", "" + #"hash_144c7c2895ed95c", 1, 1, "int", &function_c4532db1, 0, 0);
    clientfield::register("scriptmover", "" + #"hash_48f1f50c412d80c7", 1, 1, "counter", &function_f32a8a74, 0, 0);
}

// Namespace zm_escape_catwalk_event/zm_escape_catwalk_event
// Params 7, eflags: 0x0
// Checksum 0x66a6adbb, Offset: 0x1a0
// Size: 0xaa
function function_c4532db1(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (isdefined(self.n_fx_id)) {
        killfx(localclientnum, self.n_fx_id);
    }
    if (newval) {
        self.n_fx_id = util::playfxontag(localclientnum, level._effect[#"hash_46085f7d2bcd82c5"], self, "tag_origin");
    }
}

// Namespace zm_escape_catwalk_event/zm_escape_catwalk_event
// Params 7, eflags: 0x0
// Checksum 0x84a3ee4c, Offset: 0x258
// Size: 0x64
function function_f32a8a74(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self playrumbleonentity(localclientnum, #"zm_escape_catwalk_door");
}

