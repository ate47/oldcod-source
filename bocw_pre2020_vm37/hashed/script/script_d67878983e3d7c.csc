#using scripts\core_common\array_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace namespace_9ff9f642;

// Namespace namespace_9ff9f642/namespace_9ff9f642
// Params 0, eflags: 0x6
// Checksum 0x8e6df78a, Offset: 0x120
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"hash_308dff40d53a7287", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace namespace_9ff9f642/namespace_9ff9f642
// Params 0, eflags: 0x5 linked
// Checksum 0xedb11a3, Offset: 0x168
// Size: 0x5c
function private function_70a657d8() {
    clientfield::register("actor", "" + #"hash_419c1c8da4dc53a9", 1, 1, "int", &function_f4515ba8, 0, 0);
}

// Namespace namespace_9ff9f642/namespace_9ff9f642
// Params 7, eflags: 0x1 linked
// Checksum 0xed997d56, Offset: 0x1d0
// Size: 0x1f2
function function_f4515ba8(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    if (bwastimejump) {
        str_tag = "j_spinelower";
        if (!isdefined(self gettagorigin(str_tag))) {
            str_tag = "tag_origin";
        }
        if (isdefined(level._effect) && isdefined(level._effect[#"character_fire_death_torso"])) {
            self.var_62f2a054 = util::playfxontag(fieldname, level._effect[#"character_fire_death_torso"], self, str_tag);
        }
        self thread function_8847b8aa(fieldname);
        self.var_2be01485 = undefined;
        return;
    }
    self notify(#"hash_395dfda1274cd506");
    if (isdefined(self.var_62f2a054)) {
        stopfx(fieldname, self.var_62f2a054);
        self.var_62f2a054 = undefined;
    }
    if (isdefined(self.var_803e161e)) {
        foreach (n_fx_id in self.var_803e161e) {
            stopfx(fieldname, n_fx_id);
        }
        self.var_803e161e = undefined;
    }
}

// Namespace namespace_9ff9f642/namespace_9ff9f642
// Params 1, eflags: 0x5 linked
// Checksum 0x4b541201, Offset: 0x3d0
// Size: 0x1f8
function private function_8847b8aa(localclientnum) {
    self endon(#"death", #"hash_395dfda1274cd506");
    wait 1;
    a_str_tags = [];
    a_str_tags[0] = "j_elbow_le";
    a_str_tags[1] = "j_elbow_ri";
    a_str_tags[2] = "j_knee_ri";
    a_str_tags[3] = "j_knee_le";
    a_str_tags = array::randomize(a_str_tags);
    self.var_803e161e = [];
    self.var_803e161e[0] = util::playfxontag(localclientnum, level._effect[#"character_fire_death_sm"], self, a_str_tags[0]);
    wait 1;
    a_str_tags[0] = "j_wrist_ri";
    a_str_tags[1] = "j_wrist_le";
    if (!is_true(self.missinglegs)) {
        a_str_tags[2] = "j_ankle_ri";
        a_str_tags[3] = "j_ankle_le";
    }
    a_str_tags = array::randomize(a_str_tags);
    self.var_803e161e[1] = util::playfxontag(localclientnum, level._effect[#"character_fire_death_sm"], self, a_str_tags[0]);
    self.var_803e161e[2] = util::playfxontag(localclientnum, level._effect[#"character_fire_death_sm"], self, a_str_tags[1]);
}

