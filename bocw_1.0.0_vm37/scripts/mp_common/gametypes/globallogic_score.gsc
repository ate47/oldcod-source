#using script_1cc417743d7c262d;
#using scripts\abilities\ability_player;
#using scripts\abilities\ability_util;
#using scripts\core_common\activecamo_shared;
#using scripts\core_common\armor;
#using scripts\core_common\bb_shared;
#using scripts\core_common\bots\bot;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\challenges_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\contracts_shared;
#using scripts\core_common\globallogic\globallogic_score;
#using scripts\core_common\loadout_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\player\player_role;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\potm_shared;
#using scripts\core_common\rank_shared;
#using scripts\core_common\scoreevents_shared;
#using scripts\core_common\util_shared;
#using scripts\killstreaks\killstreakrules_shared;
#using scripts\killstreaks\killstreaks_shared;
#using scripts\killstreaks\killstreaks_util;
#using scripts\mp_common\callbacks;
#using scripts\mp_common\challenges;
#using scripts\mp_common\gametypes\globallogic;
#using scripts\mp_common\gametypes\globallogic_score;
#using scripts\mp_common\gametypes\globallogic_utils;
#using scripts\mp_common\gametypes\match;
#using scripts\mp_common\gametypes\outcome;
#using scripts\mp_common\scoreevents;

#namespace globallogic_score;

// Namespace globallogic_score/globallogic_score
// Params 0, eflags: 0x2
// Checksum 0xf90815e2, Offset: 0x448
// Size: 0x134
function autoexec __init__() {
    level.scoreevents_givekillstats = &givekillstats;
    level.scoreevents_processassist = &function_b1a3b359;
    clientfield::register_clientuimodel("hudItems.scoreProtected", 1, 1, "int");
    clientfield::register_clientuimodel("hudItems.minorActions.action0", 1, 1, "counter");
    clientfield::register_clientuimodel("hudItems.minorActions.action1", 1, 1, "counter");
    clientfield::register_clientuimodel("hudItems.hotStreak.level", 1, 3, "int");
    callback::on_joined_team(&set_character_spectate_on_index);
    callback::on_joined_spectate(&function_30ab51a4);
    callback::on_changed_specialist(&function_30ab51a4);
}

// Namespace globallogic_score/gametype_init
// Params 1, eflags: 0x40
// Checksum 0x9177bb4f, Offset: 0x588
// Size: 0x26
function event_handler[gametype_init] main(*eventstruct) {
    profilestart();
    level thread function_39193e3a();
    profilestop();
}

// Namespace globallogic_score/level_finalizeinit
// Params 1, eflags: 0x40
// Checksum 0x220f6ad3, Offset: 0x5b8
// Size: 0x204
function event_handler[level_finalizeinit] codecallback_finalizeinitialization(*eventstruct) {
    level.var_b961672f = 0.5;
    if (level.var_5b544215 === 0) {
        level.var_43723615 = &function_3ba7c551;
        level.var_43701269 = &function_b58be5d;
        level.var_b961672f = 0;
        level.killstreakdeathpenaltyindividualearn = undefined;
        return;
    }
    if (level.var_5b544215 === 1) {
        level.var_43723615 = &function_5dda25b9;
        level.var_43701269 = &function_fdbd4189;
        level.var_b961672f = (isdefined(getgametypesetting(#"hash_56a31bddd92a64dc")) ? getgametypesetting(#"hash_56a31bddd92a64dc") : 0) / 100;
        level.killstreakdeathpenaltyindividualearn = undefined;
        return;
    }
    if (level.var_5b544215 === 2) {
        level.var_43723615 = &function_94765bca;
        level.var_43701269 = &function_4301d2e0;
        level.var_b961672f = (isdefined(getgametypesetting(#"killstreakdeathpenaltyindividualearn")) ? getgametypesetting(#"killstreakdeathpenaltyindividualearn") : 0) / 100;
        level.var_bbaf4cdf = &function_fd1f8965;
        level.scorestreaksmaxstacking = 1;
    }
}

// Namespace globallogic_score/globallogic_score
// Params 0, eflags: 0x0
// Checksum 0xdb1fed35, Offset: 0x7c8
// Size: 0x100
function function_39193e3a() {
    self notify("13641110d63d59cc");
    self endon("13641110d63d59cc");
    level endon(#"game_ended");
    while (true) {
        waitresult = level waittill(#"hero_gadget_activated");
        if (isdefined(waitresult.weapon) && isdefined(waitresult.player)) {
            player = waitresult.player;
            if (isdefined(player.pers[#"hash_53919d92ff1d039"])) {
                scoreevents::function_6f51d1e9("battle_command_ultimate_command", player.pers[#"hash_53919d92ff1d039"], undefined, undefined);
                player.pers[#"hash_53919d92ff1d039"] = undefined;
            }
        }
    }
}

// Namespace globallogic_score/globallogic_score
// Params 0, eflags: 0x0
// Checksum 0x516aaf28, Offset: 0x8d0
// Size: 0x98
function function_eaa4e6f7() {
    if (!level.timelimit || level.forcedend) {
        gamelength = float(globallogic_utils::gettimepassed()) / 1000;
        gamelength = min(gamelength, 1200);
    } else {
        gamelength = level.timelimit * 60;
    }
    return gamelength;
}

// Namespace globallogic_score/globallogic_score
// Params 1, eflags: 0x0
// Checksum 0x1bfc6f3b, Offset: 0x970
// Size: 0x44
function function_61f303f5(game_length) {
    totaltimeplayed = self.timeplayed[#"total"];
    if (totaltimeplayed > game_length) {
        totaltimeplayed = game_length;
    }
    return totaltimeplayed;
}

// Namespace globallogic_score/globallogic_score
// Params 0, eflags: 0x0
// Checksum 0x63621326, Offset: 0x9c0
// Size: 0x62
function function_d68cdc5d() {
    var_96974d12 = isdefined(getgametypesetting(#"hash_24c718cc0c526c38")) ? getgametypesetting(#"hash_24c718cc0c526c38") : 3;
    return var_96974d12;
}

// Namespace globallogic_score/globallogic_score
// Params 1, eflags: 0x0
// Checksum 0x9bcead2b, Offset: 0xa30
// Size: 0xa4
function function_984a57ca(player) {
    var_96974d12 = function_d68cdc5d();
    for (pidx = 0; pidx < min(level.placement[#"all"].size, var_96974d12); pidx++) {
        if (level.placement[#"all"][pidx] != player) {
            continue;
        }
        return true;
    }
    return false;
}

// Namespace globallogic_score/globallogic_score
// Params 3, eflags: 0x0
// Checksum 0xbfbb5f06, Offset: 0xae0
// Size: 0xc2
function function_78e7b549(scale, type, game_length) {
    total_time_played = self function_61f303f5(game_length);
    spm = self rank::getspm();
    playerscore = int(scale * game_length / 60 * spm * total_time_played / game_length);
    self thread givematchbonus(type, playerscore);
    self.matchbonus = playerscore;
}

// Namespace globallogic_score/globallogic_score
// Params 1, eflags: 0x0
// Checksum 0xb350722a, Offset: 0xbb0
// Size: 0x3b0
function updatematchbonusscores(outcome) {
    if (!game.timepassed) {
        return;
    }
    if (!level.rankedmatch) {
        updatecustomgamewinner(outcome);
        return;
    }
    gamelength = function_eaa4e6f7();
    tie = outcome::get_flag(outcome, "tie");
    if (tie) {
        winnerscale = 0.75;
        loserscale = 0.75;
    } else {
        winnerscale = 1;
        loserscale = 0.5;
    }
    winning_team = outcome::get_winning_team(outcome);
    players = level.players;
    foreach (player in players) {
        if (player.timeplayed[#"total"] < 1 || player.pers[#"participation"] < 1) {
            player thread rank::endgameupdate();
            continue;
        }
        if (level.hostforcedend && player ishost()) {
            continue;
        }
        if (player.pers[#"score"] < 0) {
            continue;
        }
        if (isdefined(player.pers[#"team"]) && player.pers[#"team"] == #"spectator") {
            continue;
        }
        if (level.teambased) {
            if (tie) {
                player function_78e7b549(winnerscale, "tie", gamelength);
            } else if (isdefined(player.pers[#"team"]) && player.pers[#"team"] == winning_team) {
                player function_78e7b549(winnerscale, "win", gamelength);
            } else {
                player function_78e7b549(loserscale, "loss", gamelength);
            }
        } else if (function_984a57ca(player)) {
            player function_78e7b549(winnerscale, "win", gamelength);
        } else {
            player function_78e7b549(loserscale, "loss", gamelength);
        }
        player.pers[#"totalmatchbonus"] = player.pers[#"totalmatchbonus"] + player.matchbonus;
    }
}

// Namespace globallogic_score/globallogic_score
// Params 1, eflags: 0x0
// Checksum 0xaae60929, Offset: 0xf68
// Size: 0x208
function updatecustomgamewinner(outcome) {
    if (!level.mpcustommatch) {
        return;
    }
    winner_team = outcome::get_winning_team(outcome);
    tie = outcome::get_flag(outcome, "tie");
    foreach (player in level.players) {
        if (!isdefined(winner_team)) {
            player.pers[#"victory"] = 0;
        } else if (level.teambased) {
            if (player.team == winner_team) {
                player.pers[#"victory"] = 2;
            } else if (tie) {
                player.pers[#"victory"] = 1;
            } else {
                player.pers[#"victory"] = 0;
            }
        } else if (function_984a57ca(player)) {
            player.pers[#"victory"] = 2;
        } else {
            player.pers[#"victory"] = 0;
        }
        player.pers[#"sbtimeplayed"] = player.timeplayed[#"total"];
    }
}

// Namespace globallogic_score/globallogic_score
// Params 2, eflags: 0x0
// Checksum 0x16b95965, Offset: 0x1178
// Size: 0xdc
function givematchbonus(scoretype, score) {
    self endon(#"disconnect");
    level waittill(#"give_match_bonus");
    if (!isdefined(self)) {
        return;
    }
    if (scoreevents::shouldaddrankxp(self)) {
        if (isdefined(self.pers) && isdefined(self.pers[#"totalmatchbonus"])) {
            score = self.pers[#"totalmatchbonus"];
        }
        self addrankxpvalue(scoretype, score);
    }
    self rank::endgameupdate();
}

// Namespace globallogic_score/globallogic_score
// Params 0, eflags: 0x0
// Checksum 0x566f8ffe, Offset: 0x1260
// Size: 0x106
function gethighestscoringplayer() {
    players = level.players;
    winner = undefined;
    tie = 0;
    for (i = 0; i < players.size; i++) {
        if (!isdefined(players[i].pointstowin)) {
            continue;
        }
        if (players[i].pointstowin < 1) {
            continue;
        }
        if (!isdefined(winner) || players[i].pointstowin > winner.pointstowin) {
            winner = players[i];
            tie = 0;
            continue;
        }
        if (players[i].pointstowin == winner.pointstowin) {
            tie = 1;
        }
    }
    if (tie || !isdefined(winner)) {
        return undefined;
    }
    return winner;
}

// Namespace globallogic_score/globallogic_score
// Params 0, eflags: 0x0
// Checksum 0xeda96106, Offset: 0x1370
// Size: 0x10a
function function_15683f39() {
    players = level.players;
    highestscoringplayer = undefined;
    tie = 0;
    for (i = 0; i < players.size; i++) {
        player = players[i];
        if (!isdefined(player.score)) {
            continue;
        }
        if (player.score < 1) {
            continue;
        }
        if (!isdefined(highestscoringplayer) || player.score > highestscoringplayer.score) {
            highestscoringplayer = player;
            tie = 0;
            continue;
        }
        if (player.score == highestscoringplayer.score) {
            tie = 1;
        }
    }
    if (tie || !isdefined(highestscoringplayer)) {
        return undefined;
    }
    return highestscoringplayer;
}

// Namespace globallogic_score/globallogic_score
// Params 1, eflags: 0x0
// Checksum 0xb4fcde7e, Offset: 0x1488
// Size: 0x3c
function resetplayerscorechainandmomentum(player) {
    player thread _setplayermomentum(self, 0);
    player thread resetscorechain();
}

// Namespace globallogic_score/globallogic_score
// Params 0, eflags: 0x0
// Checksum 0x2c1880e4, Offset: 0x14d0
// Size: 0x2e
function resetscorechain() {
    self notify(#"reset_score_chain");
    self.scorechain = 0;
    self.rankupdatetotal = 0;
}

// Namespace globallogic_score/globallogic_score
// Params 0, eflags: 0x0
// Checksum 0xa2b48838, Offset: 0x1508
// Size: 0x74
function scorechaintimer() {
    self notify(#"score_chain_timer");
    self endon(#"reset_score_chain", #"score_chain_timer", #"death", #"disconnect");
    wait 20;
    self thread resetscorechain();
}

// Namespace globallogic_score/globallogic_score
// Params 1, eflags: 0x0
// Checksum 0xb7b77769, Offset: 0x1588
// Size: 0x4e
function roundtonearestfive(score) {
    rounding = score % 5;
    if (rounding <= 2) {
        return (score - rounding);
    }
    return score + 5 - rounding;
}

// Namespace globallogic_score/globallogic_score
// Params 9, eflags: 0x0
// Checksum 0x8cd5836d, Offset: 0x15e0
// Size: 0x294
function giveplayermomentumnotification(score, label, *descvalue, *weapon, combatefficiencybonus, eventindex = 0, event, *var_36f23f1f, var_dbaa74e2) {
    weapon += eventindex;
    if (is_true(level.var_5ee570bd)) {
        weapon = rank::function_bcb5e246(var_36f23f1f);
        if (!isdefined(weapon)) {
            weapon = 0;
        }
    }
    if (weapon != 0) {
        if (!isdefined(event)) {
            event = 1;
        }
        if (var_dbaa74e2.notificationtype === #"streak") {
            self luinotifyevent(#"hash_4aa652796cc3e19", 3, combatefficiencybonus, weapon, var_dbaa74e2.var_c874a8ab);
            self function_8ba40d2f(#"hash_4aa652796cc3e19", 3, combatefficiencybonus, weapon, var_dbaa74e2.var_c874a8ab);
        } else {
            self luinotifyevent(#"score_event", 4, combatefficiencybonus, weapon, eventindex, event);
            self function_8ba40d2f(#"score_event", 4, combatefficiencybonus, weapon, eventindex, event);
        }
        potm::function_d6b60141(#"score_event", self, combatefficiencybonus, weapon, eventindex, event);
    }
    weapon = weapon;
    if (weapon > 0 && self hasperk(#"specialty_earnmoremomentum")) {
        weapon = roundtonearestfive(int(weapon * getdvarfloat(#"perk_killstreakmomentummultiplier", 0) + 0.5));
    }
    _setplayermomentum(self, self.pers[#"momentum"] + weapon);
}

// Namespace globallogic_score/globallogic_score
// Params 0, eflags: 0x0
// Checksum 0xede0b188, Offset: 0x1880
// Size: 0x114
function resetplayermomentum() {
    if (isdefined(level.usingscorestreaks) && level.usingscorestreaks) {
        _setplayermomentum(self, 0);
        self thread resetscorechain();
        weaponslist = self getweaponslist();
        for (idx = 0; idx < weaponslist.size; idx++) {
            weapon = weaponslist[idx];
            if (killstreaks::is_killstreak_weapon(weapon)) {
                quantity = killstreaks::get_killstreak_quantity(weapon);
                if (isdefined(quantity) && quantity > 0) {
                    self killstreaks::change_killstreak_quantity(weapon, quantity * -1);
                }
            }
        }
    }
}

// Namespace globallogic_score/globallogic_score
// Params 0, eflags: 0x0
// Checksum 0x9a397f3b, Offset: 0x19a0
// Size: 0x164
function resetplayermomentumonspawn() {
    if (isdefined(level.usingscorestreaks) && level.usingscorestreaks) {
        var_a4e87ee3 = isdefined(self.deathtime) && self.deathtime > 0;
        var_a68a55cd = self function_80172c6();
        if (var_a4e87ee3 && var_a68a55cd > 0) {
            var_28749ebe = isdefined(self.var_28749ebe) ? self.var_28749ebe : 0;
            var_347218dd = var_a68a55cd > var_28749ebe;
            if (var_347218dd) {
                self.var_28749ebe = var_28749ebe + 1;
                var_a4e87ee3 = 0;
            } else {
                self.var_28749ebe = undefined;
            }
        } else {
            self.var_28749ebe = undefined;
        }
        if (var_a4e87ee3) {
            [[ level.var_43701269 ]](self);
            self thread resetscorechain();
        }
        var_8c68675a = var_a68a55cd > (isdefined(self.var_28749ebe) ? self.var_28749ebe : 0);
        self clientfield::set_player_uimodel("hudItems.scoreProtected", var_8c68675a);
    }
}

// Namespace globallogic_score/globallogic_score
// Params 0, eflags: 0x0
// Checksum 0xbe1c0081, Offset: 0x1b10
// Size: 0x5c
function function_1ceb2820() {
    if (isdefined(level.usingscorestreaks) && level.usingscorestreaks) {
        if (isdefined(level.var_bbaf4cdf)) {
            [[ level.var_bbaf4cdf ]](self);
        }
        self thread resetscorechain();
    }
}

// Namespace globallogic_score/globallogic_score
// Params 7, eflags: 0x0
// Checksum 0x1195351e, Offset: 0x1b78
// Size: 0x2ec
function giveplayermomentum(event, player, victim, descvalue, weapon, var_36f23f1f, var_dbaa74e2) {
    if (isdefined(level.disablemomentum) && level.disablemomentum == 1) {
        return;
    }
    if (level.var_73e51905 === 1 && getdvarint(#"hash_1aa5f986ed71357d", 1) != 0) {
        if (isdefined(player) && !isalive(player)) {
            return;
        }
    }
    score = player rank::getscoreinfovalue(event);
    assert(isdefined(score));
    label = rank::getscoreinfolabel(event);
    eventindex = level.scoreinfo[event][#"row"];
    combatefficiencyscore = 0;
    if (player ability_util::gadget_combat_efficiency_enabled()) {
        combatefficiencyscore = rank::function_4587103(event);
        if (isdefined(combatefficiencyscore) && combatefficiencyscore > 0) {
            player ability_util::gadget_combat_efficiency_power_drain(combatefficiencyscore);
            slot = -1;
            if (isdefined(weapon)) {
                slot = player gadgetgetslot(weapon);
                hero_slot = player ability_util::gadget_slot_for_type(11);
            }
        }
    }
    if (score == 0 && combatefficiencyscore == 0) {
        return;
    }
    if (event == "death") {
        _setplayermomentum(victim, victim.pers[#"momentum"] + score);
    }
    if (level.gameended) {
        return;
    }
    if (!isdefined(label)) {
        player giveplayermomentumnotification(score, #"hash_480234a872bd64ac", descvalue, weapon, combatefficiencyscore, eventindex, event, var_36f23f1f, var_dbaa74e2);
        return;
    }
    player giveplayermomentumnotification(score, label, descvalue, weapon, combatefficiencyscore, eventindex, event, var_36f23f1f, var_dbaa74e2);
}

// Namespace globallogic_score/globallogic_score
// Params 7, eflags: 0x0
// Checksum 0x43c73512, Offset: 0x1e70
// Size: 0x27e
function giveplayerscore(event, player, victim, descvalue, weapon = level.weaponnone, var_36f23f1f, var_dbaa74e2) {
    scorediff = 0;
    momentum = player.pers[#"momentum"];
    giveplayermomentum(event, player, victim, descvalue, weapon, var_36f23f1f, var_dbaa74e2);
    newmomentum = player.pers[#"momentum"];
    if (level.overrideplayerscore) {
        return 0;
    }
    pixbeginevent(#"");
    score = player.pers[#"score"];
    [[ level.onplayerscore ]](event, player, victim);
    newscore = player.pers[#"score"];
    profilestop();
    scorediff = newscore - score;
    mpplayerscore = {};
    mpplayerscore.gamemode = level.gametype;
    mpplayerscore.spawnid = getplayerspawnid(player);
    mpplayerscore.gametime = function_f8d53445();
    mpplayerscore.type = ishash(event) ? event : hash(event);
    mpplayerscore.isscoreevent = scoreevents::isregisteredevent(event);
    mpplayerscore.delta = scorediff;
    mpplayerscore.deltamomentum = newmomentum - momentum;
    mpplayerscore.team = player.team;
    mpplayerscore.is_wearing_armor = player armor::has_armor();
    mpplayerscore.weapon = weapon.name;
    self thread function_3172cf59(player, newscore, weapon, mpplayerscore);
    if (scorediff > 0) {
        return scorediff;
    }
    return 0;
}

// Namespace globallogic_score/globallogic_score
// Params 0, eflags: 0x0
// Checksum 0xcee3ef95, Offset: 0x20f8
// Size: 0x78
function function_e1573815() {
    if (!isdefined(level.var_a5c930dd)) {
        level.var_a5c930dd = 0;
    }
    if (!isdefined(level.var_445b1bca)) {
        level.var_445b1bca = 0;
    }
    while (level.var_a5c930dd == gettime() || level.var_445b1bca == gettime()) {
        waitframe(1);
    }
    level.var_a5c930dd = gettime();
}

// Namespace globallogic_score/globallogic_score
// Params 4, eflags: 0x0
// Checksum 0xcb80e835, Offset: 0x2178
// Size: 0x50e
function function_3172cf59(player, newscore, weapon, mpplayerscore) {
    player endon(#"disconnect");
    function_e1573815();
    pixbeginevent(#"");
    event = mpplayerscore.type;
    scorediff = mpplayerscore.delta;
    if (sessionmodeismultiplayergame() && !isbot(player)) {
        function_92d1707f(#"hash_120b2cf3162c3bc1", mpplayerscore);
    }
    player bb::add_to_stat("score", mpplayerscore.delta);
    if (!isbot(player)) {
        if (!isdefined(player.pers[#"scoreeventcache"])) {
            player.pers[#"scoreeventcache"] = [];
        }
        if (!isdefined(player.pers[#"scoreeventcache"][event])) {
            player.pers[#"scoreeventcache"][event] = 1;
        } else {
            player.pers[#"scoreeventcache"][event] = player.pers[#"scoreeventcache"][event] + 1;
        }
    }
    if (scorediff <= 0) {
        profilestop();
        return;
    }
    recordplayerstats(player, "score", newscore);
    challengesenabled = !level.disablechallenges;
    player stats::function_bb7eedf0(#"score", scorediff);
    if (challengesenabled) {
        player stats::function_dad108fa(#"career_score", scorediff);
        scoreevents = function_3cbc4c6c(weapon.var_2e4a8800);
        var_8a4cfbd = weapon.var_76ce72e8 && isdefined(scoreevents) && scoreevents.var_fcd2ff3a === 1;
        if (var_8a4cfbd) {
            player stats::function_dad108fa(#"score_specialized_equipment", scorediff);
        } else if (weapon.issignatureweapon) {
            player stats::function_dad108fa(#"score_specialized_weapons", scorediff);
        }
    }
    if (level.hardcoremode) {
        player stats::function_dad108fa(#"score_hc", scorediff);
        if (challengesenabled) {
            player stats::function_dad108fa(#"career_score_hc", scorediff);
        }
    } else if (level.arenamatch) {
        player stats::function_bb7eedf0(#"score_arena", scorediff);
    } else {
        player stats::function_bb7eedf0(#"score_core", scorediff);
    }
    if (level.multiteam) {
        player stats::function_dad108fa(#"score_multiteam", scorediff);
        if (challengesenabled) {
            player stats::function_dad108fa(#"career_score_multiteam", scorediff);
        }
    }
    player contracts::player_contract_event(#"score", newscore, scorediff);
    if (isdefined(weapon) && killstreaks::is_killstreak_weapon(weapon)) {
        killstreak = killstreaks::get_from_weapon(weapon);
        killstreakpurchased = 0;
        if (isdefined(killstreak) && isdefined(level.killstreaks[killstreak])) {
            killstreakpurchased = player util::is_item_purchased(level.killstreaks[killstreak].menuname);
        }
        player contracts::player_contract_event(#"killstreak_score", scorediff, killstreakpurchased);
    }
    profilestop();
}

// Namespace globallogic_score/globallogic_score
// Params 3, eflags: 0x0
// Checksum 0xe7ff5071, Offset: 0x2690
// Size: 0x144
function default_onplayerscore(event, player, *victim) {
    score = victim rank::getscoreinfovalue(player);
    rolescore = victim rank::getscoreinfoposition(player);
    objscore = 0;
    if (victim rank::function_f7b5d9fa(player)) {
        objscore = score;
    }
    assert(isdefined(score));
    if (level.var_73e51905 === 1 && getdvarint(#"hash_1aa5f986ed71357d", 1) != 0) {
        if (isdefined(victim) && !isalive(victim)) {
            score = 0;
            objscore = 0;
            rolescore = 0;
        }
    }
    function_889ed975(victim, score, objscore, rolescore);
}

// Namespace globallogic_score/globallogic_score
// Params 2, eflags: 0x0
// Checksum 0x4383707f, Offset: 0x27e0
// Size: 0x6e
function function_37d62931(player, amount) {
    player.pers[#"objectives"] = player.pers[#"objectives"] + amount;
    player.objectives = player.pers[#"objectives"];
}

// Namespace globallogic_score/globallogic_score
// Params 4, eflags: 0x0
// Checksum 0x82c2ef0f, Offset: 0x2858
// Size: 0x22e
function _setplayerscore(player, score, var_e21e8076, var_53c3aa0b) {
    if (score != player.pers[#"score"]) {
        player.pers[#"score"] = score;
        player.score = player.pers[#"score"];
        recordplayerstats(player, "score", player.pers[#"score"]);
    }
    if (isdefined(var_53c3aa0b) && var_53c3aa0b != player.pers[#"rolescore"]) {
        player.pers[#"rolescore"] = var_53c3aa0b;
        player.rolescore = player.pers[#"rolescore"];
    }
    if (isdefined(var_e21e8076) && var_e21e8076 != player.pers[#"objscore"]) {
        amount = var_e21e8076 - player.pers[#"objscore"] + player stats::get_stat(#"playerstatsbygametype", level.var_12323003, #"objective_score", #"statvalue");
        player stats::set_stat(#"playerstatsbygametype", level.var_12323003, #"objective_score", #"statvalue", amount);
        player.pers[#"objscore"] = var_e21e8076;
        player.objscore = player.pers[#"objscore"];
    }
}

// Namespace globallogic_score/globallogic_score
// Params 1, eflags: 0x0
// Checksum 0xcd5f235e, Offset: 0x2a90
// Size: 0x24
function _getplayerscore(player) {
    return player.pers[#"score"];
}

// Namespace globallogic_score/globallogic_score
// Params 2, eflags: 0x0
// Checksum 0x814510dc, Offset: 0x2ac0
// Size: 0x64
function function_17a678b7(player, scoresub) {
    score = player.pers[#"score"] - scoresub;
    if (score < 0) {
        score = 0;
    }
    _setplayerscore(player, score);
}

// Namespace globallogic_score/globallogic_score
// Params 4, eflags: 0x0
// Checksum 0xa643fa6c, Offset: 0x2b30
// Size: 0x16c
function function_889ed975(player, score_add, var_252f7989, var_f8258842) {
    /#
        var_1eb7c454 = getdvarfloat(#"hash_eae9a8ee387705d", 1);
        score_add = int(score_add * var_1eb7c454);
        var_252f7989 = int(var_252f7989 * var_1eb7c454);
        var_f8258842 = int(var_f8258842 * var_1eb7c454);
    #/
    score = player.pers[#"score"] + score_add;
    var_e21e8076 = player.pers[#"objscore"];
    if (isdefined(var_252f7989)) {
        var_e21e8076 += var_252f7989;
    }
    var_53c3aa0b = player.pers[#"rolescore"];
    if (isdefined(var_f8258842)) {
        var_53c3aa0b += var_f8258842;
    }
    _setplayerscore(player, score, var_e21e8076, var_53c3aa0b);
}

// Namespace globallogic_score/globallogic_score
// Params 1, eflags: 0x0
// Checksum 0xf4aaac40, Offset: 0x2ca8
// Size: 0xac
function setpointstowin(points) {
    self.pers[#"pointstowin"] = math::clamp(points, 0, 65000);
    self.pointstowin = self.pers[#"pointstowin"];
    self thread globallogic::checkscorelimit();
    self thread globallogic::checkroundscorelimit();
    self thread globallogic::checkplayerscorelimitsoon();
}

// Namespace globallogic_score/globallogic_score
// Params 1, eflags: 0x0
// Checksum 0xc8db95f5, Offset: 0x2d60
// Size: 0x3c
function givepointstowin(points) {
    self setpointstowin(self.pers[#"pointstowin"] + points);
}

// Namespace globallogic_score/globallogic_score
// Params 3, eflags: 0x0
// Checksum 0xa074c2f4, Offset: 0x2da8
// Size: 0x7a
function _setplayermomentum(player, momentum, updatescore = 1) {
    if (level.var_5b544215 != 2 || momentum > 0) {
        profilestart();
        if (isdefined(level.var_43723615)) {
            self [[ level.var_43723615 ]](player, momentum, updatescore);
        }
        profilestop();
    }
}

// Namespace globallogic_score/globallogic_score
// Params 3, eflags: 0x0
// Checksum 0xd90d574f, Offset: 0x2e30
// Size: 0x2ac
function function_3ba7c551(player, momentum, updatescore) {
    momentum = math::clamp(momentum, 0, getdvarint(#"hash_6cc2b9f9d4cbe073", 20000));
    oldmomentum = player.pers[#"momentum"];
    if (momentum == oldmomentum) {
        return;
    }
    if (updatescore) {
        player bb::add_to_stat("momentum", momentum - oldmomentum);
    }
    if (momentum > oldmomentum) {
        highestmomentumcost = 0;
        numkillstreaks = 0;
        if (isdefined(player.killstreak)) {
            numkillstreaks = player.killstreak.size;
        }
        killstreaktypearray = [];
        for (currentkillstreak = 0; currentkillstreak < numkillstreaks; currentkillstreak++) {
            killstreaktype = killstreaks::get_by_menu_name(player.killstreak[currentkillstreak]);
            if (isdefined(killstreaktype)) {
                momentumcost = player function_dceb5542(level.killstreaks[killstreaktype].itemindex);
                if (momentumcost > highestmomentumcost) {
                    highestmomentumcost = momentumcost;
                }
                killstreaktypearray[killstreaktypearray.size] = killstreaktype;
            }
        }
        function_1b25db30(player, momentum, oldmomentum, killstreaktypearray);
        while (highestmomentumcost > 0 && momentum >= highestmomentumcost) {
            oldmomentum = 0;
            momentum -= highestmomentumcost;
            function_1b25db30(player, momentum, oldmomentum, killstreaktypearray);
        }
    }
    player.pers[#"momentum"] = momentum;
    player.momentum = player.pers[#"momentum"];
    /#
        if (getdvarint(#"hash_4f17b3fc9d5ba79a", 0) > 0) {
            iprintln("<dev string:x38>" + player.pers[#"momentum"]);
        }
    #/
}

// Namespace globallogic_score/globallogic_score
// Params 3, eflags: 0x0
// Checksum 0x8fd85bce, Offset: 0x30e8
// Size: 0x304
function function_5dda25b9(player, momentum, updatescore) {
    momentum = math::clamp(momentum, 0, getdvarint(#"hash_6cc2b9f9d4cbe073", 20000));
    oldmomentum = player.pers[#"momentum"];
    if (momentum == oldmomentum) {
        return;
    }
    if (updatescore) {
        player bb::add_to_stat("momentum", momentum - oldmomentum);
    }
    player.pers[#"momentum"] = momentum;
    player.momentum = player.pers[#"momentum"];
    for (i = 0; i < 3; i++) {
        killstreaktype = killstreaks::get_by_menu_name(player.killstreak[i]);
        if (isdefined(killstreaktype)) {
            weapon = killstreaks::get_killstreak_weapon(killstreaktype);
            var_1f8971a2 = isdefined(player.pers[#"held_killstreak_ammo_count"][weapon]) && player.pers[#"held_killstreak_ammo_count"][weapon] > 0;
            var_6a0527c5 = isdefined(level.var_a385666[killstreaktype]) ? [[ level.var_a385666[killstreaktype] ]](i) : 0;
            if (function_bb8a71b(player, killstreaktype) && function_605fde09(player, killstreaktype) && player killstreakrules::iskillstreakallowed(killstreaktype, player.team, 0) && !var_1f8971a2 && !var_6a0527c5) {
                player killstreaks::add_to_notification_queue(level.killstreaks[killstreaktype].menuname, undefined, killstreaktype, 0, 0);
            }
        }
    }
    /#
        if (getdvarint(#"hash_4f17b3fc9d5ba79a", 0) > 0) {
            iprintln("<dev string:x46>" + player.pers[#"momentum"]);
        }
    #/
}

// Namespace globallogic_score/globallogic_score
// Params 2, eflags: 0x4
// Checksum 0x7424a058, Offset: 0x33f8
// Size: 0x128
function private function_bb8a71b(player, killstreaktype) {
    if (isdefined(killstreaktype)) {
        momentum = player.pers[#"momentum"];
        streakcost = player function_dceb5542(level.killstreaks[killstreaktype].itemindex);
        if (player killstreakrules::function_40451ab0(killstreaktype)) {
            if (player.pers[#"hash_b05d8e95066f3ce"][killstreaktype] !== 1) {
                player.pers[#"hash_b05d8e95066f3ce"][killstreaktype] = 1;
                return true;
            }
        } else if (player.pers[#"hash_b05d8e95066f3ce"][killstreaktype] === 1) {
            player.pers[#"hash_b05d8e95066f3ce"][killstreaktype] = 0;
        }
    }
    return false;
}

// Namespace globallogic_score/globallogic_score
// Params 1, eflags: 0x0
// Checksum 0xf669399f, Offset: 0x3528
// Size: 0x244
function function_4301d2e0(player) {
    for (slot = 0; slot < 3; slot++) {
        killstreaktype = killstreaks::get_by_menu_name(player.killstreak[slot]);
        var_dc3a7628 = 0;
        if (isdefined(killstreaktype)) {
            var_464ac60 = player.pers[level.var_e57efb05[slot]];
            var_b961672f = level.var_b961672f;
            killstreakweapon = killstreaks::get_killstreak_weapon(killstreaktype);
            if (isdefined(level.killstreakdeathpenaltyindividualearn[killstreakweapon.statname])) {
                var_b961672f = level.killstreakdeathpenaltyindividualearn[killstreakweapon.statname];
            }
            var_d152ff83 = player function_95ecfff8();
            var_c64c6d64 = var_464ac60 * var_b961672f - var_d152ff83;
            if (var_c64c6d64 < 0) {
                var_c64c6d64 = 0;
            }
            var_dc3a7628 = int(floor((var_464ac60 - var_c64c6d64) / 10) * 10);
            var_dc3a7628 = math::clamp(var_dc3a7628, 0, getdvarint(#"hash_6cc2b9f9d4cbe073", 20000));
        }
        player.pers[level.var_e57efb05[slot]] = var_dc3a7628;
        player function_2c334e8f(slot, var_dc3a7628);
        /#
            if (getdvarint(#"hash_4f17b3fc9d5ba79a", 0) > 0) {
                iprintln(killstreaktype + "<dev string:x51>" + var_dc3a7628);
            }
        #/
    }
}

// Namespace globallogic_score/globallogic_score
// Params 1, eflags: 0x0
// Checksum 0xf3553ff3, Offset: 0x3778
// Size: 0x104
function function_fd1f8965(player) {
    for (slot = 0; slot < 3; slot++) {
        killstreaktype = killstreaks::get_by_menu_name(player.killstreak[slot]);
        var_dc3a7628 = 0;
        if (isdefined(killstreaktype)) {
            var_dc3a7628 = player.pers[level.var_e57efb05[slot]];
            var_dc3a7628 = math::clamp(var_dc3a7628, 0, getdvarint(#"hash_6cc2b9f9d4cbe073", 20000));
        }
        player.pers[level.var_e57efb05[slot]] = var_dc3a7628;
        player function_2c334e8f(slot, var_dc3a7628);
    }
}

// Namespace globallogic_score/globallogic_score
// Params 1, eflags: 0x0
// Checksum 0xe0f71271, Offset: 0x3888
// Size: 0x204
function function_fdbd4189(player) {
    oldmomentum = player.pers[#"momentum"];
    var_d152ff83 = player function_95ecfff8();
    var_c64c6d64 = oldmomentum * level.var_b961672f - var_d152ff83;
    if (var_c64c6d64 < 0) {
        var_c64c6d64 = 0;
    }
    var_4c619c7a = int(floor((oldmomentum - var_c64c6d64) / 10) * 10);
    var_4c619c7a = math::clamp(var_4c619c7a, 0, getdvarint(#"hash_6cc2b9f9d4cbe073", 20000));
    player.pers[#"momentum"] = var_4c619c7a;
    player.momentum = player.pers[#"momentum"];
    if (var_4c619c7a !== oldmomentum) {
        for (i = 0; i < 3; i++) {
            killstreaktype = killstreaks::get_by_menu_name(player.killstreak[i]);
            function_bb8a71b(player, killstreaktype);
        }
    }
    /#
        if (getdvarint(#"hash_4f17b3fc9d5ba79a", 0) > 0) {
            iprintln("<dev string:x46>" + var_4c619c7a);
        }
    #/
}

// Namespace globallogic_score/globallogic_score
// Params 1, eflags: 0x0
// Checksum 0xec5b9e6c, Offset: 0x3a98
// Size: 0x154
function function_b58be5d(player) {
    oldmomentum = player.pers[#"momentum"];
    var_d152ff83 = player function_95ecfff8();
    var_559e5a31 = math::clamp(player function_3ef59ab3(), 0, 1);
    var_c64c6d64 = oldmomentum * var_559e5a31 - var_d152ff83;
    if (var_c64c6d64 < 0) {
        var_c64c6d64 = 0;
    }
    new_momentum = int(oldmomentum - var_c64c6d64);
    _setplayermomentum(player, new_momentum);
    /#
        if (getdvarint(#"hash_4f17b3fc9d5ba79a", 0) > 0) {
            iprintln("<dev string:x38>" + player.pers[#"momentum"]);
        }
    #/
}

// Namespace globallogic_score/globallogic_score
// Params 3, eflags: 0x0
// Checksum 0x17d48b81, Offset: 0x3bf8
// Size: 0xd4
function function_94765bca(player, momentum, *updatescore) {
    if (!isdefined(level.var_212e8400)) {
        level.var_212e8400 = [];
    }
    entnum = momentum getentitynumber();
    if (!isdefined(level.var_212e8400[entnum])) {
        level.var_212e8400[entnum] = 0;
    }
    level.var_212e8400[entnum] = level.var_212e8400[entnum] + updatescore;
    if (level.var_8a1954d1 !== 1) {
        level thread function_4f4a98bf(momentum, updatescore);
    }
}

// Namespace globallogic_score/globallogic_score
// Params 2, eflags: 0x4
// Checksum 0xaa1cf645, Offset: 0x3cd8
// Size: 0xde
function private function_4f4a98bf(player, momentum) {
    level.var_8a1954d1 = 1;
    waittillframeend();
    foreach (entnum, momentum in level.var_212e8400) {
        player = getentbynum(entnum);
        if (!isdefined(player)) {
            continue;
        }
        function_c17ecb35(player, momentum);
    }
    level.var_212e8400 = undefined;
    level.var_8a1954d1 = undefined;
}

// Namespace globallogic_score/globallogic_score
// Params 2, eflags: 0x4
// Checksum 0x265a9b7, Offset: 0x3dc0
// Size: 0x306
function private function_c17ecb35(player, momentum) {
    momentum = math::clamp(momentum, 0, getdvarint(#"hash_6cc2b9f9d4cbe073", 20000));
    oldmomentum = player.pers[#"momentum"];
    assert(oldmomentum == 0);
    if (momentum == oldmomentum) {
        return;
    }
    deltamomentum = momentum - oldmomentum;
    if (deltamomentum > 0) {
        numkillstreaks = 0;
        if (isdefined(player.killstreak)) {
            numkillstreaks = player.killstreak.size;
        }
        for (slot = 0; slot < numkillstreaks; slot++) {
            var_dc3a7628 = 0;
            killstreaktype = killstreaks::get_by_menu_name(player.killstreak[slot]);
            if (!isdefined(level.var_e57efb05[slot])) {
                continue;
            }
            if (isdefined(killstreaktype) && function_1d5c913f(player, killstreaktype)) {
                momentumcost = player function_dceb5542(level.killstreaks[killstreaktype].itemindex);
                var_464ac60 = player.pers[level.var_e57efb05[slot]];
                var_dc3a7628 = var_464ac60 + deltamomentum;
                given = function_9492ba27(player, var_dc3a7628, var_464ac60, killstreaktype);
                if (var_dc3a7628 > momentumcost) {
                    var_dc3a7628 = momentumcost;
                }
                if (given) {
                    var_dc3a7628 -= momentumcost;
                    assert(var_dc3a7628 >= 0);
                }
            }
            /#
                if (getdvarint(#"hash_4f17b3fc9d5ba79a", 0) > 0) {
                    iprintln(killstreaktype + "<dev string:x51>" + var_dc3a7628);
                }
            #/
            player.pers[level.var_e57efb05[slot]] = var_dc3a7628;
            player function_2c334e8f(slot, var_dc3a7628);
        }
    }
    player.pers[#"momentum"] = 0;
    player.momentum = player.pers[#"momentum"];
}

// Namespace globallogic_score/globallogic_score
// Params 2, eflags: 0x0
// Checksum 0xa709255a, Offset: 0x40d0
// Size: 0x210
function function_1d5c913f(player, killstreaktype) {
    weapon = killstreaks::get_killstreak_weapon(killstreaktype);
    if ((isdefined(player.pers[#"killstreak_quantity"][weapon]) ? player.pers[#"killstreak_quantity"][weapon] : 0) >= level.scorestreaksmaxstacking) {
        return false;
    }
    var_d0ecbc61 = getdvarint(#"hash_71ffe2a6c9f43529", 0) != 0;
    activekillstreaks = player killstreaks::getactivekillstreaks();
    if (isdefined(activekillstreaks)) {
        foreach (killstreak in activekillstreaks) {
            if (killstreak.killstreaktype === killstreaktype) {
                if (var_d0ecbc61) {
                    if (!player killstreaks::function_55e3fed6(killstreaktype)) {
                        return false;
                    }
                    continue;
                }
                return false;
            }
        }
    }
    if (isdefined(player.pers[#"held_killstreak_ammo_count"][weapon])) {
        if (player.pers[#"held_killstreak_ammo_count"][weapon] > 0) {
            return false;
        }
    }
    if (!var_d0ecbc61 && player killstreaks::function_55e3fed6(killstreaktype)) {
        return false;
    }
    return true;
}

// Namespace globallogic_score/globallogic_score
// Params 2, eflags: 0x0
// Checksum 0xbacd40f7, Offset: 0x42e8
// Size: 0x176
function function_605fde09(player, killstreaktype) {
    weapon = killstreaks::get_killstreak_weapon(killstreaktype);
    if ((isdefined(player.pers[#"killstreak_quantity"][weapon]) ? player.pers[#"killstreak_quantity"][weapon] : 0) >= level.scorestreaksmaxstacking) {
        return false;
    }
    if (!isalive(player)) {
        return false;
    }
    activekillstreaks = player killstreaks::getactivekillstreaks();
    if (isdefined(activekillstreaks)) {
        foreach (killstreak in activekillstreaks) {
            if (killstreak.killstreaktype === killstreaktype) {
                return false;
            }
        }
    }
    if (player killstreaks::function_55e3fed6(killstreaktype)) {
        return false;
    }
    return true;
}

// Namespace globallogic_score/globallogic_score
// Params 4, eflags: 0x0
// Checksum 0x6084d1f, Offset: 0x4468
// Size: 0x74
function function_1b25db30(player, momentum, oldmomentum, killstreaktypearray) {
    for (killstreaktypeindex = 0; killstreaktypeindex < killstreaktypearray.size; killstreaktypeindex++) {
        killstreaktype = killstreaktypearray[killstreaktypeindex];
        self function_d6377216(player, momentum, oldmomentum, killstreaktype);
    }
}

// Namespace globallogic_score/globallogic_score
// Params 4, eflags: 0x0
// Checksum 0x3fc61da5, Offset: 0x44e8
// Size: 0x52
function function_9492ba27(player, momentum, oldmomentum, killstreaktype) {
    given = self function_d6377216(player, momentum, oldmomentum, killstreaktype);
    return given;
}

// Namespace globallogic_score/globallogic_score
// Params 4, eflags: 0x0
// Checksum 0x474d3d81, Offset: 0x4548
// Size: 0x5c2
function function_d6377216(player, momentum, oldmomentum, killstreaktype) {
    given = 0;
    var_2b85d59c = is_true(level.var_2b85d59c);
    momentumcost = player function_dceb5542(level.killstreaks[killstreaktype].itemindex);
    if (momentumcost > oldmomentum && momentumcost <= momentum) {
        weapon = killstreaks::get_killstreak_weapon(killstreaktype);
        was_already_at_max_stacking = 0;
        if (is_true(level.usingscorestreaks)) {
            if (isdefined(level.var_ed3e6ff3)) {
                player [[ level.var_ed3e6ff3 ]](weapon, momentum);
            }
            if (weapon.iscarriedkillstreak) {
                if (!isdefined(player.pers[#"held_killstreak_ammo_count"][weapon])) {
                    player.pers[#"held_killstreak_ammo_count"][weapon] = 0;
                }
                if (!isdefined(player.pers[#"killstreak_quantity"][weapon])) {
                    player.pers[#"killstreak_quantity"][weapon] = 0;
                }
                currentweapon = player getcurrentweapon();
                if (currentweapon == weapon) {
                    if (player.pers[#"killstreak_quantity"][weapon] < level.scorestreaksmaxstacking) {
                        player.pers[#"killstreak_quantity"][weapon]++;
                        given = 1;
                    }
                } else {
                    player.pers[#"held_killstreak_clip_count"][weapon] = weapon.clipsize;
                    player.pers[#"held_killstreak_ammo_count"][weapon] = weapon.maxammo;
                    player loadout::function_3ba6ee5d(weapon, player.pers[#"held_killstreak_ammo_count"][weapon]);
                    given = 1;
                }
            } else {
                old_killstreak_quantity = player killstreaks::get_killstreak_quantity(weapon);
                new_killstreak_quantity = player killstreaks::change_killstreak_quantity(weapon, 1);
                was_already_at_max_stacking = new_killstreak_quantity == old_killstreak_quantity;
                if (!was_already_at_max_stacking) {
                    player challenges::earnedkillstreak();
                    player contracts::increment_contract(#"hash_3ddcd024e6e13a32");
                    if (player ability_util::gadget_is_active(12)) {
                        scoreevents::processscoreevent(#"focus_earn_scorestreak", player, undefined, undefined);
                        player scoreevents::specialistmedalachievement();
                        player scoreevents::specialiststatabilityusage(4, 1);
                        if (player.heroability.name == "gadget_combat_efficiency") {
                            player stats::function_e24eec31(player.heroability, #"scorestreaks_earned", 1);
                            if (!isdefined(player.scorestreaksearnedperuse)) {
                                player.scorestreaksearnedperuse = 0;
                            }
                            player.scorestreaksearnedperuse++;
                            if (player.scorestreaksearnedperuse >= 3) {
                                scoreevents::processscoreevent(#"focus_earn_multiscorestreak", player, undefined, undefined);
                                player.scorestreaksearnedperuse = 0;
                            }
                        }
                    }
                }
            }
            if (!was_already_at_max_stacking) {
                given = 1;
                if (player.pers[#"hash_b05d8e95066f3ce"][killstreaktype] === 1) {
                    var_2b85d59c = 1;
                }
                if (level.var_5b544215 == 2 && player killstreaks::function_55e3fed6(killstreaktype)) {
                    var_2b85d59c = 1;
                }
                player killstreaks::add_to_notification_queue(level.killstreaks[killstreaktype].menuname, new_killstreak_quantity, killstreaktype, var_2b85d59c, 0);
            }
        } else {
            player killstreaks::add_to_notification_queue(level.killstreaks[killstreaktype].menuname, 0, killstreaktype, var_2b85d59c, 0);
            activeeventname = "reward_active";
            if (isdefined(weapon)) {
                neweventname = weapon.name + "_active";
                if (scoreevents::isregisteredevent(neweventname)) {
                    activeeventname = neweventname;
                }
            }
        }
    }
    return given;
}

// Namespace globallogic_score/globallogic_score
// Params 2, eflags: 0x0
// Checksum 0x76d052b0, Offset: 0x4b18
// Size: 0x40
function function_3bd226fa(killstreaktype, var_9595834) {
    if (!isdefined(level.var_a385666)) {
        level.var_a385666 = [];
    }
    level.var_a385666[killstreaktype] = var_9595834;
}

// Namespace globallogic_score/globallogic_score
// Params 2, eflags: 0x0
// Checksum 0x5fd88e70, Offset: 0x4b60
// Size: 0x450
function function_13123cee(player, killstreakslot) {
    if (game.state != #"playing") {
        return 0;
    }
    if (!isalive(player)) {
        return 0;
    }
    killstreaktype = killstreaks::get_by_menu_name(player.killstreak[killstreakslot]);
    if (killstreaks::should_delay_killstreak(killstreaktype)) {
        killstreaks::display_unavailable_time();
        return 0;
    }
    given = 0;
    if (isdefined(killstreaktype)) {
        weapon = killstreaks::get_killstreak_weapon(killstreaktype);
        if (weapon.issupplydropweapon) {
            if (player getammocount(weapon) > 0) {
                player switchtoweapon(weapon);
                return 0;
            }
        }
        if (isdefined(player.pers[#"held_killstreak_ammo_count"][weapon])) {
            if (player.pers[#"held_killstreak_ammo_count"][weapon] > 0) {
                player switchtoweapon(weapon);
                return 0;
            }
        }
        if (isdefined(level.var_a385666[killstreaktype])) {
            var_6a0527c5 = [[ level.var_a385666[killstreaktype] ]](killstreakslot);
            if (var_6a0527c5) {
                player switchtoweapon(weapon);
                return 0;
            }
        }
        if (player getammocount(weapon) > 0) {
            player switchtoweapon(weapon);
            return 0;
        }
        momentum = player.pers[#"momentum"];
        if (momentum > 0 && function_605fde09(player, killstreaktype) && player killstreakrules::iskillstreakallowed(killstreaktype, player.team, 0)) {
            momentumcost = player function_dceb5542(level.killstreaks[killstreaktype].itemindex);
            given = function_9492ba27(player, momentum, 0, killstreaktype);
            if (given) {
                momentum -= momentumcost;
                player.pers[#"momentum"] = momentum;
                player.momentum = player.pers[#"momentum"];
                for (i = 0; i < 3; i++) {
                    var_d64761c7 = killstreaks::get_by_menu_name(player.killstreak[i]);
                    if (isdefined(var_d64761c7)) {
                        streakcost = player function_dceb5542(level.killstreaks[var_d64761c7].itemindex);
                        if (player.momentum < streakcost) {
                            player.pers[#"hash_b05d8e95066f3ce"][var_d64761c7] = 0;
                        }
                    }
                }
                /#
                    if (getdvarint(#"hash_4f17b3fc9d5ba79a", 0) > 0) {
                        iprintln("<dev string:x46>" + momentum);
                    }
                #/
            }
        }
    }
    return given;
}

// Namespace globallogic_score/globallogic_score
// Params 3, eflags: 0x0
// Checksum 0x8b069f2a, Offset: 0x4fb8
// Size: 0x198
function function_8b375624(player, killstreaktype, momentumcost) {
    given = 0;
    if (isdefined(killstreaktype)) {
        weapon = killstreaks::get_killstreak_weapon(killstreaktype);
        if (isdefined(player.pers[#"held_killstreak_ammo_count"][weapon])) {
            if (player.pers[#"held_killstreak_ammo_count"][weapon] > 0) {
                player switchtoweapon(weapon);
                return 0;
            }
        }
        momentum = player.pers[#"momentum"];
        if (momentum >= momentumcost && function_605fde09(player, killstreaktype)) {
            momentum -= momentumcost;
            player.pers[#"momentum"] = momentum;
            player.momentum = player.pers[#"momentum"];
            given = 1;
            /#
                if (getdvarint(#"hash_4f17b3fc9d5ba79a", 0) > 0) {
                    iprintln("<dev string:x46>" + momentum);
                }
            #/
        }
    }
    return given;
}

/#

    // Namespace globallogic_score/globallogic_score
    // Params 0, eflags: 0x0
    // Checksum 0x11f5729e, Offset: 0x5158
    // Size: 0x118
    function setplayermomentumdebug() {
        setdvar(#"sv_momentumpercent", 0);
        while (true) {
            wait 1;
            var_2227c36c = getdvarfloat(#"sv_momentumpercent", 0);
            if (var_2227c36c != 0) {
                player = util::gethostplayer();
                if (!isdefined(player)) {
                    return;
                }
                if (isdefined(player.killstreak)) {
                    _setplayermomentum(player, int(getdvarint(#"hash_6cc2b9f9d4cbe073", 20000) * var_2227c36c / 100));
                }
            }
        }
    }

#/

// Namespace globallogic_score/globallogic_score
// Params 4, eflags: 0x0
// Checksum 0x915afd15, Offset: 0x5278
// Size: 0x19c
function giveteamscore(event, team, *player, *victim) {
    if (level.overrideteamscore) {
        return;
    }
    pixbeginevent(#"");
    teamscore = game.stat[#"teamscores"][victim];
    [[ level.onteamscore ]](player, victim);
    profilestop();
    newscore = game.stat[#"teamscores"][victim];
    if (sessionmodeismultiplayergame()) {
        mpteamscores = {#gametime:function_f8d53445(), #event:player, #team:victim, #diff:newscore - teamscore, #score:newscore};
        function_92d1707f(#"hash_48d5ef92d24477d2", mpteamscores);
    }
    if (teamscore == newscore) {
        return;
    }
    updateteamscores(victim);
    thread globallogic::checkscorelimit();
    thread globallogic::checkroundscorelimit();
}

// Namespace globallogic_score/globallogic_score
// Params 2, eflags: 0x0
// Checksum 0xd4b34b0f, Offset: 0x5420
// Size: 0x13c
function giveteamscoreforobjective_delaypostprocessing(team, score) {
    teamscore = game.stat[#"teamscores"][team];
    onteamscore_incrementscore(score, team);
    newscore = game.stat[#"teamscores"][team];
    if (sessionmodeismultiplayergame()) {
        mpteamobjscores = {#gametime:function_f8d53445(), #team:team, #diff:newscore - teamscore, #score:newscore};
        function_92d1707f(#"hash_22921c2c027fa389", mpteamobjscores);
    }
    if (teamscore == newscore) {
        return;
    }
    updateteamscores(team);
}

// Namespace globallogic_score/globallogic_score
// Params 0, eflags: 0x0
// Checksum 0x15edfff2, Offset: 0x5568
// Size: 0x34
function postprocessteamscores() {
    onteamscore_postprocess();
    thread globallogic::checkscorelimit();
    thread globallogic::checkroundscorelimit();
}

// Namespace globallogic_score/globallogic_score
// Params 2, eflags: 0x0
// Checksum 0xf2b3e576, Offset: 0x55a8
// Size: 0x18c
function giveteamscoreforobjective(team, score) {
    if (!isdefined(level.teams[team])) {
        return;
    }
    teamscore = game.stat[#"teamscores"][team];
    onteamscore(score, team);
    newscore = game.stat[#"teamscores"][team];
    if (sessionmodeismultiplayergame()) {
        mpteamobjscores = {#gametime:function_f8d53445(), #team:team, #diff:newscore - teamscore, #score:newscore};
        function_92d1707f(#"hash_22921c2c027fa389", mpteamobjscores);
    }
    if (teamscore == newscore) {
        return;
    }
    updateteamscores(team);
    thread globallogic::checkscorelimit();
    thread globallogic::checkroundscorelimit();
    thread globallogic::checksuddendeathscorelimit(team);
}

// Namespace globallogic_score/globallogic_score
// Params 2, eflags: 0x0
// Checksum 0xe60f3a43, Offset: 0x5740
// Size: 0xa4
function _setteamscore(team, teamscore) {
    if (teamscore == game.stat[#"teamscores"][team]) {
        return;
    }
    game.stat[#"teamscores"][team] = math::clamp(teamscore, 0, 1000000);
    updateteamscores(team);
    thread globallogic::checkscorelimit();
    thread globallogic::checkroundscorelimit();
}

// Namespace globallogic_score/globallogic_score
// Params 0, eflags: 0x0
// Checksum 0xfe6b40ce, Offset: 0x57f0
// Size: 0xcc
function resetteamscores() {
    if (level.scoreroundwinbased || util::isfirstround()) {
        foreach (team, _ in level.teams) {
            game.stat[#"teamscores"][team] = 0;
        }
    }
    updateallteamscores();
}

// Namespace globallogic_score/globallogic_score
// Params 0, eflags: 0x0
// Checksum 0xb681981f, Offset: 0x58c8
// Size: 0x24
function resetallscores() {
    resetteamscores();
    resetplayerscores();
}

// Namespace globallogic_score/globallogic_score
// Params 0, eflags: 0x0
// Checksum 0x127729d, Offset: 0x58f8
// Size: 0x94
function resetplayerscores() {
    players = level.players;
    winner = undefined;
    tie = 0;
    for (i = 0; i < players.size; i++) {
        if (isdefined(players[i].pers[#"score"])) {
            _setplayerscore(players[i], 0);
        }
    }
}

// Namespace globallogic_score/globallogic_score
// Params 1, eflags: 0x0
// Checksum 0x1220d04c, Offset: 0x5998
// Size: 0x9c
function updateteamscores(team) {
    setteamscore(team, game.stat[#"teamscores"][team]);
    score = getteamscore(team);
    var_d0266750 = globallogic_utils::function_fd90317f(team, score);
    level thread globallogic::function_b6caec44(score, var_d0266750);
}

// Namespace globallogic_score/globallogic_score
// Params 0, eflags: 0x0
// Checksum 0xd401ba48, Offset: 0x5a40
// Size: 0x88
function updateallteamscores() {
    foreach (team, _ in level.teams) {
        updateteamscores(team);
    }
}

// Namespace globallogic_score/globallogic_score
// Params 1, eflags: 0x0
// Checksum 0xac9218ae, Offset: 0x5ad0
// Size: 0x26
function _getteamscore(team) {
    return game.stat[#"teamscores"][team];
}

// Namespace globallogic_score/globallogic_score
// Params 0, eflags: 0x0
// Checksum 0x9c476233, Offset: 0x5b00
// Size: 0xec
function gethighestteamscoreteam() {
    score = 0;
    winning_teams = [];
    foreach (team, _ in level.teams) {
        team_score = game.stat[#"teamscores"][team];
        if (team_score > score) {
            score = team_score;
            winning_teams = [];
        }
        if (team_score == score) {
            winning_teams[team] = team;
        }
    }
    return winning_teams;
}

// Namespace globallogic_score/globallogic_score
// Params 2, eflags: 0x0
// Checksum 0x5b51eee4, Offset: 0x5bf8
// Size: 0xaa
function areteamarraysequal(teamsa, teamsb) {
    if (teamsa.size != teamsb.size) {
        return false;
    }
    foreach (team in teamsa) {
        if (!isdefined(teamsb[team])) {
            return false;
        }
    }
    return true;
}

// Namespace globallogic_score/globallogic_score
// Params 2, eflags: 0x0
// Checksum 0x54f33e05, Offset: 0x5cb0
// Size: 0x3c
function onteamscore(score, team) {
    onteamscore_incrementscore(score, team);
    onteamscore_postprocess();
}

// Namespace globallogic_score/globallogic_score
// Params 2, eflags: 0x0
// Checksum 0xe036726f, Offset: 0x5cf8
// Size: 0x176
function onteamscore_incrementscore(score, team) {
    game.stat[#"teamscores"][team] = game.stat[#"teamscores"][team] + score;
    if (game.stat[#"teamscores"][team] < 0) {
        game.stat[#"teamscores"][team] = 0;
    }
    if (level.clampscorelimit) {
        if (level.scorelimit && game.stat[#"teamscores"][team] > level.scorelimit) {
            game.stat[#"teamscores"][team] = level.scorelimit;
        }
        if (level.roundscorelimit && game.stat[#"teamscores"][team] > util::get_current_round_score_limit()) {
            game.stat[#"teamscores"][team] = util::get_current_round_score_limit();
        }
    }
}

// Namespace globallogic_score/globallogic_score
// Params 1, eflags: 0x0
// Checksum 0xaee71f9b, Offset: 0x5e78
// Size: 0x268
function function_e3a10376(winning_teams) {
    if (winning_teams.size == 0) {
        return;
    }
    if (gettime() - level.laststatustime < 5000) {
        return;
    }
    if (areteamarraysequal(winning_teams, level.waswinning)) {
        return;
    }
    if (winning_teams.size == 1) {
        level.laststatustime = gettime();
        foreach (team in winning_teams) {
            if (isdefined(level.waswinning[team])) {
                if (level.waswinning.size == 1) {
                    continue;
                }
            }
            if (isdefined(level.var_e7b05b51) ? level.var_e7b05b51 : 1) {
                globallogic_audio::leader_dialog("gameLeadTaken", team, "status");
            }
        }
    } else {
        return;
    }
    if (level.waswinning.size == 1) {
        foreach (team in level.waswinning) {
            if (isdefined(winning_teams[team])) {
                if (winning_teams.size == 1) {
                    continue;
                }
                if (level.waswinning.size > 1) {
                    continue;
                }
            }
            if (isdefined(level.var_e7b05b51) ? level.var_e7b05b51 : 1) {
                globallogic_audio::leader_dialog("gameLeadLost", team, "status");
            }
        }
    }
    level.waswinning = winning_teams;
}

// Namespace globallogic_score/globallogic_score
// Params 0, eflags: 0x0
// Checksum 0x412d6e94, Offset: 0x60e8
// Size: 0x5c
function onteamscore_postprocess() {
    if (level.splitscreen) {
        return;
    }
    if (level.scorelimit == 1) {
        return;
    }
    iswinning = gethighestteamscoreteam();
    function_e3a10376(iswinning);
}

// Namespace globallogic_score/globallogic_score
// Params 2, eflags: 0x0
// Checksum 0xb31817e1, Offset: 0x6150
// Size: 0x6c
function default_onteamscore(event, team) {
    score = rank::getscoreinfovalue(event);
    assert(isdefined(score));
    onteamscore(score, team);
}

// Namespace globallogic_score/globallogic_score
// Params 2, eflags: 0x0
// Checksum 0x9f7514bb, Offset: 0x61c8
// Size: 0x8c
function initpersstat(dataname, record_stats) {
    if (!isdefined(self.pers[dataname])) {
        self.pers[dataname] = 0;
    }
    if (!isdefined(record_stats) || record_stats == 1) {
        recordplayerstats(self, dataname, int(self.pers[dataname]));
    }
}

// Namespace globallogic_score/globallogic_score
// Params 1, eflags: 0x0
// Checksum 0x45108ec, Offset: 0x6260
// Size: 0x18
function getpersstat(dataname) {
    return self.pers[dataname];
}

// Namespace globallogic_score/globallogic_score
// Params 4, eflags: 0x0
// Checksum 0x12dc3418, Offset: 0x6280
// Size: 0xee
function incpersstat(dataname, increment, record_stats, includegametype) {
    pixbeginevent(#"");
    if (isdefined(self.pers[dataname])) {
        self.pers[dataname] = self.pers[dataname] + increment;
    }
    if (is_true(includegametype)) {
        self stats::function_bb7eedf0(dataname, increment);
    } else {
        self stats::function_dad108fa(dataname, increment);
    }
    if (!isdefined(record_stats) || record_stats == 1) {
        self thread threadedrecordplayerstats(dataname);
    }
    profilestop();
}

// Namespace globallogic_score/globallogic_score
// Params 1, eflags: 0x0
// Checksum 0xccd0b000, Offset: 0x6378
// Size: 0x74
function threadedrecordplayerstats(dataname) {
    self endon(#"disconnect");
    waittillframeend();
    if (isdefined(self) && isdefined(self.pers) && isdefined(self.pers[dataname])) {
        recordplayerstats(self, dataname, self.pers[dataname]);
    }
}

// Namespace globallogic_score/globallogic_score
// Params 1, eflags: 0x0
// Checksum 0xc65bcbd7, Offset: 0x63f8
// Size: 0x3dc
function updatewinstats(winner) {
    winner stats::function_bb7eedf0(#"losses", -1);
    winner.pers[#"outcome"] = #"win";
    winner stats::function_bb7eedf0(#"wins", 1);
    if (level.rankedmatch && !level.disablestattracking && sessionmodeismultiplayergame()) {
        if (winner stats::get_stat_global(#"wins") >= 50) {
            winner giveachievement(#"mp_achievement_match_wins");
        }
    }
    if (level.hardcoremode) {
        winner stats::function_dad108fa(#"wins_hc", 1);
    } else if (!level.arenamatch) {
        winner stats::function_dad108fa(#"wins_core", 1);
    }
    if (level.arenamatch) {
        winner stats::function_dad108fa(#"wins_arena", 1);
    }
    if (level.multiteam) {
        winner stats::function_dad108fa(#"wins_multiteam", 1);
    }
    winner updatestatratio("wlratio", "wins", "losses");
    restorewinstreaks(winner);
    winner stats::function_bb7eedf0(#"cur_win_streak", 1);
    winner notify(#"win");
    winner.lootxpmultiplier = 1;
    cur_gamemode_win_streak = winner stats::function_ed81f25e(#"cur_win_streak");
    gamemode_win_streak = winner stats::function_ed81f25e(#"win_streak");
    cur_win_streak = winner stats::get_stat_global(#"cur_win_streak");
    if (isdefined(cur_gamemode_win_streak) && isdefined(gamemode_win_streak) && cur_gamemode_win_streak > gamemode_win_streak) {
        winner stats::function_baa25a23(#"win_streak", cur_gamemode_win_streak);
    }
    if (bot::is_bot_ranked_match()) {
        combattrainingwins = winner stats::get_stat(#"combattrainingwins");
        winner stats::set_stat(#"combattrainingwins", combattrainingwins + 1);
    }
    if (level.var_73e51905 === 1) {
        winner stats::function_dad108fa(#"hash_56a0e77eea02664d", 1);
    }
    updateweaponcontractwin(winner);
    updatecontractwin(winner);
}

// Namespace globallogic_score/globallogic_score
// Params 0, eflags: 0x0
// Checksum 0x12dd380f, Offset: 0x67e0
// Size: 0x56
function canupdateweaponcontractstats() {
    if (getdvarint(#"enable_weapon_contract", 0) == 0) {
        return false;
    }
    if (!level.rankedmatch && !level.arenamatch) {
        return false;
    }
    return true;
}

// Namespace globallogic_score/globallogic_score
// Params 1, eflags: 0x0
// Checksum 0xcc4a8e5, Offset: 0x6840
// Size: 0x9c
function updateweaponcontractstart(player) {
    if (!canupdateweaponcontractstats()) {
        return;
    }
    if (player stats::get_stat(#"weaponcontractdata", #"starttimestamp") == 0) {
        player stats::set_stat(#"weaponcontractdata", #"starttimestamp", getutc());
    }
}

// Namespace globallogic_score/globallogic_score
// Params 1, eflags: 0x0
// Checksum 0x5b762bf6, Offset: 0x68e8
// Size: 0x184
function updateweaponcontractwin(winner) {
    if (!canupdateweaponcontractstats()) {
        return;
    }
    matcheswon = winner stats::get_stat(#"weaponcontractdata", #"currentvalue") + 1;
    winner stats::set_stat(#"weaponcontractdata", #"currentvalue", matcheswon);
    if ((isdefined(winner stats::get_stat(#"weaponcontractdata", #"completetimestamp")) ? winner stats::get_stat(#"weaponcontractdata", #"completetimestamp") : 0) == 0) {
        targetvalue = getdvarint(#"weapon_contract_target_value", 100);
        if (matcheswon >= targetvalue) {
            winner stats::set_stat(#"weaponcontractdata", #"completetimestamp", getutc());
        }
    }
}

// Namespace globallogic_score/globallogic_score
// Params 0, eflags: 0x0
// Checksum 0xe4edb025, Offset: 0x6a78
// Size: 0x128
function updateweaponcontractplayed() {
    if (!canupdateweaponcontractstats()) {
        return;
    }
    foreach (player in level.players) {
        if (!isdefined(player)) {
            continue;
        }
        if (!isdefined(player.pers[#"team"])) {
            continue;
        }
        matchesplayed = player stats::get_stat(#"weaponcontractdata", #"matchesplayed") + 1;
        player stats::set_stat(#"weaponcontractdata", #"matchesplayed", matchesplayed);
    }
}

// Namespace globallogic_score/globallogic_score
// Params 1, eflags: 0x0
// Checksum 0x8288d274, Offset: 0x6ba8
// Size: 0xa8
function updatecontractwin(winner) {
    if (!isdefined(level.updatecontractwinevents)) {
        return;
    }
    foreach (contractwinevent in level.updatecontractwinevents) {
        if (!isdefined(contractwinevent)) {
            continue;
        }
        [[ contractwinevent ]](winner);
    }
}

// Namespace globallogic_score/globallogic_score
// Params 1, eflags: 0x0
// Checksum 0x20bf3c01, Offset: 0x6c58
// Size: 0xa8
function registercontractwinevent(event) {
    if (!isdefined(level.updatecontractwinevents)) {
        level.updatecontractwinevents = [];
    }
    if (!isdefined(level.updatecontractwinevents)) {
        level.updatecontractwinevents = [];
    } else if (!isarray(level.updatecontractwinevents)) {
        level.updatecontractwinevents = array(level.updatecontractwinevents);
    }
    level.updatecontractwinevents[level.updatecontractwinevents.size] = event;
}

// Namespace globallogic_score/globallogic_score
// Params 1, eflags: 0x0
// Checksum 0x64a2e274, Offset: 0x6d08
// Size: 0xa0
function updatelossstats(loser) {
    loser.pers[#"outcome"] = #"loss";
    loser stats::function_bb7eedf0(#"losses", 1);
    loser updatestatratio("wlratio", "wins", "losses");
    loser notify(#"loss");
}

// Namespace globallogic_score/globallogic_score
// Params 1, eflags: 0x0
// Checksum 0x1a1c1666, Offset: 0x6db0
// Size: 0x8c
function updatelosslatejoinstats(loser) {
    loser stats::function_bb7eedf0(#"losses", -1);
    loser stats::function_bb7eedf0(#"losses_late_join", 1);
    loser updatestatratio("wlratio", "wins", "losses");
}

// Namespace globallogic_score/globallogic_score
// Params 1, eflags: 0x0
// Checksum 0x43c491c8, Offset: 0x6e48
// Size: 0x130
function updatetiestats(loser) {
    loser stats::function_bb7eedf0(#"losses", -1);
    loser.pers[#"outcome"] = #"draw";
    loser stats::function_bb7eedf0(#"ties", 1);
    loser updatestatratio("wlratio", "wins", "losses");
    if (!level.disablestattracking) {
        loser stats::set_stat_global(#"cur_win_streak", 0);
        if (level.var_73e51905 === 1) {
            loser stats::set_stat_global(#"hash_56a0e77eea02664d", 0);
        }
    }
    loser notify(#"tie");
}

// Namespace globallogic_score/globallogic_score
// Params 0, eflags: 0x0
// Checksum 0xbe9a2fdf, Offset: 0x6f80
// Size: 0x790
function updatewinlossstats() {
    if (!util::waslastround() && !level.hostforcedend) {
        return;
    }
    players = level.players;
    updateweaponcontractplayed();
    if (match::function_75f97ac7()) {
        if (level.hostforcedend && match::function_517c0ce0()) {
            return;
        }
        winner = match::get_winner();
        updatewinstats(winner);
        if (!level.teambased) {
            placement = level.placement[#"all"];
            var_ced71946 = min(function_d68cdc5d(), placement.size);
            for (index = 1; index < var_ced71946; index++) {
                nexttopplayer = placement[index];
                updatewinstats(nexttopplayer);
            }
            foreach (player in players) {
                if (winner == player) {
                    continue;
                }
                for (index = 1; index < var_ced71946; index++) {
                    if (player == placement[index]) {
                        break;
                    }
                }
                if (index < var_ced71946) {
                    continue;
                }
                if (level.rankedmatch && !level.leaguematch && player.pers[#"latejoin"] === 1) {
                    updatelosslatejoinstats(player);
                }
            }
        }
        return;
    }
    if (function_d68cdc5d() > 1) {
        var_6fc391d0 = [];
        foreach (team in level.teams) {
            var_6fc391d0[var_6fc391d0.size] = team;
        }
        var_eed7c027 = level.var_eed7c027;
        for (i = 0; i < var_6fc391d0.size; i++) {
            var_4c3d7c97 = var_6fc391d0[i];
            if (!isdefined(var_eed7c027[var_4c3d7c97])) {
                continue;
            }
            for (j = i; j < var_6fc391d0.size; j++) {
                var_de0a6674 = var_6fc391d0[j];
                if (!isdefined(var_eed7c027[var_de0a6674])) {
                    continue;
                }
                if (var_eed7c027[var_de0a6674] > var_eed7c027[var_4c3d7c97]) {
                    temp = var_6fc391d0[j];
                    var_6fc391d0[j] = var_6fc391d0[i];
                    var_6fc391d0[i] = temp;
                }
            }
        }
        var_96974d12 = min(function_d68cdc5d(), level.var_eed7c027.size);
        for (index = 0; index < var_96974d12; index++) {
            winners = getplayers(level.var_eed7c027[index]);
            foreach (winner in winners) {
                updatewinstats(winner);
            }
        }
        return;
    }
    if (match::get_flag("tie")) {
        foreach (player in players) {
            if (!isdefined(player.pers[#"team"])) {
                continue;
            }
            if (level.hostforcedend && player ishost()) {
                continue;
            }
            updatetiestats(player);
        }
        return;
    }
    foreach (player in players) {
        if (!isdefined(player.pers[#"team"])) {
            continue;
        }
        if (level.hostforcedend && player ishost()) {
            continue;
        }
        if (match::get_flag("tie")) {
            updatetiestats(player);
            continue;
        }
        if (match::function_a2b53e17(player)) {
            updatewinstats(player);
            continue;
        }
        if (level.rankedmatch && !level.leaguematch && player.pers[#"latejoin"] === 1) {
            updatelosslatejoinstats(player);
        }
        if (!level.disablestattracking) {
            player stats::set_stat_global(#"cur_win_streak", 0);
            if (level.var_73e51905 === 1) {
                player stats::set_stat_global(#"hash_56a0e77eea02664d", 0);
            }
        }
    }
}

// Namespace globallogic_score/globallogic_score
// Params 0, eflags: 0x0
// Checksum 0x1172f230, Offset: 0x7718
// Size: 0x154
function backupandclearwinstreaks() {
    if (is_true(level.freerun)) {
        return;
    }
    self.pers[#"winstreak"] = self stats::get_stat_global(#"cur_win_streak");
    if (!level.disablestattracking) {
        self stats::set_stat_global(#"cur_win_streak", 0);
        if (level.var_73e51905 === 1) {
            self.pers[#"hash_130610255352357c"] = self stats::get_stat_global(#"hash_56a0e77eea02664d");
            self stats::set_stat_global(#"hash_56a0e77eea02664d", 0);
        }
    }
    self.pers[#"winstreakforgametype"] = self stats::function_ed81f25e(#"cur_win_streak");
    self stats::function_baa25a23(#"cur_win_streak", 0);
}

// Namespace globallogic_score/globallogic_score
// Params 1, eflags: 0x0
// Checksum 0x390c689c, Offset: 0x7878
// Size: 0x104
function restorewinstreaks(winner) {
    if (!level.disablestattracking) {
        winner stats::set_stat_global(#"cur_win_streak", winner.pers[#"winstreak"]);
        if (level.var_73e51905 === 1) {
            winner stats::set_stat_global(#"hash_56a0e77eea02664d", winner.pers[#"hash_130610255352357c"]);
        }
    }
    winner stats::function_baa25a23(#"cur_win_streak", isdefined(winner.pers[#"winstreakforgametype"]) ? winner.pers[#"winstreakforgametype"] : 0);
}

// Namespace globallogic_score/globallogic_score
// Params 1, eflags: 0x0
// Checksum 0x7dfee791, Offset: 0x7988
// Size: 0x86
function inckillstreaktracker(weapon) {
    self endon(#"disconnect");
    waittillframeend();
    if (weapon.name == #"artillery") {
        self.pers[#"artillery_kills"]++;
    }
    if (weapon.name == #"dog_bite") {
        self.pers[#"dog_kills"]++;
    }
}

// Namespace globallogic_score/globallogic_score
// Params 6, eflags: 0x0
// Checksum 0x30f36334, Offset: 0x7a18
// Size: 0x28c
function trackattackerkill(name, rank, xp, prestige, xuid, weapon) {
    self endon(#"disconnect");
    attacker = self;
    waittillframeend();
    pixbeginevent(#"");
    if (!isdefined(attacker.pers[#"killed_players"][name])) {
        attacker.pers[#"killed_players"][name] = 0;
    }
    if (!isdefined(attacker.pers[#"killed_players_with_specialist"][name])) {
        attacker.pers[#"killed_players_with_specialist"][name] = 0;
    }
    if (!isdefined(attacker.killedplayerscurrent[name])) {
        attacker.killedplayerscurrent[name] = 0;
    }
    attacker.pers[#"killed_players"][name]++;
    attacker.killedplayerscurrent[name]++;
    if (weapon.isheavyweapon) {
        attacker.pers[#"killed_players_with_specialist"][name]++;
    }
    if (attacker.pers[#"nemesis_name"] == name) {
        attacker challenges::killednemesis();
    }
    attacker function_e7b4c25c(name, 1.5, rank, prestige, xp, xuid);
    if (!isdefined(attacker.lastkilledvictim) || !isdefined(attacker.lastkilledvictimcount)) {
        attacker.lastkilledvictim = name;
        attacker.lastkilledvictimcount = 0;
    }
    if (attacker.lastkilledvictim == name) {
        attacker.lastkilledvictimcount++;
        if (attacker.lastkilledvictimcount >= 5) {
            attacker.lastkilledvictimcount = 0;
            attacker stats::function_dad108fa(#"streaker", 1);
        }
    } else {
        attacker.lastkilledvictim = name;
        attacker.lastkilledvictimcount = 1;
    }
    profilestop();
}

// Namespace globallogic_score/globallogic_score
// Params 5, eflags: 0x0
// Checksum 0x27f37ad1, Offset: 0x7cb0
// Size: 0x216
function trackattackeedeath(attackername, rank, xp, prestige, xuid) {
    self endon(#"disconnect");
    waittillframeend();
    pixbeginevent(#"");
    if (!isdefined(self.pers[#"killed_by"][attackername])) {
        self.pers[#"killed_by"][attackername] = 0;
    }
    self.pers[#"killed_by"][attackername]++;
    self function_e7b4c25c(attackername, 1.5, rank, prestige, xp, xuid);
    if (self.pers[#"nemesis_name"] == attackername && self.pers[#"nemesis_tracking"][attackername].value >= 2) {
        self setclientuivisibilityflag("killcam_nemesis", 1);
    } else {
        self setclientuivisibilityflag("killcam_nemesis", 0);
    }
    selfkillstowardsattacker = 0;
    if (isdefined(self.pers[#"killed_players"][attackername])) {
        selfkillstowardsattacker = self.pers[#"killed_players"][attackername];
    }
    self luinotifyevent(#"track_victim_death", 2, self.pers[#"killed_by"][attackername], selfkillstowardsattacker);
    profilestop();
}

// Namespace globallogic_score/globallogic_score
// Params 0, eflags: 0x0
// Checksum 0xbe8b522d, Offset: 0x7ed0
// Size: 0x6
function default_iskillboosting() {
    return false;
}

// Namespace globallogic_score/globallogic_score
// Params 4, eflags: 0x0
// Checksum 0xa136352a, Offset: 0x7ee0
// Size: 0x60e
function givekillstats(smeansofdeath, weapon, evictim, var_e7a369ea) {
    self endon(#"disconnect");
    if (self === var_e7a369ea) {
        self.kills += 1;
    }
    laststandparams = undefined;
    if (isdefined(evictim)) {
        laststandparams = evictim.laststandparams;
    }
    waittillframeend();
    if (level.rankedmatch && self [[ level.iskillboosting ]]()) {
        /#
            self iprintlnbold("<dev string:x58>");
        #/
        return;
    }
    pixbeginevent(#"");
    if (self === var_e7a369ea) {
        self activecamo::function_896ac347(weapon, #"kills", 1);
        self incpersstat(#"kills", 1, 1, 1);
        self.kills = self getpersstat(#"kills");
        self updatestatratio("kdratio", "kills", "deaths");
        if (isdefined(evictim) && isplayer(evictim) && isdefined(evictim.attackerdamage)) {
            if (isarray(evictim.attackerdamage) && isdefined(self.clientid) && isdefined(evictim.attackerdamage[self.clientid]) && evictim.attackerdamage.size == 1) {
                stats::function_dad108fa(#"direct_action_kills", 1);
            }
        }
        if (isdefined(level.var_c8453874)) {
            [[ level.var_c8453874 ]](self, evictim, laststandparams);
        }
        vehicle = self getvehicleoccupied();
        if (isvehicle(vehicle) && vehicle.isphysicsvehicle) {
            seat = vehicle getoccupantseat(self);
            if (isdefined(seat)) {
                if (seat === 0 || seat === vehicle.var_260e3593) {
                    self stats::function_dad108fa(#"kills_vehicle_driver", 1);
                }
                if (seat > 0) {
                    self stats::function_dad108fa(#"kills_vehicle_passenger", 1);
                }
                if (self.var_9ff5ff83 !== 1) {
                    driverkills = self stats::get_stat_global(#"kills_vehicle_driver");
                    passengerkills = self stats::get_stat_global(#"kills_vehicle_passenger");
                    if (driverkills + passengerkills >= 100) {
                        self giveachievement(#"mp_achievement_vehicle_kills");
                        self.var_9ff5ff83 = 1;
                    }
                }
            }
        }
    }
    if (isdefined(evictim) && isplayer(evictim)) {
        self incpersstat(#"ekia", 1, 1, 1);
        self stats::function_e24eec31(weapon, #"ekia", 1);
        self contracts::player_contract_event(#"ekia", weapon);
        self.ekia = self getpersstat(#"ekia");
        if (self.var_ba29f4f6 !== 1 && self.ekia >= 200) {
            self giveachievement(#"mp_achievement_eliminations");
            self.var_ba29f4f6 = 1;
        }
    }
    attacker = self;
    if (smeansofdeath === "MOD_HEAD_SHOT" && !killstreaks::is_killstreak_weapon(weapon)) {
        self activecamo::function_896ac347(weapon, #"headshots", 1);
        attacker thread incpersstat(#"headshots", 1, 1, 0);
        attacker.headshots = attacker.pers[#"headshots"];
        if (isdefined(evictim)) {
            evictim recordkillmodifier("headshot");
        }
        if (attacker.headshots % 5 == 0) {
            self contracts::increment_contract(#"hash_ca75e54eb5e5ef8");
        }
    }
    profilestop();
}

// Namespace globallogic_score/globallogic_score
// Params 3, eflags: 0x0
// Checksum 0x3e2a1f27, Offset: 0x84f8
// Size: 0x1a4
function setinflictorstat(einflictor, eattacker, weapon) {
    if (!isdefined(eattacker)) {
        return;
    }
    weaponpickedup = 0;
    if (isdefined(eattacker.pickedupweapons) && isdefined(eattacker.pickedupweapons[weapon])) {
        weaponpickedup = 1;
    }
    if (!isdefined(einflictor)) {
        eattacker stats::function_eec52333(weapon, #"hits", 1, eattacker.class_num, weaponpickedup);
        return;
    }
    if (!isdefined(einflictor.playeraffectedarray)) {
        einflictor.playeraffectedarray = [];
    }
    foundnewplayer = 1;
    for (i = 0; i < einflictor.playeraffectedarray.size; i++) {
        if (einflictor.playeraffectedarray[i] == self) {
            foundnewplayer = 0;
            break;
        }
    }
    if (foundnewplayer) {
        einflictor.playeraffectedarray[einflictor.playeraffectedarray.size] = self;
        if (weapon.rootweapon.name == "tabun_gas") {
            eattacker stats::function_e24eec31(weapon, #"used", 1);
        }
        eattacker stats::function_eec52333(weapon, #"hits", 1, eattacker.class_num, weaponpickedup);
    }
}

// Namespace globallogic_score/globallogic_score
// Params 1, eflags: 0x0
// Checksum 0x2e041a72, Offset: 0x86a8
// Size: 0x154
function processshieldassist(killedplayer) {
    self endon(#"disconnect");
    killedplayer endon(#"disconnect");
    waitframe(1);
    util::waittillslowprocessallowed();
    if (!isdefined(level.teams[self.pers[#"team"]])) {
        return;
    }
    if (self.pers[#"team"] == killedplayer.pers[#"team"]) {
        return;
    }
    if (!level.teambased) {
        return;
    }
    self incpersstat(#"assists", 1, 1, 1);
    self.assists = self getpersstat(#"assists");
    currentweapon = self getcurrentweapon();
    scoreevents::processscoreevent(#"shield_assist", self, killedplayer, currentweapon);
}

// Namespace globallogic_score/globallogic_score
// Params 4, eflags: 0x0
// Checksum 0x9f112230, Offset: 0x8808
// Size: 0x34c
function function_b1a3b359(killedplayer, damagedone, weapon, assist_level = undefined) {
    self endon(#"disconnect");
    killedplayer endon(#"disconnect");
    if (!isdefined(level.teams[self.pers[#"team"]])) {
        return;
    }
    if (self.pers[#"team"] == killedplayer.pers[#"team"]) {
        return;
    }
    if (!level.teambased) {
        return;
    }
    assist_level = "assist";
    assist_level_value = int(ceil(damagedone / 25));
    if (assist_level_value < 1) {
        assist_level_value = 1;
    } else if (assist_level_value > 3) {
        assist_level_value = 3;
    }
    assist_level = assist_level + "_" + assist_level_value * 25;
    self incpersstat(#"assists", 1, 1, 1);
    self.assists = self getpersstat(#"assists");
    if (isdefined(weapon)) {
        weaponpickedup = 0;
        if (isdefined(self.pickedupweapons) && isdefined(self.pickedupweapons[weapon])) {
            weaponpickedup = 1;
        }
        self stats::function_eec52333(weapon, #"assists", 1, self.class_num, weaponpickedup);
    }
    if (!level.var_724cf71) {
        switch (weapon.name) {
        case #"hash_577b41452577c37f":
        case #"concussion_grenade":
            assist_level = "assist_concussion";
            break;
        case #"hash_af1a40bb1375dab":
        case #"flash_grenade":
            assist_level = "assist_flash";
            break;
        case #"hash_4cd586d22c20b3cf":
        case #"emp_grenade":
            assist_level = "assist_emp";
            break;
        case #"proximity_grenade":
        case #"proximity_grenade_aoe":
            assist_level = "assist_proximity";
            break;
        }
        self challenges::assisted();
        scoreevents::processscoreevent(assist_level, self, killedplayer, weapon);
        return;
    }
    self challenges::function_57ca42c6(weapon);
}

// Namespace globallogic_score/globallogic_score
// Params 3, eflags: 0x0
// Checksum 0x94d84f05, Offset: 0x8b60
// Size: 0xc0
function function_672746e0(attacker, *inflictor, *weapon) {
    if (!isdefined(weapon) || !isdefined(weapon.team) || self util::isenemyplayer(weapon) == 0) {
        return false;
    }
    if (self == weapon || weapon.classname == "trigger_hurt" || weapon.classname == "worldspawn") {
        return false;
    }
    if (weapon.team == #"spectator") {
        return false;
    }
    return true;
}

// Namespace globallogic_score/globallogic_score
// Params 3, eflags: 0x0
// Checksum 0x1e7953b, Offset: 0x8c28
// Size: 0x19c
function function_c2ea00b2(attacker, inflictor, weapon) {
    if (!function_672746e0(attacker, inflictor, weapon)) {
        return;
    }
    params = {#players:[], #attacker:attacker, #inflictor:inflictor, #weapon:weapon};
    foreach (player in getplayers()) {
        if (util::function_fbce7263(player.team, attacker.team)) {
            continue;
        }
        if (player == attacker) {
            continue;
        }
        if (player.sessionstate != "playing") {
            continue;
        }
        params.players[player getentitynumber()] = player;
    }
    callback::callback(#"hash_7c6da2f2c9ef947a", params);
}

// Namespace globallogic_score/globallogic_score
// Params 0, eflags: 0x0
// Checksum 0x9b7991be, Offset: 0x8dd0
// Size: 0xbc
function function_9779ac61() {
    if (level.scoreroundwinbased) {
        if (level.teambased) {
            foreach (team, _ in level.teams) {
                [[ level._setteamscore ]](team, game.stat[#"roundswon"][team]);
            }
        }
    }
}

// Namespace globallogic_score/globallogic_score
// Params 6, eflags: 0x0
// Checksum 0xec25e2a6, Offset: 0x8e98
// Size: 0x2e4
function function_e7b4c25c(nemesis_name, value, nemesis_rank, var_15574043, nemesis_xp, nemesis_xuid) {
    if (!isdefined(self.pers[#"nemesis_tracking"][nemesis_name])) {
        self.pers[#"nemesis_tracking"][nemesis_name] = {#name:nemesis_name, #value:0};
    }
    self.pers[#"nemesis_tracking"][nemesis_name].value = self.pers[#"nemesis_tracking"][nemesis_name].value + value;
    var_b5c193c6 = self.pers[#"nemesis_tracking"][self.pers[#"nemesis_name"]];
    if (self.pers[#"nemesis_name"] == "" || !isdefined(var_b5c193c6) || self.pers[#"nemesis_tracking"][nemesis_name].value > var_b5c193c6.value) {
        assert(isdefined(nemesis_name), "<dev string:xa2>" + self.name);
        assert(isstring(nemesis_name), "<dev string:xc6>" + nemesis_name + "<dev string:xd2>" + self.name);
        self.pers[#"nemesis_name"] = nemesis_name;
        self.pers[#"nemesis_rank"] = nemesis_rank;
        self.pers[#"nemesis_rankicon"] = var_15574043;
        self.pers[#"nemesis_xp"] = nemesis_xp;
        self.pers[#"nemesis_xuid"] = nemesis_xuid;
        return;
    }
    if (isdefined(self.pers[#"nemesis_name"]) && self.pers[#"nemesis_name"] == nemesis_name) {
        self.pers[#"nemesis_rank"] = nemesis_rank;
        self.pers[#"nemesis_xp"] = nemesis_xp;
    }
}

// Namespace globallogic_score/globallogic_score
// Params 1, eflags: 0x0
// Checksum 0x8b96f741, Offset: 0x9188
// Size: 0x54
function function_30ab51a4(*params) {
    if (isdefined(self) && isdefined(self.pers)) {
        self.pers[#"hash_49e7469988944ecf"] = undefined;
        self.pers[#"hash_53919d92ff1d039"] = undefined;
    }
}

// Namespace globallogic_score/globallogic_score
// Params 1, eflags: 0x0
// Checksum 0xb00128ef, Offset: 0x91e8
// Size: 0x34
function set_character_spectate_on_index(params) {
    if (params.var_b66879ad === 0) {
        return;
    }
    function_30ab51a4(params);
}

