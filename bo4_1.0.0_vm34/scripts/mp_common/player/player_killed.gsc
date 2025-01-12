#using scripts\abilities\ability_player;
#using scripts\core_common\array_shared;
#using scripts\core_common\audio_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\challenges_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\demo_shared;
#using scripts\core_common\gamestate;
#using scripts\core_common\globallogic\globallogic_player;
#using scripts\core_common\globallogic\globallogic_score;
#using scripts\core_common\globallogic\globallogic_vehicle;
#using scripts\core_common\hostmigration_shared;
#using scripts\core_common\killcam_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\medals_shared;
#using scripts\core_common\persistence_shared;
#using scripts\core_common\player\player_role;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\potm_shared;
#using scripts\core_common\rank_shared;
#using scripts\core_common\scoreevents_shared;
#using scripts\core_common\spectating;
#using scripts\core_common\tweakables_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\core_common\weapons_shared;
#using scripts\killstreaks\killstreak_bundles;
#using scripts\killstreaks\killstreaks_shared;
#using scripts\killstreaks\killstreaks_util;
#using scripts\killstreaks\mp\killstreaks;
#using scripts\mp_common\bb;
#using scripts\mp_common\challenges;
#using scripts\mp_common\gametypes\battlechatter;
#using scripts\mp_common\gametypes\deathicons;
#using scripts\mp_common\gametypes\display_transition;
#using scripts\mp_common\gametypes\globallogic;
#using scripts\mp_common\gametypes\globallogic_audio;
#using scripts\mp_common\gametypes\globallogic_score;
#using scripts\mp_common\gametypes\globallogic_spawn;
#using scripts\mp_common\gametypes\globallogic_utils;
#using scripts\mp_common\player\player_loadout;
#using scripts\mp_common\player\player_record;
#using scripts\mp_common\player\player_utils;
#using scripts\mp_common\teams\teams;
#using scripts\mp_common\userspawnselection;
#using scripts\mp_common\util;
#using scripts\weapons\weapon_utils;
#using scripts\weapons\weapons;

#namespace player;

// Namespace player/player_killed
// Params 3, eflags: 0x0
// Checksum 0x960fef74, Offset: 0x5f8
// Size: 0x2a6
function function_738be268(attacker, weapon, mod) {
    if (isdefined(weapon)) {
        var_8e6b7ed0 = weapons::getbaseweapon(weapon);
        baseweaponindex = getbaseweaponitemindex(var_8e6b7ed0);
        self clientfield::set_player_uimodel("huditems.killedByItemIndex", baseweaponindex);
    } else {
        self clientfield::set_player_uimodel("huditems.killedByItemIndex", 0);
    }
    if (isdefined(attacker)) {
        self clientfield::set_player_uimodel("huditems.killedByEntNum", attacker getentitynumber());
    } else {
        self clientfield::set_player_uimodel("huditems.killedByEntNum", 15);
    }
    if (isdefined(mod)) {
        modindex = function_eee1f896(mod);
        if (mod != "MOD_META") {
            if (attacker === self) {
                modindex = function_eee1f896("MOD_SUICIDE");
            } else if (weapon === level.weaponnone) {
                modindex = function_eee1f896("MOD_UNKNOWN");
                self clientfield::set_player_uimodel("huditems.killedByEntNum", self.entnum);
            }
        }
        self clientfield::set_player_uimodel("huditems.killedByMOD", modindex);
    } else {
        self clientfield::set_player_uimodel("huditems.killedByEntNum", 15);
    }
    attachments = function_3bc0f47d(weapon);
    self clientfield::set_player_uimodel("huditems.killedByAttachmentCount", attachments.size);
    for (var_ce3eccb8 = 0; var_ce3eccb8 < attachments.size && var_ce3eccb8 < 5; var_ce3eccb8++) {
        self clientfield::set_player_uimodel("huditems.killedByAttachment" + var_ce3eccb8, attachments[var_ce3eccb8]);
    }
}

// Namespace player/player_killed
// Params 1, eflags: 0x0
// Checksum 0xdc5ad781, Offset: 0x8a8
// Size: 0x216
function function_788365ad(attacker) {
    if (isdefined(self.attackers)) {
        for (j = 0; j < self.attackers.size; j++) {
            player = self.attackers[j];
            if (!isdefined(player)) {
                continue;
            }
            if (isdefined(attacker) && player.team != attacker.team) {
                continue;
            }
            if (self.attackerdamage[player.clientid].damage == 0) {
                continue;
            }
            if (isdefined(level.ekiaresetondeath) && level.ekiaresetondeath && isdefined(player.deathtime) && player.deathtime > self.attackerdamage[player.clientid].lastdamagetime) {
                continue;
            }
            if (isdefined(level.var_48797d5) && gettime() > int(level.var_48797d5 * 1000) + self.attackerdamage[player.clientid].lastdamagetime) {
                continue;
            }
            damage_done = self.attackerdamage[player.clientid].damage;
            einflictor = self.attackerdamage[player.clientid].einflictor;
            weapon = self.attackerdamage[player.clientid].weapon;
            player function_47f05a51(einflictor, self, damage_done, weapon);
        }
    }
}

// Namespace player/player_killed
// Params 3, eflags: 0x0
// Checksum 0x4811408, Offset: 0xac8
// Size: 0x246
function function_6697047(attacker, meansofdeath, bledout = 0) {
    if (isdefined(self.attackers) && isdefined(attacker)) {
        for (j = 0; j < self.attackers.size; j++) {
            player = self.attackers[j];
            if (!isdefined(player)) {
                continue;
            }
            if (player.team != attacker.team) {
                continue;
            }
            if (self.attackerdamage[player.clientid].damage == 0) {
                continue;
            }
            if (isdefined(level.ekiaresetondeath) && level.ekiaresetondeath && isdefined(player.deathtime) && player.deathtime > self.attackerdamage[player.clientid].lastdamagetime) {
                continue;
            }
            if (isdefined(level.var_48797d5) && gettime() > int(level.var_48797d5 * 1000) + self.attackerdamage[player.clientid].lastdamagetime && !bledout) {
                continue;
            }
            einflictor = self.attackerdamage[player.clientid].einflictor;
            weapon = self.attackerdamage[player.clientid].weapon;
            if (player != attacker) {
                meansofdeath = self.attackerdamage[player.clientid].meansofdeath;
            }
            self function_274535aa(einflictor, player, meansofdeath, weapon, attacker);
        }
    }
}

// Namespace player/player_killed
// Params 10, eflags: 0x0
// Checksum 0x787fe1a4, Offset: 0xd18
// Size: 0x2afe
function callback_playerkilled(einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration, enteredresurrect = 0) {
    profilelog_begintiming(7, "ship");
    self endon(#"spawned");
    self.var_b3f9ddd4 = smeansofdeath == "MOD_META";
    if (gamestate::is_game_over()) {
        post_game_death(einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration);
        return;
    }
    if (self.sessionteam == #"spectator") {
        return;
    }
    self needsrevive(0);
    if (isdefined(self.burning) && self.burning == 1) {
        self setburn(0);
    }
    self.suicide = 0;
    self.teamkilled = 0;
    countdeath = !(isdefined(self.var_b9e04d0b) && self.var_b9e04d0b) && !self.var_b3f9ddd4;
    if (countdeath) {
        level.deaths[self.team]++;
        self.var_b1f81f5d++;
    }
    function_a44a3d04();
    self callback::callback(#"on_player_killed");
    attacker callback::callback(#"on_killed_player");
    self thread globallogic_audio::flush_leader_dialog_key_on_player("equipmentDestroyed");
    weapon = update_weapon(einflictor, weapon);
    pixbeginevent(#"hash_47eb123ec5413349");
    self thread audio::function_11607c82(attacker, smeansofdeath, weapon);
    wasinlaststand = 0;
    bledout = 0;
    deathtimeoffset = 0;
    var_a3ad44ab = undefined;
    attackerstance = undefined;
    self.laststandthislife = undefined;
    self.vattackerorigin = undefined;
    self function_738be268(attacker, weapon, smeansofdeath);
    weapon_at_time_of_death = self getcurrentweapon();
    if (isdefined(self.uselaststandparams) && enteredresurrect == 0) {
        self.uselaststandparams = undefined;
        assert(isdefined(self.laststandparams));
        if (!level.teambased || !isdefined(attacker) || !isplayer(attacker) || attacker.team != self.team || attacker == self) {
            einflictor = self.laststandparams.einflictor;
            attacker = self.laststandparams.attacker;
            attackerstance = self.laststandparams.attackerstance;
            idamage = self.laststandparams.idamage;
            smeansofdeath = self.laststandparams.smeansofdeath;
            weapon = self.laststandparams.sweapon;
            vdir = self.laststandparams.vdir;
            shitloc = self.laststandparams.shitloc;
            self.vattackerorigin = self.laststandparams.vattackerorigin;
            self.killcam_entity_info_cached = self.laststandparams.killcam_entity_info_cached;
            if (!(isdefined(self.laststandparams.var_3c2026c5) && self.laststandparams.var_3c2026c5)) {
                deathtimeoffset = float(gettime() - self.laststandparams.laststandstarttime) / 1000;
            }
            bledout = self.laststandparams.bledout;
            if (isdefined(self.var_54a2d6ec)) {
                wasinlaststand = 1;
                var_a3ad44ab = self.var_54a2d6ec;
            }
        }
        self.laststandparams = undefined;
    }
    params = {#einflictor:einflictor, #eattacker:attacker, #idamage:idamage, #smeansofdeath:smeansofdeath, #weapon:weapon, #vdir:vdir, #shitloc:shitloc, #psoffsettime:psoffsettime, #deathanimduration:deathanimduration};
    self callback::callback(#"on_player_killed_with_params", params);
    self stopsounds();
    bestplayer = undefined;
    bestplayermeansofdeath = undefined;
    obituarymeansofdeath = undefined;
    bestplayerweapon = undefined;
    obituaryweapon = weapon;
    assistedsuicide = 0;
    if ((!isdefined(attacker) || attacker.classname == "trigger_hurt_new" || attacker.classname == "worldspawn" || isdefined(attacker.ismagicbullet) && attacker.ismagicbullet == 1 || attacker == self) && isdefined(self.attackers)) {
        if (!isdefined(bestplayer)) {
            for (i = 0; i < self.attackers.size; i++) {
                player = self.attackers[i];
                if (!isdefined(player)) {
                    continue;
                }
                if (!isdefined(self.attackerdamage[player.clientid]) || !isdefined(self.attackerdamage[player.clientid].damage)) {
                    continue;
                }
                if (player == self || level.teambased && player.team == self.team) {
                    continue;
                }
                if (isdefined(level.var_48797d5) && gettime() > int(level.var_48797d5 * 1000) + self.attackerdamage[player.clientid].lastdamagetime) {
                    continue;
                }
                if (!globallogic_player::allowedassistweapon(self.attackerdamage[player.clientid].weapon)) {
                    continue;
                }
                if (self.attackerdamage[player.clientid].damage > 1 && !isdefined(bestplayer)) {
                    bestplayer = player;
                    bestplayermeansofdeath = self.attackerdamage[player.clientid].meansofdeath;
                    bestplayerweapon = self.attackerdamage[player.clientid].weapon;
                    continue;
                }
                if (isdefined(bestplayer) && self.attackerdamage[player.clientid].damage > self.attackerdamage[bestplayer.clientid].damage) {
                    bestplayer = player;
                    bestplayermeansofdeath = self.attackerdamage[player.clientid].meansofdeath;
                    bestplayerweapon = self.attackerdamage[player.clientid].weapon;
                }
            }
        }
        if (isdefined(bestplayer)) {
            scoreevents::processscoreevent(#"assisted_suicide", bestplayer, self, bestplayerweapon);
            self recordkillmodifier("assistedsuicide");
            assistedsuicide = 1;
        }
    }
    if (isdefined(bestplayer)) {
        attacker = bestplayer;
        obituarymeansofdeath = bestplayermeansofdeath;
        obituaryweapon = bestplayerweapon;
        if (isdefined(bestplayerweapon)) {
            weapon = bestplayerweapon;
        }
    }
    if (isplayer(attacker)) {
        attacker.damagedplayers[self.clientid] = undefined;
    }
    if (enteredresurrect == 0) {
        globallogic::doweaponspecifickilleffects(einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime);
    }
    self.deathtime = gettime();
    self.pers[#"deathtime"] = self.deathtime;
    if (attacker != self && (!level.teambased || attacker.team != self.team)) {
        assert(isdefined(self.lastspawntime));
        self.alivetimes[self.alivetimecurrentindex] = self.deathtime - self.lastspawntime;
        self.alivetimecurrentindex = (self.alivetimecurrentindex + 1) % level.alivetimemaxcount;
    }
    attacker = update_attacker(attacker, weapon);
    einflictor = update_inflictor(einflictor);
    smeansofdeath = self function_8188eeb0(attacker, einflictor, weapon, smeansofdeath, shitloc);
    if (!isdefined(obituarymeansofdeath)) {
        obituarymeansofdeath = smeansofdeath;
    }
    self.hasriotshield = 0;
    self.hasriotshieldequipped = 0;
    self thread function_a15bcb8b();
    if (!self.var_b3f9ddd4) {
        self function_dbe079ed(attacker, weapon, smeansofdeath, wasinlaststand, var_a3ad44ab, einflictor);
        if (bledout == 0) {
            self function_41161e59(attacker, einflictor, obituaryweapon, obituarymeansofdeath);
        }
    }
    if (enteredresurrect == 0) {
        self.sessionstate = "dead";
        self.statusicon = "hud_status_dead";
    }
    self.pers[#"weapon"] = undefined;
    self.killedplayerscurrent = [];
    if (countdeath) {
        self.deathcount++;
    }
    println("<dev string:x30>" + self.clientid + "<dev string:x39>" + self.deathcount);
    if (bledout == 0 && !self.var_b3f9ddd4) {
        self update_killstreaks(attacker, weapon);
    }
    lpselfnum = self getentitynumber();
    lpselfname = self.name;
    lpattackguid = "";
    lpattackname = "";
    lpselfteam = self.team;
    lpselfguid = self getguid();
    lpattackteam = "";
    lpattackorigin = (0, 0, 0);
    lpattacknum = -1;
    var_d9d6ccd3 = 0;
    awardassists = 0;
    wasteamkill = 0;
    wassuicide = 0;
    pixendevent();
    if (countdeath) {
        scoreevents::processscoreevent(#"death", self, self, weapon);
    }
    if (isplayer(attacker)) {
        lpattackguid = attacker getguid();
        lpattackname = attacker.name;
        lpattackteam = attacker.team;
        lpattackorigin = attacker.origin;
        var_d9d6ccd3 = attacker getxuid();
        if (smeansofdeath == "MOD_HEAD_SHOT") {
            scoreevents::processscoreevent(#"headshot", attacker, self, weapon);
            attacker util::player_contract_event("headshot");
        }
        if (attacker == self || assistedsuicide == 1) {
            if (countdeath) {
                dokillcam = 0;
                wassuicide = 1;
                awardassists = self suicide(einflictor, attacker, smeansofdeath, weapon, shitloc);
                if (assistedsuicide == 1) {
                    attacker thread globallogic_score::givekillstats(smeansofdeath, weapon, self);
                    self function_6697047(attacker, smeansofdeath);
                }
            }
        } else {
            pixbeginevent(#"hash_3c7e54851be0668");
            lpattacknum = attacker getentitynumber();
            dokillcam = 1;
            if (level.teambased && self.team == attacker.team && smeansofdeath == "MOD_GRENADE" && level.friendlyfire == 0) {
            } else if (level.teambased && self.team == attacker.team) {
                wasteamkill = 1;
                self team_kill(einflictor, attacker, smeansofdeath, weapon, shitloc);
            } else {
                if (bledout == 0 || level.var_f4b44a8a === 1) {
                    self kill(einflictor, attacker, smeansofdeath, weapon, shitloc);
                    self function_6697047(attacker, smeansofdeath, bledout);
                }
                if (bledout == 0 || level.var_4a4ff0d5 === 1) {
                    if (level.teambased) {
                        awardassists = 1;
                    }
                }
            }
            pixendevent();
        }
    } else if (isdefined(attacker) && (attacker.classname == "trigger_hurt_new" || attacker.classname == "worldspawn")) {
        dokillcam = 0;
        lpattacknum = -1;
        var_d9d6ccd3 = 0;
        lpattackguid = "";
        lpattackname = "";
        lpattackteam = "world";
        scoreevents::processscoreevent(#"suicide", self, undefined, undefined);
        self globallogic_score::incpersstat("suicides", 1);
        self.suicides = self globallogic_score::getpersstat("suicides");
        self.suicide = 1;
        thread battlechatter::on_player_suicide_or_team_kill(self, "suicide");
        awardassists = 1;
        self function_6697047(undefined, smeansofdeath);
        if (level.maxsuicidesbeforekick > 0 && level.maxsuicidesbeforekick <= self.suicides) {
            self notify(#"teamkillkicked");
            self function_29971500();
        }
    } else {
        dokillcam = 0;
        lpattacknum = -1;
        var_d9d6ccd3 = 0;
        lpattackguid = "";
        lpattackname = "";
        lpattackteam = "world";
        wassuicide = 1;
        if (isdefined(einflictor) && isdefined(einflictor.killcament)) {
            dokillcam = 1;
            lpattacknum = self getentitynumber();
            wassuicide = 0;
        }
        if (isdefined(attacker) && isdefined(attacker.team) && isdefined(level.teams[attacker.team])) {
            if (attacker.team != self.team) {
                if (level.teambased) {
                    if (!isdefined(killstreaks::get_killstreak_for_weapon(weapon)) || isdefined(level.killstreaksgivegamescore) && level.killstreaksgivegamescore) {
                        globallogic_score::giveteamscore("kill", attacker.team, attacker, self);
                    }
                }
                wassuicide = 0;
            }
        }
        awardassists = 1;
        self function_6697047(undefined, smeansofdeath);
    }
    if (isplayer(attacker) && isdefined(attacker.pers)) {
        if (attacker.pers[#"hash_49e7469988944ecf"] === 1) {
            if (weapon.statindex == level.weapon_hero_annihilator.statindex) {
                scoreevents::processscoreevent(#"hash_39926f44fa76b382", attacker, self, weapon);
                attacker.pers[#"hash_49e7469988944ecf"] = undefined;
            }
        }
    }
    if (!level.ingraceperiod && enteredresurrect == 0) {
        if (smeansofdeath != "MOD_FALLING") {
            if (weapon.name != "incendiary_fire") {
                self weapons::drop_scavenger_for_death(attacker);
            }
        }
        if (should_drop_weapon_on_death(wasteamkill, wassuicide, weapon_at_time_of_death, smeansofdeath)) {
            self weapons::drop_for_death(attacker, weapon, smeansofdeath, 0);
        }
    }
    if (awardassists) {
        self function_9c91fa31(einflictor, attacker, weapon, lpattackteam);
    }
    pixbeginevent(#"hash_6f37a114f9261138");
    self.lastattacker = attacker;
    self.lastdeathpos = self.origin;
    if (isdefined(attacker) && isplayer(attacker) && attacker != self && (!level.teambased || attacker.team != self.team)) {
        attacker notify(#"killed_enemy_player", {#victim:self, #weapon:weapon, #time:gettime()});
        self thread challenges::playerkilled(einflictor, attacker, idamage, smeansofdeath, weapon, shitloc, attackerstance, bledout);
    } else {
        self notify(#"playerkilledchallengesprocessed");
    }
    killerheropoweractive = 0;
    killer = undefined;
    killerloadoutindex = -1;
    killerwasads = 0;
    killerinvictimfov = 0;
    victiminkillerfov = 0;
    victimspecialist = function_b9650e7f(self player_role::get(), currentsessionmode());
    if (isplayer(attacker)) {
        updatekillstreak(einflictor, attacker, weapon);
        attackerspecialist = function_b9650e7f(attacker player_role::get(), currentsessionmode());
        attacker.lastkilltime = gettime();
        killer = attacker;
        killerloadoutindex = attacker.class_num;
        killerwasads = attacker playerads() >= 1;
        killerinvictimfov = util::within_fov(self.origin, self.angles, attacker.origin, self.fovcosine);
        victiminkillerfov = util::within_fov(attacker.origin, attacker.angles, self.origin, attacker.fovcosine);
        if (attacker ability_player::is_using_any_gadget()) {
            killerheropoweractive = 1;
        }
        if (killstreaks::is_killstreak_weapon(weapon)) {
            killstreak = killstreaks::get_killstreak_for_weapon_for_stats(weapon);
            bb::function_2384c738(attacker, lpattackorigin, attackerspecialist, weapon.name, self, self.origin, victimspecialist, self.currentweapon.name, idamage, smeansofdeath, shitloc, 1, killerheropoweractive, killstreak);
        } else {
            bb::function_2384c738(attacker, lpattackorigin, attackerspecialist, weapon.name, self, self.origin, victimspecialist, self.currentweapon.name, idamage, smeansofdeath, shitloc, 1, killerheropoweractive, undefined);
        }
    } else {
        bb::function_2384c738(undefined, undefined, undefined, weapon.name, self, self.origin, victimspecialist, undefined, idamage, smeansofdeath, shitloc, 1, 0, undefined);
    }
    victimweapon = undefined;
    victimweaponpickedup = 0;
    victimkillstreakweaponindex = 0;
    if (isdefined(weapon_at_time_of_death)) {
        victimweapon = weapon_at_time_of_death;
        if (isdefined(self.pickedupweapons) && isdefined(self.pickedupweapons[victimweapon])) {
            victimweaponpickedup = 1;
        }
        if (killstreaks::is_killstreak_weapon(victimweapon)) {
            killstreak = killstreaks::get_killstreak_for_weapon_for_stats(victimweapon);
            if (isdefined(level.killstreaks[killstreak].menuname)) {
                victimkillstreakweaponindex = level.killstreakindices[level.killstreaks[killstreak].menuname];
            }
        }
    }
    victimwasads = self playerads() >= 1;
    victimheropoweractive = self ability_player::is_using_any_gadget();
    killerweaponpickedup = 0;
    killerkillstreakweaponindex = 0;
    var_74580782 = 125;
    if (isdefined(weapon)) {
        if (isdefined(killer) && isdefined(killer.pickedupweapons) && isdefined(killer.pickedupweapons[weapon])) {
            killerweaponpickedup = 1;
        }
        if (killstreaks::is_killstreak_weapon(weapon)) {
            killstreak = killstreaks::get_killstreak_for_weapon_for_stats(weapon);
            if (isdefined(level.killstreaks[killstreak].menuname)) {
                killerkillstreakweaponindex = level.killstreakindices[level.killstreaks[killstreak].menuname];
                if (isdefined(killerkillstreakweaponindex) && isdefined(killer) && isdefined(killer.killstreakevents) && isdefined(killer.killstreakevents[killerkillstreakweaponindex])) {
                    var_74580782 = killer.killstreakevents[killerkillstreakweaponindex];
                } else {
                    var_74580782 = 126;
                }
            }
        }
    }
    matchrecordlogadditionaldeathinfo(self, killer, victimweapon, weapon, self.class_num, victimweaponpickedup, victimwasads, killerloadoutindex, killerweaponpickedup, killerwasads, victimheropoweractive, killerheropoweractive, victiminkillerfov, killerinvictimfov, killerkillstreakweaponindex, victimkillstreakweaponindex, var_74580782);
    self player_record::record_special_move_data_for_life(killer);
    self.pickedupweapons = [];
    self.switching_teams = undefined;
    self.joining_team = undefined;
    self.leaving_team = undefined;
    attackerstring = "none";
    if (isplayer(attacker)) {
        attackerstring = attacker getxuid() + "(" + lpattackname + ")";
    }
    /#
        print("<dev string:x4c>" + smeansofdeath + "<dev string:x4f>" + weapon.name + "<dev string:x51>" + attackerstring + "<dev string:x56>" + idamage + "<dev string:x5a>" + shitloc + "<dev string:x5e>" + int(self.origin[0]) + "<dev string:x62>" + int(self.origin[1]) + "<dev string:x62>" + int(self.origin[2]));
    #/
    level thread globallogic::updateteamstatus();
    level thread globallogic::updatealivetimes(self.team);
    self thread function_2f7d42e4();
    if (isdefined(self.killcam_entity_info_cached)) {
        killcam_entity_info = self.killcam_entity_info_cached;
        self.killcam_entity_info_cached = undefined;
    } else {
        killcam_entity_info = killcam::get_killcam_entity_info(attacker, einflictor, weapon);
    }
    if (isdefined(self.killstreak_delay_killcam)) {
        dokillcam = 0;
    }
    self weapons::detach_carry_object_model();
    pixendevent();
    pixbeginevent(#"hash_6a07afbdee38d766");
    vattackerorigin = undefined;
    if (isdefined(attacker)) {
        vattackerorigin = attacker.origin;
    }
    if (enteredresurrect == 0) {
        clone_weapon = weapon;
        if (weapon_utils::ismeleemod(smeansofdeath) && clone_weapon.type != "melee") {
            clone_weapon = level.weaponnone;
        }
        body = self cloneplayer(deathanimduration, clone_weapon, attacker, vdir);
        if (isdefined(body)) {
            self create_body(attacker, idamage, smeansofdeath, weapon, shitloc, vdir, vattackerorigin, deathanimduration, einflictor, body);
            self battlechatter::play_death_vox(body, attacker, weapon, smeansofdeath);
            globallogic::doweaponspecificcorpseeffects(body, einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime);
        }
    }
    pixendevent();
    if (enteredresurrect) {
        thread globallogic_spawn::spawnqueuedclient(self.team, attacker);
    }
    self function_2a2c6b9b(einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration);
    self function_788365ad();
    if (isdefined(self.attackers)) {
        self.attackers = [];
    }
    self.wantsafespawn = 0;
    perks = [];
    killstreaks = globallogic::getkillstreaks(attacker);
    if (!isdefined(self.killstreak_delay_killcam)) {
        self thread [[ level.spawnplayerprediction ]]();
    }
    profilelog_endtiming(7, "gs=" + game.state);
    if (wasteamkill == 0 && assistedsuicide == 0 && smeansofdeath != "MOD_SUICIDE" && !(!isdefined(attacker) || attacker.classname == "trigger_hurt_new" || attacker.classname == "worldspawn" || attacker == self || isdefined(attacker.disablefinalkillcam))) {
        level thread killcam::record_settings(lpattacknum, self getentitynumber(), killcam_entity_info, weapon, smeansofdeath, self.deathtime, deathtimeoffset, psoffsettime, perks, killstreaks, attacker);
        if (level.gametype === "bounty") {
            level thread potm::function_da7a6757(#"bh_kill", lpattacknum, var_d9d6ccd3, self, killcam_entity_info, weapon, smeansofdeath, self.deathtime, deathtimeoffset, psoffsettime, perks, killstreaks, attacker, einflictor);
        } else {
            level thread potm::function_da7a6757(#"kill", lpattacknum, var_d9d6ccd3, self, killcam_entity_info, weapon, smeansofdeath, self.deathtime, deathtimeoffset, psoffsettime, perks, killstreaks, attacker, einflictor);
        }
    }
    if (enteredresurrect) {
        return;
    }
    if (!self.var_b3f9ddd4) {
        if (isdefined(self.var_a541ee78) && self.var_a541ee78 && self == attacker) {
            waitframe(1);
        } else {
            wait 0.25;
        }
    }
    weaponclass = util::getweaponclass(weapon);
    if (isdefined(weaponclass) && weaponclass == #"weapon_sniper") {
        self thread battlechatter::killed_by_sniper(attacker);
    } else {
        self thread battlechatter::player_killed(attacker, killstreak, einflictor, weapon, smeansofdeath);
    }
    self.cancelkillcam = 0;
    if (!userspawnselection::isspawnselectenabled()) {
        self thread killcam::cancel_on_use();
    }
    if (!self.var_b3f9ddd4) {
        self watch_death(weapon, attacker, smeansofdeath, deathanimduration);
    } else {
        dokillcam = 0;
    }
    /#
        if (getdvarint(#"scr_forcekillcam", 0) != 0) {
            dokillcam = 1;
            if (lpattacknum < 0) {
                lpattacknum = self getentitynumber();
                var_d9d6ccd3 = 0;
            }
        }
    #/
    if (self.currentspectatingclient != -1 && level.spectatetype == 4 && self.pers[#"team"] != #"spectator") {
        function_9714b450(self);
    }
    lastteam = globallogic::function_4f9a4c7f();
    if (!isdefined(lastteam) && !self globallogic_spawn::mayspawn()) {
        if (sessionmodeiswarzonegame()) {
            self display_transition::function_3541df96();
        }
    }
    if (game.state != "playing") {
        return;
    }
    self.respawntimerstarttime = gettime();
    keep_deathcam = 0;
    if (isdefined(self.overrideplayerdeadstatus)) {
        keep_deathcam = self [[ self.overrideplayerdeadstatus ]]();
    }
    if (!self.cancelkillcam && dokillcam && level.killcam && wasteamkill == 0) {
        self clientfield::set_player_uimodel("hudItems.killcamActive", 1);
        livesleft = !(level.numlives && !self.pers[#"lives"]) && !(level.numteamlives && !game.lives[self.team]);
        timeuntilspawn = globallogic_spawn::timeuntilspawn(1);
        willrespawnimmediately = livesleft && timeuntilspawn <= 0 && !level.playerqueuedrespawn && !userspawnselection::isspawnselectenabled();
        self killcam::killcam(lpattacknum, self getentitynumber(), killcam_entity_info, weapon, smeansofdeath, self.deathtime, deathtimeoffset, psoffsettime, willrespawnimmediately, globallogic_utils::timeuntilroundend(), perks, killstreaks, attacker, keep_deathcam);
    } else if (self.cancelkillcam) {
        if (isdefined(self.killcamsskipped)) {
            self.killcamsskipped++;
        } else {
            self.killcamsskipped = 1;
        }
    }
    self clientfield::set_player_uimodel("hudItems.killcamActive", 0);
    self function_d056ef2b();
    if (self.var_b3f9ddd4) {
        waitframe(1);
    }
    secondary_deathcam = 0;
    timeuntilspawn = globallogic_spawn::timeuntilspawn(1);
    shoulddoseconddeathcam = timeuntilspawn > 0;
    if (shoulddoseconddeathcam && isdefined(self.secondarydeathcamtime)) {
        secondary_deathcam = self [[ self.secondarydeathcamtime ]]();
    }
    if (secondary_deathcam > 0 && !self.cancelkillcam) {
        self.spectatorclient = -1;
        self.killcamentity = -1;
        self.archivetime = 0;
        self.psoffsettime = 0;
        self.spectatekillcam = 0;
        globallogic_utils::waitfortimeornotify(secondary_deathcam, "end_death_delay");
        self notify(#"death_delay_finished");
    }
    if (!self.cancelkillcam && dokillcam && level.killcam && keep_deathcam) {
        self.sessionstate = "dead";
        self.spectatorclient = -1;
        self.killcamentity = -1;
        self.archivetime = 0;
        self.psoffsettime = 0;
        self.spectatekillcam = 0;
    }
    if (game.state != "playing") {
        self.sessionstate = "dead";
        self.spectatorclient = -1;
        self.killcamtargetentity = -1;
        self.killcamentity = -1;
        self.archivetime = 0;
        self.psoffsettime = 0;
        self.spectatekillcam = 0;
        return;
    }
    function_787c523b();
    userespawntime = 1;
    if (isdefined(level.hostmigrationtimer)) {
        userespawntime = 0;
    }
    hostmigration::waittillhostmigrationcountdown();
    if (globallogic_utils::isvalidclass(self.curclass) || !loadout::function_cd383ec5()) {
        timepassed = undefined;
        if (isdefined(self.respawntimerstarttime) && userespawntime) {
            timepassed = float(gettime() - self.respawntimerstarttime) / 1000;
        }
        self thread [[ level.spawnclient ]](timepassed);
        self.respawntimerstarttime = undefined;
    }
}

// Namespace player/player_killed
// Params 0, eflags: 0x4
// Checksum 0xf047e2b3, Offset: 0x3820
// Size: 0x18c
function private function_d056ef2b() {
    self.var_a65a4ffc = 0;
    if (userspawnselection::isspawnselectenabled() && !(isdefined(self.switching_teams) && self.switching_teams) && self globallogic_spawn::mayspawn()) {
        while (!self function_79dd9a3a()) {
            waitframe(1);
        }
        showmenu = self userspawnselection::shouldshowspawnselectionmenu();
        if (showmenu) {
            if (isdefined(self.predicted_spawn_point)) {
                self setorigin(self.predicted_spawn_point.origin);
                self setplayerangles(self.predicted_spawn_point.angles);
            }
            specialistindex = self player_role::get();
            if (player_role::is_valid(specialistindex)) {
                self.var_a65a4ffc = 1;
                self userspawnselection::function_35d0f353();
                self userspawnselection::waitforspawnselection();
            }
            return;
        }
        self userspawnselection::activatespawnselectionmenu();
    }
}

// Namespace player/player_killed
// Params 0, eflags: 0x4
// Checksum 0xe4609f78, Offset: 0x39b8
// Size: 0x38
function private function_79dd9a3a() {
    if (self isremotecontrolling()) {
        return false;
    }
    if (isdefined(self.killstreak_delay_killcam)) {
        return false;
    }
    return true;
}

// Namespace player/player_killed
// Params 4, eflags: 0x4
// Checksum 0xdbf73670, Offset: 0x39f8
// Size: 0x116
function private watch_death(weapon, attacker, smeansofdeath, deathanimduration) {
    defaultplayerdeathwatchtime = 1.75;
    if (smeansofdeath == "MOD_MELEE_ASSASSINATE" || 0 > weapon.deathcamtime) {
        defaultplayerdeathwatchtime = deathanimduration * 0.001 + 0.5;
    } else if (0 < weapon.deathcamtime) {
        defaultplayerdeathwatchtime = weapon.deathcamtime;
    }
    if (isdefined(level.overrideplayerdeathwatchtimer)) {
        defaultplayerdeathwatchtime = [[ level.overrideplayerdeathwatchtimer ]](defaultplayerdeathwatchtime);
    }
    if (!(isdefined(self.var_a541ee78) && self.var_a541ee78 && self == attacker)) {
        globallogic_utils::waitfortimeornotify(defaultplayerdeathwatchtime, "end_death_delay");
    }
    self notify(#"death_delay_finished");
}

// Namespace player/player_killed
// Params 5, eflags: 0x4
// Checksum 0xa8bf3891, Offset: 0x3b18
// Size: 0x10e
function private function_8188eeb0(attacker, einflictor, weapon, smeansofdeath, shitloc) {
    if (globallogic_utils::isheadshot(weapon, shitloc, smeansofdeath, einflictor) && isplayer(attacker) && !weapon_utils::ismeleemod(smeansofdeath)) {
        return "MOD_HEAD_SHOT";
    }
    switch (weapon.name) {
    case #"dog_bite":
        smeansofdeath = "MOD_PISTOL_BULLET";
        break;
    case #"destructible_car":
        smeansofdeath = "MOD_EXPLOSIVE";
        break;
    case #"explodable_barrel":
        smeansofdeath = "MOD_EXPLOSIVE";
        break;
    }
    return smeansofdeath;
}

// Namespace player/player_killed
// Params 2, eflags: 0x4
// Checksum 0xd5120e30, Offset: 0x3c30
// Size: 0x3c4
function private update_killstreaks(attacker, weapon) {
    if (!isdefined(self.switching_teams)) {
        if (isplayer(attacker) && level.teambased && attacker != self && self.team == attacker.team) {
            self.pers[#"cur_kill_streak"] = 0;
            self.pers[#"cur_total_kill_streak"] = 0;
            self.pers[#"totalkillstreakcount"] = 0;
            self.pers[#"killstreaksearnedthiskillstreak"] = 0;
            self setplayercurrentstreak(0);
        } else {
            if (!(isdefined(self.var_b9e04d0b) && self.var_b9e04d0b)) {
                self globallogic_score::incpersstat("deaths", 1, 1, 1);
            }
            self.deaths = self globallogic_score::getpersstat("deaths");
            self updatestatratio("kdratio", "kills", "deaths");
            if (self.pers[#"cur_kill_streak"] > self.pers[#"best_kill_streak"]) {
                self.pers[#"best_kill_streak"] = self.pers[#"cur_kill_streak"];
            }
            self.pers[#"kill_streak_before_death"] = self.pers[#"cur_kill_streak"];
            if (isdefined(self.pers[#"hvo"]) && isdefined(self.pers[#"hvo"][#"current"])) {
                self.pers[#"hvo"][#"current"][#"highestkillstreak"] = 0;
            }
            self.pers[#"cur_kill_streak"] = 0;
            self.pers[#"cur_total_kill_streak"] = 0;
            self.pers[#"totalkillstreakcount"] = 0;
            self.pers[#"killstreaksearnedthiskillstreak"] = 0;
            self setplayercurrentstreak(0);
            self.cur_death_streak++;
            if (self.cur_death_streak >= getdvarint(#"perk_deathstreakcountrequired", 0)) {
                self enabledeathstreak();
            }
        }
    } else {
        self.pers[#"totalkillstreakcount"] = 0;
        self.pers[#"killstreaksearnedthiskillstreak"] = 0;
    }
    if (killstreaks::is_killstreak_weapon(weapon)) {
        level.globalkillstreaksdeathsfrom++;
    }
}

// Namespace player/player_killed
// Params 6, eflags: 0x4
// Checksum 0xb2fb3519, Offset: 0x4000
// Size: 0x434
function private function_dbe079ed(attacker, weapon, smeansofdeath, wasinlaststand, var_a3ad44ab, inflictor) {
    if (isplayer(attacker) && attacker != self && (!level.teambased || level.teambased && self.team != attacker.team)) {
        attackerweaponpickedup = 0;
        if (isdefined(attacker.pickedupweapons) && isdefined(attacker.pickedupweapons[weapon])) {
            attackerweaponpickedup = 1;
        }
        self stats::function_c8a05f4f(weapon, #"deaths", 1, self.class_num, attackerweaponpickedup);
        if (wasinlaststand && isdefined(var_a3ad44ab)) {
            victim_weapon = var_a3ad44ab;
        } else {
            victim_weapon = self.lastdroppableweapon;
        }
        if (isdefined(victim_weapon)) {
            victimweaponpickedup = 0;
            if (isdefined(self.pickedupweapons) && isdefined(self.pickedupweapons[victim_weapon])) {
                victimweaponpickedup = 1;
            }
            self stats::function_c8a05f4f(victim_weapon, #"deathsduringuse", 1, self.class_num, victimweaponpickedup);
        }
        recordweaponstatkills = 1;
        if (attacker.isthief === 1 && isdefined(weapon) && weapon.isheroweapon === 1) {
            recordweaponstatkills = 0;
        }
        if (smeansofdeath != "MOD_FALLING" && recordweaponstatkills) {
            if (weapon.name == #"explosive_bolt" && isdefined(inflictor) && isdefined(inflictor.ownerweaponatlaunch) && inflictor.owneradsatlaunch) {
                inflictorownerweaponatlaunchpickedup = 0;
                if (isdefined(attacker.pickedupweapons) && isdefined(attacker.pickedupweapons[inflictor.ownerweaponatlaunch])) {
                    inflictorownerweaponatlaunchpickedup = 1;
                }
                attacker stats::function_c8a05f4f(inflictor.ownerweaponatlaunch, #"kills", 1, attacker.class_num, inflictorownerweaponatlaunchpickedup, 1);
            } else {
                attacker stats::function_c8a05f4f(weapon, #"kills", 1, attacker.class_num, attackerweaponpickedup);
            }
        }
        if (smeansofdeath == "MOD_HEAD_SHOT") {
            attacker stats::function_c8a05f4f(weapon, #"headshots", 1, attacker.class_num, attackerweaponpickedup);
        }
        if (smeansofdeath == "MOD_PROJECTILE") {
            attacker stats::function_4f10b697(weapon, #"direct_hit_kills", 1);
        }
        victimisroulette = self.isroulette === 1;
        if (self ability_player::gadget_checkheroabilitykill(attacker) && !victimisroulette) {
            attacker stats::function_4f10b697(attacker.heroability, #"kills_while_active", 1);
        }
    }
}

// Namespace player/player_killed
// Params 4, eflags: 0x0
// Checksum 0x16056a1d, Offset: 0x4440
// Size: 0x4cc
function function_41161e59(attacker, einflictor, weapon, smeansofdeath) {
    if (smeansofdeath == "MOD_META") {
        return;
    }
    if (!isplayer(attacker) || self util::isenemyplayer(attacker) == 0 || isdefined(weapon) && killstreaks::is_killstreak_weapon(weapon)) {
        level notify(#"reset_obituary_count");
        level.lastobituaryplayercount = 0;
        level.lastobituaryplayer = undefined;
    } else {
        if (isdefined(level.lastobituaryplayer) && level.lastobituaryplayer == attacker) {
            level.lastobituaryplayercount++;
        } else {
            level notify(#"reset_obituary_count");
            level.lastobituaryplayer = attacker;
            level.lastobituaryplayercount = 1;
        }
        level thread scoreevents::decrementlastobituaryplayercountafterfade();
        if (level.lastobituaryplayercount >= 4) {
            level notify(#"reset_obituary_count");
            level.lastobituaryplayercount = 0;
            level.lastobituaryplayer = undefined;
            self thread scoreevents::uninterruptedobitfeedkills(attacker, weapon);
        }
    }
    overrideentitycamera = function_2cebe94b(attacker, weapon);
    var_fc963626 = potm::function_d2f2ef08(weapon, smeansofdeath);
    var_fe11b7ad = 0;
    if (isdefined(weapon) && killstreaks::is_killstreak_weapon(weapon)) {
        var_fe11b7ad = 1;
    }
    if (isdefined(einflictor) && (isdefined(einflictor.var_fe11b7ad) && einflictor.var_fe11b7ad || isdefined(einflictor.owner) && isdefined(einflictor.owner.var_fe11b7ad) && einflictor.owner.var_fe11b7ad)) {
        var_fe11b7ad = 1;
    }
    if (isdefined(einflictor) && einflictor.archetype === "robot") {
        if (smeansofdeath == "MOD_HIT_BY_OBJECT") {
            weapon = getweapon(#"combat_robot_marker");
        }
        smeansofdeath = "MOD_RIFLE_BULLET";
    }
    if (level.teambased && isdefined(attacker.pers) && self.team == attacker.team && smeansofdeath == "MOD_GRENADE" && level.friendlyfire == 0) {
        obituary(self, self, weapon, smeansofdeath);
        demo::kill_bookmark(self, self, einflictor, var_fc963626, overrideentitycamera);
        if (!var_fe11b7ad) {
            if (level.gametype === "bounty") {
                potm::function_e6fdcbca(#"bh_kill", self, self, einflictor, var_fc963626, overrideentitycamera);
            } else {
                potm::kill_bookmark(self, self, einflictor, var_fc963626, overrideentitycamera);
            }
        }
        return;
    }
    obituary(self, attacker, weapon, smeansofdeath);
    demo::kill_bookmark(attacker, self, einflictor, var_fc963626, overrideentitycamera);
    if (!var_fe11b7ad) {
        if (level.gametype === "bounty") {
            potm::function_e6fdcbca(#"bh_kill", attacker, self, einflictor, var_fc963626, overrideentitycamera);
            return;
        }
        potm::kill_bookmark(attacker, self, einflictor, var_fc963626, overrideentitycamera);
    }
}

// Namespace player/player_killed
// Params 2, eflags: 0x0
// Checksum 0x9ed3b7b3, Offset: 0x4918
// Size: 0x62
function function_2cebe94b(attacker, weapon) {
    overrideentitycamera = 0;
    if (!isdefined(weapon)) {
        return overrideentitycamera;
    }
    if (killstreaks::is_killstreak_weapon(weapon)) {
        overrideentitycamera = killstreaks::should_override_entity_camera_in_demo(attacker, weapon);
    }
    return overrideentitycamera;
}

// Namespace player/player_killed
// Params 5, eflags: 0x4
// Checksum 0x97c39bbd, Offset: 0x4988
// Size: 0x360
function private suicide(einflictor, attacker, smeansofdeath, weapon, shitloc) {
    awardassists = 0;
    self.suicide = 0;
    if (isdefined(self.switching_teams)) {
        if (!level.teambased && isdefined(level.teams[self.leaving_team]) && isdefined(level.teams[self.joining_team]) && level.teams[self.leaving_team] != level.teams[self.joining_team]) {
            playercounts = self teams::count_players();
            playercounts[self.leaving_team]--;
            playercounts[self.joining_team]++;
            if (playercounts[self.joining_team] - playercounts[self.leaving_team] > 1) {
                scoreevents::processscoreevent(#"suicide", self, undefined, undefined);
                self globallogic_score::incpersstat("suicides", 1);
                self.suicides = self globallogic_score::getpersstat("suicides");
                self.suicide = 1;
            }
        }
    } else {
        scoreevents::processscoreevent(#"suicide", self);
        self globallogic_score::incpersstat("suicides", 1);
        self.suicides = self globallogic_score::getpersstat("suicides");
        if (smeansofdeath === "MOD_SUICIDE" && shitloc === "none" && isdefined(self.throwinggrenade) && self.throwinggrenade) {
            self.lastgrenadesuicidetime = gettime();
        }
        if (level.maxsuicidesbeforekick > 0 && level.maxsuicidesbeforekick <= self.suicides) {
            self notify(#"teamkillkicked");
            self function_29971500();
        }
        thread battlechatter::on_player_suicide_or_team_kill(self, "suicide");
        awardassists = 1;
        self.suicide = 1;
    }
    if (isdefined(self.friendlydamage)) {
        self iprintln(#"hash_7d1a0e5bd191fce");
        if (level.teamkillpointloss) {
            scoresub = self [[ level.getteamkillscore ]](einflictor, attacker, smeansofdeath, weapon);
            globallogic_score::function_3e69aaea(attacker, scoresub);
        }
    }
    return awardassists;
}

// Namespace player/player_killed
// Params 5, eflags: 0x4
// Checksum 0xc586f786, Offset: 0x4cf0
// Size: 0x2cc
function private team_kill(einflictor, attacker, smeansofdeath, weapon, shitloc) {
    scoreevents::processscoreevent(#"team_kill", attacker, undefined, weapon);
    self.teamkilled = 1;
    if (!ignore_team_kills(weapon, smeansofdeath, einflictor)) {
        teamkill_penalty = self [[ level.getteamkillpenalty ]](einflictor, attacker, smeansofdeath, weapon);
        attacker globallogic_score::incpersstat("teamkills_nostats", teamkill_penalty, 0);
        attacker globallogic_score::incpersstat("teamkills", 1);
        attacker.teamkillsthisround++;
        if (level.teamkillpointloss) {
            scoresub = self [[ level.getteamkillscore ]](einflictor, attacker, smeansofdeath, weapon);
            globallogic_score::function_3e69aaea(attacker, scoresub);
        }
        if (globallogic_utils::gettimepassed() < 5000) {
            var_f1377a79 = 1;
        } else if (attacker.pers[#"teamkills_nostats"] > 1 && globallogic_utils::gettimepassed() < int((8 + attacker.pers[#"teamkills_nostats"]) * 1000)) {
            var_f1377a79 = 1;
        } else {
            var_f1377a79 = attacker function_f1377a79();
        }
        if (var_f1377a79 > 0) {
            attacker.teamkillpunish = 1;
            attacker thread wait_and_suicide();
            if (attacker function_e270be34(var_f1377a79)) {
                attacker notify(#"teamkillkicked");
                attacker thread function_91312a6();
            }
            attacker thread function_626cb430();
        }
        if (isplayer(attacker)) {
            thread battlechatter::on_player_suicide_or_team_kill(attacker, "teamkill");
        }
    }
}

// Namespace player/player_killed
// Params 0, eflags: 0x4
// Checksum 0x6159b2be, Offset: 0x4fc8
// Size: 0x8c
function private wait_and_suicide() {
    self endon(#"disconnect");
    self val::set(#"wait_and_suicide", "freezecontrols");
    wait 0.25;
    self val::reset(#"wait_and_suicide", "freezecontrols");
    self suicide();
}

// Namespace player/player_killed
// Params 4, eflags: 0x4
// Checksum 0xe999a8f7, Offset: 0x5060
// Size: 0x2cc
function private function_9c91fa31(einflictor, attacker, weapon, lpattackteam) {
    pixbeginevent(#"hash_115d2072d5ab2061");
    if (isdefined(self.attackers)) {
        for (j = 0; j < self.attackers.size; j++) {
            player = self.attackers[j];
            if (!isdefined(player)) {
                continue;
            }
            if (player == attacker) {
                continue;
            }
            if (player.team != lpattackteam) {
                continue;
            }
            damage_done = self.attackerdamage[player.clientid].damage;
            function_b1f6086c(#"hash_d1357992f4715f0", {#gametime:function_25e96038(), #assistspawnid:getplayerspawnid(player), #assistspecialist:function_b9650e7f(player player_role::get(), currentsessionmode()), #assistweapon:player.currentweapon.name});
            player thread globallogic_score::processassist(self, damage_done, self.attackerdamage[player.clientid].weapon, self.attackerdamage[player.clientid].time, self.attackerdamage[player.clientid].meansofdeath);
        }
    }
    if (level.teambased) {
        self globallogic_score::processkillstreakassists(attacker, einflictor, weapon);
    }
    if (isdefined(self.lastattackedshieldplayer) && isdefined(self.lastattackedshieldtime) && self.lastattackedshieldplayer != attacker) {
        if (gettime() - self.lastattackedshieldtime < 4000) {
            self.lastattackedshieldplayer thread globallogic_score::processshieldassist(self);
        }
    }
    pixendevent();
}

// Namespace player/player_killed
// Params 1, eflags: 0x0
// Checksum 0x6f6ef146, Offset: 0x5338
// Size: 0x114
function function_52a44d71(weapon) {
    if (isdefined(weapon) && isdefined(level.iskillstreakweapon) && [[ level.iskillstreakweapon ]](weapon)) {
        return true;
    }
    if (isdefined(weapon) && isdefined(weapon.statname) && isdefined(level.iskillstreakweapon) && [[ level.iskillstreakweapon ]](getweapon(weapon.statname))) {
        return true;
    }
    switch (weapon.name) {
    case #"ar_accurate_t8_swat":
    case #"hash_17df39d53492b0bf":
    case #"tank_robot_launcher_turret":
    case #"ac130_chaingun":
    case #"hash_7b24d0d0d2823bca":
        return true;
    }
    return false;
}

// Namespace player/player_killed
// Params 5, eflags: 0x4
// Checksum 0x64f2c2e0, Offset: 0x5458
// Size: 0x3a4
function private function_274535aa(einflictor, attacker, smeansofdeath, weapon, var_4c02f3b4) {
    attacker thread globallogic_score::givekillstats(smeansofdeath, weapon, self, var_4c02f3b4);
    killstreak = killstreaks::get_killstreak_for_weapon(weapon);
    if (isdefined(killstreak)) {
        if (scoreevents::isregisteredevent(killstreak)) {
            scoreevents::processscoreevent(killstreak, attacker, self, weapon);
        }
        if (isdefined(einflictor)) {
            bundle = einflictor killstreak_bundles::function_bf8322cd();
            if (isdefined(bundle) && isdefined(bundle.var_12589ad1) && bundle.var_12589ad1) {
                scoreevents::processscoreevent(#"ekia", attacker, self, weapon);
            }
            if (killstreak == "dart" || killstreak == "inventory_dart") {
                einflictor notify(#"veh_collision");
                callback::callback(#"veh_collision", {#normal:(0, 0, 1)});
            }
        }
    } else if (!function_52a44d71(weapon)) {
        if (var_4c02f3b4 == attacker) {
            scoreevents::processscoreevent(#"kill", attacker, self, weapon);
        }
        scoreevents::processscoreevent(#"ekia", attacker, self, weapon);
        if (weapon_utils::ismeleemod(smeansofdeath)) {
            scoreevents::processscoreevent(#"melee_kill", attacker, self, weapon);
        }
    }
    damage = 0;
    if (isdefined(self.attackerdamage) && isdefined(self.attackerdamage[attacker.clientid]) && self.attackerdamage[attacker.clientid].damage) {
        damage = self.attackerdamage[attacker.clientid].damage;
        if (damage > self.maxhealth) {
            damage = self.maxhealth;
        }
    }
    if (isplayer(attacker)) {
        function_2eaddf63(self, attacker, damage);
    }
    attacker thread globallogic_score::trackattackerkill(self.name, self.pers[#"rank"], self.pers[#"rankxp"], self.pers[#"prestige"], self getxuid(), weapon);
    attacker thread globallogic_score::inckillstreaktracker(weapon);
}

// Namespace player/player_killed
// Params 5, eflags: 0x4
// Checksum 0x6e735ba3, Offset: 0x5808
// Size: 0x22c
function private kill(einflictor, attacker, smeansofdeath, weapon, shitloc) {
    if (!isdefined(killstreaks::get_killstreak_for_weapon(weapon)) || isdefined(level.killstreaksgivegamescore) && level.killstreaksgivegamescore) {
        globallogic_score::inctotalkills(attacker.team);
    }
    attackername = attacker.name;
    self thread globallogic_score::trackattackeedeath(attackername, attacker.pers[#"rank"], attacker.pers[#"rankxp"], attacker.pers[#"prestige"], attacker getxuid());
    self thread medals::setlastkilledby(attacker, einflictor);
    if (level.teambased && attacker.team != #"spectator") {
        killstreak = killstreaks::get_killstreak_for_weapon(weapon);
        if (!isdefined(killstreak) || isdefined(level.killstreaksgivegamescore) && level.killstreaksgivegamescore) {
            globallogic_score::giveteamscore("kill", attacker.team, attacker, self);
        }
    }
    scoresub = level.deathpointloss;
    if (scoresub != 0) {
        globallogic_score::function_3e69aaea(self, scoresub);
    }
    level thread function_f65f8522(attacker, weapon, self, einflictor, smeansofdeath);
}

// Namespace player/player_killed
// Params 1, eflags: 0x4
// Checksum 0x6cb9cdc3, Offset: 0x5a40
// Size: 0x24
function private should_allow_postgame_death(smeansofdeath) {
    if (smeansofdeath == "MOD_POST_GAME") {
        return true;
    }
    return false;
}

// Namespace player/player_killed
// Params 9, eflags: 0x4
// Checksum 0x69330e96, Offset: 0x5a70
// Size: 0x17c
function private post_game_death(einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration) {
    if (!should_allow_postgame_death(smeansofdeath)) {
        return;
    }
    self weapons::detach_carry_object_model();
    self.sessionstate = "dead";
    self.spectatorclient = -1;
    self.killcamentity = -1;
    self.archivetime = 0;
    self.psoffsettime = 0;
    clone_weapon = weapon;
    if (weapon_utils::ismeleemod(smeansofdeath) && clone_weapon.type != "melee") {
        clone_weapon = level.weaponnone;
    }
    body = self cloneplayer(deathanimduration, clone_weapon, attacker, vdir);
    if (isdefined(body)) {
        self create_body(attacker, idamage, smeansofdeath, weapon, shitloc, vdir, (0, 0, 0), deathanimduration, einflictor, body);
    }
}

// Namespace player/player_killed
// Params 0, eflags: 0x4
// Checksum 0xb3bb701f, Offset: 0x5bf8
// Size: 0x658
function private function_2f7d42e4() {
    self endon(#"disconnect");
    var_7ee14c78 = 10;
    var_b891259c = level.numteamlives - var_7ee14c78;
    if (isdefined(level.takelivesondeath) && level.takelivesondeath && level.numteamlives > 0) {
        enemy_team = util::getotherteam(self.team);
        teamarray = getplayers(self.team);
        if (game.lives[self.team] == 0 && !level.var_1c4b75ec[self.team]) {
            level.var_1c4b75ec[self.team] = 1;
            level.var_710cc7bb[self.team] = 1;
            thread globallogic_audio::leader_dialog("controlNoLives", self.team);
            thread globallogic_audio::leader_dialog("controlNoLivesEnemy", enemy_team);
            clientfield::set_world_uimodel("hudItems.team" + level.teamindex[self.team] + ".noRespawnsLeft", 1);
            game.lives[self.team] = 0;
            level.var_e2fa9576[self.team] = teamarray.size;
            teammates = util::get_active_players(self.team);
            foreach (player in teammates) {
                player luinotifyevent(#"hash_6b67aa04e378d681", 1, 7);
            }
            util::function_d1f9db00(24, self.team);
        }
        if (level.deaths[self.team] >= var_b891259c && !level.var_710cc7bb[self.team]) {
            level.var_710cc7bb[self.team] = 1;
            thread globallogic_audio::leader_dialog("controlLowLives", self.team);
            thread globallogic_audio::leader_dialog("controlLowLivesEnemy", enemy_team);
        }
        if (isdefined(level.var_e2fa9576) && isdefined(level.var_e2fa9576[self.team])) {
            if (level.var_e2fa9576[self.team] > 0) {
                teammates = util::get_active_players(self.team);
                foreach (player in teammates) {
                    player luinotifyevent(#"hash_6b67aa04e378d681", 2, 1, level.var_e2fa9576[self.team]);
                }
            }
            if (level.var_e2fa9576[self.team] == 1) {
                thread globallogic_audio::leader_dialog("roundEncourageLastPlayer", self.team);
                thread globallogic_audio::leader_dialog("roundEncourageLastPlayerEnemy", enemy_team);
            }
            level.var_e2fa9576[self.team]--;
        }
        function_b0782357(self.team);
        return;
    }
    clientfield::set_player_uimodel("hudItems.playerLivesCount", level.numlives - self.var_b1f81f5d);
    if (isdefined(level.var_eedab0b0)) {
        var_d8506bbf = level.playerlives[#"allies"];
        var_faccf82c = level.playerlives[#"axis"];
        if (level.gametype == "sd" && userspawnselection::function_8325b78c(self)) {
            return;
        }
        if (self.team == #"allies") {
            var_d8506bbf -= 1;
        } else if (self.team == #"axis") {
            var_faccf82c -= 1;
        }
        if (var_d8506bbf > 0 && var_faccf82c > 0) {
            foreach (player in level.activeplayers) {
                if (!isdefined(player)) {
                    continue;
                }
                player luinotifyevent(#"hash_6b67aa04e378d681", 3, 2, var_d8506bbf, var_faccf82c);
            }
        }
    }
}

// Namespace player/player_killed
// Params 1, eflags: 0x4
// Checksum 0x72e467de, Offset: 0x6258
// Size: 0x46
function private function_bf931c6b(lives) {
    if (lives == 0) {
        level notify(#"player_eliminated");
        self notify(#"player_eliminated");
    }
}

// Namespace player/player_killed
// Params 0, eflags: 0x4
// Checksum 0xc4f755c1, Offset: 0x62a8
// Size: 0x1d4
function private function_a44a3d04() {
    if (!(isdefined(level.takelivesondeath) && level.takelivesondeath)) {
        return;
    }
    if (isdefined(self.var_b9e04d0b) && self.var_b9e04d0b) {
        return;
    }
    if (game.lives[self.team] > 0) {
        if (self.attackers.size < 1) {
            return;
        } else {
            foreach (attacker in self.attackers) {
                if (!isdefined(attacker)) {
                    continue;
                }
                if (attacker.team != self.team) {
                    removelives = 1;
                    break;
                }
            }
            if (!(isdefined(removelives) && removelives)) {
                return;
            }
        }
        game.lives[self.team]--;
        if (self.pers[#"lives"] == 0) {
            self function_bf931c6b(game.lives[self.team]);
        }
        return;
    }
    if (self.pers[#"lives"]) {
        self.pers[#"lives"]--;
        self function_bf931c6b(self.pers[#"lives"]);
    }
}

// Namespace player/player_killed
// Params 10, eflags: 0x4
// Checksum 0x8f64503b, Offset: 0x6488
// Size: 0x35c
function private create_body(attacker, idamage, smeansofdeath, weapon, shitloc, vdir, vattackerorigin, deathanimduration, einflictor, body) {
    if (smeansofdeath == "MOD_HIT_BY_OBJECT" && self getstance() == "prone") {
        self.body = body;
        if (!isdefined(self.switching_teams)) {
            thread deathicons::add(body, self, self.team);
        }
        return;
    }
    if (isdefined(level.ragdoll_override) && self [[ level.ragdoll_override ]](idamage, smeansofdeath, weapon, shitloc, vdir, vattackerorigin, deathanimduration, einflictor, 0, body)) {
        return;
    }
    if (self isonladder() || self ismantling() || smeansofdeath == "MOD_CRUSH" || smeansofdeath == "MOD_HIT_BY_OBJECT") {
        body startragdoll();
    }
    if (!self isonground() && smeansofdeath != "MOD_FALLING") {
        if (getdvarint(#"scr_disable_air_death_ragdoll", 0) == 0) {
            body startragdoll();
        }
    }
    if (smeansofdeath == "MOD_MELEE_ASSASSINATE" && !attacker isonground()) {
        body start_death_from_above_ragdoll(vdir);
    }
    if (self is_explosive_ragdoll(weapon, einflictor)) {
        body start_explosive_ragdoll(vdir, weapon);
    }
    thread delayed_ragdoll(body, shitloc, vdir, weapon, einflictor, smeansofdeath);
    if (smeansofdeath == "MOD_CRUSH") {
        body globallogic_vehicle::vehiclecrush(attacker, einflictor);
    }
    self.body = body;
    if (!isdefined(self.switching_teams)) {
        thread deathicons::add(body, self, self.team);
    }
    params = spawnstruct();
    params.smeansofdeath = smeansofdeath;
    params.weapon = weapon;
    self.body callback::callback(#"on_player_corpse");
}

// Namespace player/player_killed
// Params 4, eflags: 0x4
// Checksum 0xdfdcd515, Offset: 0x67f0
// Size: 0x90
function private should_drop_weapon_on_death(wasteamkill, wassuicide, current_weapon, smeansofdeath) {
    if (wasteamkill) {
        return false;
    }
    if (wassuicide) {
        return false;
    }
    if (smeansofdeath == "MOD_TRIGGER_HURT" && !self isonground()) {
        return false;
    }
    if (isdefined(current_weapon) && current_weapon.isheavyweapon) {
        return false;
    }
    return true;
}

// Namespace player/player_killed
// Params 0, eflags: 0x4
// Checksum 0x37d8c15e, Offset: 0x6888
// Size: 0x2c
function private function_a15bcb8b() {
    if (isbot(self)) {
        level.globallarryskilled++;
    }
}

// Namespace player/player_killed
// Params 0, eflags: 0x4
// Checksum 0x2978a42e, Offset: 0x68c0
// Size: 0x44
function private function_787c523b() {
    if (isdefined(self.killstreak_delay_killcam)) {
        while (isdefined(self.killstreak_delay_killcam)) {
            wait 0.1;
        }
        wait 2;
        self killstreaks::reset_killstreak_delay_killcam();
    }
}

// Namespace player/player_killed
// Params 0, eflags: 0x4
// Checksum 0xdb0469d0, Offset: 0x6910
// Size: 0x8c
function private function_29971500() {
    self globallogic_score::incpersstat("sessionbans", 1);
    self endon(#"disconnect");
    waittillframeend();
    globallogic::gamehistoryplayerkicked();
    ban(self getentitynumber());
    globallogic_audio::leader_dialog("gamePlayerKicked");
}

// Namespace player/player_killed
// Params 0, eflags: 0x4
// Checksum 0x8446e53, Offset: 0x69a8
// Size: 0x1cc
function private function_91312a6() {
    self globallogic_score::incpersstat("sessionbans", 1);
    self endon(#"disconnect");
    waittillframeend();
    playlistbanquantum = tweakables::gettweakablevalue("team", "teamkillerplaylistbanquantum");
    playlistbanpenalty = tweakables::gettweakablevalue("team", "teamkillerplaylistbanpenalty");
    if (playlistbanquantum > 0 && playlistbanpenalty > 0) {
        timeplayedtotal = self stats::get_stat_global(#"time_played_total");
        minutesplayed = timeplayedtotal / 60;
        freebees = 2;
        banallowance = int(floor(minutesplayed / playlistbanquantum)) + freebees;
        if (self.sessionbans > banallowance) {
            self stats::set_stat_global(#"gametypeban", timeplayedtotal + playlistbanpenalty * 60);
        }
    }
    globallogic::gamehistoryplayerkicked();
    ban(self getentitynumber());
    globallogic_audio::leader_dialog("gamePlayerKicked");
}

// Namespace player/player_killed
// Params 0, eflags: 0x0
// Checksum 0x23d5520c, Offset: 0x6b80
// Size: 0x7c
function function_f1377a79() {
    teamkills = self.pers[#"teamkills_nostats"];
    if (level.minimumallowedteamkills < 0 || teamkills <= level.minimumallowedteamkills) {
        return 0;
    }
    exceeded = teamkills - level.minimumallowedteamkills;
    return level.teamkillspawndelay * exceeded;
}

// Namespace player/player_killed
// Params 1, eflags: 0x4
// Checksum 0x6f02b7c0, Offset: 0x6c08
// Size: 0x74
function private function_e270be34(var_f1377a79) {
    if (var_f1377a79 && level.minimumallowedteamkills >= 0) {
        if (globallogic_utils::gettimepassed() >= 5000) {
            return true;
        }
        if (self.pers[#"teamkills_nostats"] > 1) {
            return true;
        }
    }
    return false;
}

// Namespace player/player_killed
// Params 0, eflags: 0x0
// Checksum 0x1c93861, Offset: 0x6c88
// Size: 0xdc
function function_626cb430() {
    timeperoneteamkillreduction = 20;
    reductionpersecond = 1 / timeperoneteamkillreduction;
    while (true) {
        if (isalive(self)) {
            self.pers[#"teamkills_nostats"] = self.pers[#"teamkills_nostats"] - reductionpersecond;
            if (self.pers[#"teamkills_nostats"] < level.minimumallowedteamkills) {
                self.pers[#"teamkills_nostats"] = level.minimumallowedteamkills;
                break;
            }
        }
        wait 1;
    }
}

// Namespace player/player_killed
// Params 3, eflags: 0x4
// Checksum 0xe2b5677a, Offset: 0x6d70
// Size: 0xfa
function private ignore_team_kills(weapon, smeansofdeath, einflictor) {
    if (weapon_utils::ismeleemod(smeansofdeath)) {
        return false;
    }
    if (weapon.ignore_team_kills === 1) {
        return true;
    }
    if (isdefined(einflictor) && einflictor.ignore_team_kills === 1) {
        return true;
    }
    if (isdefined(einflictor) && isdefined(einflictor.destroyedby) && isdefined(einflictor.owner) && einflictor.destroyedby != einflictor.owner) {
        return true;
    }
    if (isdefined(einflictor) && einflictor.classname == "worldspawn") {
        return true;
    }
    return false;
}

// Namespace player/player_killed
// Params 2, eflags: 0x4
// Checksum 0x4e0d554b, Offset: 0x6e78
// Size: 0xb6
function private is_explosive_ragdoll(weapon, inflictor) {
    if (!isdefined(weapon)) {
        return false;
    }
    if (weapon.name == #"destructible_car" || weapon.name == #"explodable_barrel") {
        return true;
    }
    if (weapon.projexplosiontype == "grenade") {
        if (isdefined(inflictor) && isdefined(inflictor.stucktoplayer)) {
            if (inflictor.stucktoplayer == self) {
                return true;
            }
        }
    }
    return false;
}

// Namespace player/player_killed
// Params 2, eflags: 0x4
// Checksum 0x8b13fcfb, Offset: 0x6f38
// Size: 0x1b4
function private start_explosive_ragdoll(dir, weapon) {
    if (!isdefined(self)) {
        return;
    }
    x = randomintrange(50, 100);
    y = randomintrange(50, 100);
    z = randomintrange(10, 20);
    if (isdefined(weapon) && (weapon.name == #"sticky_grenade" || weapon.name == #"explosive_bolt")) {
        if (isdefined(dir) && lengthsquared(dir) > 0) {
            x = dir[0] * x;
            y = dir[1] * y;
        }
    } else {
        if (math::cointoss()) {
            x *= -1;
        }
        if (math::cointoss()) {
            y *= -1;
        }
    }
    self startragdoll();
    self launchragdoll((x, y, z));
}

// Namespace player/player_killed
// Params 1, eflags: 0x4
// Checksum 0x61b56a13, Offset: 0x70f8
// Size: 0x4c
function private start_death_from_above_ragdoll(dir) {
    if (!isdefined(self)) {
        return;
    }
    self startragdoll();
    self launchragdoll((0, 0, -100));
}

// Namespace player/player_killed
// Params 6, eflags: 0x4
// Checksum 0x6a604cb4, Offset: 0x7150
// Size: 0x17c
function private delayed_ragdoll(ent, shitloc, vdir, weapon, einflictor, smeansofdeath) {
    if (isdefined(ent)) {
        deathanim = ent getcorpseanim();
        if (animhasnotetrack(deathanim, "ignore_ragdoll")) {
            return;
        }
    }
    waittillframeend();
    if (!isdefined(ent)) {
        return;
    }
    if (ent isragdoll()) {
        return;
    }
    deathanim = ent getcorpseanim();
    startfrac = 0.35;
    if (animhasnotetrack(deathanim, "start_ragdoll")) {
        times = getnotetracktimes(deathanim, "start_ragdoll");
        if (isdefined(times)) {
            startfrac = times[0];
        }
    }
    waittime = startfrac * getanimlength(deathanim);
    if (waittime > 0) {
        wait waittime;
    }
    if (isdefined(ent)) {
        ent startragdoll();
    }
}

// Namespace player/player_killed
// Params 2, eflags: 0x4
// Checksum 0x1a9e445b, Offset: 0x72d8
// Size: 0x30c
function private update_attacker(attacker, weapon) {
    if (isai(attacker) && isdefined(attacker.script_owner)) {
        if (!level.teambased || attacker.script_owner.team != self.team) {
            attacker = attacker.script_owner;
        }
    }
    if (attacker.classname == "script_vehicle" && isdefined(attacker.owner)) {
        attacker notify(#"killed", {#victim:self});
        attacker = attacker.owner;
    }
    if (isai(attacker)) {
        attacker notify(#"killed", {#victim:self});
    }
    if (isdefined(self.capturinglastflag) && self.capturinglastflag == 1) {
        attacker.lastcapkiller = 1;
    }
    if (isdefined(attacker) && attacker != self && isdefined(weapon)) {
        if (weapon.name == #"planemortar") {
            if (!isdefined(attacker.planemortarbda)) {
                attacker.planemortarbda = 0;
            }
            attacker.planemortarbda++;
        } else if (weapon.name == #"dart" || weapon.name == #"dart_turret") {
            if (!isdefined(attacker.dartbda)) {
                attacker.dartbda = 0;
            }
            attacker.dartbda++;
        } else if (weapon.name == #"straferun_rockets" || weapon.name == #"straferun_gun") {
            if (isdefined(attacker.straferunbda)) {
                attacker.straferunbda++;
            }
        } else if (weapon.name == #"remote_missile_missile" || weapon.name == #"remote_missile_bomblet") {
            if (!isdefined(attacker.remotemissilebda)) {
                attacker.remotemissilebda = 0;
            }
            attacker.remotemissilebda++;
        }
    }
    return attacker;
}

// Namespace player/player_killed
// Params 1, eflags: 0x4
// Checksum 0x65e6ad42, Offset: 0x75f0
// Size: 0x78
function private update_inflictor(einflictor) {
    if (isdefined(einflictor) && einflictor.classname == "script_vehicle") {
        einflictor notify(#"killed", {#victim:self});
        if (isdefined(einflictor.bda)) {
            einflictor.bda++;
        }
    }
    return einflictor;
}

// Namespace player/player_killed
// Params 2, eflags: 0x4
// Checksum 0x887569c1, Offset: 0x7670
// Size: 0xea
function private update_weapon(einflictor, weapon) {
    if (weapon == level.weaponnone && isdefined(einflictor)) {
        if (isdefined(einflictor.targetname) && einflictor.targetname == "explodable_barrel") {
            weapon = getweapon(#"explodable_barrel");
        } else if (isdefined(einflictor.destructible_type) && issubstr(einflictor.destructible_type, "vehicle_")) {
            weapon = getweapon(#"destructible_car");
        }
    }
    return weapon;
}

// Namespace player/player_killed
// Params 5, eflags: 0x4
// Checksum 0x8bb17180, Offset: 0x7768
// Size: 0xd8
function private function_f65f8522(attacker, weapon, victim, einflictor, smeansofdeath) {
    if (isplayer(attacker)) {
        if (!killstreaks::is_killstreak_weapon(weapon)) {
            level thread battlechatter::say_kill_battle_chatter(attacker, weapon, victim, einflictor, smeansofdeath);
        }
    }
    if (isdefined(einflictor)) {
        bhtnactionstartevent(einflictor, "attack_kill");
        einflictor notify(#"bhtn_action_notify", {#action:"attack_kill"});
    }
}

// Namespace player/player_killed
// Params 3, eflags: 0x0
// Checksum 0x1f50dca8, Offset: 0x7848
// Size: 0x35a
function updatekillstreak(einflictor, attacker, weapon) {
    if (isalive(attacker)) {
        pixbeginevent(#"killstreak");
        if (!isdefined(einflictor) || !isdefined(einflictor.requireddeathcount) || attacker.deathcount == einflictor.requireddeathcount) {
            shouldgivekillstreak = killstreaks::should_give_killstreak(weapon);
            if (shouldgivekillstreak) {
                attacker killstreaks::add_to_killstreak_count(weapon);
            }
            attacker.pers[#"cur_total_kill_streak"]++;
            attacker setplayercurrentstreak(attacker.pers[#"cur_total_kill_streak"]);
            if (isdefined(level.killstreaks) && shouldgivekillstreak) {
                attacker.pers[#"cur_kill_streak"]++;
                if (attacker.pers[#"cur_kill_streak"] >= 2) {
                    if (attacker.pers[#"cur_kill_streak"] == 10) {
                        attacker challenges::killstreakten();
                    }
                    if (attacker.pers[#"cur_kill_streak"] <= 30) {
                        scoreevents::processscoreevent(#"killstreak_" + attacker.pers[#"cur_kill_streak"], attacker, self, weapon);
                        if (attacker.pers[#"cur_kill_streak"] == 30) {
                            attacker challenges::killstreak_30_noscorestreaks();
                        }
                    } else {
                        scoreevents::processscoreevent(#"killstreak_more_than_30", attacker, self, weapon);
                    }
                }
                if (!isdefined(level.usingmomentum) || !level.usingmomentum) {
                    attacker thread killstreaks::give_for_streak();
                }
            }
        }
        pixendevent();
    }
    if (attacker.pers[#"cur_kill_streak"] > attacker.gametype_kill_streak) {
        attacker stats::function_a296ab19(#"kill_streak", attacker.pers[#"cur_kill_streak"]);
        attacker.gametype_kill_streak = attacker.pers[#"cur_kill_streak"];
    }
}

// Namespace player/player_killed
// Params 9, eflags: 0x0
// Checksum 0x891e764a, Offset: 0x7bb0
// Size: 0x132
function function_2a2c6b9b(einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration) {
    foreach (callback in level.var_6e29ff90) {
        if (callback.threaded) {
            self thread [[ callback.callback ]](einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration);
            continue;
        }
        profilestart();
        self [[ callback.callback ]](einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration);
        profilestop();
    }
}

// Namespace player/player_killed
// Params 4, eflags: 0x0
// Checksum 0x227f8fa9, Offset: 0x7cf0
// Size: 0xe2
function function_47f05a51(einflictor, victim, idamage, weapon) {
    foreach (callback in level.var_66d37717) {
        if (callback.threaded) {
            self thread [[ callback.callback ]](einflictor, victim, idamage, weapon);
            continue;
        }
        profilestart();
        self [[ callback.callback ]](einflictor, victim, idamage, weapon);
        profilestop();
    }
}

