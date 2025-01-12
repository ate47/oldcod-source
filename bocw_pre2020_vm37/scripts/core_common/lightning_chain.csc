#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace lightning_chain;

// Namespace lightning_chain/lightning_chain
// Params 0, eflags: 0x6
// Checksum 0x8be812cf, Offset: 0x108
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"lightning_chain", &init, undefined, undefined, undefined);
}

// Namespace lightning_chain/lightning_chain
// Params 0, eflags: 0x1 linked
// Checksum 0xb11049b, Offset: 0x150
// Size: 0x124
function init() {
    clientfield::register("actor", "lc_fx", 1, 2, "int", &lc_shock_fx, 0, 1);
    clientfield::register("vehicle", "lc_fx", 1, 2, "int", &lc_shock_fx, 0, 0);
    clientfield::register("actor", "lc_death_fx", 1, 2, "int", &lc_play_death_fx, 0, 0);
    clientfield::register("vehicle", "lc_death_fx", 1, 2, "int", &lc_play_death_fx, 0, 0);
}

// Namespace lightning_chain/lightning_chain
// Params 7, eflags: 0x1 linked
// Checksum 0x2d4ec6cd, Offset: 0x280
// Size: 0x1c6
function lc_shock_fx(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    self endon(#"death");
    self util::waittill_dobj(fieldname);
    if (bwastimejump) {
        if (!isdefined(self.lc_shock_fx)) {
            str_tag = "J_SpineUpper";
            str_fx = "zm_ai/fx8_elec_shock";
            if (!self isai()) {
                str_tag = "tag_origin";
            }
            if (bwastimejump > 1) {
                str_fx = "zm_ai/fx8_elec_bolt";
            }
            self.lc_shock_fx = util::playfxontag(fieldname, str_fx, self, str_tag);
            if (!isdefined(self.var_b3a6c3f7)) {
                self.var_b3a6c3f7 = self playloopsound(#"hash_536f193a75e9cec9", 1);
            }
            self playsound(0, #"hash_63d588d1f28ecdc1");
        }
        return;
    }
    if (isdefined(self.lc_shock_fx)) {
        stopfx(fieldname, self.lc_shock_fx);
        self.lc_shock_fx = undefined;
    }
    if (isdefined(self.var_b3a6c3f7)) {
        self stoploopsound(self.var_b3a6c3f7);
        self.var_b3a6c3f7 = undefined;
    }
}

// Namespace lightning_chain/lightning_chain
// Params 7, eflags: 0x1 linked
// Checksum 0x98182d17, Offset: 0x450
// Size: 0xca
function lc_play_death_fx(localclientnum, *oldval, *newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    self endon(#"death");
    self util::waittill_dobj(bwastimejump);
    str_tag = "J_SpineUpper";
    if (is_true(self.isdog)) {
        str_tag = "J_Spine1";
    }
    if (self.archetype !== #"zombie") {
        tag = "tag_origin";
    }
}

