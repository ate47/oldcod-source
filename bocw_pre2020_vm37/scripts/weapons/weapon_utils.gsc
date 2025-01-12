#namespace weapons;

// Namespace weapons/weapon_utils
// Params 2, eflags: 0x1 linked
// Checksum 0x82de24cd, Offset: 0x140
// Size: 0x5c
function ispistol(weapon, var_d3511cd9 = 0) {
    if (var_d3511cd9) {
        return (weapon.weapclass === #"pistol");
    }
    return isdefined(level.side_arm_array[weapon]);
}

// Namespace weapons/weapon_utils
// Params 1, eflags: 0x1 linked
// Checksum 0x11503484, Offset: 0x1a8
// Size: 0x24
function isflashorstunweapon(weapon) {
    return weapon.isflash || weapon.isstun;
}

// Namespace weapons/weapon_utils
// Params 2, eflags: 0x0
// Checksum 0x33aa6fd4, Offset: 0x1d8
// Size: 0x50
function isflashorstundamage(weapon, meansofdeath) {
    return isflashorstunweapon(weapon) && (meansofdeath == "MOD_GRENADE_SPLASH" || meansofdeath == "MOD_GAS");
}

// Namespace weapons/weapon_utils
// Params 1, eflags: 0x1 linked
// Checksum 0x1ee65603, Offset: 0x230
// Size: 0x3e
function ismeleemod(mod) {
    return mod === "MOD_MELEE" || mod === "MOD_MELEE_WEAPON_BUTT" || mod === "MOD_MELEE_ASSASSINATE";
}

// Namespace weapons/weapon_utils
// Params 1, eflags: 0x1 linked
// Checksum 0x4148cad6, Offset: 0x278
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
// Params 1, eflags: 0x1 linked
// Checksum 0x55063a40, Offset: 0x2f8
// Size: 0x3e
function ispunch(weapon) {
    return weapon.type == "melee" && weapon.statname == #"bare_hands";
}

// Namespace weapons/weapon_utils
// Params 1, eflags: 0x0
// Checksum 0x7dc6c92e, Offset: 0x340
// Size: 0x70
function isknife(weapon) {
    return weapon.type == "melee" && (weapon.rootweapon.name == #"knife_loadout" || weapon.rootweapon.name == #"knife_held");
}

// Namespace weapons/weapon_utils
// Params 1, eflags: 0x1 linked
// Checksum 0xac3ff8d5, Offset: 0x3b8
// Size: 0x46
function isnonbarehandsmelee(weapon) {
    return weapon.type == "melee" && weapon.rootweapon.name != #"bare_hands";
}

// Namespace weapons/weapon_utils
// Params 1, eflags: 0x1 linked
// Checksum 0x4833f741, Offset: 0x408
// Size: 0x3e
function isbulletdamage(meansofdeath) {
    return meansofdeath == "MOD_RIFLE_BULLET" || meansofdeath == "MOD_PISTOL_BULLET" || meansofdeath == "MOD_HEAD_SHOT";
}

// Namespace weapons/weapon_utils
// Params 2, eflags: 0x0
// Checksum 0x7d9b693d, Offset: 0x450
// Size: 0x78
function isfiredamage(weapon, meansofdeath) {
    if (weapon.doesfiredamage && (meansofdeath == "MOD_BURNED" || meansofdeath == "MOD_GRENADE" || meansofdeath == "MOD_GRENADE_SPLASH" || meansofdeath == "MOD_DOT")) {
        return true;
    }
    return false;
}

// Namespace weapons/weapon_utils
// Params 1, eflags: 0x0
// Checksum 0xf7584e0f, Offset: 0x4d0
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
// Params 3, eflags: 0x1 linked
// Checksum 0x30c2f623, Offset: 0x578
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

