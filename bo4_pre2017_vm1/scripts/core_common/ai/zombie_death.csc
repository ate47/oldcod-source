#using scripts/core_common/struct;
#using scripts/core_common/util_shared;

#namespace zombie_death;

// Namespace zombie_death/zombie_death
// Params 0, eflags: 0x2
// Checksum 0x77982695, Offset: 0x190
// Size: 0x6a
function autoexec init_fire_fx() {
    waitframe(1);
    if (!isdefined(level._effect)) {
        level._effect = [];
    }
    level._effect["character_fire_death_sm"] = "zombie/fx_fire_torso_zmb";
    level._effect["character_fire_death_torso"] = "zombie/fx_fire_torso_zmb";
}

// Namespace zombie_death/zombie_death
// Params 1, eflags: 0x0
// Checksum 0xeeb91708, Offset: 0x208
// Size: 0x5a
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
// Checksum 0xe295a74, Offset: 0x270
// Size: 0x354
function flame_death_fx(localclientnum) {
    self endon(#"death");
    if (isdefined(self.is_on_fire) && self.is_on_fire) {
        return;
    }
    self.is_on_fire = 1;
    self thread on_fire_timeout();
    if (isdefined(level._effect) && isdefined(level._effect["character_fire_death_torso"])) {
        fire_tag = "j_spinelower";
        if (!isdefined(self gettagorigin(fire_tag))) {
            fire_tag = "tag_origin";
        }
        if (!isdefined(self.isdog) || !self.isdog) {
            playfxontag(localclientnum, level._effect["character_fire_death_torso"], self, fire_tag);
        }
    } else {
        println("<dev string:x28>");
    }
    if (isdefined(level._effect) && isdefined(level._effect["character_fire_death_sm"])) {
        if (self.archetype !== "parasite" && self.archetype !== "raps") {
            wait 1;
            tagarray = [];
            tagarray[0] = "J_Elbow_LE";
            tagarray[1] = "J_Elbow_RI";
            tagarray[2] = "J_Knee_RI";
            tagarray[3] = "J_Knee_LE";
            tagarray = randomize_array(tagarray);
            playfxontag(localclientnum, level._effect["character_fire_death_sm"], self, tagarray[0]);
            wait 1;
            tagarray[0] = "J_Wrist_RI";
            tagarray[1] = "J_Wrist_LE";
            if (!(isdefined(self.missinglegs) && self.missinglegs)) {
                tagarray[2] = "J_Ankle_RI";
                tagarray[3] = "J_Ankle_LE";
            }
            tagarray = randomize_array(tagarray);
            playfxontag(localclientnum, level._effect["character_fire_death_sm"], self, tagarray[0]);
            playfxontag(localclientnum, level._effect["character_fire_death_sm"], self, tagarray[1]);
        }
        return;
    }
    println("<dev string:xc7>");
}

// Namespace zombie_death/zombie_death
// Params 1, eflags: 0x0
// Checksum 0x19ca3b1d, Offset: 0x5d0
// Size: 0x9c
function randomize_array(array) {
    for (i = 0; i < array.size; i++) {
        j = randomint(array.size);
        temp = array[i];
        array[i] = array[j];
        array[j] = temp;
    }
    return array;
}

