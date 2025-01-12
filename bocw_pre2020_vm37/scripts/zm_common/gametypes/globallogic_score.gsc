#using scripts\core_common\ai\zombie_utility;
#using scripts\core_common\bb_shared;
#using scripts\core_common\challenges_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\rank_shared;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;
#using scripts\zm_common\bb;
#using scripts\zm_common\gametypes\globallogic;
#using scripts\zm_common\gametypes\globallogic_audio;
#using scripts\zm_common\gametypes\globallogic_utils;
#using scripts\zm_common\util;

#namespace globallogic_score;

// Namespace globallogic_score/globallogic_score
// Params 0, eflags: 0x1 linked
// Checksum 0x6563d91b, Offset: 0x1a8
// Size: 0x106
function gethighestscoringplayer() {
    players = level.players;
    winner = undefined;
    tie = 0;
    for (i = 0; i < players.size; i++) {
        if (!isdefined(players[i].score)) {
            continue;
        }
        if (players[i].score < 1) {
            continue;
        }
        if (!isdefined(winner) || players[i].score > winner.score) {
            winner = players[i];
            tie = 0;
            continue;
        }
        if (players[i].score == winner.score) {
            tie = 1;
        }
    }
    if (tie || !isdefined(winner)) {
        return undefined;
    }
    return winner;
}

// Namespace globallogic_score/globallogic_score
// Params 0, eflags: 0x1 linked
// Checksum 0x7de5a94b, Offset: 0x2b8
// Size: 0x2e
function resetscorechain() {
    self notify(#"reset_score_chain");
    self.scorechain = 0;
    self.rankupdatetotal = 0;
}

// Namespace globallogic_score/globallogic_score
// Params 0, eflags: 0x1 linked
// Checksum 0xbd00a06, Offset: 0x2f0
// Size: 0x74
function scorechaintimer() {
    self notify(#"score_chain_timer");
    self endon(#"reset_score_chain", #"score_chain_timer", #"death", #"disconnect");
    wait 20;
    self thread resetscorechain();
}

// Namespace globallogic_score/globallogic_score
// Params 1, eflags: 0x1 linked
// Checksum 0x69a809e3, Offset: 0x370
// Size: 0x4e
function roundtonearestfive(score) {
    rounding = score % 5;
    if (rounding <= 2) {
        return (score - rounding);
    }
    return score + 5 - rounding;
}

// Namespace globallogic_score/globallogic_score
// Params 4, eflags: 0x0
// Checksum 0xfaa05f76, Offset: 0x3c8
// Size: 0x1ec
function giveplayermomentumnotification(score, label, *descvalue, countstowardrampage) {
    rampagebonus = 0;
    if (isdefined(level.usingrampage) && level.usingrampage) {
        if (countstowardrampage) {
            if (!isdefined(self.scorechain)) {
                self.scorechain = 0;
            }
            self.scorechain++;
            self thread scorechaintimer();
        }
        if (isdefined(self.scorechain) && self.scorechain >= 999) {
            rampagebonus = roundtonearestfive(int(label * level.rampagebonusscale + 0.5));
        }
    }
    combat_efficiency_factor = 0;
    if (label != 0) {
        self luinotifyevent(#"score_event", 4, descvalue, label, rampagebonus, combat_efficiency_factor);
    }
    label += rampagebonus;
    if (label > 0 && self hasperk(#"specialty_earnmoremomentum")) {
        label = roundtonearestfive(int(label * getdvarfloat(#"perk_killstreakmomentummultiplier", 0) + 0.5));
    }
    _setplayermomentum(self, self.pers[#"momentum"] + label);
}

// Namespace globallogic_score/globallogic_score
// Params 0, eflags: 0x0
// Checksum 0xeb3dee7b, Offset: 0x5c0
// Size: 0x54
function resetplayermomentumondeath() {
    if (isdefined(level.usingscorestreaks) && level.usingscorestreaks) {
        _setplayermomentum(self, 0);
        self thread resetscorechain();
    }
}

// Namespace globallogic_score/globallogic_score
// Params 4, eflags: 0x1 linked
// Checksum 0x6219d03c, Offset: 0x620
// Size: 0x268
function function_144d0392(event, player, victim, *descvalue) {
    score = victim rank::getscoreinfovalue(player);
    assert(isdefined(score));
    xp = victim rank::getscoreinfoxp(player);
    assert(isdefined(xp));
    label = rank::getscoreinfolabel(player);
    var_b393387d = victim.pers[#"score"];
    pixbeginevent(#"hash_50e89abe6f3fe4f1");
    [[ level.onplayerscore ]](player, victim, descvalue);
    newscore = victim.pers[#"score"];
    pixendevent();
    var_89b2d9e4 = newscore - var_b393387d;
    var_10d67c1a = {#type:ishash(player) ? player : hash(player), #player:victim.name, #delta:var_89b2d9e4};
    if (var_89b2d9e4 && !level.gameended && isdefined(label)) {
        victim luinotifyevent(#"score_event", 2, label, var_89b2d9e4);
    }
    self function_3172cf59(victim, newscore, level.weaponnone, var_10d67c1a);
    return var_89b2d9e4;
}

// Namespace globallogic_score/globallogic_score
// Params 6, eflags: 0x1 linked
// Checksum 0xbe065b9c, Offset: 0x890
// Size: 0x52
function giveplayerscore(event, player, victim, descvalue, *weapon, *var_36f23f1f) {
    return function_144d0392(victim, descvalue, weapon, var_36f23f1f);
}

// Namespace globallogic_score/globallogic_score
// Params 3, eflags: 0x1 linked
// Checksum 0xd16e3b73, Offset: 0x8f0
// Size: 0xe4
function default_onplayerscore(event, player, *victim) {
    score = rank::getscoreinfovalue(player);
    var_a08ade2e = zombie_utility::function_6403cf83(#"zombie_point_scalar", victim.team);
    score = int(score * var_a08ade2e);
    assert(isdefined(score));
    _setplayerscore(victim, victim.pers[#"score"] + score);
}

// Namespace globallogic_score/globallogic_score
// Params 4, eflags: 0x1 linked
// Checksum 0x398f3094, Offset: 0x9e0
// Size: 0x22c
function function_3172cf59(player, newscore, *weapon, var_10d67c1a) {
    newscore endon(#"disconnect");
    pixbeginevent(#"hash_12a44df598cfa600");
    event = var_10d67c1a.type;
    scorediff = var_10d67c1a.delta;
    newscore bb::add_to_stat("score", var_10d67c1a.delta);
    if (!isbot(newscore)) {
        if (!isdefined(newscore.pers[#"scoreeventcache"])) {
            newscore.pers[#"scoreeventcache"] = [];
        }
        if (!isdefined(newscore.pers[#"scoreeventcache"][event])) {
            newscore.pers[#"scoreeventcache"][event] = 1;
        } else {
            newscore.pers[#"scoreeventcache"][event] = newscore.pers[#"scoreeventcache"][event] + 1;
        }
    }
    if (scorediff <= 0) {
        pixendevent();
        return;
    }
    recordplayerstats(newscore, "score", weapon);
    newscore stats::function_bb7eedf0(#"score", scorediff);
    newscore stats::function_bb7eedf0(#"score_core", scorediff);
    newscore.score_total += scorediff;
    pixendevent();
}

// Namespace globallogic_score/globallogic_score
// Params 2, eflags: 0x1 linked
// Checksum 0xe6c40218, Offset: 0xc18
// Size: 0xdc
function _setplayerscore(player, score) {
    if (score == player.pers[#"score"]) {
        return;
    }
    player.pers[#"score"] = score;
    player.score = player.pers[#"score"];
    recordplayerstats(player, "score", player.pers[#"score"]);
    player notify(#"hash_e456bbcb1359350");
    player thread globallogic::checkscorelimit();
    player thread globallogic::checkplayerscorelimitsoon();
}

// Namespace globallogic_score/globallogic_score
// Params 1, eflags: 0x1 linked
// Checksum 0x6e2f264, Offset: 0xd00
// Size: 0x24
function _getplayerscore(player) {
    return player.pers[#"score"];
}

// Namespace globallogic_score/globallogic_score
// Params 2, eflags: 0x1 linked
// Checksum 0xd6268f61, Offset: 0xd30
// Size: 0xee
function _setplayermomentum(player, momentum) {
    momentum = math::clamp(momentum, 0, getdvarint(#"hash_6cc2b9f9d4cbe073", 2000));
    oldmomentum = player.pers[#"momentum"];
    if (momentum == oldmomentum) {
        return;
    }
    player bb::add_to_stat("momentum", momentum - oldmomentum);
    if (momentum < oldmomentum) {
    }
    player.pers[#"momentum"] = momentum;
    player.momentum = player.pers[#"momentum"];
}

/#

    // Namespace globallogic_score/globallogic_score
    // Params 0, eflags: 0x0
    // Checksum 0x4c9cd9db, Offset: 0xe28
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
                    _setplayermomentum(player, int(getdvarint(#"hash_6cc2b9f9d4cbe073", 2000) * var_2227c36c / 100));
                }
            }
        }
    }

#/

// Namespace globallogic_score/globallogic_score
// Params 4, eflags: 0x1 linked
// Checksum 0xda7494, Offset: 0xf48
// Size: 0x194
function giveteamscore(event, team, *player, *victim) {
    if (level.overrideteamscore) {
        return;
    }
    pixbeginevent(#"hash_66d4a941ef078585");
    teamscore = game.stat[#"teamscores"][victim];
    [[ level.onteamscore ]](player, victim);
    pixendevent();
    newscore = game.stat[#"teamscores"][victim];
    zmteamscores = {#gametime:function_f8d53445(), #event:player, #team:victim, #diff:newscore - teamscore, #score:newscore};
    function_92d1707f(#"hash_6823717ff11a304a", zmteamscores);
    if (teamscore == newscore) {
        return;
    }
    updateteamscores(victim);
    thread globallogic::checkscorelimit();
}

// Namespace globallogic_score/globallogic_score
// Params 2, eflags: 0x0
// Checksum 0xf233b08c, Offset: 0x10e8
// Size: 0xac
function giveteamscoreforobjective(team, score) {
    teamscore = game.stat[#"teamscores"][team];
    onteamscore(score, team);
    newscore = game.stat[#"teamscores"][team];
    if (teamscore == newscore) {
        return;
    }
    updateteamscores(team);
    thread globallogic::checkscorelimit();
}

// Namespace globallogic_score/globallogic_score
// Params 2, eflags: 0x1 linked
// Checksum 0x548f5ef2, Offset: 0x11a0
// Size: 0x7c
function _setteamscore(team, teamscore) {
    if (teamscore == game.stat[#"teamscores"][team]) {
        return;
    }
    game.stat[#"teamscores"][team] = teamscore;
    updateteamscores(team);
    thread globallogic::checkscorelimit();
}

// Namespace globallogic_score/globallogic_score
// Params 0, eflags: 0x1 linked
// Checksum 0xbb605848, Offset: 0x1228
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
// Checksum 0x2fb84ff7, Offset: 0x1300
// Size: 0x24
function resetallscores() {
    resetteamscores();
    resetplayerscores();
}

// Namespace globallogic_score/globallogic_score
// Params 0, eflags: 0x1 linked
// Checksum 0xa82687ba, Offset: 0x1330
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
// Params 1, eflags: 0x1 linked
// Checksum 0x4c2da0f3, Offset: 0x13d0
// Size: 0x54
function updateteamscores(team) {
    setteamscore(team, game.stat[#"teamscores"][team]);
    level thread globallogic::checkteamscorelimitsoon(team);
}

// Namespace globallogic_score/globallogic_score
// Params 0, eflags: 0x1 linked
// Checksum 0xa50caf0b, Offset: 0x1430
// Size: 0x88
function updateallteamscores() {
    foreach (team, _ in level.teams) {
        updateteamscores(team);
    }
}

// Namespace globallogic_score/globallogic_score
// Params 1, eflags: 0x1 linked
// Checksum 0x5d0cf880, Offset: 0x14c0
// Size: 0x26
function _getteamscore(team) {
    return game.stat[#"teamscores"][team];
}

// Namespace globallogic_score/globallogic_score
// Params 0, eflags: 0x1 linked
// Checksum 0x375a038b, Offset: 0x14f0
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
// Params 2, eflags: 0x1 linked
// Checksum 0xc238a24e, Offset: 0x15e8
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
// Params 2, eflags: 0x1 linked
// Checksum 0xcf6544d2, Offset: 0x16a0
// Size: 0x2a8
function onteamscore(score, team) {
    game.stat[#"teamscores"][team] = game.stat[#"teamscores"][team] + score;
    if (level.scorelimit && game.stat[#"teamscores"][team] > level.scorelimit) {
        game.stat[#"teamscores"][team] = level.scorelimit;
    }
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
    level.laststatustime = gettime();
    if (iswinning.size == 1) {
        foreach (team in iswinning) {
            if (isdefined(level.waswinning[team])) {
                if (level.waswinning.size == 1) {
                }
            }
        }
    }
    if (level.waswinning.size == 1) {
        foreach (team in level.waswinning) {
            if (isdefined(iswinning[team])) {
                if (iswinning.size == 1) {
                    continue;
                }
                if (level.waswinning.size > 1) {
                }
            }
        }
    }
    level.waswinning = iswinning;
}

// Namespace globallogic_score/globallogic_score
// Params 3, eflags: 0x1 linked
// Checksum 0x7ec91490, Offset: 0x1950
// Size: 0xe8
function initpersstat(dataname, record_stats, init_to_stat_value) {
    if (!isdefined(self.pers[dataname])) {
        self.pers[dataname] = 0;
    }
    if (!isdefined(record_stats) || record_stats == 1) {
        recordplayerstats(self, dataname, int(self.pers[dataname]));
    }
    if (isdefined(init_to_stat_value) && init_to_stat_value == 1) {
        self.pers[dataname] = self stats::get_stat(#"playerstatslist", dataname, #"statvalue");
    }
}

// Namespace globallogic_score/globallogic_score
// Params 1, eflags: 0x1 linked
// Checksum 0x3d46d367, Offset: 0x1a40
// Size: 0x18
function getpersstat(dataname) {
    return self.pers[dataname];
}

// Namespace globallogic_score/globallogic_score
// Params 4, eflags: 0x1 linked
// Checksum 0x46674e1d, Offset: 0x1a60
// Size: 0xec
function incpersstat(dataname, increment, record_stats, *includegametype) {
    pixbeginevent(#"incpersstat");
    assert(isdefined(self.pers[increment]), increment + "<dev string:x38>");
    self.pers[increment] = self.pers[increment] + record_stats;
    self stats::function_dad108fa(increment, record_stats);
    if (!isdefined(includegametype) || includegametype == 1) {
        self thread threadedrecordplayerstats(increment);
    }
    pixendevent();
}

// Namespace globallogic_score/globallogic_score
// Params 1, eflags: 0x1 linked
// Checksum 0x11c631a7, Offset: 0x1b58
// Size: 0x44
function threadedrecordplayerstats(dataname) {
    self endon(#"disconnect");
    waittillframeend();
    recordplayerstats(self, dataname, self.pers[dataname]);
}

// Namespace globallogic_score/globallogic_score
// Params 1, eflags: 0x0
// Checksum 0xfed00ec8, Offset: 0x1ba8
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
// Params 5, eflags: 0x0
// Checksum 0x4ff2836f, Offset: 0x1c38
// Size: 0x34c
function trackattackerkill(name, rank, xp, prestige, xuid) {
    self endon(#"disconnect");
    attacker = self;
    waittillframeend();
    pixbeginevent(#"trackattackerkill");
    if (!isdefined(attacker.pers[#"killed_players"][name])) {
        attacker.pers[#"killed_players"][name] = 0;
    }
    if (!isdefined(attacker.killedplayerscurrent[name])) {
        attacker.killedplayerscurrent[name] = 0;
    }
    if (!isdefined(attacker.pers[#"nemesis_tracking"][name])) {
        attacker.pers[#"nemesis_tracking"][name] = 0;
    }
    attacker.pers[#"killed_players"][name]++;
    attacker.killedplayerscurrent[name]++;
    attacker.pers[#"nemesis_tracking"][name] = attacker.pers[#"nemesis_tracking"][name] + 1;
    if (attacker.pers[#"nemesis_name"] == name) {
        attacker challenges::killednemesis();
    }
    if (attacker.pers[#"nemesis_name"] == "" || attacker.pers[#"nemesis_tracking"][name] > attacker.pers[#"nemesis_tracking"][attacker.pers[#"nemesis_name"]]) {
        attacker.pers[#"nemesis_name"] = name;
        attacker.pers[#"nemesis_rank"] = rank;
        attacker.pers[#"nemesis_rankicon"] = prestige;
        attacker.pers[#"nemesis_xp"] = xp;
        attacker.pers[#"nemesis_xuid"] = xuid;
    } else if (isdefined(attacker.pers[#"nemesis_name"]) && attacker.pers[#"nemesis_name"] == name) {
        attacker.pers[#"nemesis_rank"] = rank;
        attacker.pers[#"nemesis_xp"] = xp;
    }
    pixendevent();
}

// Namespace globallogic_score/globallogic_score
// Params 5, eflags: 0x0
// Checksum 0xe88bd450, Offset: 0x1f90
// Size: 0x364
function trackattackeedeath(attackername, rank, xp, prestige, xuid) {
    self endon(#"disconnect");
    waittillframeend();
    pixbeginevent(#"trackattackeedeath");
    if (!isdefined(self.pers[#"killed_by"][attackername])) {
        self.pers[#"killed_by"][attackername] = 0;
    }
    self.pers[#"killed_by"][attackername]++;
    if (!isdefined(self.pers[#"nemesis_tracking"][attackername])) {
        self.pers[#"nemesis_tracking"][attackername] = 0;
    }
    self.pers[#"nemesis_tracking"][attackername] = self.pers[#"nemesis_tracking"][attackername] + 1.5;
    if (self.pers[#"nemesis_name"] == "" || self.pers[#"nemesis_tracking"][attackername] > self.pers[#"nemesis_tracking"][self.pers[#"nemesis_name"]]) {
        self.pers[#"nemesis_name"] = attackername;
        self.pers[#"nemesis_rank"] = rank;
        self.pers[#"nemesis_rankicon"] = prestige;
        self.pers[#"nemesis_xp"] = xp;
        self.pers[#"nemesis_xuid"] = xuid;
    } else if (isdefined(self.pers[#"nemesis_name"]) && self.pers[#"nemesis_name"] == attackername) {
        self.pers[#"nemesis_rank"] = rank;
        self.pers[#"nemesis_xp"] = xp;
    }
    if (self.pers[#"nemesis_name"] == attackername && self.pers[#"nemesis_tracking"][attackername] >= 2) {
        self setclientuivisibilityflag("killcam_nemesis", 1);
    } else {
        self setclientuivisibilityflag("killcam_nemesis", 0);
    }
    pixendevent();
}

// Namespace globallogic_score/globallogic_score
// Params 0, eflags: 0x1 linked
// Checksum 0xa3c2e971, Offset: 0x2300
// Size: 0x6
function default_iskillboosting() {
    return false;
}

// Namespace globallogic_score/globallogic_score
// Params 3, eflags: 0x0
// Checksum 0x54c5d865, Offset: 0x2310
// Size: 0x1ac
function givekillstats(smeansofdeath, *weapon, evictim) {
    self endon(#"disconnect");
    waittillframeend();
    if (level.rankedmatch && self [[ level.iskillboosting ]]()) {
        /#
            self iprintlnbold("<dev string:x85>");
        #/
        return;
    }
    pixbeginevent(#"givekillstats");
    self incpersstat(#"kills", 1, 1, 1);
    self.kills = self getpersstat(#"kills");
    self updatestatratio("kdratio", "kills", "deaths");
    attacker = self;
    if (weapon == "MOD_HEAD_SHOT") {
        attacker thread incpersstat(#"headshots", 1, 1, 0);
        attacker.headshots = attacker.pers[#"headshots"];
        evictim recordkillmodifier("headshot");
    }
    pixendevent();
}

// Namespace globallogic_score/globallogic_score
// Params 1, eflags: 0x0
// Checksum 0x69762d7c, Offset: 0x24c8
// Size: 0x4c
function inctotalkills(team) {
    if (level.teambased && isdefined(level.teams[team])) {
        game.totalkillsteam[team]++;
    }
    game.totalkills++;
}

// Namespace globallogic_score/globallogic_score
// Params 3, eflags: 0x0
// Checksum 0x785c6364, Offset: 0x2520
// Size: 0x154
function setinflictorstat(einflictor, eattacker, weapon) {
    if (!isdefined(eattacker)) {
        return;
    }
    if (!isdefined(einflictor)) {
        eattacker stats::function_e24eec31(weapon, #"hits", 1);
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
        if (weapon == "concussion_grenade" || weapon == "tabun_gas") {
            eattacker stats::function_e24eec31(weapon, #"used", 1);
        }
        eattacker stats::function_e24eec31(weapon, #"hits", 1);
    }
}

// Namespace globallogic_score/globallogic_score
// Params 1, eflags: 0x0
// Checksum 0x7b8cde8, Offset: 0x2680
// Size: 0x112
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
}

// Namespace globallogic_score/globallogic_score
// Params 4, eflags: 0x0
// Checksum 0x11c8f8d4, Offset: 0x27a0
// Size: 0x27c
function processassist(killedplayer, damagedone, weapon, assist_level = undefined) {
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
    switch (weapon.name) {
    case #"concussion_grenade":
        assist_level = "assist_concussion";
        break;
    case #"flash_grenade":
        assist_level = "assist_flash";
        break;
    case #"emp_grenade":
        assist_level = "assist_emp";
        break;
    case #"proximity_grenade":
    case #"proximity_grenade_aoe":
        assist_level = "assist_proximity";
        break;
    }
    self challenges::assisted();
}

