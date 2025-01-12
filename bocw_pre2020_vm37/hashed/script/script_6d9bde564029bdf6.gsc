#using script_396f7d71538c9677;
#using scripts\core_common\array_shared;
#using scripts\core_common\battlechatter;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\killstreaks\killstreaks_shared;
#using scripts\killstreaks\killstreaks_util;
#using scripts\weapons\weapon_utils;

#namespace battlechatter;

// Namespace battlechatter/weapon_change
// Params 1, eflags: 0x40
// Checksum 0xd81f6658, Offset: 0x170
// Size: 0x84
function event_handler[weapon_change] function_ae02f06c(eventstruct) {
    if (!function_e1983f22()) {
        return;
    }
    if (eventstruct.weapon == level.weaponnone) {
        return;
    }
    self.var_3528f7e9 = 0;
    self.var_87b1ba00 = 0;
    if (isdefined(eventstruct.weapon.var_5c238c21)) {
        function_fe2a1661(self, eventstruct.weapon);
    }
}

// Namespace battlechatter/grenade_fire
// Params 1, eflags: 0x40
// Checksum 0xfec2a826, Offset: 0x200
// Size: 0x6c
function event_handler[grenade_fire] function_8dc76d15(eventstruct) {
    if (!function_e1983f22()) {
        return;
    }
    thread function_5e1705fa(self, eventstruct.projectile, eventstruct.weapon);
    function_26ab78d1(self, eventstruct.weapon, eventstruct.projectile);
}

// Namespace battlechatter/missile_fire
// Params 1, eflags: 0x40
// Checksum 0xb412cfb9, Offset: 0x278
// Size: 0xbc
function event_handler[missile_fire] function_6b98cd96(eventstruct) {
    if (!function_e1983f22()) {
        return;
    }
    if (isdefined(eventstruct.weapon)) {
        if (killstreaks::function_c5927b3f(eventstruct.weapon)) {
            thread killstreaks::function_ece736e7(self, eventstruct.weapon);
        } else {
            thread function_5e1705fa(self, eventstruct.projectile, eventstruct.weapon);
        }
        function_26ab78d1(self, eventstruct.weapon, eventstruct.projectile);
    }
}

// Namespace battlechatter/grenade_launcher_fire
// Params 1, eflags: 0x40
// Checksum 0xdaa46094, Offset: 0x340
// Size: 0x94
function event_handler[grenade_launcher_fire] function_523f5c2e(eventstruct) {
    if (!function_e1983f22()) {
        return;
    }
    if (isdefined(eventstruct.weapon)) {
        if (killstreaks::function_c5927b3f(eventstruct.weapon)) {
            thread killstreaks::function_ece736e7(self, eventstruct.weapon);
        }
        function_26ab78d1(self, eventstruct.weapon, eventstruct.projectile);
    }
}

// Namespace battlechatter/bulletwhizby
// Params 1, eflags: 0x40
// Checksum 0xfae07993, Offset: 0x3e0
// Size: 0x2b4
function event_handler[bulletwhizby] function_e77b4f15(eventstruct) {
    if (!function_e1983f22()) {
        return;
    }
    target = eventstruct.target;
    if (!isdefined(target) || target hasperk(#"specialty_quieter")) {
        return;
    }
    source = eventstruct.source;
    if (!isdefined(source) || (isdefined(source.var_87b1ba00) ? source.var_87b1ba00 : 0)) {
        return;
    }
    if (isdefined(source.currentweapon) && isplayer(source)) {
        bundlename = source getmpdialogname();
        if (!isdefined(bundlename)) {
            return;
        }
        playerbundle = getscriptbundle(bundlename);
        if (!isdefined(playerbundle)) {
            return;
        }
        switch (source.currentweapon.name) {
        case #"hero_annihilator":
            dialogkey = playerbundle.var_93ef961;
            break;
        }
    } else if (isdefined(source.turretweapon)) {
        if (source.turretweapon.name == #"gun_ultimate_turret") {
            source.var_87b1ba00 = 1;
            self playkillstreakthreat(source.killstreaktype);
        }
    } else if (isdefined(source.weapon)) {
        if (isdefined(level.var_24de8afe) && isdefined(source.ai) && is_true(source.ai.swat_gunner) && source.weapon.name == #"hash_6c1be4b025206124") {
            source [[ level.var_24de8afe ]](self, source.script_owner);
            source.var_87b1ba00 = 1;
        }
    }
    if (!isdefined(dialogkey)) {
        return;
    }
    target thread function_a48c33ff(dialogkey, 2, undefined, undefined);
}

// Namespace battlechatter/event_bf57d5bb
// Params 1, eflags: 0x40
// Checksum 0xf15f6da5, Offset: 0x6a0
// Size: 0x622
function event_handler[event_bf57d5bb] function_4540ef25(*eventstruct) {
    if (!function_e1983f22()) {
        return;
    }
    if (!level.teambased) {
        return;
    }
    if (self hasperk(#"specialty_quieter")) {
        return;
    }
    if (self.enemythreattime + int(mpdialog_value("enemyContactInterval", 0) * 1000) >= gettime()) {
        return;
    }
    eyepoint = self geteye();
    dir = anglestoforward(self getplayerangles());
    dir *= mpdialog_value("enemyContactDistance", 0);
    endpoint = eyepoint + dir;
    traceresult = bullettrace(eyepoint, endpoint, 1, self);
    if (isdefined(traceresult[#"entity"]) && util::function_fbce7263(traceresult[#"entity"].team, self.team)) {
        if (traceresult[#"entity"].classname == "player") {
            if (!(traceresult[#"entity"].var_9ee835dc === 1)) {
                playerweapon = undefined;
                if (isdefined(traceresult[#"entity"].weapon)) {
                    playerweapon = traceresult[#"entity"].weapon;
                } else if (isdefined(traceresult[#"entity"].currentweapon)) {
                    playerweapon = traceresult[#"entity"].currentweapon;
                }
                if (isdefined(traceresult[#"entity"].killstreaktype) && !isarray(traceresult[#"entity"].killstreaktype)) {
                    self playkillstreakthreat(traceresult[#"entity"].killstreaktype);
                    traceresult[#"entity"].var_9ee835dc = 1;
                    self.enemythreattime = gettime();
                } else if (isdefined(playerweapon) && (isplayer(traceresult[#"entity"]) || isdefined(traceresult[#"entity"].owner))) {
                    var_24d3b6ca = isplayer(traceresult[#"entity"]) ? traceresult[#"entity"] : traceresult[#"entity"].owner;
                    var_9074cacb = function_58c93260(self);
                    if (dialog_chance("enemyContactChance")) {
                        if (randomfloatrange(0, 1) < 0.8) {
                            suffix = var_9074cacb.threatinfantry;
                        } else if (var_24d3b6ca util::is_female()) {
                            suffix = var_9074cacb.var_bac1f224;
                        } else {
                            suffix = var_9074cacb.var_cef2429;
                        }
                        if (isdefined(suffix) && isdefined(var_9074cacb.voiceprefix)) {
                            killdialog = var_9074cacb.voiceprefix + suffix;
                        }
                        self thread function_a48c33ff(killdialog, 2);
                        traceresult[#"entity"].var_9ee835dc = 1;
                        self.enemythreattime = gettime();
                    }
                } else if (dialog_chance("enemyContactChance")) {
                    var_9074cacb = function_58c93260(self);
                    self thread function_a48c33ff(var_9074cacb.voiceprefix + var_9074cacb.threatinfantry, 2);
                    level notify(#"level_enemy_spotted", self.team);
                    self.enemythreattime = gettime();
                }
            }
            return;
        }
        if (traceresult[#"entity"].classname == "script_vehicle" && isdefined(traceresult[#"entity"].killstreaktype)) {
            if (!(traceresult[#"entity"].var_9ee835dc === 1)) {
                self playkillstreakthreat(traceresult[#"entity"].killstreaktype);
                traceresult[#"entity"].var_9ee835dc = 1;
                self.enemythreattime = gettime();
            }
        }
    }
}

// Namespace battlechatter/grenade_stuck
// Params 1, eflags: 0x40
// Checksum 0xcf86562b, Offset: 0xcd0
// Size: 0x254
function event_handler[grenade_stuck] function_de1402a2(eventstruct) {
    if (!function_e1983f22()) {
        return;
    }
    grenade = eventstruct.projectile;
    if (!isdefined(grenade) || !isdefined(grenade.weapon)) {
        return;
    }
    var_af6fa544 = function_cdd81094(grenade.weapon);
    if (!isdefined(var_af6fa544)) {
        return;
    }
    if (!isdefined(eventstruct.hitent) || !isplayer(eventstruct.hitent)) {
        return;
    }
    if (isplayer(self)) {
        var_296bb9e8 = function_e05060f0(self);
        var_89d36f8a = isalive(self) && !self hasperk(#"specialty_quieter");
        if (isdefined(var_296bb9e8) && isdefined(var_af6fa544.var_488f1315) && var_89d36f8a) {
            dialogalias = var_296bb9e8 + var_af6fa544.var_488f1315;
            self thread function_a48c33ff(dialogalias, 6);
        }
    }
    var_cc5e757a = function_e05060f0(eventstruct.hitent);
    var_3fca87ae = isalive(eventstruct.hitent) && !self hasperk(#"specialty_quieter");
    if (isdefined(var_cc5e757a) && isdefined(var_af6fa544.var_f4196077) && var_3fca87ae) {
        dialogalias = var_cc5e757a + var_af6fa544.var_f4196077;
        eventstruct.hitent thread function_a48c33ff(dialogalias, 6);
    }
}

// Namespace battlechatter/namespace_5232fbcc
// Params 5, eflags: 0x5 linked
// Checksum 0xae90aa07, Offset: 0xf30
// Size: 0x186
function private function_1bc99c5e(*attacker, *inflictor, weapon, *mod, killstreaktype) {
    if (!isdefined(killstreaktype)) {
        return;
    }
    if (!isdefined(level.killstreaks[killstreaktype]) || !isdefined(level.killstreaks[killstreaktype].script_bundle.var_730ca8d) || !level.killstreaks[killstreaktype].script_bundle.var_730ca8d || !dialog_chance("killstreakKillChance") || killstreaks::function_c0c60634(mod)) {
        return;
    }
    ally = self get_closest_player_ally(0);
    allyradius = mpdialog_value("killstreakKillAllyRadius", 0);
    if (isdefined(ally) && distancesquared(self.origin, ally.origin) < function_a3f6cdac(allyradius)) {
        ally playkillstreakthreat(killstreaktype);
        mod.var_95b0150d = gettime();
    }
}

// Namespace battlechatter/namespace_5232fbcc
// Params 4, eflags: 0x5 linked
// Checksum 0x8636949e, Offset: 0x10c0
// Size: 0x27c
function private function_b18b0b7b(attacker, inflictor, weapon, mod) {
    level endon(#"game_ended");
    waittillframeend();
    if (isdefined(attacker) && isplayer(attacker) && !attacker hasperk(#"specialty_quieter")) {
        if (weapon.name == #"dog_ai_defaultmelee" && isdefined(inflictor)) {
            attacker function_bd715920(weapon, self, inflictor.origin, inflictor);
        } else if (weapon.name == #"hero_flamethrower" || weapon.name == #"sig_blade") {
            attacker function_bd715920(weapon, self, attacker.origin, attacker);
        }
    }
    if (isdefined(level.iskillstreakweapon) && isdefined(level.get_killstreak_for_weapon_for_stats)) {
        if ([[ level.iskillstreakweapon ]](weapon)) {
            killstreak = [[ level.get_killstreak_for_weapon_for_stats ]](weapon);
            self function_1bc99c5e(attacker, inflictor, weapon, mod, killstreak);
        }
        var_3ac7db5 = self.currentweapon;
        if ([[ level.iskillstreakweapon ]](var_3ac7db5) && self util::isenemyplayer(attacker)) {
            killstreak = [[ level.get_killstreak_for_weapon_for_stats ]](var_3ac7db5);
            attacker function_eebf94f6(killstreak);
        }
    }
    weaponclass = util::getweaponclass(weapon);
    if (isdefined(weaponclass) && weaponclass == #"weapon_sniper") {
        self function_b06bbccf(attacker);
    }
}

// Namespace battlechatter/player_killed
// Params 1, eflags: 0x40
// Checksum 0xade898ab, Offset: 0x1348
// Size: 0xc4
function event_handler[player_killed] onplayerkilled(eventstruct) {
    if (!function_e1983f22()) {
        return;
    }
    attacker = eventstruct.attacker;
    inflictor = eventstruct.inflictor;
    weapon = eventstruct.weapon;
    mod = eventstruct.mod;
    if (!level.teambased || !level.allowspecialistdialog) {
        return;
    }
    if (self === attacker) {
        return;
    }
    self thread function_b18b0b7b(attacker, inflictor, weapon, mod);
}

// Namespace battlechatter/namespace_5232fbcc
// Params 3, eflags: 0x1 linked
// Checksum 0x1dac873, Offset: 0x1418
// Size: 0x1ea
function function_5e1705fa(thrower, projectile, weapon) {
    level endon(#"game_ended");
    projectile endon(#"death");
    if (!isdefined(projectile) || !isdefined(weapon)) {
        return;
    }
    var_7d44e33d = function_cdd81094(weapon);
    if (!isdefined(var_7d44e33d) || !isdefined(var_7d44e33d.var_2c07bbf1)) {
        return;
    }
    wait isdefined(var_7d44e33d.var_613ebcfa) ? var_7d44e33d.var_613ebcfa : float(function_60d95f53()) / 1000;
    while (true) {
        if (!isdefined(projectile)) {
            return;
        }
        if (!isdefined(thrower) || thrower.team == #"spectator") {
            return;
        }
        if (level.players.size) {
            closest_enemy = thrower get_closest_player_enemy(projectile.origin);
            incomingprojectileradius = mpdialog_value("incomingProjectileRadius", 0);
            if (isdefined(closest_enemy) && distancesquared(projectile.origin, closest_enemy.origin) < incomingprojectileradius * incomingprojectileradius) {
                if (closest_enemy function_bafe1ee4(weapon)) {
                    return;
                }
            }
        }
        waitframe(1);
    }
}

// Namespace battlechatter/namespace_5232fbcc
// Params 3, eflags: 0x5 linked
// Checksum 0xcf68e6f1, Offset: 0x1610
// Size: 0x44
function private function_26ab78d1(player, weapon, *var_56dd9d60) {
    if (!isdefined(var_56dd9d60.var_5c238c21)) {
        return;
    }
    weapon function_26dd1669(var_56dd9d60);
}

// Namespace battlechatter/namespace_5232fbcc
// Params 2, eflags: 0x5 linked
// Checksum 0xc77f106f, Offset: 0x1660
// Size: 0x3c
function private function_fe2a1661(player, weapon) {
    if (!isdefined(weapon.var_5c238c21)) {
        return;
    }
    player function_4b6a650d(weapon);
}

