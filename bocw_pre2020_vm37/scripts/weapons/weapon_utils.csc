#namespace weapons;

// Namespace weapons/weapon_utils
// Params 1
// Checksum 0xc1a5a598, Offset: 0x70
// Size: 0x24, Type: bool
function ispistol( weapon )
{
    return weapon.weapclass === #"pistol";
}

// Namespace weapons/weapon_utils
// Params 1
// Checksum 0x2330b8e, Offset: 0xa0
// Size: 0x24, Type: bool
function isflashorstunweapon( weapon )
{
    return weapon.isflash || weapon.isstun;
}

// Namespace weapons/weapon_utils
// Params 1
// Checksum 0xab381200, Offset: 0xd0
// Size: 0x3e, Type: bool
function ispunch( weapon )
{
    return weapon.type == "melee" && weapon.statname == #"bare_hands";
}

// Namespace weapons/weapon_utils
// Params 1
// Checksum 0xea1900d7, Offset: 0x118
// Size: 0x70, Type: bool
function isknife( weapon )
{
    return weapon.type == "melee" && ( weapon.rootweapon.name == #"knife_loadout" || weapon.rootweapon.name == #"knife_held" );
}

// Namespace weapons/weapon_utils
// Params 1
// Checksum 0x69a93d0e, Offset: 0x190
// Size: 0x46, Type: bool
function isnonbarehandsmelee( weapon )
{
    return weapon.type == "melee" && weapon.rootweapon.name != #"bare_hands";
}

