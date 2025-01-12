#using scripts\core_common\ai\zombie_utility;
#using scripts\core_common\array_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\demo_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\flagsys_shared;
#using scripts\core_common\laststand_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\potm_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\bb;
#using scripts\zm_common\trials\zm_trial_no_powerups;
#using scripts\zm_common\zm_audio;
#using scripts\zm_common\zm_bgb;
#using scripts\zm_common\zm_customgame;
#using scripts\zm_common\zm_net;
#using scripts\zm_common\zm_score;
#using scripts\zm_common\zm_stats;
#using scripts\zm_common\zm_trial;
#using scripts\zm_common\zm_utility;
#using scripts\zm_common\zm_weapons;

#namespace zm_powerups;

// Namespace zm_powerups/zm_powerups
// Params 0, eflags: 0x0
// Checksum 0xa4f86ede, Offset: 0x468
// Size: 0x63c
function init() {
    zombie_utility::set_zombie_var(#"zombie_insta_kill", 0, undefined, undefined, 1);
    zombie_utility::set_zombie_var(#"zombie_drop_item", 0);
    zombie_utility::set_zombie_var(#"zombie_timer_offset", 350);
    zombie_utility::set_zombie_var(#"zombie_timer_offset_interval", 30);
    zombie_utility::set_zombie_var(#"zombie_powerup_fire_sale_on", 0);
    zombie_utility::set_zombie_var(#"zombie_powerup_fire_sale_time", 30);
    zombie_utility::set_zombie_var(#"zombie_powerup_bonfire_sale_on", 0);
    zombie_utility::set_zombie_var(#"zombie_powerup_bonfire_sale_time", 30);
    zombie_utility::set_zombie_var(#"zombie_powerup_insta_kill_on", 0, undefined, undefined, 1);
    zombie_utility::set_zombie_var(#"zombie_powerup_insta_kill_time", 30, undefined, undefined, 1);
    zombie_utility::set_zombie_var(#"zombie_powerup_double_points_on", 0, undefined, undefined, 1);
    zombie_utility::set_zombie_var(#"zombie_powerup_double_points_time", 30, undefined, undefined, 1);
    if (zm_custom::function_5638f689(#"zmpowerupsislimitedround")) {
        zombie_utility::set_zombie_var(#"zombie_powerup_drop_max_per_round", zm_custom::function_5638f689(#"zmpowerupslimitround"));
    } else {
        zombie_utility::set_zombie_var(#"zombie_powerup_drop_max_per_round", 4);
    }
    zombie_utility::set_zombie_var(#"hash_604cac237ec8cd3", 12);
    zombie_utility::set_zombie_var(#"hash_8b7fc80184dc451", 16);
    zombie_utility::set_zombie_var(#"hash_604cbc237ec8e86", 14);
    zombie_utility::set_zombie_var(#"hash_8b7f980184dbf38", 18);
    zombie_utility::set_zombie_var(#"hash_604ccc237ec9039", 17);
    zombie_utility::set_zombie_var(#"hash_8b7fa80184dc0eb", 21);
    zombie_utility::set_zombie_var(#"hash_604cdc237ec91ec", 20);
    zombie_utility::set_zombie_var(#"hash_8b7ff80184dc96a", 24);
    zombie_utility::set_zombie_var(#"hash_4d2cc817490bcca", 4);
    zombie_utility::set_zombie_var(#"hash_4edd68174a79580", 7);
    if (!isdefined(level.zombie_powerups)) {
        level.zombie_powerups = [];
    }
    level._effect[#"powerup_on"] = #"zombie/fx_powerup_on_green_zmb";
    level._effect[#"powerup_off"] = #"zombie/fx_powerup_off_green_zmb";
    level._effect[#"powerup_grabbed"] = #"zombie/fx_powerup_grab_green_zmb";
    if (isdefined(level.using_zombie_powerups) && level.using_zombie_powerups) {
        level._effect[#"powerup_on_red"] = #"zombie/fx_powerup_on_red_zmb";
        level._effect[#"powerup_grabbed_red"] = #"zombie/fx_powerup_grab_red_zmb";
    }
    level._effect[#"powerup_on_solo"] = #"zombie/fx_powerup_on_solo_zmb";
    level._effect[#"powerup_grabbed_solo"] = #"zombie/fx_powerup_grab_solo_zmb";
    level._effect[#"powerup_on_caution"] = #"zombie/fx_powerup_on_caution_zmb";
    level._effect[#"powerup_grabbed_caution"] = #"zombie/fx_powerup_grab_caution_zmb";
    init_powerups();
    if (!level.enable_magic || !zm_custom::function_5638f689(#"zmpowerupsactive")) {
        return;
    }
    thread watch_for_drop();
}

// Namespace zm_powerups/zm_powerups
// Params 0, eflags: 0x0
// Checksum 0x6922bdac, Offset: 0xab0
// Size: 0x23c
function init_powerups() {
    level flag::init("zombie_drop_powerups");
    if (isdefined(level.enable_magic) && level.enable_magic && isdefined(zm_custom::function_5638f689(#"zmpowerupsactive")) && zm_custom::function_5638f689(#"zmpowerupsactive")) {
        level flag::set("zombie_drop_powerups");
    }
    if (!isdefined(level.active_powerups)) {
        level.active_powerups = [];
    }
    add_zombie_powerup("insta_kill_ug", "zombie_skull", #"hash_1784640b956f2f85", &func_should_never_drop, 1, 0, 0, undefined, "powerup_instant_kill_ug", "zombie_powerup_insta_kill_ug_time", "zombie_powerup_insta_kill_ug_on", 1);
    if (isdefined(level.var_e34d2c13)) {
        [[ level.var_e34d2c13 ]]();
    }
    randomize_powerups();
    level.zombie_powerup_index = 0;
    randomize_powerups();
    level.rare_powerups_active = 0;
    level.var_bdd2f351 = randomintrange(zombie_utility::get_zombie_var(#"hash_4d2cc817490bcca"), zombie_utility::get_zombie_var(#"hash_4edd68174a79580"));
    level.firesale_vox_firstime = 0;
    level thread powerup_hud_monitor();
    clientfield::register("scriptmover", "powerup_fx", 1, 3, "int");
}

// Namespace zm_powerups/zm_powerups
// Params 1, eflags: 0x0
// Checksum 0x15edfc7a, Offset: 0xcf8
// Size: 0x42
function set_weapon_ignore_max_ammo(weapon) {
    if (!isdefined(level.zombie_weapons_no_max_ammo)) {
        level.zombie_weapons_no_max_ammo = [];
    }
    level.zombie_weapons_no_max_ammo[weapon] = 1;
}

// Namespace zm_powerups/zm_powerups
// Params 0, eflags: 0x0
// Checksum 0x5aa42382, Offset: 0xd48
// Size: 0x5d4
function powerup_hud_monitor() {
    level flag::wait_till("start_zombie_round_logic");
    if (isdefined(level.current_game_module) && level.current_game_module == 2) {
        return;
    }
    flashing_timers = [];
    flashing_values = [];
    flashing_timer = 10;
    flashing_delta_time = 0;
    flashing_is_on = 0;
    flashing_value = 3;
    flashing_min_timer = 0.15;
    while (flashing_timer >= flashing_min_timer) {
        if (flashing_timer < 5) {
            flashing_delta_time = 0.1;
        } else {
            flashing_delta_time = 0.2;
        }
        if (flashing_is_on) {
            flashing_timer = flashing_timer - flashing_delta_time - 0.05;
            flashing_value = 2;
        } else {
            flashing_timer -= flashing_delta_time;
            flashing_value = 3;
        }
        flashing_timers[flashing_timers.size] = flashing_timer;
        flashing_values[flashing_values.size] = flashing_value;
        flashing_is_on = !flashing_is_on;
    }
    client_fields = [];
    powerup_keys = getarraykeys(level.zombie_powerups);
    for (powerup_key_index = 0; powerup_key_index < powerup_keys.size; powerup_key_index++) {
        if (isdefined(level.zombie_powerups[powerup_keys[powerup_key_index]].client_field_name)) {
            powerup_name = powerup_keys[powerup_key_index];
            client_fields[powerup_name] = spawnstruct();
            client_fields[powerup_name].client_field_name = level.zombie_powerups[powerup_name].client_field_name;
            client_fields[powerup_name].only_affects_grabber = level.zombie_powerups[powerup_name].only_affects_grabber;
            client_fields[powerup_name].time_name = level.zombie_powerups[powerup_name].time_name;
            client_fields[powerup_name].on_name = level.zombie_powerups[powerup_name].on_name;
        }
    }
    client_field_keys = getarraykeys(client_fields);
    while (true) {
        waitframe(1);
        waittillframeend();
        players = level.players;
        for (playerindex = 0; playerindex < players.size; playerindex++) {
            for (client_field_key_index = 0; client_field_key_index < client_field_keys.size; client_field_key_index++) {
                player = players[playerindex];
                /#
                    if (isbot(player)) {
                        continue;
                    }
                #/
                if (player.team === #"spectator") {
                    continue;
                }
                if (isdefined(level.var_bef244e6)) {
                    if (![[ level.var_bef244e6 ]](player)) {
                        continue;
                    }
                }
                client_field_name = client_fields[client_field_keys[client_field_key_index]].client_field_name;
                time_name = client_fields[client_field_keys[client_field_key_index]].time_name;
                on_name = client_fields[client_field_keys[client_field_key_index]].on_name;
                powerup_timer = undefined;
                powerup_on = undefined;
                if (client_fields[client_field_keys[client_field_key_index]].only_affects_grabber && isdefined(player zombie_utility::get_zombie_var_player(time_name)) && isdefined(player zombie_utility::get_zombie_var_player(on_name))) {
                    powerup_timer = player.zombie_vars[time_name];
                    powerup_on = player.zombie_vars[on_name];
                } else if (isdefined(zombie_utility::get_zombie_var_team(time_name, player.team))) {
                    powerup_timer = zombie_utility::get_zombie_var_team(time_name, player.team);
                    powerup_on = zombie_utility::get_zombie_var_team(on_name, player.team);
                } else if (isdefined(zombie_utility::get_zombie_var(time_name))) {
                    powerup_timer = zombie_utility::get_zombie_var(time_name);
                    powerup_on = zombie_utility::get_zombie_var(on_name);
                }
                if (isdefined(powerup_timer) && isdefined(powerup_on)) {
                    player set_clientfield_powerups(client_field_name, powerup_timer, powerup_on, flashing_timers, flashing_values);
                    continue;
                }
                player clientfield::set_player_uimodel(client_field_name, 0);
            }
        }
    }
}

// Namespace zm_powerups/zm_powerups
// Params 5, eflags: 0x0
// Checksum 0xdd0f30f1, Offset: 0x1328
// Size: 0xfc
function set_clientfield_powerups(clientfield_name, powerup_timer, powerup_on, flashing_timers, flashing_values) {
    if (powerup_on) {
        if (powerup_timer < 10) {
            flashing_value = 3;
            for (i = flashing_timers.size - 1; i > 0; i--) {
                if (powerup_timer < flashing_timers[i]) {
                    flashing_value = flashing_values[i];
                    break;
                }
            }
            self clientfield::set_player_uimodel(clientfield_name, flashing_value);
        } else {
            self clientfield::set_player_uimodel(clientfield_name, 1);
        }
        return;
    }
    self clientfield::set_player_uimodel(clientfield_name, 0);
}

// Namespace zm_powerups/zm_powerups
// Params 0, eflags: 0x0
// Checksum 0x7ccd1d9c, Offset: 0x1430
// Size: 0x4e
function randomize_powerups() {
    if (!isdefined(level.zombie_powerup_array)) {
        level.zombie_powerup_array = [];
        return;
    }
    level.zombie_powerup_array = array::randomize(level.zombie_powerup_array);
}

// Namespace zm_powerups/zm_powerups
// Params 0, eflags: 0x0
// Checksum 0x49620c7d, Offset: 0x1488
// Size: 0x128
function get_next_powerup() {
    if (isdefined(level.var_b9008247)) {
        powerup = level.var_b9008247;
        level.var_b9008247 = undefined;
    } else if (level.var_bdd2f351 == 0 && zm_custom::function_5638f689(#"zmpowerupmaxammo") && isdefined(level.zombie_powerups[#"full_ammo"].func_should_drop_with_regular_powerups) && [[ level.zombie_powerups[#"full_ammo"].func_should_drop_with_regular_powerups ]]()) {
        powerup = "full_ammo";
    } else {
        powerup = level.zombie_powerup_array[level.zombie_powerup_index];
        level.zombie_powerup_index++;
        if (level.zombie_powerup_index >= level.zombie_powerup_array.size) {
            level.zombie_powerup_index = 0;
            randomize_powerups();
        }
    }
    return powerup;
}

// Namespace zm_powerups/zm_powerups
// Params 0, eflags: 0x0
// Checksum 0x4d068a9e, Offset: 0x15b8
// Size: 0x11a
function get_valid_powerup() {
    /#
        if (isdefined(level.zombie_devgui_power) && level.zombie_devgui_power == 1) {
            level.zombie_devgui_power = 0;
            return level.zombie_powerup_array[level.zombie_powerup_index];
        }
    #/
    if (isdefined(level.zombie_powerup_boss)) {
        i = level.zombie_powerup_boss;
        level.zombie_powerup_boss = undefined;
        return level.zombie_powerup_array[i];
    }
    if (isdefined(level.zombie_powerup_ape)) {
        str_powerup = level.zombie_powerup_ape;
        level.zombie_powerup_ape = undefined;
        return str_powerup;
    }
    while (true) {
        str_powerup = get_next_powerup();
        if (isdefined(level.zombie_powerups[str_powerup]) && [[ level.zombie_powerups[str_powerup].func_should_drop_with_regular_powerups ]]()) {
            return str_powerup;
        }
    }
}

// Namespace zm_powerups/zm_powerups
// Params 0, eflags: 0x0
// Checksum 0x9b805469, Offset: 0x16e0
// Size: 0xb8
function function_47ca4bc3() {
    if (!level.zombie_powerups.size) {
        return false;
    }
    foreach (str_powerup in level.zombie_powerup_array) {
        if (isdefined(level.zombie_powerups[str_powerup]) && [[ level.zombie_powerups[str_powerup].func_should_drop_with_regular_powerups ]]()) {
            return true;
        }
    }
    return false;
}

// Namespace zm_powerups/zm_powerups
// Params 0, eflags: 0x0
// Checksum 0xb056e2d, Offset: 0x17a0
// Size: 0xea
function minigun_no_drop() {
    players = getplayers();
    for (i = 0; i < players.size; i++) {
        if (players[i].zombie_vars[#"zombie_powerup_minigun_on"] == 1) {
            return true;
        }
    }
    if (!level flag::get("power_on")) {
        if (level flag::get("solo_game")) {
            if (!isdefined(level.solo_lives_given) || level.solo_lives_given == 0) {
                return true;
            }
        } else {
            return true;
        }
    }
    return false;
}

// Namespace zm_powerups/zm_powerups
// Params 0, eflags: 0x0
// Checksum 0x152a8309, Offset: 0x1898
// Size: 0x140
function watch_for_drop() {
    level endon(#"game_ended");
    level flag::wait_till("start_zombie_round_logic");
    level flag::wait_till("begin_spawning");
    waitframe(1);
    level.var_ccce14c8 = function_4b6d0e9a();
    if (!isdefined(level.n_total_kills)) {
        level.n_total_kills = 0;
    }
    while (true) {
        level flag::wait_till("zombie_drop_powerups");
        if (level.n_total_kills >= level.var_ccce14c8) {
            level function_ec348bd1();
            level.var_ccce14c8 = level.n_total_kills + function_4b6d0e9a();
            zombie_utility::set_zombie_var(#"zombie_drop_item", 1);
        }
        wait 0.5;
    }
}

// Namespace zm_powerups/zm_powerups
// Params 0, eflags: 0x0
// Checksum 0xe060191f, Offset: 0x19e0
// Size: 0x150
function function_4b6d0e9a() {
    a_e_players = getplayers();
    n_kill_count = randomintrangeinclusive(zombie_utility::get_zombie_var(#"hash_434b3261c607850" + a_e_players.size), zombie_utility::get_zombie_var(#"zombie_powerup_drop_max_" + a_e_players.size));
    if (zm_custom::function_5638f689(#"zmpowerupfrequency") == 0) {
        n_kill_count *= 2;
    } else if (zm_custom::function_5638f689(#"zmpowerupfrequency") == 2) {
        n_kill_count = floor(n_kill_count / 2);
    }
    if (zm_trial_no_powerups::is_active()) {
        n_kill_count /= zm_trial_no_powerups::function_3de4413();
    }
    if (n_kill_count < 1) {
        n_kill_count = 1;
    }
    return n_kill_count;
}

// Namespace zm_powerups/zm_powerups
// Params 0, eflags: 0x4
// Checksum 0x1f9b355f, Offset: 0x1b38
// Size: 0x13e
function private function_ec348bd1() {
    for (i = 1; i <= 4; i++) {
        zombie_utility::set_zombie_var(#"hash_434b3261c607850" + i, int(min(40, zombie_utility::get_zombie_var(#"hash_434b3261c607850" + i) + 1)));
        zombie_utility::set_zombie_var(#"zombie_powerup_drop_max_" + i, int(min(50, zombie_utility::get_zombie_var(#"zombie_powerup_drop_max_" + i) + 1)));
    }
}

// Namespace zm_powerups/zm_powerups
// Params 0, eflags: 0x0
// Checksum 0x6cdb7858, Offset: 0x1c80
// Size: 0x46
function get_random_powerup_name() {
    powerup_keys = getarraykeys(level.zombie_powerups);
    powerup_keys = array::randomize(powerup_keys);
    return powerup_keys[0];
}

// Namespace zm_powerups/zm_powerups
// Params 0, eflags: 0x0
// Checksum 0xf77e5a32, Offset: 0x1cd0
// Size: 0x9c
function get_regular_random_powerup_name() {
    powerup_keys = getarraykeys(level.zombie_powerups);
    powerup_keys = array::randomize(powerup_keys);
    for (i = 0; i < powerup_keys.size; i++) {
        if ([[ level.zombie_powerups[powerup_keys[i]].func_should_drop_with_regular_powerups ]]()) {
            return powerup_keys[i];
        }
    }
    return powerup_keys[0];
}

// Namespace zm_powerups/zm_powerups
// Params 0, eflags: 0x0
// Checksum 0x6b421fb7, Offset: 0x1d78
// Size: 0x1c
function function_b2585f85() {
    return util::get_game_type() != "zcleansed";
}

// Namespace zm_powerups/zm_powerups
// Params 13, eflags: 0x0
// Checksum 0x9a5a4461, Offset: 0x1da0
// Size: 0x46a
function add_zombie_powerup(powerup_name, model_name, hint, func_should_drop_with_regular_powerups, only_affects_grabber, any_team, zombie_grabbable, fx, client_field_name, time_name, on_name, clientfield_version = 1, player_specific = 0) {
    if (isdefined(level.zombie_include_powerups) && !(isdefined(level.zombie_include_powerups[powerup_name]) && level.zombie_include_powerups[powerup_name])) {
        return;
    }
    switch (powerup_name) {
    case #"full_ammo":
        str_rule = "zmPowerupMaxAmmo";
        break;
    case #"fire_sale":
        str_rule = "zmPowerupFireSale";
        break;
    case #"bonus_points_player_shared":
    case #"bonus_points_player":
    case #"bonus_points_team":
        str_rule = "zmPowerupChaosPoints";
        break;
    case #"free_perk":
        str_rule = "zmPowerupFreePerk";
        break;
    case #"nuke":
        str_rule = "zmPowerupNuke";
        break;
    case #"hero_weapon_power":
        str_rule = "zmPowerupSpecialWeapon";
        break;
    case #"insta_kill":
        str_rule = "zmPowerupInstakill";
        break;
    case #"double_points":
        str_rule = "zmPowerupDouble";
        break;
    case #"carpenter":
        str_rule = "zmPowerupCarpenter";
        break;
    default:
        str_rule = "";
        break;
    }
    if (str_rule != "" && !(isdefined(zm_custom::function_5638f689(str_rule)) && zm_custom::function_5638f689(str_rule))) {
        return;
    }
    if (!isdefined(level.zombie_powerup_array)) {
        level.zombie_powerup_array = [];
    }
    struct = spawnstruct();
    struct.powerup_name = powerup_name;
    struct.model_name = model_name;
    struct.weapon_classname = "script_model";
    struct.hint = hint;
    struct.func_should_drop_with_regular_powerups = func_should_drop_with_regular_powerups;
    struct.only_affects_grabber = only_affects_grabber;
    struct.any_team = any_team;
    struct.zombie_grabbable = zombie_grabbable;
    struct.hash_id = stathash(powerup_name);
    struct.player_specific = player_specific;
    struct.can_pick_up_in_last_stand = 1;
    if (isdefined(fx)) {
        struct.fx = fx;
    }
    level.zombie_powerups[powerup_name] = struct;
    level.zombie_powerup_array[level.zombie_powerup_array.size] = powerup_name;
    add_zombie_special_drop(powerup_name);
    if (isdefined(client_field_name)) {
        var_239542ef = "hudItems.zmPowerUps." + client_field_name + ".state";
        clientfield::register("clientuimodel", var_239542ef, clientfield_version, 2, "int");
        struct.client_field_name = var_239542ef;
        struct.time_name = time_name;
        struct.on_name = on_name;
    }
}

// Namespace zm_powerups/zm_powerups
// Params 2, eflags: 0x0
// Checksum 0xa7e4b526, Offset: 0x2218
// Size: 0x32
function powerup_set_can_pick_up_in_last_stand(powerup_name, b_can_pick_up) {
    level.zombie_powerups[powerup_name].can_pick_up_in_last_stand = b_can_pick_up;
}

// Namespace zm_powerups/zm_powerups
// Params 2, eflags: 0x0
// Checksum 0xc0776e37, Offset: 0x2258
// Size: 0x32
function powerup_set_prevent_pick_up_if_drinking(powerup_name, b_prevent_pick_up) {
    level._custom_powerups[powerup_name].prevent_pick_up_if_drinking = b_prevent_pick_up;
}

// Namespace zm_powerups/zm_powerups
// Params 2, eflags: 0x0
// Checksum 0x9a38013d, Offset: 0x2298
// Size: 0x42
function powerup_set_player_specific(powerup_name, b_player_specific = 1) {
    level.zombie_powerups[powerup_name].player_specific = b_player_specific;
}

// Namespace zm_powerups/zm_powerups
// Params 1, eflags: 0x0
// Checksum 0xfdeb466, Offset: 0x22e8
// Size: 0x42
function powerup_set_statless_powerup(powerup_name) {
    if (!isdefined(level.zombie_statless_powerups)) {
        level.zombie_statless_powerups = [];
    }
    level.zombie_statless_powerups[powerup_name] = 1;
}

// Namespace zm_powerups/zm_powerups
// Params 1, eflags: 0x0
// Checksum 0xb6c46298, Offset: 0x2338
// Size: 0x46
function add_zombie_special_drop(powerup_name) {
    if (!isdefined(level.zombie_special_drop_array)) {
        level.zombie_special_drop_array = [];
    }
    level.zombie_special_drop_array[level.zombie_special_drop_array.size] = powerup_name;
}

// Namespace zm_powerups/zm_powerups
// Params 1, eflags: 0x0
// Checksum 0x22abc5e, Offset: 0x2388
// Size: 0x42
function include_zombie_powerup(powerup_name) {
    if (!isdefined(level.zombie_include_powerups)) {
        level.zombie_include_powerups = [];
    }
    level.zombie_include_powerups[powerup_name] = 1;
}

// Namespace zm_powerups/zm_powerups
// Params 1, eflags: 0x0
// Checksum 0xd73b456, Offset: 0x23d8
// Size: 0x5a
function powerup_remove_from_regular_drops(powerup_name) {
    if (!isdefined(level.zombie_powerups) || !isdefined(level.zombie_powerups[powerup_name])) {
        return;
    }
    level.zombie_powerups[powerup_name].func_should_drop_with_regular_powerups = &func_should_never_drop;
}

// Namespace zm_powerups/zm_powerups
// Params 1, eflags: 0x0
// Checksum 0x5d4532f1, Offset: 0x2440
// Size: 0xaa
function function_b355fdc4(powerup_name) {
    if (!isdefined(level.zombie_powerups) || !isdefined(level.zombie_powerups[powerup_name]) || isdefined(level.zombie_powerups[powerup_name].var_b8d6b9ac)) {
        return;
    }
    level.zombie_powerups[powerup_name].var_b8d6b9ac = level.zombie_powerups[powerup_name].func_should_drop_with_regular_powerups;
    level.zombie_powerups[powerup_name].func_should_drop_with_regular_powerups = &func_should_never_drop;
}

// Namespace zm_powerups/zm_powerups
// Params 1, eflags: 0x0
// Checksum 0xa6160f4e, Offset: 0x24f8
// Size: 0x9a
function function_ca7b76b1(powerup_name) {
    if (!isdefined(level.zombie_powerups) || !isdefined(level.zombie_powerups[powerup_name]) || !isdefined(level.zombie_powerups[powerup_name].var_b8d6b9ac)) {
        return;
    }
    level.zombie_powerups[powerup_name].func_should_drop_with_regular_powerups = level.zombie_powerups[powerup_name].var_b8d6b9ac;
    level.zombie_powerups[powerup_name].var_b8d6b9ac = undefined;
}

// Namespace zm_powerups/zm_powerups
// Params 0, eflags: 0x0
// Checksum 0x2b79b480, Offset: 0x25a0
// Size: 0x12
function powerup_round_start() {
    level.powerup_drop_count = 0;
}

// Namespace zm_powerups/zm_powerups
// Params 1, eflags: 0x0
// Checksum 0xd6ff5401, Offset: 0x25c0
// Size: 0x580
function powerup_drop(drop_point) {
    if (zm_custom::function_3f3efa0c()) {
        return;
    }
    if (isdefined(level.var_805d0ecc)) {
        b_outcome = [[ level.var_805d0ecc ]](drop_point);
        if (isdefined(b_outcome) && b_outcome) {
            return;
        }
    }
    if (level.powerup_drop_count >= zombie_utility::get_zombie_var(#"zombie_powerup_drop_max_per_round")) {
        println("<dev string:x30>");
        return;
    }
    if (!isdefined(level.zombie_include_powerups) || level.zombie_include_powerups.size == 0 || !function_47ca4bc3()) {
        return;
    }
    var_5da59d5c = randomint(100);
    if (bgb::is_team_enabled(#"zm_bgb_power_vacuum") && var_5da59d5c < 20) {
        /#
            debug = "<dev string:x5b>";
        #/
    } else {
        if (!zombie_utility::get_zombie_var(#"zombie_drop_item")) {
            return;
        }
        /#
            debug = "<dev string:x6f>";
        #/
    }
    if (zm_utility::function_be4cf12d() && !isdefined(level.var_4b530519)) {
        level.var_4b530519 = getnodearray("player_region", "script_noteworthy");
    }
    if (zm_utility::function_a70772a9() && !isdefined(level.playable_area)) {
        level.playable_area = getentarray("player_volume", "script_noteworthy");
    }
    level.powerup_drop_count++;
    powerup = zm_net::network_safe_spawn("powerup", 1, "script_model", drop_point + (0, 0, 40));
    powerup setmodel(#"tag_origin");
    valid_drop = 0;
    if (isdefined(level.var_4b530519)) {
        node = function_e910fb8c(powerup.origin, level.var_4b530519, 500);
        if (isdefined(node)) {
            valid_drop = 1;
        }
    }
    if (isdefined(level.playable_area) && !valid_drop) {
        for (i = 0; i < level.playable_area.size; i++) {
            if (powerup istouching(level.playable_area[i])) {
                valid_drop = 1;
                break;
            }
        }
    }
    if (valid_drop && level.rare_powerups_active) {
        pos = (drop_point[0], drop_point[1], drop_point[2] + 42);
        if (check_for_rare_drop_override(pos)) {
            zombie_utility::set_zombie_var(#"zombie_drop_item", 0);
            valid_drop = 0;
        }
    }
    if (!valid_drop) {
        level.powerup_drop_count--;
        powerup delete();
        return;
    }
    powerup powerup_setup(undefined, undefined, drop_point);
    /#
        print_powerup_drop(powerup.powerup_name, debug);
    #/
    bb::logpowerupevent(powerup, undefined, "_dropped");
    powerup thread powerup_timeout();
    powerup thread powerup_wobble();
    powerup util::delay(function_93dbe4ec(drop_point), "powerup_timedout", &powerup_grab);
    powerup thread function_6627e739();
    powerup thread powerup_emp();
    zombie_utility::set_zombie_var(#"zombie_drop_item", 0);
    level notify(#"powerup_dropped", {#powerup:powerup});
}

// Namespace zm_powerups/zm_powerups
// Params 7, eflags: 0x0
// Checksum 0xfe336222, Offset: 0x2b48
// Size: 0x322
function specific_powerup_drop(powerup_name, powerup_location, powerup_team, pickup_delay, powerup_player, b_stay_forever, var_b32cdad1 = 0) {
    if (!var_b32cdad1 && zm_custom::function_3f3efa0c() || !zm_custom::function_5638f689(#"zmpowerupsactive")) {
        return;
    }
    switch (powerup_name) {
    case #"full_ammo":
        str_rule = "zmPowerupMaxAmmo";
        break;
    case #"fire_sale":
        str_rule = "zmPowerupFireSale";
        break;
    case #"bonus_points_player_shared":
    case #"bonus_points_player":
    case #"bonus_points_team":
        str_rule = "zmPowerupChaosPoints";
        break;
    case #"free_perk":
        str_rule = "zmPowerupFreePerk";
        break;
    case #"nuke":
        str_rule = "zmPowerupNuke";
        break;
    case #"hero_weapon_power":
        str_rule = "zmPowerupSpecialWeapon";
        break;
    case #"insta_kill":
        str_rule = "zmPowerupInstakill";
        break;
    case #"double_points":
        str_rule = "zmPowerupDouble";
        break;
    case #"carpenter":
        str_rule = "zmPowerupCarpenter";
        break;
    default:
        str_rule = "";
        break;
    }
    if (str_rule != "" && !(isdefined(zm_custom::function_5638f689(str_rule)) && zm_custom::function_5638f689(str_rule))) {
        return;
    }
    powerup = zm_net::network_safe_spawn("powerup", 1, "script_model", powerup_location + (0, 0, 40));
    powerup setmodel(#"tag_origin");
    powerup_location = powerup.origin;
    pickup_delay = 0.1;
    level notify(#"powerup_dropped", {#powerup:powerup});
    return powerup_init(powerup, powerup_name, powerup_team, powerup_location, pickup_delay, powerup_player, b_stay_forever);
}

// Namespace zm_powerups/zm_powerups
// Params 6, eflags: 0x0
// Checksum 0xadbc205, Offset: 0x2e78
// Size: 0x24a
function function_357c4995(var_537996cf, powerup_location, powerup_team, pickup_delay, powerup_player, b_stay_forever) {
    if (zm_custom::function_3f3efa0c()) {
        return;
    }
    if (isactor(self) && !level flag::get("zombie_drop_powerups")) {
        return;
    }
    var_a06d0b75 = array();
    foreach (str_powerup in var_537996cf) {
        if (isdefined(level.zombie_powerups[str_powerup])) {
            if ([[ level.zombie_powerups[str_powerup].func_should_drop_with_regular_powerups ]]()) {
                array::add(var_a06d0b75, str_powerup);
            }
        }
    }
    if (!var_a06d0b75.size) {
        return;
    }
    powerup = zm_net::network_safe_spawn("powerup", 1, "script_model", powerup_location + (0, 0, 40));
    powerup setmodel(#"tag_origin");
    level notify(#"powerup_dropped", {#powerup:powerup});
    str_powerup = array::random(var_a06d0b75);
    powerup_location = powerup.origin;
    pickup_delay = function_93dbe4ec(powerup_location);
    return powerup_init(powerup, str_powerup, powerup_team, powerup_location, pickup_delay, powerup_player, b_stay_forever);
}

// Namespace zm_powerups/zm_powerups
// Params 7, eflags: 0x0
// Checksum 0xd022e4c0, Offset: 0x30d0
// Size: 0x13a
function powerup_init(powerup, str_powerup, powerup_team, powerup_location, pickup_delay, powerup_player, b_stay_forever) {
    if (isdefined(powerup)) {
        powerup powerup_setup(str_powerup, powerup_team, powerup_location, powerup_player, pickup_delay);
        if (!(isdefined(b_stay_forever) && b_stay_forever)) {
            powerup thread powerup_timeout();
        }
        powerup thread powerup_wobble();
        if (isdefined(pickup_delay) && pickup_delay < 0.1) {
            pickup_delay = 0.1;
        }
        powerup util::delay(pickup_delay, "powerup_timedout", &powerup_grab, powerup_team);
        powerup thread function_6627e739();
        powerup thread powerup_emp();
        return powerup;
    }
}

// Namespace zm_powerups/zm_powerups
// Params 5, eflags: 0x0
// Checksum 0xfb7de9de, Offset: 0x3218
// Size: 0x174
function function_2b4fb695(str_powerup, powerup_team, powerup_location, powerup_player, pickup_delay) {
    var_fe2dafd1 = 60;
    var_7132298e = 120;
    var_7244859e = 6;
    if (str_powerup === "nuke") {
        name = string(randomint(2147483647));
        origin = self.origin;
        badplace_cylinder(name, 0, origin, var_fe2dafd1, var_7132298e, #"allies");
        while (isdefined(self)) {
            if (distance2dsquared(origin, self.origin) > var_7244859e * var_7244859e) {
                origin = self.origin;
                badplace_cylinder(name, 0, origin, var_fe2dafd1, var_7132298e, #"allies");
            }
            wait 1;
        }
        badplace_delete(name);
    }
}

// Namespace zm_powerups/zm_powerups
// Params 6, eflags: 0x0
// Checksum 0xf1e0dac8, Offset: 0x3398
// Size: 0x4bc
function powerup_setup(powerup_override, powerup_team, powerup_location, powerup_player, shouldplaysound = 1, pickup_delay) {
    powerup = undefined;
    if (!isdefined(powerup_override)) {
        powerup = get_valid_powerup();
    } else {
        powerup = powerup_override;
        if ("tesla" == powerup && tesla_powerup_active()) {
            powerup = "minigun";
        }
    }
    struct = level.zombie_powerups[powerup];
    if (isdefined(level._custom_powerups) && isdefined(level._custom_powerups[powerup]) && isdefined(level._custom_powerups[powerup].setup_powerup)) {
        self [[ level._custom_powerups[powerup].setup_powerup ]]();
    } else {
        self thread function_45b9317d(function_93dbe4ec(powerup_location), struct.model_name);
    }
    if (powerup == "full_ammo") {
        level.var_bdd2f351 = randomintrange(zombie_utility::get_zombie_var(#"hash_4d2cc817490bcca"), zombie_utility::get_zombie_var(#"hash_4edd68174a79580"));
    } else if (!isdefined(powerup_override)) {
        level.var_bdd2f351--;
    }
    demo::bookmark(#"zm_powerup_dropped", gettime(), undefined, undefined, 1);
    potm::bookmark(#"zm_powerup_dropped", gettime(), undefined, undefined, 1);
    if (isdefined(powerup_team)) {
        self.powerup_team = powerup_team;
    }
    if (isdefined(powerup_location)) {
        self.powerup_location = powerup_location;
    }
    if (isdefined(powerup_player)) {
        self.powerup_player = powerup_player;
    } else {
        assert(!(isdefined(struct.player_specific) && struct.player_specific), "<dev string:x74>");
    }
    self.powerup_name = struct.powerup_name;
    self.hint = struct.hint;
    self.only_affects_grabber = struct.only_affects_grabber;
    self.any_team = struct.any_team;
    self.zombie_grabbable = struct.zombie_grabbable;
    self.func_should_drop_with_regular_powerups = struct.func_should_drop_with_regular_powerups;
    if (isdefined(struct.fx)) {
        self.fx = struct.fx;
    }
    if (isdefined(struct.can_pick_up_in_last_stand)) {
        self.can_pick_up_in_last_stand = struct.can_pick_up_in_last_stand;
    }
    var_5bdbf85 = isdefined(struct.var_fe9267ed) ? struct.var_fe9267ed : 0;
    if (!(isdefined(var_5bdbf85) && var_5bdbf85)) {
        if ((powerup == "bonus_points_player" || powerup == "bonus_points_player_shared") && zm_utility::is_standard()) {
            self playsound(#"hash_1229e9d60b3181ef");
            self playloopsound(#"hash_46b9bf1ae523021c");
        } else {
            self playsound(#"zmb_spawn_powerup");
            self playloopsound(#"zmb_spawn_powerup_loop");
        }
    }
    level.active_powerups[level.active_powerups.size] = self;
    self thread function_2b4fb695(powerup, powerup_team, powerup_location, powerup_player, pickup_delay);
}

// Namespace zm_powerups/zm_powerups
// Params 1, eflags: 0x0
// Checksum 0xebeaa77a, Offset: 0x3860
// Size: 0x54
function powerup_zombie_grab_trigger_cleanup(trigger) {
    self waittill(#"powerup_timedout", #"powerup_grabbed", #"hacked");
    trigger delete();
}

// Namespace zm_powerups/zm_powerups
// Params 1, eflags: 0x0
// Checksum 0xdef07ae3, Offset: 0x38c0
// Size: 0x3ca
function powerup_zombie_grab(powerup_team) {
    self endon(#"powerup_timedout", #"powerup_grabbed", #"hacked");
    zombie_grab_trigger = spawn("trigger_radius", self.origin - (0, 0, 40), (512 | 1) + 8, 32, 72);
    zombie_grab_trigger enablelinkto();
    zombie_grab_trigger linkto(self);
    zombie_grab_trigger setteamfortrigger(level.zombie_team);
    self thread powerup_zombie_grab_trigger_cleanup(zombie_grab_trigger);
    poi_dist = 300;
    if (isdefined(level._zombie_grabbable_poi_distance_override)) {
        poi_dist = level._zombie_grabbable_poi_distance_override;
    }
    zombie_grab_trigger zm_utility::create_zombie_point_of_interest(poi_dist, 2, 0, 1, undefined, undefined, powerup_team);
    while (isdefined(self)) {
        waitresult = zombie_grab_trigger waittill(#"trigger");
        who = waitresult.activator;
        if (isdefined(level.var_352c26bc)) {
            if (!self [[ level.var_352c26bc ]](who)) {
                continue;
            }
        } else if (!isdefined(who) || !isai(who)) {
            continue;
        }
        playfx(level._effect[#"powerup_grabbed_red"], self.origin);
        if (isdefined(who)) {
            who playsound(#"zmb_powerup_grabbed");
        }
        self stoploopsound();
        if (isdefined(level._custom_powerups) && isdefined(level._custom_powerups[self.powerup_name]) && isdefined(level._custom_powerups[self.powerup_name].grab_powerup)) {
            b_continue = self [[ level._custom_powerups[self.powerup_name].grab_powerup ]]();
            if (isdefined(b_continue) && b_continue) {
                continue;
            }
        } else {
            if (isdefined(level._zombiemode_powerup_zombie_grab)) {
                level thread [[ level._zombiemode_powerup_zombie_grab ]](self);
            }
            if (isdefined(level._game_mode_powerup_zombie_grab)) {
                level thread [[ level._game_mode_powerup_zombie_grab ]](self, who);
            } else {
                println("<dev string:xad>");
            }
        }
        level thread zm_audio::sndannouncerplayvox(self.powerup_name);
        wait 0.1;
        self thread powerup_delete_delayed();
        self notify(#"powerup_grabbed", {#e_grabber:who});
    }
}

// Namespace zm_powerups/zm_powerups
// Params 1, eflags: 0x0
// Checksum 0xf38eacc4, Offset: 0x3c98
// Size: 0xab4
function powerup_grab(powerup_team) {
    if (isdefined(self) && self.zombie_grabbable) {
        self thread powerup_zombie_grab(powerup_team);
        return;
    }
    self endon(#"powerup_timedout", #"powerup_grabbed", #"powerup_stolen");
    range_squared = 4096;
    while (isdefined(self)) {
        if (isdefined(self.powerup_player)) {
            grabbers = [];
            grabbers[0] = self.powerup_player;
        } else if (isdefined(level.var_661e1459)) {
            grabbers = [[ level.var_661e1459 ]]();
        } else {
            grabbers = getplayers();
        }
        for (i = 0; i < grabbers.size; i++) {
            grabber = grabbers[i];
            if (isalive(grabber.owner) && isplayer(grabber.owner)) {
                player = grabber.owner;
            } else if (isplayer(grabber)) {
                player = grabber;
            }
            if (self.only_affects_grabber && !isdefined(player)) {
                continue;
            }
            if (player zm_utility::is_drinking() && isdefined(level._custom_powerups) && isdefined(level._custom_powerups[self.powerup_name]) && isdefined(level._custom_powerups[self.powerup_name].prevent_pick_up_if_drinking) && level._custom_powerups[self.powerup_name].prevent_pick_up_if_drinking) {
                continue;
            }
            if ((self.powerup_name == "minigun" || self.powerup_name == "tesla" || self.powerup_name == "random_weapon" || self.powerup_name == "meat_stink") && (!isplayer(grabber) || player laststand::player_is_in_laststand() || player usebuttonpressed() && player zm_utility::in_revive_trigger() || player bgb::is_enabled(#"zm_bgb_disorderly_combat"))) {
                continue;
            }
            if (!(isdefined(self.can_pick_up_in_last_stand) && self.can_pick_up_in_last_stand) && player laststand::player_is_in_laststand()) {
                continue;
            }
            ignore_range = 0;
            if (grabber.ignore_range_powerup === self) {
                grabber.ignore_range_powerup = undefined;
                ignore_range = 1;
            }
            if (distancesquared(grabber.origin, self.origin) < range_squared || ignore_range) {
                if (isdefined(level.var_352c26bc)) {
                    if (!self [[ level.var_352c26bc ]](player)) {
                        continue;
                    }
                }
                if (zm_trial_no_powerups::is_active()) {
                    var_9fb91af5 = [];
                    array::add(var_9fb91af5, player, 0);
                    zm_trial::fail(#"hash_2619fd380423798b", var_9fb91af5);
                    self thread powerup_delete_delayed();
                    self notify(#"powerup_grabbed", {#e_grabber:player});
                    return;
                }
                if (isdefined(level._custom_powerups) && isdefined(level._custom_powerups[self.powerup_name]) && isdefined(level._custom_powerups[self.powerup_name].grab_powerup)) {
                    b_continue = self [[ level._custom_powerups[self.powerup_name].grab_powerup ]](player);
                    if (isdefined(b_continue) && b_continue) {
                        continue;
                    }
                } else {
                    switch (self.powerup_name) {
                    case #"teller_withdrawl":
                        level thread teller_withdrawl(self, player);
                        break;
                    default:
                        if (isdefined(level._zombiemode_powerup_grab)) {
                            level thread [[ level._zombiemode_powerup_grab ]](self, player);
                        } else {
                            println("<dev string:xad>");
                        }
                        break;
                    }
                }
                demo::bookmark(#"zm_player_powerup_grabbed", gettime(), player);
                potm::bookmark(#"zm_player_powerup_grabbed", gettime(), player);
                bb::logpowerupevent(self, player, "_grabbed");
                if (isdefined(self.hash_id)) {
                    player recordmapevent(23, gettime(), grabber.origin, level.round_number, self.hash_id);
                }
                if (should_award_stat(self.powerup_name) && isplayer(player)) {
                    player zm_stats::increment_client_stat("drops");
                    player zm_stats::increment_player_stat("drops");
                    player zm_stats::increment_client_stat(self.powerup_name + "_pickedup");
                    player zm_stats::increment_player_stat(self.powerup_name + "_pickedup");
                    player zm_stats::increment_challenge_stat("SURVIVALIST_POWERUP");
                }
                if (isdefined(level.var_bcdda478)) {
                    self thread [[ level.var_bcdda478 ]]();
                } else if (self.only_affects_grabber) {
                    playfx(level._effect[#"powerup_grabbed_solo"], self.origin);
                } else if (self.any_team) {
                    playfx(level._effect[#"powerup_grabbed_caution"], self.origin);
                } else {
                    playfx(level._effect[#"powerup_grabbed"], self.origin);
                }
                if (isdefined(self.stolen) && self.stolen) {
                    level notify(#"monkey_see_monkey_dont_achieved");
                }
                if (isdefined(self.grabbed_level_notify)) {
                    level notify(self.grabbed_level_notify);
                }
                if ((self.powerup_name == "bonus_points_player" || self.powerup_name == "bonus_points_player_shared") && zm_utility::is_standard()) {
                    player playsound(#"hash_6c0682a7e4e26b09");
                } else {
                    player playsound(#"zmb_powerup_grabbed");
                }
                self.claimed = 1;
                self.power_up_grab_player = player;
                wait 0.1;
                self stoploopsound();
                self hide();
                if (self.powerup_name != "fire_sale") {
                    if (isdefined(self.power_up_grab_player)) {
                        if (isdefined(level.powerup_intro_vox)) {
                            level thread [[ level.powerup_intro_vox ]](self);
                            return;
                        } else if (isdefined(level.powerup_vo_available)) {
                            can_say_vo = [[ level.powerup_vo_available ]]();
                            if (!can_say_vo) {
                                self thread powerup_delete_delayed();
                                self notify(#"powerup_grabbed", {#e_grabber:player});
                                return;
                            }
                        }
                    }
                }
                if (isdefined(self.only_affects_grabber) && self.only_affects_grabber) {
                    level thread zm_audio::sndannouncerplayvox(self.powerup_name, player);
                } else {
                    level thread zm_audio::sndannouncerplayvox(self.powerup_name);
                }
                self thread powerup_delete_delayed();
                self notify(#"powerup_grabbed", {#e_grabber:player});
            }
        }
        wait 0.1;
    }
}

// Namespace zm_powerups/zm_powerups
// Params 1, eflags: 0x0
// Checksum 0xf7fd7c49, Offset: 0x4758
// Size: 0xf2
function function_93dbe4ec(var_92968756) {
    e_player = zm_utility::get_closest_player(var_92968756);
    if (isdefined(level.var_751b1aad) && level.var_751b1aad) {
        return 0.1;
    }
    if (!isdefined(e_player)) {
        return 1.5;
    }
    n_distance = distance(e_player.origin, var_92968756);
    if (n_distance > 128) {
        return 0.1;
    } else if (n_distance < 8) {
        return 1.5;
    }
    n_delay = math::linear_map(n_distance, 8, 128, 1.5, 0);
    return n_delay;
}

// Namespace zm_powerups/zm_powerups
// Params 2, eflags: 0x0
// Checksum 0x46678b66, Offset: 0x4858
// Size: 0x9c
function function_45b9317d(n_duration = 1.5, str_model) {
    self endon(#"powerup_grabbed");
    if (!(isdefined(level.var_751b1aad) && level.var_751b1aad)) {
        self function_570a79c5();
        wait n_duration;
        self notify(#"hash_d5e9f3685aed71b");
    }
    self setmodel(str_model);
}

// Namespace zm_powerups/zm_powerups
// Params 0, eflags: 0x0
// Checksum 0xa70e9615, Offset: 0x4900
// Size: 0x10a
function function_570a79c5() {
    self endon(#"hash_d5e9f3685aed71b");
    a_s_powerups = array::randomize(level.zombie_powerups);
    while (true) {
        var_f026e762 = 0;
        foreach (s_powerup in a_s_powerups) {
            if ([[ s_powerup.func_should_drop_with_regular_powerups ]]()) {
                self setmodel(s_powerup.model_name);
                var_f026e762++;
            }
            wait 0.1;
        }
        if (var_f026e762 < 2) {
            return;
        }
    }
}

// Namespace zm_powerups/zm_powerups
// Params 2, eflags: 0x0
// Checksum 0x61967b07, Offset: 0x4a18
// Size: 0x11c
function get_closest_window_repair(windows, origin) {
    current_window = undefined;
    shortest_distance = undefined;
    for (i = 0; i < windows.size; i++) {
        if (zm_utility::all_chunks_intact(windows, windows[i].barrier_chunks)) {
            continue;
        }
        if (!isdefined(current_window)) {
            current_window = windows[i];
            shortest_distance = distancesquared(current_window.origin, origin);
            continue;
        }
        if (distancesquared(windows[i].origin, origin) < shortest_distance) {
            current_window = windows[i];
            shortest_distance = distancesquared(windows[i].origin, origin);
        }
    }
    return current_window;
}

// Namespace zm_powerups/zm_powerups
// Params 1, eflags: 0x0
// Checksum 0xd3d5644a, Offset: 0x4b40
// Size: 0xf4
function powerup_vo(type) {
    self endon(#"disconnect");
    if (!isplayer(self)) {
        return;
    }
    if (isdefined(level.powerup_vo_available)) {
        if (![[ level.powerup_vo_available ]]()) {
            return;
        }
    }
    wait randomfloatrange(2, 2.5);
    if (type == "tesla") {
        self zm_audio::create_and_play_dialog("weapon_pickup", type);
    } else {
        self zm_audio::create_and_play_dialog("powerup", type);
    }
    if (isdefined(level.custom_powerup_vo_response)) {
        level [[ level.custom_powerup_vo_response ]](self, type);
    }
}

// Namespace zm_powerups/zm_powerups
// Params 2, eflags: 0x0
// Checksum 0x3d2e3857, Offset: 0x4c40
// Size: 0x56
function function_3734419a(var_57a3fb53, b_disable = 1) {
    if (isdefined(level.zombie_powerups[var_57a3fb53])) {
        level.zombie_powerups[var_57a3fb53].var_13ac89b7 = b_disable;
    }
}

// Namespace zm_powerups/zm_powerups
// Params 2, eflags: 0x0
// Checksum 0x145512e3, Offset: 0x4ca0
// Size: 0x56
function function_b10aba69(var_57a3fb53, b_disable = 1) {
    if (isdefined(level.zombie_powerups[var_57a3fb53])) {
        level.zombie_powerups[var_57a3fb53].var_fe9267ed = b_disable;
    }
}

// Namespace zm_powerups/zm_powerups
// Params 0, eflags: 0x0
// Checksum 0x22a8cde4, Offset: 0x4d00
// Size: 0xfc
function powerup_wobble_fx() {
    self endon(#"death");
    if (!isdefined(self)) {
        return;
    }
    if (isdefined(level.powerup_fx_func)) {
        self thread [[ level.powerup_fx_func ]]();
        return;
    }
    if (self.only_affects_grabber) {
        self clientfield::set("powerup_fx", 2);
        return;
    }
    if (self.any_team) {
        self clientfield::set("powerup_fx", 4);
        return;
    }
    if (self.zombie_grabbable) {
        self clientfield::set("powerup_fx", 3);
        return;
    }
    self clientfield::set("powerup_fx", 1);
}

// Namespace zm_powerups/zm_powerups
// Params 0, eflags: 0x0
// Checksum 0x4c4973f1, Offset: 0x4e08
// Size: 0x208
function powerup_wobble() {
    self endon(#"powerup_grabbed", #"powerup_timedout");
    if (isdefined(level.zombie_powerups[self.powerup_name]) && isdefined(level.zombie_powerups[self.powerup_name].var_13ac89b7) && level.zombie_powerups[self.powerup_name].var_13ac89b7) {
        return;
    }
    self thread powerup_wobble_fx();
    while (isdefined(self)) {
        waittime = randomfloatrange(2.5, 5);
        yaw = randomint(360);
        if (yaw > 300) {
            yaw = 300;
        } else if (yaw < 60) {
            yaw = 60;
        }
        yaw = self.angles[1] + yaw;
        new_angles = (-60 + randomint(120), yaw, -45 + randomint(90));
        self rotateto(new_angles, waittime, waittime * 0.5, waittime * 0.5);
        if (isdefined(self.worldgundw)) {
            self.worldgundw rotateto(new_angles, waittime, waittime * 0.5, waittime * 0.5);
        }
        wait randomfloat(waittime - 0.1);
    }
}

// Namespace zm_powerups/zm_powerups
// Params 0, eflags: 0x0
// Checksum 0xb87f540e, Offset: 0x5018
// Size: 0x44
function powerup_hide() {
    self ghost();
    if (isdefined(self.worldgundw)) {
        self.worldgundw ghost();
    }
}

// Namespace zm_powerups/zm_powerups
// Params 0, eflags: 0x0
// Checksum 0x20b34549, Offset: 0x5068
// Size: 0xcc
function powerup_show() {
    self show();
    if (isdefined(self.worldgundw)) {
        self.worldgundw show();
    }
    if (isdefined(self.powerup_player)) {
        self setinvisibletoall();
        self setvisibletoplayer(self.powerup_player);
        if (isdefined(self.worldgundw)) {
            self.worldgundw setinvisibletoall();
            self.worldgundw setvisibletoplayer(self.powerup_player);
        }
    }
}

// Namespace zm_powerups/zm_powerups
// Params 0, eflags: 0x0
// Checksum 0x76c56a60, Offset: 0x5140
// Size: 0x18c
function powerup_timeout() {
    if (isdefined(level._powerup_timeout_override) && !isdefined(self.powerup_team)) {
        self thread [[ level._powerup_timeout_override ]]();
        return;
    }
    self endon(#"powerup_grabbed", #"death", #"powerup_reset");
    self powerup_show();
    wait_time = 15;
    if (isdefined(level.var_f1e9e5aa)) {
        time = [[ level.var_f1e9e5aa ]](self);
        if (time == 0) {
            return;
        }
        wait_time = time;
    }
    if (bgb::is_team_enabled(#"zm_bgb_temporal_gift")) {
        wait_time += 30;
    }
    wait wait_time;
    self hide_and_show(&powerup_hide, &powerup_show);
    self notify(#"powerup_timedout");
    bb::logpowerupevent(self, undefined, "_timedout");
    self powerup_delete();
}

// Namespace zm_powerups/zm_powerups
// Params 2, eflags: 0x0
// Checksum 0xeab6cf0a, Offset: 0x52d8
// Size: 0x9e
function hide_and_show(hide_func, show_func) {
    for (i = 0; i < 40; i++) {
        if (i % 2) {
            self [[ hide_func ]]();
        } else {
            self [[ show_func ]]();
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
}

// Namespace zm_powerups/zm_powerups
// Params 0, eflags: 0x0
// Checksum 0xf36805c1, Offset: 0x5380
// Size: 0x64
function powerup_delete() {
    arrayremovevalue(level.active_powerups, self, 0);
    if (isdefined(self.worldgundw)) {
        self.worldgundw delete();
    }
    self delete();
}

// Namespace zm_powerups/zm_powerups
// Params 1, eflags: 0x0
// Checksum 0x207b2906, Offset: 0x53f0
// Size: 0x3c
function powerup_delete_delayed(time) {
    if (isdefined(time)) {
        wait time;
    } else {
        wait 0.01;
    }
    self powerup_delete();
}

// Namespace zm_powerups/zm_powerups
// Params 0, eflags: 0x0
// Checksum 0x3a3286fb, Offset: 0x5438
// Size: 0xd6
function is_insta_kill_active() {
    if (isdefined(zombie_utility::get_zombie_var_team(#"zombie_insta_kill", self.team)) && zombie_utility::get_zombie_var_team(#"zombie_insta_kill", self.team) || isdefined(self zombie_utility::get_zombie_var_player(#"zombie_insta_kill")) && self zombie_utility::get_zombie_var_player(#"zombie_insta_kill") || isdefined(self.personal_instakill) && self.personal_instakill) {
        return true;
    }
    return false;
}

// Namespace zm_powerups/zm_powerups
// Params 5, eflags: 0x0
// Checksum 0xd5fbf984, Offset: 0x5518
// Size: 0x1de
function function_69b64e81(player, mod, hit_location, weapon, damage) {
    if (isdefined(player) && isalive(player) && isdefined(level.check_for_instakill_override)) {
        if (!self [[ level.check_for_instakill_override ]](player)) {
            return damage;
        }
        if (!(isdefined(self.no_gib) && self.no_gib)) {
            self zombie_utility::zombie_head_gib();
        }
        self.health = 1;
        return (self.health + 666);
    }
    if (isdefined(player) && isalive(player) && player is_insta_kill_active()) {
        if (zm_utility::is_magic_bullet_shield_enabled(self)) {
            return damage;
        }
        if (isdefined(self.instakill_func)) {
            b_result = self thread [[ self.instakill_func ]](player, mod, hit_location);
            if (isdefined(b_result) && b_result) {
                return damage;
            }
        }
        if (!level flag::get("special_round") && !(isdefined(self.no_gib) && self.no_gib)) {
            self zombie_utility::zombie_head_gib();
        }
        self.health = 1;
        return (self.health + 666);
    }
    return damage;
}

// Namespace zm_powerups/zm_powerups
// Params 3, eflags: 0x0
// Checksum 0xab895bc0, Offset: 0x5700
// Size: 0x20
function function_ef67590f(player, mod, shitloc) {
    return true;
}

// Namespace zm_powerups/zm_powerups
// Params 2, eflags: 0x0
// Checksum 0xfcdf10eb, Offset: 0x5728
// Size: 0xb4
function point_doubler_on_hud(drop_item, player_team) {
    self endon(#"disconnect");
    if (zombie_utility::get_zombie_var_team(#"zombie_powerup_double_points_on", player_team)) {
        zombie_utility::set_zombie_var_team(#"zombie_powerup_double_points_time", player_team, 30);
        return;
    }
    zombie_utility::set_zombie_var_team(#"zombie_powerup_double_points_on", player_team, 1);
    level thread time_remaining_on_point_doubler_powerup(player_team);
}

// Namespace zm_powerups/zm_powerups
// Params 1, eflags: 0x0
// Checksum 0x92a38b9d, Offset: 0x57e8
// Size: 0x1c4
function time_remaining_on_point_doubler_powerup(player_team) {
    temp_ent = spawn("script_origin", (0, 0, 0));
    temp_ent playloopsound(#"zmb_double_point_loop");
    while (zombie_utility::get_zombie_var_team(#"zombie_powerup_double_points_time", player_team) >= 0) {
        waitframe(1);
        zombie_utility::set_zombie_var_team(#"zombie_powerup_double_points_time", player_team, zombie_utility::get_zombie_var_team(#"zombie_powerup_double_points_time", player_team) - 0.05);
    }
    zombie_utility::set_zombie_var_team(#"zombie_powerup_double_points_on", player_team, 0);
    players = getplayers(player_team);
    for (i = 0; i < players.size; i++) {
        players[i] playsound(#"zmb_points_loop_off");
    }
    temp_ent stoploopsound(2);
    zombie_utility::set_zombie_var_team(#"zombie_powerup_double_points_time", player_team, 30);
    temp_ent delete();
}

// Namespace zm_powerups/zm_powerups
// Params 0, eflags: 0x0
// Checksum 0xa1bc0f50, Offset: 0x59b8
// Size: 0xc
function devil_dialog_delay() {
    wait 1;
}

// Namespace zm_powerups/zm_powerups
// Params 1, eflags: 0x0
// Checksum 0x1da94683, Offset: 0x59d0
// Size: 0x34
function check_for_rare_drop_override(pos) {
    if (level flagsys::get(#"ape_round")) {
        return false;
    }
    return false;
}

// Namespace zm_powerups/zm_powerups
// Params 0, eflags: 0x0
// Checksum 0x1ad11b0a, Offset: 0x5a10
// Size: 0x72
function tesla_powerup_active() {
    players = getplayers();
    for (i = 0; i < players.size; i++) {
        if (players[i].zombie_vars[#"zombie_powerup_tesla_on"]) {
            return true;
        }
    }
    return false;
}

/#

    // Namespace zm_powerups/zm_powerups
    // Params 2, eflags: 0x0
    // Checksum 0x21ad0297, Offset: 0x5a90
    // Size: 0x194
    function print_powerup_drop(powerup, type) {
        if (!isdefined(level.powerup_drop_time)) {
            level.powerup_drop_time = 0;
            level.powerup_random_count = 0;
            level.var_96d41cf2 = 0;
        }
        time = (gettime() - level.powerup_drop_time) * 0.001;
        level.powerup_drop_time = gettime();
        if (type == "<dev string:xc2>") {
            level.powerup_random_count++;
        } else {
            level.var_96d41cf2++;
        }
        println("<dev string:xc9>");
        println("<dev string:xf0>" + powerup);
        println("<dev string:xfa>" + type);
        println("<dev string:x10b>");
        println("<dev string:x120>" + time);
        println("<dev string:x12c>");
        println("<dev string:x14b>" + level.var_96d41cf2);
        println("<dev string:x160>");
    }

#/

// Namespace zm_powerups/zm_powerups
// Params 2, eflags: 0x0
// Checksum 0xe126f98c, Offset: 0x5c30
// Size: 0x5e
function register_carpenter_node(node, callback) {
    if (!isdefined(level._additional_carpenter_nodes)) {
        level._additional_carpenter_nodes = [];
    }
    node._post_carpenter_callback = callback;
    level._additional_carpenter_nodes[level._additional_carpenter_nodes.size] = node;
}

// Namespace zm_powerups/zm_powerups
// Params 0, eflags: 0x0
// Checksum 0xb5e6904c, Offset: 0x5c98
// Size: 0x6
function func_should_never_drop() {
    return false;
}

// Namespace zm_powerups/zm_powerups
// Params 0, eflags: 0x0
// Checksum 0xe263cf4d, Offset: 0x5ca8
// Size: 0x8
function func_should_always_drop() {
    return true;
}

// Namespace zm_powerups/zm_powerups
// Params 0, eflags: 0x0
// Checksum 0xdf654d3e, Offset: 0x5cb8
// Size: 0x12e
function function_6627e739() {
    self endon(#"powerup_timedout", #"powerup_grabbed", #"death");
    var_8751c69b = 75;
    while (true) {
        waitresult = self waittill(#"hash_25ba96d951079d6f");
        moveto = waitresult.moveto;
        distance = waitresult.distance;
        var_d09882f7 = moveto - self.origin;
        range_squared = lengthsquared(var_d09882f7);
        if (range_squared > distance * distance) {
            var_d09882f7 = vectornormalize(var_d09882f7);
            var_d09882f7 = distance * var_d09882f7;
            moveto = self.origin + var_d09882f7;
        }
        self.origin = moveto;
    }
}

// Namespace zm_powerups/zm_powerups
// Params 0, eflags: 0x0
// Checksum 0x92454b43, Offset: 0x5df0
// Size: 0x10a
function powerup_emp() {
    self endon(#"powerup_timedout", #"powerup_grabbed");
    if (!zm_utility::should_watch_for_emp()) {
        return;
    }
    while (true) {
        waitresult = level waittill(#"emp_detonate");
        if (distancesquared(waitresult.position, self.origin) < waitresult.radius * waitresult.radius) {
            playfx(level._effect[#"powerup_off"], self.origin);
            self thread powerup_delete_delayed();
            self notify(#"powerup_timedout");
        }
    }
}

// Namespace zm_powerups/zm_powerups
// Params 2, eflags: 0x0
// Checksum 0x9409ca68, Offset: 0x5f08
// Size: 0xe6
function get_powerups(origin, radius) {
    if (isdefined(origin) && isdefined(radius)) {
        powerups = [];
        foreach (powerup in level.active_powerups) {
            if (distancesquared(origin, powerup.origin) < radius * radius) {
                powerups[powerups.size] = powerup;
            }
        }
        return powerups;
    }
    return level.active_powerups;
}

// Namespace zm_powerups/zm_powerups
// Params 1, eflags: 0x0
// Checksum 0xb4a7f2fd, Offset: 0x5ff8
// Size: 0xb2
function should_award_stat(powerup_name) {
    if (powerup_name == "teller_withdrawl" || powerup_name == "blue_monkey" || powerup_name == "free_perk" || powerup_name == "bonus_points_player" || powerup_name == "bonus_points_player_shared") {
        return false;
    }
    if (isdefined(level.zombie_statless_powerups) && isdefined(level.zombie_statless_powerups[powerup_name]) && level.zombie_statless_powerups[powerup_name]) {
        return false;
    }
    return true;
}

// Namespace zm_powerups/zm_powerups
// Params 2, eflags: 0x0
// Checksum 0x84593098, Offset: 0x60b8
// Size: 0x34
function teller_withdrawl(powerup, player) {
    player zm_score::add_to_player_score(powerup.value);
}

// Namespace zm_powerups/zm_powerups
// Params 1, eflags: 0x0
// Checksum 0xd3a08488, Offset: 0x60f8
// Size: 0x62
function function_ffd24ecc(str_powerup) {
    if (isdefined(level.zombie_powerups[str_powerup]) && isdefined(level.zombie_powerups[str_powerup].only_affects_grabber) && level.zombie_powerups[str_powerup].only_affects_grabber) {
        return true;
    }
    return false;
}

// Namespace zm_powerups/zm_powerups
// Params 1, eflags: 0x0
// Checksum 0x63653574, Offset: 0x6168
// Size: 0x124
function function_e00ef9d4(str_powerup) {
    self endon(#"disconnect");
    str_index_on = "zombie_powerup_" + str_powerup + "_on";
    str_index_time = "zombie_powerup_" + str_powerup + "_time";
    self zombie_utility::set_zombie_var_player(str_index_time, 30);
    if (self bgb::is_enabled(#"zm_bgb_temporal_gift")) {
        self zombie_utility::set_zombie_var_player(str_index_time, 60);
    }
    if (isdefined(self zombie_utility::get_zombie_var_player(str_index_on)) && self zombie_utility::get_zombie_var_player(str_index_on)) {
        return;
    }
    self zombie_utility::set_zombie_var_player(str_index_on, 1);
    self thread function_a260cb9c(str_powerup);
}

// Namespace zm_powerups/zm_powerups
// Params 1, eflags: 0x0
// Checksum 0xbeed2ece, Offset: 0x6298
// Size: 0x164
function function_a260cb9c(str_powerup) {
    self endon(#"disconnect");
    str_index_on = "zombie_powerup_" + str_powerup + "_on";
    str_index_time = "zombie_powerup_" + str_powerup + "_time";
    str_sound_loop = "zmb_" + str_powerup + "_loop";
    str_sound_off = "zmb_" + str_powerup + "_loop_off";
    while (zombie_utility::get_zombie_var_player(str_index_time) >= 0) {
        waitframe(1);
        self zombie_utility::set_zombie_var_player(str_index_time, zombie_utility::get_zombie_var_player(str_index_time) - float(function_f9f48566()) / 1000);
    }
    self zombie_utility::set_zombie_var_player(str_index_on, 0);
    self playsoundtoplayer(str_sound_off, self);
    zombie_utility::set_zombie_var_player(str_index_time, 30);
}

// Namespace zm_powerups/zm_powerups
// Params 2, eflags: 0x0
// Checksum 0xb748410e, Offset: 0x6408
// Size: 0x144
function show_on_hud(player_team, str_powerup) {
    self endon(#"disconnect");
    str_index_on = "zombie_powerup_" + str_powerup + "_on";
    str_index_time = "zombie_powerup_" + str_powerup + "_time";
    if (zombie_utility::get_zombie_var_team(str_index_on, player_team)) {
        zombie_utility::set_zombie_var_team(str_index_time, player_team, 30);
        if (bgb::is_team_enabled(#"zm_bgb_temporal_gift")) {
            zombie_utility::set_zombie_var_team(str_index_time, player_team, zombie_utility::get_zombie_var_team(str_index_time, player_team) + 30);
        }
        return;
    }
    zombie_utility::set_zombie_var_team(str_index_on, player_team, 1);
    level thread time_remaining_on_powerup(player_team, str_powerup);
}

// Namespace zm_powerups/zm_powerups
// Params 2, eflags: 0x0
// Checksum 0xd4e8a544, Offset: 0x6558
// Size: 0x234
function time_remaining_on_powerup(player_team, str_powerup) {
    str_index_on = "zombie_powerup_" + str_powerup + "_on";
    str_index_time = "zombie_powerup_" + str_powerup + "_time";
    str_sound_loop = "zmb_" + str_powerup + "_loop";
    str_sound_off = "zmb_" + str_powerup + "_loop_off";
    temp_ent = spawn("script_origin", (0, 0, 0));
    temp_ent playloopsound(str_sound_loop);
    if (bgb::is_team_enabled(#"zm_bgb_temporal_gift")) {
        zombie_utility::set_zombie_var_team(str_index_time, player_team, zombie_utility::get_zombie_var_team(str_index_time, player_team) + 30);
    }
    while (zombie_utility::get_zombie_var_team(str_index_time, player_team) >= 0) {
        waitframe(1);
        zombie_utility::set_zombie_var_team(str_index_time, player_team, zombie_utility::get_zombie_var_team(str_index_time, player_team) - 0.05);
    }
    zombie_utility::set_zombie_var_team(str_index_on, player_team, 0);
    getplayers()[0] playsoundtoteam(str_sound_off, player_team);
    temp_ent stoploopsound(2);
    zombie_utility::set_zombie_var_team(str_index_time, player_team, 30);
    temp_ent delete();
}

// Namespace zm_powerups/zm_powerups
// Params 4, eflags: 0x0
// Checksum 0xb6b0712c, Offset: 0x6798
// Size: 0x1dc
function weapon_powerup(ent_player, time, str_weapon, allow_cycling = 0) {
    str_weapon_on = "zombie_powerup_" + str_weapon + "_on";
    str_weapon_time_over = str_weapon + "_time_over";
    ent_player notify(#"replace_weapon_powerup");
    ent_player._show_solo_hud = 1;
    ent_player.has_specific_powerup_weapon[str_weapon] = 1;
    ent_player.has_powerup_weapon = 1;
    ent_player zm_utility::increment_is_drinking();
    if (allow_cycling) {
        ent_player enableweaponcycling();
    }
    ent_player._zombie_weapon_before_powerup[str_weapon] = ent_player getcurrentweapon();
    ent_player giveweapon(level.zombie_powerup_weapon[str_weapon]);
    ent_player switchtoweapon(level.zombie_powerup_weapon[str_weapon]);
    ent_player.zombie_vars[str_weapon_on] = 1;
    level thread weapon_powerup_countdown(ent_player, str_weapon_time_over, time, str_weapon);
    level thread weapon_powerup_replace(ent_player, str_weapon_time_over, str_weapon);
    level thread weapon_powerup_change(ent_player, str_weapon_time_over, str_weapon);
}

// Namespace zm_powerups/zm_powerups
// Params 3, eflags: 0x0
// Checksum 0x270728cb, Offset: 0x6980
// Size: 0xe4
function weapon_powerup_change(ent_player, str_gun_return_notify, str_weapon) {
    ent_player endon(#"death", #"player_downed", str_gun_return_notify, #"replace_weapon_powerup");
    while (true) {
        waitresult = ent_player waittill(#"weapon_change");
        if (waitresult.weapon != level.weaponnone && waitresult.weapon != level.zombie_powerup_weapon[str_weapon]) {
            break;
        }
    }
    level thread weapon_powerup_remove(ent_player, str_gun_return_notify, str_weapon, 0);
}

// Namespace zm_powerups/zm_powerups
// Params 4, eflags: 0x0
// Checksum 0xa64bf599, Offset: 0x6a70
// Size: 0x12c
function weapon_powerup_countdown(ent_player, str_gun_return_notify, time, str_weapon) {
    ent_player endon(#"death", #"player_downed", str_gun_return_notify, #"replace_weapon_powerup");
    str_weapon_time = "zombie_powerup_" + str_weapon + "_time";
    ent_player.zombie_vars[str_weapon_time] = time;
    if (bgb::is_team_enabled(#"zm_bgb_temporal_gift")) {
        ent_player.zombie_vars[str_weapon_time] = ent_player.zombie_vars[str_weapon_time] + 30;
    }
    [[ level._custom_powerups[str_weapon].weapon_countdown ]](ent_player, str_weapon_time);
    level thread weapon_powerup_remove(ent_player, str_gun_return_notify, str_weapon, 1);
}

// Namespace zm_powerups/zm_powerups
// Params 3, eflags: 0x0
// Checksum 0x8c08c7f6, Offset: 0x6ba8
// Size: 0xec
function weapon_powerup_replace(ent_player, str_gun_return_notify, str_weapon) {
    ent_player endon(#"death", #"player_downed", str_gun_return_notify);
    str_weapon_on = "zombie_powerup_" + str_weapon + "_on";
    ent_player waittill(#"replace_weapon_powerup");
    ent_player takeweapon(level.zombie_powerup_weapon[str_weapon]);
    ent_player.zombie_vars[str_weapon_on] = 0;
    ent_player.has_specific_powerup_weapon[str_weapon] = 0;
    ent_player.has_powerup_weapon = 0;
    ent_player zm_utility::decrement_is_drinking();
}

// Namespace zm_powerups/zm_powerups
// Params 4, eflags: 0x0
// Checksum 0xd9ca1ad8, Offset: 0x6ca0
// Size: 0x134
function weapon_powerup_remove(ent_player, str_gun_return_notify, str_weapon, b_switch_back_weapon = 1) {
    ent_player endon(#"death", #"player_downed");
    str_weapon_on = "zombie_powerup_" + str_weapon + "_on";
    ent_player takeweapon(level.zombie_powerup_weapon[str_weapon]);
    ent_player.zombie_vars[str_weapon_on] = 0;
    ent_player._show_solo_hud = 0;
    ent_player.has_specific_powerup_weapon[str_weapon] = 0;
    ent_player.has_powerup_weapon = 0;
    ent_player notify(str_gun_return_notify);
    ent_player zm_utility::decrement_is_drinking();
    if (b_switch_back_weapon) {
        ent_player zm_weapons::switch_back_primary_weapon(ent_player._zombie_weapon_before_powerup[str_weapon]);
    }
}

// Namespace zm_powerups/zm_powerups
// Params 1, eflags: 0x0
// Checksum 0x4195ae0d, Offset: 0x6de0
// Size: 0x152
function weapon_watch_gunner_downed(str_weapon) {
    str_notify = str_weapon + "_time_over";
    str_weapon_on = "zombie_powerup_" + str_weapon + "_on";
    if (!isdefined(self.has_specific_powerup_weapon) || !(isdefined(self.has_specific_powerup_weapon[str_weapon]) && self.has_specific_powerup_weapon[str_weapon])) {
        return;
    }
    primaryweapons = self getweaponslistprimaries();
    for (i = 0; i < primaryweapons.size; i++) {
        if (primaryweapons[i] == level.zombie_powerup_weapon[str_weapon]) {
            self takeweapon(level.zombie_powerup_weapon[str_weapon]);
        }
    }
    self notify(str_notify);
    self.zombie_vars[str_weapon_on] = 0;
    self._show_solo_hud = 0;
    waitframe(1);
    self.has_specific_powerup_weapon[str_weapon] = 0;
    self.has_powerup_weapon = 0;
}

// Namespace zm_powerups/zm_powerups
// Params 3, eflags: 0x0
// Checksum 0xcaef8c3b, Offset: 0x6f40
// Size: 0xd6
function register_powerup(str_powerup, func_grab_powerup, func_setup) {
    assert(isdefined(str_powerup), "<dev string:x187>");
    _register_undefined_powerup(str_powerup);
    if (isdefined(func_grab_powerup)) {
        if (!isdefined(level._custom_powerups[str_powerup].grab_powerup)) {
            level._custom_powerups[str_powerup].grab_powerup = func_grab_powerup;
        }
    }
    if (isdefined(func_setup)) {
        if (!isdefined(level._custom_powerups[str_powerup].setup_powerup)) {
            level._custom_powerups[str_powerup].setup_powerup = func_setup;
        }
    }
}

// Namespace zm_powerups/zm_powerups
// Params 1, eflags: 0x0
// Checksum 0x6e98e4a6, Offset: 0x7020
// Size: 0x7c
function _register_undefined_powerup(str_powerup) {
    if (!isdefined(level._custom_powerups)) {
        level._custom_powerups = [];
    }
    if (!isdefined(level._custom_powerups[str_powerup])) {
        level._custom_powerups[str_powerup] = spawnstruct();
        include_zombie_powerup(str_powerup);
    }
}

// Namespace zm_powerups/zm_powerups
// Params 2, eflags: 0x0
// Checksum 0x9df3f0b7, Offset: 0x70a8
// Size: 0x8e
function register_powerup_weapon(str_powerup, func_countdown) {
    assert(isdefined(str_powerup), "<dev string:x187>");
    _register_undefined_powerup(str_powerup);
    if (isdefined(func_countdown)) {
        if (!isdefined(level._custom_powerups[str_powerup].weapon_countdown)) {
            level._custom_powerups[str_powerup].weapon_countdown = func_countdown;
        }
    }
}

