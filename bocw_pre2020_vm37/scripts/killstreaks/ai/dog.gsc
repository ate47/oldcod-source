#using script_3819e7a1427df6d2;
#using scripts\core_common\ai\archetype_locomotion_utility;
#using scripts\core_common\ai\systems\ai_interface;
#using scripts\core_common\ai\systems\animation_state_machine_mocomp;
#using scripts\core_common\ai\systems\animation_state_machine_notetracks;
#using scripts\core_common\ai\systems\animation_state_machine_utility;
#using scripts\core_common\ai\systems\behavior_state_machine;
#using scripts\core_common\ai\systems\behavior_tree_utility;
#using scripts\core_common\ai\systems\blackboard;
#using scripts\core_common\animation_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\struct;
#using scripts\core_common\targetting_delay;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
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

    var var_268b3fe5;

    // Namespace lookaround/dog
    // Params 0, eflags: 0x8
    // Checksum 0xf244fa6, Offset: 0x438
    // Size: 0x2e
    constructor() {
        var_268b3fe5 = gettime() + randomintrange(4500, 6500);
    }

}

// Namespace archetypempdog
// Method(s) 2 Total 2
class class_bd3490ad {

}

// Namespace archetypempdog
// Method(s) 2 Total 2
class class_9fa5eb75 {

    var adjustmentstarted;
    var var_425c4c8b;

    // Namespace class_9fa5eb75/dog
    // Params 0, eflags: 0x8
    // Checksum 0xdcc7e958, Offset: 0x3a08
    // Size: 0x1a
    constructor() {
        adjustmentstarted = 0;
        var_425c4c8b = 1;
    }

}

// Namespace archetypempdog/dog
// Params 0, eflags: 0x0
// Checksum 0xd29acbb3, Offset: 0x320
// Size: 0x10c
function init() {
    spawner::add_archetype_spawn_function(#"mp_dog", &function_ef4b81af);
    registerbehaviorscriptfunctions();
    if (!isdefined(level.extra_screen_electricity_)) {
        level.extra_screen_electricity_ = spawnstruct();
        level.extra_screen_electricity_.functions = [];
        clientfield::register("actor", "ks_dog_bark", 1, 1, "int");
        clientfield::register("actor", "ks_shocked", 1, 1, "int");
    }
    ai_patrol::init();
    ai_escort::init();
    ai_leave::init();
}

// Namespace archetypempdog/dog
// Params 0, eflags: 0x4
// Checksum 0x9a26fb4a, Offset: 0x5b0
// Size: 0x21c
function private function_ef4b81af() {
    function_ae45f57b();
    self setplayercollision(0);
    self allowpitchangle(1);
    self setpitchorient();
    self setavoidancemask("avoid all");
    self collidewithactors(0);
    self function_11578581(30);
    self.ai.var_8a9efbb6 = 1;
    self.var_259f6c17 = 1;
    self.ignorepathenemyfightdist = 1;
    self.jukemaxdistance = 1800;
    self.highlyawareradius = 350;
    self.fovcosine = 0;
    self.fovcosinebusy = 0;
    self.maxsightdistsqrd = function_a3f6cdac(900);
    self.sightlatency = 150;
    self.var_8908e328 = 1;
    self.ai.reacquire_state = 0;
    self.ai.var_54b19f55 = 1;
    self.ai.lookaround = new lookaround();
    self.ai.var_bd3490ad = new class_bd3490ad();
    self thread targetting_delay::function_7e1a12ce(4000);
    self thread function_8f876521();
    self callback::function_d8abfc3d(#"hash_c3f225c9fa3cb25", &function_3fb68a86);
    aiutility::addaioverridedamagecallback(self, &function_d6d0a32e);
}

// Namespace archetypempdog/dog
// Params 0, eflags: 0x0
// Checksum 0x6ac0653a, Offset: 0x7d8
// Size: 0x24
function function_3fb68a86() {
    self clientfield::set("ks_dog_bark", 0);
}

// Namespace archetypempdog/dog
// Params 1, eflags: 0x0
// Checksum 0xe275773d, Offset: 0x808
// Size: 0x21e
function function_a543b380(player) {
    if (!isalive(player) || player.sessionstate != "playing") {
        return false;
    }
    if (self.owner === player) {
        return false;
    }
    if (!player util::isenemyteam(self.team)) {
        return false;
    }
    if (player.team == #"spectator") {
        return false;
    }
    if (!player playerads()) {
        return false;
    }
    weapon = player getcurrentweapon();
    if (!isdefined(weapon) || !isdefined(weapon.rootweapon)) {
        return false;
    }
    if (weapon.rootweapon != getweapon(#"shotgun_semiauto_t8")) {
        return false;
    }
    distsq = distancesquared(self.origin, player.origin);
    if (distsq > function_a3f6cdac(900)) {
        return false;
    }
    if (!util::within_fov(self.origin, self.angles, player.origin, cos(45))) {
        return false;
    }
    if (!util::within_fov(player.origin, player getplayerangles(), self.origin, cos(45))) {
        return false;
    }
    return true;
}

// Namespace archetypempdog/dog
// Params 0, eflags: 0x0
// Checksum 0xe2d85496, Offset: 0xa30
// Size: 0x1dc
function function_8f876521() {
    self endon(#"death");
    self.ai.var_e90b47c1 = gettime();
    while (isalive(self)) {
        if (isdefined(self.ai.var_e90b47c1) && gettime() <= self.ai.var_e90b47c1) {
            wait 1;
            continue;
        }
        players = getplayers();
        foreach (player in players) {
            if (!function_a543b380(player)) {
                continue;
            }
            if (self cansee(player)) {
                self.health += 1;
                self dodamage(1, player.origin, undefined, undefined, "torso_lower", "MOD_UNKNOWN", 0, getweapon("eq_swat_grenade"), 0, 1);
                self.ai.var_e90b47c1 = gettime() + randomintrange(6000, 13000);
                break;
            }
        }
        wait 1;
    }
}

// Namespace archetypempdog/dog
// Params 0, eflags: 0x0
// Checksum 0x92ff81e, Offset: 0xc18
// Size: 0xa14
function registerbehaviorscriptfunctions() {
    assert(isscriptfunctionptr(&dogtargetservice));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"mpdogtargetservice", &dogtargetservice, 1);
    assert(isscriptfunctionptr(&dogshouldwalk));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"mpdogshouldwalk", &dogshouldwalk);
    assert(isscriptfunctionptr(&dogshouldwalk));
    behaviorstatemachine::registerbsmscriptapiinternal(#"mpdogshouldwalk", &dogshouldwalk);
    assert(isscriptfunctionptr(&dogshouldrun));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"mpdogshouldrun", &dogshouldrun);
    assert(isscriptfunctionptr(&dogshouldrun));
    behaviorstatemachine::registerbsmscriptapiinternal(#"mpdogshouldrun", &dogshouldrun);
    assert(isscriptfunctionptr(&function_e382db1f));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_4178f7c4c6cfaeb6", &function_e382db1f);
    assert(isscriptfunctionptr(&function_6c2426d3));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_7aaa666497426ef4", &function_6c2426d3);
    assert(isscriptfunctionptr(&function_6c2426d3));
    behaviorstatemachine::registerbsmscriptapiinternal(#"hash_7aaa666497426ef4", &function_6c2426d3);
    assert(isscriptfunctionptr(&dogjukeinitialize));
    behaviorstatemachine::registerbsmscriptapiinternal(#"mpdogjukeinitialize", &dogjukeinitialize);
    assert(isscriptfunctionptr(&dogpreemptivejuketerminate));
    behaviorstatemachine::registerbsmscriptapiinternal(#"mpdogpreemptivejuketerminate", &dogpreemptivejuketerminate);
    assert(isscriptfunctionptr(&function_3089bb44));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_366c0b2c4164cc87", &function_3089bb44);
    assert(isscriptfunctionptr(&function_3089bb44));
    behaviorstatemachine::registerbsmscriptapiinternal(#"hash_366c0b2c4164cc87", &function_3089bb44);
    assert(isscriptfunctionptr(&function_b2e0da2));
    behaviorstatemachine::registerbsmscriptapiinternal(#"hash_65dc8904419628da", &function_b2e0da2);
    assert(isscriptfunctionptr(&function_3b9e385c));
    behaviorstatemachine::registerbsmscriptapiinternal(#"hash_4066108355410b7a", &function_3b9e385c);
    assert(isscriptfunctionptr(&function_ac9765d1));
    behaviorstatemachine::registerbsmscriptapiinternal(#"hash_3fdd4a9f016c4ba4", &function_ac9765d1);
    assert(isscriptfunctionptr(&function_d338afb8));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_28582743cd920a21", &function_d338afb8);
    assert(isscriptfunctionptr(&function_bcd7b170));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_3349a77142623d80", &function_bcd7b170);
    assert(isscriptfunctionptr(&function_4f9ebad6));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_bb74fb159118080", &function_4f9ebad6);
    assert(isscriptfunctionptr(&function_81c29086));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_34183bbd11db144", &function_81c29086);
    assert(isscriptfunctionptr(&function_c34253a9));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_3d584bfcad6c773d", &function_c34253a9);
    assert(isscriptfunctionptr(&function_aa64de4));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_27012a71f42b1b17", &function_aa64de4);
    assert(isscriptfunctionptr(&function_e7c4b160));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_a7fe4ffd555ca49", &function_e7c4b160);
    animationstatenetwork::registernotetrackhandlerfunction("dog_melee", &function_cebd576f);
    animationstatenetwork::registernotetrackhandlerfunction("camera_switch", &function_943e2e80);
    animationstatenetwork::registeranimationmocomp("mocomp_mp_dog_juke", &function_475a38e6, &function_75068028, &function_13978732);
    animationstatenetwork::registeranimationmocomp("mocomp_mp_dog_charge_melee", &function_b1eb29d8, &function_a5923bea, &function_668f9379);
    animationstatenetwork::registeranimationmocomp("mocomp_mp_dog_bark", &function_b17821dd, undefined, &function_92620306);
}

// Namespace archetypempdog/dog
// Params 1, eflags: 0x0
// Checksum 0x32ab63ea, Offset: 0x1638
// Size: 0x136
function function_aa64de4(entity) {
    if (!isdefined(entity.enemy)) {
        return false;
    }
    if (!isplayer(entity.enemy)) {
        return false;
    }
    player = entity.enemy;
    groundpos = groundtrace(player.origin + (0, 0, 8), player.origin + (0, 0, -100000), 0, player)[#"position"];
    if (!isdefined(groundpos)) {
        return false;
    }
    if (distancesquared(groundpos, player.origin) > 30) {
        return false;
    }
    if (!util::within_fov(player.origin, player.angles, entity.origin, cos(40))) {
        return false;
    }
    return true;
}

// Namespace archetypempdog/dog
// Params 1, eflags: 0x0
// Checksum 0xa625bd9b, Offset: 0x1778
// Size: 0x124
function function_e7c4b160(entity) {
    entity endon(#"death");
    latch_enemy = entity.enemy;
    latch_enemy endon(#"disconnect");
    alignnode = spawnstruct();
    alignnode.origin = entity.enemy.origin;
    alignnode.angles = entity.enemy.angles;
    alignnode thread function_a87b3d2b(entity, latch_enemy, alignnode);
    alignnode waittilltimeout(5, #"hash_7a32b2af2eef5415");
    if (isdefined(alignnode)) {
        alignnode struct::delete();
    }
    if (isdefined(latch_enemy)) {
        latch_enemy notify(#"hash_7a32b2af2eef5415");
    }
    if (isdefined(entity)) {
        entity clearpath();
    }
}

// Namespace archetypempdog/dog
// Params 3, eflags: 0x4
// Checksum 0x6eb0030c, Offset: 0x18a8
// Size: 0xf0
function private function_bb0117ce(entity, latch_enemy, alignnode) {
    alignnode endon(#"hash_7a32b2af2eef5415");
    entity endon(#"hash_24933216f788ed72");
    latch_enemy endon(#"disconnect", #"death");
    entity waittill(#"death");
    latch_enemy notify(#"hash_7d9a0a6fe117968f");
    latch_enemy setclientthirdperson(0);
    alignnode scene::stop("pb_death_stand_dog_bite_f");
    alignnode notify(#"hash_7a32b2af2eef5415");
}

// Namespace archetypempdog/dog
// Params 3, eflags: 0x4
// Checksum 0xe3ebbbf5, Offset: 0x19a0
// Size: 0x158
function private function_a87b3d2b(entity, latch_enemy, alignnode) {
    latch_enemy endon(#"disconnect");
    latch_enemy endon(#"hash_7d9a0a6fe117968f");
    entity.ai.var_ec2fbdf = 1;
    entity thread function_bb0117ce(entity, latch_enemy, alignnode);
    alignnode scene::play("pb_death_stand_dog_bite_f", array(entity, latch_enemy));
    if (isdefined(latch_enemy) && !level.gameended) {
        latch_enemy startragdoll(1);
        latch_enemy.var_6f9e9dc9 = 1;
        latch_enemy kill(entity.origin, entity, entity.owner);
    }
    if (isdefined(entity)) {
        entity.ai.var_ec2fbdf = 0;
        entity.meleeinfo = undefined;
    }
    alignnode notify(#"hash_7a32b2af2eef5415");
}

// Namespace archetypempdog/dog
// Params 12, eflags: 0x0
// Checksum 0x1fa891da, Offset: 0x1b00
// Size: 0xda
function function_d6d0a32e(*inflictor, attacker, damage, idflags, meansofdeath, weapon, *point, *dir, *hitloc, *offsettime, *boneindex, *modelindex) {
    chargelevel = 0;
    weapon_damage = killstreak_bundles::get_weapon_damage("dog", self.maxhealth, dir, modelindex, boneindex, hitloc, offsettime, chargelevel);
    if (!isdefined(weapon_damage)) {
        weapon_damage = killstreaks::get_old_damage(dir, modelindex, boneindex, hitloc, 1);
    }
    return weapon_damage;
}

// Namespace archetypempdog/dog
// Params 1, eflags: 0x4
// Checksum 0x536b08bc, Offset: 0x1be8
// Size: 0x56
function private function_4f9ebad6(entity) {
    var_14e113b = entity.var_40543c03;
    return var_14e113b === "concussion" || var_14e113b === "electrical" || var_14e113b === "flash";
}

// Namespace archetypempdog/dog
// Params 1, eflags: 0x4
// Checksum 0x6c9932d1, Offset: 0x1c48
// Size: 0x64
function private function_81c29086(entity) {
    if (entity.var_40543c03 === "electrical") {
        clientfield::set("ks_shocked", 1);
    }
    entity clientfield::set("ks_dog_bark", 0);
}

// Namespace archetypempdog/dog
// Params 1, eflags: 0x4
// Checksum 0x3e1230be, Offset: 0x1cb8
// Size: 0x24
function private function_c34253a9(*entity) {
    clientfield::set("ks_shocked", 0);
}

// Namespace archetypempdog/dog
// Params 1, eflags: 0x0
// Checksum 0x257f3d80, Offset: 0x1ce8
// Size: 0x2c
function function_d338afb8(entity) {
    return entity function_d68af34c() == "patrol";
}

// Namespace archetypempdog/dog
// Params 0, eflags: 0x0
// Checksum 0xaa6a7f48, Offset: 0x1d20
// Size: 0x3e
function function_d68af34c() {
    if (isdefined(self.ai.state) && self.ai.state == 0) {
        return "patrol";
    }
    return "escort";
}

// Namespace archetypempdog/dog
// Params 0, eflags: 0x0
// Checksum 0x6f4e03d6, Offset: 0x1d68
// Size: 0x302
function function_1eda333b() {
    var_da7abcda = function_d68af34c();
    if (var_da7abcda == "escort" && self haspath() && isdefined(self.pathgoalpos)) {
        goalpos = self.pathgoalpos;
        if (isdefined(self.ai.var_bd3490ad) && self.ai.var_bd3490ad.goalpos === goalpos) {
            /#
                recordsphere(self.ai.var_bd3490ad.facepoint, 4, (1, 0.5, 0), "<dev string:x38>");
                recordline(self.ai.var_bd3490ad.facepoint, goalpos, (1, 0.5, 0), "<dev string:x38>");
            #/
            return self.ai.var_bd3490ad.arrivalyaw;
        }
        var_e5eff04f = self predictarrival();
        if (var_e5eff04f[#"path_prediction_status"] === 2) {
            tacpoints = tacticalquery("mp_dog_arrival", goalpos);
            if (isdefined(tacpoints) && tacpoints.size) {
                facepoint = tacpoints[0].origin;
                var_514ffbc7 = vectornormalize(goalpos - self.origin);
                var_62724777 = vectornormalize(facepoint - goalpos);
                var_616967d2 = vectortoangles(var_514ffbc7)[1];
                var_238f4f40 = vectortoangles(var_62724777)[1];
                arrivalyaw = absangleclamp360(var_616967d2 - var_238f4f40);
                self.ai.var_bd3490ad.goalpos = goalpos;
                self.ai.var_bd3490ad.arrivalyaw = arrivalyaw;
                self.ai.var_bd3490ad.facepoint = facepoint;
                return arrivalyaw;
            }
        }
    }
    arrivalyaw = self bb_getlocomotionarrivalyaw();
    return arrivalyaw;
}

// Namespace archetypempdog/dog
// Params 1, eflags: 0x0
// Checksum 0xf1d713fa, Offset: 0x2078
// Size: 0x9a
function function_a3708944(*entity) {
    if (is_true(self.ai.hasseenfavoriteenemy) && isdefined(self.enemy)) {
        return false;
    }
    var_da7abcda = function_d68af34c();
    if (var_da7abcda == "escort" && gettime() > self.ai.lookaround.var_268b3fe5) {
        return true;
    }
    return false;
}

// Namespace archetypempdog/dog
// Params 0, eflags: 0x0
// Checksum 0xdd463364, Offset: 0x2120
// Size: 0x2ca
function function_c2bf7f10() {
    if (is_true(self.ai.hasseenfavoriteenemy) && isdefined(self.enemy)) {
        predictedpos = self function_18c9035f(self.enemy);
        if (isdefined(predictedpos)) {
            turnyaw = absangleclamp360(self.angles[1] - vectortoangles(predictedpos - self.origin)[1]);
            return turnyaw;
        }
    }
    if (self.ai.lookaround.var_894c8373 === gettime() && isdefined(self.ai.lookaround.var_d166ed3d)) {
        return self.ai.lookaround.var_d166ed3d;
    }
    if (function_a3708944(self)) {
        tacpoints = tacticalquery("mp_dog_arrival", self.origin);
        if (isdefined(tacpoints) && tacpoints.size) {
            tacpoints = array::randomize(tacpoints);
            facepoint = tacpoints[0].origin;
            lookdir = anglestoforward(self.angles);
            var_62724777 = vectornormalize(facepoint - self.origin);
            var_3de41380 = vectortoangles(lookdir)[1];
            var_ba54da4 = vectortoangles(var_62724777)[1];
            turnyaw = absangleclamp360(var_3de41380 - var_ba54da4);
            if (turnyaw >= 90 && turnyaw <= 270) {
                self.ai.lookaround.var_d166ed3d = turnyaw;
                self.ai.lookaround.var_894c8373 = gettime();
                self.ai.lookaround.var_268b3fe5 = gettime() + randomintrange(4500, 6500);
                return turnyaw;
            }
        }
    }
    return undefined;
}

// Namespace archetypempdog/dog
// Params 1, eflags: 0x0
// Checksum 0x96cedf28, Offset: 0x23f8
// Size: 0x54
function function_943e2e80(entity) {
    if (isdefined(entity.enemy) && isplayer(entity.enemy)) {
        entity.enemy setclientthirdperson(1);
    }
}

// Namespace archetypempdog/dog
// Params 1, eflags: 0x0
// Checksum 0xf7283f68, Offset: 0x2458
// Size: 0x74
function function_cebd576f(entity) {
    if (is_true(entity.ai.var_ec2fbdf)) {
    } else {
        entity melee();
    }
    /#
        record3dtext("<dev string:x42>", self.origin, (1, 0, 0), "<dev string:x38>", entity);
    #/
}

// Namespace archetypempdog/dog
// Params 0, eflags: 0x0
// Checksum 0x64b7eea, Offset: 0x24d8
// Size: 0x4a
function function_ae45f57b() {
    blackboard::createblackboardforentity(self);
    ai::createinterfaceforentity(self);
    self.___archetypeonanimscriptedcallback = &function_cb274b5;
}

// Namespace archetypempdog/dog
// Params 1, eflags: 0x4
// Checksum 0xce5e21, Offset: 0x2530
// Size: 0x2c
function private function_cb274b5(entity) {
    entity.__blackboard = undefined;
    entity function_ae45f57b();
}

// Namespace archetypempdog/dog
// Params 1, eflags: 0x0
// Checksum 0x8b327a2c, Offset: 0x2568
// Size: 0x3e
function getyaw(org) {
    angles = vectortoangles(org - self.origin);
    return angles[1];
}

// Namespace archetypempdog/dog
// Params 1, eflags: 0x0
// Checksum 0xd331746e, Offset: 0x25b0
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
// Checksum 0x7f3281ff, Offset: 0x2648
// Size: 0x56
function can_see_enemy(enemy) {
    if (!isdefined(enemy)) {
        return false;
    }
    if (self function_ce6d3545(enemy)) {
        return false;
    }
    if (!self targetting_delay::function_1c169b3a(enemy, 0)) {
        return false;
    }
    return true;
}

// Namespace archetypempdog/dog
// Params 0, eflags: 0x4
// Checksum 0xea94f1b, Offset: 0x26a8
// Size: 0x1a
function private function_a78474f2() {
    return self ai_state::function_a78474f2();
}

// Namespace archetypempdog/dog
// Params 0, eflags: 0x4
// Checksum 0x115c2078, Offset: 0x26d0
// Size: 0x64
function private get_favorite_enemy() {
    var_edc20efd = self ai_state::function_4af1ff64();
    var_ff716a93 = self function_a78474f2();
    if (isdefined(var_ff716a93)) {
        return ai_target::function_84235351(var_ff716a93, var_edc20efd);
    }
}

// Namespace archetypempdog/dog
// Params 0, eflags: 0x0
// Checksum 0x8796550d, Offset: 0x2740
// Size: 0x3e
function get_last_valid_position() {
    if (isplayer(self) && isdefined(self.last_valid_position)) {
        return self.last_valid_position;
    }
    return self.origin;
}

// Namespace archetypempdog/dog
// Params 1, eflags: 0x0
// Checksum 0xbde81f5e, Offset: 0x2788
// Size: 0x7e
function function_3b9e385c(entity) {
    aiutility::cleararrivalpos(entity);
    entity function_a57c34b7(entity.origin);
    entity.ai.lookaround.var_268b3fe5 = gettime() + randomintrange(4500, 6500);
}

// Namespace archetypempdog/dog
// Params 1, eflags: 0x0
// Checksum 0xfbce74c, Offset: 0x2810
// Size: 0x36
function function_b2e0da2(entity) {
    if (is_true(entity.ai.hasseenfavoriteenemy)) {
        return true;
    }
    return false;
}

// Namespace archetypempdog/dog
// Params 1, eflags: 0x4
// Checksum 0x32e0f34d, Offset: 0x2850
// Size: 0x1e
function private lid_closedpositionservicee(entity) {
    entity.ai.reacquire_state = 0;
}

// Namespace archetypempdog/dog
// Params 1, eflags: 0x4
// Checksum 0xe45d5179, Offset: 0x2878
// Size: 0x216
function private function_bcd7b170(entity) {
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
    if (entity function_ce6d3545(entity.enemy)) {
        entity.ai.reacquire_state = 4;
        return;
    }
    var_27cd0f02 = entity cansee(entity.enemy, 20000);
    hasattackedenemyrecently = entity attackedrecently(entity.enemy, 3);
    var_fef47407 = entity.enemy attackedrecently(entity, 3);
    var_3b82352c = isdefined(function_9cc082d2(entity.enemy.origin, 30));
    if (var_3b82352c && (var_27cd0f02 || hasattackedenemyrecently || var_fef47407)) {
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
// Checksum 0xaeb729e1, Offset: 0x2a98
// Size: 0x36
function function_dc0b544b(entity, enemy) {
    if (entity function_ce6d3545(enemy)) {
        return true;
    }
    return false;
}

// Namespace archetypempdog/dog
// Params 0, eflags: 0x4
// Checksum 0xe29670c0, Offset: 0x2ad8
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
// Checksum 0x42b6e4f0, Offset: 0x2b68
// Size: 0x474
function target_enemy(entity) {
    if (!isdefined(self.ai.state)) {
        return;
    }
    if (is_true(self.ignoreall)) {
        return;
    }
    self.script_owner tracking::track();
    last_enemy = entity.favoriteenemy;
    var_dc0b544b = 0;
    var_fe3bf748 = 1;
    if (isdefined(last_enemy)) {
        var_dc0b544b = entity function_dc0b544b(entity, last_enemy);
        if (!var_dc0b544b && isdefined(entity.ai.var_4520deec) && gettime() >= entity.ai.var_4520deec + 15000) {
            newenemy = entity get_favorite_enemy();
            if (isdefined(newenemy) && newenemy != last_enemy) {
                var_dc0b544b = 1;
                var_fe3bf748 = 0;
            }
        }
    }
    if (var_dc0b544b || entity.ai.state == 2 || isdefined(entity.favoriteenemy) && !entity ai_target::is_target_valid(entity.favoriteenemy)) {
        if (isdefined(entity.favoriteenemy) && isdefined(entity.favoriteenemy.hunted_by) && entity.favoriteenemy.hunted_by > 0) {
            entity.favoriteenemy.hunted_by--;
        }
        entity clearenemy();
        entity.favoriteenemy = undefined;
        entity.ai.hasseenfavoriteenemy = 0;
        entity.ai.var_4520deec = undefined;
        if (var_fe3bf748) {
        }
        entity ai_state::function_e0e1a7fc();
        lid_closedpositionservicee(entity);
        return;
    }
    if (!entity ai_target::is_target_valid(entity.favoriteenemy)) {
        entity.favoriteenemy = entity get_favorite_enemy();
        entity targetting_delay::function_a4d6d6d8(entity.favoriteenemy, 0);
    }
    if (!is_true(entity.ai.hasseenfavoriteenemy)) {
        if (isdefined(entity.favoriteenemy) && entity can_see_enemy(entity.favoriteenemy)) {
            entity.ai.hasseenfavoriteenemy = 1;
            entity.ai.var_4520deec = gettime();
            entity ai_state::function_e0e1a7fc();
            lid_closedpositionservicee(entity);
            level thread function_df8cb62a(entity);
        }
    }
    if (isdefined(entity.favoriteenemy) && is_true(entity.ai.hasseenfavoriteenemy)) {
        if (gettime() >= entity.ai.var_4520deec + 50) {
            enemypos = getclosestpointonnavmesh(entity.favoriteenemy.origin, 400, 1.2 * entity getpathfindingradius());
            if (isdefined(enemypos)) {
                entity function_a57c34b7(enemypos);
                return;
            }
            entity function_a57c34b7(entity.favoriteenemy.origin);
        }
    }
}

// Namespace archetypempdog/dog
// Params 1, eflags: 0x0
// Checksum 0x52b6d981, Offset: 0x2fe8
// Size: 0x130
function function_df8cb62a(entity) {
    entity endon(#"death");
    wait 1;
    while (entity.ai.state != 2 && is_true(entity.ai.hasseenfavoriteenemy)) {
        if (isdefined(entity.enemy) && distancesquared(entity.enemy.origin, entity.origin) <= function_a3f6cdac(400)) {
            entity clientfield::set("ks_dog_bark", 1);
            wait 1;
            entity clientfield::set("ks_dog_bark", 0);
        }
        wait randomfloatrange(0.5, 1);
    }
}

// Namespace archetypempdog/dog
// Params 1, eflags: 0x0
// Checksum 0x404b1bec, Offset: 0x3120
// Size: 0x44
function dogtargetservice(entity) {
    if (!isdefined(self.script_owner)) {
        return;
    }
    target_enemy(entity);
    entity ai_state::function_e8e7cf45();
}

// Namespace archetypempdog/dog
// Params 1, eflags: 0x0
// Checksum 0xb7b7518c, Offset: 0x3170
// Size: 0x24
function dogshouldwalk(entity) {
    return !dogshouldrun(entity);
}

// Namespace archetypempdog/dog
// Params 1, eflags: 0x0
// Checksum 0x2440e73f, Offset: 0x31a0
// Size: 0x62
function dogshouldrun(*entity) {
    if (isdefined(self.ai.state)) {
        if (self.ai.state == 0 && self.ai.patrol.state == 1) {
            return false;
        }
    }
    return true;
}

// Namespace archetypempdog/dog
// Params 1, eflags: 0x0
// Checksum 0x9ff05cb5, Offset: 0x3210
// Size: 0xb0
function function_e382db1f(entity) {
    if (!is_true(self.ai.hasseenfavoriteenemy)) {
        return false;
    }
    lastattacker = get_last_attacker();
    if (isdefined(lastattacker) && self.favoriteenemy === lastattacker) {
        if (lastattacker attackedrecently(self, 0.1) && entity.ai.var_4520deec === gettime()) {
            return true;
        }
    }
    return false;
}

// Namespace archetypempdog/dog
// Params 1, eflags: 0x4
// Checksum 0x6c0af6bd, Offset: 0x32c8
// Size: 0x36
function private function_ac9765d1(entity) {
    entity.nextpreemptivejuke = gettime() + randomintrange(4500, 6000);
}

// Namespace archetypempdog/dog
// Params 1, eflags: 0x4
// Checksum 0x38db99d9, Offset: 0x3308
// Size: 0x10
function private dogjukeinitialize(*entity) {
    return true;
}

// Namespace archetypempdog/dog
// Params 1, eflags: 0x4
// Checksum 0xe3cc04f7, Offset: 0x3320
// Size: 0x36
function private dogpreemptivejuketerminate(entity) {
    entity.nextpreemptivejuke = gettime() + randomintrange(4500, 6000);
}

// Namespace archetypempdog/dog
// Params 1, eflags: 0x0
// Checksum 0xc7cccc7e, Offset: 0x3360
// Size: 0x28a
function function_6c2426d3(entity) {
    if (!isdefined(entity.enemy) || !isplayer(entity.enemy)) {
        return false;
    }
    if (isdefined(entity.nextpreemptivejuke) && entity.nextpreemptivejuke > gettime()) {
        return false;
    }
    disttoenemysq = distancesquared(entity.origin, entity.enemy.origin);
    if (disttoenemysq < function_a3f6cdac(1800) && disttoenemysq >= function_a3f6cdac(400)) {
        if (util::within_fov(entity.origin, entity.angles, entity.enemy.origin, cos(30))) {
            if (util::within_fov(entity.enemy.origin, entity.enemy.angles, entity.origin, cos(30))) {
                enemyangles = entity.enemy.angles;
                toenemy = entity.enemy.origin - entity.origin;
                forward = anglestoforward(enemyangles);
                dotproduct = abs(vectordot(vectornormalize(toenemy), forward));
                /#
                    record3dtext(acos(dotproduct), entity.origin + (0, 0, 10), (0, 1, 0), "<dev string:x4b>");
                #/
                if (dotproduct > 0.766) {
                    return true;
                }
            }
        }
    }
    return false;
}

// Namespace archetypempdog/dog
// Params 2, eflags: 0x0
// Checksum 0xa95600fb, Offset: 0x35f8
// Size: 0x30
function dogmeleeaction(entity, asmstatename) {
    animationstatenetworkutility::requeststate(entity, asmstatename);
    return 5;
}

// Namespace archetypempdog/dog
// Params 2, eflags: 0x0
// Checksum 0x12aba0a, Offset: 0x3630
// Size: 0x18
function function_303397b0(*entity, *asmstatename) {
    return 4;
}

// Namespace archetypempdog/dog
// Params 5, eflags: 0x0
// Checksum 0x7fb4604a, Offset: 0x3650
// Size: 0x84
function function_475a38e6(entity, *mocompanim, *mocompanimblendouttime, *mocompanimflag, *mocompduration) {
    mocompduration animmode("zonly_physics", 0);
    mocompduration.blockingpain = 1;
    mocompduration.usegoalanimweight = 1;
    mocompduration pathmode("dont move");
}

// Namespace archetypempdog/dog
// Params 5, eflags: 0x0
// Checksum 0x1fcf7536, Offset: 0x36e0
// Size: 0x2c
function function_75068028(*entity, *mocompanim, *mocompanimblendouttime, *mocompanimflag, *mocompduration) {
    
}

// Namespace archetypempdog/dog
// Params 5, eflags: 0x0
// Checksum 0x703da537, Offset: 0x3718
// Size: 0x7c
function function_13978732(entity, *mocompanim, *mocompanimblendouttime, *mocompanimflag, *mocompduration) {
    mocompduration.blockingpain = 0;
    mocompduration.usegoalanimweight = 0;
    mocompduration pathmode("move allowed");
    mocompduration orientmode("face default");
}

// Namespace archetypempdog/dog
// Params 1, eflags: 0x0
// Checksum 0x131b81d0, Offset: 0x37a0
// Size: 0x25c
function function_3089bb44(entity) {
    if (isdefined(entity.enemy)) {
        predictedenemypos = entity.enemy.origin;
        distancesq = distancesquared(entity.origin, entity.enemy.origin);
        if (isplayer(entity.enemy) && distancesq >= function_a3f6cdac(100)) {
            if (entity.enemy issprinting()) {
                enemyvelocity = vectornormalize(entity.enemy getvelocity());
                var_7a61ad67 = vectornormalize(entity getvelocity());
                if (vectordot(var_7a61ad67, enemyvelocity) > cos(20)) {
                    /#
                        record3dtext("<dev string:x59>", entity.origin + (0, 0, 60), (1, 0, 0), "<dev string:x75>");
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
        if (!isdefined(function_9cc082d2(entity.enemy.origin + (0, 0, 30), 60))) {
            return false;
        }
        return true;
    }
    return false;
}

// Namespace archetypempdog/dog
// Params 5, eflags: 0x0
// Checksum 0xc7aafa76, Offset: 0x3ac8
// Size: 0x6c
function function_b17821dd(entity, *mocompanim, *mocompanimblendouttime, *mocompanimflag, *mocompduration) {
    mocompduration orientmode("face current");
    mocompduration animmode("zonly_physics", 1);
}

// Namespace archetypempdog/dog
// Params 5, eflags: 0x0
// Checksum 0x6cadd94e, Offset: 0x3b40
// Size: 0x4c
function function_92620306(entity, *mocompanim, *mocompanimblendouttime, *mocompanimflag, *mocompduration) {
    mocompduration orientmode("face default");
}

// Namespace archetypempdog/dog
// Params 5, eflags: 0x0
// Checksum 0xfd7a6a09, Offset: 0x3b98
// Size: 0x2fc
function function_b1eb29d8(entity, mocompanim, *mocompanimblendouttime, *mocompanimflag, *mocompduration) {
    mocompanimflag animmode("gravity", 1);
    mocompanimflag orientmode("face angle", mocompanimflag.angles[1]);
    mocompanimflag.usegoalanimweight = 1;
    mocompanimflag pathmode("dont move");
    mocompanimflag collidewithactors(0);
    mocompanimflag pushplayer(0);
    if (isdefined(mocompanimflag.enemy)) {
        dirtoenemy = vectornormalize(mocompanimflag.enemy.origin - mocompanimflag.origin);
        mocompanimflag forceteleport(mocompanimflag.origin, vectortoangles(dirtoenemy));
    }
    if (!isdefined(mocompanimflag.meleeinfo)) {
        mocompanimflag.meleeinfo = new class_9fa5eb75();
        mocompanimflag.meleeinfo.var_9bfa8497 = mocompanimflag.origin;
        mocompanimflag.meleeinfo.var_98bc84b7 = getnotetracktimes(mocompduration, "start_adjust")[0];
        mocompanimflag.meleeinfo.var_6392c3a2 = getnotetracktimes(mocompduration, "end_adjust")[0];
        var_e397f54c = getmovedelta(mocompduration, 0, 1);
        mocompanimflag.meleeinfo.var_cb28f380 = mocompanimflag localtoworldcoords(var_e397f54c);
        /#
            movedelta = getmovedelta(mocompduration, 0, 1);
            animendpos = mocompanimflag localtoworldcoords(movedelta);
            distance = distance(mocompanimflag.origin, animendpos);
            recordcircle(animendpos, 3, (0, 1, 0), "<dev string:x75>");
            record3dtext("<dev string:x7f>" + distance, animendpos, (0, 1, 0), "<dev string:x75>");
        #/
    }
}

// Namespace archetypempdog/dog
// Params 5, eflags: 0x0
// Checksum 0x686402f, Offset: 0x3ea0
// Size: 0xaac
function function_a5923bea(entity, mocompanim, *mocompanimblendouttime, *mocompanimflag, *mocompduration) {
    assert(isdefined(mocompanimflag.meleeinfo));
    currentanimtime = mocompanimflag getanimtime(mocompduration);
    if (isdefined(mocompanimflag.enemy) && !mocompanimflag.meleeinfo.adjustmentstarted && mocompanimflag.meleeinfo.var_425c4c8b && currentanimtime >= mocompanimflag.meleeinfo.var_98bc84b7) {
        predictedenemypos = mocompanimflag.enemy.origin;
        if (isplayer(mocompanimflag.enemy)) {
            velocity = mocompanimflag.enemy getvelocity();
            if (length(velocity) > 0) {
                predictedenemypos += vectorscale(velocity, 0.25);
            }
        }
        mocompanimflag.meleeinfo.adjustedendpos = predictedenemypos;
        var_cf699df5 = distancesquared(mocompanimflag.meleeinfo.var_9bfa8497, mocompanimflag.meleeinfo.var_cb28f380);
        var_776ddabf = distancesquared(mocompanimflag.meleeinfo.var_cb28f380, mocompanimflag.meleeinfo.adjustedendpos);
        var_65cbfb52 = distancesquared(mocompanimflag.meleeinfo.var_9bfa8497, mocompanimflag.meleeinfo.adjustedendpos);
        var_201660e6 = tracepassedonnavmesh(mocompanimflag.meleeinfo.var_9bfa8497, mocompanimflag.meleeinfo.adjustedendpos, mocompanimflag getpathfindingradius());
        traceresult = bullettrace(mocompanimflag.origin, mocompanimflag.meleeinfo.adjustedendpos + (0, 0, 30), 0, mocompanimflag);
        isvisible = traceresult[#"fraction"] == 1;
        var_535d098c = 0;
        if (isdefined(traceresult[#"hitloc"]) && traceresult[#"hitloc"] == "riotshield") {
            var_cc075bd0 = vectornormalize(mocompanimflag.origin - mocompanimflag.meleeinfo.adjustedendpos);
            mocompanimflag.meleeinfo.adjustedendpos += vectorscale(var_cc075bd0, 50);
            var_535d098c = 1;
        }
        if (!var_201660e6) {
            /#
                record3dtext("<dev string:x83>", mocompanimflag.origin + (0, 0, 60), (1, 0, 0), "<dev string:x75>");
            #/
            mocompanimflag.meleeinfo.var_425c4c8b = 0;
        } else if (var_cf699df5 > var_65cbfb52 && var_776ddabf >= function_a3f6cdac(90)) {
            /#
                record3dtext("<dev string:x95>", mocompanimflag.origin + (0, 0, 60), (1, 0, 0), "<dev string:x75>");
            #/
            mocompanimflag.meleeinfo.var_425c4c8b = 0;
        } else if (var_65cbfb52 >= function_a3f6cdac(300)) {
            /#
                record3dtext("<dev string:xa4>", mocompanimflag.origin + (0, 0, 60), (1, 0, 0), "<dev string:x75>");
            #/
            mocompanimflag.meleeinfo.var_425c4c8b = 0;
        }
        if (var_535d098c) {
            /#
                record3dtext("<dev string:xb3>", mocompanimflag.origin + (0, 0, 60), (1, 0, 0), "<dev string:x75>");
            #/
            mocompanimflag.meleeinfo.var_425c4c8b = 1;
        }
        if (mocompanimflag.meleeinfo.var_425c4c8b) {
            var_776ddabf = distancesquared(mocompanimflag.meleeinfo.var_cb28f380, mocompanimflag.meleeinfo.adjustedendpos);
            var_beabc994 = anglestoforward(mocompanimflag.angles);
            var_1c3641f2 = (mocompanimflag.enemy.origin[0], mocompanimflag.enemy.origin[1], mocompanimflag.origin[2]);
            dirtoenemy = vectornormalize(var_1c3641f2 - mocompanimflag.origin);
            zdiff = mocompanimflag.meleeinfo.var_cb28f380[2] - mocompanimflag.enemy.origin[2];
            var_6738a702 = abs(zdiff) <= 45;
            withinfov = vectordot(var_beabc994, dirtoenemy) > cos(30);
            var_7948b2f3 = var_6738a702 && withinfov;
            var_425c4c8b = (isvisible || var_535d098c) && var_7948b2f3;
            /#
                reasons = "<dev string:xc7>" + isvisible + "<dev string:xcf>" + var_6738a702 + "<dev string:xd6>" + withinfov;
                if (var_425c4c8b) {
                    record3dtext(reasons, mocompanimflag.origin + (0, 0, 60), (0, 1, 0), "<dev string:x75>");
                } else {
                    record3dtext(reasons, mocompanimflag.origin + (0, 0, 60), (1, 0, 0), "<dev string:x75>");
                }
            #/
            if (var_425c4c8b) {
                var_90c3cdd2 = length(mocompanimflag.meleeinfo.adjustedendpos - mocompanimflag.meleeinfo.var_cb28f380);
                timestep = function_60d95f53();
                animlength = getanimlength(mocompduration) * 1000;
                starttime = mocompanimflag.meleeinfo.var_98bc84b7 * animlength;
                stoptime = mocompanimflag.meleeinfo.var_6392c3a2 * animlength;
                starttime = floor(starttime / timestep);
                stoptime = floor(stoptime / timestep);
                adjustduration = stoptime - starttime;
                mocompanimflag.meleeinfo.var_10b8b6d1 = vectornormalize(mocompanimflag.meleeinfo.adjustedendpos - mocompanimflag.meleeinfo.var_cb28f380);
                mocompanimflag.meleeinfo.var_8b9a15a6 = var_90c3cdd2 / adjustduration;
                mocompanimflag.meleeinfo.var_425c4c8b = 1;
                mocompanimflag.meleeinfo.adjustmentstarted = 1;
            } else {
                mocompanimflag.meleeinfo.var_425c4c8b = 0;
            }
        }
    }
    if (mocompanimflag.meleeinfo.adjustmentstarted && currentanimtime <= mocompanimflag.meleeinfo.var_6392c3a2) {
        assert(isdefined(mocompanimflag.meleeinfo.var_10b8b6d1) && isdefined(mocompanimflag.meleeinfo.var_8b9a15a6));
        /#
            recordsphere(mocompanimflag.meleeinfo.var_cb28f380, 3, (0, 1, 0), "<dev string:x75>");
            recordsphere(mocompanimflag.meleeinfo.adjustedendpos, 3, (0, 0, 1), "<dev string:x75>");
        #/
        adjustedorigin = mocompanimflag.origin + mocompanimflag.meleeinfo.var_10b8b6d1 * mocompanimflag.meleeinfo.var_8b9a15a6;
        mocompanimflag forceteleport(adjustedorigin);
    }
}

// Namespace archetypempdog/dog
// Params 5, eflags: 0x0
// Checksum 0xa8de4b49, Offset: 0x4958
// Size: 0xae
function function_668f9379(entity, *mocompanim, *mocompanimblendouttime, *mocompanimflag, *mocompduration) {
    mocompduration.usegoalanimweight = 0;
    mocompduration pathmode("move allowed");
    mocompduration orientmode("face default");
    mocompduration collidewithactors(1);
    mocompduration pushplayer(1);
    mocompduration.meleeinfo = undefined;
}

// Namespace archetypempdog/bhtn_action_start
// Params 1, eflags: 0x40
// Checksum 0xc2acf70f, Offset: 0x4a10
// Size: 0x6c
function event_handler[bhtn_action_start] function_df9abf31(eventstruct) {
    if (isdefined(self.archetype) && self.archetype == #"mp_dog") {
        if (eventstruct.action == "bark") {
            self playsound(#"hash_21775fa77c0df395");
        }
    }
}

