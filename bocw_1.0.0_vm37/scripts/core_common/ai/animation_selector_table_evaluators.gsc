#using scripts\core_common\ai\systems\animation_selector_table;
#using scripts\core_common\animation_shared;

#namespace animation_selector_table_evaluators;

// Namespace animation_selector_table_evaluators/animation_selector_table_evaluators
// Params 0, eflags: 0x2
// Checksum 0x4ad8bdbf, Offset: 0x338
// Size: 0x234
function autoexec registerastscriptfunctions() {
    animationselectortable::registeranimationselectortableevaluator("testFunction", &testfunction);
    animationselectortable::registeranimationselectortableevaluator("evaluateMoveToCQBAnimations", &evaluatemovetocqbanimations);
    animationselectortable::registeranimationselectortableevaluator("evaluateBlockedAnimations", &evaluateblockedanimations);
    animationselectortable::registeranimationselectortableevaluator("evaluateBlockedCoverArrivalAnimations", &evaluateblockedcoverarrivalanimations);
    animationselectortable::registeranimationselectortableevaluator("evaluateBlockedCoverExitAnimations", &evaluateblockedcoverexitanimations);
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
// Params 2, eflags: 0x0
// Checksum 0x7919233f, Offset: 0x578
// Size: 0x46
function testfunction(*entity, animations) {
    if (isarray(animations) && animations.size > 0) {
        return animations[0];
    }
}

// Namespace animation_selector_table_evaluators/animation_selector_table_evaluators
// Params 2, eflags: 0x4
// Checksum 0x40169ad2, Offset: 0x5c8
// Size: 0x162
function private function_aa7530df(entity, animation) {
    pixbeginevent(#"");
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
        profilestop();
        return true;
    }
    profilestop();
    return false;
}

// Namespace animation_selector_table_evaluators/animation_selector_table_evaluators
// Params 2, eflags: 0x4
// Checksum 0x56642613, Offset: 0x738
// Size: 0x74
function private evaluatejukeblockedanimations(entity, animations) {
    if (animations.size > 0) {
        return evaluator_findfirstvalidanimation(entity, animations, array(&evaluator_checkanimationagainstnavmesh, &function_aa7530df, &evaluator_checkanimationforovershootinggoal));
    }
}

// Namespace animation_selector_table_evaluators/animation_selector_table_evaluators
// Params 2, eflags: 0x4
// Checksum 0x68cfb37d, Offset: 0x7b8
// Size: 0x222
function private evaluator_checkanimationagainstgeo(entity, animation) {
    pixbeginevent(#"");
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
            profilestop();
            return true;
        }
    }
    profilestop();
    return false;
}

// Namespace animation_selector_table_evaluators/animation_selector_table_evaluators
// Params 2, eflags: 0x4
// Checksum 0x398d21, Offset: 0x9e8
// Size: 0x11a
function private evaluator_checkanimationendpointagainstgeo(entity, animation) {
    pixbeginevent(#"");
    assert(isactor(entity));
    localdeltavector = getmovedelta(animation, 0, 1);
    var_e21fa5a4 = entity.angles + (0, entity function_144f21ef(), 0);
    endpoint = coordtransform(localdeltavector, entity.origin, var_e21fa5a4);
    endpoint = (endpoint[0], endpoint[1], entity.origin[2]);
    if (entity maymovetopoint(endpoint, 0, 0)) {
        profilestop();
        return true;
    }
    profilestop();
    return false;
}

// Namespace animation_selector_table_evaluators/animation_selector_table_evaluators
// Params 2, eflags: 0x4
// Checksum 0x5104a19b, Offset: 0xb10
// Size: 0x144
function private function_91a832bb(entity, animation) {
    localdeltavector = getmovedelta(animation, 0, 1);
    var_f0ccb726 = lengthsquared(localdeltavector);
    if (var_f0ccb726 > sqr(entity getpathlength())) {
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
// Params 2, eflags: 0x4
// Checksum 0xab34ceac, Offset: 0xc60
// Size: 0x5c
function private function_3c7d2020(entity, animation) {
    if (animhasnotetrack(animation, "corner")) {
        return 1;
    }
    return evaluator_checkanimationforovershootinggoal(entity, animation);
}

// Namespace animation_selector_table_evaluators/animation_selector_table_evaluators
// Params 2, eflags: 0x4
// Checksum 0xdc40f033, Offset: 0xcc8
// Size: 0x298
function private evaluator_checkanimationforovershootinggoal(entity, animation) {
    pixbeginevent(#"");
    assert(isactor(entity));
    if (entity haspath()) {
        startpos = entity.origin;
        goalpos = entity.var_14b548c5;
        assert(isdefined(goalpos));
        disttogoalsq = distance2dsquared(startpos, goalpos);
        localdeltavector = getmovedelta(animation, 0, 1);
        animdistsq = lengthsquared(localdeltavector);
        if (entity.traversalstartdist > 0 && animdistsq > sqr(entity.traversalstartdist)) {
            profilestop();
            return false;
        } else if ((isdefined(entity.var_c4c50a0b) ? entity.var_c4c50a0b : 0) && animdistsq > disttogoalsq) {
            profilestop();
            return false;
        }
        codemovetime = function_199662d1(animation);
        localdeltavector = getmovedelta(animation, 0, codemovetime);
        animdistsq = lengthsquared(localdeltavector);
        if (entity.isarrivalpending && distance2dsquared(startpos, entity.overridegoalpos) < disttogoalsq) {
            goalpos = entity.overridegoalpos;
            disttogoalsq = distance2dsquared(startpos, goalpos);
        }
        if (animdistsq < disttogoalsq * 0.9) {
            profilestop();
            return true;
        }
    }
    /#
        record3dtext("<dev string:x46>", entity.origin, (1, 0.5, 0), "<dev string:x38>", entity);
    #/
    profilestop();
    return false;
}

// Namespace animation_selector_table_evaluators/animation_selector_table_evaluators
// Params 2, eflags: 0x4
// Checksum 0x12bcd1b2, Offset: 0xf70
// Size: 0x1a6
function private function_da29fa63(entity, animation) {
    pixbeginevent(#"hash_4de9b510d8b94b2c");
    assert(isactor(entity));
    if (isdefined(entity.node)) {
        if (entity haspath()) {
            startpos = entity.origin;
            goalpos = entity getnodeoffsetposition(entity.node);
            disttogoalsq = distance2dsquared(startpos, goalpos);
            localdeltavector = getmovedelta(animation, 0, 1);
            animdistsq = lengthsquared(localdeltavector);
            if (animdistsq <= disttogoalsq) {
                pixendevent();
                return true;
            }
        }
        /#
            record3dtext("<dev string:x60>", entity.origin, (1, 0.5, 0), "<dev string:x38>", entity);
        #/
    }
    pixendevent();
    return false;
}

// Namespace animation_selector_table_evaluators/animation_selector_table_evaluators
// Params 2, eflags: 0x4
// Checksum 0xcc47f03c, Offset: 0x1120
// Size: 0xfe
function private function_89b21ba9(entity, animation) {
    assert(isactor(entity));
    localdeltavector = getmovedelta(animation, 0, 1);
    endpoint = coordtransform(localdeltavector, entity.origin, entity.angles);
    if (!ispointonstairs(endpoint)) {
        return true;
    }
    /#
        record3dtext("<dev string:x79>" + endpoint, entity.origin, (1, 0.5, 0), "<dev string:x38>", entity);
    #/
    return false;
}

// Namespace animation_selector_table_evaluators/animation_selector_table_evaluators
// Params 2, eflags: 0x4
// Checksum 0xae14a79f, Offset: 0x1228
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
        record3dtext("<dev string:x8e>" + endpoint, entity.origin, (1, 0.5, 0), "<dev string:x38>", entity);
    #/
    return false;
}

// Namespace animation_selector_table_evaluators/animation_selector_table_evaluators
// Params 2, eflags: 0x4
// Checksum 0x6dc1d8db, Offset: 0x1358
// Size: 0x19e
function private function_50c1352d(entity, animation) {
    localdeltavector = getmovedelta(animation, 0, 1);
    animdistsq = lengthsquared(localdeltavector);
    goalpos = entity.pathgoalpos;
    disttogoalsq = distance2dsquared(entity.origin, goalpos);
    if (disttogoalsq <= animdistsq && abs(goalpos[2] - entity.origin[2]) < 48) {
        if (is_true(entity.ai.var_a5dabb8b)) {
            return true;
        }
        var_4da2186 = coordtransform(localdeltavector, entity.origin, entity.angles);
        if (distance2dsquared(goalpos, var_4da2186) < sqr(16) && abs(goalpos[2] - var_4da2186[2]) < 48) {
            return true;
        }
    }
    return false;
}

// Namespace animation_selector_table_evaluators/animation_selector_table_evaluators
// Params 3, eflags: 0x4
// Checksum 0x868818fc, Offset: 0x1500
// Size: 0x1aa
function private evaluator_findfirstvalidanimation(entity, animations, tests) {
    assert(isarray(animations), "<dev string:xa7>");
    assert(isarray(tests), "<dev string:xe8>");
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
// Checksum 0xb97cc9fe, Offset: 0x16b8
// Size: 0x4a
function private evaluatemovetocqbanimations(entity, animations) {
    if (is_true(entity.var_81238017)) {
        return undefined;
    }
    return evaluateblockedanimations(entity, animations);
}

// Namespace animation_selector_table_evaluators/animation_selector_table_evaluators
// Params 2, eflags: 0x4
// Checksum 0x2afad326, Offset: 0x1710
// Size: 0x66
function private evaluateblockedanimations(entity, animations) {
    if (animations.size > 0) {
        return evaluator_findfirstvalidanimation(entity, animations, array(&evaluator_checkanimationagainstnavmesh, &evaluator_checkanimationforovershootinggoal));
    }
    return undefined;
}

// Namespace animation_selector_table_evaluators/animation_selector_table_evaluators
// Params 2, eflags: 0x4
// Checksum 0x32ea5578, Offset: 0x1780
// Size: 0x66
function private evaluateblockedcoverarrivalanimations(entity, animations) {
    if (animations.size > 0) {
        anim = evaluator_findfirstvalidanimation(entity, animations, array(&function_da29fa63));
        return anim;
    }
    return undefined;
}

// Namespace animation_selector_table_evaluators/animation_selector_table_evaluators
// Params 2, eflags: 0x4
// Checksum 0x3b5ce603, Offset: 0x17f0
// Size: 0x76
function private evaluateblockedcoverexitanimations(entity, animations) {
    if (animations.size > 0) {
        return evaluator_findfirstvalidanimation(entity, animations, array(&evaluator_checkanimationagainstnavmesh, &function_3c7d2020, &function_89b21ba9));
    }
    return undefined;
}

// Namespace animation_selector_table_evaluators/animation_selector_table_evaluators
// Params 2, eflags: 0x4
// Checksum 0xadfda5f0, Offset: 0x1870
// Size: 0x76
function private evaluateblockednostairsanimations(entity, animations) {
    if (animations.size > 0) {
        return evaluator_findfirstvalidanimation(entity, animations, array(&evaluator_checkanimationagainstnavmesh, &evaluator_checkanimationforovershootinggoal, &function_89b21ba9));
    }
    return undefined;
}

// Namespace animation_selector_table_evaluators/animation_selector_table_evaluators
// Params 2, eflags: 0x4
// Checksum 0xae1d7db, Offset: 0x18f0
// Size: 0x56
function private evaluateblockedanimationsrelaxed(entity, animations) {
    if (animations.size > 0) {
        return evaluator_findfirstvalidanimation(entity, animations, array(&evaluator_checkanimationforovershootinggoal));
    }
    return undefined;
}

// Namespace animation_selector_table_evaluators/animation_selector_table_evaluators
// Params 2, eflags: 0x4
// Checksum 0x545010d5, Offset: 0x1950
// Size: 0x56
function private evaluateblockedanimationsoffnavmesh(entity, animations) {
    if (animations.size > 0) {
        return evaluator_findfirstvalidanimation(entity, animations, array(&evaluator_checkanimationagainstgeo));
    }
    return undefined;
}

// Namespace animation_selector_table_evaluators/animation_selector_table_evaluators
// Params 2, eflags: 0x4
// Checksum 0xd66b34ff, Offset: 0x19b0
// Size: 0xee
function private evaluatehumanturnanimations(entity, animations) {
    /#
        if (is_true(level.ai_dontturn)) {
            return undefined;
        }
    #/
    /#
        record3dtext("<dev string:x132>" + gettime() + "<dev string:x136>", entity.origin, (1, 0.5, 0), "<dev string:x38>", entity);
    #/
    if (animations.size > 0) {
        return evaluator_findfirstvalidanimation(entity, animations, array(&function_91a832bb, &evaluator_checkanimationagainstgeo, &evaluator_checkanimationagainstnavmesh));
    }
    return undefined;
}

// Namespace animation_selector_table_evaluators/animation_selector_table_evaluators
// Params 2, eflags: 0x4
// Checksum 0x497b7f2a, Offset: 0x1aa8
// Size: 0x132
function private evaluatehumanexposedarrivalanimations(entity, animations) {
    if (isdefined(entity.pathgoalpos)) {
        if (animations.size > 0) {
            var_5e259f59 = evaluator_findfirstvalidanimation(entity, animations, array(&function_50c1352d));
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
// Params 1, eflags: 0x4
// Checksum 0x21fe791a, Offset: 0x1be8
// Size: 0xc4
function private function_199662d1(animation) {
    codemovetime = 1;
    if (animhasnotetrack(animation, "code_move")) {
        times = getnotetracktimes(animation, "code_move");
        codemovetime = times[0];
    } else if (animhasnotetrack(animation, "mocomp_end")) {
        times = getnotetracktimes(animation, "mocomp_end");
        codemovetime = times[0];
    }
    return codemovetime;
}

// Namespace animation_selector_table_evaluators/animation_selector_table_evaluators
// Params 1, eflags: 0x4
// Checksum 0xd108f4bb, Offset: 0x1cb8
// Size: 0xca
function private function_382b0cfb(animation) {
    splittime = 0.5;
    if (animhasnotetrack(animation, "corner")) {
        times = getnotetracktimes(animation, "corner");
        assert(times.size == 1, "<dev string:x14a>" + function_9e72a96(animation) + "<dev string:x159>" + "<dev string:x178>" + "<dev string:x182>");
        splittime = times[0];
    }
    return splittime;
}

// Namespace animation_selector_table_evaluators/animation_selector_table_evaluators
// Params 2, eflags: 0x4
// Checksum 0x332da332, Offset: 0x1d90
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
// Params 2, eflags: 0x4
// Checksum 0x42d83009, Offset: 0x1e18
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
                record3dtext("<dev string:x132>" + gettime() + "<dev string:x191>" + function_9e72a96(var_bff64930) + "<dev string:x1a8>" + speed, entity.origin, (1, 0.5, 0), "<dev string:x38>", entity);
            #/
            entity.var_3b77553e = speed;
            entity.var_7b1f015a.pos = entity.var_14b548c5;
            entity.var_7b1f015a.angle = entity.var_871c9e86;
            entity.var_7b1f015a.var_568d90d2 = function_15a5703b(#"human", entity function_359fd121());
            return var_bff64930;
        } else {
            /#
                record3dtext("<dev string:x132>" + gettime() + "<dev string:x1b5>", entity.origin, (1, 0.5, 0), "<dev string:x38>", entity);
            #/
            entity.var_3b77553e = -1;
        }
        return var_bff64930;
    }
    /#
        record3dtext("<dev string:x132>" + gettime() + "<dev string:x1da>", entity.origin, (1, 0.5, 0), "<dev string:x38>", entity);
    #/
    entity.var_3b77553e = -1;
    return undefined;
}

// Namespace animation_selector_table_evaluators/animation_selector_table_evaluators
// Params 1, eflags: 0x4
// Checksum 0xf9b5480e, Offset: 0x20d8
// Size: 0xc6
function private function_fe8e7e36(point) {
    if (abs(self.pathgoalpos[2] - self.origin[2]) > 0.5) {
        trace = groundtrace(point + (0, 0, 72), point + (0, 0, -72), 0, 0, 0);
        point = (point[0], point[1], trace[#"position"][2] + 6);
    }
    return point;
}

// Namespace animation_selector_table_evaluators/animation_selector_table_evaluators
// Params 2, eflags: 0x4
// Checksum 0x41ce0ce2, Offset: 0x21a8
// Size: 0x348
function private function_147224(entity, animation) {
    pixbeginevent(#"");
    assert(isactor(entity));
    midpoint = (entity.var_14b548c5[0], entity.var_14b548c5[1], entity.origin[2] + 6);
    midpoint = entity function_fe8e7e36(midpoint);
    splittime = function_382b0cfb(animation);
    localdeltahalfvector = getmovedelta(animation, 0, splittime);
    if (distance2dsquared(entity.origin, midpoint) < length2dsquared(localdeltahalfvector)) {
        profilestop();
        return false;
    }
    entrypoint = midpoint + vectornormalize(entity.origin - midpoint) * length(localdeltahalfvector);
    entrypoint = entity function_fe8e7e36(entrypoint);
    if (entity maymovefrompointtopoint(entrypoint, midpoint, 1, 1, entity, 0.75)) {
        /#
            recordline(midpoint, entrypoint, (1, 0.5, 0), "<dev string:x38>", entity);
        #/
        codemovetime = function_199662d1(animation);
        var_16ebe729 = getmovedelta(animation, 0, codemovetime);
        var_d66f5018 = vectortoangles(midpoint - entrypoint);
        endpoint = coordtransform(var_16ebe729, entrypoint, var_d66f5018);
        endpoint = entity function_fe8e7e36(endpoint);
        if (entity maymovefrompointtopoint(midpoint, endpoint, 1, 1, entity, 0.75)) {
            /#
                recordline(midpoint, endpoint, (0, 1, 0), "<dev string:x38>", entity);
            #/
            profilestop();
            return true;
        } else {
            /#
                recordline(midpoint, endpoint, (1, 0, 0), "<dev string:x38>", entity);
            #/
        }
    } else {
        /#
            recordline(midpoint, entrypoint, (1, 0, 0), "<dev string:x38>", entity);
        #/
    }
    profilestop();
    return false;
}

// Namespace animation_selector_table_evaluators/animation_selector_table_evaluators
// Params 2, eflags: 0x4
// Checksum 0xa20363d3, Offset: 0x2500
// Size: 0x184
function private humandeathevaluation(*entity, animations) {
    var_bec12c3d = 0;
    if ((isdefined(self.script_longdeath) ? self.script_longdeath : 1) == 0 || (isdefined(level.var_d03f21c6) ? level.var_d03f21c6 : 0) > gettime()) {
        var_bec12c3d = 1;
    }
    var_f4e2809d = undefined;
    if (var_bec12c3d) {
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
    } else {
        randomindex = randomint(animations.size);
        var_f4e2809d = animations[randomindex];
        length = getanimlength(var_f4e2809d);
        if (length >= 4) {
            level.var_d03f21c6 = gettime() + 30000;
        }
    }
    return var_f4e2809d;
}

