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
#using scripts\core_common\math_shared;
#using scripts\core_common\player\player_loadout;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\scoreevents_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\weapons_shared;
#using scripts\killstreaks\killstreaks_util;
#using scripts\weapons\weaponobjects;

#namespace weapons;

// Namespace weapons/weapons
// Params 0, eflags: 0x0
// Checksum 0x1c80b23, Offset: 0x298
// Size: 0x2f4
function init_shared() {
    level.weaponnone = getweapon(#"none");
    level.weaponnull = getweapon(#"weapon_null");
    level.weaponbasemelee = getweapon(#"knife");
    level.weaponbasemeleeheld = getweapon(#"knife_held");
    level.weaponballisticknife = getweapon(#"special_ballisticknife_t8_dw");
    level.weaponspecialcrossbow = getweapon(#"special_crossbow_t9");
    level.weaponflechette = getweapon(#"tr_flechette_t8");
    level.weaponriotshield = getweapon(#"riotshield");
    level.weaponflashgrenade = getweapon(#"flash_grenade");
    level.weaponsatchelcharge = getweapon(#"satchel_charge");
    level.var_43a51921 = getweapon(#"hash_5a7fd1af4a1d5c9");
    level.var_387e902c = getweapon(#"hash_31be8125c7d0f273");
    level.var_34d27b26 = getweapon(#"null_offhand_primary");
    level.var_6388e216 = getweapon(#"null_offhand_secondary");
    if (!isdefined(level.trackweaponstats)) {
        level.trackweaponstats = 1;
    }
    if (!isdefined(level.var_8c5a071d)) {
        level.var_8c5a071d = 1;
    }
    level._effect[#"flashninebang"] = #"_t6/misc/fx_equip_tac_insert_exp";
    callback::on_start_gametype(&init);
    callback::on_player_killed(&on_death);
    level.detach_all_weapons = &detach_all_weapons;
}

// Namespace weapons/weapons
// Params 0, eflags: 0x0
// Checksum 0x3e4c5f6, Offset: 0x598
// Size: 0x14
function function_6916626d() {
    level.var_e520065 = 1;
}

// Namespace weapons/weapons
// Params 0, eflags: 0x0
// Checksum 0x6dbae3f2, Offset: 0x5b8
// Size: 0x184
function init() {
    level.missileentities = [];
    level.hackertooltargets = [];
    level.var_2d187870 = [];
    level.missileduddeletedelay = getdvarint(#"scr_missileduddeletedelay", 3);
    if (!isdefined(level.roundstartexplosivedelay)) {
        level.roundstartexplosivedelay = 0;
    }
    clientfield::register_clientuimodel("hudItems.pickupHintWeaponIndex", 1, 10, "int");
    callback::on_connect(&on_player_connect);
    callback::on_spawned(&on_player_spawned);
    callback::on_weapon_change(&on_weapon_change);
    callback::on_grenade_fired(&on_grenade_fired);
    callback::function_4b7977fe(&function_4b7977fe);
    self callback::on_end_game(&on_end_game);
    if (level.var_e520065 === 1) {
        level thread function_220ea8ba();
    }
}

// Namespace weapons/weapons
// Params 0, eflags: 0x0
// Checksum 0xf23fd236, Offset: 0x748
// Size: 0x192
function function_4fddf732() {
    self.concussionendtime = 0;
    self.scavenged = 0;
    self.hasdonecombat = 0;
    self.shielddamageblocked = 0;
    self.usedkillstreakweapon = [];
    self.usedkillstreakweapon[#"minigun"] = 0;
    self.usedkillstreakweapon[#"m32"] = 0;
    self.usedkillstreakweapon[#"m220_tow"] = 0;
    self.usedkillstreakweapon[#"mp40_blinged"] = 0;
    self.killstreaktype = [];
    self.killstreaktype[#"minigun"] = "minigun";
    self.killstreaktype[#"m32"] = "m32";
    self.killstreaktype[#"m220_tow"] = "m220_tow";
    self.killstreaktype[#"mp40_blinged"] = "mp40_blinged_drop";
    self.throwinggrenade = 0;
    self.gotpullbacknotify = 0;
    self.lastdroppableweapon = level.weaponnone;
    self.lastweaponchange = 0;
    self.droppeddeathweapon = undefined;
    self.tookweaponfrom = [];
    self.pickedupweaponkills = [];
    self.var_3ffebf0a = 0;
    self.tag_stowed_back = undefined;
    self.tag_stowed_hip = undefined;
}

// Namespace weapons/weapons
// Params 0, eflags: 0x0
// Checksum 0x9ee99286, Offset: 0x8e8
// Size: 0x74
function on_player_connect() {
    self.usedweapons = 0;
    self.lastfiretime = 0;
    self.hits = 0;
    self.headshothits = 0;
    self function_4fddf732();
    if (is_true(level.var_3a0bbaea)) {
        function_878d649f(self);
    }
}

// Namespace weapons/weapons
// Params 0, eflags: 0x0
// Checksum 0x7b8461e5, Offset: 0x968
// Size: 0x74
function on_player_spawned() {
    self function_4fddf732();
    newweapon = self getcurrentweapon();
    if (may_drop(newweapon)) {
        self.lastdroppableweapon = newweapon;
    }
    self function_2a928426();
}

// Namespace weapons/weapons
// Params 1, eflags: 0x0
// Checksum 0x2bb79352, Offset: 0x9e8
// Size: 0x1e4
function function_878d649f(player) {
    assert(isplayer(player));
    if (!isdefined(level.var_94ee159)) {
        level.var_94ee159 = [];
    }
    foreach (objid in level.var_94ee159) {
        if (!isdefined(objid)) {
            continue;
        }
        objective_setinvisibletoplayer(objid, player);
    }
    player.var_18f581bc = gameobjects::get_next_obj_id();
    objective_add(player.var_18f581bc, "invisible", player.origin, #"weapon_pickup");
    objective_setprogress(player.var_18f581bc, 0);
    objective_setinvisibletoall(player.var_18f581bc);
    objective_setvisibletoplayer(player.var_18f581bc, player);
    level.var_94ee159[level.var_94ee159.size] = player.var_18f581bc;
    player thread function_54abbe5c();
    player thread function_388f7cf7();
}

// Namespace weapons/weapon_change
// Params 1, eflags: 0x40
// Checksum 0x294ce6a9, Offset: 0xbd8
// Size: 0x114
function event_handler[weapon_change] function_edc4ebe8(eventstruct) {
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
    if (!isdefined(self.lastnonkillstreakweapon) && isdefined(newweapon)) {
        self.lastnonkillstreakweapon = newweapon;
    }
    self callback::callback(#"weapon_change", eventstruct);
}

// Namespace weapons/weapons
// Params 1, eflags: 0x0
// Checksum 0x16cd8e4, Offset: 0xcf8
// Size: 0x15e
function may_drop(weapon) {
    if (weapon == level.weaponnone) {
        return false;
    }
    if (isdefined(level.laststandpistol) && weapon == level.laststandpistol) {
        return false;
    }
    if (isdefined(level.var_f425c7f3)) {
        foreach (var_22174a13 in level.var_f425c7f3) {
            if (var_22174a13 == weapon) {
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
    if (weapon.var_29d24e37) {
        return false;
    }
    if (weapon.var_9a789947) {
        return false;
    }
    if (weapon.isnotdroppable) {
        return false;
    }
    return true;
}

// Namespace weapons/weapons
// Params 0, eflags: 0x0
// Checksum 0x7a709327, Offset: 0xe60
// Size: 0x8e
function function_fe1f5cc() {
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
// Checksum 0x7289cf2, Offset: 0xef8
// Size: 0x4e
function function_2be39078(last_weapon) {
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
// Checksum 0xc135c43, Offset: 0xf50
// Size: 0x3a4
function function_d571ac59(last_weapon = undefined, immediate = 0, awayfromball = 0) {
    ball = getweapon(#"ball");
    if (isdefined(ball) && self hasweapon(ball) && !is_true(awayfromball)) {
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
        if (function_2be39078(last_weapon)) {
            to_weapon = last_weapon;
        }
        if (!isdefined(to_weapon)) {
            to_weapon = function_fe1f5cc();
        }
        if (isdefined(to_weapon)) {
            if (to_weapon.isheavyweapon) {
                if (to_weapon.gadget_heroversion_2_0) {
                    if (to_weapon.isgadget && self getammocount(to_weapon) > 0) {
                        slot = self gadgetgetslot(to_weapon);
                        if (self util::gadget_is_in_use(slot)) {
                            if (is_true(immediate)) {
                                self switchtoweaponimmediate(to_weapon);
                                return;
                            }
                            self switchtoweapon(to_weapon);
                            return;
                        }
                    }
                } else if (self getammocount(to_weapon) > 0) {
                    if (is_true(immediate)) {
                        self switchtoweaponimmediate(to_weapon);
                        return;
                    }
                    self switchtoweapon(to_weapon);
                    return;
                }
            } else if (self getammocount(to_weapon) > 0 || to_weapon.ismeleeweapon) {
                if (is_true(immediate)) {
                    self switchtoweaponimmediate(to_weapon);
                    return;
                }
                self switchtoweapon(to_weapon);
                return;
            }
        }
    }
    if (is_true(immediate)) {
        self switchtoweaponimmediate();
        return;
    }
    self switchtoweapon();
}

// Namespace weapons/weapons
// Params 1, eflags: 0x0
// Checksum 0xcc562a59, Offset: 0x1300
// Size: 0xf2
function update_last_held_weapon_timings(newtime) {
    if (isdefined(self.currentweapon) && isdefined(self.currentweaponstarttime)) {
        totaltime = int(float(newtime - self.currentweaponstarttime) / 1000);
        if (totaltime > 0) {
            weaponpickedup = 0;
            if (isdefined(self.pickedupweapons) && isdefined(self.pickedupweapons[self.currentweapon])) {
                weaponpickedup = 1;
            }
            self stats::function_eec52333(self.currentweapon, #"timeused", totaltime, self.class_num, weaponpickedup);
            self.currentweaponstarttime = newtime;
        }
    }
}

// Namespace weapons/weapons
// Params 1, eflags: 0x0
// Checksum 0x9efd4a38, Offset: 0x1400
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
            self stats::function_eec52333(self.weapon_array_grenade[i], #"timeused", totaltime, self.class_num);
        }
    }
    if (isdefined(self.weapon_array_inventory)) {
        for (i = 0; i < self.weapon_array_inventory.size; i++) {
            self stats::function_eec52333(self.weapon_array_inventory[i], #"timeused", totaltime, self.class_num);
        }
    }
    if (isdefined(self.killstreak)) {
        for (i = 0; i < self.killstreak.size; i++) {
            killstreaktype = level.menureferenceforkillstreak[self.killstreak[i]];
            if (isdefined(killstreaktype)) {
                killstreakweapon = killstreaks::get_killstreak_weapon(killstreaktype);
                self stats::function_eec52333(killstreakweapon, #"timeused", totaltime, self.class_num);
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
// Checksum 0xb935db8b, Offset: 0x17f0
// Size: 0xa4
function on_death(*params) {
    if (game.state == #"playing" && level.trackweaponstats) {
        if (!isdefined(self.var_e09dd2bf)) {
            self.var_e09dd2bf = gettime();
        }
        self bb::commit_weapon_data(getplayerspawnid(self), self getcurrentweapon(), self.var_e09dd2bf);
        update_timings(gettime());
    }
}

// Namespace weapons/weapons
// Params 0, eflags: 0x4
// Checksum 0x65112527, Offset: 0x18a0
// Size: 0x18a
function private function_220ea8ba() {
    self notify("2a2ddae2c4bac7b3");
    self endon("2a2ddae2c4bac7b3");
    level endon(#"game_ended");
    if (!isdefined(level.var_c5a37526)) {
        level.var_c5a37526 = [];
    }
    while (!isdefined(level.var_445b1bca)) {
        level waittill(#"hash_8c9c1055b97344e");
    }
    while (true) {
        waitframe(1);
        if (level.var_c5a37526.size == 0) {
            level waittill(#"hash_8c9c1055b97344e");
            continue;
        }
        if (level.var_445b1bca + function_60d95f53() >= gettime()) {
            continue;
        }
        waittillframeend();
        pixbeginevent(#"");
        info = level.var_c5a37526[0];
        if (function_c44bf23e(info)) {
            info.victim function_6cf6f3fb(info.attacker, info.sweapon, info.smeansofdeath, info.damage, info.var_1940b58e, info);
        }
        arrayremoveindex(level.var_c5a37526, 0, 0);
        profilestop();
    }
}

// Namespace weapons/weapons
// Params 1, eflags: 0x4
// Checksum 0x199fbf72, Offset: 0x1a38
// Size: 0x5e
function private function_c44bf23e(info) {
    if (!isdefined(info.victim)) {
        return false;
    }
    if (info.victim.var_3ffebf0a !== 1) {
        return false;
    }
    if (info.time + 500 < gettime()) {
        return false;
    }
    return true;
}

// Namespace weapons/weapons
// Params 5, eflags: 0x0
// Checksum 0x195da9cd, Offset: 0x1aa0
// Size: 0x22c
function drop_for_death(attacker, sweapon, smeansofdeath, damage, var_1940b58e = 1) {
    if (isdefined(level.var_c5a37526)) {
        if (level.var_c5a37526.size + 1 >= 20) {
            return;
        }
        var_cef01b32 = {};
        var_cef01b32.time = gettime();
        var_cef01b32.victim = self;
        var_cef01b32.attacker = attacker;
        var_cef01b32.sweapon = sweapon;
        var_cef01b32.smeansofdeath = smeansofdeath;
        var_cef01b32.damage = damage;
        var_cef01b32.var_1940b58e = var_1940b58e;
        lastdroppableweapon = self.lastdroppableweapon;
        if (isdefined(lastdroppableweapon)) {
            var_cef01b32.lastdroppableweapon = lastdroppableweapon;
            var_cef01b32.weaponammoclip = self getweaponammoclip(lastdroppableweapon);
            var_cef01b32.var_bf0fb76a = self getweaponammostock(lastdroppableweapon);
            var_cef01b32.anyammoforweaponmodes = self anyammoforweaponmodes(lastdroppableweapon);
        }
        if (!isdefined(level.var_c5a37526)) {
            level.var_c5a37526 = [];
        } else if (!isarray(level.var_c5a37526)) {
            level.var_c5a37526 = array(level.var_c5a37526);
        }
        level.var_c5a37526[level.var_c5a37526.size] = var_cef01b32;
        self.var_3ffebf0a = 1;
        if (level.var_c5a37526.size == 1) {
            level notify(#"hash_8c9c1055b97344e");
        }
        return;
    }
    self function_6cf6f3fb(attacker, sweapon, smeansofdeath, damage, var_1940b58e);
}

// Namespace weapons/weapons
// Params 6, eflags: 0x4
// Checksum 0xfd206f31, Offset: 0x1cd8
// Size: 0x61c
function private function_6cf6f3fb(attacker, *sweapon, smeansofdeath, damage, var_1940b58e = 1, var_8211a4fa) {
    if (level.disableweapondrop == 1) {
        return;
    }
    weapon = isdefined(var_8211a4fa) ? var_8211a4fa.lastdroppableweapon : self.lastdroppableweapon;
    if (isdefined(self.droppeddeathweapon)) {
        return;
    }
    if (!isdefined(weapon)) {
        /#
            if (getdvarint(#"scr_dropdebug", 0) == 1) {
                println("<dev string:x38>");
            }
        #/
        return;
    }
    if (weapon == level.weaponnone) {
        /#
            if (getdvarint(#"scr_dropdebug", 0) == 1) {
                println("<dev string:x5b>");
            }
        #/
        return;
    }
    if (!self hasweapon(weapon)) {
        /#
            if (getdvarint(#"scr_dropdebug", 0) == 1) {
                println("<dev string:x81>" + weapon.name + "<dev string:xb0>");
            }
        #/
        return;
    }
    if (!(isdefined(var_8211a4fa.anyammoforweaponmodes) ? var_8211a4fa.anyammoforweaponmodes : self anyammoforweaponmodes(weapon))) {
        /#
            if (getdvarint(#"scr_dropdebug", 0) == 1) {
                println("<dev string:xb5>");
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
    clipammo = isdefined(var_8211a4fa.weaponammoclip) ? var_8211a4fa.weaponammoclip : self getweaponammoclip(weapon);
    stockammo = isdefined(var_8211a4fa.var_182b7344) ? var_8211a4fa.var_182b7344 : self getweaponammostock(weapon);
    clip_and_stock_ammo = clipammo + stockammo;
    if (!clip_and_stock_ammo && !is_true(weapon.unlimitedammo)) {
        /#
            if (getdvarint(#"scr_dropdebug", 0) == 1) {
                println("<dev string:xe5>");
            }
        #/
        return;
    }
    if (is_true(weapon.isnotdroppable)) {
        return;
    }
    stockmax = weapon.maxammo;
    if (stockammo > stockmax) {
        stockammo = stockmax;
    }
    item = self dropitem(weapon);
    if (!isdefined(item)) {
        /#
            iprintlnbold("<dev string:x104>" + weapon.name);
        #/
        return;
    }
    /#
        if (getdvarint(#"scr_dropdebug", 0) == 1) {
            println("<dev string:x12e>" + weapon.name);
        }
        if (!isdefined(item.model) || item.model == #"") {
            iprintlnbold("<dev string:x142>" + weapon.name);
        }
        if (!item hasdobj()) {
            iprintlnbold("<dev string:x165>" + weapon.name);
        }
    #/
    self dropweaponfordeathlaunch(item, damage, self.angles, weapon, 1, 1);
    drop_limited_weapon(weapon, self, item);
    self.droppeddeathweapon = 1;
    if (!isdefined(item)) {
        return;
    }
    if (var_1940b58e) {
        item itemweaponsetammo(clipammo, stockammo);
    }
    item.owner = self;
    item.ownersattacker = sweapon;
    item.weapon = weapon;
    item.smeansofdeath = smeansofdeath;
    if (is_true(level.var_3a0bbaea)) {
        arrayremovevalue(level.var_2d187870, undefined);
        array::add(level.var_2d187870, item, 0);
    }
    item thread watch_pickup();
    item thread delete_pickup_after_awhile();
}

// Namespace weapons/weapons
// Params 0, eflags: 0x0
// Checksum 0x21a51122, Offset: 0x2300
// Size: 0x74
function function_54abbe5c() {
    self waittill(#"disconnect", #"game_ended");
    if (isdefined(self) && isdefined(self.var_18f581bc)) {
        gameobjects::release_obj_id(self.var_18f581bc);
        objective_delete(self.var_18f581bc);
    }
}

// Namespace weapons/weapons
// Params 0, eflags: 0x0
// Checksum 0xa8db8837, Offset: 0x2380
// Size: 0xa6
function function_388f7cf7() {
    level endon(#"game_ended");
    self endon(#"disconnect");
    self notify("1c22aea45d9e8008");
    self endon("1c22aea45d9e8008");
    self waittill(#"spawned_player");
    while (true) {
        function_d2c66128(self.origin, self getplayerangles());
        waitframe(1);
    }
}

// Namespace weapons/weapons
// Params 2, eflags: 0x0
// Checksum 0x5d892d93, Offset: 0x2430
// Size: 0x24c
function function_d2c66128(origin, *angles) {
    maxdist = util::function_16fb0a3b();
    var_fbe2cce0 = 0;
    var_9b882d22 = self function_ee839fac();
    if (isdefined(var_9b882d22)) {
        var_fbe2cce0 = distancesquared(angles, var_9b882d22.origin) < sqr(maxdist);
    }
    if (var_fbe2cce0) {
        objstate = 0;
        neardist = util::function_4c1656d5();
        if (neardist < maxdist && distancesquared(angles, var_9b882d22.origin) > sqr(neardist)) {
            objstate = 1;
        }
        objective_setstate(self.var_18f581bc, "active");
        objective_setposition(self.var_18f581bc, var_9b882d22.origin);
        objective_setgamemodeflags(self.var_18f581bc, objstate);
        weaponindex = 0;
        if (isdefined(var_9b882d22.item)) {
            weaponindex = isdefined(getbaseweaponitemindex(var_9b882d22.item)) ? getbaseweaponitemindex(var_9b882d22.item) : 0;
        }
        self clientfield::set_player_uimodel("hudItems.pickupHintWeaponIndex", weaponindex);
        return;
    }
    objective_setstate(self.var_18f581bc, "invisible");
    objective_setgamemodeflags(self.var_18f581bc, 0);
    self clientfield::set_player_uimodel("hudItems.pickupHintWeaponIndex", 0);
}

// Namespace weapons/weapons
// Params 0, eflags: 0x0
// Checksum 0x703ba78e, Offset: 0x2688
// Size: 0x5c
function delete_pickup_after_awhile() {
    self endon(#"death");
    wait 60;
    if (!isdefined(self)) {
        return;
    }
    arrayremovevalue(level.var_2d187870, self);
    self delete();
}

// Namespace weapons/weapons
// Params 0, eflags: 0x0
// Checksum 0xfe1b2f18, Offset: 0x26f0
// Size: 0x3fc
function watch_pickup() {
    self endon(#"death");
    weapon = self.item;
    waitresult = self waittill(#"trigger");
    player = waitresult.activator;
    droppeditem = waitresult.dropped_item;
    pickedupontouch = waitresult.is_pickedup_ontouch;
    var_90f043d2 = pickedupontouch && !isdefined(droppeditem);
    if (!var_90f043d2) {
        if (isdefined(player) && isplayer(player)) {
            if (isdefined(player.weaponpickupscount)) {
                player.weaponpickupscount++;
            } else {
                player.weaponpickupscount = 1;
            }
            if (!isdefined(player.pickedupweapons)) {
                player.pickedupweapons = [];
            }
            if (isdefined(self.owner)) {
                player.pickedupweapons[weapon] = self.owner getentitynumber();
            } else {
                player.pickedupweapons[weapon] = -1;
            }
        }
    }
    /#
        if (getdvarint(#"scr_dropdebug", 0) == 1) {
            println("<dev string:x187>" + weapon.name + "<dev string:x19d>" + isdefined(self.ownersattacker));
        }
    #/
    assert(isdefined(player.tookweaponfrom));
    assert(isdefined(player.pickedupweaponkills));
    if (!isdefined(player.tookweaponfrom)) {
        player.tookweaponfrom = [];
    }
    if (!isdefined(player.pickedupweaponkills)) {
        player.pickedupweaponkills = [];
    }
    if (isdefined(droppeditem)) {
        for (i = 0; i < droppeditem.size; i++) {
            if (!isdefined(droppeditem[i])) {
                continue;
            }
            droppedweapon = droppeditem[i].item;
            if (isdefined(player.tookweaponfrom[droppedweapon])) {
                droppeditem[i].owner = player.tookweaponfrom[droppedweapon].previousowner;
                droppeditem[i].ownersattacker = player;
                player.tookweaponfrom[droppedweapon] = undefined;
            }
            array::add(level.var_2d187870, droppeditem[i], 0);
            droppeditem[i] thread watch_pickup();
        }
    }
    if (!isdefined(pickedupontouch) || !pickedupontouch) {
        if (isdefined(self.ownersattacker) && self.ownersattacker == player) {
            player.tookweaponfrom[weapon] = spawnstruct();
            player.tookweaponfrom[weapon].previousowner = self.owner;
            player.tookweaponfrom[weapon].weapon = self.weapon;
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
// Checksum 0x43515874, Offset: 0x2af8
// Size: 0x6c
function event_handler[weapon_fired] function_cafc776a(eventstruct) {
    self callback::callback(#"weapon_fired", eventstruct);
    self callback::callback_weapon_fired(eventstruct.weapon);
    self function_f2c53bb2(eventstruct.weapon);
}

// Namespace weapons/weapon_melee
// Params 1, eflags: 0x40
// Checksum 0x95bfa5ff, Offset: 0x2b70
// Size: 0x2c
function event_handler[weapon_melee] function_3eaa5d64(eventstruct) {
    self callback::callback(#"weapon_melee", eventstruct);
}

// Namespace weapons/weapon_melee_charge
// Params 1, eflags: 0x40
// Checksum 0x33174c0f, Offset: 0x2ba8
// Size: 0x2c
function event_handler[weapon_melee_charge] function_9847a517(eventstruct) {
    self callback::callback(#"weapon_melee_charge", eventstruct);
}

// Namespace weapons/weapons
// Params 1, eflags: 0x0
// Checksum 0xed04421b, Offset: 0x2be0
// Size: 0x2d0
function function_f2c53bb2(curweapon) {
    if (!isplayer(self)) {
        return;
    }
    if (sessionmodeiswarzonegame() && game.state !== #"playing") {
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
        self stats::function_eec52333(curweapon, #"shots", 1, self.class_num, 0);
        break;
    default:
        break;
    }
    if (isdefined(curweapon.gadget_type) && curweapon.gadget_type == 11) {
        if (isdefined(self.heavyweaponshots)) {
            self.heavyweaponshots++;
        }
    }
    statweapon = getweapon(curweapon.statname);
    assert(statweapon != level.weaponnone);
    if (statweapon.iscarriedkillstreak) {
        var_607dffd9 = killstreaks::function_fde227c6(curweapon, statweapon);
        if (isdefined(self.pers[#"held_killstreak_ammo_count"][var_607dffd9])) {
            self.pers[#"held_killstreak_ammo_count"][var_607dffd9]--;
        }
        self.usedkillstreakweapon[statweapon.name] = 1;
    }
    self function_f95ea9b6(statweapon);
    if (isdefined(level.var_c8241070)) {
        [[ level.var_c8241070 ]](self, statweapon);
    }
}

// Namespace weapons/weapons
// Params 1, eflags: 0x0
// Checksum 0x57ced42e, Offset: 0x2eb8
// Size: 0x274
function track_fire(curweapon) {
    pixbeginevent(#"");
    weaponpickedup = 0;
    if (isdefined(self.pickedupweapons) && isdefined(self.pickedupweapons[curweapon])) {
        weaponpickedup = 1;
    }
    self trackweaponfirenative(curweapon, 1, isdefined(self.hits) ? self.hits : 0, isdefined(self.headshothits) ? self.headshothits : 0, 1, self.class_num, weaponpickedup);
    if (isdefined(self.totalmatchshots)) {
        self.totalmatchshots++;
    }
    if (isdefined(level.var_b10e134d)) {
        [[ level.var_b10e134d ]](self, curweapon, #"shots", 1);
        [[ level.var_b10e134d ]](self, curweapon, #"hits", self.hits);
    }
    if (isdefined(level.var_4e390265)) {
        [[ level.var_4e390265 ]](self, curweapon, 1, self.hits);
    }
    self bb::add_to_stat("shots", 1);
    self bb::add_to_stat("hits", self.hits);
    if (level.mpcustommatch === 1 || is_true(level.var_674e8051)) {
        self.pers[#"shotsfired"]++;
        shotsmissed = self.pers[#"shotsfired"] - self.pers[#"shotshit"];
        if (shotsmissed < 0) {
            shotsmissed = 0;
        }
        self.pers[#"shotsmissed"] = shotsmissed;
    }
    self.hits = 0;
    self.headshothits = 0;
    profilestop();
}

// Namespace weapons/weapons
// Params 2, eflags: 0x0
// Checksum 0x8db8a475, Offset: 0x3138
// Size: 0x4c
function function_b1d41bd5(weapon, damagedone) {
    self stats::function_eec52333(weapon, #"damagedone", damagedone, self.class_num);
}

// Namespace weapons/weapons
// Params 0, eflags: 0x0
// Checksum 0x827a1e7c, Offset: 0x3190
// Size: 0x74
function on_end_game() {
    for (index = 0; index < level.players.size; index++) {
        player = level.players[index];
        if (isbot(player)) {
            continue;
        }
        player function_53524d84();
    }
}

// Namespace weapons/grenade_pullback
// Params 1, eflags: 0x40
// Checksum 0xb818a068, Offset: 0x3210
// Size: 0xcc
function event_handler[grenade_pullback] function_5755a808(eventstruct) {
    if (!isplayer(self)) {
        return;
    }
    weapon = eventstruct.weapon;
    self stats::function_eec52333(weapon, #"shots", 1, self.class_num);
    self.hasdonecombat = 1;
    self.throwinggrenade = 1;
    self.gotpullbacknotify = 1;
    self thread watch_offhand_end(weapon);
    self thread begin_grenade_tracking();
}

// Namespace weapons/missile_fire
// Params 1, eflags: 0x40
// Checksum 0xf010b29f, Offset: 0x32e8
// Size: 0xec
function event_handler[missile_fire] function_f075cefa(eventstruct) {
    if (!isplayer(self)) {
        return;
    }
    missile = eventstruct.projectile;
    weapon = eventstruct.weapon;
    var_72ed30b7 = eventstruct.target;
    self.hasdonecombat = 1;
    if (isdefined(missile) && isdefined(level.missileentities)) {
        if (!isdefined(level.missileentities)) {
            level.missileentities = [];
        }
        level.missileentities[level.missileentities.size] = missile;
        missile.weapon = weapon;
        missile.var_72ed30b7 = var_72ed30b7;
        missile thread watch_missile_death();
    }
}

// Namespace weapons/weapons
// Params 0, eflags: 0x0
// Checksum 0xd8509787, Offset: 0x33e0
// Size: 0x34
function watch_missile_death() {
    self waittill(#"death");
    arrayremovevalue(level.missileentities, self);
}

// Namespace weapons/weapons
// Params 2, eflags: 0x0
// Checksum 0x73ee226d, Offset: 0x3420
// Size: 0xe6
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
// Checksum 0x80ba8519, Offset: 0x3510
// Size: 0xb4
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
// Checksum 0xf7a53a7d, Offset: 0x35d0
// Size: 0xf6
function watch_grenade_cancel() {
    self endon(#"death", #"disconnect", #"grenade_fire");
    waittillframeend();
    while (true) {
        if (!isplayer(self)) {
            return;
        }
        if (self isthrowinggrenade()) {
            self waittill(#"weapon_change", #"hash_391799142463c3d4");
            continue;
        }
        if (self function_55acff10()) {
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
// Checksum 0xc0699812, Offset: 0x36d0
// Size: 0x1c4
function watch_offhand_end(weapon) {
    self notify(#"watchoffhandend");
    self endon(#"watchoffhandend");
    if (weapon.drawoffhandmodelinhand) {
        self setoffhandvisible(1);
        while (self function_2d96f300(weapon)) {
            msg = self waittill(#"offhand_end", #"death", #"disconnect", #"grenade_fire", #"weapon_change");
            if (msg._notify == #"grenade_fire") {
                if (isdefined(self) && is_true(weapon.var_d69ee9ed) && self getweaponammoclip(weapon) > 0) {
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
// Checksum 0x57b161a3, Offset: 0x38a0
// Size: 0x66
function function_2d96f300(weapon) {
    if (!isdefined(self)) {
        return 0;
    }
    currentweapon = self getcurrentoffhand();
    if (currentweapon == weapon && weapon.drawoffhandmodelinhand) {
        return self function_6577d473();
    }
    return 0;
}

// Namespace weapons/weapons
// Params 2, eflags: 0x0
// Checksum 0xf447a174, Offset: 0x3910
// Size: 0x90
function function_6dafe6d6(grenade, weapon) {
    if (isdefined(weapon) && weapon.name === "eq_hawk") {
        if (isdefined(grenade)) {
            self.throwinggrenade = 0;
            grenade deletedelay();
            if (isdefined(level.hawk_settings.spawn)) {
                self thread [[ level.hawk_settings.spawn ]]();
            }
        }
    }
}

// Namespace weapons/weapons
// Params 0, eflags: 0x0
// Checksum 0x255b2b88, Offset: 0x39a8
// Size: 0x54c
function begin_grenade_tracking() {
    self notify(#"begin_grenade_tracking");
    self endon(#"begin_grenade_tracking", #"death", #"disconnect", #"grenade_throw_cancelled");
    starttime = gettime();
    self thread watch_grenade_cancel();
    waitresult = self waittill(#"grenade_fire");
    grenade = waitresult.projectile;
    function_6dafe6d6(grenade, waitresult.weapon);
    if (!isdefined(grenade)) {
        return;
    }
    weapon = waitresult.weapon;
    cooktime = waitresult.cook_time;
    grenade.originalowner = self;
    assert(isdefined(grenade));
    level.missileentities[level.missileentities.size] = grenade;
    grenade.weapon = weapon;
    grenade thread watch_missile_death();
    if (is_true(level.projectiles_should_ignore_world_pause)) {
        grenade setignorepauseworld(1);
    }
    if (grenade util::ishacked()) {
        return;
    }
    structname = #"mpequipmentuses";
    eventname = #"hash_7cbbee88c5db5494";
    if (sessionmodeiscampaigngame()) {
        structname = #"cpequipmentuses";
        eventname = #"hash_4b0d58055ad60c5a";
    } else if (sessionmodeiszombiesgame()) {
        structname = #"zmequipmentuses";
        eventname = #"hash_637ce41bcec9842c";
    }
    function_92d1707f(eventname, structname, {#gametime:gettime(), #spawnid:getplayerspawnid(self), #weaponname:weapon.name});
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
        self stats::function_e24eec31(weapon, #"used", 1);
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
        self stats::function_e24eec31(weapon, #"used", 1);
        break;
    }
    self.throwinggrenade = 0;
    if (weapon.var_98333ae > 0 && weapon.cookoffholdtime > 0) {
        grenade thread track_cooked_detonation(self, weapon, cooktime);
    } else if (weapon.multidetonation > 0) {
        grenade thread track_multi_detonation(self, weapon, cooktime);
    }
    if (isdefined(level.var_9d47488) && isdefined(level.var_9d47488.script)) {
        self thread [[ level.var_9d47488.script ]](grenade, weapon);
    }
    self thread begin_grenade_tracking();
}

// Namespace weapons/grenade_fire
// Params 1, eflags: 0x40
// Checksum 0xa5683bcb, Offset: 0x3f00
// Size: 0x21a
function event_handler[grenade_fire] function_e2b6d5a5(eventstruct) {
    self callback::callback(#"grenade_fired", eventstruct);
    if (!isplayer(self)) {
        return;
    }
    grenade = eventstruct.projectile;
    weapon = eventstruct.weapon;
    if (grenade util::ishacked()) {
        return;
    }
    if (isdefined(level.var_f9b89e94)) {
        grenade thread [[ level.var_f9b89e94 ]]();
    }
    switch (weapon.rootweapon.name) {
    case #"eq_sticky_grenade":
    case #"eq_cluster_semtex_grenade":
        grenade thread check_stuck_to_player(1, 1, weapon);
        if (isdefined(level.var_b61fb563)) {
            grenade thread [[ level.var_b61fb563 ]]();
        }
        break;
    case #"c4":
    case #"satchel_charge":
        grenade thread check_stuck_to_player(1, 0, weapon);
        break;
    case #"hatchet":
        grenade.lastweaponbeforetoss = self function_fe1f5cc();
        grenade thread check_hatchet_bounce();
        grenade thread check_stuck_to_player(0, 0, weapon);
        self stats::function_e24eec31(weapon, #"used", 1);
        break;
    default:
        break;
    }
}

// Namespace weapons/grenade_throwback
// Params 1, eflags: 0x40
// Checksum 0x8ac3d54f, Offset: 0x4128
// Size: 0x3a
function event_handler[grenade_throwback] function_e32d30(eventstruct) {
    eventstruct.projectile.throwback = 1;
    eventstruct.projectile.previousowner = eventstruct.owner;
}

// Namespace weapons/offhand_fire
// Params 1, eflags: 0x40
// Checksum 0x8e03303e, Offset: 0x4170
// Size: 0x2c
function event_handler[offhand_fire] function_97023fdf(eventstruct) {
    self callback::callback(#"offhand_fire", eventstruct);
}

// Namespace weapons/grenade_launcher_fire
// Params 1, eflags: 0x40
// Checksum 0x782cae55, Offset: 0x41a8
// Size: 0x2c
function event_handler[grenade_launcher_fire] function_aa7da3a(eventstruct) {
    self callback::callback(#"hash_198a389d6b65f68d", eventstruct);
}

// Namespace weapons/weapons
// Params 1, eflags: 0x0
// Checksum 0xa77eabe8, Offset: 0x41e0
// Size: 0x44
function function_43ec7f33(*str_notify) {
    killcament = self.killcament;
    waitframe(1);
    if (isdefined(killcament)) {
        killcament delete();
    }
}

// Namespace weapons/weapons
// Params 1, eflags: 0x0
// Checksum 0x6d1dc228, Offset: 0x4230
// Size: 0x116
function function_5ed178fd(owner) {
    owner endon(#"death", #"stuck_to_player");
    self endon(#"death");
    owner endoncallback(&function_43ec7f33, #"death", #"stuck_to_player");
    while (true) {
        waitframe(1);
        forward = anglestoforward(owner.angles);
        pos = owner.origin - forward * 20;
        if (!function_3238d10d(pos)) {
            owner.killcament delete();
            return;
        }
        self.origin = pos;
    }
}

// Namespace weapons/weapons
// Params 3, eflags: 0x0
// Checksum 0x53431040, Offset: 0x4350
// Size: 0x2a2
function check_stuck_to_player(deleteonteamchange, awardscoreevent, weapon) {
    self endon(#"death");
    if (function_3238d10d(self.origin) && !sessionmodeiscampaigngame()) {
        killcament = spawn("script_model", self.origin);
        killcament.targetname = "killcament_" + weapon.name;
        killcament setweapon(weapon);
        self.killcament = killcament;
        killcament thread function_5ed178fd(self);
    }
    waitresult = self waittill(#"stuck_to_player");
    player = waitresult.player;
    if (isdefined(killcament)) {
        forward = anglestoforward(self.angles);
        pos = self.origin - forward * 200;
        if (isdefined(player)) {
            dir = player.origin - pos;
            dir = vectornormalize(dir);
            killcament.angles = vectortoangles(dir);
        }
        if (function_3238d10d(pos)) {
            killcament.origin = pos;
        } else {
            killcament delete();
        }
    }
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
// Checksum 0xa1523453, Offset: 0x4600
// Size: 0x46
function check_hatchet_bounce() {
    self endon(#"stuck_to_player", #"death");
    self waittill(#"grenade_bounce");
    self.bounced = 1;
}

// Namespace weapons/weapons
// Params 1, eflags: 0x0
// Checksum 0xc166648d, Offset: 0x4650
// Size: 0xb2
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
// Checksum 0xea21eb15, Offset: 0x4710
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
// Checksum 0xe7e5916c, Offset: 0x4760
// Size: 0x24
function gettimefromlevelstart() {
    if (!isdefined(level.starttime)) {
        return 0;
    }
    return gettime() - level.starttime;
}

// Namespace weapons/weapons
// Params 3, eflags: 0x0
// Checksum 0xe02a9651, Offset: 0x4790
// Size: 0x174
function turn_grenade_into_a_dud(weapon, isthrowngrenade, player) {
    if (currentsessionmode() == 2) {
        return;
    }
    time = float(gettimefromlevelstart()) / 1000;
    if (level.roundstartexplosivedelay >= time) {
        if (weapon.disallowatmatchstart) {
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
// Checksum 0x83b9297c, Offset: 0x4910
// Size: 0x54
function function_c135199b(params) {
    grenade = params.projectile;
    weapon = params.weapon;
    grenade turn_grenade_into_a_dud(weapon, 1, self);
}

// Namespace weapons/weapons
// Params 1, eflags: 0x0
// Checksum 0x11a250a5, Offset: 0x4970
// Size: 0x24
function on_grenade_fired(params) {
    function_c135199b(params);
}

// Namespace weapons/weapons
// Params 1, eflags: 0x0
// Checksum 0xc236b986, Offset: 0x49a0
// Size: 0xb4
function function_4b7977fe(params) {
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
// Checksum 0xce58dae8, Offset: 0x4a60
// Size: 0x512
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
// Checksum 0xa5b9dfe0, Offset: 0x4f80
// Size: 0x64
function damage_trace_passed(from, to, startradius, ignore) {
    trace = damage_trace(from, to, startradius, ignore);
    return trace[#"fraction"] == 1;
}

// Namespace weapons/weapons
// Params 4, eflags: 0x0
// Checksum 0xd642e861, Offset: 0x4ff0
// Size: 0x1d8
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
// Checksum 0x9b1a67f5, Offset: 0x51d0
// Size: 0x16c
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
// Checksum 0x355ddb25, Offset: 0x5348
// Size: 0x132
function on_damage(eattacker, einflictor, weapon, meansofdeath, damage) {
    self endon(#"death", #"disconnect");
    if (isdefined(level._custom_weapon_damage_func)) {
        is_weapon_registered = self [[ level._custom_weapon_damage_func ]](eattacker, einflictor, weapon, meansofdeath, damage);
        if (is_weapon_registered) {
            return;
        }
    }
    switch (weapon.statname) {
    case #"eq_slow_grenade":
    case #"concussion_grenade":
        self.lastconcussedby = eattacker;
        break;
    default:
        if (isdefined(level.shellshockonplayerdamage) && isplayer(self)) {
            [[ level.shellshockonplayerdamage ]](eattacker, einflictor, weapon, meansofdeath, damage);
        }
        break;
    }
}

// Namespace weapons/weapons
// Params 1, eflags: 0x0
// Checksum 0x419a5130, Offset: 0x5488
// Size: 0x164
function play_concussion_sound(duration) {
    self endon(#"death", #"disconnect");
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
// Checksum 0xc4d106f8, Offset: 0x55f8
// Size: 0x4c
function delete_ent_on_owner_death(owner) {
    self endon(#"delete");
    owner waittill(#"death");
    self delete();
}

// Namespace weapons/weapons
// Params 1, eflags: 0x0
// Checksum 0x37857140, Offset: 0x5650
// Size: 0x5c
function function_1e2ad832(weapon) {
    player = self;
    if (!isdefined(player.var_9c4683a0)) {
        player.var_9c4683a0 = [];
    }
    array::add(player.var_9c4683a0, weapon);
    force_stowed_weapon_update();
}

// Namespace weapons/weapons
// Params 1, eflags: 0x0
// Checksum 0x824fbe35, Offset: 0x56b8
// Size: 0xbc
function function_8f148257(weapon) {
    player = self;
    if (!isdefined(player.var_9c4683a0)) {
        return;
    }
    foundindex = undefined;
    for (index = 0; index < player.var_9c4683a0.size; index++) {
        if (player.var_9c4683a0[index] == weapon) {
            foundindex = index;
        }
    }
    if (!isdefined(foundindex)) {
        return;
    }
    player.var_9c4683a0 = array::remove_index(player.var_9c4683a0, foundindex);
    force_stowed_weapon_update();
}

// Namespace weapons/weapons
// Params 1, eflags: 0x0
// Checksum 0xcab6a4bb, Offset: 0x5780
// Size: 0x3c4
function on_weapon_change(params) {
    if (level.trackweaponstats) {
        if (!isdefined(self.var_e09dd2bf)) {
            self.var_e09dd2bf = gettime();
        }
        if (params.last_weapon != level.weaponnone) {
            self bb::commit_weapon_data(getplayerspawnid(self), params.last_weapon, self.var_e09dd2bf);
        }
        if (params.weapon != level.weaponnone && params.weapon != params.last_weapon) {
            self.var_e09dd2bf = gettime();
            update_last_held_weapon_timings(self.var_e09dd2bf);
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
// Checksum 0x508a828f, Offset: 0x5b50
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
// Checksum 0x5c87f19d, Offset: 0x5bd8
// Size: 0x55c
function scavenger_think() {
    self endon(#"death");
    waitresult = self waittill(#"scavenger");
    player = waitresult.player;
    primary_weapons = player getweaponslistprimaries();
    if (is_true(level.var_d98576f2)) {
        offhand_weapons_and_alts = array::exclude(player getweaponslist(1), primary_weapons);
        arrayremovevalue(offhand_weapons_and_alts, level.weaponbasemelee);
        offhand_weapons_and_alts = array::reverse(offhand_weapons_and_alts);
        player.scavenged = 0;
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
                } else if (weapon.isheavyweapon && is_true(level.overrideammodropheavyweapon)) {
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
                player thread challenges::scavengedgrenade(weapon);
            }
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
        clip *= getdvarfloat(#"scavenger_clip_multiplier", 2);
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
    if (player.scavenged) {
        player playsound(#"wpn_ammo_pickup");
        player playlocalsound(#"wpn_ammo_pickup");
        player hud::function_4a4de0de();
    }
}

// Namespace weapons/weapons
// Params 1, eflags: 0x0
// Checksum 0xcfad755, Offset: 0x6140
// Size: 0x14c
function drop_scavenger_for_death(attacker) {
    if (is_true(level.var_827f5a28)) {
        return;
    }
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
    if (is_true(level.var_8c5a071d)) {
        if (isdefined(self.var_e602a1ca)) {
            self.var_e602a1ca delete();
        }
        self.var_e602a1ca = item;
    }
    item thread scavenger_think();
}

// Namespace weapons/weapons
// Params 3, eflags: 0x0
// Checksum 0x2b712bee, Offset: 0x6298
// Size: 0x5a
function add_limited_weapon(weapon, owner, num_drops) {
    limited_info = spawnstruct();
    limited_info.weapon = weapon;
    limited_info.drops = num_drops;
    owner.limited_info = limited_info;
}

// Namespace weapons/weapons
// Params 2, eflags: 0x0
// Checksum 0x8a75d9d4, Offset: 0x6300
// Size: 0x6a
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
// Checksum 0x39943c91, Offset: 0x6378
// Size: 0x8c
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
// Checksum 0x74ec50c5, Offset: 0x6410
// Size: 0x6a
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
// Checksum 0xedeb9cc1, Offset: 0x6488
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
// Checksum 0xc98f2bcd, Offset: 0x6510
// Size: 0x1d4
function ninebang_doninebang(attacker, weapon, cooktime) {
    level endon(#"game_ended");
    maxstages = weapon.var_98333ae;
    cookstages = min(floor(cooktime / weapon.cookoffholdtime * maxstages), maxstages);
    intervaltime = float(weapon.var_1c0e3cb7) / 1000;
    var_9729fdb9 = float(weapon.var_4941de5) / 1000;
    cookstages *= 3;
    if (!cookstages) {
        cookstages = 3;
    }
    wait float(weapon.fusetime) / 1000;
    for (i = 0; i < cookstages; i++) {
        if (!isdefined(self)) {
            return;
        }
        if (!isdefined(attacker)) {
            break;
        }
        attacker magicgrenadeplayer(weapon.grenadeweapon, self.origin, (0, 0, 0));
        if ((i + 1) % 3 == 0) {
            wait var_9729fdb9;
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
// Checksum 0x48bce573, Offset: 0x66f0
// Size: 0x254
function track_multi_detonation(ownerent, weapon, *cooktime) {
    self endon(#"trophy_destroyed");
    waitresult = self waittill(#"explode", #"death");
    if (waitresult._notify == "death") {
        return;
    }
    for (i = 0; i < cooktime.multidetonation; i++) {
        if (!isdefined(weapon)) {
            return;
        }
        dir = level multi_detonation_get_cluster_launch_dir(cooktime, i, cooktime.multidetonation, waitresult.normal);
        fusetime = randomfloatrange(cooktime.var_cb3d0f65, cooktime.var_cd539cb2);
        speed = randomintrangeinclusive(cooktime.var_95d8fabf, cooktime.var_c264efc6);
        vel = dir * speed;
        var_561c6e7c = waitresult.position + dir * 5;
        if (cooktime === getweapon(#"hash_117b6097e272dd1f")) {
            var_d097c411 = getweapon(#"cymbal_monkey");
            grenade = weapon magicgrenadetype(var_d097c411, var_561c6e7c, vel, fusetime);
            grenade util::deleteaftertime(180);
        } else {
            var_d097c411 = cooktime.grenadeweapon;
            grenade = weapon magicgrenadetype(var_d097c411, var_561c6e7c, vel, fusetime);
        }
        util::wait_network_frame();
    }
}

// Namespace weapons/weapons
// Params 4, eflags: 0x0
// Checksum 0xb2b07d86, Offset: 0x6950
// Size: 0x18a
function multi_detonation_get_cluster_launch_dir(weapon, index, multival, normal) {
    pitch = randomfloatrange(weapon.var_367c47fc, weapon.var_7872b3a);
    var_a978e158 = randomfloatrange(weapon.var_ccebc40 * -1, weapon.var_ccebc40);
    yaw = -180 + 360 / multival * index + var_a978e158;
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
// Checksum 0x1674055b, Offset: 0x6ae8
// Size: 0x74
function event_handler[grenade_stuck] function_5c5941ef(eventstruct) {
    grenade = eventstruct.projectile;
    if (!isdefined(grenade)) {
        return;
    }
    if (!isdefined(self.var_7c9174d1)) {
        self.var_7c9174d1 = [];
    }
    arrayremovevalue(self.var_7c9174d1, undefined);
    array::add(self.var_7c9174d1, grenade);
}

// Namespace weapons/weapons
// Params 3, eflags: 0x0
// Checksum 0x33787123, Offset: 0x6b68
// Size: 0x35e
function function_356292be(owner, origin, radius) {
    owner_team = isdefined(owner) ? owner.team : undefined;
    if (level.teambased && isdefined(owner_team) && level.friendlyfire == 0) {
        potential_targets = [];
        potential_targets = arraycombine(potential_targets, function_dbb62de0(owner_team, origin, radius), 0, 0);
        potential_targets = arraycombine(potential_targets, function_fd768835(owner_team, origin, radius), 0, 0);
        potential_targets = arraycombine(potential_targets, function_5db5c32(owner_team, origin, radius), 0, 0);
        if (isdefined(level.missileentities) && level.missileentities.size > 0 && isplayer(owner)) {
            var_f1fe3f3c = owner getentitiesinrange(level.missileentities, int(radius), origin);
            potential_targets = arraycombine(potential_targets, var_f1fe3f3c, 0, 0);
        }
        return potential_targets;
    }
    all_targets = [];
    all_targets = arraycombine(all_targets, function_8c285f35(origin, radius), 0, 0);
    all_targets = arraycombine(all_targets, function_a38db454(origin, radius), 0, 0);
    if (level.friendlyfire > 0) {
        return all_targets;
    }
    potential_targets = [];
    foreach (target in all_targets) {
        if (!isdefined(target)) {
            continue;
        }
        if (!isdefined(target.team)) {
            continue;
        }
        if (isdefined(owner)) {
            if (target != owner) {
                if (!isdefined(owner_team)) {
                    continue;
                }
                if (!util::function_fbce7263(target.team, owner_team)) {
                    continue;
                }
            }
        } else {
            if (!isdefined(self)) {
                continue;
            }
            if (!isdefined(self.team)) {
                continue;
            }
            if (!util::function_fbce7263(target.team, self.team)) {
                continue;
            }
        }
        potential_targets[potential_targets.size] = target;
    }
    return potential_targets;
}

// Namespace weapons/weapons
// Params 0, eflags: 0x0
// Checksum 0x79257885, Offset: 0x6ed0
// Size: 0xc4
function function_830e007d() {
    for (i = 0; i < level.missileentities.size; i++) {
        item = level.missileentities[i];
        if (!isdefined(item)) {
            continue;
        }
        if (!isdefined(item.weapon)) {
            continue;
        }
        if (item.owner !== self && item.originalowner !== self) {
            continue;
        }
        item notify(#"detonating");
        if (isdefined(item)) {
            item delete();
        }
    }
}

// Namespace weapons/weapons
// Params 6, eflags: 0x0
// Checksum 0x84928efc, Offset: 0x6fa0
// Size: 0x36c
function dropweaponfordeathlaunch(item, damage, angles, weapon, var_a5baf64e, var_6f02cffb) {
    if (!isdefined(item)) {
        println("<dev string:x1a3>");
        return;
    }
    if (!isdefined(item.model) || item.model == #"") {
        println("<dev string:x1dc>" + weapon.name);
        return;
    }
    if (!item hasdobj()) {
        println("<dev string:x212>" + weapon.name);
        return;
    }
    if (!isdefined(damage)) {
        damage = 0;
    }
    normalizeddamage = math::normalize_value(0, 200, damage);
    var_92043f3a = math::factor_value(250 * var_6f02cffb, 320 * var_6f02cffb, normalizeddamage);
    var_9e5cfd66 = randomfloatrange(40 * var_a5baf64e, 80 * var_a5baf64e);
    var_19a39012 = randomfloatrange(40 * var_a5baf64e, 80 * var_a5baf64e);
    if (math::cointoss()) {
        var_19a39012 *= -1;
    }
    if (!isdefined(angles)) {
        angles = self.angles;
    }
    launchvelocity = (0, 0, 0);
    launchvelocity += anglestoforward(angles) * var_9e5cfd66;
    launchvelocity += anglestoright(angles) * var_19a39012;
    launchvelocity += anglestoup(angles) * var_92043f3a;
    var_f45e7999 = randomfloatrange(100, 150);
    if (math::cointoss()) {
        var_f45e7999 *= -1;
    }
    var_af228248 = randomfloatrange(100, 150);
    if (math::cointoss()) {
        var_af228248 *= -1;
    }
    var_46dcaa45 = randomfloatrange(250, 350);
    if (math::cointoss()) {
        var_46dcaa45 *= -1;
    }
    var_342f4a88 = (var_f45e7999, var_af228248, var_46dcaa45);
    item function_1e25084(launchvelocity, var_342f4a88);
}

