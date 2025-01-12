#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\challenges_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\scoreevents_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\weapons\weaponobjects;

#namespace electroball_grenade;

// Namespace electroball_grenade/electroball_grenade
// Params 0, eflags: 0x6
// Checksum 0x9b94ad48, Offset: 0x220
// Size: 0x34
function private autoexec __init__system__() {
    system::register("electroball_grenade", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace electroball_grenade/electroball_grenade
// Params 0, eflags: 0x1 linked
// Checksum 0xc6b80a8d, Offset: 0x260
// Size: 0x21c
function function_70a657d8() {
    level.proximitygrenadedetectionradius = getdvarint(#"scr_proximitygrenadedetectionradius", 180);
    level.proximitygrenadegraceperiod = getdvarfloat(#"scr_proximitygrenadegraceperiod", 0.05);
    level.proximitygrenadedotdamageamount = getdvarint(#"scr_proximitygrenadedotdamageamount", 1);
    level.proximitygrenadedotdamageamounthardcore = getdvarint(#"scr_proximitygrenadedotdamageamounthardcore", 1);
    level.proximitygrenadedotdamagetime = getdvarfloat(#"scr_proximitygrenadedotdamagetime", 0.2);
    level.proximitygrenadedotdamageinstances = getdvarint(#"scr_proximitygrenadedotdamageinstances", 4);
    level.proximitygrenadeactivationtime = getdvarfloat(#"scr_proximitygrenadeactivationtime", 0.1);
    level.proximitygrenadeprotectedtime = getdvarfloat(#"scr_proximitygrenadeprotectedtime", 0.45);
    level thread register();
    if (!isdefined(level.spawnprotectiontimems)) {
        level.spawnprotectiontimems = 0;
    }
    callback::on_spawned(&on_player_spawned);
    callback::on_ai_spawned(&on_ai_spawned);
    callback::on_grenade_fired(&begin_other_grenade_tracking);
}

// Namespace electroball_grenade/electroball_grenade
// Params 0, eflags: 0x1 linked
// Checksum 0xd55b40e8, Offset: 0x488
// Size: 0xc4
function register() {
    clientfield::register("toplayer", "electroball_tazered", 1, 1, "int");
    clientfield::register("missile", "electroball_stop_trail", 1, 1, "int");
    clientfield::register("missile", "electroball_play_landed_fx", 1, 1, "int");
    clientfield::register("allplayers", "electroball_shock", 1, 1, "int");
}

// Namespace electroball_grenade/electroball_grenade
// Params 0, eflags: 0x1 linked
// Checksum 0x64a9fbb2, Offset: 0x558
// Size: 0x13a
function function_5d95c1d() {
    watcher = self weaponobjects::createwatcher("electroball_grenade", undefined, 0);
    watcher.watchforfire = 1;
    watcher.hackable = 0;
    watcher.hackertoolradius = level.equipmenthackertoolradius;
    watcher.hackertooltimems = level.equipmenthackertooltimems;
    watcher.headicon = 0;
    watcher.activatefx = 1;
    watcher.ownergetsassist = 1;
    watcher.ignoredirection = 1;
    watcher.immediatedetonation = 1;
    watcher.detectiongraceperiod = 0.05;
    watcher.detonateradius = 64;
    watcher.onstun = &weaponobjects::weaponstun;
    watcher.stuntime = 1;
    watcher.ondetonatecallback = &proximitydetonate;
    watcher.activationdelay = 0.05;
    watcher.activatesound = "wpn_claymore_alert";
    watcher.immunespecialty = "specialty_immunetriggershock";
    watcher.onspawn = &function_5aeaf7bc;
}

// Namespace electroball_grenade/electroball_grenade
// Params 2, eflags: 0x1 linked
// Checksum 0x863b2e04, Offset: 0x6a0
// Size: 0xd4
function function_5aeaf7bc(watcher, owner) {
    self thread setupkillcament();
    if (isplayer(owner)) {
        owner addweaponstat(self.weapon, "used", 1);
    }
    if (isdefined(self.weapon) && self.weapon.proximitydetonation > 0) {
        watcher.detonateradius = self.weapon.proximitydetonation;
    }
    weaponobjects::onspawnproximityweaponobject(watcher, owner);
    self thread function_8e671a22();
}

// Namespace electroball_grenade/electroball_grenade
// Params 0, eflags: 0x1 linked
// Checksum 0xe280cc53, Offset: 0x780
// Size: 0x74
function setupkillcament() {
    self endon(#"death");
    self util::waittillnotmoving();
    self.killcament = spawn("script_model", self.origin + (0, 0, 8));
    self thread cleanupkillcamentondeath();
}

// Namespace electroball_grenade/electroball_grenade
// Params 0, eflags: 0x1 linked
// Checksum 0x881d772c, Offset: 0x800
// Size: 0x4c
function cleanupkillcamentondeath() {
    self waittill(#"death");
    self.killcament util::deleteaftertime(4 + level.proximitygrenadedotdamagetime * level.proximitygrenadedotdamageinstances);
}

// Namespace electroball_grenade/electroball_grenade
// Params 3, eflags: 0x1 linked
// Checksum 0x1b77f6a7, Offset: 0x858
// Size: 0x34
function proximitydetonate(attacker, weapon, *target) {
    weaponobjects::weapondetonate(weapon, target);
}

// Namespace electroball_grenade/electroball_grenade
// Params 1, eflags: 0x1 linked
// Checksum 0xa957e00d, Offset: 0x898
// Size: 0x112
function watchproximitygrenadehitplayer(owner) {
    self endon(#"death");
    self setteam(owner.team);
    while (true) {
        waitresult = self waittill(#"grenade_bounce");
        if (isdefined(waitresult.ent) && isplayer(waitresult.ent) && waitresult.surface != "riotshield") {
            if (level.teambased && waitresult.ent.team == self.owner.team) {
                continue;
            }
            self proximitydetonate(self.owner, self.weapon);
            return;
        }
    }
}

// Namespace electroball_grenade/electroball_grenade
// Params 2, eflags: 0x0
// Checksum 0x32035e2, Offset: 0x9b8
// Size: 0x126
function performhudeffects(position, *distancetogrenade) {
    forwardvec = vectornormalize(anglestoforward(self.angles));
    rightvec = vectornormalize(anglestoright(self.angles));
    explosionvec = vectornormalize(distancetogrenade - self.origin);
    fdot = vectordot(explosionvec, forwardvec);
    rdot = vectordot(explosionvec, rightvec);
    fangle = acos(fdot);
    rangle = acos(rdot);
}

// Namespace electroball_grenade/electroball_grenade
// Params 1, eflags: 0x1 linked
// Checksum 0x2c9e039c, Offset: 0xae8
// Size: 0x74
function function_4e48c752(params) {
    self endon(#"death");
    if (isdefined(params.weapon) && params.weapon.name == "electroball_grenade") {
        self damageplayerinradius(params.eattacker);
    }
}

// Namespace electroball_grenade/electroball_grenade
// Params 1, eflags: 0x1 linked
// Checksum 0x3ca18299, Offset: 0xb68
// Size: 0x1c4
function damageplayerinradius(attacker) {
    self notify(#"proximitygrenadedamagestart");
    self endon(#"proximitygrenadedamagestart", #"death");
    attacker endon(#"disconnect");
    self clientfield::set("electroball_shock", 1);
    g_time = gettime();
    if (self util::mayapplyscreeneffect()) {
        self.lastshockedby = attacker;
        self.shockendtime = gettime() + 100;
        self shellshock("electrocution", 0.1);
        self clientfield::set_to_player("electroball_tazered", 1);
    }
    self playrumbleonentity("proximity_grenade");
    self playsound("wpn_taser_mine_zap");
    if (!self hasperk("specialty_proximityprotection")) {
        self thread watch_death();
        if (gettime() - g_time < 100) {
            wait (gettime() - g_time) / 1000;
        }
    } else {
        wait level.proximitygrenadeprotectedtime;
    }
    self clientfield::set_to_player("electroball_tazered", 0);
}

// Namespace electroball_grenade/electroball_grenade
// Params 0, eflags: 0x1 linked
// Checksum 0x45341597, Offset: 0xd38
// Size: 0xa4
function watch_death() {
    self endon(#"disconnect");
    self notify(#"proximity_cleanup");
    self endon(#"proximity_cleanup");
    self waittill(#"death");
    self stoprumble("proximity_grenade");
    self setblur(0, 0);
    self clientfield::set_to_player("electroball_tazered", 0);
}

// Namespace electroball_grenade/electroball_grenade
// Params 0, eflags: 0x1 linked
// Checksum 0xa9bd2d1b, Offset: 0xde8
// Size: 0x54
function on_player_spawned() {
    if (isplayer(self)) {
        self thread function_5d95c1d();
        self callback::on_player_damage(&function_4e48c752);
    }
}

// Namespace electroball_grenade/electroball_grenade
// Params 0, eflags: 0x1 linked
// Checksum 0xe4228744, Offset: 0xe48
// Size: 0x2c
function on_ai_spawned() {
    if (self.archetype === "mechz") {
        self thread function_5d95c1d();
    }
}

// Namespace electroball_grenade/electroball_grenade
// Params 1, eflags: 0x1 linked
// Checksum 0xcec9fcdb, Offset: 0xe80
// Size: 0x7c
function begin_other_grenade_tracking(params) {
    if (isdefined(params.weapon) && isdefined(params.weapon.rootweapon) && params.weapon.rootweapon.name == #"electroball_grenade") {
        params.projectile thread watchproximitygrenadehitplayer(self);
    }
}

// Namespace electroball_grenade/electroball_grenade
// Params 0, eflags: 0x1 linked
// Checksum 0x9ebdb655, Offset: 0xf08
// Size: 0xf4
function function_8e671a22() {
    self endon(#"death", #"disconnect", #"delete");
    self waittill(#"grenade_bounce", #"stationary");
    self clientfield::set("electroball_stop_trail", 1);
    self setmodel("tag_origin");
    self clientfield::set("electroball_play_landed_fx", 1);
    if (!isdefined(level.var_542ac835)) {
        level.var_542ac835 = [];
    }
    array::add(level.var_542ac835, self);
}

