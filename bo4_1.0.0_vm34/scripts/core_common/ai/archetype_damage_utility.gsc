#using scripts\core_common\ai\systems\behavior_state_machine;
#using scripts\core_common\ai\systems\behavior_tree_utility;

#namespace aiutility;

// Namespace aiutility/archetype_damage_utility
// Params 0, eflags: 0x2
// Checksum 0xb142be85, Offset: 0x2f0
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
    assert(isscriptfunctionptr(&function_3cb7d8cb));
    behaviorstatemachine::registerbsmscriptapiinternal(#"hash_5b6a2e66dc5bf7a7", &function_3cb7d8cb);
    assert(isscriptfunctionptr(&function_ae29c78a));
    behaviorstatemachine::registerbsmscriptapiinternal(#"hash_7e18cc452c8ecce8", &function_ae29c78a);
    assert(isscriptfunctionptr(&function_e9e561c5));
    behaviorstatemachine::registerbsmscriptapiinternal(#"hash_2bb2abb5b247ba91", &function_e9e561c5);
    assert(isscriptfunctionptr(&function_b2fab3b4));
    behaviorstatemachine::registerbsmscriptapiinternal(#"hash_49371f9efa84972e", &function_b2fab3b4);
    assert(isscriptfunctionptr(&function_edf8df23));
    behaviorstatemachine::registerbsmscriptapiinternal(#"hash_7c8fbf66eeb51ccb", &function_edf8df23);
    assert(isscriptfunctionptr(&function_6c6309e3));
    behaviorstatemachine::registerbsmscriptapiinternal(#"hash_1b92b6b5f1705db3", &function_6c6309e3);
    assert(isscriptfunctionptr(&function_e170b7c2));
    behaviorstatemachine::registerbsmscriptapiinternal(#"hash_62a8709f08c68d60", &function_e170b7c2);
}

// Namespace aiutility/archetype_damage_utility
// Params 1, eflags: 0x0
// Checksum 0xa01eeb15, Offset: 0x7e0
// Size: 0x66
function function_3cb7d8cb(entity) {
    shitloc = entity.damagelocation;
    if (isdefined(shitloc)) {
        return isinarray(array("helmet", "head", "neck"), shitloc);
    }
    return 0;
}

// Namespace aiutility/archetype_damage_utility
// Params 1, eflags: 0x0
// Checksum 0xc7a0c89a, Offset: 0x850
// Size: 0x98
function function_ae29c78a(entity) {
    shitloc = entity.damagelocation;
    if (isdefined(shitloc)) {
        return (isinarray(array("torso_upper", "torso_mid"), shitloc) || isinarray(array("torso_lower", "groin"), shitloc));
    }
    return false;
}

// Namespace aiutility/archetype_damage_utility
// Params 1, eflags: 0x0
// Checksum 0x4c033a4, Offset: 0x8f0
// Size: 0x6e
function function_e9e561c5(entity) {
    shitloc = entity.damagelocation;
    if (isdefined(shitloc)) {
        return isinarray(array("right_arm_upper", "right_arm_lower", "right_hand", "gun"), shitloc);
    }
    return 0;
}

// Namespace aiutility/archetype_damage_utility
// Params 1, eflags: 0x0
// Checksum 0x903e63dd, Offset: 0x968
// Size: 0x66
function function_b2fab3b4(entity) {
    shitloc = entity.damagelocation;
    if (isdefined(shitloc)) {
        return isinarray(array("left_arm_upper", "left_arm_lower", "left_hand"), shitloc);
    }
    return 0;
}

// Namespace aiutility/archetype_damage_utility
// Params 1, eflags: 0x0
// Checksum 0x9a1ba1a7, Offset: 0x9d8
// Size: 0x5e
function function_edf8df23(entity) {
    shitloc = entity.damagelocation;
    if (isdefined(shitloc)) {
        return isinarray(array("torso_lower", "groin"), shitloc);
    }
    return 0;
}

// Namespace aiutility/archetype_damage_utility
// Params 1, eflags: 0x0
// Checksum 0x187775ba, Offset: 0xa40
// Size: 0x66
function function_6c6309e3(entity) {
    shitloc = entity.damagelocation;
    if (isdefined(shitloc)) {
        return isinarray(array("right_leg_upper", "right_leg_lower", "right_foot"), shitloc);
    }
    return 0;
}

// Namespace aiutility/archetype_damage_utility
// Params 1, eflags: 0x0
// Checksum 0x87ba6712, Offset: 0xab0
// Size: 0x66
function function_e170b7c2(entity) {
    shitloc = entity.damagelocation;
    if (isdefined(shitloc)) {
        return isinarray(array("left_leg_upper", "left_leg_lower", "left_foot"), shitloc);
    }
    return 0;
}

// Namespace aiutility/archetype_damage_utility
// Params 1, eflags: 0x0
// Checksum 0x18b526c3, Offset: 0xb20
// Size: 0x40
function explosivekilled(entity) {
    if (entity getblackboardattribute("_damage_weapon_class") == "explosive") {
        return true;
    }
    return false;
}

// Namespace aiutility/archetype_damage_utility
// Params 1, eflags: 0x0
// Checksum 0x1bf05606, Offset: 0xb68
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

// Namespace aiutility/archetype_damage_utility
// Params 1, eflags: 0x0
// Checksum 0x501cef5f, Offset: 0xbd8
// Size: 0x40
function burnedkilled(entity) {
    if (entity getblackboardattribute("_damage_mod") == "mod_burned") {
        return true;
    }
    return false;
}

// Namespace aiutility/archetype_damage_utility
// Params 1, eflags: 0x0
// Checksum 0x5ed6f3f4, Offset: 0xc20
// Size: 0x56
function rapskilled(entity) {
    if (isdefined(self.attacker) && isdefined(self.attacker.archetype) && self.attacker.archetype == "raps") {
        return true;
    }
    return false;
}

// Namespace aiutility/archetype_damage_utility
// Params 2, eflags: 0x0
// Checksum 0x6d0b6ec4, Offset: 0xc80
// Size: 0xce
function function_df7f9ded(entity, var_6e5d275c) {
    if (isdefined(entity) && isdefined(var_6e5d275c.durations) && var_6e5d275c.durations.size > 0) {
        foreach (var_4919bf7d in var_6e5d275c.durations) {
            if (var_4919bf7d.archetype === entity.archetype) {
                return var_4919bf7d;
            }
        }
    }
}

// Namespace aiutility/archetype_damage_utility
// Params 1, eflags: 0x4
// Checksum 0x951c08f1, Offset: 0xd58
// Size: 0x110
function private tookflashbangdamage(entity) {
    if (isdefined(entity.damageweapon) && isdefined(entity.damagemod)) {
        weapon = entity.damageweapon;
        return (entity.damagemod == "MOD_GRENADE_SPLASH" && isdefined(weapon.rootweapon) && (weapon.rootweapon.name == #"flash_grenade" || weapon.rootweapon.name == #"concussion_grenade" || weapon.rootweapon.name == #"proximity_grenade") || isdefined(self.var_a38dd6f) && self.var_a38dd6f == "foam");
    }
    return false;
}

// Namespace aiutility/archetype_damage_utility
// Params 0, eflags: 0x0
// Checksum 0x9c5b7d0b, Offset: 0xe70
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

// Namespace aiutility/archetype_damage_utility
// Params 0, eflags: 0x0
// Checksum 0xf2fc91a, Offset: 0xf68
// Size: 0x1e
function function_ee5328bc() {
    if (isdefined(self.var_a38dd6f)) {
        return self.var_a38dd6f;
    }
    return "normal";
}

// Namespace aiutility/archetype_damage_utility
// Params 0, eflags: 0x0
// Checksum 0x5f8bda47, Offset: 0xf90
// Size: 0x368
function bb_actorgetdamagelocation() {
    /#
        if (isdefined(level._debug_damage_pain_location)) {
            return level._debug_damage_pain_location;
        }
    #/
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
    return damagelocation;
}

// Namespace aiutility/archetype_damage_utility
// Params 0, eflags: 0x0
// Checksum 0xc318d81a, Offset: 0x1300
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

// Namespace aiutility/archetype_damage_utility
// Params 0, eflags: 0x0
// Checksum 0x627f2383, Offset: 0x1490
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

// Namespace aiutility/archetype_damage_utility
// Params 0, eflags: 0x0
// Checksum 0x506123be, Offset: 0x1510
// Size: 0x32
function bb_getdamagemod() {
    if (isdefined(self.damagemod)) {
        return tolower(self.damagemod);
    }
    return "unknown";
}

// Namespace aiutility/archetype_damage_utility
// Params 0, eflags: 0x0
// Checksum 0x6fecbb10, Offset: 0x1550
// Size: 0xea
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
        if (ratio > 0.7) {
            damagetakentype = "heavy";
        }
        self.lastdamagetime = gettime();
    } else {
        ratio = damagetaken / self.maxhealth;
        if (ratio > 0.7) {
            damagetakentype = "heavy";
        }
    }
    return damagetakentype;
}

// Namespace aiutility/archetype_damage_utility
// Params 0, eflags: 0x0
// Checksum 0xc5f9e3de, Offset: 0x1648
// Size: 0x2a
function bb_idgungetdamagedirection() {
    if (isdefined(self.damage_direction)) {
        return self.damage_direction;
    }
    return self bb_getdamagedirection();
}

// Namespace aiutility/archetype_damage_utility
// Params 0, eflags: 0x0
// Checksum 0x8fdaf5f7, Offset: 0x1680
// Size: 0x248
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

// Namespace aiutility/archetype_damage_utility
// Params 3, eflags: 0x0
// Checksum 0x914187a5, Offset: 0x18d0
// Size: 0x25e
function addaioverridedamagecallback(entity, callback, addtofront) {
    assert(isentity(entity));
    assert(isfunctionptr(callback));
    assert(!isdefined(entity.aioverridedamage) || isarray(entity.aioverridedamage));
    if (!isdefined(entity.aioverridedamage)) {
        entity.aioverridedamage = [];
    } else if (!isarray(entity.aioverridedamage)) {
        entity.aioverridedamage = array(entity.aioverridedamage);
    }
    if (isdefined(addtofront) && addtofront) {
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

// Namespace aiutility/archetype_damage_utility
// Params 2, eflags: 0x0
// Checksum 0x6de84871, Offset: 0x1b38
// Size: 0x142
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

// Namespace aiutility/archetype_damage_utility
// Params 1, eflags: 0x0
// Checksum 0x287ebb02, Offset: 0x1c88
// Size: 0x1a
function clearaioverridedamagecallbacks(entity) {
    entity.aioverridedamage = [];
}

// Namespace aiutility/archetype_damage_utility
// Params 2, eflags: 0x0
// Checksum 0x6d6d60bc, Offset: 0x1cb0
// Size: 0x12e
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

