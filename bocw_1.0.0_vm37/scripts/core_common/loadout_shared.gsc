#namespace loadout;

// Namespace loadout/loadout_shared
// Params 1, eflags: 0x0
// Checksum 0x118ecdca, Offset: 0x90
// Size: 0xe
function is_warlord_perk(*itemindex) {
    return false;
}

// Namespace loadout/loadout_shared
// Params 1, eflags: 0x0
// Checksum 0x1176ea89, Offset: 0xa8
// Size: 0x6e
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
// Checksum 0xde9e2ef8, Offset: 0x120
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
// Checksum 0x33abf651, Offset: 0x1a0
// Size: 0x22
function initweaponattachments(weapon) {
    self.currentweaponstarttime = gettime();
    self.currentweapon = weapon;
}

// Namespace loadout/loadout_shared
// Params 1, eflags: 0x0
// Checksum 0x1fc20fae, Offset: 0x1d0
// Size: 0x2a
function isprimarydamage(meansofdeath) {
    return meansofdeath == "MOD_RIFLE_BULLET" || meansofdeath == "MOD_PISTOL_BULLET";
}

// Namespace loadout/loadout_shared
// Params 6, eflags: 0x0
// Checksum 0xd5ada535, Offset: 0x208
// Size: 0x1ea
function cac_modified_vehicle_damage(victim, attacker, damage, meansofdeath, weapon, *inflictor) {
    if (!isdefined(attacker) || !isdefined(damage) || !isplayer(damage)) {
        return meansofdeath;
    }
    if (!isdefined(meansofdeath) || !isdefined(weapon) || !isdefined(inflictor)) {
        return meansofdeath;
    }
    old_damage = meansofdeath;
    final_damage = meansofdeath;
    if (damage hasperk(#"specialty_bulletdamage") && isprimarydamage(weapon)) {
        final_damage = meansofdeath * (100 + level.cac_bulletdamage_data) / 100;
        /#
            if (getdvarint(#"scr_perkdebug", 0)) {
                println("<dev string:x38>" + damage.name + "<dev string:x43>");
            }
        #/
    } else {
        final_damage = old_damage;
    }
    /#
        if (getdvarint(#"scr_perkdebug", 0)) {
            println("<dev string:x73>" + final_damage / old_damage + "<dev string:x8d>" + old_damage + "<dev string:xa0>" + final_damage);
        }
    #/
    return int(final_damage);
}

// Namespace loadout/loadout_shared
// Params 2, eflags: 0x0
// Checksum 0xeb899793, Offset: 0x400
// Size: 0xb4
function function_3ba6ee5d(weapon, amount) {
    if (weapon.iscliponly) {
        self setweaponammoclip(weapon, amount);
        return;
    }
    self setweaponammoclip(weapon, amount);
    diff = amount - self getweaponammoclip(weapon);
    assert(diff >= 0);
    self setweaponammostock(weapon, diff);
}

