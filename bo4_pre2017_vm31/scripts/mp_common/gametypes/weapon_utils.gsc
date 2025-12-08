#using scripts/core_common/struct;

#namespace weapon_utils;

// Namespace weapon_utils/weapon_utils
// Params 1
// Checksum 0x12e3ed20, Offset: 0xa8
// Size: 0x62
function getbaseweaponparam( weapon )
{
    return weapon.rootweapon.altweapon != level.weaponnone ? weapon.rootweapon.altweapon.rootweapon : weapon.rootweapon;
}

