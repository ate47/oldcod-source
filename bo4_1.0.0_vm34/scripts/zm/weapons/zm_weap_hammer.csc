#using scripts\core_common\clientfield_shared;
#using scripts\core_common\postfx_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm\zm_lightning_chain;
#using scripts\zm_common\zm_utility;

#namespace zm_weap_hammer;

// Namespace zm_weap_hammer/zm_weap_hammer
// Params 0, eflags: 0x2
// Checksum 0x529d8035, Offset: 0x1e0
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"zm_weap_hammer", &__init__, undefined, undefined);
}

// Namespace zm_weap_hammer/zm_weap_hammer
// Params 0, eflags: 0x0
// Checksum 0x42f4e38f, Offset: 0x228
// Size: 0x506
function __init__() {
    clientfield::register("allplayers", "lightning_bolt_fx", 1, 1, "counter", &function_d77f0192, 0, 0);
    clientfield::register("toplayer", "hero_hammer_armor_postfx", 1, 1, "counter", &function_f516f8a8, 0, 0);
    clientfield::register("scriptmover", "lightning_miss_fx", 1, 1, "int", &function_6a2c832a, 0, 0);
    clientfield::register("scriptmover", "hammer_storm", 1, 1, "int", &hammer_storm, 0, 0);
    clientfield::register("actor", "hero_hammer_melee_impact_trail", 1, 1, "counter", &function_e5f66356, 0, 0);
    clientfield::register("vehicle", "hero_hammer_melee_impact_trail", 1, 1, "counter", &function_e5f66356, 0, 0);
    clientfield::register("actor", "lightning_impact_fx", 1, 1, "int", &function_41819534, 0, 0);
    clientfield::register("vehicle", "lightning_impact_fx", 1, 1, "int", &function_41819534, 0, 0);
    clientfield::register("actor", "lightning_arc_fx", 1, 1, "int", &function_fb3ed342, 0, 0);
    clientfield::register("vehicle", "lightning_arc_fx", 1, 1, "int", &function_fb3ed342, 0, 0);
    clientfield::register("actor", "hero_hammer_stun", 1, 1, "int", &function_ab4b14f7, 0, 0);
    clientfield::register("vehicle", "hero_hammer_stun", 1, 1, "int", &function_ab4b14f7, 0, 0);
    clientfield::register("toplayer", "hammer_rumble", 1, 1, "counter", &hammer_rumble, 0, 0);
    level._effect[#"hammer_storm"] = #"hash_20c78a023629447a";
    level._effect[#"lightning_miss"] = #"hash_211c80023671737b";
    level._effect[#"lightning_arc"] = #"hash_5bf3f1914a8ad11f";
    level._effect[#"lightning_impact"] = #"hash_13721326cc2b0c0d";
    level._effect[#"hash_68b51e827d391590"] = #"hash_6a3c982733846cf1";
    level._effect[#"hash_68bc2a827d3f48a2"] = #"hash_6a3c982733846cf1";
    level._effect[#"hash_710d46f7ce760dda"] = #"hash_421d1bfc8c356db6";
    level.var_1d5f245c = [];
}

// Namespace zm_weap_hammer/zm_weap_hammer
// Params 7, eflags: 0x0
// Checksum 0x15305c10, Offset: 0x738
// Size: 0x5c
function function_d77f0192(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    thread lightning_bolt_fx(localclientnum, self, self.origin);
}

// Namespace zm_weap_hammer/zm_weap_hammer
// Params 3, eflags: 0x0
// Checksum 0x9c112110, Offset: 0x7a0
// Size: 0x104
function lightning_bolt_fx(localclientnum, owner, position) {
    if (self zm_utility::function_a96d4c46(localclientnum)) {
        fx = level._effect[#"groundhit_1p"];
        fwd = anglestoforward(owner.angles);
        playfx(localclientnum, fx, position + fwd * 100, fwd);
        return;
    }
    fx = level._effect[#"groundhit_3p"];
    fwd = anglestoforward(owner.angles);
    playfx(localclientnum, fx, position, fwd);
}

// Namespace zm_weap_hammer/zm_weap_hammer
// Params 7, eflags: 0x0
// Checksum 0x9bf4f307, Offset: 0x8b0
// Size: 0x84
function function_e5f66356(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    util::playfxontag(localclientnum, level._effect[#"hash_710d46f7ce760dda"], self, self zm_utility::function_a7776589());
}

// Namespace zm_weap_hammer/zm_weap_hammer
// Params 7, eflags: 0x0
// Checksum 0x867de18d, Offset: 0x940
// Size: 0x1a6
function hammer_storm(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        if (isdefined(self.n_beacon_fx)) {
            deletefx(localclientnum, self.n_beacon_fx, 1);
        }
        self.n_beacon_fx = util::playfxontag(localclientnum, level._effect[#"hammer_storm"], self, "tag_origin");
        if (!isdefined(self.var_9ea6acc)) {
            self.var_9ea6acc = self playloopsound(#"hash_1fc7648098c65e92");
            self thread function_63ca487d(localclientnum);
        }
        return;
    }
    if (isdefined(self.n_beacon_fx)) {
        deletefx(localclientnum, self.n_beacon_fx, 0);
        self.n_beacon_fx = undefined;
    }
    self playsound(0, #"hash_15633b83c64a3ebb");
    if (isdefined(self.var_9ea6acc)) {
        self notify(#"hash_5384bc96a8e66d91");
        self stoploopsound(self.var_9ea6acc);
        self.var_9ea6acc = undefined;
    }
}

// Namespace zm_weap_hammer/zm_weap_hammer
// Params 1, eflags: 0x0
// Checksum 0x52746cff, Offset: 0xaf0
// Size: 0x78
function function_63ca487d(localclientnum) {
    self endon(#"hash_5384bc96a8e66d91");
    self endon(#"death");
    while (isdefined(self)) {
        self playsound(0, "wpn_hammer_storm_bolt");
        wait randomfloatrange(0.2, 0.8);
    }
}

// Namespace zm_weap_hammer/zm_weap_hammer
// Params 7, eflags: 0x0
// Checksum 0xe69428c0, Offset: 0xb70
// Size: 0xac
function function_41819534(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    if (newval) {
        util::playfxontag(localclientnum, level._effect[#"lightning_impact"], self, self zm_utility::function_a7776589());
        self playsound(0, #"hash_63d588d1f28ecdc1");
    }
}

// Namespace zm_weap_hammer/zm_weap_hammer
// Params 7, eflags: 0x0
// Checksum 0xbeca47c5, Offset: 0xc28
// Size: 0x100
function function_6a2c832a(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    if (newval) {
        util::playfxontag(localclientnum, level._effect[#"lightning_miss"], self, "tag_origin");
        level.var_1d5f245c[localclientnum] = self;
        ent = spawn(0, self.origin, "script_origin");
        ent linkto(self);
        self thread function_80209369(localclientnum, ent);
        level notify(#"lightning_ball_created");
    }
}

// Namespace zm_weap_hammer/zm_weap_hammer
// Params 2, eflags: 0x0
// Checksum 0x5e0aa05f, Offset: 0xd30
// Size: 0x4c
function function_80209369(localclientnum, ent) {
    self waittill(#"death");
    ent delete();
    level.var_1d5f245c[localclientnum] = undefined;
}

// Namespace zm_weap_hammer/zm_weap_hammer
// Params 1, eflags: 0x0
// Checksum 0x9577ab5c, Offset: 0xd88
// Size: 0x2a0
function function_749acb79(localclientnum) {
    self endon(#"death", #"hash_5531647ca0352039");
    if (!isdefined(level.var_1d5f245c[localclientnum])) {
        level waittill(#"lightning_ball_created");
        level.var_1d5f245c[localclientnum] util::waittill_dobj(localclientnum);
    }
    e_ball = level.var_1d5f245c[localclientnum];
    e_ball endon(#"death");
    util::server_wait(localclientnum, randomfloatrange(0.05, 0.1));
    if (!isdefined(e_ball)) {
        return;
    }
    self.e_fx = spawn(localclientnum, e_ball.origin, "script_model");
    self.e_fx setmodel(#"tag_origin");
    self.fx_arc = util::playfxontag(localclientnum, level._effect[#"lightning_arc"], self.e_fx, "tag_origin");
    while (true) {
        var_ec8ff93 = self gettagorigin(self zm_utility::function_a7776589());
        if (isdefined(var_ec8ff93)) {
            self.e_fx moveto(var_ec8ff93, 0.1);
        } else {
            self.e_fx moveto(self.origin, 0.1);
        }
        util::server_wait(localclientnum, 0.1);
        if (!isdefined(e_ball)) {
            return;
        }
        self.e_fx moveto(e_ball.origin, 0.1);
        util::server_wait(localclientnum, 0.1);
    }
}

// Namespace zm_weap_hammer/zm_weap_hammer
// Params 7, eflags: 0x0
// Checksum 0xdb16d984, Offset: 0x1030
// Size: 0xde
function function_fb3ed342(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    if (newval) {
        self function_749acb79(localclientnum);
        return;
    }
    self notify(#"hash_5531647ca0352039");
    if (isdefined(self.fx_arc)) {
        stopfx(localclientnum, self.fx_arc);
        self.fx_arc = undefined;
    }
    if (isdefined(self.e_fx)) {
        self.e_fx delete();
        self.e_fx = undefined;
    }
}

// Namespace zm_weap_hammer/zm_weap_hammer
// Params 7, eflags: 0x4
// Checksum 0xc40c692c, Offset: 0x1118
// Size: 0x64
function private function_f516f8a8(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
    if (newvalue) {
        self thread postfx::playpostfxbundle(#"hash_74fd0cf7c91d14d0");
    }
}

// Namespace zm_weap_hammer/zm_weap_hammer
// Params 7, eflags: 0x0
// Checksum 0x5e3ca610, Offset: 0x1188
// Size: 0x106
function function_ab4b14f7(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        if (!isdefined(self.var_3d170f9e)) {
            self.var_3d170f9e = util::playfxontag(localclientnum, level._effect[#"lightning_impact"], self, self zm_utility::function_a7776589());
        }
        self playsound(localclientnum, #"hash_63d588d1f28ecdc1");
        return;
    }
    if (isdefined(self.var_3d170f9e)) {
        deletefx(localclientnum, self.var_3d170f9e, 1);
    }
    self.var_3d170f9e = undefined;
}

// Namespace zm_weap_hammer/zm_weap_hammer
// Params 7, eflags: 0x0
// Checksum 0x793106fe, Offset: 0x1298
// Size: 0x8a
function hammer_rumble(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
    if (newvalue) {
        switch (newvalue) {
        case 4:
            self playrumbleonentity(localclientnum, "zm_weap_hammer_swipe_hit_rumble");
            break;
        }
    }
}

