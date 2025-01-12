#using script_1940fc077a028a81;
#using script_2c5daa95f8fec03c;
#using script_3357acf79ce92f4b;
#using script_3411bb48d41bd3b;
#using script_3819e7a1427df6d2;
#using scripts\core_common\aat_shared;
#using scripts\core_common\ai\archetype_avogadro;
#using scripts\core_common\ai\systems\ai_interface;
#using scripts\core_common\ai\systems\behavior_tree_utility;
#using scripts\core_common\ai\systems\blackboard;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\status_effects\status_effect_util;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\zm_common\zm_powerups;

#namespace namespace_9f3d3e9;

// Namespace namespace_9f3d3e9/namespace_9f3d3e9
// Params 0, eflags: 0x6
// Checksum 0x36436d4d, Offset: 0x2c8
// Size: 0x54
function private autoexec __init__system__() {
    system::register(#"wz_ai_avogadro", &function_70a657d8, undefined, &function_4df027f2, #"archetype_avogadro");
}

// Namespace namespace_9f3d3e9/namespace_9f3d3e9
// Params 0, eflags: 0x4
// Checksum 0x271156fd, Offset: 0x328
// Size: 0x1d4
function private function_70a657d8() {
    spawner::add_archetype_spawn_function(#"avogadro", &function_f34df3c);
    spawner::function_89a2cd87(#"avogadro", &function_c41e67c);
    level.var_8791f7c5 = &function_ac94df05;
    level.var_a35afcb2 = &function_7d5cf0e4;
    assert(isscriptfunctionptr(&function_f498585b));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_76e19aed5b42448f", &function_f498585b);
    assert(isscriptfunctionptr(&function_5871bcf8));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_408e0b3d57595bf7", &function_5871bcf8, 1);
    assert(isscriptfunctionptr(&function_14b5c940));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_21f9e6b4d52f79cb", &function_14b5c940);
}

// Namespace namespace_9f3d3e9/namespace_9f3d3e9
// Params 0, eflags: 0x0
// Checksum 0xa13ecc83, Offset: 0x508
// Size: 0xac
function function_4df027f2() {
    level thread aat::register_immunity("zm_aat_kill_o_watt", #"avogadro", 1, 1, 1);
    level thread aat::register_immunity("zm_aat_brain_decay", #"avogadro", 1, 1, 1);
    level thread aat::register_immunity("zm_aat_plasmatic_burst", #"avogadro", 1, 1, 1);
}

// Namespace namespace_9f3d3e9/namespace_9f3d3e9
// Params 0, eflags: 0x4
// Checksum 0xb2d7d9f0, Offset: 0x5c0
// Size: 0x382
function private function_f34df3c() {
    blackboard::createblackboardforentity(self);
    ai::createinterfaceforentity(self);
    self callback::function_d8abfc3d(#"hash_10ab46b52df7967a", &namespace_85745671::function_5cb3181e);
    self.var_8f78592b = &namespace_e292b080::zombieshouldmelee;
    self.cant_move_cb = &function_9c573bc6;
    self.var_31a789c0 = 1;
    self.var_1c0eb62a = 180;
    self.var_13138acf = 1;
    self.var_e729ffb = 2;
    self.var_1731eda3 = 1;
    self.var_721a3dbd = 1;
    self.var_8f61d7f4 = 1;
    self.var_4cc2bf28 = 0;
    self.var_90d0c0ff = "anim_avogadro_spawn";
    self.var_ecbef856 = "anim_avogadro_despawn";
    self.despawn_anim = "ai_t9_zm_avogadro_exit";
    self.var_c11b8a5a = 1;
    self.var_e9c62827 = 1;
    self.ai.var_870d0893 = 1;
    self.no_powerups = 1;
    self.var_b3c613a7 = [1, 1, 1, 1, 1];
    self.var_414bc881 = 1;
    self namespace_85745671::function_9758722("walk");
    self callback::function_d8abfc3d(#"on_ai_damage", &function_ce2bd83c);
    self callback::function_d8abfc3d(#"on_ai_killed", &function_8886bcc4);
    self callback::function_d8abfc3d(#"on_ai_melee", &namespace_85745671::function_b8eb5dea);
    self callback::function_d8abfc3d(#"hash_7140c3848cbefaa1", &function_e44ef704);
    self callback::function_d8abfc3d(#"hash_3bb51ce51020d0eb", &namespace_85745671::function_16e2f075);
    self callback::function_d8abfc3d(#"hash_c1d64b00f1dc607", &function_f59c1777);
    self callback::function_d8abfc3d(#"hash_4afe635f36531659", &awareness::function_c6b1009e);
    aiutility::addaioverridedamagecallback(self, &function_1fef432);
    self.completed_emerging_into_playable_area = 1;
    self ghost();
    if (!isdefined(self)) {
        return;
    }
    /#
        self.var_6c408220 = &function_c698f66b;
    #/
}

// Namespace namespace_9f3d3e9/namespace_9f3d3e9
// Params 0, eflags: 0x4
// Checksum 0x78efb90c, Offset: 0x950
// Size: 0x5c
function private function_c41e67c() {
    self endon(#"death");
    self show();
    function_905d3c1a(self);
    self function_99cad91e();
}

// Namespace namespace_9f3d3e9/namespace_9f3d3e9
// Params 0, eflags: 0x0
// Checksum 0x945561bd, Offset: 0x9b8
// Size: 0x164
function function_9c573bc6() {
    self notify("e29234e265ef313");
    self endon("3094caecf1093030", #"death");
    if (isdefined(self.enemy_override)) {
        return;
    }
    if (is_true(self.allowoffnavmesh) && is_true(level.var_5e8121a) && is_true(self.var_35eedf58)) {
        self.var_ef59b90 = 5;
        return;
    } else if (self.aistate === 3 && is_true(self.var_5a8f690)) {
        if (isdefined(self.favoriteenemy) && is_true(self.var_de6e22f7) && !self.var_13138acf) {
            self.var_ef59b90 = 6;
            return;
        }
        self.var_ef59b90 = 5;
        return;
    }
    self collidewithactors(0);
    wait 2;
    self collidewithactors(1);
}

// Namespace namespace_9f3d3e9/namespace_9f3d3e9
// Params 0, eflags: 0x0
// Checksum 0x75e2d9c8, Offset: 0xb28
// Size: 0x1dc
function function_99cad91e() {
    self.has_awareness = 1;
    self.ignorelaststandplayers = 1;
    self.fovcosine = 0.2;
    self.maxsightdistsqrd = function_a3f6cdac(1000);
    self.var_1267fdea = 1;
    self callback::function_d8abfc3d(#"on_ai_damage", &awareness::function_5f511313);
    awareness::register_state(self, #"wander", &function_83e04f3c, &awareness::function_4ebe4a6d, &awareness::function_b264a0bc, undefined, &awareness::function_555d960b);
    awareness::register_state(self, #"investigate", &function_92c28840, &awareness::function_9eefc327, &awareness::function_34162a25, undefined, &awareness::function_a360dd00);
    awareness::register_state(self, #"chase", &function_b28bc84e, &function_f8aa7ab9, &function_cea6c5e9, &function_93d792b9, undefined);
    awareness::set_state(self, #"wander");
    self thread awareness::function_fa6e010d();
}

// Namespace namespace_9f3d3e9/namespace_9f3d3e9
// Params 1, eflags: 0x0
// Checksum 0x26efd365, Offset: 0xd10
// Size: 0x7c
function function_83e04f3c(entity) {
    self.fovcosine = 0.2;
    self.maxsightdistsqrd = function_a3f6cdac(1000);
    self.var_1267fdea = 0;
    entity namespace_85745671::function_9758722("walk");
    awareness::function_9c9d96b5(entity);
}

// Namespace namespace_9f3d3e9/namespace_9f3d3e9
// Params 1, eflags: 0x0
// Checksum 0xc0b8fef8, Offset: 0xd98
// Size: 0x5c
function function_92c28840(entity) {
    self.fovcosine = 0;
    self.maxsightdistsqrd = function_a3f6cdac(1800);
    self.var_1267fdea = 0;
    awareness::function_b41f0471(entity);
}

// Namespace namespace_9f3d3e9/namespace_9f3d3e9
// Params 1, eflags: 0x0
// Checksum 0x66a94b37, Offset: 0xe00
// Size: 0x94
function function_b28bc84e(entity) {
    self.fovcosine = 0;
    self.maxsightdistsqrd = function_a3f6cdac(3000);
    self.var_1267fdea = 0;
    entity namespace_85745671::function_9758722("run");
    entity.maxsightdistsqrd = function_a3f6cdac(2000);
    awareness::function_978025e4(entity);
}

// Namespace namespace_9f3d3e9/namespace_9f3d3e9
// Params 1, eflags: 0x0
// Checksum 0x54046d96, Offset: 0xea0
// Size: 0x10c
function function_f8aa7ab9(entity) {
    if (function_7436ece2(entity.favoriteenemy)) {
        entity.var_972b23bb = 1;
        function_a756bd8e(entity);
        return;
    }
    target = archetype_avogadro::get_target_ent(entity);
    if (isdefined(target) && archetype_avogadro::function_d58f8483(entity)) {
        entity namespace_85745671::function_9758722("run");
        function_de781d41(entity);
        return;
    }
    entity namespace_85745671::function_9758722("sprint");
    function_a756bd8e(entity);
    awareness::function_39da6c3c(entity);
}

// Namespace namespace_9f3d3e9/namespace_9f3d3e9
// Params 1, eflags: 0x0
// Checksum 0x7499fa77, Offset: 0xfb8
// Size: 0x16
function function_a756bd8e(entity) {
    entity.var_e8a7f45d = undefined;
}

// Namespace namespace_9f3d3e9/namespace_9f3d3e9
// Params 1, eflags: 0x0
// Checksum 0x529dfaa, Offset: 0xfd8
// Size: 0xf4
function function_de781d41(entity) {
    if (!isdefined(entity.var_e8a7f45d)) {
        entity.var_e8a7f45d = {#state:#"hash_24e69bf779de4940", #var_a5afe5a1:gettime()};
    }
    if (!isdefined(entity.var_e8a7f45d.center_point)) {
        entity.var_e8a7f45d.center_point = entity.origin;
    }
    if (gettime() < entity.var_e8a7f45d.var_a5afe5a1) {
        return;
    }
    entity.var_e8a7f45d.var_a5afe5a1 = gettime() + 2000;
    var_1c6ab728 = function_598bf886(self);
    if (isdefined(var_1c6ab728)) {
        entity setgoal(var_1c6ab728);
    }
}

// Namespace namespace_9f3d3e9/namespace_9f3d3e9
// Params 1, eflags: 0x0
// Checksum 0xcf85c702, Offset: 0x10d8
// Size: 0x418
function function_598bf886(entity) {
    nextstate = #"hash_24e69bf779de4940";
    switch (entity.var_e8a7f45d.state) {
    case #"hash_24e69bf779de4940":
        random = randomint(100);
        if (random < 33) {
            nextstate = #"hash_a69905121714d7c";
        } else if (random < 66) {
            nextstate = #"hash_46c85a951b2258a9";
        }
        break;
    case #"hash_a69905121714d7c":
    case #"hash_46c85a951b2258a9":
        nextstate = #"hash_24e69bf779de4940";
        break;
    default:
        break;
    }
    target = archetype_avogadro::get_target_ent(entity);
    if (nextstate != entity.var_e8a7f45d.state) {
        dirtoenemy = vectornormalize(target.origin - entity.origin);
        angles = vectortoangles(dirtoenemy);
        angles = (0, angles[1], 0);
        if (nextstate == #"hash_a69905121714d7c") {
            dir = anglestoright(angles) * -1;
            movepos = entity.origin + dir * randomintrange(100, 300);
        } else if (nextstate == #"hash_46c85a951b2258a9") {
            dir = anglestoright(angles);
            movepos = entity.origin + dir * randomintrange(100, 300);
        } else {
            movepos = entity.var_e8a7f45d.center_point;
        }
        var_37c56a35 = getclosestpointonnavmesh(movepos, 128, entity getpathfindingradius() * 1.2);
        if (isdefined(var_37c56a35)) {
            var_9b482dc3 = checknavmeshdirection(entity.origin, var_37c56a35 - entity.origin, distance(entity.origin, var_37c56a35), entity getpathfindingradius());
            /#
                recordline(entity.origin, var_9b482dc3, (0, 1, 0), "<dev string:x38>", entity);
            #/
            /#
                recordline(entity.origin + (0, 0, 3), var_37c56a35 + (0, 0, 3), (1, 0.5, 0), "<dev string:x38>", entity);
            #/
            if (distancesquared(entity.origin, var_9b482dc3) >= 100 || is_false(entity.can_phase)) {
                entity.var_e8a7f45d.state = nextstate;
                return var_9b482dc3;
            }
        }
    }
}

// Namespace namespace_9f3d3e9/namespace_9f3d3e9
// Params 1, eflags: 0x0
// Checksum 0x5ff6a1e5, Offset: 0x14f8
// Size: 0xac
function function_cea6c5e9(entity) {
    function_a756bd8e(entity);
    entity.var_972b23bb = undefined;
    if (isdefined(entity.cluster) && entity.cluster.status === 0) {
        entity callback::callback(#"hash_10ab46b52df7967a");
        return;
    }
    entity.maxsightdistsqrd = function_a3f6cdac(1000);
    awareness::function_b9f81e8b(entity);
}

// Namespace namespace_9f3d3e9/namespace_9f3d3e9
// Params 1, eflags: 0x0
// Checksum 0x183e5bc0, Offset: 0x15b0
// Size: 0x3c
function function_93d792b9(entity) {
    if (function_7436ece2(entity.favoriteenemy)) {
        return;
    }
    awareness::function_5c40e824(entity);
}

// Namespace namespace_9f3d3e9/namespace_9f3d3e9
// Params 1, eflags: 0x0
// Checksum 0xba079e8c, Offset: 0x15f8
// Size: 0x134
function function_905d3c1a(entity) {
    entity endon(#"death");
    if (is_true(entity.var_83fa6083)) {
        return;
    }
    delta = getmovedelta("ai_t9_zm_avogadro_arrival", 0, 1);
    timeout = getanimlength("ai_t9_zm_avogadro_arrival");
    new_origin = (entity.origin[0], entity.origin[1], entity.origin[2] - delta[2]);
    entity animscripted("avogadro_arrival_finished", new_origin, (0, entity.angles[1], 0), "ai_t9_zm_avogadro_arrival", "normal", "root", 1, 0);
    entity waittilltimeout(timeout, #"avogadro_arrival_finished");
}

// Namespace namespace_9f3d3e9/namespace_9f3d3e9
// Params 1, eflags: 0x0
// Checksum 0xce683b55, Offset: 0x1738
// Size: 0x24
function avogadrodespawn(entity) {
    entity thread onallcracks(entity);
}

// Namespace namespace_9f3d3e9/namespace_9f3d3e9
// Params 1, eflags: 0x0
// Checksum 0xa4d0f30a, Offset: 0x1768
// Size: 0x198
function onallcracks(entity) {
    entity endon(#"death");
    entity.var_8a96267d = undefined;
    entity.is_digging = 1;
    entity pathmode("dont move", 1);
    timeout = getanimlength("ai_t9_zm_avogadro_exit");
    entity animscripted("avogadro_exit_finished", self.origin, self.angles, "ai_t9_zm_avogadro_exit", "normal", "root", 1, 0);
    waitresult = entity waittilltimeout(timeout, #"avogadro_exit_finished");
    entity ghost();
    entity notsolid();
    entity val::set(#"avogadro_despawn", "ignoreall", 1);
    entity clientfield::set("" + #"hash_2eec8fc21495a18c", 0);
    entity notify(#"is_underground");
}

// Namespace namespace_9f3d3e9/namespace_9f3d3e9
// Params 1, eflags: 0x0
// Checksum 0xa332b91, Offset: 0x1908
// Size: 0x8a
function function_7436ece2(entity) {
    if (!isplayer(entity) || !namespace_85745671::function_142c3c86(entity)) {
        return false;
    }
    vehicle = entity getvehicleoccupied();
    if (vehicle getspeed() < 100) {
        return false;
    }
    return true;
}

// Namespace namespace_9f3d3e9/namespace_9f3d3e9
// Params 1, eflags: 0x0
// Checksum 0xd7f3c916, Offset: 0x19a0
// Size: 0xfa
function function_f498585b(entity) {
    if (gettime() < entity.var_4cc2bf28) {
        return 0;
    }
    if (isdefined(entity.favoriteenemy) && is_true(entity.favoriteenemy.usingvehicle)) {
        vehicle = entity.favoriteenemy getvehicleoccupied();
        if (isdefined(vehicle.var_7cdc3732)) {
            function_1eaaceab(vehicle.var_7cdc3732, 0);
            if (vehicle.var_7cdc3732.size >= 3 && !isinarray(vehicle.var_7cdc3732, self)) {
                return 0;
            }
        }
    }
    return function_7436ece2(entity.favoriteenemy);
}

// Namespace namespace_9f3d3e9/namespace_9f3d3e9
// Params 1, eflags: 0x0
// Checksum 0x5d04a49d, Offset: 0x1aa8
// Size: 0x6e
function function_14b5c940(entity) {
    if (is_false(entity.can_shoot)) {
        return false;
    }
    if (!isdefined(entity.favoriteenemy)) {
        return false;
    }
    if (isdefined(level.var_a35afcb2) && ![[ level.var_a35afcb2 ]](entity)) {
        return false;
    }
    return true;
}

// Namespace namespace_9f3d3e9/namespace_9f3d3e9
// Params 1, eflags: 0x0
// Checksum 0xfe12aa45, Offset: 0x1b20
// Size: 0xfc
function function_175d123b(vehicle) {
    self endon(#"death");
    vehicle endon(#"death");
    if (!isdefined(vehicle.var_7cdc3732)) {
        vehicle.var_7cdc3732 = [];
    }
    vehicle.var_7cdc3732[vehicle.var_7cdc3732.size] = self;
    while (vehicle getspeed() >= 100 && isplayer(self.favoriteenemy) && isdefined(vehicle getoccupantseat(self.favoriteenemy))) {
        waitframe(1);
    }
    if (isdefined(vehicle) && isdefined(self)) {
        arrayremovevalue(vehicle.var_7cdc3732, self);
    }
}

// Namespace namespace_9f3d3e9/namespace_9f3d3e9
// Params 1, eflags: 0x0
// Checksum 0xb04d4c40, Offset: 0x1c28
// Size: 0x776
function function_5871bcf8(entity) {
    if (isdefined(entity.var_78dd7804)) {
        return;
    }
    vehicle = entity.favoriteenemy getvehicleoccupied();
    speed = vehicle getspeed();
    if (!isdefined(vehicle.var_7cdc3732) || !isinarray(vehicle.var_7cdc3732, entity)) {
        entity thread function_175d123b(vehicle);
    }
    angles = entity.favoriteenemy getplayerangles();
    angles = (0, angles[1], 0);
    direction = anglestoforward(angles);
    right = anglestoright(angles);
    angularvelocity = vehicle getangularvelocity();
    var_b03d2fe7 = abs(angularvelocity[2]);
    var_c27adf49 = mapfloat(0, 2.6, 300, 800, var_b03d2fe7);
    rightoffset = right * var_c27adf49 * (angularvelocity[2] > 0 ? -1 : 1);
    var_ff89cc4c = max(speed * 2, 1500);
    forwardoffset = direction * var_ff89cc4c;
    var_2ca243fc = rightoffset + forwardoffset;
    var_9d75e0da = length(var_2ca243fc);
    var_37cf85c7 = getclosestpointonnavmesh(vehicle.origin, 128, entity getpathfindingradius() * 1.2);
    if (!isdefined(var_37cf85c7)) {
        return;
    }
    entity.var_78dd7804 = archetype_avogadro::function_205c9932(entity);
    if (!isdefined(entity.var_78dd7804)) {
        return;
    }
    nextpos = checknavmeshdirection(var_37cf85c7, var_2ca243fc, var_9d75e0da, entity getpathfindingradius() * 1.2);
    if (distancesquared(vehicle.origin, nextpos) < function_a3f6cdac(1500)) {
        archetype_avogadro::function_c6e09354(entity.var_78dd7804);
        entity.var_78dd7804 = undefined;
        return;
    }
    points = array(nextpos + (150, 0, 0), nextpos + (300, 0, 0), nextpos - (150, 0, 0), nextpos - (300, 0, 0), nextpos + (0, 150, 0), nextpos + (0, 300, 0), nextpos - (0, 150, 0), nextpos - (0, 300, 0));
    bestpoint = undefined;
    var_fa442d4c = entity function_6a9ae71();
    points = array::randomize(points);
    foreach (point in points) {
        nextpos = groundtrace(point + (0, 0, 500) + (0, 0, 8), point + (0, 0, 500) + (0, 0, -100000), 0, entity)[#"position"];
        if (nextpos[2] < point[2] - 2000) {
            /#
                recordsphere(point, 10, (1, 0, 0), "<dev string:x38>", entity);
            #/
            continue;
        }
        if (bullettracepassed(nextpos + (0, 0, var_fa442d4c), vehicle.origin + (0, 0, var_fa442d4c), 0, vehicle)) {
            bestpoint = nextpos;
            break;
        }
        /#
            recordsphere(nextpos, 10, (1, 0, 0), "<dev string:x38>", entity);
        #/
    }
    if (!isdefined(bestpoint)) {
        archetype_avogadro::function_c6e09354(entity.var_78dd7804);
        entity.var_78dd7804 = undefined;
        return;
    }
    var_baa2a8c4 = vehicle.origin - bestpoint;
    /#
        recordsphere(bestpoint, 15, (0, 0, 1), "<dev string:x38>");
        recordline(entity.origin, bestpoint, (0, 0, 1), "<dev string:x38>");
    #/
    var_dd695160 = entity gettagorigin("j_spine4") - entity.origin;
    entity.var_78dd7804.array[0].origin = entity.origin + var_dd695160;
    entity.var_78dd7804.array[1].origin = bestpoint + var_dd695160;
    entity thread archetype_avogadro::function_d979c854(entity);
    entity forceteleport(bestpoint, vectortoangles(var_baa2a8c4));
    entity.var_4cc2bf28 = gettime() + int(3.5 * 1000);
}

// Namespace namespace_9f3d3e9/namespace_9f3d3e9
// Params 1, eflags: 0x0
// Checksum 0x3e21868f, Offset: 0x23a8
// Size: 0x334
function function_ce2bd83c(params) {
    if (is_true(self.is_phasing)) {
        return;
    }
    if (isdefined(params.einflictor) && isdefined(params.weapon) && params.smeansofdeath !== "MOD_DOT") {
        dot_params = function_f74d2943(params.weapon, 7);
        if (isdefined(dot_params)) {
            status_effect::status_effect_apply(dot_params, params.weapon, params.einflictor);
        }
    }
    if (isdefined(params.einflictor) && !isdefined(self.attackable) && isdefined(params.einflictor.var_b79a8ac7) && isarray(params.einflictor.var_b79a8ac7.slots) && isarray(level.var_7fc48a1a) && isinarray(level.var_7fc48a1a, params.weapon)) {
        if (params.einflictor namespace_85745671::get_attackable_slot(self)) {
            self.attackable = params.einflictor;
        }
    }
    if (params.smeansofdeath === "MOD_MELEE") {
        if (isplayer(params.einflictor)) {
            if (self.shield) {
                params.einflictor status_effect::status_effect_apply(level.var_2ea60515, undefined, self, 0);
            }
        }
        if (!self.shield) {
            self.shield = 1;
            self.hit_by_melee++;
        }
    } else if (self.hit_by_melee > 0) {
        self.hit_by_melee--;
    }
    if (params.idamage > 0) {
        var_ebcff177 = 1;
        weakpoint = namespace_81245006::function_3131f5dd(self, params.shitloc, 1);
        if (weakpoint.var_3765e777 === 1) {
            var_ebcff177 = 2;
        }
        callback::callback(#"hash_3886c79a26cace38", {#eattacker:params.eattacker, #var_dcc8dd60:self getentitynumber(), #idamage:params.idamage, #type:var_ebcff177});
    }
}

// Namespace namespace_9f3d3e9/namespace_9f3d3e9
// Params 12, eflags: 0x0
// Checksum 0xafc37dd5, Offset: 0x26e8
// Size: 0x9a
function function_1fef432(*inflictor, *attacker, damage, *idflags, *smeansofdeath, *weapon, *point, *dir, *shitloc, *offsettime, *boneindex, *modelindex) {
    /#
        if (is_true(level.var_85a39c96)) {
            return (self.health + 1);
        }
    #/
    return modelindex;
}

// Namespace namespace_9f3d3e9/namespace_9f3d3e9
// Params 1, eflags: 0x0
// Checksum 0x90755207, Offset: 0x2790
// Size: 0x118
function function_8886bcc4(params) {
    self playsound(#"hash_64bb457a8c6f828c");
    self clientfield::set("sndAwarenessChange", 0);
    if (params.smeansofdeath == "MOD_CRUSH") {
        self function_f59c1777({#origin:self.origin, #radius:250, #jammer:self});
        if (isdefined(params.einflictor)) {
            params.einflictor dodamage(100, self.origin, self, self, "none", "MOD_UNKNOWN");
        }
    }
    if (!isplayer(params.eattacker)) {
        return;
    }
}

// Namespace namespace_9f3d3e9/namespace_9f3d3e9
// Params 1, eflags: 0x0
// Checksum 0x825f2a74, Offset: 0x28b0
// Size: 0x3c
function function_e44ef704(*params) {
    self.var_ef59b90 = 5;
    self callback::callback(#"hash_10ab46b52df7967a");
}

// Namespace namespace_9f3d3e9/namespace_9f3d3e9
// Params 1, eflags: 0x0
// Checksum 0xa318554c, Offset: 0x28f8
// Size: 0x6a
function function_ac94df05(entity) {
    return isdefined(entity.current_state) && entity.current_state.name === #"chase" && (entity.var_9bff71aa < 2 || gettime() - entity.var_7fde19e8 > 1000);
}

// Namespace namespace_9f3d3e9/namespace_9f3d3e9
// Params 1, eflags: 0x0
// Checksum 0x6cf18513, Offset: 0x2970
// Size: 0x3e
function function_7d5cf0e4(entity) {
    return isdefined(entity.current_state) && entity.current_state.name == #"chase";
}

// Namespace namespace_9f3d3e9/namespace_9f3d3e9
// Params 1, eflags: 0x0
// Checksum 0xb3f315c8, Offset: 0x29b8
// Size: 0x120
function function_f59c1777(params) {
    entities = getentitiesinradius(params.origin, params.radius);
    foreach (entity in entities) {
        if (!function_b16c8865(entity, self)) {
            continue;
        }
        if (isplayer(entity)) {
            entity status_effect::status_effect_apply(level.var_2ea60515, undefined, self, 0);
            continue;
        }
        self thread function_e27c41b4(entity, params.jammer);
    }
}

// Namespace namespace_9f3d3e9/namespace_9f3d3e9
// Params 2, eflags: 0x4
// Checksum 0x249c6c06, Offset: 0x2ae0
// Size: 0x118
function private function_b16c8865(entity, owner) {
    if (self == entity) {
        return false;
    }
    if (!isplayer(entity) && (!isdefined(entity.model) || entity.model == #"")) {
        return false;
    }
    if (isactor(entity) && !is_true(entity.var_8f61d7f4)) {
        return false;
    }
    if (isdefined(entity.team) && !util::function_fbce7263(entity.team, owner.team)) {
        return false;
    }
    if (isdefined(entity.ignoreemp) ? entity.ignoreemp : 0) {
        return false;
    }
    return true;
}

// Namespace namespace_9f3d3e9/namespace_9f3d3e9
// Params 2, eflags: 0x4
// Checksum 0x98691d86, Offset: 0x2c00
// Size: 0x10e
function private function_e27c41b4(entity, jammer = undefined) {
    entity endon(#"death");
    if (!isdefined(entity)) {
        return;
    }
    if (isalive(entity) && isvehicle(entity) && isdefined(level.is_staircase_up)) {
        function_1c430dad(entity, 1);
        entity thread [[ level.is_staircase_up ]](self, jammer);
        return;
    }
    if (isalive(entity) && isactor(entity)) {
        function_1c430dad(entity, 1);
        return;
    }
}

// Namespace namespace_9f3d3e9/namespace_9f3d3e9
// Params 1, eflags: 0x4
// Checksum 0x6700a240, Offset: 0x2d18
// Size: 0xc4
function private function_b8c5ab9c(player) {
    player notify(#"hash_4f2e183cc0ec68bd");
    player endon(#"death", #"hash_4f2e183cc0ec68bd");
    player clientfield::set_to_player("isJammed", 1);
    player.isjammed = 1;
    player.var_fe1ebada = self;
    player setempjammed(1);
    wait 5;
    if (!isdefined(player)) {
        return;
    }
    function_d88f3e48(player);
}

// Namespace namespace_9f3d3e9/namespace_9f3d3e9
// Params 2, eflags: 0x0
// Checksum 0xa6857dac, Offset: 0x2de8
// Size: 0x86
function function_1c430dad(entity, isjammed) {
    if (!isplayer(entity) && !isactor(entity)) {
        entity clientfield::set("isJammed", isjammed);
    }
    entity.isjammed = isjammed;
    entity.emped = isjammed;
}

// Namespace namespace_9f3d3e9/namespace_9f3d3e9
// Params 1, eflags: 0x4
// Checksum 0xe4a5d7cf, Offset: 0x2e78
// Size: 0x7c
function private function_d88f3e48(entity) {
    if (!isdefined(entity)) {
        return;
    }
    if (isplayer(entity)) {
        entity clientfield::set_to_player("isJammed", 0);
        entity setempjammed(0);
    }
    function_1c430dad(entity, 0);
}

/#

    // Namespace namespace_9f3d3e9/namespace_9f3d3e9
    // Params 0, eflags: 0x0
    // Checksum 0xcc6ac33b, Offset: 0x2f00
    // Size: 0x8
    function function_c698f66b() {
        
    }

#/
