#using scripts\core_common\challenges_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\demo_shared;
#using scripts\core_common\gameobjects_shared;
#using scripts\core_common\hud_message_shared;
#using scripts\core_common\hud_util_shared;
#using scripts\core_common\influencers_shared;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\popups_shared;
#using scripts\core_common\potm_shared;
#using scripts\core_common\rank_shared;
#using scripts\core_common\scoreevents_shared;
#using scripts\core_common\sound_shared;
#using scripts\core_common\spawning_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\mp_common\bb;
#using scripts\mp_common\challenges;
#using scripts\mp_common\gametypes\globallogic;
#using scripts\mp_common\gametypes\globallogic_audio;
#using scripts\mp_common\gametypes\globallogic_defaults;
#using scripts\mp_common\gametypes\globallogic_score;
#using scripts\mp_common\gametypes\globallogic_spawn;
#using scripts\mp_common\gametypes\globallogic_utils;
#using scripts\mp_common\gametypes\hud_message;
#using scripts\mp_common\gametypes\match;
#using scripts\mp_common\gametypes\overtime;
#using scripts\mp_common\gametypes\round;
#using scripts\mp_common\player\player_utils;
#using scripts\mp_common\teams\teams;
#using scripts\mp_common\util;

#namespace ctf;

// Namespace ctf/ctf
// Params 0, eflags: 0x2
// Checksum 0x651127a6, Offset: 0x588
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"ctf", &__init__, undefined, undefined);
}

// Namespace ctf/ctf
// Params 0, eflags: 0x0
// Checksum 0xf7b984a2, Offset: 0x5d0
// Size: 0x34
function __init__() {
    clientfield::register("scriptmover", "ctf_flag_away", 1, 1, "int");
}

// Namespace ctf/gametype_init
// Params 1, eflags: 0x40
// Checksum 0x4fb58544, Offset: 0x610
// Size: 0x30c
function event_handler[gametype_init] main(eventstruct) {
    globallogic::init();
    util::registertimelimit(0, 1440);
    util::registerroundlimit(0, 10);
    util::registerroundwinlimit(0, 10);
    util::registerroundswitch(0, 9);
    util::registernumlives(0, 100);
    util::registerscorelimit(0, 5000);
    level.scoreroundwinbased = getgametypesetting(#"cumulativeroundscores") == 0;
    level.flagcapturecondition = getgametypesetting(#"flagcapturecondition");
    level.doubleovertime = 1;
    globallogic::registerfriendlyfiredelay(level.gametype, 15, 0, 1440);
    level.overrideteamscore = 1;
    level.onstartgametype = &onstartgametype;
    level.onspawnplayer = &onspawnplayer;
    level.onprecachegametype = &onprecachegametype;
    player::function_b0320e78(&onplayerkilled);
    level.onendround = &onendround;
    level.onendgame = &onendgame;
    level.getteamkillpenalty = &ctf_getteamkillpenalty;
    level.getteamkillscore = &ctf_getteamkillscore;
    level.shouldplayovertimeround = &shouldplayovertimeround;
    level.ctfreturnflag = &returnflag;
    level.var_c9d3723c = &function_4fdb87a6;
    globallogic_spawn::addsupportedspawnpointtype("ctf");
    if (!isdefined(game.ctf_teamscore_cache)) {
        game.ctf_teamscore_cache[#"allies"] = 0;
        game.ctf_teamscore_cache[#"axis"] = 0;
    }
    globallogic_audio::set_leader_gametype_dialog("startCtf", "hcStartCtf", "objCapture", "objCapture");
    level thread ctf_icon_hide();
}

// Namespace ctf/ctf
// Params 0, eflags: 0x0
// Checksum 0xa2ec8833, Offset: 0x928
// Size: 0x5a
function onprecachegametype() {
    game.flag_dropped_sound = "mp_war_objective_lost";
    game.flag_recovered_sound = "mp_war_objective_taken";
    game.strings[#"score_limit_reached"] = #"hash_5218d2db23ab36aa";
}

// Namespace ctf/ctf
// Params 0, eflags: 0x0
// Checksum 0x614a6fa6, Offset: 0x990
// Size: 0x1a8
function function_4fdb87a6() {
    spawning::place_spawn_points("mp_ctf_spawn_allies_start");
    spawning::place_spawn_points("mp_ctf_spawn_axis_start");
    spawning::add_spawn_points("sidea", "mp_ctf_spawn_allies");
    spawning::add_spawn_points("sideb", "mp_ctf_spawn_axis");
    spawning::add_fallback_spawnpoints("sidea", "mp_tdm_spawn");
    spawning::add_fallback_spawnpoints("sideb", "mp_tdm_spawn");
    spawning::updateallspawnpoints();
    spawning::update_fallback_spawnpoints();
    level.spawn_axis = spawning::get_spawnpoint_array("mp_ctf_spawn_axis");
    level.spawn_allies = spawning::get_spawnpoint_array("mp_ctf_spawn_allies");
    foreach (team, _ in level.teams) {
        spawning::add_start_spawn_points(team, "mp_ctf_spawn_" + team + "_start");
    }
}

// Namespace ctf/ctf
// Params 0, eflags: 0x0
// Checksum 0x6c41ce26, Offset: 0xb40
// Size: 0x17c
function onstartgametype() {
    globallogic_score::resetteamscores();
    if (overtime::is_overtime_round()) {
        game.ctf_teamscore_cache[#"allies"] = game.ctf_teamscore_cache[#"allies"] + [[ level._getteamscore ]](#"allies");
        game.ctf_teamscore_cache[#"axis"] = game.ctf_teamscore_cache[#"axis"] + [[ level._getteamscore ]](#"axis");
        [[ level._setteamscore ]](#"allies", 0);
        [[ level._setteamscore ]](#"axis", 0);
        util::registerscorelimit(1, 1);
        if (isdefined(game.ctf_overtime_time_to_beat)) {
            util::registertimelimit(game.ctf_overtime_time_to_beat / 60000, game.ctf_overtime_time_to_beat / 60000);
        }
    }
    thread updategametypedvars();
    thread ctf();
}

// Namespace ctf/ctf
// Params 0, eflags: 0x0
// Checksum 0x5f7c0963, Offset: 0xcc8
// Size: 0x1d6
function shouldplayovertimeround() {
    if (overtime::is_overtime_round()) {
        if (game.overtime_round == 1 || !level.gameended) {
            return true;
        }
        return false;
    }
    if (!level.scoreroundwinbased) {
        if (game.stat[#"teamscores"][#"allies"] == game.stat[#"teamscores"][#"axis"] && (util::hitroundlimit() || game.stat[#"teamscores"][#"allies"] == level.scorelimit - 1)) {
            return true;
        }
    } else {
        alliesroundswon = util::getroundswon(#"allies");
        axisroundswon = util::getroundswon(#"axis");
        if (level.roundwinlimit > 0 && axisroundswon == level.roundwinlimit - 1 && alliesroundswon == level.roundwinlimit - 1) {
            return true;
        }
        if (util::hitroundlimit() && alliesroundswon == axisroundswon) {
            return true;
        }
    }
    return false;
}

// Namespace ctf/ctf
// Params 1, eflags: 0x0
// Checksum 0xab4b90e6, Offset: 0xea8
// Size: 0xd0
function minutesandsecondsstring(milliseconds) {
    minutes = floor(float(milliseconds) / 60000);
    milliseconds -= minutes * 60000;
    seconds = floor(float(milliseconds) / 1000);
    if (seconds < 10) {
        return (minutes + ":0" + seconds);
    }
    return minutes + ":" + seconds;
}

// Namespace ctf/ctf
// Params 1, eflags: 0x0
// Checksum 0xc880841b, Offset: 0xf80
// Size: 0xfa
function onendround(var_c3d87d03) {
    winning_team = round::get_winning_team();
    if (round::get_flag("overtime")) {
        if (isdefined(winning_team) && !round::get_flag("tie")) {
            game.overtime_first_winner = winning_team;
            game.overtime_time_to_beat[#"ctf"] = globallogic_utils::gettimepassed();
        }
        return;
    }
    game.overtime_second_winner[#"ctf"] = winning_team;
    game.overtime_best_time[#"ctf"] = globallogic_utils::gettimepassed();
}

// Namespace ctf/ctf
// Params 0, eflags: 0x0
// Checksum 0xf0938461, Offset: 0x1088
// Size: 0xac
function updateteamscorebyflagscaptured() {
    if (level.scoreroundwinbased) {
        return;
    }
    foreach (team, _ in level.teams) {
        [[ level._setteamscore ]](team, [[ level._getteamscore ]](team) + game.ctf_teamscore_cache[team]);
    }
}

// Namespace ctf/ctf
// Params 1, eflags: 0x0
// Checksum 0xa23b2462, Offset: 0x1140
// Size: 0x194
function onendgame(var_c3d87d03) {
    if (level.scoreroundwinbased) {
        globallogic_score::updateteamscorebyroundswon();
    } else {
        updateteamscorebyflagscaptured();
    }
    if (overtime::is_overtime_round()) {
        if (isdefined(game.overtime_first_winner)) {
            if (round::get_flag("tie")) {
                winningteam = game.overtime_first_winner;
            }
            if (game.overtime_first_winner == winningteam) {
                level.endvictoryreasontext = #"hash_7cafa946822ee652";
                level.enddefeatreasontext = #"hash_34d0ee5d4c21542d";
            } else {
                level.endvictoryreasontext = #"hash_7cafa946822ee652";
                level.enddefeatreasontext = #"hash_5235bbca93844647";
            }
        }
        if (level.scoreroundwinbased) {
            if (isdefined(winningteam)) {
                [[ level._setteamscore ]](winningteam, game.stat[#"roundswon"][winningteam] + 1);
            }
        }
        winner = winningteam;
    } else {
        winner = match::function_81e31796();
    }
    match::function_622b7e5e(winner);
}

// Namespace ctf/ctf
// Params 1, eflags: 0x0
// Checksum 0x22a0adc6, Offset: 0x12e0
// Size: 0x54
function onspawnplayer(predictedspawn) {
    self.isflagcarrier = 0;
    self.flagcarried = undefined;
    self clientfield::set("ctf_flag_carrier", 0);
    spawning::onspawnplayer(predictedspawn);
}

// Namespace ctf/ctf
// Params 0, eflags: 0x0
// Checksum 0x21c8852d, Offset: 0x1340
// Size: 0x1b2
function updategametypedvars() {
    level.flagcapturetime = getgametypesetting(#"capturetime");
    level.flagtouchreturntime = getgametypesetting(#"defusetime");
    level.idleflagreturntime = getgametypesetting(#"idleflagresettime");
    level.flagrespawntime = getgametypesetting(#"flagrespawntime");
    level.enemycarriervisible = getgametypesetting(#"enemycarriervisible");
    level.roundlimit = getgametypesetting(#"roundlimit");
    level.cumulativeroundscores = getgametypesetting(#"cumulativeroundscores");
    level.teamkillpenaltymultiplier = getgametypesetting(#"teamkillpenalty");
    level.teamkillscoremultiplier = getgametypesetting(#"teamkillscore");
    if (level.flagtouchreturntime >= 0 && level.flagtouchreturntime != 63) {
        level.touchreturn = 1;
        return;
    }
    level.touchreturn = 0;
}

// Namespace ctf/ctf
// Params 1, eflags: 0x0
// Checksum 0xeb59376d, Offset: 0x1500
// Size: 0x37e
function createflag(trigger) {
    if (isdefined(trigger.target)) {
        visuals[0] = getent(trigger.target, "targetname");
    } else {
        visuals[0] = spawn("script_model", trigger.origin);
        visuals[0].angles = trigger.angles;
    }
    entityteam = util::function_82f4ab63(trigger.script_team);
    visuals[0] setmodel(teams::get_flag_model(entityteam));
    visuals[0] setteam(entityteam);
    flag = gameobjects::create_carry_object(entityteam, trigger, visuals, (0, 0, 100), entityteam + "_flag");
    flag gameobjects::set_team_use_time(#"friendly", level.flagtouchreturntime);
    flag gameobjects::set_team_use_time(#"enemy", level.flagcapturetime);
    flag gameobjects::allow_carry(#"enemy");
    flag gameobjects::set_visible_team(#"any");
    flag gameobjects::set_visible_carrier_model(teams::get_flag_carry_model(entityteam));
    flag gameobjects::set_2d_icon(#"friendly", level.icondefend2d);
    flag gameobjects::set_3d_icon(#"friendly", level.icondefend3d);
    flag gameobjects::set_2d_icon(#"enemy", level.iconcapture2d);
    flag gameobjects::set_3d_icon(#"enemy", level.iconcapture3d);
    if (level.enemycarriervisible == 2) {
        flag.objidpingfriendly = 1;
    }
    flag.allowweapons = 1;
    flag.onpickup = &onpickup;
    flag.onpickupfailed = &onpickup;
    flag.ondrop = &ondrop;
    flag.onreset = &onreset;
    if (level.idleflagreturntime > 0) {
        flag.autoresettime = level.idleflagreturntime;
    } else {
        flag.autoresettime = undefined;
    }
    return flag;
}

// Namespace ctf/ctf
// Params 1, eflags: 0x0
// Checksum 0x528daee9, Offset: 0x1888
// Size: 0x1a0
function createflagzone(trigger) {
    visuals = [];
    entityteam = util::function_82f4ab63(trigger.script_team);
    flagzone = gameobjects::create_use_object(entityteam, trigger, visuals, (0, 0, 0), entityteam + "_base");
    flagzone gameobjects::allow_use(#"friendly");
    flagzone gameobjects::set_use_time(0);
    flagzone gameobjects::set_use_text(#"mp/capturing_flag");
    flagzone gameobjects::set_visible_team(#"friendly");
    enemyteam = util::getotherteam(entityteam);
    flagzone gameobjects::set_key_object(level.teamflags[enemyteam]);
    flagzone.onuse = &oncapture;
    flag = level.teamflags[entityteam];
    flag.flagbase = flagzone;
    flagzone.flag = flag;
    flagzone createflagspawninfluencer(entityteam);
    return flagzone;
}

// Namespace ctf/ctf
// Params 2, eflags: 0x0
// Checksum 0xa1402ab3, Offset: 0x1a30
// Size: 0xc8
function createflaghint(team, origin) {
    radius = 128;
    height = 64;
    trigger = spawn("trigger_radius", origin, 0, radius, height);
    trigger sethintstring(#"hash_479e7adbf3e4f211");
    trigger setcursorhint("HINT_NOICON");
    trigger.original_origin = origin;
    trigger turn_off();
    return trigger;
}

// Namespace ctf/ctf
// Params 0, eflags: 0x0
// Checksum 0xbd89b044, Offset: 0x1b00
// Size: 0x2e6
function ctf() {
    level.flags = [];
    level.teamflags = [];
    level.flagzones = [];
    level.teamflagzones = [];
    flag_triggers = getentarray("ctf_flag_pickup_trig", "targetname");
    if (!isdefined(flag_triggers) || flag_triggers.size != 2) {
        /#
            util::error("<dev string:x30>");
        #/
        return;
    }
    for (index = 0; index < flag_triggers.size; index++) {
        trigger = flag_triggers[index];
        flag = createflag(trigger);
        team = flag gameobjects::get_owner_team();
        level.flags[level.flags.size] = flag;
        level.teamflags[team] = flag;
    }
    flag_zones = getentarray("ctf_flag_zone_trig", "targetname");
    if (!isdefined(flag_zones) || flag_zones.size != 2) {
        /#
            util::error("<dev string:x72>");
        #/
        return;
    }
    for (index = 0; index < flag_zones.size; index++) {
        trigger = flag_zones[index];
        flagzone = createflagzone(trigger);
        team = flagzone gameobjects::get_owner_team();
        level.flagzones[level.flagzones.size] = flagzone;
        level.teamflagzones[team] = flagzone;
        level.flaghints[team] = createflaghint(team, trigger.origin);
        facing_angle = getdvarint(#"scr_ctf_spawnpointfacingangle", 0);
        setspawnpointsbaseweight(util::getotherteamsmask(team), trigger.origin, facing_angle, level.spawnsystem.objective_facing_bonus);
    }
}

// Namespace ctf/ctf
// Params 0, eflags: 0x0
// Checksum 0x5889a5ea, Offset: 0x1df0
// Size: 0x8c
function ctf_icon_hide() {
    level waittill(#"game_ended");
    level.teamflags[#"allies"] gameobjects::set_visible_team(#"none");
    level.teamflags[#"axis"] gameobjects::set_visible_team(#"none");
}

// Namespace ctf/ctf
// Params 0, eflags: 0x0
// Checksum 0x61623b93, Offset: 0x1e88
// Size: 0xa6
function removeinfluencers() {
    if (isdefined(self.spawn_influencer_enemy_carrier)) {
        self influencers::remove_influencer(self.spawn_influencer_enemy_carrier);
        self.spawn_influencer_enemy_carrier = undefined;
    }
    if (isdefined(self.spawn_influencer_friendly_carrier)) {
        self influencers::remove_influencer(self.spawn_influencer_friendly_carrier);
        self.spawn_influencer_friendly_carrier = undefined;
    }
    if (isdefined(self.spawn_influencer_dropped)) {
        self.trigger influencers::remove_influencer(self.spawn_influencer_dropped);
        self.spawn_influencer_dropped = undefined;
    }
}

// Namespace ctf/ctf
// Params 1, eflags: 0x0
// Checksum 0x836e74be, Offset: 0x1f38
// Size: 0x534
function ondrop(player) {
    origin = (0, 0, 0);
    if (isdefined(player)) {
        player clientfield::set("ctf_flag_carrier", 0);
        origin = player.origin;
    }
    team = self gameobjects::get_owner_team();
    otherteam = util::getotherteam(team);
    bb::function_9cca214a("ctf_flagdropped", undefined, team, origin);
    self.visuals[0] clientfield::set("ctf_flag_away", 1);
    if (level.touchreturn) {
        self gameobjects::allow_carry(#"any");
        level.flaghints[otherteam] turn_off();
    }
    if (isdefined(player)) {
        util::printandsoundoneveryone(team, undefined, #"", undefined, "mp_war_objective_lost");
        level thread popups::displayteammessagetoteam(#"hash_3118e621ec8d35b8", player, team, undefined, undefined);
        level thread popups::displayteammessagetoteam(#"hash_6730bd6c7d8d0567", player, otherteam, undefined, undefined);
    } else {
        util::printandsoundoneveryone(team, undefined, #"", undefined, "mp_war_objective_lost");
    }
    globallogic_audio::leader_dialog("ctfFriendlyFlagDropped", team, undefined, "ctf_flag");
    globallogic_audio::leader_dialog("ctfEnemyFlagDropped", otherteam, undefined, "ctf_flag_enemy");
    /#
        if (isdefined(player)) {
            print(team + "<dev string:xb2>");
        } else {
            print(team + "<dev string:xb2>");
        }
    #/
    if (isdefined(player)) {
        player playlocalsound(#"mpl_flag_drop_plr");
    }
    globallogic_audio::play_2d_on_team("mpl_flagdrop_sting_friend", otherteam);
    globallogic_audio::play_2d_on_team("mpl_flagdrop_sting_enemy", team);
    if (level.touchreturn) {
        self gameobjects::set_3d_icon(#"friendly", level.iconreturn3d);
        self gameobjects::set_2d_icon(#"friendly", level.iconreturn2d);
    } else {
        self gameobjects::set_3d_icon(#"friendly", level.icondropped3d);
        self gameobjects::set_2d_icon(#"friendly", level.icondropped2d);
    }
    self gameobjects::set_visible_team(#"any");
    self gameobjects::set_3d_icon(#"enemy", level.iconcapture3d);
    self gameobjects::set_2d_icon(#"enemy", level.iconcapture2d);
    thread sound::play_on_players(game.flag_dropped_sound, game.attackers);
    self removeinfluencers();
    if (isdefined(player)) {
        player removeinfluencers();
    }
    ss = level.spawnsystem;
    player_team_mask = util::getteammask(otherteam);
    enemy_team_mask = util::getteammask(team);
    if (isdefined(player)) {
        var_fea0b904 = player.origin;
    } else {
        var_fea0b904 = self.curorigin;
    }
    self.spawn_influencer_dropped = self.trigger influencers::create_entity_influencer("ctf_flag_dropped", player_team_mask | enemy_team_mask);
    setinfluencertimeout(self.spawn_influencer_dropped, level.idleflagreturntime);
}

// Namespace ctf/ctf
// Params 1, eflags: 0x0
// Checksum 0xedc78311, Offset: 0x2478
// Size: 0x886
function onpickup(player) {
    carrierkilledby = self.carrierkilledby;
    self.carrierkilledby = undefined;
    if (isdefined(self.spawn_influencer_dropped)) {
        self.trigger influencers::remove_influencer(self.spawn_influencer_dropped);
        self.spawn_influencer_dropped = undefined;
    }
    player stats::function_2dabbec7(#"pickups", 1);
    if (level.touchreturn) {
        self gameobjects::allow_carry(#"enemy");
    }
    self removeinfluencers();
    team = self gameobjects::get_owner_team();
    otherteam = util::getotherteam(team);
    if (isdefined(player) && player.pers[#"team"] == team) {
        self notify(#"picked_up");
        util::printandsoundoneveryone(team, undefined, #"", undefined, "mp_obj_returned");
        if (isdefined(player.pers[#"returns"])) {
            player.pers[#"returns"]++;
            player.returns = player.pers[#"returns"];
        }
        if (isdefined(carrierkilledby) && carrierkilledby == player) {
            scoreevents::processscoreevent(#"flag_carrier_kill_return_close", player, undefined, undefined);
        } else if (distancesquared(self.trigger.baseorigin, player.origin) > 90000) {
            scoreevents::processscoreevent(#"flag_return", player, undefined, undefined);
        }
        demo::bookmark(#"event", gettime(), player);
        potm::bookmark(#"event", gettime(), player);
        player stats::function_2dabbec7(#"returns", 1);
        level thread popups::displayteammessagetoteam(#"hash_347504f7414c2861", player, team, undefined, undefined);
        level thread popups::displayteammessagetoteam(#"hash_565752dc258425f0", player, otherteam, undefined, undefined);
        self.visuals[0] clientfield::set("ctf_flag_away", 0);
        self gameobjects::set_flags(0);
        bb::function_9cca214a("ctf_flagreturn", undefined, team, player.origin);
        player recordgameevent("return");
        self returnflag();
        /#
            if (isdefined(player)) {
                print(team + "<dev string:xc0>");
                return;
            }
            print(team + "<dev string:xc0>");
        #/
        return;
    }
    bb::function_9cca214a("ctf_flagpickup", undefined, team, player.origin);
    player recordgameevent("pickup");
    scoreevents::processscoreevent(#"flag_grab", player, undefined, undefined);
    demo::bookmark(#"event", gettime(), player);
    potm::bookmark(#"event", gettime(), player);
    util::printandsoundoneveryone(otherteam, undefined, #"", undefined, "mp_obj_taken", "mp_enemy_obj_taken");
    level thread popups::displayteammessagetoteam(#"hash_6b94e754d048dae9", player, team, undefined, undefined);
    level thread popups::displayteammessagetoteam(#"hash_25ed0737f009ca72", player, otherteam, undefined, undefined);
    globallogic_audio::leader_dialog("ctfFriendlyFlagTaken", team, undefined, "ctf_flag");
    globallogic_audio::leader_dialog("ctfEnemyFlagTaken", otherteam, undefined, "ctf_flag_enemy");
    player.isflagcarrier = 1;
    player.flagcarried = self;
    player playlocalsound(#"mpl_flag_pickup_plr");
    player clientfield::set("ctf_flag_carrier", 1);
    self gameobjects::set_flags(1);
    globallogic_audio::play_2d_on_team("mpl_flagget_sting_friend", otherteam);
    globallogic_audio::play_2d_on_team("mpl_flagget_sting_enemy", team);
    if (level.enemycarriervisible) {
        self gameobjects::set_visible_team(#"any");
    } else {
        self gameobjects::set_visible_team(#"enemy");
    }
    self gameobjects::set_2d_icon(#"friendly", level.iconkill2d);
    self gameobjects::set_3d_icon(#"friendly", level.iconkill3d);
    self gameobjects::set_2d_icon(#"enemy", level.iconescort2d);
    self gameobjects::set_3d_icon(#"enemy", level.iconescort3d);
    player thread claim_trigger(level.flaghints[otherteam]);
    update_hints();
    /#
        print(team + "<dev string:xcf>");
    #/
    ss = level.spawnsystem;
    player_team_mask = util::getteammask(otherteam);
    enemy_team_mask = util::getteammask(team);
    player.spawn_influencer_friendly_carrier = player influencers::create_entity_influencer("ctf_carrier_friendly", player_team_mask);
    player.spawn_influencer_enemy_carrier = player influencers::create_entity_influencer("ctf_carrier_enemy", enemy_team_mask);
}

// Namespace ctf/ctf
// Params 1, eflags: 0x0
// Checksum 0x894ab7e0, Offset: 0x2d08
// Size: 0x46
function onpickupmusicstate(player) {
    self endon(#"disconnect");
    self endon(#"death");
    wait 6;
    if (player.isflagcarrier) {
    }
}

// Namespace ctf/ctf
// Params 0, eflags: 0x0
// Checksum 0x3289aec0, Offset: 0x2d58
// Size: 0x38
function ishome() {
    if (isdefined(self.carrier)) {
        return false;
    }
    if (self.curorigin != self.trigger.baseorigin) {
        return false;
    }
    return true;
}

// Namespace ctf/ctf
// Params 0, eflags: 0x0
// Checksum 0x9c35b6c1, Offset: 0x2d98
// Size: 0x244
function returnflag() {
    team = self gameobjects::get_owner_team();
    otherteam = util::getotherteam(team);
    globallogic_audio::play_2d_on_team("mpl_flagreturn_sting", team);
    globallogic_audio::play_2d_on_team("mpl_flagreturn_sting", otherteam);
    level.teamflagzones[otherteam] gameobjects::allow_use(#"friendly");
    level.teamflagzones[otherteam] gameobjects::set_visible_team(#"friendly");
    update_hints();
    if (level.touchreturn) {
        self gameobjects::allow_carry(#"enemy");
    }
    self gameobjects::return_home();
    self gameobjects::set_visible_team(#"any");
    self gameobjects::set_3d_icon(#"friendly", level.icondefend3d);
    self gameobjects::set_2d_icon(#"friendly", level.icondefend2d);
    self gameobjects::set_3d_icon(#"enemy", level.iconcapture3d);
    self gameobjects::set_2d_icon(#"enemy", level.iconcapture2d);
    globallogic_audio::leader_dialog("ctfFriendlyFlagReturned", team, undefined, "ctf_flag");
    globallogic_audio::leader_dialog("ctfEnemyFlagReturned", otherteam, undefined, "ctf_flag_enemy");
}

// Namespace ctf/ctf
// Params 1, eflags: 0x0
// Checksum 0x889c4919, Offset: 0x2fe8
// Size: 0x4e4
function oncapture(player) {
    team = player.pers[#"team"];
    enemyteam = util::getotherteam(team);
    time = gettime();
    playerteamsflag = level.teamflags[team];
    if (level.flagcapturecondition == 1 && playerteamsflag gameobjects::is_object_away_from_home()) {
        return;
    }
    if (!isdefined(player.carryobject)) {
        return;
    }
    util::printandsoundoneveryone(team, undefined, #"", undefined, "mp_obj_captured", "mp_enemy_obj_captured");
    bb::function_9cca214a("ctf_flagcapture", undefined, enemyteam, player.origin);
    game.challenge[team][#"capturedflag"] = 1;
    if (isdefined(player.pers[#"captures"])) {
        player.pers[#"captures"]++;
        player.captures = player.pers[#"captures"];
    }
    demo::bookmark(#"event", gettime(), player);
    potm::bookmark(#"event", gettime(), player);
    player stats::function_2dabbec7(#"captures", 1);
    level thread popups::displayteammessagetoteam(#"hash_97b6e279104e355", player, team, undefined, undefined);
    level thread popups::displayteammessagetoteam(#"hash_352c694daa4f9440", player, enemyteam, undefined, undefined);
    globallogic_audio::play_2d_on_team("mpl_flagcapture_sting_enemy", enemyteam);
    globallogic_audio::play_2d_on_team("mpl_flagcapture_sting_friend", team);
    player giveflagcapturexp(player);
    /#
        print(enemyteam + "<dev string:xdb>");
    #/
    flag = player.carryobject;
    player challenges::capturedobjective(time, flag.trigger);
    flag.dontannouncereturn = 1;
    flag gameobjects::return_home();
    flag.dontannouncereturn = undefined;
    otherteam = util::getotherteam(team);
    level.teamflags[otherteam] gameobjects::allow_carry(#"enemy");
    level.teamflags[otherteam] gameobjects::set_visible_team(#"any");
    level.teamflags[otherteam] gameobjects::return_home();
    level.teamflagzones[otherteam] gameobjects::allow_use(#"friendly");
    player.isflagcarrier = 0;
    player.flagcarried = undefined;
    player clientfield::set("ctf_flag_carrier", 0);
    globallogic_score::giveteamscoreforobjective(team, 1);
    globallogic_audio::leader_dialog("ctfEnemyFlagCaptured", team, undefined, "ctf_flag_enemy");
    globallogic_audio::leader_dialog("ctfFriendlyFlagCaptured", enemyteam, undefined, "ctf_flag");
    flag removeinfluencers();
    player removeinfluencers();
}

// Namespace ctf/ctf
// Params 1, eflags: 0x0
// Checksum 0x328bda28, Offset: 0x34d8
// Size: 0x54
function giveflagcapturexp(player) {
    scoreevents::processscoreevent(#"flag_capture", player, undefined, undefined);
    player recordgameevent("capture");
}

// Namespace ctf/ctf
// Params 0, eflags: 0x0
// Checksum 0x5fb4c8c5, Offset: 0x3538
// Size: 0x1c4
function onreset() {
    update_hints();
    team = self gameobjects::get_owner_team();
    self gameobjects::set_3d_icon(#"friendly", level.icondefend3d);
    self gameobjects::set_2d_icon(#"friendly", level.icondefend2d);
    self gameobjects::set_3d_icon(#"enemy", level.iconcapture3d);
    self gameobjects::set_2d_icon(#"enemy", level.iconcapture2d);
    if (level.touchreturn) {
        self gameobjects::allow_carry(#"enemy");
    }
    level.teamflagzones[team] gameobjects::set_visible_team(#"friendly");
    level.teamflagzones[team] gameobjects::allow_use(#"friendly");
    self.visuals[0] clientfield::set("ctf_flag_away", 0);
    self gameobjects::set_flags(0);
    self removeinfluencers();
}

// Namespace ctf/ctf
// Params 1, eflags: 0x0
// Checksum 0x9aa8a1b, Offset: 0x3708
// Size: 0x40
function getotherflag(flag) {
    if (flag == level.flags[0]) {
        return level.flags[1];
    }
    return level.flags[0];
}

// Namespace ctf/ctf
// Params 9, eflags: 0x0
// Checksum 0xd91c1ed9, Offset: 0x3750
// Size: 0x87c
function onplayerkilled(einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration) {
    if (isdefined(attacker) && isplayer(attacker)) {
        for (index = 0; index < level.flags.size; index++) {
            flagteam = "invalidTeam";
            inflagradius = 0;
            defendedflag = 0;
            offendedflag = 0;
            flagcarrier = level.flags[index].carrier;
            if (isdefined(flagcarrier)) {
                flagorigin = level.flags[index].carrier.origin;
                iscarried = 1;
                if (isplayer(attacker) && attacker.pers[#"team"] != self.pers[#"team"]) {
                    if (isdefined(level.flags[index].carrier.attackerdata)) {
                        if (level.flags[index].carrier != attacker) {
                            if (isdefined(level.flags[index].carrier.attackerdata[self.clientid])) {
                                scoreevents::processscoreevent(#"rescue_flag_carrier", attacker, undefined, weapon);
                            }
                        }
                    }
                }
            } else {
                flagorigin = level.flags[index].curorigin;
                iscarried = 0;
            }
            dist = distance2dsquared(self.origin, flagorigin);
            if (dist < level.defaultoffenseradiussq) {
                inflagradius = 1;
                if (level.flags[index].ownerteam == attacker.pers[#"team"]) {
                    defendedflag = 1;
                } else {
                    offendedflag = 1;
                }
            }
            dist = distance2dsquared(attacker.origin, flagorigin);
            if (dist < level.defaultoffenseradiussq) {
                inflagradius = 1;
                if (level.flags[index].ownerteam == attacker.pers[#"team"]) {
                    defendedflag = 1;
                } else {
                    offendedflag = 1;
                }
            }
            if (inflagradius && isplayer(attacker) && attacker.pers[#"team"] != self.pers[#"team"]) {
                if (defendedflag) {
                    if (isdefined(self.isflagcarrier) && self.isflagcarrier) {
                        scoreevents::processscoreevent(#"kill_flag_carrier", attacker, undefined, weapon);
                        attacker stats::function_b48aa4e(#"kill_carrier", 1);
                    } else {
                        scoreevents::processscoreevent(#"killed_attacker", attacker, undefined, weapon);
                    }
                    self recordkillmodifier("assaulting");
                }
                if (offendedflag) {
                    if (iscarried == 1) {
                        if (isdefined(flagcarrier) && attacker == flagcarrier) {
                            scoreevents::processscoreevent(#"killed_enemy_while_carrying_flag", attacker, undefined, weapon);
                        } else {
                            scoreevents::processscoreevent(#"defend_flag_carrier", attacker, undefined, weapon);
                            attacker stats::function_b48aa4e(#"defend_carrier", 1);
                        }
                    } else {
                        scoreevents::processscoreevent(#"killed_defender", attacker, undefined, weapon);
                    }
                    self recordkillmodifier("defending");
                }
            }
        }
        victim = self;
        foreach (flag_zone in level.flagzones) {
            if (isdefined(attacker.team) && attacker != victim && isdefined(victim.team)) {
                dist_to_zone_origin = distance2dsquared(attacker.origin, flag_zone.origin);
                victim_dist_to_zone_origin = distance2dsquared(victim.origin, flag_zone.origin);
                if (victim_dist_to_zone_origin < level.defaultoffenseradiussq || dist_to_zone_origin < level.defaultoffenseradiussq) {
                    if (victim.team == flag_zone.team) {
                        attacker thread challenges::killedbasedefender(flag_zone.trigger);
                        continue;
                    }
                    attacker thread challenges::killedbaseoffender(flag_zone.trigger, weapon);
                }
            }
        }
    }
    if (!isdefined(self.isflagcarrier) || !self.isflagcarrier) {
        return;
    }
    if (isdefined(attacker) && isplayer(attacker) && attacker.pers[#"team"] != self.pers[#"team"]) {
        if (isdefined(self.flagcarried)) {
            for (index = 0; index < level.flags.size; index++) {
                currentflag = level.flags[index];
                if (currentflag.ownerteam == self.team) {
                    if (currentflag.curorigin == currentflag.trigger.baseorigin) {
                        dist = distance2dsquared(self.origin, currentflag.curorigin);
                        if (dist < level.defaultoffenseradiussq) {
                            self.flagcarried.carrierkilledby = attacker;
                            break;
                        }
                    }
                }
            }
        }
        attacker recordgameevent("kill_carrier");
        self recordkillmodifier("carrying");
    }
}

// Namespace ctf/ctf
// Params 0, eflags: 0x0
// Checksum 0x6a8bb222, Offset: 0x3fd8
// Size: 0x22
function turn_on() {
    if (level.hardcoremode) {
        return;
    }
    self.origin = self.original_origin;
}

// Namespace ctf/ctf
// Params 0, eflags: 0x0
// Checksum 0xabbe4ef8, Offset: 0x4008
// Size: 0x3a
function turn_off() {
    self.origin = (self.original_origin[0], self.original_origin[1], self.original_origin[2] - 10000);
}

// Namespace ctf/ctf
// Params 0, eflags: 0x0
// Checksum 0x8775f941, Offset: 0x4050
// Size: 0x164
function update_hints() {
    allied_flag = level.teamflags[#"allies"];
    axis_flag = level.teamflags[#"axis"];
    if (!level.touchreturn) {
        return;
    }
    if (isdefined(allied_flag.carrier) && axis_flag gameobjects::is_object_away_from_home()) {
        level.flaghints[#"axis"] turn_on();
    } else {
        level.flaghints[#"axis"] turn_off();
    }
    if (isdefined(axis_flag.carrier) && allied_flag gameobjects::is_object_away_from_home()) {
        level.flaghints[#"allies"] turn_on();
        return;
    }
    level.flaghints[#"allies"] turn_off();
}

// Namespace ctf/ctf
// Params 1, eflags: 0x0
// Checksum 0xcdb1720b, Offset: 0x41c0
// Size: 0x64
function claim_trigger(trigger) {
    self endon(#"disconnect");
    self clientclaimtrigger(trigger);
    self waittill(#"drop_object");
    self clientreleasetrigger(trigger);
}

// Namespace ctf/ctf
// Params 1, eflags: 0x0
// Checksum 0x448b6649, Offset: 0x4230
// Size: 0xda
function createflagspawninfluencer(entityteam) {
    otherteam = util::getotherteam(entityteam);
    team_mask = util::getteammask(entityteam);
    other_team_mask = util::getteammask(otherteam);
    self.spawn_influencer_friendly = self influencers::create_influencer("ctf_base_friendly", self.trigger.origin, team_mask);
    self.spawn_influencer_enemy = self influencers::create_influencer("ctf_base_friendly", self.trigger.origin, other_team_mask);
}

// Namespace ctf/ctf
// Params 4, eflags: 0x0
// Checksum 0xdd9efc61, Offset: 0x4318
// Size: 0x80
function ctf_getteamkillpenalty(einflictor, attacker, smeansofdeath, weapon) {
    teamkill_penalty = globallogic_defaults::default_getteamkillpenalty(einflictor, attacker, smeansofdeath, weapon);
    if (isdefined(self.isflagcarrier) && self.isflagcarrier) {
        teamkill_penalty *= level.teamkillpenaltymultiplier;
    }
    return teamkill_penalty;
}

// Namespace ctf/ctf
// Params 4, eflags: 0x0
// Checksum 0xbaccb9dc, Offset: 0x43a0
// Size: 0x92
function ctf_getteamkillscore(einflictor, attacker, smeansofdeath, weapon) {
    teamkill_score = attacker rank::getscoreinfovalue("kill");
    if (isdefined(self.isflagcarrier) && self.isflagcarrier) {
        teamkill_score *= level.teamkillscoremultiplier;
    }
    return int(teamkill_score);
}

