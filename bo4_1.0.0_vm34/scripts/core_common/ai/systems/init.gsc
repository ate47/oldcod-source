#using scripts\core_common\ai\archetype_utility;
#using scripts\core_common\ai\systems\shared;
#using scripts\core_common\name_shared;

#namespace init;

// Namespace init/init
// Params 1, eflags: 0x0
// Checksum 0x5b442fc, Offset: 0xb0
// Size: 0xd6
function initweapon(weapon) {
    self.weaponinfo[weapon.name] = spawnstruct();
    self.weaponinfo[weapon.name].position = "none";
    self.weaponinfo[weapon.name].hasclip = 1;
    if (isdefined(weapon.clipmodel)) {
        self.weaponinfo[weapon.name].useclip = 1;
        return;
    }
    self.weaponinfo[weapon.name].useclip = 0;
}

// Namespace init/init
// Params 0, eflags: 0x0
// Checksum 0xa7f4d9ad, Offset: 0x190
// Size: 0x46a
function main() {
    self.a = spawnstruct();
    self.a.weaponpos = [];
    if (self.weapon == level.weaponnone) {
        self aiutility::setcurrentweapon(level.weaponnone);
    }
    self aiutility::setprimaryweapon(self.weapon);
    if (self.secondaryweapon == level.weaponnone) {
        self aiutility::setsecondaryweapon(level.weaponnone);
    }
    self aiutility::setsecondaryweapon(self.secondaryweapon);
    self aiutility::setcurrentweapon(self.primaryweapon);
    self.initial_primaryweapon = self.primaryweapon;
    self.initial_secondaryweapon = self.secondaryweapon;
    self initweapon(self.primaryweapon);
    self initweapon(self.secondaryweapon);
    self initweapon(self.sidearm);
    self.weapon_positions = array("left", "right", "chest", "back");
    for (i = 0; i < self.weapon_positions.size; i++) {
        self.a.weaponpos[self.weapon_positions[i]] = level.weaponnone;
    }
    self.lastweapon = self.weapon;
    firstinit();
    self.a.rockets = 3;
    self.a.rocketvisible = 1;
    self.a.pose = "stand";
    self.a.prevpose = self.a.pose;
    self.a.movement = "stop";
    self.a.special = "none";
    self.a.gunhand = "none";
    shared::placeweaponon(self.primaryweapon, "right");
    if (isdefined(self.secondaryweaponclass) && self.secondaryweaponclass != "none" && self.secondaryweaponclass != "pistol") {
        shared::placeweaponon(self.secondaryweapon, "back");
    }
    self.a.combatendtime = gettime();
    self.a.nextgrenadetrytime = 0;
    self.a.isaiming = 0;
    self.rightaimlimit = 45;
    self.leftaimlimit = -45;
    self.upaimlimit = 45;
    self.downaimlimit = -45;
    self.walk = 0;
    self.sprint = 0;
    self.a.postscriptfunc = undefined;
    self.baseaccuracy = self.accuracy;
    if (!isdefined(self.script_accuracy)) {
        self.script_accuracy = 1;
    }
    self.a.misstime = 0;
    self.ai.bulletsinclip = self.weapon.clipsize;
    self.lastenemysighttime = 0;
    self.combattime = 0;
    self.suppressed = 0;
    self.suppressedtime = 0;
    self.suppressionthreshold = 0.75;
    self.randomgrenaderange = 128;
    self.reacquire_state = 0;
}

// Namespace init/init
// Params 0, eflags: 0x0
// Checksum 0xefa1b470, Offset: 0x608
// Size: 0x2c
function setnameandrank() {
    self endon(#"death");
    self name::get();
}

// Namespace init/init
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x640
// Size: 0x4
function donothing() {
    
}

// Namespace init/init
// Params 0, eflags: 0x0
// Checksum 0xd7a1b20b, Offset: 0x650
// Size: 0x3a
function set_anim_playback_rate() {
    self.animplaybackrate = 0.9 + randomfloat(0.2);
    self.moveplaybackrate = 1;
}

// Namespace init/init
// Params 0, eflags: 0x0
// Checksum 0x55a5f9ff, Offset: 0x698
// Size: 0x34
function trackvelocity() {
    self endon(#"death");
    for (;;) {
        self.oldorigin = self.origin;
        wait 0.2;
    }
}

/#

    // Namespace init/init
    // Params 1, eflags: 0x0
    // Checksum 0xf2e83fb4, Offset: 0x6d8
    // Size: 0x400
    function checkapproachangles(transtypes) {
        idealtransangles[1] = 45;
        idealtransangles[2] = 0;
        idealtransangles[3] = -45;
        idealtransangles[4] = 90;
        idealtransangles[6] = -90;
        idealtransangles[7] = 135;
        idealtransangles[8] = 180;
        idealtransangles[9] = -135;
        waitframe(1);
        for (i = 1; i <= 9; i++) {
            for (j = 0; j < transtypes.size; j++) {
                trans = transtypes[j];
                idealadd = 0;
                if (trans == "<dev string:x30>" || trans == "<dev string:x35>") {
                    idealadd = 90;
                } else if (trans == "<dev string:x41>" || trans == "<dev string:x47>") {
                    idealadd = -90;
                }
                if (isdefined(anim.covertransangles[trans][i])) {
                    correctangle = angleclamp180(idealtransangles[i] + idealadd);
                    actualangle = angleclamp180(anim.covertransangles[trans][i]);
                    if (absangleclamp180(actualangle - correctangle) > 7) {
                        println("<dev string:x54>" + trans + "<dev string:x94>" + i + "<dev string:x98>" + actualangle + "<dev string:xa1>" + correctangle + "<dev string:xbc>");
                    }
                }
            }
        }
        for (i = 1; i <= 9; i++) {
            for (j = 0; j < transtypes.size; j++) {
                trans = transtypes[j];
                idealadd = 0;
                if (trans == "<dev string:x30>" || trans == "<dev string:x35>") {
                    idealadd = 90;
                } else if (trans == "<dev string:x41>" || trans == "<dev string:x47>") {
                    idealadd = -90;
                }
                if (isdefined(anim.coverexitangles[trans][i])) {
                    correctangle = angleclamp180(-1 * (idealtransangles[i] + idealadd + 180));
                    actualangle = angleclamp180(anim.coverexitangles[trans][i]);
                    if (absangleclamp180(actualangle - correctangle) > 7) {
                        println("<dev string:xc0>" + trans + "<dev string:x94>" + i + "<dev string:x98>" + actualangle + "<dev string:xa1>" + correctangle + "<dev string:xbc>");
                    }
                }
            }
        }
    }

#/

// Namespace init/init
// Params 2, eflags: 0x0
// Checksum 0xbcc4ef6c, Offset: 0xae0
// Size: 0x2a
function getexitsplittime(approachtype, dir) {
    return anim.coverexitsplit[approachtype][dir];
}

// Namespace init/init
// Params 2, eflags: 0x0
// Checksum 0x243c4107, Offset: 0xb18
// Size: 0x2a
function gettranssplittime(approachtype, dir) {
    return anim.covertranssplit[approachtype][dir];
}

// Namespace init/init
// Params 0, eflags: 0x0
// Checksum 0x78165628, Offset: 0xb50
// Size: 0x1c6
function firstinit() {
    if (isdefined(anim.notfirsttime)) {
        return;
    }
    anim.notfirsttime = 1;
    anim.grenadetimers[#"player_frag_grenade_sp"] = randomintrange(1000, 20000);
    anim.grenadetimers[#"player_flash_grenade_sp"] = randomintrange(1000, 20000);
    anim.grenadetimers[#"player_double_grenade"] = randomintrange(10000, 60000);
    anim.grenadetimers[#"ai_frag_grenade_sp"] = randomintrange(0, 20000);
    anim.grenadetimers[#"ai_flash_grenade_sp"] = randomintrange(0, 20000);
    anim.numgrenadesinprogresstowardsplayer = 0;
    anim.lastgrenadelandednearplayertime = -1000000;
    anim.lastfraggrenadetoplayerstart = -1000000;
    thread setnextplayergrenadetime();
    if (!isdefined(level.flag)) {
        level.flag = [];
    }
    level.painai = undefined;
    anim.covercrouchleanpitch = -55;
}

// Namespace init/init
// Params 0, eflags: 0x0
// Checksum 0x47978cc5, Offset: 0xd20
// Size: 0x32
function onplayerconnect() {
    player = self;
    firstinit();
    player.invul = 0;
}

// Namespace init/init
// Params 0, eflags: 0x0
// Checksum 0x18ce604c, Offset: 0xd60
// Size: 0x172
function setnextplayergrenadetime() {
    waittillframeend();
    if (isdefined(anim.playergrenaderangetime)) {
        maxtime = int(anim.playergrenaderangetime * 0.7);
        if (maxtime < 1) {
            maxtime = 1;
        }
        anim.grenadetimers[#"player_frag_grenade_sp"] = randomintrange(0, maxtime);
        anim.grenadetimers[#"player_flash_grenade_sp"] = randomintrange(0, maxtime);
    }
    if (isdefined(anim.playerdoublegrenadetime)) {
        maxtime = int(anim.playerdoublegrenadetime);
        mintime = int(maxtime / 2);
        if (maxtime <= mintime) {
            maxtime = mintime + 1;
        }
        anim.grenadetimers[#"player_double_grenade"] = randomintrange(mintime, maxtime);
    }
}

// Namespace init/init
// Params 1, eflags: 0x0
// Checksum 0xab09e043, Offset: 0xee0
// Size: 0xdc
function addtomissiles(grenade) {
    if (!isdefined(level.missileentities)) {
        level.missileentities = [];
    }
    if (!isdefined(level.missileentities)) {
        level.missileentities = [];
    } else if (!isarray(level.missileentities)) {
        level.missileentities = array(level.missileentities);
    }
    level.missileentities[level.missileentities.size] = grenade;
    while (isdefined(grenade)) {
        waitframe(1);
    }
    arrayremovevalue(level.missileentities, grenade);
}

// Namespace init/grenade_fire
// Params 1, eflags: 0x40
// Checksum 0x43f48eb6, Offset: 0xfc8
// Size: 0x74
function event_handler[grenade_fire] function_5676a831(eventstruct) {
    grenade = eventstruct.projectile;
    weapon = eventstruct.weapon;
    if (isdefined(grenade)) {
        grenade.owner = self;
        grenade.weapon = weapon;
        level thread addtomissiles(grenade);
    }
}

// Namespace init/grenade_launcher_fire
// Params 1, eflags: 0x40
// Checksum 0x4878150c, Offset: 0x1048
// Size: 0x64
function event_handler[grenade_launcher_fire] function_b00544c5(eventstruct) {
    eventstruct.projectile.owner = self;
    eventstruct.projectile.weapon = eventstruct.weapon;
    level thread addtomissiles(eventstruct.projectile);
}

// Namespace init/missile_fire
// Params 1, eflags: 0x40
// Checksum 0x7c9f58c, Offset: 0x10b8
// Size: 0x64
function event_handler[missile_fire] function_465aaa67(eventstruct) {
    eventstruct.projectile.owner = self;
    eventstruct.projectile.weapon = eventstruct.weapon;
    level thread addtomissiles(eventstruct.projectile);
}

// Namespace init/init
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x1128
// Size: 0x4
function end_script() {
    
}

