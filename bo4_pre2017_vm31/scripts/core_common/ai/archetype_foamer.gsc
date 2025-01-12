#using scripts/core_common/ai/archetype_foamer_interface;
#using scripts/core_common/ai/archetype_locomotion_utility;
#using scripts/core_common/ai/archetype_mocomps_utility;
#using scripts/core_common/ai/archetype_utility;
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

#namespace archetype_foamer;

// Namespace archetype_foamer/archetype_foamer
// Params 0, eflags: 0x2
// Checksum 0x62b1a80d, Offset: 0x4b8
// Size: 0x34
function autoexec __init__sytem__() {
    system::register("foamer", &__init__, undefined, undefined);
}

// Namespace archetype_foamer/archetype_foamer
// Params 0, eflags: 0x0
// Checksum 0xf8098a75, Offset: 0x4f8
// Size: 0x64
function __init__() {
    spawner::add_archetype_spawn_function("foamer", &foamerblackboardinit);
    spawner::add_archetype_spawn_function("foamer", &foamerspawnsetup);
    foamerinterface::registerfoamerinterfaceattributes();
}

// Namespace archetype_foamer/archetype_foamer
// Params 0, eflags: 0x2
// Checksum 0x273a39cd, Offset: 0x568
// Size: 0xc4
function autoexec registerbehaviorscriptfunctions() {
    assert(isscriptfunctionptr(&foamerchoosebetterpositionservice));
    behaviortreenetworkutility::registerbehaviortreescriptapi("foamerChooseBetterPositionService", &foamerchoosebetterpositionservice);
    assert(isscriptfunctionptr(&foamerreaquireservice));
    behaviortreenetworkutility::registerbehaviortreescriptapi("foamerReaquireService", &foamerreaquireservice);
}

// Namespace archetype_foamer/archetype_foamer
// Params 0, eflags: 0x0
// Checksum 0xf95ff83b, Offset: 0x638
// Size: 0x64
function foamerspawnsetup() {
    self.ignorerunandgundist = 1;
    self.combatmode = "no_cover";
    aiutility::addaioverridedamagecallback(self, &foamerdamageoverride);
    aiutility::addaioverridekilledcallback(self, &foamerkilledoverride);
}

// Namespace archetype_foamer/archetype_foamer
// Params 0, eflags: 0x4
// Checksum 0x6d551834, Offset: 0x6a8
// Size: 0x64
function private foamerblackboardinit() {
    blackboard::createblackboardforentity(self);
    ai::createinterfaceforentity(self);
    self.___archetypeonanimscriptedcallback = &foameronanimscriptedcallback;
    self.___archetypeonbehavecallback = &foameronbehavecallback;
}

// Namespace archetype_foamer/archetype_foamer
// Params 1, eflags: 0x4
// Checksum 0xc2205ad7, Offset: 0x718
// Size: 0x34
function private foameronanimscriptedcallback(entity) {
    entity.__blackboard = undefined;
    entity foamerblackboardinit();
}

// Namespace archetype_foamer/archetype_foamer
// Params 1, eflags: 0x4
// Checksum 0x94fa609e, Offset: 0x758
// Size: 0x434
function private foamerchoosebetterpositionservice(entity) {
    if (!isdefined(entity.enemy)) {
        return false;
    }
    if (entity asmistransitionrunning() || entity getbehaviortreestatus() != 5 || entity asmissubstatepending() || entity asmistransdecrunning()) {
        return false;
    }
    if (entity shouldholdgroundagainstenemy()) {
        return false;
    }
    if (entity getpathmode() == "dont move") {
        return false;
    }
    isatscriptgoal = entity isatgoal();
    itsbeenawhile = gettime() > entity.nextfindbestcovertime;
    isinbadplace = entity isinanybadplace();
    iswithineffectiverangealready = 0;
    lastknownpos = entity lastknownpos(entity.enemy);
    dist = distance2d(entity.origin, lastknownpos);
    if (dist > entity.engageminfalloffdist && dist <= entity.engagemaxfalloffdist) {
        iswithineffectiverangealready = 1;
    }
    shouldfindbetterposition = !isatscriptgoal || itsbeenawhile && !iswithineffectiverangealready || isinbadplace;
    if (!shouldfindbetterposition) {
        return false;
    }
    pixbeginevent("foamer_tacquery_combat");
    aiprofile_beginentry("foamer_tacquery_combat");
    forwardpos = vectorscale(vectornormalize(anglestoforward((0, self.angles[1], 0))), 100);
    tacpoints = tacticalquery("foamer_tacquery_combat", entity.enemy.origin, forwardpos, entity);
    pixendevent();
    aiprofile_endentry();
    pickedpoint = undefined;
    if (isdefined(tacpoints)) {
        foreach (tacpoint in tacpoints) {
            if (!self isposinclaimedlocation(tacpoint.origin)) {
                pickedpoint = tacpoint;
                break;
            }
        }
    }
    if (isdefined(pickedpoint)) {
        if (entity.pathgoalpos !== pickedpoint.origin) {
            entity useposition(pickedpoint.origin);
            aiutility::setnextfindbestcovertime(entity, undefined);
            return true;
        }
    }
    return false;
}

// Namespace archetype_foamer/archetype_foamer
// Params 1, eflags: 0x4
// Checksum 0x8dbadd99, Offset: 0xb98
// Size: 0x2e2
function private foamerreaquireservice(entity) {
    if (!isdefined(entity.reacquire_state)) {
        entity.reacquire_state = 0;
    }
    if (!isdefined(entity.enemy)) {
        entity.reacquire_state = 0;
        return false;
    }
    if (entity haspath()) {
        return false;
    }
    if (entity cansee(entity.enemy) && entity canshootenemy()) {
        entity.reacquire_state = 0;
        return false;
    }
    dirtoenemy = vectornormalize(entity.enemy.origin - entity.origin);
    forward = anglestoforward(entity.angles);
    if (vectordot(dirtoenemy, forward) < 0.5) {
        entity.reacquire_state = 0;
        return false;
    }
    switch (entity.reacquire_state) {
    case 0:
    case 1:
    case 2:
        step_size = 32 + entity.reacquire_state * 32;
        reacquirepos = entity reacquirestep(step_size);
        break;
    case 4:
        if (!entity cansee(entity.enemy) || !entity canshootenemy()) {
            entity flagenemyunattackable();
        }
        break;
    default:
        if (entity.reacquire_state > 15) {
            entity.reacquire_state = 0;
            return false;
        }
        break;
    }
    if (isvec(reacquirepos)) {
        entity useposition(reacquirepos);
        entity.reacquire_state = 0;
        return true;
    }
    entity.reacquire_state++;
    return false;
}

// Namespace archetype_foamer/archetype_foamer
// Params 1, eflags: 0x4
// Checksum 0xc88e551a, Offset: 0xe88
// Size: 0xc
function private foameronbehavecallback(entity) {
    
}

// Namespace archetype_foamer/archetype_foamer
// Params 15, eflags: 0x4
// Checksum 0x3c827022, Offset: 0xea0
// Size: 0x80
function private foamerdamageoverride(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, timeoffset, boneindex, modelindex, surfacetype, surfacenormal) {
    return idamage;
}

// Namespace archetype_foamer/archetype_foamer
// Params 8, eflags: 0x4
// Checksum 0x3ed69f51, Offset: 0xf28
// Size: 0x48
function private foamerkilledoverride(inflictor, attacker, damage, meansofdeath, weapon, dir, hitloc, offsettime) {
    return damage;
}

