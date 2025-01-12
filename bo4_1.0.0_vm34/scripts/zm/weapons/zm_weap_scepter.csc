#using scripts\core_common\beam_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\postfx_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\zm_utility;

#namespace zm_weap_scepter;

// Namespace zm_weap_scepter/zm_weap_scepter
// Params 0, eflags: 0x2
// Checksum 0x9b006f33, Offset: 0x318
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"zm_weap_scepter", &__init__, undefined, undefined);
}

// Namespace zm_weap_scepter/zm_weap_scepter
// Params 0, eflags: 0x0
// Checksum 0x2e72ea1f, Offset: 0x360
// Size: 0x692
function __init__() {
    clientfield::register("allplayers", "zombie_scepter_melee_impact", 1, 1, "counter", &function_200cb11b, 1, 0);
    clientfield::register("allplayers", "zombie_scepter_melee", 1, 1, "counter", &function_fab311a2, 1, 0);
    clientfield::register("allplayers", "zombie_scepter_heal", 1, 1, "counter", &function_a2b60a62, 0, 0);
    clientfield::register("scriptmover", "beacon_fx", 1, 1, "int", &beacon_fx, 0, 0);
    clientfield::register("allplayers", "skull_turret_beam_fire", 1, 2, "int", &skull_turret_beam_fire, 0, 0);
    clientfield::register("allplayers", "scepter_beam_flash", 1, 2, "int", &flash_fx, 0, 0);
    clientfield::register("toplayer", "hero_scepter_vigor_postfx", 1, 1, "counter", &function_1a751bb4, 0, 0);
    clientfield::register("allplayers", "zombie_scepter_revive", 1, 1, "int", &revive_fx, 0, 0);
    clientfield::register("actor", "zombie_scepter_stun", 1, 1, "int", &function_d140fc0f, 0, 0);
    clientfield::register("vehicle", "zombie_scepter_stun", 1, 1, "int", &function_d140fc0f, 0, 0);
    clientfield::register("toplayer", "scepter_rumble", 1, 3, "counter", &scepter_rumble, 0, 0);
    level._effect[#"hash_1c2f974106158a5f"] = #"hash_7c1a6aad09dc0d7a";
    level._effect[#"hash_1c28ab41060f8dad"] = #"hash_7c145ead09d78d68";
    level._effect[#"scepter_bubble"] = #"hash_17756eb35aac3766";
    level._effect[#"hash_4c17911c3aed59ae"] = #"hash_15d8d928da3054a8";
    level._effect[#"hash_47a7d03689c68789"] = #"hash_7bf95975cc22d9e3";
    level._effect[#"scepter_revive"] = #"hash_7247f41820f6a4ac";
    level._effect[#"hash_5a1d977ed6c0bfbc"] = #"hash_7e8ecb7f481f27c1";
    level._effect[#"hash_5a24a37ed6c6f2ce"] = #"hash_7e95b77f48252473";
    level._effect[#"hash_1764e15fc9d376eb"] = #"hash_7951bc836b30dd06";
    level._effect[#"hash_175dd55fc9cd43d9"] = #"hash_794ad0836b2ae054";
    level._effect[#"hash_3c7dd8fed636096e"] = #"hash_683f232e39602a5f";
    level._effect[#"hash_3c76ccfed62fd65c"] = #"hash_6838372e395a2dad";
    level._effect[#"hash_143a6ec5331de8ec"] = #"hash_2dfc8a9a16973a20";
    level._effect[#"hash_14407ac5332268fe"] = #"hash_2e02969a169bba32";
    level._effect[#"hash_37498552cad06776"] = #"hash_2bd6cabc06cbf037";
    level._effect[#"hash_37429952caca6ac4"] = #"hash_2bcfbebc06c5bd25";
    level._effect[#"turret_zombie_shock"] = "zm_weapons/fx8_scepter_ray_zmb_hit_shock";
    level._effect[#"turret_zombie_explode"] = "zm_weapons/fx8_scepter_ray_zmb_hit_exp";
    level._effect[#"skull_turret_shock_eyes"] = "zm_weapons/fx8_scepter_ray_zmb_hit_eye";
}

// Namespace zm_weap_scepter/zm_weap_scepter
// Params 7, eflags: 0x0
// Checksum 0xc4177bed, Offset: 0xa00
// Size: 0xcc
function function_200cb11b(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (self zm_utility::function_a96d4c46(localclientnum)) {
        playviewmodelfx(localclientnum, level._effect[#"hash_143a6ec5331de8ec"], "tag_flash");
        return;
    }
    util::playfxontag(localclientnum, level._effect[#"hash_14407ac5332268fe"], self, "tag_flash");
}

// Namespace zm_weap_scepter/zm_weap_scepter
// Params 7, eflags: 0x0
// Checksum 0x425573ac, Offset: 0xad8
// Size: 0xcc
function function_fab311a2(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (self zm_utility::function_a96d4c46(localclientnum)) {
        playviewmodelfx(localclientnum, level._effect[#"hash_37498552cad06776"], "tag_flash");
        return;
    }
    util::playfxontag(localclientnum, level._effect[#"hash_37429952caca6ac4"], self, "tag_flash");
}

// Namespace zm_weap_scepter/zm_weap_scepter
// Params 7, eflags: 0x0
// Checksum 0x72ca2c09, Offset: 0xbb0
// Size: 0x8c
function skull_turret_beam_fire(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    function_1046b72f(localclientnum);
    if (newval) {
        self thread function_463d46bd(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump);
    }
}

// Namespace zm_weap_scepter/zm_weap_scepter
// Params 7, eflags: 0x0
// Checksum 0x54e46919, Offset: 0xc48
// Size: 0x19a
function flash_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (isdefined(self.fx_muzzle_flash)) {
        deletefx(localclientnum, self.fx_muzzle_flash);
        self.fx_muzzle_flash = undefined;
    }
    if (function_9a47ed7f(localclientnum)) {
        return;
    }
    switch (newval) {
    case 1:
    case 2:
    case 3:
        var_1a620edb = "scepter" + newval + "_muzzle_flash1p";
        var_8757db19 = "scepter" + newval + "_muzzle_flash3p";
        if (self zm_utility::function_a96d4c46(localclientnum)) {
            self.fx_muzzle_flash = playviewmodelfx(localclientnum, level._effect[var_1a620edb], "tag_flash");
        } else {
            self.fx_muzzle_flash = util::playfxontag(localclientnum, level._effect[var_8757db19], self, "tag_flash");
        }
        break;
    }
}

// Namespace zm_weap_scepter/zm_weap_scepter
// Params 1, eflags: 0x0
// Checksum 0xf837c709, Offset: 0xdf0
// Size: 0xe4
function function_1046b72f(localclientnum) {
    self notify(#"hash_3cbfa1076dfa868b");
    if (isdefined(self.var_f929ecf4)) {
        level beam::kill(self, "tag_flash", self.var_f929ecf4, "tag_origin", "beam8_zm_scepter_ray_lvl1");
        self.var_f929ecf4 delete();
        self.var_f929ecf4 = undefined;
    }
    if (isdefined(self.var_73c7c23c)) {
        self stoploopsound(self.var_73c7c23c);
        self.var_73c7c23c = undefined;
        self playsound(localclientnum, #"hash_3126b098b980b5a3");
    }
}

// Namespace zm_weap_scepter/zm_weap_scepter
// Params 7, eflags: 0x0
// Checksum 0xfbb8a535, Offset: 0xee0
// Size: 0x194
function function_463d46bd(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self notify(#"hash_3cbfa1076dfa868b");
    self endon(#"hash_3cbfa1076dfa868b");
    if (!isdefined(self.var_73c7c23c)) {
        self playsound(localclientnum, #"hash_3765e25049981166");
        self.var_73c7c23c = self playloopsound(#"hash_170aa1970243fc4a");
    }
    self.var_f929ecf4 = util::spawn_model(localclientnum, "tag_origin", self.origin);
    switch (newval) {
    case 2:
        var_d6f6c3fe = "beam8_zm_scepter_ray_lvl2";
        break;
    case 3:
        var_d6f6c3fe = "beam8_zm_scepter_ray_lvl3";
        break;
    default:
        var_d6f6c3fe = "beam8_zm_scepter_ray_lvl1";
        break;
    }
    level beam::launch(self, "tag_flash", self.var_f929ecf4, "tag_origin", var_d6f6c3fe);
}

// Namespace zm_weap_scepter/zm_weap_scepter
// Params 2, eflags: 0x0
// Checksum 0x11332b36, Offset: 0x1080
// Size: 0x6c
function render_debug_sphere(origin, color) {
    if (getdvarint(#"turret_debug", 0)) {
        /#
            sphere(origin, 2, color, 0.75, 1, 10, 100);
        #/
    }
}

// Namespace zm_weap_scepter/zm_weap_scepter
// Params 3, eflags: 0x0
// Checksum 0x3770f5ad, Offset: 0x10f8
// Size: 0x6c
function function_cd048702(origin1, origin2, color) {
    if (getdvarint(#"turret_debug", 0)) {
        /#
            line(origin1, origin2, color, 0.75, 1, 100);
        #/
    }
}

// Namespace zm_weap_scepter/zm_weap_scepter
// Params 7, eflags: 0x0
// Checksum 0x3ec8b7e3, Offset: 0x1170
// Size: 0x136
function function_d140fc0f(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        if (!isdefined(self.var_21ed671e)) {
            str_tag = self zm_utility::function_a7776589();
            self.var_21ed671e = util::playfxontag(localclientnum, level._effect[#"hash_47a7d03689c68789"], self, str_tag);
            sndorigin = self gettagorigin(str_tag);
            playsound(0, #"zmb_vocals_zombie_skull_scream", sndorigin);
        }
        return;
    }
    if (isdefined(self.var_21ed671e)) {
        deletefx(localclientnum, self.var_21ed671e, 1);
    }
    self.var_21ed671e = undefined;
}

// Namespace zm_weap_scepter/zm_weap_scepter
// Params 7, eflags: 0x0
// Checksum 0x5396d0cb, Offset: 0x12b0
// Size: 0x204
function beacon_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        self.b_beacon_fx = 1;
        if (!isdefined(level.a_mdl_beacons)) {
            level.a_mdl_beacons = [];
        }
        if (!isinarray(level.a_mdl_beacons, self)) {
            if (!isdefined(level.a_mdl_beacons)) {
                level.a_mdl_beacons = [];
            } else if (!isarray(level.a_mdl_beacons)) {
                level.a_mdl_beacons = array(level.a_mdl_beacons);
            }
            level.a_mdl_beacons[level.a_mdl_beacons.size] = self;
        }
        if (isdefined(self.b_beacon_fx) && self.b_beacon_fx) {
            self.n_beacon_fx = util::playfxontag(localclientnum, level._effect[#"scepter_bubble"], self, "tag_origin");
        }
        return;
    }
    self.b_beacon_fx = undefined;
    if (isdefined(self.n_beacon_fx)) {
        deletefx(localclientnum, self.n_beacon_fx, 1);
        util::playfxontag(localclientnum, level._effect[#"hash_4c17911c3aed59ae"], self, "tag_origin");
        self.n_beacon_fx = undefined;
    }
    arrayremovevalue(level.a_mdl_beacons, self);
}

// Namespace zm_weap_scepter/zm_weap_scepter
// Params 7, eflags: 0x4
// Checksum 0x9c817ee2, Offset: 0x14c0
// Size: 0x64
function private function_1a751bb4(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
    if (newvalue) {
        self thread postfx::playpostfxbundle(#"hash_28d2c6df1a547302");
    }
}

// Namespace zm_weap_scepter/zm_weap_scepter
// Params 7, eflags: 0x0
// Checksum 0xb6c6426d, Offset: 0x1530
// Size: 0x13e
function function_a2b60a62(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    e_local_player = function_f97e7787(localclientnum);
    if (newval) {
        if (e_local_player != self) {
            if (!isdefined(self.var_2e2c1100)) {
                self.var_2e2c1100 = [];
            }
            if (isdefined(self.var_2e2c1100[localclientnum])) {
                return;
            }
            if (!(isdefined(self.var_b2ca5296) && self.var_b2ca5296)) {
                self.var_b2ca5296 = 1;
                self.var_2e2c1100[localclientnum] = util::playfxontag(localclientnum, #"zombie/fx_bgb_near_death_3p", self, "j_spine4");
                wait 0.5;
                stopfx(localclientnum, self.var_2e2c1100[localclientnum]);
                self.var_2e2c1100[localclientnum] = undefined;
                self.var_b2ca5296 = undefined;
            }
        }
    }
}

// Namespace zm_weap_scepter/zm_weap_scepter
// Params 7, eflags: 0x0
// Checksum 0x68aed5dd, Offset: 0x1678
// Size: 0xfe
function revive_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        if (!isdefined(self.var_d4376537)) {
            self.var_d4376537 = util::playfxontag(localclientnum, level._effect[#"scepter_revive"], self, "tag_eye");
            sndorigin = self gettagorigin("J_Eyeball_LE");
        }
        return;
    }
    if (isdefined(self.var_d4376537)) {
        deletefx(localclientnum, self.var_d4376537, 1);
    }
    self.var_d4376537 = undefined;
}

// Namespace zm_weap_scepter/zm_weap_scepter
// Params 7, eflags: 0x0
// Checksum 0x6e3dac08, Offset: 0x1780
// Size: 0xfa
function scepter_rumble(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
    if (newvalue) {
        switch (newvalue) {
        case 2:
            self playrumbleonentity(localclientnum, "zm_weap_scepter_melee_rumble");
            break;
        case 5:
            self playrumbleonentity(localclientnum, "zm_weap_scepter_ray_rumble");
            break;
        case 6:
            self playrumbleonentity(localclientnum, "zm_weap_scepter_ray_hit_rumble");
            break;
        }
    }
}

