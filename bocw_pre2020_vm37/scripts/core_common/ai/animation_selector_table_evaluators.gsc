#using scripts\core_common\ai\systems\animation_selector_table;
#using scripts\core_common\animation_shared;

#namespace animation_selector_table_evaluators;

// Namespace animation_selector_table_evaluators/animation_selector_table_evaluators
// Params 0, eflags: 0x2
// Checksum 0xd2e54a73, Offset: 0x1d0
// Size: 0x1bc
function autoexec registerastscriptfunctions() {
    animationselectortable::registeranimationselectortableevaluator("testFunction", &testfunction);
    animationselectortable::registeranimationselectortableevaluator("evaluateBlockedAnimations", &evaluateblockedanimations);
    animationselectortable::registeranimationselectortableevaluator("evaluateBlockedNoStairsAnimations", &evaluateblockednostairsanimations);
    animationselectortable::registeranimationselectortableevaluator("evaluateBlockedAnimationsRelaxed", &evaluateblockedanimationsrelaxed);
    animationselectortable::registeranimationselectortableevaluator("evaluateBlockedAnimationsOffNavmesh", &evaluateblockedanimationsoffnavmesh);
    animationselectortable::registeranimationselectortableevaluator("evaluateHumanTurnAnimations", &evaluatehumanturnanimations);
    animationselectortable::registeranimationselectortableevaluator("matchPrePlannedTurn", &matchpreplannedturn);
    animationselectortable::registeranimationselectortableevaluator("planHumanTurnAnimations", &planhumanturnanimations);
    animationselectortable::registeranimationselectortableevaluator("evaluateHumanExposedArrivalAnimations", &evaluatehumanexposedarrivalanimations);
    animationselectortable::registeranimationselectortableevaluator("evaluateJukeBlockedAnimations", &evaluatejukeblockedanimations);
    animationselectortable::registeranimationselectortableevaluator("humanDeathEvaluation", &humandeathevaluation);
}

// Namespace animation_selector_table_evaluators/animation_selector_table_evaluators
// Params 2, eflags: 0x1 linked
// Checksum 0x2a9e0b81, Offset: 0x398
// Size: 0x46
function testfunction(*entity, animations) {
    if (isarray(animations) && animations.size > 0) {
        return animations[0];
    }
}

// Namespace animation_selector_table_evaluators/animation_selector_table_evaluators
// Params 2, eflags: 0x5 linked
// Checksum 0x3e09c81a, Offset: 0x3e8
// Size: 0x196
function private function_aa7530df(entity, animation) {
    pixbeginevent(#"hash_4d3bcaa6273fc838");
    assert(isactor(entity));
    forwarddir = anglestoforward(entity.angles);
    localdeltavector = getmovedelta(animation, 0, 1);
    endpoint = entity localtoworldcoords(localdeltavector);
    forwardpoint = endpoint + vectorscale(forwarddir, 100);
    /#
        recordline(entity.origin, endpoint, (0, 0, 1), "<dev string:x38>", entity);
        recordline(endpoint, forwardpoint, (1, 0.5, 0), "<dev string:x38>", entity);
    #/
    if (entity maymovefrompointtopoint(endpoint, forwardpoint, 1, 1)) {
        pixendevent();
        return true;
    }
    pixendevent();
    return false;
}

// Namespace animation_selector_table_evaluators/animation_selector_table_evaluators
// Params 2, eflags: 0x5 linked
// Checksum 0xcd67ee27, Offset: 0x588
// Size: 0x74
function private evaluatejukeblockedanimations(entity, animations) {
    if (animations.size > 0) {
        return evaluator_findfirstvalidanimation(entity, animations, array(&evaluator_checkanimationagainstnavmesh, &function_aa7530df, &evaluator_checkanimationforovershootinggoal));
    }
}

// Namespace animation_selector_table_evaluators/animation_selector_table_evaluators
// Params 2, eflags: 0x5 linked
// Checksum 0x18cc06ca, Offset: 0x608
// Size: 0x256
function private evaluator_checkanimationagainstgeo(entity, animation) {
    pixbeginevent(#"evaluator_checkanimationagainstgeo");
    assert(isactor(entity));
    splittime = function_382b0cfb(animation);
    localdeltahalfvector = getmovedelta(animation, 0, splittime);
    midpoint = entity localtoworldcoords(localdeltahalfvector);
    midpoint = (midpoint[0], midpoint[1], entity.origin[2] + 6);
    /#
        recordline(entity.origin, midpoint, (1, 0.5, 0), "<dev string:x38>", entity);
    #/
    if (entity maymovetopoint(midpoint, 1, 1, entity, 0.05)) {
        localdeltavector = getmovedelta(animation, 0, 1);
        endpoint = entity localtoworldcoords(localdeltavector);
        endpoint = (endpoint[0], endpoint[1], entity.origin[2] + 6);
        /#
            recordline(midpoint, endpoint, (1, 0.5, 0), "<dev string:x38>", entity);
        #/
        if (entity maymovefrompointtopoint(midpoint, endpoint, 1, 1, entity, 0.05)) {
            pixendevent();
            return true;
        }
    }
    pixendevent();
    return false;
}

// Namespace animation_selector_table_evaluators/animation_selector_table_evaluators
// Params 2, eflags: 0x4
// Checksum 0x352e549, Offset: 0x868
// Size: 0x14e
function private evaluator_checkanimationendpointagainstgeo(entity, animation) {
    pixbeginevent(#"evaluator_checkanimationendpointagainstgeo");
    assert(isactor(entity));
    localdeltavector = getmovedelta(animation, 0, 1);
    var_e21fa5a4 = entity.angles + (0, entity function_144f21ef(), 0);
    endpoint = coordtransform(localdeltavector, entity.origin, var_e21fa5a4);
    endpoint = (endpoint[0], endpoint[1], entity.origin[2]);
    if (entity maymovetopoint(endpoint, 0, 0)) {
        pixendevent();
        return true;
    }
    pixendevent();
    return false;
}

// Namespace animation_selector_table_evaluators/animation_selector_table_evaluators
// Params 2, eflags: 0x5 linked
// Checksum 0x3aa97c96, Offset: 0x9c0
// Size: 0x144
function private function_91a832bb(entity, animation) {
    localdeltavector = getmovedelta(animation, 0, 1);
    var_f0ccb726 = lengthsquared(localdeltavector);
    if (var_f0ccb726 > function_a3f6cdac(entity getpathlength())) {
        return false;
    }
    splittime = function_382b0cfb(animation);
    localdeltavector = getmovedelta(animation, 0, splittime);
    var_773216e9 = length(localdeltavector);
    disttocorner = distance2d(entity.origin, entity.var_14b548c5);
    if (var_773216e9 >= disttocorner && var_773216e9 < disttocorner * 1.2) {
        return true;
    }
    return false;
}

// Namespace animation_selector_table_evaluators/animation_selector_table_evaluators
// Params 2, eflags: 0x5 linked
// Checksum 0x73157b46, Offset: 0xb10
// Size: 0x1ee
function private evaluator_checkanimationforovershootinggoal(entity, animation) {
    pixbeginevent(#"evaluator_checkanimationforovershootinggoal");
    assert(isactor(entity));
    localdeltavector = getmovedelta(animation, 0, 1);
    animdistsq = lengthsquared(localdeltavector);
    if (entity haspath()) {
        startpos = entity.origin;
        goalpos = entity.var_14b548c5;
        assert(isdefined(goalpos));
        disttogoalsq = distance2dsquared(startpos, goalpos);
        if (entity.traversalstartdist > 0 && animdistsq > function_a3f6cdac(entity.traversalstartdist)) {
            pixendevent();
            return false;
        } else if (animdistsq < disttogoalsq * 0.9) {
            pixendevent();
            return true;
        }
    }
    /#
        record3dtext("<dev string:x46>", entity.origin, (1, 0.5, 0), "<dev string:x38>", entity);
    #/
    pixendevent();
    return false;
}

// Namespace animation_selector_table_evaluators/animation_selector_table_evaluators
// Params 2, eflags: 0x5 linked
// Checksum 0x7f83324c, Offset: 0xd08
// Size: 0xfe
function private function_89b21ba9(entity, animation) {
    assert(isactor(entity));
    localdeltavector = getmovedelta(animation, 0, 1);
    endpoint = coordtransform(localdeltavector, entity.origin, entity.angles);
    if (!ispointonstairs(endpoint)) {
        return true;
    }
    /#
        record3dtext("<dev string:x60>" + endpoint, entity.origin, (1, 0.5, 0), "<dev string:x38>", entity);
    #/
    return false;
}

// Namespace animation_selector_table_evaluators/animation_selector_table_evaluators
// Params 2, eflags: 0x5 linked
// Checksum 0xb69919d0, Offset: 0xe10
// Size: 0x126
function private evaluator_checkanimationagainstnavmesh(entity, animation) {
    assert(isactor(entity));
    localdeltavector = getmovedelta(animation, 0, 1);
    var_e21fa5a4 = entity.angles + (0, entity function_144f21ef(), 0);
    endpoint = coordtransform(localdeltavector, entity.origin, var_e21fa5a4);
    if (ispointonnavmesh(endpoint)) {
        return true;
    }
    /#
        record3dtext("<dev string:x75>" + endpoint, entity.origin, (1, 0.5, 0), "<dev string:x38>", entity);
    #/
    return false;
}

// Namespace animation_selector_table_evaluators/animation_selector_table_evaluators
// Params 2, eflags: 0x5 linked
// Checksum 0xb4faf7f9, Offset: 0xf40
// Size: 0x166
function private evaluator_checkanimationarrivalposition(entity, animation) {
    localdeltavector = getmovedelta(animation, 0, 1);
    animdistsq = lengthsquared(localdeltavector);
    goalpos = entity.pathgoalpos;
    disttogoalsq = distancesquared(entity.origin, goalpos);
    if (disttogoalsq < animdistsq) {
        if (is_true(entity.ai.var_a5dabb8b)) {
            return true;
        }
        var_4da2186 = coordtransform(localdeltavector, entity.origin, entity.angles);
        if (distance2dsquared(goalpos, var_4da2186) < function_a3f6cdac(16) && abs(goalpos[2] - var_4da2186[2]) < 48) {
            return true;
        }
    }
    return false;
}

// Namespace animation_selector_table_evaluators/animation_selector_table_evaluators
// Params 3, eflags: 0x5 linked
// Checksum 0xe99bead, Offset: 0x10b0
// Size: 0x1aa
function private evaluator_findfirstvalidanimation(entity, animations, tests) {
    assert(isarray(animations), "<dev string:x8e>");
    assert(isarray(tests), "<dev string:xcf>");
    foreach (aliasanimations in animations) {
        if (aliasanimations.size > 0) {
            valid = 1;
            animation = aliasanimations[0];
            foreach (test in tests) {
                if (![[ test ]](entity, animation)) {
                    valid = 0;
                    break;
                }
            }
            if (valid) {
                return animation;
            }
        }
    }
}

// Namespace animation_selector_table_evaluators/animation_selector_table_evaluators
// Params 2, eflags: 0x5 linked
// Checksum 0xeec20ec8, Offset: 0x1268
// Size: 0x66
function private evaluateblockedanimations(entity, animations) {
    if (animations.size > 0) {
        return evaluator_findfirstvalidanimation(entity, animations, array(&evaluator_checkanimationagainstnavmesh, &evaluator_checkanimationforovershootinggoal));
    }
    return undefined;
}

// Namespace animation_selector_table_evaluators/animation_selector_table_evaluators
// Params 2, eflags: 0x5 linked
// Checksum 0x12f40b15, Offset: 0x12d8
// Size: 0x76
function private evaluateblockednostairsanimations(entity, animations) {
    if (animations.size > 0) {
        return evaluator_findfirstvalidanimation(entity, animations, array(&evaluator_checkanimationagainstnavmesh, &evaluator_checkanimationforovershootinggoal, &function_89b21ba9));
    }
    return undefined;
}

// Namespace animation_selector_table_evaluators/animation_selector_table_evaluators
// Params 2, eflags: 0x5 linked
// Checksum 0xfc8a9025, Offset: 0x1358
// Size: 0x56
function private evaluateblockedanimationsrelaxed(entity, animations) {
    if (animations.size > 0) {
        return evaluator_findfirstvalidanimation(entity, animations, array(&evaluator_checkanimationforovershootinggoal));
    }
    return undefined;
}

// Namespace animation_selector_table_evaluators/animation_selector_table_evaluators
// Params 2, eflags: 0x5 linked
// Checksum 0x46d77d6c, Offset: 0x13b8
// Size: 0x56
function private evaluateblockedanimationsoffnavmesh(entity, animations) {
    if (animations.size > 0) {
        return evaluator_findfirstvalidanimation(entity, animations, array(&evaluator_checkanimationagainstgeo));
    }
    return undefined;
}

// Namespace animation_selector_table_evaluators/animation_selector_table_evaluators
// Params 2, eflags: 0x5 linked
// Checksum 0x38786dbe, Offset: 0x1418
// Size: 0xee
function private evaluatehumanturnanimations(entity, animations) {
    /#
        if (is_true(level.ai_dontturn)) {
            return undefined;
        }
    #/
    /#
        record3dtext("<dev string:x119>" + gettime() + "<dev string:x11d>", entity.origin, (1, 0.5, 0), "<dev string:x38>", entity);
    #/
    if (animations.size > 0) {
        return evaluator_findfirstvalidanimation(entity, animations, array(&function_91a832bb, &evaluator_checkanimationagainstgeo, &evaluator_checkanimationagainstnavmesh));
    }
    return undefined;
}

// Namespace animation_selector_table_evaluators/animation_selector_table_evaluators
// Params 2, eflags: 0x5 linked
// Checksum 0xff6ca3d3, Offset: 0x1510
// Size: 0x132
function private evaluatehumanexposedarrivalanimations(entity, animations) {
    if (isdefined(entity.pathgoalpos)) {
        if (animations.size > 0) {
            var_5e259f59 = evaluator_findfirstvalidanimation(entity, animations, array(&evaluator_checkanimationarrivalposition));
            return var_5e259f59;
        }
    } else if (!entity haspath() && !isdefined(entity.node)) {
        if (animations.size > 0) {
            foreach (aliasanimations in animations) {
                if (aliasanimations.size > 0) {
                    return aliasanimations[0];
                }
            }
        }
    }
    return undefined;
}

// Namespace animation_selector_table_evaluators/animation_selector_table_evaluators
// Params 1, eflags: 0x5 linked
// Checksum 0xacdbfd5d, Offset: 0x1650
// Size: 0xca
function private function_382b0cfb(animation) {
    splittime = 0.5;
    if (animhasnotetrack(animation, "corner")) {
        times = getnotetracktimes(animation, "corner");
        assert(times.size == 1, "<dev string:x131>" + function_9e72a96(animation) + "<dev string:x140>" + "<dev string:x15f>" + "<dev string:x169>");
        splittime = times[0];
    }
    return splittime;
}

// Namespace animation_selector_table_evaluators/animation_selector_table_evaluators
// Params 2, eflags: 0x5 linked
// Checksum 0xebd4fde9, Offset: 0x1728
// Size: 0x7a
function private matchpreplannedturn(entity, animations) {
    if (isdefined(entity.var_7b1f015a.animation)) {
        for (i = 0; i < animations.size; i++) {
            if (animations[i][0] == entity.var_7b1f015a.animation) {
                return animations[i][0];
            }
        }
    }
    return undefined;
}

// Namespace animation_selector_table_evaluators/animation_selector_table_evaluators
// Params 2, eflags: 0x5 linked
// Checksum 0xfce63618, Offset: 0x17b0
// Size: 0x2b4
function private planhumanturnanimations(entity, animations) {
    if (!isdefined(entity.var_7b1f015a)) {
        entity.var_7b1f015a = {};
    }
    if (animations.size > 0) {
        var_bff64930 = evaluator_findfirstvalidanimation(entity, animations, array(&function_147224));
        entity.var_7b1f015a.animation = var_bff64930;
        if (isdefined(var_bff64930)) {
            splittime = function_382b0cfb(var_bff64930);
            halftime = splittime * 0.5;
            speed = animation::function_a23b2a60(var_bff64930, 0, halftime);
            /#
                record3dtext("<dev string:x119>" + gettime() + "<dev string:x178>" + function_9e72a96(var_bff64930) + "<dev string:x18f>" + speed, entity.origin, (1, 0.5, 0), "<dev string:x38>", entity);
            #/
            entity.var_3b77553e = speed;
            entity.var_7b1f015a.pos = entity.var_14b548c5;
            entity.var_7b1f015a.angle = entity.var_871c9e86;
            entity.var_7b1f015a.var_568d90d2 = function_15a5703b(#"human", entity function_359fd121());
            return var_bff64930;
        } else {
            /#
                record3dtext("<dev string:x119>" + gettime() + "<dev string:x19c>", entity.origin, (1, 0.5, 0), "<dev string:x38>", entity);
            #/
            entity.var_3b77553e = -1;
        }
        return var_bff64930;
    }
    /#
        record3dtext("<dev string:x119>" + gettime() + "<dev string:x1c1>", entity.origin, (1, 0.5, 0), "<dev string:x38>", entity);
    #/
    entity.var_3b77553e = -1;
    return undefined;
}

// Namespace animation_selector_table_evaluators/animation_selector_table_evaluators
// Params 1, eflags: 0x5 linked
// Checksum 0x44b36286, Offset: 0x1a70
// Size: 0xc6
function private function_fe8e7e36(point) {
    if (abs(self.pathgoalpos[2] - self.origin[2]) > 0.5) {
        trace = groundtrace(point + (0, 0, 72), point + (0, 0, -72), 0, 0, 0);
        point = (point[0], point[1], trace[#"position"][2] + 6);
    }
    return point;
}

// Namespace animation_selector_table_evaluators/animation_selector_table_evaluators
// Params 2, eflags: 0x5 linked
// Checksum 0x8f10869, Offset: 0x1b40
// Size: 0x34e
function private function_147224(entity, animation) {
    pixbeginevent(#"hash_1f5b5215c3dd76a6");
    assert(isactor(entity));
    splittime = function_382b0cfb(animation);
    midpoint = (entity.var_14b548c5[0], entity.var_14b548c5[1], entity.origin[2] + 6);
    midpoint = entity function_fe8e7e36(midpoint);
    localdeltahalfvector = getmovedelta(animation, 0, splittime);
    var_35543df9 = vectortoangles(entity.origin - midpoint);
    entrypoint = coordtransform(localdeltahalfvector, midpoint, var_35543df9);
    entrypoint = entity function_fe8e7e36(entrypoint);
    if (entity maymovefrompointtopoint(entrypoint, midpoint, 1, 1, entity, 0.75)) {
        /#
            recordline(midpoint, entrypoint, (1, 0.5, 0), "<dev string:x38>", entity);
        #/
        localdeltavector = getmovedelta(animation, 0, 1);
        var_d66f5018 = vectortoangles(midpoint - entrypoint);
        endpoint = coordtransform(localdeltavector, entrypoint, var_d66f5018);
        endpoint = (endpoint[0], endpoint[1], entity.origin[2] + 6);
        endpoint = entity function_fe8e7e36(endpoint);
        if (entity maymovefrompointtopoint(midpoint, endpoint, 1, 1, entity, 0.75)) {
            /#
                recordline(midpoint, endpoint, (0, 0, 1), "<dev string:x38>", entity);
            #/
            pixendevent();
            return true;
        } else {
            /#
                recordline(midpoint, endpoint, (1, 0, 1), "<dev string:x38>", entity);
            #/
        }
    } else {
        /#
            recordline(midpoint, entrypoint, (1, 0, 0), "<dev string:x38>", entity);
        #/
    }
    pixendevent();
    return false;
}

// Namespace animation_selector_table_evaluators/animation_selector_table_evaluators
// Params 2, eflags: 0x5 linked
// Checksum 0x504005b5, Offset: 0x1e98
// Size: 0xdc
function private humandeathevaluation(*entity, animations) {
    if ((isdefined(self.script_longdeath) ? self.script_longdeath : 1) == 0) {
        var_f4e2809d = undefined;
        validcount = 0;
        for (i = 0; i < animations.size; i++) {
            length = getanimlength(animations[i]);
            if (length < 4) {
                validcount++;
                if (randomint(validcount) == validcount - 1) {
                    var_f4e2809d = animations[i];
                }
            }
        }
        return var_f4e2809d;
    }
    return undefined;
}

