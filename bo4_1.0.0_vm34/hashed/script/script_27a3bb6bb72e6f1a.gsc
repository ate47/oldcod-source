#using scripts\core_common\ai\zombie_death;
#using scripts\core_common\ai\zombie_utility;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\laststand_shared;
#using scripts\core_common\lui_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\status_effects\status_effect_util;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\zm\zm_towers_util;
#using scripts\zm_common\zm_audio;
#using scripts\zm_common\zm_round_logic;
#using scripts\zm_common\zm_score;
#using scripts\zm_common\zm_unitrigger;
#using scripts\zm_common\zm_utility;
#using scripts\zm_common\zm_zonemgr;

#namespace namespace_1f60eead;

// Namespace namespace_1f60eead/namespace_e8589936
// Params 0, eflags: 0x2
// Checksum 0xc71c6c0e, Offset: 0x1a8
// Size: 0x44
function autoexec __init__system__() {
    system::register(#"hash_2b52a9f53a5e4b45", &__init__, &__main__, undefined);
}

// Namespace namespace_1f60eead/namespace_e8589936
// Params 0, eflags: 0x0
// Checksum 0xe54bce35, Offset: 0x1f8
// Size: 0x24
function __init__() {
    callback::on_finalize_initialization(&init);
}

// Namespace namespace_1f60eead/namespace_e8589936
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x228
// Size: 0x4
function __main__() {
    
}

// Namespace namespace_1f60eead/namespace_e8589936
// Params 0, eflags: 0x0
// Checksum 0x48551e7d, Offset: 0x238
// Size: 0x34
function init() {
    level flag::wait_till("all_players_spawned");
    function_61351d1a();
}

// Namespace namespace_1f60eead/namespace_e8589936
// Params 0, eflags: 0x0
// Checksum 0x63a0d6f3, Offset: 0x278
// Size: 0x1cc
function function_61351d1a() {
    level.var_b29c1861 = 4;
    level.var_82c7402a = 4;
    level.var_3f01b5a2 = 7;
    level.var_f282435a = getentarray("mdl_fire_column", "targetname");
    level.var_b5e9f473 = array();
    level.var_b5e9f473[0] = struct::get("fire_trap_01", "targetname");
    level.var_b5e9f473[1] = struct::get("fire_trap_02", "targetname");
    level.var_b5e9f473[2] = struct::get("fire_trap_03", "targetname");
    level.var_b5e9f473[3] = struct::get("fire_trap_04", "targetname");
    foreach (trap in level.var_b5e9f473) {
        trap function_f9d7657a();
    }
    level thread function_2884dac8();
}

// Namespace namespace_1f60eead/namespace_e8589936
// Params 0, eflags: 0x0
// Checksum 0xbf3c3080, Offset: 0x450
// Size: 0x1c8
function function_2884dac8() {
    level endoncallback(&function_a260ff32, #"game_ended");
    var_cfa0cf2d = 4;
    while (true) {
        level waittill(#"start_of_round");
        /#
            if (level.round_number % 2 == 1 && level.round_number > 4 && level.round_number - var_cfa0cf2d >= 1) {
                var_cfa0cf2d = level.round_number + 1;
            } else if (level.round_number % 2 == 0 && level.round_number > 4 && level.round_number - var_cfa0cf2d >= 2) {
                var_cfa0cf2d = level.round_number;
            }
        #/
        if (var_cfa0cf2d <= level.round_number) {
            var_cfa0cf2d += 2;
            function_6fd7b7d8();
            level thread function_eeaedf03(level.var_b29c1861, level.var_82c7402a, level.var_3f01b5a2);
            level waittill(#"end_of_round", #"kill_round");
            level thread function_a260ff32();
        }
    }
}

// Namespace namespace_1f60eead/namespace_e8589936
// Params 0, eflags: 0x0
// Checksum 0x6f24cef, Offset: 0x620
// Size: 0x8a
function function_6fd7b7d8() {
    if (level.var_b29c1861 < 8) {
        level.var_b29c1861 += 0.25;
    }
    if (level.var_82c7402a > 4) {
        level.var_82c7402a -= 0.25;
    }
    if (level.var_3f01b5a2 > 4) {
        level.var_82c7402a -= 0.25;
    }
}

// Namespace namespace_1f60eead/namespace_e8589936
// Params 3, eflags: 0x0
// Checksum 0xca03c141, Offset: 0x6b8
// Size: 0x4aa
function function_eeaedf03(var_aa0d2679, var_246c694, var_5d22719a) {
    var_f24ab26c = randomintrangeinclusive(1, 7);
    switch (var_f24ab26c) {
    case 1:
        level.var_b5e9f473[0] function_d94bfe17(5, 2, 2);
        level.var_b5e9f473[1] function_d94bfe17(5, 2, 2);
        break;
    case 2:
        level.var_b5e9f473[2] function_d94bfe17(5, 2, 2);
        level.var_b5e9f473[3] function_d94bfe17(5, 2, 2);
        break;
    case 3:
        level.var_b5e9f473[1] function_d94bfe17(5, 2, 2);
        level.var_b5e9f473[2] function_d94bfe17(5, 2, 2);
        break;
    case 4:
        level.var_b5e9f473[0] function_d94bfe17(5, 2, 2);
        level.var_b5e9f473[3] function_d94bfe17(5, 2, 2);
        break;
    case 5:
        level.var_b5e9f473[0] function_d94bfe17(3, 2, 2);
        level.var_b5e9f473[1] function_d94bfe17(3, 2, 2);
        level.var_b5e9f473[2] function_d94bfe17(3, 2, 2);
        level.var_b5e9f473[3] function_d94bfe17(3, 2, 2);
        break;
    case 6:
        level.var_b5e9f473[0] function_d94bfe17(10, 10, 10);
        level.var_b5e9f473[2] function_d94bfe17(10, 10, 10);
        wait 10;
        level.var_b5e9f473[1] function_d94bfe17(10, 10, 10);
        level.var_b5e9f473[3] function_d94bfe17(10, 10, 10);
        break;
    case 7:
        level.var_b5e9f473[0] function_d94bfe17(3, 1, 3);
        wait 1;
        level.var_b5e9f473[1] function_d94bfe17(3, 1, 3);
        wait 1;
        level.var_b5e9f473[2] function_d94bfe17(3, 1, 3);
        wait 1;
        level.var_b5e9f473[3] function_d94bfe17(3, 1, 3);
        wait 1;
        break;
    }
}

// Namespace namespace_1f60eead/namespace_e8589936
// Params 1, eflags: 0x0
// Checksum 0xe21ed0cb, Offset: 0xb70
// Size: 0x88
function function_a260ff32(_hash) {
    foreach (trap in level.var_b5e9f473) {
        trap thread function_9b6c33f6();
    }
}

// Namespace namespace_1f60eead/namespace_e8589936
// Params 0, eflags: 0x0
// Checksum 0xf71239b6, Offset: 0xc00
// Size: 0xc2
function function_f9d7657a() {
    self flag::init("activated");
    self.var_f282435a = [];
    foreach (var_38a95e1b in level.var_f282435a) {
        if (var_38a95e1b.script_string === self.script_string) {
            self.var_f282435a[self.var_f282435a.size] = var_38a95e1b;
        }
    }
}

// Namespace namespace_1f60eead/namespace_e8589936
// Params 3, eflags: 0x0
// Checksum 0x45cf3f62, Offset: 0xcd0
// Size: 0x110
function function_d94bfe17(var_aa0d2679 = 2, var_246c694 = 2, var_c7234ae1 = 2) {
    if (!self flag::get("activated")) {
        self flag::set("activated");
        foreach (var_38a95e1b in self.var_f282435a) {
            var_38a95e1b thread fire_column_activate(var_aa0d2679, var_246c694, self);
        }
    }
}

// Namespace namespace_1f60eead/namespace_e8589936
// Params 0, eflags: 0x0
// Checksum 0xe85263dc, Offset: 0xde8
// Size: 0xd4
function function_9b6c33f6() {
    if (self flag::get("activated")) {
        self flag::clear("activated");
        foreach (var_38a95e1b in self.var_f282435a) {
            var_38a95e1b thread function_9663d103();
        }
        self thread scene::play("shot 2");
    }
}

// Namespace namespace_1f60eead/namespace_e8589936
// Params 3, eflags: 0x0
// Checksum 0x659cd46, Offset: 0xec8
// Size: 0xf8
function fire_column_activate(var_aa0d2679 = 2, var_246c694 = 2, var_ce40d908) {
    self endon(#"deactivate");
    self thread function_6b13a322();
    while (true) {
        level thread function_2690f6a3();
        var_ce40d908 thread scene::play("shot 1");
        wait 0.6;
        self.var_6a16148b = 1;
        wait var_aa0d2679;
        var_ce40d908 thread scene::play("shot 2");
        wait 0.3;
        self.var_6a16148b = 0;
        wait var_246c694;
    }
}

// Namespace namespace_1f60eead/namespace_e8589936
// Params 0, eflags: 0x0
// Checksum 0x86027968, Offset: 0xfc8
// Size: 0x1a4
function function_2690f6a3() {
    level endon(#"end_game");
    if (!level flag::exists(#"hash_7ace11fa7fe1a6ce")) {
        level flag::init(#"hash_7ace11fa7fe1a6ce");
    }
    if (level flag::get(#"hash_7ace11fa7fe1a6ce")) {
        return;
    }
    foreach (e_player in util::get_active_players()) {
        str_zone = e_player zm_zonemgr::get_player_zone();
        if (zm_utility::is_player_valid(e_player, 0, 0) && isinarray(level.var_53b2b1f6, str_zone)) {
            b_said = e_player zm_audio::create_and_play_dialog("flame_hazard", "react");
            if (b_said) {
                level flag::set(#"hash_7ace11fa7fe1a6ce");
                break;
            }
        }
    }
}

// Namespace namespace_1f60eead/namespace_e8589936
// Params 0, eflags: 0x0
// Checksum 0xa1f19d32, Offset: 0x1178
// Size: 0x22
function function_9663d103() {
    self notify(#"deactivate");
    self.var_6a16148b = 0;
}

// Namespace namespace_1f60eead/namespace_e8589936
// Params 0, eflags: 0x0
// Checksum 0xd2979674, Offset: 0x11a8
// Size: 0x70
function function_6b13a322() {
    self endon(#"deactivate");
    while (true) {
        s_notify = self waittill(#"trigger");
        if (isdefined(s_notify.activator)) {
            self thread function_69efbf9d(s_notify.activator);
        }
    }
}

// Namespace namespace_1f60eead/namespace_e8589936
// Params 1, eflags: 0x0
// Checksum 0xb1c7ce05, Offset: 0x1220
// Size: 0x222
function function_69efbf9d(e_victim) {
    self endon(#"deactivate");
    w_fire = getweapon(#"incendiary_fire");
    if (isalive(e_victim) && !(isdefined(e_victim.var_e67f16a) && e_victim.var_e67f16a) && isdefined(self.var_6a16148b) && self.var_6a16148b) {
        e_victim.var_e67f16a = 1;
        if (isplayer(e_victim)) {
            if (!e_victim laststand::player_is_in_laststand()) {
                params = getstatuseffect(#"hash_4b174f501c358c4c");
                if (zm_utility::is_standard()) {
                    params.dotdamage = int(params.dotdamage / 2);
                }
                e_victim status_effect::status_effect_apply(params, w_fire, self, 0, undefined, undefined, self.origin);
                e_victim notify(#"hazard_hit");
            }
            function_cfe48a50(e_victim);
            return;
        }
        if (isactor(e_victim)) {
            e_victim thread function_bf2ae209();
            switch (e_victim.archetype) {
            case #"zombie":
                break;
            case #"gladiator":
                break;
            }
        }
    }
}

// Namespace namespace_1f60eead/namespace_e8589936
// Params 1, eflags: 0x0
// Checksum 0x6a884fae, Offset: 0x1450
// Size: 0x36
function function_cfe48a50(e_victim) {
    e_victim endon(#"death");
    wait 1;
    e_victim.var_e67f16a = 0;
}

// Namespace namespace_1f60eead/namespace_e8589936
// Params 0, eflags: 0x0
// Checksum 0x637930de, Offset: 0x1490
// Size: 0x22c
function function_bf2ae209() {
    level endon(#"end_game");
    self endon(#"death");
    if (!level flag::exists(#"hash_30c5aa0859123bf6")) {
        level flag::init(#"hash_30c5aa0859123bf6");
    }
    if (level flag::get(#"hash_30c5aa0859123bf6")) {
        return;
    }
    v_origin = self.origin;
    a_e_players = util::get_active_players();
    a_e_players = arraysortclosest(a_e_players, v_origin, undefined, 0, 512);
    foreach (e_player in a_e_players) {
        str_zone = e_player zm_zonemgr::get_player_zone();
        if (zm_utility::is_player_valid(e_player, 0, 0) && isinarray(level.var_53b2b1f6, str_zone) && e_player zm_utility::is_player_looking_at(v_origin)) {
            b_said = e_player zm_audio::create_and_play_dialog("flame_hazard", "unharmed");
            if (b_said) {
                level flag::set(#"hash_30c5aa0859123bf6");
                break;
            }
        }
    }
}

