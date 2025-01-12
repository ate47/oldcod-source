#using scripts\core_common\util_shared;

#namespace zombie_death;

// Namespace zombie_death/zombie_death
// Params 0, eflags: 0x2
// Checksum 0xb223cc92, Offset: 0xf0
// Size: 0x82
function autoexec init_fire_fx() {
    waitframe(1);
    if (!isdefined(level._effect)) {
        level._effect = [];
    }
    level._effect[#"character_fire_death_sm"] = #"hash_c9cf0acc938a7f6";
    level._effect[#"character_fire_death_torso"] = #"hash_5686def5b4c85661";
}

// Namespace zombie_death/zombie_death
// Params 1, eflags: 0x0
// Checksum 0xcb5ddd00, Offset: 0x180
// Size: 0x66
function on_fire_timeout(localclientnum) {
    self endon(#"death");
    wait 12;
    if (isdefined(self) && isalive(self)) {
        self.is_on_fire = 0;
        self notify(#"stop_flame_damage");
    }
}

// Namespace zombie_death/zombie_death
// Params 1, eflags: 0x0
// Checksum 0xc5fa6c67, Offset: 0x1f0
// Size: 0x374
function flame_death_fx(localclientnum) {
    self endon(#"death");
    self util::waittill_dobj(localclientnum);
    if (isdefined(self.is_on_fire) && self.is_on_fire) {
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
        println("<dev string:x30>");
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
            if (!(isdefined(self.missinglegs) && self.missinglegs)) {
                tagarray[2] = "J_Ankle_RI";
                tagarray[3] = "J_Ankle_LE";
            }
            tagarray = randomize_array(tagarray);
            util::playfxontag(localclientnum, level._effect[#"character_fire_death_sm"], self, tagarray[0]);
            util::playfxontag(localclientnum, level._effect[#"character_fire_death_sm"], self, tagarray[1]);
        }
        return;
    }
    println("<dev string:xcf>");
}

// Namespace zombie_death/zombie_death
// Params 1, eflags: 0x0
// Checksum 0x102464f3, Offset: 0x570
// Size: 0x90
function randomize_array(array) {
    for (i = 0; i < array.size; i++) {
        j = randomint(array.size);
        temp = array[i];
        array[i] = array[j];
        array[j] = temp;
    }
    return array;
}

