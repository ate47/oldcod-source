#using scripts\core_common\ai\zombie_utility;
#using scripts\core_common\array_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\zm_common\util;
#using scripts\zm_common\zm;
#using scripts\zm_common\zm_round_logic;
#using scripts\zm_common\zm_utility;

#namespace zm_game_module;

// Namespace zm_game_module/zm_game_module
// Params 7, eflags: 0x0
// Checksum 0xac71d00d, Offset: 0x128
// Size: 0x230
function register_game_module(index, module_name, pre_init_func, post_init_func, pre_init_zombie_spawn_func, post_init_zombie_spawn_func, hub_start_func) {
    if (!isdefined(level._game_modules)) {
        level._game_modules = [];
        level._num_registered_game_modules = 0;
    }
    for (i = 0; i < level._num_registered_game_modules; i++) {
        if (!isdefined(level._game_modules[i])) {
            continue;
        }
        if (isdefined(level._game_modules[i].index) && level._game_modules[i].index == index) {
            assert(level._game_modules[i].index != index, "<dev string:x38>" + index + "<dev string:x6b>");
        }
    }
    level._game_modules[level._num_registered_game_modules] = spawnstruct();
    level._game_modules[level._num_registered_game_modules].index = index;
    level._game_modules[level._num_registered_game_modules].module_name = module_name;
    level._game_modules[level._num_registered_game_modules].pre_init_func = pre_init_func;
    level._game_modules[level._num_registered_game_modules].post_init_func = post_init_func;
    level._game_modules[level._num_registered_game_modules].pre_init_zombie_spawn_func = pre_init_zombie_spawn_func;
    level._game_modules[level._num_registered_game_modules].post_init_zombie_spawn_func = post_init_zombie_spawn_func;
    level._game_modules[level._num_registered_game_modules].hub_start_func = hub_start_func;
    level._num_registered_game_modules++;
}

// Namespace zm_game_module/zm_game_module
// Params 1, eflags: 0x0
// Checksum 0x5d50a236, Offset: 0x360
// Size: 0xa4
function set_current_game_module(game_module_index) {
    if (!isdefined(game_module_index)) {
        level.current_game_module = level.game_module_classic_index;
        level.scr_zm_game_module = level.game_module_classic_index;
        return;
    }
    game_module = get_game_module(game_module_index);
    if (!isdefined(game_module)) {
        assert(isdefined(game_module), "<dev string:x70>" + game_module_index + "<dev string:x6b>");
        return;
    }
    level.current_game_module = game_module_index;
}

// Namespace zm_game_module/zm_game_module
// Params 0, eflags: 0x1 linked
// Checksum 0x4bb23929, Offset: 0x410
// Size: 0x1a
function get_current_game_module() {
    return get_game_module(level.current_game_module);
}

// Namespace zm_game_module/zm_game_module
// Params 1, eflags: 0x1 linked
// Checksum 0x61ea19a5, Offset: 0x438
// Size: 0x74
function get_game_module(game_module_index) {
    if (!isdefined(game_module_index)) {
        return undefined;
    }
    for (i = 0; i < level._game_modules.size; i++) {
        if (level._game_modules[i].index == game_module_index) {
            return level._game_modules[i];
        }
    }
    return undefined;
}

// Namespace zm_game_module/zm_game_module
// Params 0, eflags: 0x0
// Checksum 0xd8021f25, Offset: 0x4b8
// Size: 0x50
function game_module_pre_zombie_spawn_init() {
    current_module = get_current_game_module();
    if (!isdefined(current_module) || !isdefined(current_module.pre_init_zombie_spawn_func)) {
        return;
    }
    self [[ current_module.pre_init_zombie_spawn_func ]]();
}

// Namespace zm_game_module/zm_game_module
// Params 0, eflags: 0x0
// Checksum 0x655b2304, Offset: 0x510
// Size: 0x50
function game_module_post_zombie_spawn_init() {
    current_module = get_current_game_module();
    if (!isdefined(current_module) || !isdefined(current_module.post_init_zombie_spawn_func)) {
        return;
    }
    self [[ current_module.post_init_zombie_spawn_func ]]();
}

// Namespace zm_game_module/zm_game_module
// Params 0, eflags: 0x0
// Checksum 0x9b0346ce, Offset: 0x568
// Size: 0xd0
function respawn_spectators_and_freeze_players() {
    foreach (player in getplayers()) {
        if (player.sessionstate == "spectator") {
            player [[ level.spawnplayer ]]();
        }
        player val::set(#"respawn_spectators_and_freeze_players", "freezecontrols");
    }
}

// Namespace zm_game_module/zm_game_module
// Params 10, eflags: 0x0
// Checksum 0xef5b6bbf, Offset: 0x640
// Size: 0xc8
function damage_callback_no_pvp_damage(*einflictor, eattacker, idamage, *idflags, *smeansofdeath, *eapon, *vpoint, *vdir, *shitloc, *psoffsettime) {
    if (isdefined(shitloc) && isplayer(shitloc) && shitloc == self) {
        return psoffsettime;
    }
    if (isdefined(shitloc) && !isplayer(shitloc)) {
        return psoffsettime;
    }
    if (!isdefined(shitloc)) {
        return psoffsettime;
    }
    return 0;
}

// Namespace zm_game_module/zm_game_module
// Params 0, eflags: 0x1 linked
// Checksum 0x7a102783, Offset: 0x710
// Size: 0x9c
function respawn_players() {
    players = getplayers();
    foreach (player in players) {
        player [[ level.spawnplayer ]]();
    }
}

// Namespace zm_game_module/zm_game_module
// Params 1, eflags: 0x1 linked
// Checksum 0x38df4f74, Offset: 0x7b8
// Size: 0x238
function zombie_goto_round(target_round) {
    level flag::set("round_reset");
    level notify(#"restart_round");
    if (target_round < 1) {
        target_round = 1;
    }
    level.zombie_total = 0;
    level.zombie_health = isdefined(level.var_41dd92fd[#"zombie"].health) ? level.var_41dd92fd[#"zombie"].health : 100;
    zm_round_logic::set_round_number(target_round);
    enemies = getaiteamarray(level.zombie_team);
    if (isdefined(enemies)) {
        for (i = 0; i < enemies.size; i++) {
            enemy = enemies[i];
            if (zm_utility::is_magic_bullet_shield_enabled(enemy)) {
                enemy util::stop_magic_bullet_shield();
            }
            enemy.allowdeath = 1;
            enemy kill(undefined, undefined, undefined, undefined, undefined, 1);
        }
    }
    wait 5;
    corpses = getcorpsearray();
    foreach (corpse in corpses) {
        if (isactorcorpse(corpse)) {
            corpse delete();
        }
    }
}

// Namespace zm_game_module/zm_game_module
// Params 0, eflags: 0x0
// Checksum 0x6df5da81, Offset: 0x9f8
// Size: 0x24
function make_supersprinter() {
    self zombie_utility::set_zombie_run_cycle("super_sprint");
}

// Namespace zm_game_module/zm_game_module
// Params 4, eflags: 0x0
// Checksum 0x847f43b9, Offset: 0xa28
// Size: 0x128
function create_fireworks(launch_spots, min_wait, max_wait, randomize) {
    level endon(#"stop_fireworks");
    while (true) {
        if (is_true(randomize)) {
            launch_spots = array::randomize(launch_spots);
        }
        foreach (spot in launch_spots) {
            level thread fireworks_launch(spot);
            wait randomfloatrange(min_wait, max_wait);
        }
        wait randomfloatrange(min_wait, max_wait);
    }
}

// Namespace zm_game_module/zm_game_module
// Params 1, eflags: 0x1 linked
// Checksum 0x93eb4b6a, Offset: 0xb58
// Size: 0x2bc
function fireworks_launch(launch_spot) {
    firework = spawn("script_model", launch_spot.origin + (randomintrange(-60, 60), randomintrange(-60, 60), 0));
    firework setmodel(#"tag_origin");
    util::wait_network_frame();
    playfxontag(level._effect[#"fw_trail_cheap"], firework, "tag_origin");
    firework playloopsound(#"zmb_souls_loop", 0.75);
    dest = launch_spot;
    while (isdefined(dest) && isdefined(dest.target)) {
        random_offset = (randomintrange(-60, 60), randomintrange(-60, 60), 0);
        new_dests = struct::get_array(dest.target, "targetname");
        new_dest = array::random(new_dests);
        dest = new_dest;
        dist = distance(new_dest.origin + random_offset, firework.origin);
        time = dist / 700;
        firework moveto(new_dest.origin + random_offset, time);
        firework waittill(#"movedone");
    }
    firework playsound(#"zmb_souls_end");
    playfx(level._effect[#"fw_pre_burst"], firework.origin);
    firework delete();
}

