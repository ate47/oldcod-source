#using scripts\core_common\callbacks_shared;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\rank_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace persistence;

// Namespace persistence/persistence_shared
// Params 0, eflags: 0x6
// Checksum 0xf5b3f8e4, Offset: 0x98
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"persistence", &preinit, undefined, undefined, undefined);
}

// Namespace persistence/persistence_shared
// Params 0, eflags: 0x4
// Checksum 0x4283479e, Offset: 0xe0
// Size: 0x24
function private preinit() {
    callback::on_start_gametype(&init);
}

// Namespace persistence/persistence_shared
// Params 0, eflags: 0x0
// Checksum 0x3d59e4a3, Offset: 0x110
// Size: 0x44
function init() {
    level.persistentdatainfo = [];
    level.maxrecentstats = 10;
    level.maxhitlocations = 19;
    level thread initialize_stat_tracking();
}

// Namespace persistence/persistence_shared
// Params 0, eflags: 0x0
// Checksum 0xa9fe3fb7, Offset: 0x160
// Size: 0x1fc
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
// Checksum 0x904e7877, Offset: 0x368
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
// Checksum 0x4a417692, Offset: 0x3e8
// Size: 0xdc
function function_acac764e() {
    index = self stats::get_stat(#"playerstatsbygametype", level.var_12323003, #"prevscoreindex");
    if (!isdefined(index)) {
        return;
    }
    if (index < 0 || index > 9) {
        return;
    }
    newindex = (index + 1) % 10;
    self.pers[#"hash_76fbbcf94dab5536"] = newindex;
    self stats::set_stat(#"playerstatsbygametype", level.var_12323003, #"prevscoreindex", newindex);
}

// Namespace persistence/persistence_shared
// Params 3, eflags: 0x0
// Checksum 0x82259209, Offset: 0x4d0
// Size: 0xbc
function get_recent_stat(isglobal, index, statname) {
    if (!isdefined(index)) {
        return;
    }
    if (isglobal) {
        modename = level.var_12323003;
        return self stats::get_stat(#"gamehistory", modename, #"matchhistory", index, statname);
    }
    return self stats::get_stat(#"playerstatsbygametype", level.var_12323003, #"prevscores", index, statname);
}

// Namespace persistence/persistence_shared
// Params 4, eflags: 0x0
// Checksum 0xc0abe65d, Offset: 0x598
// Size: 0x15c
function set_recent_stat(isglobal, index, statname, value) {
    if (!isglobal) {
        index = self stats::get_stat(#"playerstatsbygametype", level.var_12323003, #"prevscoreindex");
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
        modename = level.var_12323003;
        self stats::set_stat(#"gamehistory", modename, #"matchhistory", "" + index, statname, value);
        return;
    }
    self stats::set_stat(#"playerstatsbygametype", level.var_12323003, #"prevscores", index, statname, value);
}

// Namespace persistence/persistence_shared
// Params 4, eflags: 0x0
// Checksum 0x27d4f989, Offset: 0x700
// Size: 0x10c
function add_recent_stat(isglobal, index, statname, value) {
    if (isdefined(level.nopersistence) && level.nopersistence) {
        return;
    }
    if (!isglobal) {
        index = self stats::get_stat(#"playerstatsbygametype", level.var_12323003, #"prevscoreindex");
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
// Checksum 0x2e047133, Offset: 0x818
// Size: 0x84
function set_match_history_stat(statname, value) {
    modename = level.var_12323003;
    historyindex = self stats::get_stat(#"gamehistory", modename, #"currentmatchhistoryindex");
    set_recent_stat(1, historyindex, statname, value);
}

// Namespace persistence/persistence_shared
// Params 2, eflags: 0x0
// Checksum 0xa2df31a9, Offset: 0x8a8
// Size: 0x84
function add_match_history_stat(statname, value) {
    modename = level.var_12323003;
    historyindex = self stats::get_stat(#"gamehistory", modename, #"currentmatchhistoryindex");
    add_recent_stat(1, historyindex, statname, value);
}

// Namespace persistence/persistence_shared
// Params 0, eflags: 0x0
// Checksum 0x86f35fb3, Offset: 0x938
// Size: 0x1e4
function initialize_match_stats() {
    self endon(#"disconnect");
    if (isdefined(level.nopersistence) && level.nopersistence) {
        return;
    }
    if (!level.onlinegame) {
        return;
    }
    if (!(level.rankedmatch || level.leaguematch)) {
        return;
    }
    if (sessionmodeiswarzonegame() || sessionmodeismultiplayergame()) {
        self stats::function_bb7eedf0(#"total_games_played", 1);
        if (is_true(level.hardcoremode)) {
            hc_games_played = self stats::get_stat(#"playerstatslist", #"hc_games_played", #"statvalue") + 1;
            self stats::set_stat(#"playerstatslist", #"hc_games_played", #"statvalue", hc_games_played);
        }
    }
    if (isdefined(level.var_12323003)) {
        self gamehistorystartmatch(level.var_12323003);
        return;
    }
    level.var_12323003 = level.gametype;
    self gamehistorystartmatch(getgametypeenumfromname(level.gametype, level.hardcoremode));
}

// Namespace persistence/player_challengecomplete
// Params 1, eflags: 0x40
// Checksum 0xe3dd0ae2, Offset: 0xb28
// Size: 0x8c
function event_handler[player_challengecomplete] codecallback_challengecomplete(eventstruct) {
    if (sessionmodeiscampaigngame()) {
        if (isdefined(self.challenge_callback_cp)) {
            [[ self.challenge_callback_cp ]](eventstruct.reward, eventstruct.max, eventstruct.row, eventstruct.table_number, eventstruct.challenge_type, eventstruct.item_index, eventstruct.challenge_index);
        }
        return;
    }
    self thread challenge_complete(eventstruct);
}

// Namespace persistence/persistence_shared
// Params 0, eflags: 0x0
// Checksum 0xc12bdc3e, Offset: 0xbc0
// Size: 0x78
function function_6020a116() {
    if (!isdefined(level.var_697b1d55)) {
        level.var_697b1d55 = 0;
    }
    if (!isdefined(level.var_445b1bca)) {
        level.var_445b1bca = 0;
    }
    while (level.var_697b1d55 == gettime() || level.var_445b1bca == gettime()) {
        waitframe(1);
    }
    level.var_697b1d55 = gettime();
}

// Namespace persistence/persistence_shared
// Params 1, eflags: 0x0
// Checksum 0x8b3566b4, Offset: 0xc40
// Size: 0x6c4
function challenge_complete(eventstruct) {
    self endon(#"disconnect");
    function_6020a116();
    callback::callback(#"on_challenge_complete", eventstruct);
    rewardxp = eventstruct.reward;
    maxval = eventstruct.max;
    row = eventstruct.row;
    tablenumber = eventstruct.table_number;
    challengetype = eventstruct.challenge_type;
    itemindex = eventstruct.item_index;
    challengeindex = eventstruct.challenge_index;
    var_c4e9517b = tablenumber + 1;
    if (currentsessionmode() == 0) {
        tablename = #"gamedata/stats/zm/statsmilestones" + var_c4e9517b + ".csv";
        if (var_c4e9517b == 2) {
            var_a05af556 = tablelookupcolumnforrow(tablename, row, 9);
            if (var_a05af556 === #"") {
                return;
            } else if (getdvarint(#"hash_730fab929626f598", 0) == 0) {
                if (var_a05af556 === #"camo_gold" || var_a05af556 === #"camo_diamond" || var_a05af556 === #"camo_darkmatter") {
                    return;
                }
            }
        }
    } else {
        tablename = #"gamedata/stats/mp/statsmilestones" + var_c4e9517b + ".csv";
    }
    var_eb67c133 = tablelookupcolumnforrow(tablename, row, 5);
    if (var_eb67c133 === #"hash_4a80d584aac2e7d0") {
        return;
    }
    /#
        var_54b50d64 = getdvarstring(#"hash_5f6f875e3935912a", "<dev string:x38>");
        if (var_54b50d64 != "<dev string:x38>") {
            challengecategory = tablelookupcolumnforrow(tablename, row, 16);
            if (isdefined(challengecategory) && challengecategory != var_54b50d64) {
                return;
            }
        }
    #/
    self luinotifyevent(#"challenge_complete", 7, challengeindex, itemindex, challengetype, tablenumber, row, maxval, rewardxp);
    self function_8ba40d2f(#"challenge_complete", 7, challengeindex, itemindex, challengetype, tablenumber, row, maxval, rewardxp);
    challengetier = int(tablelookupcolumnforrow(tablename, row, 1));
    matchrecordlogchallengecomplete(self, var_c4e9517b, challengetier, itemindex, var_eb67c133);
    /#
        if (getdvarint(#"debugchallenges", 0) != 0) {
            challengestring = makelocalizedstring(var_eb67c133);
            challengetiernext = int(tablelookupcolumnforrow(tablename, row + 1, 1));
            tiertext = challengetier + 1;
            var_33b913f5 = "<dev string:x3c>";
            if (challengetype == 0) {
                var_33b913f5 = "<dev string:x47>";
            } else if (challengetype == 1) {
                iteminfo = getunlockableiteminfofromindex(itemindex, 1);
                if (isdefined(iteminfo)) {
                    var_33b913f5 = makelocalizedstring(iteminfo.displayname);
                }
            }
            if (issubstr(challengestring, "<dev string:x51>")) {
                if (challengetype == 3) {
                    challengestring = strreplace(challengestring, "<dev string:x51>", "<dev string:x58>" + function_60394171(#"challenge", 3, itemindex));
                }
            }
            if (issubstr(challengestring, "<dev string:x5d>")) {
                challengestring = strreplace(challengestring, "<dev string:x5d>", "<dev string:x58>" + tiertext);
            }
            if (var_33b913f5 == "<dev string:x3c>") {
                var_fb76383b = 1;
                var_fb76383b++;
            }
            msg = var_33b913f5 + "<dev string:x64>" + challengestring + "<dev string:x6b>" + maxval;
            if (getdvarint(#"debugchallenges", 0) == 1) {
                iprintlnbold(msg);
            } else if (getdvarint(#"debugchallenges", 0) == 2) {
                self iprintlnbold(msg);
            } else if (getdvarint(#"debugchallenges", 0) == 3) {
                iprintln(msg);
            }
            println(msg);
        }
    #/
}

// Namespace persistence/player_gunchallengecomplete
// Params 1, eflags: 0x40
// Checksum 0xf10e751a, Offset: 0x1310
// Size: 0x14c
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
    self luinotifyevent(#"gun_level_complete", 4, rankid, itemindex, attachmentindex, rewardxp);
    self function_8ba40d2f(#"gun_level_complete", 4, rankid, itemindex, attachmentindex, rewardxp);
}

// Namespace persistence/persistence_shared
// Params 0, eflags: 0x0
// Checksum 0x6a417822, Offset: 0x1468
// Size: 0x54
function upload_stats_soon() {
    self notify(#"upload_stats_soon");
    self endon(#"upload_stats_soon", #"disconnect");
    wait 1;
    uploadstats(self);
}

