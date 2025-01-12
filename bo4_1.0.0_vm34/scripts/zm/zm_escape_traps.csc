#using scripts\core_common\audio_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\postfx_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\zm_utility;

#namespace zm_escape_traps;

// Namespace zm_escape_traps/zm_escape_traps
// Params 0, eflags: 0x2
// Checksum 0xa9b529d4, Offset: 0x1a0
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"zm_escape_traps", &__init__, undefined, undefined);
}

// Namespace zm_escape_traps/zm_escape_traps
// Params 0, eflags: 0x0
// Checksum 0x7c4ba8f, Offset: 0x1e8
// Size: 0x37a
function __init__() {
    clientfield::register("actor", "fan_trap_blood_fx", 1, 1, "int", &fan_trap_blood_fx, 0, 0);
    clientfield::register("toplayer", "rumble_fan_trap", 1, 1, "int", &rumble_fan_trap, 0, 0);
    clientfield::register("actor", "acid_trap_death_fx", 1, 1, "int", &acid_trap_death_fx, 0, 0);
    clientfield::register("scriptmover", "acid_trap_fx", 1, 1, "int", &acid_trap_fx, 0, 0);
    clientfield::register("actor", "spinning_trap_blood_fx", 1, 1, "int", &spinning_trap_blood_fx, 0, 0);
    clientfield::register("toplayer", "rumble_spinning_trap", 1, 1, "int", &rumble_spinning_trap, 0, 0);
    clientfield::register("toplayer", "player_acid_trap_post_fx", 1, 1, "int", &player_acid_trap_post_fx, 0, 0);
    level._effect[#"animscript_gib_fx"] = #"zombie/fx_blood_torso_explo_zmb";
    level._effect[#"fan_blood"] = #"hash_45d61db7f0d94744";
    level._effect[#"fan_blood_head"] = #"hash_21e59a64eb02516a";
    level._effect[#"acid_spray"] = #"hash_3a65c86ea64668f5";
    level._effect[#"acid_spray_death"] = #"hash_78c487ac760f594c";
    level._effect[#"hash_294b19c300d1b482"] = #"hash_45008cc138e3bba3";
    level._effect[#"hash_4391e5c4b43c63c9"] = #"hash_215c779c48fd6856";
    level._effect[#"hash_5647f8e593893bce"] = #"hash_4d61168f93739083";
}

// Namespace zm_escape_traps/zm_escape_traps
// Params 7, eflags: 0x0
// Checksum 0x302fcb52, Offset: 0x570
// Size: 0x14e
function fan_trap_blood_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    if (newval == 1) {
        if (randomint(100) > 50) {
            self.n_fan_trap_blood_fx = util::playfxontag(localclientnum, level._effect[#"fan_blood_head"], self, "J_Neck");
        } else {
            self.n_fan_trap_blood_fx = util::playfxontag(localclientnum, level._effect[#"fan_blood"], self, "j_spinelower");
        }
        playsound(localclientnum, #"hash_5840ac12dd5f08cd", self.origin);
        return;
    }
    if (isdefined(self.n_fan_trap_blood_fx)) {
        stopfx(localclientnum, self.n_fan_trap_blood_fx);
        self.n_fan_trap_blood_fx = undefined;
    }
}

// Namespace zm_escape_traps/zm_escape_traps
// Params 7, eflags: 0x0
// Checksum 0x36a2dfec, Offset: 0x6c8
// Size: 0xde
function rumble_fan_trap(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    self endon(#"death");
    if (newval == 1) {
        self endon(#"hash_583695c3e21830e7");
        while (true) {
            if (isinarray(getlocalplayers(), self)) {
                self playrumbleonentity(localclientnum, "damage_light");
            }
            wait 0.25;
        }
        return;
    }
    self notify(#"hash_583695c3e21830e7");
}

// Namespace zm_escape_traps/zm_escape_traps
// Params 7, eflags: 0x0
// Checksum 0x654c8767, Offset: 0x7b0
// Size: 0x1ac
function acid_trap_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    if (newval == 1) {
        if (isdefined(self.var_d490083b)) {
            self.var_d490083b delete();
        }
        playsound(localclientnum, #"hash_68f3e5dbc3422363", self.origin);
        audio::playloopat("zmb_trap_acid_loop", self.origin);
        self.var_d490083b = util::playfxontag(localclientnum, level._effect[#"acid_spray"], self, "tag_origin");
        return;
    }
    playsound(localclientnum, #"hash_4da8231bc8767676", self.origin);
    audio::stoploopat("zmb_trap_acid_loop", self.origin);
    if (isdefined(self.var_d490083b)) {
        stopfx(localclientnum, self.var_d490083b);
        self.var_d490083b = undefined;
    }
    util::playfxontag(localclientnum, level._effect[#"acid_spray_death"], self, "tag_origin");
}

// Namespace zm_escape_traps/zm_escape_traps
// Params 7, eflags: 0x0
// Checksum 0xba04128a, Offset: 0x968
// Size: 0xee
function acid_trap_death_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    if (newval == 1) {
        self.n_acid_trap_death_fx = util::playfxontag(localclientnum, level._effect[#"hash_294b19c300d1b482"], self, "tag_stowed_back");
        playsound(localclientnum, #"hash_4d4c9f8ad239b61f", self.origin);
        return;
    }
    if (isdefined(self.n_acid_trap_death_fx)) {
        stopfx(localclientnum, self.n_acid_trap_death_fx);
        self.n_acid_trap_death_fx = undefined;
    }
}

// Namespace zm_escape_traps/zm_escape_traps
// Params 7, eflags: 0x0
// Checksum 0xf299e600, Offset: 0xa60
// Size: 0x1a6
function player_acid_trap_post_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    if (newval == 1) {
        if (isdemoplaying() && demoisanyfreemovecamera()) {
            return;
        }
        if (self != function_f97e7787(localclientnum)) {
            return;
        }
        self notify(#"player_acid_trap_post_fx_complete");
        self thread function_3b312589(localclientnum);
        self thread postfx::playpostfxbundle(#"pstfx_zm_acid_dmg");
        self.var_7853540b = playfxoncamera(localclientnum, level._effect[#"hash_4391e5c4b43c63c9"]);
        self playrenderoverridebundle(#"hash_6efc465a2da0373a");
        if (self zm_utility::function_a96d4c46(localclientnum)) {
            self.var_1ed61c04 = playviewmodelfx(localclientnum, level._effect[#"hash_5647f8e593893bce"], "j_wrist_ri");
        }
        return;
    }
    self notify(#"player_acid_trap_post_fx_complete");
}

// Namespace zm_escape_traps/zm_escape_traps
// Params 1, eflags: 0x0
// Checksum 0xb5d9df7, Offset: 0xc10
// Size: 0xf4
function function_3b312589(localclientnum) {
    self endon(#"disconnect", #"death");
    self waittill(#"player_acid_trap_post_fx_complete");
    if (isdefined(self)) {
        self postfx::exitpostfxbundle(#"pstfx_zm_acid_dmg");
        if (isdefined(self.var_7853540b)) {
            stopfx(localclientnum, self.var_7853540b);
            self.var_7853540b = undefined;
        }
        if (isdefined(self.var_1ed61c04)) {
            stopfx(localclientnum, self.var_1ed61c04);
            self.var_1ed61c04 = undefined;
        }
        self stoprenderoverridebundle(#"hash_6efc465a2da0373a");
    }
}

// Namespace zm_escape_traps/zm_escape_traps
// Params 7, eflags: 0x0
// Checksum 0x906454ff, Offset: 0xd10
// Size: 0x14e
function spinning_trap_blood_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    if (newval == 1) {
        if (randomint(100) > 50) {
            self.n_spinning_trap_blood_fx = util::playfxontag(localclientnum, level._effect[#"fan_blood_head"], self, "J_Neck");
        } else {
            self.n_spinning_trap_blood_fx = util::playfxontag(localclientnum, level._effect[#"fan_blood"], self, "j_spinelower");
        }
        playsound(localclientnum, #"hash_5840ac12dd5f08cd", self.origin);
        return;
    }
    if (isdefined(self.n_spinning_trap_blood_fx)) {
        stopfx(localclientnum, self.n_spinning_trap_blood_fx);
        self.n_spinning_trap_blood_fx = undefined;
    }
}

// Namespace zm_escape_traps/zm_escape_traps
// Params 7, eflags: 0x0
// Checksum 0xb877f41f, Offset: 0xe68
// Size: 0xde
function rumble_spinning_trap(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    self endon(#"death");
    if (newval == 1) {
        self endon(#"hash_6fb55d3438a8d5fa");
        while (true) {
            if (isinarray(getlocalplayers(), self)) {
                self playrumbleonentity(localclientnum, "damage_light");
            }
            wait 0.25;
        }
        return;
    }
    self notify(#"hash_6fb55d3438a8d5fa");
}

