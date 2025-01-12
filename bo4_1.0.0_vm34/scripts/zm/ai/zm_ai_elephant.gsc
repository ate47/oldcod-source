#using script_2c5daa95f8fec03c;
#using scripts\core_common\aat_shared;
#using scripts\core_common\ai\archetype_damage_utility;
#using scripts\core_common\ai\archetype_elephant;
#using scripts\core_common\ai\systems\ai_blackboard;
#using scripts\core_common\ai\systems\ai_interface;
#using scripts\core_common\ai\systems\animation_state_machine_notetracks;
#using scripts\core_common\ai\systems\animation_state_machine_utility;
#using scripts\core_common\ai\systems\behavior_tree_utility;
#using scripts\core_common\ai\systems\blackboard;
#using scripts\core_common\ai\systems\gib;
#using scripts\core_common\ai\zombie_utility;
#using scripts\core_common\ai_shared;
#using scripts\core_common\animation_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\system_shared;
#using scripts\zm_common\zm_aoe;

#namespace zm_ai_elephant;

// Namespace zm_ai_elephant/zm_ai_elephant
// Params 0, eflags: 0x2
// Checksum 0xe7d7b37b, Offset: 0x240
// Size: 0x3c
function autoexec main() {
    registerbehaviorscriptfunctions();
    spawner::add_archetype_spawn_function("elephant", &function_ee4da73e);
}

// Namespace zm_ai_elephant/zm_ai_elephant
// Params 0, eflags: 0x4
// Checksum 0xc8026989, Offset: 0x288
// Size: 0xa4
function private registerbehaviorscriptfunctions() {
    animation::add_global_notetrack_handler("arrow_throw", &function_53a72c36, 0);
    animation::add_global_notetrack_handler("spear_unhide", &function_5b1a636a, 0);
    animation::add_global_notetrack_handler("spear_hide", &function_42fc8c9, 0);
    animation::add_global_notetrack_handler("start_gib", &function_bf5bd744, 0);
}

// Namespace zm_ai_elephant/zm_ai_elephant
// Params 0, eflags: 0x4
// Checksum 0xa8c3fda8, Offset: 0x338
// Size: 0x16a
function private function_ee4da73e() {
    if (!(isdefined(level.var_e7b0c3d9) && level.var_e7b0c3d9)) {
        level thread aat::register_immunity("zm_aat_brain_decay", "elephant", 1, 0, 0);
        level thread aat::register_immunity("zm_aat_frostbite", "elephant", 1, 0, 0);
        level thread aat::register_immunity("zm_aat_kill_o_watt", "elephant", 1, 0, 0);
        level thread aat::register_immunity("zm_aat_plasmatic_burst", "elephant", 1, 0, 0);
        level.var_e7b0c3d9 = 1;
    }
    self.ai.var_88f1cd90 = &function_88f1cd90;
    self.var_2e8cef76 = 1;
    self.b_ignore_cleanup = 1;
    aiutility::addaioverridedamagecallback(self, &function_a3577807);
    self.ai.var_969c4d3a = &function_c4f69cd8;
}

// Namespace zm_ai_elephant/zm_ai_elephant
// Params 2, eflags: 0x4
// Checksum 0xb88b857b, Offset: 0x4b0
// Size: 0x9a
function private function_c4f69cd8(enemies, entity) {
    foreach (enemy in enemies) {
        enemy zombie_utility::setup_zombie_knockdown(entity);
        enemy.knockdown_type = "knockdown_stun";
    }
}

// Namespace zm_ai_elephant/zm_ai_elephant
// Params 2, eflags: 0x4
// Checksum 0x953a4b95, Offset: 0x558
// Size: 0x34
function private function_88f1cd90(entity, projectile) {
    projectile thread function_c344ae66(entity, projectile);
}

// Namespace zm_ai_elephant/zm_ai_elephant
// Params 0, eflags: 0x4
// Checksum 0x80f724d1, Offset: 0x598
// Size: 0x4
function private function_bf5bd744() {
    
}

// Namespace zm_ai_elephant/zm_ai_elephant
// Params 0, eflags: 0x4
// Checksum 0xa41995c0, Offset: 0x5a8
// Size: 0x4e
function private function_42fc8c9() {
    if (isdefined(self.var_39883e02) && self.var_39883e02) {
        self detach("p7_shr_weapon_spear_lrg", "tag_weapon_right");
        self.var_39883e02 = 0;
    }
}

// Namespace zm_ai_elephant/zm_ai_elephant
// Params 0, eflags: 0x4
// Checksum 0x5a541d94, Offset: 0x600
// Size: 0x52
function private function_5b1a636a() {
    if (isdefined(self.var_39883e02) && !self.var_39883e02) {
        self attach("p7_shr_weapon_spear_lrg", "tag_weapon_right");
        self.var_39883e02 = 1;
    }
}

// Namespace zm_ai_elephant/zm_ai_elephant
// Params 0, eflags: 0x4
// Checksum 0x9fef25b2, Offset: 0x660
// Size: 0x196
function private function_53a72c36() {
    assert(isdefined(self.ai.spearweapon));
    forwarddir = anglestoforward(self.angles);
    var_4f2ab4fd = self gettagorigin("tag_weapon_right");
    var_2fbed037 = self.ai.elephant.favoriteenemy.origin;
    projectile = magicbullet(self.ai.spearweapon, var_4f2ab4fd, var_2fbed037, self.ai.elephant, self.ai.elephant.favoriteenemy);
    projectile thread function_8d1c1c18(projectile, self.ai.elephant.var_7c305ac4);
    projectile thread function_e36ac1b0(projectile);
    projectile thread watch_for_death(projectile);
    if (self.var_39883e02) {
        self detach("p7_shr_weapon_spear_lrg", "tag_weapon_right");
        self.var_39883e02 = 0;
    }
}

// Namespace zm_ai_elephant/zm_ai_elephant
// Params 3, eflags: 0x0
// Checksum 0xffdfc1f8, Offset: 0x800
// Size: 0x1aa
function function_38452231(index, multival, target) {
    normal = vectornormalize(target.origin - self.origin);
    pitch = randomfloatrange(15, 30);
    var_dfa2956f = randomfloatrange(-10, 10);
    yaw = -180 + 360 / multival * index + var_dfa2956f;
    angles = (pitch * -1, yaw, 0);
    dir = anglestoforward(angles);
    c = vectorcross(normal, dir);
    f = vectorcross(c, normal);
    theta = 90 - pitch;
    dir = normal * cos(theta) + f * sin(theta);
    dir = vectornormalize(dir);
    return dir;
}

// Namespace zm_ai_elephant/zm_ai_elephant
// Params 2, eflags: 0x4
// Checksum 0xf64cb2c1, Offset: 0x9b8
// Size: 0x2ac
function private function_c344ae66(entity, projectile) {
    projectile endon(#"death");
    projectile clientfield::set("towers_boss_head_proj_explosion_fx_cf", 1);
    enemyorigin = projectile.enemytarget.origin;
    physicsexplosionsphere(projectile.origin, 1000, 300, 400);
    /#
        recordsphere(enemyorigin, 15, (0, 0, 0), "<dev string:x30>");
    #/
    for (i = 0; i < 5; i++) {
        randomdistance = randomintrange(120, 360);
        var_dfa2956f = randomfloatrange(-10, 10);
        yaw = -180 + 72 * i + var_dfa2956f;
        angles = (0, yaw, 0);
        dir = anglestoforward(angles) * randomdistance;
        var_4d6e0846 = projectile.enemytarget.origin + dir;
        /#
            recordsphere(var_4d6e0846, 15, (1, 0.5, 0), "<dev string:x30>");
        #/
        launchvelocity = vectornormalize(var_4d6e0846 - projectile.origin) * 1400;
        grenade = entity magicmissile(entity.ai.var_4a339e42, projectile.origin, launchvelocity);
        grenade thread function_8d1c1c18(grenade);
    }
    projectile clientfield::set("towers_boss_head_proj_fx_cf", 0);
    wait 0.1;
    projectile delete();
}

// Namespace zm_ai_elephant/zm_ai_elephant
// Params 2, eflags: 0x4
// Checksum 0x84a4f446, Offset: 0xc70
// Size: 0x26c
function private function_8d1c1c18(projectile, var_7c305ac4) {
    projectile endon(#"spear_death");
    result = projectile waittill(#"projectile_impact_explode");
    if (!(isdefined(projectile.isdamaged) && projectile.isdamaged)) {
        if (isdefined(result.position)) {
            id = 1;
            var_4efbb0f5 = "zm_aoe_spear";
            /#
                if (isdefined(var_7c305ac4)) {
                    id = var_7c305ac4;
                    switch (var_7c305ac4) {
                    case 2:
                        var_4efbb0f5 = "<dev string:x37>";
                        break;
                    case 3:
                        var_4efbb0f5 = "<dev string:x4a>";
                        break;
                    }
                }
            #/
            zm_aoe::function_3defe341(id, var_4efbb0f5, groundtrace(result.position + (0, 0, 8), result.position + (0, 0, -100000), 0, projectile)[#"position"]);
            zombiesarray = getaiarchetypearray("zombie");
            zombiesarray = arraycombine(zombiesarray, getaiarchetypearray("catalyst"), 0, 0);
            zombiesarray = arraycombine(zombiesarray, getaiarchetypearray("tiger"), 0, 0);
            zombiesarray = array::filter(zombiesarray, 0, &function_e1d76e4c, projectile);
            function_c4f69cd8(zombiesarray, projectile);
            physicsexplosionsphere(result.position, 200, 100, 2);
        }
    }
}

// Namespace zm_ai_elephant/zm_ai_elephant
// Params 2, eflags: 0x4
// Checksum 0xbdbe52a7, Offset: 0xee8
// Size: 0xa0
function private function_e1d76e4c(enemy, projectile) {
    if (isdefined(enemy.knockdown) && enemy.knockdown) {
        return false;
    }
    if (!isdefined(projectile)) {
        return false;
    }
    if (gibserverutils::isgibbed(enemy, 384)) {
        return false;
    }
    if (distancesquared(enemy.origin, projectile.origin) > 250 * 250) {
        return false;
    }
    return true;
}

// Namespace zm_ai_elephant/zm_ai_elephant
// Params 1, eflags: 0x4
// Checksum 0xcea50463, Offset: 0xf90
// Size: 0x56
function private function_e36ac1b0(projectile) {
    projectile endon(#"death");
    result = projectile waittill(#"damage");
    projectile.isdamaged = 1;
}

// Namespace zm_ai_elephant/zm_ai_elephant
// Params 1, eflags: 0x4
// Checksum 0xbf35fac1, Offset: 0xff0
// Size: 0x38
function private watch_for_death(projectile) {
    projectile waittill(#"death");
    waittillframeend();
    projectile notify(#"spear_death");
}

// Namespace zm_ai_elephant/zm_ai_elephant
// Params 12, eflags: 0x0
// Checksum 0xe1cd0719, Offset: 0x1030
// Size: 0x430
function function_a3577807(inflictor, attacker, damage, idflags, meansofdeath, weapon, point, dir, hitloc, offsettime, boneindex, modelindex) {
    if (isdefined(attacker) && attacker.team === self.team) {
        return 0;
    }
    if (isdefined(attacker) && !isplayer(attacker)) {
        return 0;
    }
    self.var_dfc644e4 = 1;
    if (isinarray(level.hero_weapon[#"sword_pistol"], weapon)) {
        return 500;
    }
    if (isinarray(level.hero_weapon[#"scepter"], weapon)) {
        return 50;
    }
    if (isinarray(level.hero_weapon[#"hammer"], weapon)) {
        return 250;
    }
    if (isinarray(level.hero_weapon[#"chakram"], weapon)) {
        return 250;
    }
    var_cbbda246 = 1;
    var_216599c5 = namespace_9088c704::function_fc6ac723(self, boneindex);
    if (self.ai.var_7a7bec84 == #"hash_8e173ae91589439") {
        if (isdefined(var_216599c5) && namespace_9088c704::function_4abac7be(var_216599c5) === 1) {
            var_cbbda246 = 0;
            archetypeelephant::function_4bac1576(self, damage, attacker);
        }
        if (var_cbbda246) {
            attacker playhitmarker(undefined, 1, undefined, 0);
        }
        self.health += 10;
        return 10;
    } else if (self.ai.var_7a7bec84 == #"hash_8e170ae91588f20") {
        var_216599c5 = namespace_9088c704::function_fc6ac723(self, boneindex);
        if (isdefined(var_216599c5) && namespace_9088c704::function_4abac7be(var_216599c5) === 1) {
            if (attacker hasperk(#"specialty_mod_awareness")) {
                damage *= 1.1;
                damage = int(damage);
            }
            var_cbbda246 = 0;
            attacker playhitmarker(undefined, 1, "flakjacket", 0);
            namespace_9088c704::damageweakpoint(var_216599c5, damage);
            /#
                iprintlnbold("<dev string:x5b>" + var_216599c5.health);
            #/
            if (namespace_9088c704::function_4abac7be(var_216599c5) === 3) {
                /#
                    iprintlnbold("<dev string:x6f>");
                #/
            }
        }
        if (var_cbbda246) {
            attacker playhitmarker(undefined, 1, undefined, 0);
        }
        self.health += 10;
        return 10;
    }
    if (var_cbbda246) {
        attacker playhitmarker(undefined, 1, undefined, 0);
    }
    return damage;
}

