#using scripts/core_common/callbacks_shared;
#using scripts/core_common/rank_shared;
#using scripts/core_common/scoreevents_shared;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;

#namespace persistence;

// Namespace persistence/persistence_shared
// Params 0, eflags: 0x2
// Checksum 0x3938c9b0, Offset: 0x2f8
// Size: 0x34
function autoexec __init__sytem__() {
    system::register("persistence", &__init__, undefined, undefined);
}

// Namespace persistence/persistence_shared
// Params 0, eflags: 0x0
// Checksum 0xb2da7833, Offset: 0x338
// Size: 0x44
function __init__() {
    callback::on_start_gametype(&init);
    callback::on_connect(&on_player_connect);
}

// Namespace persistence/persistence_shared
// Params 0, eflags: 0x0
// Checksum 0x96068779, Offset: 0x388
// Size: 0x74
function init() {
    level.var_d1b7628a = 1;
    level.persistentdatainfo = [];
    level.maxrecentstats = 10;
    level.maxhitlocations = 19;
    level thread initialize_stat_tracking();
    level thread function_f352670b();
}

// Namespace persistence/persistence_shared
// Params 0, eflags: 0x0
// Checksum 0x12321ee8, Offset: 0x408
// Size: 0x14
function on_player_connect() {
    self.var_84bed14d = 1;
}

// Namespace persistence/persistence_shared
// Params 0, eflags: 0x0
// Checksum 0xd7f83588, Offset: 0x428
// Size: 0x27c
function initialize_stat_tracking() {
    level.globalexecutions = 0;
    level.globalchallenges = 0;
    level.globalsharepackages = 0;
    level.globalcontractsfailed = 0;
    level.globalcontractspassed = 0;
    level.globalcontractscppaid = 0;
    level.globalkillstreakscalled = 0;
    level.globalkillstreaksdestroyed = 0;
    level.globalkillstreaksdeathsfrom = 0;
    level.globallarryskilled = 0;
    level.globalbuzzkills = 0;
    level.globalrevives = 0;
    level.globalafterlifes = 0;
    level.globalcomebacks = 0;
    level.globalpaybacks = 0;
    level.globalbackstabs = 0;
    level.globalbankshots = 0;
    level.globalskewered = 0;
    level.globalteammedals = 0;
    level.globalfeetfallen = 0;
    level.globaldistancesprinted = 0;
    level.globaldembombsprotected = 0;
    level.globaldembombsdestroyed = 0;
    level.globalbombsdestroyed = 0;
    level.globalfraggrenadesfired = 0;
    level.globalsatchelchargefired = 0;
    level.globalshotsfired = 0;
    level.globalcrossbowfired = 0;
    level.globalcarsdestroyed = 0;
    level.globalbarrelsdestroyed = 0;
    level.globalbombsdestroyedbyteam = [];
    foreach (team in level.teams) {
        level.globalbombsdestroyedbyteam[team] = 0;
    }
}

// Namespace persistence/persistence_shared
// Params 0, eflags: 0x0
// Checksum 0x563406ca, Offset: 0x6b0
// Size: 0x634
function function_f352670b() {
    level waittill("game_ended");
    if (!level.rankedmatch && !level.wagermatch) {
        return;
    }
    totalkills = 0;
    totaldeaths = 0;
    var_54e4f2af = 0;
    totalheadshots = 0;
    totalsuicides = 0;
    totaltimeplayed = 0;
    var_639d35e8 = 0;
    var_4f996c2b = 0;
    var_aefd4904 = 0;
    var_e8d3218d = 0;
    var_c0810d02 = 0;
    var_5d7be06e = 0;
    var_9f3cccb9 = 0;
    var_3fbec512 = [];
    foreach (team in level.teams) {
        var_3fbec512[team] = 0;
    }
    switch (level.gametype) {
    case #"dem":
        var_90259f7d = 0;
        for (index = 0; index < level.bombzones.size; index++) {
            if (!isdefined(level.bombzones[index].bombexploded) || !level.bombzones[index].bombexploded) {
                level.globaldembombsprotected++;
                continue;
            }
            level.globaldembombsdestroyed++;
        }
        break;
    case #"sab":
        foreach (team in level.teams) {
            var_3fbec512[team] = level.globalbombsdestroyedbyteam[team];
        }
        break;
    }
    players = getplayers();
    for (i = 0; i < players.size; i++) {
        player = players[i];
        totaltimeplayed += min(player.timeplayed["total"], level.timeplayedcap);
    }
    if (!util::waslastround()) {
        return;
    }
    waitframe(1);
    players = getplayers();
    for (i = 0; i < players.size; i++) {
        player = players[i];
        totalkills += player.kills;
        totaldeaths += player.deaths;
        var_54e4f2af += player.assists;
        totalheadshots += player.headshots;
        totalsuicides += player.suicides;
        var_9f3cccb9 += player.humiliated;
        totaltimeplayed += int(min(player.timeplayed["alive"], level.timeplayedcap));
        switch (level.gametype) {
        case #"ctf":
            var_639d35e8 += player.captures;
            var_4f996c2b += player.returns;
            break;
        case #"koth":
            var_aefd4904 += player.destructions;
            var_e8d3218d += player.captures;
            break;
        case #"sd":
            var_c0810d02 += player.defuses;
            var_5d7be06e += player.plants;
            break;
        case #"sab":
            if (isdefined(player.team) && isdefined(level.teams[player.team])) {
                var_3fbec512[player.team] = var_3fbec512[player.team] + player.destructions;
            }
            break;
        }
    }
}

// Namespace persistence/persistence_shared
// Params 1, eflags: 0x0
// Checksum 0xc4a6afda, Offset: 0xcf0
// Size: 0x7a
function function_2369852e(dataname) {
    if (isdefined(level.nopersistence) && level.nopersistence) {
        return 0;
    }
    if (!level.onlinegame) {
        return 0;
    }
    return self getdstat("PlayerStatsByGameType", get_gametype_name(), dataname, "StatValue");
}

// Namespace persistence/persistence_shared
// Params 0, eflags: 0x0
// Checksum 0x4040c088, Offset: 0xd78
// Size: 0xaa
function get_gametype_name() {
    if (!isdefined(level.var_ddcbfa19)) {
        if (isdefined(level.hardcoremode) && level.hardcoremode && is_party_gamemode() == 0) {
            prefix = "HC";
        } else {
            prefix = "";
        }
        level.var_ddcbfa19 = tolower(prefix + level.gametype);
    }
    return level.var_ddcbfa19;
}

// Namespace persistence/persistence_shared
// Params 0, eflags: 0x0
// Checksum 0xe71973e6, Offset: 0xe30
// Size: 0x48
function is_party_gamemode() {
    switch (level.gametype) {
    case #"gun":
    case #"oic":
    case #"sas":
    case #"shrp":
        return true;
    }
    return false;
}

// Namespace persistence/persistence_shared
// Params 1, eflags: 0x0
// Checksum 0x256c181c, Offset: 0xe80
// Size: 0x26
function function_78783533(dataname) {
    return level.rankedmatch || level.wagermatch;
}

// Namespace persistence/persistence_shared
// Params 3, eflags: 0x0
// Checksum 0x9d89cbb4, Offset: 0xeb0
// Size: 0xa4
function function_e885624a(dataname, value, incvalue) {
    if (isdefined(level.nopersistence) && level.nopersistence) {
        return 0;
    }
    if (!function_78783533(dataname)) {
        return;
    }
    if (level.disablestattracking) {
        return;
    }
    self setdstat("PlayerStatsByGameType", get_gametype_name(), dataname, "StatValue", value);
}

// Namespace persistence/persistence_shared
// Params 0, eflags: 0x0
// Checksum 0xf7a41c62, Offset: 0xf60
// Size: 0x64
function adjust_recent_stats() {
    /#
        if (getdvarint("<dev string:x28>") == 1 || getdvarint("<dev string:x3f>") == 1) {
            return;
        }
    #/
    initialize_match_stats();
}

// Namespace persistence/persistence_shared
// Params 3, eflags: 0x0
// Checksum 0x9bec8340, Offset: 0xfd0
// Size: 0xec
function get_recent_stat(isglobal, index, statname) {
    if (level.wagermatch) {
        return self getdstat("RecentEarnings", index, statname);
    }
    if (isglobal) {
        modename = util::getcurrentgamemode();
        return self getdstat("gameHistory", modename, "matchHistory", index, statname);
    }
    return self getdstat("PlayerStatsByGameType", get_gametype_name(), "prevScores", index, statname);
}

// Namespace persistence/persistence_shared
// Params 4, eflags: 0x0
// Checksum 0x1c85775, Offset: 0x10c8
// Size: 0x1b4
function set_recent_stat(isglobal, index, statname, value) {
    if (!isglobal) {
        index = self getdstat("PlayerStatsByGameType", get_gametype_name(), "prevScoreIndex");
        if (index < 0 || index > 9) {
            return;
        }
    }
    if (isdefined(level.nopersistence) && level.nopersistence) {
        return;
    }
    if (!level.onlinegame) {
        return;
    }
    if (!function_78783533(statname)) {
        return;
    }
    if (level.wagermatch) {
        self setdstat("RecentEarnings", index, statname, value);
        return;
    }
    if (isglobal) {
        modename = util::getcurrentgamemode();
        self setdstat("gameHistory", modename, "matchHistory", "" + index, statname, value);
        return;
    }
    self setdstat("PlayerStatsByGameType", get_gametype_name(), "prevScores", index, statname, value);
}

// Namespace persistence/persistence_shared
// Params 4, eflags: 0x0
// Checksum 0x4f0d34f0, Offset: 0x1288
// Size: 0x124
function add_recent_stat(isglobal, index, statname, value) {
    if (isdefined(level.nopersistence) && level.nopersistence) {
        return;
    }
    if (!level.onlinegame) {
        return;
    }
    if (!function_78783533(statname)) {
        return;
    }
    if (!isglobal) {
        index = self getdstat("PlayerStatsByGameType", get_gametype_name(), "prevScoreIndex");
        if (index < 0 || index > 9) {
            return;
        }
    }
    currstat = get_recent_stat(isglobal, index, statname);
    set_recent_stat(isglobal, index, statname, currstat + value);
}

// Namespace persistence/persistence_shared
// Params 2, eflags: 0x0
// Checksum 0xa8941848, Offset: 0x13b8
// Size: 0x8c
function set_match_history_stat(statname, value) {
    modename = util::getcurrentgamemode();
    historyindex = self getdstat("gameHistory", modename, "currentMatchHistoryIndex");
    set_recent_stat(1, historyindex, statname, value);
}

// Namespace persistence/persistence_shared
// Params 2, eflags: 0x0
// Checksum 0x626e95fb, Offset: 0x1450
// Size: 0x8c
function add_match_history_stat(statname, value) {
    modename = util::getcurrentgamemode();
    historyindex = self getdstat("gameHistory", modename, "currentMatchHistoryIndex");
    add_recent_stat(1, historyindex, statname, value);
}

// Namespace persistence/persistence_shared
// Params 0, eflags: 0x0
// Checksum 0x41d57b59, Offset: 0x14e8
// Size: 0x17c
function initialize_match_stats() {
    if (isdefined(level.nopersistence) && level.nopersistence) {
        return;
    }
    if (!level.onlinegame) {
        return;
    }
    if (!(level.rankedmatch || level.wagermatch || level.leaguematch)) {
        return;
    }
    self.pers["lastHighestScore"] = self getdstat("HighestStats", "highest_score");
    if (sessionmodeismultiplayergame()) {
        self.pers["lastHighestKills"] = self getdstat("HighestStats", "highest_kills");
        self.pers["lastHighestKDRatio"] = self getdstat("HighestStats", "highest_kdratio");
    }
    currgametype = get_gametype_name();
    self gamehistorystartmatch(getgametypeenumfromname(currgametype, level.hardcoremode));
}

// Namespace persistence/persistence_shared
// Params 0, eflags: 0x0
// Checksum 0xdfada857, Offset: 0x1670
// Size: 0xe
function function_d1b7628a() {
    return level.var_d1b7628a;
}

// Namespace persistence/persistence_shared
// Params 3, eflags: 0x0
// Checksum 0xf06b02fa, Offset: 0x1688
// Size: 0x5c
function function_3ec1e50f(playerindex, statname, value) {
    if (function_d1b7628a()) {
        self setdstat("AfterActionReportStats", "playerStats", playerindex, statname, value);
    }
}

// Namespace persistence/persistence_shared
// Params 3, eflags: 0x0
// Checksum 0x20f64dc2, Offset: 0x16f0
// Size: 0x64
function function_ae338cde(playerindex, medalindex, value) {
    if (function_d1b7628a()) {
        self setdstat("AfterActionReportStats", "playerStats", playerindex, "medals", medalindex, value);
    }
}

// Namespace persistence/persistence_shared
// Params 3, eflags: 0x0
// Checksum 0xe08a9ecb, Offset: 0x1760
// Size: 0xe4
function set_after_action_report_stat(statname, value, index) {
    if (self isbot()) {
        return;
    }
    /#
        if (getdvarint("<dev string:x28>") == 1 || getdvarint("<dev string:x3f>") == 1) {
            return;
        }
    #/
    if (function_d1b7628a()) {
        if (isdefined(index)) {
            self setaarstat(statname, index, value);
            return;
        }
        self setaarstat(statname, value);
    }
}

// Namespace persistence/player_challengecomplete
// Params 1, eflags: 0x40
// Checksum 0x1cfe629f, Offset: 0x1850
// Size: 0x58c
function event_handler[player_challengecomplete] codecallback_challengecomplete(eventstruct) {
    rewardxp = eventstruct.reward;
    maxval = eventstruct.max;
    row = eventstruct.row;
    tablenumber = eventstruct.var_3ac3849f;
    challengetype = eventstruct.challenge_type;
    itemindex = eventstruct.item_index;
    challengeindex = eventstruct.challenge_index;
    params = spawnstruct();
    params.rewardxp = rewardxp;
    params.maxval = maxval;
    params.row = row;
    params.tablenumber = tablenumber;
    params.challengetype = challengetype;
    params.itemindex = itemindex;
    params.challengeindex = challengeindex;
    if (sessionmodeiscampaigngame()) {
        if (isdefined(self.challenge_callback_cp)) {
            [[ self.challenge_callback_cp ]](rewardxp, maxval, row, tablenumber, challengetype, itemindex, challengeindex);
        }
        return;
    }
    callback::callback(#"hash_b286c65c", params);
    self luinotifyevent(%challenge_complete, 7, challengeindex, itemindex, challengetype, tablenumber, row, maxval, rewardxp);
    self luinotifyeventtospectators(%challenge_complete, 7, challengeindex, itemindex, challengetype, tablenumber, row, maxval, rewardxp);
    tablenumber += 1;
    tablename = "gamedata/stats/mp/statsmilestones" + tablenumber + ".csv";
    challengestring = tablelookupcolumnforrow(tablename, row, 5);
    challengetier = int(tablelookupcolumnforrow(tablename, row, 1));
    matchrecordlogchallengecomplete(self, tablenumber, challengetier, itemindex, challengestring);
    /#
        if (getdvarint("<dev string:x55>", 0) != 0) {
            challengedescstring = challengestring + "<dev string:x69>";
            challengetiernext = int(tablelookupcolumnforrow(tablename, row + 1, 1));
            tiertext = "<dev string:x6f>" + challengetier;
            herostring = "<dev string:x7f>";
            heroinfo = getunlockableiteminfofromindex(itemindex);
            if (isdefined(heroinfo)) {
                herostring = heroinfo.displayname;
            }
            if (getdvarint("<dev string:x55>") == 1) {
                iprintlnbold(makelocalizedstring(challengestring) + "<dev string:x80>" + maxval + "<dev string:x84>" + makelocalizedstring(herostring));
                return;
            }
            if (getdvarint("<dev string:x55>") == 2) {
                self iprintlnbold(makelocalizedstring(challengestring) + "<dev string:x80>" + maxval + "<dev string:x84>" + makelocalizedstring(herostring));
                return;
            }
            if (getdvarint("<dev string:x55>") == 3) {
                iprintln(makelocalizedstring(challengestring) + "<dev string:x80>" + maxval + "<dev string:x84>" + makelocalizedstring(herostring));
            }
        }
    #/
}

// Namespace persistence/player_gunchallengecomplete
// Params 1, eflags: 0x40
// Checksum 0xe63b879c, Offset: 0x1de8
// Size: 0x15c
function event_handler[player_gunchallengecomplete] codecallback_gunchallengecomplete(eventstruct) {
    rewardxp = eventstruct.reward;
    attachmentindex = eventstruct.attachment_index;
    itemindex = eventstruct.item_index;
    rankid = eventstruct.rank_id;
    islastrank = eventstruct.is_lastrank;
    if (sessionmodeiscampaigngame()) {
        self notify(#"gun_level_complete", {#reward_xp:rewardxp, #attachment_index:attachmentindex, #item_index:itemindex, #rank:rankid, #is_last_rank:islastrank});
        return;
    }
    self luinotifyevent(%gun_level_complete, 4, rankid, itemindex, attachmentindex, rewardxp);
    self luinotifyeventtospectators(%gun_level_complete, 4, rankid, itemindex, attachmentindex, rewardxp);
}

// Namespace persistence/persistence_shared
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x1f50
// Size: 0x4
function check_contract_expirations() {
    
}

// Namespace persistence/persistence_shared
// Params 1, eflags: 0x0
// Checksum 0x154f5479, Offset: 0x1f60
// Size: 0xc
function increment_contract_times(var_9c648312) {
    
}

// Namespace persistence/persistence_shared
// Params 2, eflags: 0x0
// Checksum 0xf47168c0, Offset: 0x1f78
// Size: 0x14
function function_8e1fc5b5(index, passed) {
    
}

// Namespace persistence/persistence_shared
// Params 0, eflags: 0x0
// Checksum 0xa8195161, Offset: 0x1f98
// Size: 0x44
function upload_stats_soon() {
    self notify(#"upload_stats_soon");
    self endon(#"upload_stats_soon");
    self endon(#"disconnect");
    wait 1;
    uploadstats(self);
}

// Namespace persistence/persistence_shared
// Params 4, eflags: 0x0
// Checksum 0x2f0d91d1, Offset: 0x1fe8
// Size: 0x24
function function_8cbcaaa5(stattype, dataname, value, weapon) {
    
}

