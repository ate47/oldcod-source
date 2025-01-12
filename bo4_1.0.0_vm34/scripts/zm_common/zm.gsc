#using script_190d6b82bcca0908;
#using script_39eae6a6b493fe9e;
#using script_3c51754cf708b246;
#using script_4194df57536e11ed;
#using script_43bba08258745838;
#using script_48f7c4ab73137f8;
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
#using scripts\core_common\flagsys_shared;
#using scripts\core_common\globallogic\globallogic_vehicle;
#using scripts\core_common\hud_util_shared;
#using scripts\core_common\killcam_shared;
#using scripts\core_common\laststand_shared;
#using scripts\core_common\lui_shared;
#using scripts\core_common\music_shared;
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
#using scripts\zm\powerup\zm_powerup_bonus_points_player;
#using scripts\zm\weapons\zm_weap_claymore;
#using scripts\zm\weapons\zm_weap_homunculus;
#using scripts\zm\weapons\zm_weap_mini_turret;
#using scripts\zm\weapons\zm_weap_proximity_grenade;
#using scripts\zm_common\aats\zm_aat_brain_decay;
#using scripts\zm_common\aats\zm_aat_frostbite;
#using scripts\zm_common\aats\zm_aat_kill_o_watt;
#using scripts\zm_common\aats\zm_aat_plasmatic_burst;
#using scripts\zm_common\ai\zm_ai_utility;
#using scripts\zm_common\bb;
#using scripts\zm_common\bots\zm_bot;
#using scripts\zm_common\callings\zm_callings;
#using scripts\zm_common\gametypes\globallogic;
#using scripts\zm_common\gametypes\globallogic_player;
#using scripts\zm_common\gametypes\globallogic_scriptmover;
#using scripts\zm_common\gametypes\globallogic_spawn;
#using scripts\zm_common\gametypes\zm_gametype;
#using scripts\zm_common\talisman\zm_talisman_box_guarantee_box_only;
#using scripts\zm_common\talisman\zm_talisman_box_guarantee_lmg;
#using scripts\zm_common\talisman\zm_talisman_coagulant;
#using scripts\zm_common\talisman\zm_talisman_extra_claymore;
#using scripts\zm_common\talisman\zm_talisman_extra_frag;
#using scripts\zm_common\talisman\zm_talisman_extra_miniturret;
#using scripts\zm_common\talisman\zm_talisman_extra_molotov;
#using scripts\zm_common\talisman\zm_talisman_extra_semtex;
#using scripts\zm_common\talisman\zm_talisman_impatient;
#using scripts\zm_common\talisman\zm_talisman_perk_mod_single;
#using scripts\zm_common\talisman\zm_talisman_perk_permanent_1;
#using scripts\zm_common\talisman\zm_talisman_perk_permanent_2;
#using scripts\zm_common\talisman\zm_talisman_perk_permanent_3;
#using scripts\zm_common\talisman\zm_talisman_perk_permanent_4;
#using scripts\zm_common\talisman\zm_talisman_perk_reducecost_1;
#using scripts\zm_common\talisman\zm_talisman_perk_reducecost_2;
#using scripts\zm_common\talisman\zm_talisman_perk_reducecost_3;
#using scripts\zm_common\talisman\zm_talisman_perk_reducecost_4;
#using scripts\zm_common\talisman\zm_talisman_perk_start_1;
#using scripts\zm_common\talisman\zm_talisman_perk_start_2;
#using scripts\zm_common\talisman\zm_talisman_perk_start_3;
#using scripts\zm_common\talisman\zm_talisman_perk_start_4;
#using scripts\zm_common\talisman\zm_talisman_shield_durability_legendary;
#using scripts\zm_common\talisman\zm_talisman_shield_durability_rare;
#using scripts\zm_common\talisman\zm_talisman_shield_price;
#using scripts\zm_common\talisman\zm_talisman_special_startlv2;
#using scripts\zm_common\talisman\zm_talisman_special_startlv3;
#using scripts\zm_common\talisman\zm_talisman_special_xp_rate;
#using scripts\zm_common\talisman\zm_talisman_start_weapon_ar;
#using scripts\zm_common\talisman\zm_talisman_start_weapon_lmg;
#using scripts\zm_common\talisman\zm_talisman_start_weapon_smg;
#using scripts\zm_common\talisman\zm_talisman_weapon_reducepapcost;
#using scripts\zm_common\trials\zm_trial_headshots_only;
#using scripts\zm_common\util;
#using scripts\zm_common\zm_audio;
#using scripts\zm_common\zm_bgb;
#using scripts\zm_common\zm_blockers;
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
#using scripts\zm_common\zm_talisman;
#using scripts\zm_common\zm_transformation;
#using scripts\zm_common\zm_trial;
#using scripts\zm_common\zm_trial_util;
#using scripts\zm_common\zm_unitrigger;
#using scripts\zm_common\zm_utility;
#using scripts\zm_common\zm_vapor_random;
#using scripts\zm_common\zm_vo;
#using scripts\zm_common\zm_wallbuy;
#using scripts\zm_common\zm_weapons;
#using scripts\zm_common\zm_zonemgr;

#namespace zm;

// Namespace zm/zm
// Params 0, eflags: 0x2
// Checksum 0x7de7b866, Offset: 0x1140
// Size: 0x2a4
function autoexec ignore_systems() {
    system::ignore(#"gadget_clone");
    system::ignore(#"gadget_armor");
    system::ignore(#"gadget_cleanse");
    system::ignore(#"gadget_health_boost");
    system::ignore(#"gadget_heat_wave");
    system::ignore(#"gadget_resurrect");
    system::ignore(#"gadget_shock_field");
    system::ignore(#"gadget_overdrive");
    system::ignore(#"gadget_security_breach");
    system::ignore(#"gadget_combat_efficiency");
    system::ignore(#"gadget_other");
    system::ignore(#"gadget_camo");
    system::ignore(#"gadget_vision_pulse");
    system::ignore(#"gadget_speed_burst");
    system::ignore(#"gadget_sprint_boost");
    system::ignore(#"spike_charge_siegebot");
    system::ignore(#"siegebot");
    system::ignore(#"amws");
    system::ignore(#"gadget_health_regen");
    system::ignore(#"influencers_shared");
    system::ignore(#"mute_smoke");
}

// Namespace zm/zm
// Params 0, eflags: 0x2
// Checksum 0xcabff623, Offset: 0x13f0
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"zm", &__init__, undefined, undefined);
}

// Namespace zm/zm
// Params 0, eflags: 0x0
// Checksum 0xb8948daa, Offset: 0x1438
// Size: 0x66
function __init__() {
    if (!isdefined(level.zombie_vars)) {
        level.zombie_vars = [];
    }
    level.scr_zm_ui_gametype = util::get_game_type();
    level.scr_zm_ui_gametype_group = "";
    level.scr_zm_map_start_location = "";
}

// Namespace zm/zm
// Params 0, eflags: 0x0
// Checksum 0xa681f9f0, Offset: 0x14a8
// Size: 0xa64
function init() {
    if (isdefined(level.aat_in_use) && level.aat_in_use) {
        register_vehicle_damage_callback(&aat::aat_vehicle_damage_monitor);
        register_zombie_damage_override_callback(&aat::aat_response);
    }
    setdvar(#"doublejump_enabled", 0);
    setdvar(#"wallrun_enabled", 0);
    setdvar(#"sprintleap_enabled", 0);
    setdvar(#"traverse_mode", 2);
    setdvar(#"weaponrest_enabled", 0);
    setdvar(#"ui_allowdisplaycontinue", 1);
    if (!isdefined(level.killstreakweapons)) {
        level.killstreakweapons = [];
    }
    level.weaponnone = getweapon(#"none");
    level.weaponnull = getweapon(#"weapon_null");
    level.weaponbasemelee = getweapon(#"knife");
    level.weaponbasemeleeheld = getweapon(#"knife_held");
    level.weaponballisticknife = getweapon(#"hash_28987b4cc8577bea");
    if (!isdefined(level.weaponriotshield)) {
        level.weaponriotshield = getweapon(#"riotshield");
    }
    level.weaponrevivetool = getweapon(#"syrette");
    level.weaponzmdeaththroe = getweapon(#"death_throe");
    level.weaponzmfists = getweapon(#"zombie_fists");
    if (!isdefined(level.givecustomloadout)) {
        level.givecustomloadout = &zm_weapons::give_start_weapons;
    }
    level.projectiles_should_ignore_world_pause = 1;
    level.player_out_of_playable_area_monitor = 1;
    level.var_67a71cec = 1;
    level.var_a3e1b821 = &zm_player::function_67a71cec;
    level.player_too_many_players_check = 1;
    level.player_too_many_players_check_func = &player_too_many_players_check;
    level._use_choke_weapon_hints = 1;
    level._use_choke_blockers = 1;
    level.speed_change_round = 15;
    level.var_46df529e = 0;
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
    level.grenade_multiattack_bookmark_count = 1;
    demo::initactorbookmarkparams(3, 6000, 6000);
    if (!isdefined(level._zombies_round_spawn_failsafe)) {
        level._zombies_round_spawn_failsafe = &zombie_utility::round_spawn_failsafe;
    }
    level.func_get_zombie_spawn_delay = &zm_round_logic::get_zombie_spawn_delay;
    level.func_get_delay_between_rounds = &zm_round_logic::get_delay_between_rounds;
    level.var_b5bdb0b1 = &function_edebf96;
    level.no_target_override = &zm_cleanup::no_target_override;
    level.var_f86a6db6 = &zm_cleanup::function_f86a6db6;
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
        level.zombie_ai_limit = 24;
    }
    if (!isdefined(level.zombie_actor_limit)) {
        level.zombie_actor_limit = 31;
    }
    level.var_93c99bff = zm_game_over::register("game_over");
    init_flags();
    init_dvars();
    init_strings();
    init_levelvars();
    init_sounds();
    init_shellshocks();
    init_client_field_callback_funcs();
    zm_loadout::register_offhand_weapons_for_level_defaults();
    zm_perks::init();
    zm_talisman::init();
    zm_powerups::init();
    zm_spawner::init();
    level.zombie_poi_array = getentarray("zombie_poi", "script_noteworthy");
    init_function_overrides();
    level thread zm_laststand::function_14393746();
    level thread post_all_players_connected();
    zm_utility::init_utility();
    initializestattracking();
    if (getplayers().size <= 1) {
        incrementcounter(#"hash_174c913b3e8a0ef8", 1);
    } else if (isdefined(level.systemlink) && level.systemlink) {
        incrementcounter(#"hash_1c1b20d63880009a", 1);
    } else if (getdvarint(#"splitscreen_playercount", 0) == getplayers().size) {
        incrementcounter(#"hash_10f219c3624a520d", 1);
    } else {
        incrementcounter(#"hash_370c4f482b5ec8ea", 1);
    }
    callback::on_connect(&zm_player::zm_on_player_connect);
    zm_utility::set_demo_intermission_point();
    level thread zm_ffotd::main_end();
    level thread zm_utility::track_players_intersection_tracker();
    level thread zm_utility::function_ff0f610d();
    level thread onallplayersready();
    level thread zm_round_logic::function_83b0d780();
    callback::on_spawned(&zm_player::zm_on_player_spawned);
    level thread zm_utility::function_47c04da0();
    /#
        printhashids();
    #/
}

// Namespace zm/zm
// Params 0, eflags: 0x0
// Checksum 0x4c5fa2d5, Offset: 0x1f18
// Size: 0x1c
function post_main() {
    level thread init_custom_ai_type();
}

// Namespace zm/zm
// Params 1, eflags: 0x0
// Checksum 0xbc97ff36, Offset: 0x1f40
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
// Params 3, eflags: 0x0
// Checksum 0xf5e1e5b, Offset: 0x1fa8
// Size: 0x324
function fade_out_intro_screen_zm(hold_black_time, fade_out_time, var_47f9982a) {
    if (isdefined(level.var_7b92db95)) {
        [[ level.var_7b92db95 ]]();
    } else if (isdefined(hold_black_time)) {
        wait hold_black_time;
    } else {
        wait 0.2;
    }
    if (!isdefined(fade_out_time)) {
        fade_out_time = 1.5;
    }
    array::thread_all(getplayers(), &initialblackend);
    level clientfield::set("sndZMBFadeIn", 1);
    lui::screen_fade_in(fade_out_time, undefined);
    wait 1.6;
    level.var_46df529e = 1;
    players = getplayers();
    for (i = 0; i < players.size; i++) {
        if (isdefined(level.var_9f508948)) {
            players[i] thread [[ level.var_9f508948 ]]();
        } else {
            players[i] function_4af767f3();
        }
        if (!(isdefined(level.host_ended_game) && level.host_ended_game)) {
            if (isdefined(level.var_7679ccbb)) {
                players[i] val::set(#"fade_out_intro_screen_zm", "freezecontrols", level.var_7679ccbb);
                players[i] val::set(#"fade_out_intro_screen_zm", "disablegadgets", 1);
                println("<dev string:x30>");
                continue;
            }
            if (!(isdefined(players[i].hostmigrationcontrolsfrozen) && players[i].hostmigrationcontrolsfrozen)) {
                players[i] val::reset(#"fade_out_intro_screen_zm", "freezecontrols");
                players[i] val::reset(#"fade_out_intro_screen_zm", "disablegadgets");
                println("<dev string:x45>");
            }
        }
    }
    level flag::set("initial_blackscreen_passed");
    level clientfield::set("gameplay_started", 1);
}

// Namespace zm/zm
// Params 0, eflags: 0x0
// Checksum 0x6428e0e2, Offset: 0x22d8
// Size: 0xaa
function function_4af767f3() {
    self setclientuivisibilityflag("hud_visible", 1);
    self setclientuivisibilityflag("weapon_hud_visible", 1);
    if (!(isdefined(self.var_3aadb7ec) && self.var_3aadb7ec) && sessionmodeisonlinegame()) {
        self luinotifyevent(#"hash_167fc7366e373151", 0);
        self.var_3aadb7ec = 1;
    }
}

// Namespace zm/zm
// Params 0, eflags: 0x0
// Checksum 0x70906eb3, Offset: 0x2390
// Size: 0x50c
function onallplayersready() {
    timeout = gettime() + 5000;
    while (isloadingcinematicplaying() || getnumexpectedplayers(1) == 0 && gettime() < timeout) {
        wait 0.1;
    }
    println("<dev string:x5a>" + getnumexpectedplayers(1));
    player_count_actual = 0;
    initial_black = lui::get_luimenu("InitialBlack");
    while (getnumconnectedplayers() < getnumexpectedplayers(1) || player_count_actual < getnumexpectedplayers(1)) {
        players = getplayers();
        player_count_actual = 0;
        for (i = 0; i < players.size; i++) {
            players[i] val::set(#"onallplayersready", "freezecontrols");
            players[i] val::set(#"onallplayersready", "disablegadgets");
            if (players[i].sessionstate == "playing") {
                player_count_actual++;
            }
            if (!initial_black initial_black::is_open(players[i])) {
                players[i] initialblack();
            }
        }
        println("<dev string:x77>" + getnumconnectedplayers() + "<dev string:x8d>" + getnumexpectedplayers(1));
        wait 0.1;
    }
    setinitialplayersconnected();
    level flag::set("all_players_connected");
    println("<dev string:x9a>");
    a_e_players = getplayers();
    if (a_e_players.size == 1) {
        level flag::set("solo_game");
        level.solo_lives_given = 0;
    }
    level flag::set("initial_players_connected");
    while (!aretexturesloaded()) {
        waitframe(1);
    }
    if (isdefined(level.var_639d8432)) {
        wait level.var_639d8432;
    }
    music::setmusicstate("none");
    thread function_816dcdcc(3);
    set_intermission_point();
    n_black_screen = 5;
    level thread fade_out_intro_screen_zm(n_black_screen, 1.5, 1);
    wait n_black_screen;
    level.n_gameplay_start_time = gettime();
    clientfield::set("game_start_time", level.n_gameplay_start_time);
    foreach (player in getplayers()) {
        player val::reset(#"onallplayersready", "freezecontrols");
        player val::reset(#"onallplayersready", "disablegadgets");
    }
    /#
        rat::function_5650d768();
    #/
}

// Namespace zm/zm
// Params 1, eflags: 0x0
// Checksum 0xa7545f37, Offset: 0x28a8
// Size: 0xa0
function function_46aa9fe2(func) {
    level endon(#"all_players_connected", #"game_ended");
    array::thread_all(getplayers(), func);
    while (true) {
        result = level waittill(#"connected");
        result.player thread [[ func ]]();
    }
}

// Namespace zm/zm
// Params 0, eflags: 0x0
// Checksum 0x8187004a, Offset: 0x2950
// Size: 0x64
function initialblack() {
    luinotifyevent(#"quick_fade", 0);
    initial_black = lui::get_luimenu("InitialBlack");
    initial_black initial_black::open(self, 1);
}

// Namespace zm/zm
// Params 0, eflags: 0x0
// Checksum 0x4a61f681, Offset: 0x29c0
// Size: 0x3c
function initialblackend() {
    initial_black = lui::get_luimenu("InitialBlack");
    initial_black initial_black::close(self);
}

// Namespace zm/zm
// Params 1, eflags: 0x0
// Checksum 0x45e66f0b, Offset: 0x2a08
// Size: 0x2c
function function_816dcdcc(time_to_wait) {
    wait time_to_wait;
    level flag::set("start_zombie_round_logic");
}

// Namespace zm/zm
// Params 0, eflags: 0x0
// Checksum 0xdcb0599b, Offset: 0x2a40
// Size: 0x104
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
// Params 0, eflags: 0x0
// Checksum 0xcfd8888, Offset: 0x2b50
// Size: 0x134
function post_all_players_connected() {
    level thread end_game();
    level flag::wait_till("start_zombie_round_logic");
    level.var_e656acd7 = level.players.size;
    println("<dev string:xc9>", level.script, "<dev string:xdc>", getplayers().size);
    level thread round_end_monitor();
    if (!level.zombie_anim_intro) {
        if (isdefined(level._round_start_func)) {
            level thread [[ level._round_start_func ]]();
        }
    }
    level thread players_playing();
    level.startinvulnerabletime = getdvarint(#"player_deathinvulnerabletime", 0);
    level thread function_ad944be5();
}

// Namespace zm/zm
// Params 0, eflags: 0x0
// Checksum 0x6f0f45b0, Offset: 0x2c90
// Size: 0x40
function function_ad944be5() {
    level endon(#"end_game");
    while (true) {
        wait 300;
        function_5ce5d0be();
    }
}

// Namespace zm/zm
// Params 0, eflags: 0x0
// Checksum 0x9f1347a9, Offset: 0x2cd8
// Size: 0x34
function start_zm_dash_counter_watchers() {
    level thread first_consumables_used_watcher();
    level thread function_ba01dda6();
}

// Namespace zm/zm
// Params 0, eflags: 0x0
// Checksum 0x63cccd9b, Offset: 0x2d18
// Size: 0x24
function first_consumables_used_watcher() {
    level flag::init("first_consumables_used");
}

// Namespace zm/zm
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x2d48
// Size: 0x4
function function_ba01dda6() {
    
}

// Namespace zm/zm
// Params 0, eflags: 0x0
// Checksum 0xe33e5f96, Offset: 0x2d58
// Size: 0x54
function init_custom_ai_type() {
    if (isdefined(level.custom_ai_type)) {
        for (i = 0; i < level.custom_ai_type.size; i++) {
            [[ level.custom_ai_type[i] ]]();
        }
    }
}

// Namespace zm/zm
// Params 0, eflags: 0x0
// Checksum 0x9f198984, Offset: 0x2db8
// Size: 0x74
function zombiemode_melee_miss() {
    if (isdefined(self.enemy.var_e75c9abb)) {
        self.enemy dodamage(getdvarint(#"ai_meleedamage", 0), self.origin, self, self, "none", "melee");
    }
}

// Namespace zm/zm
// Params 0, eflags: 0x0
// Checksum 0xc4b9da48, Offset: 0x2e38
// Size: 0x16
function init_shellshocks() {
    level.player_killed_shellshock = "zombie_death";
}

// Namespace zm/zm
// Params 0, eflags: 0x0
// Checksum 0xd7c9c254, Offset: 0x2e58
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
// Params 0, eflags: 0x0
// Checksum 0x59d87d4d, Offset: 0x2fa8
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
// Params 0, eflags: 0x0
// Checksum 0x23fa9c, Offset: 0x3398
// Size: 0x8c4
function init_levelvars() {
    level.is_zombie_level = 1;
    level.default_laststandpistol = getweapon(#"pistol_topbreak_t8");
    level.default_solo_laststandpistol = getweapon(#"pistol_topbreak_t8_upgraded");
    level.super_ee_weapon = getweapon(#"pistol_burst");
    level.laststandpistol = level.default_laststandpistol;
    level.start_weapon = level.default_laststandpistol;
    level.first_round = 1;
    level.start_round = getgametypesetting(#"startround");
    level.round_number = level.start_round;
    level.enable_magic = getgametypesetting(#"magic");
    level.headshots_only = getgametypesetting(#"zmheadshotsonly");
    level.player_starting_points = function_5f5f7342();
    level.round_start_time = 0;
    level.pro_tips_start_time = 0;
    level.intermission = 0;
    level.dog_intermission = 0;
    level.zombie_total = 0;
    level.zombie_respawns = 0;
    level.var_90bfb00c = 0;
    level.total_zombies_killed = 0;
    level.zm_loc_types = [];
    level.zm_loc_types[#"zombie_location"] = [];
    level.var_e856e41a = 8;
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
    level.var_4fb25bb9 = [];
    level.var_4fb25bb9[#"walk"] = 4;
    level.var_4fb25bb9[#"run"] = 4;
    level.var_4fb25bb9[#"sprint"] = 4;
    level.var_4fb25bb9[#"super_sprint"] = 4;
    level.var_4fb25bb9[#"crawl"] = 3;
    level.current_zombie_array = [];
    level.current_zombie_count = 0;
    level.zombie_total_subtract = 0;
    level.destructible_callbacks = [];
    foreach (team, _ in level.teams) {
        if (!isdefined(level.zombie_vars[team])) {
            level.zombie_vars[team] = [];
        }
    }
    level.gamedifficulty = getgametypesetting(#"zmdifficulty");
    zombie_utility::set_zombie_var(#"below_world_check", -1000);
    zombie_utility::set_zombie_var(#"spectators_respawn", 1);
    zombie_utility::set_zombie_var(#"zombie_use_failsafe", 1);
    zombie_utility::set_zombie_var(#"zombie_between_round_time", 15);
    zombie_utility::set_zombie_var(#"zombie_intermission_time", 15);
    zombie_utility::set_zombie_var(#"zombie_score_kill", 70);
    zombie_utility::set_zombie_var(#"zombie_score_bonus_melee", 60);
    zombie_utility::set_zombie_var(#"zombie_score_bonus_head", 30);
    zombie_utility::set_zombie_var(#"hash_68aa9b4c8de33261", 50);
    zombie_utility::set_zombie_var(#"zombify_player", 0);
    if (issplitscreen()) {
        zombie_utility::set_zombie_var(#"zombie_timer_offset", 280);
    }
    function_9f624ae8();
    level thread init_player_levelvars();
    level.speed_change_max = 0;
    level.speed_change_num = 0;
    zm_round_logic::set_round_number(level.round_number);
    zm_score::function_c723805e("zombie", zombie_utility::get_zombie_var(#"zombie_score_kill"));
}

// Namespace zm/zm
// Params 0, eflags: 0x4
// Checksum 0xeca56fde, Offset: 0x3c68
// Size: 0x66
function private function_5f5f7342() {
    n_starting = (level.round_number - zm_custom::function_5638f689(#"startround") + 1) * 500;
    return isdefined(level.player_starting_points) ? level.player_starting_points : n_starting;
}

// Namespace zm/zm
// Params 0, eflags: 0x0
// Checksum 0x1ef9262f, Offset: 0x3cd8
// Size: 0x664
function function_9f624ae8() {
    var_4c9559d7 = function_fec8553f();
    zombie_utility::set_zombie_var(#"zombie_health_increase", var_4c9559d7[#"zomhealthincrease"], 0);
    zombie_utility::set_zombie_var(#"zombie_health_increase_multiplier", var_4c9559d7[#"zomhealthincreasemult"], 1);
    zombie_utility::set_zombie_var(#"zombie_health_start", var_4c9559d7[#"zombasehealth"], 0);
    zombie_utility::set_zombie_var(#"hash_7d5a25e2463f7fc5", var_4c9559d7[#"zomspawndelay"], 0);
    zombie_utility::set_zombie_var(#"zombie_new_runner_interval", var_4c9559d7[#"zomnewrunnerint"], 0);
    zombie_utility::set_zombie_var(#"zombie_max_ai", var_4c9559d7[#"zommaxcount"], 0);
    zombie_utility::set_zombie_var(#"zombie_ai_per_player", var_4c9559d7[#"zommaxcountperplayer"], 0);
    zombie_utility::set_zombie_var(#"zombie_move_speed_multiplier", var_4c9559d7[#"zommovespeedmult"], 0);
    zombie_utility::set_zombie_var(#"hash_607bc50072c2a386", var_4c9559d7[#"zomcountscalar"], 1);
    zombie_utility::set_zombie_var(#"hash_67b3cbf79292e047", var_4c9559d7[#"zomcountsolomult"], 1);
    zombie_utility::set_zombie_var(#"player_base_health", var_4c9559d7[#"plybasehealth"], 0);
    zombie_utility::set_zombie_var(#"player_health_regen_rate", var_4c9559d7[#"plyhealthregenrate"], 0);
    zombie_utility::set_zombie_var(#"player_health_regen_delay", var_4c9559d7[#"plyhealthregendelay"], 0);
    zombie_utility::set_zombie_var(#"penalty_no_revive", var_4c9559d7[#"plypenaltynorevive"], 1);
    zombie_utility::set_zombie_var(#"penalty_died", var_4c9559d7[#"plypenaltydeath"], 1);
    zombie_utility::set_zombie_var(#"penalty_downed", var_4c9559d7[#"plypenaltydowned"], 1);
    zombie_utility::set_zombie_var(#"hash_3037a1f286b662e6", var_4c9559d7[#"plypenaltydownedpointstep"], 1);
    zombie_utility::set_zombie_var(#"hash_3098c53bba6402d3", var_4c9559d7[#"plyselfrevivecountcoop"], 0);
    zombie_utility::set_zombie_var(#"hash_67ae1b8cbb7c985", var_4c9559d7[#"plyselfrevivecountsolo"], 0);
    zombie_utility::set_zombie_var(#"hash_cc85b961f25c2ff", var_4c9559d7[#"plyshielddamagemult"], 1);
    zombie_utility::set_zombie_var(#"retain_weapons", var_4c9559d7[#"plyretainweapons"], 0);
    zombie_utility::set_zombie_var(#"perks_decay", var_4c9559d7[#"plyperksdecay"], 0);
    zombie_utility::set_zombie_var(#"hash_1ab42b4d7db4cb3c", var_4c9559d7[#"plyxpmodfier"], 1);
    zombie_utility::set_zombie_var(#"highlight_craftables", var_4c9559d7[#"plyhighlightcraftables"], 0);
    zombie_utility::set_zombie_var(#"zombie_point_scalar", var_4c9559d7[#"zompointscalar"], undefined, undefined, 1);
    zombie_utility::set_zombie_var(#"hash_3a4a041c1d674898", var_4c9559d7[#"zommixedstart"], 0);
    zombie_utility::set_zombie_var(#"hash_762b7db4166c70aa", var_4c9559d7[#"zommixedstartsolo"], 0);
    zombie_utility::set_zombie_var(#"hash_6eb9b2d60babd5aa", var_4c9559d7[#"zomcatalyststart"], 0);
    zombie_utility::set_zombie_var(#"hash_376905ad360fc2e8", var_4c9559d7[#"zomcatalyststartsolo"], 0);
    zombie_utility::set_zombie_var(#"hash_3b4ad7449c039d1b", var_4c9559d7[#"zomstokerstart"], 0);
    zombie_utility::set_zombie_var(#"hash_2374f3ef775ac2c3", var_4c9559d7[#"zomstokerstartsolo"], 0);
    level flagsys::set(#"zombie_vars_init");
}

// Namespace zm/zm
// Params 0, eflags: 0x0
// Checksum 0x8251e036, Offset: 0x4348
// Size: 0x2cc
function function_fec8553f() {
    if (isdefined(level.var_5e6d7e5)) {
        zmdifficultysettings = getscriptbundle(level.var_5e6d7e5);
    } else {
        zmdifficultysettings = getscriptbundle("zm_base_difficulty");
    }
    var_4c9559d7 = [];
    switch (level.gamedifficulty) {
    case 0:
        str_suffix = "_E";
        break;
    case 1:
    default:
        str_suffix = "_N";
        break;
    case 2:
        str_suffix = "_H";
        break;
    case 3:
        str_suffix = "_I";
        break;
    }
    foreach (var_414f8ef3 in array("zomMoveSpeedMult", "zomBaseHealth", "zomHealthIncrease", "zomHealthIncreaseMult", "zomSpawnDelay", "zomNewRunnerInt", "zomMaxCount", "zomMaxCountPerPlayer", "zomCountScalar", "zomCountSoloMult", "zomPointScalar", "plyBaseHealth", "plyPenaltyNoRevive", "plyPenaltyDeath", "plyPenaltyDowned", "plyPenaltyDownedPointStep", "plySelfReviveCountCoop", "plySelfReviveCountSolo", "zomMixedStart", "zomMixedStartSolo", "zomCatalystStart", "zomCatalystStartSolo", "zomStokerStart", "zomStokerStartSolo", "plyShieldDamageMult", "plyRetainWeapons", "plyPerksDecay", "plyHealthRegenRate", "plyHealthRegenDelay", "plyXPModfier", "plyHighlightCraftables")) {
        if (!isdefined(zmdifficultysettings.(var_414f8ef3 + str_suffix))) {
            zmdifficultysettings.(var_414f8ef3 + str_suffix) = 0;
        }
        var_4c9559d7[var_414f8ef3] = zmdifficultysettings.(var_414f8ef3 + str_suffix);
    }
    return var_4c9559d7;
}

// Namespace zm/zm
// Params 0, eflags: 0x0
// Checksum 0x8f899318, Offset: 0x4620
// Size: 0xe0
function init_player_levelvars() {
    level flag::wait_till("start_zombie_round_logic");
    difficulty = 1;
    column = int(difficulty) + 1;
    for (i = 0; i < 8; i++) {
        points = 500;
        if (i > 3) {
            points = 3000;
        }
        points = zombie_utility::set_zombie_var("zombie_score_start_" + i + 1 + "p", points, 0, column);
    }
}

// Namespace zm/zm
// Params 0, eflags: 0x0
// Checksum 0xee9687a4, Offset: 0x4708
// Size: 0x9c
function init_dvars() {
    setdvar(#"magic_chest_movable", 1);
    setdvar(#"revive_trigger_radius", 75);
    setdvar(#"scr_deleteexplosivesonspawn", 0);
    setdvar(#"cg_healthperbar", 50);
}

// Namespace zm/zm
// Params 0, eflags: 0x0
// Checksum 0x48290b17, Offset: 0x47b0
// Size: 0x186
function init_function_overrides() {
    level.callbackplayerdamage = &zm_player::callback_playerdamage;
    level.overrideplayerdamage = &zm_player::player_damage_override;
    level.callbackplayerkilled = &zm_player::player_killed_override;
    level.callbackplayerlaststand = &zm_player::callback_playerlaststand;
    level.prevent_player_damage = &zm_player::player_prevent_damage;
    level.callbackactorkilled = &actor_killed_override;
    level.callbackactordamage = &actor_damage_override_wrapper;
    level.var_e66ba0a3 = &globallogic_scriptmover::function_d786279a;
    level.callbackvehicledamage = &vehicle_damage_override;
    level.callbackvehiclekilled = &globallogic_vehicle::callback_vehiclekilled;
    level.callbackvehicleradiusdamage = &globallogic_vehicle::callback_vehicleradiusdamage;
    level.custom_introscreen = &zombie_intro_screen;
    level.custom_intermission = &zm_player::player_intermission;
    level.reset_clientdvars = &zm_player::onplayerconnect_clientdvars;
    level.player_becomes_zombie = &zm_playerzombie::zombify_player;
    level.validate_enemy_path_length = &zm_utility::default_validate_enemy_path_length;
}

// Namespace zm/zm
// Params 0, eflags: 0x0
// Checksum 0x4bcf3b0b, Offset: 0x4940
// Size: 0x2a8
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
    level flag::init("initial_players_connected");
    level flag::init("power_on");
    power_trigs = getentarray("use_elec_switch", "targetname");
    foreach (trig in power_trigs) {
        if (isdefined(trig.script_int)) {
            level flag::init("power_on" + trig.script_int);
        }
    }
}

// Namespace zm/zm
// Params 0, eflags: 0x0
// Checksum 0xd245b3f8, Offset: 0x4bf0
// Size: 0x3f4
function init_client_field_callback_funcs() {
    clientfield::register("actor", "zombie_riser_fx", 1, 1, "int");
    if (isdefined(level.use_water_risers) && level.use_water_risers) {
        clientfield::register("actor", "zombie_riser_fx_water", 1, 1, "int");
    }
    if (isdefined(level.use_foliage_risers) && level.use_foliage_risers) {
        clientfield::register("actor", "zombie_riser_fx_foliage", 1, 1, "int");
    }
    if (isdefined(level.use_low_gravity_risers) && level.use_low_gravity_risers) {
        clientfield::register("actor", "zombie_riser_fx_lowg", 1, 1, "int");
    }
    clientfield::register("actor", "zombie_has_eyes", 1, 1, "int");
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
}

// Namespace zm/zm
// Params 0, eflags: 0x0
// Checksum 0x4943043d, Offset: 0x4ff0
// Size: 0x5d2
function init_fx() {
    level.createfx_callback_thread = &delete_in_createfx;
    level._effect[#"animscript_gib_fx"] = #"zombie/fx_blood_torso_explo_zmb";
    level._effect[#"animscript_gibtrail_fx"] = #"blood/fx_blood_gib_limb_trail";
    level._effect[#"switch_sparks"] = #"hash_26f37488feec03c3";
    level._effect[#"hash_4159f23a18f644a7"] = #"hash_71ed4f412b17e19e";
    level._effect[#"fx_zombie_bar_break"] = #"hash_718a24841c1e00c9";
    level._effect[#"fx_zombie_bar_break_lite"] = #"hash_35ee6425adf16fb6";
    if (!(isdefined(level.fx_exclude_edge_fog) && level.fx_exclude_edge_fog)) {
        level._effect[#"edge_fog"] = #"_t6/maps/zombie/fx_fog_zombie_amb";
    }
    level._effect[#"chest_light"] = #"zombie/fx_weapon_box_open_glow_zmb";
    level._effect[#"chest_light_closed"] = #"zombie/fx_weapon_box_closed_glow_zmb";
    if (!(isdefined(level.var_63b5ec) && level.var_63b5ec)) {
        level._effect[#"eye_glow"] = #"zm_ai/fx8_zombie_eye_glow_orange";
    }
    level._effect[#"headshot"] = #"zombie/fx_bul_flesh_head_fatal_zmb";
    level._effect[#"headshot_nochunks"] = #"zombie/fx_bul_flesh_head_nochunks_zmb";
    level._effect[#"bloodspurt"] = #"zombie/fx_bul_flesh_neck_spurt_zmb";
    if (!(isdefined(level.fx_exclude_tesla_head_light) && level.fx_exclude_tesla_head_light)) {
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
    if (!(isdefined(level.fx_exclude_default_explosion) && level.fx_exclude_default_explosion)) {
        level._effect[#"def_explosion"] = #"_t6/explosions/fx_default_explosion";
    }
    if (!(isdefined(level.disable_fx_upgrade_aquired) && level.disable_fx_upgrade_aquired)) {
        level._effect[#"upgrade_aquired"] = #"hash_359f0993cf4ebe66";
    }
}

// Namespace zm/zm
// Params 5, eflags: 0x0
// Checksum 0x382c77d1, Offset: 0x55d0
// Size: 0x4c
function zombie_intro_screen(string1, string2, string3, string4, string5) {
    level flag::wait_till("start_zombie_round_logic");
}

// Namespace zm/zm
// Params 0, eflags: 0x0
// Checksum 0xdd09f751, Offset: 0x5628
// Size: 0x56
function players_playing() {
    players = getplayers();
    level.players_playing = players.size;
    wait 20;
    players = getplayers();
    level.players_playing = players.size;
}

// Namespace zm/zm
// Params 0, eflags: 0x0
// Checksum 0xcb32bac3, Offset: 0x5688
// Size: 0x94
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
// Params 1, eflags: 0x0
// Checksum 0x24c5aaed, Offset: 0x5728
// Size: 0x46
function register_vehicle_damage_callback(func) {
    if (!isdefined(level.vehicle_damage_callbacks)) {
        level.vehicle_damage_callbacks = [];
    }
    level.vehicle_damage_callbacks[level.vehicle_damage_callbacks.size] = func;
}

// Namespace zm/zm
// Params 15, eflags: 0x0
// Checksum 0x861e098c, Offset: 0x5778
// Size: 0x174
function vehicle_damage_override(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal) {
    if (isdefined(level.vehicle_damage_callbacks)) {
        for (i = 0; i < level.vehicle_damage_callbacks.size; i++) {
            idamage = self [[ level.vehicle_damage_callbacks[i] ]](einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal);
        }
    }
    self thread zm_score::function_496b6fa3(eattacker, idamage);
    self globallogic_vehicle::callback_vehicledamage(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal);
}

// Namespace zm/zm
// Params 5, eflags: 0x4
// Checksum 0xa00b753f, Offset: 0x58f8
// Size: 0x16e
function private function_ab049397(attacker, damage, meansofdeath, weapon, shitloc) {
    if ((isdefined(level.headshots_only) && level.headshots_only || zm_trial_headshots_only::is_active()) && isplayer(attacker)) {
        if (meansofdeath == "MOD_MELEE" && (shitloc == "head" || shitloc == "helmet")) {
            return int(damage);
        }
        if (zm_utility::is_explosive_damage(meansofdeath)) {
            return int(damage);
        }
        if (weapon.isheroweapon) {
            return int(damage);
        }
        if (isdefined(self.var_74df1377) && self.var_74df1377) {
            return int(damage);
        }
        if (!zm_utility::is_headshot(weapon, shitloc, meansofdeath)) {
            return 0;
        }
    }
    return damage;
}

// Namespace zm/zm
// Params 12, eflags: 0x0
// Checksum 0xe7c99a52, Offset: 0x5a70
// Size: 0x81a
function actor_damage_override(inflictor, attacker, damage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype) {
    if (!isdefined(self) || !isdefined(attacker)) {
        return damage;
    }
    damage = bgb::actor_damage_override(inflictor, attacker, damage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype);
    damage = self check_actor_damage_callbacks(inflictor, attacker, damage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype);
    self.knuckles_extinguish_flames = weapon.name == #"tazer_knuckles";
    attacker thread zm_audio::sndplayerhitalert(self, meansofdeath, inflictor, weapon, shitloc, damage);
    if (!isplayer(attacker) && isdefined(self.non_attacker_func)) {
        if (isdefined(self.non_attack_func_takes_attacker) && self.non_attack_func_takes_attacker) {
            return self [[ self.non_attacker_func ]](damage, weapon, attacker);
        } else {
            return self [[ self.non_attacker_func ]](damage, weapon);
        }
    }
    if (isai(attacker)) {
        if (self.team == attacker.team && meansofdeath == "MOD_MELEE") {
            return 0;
        }
    }
    if (isdefined(level.zm_bots_scale) && level.zm_bots_scale && isbot(attacker)) {
        damage = int(damage * zm_bot::function_c68c1b9f(self));
    }
    if (!isdefined(damage) || !isdefined(meansofdeath)) {
        return damage;
    }
    if (meansofdeath == "") {
        return damage;
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
            println("<dev string:x103>" + final_damage / old_damage + "<dev string:x11a>" + old_damage + "<dev string:x12a>" + final_damage);
        }
    #/
    if (isdefined(self.in_water) && self.in_water) {
        if (int(final_damage) >= self.health) {
            self.water_damage = 1;
        }
    }
    if (isdefined(inflictor) && isdefined(inflictor.archetype) && inflictor.archetype == "glaive") {
        if (meansofdeath == "MOD_CRUSH") {
            if (isdefined(inflictor.enemy) && inflictor.enemy != self || isdefined(inflictor._glaive_must_return_to_owner) && inflictor._glaive_must_return_to_owner) {
                if (isdefined(self.archetype) && self.archetype != "margwa") {
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
            attacker.hits++;
        }
    }
    if (isplayer(attacker) && isdefined(attacker.heroability) && attacker.heroability === weapon) {
        var_db741e3 = int(level.zombie_health * 0.05);
        if (level.round_number > 15) {
            final_damage = damage + var_db741e3;
        }
    }
    if (isplayer(attacker)) {
        final_damage = zm_spawner::function_112edd9(meansofdeath, attacker, final_damage);
        final_damage = self zm_powerups::function_69b64e81(attacker, meansofdeath, shitloc, weapon, final_damage);
        self.has_been_damaged_by_player = 1;
    }
    final_damage = self function_ab049397(attacker, final_damage, meansofdeath, weapon, shitloc);
    final_damage = self zm_pap_util::function_93293ac0(inflictor, attacker, final_damage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype);
    if (isdefined(attacker) && final_damage > 0 && !(isdefined(self.var_dfc644e4) && self.var_dfc644e4) && !(isdefined(level.var_fc04f28d) && level.var_fc04f28d)) {
        attacker util::show_hit_marker(final_damage >= self.health);
    }
    return int(final_damage);
}

// Namespace zm/zm
// Params 12, eflags: 0x0
// Checksum 0x7a6a2b7d, Offset: 0x6298
// Size: 0x10e
function check_actor_damage_callbacks(inflictor, attacker, damage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype) {
    if (!isdefined(level.actor_damage_callbacks)) {
        return damage;
    }
    for (i = 0; i < level.actor_damage_callbacks.size; i++) {
        newdamage = self [[ level.actor_damage_callbacks[i] ]](inflictor, attacker, damage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype);
        if (-1 != newdamage) {
            return newdamage;
        }
    }
    return damage;
}

// Namespace zm/zm
// Params 2, eflags: 0x0
// Checksum 0x3b0ee42c, Offset: 0x63b0
// Size: 0x86
function register_actor_damage_callback(func, var_36d3ad3c = 0) {
    if (!isdefined(level.actor_damage_callbacks)) {
        level.actor_damage_callbacks = [];
    }
    if (var_36d3ad3c) {
        array::push_front(level.actor_damage_callbacks, func);
        return;
    }
    level.actor_damage_callbacks[level.actor_damage_callbacks.size] = func;
}

// Namespace zm/zm
// Params 0, eflags: 0x0
// Checksum 0x7fc23258, Offset: 0x6440
// Size: 0xaa
function function_5b1cb7ea() {
    if (!isdefined(level.var_2b1e048e)) {
        level.var_2b1e048e = 0;
    }
    if (!isdefined(level.var_cd1693e6)) {
        level.var_cd1693e6 = 0;
    }
    while (isdefined(self)) {
        if (level.var_2b1e048e == gettime()) {
            level.var_cd1693e6++;
            if (level.var_cd1693e6 < 4) {
                return;
            }
        } else {
            level.var_2b1e048e = gettime();
            level.var_cd1693e6 = 0;
            return;
        }
        waitframe(1);
    }
}

// Namespace zm/zm
// Params 15, eflags: 0x0
// Checksum 0xba86387, Offset: 0x64f8
// Size: 0x444
function actor_damage_override_wrapper(inflictor, attacker, damage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, boneindex, modelindex, surfacetype, vsurfacenormal) {
    if (!isdefined(self)) {
        return damage;
    }
    if (level.var_90bfb00c <= 0 && level flag::get(#"infinite_round_spawning") && !(isdefined(level.var_481b1dce) && level.var_481b1dce)) {
        self.var_f7038080 = 1;
    }
    if (isdefined(attacker) && attacker zm_utility::function_b1b590cc()) {
        attacker = attacker.owner;
    }
    damage_override = self actor_damage_override(inflictor, attacker, damage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype);
    willbekilled = self.health - damage_override <= 0;
    if (isdefined(level.zombie_damage_override_callbacks)) {
        foreach (func_override in level.zombie_damage_override_callbacks) {
            self thread [[ func_override ]](willbekilled, inflictor, attacker, damage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype);
        }
    }
    bb::logdamage(attacker, self, weapon, damage_override, meansofdeath, shitloc, willbekilled, willbekilled);
    if (!willbekilled || !(isdefined(self.dont_die_on_me) && self.dont_die_on_me)) {
        self thread zm_score::function_496b6fa3(attacker, damage_override);
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
        self callback::callback(#"on_ai_damage", params);
        self callback::callback(#"on_actor_damage", params);
        self finishactordamage(inflictor, attacker, damage_override, flags, meansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, boneindex, surfacetype, vsurfacenormal);
    }
}

// Namespace zm/zm
// Params 1, eflags: 0x0
// Checksum 0x9c3c0d5b, Offset: 0x6948
// Size: 0xaa
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
// Params 8, eflags: 0x0
// Checksum 0x93190cb2, Offset: 0x6a00
// Size: 0x77c
function actor_killed_override(einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime) {
    if (game.state == "postgame") {
        return;
    }
    if (self.var_4d11bb60 !== 1) {
        level.var_90bfb00c--;
        if (level.var_90bfb00c <= 0 && level flag::get(#"infinite_round_spawning") && !(isdefined(level.var_481b1dce) && level.var_481b1dce)) {
            self.var_f7038080 = 1;
        }
    }
    player = undefined;
    eattacker = attacker;
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
        if (isdefined(self.archetype) && (self.archetype == "tiger" || self.archetype == "brutus" || self.archetype == "zombie_dog" || self.archetype == "catalyst" || self.archetype == "stoker" || self.archetype == "blight_father")) {
            bookmarkname = #"hash_1553fcea4f6a00e";
        } else {
            bookmarkname = #"hash_37300d83d8e6f1fc";
        }
        if (bookmarkname == #"hash_1553fcea4f6a00e") {
            demo::bookmark(bookmarkname, gettime(), player);
        }
        potm::bookmark(bookmarkname, gettime(), player);
        level thread potm::function_da7a6757(bookmarkname, player getentitynumber(), player getxuid(), self, killcam_entity_info, weapon, smeansofdeath, deathtime, deathtimeoffset, psoffsettime, perks, killstreaks, player);
    }
    if (isai(attacker) && isdefined(attacker.script_owner)) {
        if (attacker.script_owner.team != self.team) {
            attacker = attacker.script_owner;
        }
    }
    if (isdefined(attacker) && attacker.classname == "script_vehicle" && isdefined(attacker.owner)) {
        attacker = attacker.owner;
    }
    if (isdefined(attacker) && isplayer(attacker)) {
        if (!isdefined(level.n_total_kills)) {
            level.n_total_kills = 0;
        }
        level.n_total_kills++;
        multiplier = 1;
        if (zm_utility::is_headshot(weapon, shitloc, smeansofdeath)) {
            multiplier = 1.5;
        }
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
    if (isdefined(self.is_ziplining) && self.is_ziplining) {
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
    var_eacb2b2d = zm_custom::function_5638f689(#"zmkillcap");
    if (var_eacb2b2d > 0 && level.n_total_kills >= var_eacb2b2d) {
        zm_custom::function_c4cdc40c("zmKillCap");
    }
}

// Namespace zm/zm
// Params 0, eflags: 0x0
// Checksum 0xaa9bc803, Offset: 0x7188
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
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x7200
// Size: 0x4
function function_c67c5c4a() {
    
}

// Namespace zm/zm
// Params 0, eflags: 0x0
// Checksum 0x86f1f343, Offset: 0x7210
// Size: 0xcaa
function end_game() {
    level waittill(#"end_game");
    check_end_game_intermission_delay();
    println("<dev string:x13b>");
    setmatchflag("game_ended", 1);
    game.state = "postgame";
    if (!isdefined(level.var_f6545288)) {
        level.var_f6545288 = gettime();
    }
    game_length = gettime() - level.var_f6545288;
    if (!isdefined(level.n_gameplay_start_time)) {
        level.n_gameplay_start_time = gettime();
    }
    level clientfield::set("gameplay_started", 0);
    level clientfield::set("game_end_time", int((gettime() - level.n_gameplay_start_time + 500) / 1000));
    level clientfield::set("zesn", 1);
    level thread zm_audio::sndmusicsystem_playstate("game_over");
    foreach (player in getplayers()) {
        player.ignoreme = 1;
        player enableinvulnerability();
    }
    players = getplayers();
    for (i = 0; i < players.size; i++) {
        players[i] notify(#"stop_ammo_tracking");
        players[i] clientfield::set("zmbLastStand", 0);
    }
    for (i = 0; i < players.size; i++) {
        if (sessionmodeisonlinegame()) {
            players[i] stats::function_d7e9dd79(#"demofileid", getdemofileid());
        }
        if (players[i] laststand::player_is_in_laststand()) {
            players[i] recordplayerdeathzombies();
            players[i] zm_stats::increment_player_stat("deaths");
            players[i] zm_stats::increment_client_stat("deaths");
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
        player zm_stats::function_bda9bc47(#"lobbypopup", #"summary");
        player zm_stats::function_bda9bc47(#"difficulty", level.gamedifficulty);
        if (level.var_70cb425c zm_laststand_client::is_open(player)) {
            level.var_70cb425c zm_laststand_client::close(player);
        }
    }
    if (!isdefined(level._supress_survived_screen)) {
        for (i = 0; i < players.size; i++) {
            level.var_93c99bff zm_game_over::open(players[i]);
            level.var_93c99bff zm_game_over::set_rounds(players[i], level.round_number - zm_custom::function_5638f689(#"startround") + 1);
        }
    } else if ("ztrials" == util::get_game_type()) {
        zm_trial_util::function_cf9e59f8();
    }
    util::preload_frontend();
    if (isdefined(level.var_dae44d7d)) {
        level [[ level.var_dae44d7d ]]();
    }
    for (i = 0; i < players.size; i++) {
        players[i] setclientuivisibilityflag("weapon_hud_visible", 0);
        players[i] setclientminiscoreboardhide(1);
        players[i] notify(#"report_bgb_consumption");
    }
    function_5ce5d0be();
    uploadstats();
    zm_stats::update_players_stats_at_match_end(players);
    zm_stats::update_global_counters_on_match_end();
    zm_stats::set_match_stat("gameLength", game_length);
    foreach (player in getplayers()) {
        player zm_stats::function_bda9bc47("gameLength", game_length);
    }
    bb::logroundevent("end_game");
    upload_leaderboards();
    recordgameresult(#"draw");
    globallogic::function_25540f15(#"draw");
    globallogic_player::recordactiveplayersendgamematchrecordstats();
    function_c67c5c4a();
    if (sessionmodeisonlinegame()) {
    }
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
        if (!(isdefined(level.host_ended_game) && level.host_ended_game) && getdvarint(#"hash_2a088de8afba1c99", 0) > 1) {
            luinotifyevent(#"force_scoreboard", 0);
            map_restart(1);
            wait 666;
        }
    #/
    luinotifyevent(#"force_scoreboard", 1, 1);
    intermission();
    if (zm_trial::is_trial_mode()) {
        level thread zm_trial_util::function_83dcb6c4();
    }
    if (potm::function_edefc28a() == 0) {
        wait zombie_utility::get_zombie_var(#"zombie_intermission_time");
    }
    players = getplayers();
    for (i = 0; i < players.size; i++) {
        if (level.var_93c99bff zm_game_over::is_open(players[i])) {
            level.var_93c99bff zm_game_over::close(players[i]);
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
        if (!(isdefined(level.host_ended_game) && level.host_ended_game) && getdvarint(#"hash_2a088de8afba1c99", 0)) {
            luinotifyevent(#"force_scoreboard", 1, 0);
            map_restart(1);
            wait 666;
        }
    #/
    exitlevel(0);
    wait 666;
}

// Namespace zm/zm
// Params 0, eflags: 0x0
// Checksum 0x7a06e89, Offset: 0x7ec8
// Size: 0x4c
function end_game_player_was_spectator() {
    waitframe(1);
    self ghost();
    self val::set(#"end_game_player_was_spectator", "freezecontrols", 1);
}

// Namespace zm/zm
// Params 1, eflags: 0x0
// Checksum 0xc6661b9b, Offset: 0x7f20
// Size: 0x2a
function disable_end_game_intermission(delay) {
    level.disable_intermission = 1;
    wait delay;
    level.disable_intermission = undefined;
}

// Namespace zm/zm
// Params 0, eflags: 0x0
// Checksum 0x2fdb6902, Offset: 0x7f58
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
// Params 0, eflags: 0x0
// Checksum 0xf1e42068, Offset: 0x7fa0
// Size: 0x5e
function upload_leaderboards() {
    players = getplayers();
    for (i = 0; i < players.size; i++) {
        players[i] uploadleaderboards();
    }
}

// Namespace zm/zm
// Params 0, eflags: 0x0
// Checksum 0xf701a218, Offset: 0x8008
// Size: 0x66
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
// Params 0, eflags: 0x0
// Checksum 0x81db6e8b, Offset: 0x8078
// Size: 0x7c
function uploadglobalstatcounters() {
    incrementcounter(#"global_zombies_killed", level.global_zombies_killed);
    incrementcounter(#"hash_73d94fcf96874317", level.zombie_player_killed_count);
    incrementcounter(#"hash_3efcb3698ff49121", level.zombie_trap_killed_count);
}

// Namespace zm/zm
// Params 1, eflags: 0x0
// Checksum 0x115e6b81, Offset: 0x8100
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
// Params 0, eflags: 0x0
// Checksum 0xc70c4fe6, Offset: 0x8298
// Size: 0x14c
function function_5b695fe2() {
    self closeingamemenu();
    self closemenu("StartMenu_Main");
    self notify(#"player_intermission");
    self endon(#"player_intermission");
    level endon(#"stop_intermission");
    self endon(#"disconnect");
    self endon(#"death");
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
// Params 0, eflags: 0x0
// Checksum 0x94390b1f, Offset: 0x83f0
// Size: 0x234
function intermission() {
    potm_enabled = 0;
    if (potm::function_edefc28a() > 0) {
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
            players[i] thread function_5b695fe2();
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
// Params 0, eflags: 0x0
// Checksum 0xdd65427f, Offset: 0x8630
// Size: 0x1a6
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
        if (isdefined(zombies[i].ignore_game_over_death) && zombies[i].ignore_game_over_death) {
            continue;
        }
        wait 0.5 + randomfloat(2);
        if (isdefined(zombies[i])) {
            if (!isvehicle(zombies[i])) {
                zombies[i] zombie_utility::zombie_head_gib();
            }
            zombies[i].allowdeath = 1;
            zombies[i] kill();
        }
    }
}

/#

    // Namespace zm/zm
    // Params 1, eflags: 0x0
    // Checksum 0xe037420a, Offset: 0x87e0
    // Size: 0x32
    function fade_up_over_time(t) {
        self fadeovertime(t);
        self.alpha = 1;
    }

#/

// Namespace zm/zm
// Params 0, eflags: 0x0
// Checksum 0xfce45d4c, Offset: 0x8820
// Size: 0x10e
function default_exit_level() {
    zombies = getaiteamarray(level.zombie_team);
    for (i = 0; i < zombies.size; i++) {
        if (isdefined(zombies[i].ignore_solo_last_stand) && zombies[i].ignore_solo_last_stand) {
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
// Params 0, eflags: 0x0
// Checksum 0xb56f39a5, Offset: 0x8938
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
// Params 0, eflags: 0x0
// Checksum 0xe2d552fa, Offset: 0x89b8
// Size: 0x294
function default_find_exit_point() {
    self endon(#"death");
    player = getplayers()[0];
    dist_zombie = 0;
    dist_player = 0;
    dest = 0;
    away = vectornormalize(self.origin - player.origin);
    endpos = self.origin + vectorscale(away, 600);
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
    while (true) {
        var_dd261077 = 1;
        if (isdefined(level.var_f803af94)) {
            var_dd261077 = [[ level.var_f803af94 ]]();
        }
        if (!level flag::get("wait_and_revive") && var_dd261077) {
            break;
        }
        wait 0.1;
    }
}

// Namespace zm/zm
// Params 2, eflags: 0x0
// Checksum 0x8389ce5c, Offset: 0x8c58
// Size: 0x142
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
    if (isdefined(level.zm_disable_recording_stats) && level.zm_disable_recording_stats) {
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
// Checksum 0x8136ee23, Offset: 0x8da8
// Size: 0x32
function is_sidequest_previously_completed(id) {
    return isdefined(level.zombie_sidequest_previously_completed[id]) && level.zombie_sidequest_previously_completed[id];
}

// Namespace zm/zm
// Params 1, eflags: 0x0
// Checksum 0x8d5412c8, Offset: 0x8de8
// Size: 0xee
function set_sidequest_completed(id) {
    level notify(#"zombie_sidequest_completed", id);
    level.zombie_sidequest_previously_completed[id] = 1;
    if (!level.onlinegame) {
        return;
    }
    if (isdefined(level.zm_disable_recording_stats) && level.zm_disable_recording_stats) {
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
// Params 0, eflags: 0x0
// Checksum 0x5c5cbf94, Offset: 0x8ee0
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
// Params 1, eflags: 0x0
// Checksum 0x62dce1a, Offset: 0x90b0
// Size: 0xa8
function increment_dog_round_stat(stat) {
    players = getplayers();
    foreach (player in players) {
        player zm_stats::increment_client_stat("zdog_rounds_" + stat);
    }
}

// Namespace zm/zm
// Params 0, eflags: 0x0
// Checksum 0x1369ac56, Offset: 0x9160
// Size: 0x118
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
// Checksum 0x84020fe1, Offset: 0x9280
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
// Params 0, eflags: 0x0
// Checksum 0x99a1c2de, Offset: 0x92d0
// Size: 0x22
function function_edebf96() {
    return zombie_utility::get_zombie_var(#"hash_1ab42b4d7db4cb3c");
}

/#

    // Namespace zm/zm
    // Params 0, eflags: 0x0
    // Checksum 0xe70d1ce8, Offset: 0x9300
    // Size: 0x2bc
    function printhashids() {
        outputstring = "<dev string:x14f>";
        outputstring += "<dev string:x196>";
        foreach (powerup in level.zombie_powerups) {
            outputstring += powerup.powerup_name + "<dev string:x1a6>" + powerup.hash_id + "<dev string:x1a8>";
        }
        outputstring += "<dev string:x1aa>";
        if (isdefined(level.aat_in_use) && level.aat_in_use) {
            foreach (aat in level.aat) {
                if (!isdefined(aat) || !isdefined(aat.name) || aat.name == "<dev string:x1b5>") {
                    continue;
                }
                outputstring += aat.name + "<dev string:x1a6>" + aat.hash_id + "<dev string:x1a8>";
            }
        }
        outputstring += "<dev string:x1ba>";
        foreach (perk in level._custom_perks) {
            if (!isdefined(perk) || !isdefined(perk.alias)) {
                continue;
            }
            outputstring += perk.alias + "<dev string:x1a6>" + perk.hash_id + "<dev string:x1a8>";
        }
        outputstring += "<dev string:x1c7>";
        println(outputstring);
    }

#/
