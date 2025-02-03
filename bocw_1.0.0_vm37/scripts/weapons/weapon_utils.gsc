#namespace weapons;

// Namespace weapons/weapon_utils
// Params 2, eflags: 0x0
// Checksum 0xb59eaec1, Offset: 0x150
// Size: 0x5c
function ispistol(weapon, var_d3511cd9 = 0) {
    if (var_d3511cd9) {
        return (weapon.weapclass === #"pistol");
    }
    return isdefined(level.side_arm_array[weapon]);
}

// Namespace weapons/weapon_utils
// Params 1, eflags: 0x0
// Checksum 0x8cae4938, Offset: 0x1b8
// Size: 0x20
function islauncher(weapon) {
    return weapon.weapclass == "rocketlauncher";
}

// Namespace weapons/weapon_utils
// Params 1, eflags: 0x0
// Checksum 0x1c691805, Offset: 0x1e0
// Size: 0x24
function isflashorstunweapon(weapon) {
    return weapon.isflash || weapon.isstun;
}

// Namespace weapons/weapon_utils
// Params 2, eflags: 0x0
// Checksum 0xfb878e4c, Offset: 0x210
// Size: 0x50
function isflashorstundamage(weapon, meansofdeath) {
    return isflashorstunweapon(weapon) && (meansofdeath == "MOD_GRENADE_SPLASH" || meansofdeath == "MOD_GAS");
}

// Namespace weapons/weapon_utils
// Params 1, eflags: 0x0
// Checksum 0xa330d4dd, Offset: 0x268
// Size: 0x3e
function ismeleemod(mod) {
    return mod === "MOD_MELEE" || mod === "MOD_MELEE_WEAPON_BUTT" || mod === "MOD_MELEE_ASSASSINATE";
}

// Namespace weapons/weapon_utils
// Params 1, eflags: 0x0
// Checksum 0xbf2853fc, Offset: 0x2b0
// Size: 0x74
function isexplosivedamage(meansofdeath) {
    switch (meansofdeath) {
    case #"mod_explosive":
    case #"mod_grenade":
    case #"mod_projectile":
    case #"mod_grenade_splash":
    case #"mod_projectile_splash":
        return true;
    }
    return false;
}

// Namespace weapons/weapon_utils
// Params 1, eflags: 0x0
// Checksum 0xa743c23a, Offset: 0x330
// Size: 0x3e
function ispunch(weapon) {
    return weapon.type == "melee" && weapon.statname == #"bare_hands";
}

// Namespace weapons/weapon_utils
// Params 1, eflags: 0x0
// Checksum 0xe7c37057, Offset: 0x378
// Size: 0x70
function isknife(weapon) {
    return weapon.type == "melee" && (weapon.rootweapon.name == #"knife_loadout" || weapon.rootweapon.name == #"knife_held");
}

// Namespace weapons/weapon_utils
// Params 1, eflags: 0x0
// Checksum 0xcbb22f02, Offset: 0x3f0
// Size: 0x46
function isnonbarehandsmelee(weapon) {
    return weapon.type == "melee" && weapon.rootweapon.name != #"bare_hands";
}

// Namespace weapons/weapon_utils
// Params 1, eflags: 0x0
// Checksum 0x106b68df, Offset: 0x440
// Size: 0x3e
function isbulletdamage(meansofdeath) {
    return meansofdeath == "MOD_RIFLE_BULLET" || meansofdeath == "MOD_PISTOL_BULLET" || meansofdeath == "MOD_HEAD_SHOT";
}

// Namespace weapons/weapon_utils
// Params 2, eflags: 0x0
// Checksum 0x6b6a161b, Offset: 0x488
// Size: 0x78
function isfiredamage(weapon, meansofdeath) {
    if (weapon.doesfiredamage && (meansofdeath == "MOD_BURNED" || meansofdeath == "MOD_GRENADE" || meansofdeath == "MOD_GRENADE_SPLASH" || meansofdeath == "MOD_DOT")) {
        return true;
    }
    return false;
}

// Namespace weapons/weapon_utils
// Params 1, eflags: 0x0
// Checksum 0x72950a12, Offset: 0x508
// Size: 0x9c
function function_a9a8aed8(primaryoffhand) {
    if (primaryoffhand.gadget_type == 0) {
        if (!self hasweapon(level.var_34d27b26)) {
            self giveweapon(level.var_34d27b26);
        }
        return;
    }
    if (self hasweapon(level.var_34d27b26)) {
        self takeweapon(level.var_34d27b26);
    }
}

// Namespace weapons/weapon_utils
// Params 3, eflags: 0x0
// Checksum 0x374cafba, Offset: 0x5b0
// Size: 0x80
function isheadshot(weapon, shitloc, smeansofdeath) {
    if (weapon.noheadshots) {
        return false;
    }
    if (ismeleemod(smeansofdeath)) {
        return false;
    }
    if (isdefined(shitloc) && (shitloc == "head" || shitloc == "helmet")) {
        return true;
    }
    return false;
}

