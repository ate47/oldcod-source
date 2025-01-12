#using scripts/core_common/ai/archetype_utility;
#using scripts/core_common/ai/systems/debug;
#using scripts/core_common/ai/systems/shared;
#using scripts/core_common/ai/systems/weaponlist;
#using scripts/core_common/gameskill_shared;
#using scripts/core_common/name_shared;
#using scripts/core_common/util_shared;

#namespace init;

// Namespace init/init
// Params 1, eflags: 0x0
// Checksum 0x8cad8f98, Offset: 0x2a0
// Size: 0xe8
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
// Checksum 0x7f0eb2, Offset: 0x390
// Size: 0x5ec
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
    self thread begingrenadetracking();
    self thread function_b44e1bfd();
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
    if (self.team == "axis" || self.team == "team3") {
        self thread gameskill::function_f7773608();
    } else if (self.team == "allies") {
        self thread gameskill::function_54f3f08b();
    }
    self.a.misstime = 0;
    self.ai.bulletsinclip = self.weapon.clipsize;
    self.lastenemysighttime = 0;
    self.combattime = 0;
    self.suppressed = 0;
    self.suppressedtime = 0;
    if (self.team == "allies") {
        self.suppressionthreshold = 0.75;
    } else {
        self.suppressionthreshold = 0.5;
    }
    if (self.team == "allies") {
        self.randomgrenaderange = 0;
    } else {
        self.randomgrenaderange = 128;
    }
    self.reacquire_state = 0;
}

// Namespace init/init
// Params 0, eflags: 0x0
// Checksum 0xca1d6df4, Offset: 0x988
// Size: 0x24
function setnameandrank() {
    self endon(#"death");
    self name::get();
}

// Namespace init/init
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x9b8
// Size: 0x4
function donothing() {
    
}

// Namespace init/init
// Params 0, eflags: 0x0
// Checksum 0xce6dd3ed, Offset: 0x9c8
// Size: 0x40
function set_anim_playback_rate() {
    self.animplaybackrate = 0.9 + randomfloat(0.2);
    self.moveplaybackrate = 1;
}

// Namespace init/init
// Params 0, eflags: 0x0
// Checksum 0xafd1b411, Offset: 0xa10
// Size: 0x30
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
    // Checksum 0xef82c523, Offset: 0xa48
    // Size: 0x420
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
                if (trans == "<dev string:x28>" || trans == "<dev string:x2d>") {
                    idealadd = 90;
                } else if (trans == "<dev string:x39>" || trans == "<dev string:x3f>") {
                    idealadd = -90;
                }
                if (isdefined(anim.covertransangles[trans][i])) {
                    correctangle = angleclamp180(idealtransangles[i] + idealadd);
                    actualangle = angleclamp180(anim.covertransangles[trans][i]);
                    if (absangleclamp180(actualangle - correctangle) > 7) {
                        println("<dev string:x4c>" + trans + "<dev string:x8c>" + i + "<dev string:x90>" + actualangle + "<dev string:x99>" + correctangle + "<dev string:xb4>");
                    }
                }
            }
        }
        for (i = 1; i <= 9; i++) {
            for (j = 0; j < transtypes.size; j++) {
                trans = transtypes[j];
                idealadd = 0;
                if (trans == "<dev string:x28>" || trans == "<dev string:x2d>") {
                    idealadd = 90;
                } else if (trans == "<dev string:x39>" || trans == "<dev string:x3f>") {
                    idealadd = -90;
                }
                if (isdefined(anim.coverexitangles[trans][i])) {
                    correctangle = angleclamp180(-1 * (idealtransangles[i] + idealadd + 180));
                    actualangle = angleclamp180(anim.coverexitangles[trans][i]);
                    if (absangleclamp180(actualangle - correctangle) > 7) {
                        println("<dev string:xb8>" + trans + "<dev string:x8c>" + i + "<dev string:x90>" + actualangle + "<dev string:x99>" + correctangle + "<dev string:xb4>");
                    }
                }
            }
        }
    }

#/

// Namespace init/init
// Params 2, eflags: 0x0
// Checksum 0xcd483019, Offset: 0xe70
// Size: 0x2a
function getexitsplittime(approachtype, dir) {
    return anim.coverexitsplit[approachtype][dir];
}

// Namespace init/init
// Params 2, eflags: 0x0
// Checksum 0xc055e3d6, Offset: 0xea8
// Size: 0x2a
function gettranssplittime(approachtype, dir) {
    return anim.covertranssplit[approachtype][dir];
}

// Namespace init/init
// Params 0, eflags: 0x0
// Checksum 0x6e118fb9, Offset: 0xee0
// Size: 0x1a0
function firstinit() {
    if (isdefined(anim.notfirsttime)) {
        return;
    }
    anim.notfirsttime = 1;
    anim.grenadetimers["player_frag_grenade_sp"] = randomintrange(1000, 20000);
    anim.grenadetimers["player_flash_grenade_sp"] = randomintrange(1000, 20000);
    anim.grenadetimers["player_double_grenade"] = randomintrange(10000, 60000);
    anim.grenadetimers["AI_frag_grenade_sp"] = randomintrange(0, 20000);
    anim.grenadetimers["AI_flash_grenade_sp"] = randomintrange(0, 20000);
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
// Checksum 0x8b0f8d60, Offset: 0x1088
// Size: 0x34
function onplayerconnect() {
    player = self;
    firstinit();
    player.invul = 0;
}

// Namespace init/init
// Params 0, eflags: 0x0
// Checksum 0x592ac7fe, Offset: 0x10c8
// Size: 0x17a
function setnextplayergrenadetime() {
    waittillframeend();
    if (isdefined(anim.playergrenaderangetime)) {
        maxtime = int(anim.playergrenaderangetime * 0.7);
        if (maxtime < 1) {
            maxtime = 1;
        }
        anim.grenadetimers["player_frag_grenade_sp"] = randomintrange(0, maxtime);
        anim.grenadetimers["player_flash_grenade_sp"] = randomintrange(0, maxtime);
    }
    if (isdefined(anim.playerdoublegrenadetime)) {
        maxtime = int(anim.playerdoublegrenadetime);
        mintime = int(maxtime / 2);
        if (maxtime <= mintime) {
            maxtime = mintime + 1;
        }
        anim.grenadetimers["player_double_grenade"] = randomintrange(mintime, maxtime);
    }
}

// Namespace init/init
// Params 1, eflags: 0x0
// Checksum 0x7c8ebca, Offset: 0x1250
// Size: 0xec
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

// Namespace init/init
// Params 0, eflags: 0x0
// Checksum 0xdce109c, Offset: 0x1348
// Size: 0xf0
function function_b44e1bfd() {
    if (!isdefined(level.missileentities)) {
        level.missileentities = [];
    }
    self endon(#"death");
    self thread function_48cec971();
    self thread function_a86baa0f();
    for (;;) {
        waitresult = self waittill("grenade_fire");
        grenade = waitresult.projectile;
        weapon = waitresult.weapon;
        grenade.owner = self;
        grenade.weapon = weapon;
        level thread addtomissiles(grenade);
    }
}

// Namespace init/init
// Params 0, eflags: 0x0
// Checksum 0x274502fd, Offset: 0x1440
// Size: 0x90
function function_48cec971() {
    self endon(#"death");
    for (;;) {
        waitresult = self waittill("grenade_launcher_fire");
        waitresult.projectile.owner = self;
        waitresult.projectile.weapon = waitresult.weapon;
        level thread addtomissiles(waitresult.projectile);
    }
}

// Namespace init/init
// Params 0, eflags: 0x0
// Checksum 0xb6c590aa, Offset: 0x14d8
// Size: 0x90
function function_a86baa0f() {
    self endon(#"death");
    for (;;) {
        waitresult = self waittill("missile_fire");
        waitresult.projectile.owner = self;
        waitresult.projectile.weapon = waitresult.weapon;
        level thread addtomissiles(waitresult.projectile);
    }
}

// Namespace init/init
// Params 0, eflags: 0x0
// Checksum 0x3516079f, Offset: 0x1570
// Size: 0x50
function begingrenadetracking() {
    self endon(#"death");
    for (;;) {
        waitresult = self waittill("grenade_fire");
        waitresult.projectile thread grenade_earthquake();
    }
}

// Namespace init/init
// Params 0, eflags: 0x0
// Checksum 0xef2732e5, Offset: 0x15c8
// Size: 0x22
function endondeath() {
    self waittill("death");
    waittillframeend();
    self notify(#"end_explode");
}

// Namespace init/init
// Params 0, eflags: 0x0
// Checksum 0x6866c0eb, Offset: 0x15f8
// Size: 0x9c
function grenade_earthquake() {
    self thread endondeath();
    self endon(#"end_explode");
    waitresult = self waittill("explode");
    playrumbleonposition("grenade_rumble", waitresult.position);
    earthquake(0.3, 0.5, waitresult.position, 400);
}

// Namespace init/init
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x16a0
// Size: 0x4
function end_script() {
    
}

