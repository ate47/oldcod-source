#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\player\player_role;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\zm_audio;
#using scripts\zm_common\zm_characters;
#using scripts\zm_common\zm_round_logic;
#using scripts\zm_common\zm_round_spawning;
#using scripts\zm_common\zm_trial;
#using scripts\zm_common\zm_utility;

#namespace zm_vo;

// Namespace zm_vo/zm_vo
// Params 0, eflags: 0x6
// Checksum 0x9dfe90f2, Offset: 0x168
// Size: 0x4c
function private autoexec __init__system__() {
    system::register(#"zm_vo", &function_70a657d8, &postinit, undefined, undefined);
}

// Namespace zm_vo/zm_vo
// Params 0, eflags: 0x5 linked
// Checksum 0xae88bf43, Offset: 0x1c0
// Size: 0x94
function private function_70a657d8() {
    level.var_98eae67a = [];
    level.var_5388c8f9 = [];
    level.var_62281818 = [];
    callback::on_connect(&on_player_connect);
    callback::on_spawned(&on_player_spawned);
    if (!isdefined(level.var_4c2cc614)) {
        level.var_4c2cc614 = &function_fb728280;
    }
}

// Namespace zm_vo/zm_vo
// Params 0, eflags: 0x5 linked
// Checksum 0x54c8d595, Offset: 0x260
// Size: 0x40
function private postinit() {
    self endon(#"_zombie_game_over");
    level waittill(#"all_players_spawned");
    level thread [[ level.var_4c2cc614 ]]();
}

// Namespace zm_vo/zm_vo
// Params 0, eflags: 0x5 linked
// Checksum 0x7e8dc7ef, Offset: 0x2a8
// Size: 0x1a
function private on_player_connect() {
    self.isspeaking = 0;
    self.n_vo_priority = 0;
}

// Namespace zm_vo/zm_vo
// Params 0, eflags: 0x5 linked
// Checksum 0xaff3097e, Offset: 0x2d0
// Size: 0xe
function private on_player_spawned() {
    self.isspeaking = 0;
}

// Namespace zm_vo/zm_vo
// Params 0, eflags: 0x5 linked
// Checksum 0xbcec0067, Offset: 0x2e8
// Size: 0x1ee
function private function_fb728280() {
    level endon(#"end_game");
    function_396064c0(1);
    level flag::wait_till("start_zombie_round_logic");
    function_396064c0(0);
    var_ad829e86 = 0;
    while (true) {
        n_round = zm_round_logic::get_round_number();
        if (n_round > 4 || n_round - var_ad829e86 > 2) {
            break;
        }
        var_f7a978da = function_d74752d8(var_ad829e86);
        if (!is_true(var_f7a978da)) {
            break;
        }
        var_ad829e86++;
        if (zm_round_logic::get_round_number() == n_round) {
            level waittill(#"end_of_round");
        }
        wait 3;
    }
    while (true) {
        n_round = zm_round_logic::get_round_number();
        if (n_round >= 7) {
            if (!zm_round_spawning::function_40229072()) {
                if (!zm_audio::sndvoxoverride()) {
                    if (!is_true(level.var_b2b15659)) {
                        _play_banter();
                    }
                }
            }
        }
        level waittill(#"end_of_round");
        wait 5;
    }
}

// Namespace zm_vo/zm_vo
// Params 4, eflags: 0x0
// Checksum 0x93f01159, Offset: 0x4e0
// Size: 0x54
function function_7922807c(var_a33019a0, var_3e24b5d5, a_players, b_force = 1) {
    _play_banter(var_3e24b5d5, var_a33019a0, a_players, b_force);
}

// Namespace zm_vo/zm_vo
// Params 4, eflags: 0x0
// Checksum 0x2ebabc1e, Offset: 0x540
// Size: 0x54
function play_banter(var_3e24b5d5, var_a33019a0, a_players, b_force = 1) {
    _play_banter(var_3e24b5d5, var_a33019a0, a_players, b_force);
}

// Namespace zm_vo/zm_vo
// Params 4, eflags: 0x5 linked
// Checksum 0x2cd047a1, Offset: 0x5a0
// Size: 0x5be
function private _play_banter(var_3e24b5d5, var_a33019a0, a_players, b_force = 0) {
    var_1bc956f4 = isdefined(level.var_3e24b5d5) ? level.var_3e24b5d5 : isdefined(var_3e24b5d5) ? var_3e24b5d5 : "banter";
    if (isdefined(var_a33019a0)) {
        function_2fd1af0(var_a33019a0, 1, var_1bc956f4);
    }
    function_396064c0(1);
    __timeout__ = 5;
    var_a51f2d59 = gettime();
    do {
        var_f5f6332 = function_172de553(!b_force, a_players);
        var_1d5dbc39 = array::randomize(getarraykeys(var_f5f6332));
        foreach (var_ac829b0 in var_1d5dbc39) {
            var_3e24b5d5 = var_1bc956f4;
            if (isdefined(level.var_66ee3895) && isstring(level.var_66ee3895[var_ac829b0])) {
                var_3e24b5d5 = level.var_66ee3895[var_ac829b0];
            }
            function_bd8c7ec(var_ac829b0, var_3e24b5d5);
            player1 = var_f5f6332[var_ac829b0][0];
            player2 = var_f5f6332[var_ac829b0][1];
            if (!is_player_valid(player1) || !is_player_valid(player2)) {
                continue;
            }
            do {
                n_index = isdefined(var_a33019a0) ? var_a33019a0 : function_e27cd027(var_ac829b0, var_3e24b5d5);
                if (function_c6311709(n_index, var_3e24b5d5)) {
                    var_a2be76a3 = function_2b7b1675(var_3e24b5d5, n_index, player1, player2);
                    if (var_a2be76a3.var_dbeb023e.size) {
                        /#
                            if (getdvarint(#"zm_debug_vo", 0)) {
                                iprintlnbold(var_3e24b5d5 + "<dev string:x38>" + function_9e72a96(var_ac829b0) + "<dev string:x38>" + n_index);
                                println(var_3e24b5d5 + "<dev string:x38>" + function_9e72a96(var_ac829b0) + "<dev string:x38>" + n_index);
                            }
                        #/
                        if (function_7e4562d7(var_a2be76a3.var_dbeb023e, var_a2be76a3.var_1dc0a881, 1)) {
                            if (isdefined(player1)) {
                                player1 notify(#"hash_ed377b19afa69d2");
                            }
                            if (isdefined(player2)) {
                                player2 notify(#"hash_ed377b19afa69d2");
                            }
                            function_3f8824e6(var_ac829b0, var_3e24b5d5);
                            level thread function_396064c0(0);
                            return true;
                        } else {
                            break;
                        }
                    }
                    if (isdefined(var_a33019a0)) {
                        break;
                    } else {
                        function_3f8824e6(var_ac829b0, var_3e24b5d5);
                    }
                } else {
                    /#
                        if (getdvarint(#"zm_debug_vo", 0)) {
                            iprintlnbold(var_3e24b5d5 + "<dev string:x38>" + function_9e72a96(var_ac829b0) + "<dev string:x38>" + n_index + "<dev string:x3f>");
                            println(var_3e24b5d5 + "<dev string:x38>" + function_9e72a96(var_ac829b0) + "<dev string:x38>" + n_index + "<dev string:x3f>");
                        }
                    #/
                    break;
                }
                if (!isdefined(player1) || !isdefined(player2)) {
                    break;
                }
            } while (n_index <= 20);
            waitframe(1);
        }
        wait randomfloatrange(0.333333, 0.666667);
    } while (!(__timeout__ >= 0 && __timeout__ - float(gettime() - var_a51f2d59) / 1000 <= 0));
    level thread function_396064c0(0);
    return false;
}

// Namespace zm_vo/zm_vo
// Params 2, eflags: 0x0
// Checksum 0xe608fb5d, Offset: 0xb68
// Size: 0x82
function function_577efa88(var_a33019a0, var_3e24b5d5 = isdefined(level.var_3e24b5d5) ? level.var_3e24b5d5 : "banter") {
    if (!isdefined(level.var_5388c8f9[var_3e24b5d5])) {
        level.var_5388c8f9[var_3e24b5d5] = [];
    }
    level.var_5388c8f9[var_3e24b5d5][var_a33019a0] = 1;
}

// Namespace zm_vo/zm_vo
// Params 3, eflags: 0x1 linked
// Checksum 0xd38a9b8, Offset: 0xbf8
// Size: 0xbc
function function_2fd1af0(var_a33019a0, var_c6a4663f = 1, var_3e24b5d5 = isdefined(level.var_3e24b5d5) ? level.var_3e24b5d5 : "banter") {
    if (!isdefined(level.var_5388c8f9[var_3e24b5d5])) {
        level.var_5388c8f9[var_3e24b5d5] = [];
    }
    level.var_5388c8f9[var_3e24b5d5][var_a33019a0] = undefined;
    if (var_c6a4663f) {
        function_cf6c9597("skipto", var_3e24b5d5, var_a33019a0);
    }
}

// Namespace zm_vo/zm_vo
// Params 2, eflags: 0x1 linked
// Checksum 0x1d6c09ff, Offset: 0xcc0
// Size: 0x74
function function_c6311709(var_a33019a0, var_3e24b5d5 = isdefined(level.var_3e24b5d5) ? level.var_3e24b5d5 : "banter") {
    if (isdefined(level.var_5388c8f9[var_3e24b5d5])) {
        return !isdefined(level.var_5388c8f9[var_3e24b5d5][var_a33019a0]);
    }
    return true;
}

// Namespace zm_vo/zm_vo
// Params 2, eflags: 0x5 linked
// Checksum 0x8bc6c6e6, Offset: 0xd40
// Size: 0xcc
function private function_bd8c7ec(var_ac829b0, var_3e24b5d5) {
    if (!isdefined(level.var_98eae67a[#"skipto"])) {
        level.var_98eae67a[#"skipto"] = [];
    }
    if (isdefined(level.var_98eae67a[#"skipto"][var_3e24b5d5])) {
        var_bc984450 = level.var_98eae67a[#"skipto"][var_3e24b5d5];
        if (function_e27cd027(var_ac829b0, var_3e24b5d5) < var_bc984450) {
            function_cf6c9597(var_ac829b0, var_3e24b5d5, var_bc984450);
        }
    }
}

// Namespace zm_vo/zm_vo
// Params 2, eflags: 0x1 linked
// Checksum 0x127a3dd5, Offset: 0xe18
// Size: 0xa6
function function_e27cd027(var_ac829b0, var_3e24b5d5 = isdefined(level.var_3e24b5d5) ? level.var_3e24b5d5 : "banter") {
    if (!isdefined(level.var_98eae67a[var_ac829b0])) {
        level.var_98eae67a[var_ac829b0] = [];
    }
    if (!isdefined(level.var_98eae67a[var_ac829b0][var_3e24b5d5])) {
        level.var_98eae67a[var_ac829b0][var_3e24b5d5] = 0;
    }
    return level.var_98eae67a[var_ac829b0][var_3e24b5d5];
}

// Namespace zm_vo/zm_vo
// Params 3, eflags: 0x1 linked
// Checksum 0x1394c209, Offset: 0xec8
// Size: 0x8a
function function_cf6c9597(var_ac829b0, var_3e24b5d5 = isdefined(level.var_3e24b5d5) ? level.var_3e24b5d5 : "banter", n_index) {
    if (!isdefined(level.var_98eae67a[var_ac829b0])) {
        level.var_98eae67a[var_ac829b0] = [];
    }
    level.var_98eae67a[var_ac829b0][var_3e24b5d5] = n_index;
}

// Namespace zm_vo/zm_vo
// Params 3, eflags: 0x0
// Checksum 0x4d57cf1a, Offset: 0xf60
// Size: 0xb0
function function_769aa73b(var_3e24b5d5, character1, character2) {
    var_2f0fa840 = zm_characters::function_dc232a80(character1);
    var_7a0bbe3b = zm_characters::function_dc232a80(character2);
    var_ac829b0 = min(var_2f0fa840, var_7a0bbe3b) + "-" + max(var_2f0fa840, var_7a0bbe3b);
    level.var_66ee3895[var_ac829b0] = var_3e24b5d5;
}

// Namespace zm_vo/zm_vo
// Params 2, eflags: 0x5 linked
// Checksum 0x1513203, Offset: 0x1018
// Size: 0x80
function private function_3f8824e6(var_ac829b0, var_3e24b5d5) {
    n_index = int(min(function_e27cd027(var_ac829b0, var_3e24b5d5) + 1, 21));
    function_cf6c9597(var_ac829b0, var_3e24b5d5, n_index);
    return n_index;
}

// Namespace zm_vo/zm_vo
// Params 4, eflags: 0x5 linked
// Checksum 0xcce60d71, Offset: 0x10a0
// Size: 0x7b4
function private function_2b7b1675(var_3e24b5d5 = isdefined(level.var_3e24b5d5) ? level.var_3e24b5d5 : "banter", var_a33019a0, var_2e6c012e, e_player_2) {
    var_53297699 = var_2e6c012e zm_characters::function_dc232a80();
    var_b1411c83 = var_2e6c012e function_82f9bc9f();
    var_6095116c = e_player_2 zm_characters::function_dc232a80();
    var_1c46f291 = e_player_2 function_82f9bc9f();
    a_test = [];
    if (!isdefined(a_test)) {
        a_test = [];
    } else if (!isarray(a_test)) {
        a_test = array(a_test);
    }
    a_test[a_test.size] = array(var_53297699, #"vox_" + var_a33019a0 + "_" + var_3e24b5d5 + "_" + var_b1411c83 + "_" + var_1c46f291 + "_" + "plr_" + var_53297699);
    if (!isdefined(a_test)) {
        a_test = [];
    } else if (!isarray(a_test)) {
        a_test = array(a_test);
    }
    a_test[a_test.size] = array(var_53297699, #"vox_" + var_a33019a0 + "_" + var_3e24b5d5 + "_" + var_1c46f291 + "_" + var_b1411c83 + "_" + "plr_" + var_53297699);
    if (!isdefined(a_test)) {
        a_test = [];
    } else if (!isarray(a_test)) {
        a_test = array(a_test);
    }
    a_test[a_test.size] = array(var_6095116c, #"vox_" + var_a33019a0 + "_" + var_3e24b5d5 + "_" + var_b1411c83 + "_" + var_1c46f291 + "_" + "plr_" + var_6095116c);
    if (!isdefined(a_test)) {
        a_test = [];
    } else if (!isarray(a_test)) {
        a_test = array(a_test);
    }
    a_test[a_test.size] = array(var_6095116c, #"vox_" + var_a33019a0 + "_" + var_3e24b5d5 + "_" + var_1c46f291 + "_" + var_b1411c83 + "_" + "plr_" + var_6095116c);
    waitframe(1);
    if (var_a33019a0 == 0) {
        if (!isdefined(a_test)) {
            a_test = [];
        } else if (!isarray(a_test)) {
            a_test = array(a_test);
        }
        a_test[a_test.size] = array(var_53297699, #"vox_" + var_3e24b5d5 + "_" + var_b1411c83 + "_" + var_1c46f291 + "_" + "plr_" + var_53297699);
        if (!isdefined(a_test)) {
            a_test = [];
        } else if (!isarray(a_test)) {
            a_test = array(a_test);
        }
        a_test[a_test.size] = array(var_53297699, #"vox_" + var_3e24b5d5 + "_" + var_1c46f291 + "_" + var_b1411c83 + "_" + "plr_" + var_53297699);
        if (!isdefined(a_test)) {
            a_test = [];
        } else if (!isarray(a_test)) {
            a_test = array(a_test);
        }
        a_test[a_test.size] = array(var_6095116c, #"vox_" + var_3e24b5d5 + "_" + var_b1411c83 + "_" + var_1c46f291 + "_" + "plr_" + var_6095116c);
        if (!isdefined(a_test)) {
            a_test = [];
        } else if (!isarray(a_test)) {
            a_test = array(a_test);
        }
        a_test[a_test.size] = array(var_6095116c, #"vox_" + var_3e24b5d5 + "_" + var_1c46f291 + "_" + var_b1411c83 + "_" + "plr_" + var_6095116c);
    }
    var_cd5bda0c = [];
    foreach (test in a_test) {
        for (i = 0; i < 20; i++) {
            str_alias = test[1] + "_" + i;
            if (soundexists(str_alias)) {
                var_cd5bda0c[i] = array(test[0], str_alias);
            }
        }
        waitframe(1);
    }
    return {#var_dbeb023e:var_cd5bda0c, #var_1dc0a881:array(0, 0.5)};
}

// Namespace zm_vo/zm_vo
// Params 1, eflags: 0x5 linked
// Checksum 0xcff4cc74, Offset: 0x1860
// Size: 0x278
function private function_d74752d8(var_2753f06a) {
    level endoncallback(&function_8d0f6d6c, #"hash_6e979a553f2df885");
    level thread function_b2fd46e3();
    if (zm_round_spawning::function_40229072()) {
        return 0;
    }
    function_396064c0(1);
    b_played = 0;
    if (isdefined(level.var_c02e63)) {
        b_played = [[ level.var_c02e63 ]](var_2753f06a);
    }
    if (!b_played) {
        a_players = getplayers();
        if (a_players.size == 1) {
            e_player = a_players[0];
            if (var_2753f06a == 0) {
                str_suffix = #"vox_solo_game_start";
            } else {
                str_suffix = #"vox_solo_end_round" + var_2753f06a;
            }
            if (isdefined(e_player.var_ab7bf755)) {
                b_played = e_player [[ e_player.var_ab7bf755 ]]();
            } else {
                b_played = e_player function_a2bd5a0c(str_suffix, 0, 1);
            }
        } else {
            var_1dc0a881 = array(0, 0.5);
            var_dcc9a85f = level.script === "zm_escape" ? 2147483647 : 2;
            if (var_2753f06a == 0) {
                b_played = function_7e4562d7(#"hash_72ea1851a50844cf", var_1dc0a881, 1, undefined, 0, 0, var_dcc9a85f);
            } else {
                b_played = function_7e4562d7(#"hash_71bde3a512edb440" + var_2753f06a, var_1dc0a881, 1, undefined, 0, 0, var_dcc9a85f);
            }
        }
    }
    level thread function_396064c0(0);
    return b_played;
}

// Namespace zm_vo/zm_vo
// Params 1, eflags: 0x1 linked
// Checksum 0xac566b98, Offset: 0x1ae0
// Size: 0x24
function function_8d0f6d6c(*str_notify) {
    level thread function_396064c0(0);
}

// Namespace zm_vo/zm_vo
// Params 1, eflags: 0x1 linked
// Checksum 0xaa625695, Offset: 0x1b10
// Size: 0x70
function function_396064c0(var_e29db913 = 1) {
    self notify("18d0f5bb9d2d292d");
    self endon("18d0f5bb9d2d292d");
    if (!is_true(var_e29db913)) {
        wait 2;
    }
    level.var_b625a184 = var_e29db913 ? 1 : undefined;
}

// Namespace zm_vo/zm_vo
// Params 0, eflags: 0x1 linked
// Checksum 0x5e4ebc50, Offset: 0x1b88
// Size: 0x60
function function_b2fd46e3() {
    self notify("513f299c08bc937a");
    self endon("513f299c08bc937a");
    while (!is_true(level.var_b2b15659)) {
        waitframe(1);
    }
    level notify(#"hash_6e979a553f2df885");
}

// Namespace zm_vo/zm_vo
// Params 2, eflags: 0x0
// Checksum 0xb86f566d, Offset: 0x1bf0
// Size: 0x88
function function_ee847f80(str_line1, str_line2) {
    var_79ef6f66 = strtok(str_line1, "_");
    shoot_vo_clear = strtok(str_line2, "_");
    return var_79ef6f66[var_79ef6f66.size - 1] < shoot_vo_clear[shoot_vo_clear.size - 1];
}

// Namespace zm_vo/zm_vo
// Params 2, eflags: 0x5 linked
// Checksum 0xa0ab6cd6, Offset: 0x1c80
// Size: 0x1d0
function private function_172de553(var_ec88b612 = 1, a_players = array::randomize(function_347f7d34())) {
    var_f5f6332 = [];
    for (i = 0; i < a_players.size; i++) {
        for (j = 0; j < a_players.size; j++) {
            if (a_players[i] != a_players[j]) {
                player1 = a_players[i];
                player2 = a_players[j];
                var_2f0fa840 = 0;
                var_7a0bbe3b = 0;
                if (isdefined(player1)) {
                    var_2f0fa840 = player1 zm_characters::function_dc232a80();
                }
                if (isdefined(player2)) {
                    var_7a0bbe3b = player2 zm_characters::function_dc232a80();
                }
                var_ac829b0 = min(var_2f0fa840, var_7a0bbe3b) + "-" + max(var_2f0fa840, var_7a0bbe3b);
                if (!isdefined(var_f5f6332[var_ac829b0])) {
                    if (!var_ec88b612 || function_5c82f986(player1, player2)) {
                        var_f5f6332[var_ac829b0] = array(player1, player2);
                    }
                }
            }
        }
    }
    return var_f5f6332;
}

// Namespace zm_vo/zm_vo
// Params 3, eflags: 0x0
// Checksum 0x87554176, Offset: 0x1e58
// Size: 0xce
function function_18d309e5(n_timeout, var_ec88b612, a_players) {
    __timeout__ = n_timeout;
    var_a51f2d59 = gettime();
    do {
        var_f5f6332 = function_172de553(var_ec88b612, a_players);
        if (var_f5f6332.size) {
            break;
        }
        wait randomfloatrange(0.2, 0.4);
    } while (!(__timeout__ >= 0 && __timeout__ - float(gettime() - var_a51f2d59) / 1000 <= 0));
    return var_f5f6332;
}

// Namespace zm_vo/zm_vo
// Params 2, eflags: 0x1 linked
// Checksum 0xf93765b1, Offset: 0x1f30
// Size: 0xce
function function_5c82f986(var_97beaf8b, var_ccac9966) {
    if (distancesquared(var_97beaf8b.origin, var_ccac9966.origin) < 589824) {
        if (abs(var_97beaf8b.origin[2] - var_ccac9966.origin[2]) < 96) {
            if (sighttracepassed(var_97beaf8b.origin + (0, 0, 64), var_ccac9966.origin + (0, 0, 64), 0, var_97beaf8b, var_ccac9966)) {
                return true;
            }
        }
    }
    return false;
}

// Namespace zm_vo/zm_vo
// Params 1, eflags: 0x1 linked
// Checksum 0xb95d453e, Offset: 0x2008
// Size: 0x24
function vo_clear(str_endon) {
    self thread _vo_clear(str_endon);
}

// Namespace zm_vo/zm_vo
// Params 1, eflags: 0x1 linked
// Checksum 0x6ee0a391, Offset: 0x2038
// Size: 0x170
function _vo_clear(str_endon) {
    profilestart();
    if (isdefined(str_endon) && isdefined(self.str_vo_being_spoken)) {
        /#
            if (getdvarint(#"zm_debug_vo", 0)) {
                iprintlnbold("<dev string:x51>");
                println("<dev string:x51>");
            }
        #/
        self stopsound(self.str_vo_being_spoken);
    }
    if (isplayer(self)) {
        self clientfield::set_to_player("isspeaking", 0);
    }
    self.str_vo_being_spoken = "";
    self.n_vo_priority = 0;
    self.isspeaking = 0;
    self.var_5b6ebfd0 = 0;
    self.var_472e3448 = undefined;
    self.last_vo_played_time = gettime();
    arrayremovevalue(level.var_62281818, self);
    zm_audio::sndvoxoverride(0);
    self notify(#"vo_clear");
    self notify(#"done_speaking");
    profilestop();
}

// Namespace zm_vo/zm_vo
// Params 2, eflags: 0x4
// Checksum 0x26a1fad, Offset: 0x21b0
// Size: 0x74
function private function_95b99c5b(n_max, var_50bb7db7) {
    assert(!isdefined(var_50bb7db7) || var_50bb7db7 < n_max, "<dev string:x5d>");
    do {
        n_new_value = randomint(n_max);
    } while (n_new_value === var_50bb7db7);
    return n_new_value;
}

// Namespace zm_vo/zm_vo
// Params 3, eflags: 0x4
// Checksum 0xd09f2cf0, Offset: 0x2230
// Size: 0x62
function private function_542dfad7(e1, e2, b_lowest_first = 1) {
    if (b_lowest_first) {
        return (e1.characterindex <= e2.characterindex);
    }
    return e1.characterindex > e2.characterindex;
}

// Namespace zm_vo/zm_vo
// Params 1, eflags: 0x1 linked
// Checksum 0xcaa41ba6, Offset: 0x22a0
// Size: 0x2a
function is_player_valid(e_player) {
    return zm_utility::is_player_valid(e_player, 0, 0, 0);
}

// Namespace zm_vo/zm_vo
// Params 0, eflags: 0x1 linked
// Checksum 0x19da27c5, Offset: 0x22d8
// Size: 0xf2
function function_347f7d34() {
    a_valid_players = [];
    foreach (player in getplayers()) {
        if (zm_utility::is_player_valid(player)) {
            if (!isdefined(a_valid_players)) {
                a_valid_players = [];
            } else if (!isarray(a_valid_players)) {
                a_valid_players = array(a_valid_players);
            }
            a_valid_players[a_valid_players.size] = player;
        }
    }
    return a_valid_players;
}

// Namespace zm_vo/zm_vo
// Params 1, eflags: 0x0
// Checksum 0xf6c794d2, Offset: 0x23d8
// Size: 0x60
function function_2ee2ece4(var_79dbc69 = 1) {
    while (true) {
        a_valid_players = function_347f7d34();
        if (a_valid_players.size >= var_79dbc69) {
            break;
        }
        waitframe(5);
    }
    return a_valid_players;
}

// Namespace zm_vo/zm_vo
// Params 0, eflags: 0x0
// Checksum 0x585d7e31, Offset: 0x2440
// Size: 0xaa
function function_45e29f06() {
    var_5eb47b1d = function_a1ef346b();
    foreach (player in var_5eb47b1d) {
        if (is_player_speaking(player)) {
            return true;
        }
    }
    return false;
}

// Namespace zm_vo/zm_vo
// Params 1, eflags: 0x1 linked
// Checksum 0x3a140e91, Offset: 0x24f8
// Size: 0x4a
function is_player_speaking(e_player) {
    if (!isdefined(e_player) && isplayer(self)) {
        e_player = self;
    }
    if (e_player.isspeaking) {
        return true;
    }
    return false;
}

// Namespace zm_vo/zm_vo
// Params 7, eflags: 0x1 linked
// Checksum 0x58ec5b1a, Offset: 0x2550
// Size: 0x1ba
function function_a2bd5a0c(var_cadd3b0c, n_delay = 0, b_wait_if_busy = 0, n_priority = 0, var_34e7887 = 0, var_d7714e4e = 0, var_67fee570 = 0) {
    assert(isplayer(self), "<dev string:x98>" + "<dev string:xb7>");
    if (!isdefined(self) || !isplayer(self)) {
        return;
    }
    n_index = zm_characters::function_dc232a80();
    if (!isdefined(n_index)) {
        return;
    }
    str_vo_alias = var_cadd3b0c + "_" + "plr_" + n_index;
    a_variants = zm_audio::get_valid_lines(str_vo_alias);
    b_ret = vo_say(array::random(a_variants), n_delay, b_wait_if_busy, n_priority, var_34e7887, var_d7714e4e, 0, var_67fee570);
    return is_true(b_ret);
}

// Namespace zm_vo/zm_vo
// Params 8, eflags: 0x1 linked
// Checksum 0xc7f11af, Offset: 0x2718
// Size: 0x308
function vo_say(str_vo_alias, n_delay, b_wait_if_busy, *n_priority = 0, *var_34e7887 = 0, var_d7714e4e = 0, var_9c64da7c = 0, var_67fee570 = 0) {
    if (!isdefined(self)) {
        return 0;
    }
    self endoncallback(&vo_clear, #"death");
    if (!isdefined(b_wait_if_busy)) {
        return 0;
    }
    if ((zm_trial::is_trial_mode() || zm_utility::is_standard()) && !var_9c64da7c) {
        return 0;
    }
    if (isplayer(self)) {
        if (!zm_utility::is_player_valid(self, 0, var_67fee570, 0) || is_true(self.dontspeak)) {
            return 0;
        }
    }
    var_56f97c91 = array::random(zm_audio::get_valid_lines(b_wait_if_busy));
    if (isdefined(var_56f97c91)) {
        __timeout__ = n_priority;
        var_a51f2d59 = gettime();
        self notify(#"hash_7efd5bdf8133ff7b");
        if (!zm_audio::can_speak(var_d7714e4e)) {
            if (is_true(var_34e7887)) {
                do {
                    waitframe(1);
                } while (!zm_audio::can_speak(var_d7714e4e));
            } else {
                return 0;
            }
        }
        /#
            if (getdvarint(#"zm_debug_vo", 0)) {
                iprintlnbold("<dev string:xd7>" + function_9e72a96(b_wait_if_busy));
                println("<dev string:xd7>" + function_9e72a96(b_wait_if_busy));
            }
        #/
        self thread function_597484c3(__timeout__ - float(gettime() - var_a51f2d59) / 1000, var_56f97c91, var_d7714e4e);
        self waittill(#"done_speaking");
        return 1;
    }
    return 0;
}

// Namespace zm_vo/zm_vo
// Params 3, eflags: 0x5 linked
// Checksum 0x69b0e394, Offset: 0x2a28
// Size: 0x13c
function private function_597484c3(n_delay, var_56f97c91, var_d7714e4e) {
    if (!isdefined(self)) {
        return;
    }
    self endoncallback(&vo_clear, #"death");
    self.isspeaking = 1;
    self.var_5b6ebfd0 = var_d7714e4e;
    if (!isdefined(level.var_62281818)) {
        level.var_62281818 = [];
    } else if (!isarray(level.var_62281818)) {
        level.var_62281818 = array(level.var_62281818);
    }
    level.var_62281818[level.var_62281818.size] = self;
    zm_audio::sndvoxoverride(1);
    if (n_delay > 0) {
        wait n_delay;
    }
    zm_audio::play_vo_internal(var_56f97c91, var_d7714e4e ? self : undefined);
    vo_clear();
}

// Namespace zm_vo/zm_vo
// Params 5, eflags: 0x0
// Checksum 0xb65515ff, Offset: 0x2b70
// Size: 0x156
function function_cf1e151c(var_3608d414, var_604e94aa = [], b_wait_if_busy = 0, n_priority = 0, var_34e7887 = 0) {
    b_played = 0;
    foreach (i, str_vo in var_3608d414) {
        var_fa74ccf1 = isdefined(var_604e94aa[i]) ? var_604e94aa[i] : 0.5;
        b_said = vo_say(str_vo, var_fa74ccf1, b_wait_if_busy, n_priority, var_34e7887);
        if (is_true(b_said)) {
            b_played = 1;
            continue;
        }
        break;
    }
    return b_played;
}

// Namespace zm_vo/zm_vo
// Params 7, eflags: 0x1 linked
// Checksum 0x82ecfceb, Offset: 0x2cd0
// Size: 0x4a2
function function_7e4562d7(var_3505e2ee, var_604e94aa = [], b_wait_if_busy = 0, n_priority = 0, var_34e7887 = 0, var_39ed8245 = 1, var_dcc9a85f = 2147483647) {
    b_played = 0;
    var_cd5bda0c = [];
    if (isstring(var_3505e2ee) || ishash(var_3505e2ee)) {
        for (p = 1; p <= 16; p++) {
            var_6b452a2f = var_3505e2ee + "_" + "plr_" + p;
            for (i = 0; i < 20; i++) {
                str_alias = var_6b452a2f + "_" + i;
                if (soundexists(str_alias)) {
                    var_cd5bda0c[i] = array(p, str_alias);
                }
            }
        }
    } else if (isarray(var_3505e2ee)) {
        var_cd5bda0c = var_3505e2ee;
    }
    a_keys = getarraykeys(var_cd5bda0c);
    var_a7e5c412 = array::sort_by_value(a_keys, 1);
    if (var_dcc9a85f < var_a7e5c412.size) {
        foreach (i, n_line in arraycopy(var_a7e5c412)) {
            player = zm_utility::function_828bac1(var_cd5bda0c[n_line][0]);
            if (!isplayer(player)) {
                arrayremoveindex(var_a7e5c412, i, 1);
            }
        }
    }
    var_2274675e = 0;
    var_acf085c3 = 0;
    foreach (i, n_line in var_a7e5c412) {
        var_fa74ccf1 = isdefined(var_604e94aa[var_2274675e]) ? var_604e94aa[var_2274675e] : 0.5;
        var_2274675e++;
        var_4a094e30 = var_dcc9a85f - var_acf085c3;
        if (var_4a094e30 <= 0) {
            break;
        } else if (var_4a094e30 < var_a7e5c412.size - i) {
            if (math::cointoss()) {
                continue;
            }
        }
        player = zm_utility::function_828bac1(var_cd5bda0c[n_line][0]);
        if (isdefined(player)) {
            b_said = 0;
            if (isplayer(player)) {
                b_said = player vo_say(var_cd5bda0c[n_line][1], var_fa74ccf1, b_wait_if_busy, n_priority, var_34e7887);
            }
            if (is_true(b_said)) {
                b_played = 1;
                var_acf085c3++;
            }
            if (var_39ed8245) {
                if (!is_true(player.var_4377124)) {
                    break;
                }
            }
        }
    }
    return b_played;
}

// Namespace zm_vo/zm_vo
// Params 0, eflags: 0x1 linked
// Checksum 0x51b42997, Offset: 0x3180
// Size: 0x54
function vo_stop() {
    if (isdefined(self.str_vo_being_spoken) && self.str_vo_being_spoken != "") {
        self stopsound(self.str_vo_being_spoken);
    }
    vo_clear();
}

// Namespace zm_vo/zm_vo
// Params 2, eflags: 0x0
// Checksum 0xb867778e, Offset: 0x31e0
// Size: 0xe0
function function_3c173d37(v_pos, n_range = 1000) {
    foreach (player in getplayers()) {
        if (!isdefined(v_pos) || distancesquared(player.origin, v_pos) <= n_range * n_range) {
            player vo_stop();
        }
    }
}

// Namespace zm_vo/zm_vo
// Params 0, eflags: 0x1 linked
// Checksum 0xf5cf3dc, Offset: 0x32c8
// Size: 0x86
function function_82f9bc9f() {
    fields = getcharacterfields(player_role::get(), currentsessionmode());
    if (isdefined(fields)) {
        if (isdefined(fields.chrname) && fields.chrname != "") {
            return fields.chrname;
        }
    }
    return "NONE";
}

// Namespace zm_vo/zm_vo
// Params 1, eflags: 0x0
// Checksum 0x8b1c1e9d, Offset: 0x3358
// Size: 0x1c
function function_d8e12055(func_banter) {
    level.var_4c2cc614 = func_banter;
}
