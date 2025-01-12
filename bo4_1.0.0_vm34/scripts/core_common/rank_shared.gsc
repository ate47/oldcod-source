#using scripts\core_common\callbacks_shared;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\scoreevents_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace rank;

// Namespace rank/rank_shared
// Params 0, eflags: 0x2
// Checksum 0x22319c4c, Offset: 0xe8
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"rank", &__init__, undefined, undefined);
}

// Namespace rank/rank_shared
// Params 0, eflags: 0x0
// Checksum 0xddf3afaf, Offset: 0x130
// Size: 0x24
function __init__() {
    callback::on_start_gametype(&init);
}

// Namespace rank/rank_shared
// Params 0, eflags: 0x0
// Checksum 0x738bc3ca, Offset: 0x160
// Size: 0x34c
function init() {
    level.scoreinfo = [];
    level.rankxpcap = getxpcap();
    level.usingmomentum = 1;
    level.usingscorestreaks = getdvarint(#"scr_scorestreaks", 0) != 0;
    level.scorestreaksmaxstacking = getdvarint(#"scr_scorestreaks_maxstacking", 0);
    level.maxinventoryscorestreaks = getdvarint(#"scr_maxinventory_scorestreaks", 3);
    level.usingrampage = !isdefined(level.usingscorestreaks) || !level.usingscorestreaks;
    level.rampagebonusscale = getdvarfloat(#"scr_rampagebonusscale", 0);
    level.ranktable = [];
    if (sessionmodeiscampaigngame()) {
        level.xpscale = getdvarfloat(#"scr_xpscalecp", 0);
    } else if (sessionmodeiszombiesgame()) {
        level.xpscale = getdvarfloat(#"scr_xpscalezm", 0);
    } else {
        level.xpscale = getdvarfloat(#"scr_xpscalemp", 0);
    }
    initscoreinfo();
    level.maxrank = int(getrankcap());
    level.maxprestige = int(getprestigecap());
    for (rankid = 0; rankid <= level.maxrank; rankid++) {
        level.ranktable[rankid][0] = getrankminxp(rankid);
        level.ranktable[rankid][1] = getrankmaxxp(rankid);
        level.ranktable[rankid][2] = level.ranktable[rankid][1] - level.ranktable[rankid][0];
    }
    callback::on_connect(&on_player_connect);
}

// Namespace rank/rank_shared
// Params 0, eflags: 0x0
// Checksum 0x6202b077, Offset: 0x4b8
// Size: 0x596
function initscoreinfo() {
    scoreinfotablename = scoreevents::getscoreeventtablename(level.gametype);
    rowcount = tablelookuprowcount(scoreinfotablename);
    for (row = 0; row < rowcount; row++) {
        type = tablelookupcolumnforrow(scoreinfotablename, row, 0);
        if (isdefined(type) && type != "") {
            labelstring = tablelookupcolumnforrow(scoreinfotablename, row, 9);
            label = undefined;
            if (labelstring != "") {
                label = tablelookup(scoreinfotablename, 0, type, 9);
            }
            lp = int(tablelookupcolumnforrow(scoreinfotablename, row, 1));
            xp = int(tablelookupcolumnforrow(scoreinfotablename, row, 2));
            sp = int(tablelookupcolumnforrow(scoreinfotablename, row, 3));
            hs = int(tablelookupcolumnforrow(scoreinfotablename, row, 4));
            res = float(tablelookupcolumnforrow(scoreinfotablename, row, 5));
            var_69303d11 = tablelookupcolumnforrow(scoreinfotablename, row, 6);
            dp = int(tablelookupcolumnforrow(scoreinfotablename, row, 7));
            is_objective = tablelookupcolumnforrow(scoreinfotablename, row, 8);
            medalname = tablelookupcolumnforrow(scoreinfotablename, row, 11);
            job_type = tablelookupcolumnforrow(scoreinfotablename, row, 16);
            var_cf57fc38 = tablelookupcolumnforrow(scoreinfotablename, row, 17);
            var_18366b8 = tablelookupcolumnforrow(scoreinfotablename, row, 18);
            var_48fb9c56 = tablelookupcolumnforrow(scoreinfotablename, row, 19);
            var_54ddad65 = tablelookupcolumnforrow(scoreinfotablename, row, 20);
            is_deprecated = tablelookupcolumnforrow(scoreinfotablename, row, 21);
            bounty_reward = tablelookupcolumnforrow(scoreinfotablename, row, 22);
            registerscoreinfo(type, row, lp, xp, sp, hs, res, var_69303d11, dp, is_objective, label, medalname, job_type, var_cf57fc38, var_18366b8, var_48fb9c56, var_54ddad65, is_deprecated, bounty_reward);
            if (!isdefined(game.scoreinfoinitialized)) {
                setddlstat = tablelookupcolumnforrow(scoreinfotablename, row, 12);
                addplayerstat = 0;
                if (setddlstat) {
                    addplayerstat = 1;
                }
                ismedal = 0;
                var_a2ae64a = tablelookup(scoreinfotablename, 0, type, 10);
                var_e7c54ed1 = tablelookup(scoreinfotablename, 0, type, 11);
                if (isdefined(var_a2ae64a) && var_a2ae64a != #"" && isdefined(var_e7c54ed1) && var_e7c54ed1 != #"") {
                    ismedal = 1;
                }
                registerxp(type, xp, addplayerstat, ismedal, dp, row);
            }
        }
    }
    game.scoreinfoinitialized = 1;
}

// Namespace rank/rank_shared
// Params 1, eflags: 0x0
// Checksum 0xa644d31d, Offset: 0xa58
// Size: 0x50
function getrankxpcapped(inrankxp) {
    if (isdefined(level.rankxpcap) && level.rankxpcap && level.rankxpcap <= inrankxp) {
        return level.rankxpcap;
    }
    return inrankxp;
}

// Namespace rank/rank_shared
// Params 19, eflags: 0x0
// Checksum 0x24b8532b, Offset: 0xab0
// Size: 0x668
function registerscoreinfo(type, row, lp, xp, sp, hs, res, var_69303d11, dp, is_obj, label, medalname, job_type, var_cf57fc38, var_18366b8, var_48fb9c56, var_54ddad65, is_deprecated, bounty_reward) {
    overridedvar = "scr_" + level.gametype + "_score_" + type;
    if (getdvarstring(overridedvar) != "") {
        value = getdvarint(overridedvar, 0);
    }
    if (isdefined(xp) && xp) {
        level.scoreinfo[type][#"xp"] = xp;
    }
    if (isdefined(sp) && sp) {
        level.scoreinfo[type][#"sp"] = sp;
    }
    if (sessionmodeismultiplayergame() || sessionmodeiswarzonegame()) {
        level.scoreinfo[type][#"row"] = row;
        if (isdefined(lp) && lp) {
            level.scoreinfo[type][#"lp"] = lp;
        }
        if (isdefined(hs) && hs) {
            level.scoreinfo[type][#"hs"] = hs;
        }
        if (isdefined(res) && res) {
            level.scoreinfo[type][#"res"] = res;
        }
        if (isdefined(var_69303d11) && var_69303d11) {
            level.scoreinfo[type][#"hash_4e7be147d773e419"] = var_69303d11;
        }
        if (isdefined(dp) && dp) {
            level.scoreinfo[type][#"dp"] = dp;
        }
        if (isdefined(is_obj) && is_obj) {
            level.scoreinfo[type][#"isobj"] = is_obj;
        }
        if (isdefined(medalname)) {
            if (type == "kill") {
                multiplier = getgametypesetting(#"killeventscoremultiplier");
                if (multiplier > 0) {
                    if (isdefined(level.scoreinfo[type][#"sp"]) && level.scoreinfo[type][#"sp"]) {
                        level.scoreinfo[type][#"sp"] = int(multiplier * level.scoreinfo[type][#"sp"]);
                    }
                }
            }
        }
        if (isdefined(label)) {
            level.scoreinfo[type][#"label"] = label;
        }
        if (isdefined(medalname) && medalname != "") {
            level.scoreinfo[type][#"medalnamehash"] = hash(medalname);
        }
        if (job_type != "") {
            level.scoreinfo[type][#"job_type"] = job_type;
        }
        if (var_cf57fc38 != "") {
            level.scoreinfo[type][#"hash_401b1493e5188252"] = var_cf57fc38;
        }
        if (var_18366b8 != "") {
            level.scoreinfo[type][#"hash_251eb53657a5574e"] = var_18366b8;
        }
        if (var_48fb9c56 != "") {
            level.scoreinfo[type][#"hash_294ec6af2b8cb400"] = var_48fb9c56;
        }
        if (isdefined(var_54ddad65) && var_54ddad65) {
            level.scoreinfo[type][#"hash_6f22dfa8ea741f95"] = var_54ddad65;
        }
        if (isdefined(is_deprecated) && is_deprecated) {
            level.scoreinfo[type][#"is_deprecated"] = is_deprecated;
        }
        if (isdefined(bounty_reward) && bounty_reward) {
            level.scoreinfo[type][#"bounty_reward"] = bounty_reward;
        }
        return;
    }
    if (sessionmodeiscampaigngame()) {
        if (isdefined(res) && res) {
            level.scoreinfo[type][#"res"] = res;
        }
    }
}

// Namespace rank/rank_shared
// Params 1, eflags: 0x0
// Checksum 0xb428c0dc, Offset: 0x1120
// Size: 0x66
function function_9f61ba96(type) {
    return isdefined(level.scoreinfo[type]) && isdefined(level.scoreinfo[type][#"hash_6f22dfa8ea741f95"]) && level.scoreinfo[type][#"hash_6f22dfa8ea741f95"];
}

// Namespace rank/rank_shared
// Params 1, eflags: 0x0
// Checksum 0x3c35d45a, Offset: 0x1190
// Size: 0x11e
function getscoreinfovalue(type) {
    playerrole = getrole();
    if (isdefined(level.scoreinfo[type])) {
        n_score = isdefined(level.scoreinfo[type][#"sp"]) ? level.scoreinfo[type][#"sp"] : 0;
        if (isdefined(level.scoremodifiercallback) && isdefined(n_score)) {
            n_score = [[ level.scoremodifiercallback ]](type, n_score);
        }
        /#
            var_c9da03e5 = getdvarfloat(#"hash_eae9a8ee387705d", 1);
            n_score = int(n_score * var_c9da03e5);
        #/
        return n_score;
    }
    return 0;
}

// Namespace rank/rank_shared
// Params 1, eflags: 0x0
// Checksum 0xde9484e8, Offset: 0x12b8
// Size: 0x3a
function function_6c082ba6(type) {
    return int(function_cb58556(type) * 1.5);
}

// Namespace rank/rank_shared
// Params 0, eflags: 0x0
// Checksum 0xfd07a4bc, Offset: 0x1300
// Size: 0xa
function getrole() {
    return "prc_mp_slayer";
}

// Namespace rank/rank_shared
// Params 1, eflags: 0x0
// Checksum 0x37f22765, Offset: 0x1318
// Size: 0xce
function getscoreinfoposition(type) {
    playerrole = getrole();
    if (isdefined(level.scoreinfo[type])) {
        n_pos = isdefined(level.scoreinfo[type][#"hash_7c1f7c7897445706"]) ? level.scoreinfo[type][#"hash_7c1f7c7897445706"] : 0;
        if (isdefined(level.scoremodifiercallback) && isdefined(n_pos)) {
            n_resource = [[ level.resourcemodifiercallback ]](type, n_pos);
        }
        return n_pos;
    }
    return 0;
}

// Namespace rank/rank_shared
// Params 1, eflags: 0x0
// Checksum 0x431da82e, Offset: 0x13f0
// Size: 0xd6
function function_cb58556(type) {
    if (!isdefined(type)) {
        return 0;
    }
    playerrole = getrole();
    if (isdefined(level.scoreinfo[type])) {
        var_f51efcdb = isdefined(level.scoreinfo[type][#"hs"]) ? level.scoreinfo[type][#"hs"] : 0;
        if (isdefined(level.var_131ad322) && isdefined(var_f51efcdb)) {
            var_f51efcdb = [[ level.var_131ad322 ]](type, var_f51efcdb);
        }
        return var_f51efcdb;
    }
    return 0;
}

// Namespace rank/rank_shared
// Params 1, eflags: 0x0
// Checksum 0x1f24d623, Offset: 0x14d0
// Size: 0xc6
function getscoreinforesource(type) {
    playerrole = getrole();
    if (isdefined(level.scoreinfo[type])) {
        n_resource = isdefined(level.scoreinfo[type][#"res"]) ? level.scoreinfo[type][#"res"] : 0;
        if (isdefined(level.resourcemodifiercallback) && isdefined(n_resource)) {
            n_resource = [[ level.resourcemodifiercallback ]](type, n_resource);
        }
        return n_resource;
    }
    return 0;
}

// Namespace rank/rank_shared
// Params 1, eflags: 0x0
// Checksum 0xf7470324, Offset: 0x15a0
// Size: 0xc6
function getscoreinfoxp(type) {
    playerrole = getrole();
    if (isdefined(level.scoreinfo[type])) {
        n_xp = isdefined(level.scoreinfo[type][#"xp"]) ? level.scoreinfo[type][#"xp"] : 0;
        if (isdefined(level.xpmodifiercallback) && isdefined(n_xp)) {
            n_xp = [[ level.xpmodifiercallback ]](type, n_xp);
        }
        return n_xp;
    }
    return 0;
}

// Namespace rank/rank_shared
// Params 1, eflags: 0x0
// Checksum 0x8b0884b5, Offset: 0x1670
// Size: 0x34
function shouldskipmomentumdisplay(type) {
    if (isdefined(level.disablemomentum) && level.disablemomentum) {
        return true;
    }
    return false;
}

// Namespace rank/rank_shared
// Params 1, eflags: 0x0
// Checksum 0xbce2050d, Offset: 0x16b0
// Size: 0x2a
function getscoreinfolabel(type) {
    return level.scoreinfo[type][#"label"];
}

// Namespace rank/rank_shared
// Params 1, eflags: 0x0
// Checksum 0x11d1e234, Offset: 0x16e8
// Size: 0x2a
function getcombatefficiencyevent(type) {
    return level.scoreinfo[type][#"combat_efficiency_event"];
}

// Namespace rank/rank_shared
// Params 1, eflags: 0x0
// Checksum 0xfa45909d, Offset: 0x1720
// Size: 0x4c
function doesscoreinfocounttowardrampage(type) {
    return isdefined(level.scoreinfo[type][#"rampage"]) && level.scoreinfo[type][#"rampage"];
}

// Namespace rank/rank_shared
// Params 1, eflags: 0x0
// Checksum 0x7db670ce, Offset: 0x1778
// Size: 0x84
function function_9055b472(type) {
    playerrole = getrole();
    if (isdefined(level.scoreinfo[type])) {
        return (isdefined(level.scoreinfo[type][#"isobj"]) ? level.scoreinfo[type][#"isobj"] : 0);
    }
    return 0;
}

// Namespace rank/rank_shared
// Params 1, eflags: 0x0
// Checksum 0xa8d962c5, Offset: 0x1808
// Size: 0x32
function getrankinfominxp(rankid) {
    return int(level.ranktable[rankid][0]);
}

// Namespace rank/rank_shared
// Params 1, eflags: 0x0
// Checksum 0x94035495, Offset: 0x1848
// Size: 0x32
function getrankinfomaxxp(rankid) {
    return int(level.ranktable[rankid][1]);
}

// Namespace rank/rank_shared
// Params 1, eflags: 0x0
// Checksum 0xd6e8282d, Offset: 0x1888
// Size: 0x32
function getrankinfoxpamt(rankid) {
    return int(level.ranktable[rankid][2]);
}

// Namespace rank/rank_shared
// Params 0, eflags: 0x0
// Checksum 0x6ae1055e, Offset: 0x18c8
// Size: 0xd8
function shouldkickbyrank() {
    if (self ishost()) {
        return false;
    }
    if (level.rankcap > 0 && self.pers[#"rank"] > level.rankcap) {
        return true;
    }
    if (level.rankcap > 0 && level.minprestige == 0 && self.pers[#"plevel"] > 0) {
        return true;
    }
    if (level.minprestige > self.pers[#"plevel"]) {
        return true;
    }
    return false;
}

// Namespace rank/rank_shared
// Params 0, eflags: 0x0
// Checksum 0x2760fea, Offset: 0x19a8
// Size: 0x88
function getrankxpstat() {
    rankxp = self stats::get_stat_global(#"rankxp");
    if (!isdefined(rankxp)) {
        return 0;
    }
    rankxpcapped = getrankxpcapped(rankxp);
    if (rankxp > rankxpcapped) {
        self stats::set_stat_global(#"rankxp", rankxpcapped);
    }
    return rankxpcapped;
}

// Namespace rank/rank_shared
// Params 0, eflags: 0x0
// Checksum 0xbac164bd, Offset: 0x1a38
// Size: 0x60
function getarenapointsstat() {
    arenaslot = arenagetslot();
    arenapoints = self stats::get_stat(#"arenastats", arenaslot, #"points");
    return arenapoints + 1;
}

// Namespace rank/rank_shared
// Params 0, eflags: 0x0
// Checksum 0xcf5acb82, Offset: 0x1aa0
// Size: 0x646
function on_player_connect() {
    self.pers[#"rankxp"] = self getrankxpstat();
    rankid = getrankforxp(self getrankxp());
    self.pers[#"rank"] = rankid;
    self.pers[#"plevel"] = self stats::get_stat_global(#"plevel");
    if (!isdefined(self.pers[#"plevel"])) {
        self.pers[#"plevel"] = 0;
    }
    if (self shouldkickbyrank()) {
        kick(self getentitynumber());
        return;
    }
    if (!isdefined(self.pers[#"participation"])) {
        self.pers[#"participation"] = 0;
    }
    self.rankupdatetotal = 0;
    self.cur_ranknum = rankid;
    assert(isdefined(self.cur_ranknum), "<dev string:x30>" + rankid + "<dev string:x37>");
    prestige = self stats::get_stat_global(#"plevel");
    if (!isdefined(prestige)) {
        prestige = 0;
    }
    self setrank(rankid, prestige);
    self.pers[#"prestige"] = prestige;
    if ((sessionmodeismultiplayergame() || sessionmodeiswarzonegame()) && gamemodeisusingstats() || sessionmodeiszombiesgame() && sessionmodeisonlinegame()) {
        paragonrank = self stats::get_stat_global(#"paragon_rank");
        if (!isdefined(paragonrank)) {
            paragonrank = 0;
        }
        self setparagonrank(paragonrank);
        self.pers[#"paragonrank"] = paragonrank;
        paragoniconid = self stats::get_stat_global(#"paragon_icon_id");
        if (!isdefined(paragoniconid)) {
            paragoniconid = 0;
        }
        self setparagoniconid(paragoniconid);
        self.pers[#"paragoniconid"] = paragoniconid;
    }
    if (!isdefined(self.pers[#"summary"])) {
        self.pers[#"summary"] = [];
        self.pers[#"summary"][#"xp"] = 0;
        self.pers[#"summary"][#"score"] = 0;
        self.pers[#"summary"][#"challenge"] = 0;
        self.pers[#"summary"][#"match"] = 0;
        self.pers[#"summary"][#"misc"] = 0;
    }
    if (gamemodeismode(6) && !isbot(self)) {
        arenapoints = self getarenapointsstat();
        arenapoints = int(min(arenapoints, 100));
        self.pers[#"arenapoints"] = arenapoints;
        self setarenapoints(arenapoints);
    }
    if (level.rankedmatch) {
        self stats::set_stat_global(#"rank", rankid);
        self stats::set_stat_global(#"minxp", getrankinfominxp(rankid));
        self stats::set_stat_global(#"maxxp", getrankinfomaxxp(rankid));
        self stats::set_stat_global(#"lastxp", getrankxpcapped(self.pers[#"rankxp"]));
    }
    self.explosivekills[0] = 0;
}

// Namespace rank/rank_shared
// Params 0, eflags: 0x0
// Checksum 0x7ae6a2ba, Offset: 0x20f0
// Size: 0x84
function atleastoneplayeroneachteam() {
    foreach (team, _ in level.teams) {
        if (!level.playercount[team]) {
            return false;
        }
    }
    return true;
}

// Namespace rank/rank_shared
// Params 1, eflags: 0x0
// Checksum 0x783933e6, Offset: 0x2180
// Size: 0x32
function round_this_number(value) {
    value = int(value + 0.5);
    return value;
}

// Namespace rank/rank_shared
// Params 0, eflags: 0x0
// Checksum 0x21f68e9c, Offset: 0x21c0
// Size: 0x1f0
function updaterank() {
    newrankid = self getrank();
    if (newrankid == self.pers[#"rank"]) {
        return false;
    }
    oldrank = self.pers[#"rank"];
    rankid = self.pers[#"rank"];
    self.pers[#"rank"] = newrankid;
    while (rankid <= newrankid) {
        self stats::set_stat_global(#"rank", rankid);
        self stats::set_stat_global(#"minxp", int(self getrankinfominxp(rankid)));
        self stats::set_stat_global(#"maxxp", int(self getrankinfomaxxp(rankid)));
        rankid++;
    }
    /#
        print("<dev string:x4f>" + oldrank + "<dev string:x5e>" + newrankid + "<dev string:x63>" + self stats::get_stat_global(#"time_played_total"));
    #/
    self setrank(newrankid);
    return true;
}

// Namespace rank/player_rankup
// Params 1, eflags: 0x40
// Checksum 0x9d3fd5c6, Offset: 0x23b8
// Size: 0x150
function event_handler[player_rankup] codecallback_rankup(eventstruct) {
    if (sessionmodeismultiplayergame()) {
        if (eventstruct.rank > 53) {
            self giveachievement("mp_trophy_battle_tested");
        }
        if (eventstruct.rank > 8) {
            self giveachievement("mp_trophy_welcome_to_the_club");
        }
    }
    self.pers[#"rank"] = eventstruct.rank;
    self luinotifyevent(#"rank_up", 3, eventstruct.rank, eventstruct.prestige, eventstruct.unlock_tokens_added);
    self luinotifyeventtospectators(#"rank_up", 3, eventstruct.rank, eventstruct.prestige, eventstruct.unlock_tokens_added);
    if (isdefined(level.playpromotionreaction)) {
        self thread [[ level.playpromotionreaction ]]();
    }
}

// Namespace rank/rank_shared
// Params 1, eflags: 0x0
// Checksum 0x6dcd580, Offset: 0x2510
// Size: 0x68
function getitemindex(refstring) {
    itemindex = getitemindexfromref(refstring);
    assert(itemindex > 0, "<dev string:x71>" + refstring + "<dev string:x8c>" + itemindex);
    return itemindex;
}

// Namespace rank/rank_shared
// Params 0, eflags: 0x0
// Checksum 0xa2bfe96a, Offset: 0x2580
// Size: 0x12
function endgameupdate() {
    player = self;
}

// Namespace rank/rank_shared
// Params 0, eflags: 0x0
// Checksum 0x9ff426b, Offset: 0x25a0
// Size: 0xa4
function getrank() {
    rankxp = getrankxpcapped(self.pers[#"rankxp"]);
    rankid = self.pers[#"rank"];
    if (rankxp < getrankinfominxp(rankid) + getrankinfoxpamt(rankid)) {
        return rankid;
    }
    return getrankforxp(rankxp);
}

// Namespace rank/rank_shared
// Params 0, eflags: 0x0
// Checksum 0x738bd61d, Offset: 0x2650
// Size: 0x44
function getspm() {
    ranklevel = self getrank() + 1;
    return (3 + ranklevel * 0.5) * 10;
}

// Namespace rank/rank_shared
// Params 0, eflags: 0x0
// Checksum 0x3b73bfcf, Offset: 0x26a0
// Size: 0x2a
function getrankxp() {
    return getrankxpcapped(self.pers[#"rankxp"]);
}

// Namespace rank/rank_shared
// Params 1, eflags: 0x0
// Checksum 0x33fd6115, Offset: 0x26d8
// Size: 0x62
function function_c079071f(type) {
    var_3743d3ae = 0;
    if (isdefined(level.scoreinfo[type][#"bounty_reward"])) {
        var_3743d3ae = level.scoreinfo[type][#"bounty_reward"];
    }
    return var_3743d3ae;
}

