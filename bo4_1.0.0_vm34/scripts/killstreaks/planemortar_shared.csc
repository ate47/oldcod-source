#using scripts\core_common\clientfield_shared;
#using scripts\core_common\util_shared;

#namespace planemortar;

// Namespace planemortar/planemortar_shared
// Params 0, eflags: 0x0
// Checksum 0x79a02da3, Offset: 0xd0
// Size: 0x7c
function init_shared() {
    if (!isdefined(level.var_2e9b3272)) {
        level.var_2e9b3272 = {};
        level.planemortarexhaustfx = "killstreaks/fx_ls_exhaust_afterburner";
        clientfield::register("scriptmover", "planemortar_contrail", 1, 1, "int", &planemortar_contrail, 0, 0);
    }
}

// Namespace planemortar/planemortar_shared
// Params 7, eflags: 0x0
// Checksum 0xa418ba88, Offset: 0x158
// Size: 0x9a
function planemortar_contrail(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self endon(#"death");
    util::waittill_dobj(localclientnum);
    if (newval) {
        self.fx = util::playfxontag(localclientnum, level.planemortarexhaustfx, self, "tag_fx");
    }
}

