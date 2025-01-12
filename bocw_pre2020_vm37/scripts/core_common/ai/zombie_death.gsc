#using scripts\core_common\ai\systems\gib;
#using scripts\core_common\array_shared;
#using scripts\core_common\fx_shared;

#namespace zombie_death;

// Namespace zombie_death/zombie_death
// Params 0, eflags: 0x1 linked
// Checksum 0x81f4df1, Offset: 0x138
// Size: 0x76
function on_fire_timeout() {
    self endon(#"death");
    if (isdefined(self.flame_fx_timeout)) {
        wait self.flame_fx_timeout;
    } else {
        wait 8;
    }
    if (isdefined(self) && isalive(self)) {
        self.is_on_fire = 0;
        self notify(#"stop_flame_damage");
    }
}

// Namespace zombie_death/zombie_death
// Params 0, eflags: 0x1 linked
// Checksum 0xc4c2b18b, Offset: 0x1b8
// Size: 0x42c
function flame_death_fx() {
    self endon(#"death");
    if (isdefined(self.is_on_fire) && self.is_on_fire) {
        return;
    }
    if (is_true(self.disable_flame_fx)) {
        return;
    }
    self.is_on_fire = 1;
    self thread on_fire_timeout();
    if (isdefined(level._effect) && isdefined(level._effect[#"character_fire_death_torso"])) {
        fire_tag = "j_spinelower";
        fire_death_torso_fx = level._effect[#"character_fire_death_torso"];
        if (isdefined(self.weapon_specific_fire_death_torso_fx)) {
            fire_death_torso_fx = self.weapon_specific_fire_death_torso_fx;
        }
        if (!isdefined(self gettagorigin(fire_tag))) {
            fire_tag = "tag_origin";
        }
        if (!isdefined(self.isdog) || !self.isdog) {
            self fx::play(fire_death_torso_fx, (0, 0, 0), (0, 0, 0), "stop_flame_damage", 1, fire_tag);
        }
        self.weapon_specific_fire_death_torso_fx = undefined;
    } else {
        println("<dev string:x38>");
    }
    if (isdefined(level._effect) && isdefined(level._effect[#"character_fire_death_sm"])) {
        if (!isvehicle(self) && self.archetype !== "raps" && self.archetype !== "spider") {
            fire_death_sm_fx = level._effect[#"character_fire_death_sm"];
            if (isdefined(self.weapon_specific_fire_death_sm_fx)) {
                fire_death_sm_fx = self.weapon_specific_fire_death_sm_fx;
            }
            if (isdefined(self.weapon_specific_fire_death_torso_fx)) {
                fire_death_torso_fx = self.weapon_specific_fire_death_torso_fx;
            }
            wait 1;
            tagarray = [];
            tagarray[0] = "j_elbow_le";
            tagarray[1] = "j_elbow_ri";
            tagarray[2] = "j_knee_ri";
            tagarray[3] = "j_knee_le";
            tagarray = array::randomize(tagarray);
            self fx::play(fire_death_sm_fx, (0, 0, 0), (0, 0, 0), "stop_flame_damage", 1, tagarray[0]);
            wait 1;
            tagarray[0] = "j_wrist_ri";
            tagarray[1] = "j_wrist_le";
            if (!isdefined(self.a.gib_ref) || self.a.gib_ref != "no_legs") {
                tagarray[2] = "j_ankle_ri";
                tagarray[3] = "j_ankle_le";
            }
            tagarray = array::randomize(tagarray);
            self fx::play(fire_death_sm_fx, (0, 0, 0), (0, 0, 0), "stop_flame_damage", 1, tagarray[0]);
            self fx::play(fire_death_sm_fx, (0, 0, 0), (0, 0, 0), "stop_flame_damage", 1, tagarray[1]);
            self.weapon_specific_fire_death_sm_fx = undefined;
        }
        return;
    }
    println("<dev string:xda>");
}

// Namespace zombie_death/zombie_death
// Params 0, eflags: 0x0
// Checksum 0x6708c36f, Offset: 0x5f0
// Size: 0x1aa
function do_gib() {
    if (!isdefined(self.a.gib_ref)) {
        return;
    }
    if (isdefined(self.is_on_fire) && self.is_on_fire) {
        return;
    }
    switch (self.a.gib_ref) {
    case #"right_arm":
        gibserverutils::gibrightarm(self);
        break;
    case #"left_arm":
        gibserverutils::gibleftarm(self);
        break;
    case #"right_leg":
        gibserverutils::gibrightleg(self);
        break;
    case #"left_leg":
        gibserverutils::gibleftleg(self);
        break;
    case #"no_legs":
        gibserverutils::giblegs(self);
        break;
    case #"head":
        gibserverutils::gibhead(self);
        break;
    case #"guts":
        break;
    default:
        assertmsg("<dev string:x176>" + self.a.gib_ref + "<dev string:x18b>");
        break;
    }
}

