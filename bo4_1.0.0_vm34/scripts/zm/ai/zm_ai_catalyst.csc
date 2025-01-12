#using scripts\core_common\ai\systems\fx_character;
#using scripts\core_common\ai_shared;
#using scripts\core_common\animation_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\postfx_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\zm_transformation;

#namespace zm_ai_catalyst;

// Namespace zm_ai_catalyst/zm_ai_catalyst
// Params 0, eflags: 0x2
// Checksum 0x190f6ae1, Offset: 0x3e0
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"zm_ai_catalyst", &__init__, undefined, undefined);
}

// Namespace zm_ai_catalyst/zm_ai_catalyst
// Params 0, eflags: 0x4
// Checksum 0x8d914134, Offset: 0x428
// Size: 0x1bc
function private __init__() {
    if (!isarchetypeloaded("catalyst")) {
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
    function_10c02df5();
    ai::add_archetype_spawn_function("catalyst", &function_7556ceb8);
}

// Namespace zm_ai_catalyst/zm_ai_catalyst
// Params 0, eflags: 0x0
// Checksum 0xed4dc8f, Offset: 0x5f0
// Size: 0x1fc
function function_10c02df5() {
    clientfield::register("actor", "catalyst_aura_clientfield", 1, 3, "int", &function_f25d7781, 0, 0);
    clientfield::register("actor", "catalyst_damage_explosion_clientfield", 1, 1, "counter", &function_5422f67a, 0, 0);
    clientfield::register("actor", "corrosive_miasma_clientfield", 1, 1, "int", &function_40f747de, 0, 0);
    clientfield::register("actor", "water_catalyst_purified", 1, 1, "int", &function_773f9a60, 0, 0);
    clientfield::register("actor", "electricity_catalyst_blast", 1, 1, "int", &function_44a59c9f, 0, 0);
    clientfield::register("actor", "plasma_catalyst_blast", 1, 1, "int", &function_d55577c2, 0, 0);
    clientfield::register("actor", "corrosive_death_clientfield", 1, 1, "int", &function_13aff33e, 0, 0);
}

// Namespace zm_ai_catalyst/zm_ai_catalyst
// Params 7, eflags: 0x4
// Checksum 0xd0e8e4bb, Offset: 0x7f8
// Size: 0x114
function private function_f25d7781(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
    self util::waittill_dobj(localclientnum);
    switch (newvalue) {
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
    }
    fxclientutils::playfxbundle(localclientnum, self, self.fxdef);
}

// Namespace zm_ai_catalyst/zm_ai_catalyst
// Params 7, eflags: 0x4
// Checksum 0x5e3df5b, Offset: 0x918
// Size: 0x9c
function private function_5422f67a(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
    util::playfxontag(localclientnum, level._effect[#"fx8_aat_opposite_exp"], self, "j_spine4");
    playsound(0, #"hash_7d7c027e3b78c5b6", self.origin);
}

// Namespace zm_ai_catalyst/zm_ai_catalyst
// Params 7, eflags: 0x4
// Checksum 0x190558f5, Offset: 0x9c0
// Size: 0x194
function private function_40f747de(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, wasdemojump) {
    if (newval) {
        self.var_a7a89aad = util::playfxontag(localclientnum, level._effect[#"fx8_cata_cor_aura"], self, "j_spine4");
        self.var_464cc6c3 = util::playfxontag(localclientnum, level._effect[#"fx8_cata_cor_aura_locked"], self, "tag_origin");
        if (!isdefined(self.var_e388c4a4)) {
            self.var_e388c4a4 = self playloopsound("zmb_ai_catalyst_corrosive_lp");
        }
        return;
    }
    if (isdefined(self.var_a7a89aad)) {
        stopfx(localclientnum, self.var_a7a89aad);
        self.var_a7a89aad = undefined;
    }
    if (isdefined(self.var_464cc6c3)) {
        stopfx(localclientnum, self.var_464cc6c3);
        self.var_464cc6c3 = undefined;
    }
    if (isdefined(self.var_e388c4a4)) {
        self stoploopsound(self.var_e388c4a4);
    }
}

// Namespace zm_ai_catalyst/zm_ai_catalyst
// Params 1, eflags: 0x4
// Checksum 0x121c8194, Offset: 0xb60
// Size: 0x54
function private function_13baf378(spawn_sfx) {
    self endon(#"death");
    self endon(#"disconnect");
    wait 0.25;
    self playsound(0, spawn_sfx);
}

// Namespace zm_ai_catalyst/zm_ai_catalyst
// Params 7, eflags: 0x4
// Checksum 0x1be087cf, Offset: 0xbc0
// Size: 0x236
function private function_773f9a60(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
    if (newvalue === 1) {
        self.var_f66e447b = util::playfxontag(localclientnum, level._effect[#"fx8_cata_water_purify"], self, "tag_eye");
        if (!isdefined(self.var_2f82be5a)) {
            self playsound(localclientnum, #"hash_56157e961854c964");
            self.var_2f82be5a = self playloopsound(#"hash_4d16df16d08f6404");
        }
        self function_c20b6c81("rob_zm_eyes_red", "j_head");
        self playrenderoverridebundle("rob_zm_eyes_blue", "j_head");
        return;
    }
    if (isdefined(self.var_f66e447b)) {
        stopfx(localclientnum, self.var_f66e447b);
        self.var_f66e447b = undefined;
        self stoprenderoverridebundle("rob_zm_eyes_blue", "j_head");
        if (isalive(self)) {
            self playrenderoverridebundle("rob_zm_eyes_red", "j_head");
        }
    }
    if (isdefined(self.var_2f82be5a)) {
        self playsound(localclientnum, #"hash_58e6fac48dd8515d");
        self stoploopsound(self.var_2f82be5a);
        self.var_2f82be5a = undefined;
    }
}

// Namespace zm_ai_catalyst/zm_ai_catalyst
// Params 7, eflags: 0x4
// Checksum 0xd657b9b1, Offset: 0xe00
// Size: 0xd6
function private function_44a59c9f(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
    if (newvalue === 1) {
        self playsound(localclientnum, #"hash_579a9e520b10d768");
        self thread function_373809ab(localclientnum);
        return;
    }
    if (isdefined(self.var_c3f55a86)) {
        stopfx(localclientnum, self.var_c3f55a86);
        self.var_c3f55a86 = undefined;
        self notify(#"scream_attack_done");
    }
}

// Namespace zm_ai_catalyst/zm_ai_catalyst
// Params 1, eflags: 0x4
// Checksum 0x920adf5f, Offset: 0xee0
// Size: 0x134
function private function_373809ab(localclientnum) {
    self notify(#"hash_28942d030dbe705");
    self endon(#"hash_28942d030dbe705");
    if (isdefined(self.var_ce46188c)) {
        self.var_ce46188c delete();
    }
    str_tag = "tag_eye";
    v_origin = self gettagorigin(str_tag);
    self.var_4a2b908f = util::spawn_model(localclientnum, "tag_origin", v_origin, self.angles);
    util::playfxontag(localclientnum, level._effect[#"fx8_cata_elec_blast"], self.var_4a2b908f, "tag_origin");
    self waittill(#"death", #"scream_attack_done");
    self.var_4a2b908f delete();
}

// Namespace zm_ai_catalyst/zm_ai_catalyst
// Params 7, eflags: 0x4
// Checksum 0xc8c52219, Offset: 0x1020
// Size: 0xc4
function private function_d55577c2(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
    util::playfxontag(localclientnum, level._effect[#"fx8_cata_plasma_blast"], self, "j_spine4");
    playsound(0, #"hash_7d7c027e3b78c5b6", self.origin);
    function_e4a51e70(localclientnum, #"hash_528115ad9eebc84f", self.origin);
}

// Namespace zm_ai_catalyst/zm_ai_catalyst
// Params 7, eflags: 0x4
// Checksum 0x2ca59e28, Offset: 0x10f0
// Size: 0xf4
function private function_13aff33e(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
    if (newvalue) {
        animname = self getprimarydeltaanim();
        if (!isdefined(animname)) {
            animname = "ai_t8_zm_zod_catalyst_corrosive_death_01";
        }
        script_model = util::spawn_anim_model(localclientnum, "c_t8_zmb_catalyst_decay_body_noreveal", self gettagorigin("j_mainroot"), self.angles);
        script_model attach("c_t8_zmb_catalyst_decay_head_noreveal");
        script_model thread function_cc27d732(animname);
    }
}

// Namespace zm_ai_catalyst/zm_ai_catalyst
// Params 1, eflags: 0x4
// Checksum 0xb1525303, Offset: 0x11f0
// Size: 0x11c
function private function_cc27d732(animname) {
    self endon(#"death");
    var_d238b4b = animname + "_scale";
    animlength = int(getanimlength(var_d238b4b) * 1000);
    starttime = gettime();
    endtime = starttime + animlength;
    self thread animation::play(var_d238b4b);
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
// Params 1, eflags: 0x4
// Checksum 0xe057555e, Offset: 0x1318
// Size: 0x22
function private function_7556ceb8(localclientnum) {
    self.var_d7aceec1 = #"hash_10bdf06ea5640d49";
}

