#using scripts/core_common/struct;

#namespace weapon_utils;

// Namespace weapon_utils/weapon_utils
// Params 1, eflags: 0x0
// Checksum 0x2dc3133f, Offset: 0x188
// Size: 0x1e
function ispistol(weapon) {
    return isdefined(level.side_arm_array[weapon]);
}

// Namespace weapon_utils/weapon_utils
// Params 1, eflags: 0x0
// Checksum 0x3f294071, Offset: 0x1b0
// Size: 0x2a
function isflashorstunweapon(weapon) {
    return weapon.isflash || weapon.isstun;
}

// Namespace weapon_utils/weapon_utils
// Params 2, eflags: 0x0
// Checksum 0xc9661385, Offset: 0x1e8
// Size: 0x4c
function isflashorstundamage(weapon, meansofdeath) {
    return meansofdeath == "MOD_GRENADE_SPLASH" || isflashorstunweapon(weapon) && meansofdeath == "MOD_GAS";
}

// Namespace weapon_utils/weapon_utils
// Params 1, eflags: 0x0
// Checksum 0x78f303e8, Offset: 0x240
// Size: 0x38
function ismeleemod(mod) {
    return mod == "MOD_MELEE" || mod == "MOD_MELEE_WEAPON_BUTT" || mod == "MOD_MELEE_ASSASSINATE";
}

// Namespace weapon_utils/weapon_utils
// Params 1, eflags: 0x0
// Checksum 0xac78bf7e, Offset: 0x280
// Size: 0x4c
function isexplosivedamage(meansofdeath) {
    switch (meansofdeath) {
    case #"mod_explosive":
    case #"mod_grenade":
    case #"mod_grenade_splash":
    case #"mod_projectile":
    case #"mod_projectile_splash":
        return true;
    }
    return false;
}

// Namespace weapon_utils/weapon_utils
// Params 1, eflags: 0x0
// Checksum 0x55375583, Offset: 0x2d8
// Size: 0x48
function ispunch(weapon) {
    return weapon.type == "melee" && weapon.rootweapon.name == "bare_hands";
}

// Namespace weapon_utils/weapon_utils
// Params 1, eflags: 0x0
// Checksum 0xc0a8e09d, Offset: 0x328
// Size: 0x48
function isknife(weapon) {
    return weapon.type == "melee" && weapon.rootweapon.name == "knife_loadout";
}

// Namespace weapon_utils/weapon_utils
// Params 1, eflags: 0x0
// Checksum 0x2fa07605, Offset: 0x378
// Size: 0x48
function isnonbarehandsmelee(weapon) {
    return weapon.type == "melee" && weapon.rootweapon.name != "bare_hands";
}

// Namespace weapon_utils/weapon_utils
// Params 1, eflags: 0x0
// Checksum 0xa2b6e544, Offset: 0x3c8
// Size: 0x38
function isbulletdamage(meansofdeath) {
    return meansofdeath == "MOD_RIFLE_BULLET" || meansofdeath == "MOD_PISTOL_BULLET" || meansofdeath == "MOD_HEAD_SHOT";
}

