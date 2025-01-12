#using scripts\core_common\ai\zombie_utility;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\lui_shared;
#using scripts\core_common\system_shared;
#using scripts\zm_common\zm_daily_challenges;
#using scripts\zm_common\zm_powerups;
#using scripts\zm_common\zm_score;
#using scripts\zm_common\zm_utility;

#namespace zm_powerup_nuke;

// Namespace zm_powerup_nuke/zm_powerup_nuke
// Params 0, eflags: 0x2
// Checksum 0x1526db77, Offset: 0x138
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"zm_powerup_nuke", &__init__, undefined, undefined);
}

// Namespace zm_powerup_nuke/zm_powerup_nuke
// Params 0, eflags: 0x0
// Checksum 0x5b9998d9, Offset: 0x180
// Size: 0xfc
function __init__() {
    zm_powerups::register_powerup("nuke", &grab_nuke);
    clientfield::register("actor", "zm_nuked", 1, 1, "int");
    clientfield::register("vehicle", "zm_nuked", 1, 1, "int");
    zm_powerups::add_zombie_powerup("nuke", "p7_zm_power_up_nuke", #"zombie/powerup_nuke", &zm_powerups::func_should_always_drop, 0, 0, 0, "zombie/fx_powerup_nuke_zmb");
    level flag::init(#"hash_21921ed511559aa3");
}

// Namespace zm_powerup_nuke/zm_powerup_nuke
// Params 1, eflags: 0x0
// Checksum 0xba65d51e, Offset: 0x288
// Size: 0xb0
function grab_nuke(player) {
    level thread nuke_powerup(self, player.team, player);
    player thread zm_powerups::powerup_vo("nuke");
    zombies = getaiteamarray(level.zombie_team);
    player.zombie_nuked = arraysort(zombies, self.origin);
    player notify(#"nuke_triggered");
}

// Namespace zm_powerup_nuke/zm_powerup_nuke
// Params 3, eflags: 0x0
// Checksum 0xeee780b7, Offset: 0x340
// Size: 0x558
function nuke_powerup(drop_item, player_team, var_b5a9d4) {
    level thread nuke_delay_spawning(3);
    location = drop_item.origin;
    if (isdefined(drop_item.fx)) {
        playfx(drop_item.fx, location);
    }
    if (!(isdefined(level.var_9d42e617) && level.var_9d42e617)) {
        level thread nuke_flash(player_team);
    }
    wait 0.5;
    zombies = getaiteamarray(level.zombie_team);
    zombies = arraysort(zombies, location);
    zombies_nuked = [];
    for (i = 0; i < zombies.size; i++) {
        if (isdefined(zombies[i].ignore_nuke) && zombies[i].ignore_nuke) {
            continue;
        }
        if (isdefined(zombies[i].marked_for_death) && zombies[i].marked_for_death) {
            continue;
        }
        if (isdefined(zombies[i].nuke_damage_func)) {
            zombies[i] thread [[ zombies[i].nuke_damage_func ]]();
            continue;
        }
        if (zm_utility::is_magic_bullet_shield_enabled(zombies[i])) {
            continue;
        }
        zombies[i].marked_for_death = 1;
        if (!(isdefined(zombies[i].nuked) && zombies[i].nuked) && !zm_utility::is_magic_bullet_shield_enabled(zombies[i])) {
            zombies[i].nuked = 1;
            zombies_nuked[zombies_nuked.size] = zombies[i];
            zombies[i] clientfield::set("zm_nuked", 1);
            zombies[i] zombie_utility::set_zombie_run_cycle_override_value("walk");
        }
    }
    for (i = 0; i < zombies_nuked.size; i++) {
        wait randomfloatrange(0.1, 0.3);
        if (!isdefined(zombies_nuked[i])) {
            continue;
        }
        if (zm_utility::is_magic_bullet_shield_enabled(zombies_nuked[i])) {
            continue;
        }
        if (!(isdefined(zombies_nuked[i].isdog) && zombies_nuked[i].isdog)) {
            if (!(isdefined(zombies_nuked[i].no_gib) && zombies_nuked[i].no_gib)) {
                zombies_nuked[i] zombie_utility::zombie_head_gib();
            }
            zombies_nuked[i] playsound(#"evt_nuked");
        }
        zombies_nuked[i] dodamage(zombies_nuked[i].health + 666, zombies_nuked[i].origin);
        level thread zm_daily_challenges::increment_nuked_zombie();
    }
    level notify(#"nuke_complete");
    if (zm_powerups::function_ffd24ecc(#"nuke") && isplayer(var_b5a9d4)) {
        var_b5a9d4 zm_score::player_add_points("nuke_powerup", 400, undefined, undefined, undefined, undefined, 1);
        return;
    }
    foreach (e_player in level.players) {
        e_player zm_score::player_add_points("nuke_powerup", 400, undefined, undefined, undefined, undefined, 1);
    }
}

// Namespace zm_powerup_nuke/zm_powerup_nuke
// Params 1, eflags: 0x0
// Checksum 0xa22bcaea, Offset: 0x8a0
// Size: 0xb4
function nuke_flash(team) {
    if (isdefined(team)) {
        getplayers()[0] playsoundtoteam("evt_nuke_flash", team);
    } else {
        getplayers()[0] playsound(#"evt_nuke_flash");
    }
    lui::screen_flash(0.2, 0.5, 1, 0.8, "white");
}

// Namespace zm_powerup_nuke/zm_powerup_nuke
// Params 1, eflags: 0x0
// Checksum 0x3a0f31c1, Offset: 0x960
// Size: 0x12c
function nuke_delay_spawning(n_spawn_delay) {
    level endon(#"disable_nuke_delay_spawning");
    if (isdefined(level.disable_nuke_delay_spawning) && level.disable_nuke_delay_spawning) {
        return;
    }
    b_spawn_zombies_before_nuke = level flag::get("spawn_zombies");
    level flag::set(#"hash_21921ed511559aa3");
    level flag::clear("spawn_zombies");
    level waittill(#"nuke_complete");
    if (isdefined(level.disable_nuke_delay_spawning) && level.disable_nuke_delay_spawning) {
        return;
    }
    wait n_spawn_delay;
    if (b_spawn_zombies_before_nuke) {
        level flag::set("spawn_zombies");
    }
    level flag::clear(#"hash_21921ed511559aa3");
}

