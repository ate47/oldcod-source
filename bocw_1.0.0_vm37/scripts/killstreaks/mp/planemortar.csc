#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\killstreaks\planemortar_shared;

#namespace planemortar;

// Namespace planemortar/planemortar
// Params 0, eflags: 0x6
// Checksum 0x3a2af856, Offset: 0xc8
// Size: 0x44
function private autoexec __init__system__() {
    system::register(#"planemortar", &preinit, undefined, undefined, #"killstreaks");
}

// Namespace planemortar/planemortar
// Params 0, eflags: 0x4
// Checksum 0xf1af055f, Offset: 0x118
// Size: 0x5c
function private preinit() {
    init_shared();
    clientfield::register("scriptmover", "planemortar_contrail", 1, 1, "int", &planemortar_contrail, 0, 0);
}

// Namespace planemortar/planemortar
// Params 7, eflags: 0x0
// Checksum 0x4be62c83, Offset: 0x180
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

