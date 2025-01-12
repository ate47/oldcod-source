#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\flagsys_shared;
#using scripts\core_common\postfx_shared;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;
#using scripts\core_common\water_surface;
#using scripts\zm_common\zm_powerups;
#using scripts\zm_common\zm_sq_modules;
#using scripts\zm_common\zm_utility;
#using scripts\zm_common\zm_weapons;

#namespace zodt8_sentinel;

// Namespace zodt8_sentinel/zm_zodt8_sentinel_trial
// Params 0, eflags: 0x0
// Checksum 0xc593721e, Offset: 0x1b8
// Size: 0x44
function init() {
    init_clientfields();
    init_flags();
    init_fx();
    function_5c165ebf();
}

// Namespace zodt8_sentinel/zm_zodt8_sentinel_trial
// Params 0, eflags: 0x0
// Checksum 0x428c95aa, Offset: 0x208
// Size: 0x7a4
function init_clientfields() {
    clientfield::register("world", "" + #"hash_3c58464f16d8a1be", 1, 1, "int", &function_bdc4f2c6, 0, 0);
    clientfield::register("scriptmover", "" + #"land_fx", 1, 1, "int", &function_7184171e, 0, 0);
    clientfield::register("scriptmover", "" + #"essence_fx", 1, 1, "int", &function_5ee38b92, 0, 0);
    clientfield::register("scriptmover", "" + #"planet_light", 1, getminbitcountfornum(9), "int", &function_1fd94860, 0, 0);
    clientfield::register("scriptmover", "" + #"pulse_shader", 1, 1, "int", &function_2d5c42af, 0, 0);
    clientfield::register("scriptmover", "" + #"sentinel_shader", 1, 1, "int", &function_fe2e366d, 0, 0);
    clientfield::register("scriptmover", "" + #"hash_3400ccffbd3d73b3", 1, 2, "int", &function_353cc4da, 0, 0);
    clientfield::register("scriptmover", "" + #"hash_15b23de7589e61a", 1, 1, "int", &function_5eb1c6e, 0, 0);
    clientfield::register("scriptmover", "" + #"blocker_fx", 1, 1, "int", &function_f30f0212, 0, 0);
    clientfield::register("scriptmover", "" + #"hash_68e2384b254175da", 1, 1, "counter", &function_ba89220, 0, 0);
    clientfield::register("scriptmover", "" + #"pipe_fx", 1, 2, "int", &pipe_fx, 0, 0);
    clientfield::register("scriptmover", "" + #"teleport_sigil", 1, 1, "int", &teleport_sigil, 0, 0);
    clientfield::register("scriptmover", "" + #"hash_46e2ed49fb0f55c6", 1, 1, "int", &function_a01755d4, 0, 0);
    clientfield::register("scriptmover", "" + #"water_props", 1, 1, "int", &function_6f16e3fe, 0, 0);
    clientfield::register("toplayer", "" + #"boiler_fx", 1, 1, "int", &function_6b349f37, 0, 0);
    clientfield::register("toplayer", "" + #"main_flash", 1, 1, "int", &function_1267d421, 0, 0);
    clientfield::register("toplayer", "" + #"iceberg_rumbles", 1, 1, "int", &function_a8508bf8, 0, 0);
    clientfield::register("toplayer", "" + #"hash_7a927551ca199a1c", 1, 1, "counter", &function_37f83aae, 0, 0);
    clientfield::register("toplayer", "" + #"icy_bubbles", 1, 1, "int", &function_35279ce6, 0, 0);
    clientfield::register("toplayer", "" + #"hash_58b44c320123e829", 1, 1, "int", &function_98c019e5, 0, 0);
    clientfield::register("toplayer", "" + #"camera_snow", 1, 1, "int", &camera_snow, 0, 0);
    clientfield::register("vehicle", "" + #"orb_fx", 1, 1, "int", &function_c230af71, 0, 0);
}

// Namespace zodt8_sentinel/zm_zodt8_sentinel_trial
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x9b8
// Size: 0x4
function init_flags() {
    
}

// Namespace zodt8_sentinel/zm_zodt8_sentinel_trial
// Params 0, eflags: 0x0
// Checksum 0x61f31576, Offset: 0x9c8
// Size: 0x872
function init_fx() {
    level._effect[#"hash_2e7f9a3bff90af4a"] = #"zm_ai/fx8_cata_cor_aura";
    level._effect[#"hash_573af1567956ac69"] = #"hash_661da9149933ecf9";
    level._effect[#"hash_538a9337bb9927da"] = #"zm_ai/fx8_cata_elec_aura";
    level._effect[#"hash_3dba8e7d212e4382"] = #"hash_641c2257723638c2";
    level._effect[#"hash_59916e76378fa3d8"] = #"hash_62eafc17a432322a";
    level._effect[#"hash_1e6b4bfa36f9487b"] = #"hash_1832a0ef5af0040d";
    level._effect[#"hash_4b9011909a431ac8"] = #"hash_619361bb6a9a5d2d";
    level._effect[#"hash_50a595992ac285d0"] = #"hash_3009e42178ffd484";
    level._effect[#"hash_4ab2496c89a7d871"] = #"hash_4a305119bc50ca3d";
    level._effect[#"packed_artifact"] = #"zombie/fx_ritual_glow_relic_zod_zmb";
    level._effect[#"catalyst_blocker"] = #"hash_5b773dbbac0012ff";
    level._effect[#"sentinel_aura"] = #"hash_3def678deb7f4078";
    level._effect[#"sentinel_activate"] = #"hash_464f27bfbf0ce7bf";
    level._effect[#"sentinel_glow"] = #"hash_41b2c270f26faabc";
    level._effect[#"glyph_activate"] = #"hash_6a4db7ffc84cf7fc";
    level._effect[#"orb_trail"] = #"hash_6d900123df67f4ce";
    level._effect[#"orb_essence"] = #"hash_2aac2efa85bfb786";
    level._effect[#"hash_2dd4629ae81753e5"] = #"hash_203548b984de70a4";
    level._effect[#"hash_23c18b717592a89d"] = #"hash_43cec289a09441e9";
    level._effect[#"hash_2bb182b164a2d789"] = #"hash_71fc8c15d53b5fe2";
    level._effect[#"hash_4274dc30c3876166"] = #"hash_2f27882b95a820fd";
    level._effect[#"ice_blocker"] = #"hash_55a1d3ce6c554a7a";
    level._effect[#"hash_53533bf74eb74209"] = #"hash_2909be1122353509";
    level._effect[#"hash_535338f74eb73cf0"] = #"hash_28b4c41121ecff3c";
    level._effect[#"hash_452505f92d084e74"] = #"hash_7fb7de4ea65f1b9d";
    level._effect[#"hash_6160e75bd4d4852"] = #"hash_369788360ca4879d";
    level._effect[#"hash_3316f2b0a2dcecda"] = #"hash_56e16e07d428fead";
    level._effect[#"step7_snow"] = #"hash_d778729ca762c5a";
    level._effect[#"loc_jupiter"] = #"hash_618dd5f64c043c98";
    level._effect[#"loc_saturn"] = #"hash_c02fd55105bf590";
    level._effect[#"loc_uranus"] = #"hash_28b92cc776e22757";
    level._effect[#"loc_neptune"] = #"hash_7f0ec9b1b2e75c04";
    level._effect[#"loc_mars"] = #"hash_1a3f1102ecab4c66";
    level._effect[#"loc_venus"] = #"hash_762bfc3142f1039c";
    level._effect[#"loc_mercury"] = #"hash_68cc20f5cb8f2474";
    level._effect[#"loc_sun"] = #"hash_7d600aa6483d645b";
    level._effect[#"loc_moon"] = #"hash_7111a6031de7ead2";
    level._effect[#"hash_5c7f484e340fdde6"] = #"hash_728126700110e700";
    level._effect[#"hash_331f4a597e6c0189"] = #"hash_1899ecdfcd7daa00";
    level._effect[#"hash_345b045ea57a58e8"] = #"hash_231dd4d8a69cc3b2";
    level._effect[#"sigil_on"] = #"hash_454a052cba35b654";
    level._effect[#"sigil_off"] = #"hash_22f995964a88d0e0";
    level._effect[#"tree_impact"] = #"hash_39b325729fc733ae";
    level._effect[#"tree_trail"] = #"hash_4d7b9b72e10c3737";
    level._effect[#"tree_activate"] = #"hash_6776cc88134ba740";
}

// Namespace zodt8_sentinel/zm_zodt8_sentinel_trial
// Params 0, eflags: 0x0
// Checksum 0x1792a8b7, Offset: 0x1248
// Size: 0x344
function function_5c165ebf() {
    zm_sq_modules::function_8ab612a3(#"hash_41a5c5168ffb2a97", 1, #"hash_3d7f94e7862a63ab", 50, level._effect[#"hash_2e7f9a3bff90af4a"], level._effect[#"hash_59916e76378fa3d8"], undefined, &j_chain_le_8);
    zm_sq_modules::function_8ab612a3(#"hash_400a481490a4e390", 1, #"hash_3d7f94e7862a63ab", 50, level._effect[#"hash_573af1567956ac69"], level._effect[#"hash_1e6b4bfa36f9487b"], undefined, &j_chain_le_8);
    zm_sq_modules::function_8ab612a3(#"hash_5562e324d230f057", 1, #"hash_3d7f94e7862a63ab", 50, level._effect[#"hash_538a9337bb9927da"], level._effect[#"hash_4b9011909a431ac8"], undefined, &j_chain_le_8);
    zm_sq_modules::function_8ab612a3(#"hash_41fae186552f1259", 1, #"hash_3d7f94e7862a63ab", 50, level._effect[#"hash_3dba8e7d212e4382"], level._effect[#"hash_50a595992ac285d0"], undefined, &j_chain_le_8);
    zm_sq_modules::function_8ab612a3(#"hash_7182a46bb3cdf577", 1, #"hash_7182a46bb3cdf577", 111, level._effect[#"hash_2e7f9a3bff90af4a"], level._effect[#"hash_59916e76378fa3d8"], undefined);
    zm_sq_modules::function_8ab612a3(#"hash_466c2764cc790370", 1, #"hash_466c2764cc790370", 111, level._effect[#"hash_573af1567956ac69"], level._effect[#"hash_1e6b4bfa36f9487b"], undefined);
    zm_sq_modules::function_8ab612a3(#"hash_34f2b4c4f7d74137", 1, #"hash_34f2b4c4f7d74137", 111, level._effect[#"hash_538a9337bb9927da"], level._effect[#"hash_4b9011909a431ac8"], undefined);
    zm_sq_modules::function_8ab612a3(#"hash_49ad34a64ecaebb9", 1, #"hash_49ad34a64ecaebb9", 111, level._effect[#"hash_3dba8e7d212e4382"], level._effect[#"hash_50a595992ac285d0"], undefined);
}

// Namespace zodt8_sentinel/zm_zodt8_sentinel_trial
// Params 3, eflags: 0x0
// Checksum 0xa2e3105b, Offset: 0x1598
// Size: 0x1c
function j_chain_le_8(localclientnum, def, s_capture_point) {
    
}

// Namespace zodt8_sentinel/zm_zodt8_sentinel_trial
// Params 7, eflags: 0x0
// Checksum 0xe0786be4, Offset: 0x15c0
// Size: 0x13c
function camera_snow(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self notify("e267d63b48e0c78");
    self endon("e267d63b48e0c78");
    if (newval) {
        while (true) {
            if (isalive(self) && self util::function_162f7df2(localclientnum)) {
                self.var_3e03e352 = playfxoncamera(localclientnum, level._effect[#"step7_snow"], undefined, anglestoforward(self.angles), anglestoup(self.angles));
            }
            wait 0.25;
        }
        return;
    }
    if (isdefined(self.var_3e03e352)) {
        stopfx(localclientnum, self.var_3e03e352);
    }
}

// Namespace zodt8_sentinel/zm_zodt8_sentinel_trial
// Params 7, eflags: 0x0
// Checksum 0x23b26c68, Offset: 0x1708
// Size: 0x16a
function function_6f16e3fe(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        self util::waittill_dobj(localclientnum);
        while (isdefined(self)) {
            n_x_move = randomintrange(-64, 64);
            var_c51a03cf = randomintrange(-64, 64);
            var_b3413122 = randomintrange(-64, 64);
            self moveto(self.origin + (n_x_move, var_c51a03cf, var_b3413122), randomintrange(10, 20));
            s_result = self waittill(#"movedone", #"death");
            if (s_result._notify == "death") {
                return;
            }
        }
    }
}

// Namespace zodt8_sentinel/zm_zodt8_sentinel_trial
// Params 7, eflags: 0x0
// Checksum 0xb57b2b1c, Offset: 0x1880
// Size: 0x236
function function_98c019e5(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        a_s_locs = struct::get_array(#"water_corpse");
        foreach (s_loc in a_s_locs) {
            n_x_offset = randomintrange(-32, 32);
            n_y_offset = randomintrange(-32, 32);
            physicsexplosionsphere(localclientnum, s_loc.origin + (n_x_offset, n_y_offset, 32), 64, 32, 0.15, undefined, undefined, 1, 1, 1);
            waitframe(1);
        }
        s_loc = struct::get(#"hash_1f307b5cf6d83aff");
        for (n_z_offset = 400; level flag::get(#"hash_13dc8f128d50bada"); n_z_offset *= -1) {
            physicsexplosionsphere(localclientnum, s_loc.origin + (0, 0, n_z_offset), 3200, 32, 0.1, undefined, undefined, 1, 1, 1);
            wait randomintrange(3, 6);
        }
    }
}

// Namespace zodt8_sentinel/zm_zodt8_sentinel_trial
// Params 1, eflags: 0x0
// Checksum 0x68ce2d54, Offset: 0x1ac0
// Size: 0xf6
function function_777e8c2d(localclientnum) {
    self endon(#"leaving_iceberg");
    waitframe(1);
    while (isalive(self)) {
        n_speed = self getspeed();
        if (n_speed > 64) {
            n_radius = max(64, n_speed * 0.7);
        } else {
            n_radius = 64;
        }
        n_magnitude = n_radius / 80;
        physicsexplosionsphere(localclientnum, self geteye(), n_radius, n_radius, n_magnitude);
        waitframe(1);
    }
}

// Namespace zodt8_sentinel/zm_zodt8_sentinel_trial
// Params 7, eflags: 0x0
// Checksum 0xc06ef39e, Offset: 0x1bc0
// Size: 0x28c
function function_35279ce6(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self notify(#"underwaterwatchbegin");
    if (newval) {
        self thread function_777e8c2d(localclientnum);
        level flag::set(#"hash_13dc8f128d50bada");
        setdvar(#"phys_gravity_dir", (0, 0, 0.005));
        self thread function_a827dd95(localclientnum);
        self notify(#"hash_6aa4f28f27ab4c64");
        do {
            waitframe(1);
        } while (postfx::function_7348f3a5(#"pstfx_zm_wormhole"));
        n_val = 0.1;
        self thread postfx::playpostfxbundle(#"pstfx_frost_loop");
        while (n_val <= 0.33) {
            self function_202a8b08(#"pstfx_frost_loop", "Reveal Threshold", n_val);
            wait 0.25;
            n_val += 0.01;
        }
        return;
    }
    setdvar(#"phys_gravity_dir", (0, 0, 1));
    level flag::clear(#"hash_13dc8f128d50bada");
    self notify(#"leaving_iceberg");
    if (self util::function_162f7df2(localclientnum)) {
        if (isdefined(self.firstperson_water_fx)) {
            stopfx(localclientnum, self.firstperson_water_fx);
            self.firstperson_water_fx = undefined;
        }
        self thread water_surface::underwaterwatchbegin();
    }
    self postfx::stoppostfxbundle(#"pstfx_frost_loop");
}

// Namespace zodt8_sentinel/zm_zodt8_sentinel_trial
// Params 1, eflags: 0x0
// Checksum 0x29494248, Offset: 0x1e58
// Size: 0x138
function function_a827dd95(localclientnum) {
    self endon(#"underwaterwatchbegin");
    s_result = self waittill(#"underwater_begin", #"death");
    if (s_result._notify == "underwater_begin") {
        while (isalive(self)) {
            if (self util::function_162f7df2(localclientnum)) {
                self.firstperson_water_fx = playfxoncamera(localclientnum, level._effect[#"hash_215b5515b4582919"], (0, 0, 0), (1, 0, 0), (0, 0, 1));
                self.var_838b5cc4 = playfxoncamera(localclientnum, level._effect[#"hash_1e7095084eda811c"], (0, 0, 0), (1, 0, 0), (0, 0, 1));
            }
            wait randomintrange(15, 20);
        }
    }
}

// Namespace zodt8_sentinel/zm_zodt8_sentinel_trial
// Params 7, eflags: 0x0
// Checksum 0x7348e6c, Offset: 0x1f98
// Size: 0xb0
function function_37f83aae(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (!self postfx::function_7348f3a5(#"pstfx_frost_loop")) {
        self thread postfx::playpostfxbundle(#"pstfx_frost_loop");
        self thread function_d745b7c6();
        waitframe(1);
    }
    level notify(#"hash_5010527c7518e767");
}

// Namespace zodt8_sentinel/zm_zodt8_sentinel_trial
// Params 0, eflags: 0x0
// Checksum 0x29cfbc2c, Offset: 0x2050
// Size: 0x174
function function_d745b7c6() {
    self endon(#"hash_6aa4f28f27ab4c64");
    n_val = 0.1;
    while (true) {
        s_result = level waittilltimeout(20, #"hash_5010527c7518e767");
        if (isalive(self) && s_result._notify == #"hash_5010527c7518e767") {
            self function_202a8b08(#"pstfx_frost_loop", "Reveal Threshold", n_val);
            n_val += 0.1;
            if (n_val > 1) {
                break;
            }
            continue;
        }
        break;
    }
    waitframe(1);
    n_val -= 0.1;
    while (n_val > 0) {
        self function_202a8b08(#"pstfx_frost_loop", "Reveal Threshold", n_val);
        n_val -= 0.1;
        wait 3;
    }
    self postfx::stoppostfxbundle(#"pstfx_frost_loop");
}

// Namespace zodt8_sentinel/zm_zodt8_sentinel_trial
// Params 7, eflags: 0x0
// Checksum 0xd1d65de3, Offset: 0x21d0
// Size: 0x12c
function teleport_sigil(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (isdefined(self.var_875fa1a8)) {
        killfx(localclientnum, self.var_875fa1a8);
        self.var_875fa1a8 = undefined;
    }
    if (newval == 1) {
        self.var_875fa1a8 = playfx(localclientnum, level._effect[#"sigil_off"], self.origin, (1, 0, 0));
    } else {
        self.var_875fa1a8 = playfx(localclientnum, level._effect[#"sigil_on"], self.origin, (1, 0, 0));
    }
    level thread function_39ada4a9(localclientnum, self, self.var_875fa1a8);
}

// Namespace zodt8_sentinel/zm_zodt8_sentinel_trial
// Params 3, eflags: 0x0
// Checksum 0x940a6292, Offset: 0x2308
// Size: 0x6c
function function_39ada4a9(localclientnum, e_sigil, var_875fa1a8) {
    self notify("16cf8444d5e59b9");
    self endon("16cf8444d5e59b9");
    e_sigil waittill(#"death");
    if (isdefined(var_875fa1a8)) {
        killfx(localclientnum, var_875fa1a8);
    }
}

// Namespace zodt8_sentinel/zm_zodt8_sentinel_trial
// Params 7, eflags: 0x0
// Checksum 0xdb48255e, Offset: 0x2380
// Size: 0x20a
function pipe_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (isdefined(self.var_f059df00)) {
        stopfx(localclientnum, self.var_f059df00);
    }
    if (isdefined(self.var_fe6a8073)) {
        self stoploopsound(self.var_fe6a8073);
    }
    if (newval == 1) {
        self.var_f059df00 = util::playfxontag(localclientnum, level._effect[#"hash_5c7f484e340fdde6"], self, "tag_origin");
        self.var_fe6a8073 = self playloopsound(#"hash_1d4b0119c9f1d519");
        return;
    }
    if (newval == 2) {
        self.var_f059df00 = util::playfxontag(localclientnum, level._effect[#"hash_331f4a597e6c0189"], self, "tag_origin");
        self playsound(localclientnum, #"hash_581cce02962580b7");
        self.var_fe6a8073 = self playloopsound(#"hash_5518d837f78963fc");
        return;
    }
    self.var_f059df00 = util::playfxontag(localclientnum, level._effect[#"hash_345b045ea57a58e8"], self, "tag_origin");
    self.var_fe6a8073 = self playloopsound(#"hash_5557e7b7271b8aff");
}

// Namespace zodt8_sentinel/zm_zodt8_sentinel_trial
// Params 7, eflags: 0x0
// Checksum 0x1a8addab, Offset: 0x2598
// Size: 0xe4
function function_5eb1c6e(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self endon(#"death");
    self util::waittill_dobj(localclientnum);
    if (newval == 1) {
        self.fx_iceberg = util::playfxontag(localclientnum, level._effect[#"hash_3316f2b0a2dcecda"], self, "tag_origin");
        return;
    }
    if (isdefined(self.fx_iceberg)) {
        stopfx(localclientnum, self.fx_iceberg);
    }
}

// Namespace zodt8_sentinel/zm_zodt8_sentinel_trial
// Params 7, eflags: 0x0
// Checksum 0x293e58b2, Offset: 0x2688
// Size: 0x30c
function function_353cc4da(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (isdefined(self.var_8b16d7c7)) {
        stopfx(localclientnum, self.var_8b16d7c7);
        self.var_8b16d7c7 = undefined;
    }
    if (newval == 1) {
        self.var_903dbf5 = util::playfxontag(localclientnum, level._effect[#"ice_blocker"], self, "tag_origin");
        self playsound(localclientnum, #"hash_3f083cd717314926");
        if (!isdefined(self.var_5f8d0f58)) {
            self.var_5f8d0f58 = self playloopsound(#"hash_cbff0b64fa402d7");
        }
        return;
    }
    if (newval == 2) {
        self playsound(localclientnum, #"hash_1892310a436314b2");
        self.var_8b16d7c7 = util::playfxontag(localclientnum, level._effect[#"hash_53533bf74eb74209"], self, "tag_origin");
        return;
    }
    if (newval == 3) {
        self playsound(localclientnum, #"hash_1892310a436314b2");
        self.var_8b16d7c7 = util::playfxontag(localclientnum, level._effect[#"hash_535338f74eb73cf0"], self, "tag_origin");
        return;
    }
    if (isdefined(self.var_903dbf5)) {
        killfx(localclientnum, self.var_903dbf5);
        self.var_903dbf5 = undefined;
    }
    if (isdefined(self.var_5f8d0f58)) {
        self stoploopsound(self.var_5f8d0f58);
    }
    self playsound(localclientnum, #"hash_28d76e47e3d57bf6");
    util::playfxontag(localclientnum, level._effect[#"hash_535338f74eb73cf0"], self, "p8_zm_zod_ice_block_mq_dmg_03");
    util::playfxontag(localclientnum, level._effect[#"hash_452505f92d084e74"], self, "p8_zm_zod_ice_block_mq_dmg_03");
}

// Namespace zodt8_sentinel/zm_zodt8_sentinel_trial
// Params 7, eflags: 0x0
// Checksum 0x3abfc4da, Offset: 0x29a0
// Size: 0x84
function function_1267d421(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        self thread postfx::playpostfxbundle("pstfx_zodt8_screenflash");
        return;
    }
    self thread postfx::stoppostfxbundle("pstfx_zodt8_screenflash");
}

// Namespace zodt8_sentinel/zm_zodt8_sentinel_trial
// Params 7, eflags: 0x0
// Checksum 0xed76b729, Offset: 0x2a30
// Size: 0x9c
function function_a8508bf8(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        self playrumbleonentity(localclientnum, #"hash_67ca45018833af1d");
        return;
    }
    self playrumbleonentity(localclientnum, #"hash_55b8ea7312be930e");
}

// Namespace zodt8_sentinel/zm_zodt8_sentinel_trial
// Params 7, eflags: 0x0
// Checksum 0xaaad2f05, Offset: 0x2ad8
// Size: 0xcc
function function_ba89220(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        fx = util::playfxontag(localclientnum, level._effect[#"glyph_activate"], self, "tag_origin");
        playsound(localclientnum, #"hash_6dfc68e5f7739824", self.origin);
        wait 3.5;
        stopfx(localclientnum, fx);
    }
}

// Namespace zodt8_sentinel/zm_zodt8_sentinel_trial
// Params 7, eflags: 0x0
// Checksum 0x4fe8cdec, Offset: 0x2bb0
// Size: 0x19e
function function_f30f0212(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        v_forward = anglestoforward(self.angles);
        self.blocker_fx = playfx(localclientnum, level._effect[#"catalyst_blocker"], self.origin, v_forward);
        if (!isdefined(self.var_47c23175)) {
            self playsound(localclientnum, #"hash_2c71df73b17cd28a");
            self.var_47c23175 = self playloopsound(#"hash_7e4a7312ab58161e");
        }
        return;
    }
    if (isdefined(self.blocker_fx)) {
        stopfx(localclientnum, self.blocker_fx);
    }
    if (isdefined(self.var_47c23175)) {
        self playsound(localclientnum, #"hash_3366b1b903dc96bf");
        self stoploopsound(self.var_47c23175);
        self.var_47c23175 = undefined;
    }
}

// Namespace zodt8_sentinel/zm_zodt8_sentinel_trial
// Params 7, eflags: 0x0
// Checksum 0x4a6fe2e7, Offset: 0x2d58
// Size: 0xbe
function function_fe2e366d(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        self.var_1f55a1cd = util::playfxontag(localclientnum, level._effect[#"packed_artifact"], self, "tag_origin");
        return;
    }
    if (isdefined(self.var_1f55a1cd)) {
        stopfx(localclientnum, self.var_1f55a1cd);
        self.var_1f55a1cd = undefined;
    }
}

// Namespace zodt8_sentinel/zm_zodt8_sentinel_trial
// Params 7, eflags: 0x0
// Checksum 0x714bc351, Offset: 0x2e20
// Size: 0xec
function function_6b349f37(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    b_underwater = self isplayerswimmingunderwater();
    if (newval) {
        self thread postfx::playpostfxbundle(#"hash_5513ce472ffeb0f3");
        if (!b_underwater) {
            setpbgactivebank(localclientnum, 4);
        }
        return;
    }
    if (!b_underwater) {
        setpbgactivebank(localclientnum, 1);
    }
    self postfx::stoppostfxbundle(#"hash_5513ce472ffeb0f3");
}

// Namespace zodt8_sentinel/zm_zodt8_sentinel_trial
// Params 7, eflags: 0x0
// Checksum 0xbac76bd5, Offset: 0x2f18
// Size: 0xe4
function function_7184171e(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        util::playfxontag(localclientnum, level._effect[#"hash_23c18b717592a89d"], self, "tag_origin");
        function_d2913e3e(localclientnum, #"zm_zodt8_planet_impact");
        return;
    }
    playfx(localclientnum, level._effect[#"hash_2bb182b164a2d789"], self.origin);
}

// Namespace zodt8_sentinel/zm_zodt8_sentinel_trial
// Params 7, eflags: 0x0
// Checksum 0x2d07cd79, Offset: 0x3008
// Size: 0x1f6
function function_5ee38b92(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        self endon(#"death");
        self util::waittill_dobj(localclientnum);
        util::playfxontag(localclientnum, level._effect[#"hash_4274dc30c3876166"], self, "tag_origin");
        if (self.origin[2] < 2000) {
            self.var_d0987664 = util::playfxontag(localclientnum, level._effect[#"hash_2dd4629ae81753e5"], self, "tag_origin");
        } else {
            self.var_d0987664 = util::playfxontag(localclientnum, level._effect[#"orb_essence"], self, "tag_origin");
        }
        self.n_fx_trail = util::playfxontag(localclientnum, level._effect[#"orb_trail"], self, "tag_origin");
        return;
    }
    if (isdefined(self.var_d0987664)) {
        killfx(localclientnum, self.var_d0987664);
        self.var_d0987664 = undefined;
    }
    if (isdefined(self.n_fx_trail)) {
        killfx(localclientnum, self.n_fx_trail);
        self.n_fx_trail = undefined;
    }
}

// Namespace zodt8_sentinel/zm_zodt8_sentinel_trial
// Params 7, eflags: 0x0
// Checksum 0xe032a4e9, Offset: 0x3208
// Size: 0x2e4
function function_1fd94860(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (isdefined(self.var_a74c765d)) {
        killfx(localclientnum, self.var_a74c765d);
    }
    if (newval == 0) {
        playsound(localclientnum, #"hash_5dea4034a9243dbc", self.origin);
        return;
    }
    switch (newval) {
    case 1:
        str_fx = #"loc_sun";
        break;
    case 2:
        str_fx = #"loc_mercury";
        break;
    case 3:
        str_fx = #"loc_venus";
        break;
    case 4:
        str_fx = #"loc_moon";
        break;
    case 5:
        str_fx = #"loc_mars";
        break;
    case 6:
        str_fx = #"loc_jupiter";
        break;
    case 7:
        str_fx = #"loc_saturn";
        break;
    case 8:
        str_fx = #"loc_uranus";
        break;
    case 9:
        str_fx = #"loc_neptune";
        break;
    }
    str_tag = struct::get(str_fx).str_tag_name;
    self.var_a74c765d = util::playfxontag(localclientnum, level._effect[str_fx], self, str_tag);
    if (newval == 1) {
        playsound(localclientnum, #"hash_5b84a753cb771ae0", self.origin);
        return;
    }
    playsound(localclientnum, #"hash_6be991aa330022ca", self.origin);
}

// Namespace zodt8_sentinel/zm_zodt8_sentinel_trial
// Params 7, eflags: 0x0
// Checksum 0xf8e5ec6b, Offset: 0x34f8
// Size: 0x1e4
function function_2d5c42af(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self endon(#"stop_shader");
    n_pulse = 0.4;
    while (isdefined(self)) {
        n_cycle_time = randomfloatrange(2, 8);
        n_pulse_increment = (1 - 0.4) / n_cycle_time / 0.1;
        while (n_pulse < 1 && isdefined(self)) {
            self mapshaderconstant(0, 0, "scriptVector0", 1, n_pulse, 0, 0);
            n_pulse += n_pulse_increment;
            wait 0.1;
        }
        n_cycle_time = randomfloatrange(2, 8);
        n_pulse_increment = (1 - 0.4) / n_cycle_time / 0.1;
        while (0.4 < n_pulse && isdefined(self)) {
            self mapshaderconstant(0, 0, "scriptVector0", 1, n_pulse, 0, 0);
            n_pulse -= n_pulse_increment;
            wait 0.1;
        }
    }
}

// Namespace zodt8_sentinel/zm_zodt8_sentinel_trial
// Params 7, eflags: 0x0
// Checksum 0x91373bfb, Offset: 0x36e8
// Size: 0x158
function function_a01755d4(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self notify("75002cc5144446d8");
    self endon("75002cc5144446d8");
    if (newval == 1) {
        util::playfxontag(localclientnum, level._effect[#"tree_activate"], self, "tag_origin");
        self playsound(localclientnum, #"hash_35bdc93fbbad3294");
        self.var_7d8b8c7 = self playloopsound(#"hash_453bd80432d8f383");
        wait 0.25;
        while (true) {
            physicsexplosionsphere(localclientnum, self.origin, 3000, 1, 4, 1, 1, 1, 1, 1);
            waitframe(randomintrange(5, 10));
        }
    }
}

// Namespace zodt8_sentinel/zm_zodt8_sentinel_trial
// Params 7, eflags: 0x0
// Checksum 0xa3a6ab4, Offset: 0x3848
// Size: 0x134
function function_c230af71(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        util::playfxontag(localclientnum, level._effect[#"tree_trail"], self, "tag_origin");
        self playsound(localclientnum, #"hash_c5737dedcdad3a8");
        return;
    }
    util::playfxontag(localclientnum, level._effect[#"tree_impact"], self, "tag_origin");
    self playsound(localclientnum, #"hash_3d9dcef3d979480b");
    function_d2913e3e(localclientnum, #"zm_zodt8_planet_impact");
}

// Namespace zodt8_sentinel/zm_zodt8_sentinel_trial
// Params 7, eflags: 0x0
// Checksum 0x55414d08, Offset: 0x3988
// Size: 0x84
function function_bdc4f2c6(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        function_a419c9f1(localclientnum, "ee_space");
        return;
    }
    function_9fb45cd8(localclientnum, "ee_space");
}

