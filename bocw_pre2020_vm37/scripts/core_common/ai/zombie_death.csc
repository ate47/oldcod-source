#using scripts\core_common\util_shared;

#namespace zombie_death;

// Namespace zombie_death/zombie_death
// Params 0, eflags: 0x2
// Checksum 0xd7b380d9, Offset: 0x120
// Size: 0x74
function autoexec init_fire_fx() {
    waitframe(1);
    if (!isdefined(level._effect)) {
        level._effect = [];
    }
    level._effect[#"character_fire_death_sm"] = #"hash_c9cf0acc938a7f6";
    level._effect[#"character_fire_death_torso"] = #"hash_5686def5b4c85661";
}

// Namespace zombie_death/zombie_death
// Params 1, eflags: 0x1 linked
// Checksum 0xf382d3fc, Offset: 0x1a0
// Size: 0x66
function on_fire_timeout(*localclientnum) {
    self endon(#"death");
    wait 12;
    if (isdefined(self) && isalive(self)) {
        self.is_on_fire = 0;
        self notify(#"stop_flame_damage");
    }
}

// Namespace zombie_death/zombie_death
// Params 1, eflags: 0x1 linked
// Checksum 0xf9e4e644, Offset: 0x210
// Size: 0x384
function flame_death_fx(localclientnum) {
    self notify("484eca5adcd8edcb");
    self endon("484eca5adcd8edcb");
    if (!isalive(self)) {
        return;
    }
    self endon(#"death");
    self util::waittill_dobj(localclientnum);
    if (is_true(self.is_on_fire)) {
        return;
    }
    self.is_on_fire = 1;
    self thread on_fire_timeout();
    if (isdefined(level._effect) && isdefined(level._effect[#"character_fire_death_torso"])) {
        fire_tag = "j_spinelower";
        if (!isdefined(self gettagorigin(fire_tag))) {
            fire_tag = "tag_origin";
        }
        if (!isdefined(self.isdog) || !self.isdog) {
            util::playfxontag(localclientnum, level._effect[#"character_fire_death_torso"], self, fire_tag);
        }
    } else {
        println("<dev string:x38>");
    }
    if (isdefined(level._effect) && isdefined(level._effect[#"character_fire_death_sm"])) {
        if (self.archetype !== "parasite" && self.archetype !== "raps") {
            wait 1;
            tagarray = [];
            tagarray[0] = "J_Elbow_LE";
            tagarray[1] = "J_Elbow_RI";
            tagarray[2] = "J_Knee_RI";
            tagarray[3] = "J_Knee_LE";
            tagarray = randomize_array(tagarray);
            util::playfxontag(localclientnum, level._effect[#"character_fire_death_sm"], self, tagarray[0]);
            wait 1;
            tagarray[0] = "J_Wrist_RI";
            tagarray[1] = "J_Wrist_LE";
            if (!is_true(self.missinglegs)) {
                tagarray[2] = "J_Ankle_RI";
                tagarray[3] = "J_Ankle_LE";
            }
            tagarray = randomize_array(tagarray);
            util::playfxontag(localclientnum, level._effect[#"character_fire_death_sm"], self, tagarray[0]);
            util::playfxontag(localclientnum, level._effect[#"character_fire_death_sm"], self, tagarray[1]);
        }
        return;
    }
    println("<dev string:xda>");
}

// Namespace zombie_death/zombie_death
// Params 1, eflags: 0x1 linked
// Checksum 0xbfb48b99, Offset: 0x5a0
// Size: 0x7e
function randomize_array(array) {
    for (i = 0; i < array.size; i++) {
        j = randomint(array.size);
        temp = array[i];
        array[i] = array[j];
        array[j] = temp;
    }
    return array;
}

