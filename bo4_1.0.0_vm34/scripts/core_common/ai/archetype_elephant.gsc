#using script_2c5daa95f8fec03c;
#using script_67e37e63e177f107;
#using scripts\core_common\ai\archetype_damage_utility;
#using scripts\core_common\ai\archetype_locomotion_utility;
#using scripts\core_common\ai\systems\ai_blackboard;
#using scripts\core_common\ai\systems\ai_interface;
#using scripts\core_common\ai\systems\animation_state_machine_mocomp;
#using scripts\core_common\ai\systems\animation_state_machine_notetracks;
#using scripts\core_common\ai\systems\behavior_state_machine;
#using scripts\core_common\ai\systems\behavior_tree_utility;
#using scripts\core_common\ai\systems\blackboard;
#using scripts\core_common\ai\systems\gib;
#using scripts\core_common\ai\zombie_utility;
#using scripts\core_common\animation_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\laststand_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\statemachine_shared;
#using scripts\core_common\status_effects\status_effect_util;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;
#using scripts\core_common\vehicle_ai_shared;

#namespace archetypeelephant;

// Namespace archetypeelephant
// Method(s) 2 Total 2
class class_e110e441 {

    var var_1ed9db82;
    var var_4a9e662e;
    var var_64caa560;

    // Namespace class_e110e441/archetype_elephant
    // Params 0, eflags: 0x8
    // Checksum 0xcb00a600, Offset: 0x62c0
    // Size: 0x26
    constructor() {
        var_1ed9db82 = 0;
        var_4a9e662e = 0;
        var_64caa560 = 0;
    }

}

// Namespace archetypeelephant/archetype_elephant
// Params 0, eflags: 0x2
// Checksum 0x92eed00e, Offset: 0x740
// Size: 0x19c
function autoexec main() {
    registerbehaviorscriptfunctions();
    spawner::add_archetype_spawn_function("elephant", &function_29de00f7);
    spawner::add_archetype_spawn_function("elephant", &function_ee4da73e);
    clientfield::register("actor", "towers_boss_melee_effect", 1, 1, "counter");
    clientfield::register("actor", "tower_boss_death_fx", 1, 1, "counter");
    clientfield::register("actor", "towers_boss_eye_fx_cf", 1, 1, "int");
    clientfield::register("scriptmover", "towers_boss_head_proj_fx_cf", 1, 1, "int");
    clientfield::register("scriptmover", "towers_boss_head_proj_explosion_fx_cf", 1, 1, "int");
    clientfield::register("actor", "sndTowersBossArmor", 1, 1, "int");
    /#
        level thread setup_devgui();
    #/
}

// Namespace archetypeelephant/archetype_elephant
// Params 0, eflags: 0x4
// Checksum 0x383b1e69, Offset: 0x8e8
// Size: 0x686
function private registerbehaviorscriptfunctions() {
    assert(isscriptfunctionptr(&function_4dce5325));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_2f6e4a95b8974fcd", &function_4dce5325);
    assert(isscriptfunctionptr(&function_d8d1487c));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_40d6b5994b49d7aa", &function_d8d1487c);
    assert(isscriptfunctionptr(&function_db745d9));
    behaviorstatemachine::registerbsmscriptapiinternal(#"hash_9188ed9ed594c69", &function_db745d9);
    assert(isscriptfunctionptr(&elephantknockdownservice));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"elephantknockdownservice", &elephantknockdownservice);
    assert(isscriptfunctionptr(&function_a5b69ca6));
    behaviorstatemachine::registerbsmscriptapiinternal(#"hash_4b225936ae91a204", &function_a5b69ca6);
    assert(isscriptfunctionptr(&elephantshouldmelee));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"elephantshouldmelee", &elephantshouldmelee);
    assert(isscriptfunctionptr(&elephantshouldmelee));
    behaviorstatemachine::registerbsmscriptapiinternal(#"elephantshouldmelee", &elephantshouldmelee);
    assert(isscriptfunctionptr(&function_2406af35));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_597ef06035bca069", &function_2406af35);
    assert(isscriptfunctionptr(&function_1a2eb773));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_4e7335c0f98549c3", &function_1a2eb773);
    assert(isscriptfunctionptr(&function_4b41033));
    behaviorstatemachine::registerbsmscriptapiinternal(#"hash_4fbf554dacfacc1f", &function_4b41033);
    assert(isscriptfunctionptr(&function_e4ca9016));
    behaviorstatemachine::registerbsmscriptapiinternal(#"hash_67699fc0b32fc954", &function_e4ca9016);
    assert(isscriptfunctionptr(&function_aaba1c90));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_72b216f44f66e0ca", &function_aaba1c90);
    animationstatenetwork::registeranimationmocomp("mocomp_melee@towers_boss", &function_8fb88df5, &function_afa59ad4, &function_6f52fb04);
    animationstatenetwork::registernotetrackhandlerfunction("towersboss_melee", &function_f4b00816);
    animationstatenetwork::registernotetrackhandlerfunction("towersboss_melee_big", &function_c2c3c910);
    animationstatenetwork::registernotetrackhandlerfunction("launch_head_proj", &function_c44b7a50);
    animationstatenetwork::registernotetrackhandlerfunction("launch_head_proj2", &function_c44b7a50);
    animationstatenetwork::registernotetrackhandlerfunction("towers_boss_ground_attack", &function_e14550fe);
    animation::add_global_notetrack_handler("carriage_explode", &function_4e9a9ec2, 0);
    animation::add_global_notetrack_handler("tower_boss_death_effects", &function_f2b13ce4, 0);
    animation::add_global_notetrack_handler("tower_boss_entrace_effects", &function_f2b13ce4, 0);
    level.var_17e8f697 = &function_fa7c3fd1;
}

// Namespace archetypeelephant/archetype_elephant
// Params 1, eflags: 0x0
// Checksum 0x2a518bed, Offset: 0xf78
// Size: 0x170
function function_fa7c3fd1(dustball) {
    enemies = util::function_8260dc36(self.team);
    foreach (target in enemies) {
        if (isplayer(target)) {
            distsq = distancesquared(dustball.origin, target.origin);
            if (distsq <= 150 * 150) {
                params = getstatuseffect(#"hash_12a64221f4d27f9b");
                weapon = getweapon(#"zombie_ai_defaultmelee");
                target status_effect::status_effect_apply(params, weapon, dustball, 1, 2, undefined, self.origin);
            }
        }
    }
}

// Namespace archetypeelephant/archetype_elephant
// Params 0, eflags: 0x0
// Checksum 0xa4c91a5b, Offset: 0x10f0
// Size: 0x24
function function_f2b13ce4() {
    self clientfield::increment("tower_boss_death_fx");
}

// Namespace archetypeelephant/archetype_elephant
// Params 0, eflags: 0x0
// Checksum 0xc2d4d0c7, Offset: 0x1120
// Size: 0x332
function elephantstartdeath() {
    model = "p8_fxanim_zm_towers_boss_death_01_mod";
    animname = "p8_fxanim_zm_towers_boss_death_01_anim";
    deathanim = self animmappingsearch(#"hash_3af6e4606cafd1ed");
    if (self.ai.phase == #"hash_266f56fb994e6639") {
        model = "p8_fxanim_zm_towers_boss_death_02_mod";
        animname = "p8_fxanim_zm_towers_boss_death_02_anim";
        deathanim = self animmappingsearch(#"hash_2ca88c72c7b85749");
    }
    self.skipdeath = 1;
    self.diedinscriptedanim = 1;
    self.entrailsmodel = spawn("script_model", self.origin);
    self.entrailsmodel setmodel(model);
    self.entrailsmodel useanimtree("generic");
    self.entrailsmodel thread animation::play(animname, self.origin, self.angles, 1, 0.2, 0.1, undefined, undefined, undefined, 0);
    origin = self.origin;
    angles = self.angles;
    var_41a597bf = self.ai.phase == #"hash_266f53fb994e6120";
    self.skipdeath = 1;
    self animation::play(deathanim, self.origin, self.angles, 1, 0.2, 0.1, undefined, undefined, undefined, 0);
    self kill();
    level thread function_244b282e();
    if (var_41a597bf) {
        soulball = spawnvehicle(#"hash_2db015dc967ccf56", origin, angles, "soul_ball_ai");
        waitframe(2);
        if (isdefined(soulball)) {
            soulball.var_92eddb80 = 1;
            var_6c1e9724 = struct::get("soul_exit", "targetname");
            pos = getclosestpointonnavmesh(var_6c1e9724.origin, 500, 30);
            soulball vehicle_ai::set_state("soul");
            soulball.ai.var_d91827d9 = pos;
        }
    }
}

// Namespace archetypeelephant/archetype_elephant
// Params 0, eflags: 0x0
// Checksum 0x2cfec03, Offset: 0x1460
// Size: 0x34
function function_244b282e() {
    wait 4.5;
    playsoundatposition(#"hash_4cf49c7c9533b539", (0, 0, 0));
}

// Namespace archetypeelephant/archetype_elephant
// Params 3, eflags: 0x0
// Checksum 0xc501e254, Offset: 0x14a0
// Size: 0x21e
function function_3ee2b551(launchpos, trajectory, targetpos) {
    self endon(#"hash_79e095919e415a70");
    self endon(#"death");
    /#
        assert(trajectory.size);
        recordsphere(targetpos, 3, (0, 1, 1), "<dev string:x30>");
        recordline(launchpos, trajectory[0], (0, 1, 1), "<dev string:x37>");
        while (true) {
            i = 0;
            foreach (point in trajectory) {
                recordsphere(point, 3, (0, 1, 1), "<dev string:x30>");
                if (isdefined(trajectory[i + 1])) {
                    recordline(point, trajectory[i + 1], (0, 1, 1), "<dev string:x37>");
                }
                i++;
            }
            recordsphere(targetpos, 3, (0, 1, 1), "<dev string:x30>");
            recordline(point, targetpos, (0, 1, 1), "<dev string:x37>");
            waitframe(1);
        }
    #/
}

// Namespace archetypeelephant/archetype_elephant
// Params 1, eflags: 0x0
// Checksum 0xc3fac9aa, Offset: 0x16c8
// Size: 0x3b8
function function_c44b7a50(entity) {
    assert(isdefined(entity.ai.var_4a339e42));
    launchpos = entity gettagorigin("j_head");
    var_c33d60f9 = entity gettagangles("j_head");
    /#
        recordsphere(launchpos, 3, (0, 0, 1), "<dev string:x37>");
    #/
    headproj = spawn("script_model", launchpos);
    headproj setmodel("tag_origin");
    vectorfromenemy = vectornormalize(entity.origin - entity.favoriteenemy.origin);
    vectorfromenemy = vectorscale(vectorfromenemy, 250);
    targetpos = entity.favoriteenemy.origin + vectorfromenemy + (0, 0, 200);
    headproj.enemytarget = entity.favoriteenemy;
    headproj clientfield::set("towers_boss_head_proj_fx_cf", 1);
    trajectory = [];
    dirtotarget = targetpos - launchpos;
    var_d7e4328b = (0, 0, 30);
    var_80ca1634 = (0, 0, 200);
    trajectory[trajectory.size] = launchpos + dirtotarget * 0.85 + var_d7e4328b;
    trajectory[trajectory.size] = launchpos + dirtotarget * 0.5 + var_80ca1634;
    trajectory[trajectory.size] = launchpos + dirtotarget * 0.15 + var_d7e4328b;
    trajectory = array::reverse(trajectory);
    /#
        self thread function_3ee2b551(launchpos, trajectory, targetpos);
    #/
    var_b9ffda45 = 0.3;
    foreach (point in trajectory) {
        headproj moveto(point, var_b9ffda45);
        headproj waittill(#"movedone");
    }
    self playsound(#"hash_62894125ab280b62");
    self notify(#"hash_79e095919e415a70");
    if (isdefined(entity.ai.var_88f1cd90)) {
        [[ entity.ai.var_88f1cd90 ]](entity, headproj);
    }
}

// Namespace archetypeelephant/archetype_elephant
// Params 1, eflags: 0x4
// Checksum 0x884517b9, Offset: 0x1a88
// Size: 0x4cc
function private function_c2c3c910(entity) {
    origin = entity gettagorigin("j_nose4");
    radiusdamage(origin, 600, 70, 30, entity);
    enemies = util::function_8260dc36(self.team);
    foreach (target in enemies) {
        dist = distance(self.origin, target.origin);
        if (isplayer(target) && dist < 600) {
            params = getstatuseffect(#"hash_2c80515d8ac9f1b4");
            weapon = getweapon(#"zombie_ai_defaultmelee");
            target status_effect::status_effect_apply(params, weapon, entity, 0, 500);
            var_4dfbed98 = (target.origin[0], target.origin[1], self.origin[2]);
            var_fdb35783 = vectornormalize(var_4dfbed98 - self.origin);
            target playerknockback(1);
            knockback = mapfloat(0, 600, 100, 1000, dist);
            target applyknockback(int(knockback), var_fdb35783);
            target playerknockback(0);
        }
    }
    entity clientfield::increment("towers_boss_melee_effect");
    zombiesarray = getaiarchetypearray("zombie");
    zombiesarray = arraycombine(zombiesarray, getaiarchetypearray("catalyst"), 0, 0);
    zombiesarray = arraycombine(zombiesarray, getaiarchetypearray("tiger"), 0, 0);
    zombiesarray = array::filter(zombiesarray, 0, &function_606db17e, entity);
    [[ self.ai.var_969c4d3a ]](zombiesarray, entity);
    var_210d17c2 = getentarray("towers_boss_tower_trigger", "targetname");
    foreach (var_f24a5933 in var_210d17c2) {
        if (!(isdefined(var_f24a5933.b_exploded) && var_f24a5933.b_exploded)) {
            distsq = distancesquared(entity.origin, var_f24a5933.origin);
            if (distsq < 300 * 300) {
                continue;
            }
            if (!util::within_fov(entity.origin, entity.angles, var_f24a5933.origin, cos(90))) {
                continue;
            }
            var_f24a5933 notify(#"tower_boss_scripted_trigger_tower");
        }
    }
}

// Namespace archetypeelephant/archetype_elephant
// Params 1, eflags: 0x4
// Checksum 0x8e046c2c, Offset: 0x1f60
// Size: 0x284
function private function_f4b00816(entity) {
    origin = entity gettagorigin("j_nose4");
    radiusdamage(origin, 450, 70, 30, entity);
    enemies = util::function_8260dc36(self.team);
    foreach (target in enemies) {
        dist = distance(self.origin, target.origin);
        if (isplayer(target) && dist < 450) {
            params = getstatuseffect(#"hash_2c80515d8ac9f1b4");
            weapon = getweapon("zombie_ai_defaultmelee");
            target status_effect::status_effect_apply(params, weapon, entity, 0, 500);
            var_fdb35783 = vectornormalize(anglestoforward(target.origin - self.origin));
            target playerknockback(1);
            knockback = mapfloat(0, 450, 100, 500, dist);
            target applyknockback(int(knockback), var_fdb35783);
            target playerknockback(0);
        }
    }
    entity clientfield::increment("towers_boss_melee_effect");
}

// Namespace archetypeelephant/archetype_elephant
// Params 0, eflags: 0x0
// Checksum 0x9cc05200, Offset: 0x21f0
// Size: 0x86
function function_bb9a0d8c() {
    if (isdefined(self.enemy)) {
        predictedpos = self.enemy.origin;
        if (isdefined(predictedpos)) {
            turnyaw = absangleclamp360(self.angles[1] - vectortoangles(predictedpos - self.origin)[1]);
            return turnyaw;
        }
    }
    return undefined;
}

// Namespace archetypeelephant/archetype_elephant
// Params 2, eflags: 0x0
// Checksum 0x9504cdb6, Offset: 0x2280
// Size: 0x3c4
function function_ac9efbfd(elephant, waittime = 0) {
    wait waittime;
    elephant detach(self.ai.armor, "tag_origin");
    if (elephant isattached(#"hash_4f282285ef50e3ee", "tag_origin")) {
        elephant detach(#"hash_4f282285ef50e3ee", "tag_origin");
    }
    if (elephant isattached(#"hash_4f282185ef50e23b", "tag_origin")) {
        elephant detach(#"hash_4f282185ef50e23b", "tag_origin");
    }
    if (elephant isattached(#"hash_4f282085ef50e088", "tag_origin")) {
        elephant detach(#"hash_4f282085ef50e088", "tag_origin");
    }
    if (elephant isattached(#"hash_4f282785ef50ec6d", "tag_origin")) {
        elephant detach(#"hash_4f282785ef50ec6d", "tag_origin");
    }
    if (elephant isattached(#"hash_4f282585ef50e907", "tag_origin")) {
        elephant detach(#"hash_4f282585ef50e907", "tag_origin");
    }
    if (elephant isattached(#"c_t8_zmb_dlc0_elephant_chain1", "tag_origin")) {
        elephant detach(#"c_t8_zmb_dlc0_elephant_chain1", "tag_origin");
    }
    if (elephant isattached(#"c_t8_zmb_dlc0_elephant_chain2", "tag_origin")) {
        elephant detach(#"c_t8_zmb_dlc0_elephant_chain2", "tag_origin");
    }
    if (elephant isattached(#"c_t8_zmb_dlc0_elephant_chain3", "tag_origin")) {
        elephant detach(#"c_t8_zmb_dlc0_elephant_chain3", "tag_origin");
    }
    if (elephant isattached(#"c_t8_zmb_dlc0_elephant_chain4", "tag_origin")) {
        elephant detach(#"c_t8_zmb_dlc0_elephant_chain4", "tag_origin");
    }
    if (elephant isattached(#"c_t8_zmb_dlc0_elephant_chain5", "tag_origin")) {
        elephant detach(#"c_t8_zmb_dlc0_elephant_chain5", "tag_origin");
    }
    if (elephant isattached(#"c_t8_zmb_dlc0_elephant_chain6", "tag_origin")) {
        elephant detach(#"c_t8_zmb_dlc0_elephant_chain6", "tag_origin");
    }
}

// Namespace archetypeelephant/archetype_elephant
// Params 0, eflags: 0x4
// Checksum 0xa0e799d4, Offset: 0x2650
// Size: 0x1ac
function private function_3facabbe() {
    self endon(#"death");
    while (!isdefined(self.ai.phase)) {
        waitframe(1);
    }
    if (self.ai.phase == #"hash_266f56fb994e6639") {
        self.ai.armor = #"hash_53ac5aa39c680a35";
    } else {
        self.ai.armor = #"hash_76c423ccbf246dc2";
    }
    self attach(self.ai.armor, "tag_origin");
    self attach(#"c_t8_zmb_dlc0_elephant_chain1", "tag_origin");
    self attach(#"c_t8_zmb_dlc0_elephant_chain2", "tag_origin");
    self attach(#"c_t8_zmb_dlc0_elephant_chain3", "tag_origin");
    self attach(#"c_t8_zmb_dlc0_elephant_chain4", "tag_origin");
    self attach(#"c_t8_zmb_dlc0_elephant_chain5", "tag_origin");
    self attach(#"c_t8_zmb_dlc0_elephant_chain6", "tag_origin");
}

// Namespace archetypeelephant/archetype_elephant
// Params 2, eflags: 0x4
// Checksum 0xacda0d44, Offset: 0x2808
// Size: 0x11e
function private function_c0924fac(elephant, rider) {
    if (!isdefined(elephant.closestenemy)) {
        return false;
    }
    if (gettime() < elephant.ai.var_8287d8d4) {
        return false;
    }
    if (isdefined(elephant.ai.var_e110e441)) {
        return false;
    }
    distsq = distancesquared(elephant.origin, elephant.closestenemy.origin);
    if (distsq < 200 * 200) {
        return false;
    }
    if (!util::within_fov(rider.origin + (0, 0, -40), rider.angles, elephant.closestenemy.origin, cos(70))) {
        return false;
    }
    return true;
}

// Namespace archetypeelephant/archetype_elephant
// Params 2, eflags: 0x4
// Checksum 0xe278f7fd, Offset: 0x2930
// Size: 0x102
function private function_fa2476c1(elephant, rider) {
    if (isdefined(elephant.closestenemy)) {
        predictedpos = elephant lastknownpos(elephant.closestenemy);
        if (isdefined(predictedpos)) {
            turnyaw = absangleclamp360(rider.angles[1] - vectortoangles(predictedpos - rider.origin)[1]);
            if (turnyaw >= 67.5 && turnyaw <= 180) {
                return "attack_right";
            }
            if (turnyaw >= 180 && turnyaw <= 292.5) {
                return "attack_left";
            }
        }
    }
    return "attack_forward";
}

// Namespace archetypeelephant/archetype_elephant
// Params 2, eflags: 0x4
// Checksum 0xd0008dfe, Offset: 0x2a40
// Size: 0x2a6
function private function_a5e59d1a(elephant, rider) {
    rider endon(#"death");
    rider endon(#"hash_45ddc9393cf1b3e2");
    elephant endon(#"death");
    while (true) {
        if (isdefined(rider.ai.inpain) && rider.ai.inpain || isdefined(rider.ai.ducking) && rider.ai.ducking) {
            waitframe(1);
            continue;
        }
        if (function_c0924fac(elephant, rider)) {
            rider.ai.attacking = 1;
            attackdirection = function_fa2476c1(elephant, rider);
            aligntag = rider.ai.var_821c3f03;
            if (attackdirection == "attack_right") {
                rider animation::play(rider.ai.var_335f9081, elephant, aligntag, 1.2, 0.2, 0.1, undefined, undefined, undefined, 0);
            } else if (attackdirection == "attack_left") {
                rider animation::play(rider.ai.var_c503ed12, elephant, aligntag, 1.2, 0.2, 0.1, undefined, undefined, undefined, 0);
            } else {
                rider animation::play(rider.ai.var_a534c1d2, elephant, aligntag, 1.2, 0.2, 0.1, undefined, undefined, undefined, 0);
            }
            rider.ai.attacking = 0;
            wait randomintrange(1, 2);
        }
        waitframe(1);
    }
}

// Namespace archetypeelephant/archetype_elephant
// Params 2, eflags: 0x0
// Checksum 0xfbfa8d10, Offset: 0x2cf0
// Size: 0x68
function function_903a794c(elephant, rider) {
    currenttime = gettime();
    if (isdefined(rider.ai.var_16b714be) && gettime() - rider.ai.var_16b714be <= 50) {
        return true;
    }
    return false;
}

// Namespace archetypeelephant/archetype_elephant
// Params 2, eflags: 0x4
// Checksum 0x92c7b6d5, Offset: 0x2d60
// Size: 0x19e
function private function_749dea72(elephant, rider) {
    rider endon(#"death");
    rider endon(#"hash_45ddc9393cf1b3e2");
    elephant endon(#"death");
    while (true) {
        if (function_903a794c(elephant, rider)) {
            rider.ai.inpain = 1;
            aligntag = rider.ai.var_821c3f03;
            rider.ai.var_b22374d9 = rider animmappingsearch(#"hash_2e52a646a71cee70");
            assert(isdefined(rider.ai.var_b22374d9));
            rider animation::play(rider.ai.var_b22374d9, elephant, aligntag, 1, 0.2, 0.1, undefined, undefined, undefined, 0);
            rider.ai.inpain = 0;
            wait randomintrange(3, 4);
        }
        waitframe(1);
    }
}

// Namespace archetypeelephant/archetype_elephant
// Params 2, eflags: 0x4
// Checksum 0xa4eaa64c, Offset: 0x2f08
// Size: 0x2fc
function private function_1a1cbd35(elephant, rider) {
    rider endon(#"death");
    rider endon(#"hash_45ddc9393cf1b3e2");
    elephant endon(#"death");
    aligntag = rider.ai.var_821c3f03;
    rider.ai.var_57a43388 = rider animmappingsearch(#"hash_6a0be85d14df502a");
    rider.ai.var_4608484a = rider animmappingsearch(#"hash_22d12a7d199608d0");
    rider.ai.var_5e01d5a5 = rider animmappingsearch(#"hash_323636e22326da5f");
    while (true) {
        if (!(isdefined(rider.ai.ducking) && rider.ai.ducking)) {
            waitframe(1);
            continue;
        }
        if (!(isdefined(rider.ai.var_58a85871) && rider.ai.var_58a85871)) {
            rider animation::play(rider.ai.var_57a43388, elephant, aligntag, 1, 0.2, 0.1, undefined, undefined, undefined, 0);
            rider.ai.var_58a85871 = 1;
        }
        rider animation::play(rider.ai.var_4608484a, elephant, aligntag, 1, 0.2, 0.1, undefined, undefined, undefined, 0);
        if (isdefined(rider.ai.var_bd7c5cbd) && rider.ai.var_bd7c5cbd) {
            rider animation::play(rider.ai.var_5e01d5a5, elephant, aligntag, 1, 0.2, 0.1, undefined, undefined, undefined, 0);
            rider.ai.var_58a85871 = 0;
            rider.ai.ducking = 0;
            rider.ai.var_bd7c5cbd = 0;
        }
        waitframe(1);
    }
}

// Namespace archetypeelephant/archetype_elephant
// Params 2, eflags: 0x4
// Checksum 0x9f3666ce, Offset: 0x3210
// Size: 0x3c0
function private function_fd5ac8f6(elephant, rider) {
    rider endon(#"death");
    rider endon(#"hash_45ddc9393cf1b3e2");
    elephant endon(#"death");
    alignstruct = struct::get("tag_align_boss_doors", "targetname");
    if (elephant.ai.phase == #"hash_266f56fb994e6639") {
        rider ghost();
        elephant waittill(#"hash_6537a2364ba9dcb3");
        rider show();
    }
    if (isdefined(rider.ai.entryanim)) {
        rider unlink();
        rider animation::play(rider.ai.entryanim, alignstruct.origin, alignstruct.angles, 1, 0.2, 0.1, undefined, undefined, undefined, 0);
        assert(isdefined(rider.ai.var_821c3f03));
        rider linkto(elephant, rider.ai.var_821c3f03, (0, 0, 0), (0, 0, 0));
    }
    rider thread function_a5e59d1a(elephant, rider);
    rider thread function_749dea72(elephant, rider);
    rider thread function_1a1cbd35(elephant, rider);
    while (true) {
        if (isdefined(rider.ai.ducking) && rider.ai.ducking) {
            waitframe(1);
            continue;
        }
        if (isdefined(rider.ai.attacking) && rider.ai.attacking) {
            waitframe(1);
            continue;
        }
        if (isdefined(rider.ai.inpain) && rider.ai.inpain) {
            waitframe(1);
            continue;
        }
        rider.ai.var_c87cadbf = rider animmappingsearch(#"hash_3cfb620b1f6d2192");
        assert(isdefined(rider.ai.var_c87cadbf));
        rider animation::play(rider.ai.var_c87cadbf, elephant, rider.ai.var_821c3f03, 1, 0.2, 0.1, undefined, undefined, undefined, 0);
    }
}

// Namespace archetypeelephant/archetype_elephant
// Params 3, eflags: 0x4
// Checksum 0x64db80d5, Offset: 0x35d8
// Size: 0x4f8
function private function_4ee8f79c(elephant, var_f1a4aac1, targetname) {
    if (!isdefined(elephant.ai.riders)) {
        elephant.ai.riders = [];
    }
    var_4da37c33 = self gettagorigin(var_f1a4aac1);
    var_ed8bdaab = self gettagangles(var_f1a4aac1);
    rider = spawnactor(#"hash_46a05f54d289c9d7", var_4da37c33, var_ed8bdaab, targetname, 1);
    assert(isdefined(rider));
    rider attach("p7_shr_weapon_spear_lrg", "tag_weapon_right");
    rider.var_39883e02 = 1;
    rider linkto(self, var_f1a4aac1, (0, 0, 0), (0, 0, 0));
    array::add(elephant.ai.riders, rider);
    rider.ai.spearweapon = getweapon("rider_spear_projectile");
    rider.ai.elephant = elephant;
    /#
        recordent(rider);
    #/
    rider.ai.var_c87cadbf = rider animmappingsearch(#"hash_3cfb620b1f6d2192");
    assert(isdefined(rider.ai.var_c87cadbf));
    rider.ai.var_a534c1d2 = rider animmappingsearch(#"hash_52c3d7bee8eabebc");
    assert(isdefined(rider.ai.var_a534c1d2));
    rider.ai.var_335f9081 = rider animmappingsearch(#"hash_4950e0c9a2675981");
    assert(isdefined(rider.ai.var_335f9081));
    rider.ai.var_c503ed12 = rider animmappingsearch(#"hash_37f92f1082115f74");
    assert(isdefined(rider.ai.var_c503ed12));
    n_health = 60000;
    for (i = 0; i < level.players.size - 1; i++) {
        n_health += 15000;
    }
    rider.maxhealth = n_health;
    rider.health = n_health;
    rider.goalradius = 24;
    rider.b_ignore_cleanup = 1;
    rider.ignore_nuke = 1;
    rider.lightning_chain_immune = 1;
    rider.var_2cd0795a = 1;
    rider disableaimassist();
    rider attach("c_t8_zmb_dlc0_zombie_destroyer_le_arm1", "j_shoulder_le");
    rider attach("c_t8_zmb_dlc0_zombie_destroyer_ri_arm1", "j_clavicle_ri");
    rider attach("c_t8_zmb_dlc0_zombie_destroyer_helmet1", "j_head");
    rider attach("c_t8_zmb_dlc0_zombie_destroyer_le_pauldron1", "tag_pauldron_le");
    rider attach("c_t8_zmb_dlc0_zombie_destroyer_ri_pauldron1", "tag_pauldron_ri");
    aiutility::addaioverridedamagecallback(rider, &function_9a99bdb4);
    return rider;
}

// Namespace archetypeelephant/archetype_elephant
// Params 0, eflags: 0x4
// Checksum 0x91f06b87, Offset: 0x3ad8
// Size: 0x3ec
function private function_ff94c51b() {
    self endon(#"death");
    while (!isdefined(self.ai.phase)) {
        waitframe(1);
    }
    rider = function_4ee8f79c(self, "tag_char_align_a", #"hash_6101964904e7d17b");
    rider.ai.var_9720236c = #"hash_20cbd41b17321edc";
    rider.ai.var_821c3f03 = "tag_char_align_a";
    rider.instakill_func = &function_1b6628;
    if (self.ai.phase == #"hash_266f53fb994e6120") {
        rider.ai.entryanim = #"hash_561cf85af113ff1e";
    } else {
        rider.ai.entryanim = #"hash_1447253275dbb643";
    }
    rider thread function_fd5ac8f6(self, rider);
    rider = function_4ee8f79c(self, "tag_char_align_b", #"hash_2672ad69ba7c107");
    rider.ai.var_9720236c = #"hash_20cbd71b173223f5";
    rider.ai.var_821c3f03 = "tag_char_align_b";
    rider.instakill_func = &function_1b6628;
    if (self.ai.phase == #"hash_266f53fb994e6120") {
        rider.ai.entryanim = #"hash_561cf75af113fd6b";
    } else {
        rider.ai.entryanim = #"hash_1447263275dbb7f6";
    }
    rider thread function_fd5ac8f6(self, rider);
    if (isdefined(level.var_4fc87c7d) && level.var_4fc87c7d) {
        rider = function_4ee8f79c(self, "tag_char_align_c", #"hash_6101964904e7d17b");
        rider.ai.var_9720236c = #"hash_20cbd41b17321edc";
        rider.ai.var_821c3f03 = "tag_char_align_c";
        rider.instakill_func = &function_1b6628;
        rider.ai.entryanim = #"hash_1447273275dbb9a9";
        rider thread function_fd5ac8f6(self, rider);
        rider = function_4ee8f79c(self, "tag_char_align_d", #"hash_2672ad69ba7c107");
        rider.ai.var_9720236c = #"hash_20cbd71b173223f5";
        rider.ai.var_821c3f03 = "tag_char_align_d";
        rider.instakill_func = &function_1b6628;
        rider.ai.entryanim = #"hash_1447283275dbbb5c";
        rider thread function_fd5ac8f6(self, rider);
    }
}

// Namespace archetypeelephant/archetype_elephant
// Params 0, eflags: 0x4
// Checksum 0x6e468c70, Offset: 0x3ed0
// Size: 0x9e
function private function_fe7ca6b() {
    self endon(#"death");
    while (true) {
        if (isdefined(self.favoriteenemy)) {
            dist = distance(self.origin, self.favoriteenemy.origin);
            /#
                record3dtext("<dev string:x3e>" + dist, self.origin, (0, 1, 0), "<dev string:x30>");
            #/
        }
        waitframe(1);
    }
}

// Namespace archetypeelephant/archetype_elephant
// Params 0, eflags: 0x4
// Checksum 0x4c5ac5, Offset: 0x3f78
// Size: 0x304
function private function_ee4da73e() {
    self disableaimassist();
    self pushplayer(1);
    self setavoidancemask("avoid none");
    self.ai.var_734ff6a9 = gettime() + 3000;
    self.ai.var_e6f97c02 = gettime() + randomintrange(3500, 4000);
    self.ai.var_4a339e42 = getweapon(#"elephant_eye_projectile");
    self clientfield::set("towers_boss_eye_fx_cf", 1);
    self.ai.var_8287d8d4 = gettime() + randomintrange(3000, 5000);
    self.b_ignore_cleanup = 1;
    self.ignore_nuke = 1;
    self.lightning_chain_immune = 1;
    self.maxhealth = 180000;
    for (i = 0; i < level.players.size - 1; i++) {
        self.maxhealth += 20000;
    }
    self.health = self.maxhealth;
    self.ai.var_e0690dac = self.health * 0.8;
    self.targetname = "zombie_towers_boss";
    self.badplaceawareness = 0;
    self.clamptonavmesh = 0;
    namespace_9088c704::initweakpoints(self, #"c_t8_zmb_dlc0_towers_boss_weakpoint_def");
    aiutility::addaioverridedamagecallback(self, &function_8f5e548e);
    function_1cbd3782(self, #"hash_8e173ae91589439");
    self thread function_4128b85e(self);
    self thread function_3facabbe();
    self setblackboardattribute("_locomotion_speed", "locomotion_speed_run");
    self thread function_ff94c51b();
    self clientfield::set("sndTowersBossArmor", 1);
    /#
        self thread function_fe7ca6b();
        self thread function_25d3701d();
    #/
}

// Namespace archetypeelephant/archetype_elephant
// Params 3, eflags: 0x4
// Checksum 0x42bcd579, Offset: 0x4288
// Size: 0x1a0
function private function_606db17e(enemy, elephant, var_11dd9f1c = 1) {
    if (isdefined(enemy.knockdown) && enemy.knockdown) {
        return false;
    }
    if (gibserverutils::isgibbed(enemy, 384)) {
        return false;
    }
    if (distancesquared(enemy.origin, elephant.origin) > 250 * 250) {
        return false;
    }
    facingvec = anglestoforward(elephant.angles);
    enemyvec = enemy.origin - elephant.origin;
    var_c960aec6 = (enemyvec[0], enemyvec[1], 0);
    var_ca23d7da = (facingvec[0], facingvec[1], 0);
    var_c960aec6 = vectornormalize(var_c960aec6);
    var_ca23d7da = vectornormalize(var_ca23d7da);
    if (var_11dd9f1c) {
        enemydot = vectordot(var_ca23d7da, var_c960aec6);
        if (enemydot < 0) {
            return false;
        }
    }
    return true;
}

// Namespace archetypeelephant/archetype_elephant
// Params 1, eflags: 0x4
// Checksum 0x795b8ac3, Offset: 0x4430
// Size: 0xf4
function private elephantknockdownservice(entity) {
    if (!isdefined(self.ai.var_e110e441)) {
        return 0;
    }
    zombiesarray = getaiarchetypearray("zombie");
    zombiesarray = arraycombine(zombiesarray, getaiarchetypearray("catalyst"), 0, 0);
    zombiesarray = arraycombine(zombiesarray, getaiarchetypearray("tiger"), 0, 0);
    zombiesarray = array::filter(zombiesarray, 0, &function_606db17e, entity);
    [[ self.ai.var_969c4d3a ]](zombiesarray, entity);
}

// Namespace archetypeelephant/archetype_elephant
// Params 0, eflags: 0x4
// Checksum 0xd3b8012e, Offset: 0x4530
// Size: 0xd8
function private function_25d3701d() {
    self waittill(#"death");
    if (isdefined(self.ai.riders)) {
        foreach (rider in self.ai.riders) {
            if (isdefined(rider)) {
                aiutility::removeaioverridedamagecallback(rider, &function_9a99bdb4);
                rider delete();
            }
        }
    }
}

// Namespace archetypeelephant/archetype_elephant
// Params 1, eflags: 0x0
// Checksum 0x42934953, Offset: 0x4610
// Size: 0x41c
function function_fc094e(elephant) {
    var_216599c5 = namespace_9088c704::function_fc6ac723(elephant, "tag_carriage_ws_le");
    if (var_216599c5.health <= var_216599c5.maxhealth * 0.1) {
        if (elephant isattached(#"c_t8_zmb_dlc0_elephant_chain6", "tag_origin")) {
            elephant detach(#"c_t8_zmb_dlc0_elephant_chain6", "tag_origin");
            elephant attach(#"hash_4f282585ef50e907", "tag_origin");
            elephant playsound(#"hash_9d86c1e08ca3809");
        }
        return;
    }
    if (var_216599c5.health <= var_216599c5.maxhealth * 0.25) {
        if (elephant isattached(#"c_t8_zmb_dlc0_elephant_chain4", "tag_origin")) {
            elephant detach(#"c_t8_zmb_dlc0_elephant_chain4", "tag_origin");
            elephant detach(#"c_t8_zmb_dlc0_elephant_chain5", "tag_origin");
            elephant attach(#"hash_4f282785ef50ec6d", "tag_origin");
            elephant playsound(#"hash_55bac56f7a46775c");
        }
        return;
    }
    if (var_216599c5.health <= var_216599c5.maxhealth * 0.5) {
        if (elephant isattached(#"c_t8_zmb_dlc0_elephant_chain3", "tag_origin")) {
            elephant detach(#"c_t8_zmb_dlc0_elephant_chain3", "tag_origin");
            elephant attach(#"hash_4f282085ef50e088", "tag_origin");
            elephant playsound(#"hash_55bac56f7a46775c");
        }
        return;
    }
    if (var_216599c5.health <= var_216599c5.maxhealth * 0.75) {
        if (elephant isattached(#"c_t8_zmb_dlc0_elephant_chain2", "tag_origin")) {
            elephant detach(#"c_t8_zmb_dlc0_elephant_chain2", "tag_origin");
            elephant attach(#"hash_4f282185ef50e23b", "tag_origin");
            elephant playsound(#"hash_55bac56f7a46775c");
        }
        return;
    }
    if (var_216599c5.health <= var_216599c5.maxhealth * 0.95) {
        if (elephant isattached(#"c_t8_zmb_dlc0_elephant_chain1", "tag_origin")) {
            elephant detach(#"c_t8_zmb_dlc0_elephant_chain1", "tag_origin");
            elephant attach(#"hash_4f282285ef50e3ee", "tag_origin");
            elephant playsound(#"hash_55bac56f7a46775c");
        }
    }
}

// Namespace archetypeelephant/archetype_elephant
// Params 3, eflags: 0x0
// Checksum 0xea1fb7a5, Offset: 0x4a38
// Size: 0x194
function function_4bac1576(elephant, damage, attacker) {
    assert(isdefined(elephant));
    self.var_dfc644e4 = 1;
    var_216599c5 = namespace_9088c704::function_fc6ac723(elephant, "tag_carriage_ws_le");
    if (isdefined(var_216599c5) && namespace_9088c704::function_4abac7be(var_216599c5) === 1) {
        attacker playhitmarker(undefined, 1, "flakjacket", 0);
        level notify(#"hash_3aa3137f1bf70773");
        namespace_9088c704::damageweakpoint(var_216599c5, damage);
        /#
            iprintlnbold("<dev string:x3f>" + var_216599c5.health);
        #/
        if (namespace_9088c704::function_4abac7be(var_216599c5) === 3) {
            /#
                iprintlnbold("<dev string:x53>");
            #/
        }
        function_fc094e(elephant);
        return;
    }
    attacker playhitmarker(undefined, 1, undefined, 0);
}

// Namespace archetypeelephant/archetype_elephant
// Params 1, eflags: 0x4
// Checksum 0x1ddb407f, Offset: 0x4bd8
// Size: 0x72
function private function_a395a1dd(damage) {
    n_scalar = 1.5;
    for (i = 0; i < level.players.size; i++) {
        n_scalar -= 0.07;
    }
    return int(damage * n_scalar);
}

// Namespace archetypeelephant/archetype_elephant
// Params 1, eflags: 0x4
// Checksum 0x9fa82b57, Offset: 0x4c58
// Size: 0x66
function private function_76f5ceec(elephant) {
    var_216599c5 = namespace_9088c704::function_fc6ac723(elephant, "tag_carriage_ws_le");
    if (isdefined(var_216599c5) && namespace_9088c704::function_4abac7be(var_216599c5) === 3) {
        return true;
    }
    return false;
}

// Namespace archetypeelephant/archetype_elephant
// Params 12, eflags: 0x0
// Checksum 0x1d5407d5, Offset: 0x4cc8
// Size: 0x16c
function function_9a99bdb4(inflictor, attacker, damage, idflags, meansofdeath, weapon, point, dir, hitloc, offsettime, boneindex, modelindex) {
    if (attacker === self) {
        return 0;
    }
    if (isdefined(attacker) && !isplayer(attacker)) {
        return 0;
    }
    if (self.health - damage <= 0) {
        self.health += int(damage + 1);
        self.ai.var_16b714be = gettime();
    }
    assert(isdefined(self.ai.elephant));
    damage = function_a395a1dd(damage);
    function_4bac1576(self.ai.elephant, damage, attacker);
    level notify(#"basket_hit");
    return damage;
}

// Namespace archetypeelephant/archetype_elephant
// Params 12, eflags: 0x0
// Checksum 0x3c06f452, Offset: 0x4e40
// Size: 0xaa
function function_8f5e548e(inflictor, attacker, damage, idflags, meansofdeath, weapon, point, dir, hitloc, offsettime, boneindex, modelindex) {
    if (isdefined(attacker) && !isplayer(attacker)) {
        return 0;
    }
    damage = function_a395a1dd(damage);
    return damage;
}

// Namespace archetypeelephant/archetype_elephant
// Params 0, eflags: 0x4
// Checksum 0xdc5da3b7, Offset: 0x4ef8
// Size: 0x4a
function private function_29de00f7() {
    blackboard::createblackboardforentity(self);
    ai::createinterfaceforentity(self);
    self.___archetypeonanimscriptedcallback = &function_f8c2ac71;
}

// Namespace archetypeelephant/archetype_elephant
// Params 1, eflags: 0x4
// Checksum 0x15ad8bf3, Offset: 0x4f50
// Size: 0x2c
function private function_f8c2ac71(entity) {
    entity.__blackboard = undefined;
    entity function_29de00f7();
}

// Namespace archetypeelephant/archetype_elephant
// Params 1, eflags: 0x4
// Checksum 0x2f7d3afd, Offset: 0x4f88
// Size: 0x110
function private function_ce86177(elephant) {
    if (elephant.ai.var_7a7bec84 == #"hash_8e173ae91589439") {
        return false;
    }
    var_5ee69524 = 0;
    var_216599c5 = namespace_9088c704::function_fc6ac723(elephant, "tag_body_ws");
    if (isdefined(var_216599c5) && namespace_9088c704::function_4abac7be(var_216599c5) === 3) {
        var_5ee69524 = 1;
    }
    headdestroyed = 0;
    var_216599c5 = namespace_9088c704::function_fc6ac723(elephant, "tag_head_ws");
    if (isdefined(var_216599c5) && namespace_9088c704::function_4abac7be(var_216599c5) === 3) {
        headdestroyed = 1;
    }
    if (var_5ee69524 || headdestroyed) {
        return true;
    }
    return false;
}

// Namespace archetypeelephant/archetype_elephant
// Params 1, eflags: 0x4
// Checksum 0xb3bd1df9, Offset: 0x50a0
// Size: 0x56
function private function_65c51ce0(elephant) {
    if (elephant.ai.var_7a7bec84 != #"hash_8e173ae91589439") {
        return true;
    }
    if (function_76f5ceec(elephant)) {
        return true;
    }
    return false;
}

// Namespace archetypeelephant/archetype_elephant
// Params 2, eflags: 0x4
// Checksum 0x6c85b7b0, Offset: 0x5100
// Size: 0xfc
function private function_95979d91(rider, elephant) {
    rider endon(#"death");
    rider notify(#"hash_45ddc9393cf1b3e2");
    rider animation::stop();
    rider animation::play(rider.ai.var_9720236c, elephant, rider.ai.var_821c3f03, 1, 0.2, 0.1);
    aiutility::removeaioverridedamagecallback(rider, &function_9a99bdb4);
    rider unlink();
    rider delete();
}

// Namespace archetypeelephant/archetype_elephant
// Params 0, eflags: 0x0
// Checksum 0xfc8c70d9, Offset: 0x5208
// Size: 0xe4
function function_4e9a9ec2() {
    self clientfield::set("sndTowersBossArmor", 0);
    self thread function_ac9efbfd(self, 0.1);
    self.var_7abadf06 show();
    self.var_7abadf06 useanimtree("generic");
    self.var_7abadf06 animation::play("p8_fxanim_zm_towers_boss_armor_explode_anim", self.origin, self.angles, 1, 0.2, 0.1, undefined, undefined, undefined, 0);
    self.var_7abadf06 delete();
}

// Namespace archetypeelephant/archetype_elephant
// Params 0, eflags: 0x0
// Checksum 0x80e7932b, Offset: 0x52f8
// Size: 0x64
function function_c5a208ef() {
    self.var_7abadf06 = spawn("script_model", self.origin);
    self.var_7abadf06 setmodel("p8_fxanim_zm_towers_boss_armor_explode_mod");
    self.var_7abadf06 hide();
}

// Namespace archetypeelephant/archetype_elephant
// Params 1, eflags: 0x4
// Checksum 0xabb723e2, Offset: 0x5368
// Size: 0x2a4
function private function_ee84be7c(elephant) {
    if (!isdefined(elephant.ai.riders)) {
        return;
    }
    foreach (rider in elephant.ai.riders) {
        rider thread function_95979d91(rider, elephant);
    }
    elephant function_c5a208ef();
    elephant animation::play("ch_vign_tplt_inbtl_hllpht_evlve_2_stg_2_00_hllpht", undefined, undefined, 1, 0.2, 0.1, undefined, undefined, undefined, 0);
    level notify(#"hash_634700dd42db02d8");
    elephant setblackboardattribute("_locomotion_speed", "locomotion_speed_run");
    var_216599c5 = namespace_9088c704::function_fc6ac723(elephant, "tag_carriage_ws_le");
    namespace_9088c704::function_3ad01c52(var_216599c5, 2);
    var_216599c5 = namespace_9088c704::function_fc6ac723(elephant, "tag_carriage_ws_ri");
    namespace_9088c704::function_3ad01c52(var_216599c5, 2);
    var_216599c5 = namespace_9088c704::function_fc6ac723(elephant, "tag_chest_armor_ws");
    namespace_9088c704::function_3ad01c52(var_216599c5, 2);
    var_216599c5 = namespace_9088c704::function_fc6ac723(elephant, "tag_body_ws");
    namespace_9088c704::function_3ad01c52(var_216599c5, 1);
    var_216599c5 = namespace_9088c704::function_fc6ac723(elephant, "tag_head_ws");
    namespace_9088c704::function_3ad01c52(var_216599c5, 1);
    function_1cbd3782(elephant, #"hash_8e170ae91588f20");
}

// Namespace archetypeelephant/archetype_elephant
// Params 1, eflags: 0x4
// Checksum 0xcc5d2848, Offset: 0x5618
// Size: 0xec
function private function_4128b85e(elephant) {
    elephant endon(#"death");
    while (true) {
        currentstate = elephant.ai.var_7a7bec84;
        switch (currentstate) {
        case #"hash_8e173ae91589439":
            if (function_65c51ce0(elephant)) {
                elephant function_ee84be7c(elephant);
            }
            break;
        case #"hash_8e170ae91588f20":
            if (function_ce86177(elephant)) {
                elephant thread elephantstartdeath();
            }
            break;
        }
        wait 1;
    }
}

// Namespace archetypeelephant/archetype_elephant
// Params 2, eflags: 0x4
// Checksum 0xa28c2e14, Offset: 0x5710
// Size: 0xba
function private function_1cbd3782(elephant, stage) {
    assert(stage == #"hash_8e173ae91589439" || stage == #"hash_8e170ae91588f20");
    elephant.ai.var_7a7bec84 = stage;
    switch (stage) {
    case #"hash_8e173ae91589439":
        break;
    case #"hash_8e170ae91588f20":
        break;
    default:
        break;
    }
}

// Namespace archetypeelephant/archetype_elephant
// Params 1, eflags: 0x0
// Checksum 0xa7723e87, Offset: 0x57d8
// Size: 0x22c
function function_1a2eb773(entity) {
    stage = entity.ai.var_7a7bec84;
    if (stage != #"hash_8e170ae91588f20") {
        return false;
    }
    if (isdefined(self.var_588417db) && self.var_588417db) {
        return false;
    }
    if (!isdefined(entity.favoriteenemy)) {
        return false;
    }
    if (isdefined(entity.ai.var_7e349f18) && gettime() < entity.ai.var_7e349f18) {
        return false;
    }
    if (distancesquared(entity.favoriteenemy.origin, entity.origin) < 600 * 600) {
        return false;
    }
    if (randomint(100) < 50) {
        return false;
    }
    fov = cos(30);
    if (!util::within_fov(entity.origin, entity.angles, entity.favoriteenemy.origin, fov)) {
        return false;
    }
    var_30e3aac4 = blackboard::getblackboardevents("towersboss_head_proj");
    if (isdefined(var_30e3aac4) && var_30e3aac4.size) {
        foreach (var_9f03c81c in var_30e3aac4) {
            if (var_9f03c81c.enemy === entity.favoriteenemy) {
                return false;
            }
        }
    }
    return true;
}

// Namespace archetypeelephant/archetype_elephant
// Params 2, eflags: 0x0
// Checksum 0x4c18e710, Offset: 0x5a10
// Size: 0x2ec
function function_e14550fe(entity, splitorigin) {
    self endon(#"death");
    forwardvec = vectornormalize(anglestoforward(entity.angles));
    forwarddist = 200;
    if (isdefined(splitorigin)) {
        launchpoint = splitorigin;
    } else {
        launchpoint = entity.origin + forwarddist * forwardvec;
    }
    closestpointonnavmesh = getclosestpointonnavmesh(launchpoint, 500, 200);
    if (isdefined(closestpointonnavmesh)) {
        trace = groundtrace(closestpointonnavmesh + (0, 0, 200), closestpointonnavmesh + (0, 0, -200), 0, undefined);
        if (isdefined(trace[#"position"])) {
            newpos = trace[#"position"];
        }
        /#
            recordsphere(newpos, 15, (1, 0.5, 0), "<dev string:x37>");
        #/
        dustball = spawnvehicle(#"hash_6be593a62b8b87a5", newpos, entity.angles, "dynamic_spawn_ai");
        if (isdefined(dustball)) {
            dustball.var_92eddb80 = 1;
            entity.ai.var_7e349f18 = gettime() + randomintrange(5000, 8000);
            if (isdefined(self.var_19722957) && self.var_19722957) {
                entity.ai.var_7e349f18 = gettime() + 5000;
            }
        }
    } else {
        /#
            recordsphere(launchpoint, 15, (0, 0, 0), "<dev string:x37>");
        #/
    }
    wait 2.5;
    if (self.ai.phase == #"hash_266f56fb994e6639" && isdefined(dustball) && isalive(dustball) && !isdefined(splitorigin)) {
        function_e14550fe(self, dustball.origin);
    }
}

// Namespace archetypeelephant/archetype_elephant
// Params 1, eflags: 0x0
// Checksum 0x56c34450, Offset: 0x5d08
// Size: 0x1f4
function function_2406af35(entity) {
    stage = entity.ai.var_7a7bec84;
    if (stage != #"hash_8e170ae91588f20") {
        return false;
    }
    if (isdefined(self.var_19722957) && self.var_19722957) {
        return false;
    }
    if (!isdefined(entity.favoriteenemy)) {
        return false;
    }
    if (gettime() < entity.ai.var_e6f97c02) {
        return false;
    }
    if (distancesquared(entity.favoriteenemy.origin, entity.origin) < 600 * 600) {
        return false;
    }
    fov = cos(20);
    if (!util::within_fov(entity.origin, entity.angles, entity.favoriteenemy.origin, fov)) {
        return false;
    }
    var_30e3aac4 = blackboard::getblackboardevents("towersboss_head_proj");
    if (isdefined(var_30e3aac4) && var_30e3aac4.size) {
        foreach (var_9f03c81c in var_30e3aac4) {
            if (var_9f03c81c.enemy === entity.favoriteenemy) {
                return false;
            }
        }
    }
    return true;
}

// Namespace archetypeelephant/archetype_elephant
// Params 1, eflags: 0x0
// Checksum 0x196702cc, Offset: 0x5f08
// Size: 0xac
function function_aaba1c90(entity) {
    entity.ai.var_e6f97c02 = gettime() + randomintrange(3500, 4000);
    var_548f83c2 = spawnstruct();
    var_548f83c2.enemy = entity.favoriteenemy;
    blackboard::addblackboardevent("towersboss_head_proj", var_548f83c2, randomintrange(3500, 4000));
}

// Namespace archetypeelephant/archetype_elephant
// Params 1, eflags: 0x0
// Checksum 0x7f459081, Offset: 0x5fc0
// Size: 0x86
function function_a5b69ca6(entity) {
    if (!elephantshouldmelee(entity)) {
        return false;
    }
    if (!util::within_fov(entity.origin, entity.angles, entity.favoriteenemy.origin, cos(45))) {
        return false;
    }
    return true;
}

// Namespace archetypeelephant/archetype_elephant
// Params 1, eflags: 0x4
// Checksum 0xad729ed1, Offset: 0x6050
// Size: 0x126
function private elephantshouldmelee(entity) {
    if (!isdefined(entity.favoriteenemy)) {
        return false;
    }
    if (entity asmistransitionrunning() || entity asmistransdecrunning()) {
        return false;
    }
    disttoenemysq = distancesquared(entity.favoriteenemy.origin, entity.origin);
    yawtoenemy = angleclamp180(entity.angles[1] - vectortoangles(entity.favoriteenemy.origin - entity.origin)[1]);
    if (disttoenemysq <= 440 * 440 && abs(yawtoenemy) < 80) {
        return true;
    }
    return false;
}

// Namespace archetypeelephant/archetype_elephant
// Params 1, eflags: 0x4
// Checksum 0xc154055f, Offset: 0x6180
// Size: 0x10
function private function_20d823e4(entity) {
    return true;
}

// Namespace archetypeelephant/archetype_elephant
// Params 1, eflags: 0x4
// Checksum 0x89a0ffb1, Offset: 0x6198
// Size: 0x11e
function private function_f7915043(entity) {
    if (isdefined(entity.ai.var_a1916335) && entity.ai.var_a1916335) {
        return false;
    }
    if (!isdefined(entity.favoriteenemy)) {
        return false;
    }
    if (entity.ai.var_734ff6a9 > gettime()) {
        return false;
    }
    if (isdefined(entity.ai.var_e110e441)) {
        return false;
    }
    if (!function_20d823e4(entity)) {
        return false;
    }
    disttoenemysq = distancesquared(entity.favoriteenemy.origin, entity.origin);
    if (disttoenemysq <= 600 * 600) {
        return false;
    }
    if (elephantshouldmelee(entity)) {
        return false;
    }
    return true;
}

// Namespace archetypeelephant/archetype_elephant
// Params 1, eflags: 0x4
// Checksum 0xd3cfc580, Offset: 0x6390
// Size: 0x9c
function private function_d8d1487c(entity) {
    if (function_f7915043(entity)) {
        targetpos = getclosestpointonnavmesh(entity.favoriteenemy.origin, 400, entity getpathfindingradius() * 1.2);
        if (isdefined(targetpos)) {
            entity setgoal(targetpos);
            return true;
        }
    }
    return false;
}

// Namespace archetypeelephant/archetype_elephant
// Params 1, eflags: 0x4
// Checksum 0xce25ecba, Offset: 0x6438
// Size: 0x2d6
function private function_4b41033(entity) {
    entity.ai.var_e110e441 = new class_e110e441();
    entity.ai.var_e110e441.var_96b470fd = entity.goalpos;
    entity.ai.var_e110e441.var_1ed9db82 = distancesquared(entity.origin, entity.goalpos);
    entity.ai.var_e110e441.startpos = entity.origin;
    stage = entity.ai.var_7a7bec84;
    if (isdefined(entity.ai.riders)) {
        foreach (rider in entity.ai.riders) {
            if (isdefined(rider)) {
                rider.ai.ducking = 1;
            }
        }
    }
    switch (stage) {
    case #"hash_8e173ae91589439":
        entity.ai.var_e110e441.var_4a9e662e = gettime() + randomintrange(2500, 3000);
        entity.ai.var_e110e441.var_64caa560 = 250 * 250;
        entity.ai.var_e110e441.var_305ddd9e = 400 * 400;
        break;
    case #"hash_8e170ae91588f20":
        entity.ai.var_e110e441.var_4a9e662e = gettime() + randomintrange(3500, 4000);
        entity.ai.var_e110e441.var_64caa560 = 250 * 250;
        entity.ai.var_e110e441.var_305ddd9e = 400 * 400;
        break;
    default:
        break;
    }
    return true;
}

// Namespace archetypeelephant/archetype_elephant
// Params 1, eflags: 0x4
// Checksum 0xde87be26, Offset: 0x6718
// Size: 0x3f0
function private function_e4ca9016(entity) {
    if (isdefined(entity.favoriteenemy) && isalive(entity.favoriteenemy)) {
        assert(isdefined(entity.ai.var_e110e441));
        assert(isdefined(entity.ai.var_e110e441.var_96b470fd));
        assert(isdefined(entity.ai.var_e110e441.var_4a9e662e));
        /#
            recordsphere(entity.ai.var_e110e441.var_96b470fd, 8, (1, 0, 0), "<dev string:x37>");
        #/
        if (entity asmistransitionrunning() || entity asmistransdecrunning()) {
            return true;
        }
        if (gettime() <= entity.ai.var_e110e441.var_4a9e662e) {
            var_8d818316 = distancesquared(entity.ai.var_e110e441.var_96b470fd, entity.favoriteenemy.origin);
            var_a8520039 = distancesquared(entity.ai.var_e110e441.startpos, entity.favoriteenemy.origin) > entity.ai.var_e110e441.var_1ed9db82;
            threshold = entity.ai.var_e110e441.var_64caa560;
            if (var_a8520039) {
                threshold = entity.ai.var_e110e441.var_305ddd9e;
            }
            if (var_8d818316 <= threshold) {
                targetpos = getclosestpointonnavmesh(entity.favoriteenemy.origin, 400, entity getpathfindingradius() * 1.2);
                if (isdefined(targetpos)) {
                    /#
                        recordsphere(targetpos, 8, (0, 1, 1), "<dev string:x37>");
                    #/
                    dirtoenemy = vectornormalize(targetpos - self.origin);
                    targetpos += vectorscale(dirtoenemy * -1, 170);
                    targetpos = getclosestpointonnavmesh(targetpos, 400, entity getpathfindingradius() * 1.2);
                    if (isdefined(targetpos)) {
                        entity setgoal(targetpos);
                        /#
                            recordsphere(targetpos, 8, (0, 0, 1), "<dev string:x37>");
                        #/
                        /#
                            recordline(entity.ai.var_e110e441.var_96b470fd, targetpos, (1, 0, 0), "<dev string:x37>");
                        #/
                    }
                }
            }
        }
    }
    return true;
}

// Namespace archetypeelephant/archetype_elephant
// Params 1, eflags: 0x4
// Checksum 0x882404a8, Offset: 0x6b10
// Size: 0x1ae
function private function_db745d9(entity) {
    entity aiutility::cleararrivalpos(entity);
    entity.ai.var_e110e441 = undefined;
    stage = entity.ai.var_7a7bec84;
    if (isdefined(entity.ai.riders)) {
        foreach (rider in entity.ai.riders) {
            if (isdefined(rider)) {
                rider.ai.var_bd7c5cbd = 1;
            }
        }
    }
    switch (stage) {
    case #"hash_8e173ae91589439":
        entity.ai.var_734ff6a9 = gettime() + randomintrange(8000, 10000);
        break;
    case #"hash_8e170ae91588f20":
        entity.ai.var_734ff6a9 = gettime() + randomintrange(6500, 7500);
        break;
    default:
        break;
    }
    return true;
}

// Namespace archetypeelephant/archetype_elephant
// Params 3, eflags: 0x0
// Checksum 0xe02ec692, Offset: 0x6cc8
// Size: 0x178
function is_player_valid(player, checkignoremeflag, ignore_laststand_players) {
    if (!isdefined(player)) {
        return 0;
    }
    if (!isalive(player)) {
        return 0;
    }
    if (!isplayer(player)) {
        return 0;
    }
    if (isdefined(player.is_zombie) && player.is_zombie == 1) {
        return 0;
    }
    if (player.sessionstate == "spectator") {
        return 0;
    }
    if (player.sessionstate == "intermission") {
        return 0;
    }
    if (isdefined(player.intermission) && player.intermission) {
        return 0;
    }
    if (!(isdefined(ignore_laststand_players) && ignore_laststand_players)) {
        if (player laststand::player_is_in_laststand()) {
            return 0;
        }
    }
    if (player isnotarget()) {
        return 0;
    }
    if (isdefined(checkignoremeflag) && checkignoremeflag && player.ignoreme) {
        return 0;
    }
    if (isdefined(level.is_player_valid_override)) {
        return [[ level.is_player_valid_override ]](player);
    }
    return 1;
}

// Namespace archetypeelephant/archetype_elephant
// Params 1, eflags: 0x4
// Checksum 0x6bbae63a, Offset: 0x6e48
// Size: 0x166
function private function_d6eddee1(entity) {
    if (isdefined(entity.ai.var_e110e441)) {
        return false;
    }
    targets = getplayers();
    for (i = 0; i < targets.size; i++) {
        target = targets[i];
        if (!is_player_valid(target, 1, 1) || !function_20d823e4(entity)) {
            arrayremovevalue(targets, target);
            break;
        }
    }
    if (targets.size == 0) {
        return false;
    }
    sortedtargets = arraysort(targets, entity.origin, 0);
    entity.favoriteenemy = sortedtargets[0];
    sortedtargets = arraysortclosest(targets, entity.origin);
    entity.closestenemy = sortedtargets[0];
    return true;
}

// Namespace archetypeelephant/archetype_elephant
// Params 1, eflags: 0x4
// Checksum 0x8e11a29d, Offset: 0x6fb8
// Size: 0xaa
function private function_4dce5325(entity) {
    if (isdefined(entity.ignoreall) && entity.ignoreall) {
        return 0;
    }
    stage = self.ai.var_7a7bec84;
    switch (stage) {
    case #"hash_8e170ae91588f20":
    case #"hash_8e173ae91589439":
        function_d6eddee1(entity);
        break;
    default:
        break;
    }
}

// Namespace archetypeelephant/archetype_elephant
// Params 5, eflags: 0x4
// Checksum 0x6612c3c9, Offset: 0x7070
// Size: 0xa4
function private function_8fb88df5(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
    entity animmode("zonly_physics", 1);
    entity pathmode("dont move");
    entity clearpath();
    entity setgoal(entity.origin);
}

// Namespace archetypeelephant/archetype_elephant
// Params 5, eflags: 0x4
// Checksum 0xb0c1a5a9, Offset: 0x7120
// Size: 0x2c
function private function_afa59ad4(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
    
}

// Namespace archetypeelephant/archetype_elephant
// Params 5, eflags: 0x4
// Checksum 0xc4d5aa8d, Offset: 0x7158
// Size: 0x6c
function private function_6f52fb04(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
    entity pathmode("move allowed");
    entity setgoal(entity.origin);
}

// Namespace archetypeelephant/archetype_elephant
// Params 3, eflags: 0x4
// Checksum 0x8232e498, Offset: 0x71d0
// Size: 0x20
function private function_1b6628(player, mod, shitloc) {
    return true;
}

/#

    // Namespace archetypeelephant/archetype_elephant
    // Params 0, eflags: 0x0
    // Checksum 0x28f51996, Offset: 0x71f8
    // Size: 0x168
    function function_6eecf85a() {
        elephants = getaiarchetypearray("<dev string:x67>");
        foreach (elephant in elephants) {
            if (isdefined(elephant.ai.riders)) {
                foreach (rider in elephant.ai.riders) {
                    if (isdefined(rider)) {
                        aiutility::removeaioverridedamagecallback(rider, &function_9a99bdb4);
                        rider delete();
                    }
                }
            }
            elephant thread elephantstartdeath();
        }
    }

    // Namespace archetypeelephant/archetype_elephant
    // Params 1, eflags: 0x0
    // Checksum 0x776a1fd8, Offset: 0x7368
    // Size: 0x1fc
    function spawn_elephant(phase) {
        player = level.players[0];
        direction = player getplayerangles();
        direction_vec = anglestoforward(direction);
        eye = player geteye();
        direction_vec = (direction_vec[0] * 8000, direction_vec[1] * 8000, direction_vec[2] * 8000);
        trace = bullettrace(eye, eye + direction_vec, 0, undefined);
        elephant = undefined;
        var_af476916 = getspawnerarray("<dev string:x70>", "<dev string:x8b>");
        if (var_af476916.size == 0) {
            iprintln("<dev string:x9d>");
            return;
        }
        elephant_spawner = array::random(var_af476916);
        elephant = zombie_utility::spawn_zombie(elephant_spawner, undefined, elephant_spawner);
        elephant.ai.phase = phase;
        if (isdefined(elephant)) {
            wait 0.5;
            elephant forceteleport(trace[#"position"], player.angles + (0, 180, 0));
        }
    }

    // Namespace archetypeelephant/archetype_elephant
    // Params 0, eflags: 0x0
    // Checksum 0xac31797b, Offset: 0x7570
    // Size: 0xd36
    function setup_devgui() {
        adddebugcommand("<dev string:xb8>");
        adddebugcommand("<dev string:x124>");
        adddebugcommand("<dev string:x18f>");
        adddebugcommand("<dev string:x1e3>");
        adddebugcommand("<dev string:x237>");
        adddebugcommand("<dev string:x28c>");
        adddebugcommand("<dev string:x2e3>");
        adddebugcommand("<dev string:x32a>");
        adddebugcommand("<dev string:x381>");
        adddebugcommand("<dev string:x3e2>");
        adddebugcommand("<dev string:x443>");
        adddebugcommand("<dev string:x4a2>");
        adddebugcommand("<dev string:x501>");
        adddebugcommand("<dev string:x560>");
        adddebugcommand("<dev string:x5c3>");
        adddebugcommand("<dev string:x61e>");
        adddebugcommand("<dev string:x681>");
        adddebugcommand("<dev string:x6e8>");
        adddebugcommand("<dev string:x758>");
        while (true) {
            setdvar(#"hash_7a7fc216709f1aa4", "<dev string:x3e>");
            wait 0.2;
            cmd = getdvarstring(#"hash_7a7fc216709f1aa4", "<dev string:x3e>");
            if (cmd == "<dev string:x3e>") {
                continue;
            }
            switch (cmd) {
            case #"spawn_phase1":
                level thread spawn_elephant(#"hash_266f53fb994e6120");
                break;
            case #"spawn_phase2":
                level.var_4fc87c7d = 1;
                level thread spawn_elephant(#"hash_266f56fb994e6639");
                break;
            case #"kill":
                function_6eecf85a();
                break;
            case #"stage_2":
                elephants = getaiarchetypearray("<dev string:x67>");
                foreach (elephant in elephants) {
                    stage = elephant.ai.var_7a7bec84;
                    if (stage == #"hash_8e173ae91589439") {
                        elephant function_ee84be7c(elephant);
                    }
                }
                break;
            case #"charge_enable":
                elephants = getaiarchetypearray("<dev string:x67>");
                foreach (elephant in elephants) {
                    elephant.ai.var_a1916335 = 0;
                }
                break;
            case #"charge_disable":
                elephants = getaiarchetypearray("<dev string:x67>");
                foreach (elephant in elephants) {
                    elephant.ai.var_a1916335 = 1;
                }
                break;
            case #"hide_heart":
                elephants = getaiarchetypearray("<dev string:x67>");
                foreach (elephant in elephants) {
                    elephant hidepart("<dev string:x7cc>");
                }
                break;
            case #"show_heart":
                elephants = getaiarchetypearray("<dev string:x67>");
                foreach (elephant in elephants) {
                    elephant showpart("<dev string:x7cc>");
                }
                break;
            case #"hide_head":
                elephants = getaiarchetypearray("<dev string:x67>");
                foreach (elephant in elephants) {
                    elephant hidepart("<dev string:x7d8>");
                }
                break;
            case #"show_head":
                elephants = getaiarchetypearray("<dev string:x67>");
                foreach (elephant in elephants) {
                    elephant showpart("<dev string:x7d8>");
                }
                break;
            case #"hash_6f54f417f7b5ac51":
                level flag::set(#"hash_37071af70fe7a9f2");
                setdvar(#"hash_3065419bcba97739", 1);
                break;
            case #"hash_484a268dfc6c97aa":
                setdvar(#"zombie_default_max", 0);
                setdvar(#"hash_2b64162aa40fe2bb", 1);
                level flag::set(#"hash_37071af70fe7a9f2");
                setdvar(#"hash_3065419bcba97739", 1);
            case #"hash_1b7f90925f6498e3":
                elephants = getaiarchetypearray("<dev string:x67>");
                foreach (elephant in elephants) {
                    elephant.var_7c305ac4 = 2;
                }
                break;
            case #"hash_503e90ea2aaf5f30":
                elephants = getaiarchetypearray("<dev string:x67>");
                foreach (elephant in elephants) {
                    elephant.var_7c305ac4 = 1;
                }
                break;
            case #"hash_5e18a71c0cbda56a":
                elephants = getaiarchetypearray("<dev string:x67>");
                foreach (elephant in elephants) {
                    elephant.var_7c305ac4 = 3;
                }
                break;
            case #"hash_28ef2ead2bec713f":
                elephants = getaiarchetypearray("<dev string:x67>");
                foreach (elephant in elephants) {
                    elephant.var_19722957 = 1;
                    elephant.var_588417db = 0;
                    elephant.ai.var_a1916335 = 1;
                }
                break;
            case #"hash_618d48cfd9850a9a":
                elephants = getaiarchetypearray("<dev string:x67>");
                foreach (elephant in elephants) {
                    elephant.var_19722957 = 0;
                    elephant.var_588417db = 0;
                    elephant.ai.var_a1916335 = 0;
                }
                break;
            case #"hash_3659cf300f60df4b":
                elephants = getaiarchetypearray("<dev string:x67>");
                foreach (elephant in elephants) {
                    elephant.var_588417db = 1;
                    elephant.var_19722957 = 0;
                    elephant.ai.var_a1916335 = 1;
                }
                break;
            case #"hash_69cb3828846de716":
                elephants = getaiarchetypearray("<dev string:x67>");
                foreach (elephant in elephants) {
                    elephant.var_588417db = 0;
                    elephant.var_19722957 = 0;
                    elephant.ai.var_a1916335 = 0;
                }
                break;
            default:
                break;
            }
        }
    }

#/
