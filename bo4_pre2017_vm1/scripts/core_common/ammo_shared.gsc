#using scripts/core_common/ai/systems/shared;
#using scripts/core_common/array_shared;
#using scripts/core_common/throttle_shared;
#using scripts/core_common/weapons/weaponobjects;
#using scripts/core_common/weapons/weapons;

#namespace ammo;

// Namespace ammo/ammo_shared
// Params 0, eflags: 0x2
// Checksum 0x7ff1d97a, Offset: 0x190
// Size: 0x44
function autoexec main() {
    level.ai_ammo_throttle = new throttle();
    [[ level.ai_ammo_throttle ]]->initialize(1, 0.1);
}

// Namespace ammo/ammo_shared
// Params 0, eflags: 0x0
// Checksum 0xf5cf57e6, Offset: 0x1e0
// Size: 0xfc
function dropaiammo() {
    self endon(#"death");
    if (!isdefined(self.ammopouch)) {
        return;
    }
    if (isdefined(self.disableammodrop) && self.disableammodrop) {
        return;
    }
    [[ level.ai_ammo_throttle ]]->waitinqueue(self);
    droppedweapon = shared::throwweapon(self.ammopouch, "tag_stowed_back", 1, 0);
    if (isdefined(droppedweapon)) {
        droppedweapon thread ammo_pouch_think();
        droppedweapon setcontents(droppedweapon setcontents(0) & ~(32768 | 67108864 | 8388608 | 33554432));
    }
}

// Namespace ammo/ammo_shared
// Params 0, eflags: 0x0
// Checksum 0xdaa831c1, Offset: 0x2e8
// Size: 0x5fe
function ammo_pouch_think() {
    self endon(#"death");
    waitresult = self waittill("scavenger");
    player = waitresult.player;
    primary_weapons = player getweaponslistprimaries();
    offhand_weapons_and_alts = array::exclude(player getweaponslist(1), primary_weapons);
    arrayremovevalue(offhand_weapons_and_alts, level.weaponbasemelee);
    offhand_weapons_and_alts = array::reverse(offhand_weapons_and_alts);
    player playsound("wpn_ammo_pickup");
    player playlocalsound("wpn_ammo_pickup");
    if (isdefined(level.b_disable_scavenger_icon) && level.b_disable_scavenger_icon) {
        player weapons::flash_scavenger_icon();
    }
    for (i = 0; i < offhand_weapons_and_alts.size; i++) {
        weapon = offhand_weapons_and_alts[i];
        maxammo = 0;
        var_480e556d = 0;
        if (weapon == player.grenadetypeprimary && isdefined(player.grenadetypeprimarycount) && player.grenadetypeprimarycount > 0) {
            maxammo = player.grenadetypeprimarycount;
            var_480e556d = 1;
        } else if (weapon == player.grenadetypesecondary && isdefined(player.grenadetypesecondarycount) && player.grenadetypesecondarycount > 0) {
            maxammo = player.grenadetypesecondarycount;
            var_480e556d = 1;
        } else if (isdefined(level.overrideammodropheavyweapon) && weapon.isheavyweapon && level.overrideammodropheavyweapon) {
            maxammo = weapon.maxammo;
        }
        if (isdefined(level.customloadoutscavenge)) {
            maxammo = self [[ level.customloadoutscavenge ]](weapon);
        }
        if (maxammo == 0) {
            continue;
        }
        if (weapon.rootweapon == level.weaponsatchelcharge) {
            if (player weaponobjects::anyobjectsinworld(weapon.rootweapon)) {
                continue;
            }
        }
        stock = player getweaponammostock(weapon);
        if (isdefined(level.overrideammodropheavyweapon) && weapon.isheavyweapon && level.overrideammodropheavyweapon) {
            ammo = stock + weapon.clipsize;
            if (ammo > maxammo) {
                ammo = maxammo;
            }
            player setweaponammostock(weapon, ammo);
            player.scavenged = 1;
            continue;
        }
        if (stock < maxammo) {
            ammo = stock + 1;
            if (ammo > maxammo) {
                ammo = maxammo;
            } else if (weapon == player.grenadetypeprimary) {
                player notify(#"scavenged_primary_grenade");
            }
            player setweaponammostock(weapon, ammo);
            player.scavenged = 1;
        }
    }
    for (i = 0; i < primary_weapons.size; i++) {
        weapon = primary_weapons[i];
        stock = player getweaponammostock(weapon);
        start = player getfractionstartammo(weapon);
        clip = weapon.clipsize;
        clip *= getdvarfloat("scavenger_clip_multiplier", 1);
        clip = int(clip);
        maxammo = weapon.maxammo;
        if (stock < maxammo - clip * 3) {
            ammo = stock + clip * 3;
            player setweaponammostock(weapon, ammo);
            continue;
        }
        player setweaponammostock(weapon, maxammo);
    }
}

