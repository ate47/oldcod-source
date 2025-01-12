#using scripts\core_common\ai\archetype_damage_utility;
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
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\spawner_shared;

#namespace zombiebehavior;

// Namespace zombiebehavior/zombie
// Params 0, eflags: 0x2
// Checksum 0x7cead911, Offset: 0x410
// Size: 0x154
function autoexec init() {
    initzombiebehaviorsandasm();
    spawner::add_archetype_spawn_function("zombie", &archetypezombieblackboardinit);
    spawner::add_archetype_spawn_function("zombie", &archetypezombiedeathoverrideinit);
    spawner::add_archetype_spawn_function("zombie", &archetypezombiespecialeffectsinit);
    spawner::add_archetype_spawn_function("zombie", &zombie_utility::zombiespawnsetup);
    /#
        spawner::add_archetype_spawn_function("<dev string:x30>", &zombie_utility::updateanimationrate);
    #/
    clientfield::register("actor", "zombie", 1, 1, "int");
    clientfield::register("actor", "zombie_special_day", 1, 1, "counter");
    zombieinterface::registerzombieinterfaceattributes();
}

// Namespace zombiebehavior/zombie
// Params 0, eflags: 0x4
// Checksum 0x79a8eea5, Offset: 0x570
// Size: 0x1464
function private initzombiebehaviorsandasm() {
    assert(!isdefined(&zombiemoveactionstart) || isscriptfunctionptr(&zombiemoveactionstart));
    assert(!isdefined(&zombiemoveactionupdate) || isscriptfunctionptr(&zombiemoveactionupdate));
    assert(!isdefined(undefined) || isscriptfunctionptr(undefined));
    behaviortreenetworkutility::registerbehaviortreeaction(#"zombiemoveaction", &zombiemoveactionstart, &zombiemoveactionupdate, undefined);
    assert(!isdefined(&function_f190c31) || isscriptfunctionptr(&function_f190c31));
    assert(!isdefined(undefined) || isscriptfunctionptr(undefined));
    assert(!isdefined(&function_14c6cbd0) || isscriptfunctionptr(&function_14c6cbd0));
    behaviortreenetworkutility::registerbehaviortreeaction(#"zombiemeleeaction", &function_f190c31, undefined, &function_14c6cbd0);
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
    assert(isscriptfunctionptr(&function_cb9c6d96));
    behaviorstatemachine::registerbsmscriptapiinternal(#"hash_4ba5bc2aba9e7670", &function_cb9c6d96);
    assert(isscriptfunctionptr(&function_d491a112));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_4136381d29600bc", &function_d491a112);
    assert(isscriptfunctionptr(&function_93c2c270));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_1732367c7f780c76", &function_93c2c270);
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
    assert(isscriptfunctionptr(&function_c27664bc));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_31cc70f275702cf6", &function_c27664bc);
    assert(isscriptfunctionptr(&function_19afea9a));
    behaviorstatemachine::registerbsmscriptapiinternal(#"zombiemoveactionstart", &function_19afea9a);
    assert(isscriptfunctionptr(&function_70c09995));
    behaviorstatemachine::registerbsmscriptapiinternal(#"zombiemoveactionupdate", &function_70c09995);
    animationstatenetwork::registernotetrackhandlerfunction("zombie_melee", &zombienotetrackmeleefire);
    animationstatenetwork::registernotetrackhandlerfunction("crushed", &zombienotetrackcrushfire);
    animationstatenetwork::registeranimationmocomp("mocomp_death_idgun@zombie", &zombieidgundeathmocompstart, undefined, undefined);
    animationstatenetwork::registeranimationmocomp("mocomp_vortex_pull@zombie", &zombieidgundeathmocompstart, undefined, undefined);
    animationstatenetwork::registeranimationmocomp("mocomp_death_idgun_hole@zombie", &zombieidgunholedeathmocompstart, undefined, &zombieidgunholedeathmocompterminate);
    animationstatenetwork::registeranimationmocomp("mocomp_turn@zombie", &zombieturnmocompstart, &zombieturnmocompupdate, &zombieturnmocompterminate);
    animationstatenetwork::registeranimationmocomp("mocomp_melee_jump@zombie", &zombiemeleejumpmocompstart, &zombiemeleejumpmocompupdate, &zombiemeleejumpmocompterminate);
    animationstatenetwork::registeranimationmocomp("mocomp_zombie_idle@zombie", &zombiezombieidlemocompstart, undefined, undefined);
    animationstatenetwork::registeranimationmocomp("mocomp_attack_object@zombie", &zombieattackobjectmocompstart, &zombieattackobjectmocompupdate, undefined);
    animationstatenetwork::registeranimationmocomp("mocomp_teleport_traversal@zombie", &function_92fcc873, undefined, undefined);
    animationstatenetwork::registeranimationmocomp("mocomp_zombie_melee@zombie", &function_2b5c772b, &function_e5505e1e, &function_e81d088);
}

// Namespace zombiebehavior/zombie
// Params 0, eflags: 0x0
// Checksum 0xdf7f11be, Offset: 0x19e0
// Size: 0x4a
function archetypezombieblackboardinit() {
    blackboard::createblackboardforentity(self);
    ai::createinterfaceforentity(self);
    self.___archetypeonanimscriptedcallback = &archetypezombieonanimscriptedcallback;
}

// Namespace zombiebehavior/zombie
// Params 1, eflags: 0x4
// Checksum 0x9120ff4a, Offset: 0x1a38
// Size: 0x2c
function private archetypezombieonanimscriptedcallback(entity) {
    entity.__blackboard = undefined;
    entity archetypezombieblackboardinit();
}

// Namespace zombiebehavior/zombie
// Params 0, eflags: 0x0
// Checksum 0xa220e250, Offset: 0x1a70
// Size: 0x24
function archetypezombiespecialeffectsinit() {
    aiutility::addaioverridedamagecallback(self, &archetypezombiespecialeffectscallback);
}

// Namespace zombiebehavior/zombie
// Params 13, eflags: 0x4
// Checksum 0x860573b8, Offset: 0x1aa0
// Size: 0x100
function private archetypezombiespecialeffectscallback(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, damagefromunderneath, modelindex, partname) {
    specialdayeffectchance = getdvarint(#"tu6_ffotd_zombiespecialdayeffectschance", 0);
    if (specialdayeffectchance && randomint(100) < specialdayeffectchance) {
        if (isdefined(eattacker) && isplayer(eattacker)) {
            self clientfield::increment("zombie_special_day");
        }
    }
    return idamage;
}

// Namespace zombiebehavior/zombie
// Params 0, eflags: 0x0
// Checksum 0x42ef1ffc, Offset: 0x1ba8
// Size: 0x1a
function bb_getvarianttype() {
    if (isdefined(self.variant_type)) {
        return self.variant_type;
    }
    return 0;
}

// Namespace zombiebehavior/zombie
// Params 0, eflags: 0x0
// Checksum 0x1386a9ca, Offset: 0x1bd0
// Size: 0x1a
function bb_getlowgravityvariant() {
    if (isdefined(self.low_gravity_variant)) {
        return self.low_gravity_variant;
    }
    return 0;
}

// Namespace zombiebehavior/zombie
// Params 1, eflags: 0x0
// Checksum 0xdae2ff2a, Offset: 0x1bf8
// Size: 0x2a
function iszombiewalking(entity) {
    return !(isdefined(entity.missinglegs) && entity.missinglegs);
}

// Namespace zombiebehavior/zombie
// Params 1, eflags: 0x0
// Checksum 0x5ba28b6e, Offset: 0x1c30
// Size: 0x8e
function zombieshoulddisplaypain(entity) {
    if (isdefined(entity.suicidaldeath) && entity.suicidaldeath) {
        return false;
    }
    if (!hasasm(entity) || entity function_e0952d0a() < 1) {
        return false;
    }
    return !(isdefined(entity.missinglegs) && entity.missinglegs);
}

// Namespace zombiebehavior/zombie
// Params 1, eflags: 0x0
// Checksum 0x4dfa7341, Offset: 0x1cc8
// Size: 0x58
function zombieshouldjukecondition(entity) {
    if (isdefined(entity.juke) && (entity.juke == "left" || entity.juke == "right")) {
        return true;
    }
    return false;
}

// Namespace zombiebehavior/zombie
// Params 1, eflags: 0x0
// Checksum 0xe1f351a7, Offset: 0x1d28
// Size: 0x24
function zombieshouldstumblecondition(entity) {
    if (isdefined(entity.stumble)) {
        return true;
    }
    return false;
}

// Namespace zombiebehavior/zombie
// Params 1, eflags: 0x4
// Checksum 0x96800792, Offset: 0x1d58
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
// Params 1, eflags: 0x4
// Checksum 0x3673ad4, Offset: 0x1e10
// Size: 0x24
function private zombiejukeactionterminate(entity) {
    entity clearpath();
}

// Namespace zombiebehavior/zombie
// Params 1, eflags: 0x4
// Checksum 0x2bd9f2c2, Offset: 0x1e40
// Size: 0x16
function private zombiestumbleactionstart(entity) {
    entity.stumble = undefined;
}

// Namespace zombiebehavior/zombie
// Params 1, eflags: 0x4
// Checksum 0xa29954f0, Offset: 0x1e60
// Size: 0x1a
function private zombieattackobjectstart(entity) {
    entity.is_inert = 1;
}

// Namespace zombiebehavior/zombie
// Params 1, eflags: 0x4
// Checksum 0x52016828, Offset: 0x1e88
// Size: 0x1a
function private zombieattackobjectterminate(entity) {
    entity.is_inert = 0;
}

// Namespace zombiebehavior/zombie
// Params 1, eflags: 0x0
// Checksum 0xa5cbdf6b, Offset: 0x1eb0
// Size: 0x44
function zombiegiblegscondition(entity) {
    return gibserverutils::isgibbed(entity, 256) || gibserverutils::isgibbed(entity, 128);
}

// Namespace zombiebehavior/zombie
// Params 1, eflags: 0x0
// Checksum 0x6741a3ee, Offset: 0x1f00
// Size: 0x22
function function_c27664bc(entity) {
    entity.ai.var_265e0488 = gettime();
}

// Namespace zombiebehavior/zombie
// Params 1, eflags: 0x0
// Checksum 0x666b385c, Offset: 0x1f30
// Size: 0x3f0
function zombienotetrackmeleefire(entity) {
    entity.melee_cooldown = gettime() + getdvarfloat(#"scr_zombiemeleecooldown", 1) * 1000;
    if (isdefined(entity.aat_turned) && entity.aat_turned) {
        if (isdefined(entity.enemy) && isalive(entity.enemy) && !isplayer(entity.enemy)) {
            if (isdefined(entity.var_7d06ae6a) && entity.var_7d06ae6a && isdefined(entity.enemy.allowdeath) && entity.enemy.allowdeath) {
                if (isdefined(entity.var_fcc82858)) {
                    e_attacker = entity.var_fcc82858;
                } else {
                    e_attacker = entity;
                }
                gibserverutils::gibhead(entity.enemy);
                entity.enemy zombie_utility::gib_random_parts();
                entity.enemy.var_74df1377 = 1;
                entity.enemy kill(entity.enemy.origin, e_attacker, e_attacker, undefined, undefined, 1);
                entity.n_aat_turned_zombie_kills++;
            } else if (isdefined(entity.enemy.canbetargetedbyturnedzombies) && entity.enemy.canbetargetedbyturnedzombies) {
                entity melee();
            }
        }
        return;
    }
    if (isdefined(entity.enemy) && isdefined(entity.enemy.ignoreme) && entity.enemy.ignoreme) {
        return;
    }
    if (isdefined(entity.ai.var_265e0488)) {
        /#
            record3dtext("<dev string:x37>" + gettime() - entity.ai.var_265e0488, self.origin, (1, 0, 0), "<dev string:x42>", entity);
        #/
    }
    entity melee();
    /#
        record3dtext("<dev string:x49>", entity.origin, (1, 0, 0), "<dev string:x42>", entity);
        if (isdefined(entity.enemy)) {
            eyepos = entity geteye();
            record3dtext("<dev string:x4f>" + distance2d(eyepos, entity.enemy.origin), entity.origin, (1, 0, 0), "<dev string:x42>", entity);
        }
    #/
    if (zombieshouldattackobject(entity)) {
        if (isdefined(level.attackablecallback)) {
            entity.attackable [[ level.attackablecallback ]](entity);
        }
    }
}

// Namespace zombiebehavior/zombie
// Params 1, eflags: 0x0
// Checksum 0x5f1738f3, Offset: 0x2328
// Size: 0x24
function zombienotetrackcrushfire(entity) {
    entity delete();
}

// Namespace zombiebehavior/zombie
// Params 1, eflags: 0x0
// Checksum 0xeac09a05, Offset: 0x2358
// Size: 0x258
function zombietargetservice(entity) {
    if (isdefined(entity.enablepushtime)) {
        if (gettime() >= entity.enablepushtime) {
            entity collidewithactors(1);
            entity.enablepushtime = undefined;
        }
    }
    if (isdefined(entity.disabletargetservice) && entity.disabletargetservice) {
        return 0;
    }
    if (isdefined(entity.ignoreall) && entity.ignoreall) {
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
        if (!(isdefined(self.zombie_do_not_update_goal) && self.zombie_do_not_update_goal)) {
            if (isdefined(level.zombie_use_zigzag_path) && level.zombie_use_zigzag_path) {
                entity zombieupdatezigzaggoal();
            } else {
                entity setgoal(player.last_valid_position);
            }
        }
        return 1;
    }
    if (!(isdefined(self.zombie_do_not_update_goal) && self.zombie_do_not_update_goal)) {
        entity setgoal(entity.origin);
    }
    return 0;
}

// Namespace zombiebehavior/zombie
// Params 0, eflags: 0x0
// Checksum 0xba33fba, Offset: 0x25b8
// Size: 0x5cc
function zombieupdatezigzaggoal() {
    aiprofile_beginentry("zombieUpdateZigZagGoal");
    shouldrepath = 0;
    if (!shouldrepath && isdefined(self.favoriteenemy)) {
        if (!isdefined(self.nextgoalupdate) || self.nextgoalupdate <= gettime()) {
            shouldrepath = 1;
        } else if (distancesquared(self.origin, self.favoriteenemy.origin) <= 250 * 250) {
            shouldrepath = 1;
        } else if (isdefined(self.pathgoalpos)) {
            distancetogoalsqr = distancesquared(self.origin, self.pathgoalpos);
            shouldrepath = distancetogoalsqr < 72 * 72;
        }
    }
    if (isdefined(self.keep_moving) && self.keep_moving) {
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
        if (distancesquared(self.origin, goalpos) > 250 * 250) {
            self.keep_moving = 1;
            self.keep_moving_time = gettime() + 250;
            path = self calcapproximatepathtoposition(goalpos, 0);
            /#
                if (getdvarint(#"ai_debugzigzag", 0)) {
                    for (index = 1; index < path.size; index++) {
                        recordline(path[index - 1], path[index], (1, 0.5, 0), "<dev string:x5b>", self);
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
                        recordcircle(seedposition, 2, (1, 0.5, 0), "<dev string:x5b>", self);
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
// Params 1, eflags: 0x0
// Checksum 0xc7111bcc, Offset: 0x2b90
// Size: 0x1ee
function zombiecrawlercollision(entity) {
    if (!(isdefined(entity.missinglegs) && entity.missinglegs) && !(isdefined(entity.knockdown) && entity.knockdown)) {
        return false;
    }
    if (isdefined(entity.dontpushtime)) {
        if (gettime() < entity.dontpushtime) {
            return true;
        }
    }
    zombies = getaiteamarray(level.zombie_team);
    foreach (zombie in zombies) {
        if (zombie == entity) {
            continue;
        }
        if (isdefined(zombie.missinglegs) && zombie.missinglegs || isdefined(zombie.knockdown) && zombie.knockdown) {
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
// Params 1, eflags: 0x0
// Checksum 0x6ecc6c8d, Offset: 0x2d88
// Size: 0x3c
function zombietraversalservice(entity) {
    if (isdefined(entity.traversestartnode)) {
        entity collidewithactors(0);
        return true;
    }
    return false;
}

// Namespace zombiebehavior/zombie
// Params 1, eflags: 0x0
// Checksum 0x849120a9, Offset: 0x2dd0
// Size: 0x1ca
function zombieisatattackobject(entity) {
    if (isdefined(entity.missinglegs) && entity.missinglegs) {
        return false;
    }
    if (isdefined(entity.enemyoverride) && isdefined(entity.enemyoverride[1])) {
        return false;
    }
    if (isdefined(entity.favoriteenemy) && isdefined(entity.favoriteenemy.b_is_designated_target) && entity.favoriteenemy.b_is_designated_target) {
        return false;
    }
    if (isdefined(entity.aat_turned) && entity.aat_turned) {
        return false;
    }
    if (isdefined(entity.attackable) && isdefined(entity.attackable.is_active) && entity.attackable.is_active) {
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
// Params 1, eflags: 0x0
// Checksum 0x9c86b14a, Offset: 0x2fa8
// Size: 0x134
function zombieshouldattackobject(entity) {
    if (isdefined(entity.missinglegs) && entity.missinglegs) {
        return false;
    }
    if (isdefined(entity.enemyoverride) && isdefined(entity.enemyoverride[1])) {
        return false;
    }
    if (isdefined(entity.favoriteenemy) && isdefined(entity.favoriteenemy.b_is_designated_target) && entity.favoriteenemy.b_is_designated_target) {
        return false;
    }
    if (isdefined(entity.aat_turned) && entity.aat_turned) {
        return false;
    }
    if (isdefined(entity.attackable) && isdefined(entity.attackable.is_active) && entity.attackable.is_active) {
        if (isdefined(entity.is_at_attackable) && entity.is_at_attackable) {
            return true;
        }
    }
    return false;
}

// Namespace zombiebehavior/zombie
// Params 1, eflags: 0x0
// Checksum 0xc06c28e4, Offset: 0x30e8
// Size: 0x110
function function_e3f0cca3(entity) {
    if (entity.archetype == "zombie" && !isdefined(entity.var_ea94c12a) && !(isdefined(self.missinglegs) && self.missinglegs)) {
        if (entity.zombie_move_speed == "walk") {
            return (100 * 100);
        } else if (entity.zombie_move_speed == "run") {
            return (120 * 120);
        }
        return (100 * 100);
    }
    if (isdefined(entity.meleeweapon) && entity.meleeweapon !== level.weaponnone) {
        meleedistsq = entity.meleeweapon.aimeleerange * entity.meleeweapon.aimeleerange;
    }
    return meleedistsq;
}

// Namespace zombiebehavior/zombie
// Params 1, eflags: 0x0
// Checksum 0xa5234722, Offset: 0x3200
// Size: 0x2d6
function zombieshouldmeleecondition(entity) {
    if (isdefined(entity.enemyoverride) && isdefined(entity.enemyoverride[1])) {
        return false;
    }
    if (!isdefined(entity.enemy)) {
        return false;
    }
    if (isdefined(entity.marked_for_death)) {
        return false;
    }
    if (isdefined(entity.ignoremelee) && entity.ignoremelee) {
        return false;
    }
    if (abs(entity.origin[2] - entity.enemy.origin[2]) > (isdefined(entity.var_6b113703) ? entity.var_6b113703 : 64)) {
        return false;
    }
    meleedistsq = function_e3f0cca3(entity);
    if (distancesquared(entity.origin, entity.enemy.origin) > meleedistsq) {
        return false;
    }
    yawtoenemy = angleclamp180(entity.angles[1] - vectortoangles(entity.enemy.origin - entity.origin)[1]);
    if (abs(yawtoenemy) > (isdefined(entity.var_f33b7054) ? entity.var_f33b7054 : 60)) {
        return false;
    }
    if (!entity cansee(entity.enemy)) {
        return false;
    }
    if (distancesquared(entity.origin, entity.enemy.origin) < 40 * 40) {
        return true;
    }
    if (!tracepassedonnavmesh(entity.origin, isdefined(entity.enemy.last_valid_position) ? entity.enemy.last_valid_position : entity.enemy.origin, entity.enemy getpathfindingradius())) {
        return false;
    }
    return true;
}

// Namespace zombiebehavior/zombie
// Params 1, eflags: 0x4
// Checksum 0x41e06285, Offset: 0x34e0
// Size: 0x7a
function private function_d491a112(entity) {
    /#
        if (getdvarint(#"hash_1a5939d8c37a2e07", 0)) {
            return false;
        }
    #/
    var_764e42f0 = blackboard::getblackboardevents("zombie_full_pain");
    if (isdefined(var_764e42f0) && var_764e42f0.size) {
        return false;
    }
    return true;
}

// Namespace zombiebehavior/zombie
// Params 1, eflags: 0x4
// Checksum 0x4aef80df, Offset: 0x3568
// Size: 0x74
function private function_93c2c270(entity) {
    var_b316d7b2 = spawnstruct();
    var_b316d7b2.enemy = entity.enemy;
    blackboard::addblackboardevent("zombie_full_pain", var_b316d7b2, randomintrange(6000, 9000));
}

// Namespace zombiebehavior/zombie
// Params 1, eflags: 0x4
// Checksum 0x7db16e55, Offset: 0x35e8
// Size: 0x28
function private zombieshouldmovelowg(entity) {
    return isdefined(entity.low_gravity) && entity.low_gravity;
}

// Namespace zombiebehavior/zombie
// Params 1, eflags: 0x4
// Checksum 0x7cb02622, Offset: 0x3618
// Size: 0x30
function private zombieshouldturn(entity) {
    return !isdefined(entity.turn_cooldown) || entity.turn_cooldown < gettime();
}

// Namespace zombiebehavior/zombie
// Params 1, eflags: 0x4
// Checksum 0x100a77cc, Offset: 0x3650
// Size: 0x22
function private function_cb9c6d96(entity) {
    entity.turn_cooldown = gettime() + 1000;
    return true;
}

// Namespace zombiebehavior/zombie
// Params 1, eflags: 0x0
// Checksum 0x5272116b, Offset: 0x3680
// Size: 0x2f0
function zombieshouldjumpmeleecondition(entity) {
    if (!(isdefined(entity.low_gravity) && entity.low_gravity)) {
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
    if (isdefined(entity.ignoremelee) && entity.ignoremelee) {
        return false;
    }
    if (entity.enemy isonground()) {
        return false;
    }
    jumpchance = getdvarfloat(#"zmmeleejumpchance", 0.5);
    if (entity getentitynumber() % 10 / 10 > jumpchance) {
        return false;
    }
    predictedposition = entity.enemy.origin + entity.enemy getvelocity() * float(function_f9f48566()) / 1000 * 2;
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
// Params 1, eflags: 0x0
// Checksum 0x4b271f61, Offset: 0x3978
// Size: 0x250
function zombieshouldjumpunderwatermelee(entity) {
    if (isdefined(entity.enemyoverride) && isdefined(entity.enemyoverride[1])) {
        return false;
    }
    if (isdefined(entity.ignoreall) && entity.ignoreall) {
        return false;
    }
    if (!isdefined(entity.enemy)) {
        return false;
    }
    if (isdefined(entity.marked_for_death)) {
        return false;
    }
    if (isdefined(entity.ignoremelee) && entity.ignoremelee) {
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
// Params 1, eflags: 0x0
// Checksum 0xf8eff0e8, Offset: 0x3bd0
// Size: 0x1a2
function zombiestumble(entity) {
    if (isdefined(entity.missinglegs) && entity.missinglegs) {
        return false;
    }
    if (!(isdefined(entity.canstumble) && entity.canstumble)) {
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
// Params 1, eflags: 0x0
// Checksum 0x7b668de2, Offset: 0x3d80
// Size: 0x3c2
function zombiejuke(entity) {
    if (!entity ai::has_behavior_attribute("can_juke")) {
        return 0;
    }
    if (!entity ai::get_behavior_attribute("can_juke")) {
        return 0;
    }
    if (isdefined(entity.missinglegs) && entity.missinglegs) {
        return 0;
    }
    if (entity aiutility::function_d0d49a4e() != "locomotion_speed_walk") {
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
                switch (entity aiutility::function_d0d49a4e()) {
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
                switch (entity aiutility::function_d0d49a4e()) {
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
// Params 1, eflags: 0x0
// Checksum 0x962ca69c, Offset: 0x4150
// Size: 0xc
function zombiedeathaction(entity) {
    
}

// Namespace zombiebehavior/zombie
// Params 1, eflags: 0x0
// Checksum 0x679f495d, Offset: 0x4168
// Size: 0x50
function waskilledbyinterdimensionalguncondition(entity) {
    if (isdefined(entity.interdimensional_gun_kill) && !isdefined(entity.killby_interdimensional_gun_hole) && isalive(entity)) {
        return true;
    }
    return false;
}

// Namespace zombiebehavior/zombie
// Params 1, eflags: 0x0
// Checksum 0x579f8a4b, Offset: 0x41c0
// Size: 0x24
function wascrushedbyinterdimensionalgunblackholecondition(entity) {
    if (isdefined(entity.killby_interdimensional_gun_hole)) {
        return true;
    }
    return false;
}

// Namespace zombiebehavior/zombie
// Params 5, eflags: 0x0
// Checksum 0xc9835663, Offset: 0x41f0
// Size: 0xc2
function zombieidgundeathmocompstart(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
    entity orientmode("face angle", entity.angles[1]);
    entity animmode("noclip");
    entity.pushable = 0;
    entity.blockingpain = 1;
    entity pathmode("dont move");
    entity.hole_pull_speed = 0;
}

// Namespace zombiebehavior/zombie
// Params 5, eflags: 0x0
// Checksum 0xaf179139, Offset: 0x42c0
// Size: 0xc2
function zombiemeleejumpmocompstart(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
    entity orientmode("face enemy");
    entity animmode("noclip", 0);
    entity.pushable = 0;
    entity.blockingpain = 1;
    entity.clamptonavmesh = 0;
    entity collidewithactors(0);
    entity.jumpstartposition = entity.origin;
}

// Namespace zombiebehavior/zombie
// Params 5, eflags: 0x0
// Checksum 0x99f6dc1a, Offset: 0x4390
// Size: 0x30c
function zombiemeleejumpmocompupdate(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
    normalizedtime = (entity getanimtime(mocompanim) * getanimlength(mocompanim) + mocompanimblendouttime) / mocompduration;
    if (normalizedtime > 0.5) {
        entity orientmode("face angle", entity.angles[1]);
    }
    speed = 5;
    if (isdefined(entity.zombie_move_speed)) {
        switch (entity.zombie_move_speed) {
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
    newposition = entity.origin + anglestoforward(entity.angles) * speed;
    newtestposition = (newposition[0], newposition[1], entity.jumpstartposition[2]);
    newvalidposition = getclosestpointonnavmesh(newtestposition, 12, 20);
    if (isdefined(newvalidposition)) {
        newvalidposition = (newvalidposition[0], newvalidposition[1], entity.origin[2]);
    } else {
        newvalidposition = entity.origin;
    }
    waterheight = getwaterheight(entity.origin);
    if (newvalidposition[2] + entity function_5c52d4ac() > waterheight) {
        newvalidposition = (newvalidposition[0], newvalidposition[1], waterheight - entity function_5c52d4ac());
    }
    groundpoint = getclosestpointonnavmesh(newvalidposition, 12, 20);
    if (isdefined(groundpoint) && groundpoint[2] > newvalidposition[2]) {
        newvalidposition = (newvalidposition[0], newvalidposition[1], groundpoint[2]);
    }
    entity forceteleport(newvalidposition);
}

// Namespace zombiebehavior/zombie
// Params 5, eflags: 0x0
// Checksum 0xe247bee4, Offset: 0x46a8
// Size: 0xbc
function zombiemeleejumpmocompterminate(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
    entity.pushable = 1;
    entity.blockingpain = 0;
    entity.clamptonavmesh = 1;
    entity collidewithactors(1);
    groundpoint = getclosestpointonnavmesh(entity.origin, 12);
    if (isdefined(groundpoint)) {
        entity forceteleport(groundpoint);
    }
}

// Namespace zombiebehavior/zombie
// Params 5, eflags: 0x0
// Checksum 0x817bbf00, Offset: 0x4770
// Size: 0x334
function zombieidgundeathupdate(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
    if (!isdefined(entity.killby_interdimensional_gun_hole)) {
        entity_eye = entity geteye();
        if (entity.b_vortex_repositioned !== 1) {
            entity.b_vortex_repositioned = 1;
            v_nearest_navmesh_point = getclosestpointonnavmesh(entity.damageorigin, 36, 15);
            if (isdefined(v_nearest_navmesh_point)) {
                f_distance = distance(entity.damageorigin, v_nearest_navmesh_point);
                if (f_distance < 41) {
                    entity.damageorigin += (0, 0, 36);
                }
            }
        }
        entity_center = entity.origin + (entity_eye - entity.origin) / 2;
        flyingdir = entity.damageorigin - entity_center;
        lengthfromhole = length(flyingdir);
        if (lengthfromhole < entity.hole_pull_speed) {
            entity.killby_interdimensional_gun_hole = 1;
            entity.allowdeath = 1;
            entity.takedamage = 1;
            entity.aioverridedamage = undefined;
            entity.magic_bullet_shield = 0;
            level notify(#"interdimensional_kill", {#entity:entity});
            if (isdefined(entity.interdimensional_gun_weapon) && isdefined(entity.interdimensional_gun_attacker)) {
                entity kill(entity.origin, entity.interdimensional_gun_attacker, entity.interdimensional_gun_attacker, entity.interdimensional_gun_weapon);
            } else {
                entity kill(entity.origin);
            }
            return;
        }
        if (entity.hole_pull_speed < 12) {
            entity.hole_pull_speed += 0.5;
            if (entity.hole_pull_speed > 12) {
                entity.hole_pull_speed = 12;
            }
        }
        flyingdir = vectornormalize(flyingdir);
        entity forceteleport(entity.origin + flyingdir * entity.hole_pull_speed);
    }
}

// Namespace zombiebehavior/zombie
// Params 5, eflags: 0x0
// Checksum 0x7cd2a03e, Offset: 0x4ab0
// Size: 0x8a
function zombieidgunholedeathmocompstart(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
    entity orientmode("face angle", entity.angles[1]);
    entity animmode("noclip");
    entity.pushable = 0;
}

// Namespace zombiebehavior/zombie
// Params 5, eflags: 0x0
// Checksum 0xf09bf63c, Offset: 0x4b48
// Size: 0x64
function zombieidgunholedeathmocompterminate(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
    if (!(isdefined(entity.interdimensional_gun_kill_vortex_explosion) && entity.interdimensional_gun_kill_vortex_explosion)) {
        entity hide();
    }
}

// Namespace zombiebehavior/zombie
// Params 5, eflags: 0x4
// Checksum 0x964e6828, Offset: 0x4bb8
// Size: 0x7c
function private zombieturnmocompstart(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
    entity orientmode("face angle", entity.angles[1]);
    entity animmode("angle deltas", 0);
}

// Namespace zombiebehavior/zombie
// Params 5, eflags: 0x4
// Checksum 0xd8eb5e0b, Offset: 0x4c40
// Size: 0xa4
function private zombieturnmocompupdate(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
    normalizedtime = (entity getanimtime(mocompanim) + mocompanimblendouttime) / mocompduration;
    if (normalizedtime > 0.25) {
        entity orientmode("face motion");
        entity animmode("normal", 0);
    }
}

// Namespace zombiebehavior/zombie
// Params 5, eflags: 0x4
// Checksum 0xdcc73bae, Offset: 0x4cf0
// Size: 0x6c
function private zombieturnmocompterminate(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
    entity orientmode("face motion");
    entity animmode("normal", 0);
}

// Namespace zombiebehavior/zombie
// Params 1, eflags: 0x0
// Checksum 0x1ee21d32, Offset: 0x4d68
// Size: 0x28
function zombiehaslegs(entity) {
    if (entity.missinglegs === 1) {
        return false;
    }
    return true;
}

// Namespace zombiebehavior/zombie
// Params 1, eflags: 0x0
// Checksum 0x27fba3da, Offset: 0x4d98
// Size: 0x6a
function zombieshouldproceduraltraverse(entity) {
    return isdefined(entity.traversestartnode) && isdefined(entity.traverseendnode) && entity.traversestartnode.spawnflags & 1024 && entity.traverseendnode.spawnflags & 1024;
}

// Namespace zombiebehavior/zombie
// Params 1, eflags: 0x0
// Checksum 0xd5b26f22, Offset: 0x4e10
// Size: 0xba
function zombieshouldmeleesuicide(entity) {
    if (!entity ai::get_behavior_attribute("suicidal_behavior")) {
        return false;
    }
    if (isdefined(entity.magic_bullet_shield) && entity.magic_bullet_shield) {
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
// Params 1, eflags: 0x0
// Checksum 0x8ec0dfd3, Offset: 0x4ed8
// Size: 0x40
function zombiemeleesuicidestart(entity) {
    entity.blockingpain = 1;
    if (isdefined(level.zombiemeleesuicidecallback)) {
        entity thread [[ level.zombiemeleesuicidecallback ]](entity);
    }
}

// Namespace zombiebehavior/zombie
// Params 1, eflags: 0x0
// Checksum 0x3730313e, Offset: 0x4f20
// Size: 0xc
function zombiemeleesuicideupdate(entity) {
    
}

// Namespace zombiebehavior/zombie
// Params 1, eflags: 0x0
// Checksum 0x63ae7bd8, Offset: 0x4f38
// Size: 0x84
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
// Params 2, eflags: 0x0
// Checksum 0x761985d8, Offset: 0x4fc8
// Size: 0xea
function zombiemoveactionstart(entity, asmstatename) {
    function_a6530b67(entity);
    animationstatenetworkutility::requeststate(entity, asmstatename);
    if (isdefined(entity.stumble) && !isdefined(entity.move_anim_end_time)) {
        stumbleactionresult = entity astsearch(asmstatename);
        stumbleactionanimation = animationstatenetworkutility::searchanimationmap(entity, stumbleactionresult[#"animation"]);
        entity.move_anim_end_time = entity.movetime + getanimlength(stumbleactionanimation);
    }
    return 5;
}

// Namespace zombiebehavior/zombie
// Params 1, eflags: 0x0
// Checksum 0x46fe39ee, Offset: 0x50c0
// Size: 0x28
function function_19afea9a(entity) {
    function_a6530b67(entity);
    return true;
}

// Namespace zombiebehavior/zombie
// Params 1, eflags: 0x0
// Checksum 0xb86e8316, Offset: 0x50f0
// Size: 0x32
function function_a6530b67(entity) {
    entity.movetime = gettime();
    entity.moveorigin = entity.origin;
}

// Namespace zombiebehavior/zombie
// Params 2, eflags: 0x0
// Checksum 0xf7c7c810, Offset: 0x5130
// Size: 0xc2
function zombiemoveactionupdate(entity, asmstatename) {
    if (isdefined(entity.move_anim_end_time) && gettime() >= entity.move_anim_end_time) {
        entity.move_anim_end_time = undefined;
        return 4;
    }
    function_ee03f332(entity);
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
// Params 1, eflags: 0x0
// Checksum 0x41e3061, Offset: 0x5200
// Size: 0x28
function function_70c09995(entity) {
    function_ee03f332(entity);
    return true;
}

// Namespace zombiebehavior/zombie
// Params 1, eflags: 0x0
// Checksum 0xd32bddb, Offset: 0x5230
// Size: 0x15e
function function_ee03f332(entity) {
    if (!(isdefined(entity.missinglegs) && entity.missinglegs) && gettime() - entity.movetime > 1000) {
        distsq = distance2dsquared(entity.origin, entity.moveorigin);
        if (distsq < 144) {
            entity setavoidancemask("avoid all");
            entity.cant_move = 1;
            /#
                record3dtext("<dev string:x66>", entity.origin, (0, 0, 1), "<dev string:x42>", entity);
            #/
            if (isdefined(entity.cant_move_cb)) {
                entity thread [[ entity.cant_move_cb ]]();
            }
        } else {
            entity setavoidancemask("avoid none");
            entity.cant_move = 0;
        }
        entity.movetime = gettime();
        entity.moveorigin = entity.origin;
    }
}

// Namespace zombiebehavior/zombie
// Params 2, eflags: 0x0
// Checksum 0x8270986b, Offset: 0x5398
// Size: 0x58
function zombiemoveactionterminate(entity, asmstatename) {
    if (!(isdefined(entity.missinglegs) && entity.missinglegs)) {
        entity setavoidancemask("avoid none");
    }
    return 4;
}

// Namespace zombiebehavior/zombie
// Params 0, eflags: 0x0
// Checksum 0xc1da4d48, Offset: 0x53f8
// Size: 0x9e
function function_6137e5da() {
    self notify("29adbaaf2351e988");
    self endon("29adbaaf2351e988");
    self endon(#"death");
    if (!isdefined(self.var_f3f83845)) {
        self.var_f3f83845 = self function_effb2fc();
    }
    self pushplayer(1);
    wait 2;
    self pushplayer(self.var_f3f83845);
    self.var_f3f83845 = undefined;
}

// Namespace zombiebehavior/zombie
// Params 2, eflags: 0x0
// Checksum 0x224da48a, Offset: 0x54a0
// Size: 0x50
function function_f190c31(entity, asmstatename) {
    animationstatenetworkutility::requeststate(entity, asmstatename);
    entity pathmode("dont move", 1);
    return 5;
}

// Namespace zombiebehavior/zombie
// Params 2, eflags: 0x0
// Checksum 0xb5bc7f52, Offset: 0x54f8
// Size: 0x38
function function_14c6cbd0(entity, asmstatename) {
    entity pathmode("move allowed");
    return 4;
}

// Namespace zombiebehavior/zombie
// Params 0, eflags: 0x0
// Checksum 0x3f6c5a8f, Offset: 0x5538
// Size: 0x24
function archetypezombiedeathoverrideinit() {
    aiutility::addaioverridekilledcallback(self, &zombiegibkilledanhilateoverride);
}

// Namespace zombiebehavior/zombie
// Params 8, eflags: 0x4
// Checksum 0xec078d75, Offset: 0x5568
// Size: 0x2f8
function private zombiegibkilledanhilateoverride(inflictor, attacker, damage, meansofdeath, weapon, dir, hitloc, offsettime) {
    if (!(isdefined(level.zombieanhilationenabled) && level.zombieanhilationenabled)) {
        return damage;
    }
    if (isdefined(self.forceanhilateondeath) && self.forceanhilateondeath) {
        self zombie_utility::gib_random_parts();
        gibserverutils::annihilate(self);
        return damage;
    }
    if (isdefined(attacker) && isplayer(attacker) && (isdefined(attacker.forceanhilateondeath) && attacker.forceanhilateondeath || isdefined(level.forceanhilateondeath) && level.forceanhilateondeath)) {
        self zombie_utility::gib_random_parts();
        gibserverutils::annihilate(self);
        return damage;
    }
    attackerdistance = 0;
    if (isdefined(attacker)) {
        attackerdistance = distancesquared(attacker.origin, self.origin);
    }
    isexplosive = isinarray(array("MOD_CRUSH", "MOD_GRENADE", "MOD_GRENADE_SPLASH", "MOD_PROJECTILE", "MOD_PROJECTILE_SPLASH", "MOD_EXPLOSIVE"), meansofdeath);
    if (isdefined(weapon.weapclass) && weapon.weapclass == "turret") {
        if (isdefined(inflictor)) {
            isdirectexplosive = isinarray(array("MOD_GRENADE", "MOD_GRENADE_SPLASH", "MOD_PROJECTILE", "MOD_PROJECTILE_SPLASH", "MOD_EXPLOSIVE"), meansofdeath);
            iscloseexplosive = distancesquared(inflictor.origin, self.origin) <= 60 * 60;
            if (isdirectexplosive && iscloseexplosive) {
                self zombie_utility::gib_random_parts();
                gibserverutils::annihilate(self);
            }
        }
    }
    return damage;
}

// Namespace zombiebehavior/zombie
// Params 5, eflags: 0x4
// Checksum 0x73e57f2c, Offset: 0x5868
// Size: 0x114
function private zombiezombieidlemocompstart(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
    if (isdefined(entity.enemyoverride) && isdefined(entity.enemyoverride[1]) && entity != entity.enemyoverride[1]) {
        entity orientmode("face direction", entity.enemyoverride[1].origin - entity.origin);
        entity animmode("zonly_physics", 0);
        return;
    }
    entity orientmode("face current");
    entity animmode("zonly_physics", 0);
}

// Namespace zombiebehavior/zombie
// Params 5, eflags: 0x4
// Checksum 0xf31c3c2b, Offset: 0x5988
// Size: 0xd4
function private zombieattackobjectmocompstart(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
    if (isdefined(entity.attackable_slot)) {
        entity orientmode("face angle", entity.attackable_slot.angles[1]);
        entity animmode("zonly_physics", 0);
        return;
    }
    entity orientmode("face current");
    entity animmode("zonly_physics", 0);
}

// Namespace zombiebehavior/zombie
// Params 5, eflags: 0x4
// Checksum 0x2eedbdc, Offset: 0x5a68
// Size: 0x64
function private zombieattackobjectmocompupdate(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
    if (isdefined(entity.attackable_slot)) {
        entity forceteleport(entity.attackable_slot.origin);
    }
}

// Namespace zombiebehavior/zombie
// Params 5, eflags: 0x4
// Checksum 0x4b36957e, Offset: 0x5ad8
// Size: 0x1a4
function private function_2b5c772b(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
    if (isdefined(entity.enemy)) {
        entity orientmode("face enemy");
    }
    entity animmode("zonly_physics", 1);
    entity pathmode("dont move");
    localdeltahalfvector = getmovedelta(mocompanim, 0, 0.9, entity);
    endpoint = entity localtoworldcoords(localdeltahalfvector);
    /#
        recordcircle(endpoint, 3, (1, 0, 0), "<dev string:x8b>");
        recordline(entity.origin, endpoint, (1, 0, 0), "<dev string:x8b>");
        record3dtext("<dev string:x92>" + distance(entity.origin, endpoint) + "<dev string:x98>" + function_15979fa9(mocompanim), endpoint, (1, 0, 0), "<dev string:x42>");
    #/
}

// Namespace zombiebehavior/zombie
// Params 5, eflags: 0x4
// Checksum 0x422e5bc1, Offset: 0x5c88
// Size: 0x4c
function private function_e5505e1e(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
    entity pathmode("dont move");
}

// Namespace zombiebehavior/zombie
// Params 5, eflags: 0x4
// Checksum 0xf6223ec3, Offset: 0x5ce0
// Size: 0x4c
function private function_e81d088(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
    entity pathmode("move allowed");
}

// Namespace zombiebehavior/zombie
// Params 5, eflags: 0x4
// Checksum 0x40ee0599, Offset: 0x5d38
// Size: 0x194
function private function_92fcc873(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
    entity orientmode("face angle", entity.angles[1]);
    entity animmode("normal");
    if (isdefined(entity.traverseendnode)) {
        /#
            print3d(entity.traversestartnode.origin, "<dev string:x9f>", (1, 0, 0), 1, 1, 60);
            print3d(entity.traverseendnode.origin, "<dev string:x9f>", (0, 1, 0), 1, 1, 60);
            line(entity.traversestartnode.origin, entity.traverseendnode.origin, (0, 1, 0), 1, 0, 60);
        #/
        entity forceteleport(entity.traverseendnode.origin, entity.traverseendnode.angles, 0);
    }
}

// Namespace zombiebehavior/zombie
// Params 4, eflags: 0x0
// Checksum 0xa35b29ef, Offset: 0x5ed8
// Size: 0x11c
function zombiegravity(entity, attribute, oldvalue, value) {
    if (value == "low") {
        self.low_gravity = 1;
        if (!isdefined(self.low_gravity_variant) && isdefined(level.var_4fb25bb9)) {
            if (isdefined(self.missinglegs) && self.missinglegs) {
                self.low_gravity_variant = randomint(level.var_4fb25bb9[#"crawl"]);
            } else {
                self.low_gravity_variant = randomint(level.var_4fb25bb9[self.zombie_move_speed]);
            }
        }
    } else if (value == "normal") {
        self.low_gravity = 0;
    }
    entity setblackboardattribute("_low_gravity", value);
}

