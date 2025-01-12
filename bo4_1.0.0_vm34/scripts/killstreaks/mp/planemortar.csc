#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\killstreaks\planemortar_shared;

#namespace planemortar;

// Namespace planemortar/planemortar
// Params 0, eflags: 0x2
// Checksum 0x503950de, Offset: 0xe0
// Size: 0x44
function autoexec __init__system__() {
    system::register(#"planemortar", &__init__, undefined, #"killstreaks");
}

// Namespace planemortar/planemortar
// Params 0, eflags: 0x0
// Checksum 0xb5e4f690, Offset: 0x130
// Size: 0x6c
function __init__() {
    init_shared();
    level.planemortarexhaustfx = "killstreaks/fx_ls_exhaust_afterburner";
    clientfield::register("scriptmover", "planemortar_contrail", 1, 1, "int", &planemortar_contrail, 0, 0);
}

// Namespace planemortar/planemortar
// Params 7, eflags: 0x0
// Checksum 0x363c6c65, Offset: 0x1a8
// Size: 0x9a
function planemortar_contrail(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self endon(#"death");
    util::waittill_dobj(localclientnum);
    if (newval) {
        self.fx = util::playfxontag(localclientnum, level.planemortarexhaustfx, self, "tag_fx");
    }
}

