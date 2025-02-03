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
// Checksum 0x5e0e5937, Offset: 0x170
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
// Checksum 0x1adcb6d8, Offset: 0x200
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
// Checksum 0x66c5a217, Offset: 0x278
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
// Checksum 0x120e5918, Offset: 0x340
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
// Checksum 0x665e67bb, Offset: 0x3e0
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
// Checksum 0xec3cc981, Offset: 0x6a0
// Size: 0x642
function event_handler[event_bf57d5bb] function_4540ef25(*eventstruct) {
    if (!function_e1983f22()) {
        return;
    }
    if (!is_true(level.teambased)) {
        return;
    }
    if (self hasperk(#"specialty_quieter")) {
        return;
    }
    if (!isdefined(self.enemythreattime) || self.enemythreattime + int(mpdialog_value("enemyContactInterval", 0) * 1000) >= gettime()) {
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
// Checksum 0x12f5314b, Offset: 0xcf0
// Size: 0x254
function event_handler[grenade_stuck] function_de1402a2(eventstruct) {
    if (!function_e1983f22()) {
        return;
    }
    grenade = eventstruct.projectile;
    if (!isdefined(grenade) || !isdefined(grenade.weapon)) {
        return;
    }
    grenadeweaponbundle = function_cdd81094(grenade.weapon);
    if (!isdefined(grenadeweaponbundle)) {
        return;
    }
    if (!isdefined(eventstruct.hitent) || !isplayer(eventstruct.hitent)) {
        return;
    }
    if (isplayer(self)) {
        var_296bb9e8 = function_e05060f0(self);
        var_89d36f8a = isalive(self) && !self hasperk(#"specialty_quieter");
        if (isdefined(var_296bb9e8) && isdefined(grenadeweaponbundle.var_488f1315) && var_89d36f8a) {
            dialogalias = var_296bb9e8 + grenadeweaponbundle.var_488f1315;
            self thread function_a48c33ff(dialogalias, 6);
        }
    }
    var_cc5e757a = function_e05060f0(eventstruct.hitent);
    var_3fca87ae = isalive(eventstruct.hitent) && !self hasperk(#"specialty_quieter");
    if (isdefined(var_cc5e757a) && isdefined(grenadeweaponbundle.var_f4196077) && var_3fca87ae) {
        dialogalias = var_cc5e757a + grenadeweaponbundle.var_f4196077;
        eventstruct.hitent thread function_a48c33ff(dialogalias, 6);
    }
}

// Namespace battlechatter/namespace_5232fbcc
// Params 5, eflags: 0x4
// Checksum 0xd2820796, Offset: 0xf50
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
    if (isdefined(ally) && distancesquared(self.origin, ally.origin) < sqr(allyradius)) {
        ally playkillstreakthreat(killstreaktype);
        mod.var_95b0150d = gettime();
    }
}

// Namespace battlechatter/namespace_5232fbcc
// Params 4, eflags: 0x4
// Checksum 0xa91c8960, Offset: 0x10e0
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
        if (killstreaks::function_c5927b3f(var_3ac7db5) && self util::isenemyplayer(attacker)) {
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
// Checksum 0x451a94c6, Offset: 0x1368
// Size: 0xe4
function event_handler[player_killed] onplayerkilled(eventstruct) {
    if (!function_e1983f22()) {
        return;
    }
    attacker = eventstruct.attacker;
    inflictor = eventstruct.inflictor;
    weapon = eventstruct.weapon;
    mod = eventstruct.mod;
    if (!is_true(level.teambased) || !is_true(level.allowspecialistdialog)) {
        return;
    }
    if (self === attacker) {
        return;
    }
    self thread function_b18b0b7b(attacker, inflictor, weapon, mod);
}

// Namespace battlechatter/namespace_5232fbcc
// Params 3, eflags: 0x0
// Checksum 0x2315d486, Offset: 0x1458
// Size: 0x2ea
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
    wait isdefined(var_7d44e33d.var_613ebcfa) ? var_7d44e33d.var_613ebcfa : 0.1;
    incomingprojectileradius = mpdialog_value("incomingProjectileRadius", 0);
    players = self getenemiesinradius(projectile.origin, incomingprojectileradius);
    var_3c0b0429 = (0, 0, thrower getplayerviewheight());
    foreach (player in players) {
        if (isplayer(player) && isalive(player) && !player hasperk(#"specialty_quieter") && isdefined(weapon)) {
            var_55ed76f0 = player.origin + var_3c0b0429;
            var_f8a966ea = projectile.origin - var_55ed76f0;
            dirforward = anglestoforward(player getplayerangles());
            dotproduct = vectordot(var_f8a966ea, dirforward);
            if (dotproduct > 0) {
                if (sighttracepassed(var_55ed76f0, projectile.origin, 1, player, projectile)) {
                    if (player function_bafe1ee4(weapon)) {
                        return;
                    }
                }
            }
        }
        waitframe(1);
    }
}

// Namespace battlechatter/namespace_5232fbcc
// Params 3, eflags: 0x4
// Checksum 0xbd91ab13, Offset: 0x1750
// Size: 0x44
function private function_26ab78d1(player, weapon, *weaponinstance) {
    if (!isdefined(weaponinstance.var_5c238c21)) {
        return;
    }
    weapon function_26dd1669(weaponinstance);
}

// Namespace battlechatter/namespace_5232fbcc
// Params 2, eflags: 0x4
// Checksum 0x3f3e36c6, Offset: 0x17a0
// Size: 0x3c
function private function_fe2a1661(player, weapon) {
    if (!isdefined(weapon.var_5c238c21)) {
        return;
    }
    player function_4b6a650d(weapon);
}

