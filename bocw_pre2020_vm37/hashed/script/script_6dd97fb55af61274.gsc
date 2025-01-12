#using script_1940fc077a028a81;
#using script_3357acf79ce92f4b;
#using script_3411bb48d41bd3b;
#using script_3751b21462a54a7d;
#using script_3a88f428c6d8ef90;
#using script_5f261a5d57de5f7c;
#using scripts\core_common\aat_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\system_shared;
#using scripts\zm_common\zm_weapons;

#namespace namespace_d35b13b1;

// Namespace namespace_d35b13b1/namespace_d35b13b1
// Params 0, eflags: 0x6
// Checksum 0xff65dda9, Offset: 0x138
// Size: 0x44
function private autoexec __init__system__() {
    system::register(#"hash_7eaac11b6cd35b05", &function_70a657d8, undefined, &function_4df027f2, undefined);
}

// Namespace namespace_d35b13b1/namespace_d35b13b1
// Params 0, eflags: 0x4
// Checksum 0x6a68be8e, Offset: 0x188
// Size: 0x8c
function private function_70a657d8() {
    spawner::add_archetype_spawn_function(#"raz", &function_ce3b36df);
    spawner::function_89a2cd87(#"raz", &function_e7ad996);
    function_c7bb75d5();
    level.var_dff96419 = &function_f3c536e3;
}

// Namespace namespace_d35b13b1/namespace_d35b13b1
// Params 0, eflags: 0x0
// Checksum 0xd7ac0957, Offset: 0x220
// Size: 0xac
function function_4df027f2() {
    level thread aat::register_immunity("zm_aat_kill_o_watt", #"raz", 1, 1, 1);
    level thread aat::register_immunity("zm_aat_brain_decay", #"raz", 1, 1, 1);
    level thread aat::register_immunity("zm_aat_plasmatic_burst", #"raz", 1, 1, 1);
}

// Namespace namespace_d35b13b1/namespace_d35b13b1
// Params 0, eflags: 0x4
// Checksum 0x80f724d1, Offset: 0x2d8
// Size: 0x4
function private function_c7bb75d5() {
    
}

// Namespace namespace_d35b13b1/namespace_d35b13b1
// Params 0, eflags: 0x0
// Checksum 0xed4a8aac, Offset: 0x2e8
// Size: 0x134
function function_ce3b36df() {
    self callback::function_d8abfc3d(#"on_ai_melee", &namespace_85745671::function_b8eb5dea);
    self callback::function_d8abfc3d(#"hash_10ab46b52df7967a", &function_f9780e50);
    self.var_12af7864 = 1;
    self.var_c11b8a5a = 1;
    self.var_b3c613a7 = [1, 1.5, 1.5, 2, 2];
    self.var_414bc881 = 1;
    self.completed_emerging_into_playable_area = 1;
    playfx("zombie/fx_portal_keeper_spawn_burst_zod_zmb", self.origin, anglestoforward((0, 0, 0)), anglestoup((0, 0, 0)));
}

// Namespace namespace_d35b13b1/namespace_d35b13b1
// Params 0, eflags: 0x0
// Checksum 0xc1a360a8, Offset: 0x428
// Size: 0x1c
function function_e7ad996() {
    setup_awareness(self);
}

// Namespace namespace_d35b13b1/namespace_d35b13b1
// Params 1, eflags: 0x0
// Checksum 0x6e135149, Offset: 0x450
// Size: 0x64
function function_f9780e50(*params) {
    self endon(#"death");
    if (isdefined(self.attackable)) {
        namespace_85745671::function_2b925fa5(self);
    }
    self kill(undefined, undefined, undefined, undefined, 0, 1);
}

// Namespace namespace_d35b13b1/namespace_d35b13b1
// Params 1, eflags: 0x4
// Checksum 0xe9673f80, Offset: 0x4c0
// Size: 0x1ac
function private setup_awareness(entity) {
    entity.has_awareness = 1;
    entity.ignorelaststandplayers = 1;
    self callback::function_d8abfc3d(#"on_ai_damage", &awareness::function_5f511313);
    awareness::register_state(entity, #"wander", &function_1df172de, &awareness::function_4ebe4a6d, &awareness::function_b264a0bc, undefined, &awareness::function_555d960b);
    awareness::register_state(entity, #"investigate", &function_bbd541c7, &awareness::function_9eefc327, &awareness::function_34162a25, undefined, &awareness::function_a360dd00);
    awareness::register_state(entity, #"chase", &function_7812e703, &function_333a7b23, &awareness::function_b9f81e8b, &awareness::function_5c40e824);
    awareness::set_state(entity, #"wander");
    entity thread awareness::function_fa6e010d();
}

// Namespace namespace_d35b13b1/namespace_d35b13b1
// Params 1, eflags: 0x4
// Checksum 0x836c0de8, Offset: 0x678
// Size: 0x5c
function private function_1df172de(entity) {
    self.fovcosine = 0.5;
    self.maxsightdistsqrd = function_a3f6cdac(1000);
    self.var_1267fdea = 0;
    awareness::function_9c9d96b5(entity);
}

// Namespace namespace_d35b13b1/namespace_d35b13b1
// Params 1, eflags: 0x4
// Checksum 0x6c55d22a, Offset: 0x6e0
// Size: 0x5c
function private function_bbd541c7(entity) {
    self.fovcosine = 0;
    self.maxsightdistsqrd = function_a3f6cdac(1800);
    self.var_1267fdea = 0;
    awareness::function_b41f0471(entity);
}

// Namespace namespace_d35b13b1/namespace_d35b13b1
// Params 1, eflags: 0x4
// Checksum 0xe762700c, Offset: 0x748
// Size: 0x5c
function private function_7812e703(entity) {
    self.fovcosine = 0;
    self.maxsightdistsqrd = function_a3f6cdac(3000);
    self.var_1267fdea = 0;
    awareness::function_978025e4(entity);
}

// Namespace namespace_d35b13b1/namespace_d35b13b1
// Params 1, eflags: 0x4
// Checksum 0xfaee3167, Offset: 0x7b0
// Size: 0x24c
function private function_333a7b23(entity) {
    if (isdefined(entity.attackable) && !isdefined(entity.var_b238ef38)) {
        if (!isdefined(entity.var_3f8ea75c)) {
            entity.var_3f8ea75c = namespace_85745671::function_12d90bae(entity, 150, 750, entity.attackable);
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

// Namespace namespace_d35b13b1/namespace_d35b13b1
// Params 1, eflags: 0x4
// Checksum 0x2a809c55, Offset: 0xa08
// Size: 0xc
function private function_9cb1b62f(*entity) {
    
}

// Namespace namespace_d35b13b1/namespace_d35b13b1
// Params 2, eflags: 0x0
// Checksum 0xd3be32, Offset: 0xa20
// Size: 0x112
function function_f3c536e3(damagemod, weapon) {
    var_36d55c9c = 1;
    if (isplayer(self)) {
        w_base = zm_weapons::get_base_weapon(weapon);
        if (level.zombie_weapons[w_base].weapon_classname === "lmg") {
            n_tier = self namespace_b61a349a::function_998f8321(weapon);
            if (n_tier >= 2) {
                var_36d55c9c = n_tier >= 4 ? 1.25 : 1.1;
            }
        }
        if (self namespace_e86ffa8::function_7bf30775(2)) {
            damagemod = damagemod * 1.5 * var_36d55c9c;
            return damagemod;
        }
    }
    return damagemod * var_36d55c9c;
}

