#using scripts\core_common\array_shared;
#using scripts\core_common\bb_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\challenges_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\debug_shared;
#using scripts\core_common\gameobjects_shared;
#using scripts\core_common\hud_shared;
#using scripts\core_common\laststand_shared;
#using scripts\core_common\loadout_shared;
#using scripts\core_common\player\player_loadout;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\scoreevents_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\weapons_shared;
#using scripts\killstreaks\killstreaks_util;
#using scripts\weapons\riotshield;
#using scripts\weapons\tabun;
#using scripts\weapons\trophy_system;
#using scripts\weapons\weaponobjects;

#namespace weapons;

// Namespace weapons/weapons
// Params 0, eflags: 0x0
// Checksum 0xfe7b8af1, Offset: 0x218
// Size: 0x26e
function init_shared() {
    level.weaponnone = getweapon(#"none");
    level.weaponnull = getweapon(#"weapon_null");
    level.weaponbasemelee = getweapon(#"knife");
    level.weaponbasemeleeheld = getweapon(#"knife_held");
    level.weaponballisticknife = getweapon(#"hash_28987b4cc8577bea");
    level.weaponriotshield = getweapon(#"riotshield");
    level.weaponflashgrenade = getweapon(#"flash_grenade");
    level.weaponsatchelcharge = getweapon(#"satchel_charge");
    level.var_35aeafd6 = getweapon(#"hash_5a7fd1af4a1d5c9");
    level.var_aac1d977 = getweapon(#"hash_31be8125c7d0f273");
    level.var_8ec54942 = getweapon(#"null_offhand_primary");
    level.var_439614d2 = getweapon(#"null_offhand_secondary");
    if (!isdefined(level.trackweaponstats)) {
        level.trackweaponstats = 1;
    }
    level._effect[#"flashninebang"] = #"_t6/misc/fx_equip_tac_insert_exp";
    callback::on_start_gametype(&init);
    level.detach_all_weapons = &detach_all_weapons;
}

// Namespace weapons/weapons
// Params 0, eflags: 0x0
// Checksum 0xf40fb7d8, Offset: 0x490
// Size: 0xe4
function init() {
    level.missileentities = [];
    level.hackertooltargets = [];
    level.var_28301021 = [];
    level.missileduddeletedelay = getdvarint(#"scr_missileduddeletedelay", 3);
    if (!isdefined(level.roundstartexplosivedelay)) {
        level.roundstartexplosivedelay = 0;
    }
    clientfield::register("clientuimodel", "hudItems.pickupHintWeaponIndex", 1, 10, "int");
    callback::on_connect(&on_player_connect);
    callback::on_spawned(&on_player_spawned);
}

// Namespace weapons/weapons
// Params 0, eflags: 0x0
// Checksum 0x776285fa, Offset: 0x580
// Size: 0x5c
function on_player_connect() {
    self.usedweapons = 0;
    self.lastfiretime = 0;
    self.hits = 0;
    if (isdefined(level.var_2cff5def) && level.var_2cff5def) {
        function_58615b2b(self);
    }
}

// Namespace weapons/weapons
// Params 0, eflags: 0x0
// Checksum 0x6f077e5e, Offset: 0x5e8
// Size: 0x254
function on_player_spawned() {
    self.concussionendtime = 0;
    self.scavenged = 0;
    self.hasdonecombat = 0;
    self.shielddamageblocked = 0;
    self.usedkillstreakweapon = [];
    self.usedkillstreakweapon[#"minigun"] = 0;
    self.usedkillstreakweapon[#"m32"] = 0;
    self.usedkillstreakweapon[#"m202_flash"] = 0;
    self.usedkillstreakweapon[#"m220_tow"] = 0;
    self.usedkillstreakweapon[#"mp40_blinged"] = 0;
    self.killstreaktype = [];
    self.killstreaktype[#"minigun"] = "minigun";
    self.killstreaktype[#"m32"] = "m32";
    self.killstreaktype[#"m202_flash"] = "m202_flash";
    self.killstreaktype[#"m220_tow"] = "m220_tow";
    self.killstreaktype[#"mp40_blinged"] = "mp40_blinged_drop";
    self.throwinggrenade = 0;
    self.gotpullbacknotify = 0;
    self.lastdroppableweapon = self getcurrentweapon();
    self.lastweaponchange = 0;
    self.droppeddeathweapon = undefined;
    self.tookweaponfrom = [];
    self.pickedupweaponkills = [];
    self.tag_stowed_back = undefined;
    self.tag_stowed_hip = undefined;
    self callback::on_death(&on_death);
    self callback::on_weapon_change(&on_weapon_change);
    self callback::on_grenade_fired(&on_grenade_fired);
    self callback::function_e108345d(&function_e108345d);
}

// Namespace weapons/weapons
// Params 1, eflags: 0x0
// Checksum 0x554fb75b, Offset: 0x848
// Size: 0x114
function function_58615b2b(player) {
    assert(isplayer(player));
    player.var_6ce15d2b = gameobjects::get_next_obj_id();
    objective_add(player.var_6ce15d2b, "invisible", player.origin, #"weapon_pickup");
    objective_setprogress(player.var_6ce15d2b, 0);
    objective_setinvisibletoall(player.var_6ce15d2b);
    objective_setvisibletoplayer(player.var_6ce15d2b, player);
    player thread function_96f00f13();
    player thread function_57b6204d();
}

// Namespace weapons/weapon_change
// Params 1, eflags: 0x40
// Checksum 0x3f0024a2, Offset: 0x968
// Size: 0xf4
function event_handler[weapon_change] function_42839d6(eventstruct) {
    if (!isplayer(self)) {
        return;
    }
    newweapon = eventstruct.weapon;
    if (may_drop(newweapon)) {
        self.lastdroppableweapon = newweapon;
        self.lastweaponchange = gettime();
    }
    if (!isdefined(self.spawnweapon)) {
        self.spawnweapon = newweapon;
    }
    if (doesweaponreplacespawnweapon(self.spawnweapon, newweapon)) {
        self.spawnweapon = newweapon;
        self.pers[#"spawnweapon"] = newweapon;
    }
    self callback::callback(#"weapon_change", eventstruct);
}

// Namespace weapons/weapons
// Params 1, eflags: 0x0
// Checksum 0x49e5d564, Offset: 0xa68
// Size: 0x12a
function may_drop(weapon) {
    if (weapon == level.weaponnone) {
        return false;
    }
    if (isdefined(level.laststandpistol) && weapon == level.laststandpistol) {
        return false;
    }
    if (isdefined(level.var_dfddf378)) {
        foreach (var_7a0a6b18 in level.var_dfddf378) {
            if (var_7a0a6b18 == weapon) {
                return false;
            }
        }
    }
    if (killstreaks::is_killstreak_weapon(weapon)) {
        return false;
    }
    if (weapon.iscarriedkillstreak) {
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
// Params 0, eflags: 0x0
// Checksum 0xaba075bf, Offset: 0xba0
// Size: 0x8e
function function_e1402f41() {
    last_weapon = undefined;
    if (isdefined(self.lastnonkillstreakweapon) && self hasweapon(self.lastnonkillstreakweapon)) {
        last_weapon = self.lastnonkillstreakweapon;
    } else if (isdefined(self.lastdroppableweapon) && self hasweapon(self.lastdroppableweapon)) {
        last_weapon = self.lastdroppableweapon;
    }
    return last_weapon;
}

// Namespace weapons/weapons
// Params 1, eflags: 0x0
// Checksum 0x5f49a47f, Offset: 0xc38
// Size: 0x4e
function function_b95d0c47(last_weapon) {
    if (!isdefined(last_weapon)) {
        return false;
    }
    if (!self hasweapon(last_weapon)) {
        return false;
    }
    if (!may_drop(last_weapon)) {
        return false;
    }
    return true;
}

// Namespace weapons/weapons
// Params 3, eflags: 0x0
// Checksum 0x1eaf0368, Offset: 0xc90
// Size: 0x394
function function_3c7b37f2(last_weapon = undefined, immediate = 0, awayfromball = 0) {
    ball = getweapon(#"ball");
    if (isdefined(ball) && self hasweapon(ball) && !(isdefined(awayfromball) && awayfromball)) {
        self switchtoweaponimmediate(ball);
        self disableweaponcycling();
        self disableoffhandweapons();
        return;
    } else if (self laststand::player_is_in_laststand()) {
        if (isdefined(self.laststandpistol) && self hasweapon(self.laststandpistol)) {
            self switchtoweapon(self.laststandpistol);
            return;
        }
    } else {
        to_weapon = undefined;
        if (function_b95d0c47(last_weapon)) {
            to_weapon = last_weapon;
        }
        if (!isdefined(to_weapon)) {
            to_weapon = function_e1402f41();
        }
        if (isdefined(to_weapon)) {
            if (to_weapon.isheavyweapon) {
                if (to_weapon.gadget_heroversion_2_0) {
                    if (to_weapon.isgadget && self getammocount(to_weapon) > 0) {
                        slot = self gadgetgetslot(to_weapon);
                        if (self util::gadget_is_in_use(slot)) {
                            if (isdefined(immediate) && immediate) {
                                self switchtoweaponimmediate(to_weapon);
                                return;
                            }
                            self switchtoweapon(to_weapon);
                            return;
                        }
                    }
                } else if (self getammocount(to_weapon) > 0) {
                    if (isdefined(immediate) && immediate) {
                        self switchtoweaponimmediate(to_weapon);
                        return;
                    }
                    self switchtoweapon(to_weapon);
                    return;
                }
            } else if (self getammocount(to_weapon) > 0 || to_weapon.ismeleeweapon) {
                if (isdefined(immediate) && immediate) {
                    self switchtoweaponimmediate(to_weapon);
                    return;
                }
                self switchtoweapon(to_weapon);
                return;
            }
        }
    }
    if (isdefined(immediate) && immediate) {
        self switchtoweaponimmediate();
        return;
    }
    self switchtoweapon();
}

// Namespace weapons/weapons
// Params 1, eflags: 0x0
// Checksum 0xdd971625, Offset: 0x1030
// Size: 0xf2
function update_last_held_weapon_timings(newtime) {
    if (isdefined(self.currentweapon) && isdefined(self.currentweaponstarttime)) {
        totaltime = int(float(newtime - self.currentweaponstarttime) / 1000);
        if (totaltime > 0) {
            weaponpickedup = 0;
            if (isdefined(self.pickedupweapons) && isdefined(self.pickedupweapons[self.currentweapon])) {
                weaponpickedup = 1;
            }
            self stats::function_c8a05f4f(self.currentweapon, #"timeused", totaltime, self.class_num, weaponpickedup);
            self.currentweaponstarttime = newtime;
        }
    }
}

// Namespace weapons/weapons
// Params 1, eflags: 0x0
// Checksum 0x7bffbc54, Offset: 0x1130
// Size: 0x3e8
function update_timings(newtime) {
    if (isbot(self)) {
        return;
    }
    update_last_held_weapon_timings(newtime);
    if (!isdefined(self.staticweaponsstarttime)) {
        return;
    }
    totaltime = int(float(newtime - self.staticweaponsstarttime) / 1000);
    if (totaltime < 0) {
        return;
    }
    self.staticweaponsstarttime = newtime;
    if (isdefined(self.weapon_array_grenade)) {
        for (i = 0; i < self.weapon_array_grenade.size; i++) {
            self stats::function_c8a05f4f(self.weapon_array_grenade[i], #"timeused", totaltime, self.class_num);
        }
    }
    if (isdefined(self.weapon_array_inventory)) {
        for (i = 0; i < self.weapon_array_inventory.size; i++) {
            self stats::function_c8a05f4f(self.weapon_array_inventory[i], #"timeused", totaltime, self.class_num);
        }
    }
    if (isdefined(self.killstreak)) {
        for (i = 0; i < self.killstreak.size; i++) {
            killstreaktype = level.menureferenceforkillstreak[self.killstreak[i]];
            if (isdefined(killstreaktype)) {
                killstreakweapon = killstreaks::get_killstreak_weapon(killstreaktype);
                self stats::function_c8a05f4f(killstreakweapon, #"timeused", totaltime, self.class_num);
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
            foreach (k, v in perksindexarray) {
                if (v == 1 && k >= 0) {
                    self stats::inc_stat(#"itemstats", k, #"stats", #"timeused", #"statvalue", totaltime);
                }
            }
        }
    }
}

// Namespace weapons/weapons
// Params 1, eflags: 0x0
// Checksum 0xbe9fdb1, Offset: 0x1520
// Size: 0x9c
function on_death(params) {
    if (game.state == "playing" && level.trackweaponstats) {
        if (!isdefined(self.var_d99169dd)) {
            self.var_d99169dd = gettime();
        }
        self bb::commit_weapon_data(getplayerspawnid(self), self getcurrentweapon(), self.var_d99169dd);
        update_timings(gettime());
    }
}

// Namespace weapons/weapons
// Params 4, eflags: 0x0
// Checksum 0x9ee7f831, Offset: 0x15c8
// Size: 0x4f4
function drop_for_death(attacker, sweapon, smeansofdeath, var_ba359e10 = 1) {
    if (level.disableweapondrop == 1) {
        return;
    }
    weapon = self.lastdroppableweapon;
    if (isdefined(self.droppeddeathweapon)) {
        return;
    }
    if (!isdefined(weapon)) {
        /#
            if (getdvarint(#"scr_dropdebug", 0) == 1) {
                println("<dev string:x30>");
            }
        #/
        return;
    }
    if (weapon == level.weaponnone) {
        /#
            if (getdvarint(#"scr_dropdebug", 0) == 1) {
                println("<dev string:x50>");
            }
        #/
        return;
    }
    if (!self hasweapon(weapon)) {
        /#
            if (getdvarint(#"scr_dropdebug", 0) == 1) {
                println("<dev string:x73>" + weapon.name + "<dev string:x9f>");
            }
        #/
        return;
    }
    if (!self anyammoforweaponmodes(weapon)) {
        /#
            if (getdvarint(#"scr_dropdebug", 0) == 1) {
                println("<dev string:xa1>");
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
            if (getdvarint(#"scr_dropdebug", 0) == 1) {
                println("<dev string:xce>");
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
            iprintlnbold("<dev string:xea>" + weapon.name);
        #/
        return;
    }
    /#
        if (getdvarint(#"scr_dropdebug", 0) == 1) {
            println("<dev string:x111>" + weapon.name);
        }
    #/
    drop_limited_weapon(weapon, self, item);
    self.droppeddeathweapon = 1;
    if (var_ba359e10) {
        item itemweaponsetammo(clipammo, stockammo);
    }
    item.owner = self;
    item.ownersattacker = attacker;
    item.sweapon = sweapon;
    item.smeansofdeath = smeansofdeath;
    if (isdefined(level.var_2cff5def) && level.var_2cff5def) {
        arrayremovevalue(level.var_28301021, undefined);
        array::add(level.var_28301021, item, 0);
    }
    item thread watch_pickup();
    item thread delete_pickup_after_awhile();
}

// Namespace weapons/weapons
// Params 0, eflags: 0x0
// Checksum 0x1d10942f, Offset: 0x1ac8
// Size: 0x5c
function function_96f00f13() {
    self waittill(#"disconnect", #"game_ended");
    gameobjects::release_obj_id(self.var_6ce15d2b);
    objective_delete(self.var_6ce15d2b);
}

// Namespace weapons/weapons
// Params 0, eflags: 0x0
// Checksum 0x8f1975b2, Offset: 0x1b30
// Size: 0xa6
function function_57b6204d() {
    level endon(#"game_ended");
    self endon(#"disconnect");
    self notify("76cde118ab7127c2");
    self endon("76cde118ab7127c2");
    self waittill(#"spawned_player");
    while (true) {
        function_a8bef2fb(self.origin, self getplayerangles());
        waitframe(1);
    }
}

// Namespace weapons/weapons
// Params 2, eflags: 0x0
// Checksum 0x6ef5d498, Offset: 0x1be0
// Size: 0x244
function function_a8bef2fb(origin, angles) {
    maxdist = util::function_1a1c8e97();
    var_7193ce12 = 0;
    var_a582c9fe = self function_6cde7bd2();
    if (isdefined(var_a582c9fe)) {
        var_7193ce12 = distancesquared(origin, var_a582c9fe.origin) < maxdist * maxdist;
    }
    if (var_7193ce12) {
        objstate = 0;
        neardist = util::function_d27ced7f();
        if (neardist < maxdist && distancesquared(origin, var_a582c9fe.origin) > neardist * neardist) {
            objstate = 1;
        }
        objective_setstate(self.var_6ce15d2b, "active");
        objective_setposition(self.var_6ce15d2b, var_a582c9fe.origin);
        objective_setgamemodeflags(self.var_6ce15d2b, objstate);
        weaponindex = 0;
        if (isdefined(var_a582c9fe.item)) {
            weaponindex = isdefined(getbaseweaponitemindex(var_a582c9fe.item)) ? getbaseweaponitemindex(var_a582c9fe.item) : 0;
        }
        self clientfield::set_player_uimodel("hudItems.pickupHintWeaponIndex", weaponindex);
        return;
    }
    objective_setstate(self.var_6ce15d2b, "invisible");
    objective_setgamemodeflags(self.var_6ce15d2b, 0);
    self clientfield::set_player_uimodel("hudItems.pickupHintWeaponIndex", 0);
}

// Namespace weapons/weapons
// Params 0, eflags: 0x0
// Checksum 0x4b609221, Offset: 0x1e30
// Size: 0x5c
function delete_pickup_after_awhile() {
    self endon(#"death");
    wait 60;
    if (!isdefined(self)) {
        return;
    }
    arrayremovevalue(level.var_28301021, self);
    self delete();
}

// Namespace weapons/weapons
// Params 0, eflags: 0x0
// Checksum 0xede785e1, Offset: 0x1e98
// Size: 0x3c4
function watch_pickup() {
    self endon(#"death");
    weapon = self.item;
    waitresult = self waittill(#"trigger");
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
            if (!isdefined(player.pickedupweapons)) {
                player.pickedupweapons = [];
            }
            player.pickedupweapons[weapon] = 1;
        }
    }
    /#
        if (getdvarint(#"scr_dropdebug", 0) == 1) {
            println("<dev string:x122>" + weapon.name + "<dev string:x135>" + isdefined(self.ownersattacker));
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
            array::add(level.var_28301021, droppeditem[i], 0);
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

// Namespace weapons/weapon_fired
// Params 1, eflags: 0x40
// Checksum 0x7c39c1e8, Offset: 0x2268
// Size: 0x6c
function event_handler[weapon_fired] function_60811de3(eventstruct) {
    self callback::callback(#"weapon_fired", eventstruct);
    self callback::callback_weapon_fired(eventstruct.weapon);
    self function_ceb089fc(eventstruct.weapon);
}

// Namespace weapons/weapons
// Params 1, eflags: 0x0
// Checksum 0x4ef5cec0, Offset: 0x22e0
// Size: 0x1fa
function function_ceb089fc(curweapon) {
    if (!isplayer(self)) {
        return;
    }
    self.lastfiretime = gettime();
    self.hasdonecombat = 1;
    switch (curweapon.weapclass) {
    case #"smg":
    case #"pistol spread":
    case #"mg":
    case #"spread":
    case #"pistol":
    case #"rifle":
        self track_fire(curweapon);
        level.globalshotsfired++;
        break;
    case #"rocketlauncher":
    case #"grenade":
        self stats::function_c8a05f4f(curweapon, #"shots", 1, self.class_num, 0);
        break;
    default:
        break;
    }
    if (isdefined(curweapon.gadget_type) && curweapon.gadget_type == 11) {
        if (isdefined(self.heavyweaponshots)) {
            self.heavyweaponshots++;
        }
    }
    if (curweapon.iscarriedkillstreak) {
        if (isdefined(self.pers[#"held_killstreak_ammo_count"][curweapon])) {
            self.pers[#"held_killstreak_ammo_count"][curweapon]--;
        }
        self.usedkillstreakweapon[curweapon.name] = 1;
    }
}

// Namespace weapons/weapons
// Params 1, eflags: 0x0
// Checksum 0xf2b00843, Offset: 0x24e8
// Size: 0x26c
function track_fire(curweapon) {
    pixbeginevent(#"trackweaponfire");
    weaponpickedup = 0;
    if (isdefined(self.pickedupweapons) && isdefined(self.pickedupweapons[curweapon])) {
        weaponpickedup = 1;
    }
    self trackweaponfirenative(curweapon, 1, self.hits, 1, self.class_num, weaponpickedup);
    if (isdefined(self.totalmatchshots)) {
        self.totalmatchshots++;
    }
    if (isdefined(level.var_722f7267)) {
        [[ level.var_722f7267 ]](self, curweapon, #"shots", 1);
        [[ level.var_722f7267 ]](self, curweapon, #"hits", self.hits);
    }
    self bb::add_to_stat("shots", 1);
    self bb::add_to_stat("hits", self.hits);
    if (level.mpcustommatch === 1) {
        self.pers[#"shotsfired"]++;
        self.shotsfired = self.pers[#"shotsfired"];
        self.pers[#"shotshit"] = self.pers[#"shotshit"] + self.hits;
        self.shotshit = self.pers[#"shotshit"];
        self.pers[#"shotsmissed"] = self.shotsfired - self.shotshit;
        self.shotsmissed = self.pers[#"shotsmissed"];
    }
    self.hits = 0;
    pixendevent();
}

// Namespace weapons/grenade_pullback
// Params 1, eflags: 0x40
// Checksum 0x9e3836a6, Offset: 0x2760
// Size: 0xcc
function event_handler[grenade_pullback] function_9cc733d6(eventstruct) {
    if (!isplayer(self)) {
        return;
    }
    weapon = eventstruct.weapon;
    self stats::function_c8a05f4f(weapon, #"shots", 1, self.class_num);
    self.hasdonecombat = 1;
    self.throwinggrenade = 1;
    self.gotpullbacknotify = 1;
    self thread watch_offhand_end(weapon);
    self thread begin_grenade_tracking();
}

// Namespace weapons/missile_fire
// Params 1, eflags: 0x40
// Checksum 0x3bd9aea0, Offset: 0x2838
// Size: 0xfc
function event_handler[missile_fire] function_f71e5b4c(eventstruct) {
    if (!isplayer(self)) {
        return;
    }
    missile = eventstruct.projectile;
    weapon = eventstruct.weapon;
    var_36b8df9f = eventstruct.target;
    self.hasdonecombat = 1;
    if (isdefined(missile) && isdefined(level.missileentities)) {
        if (!isdefined(level.missileentities)) {
            level.missileentities = [];
        }
        level.missileentities[level.missileentities.size] = missile;
        missile.weapon = weapon;
        missile.var_36b8df9f = var_36b8df9f;
        missile thread watch_missile_death();
    }
}

// Namespace weapons/weapons
// Params 0, eflags: 0x0
// Checksum 0x4a33fa0e, Offset: 0x2940
// Size: 0x34
function watch_missile_death() {
    self waittill(#"death");
    arrayremovevalue(level.missileentities, self);
}

// Namespace weapons/weapons
// Params 2, eflags: 0x0
// Checksum 0x1a4851da, Offset: 0x2980
// Size: 0xfc
function drop_all_to_ground(origin, radius) {
    weapons = getdroppedweapons();
    for (i = 0; i < weapons.size; i++) {
        if (distancesquared(origin, weapons[i].origin) < radius * radius) {
            trace = bullettrace(weapons[i].origin, weapons[i].origin + (0, 0, -2000), 0, weapons[i]);
            weapons[i].origin = trace[#"position"];
        }
    }
}

// Namespace weapons/weapons
// Params 2, eflags: 0x0
// Checksum 0x2f519985, Offset: 0x2a88
// Size: 0xbe
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
// Checksum 0xadef8124, Offset: 0x2b50
// Size: 0xe6
function watch_grenade_cancel() {
    self endon(#"death");
    self endon(#"disconnect");
    self endon(#"grenade_fire");
    waittillframeend();
    while (true) {
        if (!isplayer(self)) {
            return;
        }
        if (self isthrowinggrenade()) {
            self waittill(#"weapon_change");
            continue;
        }
        if (self function_1b77f4ea()) {
            util::wait_network_frame();
            continue;
        }
        break;
    }
    self.throwinggrenade = 0;
    self.gotpullbacknotify = 0;
    self notify(#"grenade_throw_cancelled");
}

// Namespace weapons/weapons
// Params 1, eflags: 0x0
// Checksum 0xde5013a5, Offset: 0x2c40
// Size: 0x1b4
function watch_offhand_end(weapon) {
    self notify(#"watchoffhandend");
    self endon(#"watchoffhandend");
    if (weapon.drawoffhandmodelinhand) {
        self setoffhandvisible(1);
        while (self function_9b5200f(weapon)) {
            msg = self waittill(#"offhand_end", #"death", #"disconnect", #"grenade_fire", #"weapon_change");
            if (msg._notify == #"grenade_fire") {
                if (isdefined(weapon.var_84bc48b4) && weapon.var_84bc48b4 && self getweaponammoclip(weapon) > 0) {
                    continue;
                }
                break;
            }
            if (msg._notify == #"death" || msg._notify == #"disconnect" || msg._notify == #"offhand_end") {
                break;
            }
        }
        if (isdefined(self)) {
            self setoffhandvisible(0);
        }
    }
}

// Namespace weapons/weapons
// Params 1, eflags: 0x0
// Checksum 0x25eff308, Offset: 0x2e00
// Size: 0x66
function function_9b5200f(weapon) {
    currentweapon = self getcurrentoffhand();
    if (currentweapon == weapon && weapon.drawoffhandmodelinhand) {
        return self function_ff0e0865();
    }
    return 0;
}

// Namespace weapons/weapons
// Params 0, eflags: 0x0
// Checksum 0x7afffe17, Offset: 0x2e70
// Size: 0x534
function begin_grenade_tracking() {
    self notify(#"begin_grenade_tracking");
    self endon(#"begin_grenade_tracking");
    self endon(#"death");
    self endon(#"disconnect");
    self endon(#"grenade_throw_cancelled");
    starttime = gettime();
    self thread watch_grenade_cancel();
    waitresult = self waittill(#"grenade_fire");
    grenade = waitresult.projectile;
    weapon = waitresult.weapon;
    cooktime = waitresult.cook_time;
    grenade.originalowner = self;
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
    blackboxeventname = #"mpequipmentuses";
    eventname = #"hash_7cbbee88c5db5494";
    if (sessionmodeiscampaigngame()) {
        blackboxeventname = #"cpequipmentuses";
        eventname = #"hash_4b0d58055ad60c5a";
    } else if (sessionmodeiszombiesgame()) {
        blackboxeventname = #"zmequipmentuses";
        eventname = #"hash_637ce41bcec9842c";
    }
    function_b1f6086c(eventname, blackboxeventname, {#gametime:gettime(), #spawnid:getplayerspawnid(self), #weaponname:weapon.name});
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
        self stats::function_4f10b697(weapon, #"used", 1);
        grenade setteam(self.pers[#"team"]);
        grenade setowner(self);
    case #"explosive_bolt":
        grenade.originalowner = self;
        break;
    case #"satchel_charge":
        level.globalsatchelchargefired++;
        break;
    case #"flash_grenade":
    case #"concussion_grenade":
        self stats::function_4f10b697(weapon, #"used", 1);
        break;
    }
    self.throwinggrenade = 0;
    if (weapon.var_dc337ab7 > 0 && weapon.cookoffholdtime > 0) {
        grenade thread track_cooked_detonation(self, weapon, cooktime);
    } else if (weapon.multidetonation > 0) {
        grenade thread track_multi_detonation(self, weapon, cooktime);
    }
    if (isdefined(level.var_888baf22) && isdefined(level.var_888baf22.script)) {
        self thread [[ level.var_888baf22.script ]](grenade, weapon);
    }
    self thread begin_grenade_tracking();
}

// Namespace weapons/grenade_fire
// Params 1, eflags: 0x40
// Checksum 0x2bd6d35e, Offset: 0x33b0
// Size: 0x24a
function event_handler[grenade_fire] function_c836c4f2(eventstruct) {
    self callback::callback(#"grenade_fired", eventstruct);
    if (!isplayer(self)) {
        return;
    }
    grenade = eventstruct.projectile;
    weapon = eventstruct.weapon;
    if (grenade util::ishacked()) {
        return;
    }
    if (isdefined(level.var_33eb4c03)) {
        grenade thread [[ level.var_33eb4c03 ]]();
    }
    switch (weapon.rootweapon.name) {
    case #"tabun_gas":
        grenade thread tabun::watchtabungrenadedetonation(self);
        break;
    case #"eq_sticky_grenade":
    case #"eq_cluster_semtex_grenade":
        grenade thread check_stuck_to_player(1, 1, weapon);
        grenade thread riotshield::check_stuck_to_shield();
        break;
    case #"c4":
    case #"satchel_charge":
        grenade thread check_stuck_to_player(1, 0, weapon);
        break;
    case #"hatchet":
        grenade.lastweaponbeforetoss = self function_e1402f41();
        grenade thread check_hatchet_bounce();
        grenade thread check_stuck_to_player(0, 0, weapon);
        self stats::function_4f10b697(weapon, #"used", 1);
        break;
    default:
        break;
    }
}

// Namespace weapons/offhand_fire
// Params 1, eflags: 0x40
// Checksum 0x9bf68411, Offset: 0x3608
// Size: 0x2c
function event_handler[offhand_fire] function_936c0ef7(eventstruct) {
    self callback::callback(#"offhand_fire", eventstruct);
}

// Namespace weapons/grenade_launcher_fire
// Params 1, eflags: 0x40
// Checksum 0x67e72c6a, Offset: 0x3640
// Size: 0x2c
function event_handler[grenade_launcher_fire] function_45ca8bd0(eventstruct) {
    self callback::callback(#"hash_198a389d6b65f68d", eventstruct);
}

// Namespace weapons/weapons
// Params 3, eflags: 0x0
// Checksum 0x86d8171, Offset: 0x3678
// Size: 0xfa
function check_stuck_to_player(deleteonteamchange, awardscoreevent, weapon) {
    self endon(#"death");
    waitresult = self waittill(#"stuck_to_player");
    player = waitresult.player;
    if (isdefined(player)) {
        if (deleteonteamchange) {
            self thread stuck_to_player_team_change(player);
        }
        if (awardscoreevent && isdefined(self.originalowner)) {
            if (self.originalowner util::isenemyplayer(player)) {
                scoreevents::processscoreevent(#"cluster_semtex_stick", self.originalowner, player, weapon);
            }
        }
        self.stucktoplayer = player;
    }
}

// Namespace weapons/weapons
// Params 0, eflags: 0x0
// Checksum 0xb7e24ca2, Offset: 0x3780
// Size: 0x46
function check_hatchet_bounce() {
    self endon(#"stuck_to_player");
    self endon(#"death");
    self waittill(#"grenade_bounce");
    self.bounced = 1;
}

// Namespace weapons/weapons
// Params 1, eflags: 0x0
// Checksum 0xb66fe21, Offset: 0x37d0
// Size: 0xba
function stuck_to_player_team_change(player) {
    self endon(#"death");
    player endon(#"disconnect");
    originalteam = player.pers[#"team"];
    while (true) {
        player waittill(#"joined_team");
        if (player.pers[#"team"] != originalteam) {
            self detonate();
            return;
        }
    }
}

// Namespace weapons/weapons
// Params 1, eflags: 0x0
// Checksum 0xbdd6806, Offset: 0x3898
// Size: 0x8a
function function_1ede374b(params) {
    grenade = params.projectile;
    weapon = params.weapon;
    if (isdefined(self.gotpullbacknotify) && self.gotpullbacknotify) {
        self.gotpullbacknotify = 0;
        return;
    }
    if (!weapon.isthrowback) {
        return;
    }
    grenade.threwback = 1;
    grenade.originalowner = self;
}

// Namespace weapons/weapons
// Params 1, eflags: 0x0
// Checksum 0x736645fc, Offset: 0x3930
// Size: 0x44
function wait_and_delete_dud(waittime) {
    self endon(#"death");
    wait waittime;
    if (isdefined(self)) {
        self delete();
    }
}

// Namespace weapons/weapons
// Params 0, eflags: 0x0
// Checksum 0x2b60a5e7, Offset: 0x3980
// Size: 0x24
function gettimefromlevelstart() {
    if (!isdefined(level.starttime)) {
        return 0;
    }
    return gettime() - level.starttime;
}

// Namespace weapons/weapons
// Params 3, eflags: 0x0
// Checksum 0x48ed4cbb, Offset: 0x39b0
// Size: 0x194
function turn_grenade_into_a_dud(weapon, isthrowngrenade, player) {
    if (currentsessionmode() == 2) {
        return;
    }
    time = float(gettimefromlevelstart()) / 1000;
    if (level.roundstartexplosivedelay >= time) {
        if (weapon.disallowatmatchstart || weaponhasattachment(weapon, "gl")) {
            timeleft = int(level.roundstartexplosivedelay - time);
            if (!timeleft) {
                timeleft = 1;
            }
            if (isthrowngrenade) {
                player iprintlnbold(#"hash_10012bedb9f60e99", " " + timeleft + " ", #"hash_79a58948c3b976f5");
            } else {
                player iprintlnbold(#"hash_255050263c8cd26d", " " + timeleft + " ", #"hash_79a58948c3b976f5");
            }
            self makegrenadedud();
        }
    }
}

// Namespace weapons/weapons
// Params 1, eflags: 0x0
// Checksum 0xffe33deb, Offset: 0x3b50
// Size: 0x5c
function function_1458bdfe(params) {
    grenade = params.projectile;
    weapon = params.weapon;
    grenade turn_grenade_into_a_dud(weapon, 1, self);
}

// Namespace weapons/weapons
// Params 1, eflags: 0x0
// Checksum 0xe368da2a, Offset: 0x3bb8
// Size: 0x3c
function on_grenade_fired(params) {
    function_1458bdfe(params);
    function_1ede374b(params);
}

// Namespace weapons/weapons
// Params 1, eflags: 0x0
// Checksum 0x4b54601c, Offset: 0x3c00
// Size: 0xbc
function function_e108345d(params) {
    grenade = params.projectile;
    weapon = params.weapon;
    grenade turn_grenade_into_a_dud(weapon, 0, self);
    assert(isdefined(grenade));
    level.missileentities[level.missileentities.size] = grenade;
    grenade.weapon = weapon;
    grenade thread watch_missile_death();
}

// Namespace weapons/weapons
// Params 4, eflags: 0x0
// Checksum 0x805f3f12, Offset: 0x3cc8
// Size: 0x5ae
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
        if (distsq < radius * radius && (!dolos || damage_trace_passed(pos, playerpos, startradius, undefined))) {
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
        if (distsq < radius * radius && (!dolos || damage_trace_passed(pos, entpos, startradius, grenades[i]))) {
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
        if (distsq < radius * radius && (!dolos || damage_trace_passed(pos, entpos, startradius, destructibles[i]))) {
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
        if (distsq < radius * radius && (!dolos || damage_trace_passed(pos, entpos, startradius, destructables[i]))) {
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
    return ents;
}

// Namespace weapons/weapons
// Params 4, eflags: 0x0
// Checksum 0xfa44d23c, Offset: 0x4280
// Size: 0x66
function damage_trace_passed(from, to, startradius, ignore) {
    trace = damage_trace(from, to, startradius, ignore);
    return trace[#"fraction"] == 1;
}

// Namespace weapons/weapons
// Params 4, eflags: 0x0
// Checksum 0xb2d61284, Offset: 0x42f0
// Size: 0x1f0
function damage_trace(from, to, startradius, ignore) {
    midpos = undefined;
    diff = to - from;
    if (lengthsquared(diff) < startradius * startradius) {
        midpos = to;
    }
    dir = vectornormalize(diff);
    midpos = from + (dir[0] * startradius, dir[1] * startradius, dir[2] * startradius);
    trace = bullettrace(midpos, to, 0, ignore);
    /#
        if (getdvarint(#"scr_damage_debug", 0) != 0) {
            if (trace[#"fraction"] == 1) {
                thread debug::drawdebugline(midpos, to, (1, 1, 1), 600);
            } else {
                thread debug::drawdebugline(midpos, trace[#"position"], (1, 0.9, 0.8), 600);
                thread debug::drawdebugline(trace[#"position"], to, (1, 0.4, 0.3), 600);
            }
        }
    #/
    return trace;
}

// Namespace weapons/weapons
// Params 7, eflags: 0x0
// Checksum 0xaf4a11b2, Offset: 0x44e8
// Size: 0x194
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
// Params 5, eflags: 0x0
// Checksum 0xfc85f84, Offset: 0x4688
// Size: 0x132
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
        self.lastconcussedby = eattacker;
        break;
    default:
        if (isdefined(level.shellshockonplayerdamage) && isplayer(self)) {
            [[ level.shellshockonplayerdamage ]](meansofdeath, damage, weapon);
        }
        break;
    }
}

// Namespace weapons/weapons
// Params 1, eflags: 0x0
// Checksum 0x48e19d93, Offset: 0x47c8
// Size: 0x16c
function play_concussion_sound(duration) {
    self endon(#"death");
    self endon(#"disconnect");
    concussionsound = spawn("script_origin", (0, 0, 1));
    concussionsound.origin = self.origin;
    concussionsound linkto(self);
    concussionsound thread delete_ent_on_owner_death(self);
    concussionsound playsound(#"");
    concussionsound playloopsound(#"");
    if (duration > 0.5) {
        wait duration - 0.5;
    }
    concussionsound playsound(#"");
    concussionsound stoploopsound(0.5);
    wait 0.5;
    concussionsound notify(#"delete");
    concussionsound delete();
}

// Namespace weapons/weapons
// Params 1, eflags: 0x0
// Checksum 0x1757e2ff, Offset: 0x4940
// Size: 0x4c
function delete_ent_on_owner_death(owner) {
    self endon(#"delete");
    owner waittill(#"death");
    self delete();
}

// Namespace weapons/weapons
// Params 1, eflags: 0x0
// Checksum 0x26ef299a, Offset: 0x4998
// Size: 0x6c
function function_44902e1c(weapon) {
    player = self;
    if (!isdefined(player.var_8e6e2908)) {
        player.var_8e6e2908 = [];
    }
    array::add(player.var_8e6e2908, weapon);
    force_stowed_weapon_update();
}

// Namespace weapons/weapons
// Params 1, eflags: 0x0
// Checksum 0x178cdc3e, Offset: 0x4a10
// Size: 0xd4
function function_752f3a30(weapon) {
    player = self;
    if (!isdefined(player.var_8e6e2908)) {
        return;
    }
    foundindex = undefined;
    for (index = 0; index < player.var_8e6e2908.size; index++) {
        if (player.var_8e6e2908[index] == weapon) {
            foundindex = index;
        }
    }
    if (!isdefined(foundindex)) {
        return;
    }
    player.var_8e6e2908 = array::remove_index(player.var_8e6e2908, foundindex);
    force_stowed_weapon_update();
}

// Namespace weapons/weapons
// Params 1, eflags: 0x0
// Checksum 0x7b2e7746, Offset: 0x4af0
// Size: 0x40c
function on_weapon_change(params) {
    if (level.trackweaponstats) {
        if (!isdefined(self.var_d99169dd)) {
            self.var_d99169dd = gettime();
        }
        if (params.last_weapon != level.weaponnone) {
            self bb::commit_weapon_data(getplayerspawnid(self), params.last_weapon, self.var_d99169dd);
        }
        if (params.weapon != level.weaponnone && params.weapon != params.last_weapon) {
            self.var_d99169dd = gettime();
            update_last_held_weapon_timings(self.var_d99169dd);
            self loadout::initweaponattachments(params.weapon);
        }
    }
    team = self.pers[#"team"];
    playerclass = self.pers[#"class"];
    if (self ismantling()) {
        return;
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
    if (params.weapon != level.weaponnone || !hasstowed) {
        detach_all_weapons();
        stow_on_back();
        stow_on_hip();
    }
}

// Namespace weapons/weapons
// Params 1, eflags: 0x0
// Checksum 0xc4931c09, Offset: 0x4f08
// Size: 0x7a
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
// Checksum 0x22e4ef7, Offset: 0x4f90
// Size: 0x5cc
function scavenger_think() {
    self endon(#"death");
    waitresult = self waittill(#"scavenger");
    player = waitresult.player;
    primary_weapons = player getweaponslistprimaries();
    offhand_weapons_and_alts = array::exclude(player getweaponslist(1), primary_weapons);
    arrayremovevalue(offhand_weapons_and_alts, level.weaponbasemelee);
    offhand_weapons_and_alts = array::reverse(offhand_weapons_and_alts);
    player playsound(#"wpn_ammo_pickup");
    player playlocalsound(#"wpn_ammo_pickup");
    player hud::flash_scavenger_icon();
    for (i = 0; i < offhand_weapons_and_alts.size; i++) {
        weapon = offhand_weapons_and_alts[i];
        if (!weapon.isscavengable || killstreaks::is_killstreak_weapon(weapon)) {
            continue;
        }
        maxammo = 0;
        loadout = player loadout::find_loadout_slot(weapon);
        if (isdefined(loadout)) {
            if (loadout.count > 0) {
                maxammo = loadout.count;
            } else if (weapon.isheavyweapon && isdefined(level.overrideammodropheavyweapon) && level.overrideammodropheavyweapon) {
                maxammo = weapon.maxammo;
            }
        } else if (isdefined(player.grenadetypeprimary) && weapon == player.grenadetypeprimary && isdefined(player.grenadetypeprimarycount) && player.grenadetypeprimarycount > 0) {
            maxammo = player.grenadetypeprimarycount;
        } else if (isdefined(player.grenadetypesecondary) && weapon == player.grenadetypesecondary && isdefined(player.grenadetypesecondarycount) && player.grenadetypesecondarycount > 0) {
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
            ammo = stock + 2;
            if (ammo > maxammo) {
                ammo = maxammo;
            }
            player setweaponammostock(weapon, ammo);
            player.scavenged = 1;
            player thread challenges::scavengedgrenade();
            continue;
        }
        if (weapon.rootweapon == getweapon(#"trophy_system")) {
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
        clip *= getdvarfloat(#"scavenger_clip_multiplier", 1);
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
// Params 1, eflags: 0x0
// Checksum 0x4230f7e, Offset: 0x5568
// Size: 0xe4
function drop_scavenger_for_death(attacker) {
    if (!isdefined(attacker)) {
        return;
    }
    if (attacker == self) {
        return;
    }
    if (level.gametype == "hack") {
        item = self dropscavengeritem(getweapon(#"scavenger_item_hack"));
    } else if (isplayer(attacker)) {
        item = self dropscavengeritem(getweapon(#"scavenger_item"));
    } else {
        return;
    }
    item thread scavenger_think();
}

// Namespace weapons/weapons
// Params 3, eflags: 0x0
// Checksum 0x4c3d4794, Offset: 0x5658
// Size: 0x66
function add_limited_weapon(weapon, owner, num_drops) {
    limited_info = spawnstruct();
    limited_info.weapon = weapon;
    limited_info.drops = num_drops;
    owner.limited_info = limited_info;
}

// Namespace weapons/weapons
// Params 2, eflags: 0x0
// Checksum 0xf3b70a2e, Offset: 0x56c8
// Size: 0x6e
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
// Checksum 0x28f7c314, Offset: 0x5740
// Size: 0x94
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
// Checksum 0x7eab848f, Offset: 0x57e0
// Size: 0x66
function limited_pickup(limited_info) {
    self endon(#"death");
    waitresult = self waittill(#"trigger");
    if (!isdefined(waitresult.dropped_item)) {
        return;
    }
    waitresult.activator.limited_info = limited_info;
}

// Namespace weapons/weapons
// Params 3, eflags: 0x0
// Checksum 0x1ba0da34, Offset: 0x5850
// Size: 0x7c
function track_cooked_detonation(attacker, weapon, cooktime) {
    self endon(#"trophy_destroyed");
    wait float(weapon.fusetime) / 1000;
    if (!isdefined(self)) {
        return;
    }
    self thread ninebang_doninebang(attacker, weapon, cooktime);
}

// Namespace weapons/weapons
// Params 3, eflags: 0x0
// Checksum 0x828a44c7, Offset: 0x58d8
// Size: 0x1d4
function ninebang_doninebang(attacker, weapon, cooktime) {
    level endon(#"game_ended");
    maxstages = weapon.var_dc337ab7;
    cookstages = min(floor(cooktime / weapon.cookoffholdtime * maxstages), maxstages);
    intervaltime = float(weapon.var_25ebc548) / 1000;
    var_edf677d3 = float(weapon.var_459781fd) / 1000;
    cookstages *= 3;
    if (!cookstages) {
        cookstages = 3;
    }
    wait float(weapon.fusetime) / 1000;
    for (i = 0; i < cookstages; i++) {
        if (!isdefined(self)) {
            return;
        }
        attacker magicgrenadeplayer(weapon.grenadeweapon, self.origin, (0, 0, 0));
        if ((i + 1) % 3 == 0) {
            wait var_edf677d3;
            continue;
        }
        wait intervaltime;
    }
    if (isdefined(self)) {
        self delete();
    }
}

// Namespace weapons/weapons
// Params 3, eflags: 0x0
// Checksum 0x625e8949, Offset: 0x5ab8
// Size: 0x1ce
function track_multi_detonation(ownerent, weapon, cooktime) {
    self endon(#"trophy_destroyed");
    waitresult = self waittill(#"explode", #"death");
    if (waitresult._notify == "death") {
        return;
    }
    for (i = 0; i < weapon.multidetonation; i++) {
        if (!isdefined(ownerent)) {
            return;
        }
        dir = level multi_detonation_get_cluster_launch_dir(weapon, i, weapon.multidetonation, waitresult.normal);
        fusetime = randomfloatrange(weapon.var_b0af4601, weapon.var_5dd7d73f);
        speed = randomintrangeinclusive(weapon.var_bf13f4c4, weapon.var_fc77ffda);
        vel = dir * speed;
        var_67988929 = waitresult.position + dir * 5;
        grenade = ownerent magicgrenadetype(weapon.grenadeweapon, var_67988929, vel, fusetime);
        util::wait_network_frame();
    }
}

// Namespace weapons/weapons
// Params 4, eflags: 0x0
// Checksum 0xeaf260d6, Offset: 0x5c90
// Size: 0x19a
function multi_detonation_get_cluster_launch_dir(weapon, index, multival, normal) {
    pitch = randomfloatrange(weapon.var_4e95f5c5, weapon.var_7928010b);
    var_dfa2956f = randomfloatrange(weapon.var_a71da152 * -1, weapon.var_a71da152);
    yaw = -180 + 360 / multival * index + var_dfa2956f;
    angles = (pitch * -1, yaw, 0);
    dir = anglestoforward(angles);
    c = vectorcross(normal, dir);
    f = vectorcross(c, normal);
    theta = 90 - pitch;
    dir = normal * cos(theta) + f * sin(theta);
    dir = vectornormalize(dir);
    return dir;
}

// Namespace weapons/grenade_stuck
// Params 1, eflags: 0x40
// Checksum 0x7526b7e8, Offset: 0x5e38
// Size: 0x5c
function event_handler[grenade_stuck] function_45686efb(eventstruct) {
    grenade = eventstruct.projectile;
    if (!isdefined(grenade)) {
        return;
    }
    if (!isdefined(self.var_b733ac06)) {
        self.var_b733ac06 = [];
    }
    array::add(self.var_b733ac06, grenade);
}

