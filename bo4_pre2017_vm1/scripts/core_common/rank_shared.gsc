#using scripts/core_common/callbacks_shared;
#using scripts/core_common/hud_shared;
#using scripts/core_common/player_role;
#using scripts/core_common/scoreevents_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;

#namespace rank;

// Namespace rank/rank_shared
// Params 0, eflags: 0x2
// Checksum 0xa19b6725, Offset: 0x8b0
// Size: 0x34
function autoexec __init__sytem__() {
    system::register("rank", &__init__, undefined, undefined);
}

// Namespace rank/rank_shared
// Params 0, eflags: 0x0
// Checksum 0x16806477, Offset: 0x8f0
// Size: 0x24
function __init__() {
    callback::on_start_gametype(&init);
}

// Namespace rank/rank_shared
// Params 0, eflags: 0x0
// Checksum 0x4b7919b6, Offset: 0x920
// Size: 0x634
function init() {
    level.scoreinfo = [];
    level.var_9364c56a = getdvarfloat("scr_codpointsxpscale");
    level.var_c1745e43 = getdvarfloat("scr_codpointsmatchscale");
    level.var_4e39954b = getdvarfloat("scr_codpointsperchallenge");
    level.rankxpcap = getdvarint("scr_rankXpCap");
    level.var_1846c294 = getdvarint("scr_codPointsCap");
    level.usingmomentum = 1;
    level.usingscorestreaks = getdvarint("scr_scorestreaks") != 0;
    level.scorestreaksmaxstacking = getdvarint("scr_scorestreaks_maxstacking");
    level.maxinventoryscorestreaks = getdvarint("scr_maxinventory_scorestreaks", 3);
    level.usingrampage = !isdefined(level.usingscorestreaks) || !level.usingscorestreaks;
    level.rampagebonusscale = getdvarfloat("scr_rampagebonusscale");
    level.ranktable = [];
    if (sessionmodeiscampaigngame()) {
        level.xpscale = getdvarfloat("scr_xpscalecp");
        level.var_b7e5f751 = "gamedata/tables/cp/cp_ranktable.csv";
        level.var_55417986 = "gamedata/tables/cp/cp_rankIconTable.csv";
    } else if (sessionmodeiszombiesgame()) {
        level.xpscale = getdvarfloat("scr_xpscalezm");
        level.var_b7e5f751 = "gamedata/tables/zm/zm_ranktable.csv";
        level.var_55417986 = "gamedata/tables/zm/zm_rankIconTable.csv";
    } else {
        level.xpscale = getdvarfloat("scr_xpscalemp");
        level.var_b7e5f751 = "gamedata/tables/mp/mp_ranktable.csv";
        level.var_55417986 = "gamedata/tables/mp/mp_rankIconTable.csv";
        level.var_4712114f = "gamedata/tables/mp/mp_levelpointtable.csv";
    }
    initscoreinfo();
    level.maxrank = int(tablelookup(level.var_b7e5f751, 0, "maxrank", 1));
    level.maxprestige = int(tablelookup(level.var_55417986, 0, "maxprestige", 1));
    level.var_d6d75559 = int(tablelookup(level.var_4712114f, 0, "maxlevel", 1));
    rankid = 0;
    rankname = tablelookup(level.var_b7e5f751, 0, rankid, 1);
    assert(isdefined(rankname) && rankname != "<dev string:x28>");
    while (isdefined(rankname) && rankname != "") {
        level.ranktable[rankid][1] = tablelookup(level.var_b7e5f751, 0, rankid, 1);
        level.ranktable[rankid][2] = tablelookup(level.var_b7e5f751, 0, rankid, 2);
        level.ranktable[rankid][3] = tablelookup(level.var_b7e5f751, 0, rankid, 3);
        level.ranktable[rankid][7] = tablelookup(level.var_b7e5f751, 0, rankid, 7);
        level.ranktable[rankid][14] = tablelookup(level.var_b7e5f751, 0, rankid, 14);
        if (sessionmodeiscampaigngame()) {
            level.ranktable[rankid][18] = tablelookup(level.var_b7e5f751, 0, rankid, 18);
        }
        rankid++;
        rankname = tablelookup(level.var_b7e5f751, 0, rankid, 1);
    }
    callback::on_connect(&on_player_connect);
}

// Namespace rank/rank_shared
// Params 0, eflags: 0x0
// Checksum 0x409991a5, Offset: 0xf60
// Size: 0x7c0
function initscoreinfo() {
    scoreinfotablename = scoreevents::getscoreeventtablename(level.gametype);
    for (row = 1; row < 512; row++) {
        type = tablelookupcolumnforrow(scoreinfotablename, row, 0);
        if (type != "") {
            labelstring = tablelookupcolumnforrow(scoreinfotablename, row, 22);
            label = undefined;
            if (labelstring != "") {
                label = tablelookupistring(scoreinfotablename, 0, type, 22);
            }
            var_e93ce202 = int(tablelookupcolumnforrow(scoreinfotablename, row, 1));
            var_ff36e026 = int(tablelookupcolumnforrow(scoreinfotablename, row, 2));
            var_b785c733 = int(tablelookupcolumnforrow(scoreinfotablename, row, 3));
            var_86b1b30d = int(tablelookupcolumnforrow(scoreinfotablename, row, 4));
            var_7d61c4b4 = int(tablelookupcolumnforrow(scoreinfotablename, row, 5));
            var_f9120950 = tablelookupcolumnforrow(scoreinfotablename, row, 6) == "True" ? 1 : 0;
            var_20232f3a = int(tablelookupcolumnforrow(scoreinfotablename, row, 7));
            var_92d7e611 = int(tablelookupcolumnforrow(scoreinfotablename, row, 8));
            var_7cdde7ed = int(tablelookupcolumnforrow(scoreinfotablename, row, 9));
            var_358399a4 = int(tablelookupcolumnforrow(scoreinfotablename, row, 10));
            var_f2e8ac06 = int(tablelookupcolumnforrow(scoreinfotablename, row, 11));
            var_8d1d27bd = int(tablelookupcolumnforrow(scoreinfotablename, row, 12));
            objective_pos = tablelookupcolumnforrow(scoreinfotablename, row, 13) == "True" ? 1 : 0;
            var_96ee629 = int(tablelookupcolumnforrow(scoreinfotablename, row, 14));
            var_80e18731 = int(tablelookupcolumnforrow(scoreinfotablename, row, 15));
            var_6ae7890d = int(tablelookupcolumnforrow(scoreinfotablename, row, 16));
            var_2607a3c4 = int(tablelookupcolumnforrow(scoreinfotablename, row, 17));
            var_e36cb626 = int(tablelookupcolumnforrow(scoreinfotablename, row, 18));
            var_e6e4675d = int(tablelookupcolumnforrow(scoreinfotablename, row, 19));
            var_ba3c8fbd = tablelookupcolumnforrow(scoreinfotablename, row, 20) == "True" ? 1 : 0;
            var_f9f2f049 = int(tablelookupcolumnforrow(scoreinfotablename, row, 21));
            registerscoreinfo(type, row, var_e93ce202, var_ff36e026, var_b785c733, var_86b1b30d, var_7d61c4b4, var_f9120950, var_20232f3a, var_92d7e611, var_7cdde7ed, var_358399a4, var_f2e8ac06, var_8d1d27bd, objective_pos, var_96ee629, var_80e18731, var_6ae7890d, var_2607a3c4, var_e36cb626, var_e6e4675d, var_ba3c8fbd, var_f9f2f049, label);
            if (!isdefined(game.scoreinfoinitialized)) {
                setddlstat = tablelookupcolumnforrow(scoreinfotablename, row, 25);
                addplayerstat = 0;
                if (setddlstat == "TRUE") {
                    addplayerstat = 1;
                }
                ismedal = 0;
                istring = tablelookupistring(scoreinfotablename, 0, type, 23);
                if (isdefined(istring) && istring != %) {
                    ismedal = 1;
                }
                registerxp(type, var_ff36e026, addplayerstat, ismedal, var_20232f3a, row);
            }
        }
    }
    game.scoreinfoinitialized = 1;
}

// Namespace rank/rank_shared
// Params 1, eflags: 0x0
// Checksum 0x9f2a549b, Offset: 0x1728
// Size: 0x50
function getrankxpcapped(inrankxp) {
    if (isdefined(level.rankxpcap) && level.rankxpcap && level.rankxpcap <= inrankxp) {
        return level.rankxpcap;
    }
    return inrankxp;
}

// Namespace rank/rank_shared
// Params 1, eflags: 0x0
// Checksum 0xef63f6e3, Offset: 0x1780
// Size: 0x50
function function_35db3641(var_9400f55b) {
    if (isdefined(level.var_1846c294) && level.var_1846c294 && level.var_1846c294 <= var_9400f55b) {
        return level.var_1846c294;
    }
    return var_9400f55b;
}

// Namespace rank/rank_shared
// Params 24, eflags: 0x0
// Checksum 0x9698c5a1, Offset: 0x17d8
// Size: 0x55c
function registerscoreinfo(type, row, var_e93ce202, var_ff36e026, var_b785c733, var_86b1b30d, var_7d61c4b4, var_f9120950, var_20232f3a, var_92d7e611, var_7cdde7ed, var_358399a4, var_f2e8ac06, var_8d1d27bd, objective_pos, var_96ee629, var_80e18731, var_6ae7890d, var_2607a3c4, var_e36cb626, var_e6e4675d, var_ba3c8fbd, var_f9f2f049, label) {
    overridedvar = "scr_" + level.gametype + "_score_" + type;
    if (getdvarstring(overridedvar) != "") {
        value = getdvarint(overridedvar);
    }
    level.scoreinfo[type]["row"] = row;
    level.scoreinfo[type]["prc_mp_slayer_lp"] = var_e93ce202;
    level.scoreinfo[type]["prc_mp_slayer_xp"] = var_ff36e026;
    level.scoreinfo[type]["prc_mp_slayer_sp"] = var_b785c733;
    level.scoreinfo[type]["prc_mp_slayer_hs"] = var_86b1b30d;
    level.scoreinfo[type]["prc_mp_slayer_res"] = var_7d61c4b4;
    level.scoreinfo[type]["prc_mp_slayer_pos"] = var_f9120950;
    level.scoreinfo[type]["prc_mp_slayer_dp"] = var_20232f3a;
    level.scoreinfo[type]["prc_mp_objective_lp"] = var_92d7e611;
    level.scoreinfo[type]["prc_mp_objective_xp"] = var_7cdde7ed;
    level.scoreinfo[type]["prc_mp_objective_sp"] = var_358399a4;
    level.scoreinfo[type]["prc_mp_objective_hs"] = var_f2e8ac06;
    level.scoreinfo[type]["prc_mp_objective_res"] = var_8d1d27bd;
    level.scoreinfo[type]["prc_mp_objective_pos"] = objective_pos;
    level.scoreinfo[type]["prc_mp_objective_dp"] = var_96ee629;
    level.scoreinfo[type]["prc_mp_support_lp"] = var_80e18731;
    level.scoreinfo[type]["prc_mp_support_xp"] = var_6ae7890d;
    level.scoreinfo[type]["prc_mp_support_sp"] = var_2607a3c4;
    level.scoreinfo[type]["prc_mp_support_hs"] = var_e36cb626;
    level.scoreinfo[type]["prc_mp_support_res"] = var_e6e4675d;
    level.scoreinfo[type]["prc_mp_support_pos"] = var_ba3c8fbd;
    level.scoreinfo[type]["prc_mp_support_dp"] = var_f9f2f049;
    if (type == "kill") {
        multiplier = getgametypesetting("killEventScoreMultiplier");
        if (multiplier > 0) {
            level.scoreinfo[type]["prc_mp_slayer_sp"] = int(multiplier * level.scoreinfo[type]["prc_mp_slayer_sp"]);
            level.scoreinfo[type]["prc_mp_objective_sp"] = int(multiplier * level.scoreinfo[type]["prc_mp_objective_sp"]);
            level.scoreinfo[type]["prc_mp_support_sp"] = int(multiplier * level.scoreinfo[type]["prc_mp_support_sp"]);
        }
    }
    if (isdefined(label)) {
        level.scoreinfo[type]["label"] = label;
    }
}

// Namespace rank/rank_shared
// Params 1, eflags: 0x0
// Checksum 0x11ecde53, Offset: 0x1d40
// Size: 0xd0
function getscoreinfovalue(type) {
    playerrolecategory = self player_role::get_category();
    if (playerrolecategory == "default") {
        playerrolecategory = "prc_mp_slayer";
    }
    if (isdefined(level.scoreinfo[type])) {
        n_score = level.scoreinfo[type][playerrolecategory + "_sp"];
        if (isdefined(level.scoremodifiercallback) && isdefined(n_score)) {
            n_score = [[ level.scoremodifiercallback ]](type, n_score);
        }
        return n_score;
    }
    return 0;
}

// Namespace rank/rank_shared
// Params 1, eflags: 0x0
// Checksum 0xfadef8f7, Offset: 0x1e18
// Size: 0x144
function getscoreinfoposition(type) {
    characterindex = self getspecialistindex();
    assert(player_role::is_valid(characterindex));
    playerrole = getplayerrolecategory(characterindex, currentsessionmode());
    if (!isdefined(playerrole) || playerrole == "default") {
        playerrole = "prc_mp_slayer";
    }
    if (isdefined(level.scoreinfo[type])) {
        n_pos = level.scoreinfo[type][playerrole + "_pos"];
        if (isdefined(level.scoremodifiercallback) && isdefined(n_pos)) {
            n_resource = [[ level.resourcemodifiercallback ]](type, n_pos);
        }
        return n_pos;
    }
    return 0;
}

// Namespace rank/rank_shared
// Params 1, eflags: 0x0
// Checksum 0x293d5cb6, Offset: 0x1f68
// Size: 0x13c
function getscoreinforesource(type) {
    characterindex = self getspecialistindex();
    assert(player_role::is_valid(characterindex));
    playerrole = getplayerrolecategory(characterindex, currentsessionmode());
    if (!isdefined(playerrole) || playerrole == "default") {
        playerrole = "prc_mp_slayer";
    }
    if (isdefined(level.scoreinfo[type])) {
        n_resource = level.scoreinfo[type][playerrole + "_res"];
        if (isdefined(level.scoremodifiercallback) && isdefined(n_resource)) {
            n_resource = [[ level.resourcemodifiercallback ]](type, n_resource);
        }
        return n_resource;
    }
    return 0;
}

// Namespace rank/rank_shared
// Params 1, eflags: 0x0
// Checksum 0xfed7a69e, Offset: 0x20b0
// Size: 0x13c
function getscoreinfoxp(type) {
    characterindex = self getspecialistindex();
    assert(player_role::is_valid(characterindex));
    playerrole = getplayerrolecategory(characterindex, currentsessionmode());
    if (!isdefined(playerrole) || playerrole == "default") {
        playerrole = "prc_mp_slayer";
    }
    if (isdefined(level.scoreinfo[type])) {
        n_xp = level.scoreinfo[type][playerrole + "_xp"];
        if (isdefined(level.xpmodifiercallback) && isdefined(n_xp)) {
            n_xp = [[ level.xpmodifiercallback ]](type, n_xp);
        }
        return n_xp;
    }
    return 0;
}

// Namespace rank/rank_shared
// Params 1, eflags: 0x0
// Checksum 0x71cf9411, Offset: 0x21f8
// Size: 0x150
function function_481d607(type) {
    characterindex = self getspecialistindex();
    assert(player_role::is_valid(characterindex));
    playerrole = getplayerrolecategory(characterindex, currentsessionmode());
    if (!isdefined(playerrole) || playerrole == "default") {
        playerrole = "prc_mp_slayer";
    }
    if (isdefined(level.scoreinfo[type])) {
        var_e21e76a8 = level.scoreinfo[type][playerrole + "_lp"];
        if (!isdefined(var_e21e76a8)) {
            var_e21e76a8 = 0;
        }
        if (isdefined(level.var_7f7d1d97) && isdefined(var_e21e76a8)) {
            var_e21e76a8 = [[ level.var_7f7d1d97 ]](type, var_e21e76a8);
        }
        return var_e21e76a8;
    }
    return 0;
}

// Namespace rank/rank_shared
// Params 1, eflags: 0x0
// Checksum 0x8995263c, Offset: 0x2350
// Size: 0x32
function shouldskipmomentumdisplay(type) {
    if (isdefined(level.disablemomentum) && level.disablemomentum) {
        return true;
    }
    return false;
}

// Namespace rank/rank_shared
// Params 1, eflags: 0x0
// Checksum 0xbafac10c, Offset: 0x2390
// Size: 0x26
function getscoreinfolabel(type) {
    return level.scoreinfo[type]["label"];
}

// Namespace rank/rank_shared
// Params 1, eflags: 0x0
// Checksum 0x24551dd1, Offset: 0x23c0
// Size: 0x26
function getcombatefficiencyevent(type) {
    return level.scoreinfo[type]["combat_efficiency_event"];
}

// Namespace rank/rank_shared
// Params 1, eflags: 0x0
// Checksum 0xeb61df27, Offset: 0x23f0
// Size: 0x46
function doesscoreinfocounttowardrampage(type) {
    return isdefined(level.scoreinfo[type]["rampage"]) && level.scoreinfo[type]["rampage"];
}

// Namespace rank/rank_shared
// Params 1, eflags: 0x0
// Checksum 0xf7c7807b, Offset: 0x2440
// Size: 0x32
function getrankinfominxp(rankid) {
    return int(level.ranktable[rankid][2]);
}

// Namespace rank/rank_shared
// Params 1, eflags: 0x0
// Checksum 0x23cd383d, Offset: 0x2480
// Size: 0x32
function getrankinfoxpamt(rankid) {
    return int(level.ranktable[rankid][3]);
}

// Namespace rank/rank_shared
// Params 1, eflags: 0x0
// Checksum 0x82ffc9a, Offset: 0x24c0
// Size: 0x32
function getrankinfomaxxp(rankid) {
    return int(level.ranktable[rankid][7]);
}

// Namespace rank/rank_shared
// Params 1, eflags: 0x0
// Checksum 0x626a1607, Offset: 0x2500
// Size: 0x32
function getrankinfofull(rankid) {
    return tablelookupistring(level.var_b7e5f751, 0, rankid, 16);
}

// Namespace rank/rank_shared
// Params 2, eflags: 0x0
// Checksum 0x810a3b56, Offset: 0x2540
// Size: 0x42
function getrankinfoicon(rankid, prestigeid) {
    return tablelookup(level.var_55417986, 0, rankid, prestigeid + 1);
}

// Namespace rank/rank_shared
// Params 1, eflags: 0x0
// Checksum 0xcfef4cc5, Offset: 0x2590
// Size: 0x42
function getrankinfolevel(rankid) {
    return int(tablelookup(level.var_b7e5f751, 0, rankid, 13));
}

// Namespace rank/rank_shared
// Params 1, eflags: 0x0
// Checksum 0x618a479e, Offset: 0x25e0
// Size: 0x42
function function_a8f48405(rankid) {
    return int(tablelookup(level.var_b7e5f751, 0, rankid, 17));
}

// Namespace rank/rank_shared
// Params 0, eflags: 0x0
// Checksum 0x8e47ddac, Offset: 0x2630
// Size: 0xd2
function shouldkickbyrank() {
    if (self ishost()) {
        return false;
    }
    if (level.rankcap > 0 && self.pers["rank"] > level.rankcap) {
        return true;
    }
    if (level.rankcap > 0 && level.minprestige == 0 && self.pers["plevel"] > 0) {
        return true;
    }
    if (level.minprestige > self.pers["plevel"]) {
        return true;
    }
    return false;
}

// Namespace rank/rank_shared
// Params 0, eflags: 0x0
// Checksum 0xb7e8b0b1, Offset: 0x2710
// Size: 0x88
function getcodpointsstat() {
    codpoints = self getdstat("playerstatslist", "CODPOINTS", "StatValue");
    var_7fbc8baf = function_35db3641(codpoints);
    if (codpoints > var_7fbc8baf) {
        self setcodpointsstat(var_7fbc8baf);
    }
    return var_7fbc8baf;
}

// Namespace rank/rank_shared
// Params 1, eflags: 0x0
// Checksum 0xee5d27ce, Offset: 0x27a0
// Size: 0x4c
function setcodpointsstat(codpoints) {
    self setdstat("PlayerStatsList", "CODPOINTS", "StatValue", function_35db3641(codpoints));
}

// Namespace rank/rank_shared
// Params 0, eflags: 0x0
// Checksum 0x6d96dec7, Offset: 0x27f8
// Size: 0xa0
function getrankxpstat() {
    rankxp = self getdstat("playerstatslist", "RANKXP", "StatValue");
    rankxpcapped = getrankxpcapped(rankxp);
    if (rankxp > rankxpcapped) {
        self setdstat("playerstatslist", "RANKXP", "StatValue", rankxpcapped);
    }
    return rankxpcapped;
}

// Namespace rank/rank_shared
// Params 0, eflags: 0x0
// Checksum 0xb38049d3, Offset: 0x28a0
// Size: 0x62
function getarenapointsstat() {
    arenaslot = arenagetslot();
    arenapoints = self getdstat("arenaStats", arenaslot, "points");
    return arenapoints + 1;
}

// Namespace rank/rank_shared
// Params 0, eflags: 0x0
// Checksum 0x100b9c6d, Offset: 0x2910
// Size: 0x6a4
function on_player_connect() {
    self.pers["rankxp"] = self getrankxpstat();
    self.pers["codpoints"] = self getcodpointsstat();
    self.pers["currencyspent"] = self getdstat("playerstatslist", "currencyspent", "StatValue");
    rankid = self getrankforxp(self getrankxp());
    self.pers["rank"] = rankid;
    self.pers["plevel"] = self getdstat("playerstatslist", "PLEVEL", "StatValue");
    if (self shouldkickbyrank()) {
        kick(self getentitynumber());
        return;
    }
    if (!isdefined(self.pers["participation"])) {
        self.pers["participation"] = 0;
    }
    self.rankupdatetotal = 0;
    self.cur_ranknum = rankid;
    assert(isdefined(self.cur_ranknum), "<dev string:x29>" + rankid + "<dev string:x30>" + level.var_b7e5f751);
    prestige = self getdstat("playerstatslist", "plevel", "StatValue");
    self setrank(rankid, prestige);
    self.pers["prestige"] = prestige;
    if (sessionmodeiszombiesgame() && (sessionmodeismultiplayergame() && gamemodeisusingstats() || sessionmodeisonlinegame())) {
        paragonrank = self getdstat("playerstatslist", "paragon_rank", "StatValue");
        self setparagonrank(paragonrank);
        self.pers["paragonrank"] = paragonrank;
        paragoniconid = self getdstat("playerstatslist", "paragon_icon_id", "StatValue");
        self setparagoniconid(paragoniconid);
        self.pers["paragoniconid"] = paragoniconid;
    }
    if (!isdefined(self.pers["summary"])) {
        self.pers["summary"] = [];
        self.pers["summary"]["xp"] = 0;
        self.pers["summary"]["score"] = 0;
        self.pers["summary"]["challenge"] = 0;
        self.pers["summary"]["match"] = 0;
        self.pers["summary"]["misc"] = 0;
        self.pers["summary"]["codpoints"] = 0;
    }
    if (gamemodeismode(6) && !self isbot()) {
        arenapoints = self getarenapointsstat();
        arenapoints = int(min(arenapoints, 100));
        self.pers["arenapoints"] = arenapoints;
        self setarenapoints(arenapoints);
    }
    if (level.rankedmatch) {
        self setdstat("playerstatslist", "rank", "StatValue", rankid);
        self setdstat("playerstatslist", "minxp", "StatValue", getrankinfominxp(rankid));
        self setdstat("playerstatslist", "maxxp", "StatValue", getrankinfomaxxp(rankid));
        self setdstat("playerstatslist", "lastxp", "StatValue", getrankxpcapped(self.pers["rankxp"]));
    }
    self.explosivekills[0] = 0;
    callback::on_spawned(&on_player_spawned);
    callback::on_joined_team(&on_joined_team);
    callback::on_joined_spectate(&on_joined_spectators);
}

// Namespace rank/rank_shared
// Params 0, eflags: 0x0
// Checksum 0xca774b11, Offset: 0x2fc0
// Size: 0x24
function on_joined_team() {
    self endon(#"disconnect");
    self thread function_f6937c36();
}

// Namespace rank/rank_shared
// Params 0, eflags: 0x0
// Checksum 0xc1c49271, Offset: 0x2ff0
// Size: 0x24
function on_joined_spectators() {
    self endon(#"disconnect");
    self thread function_f6937c36();
}

// Namespace rank/rank_shared
// Params 0, eflags: 0x0
// Checksum 0xe7842a77, Offset: 0x3020
// Size: 0x1a4
function on_player_spawned() {
    self endon(#"disconnect");
    if (!isdefined(self.var_c81ebd72)) {
        self.var_c81ebd72 = newscorehudelem(self);
        self.var_c81ebd72.horzalign = "center";
        self.var_c81ebd72.vertalign = "middle";
        self.var_c81ebd72.alignx = "center";
        self.var_c81ebd72.aligny = "middle";
        self.var_c81ebd72.x = 0;
        if (self issplitscreen()) {
            self.var_c81ebd72.y = -15;
        } else {
            self.var_c81ebd72.y = -60;
        }
        self.var_c81ebd72.font = "default";
        self.var_c81ebd72.fontscale = 2;
        self.var_c81ebd72.archived = 0;
        self.var_c81ebd72.color = (1, 1, 0.5);
        self.var_c81ebd72.alpha = 0;
        self.var_c81ebd72.sort = 50;
        self.var_c81ebd72 hud::function_1ad5c13d();
    }
}

// Namespace rank/rank_shared
// Params 1, eflags: 0x0
// Checksum 0x54a94a74, Offset: 0x31d0
// Size: 0x114
function function_cb1e9fe6(amount) {
    if (!util::isrankenabled()) {
        return;
    }
    if (!level.rankedmatch) {
        return;
    }
    var_a7f48cf4 = function_35db3641(self.pers["codpoints"] + amount);
    if (var_a7f48cf4 > self.pers["codpoints"]) {
        self.pers["summary"]["codpoints"] = self.pers["summary"]["codpoints"] + var_a7f48cf4 - self.pers["codpoints"];
    }
    self.pers["codpoints"] = var_a7f48cf4;
    setcodpointsstat(int(var_a7f48cf4));
}

// Namespace rank/rank_shared
// Params 0, eflags: 0x0
// Checksum 0x9396ce30, Offset: 0x32f0
// Size: 0x96
function atleastoneplayeroneachteam() {
    foreach (team in level.teams) {
        if (!level.playercount[team]) {
            return false;
        }
    }
    return true;
}

// Namespace rank/rank_shared
// Params 3, eflags: 0x0
// Checksum 0xa43fe06c, Offset: 0x3390
// Size: 0x6bc
function giverankxp(type, value, var_1d04f5a7) {
    self endon(#"disconnect");
    if (sessionmodeiszombiesgame()) {
        return;
    }
    if (level.teambased && !atleastoneplayeroneachteam() && !isdefined(var_1d04f5a7)) {
        return;
    } else if (!level.teambased && util::totalplayercount() < 2 && !isdefined(var_1d04f5a7)) {
        return;
    }
    if (!util::isrankenabled()) {
        return;
    }
    pixbeginevent("giveRankXP");
    if (!isdefined(value)) {
        value = getscoreinfovalue(type);
    }
    if (level.rankedmatch) {
        bbprint("mpplayerxp", "gametime %d, player %s, type %s, delta %d", gettime(), self.name, type, value);
    }
    switch (type) {
    case #"assault":
    case #"hash_2f1c1f8c":
    case #"assist":
    case #"assist_25":
    case #"assist_50":
    case #"assist_75":
    case #"capture":
    case #"defend":
    case #"defuse":
    case #"destroyer":
    case #"hash_b0ab71fc":
    case #"dogkill":
    case #"headshot":
    case #"hash_9d40f7c3":
    case #"hash_185beb25":
    case #"hash_129e6e25":
    case #"hash_57633dc2":
    case #"hash_ec6b0656":
    case #"kill":
    case #"medal":
    case #"pickup":
    case #"plant":
    case #"hash_2c671d1a":
    case #"return":
    case #"revive":
    case #"hash_73ae0f6c":
    case #"hash_1eccce05":
        value = int(value * level.xpscale);
        break;
    default:
        if (level.xpscale == 0) {
            value = 0;
        }
        break;
    }
    var_9e387ebd = self incrankxp(value);
    if (level.rankedmatch) {
        self updaterank();
    }
    if (value != 0) {
        self syncxpstat();
    }
    if (isdefined(self.var_84bed14d) && self.var_84bed14d && !level.hardcoremode) {
        if (type == "teamkill") {
            self thread function_9c4690f5(0 - getscoreinfovalue("kill"));
        } else {
            self thread function_9c4690f5(value);
        }
    }
    switch (type) {
    case #"assault":
    case #"assist":
    case #"assist_25":
    case #"assist_50":
    case #"assist_75":
    case #"capture":
    case #"defend":
    case #"headshot":
    case #"hash_9d40f7c3":
    case #"hash_185beb25":
    case #"hash_129e6e25":
    case #"hash_57633dc2":
    case #"kill":
    case #"medal":
    case #"pickup":
    case #"return":
    case #"revive":
    case #"suicide":
    case #"teamkill":
        self.pers["summary"]["score"] = self.pers["summary"]["score"] + value;
        function_cb1e9fe6(round_this_number(value * level.var_9364c56a));
        break;
    case #"loss":
    case #"tie":
    case #"win":
        self.pers["summary"]["match"] = self.pers["summary"]["match"] + value;
        function_cb1e9fe6(round_this_number(value * level.var_c1745e43));
        break;
    case #"challenge":
        self.pers["summary"]["challenge"] = self.pers["summary"]["challenge"] + value;
        function_cb1e9fe6(round_this_number(value * level.var_4e39954b));
        break;
    default:
        self.pers["summary"]["misc"] = self.pers["summary"]["misc"] + value;
        self.pers["summary"]["match"] = self.pers["summary"]["match"] + value;
        function_cb1e9fe6(round_this_number(value * level.var_c1745e43));
        break;
    }
    self.pers["summary"]["xp"] = self.pers["summary"]["xp"] + var_9e387ebd;
    pixendevent();
}

// Namespace rank/rank_shared
// Params 1, eflags: 0x0
// Checksum 0x384a2f63, Offset: 0x3a58
// Size: 0x34
function round_this_number(value) {
    value = int(value + 0.5);
    return value;
}

// Namespace rank/rank_shared
// Params 0, eflags: 0x0
// Checksum 0xd7c99a69, Offset: 0x3a98
// Size: 0x318
function updaterank() {
    newrankid = self getrank();
    if (newrankid == self.pers["rank"]) {
        return false;
    }
    oldrank = self.pers["rank"];
    rankid = self.pers["rank"];
    self.pers["rank"] = newrankid;
    while (rankid <= newrankid) {
        self setdstat("playerstatslist", "rank", "StatValue", rankid);
        self setdstat("playerstatslist", "minxp", "StatValue", int(level.ranktable[rankid][2]));
        self setdstat("playerstatslist", "maxxp", "StatValue", int(level.ranktable[rankid][7]));
        self.setpromotion = 1;
        if (level.rankedmatch && level.gameended && !self issplitscreen()) {
            self setdstat("AfterActionReportStats", "lobbyPopup", "promotion");
        }
        if (rankid != oldrank) {
            var_43697a64 = function_a8f48405(rankid);
            function_cb1e9fe6(var_43697a64);
            if (!isdefined(self.pers["rankcp"])) {
                self.pers["rankcp"] = 0;
            }
            self.pers["rankcp"] = self.pers["rankcp"] + var_43697a64;
        }
        rankid++;
    }
    /#
        print("<dev string:x50>" + oldrank + "<dev string:x5f>" + newrankid + "<dev string:x64>" + self getdstat("<dev string:x72>", "<dev string:x82>", "<dev string:x94>"));
    #/
    self setrank(newrankid);
    return true;
}

// Namespace rank/player_rankup
// Params 1, eflags: 0x40
// Checksum 0x2ad22931, Offset: 0x3db8
// Size: 0x1e8
function event_handler[player_rankup] codecallback_rankup(eventstruct) {
    if (sessionmodeiscampaigngame()) {
        var_5f586507 = level.ranktable[eventstruct.rank][18];
        if (isdefined(var_5f586507) && var_5f586507 != "") {
            self giveunlocktoken(int(var_5f586507));
        }
        uploadstats(self);
        return;
    }
    if (sessionmodeismultiplayergame()) {
        if (eventstruct.rank > 53) {
            self giveachievement("MP_REACH_ARENA");
        }
        if (eventstruct.rank > 8) {
            self giveachievement("MP_REACH_SERGEANT");
        }
    }
    self luinotifyevent(%rank_up, 3, eventstruct.rank, eventstruct.prestige, eventstruct.unlock_tokens_added);
    self luinotifyeventtospectators(%rank_up, 3, eventstruct.rank, eventstruct.prestige, eventstruct.unlock_tokens_added);
    if (isdefined(level.playpromotionreaction)) {
        self thread [[ level.playpromotionreaction ]]();
    }
}

// Namespace rank/rank_shared
// Params 1, eflags: 0x0
// Checksum 0x76864ceb, Offset: 0x3fa8
// Size: 0x118
function getitemindex(refstring) {
    if (sessionmodeismultiplayergame()) {
        itemindex = getitemindexfromref(refstring);
        assert(itemindex > 0, "<dev string:x9e>" + refstring + "<dev string:xb9>" + itemindex);
    } else {
        var_a804a5cf = util::function_bc37a245();
        itemindex = int(tablelookup(var_a804a5cf, 4, refstring, 0));
        assert(itemindex > 0, "<dev string:xce>" + refstring + "<dev string:xb9>" + itemindex);
    }
    return itemindex;
}

// Namespace rank/rank_shared
// Params 0, eflags: 0x0
// Checksum 0x7bc78459, Offset: 0x40c8
// Size: 0x14
function endgameupdate() {
    player = self;
}

// Namespace rank/rank_shared
// Params 1, eflags: 0x0
// Checksum 0x76001dba, Offset: 0x40e8
// Size: 0x1e4
function function_9c4690f5(amount) {
    self endon(#"disconnect");
    self endon(#"joined_team");
    self endon(#"joined_spectators");
    if (isdefined(level.usingmomentum) && level.usingmomentum) {
        return;
    }
    if (amount == 0) {
        return;
    }
    self notify(#"hash_2b145a7d");
    self endon(#"hash_2b145a7d");
    self.rankupdatetotal += amount;
    waitframe(1);
    if (isdefined(self.var_c81ebd72)) {
        if (self.rankupdatetotal < 0) {
            self.var_c81ebd72.label = %;
            self.var_c81ebd72.color = (0.73, 0.19, 0.19);
        } else {
            self.var_c81ebd72.label = %MP_PLUS;
            self.var_c81ebd72.color = (1, 1, 0.5);
        }
        self.var_c81ebd72 setvalue(self.rankupdatetotal);
        self.var_c81ebd72.alpha = 0.85;
        self.var_c81ebd72 thread hud::function_5e2578bc(self);
        wait 1;
        self.var_c81ebd72 fadeovertime(0.75);
        self.var_c81ebd72.alpha = 0;
        self.rankupdatetotal = 0;
    }
}

// Namespace rank/rank_shared
// Params 3, eflags: 0x0
// Checksum 0x1bc6aed3, Offset: 0x42d8
// Size: 0x324
function function_73d88f63(amount, reason, var_1b34c188) {
    self endon(#"disconnect");
    self endon(#"joined_team");
    self endon(#"joined_spectators");
    if (amount == 0) {
        return;
    }
    self notify(#"hash_2b145a7d");
    self endon(#"hash_2b145a7d");
    self.rankupdatetotal += amount;
    if (isdefined(self.var_c81ebd72)) {
        if (self.rankupdatetotal < 0) {
            self.var_c81ebd72.label = %;
            self.var_c81ebd72.color = (0.73, 0.19, 0.19);
        } else {
            self.var_c81ebd72.label = %MP_PLUS;
            self.var_c81ebd72.color = (1, 1, 0.5);
        }
        self.var_c81ebd72 setvalue(self.rankupdatetotal);
        self.var_c81ebd72.alpha = 0.85;
        self.var_c81ebd72 thread hud::function_5e2578bc(self);
        if (isdefined(self.var_59367135)) {
            if (isdefined(reason)) {
                if (isdefined(var_1b34c188)) {
                    self.var_59367135.label = reason;
                    self.var_59367135 setvalue(var_1b34c188);
                } else {
                    self.var_59367135.label = reason;
                    self.var_59367135 setvalue(amount);
                }
                self.var_59367135.alpha = 0.85;
                self.var_59367135 thread hud::function_5e2578bc(self);
            } else {
                self.var_59367135 fadeovertime(0.01);
                self.var_59367135.alpha = 0;
            }
        }
        wait 1;
        self.var_c81ebd72 fadeovertime(0.75);
        self.var_c81ebd72.alpha = 0;
        if (isdefined(self.var_59367135) && isdefined(reason)) {
            self.var_59367135 fadeovertime(0.75);
            self.var_59367135.alpha = 0;
        }
        wait 0.75;
        self.rankupdatetotal = 0;
    }
}

// Namespace rank/rank_shared
// Params 0, eflags: 0x0
// Checksum 0x797e7e60, Offset: 0x4608
// Size: 0x4c
function function_f6937c36() {
    if (isdefined(self.var_c81ebd72)) {
        self.var_c81ebd72.alpha = 0;
    }
    if (isdefined(self.var_59367135)) {
        self.var_59367135.alpha = 0;
    }
}

// Namespace rank/rank_shared
// Params 0, eflags: 0x0
// Checksum 0x51614e2e, Offset: 0x4660
// Size: 0xb4
function getrank() {
    rankxp = getrankxpcapped(self.pers["rankxp"]);
    rankid = self.pers["rank"];
    if (rankxp < getrankinfominxp(rankid) + getrankinfoxpamt(rankid)) {
        return rankid;
    }
    return self getrankforxp(rankxp);
}

// Namespace rank/rank_shared
// Params 1, eflags: 0x0
// Checksum 0xa4c347aa, Offset: 0x4720
// Size: 0x10e
function getrankforxp(xpval) {
    rankid = 0;
    rankname = level.ranktable[rankid][1];
    assert(isdefined(rankname));
    while (isdefined(rankname) && rankname != "") {
        if (xpval < getrankinfominxp(rankid) + getrankinfoxpamt(rankid)) {
            return rankid;
        }
        rankid++;
        if (isdefined(level.ranktable[rankid])) {
            rankname = level.ranktable[rankid][1];
            continue;
        }
        rankname = undefined;
    }
    rankid--;
    return rankid;
}

// Namespace rank/rank_shared
// Params 0, eflags: 0x0
// Checksum 0xe89651da, Offset: 0x4838
// Size: 0x48
function getspm() {
    ranklevel = self getrank() + 1;
    return (3 + ranklevel * 0.5) * 10;
}

// Namespace rank/rank_shared
// Params 0, eflags: 0x0
// Checksum 0x98a27022, Offset: 0x4888
// Size: 0x2a
function getrankxp() {
    return getrankxpcapped(self.pers["rankxp"]);
}

// Namespace rank/rank_shared
// Params 1, eflags: 0x0
// Checksum 0xc2a62007, Offset: 0x48c0
// Size: 0x142
function incrankxp(amount) {
    if (!level.rankedmatch) {
        return 0;
    }
    xp = self getrankxp();
    newxp = getrankxpcapped(xp + amount);
    if (self.pers["rank"] == level.maxrank && newxp >= getrankinfomaxxp(level.maxrank)) {
        newxp = getrankinfomaxxp(level.maxrank);
    }
    var_9e387ebd = getrankxpcapped(newxp) - self.pers["rankxp"];
    if (var_9e387ebd < 0) {
        var_9e387ebd = 0;
    }
    self.pers["rankxp"] = getrankxpcapped(newxp);
    return var_9e387ebd;
}

// Namespace rank/rank_shared
// Params 0, eflags: 0x0
// Checksum 0x429d3afc, Offset: 0x4a10
// Size: 0xdc
function syncxpstat() {
    xp = getrankxpcapped(self getrankxp());
    cp = function_35db3641(int(self.pers["codpoints"]));
    self setdstat("playerstatslist", "rankxp", "StatValue", xp);
    self setdstat("playerstatslist", "codpoints", "StatValue", cp);
}

