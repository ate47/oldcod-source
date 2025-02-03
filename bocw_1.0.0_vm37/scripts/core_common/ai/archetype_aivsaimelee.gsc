#using scripts\core_common\ai\archetype_utility;
#using scripts\core_common\ai\systems\behavior_tree_utility;
#using scripts\core_common\ai_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;

#namespace archetype_aivsaimelee;

// Namespace archetype_aivsaimelee/archetype_aivsaimelee
// Params 0, eflags: 0x2
// Checksum 0x3079f9d5, Offset: 0x1f0
// Size: 0x1e6
function autoexec main() {
    meleebundles = getscriptbundles("aiassassination");
    level._aivsai_meleebundles = [];
    foreach (meleebundle in meleebundles) {
        attacker_archetype = meleebundle.attackerarchetype;
        defender_archetype = meleebundle.defenderarchetype;
        attacker_variant = meleebundle.attackervariant;
        defender_variant = meleebundle.defendervariant;
        if (!isdefined(level._aivsai_meleebundles[attacker_archetype])) {
            level._aivsai_meleebundles[attacker_archetype] = [];
            level._aivsai_meleebundles[attacker_archetype][defender_archetype] = [];
            level._aivsai_meleebundles[attacker_archetype][defender_archetype][attacker_variant] = [];
        } else if (!isdefined(level._aivsai_meleebundles[attacker_archetype][defender_archetype])) {
            level._aivsai_meleebundles[attacker_archetype][defender_archetype] = [];
            level._aivsai_meleebundles[attacker_archetype][defender_archetype][attacker_variant] = [];
        } else if (!isdefined(level._aivsai_meleebundles[attacker_archetype][defender_archetype][attacker_variant])) {
            level._aivsai_meleebundles[attacker_archetype][defender_archetype][attacker_variant] = [];
        }
        level._aivsai_meleebundles[attacker_archetype][defender_archetype][attacker_variant][defender_variant] = meleebundle;
    }
}

// Namespace archetype_aivsaimelee/archetype_aivsaimelee
// Params 0, eflags: 0x0
// Checksum 0x3dde23bc, Offset: 0x3e0
// Size: 0x3d4
function registeraivsaimeleebehaviorfunctions() {
    assert(isscriptfunctionptr(&hasaivsaienemy));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hasaivsaienemy", &hasaivsaienemy);
    assert(isscriptfunctionptr(&decideinitiator));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"decideinitiator", &decideinitiator);
    assert(isscriptfunctionptr(&isinitiator));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"isinitiator", &isinitiator);
    assert(isscriptfunctionptr(&hascloseaivsaienemy));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hascloseaivsaienemy", &hascloseaivsaienemy);
    assert(isscriptfunctionptr(&chooseaivsaimeleeanimations));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"chooseaivsaimeleeanimations", &chooseaivsaimeleeanimations);
    assert(isscriptfunctionptr(&iscloseenoughforaivsaimelee));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"iscloseenoughforaivsaimelee", &iscloseenoughforaivsaimelee);
    assert(isscriptfunctionptr(&haspotentalaivsaimeleeenemy));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"haspotentalaivsaimeleeenemy", &haspotentalaivsaimeleeenemy);
    assert(!isdefined(&aivsaimeleeinitialize) || isscriptfunctionptr(&aivsaimeleeinitialize));
    assert(!isdefined(undefined) || isscriptfunctionptr(undefined));
    assert(!isdefined(undefined) || isscriptfunctionptr(undefined));
    behaviortreenetworkutility::registerbehaviortreeaction(#"aivsaimeleeaction", &aivsaimeleeinitialize, undefined, undefined);
}

// Namespace archetype_aivsaimelee/archetype_aivsaimelee
// Params 1, eflags: 0x0
// Checksum 0xedb00591, Offset: 0x7c0
// Size: 0x5e
function haspotentalaivsaimeleeenemy(behaviortreeentity) {
    if (!hasaivsaienemy(behaviortreeentity)) {
        return false;
    }
    if (!chooseaivsaimeleeanimations(behaviortreeentity)) {
        return false;
    }
    if (!hascloseaivsaienemy(behaviortreeentity)) {
        return true;
    }
    return false;
}

// Namespace archetype_aivsaimelee/archetype_aivsaimelee
// Params 1, eflags: 0x0
// Checksum 0xaab13cf5, Offset: 0x828
// Size: 0x5e
function iscloseenoughforaivsaimelee(behaviortreeentity) {
    if (!hasaivsaienemy(behaviortreeentity)) {
        return false;
    }
    if (!chooseaivsaimeleeanimations(behaviortreeentity)) {
        return false;
    }
    if (!hascloseaivsaienemy(behaviortreeentity)) {
        return false;
    }
    return true;
}

// Namespace archetype_aivsaimelee/archetype_aivsaimelee
// Params 1, eflags: 0x4
// Checksum 0xc4440b19, Offset: 0x890
// Size: 0xaa
function private shouldaquiremutexonenemyforaivsaimelee(behaviortreeentity) {
    if (isplayer(behaviortreeentity.enemy)) {
        return false;
    }
    if (!isdefined(behaviortreeentity.enemy)) {
        return false;
    }
    if (isdefined(behaviortreeentity.meleeenemy) && behaviortreeentity.meleeenemy == behaviortreeentity.enemy) {
        return true;
    }
    if (isdefined(behaviortreeentity.enemy.meleeenemy) && behaviortreeentity.enemy.meleeenemy != behaviortreeentity) {
        return false;
    }
    return true;
}

// Namespace archetype_aivsaimelee/archetype_aivsaimelee
// Params 1, eflags: 0x4
// Checksum 0x9a92c4f9, Offset: 0x948
// Size: 0xb38
function private hasaivsaienemy(behaviortreeentity) {
    enemy = behaviortreeentity.enemy;
    if (getdvarint(#"disable_aivsai_melee", 0)) {
        /#
            record3dtext("<dev string:x38>", behaviortreeentity.origin, (1, 0.5, 0), "<dev string:x64>", behaviortreeentity, 0.4);
        #/
        return false;
    }
    if (!isdefined(enemy)) {
        /#
            record3dtext("<dev string:x72>", behaviortreeentity.origin, (1, 0.5, 0), "<dev string:x64>", behaviortreeentity, 0.4);
        #/
        return false;
    }
    if (!(isalive(behaviortreeentity) && isalive(enemy))) {
        /#
            record3dtext("<dev string:x96>", behaviortreeentity.origin, (1, 0.5, 0), "<dev string:x64>", behaviortreeentity, 0.4);
        #/
        return false;
    }
    if (!isai(enemy) || !isactor(enemy)) {
        /#
            record3dtext("<dev string:xd0>", behaviortreeentity.origin, (1, 0.5, 0), "<dev string:x64>", behaviortreeentity, 0.4);
        #/
        return false;
    }
    if (isdefined(enemy.archetype)) {
        if (enemy.archetype != #"human" && enemy.archetype != #"human_riotshield" && enemy.archetype != #"robot") {
            /#
                record3dtext("<dev string:xff>", behaviortreeentity.origin, (1, 0.5, 0), "<dev string:x64>", behaviortreeentity, 0.4);
            #/
            return false;
        }
    }
    if (enemy.team == behaviortreeentity.team) {
        /#
            record3dtext("<dev string:x13b>", behaviortreeentity.origin, (1, 0.5, 0), "<dev string:x64>", behaviortreeentity, 0.4);
        #/
        return false;
    }
    if (enemy isragdoll()) {
        /#
            record3dtext("<dev string:x16c>", behaviortreeentity.origin, (1, 0.5, 0), "<dev string:x64>", behaviortreeentity, 0.4);
        #/
        return false;
    }
    if (is_true(enemy.ignoreme)) {
        /#
            record3dtext("<dev string:x19b>", behaviortreeentity.origin, (1, 0.5, 0), "<dev string:x64>", behaviortreeentity, 0.4);
        #/
        return false;
    }
    if (is_true(enemy._ai_melee_markeddead)) {
        /#
            record3dtext("<dev string:x1ce>", behaviortreeentity.origin, (1, 0.5, 0), "<dev string:x64>", behaviortreeentity, 0.4);
        #/
        return false;
    }
    if (behaviortreeentity ai::has_behavior_attribute("can_initiateaivsaimelee") && !behaviortreeentity ai::get_behavior_attribute("can_initiateaivsaimelee")) {
        /#
            record3dtext("<dev string:x211>", behaviortreeentity.origin, (1, 0.5, 0), "<dev string:x64>", behaviortreeentity, 0.4);
        #/
        return false;
    }
    if (behaviortreeentity ai::has_behavior_attribute("can_melee") && !behaviortreeentity ai::get_behavior_attribute("can_melee")) {
        /#
            record3dtext("<dev string:x25a>", behaviortreeentity.origin, (1, 0.5, 0), "<dev string:x64>", behaviortreeentity, 0.4);
        #/
        return false;
    }
    if (enemy ai::has_behavior_attribute("can_be_meleed") && !enemy ai::get_behavior_attribute("can_be_meleed")) {
        /#
            record3dtext("<dev string:x295>", behaviortreeentity.origin, (1, 0.5, 0), "<dev string:x64>", behaviortreeentity, 0.4);
        #/
        return false;
    }
    if (distance2dsquared(behaviortreeentity.origin, enemy.origin) > 22500) {
        /#
            record3dtext("<dev string:x2cd>", behaviortreeentity.origin, (1, 0.5, 0), "<dev string:x64>", behaviortreeentity, 0.4);
        #/
        behaviortreeentity._ai_melee_initiator = undefined;
        return false;
    }
    forwardvec = vectornormalize(anglestoforward(behaviortreeentity.angles));
    rightvec = vectornormalize(anglestoright(behaviortreeentity.angles));
    toenemyvec = vectornormalize(enemy.origin - behaviortreeentity.origin);
    fdot = vectordot(toenemyvec, forwardvec);
    if (fdot < 0) {
        /#
            record3dtext("<dev string:x2f6>", behaviortreeentity.origin, (1, 0.5, 0), "<dev string:x64>", behaviortreeentity, 0.4);
        #/
        return false;
    }
    if (enemy isinscriptedstate()) {
        /#
            record3dtext("<dev string:x321>", behaviortreeentity.origin, (1, 0.5, 0), "<dev string:x64>", behaviortreeentity, 0.4);
        #/
        return false;
    }
    currentstance = behaviortreeentity getblackboardattribute("_stance");
    enemystance = enemy getblackboardattribute("_stance");
    if (currentstance != "stand" || enemystance != "stand") {
        /#
            record3dtext("<dev string:x354>", behaviortreeentity.origin, (1, 0.5, 0), "<dev string:x64>", behaviortreeentity, 0.4);
        #/
        return false;
    }
    if (!shouldaquiremutexonenemyforaivsaimelee(behaviortreeentity)) {
        /#
            record3dtext("<dev string:x38e>", behaviortreeentity.origin, (1, 0.5, 0), "<dev string:x64>", behaviortreeentity, 0.4);
        #/
        return false;
    }
    if (abs(behaviortreeentity.origin[2] - behaviortreeentity.enemy.origin[2]) > 16) {
        /#
            record3dtext("<dev string:x3c8>", behaviortreeentity.origin, (1, 0.5, 0), "<dev string:x64>", behaviortreeentity, 0.4);
        #/
        return false;
    }
    raisedenemyentorigin = (behaviortreeentity.enemy.origin[0], behaviortreeentity.enemy.origin[1], behaviortreeentity.enemy.origin[2] + 8);
    if (!behaviortreeentity maymovetopoint(raisedenemyentorigin, 0, 1, behaviortreeentity.enemy)) {
        /#
            record3dtext("<dev string:x3f5>", behaviortreeentity.origin, (1, 0.5, 0), "<dev string:x64>", behaviortreeentity, 0.4);
        #/
        return false;
    }
    if (isdefined(enemy.allowdeath) && !enemy.allowdeath) {
        if (isdefined(behaviortreeentity.allowdeath) && !behaviortreeentity.allowdeath) {
            /#
                record3dtext("<dev string:x41d>", behaviortreeentity.origin, (1, 0.5, 0), "<dev string:x64>", behaviortreeentity, 0.4);
            #/
            self notify(#"failed_melee_mbs", {#entity:enemy});
            return false;
        }
        behaviortreeentity._ai_melee_attacker_loser = 1;
        return true;
    }
    return true;
}

// Namespace archetype_aivsaimelee/archetype_aivsaimelee
// Params 1, eflags: 0x4
// Checksum 0x3b68acb6, Offset: 0x1488
// Size: 0x4a
function private decideinitiator(behaviortreeentity) {
    if (!isdefined(behaviortreeentity._ai_melee_initiator)) {
        if (!isdefined(behaviortreeentity.enemy._ai_melee_initiator)) {
            behaviortreeentity._ai_melee_initiator = 1;
            return true;
        }
    }
    return false;
}

// Namespace archetype_aivsaimelee/archetype_aivsaimelee
// Params 1, eflags: 0x4
// Checksum 0xf9c1c73a, Offset: 0x14e0
// Size: 0x2e
function private isinitiator(behaviortreeentity) {
    if (!is_true(behaviortreeentity._ai_melee_initiator)) {
        return false;
    }
    return true;
}

// Namespace archetype_aivsaimelee/archetype_aivsaimelee
// Params 1, eflags: 0x4
// Checksum 0x4338dad6, Offset: 0x1518
// Size: 0x3a4
function private hascloseaivsaienemy(behaviortreeentity) {
    if (!(isdefined(behaviortreeentity._ai_melee_animname) && isdefined(behaviortreeentity.enemy._ai_melee_animname))) {
        /#
            record3dtext("<dev string:x456>", behaviortreeentity.origin, (1, 0.5, 0), "<dev string:x64>", behaviortreeentity, 0.4);
        #/
        return false;
    }
    animationstartorigin = getstartorigin(behaviortreeentity.enemy gettagorigin("tag_sync"), behaviortreeentity.enemy gettagangles("tag_sync"), behaviortreeentity._ai_melee_animname);
    /#
        record3dtext("<dev string:x485>" + sqrt(900), behaviortreeentity.origin, (1, 0.5, 0), "<dev string:x64>", behaviortreeentity, 0.4);
        record3dtext("<dev string:x4b7>" + distance(animationstartorigin, behaviortreeentity.origin), behaviortreeentity.origin, (1, 0.5, 0), "<dev string:x64>", behaviortreeentity, 0.4);
        recordcircle(behaviortreeentity.enemy gettagorigin("<dev string:x4e0>"), 8, (1, 0, 0), "<dev string:x64>", behaviortreeentity);
        recordcircle(animationstartorigin, 8, (1, 0.5, 0), "<dev string:x64>", behaviortreeentity);
        recordline(animationstartorigin, behaviortreeentity.origin, (1, 0.5, 0), "<dev string:x64>", behaviortreeentity);
    #/
    if (distance2dsquared(behaviortreeentity.origin, animationstartorigin) <= 900) {
        return true;
    }
    if (behaviortreeentity haspath()) {
        selfpredictedpos = behaviortreeentity.origin;
        moveangle = behaviortreeentity.angles[1] + behaviortreeentity getmotionangle();
        selfpredictedpos += (cos(moveangle), sin(moveangle), 0) * 200 * 0.2;
        /#
            record3dtext("<dev string:x4ec>" + distance(selfpredictedpos, animationstartorigin), behaviortreeentity.origin, (1, 0.5, 0), "<dev string:x64>", behaviortreeentity, 0.4);
        #/
        if (distance2dsquared(selfpredictedpos, animationstartorigin) <= 900) {
            return true;
        }
    }
    return false;
}

// Namespace archetype_aivsaimelee/archetype_aivsaimelee
// Params 1, eflags: 0x4
// Checksum 0x3f2d68f6, Offset: 0x18c8
// Size: 0x4c4
function private chooseaivsaimeleeanimations(behaviortreeentity) {
    anglestoenemy = vectortoangles(behaviortreeentity.enemy.origin - behaviortreeentity.origin);
    yawtoenemy = angleclamp180(behaviortreeentity.enemy.angles[1] - anglestoenemy[1]);
    /#
        record3dtext("<dev string:x51d>" + abs(yawtoenemy), behaviortreeentity.origin, (1, 0.5, 0), "<dev string:x64>", behaviortreeentity, 0.4);
    #/
    behaviortreeentity._ai_melee_animname = undefined;
    behaviortreeentity.enemy._ai_melee_animname = undefined;
    attacker_variant = choosearchetypevariant(behaviortreeentity);
    defender_variant = choosearchetypevariant(behaviortreeentity.enemy);
    if (!aivsaimeleebundleexists(behaviortreeentity, attacker_variant, defender_variant)) {
        /#
            record3dtext("<dev string:x530>" + function_9e72a96(behaviortreeentity.archetype) + "<dev string:x566>" + behaviortreeentity.enemy.archetype + "<dev string:x566>" + attacker_variant + "<dev string:x566>" + defender_variant, behaviortreeentity.origin, (1, 0.5, 0), "<dev string:x64>", behaviortreeentity, 0.4);
        #/
        return false;
    }
    animbundle = level._aivsai_meleebundles[behaviortreeentity.archetype][behaviortreeentity.enemy.archetype][attacker_variant][defender_variant];
    /#
        if (is_true(behaviortreeentity._ai_melee_attacker_loser)) {
            record3dtext("<dev string:x56b>", behaviortreeentity.origin, (1, 0.5, 0), "<dev string:x64>", behaviortreeentity, 0.4);
        }
    #/
    foundanims = 0;
    possiblemelees = [];
    if (abs(yawtoenemy) > 120) {
        if (isdefined(behaviortreeentity.__forceaiflipmelee)) {
            possiblemelees[possiblemelees.size] = &chooseaivsaimeleefrontflipanimations;
        } else if (isdefined(behaviortreeentity.__forceaiwrestlemelee)) {
            possiblemelees[possiblemelees.size] = &chooseaivsaimeleefrontwrestleanimations;
        } else {
            possiblemelees[possiblemelees.size] = &chooseaivsaimeleefrontflipanimations;
            possiblemelees[possiblemelees.size] = &chooseaivsaimeleefrontwrestleanimations;
        }
    } else if (abs(yawtoenemy) < 60) {
        possiblemelees[possiblemelees.size] = &chooseaivsaimeleebackanimations;
    } else {
        rightvec = vectornormalize(anglestoright(behaviortreeentity.enemy.angles));
        toattackervec = vectornormalize(behaviortreeentity.origin - behaviortreeentity.enemy.origin);
        rdot = vectordot(toattackervec, rightvec);
        if (rdot > 0) {
            possiblemelees[possiblemelees.size] = &chooseaivsaimeleerightanimations;
        } else {
            possiblemelees[possiblemelees.size] = &chooseaivsaimeleeleftanimations;
        }
    }
    if (possiblemelees.size > 0) {
        [[ array::random(possiblemelees) ]](behaviortreeentity, animbundle);
    }
    if (isdefined(behaviortreeentity._ai_melee_animname)) {
        debug_chosenmeleeanimations(behaviortreeentity);
        return true;
    }
    return false;
}

// Namespace archetype_aivsaimelee/archetype_aivsaimelee
// Params 1, eflags: 0x4
// Checksum 0xcead36f3, Offset: 0x1d98
// Size: 0xee
function private choosearchetypevariant(entity) {
    if (entity.archetype == #"robot") {
        robot_state = entity ai::get_behavior_attribute("rogue_control");
        if (isinarray(array("forced_level_1", "level_1", "level_0"), robot_state)) {
            return "regular";
        }
        if (isinarray(array("forced_level_2", "level_2", "level_3", "forced_level_3"), robot_state)) {
            return "melee";
        }
    }
    return "regular";
}

// Namespace archetype_aivsaimelee/archetype_aivsaimelee
// Params 3, eflags: 0x4
// Checksum 0x1d40ae77, Offset: 0x1e90
// Size: 0xe0
function private aivsaimeleebundleexists(behaviortreeentity, attacker_variant, defender_variant) {
    if (!isdefined(level._aivsai_meleebundles[behaviortreeentity.archetype])) {
        return false;
    } else if (!isdefined(level._aivsai_meleebundles[behaviortreeentity.archetype][behaviortreeentity.enemy.archetype])) {
        return false;
    } else if (!isdefined(level._aivsai_meleebundles[behaviortreeentity.archetype][behaviortreeentity.enemy.archetype][attacker_variant])) {
        return false;
    } else if (!isdefined(level._aivsai_meleebundles[behaviortreeentity.archetype][behaviortreeentity.enemy.archetype][attacker_variant][defender_variant])) {
        return false;
    }
    return true;
}

// Namespace archetype_aivsaimelee/archetype_aivsaimelee
// Params 2, eflags: 0x0
// Checksum 0x89b599c9, Offset: 0x1f78
// Size: 0xe8
function aivsaimeleeinitialize(behaviortreeentity, *asmstatename) {
    asmstatename.blockingpain = 1;
    asmstatename.enemy.blockingpain = 1;
    aiutility::meleeacquiremutex(asmstatename);
    asmstatename._ai_melee_opponent = asmstatename.enemy;
    asmstatename.enemy._ai_melee_opponent = asmstatename;
    if (is_true(asmstatename._ai_melee_attacker_loser)) {
        asmstatename._ai_melee_markeddead = 1;
        asmstatename.enemy thread playscriptedmeleeanimations();
    } else {
        asmstatename.enemy._ai_melee_markeddead = 1;
        asmstatename thread playscriptedmeleeanimations();
    }
    return 5;
}

// Namespace archetype_aivsaimelee/archetype_aivsaimelee
// Params 0, eflags: 0x0
// Checksum 0xc4b59eb0, Offset: 0x2068
// Size: 0x614
function playscriptedmeleeanimations() {
    self endon(#"death");
    assert(isdefined(self._ai_melee_opponent));
    opponent = self._ai_melee_opponent;
    if (!(isalive(self) && isalive(opponent))) {
        /#
            record3dtext("<dev string:x599>", self.origin, (1, 0.5, 0), "<dev string:x64>", self, 0.4);
        #/
        return 0;
    }
    if (self isragdoll() || opponent isragdoll()) {
        /#
            record3dtext("<dev string:x5dc>", self.origin, (1, 0.5, 0), "<dev string:x64>", self, 0.4);
        #/
        return 0;
    }
    if (is_true(opponent._ai_melee_attacker_loser)) {
        opponent animscripted("aivsaimeleeloser", self gettagorigin("tag_sync"), self gettagangles("tag_sync"), opponent._ai_melee_animname, "normal", undefined, 1, 0.2, 0.3);
        self animscripted("aivsaimeleewinner", self gettagorigin("tag_sync"), self gettagangles("tag_sync"), self._ai_melee_animname, "normal", undefined, 1, 0.2, 0.3);
        /#
            recordcircle(self gettagorigin("<dev string:x4e0>"), 2, (1, 0.5, 0), "<dev string:x64>");
            recordline(self gettagorigin("<dev string:x4e0>"), opponent.origin, (1, 0.5, 0), "<dev string:x64>");
        #/
    } else {
        self animscripted("aivsaimeleewinner", opponent gettagorigin("tag_sync"), opponent gettagangles("tag_sync"), self._ai_melee_animname, "normal", undefined, 1, 0.2, 0.3);
        opponent animscripted("aivsaimeleeloser", opponent gettagorigin("tag_sync"), opponent gettagangles("tag_sync"), opponent._ai_melee_animname, "normal", undefined, 1, 0.2, 0.3);
        /#
            recordcircle(opponent gettagorigin("<dev string:x4e0>"), 2, (1, 0.5, 0), "<dev string:x64>");
            recordline(opponent gettagorigin("<dev string:x4e0>"), self.origin, (1, 0.5, 0), "<dev string:x64>");
        #/
    }
    opponent thread handledeath(opponent._ai_melee_animname, self);
    if (getdvarint(#"tu1_aivsaimeleedisablegib", 1)) {
        if (opponent ai::has_behavior_attribute("can_gib")) {
            opponent ai::set_behavior_attribute("can_gib", 0);
        }
    }
    self thread processinterrupteddeath();
    opponent thread processinterrupteddeath();
    self waittillmatch({#notetrack:"end"}, #"aivsaimeleewinner");
    self.fixedlinkyawonly = 0;
    aiutility::cleanupchargemeleeattack(self);
    if (is_true(self._ai_melee_attachedknife)) {
        self detach(#"wpn_t7_knife_combat_prop", "TAG_WEAPON_LEFT");
        self._ai_melee_attachedknife = 0;
    }
    self.blockingpain = 0;
    self._ai_melee_initiator = undefined;
    self notify(#"meleecompleted");
    self pathmode("move delayed", 1, 3);
}

// Namespace archetype_aivsaimelee/archetype_aivsaimelee
// Params 2, eflags: 0x4
// Checksum 0x478feba9, Offset: 0x2688
// Size: 0x102
function private chooseaivsaimeleefrontflipanimations(behaviortreeentity, animbundle) {
    /#
        record3dtext("<dev string:x61b>", behaviortreeentity.origin, (1, 0.5, 0), "<dev string:x64>", behaviortreeentity, 0.4);
    #/
    assert(isdefined(animbundle));
    if (is_true(behaviortreeentity._ai_melee_attacker_loser)) {
        behaviortreeentity._ai_melee_animname = animbundle.attackerloserfrontanim;
        behaviortreeentity.enemy._ai_melee_animname = animbundle.defenderwinnerfrontanim;
    } else {
        behaviortreeentity._ai_melee_animname = animbundle.attackerfrontanim;
        behaviortreeentity.enemy._ai_melee_animname = animbundle.victimfrontanim;
    }
    behaviortreeentity._ai_melee_animtype = 1;
    behaviortreeentity.enemy._ai_melee_animtype = 1;
}

// Namespace archetype_aivsaimelee/archetype_aivsaimelee
// Params 2, eflags: 0x4
// Checksum 0xd40eda7f, Offset: 0x2798
// Size: 0x102
function private chooseaivsaimeleefrontwrestleanimations(behaviortreeentity, animbundle) {
    /#
        record3dtext("<dev string:x61b>", behaviortreeentity.origin, (1, 0.5, 0), "<dev string:x64>", behaviortreeentity, 0.4);
    #/
    assert(isdefined(animbundle));
    if (is_true(behaviortreeentity._ai_melee_attacker_loser)) {
        behaviortreeentity._ai_melee_animname = animbundle.attackerloseralternatefrontanim;
        behaviortreeentity.enemy._ai_melee_animname = animbundle.defenderwinneralternatefrontanim;
    } else {
        behaviortreeentity._ai_melee_animname = animbundle.attackeralternatefrontanim;
        behaviortreeentity.enemy._ai_melee_animname = animbundle.victimalternatefrontanim;
    }
    behaviortreeentity._ai_melee_animtype = 0;
    behaviortreeentity.enemy._ai_melee_animtype = 0;
}

// Namespace archetype_aivsaimelee/archetype_aivsaimelee
// Params 2, eflags: 0x4
// Checksum 0x9b3639c7, Offset: 0x28a8
// Size: 0x102
function private chooseaivsaimeleebackanimations(behaviortreeentity, animbundle) {
    /#
        record3dtext("<dev string:x641>", behaviortreeentity.origin, (1, 0.5, 0), "<dev string:x64>", behaviortreeentity, 0.4);
    #/
    assert(isdefined(animbundle));
    if (is_true(behaviortreeentity._ai_melee_attacker_loser)) {
        behaviortreeentity._ai_melee_animname = animbundle.attackerloserbackanim;
        behaviortreeentity.enemy._ai_melee_animname = animbundle.defenderwinnerbackanim;
    } else {
        behaviortreeentity._ai_melee_animname = animbundle.attackerbackanim;
        behaviortreeentity.enemy._ai_melee_animname = animbundle.victimbackanim;
    }
    behaviortreeentity._ai_melee_animtype = 2;
    behaviortreeentity.enemy._ai_melee_animtype = 2;
}

// Namespace archetype_aivsaimelee/archetype_aivsaimelee
// Params 2, eflags: 0x4
// Checksum 0x7cdfc925, Offset: 0x29b8
// Size: 0x102
function private chooseaivsaimeleerightanimations(behaviortreeentity, animbundle) {
    /#
        record3dtext("<dev string:x666>", behaviortreeentity.origin, (1, 0.5, 0), "<dev string:x64>", behaviortreeentity, 0.4);
    #/
    assert(isdefined(animbundle));
    if (is_true(behaviortreeentity._ai_melee_attacker_loser)) {
        behaviortreeentity._ai_melee_animname = animbundle.attackerloserrightanim;
        behaviortreeentity.enemy._ai_melee_animname = animbundle.defenderwinnerrightanim;
    } else {
        behaviortreeentity._ai_melee_animname = animbundle.attackerrightanim;
        behaviortreeentity.enemy._ai_melee_animname = animbundle.victimrightanim;
    }
    behaviortreeentity._ai_melee_animtype = 3;
    behaviortreeentity.enemy._ai_melee_animtype = 3;
}

// Namespace archetype_aivsaimelee/archetype_aivsaimelee
// Params 2, eflags: 0x4
// Checksum 0x7d3c9533, Offset: 0x2ac8
// Size: 0x102
function private chooseaivsaimeleeleftanimations(behaviortreeentity, animbundle) {
    /#
        record3dtext("<dev string:x68c>", behaviortreeentity.origin, (1, 0.5, 0), "<dev string:x64>", behaviortreeentity, 0.4);
    #/
    assert(isdefined(animbundle));
    if (is_true(behaviortreeentity._ai_melee_attacker_loser)) {
        behaviortreeentity._ai_melee_animname = animbundle.attackerloserleftanim;
        behaviortreeentity.enemy._ai_melee_animname = animbundle.defenderwinnerleftanim;
    } else {
        behaviortreeentity._ai_melee_animname = animbundle.attackerleftanim;
        behaviortreeentity.enemy._ai_melee_animname = animbundle.victimleftanim;
    }
    behaviortreeentity._ai_melee_animtype = 4;
    behaviortreeentity.enemy._ai_melee_animtype = 4;
}

// Namespace archetype_aivsaimelee/archetype_aivsaimelee
// Params 1, eflags: 0x4
// Checksum 0x72c78d2, Offset: 0x2bd8
// Size: 0xe4
function private debug_chosenmeleeanimations(behaviortreeentity) {
    /#
        if (isdefined(behaviortreeentity._ai_melee_animname) && isdefined(behaviortreeentity.enemy._ai_melee_animname)) {
            record3dtext("<dev string:x6b1>" + behaviortreeentity._ai_melee_animname, behaviortreeentity.origin, (1, 0.5, 0), "<dev string:x64>", behaviortreeentity, 0.4);
            record3dtext("<dev string:x6cc>" + behaviortreeentity.enemy._ai_melee_animname, behaviortreeentity.origin, (1, 0.5, 0), "<dev string:x64>", behaviortreeentity, 0.4);
        }
    #/
}

// Namespace archetype_aivsaimelee/archetype_aivsaimelee
// Params 2, eflags: 0x0
// Checksum 0xe35abbb8, Offset: 0x2cc8
// Size: 0x94
function handledeath(animationname, attacker) {
    self endon(#"death", #"interrupteddeath");
    self.skipdeath = 1;
    self.diedinscriptedanim = 1;
    totaltime = getanimlength(animationname);
    wait totaltime - 0.2;
    self killwrapper(attacker);
}

// Namespace archetype_aivsaimelee/archetype_aivsaimelee
// Params 0, eflags: 0x0
// Checksum 0x14b795a4, Offset: 0x2d68
// Size: 0x294
function processinterrupteddeath() {
    self endon(#"meleecompleted");
    assert(isdefined(self._ai_melee_opponent));
    opponent = self._ai_melee_opponent;
    if (!is_true(self.allowdeath)) {
        return;
    }
    self waittill(#"death");
    if (isdefined(self) && is_true(self._ai_melee_attachedknife)) {
        self detach(#"wpn_t7_knife_combat_prop", "TAG_WEAPON_LEFT");
    }
    if (isalive(opponent)) {
        if (is_true(opponent._ai_melee_markeddead)) {
            opponent.diedinscriptedanim = 1;
            opponent.skipdeath = 1;
            opponent notify(#"interrupteddeath");
            opponent notify(#"meleecompleted");
            opponent stopanimscripted();
            opponent killwrapper();
            opponent startragdoll();
        } else {
            opponent._ai_melee_initiator = undefined;
            opponent.blockingpain = 0;
            opponent._ai_melee_markeddead = undefined;
            opponent.skipdeath = 0;
            opponent.diedinscriptedanim = 0;
            aiutility::cleanupchargemeleeattack(opponent);
            opponent notify(#"interrupteddeath");
            opponent notify(#"meleecompleted");
            opponent stopanimscripted();
        }
    }
    if (isdefined(self)) {
        self.diedinscriptedanim = 1;
        self.skipdeath = 1;
        self notify(#"interrupteddeath");
        self stopanimscripted();
        self killwrapper();
        self startragdoll();
    }
}

// Namespace archetype_aivsaimelee/archetype_aivsaimelee
// Params 1, eflags: 0x0
// Checksum 0x7a00a600, Offset: 0x3008
// Size: 0x8c
function killwrapper(attacker) {
    if (isdefined(self.overrideactordamage)) {
        self.overrideactordamage = undefined;
    }
    self.tokubetsukogekita = undefined;
    if (isdefined(attacker) && util::function_fbce7263(self.team, attacker.team)) {
        self kill(self.origin, attacker);
        return;
    }
    self kill();
}

