#using script_1cc417743d7c262d;
#using scripts\core_common\battlechatter;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\scoreevents_shared;
#using scripts\core_common\system_shared;
#using scripts\weapons\deployable;
#using scripts\weapons\weaponobjects;

#namespace listening_device;

// Namespace listening_device/listening_device
// Params 0, eflags: 0x6
// Checksum 0xd9c89cfb, Offset: 0x170
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"listening_device", &init_shared, undefined, undefined, undefined);
}

// Namespace listening_device/listening_device
// Params 0, eflags: 0x0
// Checksum 0xac36c17d, Offset: 0x1b8
// Size: 0x164
function init_shared() {
    weaponobjects::function_e6400478("listening_device", &function_2111cf41, 0);
    level.var_81286410 = &function_23fef963;
    level.var_5be42934 = &function_f38fc2a8;
    callback::on_game_playing(&on_game_playing);
    callback::on_weapon_fired(&on_weapon_fired);
    level.var_8ddf6d3d = getscriptbundle(#"listeningdevicesettings");
    level.var_96492769 = getscriptbundle(#"listeningdevicesettings_deadsilence");
    callback::on_finalize_initialization(&function_1c601b99);
    deployable::register_deployable(getweapon("listening_device"));
    clientfield::register("missile", "listening_device_hacked", 1, 1, "counter");
}

// Namespace listening_device/listening_device
// Params 0, eflags: 0x0
// Checksum 0x44f765b0, Offset: 0x328
// Size: 0x48
function function_1c601b99() {
    if (isdefined(level.var_1b900c1d)) {
        [[ level.var_1b900c1d ]](getweapon("listening_device"), &function_bff5c062);
    }
}

// Namespace listening_device/listening_device
// Params 2, eflags: 0x0
// Checksum 0x46c7f636, Offset: 0x378
// Size: 0x18c
function function_bff5c062(listening_device, attackingplayer) {
    var_f3ab6571 = listening_device.owner weaponobjects::function_8481fc06(listening_device.weapon) > 1;
    listening_device.owner thread globallogic_audio::function_a2cde53d(listening_device.weapon, var_f3ab6571);
    listening_device.team = attackingplayer.team;
    listening_device setteam(attackingplayer.team);
    listening_device.owner = attackingplayer;
    listening_device setowner(attackingplayer);
    if (isdefined(listening_device) && isdefined(level.var_f1edf93f)) {
        _station_up_to_detention_center_triggers = [[ level.var_f1edf93f ]]();
        if (isdefined(_station_up_to_detention_center_triggers) ? _station_up_to_detention_center_triggers : 0) {
            listening_device notify(#"cancel_timeout");
            listening_device thread weaponobjects::weapon_object_timeout(listening_device.var_2d045452, _station_up_to_detention_center_triggers);
        }
    }
    listening_device thread weaponobjects::function_6d8aa6a0(attackingplayer, listening_device.var_2d045452);
    listening_device clientfield::increment("listening_device_hacked");
}

// Namespace listening_device/listening_device
// Params 1, eflags: 0x0
// Checksum 0xe3d6789, Offset: 0x510
// Size: 0x1c2
function function_2111cf41(watcher) {
    watcher.watchforfire = 1;
    watcher.activatesound = #"wpn_claymore_alert";
    watcher.hackable = 1;
    watcher.hackertoolradius = level.equipmenthackertoolradius;
    watcher.hackertooltimems = level.equipmenthackertooltimems;
    watcher.ownergetsassist = 1;
    watcher.ignoredirection = undefined;
    watcher.immediatedetonation = 1;
    watcher.immunespecialty = "specialty_immunetriggerbetty";
    watcher.var_8eda8949 = (0, 0, 0);
    var_167da8cf = getweapon(#"listening_device");
    if (isdefined(var_167da8cf.customsettings)) {
        var_e6fbac16 = getscriptbundle(var_167da8cf.customsettings);
        assert(isdefined(var_e6fbac16));
    }
    watcher.stuntime = 1;
    watcher.ondetonatecallback = &function_ad011f90;
    watcher.onfizzleout = &weaponobjects::weaponobjectfizzleout;
    watcher.onspawn = &function_8bdff396;
    watcher.stun = &weaponobjects::weaponstun;
    watcher.var_994b472b = &function_7b26afb;
    watcher.var_10efd558 = "switched_field_upgrade";
    watcher.ondestroyed = &function_8af865a6;
}

// Namespace listening_device/listening_device
// Params 3, eflags: 0x0
// Checksum 0xb0dacfc7, Offset: 0x6e0
// Size: 0xd4
function function_ad011f90(attacker, weapon, target) {
    if (isdefined(attacker) && isplayer(attacker) && attacker != self.owner && attacker.team != self.team) {
        var_f3ab6571 = self.owner weaponobjects::function_8481fc06(self.weapon) > 1;
        self.owner thread globallogic_audio::function_6daffa93(self.weapon, var_f3ab6571);
    }
    weaponobjects::proximitydetonate(attacker, weapon, target);
}

// Namespace listening_device/listening_device
// Params 1, eflags: 0x0
// Checksum 0x4ce90bde, Offset: 0x7c0
// Size: 0x24
function function_7b26afb(*player) {
    self weaponobjects::weaponobjectfizzleout();
}

// Namespace listening_device/listening_device
// Params 2, eflags: 0x0
// Checksum 0x1885873d, Offset: 0x7f0
// Size: 0x114
function function_8bdff396(watcher, player) {
    weaponobjects::onspawnproximitygrenadeweaponobject(watcher, player);
    self.weapon = getweapon(#"listening_device");
    self.var_48d842c3 = 1;
    self.var_515d6dda = 1;
    if (!isdefined(level.var_b7bd6b6d)) {
        level.var_b7bd6b6d = [];
    }
    team = player.team;
    if (isdefined(team)) {
        if (!isdefined(level.var_b7bd6b6d[team])) {
            level.var_b7bd6b6d[team] = [];
        }
        level.var_b7bd6b6d[team][self getentitynumber()] = self;
    }
    player battlechatter::function_fc82b10(self.weapon, self.origin, self);
}

// Namespace listening_device/listening_device
// Params 2, eflags: 0x0
// Checksum 0xa12216a8, Offset: 0x910
// Size: 0x10c
function function_8af865a6(attacker, *callback_data) {
    weaponobjects::proximitydetonate(callback_data);
    if (isplayer(callback_data) && callback_data != self.owner && callback_data.team != self.team) {
        scoreevents::processscoreevent(#"hash_20263a44bc86ab70", callback_data);
        self thread battlechatter::function_d2600afc(callback_data, self.owner, self.weapon);
        var_f3ab6571 = self.owner weaponobjects::function_8481fc06(self.weapon) > 1;
        self.owner thread globallogic_audio::function_6daffa93(self.weapon, var_f3ab6571);
    }
}

// Namespace listening_device/listening_device
// Params 0, eflags: 0x0
// Checksum 0x25f60709, Offset: 0xa28
// Size: 0x1da
function function_23fef963() {
    if (!isdefined(self.team)) {
        return;
    }
    if (!isdefined(level.var_b7bd6b6d[self.team])) {
        level.var_b7bd6b6d[self.team] = [];
    }
    var_c3df74e2 = isdefined(level.var_8ddf6d3d.var_ec25308b) ? level.var_8ddf6d3d.var_ec25308b : 0;
    var_bf170232 = [];
    foreach (device in level.var_b7bd6b6d[self.team]) {
        if (!isdefined(device)) {
            continue;
        }
        if (!var_c3df74e2 && device.owner !== self) {
            continue;
        }
        var_48b7953 = spawnstruct();
        var_48b7953.origin = device.origin;
        var_48b7953.angles = device.angles;
        var_48b7953.owner = device.owner;
        var_48b7953.isjammed = device.isjammed;
        if (!isdefined(var_bf170232)) {
            var_bf170232 = [];
        } else if (!isarray(var_bf170232)) {
            var_bf170232 = array(var_bf170232);
        }
        var_bf170232[var_bf170232.size] = var_48b7953;
    }
    return var_bf170232;
}

// Namespace listening_device/listening_device
// Params 0, eflags: 0x4
// Checksum 0x93d7649f, Offset: 0xc10
// Size: 0x1c
function private on_game_playing() {
    level thread function_d993c135();
}

// Namespace listening_device/listening_device
// Params 1, eflags: 0x4
// Checksum 0x9875343b, Offset: 0xc38
// Size: 0x26
function private on_weapon_fired(*params) {
    self.var_bb20a522 = gettime();
    self.var_8c3b7f1a = self.origin;
}

// Namespace listening_device/listening_device
// Params 0, eflags: 0x0
// Checksum 0xc31416ab, Offset: 0xc68
// Size: 0x3b4
function function_d993c135() {
    self notify("4962b5e6afd5b151");
    self endon("4962b5e6afd5b151");
    level endon(#"game_ended");
    pass = 0;
    var_af989ae4 = sqr(level.var_8ddf6d3d.var_293163bd);
    var_84dbcde7 = sqr(level.var_96492769.var_293163bd);
    var_24fcb2d = min(var_af989ae4, var_84dbcde7);
    var_24bfde42 = sqr(level.var_8ddf6d3d.var_9b69c823);
    var_46638976 = sqr(level.var_96492769.var_9b69c823);
    var_3d369b0c = min(var_af989ae4, var_84dbcde7);
    while (true) {
        now = gettime();
        players = getplayers();
        foreach (player in players) {
            if (!isdefined(player)) {
                continue;
            }
            if (player getentitynumber() & 3 != pass) {
                continue;
            }
            if (!isalive(player)) {
                continue;
            }
            var_92c9c085 = length2dsquared(player getvelocity());
            if (player isplayerswimming() && !player isplayerunderwater()) {
                if (var_92c9c085 < var_3d369b0c) {
                    continue;
                }
                var_daf9a500 = var_24bfde42;
                if (player hasperk(#"specialty_sixthsensejammer")) {
                    var_daf9a500 = var_84dbcde7;
                }
                if (var_92c9c085 > var_daf9a500) {
                    player.var_3ab8ccc9 = now;
                    player.var_5550488a = player.origin;
                }
                continue;
            }
            if (var_92c9c085 < var_24fcb2d) {
                continue;
            }
            if (var_92c9c085 > 62500) {
                player.var_e5a19e3d = now;
                player.var_50703880 = player.origin;
                continue;
            }
            minspeedsq = var_af989ae4;
            if (player hasperk(#"specialty_sixthsensejammer")) {
                minspeedsq = var_84dbcde7;
            }
            if (var_92c9c085 > minspeedsq) {
                player.var_3ab8ccc9 = now;
                player.var_5550488a = player.origin;
            }
        }
        pass++;
        if (pass >= 4) {
            pass = 0;
        }
        wait 0.1;
    }
}

// Namespace listening_device/listening_device
// Params 1, eflags: 0x0
// Checksum 0x9eb56f3c, Offset: 0x1028
// Size: 0x79c
function function_f38fc2a8(data) {
    attacker = self;
    if (!isdefined(attacker)) {
        return 0;
    }
    victim = data.victim;
    if (!isdefined(victim)) {
        return 0;
    }
    var_bf170232 = data.var_807875bc;
    if (!isdefined(var_bf170232)) {
        return 0;
    }
    if (!isarray(var_bf170232)) {
        return 0;
    }
    arrayremovevalue(var_bf170232, undefined, 0);
    if (var_bf170232.size == 0) {
        return 0;
    }
    var_ca2cadcd = level.var_8ddf6d3d.var_ec25308b !== 1;
    var_52b5458f = getweapon(#"listening_device");
    var_64c27ffb = 0;
    var_55336d8d = level.var_8ddf6d3d;
    var_c394e130 = level.var_96492769;
    bundle = var_55336d8d;
    if (isplayer(victim) && victim hasperk(#"specialty_sixthsensejammer")) {
        bundle = var_c394e130;
    }
    range = bundle.var_151e2c9b + 30;
    rangesq = sqr(range);
    var_d6ff0766 = 0;
    if (!isdefined(data.var_a73da413)) {
        data.var_a73da413 = 0;
    }
    if (!isdefined(data.var_c23ee432)) {
        data.var_c23ee432 = 0;
    }
    if (data.time - data.var_a73da413 < 6000) {
        var_d6ff0766 = bundle.var_a8e88375 * range;
        var_a8d3770f = data.var_5f1818be;
    } else if (data.time - data.var_c23ee432 < 6000) {
        if (data.var_f0b3c772 >= 1) {
            var_d6ff0766 = bundle.var_2b6e9133 * range;
        } else if (data.var_e05c79a4) {
            var_d6ff0766 = bundle.var_c26d14da * range;
            var_7aeac1e7 = 1;
        } else if (data.victimstance == "stand") {
            var_d6ff0766 = bundle.var_dbf6038b * range;
            var_7aeac1e7 = 1;
        } else if (data.victimstance == "crouch") {
            var_d6ff0766 = bundle.var_dccff18f * range;
        }
        var_a8d3770f = data.var_dbbf805a;
    }
    if (!isdefined(data.var_9c16cd22)) {
        data.var_9c16cd22 = 0;
    }
    if (data.time - data.var_9c16cd22 < 6000) {
        var_f57f785b = bundle.var_abea5dd8 * range;
        if (weaponhasattachment(data.victimweapon, "suppressed") || weaponhasattachment(data.victimweapon, "suppressed2")) {
            var_f57f785b = bundle.var_301350af * range;
        }
        if (var_f57f785b > var_d6ff0766) {
            var_d6ff0766 = var_f57f785b;
            var_a8d3770f = data.var_5d9be0a1;
        }
    }
    if (!isdefined(var_a8d3770f)) {
        var_a8d3770f = data.victimorigin;
    }
    var_8463af9d = sqr(var_d6ff0766);
    var_7f4e7212 = [];
    foreach (var_48b7953 in var_bf170232) {
        if (!isdefined(var_48b7953.owner)) {
            continue;
        }
        if (var_48b7953.isjammed === 1) {
            continue;
        }
        distcurrentsq = distance2dsquared(var_a8d3770f, var_48b7953.origin);
        if (distcurrentsq > rangesq) {
            continue;
        }
        disttovictim = var_a8d3770f - var_48b7953.origin;
        if (bundle.var_b060dd0c < 180) {
            var_fa4e3cfc = vectornormalize((disttovictim[0], disttovictim[1], 0));
            if (!isdefined(var_48b7953.var_fa4e3cfc)) {
                var_48b7953.var_2a5aebad = anglestoforward((0, var_48b7953.angles[1], 0));
            }
            dot = vectordot(var_fa4e3cfc, var_48b7953.var_2a5aebad);
            if (dot < cos(bundle.var_b060dd0c)) {
                continue;
            }
        }
        if (distcurrentsq > var_8463af9d) {
            continue;
        }
        var_a07d912f = !var_ca2cadcd;
        if (var_48b7953.owner == attacker) {
            scoreevents::processscoreevent(#"hash_18522e88ad05a3b2", attacker, victim, var_52b5458f);
            attacker stats::function_dad108fa(#"hash_15da16b6b9032af", 1);
            data.var_7b4d33ac = 1;
            if (attacker.var_fa9604fd !== 1) {
                if (!isdefined(attacker.var_90df1936)) {
                    attacker.var_90df1936 = 0;
                }
                if (data.time - attacker.var_90df1936 < 4000) {
                    scoreevents::processscoreevent(#"hash_293351f0ab09e08e", attacker, victim, var_52b5458f);
                    attacker.var_fa9604fd = 1;
                }
                attacker.var_90df1936 = data.time;
            }
            var_a07d912f = 0;
        }
        if (var_a07d912f && var_7f4e7212[var_48b7953.owner getentitynumber()] !== 1) {
            scoreevents::processscoreevent(#"hash_573fdf319bb7b7d1", var_48b7953.owner, victim, var_52b5458f);
            var_7f4e7212[var_48b7953.owner getentitynumber()] = 1;
        }
    }
}

