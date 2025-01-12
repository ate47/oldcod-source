#using script_1cc417743d7c262d;
#using script_335d0650ed05d36d;
#using script_3d703ef87a841fe4;
#using script_44b0b8420eabacad;
#using script_6167e26342be354b;
#using script_67ce8e728d8f37ba;
#using scripts\abilities\ability_power;
#using scripts\core_common\array_shared;
#using scripts\core_common\battlechatter;
#using scripts\core_common\bb_shared;
#using scripts\core_common\bots\bot;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\challenges_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\contracts_shared;
#using scripts\core_common\damagefeedback_shared;
#using scripts\core_common\demo_shared;
#using scripts\core_common\dogtags;
#using scripts\core_common\flag_shared;
#using scripts\core_common\gameobjects_shared;
#using scripts\core_common\gamestate;
#using scripts\core_common\gametype_shared;
#using scripts\core_common\globallogic\globallogic_shared;
#using scripts\core_common\healthoverlay;
#using scripts\core_common\high_value_operative;
#using scripts\core_common\hostmigration_shared;
#using scripts\core_common\hud_message_shared;
#using scripts\core_common\hud_shared;
#using scripts\core_common\hud_util_shared;
#using scripts\core_common\influencers_shared;
#using scripts\core_common\killcam_shared;
#using scripts\core_common\laststand_shared;
#using scripts\core_common\lui_shared;
#using scripts\core_common\map;
#using scripts\core_common\match_record;
#using scripts\core_common\math_shared;
#using scripts\core_common\persistence_shared;
#using scripts\core_common\player\player_loadout;
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
#using scripts\mp_common\challenges;
#using scripts\mp_common\draft;
#using scripts\mp_common\gameadvertisement;
#using scripts\mp_common\gamerep;
#using scripts\mp_common\gametypes\clientids;
#using scripts\mp_common\gametypes\deathicons;
#using scripts\mp_common\gametypes\dev;
#using scripts\mp_common\gametypes\display_transition;
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
#using scripts\mp_common\gametypes\radar_sweeps;
#using scripts\mp_common\gametypes\round;
#using scripts\mp_common\gametypes\serversettings;
#using scripts\mp_common\gametypes\shellshock;
#using scripts\mp_common\player\player;
#using scripts\mp_common\player\player_loadout;
#using scripts\mp_common\player\player_monitor;
#using scripts\mp_common\player\player_record;
#using scripts\mp_common\player\player_utils;
#using scripts\mp_common\rat;
#using scripts\mp_common\teams\teams;
#using scripts\mp_common\userspawnselection;
#using scripts\mp_common\util;
#using scripts\weapons\mp\weapons;
#using scripts\weapons\weapon_utils;
#using scripts\weapons\weapons;

#namespace globallogic;

// Namespace globallogic/globallogic
// Params 0, eflags: 0x6
// Checksum 0x607b75c3, Offset: 0xf88
// Size: 0x44
function private autoexec __init__system__() {
    system::register(#"globallogic", &function_70a657d8, undefined, undefined, #"visionset_mgr");
}

// Namespace globallogic/globallogic
// Params 0, eflags: 0x5 linked
// Checksum 0x93d8ce06, Offset: 0xfd8
// Size: 0x304
function private function_70a657d8() {
    if (!isdefined(level.vsmgr_prio_visionset_mpintro)) {
        level.vsmgr_prio_visionset_mpintro = 5;
    }
    visionset_mgr::register_info("visionset", "mpintro", 1, level.vsmgr_prio_visionset_mpintro, 31, 0, &visionset_mgr::ramp_in_out_thread, 0);
    level.host_migration_activate_visionset_func = &mpintro_visionset_activate_func;
    level.host_migration_deactivate_visionset_func = &mpintro_visionset_deactivate_func;
    visionset_mgr::register_info("visionset", "crithealth", 1, 4, 25, 1, &visionset_mgr::ramp_in_out_thread_per_player, 0);
    clientfield::register_clientuimodel("huditems.killedByEntNum", 1, 4, "int");
    clientfield::register_clientuimodel("huditems.killedByAttachmentCount", 1, 4, "int");
    clientfield::register_clientuimodel("huditems.killedByItemIndex", 1, 10, "int");
    clientfield::register_clientuimodel("huditems.killedByMOD", 1, 8, "int");
    for (index = 0; index < 5; index++) {
        clientfield::register_clientuimodel("huditems.killedByAttachment" + index, 1, 6, "int");
    }
    clientfield::register("toplayer", "thermal_sight", 1, 1, "int");
    clientfield::register("toplayer", "strobe_light", 1, 1, "int");
    clientfield::register("allplayers", "cold_blooded", 1, 1, "int");
    level.var_462db2cf = getweapon(#"hero_pineapplegun");
    level.var_bfce6749 = getweapon(#"hero_pineapple_grenade");
    ability_power::function_9d78823f(level.var_462db2cf, level.var_bfce6749);
    callback::on_spawned(&on_player_spawned);
    callback::on_game_playing(&on_game_playing);
}

// Namespace globallogic/globallogic
// Params 0, eflags: 0x5 linked
// Checksum 0xf7f47523, Offset: 0x12e8
// Size: 0x2e
function private on_player_spawned() {
    self clientfield::set_player_uimodel("huditems.killedByEntNum", 15);
    self.strobed = 0;
}

// Namespace globallogic/globallogic
// Params 0, eflags: 0x1 linked
// Checksum 0x9845195b, Offset: 0x1320
// Size: 0xe9c
function init() {
    level.splitscreen = issplitscreen();
    level.xenon = getdvarstring(#"xenongame") == "true";
    level.ps3 = getdvarstring(#"ps3game") == "true";
    level.wiiu = getdvarstring(#"wiiugame") == "true";
    level.orbis = getdvarstring(#"orbisgame") == "true";
    level.durango = getdvarstring(#"durangogame") == "true";
    level.console = getdvarstring(#"consolegame") == "true";
    level.onlinegame = sessionmodeisonlinegame();
    level.systemlink = sessionmodeissystemlink();
    level.rankedmatch = gamemodeisusingxp();
    level.leaguematch = 0;
    level.custommatch = gamemodeismode(1) || gamemodeismode(7);
    level.arenamatch = gamemodeisarena();
    level.mpcustommatch = level.custommatch;
    level.contractsenabled = !getgametypesetting(#"disablecontracts");
    level.contractsenabled = 0;
    level.disablevehicleburndamage = 1;
    level.var_49d9aa70 = 1;
    /#
        if (getdvarint(#"scr_forcerankedmatch", 0) == 1) {
            level.rankedmatch = 1;
        }
    #/
    level.script = util::get_map_name();
    level.gametype = util::get_game_type();
    level.var_837aa533 = hash(level.gametype);
    if (isdefined(level.gametype)) {
        level.var_12323003 = function_16495154(level.gametype);
    }
    level.teambased = 0;
    level.teamcount = getgametypesetting(#"teamcount");
    /#
        level.teamcount = math::clamp(level.teamcount, 1, getdvarint(#"com_maxclients", level.teamcount));
    #/
    level.multiteam = level.teamcount > 2;
    level.maxteamplayers = getgametypesetting(#"maxteamplayers");
    level.var_704bcca1 = getgametypesetting(#"hash_3a4691a853585241");
    level.competitivesettingsenabled = getgametypesetting(#"competitivesettings") === 1;
    level.competitiveteamlives = getgametypesetting(#"competitiveteamlives") === 1;
    level.teamscoreperkill = getgametypesetting(#"teamscoreperkill");
    level.teamscoreperdeath = getgametypesetting(#"teamscoreperdeath");
    level.teamscoreperheadshot = getgametypesetting(#"teamscoreperheadshot");
    level.killstreaksgivegamescore = getgametypesetting(#"killstreaksgivegamescore");
    setmatchflag("game_ended", 0);
    gametype::init();
    gametype::init_mp();
    init_teams();
    level.var_724cf71 = 1;
    /#
        thread function_340107d4();
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
    setdvar(#"bg_boastenabled", getgametypesetting(#"boastenabled"));
    setdvar(#"hash_e099986c072eb0f", getgametypesetting(#"hash_104f124f56f0f20a"));
    setdvar(#"hash_553ad8f9db24bf22", int(1000 * getgametypesetting(#"hash_1614b9cbe0df6f75")));
    function_9afe34e3();
    gameobjects::register_allowed_gameobject(level.gametype);
    if (isdefined(level.var_d1455682)) {
        gameobjectname = level.var_d1455682.gameobjectname;
        if (isdefined(gameobjectname)) {
            gameobjects::register_allowed_gameobject(gameobjectname);
        }
    }
    map::init();
    globallogic_ui::init();
    registerdvars();
    loadout::init_dvars();
    level.oldschool = getgametypesetting(#"oldschoolmode");
    display_transition::init_shared();
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
    clientfield::register_clientuimodel("hudItems.hideOutcomeUI", 1, 1, "int");
    clientfield::register_clientuimodel("hudItems.captureCrateState", 1, 2, "int");
    clientfield::register_clientuimodel("hudItems.captureCrateTotalTime", 1, 13, "int");
    clientfield::function_5b7d846d("hudItems.team1.roundsWon", 1, 4, "int");
    clientfield::function_5b7d846d("hudItems.team1.livesCount", 1, 8, "int");
    clientfield::function_5b7d846d("hudItems.team1.noRespawnsLeft", 1, 1, "int");
    clientfield::function_5b7d846d("hudItems.team2.roundsWon", 1, 4, "int");
    clientfield::function_5b7d846d("hudItems.team2.livesCount", 1, 8, "int");
    clientfield::function_5b7d846d("hudItems.team2.noRespawnsLeft", 1, 1, "int");
    clientfield::register_clientuimodel("hudItems.playerLivesCount", 1, 8, "int", 0);
    clientfield::register_clientuimodel("hudItems.armorIsOnCooldown", 1, 1, "int");
    level thread setroundswonuimodels();
    level.figure_out_attacker = &player::figure_out_attacker;
    level.figure_out_friendly_fire = &player::figure_out_friendly_fire;
    thread hud_message::init();
    util::registerroundswitch(0, 9);
    util::registertimelimit(0, 1440);
    util::registerscorelimit(0, 50000);
    util::registerroundlimit(0, 10);
    util::registerroundwinlimit(0, 10);
    util::registernumlives(0, 100);
    registerfriendlyfiredelay(level.gametype, 15, 0, 1440);
}

/#

    // Namespace globallogic/globallogic
    // Params 0, eflags: 0x0
    // Checksum 0xbb561ca6, Offset: 0x21c8
    // Size: 0x50
    function function_340107d4() {
        while (true) {
            wait 2;
            level.var_724cf71 = getdvarint(#"scr_ekia", level.var_724cf71);
        }
    }

#/

// Namespace globallogic/globallogic
// Params 0, eflags: 0x5 linked
// Checksum 0xb55a1f70, Offset: 0x2220
// Size: 0x1ac
function private init_teams() {
    level.teams = [];
    level.teamindex = [];
    teamcount = level.teamcount;
    level.teams[#"allies"] = "allies";
    if (level.teamcount > 1) {
        level.teams[#"axis"] = "axis";
    }
    level.teamindex[#"world"] = "world";
    level.teamindex[#"neutral"] = 0;
    level.teamindex[#"allies"] = 1;
    level.teamindex[#"axis"] = 2;
    for (teamindex = 3; teamindex < teamcount + 1; teamindex++) {
        level.teams[hash("team" + teamindex)] = "team" + teamindex;
        level.teamindex[hash("team" + teamindex)] = teamindex;
    }
    level.var_75dffa9f = [];
    callback::callback(#"init_teams");
}

// Namespace globallogic/globallogic
// Params 0, eflags: 0x1 linked
// Checksum 0x978aaf52, Offset: 0x23d8
// Size: 0x1b4
function function_9afe34e3() {
    level.var_336c35f1 = [];
    globallogic_utils::function_4aa8d809(0, "dnf");
    globallogic_utils::function_4aa8d809(1, "completed");
    globallogic_utils::function_4aa8d809(2, "time limit");
    globallogic_utils::function_4aa8d809(3, "scorelimit");
    globallogic_utils::function_4aa8d809(4, "roundscorelimit");
    globallogic_utils::function_4aa8d809(5, "roundlimit");
    globallogic_utils::function_4aa8d809(6, "team eliminated");
    globallogic_utils::function_4aa8d809(7, "forfeit");
    globallogic_utils::function_4aa8d809(8, "ended game");
    globallogic_utils::function_4aa8d809(9, "host ended game");
    globallogic_utils::function_4aa8d809(10, "host ended sucks");
    for (i = 0; i < 5; i++) {
        globallogic_utils::function_4aa8d809(11 + i, "gamemode-specific");
    }
}

// Namespace globallogic/globallogic
// Params 0, eflags: 0x1 linked
// Checksum 0xe72fe813, Offset: 0x2598
// Size: 0x114
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
// Params 0, eflags: 0x1 linked
// Checksum 0x5bf381b2, Offset: 0x26b8
// Size: 0xec
function setroundswonuimodels() {
    waitframe(1);
    if (level.roundlimit == 1) {
        return;
    }
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
// Params 10, eflags: 0x1 linked
// Checksum 0x179ed741, Offset: 0x27b0
// Size: 0x54
function blank(*arg1, *arg2, *arg3, *arg4, *arg5, *arg6, *arg7, *arg8, *arg9, *arg10) {
    
}

// Namespace globallogic/globallogic
// Params 0, eflags: 0x1 linked
// Checksum 0x3156866d, Offset: 0x2810
// Size: 0x4f4
function setup_callbacks() {
    level.spawnplayer = &globallogic_spawn::function_baf09253;
    level.spawnplayerprediction = &globallogic_spawn::spawnplayerprediction;
    level.spawnclient = &globallogic_spawn::spawnclient;
    level.spawnspectator = &globallogic_spawn::spawnspectator;
    level.spawnintermission = &globallogic_spawn::spawnintermission;
    level.scoreongiveplayerscore = &globallogic_score::giveplayerscore;
    level.onplayerscore = &globallogic_score::default_onplayerscore;
    level.onteamscore = &globallogic_score::default_onteamscore;
    level.gamehistoryplayerkicked = &gamehistoryplayerkicked;
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
    level.gettimepassed = &globallogic_utils::gettimepassed;
    level.gettimelimit = &globallogic_defaults::default_gettimelimit;
    level.getteamkillpenalty = &globallogic_defaults::default_getteamkillpenalty;
    level.getteamkillscore = &globallogic_defaults::default_getteamkillscore;
    level.iskillboosting = &globallogic_score::default_iskillboosting;
    level.var_37d62931 = &globallogic_score::function_37d62931;
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
    level.var_da2045d0 = [];
    level.var_fa66fada = [];
    level.var_6c4ec3fc = &function_8af3b312;
    level.onteamoutcomenotify = &hud_message::teamoutcomenotify;
    level.onoutcomenotify = &hud_message::outcomenotify;
    level.onendround = &blank;
    level.onendgame = &globallogic_defaults::onendgame;
    level.onmedalawarded = &blank;
    if (sessionmodeiswarzonegame()) {
        level.var_b10e134d = &player_monitor::function_d35f877a;
    }
    level callback::add_callback(#"on_last_alive", &globallogic_defaults::function_dcf41142);
    level callback::add_callback(#"hash_6b7d26d34885b425", &function_b29d2423);
    globallogic_ui::setupcallbacks();
}

// Namespace globallogic/globallogic
// Params 0, eflags: 0x1 linked
// Checksum 0x832a517b, Offset: 0x2d10
// Size: 0xe4
function precache_mp_friend_leaderboards() {
    hardcoremode = getgametypesetting(#"hardcoremode");
    if (!isdefined(hardcoremode)) {
        hardcoremode = 0;
    }
    arenamode = gamemodeisarena();
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
// Params 0, eflags: 0x1 linked
// Checksum 0xad12f3eb, Offset: 0x2e00
// Size: 0xf4
function precache_mp_anticheat_leaderboards() {
    hardcoremode = getgametypesetting(#"hardcoremode");
    if (!isdefined(hardcoremode)) {
        hardcoremode = 0;
    }
    arenamode = gamemodeisarena();
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
// Params 0, eflags: 0x1 linked
// Checksum 0xde84f97d, Offset: 0x2f00
// Size: 0x1ec
function precache_mp_public_leaderboards() {
    mapname = util::get_map_name();
    hardcoremode = getgametypesetting(#"hardcoremode");
    if (!isdefined(hardcoremode)) {
        hardcoremode = 0;
    }
    arenamode = gamemodeisarena();
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
    if (gamemodeisarena()) {
        arenaslot = arenagetslot();
        arenaleaderboard = " LB_MP_ARENA_MASTERS_0" + arenaslot;
    }
    precacheleaderboards(gamemodeleaderboard + careerleaderboard + prestigelb + arenaleaderboard);
}

// Namespace globallogic/globallogic
// Params 0, eflags: 0x1 linked
// Checksum 0xea75850a, Offset: 0x30f8
// Size: 0x44
function precache_mp_custom_leaderboards() {
    customleaderboards = "LB_MP_CG_" + level.gametype;
    precacheleaderboards("LB_MP_CG_GENERAL " + customleaderboards);
}

// Namespace globallogic/globallogic
// Params 0, eflags: 0x1 linked
// Checksum 0xb2e36ee3, Offset: 0x3148
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
// Params 1, eflags: 0x1 linked
// Checksum 0xe5e443c, Offset: 0x31e0
// Size: 0xd4
function forceend(hostsucks = 0) {
    if (level.hostforcedend || level.forcedend) {
        return;
    }
    level.forcedend = 1;
    level.hostforcedend = 1;
    if (hostsucks) {
        var_c1e98979 = 10;
    } else {
        var_c1e98979 = 9;
    }
    setmatchflag("disableIngameMenu", 1);
    round::function_870759fb();
    round::set_flag("force_end_host");
    thread end_round(var_c1e98979);
}

// Namespace globallogic/globallogic
// Params 0, eflags: 0x1 linked
// Checksum 0x1099ea83, Offset: 0x32c0
// Size: 0x94
function killserverpc() {
    if (level.hostforcedend || level.forcedend) {
        return;
    }
    level.forcedend = 1;
    level.hostforcedend = 1;
    level.killserver = 1;
    round::set_flag("force_end_host");
    round::function_870759fb();
    thread end_round(9);
}

// Namespace globallogic/globallogic
// Params 0, eflags: 0x1 linked
// Checksum 0xcc574193, Offset: 0x3360
// Size: 0xb0
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
// Params 1, eflags: 0x1 linked
// Checksum 0xb08d247, Offset: 0x3418
// Size: 0x44
function function_f25690c1(team) {
    if (!game.everexisted[team]) {
        return false;
    }
    if (level.playercount[team] < 1) {
        return true;
    }
    return false;
}

// Namespace globallogic/globallogic
// Params 0, eflags: 0x1 linked
// Checksum 0x51c74e3c, Offset: 0x3468
// Size: 0x234
function function_4b670b29() {
    if (game.state != "playing") {
        return false;
    }
    if (util::totalplayercount() == 0) {
        return false;
    }
    params = {#teams_forfeited:[], #var_6eb69269:[]};
    foreach (team, _ in level.teams) {
        if (function_f25690c1(team)) {
            if (!isdefined(params.teams_forfeited)) {
                params.teams_forfeited = [];
            } else if (!isarray(params.teams_forfeited)) {
                params.teams_forfeited = array(params.teams_forfeited);
            }
            params.teams_forfeited[params.teams_forfeited.size] = team;
            continue;
        }
        if (!isdefined(params.var_6eb69269)) {
            params.var_6eb69269 = [];
        } else if (!isarray(params.var_6eb69269)) {
            params.var_6eb69269 = array(params.var_6eb69269);
        }
        params.var_6eb69269[params.var_6eb69269.size] = team;
    }
    if (params.var_6eb69269.size == 1 && params.teams_forfeited.size > 0) {
        thread [[ level.onforfeit ]](params);
        return true;
    }
    return false;
}

// Namespace globallogic/globallogic
// Params 0, eflags: 0x1 linked
// Checksum 0x1fa6d627, Offset: 0x36a8
// Size: 0x9c
function dospawnqueueupdates() {
    foreach (team, _ in level.teams) {
        if (level.spawnqueuemodified[team]) {
            [[ level.onalivecountchange ]](team);
        }
    }
}

// Namespace globallogic/globallogic
// Params 1, eflags: 0x1 linked
// Checksum 0x3eb2871e, Offset: 0x3750
// Size: 0x74
function function_7b75ee16(team) {
    if (level.playerlives[team] && !squad_spawn::function_d072f205()) {
        return true;
    }
    if (function_a1ef346b(team).size - level.laststandcount[team] > 0) {
        return true;
    }
    return false;
}

// Namespace globallogic/globallogic
// Params 0, eflags: 0x1 linked
// Checksum 0x5d475fb6, Offset: 0x37d0
// Size: 0x1ec
function function_9c839e9() {
    params = {#var_8245068d:0, #var_46a749a8:[], #teams_alive:[]};
    aliveteam = undefined;
    foreach (team, _ in level.teams) {
        if (teams::function_9dd75dad(team)) {
            params.var_8245068d++;
            if (!teams::is_all_dead(team)) {
                if (!isdefined(params.teams_alive)) {
                    params.teams_alive = [];
                } else if (!isarray(params.teams_alive)) {
                    params.teams_alive = array(params.teams_alive);
                }
                params.teams_alive[params.teams_alive.size] = team;
                continue;
            }
            if (!isdefined(params.var_46a749a8)) {
                params.var_46a749a8 = [];
            } else if (!isarray(params.var_46a749a8)) {
                params.var_46a749a8 = array(params.var_46a749a8);
            }
            params.var_46a749a8[params.var_46a749a8.size] = team;
        }
    }
    return params;
}

// Namespace globallogic/globallogic
// Params 1, eflags: 0x1 linked
// Checksum 0xef7bec1b, Offset: 0x39c8
// Size: 0x52
function function_10dc43bc(params) {
    if (params.var_8245068d == 0) {
        return false;
    }
    if (params.teams_alive.size == 1 && params.var_46a749a8.size > 0) {
        return true;
    }
    return false;
}

// Namespace globallogic/globallogic
// Params 0, eflags: 0x5 linked
// Checksum 0xb7d03f51, Offset: 0x3a28
// Size: 0xe2
function private function_eb1c0d37() {
    if (level.var_f97a6ba3 && !level.var_4ad4bec3) {
        return false;
    }
    foreach (team, _ in level.teams) {
        if (!level.var_f97a6ba3 && !level.everexisted[team]) {
            return false;
        }
        if (!teams::is_all_dead(team)) {
            return false;
        }
    }
    return true;
}

// Namespace globallogic/globallogic
// Params 0, eflags: 0x1 linked
// Checksum 0xc99619d9, Offset: 0x3b18
// Size: 0x284
function dodeadeventupdates() {
    if (level.teambased) {
        if (function_eb1c0d37()) {
            level callback::callback(#"hash_8a248204daef7ec");
            if (isdefined(level.ondeadevent)) {
                [[ level.ondeadevent ]]("all");
            }
            return true;
        }
        foreach (team, _ in level.teams) {
            if (teams::function_9dd75dad(team) && !level.teameliminated[team]) {
                if (!function_7b75ee16(team)) {
                    level.teameliminated[team] = gettime();
                    level callback::callback(#"on_team_eliminated", team);
                    if (isdefined(level.ondeadevent)) {
                        [[ level.ondeadevent ]](team);
                    }
                }
            }
        }
        params = function_9c839e9();
        if (function_10dc43bc(params)) {
            level callback::callback(#"on_last_alive", params);
            return true;
        }
    } else if (totalalivecount() == 0 && totalplayerlives() == 0 && level.maxplayercount > 1) {
        level callback::callback(#"hash_8a248204daef7ec");
        if (isdefined(level.ondeadevent)) {
            [[ level.ondeadevent ]]("all");
        }
        return true;
    }
    return false;
}

// Namespace globallogic/globallogic
// Params 1, eflags: 0x5 linked
// Checksum 0x1e03284f, Offset: 0x3da8
// Size: 0xb8
function private function_e356468d(team) {
    if (level.var_1c9c46fd[team] === 1) {
        return false;
    }
    if (function_a1ef346b(team).size != 1) {
        return false;
    }
    if (level.playerlives[team] != 1) {
        return false;
    }
    if (function_a1ef346b(team).size && function_a1ef346b(team)[0] laststand::player_is_in_laststand()) {
        return false;
    }
    return true;
}

// Namespace globallogic/globallogic
// Params 1, eflags: 0x5 linked
// Checksum 0x13826d22, Offset: 0x3e68
// Size: 0x34
function private function_d0c92f82(team) {
    [[ level.ononeleftevent ]](team);
    level.var_1c9c46fd[team] = 1;
}

// Namespace globallogic/globallogic
// Params 0, eflags: 0x1 linked
// Checksum 0x4e181a25, Offset: 0x3ea8
// Size: 0x110
function doonelefteventupdates() {
    if (level.teambased) {
        foreach (team, _ in level.teams) {
            if (function_e356468d(team)) {
                function_d0c92f82(team);
            }
        }
        return;
    }
    if (totalalivecount() == 1 && totalplayerlives() == 1 && level.maxplayercount > 1) {
        [[ level.ononeleftevent ]]("all");
    }
}

// Namespace globallogic/globallogic
// Params 1, eflags: 0x1 linked
// Checksum 0xedb89252, Offset: 0x3fc0
// Size: 0x2ec
function function_b29d2423(*params) {
    /#
        if (getdvarint(#"scr_hostmigrationtest", 0) == 1 || getdvarint(#"hash_5fd4b23e56c1d291", 0) == 1) {
            return;
        }
    #/
    if (is_true(level.takelivesondeath)) {
        foreach (team, _ in level.teams) {
            player::function_c49fc862(team);
        }
    }
    if ((level.rankedmatch || level.leaguematch) && !level.ingraceperiod) {
        if (level.teambased) {
            if (!level.gameforfeited) {
                if (function_4b670b29()) {
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
    if (!level.playerqueuedrespawn && !level.numlives && !level.numteamlives && !level.var_c2cc011f && !squad_spawn::function_d072f205()) {
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
    doonelefteventupdates();
}

// Namespace globallogic/globallogic
// Params 0, eflags: 0x1 linked
// Checksum 0x8c80f6, Offset: 0x42b8
// Size: 0x7e
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
// Params 0, eflags: 0x1 linked
// Checksum 0x76f1b324, Offset: 0x4340
// Size: 0x3c
function mpintro_visionset_activate_func() {
    visionset_mgr::activate("visionset", "mpintro", undefined, 0, &mpintro_visionset_ramp_hold_func, 2);
}

// Namespace globallogic/globallogic
// Params 0, eflags: 0x1 linked
// Checksum 0x402886e9, Offset: 0x4388
// Size: 0x18
function mpintro_visionset_deactivate_func() {
    level notify(#"mpintro_ramp_out_notify");
}

// Namespace globallogic/globallogic
// Params 2, eflags: 0x1 linked
// Checksum 0xc5555f82, Offset: 0x43a8
// Size: 0x1e8
function showobjectivenotificationuiforallplayers(*missiontype, delay) {
    level endon(#"game_ended");
    if (!isdefined(delay) || delay < 2) {
        delay = 2;
    }
    if (sessionmodeismultiplayergame()) {
        menudelay = getgametypesetting(#"bountypurchasephaseduration");
        if (isdefined(menudelay)) {
            delay += menudelay;
        }
    }
    wait delay;
    foreach (player in level.players) {
        team = player.pers[#"team"];
        if (team === #"spectator") {
            continue;
        }
        hintmessage = util::function_4a118b30(team);
        if (is_true(level.var_43da49ff)) {
            player luinotifyevent(#"prematch_timer_ended", 1, 1);
            continue;
        }
        if (isdefined(hintmessage)) {
            player luinotifyevent(#"show_gametype_objective_hint", 1, hintmessage);
        }
    }
}

// Namespace globallogic/globallogic
// Params 2, eflags: 0x1 linked
// Checksum 0x94976cfa, Offset: 0x4598
// Size: 0x44c
function matchstarttimer(var_885aa5b1, var_1be62bdc) {
    println("<dev string:x38>");
    mpintro_visionset_activate_func();
    waitforplayers();
    if (isdefined(var_1be62bdc)) {
        level flag::wait_till(var_1be62bdc);
    }
    counttime = int(var_885aa5b1);
    var_5654073f = counttime >= 2;
    level.var_5654073f = var_5654073f;
    level.var_fd167bf6 = gettime() + int(counttime * 1000);
    var_c85a136a = 0;
    var_b9ef7eae = undefined;
    luinotifyevent(#"create_prematch_timer", 2, level.var_fd167bf6, var_5654073f);
    if (var_5654073f) {
        while (counttime > 0 && !level.gameended) {
            if (counttime == 2) {
                mpintro_visionset_deactivate_func();
            }
            if (counttime <= 1) {
                if (game.roundsplayed <= 0) {
                    level thread globallogic_audio::set_music_global("spawn", 1);
                    var_c85a136a = 1;
                }
            }
            counttime--;
            var_b9ef7eae = [];
            foreach (player in level.players) {
                shouldplaysound = 1;
                for (var_3c0cc784 = 0; var_3c0cc784 < var_b9ef7eae.size; var_3c0cc784++) {
                    if (player isplayeronsamemachine(var_b9ef7eae[var_3c0cc784])) {
                        shouldplaysound = 0;
                    }
                }
                if (shouldplaysound) {
                    if (sessionmodeiswarzonegame()) {
                        player playlocalsound(#"hash_5e14726f77107d1b");
                    } else {
                        player playlocalsound(#"hash_5e14726f77107d1b");
                    }
                    var_b9ef7eae[var_b9ef7eae.size] = player;
                }
            }
            wait 1;
        }
        util::function_a3f7de13(7, 0, -1);
    } else {
        mpintro_visionset_deactivate_func();
    }
    if (isdefined(var_b9ef7eae)) {
        arrayremovevalue(var_b9ef7eae, undefined);
        foreach (player in var_b9ef7eae) {
            player playlocalsound(#"hash_66faa3f3d0b4e586");
        }
    }
    if (!var_c85a136a) {
        level thread globallogic_audio::set_music_global("none");
    }
    luinotifyevent(#"prematch_timer_ended", 1, var_5654073f);
    println("<dev string:x63>");
}

// Namespace globallogic/globallogic
// Params 0, eflags: 0x1 linked
// Checksum 0x8fc93883, Offset: 0x49f0
// Size: 0x1c
function matchstarttimerskip() {
    visionsetnaked("default", 0);
}

// Namespace globallogic/globallogic
// Params 2, eflags: 0x1 linked
// Checksum 0x559b5c9a, Offset: 0x4a18
// Size: 0x88
function notifyteamwavespawn(team, time) {
    if (time - level.lastwave[team] > int(level.wavedelay[team] * 1000)) {
        level notify("wave_respawn_" + team);
        level.lastwave[team] = time;
        level.waveplayerspawnindex[team] = 0;
        return true;
    }
    return false;
}

// Namespace globallogic/globallogic
// Params 0, eflags: 0x1 linked
// Checksum 0x49321fd8, Offset: 0x4aa8
// Size: 0x1d8
function wavespawntimer() {
    self notify("1fe65e981c9a6b27");
    self endon("1fe65e981c9a6b27");
    level endon(#"game_ended");
    level callback::callback(#"hash_3be1213f454fa90e");
    if (isdefined(level.var_75db41a7) && gettime() >= level.var_75db41a7) {
        level callback::callback(#"hash_7fc21de2eaebdb3b");
        return;
    }
    while (game.state == "playing") {
        time = gettime();
        notified = 0;
        foreach (team, _ in level.teams) {
            notified |= notifyteamwavespawn(team, time);
        }
        if (notified) {
            level callback::callback(#"hash_3be1213f454fa90e");
            if (isdefined(level.var_75db41a7) && time >= level.var_75db41a7) {
                level callback::callback(#"hash_7fc21de2eaebdb3b");
                return;
            }
        }
        waitframe(1);
    }
}

// Namespace globallogic/globallogic
// Params 0, eflags: 0x1 linked
// Checksum 0xbc73623d, Offset: 0x4c88
// Size: 0xbc
function hostidledout() {
    hostplayer = util::gethostplayer();
    /#
        if (getdvarint(#"scr_writeconfigstrings", 0) == 1 || getdvarint(#"scr_hostmigrationtest", 0) == 1) {
            return false;
        }
    #/
    if (isdefined(hostplayer) && !is_true(hostplayer.hasspawned) && !isdefined(hostplayer.selectedclass)) {
        return true;
    }
    return false;
}

// Namespace globallogic/globallogic
// Params 3, eflags: 0x1 linked
// Checksum 0xab727c05, Offset: 0x4d50
// Size: 0x6c
function incrementmatchcompletionstat(gamemode, playedorhosted, stat) {
    if (sessionmodeiswarzonegame()) {
        return;
    }
    self stats::inc_stat(#"gamehistory", gamemode, #"modehistory", playedorhosted, stat, 1);
}

// Namespace globallogic/globallogic
// Params 3, eflags: 0x0
// Checksum 0xfebf19e4, Offset: 0x4dc8
// Size: 0x6c
function setmatchcompletionstat(gamemode, playedorhosted, stat) {
    if (sessionmodeiswarzonegame()) {
        return;
    }
    self stats::set_stat(#"gamehistory", gamemode, #"modehistory", playedorhosted, stat, 1);
}

// Namespace globallogic/globallogic
// Params 0, eflags: 0x1 linked
// Checksum 0x7123a96e, Offset: 0x4e40
// Size: 0x15a
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
// Checksum 0x24400b54, Offset: 0x4fa8
// Size: 0x7e
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
// Checksum 0x9ef85ed, Offset: 0x5030
// Size: 0x9e
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
// Params 0, eflags: 0x1 linked
// Checksum 0x54ae1210, Offset: 0x50d8
// Size: 0x3d4
function recordplaystyleinformation() {
    if (!sessionmodeismultiplayergame()) {
        return;
    }
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
    function_92d1707f(#"hash_5cee5eb6de3811d0", mpplaystyles);
}

// Namespace globallogic/globallogic
// Params 0, eflags: 0x1 linked
// Checksum 0x89460cbd, Offset: 0x54b8
// Size: 0x7b4
function updateandfinalizematchrecord() {
    /#
        if (getdvarint(#"scr_writeconfigstrings", 0) == 1) {
            return;
        }
    #/
    for (index = 0; index < level.players.size; index++) {
        player = level.players[index];
        if (!isdefined(player)) {
            continue;
        }
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
            recordplayerstats(player, "participation", player.pers[#"participation"]);
            recordplayerstats(player, "controllerParticipation", player.pers[#"controllerparticipation"]);
            recordplayerstats(player, "controllerParticipationChecks", player.pers[#"controllerparticipationchecks"]);
            recordplayerstats(player, "controllerParticipationChecksSkipped", player.pers[#"controllerparticipationchecksskipped"]);
            recordplayerstats(player, "controllerParticipationConsecutiveSuccessMax", player.pers[#"controllerparticipationconsecutivesuccessmax"]);
            recordplayerstats(player, "controllerParticipationConsecutiveFailureMax", player.pers[#"controllerparticipationconsecutivefailuremax"]);
            recordplayerstats(player, "controllerParticipationEndGameResult", player.pers[#"controllerparticipationendgameresult"]);
            recordplayerstats(player, "controllerParticipationInactivityWarnings", player.pers[#"controllerparticipationinactivitywarnings"]);
            recordplayerstats(player, "controllerParticipationSuccessAfterInactivityWarning", player.pers[#"controllerparticipationsuccessafterinactivitywarning"]);
            player recordplaystyleinformation();
            recordplayermatchend(player);
            function_c5906527(player);
            recordplayerstats(player, "present_at_end", 1);
            if (isdefined(player.pers) && isdefined(player.pers[#"totalmatchbonus"])) {
                recordplayerstats(player, "match_xp", player.pers[#"totalmatchbonus"]);
            } else if (isdefined(player.matchbonus)) {
                recordplayerstats(player, "match_xp", player.matchbonus);
            }
        }
        recordplayerstats(player, "damage_dealt", player.pers[#"damagedone"]);
    }
    finalizematchrecord();
}

// Namespace globallogic/globallogic
// Params 1, eflags: 0x1 linked
// Checksum 0xc2690a6b, Offset: 0x5c78
// Size: 0xc8
function function_c5906527(player) {
    if (isdefined(player.pers[#"scoreeventcache"])) {
        foreach (event, count in player.pers[#"scoreeventcache"]) {
            function_2c666d56(player, event, count);
        }
    }
}

// Namespace globallogic/globallogic
// Params 0, eflags: 0x1 linked
// Checksum 0x3d3cd1ab, Offset: 0x5d48
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
// Params 0, eflags: 0x1 linked
// Checksum 0x4ac56ed0, Offset: 0x5f18
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
// Params 1, eflags: 0x1 linked
// Checksum 0xff76e6b7, Offset: 0x60c8
// Size: 0x104
function function_a50a4f61(outcome) {
    if (level.teambased) {
        if (outcome::get_flag(outcome, "tie") || !isdefined(outcome::get_winning_team(outcome))) {
            demo::function_c6ae5fd6(#"game_result", level.teamindex[#"neutral"], level.teamindex[#"neutral"]);
            return;
        }
        demo::function_c6ae5fd6(#"game_result", level.teamindex[outcome::get_winning_team(outcome)], level.teamindex[#"neutral"]);
    }
}

// Namespace globallogic/globallogic
// Params 0, eflags: 0x1 linked
// Checksum 0xd583765, Offset: 0x61d8
// Size: 0xcc
function function_9022da4e() {
    bb::function_a7ba460f(match::function_3624d032());
    if (sessionmodeismultiplayergame()) {
        mpmatchfacts = {#gametime:function_f8d53445(), #winner:match::get_winner(), #killstreakcount:level.globalkillstreakscalled};
        function_92d1707f(#"hash_7784f98b4b9750ec", mpmatchfacts);
    }
}

// Namespace globallogic/globallogic
// Params 0, eflags: 0x1 linked
// Checksum 0x1ead5df0, Offset: 0x62b0
// Size: 0xa6
function function_b0a2785c() {
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
// Params 0, eflags: 0x1 linked
// Checksum 0x67e13a8, Offset: 0x6360
// Size: 0x194
function function_8111babb() {
    setmatchtalkflag("DeadChatWithDead", level.voip.deadchatwithdead);
    setmatchtalkflag("DeadChatWithTeam", level.voip.deadchatwithteam);
    setmatchtalkflag("DeadChatWithSquad", level.voip.deadchatwithsquad);
    setmatchtalkflag("LivingChatWithSquad", level.voip.livingchatwithsquad);
    setmatchtalkflag("DeadHearTeamLiving", level.voip.deadhearteamliving);
    setmatchtalkflag("DeadHearAllLiving", level.voip.deadhearallliving);
    setmatchtalkflag("EveryoneHearsEveryone", level.voip.everyonehearseveryone);
    setmatchtalkflag("EveryoneHearsFriendly", level.voip.everyonehearsfriendly);
    setmatchtalkflag("DeadHearKiller", level.voip.deadhearkiller);
    setmatchtalkflag("KillersHearVictim", level.voip.killershearvictim);
}

// Namespace globallogic/globallogic
// Params 0, eflags: 0x1 linked
// Checksum 0xf6586377, Offset: 0x6500
// Size: 0x124
function function_d89bf8aa() {
    if (!is_game_over()) {
        if (is_true(level.nextroundisovertime)) {
            game.overtime_round++;
        }
        player::function_2f80d95b(&val::reset, "freeze_player_for_round_end", "freezecontrols");
        player::function_2f80d95b(&val::reset, "freeze_player_for_round_end", "disablegadgets");
        player::function_2f80d95b(&clientfield::set_player_uimodel, "hudItems.hideOutcomeUI", 1);
        function_8111babb();
        function_452e18ad();
        game.state = "pregame";
        map_restart(1);
        return true;
    }
    return false;
}

// Namespace globallogic/globallogic
// Params 1, eflags: 0x0
// Checksum 0x3b102eeb, Offset: 0x6630
// Size: 0x68
function function_de2b637d(winner) {
    if (!isdefined(winner)) {
        return "tie";
    }
    if (isentity(winner)) {
        return (isdefined(winner.team) ? winner.team : #"none");
    }
    return winner;
}

// Namespace globallogic/globallogic
// Params 0, eflags: 0x1 linked
// Checksum 0x7a2186a5, Offset: 0x66a0
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
// Checksum 0x70490461, Offset: 0x6740
// Size: 0x44
function waitanduploadstats(player, waittime) {
    wait waittime;
    if (isplayer(player)) {
        uploadstats(player);
    }
}

// Namespace globallogic/globallogic
// Params 1, eflags: 0x0
// Checksum 0x3b6afa39, Offset: 0x6790
// Size: 0xa8
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
// Checksum 0xff113609, Offset: 0x6840
// Size: 0xe8
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
// Params 1, eflags: 0x5 linked
// Checksum 0xf12c150a, Offset: 0x6930
// Size: 0x2fc
function private function_6c9e78d5(var_c1e98979) {
    updateplacement();
    function_68bfd6d7();
    roundlength = getroundlength();
    survey_id = function_70171add();
    current_time = gettime();
    game_over = is_game_over();
    players = level.players;
    foreach (player in players) {
        /#
            player globallogic_ui::freegameplayhudelems();
        #/
        player.pers[#"lastroundscore"] = player.pointstowin;
        player weapons::update_timings(current_time);
        player bbplayermatchend(roundlength, var_c1e98979, game_over);
        player.pers[#"totaltimeplayed"] = player.pers[#"totaltimeplayed"] + player.timeplayed[#"total"];
        if (sessionmodeisonlinegame()) {
            player stats::function_7a850245(#"demofileid", getdemofileid());
            player stats::function_7a850245(#"matchid", getmatchid());
            if (level.rankedmatch) {
                player stats::function_7a850245("surveyId", survey_id);
            }
        }
        player stats::function_7a850245("hardcore", level.hardcoremode);
    }
    userspawnselection::closespawnselectionmenuforallplayers();
    player::function_2f80d95b(&function_5ae24200);
    if (!util::waslastround()) {
        player::function_38de2d5a("round_ended");
    }
}

// Namespace globallogic/globallogic
// Params 0, eflags: 0x5 linked
// Checksum 0x57784b56, Offset: 0x6c38
// Size: 0x38
function private is_game_over() {
    if (util::isoneround() || util::waslastround()) {
        return true;
    }
    return false;
}

// Namespace globallogic/globallogic
// Params 0, eflags: 0x5 linked
// Checksum 0x12cd949f, Offset: 0x6c78
// Size: 0x7e
function private function_70171add() {
    if (randomfloat(1) <= getdvarfloat(#"survey_chance", 0)) {
        return randomintrange(1, getdvarint(#"survey_count", 0) + 1);
    }
    return 0;
}

// Namespace globallogic/globallogic
// Params 0, eflags: 0x5 linked
// Checksum 0xf61fc0c3, Offset: 0x6d00
// Size: 0x90
function private function_176452e3() {
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
// Params 0, eflags: 0x5 linked
// Checksum 0x4d1bf705, Offset: 0x6d98
// Size: 0x110
function private function_9113e843() {
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
// Params 0, eflags: 0x5 linked
// Checksum 0xa10b0881, Offset: 0x6eb0
// Size: 0xaa
function private function_e8cd6051() {
    result = #"draw";
    if (!match::get_flag("tie") && match::function_c10174e7()) {
        result = match::get_winning_team();
    }
    if (result == "tie" || result == #"none") {
        result = #"draw";
    }
    return result;
}

// Namespace globallogic/globallogic
// Params 1, eflags: 0x5 linked
// Checksum 0x2be03c25, Offset: 0x6f68
// Size: 0xc4
function private function_d8d30361(var_c1e98979) {
    setmatchflag("game_ended", 1);
    gamestate::set_state("postgame");
    level.gameendtime = gettime();
    level.gameended = 1;
    level.var_8a3a9ca4.roundend = gettime();
    setdvar(#"g_gameended", 1);
    round::function_897438f4(var_c1e98979);
    /#
        rat::function_65e13d0f();
    #/
}

// Namespace globallogic/globallogic
// Params 0, eflags: 0x5 linked
// Checksum 0x24c16ff0, Offset: 0x7038
// Size: 0xcc
function private function_68bfd6d7() {
    if (!is_game_over()) {
        game_winner = round::get_winner();
        return;
    }
    game_winner = match::function_6d0354e3();
    var_8dbf2a6d = globallogic_score::function_15683f39();
    if (isdefined(var_8dbf2a6d) && isdefined(var_8dbf2a6d.var_9cd2c51d)) {
        var_8dbf2a6d stats::function_dad108fa(#"top_scorer", 1);
        var_8dbf2a6d contracts::increment_contract(#"hash_117aee9968655de3");
    }
}

// Namespace globallogic/globallogic
// Params 0, eflags: 0x1 linked
// Checksum 0x5f39eb93, Offset: 0x7110
// Size: 0x94
function function_dd9663e5() {
    callback::function_daed27e8(#"on_end_game");
    callback::function_bea20a96(#"on_end_game");
    level notify(#"game_ended");
    level clientfield::set("gameplay_started", 0);
    level clientfield::set("game_ended", 1);
}

// Namespace globallogic/globallogic
// Params 1, eflags: 0x5 linked
// Checksum 0xbefad504, Offset: 0x71b0
// Size: 0x264
function private function_4720c07f(outcome) {
    level.ingraceperiod = 0;
    function_dd9663e5();
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
    function_9113e843();
    function_176452e3();
    thread setroundswonuimodels();
    setgameendtime(0);
    updaterankedmatch(outcome);
    setmatchtalkflag("EveryoneHearsEveryone", 1);
    gamerep::gamerepupdateinformationforround();
    thread challenges::roundend(round::get_winner());
    function_6c9e78d5(outcome.var_c1e98979);
    gameobjects::function_407c83be();
    globallogic_utils::function_8d61a6c2(outcome.var_c1e98979);
    function_a50a4f61(outcome);
}

// Namespace globallogic/globallogic
// Params 1, eflags: 0x0
// Checksum 0x7e2d4b9a, Offset: 0x7420
// Size: 0x64
function function_566a70ad(var_c139bfe2) {
    level.var_49d9aa70 = 0.25;
    level.var_db945f12 = level.roundenddelay[var_c139bfe2] / 4;
    setslowmotion(1, level.var_49d9aa70, level.var_db945f12);
}

// Namespace globallogic/globallogic
// Params 3, eflags: 0x1 linked
// Checksum 0xc92e2a6f, Offset: 0x7490
// Size: 0x44
function function_2556afb5(scale_start, scale_end, transition_time) {
    level.var_49d9aa70 = scale_end;
    setslowmotion(scale_start, scale_end, transition_time);
}

// Namespace globallogic/globallogic
// Params 0, eflags: 0x1 linked
// Checksum 0xaca83c1c, Offset: 0x74e0
// Size: 0x3c
function function_452e18ad() {
    level.var_49d9aa70 = 1;
    setslowmotion(1, 1, 0);
}

// Namespace globallogic/globallogic
// Params 1, eflags: 0x1 linked
// Checksum 0xc6118b37, Offset: 0x7528
// Size: 0x6e
function function_8b4fc766(var_c1e98979) {
    switch (var_c1e98979) {
    case 0:
    case 9:
    case 10:
        return false;
    default:
        return true;
    }
    return true;
}

// Namespace globallogic/globallogic
// Params 2, eflags: 0x1 linked
// Checksum 0xa29098a5, Offset: 0x75a0
// Size: 0x94
function function_a3e3bd39(winning_team, var_c1e98979) {
    assert(isdefined(winning_team));
    if (function_8b4fc766(var_c1e98979)) {
        globallogic_score::giveteamscoreforobjective_delaypostprocessing(winning_team, 1);
    }
    round::set_winner(winning_team);
    thread end_round(var_c1e98979);
}

// Namespace globallogic/globallogic
// Params 0, eflags: 0x0
// Checksum 0x829e41e7, Offset: 0x7640
// Size: 0x4c
function function_61e80d63() {
    if (level.teambased) {
        function_a3e3bd39(game.defenders, 2);
        return;
    }
    end_round(2);
}

// Namespace globallogic/globallogic
// Params 0, eflags: 0x0
// Checksum 0xaae9ffc2, Offset: 0x7698
// Size: 0x44
function function_543ac649() {
    if (level.teambased) {
        round::set_winner(game.defenders);
    }
    end_round(2);
}

// Namespace globallogic/globallogic
// Params 0, eflags: 0x1 linked
// Checksum 0xb5cae186, Offset: 0x76e8
// Size: 0x44
function function_692f2157() {
    if (isalive(self)) {
        self.deathtime = 0;
        self.pers[#"deathtime"] = 0;
    }
}

// Namespace globallogic/globallogic
// Params 1, eflags: 0x1 linked
// Checksum 0x47263e9f, Offset: 0x7738
// Size: 0x23c
function end_round(var_c1e98979) {
    if (sessionmodeismultiplayergame() && var_c1e98979 === 6) {
        if (is_true(level.var_81536c1d)) {
            return;
        }
        level.var_81536c1d = 1;
        if (!isdefined(level.var_a5c930dd)) {
            level.var_a5c930dd = 0;
        }
        if (!isdefined(level.var_697b1d55)) {
            level.var_697b1d55 = 0;
        }
        do {
            waitframe(1);
            endtime = gettime() - 2 * float(function_60d95f53()) / 1000;
        } while (level.lastslowprocessframe > endtime || level.var_a5c930dd > endtime || level.var_697b1d55 > endtime);
    }
    if (gamestate::is_game_over() || level.gameended) {
        return;
    }
    player::function_2f80d95b(&function_692f2157);
    function_d8d30361(var_c1e98979);
    if (isdefined(level.onendround)) {
        [[ level.onendround ]](var_c1e98979);
    }
    outcome = hud_message::function_a2f30ab4(1, var_c1e98979, 0, round::function_f37f02fc());
    function_4720c07f(outcome);
    overtime::function_f435f4dd();
    display_transition::display_round_end(outcome);
    if (!function_d89bf8aa()) {
        beacon_cp_biodomes_server_room_top_floor_door_rumble();
    }
}

// Namespace globallogic/globallogic
// Params 0, eflags: 0x5 linked
// Checksum 0x2ee7a021, Offset: 0x7980
// Size: 0x64
function private function_f30cfedb() {
    if (util::isoneround()) {
        var_c1e98979 = round::function_3624d032();
    } else {
        var_c1e98979 = function_b0a2785c();
    }
    match::function_897438f4(var_c1e98979);
}

// Namespace globallogic/globallogic
// Params 0, eflags: 0x5 linked
// Checksum 0x8d0144f7, Offset: 0x79f0
// Size: 0x224
function private function_3526a519() {
    if (!isdefined(level.var_8819644a)) {
        return;
    }
    var_e61d6eb0 = [];
    foreach (vehicle in level.var_8819644a) {
        if (!isdefined(vehicle)) {
            continue;
        }
        data = {#pos_x:vehicle.origin[0], #pos_y:vehicle.origin[1], #pos_z:vehicle.origin[2], #type:vehicle.vehicletype, #used:is_true(vehicle.used)};
        if (!isdefined(var_e61d6eb0)) {
            var_e61d6eb0 = [];
        } else if (!isarray(var_e61d6eb0)) {
            var_e61d6eb0 = array(var_e61d6eb0);
        }
        var_e61d6eb0[var_e61d6eb0.size] = data;
        if (var_e61d6eb0.size >= 100) {
            function_92d1707f(#"hash_55f923de6ff3632b", #"entries", var_e61d6eb0);
            var_e61d6eb0 = [];
            wait 0.1;
        }
    }
    if (var_e61d6eb0.size > 0) {
        function_92d1707f(#"hash_55f923de6ff3632b", #"entries", var_e61d6eb0);
    }
}

// Namespace globallogic/globallogic
// Params 0, eflags: 0x5 linked
// Checksum 0xc64741d0, Offset: 0x7c20
// Size: 0x28c
function private function_e4335431() {
    if (!isdefined(level.item_spawn_stashes)) {
        return;
    }
    var_726f6c6 = [];
    foreach (stash in level.item_spawn_stashes) {
        state = function_ffdbe8c2(stash);
        data = {#pos_x:stash.origin[0], #pos_y:stash.origin[1], #pos_z:stash.origin[2], #type:stash.var_15d44120, #used:state != 0, #state:state, #var_a7feba9c:isdefined(stash.var_80b1d504) ? stash.var_80b1d504 : 0, #var_fa0ba6bc:is_true(stash.lootlocker)};
        if (!isdefined(var_726f6c6)) {
            var_726f6c6 = [];
        } else if (!isarray(var_726f6c6)) {
            var_726f6c6 = array(var_726f6c6);
        }
        var_726f6c6[var_726f6c6.size] = data;
        if (var_726f6c6.size >= 100) {
            function_92d1707f(#"hash_7cd6488eb92cb736", #"entries", var_726f6c6);
            var_726f6c6 = [];
            wait 0.1;
        }
    }
    if (var_726f6c6.size > 0) {
        function_92d1707f(#"hash_7cd6488eb92cb736", #"entries", var_726f6c6);
    }
}

// Namespace globallogic/globallogic
// Params 0, eflags: 0x5 linked
// Checksum 0x93a5423f, Offset: 0x7eb8
// Size: 0x7bc
function private function_159d7b6f() {
    itemcount = function_8322cf16();
    summary = [];
    var_69cbb8c = [];
    for (i = 0; i < itemcount; i++) {
        if (i % 100 == 0) {
            wait 0.1;
        }
        item = function_b1702735(i);
        if (!isdefined(summary[item.targetname])) {
            summary[item.targetname] = {};
        }
        if (isdefined(item.var_a6762160)) {
            if (!isdefined(summary[item.targetname].itemtypes)) {
                summary[item.targetname].itemtypes = [];
            }
            if (!isdefined(summary[item.targetname].itemtypes[item.var_a6762160.itemtype])) {
                summary[item.targetname].itemtypes[item.var_a6762160.itemtype] = {};
            }
            if (!isdefined(summary[item.targetname].itemtypes[item.var_a6762160.itemtype].items)) {
                summary[item.targetname].itemtypes[item.var_a6762160.itemtype].items = [];
            }
            if (!isdefined(summary[item.targetname].itemtypes[item.var_a6762160.itemtype].items[item.var_a6762160.name])) {
                summary[item.targetname].itemtypes[item.var_a6762160.itemtype].items[item.var_a6762160.name] = {};
            }
            if (!isdefined(summary[item.targetname].itemtypes[item.var_a6762160.itemtype].items[item.var_a6762160.name].count)) {
                summary[item.targetname].itemtypes[item.var_a6762160.itemtype].items[item.var_a6762160.name].count = 0;
            }
            summary[item.targetname].itemtypes[item.var_a6762160.itemtype].items[item.var_a6762160.name].count = summary[item.targetname].itemtypes[item.var_a6762160.itemtype].items[item.var_a6762160.name].count + 1;
            summary[item.targetname].itemtypes[item.var_a6762160.itemtype].items[item.var_a6762160.name].rarity = hash(item.var_a6762160.rarity);
        } else {
            if (!isdefined(var_69cbb8c[item.targetname])) {
                var_69cbb8c[item.targetname] = {};
            }
            if (!isdefined(var_69cbb8c[item.targetname].count)) {
                var_69cbb8c[item.targetname].count = 0;
            }
            var_69cbb8c[item.targetname].count = var_69cbb8c[item.targetname].count + 1;
        }
    }
    wait 0.1;
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
                            var_cae7fe15 = {#seed:level.item_spawn_seed, #event_count:item_data.size};
                            function_92d1707f(#"hash_67dcbe8b30edd15a", #"summary", var_cae7fe15, #"entries", item_data);
                            item_data = [];
                            wait 0.1;
                        }
                    }
                }
            }
        }
    }
    if (item_data.size > 0) {
        var_cae7fe15 = {#seed:level.item_spawn_seed, #event_count:item_data.size};
        function_92d1707f(#"hash_67dcbe8b30edd15a", #"summary", var_cae7fe15, #"entries", item_data);
    }
}

// Namespace globallogic/globallogic
// Params 0, eflags: 0x5 linked
// Checksum 0xcf31b95, Offset: 0x8680
// Size: 0x4c
function private function_2506a4ec() {
    function_3526a519();
    wait 0.1;
    function_e4335431();
    wait 0.1;
    function_159d7b6f();
    wait 0.1;
}

// Namespace globallogic/globallogic
// Params 0, eflags: 0x5 linked
// Checksum 0x58f6eb47, Offset: 0x86d8
// Size: 0xec
function private function_6a4a86() {
    result = function_e8cd6051();
    recordgameresult(result);
    player::function_2f80d95b(&player_record::function_96d38b95, result);
    player::function_2f80d95b(&player_record::record_misc_player_stats);
    skillupdate();
    if (sessionmodeiswarzonegame()) {
        thread function_2506a4ec();
    }
    winner = match::get_winner();
    thread challenges::gameend(winner);
    function_9022da4e();
}

// Namespace globallogic/globallogic
// Params 0, eflags: 0x5 linked
// Checksum 0x95cd7606, Offset: 0x87d0
// Size: 0x44
function private function_5ae24200() {
    self setclientuivisibilityflag("hud_visible", 0);
    self setclientuivisibilityflag("g_compassShowEnemies", 0);
}

// Namespace globallogic/globallogic
// Params 0, eflags: 0x5 linked
// Checksum 0xb71b25cf, Offset: 0x8820
// Size: 0x7c
function private function_a18a9342() {
    setmatchtalkflag("EveryoneHearsEveryone", 1);
    setmatchflag("cg_drawSpectatorMessages", 0);
    util::setclientsysstate("levelNotify", "streamFKsl");
    player::function_2f80d95b(&function_5ae24200);
}

// Namespace globallogic/globallogic
// Params 0, eflags: 0x5 linked
// Checksum 0xa27a5212, Offset: 0x88a8
// Size: 0x42
function private function_ac30613c() {
    return hud_message::function_a2f30ab4(1, match::function_3624d032(), 1, match::function_f37f02fc());
}

// Namespace globallogic/globallogic
// Params 1, eflags: 0x5 linked
// Checksum 0xb37d4564, Offset: 0x88f8
// Size: 0x34
function private function_bd1e54e7(outcome) {
    stopdemorecording();
    function_a50a4f61(outcome);
}

// Namespace globallogic/globallogic
// Params 0, eflags: 0x5 linked
// Checksum 0x18ef3b12, Offset: 0x8938
// Size: 0x44
function private player_end_game() {
    self thread [[ level.spawnintermission ]](0, level.usexcamsforendgame);
    self setclientuivisibilityflag("hud_visible", 1);
}

// Namespace globallogic/globallogic
// Params 0, eflags: 0x5 linked
// Checksum 0x3473e9af, Offset: 0x8988
// Size: 0x6c
function private function_f6928798() {
    level.intermission = 1;
    level notify(#"endgame_intermission");
    player::function_2f80d95b(&player_end_game);
    level clientfield::set("post_game", 1);
}

// Namespace globallogic/globallogic
// Params 1, eflags: 0x1 linked
// Checksum 0x764b822a, Offset: 0x8a00
// Size: 0x82
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
// Params 0, eflags: 0x1 linked
// Checksum 0x90a1c5bb, Offset: 0x8a90
// Size: 0x174
function function_4e7d44bd() {
    foreach (team, _ in level.teams) {
        if (level.everexisted[team]) {
            teamranking = isdefined(level.var_eed7c027[team]) ? level.var_eed7c027[team] : 1;
            players = getplayers(team);
            foreach (player in players) {
                player luinotifyevent(#"team_eliminated", 1, teamranking);
            }
        }
    }
}

// Namespace globallogic/globallogic
// Params 0, eflags: 0x1 linked
// Checksum 0x7eabf3e9, Offset: 0x8c10
// Size: 0x1c8
function function_9c14ee08() {
    for (index = 0; index < level.players.size; index++) {
        player = level.players[index];
        if (isbot(player)) {
            continue;
        }
        playerclientnum = player getentitynumber();
        var_9b208b53 = 0;
        for (j = 0; j < level.players.size; j++) {
            if (index == j) {
                continue;
            }
            notplayer = level.players[j];
            if (util::function_fbce7263(player.team, notplayer.team)) {
                var_13947986 = notplayer getentitynumber();
                killed = notplayer.pers[#"killed_by"][player.name];
                killedby = notplayer.pers[#"killed_players"][player.name];
                if (!isdefined(killed)) {
                    killed = 0;
                }
                if (!isdefined(killedby)) {
                    killedby = 0;
                }
                player luinotifyevent(#"hash_9ab42b593c66ed", 5, playerclientnum, var_9b208b53, var_13947986, killed, killedby);
                var_9b208b53++;
            }
        }
    }
}

// Namespace globallogic/globallogic
// Params 1, eflags: 0x1 linked
// Checksum 0xc9f6e449, Offset: 0x8de0
// Size: 0x4bc
function function_4636deca(player) {
    if (isbot(player)) {
        return;
    }
    player player_record::function_7569c0fb();
    nemesis = player.pers[#"nemesis_name"];
    assert(isdefined(nemesis), "<dev string:x8c>" + player.name);
    assert(isstring(nemesis), "<dev string:xb0>" + nemesis + "<dev string:xbc>" + player.name);
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
        player stats::function_7a850245(#"privatematch", 0);
    } else {
        player stats::function_7a850245(#"privatematch", 1);
    }
    player setnemesisxuid(player.pers[#"nemesis_xuid"]);
    player stats::function_7a850245(#"valid", 1);
    player stats::function_7a850245(#"nemesisname", nemesis);
    player stats::function_7a850245(#"nemesisrank", player.pers[#"nemesis_rank"]);
    player stats::function_7a850245(#"nemesisrankicon", player.pers[#"nemesis_rankicon"]);
    player stats::function_7a850245(#"nemesiskills", player.pers[#"killed_players"][nemesis]);
    player stats::function_7a850245(#"nemesiskilledby", player.pers[#"killed_by"][nemesis]);
    nemesisplayerent = getplayerbyname(nemesis);
    if (isdefined(nemesisplayerent)) {
        player stats::function_7a850245(#"nemesisheroindex", nemesisplayerent getcharacterbodytype());
    }
    clientnum = player getentitynumber();
    player stats::function_7a850245(#"clientnum", clientnum);
    characterindex = player getcharacterbodytype();
    player stats::function_7a850245(#"characterindex", characterindex);
    player stats::function_7a850245(#"gametype", level.var_12323003);
}

// Namespace globallogic/globallogic
// Params 0, eflags: 0x1 linked
// Checksum 0xb8944542, Offset: 0x92a8
// Size: 0x94
function sendafteractionreport() {
    /#
        if (getdvarint(#"scr_writeconfigstrings", 0) == 1) {
            return;
        }
    #/
    for (index = 0; index < level.players.size; index++) {
        player = level.players[index];
        function_4636deca(player);
    }
}

// Namespace globallogic/globallogic
// Params 0, eflags: 0x5 linked
// Checksum 0xe5903084, Offset: 0x9348
// Size: 0x74
function private function_5c159ad3() {
    util::preload_frontend();
    gamerep::gamerepanalyzeandreport();
    thread function_4e7d44bd();
    wait 1;
    if (!sessionmodeiswarzonegame()) {
        thread sendafteractionreport();
    }
    thread function_9c14ee08();
}

// Namespace globallogic/globallogic
// Params 1, eflags: 0x1 linked
// Checksum 0x2e64714e, Offset: 0x93c8
// Size: 0x2b4
function function_9a022fbc(str_state) {
    players = getplayers();
    var_7e05b6e9 = [];
    foreach (player in players) {
        if (isbot(player) || player issplitscreen()) {
            array::add(var_7e05b6e9, player);
        }
    }
    foreach (bot in var_7e05b6e9) {
        arrayremovevalue(players, bot);
    }
    foreach (player in players) {
        lui_menu = lui::get_luimenu("FullScreenBlack");
        if (str_state == "open") {
            if (isdefined(lui_menu)) {
                if (![[ lui_menu ]]->function_7bfd10e6(player)) {
                    [[ lui_menu ]]->open(player);
                }
                [[ lui_menu ]]->set_startalpha(player, 1);
                [[ lui_menu ]]->set_endalpha(player, 1);
                [[ lui_menu ]]->set_fadeovertime(player, int(2000));
            }
            continue;
        }
        if (isdefined(lui_menu)) {
            [[ lui_menu ]]->close(player);
        }
    }
}

// Namespace globallogic/globallogic
// Params 0, eflags: 0x5 linked
// Checksum 0x4beb746a, Offset: 0x9688
// Size: 0x2c4
function private beacon_cp_biodomes_server_room_top_floor_door_rumble() {
    function_f30cfedb();
    hvo::function_323c6715();
    [[ level.onendgame ]](match::function_3624d032());
    globallogic_score::updatewinlossstats();
    if (level.arenamatch) {
        arena::match_end();
    }
    function_6a4a86();
    function_a18a9342();
    outcome = function_ac30613c();
    level notify(#"give_match_bonus");
    thread function_5c159ad3();
    if (!isdefined(level.skipgameend) || !level.skipgameend) {
        display_transition::display_match_end(outcome);
    }
    function_bd1e54e7(outcome);
    if (util::isoneround() && !display_transition::using_new_transitions()) {
        globallogic_utils::executepostroundevents();
    }
    function_f6928798();
    level notify(#"sfade");
    updateandfinalizematchrecord();
    if (isdefined(level.end_game_video)) {
        function_9a022fbc("open");
        level thread lui::play_movie(level.end_game_video, "fullscreen", 1, 0, 0, #"", level.var_48ea0e8c);
        level waittill(#"movie_done");
    }
    gamestate::set_state("shutdown");
    var_c282197b = gettime() + int(30 * 1000);
    while (gettime() < var_c282197b) {
        if (function_2b9d6412()) {
            break;
        }
        waitframe(1);
    }
    level callback::callback(#"hash_1b5be9017cd4b5fa");
    exit_level();
}

// Namespace globallogic/globallogic
// Params 0, eflags: 0x1 linked
// Checksum 0xea776d55, Offset: 0x9958
// Size: 0x3c
function exit_level() {
    if (level.exitlevel) {
        return;
    }
    level.exitlevel = 1;
    exitlevel(0);
}

// Namespace globallogic/globallogic
// Params 1, eflags: 0x1 linked
// Checksum 0xd49a6822, Offset: 0x99a0
// Size: 0x6c
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
// Params 1, eflags: 0x1 linked
// Checksum 0xb24e9fd, Offset: 0x9a18
// Size: 0x74
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
// Params 3, eflags: 0x1 linked
// Checksum 0x1c3f9928, Offset: 0x9a98
// Size: 0x1dc
function bbplayermatchend(gamelength, var_c1e98979, gameover) {
    if (!sessionmodeismultiplayergame() || !isdefined(self.pers)) {
        return;
    }
    playerrank = getplacementforplayer(self);
    totaltimeplayed = self getroundtimeplayed(gamelength);
    xuid = int(self getxuid(1));
    mpplayermatchfacts = {#score:self.pers[#"score"], #momentum:self.pers[#"momentum"], #endreason:var_c1e98979, #sessionrank:playerrank, #playtime:int(totaltimeplayed), #xuid:xuid, #gameover:gameover, #team:self.team, #specialist:self getspecialistindex()};
    function_92d1707f(#"hash_7c173cd9201d5271", mpplayermatchfacts);
}

// Namespace globallogic/globallogic
// Params 0, eflags: 0x1 linked
// Checksum 0xeac209de, Offset: 0x9c80
// Size: 0x24
function roundenddof() {
    self clientfield::set_to_player("player_dof_settings", 2);
}

// Namespace globallogic/globallogic
// Params 0, eflags: 0x1 linked
// Checksum 0xa4bda358, Offset: 0x9cb0
// Size: 0x198
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
    if (is_true(level.timerpaused)) {
        timeremaining = globallogic_utils::gettimeremaining();
        setgameendtime(int(timeremaining) * -1);
        return;
    }
    if (is_true(level.timerstopped)) {
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
// Params 0, eflags: 0x1 linked
// Checksum 0xd8ec9c46, Offset: 0x9e50
// Size: 0x9c
function checkscorelimit() {
    if (game.state != "playing") {
        return;
    }
    if (level.scorelimit <= 0) {
        return;
    }
    if (level.teambased) {
        if (!teams::any_team_hit_score_limit()) {
            return;
        }
    } else {
        if (!isplayer(self)) {
            return;
        }
        if (self.pointstowin < level.scorelimit) {
            return;
        }
    }
    [[ level.onscorelimit ]]();
}

// Namespace globallogic/globallogic
// Params 1, eflags: 0x1 linked
// Checksum 0x34fe75ae, Offset: 0x9ef8
// Size: 0x70
function checksuddendeathscorelimit(team) {
    if (game.state != "playing") {
        return;
    }
    if (level.roundscorelimit <= 0) {
        return;
    }
    if (level.teambased) {
        if (!game.teamsuddendeath[team]) {
            return;
        }
    } else {
        return;
    }
    [[ level.onscorelimit ]]();
}

// Namespace globallogic/globallogic
// Params 0, eflags: 0x1 linked
// Checksum 0xb282f4d7, Offset: 0x9f70
// Size: 0xb8
function checkroundscorelimit() {
    if (game.state != "playing") {
        return;
    }
    if (level.roundscorelimit <= 0) {
        return;
    }
    if (level.teambased) {
        if (!util::any_team_hit_round_score_limit()) {
            return;
        }
    } else {
        if (!isplayer(self)) {
            return;
        }
        roundscorelimit = util::get_current_round_score_limit();
        if (self.pointstowin < roundscorelimit) {
            return;
        }
    }
    [[ level.onroundscorelimit ]]();
}

// Namespace globallogic/globallogic
// Params 0, eflags: 0x1 linked
// Checksum 0xd5379442, Offset: 0xa030
// Size: 0x22c
function updategametypedvars() {
    level endon(#"game_ended");
    while (!gamestate::is_game_over()) {
        roundlimit = math::clamp(getgametypesetting(#"roundlimit"), level.roundlimitmin, level.roundlimitmax);
        if (roundlimit != level.roundlimit) {
            level.roundlimit = roundlimit;
        }
        timelimit = [[ level.gettimelimit ]]();
        if (timelimit != level.timelimit) {
            level.timelimit = timelimit;
        }
        checktimelimit();
        scorelimit = math::clamp(getgametypesetting(#"scorelimit"), level.scorelimitmin, level.scorelimitmax);
        if (scorelimit != level.scorelimit) {
            level.scorelimit = scorelimit;
        }
        checkscorelimit();
        roundscorelimit = math::clamp(getgametypesetting(#"roundscorelimit"), level.roundscorelimitmin, level.roundscorelimitmax);
        if (roundscorelimit != level.roundscorelimit) {
            level.roundscorelimit = roundscorelimit;
        }
        checkroundscorelimit();
        if (isdefined(level.starttime)) {
            if (globallogic_utils::gettimeremaining() < 30000) {
                wait 0.1;
                continue;
            }
        }
        wait 0.25;
    }
}

// Namespace globallogic/globallogic
// Params 0, eflags: 0x1 linked
// Checksum 0x614418e9, Offset: 0xa268
// Size: 0x208
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
// Params 0, eflags: 0x1 linked
// Checksum 0x194f4bb, Offset: 0xa478
// Size: 0x364
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
// Params 0, eflags: 0x1 linked
// Checksum 0x38b1d17f, Offset: 0xa7e8
// Size: 0x1d4
function updateteamplacement() {
    if (!level.teambased) {
        return;
    }
    if (!isdefined(level.placement[#"all"])) {
        return;
    }
    foreach (team, _ in level.teams) {
        placement[team] = [];
    }
    placement[#"spectator"] = [];
    placementall = level.placement[#"all"];
    placementallsize = placementall.size;
    for (i = 0; i < placementallsize; i++) {
        player = placementall[i];
        if (!isdefined(player)) {
            continue;
        }
        team = player.pers[#"team"];
        placement[team][placement[team].size] = player;
    }
    foreach (team, _ in level.teams) {
        level.placement[team] = placement[team];
    }
}

// Namespace globallogic/globallogic
// Params 1, eflags: 0x1 linked
// Checksum 0xca6aedd2, Offset: 0xa9c8
// Size: 0xae
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
// Checksum 0x2471fe51, Offset: 0xaa80
// Size: 0x270
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
// Params 1, eflags: 0x1 linked
// Checksum 0x7eaac519, Offset: 0xacf8
// Size: 0x17a
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
// Params 0, eflags: 0x1 linked
// Checksum 0x79fdf90e, Offset: 0xae80
// Size: 0xa2
function totalalivecount() {
    count = 0;
    foreach (team, _ in level.teams) {
        count += function_a1ef346b(team).size;
    }
    return count;
}

// Namespace globallogic/globallogic
// Params 0, eflags: 0x1 linked
// Checksum 0xe2d9cc20, Offset: 0xaf30
// Size: 0x9a
function totalplayerlives() {
    count = 0;
    foreach (team, _ in level.teams) {
        count += level.playerlives[team];
    }
    return count;
}

// Namespace globallogic/globallogic
// Params 0, eflags: 0x1 linked
// Checksum 0x55f6071c, Offset: 0xafd8
// Size: 0xa4
function function_e9e52d05() {
    count = 0;
    foreach (team, _ in level.teams) {
        if (function_a1ef346b(team).size) {
            count++;
        }
    }
    return count;
}

// Namespace globallogic/globallogic
// Params 1, eflags: 0x1 linked
// Checksum 0x6517d415, Offset: 0xb088
// Size: 0x144
function initteamvariables(team) {
    if (!isdefined(level.laststandcount)) {
        level.laststandcount = [];
    }
    level.lastalivecount[team] = 0;
    if (!isdefined(level.var_f97a6ba3)) {
        level.var_f97a6ba3 = 0;
    }
    if (!isdefined(level.var_4ad4bec3)) {
        level.var_4ad4bec3 = 0;
    }
    if (!isdefined(game.everexisted)) {
        game.everexisted = [];
    }
    if (!isdefined(game.everexisted[team])) {
        game.everexisted[team] = 0;
    }
    if (!isdefined(level.var_eed7c027)) {
        level.var_eed7c027 = [];
    }
    level.teameliminated[team] = 0;
    level.everexisted[team] = 0;
    level.wavedelay[team] = 0;
    level.lastwave[team] = 0;
    level.waveplayerspawnindex[team] = 0;
    level.var_4ad4bec3 = 0;
    resetteamvariables(team);
}

// Namespace globallogic/globallogic
// Params 1, eflags: 0x1 linked
// Checksum 0xd0589426, Offset: 0xb1d8
// Size: 0x7c
function resetteamvariables(team) {
    level.playercount[team] = 0;
    level.botscount[team] = 0;
    level.playerlives[team] = 0;
    level.laststandcount[team] = 0;
    level.spawningplayers[team] = [];
    level.deadplayers[team] = [];
    level.spawnqueuemodified[team] = 0;
}

// Namespace globallogic/globallogic
// Params 1, eflags: 0x1 linked
// Checksum 0x52209ff, Offset: 0xb260
// Size: 0x34
function function_479ecd2d(team) {
    level.lastalivecount[team] = function_a1ef346b(team).size;
}

// Namespace globallogic/globallogic
// Params 0, eflags: 0x1 linked
// Checksum 0x788dc478, Offset: 0xb2a0
// Size: 0x564
function updateteamstatus() {
    level notify(#"updating_team_status");
    level endon(#"updating_team_status", #"game_ended");
    if (gamestate::is_game_over()) {
        return;
    }
    foreach (team, _ in level.teams) {
        resetteamvariables(team);
    }
    resetteamvariables(#"none");
    foreach (player in getplayers()) {
        if (level.teambased || player.team == #"spectator") {
            team = player.team;
        } else {
            team = #"none";
        }
        playerclass = player.curclass;
        if (team != #"spectator" && (isdefined(playerclass) && playerclass != "" || !loadout::function_87bcb1b())) {
            level.playercount[team]++;
            if (isbot(player)) {
                level.botscount[team]++;
            }
            not_quite_dead = 0;
            if (isdefined(player.overrideplayerdeadstatus)) {
                not_quite_dead = player [[ player.overrideplayerdeadstatus ]]();
            }
            if (player.sessionstate == "playing") {
                level.playerlives[team]++;
                player.spawnqueueindex = -1;
                if (isalive(player)) {
                    if (isdefined(player.laststand) && player.laststand) {
                        level.laststandcount[team]++;
                    }
                } else {
                    level.deadplayers[team][level.deadplayers[team].size] = player;
                }
                continue;
            }
            if (not_quite_dead) {
                level.playerlives[team]++;
                continue;
            }
            level.deadplayers[team][level.deadplayers[team].size] = player;
        }
    }
    foreach (team, _ in level.deadplayers) {
        foreach (player in level.deadplayers[team]) {
            if (player globallogic_spawn::mayspawn()) {
                level.playerlives[team]++;
            }
        }
        sortdeadplayers(team);
    }
    totalalive = totalalivecount();
    if (totalalive > level.maxplayercount) {
        level.maxplayercount = totalalive;
    }
    teams::function_596bfb16();
    callback::callback(#"hash_6b7d26d34885b425", {});
    foreach (team, _ in level.teams) {
        function_479ecd2d(team);
    }
    if (!level.teambased) {
        function_479ecd2d(#"none");
    }
}

// Namespace globallogic/globallogic
// Params 1, eflags: 0x1 linked
// Checksum 0xa439e4d8, Offset: 0xb810
// Size: 0x3cc
function updatealivetimes(team) {
    level.alivetimesaverage[team] = 0;
    if (gamestate::is_game_over()) {
        return;
    }
    total_player_count = 0;
    average_player_spawn_time = 0;
    total_value_count = 0;
    foreach (player in function_a1ef346b(team)) {
        average_time = 0;
        count = 0;
        if (!isdefined(player)) {
            continue;
        }
        if (isdefined(player.alivetimes)) {
            foreach (time in player.alivetimes) {
                if (!isdefined(time)) {
                    continue;
                }
                if (time != 0) {
                    average_time += time;
                    count++;
                }
            }
        }
        if (count) {
            total_value_count += count;
            average_player_spawn_time += average_time / count;
            total_player_count++;
        }
    }
    foreach (player in level.deadplayers[team]) {
        if (!isdefined(player)) {
            continue;
        }
        average_time = 0;
        count = 0;
        if (isdefined(player.alivetimes)) {
            foreach (time in player.alivetimes) {
                if (!isdefined(time)) {
                    continue;
                }
                if (time != 0) {
                    average_time += time;
                    count++;
                }
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
            iprintln("<dev string:xdc>" + level.alivetimesaverage[#"allies"] + "<dev string:xf5>" + level.alivetimesaverage[#"axis"]);
        }
    #/
}

// Namespace globallogic/globallogic
// Params 0, eflags: 0x1 linked
// Checksum 0x340972c4, Offset: 0xbbe8
// Size: 0x88
function updateallalivetimes() {
    foreach (team, _ in level.teams) {
        updatealivetimes(team);
    }
}

// Namespace globallogic/globallogic
// Params 2, eflags: 0x1 linked
// Checksum 0xdf722c0d, Offset: 0xbc78
// Size: 0x100
function function_b6caec44(score, var_d0266750) {
    assert(isdefined(score));
    assert(isdefined(var_d0266750));
    if (level.scorelimit <= 0) {
        return;
    }
    if (!level.teambased) {
        return;
    }
    if (globallogic_utils::gettimepassed() < int(60 * 1000)) {
        return;
    }
    timeleft = globallogic_utils::getestimatedtimeuntilscorelimit(score, var_d0266750);
    if (timeleft < 1) {
        level notify(#"match_ending_soon", {#event:"score"});
    }
}

// Namespace globallogic/globallogic
// Params 0, eflags: 0x1 linked
// Checksum 0xf0b6b8ae, Offset: 0xbd80
// Size: 0x100
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
    score = globallogic_score::_getplayerscore(self);
    timeleft = globallogic_utils::getestimatedtimeuntilscorelimit(score, score);
    if (timeleft < 1) {
        level notify(#"match_ending_soon", {#event:"score"});
    }
}

// Namespace globallogic/globallogic
// Params 0, eflags: 0x1 linked
// Checksum 0x71c80310, Offset: 0xbe88
// Size: 0x52c
function timelimitclock() {
    level endon(#"game_ended");
    level.var_8e3a3faf = 1;
    waitframe(1);
    clockobject = spawn("script_origin", (0, 0, 0));
    if (isdefined(clockobject)) {
        clockobject.targetname = "timeLimitClock";
    }
    var_df4e70cd = #"hash_6c97261a8e7dd055";
    while (!gamestate::is_game_over() && is_true(level.var_8e3a3faf)) {
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
            if (timeleftint <= 31) {
                level notify(#"hash_15b8b6edc4ed3032");
                level notify(#"hash_28434e94a8844dc5", {#n_delay:20});
            }
            if (timeleftint <= 10) {
                var_df4e70cd = #"hash_470c729e4c6298b2";
            }
            if (timeleftint <= 10 || timeleftint <= 30 && timeleftint % 2 == 0 || level.low_ticket_count === 1 && timeleftint % 2 == 0 || level.very_low_ticket_count === 1) {
                level notify(#"match_ending_very_soon", "time");
                if (timeleftint == 0) {
                    break;
                }
                clockobject playsound(var_df4e70cd);
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
    if (isdefined(clockobject)) {
        clockobject delete();
    }
}

// Namespace globallogic/globallogic
// Params 0, eflags: 0x5 linked
// Checksum 0x2b45a7b5, Offset: 0xc3c0
// Size: 0x2ac
function private function_54987b67() {
    players = getplayers();
    totalplayers = 0;
    foreach (player in players) {
        if (isalive(player)) {
            totalplayers++;
        }
    }
    if (isdefined(level.var_7dc1df3a) && isdefined(level.var_7dc1df3a.duration)) {
        var_bc9cd862 = level.var_7dc1df3a.duration;
        var_2c5afb5e = isdefined(level.var_7dc1df3a.var_e2382b29) ? level.var_7dc1df3a.var_e2382b29 : 0;
        var_b3418d40 = isdefined(level.var_7dc1df3a.var_7be962bb) ? level.var_7dc1df3a.var_7be962bb : 0;
        var_84dc46fb = isdefined(level.var_7dc1df3a.var_7d960258) ? level.var_7dc1df3a.var_7d960258 : 0;
        var_47f5b811 = isdefined(level.var_7dc1df3a.var_a104a7da) ? level.var_7dc1df3a.var_a104a7da : 0;
    } else {
        var_bc9cd862 = 0;
        var_2c5afb5e = 0;
        var_b3418d40 = 0;
        var_84dc46fb = 0;
        var_47f5b811 = 0;
    }
    data = {#var_ea8aaaef:var_bc9cd862, #var_962b073b:var_2c5afb5e, #var_be2fca42:var_b3418d40, #var_f0956407:var_84dc46fb, #var_cac41566:var_47f5b811, #var_31942899:gettime(), #player_count:totalplayers};
    function_92d1707f(#"hash_24f510499c464072", data);
}

// Namespace globallogic/globallogic
// Params 0, eflags: 0x5 linked
// Checksum 0xdaa307df, Offset: 0xc678
// Size: 0xec
function private set_game_playing() {
    level notify(#"game_playing");
    gamestate::set_state("playing");
    level callback::callback(#"on_game_playing");
    if (isdefined(level.var_6aec2d48) && level.var_6aec2d48 > 0) {
        thread function_b4262bec();
    }
    level clientfield::set("gameplay_started", 1);
    function_5fad41b5();
    function_54987b67();
    match_record::set_stat(#"hash_5288d149bac65a79", gettime());
}

// Namespace globallogic/globallogic
// Params 0, eflags: 0x5 linked
// Checksum 0x13ffc53f, Offset: 0xc770
// Size: 0x68
function private function_b4262bec() {
    level endon(#"game_ended");
    level.friendlyfire = level.var_78d89cdd;
    level.var_40eaa459 = 1;
    wait level.var_6aec2d48;
    level.friendlyfire = level.var_a65e8e93;
    level.var_40eaa459 = 0;
}

// Namespace globallogic/globallogic
// Params 0, eflags: 0x1 linked
// Checksum 0x62d7f8d6, Offset: 0xc7e0
// Size: 0x94
function function_edb0e0f0() {
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
// Params 0, eflags: 0x1 linked
// Checksum 0x619ed92d, Offset: 0xc880
// Size: 0x15c
function startgame() {
    callback::on_game_playing(&globallogic_utils::gametimer);
    level.timerstopped = 0;
    level.playabletimerstopped = 0;
    gamestate::set_state("pregame");
    function_8111babb();
    if (isdefined(level.custom_prematch_period)) {
        [[ level.custom_prematch_period ]]();
    } else {
        prematchperiod();
    }
    if (!gamestate::is_state("pregame")) {
        return;
    }
    set_game_playing();
    /#
        rat::function_7d22c1c9();
    #/
    thread showobjectivenotificationuiforallplayers(undefined, 0);
    thread timelimitclock();
    thread graceperiod();
    thread watchmatchendingsoon();
    thread globallogic_audio::announcercontroller();
    thread globallogic_audio::sndmusicfunctions();
    function_edb0e0f0();
}

// Namespace globallogic/globallogic
// Params 1, eflags: 0x1 linked
// Checksum 0x479a4590, Offset: 0xc9e8
// Size: 0xfc
function isprematchrequirementconditionmet(activeteamcount) {
    if (level.prematchrequirement == 0) {
        return true;
    }
    if (level.teambased) {
        if (activeteamcount.size <= 1) {
            return false;
        }
        arraykeys = getarraykeys(activeteamcount);
        for (index = 0; index < arraykeys.size; index++) {
            if (arraykeys[index] == #"any") {
                continue;
            }
            teamcount = activeteamcount[arraykeys[index]];
            if (teamcount < level.prematchrequirement) {
                return false;
            }
        }
    } else if (activeteamcount[#"any"] != level.prematchrequirement) {
        return false;
    }
    return true;
}

// Namespace globallogic/globallogic
// Params 0, eflags: 0x1 linked
// Checksum 0xbe67309f, Offset: 0xcaf0
// Size: 0x49c
function waitforplayers() {
    println("<dev string:x100>");
    level endon(#"game_ended");
    starttime = gettime();
    playerready = 0;
    activeplayercount = 0;
    if (getdvarint(#"hash_7b7a98dd2262c586", 0) || getdvarint(#"hash_7d7e2fc8bbc292a1", 0)) {
        accepttestclient = 1;
    } else {
        accepttestclient = 0;
    }
    activeteamcount = [];
    player_ready = [];
    while (!playerready || activeplayercount == 0 || !isprematchrequirementconditionmet(activeteamcount)) {
        activeplayercount = 0;
        foreach (team, _ in level.teams) {
            activeteamcount[team] = 0;
        }
        activeteamcount[#"any"] = 0;
        temp_player_ready = [];
        foreach (player in getplayers()) {
            if (player istestclient() && accepttestclient == 0) {
                continue;
            }
            if (player.team != #"spectator") {
                activeplayercount++;
                player_num = player getentitynumber();
                if (isdefined(player_ready[player_num])) {
                    temp_player_ready[player_num] = player_ready[player_num];
                } else {
                    player luinotifyevent(#"prematch_waiting_for_players");
                    temp_player_ready[player_num] = gettime();
                }
                if (temp_player_ready[player_num] + 5000 < gettime() || player isstreamerready(-1, 1)) {
                    activeteamcount[player.team]++;
                    activeteamcount[#"any"]++;
                }
            }
            if (player isstreamerready(-1, 1)) {
                if (playerready == 0) {
                    level notify(#"first_player_ready", {#player:player});
                }
                playerready = 1;
            }
        }
        player_ready = temp_player_ready;
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
    println("<dev string:x12a>");
}

// Namespace globallogic/globallogic
// Params 0, eflags: 0x1 linked
// Checksum 0xa70f1d3a, Offset: 0xcf98
// Size: 0x4c
function prematchwaitingforplayers() {
    if (level.prematchrequirement != 0) {
        level waittill(#"first_player_ready");
        luinotifyevent(#"prematch_waiting_for_players");
    }
}

// Namespace globallogic/globallogic
// Params 2, eflags: 0x1 linked
// Checksum 0xbb7ddbfb, Offset: 0xcff0
// Size: 0x2c
function function_66cbfaf2(var_dc5ec12b, var_1be62bdc) {
    thread matchstarttimer(var_dc5ec12b, var_1be62bdc);
}

// Namespace globallogic/globallogic
// Params 0, eflags: 0x5 linked
// Checksum 0x9470d407, Offset: 0xd028
// Size: 0x24
function private function_17951c74() {
    thread prematchwaitingforplayers();
    waitforplayers();
}

// Namespace globallogic/globallogic
// Params 0, eflags: 0x1 linked
// Checksum 0xf2a5a883, Offset: 0xd058
// Size: 0x414
function prematchperiod() {
    println("<dev string:x152>");
    setmatchflag("hud_hardcore", level.hardcoremode);
    level endon(#"game_ended");
    if (draft::is_draft_this_round()) {
        level thread draft::start();
        level waittill(#"draft_complete");
        if (isdefined(level.var_f3e25805)) {
            level thread [[ level.var_f3e25805 ]]();
        }
        function_654d64ea();
    } else {
        if (isdefined(level.var_f3e25805)) {
            level thread [[ level.var_f3e25805 ]]();
        }
        if (isdefined(level.var_86513cd0)) {
            [[ level.var_86513cd0 ]]();
        }
        level callback::callback(#"hash_61d33e99084dd46c");
        if (level.prematchperiod > 0) {
            var_c9d22c5d = 1;
            if (namespace_66d6aa44::function_41a307f8()) {
                println("<dev string:x17c>");
                function_17951c74();
                var_c9d22c5d = 0;
                namespace_66d6aa44::function_7ef87935();
                if (!namespace_66d6aa44::function_14956b80()) {
                    namespace_66d6aa44::function_ba9e4286();
                }
                println("<dev string:x1bc>");
            }
            if (namespace_66d6aa44::function_14956b80()) {
                if (var_c9d22c5d) {
                    function_17951c74();
                }
                namespace_66d6aa44::function_e94b8e1a(&function_66cbfaf2, level.prematchperiod);
            } else {
                thread matchstarttimer(level.prematchperiod);
                if (var_c9d22c5d) {
                    function_17951c74();
                }
                wait level.prematchperiod;
            }
        } else {
            thread matchstarttimer(level.prematchperiod);
            matchstarttimerskip();
            waitframe(1);
        }
        level.inprematchperiod = 0;
        foreach (player in level.players) {
            player val::reset(#"spawn_player", "freezecontrols");
            player val::reset(#"spawn_player", "disablegadgets");
            player enableweapons();
            player callback::callback(#"prematch_end");
        }
        level callback::callback(#"prematch_end");
    }
    println("<dev string:x1fa>");
}

// Namespace globallogic/globallogic
// Params 0, eflags: 0x1 linked
// Checksum 0x9f5c01ce, Offset: 0xd478
// Size: 0x164
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
// Params 0, eflags: 0x1 linked
// Checksum 0x5c186b42, Offset: 0xd5e8
// Size: 0x64
function watchmatchendingsoon() {
    setdvar(#"xblive_matchendingsoon", 0);
    level waittill(#"match_ending_soon");
    setdvar(#"xblive_matchendingsoon", 1);
}

// Namespace globallogic/globallogic
// Params 0, eflags: 0x1 linked
// Checksum 0x16018995, Offset: 0xd658
// Size: 0x90
function anyteamhaswavedelay() {
    foreach (team, _ in level.teams) {
        if (level.wavedelay[team]) {
            return true;
        }
    }
    return false;
}

// Namespace globallogic/globallogic
// Params 0, eflags: 0x1 linked
// Checksum 0xad0917f7, Offset: 0xd6f0
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
// Params 0, eflags: 0x1 linked
// Checksum 0x23b9aa8, Offset: 0xd790
// Size: 0x44
function function_8af3b312() {
    if (isdefined(level.var_cdb8ae2c)) {
        [[ level.var_cdb8ae2c ]]();
    }
    influencers::create_map_placed_influencers();
    spawning::addspawns();
}

// Namespace globallogic/globallogic
// Params 0, eflags: 0x1 linked
// Checksum 0xfdf74864, Offset: 0xd7e0
// Size: 0x38
function on_game_playing() {
    wavedelay = level.waverespawndelay;
    if (wavedelay) {
        level thread [[ level.wavespawntimer ]]();
    }
}

// Namespace globallogic/globallogic
// Params 0, eflags: 0x1 linked
// Checksum 0x1e22c596, Offset: 0xd820
// Size: 0x1954
function function_b9b7618() {
    level.prematchrequirement = 0;
    level.prematchperiod = 0;
    level.intermission = 0;
    setmatchflag("cg_drawSpectatorMessages", 1);
    if (!isdefined(game.gamestarted)) {
        assert(isdefined(game.attackers) && isdefined(game.defenders));
        assert(game.attackers != game.defenders);
        gamestate::set_state("pregame");
        game.strings[#"press_to_spawn"] = #"hash_203ff65a4ee460e6";
        if (level.teambased) {
            game.strings[#"waiting_for_teams"] = #"hash_150c54160239825";
            game.strings[#"opponent_forfeiting_in"] = #"hash_52d76ed35e0b625a";
        } else {
            game.strings[#"waiting_for_teams"] = #"hash_47c479655d474f31";
            game.strings[#"opponent_forfeiting_in"] = #"hash_52d76ed35e0b625a";
        }
        game.strings[#"match_starting_in"] = #"hash_18e58cc95db34427";
        game.strings[#"spawn_next_round"] = #"mp/spawn_next_round";
        game.strings[#"waiting_to_spawn"] = #"mp/waiting_to_spawn";
        game.strings[#"waiting_to_spawn_ss"] = #"hash_78bf3a61cf52e257";
        game.strings[#"you_will_spawn"] = #"hash_53c0ba6abce1c0ea";
        game.strings[#"match_starting"] = #"mp/match_starting";
        game.strings[#"change_class"] = #"mp/change_class_next_spawn";
        game.strings[#"item_on_respawn"] = #"hash_220160808c99fe71";
        game.strings[#"hash_b71875e85956ea"] = #"hash_61f8bf2959b7bd5a";
        game.strings[#"last_stand"] = #"hash_5732d212e4511a00";
        game.strings[#"cowards_way"] = #"hash_268e464278a2f8ff";
        [[ level.onprecachegametype ]]();
        game.gamestarted = 1;
        game.totalkills = 0;
        teams::function_45721cef();
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
            print("<dev string:x222>");
        #/
        if (!isdefined(level.friendlyfiredelaytime)) {
            level.friendlyfiredelaytime = 0;
        }
    }
    level.rankcap = getdvarint(#"scr_max_rank", 0);
    level.minprestige = getdvarint(#"scr_min_prestige", 0);
    if (isdefined(getgametypesetting(#"hash_29fd164e7ff1abb0")) ? getgametypesetting(#"hash_29fd164e7ff1abb0") : 0) {
        spawning::function_6325a7c5();
    } else {
        spawning::function_7a87efaa();
    }
    if (!isdefined(level.alwaysusestartspawns)) {
        level.alwaysusestartspawns = 0;
    }
    level.usexcamsforendgame = 0;
    level.cumulativeroundscores = getgametypesetting(#"cumulativeroundscores");
    level.playerqueuedrespawn = getgametypesetting(#"playerqueuedrespawn");
    level.playerforcerespawn = getgametypesetting(#"playerforcerespawn");
    level.roundstartexplosivedelay = getgametypesetting(#"roundstartexplosivedelay");
    level.roundstartkillstreakdelay = getgametypesetting(#"roundstartkillstreakdelay");
    level.perksenabled = getgametypesetting(#"perksenabled");
    level.disableattachments = getgametypesetting(#"disableattachments");
    level.disabletacinsert = getgametypesetting(#"disabletacinsert");
    level.var_d0e6b79d = getgametypesetting(#"hash_47df56af71e4df3");
    level.disablecustomcac = getgametypesetting(#"disablecustomcac");
    level.disableclassselection = getgametypesetting(#"disableclassselection");
    level.disableweapondrop = getgametypesetting(#"disableweapondrop");
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
    if (sessionmodeismultiplayergame()) {
        level.var_90bb9821 = getgametypesetting(#"specialistmaxhealth_allies_1") - 150;
        level.minimumallowedteamkills = getgametypesetting(#"specialistteamkillsallowed_allies_1") - 1;
        level.onlyheadshots = getgametypesetting(#"specialistonlyheadshots_allies_1");
        level.allowhitmarkers = getgametypesetting(#"hash_7477eea36687a960");
    } else {
        level.var_90bb9821 = getgametypesetting(#"playermaxhealth") - 150;
        level.minimumallowedteamkills = getgametypesetting(#"teamkillpunishcount") - 1;
        level.onlyheadshots = getgametypesetting(#"onlyheadshots");
        level.allowhitmarkers = getgametypesetting(#"allowhitmarkers");
    }
    level.autoheal = getgametypesetting(#"autoheal");
    level.scoreresetondeath = getgametypesetting(#"scoreresetondeath");
    level.ekiaresetondeath = getgametypesetting(#"ekiaresetondeath");
    level.var_c77de7d6 = getgametypesetting(#"hash_32da91b78e54e7b5");
    level.playerrespawndelay = getgametypesetting(#"playerrespawndelay");
    level.playerincrementalrespawndelay = getgametypesetting(#"incrementalspawndelay");
    level.playerobjectiveheldrespawndelay = getgametypesetting(#"playerobjectiveheldrespawndelay");
    level.waverespawndelay = getgametypesetting(#"waverespawndelay");
    level.suicidespawndelay = getgametypesetting(#"spawnsuicidepenalty");
    level.teamkilledspawndelay = getgametypesetting(#"spawnteamkilledpenalty");
    level.maxsuicidesbeforekick = getgametypesetting(#"maxsuicidesbeforekick");
    level.spectatetype = getgametypesetting(#"spectatetype");
    level.var_1ba484ad = getgametypesetting(#"hash_212cc2b5b360189c");
    level.voip = spawnstruct();
    level.voip.deadchatwithdead = getgametypesetting(#"voipdeadchatwithdead");
    level.voip.deadchatwithteam = getgametypesetting(#"voipdeadchatwithteam");
    level.voip.deadchatwithsquad = getgametypesetting(#"hash_7b8284382bffc197");
    level.voip.livingchatwithsquad = getgametypesetting(#"hash_6e6991561babdd7e");
    level.voip.deadhearallliving = getgametypesetting(#"voipdeadhearallliving");
    level.voip.deadhearteamliving = getgametypesetting(#"voipdeadhearteamliving");
    level.voip.everyonehearseveryone = getgametypesetting(#"voipeveryonehearseveryone");
    level.voip.everyonehearsfriendly = getgametypesetting(#"hash_2a76bf462f4c2f50");
    level.voip.deadhearkiller = getgametypesetting(#"voipdeadhearkiller");
    level.voip.killershearvictim = getgametypesetting(#"voipkillershearvictim");
    level.voip.partychat = getgametypesetting(#"hash_33bc6781006ae83d");
    level.droppedtagrespawn = getgametypesetting(#"droppedtagrespawn");
    level.var_5b544215 = isdefined(getgametypesetting(#"hash_444634d99df7a661")) ? getgametypesetting(#"hash_444634d99df7a661") : 0;
    if (is_true(level.droppedtagrespawn)) {
        dogtags::init();
    }
    gameobjects::main();
    foreach (team, _ in level.teams) {
        initteamvariables(team);
    }
    initteamvariables(#"none");
    level.maxplayercount = 0;
    level.alivetimemaxcount = 3;
    level.alivetimesaverage = [];
    level.var_a236b703 = [];
    level.var_61952d8b = [];
    level.deaths = [];
    foreach (team, _ in level.teams) {
        level.alivetimesaverage[team] = 0;
        level.var_a236b703[team] = 0;
        level.var_61952d8b[team] = 0;
        level.deaths[team] = 0;
    }
    if (!isdefined(level.livesdonotreset) || !level.livesdonotreset) {
        if (level.teambased) {
            foreach (team, _ in level.teams) {
                game.lives[team] = level.numteamlives;
            }
            level thread setteamlivesuimodels();
        } else {
            foreach (team, _ in level.teams) {
                game.lives[team] = 0;
            }
        }
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
    if (!display_transition::using_new_transitions()) {
        globallogic_utils::registerpostroundevent(&killcam::function_a26057ee);
        globallogic_utils::registerpostroundevent(&potm::post_round_potm);
    }
    wavedelay = level.waverespawndelay;
    if (wavedelay) {
        foreach (team, _ in level.teams) {
            level.wavedelay[team] = wavedelay;
            level.lastwave[team] = 0;
        }
    }
    level.inprematchperiod = 1;
    if (level.prematchperiod > 2 && level.rankedmatch) {
        level.prematchperiod += randomfloat(4) - 2;
    }
    if (level.numlives || anyteamhaswavedelay() || level.playerqueuedrespawn) {
        level.graceperiod = 15;
    } else {
        level.graceperiod = 10;
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
    level.var_aa5e6547 = strendswith(isdefined(level.gametype) ? level.gametype : "", "_cwl");
    if (level.var_aa5e6547) {
        var_1141ae61 = getdvarfloat(#"hash_5349c39a9c2a9357", 1e-06);
        if (var_1141ae61 > 0) {
            var_480ff6af = var_1141ae61 <= 1e-06 ? 0 : var_1141ae61;
            setgametypesetting("scoreHeroPowerTimeFactor", var_480ff6af);
        }
    }
    /#
        setdebugsideswitch(game.switchedsides);
    #/
}

/#

    // Namespace globallogic/globallogic
    // Params 0, eflags: 0x0
    // Checksum 0x73bc1c81, Offset: 0xf180
    // Size: 0x3a
    function function_c35255d6() {
        if (getdvarint(#"hash_32817346b14acbcc", 0) > 0) {
            return 1;
        }
        return 0;
    }

    // Namespace globallogic/globallogic
    // Params 2, eflags: 0x0
    // Checksum 0x385c0118, Offset: 0xf1c8
    // Size: 0xe0
    function function_891f6555(origin, color) {
        start = origin + (0, 0, 70000);
        end = origin - (0, 0, 70000);
        alpha = 1;
        duration = 1;
        while (true) {
            if (function_c35255d6()) {
                line(start, end, color, alpha, 1, duration);
                debugstar(origin, duration, color);
                waitframe(1);
                continue;
            }
            wait 1;
        }
    }

    // Namespace globallogic/globallogic
    // Params 0, eflags: 0x0
    // Checksum 0xd47582ed, Offset: 0xf2b0
    // Size: 0xe4
    function function_6e1f21c4() {
        wait 1;
        assert(isdefined(level.mapcenter));
        thread function_891f6555(level.mapcenter, (1, 0, 0));
        minimaporigins = getentarray("<dev string:x239>", "<dev string:x24b>");
        if (minimaporigins.size >= 2) {
            thread function_891f6555(minimaporigins[0].origin, (0, 1, 1));
            thread function_891f6555(minimaporigins[1].origin, (0, 0, 1));
        }
    }

#/

// Namespace globallogic/globallogic
// Params 0, eflags: 0x5 linked
// Checksum 0x4384ca75, Offset: 0xf3a0
// Size: 0x24c
function private calculate_map_center() {
    /#
        thread function_6e1f21c4();
    #/
    if (isdefined(level.mapcenter)) {
        return;
    }
    minimaporigins = getentarray("minimap_corner", "targetname");
    if (minimaporigins.size >= 2) {
        level.var_6d222488 = math::expand_mins((0, 0, 0), minimaporigins[0].origin);
        level.var_6d222488 = math::expand_mins(level.var_6d222488, minimaporigins[1].origin);
        level.var_7ac790f2 = math::expand_maxs((0, 0, 0), minimaporigins[0].origin);
        level.var_7ac790f2 = math::expand_maxs(level.var_6d222488, minimaporigins[1].origin);
        level.var_7ac790f2 = minimaporigins[1].origin;
        level.mapcenter = math::find_box_center(level.var_6d222488, minimaporigins[1].origin);
        setmapcenter(level.mapcenter);
        return;
    }
    level.mapcenter = (0, 0, 0);
    level.var_6d222488 = (-5000, -5000, -5000);
    level.var_7ac790f2 = (5000, 5000, 5000);
    setmapcenter(level.mapcenter);
    /#
        var_2c05cfaa = "<dev string:x259>";
        if (minimaporigins.size == 1) {
            println("<dev string:x2a9>" + var_2c05cfaa);
            return;
        }
        println("<dev string:x2e4>" + var_2c05cfaa);
    #/
}

// Namespace globallogic/globallogic
// Params 0, eflags: 0x1 linked
// Checksum 0x97edacc4, Offset: 0xf5f8
// Size: 0x19c
function callback_startgametype() {
    function_b9b7618();
    [[ level.var_6c4ec3fc ]]();
    calculate_map_center();
    gametype::on_start_game_type();
    callback::callback(#"on_start_gametype");
    [[ level.onstartgametype ]]();
    level thread killcam::do_final_killcam();
    level thread updategametypedvars();
    thread startgame();
    level thread simple_hostmigration::updatehostmigrationdata();
    if (!is_true(level.var_f16f6c66)) {
        level thread radar_sweeps::radarsweeps();
    }
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

/#

    // Namespace globallogic/globallogic
    // Params 0, eflags: 0x0
    // Checksum 0x74f2b0a3, Offset: 0xf7a0
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
// Params 4, eflags: 0x1 linked
// Checksum 0x55f80d53, Offset: 0xf7f8
// Size: 0x114
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
// Params 0, eflags: 0x1 linked
// Checksum 0xc5369159, Offset: 0xf918
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
// Params 1, eflags: 0x1 linked
// Checksum 0xa18da8aa, Offset: 0xf988
// Size: 0x102
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
// Params 1, eflags: 0x1 linked
// Checksum 0x8d503f9c, Offset: 0xfa98
// Size: 0x74
function updaterankedmatch(outcome) {
    if (level.rankedmatch) {
        if (hostidledout()) {
            level.hostforcedend = 1;
            /#
                print("<dev string:x320>");
            #/
        }
    }
    globallogic_score::updatematchbonusscores(outcome);
}

// Namespace globallogic/globallogic
// Params 3, eflags: 0x1 linked
// Checksum 0x53f1cf71, Offset: 0xfb18
// Size: 0x14c
function annihilatorgunplayerkilleffect(attacker, weapon, smeansofdeath) {
    if (smeansofdeath == "MOD_IMPACT") {
        wait weapon.fusetime / 1000;
    } else if (weapon.fusetime != 0) {
        wait 0.1;
    } else {
        wait 0.45;
    }
    if (!isdefined(self)) {
        return;
    }
    if (isdefined(attacker)) {
        self playsoundtoplayer(#"evt_annihilation_plr", attacker);
        self playsoundtoallbutplayer(#"evt_annihilation_npc", attacker);
    }
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
// Params 2, eflags: 0x1 linked
// Checksum 0x46f94978, Offset: 0xfc70
// Size: 0x174
function annihilatorgunactorkilleffect(attacker, weapon) {
    self endon(#"death");
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
    if (isdefined(attacker)) {
        self playsoundtoplayer(#"evt_annihilation_plr", attacker);
        self playsoundtoallbutplayer(#"evt_annihilation_npc", attacker);
    }
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
// Checksum 0xa37a7649, Offset: 0xfdf0
// Size: 0xcc
function pineapplegunplayerkilleffect(*attacker) {
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
// Checksum 0xc3e172aa, Offset: 0xfec8
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
// Checksum 0x914f9798, Offset: 0xff90
// Size: 0x114
function pineapplegunactorkilleffect() {
    self endon(#"death");
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
// Params 4, eflags: 0x1 linked
// Checksum 0x87d408c4, Offset: 0x100b0
// Size: 0xdc
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
// Params 4, eflags: 0x1 linked
// Checksum 0x1dd25961, Offset: 0x10198
// Size: 0x168
function function_e050e788(weapon, attacker, einflictor, smeansofdeath) {
    if (!weapon.doannihilate) {
        return false;
    }
    if (randomfloat(1) > weapon.var_36c76157) {
        return false;
    }
    if (!isplayer(attacker)) {
        return false;
    }
    if (smeansofdeath != "MOD_IMPACT" && smeansofdeath != "MOD_GRENADE" && smeansofdeath != "MOD_GRENADE_SPLASH" && smeansofdeath != "MOD_PROJECTILE" && smeansofdeath != "MOD_PROJECTILE_SPLASH" && smeansofdeath != "MOD_MELEE") {
        return false;
    }
    if (smeansofdeath == "MOD_IMPACT" && weapon.var_6262fd11) {
        return false;
    }
    if ((smeansofdeath == "MOD_GRENADE_SPLASH" || smeansofdeath == "MOD_PROJECTILE_SPLASH") && !(isdefined(einflictor) && isdefined(einflictor.stucktoplayer) && einflictor.stucktoplayer == self)) {
        return false;
    }
    return true;
}

// Namespace globallogic/globallogic
// Params 9, eflags: 0x1 linked
// Checksum 0xcd10101f, Offset: 0x10308
// Size: 0x1cc
function doweaponspecificcorpseeffects(body, einflictor, attacker, *idamage, smeansofdeath, weapon, *vdir, *shitloc, *psoffsettime) {
    if (!isdefined(psoffsettime)) {
        return;
    }
    if (function_e050e788(psoffsettime, vdir, weapon, shitloc)) {
        if (isactor(smeansofdeath)) {
            smeansofdeath thread annihilatorgunactorkilleffect(vdir, psoffsettime);
        } else {
            smeansofdeath thread annihilatorgunplayerkilleffect(vdir, psoffsettime, shitloc);
        }
        return;
    }
    if (shitloc == "MOD_BURNED" || shitloc == "MOD_DOT" && psoffsettime.doesfiredamage) {
        if (!isactor(smeansofdeath)) {
            smeansofdeath thread burncorpse();
        }
        return;
    }
    if (psoffsettime.isheavyweapon && isplayer(vdir)) {
        if (psoffsettime.name == #"hero_firefly_swarm") {
            value = randomint(2) + 1;
            if (!isactor(smeansofdeath)) {
                codesetclientfield(smeansofdeath, "firefly_effect", value);
            }
        }
    }
}

// Namespace globallogic/globallogic
// Params 0, eflags: 0x1 linked
// Checksum 0xa51b7d32, Offset: 0x104e0
// Size: 0x64
function burncorpse() {
    self endon(#"death");
    codesetclientfield(self, "burned_effect", 1);
    wait 6;
    codesetclientfield(self, "burned_effect", 0);
}

// Namespace globallogic/globallogic
// Params 1, eflags: 0x1 linked
// Checksum 0x695337b, Offset: 0x10550
// Size: 0x4c
function function_991daa12(weapon) {
    if (weaponhasattachment(weapon, "ir")) {
        self clientfield::set_to_player("thermal_sight", 1);
    }
}

// Namespace globallogic/globallogic
// Params 1, eflags: 0x1 linked
// Checksum 0x976a3e88, Offset: 0x105a8
// Size: 0x4c
function function_ec7cf015(weapon) {
    if (weaponhasattachment(weapon, "ir")) {
        self clientfield::set_to_player("thermal_sight", 0);
    }
}

// Namespace globallogic/globallogic
// Params 1, eflags: 0x1 linked
// Checksum 0xf41b62c4, Offset: 0x10600
// Size: 0x136
function function_fdb8b430(player) {
    if (!isalive(player) || player.sessionstate != "playing") {
        return false;
    }
    if (!player util::isenemyteam(self.team)) {
        return false;
    }
    distsq = distancesquared(self.origin, player.origin);
    if (distsq > level.stroberange * level.stroberange) {
        return false;
    }
    if (!util::within_fov(self.origin, self.angles, player.origin, level.strobefov)) {
        return false;
    }
    if (!util::within_fov(player.origin, player getplayerangles(), self.origin, level.strobefov)) {
        return false;
    }
    return true;
}

// Namespace globallogic/globallogic
// Params 0, eflags: 0x0
// Checksum 0x625d9793, Offset: 0x10740
// Size: 0x214
function function_a4156fb2() {
    self notify("6683078b12b6f85b");
    self endon("6683078b12b6f85b");
    self endon(#"strobe_off", #"death");
    level.stroberange = getdvarint(#"strobe_range", 500);
    level.strobefov = cos(getdvarint(#"strobe_fov", 45));
    while (true) {
        enemyplayers = getplayers("all", self.origin, level.stroberange * 2);
        foreach (player in enemyplayers) {
            if (self function_fdb8b430(player)) {
                if (!is_true(player.strobed)) {
                    player clientfield::set_to_player("strobe_light", 1);
                    player.strobed = 1;
                }
                continue;
            }
            if (is_true(player.strobed)) {
                player clientfield::set_to_player("strobe_light", 0);
                player.strobed = 0;
            }
        }
        waitframe(1);
    }
}

// Namespace globallogic/globallogic
// Params 0, eflags: 0x0
// Checksum 0x3401b413, Offset: 0x10960
// Size: 0x10a
function function_b761e219() {
    self notify(#"strobe_off");
    enemyplayers = getplayers();
    foreach (player in enemyplayers) {
        if (!player util::isenemyteam(self.team)) {
            continue;
        }
        if (is_true(player.strobed)) {
            player clientfield::set_to_player("strobe_light", 0);
            player.strobed = 0;
        }
    }
}

// Namespace globallogic/globallogic
// Params 3, eflags: 0x1 linked
// Checksum 0xa1ae46b2, Offset: 0x10a78
// Size: 0x76
function function_3305e557(player, statname, defaultvalue) {
    if (!isdefined(player) || !isplayer(player)) {
        return;
    }
    if (!isdefined(player.pers[statname])) {
        player.pers[statname] = defaultvalue;
    }
    player.pers[statname]++;
}

