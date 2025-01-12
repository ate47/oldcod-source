#using script_6334bf874cddcc13;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\fx_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;
#using scripts\zm_common\callbacks;
#using scripts\zm_common\zm_audio;
#using scripts\zm_common\zm_characters;
#using scripts\zm_common\zm_devgui;
#using scripts\zm_common\zm_net;
#using scripts\zm_common\zm_powerups;
#using scripts\zm_common\zm_score;
#using scripts\zm_common\zm_utility;
#using scripts\zm_common\zm_vo;
#using scripts\zm_common\zm_zonemgr;

#namespace zm_towers_crowd;

// Namespace zm_towers_crowd/zm_towers_crowd
// Params 0, eflags: 0x0
// Checksum 0x814cc346, Offset: 0x660
// Size: 0x2c4
function init() {
    /#
        level thread function_2d0ffae();
    #/
    level.var_6377068d = spawnstruct();
    level.var_6377068d.a_players = [];
    level flag::init("any_round_has_started");
    level._effect[#"hash_7bd75ae600e0a590"] = "maps/zm_towers/fx8_crowd_reward_flower_exp";
    level._effect[#"hash_4c4f96aa02c32a2a"] = "maps/zm_towers/fx8_crowd_reward_flower_trail";
    level thread function_c2446fa7();
    callback::on_connect(&function_b73583ac);
    callback::on_actor_killed(&function_7bc2de1a);
    zm_powerups::powerup_set_statless_powerup("dung");
    zm_powerups::powerup_set_statless_powerup("rock");
    zm_powerups::register_powerup("dung", &function_59d753db);
    zm_powerups::add_zombie_powerup("dung", #"p7_dung_camel_pile_03", #"zombie_powerup_free_perk", &zm_powerups::func_should_never_drop, 1, 0, 0);
    zm_powerups::function_3734419a("dung", 1);
    zm_powerups::function_b10aba69("dung", 1);
    level thread function_2235bf5d();
    level thread function_73353a97();
    level thread function_49afd245();
    callback::on_spawned(&function_ce633ac8);
    a_t_crowd_damage = getentarray("t_crowd_damage", "targetname");
    array::thread_all(a_t_crowd_damage, &crowd_damage_trigger);
    /#
        zm_net::network_choke_init("<dev string:x30>", 3);
    #/
}

// Namespace zm_towers_crowd/zm_towers_crowd
// Params 0, eflags: 0x0
// Checksum 0xdc23231e, Offset: 0x930
// Size: 0x1fa
function crowd_damage_trigger() {
    self endon(#"death");
    level endon(#"end_game");
    while (true) {
        s_waitresult = self waittill(#"damage");
        player = s_waitresult.attacker;
        if (isplayer(player)) {
            player.var_7229b2ab.var_4b3d59a7 += s_waitresult.amount;
            b_explosive_damage = 0;
            if (isdefined(s_waitresult.mod)) {
                switch (s_waitresult.mod) {
                case #"mod_explosive":
                case #"mod_grenade":
                case #"mod_grenade_splash":
                case #"mod_projectile_splash":
                    b_explosive_damage = 1;
                    break;
                }
            }
            if (isdefined(s_waitresult.weapon) && isdefined(s_waitresult.weapon.isrocketlauncher) && s_waitresult.weapon.isrocketlauncher) {
                b_explosive_damage = 1;
            }
            if (player.var_7229b2ab.var_4b3d59a7 >= 150) {
                player.var_7229b2ab.var_4b3d59a7 = 0;
                if (b_explosive_damage) {
                    player function_88f58c26(#"hash_4122108abe671eb7");
                    wait 1;
                }
            }
        }
    }
}

// Namespace zm_towers_crowd/zm_towers_crowd
// Params 0, eflags: 0x0
// Checksum 0x463d26e9, Offset: 0xb38
// Size: 0x5e
function function_c5e4b9a6() {
    n_amount = self.var_7229b2ab.var_1cfaf808;
    if (n_amount >= 50 || isdefined(self.var_7229b2ab.var_593d5471) && self.var_7229b2ab.var_593d5471) {
        return true;
    }
    return false;
}

// Namespace zm_towers_crowd/zm_towers_crowd
// Params 0, eflags: 0x0
// Checksum 0x1381cfc3, Offset: 0xba0
// Size: 0x5e
function function_6b3edb18() {
    n_amount = self.var_7229b2ab.var_1cfaf808;
    if (n_amount <= -50 || isdefined(self.var_7229b2ab.var_76a66aff) && self.var_7229b2ab.var_76a66aff) {
        return true;
    }
    return false;
}

// Namespace zm_towers_crowd/zm_towers_crowd
// Params 1, eflags: 0x0
// Checksum 0xbe9d9fe8, Offset: 0xc08
// Size: 0x110
function function_77f68f25(b_enable = 1) {
    foreach (var_794311d8 in array("siege_crowds_grp27", "siege_zm_crowds_indv_1", "siege_zm_crowds_indv_2", "siege_zm_crowds_indv_3", "siege_zm_crowds_indv_4", "siege_zm_crowds_indv_5", "siege_zm_crowds_indv_6", "siege_zm_crowds_indv_7", "siege_zm_crowds_indv_8", "siege_zm_crowds_indv_9", "siege_zm_crowds_indv_10")) {
        if (b_enable) {
            showmiscmodels(var_794311d8);
            continue;
        }
        hidemiscmodels(var_794311d8);
    }
}

// Namespace zm_towers_crowd/zm_towers_crowd
// Params 1, eflags: 0x0
// Checksum 0x323da5d8, Offset: 0xd20
// Size: 0x5c
function function_5c8e025a(b_enable = 1) {
    if (b_enable) {
        showmiscmodels("siege_crowds_outro");
        return;
    }
    hidemiscmodels("siege_crowds_outro");
}

// Namespace zm_towers_crowd/zm_towers_crowd
// Params 1, eflags: 0x0
// Checksum 0x37201744, Offset: 0xd88
// Size: 0x8c
function function_5ff4429f(b_enable = 1) {
    if (b_enable) {
        showmiscmodels("siege_crowds_battle");
        showmiscmodels("siege_crowds_battle_card");
        return;
    }
    hidemiscmodels("siege_crowds_battle");
    hidemiscmodels("siege_crowds_battle_card");
}

// Namespace zm_towers_crowd/zm_towers_crowd
// Params 0, eflags: 0x0
// Checksum 0x8c312b5b, Offset: 0xe20
// Size: 0x54
function function_73353a97() {
    level endon(#"end_game");
    level waittill(#"start_of_round");
    level flag::set("any_round_has_started");
}

// Namespace zm_towers_crowd/zm_towers_crowd
// Params 1, eflags: 0x0
// Checksum 0x58dc7402, Offset: 0xe80
// Size: 0x110
function function_59d753db(e_player) {
    e_player zm_score::player_reduce_points("take_specified", 250);
    if (self.powerup_name === "dung") {
        e_player playsound(#"hash_66a500811a472fac");
        e_player clientfield::set_to_player("" + #"pickup_dung", 1);
        e_player util::delay(5, "disconnect", &clientfield::set_to_player, "" + #"pickup_dung", 0);
        level notify(#"hash_694f58e8bc5dd48", {#e_player:e_player});
    }
}

// Namespace zm_towers_crowd/zm_towers_crowd
// Params 1, eflags: 0x0
// Checksum 0x43406cce, Offset: 0xf98
// Size: 0x2e4
function function_7bc2de1a(params) {
    switch (self.archetype) {
    case #"stoker":
    case #"gladiator":
        str_event = #"heavy_kill";
        break;
    case #"tiger":
        str_event = #"tiger_kill";
        break;
    case #"blight_father":
        str_event = #"miniboss_kill";
        break;
    case #"elephant":
        str_event = #"elephant_kill";
        break;
    case #"elephant_rider":
        str_event = #"hash_29a47f9b217e8b1c";
        break;
    case #"zombie":
        if (self.missinglegs) {
            str_event = #"crawler_kill";
        }
        break;
    }
    if (isplayer(params.eattacker)) {
        player = params.eattacker;
        player.var_7229b2ab.n_zombie_kills++;
        player notify(#"hash_4093e684a539c91d");
        if (player.var_7229b2ab.n_zombie_kills == 10) {
            player function_88f58c26(#"hash_158076998c9b511f");
        }
        if (str_event === #"heavy_kill") {
            if (!player.var_7229b2ab.var_8163df11) {
                player.var_7229b2ab.var_8163df11 = 1;
                player function_88f58c26(#"hash_131b705484b2876");
            } else {
                player function_88f58c26(#"heavy_kill");
            }
            return;
        }
        if (str_event === #"tiger_kill") {
            if (!player.var_7229b2ab.var_a486f7dd) {
                player.var_7229b2ab.var_a486f7dd = 1;
                player function_88f58c26(#"hash_19fccc380453c9fa");
            }
            return;
        }
        if (isdefined(str_event)) {
            player function_88f58c26(str_event);
        }
    }
}

// Namespace zm_towers_crowd/zm_towers_crowd
// Params 0, eflags: 0x0
// Checksum 0x3d28a2d2, Offset: 0x1288
// Size: 0x15c
function function_b73583ac() {
    self.var_7229b2ab = spawnstruct();
    self.var_7229b2ab.var_673bfb22 = #"hash_4977f8aaa598d06c";
    self.var_7229b2ab.var_bc5f6a40 = #"hash_4977f8aaa598d06c";
    self.var_7229b2ab.var_1cfaf808 = 0;
    self.var_7229b2ab.var_eb15391c = 0;
    self.var_7229b2ab.var_f3147ffb = 0;
    self.var_7229b2ab.var_4b3d59a7 = 0;
    self.var_7229b2ab.n_zombie_kills = 0;
    self.var_7229b2ab.var_8163df11 = 0;
    self.var_7229b2ab.var_a486f7dd = 0;
    self.var_7229b2ab.var_fd37a7a6 = 0;
    self flag::init("crowd_item_thrown_out_for_round_good");
    self flag::init("crowd_item_thrown_out_for_round_bad");
    self thread function_39591a90();
    self thread function_ed6c6d56();
    self thread function_437ba48c();
}

// Namespace zm_towers_crowd/zm_towers_crowd
// Params 0, eflags: 0x0
// Checksum 0xbda3e590, Offset: 0x13f0
// Size: 0xcc
function function_437ba48c() {
    level endon(#"end_game");
    self endon(#"disconnect");
    level flag::wait_till("any_round_has_started");
    if (!level.var_f24d2121 zm_towers_crowd_meter::is_open(self) && !zm_utility::is_standard()) {
        level.var_f24d2121 zm_towers_crowd_meter::set_visible(self, 1);
        level.var_f24d2121 zm_towers_crowd_meter::open(self);
    }
}

// Namespace zm_towers_crowd/zm_towers_crowd
// Params 2, eflags: 0x0
// Checksum 0x54251436, Offset: 0x14c8
// Size: 0x9c
function function_d3d3dcf0(b_enable = 1, b_close = 0) {
    level.var_f24d2121 zm_towers_crowd_meter::set_visible(self, b_enable);
    if (b_close) {
        if (level.var_f24d2121 zm_towers_crowd_meter::is_open(self)) {
            level.var_f24d2121 zm_towers_crowd_meter::close(self);
        }
    }
}

// Namespace zm_towers_crowd/zm_towers_crowd
// Params 0, eflags: 0x0
// Checksum 0x1bb44f10, Offset: 0x1570
// Size: 0xe0
function function_ed6c6d56() {
    level endon(#"end_game");
    self endon(#"disconnect");
    level flag::wait_till("start_zombie_round_logic");
    while (true) {
        s_waitresult = self waittilltimeout(240, #"hash_4093e684a539c91d", #"death");
        if (isalive(self) && s_waitresult._notify == "timeout") {
            self function_88f58c26(#"hash_1ecab55fd270f67b");
        }
    }
}

// Namespace zm_towers_crowd/zm_towers_crowd
// Params 0, eflags: 0x0
// Checksum 0xe43756c7, Offset: 0x1658
// Size: 0x710
function function_2235bf5d() {
    level endon(#"end_game");
    level flag::init(#"crowd_throw_item_immediate");
    level flag::init(#"hash_1a9f6d0c1e7684b4");
    level flag::init(#"hash_80fa0541e21f744");
    level.var_507a7522 = 20;
    callback::function_8def5e51(&function_8def5e51);
    level flag::wait_till("start_zombie_round_logic");
    while (true) {
        level.var_507a7522 = 20;
        while (level.var_507a7522 > 0 && !level flag::get("crowd_throw_item_immediate")) {
            wait 1;
            level.var_507a7522 -= 1;
        }
        var_7ccb15ec = [];
        var_64c0c028 = [];
        foreach (player in level.players) {
            if (isalive(player) && player.var_7229b2ab.var_1cfaf808 >= 40) {
                if (!isdefined(var_7ccb15ec)) {
                    var_7ccb15ec = [];
                } else if (!isarray(var_7ccb15ec)) {
                    var_7ccb15ec = array(var_7ccb15ec);
                }
                if (!isinarray(var_7ccb15ec, player)) {
                    var_7ccb15ec[var_7ccb15ec.size] = player;
                }
            }
            if (isalive(player) && player.var_7229b2ab.var_1cfaf808 <= -40) {
                if (!isdefined(var_64c0c028)) {
                    var_64c0c028 = [];
                } else if (!isarray(var_64c0c028)) {
                    var_64c0c028 = array(var_64c0c028);
                }
                if (!isinarray(var_64c0c028, player)) {
                    var_64c0c028[var_64c0c028.size] = player;
                }
            }
        }
        if (var_7ccb15ec.size && var_64c0c028.size) {
            var_6419afda = arraycombine(var_7ccb15ec, var_64c0c028, 0, 0);
            e_target_player = function_3c04bc1a(var_6419afda);
        } else if (var_7ccb15ec.size) {
            e_target_player = function_3c04bc1a(var_7ccb15ec);
        } else if (var_64c0c028.size) {
            e_target_player = function_3c04bc1a(var_64c0c028);
        } else if (level flag::get(#"crowd_throw_item_immediate")) {
            e_target_player = function_3c04bc1a(level.activeplayers);
        }
        if (!isalive(e_target_player)) {
            continue;
        }
        str_player_zone = e_target_player zm_zonemgr::get_player_zone();
        var_9886c0c0 = e_target_player.var_7229b2ab.var_1cfaf808;
        for (n_time = 10; isalive(e_target_player) && !level flag::get(#"crowd_throw_item_immediate") && n_time > 0; n_time -= 1) {
            if (str_player_zone === "zone_starting_area_ra" || str_player_zone === "zone_starting_area_odin" || str_player_zone === "zone_starting_area_danu" || str_player_zone === "zone_starting_area_zeus") {
                break;
            }
            str_player_zone = e_target_player zm_zonemgr::get_player_zone();
            wait 1;
        }
        if (!isalive(e_target_player) || n_time <= 0 || isdefined(e_target_player.var_7229b2ab.var_1b295554) && e_target_player.var_7229b2ab.var_1b295554) {
            level flag::clear(#"crowd_throw_item_immediate");
            continue;
        }
        if (level flag::get(#"crowd_throw_item_immediate") || function_f9988fad(var_9886c0c0) && !e_target_player flag::get(#"crowd_item_thrown_out_for_round_good") || function_de61fbc1(var_9886c0c0) && !e_target_player flag::get(#"crowd_item_thrown_out_for_round_bad")) {
            if (!level flag::get(#"crowd_throw_item_immediate")) {
                if (function_f9988fad(var_9886c0c0)) {
                    e_target_player flag::set(#"crowd_item_thrown_out_for_round_good");
                } else if (function_de61fbc1(var_9886c0c0)) {
                    e_target_player flag::set(#"crowd_item_thrown_out_for_round_bad");
                }
            }
            e_target_player thread crowd_throw_item(var_9886c0c0);
        }
        level flag::clear(#"crowd_throw_item_immediate");
    }
}

// Namespace zm_towers_crowd/zm_towers_crowd
// Params 1, eflags: 0x0
// Checksum 0x9a91daf8, Offset: 0x1d70
// Size: 0x22
function function_f9988fad(var_9886c0c0) {
    if (var_9886c0c0 >= 40) {
        return true;
    }
    return false;
}

// Namespace zm_towers_crowd/zm_towers_crowd
// Params 1, eflags: 0x0
// Checksum 0x5c734bc0, Offset: 0x1da0
// Size: 0x22
function function_de61fbc1(var_9886c0c0) {
    if (var_9886c0c0 <= -40) {
        return true;
    }
    return false;
}

// Namespace zm_towers_crowd/zm_towers_crowd
// Params 1, eflags: 0x0
// Checksum 0xdb98fdc9, Offset: 0x1dd0
// Size: 0x150
function function_3c04bc1a(a_players) {
    if (level flag::get(#"crowd_throw_item_immediate")) {
        e_target_player = array::random(a_players);
    } else {
        foreach (player in a_players) {
            var_1cfaf808 = player.var_7229b2ab.var_1cfaf808;
            if (function_f9988fad(var_1cfaf808) && !player flag::get(#"crowd_item_thrown_out_for_round_good") || function_de61fbc1(var_1cfaf808) && !player flag::get(#"crowd_item_thrown_out_for_round_bad")) {
                e_target_player = player;
                break;
            }
        }
    }
    return e_target_player;
}

// Namespace zm_towers_crowd/zm_towers_crowd
// Params 0, eflags: 0x0
// Checksum 0xd0807eb, Offset: 0x1f28
// Size: 0xa8
function function_8def5e51() {
    foreach (player in level.players) {
        player flag::clear(#"crowd_item_thrown_out_for_round_good");
        player flag::clear(#"crowd_item_thrown_out_for_round_bad");
    }
}

// Namespace zm_towers_crowd/zm_towers_crowd
// Params 1, eflags: 0x0
// Checksum 0xd8aaa9fb, Offset: 0x1fd8
// Size: 0xe5a
function crowd_throw_item(var_9886c0c0) {
    var_968f6e4e = struct::get_array("s_crowd_item_start");
    var_26834b3d = [];
    self.var_7229b2ab.var_1b295554 = 1;
    var_cce19f69 = 0;
    if (var_9886c0c0 <= -40 || level flag::get(#"hash_80fa0541e21f744")) {
        if (level flag::get(#"hash_80fa0541e21f744")) {
            var_a8b5fc6d = arraycombine(array("dung"), array("rock"), 0, 0);
        } else if (var_9886c0c0 <= -50 && level flag::get("zm_towers_pap_quest_completed")) {
            var_a8b5fc6d = array("dung");
        } else {
            var_a8b5fc6d = array("rock");
        }
    } else if (var_9886c0c0 >= 40 || level flag::get(#"hash_1a9f6d0c1e7684b4")) {
        if (level flag::get(#"hash_1a9f6d0c1e7684b4")) {
            var_a8b5fc6d = arraycombine(array("double_points", "bonus_points_player", "insta_kill"), array("hero_weapon_power"), 0, 0);
        } else if (var_9886c0c0 >= 50 && !zm_utility::is_standard()) {
            var_a8b5fc6d = array("hero_weapon_power");
        } else {
            var_a8b5fc6d = array("double_points", "bonus_points_player", "insta_kill");
        }
        var_cce19f69 = 1;
    } else {
        var_a8b5fc6d = array("double_points", "bonus_points_player", "insta_kill");
        var_cce19f69 = 1;
    }
    if (var_cce19f69 && var_9886c0c0 >= 50) {
        self.var_7229b2ab.var_593d5471 = 1;
    } else if (!var_cce19f69 && var_9886c0c0 <= -50) {
        self.var_7229b2ab.var_76a66aff = 1;
    }
    self function_54e72a5a(undefined, var_cce19f69);
    foreach (s_loc in var_968f6e4e) {
    }
    while (true) {
        if (!isalive(self)) {
            return;
        }
        foreach (s_loc in var_968f6e4e) {
            if (self util::is_player_looking_at(s_loc.origin, 0.95, 1, self)) {
                if (!isdefined(var_26834b3d)) {
                    var_26834b3d = [];
                } else if (!isarray(var_26834b3d)) {
                    var_26834b3d = array(var_26834b3d);
                }
                var_26834b3d[var_26834b3d.size] = s_loc;
            }
        }
        if (var_26834b3d.size) {
            break;
        }
        waitframe(1);
    }
    var_274fc91f = array::random(var_26834b3d);
    s_target_loc = array::random(struct::get_array(var_274fc91f.target));
    foreach (s_loc in var_968f6e4e) {
        if (isdefined(s_loc.var_bbb63d01)) {
            s_loc.var_bbb63d01 delete();
        }
    }
    level flag::clear(#"hash_80fa0541e21f744");
    level flag::clear(#"hash_1a9f6d0c1e7684b4");
    str_powerup = array::random(var_a8b5fc6d);
    if (!isdefined(level.zombie_powerups[str_powerup])) {
        if (str_powerup === "rock") {
            e_item = util::spawn_model(#"hash_5a78e7591a2e5e39", var_274fc91f.origin, var_274fc91f.angles);
            e_item fx::play(#"hash_4c4f96aa02c32a2a", e_item.origin, e_item.angles, "crowd_item_fly_fx_stop", 1);
            e_item setscale(8);
            n_time = e_item zm_utility::fake_physicslaunch(self geteye(), 5000);
            wait n_time;
            if (isalive(self)) {
                v_player_angles = self getplayerangles();
                v_pos = self geteye() + anglestoforward(v_player_angles) * 100;
                e_item moveto(v_pos, 0.05);
                self dodamage(5, v_pos);
                self shellshock(#"pain_zm", 3);
                /#
                    self thread zm_net::network_choke_action("<dev string:x30>", &function_833e58d8, self.name + "<dev string:x48>");
                #/
            }
            wait 0.05;
            if (isdefined(e_item)) {
                e_item notify(#"crowd_item_fly_fx_stop");
                e_item delete();
            }
        }
    } else {
        var_497266a7 = array::random(array(#"p8_fxanim_zm_towers_crowd_jar_01_mod", #"p8_fxanim_zm_towers_crowd_jar_02_mod", #"p8_fxanim_zm_towers_crowd_jar_03_mod"));
        e_item = util::spawn_model(var_497266a7, var_274fc91f.origin, var_274fc91f.angles);
        e_item fx::play(#"hash_4c4f96aa02c32a2a", e_item.origin, e_item.angles, "crowd_item_fly_fx_stop", 1);
        n_time = e_item zm_utility::fake_physicslaunch(s_target_loc.origin, 600);
        wait n_time;
        fx::play(#"hash_7bd75ae600e0a590", s_target_loc.origin, s_target_loc.angles + (270, 0, 0));
        e_item notify(#"crowd_item_fly_fx_stop");
        e_item.origin = s_target_loc.origin;
        switch (var_497266a7) {
        case #"p8_fxanim_zm_towers_crowd_jar_01_mod":
            s_target_loc thread scene::play("p8_fxanim_zm_towers_crowd_jar_01_bundle", e_item);
            break;
        case #"p8_fxanim_zm_towers_crowd_jar_02_mod":
            s_target_loc thread scene::play("p8_fxanim_zm_towers_crowd_jar_02_bundle", e_item);
            break;
        case #"p8_fxanim_zm_towers_crowd_jar_03_mod":
            s_target_loc thread scene::play("p8_fxanim_zm_towers_crowd_jar_03_bundle", e_item);
            break;
        }
        earthquake(0.3, 0.5, s_target_loc.origin, 256);
        if (isalive(self)) {
            e_powerup = zm_powerups::specific_powerup_drop(str_powerup, s_target_loc.origin);
            if (str_powerup === "dung") {
                e_powerup moveto(groundtrace(e_powerup.origin + (0, 0, 8), e_powerup.origin + (0, 0, -100000), 0, e_powerup)[#"position"] + (0, 0, 0), 0.25);
                e_powerup setscale(3);
                e_powerup playloopsound("zmb_dung_lp");
            }
            s_waitresult = e_powerup waittill(#"powerup_grabbed", #"powerup_timedout", #"powerup_stolen", #"hacked", #"death");
            var_b5a9d4 = s_waitresult.e_grabber;
            if (isplayer(var_b5a9d4) && var_cce19f69 == 1) {
                var_b5a9d4 notify(#"hash_62f05feef69e1ed4");
            }
            if (isplayer(var_b5a9d4) && isplayer(self)) {
                if (var_b5a9d4 == self) {
                    /#
                        self thread zm_net::network_choke_action("<dev string:x30>", &function_833e58d8, var_b5a9d4.name + "<dev string:x78>" + str_powerup + "<dev string:x82>");
                    #/
                } else {
                    if (str_powerup == "hero_weapon_power" || str_powerup == "bonus_points_player") {
                        var_b5a9d4.var_7229b2ab.var_f3147ffb++;
                        if (var_b5a9d4.var_7229b2ab.var_f3147ffb > 5) {
                            var_b5a9d4 function_88f58c26(#"hash_3d85834be3aff6d2");
                        } else {
                            var_b5a9d4 function_88f58c26(#"stole_crowd_item");
                        }
                    }
                    /#
                        thread zm_net::network_choke_action("<dev string:x30>", &function_833e58d8, var_b5a9d4.name + "<dev string:x93>" + self.name + "<dev string:x9b>" + str_powerup);
                    #/
                }
            }
        }
    }
    if (isdefined(self)) {
        self.var_7229b2ab.var_1b295554 = undefined;
        self.var_7229b2ab.var_593d5471 = undefined;
        self.var_7229b2ab.var_76a66aff = undefined;
        self function_54e72a5a(self.var_7229b2ab.var_bc5f6a40);
    }
    level.var_507a7522 = 20;
}

// Namespace zm_towers_crowd/zm_towers_crowd
// Params 1, eflags: 0x0
// Checksum 0x82b28a64, Offset: 0x2e40
// Size: 0x556
function function_88f58c26(str_event) {
    if (isdefined(level.var_dcc8a45d) && level.var_dcc8a45d) {
        return;
    }
    var_a0b31f5e = 0;
    switch (str_event) {
    case #"hash_158076998c9b511f":
        var_1f968bc7 = 5;
        break;
    case #"hash_19fccc380453c9fa":
        var_1f968bc7 = 3;
        break;
    case #"crawler_kill":
        var_1f968bc7 = 1;
        break;
    case #"hash_131b705484b2876":
        var_1f968bc7 = 15;
        var_a0b31f5e = 1;
        break;
    case #"heavy_kill":
        var_1f968bc7 = 8;
        break;
    case #"miniboss_kill":
        var_1f968bc7 = 20;
        if (!self.var_7229b2ab.var_fd37a7a6) {
            self.var_7229b2ab.var_fd37a7a6 = 1;
            var_a0b31f5e = 1;
        }
        break;
    case #"elephant_kill":
        var_1f968bc7 = 30;
        var_a0b31f5e = 1;
        break;
    case #"hash_29a47f9b217e8b1c":
        var_1f968bc7 = 10;
        var_a0b31f5e = 1;
        break;
    case #"hash_c65bc15b1aeb1bb":
        var_1f968bc7 = 5;
        break;
    case #"hash_c65bd15b1aeb36e":
        var_1f968bc7 = 5;
        break;
    case #"hash_c65be15b1aeb521":
        var_1f968bc7 = 5;
        break;
    case #"hash_2048e4bc4cd51960":
        var_1f968bc7 = 5;
        break;
    case #"trap_activated":
        var_1f968bc7 = 5;
        var_a0b31f5e = 1;
        break;
    case #"trap_kill":
        var_1f968bc7 = 1;
        break;
    case #"hash_689abcb17111463":
        var_1f968bc7 = 3;
        break;
    case #"hash_197ae1fc115dc636":
        var_1f968bc7 = 7;
        break;
    case #"hash_5d587a946bd4f958":
        var_1f968bc7 = 15;
        var_a0b31f5e = 1;
        break;
    case #"hash_5986c925a370e137":
        var_1f968bc7 = 20;
        break;
    case #"hash_4122108abe671eb7":
        var_1f968bc7 = -25;
        break;
    case #"hash_7d48d521481272cf":
        var_1f968bc7 = -2;
        break;
    case #"player_down":
        var_1f968bc7 = -7;
        break;
    case #"player_death":
        var_1f968bc7 = -13;
        break;
    case #"hash_1f2dfda53e67bf22":
        var_1f968bc7 = -12;
        break;
    case #"crawler_created":
        var_1f968bc7 = -1;
        break;
    case #"hash_1ecab55fd270f67b":
        var_1f968bc7 = -20;
        break;
    case #"hash_1dc206ff31de03eb":
        var_1f968bc7 = -2;
        break;
    case #"stole_crowd_item":
        var_1f968bc7 = -1;
        break;
    case #"hash_3d85834be3aff6d2":
        var_1f968bc7 = -15;
        break;
    case #"broken_shield":
        var_1f968bc7 = -10;
        break;
    case #"hazard_hit":
        var_1f968bc7 = -10;
        break;
    case #"hash_74fc45698491be88":
        var_1f968bc7 = -15;
        break;
    default:
        var_1f968bc7 = 0;
        break;
    }
    /#
        self thread zm_net::network_choke_action("<dev string:x30>", &function_833e58d8, str_event);
    #/
    if (self.var_7229b2ab.var_1cfaf808 <= 0 && self.var_7229b2ab.var_1cfaf808 + var_1f968bc7 >= 0 || self.var_7229b2ab.var_1cfaf808 >= 0 && self.var_7229b2ab.var_1cfaf808 + var_1f968bc7 <= 0) {
        var_a0b31f5e = 1;
    }
    self.var_7229b2ab.var_1cfaf808 += var_1f968bc7;
    self.var_7229b2ab.var_1cfaf808 = math::clamp(self.var_7229b2ab.var_1cfaf808, -50, 50);
    self thread function_3b54653a(var_1f968bc7, var_a0b31f5e);
    self notify(#"hash_22071b25b85ea046");
}

/#

    // Namespace zm_towers_crowd/zm_towers_crowd
    // Params 1, eflags: 0x0
    // Checksum 0x98a9ba8d, Offset: 0x33a0
    // Size: 0xd4
    function function_833e58d8(str_text) {
        if (ishash(str_text)) {
            if (isplayer(self)) {
                self iprintlnbold(function_15979fa9(str_text));
            } else {
                iprintlnbold(function_15979fa9(str_text));
            }
            return;
        }
        if (isplayer(self)) {
            self iprintlnbold(str_text);
            return;
        }
        iprintlnbold(str_text);
    }

#/

// Namespace zm_towers_crowd/zm_towers_crowd
// Params 2, eflags: 0x0
// Checksum 0x3077e683, Offset: 0x3480
// Size: 0x2a4
function function_3b54653a(var_1f968bc7 = 0, var_a0b31f5e = 0) {
    n_amount = self.var_7229b2ab.var_1cfaf808;
    if (!isdefined(level.var_651df98d)) {
        level.var_651df98d = 0;
    }
    level.var_1bc7ea81 = level.var_651df98d;
    var_2cee9a08 = #"hash_12d62358eda9bdf1";
    if (n_amount <= -50) {
        var_2cee9a08 = #"hash_752852f7958f9112";
        level.var_651df98d = 1;
    } else if (n_amount > -50 && n_amount <= -25) {
        var_2cee9a08 = #"hash_1cf3b5099b38de89";
        level.var_651df98d = 1;
    } else if (n_amount > -25 && n_amount <= 0) {
        var_2cee9a08 = #"hash_4977f8aaa598d06c";
        level.var_651df98d = 0;
    } else if (n_amount > 0 && n_amount <= 25) {
        var_2cee9a08 = #"hash_7dc7bbe5b45f4135";
        level.var_651df98d = 2;
    } else if (n_amount > 25 && n_amount < 50) {
        var_2cee9a08 = #"hash_ad45e7c545f8482";
        level.var_651df98d = 3;
    } else if (n_amount >= 50) {
        var_2cee9a08 = #"hash_1fe268f088f7e729";
        level.var_651df98d = 3;
    }
    self.var_7229b2ab.var_bc5f6a40 = var_2cee9a08;
    self function_54e72a5a(self.var_7229b2ab.var_bc5f6a40);
    if (!self.var_7229b2ab.var_eb15391c || var_a0b31f5e) {
        self thread function_40c4dada(var_2cee9a08, var_1f968bc7, var_a0b31f5e);
        return;
    }
    /#
        self thread zm_net::network_choke_action("<dev string:x30>", &function_833e58d8, "<dev string:x9f>");
    #/
}

// Namespace zm_towers_crowd/zm_towers_crowd
// Params 3, eflags: 0x0
// Checksum 0x7efc03b2, Offset: 0x3730
// Size: 0x454
function function_40c4dada(var_d02e7cd5, var_1f968bc7, var_a0b31f5e = 0) {
    str_name = self.name;
    var_476c0a6a = "";
    var_5f4d47e9 = 0;
    var_abd10ccc = 0;
    if ((self.var_7229b2ab.var_673bfb22 == #"hash_752852f7958f9112" || self.var_7229b2ab.var_673bfb22 == #"hash_1cf3b5099b38de89" || self.var_7229b2ab.var_673bfb22 == #"hash_4977f8aaa598d06c") && (var_d02e7cd5 == #"hash_752852f7958f9112" || var_d02e7cd5 == #"hash_1cf3b5099b38de89" || var_d02e7cd5 == #"hash_4977f8aaa598d06c") && var_1f968bc7 > 0) {
        var_5f4d47e9 = 1;
    } else if ((self.var_7229b2ab.var_673bfb22 == #"hash_7dc7bbe5b45f4135" || self.var_7229b2ab.var_673bfb22 == #"hash_ad45e7c545f8482" || self.var_7229b2ab.var_673bfb22 == #"hash_1fe268f088f7e729") && (var_d02e7cd5 == #"hash_7dc7bbe5b45f4135" || var_d02e7cd5 == #"hash_ad45e7c545f8482" || var_d02e7cd5 == #"hash_1fe268f088f7e729") && var_1f968bc7 <= 0) {
        var_abd10ccc = 1;
    }
    level clientfield::set("crowd_react", level.var_651df98d);
    self.var_7229b2ab.var_673bfb22 = var_d02e7cd5;
    switch (var_d02e7cd5) {
    case #"hash_752852f7958f9112":
        var_300cff68 = 0;
        break;
    case #"hash_1cf3b5099b38de89":
        var_300cff68 = 1;
        break;
    case #"hash_4977f8aaa598d06c":
        var_300cff68 = 2;
        break;
    case #"hash_7dc7bbe5b45f4135":
        var_300cff68 = 3;
        break;
    case #"hash_ad45e7c545f8482":
        var_300cff68 = 4;
        break;
    case #"hash_1fe268f088f7e729":
        var_300cff68 = 5;
        break;
    }
    if (var_5f4d47e9) {
        var_300cff68 = 7;
    } else if (var_abd10ccc) {
        var_300cff68 = 6;
    }
    if (level flag::get("special_round")) {
        if (var_300cff68 != 5) {
            self clientfield::set_to_player("snd_crowd_react", var_300cff68);
        }
    } else if (isdefined(level.var_c92d185a) && level.var_c92d185a) {
        if (var_300cff68 != 5) {
            self clientfield::set_to_player("snd_crowd_react", var_300cff68);
        }
    } else {
        self clientfield::set_to_player("snd_crowd_react", var_300cff68);
    }
    /#
        self thread zm_net::network_choke_action("<dev string:x30>", &function_833e58d8, function_15979fa9(var_d02e7cd5) + self.name);
    #/
    if (!var_a0b31f5e) {
        self thread function_46c36e83();
    }
}

// Namespace zm_towers_crowd/zm_towers_crowd
// Params 0, eflags: 0x0
// Checksum 0xeb60c706, Offset: 0x3b90
// Size: 0x316
function function_ce633ac8() {
    level endon(#"end_game");
    self endon(#"death");
    if (zm_utility::is_standard()) {
        return;
    }
    var_10bb1954 = array(#"hash_752852f7958f9112", #"hash_1cf3b5099b38de89", #"hash_4977f8aaa598d06c", #"hash_7dc7bbe5b45f4135", #"hash_ad45e7c545f8482", #"hash_1fe268f088f7e729");
    var_fd037c55 = self.var_7229b2ab.var_bc5f6a40;
    var_9bf29db0 = array::find(var_10bb1954, var_fd037c55);
    while (true) {
        b_announcer = 0;
        self waittill(#"hash_22071b25b85ea046");
        var_aff8cd52 = self.var_7229b2ab.var_bc5f6a40;
        var_6be6604d = array::find(var_10bb1954, var_aff8cd52);
        if (var_aff8cd52 == var_fd037c55) {
            continue;
        }
        switch (var_aff8cd52) {
        case #"hash_752852f7958f9112":
            str_category = "negative_terrible";
            break;
        case #"hash_1cf3b5099b38de89":
            str_category = "negative_poor";
            break;
        case #"hash_4977f8aaa598d06c":
            str_category = "negative_poor";
            break;
        case #"hash_7dc7bbe5b45f4135":
            b_announcer = 1;
            str_category = "positive_good";
            break;
        case #"hash_ad45e7c545f8482":
            b_announcer = 1;
            str_category = "positive_great";
            break;
        case #"hash_1fe268f088f7e729":
            b_announcer = 1;
            str_category = "positive_immac";
            break;
        }
        if (var_6be6604d < var_9bf29db0 && var_aff8cd52 != #"hash_752852f7958f9112") {
            b_announcer = 0;
            str_category = "negative_poor";
        }
        if (var_6be6604d > var_9bf29db0 && var_aff8cd52 != #"hash_1fe268f088f7e729") {
            str_category = "positive_good";
        }
        self thread function_88b49fb8(str_category, b_announcer);
        var_fd037c55 = var_aff8cd52;
        var_9bf29db0 = var_6be6604d;
        wait 5;
    }
}

// Namespace zm_towers_crowd/zm_towers_crowd
// Params 2, eflags: 0x0
// Checksum 0xa2dd5ba6, Offset: 0x3eb0
// Size: 0xdc
function function_88b49fb8(str_category, b_announcer) {
    self notify("14f79d10401c7283");
    self endon("14f79d10401c7283");
    self endon(#"death");
    if (b_announcer) {
        level zm_audio::sndannouncerplayvox(#"hash_5f0f1e699aa7e761", self);
    }
    str_zone = self zm_zonemgr::get_player_zone();
    if (!isinarray(level.var_de31807a, str_zone)) {
        return;
    }
    self thread zm_vo::function_59635cc4("crowd_" + str_category, 0, 0, undefined, 1, 1);
}

// Namespace zm_towers_crowd/zm_towers_crowd
// Params 0, eflags: 0x0
// Checksum 0x663b27a2, Offset: 0x3f98
// Size: 0x25c
function function_49afd245() {
    var_3a325ae8 = 0;
    level.var_c92d185a = 0;
    while (true) {
        level waittill(#"end_of_round");
        level.var_c92d185a = 1;
        if (!(isdefined(level.var_dcc8a45d) && level.var_dcc8a45d)) {
            foreach (player in level.players) {
                if (isdefined(var_3a325ae8) && var_3a325ae8) {
                    player clientfield::set_to_player("snd_crowd_react", 15);
                    var_3a325ae8 = 0;
                    continue;
                }
                player clientfield::set_to_player("snd_crowd_react", 10);
            }
        }
        level waittill(#"start_of_round");
        level util::delay(18, "end_of_round", &function_3c1a4f9d);
        if (!(isdefined(level.var_dcc8a45d) && level.var_dcc8a45d)) {
            foreach (player in level.players) {
                if (level flag::get("special_round")) {
                    player clientfield::set_to_player("snd_crowd_react", 14);
                    var_3a325ae8 = 1;
                    continue;
                }
                player clientfield::set_to_player("snd_crowd_react", 9);
            }
        }
    }
}

// Namespace zm_towers_crowd/zm_towers_crowd
// Params 0, eflags: 0x0
// Checksum 0x40f7f6ab, Offset: 0x4200
// Size: 0xe8
function function_3c1a4f9d() {
    level.var_c92d185a = 0;
    if (!(isdefined(level.var_dcc8a45d) && level.var_dcc8a45d)) {
        if (!level flag::get("special_round")) {
            foreach (player in level.players) {
                if (player function_c5e4b9a6()) {
                    player clientfield::set_to_player("snd_crowd_react", 5);
                }
            }
        }
    }
}

// Namespace zm_towers_crowd/zm_towers_crowd
// Params 2, eflags: 0x0
// Checksum 0x32df96ad, Offset: 0x42f0
// Size: 0x2e2
function function_54e72a5a(var_d02e7cd5, var_cce19f69) {
    if (zm_utility::is_standard()) {
        return;
    }
    if (!level.var_f24d2121 zm_towers_crowd_meter::is_open(self)) {
        level.var_f24d2121 zm_towers_crowd_meter::open(self);
    }
    if (isdefined(self.var_7229b2ab.var_1b295554) && self.var_7229b2ab.var_1b295554) {
        if (isdefined(var_cce19f69)) {
            if (var_cce19f69) {
                if (self.var_7229b2ab.var_1cfaf808 >= 50) {
                    level.var_f24d2121 zm_towers_crowd_meter::set_state(self, "crowd_power_up_available_good");
                } else {
                    level.var_f24d2121 zm_towers_crowd_meter::set_state(self, "crowd_power_up_available_good_partial");
                }
                return;
            }
            if (self.var_7229b2ab.var_1cfaf808 <= -50) {
                level.var_f24d2121 zm_towers_crowd_meter::set_state(self, "crowd_power_up_available_bad");
                return;
            }
            level.var_f24d2121 zm_towers_crowd_meter::set_state(self, "crowd_power_up_available_bad_partial");
        }
        return;
    }
    if (isdefined(var_d02e7cd5)) {
        switch (var_d02e7cd5) {
        case #"hash_752852f7958f9112":
            level.var_f24d2121 zm_towers_crowd_meter::set_state(self, "crowd_loathes");
            break;
        case #"hash_1cf3b5099b38de89":
            level.var_f24d2121 zm_towers_crowd_meter::set_state(self, "crowd_hates");
            break;
        case #"hash_4977f8aaa598d06c":
            level.var_f24d2121 zm_towers_crowd_meter::set_state(self, "crowd_no_love");
            break;
        case #"hash_7dc7bbe5b45f4135":
            level.var_f24d2121 zm_towers_crowd_meter::set_state(self, "crowd_warm_up");
            break;
        case #"hash_ad45e7c545f8482":
            level.var_f24d2121 zm_towers_crowd_meter::set_state(self, "crowd_likes");
            break;
        case #"hash_1fe268f088f7e729":
            level.var_f24d2121 zm_towers_crowd_meter::set_state(self, "crowd_loves");
            break;
        }
    }
}

// Namespace zm_towers_crowd/zm_towers_crowd
// Params 0, eflags: 0x4
// Checksum 0x3bbfb4c, Offset: 0x45e0
// Size: 0xd2
function private function_46c36e83() {
    self notify("6931ac4209d9bfae");
    self endon("6931ac4209d9bfae");
    self endon(#"disconnect");
    /#
        if (level flag::get("<dev string:xe0>")) {
            return;
        }
    #/
    self.var_7229b2ab.var_eb15391c = 1;
    if (self.var_7229b2ab.var_1cfaf808 >= 50 || self.var_7229b2ab.var_1cfaf808 <= -50) {
        n_cooldown = 20;
    } else {
        n_cooldown = 10;
    }
    wait n_cooldown;
    self.var_7229b2ab.var_eb15391c = 0;
}

// Namespace zm_towers_crowd/zm_towers_crowd
// Params 0, eflags: 0x0
// Checksum 0x779d1896, Offset: 0x46c0
// Size: 0x228
function function_c2446fa7() {
    level endon(#"end_game");
    while (true) {
        waitresult = level waittill(#"crawler_created", #"trap_kill", #"trap_activated");
        switch (waitresult._notify) {
        case #"crawler_created":
            e_player = waitresult.player;
            if (!isplayer(e_player)) {
                continue;
            }
            if (waitresult.weapon === level.w_crossbow || waitresult.weapon === level.w_crossbow_upgraded) {
                str_event = #"hash_689abcb17111463";
            } else {
                waitresult.zombie function_e16f5b08(e_player);
            }
            break;
        case #"trap_activated":
            e_player = waitresult.trap_activator;
            str_event = #"trap_activated";
            break;
        case #"trap_kill":
            if (isplayer(waitresult.e_victim)) {
                e_player = waitresult.e_victim;
                str_event = #"hash_1f2dfda53e67bf22";
            } else {
                e_player = waitresult.e_trap.activated_by_player;
                str_event = #"trap_kill";
            }
            break;
        }
        if (isplayer(e_player) && isdefined(str_event)) {
            e_player function_88f58c26(str_event);
        }
    }
}

// Namespace zm_towers_crowd/zm_towers_crowd
// Params 0, eflags: 0x0
// Checksum 0x6a151c4f, Offset: 0x48f0
// Size: 0x25e
function function_39591a90() {
    level endon(#"end_game");
    self endon(#"disconnect");
    while (true) {
        waitresult = self waittill(#"player_downed", #"bled_out", #"player_did_a_revive", #"hash_53620e40c7e139b9", #"destroy_riotshield", #"hash_74fc45698491be88", #"hazard_hit");
        switch (waitresult._notify) {
        case #"player_downed":
            str_event = #"player_down";
            break;
        case #"bled_out":
            str_event = #"player_death";
            break;
        case #"player_did_a_revive":
            if (waitresult.revived_player != self) {
                if (waitresult.revived_player.bleedout_time < 5) {
                    str_event = #"hash_5d587a946bd4f958";
                } else {
                    str_event = #"hash_197ae1fc115dc636";
                }
            }
            break;
        case #"hash_53620e40c7e139b9":
            str_event = #"hash_1dc206ff31de03eb";
            break;
        case #"destroy_riotshield":
            str_event = #"broken_shield";
            break;
        case #"hazard_hit":
            str_event = #"hazard_hit";
            break;
        case #"hash_74fc45698491be88":
            str_event = #"hash_74fc45698491be88";
            break;
        }
        if (isdefined(str_event)) {
            self function_88f58c26(str_event);
            str_event = undefined;
        }
    }
}

// Namespace zm_towers_crowd/zm_towers_crowd
// Params 1, eflags: 0x0
// Checksum 0x209d4c21, Offset: 0x4b58
// Size: 0x70
function function_e16f5b08(e_player) {
    self endon(#"death");
    e_player endon(#"disconnect");
    while (isalive(self)) {
        wait 10;
        e_player function_88f58c26(#"crawler_created");
    }
}

/#

    // Namespace zm_towers_crowd/zm_towers_crowd
    // Params 0, eflags: 0x0
    // Checksum 0x56fa0f4f, Offset: 0x4bd0
    // Size: 0x3bc
    function function_2d0ffae() {
        level flag::init("<dev string:xfe>");
        level flag::init("<dev string:xe0>");
        zm_devgui::add_custom_devgui_callback(&function_84bd12d9);
        adddebugcommand("<dev string:x11c>");
        adddebugcommand("<dev string:x179>");
        adddebugcommand("<dev string:x1df>");
        adddebugcommand("<dev string:x24b>");
        adddebugcommand("<dev string:x2b5>");
        adddebugcommand("<dev string:x309>");
        adddebugcommand("<dev string:x379>");
        adddebugcommand("<dev string:x3c9>");
        adddebugcommand("<dev string:x41f>");
        adddebugcommand("<dev string:x46d>");
        adddebugcommand("<dev string:x4c5>");
        adddebugcommand("<dev string:x51f>");
        adddebugcommand("<dev string:x57b>");
        adddebugcommand("<dev string:x5d7>");
        adddebugcommand("<dev string:x641>");
        adddebugcommand("<dev string:x6c6>");
        adddebugcommand("<dev string:x71c>");
        adddebugcommand("<dev string:x77e>");
        adddebugcommand("<dev string:x7e6>");
        adddebugcommand("<dev string:x84e>");
        adddebugcommand("<dev string:x8b6>");
        adddebugcommand("<dev string:x918>");
        adddebugcommand("<dev string:x99a>");
        adddebugcommand("<dev string:x9ec>");
        adddebugcommand("<dev string:xa40>");
        adddebugcommand("<dev string:xa99>");
        adddebugcommand("<dev string:xaf3>");
        adddebugcommand("<dev string:xb4f>");
        adddebugcommand("<dev string:xbcd>" + 240 + "<dev string:xc0e>");
        adddebugcommand("<dev string:xc3f>");
        adddebugcommand("<dev string:xca9>");
        adddebugcommand("<dev string:xd24>");
        adddebugcommand("<dev string:xd81>");
        adddebugcommand("<dev string:xddb>");
        level thread function_596954ce();
    }

    // Namespace zm_towers_crowd/zm_towers_crowd
    // Params 0, eflags: 0x0
    // Checksum 0x3cb1cb2d, Offset: 0x4f98
    // Size: 0x102
    function function_596954ce() {
        while (true) {
            if (level flag::get("<dev string:xfe>")) {
                foreach (i, player in level.players) {
                    debug2dtext((1100, 300 + 20 * i, 0), player.name + "<dev string:xe43>" + player.var_7229b2ab.var_1cfaf808, undefined, undefined, undefined, 1);
                }
            }
            waitframe(1);
        }
    }

    // Namespace zm_towers_crowd/zm_towers_crowd
    // Params 1, eflags: 0x0
    // Checksum 0x571a636c, Offset: 0x50a8
    // Size: 0x4fa
    function function_84bd12d9(cmd) {
        switch (cmd) {
        case #"hash_b988aa7a2727ae5":
            level flag::set(#"crowd_throw_item_immediate");
            level flag::set(#"hash_1a9f6d0c1e7684b4");
            level flag::clear(#"hash_80fa0541e21f744");
            break;
        case #"hash_4840e9ef3902deb3":
            level flag::set(#"crowd_throw_item_immediate");
            level flag::clear(#"hash_1a9f6d0c1e7684b4");
            level flag::set(#"hash_80fa0541e21f744");
            break;
        case #"hash_4f715fd76b8686d":
            level flag::toggle("<dev string:xe0>");
            if (level flag::get("<dev string:xe0>")) {
                thread zm_net::network_choke_action("<dev string:x30>", &function_833e58d8, "<dev string:xe57>");
                foreach (player in level.players) {
                    player.var_7229b2ab.var_eb15391c = 0;
                }
            } else {
                thread zm_net::network_choke_action("<dev string:x30>", &function_833e58d8, "<dev string:xe84>" + 10 + "<dev string:xeb5>");
            }
            break;
        case #"hash_f7e831658b8fb28":
            level flag::toggle("<dev string:xfe>");
            break;
        case #"hash_689abcb17111463":
        case #"elephant_kill":
        case #"hash_c65bc15b1aeb1bb":
        case #"hash_c65bd15b1aeb36e":
        case #"hash_c65be15b1aeb521":
        case #"broken_shield":
        case #"hash_158076998c9b511f":
        case #"stole_crowd_item":
        case #"hash_197ae1fc115dc636":
        case #"hash_19fccc380453c9fa":
        case #"hash_1dc206ff31de03eb":
        case #"hash_1ecab55fd270f67b":
        case #"hash_1f2dfda53e67bf22":
        case #"crawler_kill":
        case #"hash_2048e4bc4cd51960":
        case #"heavy_kill":
        case #"hash_29a47f9b217e8b1c":
        case #"hash_3d85834be3aff6d2":
        case #"hash_4122108abe671eb7":
        case #"trap_kill":
        case #"hash_131b705484b2876":
        case #"crawler_created":
        case #"trap_activated":
        case #"hash_5986c925a370e137":
        case #"hash_5d587a946bd4f958":
        case #"hazard_hit":
        case #"player_down":
        case #"player_death":
        case #"hash_74fc45698491be88":
        case #"miniboss_kill":
        case #"hash_7d48d521481272cf":
            foreach (player in level.activeplayers) {
                var_56883d9a = hash(cmd);
                player function_88f58c26(var_56883d9a);
            }
            break;
        }
    }

#/
