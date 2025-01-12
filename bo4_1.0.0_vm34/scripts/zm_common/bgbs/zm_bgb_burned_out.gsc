#using scripts\core_common\array_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\zm_bgb;
#using scripts\zm_common\zm_stats;
#using scripts\zm_common\zm_utility;

#namespace zm_bgb_burned_out;

// Namespace zm_bgb_burned_out/zm_bgb_burned_out
// Params 0, eflags: 0x2
// Checksum 0xa2b0eac5, Offset: 0x138
// Size: 0x44
function autoexec __init__system__() {
    system::register(#"zm_bgb_burned_out", &__init__, undefined, #"bgb");
}

// Namespace zm_bgb_burned_out/zm_bgb_burned_out
// Params 0, eflags: 0x0
// Checksum 0x99308fe3, Offset: 0x188
// Size: 0x164
function __init__() {
    if (!(isdefined(level.bgb_in_use) && level.bgb_in_use)) {
        return;
    }
    bgb::register(#"zm_bgb_burned_out", "event", &event, undefined, undefined, undefined);
    clientfield::register("toplayer", "zm_bgb_burned_out" + "_1p" + "toplayer", 1, 1, "counter");
    clientfield::register("allplayers", "zm_bgb_burned_out" + "_3p" + "_allplayers", 1, 1, "counter");
    clientfield::register("actor", "zm_bgb_burned_out" + "_fire_torso" + "_actor", 1, 1, "counter");
    clientfield::register("vehicle", "zm_bgb_burned_out" + "_fire_torso" + "_vehicle", 1, 1, "counter");
}

// Namespace zm_bgb_burned_out/zm_bgb_burned_out
// Params 0, eflags: 0x0
// Checksum 0x2be54af4, Offset: 0x2f8
// Size: 0x178
function event() {
    self endon(#"disconnect");
    self endon(#"bgb_update");
    var_63a08f52 = 0;
    self thread bgb::set_timer(3, 3);
    for (;;) {
        waitresult = self waittill(#"damage", #"damage_armor");
        type = waitresult.mod;
        attacker = waitresult.attacker;
        if ("MOD_MELEE" != type || !isai(attacker)) {
            continue;
        }
        self thread result();
        self playsound(#"zmb_bgb_powerup_burnedout");
        var_63a08f52++;
        self thread bgb::set_timer(3 - var_63a08f52, 3);
        self bgb::do_one_shot_use();
        if (3 <= var_63a08f52) {
            return;
        }
        wait 1.5;
    }
}

// Namespace zm_bgb_burned_out/zm_bgb_burned_out
// Params 0, eflags: 0x0
// Checksum 0x598bafbc, Offset: 0x478
// Size: 0x30e
function result() {
    self clientfield::increment_to_player("zm_bgb_burned_out" + "_1p" + "toplayer");
    self clientfield::increment("zm_bgb_burned_out" + "_3p" + "_allplayers");
    zombies = array::get_all_closest(self.origin, getaiteamarray(level.zombie_team), undefined, undefined, 128);
    if (!isdefined(zombies)) {
        return;
    }
    dist_sq = 128 * 128;
    var_c8f67e5c = [];
    for (i = 0; i < zombies.size; i++) {
        if (isdefined(zombies[i].ignore_nuke) && zombies[i].ignore_nuke) {
            continue;
        }
        if (isdefined(zombies[i].marked_for_death) && zombies[i].marked_for_death) {
            continue;
        }
        if (zm_utility::is_magic_bullet_shield_enabled(zombies[i])) {
            continue;
        }
        zombies[i].marked_for_death = 1;
        if (isvehicle(zombies[i])) {
            zombies[i] clientfield::increment("zm_bgb_burned_out" + "_fire_torso" + "_vehicle");
        } else {
            zombies[i] clientfield::increment("zm_bgb_burned_out" + "_fire_torso" + "_actor");
        }
        var_c8f67e5c[var_c8f67e5c.size] = zombies[i];
    }
    for (i = 0; i < var_c8f67e5c.size; i++) {
        util::wait_network_frame();
        if (!isdefined(var_c8f67e5c[i])) {
            continue;
        }
        if (zm_utility::is_magic_bullet_shield_enabled(var_c8f67e5c[i])) {
            continue;
        }
        var_c8f67e5c[i] dodamage(var_c8f67e5c[i].health + 666, var_c8f67e5c[i].origin);
        self zm_stats::increment_challenge_stat("GUM_GOBBLER_BURNED_OUT");
    }
}

