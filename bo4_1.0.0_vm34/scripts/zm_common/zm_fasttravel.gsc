#using scripts\core_common\ai\zombie_utility;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\exploder_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\core_common\vehicle_shared;
#using scripts\zm_common\trials\zm_trial_disable_buys;
#using scripts\zm_common\zm_audio;
#using scripts\zm_common\zm_bgb;
#using scripts\zm_common\zm_devgui;
#using scripts\zm_common\zm_score;
#using scripts\zm_common\zm_unitrigger;
#using scripts\zm_common\zm_utility;

#namespace zm_fasttravel;

// Namespace zm_fasttravel/zm_fasttravel
// Params 0, eflags: 0x2
// Checksum 0x72d0f32f, Offset: 0x340
// Size: 0x44
function autoexec __init__system__() {
    system::register(#"zm_fasttravel", &__init__, &__main__, undefined);
}

// Namespace zm_fasttravel/zm_fasttravel
// Params 0, eflags: 0x0
// Checksum 0x83895825, Offset: 0x390
// Size: 0xbc
function __init__() {
    init_clientfields();
    function_73748e46("power_on");
    level flag::init(#"disable_fast_travel");
    /#
        zm_devgui::add_custom_devgui_callback(&function_6b043adf);
        adddebugcommand("<dev string:x30>");
        adddebugcommand("<dev string:x81>");
        adddebugcommand("<dev string:xd0>");
    #/
}

// Namespace zm_fasttravel/zm_fasttravel
// Params 0, eflags: 0x0
// Checksum 0xd813b52d, Offset: 0x458
// Size: 0x154
function init_clientfields() {
    clientfield::register("world", "fasttravel_exploder", 1, 1, "int");
    clientfield::register("toplayer", "player_stargate_fx", 1, 1, "int");
    clientfield::register("toplayer", "player_chaos_light_rail_fx", 1, 1, "int");
    clientfield::register("toplayer", "fasttravel_teleport_sfx", 1, 1, "int");
    clientfield::register("allplayers", "fasttravel_start_fx", 1, 1, "counter");
    clientfield::register("allplayers", "fasttravel_end_fx", 1, 1, "counter");
    clientfield::register("allplayers", "fasttravel_rail_fx", 1, 2, "int");
}

// Namespace zm_fasttravel/zm_fasttravel
// Params 1, eflags: 0x0
// Checksum 0xbf93a542, Offset: 0x5b8
// Size: 0x2a
function function_73748e46(str_flag) {
    if (!isdefined(level.var_8b3ad83a)) {
        level.var_8b3ad83a = str_flag;
    }
}

// Namespace zm_fasttravel/zm_fasttravel
// Params 0, eflags: 0x0
// Checksum 0xf8cdc454, Offset: 0x5f0
// Size: 0x24e
function __main__() {
    var_bcd205ed = struct::get_array("fasttravel_trigger", "targetname");
    foreach (s_loc in var_bcd205ed) {
        level thread function_90075de7(s_loc);
    }
    callback::on_connect(&function_ce7e7de0);
    level.var_50999ca6 = [];
    for (i = 0; i < 4; i++) {
        level.var_50999ca6[i] = 0;
    }
    var_875117f5 = getentarray("fasttravel_dropout", "targetname");
    foreach (var_df0dbc71 in var_875117f5) {
        var_df0dbc71 sethintstring(#"hash_499c3242364f1755");
        var_df0dbc71 thread function_d577f470();
    }
    if (!(isdefined(level.var_76123e8b) && level.var_76123e8b)) {
        level thread function_20ca5eb3();
    }
    s_room = struct::get("s_teleport_room_1", "targetname");
    if (isdefined(s_room)) {
        level.var_5ed1c47d = 1;
    }
}

// Namespace zm_fasttravel/zm_fasttravel
// Params 0, eflags: 0x0
// Checksum 0x175b03c9, Offset: 0x848
// Size: 0xe
function function_ce7e7de0() {
    self.var_bf7ec16c = [];
}

// Namespace zm_fasttravel/zm_fasttravel
// Params 1, eflags: 0x0
// Checksum 0x2949f5dd, Offset: 0x860
// Size: 0x274
function function_90075de7(s_loc) {
    s_loc.unitrigger_stub = spawnstruct();
    s_loc.unitrigger_stub.origin = s_loc.origin;
    s_loc.unitrigger_stub.angles = s_loc.angles;
    s_loc.unitrigger_stub.script_unitrigger_type = "unitrigger_box_use";
    s_loc.unitrigger_stub.cursor_hint = "HINT_NOICON";
    s_loc.unitrigger_stub.require_look_at = 0;
    s_loc.unitrigger_stub.script_string = s_loc.script_string;
    s_loc.unitrigger_stub.script_noteworthy = s_loc.script_noteworthy;
    s_loc.unitrigger_stub.var_9fb157b5 = s_loc.var_9fb157b5;
    s_loc.unitrigger_stub.var_7e252f66 = s_loc.var_7e252f66;
    s_loc.unitrigger_stub.zombie_cost = s_loc.zombie_cost;
    s_loc.unitrigger_stub.var_796a4e2a = s_loc.unitrigger_stub.script_string;
    s_loc.unitrigger_stub.delay = s_loc.delay;
    s_loc.unitrigger_stub.used = 0;
    if (isdefined(s_loc.unitrigger_stub.delay)) {
        s_loc.unitrigger_stub flag::init("delayed");
    }
    if (isdefined(level.var_6a5cf7c6)) {
        s_loc [[ level.var_6a5cf7c6 ]]();
    }
    s_loc.unitrigger_stub.prompt_and_visibility_func = &function_6bc505b5;
    zm_unitrigger::unitrigger_force_per_player_triggers(s_loc.unitrigger_stub, 1);
    zm_unitrigger::register_static_unitrigger(s_loc.unitrigger_stub, &function_3fedd7ef);
}

// Namespace zm_fasttravel/zm_fasttravel
// Params 1, eflags: 0x0
// Checksum 0x2a354558, Offset: 0xae0
// Size: 0x200
function function_6bc505b5(player) {
    if (!isdefined(self.hint_string)) {
        self.hint_string = [];
    }
    n_player_index = player getentitynumber();
    if (!(isdefined(player.var_56c7266a) && player.var_56c7266a)) {
        self setvisibletoplayer(player);
    } else {
        self setinvisibletoplayer(player);
    }
    if (isdefined(level.var_18e96d09)) {
        var_a3338832 = self [[ level.var_18e96d09 ]](player, self.stub.var_796a4e2a);
    } else {
        var_a3338832 = self function_302c8417(player, self.stub.var_796a4e2a);
    }
    if (!(isdefined(player.var_bf7ec16c[self.stub.var_796a4e2a]) && player.var_bf7ec16c[self.stub.var_796a4e2a])) {
        if (isdefined(player.var_9dcfe945)) {
            n_cost = player.var_9dcfe945;
        } else if (isdefined(self.stub)) {
            n_cost = self.stub.zombie_cost;
        } else {
            n_cost = self.zombie_cost;
        }
    }
    if (isdefined(n_cost)) {
        self sethintstringforplayer(player, self.hint_string[n_player_index], n_cost);
    } else {
        self sethintstringforplayer(player, self.hint_string[n_player_index]);
    }
    return var_a3338832;
}

// Namespace zm_fasttravel/zm_fasttravel
// Params 2, eflags: 0x0
// Checksum 0x5a2d5b87, Offset: 0xce8
// Size: 0x1e6
function function_302c8417(player, var_796a4e2a) {
    b_result = 0;
    if (!isdefined(self.hint_string)) {
        self.hint_string = [];
    }
    n_player_index = player getentitynumber();
    if (!self function_a2ffb0c6(player)) {
        self.hint_string[n_player_index] = #"";
    } else if (isdefined(self.stub.var_7e252f66) && !level flag::get(self.stub.var_7e252f66)) {
        self.hint_string[n_player_index] = #"zombie/fasttravel_locked";
        b_result = 1;
    } else if (isdefined(player.var_bf7ec16c[var_796a4e2a]) && player.var_bf7ec16c[var_796a4e2a]) {
        self.hint_string[n_player_index] = #"hash_7667bd0f83307360";
        b_result = 1;
    } else if (isdefined(self.stub.delay) && !self.stub flag::get("delayed")) {
        self.hint_string[n_player_index] = #"zombie/fasttravel_delay";
        b_result = 1;
    } else {
        self.hint_string[n_player_index] = #"hash_2731cc5c1208e2e4";
        b_result = 1;
    }
    return b_result;
}

// Namespace zm_fasttravel/zm_fasttravel
// Params 1, eflags: 0x0
// Checksum 0x8fc2e33f, Offset: 0xed8
// Size: 0xfc
function function_a2ffb0c6(player) {
    if (!level flag::get(level.var_8b3ad83a)) {
        return 0;
    }
    if (!zombie_utility::is_player_valid(player)) {
        return 0;
    }
    if (isdefined(player.var_56c7266a) && player.var_56c7266a && self.stub.script_string !== "dropout") {
        return 0;
    }
    if (isdefined(player.var_14f171d3) && player.var_14f171d3) {
        return 0;
    }
    if (level flag::get(#"disable_fast_travel")) {
        return 0;
    }
    return 1;
}

// Namespace zm_fasttravel/zm_fasttravel
// Params 0, eflags: 0x0
// Checksum 0xa419d41, Offset: 0xfe0
// Size: 0x398
function function_3fedd7ef() {
    var_796a4e2a = self.stub.var_796a4e2a;
    while (true) {
        waitresult = self waittill(#"trigger");
        player = waitresult.activator;
        if (player zm_utility::in_revive_trigger()) {
            continue;
        }
        if (player zm_utility::is_drinking()) {
            continue;
        }
        if (zm_trial_disable_buys::is_active()) {
            continue;
        }
        if (isdefined(player.var_14f171d3) && player.var_14f171d3) {
            continue;
        }
        if (isdefined(player.var_56c7266a) && player.var_56c7266a) {
            continue;
        }
        if (!zm_utility::is_player_valid(player)) {
            continue;
        }
        if (isdefined(self.stub.var_7e252f66) && !level flag::get(self.stub.var_7e252f66)) {
            continue;
        }
        if (isdefined(player.var_bf7ec16c[var_796a4e2a]) && player.var_bf7ec16c[var_796a4e2a]) {
            continue;
        }
        if (isdefined(self.stub.delay) && !self.stub flag::get("delayed")) {
            continue;
        }
        if (isdefined(player.var_9dcfe945)) {
            n_cost = player.var_9dcfe945;
        } else if (isdefined(self.stub)) {
            n_cost = self.stub.zombie_cost;
        } else {
            n_cost = self.zombie_cost;
        }
        if (isdefined(level.var_a4b4dee4)) {
            n_cost = player [[ level.var_a4b4dee4 ]](self);
        }
        if (!player zm_score::can_player_purchase(n_cost)) {
            /#
                player iprintln("<dev string:x119>");
            #/
            player zm_audio::create_and_play_dialog("general", "outofmoney");
            continue;
        }
        player zm_score::minus_to_player_score(n_cost);
        level notify(#"fasttravel_bought", {#player:player});
        player notify(#"fasttravel_bought");
        if (isdefined(level.var_7482bc0e)) {
            player [[ level.var_7482bc0e ]](self);
        }
        if (isdefined(self.stub)) {
            player thread function_bf42ac38(self.stub, self.stub.var_9fb157b5);
            continue;
        }
        player thread function_bf42ac38(self);
    }
}

// Namespace zm_fasttravel/zm_fasttravel
// Params 2, eflags: 0x0
// Checksum 0x5f269b40, Offset: 0x1380
// Size: 0x47c
function function_bf42ac38(s_loc, var_2a0cc96d = 0) {
    n_index = get_player_index(self);
    var_9482b07c = s_loc.script_string;
    self.var_56982890 = var_9482b07c;
    self.var_fc6fd274 = 1;
    self.var_b11668ad = 0;
    self.var_de91f30f = 1;
    var_78c56e18 = s_loc.script_noteworthy;
    var_796a4e2a = s_loc.var_796a4e2a;
    s_loc.used = 1;
    switch (var_78c56e18) {
    case #"traverse":
        if (var_2a0cc96d) {
            if (var_9482b07c === "dropout") {
                n_idx = self.var_3918d346;
            } else {
                n_idx = function_5dc680b2(var_9482b07c);
                if (!isdefined(n_idx)) {
                    return;
                }
                self.var_3918d346 = n_idx;
            }
            nd_path_start = getvehiclenode("fasttravel_" + var_9482b07c + "_start_" + n_idx, "targetname");
            var_4deb6ca = getvehiclenode("fasttravel_" + var_9482b07c + "_zipline_end_" + n_idx, "targetname");
            str_notify = "fasttravel_" + var_9482b07c + "_zipline_end_" + n_idx;
        } else {
            nd_path_start = getvehiclenode("fasttravel_" + var_9482b07c + "_start", "targetname");
            s_end = struct::get(var_9482b07c + "_end_" + n_index);
            str_notify = var_9482b07c + "_end";
        }
        var_47ee7db6 = getent("veh_fasttravel_cam", "targetname");
        self function_fa685767(var_47ee7db6, nd_path_start, undefined, str_notify, undefined, s_loc);
        break;
    case #"teleport":
        n_idx = function_5dc680b2(var_9482b07c);
        if (!isdefined(n_idx)) {
            return;
        }
        self.var_3918d346 = n_idx;
        s_end = struct::get(var_9482b07c + "_end_" + n_index);
        str_notify = "fasttravel_" + var_9482b07c + "_end_" + n_idx;
        self function_fa685767(undefined, undefined, undefined, str_notify, s_end, s_loc);
        break;
    }
    if (isdefined(level.var_8ffc2d68)) {
        self thread [[ level.var_8ffc2d68 ]]();
    }
    if (isdefined(self.var_b7bc1a68)) {
        n_cooldown_timer = self.var_b7bc1a68;
    } else if (isdefined(level.var_b7bc1a68)) {
        n_cooldown_timer = level.var_b7bc1a68;
    } else {
        n_cooldown_timer = 30;
    }
    self thread function_c46eef43(n_cooldown_timer, var_796a4e2a);
    if (!var_2a0cc96d && !self.var_b11668ad) {
        self setorigin(s_end.origin);
        self setplayerangles(s_end.angles);
    }
    self.var_fc6fd274 = 0;
    self.var_56c7266a = 0;
    self thread function_1927f355();
}

// Namespace zm_fasttravel/zm_fasttravel
// Params 0, eflags: 0x0
// Checksum 0x391824a2, Offset: 0x1808
// Size: 0xea
function function_1927f355() {
    self endon(#"disconnect");
    while (true) {
        foreach (e_player in level.activeplayers) {
            if (self != e_player) {
                if (distance2dsquared(e_player.origin, self.origin) < 18 * 18) {
                    wait 0.1;
                }
            }
        }
        break;
    }
    self.var_de91f30f = undefined;
}

// Namespace zm_fasttravel/zm_fasttravel
// Params 1, eflags: 0x0
// Checksum 0x5e174b4b, Offset: 0x1900
// Size: 0x9c
function function_5dc680b2(str_loc) {
    var_604e0e83 = level.var_50999ca6.size;
    for (i = 0; i < var_604e0e83; i++) {
        n_idx = randomint(var_604e0e83);
        if (level.var_50999ca6[n_idx] == 0) {
            level.var_50999ca6[n_idx] = 1;
            return n_idx;
        }
    }
    return undefined;
}

// Namespace zm_fasttravel/zm_fasttravel
// Params 1, eflags: 0x0
// Checksum 0xa411b7cf, Offset: 0x19a8
// Size: 0x6e
function get_player_index(e_player) {
    a_players = getplayers(e_player.team);
    for (i = 0; i < a_players.size; i++) {
        if (e_player == a_players[i]) {
            return i;
        }
    }
}

// Namespace zm_fasttravel/zm_fasttravel
// Params 6, eflags: 0x0
// Checksum 0x147f21e6, Offset: 0x1a20
// Size: 0x784
function function_fa685767(var_47ee7db6, nd_path_start, var_4deb6ca, str_notify, s_end, s_loc) {
    self.var_fa6d2a24 = 1;
    self.var_56c7266a = 1;
    if (isdefined(s_loc)) {
        self.var_cdec605d = s_loc.script_string;
    }
    self val::set(#"fasttravel", "ignoreme", 1);
    self val::set(#"fasttravel", "disable_weapons", 1);
    self val::set(#"fasttravel", "freezecontrols", 1);
    self bgb::suspend_weapon_cycling();
    self.bgb_disabled = 1;
    self util::magic_bullet_shield();
    str_stance = self getstance();
    switch (str_stance) {
    case #"crouch":
        self setstance("stand");
        wait 0.2;
        break;
    case #"prone":
        self setstance("stand");
        wait 1;
        break;
    }
    self notify(#"hash_1c35eb15aa210d6");
    self stopsounds();
    self ghost();
    self thread function_345768b3();
    self clientfield::increment("fasttravel_start_fx", 1);
    self.var_2c8b91cd = 1;
    if (isdefined(var_47ee7db6)) {
        self.var_13f86a82 = spawner::simple_spawn_single(var_47ee7db6);
        self.var_13f86a82 setignorepauseworld(1);
        if (isdefined(level.var_2684a605)) {
            self.var_13f86a82 setacceleration(level.var_2684a605);
        } else {
            self.var_13f86a82 setacceleration(40);
        }
        if (isdefined(level.var_e3c3e322)) {
            self.var_13f86a82 setspeed(level.var_e3c3e322);
        } else {
            self.var_13f86a82 setspeed(55);
        }
        self.var_13f86a82 setturningability(0.03);
        self.var_13f86a82.origin = nd_path_start.origin;
        self.var_13f86a82.angles = nd_path_start.angles;
        self setorigin(nd_path_start.origin);
        self setplayerangles(nd_path_start.angles);
        self.var_13f86a82.e_parent = self;
        if (isdefined(level.var_4b03d246) && level.var_4b03d246) {
            self playerlinktodelta(self.var_13f86a82, undefined, 0.5, 0, 0, 0, 0);
        } else {
            self playerlinktodelta(self.var_13f86a82, undefined, 0.5, 30, 30, 15, 30);
        }
        self val::reset(#"fasttravel", "freezecontrols");
        self allowcrouch(0);
        self allowprone(0);
        self.var_13f86a82 vehicle::get_on_path(nd_path_start);
        util::wait_network_frame();
        self clientfield::set("fasttravel_rail_fx", 1);
        self clientfield::set_to_player("player_chaos_light_rail_fx", 1);
        self thread function_3e7d7064(var_4deb6ca);
    } else if (isdefined(level.var_5ed1c47d) && level.var_5ed1c47d) {
        self thread function_3d5a6a13(s_end);
    } else {
        self thread function_a21aa4d1(s_end);
    }
    self.var_2c8b91cd = undefined;
    self waittill(#"fasttravel_over");
    if (isdefined(var_47ee7db6)) {
        self clientfield::set("fasttravel_rail_fx", 0);
        self clientfield::set_to_player("player_chaos_light_rail_fx", 0);
        util::wait_network_frame();
        self allowcrouch(1);
        self allowprone(1);
    } else {
        self val::reset(#"fasttravel", "freezecontrols");
    }
    self clientfield::increment("fasttravel_end_fx", 1);
    self.var_fa6d2a24 = 0;
    self.bgb_disabled = 0;
    self bgb::resume_weapon_cycling();
    self val::reset(#"fasttravel", "disable_weapons");
    self show();
    if (isdefined(self.var_3918d346)) {
        level.var_50999ca6[self.var_3918d346] = 0;
    }
    if (isdefined(str_notify)) {
        level notify(str_notify);
    }
    self notify(#"fasttravel_finished");
    self val::reset(#"fasttravel", "ignoreme");
    self.var_56c7266a = 0;
    self.var_cdec605d = undefined;
    self util::stop_magic_bullet_shield();
}

// Namespace zm_fasttravel/zm_fasttravel
// Params 1, eflags: 0x0
// Checksum 0x39e1ec3a, Offset: 0x21b0
// Size: 0x15e
function function_a21aa4d1(s_end) {
    var_e2050768 = self.origin;
    self playrumbleonentity("zm_castle_pulsing_rumble");
    wait 0.5;
    self clientfield::set_to_player("player_stargate_fx", 1);
    self clientfield::set_to_player("fasttravel_teleport_sfx", 1);
    self setorigin(s_end.origin);
    self setplayerangles(s_end.angles);
    playsoundatposition(#"hash_3388d9809bf60b12", var_e2050768);
    wait 0.5;
    self clientfield::set_to_player("player_stargate_fx", 0);
    self clientfield::set_to_player("fasttravel_teleport_sfx", 0);
    self playsound(#"hash_52aaa9a4a2e71c73");
    self notify(#"fasttravel_over");
}

// Namespace zm_fasttravel/zm_fasttravel
// Params 0, eflags: 0x0
// Checksum 0xde624ddb, Offset: 0x2318
// Size: 0x15a
function function_345768b3() {
    self endon(#"disconnect");
    self waittill(#"fasttravel_over");
    a_enemies = level.ai[#"axis"];
    if (isdefined(a_enemies) && a_enemies.size) {
        a_potential_targets = array::get_all_closest(self.origin, a_enemies, undefined, undefined, 640);
        var_85ba532c = array::filter(a_potential_targets, 0, &function_f15785cf);
        if (var_85ba532c.size > 0) {
            foreach (zombie in var_85ba532c) {
                zombie zombie_utility::setup_zombie_knockdown(self);
            }
        }
        wait 0.2;
        self.var_bbd766ae = 0;
    }
}

// Namespace zm_fasttravel/zm_fasttravel
// Params 1, eflags: 0x0
// Checksum 0xa57c45b2, Offset: 0x2480
// Size: 0x30
function function_f15785cf(e_zombie) {
    if (e_zombie.var_29ed62b2 == #"basic") {
        return true;
    }
    return false;
}

// Namespace zm_fasttravel/zm_fasttravel
// Params 2, eflags: 0x0
// Checksum 0x5e3a9770, Offset: 0x24b8
// Size: 0x9a
function function_c46eef43(n_cooldown, var_796a4e2a) {
    if (var_796a4e2a == "no_cooldown") {
        return;
    }
    level endon(#"end_game");
    self.var_bf7ec16c[var_796a4e2a] = 1;
    if (self hasperk(#"specialty_cooldown")) {
        n_cooldown *= 0.5;
    }
    wait n_cooldown;
    self.var_bf7ec16c[var_796a4e2a] = 0;
}

// Namespace zm_fasttravel/zm_fasttravel
// Params 0, eflags: 0x0
// Checksum 0xece4759a, Offset: 0x2560
// Size: 0x190
function function_d577f470() {
    while (true) {
        waitresult = self waittill(#"trigger");
        player = waitresult.activator;
        player endon(#"death");
        player.var_b11668ad = 1;
        var_6b92a14d = getvehiclenode("fasttravel_dropdown_" + player.var_56982890 + "_start", "targetname");
        player notify(#"switch_rail");
        player.var_13f86a82 vehicle::detach_path();
        player.var_13f86a82 vehicle::get_on_path(var_6b92a14d);
        player clientfield::set("fasttravel_rail_fx", 2);
        player.var_13f86a82 vehicle::go_path();
        player notify(#"fasttravel_over");
        player unlink();
        wait 0.3;
        if (isdefined(player.var_13f86a82)) {
            player.var_13f86a82 delete();
        }
    }
}

// Namespace zm_fasttravel/zm_fasttravel
// Params 0, eflags: 0x0
// Checksum 0xe0772ba1, Offset: 0x26f8
// Size: 0x138
function function_20ca5eb3() {
    level waittill(#"all_players_spawned");
    level flag::wait_till(level.var_8b3ad83a);
    level clientfield::set("fasttravel_exploder", 1);
    var_bcd205ed = struct::get_array("fasttravel_trigger", "targetname");
    foreach (s_loc in var_bcd205ed) {
        if (isdefined(s_loc.unitrigger_stub.delay)) {
            s_loc.unitrigger_stub flag::delay_set(s_loc.unitrigger_stub.delay, "delayed");
        }
    }
}

// Namespace zm_fasttravel/zm_fasttravel
// Params 1, eflags: 0x0
// Checksum 0x78ecf0ea, Offset: 0x2838
// Size: 0x134
function function_3e7d7064(var_4deb6ca) {
    self endon(#"disconnect", #"switch_rail");
    self.var_13f86a82 vehicle::go_path();
    if (isdefined(var_4deb6ca)) {
        self.var_13f86a82.origin = var_4deb6ca.origin;
        self setorigin(var_4deb6ca.origin);
        self setplayerangles(var_4deb6ca.angles);
        self.var_13f86a82 vehicle::get_on_path(var_4deb6ca);
        self.var_13f86a82 vehicle::go_path();
    }
    self notify(#"fasttravel_over");
    self unlink();
    wait 0.3;
    if (isdefined(self.var_13f86a82)) {
        self.var_13f86a82 delete();
    }
}

// Namespace zm_fasttravel/zm_fasttravel
// Params 1, eflags: 0x0
// Checksum 0x22bfe327, Offset: 0x2978
// Size: 0x2e6
function function_3d5a6a13(var_6d77f62c) {
    self endon(#"death");
    var_e2050768 = self.origin;
    var_3d4f7134 = [];
    for (i = 0; i < 4; i++) {
        str_name = "s_teleport_room_" + i + 1;
        var_3d4f7134[i] = struct::get(str_name, "targetname");
    }
    if (!isdefined(level.var_6a185010)) {
        level.var_6a185010 = 0;
    }
    s_teleport_room = var_3d4f7134[level.var_6a185010];
    level.var_6a185010++;
    if (level.var_6a185010 >= var_3d4f7134.size) {
        level.var_6a185010 = 0;
    }
    util::wait_network_frame();
    self setorigin(s_teleport_room.origin);
    self setplayerangles(s_teleport_room.angles);
    self clientfield::set_to_player("fasttravel_teleport_sfx", 1);
    playsoundatposition(#"hash_3388d9809bf60b12", var_e2050768);
    self.var_49592181 = spawn("script_origin", self.origin);
    self.var_49592181.angles = self.angles;
    self linkto(self.var_49592181);
    waittillframeend();
    self playrumbleonentity("zm_castle_pulsing_rumble");
    self function_908c9a02();
    self.var_49592181 delete();
    self.var_49592181 = undefined;
    self setorigin(var_6d77f62c.origin);
    self setplayerangles(var_6d77f62c.angles);
    self clientfield::set_to_player("fasttravel_teleport_sfx", 0);
    self playsound(#"hash_52aaa9a4a2e71c73");
    self notify(#"fasttravel_over");
}

// Namespace zm_fasttravel/zm_fasttravel
// Params 0, eflags: 0x0
// Checksum 0x4cc757d5, Offset: 0x2c68
// Size: 0xfc
function function_908c9a02() {
    self endon(#"disconnect");
    v_offset = (0, 0, 60);
    v_forward = anglestoforward(self.angles);
    v_loc = self.origin + v_offset + v_forward * 1000;
    s_wormhole = struct::spawn(v_loc, (self.angles[0], self.angles[1] - 90, self.angles[2]));
    s_wormhole scene::play("p8_fxanim_zm_zod_wormhole_bundle");
    s_wormhole struct::delete();
}

// Namespace zm_fasttravel/zm_fasttravel
// Params 1, eflags: 0x0
// Checksum 0xae534064, Offset: 0x2d70
// Size: 0x11a
function function_6b043adf(cmd) {
    switch (cmd) {
    case #"start_looping":
        if (!(isdefined(level.var_9167c2cf) && level.var_9167c2cf)) {
            level.var_9167c2cf = 1;
            level thread function_b563a034(0);
        }
        break;
    case #"stop_looping":
        if (isdefined(level.var_9167c2cf) && level.var_9167c2cf) {
            level.var_9167c2cf = 0;
        }
        break;
    case #"play_once":
        if (!(isdefined(level.var_9167c2cf) && level.var_9167c2cf)) {
            level.var_9167c2cf = 1;
            level thread function_b563a034(1);
        }
        break;
    }
}

// Namespace zm_fasttravel/zm_fasttravel
// Params 1, eflags: 0x0
// Checksum 0xb96c7d5d, Offset: 0x2e98
// Size: 0x114
function function_b563a034(b_play_once) {
    s_loc = struct::spawn((0, 0, 0));
    player = level.players[0];
    player endon(#"disconnect");
    var_6ec76d8f = player.origin;
    v_start_angles = player.angles;
    while (isdefined(level.var_9167c2cf) && level.var_9167c2cf) {
        player function_3d5a6a13(s_loc);
        if (isdefined(b_play_once) && b_play_once) {
            level.var_9167c2cf = 0;
        }
    }
    player setorigin(var_6ec76d8f);
    player setplayerangles(v_start_angles);
}

