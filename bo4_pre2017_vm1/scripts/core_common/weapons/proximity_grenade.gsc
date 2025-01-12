#using scripts/core_common/callbacks_shared;
#using scripts/core_common/challenges_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/scoreevents_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;
#using scripts/core_common/values_shared;
#using scripts/core_common/weapons/weaponobjects;

#namespace proximity_grenade;

// Namespace proximity_grenade/proximity_grenade
// Params 0, eflags: 0x0
// Checksum 0xac8686b8, Offset: 0x680
// Size: 0x364
function init_shared() {
    level._effect["prox_grenade_friendly_default"] = "weapon/fx_prox_grenade_scan_blue";
    level._effect["prox_grenade_friendly_warning"] = "weapon/fx_prox_grenade_wrn_grn";
    level._effect["prox_grenade_enemy_default"] = "weapon/fx_prox_grenade_scan_orng";
    level._effect["prox_grenade_enemy_warning"] = "weapon/fx_prox_grenade_wrn_red";
    level._effect["prox_grenade_player_shock"] = "weapon/fx_prox_grenade_impact_player_spwner";
    level._effect["prox_grenade_chain_bolt"] = "weapon/fx_prox_grenade_elec_jump";
    level.proximitygrenadedetectionradius = getdvarint("scr_proximityGrenadeDetectionRadius", 180);
    level.proximitygrenadeduration = getdvarfloat("scr_proximityGrenadeDuration", 1.2);
    level.proximitygrenadegraceperiod = getdvarfloat("scr_proximityGrenadeGracePeriod", 0.05);
    level.proximitygrenadedotdamageamount = getdvarint("scr_proximityGrenadeDOTDamageAmount", 1);
    level.proximitygrenadedotdamageamounthardcore = getdvarint("scr_proximityGrenadeDOTDamageAmountHardcore", 1);
    level.proximitygrenadedotdamagetime = getdvarfloat("scr_proximityGrenadeDOTDamageTime", 0.2);
    level.proximitygrenadedotdamageinstances = getdvarint("scr_proximityGrenadeDOTDamageInstances", 4);
    level.proximitygrenadeactivationtime = getdvarfloat("scr_proximityGrenadeActivationTime", 0.1);
    level.proximitychaindebug = getdvarint("scr_proximityChainDebug", 0);
    level.proximitychaingraceperiod = getdvarint("scr_proximityChainGracePeriod", 2500);
    level.proximitychainboltspeed = getdvarfloat("scr_proximityChainBoltSpeed", 400);
    level.proximitygrenadeprotectedtime = getdvarfloat("scr_proximityGrenadeProtectedTime", 0.45);
    level.poisonfxduration = 6;
    level thread register();
    callback::on_spawned(&on_player_spawned);
    callback::add_weapon_damage(getweapon("proximity_grenade"), &on_damage);
    /#
        level thread updatedvars();
    #/
}

// Namespace proximity_grenade/proximity_grenade
// Params 0, eflags: 0x0
// Checksum 0xa6028d27, Offset: 0x9f0
// Size: 0x34
function register() {
    clientfield::register("toplayer", "tazered", 1, 1, "int");
}

// Namespace proximity_grenade/proximity_grenade
// Params 0, eflags: 0x0
// Checksum 0x2b40b0b7, Offset: 0xa30
// Size: 0x25c
function updatedvars() {
    while (true) {
        level.proximitygrenadedetectionradius = getdvarint("scr_proximityGrenadeDetectionRadius", level.proximitygrenadedetectionradius);
        level.proximitygrenadeduration = getdvarfloat("scr_proximityGrenadeDuration", 1.5);
        level.proximitygrenadegraceperiod = getdvarfloat("scr_proximityGrenadeGracePeriod", level.proximitygrenadegraceperiod);
        level.proximitygrenadedotdamageamount = getdvarint("scr_proximityGrenadeDOTDamageAmount", level.proximitygrenadedotdamageamount);
        level.proximitygrenadedotdamageamounthardcore = getdvarint("scr_proximityGrenadeDOTDamageAmountHardcore", level.proximitygrenadedotdamageamounthardcore);
        level.proximitygrenadedotdamagetime = getdvarfloat("scr_proximityGrenadeDOTDamageTime", level.proximitygrenadedotdamagetime);
        level.proximitygrenadedotdamageinstances = getdvarint("scr_proximityGrenadeDOTDamageInstances", level.proximitygrenadedotdamageinstances);
        level.proximitygrenadeactivationtime = getdvarfloat("scr_proximityGrenadeActivationTime", level.proximitygrenadeactivationtime);
        level.proximitychaindebug = getdvarint("scr_proximityChainDebug", level.proximitychaindebug);
        level.proximitychaingraceperiod = getdvarint("scr_proximityChainGracePeriod", level.proximitychaingraceperiod);
        level.proximitychainboltspeed = getdvarfloat("scr_proximityChainBoltSpeed", level.proximitychainboltspeed);
        level.proximitygrenadeprotectedtime = getdvarfloat("scr_proximityGrenadeProtectedTime", level.proximitygrenadeprotectedtime);
        wait 1;
    }
}

// Namespace proximity_grenade/proximity_grenade
// Params 0, eflags: 0x0
// Checksum 0xbcd76885, Offset: 0xc98
// Size: 0x1c0
function createproximitygrenadewatcher() {
    watcher = self weaponobjects::createproximityweaponobjectwatcher("proximity_grenade", self.team);
    watcher.watchforfire = 1;
    watcher.hackable = 1;
    watcher.hackertoolradius = level.equipmenthackertoolradius;
    watcher.hackertooltimems = level.equipmenthackertooltimems;
    watcher.headicon = 0;
    watcher.activatefx = 1;
    watcher.ownergetsassist = 1;
    watcher.ignoredirection = 1;
    watcher.immediatedetonation = 1;
    watcher.detectiongraceperiod = level.proximitygrenadegraceperiod;
    watcher.detonateradius = level.proximitygrenadedetectionradius;
    watcher.onstun = &weaponobjects::weaponstun;
    watcher.stuntime = 1;
    watcher.ondetonatecallback = &proximitydetonate;
    watcher.activationdelay = level.proximitygrenadeactivationtime;
    watcher.activatesound = "wpn_claymore_alert";
    watcher.immunespecialty = "specialty_immunetriggershock";
    watcher.onspawn = &onspawnproximitygrenadeweaponobject;
}

// Namespace proximity_grenade/proximity_grenade
// Params 0, eflags: 0x0
// Checksum 0x1a6468b8, Offset: 0xe60
// Size: 0x1b0
function creategadgetproximitygrenadewatcher() {
    watcher = self weaponobjects::createproximityweaponobjectwatcher("gadget_sticky_proximity", self.team);
    watcher.watchforfire = 1;
    watcher.hackable = 1;
    watcher.hackertoolradius = level.equipmenthackertoolradius;
    watcher.hackertooltimems = level.equipmenthackertooltimems;
    watcher.headicon = 0;
    watcher.activatefx = 1;
    watcher.ownergetsassist = 1;
    watcher.ignoredirection = 1;
    watcher.immediatedetonation = 1;
    watcher.detectiongraceperiod = level.proximitygrenadegraceperiod;
    watcher.detonateradius = level.proximitygrenadedetectionradius;
    watcher.onstun = &weaponobjects::weaponstun;
    watcher.stuntime = 1;
    watcher.ondetonatecallback = &proximitydetonate;
    watcher.activationdelay = level.proximitygrenadeactivationtime;
    watcher.activatesound = "wpn_claymore_alert";
    watcher.onspawn = &onspawnproximitygrenadeweaponobject;
}

// Namespace proximity_grenade/proximity_grenade
// Params 2, eflags: 0x0
// Checksum 0xbea663ee, Offset: 0x1018
// Size: 0xd4
function onspawnproximitygrenadeweaponobject(watcher, owner) {
    self thread setupkillcament();
    owner addweaponstat(self.weapon, "used", 1);
    if (isdefined(self.weapon) && self.weapon.proximitydetonation > 0) {
        watcher.detonateradius = self.weapon.proximitydetonation;
    }
    weaponobjects::onspawnproximityweaponobject(watcher, owner);
    self trackonowner(self.owner);
}

// Namespace proximity_grenade/proximity_grenade
// Params 1, eflags: 0x0
// Checksum 0xa0461bf2, Offset: 0x10f8
// Size: 0x96
function trackonowner(owner) {
    if (level.trackproximitygrenadesonowner === 1) {
        if (!isdefined(owner)) {
            return;
        }
        if (!isdefined(owner.activeproximitygrenades)) {
            owner.activeproximitygrenades = [];
        } else {
            arrayremovevalue(owner.activeproximitygrenades, undefined);
        }
        owner.activeproximitygrenades[owner.activeproximitygrenades.size] = self;
    }
}

// Namespace proximity_grenade/proximity_grenade
// Params 0, eflags: 0x0
// Checksum 0x6936160a, Offset: 0x1198
// Size: 0x74
function setupkillcament() {
    self endon(#"death");
    self util::waittillnotmoving();
    self.killcament = spawn("script_model", self.origin + (0, 0, 8));
    self thread cleanupkillcamentondeath();
}

// Namespace proximity_grenade/proximity_grenade
// Params 0, eflags: 0x0
// Checksum 0x723a1da0, Offset: 0x1218
// Size: 0x4c
function cleanupkillcamentondeath() {
    self waittill("death");
    self.killcament util::deleteaftertime(4 + level.proximitygrenadedotdamagetime * level.proximitygrenadedotdamageinstances);
}

// Namespace proximity_grenade/proximity_grenade
// Params 3, eflags: 0x0
// Checksum 0xd1eb17f9, Offset: 0x1270
// Size: 0xbc
function proximitydetonate(attacker, weapon, target) {
    if (isdefined(weapon) && weapon.isvalid) {
        if (isdefined(attacker)) {
            if (self.owner util::isenemyplayer(attacker)) {
                attacker challenges::destroyedexplosive(weapon);
                scoreevents::processscoreevent("destroyed_proxy", attacker, self.owner, weapon);
            }
        }
    }
    weaponobjects::weapondetonate(attacker, weapon);
}

// Namespace proximity_grenade/proximity_grenade
// Params 7, eflags: 0x0
// Checksum 0xdb46ad73, Offset: 0x1338
// Size: 0xcc
function proximitygrenadedamageplayer(eattacker, einflictor, killcament, weapon, meansofdeath, damage, proximitychain) {
    self thread damageplayerinradius(einflictor.origin, eattacker, killcament);
    if (weapon.chaineventradius > 0 && !self hasperk("specialty_proximityprotection")) {
        self thread proximitygrenadechain(eattacker, einflictor, killcament, weapon, meansofdeath, damage, proximitychain, 0);
    }
}

// Namespace proximity_grenade/proximity_grenade
// Params 0, eflags: 0x0
// Checksum 0x7cf97b40, Offset: 0x1410
// Size: 0xf2
function getproximitychain() {
    if (!isdefined(level.proximitychains)) {
        level.proximitychains = [];
    }
    foreach (chain in level.proximitychains) {
        if (!chainisactive(chain)) {
            return chain;
        }
    }
    chain = spawnstruct();
    level.proximitychains[level.proximitychains.size] = chain;
    return chain;
}

// Namespace proximity_grenade/proximity_grenade
// Params 1, eflags: 0x0
// Checksum 0xdef48616, Offset: 0x1510
// Size: 0x3e
function chainisactive(chain) {
    if (isdefined(chain.activeendtime) && chain.activeendtime > gettime()) {
        return true;
    }
    return false;
}

// Namespace proximity_grenade/proximity_grenade
// Params 0, eflags: 0x0
// Checksum 0x1b80f5fc, Offset: 0x1558
// Size: 0xfc
function cleanupproximitychainent() {
    self.cleanup = 1;
    any_active = 1;
    while (any_active) {
        wait 1;
        if (!isdefined(self)) {
            return;
        }
        any_active = 0;
        foreach (proximitychain in self.chains) {
            if (proximitychain.activeendtime > gettime()) {
                any_active = 1;
                break;
            }
        }
    }
    if (isdefined(self)) {
        self delete();
    }
}

// Namespace proximity_grenade/proximity_grenade
// Params 1, eflags: 0x0
// Checksum 0xe33f3763, Offset: 0x1660
// Size: 0x42
function isinchain(player) {
    player_num = player getentitynumber();
    return isdefined(self.chain_players[player_num]);
}

// Namespace proximity_grenade/proximity_grenade
// Params 1, eflags: 0x0
// Checksum 0x44f2a772, Offset: 0x16b0
// Size: 0x46
function addplayertochain(player) {
    player_num = player getentitynumber();
    self.chain_players[player_num] = player;
}

// Namespace proximity_grenade/proximity_grenade
// Params 8, eflags: 0x0
// Checksum 0x624cb404, Offset: 0x1700
// Size: 0x4cc
function proximitygrenadechain(eattacker, einflictor, killcament, weapon, meansofdeath, damage, proximitychain, delay) {
    self endon(#"disconnect");
    self endon(#"death");
    eattacker endon(#"disconnect");
    if (!isdefined(proximitychain)) {
        proximitychain = getproximitychain();
        proximitychain.chaineventnum = 0;
        if (!isdefined(einflictor.proximitychainent)) {
            einflictor.proximitychainent = spawn("script_origin", self.origin);
            einflictor.proximitychainent.chains = [];
            einflictor.proximitychainent.chain_players = [];
        }
        proximitychain.proximitychainent = einflictor.proximitychainent;
        proximitychain.proximitychainent.chains[proximitychain.proximitychainent.chains.size] = proximitychain;
    }
    proximitychain.chaineventnum += 1;
    if (proximitychain.chaineventnum >= weapon.chaineventmax) {
        return;
    }
    chaineventradiussq = weapon.chaineventradius * weapon.chaineventradius;
    endtime = gettime() + weapon.chaineventtime;
    proximitychain.proximitychainent addplayertochain(self);
    proximitychain.activeendtime = endtime + delay * 1000 + level.proximitychaingraceperiod;
    if (delay > 0) {
        wait delay;
    }
    if (!isdefined(proximitychain.proximitychainent.cleanup)) {
        proximitychain.proximitychainent thread cleanupproximitychainent();
    }
    while (true) {
        currenttime = gettime();
        if (endtime < currenttime) {
            return;
        }
        closestplayers = arraysort(level.players, self.origin, 1);
        foreach (player in closestplayers) {
            waitframe(1);
            if (proximitychain.chaineventnum >= weapon.chaineventmax) {
                return;
            }
            if (!isdefined(player) || !isalive(player) || player == self) {
                continue;
            }
            if (player.sessionstate != "playing") {
                continue;
            }
            distancesq = distancesquared(player.origin, self.origin);
            if (distancesq > chaineventradiussq) {
                break;
            }
            if (proximitychain.proximitychainent isinchain(player)) {
                continue;
            }
            if (level.proximitychaindebug || weaponobjects::friendlyfirecheck(eattacker, player)) {
                if (level.proximitychaindebug || !player hasperk("specialty_proximityprotection")) {
                    self thread chainplayer(eattacker, killcament, weapon, meansofdeath, damage, proximitychain, player, distancesq);
                }
            }
        }
        waitframe(1);
    }
}

// Namespace proximity_grenade/proximity_grenade
// Params 8, eflags: 0x0
// Checksum 0x209f321e, Offset: 0x1bd8
// Size: 0x1dc
function chainplayer(eattacker, killcament, weapon, meansofdeath, damage, proximitychain, player, distancesq) {
    waittime = 0.25;
    speedsq = level.proximitychainboltspeed * level.proximitychainboltspeed;
    if (speedsq > 100 && distancesq > 1) {
        waittime = distancesq / speedsq;
    }
    player thread proximitygrenadechain(eattacker, self, killcament, weapon, meansofdeath, damage, proximitychain, waittime);
    waitframe(1);
    if (level.proximitychaindebug) {
        /#
            color = (1, 1, 1);
            alpha = 1;
            depth = 0;
            time = 200;
            util::debug_line(self.origin + (0, 0, 50), player.origin + (0, 0, 50), color, alpha, depth, time);
        #/
    }
    self tesla_play_arc_fx(player, waittime);
    player thread damageplayerinradius(self.origin, eattacker, killcament);
}

// Namespace proximity_grenade/proximity_grenade
// Params 2, eflags: 0x0
// Checksum 0xbdf69f76, Offset: 0x1dc0
// Size: 0x1cc
function tesla_play_arc_fx(target, waittime) {
    if (!isdefined(self) || !isdefined(target)) {
        return;
    }
    tag = "J_SpineUpper";
    target_tag = "J_SpineUpper";
    origin = self gettagorigin(tag);
    target_origin = target gettagorigin(target_tag);
    distance_squared = 16384;
    if (distancesquared(origin, target_origin) < distance_squared) {
        return;
    }
    fxorg = spawn("script_model", origin);
    fxorg setmodel("tag_origin");
    fx = playfxontag(level._effect["prox_grenade_chain_bolt"], fxorg, "tag_origin");
    playsoundatposition("wpn_tesla_bounce", fxorg.origin);
    fxorg moveto(target_origin, waittime);
    fxorg waittill("movedone");
    fxorg delete();
}

/#

    // Namespace proximity_grenade/proximity_grenade
    // Params 0, eflags: 0x0
    // Checksum 0x82807f7f, Offset: 0x1f98
    // Size: 0x44
    function debugchainsphere() {
        util::debug_sphere(self.origin + (0, 0, 50), 20, (1, 1, 1), 1, 0);
    }

#/

// Namespace proximity_grenade/proximity_grenade
// Params 1, eflags: 0x0
// Checksum 0x81701e27, Offset: 0x1fe8
// Size: 0x142
function watchproximitygrenadehitplayer(owner) {
    self endon(#"death");
    self setowner(owner);
    self setteam(owner.team);
    while (true) {
        waitresult = self waittill("grenade_bounce");
        ent = waitresult.entity;
        surface = waitresult.stype;
        if (isdefined(ent) && isplayer(ent) && surface != "riotshield") {
            if (level.teambased && ent.team == self.owner.team) {
                continue;
            }
            self proximitydetonate(self.owner, self.weapon);
            return;
        }
    }
}

// Namespace proximity_grenade/proximity_grenade
// Params 2, eflags: 0x0
// Checksum 0x82888372, Offset: 0x2138
// Size: 0x148
function performhudeffects(position, distancetogrenade) {
    forwardvec = vectornormalize(anglestoforward(self.angles));
    rightvec = vectornormalize(anglestoright(self.angles));
    explosionvec = vectornormalize(position - self.origin);
    fdot = vectordot(explosionvec, forwardvec);
    rdot = vectordot(explosionvec, rightvec);
    fangle = acos(fdot);
    rangle = acos(rdot);
}

// Namespace proximity_grenade/proximity_grenade
// Params 3, eflags: 0x0
// Checksum 0xbee7aada, Offset: 0x2288
// Size: 0x45c
function damageplayerinradius(position, eattacker, killcament) {
    self notify(#"proximitygrenadedamagestart");
    self endon(#"proximitygrenadedamagestart");
    self endon(#"disconnect");
    self endon(#"death");
    eattacker endon(#"disconnect");
    playfxontag(level._effect["prox_grenade_player_shock"], self, "J_SpineUpper");
    g_time = gettime();
    if (self util::mayapplyscreeneffect()) {
        if (!self hasperk("specialty_proximityprotection")) {
            self.lastshockedby = eattacker;
            self.shockendtime = gettime() + level.proximitygrenadeduration * 1000;
            self shellshock("proximity_grenade", level.proximitygrenadeduration, 0);
        }
        self clientfield::set_to_player("tazered", 1);
    }
    self playrumbleonentity("proximity_grenade");
    self playsound("wpn_taser_mine_zap");
    if (!self hasperk("specialty_proximityprotection")) {
        self thread watch_death();
        if (!isdefined(killcament)) {
            killcament = spawn("script_model", position + (0, 0, 8));
        }
        killcament.soundmod = "taser_spike";
        killcament util::deleteaftertime(3 + level.proximitygrenadedotdamagetime * level.proximitygrenadedotdamageinstances);
        self val::set("grenade_damage", "show_hud", 0);
        damage = level.proximitygrenadedotdamageamount;
        if (level.hardcoremode) {
            damage = level.proximitygrenadedotdamageamounthardcore;
        }
        for (i = 0; i < level.proximitygrenadedotdamageinstances; i++) {
            assert(isdefined(eattacker));
            if (!isdefined(killcament)) {
                killcament = spawn("script_model", position + (0, 0, 8));
                killcament.soundmod = "taser_spike";
                killcament util::deleteaftertime(3 + level.proximitygrenadedotdamagetime * (level.proximitygrenadedotdamageinstances - i));
            }
            self dodamage(damage, position, eattacker, killcament, "none", "MOD_GAS", 0, getweapon("proximity_grenade_aoe"));
            wait level.proximitygrenadedotdamagetime;
        }
        if (gettime() - g_time < level.proximitygrenadeduration * 1000) {
            wait (gettime() - g_time) / 1000;
        }
        self val::reset("grenade_damage", "show_hud");
    } else {
        wait level.proximitygrenadeprotectedtime;
    }
    self clientfield::set_to_player("tazered", 0);
}

// Namespace proximity_grenade/proximity_grenade
// Params 1, eflags: 0x0
// Checksum 0x81b968a, Offset: 0x26f0
// Size: 0x26
function proximitydeathwait(owner) {
    self waittill("death");
    self notify(#"deletesound");
}

// Namespace proximity_grenade/proximity_grenade
// Params 1, eflags: 0x0
// Checksum 0x14ddf2ed, Offset: 0x2720
// Size: 0x66
function deleteentonownerdeath(owner) {
    self thread deleteentontimeout();
    self thread deleteentaftertime();
    self endon(#"delete");
    owner waittill("death");
    self notify(#"deletesound");
}

// Namespace proximity_grenade/proximity_grenade
// Params 0, eflags: 0x0
// Checksum 0xdbd2d1b6, Offset: 0x2790
// Size: 0x26
function deleteentaftertime() {
    self endon(#"delete");
    wait 10;
    self notify(#"deletesound");
}

// Namespace proximity_grenade/proximity_grenade
// Params 0, eflags: 0x0
// Checksum 0x3c5cf81b, Offset: 0x27c0
// Size: 0x34
function deleteentontimeout() {
    self endon(#"delete");
    self waittill("deleteSound");
    self delete();
}

// Namespace proximity_grenade/proximity_grenade
// Params 0, eflags: 0x0
// Checksum 0xbf6e5d25, Offset: 0x2800
// Size: 0xb4
function watch_death() {
    self endon(#"disconnect");
    self notify(#"proximity_cleanup");
    self endon(#"proximity_cleanup");
    self waittill("death");
    self stoprumble("proximity_grenade");
    self setblur(0, 0);
    self val::reset("grenade_damage", "show_hud");
    self clientfield::set_to_player("tazered", 0);
}

// Namespace proximity_grenade/proximity_grenade
// Params 0, eflags: 0x0
// Checksum 0xa1b60a1c, Offset: 0x28c0
// Size: 0x4c
function on_player_spawned() {
    self thread createproximitygrenadewatcher();
    self thread creategadgetproximitygrenadewatcher();
    self thread begin_other_grenade_tracking();
}

// Namespace proximity_grenade/proximity_grenade
// Params 0, eflags: 0x0
// Checksum 0x58d01294, Offset: 0x2918
// Size: 0xe0
function begin_other_grenade_tracking() {
    self endon(#"death");
    self endon(#"disconnect");
    self notify(#"hash_854e75e1");
    self endon(#"hash_854e75e1");
    for (;;) {
        waitresult = self waittill("grenade_fire");
        grenade = waitresult.projectile;
        weapon = waitresult.weapon;
        if (grenade util::ishacked()) {
            continue;
        }
        if (weapon.rootweapon.name == "proximity_grenade") {
            grenade thread watchproximitygrenadehitplayer(self);
        }
    }
}

// Namespace proximity_grenade/proximity_grenade
// Params 5, eflags: 0x0
// Checksum 0x4bdcdc73, Offset: 0x2a00
// Size: 0x64
function on_damage(eattacker, einflictor, weapon, meansofdeath, damage) {
    self thread proximitygrenadedamageplayer(eattacker, einflictor, einflictor.killcament, weapon, meansofdeath, damage, undefined);
}

