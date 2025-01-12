#using script_3357acf79ce92f4b;
#using script_3411bb48d41bd3b;
#using script_7f35d42a9593323b;
#using scripts\core_common\aat_shared;
#using scripts\core_common\ai\zombie_utility;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\values_shared;
#using scripts\weapons\mechz_firebomb;

#namespace namespace_394b7174;

// Namespace namespace_394b7174/namespace_394b7174
// Params 0, eflags: 0x6
// Checksum 0x283415ff, Offset: 0x1b0
// Size: 0x44
function private autoexec __init__system__() {
    system::register(#"hash_76fcf333cf2abd11", &__init__, undefined, &function_4df027f2, undefined);
}

// Namespace namespace_394b7174/namespace_394b7174
// Params 0, eflags: 0x0
// Checksum 0x863dd2c3, Offset: 0x200
// Size: 0x64
function __init__() {
    spawner::add_archetype_spawn_function(#"mechz", &function_b8e86206);
    spawner::function_89a2cd87(#"mechz", &function_3f369eaa);
}

// Namespace namespace_394b7174/namespace_394b7174
// Params 0, eflags: 0x4
// Checksum 0xa6fe111d, Offset: 0x270
// Size: 0xe4
function private function_4df027f2() {
    level thread aat::register_immunity("zm_aat_brain_decay", #"mechz", 1, 1, 1);
    level thread aat::register_immunity("zm_aat_frostbite", #"mechz", 1, 1, 1);
    level thread aat::register_immunity("zm_aat_kill_o_watt", #"mechz", 1, 1, 1);
    level thread aat::register_immunity("zm_aat_plasmatic_burst", #"mechz", 1, 1, 1);
}

// Namespace namespace_394b7174/namespace_394b7174
// Params 0, eflags: 0x0
// Checksum 0x7e0e7deb, Offset: 0x360
// Size: 0x11c
function function_b8e86206() {
    self callback::function_d8abfc3d(#"on_ai_melee", &namespace_85745671::function_b8eb5dea);
    self callback::function_d8abfc3d(#"hash_10ab46b52df7967a", &function_3076443);
    self.var_12af7864 = 1;
    self.blockingpain = 1;
    self.var_d8695234 = 1;
    self.var_90d0c0ff = "anim_mechz_spawn";
    self.var_ecbef856 = "anim_mechz_despawn";
    self.var_b3c613a7 = [1, 1.5, 1.5, 2, 2];
    self.var_414bc881 = 0.5;
    self thread function_becb8ae2();
}

// Namespace namespace_394b7174/namespace_394b7174
// Params 0, eflags: 0x0
// Checksum 0xa6da98fa, Offset: 0x488
// Size: 0x124
function function_3f369eaa() {
    self function_8d5f13fa();
    if (is_true(self.var_1a5b6b7e)) {
        self endon(#"death");
        awareness::pause(self);
        self animscripted("rise_anim", self.origin, (0, self.angles[1], 0), #"hash_768cb7840d5e6d2b", "normal", undefined, 1, 0.2);
        self waittillmatch({#notetrack:"end"}, #"rise_anim");
        awareness::resume(self);
        return;
    }
    self playsound(#"hash_41754745c29e01f4");
}

// Namespace namespace_394b7174/namespace_394b7174
// Params 1, eflags: 0x0
// Checksum 0x6a8afd89, Offset: 0x5b8
// Size: 0x11c
function function_3076443(*params) {
    self endon(#"death");
    if (isdefined(self.attackable)) {
        namespace_85745671::function_2b925fa5(self);
    }
    self animscripted("despawn_anim", self.origin, self.angles, #"hash_d4f220b98771ce4", "normal", undefined, 1, 0.2);
    self waittillmatch({#notetrack:"end"}, #"despawn_anim");
    self ghost();
    self notsolid();
    waittillframeend();
    self kill(undefined, undefined, undefined, undefined, 0, 1);
}

// Namespace namespace_394b7174/namespace_394b7174
// Params 0, eflags: 0x0
// Checksum 0xc1b9d483, Offset: 0x6e0
// Size: 0x314
function function_8d5f13fa() {
    self.fovcosine = 0.5;
    self.maxsightdistsqrd = function_a3f6cdac(900);
    self.has_awareness = 1;
    self.ignorelaststandplayers = 1;
    self.var_1267fdea = 1;
    self callback::function_d8abfc3d(#"on_ai_damage", &awareness::function_5f511313);
    awareness::register_state(self, #"wander", &function_65f28890, &awareness::function_4ebe4a6d, &awareness::function_b264a0bc, undefined, &awareness::function_555d960b);
    awareness::register_state(self, #"investigate", &awareness::function_b41f0471, &awareness::function_9eefc327, &awareness::function_34162a25, undefined, &awareness::function_a360dd00);
    awareness::register_state(self, #"chase", &function_43c21e81, &function_3715dbff, &function_dca46c2e, &awareness::function_5c40e824, undefined);
    awareness::register_state(self, #"hash_6cac9101afa678f2", &function_3a6dfa8b, &function_6e7d7d1, &function_7ea826b6, &awareness::function_5c40e824, undefined);
    awareness::register_state(self, #"scripted", &function_235c2ec8, undefined, &function_39e16337);
    awareness::set_state(self, #"wander");
    self callback::function_d8abfc3d(#"hash_1c5ac76933317a1d", &awareness::pause, undefined, array(self));
    self callback::function_d8abfc3d(#"hash_6ce1d15fa3e62552", &function_a84a928b);
    self callback::on_ai_damage(&function_d3f3bff7);
    self thread awareness::function_fa6e010d();
}

// Namespace namespace_394b7174/namespace_394b7174
// Params 1, eflags: 0x0
// Checksum 0xb38f6fb4, Offset: 0xa00
// Size: 0x84
function function_65f28890(entity) {
    entity setblackboardattribute("_locomotion_speed", "locomotion_speed_walk");
    entity.fovcosine = 0.5;
    entity.maxsightdistsqrd = function_a3f6cdac(1000);
    entity.var_1267fdea = 0;
    awareness::function_9c9d96b5(entity);
}

// Namespace namespace_394b7174/namespace_394b7174
// Params 1, eflags: 0x0
// Checksum 0x6e1638a9, Offset: 0xa90
// Size: 0x5c
function function_64072d21(entity) {
    entity.fovcosine = 0;
    entity.maxsightdistsqrd = function_a3f6cdac(1800);
    entity.var_1267fdea = 0;
    awareness::function_b41f0471(entity);
}

// Namespace namespace_394b7174/namespace_394b7174
// Params 1, eflags: 0x4
// Checksum 0x3a19ada9, Offset: 0xaf8
// Size: 0x2c
function private function_32309e80(entity) {
    return isdefined(entity.var_a8e56aa3) && entity.var_a8e56aa3 > gettime();
}

// Namespace namespace_394b7174/namespace_394b7174
// Params 1, eflags: 0x4
// Checksum 0x38ea14fb, Offset: 0xb30
// Size: 0x2c
function private function_cdbe8d0a(entity) {
    return isdefined(entity.var_e05f2c0a) && entity.var_e05f2c0a > gettime();
}

// Namespace namespace_394b7174/namespace_394b7174
// Params 1, eflags: 0x0
// Checksum 0xaec3d4c2, Offset: 0xb68
// Size: 0xac
function function_43c21e81(entity) {
    entity.fovcosine = 0;
    entity.maxsightdistsqrd = function_a3f6cdac(3000);
    entity.var_1267fdea = 0;
    entity setblackboardattribute("_locomotion_speed", "locomotion_speed_run");
    entity.maxsightdistsqrd = function_a3f6cdac(3000);
    entity.var_972b23bb = 1;
    awareness::function_978025e4(entity);
}

// Namespace namespace_394b7174/namespace_394b7174
// Params 1, eflags: 0x0
// Checksum 0x2c817920, Offset: 0xc20
// Size: 0x1ec
function function_3715dbff(entity) {
    target = isdefined(entity.favoriteenemy) ? entity.favoriteenemy : entity.attackable;
    if (isdefined(target)) {
        if (namespace_3444cb7b::mechzisinsafezone(entity) && entity cansee(target)) {
            /#
                distsqr = distancesquared(entity.origin, entity.favoriteenemy.origin);
                record3dtext("<dev string:x38>" + 225 + "<dev string:x55>" + 600 + "<dev string:x5a>" + sqrt(distsqr), entity.origin, (0, 1, 0));
                recordline(entity.origin, target.origin, (0, 1, 0));
            #/
            if (function_32309e80(entity)) {
                if (function_cdbe8d0a(entity)) {
                    awareness::set_state(entity, #"hash_6cac9101afa678f2");
                    return;
                }
                var_274bac27 = 90000;
                if (distancesquared(entity.origin, target.origin) > var_274bac27) {
                    awareness::function_39da6c3c(entity);
                }
            }
            return;
        }
    }
    awareness::function_39da6c3c(entity);
}

// Namespace namespace_394b7174/namespace_394b7174
// Params 1, eflags: 0x0
// Checksum 0x35c2dbd, Offset: 0xe18
// Size: 0x9c
function function_dca46c2e(entity) {
    entity.maxsightdistsqrd = function_a3f6cdac(900);
    entity.var_972b23bb = undefined;
    if (isdefined(entity.cluster) && entity.cluster.status === 0) {
        entity callback::callback(#"hash_10ab46b52df7967a");
        return;
    }
    awareness::function_b9f81e8b(entity);
}

// Namespace namespace_394b7174/namespace_394b7174
// Params 1, eflags: 0x0
// Checksum 0x777c9a37, Offset: 0xec0
// Size: 0x5dc
function function_3a6dfa8b(entity) {
    function_43c21e81(entity);
    entity setblackboardattribute("_locomotion_speed", "locomotion_speed_run");
    enemy = entity.favoriteenemy;
    assert(isdefined(enemy));
    var_1f1d655 = vectortoangles(entity.origin - entity.favoriteenemy.origin)[1];
    var_8daf3ac3 = 300;
    var_5c85bc30 = [];
    var_6f9adfe4 = [30, -30];
    foreach (angle in var_6f9adfe4) {
        var_43ed722a = absangleclamp360(var_1f1d655 + angle);
        var_dfa014f8 = anglestoforward((0, var_43ed722a, 0));
        target_pos = enemy.origin + var_dfa014f8 * var_8daf3ac3;
        var_c38ec8b1 = getclosestpointonnavmesh(target_pos, 64, entity getpathfindingradius());
        if (isdefined(var_c38ec8b1)) {
            var_5c85bc30[var_5c85bc30.size] = var_c38ec8b1;
        }
    }
    var_e3a26bf0 = undefined;
    var_9da770d9 = 0;
    var_e1aa7e8 = undefined;
    var_6481e3f2 = entity getangles()[1];
    forward_vec = anglestoforward((0, var_6481e3f2, 0));
    foreach (pos in var_5c85bc30) {
        var_2872f5ac = pos - entity.origin;
        dot = vectordot(var_2872f5ac, forward_vec);
        if (dot > 0) {
            var_e3a26bf0 = pos;
        }
        if (!isdefined(var_e1aa7e8)) {
            var_e1aa7e8 = dot;
        }
        if (math::sign(dot) != math::sign(var_e1aa7e8)) {
            var_9da770d9 = 1;
        }
        var_e1aa7e8 = dot;
        /#
            recordsphere(pos, 10, (1, 0, 0), "<dev string:x66>");
            record3dtext("<dev string:x70>" + dot, pos + (0, 0, -10), (1, 0, 0));
        #/
    }
    if (var_9da770d9) {
    } else if (isplayer(enemy)) {
        player_yaw = enemy getplayerangles()[1];
        var_ae507841 = anglestoforward((0, player_yaw, 0));
        var_ba9c64fa = enemy.origin + var_ae507841 * var_8daf3ac3;
        /#
            recordsphere(var_ba9c64fa, 10, (0, 1, 0), "<dev string:x66>");
        #/
        var_3393a039 = 2147483647;
        foreach (pos in var_5c85bc30) {
            var_629011b4 = distancesquared(var_ba9c64fa, pos);
            if (var_629011b4 < var_3393a039) {
                var_3393a039 = var_629011b4;
                var_e3a26bf0 = pos;
            }
        }
    } else if (var_5c85bc30.size > 0) {
        var_e3a26bf0 = var_5c85bc30[randomint(var_5c85bc30.size)];
    }
    if (isdefined(var_e3a26bf0)) {
        entity setgoal(var_e3a26bf0);
        /#
            recordsphere(var_e3a26bf0, 10, (0, 0, 1), "<dev string:x66>");
        #/
    }
}

// Namespace namespace_394b7174/namespace_394b7174
// Params 1, eflags: 0x0
// Checksum 0xb0519215, Offset: 0x14a8
// Size: 0x114
function function_6e7d7d1(entity) {
    /#
        record3dtext("<dev string:x79>", entity.origin + (0, 20, 0), (0, 0, 1));
    #/
    if (isdefined(entity.favoriteenemy)) {
        goalinfo = entity function_4794d6a3();
        var_127a38a7 = distancesquared(goalinfo.goalpos, entity.origin);
        if (!namespace_3444cb7b::mechzisinsafezone(entity) || goalinfo.isatgoal || var_127a38a7 < function_a3f6cdac(64)) {
            awareness::set_state(entity, #"chase");
        }
    }
}

// Namespace namespace_394b7174/namespace_394b7174
// Params 1, eflags: 0x0
// Checksum 0xd974b7a5, Offset: 0x15c8
// Size: 0x24
function function_7ea826b6(entity) {
    function_dca46c2e(entity);
}

// Namespace namespace_394b7174/namespace_394b7174
// Params 1, eflags: 0x0
// Checksum 0x376443b3, Offset: 0x15f8
// Size: 0x4c
function function_235c2ec8(entity) {
    entity.favoriteenemy = undefined;
    entity clearpath();
    entity setgoal(entity.origin, 1);
}

// Namespace namespace_394b7174/namespace_394b7174
// Params 1, eflags: 0x0
// Checksum 0x4c88f060, Offset: 0x1650
// Size: 0x4c
function function_39e16337(entity) {
    entity.favoriteenemy = undefined;
    entity clearpath();
    entity setgoal(entity.origin, 1);
}

// Namespace namespace_394b7174/namespace_394b7174
// Params 1, eflags: 0x0
// Checksum 0x60756611, Offset: 0x16a8
// Size: 0x252
function function_d3f3bff7(params) {
    if (isdefined(params.einflictor) && !isdefined(self.attackable) && isdefined(params.einflictor.var_b79a8ac7) && isarray(params.einflictor.var_b79a8ac7.slots) && isarray(level.var_7fc48a1a) && isinarray(level.var_7fc48a1a, params.weapon)) {
        if (params.einflictor namespace_85745671::get_attackable_slot(self)) {
            self.attackable = params.einflictor;
        }
    }
    if (!isdefined(self.favoriteenemy) && isdefined(params.einflictor) && !isdefined(self.var_4b559171)) {
        awareness::function_c241ef9a(self, params.einflictor, 8);
        pointonnavmesh = getclosestpointonnavmesh(params.einflictor.origin, 256, self getpathfindingradius() * 1.2);
        var_f2f7ce25 = getclosestpointonnavmesh(self.origin, 256, self getpathfindingradius() * 1.2);
        if (!isdefined(pointonnavmesh) || !isdefined(var_f2f7ce25)) {
            return;
        }
        to_origin = self.origin - pointonnavmesh;
        goalpos = checknavmeshdirection(pointonnavmesh, to_origin, 96, self getpathfindingradius() * 1.2);
        self.var_4b559171 = goalpos;
    }
}

// Namespace namespace_394b7174/namespace_394b7174
// Params 1, eflags: 0x0
// Checksum 0xb004e1e7, Offset: 0x1908
// Size: 0x100
function function_a84a928b(*params) {
    awareness::resume(self);
    var_8e1582ca = getentitiesinradius(self.origin, self getpathfindingradius() * 3, 15);
    foreach (zombie in var_8e1582ca) {
        if (zombie.archetype == #"zombie") {
            zombie zombie_utility::setup_zombie_knockdown(self);
        }
    }
}

// Namespace namespace_394b7174/namespace_394b7174
// Params 0, eflags: 0x0
// Checksum 0xd2259170, Offset: 0x1a10
// Size: 0x70
function function_becb8ae2() {
    self endon(#"death");
    while (isalive(self)) {
        self playsound(#"hash_152163acb125a7b2");
        wait randomfloatrange(1.5, 4);
    }
}

