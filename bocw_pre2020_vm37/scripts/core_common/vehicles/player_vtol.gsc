#using scripts\core_common\system_shared;
#using scripts\core_common\targetting_delay;
#using scripts\core_common\turret_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\vehicle_shared;
#using scripts\killstreaks\airsupport;
#using scripts\killstreaks\killstreaks_shared;
#using scripts\weapons\heatseekingmissile;

#namespace player_vtol;

// Namespace player_vtol/player_vtol
// Params 0, eflags: 0x6
// Checksum 0x62a209fa, Offset: 0xe0
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"player_vtol", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace player_vtol/player_vtol
// Params 0, eflags: 0x5 linked
// Checksum 0x20f31ee, Offset: 0x128
// Size: 0x2c
function private function_70a657d8() {
    vehicle::add_main_callback("player_vtol", &function_1b39ded0);
}

// Namespace player_vtol/player_vtol
// Params 0, eflags: 0x1 linked
// Checksum 0x6062efce, Offset: 0x160
// Size: 0x10c
function function_1b39ded0() {
    self function_803e9bf3(1);
    self.numflares = 1;
    self.var_fc0dee44 = 10000;
    bundle = killstreaks::get_script_bundle("hoverjet");
    self thread heatseekingmissile::missiletarget_proximitydetonateincomingmissile(bundle, "death", "dodge_missile", 1);
    self thread function_fcc7ca52();
    self.var_51e39f11 = [];
    self thread function_7d2e878c();
    self thread function_c87c4293();
    self thread function_4ceb8c26();
    self thread targetting_delay::function_7e1a12ce(self.var_fc0dee44);
}

// Namespace player_vtol/player_vtol
// Params 0, eflags: 0x1 linked
// Checksum 0x5f988f7b, Offset: 0x278
// Size: 0x104
function function_fcc7ca52() {
    self endon(#"death");
    while (true) {
        params = self waittill(#"weapon_fired");
        self turretsettarget(1, self turretgettarget(0));
        foreach (projectile in params.projectile) {
            self fireweapon(1);
        }
    }
}

// Namespace player_vtol/event_5fafee73
// Params 0, eflags: 0x40
// Checksum 0xa8eeaff9, Offset: 0x388
// Size: 0x12c
function event_handler[event_5fafee73] function_49e8c140() {
    if (target_istarget(self)) {
        target_remove(self);
    }
    foreach (missile in self.var_51e39f11) {
        if (isdefined(missile)) {
            missile missile_settarget(undefined);
        }
    }
    self.var_51e39f11 = [];
    self notify(#"dodge_missile");
    bundle = killstreaks::get_script_bundle("hoverjet");
    self thread heatseekingmissile::missiletarget_proximitydetonateincomingmissile(bundle, "death", "dodge_missile", 1);
}

// Namespace player_vtol/event_a1da12f0
// Params 0, eflags: 0x40
// Checksum 0x79157ee8, Offset: 0x4c0
// Size: 0x1c
function event_handler[event_a1da12f0] function_9d2a2309() {
    target_set(self);
}

// Namespace player_vtol/player_vtol
// Params 0, eflags: 0x1 linked
// Checksum 0x75aa9ed7, Offset: 0x4e8
// Size: 0xc4
function function_7d2e878c() {
    level endon(#"game_ended");
    self endon(#"death");
    for (;;) {
        waitresult = self waittill(#"stinger_fired_at_me");
        if (!isdefined(self.var_51e39f11)) {
            self.var_51e39f11 = [];
        } else if (!isarray(self.var_51e39f11)) {
            self.var_51e39f11 = array(self.var_51e39f11);
        }
        self.var_51e39f11[self.var_51e39f11.size] = waitresult.projectile;
    }
}

// Namespace player_vtol/player_vtol
// Params 1, eflags: 0x0
// Checksum 0x61313b59, Offset: 0x5b8
// Size: 0x54
function function_ff2361d1(target) {
    self waittill(#"death");
    if (isdefined(target) && isdefined(target.var_51e39f11)) {
        arrayremovevalue(target.var_51e39f11, self);
    }
}

// Namespace player_vtol/player_vtol
// Params 0, eflags: 0x1 linked
// Checksum 0x7490e09b, Offset: 0x618
// Size: 0x338
function function_4ceb8c26() {
    self endon(#"death");
    for (;;) {
        heli_centroid = self.origin + (0, 0, -160);
        heli_forward_norm = anglestoforward(self.angles);
        heli_turret_point = heli_centroid + 144 * heli_forward_norm;
        targets = [];
        foreach (player in level.players) {
            if (isdefined(player) && self cantargetplayer_turret(player, heli_turret_point)) {
                if (!isdefined(targets)) {
                    targets = [];
                } else if (!isarray(targets)) {
                    targets = array(targets);
                }
                targets[targets.size] = player;
            }
        }
        actors = getactorarray();
        foreach (actor in actors) {
            if (isdefined(actor) && isactor(actor) && isalive(actor)) {
                if (self cantargetactor_turret(actor, heli_turret_point)) {
                    targets[targets.size] = actor;
                }
            }
        }
        if (targets.size == 0) {
            self.primarytarget = undefined;
            wait 0.5;
            continue;
        }
        if (targets.size == 1) {
            if (isactor(targets[0])) {
                killstreaks::update_actor_threat(targets[0]);
            } else {
                killstreaks::update_player_threat(targets[0]);
            }
            self.primarytarget = targets[0];
            self notify(#"primary acquired");
        } else if (targets.size > 1) {
            assignprimarytargets(targets);
        }
        wait 0.5;
    }
}

// Namespace player_vtol/player_vtol
// Params 2, eflags: 0x1 linked
// Checksum 0x3bf7553, Offset: 0x958
// Size: 0x244
function cantargetplayer_turret(player, sightpos) {
    if (!isalive(player) || player.sessionstate != "playing") {
        return false;
    }
    if (player.ignoreme === 1) {
        return false;
    }
    if (player === self.remoteowner) {
        return false;
    }
    if (player isnotarget()) {
        return false;
    }
    if (player airsupport::cantargetplayerwithspecialty() == 0) {
        return false;
    }
    if (distancesquared(player.origin, self.origin) > function_a3f6cdac(self.var_fc0dee44)) {
        return false;
    }
    if (!isdefined(player.team)) {
        return false;
    }
    if (!util::function_fbce7263(player.team, self.team)) {
        return false;
    }
    if (player.team == #"spectator") {
        return false;
    }
    if (isdefined(player.spawntime) && float(gettime() - player.spawntime) / 1000 <= 5) {
        return false;
    }
    visible_amount = player sightconetrace(sightpos, self);
    if (visible_amount < 0.2) {
        return false;
    }
    var_2910def0 = self targetting_delay::function_1c169b3a(player);
    targetting_delay::function_a4d6d6d8(player, int((isdefined(0.5) ? 0.5 : 0.25) * 1000));
    if (!var_2910def0) {
        return false;
    }
    return true;
}

// Namespace player_vtol/player_vtol
// Params 2, eflags: 0x1 linked
// Checksum 0xcae1689c, Offset: 0xba8
// Size: 0xe6
function cantargetactor_turret(actor, sightpos) {
    if (!isalive(actor)) {
        return false;
    }
    if (!isdefined(actor.team)) {
        return false;
    }
    if (!util::function_fbce7263(actor.team, self.team)) {
        return false;
    }
    if (distancesquared(actor.origin, self.origin) > function_a3f6cdac(self.var_fc0dee44)) {
        return false;
    }
    visible_amount = actor sightconetrace(sightpos, self);
    if (visible_amount < 0.2) {
        return false;
    }
    return true;
}

// Namespace player_vtol/player_vtol
// Params 1, eflags: 0x1 linked
// Checksum 0x2bc8d89d, Offset: 0xc98
// Size: 0x1b6
function assignprimarytargets(targets) {
    for (idx = 0; idx < targets.size; idx++) {
        if (isplayer(targets[idx])) {
            killstreaks::update_player_threat(targets[idx]);
            continue;
        }
        if (isactor(targets[idx])) {
            killstreaks::update_actor_threat(targets[idx]);
            continue;
        }
        killstreaks::update_non_player_threat(targets[idx]);
    }
    assert(targets.size >= 1, "<dev string:x38>");
    highest = 0;
    primarytarget = undefined;
    for (idx = 0; idx < targets.size; idx++) {
        assert(isdefined(targets[idx].threatlevel), "<dev string:x60>");
        if (targets[idx].threatlevel >= highest) {
            highest = targets[idx].threatlevel;
            primarytarget = targets[idx];
        }
    }
    assert(isdefined(primarytarget), "<dev string:x8c>");
    self.primarytarget = primarytarget;
    self notify(#"primary acquired");
}

// Namespace player_vtol/player_vtol
// Params 0, eflags: 0x1 linked
// Checksum 0x96861ddc, Offset: 0xe58
// Size: 0x31e
function function_c87c4293() {
    self endon(#"death");
    level endon(#"game_ended");
    self turretsetontargettolerance(0, 5);
    for (;;) {
        if (isdefined(self.primarytarget)) {
            self.primarytarget.antithreat = undefined;
            self.turrettarget = self.primarytarget;
            antithreat = 0;
            while (isdefined(self.turrettarget) && isalive(self.turrettarget)) {
                if (!isdefined(self.turrettarget) || !isalive(self.turrettarget)) {
                    break;
                }
                self turretsettarget(2, self.primarytarget);
                turret::function_38841344(self.turrettarget, 2);
                self notify(#"turret_on_target");
                wait 0;
                for (i = 0; i < 30; i++) {
                    if (isdefined(self.turrettarget) && isdefined(self.primarytarget)) {
                        if (self.primarytarget != self.turrettarget) {
                            self turret::set_target(self.primarytarget, (0, 0, 0), 2);
                            while (!self.turretontarget) {
                                waitframe(1);
                            }
                        }
                    }
                    if (isdefined(self.primarytarget)) {
                        self turretsettarget(2, self.primarytarget);
                        minigun = self fireweapon(2, self.primarytarget);
                    } else {
                        minigun = self fireweapon(2);
                    }
                    waitframe(1);
                }
                self notify(#"turret reloading");
                wait 2;
                if (isdefined(self.turrettarget) && isalive(self.turrettarget)) {
                    antithreat += 100;
                    self.turrettarget.antithreat = antithreat;
                }
                if (!isdefined(self.primarytarget) || isdefined(self.turrettarget) && isdefined(self.primarytarget) && self.primarytarget != self.turrettarget) {
                    break;
                }
            }
            if (isdefined(self.turrettarget)) {
                self.turrettarget.antithreat = undefined;
            }
        }
        self waittill(#"primary acquired");
    }
}

