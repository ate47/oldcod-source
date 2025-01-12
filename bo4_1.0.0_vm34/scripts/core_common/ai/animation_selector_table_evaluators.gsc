#using scripts\core_common\ai\systems\animation_selector_table;

#namespace animation_selector_table_evaluators;

// Namespace animation_selector_table_evaluators/animation_selector_table_evaluators
// Params 0, eflags: 0x2
// Checksum 0xf03ab4c, Offset: 0x140
// Size: 0x11c
function autoexec registerastscriptfunctions() {
    animationselectortable::registeranimationselectortableevaluator("testFunction", &testfunction);
    animationselectortable::registeranimationselectortableevaluator("evaluateBlockedAnimations", &evaluateblockedanimations);
    animationselectortable::registeranimationselectortableevaluator("evaluateBlockedAnimationsRelaxed", &evaluateblockedanimationsrelaxed);
    animationselectortable::registeranimationselectortableevaluator("evaluateBlockedAnimationsOffNavmesh", &evaluateblockedanimationsoffnavmesh);
    animationselectortable::registeranimationselectortableevaluator("evaluateHumanTurnAnimations", &evaluatehumanturnanimations);
    animationselectortable::registeranimationselectortableevaluator("evaluateHumanExposedArrivalAnimations", &evaluatehumanexposedarrivalanimations);
    animationselectortable::registeranimationselectortableevaluator("evaluateJukeBlockedAnimations", &evaluatejukeblockedanimations);
}

// Namespace animation_selector_table_evaluators/animation_selector_table_evaluators
// Params 2, eflags: 0x0
// Checksum 0xdb0b84fa, Offset: 0x268
// Size: 0x48
function testfunction(entity, animations) {
    if (isarray(animations) && animations.size > 0) {
        return animations[0];
    }
}

// Namespace animation_selector_table_evaluators/animation_selector_table_evaluators
// Params 2, eflags: 0x4
// Checksum 0x9d9afc57, Offset: 0x2b8
// Size: 0x19e
function private function_16d86ac2(entity, animation) {
    pixbeginevent(#"evaluator_checkanimationagainstgeo");
    assert(isactor(entity));
    forwarddir = anglestoforward(entity.angles);
    localdeltavector = getmovedelta(animation, 0, 1, entity);
    endpoint = entity localtoworldcoords(localdeltavector);
    forwardpoint = endpoint + vectorscale(forwarddir, 100);
    /#
        recordline(entity.origin, endpoint, (0, 0, 1), "<dev string:x30>", entity);
        recordline(endpoint, forwardpoint, (1, 0.5, 0), "<dev string:x30>", entity);
    #/
    if (entity maymovefrompointtopoint(endpoint, forwardpoint, 1, 1)) {
        pixendevent();
        return true;
    }
    pixendevent();
    return false;
}

// Namespace animation_selector_table_evaluators/animation_selector_table_evaluators
// Params 2, eflags: 0x4
// Checksum 0x56dfcba7, Offset: 0x460
// Size: 0x7c
function private evaluatejukeblockedanimations(entity, animations) {
    if (animations.size > 0) {
        return evaluator_findfirstvalidanimation(entity, animations, array(&evaluator_checkanimationagainstnavmesh, &function_16d86ac2, &evaluator_checkanimationforovershootinggoal));
    }
}

// Namespace animation_selector_table_evaluators/animation_selector_table_evaluators
// Params 2, eflags: 0x4
// Checksum 0x6106232a, Offset: 0x4e8
// Size: 0x22e
function private evaluator_checkanimationagainstgeo(entity, animation) {
    pixbeginevent(#"evaluator_checkanimationagainstgeo");
    assert(isactor(entity));
    localdeltahalfvector = getmovedelta(animation, 0, 0.5, entity);
    midpoint = entity localtoworldcoords(localdeltahalfvector);
    midpoint = (midpoint[0], midpoint[1], entity.origin[2]);
    /#
        recordline(entity.origin, midpoint, (1, 0.5, 0), "<dev string:x30>", entity);
    #/
    if (entity maymovetopoint(midpoint, 1, 1)) {
        localdeltavector = getmovedelta(animation, 0, 1, entity);
        endpoint = entity localtoworldcoords(localdeltavector);
        endpoint = (endpoint[0], endpoint[1], entity.origin[2]);
        /#
            recordline(midpoint, endpoint, (1, 0.5, 0), "<dev string:x30>", entity);
        #/
        if (entity maymovefrompointtopoint(midpoint, endpoint, 1, 1)) {
            pixendevent();
            return true;
        }
    }
    pixendevent();
    return false;
}

// Namespace animation_selector_table_evaluators/animation_selector_table_evaluators
// Params 2, eflags: 0x4
// Checksum 0x8b4c593, Offset: 0x720
// Size: 0x11e
function private evaluator_checkanimationendpointagainstgeo(entity, animation) {
    pixbeginevent(#"evaluator_checkanimationendpointagainstgeo");
    assert(isactor(entity));
    localdeltavector = getmovedelta(animation, 0, 1, entity);
    endpoint = entity localtoworldcoords(localdeltavector);
    endpoint = (endpoint[0], endpoint[1], entity.origin[2]);
    if (entity maymovetopoint(endpoint, 0, 0)) {
        pixendevent();
        return true;
    }
    pixendevent();
    return false;
}

// Namespace animation_selector_table_evaluators/animation_selector_table_evaluators
// Params 2, eflags: 0x4
// Checksum 0x78381f89, Offset: 0x848
// Size: 0x18e
function private evaluator_checkanimationforovershootinggoal(entity, animation) {
    pixbeginevent(#"evaluator_checkanimationforovershootinggoal");
    assert(isactor(entity));
    localdeltavector = getmovedelta(animation, 0, 1, entity);
    endpoint = entity localtoworldcoords(localdeltavector);
    animdistsq = lengthsquared(localdeltavector);
    if (entity haspath()) {
        startpos = entity.origin;
        goalpos = entity.pathgoalpos;
        assert(isdefined(goalpos));
        disttogoalsq = distancesquared(startpos, goalpos);
        if (animdistsq < disttogoalsq * 0.8) {
            pixendevent();
            return true;
        }
    }
    pixendevent();
    return false;
}

// Namespace animation_selector_table_evaluators/animation_selector_table_evaluators
// Params 2, eflags: 0x4
// Checksum 0x8d709c2b, Offset: 0x9e0
// Size: 0xa6
function private evaluator_checkanimationagainstnavmesh(entity, animation) {
    assert(isactor(entity));
    localdeltavector = getmovedelta(animation, 0, 1, entity);
    endpoint = entity localtoworldcoords(localdeltavector);
    if (ispointonnavmesh(endpoint, entity)) {
        return true;
    }
    return false;
}

// Namespace animation_selector_table_evaluators/animation_selector_table_evaluators
// Params 2, eflags: 0x4
// Checksum 0x5dbd8a4b, Offset: 0xa90
// Size: 0xf4
function private evaluator_checkanimationarrivalposition(entity, animation) {
    localdeltavector = getmovedelta(animation, 0, 1, entity);
    endpoint = entity localtoworldcoords(localdeltavector);
    animdistsq = lengthsquared(localdeltavector);
    startpos = entity.origin;
    goalpos = entity.pathgoalpos;
    disttogoalsq = distancesquared(startpos, goalpos);
    return disttogoalsq < animdistsq && entity isposatgoal(endpoint);
}

// Namespace animation_selector_table_evaluators/animation_selector_table_evaluators
// Params 3, eflags: 0x4
// Checksum 0x4b6a29ed, Offset: 0xb90
// Size: 0x194
function private evaluator_findfirstvalidanimation(entity, animations, tests) {
    assert(isarray(animations), "<dev string:x3b>");
    assert(isarray(tests), "<dev string:x79>");
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
// Params 2, eflags: 0x4
// Checksum 0x660480c5, Offset: 0xd30
// Size: 0x6e
function private evaluateblockedanimations(entity, animations) {
    if (animations.size > 0) {
        return evaluator_findfirstvalidanimation(entity, animations, array(&evaluator_checkanimationagainstnavmesh, &evaluator_checkanimationforovershootinggoal));
    }
    return undefined;
}

// Namespace animation_selector_table_evaluators/animation_selector_table_evaluators
// Params 2, eflags: 0x4
// Checksum 0x8861e04, Offset: 0xda8
// Size: 0x5e
function private evaluateblockedanimationsrelaxed(entity, animations) {
    if (animations.size > 0) {
        return evaluator_findfirstvalidanimation(entity, animations, array(&evaluator_checkanimationforovershootinggoal));
    }
    return undefined;
}

// Namespace animation_selector_table_evaluators/animation_selector_table_evaluators
// Params 2, eflags: 0x4
// Checksum 0x2f2368e, Offset: 0xe10
// Size: 0x5e
function private evaluateblockedanimationsoffnavmesh(entity, animations) {
    if (animations.size > 0) {
        return evaluator_findfirstvalidanimation(entity, animations, array(&evaluator_checkanimationagainstgeo));
    }
    return undefined;
}

// Namespace animation_selector_table_evaluators/animation_selector_table_evaluators
// Params 2, eflags: 0x4
// Checksum 0x3e48c278, Offset: 0xe78
// Size: 0xf6
function private evaluatehumanturnanimations(entity, animations) {
    /#
        if (isdefined(level.ai_dontturn) && level.ai_dontturn) {
            return undefined;
        }
    #/
    /#
        record3dtext("<dev string:xc0>" + gettime() + "<dev string:xc1>", entity.origin, (1, 0.5, 0), "<dev string:x30>", entity);
    #/
    if (animations.size > 0) {
        return evaluator_findfirstvalidanimation(entity, animations, array(&evaluator_checkanimationforovershootinggoal, &evaluator_checkanimationagainstgeo, &evaluator_checkanimationagainstnavmesh));
    }
    return undefined;
}

// Namespace animation_selector_table_evaluators/animation_selector_table_evaluators
// Params 2, eflags: 0x4
// Checksum 0xfe05bde5, Offset: 0xf78
// Size: 0x6e
function private evaluatehumanexposedarrivalanimations(entity, animations) {
    if (!isdefined(entity.pathgoalpos)) {
        return undefined;
    }
    if (animations.size > 0) {
        return evaluator_findfirstvalidanimation(entity, animations, array(&evaluator_checkanimationarrivalposition));
    }
    return undefined;
}

