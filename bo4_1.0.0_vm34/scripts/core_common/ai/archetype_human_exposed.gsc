#using scripts\core_common\ai\archetype_utility;
#using scripts\core_common\ai\systems\behavior_tree_utility;

#namespace archetype_human_exposed;

// Namespace archetype_human_exposed/archetype_human_exposed
// Params 0, eflags: 0x2
// Checksum 0xfc5ce3d1, Offset: 0x140
// Size: 0x2a4
function autoexec registerbehaviorscriptfunctions() {
    assert(isscriptfunctionptr(&hascloseenemy));
    behaviortreenetworkutility::registerbehaviortreescriptapi("hasCloseEnemy", &hascloseenemy);
    assert(isscriptfunctionptr(&nocloseenemyservice));
    behaviortreenetworkutility::registerbehaviortreescriptapi("noCloseEnemyService", &nocloseenemyservice);
    assert(isscriptfunctionptr(&tryreacquireservice));
    behaviortreenetworkutility::registerbehaviortreescriptapi("tryReacquireService", &tryreacquireservice);
    assert(isscriptfunctionptr(&preparetoreacttoenemy));
    behaviortreenetworkutility::registerbehaviortreescriptapi("prepareToReactToEnemy", &preparetoreacttoenemy);
    assert(isscriptfunctionptr(&resetreactiontoenemy));
    behaviortreenetworkutility::registerbehaviortreescriptapi("resetReactionToEnemy", &resetreactiontoenemy);
    assert(isscriptfunctionptr(&exposedsetdesiredstancetostand));
    behaviortreenetworkutility::registerbehaviortreescriptapi("exposedSetDesiredStanceToStand", &exposedsetdesiredstancetostand);
    assert(isscriptfunctionptr(&setpathmovedelayedrandom));
    behaviortreenetworkutility::registerbehaviortreescriptapi("setPathMoveDelayedRandom", &setpathmovedelayedrandom);
}

// Namespace archetype_human_exposed/archetype_human_exposed
// Params 1, eflags: 0x4
// Checksum 0x2d466e67, Offset: 0x3f0
// Size: 0x4c
function private preparetoreacttoenemy(behaviortreeentity) {
    behaviortreeentity.newenemyreaction = 0;
    behaviortreeentity.malfunctionreaction = 0;
    behaviortreeentity pathmode("move delayed", 1, 3);
}

// Namespace archetype_human_exposed/archetype_human_exposed
// Params 1, eflags: 0x4
// Checksum 0x718e212a, Offset: 0x448
// Size: 0x26
function private resetreactiontoenemy(behaviortreeentity) {
    behaviortreeentity.newenemyreaction = 0;
    behaviortreeentity.malfunctionreaction = 0;
}

// Namespace archetype_human_exposed/archetype_human_exposed
// Params 1, eflags: 0x4
// Checksum 0xe54f269, Offset: 0x478
// Size: 0x54
function private nocloseenemyservice(behaviortreeentity) {
    if (isdefined(behaviortreeentity.enemy) && aiutility::hascloseenemytomelee(behaviortreeentity)) {
        behaviortreeentity clearpath();
        return true;
    }
    return false;
}

// Namespace archetype_human_exposed/archetype_human_exposed
// Params 1, eflags: 0x4
// Checksum 0x31b00f21, Offset: 0x4d8
// Size: 0x5a
function private hascloseenemy(behaviortreeentity) {
    if (!isdefined(behaviortreeentity.enemy)) {
        return false;
    }
    if (distancesquared(behaviortreeentity.origin, behaviortreeentity.enemy.origin) < 22500) {
        return true;
    }
    return false;
}

// Namespace archetype_human_exposed/archetype_human_exposed
// Params 2, eflags: 0x4
// Checksum 0x8b211327, Offset: 0x540
// Size: 0x4c
function private setpathmovedelayedrandom(behaviortreeentity, asmstatename) {
    behaviortreeentity pathmode("move delayed", 0, randomfloatrange(1, 3));
}

// Namespace archetype_human_exposed/archetype_human_exposed
// Params 2, eflags: 0x4
// Checksum 0xaec39173, Offset: 0x598
// Size: 0x7c
function private exposedsetdesiredstancetostand(behaviortreeentity, asmstatename) {
    aiutility::keepclaimnode(behaviortreeentity);
    currentstance = behaviortreeentity getblackboardattribute("_stance");
    behaviortreeentity setblackboardattribute("_desired_stance", "stand");
}

// Namespace archetype_human_exposed/archetype_human_exposed
// Params 1, eflags: 0x4
// Checksum 0x1358a779, Offset: 0x620
// Size: 0x2ba
function private tryreacquireservice(behaviortreeentity) {
    if (!isdefined(behaviortreeentity.reacquire_state)) {
        behaviortreeentity.reacquire_state = 0;
    }
    if (!isdefined(behaviortreeentity.enemy)) {
        behaviortreeentity.reacquire_state = 0;
        return false;
    }
    if (behaviortreeentity haspath()) {
        behaviortreeentity.reacquire_state = 0;
        return false;
    }
    if (behaviortreeentity seerecently(behaviortreeentity.enemy, 4)) {
        behaviortreeentity.reacquire_state = 0;
        return false;
    }
    dirtoenemy = vectornormalize(behaviortreeentity.enemy.origin - behaviortreeentity.origin);
    forward = anglestoforward(behaviortreeentity.angles);
    if (vectordot(dirtoenemy, forward) < 0.5) {
        behaviortreeentity.reacquire_state = 0;
        return false;
    }
    switch (behaviortreeentity.reacquire_state) {
    case 0:
    case 1:
    case 2:
        step_size = 32 + behaviortreeentity.reacquire_state * 32;
        reacquirepos = behaviortreeentity reacquirestep(step_size);
        break;
    case 4:
        if (!behaviortreeentity cansee(behaviortreeentity.enemy) || !behaviortreeentity canshootenemy()) {
            behaviortreeentity flagenemyunattackable();
        }
        break;
    default:
        if (behaviortreeentity.reacquire_state > 15) {
            behaviortreeentity.reacquire_state = 0;
            return false;
        }
        break;
    }
    if (isvec(reacquirepos)) {
        behaviortreeentity function_3c8dce03(reacquirepos);
        return true;
    }
    behaviortreeentity.reacquire_state++;
    return false;
}

