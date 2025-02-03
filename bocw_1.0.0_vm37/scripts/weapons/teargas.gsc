#using script_1cc417743d7c262d;
#using scripts\core_common\battlechatter;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\challenges_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\globallogic\globallogic_score;
#using scripts\core_common\scoreevents_shared;
#using scripts\core_common\sound_shared;
#using scripts\core_common\status_effects\status_effect_util;
#using scripts\core_common\util_shared;
#using scripts\weapons\deployable;
#using scripts\weapons\weaponobjects;

#namespace teargas;

// Namespace teargas/teargas
// Params 0, eflags: 0x0
// Checksum 0x12ba5239, Offset: 0x170
// Size: 0x1ec
function init_shared() {
    level.var_2ee59975 = [];
    level.var_29115f03 = [];
    level.var_29115f03[1] = {#slow:#"hash_8a5fd5a0a3d0325", #var_18c0a09d:#"hash_42b275f8ad52e92d"};
    level.var_29115f03[2] = {#slow:#"hash_8a5fa5a0a3cfe0c", #var_18c0a09d:#"hash_42b272f8ad52e414"};
    level.var_29115f03[3] = {#slow:#"hash_8a5fb5a0a3cffbf", #var_18c0a09d:#"hash_42b273f8ad52e5c7"};
    weapon = getweapon(#"tear_gas");
    clientfield::register("toplayer", "in_tear_gas", 1, 2, "int");
    globallogic_score::register_kill_callback(weapon, &function_8f5e1a77);
    weaponobjects::function_e6400478(#"tear_gas", &function_db9e3adb, 0);
    deployable::register_deployable(weapon);
    callback::on_finalize_initialization(&function_1c601b99);
}

// Namespace teargas/teargas
// Params 0, eflags: 0x0
// Checksum 0x64a182b2, Offset: 0x368
// Size: 0x48
function function_1c601b99() {
    if (isdefined(level.var_1b900c1d)) {
        [[ level.var_1b900c1d ]](getweapon("tear_gas"), &function_bff5c062);
    }
}

// Namespace teargas/teargas
// Params 2, eflags: 0x0
// Checksum 0x7ec12868, Offset: 0x3b8
// Size: 0x1dc
function function_bff5c062(teargas, attackingplayer) {
    var_f3ab6571 = teargas.owner weaponobjects::function_8481fc06(teargas.weapon) > 1;
    teargas.owner thread globallogic_audio::function_a2cde53d(teargas.weapon, var_f3ab6571);
    teargas.owner weaponobjects::hackerremoveweapon(teargas);
    teargas weaponobjects::function_fb7b0024(teargas.owner);
    teargas.team = attackingplayer.team;
    teargas setteam(attackingplayer.team);
    teargas.owner = attackingplayer;
    teargas setowner(attackingplayer);
    teargas weaponobjects::function_386fa470(attackingplayer);
    teargas weaponobjects::function_931041f8(attackingplayer);
    if (isdefined(teargas) && isdefined(level.var_f1edf93f)) {
        _station_up_to_detention_center_triggers = [[ level.var_f1edf93f ]]();
        if (isdefined(_station_up_to_detention_center_triggers) ? _station_up_to_detention_center_triggers : 0) {
            teargas notify(#"cancel_timeout");
            teargas thread weaponobjects::weapon_object_timeout(teargas.var_2d045452, _station_up_to_detention_center_triggers);
        }
    }
    teargas thread weaponobjects::function_6d8aa6a0(attackingplayer, teargas.var_2d045452);
}

// Namespace teargas/teargas
// Params 1, eflags: 0x0
// Checksum 0x732da82d, Offset: 0x5a0
// Size: 0x1ca
function function_db9e3adb(watcher) {
    watcher.watchforfire = 1;
    watcher.hackertoolradius = level.equipmenthackertoolradius;
    watcher.hackertooltimems = level.equipmenthackertooltimems;
    watcher.ownergetsassist = 1;
    watcher.ignoredirection = 1;
    watcher.immediatedetonation = 1;
    watcher.immunespecialty = "specialty_immunegastrap";
    watcher.var_8eda8949 = (0, 0, 0);
    watcher.stuntime = 1;
    watcher.var_10efd558 = "switched_field_upgrade";
    if (isdefined(watcher.weapon.customsettings)) {
        var_e6fbac16 = getscriptbundle(watcher.weapon.customsettings);
        watcher.triggertime = var_e6fbac16.var_af22b5dc;
        watcher.activationdelay = var_e6fbac16.var_a3fd61e7;
        watcher.detectiongraceperiod = isdefined(var_e6fbac16.var_88b0248b) ? var_e6fbac16.var_88b0248b : 0;
        if (isdefined(var_e6fbac16.var_29467698) && var_e6fbac16.var_29467698 != 0) {
            watcher.detonateradius = var_e6fbac16.var_29467698;
        }
    }
    watcher.ondetonatecallback = &function_f82566e8;
    watcher.onfizzleout = &weaponobjects::weaponobjectfizzleout;
    watcher.onspawn = &function_7641afa6;
    watcher.var_994b472b = &function_5192d9d6;
    watcher.stun = &weaponobjects::weaponstun;
}

// Namespace teargas/teargas
// Params 2, eflags: 0x0
// Checksum 0xca0deeff, Offset: 0x778
// Size: 0xd4
function function_7641afa6(watcher, player) {
    self.delete_on_death = 1;
    self.var_48d842c3 = 1;
    self.var_515d6dda = 1;
    var_e6fbac16 = getscriptbundle(self.weapon.customsettings);
    self.var_b2ed661a = var_e6fbac16.teargasduration + 3;
    self weaponobjects::onspawnproximitygrenadeweaponobject(watcher, player);
    player battlechatter::function_fc82b10(getweapon(#"tear_gas"), self.origin, self);
}

// Namespace teargas/teargas
// Params 1, eflags: 0x0
// Checksum 0x2e83f4dd, Offset: 0x858
// Size: 0x24
function function_5192d9d6(*player) {
    self weaponobjects::weaponobjectfizzleout();
}

// Namespace teargas/teargas
// Params 3, eflags: 0x0
// Checksum 0x59b18895, Offset: 0x888
// Size: 0x314
function function_f82566e8(attacker, weapon, target) {
    var_7e6e7f9f = self.weapon;
    if (is_true(self.wasdamaged)) {
        if (self.owner util::isenemyplayer(attacker)) {
            attacker challenges::destroyedexplosive(weapon);
            scoreevents::processscoreevent(#"hash_6913b395f1030cd3", attacker, self.owner, weapon);
            self thread battlechatter::function_d2600afc(attacker, self.owner, var_7e6e7f9f, weapon);
            var_f3ab6571 = self.owner weaponobjects::function_8481fc06(var_7e6e7f9f) > 1;
            self.owner thread globallogic_audio::function_6daffa93(var_7e6e7f9f, var_f3ab6571);
        }
        if (isdefined(level._equipment_explode_fx)) {
            playfx(level._equipment_explode_fx, self.origin);
        }
        self playsound(#"hash_16dfe84ea21fd143");
        self delete();
        return;
    }
    var_e6fbac16 = getscriptbundle(var_7e6e7f9f.customsettings);
    radius = var_e6fbac16.var_b86ce9f4;
    duration = var_e6fbac16.teargasduration;
    position = self.origin;
    dir_up = (0, 0, 1);
    ent = spawn("script_model", position);
    ent setteam(self.team);
    ent.team = self.team;
    owner = self.owner;
    ent.killcament = self.killcament;
    if (isdefined(owner)) {
        ent setowner(owner);
        ent.owner = owner;
        owner.var_d56524fc = gettime();
        owner.var_2af14143 = position;
    }
    ent thread function_2f37f73e(var_7e6e7f9f, duration, radius);
    level thread function_a2493473(position, duration, var_7e6e7f9f.projsmokestartsound, var_7e6e7f9f.projsmokeendsound, var_7e6e7f9f.projsmokeloopsound);
    self weaponobjects::proximitydetonate(attacker, weapon, target);
}

// Namespace teargas/teargas
// Params 3, eflags: 0x0
// Checksum 0xb84635f1, Offset: 0xba8
// Size: 0x17c
function function_2f37f73e(var_7e6e7f9f, duration, radius) {
    team = self.team;
    owner = self.owner;
    trigger = spawn("trigger_radius", self.origin, 0, radius, radius);
    trigger.owner = owner;
    self.var_160d2855 = trigger;
    if (!isdefined(level.var_2ee59975)) {
        level.var_2ee59975 = [];
    } else if (!isarray(level.var_2ee59975)) {
        level.var_2ee59975 = array(level.var_2ee59975);
    }
    level.var_2ee59975[level.var_2ee59975.size] = trigger;
    level thread function_516794d8(self, var_7e6e7f9f);
    self waittilltimeout(duration, #"death");
    arrayremovevalue(level.var_2ee59975, trigger);
    if (isdefined(trigger)) {
        trigger delete();
    }
}

// Namespace teargas/teargas
// Params 5, eflags: 0x0
// Checksum 0x550166a2, Offset: 0xd30
// Size: 0x70
function function_8f5e1a77(attacker, victim, *weapon, *attackerweapon, *meansofdeath) {
    if (!isdefined(attackerweapon) || !isdefined(meansofdeath)) {
        return false;
    }
    var_160d2855 = meansofdeath function_12b45f48();
    if (isdefined(var_160d2855)) {
    }
    return false;
}

// Namespace teargas/teargas
// Params 2, eflags: 0x0
// Checksum 0x6c11a70a, Offset: 0xda8
// Size: 0xee
function function_12b45f48(skiptrigger, team) {
    foreach (trigger in level.var_2ee59975) {
        if (isdefined(team) && trigger util::isenemyteam(team)) {
            continue;
        }
        if (self istouching(trigger)) {
            if (isdefined(skiptrigger)) {
                if (skiptrigger != trigger) {
                    return trigger;
                }
                continue;
            }
            return trigger;
        }
    }
    return undefined;
}

// Namespace teargas/teargas
// Params 1, eflags: 0x0
// Checksum 0xdb24dbf7, Offset: 0xea0
// Size: 0x40
function function_585ad28f(weapon) {
    if (getweapon(#"tear_gas") == weapon.rootweapon) {
        return true;
    }
    return false;
}

// Namespace teargas/teargas
// Params 2, eflags: 0x0
// Checksum 0x543944e, Offset: 0xee8
// Size: 0x2f0
function function_516794d8(grenadeent, var_7e6e7f9f) {
    var_160d2855 = grenadeent.var_160d2855;
    if (!isdefined(var_160d2855)) {
        return;
    }
    grenadeteam = grenadeent.team;
    owner = grenadeent.owner;
    while (true) {
        waitresult = var_160d2855 waittilltimeout(0.2, #"death");
        playertargets = grenadeent getpotentialtargets(owner, grenadeteam, var_7e6e7f9f);
        foreach (player in playertargets) {
            if (player hasperk(#"hash_5fef46715b368a6e")) {
                continue;
            }
            if (waitresult._notify == #"timeout" && isdefined(var_160d2855) && player istouching(var_160d2855) && bullettracepassed(grenadeent.origin, player.origin + (0, 0, 12), 0, player)) {
                if (!isdefined(player.var_2ee59975)) {
                    player.var_2ee59975 = [];
                } else if (!isarray(player.var_2ee59975)) {
                    player.var_2ee59975 = array(player.var_2ee59975);
                }
                if (!isinarray(player.var_2ee59975, var_160d2855)) {
                    player.var_2ee59975[var_160d2855 getentitynumber()] = var_160d2855;
                    if (!isdefined(player.var_1b05dcde)) {
                        player thread function_78d7002(var_7e6e7f9f, owner, grenadeent);
                    }
                }
                continue;
            }
            if (isdefined(player.var_1b05dcde)) {
                player function_9eda41cd(var_160d2855, var_7e6e7f9f, owner);
            }
        }
        if (!isdefined(var_160d2855) || waitresult._notify != "timeout") {
            return;
        }
    }
}

// Namespace teargas/teargas
// Params 3, eflags: 0x4
// Checksum 0xf337b63f, Offset: 0x11e0
// Size: 0xd0
function private getpotentialtargets(owner, ownerteam, var_7e6e7f9f) {
    if (level.friendlyfire) {
        return function_a1ef346b();
    }
    potentialtargets = function_f6f34851(ownerteam);
    var_e6fbac16 = getscriptbundle(var_7e6e7f9f.customsettings);
    if (is_true(var_e6fbac16.var_fc20cda3) && isalive(owner)) {
        potentialtargets[potentialtargets.size] = owner;
    }
    return potentialtargets;
}

// Namespace teargas/teargas
// Params 3, eflags: 0x4
// Checksum 0x30e0ca0, Offset: 0x12b8
// Size: 0x1e2
function private function_78d7002(var_7e6e7f9f, owner, grenadeent) {
    self endoncallback(&function_ac86e0a9, #"death", #"hash_7adffd186663a874");
    dot = getstatuseffect(#"hash_69c2a47bf2322b6b");
    dot.killcament = grenadeent.killcament;
    self thread status_effect::status_effect_apply(dot, var_7e6e7f9f, owner, 0, undefined, undefined, grenadeent.origin);
    self playsoundtoplayer(#"hash_569fa11d8a4005ba", self);
    foreach (stage, var_c62d6d34 in level.var_29115f03) {
        self.var_1b05dcde = stage;
        slow = getstatuseffect(var_c62d6d34.slow);
        self thread status_effect::status_effect_apply(slow, var_7e6e7f9f, owner);
        self clientfield::set_to_player("in_tear_gas", stage);
        wait float(slow.seduration) / 1000;
    }
}

// Namespace teargas/teargas
// Params 1, eflags: 0x4
// Checksum 0x930d172f, Offset: 0x14a8
// Size: 0x11e
function private function_ac86e0a9(notifyhash) {
    if (notifyhash == "death" && isdefined(self)) {
        if (isdefined(self.var_1b05dcde)) {
            var_c62d6d34 = level.var_29115f03[self.var_1b05dcde];
            slow = getstatuseffect(var_c62d6d34.slow);
            self status_effect::function_408158ef(slow.setype, slow.var_18d16a6b);
            self.var_1b05dcde = undefined;
        }
        dot = getstatuseffect(#"hash_69c2a47bf2322b6b");
        self status_effect::function_408158ef(dot.setype, dot.var_18d16a6b);
        self clientfield::set_to_player("in_tear_gas", 0);
        self.var_2ee59975 = undefined;
    }
}

// Namespace teargas/teargas
// Params 3, eflags: 0x4
// Checksum 0x6a8ac9f9, Offset: 0x15d0
// Size: 0x1de
function private function_9eda41cd(var_160d2855, var_7e6e7f9f, owner) {
    if (isarray(self.var_2ee59975) && isinarray(self.var_2ee59975, var_160d2855)) {
        arrayremovevalue(self.var_2ee59975, var_160d2855);
        if (!self.var_2ee59975.size) {
            self.var_2ee59975 = undefined;
        }
    }
    if (isdefined(self.var_2ee59975)) {
        return;
    }
    self notify(#"hash_7adffd186663a874");
    if (!isdefined(self.var_1b05dcde)) {
        return;
    }
    var_c62d6d34 = level.var_29115f03[self.var_1b05dcde];
    slow = getstatuseffect(var_c62d6d34.slow);
    var_18c0a09d = getstatuseffect(var_c62d6d34.var_18c0a09d);
    dot = getstatuseffect(#"hash_69c2a47bf2322b6b");
    self status_effect::function_408158ef(dot.setype, dot.var_18d16a6b);
    self status_effect::function_408158ef(slow.setype, slow.var_18d16a6b);
    self thread status_effect::status_effect_apply(var_18c0a09d, var_7e6e7f9f, owner);
    self clientfield::set_to_player("in_tear_gas", 0);
    self.var_1b05dcde = undefined;
}

// Namespace teargas/teargas
// Params 5, eflags: 0x0
// Checksum 0x4bd1c829, Offset: 0x17b8
// Size: 0x13c
function function_a2493473(position, duration, startsound, stopsound, loopsound) {
    var_4af5a2e7 = spawn("script_origin", (0, 0, 1));
    if (isdefined(var_4af5a2e7)) {
        var_4af5a2e7 endon(#"death");
        var_4af5a2e7.origin = position;
        if (isdefined(startsound)) {
            var_4af5a2e7 playsound(startsound);
        }
        if (isdefined(loopsound)) {
            var_4af5a2e7 playloopsound(loopsound);
        }
        if (duration > 7.5) {
            wait duration - 7.5;
        }
        if (isdefined(stopsound)) {
            thread sound::play_in_space(stopsound, position);
        }
        var_4af5a2e7 stoploopsound(0.5);
        wait 0.5;
        var_4af5a2e7 delete();
    }
}

