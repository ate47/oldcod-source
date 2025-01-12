#using scripts\core_common\clientfield_shared;
#using scripts\core_common\util_shared;

#namespace namespace_826acffa;

// Namespace namespace_826acffa/level_init
// Params 1, eflags: 0x40
// Checksum 0x1353a46a, Offset: 0xc0
// Size: 0x15c
function event_handler[level_init] main(*eventstruct) {
    clientfield::register("scriptmover", "supply_portal", 1, 1, "int", &function_cb4fe9eb, 0, 0);
    clientfield::register("scriptmover", "portal_form", 1, 1, "int", &function_45a7a147, 0, 0);
    clientfield::register("scriptmover", "smoke_fx", 1, 1, "int", &supply_drop_fx, 0, 0);
    level._effect[#"supply_portal"] = #"vehicle/fx8_replacer_car_spawn";
    level._effect[#"supply_drop"] = #"hash_2009074648ef05a5";
    level._effect[#"smoke_fx"] = #"hash_42b513cdb0d45d0e";
}

// Namespace namespace_826acffa/namespace_826acffa
// Params 7, eflags: 0x0
// Checksum 0xf2a7264a, Offset: 0x228
// Size: 0x74
function function_45a7a147(localclientnum, *oldval, *newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    util::playfxontag(bwastimejump, level._effect[#"supply_drop"], self, "tag_origin");
}

// Namespace namespace_826acffa/namespace_826acffa
// Params 7, eflags: 0x0
// Checksum 0x7bec54ef, Offset: 0x2a8
// Size: 0x74
function function_cb4fe9eb(localclientnum, *oldval, *newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    util::playfxontag(bwastimejump, level._effect[#"supply_portal"], self, "tag_origin");
}

// Namespace namespace_826acffa/namespace_826acffa
// Params 7, eflags: 0x0
// Checksum 0x34d2dce7, Offset: 0x328
// Size: 0x104
function supply_drop_fx(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    if (bwastimejump == 1) {
        self.e_fx = util::spawn_model(fieldname, "tag_origin", self.origin);
        self.e_fx linkto(self);
        self.n_fx = util::playfxontag(fieldname, level._effect[#"smoke_fx"], self.e_fx, "tag_origin");
        return;
    }
    if (isdefined(self.n_fx)) {
        stopfx(fieldname, self.n_fx);
    }
}

