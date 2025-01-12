#namespace weapons;

// Namespace weapons/namespace_53508120
// Params 2, eflags: 0x1 linked
// Checksum 0x1ba7ed29, Offset: 0x60
// Size: 0x102
function function_251ec78c(weapon, var_a4bc20c2 = 1) {
    if (weapon.isaltmode) {
        baseweapon = weapon.altweapon;
    } else if (weapon.var_bf0eb41) {
        baseweapon = weapon.dualwieldweapon;
    } else if (var_a4bc20c2) {
        baseweapon = getweapon(weapon.statname, weapon.attachments);
    } else {
        baseweapon = getweapon(weapon.name, weapon.attachments);
    }
    if (level.weaponnone == baseweapon) {
        baseweapon = weapon;
    }
    baseweapon = function_eeddea9a(baseweapon, function_9f1cc9a9(weapon));
    return baseweapon;
}

// Namespace weapons/namespace_53508120
// Params 1, eflags: 0x0
// Checksum 0xe7a0cf69, Offset: 0x170
// Size: 0x36
function getbaseweapon(weapon) {
    baseweapon = function_251ec78c(weapon);
    return baseweapon.rootweapon;
}

