#using scripts/core_common/ai/archetype_locomotion_utility;
#using scripts/core_common/ai/archetype_mocomps_utility;
#using scripts/core_common/ai/archetype_utility;
#using scripts/core_common/ai/archetype_zombie_interface;
#using scripts/core_common/ai/systems/ai_interface;
#using scripts/core_common/ai/systems/animation_state_machine_mocomp;
#using scripts/core_common/ai/systems/animation_state_machine_notetracks;
#using scripts/core_common/ai/systems/animation_state_machine_utility;
#using scripts/core_common/ai/systems/behavior_tree_utility;
#using scripts/core_common/ai/systems/blackboard;
#using scripts/core_common/ai/systems/debug;
#using scripts/core_common/ai/systems/gib;
#using scripts/core_common/ai/zombie_death;
#using scripts/core_common/ai/zombie_shared;
#using scripts/core_common/ai/zombie_utility;
#using scripts/core_common/ai_shared;
#using scripts/core_common/array_shared;
#using scripts/core_common/callbacks_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/fx_shared;
#using scripts/core_common/math_shared;
#using scripts/core_common/scene_shared;
#using scripts/core_common/spawner_shared;
#using scripts/core_common/struct;
#using scripts/core_common/util_shared;

#namespace zombiebehavior;

// Namespace zombiebehavior/zombie
// Params 0, eflags: 0x2
// Checksum 0xd9f970c9, Offset: 0xb58
// Size: 0x124
function autoexec init() {
    initzombiebehaviorsandasm();
    spawner::add_archetype_spawn_function("zombie", &archetypezombieblackboardinit);
    spawner::add_archetype_spawn_function("zombie", &archetypezombiedeathoverrideinit);
    spawner::add_archetype_spawn_function("zombie", &archetypezombiespecialeffectsinit);
    spawner::add_archetype_spawn_function("zombie", &zombie_utility::zombiespawnsetup);
    clientfield::register("actor", "zombie", 1, 1, "int");
    clientfield::register("actor", "zombie_special_day", 6001, 1, "counter");
    zombieinterface::registerzombieinterfaceattributes();
}

// Namespace zombiebehavior/zombie
// Params 0, eflags: 0x4
// Checksum 0x840ea2ba, Offset: 0xc88
// Size: 0xe94
function private initzombiebehaviorsandasm() {
    assert(!isdefined(&zombiemoveaction) || isscriptfunctionptr(&zombiemoveaction));
    assert(!isdefined(&zombiemoveactionupdate) || isscriptfunctionptr(&zombiemoveactionupdate));
    assert(!isdefined(undefined) || isscriptfunctionptr(undefined));
    behaviortreenetworkutility::registerbehaviortreeaction("zombieMoveAction", &zombiemoveaction, &zombiemoveactionupdate, undefined);
    assert(isscriptfunctionptr(&zombietargetservice));
    behaviortreenetworkutility::registerbehaviortreescriptapi("zombieTargetService", &zombietargetservice);
    assert(isscriptfunctionptr(&zombiecrawlercollision));
    behaviortreenetworkutility::registerbehaviortreescriptapi("zombieCrawlerCollisionService", &zombiecrawlercollision);
    assert(isscriptfunctionptr(&zombietraversalservice));
    behaviortreenetworkutility::registerbehaviortreescriptapi("zombieTraversalService", &zombietraversalservice);
    assert(isscriptfunctionptr(&zombieisatattackobject));
    behaviortreenetworkutility::registerbehaviortreescriptapi("zombieIsAtAttackObject", &zombieisatattackobject);
    assert(isscriptfunctionptr(&zombieshouldattackobject));
    behaviortreenetworkutility::registerbehaviortreescriptapi("zombieShouldAttackObject", &zombieshouldattackobject);
    assert(isscriptfunctionptr(&zombieshouldmeleecondition));
    behaviortreenetworkutility::registerbehaviortreescriptapi("zombieShouldMelee", &zombieshouldmeleecondition);
    assert(isscriptfunctionptr(&zombieshouldjumpmeleecondition));
    behaviortreenetworkutility::registerbehaviortreescriptapi("zombieShouldJumpMelee", &zombieshouldjumpmeleecondition);
    assert(isscriptfunctionptr(&zombieshouldjumpunderwatermelee));
    behaviortreenetworkutility::registerbehaviortreescriptapi("zombieShouldJumpUnderwaterMelee", &zombieshouldjumpunderwatermelee);
    assert(isscriptfunctionptr(&zombiegiblegscondition));
    behaviortreenetworkutility::registerbehaviortreescriptapi("zombieGibLegsCondition", &zombiegiblegscondition);
    assert(isscriptfunctionptr(&zombieshoulddisplaypain));
    behaviortreenetworkutility::registerbehaviortreescriptapi("zombieShouldDisplayPain", &zombieshoulddisplaypain);
    assert(isscriptfunctionptr(&iszombiewalking));
    behaviortreenetworkutility::registerbehaviortreescriptapi("isZombieWalking", &iszombiewalking);
    assert(isscriptfunctionptr(&zombieshouldmeleesuicide));
    behaviortreenetworkutility::registerbehaviortreescriptapi("zombieShouldMeleeSuicide", &zombieshouldmeleesuicide);
    assert(isscriptfunctionptr(&zombiemeleesuicidestart));
    behaviortreenetworkutility::registerbehaviortreescriptapi("zombieMeleeSuicideStart", &zombiemeleesuicidestart);
    assert(isscriptfunctionptr(&zombiemeleesuicideupdate));
    behaviortreenetworkutility::registerbehaviortreescriptapi("zombieMeleeSuicideUpdate", &zombiemeleesuicideupdate);
    assert(isscriptfunctionptr(&zombiemeleesuicideterminate));
    behaviortreenetworkutility::registerbehaviortreescriptapi("zombieMeleeSuicideTerminate", &zombiemeleesuicideterminate);
    assert(isscriptfunctionptr(&zombieshouldjukecondition));
    behaviortreenetworkutility::registerbehaviortreescriptapi("zombieShouldJuke", &zombieshouldjukecondition);
    assert(isscriptfunctionptr(&zombiejukeactionstart));
    behaviortreenetworkutility::registerbehaviortreescriptapi("zombieJukeActionStart", &zombiejukeactionstart);
    assert(isscriptfunctionptr(&zombiejukeactionterminate));
    behaviortreenetworkutility::registerbehaviortreescriptapi("zombieJukeActionTerminate", &zombiejukeactionterminate);
    assert(isscriptfunctionptr(&zombiedeathaction));
    behaviortreenetworkutility::registerbehaviortreescriptapi("zombieDeathAction", &zombiedeathaction);
    assert(isscriptfunctionptr(&zombiejuke));
    behaviortreenetworkutility::registerbehaviortreescriptapi("zombieJukeService", &zombiejuke);
    assert(isscriptfunctionptr(&zombiestumble));
    behaviortreenetworkutility::registerbehaviortreescriptapi("zombieStumbleService", &zombiestumble);
    assert(isscriptfunctionptr(&zombieshouldstumblecondition));
    behaviortreenetworkutility::registerbehaviortreescriptapi("zombieStumbleCondition", &zombieshouldstumblecondition);
    assert(isscriptfunctionptr(&zombiestumbleactionstart));
    behaviortreenetworkutility::registerbehaviortreescriptapi("zombieStumbleActionStart", &zombiestumbleactionstart);
    assert(isscriptfunctionptr(&zombieattackobjectstart));
    behaviortreenetworkutility::registerbehaviortreescriptapi("zombieAttackObjectStart", &zombieattackobjectstart);
    assert(isscriptfunctionptr(&zombieattackobjectterminate));
    behaviortreenetworkutility::registerbehaviortreescriptapi("zombieAttackObjectTerminate", &zombieattackobjectterminate);
    assert(isscriptfunctionptr(&waskilledbyinterdimensionalguncondition));
    behaviortreenetworkutility::registerbehaviortreescriptapi("wasKilledByInterdimensionalGun", &waskilledbyinterdimensionalguncondition);
    assert(isscriptfunctionptr(&wascrushedbyinterdimensionalgunblackholecondition));
    behaviortreenetworkutility::registerbehaviortreescriptapi("wasCrushedByInterdimensionalGunBlackhole", &wascrushedbyinterdimensionalgunblackholecondition);
    assert(isscriptfunctionptr(&zombieidgundeathupdate));
    behaviortreenetworkutility::registerbehaviortreescriptapi("zombieIDGunDeathUpdate", &zombieidgundeathupdate);
    assert(isscriptfunctionptr(&zombieidgundeathupdate));
    behaviortreenetworkutility::registerbehaviortreescriptapi("zombieVortexPullUpdate", &zombieidgundeathupdate);
    assert(isscriptfunctionptr(&zombiehaslegs));
    behaviortreenetworkutility::registerbehaviortreescriptapi("zombieHasLegs", &zombiehaslegs);
    assert(isscriptfunctionptr(&zombieshouldproceduraltraverse));
    behaviortreenetworkutility::registerbehaviortreescriptapi("zombieShouldProceduralTraverse", &zombieshouldproceduraltraverse);
    animationstatenetwork::registernotetrackhandlerfunction("zombie_melee", &zombienotetrackmeleefire);
    animationstatenetwork::registernotetrackhandlerfunction("crushed", &zombienotetrackcrushfire);
    animationstatenetwork::registeranimationmocomp("mocomp_death_idgun@zombie", &zombieidgundeathmocompstart, undefined, undefined);
    animationstatenetwork::registeranimationmocomp("mocomp_vortex_pull@zombie", &zombieidgundeathmocompstart, undefined, undefined);
    animationstatenetwork::registeranimationmocomp("mocomp_death_idgun_hole@zombie", &zombieidgunholedeathmocompstart, undefined, &zombieidgunholedeathmocompterminate);
    animationstatenetwork::registeranimationmocomp("mocomp_turn@zombie", &zombieturnmocompstart, &zombieturnmocompupdate, &zombieturnmocompterminate);
    animationstatenetwork::registeranimationmocomp("mocomp_melee_jump@zombie", &zombiemeleejumpmocompstart, &zombiemeleejumpmocompupdate, &zombiemeleejumpmocompterminate);
    animationstatenetwork::registeranimationmocomp("mocomp_zombie_idle@zombie", &zombiezombieidlemocompstart, undefined, undefined);
    animationstatenetwork::registeranimationmocomp("mocomp_attack_object@zombie", &zombieattackobjectmocompstart, &zombieattackobjectmocompupdate, undefined);
}

// Namespace zombiebehavior/zombie
// Params 0, eflags: 0x0
// Checksum 0x83a495f3, Offset: 0x1b28
// Size: 0x4c
function archetypezombieblackboardinit() {
    blackboard::createblackboardforentity(self);
    ai::createinterfaceforentity(self);
    self.___archetypeonanimscriptedcallback = &archetypezombieonanimscriptedcallback;
}

// Namespace zombiebehavior/zombie
// Params 1, eflags: 0x4
// Checksum 0xd52ed3e0, Offset: 0x1b80
// Size: 0x34
function private archetypezombieonanimscriptedcallback(entity) {
    entity.__blackboard = undefined;
    entity archetypezombieblackboardinit();
}

// Namespace zombiebehavior/zombie
// Params 0, eflags: 0x0
// Checksum 0xa3a76417, Offset: 0x1bc0
// Size: 0x24
function archetypezombiespecialeffectsinit() {
    aiutility::addaioverridedamagecallback(self, &archetypezombiespecialeffectscallback);
}

// Namespace zombiebehavior/zombie
// Params 13, eflags: 0x4
// Checksum 0x168599f5, Offset: 0x1bf0
// Size: 0xf8
function private archetypezombiespecialeffectscallback(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, damagefromunderneath, modelindex, partname) {
    specialdayeffectchance = getdvarint("tu6_ffotd_zombieSpecialDayEffectsChance", 0);
    if (specialdayeffectchance && randomint(100) < specialdayeffectchance) {
        if (isdefined(eattacker) && isplayer(eattacker)) {
            self clientfield::increment("zombie_special_day");
        }
    }
    return idamage;
}

// Namespace zombiebehavior/zombie
// Params 0, eflags: 0x0
// Checksum 0x51de206f, Offset: 0x1cf0
// Size: 0x22
function bb_getvarianttype() {
    if (isdefined(self.variant_type)) {
        return self.variant_type;
    }
    return 0;
}

// Namespace zombiebehavior/zombie
// Params 0, eflags: 0x0
// Checksum 0x978c01c7, Offset: 0x1d20
// Size: 0x22
function bb_getlowgravityvariant() {
    if (isdefined(self.low_gravity_variant)) {
        return self.low_gravity_variant;
    }
    return 0;
}

// Namespace zombiebehavior/zombie
// Params 1, eflags: 0x0
// Checksum 0x86fef39b, Offset: 0x1d50
// Size: 0x30
function iszombiewalking(behaviortreeentity) {
    return !(isdefined(behaviortreeentity.missinglegs) && behaviortreeentity.missinglegs);
}

// Namespace zombiebehavior/zombie
// Params 1, eflags: 0x0
// Checksum 0x977f6aac, Offset: 0x1d88
// Size: 0x58
function zombieshoulddisplaypain(behaviortreeentity) {
    if (isdefined(behaviortreeentity.suicidaldeath) && behaviortreeentity.suicidaldeath) {
        return false;
    }
    return !(isdefined(behaviortreeentity.missinglegs) && behaviortreeentity.missinglegs);
}

// Namespace zombiebehavior/zombie
// Params 1, eflags: 0x0
// Checksum 0x8446f8b4, Offset: 0x1de8
// Size: 0x60
function zombieshouldjukecondition(behaviortreeentity) {
    if (behaviortreeentity.juke == "left" || isdefined(behaviortreeentity.juke) && behaviortreeentity.juke == "right") {
        return true;
    }
    return false;
}

// Namespace zombiebehavior/zombie
// Params 1, eflags: 0x0
// Checksum 0x163cc58c, Offset: 0x1e50
// Size: 0x28
function zombieshouldstumblecondition(behaviortreeentity) {
    if (isdefined(behaviortreeentity.stumble)) {
        return true;
    }
    return false;
}

// Namespace zombiebehavior/zombie
// Params 1, eflags: 0x4
// Checksum 0x2a39c60c, Offset: 0x1e80
// Size: 0xb6
function private zombiejukeactionstart(behaviortreeentity) {
    behaviortreeentity setblackboardattribute("_juke_direction", behaviortreeentity.juke);
    if (isdefined(behaviortreeentity.jukedistance)) {
        behaviortreeentity setblackboardattribute("_juke_distance", behaviortreeentity.jukedistance);
    } else {
        behaviortreeentity setblackboardattribute("_juke_distance", "short");
    }
    behaviortreeentity.jukedistance = undefined;
    behaviortreeentity.juke = undefined;
}

// Namespace zombiebehavior/zombie
// Params 1, eflags: 0x4
// Checksum 0x961de0a1, Offset: 0x1f40
// Size: 0x24
function private zombiejukeactionterminate(behaviortreeentity) {
    behaviortreeentity clearpath();
}

// Namespace zombiebehavior/zombie
// Params 1, eflags: 0x4
// Checksum 0xe1b0d0cd, Offset: 0x1f70
// Size: 0x1a
function private zombiestumbleactionstart(behaviortreeentity) {
    behaviortreeentity.stumble = undefined;
}

// Namespace zombiebehavior/zombie
// Params 1, eflags: 0x4
// Checksum 0x2b218a8c, Offset: 0x1f98
// Size: 0x20
function private zombieattackobjectstart(behaviortreeentity) {
    behaviortreeentity.is_inert = 1;
}

// Namespace zombiebehavior/zombie
// Params 1, eflags: 0x4
// Checksum 0xb9252fd0, Offset: 0x1fc0
// Size: 0x1c
function private zombieattackobjectterminate(behaviortreeentity) {
    behaviortreeentity.is_inert = 0;
}

// Namespace zombiebehavior/zombie
// Params 1, eflags: 0x0
// Checksum 0xe664ce95, Offset: 0x1fe8
// Size: 0x42
function zombiegiblegscondition(behaviortreeentity) {
    return gibserverutils::isgibbed(behaviortreeentity, 256) || gibserverutils::isgibbed(behaviortreeentity, 128);
}

// Namespace zombiebehavior/zombie
// Params 1, eflags: 0x0
// Checksum 0xd2788fcd, Offset: 0x2038
// Size: 0x274
function zombienotetrackmeleefire(entity) {
    if (isdefined(entity.aat_turned) && entity.aat_turned) {
        if (isdefined(entity.enemy) && !isplayer(entity.enemy)) {
            if (isdefined(entity.enemy.allowdeath) && entity.enemy.archetype == "zombie" && entity.enemy.allowdeath) {
                gibserverutils::gibhead(entity.enemy);
                entity.enemy zombie_utility::gib_random_parts();
                entity.enemy kill();
                entity.n_aat_turned_zombie_kills++;
            } else if (isdefined(entity.enemy.canbetargetedbyturnedzombies) && entity.enemy.canbetargetedbyturnedzombies) {
                entity melee();
            }
        }
        return;
    }
    if (isdefined(entity.enemy.bgb_in_plain_sight_active) && isdefined(entity.enemy) && entity.enemy.bgb_in_plain_sight_active) {
        return;
    }
    entity melee();
    /#
        record3dtext("<dev string:x28>", self.origin, (1, 0, 0), "<dev string:x2e>", entity);
    #/
    if (zombieshouldattackobject(entity)) {
        if (isdefined(level.attackablecallback)) {
            entity.attackable [[ level.attackablecallback ]](entity);
        }
    }
}

// Namespace zombiebehavior/zombie
// Params 1, eflags: 0x0
// Checksum 0x90cb97a9, Offset: 0x22b8
// Size: 0x24
function zombienotetrackcrushfire(behaviortreeentity) {
    behaviortreeentity delete();
}

// Namespace zombiebehavior/zombie
// Params 1, eflags: 0x0
// Checksum 0xb3647ce6, Offset: 0x22e8
// Size: 0x298
function zombietargetservice(behaviortreeentity) {
    if (isdefined(behaviortreeentity.enablepushtime)) {
        if (gettime() >= behaviortreeentity.enablepushtime) {
            behaviortreeentity collidewithactors(1);
            behaviortreeentity.enablepushtime = undefined;
        }
    }
    if (isdefined(behaviortreeentity.disabletargetservice) && behaviortreeentity.disabletargetservice) {
        return 0;
    }
    if (isdefined(behaviortreeentity.ignoreall) && behaviortreeentity.ignoreall) {
        return 0;
    }
    specifictarget = undefined;
    if (isdefined(level.zombielevelspecifictargetcallback)) {
        specifictarget = [[ level.zombielevelspecifictargetcallback ]]();
    }
    if (isdefined(specifictarget)) {
        behaviortreeentity setgoal(specifictarget.origin);
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
                behaviortreeentity zombieupdatezigzaggoal();
            } else {
                behaviortreeentity setgoal(player.last_valid_position);
            }
        }
        return 1;
    }
    if (!(isdefined(self.zombie_do_not_update_goal) && self.zombie_do_not_update_goal)) {
        behaviortreeentity setgoal(behaviortreeentity.origin);
    }
    return 0;
}

// Namespace zombiebehavior/zombie
// Params 0, eflags: 0x0
// Checksum 0xed34a601, Offset: 0x2588
// Size: 0x63c
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
                if (getdvarint("<dev string:x35>")) {
                    for (index = 1; index < path.size; index++) {
                        recordline(path[index - 1], path[index], (1, 0.5, 0), "<dev string:x44>", self);
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
                        recordcircle(seedposition, 2, (1, 0.5, 0), "<dev string:x44>", self);
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
// Checksum 0x17f60bd5, Offset: 0x2bd0
// Size: 0x21e
function zombiecrawlercollision(behaviortreeentity) {
    if (!(isdefined(behaviortreeentity.missinglegs) && behaviortreeentity.missinglegs) && !(isdefined(behaviortreeentity.knockdown) && behaviortreeentity.knockdown)) {
        return false;
    }
    if (isdefined(behaviortreeentity.dontpushtime)) {
        if (gettime() < behaviortreeentity.dontpushtime) {
            return true;
        }
    }
    zombies = getaiteamarray(level.zombie_team);
    foreach (zombie in zombies) {
        if (zombie == behaviortreeentity) {
            continue;
        }
        if (isdefined(zombie.knockdown) && (isdefined(zombie.missinglegs) && zombie.missinglegs || zombie.knockdown)) {
            continue;
        }
        dist_sq = distancesquared(behaviortreeentity.origin, zombie.origin);
        if (dist_sq < 14400) {
            behaviortreeentity collidewithactors(0);
            behaviortreeentity.dontpushtime = gettime() + 2000;
            return true;
        }
    }
    behaviortreeentity collidewithactors(1);
    return false;
}

// Namespace zombiebehavior/zombie
// Params 1, eflags: 0x0
// Checksum 0x55873d3d, Offset: 0x2df8
// Size: 0x44
function zombietraversalservice(entity) {
    if (isdefined(entity.traversestartnode)) {
        entity collidewithactors(0);
        return true;
    }
    return false;
}

// Namespace zombiebehavior/zombie
// Params 1, eflags: 0x0
// Checksum 0x408ccfd6, Offset: 0x2e48
// Size: 0x200
function zombieisatattackobject(entity) {
    if (isdefined(entity.missinglegs) && entity.missinglegs) {
        return false;
    }
    if (isdefined(entity.enemyoverride) && isdefined(entity.enemyoverride[1])) {
        return false;
    }
    if (isdefined(entity.favoriteenemy.b_is_designated_target) && isdefined(entity.favoriteenemy) && entity.favoriteenemy.b_is_designated_target) {
        return false;
    }
    if (isdefined(entity.aat_turned) && entity.aat_turned) {
        return false;
    }
    if (isdefined(entity.attackable.is_active) && isdefined(entity.attackable) && entity.attackable.is_active) {
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
// Checksum 0x5d719772, Offset: 0x3050
// Size: 0x14e
function zombieshouldattackobject(entity) {
    if (isdefined(entity.missinglegs) && entity.missinglegs) {
        return false;
    }
    if (isdefined(entity.enemyoverride) && isdefined(entity.enemyoverride[1])) {
        return false;
    }
    if (isdefined(entity.favoriteenemy.b_is_designated_target) && isdefined(entity.favoriteenemy) && entity.favoriteenemy.b_is_designated_target) {
        return false;
    }
    if (isdefined(entity.aat_turned) && entity.aat_turned) {
        return false;
    }
    if (isdefined(entity.attackable.is_active) && isdefined(entity.attackable) && entity.attackable.is_active) {
        if (isdefined(entity.is_at_attackable) && entity.is_at_attackable) {
            return true;
        }
    }
    return false;
}

// Namespace zombiebehavior/zombie
// Params 1, eflags: 0x0
// Checksum 0x7cb3ebf7, Offset: 0x31a8
// Size: 0x164
function zombieshouldmeleecondition(behaviortreeentity) {
    if (isdefined(behaviortreeentity.enemyoverride) && isdefined(behaviortreeentity.enemyoverride[1])) {
        return false;
    }
    if (!isdefined(behaviortreeentity.enemy)) {
        return false;
    }
    if (isdefined(behaviortreeentity.marked_for_death)) {
        return false;
    }
    if (isdefined(behaviortreeentity.ignoremelee) && behaviortreeentity.ignoremelee) {
        return false;
    }
    if (distancesquared(behaviortreeentity.origin, behaviortreeentity.enemy.origin) > 4096) {
        return false;
    }
    yawtoenemy = angleclamp180(behaviortreeentity.angles[1] - vectortoangles(behaviortreeentity.enemy.origin - behaviortreeentity.origin)[1]);
    if (abs(yawtoenemy) > 60) {
        return false;
    }
    return true;
}

// Namespace zombiebehavior/zombie
// Params 1, eflags: 0x0
// Checksum 0x7eda5540, Offset: 0x3318
// Size: 0x2f8
function zombieshouldjumpmeleecondition(behaviortreeentity) {
    if (!(isdefined(behaviortreeentity.low_gravity) && behaviortreeentity.low_gravity)) {
        return false;
    }
    if (isdefined(behaviortreeentity.enemyoverride) && isdefined(behaviortreeentity.enemyoverride[1])) {
        return false;
    }
    if (!isdefined(behaviortreeentity.enemy)) {
        return false;
    }
    if (isdefined(behaviortreeentity.marked_for_death)) {
        return false;
    }
    if (isdefined(behaviortreeentity.ignoremelee) && behaviortreeentity.ignoremelee) {
        return false;
    }
    if (behaviortreeentity.enemy isonground()) {
        return false;
    }
    jumpchance = getdvarfloat("zmMeleeJumpChance", 0.5);
    if (behaviortreeentity getentitynumber() % 10 / 10 > jumpchance) {
        return false;
    }
    predictedposition = behaviortreeentity.enemy.origin + behaviortreeentity.enemy getvelocity() * 0.05 * 2;
    jumpdistancesq = pow(getdvarint("zmMeleeJumpDistance", 180), 2);
    if (distance2dsquared(behaviortreeentity.origin, predictedposition) > jumpdistancesq) {
        return false;
    }
    yawtoenemy = angleclamp180(behaviortreeentity.angles[1] - vectortoangles(behaviortreeentity.enemy.origin - behaviortreeentity.origin)[1]);
    if (abs(yawtoenemy) > 60) {
        return false;
    }
    heighttoenemy = behaviortreeentity.enemy.origin[2] - behaviortreeentity.origin[2];
    if (heighttoenemy <= getdvarint("zmMeleeJumpHeightDifference", 60)) {
        return false;
    }
    return true;
}

// Namespace zombiebehavior/zombie
// Params 1, eflags: 0x0
// Checksum 0x4f34d91e, Offset: 0x3618
// Size: 0x258
function zombieshouldjumpunderwatermelee(behaviortreeentity) {
    if (isdefined(behaviortreeentity.enemyoverride) && isdefined(behaviortreeentity.enemyoverride[1])) {
        return false;
    }
    if (!isdefined(behaviortreeentity.enemy)) {
        return false;
    }
    if (isdefined(behaviortreeentity.marked_for_death)) {
        return false;
    }
    if (isdefined(behaviortreeentity.ignoremelee) && behaviortreeentity.ignoremelee) {
        return false;
    }
    if (behaviortreeentity.enemy isonground()) {
        return false;
    }
    if (behaviortreeentity depthinwater() < 48) {
        return false;
    }
    jumpdistancesq = pow(getdvarint("zmMeleeWaterJumpDistance", 64), 2);
    if (distance2dsquared(behaviortreeentity.origin, behaviortreeentity.enemy.origin) > jumpdistancesq) {
        return false;
    }
    yawtoenemy = angleclamp180(behaviortreeentity.angles[1] - vectortoangles(behaviortreeentity.enemy.origin - behaviortreeentity.origin)[1]);
    if (abs(yawtoenemy) > 60) {
        return false;
    }
    heighttoenemy = behaviortreeentity.enemy.origin[2] - behaviortreeentity.origin[2];
    if (heighttoenemy <= getdvarint("zmMeleeJumpUnderwaterHeightDifference", 48)) {
        return false;
    }
    return true;
}

// Namespace zombiebehavior/zombie
// Params 1, eflags: 0x0
// Checksum 0x4408e571, Offset: 0x3878
// Size: 0x1d0
function zombiestumble(behaviortreeentity) {
    if (isdefined(behaviortreeentity.missinglegs) && behaviortreeentity.missinglegs) {
        return false;
    }
    if (!(isdefined(behaviortreeentity.canstumble) && behaviortreeentity.canstumble)) {
        return false;
    }
    if (!isdefined(behaviortreeentity.zombie_move_speed) || behaviortreeentity.zombie_move_speed != "sprint") {
        return false;
    }
    if (isdefined(behaviortreeentity.stumble)) {
        return false;
    }
    if (!isdefined(behaviortreeentity.next_stumble_time)) {
        behaviortreeentity.next_stumble_time = gettime() + randomintrange(9000, 12000);
    }
    if (gettime() > behaviortreeentity.next_stumble_time) {
        if (randomint(100) < 5) {
            closestplayer = arraygetclosest(behaviortreeentity.origin, level.players);
            if (distancesquared(closestplayer.origin, behaviortreeentity.origin) > 50000) {
                if (isdefined(behaviortreeentity.next_juke_time)) {
                    behaviortreeentity.next_juke_time = undefined;
                }
                behaviortreeentity.next_stumble_time = undefined;
                behaviortreeentity.stumble = 1;
                return true;
            }
        }
    }
    return false;
}

// Namespace zombiebehavior/zombie
// Params 1, eflags: 0x0
// Checksum 0xc80e473e, Offset: 0x3a50
// Size: 0x3ca
function zombiejuke(behaviortreeentity) {
    if (!behaviortreeentity ai::has_behavior_attribute("can_juke")) {
        return 0;
    }
    if (!behaviortreeentity ai::get_behavior_attribute("can_juke")) {
        return 0;
    }
    if (isdefined(behaviortreeentity.missinglegs) && behaviortreeentity.missinglegs) {
        return 0;
    }
    if (behaviortreeentity aiutility::function_f8ae4008() != "locomotion_speed_walk") {
        if (behaviortreeentity ai::has_behavior_attribute("spark_behavior") && !behaviortreeentity ai::get_behavior_attribute("spark_behavior")) {
            return 0;
        }
    }
    if (isdefined(behaviortreeentity.juke)) {
        return 0;
    }
    if (!isdefined(behaviortreeentity.next_juke_time)) {
        behaviortreeentity.next_juke_time = gettime() + randomintrange(7500, 9500);
    }
    if (gettime() > behaviortreeentity.next_juke_time) {
        behaviortreeentity.next_juke_time = undefined;
        if (behaviortreeentity ai::has_behavior_attribute("spark_behavior") && (randomint(100) < 25 || behaviortreeentity ai::get_behavior_attribute("spark_behavior"))) {
            if (isdefined(behaviortreeentity.next_stumble_time)) {
                behaviortreeentity.next_stumble_time = undefined;
            }
            forwardoffset = 15;
            behaviortreeentity.ignorebackwardposition = 1;
            if (math::cointoss()) {
                jukedistance = 101;
                behaviortreeentity.jukedistance = "long";
                switch (behaviortreeentity aiutility::function_f8ae4008()) {
                case #"locomotion_speed_run":
                case #"locomotion_speed_walk":
                    forwardoffset = 122;
                    break;
                case #"locomotion_speed_sprint":
                    forwardoffset = 129;
                    break;
                }
                behaviortreeentity.juke = aiutility::calculatejukedirection(behaviortreeentity, forwardoffset, jukedistance);
            }
            if (!isdefined(behaviortreeentity.juke) || behaviortreeentity.juke == "forward") {
                jukedistance = 69;
                behaviortreeentity.jukedistance = "short";
                switch (behaviortreeentity aiutility::function_f8ae4008()) {
                case #"locomotion_speed_run":
                case #"locomotion_speed_walk":
                    forwardoffset = 127;
                    break;
                case #"locomotion_speed_sprint":
                    forwardoffset = 148;
                    break;
                }
                behaviortreeentity.juke = aiutility::calculatejukedirection(behaviortreeentity, forwardoffset, jukedistance);
                if (behaviortreeentity.juke == "forward") {
                    behaviortreeentity.juke = undefined;
                    behaviortreeentity.jukedistance = undefined;
                    return 0;
                }
            }
        }
    }
}

// Namespace zombiebehavior/zombie
// Params 1, eflags: 0x0
// Checksum 0x201f86cc, Offset: 0x3e28
// Size: 0xc
function zombiedeathaction(behaviortreeentity) {
    
}

// Namespace zombiebehavior/zombie
// Params 1, eflags: 0x0
// Checksum 0x1e85e8d4, Offset: 0x3e40
// Size: 0x56
function waskilledbyinterdimensionalguncondition(behaviortreeentity) {
    if (isdefined(behaviortreeentity.interdimensional_gun_kill) && !isdefined(behaviortreeentity.killby_interdimensional_gun_hole) && isalive(behaviortreeentity)) {
        return true;
    }
    return false;
}

// Namespace zombiebehavior/zombie
// Params 1, eflags: 0x0
// Checksum 0x3e49aad5, Offset: 0x3ea0
// Size: 0x28
function wascrushedbyinterdimensionalgunblackholecondition(behaviortreeentity) {
    if (isdefined(behaviortreeentity.killby_interdimensional_gun_hole)) {
        return true;
    }
    return false;
}

// Namespace zombiebehavior/zombie
// Params 5, eflags: 0x0
// Checksum 0x5cac3943, Offset: 0x3ed0
// Size: 0xcc
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
// Checksum 0xdf4e7942, Offset: 0x3fa8
// Size: 0xd8
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
// Checksum 0xc79b374a, Offset: 0x4088
// Size: 0x2b4
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
    groundpoint = getclosestpointonnavmesh(newvalidposition, 12, 20);
    if (isdefined(groundpoint) && groundpoint[2] > newvalidposition[2]) {
        newvalidposition = (newvalidposition[0], newvalidposition[1], groundpoint[2]);
    }
    entity forceteleport(newvalidposition);
}

// Namespace zombiebehavior/zombie
// Params 5, eflags: 0x0
// Checksum 0x5a9c53ec, Offset: 0x4348
// Size: 0xcc
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
// Checksum 0x81cb20e, Offset: 0x4420
// Size: 0x38c
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
// Checksum 0x863681f4, Offset: 0x47b8
// Size: 0x8c
function zombieidgunholedeathmocompstart(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
    entity orientmode("face angle", entity.angles[1]);
    entity animmode("noclip");
    entity.pushable = 0;
}

// Namespace zombiebehavior/zombie
// Params 5, eflags: 0x0
// Checksum 0xd5069215, Offset: 0x4850
// Size: 0x6c
function zombieidgunholedeathmocompterminate(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
    if (!(isdefined(entity.interdimensional_gun_kill_vortex_explosion) && entity.interdimensional_gun_kill_vortex_explosion)) {
        entity hide();
    }
}

// Namespace zombiebehavior/zombie
// Params 5, eflags: 0x4
// Checksum 0xb90ec626, Offset: 0x48c8
// Size: 0x7c
function private zombieturnmocompstart(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
    entity orientmode("face angle", entity.angles[1]);
    entity animmode("angle deltas", 0);
}

// Namespace zombiebehavior/zombie
// Params 5, eflags: 0x4
// Checksum 0x3e77996d, Offset: 0x4950
// Size: 0xac
function private zombieturnmocompupdate(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
    normalizedtime = (entity getanimtime(mocompanim) + mocompanimblendouttime) / mocompduration;
    if (normalizedtime > 0.25) {
        entity orientmode("face motion");
        entity animmode("normal", 0);
    }
}

// Namespace zombiebehavior/zombie
// Params 5, eflags: 0x4
// Checksum 0x19072583, Offset: 0x4a08
// Size: 0x6c
function private zombieturnmocompterminate(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
    entity orientmode("face motion");
    entity animmode("normal", 0);
}

// Namespace zombiebehavior/zombie
// Params 1, eflags: 0x0
// Checksum 0xa850e8c0, Offset: 0x4a80
// Size: 0x2c
function zombiehaslegs(behaviortreeentity) {
    if (behaviortreeentity.missinglegs === 1) {
        return false;
    }
    return true;
}

// Namespace zombiebehavior/zombie
// Params 1, eflags: 0x0
// Checksum 0xac0cc0ba, Offset: 0x4ab8
// Size: 0x70
function zombieshouldproceduraltraverse(entity) {
    return isdefined(entity.traversestartnode) && isdefined(entity.traverseendnode) && entity.traversestartnode.spawnflags & 1024 && entity.traverseendnode.spawnflags & 1024;
}

// Namespace zombiebehavior/zombie
// Params 1, eflags: 0x0
// Checksum 0x284b6684, Offset: 0x4b30
// Size: 0xd0
function zombieshouldmeleesuicide(behaviortreeentity) {
    if (!behaviortreeentity ai::get_behavior_attribute("suicidal_behavior")) {
        return false;
    }
    if (isdefined(behaviortreeentity.magic_bullet_shield) && behaviortreeentity.magic_bullet_shield) {
        return false;
    }
    if (!isdefined(behaviortreeentity.enemy)) {
        return false;
    }
    if (isdefined(behaviortreeentity.marked_for_death)) {
        return false;
    }
    if (distancesquared(behaviortreeentity.origin, behaviortreeentity.enemy.origin) > 40000) {
        return false;
    }
    return true;
}

// Namespace zombiebehavior/zombie
// Params 1, eflags: 0x0
// Checksum 0x571b6cbe, Offset: 0x4c08
// Size: 0x4c
function zombiemeleesuicidestart(behaviortreeentity) {
    behaviortreeentity.blockingpain = 1;
    if (isdefined(level.zombiemeleesuicidecallback)) {
        behaviortreeentity thread [[ level.zombiemeleesuicidecallback ]](behaviortreeentity);
    }
}

// Namespace zombiebehavior/zombie
// Params 1, eflags: 0x0
// Checksum 0x652447cf, Offset: 0x4c60
// Size: 0xc
function zombiemeleesuicideupdate(behaviortreeentity) {
    
}

// Namespace zombiebehavior/zombie
// Params 1, eflags: 0x0
// Checksum 0x91ff6cdb, Offset: 0x4c78
// Size: 0x90
function zombiemeleesuicideterminate(behaviortreeentity) {
    if (isalive(behaviortreeentity) && zombieshouldmeleesuicide(behaviortreeentity)) {
        behaviortreeentity.takedamage = 1;
        behaviortreeentity.allowdeath = 1;
        if (isdefined(level.zombiemeleesuicidedonecallback)) {
            behaviortreeentity thread [[ level.zombiemeleesuicidedonecallback ]](behaviortreeentity);
        }
    }
}

// Namespace zombiebehavior/zombie
// Params 2, eflags: 0x0
// Checksum 0x46d80ac4, Offset: 0x4d10
// Size: 0x120
function zombiemoveaction(behaviortreeentity, asmstatename) {
    behaviortreeentity.movetime = gettime();
    behaviortreeentity.moveorigin = behaviortreeentity.origin;
    animationstatenetworkutility::requeststate(behaviortreeentity, asmstatename);
    if (isdefined(behaviortreeentity.stumble) && !isdefined(behaviortreeentity.move_anim_end_time)) {
        stumbleactionresult = behaviortreeentity astsearch(istring(asmstatename));
        stumbleactionanimation = animationstatenetworkutility::searchanimationmap(behaviortreeentity, stumbleactionresult["animation"]);
        behaviortreeentity.move_anim_end_time = behaviortreeentity.movetime + getanimlength(stumbleactionanimation);
    }
    return 5;
}

// Namespace zombiebehavior/zombie
// Params 2, eflags: 0x0
// Checksum 0xb65b8cdb, Offset: 0x4e38
// Size: 0x1f2
function zombiemoveactionupdate(behaviortreeentity, asmstatename) {
    if (isdefined(behaviortreeentity.move_anim_end_time) && gettime() >= behaviortreeentity.move_anim_end_time) {
        behaviortreeentity.move_anim_end_time = undefined;
        return 4;
    }
    if (!(isdefined(behaviortreeentity.missinglegs) && behaviortreeentity.missinglegs) && gettime() - behaviortreeentity.movetime > 1000) {
        distsq = distance2dsquared(behaviortreeentity.origin, behaviortreeentity.moveorigin);
        if (distsq < 144) {
            behaviortreeentity setavoidancemask("avoid all");
            behaviortreeentity.cant_move = 1;
            if (isdefined(behaviortreeentity.cant_move_cb)) {
                behaviortreeentity [[ behaviortreeentity.cant_move_cb ]]();
            }
        } else {
            behaviortreeentity setavoidancemask("avoid none");
            behaviortreeentity.cant_move = 0;
        }
        behaviortreeentity.movetime = gettime();
        behaviortreeentity.moveorigin = behaviortreeentity.origin;
    }
    if (behaviortreeentity asmgetstatus() == "asm_status_complete") {
        if (behaviortreeentity iscurrentbtactionlooping()) {
            zombiemoveaction(behaviortreeentity, asmstatename);
        } else {
            return 4;
        }
    }
    return 5;
}

// Namespace zombiebehavior/zombie
// Params 2, eflags: 0x0
// Checksum 0x341e87aa, Offset: 0x5038
// Size: 0x58
function zombiemoveactionterminate(behaviortreeentity, asmstatename) {
    if (!(isdefined(behaviortreeentity.missinglegs) && behaviortreeentity.missinglegs)) {
        behaviortreeentity setavoidancemask("avoid none");
    }
    return 4;
}

// Namespace zombiebehavior/zombie
// Params 0, eflags: 0x0
// Checksum 0x3acab5ed, Offset: 0x5098
// Size: 0x24
function archetypezombiedeathoverrideinit() {
    aiutility::addaioverridekilledcallback(self, &zombiegibkilledanhilateoverride);
}

// Namespace zombiebehavior/zombie
// Params 8, eflags: 0x4
// Checksum 0xcf4d5846, Offset: 0x50c8
// Size: 0x310
function private zombiegibkilledanhilateoverride(inflictor, attacker, damage, meansofdeath, weapon, dir, hitloc, offsettime) {
    if (!(isdefined(level.zombieanhilationenabled) && level.zombieanhilationenabled)) {
        return damage;
    }
    if (isdefined(self.forceanhilateondeath) && self.forceanhilateondeath) {
        self zombie_utility::gib_random_parts();
        gibserverutils::annihilate(self);
        return damage;
    }
    if (isdefined(level.forceanhilateondeath) && (isdefined(attacker.forceanhilateondeath) && attacker.forceanhilateondeath || isdefined(attacker) && isplayer(attacker) && level.forceanhilateondeath)) {
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
// Checksum 0xbac50d31, Offset: 0x53e0
// Size: 0x11c
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
// Checksum 0x34cd9812, Offset: 0x5508
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
// Checksum 0x700118c9, Offset: 0x55e8
// Size: 0x6c
function private zombieattackobjectmocompupdate(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
    if (isdefined(entity.attackable_slot)) {
        entity forceteleport(entity.attackable_slot.origin);
    }
}

