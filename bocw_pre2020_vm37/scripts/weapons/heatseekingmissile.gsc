#using scripts\core_common\battlechatter;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\challenges_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\dev_shared;
#using scripts\core_common\scoreevents_shared;
#using scripts\core_common\util_shared;
#using scripts\killstreaks\killstreaks_shared;

#namespace heatseekingmissile;

// Namespace heatseekingmissile/heatseekingmissile
// Params 0, eflags: 0x1 linked
// Checksum 0x85cedd0d, Offset: 0x188
// Size: 0x84
function init_shared() {
    game.locking_on_sound = "uin_alert_lockon_start";
    game.locked_on_sound = "uin_alert_lockon";
    callback::on_spawned(&on_player_spawned);
    level.fx_flare = #"hash_409b85809816c79b";
    /#
        setdvar(#"scr_freelock", 0);
    #/
}

// Namespace heatseekingmissile/heatseekingmissile
// Params 0, eflags: 0x1 linked
// Checksum 0xac60f593, Offset: 0x218
// Size: 0x4c
function on_player_spawned() {
    self endon(#"disconnect");
    self clearirtarget();
    self callback::on_weapon_change(&on_weapon_change);
}

// Namespace heatseekingmissile/heatseekingmissile
// Params 0, eflags: 0x1 linked
// Checksum 0x724e99dc, Offset: 0x270
// Size: 0x1ec
function clearirtarget() {
    self notify(#"stop_lockon_sound");
    self notify(#"stop_locked_sound");
    self.stingerlocksound = undefined;
    self stoprumble("stinger_lock_rumble");
    self.stingerlockstarttime = 0;
    self.stingerlockstarted = 0;
    self.stingerlockfinalized = 0;
    self.stingerlockdetected = 0;
    if (isdefined(self.stingertarget)) {
        self.stingertarget notify(#"missile_unlocked");
        clientnum = self getentitynumber();
        if ((self.stingertarget.locked_on & 1 << clientnum) != 0) {
            self notify(#"hash_41e93a518427847c");
        }
        self lockingon(self.stingertarget, 0);
        self lockedon(self.stingertarget, 0);
    }
    self.stingertarget = undefined;
    self.stingersubtarget = undefined;
    self weaponlockfree();
    self weaponlocktargettooclose(0);
    self weaponlocknoclearance(0);
    self stoplocalsound(game.locking_on_sound);
    self stoplocalsound(game.locked_on_sound);
    /#
        self destroylockoncanceledmessage();
    #/
}

// Namespace heatseekingmissile/heatseekingmissile
// Params 2, eflags: 0x1 linked
// Checksum 0x3021e7c1, Offset: 0x468
// Size: 0x84
function function_5e6cd0ab(weapon, attacker) {
    params = {#weapon:weapon, #attacker:attacker};
    self notify(#"missile_lock", params);
    self callback::callback(#"missile_lock", params);
}

// Namespace heatseekingmissile/heatseekingmissile
// Params 3, eflags: 0x1 linked
// Checksum 0xe530326, Offset: 0x4f8
// Size: 0x9c
function function_a439ae56(missile, weapon, attacker) {
    params = {#projectile:missile, #weapon:weapon, #attacker:attacker};
    self notify(#"stinger_fired_at_me", params);
    self callback::callback(#"hash_1a32e0fdeb70a76b", params);
}

// Namespace heatseekingmissile/missile_fire
// Params 1, eflags: 0x40
// Checksum 0xb59cf39e, Offset: 0x5a0
// Size: 0x124
function event_handler[missile_fire] function_a3d258b6(eventstruct) {
    missile = eventstruct.projectile;
    weapon = eventstruct.weapon;
    target = eventstruct.target;
    /#
        if (getdvarint(#"scr_debug_missile", 0) != 0) {
            thread debug_missile(missile);
        }
    #/
    if (weapon.lockontype == "Legacy Single") {
        if (isplayer(self) && isdefined(self.stingertarget) && self.stingerlockfinalized) {
            self.stingertarget function_a439ae56(missile, weapon, self);
            return;
        }
        if (isdefined(target)) {
            target function_a439ae56(missile, weapon, self);
        }
    }
}

/#

    // Namespace heatseekingmissile/heatseekingmissile
    // Params 1, eflags: 0x0
    // Checksum 0xa03e8030, Offset: 0x6d0
    // Size: 0x21a
    function debug_missile(missile) {
        level notify(#"debug_missile");
        level endon(#"debug_missile");
        level.debug_missile_dots = [];
        while (true) {
            if (isdefined(missile)) {
                missile_info = spawnstruct();
                missile_info.origin = missile.origin;
                target = missile missile_gettarget();
                missile_info.targetentnum = isdefined(target) ? target getentitynumber() : undefined;
                if (!isdefined(level.debug_missile_dots)) {
                    level.debug_missile_dots = [];
                } else if (!isarray(level.debug_missile_dots)) {
                    level.debug_missile_dots = array(level.debug_missile_dots);
                }
                level.debug_missile_dots[level.debug_missile_dots.size] = missile_info;
            }
            foreach (missile_info in level.debug_missile_dots) {
                dot_color = isdefined(missile_info.targetentnum) ? (1, 0, 0) : (0, 1, 0);
                dev::debug_sphere(missile_info.origin, 10, dot_color, 0.66, 1);
            }
            waitframe(1);
        }
    }

#/

// Namespace heatseekingmissile/heatseekingmissile
// Params 1, eflags: 0x1 linked
// Checksum 0x36bb9c9, Offset: 0x8f8
// Size: 0xb2
function getappropriateplayerweapon(currentweapon) {
    appropriateweapon = currentweapon;
    if (self.usingvehicle) {
        vehicleseatposition = isdefined(self.vehicleposition) ? self.vehicleposition : 0;
        vehicleentity = self.viewlockedentity;
        if (isdefined(vehicleentity) && isvehicle(vehicleentity)) {
            appropriateweapon = vehicleentity seatgetweapon(vehicleseatposition);
            if (!isdefined(appropriateweapon)) {
                appropriateweapon = currentweapon;
            }
        }
    }
    return appropriateweapon;
}

// Namespace heatseekingmissile/heatseekingmissile
// Params 0, eflags: 0x1 linked
// Checksum 0x52d2629a, Offset: 0x9b8
// Size: 0x98
function stingerwaitforads() {
    while (!self playerstingerads()) {
        waitframe(1);
        currentweapon = self getcurrentweapon();
        weapon = getappropriateplayerweapon(currentweapon);
        if (weapon.lockontype != "Legacy Single" || weapon.noadslockoncheck) {
            return false;
        }
    }
    return true;
}

// Namespace heatseekingmissile/heatseekingmissile
// Params 1, eflags: 0x1 linked
// Checksum 0x18157832, Offset: 0xa58
// Size: 0x208
function on_weapon_change(params) {
    self endon(#"death", #"disconnect");
    weapon = self getappropriateplayerweapon(params.weapon);
    while (weapon.lockontype == "Legacy Single") {
        weaponammoclip = self getweaponammoclip(weapon);
        if (weaponammoclip == 0 && !weapon.unlimitedammo) {
            waitframe(1);
            currentweapon = self getcurrentweapon();
            weapon = self getappropriateplayerweapon(params.weapon);
            continue;
        }
        if (!weapon.noadslockoncheck && !stingerwaitforads()) {
            break;
        }
        self thread stingerirtloop(weapon);
        if (weapon.noadslockoncheck) {
            waitresult = self waittill(#"weapon_change");
            weapon = self getappropriateplayerweapon(waitresult.weapon);
        } else {
            while (self playerstingerads()) {
                waitframe(1);
            }
            currweap = self getcurrentweapon();
            weapon = self getappropriateplayerweapon(currweap);
        }
        self notify(#"stinger_irt_off");
        self clearirtarget();
    }
}

// Namespace heatseekingmissile/heatseekingmissile
// Params 1, eflags: 0x1 linked
// Checksum 0xfd919780, Offset: 0xc68
// Size: 0x790
function stingerirtloop(weapon) {
    self endon(#"disconnect", #"death", #"stinger_irt_off");
    locklength = self getlockonspeed();
    if (!isdefined(self.stingerlockfinalized)) {
        self.stingerlockfinalized = 0;
    }
    for (;;) {
        waitframe(1);
        if (!self hasweapon(weapon)) {
            return;
        }
        currentweapon = self getcurrentweapon();
        currentplayerweapon = self getappropriateplayerweapon(currentweapon);
        if (currentplayerweapon !== weapon) {
            continue;
        }
        if (is_true(self.stingerlockfinalized)) {
            passed = softsighttest(1);
            if (!passed) {
                continue;
            }
            if (!self isstillvalidtarget(self.stingertarget, weapon) || self insidestingerreticlelocked(self.stingertarget, self.stingersubtarget, weapon) == 0) {
                self setweaponlockonpercent(weapon, 0);
                self clearirtarget();
                continue;
            }
            if (!self.stingertarget.locked_on) {
                self.stingertarget function_5e6cd0ab(self getcurrentweapon(), self);
            }
            self lockingon(self.stingertarget, 0);
            self lockedon(self.stingertarget, 1);
            if (isdefined(weapon)) {
                setfriendlyflags(weapon, self.stingertarget);
            }
            thread looplocallocksound(game.locked_on_sound, 0.75);
            continue;
        }
        if (is_true(self.stingerlockstarted)) {
            if (!self isstillvalidtarget(self.stingertarget, weapon) || self insidestingerreticlelocked(self.stingertarget, self.stingersubtarget, weapon) == 0) {
                self setweaponlockonpercent(weapon, 0);
                self clearirtarget();
                continue;
            }
            self lockingon(self.stingertarget, 1);
            self lockedon(self.stingertarget, 0);
            if (isdefined(weapon)) {
                setfriendlyflags(weapon, self.stingertarget);
            }
            passed = softsighttest(1);
            if (!passed) {
                continue;
            }
            timepassed = gettime() - self.stingerlockstarttime;
            if (isdefined(weapon)) {
                lockpct = 1;
                if (locklength > 0) {
                    lockpct = timepassed / locklength;
                }
                self setweaponlockonpercent(weapon, lockpct * 100);
                setfriendlyflags(weapon, self.stingertarget);
            }
            if (timepassed < locklength) {
                continue;
            }
            assert(isdefined(self.stingertarget));
            self notify(#"stop_lockon_sound");
            self.stingerlockfinalized = 1;
            self weaponlockfinalize(self.stingertarget, 0, self.stingersubtarget);
            continue;
        }
        result = self getbeststingertarget(weapon);
        besttarget = result[#"target"];
        bestsubtarget = result[#"subtarget"];
        if (!isdefined(besttarget) || isdefined(self.stingertarget) && self.stingertarget != besttarget) {
            /#
                self destroylockoncanceledmessage();
            #/
            if (self.stingerlockdetected == 1) {
                self weaponlockfree();
                self.stingerlockdetected = 0;
            }
            continue;
        }
        if (!self locksighttest(besttarget)) {
            /#
                self destroylockoncanceledmessage();
            #/
            continue;
        }
        if (isdefined(besttarget.lockondelay) && besttarget.lockondelay) {
            /#
                self displaylockoncanceledmessage();
            #/
            continue;
        }
        if (!targetwithinrangeofplayspace(besttarget)) {
            /#
                self displaylockoncanceledmessage();
            #/
            continue;
        }
        if (!function_1b76fb42(besttarget, weapon)) {
            /#
                self displaylockoncanceledmessage();
            #/
            continue;
        }
        /#
            self destroylockoncanceledmessage();
        #/
        if (self insidestingerreticlelocked(besttarget, bestsubtarget, weapon) == 0) {
            if (self.stingerlockdetected == 0) {
                self weaponlockdetect(besttarget, 0, bestsubtarget);
            }
            self.stingerlockdetected = 1;
            if (isdefined(weapon)) {
                setfriendlyflags(weapon, besttarget);
            }
            continue;
        }
        self.stingerlockdetected = 0;
        initlockfield(besttarget);
        self.stingertarget = besttarget;
        self.stingersubtarget = bestsubtarget;
        self.stingerlockstarttime = gettime();
        self.stingerlockstarted = 1;
        self.stingerlostsightlinetime = 0;
        self weaponlockstart(besttarget, 0, bestsubtarget);
        self thread looplocalseeksound(game.locking_on_sound, 0.6);
    }
}

// Namespace heatseekingmissile/heatseekingmissile
// Params 1, eflags: 0x1 linked
// Checksum 0x2498378, Offset: 0x1400
// Size: 0x176
function targetwithinrangeofplayspace(target) {
    /#
        if (getdvarint(#"scr_missilelock_playspace_extra_radius_override_enabled", 0) > 0) {
            extraradiusdvar = getdvarint(#"scr_missilelock_playspace_extra_radius", 5000);
            if (extraradiusdvar != (isdefined(level.missilelockplayspacecheckextraradius) ? level.missilelockplayspacecheckextraradius : 0)) {
                level.missilelockplayspacecheckextraradius = extraradiusdvar;
                level.missilelockplayspacecheckradiussqr = undefined;
            }
        }
    #/
    if (level.missilelockplayspacecheckenabled === 1) {
        if (!isdefined(target)) {
            return false;
        }
        if (!isdefined(level.playspacecenter)) {
            level.playspacecenter = util::getplayspacecenter();
        }
        if (!isdefined(level.missilelockplayspacecheckradiussqr)) {
            level.missilelockplayspacecheckradiussqr = function_a3f6cdac(util::getplayspacemaxwidth() * 0.5 + level.missilelockplayspacecheckextraradius);
        }
        if (distance2dsquared(target.origin, level.playspacecenter) > level.missilelockplayspacecheckradiussqr) {
            return false;
        }
    }
    return true;
}

/#

    // Namespace heatseekingmissile/heatseekingmissile
    // Params 0, eflags: 0x0
    // Checksum 0x3ebcb258, Offset: 0x1580
    // Size: 0x2c
    function destroylockoncanceledmessage() {
        if (isdefined(self.lockoncanceledmessage)) {
            self.lockoncanceledmessage destroy();
        }
    }

    // Namespace heatseekingmissile/heatseekingmissile
    // Params 0, eflags: 0x0
    // Checksum 0xd7ba5c15, Offset: 0x15b8
    // Size: 0x144
    function displaylockoncanceledmessage() {
        if (isdefined(self.lockoncanceledmessage)) {
            return;
        }
        self.lockoncanceledmessage = newdebughudelem(self);
        self.lockoncanceledmessage.fontscale = 1.25;
        self.lockoncanceledmessage.x = 0;
        self.lockoncanceledmessage.y = 50;
        self.lockoncanceledmessage.alignx = "<dev string:x38>";
        self.lockoncanceledmessage.aligny = "<dev string:x42>";
        self.lockoncanceledmessage.horzalign = "<dev string:x38>";
        self.lockoncanceledmessage.vertalign = "<dev string:x42>";
        self.lockoncanceledmessage.foreground = 1;
        self.lockoncanceledmessage.hidewheninmenu = 1;
        self.lockoncanceledmessage.archived = 0;
        self.lockoncanceledmessage.alpha = 1;
        self.lockoncanceledmessage settext(#"hash_31537402e7b1c369");
    }

#/

// Namespace heatseekingmissile/heatseekingmissile
// Params 1, eflags: 0x5 linked
// Checksum 0xa3fc4959, Offset: 0x1708
// Size: 0x9e
function private function_d656e945(team) {
    if (!isdefined(self.team)) {
        return false;
    }
    vehicle_team = self.team;
    if (vehicle_team == #"neutral") {
        driver = self getseatoccupant(0);
        if (isdefined(driver)) {
            vehicle_team = driver.team;
        }
    }
    if (util::function_fbce7263(vehicle_team, team)) {
        return true;
    }
    return false;
}

// Namespace heatseekingmissile/heatseekingmissile
// Params 1, eflags: 0x1 linked
// Checksum 0x25beba15, Offset: 0x17b0
// Size: 0x4ac
function getbeststingertarget(weapon) {
    result = [];
    targetsall = [];
    if (isdefined(self.get_stinger_target_override)) {
        targetsall = self [[ self.get_stinger_target_override ]]();
    } else {
        targetsall = target_getarray();
    }
    targetsvalid = [];
    subtargetsvalid = [];
    for (idx = 0; idx < targetsall.size; idx++) {
        /#
            if (getdvarint(#"scr_freelock", 0) == 1) {
                if (self insidestingerreticlenolock(targetsall[idx], undefined, weapon)) {
                    targetsvalid[targetsvalid.size] = targetsall[idx];
                }
                continue;
            }
        #/
        target = targetsall[idx];
        if (!isdefined(target)) {
            continue;
        }
        subtargets = target_getsubtargets(target);
        for (sidx = 0; sidx < subtargets.size; sidx++) {
            subtarget = subtargets[sidx];
            if (isdefined(target)) {
                if (level.teambased || level.use_team_based_logic_for_locking_on === 1) {
                    if (target function_d656e945(self.team)) {
                        if (self insidestingerreticledetect(target, subtarget, weapon)) {
                            if (!isdefined(self.is_valid_target_for_stinger_override) || self [[ self.is_valid_target_for_stinger_override ]](target)) {
                                if (!isentity(target) || isalive(target)) {
                                    hascamo = isdefined(target.camo_state) && target.camo_state == 1 && !self hasperk(#"specialty_showenemyequipment");
                                    if (!hascamo) {
                                        targetsvalid[targetsvalid.size] = target;
                                        subtargetsvalid[subtargetsvalid.size] = subtarget;
                                    }
                                }
                            }
                        }
                    }
                    continue;
                }
                if (self insidestingerreticledetect(target, subtarget, weapon)) {
                    if (isdefined(target.owner) && self != target.owner || isplayer(target) && self != target) {
                        if (!isdefined(self.is_valid_target_for_stinger_override) || self [[ self.is_valid_target_for_stinger_override ]](target)) {
                            if (!isentity(target) || isalive(target)) {
                                targetsvalid[targetsvalid.size] = target;
                                subtargetsvalid[subtargetsvalid.size] = subtarget;
                            }
                        }
                    }
                }
            }
        }
    }
    if (targetsvalid.size == 0) {
        return result;
    }
    besttarget = targetsvalid[0];
    bestsubtarget = subtargetsvalid[0];
    if (targetsvalid.size > 1) {
        closestratio = 0;
        foreach (target in targetsvalid) {
            ratio = ratiodistancefromscreencenter(target, subtarget, weapon);
            if (ratio > closestratio) {
                closestratio = ratio;
                besttarget = target;
            }
        }
    }
    result[#"target"] = besttarget;
    result[#"subtarget"] = bestsubtarget;
    return result;
}

// Namespace heatseekingmissile/heatseekingmissile
// Params 3, eflags: 0x1 linked
// Checksum 0x97bcaf55, Offset: 0x1c68
// Size: 0xf0
function calclockonradius(target, *subtarget, weapon) {
    radius = self getlockonradius();
    if (isdefined(weapon) && isdefined(weapon.lockonscreenradius) && weapon.lockonscreenradius > radius) {
        radius = weapon.lockonscreenradius;
    }
    if (isdefined(level.lockoncloserange) && isdefined(level.lockoncloseradiusscaler)) {
        dist2 = distancesquared(subtarget.origin, self.origin);
        if (dist2 < level.lockoncloserange * level.lockoncloserange) {
            radius *= level.lockoncloseradiusscaler;
        }
    }
    return radius;
}

// Namespace heatseekingmissile/heatseekingmissile
// Params 3, eflags: 0x1 linked
// Checksum 0xcb9d792b, Offset: 0x1d60
// Size: 0xf0
function calclockonlossradius(target, *subtarget, weapon) {
    radius = self getlockonlossradius();
    if (isdefined(weapon) && isdefined(weapon.lockonscreenradius) && weapon.lockonscreenradius > radius) {
        radius = weapon.lockonscreenradius;
    }
    if (isdefined(level.lockoncloserange) && isdefined(level.lockoncloseradiusscaler)) {
        dist2 = distancesquared(subtarget.origin, self.origin);
        if (dist2 < level.lockoncloserange * level.lockoncloserange) {
            radius *= level.lockoncloseradiusscaler;
        }
    }
    return radius;
}

// Namespace heatseekingmissile/heatseekingmissile
// Params 3, eflags: 0x1 linked
// Checksum 0x44740a04, Offset: 0x1e58
// Size: 0x62
function ratiodistancefromscreencenter(target, subtarget, weapon) {
    radius = calclockonradius(target, subtarget, weapon);
    return target_scaleminmaxradius(target, self, 65, 0, radius, subtarget);
}

// Namespace heatseekingmissile/heatseekingmissile
// Params 3, eflags: 0x1 linked
// Checksum 0xde0790ee, Offset: 0x1ec8
// Size: 0x62
function insidestingerreticledetect(target, subtarget, weapon) {
    radius = calclockonradius(target, subtarget, weapon);
    return target_isincircle(target, self, 65, radius, 0, subtarget);
}

// Namespace heatseekingmissile/heatseekingmissile
// Params 3, eflags: 0x0
// Checksum 0x49e21675, Offset: 0x1f38
// Size: 0x62
function insidestingerreticlenolock(target, subtarget, weapon) {
    radius = calclockonradius(target, subtarget, weapon);
    return target_isincircle(target, self, 65, radius, 0, subtarget);
}

// Namespace heatseekingmissile/heatseekingmissile
// Params 3, eflags: 0x1 linked
// Checksum 0xbca38dde, Offset: 0x1fa8
// Size: 0x62
function insidestingerreticlelocked(target, subtarget, weapon) {
    radius = calclockonlossradius(target, subtarget, weapon);
    return target_isincircle(target, self, 65, radius, 0, subtarget);
}

// Namespace heatseekingmissile/heatseekingmissile
// Params 3, eflags: 0x1 linked
// Checksum 0x52cf58e2, Offset: 0x2018
// Size: 0x12a
function isstillvalidtarget(ent, weapon, var_7929b469 = 1) {
    if (!isdefined(ent)) {
        return 0;
    }
    if (isentity(ent) && !isalive(ent)) {
        return 0;
    }
    if (isdefined(ent.is_still_valid_target_for_stinger_override)) {
        return self [[ ent.is_still_valid_target_for_stinger_override ]](ent, weapon);
    }
    if (isdefined(self.is_still_valid_target_for_stinger_override)) {
        return self [[ self.is_still_valid_target_for_stinger_override ]](ent, weapon);
    }
    if (!target_istarget(ent) && !(isdefined(ent.allowcontinuedlockonafterinvis) && ent.allowcontinuedlockonafterinvis)) {
        return 0;
    }
    if (var_7929b469 && !function_1b76fb42(ent, weapon)) {
        return 0;
    }
    return 1;
}

// Namespace heatseekingmissile/heatseekingmissile
// Params 2, eflags: 0x1 linked
// Checksum 0x84d5c65c, Offset: 0x2150
// Size: 0x98
function function_1b76fb42(ent, weapon) {
    var_91c7ae51 = distance2dsquared(self.origin, ent.origin);
    if (weapon.lockonminrange > 0) {
        if (var_91c7ae51 < weapon.lockonminrange * weapon.lockonminrange) {
            return false;
        }
    }
    if (weapon.lockonmaxrange > 0) {
        if (var_91c7ae51 > weapon.lockonmaxrange * weapon.lockonmaxrange) {
            return false;
        }
    }
    return true;
}

// Namespace heatseekingmissile/heatseekingmissile
// Params 0, eflags: 0x1 linked
// Checksum 0xc37b659e, Offset: 0x21f0
// Size: 0x24
function playerstingerads() {
    return self playerads() == 1;
}

// Namespace heatseekingmissile/heatseekingmissile
// Params 2, eflags: 0x1 linked
// Checksum 0x7c6e7e60, Offset: 0x2220
// Size: 0xac
function looplocalseeksound(alias, interval) {
    self endon(#"stop_lockon_sound", #"disconnect", #"death", #"enter_vehicle", #"exit_vehicle");
    for (;;) {
        self playsoundforlocalplayer(alias);
        self playrumbleonentity("stinger_lock_rumble");
        wait interval / 2;
    }
}

// Namespace heatseekingmissile/heatseekingmissile
// Params 1, eflags: 0x1 linked
// Checksum 0xa6e0c67d, Offset: 0x22d8
// Size: 0x7c
function playsoundforlocalplayer(alias) {
    if (self isinvehicle()) {
        sound_target = self getvehicleoccupied();
        if (isdefined(sound_target)) {
            sound_target playsoundtoplayer(alias, self);
        }
        return;
    }
    self playlocalsound(alias);
}

// Namespace heatseekingmissile/heatseekingmissile
// Params 2, eflags: 0x1 linked
// Checksum 0x194e3fd0, Offset: 0x2360
// Size: 0x172
function looplocallocksound(alias, interval) {
    self endon(#"stop_locked_sound", #"disconnect", #"death", #"enter_vehicle", #"exit_vehicle");
    if (isdefined(self.stingerlocksound)) {
        return;
    }
    self.stingerlocksound = 1;
    for (;;) {
        self playsoundforlocalplayer(alias);
        self playrumbleonentity("stinger_lock_rumble");
        wait interval / 6;
        self playsoundforlocalplayer(alias);
        self playrumbleonentity("stinger_lock_rumble");
        wait interval / 6;
        self playsoundforlocalplayer(alias);
        self playrumbleonentity("stinger_lock_rumble");
        wait interval / 6;
        self stoprumble("stinger_lock_rumble");
    }
    self.stingerlocksound = undefined;
}

// Namespace heatseekingmissile/heatseekingmissile
// Params 3, eflags: 0x1 linked
// Checksum 0x30e80be8, Offset: 0x24e0
// Size: 0x176
function locksighttest(target, subtarget, var_27cdcb1 = 0) {
    camerapos = self getplayercamerapos();
    if (!isdefined(target)) {
        return false;
    }
    if (is_true(target.var_e8ec304d)) {
        return false;
    }
    targetorigin = target_getorigin(target, subtarget);
    if (bullettracepassed(camerapos, targetorigin, 0, target, target.parent, var_27cdcb1)) {
        return true;
    }
    front = target getpointinbounds(1, 0, 0);
    if (bullettracepassed(camerapos, front, 0, target, target.parent, var_27cdcb1)) {
        return true;
    }
    back = target getpointinbounds(-1, 0, 0);
    if (bullettracepassed(camerapos, back, 0, target, target.parent, var_27cdcb1)) {
        return true;
    }
    return false;
}

// Namespace heatseekingmissile/heatseekingmissile
// Params 1, eflags: 0x1 linked
// Checksum 0x5dd4ee2e, Offset: 0x2660
// Size: 0xbc
function softsighttest(var_27cdcb1 = 0) {
    lost_sight_limit = 500;
    if (self locksighttest(self.stingertarget, self.stingersubtarget, var_27cdcb1)) {
        self.stingerlostsightlinetime = 0;
        return true;
    }
    if (self.stingerlostsightlinetime == 0) {
        self.stingerlostsightlinetime = gettime();
    }
    timepassed = gettime() - self.stingerlostsightlinetime;
    if (timepassed >= lost_sight_limit) {
        self clearirtarget();
        return false;
    }
    return true;
}

// Namespace heatseekingmissile/heatseekingmissile
// Params 1, eflags: 0x1 linked
// Checksum 0xbfb85fb9, Offset: 0x2728
// Size: 0x42
function initlockfield(target) {
    if (isdefined(target.locking_on)) {
        return;
    }
    target.locking_on = 0;
    target.locked_on = 0;
    target.locking_on_hacking = 0;
}

// Namespace heatseekingmissile/heatseekingmissile
// Params 2, eflags: 0x1 linked
// Checksum 0x7d8ebecf, Offset: 0x2778
// Size: 0x1a6
function lockingon(target, lock) {
    assert(isdefined(target.locking_on));
    clientnum = self getentitynumber();
    if (lock) {
        if ((target.locking_on & 1 << clientnum) == 0) {
            target notify(#"locking on");
            target.locking_on |= 1 << clientnum;
            self thread watchclearlockingon(target, clientnum);
            if (!isdefined(target.team) || !isdefined(target.killstreaktype) && util::function_fbce7263(self.team, target.team) && !is_true(target.var_9ee835dc)) {
                target.var_9ee835dc = 1;
                self battlechatter::playkillstreakthreat(target.killstreaktype);
            }
        }
        return;
    }
    self notify(#"locking_on_cleared");
    target.locking_on &= ~(1 << clientnum);
}

// Namespace heatseekingmissile/heatseekingmissile
// Params 2, eflags: 0x1 linked
// Checksum 0x86304fa7, Offset: 0x2928
// Size: 0x82
function watchclearlockingon(target, clientnum) {
    target endon(#"death");
    self endon(#"locking_on_cleared");
    self waittill(#"death", #"disconnect");
    target.locking_on &= ~(1 << clientnum);
}

// Namespace heatseekingmissile/heatseekingmissile
// Params 2, eflags: 0x1 linked
// Checksum 0x9bc434a1, Offset: 0x29b8
// Size: 0xfe
function lockedon(target, lock) {
    assert(isdefined(target.locked_on));
    clientnum = self getentitynumber();
    if (lock) {
        if ((target.locked_on & 1 << clientnum) == 0) {
            target.locked_on |= 1 << clientnum;
            self notify(#"lock_on_acquired");
            self thread watchclearlockedon(target, clientnum);
        }
        return;
    }
    self notify(#"locked_on_cleared");
    target.locked_on &= ~(1 << clientnum);
}

// Namespace heatseekingmissile/heatseekingmissile
// Params 2, eflags: 0x0
// Checksum 0x88879f43, Offset: 0x2ac0
// Size: 0xe6
function targetinghacking(target, lock) {
    assert(isdefined(target.locking_on_hacking));
    clientnum = self getentitynumber();
    if (lock) {
        target notify(#"locking on hacking");
        target.locking_on_hacking |= 1 << clientnum;
        self thread watchclearhacking(target, clientnum);
        return;
    }
    self notify(#"locking_on_hacking_cleared");
    target.locking_on_hacking &= ~(1 << clientnum);
}

// Namespace heatseekingmissile/heatseekingmissile
// Params 2, eflags: 0x1 linked
// Checksum 0x82dc0513, Offset: 0x2bb0
// Size: 0x82
function watchclearhacking(target, clientnum) {
    target endon(#"death");
    self endon(#"locking_on_hacking_cleared");
    self waittill(#"death", #"disconnect");
    target.locking_on_hacking &= ~(1 << clientnum);
}

// Namespace heatseekingmissile/heatseekingmissile
// Params 2, eflags: 0x1 linked
// Checksum 0x6f8e0b14, Offset: 0x2c40
// Size: 0x594
function setfriendlyflags(weapon, target) {
    if (!self isinvehicle()) {
        self setfriendlyhacking(weapon, target);
        self setfriendlytargetting(weapon, target);
        self setfriendlytargetlocked(weapon, target);
        if (isdefined(level.killstreakmaxhealthfunction)) {
            if (isdefined(target.usevtoltime) && isdefined(level.vtol)) {
                killstreakendtime = level.vtol.killstreakendtime;
                if (isdefined(killstreakendtime)) {
                    self settargetedentityendtime(weapon, int(killstreakendtime));
                }
            } else if (isdefined(target.killstreakendtime)) {
                self settargetedentityendtime(weapon, int(target.killstreakendtime));
            } else if (isdefined(target.parentstruct) && isdefined(target.parentstruct.killstreakendtime)) {
                self settargetedentityendtime(weapon, int(target.parentstruct.killstreakendtime));
            } else {
                self settargetedentityendtime(weapon, 0);
            }
            self settargetedmissilesremaining(weapon, 0);
            killstreaktype = target.killstreaktype;
            if (!isdefined(target.killstreaktype) && isdefined(target.parentstruct) && isdefined(target.parentstruct.killstreaktype)) {
                killstreaktype = target.parentstruct.killstreaktype;
            } else if (isdefined(target.usevtoltime) && isdefined(level.vtol.killstreaktype)) {
                killstreaktype = level.vtol.killstreaktype;
            }
            if (isdefined(killstreaktype)) {
                if (isdefined(target.forceonemissile)) {
                    self settargetedmissilesremaining(weapon, 1);
                } else if (isdefined(target.usevtoltime) && isdefined(level.vtol) && isdefined(level.vtol.totalrockethits) && isdefined(level.vtol.missiletodestroy)) {
                    self settargetedmissilesremaining(weapon, level.vtol.missiletodestroy - level.vtol.totalrockethits);
                } else {
                    maxhealth = [[ level.killstreakmaxhealthfunction ]](killstreaktype);
                    damagetaken = target.damagetaken;
                    if (!isdefined(damagetaken) && isdefined(target.parentstruct)) {
                        damagetaken = target.parentstruct.damagetaken;
                    }
                    if (isdefined(target.missiletrackdamage)) {
                        damagetaken = target.missiletrackdamage;
                    }
                    if (isdefined(damagetaken) && isdefined(maxhealth)) {
                        bundle = killstreaks::get_script_bundle(killstreaktype);
                        rocketstokill = bundle.ksrocketstokill;
                        if (level.competitivesettingsenabled && isdefined(bundle.var_b744074b) && bundle.var_b744074b != 0) {
                            rocketstokill = bundle.var_b744074b;
                        }
                        damageperrocket = maxhealth / rocketstokill + 1;
                        remaininghealth = maxhealth - damagetaken;
                        if (remaininghealth > 0) {
                            missilesremaining = int(ceil(remaininghealth / damageperrocket));
                            if (isdefined(target.numflares) && target.numflares > 0) {
                                missilesremaining += target.numflares;
                            }
                            if (isdefined(target.flak_drone)) {
                                missilesremaining += 1;
                            }
                            self settargetedmissilesremaining(weapon, int(min(missilesremaining, 7)));
                        }
                    }
                }
            }
            return;
        }
        if (isdefined(level.callback_set_missiles_remaining)) {
            self settargetedmissilesremaining(weapon, [[ level.callback_set_missiles_remaining ]](weapon, target));
        }
    }
}

// Namespace heatseekingmissile/heatseekingmissile
// Params 2, eflags: 0x1 linked
// Checksum 0xc06c49dd, Offset: 0x31e0
// Size: 0xcc
function setfriendlyhacking(weapon, target) {
    if (level.teambased) {
        friendlyhackingmask = target.locking_on_hacking;
        if (isdefined(friendlyhackingmask) && self hasweapon(weapon)) {
            friendlyhacking = 0;
            clientnum = self getentitynumber();
            friendlyhackingmask &= ~(1 << clientnum);
            if (friendlyhackingmask != 0) {
                friendlyhacking = 1;
            }
            self setweaponfriendlyhacking(weapon, friendlyhacking);
        }
    }
}

// Namespace heatseekingmissile/heatseekingmissile
// Params 2, eflags: 0x1 linked
// Checksum 0x7dd1c361, Offset: 0x32b8
// Size: 0xcc
function setfriendlytargetting(weapon, target) {
    if (level.teambased) {
        friendlytargetingmask = target.locking_on;
        if (isdefined(friendlytargetingmask) && self hasweapon(weapon)) {
            friendlytargeting = 0;
            clientnum = self getentitynumber();
            friendlytargetingmask &= ~(1 << clientnum);
            if (friendlytargetingmask != 0) {
                friendlytargeting = 1;
            }
            self setweaponfriendlytargeting(weapon, friendlytargeting);
        }
    }
}

// Namespace heatseekingmissile/heatseekingmissile
// Params 2, eflags: 0x1 linked
// Checksum 0xd6a80648, Offset: 0x3390
// Size: 0xe4
function setfriendlytargetlocked(weapon, target) {
    if (level.teambased) {
        friendlytargetlocked = 0;
        friendlylockingonmask = target.locked_on;
        if (isdefined(friendlylockingonmask)) {
            friendlytargetlocked = 0;
            clientnum = self getentitynumber();
            friendlylockingonmask &= ~(1 << clientnum);
            if (friendlylockingonmask != 0) {
                friendlytargetlocked = 1;
            }
        }
        if (friendlytargetlocked == 0) {
            friendlytargetlocked = target missiletarget_isotherplayermissileincoming(self);
        }
        self setweaponfriendlytargetlocked(weapon, friendlytargetlocked);
    }
}

// Namespace heatseekingmissile/heatseekingmissile
// Params 2, eflags: 0x1 linked
// Checksum 0x24f682b4, Offset: 0x3480
// Size: 0x72
function watchclearlockedon(target, clientnum) {
    self endon(#"locked_on_cleared");
    self waittill(#"death", #"disconnect");
    if (isdefined(target)) {
        target.locked_on &= ~(1 << clientnum);
    }
}

// Namespace heatseekingmissile/heatseekingmissile
// Params 3, eflags: 0x0
// Checksum 0x522ada81, Offset: 0x3500
// Size: 0x250
function missiletarget_lockonmonitor(*player, endon1, endon2) {
    self endon(#"death");
    if (isdefined(endon1)) {
        self endon(endon1);
    }
    if (isdefined(endon2)) {
        self endon(endon2);
    }
    for (;;) {
        if (target_istarget(self)) {
            if (self missiletarget_ismissileincoming()) {
                self clientfield::set("heli_warn_fired", 1);
                self clientfield::set("heli_warn_locked", 0);
                self clientfield::set("heli_warn_targeted", 0);
            } else if (isdefined(self.locked_on) && self.locked_on) {
                self clientfield::set("heli_warn_locked", 1);
                self clientfield::set("heli_warn_fired", 0);
                self clientfield::set("heli_warn_targeted", 0);
            } else if (isdefined(self.locking_on) && self.locking_on) {
                self clientfield::set("heli_warn_targeted", 1);
                self clientfield::set("heli_warn_fired", 0);
                self clientfield::set("heli_warn_locked", 0);
            } else {
                self clientfield::set("heli_warn_fired", 0);
                self clientfield::set("heli_warn_targeted", 0);
                self clientfield::set("heli_warn_locked", 0);
            }
        }
        wait 0.1;
    }
}

// Namespace heatseekingmissile/heatseekingmissile
// Params 2, eflags: 0x1 linked
// Checksum 0xe7c8c426, Offset: 0x3758
// Size: 0x104
function _incomingmissile(missile, attacker) {
    if (!isdefined(self.incoming_missile)) {
        self.incoming_missile = 0;
    }
    if (!isdefined(self.incoming_missile_owner)) {
        self.incoming_missile_owner = [];
    }
    attacker_entnum = attacker getentitynumber();
    if (!isdefined(self.incoming_missile_owner[attacker_entnum])) {
        self.incoming_missile_owner[attacker_entnum] = 0;
    }
    self.incoming_missile++;
    self.incoming_missile_owner[attacker_entnum]++;
    if (isplayer(attacker)) {
        attacker lockedon(self, 1);
    }
    self thread _incomingmissiletracker(missile, attacker);
    self thread _targetmissiletracker(missile, attacker);
}

// Namespace heatseekingmissile/heatseekingmissile
// Params 2, eflags: 0x1 linked
// Checksum 0xcc9d2c6d, Offset: 0x3868
// Size: 0x84
function _targetmissiletracker(missile, attacker) {
    missile endon(#"death");
    self waittill(#"death");
    if (isdefined(attacker) && isplayer(attacker) && isdefined(self)) {
        attacker lockedon(self, 0);
    }
}

// Namespace heatseekingmissile/heatseekingmissile
// Params 2, eflags: 0x1 linked
// Checksum 0x24a06d07, Offset: 0x38f8
// Size: 0xfc
function _incomingmissiletracker(missile, attacker) {
    self endon(#"death");
    attacker_entnum = attacker getentitynumber();
    missile waittill(#"death");
    self.incoming_missile--;
    self.incoming_missile_owner[attacker_entnum]--;
    if (self.incoming_missile_owner[attacker_entnum] == 0) {
        self.incoming_missile_owner[attacker_entnum] = undefined;
    }
    if (isdefined(attacker) && isplayer(attacker)) {
        attacker lockedon(self, 0);
    }
    assert(self.incoming_missile >= 0);
}

// Namespace heatseekingmissile/heatseekingmissile
// Params 0, eflags: 0x1 linked
// Checksum 0x82124518, Offset: 0x3a00
// Size: 0x26
function missiletarget_ismissileincoming() {
    if (!isdefined(self.incoming_missile)) {
        return false;
    }
    if (self.incoming_missile) {
        return true;
    }
    return false;
}

// Namespace heatseekingmissile/heatseekingmissile
// Params 1, eflags: 0x1 linked
// Checksum 0x4ebc4e05, Offset: 0x3a30
// Size: 0x80
function missiletarget_isotherplayermissileincoming(attacker) {
    if (!isdefined(self.incoming_missile_owner)) {
        return false;
    }
    if (self.incoming_missile_owner.size == 0) {
        return false;
    }
    attacker_entnum = attacker getentitynumber();
    if (self.incoming_missile_owner.size == 1 && isdefined(self.incoming_missile_owner[attacker_entnum])) {
        return false;
    }
    return true;
}

// Namespace heatseekingmissile/heatseekingmissile
// Params 4, eflags: 0x1 linked
// Checksum 0x50906c63, Offset: 0x3ab8
// Size: 0xf6
function missiletarget_handleincomingmissile(responsefunc, endon1, endon2, allowdirectdamage) {
    level endon(#"game_ended");
    self endon(#"death");
    if (isdefined(endon1)) {
        self endon(endon1);
    }
    if (isdefined(endon2)) {
        self endon(endon2);
    }
    for (;;) {
        waitresult = self waittill(#"stinger_fired_at_me");
        _incomingmissile(waitresult.projectile, waitresult.attacker);
        if (isdefined(responsefunc)) {
            self thread [[ responsefunc ]](waitresult.projectile, waitresult.attacker, waitresult.weapon, endon1, endon2, allowdirectdamage);
        }
    }
}

// Namespace heatseekingmissile/heatseekingmissile
// Params 4, eflags: 0x1 linked
// Checksum 0x7e11b9f4, Offset: 0x3bb8
// Size: 0xe4
function missiletarget_proximitydetonateincomingmissile(killstreakbundle, endon1, endon2, allowdirectdamage) {
    if (isarray(level.var_2d90c17e)) {
        foreach (func in level.var_2d90c17e) {
            self [[ func ]](killstreakbundle);
        }
    }
    missiletarget_handleincomingmissile(&missiletarget_proximitydetonate, endon1, endon2, allowdirectdamage);
}

// Namespace heatseekingmissile/heatseekingmissile
// Params 6, eflags: 0x1 linked
// Checksum 0x17fd3415, Offset: 0x3ca8
// Size: 0x21c
function _missiledetonate(attacker, weapon, range, mindamage, maxdamage, allowdirectdamage) {
    origin = self.origin;
    target = self missile_gettarget();
    self detonate();
    if (isdefined(target.origin)) {
        var_5289435c = 0;
        if (is_true(self.var_30dc969d)) {
            var_5289435c = 1;
        } else if (allowdirectdamage === 1) {
            mindistsq = isdefined(target.locked_missile_min_distsq) ? target.locked_missile_min_distsq : function_a3f6cdac(range);
            distsq = distancesquared(self.origin, target.origin);
            if (distsq < mindistsq) {
                var_5289435c = 1;
            }
        }
        if (var_5289435c) {
            target dodamage(maxdamage, origin, attacker, self, "none", "MOD_PROJECTILE", 0, weapon);
        }
    }
    attackerentity = attacker;
    if (function_3132f113(attacker) || isdefined(attacker) && !isplayer(attacker) && !isalive(attacker)) {
        attackerentity = undefined;
    }
    radiusdamage(origin, range, maxdamage, mindamage, attackerentity, "MOD_PROJECTILE_SPLASH", weapon);
}

// Namespace heatseekingmissile/heatseekingmissile
// Params 6, eflags: 0x1 linked
// Checksum 0xf4b0cc42, Offset: 0x3ed0
// Size: 0x3a8
function missiletarget_proximitydetonate(missile, attacker, weapon, endon1, endon2, allowdirectdamage) {
    self endon(#"death");
    level endon(#"game_ended");
    missile endon(#"death");
    if (isdefined(endon1)) {
        self endon(endon1);
    }
    if (isdefined(endon2)) {
        self endon(endon2);
    }
    mindist = distancesquared(missile.origin, self.origin);
    lastcenter = self.origin;
    var_77fe49d5 = 0;
    missile missile_settarget(self, isdefined(target_getoffset(self)) ? target_getoffset(self) : (0, 0, 0));
    if (isdefined(self.missiletargetmissdistance)) {
        misseddistancesq = self.missiletargetmissdistance * self.missiletargetmissdistance;
    } else {
        misseddistancesq = 250000;
    }
    flaredistancesq = 12250000;
    for (;;) {
        if (!isdefined(self)) {
            center = lastcenter;
        } else {
            center = self.origin;
        }
        lastcenter = center;
        curdist = distancesquared(missile.origin, center);
        if (!is_true(missile.var_b324d423) && curdist < flaredistancesq && isdefined(self.numflares) && self.numflares > 0) {
            self.numflares--;
            self thread missiletarget_playflarefx();
            self challenges::trackassists(attacker, 0, 1);
            newtarget = self missiletarget_deployflares(missile.origin, missile.angles);
            missile missile_settarget(newtarget, isdefined(target_getoffset(newtarget)) ? target_getoffset(newtarget) : (0, 0, 0));
            missiletarget = newtarget;
            scoreevents::processscoreevent(#"flare_assist", attacker, undefined, weapon);
            self notify(#"flare_deployed");
            return;
        }
        if (curdist < mindist) {
            var_77fe49d5 = 1;
            mindist = curdist;
        }
        if (var_77fe49d5 && curdist > mindist) {
            if (!is_true(missile.var_30dc969d) && curdist > misseddistancesq) {
                return;
            }
            missile thread _missiledetonate(attacker, weapon, 500, 600, 600, allowdirectdamage);
            return;
        }
        waitframe(1);
    }
}

// Namespace heatseekingmissile/heatseekingmissile
// Params 2, eflags: 0x1 linked
// Checksum 0xf4864e8f, Offset: 0x4280
// Size: 0x104
function missiletarget_playflarefx(flare_fx, tag_origin) {
    if (!isdefined(self)) {
        return;
    }
    if (!isdefined(flare_fx)) {
        if (isdefined(self.fx_flare)) {
            flare_fx = self.fx_flare;
        } else {
            flare_fx = level.fx_flare;
        }
    }
    if (!isdefined(tag_origin)) {
        tag_origin = "tag_origin";
    }
    if (isdefined(self.flare_ent)) {
        playfxontag(flare_fx, self.flare_ent, tag_origin);
    } else {
        playfxontag(flare_fx, self, tag_origin);
    }
    if (isdefined(self.owner)) {
        self playsoundtoplayer(#"hash_470978b5aa6302ba", self.owner);
    }
    self playsound(#"hash_470978b5aa6302ba");
}

// Namespace heatseekingmissile/heatseekingmissile
// Params 2, eflags: 0x1 linked
// Checksum 0xafa403cd, Offset: 0x4390
// Size: 0x290
function missiletarget_deployflares(origin, angles) {
    vec_toforward = anglestoforward(self.angles);
    vec_toright = anglestoright(self.angles);
    vec_tomissileforward = anglestoforward(angles);
    delta = self.origin - origin;
    dot = vectordot(vec_tomissileforward, vec_toright);
    sign = 1;
    if (dot > 0) {
        sign = -1;
    }
    flare_dir = vectornormalize(vectorscale(vec_toforward, -0.5) + vectorscale(vec_toright, sign));
    velocity = vectorscale(flare_dir, randomintrange(200, 400));
    velocity = (velocity[0], velocity[1], velocity[2] - randomintrange(10, 100));
    flareorigin = self.origin;
    flareorigin += vectorscale(flare_dir, randomintrange(600, 800));
    flareorigin += (0, 0, 500);
    if (isdefined(self.flareoffset)) {
        flareorigin += self.flareoffset;
    }
    flareobject = spawn("script_origin", flareorigin);
    flareobject.angles = self.angles;
    flareobject setmodel(#"tag_origin");
    flareobject movegravity(velocity, 5);
    flareobject thread util::deleteaftertime(5);
    /#
        self thread debug_tracker(flareobject);
    #/
    return flareobject;
}

/#

    // Namespace heatseekingmissile/heatseekingmissile
    // Params 1, eflags: 0x0
    // Checksum 0xb6f67eb4, Offset: 0x4628
    // Size: 0x5e
    function debug_tracker(target) {
        target endon(#"death");
        while (true) {
            dev::debug_sphere(target.origin, 10, (1, 0, 0), 1, 1);
            waitframe(1);
        }
    }

#/