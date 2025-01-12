#using scripts\core_common\ai\archetype_brutus;
#using scripts\core_common\ai\systems\destructible_character;
#using scripts\core_common\ai\zombie_death;
#using scripts\core_common\ai\zombie_utility;
#using scripts\core_common\ai_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\zm\ai\zm_ai_brutus;
#using scripts\zm_common\zm_audio;
#using scripts\zm_common\zm_crafting;
#using scripts\zm_common\zm_devgui;
#using scripts\zm_common\zm_items;
#using scripts\zm_common\zm_magicbox;
#using scripts\zm_common\zm_perks;
#using scripts\zm_common\zm_powerups;
#using scripts\zm_common\zm_score;
#using scripts\zm_common\zm_spawner;
#using scripts\zm_common\zm_stats;
#using scripts\zm_common\zm_utility;
#using scripts\zm_common\zm_zonemgr;

#namespace zombie_brutus_util;

// Namespace zombie_brutus_util/ai_brutus_util
// Params 0, eflags: 0x2
// Checksum 0xa9472968, Offset: 0x268
// Size: 0x54
function autoexec __init__system__() {
    system::register(#"zombie_brutus_util", &__init__, &__main__, #"zm_ai_brutus");
}

// Namespace zombie_brutus_util/ai_brutus_util
// Params 0, eflags: 0x0
// Checksum 0x1bccf7be, Offset: 0x2c8
// Size: 0xc4
function __init__() {
    clientfield::register("actor", "brutus_lock_down", 1, 1, "int");
    level.var_20c2ed6c = getentarray("brutus_zombie_spawner", "script_noteworthy");
    if (level.var_20c2ed6c.size == 0) {
        assertmsg("<dev string:x30>");
        return;
    }
    /#
        thread function_586ffa94();
    #/
    level flag::init("brutus_setup_complete");
}

// Namespace zombie_brutus_util/ai_brutus_util
// Params 0, eflags: 0x0
// Checksum 0xfbb534ec, Offset: 0x398
// Size: 0x1c
function __main__() {
    level thread enable_brutus();
}

// Namespace zombie_brutus_util/ai_brutus_util
// Params 0, eflags: 0x0
// Checksum 0x81add2c1, Offset: 0x3c0
// Size: 0x30e
function enable_brutus() {
    array::thread_all(level.var_20c2ed6c, &spawner::add_spawn_function, &brutus_prespawn);
    for (i = 0; i < level.var_20c2ed6c.size; i++) {
        level.var_20c2ed6c[i].is_enabled = 1;
        level.var_20c2ed6c[i].script_forcespawn = 1;
    }
    level.var_c3308809 = struct::get_array("brutus_location", "script_noteworthy");
    level.var_c993a3d4 = 0;
    level.var_93e4807 = 500;
    level.brutus_round_count = 0;
    level.var_a78905e7 = 1;
    level.brutus_last_spawn_round = 0;
    level.brutus_count = 0;
    level.brutus_max_count = 4;
    level.brutus_damage_percent = 0.1;
    level.var_6aec1eb = 500;
    level.var_92a2ca43 = 250;
    level.brutus_points_for_helmet = 250;
    level.var_80d48b43 = 100;
    level.var_9cdb8818 = 100;
    level.var_220aa1a9 = 10;
    level.var_5d9caa5e = 200;
    level.var_d6fe62be = 4;
    level.var_bd692124 = 7;
    level.var_fd5ad83e = 1;
    level.var_8914aec8 = 120;
    level.var_dd502f59 = 0;
    level.var_bb9bf04c = 4;
    level.var_fb72eb39 = 600;
    level.var_94f7f085 = 4;
    level.brutus_do_prologue = 1;
    level.var_36fcdaa3 = 10;
    level.var_94e017f1 = 60;
    level.var_1e229d13 = 1;
    level.var_e20988c8 = 0;
    if (level.scr_zm_ui_gametype == "zgrief") {
        level.var_e20988c8 = 1;
    }
    level.var_a2884b8c = 48;
    level thread brutus_spawning_logic();
    if (!level.var_e20988c8) {
        level.custom_perk_validation = &check_perk_machine_valid;
        level.var_93b7659f = &check_craftable_table_valid;
    }
}

// Namespace zombie_brutus_util/ai_brutus_util
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x6d8
// Size: 0x4
function brutus_prespawn() {
    
}

// Namespace zombie_brutus_util/ai_brutus_util
// Params 0, eflags: 0x0
// Checksum 0xc104a31f, Offset: 0x6e8
// Size: 0x1a0
function brutus_spawning_logic() {
    if (!level.var_e20988c8) {
        level thread enable_brutus_rounds();
    }
    level thread function_10b061a6();
    while (true) {
        s_result = level waittill(#"spawn_brutus");
        n_spawn = s_result.n_spawn;
        if (n_spawn > 1) {
            level thread function_82cc702a(n_spawn, s_result.str_zone_name, s_result.var_8c4f6a1a);
            continue;
        }
        ai_brutus = zombie_utility::spawn_zombie(level.var_20c2ed6c[0]);
        if (isalive(ai_brutus)) {
            ai_brutus thread brutus_spawn(undefined, undefined, undefined, undefined, s_result.str_zone_name);
            if (!(isdefined(s_result.var_8c4f6a1a) && s_result.var_8c4f6a1a) && !(isdefined(level.var_1169d000) && level.var_1169d000)) {
                ai_brutus playsound(#"zmb_ai_brutus_spawn_2d");
            }
        }
    }
}

// Namespace zombie_brutus_util/ai_brutus_util
// Params 3, eflags: 0x4
// Checksum 0x59570de6, Offset: 0x890
// Size: 0x128
function private function_82cc702a(n_spawn, str_zone_name, var_8c4f6a1a) {
    level endon(#"end_of_round", #"end_game");
    var_28738408 = 0;
    while (var_28738408 < n_spawn) {
        ai_brutus = zombie_utility::spawn_zombie(level.var_20c2ed6c[0]);
        if (isdefined(ai_brutus)) {
            ai_brutus thread brutus_spawn(undefined, undefined, undefined, undefined, str_zone_name);
            if (!(isdefined(var_8c4f6a1a) && var_8c4f6a1a)) {
                ai_brutus playsound(#"zmb_ai_brutus_spawn_2d");
            }
            var_28738408++;
        }
        if (isdefined(level.var_a78905e7) && level.var_a78905e7) {
            wait randomfloatrange(15, 45);
        }
    }
}

// Namespace zombie_brutus_util/ai_brutus_util
// Params 0, eflags: 0x0
// Checksum 0x1c79404, Offset: 0x9c0
// Size: 0x5e
function zombie_setup_attack_properties() {
    self val::reset(#"attack_properties", "ignoreall");
    self.meleeattackdist = 64;
    self.maxsightdistsqrd = 16384;
    self.disablearrivals = 1;
    self.disableexits = 1;
}

// Namespace zombie_brutus_util/ai_brutus_util
// Params 5, eflags: 0x0
// Checksum 0xf679be47, Offset: 0xa28
// Size: 0x51e
function brutus_spawn(starting_health, has_helmet, var_83d10ab, var_5ad1fcf3, zone_name) {
    self endon(#"death");
    level.var_dd502f59 = 0;
    self.has_helmet = isdefined(has_helmet) ? has_helmet : 1;
    self.var_83d10ab = isdefined(var_83d10ab) ? var_83d10ab : 0;
    self.var_5ad1fcf3 = isdefined(var_5ad1fcf3) ? var_5ad1fcf3 : 0;
    self.starting_health = starting_health;
    self.no_damage_points = 1;
    self endon(#"death");
    level endon(#"intermission");
    self.animname = "brutus_zombie";
    self.var_5be6d71c = "brutus";
    self.has_legs = 1;
    self.is_brutus = 1;
    if (!(isdefined(level.var_c8a9f67f) && level.var_c8a9f67f)) {
        self.ignore_enemy_count = 1;
    }
    self.b_ignore_cleanup = 1;
    self.var_76b55fb2 = 0;
    self.var_a490243 = 1000;
    self.var_6fca76ea = 0;
    self setphysparams(20, 0, 60);
    self.zombie_init_done = 1;
    self notify(#"zombie_init_done");
    self.allowpain = 0;
    self animmode("normal");
    self orientmode("face enemy");
    self zombie_setup_attack_properties();
    self setfreecameralockonallowed(0);
    level thread zm_spawner::zombie_death_event(self);
    spawn_pos = get_best_brutus_spawn_pos(zone_name);
    if (isdefined(zone_name) && !isdefined(spawn_pos)) {
        a_str_active_zones = zm_zonemgr::get_active_zone_names();
        foreach (str_zone in a_str_active_zones) {
            spawn_pos = get_best_brutus_spawn_pos(str_zone);
            if (isdefined(spawn_pos)) {
                break;
            }
        }
    }
    if (!isdefined(spawn_pos)) {
        assertmsg("<dev string:x78>" + zone_name);
        self delete();
        level notify(#"brutus_spawn_failed");
        return;
    }
    if (!isdefined(spawn_pos.angles)) {
        spawn_pos.angles = (0, 0, 0);
    }
    if (isdefined(level.brutus_do_prologue) && level.brutus_do_prologue) {
        self brutus_spawn_prologue(spawn_pos);
    }
    if (!self.has_helmet) {
        self detach("c_t8_zmb_mob_brutus_helmet");
    }
    level.brutus_count++;
    self thread brutus_death();
    self thread brutus_check_zone();
    self thread brutus_watch_enemy();
    self forceteleport(spawn_pos.origin, spawn_pos.angles);
    self thread brutus_lockdown_client_effects(0.5);
    self thread zombie_utility::delayed_zombie_eye_glow();
    level notify(#"brutus_spawned", {#ai_brutus:self});
    util::wait_network_frame();
    self callback::callback(#"hash_6f9c2499f805be2f");
    if (isdefined(level.var_1169d000) && level.var_1169d000) {
        return;
    }
}

// Namespace zombie_brutus_util/ai_brutus_util
// Params 1, eflags: 0x0
// Checksum 0x5edc2c66, Offset: 0xf50
// Size: 0x15e
function get_best_brutus_spawn_pos(zone_name) {
    val = 0;
    for (i = 0; i < level.var_c3308809.size; i++) {
        if (isdefined(zone_name) && level.var_c3308809[i].zone_name != zone_name) {
            a_players_in_zone = zm_zonemgr::get_players_in_zone(zone_name, 1);
            if (a_players_in_zone.size) {
                continue;
            }
        }
        e_player_closest = arraygetclosest(level.var_c3308809[i].origin, level.players, 512);
        if (isdefined(e_player_closest)) {
            continue;
        }
        newval = get_brutus_spawn_pos_val(level.var_c3308809[i]);
        if (newval > val) {
            val = newval;
            pos_idx = i;
        }
    }
    if (isdefined(pos_idx)) {
        return level.var_c3308809[pos_idx];
    }
    return undefined;
}

// Namespace zombie_brutus_util/ai_brutus_util
// Params 1, eflags: 0x0
// Checksum 0xe149e7da, Offset: 0x10b8
// Size: 0x198
function get_brutus_spawn_pos_val(var_186f8191) {
    n_score = 0;
    zone_name = var_186f8191.zone_name;
    if (!zm_zonemgr::zone_is_enabled(zone_name)) {
        return 0;
    }
    if (!level.zones[zone_name].is_active) {
        return 0;
    }
    a_players_in_zone = zm_zonemgr::get_players_in_zone(zone_name, 1);
    n_score_addition = 1;
    for (i = 0; i < a_players_in_zone.size; i++) {
        if (self findpath(var_186f8191.origin, a_players_in_zone[i].origin, 0, 0)) {
            n_dist = distance2d(var_186f8191.origin, a_players_in_zone[i].origin);
            n_score_addition += math::linear_map(n_dist, 128, 4016, 0, level.var_8914aec8);
        }
    }
    if (n_score_addition > level.var_8914aec8) {
        n_score_addition = level.var_8914aec8;
    }
    n_score += n_score_addition;
    return n_score;
}

// Namespace zombie_brutus_util/ai_brutus_util
// Params 1, eflags: 0x0
// Checksum 0x2b41dcc2, Offset: 0x1258
// Size: 0x3a
function brutus_spawn_prologue(spawn_pos) {
    playsoundatposition(#"zmb_ai_brutus_prespawn", spawn_pos.origin);
    wait 3;
}

// Namespace zombie_brutus_util/ai_brutus_util
// Params 0, eflags: 0x0
// Checksum 0x40804370, Offset: 0x12a0
// Size: 0x7e
function function_10b061a6() {
    level flag::wait_till("start_zombie_round_logic");
    if (isdefined(level.chests)) {
        for (i = 0; i < level.chests.size; i++) {
            level.chests[i] thread wait_on_box_alarm();
        }
    }
}

// Namespace zombie_brutus_util/ai_brutus_util
// Params 0, eflags: 0x0
// Checksum 0x8a0c07c, Offset: 0x1328
// Size: 0x44
function enable_brutus_rounds() {
    level.var_44c77ba0 = 1;
    level flag::init("brutus_round");
    level thread brutus_round_tracker();
}

// Namespace zombie_brutus_util/ai_brutus_util
// Params 0, eflags: 0x0
// Checksum 0x72952db4, Offset: 0x1378
// Size: 0x23a
function brutus_round_tracker() {
    level.var_9602cc8f = level.round_number + randomintrange(level.var_d6fe62be, level.var_bd692124);
    old_spawn_func = level.round_spawn_func;
    old_wait_func = level.round_wait_func;
    while (true) {
        level waittill(#"between_round_over");
        players = getplayers();
        if (isdefined(level.next_dog_round) && level.next_dog_round == level.var_9602cc8f) {
            level.var_9602cc8f += 2;
        }
        if (level.round_number < 6 && isdefined(level.is_forever_solo_game) && level.is_forever_solo_game && !(isdefined(level.var_cda59884) && level.var_cda59884)) {
            if (level.var_9602cc8f < 6) {
                level.var_9602cc8f = 6;
            }
            continue;
        }
        if (level.var_9602cc8f <= level.round_number) {
            if (isdefined(level.var_cda59884) && level.var_cda59884) {
                level.var_cda59884 = undefined;
            } else {
                wait randomfloatrange(level.var_36fcdaa3, level.var_94e017f1);
            }
            if (attempt_brutus_spawn(function_ee5a6c0d())) {
                level.var_ffad36ea = 1;
                level.var_9602cc8f = level.round_number + randomintrange(level.var_d6fe62be, level.var_bd692124);
            }
        }
    }
}

// Namespace zombie_brutus_util/ai_brutus_util
// Params 0, eflags: 0x4
// Checksum 0xa4ee4270, Offset: 0x15c0
// Size: 0x76
function private function_ee5a6c0d() {
    if (level.round_number >= 30) {
        level.var_fd5ad83e = 4;
    } else if (level.round_number >= 25) {
        level.var_fd5ad83e = 3;
    } else if (level.round_number >= 17) {
        level.var_fd5ad83e = 2;
    }
    return level.var_fd5ad83e;
}

// Namespace zombie_brutus_util/ai_brutus_util
// Params 0, eflags: 0x0
// Checksum 0x447992ec, Offset: 0x1640
// Size: 0x36
function brutus_round_spawn_failsafe_respawn() {
    while (true) {
        wait 2;
        if (attempt_brutus_spawn(1)) {
            break;
        }
    }
}

// Namespace zombie_brutus_util/ai_brutus_util
// Params 3, eflags: 0x0
// Checksum 0xff636489, Offset: 0x1680
// Size: 0xcc
function attempt_brutus_spawn(var_1b655864, str_zone_name, var_8c4f6a1a = 0) {
    if (level.brutus_count + var_1b655864 > level.brutus_max_count) {
        /#
            iprintln("<dev string:xbd>");
        #/
        level thread function_fdb6607f();
        return false;
    }
    level notify(#"spawn_brutus", {#n_spawn:var_1b655864, #str_zone_name:str_zone_name, #var_8c4f6a1a:var_8c4f6a1a});
    return true;
}

// Namespace zombie_brutus_util/ai_brutus_util
// Params 0, eflags: 0x0
// Checksum 0xe8a7135d, Offset: 0x1758
// Size: 0x20
function function_fdb6607f() {
    waitframe(1);
    level notify(#"brutus_spawn_failed");
}

// Namespace zombie_brutus_util/ai_brutus_util
// Params 0, eflags: 0x0
// Checksum 0x9a5ecb70, Offset: 0x1780
// Size: 0x7f6
function brutus_death() {
    self endon(#"brutus_cleanup");
    self thread brutus_cleanup();
    if (level.var_e20988c8) {
        self thread brutus_cleanup_at_end_of_grief_round();
    }
    s_result = self waittill(#"death");
    if ((s_result.weapon == getweapon(#"ww_blundergat_t8") || s_result.weapon == getweapon(#"ww_blundergat_t8_upgraded") || s_result.weapon == getweapon(#"ww_blundergat_fire_t8") || s_result.weapon == getweapon(#"ww_blundergat_fire_t8_upgraded") || s_result.weapon == getweapon(#"ww_blundergat_acid_t8") || s_result.weapon == getweapon(#"ww_blundergat_acid_t8_upgraded") || s_result.weapon == getweapon(#"hash_494f5501b3f8e1e9")) && isplayer(s_result.attacker)) {
        s_result.attacker notify(#"hash_2e36f5f4d9622bb3", {#weapon:s_result.weapon});
    }
    level.brutus_count--;
    if (zombie_utility::get_current_zombie_count() == 0 && level.zombie_total == 0) {
        level.var_bf3a56e4 = self.origin;
        level notify(#"last_brutus_down");
        if (isdefined(self.var_37cb90a5) && self.var_37cb90a5) {
            level.var_9602cc8f = level.round_number + 1;
        }
    } else if (isdefined(self.var_37cb90a5) && self.var_37cb90a5) {
        level.zombie_total++;
        level.zombie_total_subtract++;
        level thread brutus_round_spawn_failsafe_respawn();
    }
    var_3a122e56 = 0;
    a_s_blueprints = zm_crafting::function_f941c8e0();
    foreach (s_blueprint in a_s_blueprints) {
        if (s_blueprint.var_29ca87bc == getweapon(#"zhield_spectral_dw")) {
            var_3a122e56 = 1;
            break;
        }
    }
    if (isdefined(level.crafting_components[#"zitem_spectral_shield_part_3"]) && !(isdefined(var_3a122e56) && var_3a122e56)) {
        w_component = zm_crafting::get_component(#"zitem_spectral_shield_part_3");
        if (!zm_items::player_has(level.players[0], w_component) && !(isdefined(self.var_fbe1f7e9) && self.var_fbe1f7e9)) {
            self.var_76b55fb2 = 1;
            self thread function_31ef0a02(w_component);
        }
    }
    if (!(isdefined(self.var_76b55fb2) && self.var_76b55fb2)) {
        if (!(isdefined(level.var_8cb70cfc) && level.var_8cb70cfc)) {
            if (level.powerup_drop_count >= level.zombie_vars[#"zombie_powerup_drop_max_per_round"]) {
                level.powerup_drop_count = level.zombie_vars[#"zombie_powerup_drop_max_per_round"] - 1;
            }
            level.zombie_vars[#"zombie_drop_item"] = 1;
            var_e54e36dc = groundtrace(self.origin + (0, 0, 8), self.origin + (0, 0, -100000), 0, self)[#"position"];
            level thread zm_powerups::powerup_drop(var_e54e36dc);
        }
    }
    if (isplayer(self.attacker)) {
        event = "death";
        if (level.var_e20988c8) {
            team_points = level.var_6aec1eb;
            player_points = level.var_92a2ca43;
            a_players = getplayers(self.team);
        } else {
            multiplier = zm_score::get_points_multiplier(self.attacker);
            team_points = multiplier * zm_utility::round_up_score(level.var_6aec1eb, 5);
            player_points = multiplier * zm_utility::round_up_score(level.var_92a2ca43, 5);
            a_players = getplayers();
        }
        foreach (player in a_players) {
            if (!zm_utility::is_player_valid(player)) {
                continue;
            }
            player zm_score::add_to_player_score(team_points);
            if (player == self.attacker) {
                player zm_score::add_to_player_score(player_points);
                level notify(#"brutus_killed", {#player:player});
            }
            player.pers[#"score"] = player.score;
            player zm_stats::increment_client_stat("prison_brutus_killed", 0);
        }
    }
    self notify(#"brutus_cleanup");
}

// Namespace zombie_brutus_util/ai_brutus_util
// Params 1, eflags: 0x0
// Checksum 0x381ad1ee, Offset: 0x1f80
// Size: 0x16c
function function_31ef0a02(w_component) {
    var_c32b05c2 = groundtrace(self.origin + (0, 0, 8), self.origin + (0, 0, -100000), 0, self)[#"position"];
    mdl_key = util::spawn_model(w_component.worldmodel, var_c32b05c2 + (0, 0, 36), self.angles);
    mdl_key endon(#"death");
    w_item = zm_items::spawn_item(w_component, var_c32b05c2 + (0, 0, 12), self.angles);
    w_item ghost();
    mdl_key thread function_a1acc3fa(w_item);
    mdl_key thread function_2dc369fa(w_item);
    while (isdefined(w_item)) {
        wait 0.25;
    }
    mdl_key delete();
}

// Namespace zombie_brutus_util/ai_brutus_util
// Params 1, eflags: 0x0
// Checksum 0x53b6f480, Offset: 0x20f8
// Size: 0x168
function function_a1acc3fa(w_item) {
    self endon(#"death");
    self clientfield::set("powerup_fx", 2);
    while (isdefined(w_item)) {
        waittime = randomfloatrange(2.5, 5);
        yaw = math::clamp(randomint(360), 60, 300);
        yaw = self.angles[1] + yaw;
        new_angles = (-60 + randomint(120), yaw, -45 + randomint(90));
        self rotateto(new_angles, waittime, waittime * 0.5, waittime * 0.5);
        wait randomfloat(waittime - 0.1);
    }
}

// Namespace zombie_brutus_util/ai_brutus_util
// Params 1, eflags: 0x0
// Checksum 0x35725e63, Offset: 0x2268
// Size: 0x12c
function function_2dc369fa(w_item) {
    self endon(#"death");
    wait 15;
    for (i = 0; i < 40; i++) {
        if (i % 2) {
            self ghost();
        } else {
            self show();
        }
        if (i < 15) {
            wait 0.5;
            continue;
        }
        if (i < 25) {
            wait 0.25;
            continue;
        }
        wait 0.1;
    }
    if (isdefined(w_item)) {
        w_item delete();
    }
    playfx(level._effect[#"powerup_grabbed_solo"], self.origin);
    self delete();
}

// Namespace zombie_brutus_util/ai_brutus_util
// Params 0, eflags: 0x0
// Checksum 0x464458bb, Offset: 0x23a0
// Size: 0xa2
function brutus_cleanup() {
    self waittill(#"brutus_cleanup");
    level.var_c993a3d4 = 0;
    if (isdefined(self.var_81efb511)) {
        self.var_81efb511 delete();
        self.var_81efb511 = undefined;
    }
    a_ai_brutus = getaiarchetypearray("brutus");
    if (a_ai_brutus.size) {
        level.brutus_count = a_ai_brutus.size;
        return;
    }
    level.brutus_count = 0;
}

// Namespace zombie_brutus_util/ai_brutus_util
// Params 0, eflags: 0x0
// Checksum 0xa92775ed, Offset: 0x2450
// Size: 0x74
function brutus_cleanup_at_end_of_grief_round() {
    self endon(#"death", #"brutus_cleanup");
    level waittill(#"keep_griefing", #"game_module_ended");
    self notify(#"brutus_cleanup");
    self delete();
}

// Namespace zombie_brutus_util/ai_brutus_util
// Params 0, eflags: 0x0
// Checksum 0x78c06ce4, Offset: 0x24d0
// Size: 0x196
function wait_on_box_alarm() {
    while (true) {
        self.zbarrier waittill(#"randomization_done");
        level.var_dd502f59++;
        if (level.var_e20988c8) {
            level.var_bb9bf04c = randomintrange(7, 10);
        }
        if (level.var_dd502f59 >= level.var_bb9bf04c) {
            rand = randomint(500);
            if (level.var_e20988c8) {
                attempt_brutus_spawn(1);
                continue;
            }
            if (rand <= level.var_80d48b43) {
                if (level flag::get("moving_chest_now")) {
                    continue;
                }
                if (attempt_brutus_spawn(1)) {
                    if (level.var_9602cc8f == level.round_number + 1) {
                        level.var_9602cc8f++;
                    }
                    level.var_80d48b43 = level.var_9cdb8818;
                }
                continue;
            }
            if (level.var_80d48b43 < level.var_5d9caa5e) {
                level.var_80d48b43 += level.var_220aa1a9;
            }
        }
    }
}

// Namespace zombie_brutus_util/ai_brutus_util
// Params 1, eflags: 0x0
// Checksum 0x624e4098, Offset: 0x2670
// Size: 0xa4
function check_perk_machine_valid(player) {
    if (isdefined(self.is_locked) && self.is_locked) {
        if (player.score >= self.var_e8bd0c39) {
            player zm_score::minus_to_player_score(self.var_e8bd0c39);
            self.is_locked = 0;
            self.var_e8bd0c39 = undefined;
            self.var_606c2099 delete();
            self zm_perks::reset_vending_hint_string();
        }
        return false;
    }
    return true;
}

// Namespace zombie_brutus_util/ai_brutus_util
// Params 1, eflags: 0x0
// Checksum 0x50bd28c, Offset: 0x2720
// Size: 0x18c
function check_craftable_table_valid(player) {
    if (!isdefined(self.stub) && isdefined(self.is_locked) && self.is_locked) {
        if (player.score >= self.var_e8bd0c39) {
            player zm_score::minus_to_player_score(self.var_e8bd0c39);
            self.is_locked = 0;
            self.var_e8bd0c39 = undefined;
            self.var_606c2099 delete();
        }
        return false;
    } else if (isdefined(self.stub) && isdefined(self.stub.is_locked) && self.stub.is_locked) {
        if (player.score >= self.stub.var_e8bd0c39) {
            player zm_score::minus_to_player_score(self.stub.var_e8bd0c39);
            self.stub.is_locked = 0;
            self.stub.var_e8bd0c39 = undefined;
            self.stub.var_606c2099 delete();
            self sethintstring(self.stub.hint_string);
        }
        return false;
    }
    return true;
}

// Namespace zombie_brutus_util/ai_brutus_util
// Params 0, eflags: 0x0
// Checksum 0xefc2d1f9, Offset: 0x28b8
// Size: 0x154
function brutus_check_zone() {
    self endon(#"death", #"brutus_cleanup");
    self.var_23fe9229 = 0;
    while (true) {
        self.var_23fe9229 = 0;
        foreach (zone in level.zones) {
            if (!isdefined(zone.volumes) || zone.volumes.size == 0) {
                continue;
            }
            zone_name = zone.volumes[0].targetname;
            if (self zm_zonemgr::entity_in_zone(zone_name)) {
                if (isdefined(zone.is_occupied) && zone.is_occupied) {
                    self.var_23fe9229 = 1;
                    break;
                }
            }
        }
        wait 0.2;
    }
}

// Namespace zombie_brutus_util/ai_brutus_util
// Params 0, eflags: 0x0
// Checksum 0x6a9c6f34, Offset: 0x2a18
// Size: 0xb0
function brutus_watch_enemy() {
    self endon(#"death", #"brutus_cleanup");
    level endon(#"end_game");
    while (true) {
        if (!zm_utility::is_player_valid(self.favoriteenemy)) {
            var_7f863ad5 = util::get_active_players();
            if (var_7f863ad5.size) {
                self.favoriteenemy = function_1b9b23b5(var_7f863ad5);
            }
        }
        wait 0.2;
    }
}

// Namespace zombie_brutus_util/ai_brutus_util
// Params 1, eflags: 0x4
// Checksum 0x507eac41, Offset: 0x2ad0
// Size: 0x11e
function private function_1b9b23b5(var_7f863ad5) {
    least_hunted = var_7f863ad5[0];
    for (i = 0; i < var_7f863ad5.size; i++) {
        if (isdefined(var_7f863ad5[i]) && !isdefined(var_7f863ad5[i].hunted_by)) {
            var_7f863ad5[i].hunted_by = 0;
        }
        if (!zm_utility::is_player_valid(var_7f863ad5[i])) {
            continue;
        }
        if (!zm_utility::is_player_valid(least_hunted)) {
            least_hunted = var_7f863ad5[i];
        }
        if (var_7f863ad5[i].hunted_by < least_hunted.hunted_by) {
            least_hunted = var_7f863ad5[i];
        }
    }
    least_hunted.hunted_by += 1;
    return least_hunted;
}

// Namespace zombie_brutus_util/ai_brutus_util
// Params 1, eflags: 0x0
// Checksum 0xe16dfcb6, Offset: 0x2bf8
// Size: 0xa4
function brutus_lockdown_client_effects(delay) {
    self endon(#"death", #"brutus_cleanup");
    if (isdefined(delay)) {
        wait delay;
    }
    if (self.var_6fca76ea) {
        self.var_6fca76ea = 0;
        self clientfield::set("brutus_lock_down", 0);
        return;
    }
    self.var_6fca76ea = 1;
    self clientfield::set("brutus_lock_down", 1);
}

// Namespace zombie_brutus_util/ai_brutus_util
// Params 0, eflags: 0x0
// Checksum 0x8dde5e33, Offset: 0x2ca8
// Size: 0x158
function function_778b6b29() {
    if (level.brutus_count == 0) {
        return;
    }
    a_e_brutus = getaiarchetypearray("brutus");
    foreach (e_brutus in a_e_brutus) {
        var_60ff90f4 = 0;
        foreach (e_player in level.activeplayers) {
            if (isdefined(zm_zonemgr::function_a5972886(e_player, e_brutus))) {
                var_60ff90f4 = 1;
                break;
            }
        }
        if (!var_60ff90f4) {
            level thread function_837ce2f(e_brutus);
        }
    }
}

// Namespace zombie_brutus_util/ai_brutus_util
// Params 1, eflags: 0x0
// Checksum 0x9260e777, Offset: 0x2e08
// Size: 0x6c
function function_837ce2f(e_brutus) {
    e_brutus notify(#"zombie_delete");
    e_brutus notify(#"brutus_cleanup");
    e_brutus delete();
    waitframe(1);
    attempt_brutus_spawn(1);
}

/#

    // Namespace zombie_brutus_util/ai_brutus_util
    // Params 0, eflags: 0x0
    // Checksum 0x9edbd1b7, Offset: 0x2e80
    // Size: 0x44
    function function_586ffa94() {
        zm_devgui::add_custom_devgui_callback(&function_bfadc49e);
        adddebugcommand("<dev string:xf9>");
    }

    // Namespace zombie_brutus_util/ai_brutus_util
    // Params 1, eflags: 0x0
    // Checksum 0xd5b5c0b4, Offset: 0x2ed0
    // Size: 0x72
    function function_bfadc49e(cmd) {
        switch (cmd) {
        case #"hash_4d20b9f9a8da7a33":
            level.var_cda59884 = 1;
            if (isdefined(level.var_9602cc8f)) {
                zm_devgui::zombie_devgui_goto_round(level.var_9602cc8f);
            }
            break;
        }
    }

#/
