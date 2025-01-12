#using scripts\abilities\ability_power;
#using scripts\core_common\bb_shared;
#using scripts\core_common\bots\bot;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\challenges_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\damagefeedback_shared;
#using scripts\core_common\demo_shared;
#using scripts\core_common\gameobjects_shared;
#using scripts\core_common\gamestate;
#using scripts\core_common\globallogic\globallogic_shared;
#using scripts\core_common\healthoverlay;
#using scripts\core_common\high_value_operative;
#using scripts\core_common\hostmigration_shared;
#using scripts\core_common\hud_message_shared;
#using scripts\core_common\hud_shared;
#using scripts\core_common\hud_util_shared;
#using scripts\core_common\influencers_shared;
#using scripts\core_common\killcam_shared;
#using scripts\core_common\lui_shared;
#using scripts\core_common\map;
#using scripts\core_common\match_record;
#using scripts\core_common\math_shared;
#using scripts\core_common\persistence_shared;
#using scripts\core_common\player\player_shared;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\potm_shared;
#using scripts\core_common\rank_shared;
#using scripts\core_common\rat_shared;
#using scripts\core_common\simple_hostmigration;
#using scripts\core_common\spawning_shared;
#using scripts\core_common\spectating;
#using scripts\core_common\status_effects\status_effect_util;
#using scripts\core_common\system_shared;
#using scripts\core_common\tweakables_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\core_common\visionset_mgr_shared;
#using scripts\killstreaks\killstreaks_shared;
#using scripts\killstreaks\mp\killstreaks;
#using scripts\mp_common\arena;
#using scripts\mp_common\bots\mp_bot;
#using scripts\mp_common\challenges;
#using scripts\mp_common\draft;
#using scripts\mp_common\gameadvertisement;
#using scripts\mp_common\gamerep;
#using scripts\mp_common\gametypes\battlechatter;
#using scripts\mp_common\gametypes\clientids;
#using scripts\mp_common\gametypes\deathicons;
#using scripts\mp_common\gametypes\dev;
#using scripts\mp_common\gametypes\display_transition;
#using scripts\mp_common\gametypes\dogtags;
#using scripts\mp_common\gametypes\gametype;
#using scripts\mp_common\gametypes\globallogic_audio;
#using scripts\mp_common\gametypes\globallogic_defaults;
#using scripts\mp_common\gametypes\globallogic_score;
#using scripts\mp_common\gametypes\globallogic_spawn;
#using scripts\mp_common\gametypes\globallogic_ui;
#using scripts\mp_common\gametypes\globallogic_utils;
#using scripts\mp_common\gametypes\hostmigration;
#using scripts\mp_common\gametypes\hud_message;
#using scripts\mp_common\gametypes\match;
#using scripts\mp_common\gametypes\menus;
#using scripts\mp_common\gametypes\outcome;
#using scripts\mp_common\gametypes\overtime;
#using scripts\mp_common\gametypes\round;
#using scripts\mp_common\gametypes\serversettings;
#using scripts\mp_common\gametypes\shellshock;
#using scripts\mp_common\player\player;
#using scripts\mp_common\player\player_loadout;
#using scripts\mp_common\player\player_monitor;
#using scripts\mp_common\player\player_record;
#using scripts\mp_common\player\player_utils;
#using scripts\mp_common\rat;
#using scripts\mp_common\userspawnselection;
#using scripts\mp_common\util;
#using scripts\weapons\mp\weapons;
#using scripts\weapons\weapon_utils;
#using scripts\weapons\weapons;

#namespace globallogic;

// Namespace globallogic/globallogic
// Params 0, eflags: 0x2
// Checksum 0xc1926f91, Offset: 0xb00
// Size: 0x44
function autoexec __init__system__() {
    system::register(#"globallogic", &__init__, undefined, #"visionset_mgr");
}

// Namespace globallogic/globallogic
// Params 0, eflags: 0x0
// Checksum 0xac886d57, Offset: 0xb50
// Size: 0x28c
function __init__() {
    if (!isdefined(level.vsmgr_prio_visionset_mpintro)) {
        level.vsmgr_prio_visionset_mpintro = 5;
    }
    visionset_mgr::register_info("visionset", "mpintro", 1, level.vsmgr_prio_visionset_mpintro, 31, 0, &visionset_mgr::ramp_in_out_thread, 0);
    level.host_migration_activate_visionset_func = &mpintro_visionset_activate_func;
    level.host_migration_deactivate_visionset_func = &mpintro_visionset_deactivate_func;
    visionset_mgr::register_info("visionset", "crithealth", 1, 4, 25, 1, &visionset_mgr::ramp_in_out_thread_per_player, 0);
    clientfield::register("clientuimodel", "huditems.killedByEntNum", 1, 4, "int");
    clientfield::register("clientuimodel", "huditems.killedByAttachmentCount", 1, 4, "int");
    clientfield::register("clientuimodel", "huditems.killedByItemIndex", 1, 10, "int");
    clientfield::register("clientuimodel", "huditems.killedByMOD", 1, 8, "int");
    for (index = 0; index < 5; index++) {
        clientfield::register("clientuimodel", "huditems.killedByAttachment" + index, 1, 6, "int");
    }
    level.weaponpineapplegun = getweapon(#"hero_pineapplegun");
    level.weaponpineapplegungrenade = getweapon(#"hero_pineapple_grenade");
    ability_power::function_db8f789(level.weaponpineapplegun, level.weaponpineapplegungrenade);
    callback::on_spawned(&on_player_spawned);
}

// Namespace globallogic/globallogic
// Params 0, eflags: 0x4
// Checksum 0xbbedec02, Offset: 0xde8
// Size: 0x24
function private on_player_spawned() {
    self clientfield::set_player_uimodel("huditems.killedByEntNum", 15);
}

// Namespace globallogic/globallogic
// Params 0, eflags: 0x0
// Checksum 0x255d1b8d, Offset: 0xe18
// Size: 0xbc4
function init() {
    level.splitscreen = issplitscreen();
    level.xenon = getdvarstring(#"xenongame") == "true";
    level.ps3 = getdvarstring(#"ps3game") == "true";
    level.wiiu = getdvarstring(#"wiiugame") == "true";
    level.orbis = getdvarstring(#"orbisgame") == "true";
    level.durango = getdvarstring(#"durangogame") == "true";
    level.onlinegame = sessionmodeisonlinegame();
    level.systemlink = sessionmodeissystemlink();
    level.console = level.xenon || level.ps3 || level.wiiu || level.orbis || level.durango;
    level.rankedmatch = gamemodeisusingxp();
    level.leaguematch = 0;
    level.custommatch = gamemodeismode(1);
    level.arenamatch = gamemodeisarena();
    level.mpcustommatch = level.custommatch;
    level.contractsenabled = !getgametypesetting(#"disablecontracts");
    level.contractsenabled = 0;
    level.disablevehicleburndamage = 1;
    level.var_74db4b88 = 1;
    /#
        if (getdvarint(#"scr_forcerankedmatch", 0) == 1) {
            level.rankedmatch = 1;
        }
    #/
    level.script = util::get_map_name();
    level.gametype = util::get_game_type();
    level.teambased = 0;
    level.teamcount = getgametypesetting(#"teamcount");
    /#
        level.teamcount = math::clamp(level.teamcount, 1, getdvarint(#"com_maxclients", level.teamcount));
    #/
    level.multiteam = level.teamcount > 2;
    level.maxteamplayers = getgametypesetting(#"maxteamplayers");
    init_teams();
    level.var_3867395b = 1;
    /#
        thread function_ed41a631();
    #/
    level.overrideteamscore = 0;
    level.overrideplayerscore = 0;
    level.displayhalftimetext = 0;
    level.displayroundendtext = 1;
    level.clampscorelimit = 1;
    level.endgameonscorelimit = 1;
    level.endgameontimelimit = 1;
    level.scoreroundwinbased = 0;
    level.resetplayerscoreeveryround = 0;
    level.doendgamescoreboard = 1;
    level.gameforfeited = 0;
    level.forceautoassign = 0;
    level.halftimetype = 2;
    level.laststatustime = 0;
    level.waswinning = [];
    level.lastslowprocessframe = 0;
    level.placement = [];
    foreach (team, _ in level.teams) {
        level.placement[team] = [];
    }
    level.placement[#"all"] = [];
    level.defaultoffenseradius = 560;
    level.defaultoffenseradiussq = level.defaultoffenseradius * level.defaultoffenseradius;
    level.dropteam = getdvarint(#"sv_maxclients", 0);
    level.infinalkillcam = 0;
    level.new_health_model = getdvarint(#"new_health_model", 1) > 0;
    function_ef1056a0();
    gameobjects::register_allowed_gameobject(level.gametype);
    map::init();
    gametype::init();
    globallogic_ui::init();
    registerdvars();
    loadout::init_dvars();
    level.oldschool = getgametypesetting(#"oldschoolmode");
    display_transition::function_e1efa707();
    precache_mp_leaderboards();
    if (!isdefined(game.tiebreaker)) {
        game.tiebreaker = 0;
    }
    if (!isdefined(game.stat)) {
        game.stat = [];
    }
    thread gameadvertisement::init();
    thread gamerep::init();
    level.disablechallenges = 0;
    if (level.leaguematch || getdvarint(#"scr_disablechallenges", 0) > 0) {
        level.disablechallenges = 1;
    }
    level.disablestattracking = getdvarint(#"scr_disablestattracking", 0) > 0;
    setup_callbacks();
    clientfield::register("playercorpse", "firefly_effect", 1, 2, "int");
    clientfield::register("playercorpse", "annihilate_effect", 1, 1, "int");
    clientfield::register("playercorpse", "pineapplegun_effect", 1, 1, "int");
    clientfield::register("actor", "annihilate_effect", 1, 1, "int");
    clientfield::register("actor", "pineapplegun_effect", 1, 1, "int");
    clientfield::register("world", "game_ended", 1, 1, "int");
    clientfield::register("world", "post_game", 1, 1, "int");
    clientfield::register("clientuimodel", "hudItems.hideOutcomeUI", 1, 1, "int");
    clientfield::register("clientuimodel", "hudItems.captureCrateState", 1, 2, "int");
    clientfield::register("clientuimodel", "hudItems.captureCrateTotalTime", 1, 13, "int");
    clientfield::register("worlduimodel", "hudItems.team1.roundsWon", 1, 4, "int");
    clientfield::register("worlduimodel", "hudItems.team1.livesCount", 1, 8, "int");
    clientfield::register("worlduimodel", "hudItems.team1.noRespawnsLeft", 1, 1, "int");
    clientfield::register("worlduimodel", "hudItems.team2.roundsWon", 1, 4, "int");
    clientfield::register("worlduimodel", "hudItems.team2.livesCount", 1, 8, "int");
    clientfield::register("worlduimodel", "hudItems.team2.noRespawnsLeft", 1, 1, "int");
    clientfield::register("worlduimodel", "hudItems.specialistSwitchIsLethal", 1, 1, "int");
    clientfield::register("clientuimodel", "hudItems.playerLivesCount", 1, 8, "int");
    clientfield::register("clientuimodel", "hudItems.armorIsOnCooldown", 1, 1, "int");
    level thread setroundswonuimodels();
    level.figure_out_attacker = &player::figure_out_attacker;
    level.figure_out_friendly_fire = &player::figure_out_friendly_fire;
    thread hud_message::init();
}

/#

    // Namespace globallogic/globallogic
    // Params 0, eflags: 0x0
    // Checksum 0x2c58ad01, Offset: 0x19e8
    // Size: 0x52
    function function_ed41a631() {
        while (true) {
            wait 2;
            level.var_3867395b = getdvarint(#"scr_ekia", level.var_3867395b);
        }
    }

#/

// Namespace globallogic/globallogic
// Params 0, eflags: 0x4
// Checksum 0xd2c257b7, Offset: 0x1a48
// Size: 0x21c
function private init_teams() {
    level.teams = [];
    level.teamindex = [];
    teamcount = level.teamcount;
    if (level.teamcount == 1) {
        teamcount = getdvarint(#"com_maxclients", 18);
        level.teams[#"free"] = "free";
    }
    level.teams[#"allies"] = "allies";
    level.teams[#"axis"] = "axis";
    level.teamindex[#"world"] = "world";
    level.teamindex[#"neutral"] = 0;
    level.teamindex[#"allies"] = 1;
    level.teamindex[#"axis"] = 2;
    for (teamindex = 3; teamindex < teamcount; teamindex++) {
        level.teams[hash("team" + teamindex)] = "team" + teamindex;
        level.teamindex[hash("team" + teamindex)] = teamindex;
    }
    callback::callback(#"init_teams");
}

// Namespace globallogic/globallogic
// Params 0, eflags: 0x0
// Checksum 0x59cbf0f4, Offset: 0x1c70
// Size: 0x1b6
function function_ef1056a0() {
    level.var_c356c6bc = [];
    globallogic_utils::function_3e5486f6(0, "dnf");
    globallogic_utils::function_3e5486f6(1, "completed");
    globallogic_utils::function_3e5486f6(2, "time limit");
    globallogic_utils::function_3e5486f6(3, "scorelimit");
    globallogic_utils::function_3e5486f6(4, "roundscorelimit");
    globallogic_utils::function_3e5486f6(5, "roundlimit");
    globallogic_utils::function_3e5486f6(6, "team eliminated");
    globallogic_utils::function_3e5486f6(7, "forfeit");
    globallogic_utils::function_3e5486f6(8, "ended game");
    globallogic_utils::function_3e5486f6(9, "host ended game");
    globallogic_utils::function_3e5486f6(10, "host ended sucks");
    for (i = 0; i < 5; i++) {
        globallogic_utils::function_3e5486f6(11 + i, "gamemode-specific");
    }
}

// Namespace globallogic/globallogic
// Params 0, eflags: 0x0
// Checksum 0x9c0f9c3f, Offset: 0x1e30
// Size: 0x124
function registerdvars() {
    setmatchflag("bomb_timer", 0);
    level.vehicledamagescalar = getdvarfloat(#"scr_vehicle_damage_scalar", 1);
    level.fire_audio_repeat_duration = getdvarint(#"fire_audio_repeat_duration", 0);
    level.fire_audio_random_max_duration = getdvarint(#"fire_audio_random_max_duration", 0);
    setdvar(#"g_customteamname_allies", "");
    setdvar(#"g_customteamname_axis", "");
    setdvar(#"hash_8351525729015ab", 1);
}

// Namespace globallogic/globallogic
// Params 0, eflags: 0x0
// Checksum 0x7c8a83f0, Offset: 0x1f60
// Size: 0xd4
function setroundswonuimodels() {
    waitframe(1);
    alliesroundswon = 0;
    axisroundswon = 0;
    if (isdefined(game.stat[#"roundswon"])) {
        alliesroundswon = game.stat[#"roundswon"][#"allies"];
        axisroundswon = game.stat[#"roundswon"][#"axis"];
    }
    clientfield::set_world_uimodel("hudItems.team1.roundsWon", alliesroundswon);
    clientfield::set_world_uimodel("hudItems.team2.roundsWon", axisroundswon);
}

// Namespace globallogic/globallogic
// Params 10, eflags: 0x0
// Checksum 0x3fbec500, Offset: 0x2040
// Size: 0x54
function blank(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10) {
    
}

// Namespace globallogic/globallogic
// Params 0, eflags: 0x0
// Checksum 0x4fd31582, Offset: 0x20a0
// Size: 0x4ac
function setup_callbacks() {
    level.spawnplayer = &globallogic_spawn::spawnplayer;
    level.spawnplayerprediction = &globallogic_spawn::spawnplayerprediction;
    level.spawnclient = &globallogic_spawn::spawnclient;
    level.spawnspectator = &globallogic_spawn::spawnspectator;
    level.spawnintermission = &globallogic_spawn::spawnintermission;
    level.scoreongiveplayerscore = &globallogic_score::giveplayerscore;
    level.onplayerscore = &globallogic_score::default_onplayerscore;
    level.onteamscore = &globallogic_score::default_onteamscore;
    level.wavespawntimer = &wavespawntimer;
    level.spawnmessage = &globallogic_spawn::default_spawnmessage;
    level.onspawnplayer = &blank;
    level.onspawnplayer = &spawning::onspawnplayer;
    level.onspawnspectator = &globallogic_defaults::default_onspawnspectator;
    level.onspawnintermission = &globallogic_defaults::default_onspawnintermission;
    level.onrespawndelay = &blank;
    level.onforfeit = &globallogic_defaults::default_onforfeit;
    level.ontimelimit = &globallogic_defaults::default_ontimelimit;
    level.onscorelimit = &globallogic_defaults::default_onscorelimit;
    level.onroundscorelimit = &globallogic_defaults::default_onroundscorelimit;
    level.onalivecountchange = &globallogic_defaults::default_onalivecountchange;
    level.ondeadevent = undefined;
    level.ononeleftevent = &globallogic_defaults::default_ononeleftevent;
    level.giveteamscore = &globallogic_score::giveteamscore;
    level.onlastteamaliveevent = &globallogic_defaults::function_45c10f52;
    level.gettimepassed = &globallogic_utils::gettimepassed;
    level.gettimelimit = &globallogic_defaults::default_gettimelimit;
    level.getteamkillpenalty = &globallogic_defaults::default_getteamkillpenalty;
    level.getteamkillscore = &globallogic_defaults::default_getteamkillscore;
    level.iskillboosting = &globallogic_score::default_iskillboosting;
    level.var_b11ed148 = &globallogic_score::function_b11ed148;
    level._setteamscore = &globallogic_score::_setteamscore;
    level._setplayerscore = &globallogic_score::_setplayerscore;
    level._getteamscore = &globallogic_score::_getteamscore;
    level._getplayerscore = &globallogic_score::_getplayerscore;
    level.resetplayerscorestreaks = &globallogic_score::resetplayerscorechainandmomentum;
    level.onprecachegametype = &blank;
    level.onstartgametype = &blank;
    level.onplayerconnect = &blank;
    level.onplayerdisconnect = &blank;
    level.onplayerdamage = &blank;
    level.var_6e29ff90 = [];
    level.var_66d37717 = [];
    level.var_ec2732d9 = &function_e2f4e49b;
    level.onteamoutcomenotify = &hud_message::teamoutcomenotify;
    level.onoutcomenotify = &hud_message::outcomenotify;
    level.onendround = &blank;
    level.onendgame = &globallogic_defaults::onendgame;
    level.onmedalawarded = &blank;
    if (sessionmodeiswarzonegame()) {
        level.var_722f7267 = &player_monitor::function_add15ef8;
    }
    globallogic_ui::setupcallbacks();
}

// Namespace globallogic/globallogic
// Params 0, eflags: 0x0
// Checksum 0xd33bfec1, Offset: 0x2558
// Size: 0xe4
function precache_mp_friend_leaderboards() {
    hardcoremode = getgametypesetting(#"hardcoremode");
    if (!isdefined(hardcoremode)) {
        hardcoremode = 0;
    }
    arenamode = isarenamode();
    postfix = "";
    if (hardcoremode) {
        postfix = "_HC";
    } else if (arenamode) {
        postfix = "_ARENA";
    }
    friendleaderboarda = "LB_MP_FRIEND_A" + postfix;
    friendleaderboardb = " LB_MP_FRIEND_B" + postfix;
    precacheleaderboards(friendleaderboarda + friendleaderboardb);
}

// Namespace globallogic/globallogic
// Params 0, eflags: 0x0
// Checksum 0x9b7815d1, Offset: 0x2648
// Size: 0xf4
function precache_mp_anticheat_leaderboards() {
    hardcoremode = getgametypesetting(#"hardcoremode");
    if (!isdefined(hardcoremode)) {
        hardcoremode = 0;
    }
    arenamode = isarenamode();
    postfix = "";
    if (hardcoremode) {
        postfix = "_HC";
    } else if (arenamode) {
        postfix = "_ARENA";
    }
    anticheatleaderboard = "LB_MP_ANTICHEAT_" + level.gametype + postfix;
    if (level.gametype != "fr") {
        anticheatleaderboard += " LB_MP_ANTICHEAT_GLOBAL";
    }
    precacheleaderboards(anticheatleaderboard);
}

// Namespace globallogic/globallogic
// Params 0, eflags: 0x0
// Checksum 0x21424e77, Offset: 0x2748
// Size: 0x1f4
function precache_mp_public_leaderboards() {
    mapname = util::get_map_name();
    hardcoremode = getgametypesetting(#"hardcoremode");
    if (!isdefined(hardcoremode)) {
        hardcoremode = 0;
    }
    arenamode = isarenamode();
    freerunmode = level.gametype == "fr";
    postfix = "";
    if (freerunmode) {
        frleaderboard = " LB_MP_GM_FR_" + getsubstr(mapname, 3, mapname.size);
        precacheleaderboards(frleaderboard);
        return;
    } else if (hardcoremode) {
        postfix = "_HC";
    } else if (arenamode) {
        postfix = "_ARENA";
    }
    careerleaderboard = " LB_MP_GB_SCORE" + postfix;
    prestigelb = " LB_MP_GB_XPPRESTIGE";
    gamemodeleaderboard = "LB_MP_GM_" + level.gametype + postfix;
    arenaleaderboard = "";
    if (gamemodeismode(6)) {
        arenaslot = arenagetslot();
        arenaleaderboard = " LB_MP_ARENA_MASTERS_0" + arenaslot;
    }
    precacheleaderboards(gamemodeleaderboard + careerleaderboard + prestigelb + arenaleaderboard);
}

// Namespace globallogic/globallogic
// Params 0, eflags: 0x0
// Checksum 0x4ee89c50, Offset: 0x2948
// Size: 0x44
function precache_mp_custom_leaderboards() {
    customleaderboards = "LB_MP_CG_" + level.gametype;
    precacheleaderboards("LB_MP_CG_GENERAL " + customleaderboards);
}

// Namespace globallogic/globallogic
// Params 0, eflags: 0x0
// Checksum 0xc4cfe300, Offset: 0x2998
// Size: 0x8c
function precache_mp_leaderboards() {
    if (bot::is_bot_ranked_match()) {
        return;
    }
    if (level.rankedmatch || level.gametype == "fr") {
        precache_mp_public_leaderboards();
        precache_mp_friend_leaderboards();
        precache_mp_anticheat_leaderboards();
        return;
    }
    precache_mp_custom_leaderboards();
}

// Namespace globallogic/globallogic
// Params 4, eflags: 0x0
// Checksum 0x41b2ac03, Offset: 0x2a30
// Size: 0xb2
function compareteambygamestat(gamestat, teama, teamb, previous_winner_score) {
    winner = undefined;
    assert(teama !== "<dev string:x30>");
    if (previous_winner_score == game.stat[gamestat][teamb]) {
        winner = undefined;
    } else if (game.stat[gamestat][teamb] > previous_winner_score) {
        winner = teamb;
    } else {
        winner = teama;
    }
    return winner;
}

// Namespace globallogic/globallogic
// Params 1, eflags: 0x0
// Checksum 0xa79efe62, Offset: 0x2af0
// Size: 0xd4
function determineteamwinnerbygamestat(gamestat) {
    teamkeys = getarraykeys(level.teams);
    winner = teamkeys[0];
    previous_winner_score = game.stat[gamestat][winner];
    for (teamindex = 1; teamindex < teamkeys.size; teamindex++) {
        winner = compareteambygamestat(gamestat, winner, teamkeys[teamindex], previous_winner_score);
        if (isdefined(winner)) {
            previous_winner_score = game.stat[gamestat][winner];
        }
    }
    return winner;
}

// Namespace globallogic/globallogic
// Params 3, eflags: 0x0
// Checksum 0x8bf26ece, Offset: 0x2bd0
// Size: 0x86
function compareteambyteamscore(currentwinner, teamb, var_cafaf664) {
    assert(currentwinner !== "<dev string:x30>");
    teambscore = [[ level._getteamscore ]](teamb);
    if (teambscore == var_cafaf664) {
        return undefined;
    } else if (teambscore > var_cafaf664) {
        return teamb;
    }
    return currentwinner;
}

// Namespace globallogic/globallogic
// Params 0, eflags: 0x0
// Checksum 0x45cd2ef4, Offset: 0x2c60
// Size: 0xc0
function determineteamwinnerbyteamscore() {
    teamkeys = getarraykeys(level.teams);
    winner = teamkeys[0];
    var_cafaf664 = [[ level._getteamscore ]](winner);
    for (teamindex = 1; teamindex < teamkeys.size; teamindex++) {
        winner = compareteambyteamscore(winner, teamkeys[teamindex], var_cafaf664);
        if (isdefined(winner)) {
            var_cafaf664 = [[ level._getteamscore ]](winner);
        }
    }
    return winner;
}

// Namespace globallogic/globallogic
// Params 1, eflags: 0x0
// Checksum 0xb9b8e57e, Offset: 0x2d28
// Size: 0xd4
function forceend(hostsucks = 0) {
    if (level.hostforcedend || level.forcedend) {
        return;
    }
    level.forcedend = 1;
    level.hostforcedend = 1;
    if (hostsucks) {
        var_c3d87d03 = 10;
    } else {
        var_c3d87d03 = 9;
    }
    setmatchflag("disableIngameMenu", 1);
    round::function_76a0135d();
    round::set_flag("force_end_host");
    thread end_round(var_c3d87d03);
}

// Namespace globallogic/globallogic
// Params 0, eflags: 0x0
// Checksum 0xf68c277d, Offset: 0x2e08
// Size: 0x94
function killserverpc() {
    if (level.hostforcedend || level.forcedend) {
        return;
    }
    level.forcedend = 1;
    level.hostforcedend = 1;
    level.killserver = 1;
    round::set_flag("force_end_host");
    round::function_76a0135d();
    thread end_round(9);
}

// Namespace globallogic/globallogic
// Params 0, eflags: 0x0
// Checksum 0x9ad30730, Offset: 0x2ea8
// Size: 0xa6
function atleasttwoteams() {
    valid_count = 0;
    foreach (team, _ in level.teams) {
        if (level.playercount[team] != 0) {
            valid_count++;
        }
    }
    if (valid_count < 2) {
        return false;
    }
    return true;
}

// Namespace globallogic/globallogic
// Params 1, eflags: 0x0
// Checksum 0xeb698ac7, Offset: 0x2f58
// Size: 0x64
function checkifteamforfeits(team) {
    if (!game.everexisted[team]) {
        return false;
    }
    if (level.playercount[team] < 1 && util::totalplayercount() > 0) {
        return true;
    }
    return false;
}

// Namespace globallogic/globallogic
// Params 0, eflags: 0x0
// Checksum 0x1e64619f, Offset: 0x2fc8
// Size: 0x114
function function_c64c7a91() {
    var_4dfb2196 = 0;
    var_9c3f07a7 = undefined;
    foreach (team, _ in level.teams) {
        if (checkifteamforfeits(team)) {
            var_4dfb2196++;
            if (!level.multiteam) {
                thread [[ level.onforfeit ]](team);
                return true;
            }
            continue;
        }
        var_9c3f07a7 = team;
    }
    if (level.multiteam && var_4dfb2196 == level.teams.size - 1) {
        thread [[ level.onforfeit ]](var_9c3f07a7);
        return true;
    }
    return false;
}

// Namespace globallogic/globallogic
// Params 0, eflags: 0x0
// Checksum 0xdf8ae439, Offset: 0x30e8
// Size: 0x90
function dospawnqueueupdates() {
    foreach (team, _ in level.teams) {
        if (level.spawnqueuemodified[team]) {
            [[ level.onalivecountchange ]](team);
        }
    }
}

// Namespace globallogic/globallogic
// Params 1, eflags: 0x0
// Checksum 0x430720f2, Offset: 0x3180
// Size: 0x58
function isteamalldead(team) {
    return (level.var_ba5bd3ee || level.everexisted[team]) && !level.alivecount[team] && !level.playerlives[team];
}

// Namespace globallogic/globallogic
// Params 0, eflags: 0x0
// Checksum 0x4100de64, Offset: 0x31e0
// Size: 0x8a
function areallteamsdead() {
    foreach (team, _ in level.teams) {
        if (!isteamalldead(team)) {
            return false;
        }
    }
    return true;
}

// Namespace globallogic/globallogic
// Params 0, eflags: 0x0
// Checksum 0x5b9655ca, Offset: 0x3278
// Size: 0xf4
function function_4f9a4c7f() {
    count = 0;
    var_42bbdeba = 0;
    aliveteam = undefined;
    foreach (team, _ in level.teams) {
        if (level.everexisted[team]) {
            if (!isteamalldead(team)) {
                aliveteam = team;
                count++;
            }
            var_42bbdeba++;
        }
    }
    if (var_42bbdeba > 1 && count == 1) {
        return aliveteam;
    }
    return undefined;
}

// Namespace globallogic/globallogic
// Params 0, eflags: 0x0
// Checksum 0x3401ca6, Offset: 0x3378
// Size: 0x1a0
function dodeadeventupdates() {
    if (level.teambased) {
        if (areallteamsdead()) {
            if (isdefined(level.ondeadevent)) {
                [[ level.ondeadevent ]]("all");
            }
            return true;
        }
        if (isdefined(level.ondeadevent)) {
            foreach (team, _ in level.teams) {
                if (isteamalldead(team)) {
                    [[ level.ondeadevent ]](team);
                    return true;
                }
            }
        } else {
            var_718021e5 = function_4f9a4c7f();
            if (isdefined(var_718021e5)) {
                [[ level.onlastteamaliveevent ]](var_718021e5);
                return true;
            }
        }
    } else if (totalalivecount() == 0 && totalplayerlives() == 0 && level.maxplayercount > 1) {
        [[ level.ondeadevent ]]("all");
        return true;
    }
    return false;
}

// Namespace globallogic/globallogic
// Params 1, eflags: 0x0
// Checksum 0xcf46d718, Offset: 0x3520
// Size: 0x58
function isonlyoneleftaliveonteam(team) {
    return level.lastalivecount[team] > 1 && level.alivecount[team] == 1 && level.playerlives[team] == 1;
}

// Namespace globallogic/globallogic
// Params 0, eflags: 0x0
// Checksum 0x82730089, Offset: 0x3580
// Size: 0x110
function doonelefteventupdates() {
    if (level.teambased) {
        foreach (team, _ in level.teams) {
            if (isonlyoneleftaliveonteam(team)) {
                [[ level.ononeleftevent ]](team);
                return true;
            }
        }
    } else if (totalalivecount() == 1 && totalplayerlives() == 1 && level.maxplayercount > 1) {
        [[ level.ononeleftevent ]]("all");
        return true;
    }
    return false;
}

// Namespace globallogic/globallogic
// Params 0, eflags: 0x0
// Checksum 0x81e7d858, Offset: 0x3698
// Size: 0x270
function updategameevents() {
    /#
        if (getdvarint(#"scr_hostmigrationtest", 0) == 1) {
            return;
        }
    #/
    foreach (team, _ in level.teams) {
        player::function_b0782357(team);
    }
    if ((level.rankedmatch || level.leaguematch) && !level.ingraceperiod) {
        if (level.teambased) {
            if (!level.gameforfeited) {
                if (game.state == "playing" && function_c64c7a91()) {
                    return;
                }
            } else if (atleasttwoteams()) {
                level.gameforfeited = 0;
                level notify(#"abort forfeit");
            }
        } else if (!level.gameforfeited) {
            if (util::totalplayercount() == 1 && level.maxplayercount > 1) {
                thread [[ level.onforfeit ]]();
                return;
            }
        } else if (util::totalplayercount() > 1) {
            level.gameforfeited = 0;
            level notify(#"abort forfeit");
        }
    }
    if (!level.playerqueuedrespawn && !level.numlives) {
        return;
    }
    if (level.ingraceperiod) {
        return;
    }
    if (level.playerqueuedrespawn) {
        dospawnqueueupdates();
    }
    if (dodeadeventupdates()) {
        return;
    }
    if (doonelefteventupdates()) {
        return;
    }
}

// Namespace globallogic/globallogic
// Params 0, eflags: 0x0
// Checksum 0xf7b7ccaf, Offset: 0x3910
// Size: 0x80
function mpintro_visionset_ramp_hold_func() {
    level endon(#"mpintro_ramp_out_notify");
    while (true) {
        for (player_index = 0; player_index < level.players.size; player_index++) {
            self visionset_mgr::set_state_active(level.players[player_index], 1);
        }
        waitframe(1);
    }
}

// Namespace globallogic/globallogic
// Params 0, eflags: 0x0
// Checksum 0xa8db6a3b, Offset: 0x3998
// Size: 0x3c
function mpintro_visionset_activate_func() {
    visionset_mgr::activate("visionset", "mpintro", undefined, 0, &mpintro_visionset_ramp_hold_func, 2);
}

// Namespace globallogic/globallogic
// Params 0, eflags: 0x0
// Checksum 0x769257d2, Offset: 0x39e0
// Size: 0x18
function mpintro_visionset_deactivate_func() {
    level notify(#"mpintro_ramp_out_notify");
}

// Namespace globallogic/globallogic
// Params 2, eflags: 0x0
// Checksum 0x45f324f5, Offset: 0x3a00
// Size: 0x180
function showobjectivenotificationuiforallplayers(missiontype, delay) {
    level endon(#"game_ended");
    if (!isdefined(delay) || delay < 2) {
        delay = 2;
    }
    menudelay = getgametypesetting(#"bountypurchasephaseduration");
    if (isdefined(menudelay)) {
        delay += menudelay;
    }
    wait delay;
    foreach (player in level.players) {
        team = player.pers[#"team"];
        if (team === #"spectator") {
            continue;
        }
        hintmessage = util::function_83576051(team);
        if (isdefined(hintmessage)) {
            player luinotifyevent(#"show_gametype_objective_hint", 1, hintmessage);
        }
    }
}

// Namespace globallogic/globallogic
// Params 0, eflags: 0x0
// Checksum 0xc2a61911, Offset: 0x3b88
// Size: 0x2d4
function matchstarttimer() {
    mpintro_visionset_activate_func();
    waitforplayers();
    counttime = int(level.prematchperiod);
    var_8ad39a91 = counttime >= 2;
    luinotifyevent(#"create_prematch_timer", 2, gettime() + int(counttime * 1000), var_8ad39a91);
    if (var_8ad39a91) {
        while (counttime > 0 && !level.gameended) {
            if (counttime == 2) {
                mpintro_visionset_deactivate_func();
            }
            if (counttime == 3) {
                level thread sndsetmatchsnapshot(0);
                foreach (player in level.players) {
                    if (player.hasspawned || player.pers[#"team"] == #"spectator") {
                        player globallogic_audio::set_music_on_player("spawnPreRise");
                    }
                }
            }
            counttime--;
            foreach (player in level.players) {
                if (sessionmodeiswarzonegame()) {
                    player playlocalsound(#"hash_6a97a2aee9eb2f4");
                    continue;
                }
                player playlocalsound(#"uin_start_count_down");
            }
            wait 1;
        }
    } else {
        mpintro_visionset_deactivate_func();
    }
    luinotifyevent(#"prematch_timer_ended", 1, var_8ad39a91);
}

// Namespace globallogic/globallogic
// Params 0, eflags: 0x0
// Checksum 0x1f128a93, Offset: 0x3e68
// Size: 0x1c
function matchstarttimerskip() {
    visionsetnaked("default", 0);
}

// Namespace globallogic/globallogic
// Params 1, eflags: 0x0
// Checksum 0xbfcc887f, Offset: 0x3e90
// Size: 0x34
function sndsetmatchsnapshot(num) {
    waitframe(1);
    level clientfield::set("sndMatchSnapshot", num);
}

// Namespace globallogic/globallogic
// Params 2, eflags: 0x0
// Checksum 0xcf760a2b, Offset: 0x3ed0
// Size: 0x96
function notifyteamwavespawn(team, time) {
    if (time - level.lastwave[team] > int(level.wavedelay[team] * 1000)) {
        level notify("wave_respawn_" + team);
        level.lastwave[team] = time;
        level.waveplayerspawnindex[team] = 0;
    }
}

// Namespace globallogic/globallogic
// Params 0, eflags: 0x0
// Checksum 0xe2a5611f, Offset: 0x3f70
// Size: 0xc2
function wavespawntimer() {
    level endon(#"game_ended");
    while (game.state == "playing") {
        time = gettime();
        foreach (team, _ in level.teams) {
            notifyteamwavespawn(team, time);
        }
        waitframe(1);
    }
}

// Namespace globallogic/globallogic
// Params 0, eflags: 0x0
// Checksum 0xd204d055, Offset: 0x4040
// Size: 0xb4
function hostidledout() {
    hostplayer = util::gethostplayer();
    /#
        if (getdvarint(#"scr_writeconfigstrings", 0) == 1 || getdvarint(#"scr_hostmigrationtest", 0) == 1) {
            return false;
        }
    #/
    if (isdefined(hostplayer) && !hostplayer.hasspawned && !isdefined(hostplayer.selectedclass)) {
        return true;
    }
    return false;
}

// Namespace globallogic/globallogic
// Params 3, eflags: 0x0
// Checksum 0xadae8287, Offset: 0x4100
// Size: 0x5c
function incrementmatchcompletionstat(gamemode, playedorhosted, stat) {
    self stats::inc_stat(#"gamehistory", gamemode, #"modehistory", playedorhosted, stat, 1);
}

// Namespace globallogic/globallogic
// Params 3, eflags: 0x0
// Checksum 0xc28db162, Offset: 0x4168
// Size: 0x5c
function setmatchcompletionstat(gamemode, playedorhosted, stat) {
    self stats::set_stat(#"gamehistory", gamemode, #"modehistory", playedorhosted, stat, 1);
}

// Namespace globallogic/globallogic
// Params 0, eflags: 0x0
// Checksum 0x6b2ee472, Offset: 0x41d0
// Size: 0x14a
function getteamscoreratio() {
    playerteam = self.pers[#"team"];
    score = getteamscore(playerteam);
    otherteamscore = 0;
    foreach (team, _ in level.teams) {
        if (team == playerteam) {
            continue;
        }
        otherteamscore += getteamscore(team);
    }
    if (level.teams.size > 1) {
        otherteamscore /= level.teams.size - 1;
    }
    if (otherteamscore != 0) {
        return (float(score) / float(otherteamscore));
    }
    return score;
}

// Namespace globallogic/globallogic
// Params 0, eflags: 0x0
// Checksum 0xed5d9b09, Offset: 0x4328
// Size: 0x84
function gethighestscore() {
    highestscore = -999999999;
    for (index = 0; index < level.players.size; index++) {
        player = level.players[index];
        if (player.score > highestscore) {
            highestscore = player.score;
        }
    }
    return highestscore;
}

// Namespace globallogic/globallogic
// Params 1, eflags: 0x0
// Checksum 0x5c127ab6, Offset: 0x43b8
// Size: 0xa4
function getnexthighestscore(score) {
    highestscore = -999999999;
    for (index = 0; index < level.players.size; index++) {
        player = level.players[index];
        if (player.score >= score) {
            continue;
        }
        if (player.score > highestscore) {
            highestscore = player.score;
        }
    }
    return highestscore;
}

// Namespace globallogic/globallogic
// Params 0, eflags: 0x0
// Checksum 0xa25f3256, Offset: 0x4468
// Size: 0x3cc
function recordplaystyleinformation() {
    avgkilldistance = 0;
    percenttimemoving = 0;
    avgspeedofplayerwhenmoving = 0;
    totalkilldistances = float(self.pers[#"kill_distances"]);
    numkilldistanceentries = float(self.pers[#"num_kill_distance_entries"]);
    timeplayedmoving = float(self.pers[#"time_played_moving"]);
    timeplayedalive = float(self.pers[#"time_played_alive"]);
    totalspeedswhenmoving = float(self.pers[#"total_speeds_when_moving"]);
    numspeedswhenmovingentries = float(self.pers[#"num_speeds_when_moving_entries"]);
    totaldistancetravelled = float(self.pers[#"total_distance_travelled"]);
    movementupdatecount = float(self.pers[#"movement_update_count"]);
    if (numkilldistanceentries > 0) {
        avgkilldistance = totalkilldistances / numkilldistanceentries;
    }
    movementupdatedenom = int(movementupdatecount / 5);
    if (movementupdatedenom > 0) {
        percenttimemoving = numspeedswhenmovingentries / movementupdatedenom * 100;
    }
    if (numspeedswhenmovingentries > 0) {
        avgspeedofplayerwhenmoving = totalspeedswhenmoving / numspeedswhenmovingentries;
    }
    recordplayerstats(self, "totalKillDistances", totalkilldistances);
    recordplayerstats(self, "numKillDistanceEntries", numkilldistanceentries);
    recordplayerstats(self, "timePlayedMoving", timeplayedmoving);
    recordplayerstats(self, "timePlayedAlive", timeplayedalive);
    recordplayerstats(self, "totalSpeedsWhenMoving", totalspeedswhenmoving);
    recordplayerstats(self, "numSpeedsWhenMovingEntries", numspeedswhenmovingentries);
    recordplayerstats(self, "averageKillDistance", avgkilldistance);
    recordplayerstats(self, "percentageOfTimeMoving", percenttimemoving);
    recordplayerstats(self, "averageSpeedDuringMatch", avgspeedofplayerwhenmoving);
    recordplayerstats(self, "totalDistanceTravelled", totaldistancetravelled);
    mpplaystyles = {#averagekilldistance:avgkilldistance, #percentageoftimemoving:percenttimemoving, #averagespeedduringmatch:avgspeedofplayerwhenmoving};
    function_b1f6086c(#"hash_5cee5eb6de3811d0", mpplaystyles);
}

// Namespace globallogic/globallogic
// Params 0, eflags: 0x0
// Checksum 0xe804de58, Offset: 0x4840
// Size: 0x584
function updateandfinalizematchrecord() {
    /#
        if (getdvarint(#"scr_writeconfigstrings", 0) == 1) {
            return;
        }
    #/
    for (index = 0; index < level.players.size; index++) {
        player = level.players[index];
        player player_record::record_special_move_data_for_life(undefined);
        if (isbot(player)) {
            continue;
        }
        player player_record::record_global_mp_stats_for_player_at_match_end();
        nemesis = player.pers[#"nemesis_name"];
        if (!isdefined(player.pers[#"killed_players"][nemesis])) {
            player.pers[#"killed_players"][nemesis] = 0;
        }
        if (!isdefined(player.pers[#"killed_by"][nemesis])) {
            player.pers[#"killed_by"][nemesis] = 0;
        }
        spread = player.kills - player.deaths;
        if (player.pers[#"cur_kill_streak"] > player.pers[#"best_kill_streak"]) {
            player.pers[#"best_kill_streak"] = player.pers[#"cur_kill_streak"];
        }
        if (level.onlinegame) {
            teamscoreratio = player getteamscoreratio();
            scoreboardposition = getplacementforplayer(player);
            if (scoreboardposition < 0) {
                scoreboardposition = level.players.size;
            }
            player gamehistoryfinishmatch(4, player.kills, player.deaths, player.score, scoreboardposition, teamscoreratio);
            placement = level.placement[#"all"];
            for (otherplayerindex = 0; otherplayerindex < placement.size; otherplayerindex++) {
                if (level.placement[#"all"][otherplayerindex] == player) {
                    recordplayerstats(player, "position", otherplayerindex);
                }
            }
            if (isdefined(player.pers[#"matchesplayedstatstracked"])) {
                gamemode = util::getcurrentgamemode();
                player incrementmatchcompletionstat(gamemode, "played", "completed");
                if (isdefined(player.pers[#"matcheshostedstatstracked"])) {
                    player incrementmatchcompletionstat(gamemode, "hosted", "completed");
                    player.pers[#"matcheshostedstatstracked"] = undefined;
                }
                player.pers[#"matchesplayedstatstracked"] = undefined;
            }
            recordplayerstats(player, "highestKillStreak", player.pers[#"best_kill_streak"]);
            recordplayerstats(player, "numUavCalled", player killstreaks::get_killstreak_usage("uav_used"));
            recordplayerstats(player, "numDogsCalleD", player killstreaks::get_killstreak_usage("dogs_used"));
            recordplayerstats(player, "numDogsKills", player.pers[#"dog_kills"]);
            player recordplaystyleinformation();
            recordplayermatchend(player);
            function_8670f0f2(player);
            recordplayerstats(player, "present_at_end", 1);
        }
    }
    finalizematchrecord();
}

// Namespace globallogic/globallogic
// Params 1, eflags: 0x0
// Checksum 0x3f51539f, Offset: 0x4dd0
// Size: 0xc0
function function_8670f0f2(player) {
    if (isdefined(player.pers[#"scoreeventcache"])) {
        foreach (event, count in player.pers[#"scoreeventcache"]) {
            function_82da7483(player, event, count);
        }
    }
}

// Namespace globallogic/globallogic
// Params 0, eflags: 0x0
// Checksum 0x5c8b91ed, Offset: 0x4e98
// Size: 0x1c2
function gamehistoryplayerkicked() {
    teamscoreratio = self getteamscoreratio();
    scoreboardposition = getplacementforplayer(self);
    if (scoreboardposition < 0) {
        scoreboardposition = level.players.size;
    }
    /#
        assert(isdefined(self.kills));
        assert(isdefined(self.deaths));
        assert(isdefined(self.score));
        assert(isdefined(scoreboardposition));
        assert(isdefined(teamscoreratio));
    #/
    self gamehistoryfinishmatch(2, self.kills, self.deaths, self.score, scoreboardposition, teamscoreratio);
    if (isdefined(self.pers[#"matchesplayedstatstracked"])) {
        gamemode = util::getcurrentgamemode();
        self incrementmatchcompletionstat(gamemode, "played", "kicked");
        self.pers[#"matchesplayedstatstracked"] = undefined;
    }
    uploadstats(self);
    wait 1;
}

// Namespace globallogic/globallogic
// Params 0, eflags: 0x0
// Checksum 0x21bd865c, Offset: 0x5068
// Size: 0x1a4
function gamehistoryplayerquit() {
    teamscoreratio = self getteamscoreratio();
    scoreboardposition = getplacementforplayer(self);
    if (scoreboardposition < 0) {
        scoreboardposition = level.players.size;
    }
    self gamehistoryfinishmatch(3, self.kills, self.deaths, self.score, scoreboardposition, teamscoreratio);
    if (isdefined(self.pers[#"matchesplayedstatstracked"])) {
        gamemode = util::getcurrentgamemode();
        self incrementmatchcompletionstat(gamemode, "played", "quit");
        if (isdefined(self.pers[#"matcheshostedstatstracked"])) {
            self incrementmatchcompletionstat(gamemode, "hosted", "quit");
            self.pers[#"matcheshostedstatstracked"] = undefined;
        }
        self.pers[#"matchesplayedstatstracked"] = undefined;
    }
    uploadstats(self);
    if (!self ishost()) {
        wait 1;
    }
}

// Namespace globallogic/globallogic
// Params 1, eflags: 0x0
// Checksum 0xeaba71cc, Offset: 0x5218
// Size: 0x104
function function_5e3b7db7(outcome) {
    if (level.teambased) {
        if (outcome::get_flag(outcome, "tie") || !isdefined(outcome::get_winning_team(outcome))) {
            demo::function_dc6e0ae8(#"game_result", level.teamindex[#"neutral"], level.teamindex[#"neutral"]);
            return;
        }
        demo::function_dc6e0ae8(#"game_result", level.teamindex[outcome::get_winning_team(outcome)], level.teamindex[#"neutral"]);
    }
}

// Namespace globallogic/globallogic
// Params 0, eflags: 0x0
// Checksum 0x23ef22a0, Offset: 0x5328
// Size: 0xb4
function function_f3dd26cb() {
    bb::function_deb9127a(match::function_fa0cfd68());
    mpmatchfacts = {#gametime:function_25e96038(), #winner:match::get_winner(), #killstreakcount:level.globalkillstreakscalled};
    function_b1f6086c(#"hash_7784f98b4b9750ec", mpmatchfacts);
}

// Namespace globallogic/globallogic
// Params 0, eflags: 0x0
// Checksum 0x444626a4, Offset: 0x53e8
// Size: 0xa6
function function_18a44ba4() {
    if (util::hitroundlimit() || util::hitroundwinlimit()) {
        return 5;
    } else if (util::hitscorelimit()) {
        return 3;
    } else if (util::hitroundscorelimit()) {
        return 4;
    }
    if (level.forcedend) {
        if (level.hostforcedend) {
            return 9;
        } else {
            return 8;
        }
    }
    return "time limit";
}

// Namespace globallogic/globallogic
// Params 0, eflags: 0x0
// Checksum 0xa44a5326, Offset: 0x5498
// Size: 0x11c
function function_e10d8d2e() {
    setmatchtalkflag("DeadChatWithDead", level.voip.deadchatwithdead);
    setmatchtalkflag("DeadChatWithTeam", level.voip.deadchatwithteam);
    setmatchtalkflag("DeadHearTeamLiving", level.voip.deadhearteamliving);
    setmatchtalkflag("DeadHearAllLiving", level.voip.deadhearallliving);
    setmatchtalkflag("EveryoneHearsEveryone", level.voip.everyonehearseveryone);
    setmatchtalkflag("DeadHearKiller", level.voip.deadhearkiller);
    setmatchtalkflag("KillersHearVictim", level.voip.killershearvictim);
}

// Namespace globallogic/globallogic
// Params 0, eflags: 0x0
// Checksum 0xebd88d82, Offset: 0x55c0
// Size: 0x124
function function_4b0a326c() {
    if (!is_game_over()) {
        if (isdefined(level.nextroundisovertime) && level.nextroundisovertime) {
            game.overtime_round++;
        }
        player::function_15b6b25d(&val::reset, "freeze_player_for_round_end", "freezecontrols");
        player::function_15b6b25d(&val::reset, "freeze_player_for_round_end", "disablegadgets");
        player::function_15b6b25d(&clientfield::set_player_uimodel, "hudItems.hideOutcomeUI", 1);
        function_e10d8d2e();
        function_f7f33c6d();
        game.state = "pregame";
        map_restart(1);
        return true;
    }
    return false;
}

// Namespace globallogic/globallogic
// Params 1, eflags: 0x0
// Checksum 0x34163316, Offset: 0x56f0
// Size: 0x68
function function_193bf9a3(winner) {
    if (!isdefined(winner)) {
        return "tie";
    }
    if (isentity(winner)) {
        return (isdefined(winner.team) ? winner.team : #"none");
    }
    return winner;
}

// Namespace globallogic/globallogic
// Params 0, eflags: 0x0
// Checksum 0xa3fe12e3, Offset: 0x5760
// Size: 0x98
function getroundlength() {
    if (!level.timelimit || level.forcedend) {
        gamelength = float(globallogic_utils::gettimepassed()) / 1000;
        gamelength = min(gamelength, 1200);
    } else {
        gamelength = level.timelimit * 60;
    }
    return gamelength;
}

// Namespace globallogic/globallogic
// Params 2, eflags: 0x0
// Checksum 0x86aacb78, Offset: 0x5800
// Size: 0x44
function waitanduploadstats(player, waittime) {
    wait waittime;
    if (isplayer(player)) {
        uploadstats(player);
    }
}

// Namespace globallogic/globallogic
// Params 1, eflags: 0x0
// Checksum 0xcbe989c5, Offset: 0x5850
// Size: 0xaa
function registerotherlootxpawards(func) {
    if (!isdefined(level.awardotherlootxpfunctions)) {
        level.awardotherlootxpfunctions = [];
    }
    if (!isdefined(level.awardotherlootxpfunctions)) {
        level.awardotherlootxpfunctions = [];
    } else if (!isarray(level.awardotherlootxpfunctions)) {
        level.awardotherlootxpfunctions = array(level.awardotherlootxpfunctions);
    }
    level.awardotherlootxpfunctions[level.awardotherlootxpfunctions.size] = func;
}

// Namespace globallogic/globallogic
// Params 0, eflags: 0x0
// Checksum 0xdbb30feb, Offset: 0x5908
// Size: 0xda
function awardotherlootxp() {
    player = self;
    if (!isdefined(level.awardotherlootxpfunctions)) {
        return 0;
    }
    if (!isplayer(player)) {
        return 0;
    }
    lootxp = 0;
    foreach (func in level.awardotherlootxpfunctions) {
        if (!isdefined(func)) {
            continue;
        }
        lootxp += player [[ func ]]();
    }
    return lootxp;
}

// Namespace globallogic/globallogic
// Params 1, eflags: 0x4
// Checksum 0x77a92839, Offset: 0x59f0
// Size: 0x274
function private function_658289a2(var_c3d87d03) {
    updateplacement();
    function_78d6b4c3();
    roundlength = getroundlength();
    survey_id = function_2516bb7c();
    current_time = gettime();
    game_over = is_game_over();
    players = level.players;
    foreach (player in players) {
        /#
            player globallogic_ui::freegameplayhudelems();
        #/
        player.pers[#"lastroundscore"] = player.pointstowin;
        player weapons::update_timings(current_time);
        player bbplayermatchend(roundlength, var_c3d87d03, game_over);
        player.pers[#"totaltimeplayed"] = player.pers[#"totaltimeplayed"] + player.timeplayed[#"total"];
        player stats::function_d7e9dd79("surveyId", survey_id);
        player stats::function_d7e9dd79("hardcore", level.hardcoremode);
    }
    userspawnselection::closespawnselectionmenuforallplayers();
    player::function_15b6b25d(&function_5d59ee1e);
    if (!util::waslastround()) {
        player::function_94273df5("round_ended");
    }
}

// Namespace globallogic/globallogic
// Params 0, eflags: 0x4
// Checksum 0xca26c774, Offset: 0x5c70
// Size: 0x38
function private is_game_over() {
    if (util::isoneround() || util::waslastround()) {
        return true;
    }
    return false;
}

// Namespace globallogic/globallogic
// Params 0, eflags: 0x4
// Checksum 0xbb1a55a7, Offset: 0x5cb0
// Size: 0x7e
function private function_2516bb7c() {
    if (randomfloat(1) <= getdvarfloat(#"survey_chance", 0)) {
        return randomintrange(1, getdvarint(#"survey_count", 0) + 1);
    }
    return 0;
}

// Namespace globallogic/globallogic
// Params 0, eflags: 0x4
// Checksum 0x52910cbc, Offset: 0x5d38
// Size: 0x92
function private function_5594c7bc() {
    winning_team = round::get_winning_team();
    winner = round::get_winner();
    if (isdefined(winner) && isdefined(level.teams[winning_team])) {
        level.finalkillcam_winner = winner;
    } else {
        level.finalkillcam_winner = "none";
    }
    level.finalkillcam_winnerpicked = 1;
}

// Namespace globallogic/globallogic
// Params 0, eflags: 0x4
// Checksum 0x25ded97e, Offset: 0x5dd8
// Size: 0x124
function private function_85112cc1() {
    winning_team = round::get_winning_team();
    overtime_round = round::get_flag("overtime");
    if (overtime_round) {
        if (isdefined(game.stat[#"overtimeroundswon"][winning_team])) {
            game.stat[#"overtimeroundswon"][winning_team]++;
        }
    }
    if (!overtime_round || util::waslastround()) {
        game.roundsplayed++;
        game.roundwinner[game.roundsplayed] = round::get_winner();
        if (isdefined(game.stat[#"roundswon"][winning_team])) {
            game.stat[#"roundswon"][winning_team]++;
        }
    }
}

// Namespace globallogic/globallogic
// Params 0, eflags: 0x4
// Checksum 0x87a005c9, Offset: 0x5f08
// Size: 0xa2
function private function_61c56119() {
    result = #"draw";
    if (!match::get_flag("tie") && match::function_c6c8145e()) {
        result = match::get_winning_team();
    }
    if (result == "tie" || result == "free") {
        result = #"draw";
    }
    return result;
}

// Namespace globallogic/globallogic
// Params 1, eflags: 0x4
// Checksum 0x4fed7e54, Offset: 0x5fb8
// Size: 0xcc
function private function_acf25ccb(var_c3d87d03) {
    setmatchflag("game_ended", 1);
    gamestate::set_state("postgame");
    level.gameendtime = gettime();
    level.gameended = 1;
    level.var_a033439c.roundend = gettime();
    setdvar(#"g_gameended", 1);
    round::function_b14d882c(var_c3d87d03);
    /#
        rat::function_62053ec9();
    #/
}

// Namespace globallogic/globallogic
// Params 0, eflags: 0x4
// Checksum 0xd173efd6, Offset: 0x6090
// Size: 0x4e
function private function_78d6b4c3() {
    if (!is_game_over()) {
        game_winner = round::get_winner();
        return;
    }
    game_winner = match::function_81e31796();
}

// Namespace globallogic/globallogic
// Params 0, eflags: 0x0
// Checksum 0xd77e92f0, Offset: 0x60e8
// Size: 0x94
function function_6a0eb307() {
    callback::function_a8a0e3ff(#"on_end_game");
    callback::function_569d2199(#"on_end_game");
    level notify(#"game_ended");
    level clientfield::set("gameplay_started", 0);
    level clientfield::set("game_ended", 1);
}

// Namespace globallogic/globallogic
// Params 1, eflags: 0x4
// Checksum 0xb52ca5d6, Offset: 0x6188
// Size: 0x264
function private function_d65b7e1d(outcome) {
    level.ingraceperiod = 0;
    function_6a0eb307();
    if (!isdefined(level.disableoutrovisionset) || level.disableoutrovisionset == 0) {
        visionsetnaked("mpOutro", 2);
    }
    setmatchflag("cg_drawSpectatorMessages", 0);
    globallogic_audio::flush_dialog();
    foreach (team, _ in level.teams) {
        game.lastroundscore[team] = getteamscore(team);
    }
    if (util::isroundbased()) {
        matchrecordroundend();
    }
    function_85112cc1();
    function_5594c7bc();
    thread setroundswonuimodels();
    setgameendtime(0);
    updaterankedmatch(outcome);
    setmatchtalkflag("EveryoneHearsEveryone", 1);
    gamerep::gamerepupdateinformationforround();
    thread challenges::roundend(round::get_winner());
    function_658289a2(outcome.var_c3d87d03);
    gameobjects::function_b3676c5c();
    globallogic_utils::function_f44aa11d(outcome.var_c3d87d03);
    function_5e3b7db7(outcome);
}

// Namespace globallogic/globallogic
// Params 1, eflags: 0x0
// Checksum 0x312b8ea, Offset: 0x63f8
// Size: 0x6c
function function_e453737c(var_e8709981) {
    level.var_74db4b88 = 0.25;
    level.var_a847f5b1 = level.roundenddelay[var_e8709981] / 4;
    setslowmotion(1, level.var_74db4b88, level.var_a847f5b1);
}

// Namespace globallogic/globallogic
// Params 3, eflags: 0x0
// Checksum 0x5e0aa072, Offset: 0x6470
// Size: 0x44
function function_c81eabc3(scale_start, scale_end, transition_time) {
    level.var_74db4b88 = scale_end;
    setslowmotion(scale_start, scale_end, transition_time);
}

// Namespace globallogic/globallogic
// Params 0, eflags: 0x0
// Checksum 0x677bffac, Offset: 0x64c0
// Size: 0x3c
function function_f7f33c6d() {
    level.var_74db4b88 = 1;
    setslowmotion(1, 1, 0);
}

// Namespace globallogic/globallogic
// Params 1, eflags: 0x0
// Checksum 0x8f2c9f2d, Offset: 0x6508
// Size: 0x1e
function function_560d398c(var_c3d87d03) {
    switch (var_c3d87d03) {
    case 0:
    case 9:
    case 10:
        return false;
    default:
        return true;
    }
}

// Namespace globallogic/globallogic
// Params 2, eflags: 0x0
// Checksum 0xdf17522f, Offset: 0x6580
// Size: 0x94
function function_e0994b4(winning_team, var_c3d87d03) {
    assert(isdefined(winning_team));
    if (function_560d398c(var_c3d87d03)) {
        globallogic_score::giveteamscoreforobjective_delaypostprocessing(winning_team, 1);
    }
    round::set_winner(winning_team);
    thread end_round(var_c3d87d03);
}

// Namespace globallogic/globallogic
// Params 0, eflags: 0x0
// Checksum 0x2229fb7e, Offset: 0x6620
// Size: 0x4c
function function_607ebdc5() {
    if (level.teambased) {
        function_e0994b4(game.defenders, 2);
        return;
    }
    end_round(2);
}

// Namespace globallogic/globallogic
// Params 0, eflags: 0x0
// Checksum 0x32253ef8, Offset: 0x6678
// Size: 0x44
function function_17e1fcf8() {
    if (level.teambased) {
        round::set_winner(game.defenders);
    }
    end_round(2);
}

// Namespace globallogic/globallogic
// Params 0, eflags: 0x0
// Checksum 0xacafc125, Offset: 0x66c8
// Size: 0x46
function function_b77980b5() {
    if (isalive(self)) {
        self.deathtime = 0;
        self.pers[#"deathtime"] = 0;
    }
}

// Namespace globallogic/globallogic
// Params 1, eflags: 0x0
// Checksum 0xccf90a6e, Offset: 0x6718
// Size: 0x144
function end_round(var_c3d87d03) {
    if (gamestate::is_game_over() || level.gameended) {
        return;
    }
    player::function_15b6b25d(&function_b77980b5);
    function_acf25ccb(var_c3d87d03);
    level clientfield::set_world_uimodel("hudItems.specialistSwitchIsLethal", 0);
    if (isdefined(level.onendround)) {
        [[ level.onendround ]](var_c3d87d03);
    }
    outcome = hud_message::function_75c92765(1, var_c3d87d03, 0, round::function_35b54582());
    function_d65b7e1d(outcome);
    overtime::function_d699aea2();
    display_transition::display_round_end(outcome);
    if (!function_4b0a326c()) {
        function_6226af1c();
    }
}

// Namespace globallogic/globallogic
// Params 0, eflags: 0x4
// Checksum 0xcf7d1bb2, Offset: 0x6868
// Size: 0x64
function private function_87a8327c() {
    if (util::isoneround()) {
        var_c3d87d03 = round::function_fa0cfd68();
    } else {
        var_c3d87d03 = function_18a44ba4();
    }
    match::function_b14d882c(var_c3d87d03);
}

// Namespace globallogic/globallogic
// Params 0, eflags: 0x4
// Checksum 0xa2f2425d, Offset: 0x68d8
// Size: 0x224
function private function_a7ba160a() {
    var_6c588152 = [];
    foreach (vehicle in level.var_251a5eb0) {
        if (!isdefined(vehicle)) {
            continue;
        }
        data = {#pos_x:vehicle.origin[0], #pos_y:vehicle.origin[1], #pos_z:vehicle.origin[2], #type:vehicle.vehicletype, #used:isdefined(vehicle.used) && vehicle.used};
        if (!isdefined(var_6c588152)) {
            var_6c588152 = [];
        } else if (!isarray(var_6c588152)) {
            var_6c588152 = array(var_6c588152);
        }
        var_6c588152[var_6c588152.size] = data;
        if (var_6c588152.size >= 100) {
            function_b1f6086c(#"hash_55f923de6ff3632b", #"entries", var_6c588152);
            var_6c588152 = [];
            util::wait_network_frame(1);
        }
    }
    if (var_6c588152.size > 0) {
        function_b1f6086c(#"hash_55f923de6ff3632b", #"entries", var_6c588152);
    }
}

// Namespace globallogic/globallogic
// Params 0, eflags: 0x4
// Checksum 0x603b4d24, Offset: 0x6b08
// Size: 0x204
function private function_d35ffb80() {
    var_a48a5cff = [];
    foreach (stash in level.item_spawn_stashes) {
        state = function_7f51b166(stash);
        data = {#pos_x:stash.origin[0], #pos_y:stash.origin[1], #pos_z:stash.origin[2], #used:state != 0};
        if (!isdefined(var_a48a5cff)) {
            var_a48a5cff = [];
        } else if (!isarray(var_a48a5cff)) {
            var_a48a5cff = array(var_a48a5cff);
        }
        var_a48a5cff[var_a48a5cff.size] = data;
        if (var_a48a5cff.size >= 100) {
            function_b1f6086c(#"hash_7cd6488eb92cb736", #"entries", var_a48a5cff);
            var_a48a5cff = [];
            util::wait_network_frame(1);
        }
    }
    if (var_a48a5cff.size > 0) {
        function_b1f6086c(#"hash_7cd6488eb92cb736", #"entries", var_a48a5cff);
    }
}

// Namespace globallogic/globallogic
// Params 0, eflags: 0x4
// Checksum 0x982529e8, Offset: 0x6d18
// Size: 0x83c
function private function_a4f76e67() {
    itemcount = function_6a1c8e6f();
    summary = [];
    var_ffd9b87e = [];
    for (i = 0; i < itemcount; i++) {
        item = function_9c3c6ff2(i);
        if (!isdefined(summary[item.targetname])) {
            summary[item.targetname] = {};
        }
        if (isdefined(item.itementry)) {
            if (!isdefined(summary[item.targetname].itemtypes)) {
                summary[item.targetname].itemtypes = [];
            }
            if (!isdefined(summary[item.targetname].itemtypes[item.itementry.itemtype])) {
                summary[item.targetname].itemtypes[item.itementry.itemtype] = {};
            }
            if (!isdefined(summary[item.targetname].itemtypes[item.itementry.itemtype].items)) {
                summary[item.targetname].itemtypes[item.itementry.itemtype].items = [];
            }
            if (!isdefined(summary[item.targetname].itemtypes[item.itementry.itemtype].items[item.itementry.name])) {
                summary[item.targetname].itemtypes[item.itementry.itemtype].items[item.itementry.name] = {};
            }
            if (!isdefined(summary[item.targetname].itemtypes[item.itementry.itemtype].items[item.itementry.name].count)) {
                summary[item.targetname].itemtypes[item.itementry.itemtype].items[item.itementry.name].count = 0;
            }
            summary[item.targetname].itemtypes[item.itementry.itemtype].items[item.itementry.name].count = summary[item.targetname].itemtypes[item.itementry.itemtype].items[item.itementry.name].count + 1;
            summary[item.targetname].itemtypes[item.itementry.itemtype].items[item.itementry.name].rarity = hash(item.itementry.rarity);
        } else {
            if (!isdefined(var_ffd9b87e[item.targetname])) {
                var_ffd9b87e[item.targetname] = {};
            }
            if (!isdefined(var_ffd9b87e[item.targetname].count)) {
                var_ffd9b87e[item.targetname].count = 0;
            }
            var_ffd9b87e[item.targetname].count = var_ffd9b87e[item.targetname].count + 1;
        }
    }
    util::wait_network_frame(1);
    item_data = [];
    foreach (location_name, location in summary) {
        if (isdefined(location.itemtypes)) {
            foreach (category_name, category in location.itemtypes) {
                if (isdefined(category.items)) {
                    foreach (item_name, item in category.items) {
                        data = {#location:location_name, #category:category_name, #item:item_name, #rarity:item.rarity, #count:item.count};
                        if (!isdefined(item_data)) {
                            item_data = [];
                        } else if (!isarray(item_data)) {
                            item_data = array(item_data);
                        }
                        item_data[item_data.size] = data;
                        if (item_data.size >= 100) {
                            var_dd4bc436 = {#seed:level.item_spawn_seed, #event_count:item_data.size};
                            function_b1f6086c(#"hash_67dcbe8b30edd15a", #"summary", var_dd4bc436, #"entries", item_data);
                            item_data = [];
                            util::wait_network_frame(1);
                        }
                    }
                }
            }
        }
    }
    if (item_data.size > 0) {
        var_dd4bc436 = {#seed:level.item_spawn_seed, #event_count:item_data.size};
        function_b1f6086c(#"hash_67dcbe8b30edd15a", #"summary", var_dd4bc436, #"entries", item_data);
    }
}

// Namespace globallogic/globallogic
// Params 0, eflags: 0x4
// Checksum 0x40504cb2, Offset: 0x7560
// Size: 0x7c
function private function_68d747cd() {
    function_a7ba160a();
    util::wait_network_frame(1);
    function_d35ffb80();
    util::wait_network_frame(1);
    function_a4f76e67();
    util::wait_network_frame(1);
}

// Namespace globallogic/globallogic
// Params 0, eflags: 0x4
// Checksum 0x3191de35, Offset: 0x75e8
// Size: 0xec
function private function_f7176ca0() {
    result = function_61c56119();
    recordgameresult(result);
    player::function_15b6b25d(&player_record::function_9c92813d, result);
    player::function_15b6b25d(&player_record::record_misc_player_stats);
    skillupdate();
    if (sessionmodeiswarzonegame()) {
        thread function_68d747cd();
    }
    winner = match::get_winner();
    thread challenges::gameend(winner);
    function_f3dd26cb();
}

// Namespace globallogic/globallogic
// Params 0, eflags: 0x4
// Checksum 0x10f2cb3f, Offset: 0x76e0
// Size: 0x44
function private function_5d59ee1e() {
    self setclientuivisibilityflag("hud_visible", 0);
    self setclientuivisibilityflag("g_compassShowEnemies", 0);
}

// Namespace globallogic/globallogic
// Params 0, eflags: 0x4
// Checksum 0x63e17126, Offset: 0x7730
// Size: 0x7c
function private function_574def33() {
    setmatchtalkflag("EveryoneHearsEveryone", 1);
    setmatchflag("cg_drawSpectatorMessages", 0);
    util::setclientsysstate("levelNotify", "streamFKsl");
    player::function_15b6b25d(&function_5d59ee1e);
}

// Namespace globallogic/globallogic
// Params 0, eflags: 0x4
// Checksum 0xfa0c8c1d, Offset: 0x77b8
// Size: 0x42
function private function_9b8ef560() {
    return hud_message::function_75c92765(1, match::function_fa0cfd68(), 1, match::function_35b54582());
}

// Namespace globallogic/globallogic
// Params 1, eflags: 0x4
// Checksum 0x45917441, Offset: 0x7808
// Size: 0x34
function private function_123a7bdb(outcome) {
    stopdemorecording();
    function_5e3b7db7(outcome);
}

// Namespace globallogic/globallogic
// Params 0, eflags: 0x4
// Checksum 0x1ed0d88b, Offset: 0x7848
// Size: 0x44
function private player_end_game() {
    self thread [[ level.spawnintermission ]](0, level.usexcamsforendgame);
    self setclientuivisibilityflag("hud_visible", 1);
}

// Namespace globallogic/globallogic
// Params 0, eflags: 0x4
// Checksum 0x84d72632, Offset: 0x7898
// Size: 0x6c
function private function_20d1c38a() {
    level.intermission = 1;
    level notify(#"endgame_intermission");
    player::function_15b6b25d(&player_end_game);
    level clientfield::set("post_game", 1);
}

// Namespace globallogic/globallogic
// Params 1, eflags: 0x0
// Checksum 0x25c5baf3, Offset: 0x7910
// Size: 0x88
function getplayerbyname(name) {
    for (index = 0; index < level.players.size; index++) {
        player = level.players[index];
        if (isbot(player)) {
            continue;
        }
        if (player.name == name) {
            return player;
        }
    }
}

// Namespace globallogic/globallogic
// Params 0, eflags: 0x0
// Checksum 0x3667f0cf, Offset: 0x79a0
// Size: 0x154
function function_9af3c191() {
    foreach (team, _ in level.teams) {
        if (level.everexisted[team]) {
            teamranking = isdefined(level.var_51eea74b[team]) ? level.var_51eea74b[team] : 1;
            players = getplayers(team);
            foreach (player in players) {
                player luinotifyevent(#"team_eliminated", 1, teamranking);
            }
        }
    }
}

// Namespace globallogic/globallogic
// Params 0, eflags: 0x0
// Checksum 0xd4de83e3, Offset: 0x7b00
// Size: 0x1ee
function function_62ff6bbc() {
    for (index = 0; index < level.players.size; index++) {
        player = level.players[index];
        if (isbot(player)) {
            continue;
        }
        playerclientnum = player getentitynumber();
        var_7340ccc9 = 0;
        for (j = 0; j < level.players.size; j++) {
            if (index == j) {
                continue;
            }
            notplayer = level.players[j];
            if (player.team != notplayer.team) {
                var_e9952a3a = notplayer getentitynumber();
                killed = notplayer.pers[#"killed_by"][player.name];
                killedby = notplayer.pers[#"killed_players"][player.name];
                if (!isdefined(killed)) {
                    killed = 0;
                }
                if (!isdefined(killedby)) {
                    killedby = 0;
                }
                player luinotifyevent(#"hash_9ab42b593c66ed", 5, playerclientnum, var_7340ccc9, var_e9952a3a, killed, killedby);
                var_7340ccc9++;
            }
        }
    }
}

// Namespace globallogic/globallogic
// Params 0, eflags: 0x0
// Checksum 0xd7c7a8e1, Offset: 0x7cf8
// Size: 0x4e6
function sendafteractionreport() {
    /#
        if (getdvarint(#"scr_writeconfigstrings", 0) == 1) {
            return;
        }
    #/
    for (index = 0; index < level.players.size; index++) {
        player = level.players[index];
        if (isbot(player)) {
            continue;
        }
        player player_record::function_a7b47dbc();
        nemesis = player.pers[#"nemesis_name"];
        assert(isdefined(nemesis), "<dev string:x34>" + player.name);
        assert(isstring(nemesis), "<dev string:x55>" + nemesis + "<dev string:x5e>" + player.name);
        if (!isdefined(player.pers[#"killed_players"][nemesis])) {
            player.pers[#"killed_players"][nemesis] = 0;
        }
        if (!isdefined(player.pers[#"killed_by"][nemesis])) {
            player.pers[#"killed_by"][nemesis] = 0;
        }
        spread = player.kills - player.deaths;
        if (player.pers[#"cur_kill_streak"] > player.pers[#"best_kill_streak"]) {
            player.pers[#"best_kill_streak"] = player.pers[#"cur_kill_streak"];
        }
        if (level.rankedmatch || level.leaguematch) {
            player stats::function_d7e9dd79(#"privatematch", 0);
        } else {
            player stats::function_d7e9dd79(#"privatematch", 1);
        }
        player setnemesisxuid(player.pers[#"nemesis_xuid"]);
        player stats::function_d7e9dd79(#"valid", 1);
        player stats::function_d7e9dd79(#"nemesisname", nemesis);
        player stats::function_d7e9dd79(#"nemesisrank", player.pers[#"nemesis_rank"]);
        player stats::function_d7e9dd79(#"nemesisrankicon", player.pers[#"nemesis_rankicon"]);
        player stats::function_d7e9dd79(#"nemesiskills", player.pers[#"killed_players"][nemesis]);
        player stats::function_d7e9dd79(#"nemesiskilledby", player.pers[#"killed_by"][nemesis]);
        nemesisplayerent = getplayerbyname(nemesis);
        if (isdefined(nemesisplayerent)) {
            player stats::function_d7e9dd79(#"nemesisheroindex", nemesisplayerent getcharacterbodytype());
        }
        clientnum = player getentitynumber();
        player stats::function_d7e9dd79(#"clientnum", clientnum);
    }
}

// Namespace globallogic/globallogic
// Params 0, eflags: 0x4
// Checksum 0x4f189a0c, Offset: 0x81e8
// Size: 0x5c
function private function_a14c0d4b() {
    util::preload_frontend();
    gamerep::gamerepanalyzeandreport();
    wait 1;
    thread sendafteractionreport();
    thread function_62ff6bbc();
    thread function_9af3c191();
}

// Namespace globallogic/globallogic
// Params 0, eflags: 0x4
// Checksum 0xd7847153, Offset: 0x8250
// Size: 0x1b4
function private function_6226af1c() {
    function_87a8327c();
    hvo::function_73ea84a3();
    [[ level.onendgame ]](match::function_fa0cfd68());
    globallogic_score::updatewinlossstats();
    if (level.arenamatch) {
        arena::match_end();
    }
    function_f7176ca0();
    function_574def33();
    outcome = function_9b8ef560();
    level notify(#"give_match_bonus");
    thread function_a14c0d4b();
    if (!isdefined(level.skipgameend) || !level.skipgameend) {
        display_transition::function_76bbac9d(outcome);
    }
    function_123a7bdb(outcome);
    if (util::isoneround() && !display_transition::function_7ba795bd()) {
        globallogic_utils::executepostroundevents();
    }
    function_20d1c38a();
    level notify(#"sfade");
    updateandfinalizematchrecord();
    exit_level();
}

// Namespace globallogic/globallogic
// Params 0, eflags: 0x0
// Checksum 0x28925e84, Offset: 0x8410
// Size: 0x34
function exit_level() {
    if (level.exitlevel) {
        return;
    }
    level.exitlevel = 1;
    exitlevel(0);
}

// Namespace globallogic/globallogic
// Params 1, eflags: 0x0
// Checksum 0x1a5c1b1a, Offset: 0x8450
// Size: 0x70
function gettotaltimeplayed(maxlength) {
    totaltimeplayed = 0;
    if (isdefined(self.pers[#"totaltimeplayed"])) {
        totaltimeplayed = self.pers[#"totaltimeplayed"];
        if (totaltimeplayed > maxlength) {
            totaltimeplayed = maxlength;
        }
    }
    return totaltimeplayed;
}

// Namespace globallogic/globallogic
// Params 1, eflags: 0x0
// Checksum 0x6ae56116, Offset: 0x84c8
// Size: 0x78
function getroundtimeplayed(roundlength) {
    totaltimeplayed = 0;
    if (isdefined(self.timeplayed) && isdefined(self.timeplayed[#"total"])) {
        totaltimeplayed = self.timeplayed[#"total"];
        if (totaltimeplayed > roundlength) {
            totaltimeplayed = roundlength;
        }
    }
    return totaltimeplayed;
}

// Namespace globallogic/globallogic
// Params 3, eflags: 0x0
// Checksum 0xbe79ce56, Offset: 0x8548
// Size: 0x1a4
function bbplayermatchend(gamelength, var_c3d87d03, gameover) {
    playerrank = getplacementforplayer(self);
    totaltimeplayed = self getroundtimeplayed(gamelength);
    xuid = self getxuid();
    mpplayermatchfacts = {#score:self.pers[#"score"], #momentum:self.pers[#"momentum"], #endreason:var_c3d87d03, #sessionrank:playerrank, #playtime:int(totaltimeplayed), #xuid:xuid, #gameover:gameover, #team:self.team, #specialist:self getspecialistindex()};
    function_b1f6086c(#"hash_7c173cd9201d5271", mpplayermatchfacts);
}

// Namespace globallogic/globallogic
// Params 0, eflags: 0x0
// Checksum 0x3fd7ee7d, Offset: 0x86f8
// Size: 0x24
function roundenddof() {
    self clientfield::set_to_player("player_dof_settings", 2);
}

// Namespace globallogic/globallogic
// Params 0, eflags: 0x0
// Checksum 0x90088a42, Offset: 0x8728
// Size: 0x178
function checktimelimit() {
    if (isdefined(level.timelimitoverride) && level.timelimitoverride) {
        return;
    }
    if (gamestate::is_game_over()) {
        setgameendtime(0);
        return;
    }
    if (level.timelimit <= 0) {
        setgameendtime(0);
        return;
    }
    if (isdefined(level.timerpaused) && level.timerpaused) {
        timeremaining = globallogic_utils::gettimeremaining();
        setgameendtime(int(timeremaining) * -1);
        return;
    }
    if (level.timerstopped) {
        setgameendtime(0);
        return;
    }
    if (!isdefined(level.starttime)) {
        return;
    }
    timeleft = globallogic_utils::gettimeremaining();
    setgameendtime(gettime() + int(timeleft));
    if (timeleft > 0) {
        return;
    }
    [[ level.ontimelimit ]]();
}

// Namespace globallogic/globallogic
// Params 0, eflags: 0x0
// Checksum 0x92aafe99, Offset: 0x88a8
// Size: 0xa4
function checkscorelimit() {
    if (game.state != "playing") {
        return 0;
    }
    if (level.scorelimit <= 0) {
        return 0;
    }
    if (level.teambased) {
        if (!util::any_team_hit_score_limit()) {
            return 0;
        }
    } else {
        if (!isplayer(self)) {
            return 0;
        }
        if (self.pointstowin < level.scorelimit) {
            return 0;
        }
    }
    [[ level.onscorelimit ]]();
}

// Namespace globallogic/globallogic
// Params 1, eflags: 0x0
// Checksum 0xb31bae70, Offset: 0x8958
// Size: 0x78
function checksuddendeathscorelimit(team) {
    if (game.state != "playing") {
        return 0;
    }
    if (level.roundscorelimit <= 0) {
        return 0;
    }
    if (level.teambased) {
        if (!game.teamsuddendeath[team]) {
            return 0;
        }
    } else {
        return 0;
    }
    [[ level.onscorelimit ]]();
}

// Namespace globallogic/globallogic
// Params 0, eflags: 0x0
// Checksum 0x2b4c9d9a, Offset: 0x89d8
// Size: 0xbc
function checkroundscorelimit() {
    if (game.state != "playing") {
        return 0;
    }
    if (level.roundscorelimit <= 0) {
        return 0;
    }
    if (level.teambased) {
        if (!util::any_team_hit_round_score_limit()) {
            return 0;
        }
    } else {
        if (!isplayer(self)) {
            return 0;
        }
        roundscorelimit = util::get_current_round_score_limit();
        if (self.pointstowin < roundscorelimit) {
            return 0;
        }
    }
    [[ level.onroundscorelimit ]]();
}

// Namespace globallogic/globallogic
// Params 0, eflags: 0x0
// Checksum 0x7b7641db, Offset: 0x8aa0
// Size: 0x212
function removedisconnectedplayerfromplacement() {
    if (gamestate::is_shutting_down()) {
        return;
    }
    offset = 0;
    numplayers = level.placement[#"all"].size;
    found = 0;
    for (i = 0; i < numplayers; i++) {
        if (level.placement[#"all"][i] == self) {
            found = 1;
        }
        if (found) {
            level.placement[#"all"][i] = level.placement[#"all"][i + 1];
        }
    }
    if (!found) {
        return;
    }
    level.placement[#"all"][numplayers - 1] = undefined;
    assert(level.placement[#"all"].size == numplayers - 1);
    /#
        globallogic_utils::assertproperplacement();
    #/
    updateteamplacement();
    if (level.teambased) {
        return;
    }
    numplayers = level.placement[#"all"].size;
    for (i = 0; i < numplayers; i++) {
        player = level.placement[#"all"][i];
        player notify(#"update_outcome");
    }
}

// Namespace globallogic/globallogic
// Params 0, eflags: 0x0
// Checksum 0x8406f76c, Offset: 0x8cc0
// Size: 0x3d4
function updateplacement() {
    if (!level.players.size) {
        return;
    }
    level.placement[#"all"] = [];
    foreach (player in level.players) {
        if (!level.teambased || isdefined(level.teams[player.team])) {
            level.placement[#"all"][level.placement[#"all"].size] = player;
        }
    }
    placementall = level.placement[#"all"];
    if (level.teambased) {
        for (i = 1; i < placementall.size; i++) {
            player = placementall[i];
            playerscore = player.score;
            for (j = i - 1; j >= 0 && (playerscore > placementall[j].score || playerscore == placementall[j].score && player.deaths < placementall[j].deaths); j--) {
                placementall[j + 1] = placementall[j];
            }
            placementall[j + 1] = player;
        }
    } else {
        for (i = 1; i < placementall.size; i++) {
            player = placementall[i];
            playerscore = player.pointstowin;
            for (j = i - 1; j >= 0 && (playerscore > placementall[j].pointstowin || playerscore == placementall[j].pointstowin && player.deaths < placementall[j].deaths || playerscore == placementall[j].pointstowin && player.deaths == placementall[j].deaths && player.lastkilltime > placementall[j].lastkilltime); j--) {
                placementall[j + 1] = placementall[j];
            }
            placementall[j + 1] = player;
        }
    }
    level.placement[#"all"] = placementall;
    /#
        globallogic_utils::assertproperplacement();
    #/
    updateteamplacement();
}

// Namespace globallogic/globallogic
// Params 0, eflags: 0x0
// Checksum 0xccb022cd, Offset: 0x90a0
// Size: 0x1b6
function updateteamplacement() {
    foreach (team, _ in level.teams) {
        placement[team] = [];
    }
    placement[#"spectator"] = [];
    if (!level.teambased) {
        return;
    }
    placementall = level.placement[#"all"];
    placementallsize = placementall.size;
    for (i = 0; i < placementallsize; i++) {
        player = placementall[i];
        team = player.pers[#"team"];
        placement[team][placement[team].size] = player;
    }
    foreach (team, _ in level.teams) {
        level.placement[team] = placement[team];
    }
}

// Namespace globallogic/globallogic
// Params 1, eflags: 0x0
// Checksum 0x623f5480, Offset: 0x9260
// Size: 0xb0
function getplacementforplayer(player) {
    updateplacement();
    playerrank = -1;
    placement = level.placement[#"all"];
    for (placementindex = 0; placementindex < placement.size; placementindex++) {
        if (level.placement[#"all"][placementindex] == player) {
            playerrank = placementindex + 1;
            break;
        }
    }
    return playerrank;
}

// Namespace globallogic/globallogic
// Params 1, eflags: 0x0
// Checksum 0xde9f93ff, Offset: 0x9318
// Size: 0x264
function istopscoringplayer(player) {
    topscoringplayer = 0;
    updateplacement();
    assert(level.placement[#"all"].size > 0);
    if (level.placement[#"all"].size == 0) {
        return 0;
    }
    if (level.teambased) {
        topscore = level.placement[#"all"][0].score;
        foreach (place in level.placement[#"all"]) {
            if (place.score == 0) {
                break;
            }
            if (topscore > place.score) {
                break;
            }
            if (player == place) {
                topscoringplayer = 1;
                break;
            }
        }
    } else {
        topscore = level.placement[#"all"][0].pointstowin;
        foreach (place in level.placement[#"all"]) {
            if (place.pointstowin == 0) {
                break;
            }
            if (topscore > place.pointstowin) {
                break;
            }
            if (player == place) {
                topscoringplayer = 1;
                break;
            }
        }
    }
    return topscoringplayer;
}

// Namespace globallogic/globallogic
// Params 1, eflags: 0x0
// Checksum 0xeded2061, Offset: 0x9588
// Size: 0x1a4
function sortdeadplayers(team) {
    if (!level.playerqueuedrespawn) {
        return;
    }
    for (i = 1; i < level.deadplayers[team].size; i++) {
        player = level.deadplayers[team][i];
        for (j = i - 1; j >= 0 && player.deathtime < level.deadplayers[team][j].deathtime; j--) {
            level.deadplayers[team][j + 1] = level.deadplayers[team][j];
        }
        level.deadplayers[team][j + 1] = player;
    }
    for (i = 0; i < level.deadplayers[team].size; i++) {
        if (level.deadplayers[team][i].spawnqueueindex != i) {
            level.spawnqueuemodified[team] = 1;
        }
        level.deadplayers[team][i].spawnqueueindex = i;
    }
}

// Namespace globallogic/globallogic
// Params 0, eflags: 0x0
// Checksum 0xf997f818, Offset: 0x9738
// Size: 0x92
function totalalivecount() {
    count = 0;
    foreach (team, _ in level.teams) {
        count += level.alivecount[team];
    }
    return count;
}

// Namespace globallogic/globallogic
// Params 0, eflags: 0x0
// Checksum 0x17638f3d, Offset: 0x97d8
// Size: 0x92
function totalplayerlives() {
    count = 0;
    foreach (team, _ in level.teams) {
        count += level.playerlives[team];
    }
    return count;
}

// Namespace globallogic/globallogic
// Params 0, eflags: 0x0
// Checksum 0x411aac7, Offset: 0x9878
// Size: 0x92
function function_be9037f8() {
    count = 0;
    foreach (team, _ in level.teams) {
        if (level.alivecount[team]) {
            count++;
        }
    }
    return count;
}

// Namespace globallogic/globallogic
// Params 1, eflags: 0x0
// Checksum 0xdeaf48d3, Offset: 0x9918
// Size: 0x134
function initteamvariables(team) {
    if (!isdefined(level.alivecount)) {
        level.alivecount = [];
    }
    level.alivecount[team] = 0;
    level.lastalivecount[team] = 0;
    if (!isdefined(level.var_ba5bd3ee)) {
        level.var_ba5bd3ee = 0;
    }
    if (!isdefined(game.everexisted)) {
        game.everexisted = [];
    }
    if (!isdefined(game.everexisted[team])) {
        game.everexisted[team] = 0;
    }
    if (!isdefined(level.var_51eea74b)) {
        level.var_51eea74b = [];
    }
    level.everexisted[team] = 0;
    level.wavedelay[team] = 0;
    level.lastwave[team] = 0;
    level.waveplayerspawnindex[team] = 0;
    resetteamvariables(team);
}

// Namespace globallogic/globallogic
// Params 1, eflags: 0x0
// Checksum 0x272f5b93, Offset: 0x9a58
// Size: 0xe2
function resetteamvariables(team) {
    level.playercount[team] = 0;
    level.botscount[team] = 0;
    level.lastalivecount[team] = level.alivecount[team];
    level.alivecount[team] = 0;
    level.playerlives[team] = 0;
    level.aliveplayers[team] = [];
    level.spawningplayers[team] = [];
    level.deadplayers[team] = [];
    level.squads[team] = [];
    level.spawnqueuemodified[team] = 0;
}

// Namespace globallogic/globallogic
// Params 0, eflags: 0x0
// Checksum 0xb24e871f, Offset: 0x9b48
// Size: 0x66c
function updateteamstatus() {
    level notify(#"updating_team_status");
    level endon(#"updating_team_status");
    level endon(#"game_ended");
    waittillframeend();
    wait 0;
    if (gamestate::is_game_over()) {
        return;
    }
    resettimeout();
    var_2888db16 = [];
    foreach (team, _ in level.teams) {
        var_2888db16[team] = level.alivecount[team] > 0;
        resetteamvariables(team);
    }
    if (!level.teambased) {
        resetteamvariables("free");
    }
    level.activeplayers = [];
    level.var_4f19f362 = [];
    players = level.players;
    for (i = 0; i < players.size; i++) {
        player = players[i];
        if (!isdefined(player) && level.splitscreen) {
            continue;
        }
        if (level.teambased || player.team == #"spectator") {
            team = player.team;
        } else {
            team = "free";
        }
        playerclass = player.curclass;
        if (team != #"spectator" && (isdefined(playerclass) && playerclass != "" || !loadout::function_cd383ec5())) {
            level.playercount[team]++;
            if (isbot(player)) {
                level.botscount[team]++;
            }
            not_quite_dead = 0;
            if (isdefined(player.overrideplayerdeadstatus)) {
                not_quite_dead = player [[ player.overrideplayerdeadstatus ]]();
            }
            if (player.sessionstate == "playing") {
                level.alivecount[team]++;
                level.playerlives[team]++;
                player.spawnqueueindex = -1;
                if (isalive(player)) {
                    level.aliveplayers[team][level.aliveplayers[team].size] = player;
                    level.activeplayers[level.activeplayers.size] = player;
                } else {
                    level.deadplayers[team][level.deadplayers[team].size] = player;
                }
                continue;
            }
            if (not_quite_dead) {
                level.alivecount[team]++;
                level.playerlives[team]++;
                level.aliveplayers[team][level.aliveplayers[team].size] = player;
                continue;
            }
            level.deadplayers[team][level.deadplayers[team].size] = player;
            if (player globallogic_spawn::mayspawn()) {
                level.playerlives[team]++;
            }
        }
    }
    totalalive = totalalivecount();
    if (totalalive > level.maxplayercount) {
        level.maxplayercount = totalalive;
    }
    aliveteamcount = function_be9037f8();
    foreach (team, _ in level.teams) {
        if (level.alivecount[team]) {
            game.everexisted[team] = 1;
            if (level.everexisted[team] == 0) {
                level.everexisted[team] = gettime();
            }
        } else if (var_2888db16[team]) {
            level.var_51eea74b[team] = aliveteamcount + 1;
        }
        sortdeadplayers(team);
    }
    /#
        if (getdvarint(#"hash_79f55d595a926104", 0)) {
            foreach (team, _ in level.teams) {
                game.everexisted[team] = 0;
                level.everexisted[team] = 0;
            }
        }
    #/
    level updategameevents();
}

// Namespace globallogic/globallogic
// Params 1, eflags: 0x0
// Checksum 0x1d850cb6, Offset: 0xa1c0
// Size: 0x384
function updatealivetimes(team) {
    level.alivetimesaverage[team] = 0;
    if (gamestate::is_game_over()) {
        return;
    }
    total_player_count = 0;
    average_player_spawn_time = 0;
    total_value_count = 0;
    foreach (player in level.aliveplayers[team]) {
        average_time = 0;
        count = 0;
        foreach (time in player.alivetimes) {
            if (time != 0) {
                average_time += time;
                count++;
            }
        }
        if (count) {
            total_value_count += count;
            average_player_spawn_time += average_time / count;
            total_player_count++;
        }
    }
    foreach (player in level.deadplayers[team]) {
        average_time = 0;
        count = 0;
        foreach (time in player.alivetimes) {
            if (time != 0) {
                average_time += time;
                count++;
            }
        }
        if (count) {
            total_value_count += count;
            average_player_spawn_time += average_time / count;
            total_player_count++;
        }
    }
    if (total_player_count == 0 || total_value_count < 3) {
        level.alivetimesaverage[team] = 0;
        return;
    }
    level.alivetimesaverage[team] = average_player_spawn_time / total_player_count;
    /#
        if (getdvarint(#"hash_7d48f244ba0d0b2d", 0)) {
            iprintln("<dev string:x7b>" + level.alivetimesaverage[#"allies"] + "<dev string:x91>" + level.alivetimesaverage[#"axis"]);
        }
    #/
}

// Namespace globallogic/globallogic
// Params 0, eflags: 0x0
// Checksum 0xdae93296, Offset: 0xa550
// Size: 0x80
function updateallalivetimes() {
    foreach (team, _ in level.teams) {
        updatealivetimes(team);
    }
}

// Namespace globallogic/globallogic
// Params 1, eflags: 0x0
// Checksum 0x83a6d545, Offset: 0xa5d8
// Size: 0xd8
function checkteamscorelimitsoon(team) {
    assert(isdefined(team));
    if (level.scorelimit <= 0) {
        return;
    }
    if (!level.teambased) {
        return;
    }
    if (globallogic_utils::gettimepassed() < int(60 * 1000)) {
        return;
    }
    timeleft = globallogic_utils::getestimatedtimeuntilscorelimit(team);
    if (timeleft < 1) {
        level notify(#"match_ending_soon", {#event:"score"});
    }
}

// Namespace globallogic/globallogic
// Params 0, eflags: 0x0
// Checksum 0xb3cb3b8d, Offset: 0xa6b8
// Size: 0xe0
function checkplayerscorelimitsoon() {
    assert(isplayer(self));
    if (level.scorelimit <= 0) {
        return;
    }
    if (level.teambased) {
        return;
    }
    if (globallogic_utils::gettimepassed() < int(60 * 1000)) {
        return;
    }
    timeleft = globallogic_utils::getestimatedtimeuntilscorelimit(undefined);
    if (timeleft < 1) {
        level notify(#"match_ending_soon", {#event:"score"});
    }
}

// Namespace globallogic/globallogic
// Params 0, eflags: 0x0
// Checksum 0x6357a731, Offset: 0xa7a0
// Size: 0x450
function timelimitclock() {
    level endon(#"game_ended");
    waitframe(1);
    clockobject = spawn("script_origin", (0, 0, 0));
    while (!gamestate::is_game_over()) {
        using_tickets_as_time = level.timelimit == 0 && isdefined(level.low_tickets_enabled) && isdefined(level.get_tickets_as_time);
        if (!level.timerstopped && (level.timelimit || level.low_ticket_count === 1)) {
            if (using_tickets_as_time) {
                timeleftint = [[ level.get_tickets_as_time ]]();
            } else {
                timeleft = float(globallogic_utils::gettimeremaining()) / 1000;
                timeleftint = int(timeleft + 0.5);
            }
            if (timeleftint == 601) {
                util::clientnotify("notify_10");
            }
            if (timeleftint == 301) {
                util::clientnotify("notify_5");
            }
            if (timeleftint == 60) {
                util::clientnotify("notify_1");
            }
            if (timeleftint == 12) {
                util::clientnotify("notify_count");
            }
            if (timeleftint >= 40 && timeleftint <= 60) {
                level notify(#"match_ending_soon", "time");
            }
            if (timeleftint >= 30 && timeleftint <= 40) {
                level notify(#"match_ending_pretty_soon", "time");
            }
            if (timeleftint <= 32) {
                level notify(#"match_ending_vox");
            }
            if (timeleftint <= 10 || timeleftint <= 30 && timeleftint % 2 == 0 || level.low_ticket_count === 1 && timeleftint % 2 == 0 || level.very_low_ticket_count === 1) {
                level notify(#"match_ending_very_soon", "time");
                if (timeleftint == 0) {
                    break;
                }
                clockobject playsound(#"mpl_ui_timer_countdown");
            }
            if (!using_tickets_as_time) {
                if (timeleftint <= 5) {
                    wait 0.5;
                    continue;
                } else if (timeleft - floor(timeleft) >= 0.05) {
                    wait timeleft - floor(timeleft);
                }
            }
        }
        if (using_tickets_as_time && !level.timerstopped) {
            timeleftint = [[ level.get_tickets_as_time ]]();
            if (timeleftint <= 0) {
                wait 1;
            } else {
                oldtimeleftint = timeleftint;
                while (!level.timerstopped && oldtimeleftint == timeleftint && timeleftint > 0) {
                    waitframe(1);
                    timeleftint = [[ level.get_tickets_as_time ]]();
                }
            }
            continue;
        }
        wait 1;
    }
}

// Namespace globallogic/globallogic
// Params 1, eflags: 0x0
// Checksum 0x7cd2bbe7, Offset: 0xabf8
// Size: 0xb0
function timelimitclock_intermission(waittime) {
    setgameendtime(gettime() + int(waittime * 1000));
    clockobject = spawn("script_origin", (0, 0, 0));
    if (waittime >= 10) {
        wait waittime - 10;
    }
    for (;;) {
        clockobject playsound(#"mpl_ui_timer_countdown");
        wait 1;
    }
}

// Namespace globallogic/globallogic
// Params 0, eflags: 0x4
// Checksum 0xdcde81d9, Offset: 0xacb0
// Size: 0x334
function private set_game_playing() {
    level notify(#"game_playing");
    game.state = "playing";
    level callback::callback(#"on_game_playing");
    level clientfield::set("gameplay_started", 1);
    players = getplayers();
    totalplayers = 0;
    foreach (player in players) {
        if (isalive(player)) {
            totalplayers++;
        }
    }
    if (isdefined(level.var_354ac898)) {
        var_de8726e0 = isdefined(level.var_354ac898.duration) ? level.var_354ac898.duration : 0;
        var_aeca71b1 = isdefined(level.var_354ac898.var_1e58f0c1) ? level.var_354ac898.var_1e58f0c1 : 0;
        var_f90bd1b3 = isdefined(level.var_354ac898.var_e39307df) ? level.var_354ac898.var_e39307df : 0;
        var_84983631 = isdefined(level.var_354ac898.var_7198d0b5) ? level.var_354ac898.var_7198d0b5 : 0;
        var_e0216802 = isdefined(level.var_354ac898.var_20d68242) ? level.var_354ac898.var_20d68242 : 0;
    } else {
        var_de8726e0 = 0;
        var_aeca71b1 = 0;
        var_f90bd1b3 = 0;
        var_84983631 = 0;
        var_e0216802 = 0;
    }
    data = {#var_adcb9463:var_de8726e0, #var_47b30718:var_aeca71b1, #var_bdaece04:var_f90bd1b3, #var_49d16c80:var_84983631, #var_614beae1:var_e0216802, #var_4e3dc9b1:gettime(), #player_count:totalplayers};
    function_b1f6086c(#"hash_24f510499c464072", data);
    match_record::set_stat(#"hash_5288d149bac65a79", gettime());
}

// Namespace globallogic/globallogic
// Params 0, eflags: 0x0
// Checksum 0xa2cec61c, Offset: 0xaff0
// Size: 0x94
function function_43980a52() {
    if (util::isroundbased()) {
        if (util::getroundsplayed() == 0) {
            recordmatchbegin();
        }
        matchrecordroundstart();
        if (overtime::is_overtime_round()) {
            matchrecordovertimeround();
        }
        return;
    }
    recordmatchbegin();
}

// Namespace globallogic/globallogic
// Params 0, eflags: 0x0
// Checksum 0xbbfbae81, Offset: 0xb090
// Size: 0x244
function startgame() {
    callback::on_game_playing(&globallogic_utils::gametimer);
    level.timerstopped = 0;
    level.playabletimerstopped = 0;
    game.state = "pregame";
    setmatchtalkflag("DeadChatWithDead", level.voip.deadchatwithdead);
    setmatchtalkflag("DeadChatWithTeam", level.voip.deadchatwithteam);
    setmatchtalkflag("DeadHearTeamLiving", level.voip.deadhearteamliving);
    setmatchtalkflag("DeadHearAllLiving", level.voip.deadhearallliving);
    setmatchtalkflag("EveryoneHearsEveryone", level.voip.everyonehearseveryone);
    setmatchtalkflag("DeadHearKiller", level.voip.deadhearkiller);
    setmatchtalkflag("KillersHearVictim", level.voip.killershearvictim);
    if (isdefined(level.custom_prematch_period)) {
        [[ level.custom_prematch_period ]]();
    } else {
        prematchperiod();
    }
    set_game_playing();
    /#
        rat::function_5650d768();
    #/
    thread showobjectivenotificationuiforallplayers(undefined, 0);
    thread timelimitclock();
    thread graceperiod();
    thread watchmatchendingsoon();
    thread globallogic_audio::announcercontroller();
    thread globallogic_audio::sndmusicfunctions();
    function_43980a52();
}

// Namespace globallogic/globallogic
// Params 1, eflags: 0x0
// Checksum 0xa5f6df4c, Offset: 0xb2e0
// Size: 0xe8
function isprematchrequirementconditionmet(activeteamcount) {
    if (level.prematchrequirement == 0) {
        return true;
    }
    if (level.teambased) {
        if (activeteamcount.size <= 1) {
            return false;
        }
        foreach (teamcount in activeteamcount) {
            if (teamcount != level.prematchrequirement) {
                return false;
            }
        }
    } else if (activeteamcount[#"free"] != level.prematchrequirement) {
        return false;
    }
    return true;
}

// Namespace globallogic/globallogic
// Params 0, eflags: 0x0
// Checksum 0xebbfe6f1, Offset: 0xb3d0
// Size: 0x402
function waitforplayers() {
    level endon(#"game_ended");
    starttime = gettime();
    playerready = 0;
    activeplayercount = 0;
    accepttestclient = 0;
    activeteamcount = [];
    player_ready = [];
    while (!playerready || activeplayercount == 0 || !isprematchrequirementconditionmet(activeteamcount)) {
        activeplayercount = 0;
        if (level.teambased) {
            foreach (team, _ in level.teams) {
                activeteamcount[team] = 0;
            }
        } else {
            activeteamcount[#"free"] = 0;
        }
        temp_player_ready = [];
        foreach (player in level.players) {
            if (player istestclient() && accepttestclient == 0) {
                continue;
            }
            if (player.team != #"spectator") {
                activeplayercount++;
                player_num = player getentitynumber();
                if (isdefined(player_ready[player_num])) {
                    temp_player_ready[player_num] = player_ready[player_num];
                } else {
                    temp_player_ready[player_num] = gettime();
                }
                if (temp_player_ready[player_num] + 5000 < gettime() || player isstreamerready(-1, 1)) {
                    if (level.teambased) {
                        activeteamcount[player.team]++;
                    } else {
                        activeteamcount[#"free"]++;
                    }
                }
            }
            if (player isstreamerready(-1, 1)) {
                if (playerready == 0) {
                    level notify(#"first_player_ready", {#player:player});
                }
                playerready = 1;
            }
        }
        player_read = temp_player_ready;
        waitframe(1);
        if (gettime() - starttime > int(20 * 1000)) {
            if (level.rankedmatch == 0 && level.arenamatch == 0) {
                accepttestclient = 1;
            }
        }
        if (level.rankedmatch && gettime() - starttime > int(120 * 1000)) {
            exit_level();
            while (true) {
                wait 10;
            }
        }
    }
}

// Namespace globallogic/globallogic
// Params 0, eflags: 0x0
// Checksum 0x688183d2, Offset: 0xb7e0
// Size: 0x4c
function prematchwaitingforplayers() {
    if (level.prematchrequirement != 0) {
        level waittill(#"first_player_ready");
        luinotifyevent(#"prematch_waiting_for_players");
    }
}

// Namespace globallogic/globallogic
// Params 0, eflags: 0x0
// Checksum 0x908c9212, Offset: 0xb838
// Size: 0x24c
function prematchperiod() {
    setmatchflag("hud_hardcore", level.hardcoremode);
    level endon(#"game_ended");
    globallogic_audio::sndmusicsetrandomizer();
    if (draft::is_draft_this_round()) {
        level thread draft::start();
        level waittill(#"draft_complete");
        return;
    }
    if (isdefined(level.var_50c2ca68)) {
        [[ level.var_50c2ca68 ]]();
    }
    thread matchstarttimer();
    if (level.prematchperiod > 0) {
        thread prematchwaitingforplayers();
        waitforplayers();
        wait level.prematchperiod;
    } else {
        matchstarttimerskip();
        waitframe(1);
    }
    level.inprematchperiod = 0;
    level thread sndsetmatchsnapshot(0);
    foreach (player in level.players) {
        player val::reset(#"spawn_player", "freezecontrols");
        player val::reset(#"spawn_player", "disablegadgets");
        player enableweapons();
        player callback::callback(#"prematch_end");
    }
    level callback::callback(#"prematch_end");
}

// Namespace globallogic/globallogic
// Params 0, eflags: 0x0
// Checksum 0xec03cda2, Offset: 0xba90
// Size: 0x16c
function graceperiod() {
    level endon(#"game_ended");
    if (isdefined(level.graceperiodfunc)) {
        [[ level.graceperiodfunc ]]();
    } else {
        wait level.graceperiod;
    }
    level notify(#"grace_period_ending");
    waitframe(1);
    level.ingraceperiod = 0;
    if (gamestate::is_game_over()) {
        return;
    }
    if (level.numlives) {
        players = level.players;
        for (i = 0; i < players.size; i++) {
            player = players[i];
            if (!player.hasspawned && player.sessionteam != #"spectator" && !isalive(player)) {
                player.statusicon = "hud_status_dead";
            }
        }
    }
    level thread updateteamstatus();
    level thread updateallalivetimes();
}

// Namespace globallogic/globallogic
// Params 0, eflags: 0x0
// Checksum 0x8591819e, Offset: 0xbc08
// Size: 0x64
function watchmatchendingsoon() {
    setdvar(#"xblive_matchendingsoon", 0);
    level waittill(#"match_ending_soon");
    setdvar(#"xblive_matchendingsoon", 1);
}

// Namespace globallogic/globallogic
// Params 0, eflags: 0x0
// Checksum 0x5cdc1b23, Offset: 0xbc78
// Size: 0x84
function anyteamhaswavedelay() {
    foreach (team, _ in level.teams) {
        if (level.wavedelay[team]) {
            return true;
        }
    }
    return false;
}

// Namespace globallogic/globallogic
// Params 0, eflags: 0x0
// Checksum 0x53da5560, Offset: 0xbd08
// Size: 0x94
function setteamlivesuimodels() {
    waitframe(1);
    if (level.numteamlives > 0) {
        allieslivescount = 0;
        axislivescount = 0;
        if (isdefined(game.lives)) {
            allieslivescount = level.numteamlives;
            axislivescount = level.numteamlives;
        }
        clientfield::set_world_uimodel("hudItems.team1.livesCount", allieslivescount);
        clientfield::set_world_uimodel("hudItems.team2.livesCount", axislivescount);
    }
}

// Namespace globallogic/globallogic
// Params 0, eflags: 0x0
// Checksum 0xa573237c, Offset: 0xbda8
// Size: 0x44
function function_e2f4e49b() {
    if (isdefined(level.var_c9d3723c)) {
        [[ level.var_c9d3723c ]]();
    }
    influencers::create_map_placed_influencers();
    globallogic_spawn::addspawns();
}

// Namespace globallogic/globallogic
// Params 0, eflags: 0x0
// Checksum 0x76fc2617, Offset: 0xbdf8
// Size: 0x16c4
function function_98cb5f3b() {
    level.prematchrequirement = 0;
    level.prematchperiod = 0;
    level.intermission = 0;
    setmatchflag("cg_drawSpectatorMessages", 1);
    setmatchflag("game_ended", 0);
    if (!isdefined(game.gamestarted)) {
        assert(isdefined(game.attackers) && isdefined(game.defenders));
        assert(game.attackers != game.defenders);
        if (!isdefined(game.state)) {
            game.state = "pregame";
        }
        game.strings[#"press_to_spawn"] = #"hash_203ff65a4ee460e6";
        if (level.teambased) {
            game.strings[#"waiting_for_teams"] = #"hash_150c54160239825";
            game.strings[#"opponent_forfeiting_in"] = #"hash_52d76ed35e0b625a";
        } else {
            game.strings[#"waiting_for_teams"] = #"hash_47c479655d474f31";
            game.strings[#"opponent_forfeiting_in"] = #"hash_52d76ed35e0b625a";
        }
        game.strings[#"match_starting_in"] = #"hash_18e58cc95db34427";
        game.strings[#"spawn_next_round"] = #"hash_590100cdca62e7db";
        game.strings[#"waiting_to_spawn"] = #"hash_44d60a6e6ed2a53c";
        game.strings[#"waiting_to_spawn_ss"] = #"hash_78bf3a61cf52e257";
        game.strings[#"you_will_spawn"] = #"hash_53c0ba6abce1c0ea";
        game.strings[#"match_starting"] = #"mp/match_starting";
        game.strings[#"change_class"] = #"hash_181a96fe9c28ada2";
        game.strings[#"item_on_respawn"] = #"hash_220160808c99fe71";
        game.strings[#"hash_b71875e85956ea"] = #"hash_61f8bf2959b7bd5a";
        game.strings[#"last_stand"] = #"hash_5732d212e4511a00";
        game.strings[#"cowards_way"] = #"hash_268e464278a2f8ff";
        [[ level.onprecachegametype ]]();
        game.gamestarted = 1;
        game.totalkills = 0;
        foreach (team, _ in level.teams) {
            if (!isdefined(game.migratedhost)) {
                game.stat[#"teamscores"][team] = 0;
            }
            game.teamsuddendeath[team] = 0;
            game.totalkillsteam[team] = 0;
        }
        level.prematchrequirement = getgametypesetting(#"prematchrequirement");
        level.prematchperiod = getgametypesetting(#"prematchperiod");
        /#
            prematchperiodoverride = getdvarint(#"prematchperiodoverride", -1);
            if (prematchperiodoverride >= 0) {
                level.prematchperiod = prematchperiodoverride;
            }
        #/
    } else {
        if (!level.splitscreen) {
            level.prematchperiod = getgametypesetting(#"preroundperiod");
        }
        /#
            preroundperiodoverride = getdvarint(#"preroundperiodoverride", -1);
            if (preroundperiodoverride >= 0) {
                level.prematchperiod = preroundperiodoverride;
            }
        #/
    }
    if (!isdefined(game.timepassed)) {
        game.timepassed = 0;
    }
    if (!isdefined(game.playabletimepassed)) {
        game.playabletimepassed = 0;
    }
    round::round_stats_init();
    level.skipvote = 0;
    level.gameended = 0;
    level.exitlevel = 0;
    setdvar(#"g_gameended", 0);
    level.objidstart = 0;
    level.forcedend = 0;
    level.hostforcedend = 0;
    level.hardcoremode = getgametypesetting(#"hardcoremode");
    if (level.hardcoremode) {
        /#
            print("<dev string:x99>");
        #/
        if (!isdefined(level.friendlyfiredelaytime)) {
            level.friendlyfiredelaytime = 0;
        }
    }
    level.rankcap = getdvarint(#"scr_max_rank", 0);
    level.minprestige = getdvarint(#"scr_min_prestige", 0);
    level.usestartspawns = 1;
    level.alwaysusestartspawns = 0;
    level.usexcamsforendgame = 0;
    level.cumulativeroundscores = getgametypesetting(#"cumulativeroundscores");
    level.allowhitmarkers = getgametypesetting(#"allowhitmarkers");
    level.playerqueuedrespawn = getgametypesetting(#"playerqueuedrespawn");
    level.playerforcerespawn = getgametypesetting(#"playerforcerespawn");
    level.roundstartexplosivedelay = getgametypesetting(#"roundstartexplosivedelay");
    level.roundstartkillstreakdelay = getgametypesetting(#"roundstartkillstreakdelay");
    level.perksenabled = getgametypesetting(#"perksenabled");
    level.disableattachments = getgametypesetting(#"disableattachments");
    level.disabletacinsert = getgametypesetting(#"disabletacinsert");
    level.disablecac = getgametypesetting(#"disablecac");
    level.disableclassselection = getgametypesetting(#"disableclassselection");
    level.disableweapondrop = getgametypesetting(#"disableweapondrop");
    level.onlyheadshots = getgametypesetting(#"onlyheadshots");
    level.minimumallowedteamkills = getgametypesetting(#"teamkillpunishcount") - 1;
    level.teamkillreducedpenalty = getgametypesetting(#"teamkillreducedpenalty");
    level.teamkillpointloss = getgametypesetting(#"teamkillpointloss");
    level.teamkillspawndelay = getgametypesetting(#"teamkillspawndelay");
    level.deathpointloss = getgametypesetting(#"deathpointloss");
    level.leaderbonus = getgametypesetting(#"leaderbonus");
    level.forceradar = getgametypesetting(#"forceradar");
    level.playersprinttime = getgametypesetting(#"playersprinttime");
    level.bulletdamagescalar = getgametypesetting(#"bulletdamagescalar");
    level.playermaxhealth = getgametypesetting(#"playermaxhealth");
    level.playerhealthregentime = getgametypesetting(#"playerhealthregentime");
    level.var_9ef11bf6 = getgametypesetting(#"playermaxhealth") - 150;
    level.scoreresetondeath = getgametypesetting(#"scoreresetondeath");
    level.ekiaresetondeath = getgametypesetting(#"ekiaresetondeath");
    level.var_48797d5 = getgametypesetting(#"hash_32da91b78e54e7b5");
    level.playerrespawndelay = getgametypesetting(#"playerrespawndelay");
    level.playerincrementalrespawndelay = getgametypesetting(#"incrementalspawndelay");
    level.playerobjectiveheldrespawndelay = getgametypesetting(#"playerobjectiveheldrespawndelay");
    level.waverespawndelay = getgametypesetting(#"waverespawndelay");
    level.suicidespawndelay = getgametypesetting(#"spawnsuicidepenalty");
    level.teamkilledspawndelay = getgametypesetting(#"spawnteamkilledpenalty");
    level.maxsuicidesbeforekick = getgametypesetting(#"maxsuicidesbeforekick");
    level.spectatetype = getgametypesetting(#"spectatetype");
    level.voip = spawnstruct();
    level.voip.deadchatwithdead = getgametypesetting(#"voipdeadchatwithdead");
    level.voip.deadchatwithteam = getgametypesetting(#"voipdeadchatwithteam");
    level.voip.deadhearallliving = getgametypesetting(#"voipdeadhearallliving");
    level.voip.deadhearteamliving = getgametypesetting(#"voipdeadhearteamliving");
    level.voip.everyonehearseveryone = getgametypesetting(#"voipeveryonehearseveryone");
    level.voip.deadhearkiller = getgametypesetting(#"voipdeadhearkiller");
    level.voip.killershearvictim = getgametypesetting(#"voipkillershearvictim");
    level.droppedtagrespawn = getgametypesetting(#"droppedtagrespawn");
    if (isdefined(level.droppedtagrespawn) && level.droppedtagrespawn) {
        dogtags::init();
    }
    gameobjects::main();
    foreach (team, _ in level.teams) {
        initteamvariables(team);
    }
    if (!level.teambased) {
        initteamvariables("free");
    }
    level.maxplayercount = 0;
    level.activeplayers = [];
    level.alivetimemaxcount = 3;
    level.alivetimesaverage = [];
    level.var_710cc7bb = [];
    level.var_1c4b75ec = [];
    level.deaths = [];
    foreach (team, _ in level.teams) {
        level.alivetimesaverage[team] = 0;
        level.var_710cc7bb[team] = 0;
        level.var_1c4b75ec[team] = 0;
        level.deaths[team] = 0;
    }
    if (!isdefined(level.livesdonotreset) || !level.livesdonotreset) {
        foreach (team, _ in level.teams) {
            game.lives[team] = level.numteamlives;
        }
        level thread setteamlivesuimodels();
    }
    level.allowannouncer = getgametypesetting(#"allowannouncer");
    if (!isdefined(level.timelimit)) {
        util::registertimelimit(1, 1440);
    }
    if (!isdefined(level.scorelimit)) {
        util::registerscorelimit(1, 500);
    }
    if (!isdefined(level.roundscorelimit)) {
        util::registerroundscorelimit(0, 500);
    }
    if (!isdefined(level.roundlimit)) {
        util::registerroundlimit(0, 10);
    }
    if (!isdefined(level.roundwinlimit)) {
        util::registerroundwinlimit(0, 10);
    }
    if (!display_transition::function_7ba795bd()) {
        globallogic_utils::registerpostroundevent(&killcam::function_5a897061);
        globallogic_utils::registerpostroundevent(&potm::post_round_potm);
    }
    wavedelay = level.waverespawndelay;
    if (wavedelay) {
        foreach (team, _ in level.teams) {
            level.wavedelay[team] = wavedelay;
            level.lastwave[team] = 0;
        }
        level thread [[ level.wavespawntimer ]]();
    }
    level.inprematchperiod = 1;
    if (level.prematchperiod > 2 && level.rankedmatch) {
        level.prematchperiod += randomfloat(4) - 2;
    }
    if (level.numlives || anyteamhaswavedelay() || level.playerqueuedrespawn) {
        level.graceperiod = 15;
    } else {
        level.graceperiod = 5;
    }
    level.ingraceperiod = 1;
    level.roundenddelay[0] = 3.5;
    level.roundenddelay[1] = 1.5;
    level.roundenddelay[2] = 1.5;
    level.roundenddelay[3] = 7;
    level.roundenddelay[4] = 2;
    globallogic_score::updateallteamscores();
    level.killstreaksenabled = 1;
    level.missilelockplayspacecheckenabled = 1;
    level.missilelockplayspacecheckextraradius = 18000;
    if (getdvarstring(#"scr_game_rankenabled") == "") {
        setdvar(#"scr_game_rankenabled", 1);
    }
    level.rankenabled = getdvarint(#"scr_game_rankenabled", 0);
    if (getdvarstring(#"scr_game_medalsenabled") == "") {
        setdvar(#"scr_game_medalsenabled", 1);
    }
    level.medalsenabled = getdvarint(#"scr_game_medalsenabled", 0);
    if (level.hardcoremode && level.rankedmatch && getdvarstring(#"scr_game_friendlyfiredelay") == "") {
        setdvar(#"scr_game_friendlyfiredelay", 1);
    }
    level.friendlyfiredelay = getdvarint(#"scr_game_friendlyfiredelay", 0);
    setclientnamemode("auto_change");
    if (getdvarint(#"custom_killstreak_mode", 0) == 1) {
        level.killstreaksenabled = 0;
    }
    /#
        setdebugsideswitch(game.switchedsides);
    #/
}

// Namespace globallogic/globallogic
// Params 0, eflags: 0x0
// Checksum 0x869044df, Offset: 0xd4c8
// Size: 0x15c
function callback_startgametype() {
    function_98cb5f3b();
    [[ level.var_ec2732d9 ]]();
    gametype::on_start_game_type();
    callback::callback(#"on_start_gametype");
    [[ level.onstartgametype ]]();
    level thread function_61fd6a1e();
    level thread killcam::do_final_killcam();
    thread startgame();
    level thread simple_hostmigration::updatehostmigrationdata();
    /#
        if (getdvarint(#"scr_writeconfigstrings", 0) == 1) {
            level.skipgameend = 1;
            level.roundlimit = 1;
            wait 1;
            thread forceend(0);
        }
        if (getdvarint(#"scr_hostmigrationtest", 0) == 1) {
            thread forcedebughostmigration();
        }
    #/
}

// Namespace globallogic/globallogic
// Params 0, eflags: 0x0
// Checksum 0xd08681bd, Offset: 0xd630
// Size: 0x7c
function function_61fd6a1e() {
    waittillframeend();
    while (game.state != "playing") {
        waitframe(1);
    }
    specialistswitchislethal = 1;
    if (isdefined(level.var_f1294938) && level.var_f1294938) {
        specialistswitchislethal = 0;
    }
    level clientfield::set_world_uimodel("hudItems.specialistSwitchIsLethal", specialistswitchislethal);
}

/#

    // Namespace globallogic/globallogic
    // Params 0, eflags: 0x0
    // Checksum 0x333c7084, Offset: 0xd6b8
    // Size: 0x50
    function forcedebughostmigration() {
        while (true) {
            hostmigration::waittillhostmigrationdone();
            wait 60;
            starthostmigration();
            hostmigration::waittillhostmigrationdone();
        }
    }

#/

// Namespace globallogic/globallogic
// Params 4, eflags: 0x0
// Checksum 0xbca61b5, Offset: 0xd710
// Size: 0x116
function registerfriendlyfiredelay(dvarstring, defaultvalue, minvalue, maxvalue) {
    dvarstring = "scr_" + dvarstring + "_friendlyFireDelayTime";
    if (getdvarstring(dvarstring) == "") {
        setdvar(dvarstring, defaultvalue);
    }
    if (getdvarint(dvarstring, 0) > maxvalue) {
        setdvar(dvarstring, maxvalue);
    } else if (getdvarint(dvarstring, 0) < minvalue) {
        setdvar(dvarstring, minvalue);
    }
    level.friendlyfiredelaytime = getdvarint(dvarstring, 0);
}

// Namespace globallogic/globallogic
// Params 0, eflags: 0x0
// Checksum 0x7822033e, Offset: 0xd830
// Size: 0x64
function listenforgameend() {
    self endon(#"disconnect");
    self waittill(#"host_sucks_end_game");
    level.skipvote = 1;
    if (!level.gameended) {
        level thread forceend(1);
    }
}

// Namespace globallogic/globallogic
// Params 1, eflags: 0x0
// Checksum 0x867f5cda, Offset: 0xd8a0
// Size: 0x114
function getkillstreaks(player) {
    for (killstreaknum = 0; killstreaknum < level.maxkillstreaks; killstreaknum++) {
        killstreak[killstreaknum] = "killstreak_null";
    }
    if (isplayer(player) && level.disableclassselection != 1 && !isbot(player) && isdefined(player.killstreak)) {
        currentkillstreak = 0;
        for (killstreaknum = 0; killstreaknum < level.maxkillstreaks; killstreaknum++) {
            if (isdefined(player.killstreak[killstreaknum])) {
                killstreak[currentkillstreak] = player.killstreak[killstreaknum];
                currentkillstreak++;
            }
        }
    }
    return killstreak;
}

// Namespace globallogic/globallogic
// Params 1, eflags: 0x0
// Checksum 0x511a3fc5, Offset: 0xd9c0
// Size: 0x74
function updaterankedmatch(outcome) {
    if (level.rankedmatch) {
        if (hostidledout()) {
            level.hostforcedend = 1;
            /#
                print("<dev string:xad>");
            #/
        }
    }
    globallogic_score::updatematchbonusscores(outcome);
}

// Namespace globallogic/globallogic
// Params 2, eflags: 0x0
// Checksum 0x98d3e703, Offset: 0xda40
// Size: 0x11c
function annihilatorgunplayerkilleffect(attacker, weapon) {
    if (weapon.fusetime != 0) {
        wait 0.1;
    } else {
        wait 0.45;
    }
    if (!isdefined(self)) {
        return;
    }
    self playsoundtoplayer(#"evt_annihilation_plr", attacker);
    self playsoundtoallbutplayer(#"evt_annihilation_npc", attacker);
    codesetclientfield(self, "annihilate_effect", 1);
    earthquake(0.3, 0.75, self.origin, 500);
    wait 0.1;
    if (!isdefined(self)) {
        return;
    }
    self notsolid();
    self ghost();
}

// Namespace globallogic/globallogic
// Params 2, eflags: 0x0
// Checksum 0xfaf6c735, Offset: 0xdb68
// Size: 0x15c
function annihilatorgunactorkilleffect(attacker, weapon) {
    waitresult = self waittill(#"actor_corpse");
    body = waitresult.corpse;
    if (weapon.fusetime != 0) {
        wait weapon.fusetime * 0.001;
    } else {
        wait 0.45;
    }
    if (!isdefined(self)) {
        return;
    }
    self playsoundtoplayer(#"evt_annihilation_plr", attacker);
    self playsoundtoallbutplayer(#"evt_annihilation_npc", attacker);
    if (!isdefined(body)) {
        return;
    }
    codesetclientfield(body, "annihilate_effect", 1);
    body shake_and_rumble(0, 0.6, 0.2, 1);
    body notsolid();
    body ghost();
}

// Namespace globallogic/globallogic
// Params 1, eflags: 0x0
// Checksum 0xf75979a4, Offset: 0xdcd0
// Size: 0xcc
function pineapplegunplayerkilleffect(attacker) {
    wait 0.1;
    if (!isdefined(self)) {
        return;
    }
    playsoundatposition(#"evt_annihilation_npc", self.origin);
    codesetclientfield(self, "pineapplegun_effect", 1);
    self shake_and_rumble(0, 0.3, 0.35, 1);
    wait 0.1;
    if (!isdefined(self)) {
        return;
    }
    self notsolid();
    self ghost();
}

// Namespace globallogic/globallogic
// Params 0, eflags: 0x0
// Checksum 0xabbebac7, Offset: 0xdda8
// Size: 0xbc
function bowplayerkilleffect() {
    waitframe(1);
    if (!isdefined(self)) {
        return;
    }
    playsoundatposition(#"evt_annihilation_npc", self.origin);
    codesetclientfield(self, "annihilate_effect", 1);
    self shake_and_rumble(0, 0.3, 0.35, 1);
    if (!isdefined(self)) {
        return;
    }
    self notsolid();
    self ghost();
}

// Namespace globallogic/globallogic
// Params 0, eflags: 0x0
// Checksum 0x2e92069, Offset: 0xde70
// Size: 0xfc
function pineapplegunactorkilleffect() {
    waitresult = self waittill(#"actor_corpse");
    body = waitresult.corpse;
    wait 0.75;
    if (!isdefined(self)) {
        return;
    }
    playsoundatposition(#"evt_annihilation_npc", self.origin);
    if (!isdefined(body)) {
        return;
    }
    codesetclientfield(body, "pineapplegun_effect", 1);
    body shake_and_rumble(0, 0.3, 0.75, 1);
    body notsolid();
    body ghost();
}

// Namespace globallogic/globallogic
// Params 4, eflags: 0x0
// Checksum 0xc3ac8aae, Offset: 0xdf78
// Size: 0xee
function shake_and_rumble(n_delay, shake_size, shake_time, rumble_num) {
    if (isdefined(n_delay) && n_delay > 0) {
        wait n_delay;
    }
    nmagnitude = shake_size;
    nduration = shake_time;
    nradius = 500;
    v_pos = self.origin;
    earthquake(nmagnitude, nduration, v_pos, nradius);
    for (i = 0; i < rumble_num; i++) {
        self playrumbleonentity("damage_heavy");
        wait 0.1;
    }
}

// Namespace globallogic/globallogic
// Params 8, eflags: 0x0
// Checksum 0x9ebdea3a, Offset: 0xe070
// Size: 0xac
function doweaponspecifickilleffects(einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime) {
    if (weapon.name == "hero_pineapplegun" && isplayer(attacker) && smeansofdeath == "MOD_GRENADE") {
        attacker playlocalsound(#"wpn_pineapple_grenade_explode_flesh_2d");
    }
}

// Namespace globallogic/globallogic
// Params 4, eflags: 0x0
// Checksum 0x4acade1, Offset: 0xe128
// Size: 0x100
function function_ce510c1c(weapon, attacker, einflictor, smeansofdeath) {
    if (!weapon.doannihilate) {
        return false;
    }
    if (!isplayer(attacker)) {
        return false;
    }
    if (smeansofdeath != "MOD_IMPACT" && smeansofdeath != "MOD_GRENADE" && smeansofdeath != "MOD_GRENADE_SPLASH") {
        return false;
    }
    if (smeansofdeath == "MOD_IMPACT" && weapon.var_36ea826) {
        return false;
    }
    if (!(smeansofdeath == "MOD_GRENADE_SPLASH" && isdefined(einflictor) && isdefined(einflictor.stucktoplayer) && einflictor.stucktoplayer == self)) {
        return false;
    }
    return true;
}

// Namespace globallogic/globallogic
// Params 9, eflags: 0x0
// Checksum 0x2f544d42, Offset: 0xe230
// Size: 0x1d4
function doweaponspecificcorpseeffects(body, einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime) {
    if (!isdefined(weapon)) {
        return;
    }
    if (function_ce510c1c(weapon, attacker, einflictor, smeansofdeath)) {
        if (isactor(body)) {
            body thread annihilatorgunactorkilleffect(attacker, weapon);
        } else {
            body thread annihilatorgunplayerkilleffect(attacker, weapon);
        }
        return;
    }
    if (smeansofdeath == "MOD_BURNED" || smeansofdeath == "MOD_DOT" && weapon.doesfiredamage) {
        if (!isactor(body)) {
            body thread burncorpse();
        }
        return;
    }
    if (weapon.isheavyweapon && isplayer(attacker)) {
        if (weapon.name == #"hero_firefly_swarm") {
            value = randomint(2) + 1;
            if (!isactor(body)) {
                codesetclientfield(body, "firefly_effect", value);
            }
        }
    }
}

// Namespace globallogic/globallogic
// Params 0, eflags: 0x0
// Checksum 0x6892c6c4, Offset: 0xe410
// Size: 0x64
function burncorpse() {
    self endon(#"death");
    codesetclientfield(self, "burned_effect", 1);
    wait 6;
    codesetclientfield(self, "burned_effect", 0);
}

