#using scripts/core_common/ai/systems/gib;
#using scripts/core_common/ai_shared;
#using scripts/core_common/clientfield_shared;

#namespace zombie;

// Namespace zombie/zombie
// Params 0, eflags: 0x2
// Checksum 0x80f724d1, Offset: 0x3d8
// Size: 0x4
function autoexec precache() {
    
}

// Namespace zombie/zombie
// Params 0, eflags: 0x2
// Checksum 0x10dfd760, Offset: 0x3e8
// Size: 0xdc
function autoexec main() {
    level._effect["zombie_special_day_effect"] = "zombie/fx_val_chest_burst";
    ai::add_archetype_spawn_function("zombie", &zombieclientutils::zombie_override_burn_fx);
    clientfield::register("actor", "zombie", 1, 1, "int", &zombieclientutils::zombiehandler, 0, 0);
    clientfield::register("actor", "zombie_special_day", 6001, 1, "counter", &zombieclientutils::zombiespecialdayeffectshandler, 0, 0);
}

#namespace zombieclientutils;

// Namespace zombieclientutils/zombie
// Params 7, eflags: 0x0
// Checksum 0x5a931223, Offset: 0x4d0
// Size: 0x184
function zombiehandler(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
    entity = self;
    if (isdefined(entity.archetype) && entity.archetype != "zombie") {
        return;
    }
    if (!isdefined(entity.initializedgibcallbacks) || !entity.initializedgibcallbacks) {
        entity.initializedgibcallbacks = 1;
        gibclientutils::addgibcallback(localclientnum, entity, 8, &_gibcallback);
        gibclientutils::addgibcallback(localclientnum, entity, 16, &_gibcallback);
        gibclientutils::addgibcallback(localclientnum, entity, 32, &_gibcallback);
        gibclientutils::addgibcallback(localclientnum, entity, 128, &_gibcallback);
        gibclientutils::addgibcallback(localclientnum, entity, 256, &_gibcallback);
    }
}

// Namespace zombieclientutils/zombie
// Params 3, eflags: 0x4
// Checksum 0x45c940a7, Offset: 0x660
// Size: 0xc6
function private _gibcallback(localclientnum, entity, gibflag) {
    switch (gibflag) {
    case 8:
        playsound(0, "zmb_zombie_head_gib", self.origin + (0, 0, 60));
        break;
    case 16:
    case 32:
    case 128:
    case 256:
        playsound(0, "zmb_death_gibs", self.origin + (0, 0, 30));
        break;
    }
}

// Namespace zombieclientutils/zombie
// Params 7, eflags: 0x0
// Checksum 0x8ba9ffd7, Offset: 0x730
// Size: 0x104
function zombiespecialdayeffectshandler(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
    entity = self;
    if (isdefined(entity.archetype) && entity.archetype != "zombie") {
        return;
    }
    origin = entity gettagorigin("j_spine4");
    fx = playfx(localclientnum, level._effect["zombie_special_day_effect"], origin);
    setfxignorepause(localclientnum, fx, 1);
}

// Namespace zombieclientutils/zombie
// Params 1, eflags: 0x0
// Checksum 0xfa53afbe, Offset: 0x840
// Size: 0x176
function zombie_override_burn_fx(localclientnum) {
    if (sessionmodeiszombiesgame()) {
        if (!isdefined(self._effect)) {
            self._effect = [];
        }
        level._effect["fire_zombie_j_elbow_le_loop"] = "fire/fx_fire_ai_human_arm_left_loop_optim";
        level._effect["fire_zombie_j_elbow_ri_loop"] = "fire/fx_fire_ai_human_arm_right_loop_optim";
        level._effect["fire_zombie_j_shoulder_le_loop"] = "fire/fx_fire_ai_human_arm_left_loop_optim";
        level._effect["fire_zombie_j_shoulder_ri_loop"] = "fire/fx_fire_ai_human_arm_right_loop_optim";
        level._effect["fire_zombie_j_spine4_loop"] = "fire/fx_fire_ai_human_torso_loop_optim";
        level._effect["fire_zombie_j_hip_le_loop"] = "fire/fx_fire_ai_human_hip_left_loop_optim";
        level._effect["fire_zombie_j_hip_ri_loop"] = "fire/fx_fire_ai_human_hip_right_loop_optim";
        level._effect["fire_zombie_j_knee_le_loop"] = "fire/fx_fire_ai_human_leg_left_loop_optim";
        level._effect["fire_zombie_j_knee_ri_loop"] = "fire/fx_fire_ai_human_leg_right_loop_optim";
        level._effect["fire_zombie_j_head_loop"] = "fire/fx_fire_ai_human_head_loop_optim";
    }
}

