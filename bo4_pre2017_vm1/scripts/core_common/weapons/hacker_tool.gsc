#using scripts/core_common/callbacks_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/killstreaks_shared;
#using scripts/core_common/scoreevents_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;
#using scripts/core_common/weapons/heatseekingmissile;
#using scripts/core_common/weapons/weaponobjects;

#namespace hacker_tool;

// Namespace hacker_tool/hacker_tool
// Params 0, eflags: 0x0
// Checksum 0x862d9424, Offset: 0x3d8
// Size: 0x16c
function init_shared() {
    level.weaponhackertool = getweapon("pda_hack");
    level.hackertoollostsightlimitms = 1000;
    level.hackertoollockonradius = 25;
    level.hackertoollockonfov = 65;
    level.hackertoolhacktimems = 0.4;
    level.equipmenthackertoolradius = 20;
    level.equipmenthackertooltimems = 100;
    level.carepackagehackertoolradius = 60;
    level.carepackagehackertooltimems = getgametypesetting("crateCaptureTime") * 500;
    level.carepackagefriendlyhackertooltimems = getgametypesetting("crateCaptureTime") * 2000;
    level.carepackageownerhackertooltimems = 250;
    level.vehiclehackertoolradius = 80;
    level.vehiclehackertooltimems = 5000;
    clientfield::register("toplayer", "hacker_tool", 1, 2, "int");
    callback::on_spawned(&on_player_spawned);
}

// Namespace hacker_tool/hacker_tool
// Params 0, eflags: 0x0
// Checksum 0xada7da03, Offset: 0x550
// Size: 0x5c
function on_player_spawned() {
    self endon(#"disconnect");
    self clearhackertarget(undefined, 0, 1);
    self thread function_256a0863();
    self thread watchhackertoolfired();
}

// Namespace hacker_tool/hacker_tool
// Params 3, eflags: 0x0
// Checksum 0xff127e44, Offset: 0x5b8
// Size: 0x24c
function clearhackertarget(weapon, successfulhack, spawned) {
    self notify(#"stop_lockon_sound");
    self notify(#"stop_locked_sound");
    self notify(#"clearhackertarget");
    self.stingerlocksound = undefined;
    self stoprumble("stinger_lock_rumble");
    self.hackertoollockstarttime = 0;
    self.hackertoollockstarted = 0;
    self.hackertoollockfinalized = 0;
    self.hackertoollocktimeelapsed = 0;
    if (isdefined(weapon)) {
        self setweaponhackpercent(weapon, 0);
        if (isdefined(self.hackertooltarget)) {
            heatseekingmissile::setfriendlyflags(weapon, self.hackertooltarget);
        }
    }
    if (successfulhack == 0) {
        if (spawned == 0) {
            if (isdefined(self.hackertooltarget)) {
                self playsoundtoplayer("evt_hacker_hack_lost", self);
            }
        }
        self clientfield::set_to_player("hacker_tool", 0);
        self stophackertoolsoundloop();
    }
    if (isdefined(self.hackertooltarget)) {
        heatseekingmissile::targetinghacking(self.hackertooltarget, 0);
    }
    self.hackertooltarget = undefined;
    self weaponlockfree();
    self weaponlocktargettooclose(0);
    self weaponlocknoclearance(0);
    self stoplocalsound(game.locking_on_sound);
    self stoplocalsound(game.locked_on_sound);
    self heatseekingmissile::destroylockoncanceledmessage();
}

// Namespace hacker_tool/hacker_tool
// Params 0, eflags: 0x0
// Checksum 0xfd6ffdb2, Offset: 0x810
// Size: 0x708
function watchhackertoolfired() {
    self endon(#"disconnect");
    self endon(#"death");
    self endon(#"killhackermonitor");
    while (true) {
        waitresult = self waittill("hacker_tool_fired");
        hackertooltarget = waitresult.target;
        weapon = waitresult.weapon;
        if (isdefined(hackertooltarget)) {
            if (isentityhackablecarepackage(hackertooltarget)) {
                scoreevents::givecratecapturemedal(hackertooltarget, self);
                hackertooltarget notify(#"captured", {#player:self, #is_remote_hack:1});
                if (isdefined(hackertooltarget.owner) && isplayer(hackertooltarget.owner) && hackertooltarget.owner.team != self.team && isdefined(level.play_killstreak_hacked_dialog)) {
                    hackertooltarget.owner [[ level.play_killstreak_hacked_dialog ]](hackertooltarget.killstreaktype, hackertooltarget.killstreakid, self);
                }
            } else if (isentityhackableweaponobject(hackertooltarget) && isdefined(hackertooltarget.hackertrigger)) {
                hackertooltarget.hackertrigger notify(#"trigger", {#activator:self, #dropped_item:1});
                hackertooltarget.previouslyhacked = 1;
                self.throwinggrenade = 0;
            } else if (!isdefined(hackertooltarget.killstreaktimedout) || isdefined(hackertooltarget.killstreak_hackedcallback) && hackertooltarget.killstreaktimedout == 0) {
                if (hackertooltarget.killstreak_hackedprotection == 0) {
                    if (isdefined(hackertooltarget.owner) && isplayer(hackertooltarget.owner)) {
                        if (isdefined(level.play_killstreak_hacked_dialog)) {
                            hackertooltarget.owner [[ level.play_killstreak_hacked_dialog ]](hackertooltarget.killstreaktype, hackertooltarget.killstreakid, self);
                        }
                    }
                    self playsoundtoplayer("evt_hacker_fw_success", self);
                    hackertooltarget notify(#"killstreak_hacked", {#hacker:self});
                    hackertooltarget.previouslyhacked = 1;
                    hackertooltarget [[ hackertooltarget.killstreak_hackedcallback ]](self);
                    if (self util::has_blind_eye_perk_purchased_and_equipped() || self util::has_hacker_perk_purchased_and_equipped()) {
                        self addplayerstat("hack_streak_with_blindeye_or_engineer", 1);
                    }
                } else {
                    if (isdefined(hackertooltarget.owner) && isplayer(hackertooltarget.owner)) {
                        if (isdefined(level.play_killstreak_firewall_hacked_dialog)) {
                            self.hackertooltarget.owner [[ level.play_killstreak_firewall_hacked_dialog ]](self.hackertooltarget.killstreaktype, self.hackertooltarget.killstreakid);
                        }
                    }
                    self playsoundtoplayer("evt_hacker_ks_success", self);
                    scoreevents::processscoreevent("hacked_killstreak_protection", self, hackertooltarget, level.weaponhackertool);
                }
                hackertooltarget.killstreak_hackedprotection = 0;
            } else {
                if (isdefined(hackertooltarget.classname) && hackertooltarget.classname == "grenade") {
                    damage = 1;
                } else if (isdefined(hackertooltarget.hackertooldamage)) {
                    damage = hackertooltarget.hackertooldamage;
                } else if (isdefined(hackertooltarget.maxhealth)) {
                    damage = hackertooltarget.maxhealth + 1;
                } else {
                    damage = 999999;
                }
                if (isdefined(hackertooltarget.numflares) && hackertooltarget.numflares > 0) {
                    damage = 1;
                    hackertooltarget.numflares--;
                    hackertooltarget heatseekingmissile::missiletarget_playflarefx();
                }
                hackertooltarget dodamage(damage, self.origin, self, self, 0, "MOD_UNKNOWN", 0, weapon);
            }
            if (self util::is_item_purchased("pda_hack")) {
                self addplayerstat("hack_enemy_target", 1);
            }
            self addweaponstat(weapon, "used", 1);
        }
        clearhackertarget(weapon, 1, 0);
        self forceoffhandend();
        if (getdvarint("player_sustainAmmo") == 0) {
            clip_ammo = self getweaponammoclip(weapon);
            clip_ammo--;
            assert(clip_ammo >= 0);
            self setweaponammoclip(weapon, clip_ammo);
        }
        self killstreaks::switch_to_last_non_killstreak_weapon();
    }
}

// Namespace hacker_tool/hacker_tool
// Params 0, eflags: 0x0
// Checksum 0xf4756a90, Offset: 0xf20
// Size: 0x130
function function_256a0863() {
    self endon(#"disconnect");
    self endon(#"death");
    for (;;) {
        waitresult = self waittill("grenade_pullback");
        weapon = waitresult.weapon;
        if (weapon.rootweapon == level.weaponhackertool) {
            waitframe(1);
            currentoffhand = self getcurrentoffhand();
            if (self isusingoffhand() && currentoffhand.rootweapon == level.weaponhackertool) {
                self thread hackertooltargetloop(weapon);
                self thread watchhackertoolend(weapon);
                self thread watchforgrenadefire(weapon);
                self thread watchhackertoolinterrupt(weapon);
            }
        }
    }
}

// Namespace hacker_tool/hacker_tool
// Params 1, eflags: 0x0
// Checksum 0x53719f85, Offset: 0x1058
// Size: 0x9e
function watchhackertoolinterrupt(weapon) {
    self endon(#"disconnect", #"hacker_tool_fired", #"death", #"weapon_change", #"grenade_fire");
    while (true) {
        waitresult = level waittill("use_interrupt");
        if (self.hackertooltarget == waitresult.target) {
            clearhackertarget(weapon, 0, 0);
        }
        waitframe(1);
    }
}

// Namespace hacker_tool/hacker_tool
// Params 1, eflags: 0x0
// Checksum 0x141fb0f0, Offset: 0x1100
// Size: 0x9c
function watchhackertoolend(weapon) {
    self endon(#"disconnect");
    self endon(#"hacker_tool_fired");
    self waittill("weapon_change", "death", "hacker_tool_fired", "disconnect");
    clearhackertarget(weapon, 0, 0);
    self clientfield::set_to_player("hacker_tool", 0);
    self stophackertoolsoundloop();
}

// Namespace hacker_tool/hacker_tool
// Params 1, eflags: 0x0
// Checksum 0x7574c714, Offset: 0x11a8
// Size: 0x14c
function watchforgrenadefire(weapon) {
    self endon(#"disconnect", #"hacker_tool_fired", #"weapon_change", #"death");
    while (true) {
        waitresult = self waittill("grenade_fire");
        grenade_instance = waitresult.projectile;
        grenade_weapon = waitresult.weapon;
        respawnfromhack = waitresult.respawn_from_hack;
        if (isdefined(respawnfromhack) && respawnfromhack) {
            continue;
        }
        clearhackertarget(grenade_weapon, 0, 0);
        clip_ammo = self getweaponammoclip(grenade_weapon);
        clip_max_ammo = grenade_weapon.clipsize;
        if (clip_ammo < clip_max_ammo) {
            clip_ammo++;
        }
        self setweaponammoclip(grenade_weapon, clip_ammo);
        break;
    }
}

// Namespace hacker_tool/hacker_tool
// Params 0, eflags: 0x0
// Checksum 0xf117ac75, Offset: 0x1300
// Size: 0x70
function playhackertoolsoundloop() {
    if (isdefined(self.hacker_alreadyhacked) && (!isdefined(self.hacker_sound_ent) || self.hacker_alreadyhacked == 1)) {
        self playloopsound("evt_hacker_device_loop");
        self.hacker_sound_ent = 1;
        self.hacker_alreadyhacked = 0;
    }
}

// Namespace hacker_tool/hacker_tool
// Params 0, eflags: 0x0
// Checksum 0x10c1bd7d, Offset: 0x1378
// Size: 0x36
function stophackertoolsoundloop() {
    self stoploopsound(0.5);
    self.hacker_sound_ent = undefined;
    self.hacker_alreadyhacked = undefined;
}

// Namespace hacker_tool/hacker_tool
// Params 1, eflags: 0x0
// Checksum 0x76d29f71, Offset: 0x13b8
// Size: 0xa00
function hackertooltargetloop(weapon) {
    self endon(#"disconnect", #"death", #"weapon_change", #"grenade_fire");
    self clientfield::set_to_player("hacker_tool", 1);
    self playhackertoolsoundloop();
    while (true) {
        waitframe(1);
        waitframe(1);
        if (self.hackertoollockfinalized) {
            if (!self isvalidhackertooltarget(self.hackertooltarget, weapon, 0)) {
                self clearhackertarget(weapon, 0, 0);
                continue;
            }
            passed = self hackersoftsighttest(weapon);
            if (!passed) {
                continue;
            }
            self clientfield::set_to_player("hacker_tool", 0);
            self stophackertoolsoundloop();
            heatseekingmissile::targetinghacking(self.hackertooltarget, 0);
            heatseekingmissile::setfriendlyflags(weapon, self.hackertooltarget);
            thread heatseekingmissile::looplocallocksound(game.locked_on_sound, 0.75);
            self notify(#"hacker_tool_fired", {#target:self.hackertooltarget, #weapon:weapon});
            return;
        }
        if (self.hackertoollockstarted) {
            if (!self isvalidhackertooltarget(self.hackertooltarget, weapon, 0)) {
                self clearhackertarget(weapon, 0, 0);
                continue;
            }
            lockontime = self getlockontime(self.hackertooltarget, weapon);
            if (lockontime == 0) {
                self clearhackertarget(weapon, 0, 0);
                continue;
            }
            if (self.hackertoollocktimeelapsed == 0) {
                self playlocalsound("evt_hacker_hacking");
                if (isdefined(self.hackertooltarget.owner) && isplayer(self.hackertooltarget.owner)) {
                    if (!isdefined(self.hackertooltarget.killstreaktimedout) || isdefined(self.hackertooltarget.killstreak_hackedcallback) && self.hackertooltarget.killstreaktimedout == 0) {
                        if (self.hackertooltarget.killstreak_hackedprotection == 0) {
                            if (isdefined(level.play_killstreak_being_hacked_dialog)) {
                                self.hackertooltarget.owner [[ level.play_killstreak_being_hacked_dialog ]](self.hackertooltarget.killstreaktype, self.hackertooltarget.killstreakid);
                            }
                        } else if (isdefined(level.play_killstreak_firewall_being_hacked_dialog)) {
                            self.hackertooltarget.owner [[ level.play_killstreak_firewall_being_hacked_dialog ]](self.hackertooltarget.killstreaktype, self.hackertooltarget.killstreakid);
                        }
                    }
                }
            }
            self weaponlockstart(self.hackertooltarget);
            self playhackertoolsoundloop();
            if (isdefined(self.hackertooltarget.killstreak_hackedprotection) && self.hackertooltarget.killstreak_hackedprotection == 1) {
                self clientfield::set_to_player("hacker_tool", 3);
            } else {
                self clientfield::set_to_player("hacker_tool", 2);
            }
            heatseekingmissile::targetinghacking(self.hackertooltarget, 1);
            heatseekingmissile::setfriendlyflags(weapon, self.hackertooltarget);
            passed = self hackersoftsighttest(weapon);
            if (!passed) {
                continue;
            }
            if (self.hackertoollostsightlinetime == 0) {
                self.hackertoollocktimeelapsed += 0.1 * hackingtimescale(self.hackertooltarget);
                hackpercentage = self.hackertoollocktimeelapsed / lockontime * 100;
                self setweaponhackpercent(weapon, hackpercentage);
                heatseekingmissile::setfriendlyflags(weapon, self.hackertooltarget);
            } else {
                self.hackertoollocktimeelapsed -= 0.1 * hackingtimenolineofsightscale(self.hackertooltarget);
                if (self.hackertoollocktimeelapsed < 0) {
                    self.hackertoollocktimeelapsed = 0;
                    self clearhackertarget(weapon, 0, 0);
                    continue;
                }
                hackpercentage = self.hackertoollocktimeelapsed / lockontime * 100;
                self setweaponhackpercent(weapon, hackpercentage);
                heatseekingmissile::setfriendlyflags(weapon, self.hackertooltarget);
            }
            if (self.hackertoollocktimeelapsed < lockontime) {
                continue;
            }
            assert(isdefined(self.hackertooltarget));
            self notify(#"stop_lockon_sound");
            self.hackertoollockfinalized = 1;
            self weaponlockfinalize(self.hackertooltarget);
            continue;
        }
        if (self isempjammed()) {
            self heatseekingmissile::destroylockoncanceledmessage();
            continue;
        }
        besttarget = self getbesthackertooltarget(weapon);
        if (!isdefined(besttarget)) {
            self stophackertoolsoundloop();
            self heatseekingmissile::destroylockoncanceledmessage();
            continue;
        }
        if (!self heatseekingmissile::locksighttest(besttarget)) {
            self stophackertoolsoundloop();
            self heatseekingmissile::destroylockoncanceledmessage();
            continue;
        }
        if (self heatseekingmissile::locksighttest(besttarget) && isdefined(besttarget.lockondelay) && besttarget.lockondelay) {
            self stophackertoolsoundloop();
            self heatseekingmissile::displaylockoncanceledmessage();
            continue;
        }
        self heatseekingmissile::destroylockoncanceledmessage();
        if (isentitypreviouslyhacked(besttarget)) {
            if (isdefined(self.hacker_alreadyhacked) && (!isdefined(self.hacker_sound_ent) || self.hacker_alreadyhacked == 0)) {
                self.hacker_sound_ent = 1;
                self.hacker_alreadyhacked = 1;
                self playloopsound("evt_hacker_unhackable_loop");
            }
            continue;
        } else {
            self stophackertoolsoundloop();
        }
        heatseekingmissile::initlockfield(besttarget);
        self.hackertooltarget = besttarget;
        self thread watchtargetentityupdate(besttarget);
        self.hackertoollockstarttime = gettime();
        self.hackertoollockstarted = 1;
        self.hackertoollostsightlinetime = 0;
        self.hackertoollocktimeelapsed = 0;
        self setweaponhackpercent(weapon, 0);
        if (isdefined(self.hackertooltarget)) {
            heatseekingmissile::setfriendlyflags(weapon, self.hackertooltarget);
        }
    }
}

// Namespace hacker_tool/hacker_tool
// Params 1, eflags: 0x0
// Checksum 0x5cd5362b, Offset: 0x1dc0
// Size: 0xac
function watchtargetentityupdate(besttarget) {
    self endon(#"death");
    self endon(#"disconnect");
    self notify(#"watchtargetentityupdate");
    self endon(#"watchtargetentityupdate");
    self endon(#"clearhackertarget");
    besttarget endon(#"death");
    waitresult = besttarget waittill("hackertool_update_ent");
    heatseekingmissile::initlockfield(waitresult.entity);
    self.hackertooltarget = waitresult.entity;
}

// Namespace hacker_tool/hacker_tool
// Params 1, eflags: 0x0
// Checksum 0x6ee05988, Offset: 0x1e78
// Size: 0x3aa
function getbesthackertooltarget(weapon) {
    targetsvalid = [];
    targetsall = arraycombine(target_getarray(), level.missileentities, 0, 0);
    targetsall = arraycombine(targetsall, level.hackertooltargets, 0, 0);
    for (idx = 0; idx < targetsall.size; idx++) {
        target_ent = targetsall[idx];
        if (!isdefined(target_ent) || !isdefined(target_ent.owner)) {
            continue;
        }
        /#
            if (getdvarstring("<dev string:x28>") == "<dev string:x35>") {
                if (self iswithinhackertoolreticle(targetsall[idx], weapon)) {
                    targetsvalid[targetsvalid.size] = targetsall[idx];
                }
                continue;
            }
        #/
        if (level.teambased || level.use_team_based_logic_for_locking_on === 1) {
            if (isentityhackablecarepackage(target_ent)) {
                if (self cantargetentity(target_ent, weapon)) {
                    targetsvalid[targetsvalid.size] = target_ent;
                }
            } else if (isdefined(target_ent.team)) {
                if (target_ent.team != self.team) {
                    if (self cantargetentity(target_ent, weapon)) {
                        targetsvalid[targetsvalid.size] = target_ent;
                    }
                }
            } else if (isdefined(target_ent.owner.team)) {
                if (target_ent.owner.team != self.team) {
                    if (self cantargetentity(target_ent, weapon)) {
                        targetsvalid[targetsvalid.size] = target_ent;
                    }
                }
            }
            continue;
        }
        if (self iswithinhackertoolreticle(target_ent, weapon)) {
            if (isentityhackablecarepackage(target_ent)) {
                if (self cantargetentity(target_ent, weapon)) {
                    targetsvalid[targetsvalid.size] = target_ent;
                }
                continue;
            }
            if (isdefined(target_ent.owner) && self != target_ent.owner) {
                if (self cantargetentity(target_ent, weapon)) {
                    targetsvalid[targetsvalid.size] = target_ent;
                }
            }
        }
    }
    chosenent = undefined;
    if (targetsvalid.size != 0) {
        chosenent = targetsvalid[0];
    }
    return chosenent;
}

// Namespace hacker_tool/hacker_tool
// Params 2, eflags: 0x0
// Checksum 0xfeb2c408, Offset: 0x2230
// Size: 0x66
function cantargetentity(target, weapon) {
    if (!self iswithinhackertoolreticle(target, weapon)) {
        return false;
    }
    if (!isvalidhackertooltarget(target, weapon, 1)) {
        return false;
    }
    return true;
}

// Namespace hacker_tool/hacker_tool
// Params 2, eflags: 0x0
// Checksum 0xd61d3679, Offset: 0x22a0
// Size: 0xba
function iswithinhackertoolreticle(target, weapon) {
    radiusinner = gethackertoolinnerradius(target);
    radiusouter = gethackertoolouterradius(target);
    if (target_scaleminmaxradius(target, self, level.hackertoollockonfov, radiusinner, radiusouter) > 0) {
        return 1;
    }
    return target_boundingisunderreticle(self, target, weapon.lockonmaxrange);
}

// Namespace hacker_tool/hacker_tool
// Params 1, eflags: 0x0
// Checksum 0x57b9aec, Offset: 0x2368
// Size: 0x1de
function hackingtimescale(target) {
    hackratio = 1;
    radiusinner = gethackertoolinnerradius(target);
    radiusouter = gethackertoolouterradius(target);
    if (radiusinner != radiusouter) {
        scale = target_scaleminmaxradius(target, self, level.hackertoollockonfov, radiusinner, radiusouter);
        hacktime = lerpfloat(gethackoutertime(target), gethacktime(target), scale);
        /#
            hackertooldebugtext = getdvarint("<dev string:x37>", 0);
            if (hackertooldebugtext) {
                print3d(target.origin, "<dev string:x4b>" + scale + "<dev string:x53>" + radiusinner + "<dev string:x5c>" + radiusouter, (0, 0, 0), 1, hackertooldebugtext, 2);
            }
            assert(hacktime > 0);
        #/
        hackratio = gethacktime(target) / hacktime;
        if (!isdefined(hackratio)) {
            hackratio = 1;
        }
    }
    return hackratio;
}

// Namespace hacker_tool/hacker_tool
// Params 1, eflags: 0x0
// Checksum 0xbd8663bf, Offset: 0x2550
// Size: 0x92
function hackingtimenolineofsightscale(target) {
    hackratio = 1;
    if (isdefined(target.killstreakhacklostlineofsighttimems) && target.killstreakhacklostlineofsighttimems > 0) {
        assert(target.killstreakhacklostlineofsighttimems > 0);
        hackratio = 1000 / target.killstreakhacklostlineofsighttimems;
    }
    return hackratio;
}

// Namespace hacker_tool/hacker_tool
// Params 1, eflags: 0x0
// Checksum 0x5407b1ee, Offset: 0x25f0
// Size: 0xec
function isentityhackableweaponobject(entity) {
    if (isdefined(entity.classname) && entity.classname == "grenade") {
        if (isdefined(entity.weapon)) {
            watcher = weaponobjects::getweaponobjectwatcherbyweapon(entity.weapon);
            if (isdefined(watcher)) {
                if (watcher.hackable) {
                    /#
                        assert(isdefined(watcher.hackertoolradius));
                        assert(isdefined(watcher.hackertooltimems));
                    #/
                    return true;
                }
            }
        }
    }
    return false;
}

// Namespace hacker_tool/hacker_tool
// Params 1, eflags: 0x0
// Checksum 0x78719b65, Offset: 0x26e8
// Size: 0xe2
function getweaponobjecthackerradius(entity) {
    /#
        assert(isdefined(entity.classname));
        assert(isdefined(entity.weapon));
    #/
    watcher = weaponobjects::getweaponobjectwatcherbyweapon(entity.weapon);
    /#
        assert(watcher.hackable);
        assert(isdefined(watcher.hackertoolradius));
    #/
    return watcher.hackertoolradius;
}

// Namespace hacker_tool/hacker_tool
// Params 1, eflags: 0x0
// Checksum 0xdc69d1e6, Offset: 0x27d8
// Size: 0xe2
function getweaponobjecthacktimems(entity) {
    /#
        assert(isdefined(entity.classname));
        assert(isdefined(entity.weapon));
    #/
    watcher = weaponobjects::getweaponobjectwatcherbyweapon(entity.weapon);
    /#
        assert(watcher.hackable);
        assert(isdefined(watcher.hackertooltimems));
    #/
    return watcher.hackertooltimems;
}

// Namespace hacker_tool/hacker_tool
// Params 1, eflags: 0x0
// Checksum 0x4f9a1035, Offset: 0x28c8
// Size: 0x42
function isentityhackablecarepackage(entity) {
    if (isdefined(entity.model)) {
        return (entity.model == "wpn_t7_care_package_world");
    }
    return 0;
}

// Namespace hacker_tool/hacker_tool
// Params 3, eflags: 0x0
// Checksum 0x27744fb7, Offset: 0x2918
// Size: 0x17e
function isvalidhackertooltarget(ent, weapon, allowhacked) {
    if (!isdefined(ent)) {
        return false;
    }
    if (self util::isusingremote()) {
        return false;
    }
    if (self isempjammed()) {
        return false;
    }
    if (!(isdefined(ent.allowhackingaftercloak) && (target_istarget(ent) || ent.allowhackingaftercloak == 1)) && !isentityhackableweaponobject(ent) && !isinarray(level.hackertooltargets, ent)) {
        return false;
    }
    if (isentityhackableweaponobject(ent)) {
        if (distancesquared(self.origin, ent.origin) > weapon.lockonmaxrange * weapon.lockonmaxrange) {
            return false;
        }
    }
    if (allowhacked == 0 && isentitypreviouslyhacked(ent)) {
        return false;
    }
    return true;
}

// Namespace hacker_tool/hacker_tool
// Params 1, eflags: 0x0
// Checksum 0xa5bef03d, Offset: 0x2aa0
// Size: 0x3a
function isentitypreviouslyhacked(entity) {
    if (isdefined(entity.previouslyhacked) && entity.previouslyhacked) {
        return true;
    }
    return false;
}

// Namespace hacker_tool/hacker_tool
// Params 1, eflags: 0x0
// Checksum 0x4ee09a74, Offset: 0x2ae8
// Size: 0x1b8
function hackersoftsighttest(weapon) {
    passed = 1;
    lockontime = 0;
    if (isdefined(self.hackertooltarget)) {
        lockontime = self getlockontime(self.hackertooltarget, weapon);
    }
    if (lockontime == 0 || self isempjammed()) {
        self clearhackertarget(weapon, 0, 0);
        passed = 0;
    } else if (iswithinhackertoolreticle(self.hackertooltarget, weapon) && self heatseekingmissile::locksighttest(self.hackertooltarget)) {
        self.hackertoollostsightlinetime = 0;
    } else {
        if (self.hackertoollostsightlinetime == 0) {
            self.hackertoollostsightlinetime = gettime();
        }
        timepassed = gettime() - self.hackertoollostsightlinetime;
        lostlineofsighttimelimitmsec = level.hackertoollostsightlimitms;
        if (isdefined(self.hackertooltarget.killstreakhacklostlineofsightlimitms)) {
            lostlineofsighttimelimitmsec = self.hackertooltarget.killstreakhacklostlineofsightlimitms;
        }
        if (timepassed >= lostlineofsighttimelimitmsec) {
            self clearhackertarget(weapon, 0, 0);
            passed = 0;
        }
    }
    return passed;
}

// Namespace hacker_tool/hacker_tool
// Params 2, eflags: 0x0
// Checksum 0xd61b199, Offset: 0x2ca8
// Size: 0xb2
function registerwithhackertool(radius, hacktimems) {
    self endon(#"death");
    if (isdefined(radius)) {
        self.hackertoolradius = radius;
    } else {
        self.hackertoolradius = level.hackertoollockonradius;
    }
    if (isdefined(hacktimems)) {
        self.hackertooltimems = hacktimems;
    } else {
        self.hackertooltimems = level.hackertoolhacktimems;
    }
    self thread watchhackableentitydeath();
    level.hackertooltargets[level.hackertooltargets.size] = self;
}

// Namespace hacker_tool/hacker_tool
// Params 0, eflags: 0x0
// Checksum 0xd83cfe3e, Offset: 0x2d68
// Size: 0x34
function watchhackableentitydeath() {
    self waittill("death");
    arrayremovevalue(level.hackertooltargets, self);
}

// Namespace hacker_tool/hacker_tool
// Params 1, eflags: 0x0
// Checksum 0xf14e360c, Offset: 0x2da8
// Size: 0x114
function gethackertoolinnerradius(target) {
    radius = level.hackertoollockonradius;
    if (isentityhackablecarepackage(target)) {
        assert(isdefined(target.hackertoolradius));
        radius = target.hackertoolradius;
    } else if (isentityhackableweaponobject(target)) {
        radius = getweaponobjecthackerradius(target);
    } else if (isdefined(target.hackertoolinnerradius)) {
        radius = target.hackertoolinnerradius;
    } else if (isdefined(target.hackertoolradius)) {
        radius = target.hackertoolradius;
    }
    return radius;
}

// Namespace hacker_tool/hacker_tool
// Params 1, eflags: 0x0
// Checksum 0x99fe971d, Offset: 0x2ec8
// Size: 0x114
function gethackertoolouterradius(target) {
    radius = level.hackertoollockonradius;
    if (isentityhackablecarepackage(target)) {
        assert(isdefined(target.hackertoolradius));
        radius = target.hackertoolradius;
    } else if (isentityhackableweaponobject(target)) {
        radius = getweaponobjecthackerradius(target);
    } else if (isdefined(target.hackertoolouterradius)) {
        radius = target.hackertoolouterradius;
    } else if (isdefined(target.hackertoolradius)) {
        radius = target.hackertoolradius;
    }
    return radius;
}

// Namespace hacker_tool/hacker_tool
// Params 1, eflags: 0x0
// Checksum 0xccdfad34, Offset: 0x2fe8
// Size: 0x17c
function gethacktime(target) {
    time = 500;
    if (isentityhackablecarepackage(target)) {
        assert(isdefined(target.hackertooltimems));
        if (isdefined(target.owner) && target.owner == self) {
            time = level.carepackageownerhackertooltimems;
        } else if (isdefined(target.owner) && target.owner.team == self.team) {
            time = level.carepackagefriendlyhackertooltimems;
        } else {
            time = level.carepackagehackertooltimems;
        }
    } else if (isentityhackableweaponobject(target)) {
        time = getweaponobjecthacktimems(target);
    } else if (isdefined(target.hackertoolinnertimems)) {
        time = target.hackertoolinnertimems;
    } else {
        time = level.vehiclehackertooltimems;
    }
    return time;
}

// Namespace hacker_tool/hacker_tool
// Params 1, eflags: 0x0
// Checksum 0x813053f0, Offset: 0x3170
// Size: 0x17c
function gethackoutertime(target) {
    time = 500;
    if (isentityhackablecarepackage(target)) {
        assert(isdefined(target.hackertooltimems));
        if (isdefined(target.owner) && target.owner == self) {
            time = level.carepackageownerhackertooltimems;
        } else if (isdefined(target.owner) && target.owner.team == self.team) {
            time = level.carepackagefriendlyhackertooltimems;
        } else {
            time = level.carepackagehackertooltimems;
        }
    } else if (isentityhackableweaponobject(target)) {
        time = getweaponobjecthacktimems(target);
    } else if (isdefined(target.hackertooloutertimems)) {
        time = target.hackertooloutertimems;
    } else {
        time = level.vehiclehackertooltimems;
    }
    return time;
}

// Namespace hacker_tool/hacker_tool
// Params 2, eflags: 0x0
// Checksum 0xf2f5c631, Offset: 0x32f8
// Size: 0x8c
function getlockontime(target, weapon) {
    locklengthms = self gethacktime(self.hackertooltarget);
    if (locklengthms == 0) {
        return 0;
    }
    lockonspeed = weapon.lockonspeed;
    if (lockonspeed <= 0) {
        lockonspeed = 1000;
    }
    return locklengthms / lockonspeed;
}

/#

    // Namespace hacker_tool/hacker_tool
    // Params 0, eflags: 0x0
    // Checksum 0x5b468b52, Offset: 0x3390
    // Size: 0x94
    function tunables() {
        while (true) {
            level.hackertoollostsightlimitms = getdvarint("<dev string:x65>", 1000);
            level.hackertoollockonradius = getdvarfloat("<dev string:x84>", 20);
            level.hackertoollockonfov = getdvarint("<dev string:x9f>", 65);
            wait 1;
        }
    }

#/
