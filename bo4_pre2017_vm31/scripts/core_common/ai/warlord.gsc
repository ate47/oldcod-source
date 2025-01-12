#using scripts/core_common/ai/archetype_locomotion_utility;
#using scripts/core_common/ai/archetype_mocomps_utility;
#using scripts/core_common/ai/archetype_utility;
#using scripts/core_common/ai/archetype_warlord_interface;
#using scripts/core_common/ai/systems/ai_blackboard;
#using scripts/core_common/ai/systems/ai_interface;
#using scripts/core_common/ai/systems/animation_state_machine_notetracks;
#using scripts/core_common/ai/systems/animation_state_machine_utility;
#using scripts/core_common/ai/systems/behavior_tree_utility;
#using scripts/core_common/ai/systems/blackboard;
#using scripts/core_common/ai/systems/debug;
#using scripts/core_common/ai_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/fx_shared;
#using scripts/core_common/gameobjects_shared;
#using scripts/core_common/laststand_shared;
#using scripts/core_common/math_shared;
#using scripts/core_common/scene_shared;
#using scripts/core_common/spawner_shared;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;

#namespace warlord;

// Namespace warlord/warlord
// Params 0, eflags: 0x2
// Checksum 0x6a4c3d83, Offset: 0x7e0
// Size: 0x34
function autoexec __init__sytem__() {
    system::register("warlord", &__init__, undefined, undefined);
}

// Namespace warlord/warlord
// Params 0, eflags: 0x0
// Checksum 0xad71ce44, Offset: 0x820
// Size: 0x13c
function __init__() {
    spawner::add_archetype_spawn_function("warlord", &namespace_c7ab8fce::function_ad72c974);
    spawner::add_archetype_spawn_function("warlord", &namespace_b4645fec::function_b65f3cc0);
    if (ai::shouldregisterclientfieldforarchetype("warlord")) {
        clientfield::register("actor", "warlord_damage_state", 1, 2, "int");
        clientfield::register("actor", "warlord_thruster_direction", 1, 3, "int");
        clientfield::register("actor", "warlord_type", 1, 2, "int");
        clientfield::register("actor", "warlord_lights_state", 1, 1, "int");
    }
    namespace_69ee7109::function_65180251();
}

#namespace namespace_c7ab8fce;

// Namespace namespace_c7ab8fce/warlord
// Params 0, eflags: 0x2
// Checksum 0x355ff2fe, Offset: 0x968
// Size: 0x5c4
function autoexec registerbehaviorscriptfunctions() {
    assert(isscriptfunctionptr(&function_80e7735));
    behaviortreenetworkutility::registerbehaviortreescriptapi("warlordCanJukeCondition", &function_80e7735);
    assert(isscriptfunctionptr(&function_f663699c));
    behaviortreenetworkutility::registerbehaviortreescriptapi("warlordCanTacticalJukeCondition", &function_f663699c);
    assert(isscriptfunctionptr(&warlordShouldNormalMelee));
    behaviortreenetworkutility::registerbehaviortreescriptapi("warlordShouldNormalMelee", &warlordShouldNormalMelee);
    assert(isscriptfunctionptr(&function_47cb87ef));
    behaviortreenetworkutility::registerbehaviortreescriptapi("warlordCanTakePainCondition", &function_47cb87ef);
    assert(isscriptfunctionptr(&warlordShouldTransitionWoundedLastStand));
    behaviortreenetworkutility::registerbehaviortreescriptapi("warlordShouldTransitionWoundedLastStand", &warlordShouldTransitionWoundedLastStand);
    assert(iscodefunctionptr(&btapi_warlordexposedpainactionstart));
    behaviortreenetworkutility::registerbehaviortreescriptapi("warlordExposedPainActionStart", &btapi_warlordexposedpainactionstart);
    assert(isscriptfunctionptr(&warlordWoundedTransitionComplete));
    behaviortreenetworkutility::registerbehaviortreescriptapi("warlordWoundedTransitionComplete", &warlordWoundedTransitionComplete);
    assert(!isdefined(&function_5e6a5213) || isscriptfunctionptr(&function_5e6a5213));
    assert(!isdefined(undefined) || isscriptfunctionptr(undefined));
    assert(!isdefined(undefined) || isscriptfunctionptr(undefined));
    behaviortreenetworkutility::registerbehaviortreeaction("warlordDeathAction", &function_5e6a5213, undefined, undefined);
    assert(!isdefined(&function_296ed07c) || isscriptfunctionptr(&function_296ed07c));
    assert(!isdefined(undefined) || isscriptfunctionptr(undefined));
    assert(!isdefined(&function_4daf9b71) || isscriptfunctionptr(&function_4daf9b71));
    behaviortreenetworkutility::registerbehaviortreeaction("warlordJukeAction", &function_296ed07c, undefined, &function_4daf9b71);
    assert(isscriptfunctionptr(&chooseBetterPositionService));
    behaviortreenetworkutility::registerbehaviortreescriptapi("chooseBetterPositionService", &chooseBetterPositionService);
    assert(isscriptfunctionptr(&warlordIsWounded));
    behaviortreenetworkutility::registerbehaviortreescriptapi("warlordIsWounded", &warlordIsWounded);
    assert(isscriptfunctionptr(&warlordSetupWounded));
    behaviortreenetworkutility::registerbehaviortreescriptapi("warlordSetupWounded", &warlordSetupWounded);
}

// Namespace namespace_c7ab8fce/warlord
// Params 0, eflags: 0x4
// Checksum 0xcb579ad6, Offset: 0xf38
// Size: 0x4c
function private function_ad72c974() {
    blackboard::createblackboardforentity(self);
    ai::createinterfaceforentity(self);
    self.___archetypeonanimscriptedcallback = &function_327511a;
}

// Namespace namespace_c7ab8fce/warlord
// Params 1, eflags: 0x4
// Checksum 0xafd9cbf8, Offset: 0xf90
// Size: 0x34
function private function_327511a(entity) {
    entity.__blackboard = undefined;
    entity function_ad72c974();
}

// Namespace namespace_c7ab8fce/warlord
// Params 1, eflags: 0x4
// Checksum 0x911a0ad8, Offset: 0xfd0
// Size: 0x50
function private warlordIsWounded(entity) {
    var_bd0703c = entity getblackboardattribute("_wounded_type");
    if (var_bd0703c == "wounded_yes") {
        return true;
    }
    return false;
}

// Namespace namespace_c7ab8fce/warlord
// Params 1, eflags: 0x4
// Checksum 0xe3c84317, Offset: 0x1028
// Size: 0x3a
function private warlordShouldTransitionWoundedLastStand(entity) {
    if (isdefined(entity.var_96ac8ed) && entity.var_96ac8ed) {
        return true;
    }
    return false;
}

// Namespace namespace_c7ab8fce/warlord
// Params 1, eflags: 0x4
// Checksum 0xda91edb9, Offset: 0x1070
// Size: 0x2c
function private warlordSetupWounded(entity) {
    entity damagemode("next_shot_kills");
}

// Namespace namespace_c7ab8fce/warlord
// Params 1, eflags: 0x4
// Checksum 0xe5960eb5, Offset: 0x10a8
// Size: 0x50
function private function_5a83bc0a(entity) {
    if (isdefined(entity.enemy) && isdefined(entity.var_ce767dbd) && gettime() < entity.var_ce767dbd) {
        return true;
    }
    return false;
}

// Namespace namespace_c7ab8fce/warlord
// Params 1, eflags: 0x4
// Checksum 0xe615ebb9, Offset: 0x1100
// Size: 0x37c
function private function_9b66e9bc(entity) {
    /#
        namespace_e585b400::function_3f561bff(entity, 3, 1);
    #/
    if (distance2dsquared(entity.origin, self lastknownpos(self.enemy)) <= 250 * 250) {
        return false;
    }
    if (isdefined(entity.var_c9cd0861) && gettime() < entity.var_c9cd0861) {
        return false;
    }
    positiononnavmesh = getclosestpointonnavmesh(self lastknownpos(self.enemy), 200);
    if (!isdefined(positiononnavmesh)) {
        positiononnavmesh = self lastknownpos(self.enemy);
    }
    queryresult = positionquery_source_navigation(positiononnavmesh, 150, 250, 45, 36, entity, 36);
    positionquery_filter_inclaimedlocation(queryresult, entity);
    positionquery_filter_distancetogoal(queryresult, entity);
    if (queryresult.data.size > 0) {
        closestpoint = undefined;
        closestdistance = undefined;
        foreach (point in queryresult.data) {
            if (!point.inclaimedlocation && point.disttogoal == 0) {
                newclosestdistance = distance2dsquared(entity.origin, point.origin);
                if (!isdefined(closestpoint) || newclosestdistance < closestdistance) {
                    closestpoint = point.origin;
                    closestdistance = newclosestdistance;
                }
            }
        }
        if (isdefined(closestpoint)) {
            /#
                namespace_e585b400::function_4160d34d(entity, 3, 1);
            #/
            entity useposition(closestpoint);
            entity.var_c9cd0861 = gettime() + randomintrange(500, 1500);
            return true;
        }
    }
    /#
        namespace_e585b400::function_c2db5ca5(entity, 3);
    #/
    entity.var_ce767dbd = undefined;
    return false;
}

// Namespace namespace_c7ab8fce/warlord
// Params 1, eflags: 0x0
// Checksum 0xadabfbe, Offset: 0x1488
// Size: 0xf24
function chooseBetterPositionService(entity) {
    if (entity asmistransitionrunning() || entity getbehaviortreestatus() != 5 || entity asmissubstatepending() || entity asmistransdecrunning()) {
        return 0;
    }
    shouldrepath = 0;
    var_cb05c034 = 0;
    searchorigin = undefined;
    var_976ace1e = entity isapproachinggoal();
    if (!var_976ace1e) {
        /#
            namespace_e585b400::function_4160d34d(entity, 6);
        #/
        if (isdefined(entity.goalent) || entity.goalradius < 72) {
            var_e972a672 = getclosestpointonnavmesh(self.goalpos, 200);
            if (!isdefined(var_e972a672)) {
                var_e972a672 = self.goalpos;
            }
            entity useposition(var_e972a672);
            return 1;
        }
    }
    if (var_976ace1e && function_5a83bc0a(entity)) {
        return function_9b66e9bc(entity);
    } else if (isdefined(entity.enemy) && isdefined(entity.lastenemysightpos) && !namespace_b4645fec::function_d55b9558(entity)) {
        searchorigin = entity.lastenemysightpos;
    } else {
        /#
            entity namespace_e585b400::function_3d68d6d1(undefined, (1, 0, 0), "<dev string:x28>");
        #/
        searchorigin = entity.goalpos;
    }
    if (isdefined(searchorigin)) {
        searchorigin = getclosestpointonnavmesh(searchorigin, 200);
    }
    if (!isdefined(searchorigin)) {
        return 0;
    }
    if (!var_976ace1e || !isdefined(entity.var_26ca18bb) || gettime() > entity.var_26ca18bb) {
        shouldrepath = 1;
    }
    if (isdefined(entity.enemy) && !entity seerecently(entity.enemy, 2) && isdefined(entity.lastenemysightpos)) {
        /#
            entity namespace_e585b400::function_3d68d6d1(undefined, (1, 1, 1), "<dev string:x44>");
        #/
        var_cb05c034 = 1;
        if (isdefined(entity.pathgoalpos)) {
            distancetogoalsqr = distancesquared(searchorigin, entity.pathgoalpos);
            if (distancetogoalsqr < 200 * 200) {
                shouldrepath = 0;
            }
        } else {
            shouldrepath = 1;
        }
    }
    if (!shouldrepath) {
        if (isdefined(entity.var_ecf7b5b1)) {
            entity.var_ecf7b5b1 = undefined;
            shouldrepath = 1;
        }
    }
    if (shouldrepath) {
        queryresult = positionquery_source_navigation(searchorigin, 0, entity.engagemaxdist, 45, 72, entity, 72);
        positionquery_filter_inclaimedlocation(queryresult, entity);
        positionquery_filter_distancetogoal(queryresult, entity);
        randompoints = [];
        var_20e1d4f5 = 0;
        var_8259f71c = 0;
        var_1d39aec2 = 0;
        var_c713e0ba = 36;
        foreach (point in queryresult.data) {
            if (point.inclaimedlocation) {
                continue;
            }
            var_20e1d4f5++;
            if (point.disttogoal > 0) {
                continue;
            }
            var_8259f71c++;
            if (isdefined(point.visibility) && !point.visibility) {
                continue;
            }
            var_1d39aec2++;
            if (point.disttoorigin2d < var_c713e0ba) {
                continue;
            }
            randompoints[randompoints.size] = point.origin;
        }
        if (randompoints.size == 0) {
            if (var_20e1d4f5 == 0) {
                return 0;
            } else if (var_8259f71c == 0) {
                var_fe3237cf = entity.goalpos + vectornormalize(searchorigin - entity.goalpos) * entity.goalradius;
                queryresult = positionquery_source_navigation(var_fe3237cf, 0, entity.engagemaxdist, 45, 72, entity, 108);
                positionquery_filter_inclaimedlocation(queryresult, entity);
                positionquery_filter_distancetogoal(queryresult, entity);
                var_20e1d4f5 = 0;
                var_8259f71c = 0;
                var_1d39aec2 = 0;
                foreach (point in queryresult.data) {
                    if (point.inclaimedlocation) {
                        continue;
                    }
                    var_20e1d4f5++;
                    if (point.disttogoal > 0) {
                        continue;
                    }
                    var_8259f71c++;
                    if (isdefined(point.visibility) && !point.visibility) {
                        continue;
                    }
                    var_1d39aec2++;
                    if (point.disttoorigin2d < var_c713e0ba) {
                        continue;
                    }
                    randompoints[randompoints.size] = point.origin;
                }
                if (randompoints.size == 0) {
                    foreach (point in queryresult.data) {
                        if (point.inclaimedlocation) {
                            continue;
                        }
                        if (point.disttogoal > 0) {
                            continue;
                        }
                        if (var_1d39aec2 > 0 && isdefined(point.visibility) && !point.visibility) {
                            continue;
                        }
                        randompoints[randompoints.size] = point.origin;
                    }
                }
            } else {
                foreach (point in queryresult.data) {
                    if (point.inclaimedlocation) {
                        continue;
                    }
                    if (point.disttogoal > 0) {
                        continue;
                    }
                    if (var_1d39aec2 > 0 && isdefined(point.visibility) && !point.visibility) {
                        continue;
                    }
                    randompoints[randompoints.size] = point.origin;
                }
            }
            if (randompoints.size == 0) {
                if (!var_976ace1e) {
                    if (!isdefined(randompoints)) {
                        randompoints = [];
                    } else if (!isarray(randompoints)) {
                        randompoints = array(randompoints);
                    }
                    randompoints[randompoints.size] = entity.goalpos;
                } else {
                    /#
                        namespace_e585b400::function_c2db5ca5(entity, 5);
                    #/
                    return 0;
                }
            }
        }
        goalweight = -10000;
        var_c3fc0358 = entity.engageminfalloffdist * entity.engageminfalloffdist;
        var_4b54d64a = entity.engagemindist * entity.engagemindist;
        var_c9068104 = entity.engagemaxdist * entity.engagemaxdist;
        var_a3945c26 = entity.engagemaxfalloffdist * entity.engagemaxfalloffdist;
        if (isdefined(entity.enemy) && issentient(entity.enemy)) {
            var_7b1a8986 = vectornormalize(anglestoforward(entity.enemy.angles));
        }
        for (index = 0; index < randompoints.size; index++) {
            var_ec0332d3 = distance2dsquared(randompoints[index], searchorigin);
            var_6c2b207a = 1;
            if (isdefined(var_cb05c034)) {
                var_6c2b207a = -1;
            }
            var_1fe6d199 = 0;
            if (var_ec0332d3 < var_c3fc0358) {
                var_1fe6d199 = -1 * var_6c2b207a;
            } else if (var_ec0332d3 < var_4b54d64a) {
                var_1fe6d199 = -0.5 * var_6c2b207a;
            } else if (var_ec0332d3 > var_a3945c26) {
                var_1fe6d199 = 1 * var_6c2b207a;
            } else if (var_ec0332d3 > var_c9068104) {
                var_1fe6d199 = 1 * var_6c2b207a;
            }
            if (isdefined(var_7b1a8986)) {
                var_f8b1c22d = acos(math::clamp(vectordot(vectornormalize(var_1fe6d199 - entity.enemy.origin), var_7b1a8986), -1, 1));
                if (var_f8b1c22d > 80) {
                    var_1fe6d199 += -0.5;
                }
            }
            var_1fe6d199 += randomfloatrange(-0.25, 0.25);
            if (goalweight < var_1fe6d199) {
                goalweight = var_1fe6d199;
                goalposition = randompoints[index];
            }
            /#
                if (getdvarint("<dev string:x59>") > 0 && isdefined(getentbynum(getdvarint("<dev string:x59>"))) && entity == getentbynum(getdvarint("<dev string:x59>"))) {
                    as_debug::debugdrawweightedpoint(entity, randompoints[index], var_1fe6d199, -1.25, 1.75);
                }
            #/
        }
        var_cfb305f0 = goalweight;
        if (isdefined(goalposition)) {
            if (entity findpath(entity.origin, goalposition, 1, 0)) {
                entity useposition(goalposition);
                entity.var_26ca18bb = gettime() + entity.coversearchinterval;
                /#
                    namespace_e585b400::function_4160d34d(entity, 5);
                #/
                return 1;
            }
        }
    }
    return 0;
}

// Namespace namespace_c7ab8fce/warlord
// Params 1, eflags: 0x4
// Checksum 0x1f377ab8, Offset: 0x23b8
// Size: 0x1c
function private warlordWoundedTransitionComplete(entity) {
    entity.var_96ac8ed = 0;
}

// Namespace namespace_c7ab8fce/warlord
// Params 1, eflags: 0x0
// Checksum 0xb3c422cb, Offset: 0x23e0
// Size: 0x4a
function function_80e7735(behaviortreeentity) {
    if (isdefined(behaviortreeentity.var_b948f7a) && gettime() < behaviortreeentity.var_b948f7a) {
        return 0;
    }
    return namespace_b4645fec::function_96271879(behaviortreeentity);
}

// Namespace namespace_c7ab8fce/warlord
// Params 1, eflags: 0x0
// Checksum 0x25ab52c3, Offset: 0x2438
// Size: 0x4a
function function_f663699c(behaviortreeentity) {
    if (isdefined(behaviortreeentity.var_b948f7a) && gettime() < behaviortreeentity.var_b948f7a) {
        return 0;
    }
    return namespace_b4645fec::function_34d050ea(behaviortreeentity);
}

// Namespace namespace_c7ab8fce/warlord
// Params 1, eflags: 0x0
// Checksum 0x76d95c21, Offset: 0x2490
// Size: 0x2c8
function warlordShouldNormalMelee(behaviortreeentity) {
    if (isdefined(behaviortreeentity.enemy) && !(isdefined(behaviortreeentity.enemy.allowdeath) && behaviortreeentity.enemy.allowdeath)) {
        return false;
    }
    if (btapi_hasenemy(behaviortreeentity) && !isalive(behaviortreeentity.enemy)) {
        return false;
    }
    if (!issentient(behaviortreeentity.enemy)) {
        return false;
    }
    if (isvehicle(behaviortreeentity.enemy) && isdefined(behaviortreeentity.enemy.ai) && !(isdefined(behaviortreeentity.enemy.ai.good_melee_target) && behaviortreeentity.enemy.ai.good_melee_target)) {
        return false;
    }
    if (!aiutility::shouldmutexmelee(behaviortreeentity)) {
        return false;
    }
    if (behaviortreeentity ai::has_behavior_attribute("can_melee") && !behaviortreeentity ai::get_behavior_attribute("can_melee")) {
        return false;
    }
    if (behaviortreeentity.enemy ai::has_behavior_attribute("can_be_meleed") && !behaviortreeentity.enemy ai::get_behavior_attribute("can_be_meleed")) {
        return false;
    }
    if (!isplayer(behaviortreeentity.enemy) && !(isdefined(behaviortreeentity.enemy.magic_bullet_shield) && behaviortreeentity.enemy.magic_bullet_shield)) {
        return false;
    }
    if (aiutility::hascloseenemytomeleewithrange(behaviortreeentity, 100 * 100)) {
        if (namespace_b4645fec::function_54978bb4(behaviortreeentity.enemy)) {
            namespace_b4645fec::function_c17a57a6(behaviortreeentity);
            return false;
        }
        return true;
    }
    return false;
}

// Namespace namespace_c7ab8fce/warlord
// Params 1, eflags: 0x0
// Checksum 0xe73ee317, Offset: 0x2760
// Size: 0x24
function function_47cb87ef(behaviortreeentity) {
    return gettime() >= behaviortreeentity.ai.nextpaintime;
}

// Namespace namespace_c7ab8fce/warlord
// Params 2, eflags: 0x0
// Checksum 0x45a26fcd, Offset: 0x2790
// Size: 0x1c0
function function_296ed07c(behaviortreeentity, asmstatename) {
    if (namespace_b4645fec::function_d55b9558(behaviortreeentity)) {
        var_b948f7a = 1000;
    } else {
        var_b948f7a = 3000;
    }
    behaviortreeentity.var_b948f7a = gettime() + var_b948f7a;
    animationstatenetworkutility::requeststate(behaviortreeentity, asmstatename);
    jukedirection = behaviortreeentity getblackboardattribute("_juke_direction");
    switch (jukedirection) {
    case #"left":
        clientfield::set("warlord_thruster_direction", 4);
        break;
    case #"right":
        clientfield::set("warlord_thruster_direction", 3);
        break;
    }
    behaviortreeentity clearpath();
    jukeinfo = spawnstruct();
    jukeinfo.origin = behaviortreeentity.origin;
    jukeinfo.entity = behaviortreeentity;
    blackboard::addblackboardevent("actor_juke", jukeinfo, 2000);
    jukeinfo.entity playsound("fly_jetpack_juke_warlord");
    return 5;
}

// Namespace namespace_c7ab8fce/warlord
// Params 2, eflags: 0x0
// Checksum 0x990e9730, Offset: 0x2958
// Size: 0xb0
function function_4daf9b71(behaviortreeentity, asmstatename) {
    behaviortreeentity setblackboardattribute("_juke_direction", undefined);
    clientfield::set("warlord_thruster_direction", 0);
    positiononnavmesh = getclosestpointonnavmesh(behaviortreeentity.origin, 200);
    if (!isdefined(positiononnavmesh)) {
        positiononnavmesh = behaviortreeentity.origin;
    }
    behaviortreeentity useposition(positiononnavmesh);
    return 4;
}

// Namespace namespace_c7ab8fce/warlord
// Params 2, eflags: 0x0
// Checksum 0x2fb5cc92, Offset: 0x2a10
// Size: 0x50
function function_5e6a5213(behaviortreeentity, asmstatename) {
    clientfield::set("warlord_damage_state", 3);
    animationstatenetworkutility::requeststate(behaviortreeentity, asmstatename);
    return 5;
}

// Namespace namespace_c7ab8fce/warlord
// Params 1, eflags: 0x0
// Checksum 0x90591be4, Offset: 0x2a68
// Size: 0x5c
function function_a778e8e3(behaviortreeentity) {
    behaviortreeentity.ai.nextpaintime = gettime() + randomintrange(500, 2500);
    aiutility::keepclaimnode(behaviortreeentity);
}

#namespace namespace_b4645fec;

// Namespace namespace_b4645fec/warlord
// Params 1, eflags: 0x0
// Checksum 0x9d7fcdd, Offset: 0x2ad0
// Size: 0x154
function function_96271879(entity) {
    if (!isdefined(entity.enemy)) {
        return false;
    }
    distancesqr = distancesquared(entity.enemy.origin, entity.origin);
    if (distancesqr < 300 * 300) {
        jukedistance = 72.5;
    } else {
        jukedistance = 145;
    }
    jukedirection = aiutility::calculatejukedirection(entity, 18, jukedistance);
    if (jukedirection != "forward") {
        entity setblackboardattribute("_juke_direction", jukedirection);
        if (jukedistance == 145) {
            entity setblackboardattribute("_juke_distance", "long");
        } else {
            entity setblackboardattribute("_juke_distance", "short");
        }
        return true;
    }
    return false;
}

// Namespace namespace_b4645fec/warlord
// Params 1, eflags: 0x0
// Checksum 0xc21ddfe4, Offset: 0x2c30
// Size: 0xf4
function function_34d050ea(entity) {
    if (entity haspath()) {
        var_26383879 = aiutility::bb_getlocomotionfaceenemyquadrant();
        if (var_26383879 == "locomotion_face_enemy_front" || var_26383879 == "locomotion_face_enemy_back") {
            jukedirection = aiutility::calculatejukedirection(entity, 50, 145);
            if (jukedirection != "forward") {
                entity setblackboardattribute("_juke_direction", jukedirection);
                entity setblackboardattribute("_juke_distance", "long");
                return true;
            }
        }
    }
    return false;
}

// Namespace namespace_b4645fec/warlord
// Params 1, eflags: 0x0
// Checksum 0xe89df585, Offset: 0x2d30
// Size: 0xa4
function function_54978bb4(enemy) {
    if (isplayer(enemy)) {
        if (isdefined(enemy.laststand) && enemy.laststand) {
            return true;
        }
        playerstance = enemy getstance();
        if (playerstance == "prone" || isdefined(playerstance) && playerstance == "crouch") {
            return true;
        }
    }
    return false;
}

// Namespace namespace_b4645fec/warlord
// Params 1, eflags: 0x0
// Checksum 0x2e752f92, Offset: 0x2de0
// Size: 0x54
function function_d55b9558(entity) {
    if (!isdefined(entity.var_db9be359)) {
        return false;
    }
    if (gettime() - entity.var_db9be359 <= 4000) {
        return true;
    }
    entity.var_db9be359 = undefined;
    return false;
}

// Namespace namespace_b4645fec/warlord
// Params 1, eflags: 0x0
// Checksum 0x2c989c3, Offset: 0x2e40
// Size: 0x4c
function function_c17a57a6(entity) {
    if (function_d55b9558(entity)) {
        return;
    }
    entity.var_db9be359 = gettime();
    entity.var_ecf7b5b1 = 1;
}

// Namespace namespace_b4645fec/warlord
// Params 2, eflags: 0x0
// Checksum 0x6166d4c8, Offset: 0x2e98
// Size: 0x1c4
function function_bc580b21(entity, attackerinfo) {
    if (attackerinfo.damage < 250) {
        return 0;
    }
    threat = 1;
    var_600fee07 = isplayer(attackerinfo.attacker);
    if (var_600fee07) {
        threat *= 10;
    }
    var_bfbf28f9 = distance2dsquared(entity.origin, attackerinfo.attacker.origin);
    var_1742c12e = 0;
    if (var_600fee07) {
        if (var_bfbf28f9 <= 100 * 100) {
            threat *= 1000;
        } else {
            var_1742c12e = var_bfbf28f9 / entity.engagemaxfalloffdist * entity.engagemaxfalloffdist;
            if (var_1742c12e > 1) {
                var_1742c12e = 1;
            }
            var_1742c12e = 1 - var_1742c12e;
        }
    }
    var_e864ad90 = attackerinfo.damage / 1000;
    if (var_e864ad90 > 1) {
        var_e864ad90 = 1;
    }
    threat *= (var_1742c12e * 0.65 + var_e864ad90 * 0.35) * 100;
    return threat;
}

// Namespace namespace_b4645fec/warlord
// Params 3, eflags: 0x0
// Checksum 0xeaa9505d, Offset: 0x3068
// Size: 0xb2
function function_5530167b(entity, attacker, threat) {
    if (entity.enemy === attacker) {
        return false;
    }
    if (!isdefined(entity.var_f8d4f481)) {
        return true;
    }
    if (entity.var_f8d4f481.health <= 0) {
        return true;
    }
    if (entity.var_f8d4f481 == attacker) {
        return false;
    }
    if (gettime() - entity.var_8af76ae5 < 1) {
        return false;
    }
    return true;
}

// Namespace namespace_b4645fec/warlord
// Params 15, eflags: 0x0
// Checksum 0xcd7446a0, Offset: 0x3128
// Size: 0x2b8
function function_fe54fdc3(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, timeoffset, boneindex, modelindex, surfacetype, surfacenormal) {
    entity = self;
    if (!isplayer(eattacker)) {
        idamage = int(idamage * 0.05);
    }
    if (smeansofdeath == "MOD_PROJECTILE" || smeansofdeath == "MOD_PROJECTILE_SPLASH" || smeansofdeath == "MOD_EXPLOSIVE" || isdefined(smeansofdeath) && smeansofdeath == "MOD_GRENADE") {
        idamage = int(idamage * 1);
    }
    if (entity.health <= entity.var_538edf9c) {
        clientfield::set("warlord_damage_state", 2);
    } else if (entity.health <= entity.var_3f5986f) {
        clientfield::set("warlord_damage_state", 1);
    } else {
        clientfield::set("warlord_damage_state", 0);
    }
    if (!isdefined(entity.lastdamagetime)) {
        entity.lastdamagetime = 0;
    }
    if (gettime() - entity.lastdamagetime > 1500) {
        entity.var_9366282a = idamage;
    } else {
        entity.var_9366282a += idamage;
    }
    var_9dcbd3e = getdvarint("warlordhuntdamage", 350);
    if (entity.var_9366282a > var_9dcbd3e) {
        self.var_ce767dbd = gettime() + 15000;
    }
    entity.lastdamagetime = gettime();
    return idamage;
}

// Namespace namespace_b4645fec/warlord
// Params 0, eflags: 0x0
// Checksum 0x9e27a681, Offset: 0x33e8
// Size: 0x1f6
function function_b65f3cc0() {
    entity = self;
    entity.ai = spawnstruct();
    entity.ai.nextpaintime = 0;
    entity.var_8af76ae5 = 0;
    entity.var_3968f41e = 0;
    entity.ignorerunandgundist = 1;
    entity.var_96ac8ed = 1;
    entity.combatmode = "no_cover";
    aiutility::addaioverridedamagecallback(entity, &function_fe54fdc3);
    entity.fullhealth = entity.health;
    entity.var_3f5986f = int(entity.fullhealth * 0.5);
    entity.var_538edf9c = int(entity.fullhealth * 0.25);
    clientfield::set("warlord_damage_state", 0);
    clientfield::set("warlord_lights_state", 1);
    switch (entity.classname) {
    case #"hash_7aa06c54":
        clientfield::set("warlord_type", 2);
        break;
    default:
        clientfield::set("warlord_type", 1);
        break;
    }
}

// Namespace namespace_b4645fec/warlord
// Params 0, eflags: 0x0
// Checksum 0x6edcf5bc, Offset: 0x35e8
// Size: 0x5c
function function_afb9d85b() {
    if (!isdefined(self.missile_repulsor)) {
        self.missile_repulsor = missile_createrepulsorent(self, 40000, 256, 1);
    }
    self thread repulsor_fx();
}

// Namespace namespace_b4645fec/warlord
// Params 0, eflags: 0x0
// Checksum 0xec55572c, Offset: 0x3650
// Size: 0x6c
function remove_repulsor() {
    self endon(#"death");
    if (isdefined(self.missile_repulsor)) {
        missile_deleteattractor(self.missile_repulsor);
        self.missile_repulsor = undefined;
    }
    wait 0.5;
    if (isdefined(self)) {
        self function_afb9d85b();
    }
}

// Namespace namespace_b4645fec/warlord
// Params 0, eflags: 0x0
// Checksum 0xa383b5e3, Offset: 0x36c8
// Size: 0xc6
function repulsor_fx() {
    self endon(#"death");
    self endon(#"hash_85c65e4");
    while (true) {
        self waittill("projectile_applyattractor", "play_meleefx");
        playfxontag("vehicle/fx_quadtank_airburst", self, "tag_origin");
        playfxontag("vehicle/fx_quadtank_airburst_ground", self, "tag_origin");
        self playsound("wpn_trophy_alert");
        self thread remove_repulsor();
        self notify(#"hash_85c65e4");
    }
}

// Namespace namespace_b4645fec/warlord
// Params 0, eflags: 0x0
// Checksum 0x760f0c0c, Offset: 0x3798
// Size: 0x5c
function trigger_player_shock_fx() {
    if (!isdefined(self._player_shock_fx_quadtank_melee)) {
        self._player_shock_fx_quadtank_melee = 0;
    }
    self._player_shock_fx_quadtank_melee = !self._player_shock_fx_quadtank_melee;
    self clientfield::set_to_player("player_shock_fx", self._player_shock_fx_quadtank_melee);
}

#namespace namespace_e585b400;

/#

    // Namespace namespace_e585b400/warlord
    // Params 3, eflags: 0x0
    // Checksum 0x765e2d75, Offset: 0x3800
    // Size: 0x23c
    function function_3d68d6d1(state, color, string) {
        if (getdvarint("<dev string:x71>") > 0) {
            if (!isdefined(string)) {
                string = "<dev string:x81>";
            }
            if (!isdefined(state)) {
                if (!isdefined(self) || !isdefined(self.lastmessage) || self.lastmessage != string) {
                    self.lastmessage = string;
                    printtoprightln(string + gettime(), color, -1);
                }
                return;
            }
            if (state == 0) {
                printtoprightln("<dev string:x82>" + string + gettime(), color, -1);
                return;
            }
            if (state == 1) {
                printtoprightln("<dev string:x98>" + string + gettime(), color, -1);
                return;
            }
            if (state == 2) {
                printtoprightln("<dev string:xad>" + string + gettime(), color, -1);
                return;
            }
            if (state == 3) {
                printtoprightln("<dev string:xcd>" + string + gettime(), color, -1);
                return;
            }
            if (state == 5) {
                printtoprightln("<dev string:xe1>" + string + gettime(), color, -1);
                return;
            }
            if (state == 6) {
                printtoprightln("<dev string:xfd>" + string + gettime(), color, -1);
            }
        }
    }

    // Namespace namespace_e585b400/warlord
    // Params 3, eflags: 0x0
    // Checksum 0x9de21d03, Offset: 0x3a48
    // Size: 0x94
    function function_3f561bff(entity, state, var_db3a489f) {
        if (getdvarint("<dev string:x71>") > 0) {
            if (!(isdefined(var_db3a489f) && isnewstate(entity, state))) {
                color = (1, 1, 1);
                entity function_3d68d6d1(state, color);
            }
        }
    }

#/

// Namespace namespace_e585b400/warlord
// Params 3, eflags: 0x0
// Checksum 0xa7a74f2b, Offset: 0x3ae8
// Size: 0x118
function function_4160d34d(entity, state, var_4b0cc01e) {
    if (!isdefined(var_4b0cc01e)) {
        var_4b0cc01e = 0;
    }
    /#
        if (getdvarint("<dev string:x71>") > 0) {
            if (!isdefined(var_4b0cc01e) || isnewstate(entity, state)) {
                color = (0, 1, 0);
            } else {
                color = (0, 1, 1);
            }
            if (!isdefined(state)) {
                color = (0, 0, 1);
                entity function_3d68d6d1(entity.currentstate, color, "<dev string:x111>");
            }
            entity function_3d68d6d1(state, color);
        }
    #/
    entity.currentstate = state;
}

/#

    // Namespace namespace_e585b400/warlord
    // Params 2, eflags: 0x0
    // Checksum 0x1f831cf3, Offset: 0x3c08
    // Size: 0x6c
    function function_c2db5ca5(entity, state) {
        if (getdvarint("<dev string:x71>") > 0) {
            color = (1, 1, 0);
            entity function_3d68d6d1(state, color);
        }
    }

#/

// Namespace namespace_e585b400/warlord
// Params 2, eflags: 0x0
// Checksum 0x78a765ee, Offset: 0x3c80
// Size: 0x7e
function isnewstate(entity, state) {
    var_42b6f508 = 0;
    if (!isdefined(entity.currentstate)) {
        var_42b6f508 = 1;
    } else if (!isdefined(state)) {
        return 0;
    } else if (entity.currentstate != state) {
        var_42b6f508 = 1;
    }
    return var_42b6f508;
}

