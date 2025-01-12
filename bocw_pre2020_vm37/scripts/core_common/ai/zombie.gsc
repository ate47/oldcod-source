#using script_3819e7a1427df6d2;
#using scripts\core_common\ai\archetype_locomotion_utility;
#using scripts\core_common\ai\archetype_utility;
#using scripts\core_common\ai\archetype_zombie_interface;
#using scripts\core_common\ai\systems\ai_blackboard;
#using scripts\core_common\ai\systems\ai_interface;
#using scripts\core_common\ai\systems\animation_state_machine_mocomp;
#using scripts\core_common\ai\systems\animation_state_machine_notetracks;
#using scripts\core_common\ai\systems\animation_state_machine_utility;
#using scripts\core_common\ai\systems\behavior_state_machine;
#using scripts\core_common\ai\systems\behavior_tree_utility;
#using scripts\core_common\ai\systems\blackboard;
#using scripts\core_common\ai\systems\gib;
#using scripts\core_common\ai\zombie_utility;
#using scripts\core_common\ai_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\laststand_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\spawner_shared;

#namespace zombiebehavior;

// Namespace zombiebehavior/zombie
// Params 0, eflags: 0x2
// Checksum 0x3c693eb0, Offset: 0x568
// Size: 0x1dc
function autoexec init() {
    initzombiebehaviorsandasm();
    spawner::add_archetype_spawn_function(#"zombie", &archetypezombieblackboardinit);
    spawner::add_archetype_spawn_function(#"zombie", &zombie_utility::zombiespawnsetup);
    spawner::add_archetype_spawn_function(#"zombie", &archetypezombiedeathoverrideinit);
    spawner::add_archetype_spawn_function(#"zombie", &function_eb55349f);
    spawner::function_89a2cd87(#"zombie", &function_9668f61f);
    /#
        spawner::add_archetype_spawn_function(#"zombie", &zombie_utility::updateanimationrate);
    #/
    clientfield::register("actor", "zombie", 1, 1, "int");
    clientfield::register("actor", "zombie_special_day", 1, 1, "counter");
    clientfield::register("actor", "pustule_pulse_cf", 1, 1, "int");
    zombieinterface::registerzombieinterfaceattributes();
}

// Namespace zombiebehavior/zombie
// Params 0, eflags: 0x5 linked
// Checksum 0xe0c76a54, Offset: 0x750
// Size: 0x166c
function private initzombiebehaviorsandasm() {
    assert(!isdefined(&zombiemoveactionstart) || isscriptfunctionptr(&zombiemoveactionstart));
    assert(!isdefined(&zombiemoveactionupdate) || isscriptfunctionptr(&zombiemoveactionupdate));
    assert(!isdefined(undefined) || isscriptfunctionptr(undefined));
    behaviortreenetworkutility::registerbehaviortreeaction(#"zombiemoveaction", &zombiemoveactionstart, &zombiemoveactionupdate, undefined);
    assert(!isdefined(&function_9b6830c9) || isscriptfunctionptr(&function_9b6830c9));
    assert(!isdefined(undefined) || isscriptfunctionptr(undefined));
    assert(!isdefined(&function_fbdc2cc4) || isscriptfunctionptr(&function_fbdc2cc4));
    behaviortreenetworkutility::registerbehaviortreeaction(#"zombiemeleeaction", &function_9b6830c9, undefined, &function_fbdc2cc4);
    assert(isscriptfunctionptr(&zombietargetservice));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombietargetservice", &zombietargetservice);
    assert(isscriptfunctionptr(&zombiecrawlercollision));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombiecrawlercollisionservice", &zombiecrawlercollision);
    assert(isscriptfunctionptr(&zombietraversalservice));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombietraversalservice", &zombietraversalservice);
    assert(isscriptfunctionptr(&zombieisatattackobject));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombieisatattackobject", &zombieisatattackobject);
    assert(isscriptfunctionptr(&zombieshouldattackobject));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombieshouldattackobject", &zombieshouldattackobject);
    assert(isscriptfunctionptr(&zombieshouldmeleecondition));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombieshouldmelee", &zombieshouldmeleecondition);
    assert(isscriptfunctionptr(&zombieshouldjumpmeleecondition));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombieshouldjumpmelee", &zombieshouldjumpmeleecondition);
    assert(isscriptfunctionptr(&zombieshouldjumpunderwatermelee));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombieshouldjumpunderwatermelee", &zombieshouldjumpunderwatermelee);
    assert(isscriptfunctionptr(&zombiegiblegscondition));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombiegiblegscondition", &zombiegiblegscondition);
    assert(isscriptfunctionptr(&zombieshoulddisplaypain));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombieshoulddisplaypain", &zombieshoulddisplaypain);
    assert(isscriptfunctionptr(&iszombiewalking));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"iszombiewalking", &iszombiewalking);
    assert(isscriptfunctionptr(&zombieshouldmovelowg));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombieshouldmovelowg", &zombieshouldmovelowg);
    assert(isscriptfunctionptr(&zombieshouldturn));
    behaviorstatemachine::registerbsmscriptapiinternal(#"zombieshouldturn", &zombieshouldturn);
    assert(isscriptfunctionptr(&function_a716a3af));
    behaviorstatemachine::registerbsmscriptapiinternal(#"hash_4ba5bc2aba9e7670", &function_a716a3af);
    assert(isscriptfunctionptr(&function_ce53cb2e));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_27d8ceabf090b1aa", &function_ce53cb2e);
    assert(isscriptfunctionptr(&function_30373e53));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_2d1a9c2809fc0d28", &function_30373e53);
    assert(isscriptfunctionptr(&function_1b8c9407));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_4136381d29600bc", &function_1b8c9407);
    assert(isscriptfunctionptr(&function_ecba5a44));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_1732367c7f780c76", &function_ecba5a44);
    assert(isscriptfunctionptr(&function_97aec83a));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_7e8590f0e7d32865", &function_97aec83a);
    assert(isscriptfunctionptr(&function_eb4b29ab));
    behaviorstatemachine::registerbsmscriptapiinternal(#"hash_781acbf9eb317aa9", &function_eb4b29ab);
    assert(isscriptfunctionptr(&zombieshouldmeleesuicide));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombieshouldmeleesuicide", &zombieshouldmeleesuicide);
    assert(isscriptfunctionptr(&zombiemeleesuicidestart));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombiemeleesuicidestart", &zombiemeleesuicidestart);
    assert(isscriptfunctionptr(&zombiemeleesuicideupdate));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombiemeleesuicideupdate", &zombiemeleesuicideupdate);
    assert(isscriptfunctionptr(&zombiemeleesuicideterminate));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombiemeleesuicideterminate", &zombiemeleesuicideterminate);
    assert(isscriptfunctionptr(&zombieshouldjukecondition));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombieshouldjuke", &zombieshouldjukecondition);
    assert(isscriptfunctionptr(&zombiejukeactionstart));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombiejukeactionstart", &zombiejukeactionstart);
    assert(isscriptfunctionptr(&zombiejukeactionterminate));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombiejukeactionterminate", &zombiejukeactionterminate);
    assert(isscriptfunctionptr(&zombiedeathaction));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombiedeathaction", &zombiedeathaction);
    assert(isscriptfunctionptr(&zombiejuke));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombiejukeservice", &zombiejuke);
    assert(isscriptfunctionptr(&zombiestumble));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombiestumbleservice", &zombiestumble);
    assert(isscriptfunctionptr(&zombieshouldstumblecondition));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombiestumblecondition", &zombieshouldstumblecondition);
    assert(isscriptfunctionptr(&zombiestumbleactionstart));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombiestumbleactionstart", &zombiestumbleactionstart);
    assert(isscriptfunctionptr(&zombieattackobjectstart));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombieattackobjectstart", &zombieattackobjectstart);
    assert(isscriptfunctionptr(&zombieattackobjectterminate));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombieattackobjectterminate", &zombieattackobjectterminate);
    assert(isscriptfunctionptr(&waskilledbyinterdimensionalguncondition));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"waskilledbyinterdimensionalgun", &waskilledbyinterdimensionalguncondition);
    assert(isscriptfunctionptr(&wascrushedbyinterdimensionalgunblackholecondition));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"wascrushedbyinterdimensionalgunblackhole", &wascrushedbyinterdimensionalgunblackholecondition);
    assert(isscriptfunctionptr(&zombieidgundeathupdate));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombieidgundeathupdate", &zombieidgundeathupdate);
    assert(isscriptfunctionptr(&zombieidgundeathupdate));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombievortexpullupdate", &zombieidgundeathupdate);
    assert(isscriptfunctionptr(&zombiehaslegs));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombiehaslegs", &zombiehaslegs);
    assert(isscriptfunctionptr(&zombieshouldproceduraltraverse));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombieshouldproceduraltraverse", &zombieshouldproceduraltraverse);
    assert(isscriptfunctionptr(&zombiemissinglegs));
    behaviorstatemachine::registerbsmscriptapiinternal(#"zombiemissinglegs", &zombiemissinglegs);
    assert(isscriptfunctionptr(&function_f937377));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_31cc70f275702cf6", &function_f937377);
    assert(isscriptfunctionptr(&function_a82068d7));
    behaviorstatemachine::registerbsmscriptapiinternal(#"zombiemoveactionstart", &function_a82068d7);
    assert(isscriptfunctionptr(&function_626edd6b));
    behaviorstatemachine::registerbsmscriptapiinternal(#"zombiemoveactionupdate", &function_626edd6b);
    animationstatenetwork::registernotetrackhandlerfunction("zombie_melee", &zombienotetrackmeleefire);
    animationstatenetwork::registernotetrackhandlerfunction("crushed", &zombienotetrackcrushfire);
    animationstatenetwork::registeranimationmocomp("mocomp_death_idgun@zombie", &zombieidgundeathmocompstart, undefined, undefined);
    animationstatenetwork::registeranimationmocomp("mocomp_vortex_pull@zombie", &zombieidgundeathmocompstart, undefined, undefined);
    animationstatenetwork::registeranimationmocomp("mocomp_death_idgun_hole@zombie", &zombieidgunholedeathmocompstart, undefined, &zombieidgunholedeathmocompterminate);
    animationstatenetwork::registeranimationmocomp("mocomp_turn@zombie", &zombieturnmocompstart, &zombieturnmocompupdate, &zombieturnmocompterminate);
    animationstatenetwork::registeranimationmocomp("mocomp_melee_jump@zombie", &zombiemeleejumpmocompstart, &zombiemeleejumpmocompupdate, &zombiemeleejumpmocompterminate);
    animationstatenetwork::registeranimationmocomp("mocomp_zombie_idle@zombie", &zombiezombieidlemocompstart, undefined, undefined);
    animationstatenetwork::registeranimationmocomp("mocomp_attack_object@zombie", &zombieattackobjectmocompstart, &zombieattackobjectmocompupdate, undefined);
    animationstatenetwork::registeranimationmocomp("mocomp_teleport_traversal@zombie", &function_cbbae5cb, undefined, undefined);
    animationstatenetwork::registeranimationmocomp("mocomp_zombie_melee@zombie", &function_54d75299, &function_d1474842, &function_b6d297bb);
}

// Namespace zombiebehavior/zombie
// Params 0, eflags: 0x1 linked
// Checksum 0x94841b0e, Offset: 0x1dc8
// Size: 0x4a
function archetypezombieblackboardinit() {
    blackboard::createblackboardforentity(self);
    ai::createinterfaceforentity(self);
    self.___archetypeonanimscriptedcallback = &archetypezombieonanimscriptedcallback;
}

// Namespace zombiebehavior/zombie
// Params 1, eflags: 0x5 linked
// Checksum 0xbc5c78d6, Offset: 0x1e20
// Size: 0x2c
function private archetypezombieonanimscriptedcallback(entity) {
    entity.__blackboard = undefined;
    entity archetypezombieblackboardinit();
}

// Namespace zombiebehavior/zombie
// Params 0, eflags: 0x1 linked
// Checksum 0xfe3fa1f7, Offset: 0x1e58
// Size: 0xc4
function function_eb55349f() {
    aiutility::addaioverridedamagecallback(self, &archetypezombiespecialeffectscallback);
    if (self.model === #"hash_6aa75847e285712b") {
        self clientfield::set("pustule_pulse_cf", 1);
        self callback::function_d8abfc3d(#"on_ai_killed", &function_5b8201e0);
    }
    self callback::function_d8abfc3d(#"on_actor_damage", &function_f771a3f8);
}

// Namespace zombiebehavior/zombie
// Params 0, eflags: 0x1 linked
// Checksum 0xff7ad0d4, Offset: 0x1f28
// Size: 0x62
function function_9668f61f() {
    self.stumble = 0;
    self.var_b1c7a59d = gettime();
    self.var_eabe8c08 = gettime();
    self.var_4db55459 = 0;
    self.var_8198a38c = function_4a33fa36();
    self.var_b91eb4e5 = function_9ec512e6();
}

// Namespace zombiebehavior/zombie
// Params 0, eflags: 0x1 linked
// Checksum 0x8a6ce5e1, Offset: 0x1f98
// Size: 0x2c
function function_4a33fa36() {
    if (isdefined(self.health)) {
        return (0.15 * self.health);
    }
    return 30;
}

// Namespace zombiebehavior/zombie
// Params 0, eflags: 0x1 linked
// Checksum 0xaa76a93e, Offset: 0x1fd0
// Size: 0x2c
function function_9ec512e6() {
    if (isdefined(self.health)) {
        return (0.075 * self.health);
    }
    return 15;
}

// Namespace zombiebehavior/zombie
// Params 1, eflags: 0x1 linked
// Checksum 0xe38cb491, Offset: 0x2008
// Size: 0x2c
function function_5b8201e0(*params) {
    self clientfield::set("pustule_pulse_cf", 0);
}

// Namespace zombiebehavior/zombie
// Params 1, eflags: 0x1 linked
// Checksum 0xabfa458a, Offset: 0x2040
// Size: 0x214
function function_f771a3f8(params) {
    if (isdefined(self.var_b1c7a59d) && !is_true(self.missinglegs)) {
        if (self.var_b1c7a59d < gettime()) {
            self.var_b1c7a59d = gettime() + 5000;
            self.var_4db55459 = 0;
            self.stumble = 0;
        }
        self.var_4db55459 += params.idamage;
        if (isdefined(params.shitloc)) {
            if (isinarray(array("helmet", "head", "neck"), params.shitloc)) {
                function_da30b556(self);
            } else if (isinarray(array("right_leg_upper", "left_leg_upper", "right_leg_lower", "left_leg_lower", "right_foot", "left_foot"), params.shitloc)) {
                if (self.var_4db55459 >= self.var_b91eb4e5 && self.var_eabe8c08 < gettime()) {
                    function_da30b556(self);
                }
            } else if (self.var_4db55459 >= self.var_8198a38c && self.var_eabe8c08 < gettime()) {
                function_da30b556(self);
            }
            return;
        }
        if (self.var_4db55459 >= self.var_8198a38c && self.var_eabe8c08 < gettime()) {
            function_da30b556(self);
        }
    }
}

// Namespace zombiebehavior/zombie
// Params 1, eflags: 0x1 linked
// Checksum 0xaaa0d6e4, Offset: 0x2260
// Size: 0x46
function function_da30b556(entity) {
    entity.stumble = 1;
    entity.var_b1c7a59d = gettime() + 5000;
    entity.var_eabe8c08 = gettime() + 1000;
    entity.var_4db55459 = 0;
}

// Namespace zombiebehavior/zombie
// Params 1, eflags: 0x5 linked
// Checksum 0x71413702, Offset: 0x22b0
// Size: 0x4e
function private function_ce53cb2e(entity) {
    if (entity.stumble === 1 && is_false(entity.var_67f98db0)) {
        return 1;
    }
    return 0;
}

// Namespace zombiebehavior/zombie
// Params 1, eflags: 0x5 linked
// Checksum 0xd06995c3, Offset: 0x2308
// Size: 0x42
function private function_30373e53(entity) {
    entity.stumble = 0;
    entity.var_b1c7a59d = gettime() + 5000;
    entity.var_eabe8c08 = gettime() + 1000;
    entity.var_4db55459 = 0;
}

// Namespace zombiebehavior/zombie
// Params 13, eflags: 0x5 linked
// Checksum 0xbe3f3090, Offset: 0x2358
// Size: 0x100
function private archetypezombiespecialeffectscallback(*einflictor, eattacker, idamage, *idflags, *smeansofdeath, *weapon, *vpoint, *vdir, *shitloc, *psoffsettime, *damagefromunderneath, *modelindex, *partname) {
    specialdayeffectchance = getdvarint(#"tu6_ffotd_zombiespecialdayeffectschance", 0);
    if (specialdayeffectchance && randomint(100) < specialdayeffectchance) {
        if (isdefined(modelindex) && isplayer(modelindex)) {
            self clientfield::increment("zombie_special_day");
        }
    }
    return partname;
}

// Namespace zombiebehavior/zombie
// Params 0, eflags: 0x1 linked
// Checksum 0xe1881144, Offset: 0x2460
// Size: 0x1a
function bb_getvarianttype() {
    if (isdefined(self.variant_type)) {
        return self.variant_type;
    }
    return 0;
}

// Namespace zombiebehavior/zombie
// Params 0, eflags: 0x1 linked
// Checksum 0x57a9dcd0, Offset: 0x2488
// Size: 0x1a
function bb_getlowgravityvariant() {
    if (isdefined(self.low_gravity_variant)) {
        return self.low_gravity_variant;
    }
    return 0;
}

// Namespace zombiebehavior/zombie
// Params 0, eflags: 0x5 linked
// Checksum 0x6c83e626, Offset: 0x24b0
// Size: 0x5a
function private function_a95e9277() {
    assert(self.archetype == #"zombie");
    speed = self function_28e7d252();
    return speed;
}

// Namespace zombiebehavior/zombie
// Params 1, eflags: 0x1 linked
// Checksum 0x6ee35beb, Offset: 0x2518
// Size: 0x24
function iszombiewalking(entity) {
    return !is_true(entity.missinglegs);
}

// Namespace zombiebehavior/zombie
// Params 1, eflags: 0x1 linked
// Checksum 0xcce36a80, Offset: 0x2548
// Size: 0x84
function zombieshoulddisplaypain(entity) {
    if (is_true(entity.suicidaldeath)) {
        return false;
    }
    if (!hasasm(entity) || entity function_ebbebf56() < 1) {
        return false;
    }
    return !is_true(entity.missinglegs);
}

// Namespace zombiebehavior/zombie
// Params 1, eflags: 0x1 linked
// Checksum 0x428d25bb, Offset: 0x25d8
// Size: 0x58
function zombieshouldjukecondition(entity) {
    if (isdefined(entity.juke) && (entity.juke == "left" || entity.juke == "right")) {
        return true;
    }
    return false;
}

// Namespace zombiebehavior/zombie
// Params 1, eflags: 0x1 linked
// Checksum 0xfd842e6f, Offset: 0x2638
// Size: 0x24
function zombieshouldstumblecondition(entity) {
    if (isdefined(entity.stumble)) {
        return true;
    }
    return false;
}

// Namespace zombiebehavior/zombie
// Params 1, eflags: 0x5 linked
// Checksum 0xe629e494, Offset: 0x2668
// Size: 0xaa
function private zombiejukeactionstart(entity) {
    entity setblackboardattribute("_juke_direction", entity.juke);
    if (isdefined(entity.jukedistance)) {
        entity setblackboardattribute("_juke_distance", entity.jukedistance);
    } else {
        entity setblackboardattribute("_juke_distance", "short");
    }
    entity.jukedistance = undefined;
    entity.juke = undefined;
}

// Namespace zombiebehavior/zombie
// Params 1, eflags: 0x5 linked
// Checksum 0xdfdac613, Offset: 0x2720
// Size: 0x24
function private zombiejukeactionterminate(entity) {
    entity clearpath();
}

// Namespace zombiebehavior/zombie
// Params 1, eflags: 0x5 linked
// Checksum 0x60f69f6d, Offset: 0x2750
// Size: 0x16
function private zombiestumbleactionstart(entity) {
    entity.stumble = undefined;
}

// Namespace zombiebehavior/zombie
// Params 1, eflags: 0x5 linked
// Checksum 0xeac03454, Offset: 0x2770
// Size: 0x1a
function private zombieattackobjectstart(entity) {
    entity.is_inert = 1;
}

// Namespace zombiebehavior/zombie
// Params 1, eflags: 0x5 linked
// Checksum 0xf7e2e548, Offset: 0x2798
// Size: 0x16
function private zombieattackobjectterminate(entity) {
    entity.is_inert = 0;
}

// Namespace zombiebehavior/zombie
// Params 1, eflags: 0x1 linked
// Checksum 0xda6081a3, Offset: 0x27b8
// Size: 0x44
function zombiegiblegscondition(entity) {
    return gibserverutils::isgibbed(entity, 256) || gibserverutils::isgibbed(entity, 128);
}

// Namespace zombiebehavior/zombie
// Params 1, eflags: 0x1 linked
// Checksum 0x59da2fea, Offset: 0x2808
// Size: 0x1e
function function_f937377(entity) {
    entity.ai.var_80045105 = gettime();
}

// Namespace zombiebehavior/zombie
// Params 1, eflags: 0x1 linked
// Checksum 0x99d9def8, Offset: 0x2830
// Size: 0x53c
function zombienotetrackmeleefire(entity) {
    if (is_true(entity.marked_for_death)) {
        return;
    }
    entity.melee_cooldown = gettime() + getdvarfloat(#"scr_zombiemeleecooldown", 1) * 1000;
    if (is_true(entity.aat_turned)) {
        if (isdefined(entity.enemy) && isalive(entity.enemy) && !isplayer(entity.enemy)) {
            if (isdefined(entity.var_16d0eb06) && is_true(entity.enemy.var_6d23c054)) {
                if (isdefined(entity.var_443d78cc)) {
                    e_attacker = entity.var_443d78cc;
                } else {
                    e_attacker = entity;
                }
                entity.enemy dodamage(entity.var_16d0eb06, entity.origin, e_attacker, entity);
                if (!isalive(entity.enemy)) {
                    gibserverutils::gibhead(entity.enemy);
                    entity.enemy zombie_utility::gib_random_parts();
                    entity.enemy.var_7105092c = 1;
                    entity.n_aat_turned_zombie_kills++;
                }
            } else if (is_true(entity.enemy.var_6d23c054) && is_true(entity.enemy.allowdeath)) {
                if (isdefined(entity.var_443d78cc)) {
                    e_attacker = entity.var_443d78cc;
                } else {
                    e_attacker = entity;
                }
                gibserverutils::gibhead(entity.enemy);
                entity.enemy zombie_utility::gib_random_parts();
                entity.enemy.var_7105092c = 1;
                entity.enemy kill(entity.enemy.origin, e_attacker, entity, undefined, undefined, 1);
                entity.n_aat_turned_zombie_kills++;
            } else if (is_true(entity.enemy.canbetargetedbyturnedzombies)) {
                entity melee();
            }
            entity callback::callback(#"on_ai_melee");
        }
        return;
    }
    if (isdefined(entity.enemy) && is_true(entity.enemy.ignoreme)) {
        return;
    }
    if (isdefined(entity.ai.var_80045105)) {
        /#
            record3dtext("<dev string:x38>" + gettime() - entity.ai.var_80045105, self.origin, (1, 0, 0), "<dev string:x46>", entity);
        #/
    }
    if (isdefined(level.custom_melee_fire)) {
        entity [[ level.custom_melee_fire ]]();
    } else {
        entity melee();
    }
    /#
        record3dtext("<dev string:x50>", entity.origin, (1, 0, 0), "<dev string:x46>", entity);
        if (isdefined(entity.enemy)) {
            eyepos = entity geteye();
            record3dtext("<dev string:x59>" + distance2d(eyepos, entity.enemy.origin), entity.origin, (1, 0, 0), "<dev string:x46>", entity);
        }
    #/
    if (zombieshouldattackobject(entity)) {
        if (isdefined(level.attackablecallback)) {
            entity.attackable [[ level.attackablecallback ]](entity);
        }
    }
    entity callback::callback(#"on_ai_melee");
}

// Namespace zombiebehavior/zombie
// Params 1, eflags: 0x1 linked
// Checksum 0xebf18792, Offset: 0x2d78
// Size: 0x24
function zombienotetrackcrushfire(entity) {
    entity delete();
}

// Namespace zombiebehavior/zombie
// Params 1, eflags: 0x1 linked
// Checksum 0xb07ca414, Offset: 0x2da8
// Size: 0x250
function zombietargetservice(entity) {
    if (isdefined(entity.enablepushtime)) {
        if (gettime() >= entity.enablepushtime) {
            entity collidewithactors(1);
            entity.enablepushtime = undefined;
        }
    }
    if (is_true(entity.disabletargetservice)) {
        return 0;
    }
    if (is_true(entity.ignoreall)) {
        return 0;
    }
    specifictarget = undefined;
    if (isdefined(level.zombielevelspecifictargetcallback)) {
        specifictarget = [[ level.zombielevelspecifictargetcallback ]]();
    }
    if (isdefined(specifictarget)) {
        entity setgoal(specifictarget.origin);
        return;
    }
    player = zombie_utility::get_closest_valid_player(self.origin, self.ignore_player);
    if (!isdefined(player)) {
        if (isdefined(self.ignore_player)) {
            if (isdefined(level._should_skip_ignore_player_logic) && [[ level._should_skip_ignore_player_logic ]]()) {
                return 0;
            }
            self.ignore_player = [];
        }
        self setgoal(self.origin);
        return 0;
    }
    if (isdefined(player.last_valid_position)) {
        if (!is_true(self.zombie_do_not_update_goal)) {
            if (is_true(level.zombie_use_zigzag_path)) {
                entity zombieupdatezigzaggoal();
            } else {
                entity setgoal(player.last_valid_position);
            }
        }
        return 1;
    }
    if (!is_true(self.zombie_do_not_update_goal)) {
        entity setgoal(entity.origin);
    }
    return 0;
}

// Namespace zombiebehavior/zombie
// Params 0, eflags: 0x1 linked
// Checksum 0xfe6db517, Offset: 0x3000
// Size: 0x5bc
function zombieupdatezigzaggoal() {
    aiprofile_beginentry("zombieUpdateZigZagGoal");
    shouldrepath = 0;
    if (!shouldrepath && isdefined(self.favoriteenemy)) {
        if (!isdefined(self.nextgoalupdate) || self.nextgoalupdate <= gettime()) {
            shouldrepath = 1;
        } else if (distancesquared(self.origin, self.favoriteenemy.origin) <= function_a3f6cdac(250)) {
            shouldrepath = 1;
        } else if (isdefined(self.pathgoalpos)) {
            distancetogoalsqr = distancesquared(self.origin, self.pathgoalpos);
            shouldrepath = distancetogoalsqr < function_a3f6cdac(72);
        }
    }
    if (is_true(self.keep_moving)) {
        if (gettime() > self.keep_moving_time) {
            self.keep_moving = 0;
        }
    }
    if (shouldrepath) {
        goalpos = self.favoriteenemy.origin;
        if (isdefined(self.favoriteenemy.last_valid_position)) {
            goalpos = self.favoriteenemy.last_valid_position;
        }
        self setgoal(goalpos);
        if (distancesquared(self.origin, goalpos) > function_a3f6cdac(250)) {
            self.keep_moving = 1;
            self.keep_moving_time = gettime() + 250;
            path = self calcapproximatepathtoposition(goalpos, 0);
            /#
                if (getdvarint(#"ai_debugzigzag", 0)) {
                    for (index = 1; index < path.size; index++) {
                        recordline(path[index - 1], path[index], (1, 0.5, 0), "<dev string:x68>", self);
                    }
                }
            #/
            if (isdefined(level._zombiezigzagdistancemin) && isdefined(level._zombiezigzagdistancemax)) {
                min = level._zombiezigzagdistancemin;
                max = level._zombiezigzagdistancemax;
            } else {
                min = 240;
                max = 600;
            }
            deviationdistance = randomintrange(min, max);
            segmentlength = 0;
            for (index = 1; index < path.size; index++) {
                currentseglength = distance(path[index - 1], path[index]);
                if (segmentlength + currentseglength > deviationdistance) {
                    remaininglength = deviationdistance - segmentlength;
                    seedposition = path[index - 1] + vectornormalize(path[index] - path[index - 1]) * remaininglength;
                    /#
                        recordcircle(seedposition, 2, (1, 0.5, 0), "<dev string:x68>", self);
                    #/
                    innerzigzagradius = 0;
                    outerzigzagradius = 96;
                    queryresult = positionquery_source_navigation(seedposition, innerzigzagradius, outerzigzagradius, 0.5 * 72, 16, self, 16);
                    positionquery_filter_inclaimedlocation(queryresult, self);
                    if (queryresult.data.size > 0) {
                        point = queryresult.data[randomint(queryresult.data.size)];
                        self setgoal(point.origin);
                    }
                    break;
                }
                segmentlength += currentseglength;
            }
        }
        if (isdefined(level._zombiezigzagtimemin) && isdefined(level._zombiezigzagtimemax)) {
            mintime = level._zombiezigzagtimemin;
            maxtime = level._zombiezigzagtimemax;
        } else {
            mintime = 2500;
            maxtime = 3500;
        }
        self.nextgoalupdate = gettime() + randomintrange(mintime, maxtime);
    }
    aiprofile_endentry();
}

// Namespace zombiebehavior/zombie
// Params 1, eflags: 0x1 linked
// Checksum 0x24f758b5, Offset: 0x35c8
// Size: 0x1e6
function zombiecrawlercollision(entity) {
    if (!is_true(entity.missinglegs) && !is_true(entity.knockdown)) {
        return false;
    }
    if (isdefined(entity.dontpushtime)) {
        if (gettime() < entity.dontpushtime) {
            return true;
        }
    }
    if (!isdefined(level.zombie_team)) {
        return false;
    }
    zombies = getaiteamarray(level.zombie_team);
    foreach (zombie in zombies) {
        if (zombie == entity) {
            continue;
        }
        if (is_true(zombie.missinglegs) || is_true(zombie.knockdown)) {
            continue;
        }
        dist_sq = distancesquared(entity.origin, zombie.origin);
        if (dist_sq < 14400) {
            entity collidewithactors(0);
            entity.dontpushtime = gettime() + 2000;
            return true;
        }
    }
    entity collidewithactors(1);
    return false;
}

// Namespace zombiebehavior/zombie
// Params 1, eflags: 0x1 linked
// Checksum 0xbab0a3d7, Offset: 0x37b8
// Size: 0x3c
function zombietraversalservice(entity) {
    if (isdefined(entity.traversestartnode)) {
        entity collidewithactors(0);
        return true;
    }
    return false;
}

// Namespace zombiebehavior/zombie
// Params 1, eflags: 0x1 linked
// Checksum 0x68a1c0df, Offset: 0x3800
// Size: 0x196
function zombieisatattackobject(entity) {
    if (is_true(entity.missinglegs)) {
        return false;
    }
    if (isdefined(entity.enemyoverride) && isdefined(entity.enemyoverride[1])) {
        return false;
    }
    if (isdefined(entity.favoriteenemy) && is_true(entity.favoriteenemy.b_is_designated_target)) {
        return false;
    }
    if (is_true(entity.aat_turned)) {
        return false;
    }
    if (isdefined(entity.attackable) && is_true(entity.attackable.is_active)) {
        if (!isdefined(entity.attackable_slot)) {
            return false;
        }
        dist = distance2dsquared(entity.origin, entity.attackable_slot.origin);
        if (dist < 256) {
            height_offset = abs(entity.origin[2] - entity.attackable_slot.origin[2]);
            if (height_offset < 32) {
                entity.is_at_attackable = 1;
                return true;
            }
        }
    }
    return false;
}

// Namespace zombiebehavior/zombie
// Params 1, eflags: 0x1 linked
// Checksum 0xbc435bc0, Offset: 0x39a0
// Size: 0x106
function zombieshouldattackobject(entity) {
    if (is_true(entity.missinglegs)) {
        return false;
    }
    if (isdefined(entity.enemyoverride) && isdefined(entity.enemyoverride[1])) {
        return false;
    }
    if (isdefined(entity.favoriteenemy) && is_true(entity.favoriteenemy.b_is_designated_target)) {
        return false;
    }
    if (is_true(entity.aat_turned)) {
        return false;
    }
    if (isdefined(entity.attackable) && is_true(entity.attackable.is_active)) {
        if (is_true(entity.is_at_attackable)) {
            return true;
        }
    }
    return false;
}

// Namespace zombiebehavior/zombie
// Params 1, eflags: 0x1 linked
// Checksum 0xb3f070e1, Offset: 0x3ab0
// Size: 0x148
function function_997f1224(entity) {
    if (entity.archetype == #"zombie" && !isdefined(entity.var_9fde8624) && !is_true(self.missinglegs)) {
        if (entity.zombie_move_speed == "walk") {
            return function_a3f6cdac(100);
        } else if (entity.zombie_move_speed == "run") {
            return function_a3f6cdac(120);
        }
        return function_a3f6cdac(90);
    }
    if (isdefined(entity.meleeweapon) && entity.meleeweapon !== level.weaponnone) {
        meleedistsq = entity.meleeweapon.aimeleerange * entity.meleeweapon.aimeleerange;
    }
    if (!isdefined(meleedistsq)) {
        return function_a3f6cdac(100);
    }
    return meleedistsq;
}

// Namespace zombiebehavior/zombie
// Params 1, eflags: 0x1 linked
// Checksum 0xf4947bbc, Offset: 0x3c00
// Size: 0x2c6
function zombieshouldmeleecondition(entity) {
    if (isdefined(entity.enemyoverride) && isdefined(entity.enemyoverride[1])) {
        return false;
    }
    if (!isdefined(entity.enemy)) {
        return false;
    }
    if (is_true(entity.marked_for_death)) {
        return false;
    }
    if (is_true(entity.ignoremelee)) {
        return false;
    }
    if (abs(entity.origin[2] - entity.enemy.origin[2]) > (isdefined(entity.var_737e8510) ? entity.var_737e8510 : 64)) {
        return false;
    }
    meleedistsq = function_997f1224(entity);
    if (distancesquared(entity.origin, entity.enemy.origin) > meleedistsq) {
        return false;
    }
    yawtoenemy = angleclamp180(entity.angles[1] - vectortoangles(entity.enemy.origin - entity.origin)[1]);
    if (abs(yawtoenemy) > (isdefined(entity.var_1c0eb62a) ? entity.var_1c0eb62a : 60)) {
        return false;
    }
    if (!entity cansee(entity.enemy)) {
        return false;
    }
    if (distancesquared(entity.origin, entity.enemy.origin) < function_a3f6cdac(40)) {
        return true;
    }
    if (!tracepassedonnavmesh(entity.origin, isdefined(entity.enemy.last_valid_position) ? entity.enemy.last_valid_position : entity.enemy.origin, entity.enemy getpathfindingradius())) {
        return false;
    }
    return true;
}

// Namespace zombiebehavior/zombie
// Params 1, eflags: 0x5 linked
// Checksum 0xf79f6cb3, Offset: 0x3ed0
// Size: 0xc2
function private function_1b8c9407(entity) {
    /#
        if (getdvarint(#"hash_1a5939d8c37a2e07", 0)) {
            return false;
        }
    #/
    var_9fce1294 = blackboard::getblackboardevents("zombie_full_pain");
    if (isdefined(var_9fce1294) && var_9fce1294.size) {
        return false;
    }
    if (is_true(self.var_67f98db0)) {
        return false;
    }
    if (isdefined(level.var_eeb66e64) && ![[ level.var_eeb66e64 ]](entity)) {
        return false;
    }
    return true;
}

// Namespace zombiebehavior/zombie
// Params 1, eflags: 0x5 linked
// Checksum 0xfbf9001c, Offset: 0x3fa0
// Size: 0x6c
function private function_ecba5a44(entity) {
    var_1e466fbb = spawnstruct();
    var_1e466fbb.enemy = entity.enemy;
    blackboard::addblackboardevent("zombie_full_pain", var_1e466fbb, randomintrange(6000, 9000));
}

// Namespace zombiebehavior/zombie
// Params 1, eflags: 0x5 linked
// Checksum 0xb8ea527a, Offset: 0x4018
// Size: 0x3e
function private function_97aec83a(*entity) {
    /#
        if (getdvarint(#"hash_30c850c9bcd873bb", 0)) {
            return true;
        }
    #/
    return false;
}

// Namespace zombiebehavior/zombie
// Params 1, eflags: 0x5 linked
// Checksum 0xe2f46d4f, Offset: 0x4060
// Size: 0x3e
function private function_eb4b29ab(*entity) {
    /#
        if (getdvarint(#"hash_174d05033246950b", 0)) {
            return true;
        }
    #/
    return false;
}

// Namespace zombiebehavior/zombie
// Params 1, eflags: 0x5 linked
// Checksum 0xa6e1b30f, Offset: 0x40a8
// Size: 0x22
function private zombieshouldmovelowg(entity) {
    return is_true(entity.low_gravity);
}

// Namespace zombiebehavior/zombie
// Params 1, eflags: 0x5 linked
// Checksum 0x38ca855, Offset: 0x40d8
// Size: 0x2c
function private zombieshouldturn(entity) {
    return !isdefined(entity.turn_cooldown) || entity.turn_cooldown < gettime();
}

// Namespace zombiebehavior/zombie
// Params 1, eflags: 0x5 linked
// Checksum 0x283f0e0, Offset: 0x4110
// Size: 0x22
function private function_a716a3af(entity) {
    entity.turn_cooldown = gettime() + 1000;
    return true;
}

// Namespace zombiebehavior/zombie
// Params 1, eflags: 0x1 linked
// Checksum 0x95175b32, Offset: 0x4140
// Size: 0x370
function zombieshouldjumpmeleecondition(entity) {
    if (!is_true(entity.low_gravity)) {
        return false;
    }
    if (isdefined(entity.enemyoverride) && isdefined(entity.enemyoverride[1])) {
        return false;
    }
    if (!isdefined(entity.enemy)) {
        return false;
    }
    if (isdefined(entity.marked_for_death)) {
        return false;
    }
    if (is_true(entity.ignoremelee)) {
        return false;
    }
    if (entity.enemy isonground()) {
        if (isplayer(entity.enemy) && entity.enemy isplayerswimming()) {
            waterheight = getwaterheight(entity.enemy.origin);
            if (waterheight - entity.enemy.origin[2] < 24) {
                return false;
            }
        } else {
            return false;
        }
    }
    jumpchance = getdvarfloat(#"zmmeleejumpchance", 0.5);
    if (entity getentitynumber() % 10 / 10 > jumpchance) {
        return false;
    }
    predictedposition = entity.enemy.origin + entity.enemy getvelocity() * float(function_60d95f53()) / 1000 * 2;
    jumpdistancesq = pow(getdvarint(#"zmmeleejumpdistance", 180), 2);
    if (distance2dsquared(entity.origin, predictedposition) > jumpdistancesq) {
        return false;
    }
    yawtoenemy = angleclamp180(entity.angles[1] - vectortoangles(entity.enemy.origin - entity.origin)[1]);
    if (abs(yawtoenemy) > 60) {
        return false;
    }
    heighttoenemy = entity.enemy.origin[2] - entity.origin[2];
    if (heighttoenemy <= getdvarint(#"zmmeleejumpheightdifference", 60)) {
        return false;
    }
    return true;
}

// Namespace zombiebehavior/zombie
// Params 1, eflags: 0x1 linked
// Checksum 0x3979b2b2, Offset: 0x44b8
// Size: 0x248
function zombieshouldjumpunderwatermelee(entity) {
    if (isdefined(entity.enemyoverride) && isdefined(entity.enemyoverride[1])) {
        return false;
    }
    if (is_true(entity.ignoreall)) {
        return false;
    }
    if (!isdefined(entity.enemy)) {
        return false;
    }
    if (isdefined(entity.marked_for_death)) {
        return false;
    }
    if (is_true(entity.ignoremelee)) {
        return false;
    }
    if (entity.enemy isonground()) {
        return false;
    }
    if (entity depthinwater() < 48) {
        return false;
    }
    jumpdistancesq = pow(getdvarint(#"zmmeleewaterjumpdistance", 64), 2);
    if (distance2dsquared(entity.origin, entity.enemy.origin) > jumpdistancesq) {
        return false;
    }
    yawtoenemy = angleclamp180(entity.angles[1] - vectortoangles(entity.enemy.origin - entity.origin)[1]);
    if (abs(yawtoenemy) > 60) {
        return false;
    }
    heighttoenemy = entity.enemy.origin[2] - entity.origin[2];
    if (heighttoenemy <= getdvarint(#"zmmeleejumpunderwaterheightdifference", 48)) {
        return false;
    }
    return true;
}

// Namespace zombiebehavior/zombie
// Params 1, eflags: 0x1 linked
// Checksum 0xe8a6b545, Offset: 0x4708
// Size: 0x17a
function zombiestumble(entity) {
    if (is_true(entity.missinglegs)) {
        return false;
    }
    if (!is_true(entity.canstumble)) {
        return false;
    }
    if (!isdefined(entity.zombie_move_speed) || entity.zombie_move_speed != "sprint") {
        return false;
    }
    if (isdefined(entity.stumble)) {
        return false;
    }
    if (!isdefined(entity.next_stumble_time)) {
        entity.next_stumble_time = gettime() + randomintrange(9000, 12000);
    }
    if (gettime() > entity.next_stumble_time) {
        if (randomint(100) < 5) {
            closestplayer = arraygetclosest(entity.origin, level.players);
            if (distancesquared(closestplayer.origin, entity.origin) > 50000) {
                if (isdefined(entity.next_juke_time)) {
                    entity.next_juke_time = undefined;
                }
                entity.next_stumble_time = undefined;
                entity.stumble = 1;
                return true;
            }
        }
    }
    return false;
}

// Namespace zombiebehavior/zombie
// Params 1, eflags: 0x1 linked
// Checksum 0x473ea1b, Offset: 0x4890
// Size: 0x392
function zombiejuke(entity) {
    if (!entity ai::has_behavior_attribute("can_juke")) {
        return 0;
    }
    if (!entity ai::get_behavior_attribute("can_juke")) {
        return 0;
    }
    if (is_true(entity.missinglegs)) {
        return 0;
    }
    if (entity aiutility::function_cc26899f() != "locomotion_speed_walk") {
        if (entity ai::has_behavior_attribute("spark_behavior") && !entity ai::get_behavior_attribute("spark_behavior")) {
            return 0;
        }
    }
    if (isdefined(entity.juke)) {
        return 0;
    }
    if (!isdefined(entity.next_juke_time)) {
        entity.next_juke_time = gettime() + randomintrange(7500, 9500);
    }
    if (gettime() > entity.next_juke_time) {
        entity.next_juke_time = undefined;
        if (randomint(100) < 25 || entity ai::has_behavior_attribute("spark_behavior") && entity ai::get_behavior_attribute("spark_behavior")) {
            if (isdefined(entity.next_stumble_time)) {
                entity.next_stumble_time = undefined;
            }
            forwardoffset = 15;
            entity.ignorebackwardposition = 1;
            if (math::cointoss()) {
                jukedistance = 101;
                entity.jukedistance = "long";
                switch (entity aiutility::function_cc26899f()) {
                case #"locomotion_speed_run":
                case #"locomotion_speed_walk":
                    forwardoffset = 122;
                    break;
                case #"locomotion_speed_sprint":
                    forwardoffset = 129;
                    break;
                }
                entity.juke = aiutility::calculatejukedirection(entity, forwardoffset, jukedistance);
            }
            if (!isdefined(entity.juke) || entity.juke == "forward") {
                jukedistance = 69;
                entity.jukedistance = "short";
                switch (entity aiutility::function_cc26899f()) {
                case #"locomotion_speed_run":
                case #"locomotion_speed_walk":
                    forwardoffset = 127;
                    break;
                case #"locomotion_speed_sprint":
                    forwardoffset = 148;
                    break;
                }
                entity.juke = aiutility::calculatejukedirection(entity, forwardoffset, jukedistance);
                if (entity.juke == "forward") {
                    entity.juke = undefined;
                    entity.jukedistance = undefined;
                    return 0;
                }
            }
        }
    }
}

// Namespace zombiebehavior/zombie
// Params 1, eflags: 0x1 linked
// Checksum 0x9ae1beff, Offset: 0x4c30
// Size: 0xe
function zombiedeathaction(*entity) {
    return undefined;
}

// Namespace zombiebehavior/zombie
// Params 1, eflags: 0x1 linked
// Checksum 0xe4cbeb78, Offset: 0x4c48
// Size: 0x50
function waskilledbyinterdimensionalguncondition(entity) {
    if (isdefined(entity.interdimensional_gun_kill) && !isdefined(entity.killby_interdimensional_gun_hole) && isalive(entity)) {
        return true;
    }
    return false;
}

// Namespace zombiebehavior/zombie
// Params 1, eflags: 0x1 linked
// Checksum 0x65880ae7, Offset: 0x4ca0
// Size: 0x24
function wascrushedbyinterdimensionalgunblackholecondition(entity) {
    if (isdefined(entity.killby_interdimensional_gun_hole)) {
        return true;
    }
    return false;
}

// Namespace zombiebehavior/zombie
// Params 5, eflags: 0x1 linked
// Checksum 0xa0791cb1, Offset: 0x4cd0
// Size: 0xae
function zombieidgundeathmocompstart(entity, *mocompanim, *mocompanimblendouttime, *mocompanimflag, *mocompduration) {
    mocompduration orientmode("face angle", mocompduration.angles[1]);
    mocompduration animmode("noclip");
    mocompduration.pushable = 0;
    mocompduration.blockingpain = 1;
    mocompduration pathmode("dont move");
    mocompduration.hole_pull_speed = 0;
}

// Namespace zombiebehavior/zombie
// Params 5, eflags: 0x1 linked
// Checksum 0x669f2cb9, Offset: 0x4d88
// Size: 0xb6
function zombiemeleejumpmocompstart(entity, *mocompanim, *mocompanimblendouttime, *mocompanimflag, *mocompduration) {
    mocompduration orientmode("face enemy");
    mocompduration animmode("noclip", 0);
    mocompduration.pushable = 0;
    mocompduration.blockingpain = 1;
    mocompduration.clamptonavmesh = 0;
    mocompduration collidewithactors(0);
    mocompduration.jumpstartposition = mocompduration.origin;
}

// Namespace zombiebehavior/zombie
// Params 5, eflags: 0x1 linked
// Checksum 0x75353400, Offset: 0x4e48
// Size: 0x304
function zombiemeleejumpmocompupdate(entity, mocompanim, mocompanimblendouttime, *mocompanimflag, mocompduration) {
    normalizedtime = (mocompanim getanimtime(mocompanimblendouttime) * getanimlength(mocompanimblendouttime) + mocompanimflag) / mocompduration;
    if (normalizedtime > 0.5) {
        mocompanim orientmode("face angle", mocompanim.angles[1]);
    }
    speed = 5;
    if (isdefined(mocompanim.zombie_move_speed)) {
        switch (mocompanim.zombie_move_speed) {
        case #"walk":
            speed = 5;
            break;
        case #"run":
            speed = 6;
            break;
        case #"sprint":
            speed = 7;
            break;
        }
    }
    newposition = mocompanim.origin + anglestoforward(mocompanim.angles) * speed;
    newtestposition = (newposition[0], newposition[1], mocompanim.jumpstartposition[2]);
    newvalidposition = getclosestpointonnavmesh(newtestposition, 12, 20);
    if (isdefined(newvalidposition)) {
        newvalidposition = (newvalidposition[0], newvalidposition[1], mocompanim.origin[2]);
    } else {
        newvalidposition = mocompanim.origin;
    }
    if (!is_true(mocompanim.var_7c16e514)) {
        waterheight = getwaterheight(mocompanim.origin);
        if (newvalidposition[2] + mocompanim function_6a9ae71() > waterheight) {
            newvalidposition = (newvalidposition[0], newvalidposition[1], waterheight - mocompanim function_6a9ae71());
        }
    }
    groundpoint = getclosestpointonnavmesh(newvalidposition, 12, 20);
    if (isdefined(groundpoint) && groundpoint[2] > newvalidposition[2]) {
        newvalidposition = (newvalidposition[0], newvalidposition[1], groundpoint[2]);
    }
    mocompanim forceteleport(newvalidposition);
}

// Namespace zombiebehavior/zombie
// Params 5, eflags: 0x1 linked
// Checksum 0x8dc5d076, Offset: 0x5158
// Size: 0xb4
function zombiemeleejumpmocompterminate(entity, *mocompanim, *mocompanimblendouttime, *mocompanimflag, *mocompduration) {
    mocompduration.pushable = 1;
    mocompduration.blockingpain = 0;
    mocompduration.clamptonavmesh = 1;
    mocompduration collidewithactors(1);
    groundpoint = getclosestpointonnavmesh(mocompduration.origin, 12);
    if (isdefined(groundpoint)) {
        mocompduration forceteleport(groundpoint);
    }
}

// Namespace zombiebehavior/zombie
// Params 5, eflags: 0x1 linked
// Checksum 0xc72e0b15, Offset: 0x5218
// Size: 0x2f4
function zombieidgundeathupdate(entity, *mocompanim, *mocompanimblendouttime, *mocompanimflag, *mocompduration) {
    if (!isdefined(mocompduration.killby_interdimensional_gun_hole)) {
        entity_eye = mocompduration geteye();
        if (mocompduration.b_vortex_repositioned !== 1) {
            mocompduration.b_vortex_repositioned = 1;
            v_nearest_navmesh_point = getclosestpointonnavmesh(mocompduration.damageorigin, 36, 15);
            if (isdefined(v_nearest_navmesh_point)) {
                f_distance = distance(mocompduration.damageorigin, v_nearest_navmesh_point);
                if (f_distance < 41) {
                    mocompduration.damageorigin += (0, 0, 36);
                }
            }
        }
        entity_center = mocompduration.origin + (entity_eye - mocompduration.origin) / 2;
        flyingdir = mocompduration.damageorigin - entity_center;
        lengthfromhole = length(flyingdir);
        if (lengthfromhole < mocompduration.hole_pull_speed) {
            mocompduration.killby_interdimensional_gun_hole = 1;
            mocompduration.allowdeath = 1;
            mocompduration.takedamage = 1;
            mocompduration.aioverridedamage = undefined;
            mocompduration.magic_bullet_shield = 0;
            level notify(#"interdimensional_kill", {#entity:mocompduration});
            if (isdefined(mocompduration.interdimensional_gun_weapon) && isdefined(mocompduration.interdimensional_gun_attacker)) {
                mocompduration kill(mocompduration.origin, mocompduration.interdimensional_gun_attacker, mocompduration.interdimensional_gun_attacker, mocompduration.interdimensional_gun_weapon);
            } else {
                mocompduration kill(mocompduration.origin);
            }
            return;
        }
        if (mocompduration.hole_pull_speed < 12) {
            mocompduration.hole_pull_speed += 0.5;
            if (mocompduration.hole_pull_speed > 12) {
                mocompduration.hole_pull_speed = 12;
            }
        }
        flyingdir = vectornormalize(flyingdir);
        mocompduration forceteleport(mocompduration.origin + flyingdir * mocompduration.hole_pull_speed);
    }
}

// Namespace zombiebehavior/zombie
// Params 5, eflags: 0x1 linked
// Checksum 0x27409f91, Offset: 0x5518
// Size: 0x7e
function zombieidgunholedeathmocompstart(entity, *mocompanim, *mocompanimblendouttime, *mocompanimflag, *mocompduration) {
    mocompduration orientmode("face angle", mocompduration.angles[1]);
    mocompduration animmode("noclip");
    mocompduration.pushable = 0;
}

// Namespace zombiebehavior/zombie
// Params 5, eflags: 0x1 linked
// Checksum 0xbc024244, Offset: 0x55a0
// Size: 0x5c
function zombieidgunholedeathmocompterminate(entity, *mocompanim, *mocompanimblendouttime, *mocompanimflag, *mocompduration) {
    if (!is_true(mocompduration.interdimensional_gun_kill_vortex_explosion)) {
        mocompduration hide();
    }
}

// Namespace zombiebehavior/zombie
// Params 5, eflags: 0x5 linked
// Checksum 0x53a223d4, Offset: 0x5608
// Size: 0x74
function private zombieturnmocompstart(entity, *mocompanim, *mocompanimblendouttime, *mocompanimflag, *mocompduration) {
    mocompduration orientmode("face angle", mocompduration.angles[1]);
    mocompduration animmode("angle deltas", 0);
}

// Namespace zombiebehavior/zombie
// Params 5, eflags: 0x5 linked
// Checksum 0xc7ba9692, Offset: 0x5688
// Size: 0xa4
function private zombieturnmocompupdate(entity, mocompanim, mocompanimblendouttime, *mocompanimflag, mocompduration) {
    normalizedtime = (mocompanim getanimtime(mocompanimblendouttime) + mocompanimflag) / mocompduration;
    if (normalizedtime > 0.25) {
        mocompanim orientmode("face motion");
        mocompanim animmode("normal", 0);
    }
}

// Namespace zombiebehavior/zombie
// Params 5, eflags: 0x5 linked
// Checksum 0x9fc38cf0, Offset: 0x5738
// Size: 0x6c
function private zombieturnmocompterminate(entity, *mocompanim, *mocompanimblendouttime, *mocompanimflag, *mocompduration) {
    mocompduration orientmode("face motion");
    mocompduration animmode("normal", 0);
}

// Namespace zombiebehavior/zombie
// Params 1, eflags: 0x1 linked
// Checksum 0x2679f999, Offset: 0x57b0
// Size: 0x28
function zombiehaslegs(entity) {
    if (entity.missinglegs === 1) {
        return false;
    }
    return true;
}

// Namespace zombiebehavior/zombie
// Params 1, eflags: 0x1 linked
// Checksum 0xb7c5d40b, Offset: 0x57e0
// Size: 0x24
function zombiemissinglegs(entity) {
    return !zombiehaslegs(entity);
}

// Namespace zombiebehavior/zombie
// Params 1, eflags: 0x1 linked
// Checksum 0x3252663d, Offset: 0x5810
// Size: 0x62
function zombieshouldproceduraltraverse(entity) {
    return isdefined(entity.traversestartnode) && isdefined(entity.traverseendnode) && entity.traversestartnode.spawnflags & 1024 && entity.traverseendnode.spawnflags & 1024;
}

// Namespace zombiebehavior/zombie
// Params 1, eflags: 0x1 linked
// Checksum 0xe4174464, Offset: 0x5880
// Size: 0xb2
function zombieshouldmeleesuicide(entity) {
    if (!entity ai::get_behavior_attribute("suicidal_behavior")) {
        return false;
    }
    if (is_true(entity.magic_bullet_shield)) {
        return false;
    }
    if (!isdefined(entity.enemy)) {
        return false;
    }
    if (isdefined(entity.marked_for_death)) {
        return false;
    }
    if (distancesquared(entity.origin, entity.enemy.origin) > 40000) {
        return false;
    }
    return true;
}

// Namespace zombiebehavior/zombie
// Params 1, eflags: 0x1 linked
// Checksum 0x9626b596, Offset: 0x5940
// Size: 0x40
function zombiemeleesuicidestart(entity) {
    entity.blockingpain = 1;
    if (isdefined(level.zombiemeleesuicidecallback)) {
        entity thread [[ level.zombiemeleesuicidecallback ]](entity);
    }
}

// Namespace zombiebehavior/zombie
// Params 1, eflags: 0x1 linked
// Checksum 0xfe2563b3, Offset: 0x5988
// Size: 0xc
function zombiemeleesuicideupdate(*entity) {
    
}

// Namespace zombiebehavior/zombie
// Params 1, eflags: 0x1 linked
// Checksum 0x70d9629e, Offset: 0x59a0
// Size: 0x80
function zombiemeleesuicideterminate(entity) {
    if (isalive(entity) && zombieshouldmeleesuicide(entity)) {
        entity.takedamage = 1;
        entity.allowdeath = 1;
        if (isdefined(level.zombiemeleesuicidedonecallback)) {
            entity thread [[ level.zombiemeleesuicidedonecallback ]](entity);
        }
    }
}

// Namespace zombiebehavior/zombie
// Params 2, eflags: 0x1 linked
// Checksum 0x5377aba4, Offset: 0x5a28
// Size: 0x11a
function zombiemoveactionstart(entity, asmstatename) {
    function_ec25b529(entity);
    animationstatenetworkutility::requeststate(entity, asmstatename);
    if (is_true(entity.stumble) && !isdefined(entity.move_anim_end_time)) {
        stumbleactionresult = entity astsearch(asmstatename);
        stumbleactionanimation = animationstatenetworkutility::searchanimationmap(entity, stumbleactionresult[#"animation"]);
        entity.move_anim_end_time = entity.movetime + getanimlength(stumbleactionanimation);
    }
    entity.movetime = gettime();
    entity.moveorigin = entity.origin;
    entity.var_13138acf = 0;
    return 5;
}

// Namespace zombiebehavior/zombie
// Params 1, eflags: 0x1 linked
// Checksum 0xf15f7997, Offset: 0x5b50
// Size: 0x28
function function_a82068d7(entity) {
    function_ec25b529(entity);
    return true;
}

// Namespace zombiebehavior/zombie
// Params 1, eflags: 0x1 linked
// Checksum 0x47067bb5, Offset: 0x5b80
// Size: 0x26
function function_ec25b529(entity) {
    entity.movetime = gettime();
    entity.moveorigin = entity.origin;
}

// Namespace zombiebehavior/zombie
// Params 2, eflags: 0x1 linked
// Checksum 0xd295de00, Offset: 0x5bb0
// Size: 0xba
function zombiemoveactionupdate(entity, asmstatename) {
    if (isdefined(entity.move_anim_end_time) && gettime() >= entity.move_anim_end_time) {
        entity.move_anim_end_time = undefined;
        return 4;
    }
    function_26f9b8b1(entity);
    if (entity asmgetstatus() == "asm_status_complete") {
        if (entity iscurrentbtactionlooping()) {
            return zombiemoveactionstart(entity, asmstatename);
        } else {
            return 4;
        }
    }
    return 5;
}

// Namespace zombiebehavior/zombie
// Params 1, eflags: 0x1 linked
// Checksum 0xfe7a1369, Offset: 0x5c78
// Size: 0x28
function function_626edd6b(entity) {
    function_26f9b8b1(entity);
    return true;
}

// Namespace zombiebehavior/zombie
// Params 1, eflags: 0x1 linked
// Checksum 0xa23e7ac9, Offset: 0x5ca8
// Size: 0x19a
function function_26f9b8b1(entity) {
    if (!is_true(entity.missinglegs) && gettime() - entity.movetime > 1000) {
        distsq = distance2dsquared(entity.origin, entity.moveorigin);
        if (distsq < 144 && !is_true(entity.cant_move)) {
            entity.cant_move = 1;
            entity setavoidancemask("avoid all");
            /#
                record3dtext("<dev string:x76>", entity.origin, (0, 0, 1), "<dev string:x46>", entity);
            #/
            if (isdefined(entity.cant_move_cb)) {
                entity thread [[ entity.cant_move_cb ]]();
            }
        } else if (is_true(entity.cant_move)) {
            entity.cant_move = 0;
            entity setavoidancemask("avoid none");
            if (isdefined(entity.var_63d2fce2)) {
                entity thread [[ entity.var_63d2fce2 ]]();
            }
        }
        entity.movetime = gettime();
        entity.moveorigin = entity.origin;
    }
}

// Namespace zombiebehavior/zombie
// Params 2, eflags: 0x0
// Checksum 0x9bef6baf, Offset: 0x5e50
// Size: 0x50
function zombiemoveactionterminate(entity, *asmstatename) {
    if (!is_true(asmstatename.missinglegs)) {
        asmstatename setavoidancemask("avoid none");
    }
    return 4;
}

// Namespace zombiebehavior/zombie
// Params 0, eflags: 0x1 linked
// Checksum 0x9f395a57, Offset: 0x5ea8
// Size: 0xae
function function_79fe956f() {
    self notify("36149a7201e5e729");
    self endon("36149a7201e5e729");
    self endon(#"death");
    if (!isdefined(self.var_9ed3cc11)) {
        self.var_9ed3cc11 = self function_e827fc0e();
    }
    self pushplayer(1);
    wait 2;
    if (isdefined(self.var_9ed3cc11)) {
        self pushplayer(self.var_9ed3cc11);
        self.var_9ed3cc11 = undefined;
    }
}

// Namespace zombiebehavior/zombie
// Params 0, eflags: 0x1 linked
// Checksum 0xb890c52b, Offset: 0x5f60
// Size: 0x18e
function function_22762653() {
    self notify("4a15b7080a213a8a");
    self endon("4a15b7080a213a8a");
    self endon(#"death");
    var_159fa617 = 0;
    foreach (player in getplayers()) {
        if (player laststand::player_is_in_laststand()) {
            if (distancesquared(self.origin, player.origin) < 14400) {
                var_159fa617 = 1;
                break;
            }
        }
    }
    if (!var_159fa617) {
        return;
    }
    if (!isdefined(self.var_9ed3cc11)) {
        self.var_9ed3cc11 = self function_e827fc0e();
    }
    self pushplayer(1);
    wait 2;
    if (isdefined(self.var_9ed3cc11)) {
        self pushplayer(self.var_9ed3cc11);
        self.var_9ed3cc11 = undefined;
    }
}

// Namespace zombiebehavior/zombie
// Params 2, eflags: 0x1 linked
// Checksum 0xd6af2ee0, Offset: 0x60f8
// Size: 0x50
function function_9b6830c9(entity, asmstatename) {
    animationstatenetworkutility::requeststate(entity, asmstatename);
    entity pathmode("dont move");
    return 5;
}

// Namespace zombiebehavior/zombie
// Params 2, eflags: 0x1 linked
// Checksum 0xd4224f12, Offset: 0x6150
// Size: 0x38
function function_fbdc2cc4(entity, *asmstatename) {
    asmstatename pathmode("move allowed");
    return 4;
}

// Namespace zombiebehavior/zombie
// Params 0, eflags: 0x1 linked
// Checksum 0xa827a066, Offset: 0x6190
// Size: 0x24
function archetypezombiedeathoverrideinit() {
    aiutility::addaioverridekilledcallback(self, &zombiegibkilledanhilateoverride);
}

// Namespace zombiebehavior/zombie
// Params 8, eflags: 0x5 linked
// Checksum 0xceb9cc49, Offset: 0x61c0
// Size: 0x2e8
function private zombiegibkilledanhilateoverride(inflictor, attacker, damage, meansofdeath, weapon, *dir, *hitloc, *offsettime) {
    if (!is_true(level.zombieanhilationenabled)) {
        return dir;
    }
    if (is_true(self.forceanhilateondeath)) {
        self zombie_utility::gib_random_parts();
        gibserverutils::annihilate(self);
        return dir;
    }
    if (isdefined(weapon) && isplayer(weapon) && (is_true(weapon.forceanhilateondeath) || is_true(level.forceanhilateondeath))) {
        self zombie_utility::gib_random_parts();
        gibserverutils::annihilate(self);
        return dir;
    }
    attackerdistance = 0;
    if (isdefined(weapon)) {
        attackerdistance = distancesquared(weapon.origin, self.origin);
    }
    isexplosive = isinarray(array("MOD_CRUSH", "MOD_GRENADE", "MOD_GRENADE_SPLASH", "MOD_PROJECTILE", "MOD_PROJECTILE_SPLASH", "MOD_EXPLOSIVE"), hitloc);
    if (isdefined(offsettime.weapclass) && offsettime.weapclass == "turret") {
        if (isdefined(meansofdeath)) {
            isdirectexplosive = isinarray(array("MOD_GRENADE", "MOD_GRENADE_SPLASH", "MOD_PROJECTILE", "MOD_PROJECTILE_SPLASH", "MOD_EXPLOSIVE"), hitloc);
            iscloseexplosive = distancesquared(meansofdeath.origin, self.origin) <= function_a3f6cdac(60);
            if (isdirectexplosive && iscloseexplosive) {
                self zombie_utility::gib_random_parts();
                gibserverutils::annihilate(self);
            }
        }
    }
    return dir;
}

// Namespace zombiebehavior/zombie
// Params 5, eflags: 0x5 linked
// Checksum 0x389c7aa2, Offset: 0x64b0
// Size: 0x10c
function private zombiezombieidlemocompstart(entity, *mocompanim, *mocompanimblendouttime, *mocompanimflag, *mocompduration) {
    if (isdefined(mocompduration.enemyoverride) && isdefined(mocompduration.enemyoverride[1]) && mocompduration != mocompduration.enemyoverride[1]) {
        mocompduration orientmode("face direction", mocompduration.enemyoverride[1].origin - mocompduration.origin);
        mocompduration animmode("zonly_physics", 0);
        return;
    }
    mocompduration orientmode("face current");
    mocompduration animmode("zonly_physics", 0);
}

// Namespace zombiebehavior/zombie
// Params 5, eflags: 0x5 linked
// Checksum 0x9a691ad3, Offset: 0x65c8
// Size: 0xcc
function private zombieattackobjectmocompstart(entity, *mocompanim, *mocompanimblendouttime, *mocompanimflag, *mocompduration) {
    if (isdefined(mocompduration.attackable_slot)) {
        mocompduration orientmode("face angle", mocompduration.attackable_slot.angles[1]);
        mocompduration animmode("zonly_physics", 0);
        return;
    }
    mocompduration orientmode("face current");
    mocompduration animmode("zonly_physics", 0);
}

// Namespace zombiebehavior/zombie
// Params 5, eflags: 0x5 linked
// Checksum 0x90b8e2f3, Offset: 0x66a0
// Size: 0x64
function private zombieattackobjectmocompupdate(entity, *mocompanim, *mocompanimblendouttime, *mocompanimflag, *mocompduration) {
    if (isdefined(mocompduration.attackable_slot)) {
        mocompduration forceteleport(mocompduration.attackable_slot.origin);
    }
}

// Namespace zombiebehavior/zombie
// Params 5, eflags: 0x5 linked
// Checksum 0x6eb1cfb6, Offset: 0x6710
// Size: 0x19c
function private function_54d75299(entity, mocompanim, *mocompanimblendouttime, *mocompanimflag, *mocompduration) {
    if (isdefined(mocompanimflag.enemy)) {
        mocompanimflag orientmode("face enemy");
    }
    mocompanimflag animmode("zonly_physics", 1);
    mocompanimflag pathmode("dont move");
    localdeltahalfvector = getmovedelta(mocompduration, 0, 0.9);
    endpoint = mocompanimflag localtoworldcoords(localdeltahalfvector);
    /#
        recordcircle(endpoint, 3, (1, 0, 0), "<dev string:x9e>");
        recordline(mocompanimflag.origin, endpoint, (1, 0, 0), "<dev string:x9e>");
        record3dtext("<dev string:xa8>" + distance(mocompanimflag.origin, endpoint) + "<dev string:xb1>" + function_9e72a96(mocompduration), endpoint, (1, 0, 0), "<dev string:x46>");
    #/
}

// Namespace zombiebehavior/zombie
// Params 5, eflags: 0x5 linked
// Checksum 0x65851379, Offset: 0x68b8
// Size: 0x4c
function private function_d1474842(entity, *mocompanim, *mocompanimblendouttime, *mocompanimflag, *mocompduration) {
    mocompduration pathmode("dont move");
}

// Namespace zombiebehavior/zombie
// Params 5, eflags: 0x5 linked
// Checksum 0x468024e0, Offset: 0x6910
// Size: 0x4c
function private function_b6d297bb(entity, *mocompanim, *mocompanimblendouttime, *mocompanimflag, *mocompduration) {
    mocompduration pathmode("move allowed");
}

// Namespace zombiebehavior/zombie
// Params 5, eflags: 0x5 linked
// Checksum 0x35e03518, Offset: 0x6968
// Size: 0x174
function private function_cbbae5cb(entity, *mocompanim, *mocompanimblendouttime, *mocompanimflag, *mocompduration) {
    mocompduration orientmode("face angle", mocompduration.angles[1]);
    mocompduration animmode("normal");
    if (isdefined(mocompduration.traverseendnode)) {
        /#
            print3d(mocompduration.traversestartnode.origin, "<dev string:xbb>", (1, 0, 0), 1, 1, 60);
            print3d(mocompduration.traverseendnode.origin, "<dev string:xbb>", (0, 1, 0), 1, 1, 60);
            line(mocompduration.traversestartnode.origin, mocompduration.traverseendnode.origin, (0, 1, 0), 1, 0, 60);
        #/
        mocompduration forceteleport(mocompduration.traverseendnode.origin, mocompduration.traverseendnode.angles, 0);
    }
}

// Namespace zombiebehavior/zombie
// Params 4, eflags: 0x1 linked
// Checksum 0xbd76b3a4, Offset: 0x6ae8
// Size: 0x11c
function function_db26137a(entity, *attribute, *oldvalue, value) {
    if (value == "low") {
        self.low_gravity = 1;
        if (!isdefined(self.low_gravity_variant) && isdefined(level.var_d9ffddf4)) {
            if (is_true(self.missinglegs)) {
                self.low_gravity_variant = randomint(level.var_d9ffddf4[#"crawl"]);
            } else {
                self.low_gravity_variant = randomint(level.var_d9ffddf4[self.zombie_move_speed]);
            }
        }
    } else if (value == "normal") {
        self.low_gravity = 0;
    }
    oldvalue setblackboardattribute("_low_gravity", value);
}

