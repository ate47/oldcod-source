#using scripts/core_common/callbacks_shared;
#using scripts/core_common/challenges_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/scoreevents_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;
#using scripts/core_common/weapons/weaponobjects;

#namespace bouncingbetty;

// Namespace bouncingbetty/bouncingbetty
// Params 0, eflags: 0x0
// Checksum 0x3b3a646, Offset: 0x498
// Size: 0x304
function init_shared() {
    level.bettydestroyedfx = "weapon/fx_betty_exp_destroyed";
    level._effect["fx_betty_friendly_light"] = "weapon/fx_betty_light_blue";
    level._effect["fx_betty_enemy_light"] = "weapon/fx_betty_light_orng";
    level.bettymindist = 20;
    level.bettystuntime = 1;
    bettyexplodeanim = bouncing_betty%o_spider_mine_detonate;
    bettydeployanim = bouncing_betty%o_spider_mine_deploy;
    level.bettyradius = getdvarint("betty_detect_radius", 180);
    level.bettyactivationdelay = getdvarfloat("betty_activation_delay", 1);
    level.bettygraceperiod = getdvarfloat("betty_grace_period", 0);
    level.bettydamageradius = getdvarint("betty_damage_radius", 180);
    level.bettydamagemax = getdvarint("betty_damage_max", 180);
    level.bettydamagemin = getdvarint("betty_damage_min", 70);
    level.bettydamageheight = getdvarint("betty_damage_cylinder_height", 200);
    level.bettyjumpheight = getdvarint("betty_jump_height_onground", 55);
    level.bettyjumpheightwall = getdvarint("betty_jump_height_wall", 20);
    level.bettyjumpheightwallangle = getdvarint("betty_onground_angle_threshold", 30);
    level.bettyjumpheightwallanglecos = cos(level.bettyjumpheightwallangle);
    level.bettyjumptime = getdvarfloat("betty_jump_time", 0.7);
    level.bettybombletspawndistance = 20;
    level.bettybombletcount = 4;
    level thread register();
    /#
        level thread bouncingbettydvarupdate();
    #/
    callback::add_weapon_watcher(&createbouncingbettywatcher);
}

// Namespace bouncingbetty/bouncingbetty
// Params 0, eflags: 0x0
// Checksum 0xc29710f8, Offset: 0x7a8
// Size: 0x64
function register() {
    clientfield::register("missile", "bouncingbetty_state", 1, 2, "int");
    clientfield::register("scriptmover", "bouncingbetty_state", 1, 2, "int");
}

/#

    // Namespace bouncingbetty/bouncingbetty
    // Params 0, eflags: 0x0
    // Checksum 0xd1d2a275, Offset: 0x818
    // Size: 0x24a
    function bouncingbettydvarupdate() {
        for (;;) {
            level.bettyradius = getdvarint("<dev string:x28>", level.bettyradius);
            level.bettyactivationdelay = getdvarfloat("<dev string:x3c>", level.bettyactivationdelay);
            level.bettygraceperiod = getdvarfloat("<dev string:x53>", level.bettygraceperiod);
            level.bettydamageradius = getdvarint("<dev string:x66>", level.bettydamageradius);
            level.bettydamagemax = getdvarint("<dev string:x7a>", level.bettydamagemax);
            level.bettydamagemin = getdvarint("<dev string:x8b>", level.bettydamagemin);
            level.bettydamageheight = getdvarint("<dev string:x9c>", level.bettydamageheight);
            level.bettyjumpheight = getdvarint("<dev string:xb9>", level.bettyjumpheight);
            level.bettyjumpheightwall = getdvarint("<dev string:xd4>", level.bettyjumpheightwall);
            level.bettyjumpheightwallangle = getdvarint("<dev string:xeb>", level.bettyjumpheightwallangle);
            level.bettyjumpheightwallanglecos = cos(level.bettyjumpheightwallangle);
            level.bettyjumptime = getdvarfloat("<dev string:x10a>", level.bettyjumptime);
            wait 3;
        }
    }

#/

// Namespace bouncingbetty/bouncingbetty
// Params 0, eflags: 0x0
// Checksum 0x6c92d07a, Offset: 0xa70
// Size: 0x1d0
function createbouncingbettywatcher() {
    watcher = self weaponobjects::createproximityweaponobjectwatcher("bouncingbetty", self.team);
    watcher.onspawn = &onspawnbouncingbetty;
    watcher.watchforfire = 1;
    watcher.ondetonatecallback = &bouncingbettydetonate;
    watcher.activatesound = "wpn_betty_alert";
    watcher.hackable = 1;
    watcher.hackertoolradius = level.equipmenthackertoolradius;
    watcher.hackertooltimems = level.equipmenthackertooltimems;
    watcher.ownergetsassist = 1;
    watcher.ignoredirection = 1;
    watcher.immediatedetonation = 1;
    watcher.immunespecialty = "specialty_immunetriggerbetty";
    watcher.detectionmindist = level.bettymindist;
    watcher.detectiongraceperiod = level.bettygraceperiod;
    watcher.detonateradius = level.bettyradius;
    watcher.onfizzleout = &onbouncingbettyfizzleout;
    watcher.stun = &weaponobjects::weaponstun;
    watcher.stuntime = level.bettystuntime;
    watcher.activationdelay = level.bettyactivationdelay;
}

// Namespace bouncingbetty/bouncingbetty
// Params 0, eflags: 0x0
// Checksum 0x98111bda, Offset: 0xc48
// Size: 0x7c
function onbouncingbettyfizzleout() {
    if (isdefined(self.minemover)) {
        if (isdefined(self.minemover.killcament)) {
            self.minemover.killcament delete();
        }
        self.minemover delete();
    }
    self delete();
}

// Namespace bouncingbetty/bouncingbetty
// Params 2, eflags: 0x0
// Checksum 0xed6b1fdc, Offset: 0xcd0
// Size: 0xb4
function onspawnbouncingbetty(watcher, owner) {
    weaponobjects::onspawnproximityweaponobject(watcher, owner);
    self.originalowner = owner;
    self thread spawnminemover();
    self trackonowner(owner);
    self thread trackusedstatondeath();
    self thread donotrackusedstatonpickup();
    self thread trackusedonhack();
}

// Namespace bouncingbetty/bouncingbetty
// Params 0, eflags: 0x0
// Checksum 0xec408386, Offset: 0xd90
// Size: 0x56
function trackusedstatondeath() {
    self endon(#"do_not_track_used");
    self waittill("death");
    waittillframeend();
    self.owner trackbouncingbettyasused();
    self notify(#"end_donotrackusedonpickup");
    self notify(#"end_donotrackusedonhacked");
}

// Namespace bouncingbetty/bouncingbetty
// Params 0, eflags: 0x0
// Checksum 0xdc817419, Offset: 0xdf0
// Size: 0x2a
function donotrackusedstatonpickup() {
    self endon(#"end_donotrackusedonpickup");
    self waittill("picked_up");
    self notify(#"do_not_track_used");
}

// Namespace bouncingbetty/bouncingbetty
// Params 0, eflags: 0x0
// Checksum 0x8b20f1d2, Offset: 0xe28
// Size: 0x4a
function trackusedonhack() {
    self endon(#"end_donotrackusedonhacked");
    self waittill("hacked");
    self.originalowner trackbouncingbettyasused();
    self notify(#"do_not_track_used");
}

// Namespace bouncingbetty/bouncingbetty
// Params 0, eflags: 0x0
// Checksum 0xc7bf187d, Offset: 0xe80
// Size: 0x54
function trackbouncingbettyasused() {
    if (isplayer(self)) {
        self addweaponstat(getweapon("bouncingbetty"), "used", 1);
    }
}

// Namespace bouncingbetty/bouncingbetty
// Params 1, eflags: 0x0
// Checksum 0x66ed123, Offset: 0xee0
// Size: 0x96
function trackonowner(owner) {
    if (level.trackbouncingbettiesonowner === 1) {
        if (!isdefined(owner)) {
            return;
        }
        if (!isdefined(owner.activebouncingbetties)) {
            owner.activebouncingbetties = [];
        } else {
            arrayremovevalue(owner.activebouncingbetties, undefined);
        }
        owner.activebouncingbetties[owner.activebouncingbetties.size] = self;
    }
}

// Namespace bouncingbetty/bouncingbetty
// Params 0, eflags: 0x0
// Checksum 0xd62b4fa, Offset: 0xf80
// Size: 0x284
function spawnminemover() {
    self endon(#"death");
    self util::waittillnotmoving();
    self clientfield::set("bouncingbetty_state", 2);
    self useanimtree(#bouncing_betty);
    self setanim(bouncing_betty%o_spider_mine_deploy, 1, 0, 1);
    minemover = spawn("script_model", self.origin);
    minemover.angles = self.angles;
    minemover setmodel("tag_origin");
    minemover.owner = self.owner;
    mineup = anglestoup(minemover.angles);
    z_offset = getdvarfloat("scr_bouncing_betty_killcam_offset", 18);
    minemover.killcamoffset = vectorscale(mineup, z_offset);
    minemover.weapon = self.weapon;
    minemover playsound("wpn_betty_arm");
    killcament = spawn("script_model", minemover.origin + minemover.killcamoffset);
    killcament.angles = (0, 0, 0);
    killcament setmodel("tag_origin");
    killcament setweapon(self.weapon);
    minemover.killcament = killcament;
    self.minemover = minemover;
    self thread killminemoveronpickup();
}

// Namespace bouncingbetty/bouncingbetty
// Params 0, eflags: 0x0
// Checksum 0x88e3b7f4, Offset: 0x1210
// Size: 0x44
function killminemoveronpickup() {
    self.minemover endon(#"death");
    self waittill("picked_up", "hacked");
    self killminemover();
}

// Namespace bouncingbetty/bouncingbetty
// Params 0, eflags: 0x0
// Checksum 0x702ffab1, Offset: 0x1260
// Size: 0x64
function killminemover() {
    if (isdefined(self.minemover)) {
        if (isdefined(self.minemover.killcament)) {
            self.minemover.killcament delete();
        }
        self.minemover delete();
    }
}

// Namespace bouncingbetty/bouncingbetty
// Params 3, eflags: 0x0
// Checksum 0x4c9cc8b8, Offset: 0x12d0
// Size: 0x164
function bouncingbettydetonate(attacker, weapon, target) {
    if (isdefined(weapon) && weapon.isvalid) {
        self.destroyedby = attacker;
        if (isdefined(attacker)) {
            if (self.owner util::isenemyplayer(attacker)) {
                attacker challenges::destroyedexplosive(weapon);
                scoreevents::processscoreevent("destroyed_bouncingbetty", attacker, self.owner, weapon);
            }
        }
        self bouncingbettydestroyed();
        return;
    }
    if (isdefined(self.minemover)) {
        self.minemover.ignore_team_kills = 1;
        self.minemover setmodel(self.model);
        self.minemover thread bouncingbettyjumpandexplode();
        self delete();
        return;
    }
    self bouncingbettydestroyed();
}

// Namespace bouncingbetty/bouncingbetty
// Params 0, eflags: 0x0
// Checksum 0xd448f9cd, Offset: 0x1440
// Size: 0xe4
function bouncingbettydestroyed() {
    playfx(level.bettydestroyedfx, self.origin);
    playsoundatposition("dst_equipment_destroy", self.origin);
    if (isdefined(self.trigger)) {
        self.trigger delete();
    }
    self killminemover();
    self radiusdamage(self.origin, 128, 110, 10, self.owner, "MOD_EXPLOSIVE", self.weapon);
    self delete();
}

// Namespace bouncingbetty/bouncingbetty
// Params 0, eflags: 0x0
// Checksum 0x99ac6dea, Offset: 0x1530
// Size: 0x134
function bouncingbettyjumpandexplode() {
    jumpdir = vectornormalize(anglestoup(self.angles));
    if (jumpdir[2] > level.bettyjumpheightwallanglecos) {
        jumpheight = level.bettyjumpheight;
    } else {
        jumpheight = level.bettyjumpheightwall;
    }
    explodepos = self.origin + jumpdir * jumpheight;
    self.killcament moveto(explodepos + self.killcamoffset, level.bettyjumptime, 0, level.bettyjumptime);
    self clientfield::set("bouncingbetty_state", 1);
    wait level.bettyjumptime;
    self thread mineexplode(jumpdir, explodepos);
}

// Namespace bouncingbetty/bouncingbetty
// Params 2, eflags: 0x0
// Checksum 0x633b9c86, Offset: 0x1670
// Size: 0x19c
function mineexplode(explosiondir, explodepos) {
    if (!isdefined(self) || !isdefined(self.owner)) {
        return;
    }
    self playsound("wpn_betty_explo");
    self clientfield::set("sndRattle", 1);
    waitframe(1);
    if (!isdefined(self) || !isdefined(self.owner)) {
        return;
    }
    self cylinderdamage(explosiondir * level.bettydamageheight, explodepos, level.bettydamageradius, level.bettydamageradius, level.bettydamagemax, level.bettydamagemin, self.owner, "MOD_EXPLOSIVE", self.weapon);
    self ghost();
    wait 0.1;
    if (!isdefined(self) || !isdefined(self.owner)) {
        return;
    }
    if (isdefined(self.trigger)) {
        self.trigger delete();
    }
    self.killcament delete();
    self delete();
}

