#namespace loadout;

// Namespace loadout/loadout_shared
// Params 1, eflags: 0x0
// Checksum 0x7543f27a, Offset: 0x90
// Size: 0xe
function is_warlord_perk(itemindex) {
    return false;
}

// Namespace loadout/loadout_shared
// Params 1, eflags: 0x0
// Checksum 0x6f7bfb1, Offset: 0xa8
// Size: 0x78
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
// Checksum 0xb4292cbf, Offset: 0x128
// Size: 0x72
function getloadoutitemfromddlstats(customclassnum, loadoutslot) {
    itemindex = self getloadoutitem(customclassnum, loadoutslot);
    if (is_item_excluded(itemindex) && !is_warlord_perk(itemindex)) {
        return 0;
    }
    return itemindex;
}

// Namespace loadout/loadout_shared
// Params 1, eflags: 0x0
// Checksum 0xbce6c5f7, Offset: 0x1a8
// Size: 0x22
function initweaponattachments(weapon) {
    self.currentweaponstarttime = gettime();
    self.currentweapon = weapon;
}

// Namespace loadout/loadout_shared
// Params 1, eflags: 0x0
// Checksum 0x44914a8a, Offset: 0x1d8
// Size: 0x2a
function isprimarydamage(meansofdeath) {
    return meansofdeath == "MOD_RIFLE_BULLET" || meansofdeath == "MOD_PISTOL_BULLET";
}

// Namespace loadout/loadout_shared
// Params 6, eflags: 0x0
// Checksum 0xe6b5bf0a, Offset: 0x210
// Size: 0x1f2
function cac_modified_vehicle_damage(victim, attacker, damage, meansofdeath, weapon, inflictor) {
    if (!isdefined(victim) || !isdefined(attacker) || !isplayer(attacker)) {
        return damage;
    }
    if (!isdefined(damage) || !isdefined(meansofdeath) || !isdefined(weapon)) {
        return damage;
    }
    old_damage = damage;
    final_damage = damage;
    if (attacker hasperk(#"specialty_bulletdamage") && isprimarydamage(meansofdeath)) {
        final_damage = damage * (100 + level.cac_bulletdamage_data) / 100;
        /#
            if (getdvarint(#"scr_perkdebug", 0)) {
                println("<dev string:x30>" + attacker.name + "<dev string:x38>");
            }
        #/
    } else {
        final_damage = old_damage;
    }
    /#
        if (getdvarint(#"scr_perkdebug", 0)) {
            println("<dev string:x65>" + final_damage / old_damage + "<dev string:x7c>" + old_damage + "<dev string:x8c>" + final_damage);
        }
    #/
    return int(final_damage);
}

// Namespace loadout/loadout_shared
// Params 2, eflags: 0x0
// Checksum 0xda8e5fb8, Offset: 0x410
// Size: 0xb4
function function_fae397a1(weapon, amount) {
    if (weapon.iscliponly) {
        self setweaponammoclip(weapon, amount);
        return;
    }
    self setweaponammoclip(weapon, amount);
    diff = amount - self getweaponammoclip(weapon);
    assert(diff >= 0);
    self setweaponammostock(weapon, diff);
}

