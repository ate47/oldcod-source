#using script_1940fc077a028a81;
#using script_2618e0f3e5e11649;
#using script_3357acf79ce92f4b;
#using script_3411bb48d41bd3b;
#using script_3751b21462a54a7d;
#using scripts\core_common\aat_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\system_shared;

#namespace namespace_cd6bd9f;

// Namespace namespace_cd6bd9f/namespace_cd6bd9f
// Params 0, eflags: 0x6
// Checksum 0x111349ec, Offset: 0x100
// Size: 0x44
function private autoexec __init__system__() {
    system::register(#"hash_54149d856843e31a", &function_70a657d8, undefined, &function_4df027f2, undefined);
}

// Namespace namespace_cd6bd9f/namespace_cd6bd9f
// Params 0, eflags: 0x4
// Checksum 0x163e556b, Offset: 0x150
// Size: 0x64
function private function_70a657d8() {
    spawner::add_archetype_spawn_function(#"hash_7c0d83ac1e845ac2", &function_8efe7666);
    spawner::function_89a2cd87(#"hash_7c0d83ac1e845ac2", &function_37804710);
}

// Namespace namespace_cd6bd9f/namespace_cd6bd9f
// Params 0, eflags: 0x0
// Checksum 0xe2eb3365, Offset: 0x1c0
// Size: 0xac
function function_4df027f2() {
    level thread aat::register_immunity("zm_aat_kill_o_watt", #"hash_7c0d83ac1e845ac2", 1, 1, 1);
    level thread aat::register_immunity("zm_aat_brain_decay", #"hash_7c0d83ac1e845ac2", 1, 1, 1);
    level thread aat::register_immunity("zm_aat_plasmatic_burst", #"hash_7c0d83ac1e845ac2", 1, 1, 1);
}

// Namespace namespace_cd6bd9f/namespace_cd6bd9f
// Params 0, eflags: 0x0
// Checksum 0x74a839e1, Offset: 0x278
// Size: 0x14e
function function_8efe7666() {
    self callback::function_d8abfc3d(#"on_ai_melee", &namespace_85745671::function_b8eb5dea);
    self callback::function_d8abfc3d(#"hash_10ab46b52df7967a", &function_bac62d85);
    self.var_12af7864 = 1;
    self.var_c11b8a5a = 1;
    self.ai.var_870d0893 = 1;
    self.targetname = "defend_zombie";
    if (!isdefined(self.var_9fde8624)) {
        self.var_9d59692c = &function_9d59692c;
        self.var_813a079f = &function_1915f8d6;
    } else {
        self.var_813a079f = &function_ccdf9d44;
    }
    self.var_b3c613a7 = [1, 1.5, 1.5, 2, 2];
    self.var_414bc881 = 1;
}

// Namespace namespace_cd6bd9f/namespace_cd6bd9f
// Params 0, eflags: 0x0
// Checksum 0xbe6fadd9, Offset: 0x3d0
// Size: 0x24
function function_37804710() {
    if (!isdefined(self.var_9fde8624)) {
        setup_awareness(self);
    }
}

// Namespace namespace_cd6bd9f/namespace_cd6bd9f
// Params 1, eflags: 0x0
// Checksum 0x73d9852a, Offset: 0x400
// Size: 0x64
function function_bac62d85(*params) {
    self endon(#"death");
    if (isdefined(self.attackable)) {
        namespace_85745671::function_2b925fa5(self);
    }
    self kill(undefined, undefined, undefined, undefined, 0, 1);
}

// Namespace namespace_cd6bd9f/namespace_cd6bd9f
// Params 2, eflags: 0x4
// Checksum 0x5ec29ccc, Offset: 0x470
// Size: 0x62
function private function_887b8ada(var_5c5062cd, var_fbac2b3f) {
    self.var_659efbe = var_fbac2b3f;
    self.list_name = var_5c5062cd.list_name;
    self.var_89592ba7 = var_5c5062cd.var_89592ba7;
    self.var_722e942 = var_5c5062cd.var_722e942;
    self.hotzone = var_5c5062cd.hotzone;
}

// Namespace namespace_cd6bd9f/namespace_cd6bd9f
// Params 2, eflags: 0x4
// Checksum 0x55ee4a4f, Offset: 0x4e0
// Size: 0xe4
function private function_9d59692c(var_33e339fe, var_551c6a0e) {
    if (!isdefined(self.list_name) || !isdefined(self.var_89592ba7)) {
        return;
    }
    if (isdefined(var_33e339fe)) {
        setup_awareness(var_33e339fe);
        var_33e339fe function_887b8ada(self, var_551c6a0e);
        namespace_ce1f29cc::function_418ab095(var_33e339fe, self.hotzone);
    }
    if (isdefined(var_551c6a0e)) {
        setup_awareness(var_551c6a0e);
        var_551c6a0e function_887b8ada(self, var_33e339fe);
        namespace_ce1f29cc::function_418ab095(var_551c6a0e, self.hotzone);
    }
}

// Namespace namespace_cd6bd9f/namespace_cd6bd9f
// Params 2, eflags: 0x4
// Checksum 0x71110f86, Offset: 0x5d0
// Size: 0x78
function private function_ccdf9d44(params, *hotzone) {
    if (!isdefined(self.list_name) || !isdefined(self.var_89592ba7) || isplayer(hotzone.eattacker) || isalive(self.var_659efbe)) {
        return false;
    }
    return true;
}

// Namespace namespace_cd6bd9f/namespace_cd6bd9f
// Params 2, eflags: 0x4
// Checksum 0xdaa08839, Offset: 0x650
// Size: 0x92
function private function_1915f8d6(params, *hotzone) {
    if (!is_true(self.var_8576e0be) && !isplayer(hotzone.eattacker) && isdefined(self.list_name) && isdefined(self.var_89592ba7) && !is_true(self.var_7a68cd0c)) {
        return true;
    }
    return false;
}

// Namespace namespace_cd6bd9f/namespace_cd6bd9f
// Params 1, eflags: 0x4
// Checksum 0x9129c81c, Offset: 0x6f0
// Size: 0x1bc
function private setup_awareness(entity) {
    entity.has_awareness = 1;
    entity.ignorelaststandplayers = 1;
    entity.var_1267fdea = 1;
    self callback::function_d8abfc3d(#"on_ai_damage", &awareness::function_5f511313);
    awareness::register_state(entity, #"wander", &function_7cdb2c4c, &awareness::function_4ebe4a6d, &awareness::function_b264a0bc, undefined, &awareness::function_555d960b);
    awareness::register_state(entity, #"investigate", &function_ba66485e, &awareness::function_9eefc327, &awareness::function_34162a25, undefined, &awareness::function_a360dd00);
    awareness::register_state(entity, #"chase", &function_1534f0a3, &function_9ffae104, &awareness::function_b9f81e8b, &awareness::function_5c40e824);
    awareness::set_state(entity, #"wander");
    entity thread awareness::function_fa6e010d();
}

// Namespace namespace_cd6bd9f/namespace_cd6bd9f
// Params 1, eflags: 0x4
// Checksum 0xf3e66b5b, Offset: 0x8b8
// Size: 0x5c
function private function_7cdb2c4c(entity) {
    self.fovcosine = 0.5;
    self.maxsightdistsqrd = function_a3f6cdac(1000);
    self.var_1267fdea = 0;
    awareness::function_9c9d96b5(entity);
}

// Namespace namespace_cd6bd9f/namespace_cd6bd9f
// Params 1, eflags: 0x4
// Checksum 0x679e6bf4, Offset: 0x920
// Size: 0x5c
function private function_ba66485e(entity) {
    self.fovcosine = 0;
    self.maxsightdistsqrd = function_a3f6cdac(1800);
    self.var_1267fdea = 0;
    awareness::function_b41f0471(entity);
}

// Namespace namespace_cd6bd9f/namespace_cd6bd9f
// Params 1, eflags: 0x4
// Checksum 0x47e50735, Offset: 0x988
// Size: 0x5c
function private function_1534f0a3(entity) {
    self.fovcosine = 0;
    self.maxsightdistsqrd = function_a3f6cdac(3000);
    self.var_1267fdea = 0;
    awareness::function_978025e4(entity);
}

// Namespace namespace_cd6bd9f/namespace_cd6bd9f
// Params 1, eflags: 0x4
// Checksum 0x2b46ed55, Offset: 0x9f0
// Size: 0x27c
function private function_9ffae104(entity) {
    if (isdefined(entity.enemy) && awareness::function_2bc424fd(entity, entity.enemy)) {
        return;
    }
    if (isdefined(entity.attackable) && !isdefined(entity.var_b238ef38)) {
        if (!isdefined(entity.var_3f8ea75c)) {
            entity.var_3f8ea75c = namespace_85745671::function_12d90bae(entity, 150, 500, entity.attackable);
        }
        if (isdefined(entity.var_3f8ea75c)) {
            if (!entity isingoal(entity.var_3f8ea75c)) {
                entity setgoal(entity.var_3f8ea75c);
                entity waittill(#"goal", #"hash_5114eb062d7568b6");
                if (isdefined(entity.attackable)) {
                    var_bf3a521d = vectortoangles(entity.attackable.origin - entity.origin);
                    entity forceteleport(entity.origin, (0, var_bf3a521d[1], 0), 0);
                }
                return;
            }
            if (entity isatgoal()) {
                var_bf3a521d = entity.attackable.origin - entity.origin;
                var_bf3a521d = vectornormalize(var_bf3a521d);
                if (vectordot(var_bf3a521d, anglestoforward(entity.angles)) < 0.99) {
                    var_ae7100d7 = vectortoangles(var_bf3a521d);
                    entity forceteleport(entity.origin, (0, var_ae7100d7[1], 0), 0);
                }
            }
            return;
        }
    }
    awareness::function_39da6c3c(entity);
}

// Namespace namespace_cd6bd9f/namespace_cd6bd9f
// Params 1, eflags: 0x4
// Checksum 0xe35128ff, Offset: 0xc78
// Size: 0xc
function private function_b6d015bd(*entity) {
    
}

