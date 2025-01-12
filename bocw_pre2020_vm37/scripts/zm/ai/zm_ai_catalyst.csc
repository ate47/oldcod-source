#using scripts\core_common\ai\systems\fx_character;
#using scripts\core_common\ai_shared;
#using scripts\core_common\animation_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\zm_transformation;

#namespace zm_ai_catalyst;

// Namespace zm_ai_catalyst/zm_ai_catalyst
// Params 0, eflags: 0x6
// Checksum 0xfdc86d95, Offset: 0x428
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"zm_ai_catalyst", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace zm_ai_catalyst/zm_ai_catalyst
// Params 0, eflags: 0x5 linked
// Checksum 0x6bd994ad, Offset: 0x470
// Size: 0x184
function private function_70a657d8() {
    if (!isarchetypeloaded(#"catalyst")) {
        return;
    }
    level._effect[#"fx8_aat_opposite_exp"] = "zm_weapons/fx8_aat_opposite_exp";
    level._effect[#"fx8_cata_cor_aura"] = "zm_ai/fx8_cata_cor_aura";
    level._effect[#"fx8_cata_cor_aura_locked"] = "zm_ai/fx8_cata_cor_aura_locked";
    level._effect[#"fx8_cata_water_purify"] = "zm_ai/fx8_cata_water_purify";
    level._effect[#"fx8_cata_elec_blast"] = "zm_ai/fx8_cata_elec_blast";
    level._effect[#"fx8_cata_elec_blast"] = "zm_ai/fx8_cata_elec_blast";
    level._effect[#"fx8_cata_plasma_blast"] = "zm_ai/fx8_cata_plasma_blast";
    level._effect[#"fx8_cata_plasma_blast_tell_head"] = "zm_ai/fx8_cata_plasma_blast_tell_head";
    level._effect[#"fx8_cata_plasma_blast_tell_torso"] = "zm_ai/fx8_cata_plasma_blast_tell_torso";
    function_b6fd8c68();
    ai::add_archetype_spawn_function(#"catalyst", &function_5608540a);
}

// Namespace zm_ai_catalyst/zm_ai_catalyst
// Params 0, eflags: 0x1 linked
// Checksum 0x402e30ff, Offset: 0x600
// Size: 0x1fc
function function_b6fd8c68() {
    clientfield::register("actor", "catalyst_aura_clientfield", 1, 3, "int", &function_213aaacc, 0, 0);
    clientfield::register("actor", "catalyst_damage_explosion_clientfield", 1, 1, "counter", &function_b3c2dc1c, 0, 0);
    clientfield::register("actor", "corrosive_miasma_clientfield", 1, 1, "int", &function_8cc5be3b, 0, 0);
    clientfield::register("actor", "water_catalyst_purified", 1, 1, "int", &function_72d9d9e7, 0, 0);
    clientfield::register("actor", "electricity_catalyst_blast", 1, 1, "int", &function_dce55f49, 0, 0);
    clientfield::register("actor", "plasma_catalyst_blast", 1, 1, "int", &function_1578a764, 0, 0);
    clientfield::register("actor", "corrosive_death_clientfield", 1, 1, "int", &function_5c22755, 0, 0);
}

// Namespace zm_ai_catalyst/zm_ai_catalyst
// Params 7, eflags: 0x5 linked
// Checksum 0x23292d1c, Offset: 0x808
// Size: 0x14c
function private function_213aaacc(localclientnum, *oldvalue, newvalue, *bnewent, *binitialsnap, *fieldname, *wasdemojump) {
    self util::waittill_dobj(fieldname);
    switch (wasdemojump) {
    case 1:
        spawn_sfx = "zmb_ai_catalyst_corrosive_spawn";
        break;
    case 4:
        spawn_sfx = "zmb_ai_catalyst_water_spawn";
        break;
    case 3:
        spawn_sfx = "zmb_ai_catalyst_electric_spawn";
        break;
    case 2:
        spawn_sfx = "zmb_ai_catalyst_plasma_spawn";
        break;
    default:
        fxclientutils::function_ae92446(fieldname, self, self.fxdef);
        return;
    }
    if (isdefined(self)) {
        fxclientutils::playfxbundle(fieldname, self, self.fxdef);
    }
}

// Namespace zm_ai_catalyst/zm_ai_catalyst
// Params 7, eflags: 0x5 linked
// Checksum 0x63fc3f49, Offset: 0x960
// Size: 0x9c
function private function_b3c2dc1c(localclientnum, *oldvalue, *newvalue, *bnewent, *binitialsnap, *fieldname, *wasdemojump) {
    util::playfxontag(wasdemojump, level._effect[#"fx8_aat_opposite_exp"], self, "j_spine4");
    playsound(0, #"hash_7d7c027e3b78c5b6", self.origin);
}

// Namespace zm_ai_catalyst/zm_ai_catalyst
// Params 7, eflags: 0x5 linked
// Checksum 0x32968031, Offset: 0xa08
// Size: 0x194
function private function_8cc5be3b(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *wasdemojump) {
    if (wasdemojump) {
        self.var_565b4840 = util::playfxontag(fieldname, level._effect[#"fx8_cata_cor_aura"], self, "j_spine4");
        self.var_430cfa87 = util::playfxontag(fieldname, level._effect[#"fx8_cata_cor_aura_locked"], self, "tag_origin");
        if (!isdefined(self.var_8c3a51be)) {
            self.var_8c3a51be = self playloopsound("zmb_ai_catalyst_corrosive_lp");
        }
        return;
    }
    if (isdefined(self.var_565b4840)) {
        stopfx(fieldname, self.var_565b4840);
        self.var_565b4840 = undefined;
    }
    if (isdefined(self.var_430cfa87)) {
        stopfx(fieldname, self.var_430cfa87);
        self.var_430cfa87 = undefined;
    }
    if (isdefined(self.var_8c3a51be)) {
        self stoploopsound(self.var_8c3a51be);
    }
}

// Namespace zm_ai_catalyst/zm_ai_catalyst
// Params 7, eflags: 0x5 linked
// Checksum 0x2911e476, Offset: 0xba8
// Size: 0x186
function private function_72d9d9e7(localclientnum, *oldvalue, newvalue, *bnewent, *binitialsnap, *fieldname, *wasdemojump) {
    if (wasdemojump === 1) {
        self.var_5fe1f99b = util::playfxontag(fieldname, level._effect[#"fx8_cata_water_purify"], self, "tag_eye");
        if (!isdefined(self.var_983b7af9)) {
            self playsound(fieldname, #"hash_56157e961854c964");
            self.var_983b7af9 = self playloopsound(#"hash_4d16df16d08f6404");
        }
        return;
    }
    if (isdefined(self.var_5fe1f99b)) {
        stopfx(fieldname, self.var_5fe1f99b);
        self.var_5fe1f99b = undefined;
    }
    if (isdefined(self.var_983b7af9)) {
        self playsound(fieldname, #"hash_58e6fac48dd8515d");
        self stoploopsound(self.var_983b7af9);
        self.var_983b7af9 = undefined;
    }
}

// Namespace zm_ai_catalyst/zm_ai_catalyst
// Params 7, eflags: 0x5 linked
// Checksum 0x1f1054c0, Offset: 0xd38
// Size: 0xd6
function private function_dce55f49(localclientnum, *oldvalue, newvalue, *bnewent, *binitialsnap, *fieldname, *wasdemojump) {
    if (wasdemojump === 1) {
        self playsound(fieldname, #"hash_579a9e520b10d768");
        self thread function_8c78e227(fieldname);
        return;
    }
    if (isdefined(self.var_5e3f0a3c)) {
        stopfx(fieldname, self.var_5e3f0a3c);
        self.var_5e3f0a3c = undefined;
        self notify(#"scream_attack_done");
    }
}

// Namespace zm_ai_catalyst/zm_ai_catalyst
// Params 1, eflags: 0x5 linked
// Checksum 0x3c344ed6, Offset: 0xe18
// Size: 0x13c
function private function_8c78e227(localclientnum) {
    self notify(#"hash_28942d030dbe705");
    self endon(#"hash_28942d030dbe705");
    if (isdefined(self.var_c1e13a67)) {
        self.var_c1e13a67 delete();
    }
    str_tag = "tag_eye";
    v_origin = self gettagorigin(str_tag);
    self.var_c1e13a67 = util::spawn_model(localclientnum, "tag_origin", v_origin, self.angles);
    self.var_5e3f0a3c = util::playfxontag(localclientnum, level._effect[#"fx8_cata_elec_blast"], self.var_c1e13a67, "tag_origin");
    self waittill(#"death", #"scream_attack_done");
    self.var_c1e13a67 delete();
}

// Namespace zm_ai_catalyst/zm_ai_catalyst
// Params 7, eflags: 0x5 linked
// Checksum 0x4f0d21b2, Offset: 0xf60
// Size: 0xc4
function private function_1578a764(localclientnum, *oldvalue, *newvalue, *bnewent, *binitialsnap, *fieldname, *wasdemojump) {
    util::playfxontag(wasdemojump, level._effect[#"fx8_cata_plasma_blast"], self, "j_spine4");
    playsound(0, #"hash_7d7c027e3b78c5b6", self.origin);
    function_2a9101fe(wasdemojump, #"hash_528115ad9eebc84f", self.origin);
}

// Namespace zm_ai_catalyst/zm_ai_catalyst
// Params 7, eflags: 0x5 linked
// Checksum 0xb06b759, Offset: 0x1030
// Size: 0x15c
function private function_5c22755(localclientnum, *oldvalue, newvalue, *bnewent, *binitialsnap, *fieldname, *wasdemojump) {
    self util::waittill_dobj(fieldname);
    if (wasdemojump && isdefined(self) && self.var_9fde8624 === #"catalyst_corrosive") {
        animname = self getprimarydeltaanim();
        if (!isdefined(animname) || animname != "ai_t8_zm_zod_catalyst_corrosive_death_01" && animname != "ai_t8_zm_zod_catalyst_corrosive_death_02") {
            animname = "ai_t8_zm_zod_catalyst_corrosive_death_01";
        }
        script_model = util::spawn_anim_model(fieldname, "c_t8_zmb_catalyst_decay_body_noreveal", self gettagorigin("j_mainroot"), self.angles);
        if (isdefined(script_model)) {
            script_model attach("c_t8_zmb_catalyst_decay_head_noreveal");
            script_model thread function_ce9e3dc7(animname);
        }
    }
}

// Namespace zm_ai_catalyst/zm_ai_catalyst
// Params 1, eflags: 0x5 linked
// Checksum 0x9451b031, Offset: 0x1198
// Size: 0x124
function private function_ce9e3dc7(animname) {
    self endon(#"death");
    var_1d3061ce = animname + "_scale";
    animlength = int(getanimlength(var_1d3061ce) * 1000);
    if (animlength <= 0) {
        return;
    }
    starttime = gettime();
    endtime = starttime + animlength;
    self thread animation::play(var_1d3061ce);
    while (endtime > gettime()) {
        scale = 1 - (gettime() - starttime) / animlength;
        if (scale > 0) {
            self setscale(scale);
        }
        waitframe(1);
    }
    self delete();
}

// Namespace zm_ai_catalyst/zm_ai_catalyst
// Params 1, eflags: 0x5 linked
// Checksum 0xbf441f08, Offset: 0x12c8
// Size: 0x3a
function private function_5608540a(*localclientnum) {
    self enableonradar();
    self.var_fab3cf78 = #"hash_10bdf06ea5640d49";
}

