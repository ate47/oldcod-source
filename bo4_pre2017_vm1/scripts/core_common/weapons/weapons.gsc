#using scripts/core_common/array_shared;
#using scripts/core_common/bb_shared;
#using scripts/core_common/callbacks_shared;
#using scripts/core_common/challenges_shared;
#using scripts/core_common/gameobjects_shared;
#using scripts/core_common/killstreaks_shared;
#using scripts/core_common/loadout_shared;
#using scripts/core_common/scoreevents_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;
#using scripts/core_common/weapons/empgrenade;
#using scripts/core_common/weapons/flashgrenades;
#using scripts/core_common/weapons/hacker_tool;
#using scripts/core_common/weapons/hive_gun;
#using scripts/core_common/weapons/proximity_grenade;
#using scripts/core_common/weapons/riotshield;
#using scripts/core_common/weapons/sticky_grenade;
#using scripts/core_common/weapons/tabun;
#using scripts/core_common/weapons/trophy_system;
#using scripts/core_common/weapons/weapon_utils;
#using scripts/core_common/weapons/weaponobjects;
#using scripts/core_common/weapons_shared;

#namespace weapons;

// Namespace weapons/weapons
// Params 0, eflags: 0x0
// Checksum 0x1d1c5ff, Offset: 0x960
// Size: 0x1b8
function init_shared() {
    level.weaponnone = getweapon("none");
    level.weaponnull = getweapon("weapon_null");
    level.weaponbasemelee = getweapon("knife");
    level.weaponbasemeleeheld = getweapon("knife_held");
    level.weaponballisticknife = getweapon("knife_ballistic");
    level.weaponriotshield = getweapon("riotshield");
    level.weaponflashgrenade = getweapon("flash_grenade");
    level.weaponsatchelcharge = getweapon("satchel_charge");
    if (!isdefined(level.trackweaponstats)) {
        level.trackweaponstats = 1;
    }
    level._effect["flashNineBang"] = "_t6/misc/fx_equip_tac_insert_exp";
    callback::on_start_gametype(&init);
    level.detach_all_weapons = &detach_all_weapons;
}

// Namespace weapons/weapons
// Params 0, eflags: 0x0
// Checksum 0xe873a1dd, Offset: 0xb20
// Size: 0xb4
function init() {
    level.missileentities = [];
    level.hackertooltargets = [];
    level.missileduddeletedelay = getdvarint("scr_missileDudDeleteDelay", 3);
    if (!isdefined(level.roundstartexplosivedelay)) {
        level.roundstartexplosivedelay = 0;
    }
    callback::on_connect(&on_player_connect);
    callback::on_spawned(&on_player_spawned);
}

// Namespace weapons/weapons
// Params 0, eflags: 0x0
// Checksum 0xe23424db, Offset: 0xbe0
// Size: 0x3c
function on_player_connect() {
    self.usedweapons = 0;
    self.lastfiretime = 0;
    self.hits = 0;
    self scavenger_hud_create();
}

// Namespace weapons/weapons
// Params 0, eflags: 0x0
// Checksum 0x17ef1f97, Offset: 0xc28
// Size: 0xec
function on_player_spawned() {
    self.concussionendtime = 0;
    self.scavenged = 0;
    self.hasdonecombat = 0;
    self.shielddamageblocked = 0;
    self thread function_1748a15e();
    self thread function_ae346b89();
    self thread function_b486caf3();
    self thread function_fd4b8044();
    if (level.trackweaponstats) {
        self thread track();
    }
    self.droppeddeathweapon = undefined;
    self.tookweaponfrom = [];
    self.pickedupweaponkills = [];
    self thread function_43de9900();
}

// Namespace weapons/weapons
// Params 0, eflags: 0x0
// Checksum 0x3f005eca, Offset: 0xd20
// Size: 0x11e
function function_fd4b8044() {
    self endon(#"death");
    self endon(#"disconnect");
    self.lastdroppableweapon = self getcurrentweapon();
    self.lastweaponchange = 0;
    while (true) {
        previous_weapon = self getcurrentweapon();
        waitresult = self waittill("weapon_change");
        newweapon = waitresult.weapon;
        if (may_drop(newweapon)) {
            self.lastdroppableweapon = newweapon;
            self.lastweaponchange = gettime();
        }
        if (doesweaponreplacespawnweapon(self.spawnweapon, newweapon)) {
            self.spawnweapon = newweapon;
            self.pers["spawnWeapon"] = newweapon;
        }
    }
}

// Namespace weapons/weapons
// Params 1, eflags: 0x0
// Checksum 0x9647bbc9, Offset: 0xe48
// Size: 0xf4
function update_last_held_weapon_timings(newtime) {
    if (isdefined(self.currentweapon) && isdefined(self.currentweaponstarttime)) {
        totaltime = int((newtime - self.currentweaponstarttime) / 1000);
        if (totaltime > 0) {
            weaponpickedup = 0;
            if (isdefined(self.pickedupweapons) && isdefined(self.pickedupweapons[self.currentweapon])) {
                weaponpickedup = 1;
            }
            self addweaponstat(self.currentweapon, "timeUsed", totaltime, self.class_num, weaponpickedup);
            self.currentweaponstarttime = newtime;
        }
    }
}

// Namespace weapons/weapons
// Params 1, eflags: 0x0
// Checksum 0xf459c1c5, Offset: 0xf48
// Size: 0x3d6
function update_timings(newtime) {
    if (self isbot()) {
        return;
    }
    update_last_held_weapon_timings(newtime);
    if (!isdefined(self.staticweaponsstarttime)) {
        return;
    }
    totaltime = int((newtime - self.staticweaponsstarttime) / 1000);
    if (totaltime < 0) {
        return;
    }
    self.staticweaponsstarttime = newtime;
    if (isdefined(self.weapon_array_grenade)) {
        for (i = 0; i < self.weapon_array_grenade.size; i++) {
            self addweaponstat(self.weapon_array_grenade[i], "timeUsed", totaltime, self.class_num);
        }
    }
    if (isdefined(self.weapon_array_inventory)) {
        for (i = 0; i < self.weapon_array_inventory.size; i++) {
            self addweaponstat(self.weapon_array_inventory[i], "timeUsed", totaltime, self.class_num);
        }
    }
    if (isdefined(self.killstreak)) {
        for (i = 0; i < self.killstreak.size; i++) {
            killstreaktype = level.menureferenceforkillstreak[self.killstreak[i]];
            if (isdefined(killstreaktype)) {
                killstreakweapon = killstreaks::get_killstreak_weapon(killstreaktype);
                self addweaponstat(killstreakweapon, "timeUsed", totaltime, self.class_num);
            }
        }
    }
    if (level.rankedmatch && level.perksenabled) {
        perksindexarray = [];
        specialtys = self.specialty;
        if (!isdefined(specialtys)) {
            return;
        }
        if (!isdefined(self.curclass)) {
            return;
        }
        if (isdefined(self.class_num)) {
            for (numspecialties = 0; numspecialties < level.maxspecialties; numspecialties++) {
                perk = self getloadoutitem(self.class_num, "specialty" + numspecialties + 1);
                if (perk != 0) {
                    perksindexarray[perk] = 1;
                }
            }
            var_5a4b166e = getarraykeys(perksindexarray);
            for (i = 0; i < var_5a4b166e.size; i++) {
                if (perksindexarray[var_5a4b166e[i]] == 1) {
                    self adddstat("itemStats", var_5a4b166e[i], "stats", "timeUsed", "statValue", totaltime);
                }
            }
        }
    }
}

// Namespace weapons/weapons
// Params 0, eflags: 0x0
// Checksum 0x69a6dde, Offset: 0x1328
// Size: 0x1ca
function track() {
    currentweapon = self getcurrentweapon();
    currenttime = gettime();
    spawnid = getplayerspawnid(self);
    while (true) {
        event = self waittill("weapon_change", "death", "disconnect");
        newtime = gettime();
        if (event._notify == "weapon_change") {
            self bb::commit_weapon_data(spawnid, currentweapon, currenttime);
            newweapon = self getcurrentweapon();
            if (newweapon != level.weaponnone && newweapon != currentweapon) {
                update_last_held_weapon_timings(newtime);
                self loadout::initweaponattachments(newweapon);
                currentweapon = newweapon;
                currenttime = newtime;
            }
            continue;
        }
        if (event._notify != "disconnect" && isdefined(self)) {
            self bb::commit_weapon_data(spawnid, currentweapon, currenttime);
            update_timings(newtime);
        }
        return;
    }
}

// Namespace weapons/weapons
// Params 1, eflags: 0x0
// Checksum 0x46a41bef, Offset: 0x1500
// Size: 0x86
function may_drop(weapon) {
    if (level.disableweapondrop == 1) {
        return false;
    }
    if (weapon == level.weaponnone) {
        return false;
    }
    if (killstreaks::is_killstreak_weapon(weapon)) {
        return false;
    }
    if (weapon.isgameplayweapon) {
        return false;
    }
    if (!weapon.isprimary) {
        return false;
    }
    return true;
}

// Namespace weapons/weapons
// Params 3, eflags: 0x0
// Checksum 0x7b9b9c82, Offset: 0x1590
// Size: 0x4c4
function drop_for_death(attacker, sweapon, smeansofdeath) {
    if (level.disableweapondrop == 1) {
        return;
    }
    weapon = self.lastdroppableweapon;
    if (isdefined(self.droppeddeathweapon)) {
        return;
    }
    if (!isdefined(weapon)) {
        /#
            if (getdvarstring("<dev string:x28>") == "<dev string:x36>") {
                println("<dev string:x38>");
            }
        #/
        return;
    }
    if (weapon == level.weaponnone) {
        /#
            if (getdvarstring("<dev string:x28>") == "<dev string:x36>") {
                println("<dev string:x58>");
            }
        #/
        return;
    }
    if (!self hasweapon(weapon)) {
        /#
            if (getdvarstring("<dev string:x28>") == "<dev string:x36>") {
                println("<dev string:x7b>" + weapon.name + "<dev string:xa7>");
            }
        #/
        return;
    }
    if (!self anyammoforweaponmodes(weapon)) {
        /#
            if (getdvarstring("<dev string:x28>") == "<dev string:x36>") {
                println("<dev string:xa9>");
            }
        #/
        return;
    }
    if (!should_drop_limited_weapon(weapon, self)) {
        return;
    }
    if (weapon.iscarriedkillstreak) {
        return;
    }
    clipammo = self getweaponammoclip(weapon);
    stockammo = self getweaponammostock(weapon);
    clip_and_stock_ammo = clipammo + stockammo;
    if (!clip_and_stock_ammo && !(isdefined(weapon.unlimitedammo) && weapon.unlimitedammo)) {
        /#
            if (getdvarstring("<dev string:x28>") == "<dev string:x36>") {
                println("<dev string:xd6>");
            }
        #/
        return;
    }
    if (isdefined(weapon.isnotdroppable) && weapon.isnotdroppable) {
        return;
    }
    stockmax = weapon.maxammo;
    if (stockammo > stockmax) {
        stockammo = stockmax;
    }
    item = self dropitem(weapon);
    if (!isdefined(item)) {
        /#
            iprintlnbold("<dev string:xf2>" + weapon.name);
        #/
        return;
    }
    /#
        if (getdvarstring("<dev string:x28>") == "<dev string:x36>") {
            println("<dev string:x119>" + weapon.name);
        }
    #/
    drop_limited_weapon(weapon, self, item);
    self.droppeddeathweapon = 1;
    item itemweaponsetammo(clipammo, stockammo);
    item.owner = self;
    item.ownersattacker = attacker;
    item.sweapon = sweapon;
    item.smeansofdeath = smeansofdeath;
    item thread watch_pickup();
    item thread delete_pickup_after_awhile();
}

// Namespace weapons/weapons
// Params 0, eflags: 0x0
// Checksum 0x2fccb86f, Offset: 0x1a60
// Size: 0x34
function delete_pickup_after_awhile() {
    self endon(#"death");
    wait 60;
    if (!isdefined(self)) {
        return;
    }
    self delete();
}

// Namespace weapons/weapons
// Params 0, eflags: 0x0
// Checksum 0x7565508b, Offset: 0x1aa0
// Size: 0x40c
function watch_pickup() {
    self endon(#"death");
    weapon = self.item;
    waitresult = self waittill("trigger");
    player = waitresult.activator;
    droppeditem = waitresult.dropped_item;
    pickedupontouch = waitresult.is_pickedup_ontouch;
    if (true) {
        if (isdefined(player) && isplayer(player)) {
            if (isdefined(player.weaponpickupscount)) {
                player.weaponpickupscount++;
            } else {
                player.weaponpickupscount = 1;
            }
            player incrementspecificweaponpickedupcount(weapon);
            if (!isdefined(player.pickedupweapons)) {
                player.pickedupweapons = [];
            }
            player.pickedupweapons[weapon] = 1;
        }
    }
    /#
        if (getdvarstring("<dev string:x28>") == "<dev string:x36>") {
            println("<dev string:x12a>" + weapon.name + "<dev string:x13d>" + isdefined(self.ownersattacker));
        }
    #/
    assert(isdefined(player.tookweaponfrom));
    assert(isdefined(player.pickedupweaponkills));
    if (isdefined(droppeditem)) {
        for (i = 0; i < droppeditem.size; i++) {
            if (!isdefined(droppeditem[i])) {
                continue;
            }
            droppedweapon = droppeditem[i].item;
            if (isdefined(player.tookweaponfrom[droppedweapon])) {
                droppeditem[i].owner = player.tookweaponfrom[droppedweapon];
                droppeditem[i].ownersattacker = player;
                player.tookweaponfrom[droppedweapon] = undefined;
            }
            droppeditem[i] thread watch_pickup();
        }
    }
    if (!isdefined(pickedupontouch) || !pickedupontouch) {
        if (isdefined(self.ownersattacker) && self.ownersattacker == player) {
            player.tookweaponfrom[weapon] = spawnstruct();
            player.tookweaponfrom[weapon].previousowner = self.owner;
            player.tookweaponfrom[weapon].sweapon = self.sweapon;
            player.tookweaponfrom[weapon].smeansofdeath = self.smeansofdeath;
            player.pickedupweaponkills[weapon] = 0;
            return;
        }
        player.tookweaponfrom[weapon] = undefined;
        player.pickedupweaponkills[weapon] = undefined;
    }
}

// Namespace weapons/weapons
// Params 0, eflags: 0x0
// Checksum 0x72bfd8ee, Offset: 0x1eb8
// Size: 0x2fa
function function_1748a15e() {
    self endon(#"death");
    self endon(#"disconnect");
    level endon(#"game_ended");
    self.usedkillstreakweapon = [];
    self.usedkillstreakweapon["minigun"] = 0;
    self.usedkillstreakweapon["m32"] = 0;
    self.usedkillstreakweapon["m202_flash"] = 0;
    self.usedkillstreakweapon["m220_tow"] = 0;
    self.usedkillstreakweapon["mp40_blinged"] = 0;
    self.killstreaktype = [];
    self.killstreaktype["minigun"] = "minigun";
    self.killstreaktype["m32"] = "m32";
    self.killstreaktype["m202_flash"] = "m202_flash";
    self.killstreaktype["m220_tow"] = "m220_tow";
    self.killstreaktype["mp40_blinged"] = "mp40_blinged_drop";
    for (;;) {
        waitresult = self waittill("weapon_fired");
        curweapon = waitresult.weapon;
        self.lastfiretime = gettime();
        self.hasdonecombat = 1;
        switch (curweapon.weapclass) {
        case #"mg":
        case #"pistol":
        case #"hash_ae7987cd":
        case #"rifle":
        case #"smg":
        case #"spread":
            self track_fire(curweapon);
            level.globalshotsfired++;
            break;
        case #"grenade":
        case #"rocketlauncher":
            self addweaponstat(curweapon, "shots", 1, self.class_num, 0);
            break;
        default:
            break;
        }
        if (isdefined(curweapon.gadget_type) && curweapon.gadget_type == 14) {
            if (isdefined(self.heavyweaponshots)) {
                self.heavyweaponshots++;
            }
        }
        if (curweapon.iscarriedkillstreak) {
            if (isdefined(self.pers["held_killstreak_ammo_count"][curweapon])) {
                self.pers["held_killstreak_ammo_count"][curweapon]--;
            }
            self.usedkillstreakweapon[curweapon.name] = 1;
        }
    }
}

// Namespace weapons/weapons
// Params 1, eflags: 0x0
// Checksum 0xa92e557, Offset: 0x21c0
// Size: 0x204
function track_fire(curweapon) {
    pixbeginevent("trackWeaponFire");
    weaponpickedup = 0;
    if (isdefined(self.pickedupweapons) && isdefined(self.pickedupweapons[curweapon])) {
        weaponpickedup = 1;
    }
    self trackweaponfirenative(curweapon, 1, self.hits, 1, self.class_num, weaponpickedup, self.primaryloadoutgunsmithvariantindex, self.secondaryloadoutgunsmithvariantindex);
    if (isdefined(self.totalmatchshots)) {
        self.totalmatchshots++;
    }
    self bb::add_to_stat("shots", 1);
    self bb::add_to_stat("hits", self.hits);
    if (level.mpcustommatch === 1) {
        self.pers["shotsfired"]++;
        self.shotsfired = self.pers["shotsfired"];
        self.pers["shotshit"] = self.pers["shotshit"] + self.hits;
        self.shotshit = self.pers["shotshit"];
        self.pers["shotsmissed"] = self.shotsfired - self.shotshit;
        self.shotsmissed = self.pers["shotsmissed"];
    }
    self.hits = 0;
    pixendevent();
}

// Namespace weapons/weapons
// Params 0, eflags: 0x0
// Checksum 0x70fae679, Offset: 0x23d0
// Size: 0x180
function function_ae346b89() {
    self endon(#"death");
    self endon(#"disconnect");
    self.throwinggrenade = 0;
    self.gotpullbacknotify = 0;
    self thread begin_other_grenade_tracking();
    self thread function_aea44179();
    self thread function_f01938c2();
    self thread function_4c2ae355();
    for (;;) {
        waitresult = self waittill("grenade_pullback");
        weapon = waitresult.weapon;
        self addweaponstat(weapon, "shots", 1, self.class_num);
        self.hasdonecombat = 1;
        self.throwinggrenade = 1;
        self.gotpullbacknotify = 1;
        if (weapon.drawoffhandmodelinhand) {
            self setoffhandvisible(1);
            self thread watch_offhand_end();
        }
        self thread begin_grenade_tracking();
    }
}

// Namespace weapons/weapons
// Params 0, eflags: 0x0
// Checksum 0x98d28bf4, Offset: 0x2558
// Size: 0xe0
function function_b486caf3() {
    self endon(#"death");
    self endon(#"disconnect");
    level endon(#"game_ended");
    for (;;) {
        waitresult = self waittill("missile_fire");
        missile = waitresult.projectile;
        weapon = waitresult.weapon;
        self.hasdonecombat = 1;
        if (isdefined(missile)) {
            level.missileentities[level.missileentities.size] = missile;
            missile.weapon = weapon;
            missile thread watch_missile_death();
        }
    }
}

// Namespace weapons/weapons
// Params 0, eflags: 0x0
// Checksum 0x4d6b33a6, Offset: 0x2640
// Size: 0x34
function watch_missile_death() {
    self waittill("death");
    arrayremovevalue(level.missileentities, self);
}

// Namespace weapons/weapons
// Params 2, eflags: 0x0
// Checksum 0x1b551ecd, Offset: 0x2680
// Size: 0x112
function drop_all_to_ground(origin, radius) {
    weapons = getdroppedweapons();
    for (i = 0; i < weapons.size; i++) {
        if (distancesquared(origin, weapons[i].origin) < radius * radius) {
            trace = bullettrace(weapons[i].origin, weapons[i].origin + (0, 0, -2000), 0, weapons[i]);
            weapons[i].origin = trace["position"];
        }
    }
}

// Namespace weapons/weapons
// Params 2, eflags: 0x0
// Checksum 0xa8230ed7, Offset: 0x27a0
// Size: 0xce
function drop_grenades_to_ground(origin, radius) {
    grenades = getentarray("grenade", "classname");
    for (i = 0; i < grenades.size; i++) {
        if (distancesquared(origin, grenades[i].origin) < radius * radius) {
            grenades[i] launch((5, 5, 5));
        }
    }
}

// Namespace weapons/weapons
// Params 0, eflags: 0x0
// Checksum 0x5000321e, Offset: 0x2878
// Size: 0xae
function watch_grenade_cancel() {
    self endon(#"death");
    self endon(#"disconnect");
    self endon(#"grenade_fire");
    waittillframeend();
    weapon = level.weaponnone;
    while (self isthrowinggrenade() && weapon == level.weaponnone) {
        self waittill("weapon_change");
    }
    self.throwinggrenade = 0;
    self.gotpullbacknotify = 0;
    self notify(#"grenade_throw_cancelled");
}

// Namespace weapons/weapons
// Params 0, eflags: 0x0
// Checksum 0x411c978d, Offset: 0x2930
// Size: 0xcc
function watch_offhand_end() {
    self notify(#"watchoffhandend");
    self endon(#"watchoffhandend");
    while (self function_bd108e58()) {
        msg = self waittill("death", "disconnect", "grenade_fire", "weapon_change", "watchOffhandEnd");
        if (msg._notify == "death" || msg._notify == "disconnect") {
            break;
        }
    }
    if (isdefined(self)) {
        self setoffhandvisible(0);
    }
}

// Namespace weapons/weapons
// Params 0, eflags: 0x0
// Checksum 0x93551ff3, Offset: 0x2a08
// Size: 0x5a
function function_bd108e58() {
    if (self isusingoffhand()) {
        weapon = self getcurrentoffhand();
        if (weapon.isequipment) {
            return true;
        }
    }
    return false;
}

// Namespace weapons/weapons
// Params 0, eflags: 0x0
// Checksum 0x7fc1ea7c, Offset: 0x2a70
// Size: 0x3f4
function begin_grenade_tracking() {
    self endon(#"death");
    self endon(#"disconnect");
    self endon(#"grenade_throw_cancelled");
    starttime = gettime();
    self thread watch_grenade_cancel();
    waitresult = self waittill("grenade_fire");
    grenade = waitresult.projectile;
    weapon = waitresult.weapon;
    cooktime = waitresult.cook_time;
    assert(isdefined(grenade));
    level.missileentities[level.missileentities.size] = grenade;
    grenade.weapon = weapon;
    grenade thread watch_missile_death();
    if (isdefined(level.projectiles_should_ignore_world_pause) && level.projectiles_should_ignore_world_pause) {
        grenade setignorepauseworld(1);
    }
    if (grenade util::ishacked()) {
        return;
    }
    blackboxeventname = "mpequipmentuses";
    if (sessionmodeiscampaigngame()) {
        blackboxeventname = "cpequipmentuses";
    } else if (sessionmodeiszombiesgame()) {
        blackboxeventname = "zmequipmentuses";
    }
    bbprint(blackboxeventname, "gametime %d spawnid %d weaponname %s", gettime(), getplayerspawnid(self), weapon.name);
    cookedtime = gettime() - starttime;
    if (cookedtime > 1000) {
        grenade.iscooked = 1;
    }
    if (isdefined(self.grenadesused)) {
        self.grenadesused++;
    }
    switch (weapon.rootweapon.name) {
    case #"frag_grenade":
        level.globalfraggrenadesfired++;
    case #"sticky_grenade":
        self addweaponstat(weapon, "used", 1);
        grenade setteam(self.pers["team"]);
        grenade setowner(self);
    case #"explosive_bolt":
        grenade.originalowner = self;
        break;
    case #"satchel_charge":
        level.globalsatchelchargefired++;
        break;
    case #"concussion_grenade":
    case #"flash_grenade":
        self addweaponstat(weapon, "used", 1);
        break;
    }
    self.throwinggrenade = 0;
    if (weapon.cookoffholdtime > 0) {
        grenade thread track_cooked_detonation(self, weapon, cooktime);
        return;
    }
    if (weapon.multidetonation > 0) {
        grenade thread track_multi_detonation(self, weapon, cooktime);
    }
}

// Namespace weapons/weapons
// Params 0, eflags: 0x0
// Checksum 0x7cb5b342, Offset: 0x2e70
// Size: 0x1f6
function begin_other_grenade_tracking() {
    self notify(#"hash_1e4ca7f2");
    self endon(#"hash_1e4ca7f2");
    self endon(#"disconnect");
    for (;;) {
        waitresult = self waittill("grenade_fire");
        grenade = waitresult.projectile;
        weapon = waitresult.weapon;
        if (grenade util::ishacked()) {
            continue;
        }
        switch (weapon.rootweapon.name) {
        case #"tabun_gas":
            grenade thread tabun::watchtabungrenadedetonation(self);
            break;
        case #"sticky_grenade":
            grenade thread check_stuck_to_player(1, 1, weapon);
            grenade thread riotshield::check_stuck_to_shield();
            break;
        case #"c4":
        case #"satchel_charge":
            grenade thread check_stuck_to_player(1, 0, weapon);
            break;
        case #"hatchet":
            grenade.lastweaponbeforetoss = self util::getlastweapon();
            grenade thread check_hatchet_bounce();
            grenade thread check_stuck_to_player(0, 0, weapon);
            self addweaponstat(weapon, "used", 1);
            break;
        default:
            break;
        }
    }
}

// Namespace weapons/weapons
// Params 3, eflags: 0x0
// Checksum 0xf80fad06, Offset: 0x3070
// Size: 0xfc
function check_stuck_to_player(deleteonteamchange, awardscoreevent, weapon) {
    self endon(#"death");
    waitresult = self waittill("stuck_to_player");
    player = waitresult.player;
    if (isdefined(player)) {
        if (deleteonteamchange) {
            self thread stuck_to_player_team_change(player);
        }
        if (awardscoreevent && isdefined(self.originalowner)) {
            if (self.originalowner util::isenemyplayer(player)) {
                scoreevents::processscoreevent("stick_explosive_kill", self.originalowner, player, weapon);
            }
        }
        self.stucktoplayer = player;
    }
}

// Namespace weapons/weapons
// Params 0, eflags: 0x0
// Checksum 0xf9d3a8d, Offset: 0x3178
// Size: 0x38
function check_hatchet_bounce() {
    self endon(#"stuck_to_player");
    self endon(#"death");
    self waittill("grenade_bounce");
    self.bounced = 1;
}

// Namespace weapons/weapons
// Params 1, eflags: 0x0
// Checksum 0xb416327f, Offset: 0x31b8
// Size: 0x9a
function stuck_to_player_team_change(player) {
    self endon(#"death");
    player endon(#"disconnect");
    originalteam = player.pers["team"];
    while (true) {
        player waittill("joined_team");
        if (player.pers["team"] != originalteam) {
            self detonate();
            return;
        }
    }
}

// Namespace weapons/weapons
// Params 0, eflags: 0x0
// Checksum 0x7542217a, Offset: 0x3260
// Size: 0xe0
function function_aea44179() {
    self endon(#"death");
    self endon(#"disconnect");
    for (;;) {
        waitresult = self waittill("grenade_fire");
        grenade = waitresult.projectile;
        weapon = waitresult.weapon;
        if (self.gotpullbacknotify) {
            self.gotpullbacknotify = 0;
            continue;
        }
        if (!issubstr(weapon.name, "frag_")) {
            continue;
        }
        grenade.threwback = 1;
        grenade.originalowner = self;
    }
}

// Namespace weapons/weapons
// Params 1, eflags: 0x0
// Checksum 0x8bf9e701, Offset: 0x3348
// Size: 0x3c
function wait_and_delete_dud(waittime) {
    self endon(#"death");
    wait waittime;
    if (isdefined(self)) {
        self delete();
    }
}

// Namespace weapons/weapons
// Params 0, eflags: 0x0
// Checksum 0x3f3b7063, Offset: 0x3390
// Size: 0x28
function gettimefromlevelstart() {
    if (!isdefined(level.starttime)) {
        return 0;
    }
    return gettime() - level.starttime;
}

// Namespace weapons/weapons
// Params 3, eflags: 0x0
// Checksum 0x25e5c605, Offset: 0x33c0
// Size: 0x164
function turn_grenade_into_a_dud(weapon, isthrowngrenade, player) {
    time = gettimefromlevelstart() / 1000;
    if (level.roundstartexplosivedelay >= time) {
        if (weapon.disallowatmatchstart || weaponhasattachment(weapon, "gl")) {
            timeleft = int(level.roundstartexplosivedelay - time);
            if (!timeleft) {
                timeleft = 1;
            }
            if (isthrowngrenade) {
                player iprintlnbold(%MP_GRENADE_UNAVAILABLE_FOR_N, " " + timeleft + " ", %EXE_SECONDS);
            } else {
                player iprintlnbold(%MP_LAUNCHER_UNAVAILABLE_FOR_N, " " + timeleft + " ", %EXE_SECONDS);
            }
            self makegrenadedud();
        }
    }
}

// Namespace weapons/weapons
// Params 0, eflags: 0x0
// Checksum 0xab87e4b5, Offset: 0x3530
// Size: 0x98
function function_f01938c2() {
    self endon(#"spawned_player");
    self endon(#"disconnect");
    while (true) {
        waitresult = self waittill("grenade_fire");
        grenade = waitresult.projectile;
        weapon = waitresult.weapon;
        grenade turn_grenade_into_a_dud(weapon, 1, self);
    }
}

// Namespace weapons/weapons
// Params 0, eflags: 0x0
// Checksum 0xb3657ba9, Offset: 0x35d0
// Size: 0x100
function function_4c2ae355() {
    self endon(#"spawned_player");
    self endon(#"disconnect");
    while (true) {
        waitresult = self waittill("grenade_launcher_fire");
        grenade = waitresult.projectile;
        weapon = waitresult.weapon;
        grenade turn_grenade_into_a_dud(weapon, 0, self);
        assert(isdefined(grenade));
        level.missileentities[level.missileentities.size] = grenade;
        grenade.weapon = weapon;
        grenade thread watch_missile_death();
    }
}

// Namespace weapons/weapons
// Params 4, eflags: 0x0
// Checksum 0x6a095cb4, Offset: 0x36d8
// Size: 0x818
function get_damageable_ents(pos, radius, dolos, startradius) {
    ents = [];
    if (!isdefined(dolos)) {
        dolos = 0;
    }
    if (!isdefined(startradius)) {
        startradius = 0;
    }
    players = level.players;
    for (i = 0; i < players.size; i++) {
        if (!isalive(players[i]) || players[i].sessionstate != "playing") {
            continue;
        }
        playerpos = players[i].origin + (0, 0, 32);
        distsq = distancesquared(pos, playerpos);
        if (!dolos || distsq < radius * radius && damage_trace_passed(pos, playerpos, startradius, undefined)) {
            newent = spawnstruct();
            newent.isplayer = 1;
            newent.isadestructable = 0;
            newent.isadestructible = 0;
            newent.isactor = 0;
            newent.entity = players[i];
            newent.damagecenter = playerpos;
            ents[ents.size] = newent;
        }
    }
    grenades = getentarray("grenade", "classname");
    for (i = 0; i < grenades.size; i++) {
        entpos = grenades[i].origin;
        distsq = distancesquared(pos, entpos);
        if (!dolos || distsq < radius * radius && damage_trace_passed(pos, entpos, startradius, grenades[i])) {
            newent = spawnstruct();
            newent.isplayer = 0;
            newent.isadestructable = 0;
            newent.isadestructible = 0;
            newent.isactor = 0;
            newent.entity = grenades[i];
            newent.damagecenter = entpos;
            ents[ents.size] = newent;
        }
    }
    destructibles = getentarray("destructible", "targetname");
    for (i = 0; i < destructibles.size; i++) {
        entpos = destructibles[i].origin;
        distsq = distancesquared(pos, entpos);
        if (!dolos || distsq < radius * radius && damage_trace_passed(pos, entpos, startradius, destructibles[i])) {
            newent = spawnstruct();
            newent.isplayer = 0;
            newent.isadestructable = 0;
            newent.isadestructible = 1;
            newent.isactor = 0;
            newent.entity = destructibles[i];
            newent.damagecenter = entpos;
            ents[ents.size] = newent;
        }
    }
    destructables = getentarray("destructable", "targetname");
    for (i = 0; i < destructables.size; i++) {
        entpos = destructables[i].origin;
        distsq = distancesquared(pos, entpos);
        if (!dolos || distsq < radius * radius && damage_trace_passed(pos, entpos, startradius, destructables[i])) {
            newent = spawnstruct();
            newent.isplayer = 0;
            newent.isadestructable = 1;
            newent.isadestructible = 0;
            newent.isactor = 0;
            newent.entity = destructables[i];
            newent.damagecenter = entpos;
            ents[ents.size] = newent;
        }
    }
    dogs = [[ level.dogmanagerongetdogs ]]();
    if (isdefined(dogs)) {
        foreach (dog in dogs) {
            if (!isalive(dog)) {
                continue;
            }
            entpos = dog.origin;
            distsq = distancesquared(pos, entpos);
            if (!dolos || distsq < radius * radius && damage_trace_passed(pos, entpos, startradius, dog)) {
                newent = spawnstruct();
                newent.isplayer = 0;
                newent.isadestructable = 0;
                newent.isadestructible = 0;
                newent.isactor = 1;
                newent.entity = dog;
                newent.damagecenter = entpos;
                ents[ents.size] = newent;
            }
        }
    }
    return ents;
}

// Namespace weapons/weapons
// Params 4, eflags: 0x0
// Checksum 0x3c6a085f, Offset: 0x3ef8
// Size: 0x62
function damage_trace_passed(from, to, startradius, ignore) {
    trace = damage_trace(from, to, startradius, ignore);
    return trace["fraction"] == 1;
}

// Namespace weapons/weapons
// Params 4, eflags: 0x0
// Checksum 0x269ca4ad, Offset: 0x3f68
// Size: 0x1e0
function damage_trace(from, to, startradius, ignore) {
    midpos = undefined;
    diff = to - from;
    if (lengthsquared(diff) < startradius * startradius) {
        midpos = to;
    }
    dir = vectornormalize(diff);
    midpos = from + (dir[0] * startradius, dir[1] * startradius, dir[2] * startradius);
    trace = bullettrace(midpos, to, 0, ignore);
    if (getdvarint("scr_damage_debug") != 0) {
        if (trace["fraction"] == 1) {
            thread debugline(midpos, to, (1, 1, 1));
        } else {
            thread debugline(midpos, trace["position"], (1, 0.9, 0.8));
            thread debugline(trace["position"], to, (1, 0.4, 0.3));
        }
    }
    return trace;
}

// Namespace weapons/weapons
// Params 7, eflags: 0x0
// Checksum 0xb0f7ec9c, Offset: 0x4150
// Size: 0x1b4
function damage_ent(einflictor, eattacker, idamage, smeansofdeath, weapon, damagepos, damagedir) {
    if (self.isplayer) {
        self.damageorigin = damagepos;
        self.entity thread [[ level.callbackplayerdamage ]](einflictor, eattacker, idamage, 0, smeansofdeath, weapon, damagepos, damagedir, "none", damagepos, 0, 0, undefined);
        return;
    }
    if (self.isactor) {
        self.damageorigin = damagepos;
        self.entity thread [[ level.callbackactordamage ]](einflictor, eattacker, idamage, 0, smeansofdeath, weapon, damagepos, damagedir, "none", damagepos, 0, 0, 0, 0, (1, 0, 0));
        return;
    }
    if (self.isadestructible) {
        self.damageorigin = damagepos;
        self.entity dodamage(idamage, damagepos, eattacker, einflictor, 0, smeansofdeath, 0, weapon);
        return;
    }
    self.entity util::damage_notify_wrapper(idamage, eattacker, (0, 0, 0), (0, 0, 0), "mod_explosive", "", "");
}

// Namespace weapons/weapons
// Params 3, eflags: 0x0
// Checksum 0xa55fd8ff, Offset: 0x4310
// Size: 0x6c
function debugline(a, b, color) {
    /#
        for (i = 0; i < 600; i++) {
            line(a, b, color);
            waitframe(1);
        }
    #/
}

// Namespace weapons/weapons
// Params 5, eflags: 0x0
// Checksum 0x8baa501c, Offset: 0x4388
// Size: 0x27a
function on_damage(eattacker, einflictor, weapon, meansofdeath, damage) {
    self endon(#"death");
    self endon(#"disconnect");
    if (isdefined(level._custom_weapon_damage_func)) {
        is_weapon_registered = self [[ level._custom_weapon_damage_func ]](eattacker, einflictor, weapon, meansofdeath, damage);
        if (is_weapon_registered) {
            return;
        }
    }
    switch (weapon.rootweapon.name) {
    case #"concussion_grenade":
        radius = weapon.explosionradius;
        if (self == eattacker) {
            radius *= 0.5;
        }
        scale = 1 - distance(self.origin, einflictor.origin) / radius;
        if (scale < 0) {
            scale = 0;
        }
        time = 0.25 + 4 * scale;
        waitframe(1);
        if (meansofdeath != "MOD_IMPACT") {
            if (self hasperk("specialty_stunprotection")) {
                time *= 0.1;
            } else if (self util::mayapplyscreeneffect()) {
                self shellshock("concussion_grenade_mp", time, 0);
            }
            self thread play_concussion_sound(time);
            self.concussionendtime = gettime() + time * 1000;
            self.lastconcussedby = eattacker;
        }
        break;
    default:
        if (isdefined(level.shellshockonplayerdamage)) {
            [[ level.shellshockonplayerdamage ]](meansofdeath, damage, weapon);
        }
        break;
    }
}

// Namespace weapons/weapons
// Params 1, eflags: 0x0
// Checksum 0x8521ee65, Offset: 0x4610
// Size: 0x164
function play_concussion_sound(duration) {
    self endon(#"death");
    self endon(#"disconnect");
    concussionsound = spawn("script_origin", (0, 0, 1));
    concussionsound.origin = self.origin;
    concussionsound linkto(self);
    concussionsound thread delete_ent_on_owner_death(self);
    concussionsound playsound("");
    concussionsound playloopsound("");
    if (duration > 0.5) {
        wait duration - 0.5;
    }
    concussionsound playsound("");
    concussionsound stoploopsound(0.5);
    wait 0.5;
    concussionsound notify(#"delete");
    concussionsound delete();
}

// Namespace weapons/weapons
// Params 1, eflags: 0x0
// Checksum 0x3a7ce7ed, Offset: 0x4780
// Size: 0x3c
function delete_ent_on_owner_death(owner) {
    self endon(#"delete");
    owner waittill("death");
    self delete();
}

// Namespace weapons/weapons
// Params 0, eflags: 0x0
// Checksum 0x6b8849df, Offset: 0x47c8
// Size: 0x398
function function_43de9900() {
    self endon(#"spawned");
    self endon(#"killed_player");
    self endon(#"disconnect");
    self.tag_stowed_back = undefined;
    self.tag_stowed_hip = undefined;
    team = self.pers["team"];
    playerclass = self.pers["class"];
    while (true) {
        waitresult = self waittill("weapon_change");
        if (self ismantling()) {
            continue;
        }
        currentstowed = self getstowedweapon();
        hasstowed = 0;
        self.weapon_array_primary = [];
        self.weapon_array_sidearm = [];
        self.weapon_array_grenade = [];
        self.weapon_array_inventory = [];
        weaponslist = self getweaponslist();
        for (idx = 0; idx < weaponslist.size; idx++) {
            switch (weaponslist[idx].name) {
            case #"m32":
            case #"minigun":
                continue;
            default:
                break;
            }
            if (!hasstowed || currentstowed == weaponslist[idx]) {
                currentstowed = weaponslist[idx];
                hasstowed = 1;
            }
            if (is_primary_weapon(weaponslist[idx])) {
                self.weapon_array_primary[self.weapon_array_primary.size] = weaponslist[idx];
                continue;
            }
            if (is_side_arm(weaponslist[idx])) {
                self.weapon_array_sidearm[self.weapon_array_sidearm.size] = weaponslist[idx];
                continue;
            }
            if (is_grenade(weaponslist[idx])) {
                self.weapon_array_grenade[self.weapon_array_grenade.size] = weaponslist[idx];
                continue;
            }
            if (is_inventory(weaponslist[idx])) {
                self.weapon_array_inventory[self.weapon_array_inventory.size] = weaponslist[idx];
                continue;
            }
            if (weaponslist[idx].isprimary) {
                self.weapon_array_primary[self.weapon_array_primary.size] = weaponslist[idx];
            }
        }
        if (waitresult.weapon != level.weaponnone || !hasstowed) {
            detach_all_weapons();
            stow_on_back();
            stow_on_hip();
        }
    }
}

// Namespace weapons/weapons
// Params 1, eflags: 0x0
// Checksum 0x310a0646, Offset: 0x4b68
// Size: 0xf6
function function_64df9f6e(stat) {
    if (isdefined(level.givecustomloadout)) {
        return level.weaponnone;
    }
    assert(isdefined(self.class_num));
    if (isdefined(self.class_num)) {
        index = self loadout::getloadoutitemfromddlstats(self.class_num, stat);
        if (isdefined(level.tbl_weaponids[index]) && isdefined(level.tbl_weaponids[index]["reference"])) {
            return getweapon(level.tbl_weaponids[index]["reference"]);
        }
    }
    return level.weaponnone;
}

// Namespace weapons/weapons
// Params 1, eflags: 0x0
// Checksum 0xb467e2bc, Offset: 0x4c68
// Size: 0x8c
function loadout_get_offhand_count(stat) {
    count = 0;
    if (isdefined(level.givecustomloadout)) {
        return 0;
    }
    assert(isdefined(self.class_num));
    if (isdefined(self.class_num)) {
        count = self loadout::getloadoutitemfromddlstats(self.class_num, stat);
    }
    return count;
}

// Namespace weapons/weapons
// Params 0, eflags: 0x0
// Checksum 0xc3505cdb, Offset: 0x4d00
// Size: 0x50
function flash_scavenger_icon() {
    self.scavenger_icon.alpha = 1;
    self.scavenger_icon fadeovertime(1);
    self.scavenger_icon.alpha = 0;
}

// Namespace weapons/weapons
// Params 0, eflags: 0x0
// Checksum 0xbf808673, Offset: 0x4d58
// Size: 0x582
function scavenger_think() {
    self endon(#"death");
    waitresult = self waittill("scavenger");
    player = waitresult.player;
    primary_weapons = player getweaponslistprimaries();
    offhand_weapons_and_alts = array::exclude(player getweaponslist(1), primary_weapons);
    arrayremovevalue(offhand_weapons_and_alts, level.weaponbasemelee);
    offhand_weapons_and_alts = array::reverse(offhand_weapons_and_alts);
    player playsound("wpn_ammo_pickup");
    player playlocalsound("wpn_ammo_pickup");
    player flash_scavenger_icon();
    for (i = 0; i < offhand_weapons_and_alts.size; i++) {
        weapon = offhand_weapons_and_alts[i];
        if (!weapon.isscavengable || killstreaks::is_killstreak_weapon(weapon)) {
            continue;
        }
        maxammo = 0;
        if (weapon == player.grenadetypeprimary && isdefined(player.grenadetypeprimarycount) && player.grenadetypeprimarycount > 0) {
            maxammo = player.grenadetypeprimarycount;
        } else if (weapon == player.grenadetypesecondary && isdefined(player.grenadetypesecondarycount) && player.grenadetypesecondarycount > 0) {
            maxammo = player.grenadetypesecondarycount;
        }
        if (isdefined(level.customloasdoutscavenge)) {
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
        if (stock < maxammo) {
            ammo = stock + 1;
            if (ammo > maxammo) {
                ammo = maxammo;
            }
            player setweaponammostock(weapon, ammo);
            player.scavenged = 1;
            player thread challenges::scavengedgrenade();
            continue;
        }
        if (weapon.rootweapon == getweapon("trophy_system")) {
            player trophy_system::ammo_scavenger(weapon);
        }
    }
    for (i = 0; i < primary_weapons.size; i++) {
        weapon = primary_weapons[i];
        if (!weapon.isscavengable || killstreaks::is_killstreak_weapon(weapon)) {
            continue;
        }
        stock = player getweaponammostock(weapon);
        start = player getfractionstartammo(weapon);
        clip = weapon.clipsize;
        clip *= getdvarfloat("scavenger_clip_multiplier", 1);
        clip = int(clip);
        maxammo = weapon.maxammo;
        if (stock < maxammo - clip) {
            ammo = stock + clip;
            player setweaponammostock(weapon, ammo);
            player.scavenged = 1;
            continue;
        }
        player setweaponammostock(weapon, maxammo);
        player.scavenged = 1;
    }
}

// Namespace weapons/weapons
// Params 0, eflags: 0x0
// Checksum 0xb0927830, Offset: 0x52e8
// Size: 0x3c
function function_e5ed7d9b() {
    self waittill("disconnect");
    if (isdefined(self.scavenger_icon)) {
        self.scavenger_icon destroy();
    }
}

// Namespace weapons/weapons
// Params 0, eflags: 0x0
// Checksum 0xf9e42ccc, Offset: 0x5330
// Size: 0x1a4
function scavenger_hud_create() {
    if (level.wagermatch) {
        return;
    }
    if (isdefined(level.var_8cc5e3c) && level.var_8cc5e3c) {
        return;
    }
    self.scavenger_icon = newclienthudelem(self);
    if (isdefined(self.scavenger_icon)) {
        self thread function_e5ed7d9b();
        self.scavenger_icon.horzalign = "center";
        self.scavenger_icon.vertalign = "middle";
        self.scavenger_icon.alpha = 0;
        width = 64;
        height = 64;
        if (level.splitscreen) {
            width = int(width * 0.5);
            height = int(height * 0.5);
        }
        self.scavenger_icon.x = width * -1 / 2;
        self.scavenger_icon.y = 16;
        self.scavenger_icon setshader("hud_scavenger_pickup", width, height);
    }
}

// Namespace weapons/weapons
// Params 1, eflags: 0x0
// Checksum 0x59eaec9d, Offset: 0x54e0
// Size: 0xf4
function drop_scavenger_for_death(attacker) {
    if (level.wagermatch) {
        return;
    }
    if (!isdefined(attacker)) {
        return;
    }
    if (attacker == self) {
        return;
    }
    if (level.gametype == "hack") {
        item = self dropscavengeritem(getweapon("scavenger_item_hack"));
    } else if (isplayer(attacker)) {
        item = self dropscavengeritem(getweapon("scavenger_item"));
    } else {
        return;
    }
    item thread scavenger_think();
}

// Namespace weapons/weapons
// Params 3, eflags: 0x0
// Checksum 0x7bc39683, Offset: 0x55e0
// Size: 0x74
function add_limited_weapon(weapon, owner, num_drops) {
    limited_info = spawnstruct();
    limited_info.weapon = weapon;
    limited_info.drops = num_drops;
    owner.limited_info = limited_info;
}

// Namespace weapons/weapons
// Params 2, eflags: 0x0
// Checksum 0xc5510eac, Offset: 0x5660
// Size: 0x7a
function should_drop_limited_weapon(weapon, owner) {
    limited_info = owner.limited_info;
    if (!isdefined(limited_info)) {
        return true;
    }
    if (limited_info.weapon != weapon) {
        return true;
    }
    if (limited_info.drops <= 0) {
        return false;
    }
    return true;
}

// Namespace weapons/weapons
// Params 3, eflags: 0x0
// Checksum 0x3fcb6fc1, Offset: 0x56e8
// Size: 0xac
function drop_limited_weapon(weapon, owner, item) {
    limited_info = owner.limited_info;
    if (!isdefined(limited_info)) {
        return;
    }
    if (limited_info.weapon != weapon) {
        return;
    }
    limited_info.drops -= 1;
    owner.limited_info = undefined;
    item thread limited_pickup(limited_info);
}

// Namespace weapons/weapons
// Params 1, eflags: 0x0
// Checksum 0xb99505ad, Offset: 0x57a0
// Size: 0x60
function limited_pickup(limited_info) {
    self endon(#"death");
    waitresult = self waittill("trigger");
    if (!isdefined(waitresult.dropped_item)) {
        return;
    }
    waitresult.activator.limited_info = limited_info;
}

// Namespace weapons/weapons
// Params 3, eflags: 0x0
// Checksum 0x49a2a7a4, Offset: 0x5808
// Size: 0x8c
function track_cooked_detonation(attacker, weapon, cooktime) {
    self endon(#"trophy_destroyed");
    waitresult = self waittill("explode");
    if (weapon.rootweapon == level.weaponflashgrenade) {
        level thread ninebang_doninebang(attacker, weapon, waitresult.position, cooktime);
    }
}

// Namespace weapons/weapons
// Params 4, eflags: 0x0
// Checksum 0x3499caa2, Offset: 0x58a0
// Size: 0x4ce
function ninebang_doninebang(attacker, weapon, pos, cooktime) {
    level endon(#"game_ended");
    maxstages = 4;
    maxradius = 20;
    mindelay = 0.15;
    maxdelay = 0.3;
    var_eeebdaf4 = weapon.explosionradius * weapon.explosionradius;
    var_1fbec830 = weapon.explosioninnerradius * weapon.explosioninnerradius;
    cookstages = cooktime / weapon.cookoffholdtime * maxstages + 1;
    var_b7bc3121 = 0;
    if (cookstages < 2) {
        return;
    } else if (cookstages < 3) {
        var_b7bc3121 = 3;
    } else if (cookstages < 4) {
        var_b7bc3121 = 6;
    } else {
        var_b7bc3121 = 9;
    }
    wait randomfloatrange(mindelay, maxdelay);
    for (i = 1; i < var_b7bc3121; i++) {
        newpos = level function_3bb8b559(pos, maxradius);
        playsoundatposition("wpn_flash_grenade_explode", newpos);
        playfx(level._effect["flashNineBang"], newpos);
        closestplayers = arraysort(level.players, newpos, 1);
        foreach (player in closestplayers) {
            if (!isdefined(player) || !isalive(player)) {
                continue;
            }
            if (player.sessionstate != "playing") {
                continue;
            }
            vieworigin = player geteye();
            dist = distancesquared(pos, vieworigin);
            if (dist > var_eeebdaf4) {
                break;
            }
            if (!bullettracepassed(pos, vieworigin, 0, player)) {
                continue;
            }
            if (dist <= var_1fbec830) {
                var_be1937a = 1;
            } else {
                var_be1937a = 1 - (dist - var_1fbec830) / (var_eeebdaf4 - var_1fbec830);
            }
            forward = anglestoforward(player getplayerangles());
            var_57060e68 = pos - vieworigin;
            var_57060e68 = vectornormalize(var_57060e68);
            var_49317b64 = 0.5 * (1 + vectordot(forward, var_57060e68));
            player notify(#"flashbang", {#distance:var_be1937a, #angle:var_49317b64, #attacker:attacker});
        }
        wait randomfloatrange(mindelay, maxdelay);
    }
}

// Namespace weapons/weapons
// Params 2, eflags: 0x0
// Checksum 0x732c7fe5, Offset: 0x5d78
// Size: 0xb0
function function_3bb8b559(startpos, range) {
    offset = (randomfloatrange(-1 * range, range), randomfloatrange(-1 * range, range), 0);
    newpos = startpos + offset;
    if (bullettracepassed(startpos, newpos, 0, undefined)) {
        return newpos;
    }
    return startpos;
}

// Namespace weapons/weapons
// Params 3, eflags: 0x0
// Checksum 0x6c9857ed, Offset: 0x5e30
// Size: 0x14e
function function_3a93d5a6(player, weapon, position) {
    var_ba3e6d6e = 512;
    radiussq = var_ba3e6d6e * var_ba3e6d6e;
    playsoundatposition("wpn_emp_explode", position);
    level empgrenade::empexplosiondamageents(player, weapon, position, var_ba3e6d6e, 0);
    foreach (targetent in level.players) {
        if (function_4c3bee5(targetent, position, radiussq, 0, 0)) {
            targetent notify(#"emp_grenaded", {#attacker:player, #position:position});
        }
    }
}

// Namespace weapons/weapons
// Params 5, eflags: 0x0
// Checksum 0x4d555fea, Offset: 0x5f88
// Size: 0xaa
function function_4c3bee5(ent, pos, radiussq, dolos, startradius) {
    entpos = ent.origin;
    distsq = distancesquared(pos, entpos);
    return !dolos || distsq < radiussq && weapondamagetracepassed(pos, entpos, startradius, ent);
}

// Namespace weapons/weapons
// Params 3, eflags: 0x0
// Checksum 0xf73692b3, Offset: 0x6040
// Size: 0x18e
function track_multi_detonation(ownerent, weapon, cooktime) {
    self endon(#"trophy_destroyed");
    waitresult = self waittill("explode");
    if (weapon.rootweapon == getweapon("frag_grenade_grenade")) {
        for (i = 0; i < weapon.multidetonation; i++) {
            if (!isdefined(ownerent)) {
                return;
            }
            var_69063516 = getweapon("frag_multi_blast");
            dir = level multi_detonation_get_cluster_launch_dir(i, weapon.multidetonation);
            vel = dir * var_69063516.multidetonationfragmentspeed;
            fusetime = var_69063516.fusetime / 1000;
            grenade = ownerent magicgrenadetype(var_69063516, waitresult.position, vel, fusetime);
            util::wait_network_frame();
        }
    }
}

// Namespace weapons/weapons
// Params 2, eflags: 0x0
// Checksum 0x641fe149, Offset: 0x61d8
// Size: 0x8c
function multi_detonation_get_cluster_launch_dir(index, multival) {
    pitch = 45;
    yaw = -180 + 360 / multival * index;
    angles = (pitch, yaw, 45);
    dir = anglestoforward(angles);
    return dir;
}

