#using scripts\core_common\array_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\util_shared;

#namespace archetype_damage_effects;

// Namespace archetype_damage_effects
// Method(s) 2 Total 2
class class_54692904 {

    var shaderconst;
    var tags;

    // Namespace class_54692904/archetype_damage_effects
    // Params 0, eflags: 0x8
    // Checksum 0x81c530a6, Offset: 0x1220
    // Size: 0x1e
    constructor() {
        tags = [];
        shaderconst = 0;
    }

}

// Namespace archetype_damage_effects/archetype_damage_effects
// Params 0, eflags: 0x2
// Checksum 0xde77990, Offset: 0x220
// Size: 0x24
function autoexec main() {
    registerclientfields();
    loadeffects();
}

// Namespace archetype_damage_effects/archetype_damage_effects
// Params 0, eflags: 0x0
// Checksum 0xaafd6a9b, Offset: 0x250
// Size: 0x94
function registerclientfields() {
    clientfield::register("actor", "arch_actor_fire_fx", 1, 2, "int", &actor_fire_fx_state, 0, 0);
    clientfield::register("actor", "arch_actor_char", 1, 2, "int", &actor_char, 0, 0);
}

// Namespace archetype_damage_effects/archetype_damage_effects
// Params 0, eflags: 0x0
// Checksum 0x3d7aebef, Offset: 0x2f0
// Size: 0xccc
function loadeffects() {
    level._effect[#"fire_robot_j_elbow_le_rot_loop"] = #"fire/fx_fire_ai_robot_arm_left_loop";
    level._effect[#"fire_robot_j_elbow_ri_rot_loop"] = #"fire/fx_fire_ai_robot_arm_right_loop";
    level._effect[#"fire_robot_j_shoulder_le_rot_loop"] = #"fire/fx_fire_ai_robot_arm_left_loop";
    level._effect[#"fire_robot_j_shoulder_ri_rot_loop"] = #"fire/fx_fire_ai_robot_arm_right_loop";
    level._effect[#"fire_robot_j_spine4_loop"] = #"fire/fx_fire_ai_robot_torso_loop";
    level._effect[#"fire_robot_j_knee_le_loop"] = #"fire/fx_fire_ai_robot_leg_left_loop";
    level._effect[#"fire_robot_j_knee_ri_loop"] = #"fire/fx_fire_ai_robot_leg_right_loop";
    level._effect[#"fire_robot_j_head_loop"] = #"fire/fx_fire_ai_robot_head_loop";
    level._effect[#"fire_robot_j_elbow_le_rot_os"] = #"fire/fx_fire_ai_robot_arm_left_os";
    level._effect[#"fire_robot_j_elbow_ri_rot_os"] = #"fire/fx_fire_ai_robot_arm_right_os";
    level._effect[#"fire_robot_j_shoulder_le_rot_os"] = #"fire/fx_fire_ai_robot_arm_left_os";
    level._effect[#"fire_robot_j_shoulder_ri_rot_os"] = #"fire/fx_fire_ai_robot_arm_right_os";
    level._effect[#"fire_robot_j_spine4_os"] = #"fire/fx_fire_ai_robot_torso_os";
    level._effect[#"fire_robot_j_knee_le_os"] = #"fire/fx_fire_ai_robot_leg_left_os";
    level._effect[#"fire_robot_j_knee_ri_os"] = #"fire/fx_fire_ai_robot_leg_right_os";
    level._effect[#"fire_robot_j_head_os"] = #"fire/fx_fire_ai_robot_head_os";
    level.var_b19ce09b = [];
    level.var_b19ce09b[#"mp_dog"] = [];
    level.var_b19ce09b[#"mp_dog"][#"hash_3cf96a0aa8ac919"] = #"fire/fx_fire_ai_human_arm_left_loop";
    level.var_b19ce09b[#"mp_dog"][#"hash_66d60e2138e4f152"] = #"fire/fx_fire_ai_human_arm_left_loop";
    level.var_b19ce09b[#"mp_dog"][#"hash_213857ac6d630ed3"] = #"fire/fx_fire_ai_human_arm_left_loop";
    level.var_b19ce09b[#"mp_dog"][#"hash_6f9163ebf3baeee4"] = #"fire/fx_fire_ai_human_arm_left_loop";
    level.var_b19ce09b[#"mp_dog"][#"hash_67bbf1ab610115b4"] = #"fire/fx_fire_ai_human_arm_left_loop";
    level.var_b19ce09b[#"mp_dog"][#"hash_64c72f1dfecd290c"] = #"fire/fx_fire_ai_human_arm_left_loop";
    level.var_b19ce09b[#"mp_dog"][#"hash_2a4e6916c0772dca"] = #"fire/fx_fire_ai_human_arm_left_loop";
    level.var_b19ce09b[#"mp_dog"][#"hash_64c1f4459de5c8a2"] = #"fire/fx_fire_ai_human_arm_left_loop";
    level.var_b19ce09b[#"human"] = [];
    level.var_b19ce09b[#"human"][#"fire_j_elbow_le_loop"] = #"fire/fx_fire_ai_human_arm_left_loop";
    level.var_b19ce09b[#"human"][#"fire_j_elbow_ri_loop"] = #"fire/fx_fire_ai_human_arm_right_loop";
    level.var_b19ce09b[#"human"][#"fire_j_shoulder_le_loop"] = #"fire/fx_fire_ai_human_arm_left_loop";
    level.var_b19ce09b[#"human"][#"fire_j_shoulder_ri_loop"] = #"fire/fx_fire_ai_human_arm_right_loop";
    level.var_b19ce09b[#"human"][#"fire_j_spine4_loop"] = #"fire/fx_fire_ai_human_torso_loop";
    level.var_b19ce09b[#"human"][#"fire_j_hip_le_loop"] = #"fire/fx_fire_ai_human_hip_left_loop";
    level.var_b19ce09b[#"human"][#"fire_j_hip_ri_loop"] = #"fire/fx_fire_ai_human_hip_right_loop";
    level.var_b19ce09b[#"human"][#"fire_j_head_loop"] = #"fire/fx_fire_ai_human_head_loop";
    level.var_b19ce09b[#"human"][#"fire_j_knee_le_os"] = #"fire/fx_fire_ai_human_leg_left_os";
    level.var_b19ce09b[#"human"][#"fire_j_knee_ri_os"] = #"fire/fx_fire_ai_human_leg_right_os";
    level.var_b19ce09b[#"human"][#"fire_j_elbow_le_os"] = #"fire/fx_fire_ai_human_arm_left_os";
    level.var_b19ce09b[#"human"][#"fire_j_elbow_ri_os"] = #"fire/fx_fire_ai_human_arm_right_os";
    level.var_b19ce09b[#"human"][#"fire_j_shoulder_le_os"] = #"fire/fx_fire_ai_human_arm_left_os";
    level.var_b19ce09b[#"human"][#"fire_j_shoulder_ri_os"] = #"fire/fx_fire_ai_human_arm_right_os";
    level.var_b19ce09b[#"human"][#"fire_j_spine4_os"] = #"fire/fx_fire_ai_human_torso_os";
    level.var_b19ce09b[#"human"][#"fire_j_hip_le_os"] = #"fire/fx_fire_ai_human_hip_left_os";
    level.var_b19ce09b[#"human"][#"fire_j_hip_ri_os"] = #"fire/fx_fire_ai_human_hip_right_os";
    level.var_b19ce09b[#"human"][#"fire_j_head_os"] = #"fire/fx_fire_ai_human_head_os";
    level.var_b19ce09b[#"human"][#"fire_j_knee_le_os"] = #"fire/fx_fire_ai_human_leg_left_os";
    level.var_b19ce09b[#"human"][#"fire_j_knee_ri_os"] = #"fire/fx_fire_ai_human_leg_right_os";
    level.var_b19ce09b[#"human"][#"hash_38690ef2c303b981"] = #"smoke/fx_smk_ai_human_arm_left_os";
    level.var_b19ce09b[#"human"][#"hash_1b8ec036e64264e3"] = #"smoke/fx_smk_ai_human_arm_right_os";
    level.var_b19ce09b[#"human"][#"hash_93987513d9fcf74"] = #"smoke/fx_smk_ai_human_arm_left_os";
    level.var_b19ce09b[#"human"][#"hash_4120bed5ccbd9ada"] = #"hash_508a2d8945b9a938";
    level.var_b19ce09b[#"human"][#"hash_2956a5ac1199cb6f"] = #"smoke/fx_smk_ai_human_torso_os";
    level.var_b19ce09b[#"human"][#"hash_5156e6a4093a5ef7"] = #"smoke/fx_smk_ai_human_hip_left_os";
    level.var_b19ce09b[#"human"][#"hash_577af0103b54f9d5"] = #"smoke/fx_smk_ai_human_hip_right_os";
    level.var_b19ce09b[#"human"][#"hash_90fd448cc5848d6"] = #"smoke/fx_smk_ai_human_head_os";
    level.var_b19ce09b[#"human"][#"hash_1c2f6725995eb16b"] = #"smoke/fx_smk_ai_human_leg_left_os";
    level.var_b19ce09b[#"human"][#"hash_101185c328f39789"] = #"smoke/fx_smk_ai_human_leg_right_os";
}

// Namespace archetype_damage_effects/archetype_damage_effects
// Params 4, eflags: 0x4
// Checksum 0xba4447b, Offset: 0xfc8
// Size: 0xdc
function private _burntag(localclientnum, tag, postfix, prefix) {
    if (isdefined(self) && self hasdobj(localclientnum)) {
        fx_to_play = undefined;
        if (isdefined(level.var_b19ce09b) && isdefined(level.var_b19ce09b[self.archetype])) {
            fxitem = prefix + tag + postfix;
            fx_to_play = level.var_b19ce09b[self.archetype][fxitem];
            if (isdefined(fx_to_play)) {
                return util::playfxontag(localclientnum, fx_to_play, self, tag);
            }
        }
    }
}

// Namespace archetype_damage_effects/archetype_damage_effects
// Params 4, eflags: 0x4
// Checksum 0x71ec8ed4, Offset: 0x10b0
// Size: 0x166
function private _burnstage(localclientnum, tagarray, shouldwait, prefix) {
    if (!isdefined(self)) {
        return;
    }
    self endon(#"death");
    if (!isdefined(prefix)) {
        prefix = "fire_";
    }
    tags = array::randomize(tagarray);
    for (i = 1; i < tags.size; i++) {
        if (tags[i] == "null") {
            continue;
        }
        self.activefx[self.activefx.size] = self _burntag(localclientnum, tags[i], shouldwait ? "_loop" : "_os", prefix);
        if (shouldwait) {
            wait randomfloatrange(0.1, 0.3);
        }
    }
    if (shouldwait) {
        wait randomfloatrange(0, 1);
    }
    if (isdefined(self)) {
        self notify(#"burn_stage_finished");
    }
}

// Namespace archetype_damage_effects/archetype_damage_effects
// Params 2, eflags: 0x4
// Checksum 0xc372c7ac, Offset: 0x12e8
// Size: 0x4ee
function private _burnbody(localclientnum, prefix) {
    self endon(#"death");
    timer = 10;
    bonemodifier = "";
    if (self.archetype == "robot") {
        bonemodifier = "_rot";
        timer = 6;
    }
    if (!isdefined(prefix)) {
        prefix = "fire_";
    }
    var_e9b8dbbc = [];
    if (self.archetype == "mp_dog") {
        var_305978ec = new class_54692904();
        var_305978ec.tags = array("tag_thigh_str_drvr_le", "tag_thigh_stretch_le", "tag_thigh_str_drvr_ri", "tag_thigh_stretch_ri", "tag_shldr_str_drvr_le", "tag_shoulder_stretch_le", "tag_shldr_str_drvr_ri", "tag_shoulder_stretch_ri");
        array::add(var_e9b8dbbc, var_305978ec);
    } else {
        var_305978ec = new class_54692904();
        var_305978ec.tags = array("j_elbow_le" + bonemodifier, "j_elbow_ri" + bonemodifier, "null");
        var_305978ec.shaderconst = 0.2;
        array::add(var_e9b8dbbc, var_305978ec);
        var_e496d3d3 = new class_54692904();
        var_e496d3d3.tags = array("j_shoulder_le" + bonemodifier, "j_shoulder_ri" + bonemodifier, "null");
        var_e496d3d3.shaderconst = 0.4;
        array::add(var_e9b8dbbc, var_e496d3d3);
        var_532125ca = new class_54692904();
        var_532125ca.tags = array("j_spine4", "null");
        var_532125ca.shaderconst = 0.6;
        array::add(var_e9b8dbbc, var_532125ca);
        var_85dde3e1 = new class_54692904();
        var_85dde3e1.tags = array("j_hip_le", "j_hip_ri", "j_head", "null");
        var_85dde3e1.shaderconst = 0.8;
        array::add(var_e9b8dbbc, var_85dde3e1);
        var_e55a31a8 = new class_54692904();
        var_e55a31a8.tags = array("j_knee_le", "j_knee_ri", "null");
        var_e55a31a8.shaderconst = 1;
        array::add(var_e9b8dbbc, var_e55a31a8);
    }
    maturemask = 0;
    if (util::is_mature()) {
        maturemask = 1;
    }
    self.activefx = [];
    foreach (var_90006c35 in var_e9b8dbbc) {
        self.activefx[self.activefx.size] = self thread _burnstage(localclientnum, var_90006c35.tags, 1, prefix);
        self mapshaderconstant(localclientnum, 0, "scriptVector0", maturemask * var_90006c35.shaderconst);
        self waittill(#"burn_stage_finished");
    }
}

// Namespace archetype_damage_effects/archetype_damage_effects
// Params 1, eflags: 0x0
// Checksum 0x979aac9e, Offset: 0x17e0
// Size: 0x6c
function sndstopburnloop(timer) {
    self waittilltimeout(timer, #"death", #"stopburningsounds");
    if (isdefined(self)) {
        if (isdefined(self.burn_loop_sound_handle)) {
            self stoploopsound(self.burn_loop_sound_handle);
        }
    }
}

// Namespace archetype_damage_effects/archetype_damage_effects
// Params 1, eflags: 0x4
// Checksum 0xfe0a6b2f, Offset: 0x1858
// Size: 0x3d6
function private _burncorpse(localclientnum) {
    self endon(#"death");
    timer = 10;
    bonemodifier = "";
    if (self.archetype == "robot") {
        bonemodifier = "_rot";
        timer = 3;
    }
    stage1burntags = array("j_elbow_le" + bonemodifier, "j_elbow_ri" + bonemodifier);
    stage2burntags = array("j_shoulder_le" + bonemodifier, "j_shoulder_ri" + bonemodifier);
    stage3burntags = array("j_spine4", "j_spinelower", "null");
    stage4burntags = array("j_hip_le", "j_hip_ri", "j_head");
    stage5burntags = array("j_knee_le", "j_knee_ri");
    self.burn_loop_sound_handle = self playloopsound(#"chr_burn_npc_loop1", 0.2);
    self thread sndstopburnloop(timer);
    self.activefx = [];
    self.activefx[self.activefx.size] = self thread _burnstage(localclientnum, stage1burntags, 0);
    self.activefx[self.activefx.size] = self thread _burnstage(localclientnum, stage2burntags, 0);
    self.activefx[self.activefx.size] = self thread _burnstage(localclientnum, stage3burntags, 0);
    self.activefx[self.activefx.size] = self thread _burnstage(localclientnum, stage4burntags, 0);
    self.activefx[self.activefx.size] = self thread _burnstage(localclientnum, stage5burntags, 0);
    maturemask = 0;
    if (util::is_mature()) {
        maturemask = 1;
    }
    self mapshaderconstant(localclientnum, 0, "scriptVector0", maturemask * 1);
    wait 20;
    if (isdefined(self)) {
        foreach (fx in self.activefx) {
            stopfx(localclientnum, fx);
            self notify(#"stopburningsounds");
        }
        if (isdefined(self)) {
            self.activefx = [];
        }
    }
}

// Namespace archetype_damage_effects/archetype_damage_effects
// Params 3, eflags: 0x0
// Checksum 0xdfb0399, Offset: 0x1c38
// Size: 0x17a
function actor_fire_fx(localclientnum, value, burningduration) {
    switch (value) {
    case 0:
        if (isdefined(self.activefx)) {
            self stopallloopsounds(1);
            foreach (fx in self.activefx) {
                stopfx(localclientnum, fx);
            }
        }
        self.activefx = [];
        break;
    case 1:
        self thread _burnbody(localclientnum);
        break;
    case 2:
        self thread _burnbody(localclientnum);
        break;
    case 3:
        self thread _burnbody(localclientnum, "smolder_");
        break;
    }
}

// Namespace archetype_damage_effects/archetype_damage_effects
// Params 7, eflags: 0x0
// Checksum 0x2535824c, Offset: 0x1dc0
// Size: 0x5c
function actor_fire_fx_state(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self actor_fire_fx(localclientnum, newval, 14);
}

// Namespace archetype_damage_effects/archetype_damage_effects
// Params 7, eflags: 0x0
// Checksum 0x924ea105, Offset: 0x1e28
// Size: 0x132
function actor_char(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    maturemask = 0;
    if (util::is_mature()) {
        maturemask = 1;
    }
    switch (newval) {
    case 1:
        self thread actorcharrampto(localclientnum, 1);
        break;
    case 0:
        self mapshaderconstant(localclientnum, 0, "scriptVector0", 0);
        break;
    case 2:
        self mapshaderconstant(localclientnum, 0, "scriptVector0", maturemask * 1);
        break;
    }
}

// Namespace archetype_damage_effects/archetype_damage_effects
// Params 2, eflags: 0x0
// Checksum 0xd092950, Offset: 0x1f68
// Size: 0x16c
function actorcharrampto(localclientnum, chardesired) {
    self endon(#"death");
    if (!isdefined(self.curcharlevel)) {
        self.curcharlevel = 0;
    }
    maturemask = 0;
    if (util::is_mature()) {
        maturemask = 1;
    }
    if (!isdefined(self.charsteps)) {
        assert(isdefined(chardesired));
        self.charsteps = int(200);
        delta = chardesired - self.curcharlevel;
        self.charinc = delta / self.charsteps;
    }
    while (self.charsteps) {
        self.curcharlevel = math::clamp(self.curcharlevel + self.charinc, 0, 1);
        self mapshaderconstant(localclientnum, 0, "scriptVector0", maturemask * self.curcharlevel);
        self.charsteps--;
        wait 0.01;
    }
}

