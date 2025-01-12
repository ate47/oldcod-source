#using scripts\abilities\ability_player;
#using scripts\abilities\ability_power;
#using scripts\abilities\ability_util;
#using scripts\core_common\burnplayer;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\damagefeedback_shared;
#using scripts\core_common\gamestate;
#using scripts\core_common\globallogic\globallogic_player;
#using scripts\core_common\laststand_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\persistence_shared;
#using scripts\core_common\player\player_role;
#using scripts\core_common\player\player_shared;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\rank_shared;
#using scripts\core_common\scoreevents_shared;
#using scripts\core_common\status_effects\status_effect_util;
#using scripts\core_common\util_shared;
#using scripts\killstreaks\killstreaks_shared;
#using scripts\killstreaks\killstreaks_util;
#using scripts\killstreaks\mp\killstreaks;
#using scripts\mp_common\armor;
#using scripts\mp_common\bb;
#using scripts\mp_common\gametypes\battlechatter;
#using scripts\mp_common\gametypes\globallogic;
#using scripts\mp_common\gametypes\globallogic_score;
#using scripts\mp_common\gametypes\globallogic_utils;
#using scripts\mp_common\player\player_loadout;
#using scripts\mp_common\player\player_utils;
#using scripts\mp_common\vehicle;
#using scripts\weapons\weapon_utils;
#using scripts\weapons\weapons;

#namespace player;

// Namespace player/player_damage
// Params 13, eflags: 0x0
// Checksum 0x1fcf1684, Offset: 0x3c8
// Size: 0xd64
function callback_playerdamage(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, boneindex, vsurfacenormal) {
    profilelog_begintiming(6, "ship");
    if (function_36a83afb(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, boneindex, vsurfacenormal)) {
        return;
    }
    if (self getinvulnerability()) {
        return;
    }
    do_post_game_damage(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, boneindex, vsurfacenormal);
    self.idflags = idflags;
    self.idflagstime = gettime();
    if (!isplayer(eattacker) && isdefined(eattacker) && eattacker.owner === self) {
        treat_self_damage_as_friendly_fire = eattacker.treat_owner_damage_as_friendly_fire;
    }
    ignore_round_start_friendly_fire = isdefined(einflictor) && smeansofdeath == "MOD_CRUSH" || smeansofdeath == "MOD_HIT_BY_OBJECT";
    eattacker = figure_out_attacker(eattacker);
    if (isplayer(eattacker) && isdefined(eattacker.laststand) && eattacker.laststand && einflictor === eattacker) {
        return;
    }
    smeansofdeath = modify_player_damage_meansofdeath(einflictor, eattacker, smeansofdeath, weapon, shitloc);
    if (!self should_do_player_damage(eattacker, einflictor, weapon, smeansofdeath, idflags)) {
        return;
    }
    update_attacker(einflictor, eattacker, smeansofdeath);
    weapon = function_b9e7109(weapon, einflictor);
    pixbeginevent(#"hash_5a86c546901702e2");
    if (!isdefined(vdir)) {
        idflags |= 4;
    }
    attackerishittingteammate = isplayer(eattacker) && self util::isenemyplayer(eattacker) == 0;
    attackerishittingself = isplayer(eattacker) && self == eattacker;
    friendlyfire = attackerishittingself && treat_self_damage_as_friendly_fire === 1 || level.teambased && !attackerishittingself && attackerishittingteammate;
    pixendevent();
    idamage = modify_player_damage(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex);
    if (friendlyfire) {
        idamage = modify_player_damage_friendlyfire(idamage);
    }
    if (shitloc == "riotshield") {
        riotshield_hit(einflictor, eattacker, idamage, smeansofdeath, weapon, attackerishittingteammate, vdir);
    }
    if (self does_player_completely_avoid_damage(idflags, shitloc, weapon, friendlyfire, attackerishittingself, smeansofdeath, vpoint, idamage, einflictor, eattacker)) {
        return;
    }
    armor_damage = apply_damage_to_armor(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, shitloc, friendlyfire, ignore_round_start_friendly_fire);
    idamage = armor_damage.idamage;
    idflags = armor_damage.idflags;
    if (isdefined(eattacker) && isplayer(eattacker) && !weapon_utils::ismeleemod(smeansofdeath)) {
        var_5af68402 = function_59c97a77(weapon, shitloc);
        idamage *= var_5af68402;
    }
    idamage = function_850ed92(eattacker, idamage, smeansofdeath, weapon, shitloc);
    idamage = make_sure_damage_is_not_zero(idamage, idflags & 2048);
    params = {#einflictor:einflictor, #eattacker:eattacker, #idamage:idamage, #smeansofdeath:smeansofdeath, #weapon:weapon, #vdir:vdir, #shitloc:shitloc};
    self callback::callback(#"on_player_damage", params);
    if (self laststand::player_is_in_laststand()) {
        self notify(#"laststand_damage", params);
        self.health++;
        idamage = 1;
    }
    if (shitloc == "riotshield") {
        shitloc = "none";
    }
    if (!function_1df04561(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex)) {
        return;
    }
    prevhealthratio = self.health / self.maxhealth;
    fatal = 0;
    if (friendlyfire) {
        pixmarker("BEGIN: PlayerDamage player");
        if (function_1595b674(ignore_round_start_friendly_fire)) {
            self.lastdamagewasfromenemy = 0;
            fatal = self function_47cfe95c(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, boneindex, vsurfacenormal);
        } else if (weapon.var_74d78f2e) {
            self function_3ce8b3bd(eattacker, einflictor, weapon, smeansofdeath, idamage);
        }
        if (function_4e73ead5(eattacker, ignore_round_start_friendly_fire)) {
            eattacker.lastdamagewasfromenemy = 0;
            eattacker.friendlydamage = 1;
            fatal = eattacker function_47cfe95c(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, boneindex, vsurfacenormal);
            eattacker.friendlydamage = undefined;
        }
        pixmarker("END: PlayerDamage player");
    } else {
        self.lastattackweapon = weapon;
        globallogic_player::giveattackerandinflictorownerassist(eattacker, einflictor, idamage, smeansofdeath, weapon);
        globallogic_player::function_5bc7cfdb(einflictor);
        if (isdefined(eattacker)) {
            level.lastlegitimateattacker = eattacker;
        }
        if ((smeansofdeath == "MOD_GRENADE" || smeansofdeath == "MOD_GRENADE_SPLASH") && isdefined(einflictor) && isdefined(einflictor.iscooked)) {
            self.wascooked = gettime();
        } else {
            self.wascooked = undefined;
        }
        self.lastdamagewasfromenemy = isdefined(eattacker) && eattacker != self;
        if (self.lastdamagewasfromenemy) {
            if (isplayer(eattacker)) {
                if (isdefined(eattacker.damagedplayers[self.clientid]) == 0) {
                    eattacker.damagedplayers[self.clientid] = spawnstruct();
                }
                eattacker.damagedplayers[self.clientid].time = gettime();
                eattacker.damagedplayers[self.clientid].entity = self;
            }
        }
        if (isplayer(eattacker) && isdefined(weapon.gadget_type) && weapon.gadget_type == 11) {
            if (isdefined(eattacker.heavyweaponhits)) {
                eattacker.heavyweaponhits++;
            }
        }
        fatal = self function_47cfe95c(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, boneindex, vsurfacenormal);
    }
    self.var_3f6353c8 = gettime();
    if (isdefined(eattacker) && !attackerishittingself && (isalive(eattacker) || eattacker util::isusingremote())) {
        if (damagefeedback::dodamagefeedback(weapon, einflictor, idamage, smeansofdeath)) {
            if (idamage > 0 && self.health > 0) {
                perkfeedback = function_60b88d75(self, weapon, smeansofdeath, einflictor, idflags & 2048);
            }
            eattacker thread damagefeedback::update(smeansofdeath, einflictor, perkfeedback, weapon, self, psoffsettime, shitloc, fatal, idflags);
        }
    }
    if (isalive(self)) {
        if (!isdefined(eattacker) || !friendlyfire || isdefined(level.hardcoremode) && level.hardcoremode) {
            self battlechatter::pain_vox(smeansofdeath, weapon);
        }
    }
    self.hasdonecombat = 1;
    if (weapon.isemp && smeansofdeath == "MOD_GRENADE_SPLASH" && !isdefined(weapon.var_9e990fe0)) {
        if (!self hasperk(#"specialty_immuneemp")) {
            self notify(#"emp_grenaded", {#attacker:eattacker, #position:vpoint});
        }
    }
    if (isdefined(eattacker) && eattacker != self && !friendlyfire) {
        level.usestartspawns = 0;
    }
    player_damage_log(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex);
    profilelog_endtiming(6, "gs=" + game.state);
}

// Namespace player/player_damage
// Params 5, eflags: 0x4
// Checksum 0x3f564e6, Offset: 0x1138
// Size: 0x180
function private function_850ed92(eattacker, idamage, smeansofdeath, weapon, shitloc) {
    if (isdefined(eattacker) && isplayer(eattacker) && smeansofdeath == "MOD_MELEE" && weapon_utils::ispunch(weapon) && eattacker hasperk(#"specialty_brawler")) {
        idamage += 20;
        new_health = eattacker.health + 20;
        eattacker.health = int(math::clamp(new_health, 0, max(eattacker.maxhealth, eattacker.var_63f2cd6e)));
        params = getstatuseffect(#"deaf_tinnitus");
        self status_effect::status_effect_apply(params, weapon, eattacker);
    }
    return idamage;
}

// Namespace player/player_damage
// Params 3, eflags: 0x4
// Checksum 0x86c3cd2a, Offset: 0x12c0
// Size: 0xb2
function private function_f61ab05e(einflictor, eattacker, weapon) {
    if (isplayer(einflictor)) {
        return true;
    }
    if (!isplayer(eattacker)) {
        return false;
    }
    if (isvehicle(einflictor)) {
        return false;
    }
    if (weapon.isprimary) {
        return true;
    }
    if (weapon.isheroweapon) {
        return true;
    }
    if (weapon.islauncher) {
        return true;
    }
    return false;
}

// Namespace player/player_damage
// Params 1, eflags: 0x4
// Checksum 0x76312a8b, Offset: 0x1380
// Size: 0x82
function private function_33cf2a09(var_cf021bb9) {
    var_4cdfb7ba = self.var_fbd793fb === gettime() ? self.var_2ab9c0eb : 0;
    var_a8b375f3 = int(max(var_cf021bb9, var_4cdfb7ba));
    self.var_2ab9c0eb = var_a8b375f3;
    self.var_fbd793fb = gettime();
    return var_a8b375f3;
}

// Namespace player/player_damage
// Params 13, eflags: 0x4
// Checksum 0x7b2be20f, Offset: 0x1410
// Size: 0x968
function private function_47cfe95c(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, boneindex, vsurfacenormal) {
    pixbeginevent(#"hash_161ca565ac88c256");
    if (!level.console && idflags & 8 && isplayer(eattacker)) {
        println("<dev string:x30>" + self getentitynumber() + "<dev string:x3c>" + self.health + "<dev string:x45>" + eattacker.clientid + "<dev string:x50>" + isplayer(einflictor) + "<dev string:x66>" + idamage + "<dev string:x6f>" + shitloc);
        eattacker stats::function_b48aa4e(#"penetration_shots", 1);
    }
    if (getdvarstring(#"scr_csmode") != "") {
        self shellshock(#"damage_mp", 0.2);
    }
    self function_3ce8b3bd(eattacker, einflictor, weapon, smeansofdeath, idamage);
    self ability_power::power_loss_event_took_damage(eattacker, einflictor, weapon, smeansofdeath, idamage);
    if (isplayer(eattacker)) {
        self.lastshotby = eattacker.clientid;
    }
    if (smeansofdeath == "MOD_BURNED") {
        self burnplayer::takingburndamage(eattacker, weapon, smeansofdeath);
    }
    self.gadget_was_active_last_damage = self gadgetisactive(0);
    isexplosivedamage = weapon_utils::isexplosivedamage(smeansofdeath);
    var_433a0062 = 0;
    if (isdefined(einflictor) && isdefined(einflictor.stucktoplayer) && einflictor.stucktoplayer == self) {
        var_433a0062 = 1;
    }
    if (isexplosivedamage && idamage > 0 && (weapon.explosioninnerdamage > 1 || isdefined(einflictor) && einflictor.var_6ea9a111 === 1)) {
        var_b79e6ae6 = status_effect::function_508e1a13(3);
        if (!var_433a0062 && weapon != getweapon(#"hero_pineapplegun")) {
            idamage = int(idamage * (1 - var_b79e6ae6));
        }
        var_219320f9 = getstatuseffect("explosive_damage");
        status_effect::status_effect_apply(var_219320f9, weapon, eattacker);
    }
    if (isdefined(eattacker) && self != eattacker) {
        damagedone = idamage;
        if (self.health < damagedone) {
            damagedone = self.health;
        }
        if (isplayer(eattacker)) {
            if (!isdefined(eattacker.damagedone)) {
                eattacker.damagedone = 0;
            }
            eattacker.damagedone += damagedone;
            eattacker.pers[#"damagedone"] = eattacker.damagedone;
        }
    }
    is_melee = weapon_utils::ismeleemod(smeansofdeath);
    var_beb2615e = function_d091841e(weapon, 6);
    var_ad4366d8 = isdefined(var_beb2615e) && !is_melee;
    dot_params = function_d091841e(weapon, 7);
    var_eddd2570 = isdefined(dot_params) && !is_melee;
    if ((isdefined(self.var_2334f41d) || var_ad4366d8) && self !== eattacker) {
        var_b26607ef = idamage;
        if (self.var_cf28d487 === gettime()) {
            var_b26607ef += self.var_b26607ef;
        }
        var_9c44b482 = max(self.maxhealth, self.health);
        var_cf021bb9 = var_9c44b482 - self.health + var_b26607ef;
        var_15b8b0a3 = self function_9a032249();
        var_8180bcf1 = var_9c44b482 - var_15b8b0a3;
        if (var_cf021bb9 > var_8180bcf1) {
            var_cf021bb9 = var_8180bcf1;
        }
        self.var_cf28d487 = gettime();
        self.var_b26607ef = var_b26607ef;
        if (isdefined(self.var_355829db)) {
            params = getstatuseffect("wound_radiation");
        } else if (isdefined(self.var_7c4064a2)) {
            params = getstatuseffect("shock_rifle_shock");
        } else if (var_eddd2570) {
            params = dot_params;
        } else if (var_ad4366d8) {
            params = var_beb2615e;
        } else {
            params = getstatuseffect("wound");
        }
        if (!(isdefined(params.var_39717de4) && params.var_39717de4) && (!isdefined(self.var_355829db) || self.var_355829db != self)) {
            params.var_e0987ab7 = smeansofdeath != "MOD_DOT";
            if (params.setype == 6) {
                params.var_a8b375f3 = function_33cf2a09(var_cf021bb9);
                params.var_e0987ab7 = 1;
                self.var_bffe7e05 = 1;
            }
            self status_effect::status_effect_apply(params, weapon, eattacker, 0);
            var_831fcd45 = params.setype == 6;
            if (var_eddd2570 && !var_831fcd45) {
                wound_params = var_ad4366d8 ? var_beb2615e : getstatuseffect("wound");
                wound_params.var_a8b375f3 = function_33cf2a09(var_cf021bb9);
                self.var_bffe7e05 = 1;
                self status_effect::status_effect_apply(wound_params, weapon, eattacker, 0);
            }
        }
        if (isdefined(params.var_2387104d) && params.var_2387104d) {
            vdir = undefined;
        }
    }
    fatal = self finishplayerdamage(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, boneindex, vsurfacenormal);
    if (self.var_bffe7e05 === 1) {
        self function_98fb2879();
        self.var_bffe7e05 = undefined;
    }
    pixendevent();
    return fatal;
}

// Namespace player/player_damage
// Params 11, eflags: 0x4
// Checksum 0xa12cf4c, Offset: 0x1d80
// Size: 0x40c
function private player_damage_log(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex) {
    pixbeginevent(#"playerdamage log");
    /#
        if (getdvarint(#"g_debugdamage", 0)) {
            println("<dev string:x78>" + self getentitynumber() + "<dev string:x3c>" + self.health + "<dev string:x45>" + eattacker.clientid + "<dev string:x50>" + isplayer(einflictor) + "<dev string:x66>" + idamage + "<dev string:x6f>" + shitloc);
        }
    #/
    if (self.sessionstate != "dead") {
        lpselfnum = self getentitynumber();
        lpselfname = self.name;
        lpselfteam = self.team;
        lpselfguid = self getguid();
        lpattackerteam = "";
        lpattackerorigin = (0, 0, 0);
        victimspecialist = function_b9650e7f(self player_role::get(), currentsessionmode());
        if (isplayer(eattacker)) {
            lpattacknum = eattacker getentitynumber();
            var_d9d6ccd3 = eattacker getxuid();
            lpattackguid = eattacker getguid();
            lpattackname = eattacker.name;
            lpattackerteam = eattacker.team;
            lpattackerorigin = eattacker.origin;
            isusingheropower = 0;
            attackerspecialist = function_b9650e7f(eattacker player_role::get(), currentsessionmode());
            if (eattacker ability_player::is_using_any_gadget()) {
                isusingheropower = 1;
            }
            bb::function_2384c738(eattacker, lpattackerorigin, attackerspecialist, weapon.name, self, self.origin, victimspecialist, self.currentweapon.name, idamage, smeansofdeath, shitloc, 0, isusingheropower, undefined);
        } else {
            lpattacknum = -1;
            var_d9d6ccd3 = 0;
            lpattackguid = "";
            lpattackname = "";
            lpattackerteam = "world";
            bb::function_2384c738(undefined, undefined, undefined, weapon.name, self, self.origin, undefined, undefined, idamage, smeansofdeath, shitloc, 0, 0, undefined);
        }
    }
    pixendevent();
}

// Namespace player/player_damage
// Params 1, eflags: 0x4
// Checksum 0xd2f49da2, Offset: 0x2198
// Size: 0x36
function private should_allow_postgame_damage(smeansofdeath) {
    if (smeansofdeath == "MOD_TRIGGER_HURT" || smeansofdeath == "MOD_CRUSH") {
        return true;
    }
    return false;
}

// Namespace player/player_damage
// Params 13, eflags: 0x4
// Checksum 0xcb8f364, Offset: 0x21d8
// Size: 0xe4
function private do_post_game_damage(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, boneindex, vsurfacenormal) {
    if (!gamestate::is_game_over()) {
        return;
    }
    if (!should_allow_postgame_damage(smeansofdeath)) {
        return;
    }
    self finishplayerdamage(einflictor, eattacker, idamage, idflags, "MOD_POST_GAME", weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, boneindex, vsurfacenormal);
}

// Namespace player/player_damage
// Params 13, eflags: 0x4
// Checksum 0x627b3162, Offset: 0x22c8
// Size: 0x148
function private function_36a83afb(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, boneindex, vsurfacenormal) {
    if (!gamestate::is_state("pregame")) {
        return false;
    }
    if (damagefeedback::dodamagefeedback(weapon, einflictor, idamage, smeansofdeath)) {
        if (idamage > 0) {
            perkfeedback = function_60b88d75(self, weapon, smeansofdeath, einflictor, idflags & 2048);
        }
        eattacker = figure_out_attacker(eattacker);
        if (isdefined(eattacker)) {
            eattacker thread damagefeedback::update(smeansofdeath, einflictor, perkfeedback, weapon, self, psoffsettime, shitloc, 0, idflags);
        }
    }
    return true;
}

// Namespace player/player_damage
// Params 5, eflags: 0x4
// Checksum 0x1247a341, Offset: 0x2418
// Size: 0x1ae
function private function_60b88d75(player, weapon, smeansofdeath, einflictor, armor_damaged) {
    perkfeedback = undefined;
    var_8c628e44 = player function_8c628e44();
    hasflakjacket = player hasperk(#"specialty_flakjacket");
    isexplosivedamage = weapon_utils::isexplosivedamage(smeansofdeath);
    isflashorstundamage = weapon_utils::isflashorstundamage(weapon, smeansofdeath);
    var_4beeafb5 = weapon_utils::isfiredamage(weapon, smeansofdeath);
    if (isflashorstundamage && var_8c628e44) {
        perkfeedback = "tacticalMask";
    } else if (player hasperk(#"specialty_fireproof") && weapon_utils::isfiredamage(weapon, smeansofdeath)) {
        perkfeedback = "flakjacket";
    } else if ((isexplosivedamage || var_4beeafb5) && hasflakjacket && !weapon.ignoresflakjacket && !function_c3925735(weapon, einflictor)) {
        perkfeedback = "flakjacket";
    } else if (armor_damaged) {
    }
    return perkfeedback;
}

// Namespace player/player_damage
// Params 2, eflags: 0x4
// Checksum 0xcf587f67, Offset: 0x25d0
// Size: 0x56
function private function_c3925735(weapon, einflictor) {
    if (weapon.isaikillstreakdamage) {
        if (weapon.name != "ai_tank_drone_rocket" || isdefined(einflictor.firedbyai)) {
            return true;
        }
    }
    return false;
}

// Namespace player/player_damage
// Params 10, eflags: 0x4
// Checksum 0xdd600189, Offset: 0x2630
// Size: 0x39e
function private does_player_completely_avoid_damage(idflags, shitloc, weapon, friendlyfire, attackerishittingself, smeansofdeath, vpoint, idamage, einflictor, eattacker) {
    if (idflags & 8192) {
        return false;
    }
    if (friendlyfire && level.friendlyfire == 0) {
        return true;
    }
    if (shitloc == "riotshield") {
        if (!(idflags & 160)) {
            return true;
        }
    }
    if (self.currentweapon == getweapon(#"sig_buckler_turret") && (smeansofdeath == "MOD_GRENADE" || smeansofdeath == "MOD_GRENADE_SPLASH" || smeansofdeath == "MOD_PROJECTILE_SPLASH" || smeansofdeath == "MOD_PROJECTILE" || weapon.type == "gas" && (smeansofdeath == "MOD_GAS" || smeansofdeath == "MOD_BURNED"))) {
        angles = self getplayerangles();
        forward = anglestoforward((0, angles[1], 0));
        var_199ac64c = weapon.statname == #"hero_flamethrower" && weapon.type == "gas" && (smeansofdeath == "MOD_GAS" || smeansofdeath == "MOD_BURNED");
        if (var_199ac64c && isdefined(eattacker) && false) {
            vpoint = eattacker.origin;
        }
        dirtoplayer = self.origin - vpoint;
        dir = vectornormalize((dirtoplayer[0], dirtoplayer[1], 0));
        dot = vectordot(forward, dir);
        dot_threshold = -0.7;
        if (var_199ac64c) {
            dot_threshold = getdvarfloat(#"hash_5225b2e88154efd5", -0.25);
        }
        if (dot < dot_threshold) {
            function_429bc719(einflictor, eattacker, idamage, weapon, getscriptbundle(self.currentweapon.customsettings));
            return true;
        }
    }
    if (weapon.isemp && smeansofdeath == "MOD_GRENADE_SPLASH") {
        if (self hasperk(#"specialty_immuneemp")) {
            return true;
        }
    }
    return false;
}

// Namespace player/player_damage
// Params 5, eflags: 0x0
// Checksum 0x46ee8fb4, Offset: 0x29d8
// Size: 0x2ac
function function_429bc719(einflictor, eattacker, idamage, weapon, customsettings) {
    previous_shield_damage = self.shielddamageblocked;
    self.shielddamageblocked += idamage;
    if (self.shielddamageblocked % 200 < previous_shield_damage % 200) {
        if (!isplayer(einflictor)) {
            if (!isdefined(einflictor.var_505bb4de)) {
                einflictor.var_505bb4de = [];
            }
            if (!isdefined(einflictor.var_505bb4de[self.clientid]) || einflictor.var_505bb4de[self.clientid].var_2b9ad42c != (isdefined(self.var_2b9ad42c) ? self.var_2b9ad42c : 0)) {
                info = spawnstruct();
                info.var_5a7ec9a1 = 1;
                info.var_2b9ad42c = isdefined(self.var_2b9ad42c) ? self.var_2b9ad42c : 0;
                einflictor.var_505bb4de[self.clientid] = info;
            } else {
                einflictor.var_505bb4de[self.clientid].var_5a7ec9a1++;
            }
        }
        var_14258547 = isdefined(customsettings.var_14258547) ? customsettings.var_14258547 : 0;
        if (isplayer(einflictor) || einflictor.var_505bb4de[self.clientid].var_5a7ec9a1 <= var_14258547) {
            score = rank::getscoreinfovalue("shield_blocked_damage");
            if (score > 0) {
                self stats::function_4f10b697(level.weaponriotshield, #"score_from_blocked_damage", score);
            }
            scoreevents::processscoreevent(#"shield_blocked_damage", self, undefined, self.currentweapon);
        }
        self battlechatter::function_b505bc94(self.currentweapon, eattacker, self.origin, weapon);
    }
}

// Namespace player/player_damage
// Params 7, eflags: 0x4
// Checksum 0x3325b140, Offset: 0x2c90
// Size: 0x1b4
function private riotshield_hit(einflictor, eattacker, idamage, smeansofdeath, weapon, attackerishittingteammate, vdir) {
    if ((smeansofdeath == "MOD_PISTOL_BULLET" || smeansofdeath == "MOD_RIFLE_BULLET" || smeansofdeath == "MOD_IMPACT") && !attackerishittingteammate) {
        currentweapon = self getcurrentweapon();
        if (currentweapon.isriotshield) {
            if (isplayer(eattacker)) {
                eattacker.lastattackedshieldplayer = self;
                eattacker.lastattackedshieldtime = gettime();
            }
            function_429bc719(einflictor, eattacker, idamage, weapon, getscriptbundle(currentweapon.customsettings));
            forward = anglestoforward(self getplayerangles());
            dot = vectordot(forward, vdir);
            if (dot < -0.8) {
                self status_effect::status_effect_apply(getstatuseffect("riotshield_hit_slow"), self.currentweapon, self, 0);
            }
        }
    }
}

// Namespace player/player_damage
// Params 3, eflags: 0x4
// Checksum 0x78bbb0aa, Offset: 0x2e50
// Size: 0x8a
function private function_298eaa7e(eattacker, etarget, weapon) {
    if (level.hardcoremode) {
        return 0;
    }
    if (!isdefined(eattacker) || !isdefined(etarget)) {
        return 0;
    }
    if (!isdefined(weapon)) {
        return 0;
    }
    if (isdefined(eattacker.script_owner) && eattacker.script_owner == etarget) {
        return weapon.donotdamageowner;
    }
    return 0;
}

// Namespace player/player_damage
// Params 5, eflags: 0x4
// Checksum 0x7ba4ad3f, Offset: 0x2ee8
// Size: 0x2e4
function private should_do_player_damage(eattacker, einflictor, weapon, smeansofdeath, idflags) {
    if (gamestate::is_game_over()) {
        return 0;
    }
    if (self.sessionteam == #"spectator") {
        return 0;
    }
    if (isdefined(self.candocombat) && !self.candocombat) {
        return 0;
    }
    if (isdefined(eattacker) && isplayer(eattacker) && isdefined(eattacker.candocombat) && !eattacker.candocombat) {
        return 0;
    }
    if (isdefined(level.hostmigrationtimer)) {
        return 0;
    }
    if (level.onlyheadshots) {
        if (smeansofdeath == "MOD_PISTOL_BULLET" || smeansofdeath == "MOD_RIFLE_BULLET") {
            return 0;
        }
    }
    if (isdefined(einflictor) && isactor(einflictor) && isdefined(einflictor.ai.var_8e5bbae5) && einflictor.ai.var_8e5bbae5 && einflictor.team === self.team) {
        return 0;
    }
    if (isdefined(eattacker) && isactor(eattacker) && isdefined(eattacker.ai.var_8e5bbae5) && eattacker.ai.var_8e5bbae5 && eattacker.team === self.team) {
        return 0;
    }
    if (self vehicle::player_is_occupant_invulnerable(eattacker, smeansofdeath)) {
        return 0;
    }
    if (weapon.issupplydropweapon && !weapon.isgrenadeweapon && smeansofdeath != "MOD_TRIGGER_HURT") {
        return 0;
    }
    if (self.scene_takedamage === 0) {
        return 0;
    }
    if (function_298eaa7e(einflictor, self, weapon)) {
        return 0;
    }
    if (idflags & 8 && self is_spawn_protected()) {
        return 0;
    }
    if (smeansofdeath == "MOD_CRUSH" && isdefined(einflictor) && einflictor.deal_no_crush_damage === 1) {
        return;
    }
    return 1;
}

// Namespace player/player_damage
// Params 9, eflags: 0x4
// Checksum 0x9facc30b, Offset: 0x31d8
// Size: 0x23c
function private apply_damage_to_armor(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, shitloc, friendlyfire, ignore_round_start_friendly_fire) {
    victim = self;
    if (friendlyfire && !function_1595b674(ignore_round_start_friendly_fire)) {
        return {#idflags:idflags, #idamage:idamage};
    }
    if (isdefined(einflictor) && isdefined(einflictor.stucktoplayer) && einflictor.stucktoplayer == victim) {
        return {#idflags:idflags, #idamage:victim.health};
    }
    armor = self armor::get_armor();
    gear_armor = self.armor;
    self.var_dec85f5f = undefined;
    idamage = victim armor::apply_damage(weapon, idamage, smeansofdeath, eattacker);
    idamage = victim armor::function_ccf62ba6(einflictor, eattacker, idamage, smeansofdeath, weapon, shitloc);
    armor_damaged = armor != self armor::get_armor();
    if (armor_damaged) {
        idflags |= 2048;
        if (gear_armor > 0 && self.armor <= 0) {
            self.var_dec85f5f = 1;
        }
    }
    if (isdefined(self.power_armor_took_damage) && self.power_armor_took_damage) {
        idflags |= 1024;
    }
    return {#idflags:idflags, #idamage:idamage};
}

// Namespace player/player_damage
// Params 2, eflags: 0x4
// Checksum 0xac7ad216, Offset: 0x3420
// Size: 0xb2
function private make_sure_damage_is_not_zero(idamage, armor_damaged) {
    if (idamage < 1) {
        if ((armor_damaged || self ability_util::gadget_power_armor_on() || self armor::has_armor()) && isdefined(self.maxhealth) && self.health < self.maxhealth) {
            self.health += 1;
        }
        idamage = 1;
    }
    return int(idamage);
}

// Namespace player/player_damage
// Params 1, eflags: 0x4
// Checksum 0xfff85f, Offset: 0x34e0
// Size: 0x6a
function private modify_player_damage_friendlyfire(idamage) {
    friendlyfire = [[ level.figure_out_friendly_fire ]](self);
    if (friendlyfire == 2 || friendlyfire == 3) {
        idamage = int(idamage * 0.5);
    }
    return idamage;
}

// Namespace player/player_damage
// Params 0, eflags: 0x0
// Checksum 0x4cead48, Offset: 0x3558
// Size: 0x98
function function_7668acc6() {
    if (self isinvehicle()) {
        vehicle = self getvehicleoccupied();
        if (isdefined(vehicle) && isdefined(vehicle.overrideplayerdamage)) {
            return vehicle.overrideplayerdamage;
        }
    }
    if (isdefined(self.overrideplayerdamage)) {
        return self.overrideplayerdamage;
    }
    if (isdefined(level.overrideplayerdamage)) {
        return level.overrideplayerdamage;
    }
}

// Namespace player/player_damage
// Params 11, eflags: 0x4
// Checksum 0xb69436b3, Offset: 0x35f8
// Size: 0x43a
function private modify_player_damage(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex) {
    overrideplayerdamage = function_7668acc6();
    if (isdefined(overrideplayerdamage)) {
        idamage = self [[ overrideplayerdamage ]](einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex);
    }
    assert(isdefined(idamage), "<dev string:x80>");
    if (isdefined(eattacker)) {
        idamage = loadout::cac_modified_damage(self, eattacker, idamage, smeansofdeath, weapon, einflictor, shitloc);
        if (isdefined(eattacker.pickup_damage_scale) && eattacker.pickup_damage_scale_time > gettime()) {
            idamage *= eattacker.pickup_damage_scale;
        }
    }
    idamage = custom_gamemodes_modified_damage(self, eattacker, idamage, smeansofdeath, weapon, einflictor, shitloc);
    if (level.onplayerdamage != &globallogic::blank) {
        modifieddamage = [[ level.onplayerdamage ]](einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime);
        if (isdefined(modifieddamage)) {
            if (modifieddamage <= 0) {
                return;
            }
            idamage = modifieddamage;
        }
    }
    if (level.onlyheadshots) {
        if (smeansofdeath == "MOD_HEAD_SHOT") {
            idamage = 150;
        }
    }
    if (weapon.damagealwayskillsplayer) {
        idamage = self.maxhealth + 1;
    }
    if (shitloc == "riotshield") {
        if (idflags & 32) {
            if (!(idflags & 64)) {
                idamage *= 0;
            }
        } else if (idflags & 128) {
            if (isdefined(einflictor) && isdefined(einflictor.stucktoplayer) && einflictor.stucktoplayer == self) {
                idamage = self.maxhealth + 1;
            }
        }
    }
    if (self.currentweapon == getweapon(#"sig_buckler_dw") && (smeansofdeath == "MOD_GRENADE" || smeansofdeath == "MOD_GRENADE_SPLASH" || smeansofdeath == "MOD_PROJECTILE_SPLASH" || smeansofdeath == "MOD_PROJECTILE")) {
        angles = self getplayerangles();
        forward = anglestoforward((0, angles[1], 0));
        dirtoplayer = self.origin - vpoint;
        dir = vectornormalize((dirtoplayer[0], dirtoplayer[1], 0));
        dot = vectordot(forward, dir);
        if (dot < -0.7) {
            idamage *= weapon.var_b61c6973;
        }
    }
    return int(idamage);
}

// Namespace player/player_damage
// Params 5, eflags: 0x4
// Checksum 0xf5cbfdda, Offset: 0x3a40
// Size: 0xd2
function private modify_player_damage_meansofdeath(einflictor, eattacker, smeansofdeath, weapon, shitloc) {
    if (globallogic_utils::isheadshot(weapon, shitloc, smeansofdeath, einflictor) && isplayer(eattacker) && !weapon_utils::ismeleemod(smeansofdeath)) {
        smeansofdeath = "MOD_HEAD_SHOT";
    }
    if (isdefined(einflictor) && isdefined(einflictor.script_noteworthy)) {
        if (einflictor.script_noteworthy == "ragdoll_now") {
            smeansofdeath = "MOD_FALLING";
        }
    }
    return smeansofdeath;
}

// Namespace player/player_damage
// Params 3, eflags: 0x4
// Checksum 0x8be2840a, Offset: 0x3b20
// Size: 0xb2
function private update_attacker(einflictor, eattacker, smeansofdeath) {
    if (isplayer(eattacker)) {
        if (isdefined(einflictor) && eattacker == einflictor) {
            if (smeansofdeath == "MOD_HEAD_SHOT" || smeansofdeath == "MOD_PISTOL_BULLET" || smeansofdeath == "MOD_RIFLE_BULLET") {
                eattacker.hits++;
            }
        }
        eattacker.pers[#"participation"]++;
    }
}

// Namespace player/player_damage
// Params 3, eflags: 0x4
// Checksum 0xb08306ea, Offset: 0x3be0
// Size: 0x13e
function private function_80814219(einflictor, weapon, smeansofdeath) {
    if (!self is_spawn_protected()) {
        return false;
    }
    if (weapon.explosionradius == 0) {
        return false;
    }
    distsqr = isdefined(einflictor) && isdefined(self.lastspawnpoint) ? distancesquared(einflictor.origin, self.lastspawnpoint.origin) : 0;
    if (distsqr < 250 * 250) {
        if (smeansofdeath == "MOD_GRENADE" || smeansofdeath == "MOD_GRENADE_SPLASH") {
            return true;
        }
        if (smeansofdeath == "MOD_PROJECTILE" || smeansofdeath == "MOD_PROJECTILE_SPLASH") {
            return true;
        }
        if (smeansofdeath == "MOD_EXPLOSIVE") {
            return true;
        }
    }
    if (killstreaks::is_killstreak_weapon(weapon)) {
        return true;
    }
    return false;
}

// Namespace player/player_damage
// Params 11, eflags: 0x4
// Checksum 0x2b3a6293, Offset: 0x3d28
// Size: 0x62a
function private function_1df04561(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex) {
    is_explosive_damage = weapon_utils::isexplosivedamage(smeansofdeath);
    if (is_explosive_damage) {
        if (self function_80814219(einflictor, weapon, smeansofdeath)) {
            return false;
        }
        if (self function_31163d36(eattacker, weapon)) {
            return false;
        }
    }
    if (isdefined(einflictor) && (smeansofdeath == "MOD_GAS" || is_explosive_damage)) {
        self.explosiveinfo = [];
        self.explosiveinfo[#"damagetime"] = gettime();
        self.explosiveinfo[#"damageid"] = einflictor getentitynumber();
        self.explosiveinfo[#"originalownerkill"] = 0;
        self.explosiveinfo[#"bulletpenetrationkill"] = 0;
        self.explosiveinfo[#"chainkill"] = 0;
        self.explosiveinfo[#"damageexplosivekill"] = 0;
        self.explosiveinfo[#"chainkill"] = 0;
        self.explosiveinfo[#"cookedkill"] = 0;
        self.explosiveinfo[#"weapon"] = weapon;
        self.explosiveinfo[#"originalowner"] = einflictor.originalowner;
        isfrag = weapon.rootweapon.name == "frag_grenade";
        if (isdefined(eattacker) && eattacker != self) {
            if (isdefined(eattacker) && isdefined(einflictor.owner) && (weapon.name == #"satchel_charge" || weapon.name == #"claymore" || weapon.name == #"bouncingbetty")) {
                self.explosiveinfo[#"originalownerkill"] = einflictor.owner == self;
                self.explosiveinfo[#"damageexplosivekill"] = isdefined(einflictor.wasdamaged);
                self.explosiveinfo[#"chainkill"] = isdefined(einflictor.waschained);
                self.explosiveinfo[#"wasjustplanted"] = isdefined(einflictor.wasjustplanted);
                self.explosiveinfo[#"bulletpenetrationkill"] = isdefined(einflictor.wasdamagedfrombulletpenetration);
                self.explosiveinfo[#"cookedkill"] = 0;
            }
            if (isdefined(einflictor) && isdefined(einflictor.stucktoplayer) && weapon.projexplosiontype == "grenade") {
                self.explosiveinfo[#"stucktoplayer"] = einflictor.stucktoplayer;
            }
            if (weapon.dostun) {
                self.laststunnedby = eattacker;
                self.laststunnedtime = self.idflagstime;
            }
            if (isdefined(eattacker.lastgrenadesuicidetime) && eattacker.lastgrenadesuicidetime >= gettime() - 50 && isfrag) {
                self.explosiveinfo[#"suicidegrenadekill"] = 1;
            } else {
                self.explosiveinfo[#"suicidegrenadekill"] = 0;
            }
        }
        if (isfrag) {
            self.explosiveinfo[#"cookedkill"] = isdefined(einflictor.iscooked);
            self.explosiveinfo[#"throwbackkill"] = isdefined(einflictor.threwback);
        }
        if (isdefined(eattacker) && isplayer(eattacker) && eattacker != self) {
            self globallogic_score::setinflictorstat(einflictor, eattacker, weapon);
        }
    }
    if (smeansofdeath == "MOD_IMPACT" && isdefined(eattacker) && isplayer(eattacker) && eattacker != self) {
        if (weapon != level.weaponballisticknife) {
            self globallogic_score::setinflictorstat(einflictor, eattacker, weapon);
        }
        if (weapon.rootweapon.name == "hatchet" && isdefined(einflictor)) {
            self.explosiveinfo[#"projectile_bounced"] = isdefined(einflictor.bounced);
        }
    }
    return true;
}

// Namespace player/player_damage
// Params 0, eflags: 0x4
// Checksum 0x2edf88a8, Offset: 0x4360
// Size: 0x5c
function private function_ac661458() {
    if (level.friendlyfiredelay && level.friendlyfiredelaytime >= float(gettime() - level.starttime - level.discardtime) / 1000) {
        return true;
    }
    return false;
}

// Namespace player/player_damage
// Params 2, eflags: 0x4
// Checksum 0xa36b3f2, Offset: 0x43c8
// Size: 0xac
function private function_4e73ead5(eattacker, ignore_round_start_friendly_fire) {
    if (!isalive(eattacker)) {
        return false;
    }
    friendlyfire = [[ level.figure_out_friendly_fire ]](self);
    if (friendlyfire == 1) {
        if (function_ac661458() && ignore_round_start_friendly_fire == 0) {
            return true;
        }
    }
    if (friendlyfire == 2) {
        return true;
    }
    if (friendlyfire == 3) {
        return true;
    }
    return false;
}

// Namespace player/player_damage
// Params 1, eflags: 0x0
// Checksum 0x6c3a8ca4, Offset: 0x4480
// Size: 0x7c
function function_1595b674(ignore_round_start_friendly_fire) {
    friendlyfire = [[ level.figure_out_friendly_fire ]](self);
    if (friendlyfire == 1) {
        if (function_ac661458() && ignore_round_start_friendly_fire == 0) {
            return false;
        }
        return true;
    }
    if (friendlyfire == 3) {
        return true;
    }
    return false;
}

// Namespace player/player_damage
// Params 2, eflags: 0x4
// Checksum 0xd7da3dfe, Offset: 0x4508
// Size: 0x4e
function private function_31163d36(eattacker, weapon) {
    if (level.hardcoremode) {
        return 0;
    }
    if (!isdefined(eattacker)) {
        return 0;
    }
    if (self != eattacker) {
        return 0;
    }
    return weapon.donotdamageowner;
}

// Namespace player/player_damage
// Params 2, eflags: 0x4
// Checksum 0x80af0004, Offset: 0x4560
// Size: 0x17a
function private function_b9e7109(weapon, einflictor) {
    if (weapon == level.weaponnone && isdefined(einflictor)) {
        if (isdefined(einflictor.targetname) && einflictor.targetname == "explodable_barrel") {
            weapon = getweapon(#"explodable_barrel");
        } else if (isdefined(einflictor.destructible_type) && issubstr(einflictor.destructible_type, "vehicle_")) {
            weapon = getweapon(#"destructible_car");
        } else if (isdefined(einflictor.scriptvehicletype)) {
            veh_weapon = getweapon(einflictor.scriptvehicletype);
            if (isdefined(veh_weapon)) {
                weapon = veh_weapon;
            }
        }
    }
    if (isdefined(einflictor) && isdefined(einflictor.script_noteworthy)) {
        if (isdefined(level.overrideweaponfunc)) {
            weapon = [[ level.overrideweaponfunc ]](weapon, einflictor.script_noteworthy);
        }
    }
    return weapon;
}

// Namespace player/player_damage
// Params 7, eflags: 0x4
// Checksum 0x79db1ddb, Offset: 0x46e8
// Size: 0xe2
function private custom_gamemodes_modified_damage(victim, eattacker, idamage, smeansofdeath, weapon, einflictor, shitloc) {
    if (level.onlinegame && !sessionmodeisprivate()) {
        return idamage;
    }
    if (isdefined(eattacker) && isdefined(eattacker.damagemodifier)) {
        idamage *= eattacker.damagemodifier;
    }
    if (smeansofdeath == "MOD_PISTOL_BULLET" || smeansofdeath == "MOD_RIFLE_BULLET") {
        idamage = int(idamage * level.bulletdamagescalar);
    }
    return idamage;
}

// Namespace player/player_damage
// Params 5, eflags: 0x4
// Checksum 0xbfe4d6bc, Offset: 0x47d8
// Size: 0x11e
function private function_3ce8b3bd(eattacker, einflictor, weapon, smeansofdeath, idamage) {
    self thread weapons::on_damage(eattacker, einflictor, weapon, smeansofdeath, idamage);
    if (!self util::isusingremote()) {
        if (smeansofdeath != "MOD_DOT" && smeansofdeath != "MOD_DOT_SELF") {
            if (!isdefined(self.var_c4f15783) || gettime() > self.var_c4f15783) {
                self playrumbleonentity("damage_heavy");
                self.var_c4f15783 = gettime();
            }
            return;
        }
        if (!isdefined(self.var_7e8a632b) || gettime() > self.var_7e8a632b) {
            self playrumbleonentity("damage_light");
            self.var_7e8a632b = gettime();
        }
    }
}

