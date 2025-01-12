#using scripts\core_common\ai\systems\fx_character;
#using scripts\core_common\ai\systems\gib;
#using scripts\core_common\ai_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\util_shared;

#namespace zombie;

// Namespace zombie/zombie
// Params 0, eflags: 0x2
// Checksum 0x36bca5c7, Offset: 0xf0
// Size: 0x164
function autoexec main() {
    level._effect[#"zombie_special_day_effect"] = #"hash_7a37324c1988abb5";
    ai::add_archetype_spawn_function(#"zombie", &zombieclientutils::zombie_override_burn_fx);
    ai::add_archetype_spawn_function(#"zombie", &zombieclientutils::zombiespawnsetup);
    clientfield::register("actor", "zombie", 1, 1, "int", &zombieclientutils::zombiehandler, 0, 0);
    clientfield::register("actor", "zombie_special_day", 1, 1, "counter", &zombieclientutils::zombiespecialdayeffectshandler, 0, 0);
    clientfield::register("actor", "pustule_pulse_cf", 1, 1, "int", &zombieclientutils::function_a17af3df, 0, 0);
}

#namespace zombieclientutils;

// Namespace zombieclientutils/zombie
// Params 7, eflags: 0x1 linked
// Checksum 0x9d86beb9, Offset: 0x260
// Size: 0x174
function zombiehandler(localclientnum, *oldvalue, *newvalue, *bnewent, *binitialsnap, *fieldname, *wasdemojump) {
    entity = self;
    if (isdefined(entity.archetype) && entity.archetype != #"zombie") {
        return;
    }
    if (!isdefined(entity.initializedgibcallbacks) || !entity.initializedgibcallbacks) {
        entity.initializedgibcallbacks = 1;
        gibclientutils::addgibcallback(wasdemojump, entity, 8, &_gibcallback);
        gibclientutils::addgibcallback(wasdemojump, entity, 16, &_gibcallback);
        gibclientutils::addgibcallback(wasdemojump, entity, 32, &_gibcallback);
        gibclientutils::addgibcallback(wasdemojump, entity, 128, &_gibcallback);
        gibclientutils::addgibcallback(wasdemojump, entity, 256, &_gibcallback);
    }
}

// Namespace zombieclientutils/zombie
// Params 3, eflags: 0x5 linked
// Checksum 0x7332e19e, Offset: 0x3e0
// Size: 0xfa
function private _gibcallback(*localclientnum, *entity, gibflag) {
    switch (gibflag) {
    case 8:
        playsound(0, #"zmb_zombie_head_gib", self.origin + (0, 0, 60));
        break;
    case 16:
    case 32:
    case 128:
    case 256:
        playsound(0, #"zmb_death_gibs", self.origin + (0, 0, 30));
        break;
    }
}

// Namespace zombieclientutils/zombie
// Params 7, eflags: 0x1 linked
// Checksum 0xecf7ebb9, Offset: 0x4e8
// Size: 0x104
function zombiespecialdayeffectshandler(localclientnum, *oldvalue, *newvalue, *bnewent, *binitialsnap, *fieldname, *wasdemojump) {
    entity = self;
    if (isdefined(entity.archetype) && entity.archetype != #"zombie") {
        return;
    }
    origin = entity gettagorigin("j_spine4");
    fx = playfx(wasdemojump, level._effect[#"zombie_special_day_effect"], origin);
    setfxignorepause(wasdemojump, fx, 1);
}

// Namespace zombieclientutils/zombie
// Params 1, eflags: 0x1 linked
// Checksum 0x57c82838, Offset: 0x5f8
// Size: 0x1c4
function zombie_override_burn_fx(*localclientnum) {
    if (sessionmodeiszombiesgame()) {
        if (!isdefined(self._effect)) {
            self._effect = [];
        }
        level._effect[#"fire_zombie_j_elbow_le_loop"] = #"fire/fx_fire_ai_human_arm_left_loop";
        level._effect[#"fire_zombie_j_elbow_ri_loop"] = #"fire/fx_fire_ai_human_arm_right_loop";
        level._effect[#"fire_zombie_j_shoulder_le_loop"] = #"fire/fx_fire_ai_human_arm_left_loop";
        level._effect[#"fire_zombie_j_shoulder_ri_loop"] = #"fire/fx_fire_ai_human_arm_right_loop";
        level._effect[#"fire_zombie_j_spine4_loop"] = #"fire/fx_fire_ai_human_torso_loop";
        level._effect[#"fire_zombie_j_hip_le_loop"] = #"fire/fx_fire_ai_human_hip_left_loop";
        level._effect[#"fire_zombie_j_hip_ri_loop"] = #"fire/fx_fire_ai_human_hip_right_loop";
        level._effect[#"fire_zombie_j_knee_le_loop"] = #"fire/fx_fire_ai_human_leg_left_loop";
        level._effect[#"fire_zombie_j_knee_ri_loop"] = #"fire/fx_fire_ai_human_leg_right_loop";
        level._effect[#"fire_zombie_j_head_loop"] = #"fire/fx_fire_ai_human_head_loop";
    }
}

// Namespace zombieclientutils/zombie
// Params 1, eflags: 0x1 linked
// Checksum 0xa27405a0, Offset: 0x7c8
// Size: 0x44
function zombiespawnsetup(localclientnum) {
    self enableonradar();
    fxclientutils::playfxbundle(localclientnum, self, self.fxdef);
}

// Namespace zombieclientutils/zombie
// Params 7, eflags: 0x1 linked
// Checksum 0xe420d537, Offset: 0x818
// Size: 0xbc
function function_a17af3df(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    util::waittill_dobj(fieldname);
    if (!isdefined(self)) {
        return;
    }
    if (bwastimejump) {
        self playrenderoverridebundle(#"hash_882e5d8c59f40a3");
        self callback::on_shutdown(&function_c88acbea);
        return;
    }
    function_c88acbea();
}

// Namespace zombieclientutils/zombie
// Params 1, eflags: 0x1 linked
// Checksum 0xb317245f, Offset: 0x8e0
// Size: 0x2c
function function_c88acbea(*params) {
    self stoprenderoverridebundle(#"hash_882e5d8c59f40a3");
}

