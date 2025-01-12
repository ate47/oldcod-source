#using script_1d96ce237e3b4068;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\util_shared;

#namespace planemortar;

// Namespace planemortar/planemortar_shared
// Params 0, eflags: 0x1 linked
// Checksum 0xb6fa7ae5, Offset: 0xe8
// Size: 0xb4
function init_shared() {
    if (!isdefined(level.var_6ea2bb2e)) {
        level.var_6ea2bb2e = {};
        clientfield::register("scriptmover", "planemortar_contrail", 1, 1, "int", &planemortar_contrail, 0, 0);
        clientfield::register_clientuimodel("hudItems.planeMortarShotsRemaining", #"hash_6f4b11a0bee9b73d", #"hash_569b707ceee60e2b", 1, 2, "int", undefined, 0, 0);
    }
}

// Namespace planemortar/planemortar_shared
// Params 7, eflags: 0x1 linked
// Checksum 0xee373ab3, Offset: 0x1a8
// Size: 0xf2
function planemortar_contrail(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    self endon(#"death");
    params = getscriptbundle("killstreak_planemortar");
    util::waittill_dobj(fieldname);
    if (bwastimejump) {
        self.fx = util::playfxontag(fieldname, params.var_dcbb40c5, self, params.var_d678978c);
        self.fx = util::playfxontag(fieldname, params.var_2375a152, self, params.var_e5082065);
    }
}

