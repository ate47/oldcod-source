#using scripts\core_common\ai\zombie_death;
#using scripts\core_common\ai\zombie_utility;
#using scripts\core_common\ai_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\lui_shared;
#using scripts\core_common\scoreevents_shared;
#using scripts\core_common\system_shared;
#using scripts\zm_common\zm_daily_challenges;
#using scripts\zm_common\zm_powerups;
#using scripts\zm_common\zm_score;
#using scripts\zm_common\zm_utility;

#namespace zm_powerup_nuke;

// Namespace zm_powerup_nuke/zm_powerup_nuke
// Params 0, eflags: 0x6
// Checksum 0x61767734, Offset: 0x178
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"zm_powerup_nuke", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace zm_powerup_nuke/zm_powerup_nuke
// Params 0, eflags: 0x5 linked
// Checksum 0xac8d0827, Offset: 0x1c0
// Size: 0xfc
function private function_70a657d8() {
    zm_powerups::register_powerup("nuke", &grab_nuke);
    clientfield::register("actor", "zm_nuked", 1, 1, "int");
    clientfield::register("vehicle", "zm_nuked", 1, 1, "int");
    zm_powerups::add_zombie_powerup("nuke", "p7_zm_power_up_nuke", #"zombie/powerup_nuke", &function_8d3a47ed, 0, 0, 0, "zombie/fx9_powerup_nuke");
    level flag::init(#"hash_21921ed511559aa3");
}

// Namespace zm_powerup_nuke/zm_powerup_nuke
// Params 1, eflags: 0x1 linked
// Checksum 0x803ffec8, Offset: 0x2c8
// Size: 0xb0
function grab_nuke(player) {
    level thread nuke_powerup(self, player.team, player);
    player thread zm_powerups::powerup_vo("nuke");
    zombies = getaiteamarray(level.zombie_team);
    player.zombie_nuked = arraysort(zombies, self.origin);
    player notify(#"nuke_triggered");
}

// Namespace zm_powerup_nuke/zm_powerup_nuke
// Params 0, eflags: 0x1 linked
// Checksum 0x73be8969, Offset: 0x380
// Size: 0xea
function function_8d3a47ed() {
    if (zm_utility::is_survival()) {
        a_players = getplayers();
        foreach (player in a_players) {
            a_enemies = player getenemiesinradius(player.origin, 3000);
            if (a_enemies.size) {
                return true;
            }
        }
        return false;
    }
    return true;
}

// Namespace zm_powerup_nuke/zm_powerup_nuke
// Params 3, eflags: 0x1 linked
// Checksum 0xf9263daf, Offset: 0x478
// Size: 0x878
function nuke_powerup(drop_item, player_team, var_264cf1f9) {
    level thread nuke_delay_spawning(3);
    location = drop_item.origin;
    if (isdefined(drop_item.fx)) {
        playfx(drop_item.fx, location);
    }
    if (!is_true(level.var_5f911d8e)) {
        level thread nuke_flash(player_team);
    }
    if (zm_utility::is_survival()) {
        a_enemies = var_264cf1f9 getenemiesinradius(location, 3000);
    } else {
        a_enemies = getaiteamarray(level.zombie_team);
    }
    foreach (ai_enemy in a_enemies) {
        ai_enemy ai::stun(1.5);
    }
    wait 0.5;
    if (zm_utility::is_survival()) {
        zombies = a_enemies;
        function_1eaaceab(zombies);
    } else {
        zombies = getaiteamarray(level.zombie_team);
    }
    zombies = arraysort(zombies, location);
    zombies_nuked = [];
    for (i = 0; i < zombies.size; i++) {
        if (is_true(zombies[i].ignore_nuke)) {
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
        if (!is_true(zombies[i].nuked) && !zm_utility::is_magic_bullet_shield_enabled(zombies[i])) {
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
        if (!is_true(zombies_nuked[i].isdog)) {
            if (!is_true(zombies_nuked[i].no_gib)) {
                zombies_nuked[i] zombie_utility::zombie_head_gib();
            }
            zombies_nuked[i] playsound(#"evt_nuked");
        }
        if (isdefined(zombies_nuked[i].archetype) && isinarray(array(#"bat", #"dog", #"zombie_dog", #"zombie"), zombies_nuked[i].archetype)) {
            level thread zm_daily_challenges::increment_nuked_zombie();
            zombies_nuked[i] kill();
        } else if (isdefined(zombies_nuked[i].archetype) && isinarray(array(#"stoker", #"gladiator", #"gladiator_marauder", #"gladiator_destroyer", #"werewolf", #"avogadro", #"raz"), zombies_nuked[i].archetype)) {
            var_c790ea95 = zombies_nuked[i].maxhealth * 0.75;
        } else if (isdefined(zombies_nuked[i].archetype) && isinarray(array(#"blight_father", #"brutus", #"gegenees", #"mechz", #"hash_7c0d83ac1e845ac2"), zombies_nuked[i].archetype)) {
            var_c790ea95 = zombies_nuked[i].maxhealth * 0.25;
        }
        if (isdefined(var_c790ea95)) {
            if (var_c790ea95 > zombies_nuked[i].health) {
                level thread zm_daily_challenges::increment_nuked_zombie();
            }
            zombies_nuked[i] dodamage(var_c790ea95, zombies_nuked[i].origin);
        }
    }
    level notify(#"nuke_complete");
    if (zm_powerups::function_cfd04802(#"nuke") && isplayer(var_264cf1f9)) {
        level scoreevents::doscoreeventcallback("scoreEventZM", {#attacker:var_264cf1f9, #scoreevent:"nuke_powerup_zm"});
        return;
    }
    foreach (e_player in level.players) {
        level scoreevents::doscoreeventcallback("scoreEventZM", {#attacker:e_player, #scoreevent:"nuke_powerup_zm"});
    }
}

// Namespace zm_powerup_nuke/zm_powerup_nuke
// Params 1, eflags: 0x1 linked
// Checksum 0xe3cb3f42, Offset: 0xcf8
// Size: 0xbc
function nuke_flash(team) {
    if (isdefined(team)) {
        getplayers()[0] playsoundtoteam("evt_nuke_flash", team);
    } else {
        getplayers()[0] playsound(#"evt_nuke_flash");
    }
    lui::screen_flash(0.2, 0.5, 1, 0.8, "white", undefined, 1);
}

// Namespace zm_powerup_nuke/zm_powerup_nuke
// Params 1, eflags: 0x1 linked
// Checksum 0xfab3c0bb, Offset: 0xdc0
// Size: 0x16c
function nuke_delay_spawning(n_spawn_delay) {
    level endoncallback(&function_406d206b, #"disable_nuke_delay_spawning");
    if (is_true(level.disable_nuke_delay_spawning)) {
        return;
    }
    b_spawn_zombies_before_nuke = level flag::get("spawn_zombies");
    level flag::set(#"hash_21921ed511559aa3");
    level flag::clear("spawn_zombies");
    level waittill(#"nuke_complete");
    if (is_true(level.disable_nuke_delay_spawning)) {
        level flag::clear(#"hash_21921ed511559aa3");
        return;
    }
    wait n_spawn_delay;
    if (!is_true(level.disable_nuke_delay_spawning) && b_spawn_zombies_before_nuke) {
        level flag::set("spawn_zombies");
    }
    level flag::clear(#"hash_21921ed511559aa3");
}

// Namespace zm_powerup_nuke/zm_powerup_nuke
// Params 1, eflags: 0x1 linked
// Checksum 0xda87a3f0, Offset: 0xf38
// Size: 0x2c
function function_406d206b(*var_c34665fc) {
    level flag::clear(#"hash_21921ed511559aa3");
}

// Namespace zm_powerup_nuke/zm_powerup_nuke
// Params 1, eflags: 0x1 linked
// Checksum 0x44e7e4a8, Offset: 0xf70
// Size: 0x2e
function function_9a79647b(var_8de6cf73) {
    self.nuke_damage_func = &nuke_damage_func;
    self.var_3b6e5508 = var_8de6cf73;
}

// Namespace zm_powerup_nuke/zm_powerup_nuke
// Params 0, eflags: 0x1 linked
// Checksum 0xf5c99e58, Offset: 0xfa8
// Size: 0xa4
function nuke_damage_func() {
    self endon(#"death");
    wait randomfloatrange(0.1, 0.7);
    self thread zombie_death::flame_death_fx();
    self playsound(#"evt_nuked");
    self dodamage(self.maxhealth * self.var_3b6e5508, self.origin);
}
