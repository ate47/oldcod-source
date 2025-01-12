#using script_2c5daa95f8fec03c;
#using scripts\abilities\gadgets\gadget_jammer_shared;
#using scripts\core_common\ai\systems\ai_blackboard;
#using scripts\core_common\ai\systems\ai_interface;
#using scripts\core_common\ai\systems\animation_state_machine_mocomp;
#using scripts\core_common\ai\systems\animation_state_machine_notetracks;
#using scripts\core_common\ai\systems\animation_state_machine_utility;
#using scripts\core_common\ai\systems\behavior_tree_utility;
#using scripts\core_common\ai\systems\blackboard;
#using scripts\core_common\ai\zombie_utility;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\status_effects\status_effect_util;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace archetype_avogadro;

// Namespace archetype_avogadro/archetype_avogadro
// Params 0, eflags: 0x6
// Checksum 0x27cf0d07, Offset: 0x278
// Size: 0x4c
function private autoexec __init__system__() {
    system::register(#"archetype_avogadro", &function_70a657d8, &postinit, undefined, undefined);
}

// Namespace archetype_avogadro/archetype_avogadro
// Params 0, eflags: 0x5 linked
// Checksum 0x75785195, Offset: 0x2d0
// Size: 0x1e4
function private function_70a657d8() {
    registerbehaviorscriptfunctions();
    clientfield::register("missile", "" + #"hash_699d5bb1a9339a93", 1, 2, "int");
    clientfield::register("actor", "" + #"hash_4466de6137f54b59", 1, 1, "int");
    clientfield::register("actor", "" + #"hash_2eec8fc21495a18c", 1, 2, "int");
    clientfield::register("scriptmover", "" + #"hash_183ef3538fd62563", 1, 1, "int");
    clientfield::register("scriptmover", "avogadro_phase_beam", 1, getminbitcountfornum(4), "int");
    spawner::add_archetype_spawn_function(#"avogadro", &function_ee579eb5);
    spawner::function_89a2cd87(#"avogadro", &function_d1359818);
    callback::on_player_damage(&function_99ce086a);
    function_5ca95b95();
}

// Namespace archetype_avogadro/archetype_avogadro
// Params 0, eflags: 0x5 linked
// Checksum 0x5e454b39, Offset: 0x4c0
// Size: 0x2c
function private postinit() {
    level.var_2ea60515 = getstatuseffect(#"hash_3a1f530cdb5f75f4");
}

// Namespace archetype_avogadro/archetype_avogadro
// Params 0, eflags: 0x1 linked
// Checksum 0x7b0cafe3, Offset: 0x4f8
// Size: 0x73c
function registerbehaviorscriptfunctions() {
    assert(isscriptfunctionptr(&function_f8e8c129));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_520d52c557d9427", &function_f8e8c129);
    assert(isscriptfunctionptr(&function_7e5905cd));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_3a8b7da6a91d85f3", &function_7e5905cd);
    assert(isscriptfunctionptr(&function_1169b184));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_3e8335833e76fa0e", &function_1169b184);
    assert(isscriptfunctionptr(&function_afa4bed6));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_34a6a91002379d9e", &function_afa4bed6);
    assert(isscriptfunctionptr(&function_e7e003b0));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_351e1f4e4e8beb5", &function_e7e003b0);
    assert(isscriptfunctionptr(&function_14e1e2c8));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_1e90b07558cc9b1b", &function_14e1e2c8);
    assert(isscriptfunctionptr(&function_9ab1c000));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_1d3ff4cb570ac40", &function_9ab1c000);
    assert(isscriptfunctionptr(&function_3b8d314c));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_75ba4163e4512e01", &function_3b8d314c);
    assert(isscriptfunctionptr(&function_ceeb405));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_2cca123cff468ca8", &function_ceeb405);
    assert(isscriptfunctionptr(&function_b57de57a));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_2992bf38eb0ecb9c", &function_b57de57a);
    assert(isscriptfunctionptr(&function_36f6a838));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_14db413a212246df", &function_36f6a838);
    assert(isscriptfunctionptr(&function_d58f8483));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_42901d14fb88f316", &function_d58f8483);
    assert(isscriptfunctionptr(&function_95141921));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_177974191a99d4ac", &function_95141921);
    assert(isscriptfunctionptr(&function_77788917));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_6220b20470033c72", &function_77788917);
    assert(isscriptfunctionptr(&function_a495d71f));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_49880776aa68a310", &function_a495d71f, 1);
    assert(isscriptfunctionptr(&function_a495d71f));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_2b76cd8d945e7de7", &function_a495d71f, 1);
    animationstatenetwork::registernotetrackhandlerfunction("avogadro_shoot_bolt", &shoot_bolt_wait);
    animationstatenetwork::registeranimationmocomp("avogadro_tactical_walk@avogadro", &function_bc2f2686, &function_bc2f2686, undefined);
    animationstatenetwork::registeranimationmocomp("mocomp_traversal_teleport@avogadro", &function_9f3a10a4, &function_4cf6a31d, &function_7b70bdbe);
}

// Namespace archetype_avogadro/archetype_avogadro
// Params 0, eflags: 0x1 linked
// Checksum 0xe8a296f5, Offset: 0xc40
// Size: 0xdc
function function_ee579eb5() {
    self callback::function_d8abfc3d(#"on_actor_damage", &function_50a86206);
    self.shield = 1;
    self.hit_by_melee = 0;
    self.phase_time = 0;
    self.var_1ce249af = 0;
    self.var_15aa1ae0 = 2000;
    self.var_f3bbe853 = 1;
    self.var_fc782c29 = 0;
    self.var_b4ca9f11 = gettime();
    self.var_7fde19e8 = 0;
    self.var_9bff71aa = 0;
    self.var_696e2d53 = 0;
    self.var_e3b6f14a = 1;
    self function_8a404313();
}

// Namespace archetype_avogadro/archetype_avogadro
// Params 0, eflags: 0x5 linked
// Checksum 0x778a646d, Offset: 0xd28
// Size: 0x4a
function private function_8a404313() {
    blackboard::createblackboardforentity(self);
    ai::createinterfaceforentity(self);
    self.___archetypeonanimscriptedcallback = &function_c7791d22;
}

// Namespace archetype_avogadro/archetype_avogadro
// Params 1, eflags: 0x5 linked
// Checksum 0x10a413ce, Offset: 0xd80
// Size: 0x2c
function private function_c7791d22(entity) {
    entity.__blackboard = undefined;
    entity function_8a404313();
}

// Namespace archetype_avogadro/archetype_avogadro
// Params 0, eflags: 0x1 linked
// Checksum 0x2c42e4b, Offset: 0xdb8
// Size: 0x34
function function_d1359818() {
    function_dbc638a8(self);
    namespace_81245006::initweakpoints(self);
}

// Namespace archetype_avogadro/archetype_avogadro
// Params 12, eflags: 0x1 linked
// Checksum 0x1197b837, Offset: 0xdf8
// Size: 0x64
function function_99ce086a(*inflictor, *attacker, *damage, *flags, *meansofdeath, *weapon, *vpoint, *vdir, *shitloc, *psoffsettime, *boneindex, *surfacetype) {
    
}

// Namespace archetype_avogadro/archetype_avogadro
// Params 1, eflags: 0x1 linked
// Checksum 0x2c11c69c, Offset: 0xe68
// Size: 0xcc
function function_dbc638a8(entity) {
    var_5a8e6bf6 = entity.health / entity.maxhealth;
    var_5a8e6bf6 = int(var_5a8e6bf6 * 100);
    var_f8c4006a = 3;
    if (var_5a8e6bf6 <= 33) {
        var_f8c4006a = 1;
    } else if (var_5a8e6bf6 <= 67 && var_5a8e6bf6 > 33) {
        var_f8c4006a = 2;
    }
    entity clientfield::set("" + #"hash_2eec8fc21495a18c", var_f8c4006a);
}

// Namespace archetype_avogadro/archetype_avogadro
// Params 1, eflags: 0x1 linked
// Checksum 0x8888ba2a, Offset: 0xf40
// Size: 0x84
function function_50a86206(params) {
    if (!isdefined(self.var_fc782c29) || !isdefined(self.var_b4ca9f11) || self.var_b4ca9f11 < gettime()) {
        self.var_fc782c29 = 0;
        self.var_b4ca9f11 = gettime() + 2000;
    }
    self.var_fc782c29 += params.idamage;
    function_dbc638a8(self);
}

// Namespace archetype_avogadro/archetype_avogadro
// Params 1, eflags: 0x1 linked
// Checksum 0x12ed2f80, Offset: 0xfd0
// Size: 0x38
function get_target_ent(entity) {
    if (isdefined(entity.attackable)) {
        return entity.attackable;
    }
    return entity.favoriteenemy;
}

// Namespace archetype_avogadro/archetype_avogadro
// Params 1, eflags: 0x0
// Checksum 0x1a99d6f9, Offset: 0x1010
// Size: 0x62
function function_80fc1a78(time) {
    self notify("7373214be9aec245");
    self endon("7373214be9aec245");
    self endon(#"death", #"hash_7d29584dcbbe7d67");
    self show();
    wait time;
}

// Namespace archetype_avogadro/archetype_avogadro
// Params 1, eflags: 0x5 linked
// Checksum 0x4a3b09e9, Offset: 0x1080
// Size: 0x34c
function private function_f8e8c129(entity) {
    if (is_false(entity.can_shoot)) {
        return false;
    }
    enemy = get_target_ent(entity);
    if (!isdefined(enemy)) {
        return false;
    }
    if (!function_aa6fbf56(entity)) {
        return false;
    }
    if (function_7a19f38(enemy)) {
        return false;
    }
    if (isdefined(level.var_a35afcb2) && ![[ level.var_a35afcb2 ]](entity)) {
        return false;
    }
    if (isdefined(enemy)) {
        vec_enemy = enemy.origin - self.origin;
        dist_sq = lengthsquared(vec_enemy);
        if ((dist_sq > 14400 || is_false(entity.can_phase)) && dist_sq < 2250000) {
            vec_facing = anglestoforward(self.angles);
            norm_facing = vectornormalize(vec_facing);
            norm_enemy = vectornormalize(vec_enemy);
            dot = vectordot(norm_facing, norm_enemy);
            var_482d3bba = (vec_facing[0], vec_facing[1], 0);
            var_45ed4f50 = vectornormalize((vec_facing[0], vec_facing[1], 0));
            var_9743030a = vectornormalize((vec_enemy[0], vec_enemy[1], 0));
            var_5e958f82 = vectordot(var_45ed4f50, var_9743030a);
            if (dot > 0.707 && var_5e958f82 > 0.99) {
                var_f6a4b2f3 = enemy getcentroid();
                if (issentient(enemy)) {
                    var_f6a4b2f3 = enemy geteye();
                }
                eye_pos = self geteye();
                traceresult = bullettrace(eye_pos, var_f6a4b2f3, 0, isentity(enemy) ? enemy : undefined);
                if (traceresult[#"fraction"] == 1) {
                    return true;
                }
            }
        }
    }
    return false;
}

// Namespace archetype_avogadro/archetype_avogadro
// Params 1, eflags: 0x5 linked
// Checksum 0x67c3b6bb, Offset: 0x13d8
// Size: 0xd8
function private function_aa6fbf56(entity) {
    var_99387d40 = blackboard::getblackboardevents(#"hash_27bee30b37f7debe");
    if (isdefined(var_99387d40) && var_99387d40.size) {
        foreach (var_9fb4c4cc in var_99387d40) {
            if (var_9fb4c4cc.data.entity === entity) {
                return false;
            }
        }
    }
    return true;
}

// Namespace archetype_avogadro/archetype_avogadro
// Params 1, eflags: 0x5 linked
// Checksum 0x3b72eb0c, Offset: 0x14b8
// Size: 0x5a
function private function_7a19f38(enemy) {
    if (is_true(enemy.usingvehicle)) {
        vehicle = enemy getvehicleoccupied();
        if (vehicle.emped) {
            return true;
        }
    }
    return false;
}

// Namespace archetype_avogadro/archetype_avogadro
// Params 1, eflags: 0x5 linked
// Checksum 0x3922996d, Offset: 0x1520
// Size: 0x54
function private function_afa4bed6(entity) {
    decision = randomint(2);
    entity setblackboardattribute("_ranged_attack_variant", decision);
}

// Namespace archetype_avogadro/archetype_avogadro
// Params 1, eflags: 0x5 linked
// Checksum 0x3561ced3, Offset: 0x1580
// Size: 0xdc
function private function_7e5905cd(entity) {
    enemy = self.favoriteenemy;
    if (isdefined(enemy)) {
        self.shield = 1;
        self notify(#"hash_7d29584dcbbe7d67");
        self show();
    }
    var_8706203c = 500;
    if (isdefined(entity.var_fffac33)) {
        var_8706203c = [[ entity.var_fffac33 ]](entity);
    }
    blackboard::addblackboardevent(#"hash_27bee30b37f7debe", {#entity:self}, randomintrange(2000, 3000));
}

// Namespace archetype_avogadro/archetype_avogadro
// Params 1, eflags: 0x5 linked
// Checksum 0xe5c68793, Offset: 0x1668
// Size: 0x110
function private function_e7e003b0(entity) {
    if (!isdefined(self.var_8f78592b)) {
        return false;
    }
    var_aa313325 = entity [[ entity.var_8f78592b ]](entity);
    if (!var_aa313325) {
        return false;
    }
    var_a430e28e = blackboard::getblackboardevents(#"hash_71e87bb4fbe53c16");
    if (isdefined(var_a430e28e) && var_a430e28e.size) {
        foreach (var_73fafdf0 in var_a430e28e) {
            if (var_73fafdf0.data.entity === entity) {
                return false;
            }
        }
    }
    return true;
}

// Namespace archetype_avogadro/archetype_avogadro
// Params 1, eflags: 0x5 linked
// Checksum 0xe49579af, Offset: 0x1780
// Size: 0x5c
function private function_14e1e2c8(*entity) {
    blackboard::addblackboardevent(#"hash_71e87bb4fbe53c16", {#entity:self}, randomintrange(2000, 3000));
}

// Namespace archetype_avogadro/archetype_avogadro
// Params 1, eflags: 0x5 linked
// Checksum 0x30facb6e, Offset: 0x17e8
// Size: 0x274
function private shoot_bolt_wait(entity) {
    if (!isdefined(get_target_ent(entity))) {
        return;
    }
    enemy = get_target_ent(entity);
    target_pos = enemy getcentroid();
    if (issentient(enemy)) {
        target_pos = enemy geteye();
    }
    target_velocity = enemy getvelocity();
    if (isplayer(enemy)) {
        target_pos += (0, 0, -12);
        if (enemy isinvehicle()) {
            target_velocity = enemy getvehicleoccupied() getvelocity();
        }
    }
    source_pos = self gettagorigin("tag_weapon_right");
    velocity = target_pos - source_pos;
    var_cfca9f29 = length(velocity) / 800;
    target_pos += target_velocity * var_cfca9f29 * randomfloatrange(0, 1);
    /#
        recordsphere(target_pos, 10, (0, 1, 0), "<dev string:x38>");
    #/
    velocity = target_pos - source_pos;
    velocity = vectornormalize(velocity);
    velocity *= 800;
    bolt = entity magicmissile(getweapon(#"hash_28832732f6432c98"), source_pos, velocity);
    if (!isdefined(bolt)) {
        return;
    }
    bolt function_b1b41f33(entity);
}

// Namespace archetype_avogadro/archetype_avogadro
// Params 1, eflags: 0x1 linked
// Checksum 0xcbd35604, Offset: 0x1a68
// Size: 0x144
function function_b1b41f33(owner) {
    self endon(#"death");
    self.owner = owner;
    self clientfield::set("" + #"hash_699d5bb1a9339a93", 1);
    self thread function_dec8144d();
    waitresult = self function_5f86757d();
    if (!isdefined(owner) || !isdefined(waitresult)) {
        return;
    }
    if (waitresult._notify == #"explode" && isdefined(waitresult.position)) {
        owner callback::callback(#"hash_c1d64b00f1dc607", {#origin:waitresult.position, #radius:self.weapon.explosionradius, #jammer:self});
    }
}

// Namespace archetype_avogadro/archetype_avogadro
// Params 0, eflags: 0x1 linked
// Checksum 0xb806391d, Offset: 0x1bb8
// Size: 0x1b0
function function_dec8144d() {
    self endon(#"death", #"explode");
    self.takedamage = 1;
    self.maxhealth = 50;
    self.health = 50;
    if (isdefined(self.owner) && isdefined(self.owner.maxhealth)) {
        self.maxhealth = int(0.05 * self.owner.maxhealth);
        self.health = self.maxhealth;
    }
    while (isdefined(self)) {
        waitresult = self waittill(#"damage");
        if (waitresult.mod === "MOD_PISTOL_BULLET" || waitresult.mod === "MOD_RIFLE_BULLET" || waitresult.mod === "MOD_PROJECTILE") {
            if (self.health <= 0) {
                var_5fae82a9 = spawn("script_model", self.origin);
                var_5fae82a9 setmodel("tag_origin");
                var_5fae82a9 thread function_5f54a393();
                self deletedelay();
            }
        }
    }
}

// Namespace archetype_avogadro/archetype_avogadro
// Params 0, eflags: 0x1 linked
// Checksum 0xbb18b67c, Offset: 0x1d70
// Size: 0x4c
function function_5f54a393() {
    self clientfield::set("" + #"hash_183ef3538fd62563", 1);
    wait 5;
    self deletedelay();
}

// Namespace archetype_avogadro/archetype_avogadro
// Params 0, eflags: 0x1 linked
// Checksum 0x42c5b6f0, Offset: 0x1dc8
// Size: 0xb0
function function_5f86757d() {
    level endon(#"game_ended");
    waitresult = self waittill(#"explode", #"death");
    if (!isdefined(self)) {
        return waitresult;
    }
    playsoundatposition(#"hash_525786cd7853a7a0", self.origin);
    self clientfield::set("" + #"hash_699d5bb1a9339a93", 0);
    return waitresult;
}

// Namespace archetype_avogadro/archetype_avogadro
// Params 1, eflags: 0x1 linked
// Checksum 0x34fa2821, Offset: 0x1e80
// Size: 0x36
function function_95141921(entity) {
    function_dbc638a8(entity);
    self.phase_time = gettime() - 1;
}

// Namespace archetype_avogadro/archetype_avogadro
// Params 0, eflags: 0x1 linked
// Checksum 0x945f6575, Offset: 0x1ec0
// Size: 0x90
function function_5ca95b95() {
    level.var_be622b90 = [];
    for (i = 0; i < 3; i++) {
        level.var_be622b90[i] = array(util::spawn_model(#"tag_origin"), util::spawn_model(#"tag_origin"));
    }
}

// Namespace archetype_avogadro/archetype_avogadro
// Params 1, eflags: 0x1 linked
// Checksum 0x2f3f9a07, Offset: 0x1f58
// Size: 0x152
function function_205c9932(entity) {
    foreach (index, array in level.var_be622b90) {
        if (isdefined(array[0].owner) || isdefined(array[1].owner)) {
            continue;
        }
        foreach (ent in array) {
            ent.owner = entity;
        }
        return {#id:index + 1, #array:array};
    }
}

// Namespace archetype_avogadro/archetype_avogadro
// Params 1, eflags: 0x1 linked
// Checksum 0xaec0149f, Offset: 0x20b8
// Size: 0xaa
function function_c6e09354(var_78dd7804) {
    foreach (ent in var_78dd7804.array) {
        ent clientfield::set("avogadro_phase_beam", 0);
        ent.owner = undefined;
    }
}

// Namespace archetype_avogadro/archetype_avogadro
// Params 1, eflags: 0x1 linked
// Checksum 0x48234cb2, Offset: 0x2170
// Size: 0x3c
function function_2e3c588(*notifyhash) {
    if (isdefined(self) && isdefined(self.var_78dd7804)) {
        function_c6e09354(self.var_78dd7804);
    }
}

// Namespace archetype_avogadro/archetype_avogadro
// Params 1, eflags: 0x1 linked
// Checksum 0xc50ecc0d, Offset: 0x21b8
// Size: 0x11e
function function_d979c854(entity) {
    entity endoncallback(&function_2e3c588, #"death");
    var_78dd7804 = entity.var_78dd7804;
    foreach (ent in var_78dd7804.array) {
        ent clientfield::set("avogadro_phase_beam", var_78dd7804.id);
    }
    util::wait_network_frame();
    function_c6e09354(var_78dd7804);
    if (isdefined(entity)) {
        entity.var_78dd7804 = undefined;
    }
}

// Namespace archetype_avogadro/archetype_avogadro
// Params 1, eflags: 0x1 linked
// Checksum 0x2ccf3f83, Offset: 0x22e0
// Size: 0x146
function function_a495d71f(entity) {
    if (!function_2eb165a4(entity)) {
        return 0;
    }
    entity.var_78dd7804 = function_205c9932(entity);
    if (!isdefined(entity.var_78dd7804)) {
        return 0;
    }
    endpoint = function_c3ceb539(entity);
    if (!isdefined(endpoint)) {
        function_c6e09354(entity.var_78dd7804);
        entity.var_78dd7804 = undefined;
        return 0;
    }
    entity.endpoint = endpoint;
    var_dd695160 = entity gettagorigin("j_spine4") - entity.origin;
    entity.var_78dd7804.array[0].origin = entity.origin + var_dd695160;
    entity.var_78dd7804.array[1].origin = entity.endpoint + var_dd695160;
}

// Namespace archetype_avogadro/archetype_avogadro
// Params 1, eflags: 0x1 linked
// Checksum 0x8b61dd7e, Offset: 0x2430
// Size: 0x32a
function function_2eb165a4(entity) {
    if (isdefined(level.var_8791f7c5) && ![[ level.var_8791f7c5 ]](entity)) {
        return false;
    }
    if (entity.phase_time > gettime()) {
        return false;
    }
    if (isdefined(entity.var_78dd7804)) {
        return false;
    }
    target = get_target_ent(entity);
    var_c5504ae5 = 1 / 4;
    var_5a8e6bf6 = entity.health / entity.maxhealth;
    if (!isdefined(entity.var_f89ee7ac)) {
        entity.var_f89ee7ac = 1 - var_c5504ae5;
    }
    if (var_5a8e6bf6 <= entity.var_f89ee7ac) {
        entity.var_f89ee7ac = var_5a8e6bf6 - var_c5504ae5;
        return true;
    }
    if (isdefined(entity.favoriteenemy)) {
        if (isplayer(entity.favoriteenemy) && entity.favoriteenemy isinvehicle()) {
            return false;
        }
        var_bec89360 = distancesquared(entity.favoriteenemy.origin, entity.origin);
        if (var_bec89360 <= function_a3f6cdac(200)) {
            return true;
        }
        if (var_bec89360 >= function_a3f6cdac(1500)) {
            return true;
        }
        if (target === entity.favoriteenemy && !entity seerecently(entity.favoriteenemy, 1)) {
            return true;
        }
    }
    if (isdefined(entity.attackable)) {
        var_bec89360 = distancesquared(entity.attackable.origin, entity.origin);
        if (var_bec89360 <= function_a3f6cdac(200)) {
            return true;
        }
        if (var_bec89360 >= function_a3f6cdac(1500)) {
            return true;
        }
        var_f5f64fa2 = entity geteye();
        var_ac89c6e3 = entity.attackable getcentroid();
        if (target === entity.attackable && !sighttracepassed(var_f5f64fa2, var_ac89c6e3, 0, entity.attackable)) {
            return true;
        }
    }
    return false;
}

// Namespace archetype_avogadro/archetype_avogadro
// Params 1, eflags: 0x1 linked
// Checksum 0xe2c398c2, Offset: 0x2768
// Size: 0x696
function function_c3ceb539(entity) {
    test_points = [];
    target = get_target_ent(entity);
    var_5494b2e9 = 0;
    self.can_phase = 0;
    if (isdefined(entity.attackable) && entity.attackable === target) {
        var_5494b2e9 = 1;
        test_points = array();
        slots = array::randomize(entity.attackable.var_b79a8ac7.slots);
        point_count = int(min(slots.size, 3));
        for (i = 0; i < point_count; i++) {
            slot = slots[i];
            angles = vectortoangles(slot.origin - entity.attackable.origin);
            test_points[test_points.size] = entity.attackable.origin + anglestoforward((0, angles[1], 0)) * randomfloatrange(150, 500);
        }
    } else if (isplayer(entity.favoriteenemy) && entity.favoriteenemy === target) {
        var_5494b2e9 = 1;
        var_529624a4 = entity.favoriteenemy getplayerangles();
        test_points = array(entity.favoriteenemy.origin + anglestoforward((0, angleclamp180(var_529624a4[1] + randomfloatrange(20, 40) / 2), 0)) * randomfloatrange(1000, 1500), entity.favoriteenemy.origin + anglestoforward((0, angleclamp180(var_529624a4[1] - randomfloatrange(20, 40) / 2), 0)) * randomfloatrange(1000, 1500));
    } else if (isalive(entity.favoriteenemy) && entity.favoriteenemy === target) {
        var_5494b2e9 = 1;
        test_points = array(entity.favoriteenemy.origin + anglestoforward((0, randomfloat(180), 0)) * randomfloatrange(1000, 1500), entity.favoriteenemy.origin + anglestoforward((0, randomfloat(180) * -1, 0)) * randomfloatrange(1000, 1500));
    } else {
        return undefined;
    }
    enemy = target;
    test_points = array::randomize(test_points);
    if (var_5494b2e9) {
        bestpoint = undefined;
        foreach (point in test_points) {
            bestpoint = function_3d3ee1a4(entity, point, enemy);
            if (isdefined(bestpoint)) {
                break;
            }
        }
    } else {
        bestpoint = test_points[0];
    }
    /#
        if (isdefined(bestpoint)) {
            recordsphere(bestpoint, 15, (0, 0, 1), "<dev string:x38>");
            recordline(entity.origin, bestpoint, (0, 0, 1), "<dev string:x38>");
        }
        if (isplayer(entity.favoriteenemy)) {
            player_angles = entity.favoriteenemy getplayerangles();
            if (isdefined(player_angles) && isdefined(bestpoint)) {
                var_891a94cf = anglestoforward(player_angles);
                var_e4529f5f = acos(vectordot(var_891a94cf, vectornormalize(bestpoint - entity.favoriteenemy.origin)));
                distsqrd = distancesquared(bestpoint, entity.favoriteenemy.origin);
                dist = sqrt(distsqrd);
            }
        }
    #/
    self.can_phase = isdefined(bestpoint);
    return bestpoint;
}

// Namespace archetype_avogadro/archetype_avogadro
// Params 1, eflags: 0x1 linked
// Checksum 0xe6757ed7, Offset: 0x2e08
// Size: 0xbe
function function_77788917(*entity) {
    self playsound(#"hash_64bb457a8c6f828c");
    self clientfield::set("" + #"hash_2eec8fc21495a18c", 120);
    self ghost();
    self notsolid();
    if (isdefined(self.var_78dd7804)) {
        function_c6e09354(self.var_78dd7804);
        self.var_78dd7804 = undefined;
    }
}

// Namespace archetype_avogadro/archetype_avogadro
// Params 3, eflags: 0x1 linked
// Checksum 0xb716cd5a, Offset: 0x2ed0
// Size: 0x316
function function_3d3ee1a4(entity, point, enemy) {
    groundpos = groundtrace(point + (0, 0, 500) + (0, 0, 8), point + (0, 0, 500) + (0, 0, -100000), 0, entity)[#"position"];
    if (groundpos[2] < point[2] - 2000) {
        /#
            recordsphere(point, 10, (1, 0, 0), "<dev string:x38>", entity);
        #/
        return undefined;
    }
    nextpos = getclosestpointonnavmesh(groundpos, 128, entity getpathfindingradius());
    if (!isdefined(nextpos)) {
        /#
            recordsphere(point, 10, (1, 0, 0), "<dev string:x38>", entity);
        #/
        return undefined;
    }
    if (isdefined(enemy)) {
        var_94324c7a = getclosestpointonnavmesh(enemy.origin, 128, entity getpathfindingradius());
        if (isdefined(var_94324c7a)) {
            nextpos = checknavmeshdirection(var_94324c7a, nextpos - var_94324c7a, distance(nextpos, var_94324c7a), entity getpathfindingradius());
            if (isdefined(entity.favoriteenemy) && distancesquared(var_94324c7a, nextpos) <= function_a3f6cdac(1000)) {
                /#
                    recordsphere(nextpos, 10, (1, 0, 0), "<dev string:x38>", entity);
                #/
                return undefined;
            }
        }
    }
    groundpos = groundtrace(nextpos + (0, 0, 500) + (0, 0, 8), nextpos + (0, 0, 500) + (0, 0, -100000), 0, entity)[#"position"];
    if (abs(nextpos[2] - groundpos[2]) > 5) {
        return undefined;
    }
    if (isdefined(nextpos) && distancesquared(entity.origin, nextpos) < 700) {
        return undefined;
    }
    return nextpos;
}

// Namespace archetype_avogadro/archetype_avogadro
// Params 1, eflags: 0x1 linked
// Checksum 0x37e26e37, Offset: 0x31f0
// Size: 0x18
function function_9ab1c000(entity) {
    return isdefined(entity.var_78dd7804);
}

// Namespace archetype_avogadro/archetype_avogadro
// Params 1, eflags: 0x1 linked
// Checksum 0xb5e915bc, Offset: 0x3210
// Size: 0x1a
function function_3b8d314c(entity) {
    entity.blockingpain = 1;
}

// Namespace archetype_avogadro/archetype_avogadro
// Params 1, eflags: 0x1 linked
// Checksum 0xd2aabcc6, Offset: 0x3238
// Size: 0x3c
function function_ceeb405(entity) {
    entity.blockingpain = 0;
    if (isdefined(entity.var_78dd7804)) {
        entity thread function_d979c854(entity);
    }
}

// Namespace archetype_avogadro/archetype_avogadro
// Params 1, eflags: 0x1 linked
// Checksum 0xc2d314d1, Offset: 0x3280
// Size: 0x22
function function_36f6a838(entity) {
    entity.phase_time = gettime() + entity.var_15aa1ae0;
}

// Namespace archetype_avogadro/archetype_avogadro
// Params 1, eflags: 0x1 linked
// Checksum 0x653ef10, Offset: 0x32b0
// Size: 0xc4
function function_b57de57a(entity) {
    entity dontinterpolate();
    angles = entity.angles;
    target = get_target_ent(entity);
    if (isdefined(target)) {
        angles = vectortoangles(target.origin - entity.endpoint);
    }
    if (isdefined(entity.endpoint)) {
        entity forceteleport(entity.endpoint, (0, angles[1], 0));
    }
}

// Namespace archetype_avogadro/archetype_avogadro
// Params 1, eflags: 0x1 linked
// Checksum 0xf9b16bf6, Offset: 0x3380
// Size: 0x24
function function_1169b184(entity) {
    function_dbc638a8(entity);
}

// Namespace archetype_avogadro/archetype_avogadro
// Params 1, eflags: 0x1 linked
// Checksum 0x2c097aa1, Offset: 0x33b0
// Size: 0x1d8
function function_d58f8483(entity) {
    target = get_target_ent(entity);
    if (isdefined(target) && distancesquared(entity.origin, target.origin) <= function_a3f6cdac(1500)) {
        assert(isdefined(entity.var_696e2d53) && isdefined(entity.var_e3b6f14a), "<dev string:x42>");
        if (gettime() < entity.var_696e2d53) {
            return entity.var_e3b6f14a;
        }
        entity.var_696e2d53 = gettime();
        var_32eb9058 = isentity(target) ? target getcentroid() : target.origin;
        traceresult = bullettrace(entity geteye(), var_32eb9058, 0, isentity(target) ? target : undefined);
        if (traceresult[#"fraction"] == 1) {
            entity.var_e3b6f14a = 1;
            return 1;
        }
    }
    entity.var_e3b6f14a = 0;
    entity.var_696e2d53 = gettime() + randomintrangeinclusive(800, 1000);
    return 0;
}

// Namespace archetype_avogadro/archetype_avogadro
// Params 5, eflags: 0x1 linked
// Checksum 0x2e660a1d, Offset: 0x3590
// Size: 0x13c
function function_bc2f2686(entity, *mocompanim, *mocompanimblendouttime, *mocompanimflag, *mocompduration) {
    mocompduration animmode("normal", 0);
    target = get_target_ent(mocompduration);
    if (isdefined(mocompduration.attackable) && mocompduration.attackable === target) {
        mocompduration orientmode("face point", mocompduration.attackable getcentroid());
        return;
    }
    if (isdefined(mocompduration.favoriteenemy) && mocompduration.favoriteenemy === target) {
        mocompduration orientmode("face point", mocompduration.favoriteenemy.origin);
        return;
    }
    mocompduration orientmode("face default");
}

// Namespace archetype_avogadro/archetype_avogadro
// Params 5, eflags: 0x1 linked
// Checksum 0x27b3dbe3, Offset: 0x36d8
// Size: 0x13e
function function_9f3a10a4(entity, mocompanim, *mocompanimblendouttime, *mocompanimflag, *mocompduration) {
    mocompanimflag animmode("normal", 0);
    mocompanimflag.blockingpain = 1;
    mocompanimflag.var_78dd7804 = function_205c9932(mocompanimflag);
    if (isdefined(mocompanimflag.var_78dd7804)) {
        mocompanimflag.var_78dd7804.array[0].origin = mocompanimflag.traversalstartpos;
        mocompanimflag.var_78dd7804.array[1].origin = mocompanimflag.traversalendpos;
    }
    mocompanimflag.var_d39541c9 = {#var_deb95e3f:getnotetracktimes(mocompduration, "phase_start")[0], #var_c970f455:getnotetracktimes(mocompduration, "phase_end")[0]};
}

// Namespace archetype_avogadro/archetype_avogadro
// Params 5, eflags: 0x1 linked
// Checksum 0xcb2679be, Offset: 0x3820
// Size: 0x16a
function function_4cf6a31d(entity, mocompanim, *mocompanimblendouttime, *mocompanimflag, *mocompduration) {
    if (mocompanimflag getanimtime(mocompduration) >= mocompanimflag.var_d39541c9.var_deb95e3f && !is_true(mocompanimflag.var_d39541c9.var_50524dbd)) {
        if (isdefined(mocompanimflag.var_78dd7804)) {
            mocompanimflag thread function_d979c854(mocompanimflag);
        }
        mocompanimflag.var_d39541c9.var_50524dbd = 1;
    }
    if (mocompanimflag getanimtime(mocompduration) >= mocompanimflag.var_d39541c9.var_c970f455 && !is_true(mocompanimflag.var_d39541c9.var_90a731c)) {
        mocompanimflag dontinterpolate();
        mocompanimflag forceteleport(mocompanimflag.traversalendpos, mocompanimflag.angles, 0);
        mocompanimflag.var_d39541c9.var_90a731c = 1;
    }
}

// Namespace archetype_avogadro/archetype_avogadro
// Params 5, eflags: 0x1 linked
// Checksum 0x65457db0, Offset: 0x3998
// Size: 0x4e
function function_7b70bdbe(entity, *mocompanim, *mocompanimblendouttime, *mocompanimflag, *mocompduration) {
    mocompduration.blockingpain = 0;
    mocompduration.var_78dd7804 = undefined;
    mocompduration.var_d39541c9 = undefined;
}

