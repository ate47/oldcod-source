#using scripts\core_common\callbacks_shared;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace persistence;

// Namespace persistence/persistence_shared
// Params 0, eflags: 0x2
// Checksum 0xb4d67d93, Offset: 0x90
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"persistence", &__init__, undefined, undefined);
}

// Namespace persistence/persistence_shared
// Params 0, eflags: 0x0
// Checksum 0xa1fdd999, Offset: 0xd8
// Size: 0x24
function __init__() {
    callback::on_start_gametype(&init);
}

// Namespace persistence/persistence_shared
// Params 0, eflags: 0x0
// Checksum 0x6c93e53, Offset: 0x108
// Size: 0x7c
function init() {
    level.persistentdatainfo = [];
    level.maxrecentstats = 10;
    level.maxhitlocations = 19;
    level thread initialize_stat_tracking();
    level callback::add_callback(#"on_end_game", &function_f352670b);
}

// Namespace persistence/persistence_shared
// Params 0, eflags: 0x0
// Checksum 0xe15b8243, Offset: 0x190
// Size: 0x1f2
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
    foreach (team, _ in level.teams) {
        level.globalbombsdestroyedbyteam[team] = 0;
    }
}

// Namespace persistence/persistence_shared
// Params 0, eflags: 0x0
// Checksum 0xa7b54c1d, Offset: 0x390
// Size: 0x5cc
function function_f352670b() {
    if (!level.rankedmatch) {
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
    foreach (team, _ in level.teams) {
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
        foreach (team, _ in level.teams) {
            var_3fbec512[team] = level.globalbombsdestroyedbyteam[team];
        }
        break;
    }
    players = getplayers();
    for (i = 0; i < players.size; i++) {
        player = players[i];
        if (!isdefined(player.timeplayed) || !isdefined(player.timeplayed[#"total"])) {
            continue;
        }
        totaltimeplayed += min(player.timeplayed[#"total"], level.timeplayedcap);
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
        totaltimeplayed += int(min(player.timeplayed[#"alive"], level.timeplayedcap));
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
// Params 0, eflags: 0x0
// Checksum 0xda6d0a12, Offset: 0x968
// Size: 0x74
function adjust_recent_stats() {
    /#
        if (getdvarint(#"scr_writeconfigstrings", 0) == 1 || getdvarint(#"scr_hostmigrationtest", 0) == 1) {
            return;
        }
    #/
    initialize_match_stats();
}

// Namespace persistence/persistence_shared
// Params 0, eflags: 0x0
// Checksum 0xe4c7ee90, Offset: 0x9e8
// Size: 0x32
function function_6748c2a5() {
    if (sessionmodeiswarzonegame()) {
        return #"hash_6d55367d52bbd3fd";
    }
    return #"playerstatsbygametype";
}

// Namespace persistence/persistence_shared
// Params 0, eflags: 0x0
// Checksum 0x4e6190aa, Offset: 0xa28
// Size: 0xd4
function function_1eb75035() {
    index = self stats::get_stat(function_6748c2a5(), util::get_gametype_name(), #"prevscoreindex");
    if (!isdefined(index)) {
        return;
    }
    if (index < 0 || index > 9) {
        return;
    }
    newindex = (index + 1) % 10;
    self stats::set_stat(function_6748c2a5(), util::get_gametype_name(), #"prevscoreindex", newindex);
}

// Namespace persistence/persistence_shared
// Params 3, eflags: 0x0
// Checksum 0xa1cda0b1, Offset: 0xb08
// Size: 0xcc
function get_recent_stat(isglobal, index, statname) {
    if (!isdefined(index)) {
        return;
    }
    if (isglobal) {
        modename = util::getcurrentgamemode();
        return self stats::get_stat(#"gamehistory", modename, #"matchhistory", index, statname);
    }
    return self stats::get_stat(function_6748c2a5(), util::get_gametype_name(), #"prevscores", index, statname);
}

// Namespace persistence/persistence_shared
// Params 4, eflags: 0x0
// Checksum 0xbcb59d9d, Offset: 0xbe0
// Size: 0x17c
function set_recent_stat(isglobal, index, statname, value) {
    if (!isglobal) {
        index = self stats::get_stat(function_6748c2a5(), util::get_gametype_name(), #"prevscoreindex");
        if (!isdefined(index)) {
            return;
        }
        if (index < 0 || index > 9) {
            return;
        }
    }
    if (isdefined(level.nopersistence) && level.nopersistence) {
        return;
    }
    if (!isdefined(index)) {
        return;
    }
    if (isglobal) {
        modename = util::getcurrentgamemode();
        self stats::set_stat(#"gamehistory", modename, #"matchhistory", "" + index, statname, value);
        return;
    }
    self stats::set_stat(function_6748c2a5(), util::get_gametype_name(), #"prevscores", index, statname, value);
}

// Namespace persistence/persistence_shared
// Params 4, eflags: 0x0
// Checksum 0xe41e216a, Offset: 0xd68
// Size: 0x114
function add_recent_stat(isglobal, index, statname, value) {
    if (isdefined(level.nopersistence) && level.nopersistence) {
        return;
    }
    if (!isglobal) {
        index = self stats::get_stat(function_6748c2a5(), util::get_gametype_name(), #"prevscoreindex");
        if (!isdefined(index)) {
            return;
        }
        if (index < 0 || index > 9) {
            return;
        }
    }
    if (!isdefined(index)) {
        return;
    }
    currstat = get_recent_stat(isglobal, index, statname);
    if (isdefined(currstat)) {
        set_recent_stat(isglobal, index, statname, currstat + value);
    }
}

// Namespace persistence/persistence_shared
// Params 2, eflags: 0x0
// Checksum 0xa2e0356e, Offset: 0xe88
// Size: 0x84
function set_match_history_stat(statname, value) {
    modename = util::getcurrentgamemode();
    historyindex = self stats::get_stat(#"gamehistory", modename, #"currentmatchhistoryindex");
    set_recent_stat(1, historyindex, statname, value);
}

// Namespace persistence/persistence_shared
// Params 2, eflags: 0x0
// Checksum 0x2dbdc34c, Offset: 0xf18
// Size: 0x84
function add_match_history_stat(statname, value) {
    modename = util::getcurrentgamemode();
    historyindex = self stats::get_stat(#"gamehistory", modename, #"currentmatchhistoryindex");
    add_recent_stat(1, historyindex, statname, value);
}

// Namespace persistence/persistence_shared
// Params 0, eflags: 0x0
// Checksum 0x1758803c, Offset: 0xfa8
// Size: 0x9c
function initialize_match_stats() {
    if (isdefined(level.nopersistence) && level.nopersistence) {
        return;
    }
    if (!level.onlinegame) {
        return;
    }
    if (!(level.rankedmatch || level.leaguematch)) {
        return;
    }
    currgametype = util::get_gametype_name();
    self gamehistorystartmatch(getgametypeenumfromname(currgametype, level.hardcoremode));
}

// Namespace persistence/player_challengecomplete
// Params 1, eflags: 0x40
// Checksum 0x6b13548d, Offset: 0x1050
// Size: 0x54c
function event_handler[player_challengecomplete] codecallback_challengecomplete(eventstruct) {
    if (getdvarint(#"hash_7c7d16a2a7e8f9a1", 0) == 0) {
        return;
    }
    rewardxp = eventstruct.reward;
    maxval = eventstruct.max;
    row = eventstruct.row;
    tablenumber = eventstruct.table_number;
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
    callback::callback(#"on_challenge_complete", params);
    self luinotifyevent(#"challenge_complete", 7, challengeindex, itemindex, challengetype, tablenumber, row, maxval, rewardxp);
    self luinotifyeventtospectators(#"challenge_complete", 7, challengeindex, itemindex, challengetype, tablenumber, row, maxval, rewardxp);
    tablenumber += 1;
    tablename = #"gamedata/stats/mp/statsmilestones" + tablenumber + ".csv";
    var_7a39ba39 = tablelookupcolumnforrow(tablename, row, 5);
    challengetier = int(tablelookupcolumnforrow(tablename, row, 1));
    matchrecordlogchallengecomplete(self, tablenumber, challengetier, itemindex, var_7a39ba39);
    /#
        if (getdvarint(#"scr_debugchallenges", 0) != 0) {
            challengestring = function_15979fa9(var_7a39ba39);
            challengedescstring = challengestring + "<dev string:x30>";
            challengetiernext = int(tablelookupcolumnforrow(tablename, row + 1, 1));
            tiertext = "<dev string:x36>" + challengetier;
            herostring = "<dev string:x46>";
            heroinfo = getunlockableiteminfofromindex(itemindex, 1);
            if (isdefined(heroinfo)) {
                herostring = heroinfo.displayname;
            }
            if (getdvarint(#"scr_debugchallenges", 0) == 1) {
                iprintlnbold(challengestring + "<dev string:x47>" + maxval + "<dev string:x4b>" + herostring);
                return;
            }
            if (getdvarint(#"scr_debugchallenges", 0) == 2) {
                self iprintlnbold(challengestring + "<dev string:x47>" + maxval + "<dev string:x4b>" + herostring);
                return;
            }
            if (getdvarint(#"scr_debugchallenges", 0) == 3) {
                iprintln(challengestring + "<dev string:x47>" + maxval + "<dev string:x4b>" + herostring);
            }
        }
    #/
}

// Namespace persistence/player_gunchallengecomplete
// Params 1, eflags: 0x40
// Checksum 0xb8499f17, Offset: 0x15a8
// Size: 0x18c
function event_handler[player_gunchallengecomplete] codecallback_gunchallengecomplete(eventstruct) {
    if (getdvarint(#"hash_7c7d16a2a7e8f9a1", 0) == 0) {
        return;
    }
    rewardxp = eventstruct.reward;
    attachmentindex = eventstruct.attachment_index;
    itemindex = eventstruct.item_index;
    rankid = eventstruct.rank_id;
    islastrank = eventstruct.is_lastrank;
    if (sessionmodeiscampaigngame()) {
        self notify(#"gun_level_complete", {#reward_xp:rewardxp, #attachment_index:attachmentindex, #item_index:itemindex, #rank:rankid, #is_last_rank:islastrank});
        return;
    }
    self luinotifyevent(#"gun_level_complete", 4, rankid, itemindex, attachmentindex, rewardxp);
    self luinotifyeventtospectators(#"gun_level_complete", 4, rankid, itemindex, attachmentindex, rewardxp);
}

// Namespace persistence/persistence_shared
// Params 0, eflags: 0x0
// Checksum 0x382f8588, Offset: 0x1740
// Size: 0x54
function upload_stats_soon() {
    self notify(#"upload_stats_soon");
    self endon(#"upload_stats_soon");
    self endon(#"disconnect");
    wait 1;
    uploadstats(self);
}

