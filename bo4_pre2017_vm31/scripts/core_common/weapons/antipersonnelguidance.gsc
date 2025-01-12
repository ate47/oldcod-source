#using scripts/core_common/abilities/ability_util;
#using scripts/core_common/array_shared;
#using scripts/core_common/callbacks_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/flagsys_shared;
#using scripts/core_common/hud_util_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;

#namespace singlelockap_guidance;

// Namespace singlelockap_guidance/antipersonnelguidance
// Params 0, eflags: 0x2
// Checksum 0xcaae1a34, Offset: 0x270
// Size: 0x34
function autoexec __init__sytem__() {
    system::register("singlelockap_guidance", &__init__, undefined, undefined);
}

// Namespace singlelockap_guidance/antipersonnelguidance
// Params 0, eflags: 0x0
// Checksum 0x37d181cb, Offset: 0x2b0
// Size: 0x24
function __init__() {
    callback::on_spawned(&on_player_spawned);
}

// Namespace singlelockap_guidance/antipersonnelguidance
// Params 0, eflags: 0x0
// Checksum 0x17ab3acd, Offset: 0x2e0
// Size: 0x4c
function on_player_spawned() {
    self endon(#"disconnect");
    self clearaptarget();
    thread aptoggleloop();
    self thread function_c0677ebd();
}

// Namespace singlelockap_guidance/antipersonnelguidance
// Params 2, eflags: 0x0
// Checksum 0x687d19b9, Offset: 0x338
// Size: 0x26c
function clearaptarget(weapon, whom) {
    if (!isdefined(self.multilocklist)) {
        self.multilocklist = [];
    }
    if (isdefined(whom)) {
        for (i = 0; i < self.multilocklist.size; i++) {
            if (whom.aptarget == self.multilocklist[i].aptarget) {
                self.multilocklist[i].aptarget notify(#"missile_unlocked");
                self notify("stop_sound" + whom.apsoundid);
                self weaponlockremoveslot(i);
                arrayremovevalue(self.multilocklist, whom, 0);
                break;
            }
        }
    } else {
        for (i = 0; i < self.multilocklist.size; i++) {
            self.multilocklist[i].aptarget notify(#"missile_unlocked");
            self notify("stop_sound" + self.multilocklist[i].apsoundid);
        }
        self.multilocklist = [];
    }
    if (self.multilocklist.size == 0) {
        self stoprumble("stinger_lock_rumble");
        self weaponlockremoveslot(-1);
        if (isdefined(weapon)) {
            if (isdefined(weapon.lockonseekersearchsound)) {
                self stoplocalsound(weapon.lockonseekersearchsound);
            }
            if (isdefined(weapon.lockonseekerlockedsound)) {
                self stoplocalsound(weapon.lockonseekerlockedsound);
            }
        }
        self destroylockoncanceledmessage();
    }
}

// Namespace singlelockap_guidance/antipersonnelguidance
// Params 0, eflags: 0x0
// Checksum 0x20e1803, Offset: 0x5b0
// Size: 0x166
function function_c0677ebd() {
    self endon(#"disconnect");
    self endon(#"death");
    while (true) {
        waitresult = self waittill("missile_fire");
        missile = waitresult.projectile;
        weapon = waitresult.weapon;
        if (weapon.lockontype == "AP Single") {
            foreach (target in self.multilocklist) {
                if (isdefined(target.aptarget) && target.aplockfinalized) {
                    target.aptarget notify(#"stinger_fired_at_me", {#projectile:missile, #weapon:weapon, #attacker:self});
                }
            }
        }
    }
}

// Namespace singlelockap_guidance/antipersonnelguidance
// Params 0, eflags: 0x0
// Checksum 0x50982b16, Offset: 0x720
// Size: 0x190
function aptoggleloop() {
    self endon(#"disconnect");
    self endon(#"death");
    for (;;) {
        waitresult = self waittill("weapon_change");
        for (weapon = waitresult.weapon; weapon.lockontype == "AP Single"; weapon = self getcurrentweapon()) {
            abort = 0;
            while (!(self playerads() == 1)) {
                waitframe(1);
                currentweapon = self getcurrentweapon();
                if (currentweapon.lockontype != "AP Single") {
                    abort = 1;
                    break;
                }
            }
            if (abort) {
                break;
            }
            self thread aplockloop(weapon);
            while (self playerads() == 1) {
                waitframe(1);
            }
            self notify(#"ap_off");
            self clearaptarget(weapon);
        }
    }
}

// Namespace singlelockap_guidance/antipersonnelguidance
// Params 1, eflags: 0x0
// Checksum 0x70d834b9, Offset: 0x8b8
// Size: 0x556
function aplockloop(weapon) {
    self endon(#"disconnect");
    self endon(#"death");
    self endon(#"ap_off");
    locklength = self getlockonspeed();
    self.multilocklist = [];
    for (;;) {
        waitframe(1);
        do {
            done = 1;
            foreach (target in self.multilocklist) {
                if (target.aplockfinalized) {
                    if (!isstillvalidtarget(weapon, target.aptarget)) {
                        self clearaptarget(weapon, target);
                        done = 0;
                        break;
                    }
                }
            }
        } while (!done);
        inlockingstate = 0;
        do {
            done = 1;
            for (i = 0; i < self.multilocklist.size; i++) {
                target = self.multilocklist[i];
                if (target.aplocking) {
                    if (!isstillvalidtarget(weapon, target.aptarget)) {
                        self clearaptarget(weapon, target);
                        done = 0;
                        break;
                    }
                    inlockingstate = 1;
                    timepassed = gettime() - target.aplockstarttime;
                    if (timepassed < locklength) {
                        continue;
                    }
                    assert(isdefined(target.aptarget));
                    target.aplockfinalized = 1;
                    target.aplocking = 0;
                    target.aplockpending = 0;
                    self weaponlockfinalize(target.aptarget, i);
                    self thread seekersound(weapon.lockonseekerlockedsound, weapon.lockonseekerlockedsoundloops, target.apsoundid);
                    target.aptarget notify(#"missile_lock", {#attacker:self, #weapon:weapon});
                }
            }
        } while (!done);
        if (!inlockingstate) {
            do {
                done = 1;
                for (i = 0; i < self.multilocklist.size; i++) {
                    target = self.multilocklist[i];
                    if (target.aplockpending) {
                        if (!isstillvalidtarget(weapon, target.aptarget)) {
                            self clearaptarget(weapon, target);
                            done = 0;
                            break;
                        }
                        target.aplockstarttime = gettime();
                        target.aplockfinalized = 0;
                        target.aplockpending = 0;
                        target.aplocking = 1;
                        self thread seekersound(weapon.lockonseekersearchsound, weapon.lockonseekersearchsoundloops, target.apsoundid);
                        done = 1;
                        break;
                    }
                }
            } while (!done);
        }
        if (self.multilocklist.size >= 1) {
            continue;
        }
        besttarget = self getbesttarget(weapon);
        if (!isdefined(besttarget) && self.multilocklist.size == 0) {
            self destroylockoncanceledmessage();
            continue;
        }
        if (isdefined(besttarget) && self.multilocklist.size < 1) {
            self weaponlockstart(besttarget.aptarget, self.multilocklist.size);
            self.multilocklist[self.multilocklist.size] = besttarget;
        }
    }
}

// Namespace singlelockap_guidance/antipersonnelguidance
// Params 0, eflags: 0x0
// Checksum 0x1f156018, Offset: 0xe18
// Size: 0x2c
function destroylockoncanceledmessage() {
    if (isdefined(self.lockoncanceledmessage)) {
        self.lockoncanceledmessage destroy();
    }
}

// Namespace singlelockap_guidance/antipersonnelguidance
// Params 0, eflags: 0x0
// Checksum 0x60f7fbdc, Offset: 0xe50
// Size: 0x16c
function displaylockoncanceledmessage() {
    if (isdefined(self.lockoncanceledmessage)) {
        return;
    }
    self.lockoncanceledmessage = newclienthudelem(self);
    self.lockoncanceledmessage.fontscale = 1.25;
    self.lockoncanceledmessage.x = 0;
    self.lockoncanceledmessage.y = 50;
    self.lockoncanceledmessage.alignx = "center";
    self.lockoncanceledmessage.aligny = "top";
    self.lockoncanceledmessage.horzalign = "center";
    self.lockoncanceledmessage.vertalign = "top";
    self.lockoncanceledmessage.foreground = 1;
    self.lockoncanceledmessage.hidewhendead = 0;
    self.lockoncanceledmessage.hidewheninmenu = 1;
    self.lockoncanceledmessage.archived = 0;
    self.lockoncanceledmessage.alpha = 1;
    self.lockoncanceledmessage settext(%MP_CANNOT_LOCKON_TO_TARGET);
}

// Namespace singlelockap_guidance/antipersonnelguidance
// Params 1, eflags: 0x0
// Checksum 0xf2a355cc, Offset: 0xfc8
// Size: 0x53e
function getbesttarget(weapon) {
    playertargets = getplayers();
    vehicletargets = target_getarray();
    targetsall = getaiteamarray();
    targetsall = arraycombine(targetsall, playertargets, 0, 0);
    targetsall = arraycombine(targetsall, vehicletargets, 0, 0);
    targetsvalid = [];
    for (idx = 0; idx < targetsall.size; idx++) {
        if (level.teambased) {
            if (isdefined(targetsall[idx].team) && targetsall[idx].team != self.team) {
                if (self insideapreticlenolock(targetsall[idx])) {
                    if (self locksighttest(targetsall[idx])) {
                        targetsvalid[targetsvalid.size] = targetsall[idx];
                    }
                }
            }
            continue;
        }
        if (self insideapreticlenolock(targetsall[idx])) {
            if (isdefined(targetsall[idx].owner) && self != targetsall[idx].owner) {
                if (self locksighttest(targetsall[idx])) {
                    targetsvalid[targetsvalid.size] = targetsall[idx];
                }
            }
        }
    }
    if (targetsvalid.size == 0) {
        return undefined;
    }
    playerforward = anglestoforward(self getplayerangles());
    dots = [];
    for (i = 0; i < targetsvalid.size; i++) {
        newitem = spawnstruct();
        newitem.index = i;
        newitem.dot = vectordot(playerforward, vectornormalize(targetsvalid[i].origin - self.origin));
        array::function_5fee9333(dots, &targetinsertionsortcompare, newitem);
    }
    index = 0;
    foreach (dot in dots) {
        found = 0;
        foreach (lock in self.multilocklist) {
            if (lock.aptarget == targetsvalid[dot.index]) {
                found = 1;
            }
        }
        if (found) {
            continue;
        }
        newentry = spawnstruct();
        newentry.aptarget = targetsvalid[dot.index];
        newentry.aplockstarttime = gettime();
        newentry.aplockpending = 1;
        newentry.aplocking = 0;
        newentry.aplockfinalized = 0;
        newentry.aplostsightlinetime = 0;
        newentry.apsoundid = randomint(2147483647);
        return newentry;
    }
    return undefined;
}

// Namespace singlelockap_guidance/antipersonnelguidance
// Params 2, eflags: 0x0
// Checksum 0x2e3cc306, Offset: 0x1510
// Size: 0x60
function targetinsertionsortcompare(a, b) {
    if (a.dot < b.dot) {
        return -1;
    }
    if (a.dot > b.dot) {
        return 1;
    }
    return 0;
}

// Namespace singlelockap_guidance/antipersonnelguidance
// Params 1, eflags: 0x0
// Checksum 0x1d2c0bb2, Offset: 0x1578
// Size: 0x52
function insideapreticlenolock(target) {
    radius = self getlockonradius();
    return target_isincircle(target, self, 65, radius);
}

// Namespace singlelockap_guidance/antipersonnelguidance
// Params 1, eflags: 0x0
// Checksum 0x873d4baa, Offset: 0x15d8
// Size: 0x52
function insideapreticlelocked(target) {
    radius = self getlockonlossradius();
    return target_isincircle(target, self, 65, radius);
}

// Namespace singlelockap_guidance/antipersonnelguidance
// Params 2, eflags: 0x0
// Checksum 0x178e0594, Offset: 0x1638
// Size: 0x86
function isstillvalidtarget(weapon, ent) {
    if (!isdefined(ent)) {
        return false;
    }
    if (!insideapreticlelocked(ent)) {
        return false;
    }
    if (!isalive(ent)) {
        return false;
    }
    if (!locksighttest(ent)) {
        return false;
    }
    return true;
}

// Namespace singlelockap_guidance/antipersonnelguidance
// Params 3, eflags: 0x0
// Checksum 0xdf1c69ed, Offset: 0x16c8
// Size: 0xf4
function seekersound(alias, looping, id) {
    self notify("stop_sound" + id);
    self endon("stop_sound" + id);
    self endon(#"disconnect");
    self endon(#"death");
    if (isdefined(alias)) {
        self playrumbleonentity("stinger_lock_rumble");
        time = soundgetplaybacktime(alias) * 0.001;
        do {
            self playlocalsound(alias);
            wait time;
        } while (looping);
        self stoprumble("stinger_lock_rumble");
    }
}

// Namespace singlelockap_guidance/antipersonnelguidance
// Params 1, eflags: 0x0
// Checksum 0x56f1ae37, Offset: 0x17c8
// Size: 0x180
function locksighttest(target) {
    eyepos = self geteye();
    if (!isdefined(target)) {
        return false;
    }
    if (!isalive(target)) {
        return false;
    }
    pos = target getshootatpos();
    if (isdefined(pos)) {
        passed = bullettracepassed(eyepos, pos, 0, target, undefined, 1, 1);
        if (passed) {
            return true;
        }
    }
    pos = target getcentroid();
    if (isdefined(pos)) {
        passed = bullettracepassed(eyepos, pos, 0, target, undefined, 1, 1);
        if (passed) {
            return true;
        }
    }
    pos = target.origin;
    passed = bullettracepassed(eyepos, pos, 0, target, undefined, 1, 1);
    if (passed) {
        return true;
    }
    return false;
}

