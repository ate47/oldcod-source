#using scripts\core_common\ai\archetype_damage_utility;
#using scripts\core_common\ai\archetype_locomotion_utility;
#using scripts\core_common\ai\systems\ai_interface;
#using scripts\core_common\ai\systems\animation_state_machine_mocomp;
#using scripts\core_common\ai\systems\animation_state_machine_notetracks;
#using scripts\core_common\ai\systems\animation_state_machine_utility;
#using scripts\core_common\ai\systems\behavior_state_machine;
#using scripts\core_common\ai\systems\behavior_tree_utility;
#using scripts\core_common\ai\systems\blackboard;
#using scripts\core_common\array_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\targetting_delay;
#using scripts\killstreaks\ai\escort;
#using scripts\killstreaks\ai\leave;
#using scripts\killstreaks\ai\patrol;
#using scripts\killstreaks\ai\state;
#using scripts\killstreaks\ai\target;
#using scripts\killstreaks\ai\tracking;
#using scripts\killstreaks\killstreak_bundles;
#using scripts\killstreaks\killstreaks_shared;

#namespace archetypempdog;

// Namespace archetypempdog
// Method(s) 2 Total 2
class lookaround {

    var var_1c9b697;

    // Namespace lookaround/dog
    // Params 0, eflags: 0x8
    // Checksum 0x28daa934, Offset: 0x370
    // Size: 0x2e
    constructor() {
        var_1c9b697 = gettime() + randomintrange(4500, 6500);
    }

}

// Namespace archetypempdog
// Method(s) 2 Total 2
class class_b874e3b5 {

}

// Namespace archetypempdog
// Method(s) 2 Total 2
class class_b8ce49e3 {

    var adjustmentstarted;
    var var_98b8af1;

    // Namespace class_b8ce49e3/dog
    // Params 0, eflags: 0x8
    // Checksum 0x5ee2eaf3, Offset: 0x2e40
    // Size: 0x1a
    constructor() {
        adjustmentstarted = 0;
        var_98b8af1 = 1;
    }

}

// Namespace archetypempdog/dog
// Params 0, eflags: 0x0
// Checksum 0x285d7ccb, Offset: 0x258
// Size: 0x10c
function init() {
    spawner::add_archetype_spawn_function("mp_dog", &function_8b181168);
    registerbehaviorscriptfunctions();
    if (!isdefined(level.var_32742545)) {
        level.var_32742545 = spawnstruct();
        level.var_32742545.functions = [];
        clientfield::register("actor", "ks_dog_bark", 1, 1, "counter");
        clientfield::register("actor", "ks_shocked", 1, 1, "int");
    }
    ai_patrol::init();
    ai_escort::init();
    ai_leave::init();
}

// Namespace archetypempdog/dog
// Params 0, eflags: 0x4
// Checksum 0xe53a66ce, Offset: 0x4f8
// Size: 0x1c4
function private function_8b181168() {
    function_933704bd();
    self setplayercollision(0);
    self allowpitchangle(1);
    self setpitchorient();
    self setavoidancemask("avoid none");
    self collidewithactors(0);
    self function_c6eb7b16(30);
    self.ai.var_6a562b85 = 1;
    self.ignorepathenemyfightdist = 1;
    self.jukemaxdistance = 1500;
    self.highlyawareradius = 350;
    self.fovcosine = 0;
    self.fovcosinebusy = 0;
    self.maxsightdistsqrd = 900 * 900;
    self.sightlatency = 150;
    self.var_a29d9d0c = 1;
    self.ai.reacquire_state = 0;
    self.ai.var_8e5bbae5 = 1;
    self.ai.lookaround = new lookaround();
    self.ai.var_b874e3b5 = new class_b874e3b5();
    self thread targetting_delay::function_3362444f(4000);
    aiutility::addaioverridedamagecallback(self, &function_37fb40b);
}

// Namespace archetypempdog/dog
// Params 0, eflags: 0x0
// Checksum 0x6d43b3c3, Offset: 0x6c8
// Size: 0x8ac
function registerbehaviorscriptfunctions() {
    assert(isscriptfunctionptr(&dogtargetservice));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"mpdogtargetservice", &dogtargetservice);
    assert(isscriptfunctionptr(&dogshouldwalk));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"mpdogshouldwalk", &dogshouldwalk);
    assert(isscriptfunctionptr(&dogshouldwalk));
    behaviorstatemachine::registerbsmscriptapiinternal(#"mpdogshouldwalk", &dogshouldwalk);
    assert(isscriptfunctionptr(&dogshouldrun));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"mpdogshouldrun", &dogshouldrun);
    assert(isscriptfunctionptr(&dogshouldrun));
    behaviorstatemachine::registerbsmscriptapiinternal(#"mpdogshouldrun", &dogshouldrun);
    assert(isscriptfunctionptr(&function_6ea454fd));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_4178f7c4c6cfaeb6", &function_6ea454fd);
    assert(isscriptfunctionptr(&function_3a15eb4f));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_7aaa666497426ef4", &function_3a15eb4f);
    assert(isscriptfunctionptr(&function_3a15eb4f));
    behaviorstatemachine::registerbsmscriptapiinternal(#"hash_7aaa666497426ef4", &function_3a15eb4f);
    assert(isscriptfunctionptr(&dogjukeinitialize));
    behaviorstatemachine::registerbsmscriptapiinternal(#"mpdogjukeinitialize", &dogjukeinitialize);
    assert(isscriptfunctionptr(&dogpreemptivejuketerminate));
    behaviorstatemachine::registerbsmscriptapiinternal(#"mpdogpreemptivejuketerminate", &dogpreemptivejuketerminate);
    assert(isscriptfunctionptr(&function_5cee9f84));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_366c0b2c4164cc87", &function_5cee9f84);
    assert(isscriptfunctionptr(&function_5cee9f84));
    behaviorstatemachine::registerbsmscriptapiinternal(#"hash_366c0b2c4164cc87", &function_5cee9f84);
    assert(isscriptfunctionptr(&function_5d87d173));
    behaviorstatemachine::registerbsmscriptapiinternal(#"hash_65dc8904419628da", &function_5d87d173);
    assert(isscriptfunctionptr(&function_7bfdc3f));
    behaviorstatemachine::registerbsmscriptapiinternal(#"hash_4066108355410b7a", &function_7bfdc3f);
    assert(isscriptfunctionptr(&function_5a0e0fcc));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_28582743cd920a21", &function_5a0e0fcc);
    assert(isscriptfunctionptr(&function_892e7aa7));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_3349a77142623d80", &function_892e7aa7);
    assert(isscriptfunctionptr(&function_87cc175f));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_bb74fb159118080", &function_87cc175f);
    assert(isscriptfunctionptr(&function_2a53dda3));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_34183bbd11db144", &function_2a53dda3);
    assert(isscriptfunctionptr(&function_7b9cba10));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_3d584bfcad6c773d", &function_7b9cba10);
    animationstatenetwork::registernotetrackhandlerfunction("dog_melee", &function_23f8877c);
    animationstatenetwork::registeranimationmocomp("mocomp_mp_dog_juke", &function_e410efd9, &function_68f1aa90, &function_53037c62);
    animationstatenetwork::registeranimationmocomp("mocomp_mp_dog_charge_melee", &function_be2e2d3c, &function_35d6884b, &function_e3b2357);
    animationstatenetwork::registeranimationmocomp("mocomp_mp_dog_bark", &function_e903ca6, undefined, &function_40440d45);
}

// Namespace archetypempdog/dog
// Params 12, eflags: 0x0
// Checksum 0x56080cca, Offset: 0xf80
// Size: 0xea
function function_37fb40b(inflictor, attacker, damage, idflags, meansofdeath, weapon, point, dir, hitloc, offsettime, boneindex, modelindex) {
    chargelevel = 0;
    weapon_damage = killstreak_bundles::get_weapon_damage("dog", self.maxhealth, attacker, weapon, meansofdeath, damage, idflags, chargelevel);
    if (!isdefined(weapon_damage)) {
        weapon_damage = killstreaks::get_old_damage(attacker, weapon, meansofdeath, damage, 1);
    }
    return weapon_damage;
}

// Namespace archetypempdog/dog
// Params 1, eflags: 0x4
// Checksum 0x9842eab8, Offset: 0x1078
// Size: 0x42
function private function_87cc175f(entity) {
    var_64879891 = entity.var_a38dd6f;
    return var_64879891 === "concussion" || var_64879891 === "electrical";
}

// Namespace archetypempdog/dog
// Params 1, eflags: 0x4
// Checksum 0x5ea4e06c, Offset: 0x10c8
// Size: 0x44
function private function_2a53dda3(entity) {
    if (entity.var_a38dd6f === "electrical") {
        clientfield::set("ks_shocked", 1);
    }
}

// Namespace archetypempdog/dog
// Params 1, eflags: 0x4
// Checksum 0xaf057623, Offset: 0x1118
// Size: 0x24
function private function_7b9cba10(entity) {
    clientfield::set("ks_shocked", 0);
}

// Namespace archetypempdog/dog
// Params 1, eflags: 0x0
// Checksum 0x9e2ad278, Offset: 0x1148
// Size: 0x2c
function function_5a0e0fcc(entity) {
    return entity function_2f834e7() == "patrol";
}

// Namespace archetypempdog/dog
// Params 0, eflags: 0x0
// Checksum 0x3af63241, Offset: 0x1180
// Size: 0x2a
function function_2f834e7() {
    if (self.ai.state == 0) {
        return "patrol";
    }
    return "escort";
}

// Namespace archetypempdog/dog
// Params 0, eflags: 0x0
// Checksum 0x83d733a3, Offset: 0x11b8
// Size: 0x302
function function_3b52c84() {
    var_e2881c20 = function_2f834e7();
    if (var_e2881c20 == "escort" && self haspath() && isdefined(self.pathgoalpos)) {
        goalpos = self.pathgoalpos;
        if (isdefined(self.ai.var_b874e3b5) && self.ai.var_b874e3b5.goalpos === goalpos) {
            /#
                recordsphere(self.ai.var_b874e3b5.facepoint, 4, (1, 0.5, 0), "<dev string:x30>");
                recordline(self.ai.var_b874e3b5.facepoint, goalpos, (1, 0.5, 0), "<dev string:x30>");
            #/
            return self.ai.var_b874e3b5.arrivalyaw;
        }
        var_6157ce20 = self predictarrival();
        if (var_6157ce20[#"path_prediction_status"] === 2) {
            tacpoints = tacticalquery("mp_dog_arrival", goalpos);
            if (isdefined(tacpoints) && tacpoints.size) {
                facepoint = tacpoints[0].origin;
                var_5402f446 = vectornormalize(goalpos - self.origin);
                var_f8975fb4 = vectornormalize(facepoint - goalpos);
                var_5e6dda2f = vectortoangles(var_5402f446)[1];
                var_a8d001ea = vectortoangles(var_f8975fb4)[1];
                arrivalyaw = absangleclamp360(var_5e6dda2f - var_a8d001ea);
                self.ai.var_b874e3b5.goalpos = goalpos;
                self.ai.var_b874e3b5.arrivalyaw = arrivalyaw;
                self.ai.var_b874e3b5.facepoint = facepoint;
                return arrivalyaw;
            }
        }
    }
    arrivalyaw = self bb_getlocomotionarrivalyaw();
    return arrivalyaw;
}

// Namespace archetypempdog/dog
// Params 1, eflags: 0x0
// Checksum 0xcf1cf047, Offset: 0x14c8
// Size: 0xa2
function function_67f787fe(entity) {
    if (isdefined(self.ai.hasseenfavoriteenemy) && self.ai.hasseenfavoriteenemy && isdefined(self.enemy)) {
        return false;
    }
    var_e2881c20 = function_2f834e7();
    if (var_e2881c20 == "escort" && gettime() > self.ai.lookaround.var_1c9b697) {
        return true;
    }
    return false;
}

// Namespace archetypempdog/dog
// Params 0, eflags: 0x0
// Checksum 0x5c79d3d7, Offset: 0x1578
// Size: 0x2d2
function function_3678efd0() {
    if (isdefined(self.ai.hasseenfavoriteenemy) && self.ai.hasseenfavoriteenemy && isdefined(self.enemy)) {
        predictedpos = self function_5e534fba(self.enemy);
        if (isdefined(predictedpos)) {
            turnyaw = absangleclamp360(self.angles[1] - vectortoangles(predictedpos - self.origin)[1]);
            return turnyaw;
        }
    }
    if (self.ai.lookaround.var_7410d077 === gettime() && isdefined(self.ai.lookaround.var_ec5714d0)) {
        return self.ai.lookaround.var_ec5714d0;
    }
    if (function_67f787fe(self)) {
        tacpoints = tacticalquery("mp_dog_arrival", self.origin);
        if (isdefined(tacpoints) && tacpoints.size) {
            tacpoints = array::randomize(tacpoints);
            facepoint = tacpoints[0].origin;
            lookdir = anglestoforward(self.angles);
            var_f8975fb4 = vectornormalize(facepoint - self.origin);
            var_3cde2872 = vectortoangles(lookdir)[1];
            var_16dda43a = vectortoangles(var_f8975fb4)[1];
            turnyaw = absangleclamp360(var_3cde2872 - var_16dda43a);
            if (turnyaw >= 90 && turnyaw <= 270) {
                self.ai.lookaround.var_ec5714d0 = turnyaw;
                self.ai.lookaround.var_7410d077 = gettime();
                self.ai.lookaround.var_1c9b697 = gettime() + randomintrange(4500, 6500);
                return turnyaw;
            }
        }
    }
    return undefined;
}

// Namespace archetypempdog/dog
// Params 1, eflags: 0x0
// Checksum 0x6d93b45, Offset: 0x1858
// Size: 0x74
function function_23f8877c(entity) {
    entity melee();
    entity playsound(#"aml_dog_attack_jump");
    /#
        record3dtext("<dev string:x37>", self.origin, (1, 0, 0), "<dev string:x30>", entity);
    #/
}

// Namespace archetypempdog/dog
// Params 0, eflags: 0x0
// Checksum 0xe6369677, Offset: 0x18d8
// Size: 0x4a
function function_933704bd() {
    blackboard::createblackboardforentity(self);
    ai::createinterfaceforentity(self);
    self.___archetypeonanimscriptedcallback = &function_159d3c5b;
}

// Namespace archetypempdog/dog
// Params 1, eflags: 0x4
// Checksum 0x6e851e0a, Offset: 0x1930
// Size: 0x2c
function private function_159d3c5b(entity) {
    entity.__blackboard = undefined;
    entity function_933704bd();
}

// Namespace archetypempdog/dog
// Params 1, eflags: 0x0
// Checksum 0xc726c93a, Offset: 0x1968
// Size: 0x40
function getyaw(org) {
    angles = vectortoangles(org - self.origin);
    return angles[1];
}

// Namespace archetypempdog/dog
// Params 1, eflags: 0x0
// Checksum 0x7ba7c850, Offset: 0x19b0
// Size: 0x8a
function absyawtoenemy(enemy) {
    assert(isdefined(enemy));
    yaw = self.angles[1] - getyaw(enemy.origin);
    yaw = angleclamp180(yaw);
    if (yaw < 0) {
        yaw = -1 * yaw;
    }
    return yaw;
}

// Namespace archetypempdog/dog
// Params 1, eflags: 0x0
// Checksum 0xf737689, Offset: 0x1a48
// Size: 0x56
function can_see_enemy(enemy) {
    if (!isdefined(enemy)) {
        return false;
    }
    if (self function_cf6a62c(enemy)) {
        return false;
    }
    if (!self targetting_delay::function_3b2437d9(enemy, 0)) {
        return false;
    }
    return true;
}

// Namespace archetypempdog/dog
// Params 0, eflags: 0x4
// Checksum 0x5e84daf6, Offset: 0x1aa8
// Size: 0x1a
function private function_7c8eb77() {
    return self ai_state::function_7c8eb77();
}

// Namespace archetypempdog/dog
// Params 0, eflags: 0x4
// Checksum 0x74ea1ec8, Offset: 0x1ad0
// Size: 0x64
function private get_favorite_enemy() {
    var_38aa2f7a = self ai_state::function_c1aee63();
    attack_origin = self function_7c8eb77();
    if (isdefined(attack_origin)) {
        return ai_target::function_a8f13fc2(attack_origin, var_38aa2f7a);
    }
}

// Namespace archetypempdog/dog
// Params 0, eflags: 0x0
// Checksum 0xea835180, Offset: 0x1b40
// Size: 0x3e
function get_last_valid_position() {
    if (isplayer(self) && isdefined(self.last_valid_position)) {
        return self.last_valid_position;
    }
    return self.origin;
}

// Namespace archetypempdog/dog
// Params 1, eflags: 0x0
// Checksum 0x6fb7e3e6, Offset: 0x1b88
// Size: 0x7e
function function_7bfdc3f(entity) {
    aiutility::cleararrivalpos(entity);
    entity function_3c8dce03(entity.origin);
    entity.ai.lookaround.var_1c9b697 = gettime() + randomintrange(4500, 6500);
}

// Namespace archetypempdog/dog
// Params 1, eflags: 0x0
// Checksum 0x90a2e9a8, Offset: 0x1c10
// Size: 0x44
function function_5d87d173(entity) {
    if (isdefined(entity.ai.hasseenfavoriteenemy) && entity.ai.hasseenfavoriteenemy) {
        return true;
    }
    return false;
}

// Namespace archetypempdog/dog
// Params 1, eflags: 0x4
// Checksum 0x8eb739d1, Offset: 0x1c60
// Size: 0x22
function private function_e8afedda(entity) {
    entity.ai.reacquire_state = 0;
}

// Namespace archetypempdog/dog
// Params 1, eflags: 0x4
// Checksum 0xb58719f, Offset: 0x1c90
// Size: 0x236
function private function_892e7aa7(entity) {
    if (!isdefined(entity.ai.reacquire_state)) {
        entity.ai.reacquire_state = 0;
    }
    if (!isdefined(entity.enemy)) {
        entity.ai.reacquire_state = 0;
        return 0;
    }
    if (!isalive(entity.enemy)) {
        entity.ai.reacquire_state = 0;
        return;
    }
    if (entity function_cf6a62c(entity.enemy)) {
        entity.ai.reacquire_state = 4;
        return;
    }
    var_52b9cd2 = entity cansee(entity.enemy, 4000);
    hasattackedenemyrecently = entity attackedrecently(entity.enemy, 3);
    var_6d0806a6 = entity.enemy attackedrecently(entity, 3);
    var_39c9ba7c = isdefined(function_cfee2a04(entity.enemy.origin, 30));
    if (var_39c9ba7c && (var_52b9cd2 || hasattackedenemyrecently || var_6d0806a6)) {
        entity.ai.reacquire_state = 0;
        return 0;
    }
    entity.ai.reacquire_state++;
    if (entity.ai.reacquire_state >= 4) {
        entity flagenemyunattackable(randomintrange(4000, 4500));
    }
    return 0;
}

// Namespace archetypempdog/dog
// Params 2, eflags: 0x0
// Checksum 0x251d64dd, Offset: 0x1ed0
// Size: 0x36
function function_4efc4716(entity, enemy) {
    if (entity function_cf6a62c(enemy)) {
        return true;
    }
    return false;
}

// Namespace archetypempdog/dog
// Params 0, eflags: 0x4
// Checksum 0xe600bf5b, Offset: 0x1f10
// Size: 0x82
function private get_last_attacker() {
    if (isdefined(self.attacker)) {
        if (issentient(self.attacker)) {
            return self.attacker;
        }
        if (isdefined(self.attacker.script_owner) && issentient(self.attacker.script_owner)) {
            return self.attacker.script_owner;
        }
    }
    return undefined;
}

// Namespace archetypempdog/dog
// Params 1, eflags: 0x0
// Checksum 0xa65297d6, Offset: 0x1fa0
// Size: 0x4a4
function target_enemy(entity) {
    if (!isdefined(self.ai.state)) {
        return;
    }
    if (isdefined(self.ignoreall) && self.ignoreall) {
        return;
    }
    self.script_owner tracking::track();
    last_enemy = entity.favoriteenemy;
    var_4efc4716 = 0;
    var_ab06bb92 = 1;
    if (isdefined(last_enemy)) {
        var_4efc4716 = entity function_4efc4716(entity, last_enemy);
        if (!var_4efc4716 && isdefined(entity.ai.var_e94cd2bf) && gettime() >= entity.ai.var_e94cd2bf + 5000) {
            newenemy = entity get_favorite_enemy();
            if (isdefined(newenemy) && newenemy != last_enemy) {
                var_4efc4716 = 1;
                var_ab06bb92 = 0;
            }
        }
    }
    if (var_4efc4716 || entity.ai.state == 2 || isdefined(entity.favoriteenemy) && !entity ai_target::is_target_valid(entity.favoriteenemy)) {
        if (isdefined(entity.favoriteenemy) && isdefined(entity.favoriteenemy.hunted_by) && entity.favoriteenemy.hunted_by > 0) {
            entity.favoriteenemy.hunted_by--;
        }
        entity clearenemy();
        entity.favoriteenemy = undefined;
        entity.ai.hasseenfavoriteenemy = 0;
        entity.ai.var_e94cd2bf = undefined;
        if (var_ab06bb92) {
        }
        entity ai_state::function_e7060dfd();
        function_e8afedda(entity);
        return;
    }
    if (!entity ai_target::is_target_valid(entity.favoriteenemy)) {
        entity.favoriteenemy = entity get_favorite_enemy();
        entity targetting_delay::function_4ba58de4(entity.favoriteenemy, 0);
    }
    if (!(isdefined(entity.ai.hasseenfavoriteenemy) && entity.ai.hasseenfavoriteenemy)) {
        if (isdefined(entity.favoriteenemy) && entity can_see_enemy(entity.favoriteenemy)) {
            entity.ai.hasseenfavoriteenemy = 1;
            entity.ai.var_e94cd2bf = gettime();
            entity ai_state::function_e7060dfd();
            function_e8afedda(entity);
            level thread function_78fc434b(entity);
        }
    }
    if (isdefined(entity.favoriteenemy) && isdefined(entity.ai.hasseenfavoriteenemy) && entity.ai.hasseenfavoriteenemy) {
        if (gettime() >= entity.ai.var_e94cd2bf + 50) {
            enemypos = getclosestpointonnavmesh(entity.favoriteenemy.origin, 200, 1.2 * entity getpathfindingradius());
            if (isdefined(enemypos)) {
                entity function_3c8dce03(enemypos);
                return;
            }
            entity function_3c8dce03(entity.favoriteenemy.origin);
        }
    }
}

// Namespace archetypempdog/dog
// Params 1, eflags: 0x0
// Checksum 0x477b0e9f, Offset: 0x2450
// Size: 0xd8
function function_78fc434b(entity) {
    entity endon(#"death");
    wait 1;
    while (entity.ai.state != 2 && isdefined(entity.ai.hasseenfavoriteenemy) && entity.ai.hasseenfavoriteenemy) {
        entity clientfield::increment("ks_dog_bark", 1);
        entity playsound("aml_dog_run_bark");
        wait randomfloatrange(0.5, 1.2);
    }
}

// Namespace archetypempdog/dog
// Params 1, eflags: 0x0
// Checksum 0xabca1344, Offset: 0x2530
// Size: 0x44
function dogtargetservice(entity) {
    if (!isdefined(self.script_owner)) {
        return;
    }
    target_enemy(entity);
    entity ai_state::function_6ea20b5e();
}

// Namespace archetypempdog/dog
// Params 1, eflags: 0x0
// Checksum 0x7169a5ce, Offset: 0x2580
// Size: 0x24
function dogshouldwalk(entity) {
    return !dogshouldrun(entity);
}

// Namespace archetypempdog/dog
// Params 1, eflags: 0x0
// Checksum 0x3bcd641, Offset: 0x25b0
// Size: 0x62
function dogshouldrun(entity) {
    if (isdefined(self.ai.state)) {
        if (self.ai.state == 0 && self.ai.patrol.state == 1) {
            return false;
        }
    }
    return true;
}

// Namespace archetypempdog/dog
// Params 1, eflags: 0x0
// Checksum 0xafbce4cf, Offset: 0x2620
// Size: 0xbc
function function_6ea454fd(entity) {
    if (!(isdefined(self.ai.hasseenfavoriteenemy) && self.ai.hasseenfavoriteenemy)) {
        return false;
    }
    lastattacker = get_last_attacker();
    if (isdefined(lastattacker) && self.favoriteenemy === lastattacker) {
        if (lastattacker attackedrecently(self, 0.1) && entity.ai.var_e94cd2bf === gettime()) {
            return true;
        }
    }
    return false;
}

// Namespace archetypempdog/dog
// Params 1, eflags: 0x4
// Checksum 0xeaf14451, Offset: 0x26e8
// Size: 0x10
function private dogjukeinitialize(entity) {
    return true;
}

// Namespace archetypempdog/dog
// Params 1, eflags: 0x4
// Checksum 0x4d30cd6a, Offset: 0x2700
// Size: 0x4c
function private dogpreemptivejuketerminate(entity) {
    entity.nextpreemptivejuke = gettime() + randomintrange(4000, 7000);
    entity clearpath();
}

// Namespace archetypempdog/dog
// Params 1, eflags: 0x0
// Checksum 0x96794948, Offset: 0x2758
// Size: 0x2b4
function function_3a15eb4f(entity) {
    if (!isdefined(entity.enemy) || !isplayer(entity.enemy)) {
        return false;
    }
    if (isdefined(entity.nextpreemptivejuke) && entity.nextpreemptivejuke > gettime()) {
        return false;
    }
    disttoenemysq = distancesquared(entity.origin, entity.enemy.origin);
    if (disttoenemysq < 1500 * 1500 && disttoenemysq >= 550 * 550) {
        angledifference = absangleclamp180(entity.angles[1] - entity.enemy.angles[1]);
        /#
            record3dtext(angledifference, entity.origin + (0, 0, 5), (0, 1, 0), "<dev string:x3d>");
        #/
        if (angledifference > 135) {
            enemyangles = entity.enemy getgunangles();
            toenemy = entity.enemy.origin - entity.origin;
            forward = anglestoforward(enemyangles);
            dotproduct = abs(vectordot(vectornormalize(toenemy), forward));
            /#
                record3dtext(acos(dotproduct), entity.origin + (0, 0, 10), (0, 1, 0), "<dev string:x3d>");
            #/
            if (dotproduct > 0.9396 && aiutility::canjuke(entity)) {
                aiutility::choosejukedirection(entity);
                return true;
            }
        }
    }
    return false;
}

// Namespace archetypempdog/dog
// Params 2, eflags: 0x0
// Checksum 0xa922eb29, Offset: 0x2a18
// Size: 0x30
function dogmeleeaction(entity, asmstatename) {
    animationstatenetworkutility::requeststate(entity, asmstatename);
    return 5;
}

// Namespace archetypempdog/dog
// Params 2, eflags: 0x0
// Checksum 0xfc7422fe, Offset: 0x2a50
// Size: 0x18
function function_fb7437aa(entity, asmstatename) {
    return 4;
}

// Namespace archetypempdog/dog
// Params 5, eflags: 0x0
// Checksum 0xaf912721, Offset: 0x2a70
// Size: 0x84
function function_e410efd9(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
    entity animmode("zonly_physics", 0);
    entity.blockingpain = 1;
    entity.usegoalanimweight = 1;
    entity pathmode("dont move");
}

// Namespace archetypempdog/dog
// Params 5, eflags: 0x0
// Checksum 0x6a16d4f5, Offset: 0x2b00
// Size: 0x2c
function function_68f1aa90(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
    
}

// Namespace archetypempdog/dog
// Params 5, eflags: 0x0
// Checksum 0x7e73cb7d, Offset: 0x2b38
// Size: 0x84
function function_53037c62(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
    entity.blockingpain = 0;
    entity.usegoalanimweight = 0;
    entity pathmode("move allowed");
    entity orientmode("face default");
}

// Namespace archetypempdog/dog
// Params 1, eflags: 0x0
// Checksum 0xc56d7313, Offset: 0x2bc8
// Size: 0x26c
function function_5cee9f84(entity) {
    if (isdefined(entity.enemy)) {
        predictedenemypos = entity.enemy.origin;
        distancesq = distancesquared(entity.origin, entity.enemy.origin);
        if (isplayer(entity.enemy) && distancesq >= 100 * 100) {
            if (entity.enemy issprinting()) {
                enemyvelocity = vectornormalize(entity.enemy getvelocity());
                var_93152242 = vectornormalize(entity getvelocity());
                if (vectordot(var_93152242, enemyvelocity) > cos(20)) {
                    /#
                        record3dtext("<dev string:x48>", entity.origin + (0, 0, 60), (1, 0, 0), "<dev string:x61>");
                    #/
                    return false;
                }
            }
        }
        if (abs(entity.origin[2] - entity.enemy.origin[2]) > 64) {
            return false;
        }
        if (!entity cansee(entity.enemy)) {
            return false;
        }
        if (!tracepassedonnavmesh(entity.origin, entity.enemy.origin, entity getpathfindingradius())) {
            return false;
        }
        return true;
    }
    return true;
}

// Namespace archetypempdog/dog
// Params 5, eflags: 0x0
// Checksum 0x3d3f9374, Offset: 0x2f08
// Size: 0x6c
function function_e903ca6(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
    entity orientmode("face current");
    entity animmode("zonly_physics", 1);
}

// Namespace archetypempdog/dog
// Params 5, eflags: 0x0
// Checksum 0x14741984, Offset: 0x2f80
// Size: 0x4c
function function_40440d45(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
    entity orientmode("face default");
}

// Namespace archetypempdog/dog
// Params 5, eflags: 0x0
// Checksum 0x79547a86, Offset: 0x2fd8
// Size: 0x32c
function function_be2e2d3c(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
    entity animmode("gravity", 1);
    entity orientmode("face angle", entity.angles[1]);
    entity.blockingpain = 1;
    entity.usegoalanimweight = 1;
    entity pathmode("dont move");
    entity collidewithactors(0);
    entity pushplayer(0);
    if (isdefined(entity.enemy)) {
        dirtoenemy = vectornormalize(entity.enemy.origin - entity.origin);
        entity forceteleport(entity.origin, vectortoangles(dirtoenemy));
    }
    if (!isdefined(entity.meleeinfo)) {
        entity.meleeinfo = new class_b8ce49e3();
        entity.meleeinfo.var_b41f1299 = entity.origin;
        entity.meleeinfo.var_14f9d875 = getnotetracktimes(mocompanim, "start_adjust")[0];
        entity.meleeinfo.var_4a9e662e = getnotetracktimes(mocompanim, "end_adjust")[0];
        var_4e4d2dde = getmovedelta(mocompanim, 0, 1, entity);
        entity.meleeinfo.var_773d1d97 = entity localtoworldcoords(var_4e4d2dde);
        /#
            movedelta = getmovedelta(mocompanim, 0, 1, entity);
            animendpos = entity localtoworldcoords(movedelta);
            distance = distance(entity.origin, animendpos);
            recordcircle(animendpos, 3, (0, 1, 0), "<dev string:x61>");
            record3dtext("<dev string:x68>" + distance, animendpos, (0, 1, 0), "<dev string:x61>");
        #/
    }
}

// Namespace archetypempdog/dog
// Params 5, eflags: 0x0
// Checksum 0x63821c1d, Offset: 0x3310
// Size: 0xb34
function function_35d6884b(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
    assert(isdefined(entity.meleeinfo));
    currentanimtime = entity getanimtime(mocompanim);
    if (isdefined(entity.enemy) && !entity.meleeinfo.adjustmentstarted && entity.meleeinfo.var_98b8af1 && currentanimtime >= entity.meleeinfo.var_14f9d875) {
        predictedenemypos = entity.enemy.origin;
        if (isplayer(entity.enemy)) {
            velocity = entity.enemy getvelocity();
            if (length(velocity) > 0) {
                predictedenemypos += vectorscale(velocity, 0.25);
            }
        }
        entity.meleeinfo.adjustedendpos = predictedenemypos;
        var_f0c1075f = distancesquared(entity.meleeinfo.var_b41f1299, entity.meleeinfo.var_773d1d97);
        var_66728108 = distancesquared(entity.meleeinfo.var_773d1d97, entity.meleeinfo.adjustedendpos);
        var_873d139c = distancesquared(entity.meleeinfo.var_b41f1299, entity.meleeinfo.adjustedendpos);
        var_1c29e9f4 = tracepassedonnavmesh(entity.meleeinfo.var_b41f1299, entity.meleeinfo.adjustedendpos, entity getpathfindingradius());
        traceresult = bullettrace(entity.origin, entity.meleeinfo.adjustedendpos + (0, 0, 30), 0, entity);
        isvisible = traceresult[#"fraction"] == 1;
        var_6274a2e3 = 0;
        if (isdefined(traceresult[#"hitloc"]) && traceresult[#"hitloc"] == "riotshield") {
            var_8889a0a2 = vectornormalize(entity.origin - entity.meleeinfo.adjustedendpos);
            entity.meleeinfo.adjustedendpos += vectorscale(var_8889a0a2, 50);
            var_6274a2e3 = 1;
        }
        if (!var_1c29e9f4) {
            /#
                record3dtext("<dev string:x69>", entity.origin + (0, 0, 60), (1, 0, 0), "<dev string:x61>");
            #/
            entity.meleeinfo.var_98b8af1 = 0;
        } else if (var_f0c1075f > var_873d139c && var_66728108 >= 90 * 90) {
            /#
                record3dtext("<dev string:x78>", entity.origin + (0, 0, 60), (1, 0, 0), "<dev string:x61>");
            #/
            entity.meleeinfo.var_98b8af1 = 0;
        } else if (var_873d139c >= 300 * 300) {
            /#
                record3dtext("<dev string:x84>", entity.origin + (0, 0, 60), (1, 0, 0), "<dev string:x61>");
            #/
            entity.meleeinfo.var_98b8af1 = 0;
        }
        if (var_6274a2e3) {
            /#
                record3dtext("<dev string:x90>", entity.origin + (0, 0, 60), (1, 0, 0), "<dev string:x61>");
            #/
            entity.meleeinfo.var_98b8af1 = 1;
        }
        if (entity.meleeinfo.var_98b8af1) {
            var_66728108 = distancesquared(entity.meleeinfo.var_773d1d97, entity.meleeinfo.adjustedendpos);
            myforward = anglestoforward(entity.angles);
            var_63d012a3 = (entity.enemy.origin[0], entity.enemy.origin[1], entity.origin[2]);
            dirtoenemy = vectornormalize(var_63d012a3 - entity.origin);
            zdiff = entity.meleeinfo.var_773d1d97[2] - entity.enemy.origin[2];
            withinzrange = abs(zdiff) <= 45;
            withinfov = vectordot(myforward, dirtoenemy) > cos(30);
            var_4f74dce4 = withinzrange && withinfov;
            var_98b8af1 = (isvisible || var_6274a2e3) && var_4f74dce4;
            /#
                reasons = "<dev string:xa1>" + isvisible + "<dev string:xa6>" + withinzrange + "<dev string:xaa>" + withinfov;
                if (var_98b8af1) {
                    record3dtext(reasons, entity.origin + (0, 0, 60), (0, 1, 0), "<dev string:x61>");
                } else {
                    record3dtext(reasons, entity.origin + (0, 0, 60), (1, 0, 0), "<dev string:x61>");
                }
            #/
            if (var_98b8af1) {
                var_fb46decc = length(entity.meleeinfo.adjustedendpos - entity.meleeinfo.var_773d1d97);
                timestep = function_f9f48566();
                animlength = getanimlength(mocompanim) * 1000;
                starttime = entity.meleeinfo.var_14f9d875 * animlength;
                stoptime = entity.meleeinfo.var_4a9e662e * animlength;
                starttime = floor(starttime / timestep);
                stoptime = floor(stoptime / timestep);
                adjustduration = stoptime - starttime;
                entity.meleeinfo.var_e4382b96 = vectornormalize(entity.meleeinfo.adjustedendpos - entity.meleeinfo.var_773d1d97);
                entity.meleeinfo.var_8ae4eb71 = var_fb46decc / adjustduration;
                entity.meleeinfo.var_98b8af1 = 1;
                entity.meleeinfo.adjustmentstarted = 1;
            } else {
                entity.meleeinfo.var_98b8af1 = 0;
            }
        }
    }
    if (entity.meleeinfo.adjustmentstarted && currentanimtime <= entity.meleeinfo.var_4a9e662e) {
        assert(isdefined(entity.meleeinfo.var_e4382b96) && isdefined(entity.meleeinfo.var_8ae4eb71));
        /#
            recordsphere(entity.meleeinfo.var_773d1d97, 3, (0, 1, 0), "<dev string:x61>");
            recordsphere(entity.meleeinfo.adjustedendpos, 3, (0, 0, 1), "<dev string:x61>");
        #/
        adjustedorigin = entity.origin + entity.meleeinfo.var_e4382b96 * entity.meleeinfo.var_8ae4eb71;
        entity forceteleport(adjustedorigin);
    }
}

// Namespace archetypempdog/dog
// Params 5, eflags: 0x0
// Checksum 0x230ea158, Offset: 0x3e50
// Size: 0xbe
function function_e3b2357(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
    entity.blockingpain = 0;
    entity.usegoalanimweight = 0;
    entity pathmode("move allowed");
    entity orientmode("face default");
    entity collidewithactors(1);
    entity pushplayer(1);
    entity.meleeinfo = undefined;
}

// Namespace archetypempdog/bhtn_action_start
// Params 1, eflags: 0x40
// Checksum 0x3794fb4d, Offset: 0x3f18
// Size: 0x6c
function event_handler[bhtn_action_start] function_eb2e6c09(eventstruct) {
    if (isdefined(self.archetype) && self.archetype == "mp_dog") {
        if (eventstruct.action == "bark") {
            self playsound(#"aml_dog_run_bark");
        }
    }
}

