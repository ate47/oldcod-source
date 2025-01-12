#using scripts\core_common\challenges_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\scoreevents_shared;
#using scripts\core_common\util_shared;
#using scripts\weapons\weaponobjects;

#namespace bouncingbetty;

// Namespace bouncingbetty/bouncingbetty
// Params 0, eflags: 0x0
// Checksum 0xb58ae565, Offset: 0x140
// Size: 0x374
function init_shared() {
    level.bettydestroyedfx = #"weapon/fx_betty_exp_destroyed";
    level._effect[#"fx_betty_friendly_light"] = #"hash_5f76ecd582d98e38";
    level._effect[#"fx_betty_enemy_light"] = #"hash_330682ff4f12f646";
    level.bettymindist = 20;
    level.bettystuntime = 1;
    bettyexplodeanim = "o_spider_mine_detonate";
    bettydeployanim = "o_spider_mine_deploy";
    level.bettyradius = getdvarint(#"betty_detect_radius", 180);
    level.bettyactivationdelay = getdvarfloat(#"betty_activation_delay", 1);
    level.bettygraceperiod = getdvarfloat(#"betty_grace_period", 0);
    level.bettydamageradius = getdvarint(#"betty_damage_radius", 180);
    level.bettydamagemax = getdvarint(#"betty_damage_max", 180);
    level.bettydamagemin = getdvarint(#"betty_damage_min", 70);
    level.bettydamageheight = getdvarint(#"betty_damage_cylinder_height", 200);
    level.bettyjumpheight = getdvarint(#"betty_jump_height_onground", 55);
    level.bettyjumpheightwall = getdvarint(#"betty_jump_height_wall", 20);
    level.bettyjumpheightwallangle = getdvarint(#"betty_onground_angle_threshold", 30);
    level.bettyjumpheightwallanglecos = cos(level.bettyjumpheightwallangle);
    level.bettyjumptime = getdvarfloat(#"betty_jump_time", 0.7);
    level.bettybombletspawndistance = 20;
    level.bettybombletcount = 4;
    level thread register();
    /#
        level thread bouncingbettydvarupdate();
    #/
    weaponobjects::function_f298eae6(#"bouncingbetty", &createbouncingbettywatcher, 0);
}

// Namespace bouncingbetty/bouncingbetty
// Params 0, eflags: 0x0
// Checksum 0x17d46291, Offset: 0x4c0
// Size: 0x64
function register() {
    clientfield::register("missile", "bouncingbetty_state", 1, 2, "int");
    clientfield::register("scriptmover", "bouncingbetty_state", 1, 2, "int");
}

/#

    // Namespace bouncingbetty/bouncingbetty
    // Params 0, eflags: 0x0
    // Checksum 0x2472c807, Offset: 0x530
    // Size: 0x2a0
    function bouncingbettydvarupdate() {
        for (;;) {
            level.bettyradius = getdvarint(#"betty_detect_radius", level.bettyradius);
            level.bettyactivationdelay = getdvarfloat(#"betty_activation_delay", level.bettyactivationdelay);
            level.bettygraceperiod = getdvarfloat(#"betty_grace_period", level.bettygraceperiod);
            level.bettydamageradius = getdvarint(#"betty_damage_radius", level.bettydamageradius);
            level.bettydamagemax = getdvarint(#"betty_damage_max", level.bettydamagemax);
            level.bettydamagemin = getdvarint(#"betty_damage_min", level.bettydamagemin);
            level.bettydamageheight = getdvarint(#"betty_damage_cylinder_height", level.bettydamageheight);
            level.bettyjumpheight = getdvarint(#"betty_jump_height_onground", level.bettyjumpheight);
            level.bettyjumpheightwall = getdvarint(#"betty_jump_height_wall", level.bettyjumpheightwall);
            level.bettyjumpheightwallangle = getdvarint(#"betty_onground_angle_threshold", level.bettyjumpheightwallangle);
            level.bettyjumpheightwallanglecos = cos(level.bettyjumpheightwallangle);
            level.bettyjumptime = getdvarfloat(#"betty_jump_time", level.bettyjumptime);
            wait 3;
        }
    }

#/

// Namespace bouncingbetty/bouncingbetty
// Params 1, eflags: 0x0
// Checksum 0x7b1d4ea2, Offset: 0x7d8
// Size: 0x176
function createbouncingbettywatcher(watcher) {
    watcher.onspawn = &onspawnbouncingbetty;
    watcher.watchforfire = 1;
    watcher.ondetonatecallback = &bouncingbettydetonate;
    watcher.activatesound = #"wpn_betty_alert";
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
// Checksum 0x299ca27, Offset: 0x958
// Size: 0x74
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
// Checksum 0xf610208b, Offset: 0x9d8
// Size: 0xac
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
// Checksum 0x20f3e0f9, Offset: 0xa90
// Size: 0x66
function trackusedstatondeath() {
    self endon(#"do_not_track_used");
    self waittill(#"death");
    waittillframeend();
    self.owner trackbouncingbettyasused();
    self notify(#"end_donotrackusedonpickup");
    self notify(#"end_donotrackusedonhacked");
}

// Namespace bouncingbetty/bouncingbetty
// Params 0, eflags: 0x0
// Checksum 0x20e14c2c, Offset: 0xb00
// Size: 0x3e
function donotrackusedstatonpickup() {
    self endon(#"end_donotrackusedonpickup");
    self waittill(#"picked_up");
    self notify(#"do_not_track_used");
}

// Namespace bouncingbetty/bouncingbetty
// Params 0, eflags: 0x0
// Checksum 0xf0b1bb3b, Offset: 0xb48
// Size: 0x56
function trackusedonhack() {
    self endon(#"end_donotrackusedonhacked");
    self waittill(#"hacked");
    self.originalowner trackbouncingbettyasused();
    self notify(#"do_not_track_used");
}

// Namespace bouncingbetty/bouncingbetty
// Params 0, eflags: 0x0
// Checksum 0x9bc40505, Offset: 0xba8
// Size: 0x64
function trackbouncingbettyasused() {
    if (isplayer(self)) {
        self stats::function_4f10b697(getweapon(#"bouncingbetty"), #"used", 1);
    }
}

// Namespace bouncingbetty/bouncingbetty
// Params 1, eflags: 0x0
// Checksum 0xb2ebc64b, Offset: 0xc18
// Size: 0x8a
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
// Checksum 0xee21841e, Offset: 0xcb0
// Size: 0x29c
function spawnminemover() {
    self endon(#"death");
    self util::waittillnotmoving();
    self clientfield::set("bouncingbetty_state", 2);
    self useanimtree("generic");
    self setanim(#"o_spider_mine_deploy", 1, 0, 1);
    minemover = spawn("script_model", self.origin);
    minemover.angles = self.angles;
    minemover setmodel(#"tag_origin");
    minemover.owner = self.owner;
    mineup = anglestoup(minemover.angles);
    z_offset = getdvarfloat(#"scr_bouncing_betty_killcam_offset", 18);
    minemover enablelinkto();
    minemover linkto(self);
    minemover.killcamoffset = vectorscale(mineup, z_offset);
    minemover.weapon = self.weapon;
    minemover playsound(#"wpn_betty_arm");
    killcament = spawn("script_model", minemover.origin + minemover.killcamoffset);
    killcament.angles = (0, 0, 0);
    killcament setmodel(#"tag_origin");
    killcament setweapon(self.weapon);
    minemover.killcament = killcament;
    self.minemover = minemover;
    self thread killminemoveronpickup();
}

// Namespace bouncingbetty/bouncingbetty
// Params 0, eflags: 0x0
// Checksum 0xd2c295b6, Offset: 0xf58
// Size: 0x54
function killminemoveronpickup() {
    self.minemover endon(#"death");
    self waittill(#"picked_up", #"hacked");
    self killminemover();
}

// Namespace bouncingbetty/bouncingbetty
// Params 0, eflags: 0x0
// Checksum 0xe5f5bf81, Offset: 0xfb8
// Size: 0x5c
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
// Checksum 0x828e37cf, Offset: 0x1020
// Size: 0x14c
function bouncingbettydetonate(attacker, weapon, target) {
    if (isdefined(weapon) && weapon.isvalid) {
        self.destroyedby = attacker;
        if (isdefined(attacker)) {
            if (self.owner util::isenemyplayer(attacker)) {
                attacker challenges::destroyedexplosive(weapon);
                scoreevents::processscoreevent(#"destroyed_bouncingbetty", attacker, self.owner, weapon);
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
// Checksum 0xb5f11e61, Offset: 0x1178
// Size: 0xe4
function bouncingbettydestroyed() {
    playfx(level.bettydestroyedfx, self.origin);
    playsoundatposition(#"dst_equipment_destroy", self.origin);
    if (isdefined(self.trigger)) {
        self.trigger delete();
    }
    self killminemover();
    self radiusdamage(self.origin, 128, 110, 10, self.owner, "MOD_EXPLOSIVE", self.weapon);
    self delete();
}

// Namespace bouncingbetty/bouncingbetty
// Params 0, eflags: 0x0
// Checksum 0xe1a0452d, Offset: 0x1268
// Size: 0x114
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
// Checksum 0x306577f1, Offset: 0x1388
// Size: 0x18c
function mineexplode(explosiondir, explodepos) {
    if (!isdefined(self) || !isdefined(self.owner)) {
        return;
    }
    self playsound(#"wpn_betty_explo");
    self clientfield::increment("sndRattle", 1);
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

