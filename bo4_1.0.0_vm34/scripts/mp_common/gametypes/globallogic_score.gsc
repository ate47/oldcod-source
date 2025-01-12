#using scripts\abilities\ability_player;
#using scripts\abilities\ability_util;
#using scripts\core_common\bb_shared;
#using scripts\core_common\bots\bot;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\challenges_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\globallogic\globallogic_score;
#using scripts\core_common\loadout_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\persistence_shared;
#using scripts\core_common\player\player_role;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\rank_shared;
#using scripts\core_common\scoreevents_shared;
#using scripts\core_common\util_shared;
#using scripts\killstreaks\killstreaks_shared;
#using scripts\killstreaks\killstreaks_util;
#using scripts\mp_common\callbacks;
#using scripts\mp_common\gametypes\globallogic;
#using scripts\mp_common\gametypes\globallogic_audio;
#using scripts\mp_common\gametypes\globallogic_score;
#using scripts\mp_common\gametypes\globallogic_utils;
#using scripts\mp_common\gametypes\match;
#using scripts\mp_common\gametypes\outcome;
#using scripts\mp_common\scoreevents;
#using scripts\mp_common\util;

#namespace globallogic_score;

// Namespace globallogic_score/globallogic_score
// Params 0, eflags: 0x2
// Checksum 0x43fcfced, Offset: 0x388
// Size: 0x16c
function autoexec __init__() {
    level.scoreevents_givekillstats = &givekillstats;
    level.scoreevents_processassist = &function_73f2c8b2;
    level.var_a79368c1 = &function_c3504ba5;
    clientfield::register("clientuimodel", "hudItems.scoreProtected", 1, 1, "int");
    clientfield::register("clientuimodel", "hudItems.minorActions.action0", 1, 1, "counter");
    clientfield::register("clientuimodel", "hudItems.minorActions.action1", 1, 1, "counter");
    clientfield::register("clientuimodel", "hudItems.hotStreak.level", 1, 3, "int");
    callback::on_joined_team(&function_8020890f);
    callback::on_joined_spectate(&function_6b623aa1);
    callback::on_changed_specialist(&function_6b623aa1);
}

// Namespace globallogic_score/gametype_init
// Params 1, eflags: 0x40
// Checksum 0x40dbad90, Offset: 0x500
// Size: 0x26
function event_handler[gametype_init] main(eventstruct) {
    profilestart();
    level thread function_3b0bf3a0();
    profilestop();
}

// Namespace globallogic_score/globallogic_score
// Params 0, eflags: 0x0
// Checksum 0xa53bae79, Offset: 0x530
// Size: 0x114
function function_3b0bf3a0() {
    self notify("6f4f1136d1eb61c0");
    self endon("6f4f1136d1eb61c0");
    level endon(#"game_ended");
    while (true) {
        waitresult = level waittill(#"hero_gadget_activated");
        if (isdefined(waitresult.weapon) && isdefined(waitresult.player)) {
            player = waitresult.player;
            if (isdefined(player.pers[#"hash_53919d92ff1d039"])) {
                scoreevents::function_2c6f1417("battle_command_ultimate_command", player.pers[#"hash_53919d92ff1d039"], undefined, undefined);
                player.pers[#"hash_53919d92ff1d039"] = undefined;
            }
        }
    }
}

// Namespace globallogic_score/globallogic_score
// Params 1, eflags: 0x0
// Checksum 0xd045a083, Offset: 0x650
// Size: 0x21e
function function_c3504ba5(hotstreak) {
    level endon(#"game_ended");
    self endon(#"disconnect", #"joined_spectators");
    self notify("159017609bf022bd");
    self endon("159017609bf022bd");
    if (!isdefined(self) || !isplayer(self) || !isdefined(hotstreak) || isbot(self)) {
        return;
    }
    if (!isdefined(self.hotstreak)) {
        self.hotstreak = 0;
    }
    var_eab9bc2c = self.hotstreak + hotstreak;
    if (self.hotstreak < 100) {
        if (var_eab9bc2c >= 100) {
            self clientfield::set_player_uimodel("hudItems.hotStreak.level", 1);
        }
    } else if (self.hotstreak < 200) {
        if (var_eab9bc2c >= 200) {
            self clientfield::set_player_uimodel("hudItems.hotStreak.level", 2);
        }
    } else if (self.hotstreak < 300) {
        if (var_eab9bc2c >= 300) {
            self clientfield::set_player_uimodel("hudItems.hotStreak.level", 3);
        }
    }
    self.hotstreak = var_eab9bc2c;
    waitresult = self waittilltimeout(10, #"death", #"joined_team", #"changed_specialist");
    self clientfield::set_player_uimodel("hudItems.hotStreak.level", 0);
    self.hotstreak = 0;
}

// Namespace globallogic_score/globallogic_score
// Params 0, eflags: 0x0
// Checksum 0xe12e6d93, Offset: 0x878
// Size: 0x98
function function_7fa401e9() {
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
// Checksum 0x7b5cf8d5, Offset: 0x918
// Size: 0x48
function function_36ca238b(game_length) {
    totaltimeplayed = self.timeplayed[#"total"];
    if (totaltimeplayed > game_length) {
        totaltimeplayed = game_length;
    }
    return totaltimeplayed;
}

// Namespace globallogic_score/globallogic_score
// Params 1, eflags: 0x0
// Checksum 0x1c262474, Offset: 0x968
// Size: 0x96
function function_53b1c07d(player) {
    for (pidx = 0; pidx < min(level.placement[#"all"][0].size, 3); pidx++) {
        if (level.placement[#"all"][pidx] != player) {
            continue;
        }
        return true;
    }
    return false;
}

// Namespace globallogic_score/globallogic_score
// Params 3, eflags: 0x0
// Checksum 0xbaa58997, Offset: 0xa08
// Size: 0xca
function function_568fb254(scale, type, game_length) {
    total_time_played = self function_36ca238b(game_length);
    spm = self rank::getspm();
    playerscore = int(scale * game_length / 60 * spm * total_time_played / game_length);
    self thread givematchbonus(type, playerscore);
    self.matchbonus = playerscore;
}

// Namespace globallogic_score/globallogic_score
// Params 1, eflags: 0x0
// Checksum 0x792baef6, Offset: 0xae0
// Size: 0x3e6
function updatematchbonusscores(outcome) {
    if (!game.timepassed) {
        return;
    }
    if (!level.rankedmatch) {
        updatecustomgamewinner(outcome);
        return;
    }
    gamelength = function_7fa401e9();
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
                player function_568fb254(winnerscale, "tie", gamelength);
            } else if (isdefined(player.pers[#"team"]) && player.pers[#"team"] == winning_team) {
                player function_568fb254(winnerscale, "win", gamelength);
            } else {
                player function_568fb254(loserscale, "loss", gamelength);
            }
        } else if (function_53b1c07d(player)) {
            player function_568fb254(winnerscale, "win", gamelength);
        } else {
            player function_568fb254(loserscale, "loss", gamelength);
        }
        player.pers[#"totalmatchbonus"] = player.pers[#"totalmatchbonus"] + player.matchbonus;
    }
}

// Namespace globallogic_score/globallogic_score
// Params 1, eflags: 0x0
// Checksum 0xbda3d5a8, Offset: 0xed0
// Size: 0x26e
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
        } else if (function_53b1c07d(player)) {
            player.pers[#"victory"] = 2;
        } else {
            player.pers[#"victory"] = 0;
        }
        player.victory = player.pers[#"victory"];
        player.pers[#"sbtimeplayed"] = player.timeplayed[#"total"];
        player.sbtimeplayed = player.pers[#"sbtimeplayed"];
    }
}

// Namespace globallogic_score/globallogic_score
// Params 2, eflags: 0x0
// Checksum 0x5d6c46b7, Offset: 0x1148
// Size: 0xf4
function givematchbonus(scoretype, score) {
    self endon(#"disconnect");
    level waittill(#"give_match_bonus");
    if (!isdefined(self)) {
        return;
    }
    if (sessionmodeiswarzonegame()) {
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
// Checksum 0x97319764, Offset: 0x1248
// Size: 0x128
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
// Params 1, eflags: 0x0
// Checksum 0x73bbed77, Offset: 0x1378
// Size: 0x3c
function resetplayerscorechainandmomentum(player) {
    player thread _setplayermomentum(self, 0);
    player thread resetscorechain();
}

// Namespace globallogic_score/globallogic_score
// Params 0, eflags: 0x0
// Checksum 0x46694cbb, Offset: 0x13c0
// Size: 0x2e
function resetscorechain() {
    self notify(#"reset_score_chain");
    self.scorechain = 0;
    self.rankupdatetotal = 0;
}

// Namespace globallogic_score/globallogic_score
// Params 0, eflags: 0x0
// Checksum 0x4000ff8b, Offset: 0x13f8
// Size: 0x74
function scorechaintimer() {
    self notify(#"score_chain_timer");
    self endon(#"reset_score_chain");
    self endon(#"score_chain_timer");
    self endon(#"death");
    self endon(#"disconnect");
    wait 20;
    self thread resetscorechain();
}

// Namespace globallogic_score/globallogic_score
// Params 1, eflags: 0x0
// Checksum 0xd74103e1, Offset: 0x1478
// Size: 0x52
function roundtonearestfive(score) {
    rounding = score % 5;
    if (rounding <= 2) {
        return (score - rounding);
    }
    return score + 5 - rounding;
}

// Namespace globallogic_score/globallogic_score
// Params 9, eflags: 0x0
// Checksum 0x11f42b26, Offset: 0x14d8
// Size: 0x344
function giveplayermomentumnotification(score, label, descvalue, countstowardrampage, weapon, combatefficiencybonus = 0, eventindex, event, var_2547ae45) {
    score += combatefficiencybonus;
    hotstreak = rank::function_cb58556(event);
    if (isdefined(level.var_a62f76a1) && level.var_a62f76a1) {
        score = rank::function_c079071f(event);
        if (!isdefined(score)) {
            score = 0;
        }
    }
    if (score != 0) {
        if (!isdefined(eventindex)) {
            eventindex = 1;
        }
        self luinotifyevent(#"score_event", 4, label, score, combatefficiencybonus, eventindex);
        self luinotifyeventtospectators(#"score_event", 4, label, score, combatefficiencybonus, eventindex);
    }
    if (isdefined(event) && isdefined(level.scoreinfo[event][#"job_type"]) && level.scoreinfo[event][#"job_type"] == "hotstreak") {
        if (!isdefined(var_2547ae45) || var_2547ae45 < 2) {
            self luinotifyevent(#"challenge_coin_received", 1, eventindex);
            self luinotifyeventtospectators(#"challenge_coin_received", 1, eventindex);
        } else {
            self luinotifyevent(#"challenge_coin_received", 2, eventindex, var_2547ae45);
            self luinotifyeventtospectators(#"challenge_coin_received", 2, eventindex, var_2547ae45);
        }
    }
    score = score;
    if (score > 0 && self hasperk(#"specialty_earnmoremomentum")) {
        score = roundtonearestfive(int(score * getdvarfloat(#"perk_killstreakmomentummultiplier", 0) + 0.5));
    }
    if (isalive(self)) {
        _setplayermomentum(self, self.pers[#"momentum"] + score);
    }
}

// Namespace globallogic_score/globallogic_score
// Params 0, eflags: 0x0
// Checksum 0x78b7a21, Offset: 0x1828
// Size: 0x11e
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
// Checksum 0xa8dcab8, Offset: 0x1950
// Size: 0x1cc
function resetplayermomentumonspawn() {
    if (isdefined(level.usingscorestreaks) && level.usingscorestreaks) {
        var_b4647c9b = self.deathtime > 0;
        var_a3a27951 = self function_e4d4959a();
        if (var_b4647c9b && var_a3a27951 > 0) {
            var_e27deb41 = isdefined(self.var_e27deb41) ? self.var_e27deb41 : 0;
            var_7bd4a79e = var_a3a27951 > var_e27deb41;
            if (var_7bd4a79e) {
                self.var_e27deb41 = var_e27deb41 + 1;
                var_b4647c9b = 0;
            } else {
                self.var_e27deb41 = undefined;
            }
        } else {
            self.var_e27deb41 = undefined;
        }
        if (var_b4647c9b) {
            new_momentum = int(self.pers[#"momentum"] * (1 - math::clamp(self function_107de9fd(), 0, 1)));
            _setplayermomentum(self, new_momentum);
            self thread resetscorechain();
        }
        var_5095e1ed = var_a3a27951 > (isdefined(self.var_e27deb41) ? self.var_e27deb41 : 0);
        self clientfield::set_player_uimodel("hudItems.scoreProtected", var_5095e1ed);
    }
}

// Namespace globallogic_score/globallogic_score
// Params 6, eflags: 0x0
// Checksum 0xcaddd0c4, Offset: 0x1b28
// Size: 0x2cc
function giveplayermomentum(event, player, victim, descvalue, weapon, var_2547ae45) {
    if (isdefined(level.disablemomentum) && level.disablemomentum == 1) {
        return;
    }
    score = player rank::getscoreinfovalue(event);
    assert(isdefined(score));
    label = rank::getscoreinfolabel(event);
    eventindex = level.scoreinfo[event][#"row"];
    countstowardrampage = rank::doesscoreinfocounttowardrampage(event);
    combatefficiencyscore = 0;
    if (player ability_util::gadget_combat_efficiency_enabled()) {
        combatefficiencyscore = rank::function_6c082ba6(event);
        if (isdefined(combatefficiencyscore) && combatefficiencyscore > 0) {
            player ability_util::gadget_combat_efficiency_power_drain(combatefficiencyscore);
            slot = -1;
            if (isdefined(weapon)) {
                slot = player gadgetgetslot(weapon);
                hero_slot = player ability_util::gadget_slot_for_type(11);
            }
        }
    }
    if (event == "death") {
        _setplayermomentum(victim, victim.pers[#"momentum"] + score);
    }
    hotstreak = player rank::function_cb58556(event);
    if (level.gameended) {
        return;
    }
    if (!isdefined(label)) {
        player giveplayermomentumnotification(score, #"hash_480234a872bd64ac", descvalue, countstowardrampage, weapon, combatefficiencyscore, eventindex, event, var_2547ae45);
        return;
    }
    player giveplayermomentumnotification(score, label, descvalue, countstowardrampage, weapon, combatefficiencyscore, eventindex, event, var_2547ae45);
}

// Namespace globallogic_score/globallogic_score
// Params 6, eflags: 0x0
// Checksum 0x5226f400, Offset: 0x1e00
// Size: 0x660
function giveplayerscore(event, player, victim, descvalue, weapon, var_2547ae45) {
    scorediff = 0;
    momentum = player.pers[#"momentum"];
    giveplayermomentum(event, player, victim, descvalue, weapon, var_2547ae45);
    newmomentum = player.pers[#"momentum"];
    if (level.overrideplayerscore) {
        return 0;
    }
    pixbeginevent(#"hash_50e89abe6f3fe4f1");
    score = player.pers[#"score"];
    [[ level.onplayerscore ]](event, player, victim);
    newscore = player.pers[#"score"];
    pixendevent();
    isusingheropower = 0;
    if (player ability_player::is_using_any_gadget()) {
        isusingheropower = 1;
    }
    scorediff = newscore - score;
    mpplayerscore = {};
    mpplayerscore.gamemode = level.gametype;
    mpplayerscore.spawnid = getplayerspawnid(player);
    mpplayerscore.playerspecialist = function_b9650e7f(player player_role::get(), currentsessionmode());
    mpplayerscore.gametime = function_25e96038();
    mpplayerscore.type = event;
    mpplayerscore.isscoreevent = scoreevents::isregisteredevent(event);
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
    mpplayerscore.player = player.name;
    mpplayerscore.delta = scorediff;
    mpplayerscore.deltamomentum = newmomentum - momentum;
    mpplayerscore.team = player.team;
    mpplayerscore.isusingheropower = isusingheropower;
    function_b1f6086c(#"hash_120b2cf3162c3bc1", mpplayerscore);
    player bb::add_to_stat("score", newscore - score);
    if (score == newscore) {
        return 0;
    }
    pixbeginevent(#"giveplayerscore");
    recordplayerstats(player, "score", newscore);
    challengesenabled = !level.disablechallenges;
    player stats::function_2dabbec7(#"score", scorediff);
    if (challengesenabled) {
        player stats::function_b48aa4e(#"career_score", scorediff);
    }
    if (level.hardcoremode) {
        player stats::function_b48aa4e(#"score_hc", scorediff);
        if (challengesenabled) {
            player stats::function_b48aa4e(#"career_score_hc", scorediff);
        }
    }
    if (level.multiteam) {
        player stats::function_b48aa4e(#"score_multiteam", scorediff);
        if (challengesenabled) {
            player stats::function_b48aa4e(#"career_score_multiteam", scorediff);
        }
    }
    player util::player_contract_event("score", scorediff);
    if (isdefined(weapon) && killstreaks::is_killstreak_weapon(weapon)) {
        killstreak = killstreaks::get_from_weapon(weapon);
        killstreakpurchased = 0;
        if (isdefined(killstreak) && isdefined(level.killstreaks[killstreak])) {
            killstreakpurchased = player util::is_item_purchased(level.killstreaks[killstreak].menuname);
        }
        player util::player_contract_event("killstreak_score", scorediff, killstreakpurchased);
    }
    pixendevent();
    return scorediff;
}

// Namespace globallogic_score/globallogic_score
// Params 3, eflags: 0x0
// Checksum 0x56f75da0, Offset: 0x2468
// Size: 0xcc
function default_onplayerscore(event, player, victim) {
    score = player rank::getscoreinfovalue(event);
    rolescore = player rank::getscoreinfoposition(event);
    objscore = 0;
    if (player rank::function_9055b472(event)) {
        objscore = score;
    }
    assert(isdefined(score));
    function_80f2bf6e(player, score, objscore, rolescore);
}

// Namespace globallogic_score/globallogic_score
// Params 2, eflags: 0x0
// Checksum 0xa827aeb4, Offset: 0x2540
// Size: 0x7a
function function_b11ed148(player, amount) {
    player.pers[#"objectives"] = player.pers[#"objectives"] + amount;
    player.objectives = player.pers[#"objectives"];
}

// Namespace globallogic_score/globallogic_score
// Params 4, eflags: 0x0
// Checksum 0x5f245652, Offset: 0x25c8
// Size: 0x1ba
function _setplayerscore(player, score, var_e66afbeb, var_16195fc2) {
    if (score != player.pers[#"score"]) {
        player.pers[#"score"] = score;
        player.score = player.pers[#"score"];
        recordplayerstats(player, "score", player.pers[#"score"]);
    }
    if (isdefined(var_16195fc2) && var_16195fc2 != player.pers[#"rolescore"]) {
        player.pers[#"rolescore"] = var_16195fc2;
        player.rolescore = player.pers[#"rolescore"];
    }
    if (isdefined(var_e66afbeb) && var_e66afbeb != player.pers[#"objscore"]) {
        player.pers[#"objscore"] = var_e66afbeb;
        player.objscore = player.pers[#"objscore"];
    }
}

// Namespace globallogic_score/globallogic_score
// Params 1, eflags: 0x0
// Checksum 0x58f934ef, Offset: 0x2790
// Size: 0x28
function _getplayerscore(player) {
    return player.pers[#"score"];
}

// Namespace globallogic_score/globallogic_score
// Params 2, eflags: 0x0
// Checksum 0xc2da1955, Offset: 0x27c0
// Size: 0x6c
function function_3e69aaea(player, scoresub) {
    score = player.pers[#"score"] - scoresub;
    if (score < 0) {
        score = 0;
    }
    _setplayerscore(player, score);
}

// Namespace globallogic_score/globallogic_score
// Params 4, eflags: 0x0
// Checksum 0xab7c9ada, Offset: 0x2838
// Size: 0x18c
function function_80f2bf6e(player, score_add, var_2d3b597b, var_1ae87e3a) {
    /#
        var_c9da03e5 = getdvarfloat(#"hash_eae9a8ee387705d", 1);
        score_add = int(score_add * var_c9da03e5);
        var_2d3b597b = int(var_2d3b597b * var_c9da03e5);
        var_1ae87e3a = int(var_1ae87e3a * var_c9da03e5);
    #/
    score = player.pers[#"score"] + score_add;
    var_e66afbeb = player.pers[#"objscore"];
    if (isdefined(var_2d3b597b)) {
        var_e66afbeb += var_2d3b597b;
    }
    var_16195fc2 = player.pers[#"rolescore"];
    if (isdefined(var_1ae87e3a)) {
        var_16195fc2 += var_1ae87e3a;
    }
    _setplayerscore(player, score, var_e66afbeb, var_16195fc2);
}

// Namespace globallogic_score/globallogic_score
// Params 0, eflags: 0x0
// Checksum 0xadbb0842, Offset: 0x29d0
// Size: 0x180
function playtop3sounds() {
    waitframe(1);
    globallogic::updateplacement();
    for (i = 0; i < level.placement[#"all"].size; i++) {
        prevscoreplace = level.placement[#"all"][i].prevscoreplace;
        if (!isdefined(prevscoreplace)) {
            prevscoreplace = 1;
        }
        currentscoreplace = i + 1;
        for (j = i - 1; j >= 0; j--) {
            if (level.placement[#"all"][i].score == level.placement[#"all"][j].score) {
                currentscoreplace--;
            }
        }
        wasinthemoney = prevscoreplace <= 3;
        isinthemoney = currentscoreplace <= 3;
        level.placement[#"all"][i].prevscoreplace = currentscoreplace;
    }
}

// Namespace globallogic_score/globallogic_score
// Params 1, eflags: 0x0
// Checksum 0xe4af4767, Offset: 0x2b58
// Size: 0xc4
function setpointstowin(points) {
    self.pers[#"pointstowin"] = math::clamp(points, 0, 65000);
    self.pointstowin = self.pers[#"pointstowin"];
    self thread globallogic::checkscorelimit();
    self thread globallogic::checkroundscorelimit();
    self thread globallogic::checkplayerscorelimitsoon();
    level thread playtop3sounds();
}

// Namespace globallogic_score/globallogic_score
// Params 1, eflags: 0x0
// Checksum 0xc7836b07, Offset: 0x2c28
// Size: 0x3c
function givepointstowin(points) {
    self setpointstowin(self.pers[#"pointstowin"] + points);
}

// Namespace globallogic_score/globallogic_score
// Params 3, eflags: 0x0
// Checksum 0x86379607, Offset: 0x2c70
// Size: 0x272
function _setplayermomentum(player, momentum, updatescore = 1) {
    momentum = math::clamp(momentum, 0, 2000);
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
                momentumcost = player function_ec6a435b(level.killstreaks[killstreaktype].itemindex);
                if (momentumcost > highestmomentumcost) {
                    highestmomentumcost = momentumcost;
                }
                killstreaktypearray[killstreaktypearray.size] = killstreaktype;
            }
        }
        _giveplayerkillstreakinternal(player, momentum, oldmomentum, killstreaktypearray);
        while (highestmomentumcost > 0 && momentum >= highestmomentumcost) {
            oldmomentum = 0;
            momentum -= highestmomentumcost;
            _giveplayerkillstreakinternal(player, momentum, oldmomentum, killstreaktypearray);
        }
    }
    player.pers[#"momentum"] = momentum;
    player.momentum = player.pers[#"momentum"];
}

// Namespace globallogic_score/globallogic_score
// Params 4, eflags: 0x0
// Checksum 0x97dfe82c, Offset: 0x2ef0
// Size: 0x580
function _giveplayerkillstreakinternal(player, momentum, oldmomentum, killstreaktypearray) {
    for (killstreaktypeindex = 0; killstreaktypeindex < killstreaktypearray.size; killstreaktypeindex++) {
        killstreaktype = killstreaktypearray[killstreaktypeindex];
        momentumcost = player function_ec6a435b(level.killstreaks[killstreaktype].itemindex);
        if (momentumcost > oldmomentum && momentumcost <= momentum) {
            weapon = killstreaks::get_killstreak_weapon(killstreaktype);
            was_already_at_max_stacking = 0;
            if (isdefined(level.usingscorestreaks) && level.usingscorestreaks) {
                if (isdefined(level.var_d3a74126)) {
                    player [[ level.var_d3a74126 ]](weapon, momentum);
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
                        }
                    } else {
                        player.pers[#"held_killstreak_clip_count"][weapon] = weapon.clipsize;
                        player.pers[#"held_killstreak_ammo_count"][weapon] = weapon.maxammo;
                        player loadout::function_fae397a1(weapon, player.pers[#"held_killstreak_ammo_count"][weapon]);
                    }
                } else {
                    old_killstreak_quantity = player killstreaks::get_killstreak_quantity(weapon);
                    new_killstreak_quantity = player killstreaks::change_killstreak_quantity(weapon, 1);
                    was_already_at_max_stacking = new_killstreak_quantity == old_killstreak_quantity;
                    if (!was_already_at_max_stacking) {
                        player challenges::earnedkillstreak();
                        if (player ability_util::gadget_is_active(12)) {
                            scoreevents::processscoreevent(#"focus_earn_scorestreak", player, undefined, undefined);
                            player scoreevents::specialistmedalachievement();
                            player scoreevents::specialiststatabilityusage(4, 1);
                            if (player.heroability.name == "gadget_combat_efficiency") {
                                player stats::function_4f10b697(player.heroability, #"scorestreaks_earned", 1);
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
                    player killstreaks::add_to_notification_queue(level.killstreaks[killstreaktype].menuname, new_killstreak_quantity, killstreaktype, undefined, 0);
                }
                continue;
            }
            player killstreaks::add_to_notification_queue(level.killstreaks[killstreaktype].menuname, 0, killstreaktype, undefined, 0);
            activeeventname = "reward_active";
            if (isdefined(weapon)) {
                neweventname = weapon.name + "_active";
                if (scoreevents::isregisteredevent(neweventname)) {
                    activeeventname = neweventname;
                }
            }
        }
    }
}

/#

    // Namespace globallogic_score/globallogic_score
    // Params 0, eflags: 0x0
    // Checksum 0xad06397, Offset: 0x3478
    // Size: 0xf8
    function setplayermomentumdebug() {
        setdvar(#"sv_momentumpercent", 0);
        while (true) {
            wait 1;
            momentumpercent = getdvarfloat(#"sv_momentumpercent", 0);
            if (momentumpercent != 0) {
                player = util::gethostplayer();
                if (!isdefined(player)) {
                    return;
                }
                if (isdefined(player.killstreak)) {
                    _setplayermomentum(player, int(2000 * momentumpercent / 100));
                }
            }
        }
    }

#/

// Namespace globallogic_score/globallogic_score
// Params 4, eflags: 0x0
// Checksum 0xc775e9b7, Offset: 0x3578
// Size: 0x1ac
function giveteamscore(event, team, player, victim) {
    if (level.overrideteamscore) {
        return;
    }
    pixbeginevent(#"hash_66d4a941ef078585");
    teamscore = game.stat[#"teamscores"][team];
    [[ level.onteamscore ]](event, team);
    pixendevent();
    newscore = game.stat[#"teamscores"][team];
    mpteamscores = {#gametime:function_25e96038(), #event:event, #team:team, #diff:newscore - teamscore, #score:newscore};
    function_b1f6086c(#"hash_48d5ef92d24477d2", mpteamscores);
    if (teamscore == newscore) {
        return;
    }
    updateteamscores(team);
    thread globallogic::checkscorelimit();
    thread globallogic::checkroundscorelimit();
}

// Namespace globallogic_score/globallogic_score
// Params 2, eflags: 0x0
// Checksum 0xaa742aae, Offset: 0x3730
// Size: 0x12c
function giveteamscoreforobjective_delaypostprocessing(team, score) {
    teamscore = game.stat[#"teamscores"][team];
    onteamscore_incrementscore(score, team);
    newscore = game.stat[#"teamscores"][team];
    mpteamobjscores = {#gametime:function_25e96038(), #team:team, #diff:newscore - teamscore, #score:newscore};
    function_b1f6086c(#"hash_22921c2c027fa389", mpteamobjscores);
    if (teamscore == newscore) {
        return;
    }
    updateteamscores(team);
}

// Namespace globallogic_score/globallogic_score
// Params 1, eflags: 0x0
// Checksum 0x10946015, Offset: 0x3868
// Size: 0xa4
function postprocessteamscores(teams) {
    foreach (team in teams) {
        onteamscore_postprocess(team);
    }
    thread globallogic::checkscorelimit();
    thread globallogic::checkroundscorelimit();
}

// Namespace globallogic_score/globallogic_score
// Params 2, eflags: 0x0
// Checksum 0x5f8c8013, Offset: 0x3918
// Size: 0x17c
function giveteamscoreforobjective(team, score) {
    if (!isdefined(level.teams[team])) {
        return;
    }
    teamscore = game.stat[#"teamscores"][team];
    onteamscore(score, team);
    newscore = game.stat[#"teamscores"][team];
    mpteamobjscores = {#gametime:function_25e96038(), #team:team, #diff:newscore - teamscore, #score:newscore};
    function_b1f6086c(#"hash_22921c2c027fa389", mpteamobjscores);
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
// Checksum 0x11efdb34, Offset: 0x3aa0
// Size: 0xb4
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
// Checksum 0xf20f0a54, Offset: 0x3b60
// Size: 0xc4
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
// Checksum 0xd010f0fe, Offset: 0x3c30
// Size: 0x24
function resetallscores() {
    resetteamscores();
    resetplayerscores();
}

// Namespace globallogic_score/globallogic_score
// Params 0, eflags: 0x0
// Checksum 0x1e3a11c7, Offset: 0x3c60
// Size: 0xa6
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
// Checksum 0x67278239, Offset: 0x3d10
// Size: 0x54
function updateteamscores(team) {
    setteamscore(team, game.stat[#"teamscores"][team]);
    level thread globallogic::checkteamscorelimitsoon(team);
}

// Namespace globallogic_score/globallogic_score
// Params 0, eflags: 0x0
// Checksum 0xf2d46e13, Offset: 0x3d70
// Size: 0x80
function updateallteamscores() {
    foreach (team, _ in level.teams) {
        updateteamscores(team);
    }
}

// Namespace globallogic_score/globallogic_score
// Params 1, eflags: 0x0
// Checksum 0x29dbf2f5, Offset: 0x3df8
// Size: 0x26
function _getteamscore(team) {
    return game.stat[#"teamscores"][team];
}

// Namespace globallogic_score/globallogic_score
// Params 0, eflags: 0x0
// Checksum 0xd83d997a, Offset: 0x3e28
// Size: 0xea
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
// Checksum 0x12a7723, Offset: 0x3f20
// Size: 0xa0
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
// Checksum 0x6e70a26a, Offset: 0x3fc8
// Size: 0x44
function onteamscore(score, team) {
    onteamscore_incrementscore(score, team);
    onteamscore_postprocess(team);
}

// Namespace globallogic_score/globallogic_score
// Params 2, eflags: 0x0
// Checksum 0x34accaf6, Offset: 0x4018
// Size: 0x18c
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
// Checksum 0x2449ae86, Offset: 0x41b0
// Size: 0x286
function onteamscore_postprocess(team) {
    if (level.splitscreen) {
        return;
    }
    if (level.scorelimit == 1) {
        return;
    }
    iswinning = gethighestteamscoreteam();
    if (iswinning.size == 0) {
        return;
    }
    if (gettime() - level.laststatustime < 5000) {
        return;
    }
    if (areteamarraysequal(iswinning, level.waswinning)) {
        return;
    }
    if (iswinning.size == 1) {
        level.laststatustime = gettime();
        foreach (team in iswinning) {
            if (isdefined(level.waswinning[team])) {
                if (level.waswinning.size == 1) {
                    continue;
                }
            }
            if (isdefined(level.var_30cb1d41) ? level.var_30cb1d41 : 1) {
                globallogic_audio::leader_dialog("gameLeadTaken", team, undefined, "status");
            }
        }
    } else {
        return;
    }
    if (level.waswinning.size == 1) {
        foreach (team in level.waswinning) {
            if (isdefined(iswinning[team])) {
                if (iswinning.size == 1) {
                    continue;
                }
                if (level.waswinning.size > 1) {
                    continue;
                }
            }
            if (isdefined(level.var_30cb1d41) ? level.var_30cb1d41 : 1) {
                globallogic_audio::leader_dialog("gameLeadLost", team, undefined, "status");
            }
        }
    }
    level.waswinning = iswinning;
}

// Namespace globallogic_score/globallogic_score
// Params 2, eflags: 0x0
// Checksum 0xc9cdbe82, Offset: 0x4440
// Size: 0x6c
function default_onteamscore(event, team) {
    score = rank::getscoreinfovalue(event);
    assert(isdefined(score));
    onteamscore(score, team);
}

// Namespace globallogic_score/globallogic_score
// Params 2, eflags: 0x0
// Checksum 0x5ec0c810, Offset: 0x44b8
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
// Checksum 0x444c4787, Offset: 0x4550
// Size: 0x18
function getpersstat(dataname) {
    return self.pers[dataname];
}

// Namespace globallogic_score/globallogic_score
// Params 4, eflags: 0x0
// Checksum 0x51784, Offset: 0x4570
// Size: 0xf4
function incpersstat(dataname, increment, record_stats, includegametype) {
    pixbeginevent(#"incpersstat");
    self.pers[dataname] = self.pers[dataname] + increment;
    if (isdefined(includegametype) && includegametype) {
        self stats::function_2dabbec7(dataname, increment);
    } else {
        self stats::function_b48aa4e(dataname, increment);
    }
    if (!isdefined(record_stats) || record_stats == 1) {
        self thread threadedrecordplayerstats(dataname);
    }
    pixendevent();
}

// Namespace globallogic_score/globallogic_score
// Params 1, eflags: 0x0
// Checksum 0xa7d1883d, Offset: 0x4670
// Size: 0x44
function threadedrecordplayerstats(dataname) {
    self endon(#"disconnect");
    waittillframeend();
    recordplayerstats(self, dataname, self.pers[dataname]);
}

// Namespace globallogic_score/globallogic_score
// Params 1, eflags: 0x0
// Checksum 0xe2df442f, Offset: 0x46c0
// Size: 0x324
function updatewinstats(winner) {
    winner stats::function_2dabbec7(#"losses", -1);
    winner.pers[#"outcome"] = #"win";
    winner stats::function_2dabbec7(#"wins", 1);
    if (level.rankedmatch && !level.disablestattracking && sessionmodeismultiplayergame()) {
        if (winner stats::get_stat_global(#"wins") > 49) {
            winner giveachievement("mp_trophy_vanquisher");
        }
    }
    if (level.hardcoremode) {
        winner stats::function_b48aa4e(#"wins_hc", 1);
    }
    if (level.multiteam) {
        winner stats::function_b48aa4e(#"wins_multiteam", 1);
    }
    winner updatestatratio("wlratio", "wins", "losses");
    restorewinstreaks(winner);
    winner stats::function_2dabbec7(#"cur_win_streak", 1);
    winner notify(#"win");
    winner.lootxpmultiplier = 1;
    cur_gamemode_win_streak = winner stats::function_3774f22d(#"cur_win_streak");
    gamemode_win_streak = winner stats::function_3774f22d(#"win_streak");
    cur_win_streak = winner stats::get_stat_global(#"cur_win_streak");
    if (cur_gamemode_win_streak > gamemode_win_streak) {
        winner stats::function_a296ab19(#"win_streak", cur_gamemode_win_streak);
    }
    if (bot::is_bot_ranked_match()) {
        combattrainingwins = winner stats::get_stat(#"combattrainingwins");
        winner stats::set_stat(#"combattrainingwins", combattrainingwins + 1);
    }
    updateweaponcontractwin(winner);
    updatecontractwin(winner);
}

// Namespace globallogic_score/globallogic_score
// Params 0, eflags: 0x0
// Checksum 0x423acb43, Offset: 0x49f0
// Size: 0x6e
function canupdateweaponcontractstats() {
    if (getdvarint(#"enable_weapon_contract", 0) == 0) {
        return false;
    }
    if (!level.rankedmatch && !level.arenamatch) {
        return false;
    }
    if (sessionmodeiswarzonegame()) {
        return false;
    }
    return true;
}

// Namespace globallogic_score/globallogic_score
// Params 1, eflags: 0x0
// Checksum 0xbbc1d4e6, Offset: 0x4a68
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
// Checksum 0xbf9b6a2e, Offset: 0x4b10
// Size: 0x18c
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
// Checksum 0xa2ba1c48, Offset: 0x4ca8
// Size: 0x120
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
// Checksum 0xab428d0c, Offset: 0x4dd0
// Size: 0x9a
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
// Checksum 0xa7301f6c, Offset: 0x4e78
// Size: 0xaa
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
// Checksum 0x2462978a, Offset: 0x4f30
// Size: 0xa0
function updatelossstats(loser) {
    loser.pers[#"outcome"] = #"loss";
    loser stats::function_2dabbec7(#"losses", 1);
    loser updatestatratio("wlratio", "wins", "losses");
    loser notify(#"loss");
}

// Namespace globallogic_score/globallogic_score
// Params 1, eflags: 0x0
// Checksum 0xd9c8816c, Offset: 0x4fd8
// Size: 0x8c
function updatelosslatejoinstats(loser) {
    loser stats::function_2dabbec7(#"losses", -1);
    loser stats::function_2dabbec7(#"losses_late_join", 1);
    loser updatestatratio("wlratio", "wins", "losses");
}

// Namespace globallogic_score/globallogic_score
// Params 1, eflags: 0x0
// Checksum 0xbcb29de5, Offset: 0x5070
// Size: 0xf8
function updatetiestats(loser) {
    loser stats::function_2dabbec7(#"losses", -1);
    loser.pers[#"outcome"] = #"draw";
    loser stats::function_2dabbec7(#"ties", 1);
    loser updatestatratio("wlratio", "wins", "losses");
    if (!level.disablestattracking) {
        loser stats::set_stat_global(#"cur_win_streak", 0);
    }
    loser notify(#"tie");
}

// Namespace globallogic_score/globallogic_score
// Params 0, eflags: 0x0
// Checksum 0x9c6fc768, Offset: 0x5170
// Size: 0x4e8
function updatewinlossstats() {
    if (!util::waslastround() && !level.hostforcedend) {
        return;
    }
    players = level.players;
    updateweaponcontractplayed();
    if (match::function_ea1a6273()) {
        if (level.hostforcedend && match::function_c925deac()) {
            return;
        }
        winner = match::get_winner();
        updatewinstats(winner);
        if (!level.teambased) {
            placement = level.placement[#"all"];
            topthreeplayers = min(3, placement.size);
            for (index = 1; index < topthreeplayers; index++) {
                nexttopplayer = placement[index];
                updatewinstats(nexttopplayer);
            }
            foreach (player in players) {
                if (winner == player) {
                    continue;
                }
                for (index = 1; index < topthreeplayers; index++) {
                    if (player == placement[index]) {
                        break;
                    }
                }
                if (index < topthreeplayers) {
                    continue;
                }
                if (level.rankedmatch && !level.leaguematch && player.pers[#"latejoin"] === 1) {
                    updatelosslatejoinstats(player);
                }
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
        if (match::function_356f8b9b(player)) {
            updatewinstats(player);
            continue;
        }
        if (level.rankedmatch && !level.leaguematch && player.pers[#"latejoin"] === 1) {
            updatelosslatejoinstats(player);
        }
        if (!level.disablestattracking) {
            player stats::set_stat_global(#"cur_win_streak", 0);
        }
    }
}

// Namespace globallogic_score/globallogic_score
// Params 0, eflags: 0x0
// Checksum 0x74983ab4, Offset: 0x5660
// Size: 0xec
function backupandclearwinstreaks() {
    if (isdefined(level.freerun) && level.freerun) {
        return;
    }
    self.pers[#"winstreak"] = self stats::get_stat_global(#"cur_win_streak");
    if (!level.disablestattracking) {
        self stats::set_stat_global(#"cur_win_streak", 0);
    }
    self.pers[#"winstreakforgametype"] = self stats::function_3774f22d(#"cur_win_streak");
    self stats::function_a296ab19(#"cur_win_streak", 0);
}

// Namespace globallogic_score/globallogic_score
// Params 1, eflags: 0x0
// Checksum 0xc0be69b4, Offset: 0x5758
// Size: 0x8c
function restorewinstreaks(winner) {
    if (!level.disablestattracking) {
        winner stats::set_stat_global(#"cur_win_streak", winner.pers[#"winstreak"]);
    }
    winner stats::function_a296ab19(#"cur_win_streak", winner.pers[#"winstreakforgametype"]);
}

// Namespace globallogic_score/globallogic_score
// Params 1, eflags: 0x0
// Checksum 0x778bb43f, Offset: 0x57f0
// Size: 0x8e
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
// Checksum 0x50deb3b2, Offset: 0x5888
// Size: 0x2ec
function trackattackerkill(name, rank, xp, prestige, xuid, weapon) {
    self endon(#"disconnect");
    attacker = self;
    waittillframeend();
    pixbeginevent(#"trackattackerkill");
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
    attacker function_ec4dec3f(name, 1.5, rank, prestige, xp, xuid);
    if (!isdefined(attacker.lastkilledvictim) || !isdefined(attacker.lastkilledvictimcount)) {
        attacker.lastkilledvictim = name;
        attacker.lastkilledvictimcount = 0;
    }
    if (attacker.lastkilledvictim == name) {
        attacker.lastkilledvictimcount++;
        if (attacker.lastkilledvictimcount >= 5) {
            attacker.lastkilledvictimcount = 0;
            attacker stats::function_b48aa4e(#"streaker", 1);
        }
    } else {
        attacker.lastkilledvictim = name;
        attacker.lastkilledvictimcount = 1;
    }
    pixendevent();
}

// Namespace globallogic_score/globallogic_score
// Params 5, eflags: 0x0
// Checksum 0xcf7f3271, Offset: 0x5b80
// Size: 0x234
function trackattackeedeath(attackername, rank, xp, prestige, xuid) {
    self endon(#"disconnect");
    waittillframeend();
    pixbeginevent(#"trackattackeedeath");
    if (!isdefined(self.pers[#"killed_by"][attackername])) {
        self.pers[#"killed_by"][attackername] = 0;
    }
    self.pers[#"killed_by"][attackername]++;
    self function_ec4dec3f(attackername, 1.5, rank, prestige, xp, xuid);
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
    pixendevent();
}

// Namespace globallogic_score/globallogic_score
// Params 0, eflags: 0x0
// Checksum 0xdde6c25, Offset: 0x5dc0
// Size: 0x6
function default_iskillboosting() {
    return false;
}

// Namespace globallogic_score/globallogic_score
// Params 4, eflags: 0x0
// Checksum 0xe67f244, Offset: 0x5dd0
// Size: 0x26c
function givekillstats(smeansofdeath, weapon, evictim, var_4c02f3b4) {
    self endon(#"disconnect");
    self.kills += 1;
    waittillframeend();
    if (level.rankedmatch && self [[ level.iskillboosting ]]()) {
        /#
            self iprintlnbold("<dev string:x30>");
        #/
        return;
    }
    pixbeginevent(#"givekillstats");
    if (self === var_4c02f3b4) {
        self incpersstat("kills", 1, 1, 1);
        self.kills = self getpersstat("kills");
        self updatestatratio("kdratio", "kills", "deaths");
    }
    if (isdefined(evictim) && isplayer(evictim)) {
        self incpersstat("EKIA", 1, 1, 1);
        self.ekia = self getpersstat("EKIA");
    }
    attacker = self;
    if (smeansofdeath == "MOD_HEAD_SHOT" && !killstreaks::is_killstreak_weapon(weapon)) {
        attacker thread incpersstat("headshots", 1, 1, 0);
        attacker.headshots = attacker.pers[#"headshots"];
        if (isdefined(evictim)) {
            evictim recordkillmodifier("headshot");
        }
    }
    pixendevent();
}

// Namespace globallogic_score/globallogic_score
// Params 3, eflags: 0x0
// Checksum 0x869f2a91, Offset: 0x6048
// Size: 0x1d4
function setinflictorstat(einflictor, eattacker, weapon) {
    if (!isdefined(eattacker)) {
        return;
    }
    weaponpickedup = 0;
    if (isdefined(eattacker.pickedupweapons) && isdefined(eattacker.pickedupweapons[weapon])) {
        weaponpickedup = 1;
    }
    if (!isdefined(einflictor)) {
        eattacker stats::function_c8a05f4f(weapon, #"hits", 1, eattacker.class_num, weaponpickedup);
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
            eattacker stats::function_4f10b697(weapon, #"used", 1);
        }
        eattacker stats::function_c8a05f4f(weapon, #"hits", 1, eattacker.class_num, weaponpickedup);
    }
}

// Namespace globallogic_score/globallogic_score
// Params 1, eflags: 0x0
// Checksum 0x47bfb81f, Offset: 0x6228
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
    self incpersstat("assists", 1, 1, 1);
    self.assists = self getpersstat("assists");
    currentweapon = self getcurrentweapon();
    scoreevents::processscoreevent(#"shield_assist", self, killedplayer, currentweapon);
}

// Namespace globallogic_score/globallogic_score
// Params 4, eflags: 0x0
// Checksum 0x417da987, Offset: 0x6388
// Size: 0x39c
function function_73f2c8b2(killedplayer, damagedone, weapon, assist_level = undefined) {
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
    self incpersstat("assists", 1, 1, 1);
    self.assists = self getpersstat("assists");
    if (isdefined(killedplayer) && isplayer(killedplayer)) {
        self incpersstat("EKIA", 1, 1, 1);
        self.ekia = self getpersstat("EKIA");
    }
    if (isdefined(weapon)) {
        weaponpickedup = 0;
        if (isdefined(self.pickedupweapons) && isdefined(self.pickedupweapons[weapon])) {
            weaponpickedup = 1;
        }
        self stats::function_c8a05f4f(weapon, #"assists", 1, self.class_num, weaponpickedup);
    }
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
}

// Namespace globallogic_score/globallogic_score
// Params 3, eflags: 0x0
// Checksum 0xb1bd5a61, Offset: 0x6730
// Size: 0xe8
function function_eea272b2(attacker, inflictor, weapon) {
    if (!isdefined(attacker) || !isdefined(attacker.team) || self util::isenemyplayer(attacker) == 0) {
        return false;
    }
    if (self == attacker || attacker.classname == "trigger_hurt_new" || attacker.classname == "worldspawn") {
        return false;
    }
    if (killstreaks::is_killstreak_weapon(weapon)) {
        return false;
    }
    if (attacker.team == #"spectator") {
        return false;
    }
    return true;
}

// Namespace globallogic_score/globallogic_score
// Params 3, eflags: 0x0
// Checksum 0x46af997d, Offset: 0x6820
// Size: 0x1ec
function processkillstreakassists(attacker, inflictor, weapon) {
    if (!function_eea272b2(attacker, inflictor, weapon)) {
        return;
    }
    params = {#players:[], #attacker:attacker, #inflictor:inflictor, #weapon:weapon};
    foreach (player in level.players) {
        if (player.team != attacker.team) {
            continue;
        }
        if (player == attacker) {
            continue;
        }
        if (player.sessionstate != "playing") {
            continue;
        }
        if (!isdefined(params.players)) {
            params.players = [];
        } else if (!isarray(params.players)) {
            params.players = array(params.players);
        }
        params.players[params.players.size] = player;
    }
    callback::callback(#"hash_425352b435722271", params);
}

// Namespace globallogic_score/globallogic_score
// Params 0, eflags: 0x0
// Checksum 0xe6cc980b, Offset: 0x6a18
// Size: 0xa4
function updateteamscorebyroundswon() {
    if (level.scoreroundwinbased) {
        foreach (team, _ in level.teams) {
            [[ level._setteamscore ]](team, game.stat[#"roundswon"][team]);
        }
    }
}

// Namespace globallogic_score/globallogic_score
// Params 6, eflags: 0x0
// Checksum 0xc532402b, Offset: 0x6ac8
// Size: 0x2fe
function function_ec4dec3f(nemesis_name, value, nemesis_rank, var_1ac9f5b5, nemesis_xp, nemesis_xuid) {
    if (!isdefined(self.pers[#"nemesis_tracking"][nemesis_name])) {
        self.pers[#"nemesis_tracking"][nemesis_name] = {#name:nemesis_name, #value:0};
    }
    self.pers[#"nemesis_tracking"][nemesis_name].value = self.pers[#"nemesis_tracking"][nemesis_name].value + value;
    if (self.pers[#"nemesis_name"] == "" || self.pers[#"nemesis_tracking"][nemesis_name].value > self.pers[#"nemesis_tracking"][self.pers[#"nemesis_name"]].value) {
        assert(isdefined(nemesis_name), "<dev string:x77>" + self.name);
        assert(isstring(nemesis_name), "<dev string:x98>" + nemesis_name + "<dev string:xa1>" + self.name);
        self.pers[#"nemesis_name"] = nemesis_name;
        self.pers[#"nemesis_rank"] = nemesis_rank;
        self.pers[#"nemesis_rankicon"] = var_1ac9f5b5;
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
// Checksum 0xccac6e07, Offset: 0x6dd0
// Size: 0x54
function function_6b623aa1(params) {
    if (isdefined(self) && isdefined(self.pers)) {
        self.pers[#"hash_49e7469988944ecf"] = undefined;
        self.pers[#"hash_53919d92ff1d039"] = undefined;
    }
}

// Namespace globallogic_score/globallogic_score
// Params 1, eflags: 0x0
// Checksum 0x6ece9877, Offset: 0x6e30
// Size: 0x34
function function_8020890f(params) {
    if (params.var_b75f6e20 === 0) {
        return;
    }
    function_6b623aa1(params);
}

