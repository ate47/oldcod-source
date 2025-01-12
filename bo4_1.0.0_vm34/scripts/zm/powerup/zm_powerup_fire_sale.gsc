#using scripts\core_common\ai\zombie_death;
#using scripts\core_common\ai\zombie_utility;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\zm_audio;
#using scripts\zm_common\zm_bgb;
#using scripts\zm_common\zm_customgame;
#using scripts\zm_common\zm_magicbox;
#using scripts\zm_common\zm_powerups;
#using scripts\zm_common\zm_score;
#using scripts\zm_common\zm_spawner;
#using scripts\zm_common\zm_utility;

#namespace zm_powerup_fire_sale;

// Namespace zm_powerup_fire_sale/zm_powerup_fire_sale
// Params 0, eflags: 0x2
// Checksum 0x45c266f2, Offset: 0x178
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"zm_powerup_fire_sale", &__init__, undefined, undefined);
}

// Namespace zm_powerup_fire_sale/zm_powerup_fire_sale
// Params 0, eflags: 0x0
// Checksum 0x341294f, Offset: 0x1c0
// Size: 0x9c
function __init__() {
    zm_powerups::register_powerup("fire_sale", &grab_fire_sale);
    if (zm_powerups::function_b2585f85()) {
        zm_powerups::add_zombie_powerup("fire_sale", "p7_zm_power_up_firesale", #"zombie/powerup_max_ammo", &func_should_drop_fire_sale, 0, 0, 0, undefined, "powerup_fire_sale", "zombie_powerup_fire_sale_time", "zombie_powerup_fire_sale_on");
    }
}

// Namespace zm_powerup_fire_sale/zm_powerup_fire_sale
// Params 1, eflags: 0x0
// Checksum 0x4afbf89f, Offset: 0x268
// Size: 0x84
function grab_fire_sale(player) {
    if (zm_powerups::function_ffd24ecc("fire_sale")) {
        level thread function_8fd36f7c(self, player);
    } else {
        level thread start_fire_sale(self);
    }
    player thread zm_powerups::powerup_vo("firesale");
}

// Namespace zm_powerup_fire_sale/zm_powerup_fire_sale
// Params 2, eflags: 0x0
// Checksum 0xc7f7b, Offset: 0x2f8
// Size: 0xf4
function function_8fd36f7c(e_powerup, player) {
    player notify(#"hash_2c4d2767debc3824");
    player endon(#"hash_2c4d2767debc3824", #"disconnect");
    player thread zm_powerups::function_e00ef9d4("fire_sale");
    player zombie_utility::set_zombie_var_player(#"zombie_powerup_fire_sale_on", 1);
    player zombie_utility::set_zombie_var_player(#"zombie_powerup_fire_sale_time", 30);
    level waittilltimeout(30, #"end_game");
    player zombie_utility::set_zombie_var_player(#"zombie_powerup_fire_sale_on", 0);
}

// Namespace zm_powerup_fire_sale/zm_powerup_fire_sale
// Params 1, eflags: 0x0
// Checksum 0xd10dc689, Offset: 0x3f8
// Size: 0x2e8
function start_fire_sale(item) {
    if (isdefined(level.custom_firesale_box_leave) && level.custom_firesale_box_leave) {
        while (firesale_chest_is_leaving()) {
            waitframe(1);
        }
    }
    if (zombie_utility::get_zombie_var(#"zombie_powerup_fire_sale_time") > 0 && isdefined(zombie_utility::get_zombie_var(#"zombie_powerup_fire_sale_on")) && zombie_utility::get_zombie_var(#"zombie_powerup_fire_sale_on")) {
        zombie_utility::set_zombie_var(#"zombie_powerup_fire_sale_time", zombie_utility::get_zombie_var(#"zombie_powerup_fire_sale_time") + 30);
        return;
    }
    level notify(#"hash_2c4d2767debc3824");
    level endon(#"hash_2c4d2767debc3824");
    level thread zm_audio::sndannouncerplayvox("fire_sale");
    zombie_utility::set_zombie_var(#"zombie_powerup_fire_sale_on", 1);
    level.disable_firesale_drop = 1;
    level thread toggle_fire_sale_on();
    zombie_utility::set_zombie_var(#"zombie_powerup_fire_sale_time", 30);
    if (bgb::is_team_enabled(#"zm_bgb_temporal_gift")) {
        zombie_utility::set_zombie_var(#"zombie_powerup_fire_sale_time", zombie_utility::get_zombie_var(#"zombie_powerup_fire_sale_time") + 30);
    }
    while (zombie_utility::get_zombie_var(#"zombie_powerup_fire_sale_time") > 0) {
        waitframe(1);
        zombie_utility::set_zombie_var(#"zombie_powerup_fire_sale_time", zombie_utility::get_zombie_var(#"zombie_powerup_fire_sale_time") - 0.05);
    }
    level thread check_to_clear_fire_sale();
    zombie_utility::set_zombie_var(#"zombie_powerup_fire_sale_on", 0);
    level notify(#"fire_sale_off");
}

// Namespace zm_powerup_fire_sale/zm_powerup_fire_sale
// Params 0, eflags: 0x0
// Checksum 0x305f1d62, Offset: 0x6e8
// Size: 0x2a
function check_to_clear_fire_sale() {
    while (firesale_chest_is_leaving()) {
        waitframe(1);
    }
    level.disable_firesale_drop = undefined;
}

// Namespace zm_powerup_fire_sale/zm_powerup_fire_sale
// Params 0, eflags: 0x0
// Checksum 0x8687fd0e, Offset: 0x720
// Size: 0xfc
function firesale_chest_is_leaving() {
    for (i = 0; i < level.chests.size; i++) {
        if (i !== level.chest_index) {
            if (level.chests[i].zbarrier.state === "leaving" || level.chests[i].zbarrier.state === "open" || level.chests[i].zbarrier.state === "close" || level.chests[i].zbarrier.state === "closing") {
                return true;
            }
        }
    }
    return false;
}

// Namespace zm_powerup_fire_sale/zm_powerup_fire_sale
// Params 0, eflags: 0x0
// Checksum 0x63c905d4, Offset: 0x828
// Size: 0x29c
function toggle_fire_sale_on() {
    level endon(#"hash_2c4d2767debc3824");
    if (!isdefined(zombie_utility::get_zombie_var(#"zombie_powerup_fire_sale_on"))) {
        return;
    }
    level thread sndfiresalemusic_start();
    for (i = 0; i < level.chests.size; i++) {
        show_firesale_box = level.chests[i] [[ level._zombiemode_check_firesale_loc_valid_func ]]();
        if (show_firesale_box) {
            level.chests[i].zombie_cost = 10;
            if (level.chest_index != i) {
                if (zm_custom::function_5638f689(#"zmmysteryboxstate") != 3) {
                    level.chests[i].was_temp = 1;
                }
                if (isdefined(level.chests[i].hidden) && level.chests[i].hidden) {
                    level.chests[i] thread apply_fire_sale_to_chest();
                }
            }
        }
    }
    level notify(#"fire_sale_on");
    level waittill(#"fire_sale_off");
    waittillframeend();
    level thread sndfiresalemusic_stop();
    for (i = 0; i < level.chests.size; i++) {
        show_firesale_box = level.chests[i] [[ level._zombiemode_check_firesale_loc_valid_func ]]();
        if (show_firesale_box) {
            if (level.chest_index != i && isdefined(level.chests[i].was_temp)) {
                level.chests[i].was_temp = undefined;
                level thread remove_temp_chest(i);
            }
            level.chests[i].zombie_cost = level.chests[i].old_cost;
        }
    }
}

// Namespace zm_powerup_fire_sale/zm_powerup_fire_sale
// Params 0, eflags: 0x0
// Checksum 0xe32eb753, Offset: 0xad0
// Size: 0x9c
function apply_fire_sale_to_chest() {
    if (self.zbarrier getzbarrierpiecestate(1) == "closing") {
        while (self.zbarrier getzbarrierpiecestate(1) == "closing") {
            wait 0.1;
        }
        self.zbarrier waittill(#"left");
    }
    wait 0.1;
    self thread zm_magicbox::show_chest();
}

// Namespace zm_powerup_fire_sale/zm_powerup_fire_sale
// Params 1, eflags: 0x0
// Checksum 0xde0fdf6c, Offset: 0xb78
// Size: 0x226
function remove_temp_chest(chest_index) {
    level.chests[chest_index].being_removed = 1;
    while (isdefined(level.chests[chest_index].chest_user) || isdefined(level.chests[chest_index]._box_open) && level.chests[chest_index]._box_open == 1) {
        util::wait_network_frame();
    }
    if (zombie_utility::get_zombie_var(#"zombie_powerup_fire_sale_on")) {
        level.chests[chest_index].was_temp = 1;
        level.chests[chest_index].zombie_cost = 10;
        level.chests[chest_index].being_removed = 0;
        return;
    }
    for (i = 0; i < chest_index; i++) {
        util::wait_network_frame();
    }
    playfx(level._effect[#"poltergeist"], level.chests[chest_index].orig_origin);
    util::wait_network_frame();
    if (isdefined(level.custom_firesale_box_leave) && level.custom_firesale_box_leave) {
        level.chests[chest_index] zm_magicbox::hide_chest(1);
    } else {
        level.chests[chest_index] zm_magicbox::hide_chest();
    }
    level.chests[chest_index].being_removed = 0;
}

// Namespace zm_powerup_fire_sale/zm_powerup_fire_sale
// Params 0, eflags: 0x0
// Checksum 0xf709448a, Offset: 0xda8
// Size: 0x92
function func_should_drop_fire_sale() {
    if (zm_custom::function_5638f689(#"zmmysteryboxstate") == 0 || zombie_utility::get_zombie_var(#"zombie_powerup_fire_sale_on") == 1 || level.chest_moves < 1 || isdefined(level.disable_firesale_drop) && level.disable_firesale_drop) {
        return false;
    }
    return true;
}

// Namespace zm_powerup_fire_sale/zm_powerup_fire_sale
// Params 0, eflags: 0x0
// Checksum 0x71d19ffc, Offset: 0xe48
// Size: 0x140
function sndfiresalemusic_start() {
    array = level.chests;
    foreach (struct in array) {
        if (!isdefined(struct.sndent)) {
            struct.sndent = spawn("script_origin", struct.origin + (0, 0, 100));
        }
        if (isdefined(level.player_4_vox_override) && level.player_4_vox_override) {
            struct.sndent playloopsound(#"mus_fire_sale_rich", 1);
            continue;
        }
        struct.sndent playloopsound(#"mus_fire_sale", 1);
    }
}

// Namespace zm_powerup_fire_sale/zm_powerup_fire_sale
// Params 0, eflags: 0x0
// Checksum 0xb4316117, Offset: 0xf90
// Size: 0xaa
function sndfiresalemusic_stop() {
    array = level.chests;
    foreach (struct in array) {
        if (isdefined(struct.sndent)) {
            struct.sndent delete();
            struct.sndent = undefined;
        }
    }
}

