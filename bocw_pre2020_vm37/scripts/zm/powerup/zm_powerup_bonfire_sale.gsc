#using scripts\core_common\ai\zombie_death;
#using scripts\core_common\ai\zombie_utility;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\zm_audio;
#using scripts\zm_common\zm_bgb;
#using scripts\zm_common\zm_magicbox;
#using scripts\zm_common\zm_powerups;
#using scripts\zm_common\zm_score;
#using scripts\zm_common\zm_spawner;
#using scripts\zm_common\zm_utility;

#namespace zm_powerup_bonfire_sale;

// Namespace zm_powerup_bonfire_sale/zm_powerup_bonfire_sale
// Params 0, eflags: 0x6
// Checksum 0xd5e02d8f, Offset: 0x1a8
// Size: 0x4c
function private autoexec __init__system__() {
    system::register(#"zm_powerup_bonfire_sale", &function_70a657d8, &postinit, undefined, undefined);
}

// Namespace zm_powerup_bonfire_sale/zm_powerup_bonfire_sale
// Params 0, eflags: 0x5 linked
// Checksum 0xaef882d, Offset: 0x200
// Size: 0x9c
function private function_70a657d8() {
    zm_powerups::register_powerup("bonfire_sale", &grab_bonfire_sale);
    if (zm_powerups::function_cc33adc8()) {
        zm_powerups::add_zombie_powerup("bonfire_sale", "p8_zm_power_up_bonfire_sale", #"zombie/powerup_max_ammo", &zm_powerups::func_should_never_drop, 0, 0, 0, undefined, "powerup_bon_fire", "zombie_powerup_bonfire_sale_time", "zombie_powerup_bonfire_sale_on");
    }
}

// Namespace zm_powerup_bonfire_sale/zm_powerup_bonfire_sale
// Params 0, eflags: 0x5 linked
// Checksum 0x80f724d1, Offset: 0x2a8
// Size: 0x4
function private postinit() {
    
}

// Namespace zm_powerup_bonfire_sale/zm_powerup_bonfire_sale
// Params 1, eflags: 0x1 linked
// Checksum 0x5a2ca30, Offset: 0x2b8
// Size: 0x44
function grab_bonfire_sale(player) {
    level thread start_bonfire_sale(self);
    player thread zm_powerups::powerup_vo("bonfiresale");
}

// Namespace zm_powerup_bonfire_sale/zm_powerup_bonfire_sale
// Params 1, eflags: 0x1 linked
// Checksum 0xc8323fb2, Offset: 0x308
// Size: 0x26c
function start_bonfire_sale(*item) {
    level notify(#"powerup bonfire sale");
    level endon(#"powerup bonfire sale");
    temp_ent = spawn("script_origin", (0, 0, 0));
    temp_ent playloopsound(#"zmb_double_point_loop");
    zombie_utility::set_zombie_var(#"zombie_powerup_bonfire_sale_on", 1);
    level thread toggle_bonfire_sale_on();
    zombie_utility::set_zombie_var(#"zombie_powerup_bonfire_sale_time", 30);
    if (bgb::is_team_enabled("zm_bgb_temporal_gift")) {
        zombie_utility::set_zombie_var(#"zombie_powerup_bonfire_sale_time", zombie_utility::function_d2dfacfd(#"zombie_powerup_bonfire_sale_time") + 30);
    }
    while (zombie_utility::function_d2dfacfd(#"zombie_powerup_bonfire_sale_time") > 0) {
        waitframe(1);
        zombie_utility::set_zombie_var(#"zombie_powerup_bonfire_sale_time", zombie_utility::function_d2dfacfd(#"zombie_powerup_bonfire_sale_time") - 0.05);
    }
    zombie_utility::set_zombie_var(#"zombie_powerup_bonfire_sale_on", 0);
    level notify(#"bonfire_sale_off");
    players = getplayers();
    for (i = 0; i < players.size; i++) {
        players[i] playsound(#"zmb_points_loop_off");
    }
    temp_ent delete();
}

// Namespace zm_powerup_bonfire_sale/zm_powerup_bonfire_sale
// Params 0, eflags: 0x1 linked
// Checksum 0x2b29c6c9, Offset: 0x580
// Size: 0x9c
function toggle_bonfire_sale_on() {
    level endon(#"powerup bonfire sale");
    if (!isdefined(zombie_utility::function_d2dfacfd(#"zombie_powerup_bonfire_sale_on"))) {
        return;
    }
    if (zombie_utility::function_d2dfacfd(#"zombie_powerup_bonfire_sale_on")) {
        if (isdefined(level.bonfire_init_func)) {
            level thread [[ level.bonfire_init_func ]]();
        }
        level waittill(#"bonfire_sale_off");
    }
}

// Namespace zm_powerup_bonfire_sale/zm_powerup_bonfire_sale
// Params 0, eflags: 0x0
// Checksum 0xff4a9d99, Offset: 0x628
// Size: 0xfc
function setup_bonfiresale_audio() {
    wait 2;
    intercom = getentarray("intercom", "targetname");
    while (true) {
        while (zombie_utility::function_d2dfacfd(#"zombie_powerup_fire_sale_on") == 0) {
            wait 0.2;
        }
        for (i = 0; i < intercom.size; i++) {
            intercom[i] thread play_bonfiresale_audio();
        }
        while (zombie_utility::function_d2dfacfd(#"zombie_powerup_fire_sale_on") == 1) {
            wait 0.1;
        }
        level notify(#"firesale_over");
    }
}

// Namespace zm_powerup_bonfire_sale/zm_powerup_bonfire_sale
// Params 0, eflags: 0x1 linked
// Checksum 0x40b4047e, Offset: 0x730
// Size: 0xb4
function play_bonfiresale_audio() {
    if (is_true(level.sndfiresalemusoff)) {
        return;
    }
    if (is_true(level.sndannouncerisrich)) {
        self playloopsound(#"mus_fire_sale_rich");
    } else {
        self playloopsound(#"mus_fire_sale");
    }
    level waittill(#"firesale_over");
    self stoploopsound();
}

