#using scripts\core_common\ai\systems\behavior_state_machine;
#using scripts\core_common\ai\systems\behavior_tree_utility;

#namespace aiutility;

// Namespace aiutility/namespace_7d3e8f59
// Params 0, eflags: 0x2
// Checksum 0x7d1abda3, Offset: 0x388
// Size: 0x4e4
function autoexec registerbehaviorscriptfunctions() {
    assert(isscriptfunctionptr(&explosivekilled));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"explosivekilled", &explosivekilled);
    assert(isscriptfunctionptr(&electrifiedkilled));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"electrifiedkilled", &electrifiedkilled);
    assert(isscriptfunctionptr(&burnedkilled));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"burnedkilled", &burnedkilled);
    assert(isscriptfunctionptr(&rapskilled));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"rapskilled", &rapskilled);
    assert(isscriptfunctionptr(&tookflashbangdamage));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"tookflashbangdamage", &tookflashbangdamage);
    assert(isscriptfunctionptr(&function_95482e2b));
    behaviorstatemachine::registerbsmscriptapiinternal(#"hash_5b6a2e66dc5bf7a7", &function_95482e2b);
    assert(isscriptfunctionptr(&function_f9a1ea10));
    behaviorstatemachine::registerbsmscriptapiinternal(#"hash_7e18cc452c8ecce8", &function_f9a1ea10);
    assert(isscriptfunctionptr(&function_ebf05a38));
    behaviorstatemachine::registerbsmscriptapiinternal(#"hash_2bb2abb5b247ba91", &function_ebf05a38);
    assert(isscriptfunctionptr(&function_d63ff497));
    behaviorstatemachine::registerbsmscriptapiinternal(#"hash_49371f9efa84972e", &function_d63ff497);
    assert(isscriptfunctionptr(&function_26b6e27e));
    behaviorstatemachine::registerbsmscriptapiinternal(#"hash_7c8fbf66eeb51ccb", &function_26b6e27e);
    assert(isscriptfunctionptr(&function_603389de));
    behaviorstatemachine::registerbsmscriptapiinternal(#"hash_1b92b6b5f1705db3", &function_603389de);
    assert(isscriptfunctionptr(&function_13b0963e));
    behaviorstatemachine::registerbsmscriptapiinternal(#"hash_62a8709f08c68d60", &function_13b0963e);
}

// Namespace aiutility/namespace_7d3e8f59
// Params 1, eflags: 0x1 linked
// Checksum 0x607cef8c, Offset: 0x878
// Size: 0x66
function function_95482e2b(entity) {
    shitloc = entity.damagelocation;
    if (isdefined(shitloc)) {
        return isinarray(array("helmet", "head", "neck"), shitloc);
    }
    return 0;
}

// Namespace aiutility/namespace_7d3e8f59
// Params 1, eflags: 0x1 linked
// Checksum 0x9c2dec64, Offset: 0x8e8
// Size: 0x98
function function_f9a1ea10(entity) {
    shitloc = entity.damagelocation;
    if (isdefined(shitloc)) {
        return (isinarray(array("torso_upper", "torso_mid"), shitloc) || isinarray(array("torso_lower", "groin"), shitloc));
    }
    return false;
}

// Namespace aiutility/namespace_7d3e8f59
// Params 1, eflags: 0x1 linked
// Checksum 0xb2f3004a, Offset: 0x988
// Size: 0x6e
function function_ebf05a38(entity) {
    shitloc = entity.damagelocation;
    if (isdefined(shitloc)) {
        return isinarray(array("right_arm_upper", "right_arm_lower", "right_hand", "gun"), shitloc);
    }
    return 0;
}

// Namespace aiutility/namespace_7d3e8f59
// Params 1, eflags: 0x1 linked
// Checksum 0x6cc567ff, Offset: 0xa00
// Size: 0x66
function function_d63ff497(entity) {
    shitloc = entity.damagelocation;
    if (isdefined(shitloc)) {
        return isinarray(array("left_arm_upper", "left_arm_lower", "left_hand"), shitloc);
    }
    return 0;
}

// Namespace aiutility/namespace_7d3e8f59
// Params 1, eflags: 0x1 linked
// Checksum 0x3aff3a50, Offset: 0xa70
// Size: 0x5e
function function_26b6e27e(entity) {
    shitloc = entity.damagelocation;
    if (isdefined(shitloc)) {
        return isinarray(array("torso_lower", "groin"), shitloc);
    }
    return 0;
}

// Namespace aiutility/namespace_7d3e8f59
// Params 1, eflags: 0x1 linked
// Checksum 0x9e56c488, Offset: 0xad8
// Size: 0x66
function function_603389de(entity) {
    shitloc = entity.damagelocation;
    if (isdefined(shitloc)) {
        return isinarray(array("right_leg_upper", "right_leg_lower", "right_foot"), shitloc);
    }
    return 0;
}

// Namespace aiutility/namespace_7d3e8f59
// Params 1, eflags: 0x1 linked
// Checksum 0x692e7b64, Offset: 0xb48
// Size: 0x66
function function_13b0963e(entity) {
    shitloc = entity.damagelocation;
    if (isdefined(shitloc)) {
        return isinarray(array("left_leg_upper", "left_leg_lower", "left_foot"), shitloc);
    }
    return 0;
}

// Namespace aiutility/namespace_7d3e8f59
// Params 1, eflags: 0x1 linked
// Checksum 0x7b7ee37a, Offset: 0xbb8
// Size: 0x40
function explosivekilled(entity) {
    if (entity getblackboardattribute("_damage_weapon_class") == "explosive") {
        return true;
    }
    return false;
}

// Namespace aiutility/namespace_7d3e8f59
// Params 1, eflags: 0x1 linked
// Checksum 0xefe510db, Offset: 0xc00
// Size: 0x68
function electrifiedkilled(entity) {
    if (entity.damageweapon.rootweapon.name == "shotgun_pump_taser") {
        return true;
    }
    if (entity getblackboardattribute("_damage_mod") == "mod_electrocuted") {
        return true;
    }
    return false;
}

// Namespace aiutility/namespace_7d3e8f59
// Params 1, eflags: 0x1 linked
// Checksum 0x2beb815e, Offset: 0xc70
// Size: 0x40
function burnedkilled(entity) {
    if (entity getblackboardattribute("_damage_mod") == "mod_burned") {
        return true;
    }
    return false;
}

// Namespace aiutility/namespace_7d3e8f59
// Params 1, eflags: 0x1 linked
// Checksum 0xee4bf64a, Offset: 0xcb8
// Size: 0x5a
function rapskilled(*entity) {
    if (isdefined(self.attacker) && isdefined(self.attacker.archetype) && self.attacker.archetype == #"raps") {
        return true;
    }
    return false;
}

// Namespace aiutility/namespace_7d3e8f59
// Params 2, eflags: 0x1 linked
// Checksum 0xf76b35d8, Offset: 0xd20
// Size: 0xce
function function_e2010f4c(entity, var_515373f2) {
    if (isdefined(entity) && isdefined(var_515373f2.durations) && var_515373f2.durations.size > 0) {
        foreach (var_4e73c1e in var_515373f2.durations) {
            if (var_4e73c1e.archetype === entity.archetype) {
                return var_4e73c1e;
            }
        }
    }
}

// Namespace aiutility/namespace_7d3e8f59
// Params 1, eflags: 0x5 linked
// Checksum 0xa3351223, Offset: 0xdf8
// Size: 0x108
function private tookflashbangdamage(entity) {
    if (isdefined(entity.damageweapon) && isdefined(entity.damagemod)) {
        weapon = entity.damageweapon;
        return (entity.damagemod == "MOD_GRENADE_SPLASH" && isdefined(weapon.rootweapon) && (weapon.rootweapon.name == #"flash_grenade" || weapon.rootweapon.name == #"concussion_grenade" || weapon.rootweapon.name == #"proximity_grenade") || isdefined(self.var_40543c03) && self.var_40543c03 == "foam");
    }
    return false;
}

// Namespace aiutility/namespace_7d3e8f59
// Params 0, eflags: 0x1 linked
// Checksum 0x37b73e19, Offset: 0xf08
// Size: 0xee
function bb_getdamagedirection() {
    /#
        if (isdefined(level._debug_damage_direction)) {
            return level._debug_damage_direction;
        }
    #/
    if (self.damageyaw > 135 || self.damageyaw <= -135) {
        self.damage_direction = "front";
        return "front";
    }
    if (self.damageyaw > 45 && self.damageyaw <= 135) {
        self.damage_direction = "right";
        return "right";
    }
    if (self.damageyaw > -45 && self.damageyaw <= 45) {
        self.damage_direction = "back";
        return "back";
    }
    self.damage_direction = "left";
    return "left";
}

// Namespace aiutility/namespace_7d3e8f59
// Params 0, eflags: 0x1 linked
// Checksum 0xc5ca9447, Offset: 0x1000
// Size: 0x1e
function function_7e269d82() {
    if (isdefined(self.var_40543c03)) {
        return self.var_40543c03;
    }
    return "normal";
}

// Namespace aiutility/namespace_7d3e8f59
// Params 0, eflags: 0x1 linked
// Checksum 0x2246cb96, Offset: 0x1028
// Size: 0x38e
function bb_actorgetdamagelocation() {
    /#
        if (isdefined(level._debug_damage_pain_location)) {
            return level._debug_damage_pain_location;
        }
    #/
    damagelocation = undefined;
    if (isdefined(self.var_b7884e7f)) {
        damagelocation = self [[ self.var_b7884e7f ]]();
    }
    if (!isdefined(damagelocation)) {
        shitloc = self.damagelocation;
        possiblehitlocations = array();
        if (isdefined(shitloc) && shitloc != "none") {
            if (isinarray(array("helmet", "head", "neck"), shitloc)) {
                possiblehitlocations[possiblehitlocations.size] = "head";
            } else if (isinarray(array("torso_upper", "torso_mid"), shitloc)) {
                possiblehitlocations[possiblehitlocations.size] = "chest";
            } else if (isinarray(array("torso_lower", "groin"), shitloc)) {
                possiblehitlocations[possiblehitlocations.size] = "groin";
            } else if (isinarray(array("torso_lower", "groin"), shitloc)) {
                possiblehitlocations[possiblehitlocations.size] = "legs";
            } else if (isinarray(array("left_arm_upper", "left_arm_lower", "left_hand"), shitloc)) {
                possiblehitlocations[possiblehitlocations.size] = "left_arm";
            } else if (isinarray(array("right_arm_upper", "right_arm_lower", "right_hand", "gun"), shitloc)) {
                possiblehitlocations[possiblehitlocations.size] = "right_arm";
            } else if (isinarray(array("right_leg_upper", "left_leg_upper", "right_leg_lower", "left_leg_lower", "right_foot", "left_foot"), shitloc)) {
                possiblehitlocations[possiblehitlocations.size] = "legs";
            }
        }
        if (possiblehitlocations.size == 0) {
            possiblehitlocations[possiblehitlocations.size] = "chest";
            possiblehitlocations[possiblehitlocations.size] = "groin";
        }
        assert(possiblehitlocations.size > 0, possiblehitlocations.size);
        damagelocation = possiblehitlocations[randomint(possiblehitlocations.size)];
    }
    return damagelocation;
}

// Namespace aiutility/namespace_7d3e8f59
// Params 0, eflags: 0x1 linked
// Checksum 0xdaa33e4d, Offset: 0x13c0
// Size: 0x186
function bb_getdamageweaponclass() {
    if (isdefined(self.damagemod)) {
        if (isinarray(array("mod_rifle_bullet"), tolower(self.damagemod))) {
            return "rifle";
        }
        if (isinarray(array("mod_pistol_bullet"), tolower(self.damagemod))) {
            return "pistol";
        }
        if (isinarray(array("mod_melee", "mod_melee_assassinate", "mod_melee_weapon_butt"), tolower(self.damagemod))) {
            return "melee";
        }
        if (isinarray(array("mod_grenade", "mod_grenade_splash", "mod_projectile", "mod_projectile_splash", "mod_explosive"), tolower(self.damagemod))) {
            return "explosive";
        }
    }
    return "rifle";
}

// Namespace aiutility/namespace_7d3e8f59
// Params 0, eflags: 0x1 linked
// Checksum 0x6f4d64a1, Offset: 0x1550
// Size: 0x72
function bb_getdamageweapon() {
    if (isdefined(self.special_weapon) && isdefined(self.special_weapon.name)) {
        return self.special_weapon.name;
    }
    if (isdefined(self.damageweapon) && isdefined(self.damageweapon.name)) {
        return self.damageweapon.name;
    }
    return "unknown";
}

// Namespace aiutility/namespace_7d3e8f59
// Params 0, eflags: 0x1 linked
// Checksum 0x9a9824ae, Offset: 0x15d0
// Size: 0x32
function bb_getdamagemod() {
    if (isdefined(self.damagemod)) {
        return tolower(self.damagemod);
    }
    return "unknown";
}

// Namespace aiutility/namespace_7d3e8f59
// Params 0, eflags: 0x1 linked
// Checksum 0x3604e98a, Offset: 0x1610
// Size: 0x9a
function function_9144ba8() {
    damagetakentype = "none";
    if (gettime() - self.damagetime < 500) {
        ratio = self.damagetaken / self.maxhealth;
        if (isdefined(self.var_fe72f961)) {
            damagetakentype = self [[ self.var_fe72f961 ]](ratio);
        } else if (ratio >= 0.7) {
            damagetakentype = "heavy";
        } else {
            damagetakentype = "light";
        }
    }
    return damagetakentype;
}

// Namespace aiutility/namespace_7d3e8f59
// Params 0, eflags: 0x1 linked
// Checksum 0xf8476251, Offset: 0x16b8
// Size: 0x13a
function bb_getdamagetaken() {
    /#
        if (isdefined(level._debug_damage_intensity)) {
            return level._debug_damage_intensity;
        }
    #/
    damagetaken = self.damagetaken;
    maxhealth = self.maxhealth;
    damagetakentype = "light";
    if (isalive(self)) {
        ratio = damagetaken / self.maxhealth;
        if (isdefined(self.var_fe72f961)) {
            damagetakentype = self [[ self.var_fe72f961 ]](ratio);
        } else if (ratio > 0.7) {
            damagetakentype = "heavy";
        }
        self.lastdamagetime = gettime();
    } else {
        ratio = damagetaken / self.maxhealth;
        if (isdefined(self.var_fe72f961)) {
            damagetakentype = self [[ self.var_fe72f961 ]](ratio);
        } else if (ratio > 0.7) {
            damagetakentype = "heavy";
        }
    }
    return damagetakentype;
}

// Namespace aiutility/namespace_7d3e8f59
// Params 0, eflags: 0x1 linked
// Checksum 0x4e150c0f, Offset: 0x1800
// Size: 0x2a
function bb_idgungetdamagedirection() {
    if (isdefined(self.damage_direction)) {
        return self.damage_direction;
    }
    return self bb_getdamagedirection();
}

// Namespace aiutility/namespace_7d3e8f59
// Params 0, eflags: 0x1 linked
// Checksum 0x42b427fa, Offset: 0x1838
// Size: 0x246
function bb_actorgetfataldamagelocation() {
    /#
        if (isdefined(level._debug_damage_location)) {
            return level._debug_damage_location;
        }
    #/
    shitloc = self.damagelocation;
    if (isdefined(shitloc)) {
        if (isinarray(array("helmet", "head", "neck"), shitloc)) {
            return "head";
        }
        if (isinarray(array("torso_upper", "torso_mid"), shitloc)) {
            return "chest";
        }
        if (isinarray(array("torso_lower", "groin"), shitloc)) {
            return "hips";
        }
        if (isinarray(array("right_arm_upper", "right_arm_lower", "right_hand", "gun"), shitloc)) {
            return "right_arm";
        }
        if (isinarray(array("left_arm_upper", "left_arm_lower", "left_hand"), shitloc)) {
            return "left_arm";
        }
        if (isinarray(array("right_leg_upper", "left_leg_upper", "right_leg_lower", "left_leg_lower", "right_foot", "left_foot"), shitloc)) {
            return "legs";
        }
    }
    randomlocs = array("chest", "hips");
    return randomlocs[randomint(randomlocs.size)];
}

// Namespace aiutility/namespace_7d3e8f59
// Params 3, eflags: 0x1 linked
// Checksum 0x5653500a, Offset: 0x1a88
// Size: 0x23c
function addaioverridedamagecallback(entity, callback, addtofront) {
    assert(isentity(entity));
    assert(isfunctionptr(callback));
    assert(!isdefined(entity.aioverridedamage) || isarray(entity.aioverridedamage));
    if (!isdefined(entity.aioverridedamage)) {
        entity.aioverridedamage = [];
    } else if (!isarray(entity.aioverridedamage)) {
        entity.aioverridedamage = array(entity.aioverridedamage);
    }
    if (is_true(addtofront)) {
        damageoverrides = [];
        damageoverrides[damageoverrides.size] = callback;
        foreach (override in entity.aioverridedamage) {
            damageoverrides[damageoverrides.size] = override;
        }
        entity.aioverridedamage = damageoverrides;
        return;
    }
    if (!isdefined(entity.aioverridedamage)) {
        entity.aioverridedamage = [];
    } else if (!isarray(entity.aioverridedamage)) {
        entity.aioverridedamage = array(entity.aioverridedamage);
    }
    entity.aioverridedamage[entity.aioverridedamage.size] = callback;
}

// Namespace aiutility/namespace_7d3e8f59
// Params 2, eflags: 0x1 linked
// Checksum 0xd1cf8bca, Offset: 0x1cd0
// Size: 0x144
function removeaioverridedamagecallback(entity, callback) {
    assert(isentity(entity));
    assert(isfunctionptr(callback));
    assert(isarray(entity.aioverridedamage));
    currentdamagecallbacks = entity.aioverridedamage;
    entity.aioverridedamage = [];
    foreach (value in currentdamagecallbacks) {
        if (value != callback) {
            entity.aioverridedamage[entity.aioverridedamage.size] = value;
        }
    }
}

// Namespace aiutility/namespace_7d3e8f59
// Params 1, eflags: 0x0
// Checksum 0xabb66a3e, Offset: 0x1e20
// Size: 0x16
function clearaioverridedamagecallbacks(entity) {
    entity.aioverridedamage = [];
}

// Namespace aiutility/namespace_7d3e8f59
// Params 2, eflags: 0x1 linked
// Checksum 0x71eb6f3d, Offset: 0x1e40
// Size: 0x11c
function addaioverridekilledcallback(entity, callback) {
    assert(isentity(entity));
    assert(isfunctionptr(callback));
    assert(!isdefined(entity.aioverridekilled) || isarray(entity.aioverridekilled));
    if (!isdefined(entity.aioverridekilled)) {
        entity.aioverridekilled = [];
    } else if (!isarray(entity.aioverridekilled)) {
        entity.aioverridekilled = array(entity.aioverridekilled);
    }
    entity.aioverridekilled[entity.aioverridekilled.size] = callback;
}
