#using scripts/core_common/ai/archetype_cover_utility;
#using scripts/core_common/ai/archetype_human_blackboard;
#using scripts/core_common/ai/archetype_human_cover;
#using scripts/core_common/ai/archetype_human_exposed;
#using scripts/core_common/ai/archetype_human_interface;
#using scripts/core_common/ai/archetype_human_locomotion;
#using scripts/core_common/ai/archetype_mocomps_utility;
#using scripts/core_common/ai/archetype_notetracks;
#using scripts/core_common/ai/archetype_utility;
#using scripts/core_common/ai/systems/ai_blackboard;
#using scripts/core_common/ai/systems/ai_interface;
#using scripts/core_common/ai/systems/animation_state_machine_utility;
#using scripts/core_common/ai/systems/behavior_tree_utility;
#using scripts/core_common/ai/systems/blackboard;
#using scripts/core_common/ai/systems/destructible_character;
#using scripts/core_common/ai/systems/gib;
#using scripts/core_common/ai_shared;
#using scripts/core_common/array_shared;
#using scripts/core_common/callbacks_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/gameskill_shared;
#using scripts/core_common/math_shared;
#using scripts/core_common/spawner_shared;
#using scripts/core_common/util_shared;

#namespace archetype_human;

// Namespace archetype_human/archetype_human
// Params 0, eflags: 0x2
// Checksum 0x1ead7ccd, Offset: 0x750
// Size: 0xc0
function autoexec init() {
    spawner::add_archetype_spawn_function("human", &archetypehumanblackboardinit);
    spawner::add_archetype_spawn_function("human", &archetypehumaninit);
    humaninterface::registerhumaninterfaceattributes();
    clientfield::register("actor", "facial_dial", 1, 1, "int");
    /#
        level.__ai_forcegibs = getdvarint("<dev string:x28>");
    #/
}

// Namespace archetype_human/archetype_human
// Params 0, eflags: 0x4
// Checksum 0xed4d78ce, Offset: 0x818
// Size: 0x124
function private archetypehumaninit() {
    entity = self;
    aiutility::addaioverridedamagecallback(entity, &damageoverride);
    aiutility::addaioverridekilledcallback(entity, &humangibkilledoverride);
    locomotiontypes = array("alt1", "alt2", "alt3", "alt4");
    altindex = entity getentitynumber() % locomotiontypes.size;
    entity setblackboardattribute("_human_locomotion_variation", locomotiontypes[altindex]);
    if (isdefined(entity.hero) && entity.hero) {
        entity setblackboardattribute("_human_locomotion_variation", "alt1");
    }
}

// Namespace archetype_human/archetype_human
// Params 0, eflags: 0x4
// Checksum 0xcc1e9b30, Offset: 0x948
// Size: 0xec
function private archetypehumanblackboardinit() {
    blackboard::createblackboardforentity(self);
    ai::createinterfaceforentity(self);
    self.___archetypeonanimscriptedcallback = &archetypehumanonanimscriptedcallback;
    self.___archetypeonbehavecallback = &archetypehumanonbehavecallback;
    self thread gameskill::function_bc280431(self);
    if (self.accuratefire) {
        self thread aiutility::preshootlaserandglinton(self);
        self thread aiutility::postshootlaserandglintoff(self);
    }
    destructserverutils::togglespawngibs(self, 1);
    gibserverutils::togglespawngibs(self, 1);
}

// Namespace archetype_human/archetype_human
// Params 1, eflags: 0x4
// Checksum 0xb8695bc3, Offset: 0xa40
// Size: 0xdc
function private archetypehumanonbehavecallback(entity) {
    if (btapi_isatcovercondition(entity)) {
        entity setblackboardattribute("_previous_cover_mode", "cover_alert");
        entity setblackboardattribute("_cover_mode", "cover_mode_none");
    }
    grenadethrowinfo = spawnstruct();
    grenadethrowinfo.grenadethrower = entity;
    blackboard::addblackboardevent("human_grenade_throw", grenadethrowinfo, randomintrange(3000, 4000));
}

// Namespace archetype_human/archetype_human
// Params 1, eflags: 0x4
// Checksum 0x5238f95f, Offset: 0xb28
// Size: 0x84
function private archetypehumanonanimscriptedcallback(entity) {
    entity.__blackboard = undefined;
    entity archetypehumanblackboardinit();
    vignettemode = ai::getaiattribute(entity, "vignette_mode");
    humansoldierserverutils::vignettemodecallback(entity, "vignette_mode", vignettemode, vignettemode);
}

// Namespace archetype_human/archetype_human
// Params 8, eflags: 0x4
// Checksum 0x917b4619, Offset: 0xbb8
// Size: 0x318
function private humangibkilledoverride(inflictor, attacker, damage, meansofdeath, weapon, dir, hitloc, offsettime) {
    entity = self;
    if (math::cointoss()) {
        return damage;
    }
    attackerdistance = 0;
    if (isdefined(attacker)) {
        attackerdistance = distancesquared(attacker.origin, entity.origin);
    }
    isexplosive = isinarray(array("MOD_CRUSH", "MOD_GRENADE", "MOD_GRENADE_SPLASH", "MOD_PROJECTILE", "MOD_PROJECTILE_SPLASH", "MOD_EXPLOSIVE"), meansofdeath);
    forcegibbing = 0;
    if (isdefined(weapon.weapclass) && weapon.weapclass == "turret") {
        forcegibbing = 1;
        if (isdefined(inflictor)) {
            isdirectexplosive = isinarray(array("MOD_GRENADE", "MOD_GRENADE_SPLASH", "MOD_PROJECTILE", "MOD_PROJECTILE_SPLASH", "MOD_EXPLOSIVE"), meansofdeath);
            iscloseexplosive = distancesquared(inflictor.origin, entity.origin) <= 60 * 60;
            if (isdirectexplosive && iscloseexplosive) {
                gibserverutils::annihilate(entity);
            }
        }
    }
    if (weapon.dogibbing && (isdefined(level.__ai_forcegibs) && (forcegibbing || isexplosive || level.__ai_forcegibs) || attackerdistance <= weapon.maxgibdistance * weapon.maxgibdistance)) {
        gibserverutils::togglespawngibs(entity, 1);
        destructserverutils::togglespawngibs(entity, 1);
        trygibbinglimb(entity, damage, hitloc, isexplosive || forcegibbing);
        trygibbinglegs(entity, damage, hitloc, isexplosive);
    }
    return damage;
}

// Namespace archetype_human/archetype_human
// Params 4, eflags: 0x4
// Checksum 0x8d58a0b3, Offset: 0xed8
// Size: 0x9c
function private trygibbinghead(entity, damage, hitloc, isexplosive) {
    if (isexplosive) {
        gibserverutils::gibhead(entity);
        return;
    }
    if (isinarray(array("head", "neck", "helmet"), hitloc)) {
        gibserverutils::gibhead(entity);
    }
}

// Namespace archetype_human/archetype_human
// Params 4, eflags: 0x4
// Checksum 0xf79c4ad1, Offset: 0xf80
// Size: 0x1cc
function private trygibbinglimb(entity, damage, hitloc, isexplosive) {
    if (isexplosive) {
        randomchance = randomfloatrange(0, 1);
        if (randomchance < 0.5) {
            gibserverutils::gibrightarm(entity);
        } else {
            gibserverutils::gibleftarm(entity);
        }
        return;
    }
    if (isinarray(array("left_hand", "left_arm_lower", "left_arm_upper"), hitloc)) {
        gibserverutils::gibleftarm(entity);
        return;
    }
    if (isinarray(array("right_hand", "right_arm_lower", "right_arm_upper"), hitloc)) {
        gibserverutils::gibrightarm(entity);
        return;
    }
    if (isinarray(array("torso_upper"), hitloc) && math::cointoss()) {
        if (math::cointoss()) {
            gibserverutils::gibleftarm(entity);
            return;
        }
        gibserverutils::gibrightarm(entity);
    }
}

// Namespace archetype_human/archetype_human
// Params 5, eflags: 0x4
// Checksum 0xa1ce12f0, Offset: 0x1158
// Size: 0x1fc
function private trygibbinglegs(entity, damage, hitloc, isexplosive, attacker) {
    if (isexplosive) {
        randomchance = randomfloatrange(0, 1);
        if (randomchance < 0.33) {
            gibserverutils::gibrightleg(entity);
        } else if (randomchance < 0.66) {
            gibserverutils::gibleftleg(entity);
        } else {
            gibserverutils::giblegs(entity);
        }
        return;
    }
    if (isinarray(array("left_leg_upper", "left_leg_lower", "left_foot"), hitloc)) {
        gibserverutils::gibleftleg(entity);
        return;
    }
    if (isinarray(array("right_leg_upper", "right_leg_lower", "right_foot"), hitloc)) {
        gibserverutils::gibrightleg(entity);
        return;
    }
    if (isinarray(array("torso_lower"), hitloc) && math::cointoss()) {
        if (math::cointoss()) {
            gibserverutils::gibleftleg(entity);
            return;
        }
        gibserverutils::gibrightleg(entity);
    }
}

// Namespace archetype_human/archetype_human
// Params 12, eflags: 0x0
// Checksum 0xa9161c2, Offset: 0x1360
// Size: 0x1bc
function damageoverride(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, psoffsettime, boneindex, modelindex) {
    entity = self;
    entity destructserverutils::handledamage(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, psoffsettime, boneindex, modelindex);
    if (isdefined(eattacker) && !isplayer(eattacker) && !isvehicle(eattacker)) {
        dist = distancesquared(entity.origin, eattacker.origin);
        if (dist < 65536) {
            idamage = int(idamage * 10);
        } else {
            idamage = int(idamage * 1.5);
        }
    }
    if (sweapon.name == "incendiary_grenade") {
        idamage = entity.health;
    }
    return idamage;
}

#namespace humansoldierserverutils;

// Namespace humansoldierserverutils/archetype_human
// Params 4, eflags: 0x0
// Checksum 0x1ac6c117, Offset: 0x1528
// Size: 0xa4
function cqbattributecallback(entity, attribute, oldvalue, value) {
    if (value) {
        entity asmchangeanimmappingtable(2);
        return;
    }
    if (entity ai::get_behavior_attribute("useAnimationOverride")) {
        entity asmchangeanimmappingtable(1);
        return;
    }
    entity asmchangeanimmappingtable(0);
}

// Namespace humansoldierserverutils/archetype_human
// Params 4, eflags: 0x0
// Checksum 0x3d227df1, Offset: 0x15d8
// Size: 0x38
function forcetacticalwalkcallback(entity, attribute, oldvalue, value) {
    entity.ignorerunandgundist = value;
}

// Namespace humansoldierserverutils/archetype_human
// Params 4, eflags: 0x0
// Checksum 0x9d9123c4, Offset: 0x1618
// Size: 0x6e
function movemodeattributecallback(entity, attribute, oldvalue, value) {
    entity.ignorepathenemyfightdist = 0;
    switch (value) {
    case #"normal":
        break;
    case #"rambo":
        entity.ignorepathenemyfightdist = 1;
        break;
    }
}

// Namespace humansoldierserverutils/archetype_human
// Params 4, eflags: 0x0
// Checksum 0x5ca46456, Offset: 0x1690
// Size: 0x64
function useanimationoverridecallback(entity, attribute, oldvalue, value) {
    if (value) {
        entity asmchangeanimmappingtable(1);
        return;
    }
    entity asmchangeanimmappingtable(0);
}

// Namespace humansoldierserverutils/archetype_human
// Params 4, eflags: 0x0
// Checksum 0xa3a101f0, Offset: 0x1700
// Size: 0x54
function disablesprintcallback(entity, attribute, oldvalue, value) {
    if (value) {
        entity.disablesprint = 1;
        return;
    }
    entity.disablesprint = 0;
}

// Namespace humansoldierserverutils/archetype_human
// Params 4, eflags: 0x0
// Checksum 0x546dd842, Offset: 0x1760
// Size: 0x54
function forcesprintcallback(entity, attribute, oldvalue, value) {
    if (value) {
        entity.forcesprint = 1;
        return;
    }
    entity.forcesprint = 0;
}

// Namespace humansoldierserverutils/archetype_human
// Params 4, eflags: 0x0
// Checksum 0x2bba7544, Offset: 0x17c0
// Size: 0x1f2
function vignettemodecallback(entity, attribute, oldvalue, value) {
    switch (value) {
    case #"off":
        entity.pushable = 1;
        entity collidewithactors(0);
        entity pushplayer(0);
        entity setavoidancemask("avoid all");
        entity setsteeringmode("normal steering");
        break;
    case #"slow":
        entity.pushable = 0;
        entity collidewithactors(0);
        entity pushplayer(1);
        entity setavoidancemask("avoid ai");
        entity setsteeringmode("vignette steering");
        break;
    case #"fast":
        entity.pushable = 0;
        entity collidewithactors(1);
        entity pushplayer(1);
        entity setavoidancemask("avoid none");
        entity setsteeringmode("vignette steering");
        break;
    default:
        break;
    }
}

