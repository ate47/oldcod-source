#using script_165beea08a63a243;
#using script_190d6b82bcca0908;
#using script_1caf36ff04a85ff6;
#using script_2c5daa95f8fec03c;
#using script_301f64a4090c381a;
#using script_355c6e84a79530cb;
#using script_3688d332e17e9ac1;
#using script_3a88f428c6d8ef90;
#using script_4194df57536e11ed;
#using script_41b18a77720c5395;
#using script_4421226bbc54b398;
#using script_4599f8932c8c9e42;
#using script_4721de209091b1a6;
#using script_48f7c4ab73137f8;
#using script_556e19065f09f8a2;
#using script_5a525a75a8f1f7e4;
#using script_61828ad9e71c6616;
#using script_62caa307a394c18c;
#using script_72401f526ba71638;
#using script_7bdcff4f92f3d220;
#using script_b9d273dc917ee1f;
#using scripts\core_common\aat_shared;
#using scripts\core_common\ai\systems\gib;
#using scripts\core_common\ai\zombie_death;
#using scripts\core_common\ai\zombie_utility;
#using scripts\core_common\ai_puppeteer_shared;
#using scripts\core_common\ai_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\demo_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\gamestate;
#using scripts\core_common\globallogic\globallogic_vehicle;
#using scripts\core_common\hud_shared;
#using scripts\core_common\hud_util_shared;
#using scripts\core_common\item_inventory;
#using scripts\core_common\item_world;
#using scripts\core_common\killcam_shared;
#using scripts\core_common\laststand_shared;
#using scripts\core_common\lui_shared;
#using scripts\core_common\music_shared;
#using scripts\core_common\perks;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\potm_shared;
#using scripts\core_common\rat_shared;
#using scripts\core_common\scoreevents_shared;
#using scripts\core_common\status_effects\status_effects;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\core_common\visionset_mgr_shared;
#using scripts\killstreaks\annihilator;
#using scripts\killstreaks\flamethrower;
#using scripts\killstreaks\killstreak_bundles;
#using scripts\killstreaks\killstreak_detect;
#using scripts\killstreaks\killstreak_hacking;
#using scripts\killstreaks\killstreakrules_shared;
#using scripts\killstreaks\killstreaks_shared;
#using scripts\killstreaks\killstreaks_util;
#using scripts\killstreaks\scythe;
#using scripts\killstreaks\sparrow;
#using scripts\killstreaks\warmachine;
#using scripts\killstreaks\zm\ultimate_turret;
#using scripts\zm\perk\zm_perk_deadshot;
#using scripts\zm\perk\zm_perk_juggernaut;
#using scripts\zm\perk\zm_perk_quick_revive;
#using scripts\zm\powerup\zm_powerup_bonus_points_player;
#using scripts\zm\weapons\zm_weap_claymore;
#using scripts\zm\weapons\zm_weap_homunculus;
#using scripts\zm\weapons\zm_weap_mini_turret;
#using scripts\zm_common\ai\zm_ai_utility;
#using scripts\zm_common\bb;
#using scripts\zm_common\bots\zm_bot;
#using scripts\zm_common\callings\zm_callings;
#using scripts\zm_common\gametypes\globallogic;
#using scripts\zm_common\gametypes\globallogic_player;
#using scripts\zm_common\gametypes\globallogic_scriptmover;
#using scripts\zm_common\gametypes\globallogic_spawn;
#using scripts\zm_common\gametypes\zm_gametype;
#using scripts\zm_common\scoreevents;
#using scripts\zm_common\trials\zm_trial_headshots_only;
#using scripts\zm_common\util;
#using scripts\zm_common\zm_armor;
#using scripts\zm_common\zm_attachments;
#using scripts\zm_common\zm_audio;
#using scripts\zm_common\zm_bgb;
#using scripts\zm_common\zm_blockers;
#using scripts\zm_common\zm_challenges;
#using scripts\zm_common\zm_characters;
#using scripts\zm_common\zm_cleanup_mgr;
#using scripts\zm_common\zm_crafting;
#using scripts\zm_common\zm_customgame;
#using scripts\zm_common\zm_daily_challenges;
#using scripts\zm_common\zm_equipment;
#using scripts\zm_common\zm_ffotd;
#using scripts\zm_common\zm_game_module;
#using scripts\zm_common\zm_hero_weapon;
#using scripts\zm_common\zm_hud;
#using scripts\zm_common\zm_laststand;
#using scripts\zm_common\zm_loadout;
#using scripts\zm_common\zm_melee_weapon;
#using scripts\zm_common\zm_pack_a_punch_util;
#using scripts\zm_common\zm_perks;
#using scripts\zm_common\zm_placeable_mine;
#using scripts\zm_common\zm_player;
#using scripts\zm_common\zm_playerzombie;
#using scripts\zm_common\zm_powerups;
#using scripts\zm_common\zm_quick_spawning;
#using scripts\zm_common\zm_round_logic;
#using scripts\zm_common\zm_score;
#using scripts\zm_common\zm_spawner;
#using scripts\zm_common\zm_stats;
#using scripts\zm_common\zm_transformation;
#using scripts\zm_common\zm_trial;
#using scripts\zm_common\zm_trial_util;
#using scripts\zm_common\zm_unitrigger;
#using scripts\zm_common\zm_utility;
#using scripts\zm_common\zm_vo;
#using scripts\zm_common\zm_wallbuy;
#using scripts\zm_common\zm_weapons;
#using scripts\zm_common\zm_zonemgr;

#namespace zm;

// Namespace zm/zm
// Params 0, eflags: 0x2
// Checksum 0x67dfc9a5, Offset: 0x12f8
// Size: 0x284
function autoexec ignore_systems() {
    system::ignore(#"gadget_clone");
    system::ignore(#"gadget_armor");
    system::ignore(#"gadget_cleanse");
    system::ignore(#"gadget_heat_wave");
    system::ignore(#"gadget_resurrect");
    system::ignore(#"gadget_health_boost");
    system::ignore(#"gadget_shock_field");
    system::ignore(#"gadget_other");
    system::ignore(#"gadget_camo");
    system::ignore(#"gadget_vision_pulse");
    system::ignore(#"gadget_speed_burst");
    system::ignore(#"gadget_overdrive");
    system::ignore(#"gadget_security_breach");
    system::ignore(#"gadget_combat_efficiency");
    system::ignore(#"gadget_sprint_boost");
    system::ignore(#"spike_charge_siegebot");
    system::ignore(#"siegebot");
    system::ignore(#"amws");
    system::ignore(#"influencers_shared");
    system::ignore(#"mute_smoke");
}

// Namespace zm/zm
// Params 0, eflags: 0x6
// Checksum 0x9ead2146, Offset: 0x1588
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"zm", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace zm/zm
// Params 0, eflags: 0x5 linked
// Checksum 0x740453f9, Offset: 0x15d0
// Size: 0xdc
function private function_70a657d8() {
    if (!isdefined(level.zombie_vars)) {
        level.zombie_vars = [];
    }
    level.bgb_in_use = 0;
    level.var_7ed465e4 = &function_7ed465e4;
    level.scr_zm_ui_gametype = util::get_game_type();
    level.scr_zm_ui_gametype_group = "";
    level.scr_zm_map_start_location = "";
    level.var_aaf21bbb = 0;
    level.var_5caadd40 = 0;
    level.var_dcf5a517 = 1;
    level.var_74b10e67 = &register_perks;
    callback::on_connect(&on_connect);
}

// Namespace zm/zm
// Params 0, eflags: 0x1 linked
// Checksum 0xbdc476b, Offset: 0x16b8
// Size: 0x8b4
function init() {
    if (is_true(level.aat_in_use)) {
        register_vehicle_damage_callback(&aat::aat_vehicle_damage_monitor);
        register_zombie_damage_override_callback(&aat::aat_response);
    }
    setdvar(#"sprintleap_enabled", 0);
    setdvar(#"weaponrest_enabled", 0);
    setdvar(#"ui_allowdisplaycontinue", 1);
    if (!isdefined(level.killstreakweapons)) {
        level.killstreakweapons = [];
    }
    level.var_b68902c4 = 1;
    level.weaponnone = getweapon(#"none");
    level.weaponnull = getweapon(#"weapon_null");
    level.weaponbasemeleeheld = getweapon(#"bare_hands");
    if (!isdefined(level.weaponriotshield)) {
        level.weaponriotshield = getweapon(#"riotshield");
    }
    level.weaponrevivetool = getweapon(#"syrette");
    level.weaponzmdeaththroe = getweapon(#"death_throe");
    level.weaponzmfists = getweapon(#"hash_46125fd7f3ad4b82");
    level.projectiles_should_ignore_world_pause = 1;
    if (!isdefined(level.player_out_of_playable_area_monitor)) {
        level.player_out_of_playable_area_monitor = 1;
    }
    level.player_too_many_players_check = 1;
    level.player_too_many_players_check_func = &player_too_many_players_check;
    level._use_choke_weapon_hints = 1;
    level._use_choke_blockers = 1;
    level.speed_change_round = 15;
    if (!isdefined(level.custom_ai_type)) {
        level.custom_ai_type = [];
    }
    level.custom_ai_spawn_check_funcs = [];
    level thread zm_ffotd::main_start();
    level.zombiemode = 1;
    level.revivefeature = 0;
    level.swimmingfeature = 0;
    level.calc_closest_player_using_paths = 0;
    level.zombie_melee_in_water = 1;
    level.put_timed_out_zombies_back_in_queue = 1;
    level.use_alternate_poi_positioning = 1;
    level.zmb_laugh_alias = "zmb_player_outofbounds";
    level.sndannouncerisrich = 1;
    level.curr_gametype_affects_rank = 0;
    gametype = util::get_game_type();
    if ("zclassic" == gametype || "zstandard" == gametype) {
        level.curr_gametype_affects_rank = 1;
    }
    setailimit(40);
    level.grenade_multiattack_bookmark_count = 1;
    demo::initactorbookmarkparams(3, 6000, 6000);
    if (!isdefined(level._zombies_round_spawn_failsafe)) {
        level._zombies_round_spawn_failsafe = &zombie_utility::round_spawn_failsafe;
    }
    level.func_get_zombie_spawn_delay = &zm_round_logic::get_zombie_spawn_delay;
    level.func_get_delay_between_rounds = &zm_round_logic::get_delay_between_rounds;
    level.var_3426461d = &function_a2b54d42;
    level.no_target_override = &zm_cleanup::no_target_override;
    level.var_d22435d9 = &zm_cleanup::function_d22435d9;
    level.zombie_visionset = "zombie_neutral";
    level.wait_and_revive = 0;
    if (getdvarint(#"anim_intro", 0) == 1) {
        level.zombie_anim_intro = 1;
    } else {
        level.zombie_anim_intro = 0;
    }
    zm_player::precache_models();
    precache_zombie_leaderboards();
    level._zombie_gib_piece_index_all = 0;
    level._zombie_gib_piece_index_right_arm = 1;
    level._zombie_gib_piece_index_left_arm = 2;
    level._zombie_gib_piece_index_right_leg = 3;
    level._zombie_gib_piece_index_left_leg = 4;
    level._zombie_gib_piece_index_head = 5;
    level._zombie_gib_piece_index_guts = 6;
    level._zombie_gib_piece_index_hat = 7;
    if (!isdefined(level.zombie_ai_limit)) {
        level.zombie_ai_limit = 32;
    }
    if (!isdefined(level.zombie_actor_limit)) {
        level.zombie_actor_limit = 31;
    }
    level.var_7c7c6c35 = zm_game_over::register();
    init_flags();
    init_dvars();
    init_strings();
    init_levelvars();
    init_sounds();
    init_shellshocks();
    init_client_field_callback_funcs();
    zm_loadout::register_offhand_weapons_for_level_defaults();
    zm_perks::init();
    zm_powerups::init();
    level flag::set(#"hash_507a4486c4a79f1d");
    level.zombie_poi_array = getentarray("zombie_poi", "script_noteworthy");
    init_function_overrides();
    level thread zm_laststand::function_5ff83684();
    level thread post_all_players_connected();
    zm_utility::init_utility();
    initializestattracking();
    callback::on_connect(&zm_player::zm_on_player_connect);
    zm_utility::set_demo_intermission_point();
    level thread zm_ffotd::main_end();
    level thread zm_utility::track_players_intersection_tracker();
    level thread zm_utility::function_55295a16();
    level thread onallplayersready();
    level thread zm_round_logic::function_d20309f1();
    callback::on_spawned(&zm_player::zm_on_player_spawned);
    callback::on_disconnect(&on_player_disconnect);
    callback::on_deleted(&on_entity_deleted);
    level thread zm_utility::function_a3648315();
    level.var_f365bb30 = &function_85ea1f60;
    level.var_d539e0dd = &function_85ea1f60;
    /#
        printhashids();
    #/
}

// Namespace zm/zm
// Params 0, eflags: 0x1 linked
// Checksum 0xa8c15c1a, Offset: 0x1f78
// Size: 0x3c
function on_connect() {
    if (is_true(self.is_hotjoining)) {
        item_world::function_4c0953c4(level.item_spawn_seed);
    }
}

// Namespace zm/zm
// Params 0, eflags: 0x1 linked
// Checksum 0x92140d40, Offset: 0x1fc0
// Size: 0x1c
function on_player_disconnect() {
    zm_stats::function_ea5b4947(0);
}

// Namespace zm/zm
// Params 0, eflags: 0x1 linked
// Checksum 0xe4617bc1, Offset: 0x1fe8
// Size: 0x16
function on_entity_deleted() {
    self notify(#"deleted");
}

// Namespace zm/zm
// Params 0, eflags: 0x0
// Checksum 0xf7348d6b, Offset: 0x2008
// Size: 0x1c
function post_main() {
    level thread init_custom_ai_type();
}

// Namespace zm/zm
// Params 1, eflags: 0x1 linked
// Checksum 0xbe3ad483, Offset: 0x2030
// Size: 0x5e
function cheat_enabled(val) {
    if (getdvarint(#"zombie_cheat", 0) >= val) {
        /#
            return true;
        #/
        if (isprofilebuild()) {
            return true;
        }
    }
    return false;
}

// Namespace zm/zm
// Params 1, eflags: 0x1 linked
// Checksum 0x7420590f, Offset: 0x2098
// Size: 0x10c
function fade_out_intro_screen_zm(hold_black_time = 0.2) {
    if (isdefined(level.var_fdba6f4b)) {
        [[ level.var_fdba6f4b ]]();
    } else {
        wait hold_black_time;
    }
    level flag::set("initial_blackscreen_passed");
    level clientfield::set("sndZMBFadeIn", 1);
    wait level.var_ab367500;
    if (isdefined(level.var_3a382f82)) {
        wait level.var_3a382f82;
    } else {
        wait 1.6;
    }
    level flag::set("gameplay_started");
    level clientfield::set("gameplay_started", 1);
    setmatchflag("disableIngameMenu", 0);
}

// Namespace zm/zm
// Params 0, eflags: 0x1 linked
// Checksum 0xdaf7d1b8, Offset: 0x21b0
// Size: 0x474
function onallplayersready() {
    level endon(#"game_ended");
    changeadvertisedstatus(0);
    while (isloadingcinematicplaying()) {
        waitframe(1);
    }
    gametype = hash(util::get_game_type());
    if (gametype == #"zclassic" || gametype == #"zsurvival") {
        changeadvertisedstatus(1);
    }
    while (!getnumexpectedplayers(1)) {
        waitframe(1);
    }
    println("<dev string:x38>" + getnumexpectedplayers(1));
    player_count_actual = 0;
    while (player_count_actual < getnumexpectedplayers(1)) {
        players = getplayers();
        player_count_actual = 0;
        for (i = 0; i < players.size; i++) {
            if (players[i].sessionstate == "playing" && !isbot(players[i])) {
                player_count_actual++;
            }
        }
        println("<dev string:x58>" + getnumconnectedplayers() + "<dev string:x71>" + getnumexpectedplayers(1));
        waitframe(1);
    }
    setinitialplayersconnected();
    println("<dev string:x81>");
    a_e_players = getplayers();
    if (a_e_players.size == 1) {
        level flag::set("solo_game");
        level.solo_lives_given = 0;
    }
    level flag::set("all_players_connected");
    function_9a8ab40f();
    while (!aretexturesloaded()) {
        waitframe(1);
    }
    level util::streamer_wait(undefined, 2, 15);
    wait 5;
    function_5fad41b5();
    n_start_delay = 3;
    level thread util::delay(n_start_delay, "game_ended", &flag::set, "start_zombie_round_logic");
    level thread function_d797f41f(n_start_delay - 0.1);
    set_intermission_point();
    n_black_screen = n_start_delay + 2;
    level thread fade_out_intro_screen_zm(n_black_screen);
    wait n_black_screen;
    level.n_gameplay_start_time = gettime();
    clientfield::set("game_start_time", level.n_gameplay_start_time);
    level flag::set("initial_fade_in_complete");
    /#
        rat::function_7d22c1c9();
    #/
    wait n_start_delay;
    luinotifyevent(#"hash_3aef0da8363893b6");
}

// Namespace zm/zm
// Params 0, eflags: 0x1 linked
// Checksum 0xc4ce947a, Offset: 0x2630
// Size: 0xce
function function_9a8ab40f() {
    do {
        waitframe(1);
        var_183929a8 = 0;
        a_players = getplayers();
        foreach (player in a_players) {
            if (!player isloadingcinematicplaying()) {
                var_183929a8++;
            }
        }
    } while (a_players.size > var_183929a8);
}

// Namespace zm/zm
// Params 1, eflags: 0x1 linked
// Checksum 0xa49e6df2, Offset: 0x2708
// Size: 0x22
function function_d797f41f(n_waittime = 1) {
    wait n_waittime;
}

// Namespace zm/zm
// Params 1, eflags: 0x0
// Checksum 0x55d38432, Offset: 0x2738
// Size: 0xa8
function _outro_slow(func) {
    level endon(#"all_players_connected", #"game_ended");
    array::thread_all(getplayers(), func);
    while (true) {
        result = level waittill(#"connected");
        result.player thread [[ func ]]();
    }
}

// Namespace zm/zm
// Params 0, eflags: 0x1 linked
// Checksum 0x3024ab76, Offset: 0x27e8
// Size: 0x394
function initialblack() {
    self endon(#"disconnect");
    util::function_1690fd42(self);
    gametype = hash(util::get_game_type());
    if (gametype != #"zsurvival" && level flag::get("start_zombie_round_logic")) {
        return;
    }
    if (!is_true(self.hasspawned)) {
        self waittill(#"spawned");
    }
    do {
        waitframe(1);
    } while (!self isclientuivisibilityflagset("hud_visible"));
    val::set(#"initial_black", "hide");
    val::set(#"initial_black", "takedamage", 0);
    val::set(#"initial_black", "ignoreme");
    val::set(#"initial_black", "freezecontrols");
    val::set(#"initial_black", "disablegadgets");
    val::set(#"initial_black", "show_hud", 0);
    level flag::wait_till("initial_blackscreen_passed");
    lui::screen_fade_out(0);
    util::wait_network_frame(2);
    util::function_cd98604b(self);
    val::reset(#"initial_black", "hide");
    val::reset(#"initial_black", "takedamage");
    util::wait_network_frame(2);
    val::reset(#"initial_black", "freezecontrols");
    self thread lui::screen_fade_in(level.var_ab367500);
    level flag::wait_till("gameplay_started");
    val::reset(#"initial_black", "ignoreme");
    val::reset(#"initial_black", "disablegadgets");
    val::reset(#"initial_black", "show_hud");
}

// Namespace zm/zm
// Params 0, eflags: 0x1 linked
// Checksum 0xa8c13ae4, Offset: 0x2b88
// Size: 0xf0
function delete_in_createfx() {
    exterior_goals = struct::get_array("exterior_goal", "targetname");
    for (i = 0; i < exterior_goals.size; i++) {
        if (!isdefined(exterior_goals[i].target)) {
            continue;
        }
        targets = getentarray(exterior_goals[i].target, "targetname");
        for (j = 0; j < targets.size; j++) {
            targets[j] zm_utility::self_delete();
        }
    }
    if (isdefined(level.level_createfx_callback_thread)) {
        level thread [[ level.level_createfx_callback_thread ]]();
    }
}

// Namespace zm/zm
// Params 0, eflags: 0x1 linked
// Checksum 0xf3cfa1ed, Offset: 0x2c80
// Size: 0x164
function post_all_players_connected() {
    level thread end_game();
    level flag::wait_till("start_zombie_round_logic");
    level.var_aaf21bbb = level.players.size;
    level.var_5caadd40 = function_58385b58(#"allies").size;
    println("<dev string:xb3>", level.script, "<dev string:xc9>", getplayers().size);
    level thread round_end_monitor();
    if (!level.zombie_anim_intro) {
        if (isdefined(level._round_start_func)) {
            level thread [[ level._round_start_func ]]();
        }
    }
    level thread players_playing();
    level.startinvulnerabletime = getdvarint(#"player_deathinvulnerabletime", 0);
    level thread zm_stats::function_b14863c1();
}

// Namespace zm/zm
// Params 0, eflags: 0x0
// Checksum 0x47b90af4, Offset: 0x2df0
// Size: 0x1c
function start_zm_dash_counter_watchers() {
    level thread first_consumables_used_watcher();
}

// Namespace zm/zm
// Params 0, eflags: 0x1 linked
// Checksum 0x9e3d81bf, Offset: 0x2e18
// Size: 0x24
function first_consumables_used_watcher() {
    level flag::init("first_consumables_used");
}

// Namespace zm/zm
// Params 0, eflags: 0x1 linked
// Checksum 0x2898c63b, Offset: 0x2e48
// Size: 0x52
function init_custom_ai_type() {
    if (isdefined(level.custom_ai_type)) {
        for (i = 0; i < level.custom_ai_type.size; i++) {
            [[ level.custom_ai_type[i] ]]();
        }
    }
}

// Namespace zm/zm
// Params 0, eflags: 0x0
// Checksum 0x9e6c180f, Offset: 0x2ea8
// Size: 0x74
function zombiemode_melee_miss() {
    if (isdefined(self.enemy.var_e764ac36)) {
        self.enemy dodamage(getdvarint(#"ai_meleedamage", 0), self.origin, self, self, "none", "melee");
    }
}

// Namespace zm/zm
// Params 0, eflags: 0x1 linked
// Checksum 0x947ca2e5, Offset: 0x2f28
// Size: 0x14
function init_shellshocks() {
    level.player_killed_shellshock = "zombie_death";
}

// Namespace zm/zm
// Params 0, eflags: 0x1 linked
// Checksum 0x76051bac, Offset: 0x2f48
// Size: 0x144
function init_strings() {
    zm_utility::add_zombie_hint("undefined", #"zombie/undefined");
    zm_utility::add_zombie_hint("default_treasure_chest", #"hash_40a3bd4c33eac8cc");
    zm_utility::add_zombie_hint("default_buy_barrier_piece_10", #"hash_1c189b8ad7ec73a1");
    zm_utility::add_zombie_hint("default_buy_barrier_piece_20", #"hash_1c1c218ad7ef8d2a");
    zm_utility::add_zombie_hint("default_buy_barrier_piece_50", #"hash_1c26138ad7f7c9e5");
    zm_utility::add_zombie_hint("default_buy_barrier_piece_100", #"hash_2a43ddece6c85f63");
    zm_utility::add_zombie_hint("default_reward_barrier_piece", #"hash_6a8e67597b680da2");
    zm_utility::add_zombie_hint("default_buy_area", #"hash_cc45440fbd070dc");
}

// Namespace zm/zm
// Params 0, eflags: 0x1 linked
// Checksum 0xc44bc308, Offset: 0x3098
// Size: 0x3e4
function init_sounds() {
    zm_utility::add_sound("end_of_round", "mus_zmb_round_over");
    zm_utility::add_sound("end_of_game", "mus_zmb_game_over");
    zm_utility::add_sound("chalk_one_up", "mus_zmb_chalk");
    zm_utility::add_sound("purchase", "zmb_cha_ching");
    zm_utility::add_sound("no_purchase", "zmb_no_cha_ching");
    zm_utility::add_sound("playerzombie_usebutton_sound", "zmb_zombie_vocals_attack");
    zm_utility::add_sound("playerzombie_attackbutton_sound", "zmb_zombie_vocals_attack");
    zm_utility::add_sound("playerzombie_adsbutton_sound", "zmb_zombie_vocals_attack");
    zm_utility::add_sound("zombie_head_gib", "zmb_zombie_head_gib");
    zm_utility::add_sound("rebuild_barrier_piece", "zmb_repair_boards");
    zm_utility::add_sound("rebuild_barrier_metal_piece", "zmb_metal_repair");
    zm_utility::add_sound("rebuild_barrier_hover", "zmb_boards_float");
    zm_utility::add_sound("debris_hover_loop", "zmb_couch_loop");
    zm_utility::add_sound("break_barrier_piece", "zmb_break_boards");
    zm_utility::add_sound("grab_metal_bar", "zmb_bar_pull");
    zm_utility::add_sound("break_metal_bar", "zmb_bar_break");
    zm_utility::add_sound("drop_metal_bar", "zmb_bar_drop");
    zm_utility::add_sound("blocker_end_move", "zmb_board_slam");
    zm_utility::add_sound("barrier_rebuild_slam", "zmb_board_slam");
    zm_utility::add_sound("bar_rebuild_slam", "zmb_bar_repair");
    zm_utility::add_sound("zmb_rock_fix", "zmb_break_rock_barrier_fix");
    zm_utility::add_sound("zmb_vent_fix", "evt_vent_slat_repair");
    zm_utility::add_sound("zmb_barrier_debris_move", "zmb_barrier_debris_move");
    zm_utility::add_sound("door_slide_open", "zmb_door_slide_open");
    zm_utility::add_sound("door_rotate_open", "zmb_door_slide_open");
    zm_utility::add_sound("debris_move", "zmb_weap_wall");
    zm_utility::add_sound("open_chest", "zmb_lid_open");
    zm_utility::add_sound("music_chest", "zmb_music_box");
    zm_utility::add_sound("close_chest", "zmb_lid_close");
    zm_utility::add_sound("weapon_show", "zmb_weap_wall");
    zm_utility::add_sound("break_stone", "evt_break_stone");
}

// Namespace zm/zm
// Params 0, eflags: 0x1 linked
// Checksum 0xb383d187, Offset: 0x3488
// Size: 0x984
function init_levelvars() {
    level.is_zombie_level = 1;
    level.default_laststandpistol = getweapon(#"pistol_semiauto_t9");
    level.default_solo_laststandpistol = getweapon(#"pistol_semiauto_t9");
    level.super_ee_weapon = getweapon(#"pistol_burst_t9");
    level.laststandpistol = level.default_laststandpistol;
    level.start_weapon = level.default_laststandpistol;
    level.first_round = 1;
    level.start_round = getgametypesetting(#"startround");
    level.round_number = level.start_round;
    level.enable_magic = getgametypesetting(#"magic");
    level.headshots_only = getgametypesetting(#"zmheadshotsonly");
    level.player_starting_points = function_b10f6843();
    level.round_start_time = 0;
    level.pro_tips_start_time = 0;
    level.intermission = 0;
    level.dog_intermission = 0;
    level.zombie_total = 0;
    level.zombie_respawns = 0;
    level.var_9427911d = 0;
    level.total_zombies_killed = 0;
    level.zm_loc_types = [];
    level.zm_loc_types[#"zombie_location"] = [];
    level.var_9b91564e = 8;
    level.zm_variant_type_max = [];
    level.zm_variant_type_max[#"walk"] = [];
    level.zm_variant_type_max[#"run"] = [];
    level.zm_variant_type_max[#"sprint"] = [];
    level.zm_variant_type_max[#"super_sprint"] = [];
    level.zm_variant_type_max[#"walk"][#"down"] = 14;
    level.zm_variant_type_max[#"walk"][#"up"] = 16;
    level.zm_variant_type_max[#"run"][#"down"] = 13;
    level.zm_variant_type_max[#"run"][#"up"] = 12;
    level.zm_variant_type_max[#"sprint"][#"down"] = 9;
    level.zm_variant_type_max[#"sprint"][#"up"] = 8;
    level.zm_variant_type_max[#"super_sprint"][#"down"] = 1;
    level.zm_variant_type_max[#"super_sprint"][#"up"] = 1;
    level.zm_variant_type_max[#"burned"][#"down"] = 1;
    level.zm_variant_type_max[#"burned"][#"up"] = 1;
    level.zm_variant_type_max[#"jump_pad_super_sprint"][#"down"] = 1;
    level.zm_variant_type_max[#"jump_pad_super_sprint"][#"up"] = 1;
    level.var_d9ffddf4 = [];
    level.var_d9ffddf4[#"walk"] = 4;
    level.var_d9ffddf4[#"run"] = 4;
    level.var_d9ffddf4[#"sprint"] = 4;
    level.var_d9ffddf4[#"super_sprint"] = 4;
    level.var_d9ffddf4[#"crawl"] = 3;
    level.current_zombie_array = [];
    level.current_zombie_count = 0;
    level.zombie_total_subtract = 0;
    level.destructible_callbacks = [];
    foreach (team, _ in level.teams) {
        if (!isdefined(level.zombie_vars[team])) {
            level.zombie_vars[team] = [];
        }
    }
    if (!isdefined(level.var_aed5d327)) {
        level.var_aed5d327 = [];
    }
    level.gamedifficulty = getgametypesetting(#"zmdifficulty");
    level.var_ab367500 = 1.5;
    zmsettings = zm_utility::function_10e38d86();
    zombie_utility::set_zombie_var(#"below_world_check", zmsettings.var_c9ca5291, 0);
    zombie_utility::set_zombie_var(#"spectators_respawn", zmsettings.var_629f7daa, 0);
    zombie_utility::set_zombie_var(#"zombie_use_failsafe", zmsettings.var_388eb2fd, 0);
    zombie_utility::set_zombie_var(#"zombie_between_round_time", zmsettings.var_7c95cc24, 0);
    zombie_utility::set_zombie_var(#"zombie_intermission_time", zmsettings.var_54e1d605, 0);
    zombie_utility::set_zombie_var(#"hash_6bae95928bbe8f1", zmsettings.var_db686493, 0);
    zombie_utility::set_zombie_var(#"zombie_score_kill", zmsettings.var_e1b7f6c8, 0);
    zombie_utility::set_zombie_var(#"zombie_score_bonus_melee", zmsettings.var_23244f59, 0);
    zombie_utility::set_zombie_var(#"zombie_score_bonus_head", zmsettings.var_4a0240f3, 0);
    zombie_utility::set_zombie_var(#"hash_68aa9b4c8de33261", zmsettings.var_86036d4, 0);
    zombie_utility::set_zombie_var(#"zombify_player", zmsettings.var_d996cae, 0);
    zombie_utility::set_zombie_var(#"hash_6ba259e60f87bb15", zmsettings.var_b39946c5, []);
    if (issplitscreen()) {
        zombie_utility::set_zombie_var(#"zombie_timer_offset", zmsettings.var_37d2cb01, 0);
    }
    function_1442d44f();
    level thread init_player_levelvars();
    level.speed_change_max = 0;
    level.speed_change_num = 0;
    zm_round_logic::set_round_number(level.round_number);
    zm_score::function_e5d6e6dd(#"zombie", zombie_utility::function_d2dfacfd(#"zombie_score_kill"));
}

// Namespace zm/zm
// Params 0, eflags: 0x5 linked
// Checksum 0x23c84019, Offset: 0x3e18
// Size: 0x66
function private function_b10f6843() {
    n_starting = (level.round_number - zm_custom::function_901b751c(#"startround") + 1) * 500;
    return isdefined(level.player_starting_points) ? level.player_starting_points : n_starting;
}

// Namespace zm/zm
// Params 0, eflags: 0x1 linked
// Checksum 0x27d74731, Offset: 0x3e88
// Size: 0x7ec
function function_1442d44f() {
    zmsettings = zm_utility::function_10e38d86();
    zombie_utility::set_zombie_var(#"zombie_health_start", zmsettings.difficultysettings[level.gamedifficulty].var_d2a37ad0, 0);
    zombie_utility::set_zombie_var(#"zombie_health_increase", zmsettings.difficultysettings[level.gamedifficulty].var_2defce07, 0);
    zombie_utility::set_zombie_var(#"zombie_health_increase_multiplier", zmsettings.difficultysettings[level.gamedifficulty].var_68f07704, 0);
    zombie_utility::set_zombie_var(#"hash_7d5a25e2463f7fc5", zmsettings.difficultysettings[level.gamedifficulty].var_75236df1, 0);
    zombie_utility::set_zombie_var(#"zombie_new_runner_interval", zmsettings.difficultysettings[level.gamedifficulty].var_8cb6013d, 0);
    zombie_utility::set_zombie_var(#"zombie_max_ai", zmsettings.difficultysettings[level.gamedifficulty].var_e134c623, 0);
    zombie_utility::set_zombie_var(#"zombie_ai_per_player", zmsettings.difficultysettings[level.gamedifficulty].var_8c9f998a);
    zombie_utility::set_zombie_var(#"zombie_move_speed_multiplier", zmsettings.difficultysettings[level.gamedifficulty].var_ecafcfe9);
    zombie_utility::set_zombie_var(#"hash_607bc50072c2a386", zmsettings.difficultysettings[level.gamedifficulty].var_9e2df5e5, 0);
    zombie_utility::set_zombie_var(#"hash_67b3cbf79292e047", zmsettings.difficultysettings[level.gamedifficulty].var_24d886f5, 0);
    zombie_utility::set_zombie_var(#"player_base_health", zmsettings.difficultysettings[level.gamedifficulty].var_edc0d364, 0);
    zombie_utility::set_zombie_var(#"player_health_regen_rate", zmsettings.difficultysettings[level.gamedifficulty].var_d3001509, 0);
    zombie_utility::set_zombie_var(#"player_health_regen_delay", zmsettings.difficultysettings[level.gamedifficulty].var_73b26261, 0);
    zombie_utility::set_zombie_var(#"penalty_no_revive", zmsettings.difficultysettings[level.gamedifficulty].var_6e13b2b7, 0);
    zombie_utility::set_zombie_var(#"penalty_died", zmsettings.difficultysettings[level.gamedifficulty].var_a93b7e4f, 0);
    zombie_utility::set_zombie_var(#"penalty_downed", zmsettings.difficultysettings[level.gamedifficulty].var_415b24aa, 0);
    zombie_utility::set_zombie_var(#"hash_3037a1f286b662e6", zmsettings.difficultysettings[level.gamedifficulty].var_b84141ad, 0);
    zombie_utility::set_zombie_var(#"hash_3098c53bba6402d3", zmsettings.difficultysettings[level.gamedifficulty].var_6de8fcc4, 0);
    zombie_utility::set_zombie_var(#"hash_67ae1b8cbb7c985", zmsettings.difficultysettings[level.gamedifficulty].var_e8996012, 0);
    zombie_utility::set_zombie_var(#"hash_cc85b961f25c2ff", zmsettings.difficultysettings[level.gamedifficulty].var_4a94ab75, 0);
    zombie_utility::set_zombie_var(#"retain_weapons", zmsettings.difficultysettings[level.gamedifficulty].var_3c177b07, 0);
    zombie_utility::set_zombie_var(#"perks_decay", zmsettings.difficultysettings[level.gamedifficulty].var_792e5fa0, 0);
    zombie_utility::set_zombie_var(#"hash_1ab42b4d7db4cb3c", zmsettings.difficultysettings[level.gamedifficulty].var_539d49a1, 0);
    zombie_utility::set_zombie_var(#"highlight_craftables", zmsettings.difficultysettings[level.gamedifficulty].var_93820904, 0);
    zombie_utility::set_zombie_var(#"zombie_point_scalar", zmsettings.difficultysettings[level.gamedifficulty].var_5a60ae8, 0, 1);
    zombie_utility::set_zombie_var(#"hash_3a4a041c1d674898", zmsettings.difficultysettings[level.gamedifficulty].var_dd67fc96, 0);
    zombie_utility::set_zombie_var(#"hash_762b7db4166c70aa", zmsettings.difficultysettings[level.gamedifficulty].var_f40fa2be, 0);
    zombie_utility::set_zombie_var(#"hash_6eb9b2d60babd5aa", zmsettings.difficultysettings[level.gamedifficulty].var_e97877db, 0);
    zombie_utility::set_zombie_var(#"hash_376905ad360fc2e8", zmsettings.difficultysettings[level.gamedifficulty].var_5e295f7d, 0);
    zombie_utility::set_zombie_var(#"hash_3b4ad7449c039d1b", zmsettings.difficultysettings[level.gamedifficulty].var_38e75b4c, 0);
    zombie_utility::set_zombie_var(#"hash_2374f3ef775ac2c3", zmsettings.difficultysettings[level.gamedifficulty].var_bc2d6211, 0);
    level flag::set(#"zombie_vars_init");
}

// Namespace zm/zm
// Params 0, eflags: 0x1 linked
// Checksum 0x431474a, Offset: 0x4680
// Size: 0xd6
function init_player_levelvars() {
    level flag::wait_till("start_zombie_round_logic");
    difficulty = 1;
    column = int(difficulty) + 1;
    for (i = 0; i < 8; i++) {
        points = 500;
        if (i > 3) {
            points = 3000;
        }
        points = zombie_utility::set_zombie_var("zombie_score_start_" + i + 1 + "p", points);
    }
}

// Namespace zm/zm
// Params 0, eflags: 0x1 linked
// Checksum 0xa08ca47a, Offset: 0x4760
// Size: 0x7c
function init_dvars() {
    setdvar(#"magic_chest_movable", 1);
    setdvar(#"revive_trigger_radius", 100);
    setdvar(#"cg_healthperbar", 50);
}

// Namespace zm/zm
// Params 0, eflags: 0x1 linked
// Checksum 0x35f8d6ce, Offset: 0x47e8
// Size: 0x19c
function init_function_overrides() {
    level.callbackplayerdamage = &zm_player::callback_playerdamage;
    level.overrideplayerdamage = &zm_player::player_damage_override;
    level.callbackplayerkilled = &zm_player::player_killed_override;
    level.callbackplayerlaststand = &zm_player::callback_playerlaststand;
    level.prevent_player_damage = &zm_player::player_prevent_damage;
    level.callbackactorkilled = &actor_killed_override;
    level.callbackactordamage = &actor_damage_override_wrapper;
    level.var_6788bf11 = &globallogic_scriptmover::function_8c7ec52f;
    level.callbackvehicledamage = &vehicle_damage_override;
    level.callbackvehiclekilled = &globallogic_vehicle::callback_vehiclekilled;
    level.callbackvehicleradiusdamage = &globallogic_vehicle::callback_vehicleradiusdamage;
    level.custom_introscreen = &zombie_intro_screen;
    level.custom_intermission = &zm_player::player_intermission;
    level.reset_clientdvars = &zm_player::onplayerconnect_clientdvars;
    level.player_becomes_zombie = &zm_playerzombie::zombify_player;
    level.validate_enemy_path_length = &zm_utility::default_validate_enemy_path_length;
    level.curclass = &zm_loadout::menuclass;
}

// Namespace zm/zm
// Params 0, eflags: 0x1 linked
// Checksum 0xf275c7c5, Offset: 0x4990
// Size: 0x2d0
function init_flags() {
    level flag::init("solo_game");
    level flag::init("start_zombie_round_logic");
    level flag::init("start_encounters_match_logic");
    level flag::init("spawn_point_override");
    level flag::init("crawler_round");
    level flag::init("spawn_zombies", 1);
    level flag::init("special_round");
    level flag::init("dog_round");
    level flag::init("raps_round");
    level flag::init("begin_spawning");
    level flag::init("end_round_wait");
    level flag::init("wait_and_revive");
    level flag::init("initial_blackscreen_passed");
    level flag::init("gameplay_started");
    setmatchflag("disableIngameMenu", 1);
    level flag::init("power_on");
    power_trigs = getentarray("use_elec_switch", "targetname");
    foreach (trig in power_trigs) {
        if (isdefined(trig.script_int)) {
            level flag::init("power_on" + trig.script_int);
        }
    }
}

// Namespace zm/zm
// Params 0, eflags: 0x1 linked
// Checksum 0xbc95f798, Offset: 0x4c68
// Size: 0x3fc
function init_client_field_callback_funcs() {
    clientfield::register("actor", "zombie_riser_fx", 1, 1, "int");
    if (is_true(level.use_water_risers)) {
        clientfield::register("actor", "zombie_riser_fx_water", 1, 1, "int");
    }
    if (is_true(level.use_foliage_risers)) {
        clientfield::register("actor", "zombie_riser_fx_foliage", 1, 1, "int");
    }
    if (is_true(level.use_low_gravity_risers)) {
        clientfield::register("actor", "zombie_riser_fx_lowg", 1, 1, "int");
    }
    clientfield::register("actor", "zombie_ragdoll_explode", 1, 1, "int");
    clientfield::register("actor", "zombie_gut_explosion", 1, 1, "int");
    clientfield::register("actor", "zombie_keyline_render", 1, 1, "int");
    bits = 4;
    trigs = getentarray("use_elec_switch", "targetname");
    if (isdefined(trigs)) {
        bits = getminbitcountfornum(trigs.size + 1);
    }
    clientfield::register("world", "zombie_power_on", 1, bits, "int");
    clientfield::register("world", "zombie_power_off", 1, bits, "int");
    clientfield::register("world", "zesn", 1, 1, "int");
    clientfield::register("world", "round_complete_time", 1, 20, "int");
    clientfield::register("world", "round_complete_num", 1, 8, "int");
    clientfield::register("world", "game_end_time", 1, 20, "int");
    clientfield::register("world", "quest_complete_time", 1, 20, "int");
    clientfield::register("world", "game_start_time", 1, 20, "int");
    clientfield::register("scriptmover", "rob_zm_prop_fade", 1, 1, "int");
    clientfield::register_clientuimodel("ZMInvTalisman.show", 1, 1, "int");
    clientfield::register_clientuimodel("hudItems.hasBackpack", 1, 1, "int", 0);
}

// Namespace zm/zm
// Params 0, eflags: 0x1 linked
// Checksum 0x257aee9c, Offset: 0x5070
// Size: 0x4b4
function init_fx() {
    level.createfx_callback_thread = &delete_in_createfx;
    level._effect[#"animscript_gib_fx"] = #"zombie/fx_blood_torso_explo_zmb";
    level._effect[#"animscript_gibtrail_fx"] = #"blood/fx_blood_gib_limb_trail";
    level._effect[#"switch_sparks"] = #"hash_26f37488feec03c3";
    level._effect[#"hash_4159f23a18f644a7"] = #"hash_71ed4f412b17e19e";
    level._effect[#"fx_zombie_bar_break"] = #"hash_718a24841c1e00c9";
    level._effect[#"fx_zombie_bar_break_lite"] = #"hash_35ee6425adf16fb6";
    if (!is_true(level.fx_exclude_edge_fog)) {
        level._effect[#"edge_fog"] = #"_t6/maps/zombie/fx_fog_zombie_amb";
    }
    level._effect[#"chest_light"] = #"zombie/fx_weapon_box_open_glow_zmb";
    level._effect[#"chest_light_closed"] = #"zombie/fx_weapon_box_closed_glow_zmb";
    level._effect[#"headshot"] = #"zombie/fx_bul_flesh_head_fatal_zmb";
    level._effect[#"headshot_nochunks"] = #"zombie/fx_bul_flesh_head_nochunks_zmb";
    level._effect[#"bloodspurt"] = #"zombie/fx_bul_flesh_neck_spurt_zmb";
    if (!is_true(level.fx_exclude_tesla_head_light)) {
        level._effect[#"tesla_head_light"] = #"hash_757d002378ec934c";
    }
    level._effect[#"zombie_guts_explosion"] = #"zombie/fx_blood_torso_explo_lg_zmb";
    level._effect[#"rise_burst_water"] = #"zombie/fx_spawn_dirt_hand_burst_zmb";
    level._effect[#"rise_billow_water"] = #"zombie/fx_spawn_dirt_body_billowing_zmb";
    level._effect[#"rise_dust_water"] = #"zombie/fx_spawn_dirt_body_dustfalling_zmb";
    level._effect[#"rise_burst"] = #"zombie/fx_spawn_dirt_hand_burst_zmb";
    level._effect[#"rise_billow"] = #"zombie/fx_spawn_dirt_body_billowing_zmb";
    level._effect[#"rise_dust"] = #"zombie/fx_spawn_dirt_body_dustfalling_zmb";
    level._effect[#"fall_burst"] = #"zombie/fx_spawn_dirt_hand_burst_zmb";
    level._effect[#"fall_billow"] = #"zombie/fx_spawn_dirt_body_billowing_zmb";
    level._effect[#"fall_dust"] = #"zombie/fx_spawn_dirt_body_dustfalling_zmb";
    level._effect[#"character_fire_death_sm"] = #"hash_c9cf0acc938a7f6";
    level._effect[#"character_fire_death_torso"] = #"hash_5686def5b4c85661";
    if (!is_true(level.fx_exclude_default_explosion)) {
        level._effect[#"def_explosion"] = #"_t6/explosions/fx_default_explosion";
    }
    if (!is_true(level.disable_fx_upgrade_aquired)) {
        level._effect[#"upgrade_aquired"] = #"hash_359f0993cf4ebe66";
    }
}

// Namespace zm/zm
// Params 5, eflags: 0x1 linked
// Checksum 0xeb6c9f59, Offset: 0x5530
// Size: 0x4c
function zombie_intro_screen(*string1, *string2, *string3, *string4, *string5) {
    level flag::wait_till("start_zombie_round_logic");
}

// Namespace zm/zm
// Params 0, eflags: 0x1 linked
// Checksum 0x46a623c5, Offset: 0x5588
// Size: 0x60
function players_playing() {
    players = getplayers();
    level.players_playing = players.size;
    wait 20;
    players = getplayers();
    level.players_playing = players.size;
}

// Namespace zm/zm
// Params 0, eflags: 0x1 linked
// Checksum 0xe6a49a6d, Offset: 0x55f0
// Size: 0x8c
function set_intermission_point() {
    points = struct::get_array("intermission", "targetname");
    if (points.size < 1) {
        return;
    }
    points = array::randomize(points);
    point = points[0];
    setdemointermissionpoint(point.origin, point.angles);
}

// Namespace zm/zm
// Params 1, eflags: 0x1 linked
// Checksum 0xe5307990, Offset: 0x5688
// Size: 0x44
function register_vehicle_damage_callback(func) {
    if (!isdefined(level.vehicle_damage_callbacks)) {
        level.vehicle_damage_callbacks = [];
    }
    level.vehicle_damage_callbacks[level.vehicle_damage_callbacks.size] = func;
}

// Namespace zm/zm
// Params 15, eflags: 0x1 linked
// Checksum 0xdef1b4ec, Offset: 0x56d8
// Size: 0x1c4
function vehicle_damage_override(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal) {
    if (isdefined(level.vehicle_damage_callbacks)) {
        for (i = 0; i < level.vehicle_damage_callbacks.size; i++) {
            idamage = self [[ level.vehicle_damage_callbacks[i] ]](einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal);
        }
    }
    if (is_true(self.var_1e7e5205)) {
        idamage *= 2;
    }
    self globallogic_vehicle::callback_vehicledamage(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal);
    if (isdefined(eattacker) && isdefined(self) && idamage > 0 && !is_true(self.var_265cb589) && !is_true(level.var_dc60105c)) {
        eattacker util::show_hit_marker(self.health <= 0);
    }
}

// Namespace zm/zm
// Params 5, eflags: 0x5 linked
// Checksum 0xf48cd9dd, Offset: 0x58a8
// Size: 0x166
function private function_7bdb1f9f(attacker, damage, meansofdeath, weapon, shitloc) {
    if ((is_true(level.headshots_only) || zm_trial_headshots_only::is_active()) && isplayer(attacker)) {
        if (meansofdeath == "MOD_MELEE" && (shitloc == "head" || shitloc == "helmet")) {
            return int(damage);
        }
        if (zm_utility::is_explosive_damage(meansofdeath)) {
            return int(damage);
        }
        if (weapon.isheroweapon) {
            return int(damage);
        }
        if (is_true(self.var_7105092c)) {
            return int(damage);
        }
        if (!self zm_utility::is_headshot(weapon, shitloc, meansofdeath)) {
            return 0;
        }
    }
    return damage;
}

// Namespace zm/zm
// Params 4, eflags: 0x1 linked
// Checksum 0xada1bc97, Offset: 0x5a18
// Size: 0xb0
function function_34d1053d(damage, weapon, vpoint, shitloc) {
    var_dd54fdb1 = namespace_81245006::function_3131f5dd(self, shitloc, 1);
    if (!isdefined(var_dd54fdb1)) {
        var_dd54fdb1 = namespace_81245006::function_73ab4754(self, vpoint, 1);
    }
    if (var_dd54fdb1.var_3765e777 !== 1 || !isdefined(weapon.var_349c3324)) {
        return damage;
    }
    return damage * weapon.var_349c3324;
}

// Namespace zm/zm
// Params 12, eflags: 0x1 linked
// Checksum 0x49da6d8c, Offset: 0x5ad0
// Size: 0xd3a
function actor_damage_override(inflictor, attacker, damage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype) {
    if (!isdefined(self) || !isdefined(attacker)) {
        return damage;
    }
    if (isai(attacker)) {
        if (self.team == attacker.team && meansofdeath == "MOD_MELEE") {
            return 0;
        }
    }
    if (meansofdeath == "MOD_PROJECTILE" || meansofdeath == "MOD_PROJECTILE_SPLASH" || meansofdeath == "MOD_GRENADE" || meansofdeath == "MOD_GRENADE_SPLASH") {
        self.var_e6675d2d = vpoint;
    } else {
        self.var_e6675d2d = undefined;
    }
    if (isdefined(weapon) && isplayer(attacker)) {
        if (weapon.offhandslot === "Tactical grenade" || weapon.offhandslot === "Lethal grenade" || weapon.offhandslot === "Special" || killstreaks::is_killstreak_weapon(weapon)) {
            if (zm_utility::is_survival()) {
                damage = zm_equipment::function_739fbb72(damage);
            } else {
                damage = zm_equipment::function_379f6b5d(damage);
            }
        }
        item = attacker item_inventory::function_230ceec4(weapon);
        if (isdefined(item)) {
            var_fd72ea28 = self namespace_b61a349a::function_b3496fde(inflictor, attacker, damage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype);
            var_98decf84 = zm_weapons::function_d85e6c3a(item.var_a6762160.rarity);
            damage = damage + damage * var_98decf84 + var_fd72ea28;
            if (isdefined(item.var_a8bccf69) && meansofdeath != "MOD_MELEE") {
                var_cb0241cb = zm_weapons::function_896671d5(item.var_a8bccf69);
                damage += damage * var_cb0241cb;
            }
        } else {
            var_fd72ea28 = self namespace_b61a349a::function_b3496fde(inflictor, attacker, damage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype);
            damage += var_fd72ea28;
        }
    }
    if (isdefined(weapon) && isai(self)) {
        if (is_true(weapon.dostun)) {
            self ai::stun();
        }
    }
    element = namespace_42457a0::function_d6863a3(inflictor, attacker, meansofdeath, weapon);
    if (isdefined(element)) {
        damage = namespace_42457a0::function_9fbcd067(element, inflictor, attacker, damage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype);
    }
    if (is_true(level.bgb_in_use)) {
        damage = bgb::actor_damage_override(inflictor, attacker, damage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype);
    }
    if (isdefined(weapon.name) && isdefined(level.var_aed5d327[weapon.name])) {
        damage = self [[ level.var_aed5d327[weapon.name] ]](inflictor, attacker, damage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype);
    }
    damage = zm_perks::actor_damage_override(inflictor, attacker, damage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype);
    damage = self function_34d1053d(damage, weapon, vpoint, shitloc);
    damage = namespace_e38c57c1::actor_damage_override(inflictor, attacker, damage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype);
    damage = self check_actor_damage_callbacks(inflictor, attacker, damage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype);
    self.knuckles_extinguish_flames = weapon.name == #"tazer_knuckles";
    attacker thread zm_audio::sndplayerhitalert(self, meansofdeath, inflictor, weapon, shitloc, damage);
    if (!isplayer(attacker) && isdefined(self.non_attacker_func)) {
        if (is_true(self.non_attack_func_takes_attacker)) {
            return self [[ self.non_attacker_func ]](damage, weapon, attacker);
        } else {
            return self [[ self.non_attacker_func ]](damage, weapon);
        }
    }
    if (!isbot(attacker)) {
        level notify(#"hash_3fdaafe712252cf5");
    }
    if (is_true(self.var_1e7e5205)) {
        damage *= 2;
    }
    if (is_true(level.zm_bots_scale) && isbot(attacker)) {
        damage = int(damage * zm_bot::function_e16b5033(self));
    }
    if (!isdefined(damage) || !isdefined(meansofdeath)) {
        return damage;
    }
    if (meansofdeath == "") {
        return damage;
    }
    self.var_2e581a5 = undefined;
    if (self.var_6f84b820 === #"special" || self.var_6f84b820 === #"elite") {
        var_84ed9a13 = self zm_ai_utility::function_de3dda83(boneindex, shitloc, vpoint);
        if (isdefined(var_84ed9a13) && namespace_81245006::function_f29756fe(var_84ed9a13) == 1 && var_84ed9a13.type !== #"armor") {
            self.var_2e581a5 = 1;
        }
    }
    if (isdefined(self.aioverridedamage)) {
        for (index = 0; index < self.aioverridedamage.size; index++) {
            damagecallback = self.aioverridedamage[index];
            damage = self [[ damagecallback ]](inflictor, attacker, damage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, undefined);
        }
        if (damage < 1) {
            return 0;
        }
        damage = int(damage + 0.5);
    }
    old_damage = damage;
    final_damage = damage;
    if (isdefined(self.actor_damage_func)) {
        final_damage = [[ self.actor_damage_func ]](inflictor, attacker, damage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex);
    }
    /#
        if (getdvarint(#"scr_perkdebug", 0)) {
            println("<dev string:xf3>" + final_damage / old_damage + "<dev string:x10d>" + old_damage + "<dev string:x120>" + final_damage);
        }
    #/
    if (is_true(self.in_water)) {
        if (int(final_damage) >= self.health) {
            self.water_damage = 1;
        }
    }
    if (isdefined(inflictor) && isdefined(inflictor.archetype) && inflictor.archetype == #"glaive") {
        if (meansofdeath == "MOD_CRUSH") {
            if (isdefined(inflictor.enemy) && inflictor.enemy != self || is_true(inflictor._glaive_must_return_to_owner)) {
                if (isdefined(self.archetype) && self.archetype != #"margwa") {
                    final_damage += self.health;
                    if (isactor(self)) {
                        self zombie_utility::gib_random_parts();
                    }
                }
            } else {
                return 0;
            }
        }
    }
    if (isdefined(inflictor) && isplayer(attacker) && attacker == inflictor) {
        if (meansofdeath == "MOD_HEAD_SHOT" || meansofdeath == "MOD_PISTOL_BULLET" || meansofdeath == "MOD_RIFLE_BULLET") {
            if (!isdefined(attacker.hits)) {
                attacker.hits = 0;
            }
            attacker.hits++;
        }
    }
    if (isplayer(attacker)) {
        if (isalive(attacker) && (meansofdeath === "MOD_GRENADE" || meansofdeath === "MOD_GRENADE_SPLASH")) {
            attacker.grenade_multiattack_count++;
            attacker.grenade_multiattack_ent = self;
        }
        final_damage = self zm_powerups::function_fe6d6eac(attacker, meansofdeath, shitloc, weapon, final_damage);
        self.has_been_damaged_by_player = 1;
    }
    final_damage = self function_7bdb1f9f(attacker, final_damage, meansofdeath, weapon, shitloc);
    if (isdefined(attacker) && final_damage > 0 && !is_true(self.var_265cb589) && !is_true(level.var_dc60105c)) {
        var_6b5f7089 = 0;
        if ((weapon.name === #"lmg_heavy_t8_upgraded" || weapon.name === #"ar_mg1909_t8_upgraded") && meansofdeath == "MOD_PROJECTILE_SPLASH") {
            var_6b5f7089 = 1;
        }
        if (isplayer(attacker) && attacker issplitscreen()) {
            players = getplayers();
            if (players.size == 4) {
                var_6b5f7089 = 1;
            }
        }
        if (!var_6b5f7089) {
            attacker util::show_hit_marker(final_damage >= self.health);
        }
    }
    if (isdefined(level.var_8d314fbb)) {
        final_damage = [[ level.var_8d314fbb ]](inflictor, attacker, damage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype);
    }
    return int(final_damage);
}

// Namespace zm/zm
// Params 12, eflags: 0x1 linked
// Checksum 0xe6e25918, Offset: 0x6818
// Size: 0xf8
function check_actor_damage_callbacks(inflictor, attacker, damage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype) {
    if (!isdefined(level.actor_damage_callbacks)) {
        return damage;
    }
    for (i = 0; i < level.actor_damage_callbacks.size; i++) {
        newdamage = self [[ level.actor_damage_callbacks[i] ]](inflictor, attacker, damage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype);
        if (-1 !== newdamage) {
            return newdamage;
        }
    }
    return damage;
}

// Namespace zm/zm
// Params 2, eflags: 0x1 linked
// Checksum 0xc47d7268, Offset: 0x6918
// Size: 0x40
function function_84d343d(str_weapon, func) {
    if (!isdefined(level.var_aed5d327)) {
        level.var_aed5d327 = [];
    }
    level.var_aed5d327[str_weapon] = func;
}

// Namespace zm/zm
// Params 2, eflags: 0x1 linked
// Checksum 0xa6058b71, Offset: 0x6960
// Size: 0x84
function register_actor_damage_callback(func, var_61bac8c = 0) {
    if (!isdefined(level.actor_damage_callbacks)) {
        level.actor_damage_callbacks = [];
    }
    if (var_61bac8c) {
        array::push_front(level.actor_damage_callbacks, func);
        return;
    }
    level.actor_damage_callbacks[level.actor_damage_callbacks.size] = func;
}

// Namespace zm/zm
// Params 0, eflags: 0x0
// Checksum 0x6d602e1d, Offset: 0x69f0
// Size: 0xa4
function function_79a42ab9() {
    if (!isdefined(level.var_d0851e53)) {
        level.var_d0851e53 = 0;
    }
    if (!isdefined(level.var_7c1032cf)) {
        level.var_7c1032cf = 0;
    }
    while (isdefined(self)) {
        if (level.var_d0851e53 == gettime()) {
            level.var_7c1032cf++;
            if (level.var_7c1032cf < 4) {
                return;
            }
        } else {
            level.var_d0851e53 = gettime();
            level.var_7c1032cf = 0;
            return;
        }
        waitframe(1);
    }
}

// Namespace zm/zm
// Params 15, eflags: 0x1 linked
// Checksum 0xc8769419, Offset: 0x6aa0
// Size: 0x614
function actor_damage_override_wrapper(inflictor, attacker, damage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, boneindex, modelindex, surfacetype, vsurfacenormal) {
    if (!isdefined(self)) {
        return damage;
    }
    if (level.var_9427911d <= 0 && level flag::get(#"infinite_round_spawning") && !is_true(level.var_382a24b0)) {
        self.var_12745932 = 1;
    }
    if (isdefined(attacker) && attacker zm_utility::function_45492cc4()) {
        attacker = attacker.owner;
    }
    if (isdefined(self.var_ccefa6dd) && isdefined(attacker) && attacker.team === self.team) {
        return 0;
    }
    damage_override = self actor_damage_override(inflictor, attacker, damage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype);
    willbekilled = self.health - damage_override <= 0;
    if (isdefined(level.zombie_damage_override_callbacks)) {
        foreach (func_override in level.zombie_damage_override_callbacks) {
            self thread [[ func_override ]](willbekilled, inflictor, attacker, damage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype);
        }
    }
    scoreevents::function_82234b38(self, attacker, weapon, meansofdeath);
    bb::logdamage(attacker, self, weapon, damage_override, meansofdeath, shitloc, willbekilled, willbekilled);
    if (!willbekilled || !is_true(self.dont_die_on_me)) {
        params = spawnstruct();
        params.einflictor = inflictor;
        params.eattacker = attacker;
        params.idamage = damage_override;
        params.idflags = flags;
        params.smeansofdeath = meansofdeath;
        params.weapon = weapon;
        params.vpoint = vpoint;
        params.vdir = vdir;
        params.shitloc = shitloc;
        params.vdamageorigin = vdamageorigin;
        params.psoffsettime = psoffsettime;
        params.boneindex = boneindex;
        params.modelindex = modelindex;
        params.surfacetype = surfacetype;
        params.vsurfacenormal = vsurfacenormal;
        if (params.idamage > 0 || namespace_ae2d0839::is_active()) {
            self callback::callback(#"on_ai_damage", params);
            self callback::callback(#"on_actor_damage", params);
        }
        if (self zm_utility::is_headshot(weapon, shitloc, meansofdeath) && !is_true(self.var_58c4c69b)) {
            level.var_d7e2833c = 1;
            var_ebcff177 = 2;
        } else {
            var_ebcff177 = 1;
        }
        if (!zm_utility::is_survival()) {
            hud::function_c9800094(attacker, self getentitynumber(), damage_override, var_ebcff177);
        }
        if (is_true(level.var_d7e2833c)) {
            level.var_d7e2833c = undefined;
            flags |= 131072;
        }
        if (is_true(level.var_d921ba10)) {
            level.var_d921ba10 = undefined;
            flags |= 262144;
        }
        self finishactordamage(inflictor, attacker, damage_override, flags, meansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, boneindex, surfacetype, vsurfacenormal);
    }
    if ((shitloc === "head" || shitloc === "helmet") && !zm_ai_utility::hashelmet(shitloc, self) && self.archetype !== #"zombie_dog" && meansofdeath != "MOD_MELEE") {
        level scoreevents::doscoreeventcallback("scoreEventZM", {#attacker:attacker, #scoreevent:"hit_weak_point_zm", #enemy:self, #hitloc:shitloc});
    }
}

// Namespace zm/zm
// Params 1, eflags: 0x1 linked
// Checksum 0x2610dd88, Offset: 0x70c0
// Size: 0xa8
function register_zombie_damage_override_callback(func) {
    if (!isdefined(level.zombie_damage_override_callbacks)) {
        level.zombie_damage_override_callbacks = [];
    }
    if (!isdefined(level.zombie_damage_override_callbacks)) {
        level.zombie_damage_override_callbacks = [];
    } else if (!isarray(level.zombie_damage_override_callbacks)) {
        level.zombie_damage_override_callbacks = array(level.zombie_damage_override_callbacks);
    }
    level.zombie_damage_override_callbacks[level.zombie_damage_override_callbacks.size] = func;
}

// Namespace zm/zm
// Params 8, eflags: 0x1 linked
// Checksum 0xbb19bb0b, Offset: 0x7170
// Size: 0x7f4
function actor_killed_override(einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime) {
    if (game.state == "postgame") {
        return;
    }
    if (self.var_c39323b5 !== 1) {
        level.var_9427911d--;
        if (level.var_9427911d <= 0 && level flag::get(#"infinite_round_spawning") && !is_true(level.var_382a24b0)) {
            self.var_12745932 = 1;
        }
    }
    player = undefined;
    eattacker = attacker;
    if (!isdefined(level.n_total_kills)) {
        level.n_total_kills = 0;
    }
    if (isdefined(eattacker)) {
        if (isplayer(eattacker)) {
            player = eattacker;
        } else if (isdefined(eattacker.owner) && isplayer(eattacker) && eattacker.classname == "script_vehicle") {
            player = eattacker.owner;
        }
    }
    if (isdefined(player) && isplayer(player)) {
        killcam_entity_info = killcam::get_killcam_entity_info(player, einflictor, weapon);
        deathtime = gettime();
        deathtimeoffset = 0;
        perks = [];
        killstreaks = [];
        rounds = level.round_number;
        bookmarkname = #"";
        if (isdefined(self.archetype) && (self.archetype == #"tiger" || self.archetype == #"brutus" || self.archetype == #"zombie_dog" || self.archetype == #"catalyst" || self.archetype == #"stoker" || self.archetype == #"blight_father")) {
            bookmarkname = #"hash_1553fcea4f6a00e";
        } else {
            bookmarkname = #"hash_37300d83d8e6f1fc";
        }
        if (bookmarkname == #"hash_1553fcea4f6a00e") {
            demo::bookmark(bookmarkname, gettime(), player);
        }
        potm::bookmark(bookmarkname, gettime(), player);
        level thread potm::function_5523a49a(bookmarkname, player getentitynumber(), player getxuid(), self, killcam_entity_info, weapon, smeansofdeath, deathtime, deathtimeoffset, psoffsettime, perks, killstreaks, player);
    }
    if (isai(attacker) && isdefined(attacker.script_owner)) {
        if (attacker.script_owner.team != self.team) {
            attacker = attacker.script_owner;
        }
    }
    if (isdefined(attacker) && attacker zm_utility::function_45492cc4(0)) {
        attacker = attacker.owner;
    }
    if (isdefined(attacker) && isplayer(attacker)) {
        level.n_total_kills++;
        type = undefined;
        if (isdefined(self.animname)) {
            switch (self.animname) {
            case #"quad_zombie":
                type = "quadkill";
                break;
            case #"ape_zombie":
                type = "apekill";
                break;
            case #"zombie":
                type = "zombiekill";
                break;
            case #"zombie_dog":
                type = "dogkill";
                break;
            }
        }
    }
    if (is_true(self.is_ziplining)) {
        self.deathanim = undefined;
    }
    params = spawnstruct();
    params.einflictor = einflictor;
    params.eattacker = attacker;
    params.idamage = idamage;
    params.smeansofdeath = smeansofdeath;
    params.weapon = weapon;
    params.vdir = vdir;
    params.shitloc = shitloc;
    params.psoffsettime = psoffsettime;
    self callback::callback(#"on_ai_killed", params);
    self callback::callback(#"on_actor_killed", params);
    self zm_stats::handle_death(einflictor, attacker, weapon, smeansofdeath);
    if (isdefined(self.actor_killed_override)) {
        self [[ self.actor_killed_override ]](einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime);
    }
    if (isdefined(self.deathfunction)) {
        self [[ self.deathfunction ]](einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime);
    }
    var_82700ea5 = zm_custom::function_901b751c(#"zmkillcap");
    if (var_82700ea5 > 0 && level.n_total_kills >= var_82700ea5) {
        zm_custom::function_9be9c072("zmKillCap");
    }
    scoreevents::function_82234b38(self, attacker, weapon);
    params.enemy = self;
    if ((shitloc === "head" || shitloc === "helmet") && !zm_ai_utility::hashelmet(shitloc, self) && self.archetype !== #"zombie_dog") {
        params.var_3fb48d9c = 1;
    }
    if (!isplayer(params.eattacker) || params.enemy.var_c3083789 === 0) {
        return;
    }
    level scoreevents::doscoreeventcallback("killingBlow", params);
}

// Namespace zm/zm
// Params 0, eflags: 0x1 linked
// Checksum 0xe5e63b5e, Offset: 0x7970
// Size: 0x6e
function round_end_monitor() {
    while (true) {
        level waittill(#"end_of_round");
        demo::bookmark(#"zm_round_end", gettime(), undefined, undefined, 1);
        bbpostdemostreamstatsforround(level.round_number);
        waitframe(1);
    }
}

// Namespace zm/zm
// Params 0, eflags: 0x1 linked
// Checksum 0x81dd1704, Offset: 0x79e8
// Size: 0xbc
function function_51133aa1() {
    level endon(#"resume_end_game");
    while (true) {
        waitresult = self waittill(#"menuresponse");
        response = waitresult.response;
        if (response == "restart_level_zm") {
            level thread zm_gametype::zm_map_restart();
            wait 666;
            continue;
        }
        if (response == "resume_end_game") {
            level notify(#"resume_end_game");
        }
    }
}

// Namespace zm/zm
// Params 0, eflags: 0x1 linked
// Checksum 0x7fafcf1e, Offset: 0x7ab0
// Size: 0x78
function function_d723e40() {
    level endon(#"resume_end_game");
    wait 1;
    luinotifyevent(#"hash_1fc4832b89307895", 0);
    wait zombie_utility::function_d2dfacfd(#"hash_6bae95928bbe8f1");
    level notify(#"resume_end_game");
}

// Namespace zm/zm
// Params 0, eflags: 0x1 linked
// Checksum 0x50715a60, Offset: 0x7b30
// Size: 0xec
function restart_prompt() {
    players = getplayers();
    foreach (player in players) {
        player thread function_51133aa1();
    }
    level thread function_d723e40();
    level waittill(#"resume_end_game");
    luinotifyevent(#"hash_3aa743d9ad6c8e19", 0);
}

// Namespace zm/zm
// Params 0, eflags: 0x5 linked
// Checksum 0x1565a2a6, Offset: 0x7c28
// Size: 0x7e
function private function_70171add() {
    if (randomfloat(1) <= getdvarfloat(#"survey_chance", 0)) {
        return randomintrange(1, getdvarint(#"survey_count", 0) + 1);
    }
    return 0;
}

// Namespace zm/zm
// Params 0, eflags: 0x1 linked
// Checksum 0xd037f9fd, Offset: 0x7cb0
// Size: 0x108
function function_6c369691() {
    a_ai = getaiteamarray("axis");
    foreach (n_index, ai in a_ai) {
        if (isalive(ai)) {
            ai val::set(#"end_game", "ignoreall", 1);
            ai thread zm_cleanup::no_target_override(ai);
            if (n_index % 2) {
                wait 0.05;
            }
        }
    }
}

// Namespace zm/zm
// Params 1, eflags: 0x1 linked
// Checksum 0x66f1b9ee, Offset: 0x7dc0
// Size: 0x134
function function_2a49523d(winner) {
    outcome = {#var_c1e98979:0, #var_68c25772:1, #var_7d5c2c5f:0, #var_277c7d47:1, #var_14f94126:game.strings[#"defeat"], #team:#"axis", #players:[]};
    if (isdefined(winner) && winner == #"allies") {
        outcome.var_14f94126 = game.strings[#"victory"];
        outcome.team = #"allies";
    }
    display_transition::function_e6b4f2f7(outcome);
    display_transition::function_15e28b1a(outcome);
}

// Namespace zm/zm
// Params 0, eflags: 0x1 linked
// Checksum 0x73dc521f, Offset: 0x7f00
// Size: 0x1032
function end_game() {
    waitresult = level waittill(#"end_game");
    changeadvertisedstatus(0);
    check_end_game_intermission_delay();
    println("<dev string:x134>");
    setmatchflag("game_ended", 1);
    game.state = "postgame";
    if (!isdefined(level.var_21e22beb)) {
        level.var_21e22beb = gettime();
    }
    var_7da9f0c = isdefined(level.var_bccd8271) ? level.var_bccd8271 : gettime() - level.var_21e22beb;
    if (!isdefined(level.n_gameplay_start_time)) {
        level.n_gameplay_start_time = gettime();
    }
    level clientfield::set("gameplay_started", 0);
    level clientfield::set("game_end_time", int((gettime() - level.n_gameplay_start_time + 500) / 1000));
    level clientfield::set("zesn", 1);
    if (isdefined(level.var_ea32773)) {
        level [[ level.var_ea32773 ]](waitresult);
    }
    gametype = hash(util::get_game_type());
    if (gametype == #"zsurvival") {
        function_2a49523d();
        gamestate::set_state("shutdown");
        exitlevel(0);
        return;
    }
    if (zm_utility::is_tutorial()) {
        music::setmusicstate("zodt8_death");
    } else {
        level thread zm_audio::sndmusicsystem_playstate("game_over");
    }
    players = getplayers();
    foreach (player in players) {
        player val::set(#"end_game", "ignoreme", 1);
        player enableinvulnerability();
        if (!isdefined(player.score_total)) {
            player.score_total = 0;
        }
        player.score = player.score_total;
        player notify(#"stop_ammo_tracking");
        player clientfield::set("zmbLastStand", 0);
    }
    level thread function_6c369691();
    surveyid = function_70171add();
    for (i = 0; i < players.size; i++) {
        if (sessionmodeisonlinegame()) {
            players[i] stats::function_7a850245(#"demofileid", getdemofileid());
            players[i] stats::function_7a850245(#"matchid", getmatchid());
            if (level.rankedmatch) {
                players[i] stats::function_7a850245(#"surveyid", surveyid);
            }
        }
        if (players[i] laststand::player_is_in_laststand()) {
            players[i] recordplayerdeathzombies();
            players[i] zm_stats::increment_player_stat("deaths");
            players[i] zm_stats::increment_client_stat("deaths");
            players[i] zm_stats::function_8f10788e("boas_deaths");
        }
    }
    stopallrumbles();
    level.intermission = 1;
    zombie_utility::set_zombie_var(#"zombie_powerup_insta_kill_time", 0);
    zombie_utility::set_zombie_var(#"zombie_powerup_fire_sale_time", 0);
    zombie_utility::set_zombie_var(#"zombie_powerup_double_points_time", 0);
    wait 0.1;
    game_over = [];
    survived = [];
    players = getplayers();
    setmatchflag("disableIngameMenu", 1);
    foreach (player in players) {
        player closeingamemenu();
        player closemenu("StartMenu_Main");
    }
    foreach (player in players) {
        player zm_stats::function_9daadcaa(#"lobbypopup", #"summary");
        player zm_stats::function_9daadcaa(#"difficulty", level.gamedifficulty);
        if (level.var_ff482f76 zm_laststand_client::is_open(player)) {
            level.var_ff482f76 zm_laststand_client::close(player);
        }
    }
    if (!isdefined(level._supress_survived_screen)) {
        var_5c965b78 = 0;
        if (is_true(level.var_458eec65)) {
            var_5c965b78 = 1;
        }
        for (i = 0; i < players.size; i++) {
            level.var_7c7c6c35 zm_game_over::open(players[i]);
            level.var_7c7c6c35 zm_game_over::set_rounds(players[i], level.round_number - zm_custom::function_901b751c(#"startround") + var_5c965b78);
        }
    } else if ("ztrials" == util::get_game_type()) {
        zm_trial_util::function_2ee2d021();
    }
    util::preload_frontend();
    players = getplayers();
    if (isdefined(level.var_77805e8)) {
        level [[ level.var_77805e8 ]]();
    }
    for (i = 0; i < players.size; i++) {
        players[i] setclientuivisibilityflag("weapon_hud_visible", 0);
        players[i] setclientminiscoreboardhide(1);
        players[i] notify(#"report_bgb_consumption");
    }
    zm_stats::update_players_stats_at_match_end(players);
    zm_stats::update_global_counters_on_match_end();
    zm_stats::set_match_stat("gameLength", var_7da9f0c);
    foreach (player in getplayers()) {
        player zm_stats::function_9daadcaa("gameLength", var_7da9f0c);
        player zm_stats::function_ae547e45("boas_gameLength", var_7da9f0c);
        player zm_stats::function_ae547e45("boas_numZombieRounds", level.round_number);
        player zm_stats::function_ae547e45("boas_score", player.score);
        if (isdefined(level.var_211e3a53)) {
            player zm_stats::function_ae547e45("boas_gameType", level.var_211e3a53);
            continue;
        }
        player zm_stats::function_ae547e45("boas_gameType", util::get_game_type());
    }
    zm_stats::function_ea5b4947(1);
    bb::logroundevent("end_game");
    upload_leaderboards();
    recordgameresult(#"draw");
    globallogic::function_6c8d7c31(#"draw");
    globallogic_player::recordactiveplayersendgamematchrecordstats();
    recordnumzombierounds(level.round_number);
    finalizematchrecord();
    players = getplayers();
    foreach (player in players) {
        if (isdefined(player.sessionstate) && player.sessionstate == "spectator") {
            player thread end_game_player_was_spectator();
        }
    }
    waitframe(1);
    /#
        if (!is_true(level.host_ended_game) && getdvarint(#"hash_2a088de8afba1c99", 0) > 1) {
            luinotifyevent(#"force_scoreboard", 0);
            map_restart(1);
            wait 666;
        }
    #/
    luinotifyevent(#"force_scoreboard", 1, 1);
    players = getplayers();
    for (i = 0; i < players.size; i++) {
        players[i] val::set(#"end_of_game", "freezecontrols");
    }
    intermission();
    if (getdvar(#"hash_4413f876155a89bd", 0)) {
        restart_prompt();
    }
    if (zm_trial::is_trial_mode()) {
        level thread zm_trial_util::function_f79b96ac();
    }
    if (potm::function_afe21831() == 0) {
        wait zombie_utility::function_d2dfacfd(#"zombie_intermission_time");
    }
    players = getplayers();
    for (i = 0; i < players.size; i++) {
        if (level.var_7c7c6c35 zm_game_over::is_open(players[i])) {
            level.var_7c7c6c35 zm_game_over::close(players[i]);
        }
    }
    level notify(#"stop_intermission");
    array::thread_all(getplayers(), &zm_player::player_exit_level);
    wait 1.5;
    players = getplayers();
    for (i = 0; i < players.size; i++) {
        players[i] cameraactivate(0);
    }
    /#
        if (!is_true(level.host_ended_game) && getdvarint(#"hash_2a088de8afba1c99", 0)) {
            luinotifyevent(#"force_scoreboard", 1, 0);
            map_restart(1);
            wait 666;
        }
    #/
    gamestate::set_state("shutdown");
    exitlevel(0);
    wait 666;
}

// Namespace zm/zm
// Params 0, eflags: 0x1 linked
// Checksum 0xcfd575da, Offset: 0x8f40
// Size: 0x4c
function end_game_player_was_spectator() {
    waitframe(1);
    self ghost();
    self val::set(#"end_game_player_was_spectator", "freezecontrols", 1);
}

// Namespace zm/zm
// Params 1, eflags: 0x0
// Checksum 0xb2ac91fc, Offset: 0x8f98
// Size: 0x2e
function disable_end_game_intermission(delay) {
    level.disable_intermission = 1;
    wait delay;
    level.disable_intermission = undefined;
}

// Namespace zm/zm
// Params 0, eflags: 0x1 linked
// Checksum 0xd73ce494, Offset: 0x8fd0
// Size: 0x3c
function check_end_game_intermission_delay() {
    if (isdefined(level.disable_intermission)) {
        while (true) {
            if (!isdefined(level.disable_intermission)) {
                break;
            }
            wait 0.01;
        }
    }
}

// Namespace zm/zm
// Params 0, eflags: 0x1 linked
// Checksum 0xdaf0faf7, Offset: 0x9018
// Size: 0x54
function upload_leaderboards() {
    players = getplayers();
    for (i = 0; i < players.size; i++) {
        players[i] uploadleaderboards();
    }
}

// Namespace zm/zm
// Params 0, eflags: 0x1 linked
// Checksum 0xc8adc3e7, Offset: 0x9078
// Size: 0x64
function initializestattracking() {
    level.global_zombies_killed = 0;
    level.zombies_timeout_spawn = 0;
    level.zombies_timeout_playspace = 0;
    level.zombies_timeout_undamaged = 0;
    level.zombie_player_killed_count = 0;
    level.zombie_trap_killed_count = 0;
    level.zombie_pathing_failed = 0;
    level.zombie_breadcrumb_failed = 0;
}

// Namespace zm/zm
// Params 1, eflags: 0x0
// Checksum 0xcb1064af, Offset: 0x90e8
// Size: 0x18e
function to_mins(seconds) {
    hours = 0;
    minutes = 0;
    if (seconds > 59) {
        minutes = int(seconds / 60);
        seconds = int(seconds * 1000) % 60000;
        seconds *= 0.001;
        if (minutes > 59) {
            hours = int(minutes / 60);
            minutes = int(minutes * 1000) % 60000;
            minutes *= 0.001;
        }
    }
    if (hours < 10) {
        hours = "0" + hours;
    }
    if (minutes < 10) {
        minutes = "0" + minutes;
    }
    seconds = int(seconds);
    if (seconds < 10) {
        seconds = "0" + seconds;
    }
    combined = "" + hours + ":" + minutes + ":" + seconds;
    return combined;
}

// Namespace zm/zm
// Params 0, eflags: 0x1 linked
// Checksum 0x3680f958, Offset: 0x9280
// Size: 0x14c
function function_dccccaf2() {
    self closeingamemenu();
    self closemenu("StartMenu_Main");
    self notify(#"player_intermission");
    self endon(#"player_intermission");
    level endon(#"stop_intermission");
    self endon(#"disconnect", #"death");
    self notify(#"_zombie_game_over");
    self.score = self.score_total;
    wait 0.51;
    self lui::screen_fade_out(1);
    level waittill(#"play_potm");
    self lui::screen_fade_in(0.1);
    level waittill(#"potm_finished");
    self lui::screen_fade_out(2);
}

// Namespace zm/zm
// Params 0, eflags: 0x1 linked
// Checksum 0xcf188e9f, Offset: 0x93d8
// Size: 0x21c
function intermission() {
    potm_enabled = 0;
    if (potm::function_afe21831() > 0) {
        potm_enabled = 1;
    }
    level.intermission = 1;
    level notify(#"intermission");
    players = getplayers();
    for (i = 0; i < players.size; i++) {
        players[i] setclientthirdperson(0);
        players[i] resetfov();
        players[i].health = players[i].maxhealth;
        if (potm_enabled) {
            players[i] thread function_dccccaf2();
        } else {
            players[i] thread [[ level.custom_intermission ]]();
        }
        players[i] stopsounds();
    }
    if (potm_enabled) {
        wait 5;
        level thread potm::play_potm(2);
        waitframe(1);
        level notify(#"play_potm");
        level waittill(#"potm_finished");
        wait 2.25;
        return;
    }
    wait 5.25;
    players = getplayers();
    for (i = 0; i < players.size; i++) {
        players[i] clientfield::set("zmbLastStand", 0);
    }
    level thread zombie_game_over_death();
}

// Namespace zm/zm
// Params 0, eflags: 0x1 linked
// Checksum 0x3a6e5a44, Offset: 0x9600
// Size: 0x194
function zombie_game_over_death() {
    zombies = getaiteamarray(level.zombie_team);
    for (i = 0; i < zombies.size; i++) {
        if (!isalive(zombies[i])) {
            continue;
        }
        zombies[i] setgoal(zombies[i].origin);
    }
    for (i = 0; i < zombies.size; i++) {
        if (!isalive(zombies[i])) {
            continue;
        }
        if (is_true(zombies[i].ignore_game_over_death)) {
            continue;
        }
        wait 0.5 + randomfloat(2);
        if (isdefined(zombies[i])) {
            if (!isvehicle(zombies[i])) {
                zombies[i] zombie_utility::zombie_head_gib();
            }
            zombies[i].allowdeath = 1;
            zombies[i] kill(zombies[i].origin, undefined, undefined, undefined, 0, 1);
        }
    }
}

/#

    // Namespace zm/zm
    // Params 1, eflags: 0x0
    // Checksum 0x8ef5e236, Offset: 0x97a0
    // Size: 0x32
    function fade_up_over_time(t) {
        self fadeovertime(t);
        self.alpha = 1;
    }

#/

// Namespace zm/zm
// Params 0, eflags: 0x0
// Checksum 0x964c5521, Offset: 0x97e0
// Size: 0xe4
function default_exit_level() {
    zombies = getaiteamarray(level.zombie_team);
    for (i = 0; i < zombies.size; i++) {
        if (is_true(zombies[i].ignore_solo_last_stand)) {
            continue;
        }
        if (isdefined(zombies[i].find_exit_point)) {
            zombies[i] thread [[ zombies[i].find_exit_point ]]();
            continue;
        }
        if (zombies[i].ignoreme) {
            zombies[i] thread default_delayed_exit();
            continue;
        }
        zombies[i] thread default_find_exit_point();
    }
}

// Namespace zm/zm
// Params 0, eflags: 0x1 linked
// Checksum 0xe255a3c2, Offset: 0x98d0
// Size: 0x74
function default_delayed_exit() {
    self endon(#"death");
    while (true) {
        if (!level flag::get("wait_and_revive")) {
            return;
        }
        if (!self.ignoreme) {
            break;
        }
        wait 0.1;
    }
    self thread default_find_exit_point();
}

// Namespace zm/zm
// Params 0, eflags: 0x1 linked
// Checksum 0x7cf83138, Offset: 0x9950
// Size: 0x204
function default_find_exit_point() {
    self endon(#"death");
    player = util::gethostplayer();
    if (!isdefined(player)) {
        return;
    }
    dist_zombie = 0;
    dist_player = 0;
    dest = 0;
    away = vectornormalize(self.origin - player.origin);
    endpos = self.origin + vectorscale(away, 600);
    locs = [];
    if (isdefined(level.zm_loc_types[#"wait_location"]) && level.zm_loc_types[#"wait_location"].size > 0) {
        locs = array::randomize(level.zm_loc_types[#"wait_location"]);
    }
    for (i = 0; i < locs.size; i++) {
        dist_zombie = distancesquared(locs[i].origin, endpos);
        dist_player = distancesquared(locs[i].origin, player.origin);
        if (dist_zombie < dist_player) {
            dest = i;
            break;
        }
    }
    self notify(#"stop_find_flesh");
    self notify(#"zombie_acquire_enemy");
    if (isdefined(locs[dest])) {
        self setgoal(locs[dest].origin);
    }
}

// Namespace zm/zm
// Params 2, eflags: 0x0
// Checksum 0x62c03af8, Offset: 0x9b60
// Size: 0x122
function register_sidequest(id, sidequest_stat) {
    if (!isdefined(level.zombie_sidequest_stat)) {
        level.zombie_sidequest_previously_completed = [];
        level.zombie_sidequest_stat = [];
    }
    level.zombie_sidequest_stat[id] = sidequest_stat;
    level flag::wait_till("start_zombie_round_logic");
    level.zombie_sidequest_previously_completed[id] = 0;
    if (!level.onlinegame) {
        return;
    }
    if (is_true(level.zm_disable_recording_stats)) {
        return;
    }
    players = getplayers();
    for (i = 0; i < players.size; i++) {
        if (players[i] zm_stats::get_global_stat(level.zombie_sidequest_stat[id])) {
            level.zombie_sidequest_previously_completed[id] = 1;
            return;
        }
    }
}

// Namespace zm/zm
// Params 1, eflags: 0x0
// Checksum 0x3fc2e326, Offset: 0x9c90
// Size: 0x2a
function is_sidequest_previously_completed(id) {
    return is_true(level.zombie_sidequest_previously_completed[id]);
}

// Namespace zm/zm
// Params 1, eflags: 0x0
// Checksum 0x5996bcb8, Offset: 0x9cc8
// Size: 0xdc
function set_sidequest_completed(id) {
    level notify(#"zombie_sidequest_completed", id);
    level.zombie_sidequest_previously_completed[id] = 1;
    if (!level.onlinegame) {
        return;
    }
    if (is_true(level.zm_disable_recording_stats)) {
        return;
    }
    players = getplayers();
    for (i = 0; i < players.size; i++) {
        if (isdefined(level.zombie_sidequest_stat[id])) {
            players[i] zm_stats::add_global_stat(level.zombie_sidequest_stat[id], 1);
        }
    }
}

// Namespace zm/zm
// Params 0, eflags: 0x1 linked
// Checksum 0x7b862823, Offset: 0x9db0
// Size: 0x1c4
function precache_zombie_leaderboards() {
    if (sessionmodeissystemlink()) {
        return;
    }
    globalleaderboards = "LB_ZM_GB_BULLETS_FIRED_AT ";
    globalleaderboards += "LB_ZM_GB_BULLETS_HIT_AT ";
    globalleaderboards += "LB_ZM_GB_DISTANCE_TRAVELED_AT ";
    globalleaderboards += "LB_ZM_GB_DOORS_PURCHASED_AT ";
    globalleaderboards += "LB_ZM_GB_GRENADE_KILLS_AT ";
    globalleaderboards += "LB_ZM_GB_HEADSHOTS_AT ";
    globalleaderboards += "LB_ZM_GB_KILLS_AT ";
    globalleaderboards += "LB_ZM_GB_PERKS_DRANK_AT ";
    globalleaderboards += "LB_ZM_GB_REVIVES_AT ";
    globalleaderboards += "LB_ZM_GB_KILLSTATS_MR ";
    globalleaderboards += "LB_ZM_GB_GAMESTATS_MR ";
    if (!level.rankedmatch && getdvarint(#"zm_private_rankedmatch", 0) == 0) {
        precacheleaderboards(globalleaderboards);
        return;
    }
    mapname = util::get_map_name();
    expectedplayernum = getnumexpectedplayers();
    mapleaderboard = "LB_ZM_MAP_" + getsubstr(mapname, 3, mapname.size) + "_" + expectedplayernum + "PLAYER";
    precacheleaderboards(globalleaderboards + mapleaderboard);
}

// Namespace zm/zm
// Params 1, eflags: 0x1 linked
// Checksum 0xdceeae1c, Offset: 0x9f80
// Size: 0xb8
function increment_dog_round_stat(stat) {
    players = getplayers();
    foreach (player in players) {
        player zm_stats::increment_client_stat("zdog_rounds_" + stat);
    }
}

// Namespace zm/zm
// Params 0, eflags: 0x1 linked
// Checksum 0xdf0dba47, Offset: 0xa040
// Size: 0x120
function player_too_many_players_check() {
    max_players = 4;
    if (level.scr_zm_ui_gametype == "zgrief" || level.scr_zm_ui_gametype == "zmeat") {
        max_players = 8;
    }
    if (getplayers().size > max_players) {
        foreach (player in getplayers()) {
            player val::set(#"hash_1a88595aedca8cc4", "freezecontrols");
        }
        level notify(#"end_game");
    }
}

// Namespace zm/zm
// Params 1, eflags: 0x0
// Checksum 0xbd4c4ee, Offset: 0xa168
// Size: 0x46
function is_idgun_damage(weapon) {
    if (isdefined(level.idgun_weapons)) {
        if (isinarray(level.idgun_weapons, weapon)) {
            return true;
        }
    }
    return false;
}

// Namespace zm/zm
// Params 0, eflags: 0x1 linked
// Checksum 0x44ccab72, Offset: 0xa1b8
// Size: 0x1e6
function function_a2b54d42() {
    n_multiplier = zombie_utility::function_d2dfacfd(#"hash_1ab42b4d7db4cb3c");
    if (zm_utility::is_standard()) {
        switch (level.players.size) {
        case 1:
            n_multiplier *= 0.55;
            break;
        case 2:
            n_multiplier *= 0.75;
            break;
        case 3:
            n_multiplier *= 0.9;
            break;
        case 4:
            n_multiplier *= 1.1;
            break;
        default:
            n_multiplier *= 1.3;
            break;
        }
    } else {
        switch (level.players.size) {
        case 1:
            n_multiplier *= 0.63;
            break;
        case 2:
            n_multiplier *= 0.75;
            break;
        case 3:
            n_multiplier *= 0.8;
            break;
        case 4:
            n_multiplier *= 0.95;
            break;
        default:
            n_multiplier *= 1.1;
            break;
        }
    }
    return n_multiplier;
}

// Namespace zm/zm
// Params 1, eflags: 0x5 linked
// Checksum 0x7df8e2e5, Offset: 0xa3a8
// Size: 0x4e
function private function_ad7bd142(*item) {
    weapon = self getcurrentweapon();
    if (killstreaks::is_killstreak_weapon(weapon)) {
        return true;
    }
    return false;
}

// Namespace zm/zm
// Params 1, eflags: 0x5 linked
// Checksum 0x5b382a2a, Offset: 0xa400
// Size: 0x168
function private function_be26a3f3(*item) {
    var_e20637be = 1;
    nullweapon = getweapon(#"none");
    var_f945fa92 = getweapon(#"bare_hands");
    currentweapon = self getcurrentweapon();
    if (currentweapon != nullweapon && currentweapon != var_f945fa92) {
        maxammo = currentweapon.maxammo;
        currentammostock = self getweaponammostock(currentweapon);
        if (currentammostock < maxammo) {
            var_e20637be = 0;
        }
    }
    var_824ff7c7 = self getstowedweapon();
    if (var_824ff7c7 != nullweapon && var_824ff7c7 != var_f945fa92) {
        maxammo = var_824ff7c7.maxammo;
        var_22baab7c = self getweaponammostock(var_824ff7c7);
        if (var_22baab7c < maxammo) {
            var_e20637be = 0;
        }
    }
    return var_e20637be;
}

// Namespace zm/zm
// Params 0, eflags: 0x5 linked
// Checksum 0xdf9e22f, Offset: 0xa570
// Size: 0x2c
function private function_d87329b7() {
    if ((isdefined(self.maxarmor) ? self.maxarmor : 0) == 0) {
        return false;
    }
    return true;
}

// Namespace zm/zm
// Params 0, eflags: 0x5 linked
// Checksum 0xbdafac34, Offset: 0xa5a8
// Size: 0x46
function private function_1072c231() {
    if ((isdefined(self.maxarmor) ? self.maxarmor : 0) == 0) {
        return true;
    }
    if (self.armor < self.maxarmor) {
        return false;
    }
    return true;
}

// Namespace zm/zm
// Params 1, eflags: 0x5 linked
// Checksum 0xdc8b2e5, Offset: 0xa5f8
// Size: 0x134
function private function_96184f63(item) {
    if (isdefined(item.var_a6762160.talents) && isdefined(self.var_7341f980)) {
        foreach (talent in item.var_a6762160.talents) {
            foreach (var_7387d8e1 in self.var_7341f980) {
                if (talent.talent == var_7387d8e1) {
                    return true;
                }
            }
        }
    }
    return false;
}

// Namespace zm/zm
// Params 1, eflags: 0x5 linked
// Checksum 0x806d61b9, Offset: 0xa738
// Size: 0x256
function private function_85ea1f60(item) {
    if (self isswitchingweapons()) {
        return false;
    }
    if (item.var_a6762160.name === #"self_revive_sr_item") {
        if (self zm_laststand::function_618fd37e() < 1) {
            return true;
        } else {
            return false;
        }
    }
    switch (item.var_a6762160.itemtype) {
    case #"armor":
        if (item.var_a6762160.var_4a1a4613 === #"armor_heal") {
            return (!self function_d87329b7() || !self function_1072c231() || self.armortier < (isdefined(item.var_a6762160.armortier) ? item.var_a6762160.armortier : 1));
        } else {
            return true;
        }
        break;
    }
    switch (item.var_a6762160.itemtype) {
    case #"weapon":
    case #"scorestreak":
        return !self function_ad7bd142(item);
    case #"survival_ammo":
        return !self function_be26a3f3(item);
    case #"survival_armor_shard":
        return !self function_1072c231();
    case #"survival_perk":
        return !self function_96184f63(item);
    default:
        return true;
    }
    return true;
}

// Namespace zm/zm
// Params 0, eflags: 0x1 linked
// Checksum 0x3b89e7d7, Offset: 0xa998
// Size: 0xd0
function register_perks() {
    perks = self.specialty;
    perks::perk_reset_all();
    if (isdefined(perks) && is_true(level.perksenabled)) {
        for (i = 0; i < perks.size; i++) {
            perk = perks[i];
            if (perk == #"specialty_null" || perk == #"weapon_null") {
                continue;
            }
            self perks::perk_setperk(perk);
        }
    }
    /#
    #/
}

// Namespace zm/zm
// Params 0, eflags: 0x1 linked
// Checksum 0xfa31cbd, Offset: 0xaa70
// Size: 0x18c
function function_7ed465e4() {
    killstreakrules::createrule("hero_weapons", 0, 0);
    killstreakrules::addkillstreaktorule("hero_annihilator", "hero_weapons", 0, 0);
    killstreakrules::addkillstreaktorule("hero_flamethrower", "hero_weapons", 0, 0);
    killstreakrules::addkillstreaktorule("hero_pineapplegun", "hero_weapons", 0, 0);
    killstreakrules::addkillstreaktorule("sig_lmg", "hero_weapons", 0, 0);
    killstreakrules::addkillstreaktorule("ultimate_turret", "hero_weapons", 0, 0);
    killstreakrules::addkillstreaktorule("chopper_gunner", "hero_weapons", 0, 0);
    killstreakrules::addkillstreaktorule("planemortar", "hero_weapons", 0, 0);
    killstreakrules::addkillstreaktorule("napalm_strike", "hero_weapons", 0, 0);
    killstreakrules::addkillstreaktorule("killstreak_sparrow", "hero_weapons", 0, 0);
}

/#

    // Namespace zm/zm
    // Params 0, eflags: 0x0
    // Checksum 0x46488d7c, Offset: 0xac08
    // Size: 0x31c
    function printhashids() {
        println("<dev string:x14b>");
        println("<dev string:x193>");
        foreach (powerup in level.zombie_powerups) {
            println(powerup.powerup_name + "<dev string:x1a5>" + powerup.hash_id);
        }
        println("<dev string:x1aa>");
        if (is_true(level.aat_in_use)) {
            foreach (aat in level.aat) {
                if (!isdefined(aat) || !isdefined(aat.name) || aat.name == "<dev string:x1b7>") {
                    continue;
                }
                println(aat.name + "<dev string:x1a5>" + aat.hash_id);
            }
        }
        println("<dev string:x1bf>");
        if (isdefined(level._custom_perks)) {
            foreach (perk in level._custom_perks) {
                if (!isdefined(perk) || !isdefined(perk.alias)) {
                    continue;
                }
                println(function_9e72a96(perk.alias) + "<dev string:x1a5>" + perk.alias);
            }
        }
        println("<dev string:x1ce>");
    }

#/
