#using scripts\core_common\array_shared;
#using scripts\core_common\beam_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\postfx_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\zm_utility;

#namespace zm_weap_spectral_shield;

// Namespace zm_weap_spectral_shield/zm_weap_spectral_shield
// Params 0, eflags: 0x2
// Checksum 0xcabe0dd8, Offset: 0x3b0
// Size: 0x44
function autoexec __init__system__() {
    system::register(#"zm_weap_spectral_shield", &__init__, &__main__, undefined);
}

// Namespace zm_weap_spectral_shield/zm_weap_spectral_shield
// Params 0, eflags: 0x0
// Checksum 0xe950f2cf, Offset: 0x400
// Size: 0x72a
function __init__() {
    level.var_3d9066fe = getweapon(#"zhield_spectral_turret");
    level.var_6da26c79 = [];
    clientfield::register("allplayers", "afterlife_vision_play", 1, 1, "int", &afterlife_vision_play, 0, 0);
    clientfield::register("toplayer", "afterlife_window", 1, 1, "int", &afterlife_window, 0, 0);
    clientfield::register("scriptmover", "afterlife_entity_visibility", 1, 2, "int", &afterlife_entity_visibility, 0, 0);
    clientfield::register("allplayers", "spectral_key_beam_fire", 1, 1, "int", &spectral_key_beam_fire, 0, 0);
    clientfield::register("allplayers", "spectral_key_beam_flash", 1, 2, "int", &function_b7fa30cb, 0, 0);
    n_bits = getminbitcountfornum(4);
    clientfield::register("actor", "zombie_spectral_key_stun", 1, n_bits, "int", &function_f2f42fe9, 0, 0);
    clientfield::register("vehicle", "zombie_spectral_key_stun", 1, n_bits, "int", &function_f2f42fe9, 0, 0);
    clientfield::register("scriptmover", "zombie_spectral_key_stun", 1, n_bits, "int", &function_f2f42fe9, 0, 0);
    clientfield::register("scriptmover", "spectral_key_essence", 1, 1, "int", &function_c04d47ab, 0, 0);
    clientfield::register("allplayers", "spectral_key_charging", 1, 2, "int", &function_8db6e02a, 0, 0);
    clientfield::register("allplayers", "spectral_shield_blast", 1, 1, "counter", &function_c03298a1, 0, 0);
    clientfield::register("scriptmover", "shield_crafting_fx", 1, 1, "counter", &shield_crafting_fx, 0, 0);
    clientfield::register("actor", "spectral_blast_death", 1, 1, "int", &spectral_blast_death, 0, 0);
    level._effect[#"spectral_key_muzzle_flash1p"] = #"hash_1897770e10623dab";
    level._effect[#"spectral_key_muzzle_flash3p"] = #"hash_18906b0e105c0a99";
    level._effect[#"spectral_key_muzzle_flash1p_idle"] = #"hash_74f3e07770b3c780";
    level._effect[#"spectral_key_muzzle_flash3p_idle"] = #"hash_74faec7770b9fa92";
    level._effect[#"hash_5a834a39ce281cef"] = #"hash_42b1e9abdde1d678";
    level._effect[#"hash_6ca5cf8a3ac2254a"] = #"hash_6894b23015ff2626";
    level._effect[#"hash_5e08e3b80445f6d7"] = #"hash_db890f21c0af009";
    level._effect[#"hash_5e01d7b8043fc3c5"] = #"hash_dbf9cf21c11231b";
    level._effect[#"hash_3ae08d08271270d6"] = #"hash_35b66c4bdba4f1a8";
    level._effect[#"hash_3ad9a108270c7424"] = #"hash_35bd784bdbab24ba";
    level._effect[#"hash_4a41e8484e30822e"] = #"hash_55a201e66dbc23d3";
    level._effect[#"hash_4a3bdc484e2c021c"] = #"hash_559b15e66db62721";
    level._effect[#"hash_29b0420a85baa71b"] = #"hash_4a8de7cdf2716f1b";
    level._effect[#"hash_28b1c64bd72686eb"] = #"hash_5e46c3cecd080eeb";
    level._effect[#"air_blast"] = #"hash_70630dd76a790b4";
    level._effect[#"hash_3757ad652a2b0e54"] = #"hash_382d55804b58cfcb";
    level._effect[#"shield_crafting"] = #"hash_1e261e7fd620ac9e";
}

// Namespace zm_weap_spectral_shield/zm_weap_spectral_shield
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0xb38
// Size: 0x4
function __main__() {
    
}

// Namespace zm_weap_spectral_shield/zm_weap_spectral_shield
// Params 7, eflags: 0x0
// Checksum 0x43d392ed, Offset: 0xb48
// Size: 0x47c
function afterlife_vision_play(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    if (!isdefined(self.var_15dbaa77)) {
        self.var_15dbaa77 = [];
    }
    if (newval == 1) {
        if (!isdefined(self.weapon)) {
            return;
        }
        if (!(isdefined(function_fa783e7(self.weapon)) && function_fa783e7(self.weapon))) {
            return;
        }
        if (self getlocalclientnumber() === localclientnum) {
            self thread postfx::playpostfxbundle(#"hash_529f2ffb7f62ca50");
            a_e_players = getlocalplayers();
            foreach (e_player in a_e_players) {
                if (!e_player util::function_162f7df2(localclientnum)) {
                    e_player thread zm_utility::function_7bcc2e7e(localclientnum, #"hash_529f2ffb7f62ca50", #"hash_242ff4bae72c27b3");
                }
            }
            level.var_6da26c79 = array::remove_undefined(level.var_6da26c79, 0);
            foreach (e_vision in level.var_6da26c79) {
                if (isdefined(e_vision.show_function)) {
                    e_vision thread [[ e_vision.show_function ]](localclientnum);
                }
            }
        } else {
            self.var_15dbaa77[localclientnum] = util::playfxontag(localclientnum, level._effect[#"hash_3757ad652a2b0e54"], self, "tag_window_fx");
        }
        return;
    }
    if (self getlocalclientnumber() === localclientnum) {
        self postfx::stoppostfxbundle(#"hash_529f2ffb7f62ca50");
        a_e_players = getlocalplayers();
        foreach (e_player in a_e_players) {
            if (!e_player util::function_162f7df2(localclientnum)) {
                e_player notify(#"hash_242ff4bae72c27b3");
            }
        }
        level.var_6da26c79 = array::remove_undefined(level.var_6da26c79, 0);
        foreach (e_vision in level.var_6da26c79) {
            if (isdefined(e_vision.hide_function)) {
                e_vision thread [[ e_vision.hide_function ]](localclientnum);
            }
        }
        return;
    }
    if (isdefined(self.var_15dbaa77[localclientnum])) {
        stopfx(localclientnum, self.var_15dbaa77[localclientnum]);
        self.var_15dbaa77[localclientnum] = undefined;
    }
}

// Namespace zm_weap_spectral_shield/zm_weap_spectral_shield
// Params 7, eflags: 0x0
// Checksum 0x41b50282, Offset: 0xfd0
// Size: 0x84
function afterlife_window(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    if (newval) {
        self playrenderoverridebundle("rob_shield_window");
        return;
    }
    self stoprenderoverridebundle("rob_shield_window");
}

// Namespace zm_weap_spectral_shield/zm_weap_spectral_shield
// Params 7, eflags: 0x0
// Checksum 0xf24d38e9, Offset: 0x1060
// Size: 0x194
function afterlife_entity_visibility(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    if (newval == 1) {
        if (!isdefined(level.var_6da26c79)) {
            level.var_6da26c79 = [];
        } else if (!isarray(level.var_6da26c79)) {
            level.var_6da26c79 = array(level.var_6da26c79);
        }
        if (!isinarray(level.var_6da26c79, self)) {
            level.var_6da26c79[level.var_6da26c79.size] = self;
        }
        self.show_function = &function_99743bb7;
        self.hide_function = &function_8ccb5aa6;
        self hide();
        return;
    }
    if (newval == 2) {
        self notify(#"set_grabbed");
        self.b_seen = undefined;
        self.hide_function = undefined;
        self playrenderoverridebundle("rob_skull_grab");
        self show();
    }
}

// Namespace zm_weap_spectral_shield/zm_weap_spectral_shield
// Params 1, eflags: 0x0
// Checksum 0x3f88ee72, Offset: 0x1200
// Size: 0x64
function function_99743bb7(localclientnum) {
    self endon(#"death", #"set_grabbed");
    self playrenderoverridebundle("rob_spectral_vision");
    self show();
}

// Namespace zm_weap_spectral_shield/zm_weap_spectral_shield
// Params 1, eflags: 0x0
// Checksum 0x807bf788, Offset: 0x1270
// Size: 0x4c
function function_8ccb5aa6(localclientnum) {
    self endon(#"death", #"set_grabbed");
    self stoprenderoverridebundle("rob_spectral_vision");
}

// Namespace zm_weap_spectral_shield/zm_weap_spectral_shield
// Params 7, eflags: 0x0
// Checksum 0x6bbb0a90, Offset: 0x12c8
// Size: 0xf2
function spectral_blast_death(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    if (isdefined(self.var_dcec2cb7)) {
        deletefx(localclientnum, self.var_dcec2cb7, 1);
        self.var_dcec2cb7 = undefined;
    }
    if (newval == 1) {
        str_tag = "j_spineupper";
        if (self.archetype == "zombie_dog") {
            str_tag = "j_spine1";
        }
        self.var_dcec2cb7 = util::playfxontag(localclientnum, level._effect[#"hash_28b1c64bd72686eb"], self, str_tag);
    }
}

// Namespace zm_weap_spectral_shield/zm_weap_spectral_shield
// Params 7, eflags: 0x0
// Checksum 0x6900e42f, Offset: 0x13c8
// Size: 0xde
function spectral_key_beam_fire(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self endon(#"death", #"disconnect", #"hash_3ed4154ad2e33ec3");
    self function_d8bc2b9f(localclientnum);
    if (newval == 1) {
        self thread function_b3b0b78d(localclientnum);
        self thread function_78076ce2(localclientnum);
        return;
    }
    self notify(#"hash_3ed4154ad2e33ec3");
}

// Namespace zm_weap_spectral_shield/zm_weap_spectral_shield
// Params 1, eflags: 0x0
// Checksum 0x58204ccc, Offset: 0x14b0
// Size: 0x160
function function_78076ce2(localclientnum) {
    self endon(#"death", #"disconnect", #"hash_3ed4154ad2e33ec3");
    while (true) {
        s_result = level waittill(#"hash_73ff8d0d706c332d", #"hash_527d9fdde8903b80");
        self function_d8bc2b9f(localclientnum);
        if (s_result._notify === #"hash_73ff8d0d706c332d" && s_result.e_attacker === self && isdefined(s_result.e_target)) {
            var_becbdfb7 = s_result.e_target;
            self thread function_4505a44f(localclientnum);
            self thread function_73044d20(localclientnum, s_result.e_target);
            continue;
        }
        if (isdefined(var_becbdfb7) && var_becbdfb7 !== s_result.e_target) {
            return;
        }
        var_becbdfb7 = undefined;
        self thread function_b3b0b78d(localclientnum);
    }
}

// Namespace zm_weap_spectral_shield/zm_weap_spectral_shield
// Params 1, eflags: 0x0
// Checksum 0x840863d7, Offset: 0x1618
// Size: 0x104
function function_d8bc2b9f(localclientnum) {
    if (!isdefined(self)) {
        return;
    }
    self notify(#"hash_4ea2d9a0f785e09b");
    if (isdefined(self.var_cedfb9f5)) {
        level beam::kill(self, "tag_shield_key_fx", self.var_f929ecf4, "tag_origin", "beam8_zm_shield_key_ray_targeted");
        self.var_cedfb9f5 = undefined;
    }
    if (isdefined(self.var_f929ecf4)) {
        self.var_f929ecf4 delete();
        self.var_f929ecf4 = undefined;
    }
    if (isdefined(self.var_73c7c23c)) {
        self stoploopsound(self.var_73c7c23c);
        self.var_73c7c23c = undefined;
        self playsound(localclientnum, #"hash_3126b098b980b5a3");
    }
}

// Namespace zm_weap_spectral_shield/zm_weap_spectral_shield
// Params 1, eflags: 0x0
// Checksum 0x5285c0c0, Offset: 0x1728
// Size: 0xac
function function_b3b0b78d(localclientnum) {
    if (!isdefined(self)) {
        return;
    }
    self endon(#"death", #"hash_4ea2d9a0f785e09b");
    if (!isdefined(self.var_73c7c23c)) {
        self playsound(localclientnum, #"hash_3765e25049981166");
        self.var_73c7c23c = self playloopsound(#"hash_170aa1970243fc4a");
    }
    self thread function_f1485d07(localclientnum);
}

// Namespace zm_weap_spectral_shield/zm_weap_spectral_shield
// Params 1, eflags: 0x0
// Checksum 0x275759a9, Offset: 0x17e0
// Size: 0xa4
function function_f1485d07(localclientnum) {
    if (!isdefined(self)) {
        return;
    }
    self endon(#"death", #"hash_4ea2d9a0f785e09b");
    wait 0.5;
    if (isdefined(self) && isdefined(self.var_73c7c23c)) {
        self stoploopsound(self.var_73c7c23c);
        self.var_73c7c23c = undefined;
        self playsound(localclientnum, #"hash_3126b098b980b5a3");
    }
}

// Namespace zm_weap_spectral_shield/zm_weap_spectral_shield
// Params 2, eflags: 0x0
// Checksum 0xbb9402ff, Offset: 0x1890
// Size: 0x202
function function_73044d20(localclientnum, e_target) {
    if (!isdefined(self)) {
        return;
    }
    self endon(#"death", #"hash_4ea2d9a0f785e09b");
    if (!isdefined(self.var_73c7c23c)) {
        self playsound(localclientnum, #"hash_3765e25049981166");
        self.var_73c7c23c = self playloopsound(#"hash_170aa1970243fc4a");
    }
    var_cd2b6b1b = "j_spinelower";
    if (e_target isai()) {
        if (e_target.archetype == "zombie_dog") {
            var_cd2b6b1b = "j_spine1";
        } else if (!isdefined(e_target gettagorigin(var_cd2b6b1b))) {
            var_cd2b6b1b = "tag_origin";
        }
        self.var_f929ecf4 = util::spawn_model(localclientnum, "tag_origin", e_target gettagorigin(var_cd2b6b1b));
    } else if (e_target.type == "scriptmover") {
        var_cd2b6b1b = "tag_origin";
        self.var_f929ecf4 = util::spawn_model(localclientnum, "tag_origin", e_target.origin);
    }
    self.var_f929ecf4 linkto(e_target, var_cd2b6b1b);
    self.var_cedfb9f5 = level beam::launch(self, "tag_shield_key_fx", self.var_f929ecf4, "tag_origin", "beam8_zm_shield_key_ray_targeted");
}

// Namespace zm_weap_spectral_shield/zm_weap_spectral_shield
// Params 7, eflags: 0x0
// Checksum 0x79c83083, Offset: 0x1aa0
// Size: 0x450
function function_b7fa30cb(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (!isdefined(self.fx_muzzle_flash)) {
        self.fx_muzzle_flash = [];
    }
    if (isdefined(self.fx_muzzle_flash[localclientnum])) {
        deletefx(localclientnum, self.fx_muzzle_flash[localclientnum]);
        self.fx_muzzle_flash[localclientnum] = undefined;
    }
    a_e_players = getlocalplayers();
    foreach (e_player in a_e_players) {
        if (!e_player util::function_162f7df2(localclientnum)) {
            e_player notify(#"hash_52e05d0e2370536d");
        }
    }
    if (newval == 1) {
        var_1a620edb = "spectral_key_muzzle_flash1p_idle";
        var_8757db19 = "spectral_key_muzzle_flash3p_idle";
        if (self zm_utility::function_a96d4c46(localclientnum)) {
            self.fx_muzzle_flash[localclientnum] = playviewmodelfx(localclientnum, level._effect[var_1a620edb], "tag_flash");
        } else {
            self.fx_muzzle_flash[localclientnum] = util::playfxontag(localclientnum, level._effect[var_8757db19], self, "tag_flash");
        }
        a_e_players = getlocalplayers();
        foreach (e_player in a_e_players) {
            if (!e_player util::function_162f7df2(localclientnum)) {
                e_player thread zm_utility::function_7be7b2d8(localclientnum, self.fx_muzzle_flash[localclientnum], #"hash_52e05d0e2370536d");
            }
        }
        return;
    }
    if (newval == 2) {
        var_1a620edb = "spectral_key_muzzle_flash1p";
        var_8757db19 = "spectral_key_muzzle_flash3p";
        if (self zm_utility::function_a96d4c46(localclientnum)) {
            self.fx_muzzle_flash[localclientnum] = playviewmodelfx(localclientnum, level._effect[var_1a620edb], "tag_flash");
        } else {
            self.fx_muzzle_flash[localclientnum] = util::playfxontag(localclientnum, level._effect[var_8757db19], self, "tag_flash");
        }
        a_e_players = getlocalplayers();
        foreach (e_player in a_e_players) {
            if (!e_player util::function_162f7df2(localclientnum)) {
                e_player thread zm_utility::function_7be7b2d8(localclientnum, self.fx_muzzle_flash[localclientnum], #"hash_52e05d0e2370536d");
            }
        }
    }
}

// Namespace zm_weap_spectral_shield/zm_weap_spectral_shield
// Params 1, eflags: 0x4
// Checksum 0xf9012fe1, Offset: 0x1ef8
// Size: 0xf0
function private function_4505a44f(localclientnum) {
    if (!isdefined(self)) {
        return;
    }
    self notify(#"hash_360be32d770a6eb2");
    self endon(#"death", #"hash_360be32d770a6eb2", #"hash_4ea2d9a0f785e09b");
    self playrumbleonentity(localclientnum, "zm_weap_scepter_ray_hit_rumble");
    wait 0.5;
    while (true) {
        if (self isplayer() && self function_60dbc438()) {
            self playrumbleonentity(localclientnum, "zm_weap_scepter_ray_rumble");
        }
        wait 0.5;
    }
}

// Namespace zm_weap_spectral_shield/zm_weap_spectral_shield
// Params 7, eflags: 0x0
// Checksum 0xea627e5e, Offset: 0x1ff0
// Size: 0x34c
function function_f2f42fe9(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 0) {
        if (self isai()) {
            if (isdefined(self.var_c8cc6cd0)) {
                deletefx(localclientnum, self.var_c8cc6cd0, 1);
            }
            self.var_c8cc6cd0 = undefined;
            if (isdefined(self.var_59ed97f1) && self.var_59ed97f1) {
                self stoprenderoverridebundle("rob_zm_eyes_blue", "tag_eye");
                self.var_59ed97f1 = undefined;
            }
        } else if (isdefined(self.var_c8cc6cd0)) {
            deletefx(localclientnum, self.var_c8cc6cd0, 1);
            self.var_c8cc6cd0 = undefined;
        }
        if (isdefined(self.var_9e28bbd3)) {
            self stoploopsound(self.var_9e28bbd3);
            self.var_9e28bbd3 = undefined;
        }
        level thread function_56a7849b(localclientnum, self, undefined, 0);
        return;
    }
    e_attacker = getentbynum(localclientnum, newval - 1);
    if (self isai() && !(isdefined(self.isvehicle) && self.isvehicle)) {
        if (!isdefined(self.var_c8cc6cd0)) {
            str_tag = self zm_utility::function_a7776589();
            self.var_c8cc6cd0 = util::playfxontag(localclientnum, level._effect[#"hash_5a834a39ce281cef"], self, str_tag);
        }
        if (!(isdefined(self.var_59ed97f1) && self.var_59ed97f1) && self.archetype !== "ghost") {
            self playrenderoverridebundle("rob_zm_eyes_blue", "tag_eye");
            self.var_59ed97f1 = 1;
        }
    } else if (!isdefined(self.var_c8cc6cd0)) {
        self.var_c8cc6cd0 = util::playfxontag(localclientnum, level._effect[#"hash_5a834a39ce281cef"], self, "tag_origin");
    }
    if (!isdefined(self.var_9e28bbd3)) {
        self.var_9e28bbd3 = self playloopsound(#"hash_4c803bdbf30dd7fc");
    }
    level thread function_56a7849b(localclientnum, self, e_attacker, 1);
}

// Namespace zm_weap_spectral_shield/zm_weap_spectral_shield
// Params 4, eflags: 0x0
// Checksum 0xe91ba908, Offset: 0x2348
// Size: 0x19c
function function_56a7849b(localclientnum, e_target, e_attacker, var_84d383a = 1) {
    waitframe(1);
    if (var_84d383a) {
        level notify(#"hash_73ff8d0d706c332d", {#e_target:e_target, #e_attacker:e_attacker});
        if (e_target.archetype === "zombie_dog") {
            level thread function_c8c23689(localclientnum, e_target, e_attacker);
        }
        return;
    }
    level notify(#"hash_527d9fdde8903b80", {#e_target:e_target, #e_attacker:e_attacker});
    if (isdefined(e_target) && !isalive(e_target) && e_target.archetype === "zombie") {
        util::playfxontag(localclientnum, level._effect[#"hash_28b1c64bd72686eb"], e_target, "j_spinelower");
        playsound(localclientnum, #"hash_5eb0bbabfbde1ce8", e_target.origin);
    }
}

// Namespace zm_weap_spectral_shield/zm_weap_spectral_shield
// Params 3, eflags: 0x0
// Checksum 0x5bf9b54e, Offset: 0x24f0
// Size: 0x11c
function function_c8c23689(localclientnum, e_target, e_attacker) {
    if (isdefined(e_target)) {
        var_57816677 = e_target gettagorigin("j_spine1");
    }
    while (isalive(e_target) && isdefined(e_target.var_c8cc6cd0)) {
        var_57816677 = e_target gettagorigin("j_spine1");
        waitframe(1);
    }
    level notify(#"hash_527d9fdde8903b80", {#e_target:e_target, #e_attacker:e_attacker});
    if (!isalive(e_target) && isdefined(var_57816677)) {
        playsound(localclientnum, #"hash_5eb0bbabfbde1ce8", var_57816677);
    }
}

// Namespace zm_weap_spectral_shield/zm_weap_spectral_shield
// Params 7, eflags: 0x0
// Checksum 0xed27234a, Offset: 0x2618
// Size: 0xf6
function function_c04d47ab(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        if (isdefined(self.var_e3e7628c)) {
            deletefx(localclientnum, self.var_e3e7628c, 1);
        }
        self.var_e3e7628c = util::playfxontag(localclientnum, level._effect[#"hash_29b0420a85baa71b"], self, "tag_origin");
        return;
    }
    if (isdefined(self.var_e3e7628c)) {
        deletefx(localclientnum, self.var_e3e7628c, 1);
        self.var_e3e7628c = undefined;
    }
}

// Namespace zm_weap_spectral_shield/zm_weap_spectral_shield
// Params 7, eflags: 0x0
// Checksum 0x6e856029, Offset: 0x2718
// Size: 0x436
function function_8db6e02a(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (!isdefined(self.var_431f6723)) {
        self.var_431f6723 = [];
    }
    if (!isdefined(self.var_7470c76a)) {
        self.var_7470c76a = [];
    }
    a_e_players = getlocalplayers();
    foreach (e_player in a_e_players) {
        if (!e_player util::function_162f7df2(localclientnum)) {
            return;
        }
    }
    if (isdefined(self.var_431f6723[localclientnum])) {
        deletefx(localclientnum, self.var_431f6723[localclientnum], 1);
        self.var_431f6723[localclientnum] = undefined;
        self function_c20b6c81("rob_key_charging", "tag_weapon_right");
    }
    if (isdefined(self.var_7470c76a[localclientnum])) {
        deletefx(localclientnum, self.var_7470c76a[localclientnum], 1);
        self.var_7470c76a[localclientnum] = undefined;
        self function_c20b6c81("rob_key_charged", "tag_weapon_right");
    }
    if (!isdefined(self.weapon)) {
        return;
    }
    if (!(isdefined(function_fa783e7(self.weapon)) && function_fa783e7(self.weapon))) {
        return;
    }
    if (newval == 1) {
        if (self zm_utility::function_a96d4c46(localclientnum)) {
            self.var_431f6723[localclientnum] = playviewmodelfx(localclientnum, level._effect[#"hash_5e08e3b80445f6d7"], "tag_flash");
            self playrenderoverridebundle("rob_key_charging", "tag_weapon_right");
        } else {
            self.var_431f6723[localclientnum] = util::playfxontag(localclientnum, level._effect[#"hash_5e01d7b8043fc3c5"], self, "tag_flash");
        }
        self thread function_170bf239(localclientnum);
        return;
    }
    if (newval == 2) {
        if (self zm_utility::function_a96d4c46(localclientnum)) {
            self.var_7470c76a[localclientnum] = playviewmodelfx(localclientnum, level._effect[#"hash_3ae08d08271270d6"], "tag_flash");
            self playrenderoverridebundle("rob_key_charged", "tag_weapon_right");
        } else {
            self.var_431f6723[localclientnum] = util::playfxontag(localclientnum, level._effect[#"hash_3ad9a108270c7424"], self, "tag_flash");
        }
        self thread function_170bf239(localclientnum);
        return;
    }
    self notify(#"hash_479f7dbb037c00bc");
}

// Namespace zm_weap_spectral_shield/zm_weap_spectral_shield
// Params 1, eflags: 0x0
// Checksum 0x752a1b0, Offset: 0x2b58
// Size: 0x172
function function_170bf239(localclientnum) {
    self endon(#"disconnect");
    while (true) {
        self waittill(#"weapon_change", #"hash_479f7dbb037c00bc");
        if (!(isdefined(function_fa783e7(self.weapon)) && function_fa783e7(self.weapon))) {
            if (isdefined(self.var_431f6723[localclientnum])) {
                deletefx(localclientnum, self.var_431f6723[localclientnum], 1);
                self.var_431f6723[localclientnum] = undefined;
                self function_c20b6c81("rob_key_charging", "tag_weapon_right");
            }
            if (isdefined(self.var_7470c76a[localclientnum])) {
                deletefx(localclientnum, self.var_7470c76a[localclientnum], 1);
                self.var_7470c76a[localclientnum] = undefined;
                self function_c20b6c81("rob_key_charged", "tag_weapon_right");
            }
            return;
        }
    }
}

// Namespace zm_weap_spectral_shield/zm_weap_spectral_shield
// Params 7, eflags: 0x0
// Checksum 0xc912c3d0, Offset: 0x2cd8
// Size: 0x2ac
function function_c03298a1(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (!isdefined(self.var_28962658)) {
        self.var_28962658 = [];
    }
    w_current = self.weapon;
    if (w_current !== getweapon(#"zhield_spectral_turret") && w_current !== getweapon(#"zhield_spectral_turret_upgraded")) {
        return;
    }
    if (isdefined(self.var_28962658[localclientnum])) {
        deletefx(localclientnum, self.var_28962658[localclientnum], 1);
    }
    if (self zm_utility::function_a96d4c46(localclientnum)) {
        self.var_28962658[localclientnum] = playviewmodelfx(localclientnum, level._effect[#"hash_4a41e8484e30822e"], "tag_body_window");
    } else {
        self.var_28962658[localclientnum] = util::playfxontag(localclientnum, level._effect[#"hash_4a3bdc484e2c021c"], self, "tag_body_window");
    }
    util::playfxontag(localclientnum, level._effect[#"air_blast"], self, "tag_origin");
    var_5c795539 = util::spawn_model(localclientnum, "tag_origin", self gettagorigin("tag_body_window"), self gettagangles("tag_body_window"));
    var_5c795539 scene::play(#"p8_fxanim_zm_esc_blast_afterlife_bundle");
    var_5c795539 delete();
    if (isdefined(self.var_28962658[localclientnum])) {
        deletefx(localclientnum, self.var_28962658[localclientnum], 1);
    }
    self.var_28962658[localclientnum] = undefined;
}

// Namespace zm_weap_spectral_shield/zm_weap_spectral_shield
// Params 1, eflags: 0x4
// Checksum 0x396f182c, Offset: 0x2f90
// Size: 0xc2
function private function_fa783e7(w_current) {
    if (w_current == getweapon(#"zhield_spectral_dw") || w_current == getweapon(#"zhield_spectral_dw_upgraded")) {
        return true;
    }
    if (w_current == getweapon(#"zhield_spectral_turret") || w_current == getweapon(#"zhield_spectral_turret_upgraded")) {
        return true;
    }
    return false;
}

// Namespace zm_weap_spectral_shield/zm_weap_spectral_shield
// Params 7, eflags: 0x0
// Checksum 0xbd385b81, Offset: 0x3060
// Size: 0x74
function shield_crafting_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    util::playfxontag(localclientnum, level._effect[#"shield_crafting"], self, "tag_origin");
}

