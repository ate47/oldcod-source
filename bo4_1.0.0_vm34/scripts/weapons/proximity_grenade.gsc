#using scripts\core_common\callbacks_shared;
#using scripts\core_common\challenges_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\damage;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\scoreevents_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\weapons\weaponobjects;

#namespace proximity_grenade;

// Namespace proximity_grenade/proximity_grenade
// Params 0, eflags: 0x0
// Checksum 0xf9053217, Offset: 0x160
// Size: 0x43c
function init_shared() {
    level._effect[#"prox_grenade_friendly_default"] = #"weapon/fx_prox_grenade_scan_blue";
    level._effect[#"prox_grenade_friendly_warning"] = #"weapon/fx_prox_grenade_wrn_grn";
    level._effect[#"prox_grenade_enemy_default"] = #"weapon/fx_prox_grenade_scan_orng";
    level._effect[#"prox_grenade_enemy_warning"] = #"weapon/fx_prox_grenade_wrn_red";
    level._effect[#"prox_grenade_player_shock"] = #"weapon/fx_prox_grenade_impact_player_spwner";
    level._effect[#"prox_grenade_chain_bolt"] = #"weapon/fx_prox_grenade_elec_jump";
    level.proximitygrenadedetectionradius = getdvarint(#"scr_proximitygrenadedetectionradius", 180);
    level.proximitygrenadeduration = getdvarfloat(#"scr_proximitygrenadeduration", 1.2);
    level.proximitygrenadegraceperiod = getdvarfloat(#"scr_proximitygrenadegraceperiod", 0.05);
    level.proximitygrenadedotdamageamount = getdvarint(#"scr_proximitygrenadedotdamageamount", 1);
    level.proximitygrenadedotdamageamounthardcore = getdvarint(#"scr_proximitygrenadedotdamageamounthardcore", 1);
    level.proximitygrenadedotdamagetime = getdvarfloat(#"scr_proximitygrenadedotdamagetime", 0.2);
    level.proximitygrenadedotdamageinstances = getdvarint(#"scr_proximitygrenadedotdamageinstances", 4);
    level.proximitygrenadeactivationtime = getdvarfloat(#"scr_proximitygrenadeactivationtime", 0.1);
    level.proximitychaindebug = getdvarint(#"scr_proximitychaindebug", 0);
    level.proximitychaingraceperiod = getdvarint(#"scr_proximitychaingraceperiod", 2500);
    level.proximitychainboltspeed = getdvarfloat(#"scr_proximitychainboltspeed", 400);
    level.proximitygrenadeprotectedtime = getdvarfloat(#"scr_proximitygrenadeprotectedtime", 0.45);
    level.poisonfxduration = 6;
    level thread register();
    callback::add_weapon_damage(getweapon(#"proximity_grenade"), &on_damage);
    weaponobjects::function_f298eae6(#"proximity_grenade", &createproximitygrenadewatcher, 0);
    weaponobjects::function_f298eae6(#"gadget_sticky_proximity", &creategadgetproximitygrenadewatcher, 0);
    /#
        level thread updatedvars();
    #/
}

/#

    // Namespace proximity_grenade/proximity_grenade
    // Params 0, eflags: 0x0
    // Checksum 0xc7e4501b, Offset: 0x5a8
    // Size: 0x2b4
    function updatedvars() {
        while (true) {
            level.proximitygrenadedetectionradius = getdvarint(#"scr_proximitygrenadedetectionradius", level.proximitygrenadedetectionradius);
            level.proximitygrenadeduration = getdvarfloat(#"scr_proximitygrenadeduration", 1.5);
            level.proximitygrenadegraceperiod = getdvarfloat(#"scr_proximitygrenadegraceperiod", level.proximitygrenadegraceperiod);
            level.proximitygrenadedotdamageamount = getdvarint(#"scr_proximitygrenadedotdamageamount", level.proximitygrenadedotdamageamount);
            level.proximitygrenadedotdamageamounthardcore = getdvarint(#"scr_proximitygrenadedotdamageamounthardcore", level.proximitygrenadedotdamageamounthardcore);
            level.proximitygrenadedotdamagetime = getdvarfloat(#"scr_proximitygrenadedotdamagetime", level.proximitygrenadedotdamagetime);
            level.proximitygrenadedotdamageinstances = getdvarint(#"scr_proximitygrenadedotdamageinstances", level.proximitygrenadedotdamageinstances);
            level.proximitygrenadeactivationtime = getdvarfloat(#"scr_proximitygrenadeactivationtime", level.proximitygrenadeactivationtime);
            level.proximitychaindebug = getdvarint(#"scr_proximitychaindebug", level.proximitychaindebug);
            level.proximitychaingraceperiod = getdvarint(#"scr_proximitychaingraceperiod", level.proximitychaingraceperiod);
            level.proximitychainboltspeed = getdvarfloat(#"scr_proximitychainboltspeed", level.proximitychainboltspeed);
            level.proximitygrenadeprotectedtime = getdvarfloat(#"scr_proximitygrenadeprotectedtime", level.proximitygrenadeprotectedtime);
            wait 1;
        }
    }

#/

// Namespace proximity_grenade/proximity_grenade
// Params 0, eflags: 0x0
// Checksum 0xb16fc498, Offset: 0x868
// Size: 0x34
function register() {
    clientfield::register("toplayer", "tazered", 1, 1, "int");
}

// Namespace proximity_grenade/proximity_grenade
// Params 1, eflags: 0x0
// Checksum 0x8f2155e8, Offset: 0x8a8
// Size: 0x15e
function createproximitygrenadewatcher(watcher) {
    watcher.watchforfire = 1;
    watcher.hackable = 1;
    watcher.hackertoolradius = level.equipmenthackertoolradius;
    watcher.hackertooltimems = level.equipmenthackertooltimems;
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
    watcher.activatesound = #"wpn_claymore_alert";
    watcher.immunespecialty = "specialty_immunetriggershock";
    watcher.onspawn = &onspawnproximitygrenadeweaponobject;
}

// Namespace proximity_grenade/proximity_grenade
// Params 1, eflags: 0x0
// Checksum 0x3968bdf3, Offset: 0xa10
// Size: 0x146
function creategadgetproximitygrenadewatcher(watcher) {
    watcher.watchforfire = 1;
    watcher.hackable = 1;
    watcher.hackertoolradius = level.equipmenthackertoolradius;
    watcher.hackertooltimems = level.equipmenthackertooltimems;
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
    watcher.activatesound = #"wpn_claymore_alert";
    watcher.onspawn = &onspawnproximitygrenadeweaponobject;
}

// Namespace proximity_grenade/proximity_grenade
// Params 2, eflags: 0x0
// Checksum 0x14f80387, Offset: 0xb60
// Size: 0xfa
function onspawnproximitygrenadeweaponobject(watcher, owner) {
    self thread setupkillcament();
    if (isplayer(owner)) {
        owner stats::function_4f10b697(self.weapon, #"used", 1);
    }
    if (isdefined(self.weapon) && self.weapon.proximitydetonation > 0) {
        watcher.detonateradius = self.weapon.proximitydetonation;
    }
    weaponobjects::onspawnproximityweaponobject(watcher, owner);
    self trackonowner(self.owner);
    self.originalowner = owner;
}

// Namespace proximity_grenade/proximity_grenade
// Params 1, eflags: 0x0
// Checksum 0x27ece836, Offset: 0xc68
// Size: 0x8a
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
// Checksum 0xc723c149, Offset: 0xd00
// Size: 0x74
function setupkillcament() {
    self endon(#"death");
    self util::waittillnotmoving();
    self.killcament = spawn("script_model", self.origin + (0, 0, 8));
    self thread cleanupkillcamentondeath();
}

// Namespace proximity_grenade/proximity_grenade
// Params 0, eflags: 0x0
// Checksum 0x28d5cd35, Offset: 0xd80
// Size: 0x4c
function cleanupkillcamentondeath() {
    self waittill(#"death");
    self.killcament util::deleteaftertime(4 + level.proximitygrenadedotdamagetime * level.proximitygrenadedotdamageinstances);
}

// Namespace proximity_grenade/proximity_grenade
// Params 3, eflags: 0x0
// Checksum 0xe2e30957, Offset: 0xdd8
// Size: 0x124
function proximitydetonate(attacker, weapon, target) {
    if (isdefined(weapon) && weapon.isvalid) {
        if (isdefined(attacker)) {
            if (self.owner util::isenemyplayer(attacker)) {
                if (sessionmodeismultiplayergame() || sessionmodeiswarzonegame()) {
                    attacker challenges::destroyedexplosive(weapon);
                    scoreevents::processscoreevent(#"destroyed_claymore", attacker, self.owner, weapon);
                    if (isdefined(level.var_b31e16d4)) {
                        self [[ level.var_b31e16d4 ]](attacker, self.owner, self.weapon, weapon);
                    }
                }
            }
        }
    }
    weaponobjects::weapondetonate(attacker, weapon);
}

// Namespace proximity_grenade/proximity_grenade
// Params 7, eflags: 0x0
// Checksum 0x6038b7ca, Offset: 0xf08
// Size: 0xcc
function proximitygrenadedamageplayer(eattacker, einflictor, killcament, weapon, meansofdeath, damage, proximitychain) {
    self thread damageplayerinradius(einflictor.origin, eattacker, killcament);
    if (weapon.chaineventradius > 0 && !self hasperk(#"specialty_proximityprotection")) {
        self thread proximitygrenadechain(eattacker, einflictor, killcament, weapon, meansofdeath, damage, proximitychain, 0);
    }
}

// Namespace proximity_grenade/proximity_grenade
// Params 0, eflags: 0x0
// Checksum 0x675f4ed8, Offset: 0xfe0
// Size: 0xd6
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
// Checksum 0x4186d2b6, Offset: 0x10c0
// Size: 0x38
function chainisactive(chain) {
    if (isdefined(chain.activeendtime) && chain.activeendtime > gettime()) {
        return true;
    }
    return false;
}

// Namespace proximity_grenade/proximity_grenade
// Params 0, eflags: 0x0
// Checksum 0xf1a1ab45, Offset: 0x1100
// Size: 0xdc
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
// Checksum 0x68e553fa, Offset: 0x11e8
// Size: 0x3e
function isinchain(player) {
    player_num = player getentitynumber();
    return isdefined(self.chain_players[player_num]);
}

// Namespace proximity_grenade/proximity_grenade
// Params 1, eflags: 0x0
// Checksum 0x3666d873, Offset: 0x1230
// Size: 0x42
function addplayertochain(player) {
    player_num = player getentitynumber();
    self.chain_players[player_num] = player;
}

// Namespace proximity_grenade/proximity_grenade
// Params 8, eflags: 0x0
// Checksum 0xd971fc4e, Offset: 0x1280
// Size: 0x482
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
    proximitychain.activeendtime = endtime + int(delay * 1000) + level.proximitychaingraceperiod;
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
            if (level.proximitychaindebug || damage::friendlyfirecheck(eattacker, player)) {
                if (level.proximitychaindebug || !player hasperk(#"specialty_proximityprotection")) {
                    self thread chainplayer(eattacker, killcament, weapon, meansofdeath, damage, proximitychain, player, distancesq);
                }
            }
        }
        waitframe(1);
    }
}

// Namespace proximity_grenade/proximity_grenade
// Params 8, eflags: 0x0
// Checksum 0x3f960d4f, Offset: 0x1710
// Size: 0x1b4
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
// Checksum 0xac0f04a0, Offset: 0x18d0
// Size: 0x1c4
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
    fxorg setmodel(#"tag_origin");
    fx = playfxontag(level._effect[#"prox_grenade_chain_bolt"], fxorg, "tag_origin");
    playsoundatposition(#"wpn_tesla_bounce", fxorg.origin);
    fxorg moveto(target_origin, waittime);
    fxorg waittill(#"movedone");
    fxorg delete();
}

/#

    // Namespace proximity_grenade/proximity_grenade
    // Params 0, eflags: 0x0
    // Checksum 0x92b5777a, Offset: 0x1aa0
    // Size: 0x3c
    function debugchainsphere() {
        util::debug_sphere(self.origin + (0, 0, 50), 20, (1, 1, 1), 1, 0);
    }

#/

// Namespace proximity_grenade/proximity_grenade
// Params 1, eflags: 0x0
// Checksum 0xb43a1932, Offset: 0x1ae8
// Size: 0x13a
function watchproximitygrenadehitplayer(owner) {
    self endon(#"death");
    self setowner(owner);
    self setteam(owner.team);
    while (true) {
        waitresult = self waittill(#"grenade_bounce");
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
// Checksum 0xc72b166, Offset: 0x1c30
// Size: 0x126
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
// Checksum 0xf5f12c29, Offset: 0x1d60
// Size: 0x48c
function damageplayerinradius(position, eattacker, killcament) {
    self notify(#"proximitygrenadedamagestart");
    self endon(#"proximitygrenadedamagestart");
    self endon(#"disconnect");
    self endon(#"death");
    eattacker endon(#"disconnect");
    playfxontag(level._effect[#"prox_grenade_player_shock"], self, "J_SpineUpper");
    g_time = gettime();
    if (self util::mayapplyscreeneffect()) {
        if (!self hasperk(#"specialty_proximityprotection")) {
            self.lastshockedby = eattacker;
            self.shockendtime = gettime() + int(level.proximitygrenadeduration * 1000);
            self shellshock(#"proximity_grenade", level.proximitygrenadeduration, 0);
        }
        self clientfield::set_to_player("tazered", 1);
    }
    self playrumbleonentity("proximity_grenade");
    self playsound(#"wpn_taser_mine_zap");
    if (!self hasperk(#"specialty_proximityprotection")) {
        self thread watch_death();
        if (!isdefined(killcament)) {
            killcament = spawn("script_model", position + (0, 0, 8));
        }
        killcament.soundmod = "taser_spike";
        killcament util::deleteaftertime(3 + level.proximitygrenadedotdamagetime * level.proximitygrenadedotdamageinstances);
        self val::set(#"grenade_damage", "show_hud", 0);
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
            self dodamage(damage, position, eattacker, killcament, "none", "MOD_GAS", 0, getweapon(#"proximity_grenade_aoe"));
            wait level.proximitygrenadedotdamagetime;
        }
        if (gettime() - g_time < int(level.proximitygrenadeduration * 1000)) {
            wait float(gettime() - g_time) / 1000;
        }
        self val::reset(#"grenade_damage", "show_hud");
    } else {
        wait level.proximitygrenadeprotectedtime;
    }
    self clientfield::set_to_player("tazered", 0);
}

// Namespace proximity_grenade/proximity_grenade
// Params 1, eflags: 0x0
// Checksum 0x43a40317, Offset: 0x21f8
// Size: 0x36
function proximitydeathwait(owner) {
    self waittill(#"death");
    self notify(#"deletesound");
}

// Namespace proximity_grenade/proximity_grenade
// Params 1, eflags: 0x0
// Checksum 0xc79a925f, Offset: 0x2238
// Size: 0x76
function deleteentonownerdeath(owner) {
    self thread deleteentontimeout();
    self thread deleteentaftertime();
    self endon(#"delete");
    owner waittill(#"death");
    self notify(#"deletesound");
}

// Namespace proximity_grenade/proximity_grenade
// Params 0, eflags: 0x0
// Checksum 0x7ae2c2c2, Offset: 0x22b8
// Size: 0x36
function deleteentaftertime() {
    self endon(#"delete");
    wait 10;
    self notify(#"deletesound");
}

// Namespace proximity_grenade/proximity_grenade
// Params 0, eflags: 0x0
// Checksum 0x5c049a74, Offset: 0x22f8
// Size: 0x3c
function deleteentontimeout() {
    self endon(#"delete");
    self waittill(#"deletesound");
    self delete();
}

// Namespace proximity_grenade/proximity_grenade
// Params 0, eflags: 0x0
// Checksum 0x134a7965, Offset: 0x2340
// Size: 0xcc
function watch_death() {
    self endon(#"disconnect");
    self notify(#"proximity_cleanup");
    self endon(#"proximity_cleanup");
    self waittill(#"death");
    self stoprumble("proximity_grenade");
    self setblur(0, 0);
    self val::reset(#"grenade_damage", "show_hud");
    self clientfield::set_to_player("tazered", 0);
}

// Namespace proximity_grenade/grenade_fire
// Params 1, eflags: 0x40
// Checksum 0x68a8b4d3, Offset: 0x2418
// Size: 0xac
function event_handler[grenade_fire] function_d4475a5e(eventstruct) {
    if (!isplayer(self)) {
        return;
    }
    grenade = eventstruct.projectile;
    weapon = eventstruct.weapon;
    if (grenade util::ishacked()) {
        return;
    }
    if (weapon.rootweapon.name == "proximity_grenade") {
        grenade thread watchproximitygrenadehitplayer(self);
    }
}

// Namespace proximity_grenade/proximity_grenade
// Params 5, eflags: 0x0
// Checksum 0x277209b3, Offset: 0x24d0
// Size: 0x64
function on_damage(eattacker, einflictor, weapon, meansofdeath, damage) {
    self thread proximitygrenadedamageplayer(eattacker, einflictor, einflictor.killcament, weapon, meansofdeath, damage, undefined);
}

