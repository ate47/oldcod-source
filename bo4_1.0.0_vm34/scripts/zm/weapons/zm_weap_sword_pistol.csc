#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\zm_utility;

#namespace zm_weap_sword_pistol;

// Namespace zm_weap_sword_pistol/zm_weap_sword_pistol
// Params 0, eflags: 0x2
// Checksum 0x9feeaf5c, Offset: 0x1f8
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"zm_weap_sword_pistol", &__init__, undefined, undefined);
}

// Namespace zm_weap_sword_pistol/zm_weap_sword_pistol
// Params 0, eflags: 0x0
// Checksum 0x70817ee3, Offset: 0x240
// Size: 0x572
function __init__() {
    clientfield::register("actor", "sword_pistol_slice_right", 1, 1, "counter", &function_bbeb4c2c, 1, 0);
    clientfield::register("vehicle", "sword_pistol_slice_right", 1, 1, "counter", &function_bbeb4c2c, 1, 0);
    clientfield::register("actor", "sword_pistol_slice_left", 1, 1, "counter", &function_38924d95, 1, 0);
    clientfield::register("vehicle", "sword_pistol_slice_left", 1, 1, "counter", &function_38924d95, 1, 0);
    clientfield::register("actor", "dragon_roar_impact", 1, 1, "counter", &dragon_roar_impact, 1, 0);
    clientfield::register("vehicle", "dragon_roar_impact", 1, 1, "counter", &dragon_roar_impact, 1, 0);
    clientfield::register("scriptmover", "dragon_roar_explosion", 1, 1, "counter", &dragon_roar_explosion, 1, 0);
    clientfield::register("scriptmover", "viper_bite_projectile", 1, 1, "int", &viper_bite_projectile, 1, 0);
    clientfield::register("actor", "viper_bite_projectile_impact", 1, 1, "counter", &viper_bite_projectile_impact, 1, 0);
    clientfield::register("vehicle", "viper_bite_projectile_impact", 1, 1, "counter", &viper_bite_projectile_impact, 1, 0);
    clientfield::register("actor", "viper_bite_bitten_fx", 1, 1, "int", &viper_bite_bitten_fx, 1, 0);
    clientfield::register("toplayer", "swordpistol_rumble", 1, 3, "counter", &swordpistol_rumble, 0, 0);
    level._effect[#"hash_25626300bbf56aa7"] = #"hash_6a8080a7153541f6";
    level._effect[#"hash_67085795f324f6b5"] = #"hash_6a8080a7153541f6";
    level._effect[#"hash_72dcd3be23419b87"] = #"hash_597abd90e7ff80e0";
    level._effect[#"hash_2cce5c832c2c19be"] = #"hash_358368e2fa3ca4f1";
    level._effect[#"hash_6890c4ba9ae61d0b"] = #"hash_28918c31efbce546";
    level._effect[#"hash_206a58239ffb5e0f"] = #"hash_73d097f983d47f3c";
    level._effect[#"viper_bite_projectile"] = #"hash_2ecc9e78037c5407";
    level._effect[#"viper_bite_projectile_impact"] = #"hash_571fb567ca3d4add";
    level._effect[#"hash_b784dd4d224f7e"] = #"hash_90808e1ff32f322";
    level._effect[#"dragon_roar_impact"] = #"hash_128e20307b969081";
    level._effect[#"dragon_roar_explosion"] = #"hash_1d90aa9406e48582";
}

// Namespace zm_weap_sword_pistol/zm_weap_sword_pistol
// Params 7, eflags: 0x0
// Checksum 0xae746421, Offset: 0x7c0
// Size: 0x94
function function_bbeb4c2c(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    util::playfxontag(localclientnum, level._effect[#"hash_25626300bbf56aa7"], self, "j_spine4");
    self playrumbleonentity(localclientnum, "damage_heavy");
}

// Namespace zm_weap_sword_pistol/zm_weap_sword_pistol
// Params 7, eflags: 0x0
// Checksum 0x93cff522, Offset: 0x860
// Size: 0x94
function function_38924d95(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    util::playfxontag(localclientnum, level._effect[#"hash_67085795f324f6b5"], self, "j_spine4");
    self playrumbleonentity(localclientnum, "damage_heavy");
}

// Namespace zm_weap_sword_pistol/zm_weap_sword_pistol
// Params 7, eflags: 0x0
// Checksum 0x1b85a0dc, Offset: 0x900
// Size: 0xa4
function dragon_roar_impact(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    util::playfxontag(localclientnum, level._effect[#"dragon_roar_impact"], self, self zm_utility::function_a7776589());
    self playsound(0, #"hash_7272d200a14dfe79");
}

// Namespace zm_weap_sword_pistol/zm_weap_sword_pistol
// Params 7, eflags: 0x0
// Checksum 0xdd6a5fd0, Offset: 0x9b0
// Size: 0x94
function dragon_roar_explosion(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    playfx(localclientnum, level._effect[#"dragon_roar_explosion"], self.origin);
    self playsound(0, #"hash_5e5fc609282c18d2");
}

// Namespace zm_weap_sword_pistol/zm_weap_sword_pistol
// Params 7, eflags: 0x0
// Checksum 0x98c043e9, Offset: 0xa50
// Size: 0xd0
function viper_bite_projectile(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        self.fx_trail = util::playfxontag(localclientnum, level._effect[#"viper_bite_projectile"], self, "tag_origin");
        if (isdefined(self.snd_looper)) {
        }
        return;
    }
    if (isdefined(self.fx_trail)) {
        stopfx(localclientnum, self.fx_trail);
    }
    if (isdefined(self.snd_looper)) {
    }
}

// Namespace zm_weap_sword_pistol/zm_weap_sword_pistol
// Params 7, eflags: 0x0
// Checksum 0x3ae636a1, Offset: 0xb28
// Size: 0xa4
function viper_bite_projectile_impact(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    util::playfxontag(localclientnum, level._effect[#"viper_bite_projectile_impact"], self, self zm_utility::function_a7776589());
    self playsound(0, #"hash_3098cba1f74bb5d1");
}

// Namespace zm_weap_sword_pistol/zm_weap_sword_pistol
// Params 7, eflags: 0x0
// Checksum 0x4debb7e7, Offset: 0xbd8
// Size: 0x15c
function viper_bite_bitten_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        self.var_895a934 = util::playfxontag(localclientnum, level._effect[#"hash_206a58239ffb5e0f"], self, "j_spine4");
        if (!isdefined(self.var_73c76e1b)) {
            self.var_73c76e1b = self playloopsound(#"hash_117558f0dda6471f");
        }
        return;
    }
    if (isdefined(self.var_895a934)) {
        stopfx(localclientnum, self.var_895a934);
    }
    if (isdefined(self.var_73c76e1b)) {
        self stoploopsound(self.var_73c76e1b);
        self.var_73c76e1b = undefined;
    }
    util::playfxontag(localclientnum, level._effect[#"hash_b784dd4d224f7e"], self, "j_spine4");
}

// Namespace zm_weap_sword_pistol/zm_weap_sword_pistol
// Params 7, eflags: 0x0
// Checksum 0x135be4b9, Offset: 0xd40
// Size: 0xfa
function swordpistol_rumble(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
    if (newvalue) {
        switch (newvalue) {
        case 2:
            self playrumbleonentity(localclientnum, "zm_weap_swordpistol_melee_rumble");
            break;
        case 4:
            self playrumbleonentity(localclientnum, "zm_weap_swordpistol_shoot_rumble");
            break;
        case 5:
            self playrumbleonentity(localclientnum, "zm_weap_swordpistol_special_rumble");
            break;
        }
    }
}

