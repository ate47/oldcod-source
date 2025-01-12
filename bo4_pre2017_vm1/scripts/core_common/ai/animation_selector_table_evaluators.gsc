#using scripts/core_common/ai/systems/animation_selector_table;
#using scripts/core_common/array_shared;

#namespace animation_selector_table_evaluators;

// Namespace animation_selector_table_evaluators/animation_selector_table_evaluators
// Params 0, eflags: 0x2
// Checksum 0x359bcf12, Offset: 0x1e0
// Size: 0xa4
function autoexec registerastscriptfunctions() {
    animationselectortable::registeranimationselectortableevaluator("testFunction", &testfunction);
    animationselectortable::registeranimationselectortableevaluator("evaluateBlockedAnimations", &evaluateblockedanimations);
    animationselectortable::registeranimationselectortableevaluator("evaluateHumanTurnAnimations", &evaluatehumanturnanimations);
    animationselectortable::registeranimationselectortableevaluator("evaluateHumanExposedArrivalAnimations", &evaluatehumanexposedarrivalanimations);
}

// Namespace animation_selector_table_evaluators/animation_selector_table_evaluators
// Params 2, eflags: 0x0
// Checksum 0x323717cc, Offset: 0x290
// Size: 0x46
function testfunction(entity, animations) {
    if (isarray(animations) && animations.size > 0) {
        return animations[0];
    }
}

// Namespace animation_selector_table_evaluators/animation_selector_table_evaluators
// Params 2, eflags: 0x4
// Checksum 0x85cbbc2a, Offset: 0x2e0
// Size: 0x256
function private evaluator_checkanimationagainstgeo(entity, animation) {
    pixbeginevent("Evaluator_CheckAnimationAgainstGeo");
    /#
        assert(isactor(entity));
    #/
    localdeltahalfvector = getmovedelta(animation, 0, 0.5, entity);
    midpoint = entity localtoworldcoords(localdeltahalfvector);
    midpoint = (midpoint[0], midpoint[1], entity.origin[2]);
    /#
        recordline(entity.origin, midpoint, (1, 0.5, 0), "<dev string:x28>", entity);
    #/
    if (entity maymovetopoint(midpoint, 1, 1)) {
        localdeltavector = getmovedelta(animation, 0, 1, entity);
        endpoint = entity localtoworldcoords(localdeltavector);
        endpoint = (endpoint[0], endpoint[1], entity.origin[2]);
        /#
            recordline(midpoint, endpoint, (1, 0.5, 0), "<dev string:x28>", entity);
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
// Checksum 0x4f842614, Offset: 0x540
// Size: 0x12e
function private evaluator_checkanimationendpointagainstgeo(entity, animation) {
    pixbeginevent("Evaluator_CheckAnimationEndPointAgainstGeo");
    /#
        assert(isactor(entity));
    #/
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
// Checksum 0x4a561e45, Offset: 0x678
// Size: 0x19e
function private evaluator_checkanimationforovershootinggoal(entity, animation) {
    pixbeginevent("Evaluator_CheckAnimationForOverShootingGoal");
    /#
        assert(isactor(entity));
    #/
    localdeltavector = getmovedelta(animation, 0, 1, entity);
    endpoint = entity localtoworldcoords(localdeltavector);
    animdistsq = lengthsquared(localdeltavector);
    if (entity haspath()) {
        startpos = entity.origin;
        goalpos = entity.pathgoalpos;
        /#
            assert(isdefined(goalpos));
        #/
        disttogoalsq = distancesquared(startpos, goalpos);
        if (animdistsq < disttogoalsq) {
            pixendevent();
            return true;
        }
    }
    pixendevent();
    return false;
}

// Namespace animation_selector_table_evaluators/animation_selector_table_evaluators
// Params 2, eflags: 0x4
// Checksum 0xd71acb46, Offset: 0x820
// Size: 0xbe
function private evaluator_checkanimationagainstnavmesh(entity, animation) {
    /#
        assert(isactor(entity));
    #/
    localdeltavector = getmovedelta(animation, 0, 1, entity);
    endpoint = entity localtoworldcoords(localdeltavector);
    if (ispointonnavmesh(endpoint, entity)) {
        return true;
    }
    return false;
}

// Namespace animation_selector_table_evaluators/animation_selector_table_evaluators
// Params 2, eflags: 0x4
// Checksum 0x2c0d17bf, Offset: 0x8e8
// Size: 0x112
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
// Checksum 0xb389cef2, Offset: 0xa08
// Size: 0x1ce
function private evaluator_findfirstvalidanimation(entity, animations, tests) {
    /#
        assert(isarray(animations), "<dev string:x33>");
    #/
    /#
        assert(isarray(tests), "<dev string:x71>");
    #/
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
// Checksum 0x2208e7af, Offset: 0xbe0
// Size: 0x6e
function private evaluateblockedanimations(entity, animations) {
    if (animations.size > 0) {
        return evaluator_findfirstvalidanimation(entity, animations, array(&evaluator_checkanimationagainstgeo, &evaluator_checkanimationforovershootinggoal));
    }
    return undefined;
}

// Namespace animation_selector_table_evaluators/animation_selector_table_evaluators
// Params 2, eflags: 0x4
// Checksum 0x7ad076cc, Offset: 0xc58
// Size: 0xf6
function private evaluatehumanturnanimations(entity, animations) {
    /#
        if (isdefined(level.ai_dontturn) && level.ai_dontturn) {
            return undefined;
        }
    #/
    /#
        record3dtext("<dev string:xb8>" + gettime() + "<dev string:xb9>", entity.origin, (1, 0.5, 0), "<dev string:x28>", entity);
    #/
    if (animations.size > 0) {
        return evaluator_findfirstvalidanimation(entity, animations, array(&evaluator_checkanimationforovershootinggoal, &evaluator_checkanimationagainstgeo, &evaluator_checkanimationagainstnavmesh));
    }
    return undefined;
}

// Namespace animation_selector_table_evaluators/animation_selector_table_evaluators
// Params 2, eflags: 0x4
// Checksum 0xbc1be9bd, Offset: 0xd58
// Size: 0x76
function private evaluatehumanexposedarrivalanimations(entity, animations) {
    if (!isdefined(entity.pathgoalpos)) {
        return undefined;
    }
    if (animations.size > 0) {
        return evaluator_findfirstvalidanimation(entity, animations, array(&evaluator_checkanimationarrivalposition));
    }
    return undefined;
}

