#using scripts\core_common\clientfield_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\zm_utility;

#namespace zm_silver_ww_quest;

// Namespace zm_silver_ww_quest/zm_silver_ww_quest
// Params 0, eflags: 0x1 linked
// Checksum 0x8938987d, Offset: 0x120
// Size: 0x294
function init() {
    clientfield::register("scriptmover", "" + #"hash_3654e70518cd9bb5", 1, 1, "int", &function_216c11c7, 0, 0);
    clientfield::register("scriptmover", "" + #"hash_7159facf785aad53", 1, 1, "int", &function_7bceb311, 0, 0);
    clientfield::register("toplayer", "" + #"hash_864ef374ea11ea7", 1, 1, "int", &function_37ba0961, 0, 0);
    clientfield::register("scriptmover", "" + #"hash_3fc8d4cd56e4e9b0", 1, 1, "int", &function_198e136e, 0, 0);
    clientfield::register("scriptmover", "" + #"hash_18f64f139f905f76", 1, 1, "int", &function_f875612b, 0, 0);
    clientfield::register("scriptmover", "crystal_energy_fx", 1, 1, "int", &crystal_energy_fx, 0, 0);
    clientfield::register("allplayers", "ww_vacuum_crystal_fx", 1, 1, "int", &ww_vacuum_crystal_fx, 0, 0);
    clientfield::register("allplayers", "hold_crystal_energy", 1, 1, "int", &hold_crystal_energy, 0, 0);
}

// Namespace zm_silver_ww_quest/zm_silver_ww_quest
// Params 7, eflags: 0x1 linked
// Checksum 0x38abc4d6, Offset: 0x3c0
// Size: 0x74
function function_216c11c7(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwasdemojump) {
    if (bwasdemojump == 1) {
        util::playfxontag(fieldname, #"zombie/fx_powerup_on_caution_zmb", self, "tag_origin");
    }
}

// Namespace zm_silver_ww_quest/zm_silver_ww_quest
// Params 7, eflags: 0x1 linked
// Checksum 0x324362b4, Offset: 0x440
// Size: 0x74
function function_7bceb311(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwasdemojump) {
    if (bwasdemojump == 1) {
        util::playfxontag(fieldname, #"hash_153e7a9ec679962e", self, "tag_origin");
    }
}

// Namespace zm_silver_ww_quest/zm_silver_ww_quest
// Params 7, eflags: 0x1 linked
// Checksum 0x9721af1, Offset: 0x4c0
// Size: 0x8e
function function_37ba0961(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwasdemojump) {
    self endon(#"disconnect");
    if (bwasdemojump == 1) {
        self thread function_5bd0643d(fieldname);
        return;
    }
    self notify(#"hash_7e008885ec855120");
}

// Namespace zm_silver_ww_quest/zm_silver_ww_quest
// Params 1, eflags: 0x1 linked
// Checksum 0xfcca3b36, Offset: 0x558
// Size: 0xae
function function_5bd0643d(localclientnum) {
    self notify(#"hash_7e008885ec855120");
    self endon(#"disconnect", #"hash_7e008885ec855120");
    while (true) {
        if (isdefined(self)) {
            earthquake(localclientnum, 0.2, 1, self.origin, 100);
            self playrumbleonentity(localclientnum, "damage_light");
        }
        waitframe(1);
    }
}

// Namespace zm_silver_ww_quest/zm_silver_ww_quest
// Params 7, eflags: 0x1 linked
// Checksum 0xfd1e7daa, Offset: 0x610
// Size: 0x74
function function_198e136e(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwasdemojump) {
    if (bwasdemojump == 1) {
        playfx(fieldname, #"hash_7691f79bfc16f0bf", self.origin);
    }
}

// Namespace zm_silver_ww_quest/zm_silver_ww_quest
// Params 7, eflags: 0x1 linked
// Checksum 0x953055ac, Offset: 0x690
// Size: 0x74
function function_f875612b(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwasdemojump) {
    if (bwasdemojump == 1) {
        playfx(fieldname, #"hash_47d98c0644ec2ecd", self.origin);
    }
}

// Namespace zm_silver_ww_quest/zm_silver_ww_quest
// Params 7, eflags: 0x1 linked
// Checksum 0xaa3faffd, Offset: 0x710
// Size: 0xae
function crystal_energy_fx(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwasdemojump) {
    if (bwasdemojump) {
        self.var_358ffe83 = playfx(fieldname, #"zombie/fx_powerup_on_caution_zmb", self.origin);
        return;
    }
    if (isdefined(self.var_358ffe83)) {
        stopfx(fieldname, self.var_358ffe83);
        self.var_358ffe83 = undefined;
    }
}

// Namespace zm_silver_ww_quest/zm_silver_ww_quest
// Params 7, eflags: 0x1 linked
// Checksum 0xf3fb464, Offset: 0x7c8
// Size: 0xf6
function ww_vacuum_crystal_fx(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwasdemojump) {
    if (bwasdemojump) {
        if (self zm_utility::function_f8796df3(fieldname)) {
            self.var_37d7e267 = playviewmodelfx(fieldname, #"hash_2421d7984fb8e652", "tag_flash");
        } else {
            self.var_37d7e267 = util::playfxontag(fieldname, #"hash_2421d7984fb8e652", self, "tag_flash");
        }
        return;
    }
    if (isdefined(self.var_37d7e267)) {
        stopfx(fieldname, self.var_37d7e267);
        self.var_37d7e267 = undefined;
    }
}

// Namespace zm_silver_ww_quest/zm_silver_ww_quest
// Params 7, eflags: 0x1 linked
// Checksum 0x357eebb0, Offset: 0x8c8
// Size: 0xac
function hold_crystal_energy(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwasdemojump) {
    if (bwasdemojump) {
        self thread function_a6b2453b(fieldname, self zm_utility::function_f8796df3(fieldname));
        return;
    }
    self notify(#"hash_5b93168ba86f708a");
    self function_564a4c6(fieldname, 0);
}

// Namespace zm_silver_ww_quest/zm_silver_ww_quest
// Params 2, eflags: 0x1 linked
// Checksum 0x3deecaf7, Offset: 0x980
// Size: 0x158
function function_a6b2453b(localclientnum, var_a4f83274) {
    self endon(#"death", #"hash_5b93168ba86f708a");
    w_current = self function_d2c2b168();
    if (w_current.name == #"ww_ieu_shockwave_t9") {
        function_9dd39fc8(localclientnum, var_a4f83274);
    }
    while (isdefined(self)) {
        waitresult = self waittill(#"weapon_change");
        w_current = waitresult.weapon;
        w_previous = waitresult.last_weapon;
        if (w_current.name == #"ww_ieu_shockwave_t9") {
            function_9dd39fc8(localclientnum, var_a4f83274);
            continue;
        }
        if (w_previous.name == #"ww_ieu_shockwave_t9") {
            function_564a4c6(localclientnum, 1);
        }
    }
}

// Namespace zm_silver_ww_quest/zm_silver_ww_quest
// Params 2, eflags: 0x5 linked
// Checksum 0x32193113, Offset: 0xae0
// Size: 0x7a
function private function_9dd39fc8(localclientnum, var_a4f83274) {
    if (var_a4f83274) {
        self.var_23b807cf = playviewmodelfx(localclientnum, #"zombie/fx_powerup_on_caution_zmb", "tag_flash");
        return;
    }
    self.var_23b807cf = util::playfxontag(localclientnum, #"zombie/fx_powerup_on_caution_zmb", self, "tag_flash");
}

// Namespace zm_silver_ww_quest/zm_silver_ww_quest
// Params 2, eflags: 0x5 linked
// Checksum 0x5b62226b, Offset: 0xb68
// Size: 0x6e
function private function_564a4c6(localclientnum, var_d4ece4fd) {
    if (isdefined(self.var_23b807cf)) {
        if (var_d4ece4fd) {
            killfx(localclientnum, self.var_23b807cf);
        } else {
            stopfx(localclientnum, self.var_23b807cf);
        }
        self.var_23b807cf = undefined;
    }
}

