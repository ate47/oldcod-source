#using scripts\core_common\aat_shared;
#using scripts\core_common\ai\systems\gib;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace ammomod_napalmburst;

// Namespace ammomod_napalmburst/ammomod_napalmburst
// Params 0, eflags: 0x1 linked
// Checksum 0xa9a755e6, Offset: 0x5e8
// Size: 0x5bc
function function_4e4244c1() {
    if (!is_true(level.aat_in_use)) {
        return;
    }
    aat::register("ammomod_napalmburst", #"zmui/zm_ammomod_napalmburst", "t7_icon_zm_aat_blast_furnace");
    aat::register("ammomod_napalmburst_1", #"zmui/zm_ammomod_napalmburst", "t7_icon_zm_aat_blast_furnace");
    aat::register("ammomod_napalmburst_2", #"zmui/zm_ammomod_napalmburst", "t7_icon_zm_aat_blast_furnace");
    aat::register("ammomod_napalmburst_3", #"zmui/zm_ammomod_napalmburst", "t7_icon_zm_aat_blast_furnace");
    aat::register("ammomod_napalmburst_4", #"zmui/zm_ammomod_napalmburst", "t7_icon_zm_aat_blast_furnace");
    aat::register("ammomod_napalmburst_5", #"zmui/zm_ammomod_napalmburst", "t7_icon_zm_aat_blast_furnace");
    clientfield::register("actor", "zm_ammomod_napalmburst_explosion", 1, 1, "counter", &function_c8e3a0dc, 0, 0);
    clientfield::register("vehicle", "zm_ammomod_napalmburst_explosion", 1, 1, "counter", &function_c8e3a0dc, 0, 0);
    clientfield::register("actor", "zm_ammomod_napalmburst_burn", 1, 1, "int", &function_f3b43353, 0, 0);
    clientfield::register("vehicle", "zm_ammomod_napalmburst_burn", 1, 1, "int", &function_2d64f265, 0, 0);
    function_c487d6b1(#"zombie", "zm_weapons/fx9_aat_burnination_lvl1_fire_zmb_arm_left", "j_shoulder_le", 32);
    function_c487d6b1(#"zombie", "zm_weapons/fx9_aat_burnination_lvl1_fire_zmb_arm_right", "j_shoulder_ri", 16);
    function_c487d6b1(#"zombie", "zm_weapons/fx9_aat_burnination_lvl1_fire_zmb_head", "j_head", 8);
    function_c487d6b1(#"zombie", "zm_weapons/fx9_aat_burnination_lvl1_fire_zmb_hip_left", "j_hip_le", 256);
    function_c487d6b1(#"zombie", "zm_weapons/fx9_aat_burnination_lvl1_fire_zmb_hip_right", "j_hip_ri", 128);
    function_c487d6b1(#"zombie", "zm_weapons/fx9_aat_burnination_lvl1_fire_zmb_leg_left", "j_knee_le", 256);
    function_c487d6b1(#"zombie", "zm_weapons/fx9_aat_burnination_lvl1_fire_zmb_leg_right", "j_knee_ri", 128);
    function_c487d6b1(#"zombie", "zm_weapons/fx9_aat_burnination_lvl1_fire_zmb_waist", "j_spinelower", undefined);
    function_c487d6b1(#"zombie", "zm_weapons/fx9_aat_burnination_lvl1_fire_zmb_torso", "j_spine4", undefined);
    function_c487d6b1(#"zombie_dog", "zm_weapons/fx9_aat_burnination_lvl1_fire_hound_torso", "j_spine4", undefined);
    function_c487d6b1(#"raz", "zm_weapons/fx9_aat_burnination_lvl1_fire_raz_hip_left", "j_hip_le", 256);
    function_c487d6b1(#"raz", "zm_weapons/fx9_aat_burnination_lvl1_fire_raz_hip_right", "j_hip_ri", 128);
    function_c487d6b1(#"raz", "zm_weapons/fx9_aat_burnination_lvl1_fire_raz_leg_left", "j_knee_le", 256);
    function_c487d6b1(#"raz", "zm_weapons/fx9_aat_burnination_lvl1_fire_raz_leg_right", "j_knee_ri", 128);
    function_c487d6b1(#"raz", "zm_weapons/fx9_aat_burnination_lvl1_fire_raz_waist", "j_spinelower", undefined);
    function_c487d6b1(#"raz", "zm_weapons/fx9_aat_burnination_lvl1_fire_raz_torso", "j_spine4", undefined);
}

// Namespace ammomod_napalmburst/ammomod_napalmburst
// Params 4, eflags: 0x1 linked
// Checksum 0x30898cac, Offset: 0xbb0
// Size: 0xc2
function function_c487d6b1(archetype, fx, joint, gibflag) {
    if (!isdefined(level.var_fd6cbce7)) {
        level.var_fd6cbce7 = [];
    }
    if (!isdefined(level.var_fd6cbce7[archetype])) {
        level.var_fd6cbce7[archetype] = [];
    }
    level.var_fd6cbce7[archetype][fx] = spawnstruct();
    level.var_fd6cbce7[archetype][fx].joint = joint;
    level.var_fd6cbce7[archetype][fx].gibflag = gibflag;
}

// Namespace ammomod_napalmburst/ammomod_napalmburst
// Params 7, eflags: 0x1 linked
// Checksum 0x706ca1b6, Offset: 0xc80
// Size: 0xd4
function function_c8e3a0dc(localclientnum, *oldval, *newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    if (isdefined(self)) {
        str_tag = isdefined(self gettagorigin("j_spine4")) ? "j_spine4" : "tag_origin";
        self playsound(bwastimejump, #"hash_26a0d9f48c9852ab");
        self util::playfxontag(bwastimejump, "zm_weapons/fx9_aat_burnination_lvl5_aoe", self, str_tag);
    }
}

// Namespace ammomod_napalmburst/ammomod_napalmburst
// Params 7, eflags: 0x1 linked
// Checksum 0x94487c8c, Offset: 0xd60
// Size: 0x74
function function_f3b43353(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    if (bwastimejump) {
        self function_a681160a(fieldname);
        return;
    }
    self function_725a593f(fieldname);
}

// Namespace ammomod_napalmburst/ammomod_napalmburst
// Params 7, eflags: 0x1 linked
// Checksum 0xeda1f3b6, Offset: 0xde0
// Size: 0x7c
function function_2d64f265(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    if (bwastimejump) {
        self function_a681160a(fieldname, 1);
        return;
    }
    self function_725a593f(fieldname);
}

// Namespace ammomod_napalmburst/ammomod_napalmburst
// Params 2, eflags: 0x1 linked
// Checksum 0xd6c2c98a, Offset: 0xe68
// Size: 0x32a
function function_a681160a(localclientnum, is_vehicle = 0) {
    if (is_vehicle) {
        str_tag = isdefined(self gettagorigin("tag_body")) ? "tag_body" : "tag_origin";
        self.var_b1312f24 = util::playfxontag(localclientnum, "zm_weapons/fx9_aat_burnination_lvl1_fire_zmb_torso", self, str_tag);
    } else if (!isdefined(self.var_9bdf44ae)) {
        self.var_9bdf44ae = [];
        if (isarray(level.var_fd6cbce7[self.archetype])) {
            foreach (i, fx in level.var_fd6cbce7[self.archetype]) {
                if (isdefined(fx.gibflag)) {
                    if (isdefined(self gettagorigin(fx.joint)) && !gibclientutils::isgibbed(localclientnum, self, fx.gibflag)) {
                        fxid = util::playfxontag(localclientnum, i, self, fx.joint);
                        if (!isdefined(self.var_9bdf44ae)) {
                            self.var_9bdf44ae = [];
                        } else if (!isarray(self.var_9bdf44ae)) {
                            self.var_9bdf44ae = array(self.var_9bdf44ae);
                        }
                        self.var_9bdf44ae[self.var_9bdf44ae.size] = fxid;
                    }
                    continue;
                }
                if (isdefined(self gettagorigin(fx.joint))) {
                    fxid = util::playfxontag(localclientnum, i, self, fx.joint);
                    if (!isdefined(self.var_9bdf44ae)) {
                        self.var_9bdf44ae = [];
                    } else if (!isarray(self.var_9bdf44ae)) {
                        self.var_9bdf44ae = array(self.var_9bdf44ae);
                    }
                    self.var_9bdf44ae[self.var_9bdf44ae.size] = fxid;
                }
            }
        }
    }
    if (!isdefined(self.var_428ce87c)) {
        self.var_428ce87c = self playloopsound(#"hash_eb5c7d29e54ca9c");
    }
}

// Namespace ammomod_napalmburst/ammomod_napalmburst
// Params 1, eflags: 0x1 linked
// Checksum 0x78fbef43, Offset: 0x11a0
// Size: 0xd2
function function_725a593f(localclientnum) {
    if (isdefined(self.var_428ce87c)) {
        self stoploopsound(self.var_428ce87c);
    }
    if (isdefined(self.var_9bdf44ae)) {
        foreach (fxid in self.var_9bdf44ae) {
            stopfx(localclientnum, fxid);
        }
        self.var_9bdf44ae = undefined;
    }
}

