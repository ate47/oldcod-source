#using scripts\core_common\beam_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;

#namespace namespace_24fd6413;

// Namespace namespace_24fd6413/level_init
// Params 1, eflags: 0x40
// Checksum 0x6b95371f, Offset: 0x2e0
// Size: 0x28c
function event_handler[level_init] main(*eventstruct) {
    clientfield::register("scriptmover", "" + #"hash_502be00d1af105e9", 1, 1, "counter", &function_c6f8a4a0, 0, 0);
    clientfield::register("scriptmover", "" + #"hash_771abe419eda7442", 1, 1, "int", &function_10ea3e76, 0, 0);
    clientfield::register("scriptmover", "" + #"hash_38e22f5ceb9065c", 1, 2, "int", &function_e443c84c, 0, 0);
    clientfield::register("scriptmover", "" + #"hash_76d1986dfad6a190", 1, 2, "int", &function_55b89b40, 0, 0);
    clientfield::register("scriptmover", "" + #"hash_43aa7cec00d262aa", 1, 1, "int", &function_f9db1826, 0, 0);
    clientfield::register("scriptmover", "" + #"hash_582f769d593e00e0", 1, 1, "int", &function_293dff39, 0, 0);
    clientfield::register("actor", "" + #"hash_5342c00e940ad12b", 1, 1, "int", &function_bb5d646a, 0, 0);
    util::waitforclient(0);
}

// Namespace namespace_24fd6413/namespace_24fd6413
// Params 7, eflags: 0x0
// Checksum 0x8eea31c5, Offset: 0x578
// Size: 0x9c
function function_c6f8a4a0(localclientnum, *oldval, *newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    playfx(bwastimejump, "maps/zm_escape/fx8_brutus_transformation_shockwave", self.origin + (0, 0, 32), anglestoforward(self.angles), anglestoup(self.angles));
}

// Namespace namespace_24fd6413/namespace_24fd6413
// Params 7, eflags: 0x0
// Checksum 0xea82db6, Offset: 0x620
// Size: 0x204
function function_10ea3e76(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    if (bwastimejump == 1) {
        if (!isdefined(self.var_8999a4bf)) {
            self.var_8999a4bf = util::spawn_model(fieldname, "tag_origin", self.origin + (0, 0, 172));
        }
        if (!isdefined(self.var_f1b20bef)) {
            v_ground = self.origin + (400, 0, 0);
            self.var_f1b20bef = util::spawn_model(fieldname, "tag_origin", v_ground);
        }
        wait 0.1;
        self.var_f1b20bef linkto(self.var_8999a4bf);
        self beam::launch(self.var_f1b20bef, "tag_origin", self.var_8999a4bf, "tag_origin", "beam9_sr_objective_portal_corrupted", 1);
        self.var_8999a4bf rotateyaw(360, 4);
        self.var_8999a4bf waittill(#"rotatedone");
        self beam::kill(self.var_f1b20bef, "tag_origin", self.var_8999a4bf, "tag_origin", "beam9_sr_objective_portal_corrupted");
        self.var_f1b20bef delete();
        self.var_8999a4bf delete();
    }
}

// Namespace namespace_24fd6413/namespace_24fd6413
// Params 7, eflags: 0x0
// Checksum 0x2e8c82b, Offset: 0x830
// Size: 0x204
function function_bb5d646a(localclientnum, *oldval, *newval, *bnewent, *binitialsnap, *fieldname, *bwasdemojump) {
    self util::waittill_dobj(bwasdemojump);
    if (!isdefined(self) || !isdefined(self.origin)) {
        return;
    }
    capture_points = struct::get_array("capture_point", "targetname");
    capture_point = arraygetclosest(self.origin, capture_points);
    e_fx = util::spawn_model(bwasdemojump, "tag_origin", self gettagorigin("J_Spine4"));
    util::playfxontag(bwasdemojump, "zm_ai/fx8_zombie_soul_transfer", e_fx, "tag_origin");
    e_fx movez(40, 0.8);
    wait 0.75;
    n_time = distance(e_fx.origin, capture_point.origin) / 400;
    e_fx moveto(capture_point.origin, n_time);
    e_fx waittill(#"movedone");
    util::playfxontag(bwasdemojump, "zm_ai/fx8_nova_crawler_elec_projectile_impact", e_fx, "tag_origin");
    wait 0.3;
    e_fx delete();
}

// Namespace namespace_24fd6413/namespace_24fd6413
// Params 7, eflags: 0x0
// Checksum 0x1a117f5, Offset: 0xa40
// Size: 0xa4
function function_293dff39(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    if (bwastimejump == 1) {
        self.var_333158f2 = util::playfxontag(fieldname, "maps/zm_escape/fx8_brutus_energy_ball_white_bluish", self, "tag_origin");
        return;
    }
    if (isdefined(self.var_333158f2)) {
        stopfx(fieldname, self.var_333158f2);
    }
}

// Namespace namespace_24fd6413/namespace_24fd6413
// Params 7, eflags: 0x0
// Checksum 0xcd038b09, Offset: 0xaf0
// Size: 0xa4
function function_f9db1826(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    if (bwastimejump == 1) {
        self.var_3439fec0 = util::playfxontag(fieldname, "sr/fx9_drop_pod_ground_marker", self, "tag_origin");
        return;
    }
    if (isdefined(self.var_3439fec0)) {
        stopfx(fieldname, self.var_3439fec0);
    }
}

// Namespace namespace_24fd6413/namespace_24fd6413
// Params 7, eflags: 0x0
// Checksum 0x44696568, Offset: 0xba0
// Size: 0x284
function function_55b89b40(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    if (bwastimejump == 1) {
        self.var_7e405f09 = util::playfxontag(fieldname, "sr/fx9_drop_pod_smk_trail", self, "tag_origin");
        self playsound(fieldname, #"hash_6d7c85beb1d38b09");
        return;
    }
    if (bwastimejump == 2) {
        if (isdefined(self.var_7e405f09)) {
            stopfx(fieldname, self.var_7e405f09);
        }
        util::playfxontag(fieldname, "sr/fx9_drop_pod_impact", self, "tag_origin");
        self playsound(fieldname, #"hash_68b57d60b88fc4bc");
        if (isdefined(self.var_ad63d07b)) {
            self.var_ad63d07b delete();
        }
        return;
    }
    if (bwastimejump == 3) {
        if (isdefined(self.var_7e405f09)) {
            stopfx(fieldname, self.var_7e405f09);
        }
        self.var_ad63d07b = util::spawn_model(fieldname, "tag_origin", self.origin, self.angles + (90, 0, 0));
        self.var_ad63d07b linkto(self);
        self.var_7e405f09 = util::playfxontag(fieldname, "vehicle/fx9_jetfighter_thruster", self.var_ad63d07b, "tag_origin");
        return;
    }
    if (isdefined(self.var_7e405f09)) {
        stopfx(fieldname, self.var_7e405f09);
    }
    if (isdefined(self.var_ad63d07b)) {
        self.var_ad63d07b delete();
    }
}

// Namespace namespace_24fd6413/namespace_24fd6413
// Params 7, eflags: 0x0
// Checksum 0xbc01571e, Offset: 0xe30
// Size: 0x28c
function function_e443c84c(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    self endon(#"death");
    if (bwastimejump == 1) {
        self.n_id = util::playfxontag(fieldname, "sr/fx9_drop_pod_health_light_red", self, "tag_origin");
        self.n_sfx = self playloopsound(#"hash_52063b34095e6a61");
        return;
    }
    if (bwastimejump == 2) {
        if (isdefined(self.n_id)) {
            stopfx(fieldname, self.n_id);
        }
        self playsound(fieldname, #"hash_5dfa30eeaeb1af53");
        if (isdefined(self.n_sfx)) {
            self stoploopsound(self.n_sfx);
            self.n_sfx = undefined;
        }
        util::playfxontag(fieldname, "sr/fx9_drop_pod_exp_success_flash", self, "tag_hatch");
        while (isdefined(self) && isdefined(self.n_id)) {
            self playsound(fieldname, #"hash_2847596f1017cb69");
            self.n_id = util::playfxontag(fieldname, "sr/fx9_drop_pod_exp_success", self, "tag_origin");
            wait 0.5;
        }
        return;
    }
    if (bwastimejump == 3) {
        if (isdefined(self.n_id)) {
            stopfx(fieldname, self.n_id);
            self.n_id = undefined;
        }
        wait 0.1;
        self playsound(fieldname, #"hash_6605dba066e7cbc");
        util::playfxontag(fieldname, "sr/fx9_drop_pod_exp_success_os", self, "tag_origin");
    }
}

