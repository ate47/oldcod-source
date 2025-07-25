#using scripts\core_common\ai\systems\shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\hud_shared;
#using scripts\core_common\player\player_loadout;
#using scripts\core_common\throttle_shared;
#using scripts\weapons\weaponobjects;

#namespace ammo;

// Namespace ammo/ammo_shared
// Params 0, eflags: 0x2
// Checksum 0x91af9e68, Offset: 0xc0
// Size: 0x50
function autoexec main() {
    if (!isdefined(level.ai_ammo_throttle)) {
        level.ai_ammo_throttle = new throttle();
        [[ level.ai_ammo_throttle ]]->initialize(1, 0.1);
    }
}

// Namespace ammo/ammo_shared
// Params 0, eflags: 0x0
// Checksum 0x1c3fe698, Offset: 0x118
// Size: 0xf4
function dropaiammo() {
    self endon(#"death");
    if (!isdefined(self.ammopouch)) {
        return;
    }
    if (is_true(self.disableammodrop)) {
        return;
    }
    [[ level.ai_ammo_throttle ]]->waitinqueue(self);
    droppedweapon = shared::throwweapon(self.ammopouch, "tag_stowed_back", 1, 0);
    if (isdefined(droppedweapon)) {
        droppedweapon thread ammo_pouch_think();
        droppedweapon setcontents(droppedweapon setcontents(0) & ~(32768 | 16777216 | 2097152 | 8388608));
    }
}

// Namespace ammo/ammo_shared
// Params 0, eflags: 0x0
// Checksum 0xc9ad2d44, Offset: 0x218
// Size: 0x5fc
function ammo_pouch_think() {
    self endon(#"death");
    waitresult = self waittill(#"scavenger");
    player = waitresult.player;
    primary_weapons = player getweaponslistprimaries();
    offhand_weapons_and_alts = array::exclude(player getweaponslist(1), primary_weapons);
    arrayremovevalue(offhand_weapons_and_alts, level.weaponbasemelee);
    offhand_weapons_and_alts = array::reverse(offhand_weapons_and_alts);
    player playsound(#"wpn_ammo_pickup");
    player playlocalsound(#"wpn_ammo_pickup");
    if (is_true(level.b_disable_scavenger_icon)) {
        player hud::function_4a4de0de();
    }
    for (i = 0; i < offhand_weapons_and_alts.size; i++) {
        weapon = offhand_weapons_and_alts[i];
        if (is_true(weapon.var_cc0ed831)) {
            continue;
        }
        maxammo = 0;
        loadout = player loadout::find_loadout_slot(weapon);
        if (isdefined(loadout)) {
            if (loadout.count > 0) {
                maxammo = loadout.count;
            } else if (weapon.isheavyweapon && is_true(level.overrideammodropheavyweapon)) {
                maxammo = weapon.maxammo;
            }
        } else if (weapon == player.grenadetypeprimary && isdefined(player.grenadetypeprimarycount) && player.grenadetypeprimarycount > 0) {
            maxammo = player.grenadetypeprimarycount;
        } else if (weapon == player.grenadetypesecondary && isdefined(player.grenadetypesecondarycount) && player.grenadetypesecondarycount > 0) {
            maxammo = player.grenadetypesecondarycount;
        } else if (weapon.isheavyweapon && is_true(level.overrideammodropheavyweapon)) {
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
        if (weapon.isheavyweapon && is_true(level.overrideammodropheavyweapon)) {
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
            } else if (isdefined(loadout)) {
                if ("primarygrenade" == player loadout::function_8435f729(weapon)) {
                    player callback::callback(#"scavenged_primary_grenade", {#weapon:weapon});
                }
            }
            player setweaponammostock(weapon, ammo);
            player.scavenged = 1;
        }
    }
    for (i = 0; i < primary_weapons.size; i++) {
        weapon = primary_weapons[i];
        if (is_true(weapon.var_cc0ed831)) {
            continue;
        }
        stock = player getweaponammostock(weapon);
        start = player getfractionstartammo(weapon);
        clip = weapon.clipsize;
        clip *= getdvarfloat(#"scavenger_clip_multiplier", 1);
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

