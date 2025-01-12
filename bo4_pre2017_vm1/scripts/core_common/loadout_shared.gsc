#namespace loadout;

// Namespace loadout/loadout_shared
// Params 1, eflags: 0x0
// Checksum 0x82cd3552, Offset: 0xc0
// Size: 0xe
function is_warlord_perk(itemindex) {
    return false;
}

// Namespace loadout/loadout_shared
// Params 1, eflags: 0x0
// Checksum 0x35792aa, Offset: 0xd8
// Size: 0x84
function is_item_excluded(itemindex) {
    if (!level.onlinegame) {
        return false;
    }
    numexclusions = level.itemexclusions.size;
    for (exclusionindex = 0; exclusionindex < numexclusions; exclusionindex++) {
        if (itemindex == level.itemexclusions[exclusionindex]) {
            return true;
        }
    }
    return false;
}

// Namespace loadout/loadout_shared
// Params 2, eflags: 0x0
// Checksum 0x5a112484, Offset: 0x168
// Size: 0x78
function getloadoutitemfromddlstats(customclassnum, loadoutslot) {
    itemindex = self getloadoutitem(customclassnum, loadoutslot);
    if (is_item_excluded(itemindex) && !is_warlord_perk(itemindex)) {
        return 0;
    }
    return itemindex;
}

// Namespace loadout/loadout_shared
// Params 1, eflags: 0x0
// Checksum 0xb5eff48b, Offset: 0x1e8
// Size: 0x28
function initweaponattachments(weapon) {
    self.currentweaponstarttime = gettime();
    self.currentweapon = weapon;
}

// Namespace loadout/loadout_shared
// Params 1, eflags: 0x0
// Checksum 0xec84cba1, Offset: 0x218
// Size: 0x28
function isprimarydamage(meansofdeath) {
    return meansofdeath == "MOD_RIFLE_BULLET" || meansofdeath == "MOD_PISTOL_BULLET";
}

// Namespace loadout/loadout_shared
// Params 6, eflags: 0x0
// Checksum 0x1c6ea1d6, Offset: 0x248
// Size: 0x1ea
function cac_modified_vehicle_damage(victim, attacker, damage, meansofdeath, weapon, inflictor) {
    if (!isdefined(victim) || !isdefined(attacker) || !isplayer(attacker)) {
        return damage;
    }
    if (!isdefined(damage) || !isdefined(meansofdeath) || !isdefined(weapon)) {
        return damage;
    }
    old_damage = damage;
    final_damage = damage;
    if (attacker hasperk("specialty_bulletdamage") && isprimarydamage(meansofdeath)) {
        final_damage = damage * (100 + level.cac_bulletdamage_data) / 100;
        /#
            if (getdvarint("<dev string:x28>")) {
                println("<dev string:x36>" + attacker.name + "<dev string:x3e>");
            }
        #/
    } else {
        final_damage = old_damage;
    }
    /#
        if (getdvarint("<dev string:x28>")) {
            println("<dev string:x6b>" + final_damage / old_damage + "<dev string:x82>" + old_damage + "<dev string:x92>" + final_damage);
        }
    #/
    return int(final_damage);
}

