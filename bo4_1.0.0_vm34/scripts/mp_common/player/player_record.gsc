#using scripts\core_common\bb_shared;
#using scripts\core_common\persistence_shared;
#using scripts\core_common\player\player_loadout;
#using scripts\core_common\player\player_role;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\rank_shared;
#using scripts\core_common\util_shared;
#using scripts\mp_common\contracts;
#using scripts\mp_common\gametypes\globallogic;
#using scripts\mp_common\gametypes\globallogic_score;

#namespace player_record;

// Namespace player_record/player_record
// Params 1, eflags: 0x4
// Checksum 0x55588e21, Offset: 0x2d8
// Size: 0x92
function private function_d49af988(inputarray) {
    targetstring = "";
    if (!isdefined(inputarray)) {
        return targetstring;
    }
    for (i = 0; i < inputarray.size; i++) {
        targetstring += inputarray[i];
        if (i != inputarray.size - 1) {
            targetstring += ",";
        }
    }
    return targetstring;
}

// Namespace player_record/player_record
// Params 1, eflags: 0x0
// Checksum 0x46ee0467, Offset: 0x378
// Size: 0x1474
function function_9c92813d(result) {
    player = self;
    lpselfnum = player getentitynumber();
    lpxuid = player getxuid(1);
    var_42821b87 = sessionmodeismultiplayergame() && sessionmodeisonlinegame();
    bb::function_a8a8fbfc(player.name, lpselfnum, lpxuid);
    weeklyacontractid = 0;
    weeklyacontracttarget = 0;
    weeklyacontractcurrent = 0;
    weeklyacontractcompleted = 0;
    weeklybcontractid = 0;
    weeklybcontracttarget = 0;
    weeklybcontractcurrent = 0;
    weeklybcontractcompleted = 0;
    dailycontractid = 0;
    dailycontracttarget = 0;
    dailycontractcurrent = 0;
    dailycontractcompleted = 0;
    specialcontractid = 0;
    specialcontracttarget = 0;
    specialcontractcurent = 0;
    specialcontractcompleted = 0;
    if (isbot(player) || !var_42821b87) {
        currxp = 0;
        prevxp = 0;
    } else {
        currxp = player rank::getrankxpstat();
        prevxp = player.pers[#"rankxp"];
        if (globallogic_score::canupdateweaponcontractstats()) {
            specialcontractid = 1;
            specialcontracttarget = getdvarint(#"weapon_contract_target_value", 100);
            specialcontractcurent = player stats::get_stat(#"weaponcontractdata", #"currentvalue");
            if ((isdefined(player stats::get_stat(#"weaponcontractdata", #"completetimestamp")) ? player stats::get_stat(#"weaponcontractdata", #"completetimestamp") : 0) != 0) {
                specialcontractcompleted = 1;
            }
        }
        if (player contracts::can_process_contracts()) {
            contractid = player contracts::get_contract_stat(0, "index");
            if (player contracts::is_contract_active(contractid)) {
                weeklyacontractid = contractid;
                weeklyacontracttarget = player.pers[#"contracts"][weeklyacontractid].target_value;
                weeklyacontractcurrent = player contracts::get_contract_stat(0, "progress");
                weeklyacontractcompleted = player contracts::get_contract_stat(0, "award_given");
            }
            contractid = player contracts::get_contract_stat(1, "index");
            if (player contracts::is_contract_active(contractid)) {
                weeklybcontractid = contractid;
                weeklybcontracttarget = player.pers[#"contracts"][weeklybcontractid].target_value;
                weeklybcontractcurrent = player contracts::get_contract_stat(1, "progress");
                weeklybcontractcompleted = player contracts::get_contract_stat(1, "award_given");
            }
            contractid = player contracts::get_contract_stat(2, "index");
            if (player contracts::is_contract_active(contractid)) {
                dailycontractid = contractid;
                dailycontracttarget = player.pers[#"contracts"][dailycontractid].target_value;
                dailycontractcurrent = player contracts::get_contract_stat(2, "progress");
                dailycontractcompleted = player contracts::get_contract_stat(2, "award_given");
            }
        }
    }
    if (var_42821b87 && !isdefined(prevxp)) {
        return;
    }
    resultstr = result;
    if (isdefined(player.team) && result == player.team) {
        resultstr = #"win";
    } else if (result == #"allies" || result == #"axis") {
        resultstr = #"lose";
    }
    xpearned = currxp - prevxp;
    perkstr = function_d49af988(player getperks());
    primaryweaponname = #"";
    primaryweaponattachstr = "";
    secondaryweaponname = #"";
    secondaryweaponattachstr = "";
    grenadeprimaryname = #"";
    grenadesecondaryname = #"";
    primary_weapon = player loadout::function_3d8b02a0("primary");
    if (isdefined(primary_weapon)) {
        primaryweaponname = primary_weapon.name;
        primaryweaponattachstr = function_d49af988(getarraykeys(primary_weapon.attachments));
    }
    secondary_weapon = player loadout::function_3d8b02a0("secondary");
    if (isdefined(secondary_weapon)) {
        secondaryweaponname = secondary_weapon.name;
        secondaryweaponattachstr = function_d49af988(getarraykeys(secondary_weapon.attachments));
    }
    loadout = player loadout::get_loadout_slot("primarygrenade");
    if (isdefined(loadout)) {
        grenadeprimaryname = loadout.weapon.name;
    }
    loadout = player loadout::get_loadout_slot("specialgrenade");
    if (isdefined(loadout)) {
        grenadesecondaryname = loadout.weapon.name;
    }
    killstreakstr = function_d49af988(player.killstreak);
    gamelength = float(game.timepassed) / 1000;
    timeplayed = player globallogic::gettotaltimeplayed(gamelength);
    totalkills = player stats::get_stat_global(#"kills");
    totalhits = player stats::get_stat_global(#"hits");
    totaldeaths = player stats::get_stat_global(#"deaths");
    totalwins = player stats::get_stat_global(#"wins");
    totalxp = player stats::get_stat_global(#"rankxp");
    killcount = 0;
    hitcount = 0;
    if (level.mpcustommatch) {
        killcount = player.kills;
        hitcount = player.shotshit;
    } else {
        if (isdefined(player.startkills)) {
            killcount = totalkills - player.startkills;
        }
        if (isdefined(player.starthits)) {
            hitcount = totalhits - player.starthits;
        }
    }
    bestscore = "0";
    if (isdefined(player.pers[#"lasthighestscore"]) && player.score > player.pers[#"lasthighestscore"]) {
        bestscore = "1";
    }
    bestkills = "0";
    if (isdefined(player.pers[#"lasthighestkills"]) && killcount > player.pers[#"lasthighestkills"]) {
        bestkills = "1";
    }
    totalmatchshots = 0;
    if (isdefined(player.totalmatchshots)) {
        totalmatchshots = player.totalmatchshots;
    }
    deaths = player.deaths;
    if (deaths == 0) {
        deaths = 1;
    }
    kdratio = player.kills * 1000 / deaths;
    bestkdratio = "0";
    if (isdefined(player.pers[#"lasthighestkdratio"]) && kdratio > player.pers[#"lasthighestkdratio"]) {
        bestkdratio = "1";
    }
    showcaseweapon = player getplayershowcaseweapon();
    startingteam = 0;
    if (isdefined(player.startingteam)) {
        startingteam = player.startingteam;
    }
    endingteam = 0;
    if (isdefined(player.team)) {
        endingteam = player.team;
    }
    var_6aca5c39 = spawnstruct();
    var_6aca5c39.session_mode = currentsessionmode();
    var_6aca5c39.game_type = hash(level.gametype);
    var_6aca5c39.private_match = sessionmodeisprivate();
    var_6aca5c39.esports_flag = level.leaguematch;
    var_6aca5c39.ranked_play_flag = level.arenamatch;
    var_6aca5c39.game_map = util::get_map_name();
    var_6aca5c39.player_xuid = player getxuid(1);
    var_6aca5c39.player_ip = player getipaddress();
    var_6aca5c39.season_pass_owned = player hasseasonpass(0);
    var_6aca5c39.dlc_owned = player getdlcavailable();
    var_6aca5c39.starting_team = startingteam;
    var_6aca5c39.ending_team = endingteam;
    var_efb2fb58 = spawnstruct();
    var_efb2fb58.match_kills = killcount;
    var_efb2fb58.match_deaths = player.deaths;
    var_efb2fb58.match_xp = xpearned;
    var_efb2fb58.match_score = player.score;
    var_efb2fb58.match_streak = player.pers[#"best_kill_streak"];
    var_efb2fb58.match_captures = player.pers[#"captures"];
    var_efb2fb58.match_defends = player.pers[#"defends"];
    var_efb2fb58.match_headshots = player.pers[#"headshots"];
    var_efb2fb58.match_longshots = player.pers[#"longshots"];
    var_efb2fb58.match_objtime = player.pers[#"objtime"];
    var_efb2fb58.match_plants = player.pers[#"plants"];
    var_efb2fb58.match_defuses = player.pers[#"defuses"];
    var_efb2fb58.match_throws = player.pers[#"throws"];
    var_efb2fb58.match_carries = player.pers[#"carries"];
    var_efb2fb58.match_returns = player.pers[#"returns"];
    var_efb2fb58.match_result = resultstr;
    var_efb2fb58.match_duration = int(timeplayed);
    var_efb2fb58.match_shots = totalmatchshots;
    var_efb2fb58.match_hits = hitcount;
    var_efb2fb58.prestige_max = player.pers[#"plevel"];
    var_efb2fb58.level_max = player.pers[#"rank"];
    var_efb2fb58.specialist_kills = player.heavyweaponkillcount;
    var_8c7365c3 = spawnstruct();
    var_8c7365c3.player_gender = player getplayergendertype(currentsessionmode());
    var_8c7365c3.specialist_used = function_b9650e7f(player player_role::get(), currentsessionmode());
    var_8c7365c3.loadout_perks = perkstr;
    var_8c7365c3.loadout_lethal = grenadeprimaryname;
    var_8c7365c3.loadout_tactical = grenadesecondaryname;
    var_8c7365c3.loadout_scorestreaks = killstreakstr;
    var_8c7365c3.loadout_primary_weapon = primaryweaponname;
    var_8c7365c3.loadout_secondary_weapon = secondaryweaponname;
    var_8c7365c3.loadout_primary_attachments = primaryweaponattachstr;
    var_8c7365c3.loadout_secondary_attachments = secondaryweaponattachstr;
    var_8abe6c0c = spawnstruct();
    var_8abe6c0c.best_score = bestscore;
    var_8abe6c0c.best_kills = bestkills;
    var_8abe6c0c.best_kd = bestkdratio;
    var_8abe6c0c.total_kills = totalkills;
    var_8abe6c0c.total_deaths = totaldeaths;
    var_8abe6c0c.total_wins = totalwins;
    var_8abe6c0c.total_xp = totalxp;
    var_878dd0a2 = spawnstruct();
    var_878dd0a2.daily_contract_id = dailycontractid;
    var_878dd0a2.daily_contract_target = dailycontracttarget;
    var_878dd0a2.daily_contract_current = dailycontractcurrent;
    var_878dd0a2.daily_contract_completed = dailycontractcompleted;
    var_878dd0a2.weeklya_contract_id = weeklyacontractid;
    var_878dd0a2.weeklya_contract_target = weeklyacontracttarget;
    var_878dd0a2.weeklya_contract_current = weeklyacontractcurrent;
    var_878dd0a2.weeklya_contract_completed = weeklyacontractcompleted;
    var_878dd0a2.weeklyb_contract_id = weeklybcontractid;
    var_878dd0a2.weeklyb_contract_target = weeklybcontracttarget;
    var_878dd0a2.weeklyb_contract_current = weeklybcontractcurrent;
    var_878dd0a2.weeklyb_contract_completed = weeklybcontractcompleted;
    var_878dd0a2.special_contract_id = specialcontractid;
    var_878dd0a2.special_contract_target = specialcontracttarget;
    var_878dd0a2.special_contract_curent = specialcontractcurent;
    var_878dd0a2.special_contract_completed = specialcontractcompleted;
    var_2e7340e = spawnstruct();
    var_2e7340e.var_2fd87d4 = player function_dd025223();
    var_2e7340e.specialist_head = player function_48b6673e();
    var_2e7340e.specialist_legs = player function_2d8b2021();
    var_2e7340e.specialist_torso = player function_fb7ff145();
    var_2e7340e.specialist_showcase = showcaseweapon.weapon.name;
    function_b1f6086c(#"hash_4c5946fa1191bc64", #"hash_71960e91f80c3365", var_6aca5c39, #"hash_4682ee0eb5071d2", var_efb2fb58, #"hash_209c80d657442a83", var_8c7365c3, #"hash_43cb38816354c3aa", var_8abe6c0c, #"hash_11fcb8f188ed5050", var_878dd0a2, #"hash_78a6c018d9f82184", var_2e7340e);
}

// Namespace player_record/player_record
// Params 1, eflags: 0x0
// Checksum 0x685c33a5, Offset: 0x17f8
// Size: 0x204
function record_special_move_data_for_life(killer) {
    if (!isdefined(self.lastswimmingstarttime) || !isdefined(self.lastwallrunstarttime) || !isdefined(self.lastslidestarttime) || !isdefined(self.lastdoublejumpstarttime) || !isdefined(self.timespentswimminginlife) || !isdefined(self.timespentwallrunninginlife) || !isdefined(self.numberofdoublejumpsinlife) || !isdefined(self.numberofslidesinlife)) {
        println("<dev string:x30>");
        return;
    }
    if (isdefined(killer)) {
        if (!isdefined(killer.lastswimmingstarttime) || !isdefined(killer.lastwallrunstarttime) || !isdefined(killer.lastslidestarttime) || !isdefined(killer.lastdoublejumpstarttime)) {
            println("<dev string:x70>");
            return;
        }
        matchrecordlogspecialmovedataforlife(self, self.lastswimmingstarttime, self.lastwallrunstarttime, self.lastslidestarttime, self.lastdoublejumpstarttime, self.timespentswimminginlife, self.timespentwallrunninginlife, self.numberofdoublejumpsinlife, self.numberofslidesinlife, killer, killer.lastswimmingstarttime, killer.lastwallrunstarttime, killer.lastslidestarttime, killer.lastdoublejumpstarttime);
        return;
    }
    matchrecordlogspecialmovedataforlife(self, self.lastswimmingstarttime, self.lastwallrunstarttime, self.lastslidestarttime, self.lastdoublejumpstarttime, self.timespentswimminginlife, self.timespentwallrunninginlife, self.numberofdoublejumpsinlife, self.numberofslidesinlife);
}

// Namespace player_record/player_record
// Params 0, eflags: 0x0
// Checksum 0xf182dc79, Offset: 0x1a08
// Size: 0x38c
function record_global_mp_stats_for_player_at_match_start() {
    if (isdefined(level.disablestattracking) && level.disablestattracking == 1) {
        return;
    }
    startkills = self stats::get_stat_global(#"kills");
    startdeaths = self stats::get_stat_global(#"deaths");
    startwins = self stats::get_stat_global(#"wins");
    startlosses = self stats::get_stat_global(#"losses");
    starthits = self stats::get_stat_global(#"hits");
    startmisses = self stats::get_stat_global(#"misses");
    starttimeplayedtotal = self stats::get_stat_global(#"time_played_total");
    startscore = self stats::get_stat_global(#"score");
    startprestige = self stats::get_stat_global(#"plevel");
    startunlockpoints = self stats::get_stat(#"unlocks", 0);
    ties = self stats::get_stat_global(#"ties");
    startgamesplayed = startwins + startlosses + ties;
    self.startkills = startkills;
    self.starthits = starthits;
    self.totalmatchshots = 0;
    recordplayerstats(self, "start_kills", startkills);
    recordplayerstats(self, "start_deaths", startdeaths);
    recordplayerstats(self, "start_wins", startwins);
    recordplayerstats(self, "start_losses", startlosses);
    recordplayerstats(self, "start_hits", starthits);
    recordplayerstats(self, "start_misses", startmisses);
    recordplayerstats(self, "start_total_time_played_s", starttimeplayedtotal);
    recordplayerstats(self, "start_score", startscore);
    recordplayerstats(self, "start_prestige", startprestige);
    recordplayerstats(self, "start_unlock_points", startunlockpoints);
    recordplayerstats(self, "start_games_played", startgamesplayed);
}

// Namespace player_record/player_record
// Params 0, eflags: 0x0
// Checksum 0xb0012592, Offset: 0x1da0
// Size: 0x36c
function record_global_mp_stats_for_player_at_match_end() {
    if (isdefined(level.disablestattracking) && level.disablestattracking == 1) {
        return;
    }
    endkills = self stats::get_stat_global(#"kills");
    enddeaths = self stats::get_stat_global(#"deaths");
    endwins = self stats::get_stat_global(#"wins");
    endlosses = self stats::get_stat_global(#"losses");
    endhits = self stats::get_stat_global(#"hits");
    endmisses = self stats::get_stat_global(#"misses");
    endtimeplayedtotal = self stats::get_stat_global(#"time_played_total");
    endscore = self stats::get_stat_global(#"score");
    endprestige = self stats::get_stat_global(#"plevel");
    endunlockpoints = self stats::get_stat(#"unlocks", 0);
    ties = self stats::get_stat_global(#"ties");
    endgamesplayed = endwins + endlosses + ties;
    recordplayerstats(self, "end_kills", endkills);
    recordplayerstats(self, "end_deaths", enddeaths);
    recordplayerstats(self, "end_wins", endwins);
    recordplayerstats(self, "end_losses", endlosses);
    recordplayerstats(self, "end_hits", endhits);
    recordplayerstats(self, "end_misses", endmisses);
    recordplayerstats(self, "end_total_time_played_s", endtimeplayedtotal);
    recordplayerstats(self, "end_score", endscore);
    recordplayerstats(self, "end_prestige", endprestige);
    recordplayerstats(self, "end_unlock_points", endunlockpoints);
    recordplayerstats(self, "end_games_played", endgamesplayed);
}

// Namespace player_record/player_record
// Params 0, eflags: 0x0
// Checksum 0x6401cefa, Offset: 0x2118
// Size: 0x334
function record_misc_player_stats() {
    if (isdefined(level.disablestattracking) && level.disablestattracking == 1) {
        return;
    }
    recordplayerstats(self, "utc_disconnect_time_s", getutc());
    if (isdefined(self.weaponpickupscount)) {
        recordplayerstats(self, "weaponPickupsCount", self.weaponpickupscount);
    }
    if (isdefined(self.killcamsskipped)) {
        recordplayerstats(self, "totalKillcamsSkipped", self.killcamsskipped);
    }
    if (isdefined(self.pers) && isdefined(self.pers[#"totalmatchbonus"])) {
        recordplayerstats(self, "match_xp", self.pers[#"totalmatchbonus"]);
    } else if (isdefined(self.matchbonus)) {
        recordplayerstats(self, "match_xp", self.matchbonus);
    }
    if (isdefined(self.killsdenied)) {
        recordplayerstats(self, "killsDenied", self.killsdenied);
    }
    if (isdefined(self.killsconfirmed)) {
        recordplayerstats(self, "killsConfirmed", self.killsconfirmed);
    }
    if (self.objtime) {
        recordplayerstats(self, "objectiveTime", self.objtime);
    }
    if (self.escorts) {
        recordplayerstats(self, "escortTime", self.escorts);
    }
    if (isdefined(level.rankedmatch) && level.rankedmatch && isdefined(self.pers) && isdefined(self.pers[#"summary"])) {
        recordplayerstats(self, "challenge_xp", self.pers[#"summary"][#"challenge"]);
        recordplayerstats(self, "score_xp", self.pers[#"summary"][#"score"]);
        recordplayerstats(self, "misc_xp", self.pers[#"summary"][#"misc"]);
    }
}

// Namespace player_record/player_record
// Params 0, eflags: 0x0
// Checksum 0xcbdab7ac, Offset: 0x2458
// Size: 0x51a
function function_a7b47dbc() {
    self persistence::function_1eb75035();
    self persistence::set_recent_stat(0, 0, #"valid", 1);
    self persistence::set_recent_stat(0, 0, #"ekia", self.ekia);
    self persistence::set_recent_stat(0, 0, #"deaths", self.deaths);
    self persistence::set_recent_stat(0, 0, #"kills", self.kills);
    self persistence::set_recent_stat(0, 0, #"outcome", self.pers[#"outcome"]);
    self persistence::set_recent_stat(0, 0, #"timeplayed", self.timeplayed[#"total"]);
    self persistence::set_recent_stat(0, 0, #"score", self.pers[#"score"]);
    self persistence::set_recent_stat(0, 0, #"damage", self.pers[#"damagedone"]);
    self persistence::set_recent_stat(0, 0, #"objectiveekia", self.pers[#"objectiveekia"]);
    self persistence::set_recent_stat(0, 0, #"objectivescore", self.pers[#"objectivescore"]);
    self persistence::set_recent_stat(0, 0, #"objectivedefends", self.pers[#"objectivedefends"]);
    self persistence::set_recent_stat(0, 0, #"objectivetime", self.pers[#"objectivetime"]);
    self stats::function_93b148d7(self.pers[#"outcome"], 1);
    self stats::function_93b148d7(#"timeplayed", self.timeplayed[#"total"]);
    self stats::function_93b148d7(#"gamesplayed", 1);
    switch (level.gametype) {
    case #"control":
    case #"sd":
    case #"dom":
    case #"bounty":
        self stats::function_93b148d7(#"stat1", self.pers[#"objectivescore"]);
        self stats::function_93b148d7(#"stat2", self.ekia);
        break;
    case #"koth":
        self stats::function_93b148d7(#"stat1", self.pers[#"objectivetime"]);
        self stats::function_93b148d7(#"stat2", self.ekia);
        break;
    case #"tdm":
        self stats::function_93b148d7(#"stat1", self.ekia);
        self stats::function_93b148d7(#"stat2", self.deaths);
        break;
    default:
        break;
    }
}

