#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\killstreaks\planemortar_shared;

#namespace planemortar;

// Namespace planemortar/planemortar
// Params 0, eflags: 0x6
// Checksum 0x9625bd8f, Offset: 0x120
// Size: 0x44
function private autoexec __init__system__() {
    system::register(#"planemortar", &function_70a657d8, undefined, undefined, #"killstreaks");
}

// Namespace planemortar/planemortar
// Params 0, eflags: 0x5 linked
// Checksum 0xd60b2426, Offset: 0x170
// Size: 0xa4
function private function_70a657d8() {
    init_shared();
    clientfield::register("scriptmover", "planemortar_contrail", 1, 1, "int", &planemortar_contrail, 0, 0);
    clientfield::register("scriptmover", "planemortar_marker_on", 1, 1, "int", &planemortar_marker_on, 0, 0);
}

// Namespace planemortar/planemortar
// Params 7, eflags: 0x1 linked
// Checksum 0x15deb37a, Offset: 0x220
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

// Namespace planemortar/planemortar
// Params 7, eflags: 0x1 linked
// Checksum 0x1bbef574, Offset: 0x320
// Size: 0xa4
function planemortar_marker_on(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    if (bwastimejump) {
        self.marker_fx = util::playfxontag(fieldname, "zm_zc2/killstreaks/fx8_air_drop_marker_gold", self, "tag_origin");
        return;
    }
    if (isdefined(self.marker_fx)) {
        stopfx(fieldname, self.marker_fx);
    }
}

