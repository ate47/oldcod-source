#using scripts\core_common\clientfield_shared;
#using scripts\core_common\util_shared;

#namespace namespace_d8b81d0b;

// Namespace namespace_d8b81d0b/namespace_9088ffd
// Params 0, eflags: 0x0
// Checksum 0x22ae838a, Offset: 0xa0
// Size: 0xe2
function init_clientfields() {
    clientfield::register("scriptmover", "" + #"hash_3e57db9b106dff0a", 1, 1, "int", &function_db0568c4, 0, 0);
    clientfield::register("scriptmover", "" + #"hash_4ccf2ce25e0dc836", 1, 1, "int", &function_2d509af4, 0, 0);
    level._effect[#"hash_62343c2144d3f8d1"] = #"hash_e567a706dafea31";
}

// Namespace namespace_d8b81d0b/namespace_9088ffd
// Params 7, eflags: 0x0
// Checksum 0xb6eb4af3, Offset: 0x190
// Size: 0xb4
function function_db0568c4(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        self.n_fx_id = util::playfxontag(localclientnum, level._effect[#"powerup_on_solo"], self, "tag_origin");
        return;
    }
    if (isdefined(self.n_fx_id)) {
        stopfx(localclientnum, self.n_fx_id);
    }
}

// Namespace namespace_d8b81d0b/namespace_9088ffd
// Params 7, eflags: 0x0
// Checksum 0x6f549996, Offset: 0x250
// Size: 0xb4
function function_2d509af4(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        self.var_94f97f45 = util::playfxontag(localclientnum, level._effect[#"hash_62343c2144d3f8d1"], self, "tag_animate");
        return;
    }
    if (isdefined(self.var_94f97f45)) {
        stopfx(localclientnum, self.var_94f97f45);
    }
}

