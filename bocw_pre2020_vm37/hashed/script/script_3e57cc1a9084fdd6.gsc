#using script_1940fc077a028a81;
#using script_20dc0f45753888c7;
#using script_3357acf79ce92f4b;
#using script_3411bb48d41bd3b;
#using script_3819e7a1427df6d2;
#using scripts\core_common\ai\archetype_utility;
#using scripts\core_common\ai\systems\ai_interface;
#using scripts\core_common\ai\systems\animation_state_machine_mocomp;
#using scripts\core_common\ai\systems\animation_state_machine_notetracks;
#using scripts\core_common\ai\systems\animation_state_machine_utility;
#using scripts\core_common\ai\systems\behavior_state_machine;
#using scripts\core_common\ai\systems\behavior_tree_utility;
#using scripts\core_common\ai\systems\blackboard;
#using scripts\core_common\ai_shared;
#using scripts\core_common\animation_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\status_effects\status_effect_util;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;

#namespace namespace_9bfbd119;

// Namespace namespace_9bfbd119
// Method(s) 2 Total 2
class class_970c2a7e {

    var adjustmentstarted;
    var var_425c4c8b;

    // Namespace class_970c2a7e/namespace_ec0691f8
    // Params 0, eflags: 0x9 linked
    // Checksum 0x9ac38539, Offset: 0x4d80
    // Size: 0x1a
    constructor() {
        adjustmentstarted = 0;
        var_425c4c8b = 1;
    }

}

#namespace namespace_ec0691f8;

// Namespace namespace_ec0691f8/namespace_ec0691f8
// Params 0, eflags: 0x6
// Checksum 0x952fbb97, Offset: 0x518
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"hash_4863f776a30a1247", &function_d29d4c99, undefined, undefined, undefined);
}

// Namespace namespace_ec0691f8/namespace_ec0691f8
// Params 0, eflags: 0x1 linked
// Checksum 0x170727cc, Offset: 0x560
// Size: 0x104
function function_d29d4c99() {
    clientfield::register("actor", "sr_dog_pre_spawn_fx", 15000, 1, "counter");
    clientfield::register("actor", "sr_dog_spawn_fx", 15000, 1, "counter");
    clientfield::register("actor", "sr_dog_fx", 15000, 1, "int");
    registerbehaviorscriptfunctions();
    spawner::add_archetype_spawn_function(#"zombie_dog", &function_b9d56970);
    spawner::function_89a2cd87(#"zombie_dog", &function_e79ec851);
}

// Namespace namespace_ec0691f8/namespace_ec0691f8
// Params 13, eflags: 0x5 linked
// Checksum 0x1bed2cb, Offset: 0x670
// Size: 0x398
function private function_cef412a7(einflictor, eattacker, idamage, *idflags, smeansofdeath, weapon, *vpoint, *vdir, *shitloc, *psoffsettime, *damagefromunderneath, *modelindex, *partname) {
    /#
        if (is_true(level.var_85a39c96)) {
            damagefromunderneath = self.health + 1;
        }
    #/
    if (isdefined(psoffsettime) && !util::function_fbce7263(self.team, psoffsettime.team)) {
        return 0;
    }
    if (isdefined(partname) && modelindex !== "MOD_DOT") {
        dot_params = function_f74d2943(partname, 7);
        if (isdefined(dot_params)) {
            status_effect::status_effect_apply(dot_params, partname, shitloc);
        }
    }
    if (isdefined(shitloc) && !isdefined(self.attackable) && isdefined(shitloc.var_b79a8ac7) && isarray(shitloc.var_b79a8ac7.slots) && isarray(level.var_7fc48a1a) && isinarray(level.var_7fc48a1a, partname)) {
        if (shitloc namespace_85745671::get_attackable_slot(self)) {
            self.attackable = shitloc;
        }
    }
    if (is_true(level.is_survival) && !isdefined(self.enemy_override) && !isdefined(self.favoriteenemy) && isdefined(psoffsettime) && isplayer(psoffsettime)) {
        if (isdefined(modelindex) && (modelindex == "MOD_MELEE" || modelindex == "MOD_MELEE_WEAPON_BUTT") || isdefined(partname) && partname.statname === #"hatchet") {
            n_radius = 512;
        } else {
            n_radius = 2048;
        }
        awareness::function_e732359c(1, self.origin, n_radius, self, {#position:psoffsettime.origin});
    }
    if (damagefromunderneath > 0) {
        var_ebcff177 = 1;
        callback::callback(#"hash_3886c79a26cace38", {#eattacker:psoffsettime, #var_dcc8dd60:self getentitynumber(), #idamage:damagefromunderneath, #type:var_ebcff177});
    }
    return damagefromunderneath;
}

// Namespace namespace_ec0691f8/namespace_ec0691f8
// Params 0, eflags: 0x1 linked
// Checksum 0x3d664e28, Offset: 0xa10
// Size: 0x2b6
function function_b9d56970() {
    self callback::function_d8abfc3d(#"on_ai_melee", &namespace_85745671::function_b8eb5dea);
    self callback::function_d8abfc3d(#"hash_45b50cc48ee7f9d8", &function_69c3e2ac);
    self callback::function_d8abfc3d(#"hash_3bb51ce51020d0eb", &namespace_85745671::function_16e2f075);
    self callback::function_d8abfc3d(#"hash_10ab46b52df7967a", &namespace_85745671::function_5cb3181e);
    self callback::function_d8abfc3d(#"hash_790882ac8688cee5", &function_2272dcba);
    if (!isdefined(self.var_9fde8624)) {
        self callback::function_d8abfc3d(#"on_dog_killed", &on_dog_killed);
    }
    aiutility::addaioverridedamagecallback(self, &function_cef412a7);
    self.var_b3c613a7 = [1, 1, 1, 1, 1];
    self.var_414bc881 = 0.5;
    if (self.var_9fde8624 === #"hash_2a5479b83161cb35") {
        self.var_12af7864 = 1;
    }
    self.var_58c4c69b = 1;
    self.var_65e57a10 = 1;
    self.var_f8df968e = &function_d4dbfd41;
    self.cant_move_cb = &function_9c573bc6;
    self.var_31a789c0 = 1;
    self.var_1c0eb62a = 180;
    self.var_13138acf = 1;
    self.var_cbc65493 = 1.5;
    self.var_f1b4d6d3 = 1;
    self.var_6daa6190 = 1;
    self.var_721a3dbd = 1;
    self.var_86152978 = gettime();
    self.var_b82726ff = 0;
    self.var_4b07f09f = 0;
    self.completed_emerging_into_playable_area = 1;
    self.ai.var_870d0893 = 1;
}

// Namespace namespace_ec0691f8/namespace_ec0691f8
// Params 0, eflags: 0x1 linked
// Checksum 0x4eb5c18e, Offset: 0xcd0
// Size: 0x14
function function_e79ec851() {
    function_c2400b01();
}

// Namespace namespace_ec0691f8/namespace_ec0691f8
// Params 1, eflags: 0x1 linked
// Checksum 0x6c2faa, Offset: 0xcf0
// Size: 0x54
function function_2272dcba(*params) {
    self callback::function_d8abfc3d(#"hash_4afe635f36531659", &awareness::function_c6b1009e);
    self thread awareness::function_c6b1009e();
}

// Namespace namespace_ec0691f8/namespace_ec0691f8
// Params 1, eflags: 0x5 linked
// Checksum 0x45d48aab, Offset: 0xd50
// Size: 0x7c
function private function_9c573bc6(*entity) {
    self notify("4d51a1e90af548ec");
    self endon("5c2a82620d7bf511", #"death");
    if (isdefined(self.enemy_override)) {
        return;
    }
    self collidewithactors(0);
    wait 2;
    self collidewithactors(1);
}

// Namespace namespace_ec0691f8/namespace_ec0691f8
// Params 0, eflags: 0x1 linked
// Checksum 0xdea8daad, Offset: 0xdd8
// Size: 0x294
function function_c2400b01() {
    self endon(#"death");
    self.has_awareness = 1;
    self.ignorelaststandplayers = 1;
    self.var_1267fdea = 1;
    self callback::function_d8abfc3d(#"on_ai_damage", &awareness::function_5f511313);
    awareness::register_state(self, #"wander", &function_9f9d7a80, &awareness::function_4ebe4a6d, &awareness::function_b264a0bc, undefined, &awareness::function_555d960b);
    awareness::register_state(self, #"investigate", &function_461711c2, &awareness::function_9eefc327, &function_2114b12b, undefined, &awareness::function_a360dd00);
    if (self.var_9fde8624 === #"hash_28e36e7b7d5421f") {
        awareness::register_state(self, #"chase", &function_6f207918, &function_d005c417, &function_cf29908a, &awareness::function_5c40e824, undefined);
    } else {
        awareness::register_state(self, #"chase", &function_6f207918, &namespace_9bfbd119::function_90da9686, &function_cf29908a, &awareness::function_5c40e824, undefined);
    }
    if (is_true(level.is_survival)) {
        awareness::set_state(self, #"wander");
    } else {
        self.var_6324ed63 = -1;
        awareness::set_state(self, #"chase");
    }
    self thread awareness::function_fa6e010d();
}

// Namespace namespace_ec0691f8/namespace_ec0691f8
// Params 1, eflags: 0x5 linked
// Checksum 0xfa713ed4, Offset: 0x1078
// Size: 0x84
function private function_9f9d7a80(entity) {
    entity.fovcosine = 0.5;
    entity.maxsightdistsqrd = function_a3f6cdac(1400);
    entity.var_1267fdea = 0;
    entity namespace_85745671::function_9758722(#"walk");
    self.var_6daa6190 = 1;
    awareness::function_9c9d96b5(entity);
}

// Namespace namespace_ec0691f8/namespace_ec0691f8
// Params 1, eflags: 0x5 linked
// Checksum 0x976449d, Offset: 0x1108
// Size: 0xac
function private function_461711c2(entity) {
    entity.fovcosine = 0;
    entity.maxsightdistsqrd = function_a3f6cdac(2000);
    entity.var_1267fdea = 0;
    util::delay(randomfloatrange(0.1, 1), "state_changed", &namespace_85745671::function_9758722, #"run");
    awareness::function_b41f0471(entity);
}

// Namespace namespace_ec0691f8/namespace_ec0691f8
// Params 1, eflags: 0x5 linked
// Checksum 0x56915b63, Offset: 0x11c0
// Size: 0x24
function private function_2114b12b(entity) {
    awareness::function_34162a25(entity);
}

// Namespace namespace_ec0691f8/namespace_ec0691f8
// Params 1, eflags: 0x5 linked
// Checksum 0x2535f62b, Offset: 0x11f0
// Size: 0x7c
function private function_6f207918(entity) {
    entity.fovcosine = 0;
    entity.maxsightdistsqrd = function_a3f6cdac(3000);
    entity.var_1267fdea = 0;
    self namespace_85745671::function_9758722(#"super_sprint");
    awareness::function_978025e4(entity);
}

// Namespace namespace_ec0691f8/namespace_ec0691f8
// Params 1, eflags: 0x5 linked
// Checksum 0xec3428f9, Offset: 0x1278
// Size: 0x24
function private function_cf29908a(entity) {
    awareness::function_b9f81e8b(entity);
}

// Namespace namespace_ec0691f8/namespace_ec0691f8
// Params 0, eflags: 0x1 linked
// Checksum 0x126b5f88, Offset: 0x12a8
// Size: 0xdbc
function registerbehaviorscriptfunctions() {
    spawner::add_archetype_spawn_function(#"zombie_dog", &archetypezombiedogblackboardinit);
    assert(isscriptfunctionptr(&zombiedogshouldwalk));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombiedogshouldwalk", &zombiedogshouldwalk);
    assert(isscriptfunctionptr(&zombiedogshouldwalk));
    behaviorstatemachine::registerbsmscriptapiinternal(#"zombiedogshouldwalk", &zombiedogshouldwalk);
    assert(isscriptfunctionptr(&zombiedogshouldrun));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombiedogshouldrun", &zombiedogshouldrun);
    assert(isscriptfunctionptr(&zombiedogshouldrun));
    behaviorstatemachine::registerbsmscriptapiinternal(#"zombiedogshouldrun", &zombiedogshouldrun);
    assert(isscriptfunctionptr(&function_9c2fe7e6));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_32d317d9aed4eaeb", &function_9c2fe7e6);
    assert(isscriptfunctionptr(&function_9c2fe7e6));
    behaviorstatemachine::registerbsmscriptapiinternal(#"hash_32d317d9aed4eaeb", &function_9c2fe7e6);
    assert(isscriptfunctionptr(&function_77b7ec2d));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_1a882594c3f18ac5", &function_77b7ec2d);
    assert(isscriptfunctionptr(&function_77b7ec2d));
    behaviorstatemachine::registerbsmscriptapiinternal(#"hash_1a882594c3f18ac5", &function_77b7ec2d);
    assert(isscriptfunctionptr(&function_1a2ec6cf));
    behaviorstatemachine::registerbsmscriptapiinternal(#"hash_302c63f6e1cadacc", &function_1a2ec6cf);
    assert(isscriptfunctionptr(&function_731939c2));
    behaviorstatemachine::registerbsmscriptapiinternal(#"hash_6f309052a6def471", &function_731939c2);
    assert(isscriptfunctionptr(&function_5bac75b6));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_77ab4b89c5221f6a", &function_5bac75b6);
    assert(isscriptfunctionptr(&function_4cc712c8));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_6125f61af86f0b68", &function_4cc712c8);
    assert(isscriptfunctionptr(&function_a82712bc));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_366544d16d423e37", &function_a82712bc);
    assert(isscriptfunctionptr(&function_4a7e2ba0));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_545a7d19924edd47", &function_4a7e2ba0);
    assert(isscriptfunctionptr(&function_e393f5fe));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_105b4f2a2302e4fc", &function_e393f5fe);
    assert(isscriptfunctionptr(&function_80f985a4));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_39dff89e44839780", &function_80f985a4);
    assert(isscriptfunctionptr(&zombiedogshouldmelee));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombiedogshouldmelee", &zombiedogshouldmelee);
    assert(!isdefined(&zombiedogmeleeaction) || isscriptfunctionptr(&zombiedogmeleeaction));
    assert(!isdefined(undefined) || isscriptfunctionptr(undefined));
    assert(!isdefined(&zombiedogmeleeactionterminate) || isscriptfunctionptr(&zombiedogmeleeactionterminate));
    behaviortreenetworkutility::registerbehaviortreeaction("zombieDogMeleeAction", &zombiedogmeleeaction, undefined, &zombiedogmeleeactionterminate);
    assert(isscriptfunctionptr(&function_47e1bdeb));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_17b0ff54092cd3bd", &function_47e1bdeb);
    assert(isscriptfunctionptr(&function_a5103696));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_741bad83e4d39bf2", &function_a5103696);
    assert(isscriptfunctionptr(&function_648f6c9b));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_5dacd9fb020cb77b", &function_648f6c9b);
    assert(isscriptfunctionptr(&function_a5c4f83b));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_5c24ff85e2293300", &function_a5c4f83b);
    animationstatenetwork::registeranimationmocomp("mocomp_dog_lightning_teleport", &function_90dbd41, &function_2fa3612a, &function_1f51eea3);
    animationstatenetwork::registernotetrackhandlerfunction("zombie_dog_explode", &function_7ee905fc);
    animationstatenetwork::registernotetrackhandlerfunction("zombie_dog_suicide", &function_7ee905fc);
    animationstatenetwork::registernotetrackhandlerfunction("zombie_dog_death_vocal", &function_6f24d732);
    animationstatenetwork::registernotetrackhandlerfunction("show_hound", &function_2705e687);
    animationstatenetwork::registeranimationmocomp("mocomp_zombie_dog_leap_attack", &namespace_9bfbd119::function_fba7325a, &namespace_9bfbd119::function_b1b9da60, &namespace_9bfbd119::function_9280d53b);
    assert(!isdefined(&namespace_9bfbd119::function_856447f6) || isscriptfunctionptr(&namespace_9bfbd119::function_856447f6));
    assert(!isdefined(&namespace_9bfbd119::function_e87d4fff) || isscriptfunctionptr(&namespace_9bfbd119::function_e87d4fff));
    assert(!isdefined(&namespace_9bfbd119::function_81758b93) || isscriptfunctionptr(&namespace_9bfbd119::function_81758b93));
    behaviortreenetworkutility::registerbehaviortreeaction(#"hash_1765abc5cdc24867", &namespace_9bfbd119::function_856447f6, &namespace_9bfbd119::function_e87d4fff, &namespace_9bfbd119::function_81758b93);
    assert(isscriptfunctionptr(&namespace_9bfbd119::pa_cl_vport_zscale_4));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_1e70520bdbcffd27", &namespace_9bfbd119::pa_cl_vport_zscale_4);
    assert(isscriptfunctionptr(&namespace_9bfbd119::function_2e0abd15));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_286661abebb905a2", &namespace_9bfbd119::function_2e0abd15);
    assert(isscriptfunctionptr(&namespace_9bfbd119::function_70daebd0));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_480dc00bc877ad26", &namespace_9bfbd119::function_70daebd0);
    animationstatenetwork::registeranimationmocomp("mocomp_zombie_dog_juke", &function_bdd562d7, &function_5c3d4c42, &function_826afb7e);
}

// Namespace namespace_ec0691f8/namespace_ec0691f8
// Params 0, eflags: 0x1 linked
// Checksum 0x3f390133, Offset: 0x2070
// Size: 0x4a
function archetypezombiedogblackboardinit() {
    blackboard::createblackboardforentity(self);
    ai::createinterfaceforentity(self);
    self.___archetypeonanimscriptedcallback = &archetypezombiedogonanimscriptedcallback;
}

// Namespace namespace_ec0691f8/namespace_ec0691f8
// Params 1, eflags: 0x5 linked
// Checksum 0xa6f55f9, Offset: 0x20c8
// Size: 0x2c
function private archetypezombiedogonanimscriptedcallback(entity) {
    entity.__blackboard = undefined;
    entity archetypezombiedogblackboardinit();
}

// Namespace namespace_ec0691f8/namespace_ec0691f8
// Params 3, eflags: 0x5 linked
// Checksum 0xc338fd64, Offset: 0x2100
// Size: 0x1e4
function private function_d4dbfd41(*origin, angles, *spawn_anim) {
    self endon(#"death");
    self ghost();
    self pathmode("dont move", 1);
    self val::set(#"dog_spawn", "ignoreme");
    self val::set(#"dog_spawn", "takedamage", 0);
    self clientfield::increment("sr_dog_pre_spawn_fx");
    self setfreecameralockonallowed(0);
    if (isdefined(self.favoriteenemy)) {
        angle = vectortoangles(self.favoriteenemy.origin - self.origin);
        spawn_anim = (self.angles[0], angle[1], self.angles[2]);
    } else {
        spawn_anim = self.angles;
    }
    if (self.var_9fde8624 === #"hash_2a5479b83161cb35") {
        self animation::play("ai_t9_zm_zombie_dog_spawn_air_plaguehound_01", self.origin, spawn_anim);
        return;
    }
    if (self.var_9fde8624 === #"hash_28e36e7b7d5421f") {
        self animation::play("ai_t9_zm_zombie_dog_spawn_air_hellhound_01", self.origin, spawn_anim);
    }
}

// Namespace namespace_ec0691f8/namespace_ec0691f8
// Params 1, eflags: 0x5 linked
// Checksum 0x3f0dc4d8, Offset: 0x22f0
// Size: 0x1dc
function private function_2705e687(*entity) {
    earthquake(0.5, 0.75, self.origin, 1000);
    if (isdefined(self.favoriteenemy)) {
        angle = vectortoangles(self.favoriteenemy.origin - self.origin);
        angles = (self.angles[0], angle[1], self.angles[2]);
    } else {
        angles = self.angles;
    }
    self dontinterpolate();
    self forceteleport(self.origin, angles);
    self clientfield::increment("sr_dog_spawn_fx");
    self val::reset(#"dog_spawn", "takedamage");
    wait 0.1;
    self show();
    self setfreecameralockonallowed(1);
    self val::reset(#"dog_spawn", "ignoreme");
    self pathmode("move allowed");
    self clientfield::set("sr_dog_fx", 1);
}

// Namespace namespace_ec0691f8/namespace_ec0691f8
// Params 1, eflags: 0x5 linked
// Checksum 0xb3a3c7f0, Offset: 0x24d8
// Size: 0x84
function private function_7ee905fc(*params) {
    if (self ishidden()) {
        return;
    }
    if (function_a82712bc(self)) {
        function_2bf6dd1c(self);
    }
    self.var_7a68cd0c = 1;
    self callback::callback(#"on_dog_killed");
}

// Namespace namespace_ec0691f8/namespace_ec0691f8
// Params 1, eflags: 0x5 linked
// Checksum 0x5e91bcfa, Offset: 0x2568
// Size: 0x94
function private function_6f24d732(*params) {
    self clientfield::set("sndAwarenessChange", 0);
    if (self.var_9fde8624 === #"hash_2a5479b83161cb35") {
        self playsound(#"hash_6e603d5f1970365b");
        return;
    }
    self playsound(#"vox_ai_hellhound_death");
}

// Namespace namespace_ec0691f8/namespace_ec0691f8
// Params 1, eflags: 0x5 linked
// Checksum 0x321ab6c4, Offset: 0x2608
// Size: 0x12c
function private on_dog_killed(*params) {
    blast_radius = 150;
    var_83f35abe = 20;
    var_6927cfa0 = 1;
    if (getdvarstring(#"g_gametype") !== "survival") {
        blast_radius = 100;
        var_83f35abe = 5;
    }
    radiusdamage(self.origin + (0, 0, 18), blast_radius, var_83f35abe, var_6927cfa0, undefined, "MOD_PROJECTILE_SPLASH");
    self clientfield::set("sr_dog_fx", 0);
    self ghost();
    self notsolid();
    playsoundatposition(#"zmb_hellhound_explode", self.origin);
}

// Namespace namespace_ec0691f8/namespace_ec0691f8
// Params 0, eflags: 0x5 linked
// Checksum 0x819f9484, Offset: 0x2740
// Size: 0x22
function private function_69c3e2ac() {
    self.hasseenfavoriteenemy = isdefined(self.enemy_override) || isdefined(self.favoriteenemy);
}

// Namespace namespace_ec0691f8/namespace_ec0691f8
// Params 0, eflags: 0x0
// Checksum 0xb1e0ed0b, Offset: 0x2770
// Size: 0xc2
function bb_getshouldhowlstatus() {
    if (self ai::has_behavior_attribute("howl_chance") && is_true(self.hasseenfavoriteenemy)) {
        if (!isdefined(self.shouldhowl)) {
            chance = self ai::get_behavior_attribute("howl_chance");
            self.shouldhowl = randomfloat(1) <= chance;
        }
        return (self.shouldhowl ? "howl" : "dont_howl");
    }
    return "dont_howl";
}

// Namespace namespace_ec0691f8/namespace_ec0691f8
// Params 1, eflags: 0x1 linked
// Checksum 0xe1d70da6, Offset: 0x2840
// Size: 0x34
function zombiedogshouldwalk(behaviortreeentity) {
    return behaviortreeentity getblackboardattribute("_locomotion_speed_zombie") === "locomotion_speed_walk";
}

// Namespace namespace_ec0691f8/namespace_ec0691f8
// Params 1, eflags: 0x1 linked
// Checksum 0x7b040e8d, Offset: 0x2880
// Size: 0x34
function zombiedogshouldrun(behaviortreeentity) {
    return behaviortreeentity getblackboardattribute("_locomotion_speed_zombie") === "locomotion_speed_run";
}

// Namespace namespace_ec0691f8/namespace_ec0691f8
// Params 1, eflags: 0x1 linked
// Checksum 0x7673d77f, Offset: 0x28c0
// Size: 0x34
function function_9c2fe7e6(behaviortreeentity) {
    return behaviortreeentity getblackboardattribute("_locomotion_speed_zombie") === "locomotion_speed_super_sprint";
}

// Namespace namespace_ec0691f8/namespace_ec0691f8
// Params 1, eflags: 0x1 linked
// Checksum 0xadcdbdfe, Offset: 0x2900
// Size: 0x22
function function_5bac75b6(*behaviortreeentity) {
    return is_true(self.var_8a96267d);
}

// Namespace namespace_ec0691f8/namespace_ec0691f8
// Params 1, eflags: 0x1 linked
// Checksum 0xc3e0f442, Offset: 0x2930
// Size: 0x22
function function_4cc712c8(*behaviortreeentity) {
    return is_true(self.var_8ba6ede3);
}

// Namespace namespace_ec0691f8/namespace_ec0691f8
// Params 1, eflags: 0x1 linked
// Checksum 0x48076b70, Offset: 0x2960
// Size: 0x68
function function_4a7e2ba0(behaviortreeentity) {
    if (!is_true(behaviortreeentity.takedamage)) {
        return false;
    }
    if (behaviortreeentity.var_9fde8624 === #"hash_28e36e7b7d5421f") {
        return true;
    }
    return false;
}

// Namespace namespace_ec0691f8/namespace_ec0691f8
// Params 1, eflags: 0x1 linked
// Checksum 0x6fbad09, Offset: 0x29d0
// Size: 0xa8
function function_e393f5fe(behaviortreeentity) {
    enemy = behaviortreeentity.favoriteenemy;
    if (isplayer(enemy) && util::within_fov(enemy getplayercamerapos(), enemy getplayerangles(), behaviortreeentity.origin, 0.5)) {
        behaviortreeentity setblackboardattribute("_dog_jump_explode", 1);
    }
    return true;
}

// Namespace namespace_ec0691f8/namespace_ec0691f8
// Params 1, eflags: 0x1 linked
// Checksum 0x94c0412e, Offset: 0x2a80
// Size: 0x30
function function_80f985a4(behaviortreeentity) {
    if (behaviortreeentity.var_9fde8624 === #"hash_2a5479b83161cb35") {
        return true;
    }
    return false;
}

// Namespace namespace_ec0691f8/namespace_ec0691f8
// Params 1, eflags: 0x1 linked
// Checksum 0x685430da, Offset: 0x2ab8
// Size: 0x6a
function function_a82712bc(behaviortreeentity) {
    if (behaviortreeentity.var_9fde8624 === #"hash_28e36e7b7d5421f") {
        node = behaviortreeentity.traversestartnode;
        if (namespace_85745671::function_f4087909(node.var_597f08bf)) {
            return true;
        }
        return false;
    }
    return false;
}

// Namespace namespace_ec0691f8/namespace_ec0691f8
// Params 1, eflags: 0x1 linked
// Checksum 0xee1260cc, Offset: 0x2b30
// Size: 0x5e
function function_2bf6dd1c(entity) {
    node = entity.traversestartnode;
    if (isdefined(node.var_597f08bf)) {
        barricade = node.var_597f08bf;
        barricade notify(#"hash_5cfbbb6ee8378665");
        return 1;
    }
}

// Namespace namespace_ec0691f8/namespace_ec0691f8
// Params 1, eflags: 0x1 linked
// Checksum 0x61db2a4, Offset: 0x2b98
// Size: 0x7a
function zombiedogshouldmelee(entity) {
    if (entity.var_9fde8624 === #"hash_2a5479b83161cb35") {
        return 0;
    }
    if (entity.var_9fde8624 === #"hash_28e36e7b7d5421f" && function_a82712bc(entity)) {
        return 1;
    }
    return namespace_e292b080::zombieshouldmelee(entity);
}

// Namespace namespace_ec0691f8/namespace_ec0691f8
// Params 0, eflags: 0x1 linked
// Checksum 0x893f2a98, Offset: 0x2c20
// Size: 0x166
function use_low_attack() {
    if (!isdefined(self.enemy) || !isplayer(self.enemy)) {
        return false;
    }
    height_diff = self.enemy.origin[2] - self.origin[2];
    low_enough = 30;
    if (height_diff < low_enough && self.enemy getstance() == "prone") {
        return true;
    }
    melee_origin = (self.origin[0], self.origin[1], self.origin[2] + 65);
    enemy_origin = (self.enemy.origin[0], self.enemy.origin[1], self.enemy.origin[2] + 32);
    if (!bullettracepassed(melee_origin, enemy_origin, 0, self)) {
        return true;
    }
    return false;
}

// Namespace namespace_ec0691f8/namespace_ec0691f8
// Params 2, eflags: 0x1 linked
// Checksum 0xb6a1cd6f, Offset: 0x2d90
// Size: 0xa0
function zombiedogmeleeaction(behaviortreeentity, asmstatename) {
    behaviortreeentity clearpath();
    context = "high";
    if (behaviortreeentity use_low_attack()) {
        context = "low";
    }
    behaviortreeentity setblackboardattribute("_context", context);
    animationstatenetworkutility::requeststate(behaviortreeentity, asmstatename);
    return 5;
}

// Namespace namespace_ec0691f8/namespace_ec0691f8
// Params 2, eflags: 0x1 linked
// Checksum 0x5c9b84f4, Offset: 0x2e38
// Size: 0x38
function zombiedogmeleeactionterminate(behaviortreeentity, *asmstatename) {
    asmstatename setblackboardattribute("_context", undefined);
    return 4;
}

// Namespace namespace_ec0691f8/namespace_ec0691f8
// Params 1, eflags: 0x1 linked
// Checksum 0xd3de03e8, Offset: 0x2e78
// Size: 0xac
function function_648f6c9b(behaviortreeentity) {
    behaviortreeentity.var_8a96267d = undefined;
    behaviortreeentity clientfield::set("sr_dog_fx", 0);
    behaviortreeentity ghost();
    behaviortreeentity notsolid();
    behaviortreeentity pathmode("dont move", 1);
    playsoundatposition(#"zmb_hellhound_explode", behaviortreeentity.origin);
}

// Namespace namespace_ec0691f8/namespace_ec0691f8
// Params 1, eflags: 0x1 linked
// Checksum 0xad0474e0, Offset: 0x2f30
// Size: 0x20
function function_a5c4f83b(behaviortreeentity) {
    behaviortreeentity notify(#"is_underground");
}

// Namespace namespace_ec0691f8/namespace_ec0691f8
// Params 1, eflags: 0x1 linked
// Checksum 0x5dccb113, Offset: 0x2f58
// Size: 0x2e
function function_47e1bdeb(behaviortreeentity) {
    behaviortreeentity solid();
    behaviortreeentity.var_8ba6ede3 = undefined;
}

// Namespace namespace_ec0691f8/namespace_ec0691f8
// Params 1, eflags: 0x1 linked
// Checksum 0x4b245540, Offset: 0x2f90
// Size: 0x24
function function_a5103696(behaviortreeentity) {
    behaviortreeentity thread function_1980a07a(behaviortreeentity);
}

// Namespace namespace_ec0691f8/namespace_ec0691f8
// Params 1, eflags: 0x5 linked
// Checksum 0x706f2472, Offset: 0x2fc0
// Size: 0x58
function private function_1980a07a(behaviortreeentity) {
    behaviortreeentity endon(#"death");
    behaviortreeentity pathmode("move allowed");
    behaviortreeentity.var_8ba6ede3 = undefined;
    behaviortreeentity notify(#"not_underground");
}

// Namespace namespace_ec0691f8/namespace_ec0691f8
// Params 5, eflags: 0x5 linked
// Checksum 0x7d5c15f7, Offset: 0x3020
// Size: 0x7c
function private function_90dbd41(entity, *mocompanim, *mocompanimblendouttime, *mocompanimflag, *mocompduration) {
    mocompduration clientfield::increment("sr_dog_spawn_fx");
    mocompduration ghost();
    mocompduration notsolid();
}

// Namespace namespace_ec0691f8/namespace_ec0691f8
// Params 5, eflags: 0x5 linked
// Checksum 0x4a0d153b, Offset: 0x30a8
// Size: 0x2c
function private function_2fa3612a(*entity, *mocompanim, *mocompanimblendouttime, *mocompanimflag, *mocompduration) {
    
}

// Namespace namespace_ec0691f8/namespace_ec0691f8
// Params 5, eflags: 0x5 linked
// Checksum 0x426f3cf9, Offset: 0x30e0
// Size: 0xcc
function private function_1f51eea3(entity, *mocompanim, *mocompanimblendouttime, *mocompanimflag, *mocompduration) {
    mocompduration dontinterpolate();
    mocompduration forceteleport(mocompduration.traverseendnode.origin, mocompduration.traverseendnode.angles, 0);
    mocompduration clientfield::increment("sr_dog_spawn_fx");
    mocompduration show();
    mocompduration solid();
}

// Namespace namespace_ec0691f8/namespace_ec0691f8
// Params 1, eflags: 0x1 linked
// Checksum 0x7656ef3c, Offset: 0x31b8
// Size: 0x46c
function function_d005c417(entity) {
    if (is_true(entity.var_1fa24724)) {
        if (float(gettime() - entity.var_4ca11261) / 1000 > 5) {
            entity.var_6324ed63 = undefined;
        }
        goal = getclosestpointonnavmesh(entity.origin, 2 * 39.3701, entity getpathfindingradius() * 1.2);
        if (isdefined(goal)) {
            entity setgoal(goal);
        } else {
            entity setgoal(self.origin);
        }
    }
    if (!isdefined(entity.enemy_override) && !isdefined(entity.attackable) && !awareness::function_2bc424fd(entity, entity.enemy)) {
        awareness::set_state(entity, #"wander");
        return;
    }
    if (isdefined(entity.var_b238ef38) && isdefined(entity.var_b238ef38.position)) {
        entity setgoal(entity.var_b238ef38.position);
        return;
    }
    if (isdefined(entity.enemy_override)) {
        goal = getclosestpointonnavmesh(entity.enemy_override.origin, 200, entity getpathfindingradius() * 1.2);
        if (isdefined(goal)) {
            entity setgoal(goal);
            return;
        }
    }
    if (isdefined(entity.favoriteenemy)) {
        lastknownpos = entity lastknownpos(entity.enemy);
        if (isdefined(lastknownpos)) {
            if (namespace_85745671::function_142c3c86(entity.enemy)) {
                enemy_vehicle = entity.enemy getvehicleoccupied();
                var_81952387 = enemy_vehicle.origin;
                for (i = 0; i < 11; i++) {
                    if (enemy_vehicle function_dcef0ba1(i)) {
                        var_ec950ebd = enemy_vehicle function_defc91b2(i);
                        if (isdefined(var_ec950ebd) && var_ec950ebd >= 0) {
                            seat_pos = enemy_vehicle function_5051cc0c(i);
                            if (distancesquared(entity.origin, var_81952387) > distancesquared(entity.origin, seat_pos)) {
                                var_81952387 = seat_pos;
                            }
                        }
                    }
                }
                lastknownpos = var_81952387;
            }
            goal = getclosestpointonnavmesh(lastknownpos, 200, entity getpathfindingradius() * 1.2);
            if (isdefined(goal)) {
                entity setgoal(goal);
            }
        }
        return;
    }
    goal = getclosestpointonnavmesh(entity.origin, 200, entity getpathfindingradius() * 1.2);
    if (isdefined(goal)) {
        entity setgoal(goal);
        return;
    }
    entity setgoal(self.origin);
}

// Namespace namespace_ec0691f8/namespace_ec0691f8
// Params 1, eflags: 0x4
// Checksum 0xa92697f6, Offset: 0x3630
// Size: 0x36
function private function_84460929(entity) {
    entity.var_3f59be70 = gettime() + randomintrange(4500, 6000);
}

// Namespace namespace_ec0691f8/namespace_ec0691f8
// Params 1, eflags: 0x5 linked
// Checksum 0x149918e9, Offset: 0x3670
// Size: 0x10
function private function_1a2ec6cf(*entity) {
    return true;
}

// Namespace namespace_ec0691f8/namespace_ec0691f8
// Params 1, eflags: 0x5 linked
// Checksum 0x84c19c0c, Offset: 0x3688
// Size: 0x36
function private function_731939c2(entity) {
    entity.var_3f59be70 = gettime() + randomintrange(4500, 6000);
}

// Namespace namespace_ec0691f8/namespace_ec0691f8
// Params 1, eflags: 0x1 linked
// Checksum 0xee030bb6, Offset: 0x36c8
// Size: 0x194
function function_77b7ec2d(entity) {
    if (entity.var_9fde8624 === #"hash_28e36e7b7d5421f") {
        return false;
    }
    if (!isdefined(entity.favoriteenemy) || !isplayer(entity.favoriteenemy)) {
        return false;
    }
    if (isdefined(entity.var_3f59be70) && entity.var_3f59be70 > gettime()) {
        return false;
    }
    disttoenemysq = distancesquared(entity.origin, entity.favoriteenemy.origin);
    if (disttoenemysq < function_a3f6cdac(1800) && disttoenemysq >= function_a3f6cdac(400)) {
        if (util::within_fov(entity.origin, entity.angles, entity.favoriteenemy.origin, cos(30))) {
            /#
                record3dtext("<dev string:x79>", entity.origin + (0, 0, 10), (0, 1, 0), "<dev string:x83>");
            #/
            return true;
        }
    }
    return false;
}

// Namespace namespace_ec0691f8/namespace_ec0691f8
// Params 5, eflags: 0x1 linked
// Checksum 0xe48f0e49, Offset: 0x3868
// Size: 0x84
function function_bdd562d7(entity, *mocompanim, *mocompanimblendouttime, *mocompanimflag, *mocompduration) {
    mocompduration animmode("zonly_physics", 0);
    mocompduration.blockingpain = 1;
    mocompduration.usegoalanimweight = 1;
    mocompduration pathmode("dont move");
}

// Namespace namespace_ec0691f8/namespace_ec0691f8
// Params 5, eflags: 0x1 linked
// Checksum 0x98c13fa0, Offset: 0x38f8
// Size: 0x2c
function function_5c3d4c42(*entity, *mocompanim, *mocompanimblendouttime, *mocompanimflag, *mocompduration) {
    
}

// Namespace namespace_ec0691f8/namespace_ec0691f8
// Params 5, eflags: 0x1 linked
// Checksum 0x1bfe0d59, Offset: 0x3930
// Size: 0x7c
function function_826afb7e(entity, *mocompanim, *mocompanimblendouttime, *mocompanimflag, *mocompduration) {
    mocompduration.blockingpain = 0;
    mocompduration.usegoalanimweight = 0;
    mocompduration pathmode("move allowed");
    mocompduration orientmode("face default");
}

#namespace namespace_9bfbd119;

// Namespace namespace_9bfbd119/namespace_ec0691f8
// Params 1, eflags: 0x1 linked
// Checksum 0x934ef3b3, Offset: 0x39b8
// Size: 0x234
function function_70daebd0(behaviortreeentity) {
    if (self.var_9fde8624 !== #"hash_2a5479b83161cb35") {
        return false;
    }
    if (behaviortreeentity.ignoreall || !isdefined(behaviortreeentity.favoriteenemy) || !namespace_85745671::is_player_valid(behaviortreeentity.favoriteenemy) && behaviortreeentity.team === level.zombie_team) {
        return false;
    }
    enemydistsq = distancesquared(behaviortreeentity.origin, behaviortreeentity.favoriteenemy.origin);
    if (enemydistsq < function_a3f6cdac(96) && !is_true(behaviortreeentity.var_4b07f09f)) {
        return true;
    }
    if (gettime() <= self.var_86152978) {
        return false;
    }
    offset = behaviortreeentity.favoriteenemy.origin - vectornormalize(behaviortreeentity.favoriteenemy.origin - behaviortreeentity.origin) * 36;
    if (enemydistsq < function_a3f6cdac(256)) {
        if (behaviortreeentity maymovetopoint(offset, 1, 1)) {
            yawtoenemy = angleclamp180(behaviortreeentity.angles[1] - vectortoangles(behaviortreeentity.favoriteenemy.origin - behaviortreeentity.origin)[1]);
            if (abs(yawtoenemy) <= 80) {
                return true;
            }
        }
    }
    return false;
}

// Namespace namespace_9bfbd119/namespace_ec0691f8
// Params 1, eflags: 0x5 linked
// Checksum 0x44f8f302, Offset: 0x3bf8
// Size: 0x49a
function private function_67ac704b(entity) {
    if (is_true(entity.ignoreall)) {
        return 0;
    }
    if (is_true(entity.disabletargetservice)) {
        return 0;
    }
    var_eef1279d = 0;
    if (distancesquared(entity.origin, entity.favoriteenemy.origin) >= function_a3f6cdac(200)) {
        var_eef1279d = 1;
    }
    if (var_eef1279d && !is_true(entity.var_cc94acec) && !is_true(entity.var_b11272e3)) {
        if (!isdefined(entity.var_aaeee932)) {
            entity.var_aaeee932 = 0;
            if (math::cointoss()) {
                entity.var_aaeee932 = 2;
            }
        }
        entity function_4ab2a687();
    }
    if (is_true(entity.var_cc94acec) && !is_true(entity.var_b11272e3)) {
        self function_a57c34b7(entity.var_826049b6);
        if (entity function_5f5b0c1a()) {
            entity.var_b82726ff = 1;
            entity namespace_85745671::function_9758722(#"super_sprint");
        } else if (entity.var_b82726ff === 1) {
            entity namespace_85745671::function_9758722(#"super_sprint");
        } else {
            entity namespace_85745671::function_9758722(#"walk");
        }
        if (distancesquared(entity.origin, entity.var_826049b6) <= function_a3f6cdac(32)) {
            entity.var_b11272e3 = 1;
            if (entity function_5f5b0c1a() === 0 && is_true(entity.var_4b07f09f)) {
                entity.var_b82726ff = 0;
            } else {
                entity.var_b82726ff = 1;
            }
            self function_d4c687c9();
        }
        return 1;
    }
    if (distancesquared(entity.origin, entity.favoriteenemy.origin) <= function_a3f6cdac(64)) {
        entity.var_b11272e3 = 0;
        entity.var_cc94acec = 0;
        entity.var_86152978 = gettime();
        entity namespace_85745671::function_9758722(#"super_sprint");
        entity.var_b82726ff = 1;
        return;
    }
    if (entity function_5f5b0c1a()) {
        lastknownpos = entity lastknownpos(entity.enemy);
        entity namespace_85745671::function_9758722(#"super_sprint");
        entity.var_b82726ff = 1;
        if (isdefined(lastknownpos)) {
            goal = getclosestpointonnavmesh(lastknownpos, 200, entity getpathfindingradius() * 1.2);
            if (isdefined(goal)) {
                entity setgoal(goal);
            }
        }
        return;
    }
    entity.var_cc94acec = 0;
    entity.var_b11272e3 = 0;
    entity.var_aaeee932 = undefined;
}

// Namespace namespace_9bfbd119/namespace_ec0691f8
// Params 0, eflags: 0x5 linked
// Checksum 0x838d7d5b, Offset: 0x40a0
// Size: 0x21c
function private function_4ab2a687() {
    var_77f4782e = 45;
    if (isdefined(self.var_aaeee932)) {
        if (self.var_aaeee932 == 0) {
            var_77f4782e = -45;
        } else if (self.var_aaeee932 == 1) {
            var_77f4782e = -22.5;
        } else if (self.var_aaeee932 == 3) {
            var_77f4782e = 22.5;
        }
        self.var_aaeee932++;
        if (self.var_aaeee932 > 3) {
            self.var_aaeee932 = 0;
        }
    }
    enemy = self.favoriteenemy;
    var_4a8dc744 = vectortoangles(self.origin - self.favoriteenemy.origin)[1];
    var_36294491 = absangleclamp360(var_4a8dc744 + var_77f4782e);
    var_ef2595f9 = anglestoforward((0, var_36294491, 0));
    var_9b0fde6d = enemy.origin + var_ef2595f9 * 400;
    var_b4a11ac2 = getclosestpointonnavmesh(var_9b0fde6d, 128, self getpathfindingradius());
    if (isdefined(var_b4a11ac2)) {
        path_success = self findpath(self.origin, var_b4a11ac2, 1, 0);
        if (path_success) {
            self.var_826049b6 = var_b4a11ac2;
            self.var_cc94acec = 1;
            /#
                recordsphere(self.var_826049b6, 3, (0, 1, 0), "<dev string:x91>");
            #/
            return true;
        }
    }
    return false;
}

// Namespace namespace_9bfbd119/namespace_ec0691f8
// Params 0, eflags: 0x5 linked
// Checksum 0x843d782d, Offset: 0x42c8
// Size: 0x26
function private function_5f5b0c1a() {
    if (isdefined(self.var_86152978)) {
        if (gettime() > self.var_86152978) {
            return true;
        }
    }
    return false;
}

// Namespace namespace_9bfbd119/namespace_ec0691f8
// Params 1, eflags: 0x1 linked
// Checksum 0x43838f3b, Offset: 0x42f8
// Size: 0x50c
function function_90da9686(entity) {
    if (is_true(entity.var_1fa24724)) {
        if (float(gettime() - entity.var_4ca11261) / 1000 > 5) {
            entity.var_6324ed63 = undefined;
        }
        goal = getclosestpointonnavmesh(entity.origin, 2 * 39.3701, entity getpathfindingradius() * 1.2);
        if (isdefined(goal)) {
            entity setgoal(goal);
        } else {
            entity setgoal(self.origin);
        }
    }
    if (!isdefined(entity.enemy_override) && !isdefined(entity.attackable) && !awareness::function_2bc424fd(entity, entity.enemy)) {
        awareness::set_state(entity, #"wander");
        return;
    }
    if (isdefined(entity.var_b238ef38) && isdefined(entity.var_b238ef38.position)) {
        entity setgoal(entity.var_b238ef38.position);
        return;
    }
    if (isdefined(entity.enemy_override)) {
        goal = getclosestpointonnavmesh(entity.enemy_override.origin, 200, entity getpathfindingradius() * 1.2);
        if (isdefined(goal)) {
            entity setgoal(goal);
            return;
        }
    }
    if (isdefined(entity.favoriteenemy)) {
        dist_sq = distancesquared(entity.origin, entity.favoriteenemy.origin);
        if (distancesquared(entity.origin, entity.favoriteenemy.origin) >= function_a3f6cdac(600) && !is_true(entity.var_cc94acec)) {
            lastknownpos = entity lastknownpos(entity.enemy);
            if (isdefined(lastknownpos)) {
                goal = getclosestpointonnavmesh(lastknownpos, 200, entity getpathfindingradius() * 1.2);
                if (isdefined(goal)) {
                    entity setgoal(goal);
                }
            }
            return;
        }
        if (is_true(entity.var_92457a8d) && (!entity function_5f5b0c1a() || dist_sq < function_a3f6cdac(96))) {
            entity namespace_85745671::function_9758722(#"walk");
            if (!is_true(entity.var_5372f2b4)) {
                if (!isdefined(entity.var_f80163dc)) {
                    entity.var_f80163dc = randomint(8);
                } else {
                    entity.var_f80163dc++;
                    if (entity.var_f80163dc >= 8) {
                        entity.var_f80163dc = 0;
                    }
                }
                entity function_1e0ddac1();
                if (isdefined(entity.var_94d159ee)) {
                    entity setgoal(entity.var_94d159ee);
                    entity.var_5372f2b4 = 1;
                }
            } else if (distancesquared(entity.origin, entity.var_94d159ee) <= function_a3f6cdac(32)) {
                entity.var_5372f2b4 = 0;
                entity.var_94d159ee = undefined;
            }
            return;
        }
        function_67ac704b(entity);
    }
}

// Namespace namespace_9bfbd119/namespace_ec0691f8
// Params 0, eflags: 0x5 linked
// Checksum 0xe8d18b14, Offset: 0x4810
// Size: 0x1f6
function private function_1e0ddac1() {
    var_77f4782e = 45 * self.var_f80163dc;
    self.var_f80163dc++;
    if (self.var_f80163dc >= 8) {
        self.var_f80163dc = 0;
    }
    enemy = self.favoriteenemy;
    var_4a8dc744 = vectortoangles(self.origin - self.favoriteenemy.origin)[1];
    var_36294491 = angleclamp180(var_4a8dc744 + var_77f4782e);
    var_ef2595f9 = anglestoforward((0, var_36294491, 0));
    var_47ce0158 = randomintrange(120, 240);
    var_9b0fde6d = enemy.origin + var_ef2595f9 * var_47ce0158;
    var_b4a11ac2 = getclosestpointonnavmesh(var_9b0fde6d, 128, self getpathfindingradius());
    if (isdefined(var_b4a11ac2)) {
        if (tracepassedonnavmesh(self.origin, var_b4a11ac2, self getpathfindingradius())) {
            self.var_94d159ee = var_b4a11ac2;
            return true;
        } else {
            /#
                recordline(self.origin, var_b4a11ac2, (1, 0, 0));
                recordcircle(var_b4a11ac2, 16, (1, 0, 0));
            #/
        }
    }
    return false;
}

// Namespace namespace_9bfbd119/namespace_ec0691f8
// Params 2, eflags: 0x5 linked
// Checksum 0xa0c05ab9, Offset: 0x4a10
// Size: 0x52
function private function_856447f6(entity, asmstatename) {
    animationstatenetworkutility::requeststate(entity, asmstatename);
    pa_cl_vport_zscale_4(entity);
    entity.hit_ent = undefined;
    return 5;
}

// Namespace namespace_9bfbd119/namespace_ec0691f8
// Params 2, eflags: 0x5 linked
// Checksum 0xe642443b, Offset: 0x4a70
// Size: 0x128
function private function_e87d4fff(entity, *asmstatename) {
    if (asmstatename asmgetstatus() == "asm_status_complete") {
        return 4;
    }
    if (isdefined(asmstatename.hit_ent) || !isdefined(asmstatename.favoriteenemy) || !is_true(asmstatename.var_47c91780)) {
        return 5;
    }
    eye_pos = asmstatename util::get_eye();
    enemy_eye_pos = asmstatename.favoriteenemy util::get_eye();
    if (distancesquared(eye_pos, enemy_eye_pos) > function_a3f6cdac(asmstatename.meleeweapon.aimeleerange)) {
        return 5;
    }
    asmstatename function_5295d194(eye_pos, enemy_eye_pos);
    return 5;
}

// Namespace namespace_9bfbd119/namespace_ec0691f8
// Params 2, eflags: 0x5 linked
// Checksum 0x8484dd06, Offset: 0x4ba0
// Size: 0x76
function private function_81758b93(entity, *asmstatename) {
    function_2e0abd15(asmstatename);
    asmstatename.hit_ent = undefined;
    asmstatename.var_cc94acec = 0;
    asmstatename.var_b11272e3 = 0;
    asmstatename.var_aaeee932 = undefined;
    asmstatename.var_5372f2b4 = 0;
    asmstatename.var_94d159ee = undefined;
    return 4;
}

// Namespace namespace_9bfbd119/namespace_ec0691f8
// Params 1, eflags: 0x1 linked
// Checksum 0xcc425899, Offset: 0x4c20
// Size: 0x4c
function pa_cl_vport_zscale_4(entity) {
    entity.var_fabc1520 = 1;
    self function_2b82dc3c();
    entity pathmode("dont move", 1);
}

// Namespace namespace_9bfbd119/namespace_ec0691f8
// Params 1, eflags: 0x1 linked
// Checksum 0xfe185feb, Offset: 0x4c78
// Size: 0x6e
function function_2e0abd15(entity) {
    entity.var_fabc1520 = 0;
    self function_2b82dc3c();
    entity.var_b82726ff = 1;
    entity pathmode("move allowed");
    entity.var_92457a8d = 1;
    entity.var_f80163dc = undefined;
}

// Namespace namespace_9bfbd119/namespace_ec0691f8
// Params 2, eflags: 0x1 linked
// Checksum 0x99c2c842, Offset: 0x4cf0
// Size: 0x84
function function_35b4cc91(tiger, entity) {
    forward = anglestoforward(tiger.angles);
    to_enemy = vectornormalize(entity.origin - tiger.origin);
    return vectordot(forward, to_enemy) >= 0.966;
}

// Namespace namespace_9bfbd119/namespace_ec0691f8
// Params 5, eflags: 0x1 linked
// Checksum 0xb58d61b0, Offset: 0x4e40
// Size: 0x3ac
function function_fba7325a(entity, mocompanim, *mocompanimblendouttime, *mocompanimflag, *mocompduration) {
    mocompanimflag animmode("gravity", 1);
    mocompanimflag orientmode("face angle", mocompanimflag.angles[1]);
    mocompanimflag.blockingpain = 1;
    mocompanimflag.var_5dd07a80 = 1;
    mocompanimflag.var_c2986b66 = 1;
    mocompanimflag.usegoalanimweight = 1;
    mocompanimflag pathmode("dont move");
    mocompanimflag collidewithactors(0);
    mocompanimflag.var_47c91780 = 0;
    mocompanimflag.var_b736fc8b = 1;
    mocompanimflag.var_ce44ec9f = getnotetracktimes(mocompduration, "start_trace")[0];
    mocompanimflag.minigun_killstreak_minigun_inbound = getnotetracktimes(mocompduration, "stop_trace")[0];
    if (isdefined(mocompanimflag.enemy)) {
        dirtoenemy = vectornormalize(mocompanimflag.enemy.origin - mocompanimflag.origin);
        mocompanimflag forceteleport(mocompanimflag.origin, vectortoangles(dirtoenemy));
    }
    if (!isdefined(self.meleeinfo)) {
        self.meleeinfo = new class_970c2a7e();
        self.meleeinfo.var_9bfa8497 = mocompanimflag.origin;
        self.meleeinfo.var_98bc84b7 = getnotetracktimes(mocompduration, "start_procedural")[0];
        self.meleeinfo.var_6392c3a2 = getnotetracktimes(mocompduration, "stop_procedural")[0];
        var_2401d30a = getnotetracktimes(mocompduration, "stop_procedural_distance_check")[0];
        var_e397f54c = getmovedelta(mocompduration, 0, isdefined(var_2401d30a) ? var_2401d30a : 1);
        self.meleeinfo.var_cb28f380 = mocompanimflag localtoworldcoords(var_e397f54c);
        /#
            movedelta = getmovedelta(mocompduration, 0, 1);
            animendpos = mocompanimflag localtoworldcoords(movedelta);
            distance = distance(mocompanimflag.origin, animendpos);
            recordcircle(animendpos, 3, (0, 1, 0), "<dev string:x91>");
            record3dtext("<dev string:x9b>" + distance, animendpos, (0, 1, 0), "<dev string:x91>");
        #/
    }
}

// Namespace namespace_9bfbd119/namespace_ec0691f8
// Params 5, eflags: 0x1 linked
// Checksum 0xfff8a8b1, Offset: 0x51f8
// Size: 0xa44
function function_b1b9da60(entity, mocompanim, *mocompanimblendouttime, *mocompanimflag, *mocompduration) {
    assert(isdefined(self.meleeinfo));
    currentanimtime = mocompanimflag getanimtime(mocompduration);
    if (isdefined(self.var_ce44ec9f) && currentanimtime >= self.var_ce44ec9f && currentanimtime <= self.minigun_killstreak_minigun_inbound) {
        self.var_47c91780 = 1;
    } else {
        self.var_47c91780 = 0;
    }
    if (isdefined(self.enemy) && !self.meleeinfo.adjustmentstarted && self.meleeinfo.var_425c4c8b && currentanimtime >= self.meleeinfo.var_98bc84b7) {
        predictedenemypos = mocompanimflag.enemy.origin;
        if (isplayer(mocompanimflag.enemy)) {
            velocity = mocompanimflag.enemy getvelocity();
            if (length(velocity) >= 0) {
                predictedenemypos += vectorscale(velocity, 0.25);
            }
        }
        var_83fd29ee = vectornormalize(predictedenemypos - mocompanimflag.origin);
        var_1efb2395 = predictedenemypos - var_83fd29ee * mocompanimflag getpathfindingradius();
        self.meleeinfo.adjustedendpos = var_1efb2395;
        var_776ddabf = distancesquared(self.meleeinfo.var_cb28f380, self.meleeinfo.adjustedendpos);
        var_65cbfb52 = distancesquared(self.meleeinfo.var_9bfa8497, self.meleeinfo.adjustedendpos);
        if (var_776ddabf <= function_a3f6cdac(35)) {
            /#
                record3dtext("<dev string:x9f>", mocompanimflag.origin + (0, 0, 60), (1, 0, 0), "<dev string:x91>");
            #/
            self.meleeinfo.var_425c4c8b = 0;
        } else if (var_65cbfb52 <= function_a3f6cdac(200)) {
            /#
                record3dtext("<dev string:xad>", mocompanimflag.origin + (0, 0, 60), (1, 0, 0), "<dev string:x91>");
            #/
            self.meleeinfo.var_425c4c8b = 0;
        } else if (var_65cbfb52 >= function_a3f6cdac(400)) {
            /#
                record3dtext("<dev string:xbc>", mocompanimflag.origin + (0, 0, 60), (1, 0, 0), "<dev string:x91>");
            #/
            self.meleeinfo.var_425c4c8b = 0;
        }
        if (self.meleeinfo.var_425c4c8b) {
            var_776ddabf = distancesquared(self.meleeinfo.var_cb28f380, self.meleeinfo.adjustedendpos);
            var_beabc994 = anglestoforward(self.angles);
            var_1c3641f2 = (mocompanimflag.enemy.origin[0], mocompanimflag.enemy.origin[1], mocompanimflag.origin[2]);
            dirtoenemy = vectornormalize(var_1c3641f2 - mocompanimflag.origin);
            zdiff = self.meleeinfo.var_cb28f380[2] - mocompanimflag.enemy.origin[2];
            var_6738a702 = abs(zdiff) <= 30;
            withinfov = vectordot(var_beabc994, dirtoenemy) > cos(30);
            var_7948b2f3 = var_6738a702 && withinfov;
            isvisible = bullettracepassed(mocompanimflag.origin, mocompanimflag.enemy.origin, 0, self);
            var_425c4c8b = isvisible && var_7948b2f3;
            /#
                reasons = "<dev string:xcb>" + isvisible + "<dev string:xd3>" + var_6738a702 + "<dev string:xda>" + withinfov;
                if (var_425c4c8b) {
                    record3dtext(reasons, mocompanimflag.origin + (0, 0, 60), (0, 1, 0), "<dev string:x91>");
                } else {
                    record3dtext(reasons, mocompanimflag.origin + (0, 0, 60), (1, 0, 0), "<dev string:x91>");
                }
            #/
            if (var_425c4c8b) {
                var_90c3cdd2 = length(self.meleeinfo.adjustedendpos - self.meleeinfo.var_cb28f380);
                timestep = function_60d95f53();
                animlength = getanimlength(mocompduration) * 1000;
                starttime = self.meleeinfo.var_98bc84b7 * animlength;
                stoptime = self.meleeinfo.var_6392c3a2 * animlength;
                starttime = floor(starttime / timestep);
                stoptime = floor(stoptime / timestep);
                adjustduration = stoptime - starttime;
                self.meleeinfo.var_10b8b6d1 = vectornormalize(self.meleeinfo.adjustedendpos - self.meleeinfo.var_cb28f380);
                self.meleeinfo.var_8b9a15a6 = var_90c3cdd2 / adjustduration;
                self.meleeinfo.var_425c4c8b = 1;
                self.meleeinfo.adjustmentstarted = 1;
                self allowpitchangle(0);
                self clearpitchorient();
            } else {
                self.meleeinfo.var_425c4c8b = 0;
            }
        }
    }
    if (self.meleeinfo.adjustmentstarted && currentanimtime <= self.meleeinfo.var_6392c3a2) {
        assert(isdefined(self.meleeinfo.var_10b8b6d1) && isdefined(self.meleeinfo.var_8b9a15a6));
        /#
            recordsphere(self.meleeinfo.var_cb28f380, 3, (0, 1, 0), "<dev string:x91>");
            recordsphere(self.meleeinfo.adjustedendpos, 3, (0, 0, 1), "<dev string:x91>");
        #/
        adjustedorigin = mocompanimflag.origin + mocompanimflag.meleeinfo.var_10b8b6d1 * self.meleeinfo.var_8b9a15a6;
    }
    if (isdefined(mocompanimflag.favoriteenemy) && distancesquared(mocompanimflag.favoriteenemy.origin, mocompanimflag.origin) <= function_a3f6cdac(64) && function_35b4cc91(mocompanimflag, mocompanimflag.favoriteenemy)) {
        mocompanimflag animmode("angle deltas");
        return;
    }
    mocompanimflag animmode("gravity");
    if (isdefined(adjustedorigin)) {
        mocompanimflag forceteleport(adjustedorigin);
    }
}

// Namespace namespace_9bfbd119/namespace_ec0691f8
// Params 5, eflags: 0x1 linked
// Checksum 0x6bdbff41, Offset: 0x5c48
// Size: 0xf4
function function_9280d53b(entity, *mocompanim, *mocompanimblendouttime, *mocompanimflag, *mocompduration) {
    mocompduration.blockingpain = 0;
    mocompduration.var_5dd07a80 = undefined;
    mocompduration.var_c2986b66 = undefined;
    mocompduration.usegoalanimweight = 0;
    mocompduration pathmode("move allowed");
    mocompduration orientmode("face default");
    mocompduration collidewithactors(1);
    mocompduration.var_b736fc8b = 0;
    mocompduration.meleeinfo = undefined;
    mocompduration allowpitchangle(1);
    mocompduration setpitchorient();
}

// Namespace namespace_9bfbd119/namespace_ec0691f8
// Params 1, eflags: 0x0
// Checksum 0x88e4989c, Offset: 0x5d48
// Size: 0x24
function function_8ee8d380(entity) {
    entity function_5295d194();
}

// Namespace namespace_9bfbd119/namespace_ec0691f8
// Params 2, eflags: 0x1 linked
// Checksum 0x676aa927, Offset: 0x5d78
// Size: 0x16a
function function_5295d194(eye_pos, enemy_eye_pos) {
    if (!isdefined(self.favoriteenemy)) {
        return;
    }
    if (!isdefined(eye_pos)) {
        eye_pos = self util::get_eye();
    }
    if (!isdefined(enemy_eye_pos)) {
        enemy_eye_pos = self.favoriteenemy util::get_eye();
    }
    trace = physicstrace(eye_pos, enemy_eye_pos, (-15, -15, -15), (15, 15, 15), self);
    if (trace[#"fraction"] < 1) {
        self.hit_ent = trace[#"entity"];
    }
    if (isdefined(self.hit_ent)) {
        self.hit_ent dodamage(30, self.hit_ent.origin, self);
        if (isplayer(self.hit_ent)) {
            self function_5b561e92(self.hit_ent);
            self.var_4b07f09f = 1;
        }
        return;
    }
    self.var_4b07f09f = 0;
}

// Namespace namespace_9bfbd119/namespace_ec0691f8
// Params 0, eflags: 0x1 linked
// Checksum 0x838327dc, Offset: 0x5ef0
// Size: 0x16
function function_2b82dc3c() {
    self.var_86152978 = gettime() + 5000;
}

// Namespace namespace_9bfbd119/namespace_ec0691f8
// Params 1, eflags: 0x1 linked
// Checksum 0x71cc22f5, Offset: 0x5f10
// Size: 0xac
function function_5b561e92(player) {
    var_7e6e7f9f = getweapon(#"tear_gas");
    params = getstatuseffect("dot_toxic_claw");
    player status_effect::status_effect_apply(params, var_7e6e7f9f, self);
    player clientfield::increment_to_player("" + #"hash_10eff6a8464fb235", 1);
}

