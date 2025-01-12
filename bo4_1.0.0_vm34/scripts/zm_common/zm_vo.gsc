#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\flagsys_shared;
#using scripts\core_common\player\player_role;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\zm_audio;
#using scripts\zm_common\zm_characters;
#using scripts\zm_common\zm_round_spawning;
#using scripts\zm_common\zm_trial;
#using scripts\zm_common\zm_utility;

#namespace zm_vo;

// Namespace zm_vo/zm_vo
// Params 0, eflags: 0x2
// Checksum 0x5ea70c76, Offset: 0x180
// Size: 0x44
function autoexec __init__system__() {
    system::register(#"zm_vo", &__init__, &__main__, undefined);
}

// Namespace zm_vo/zm_vo
// Params 0, eflags: 0x0
// Checksum 0x1c117358, Offset: 0x1d0
// Size: 0xa4
function __init__() {
    level.var_d9c1686c = [];
    level.var_c047eae4 = [];
    callback::on_connect(&on_player_connect);
    callback::on_spawned(&on_player_spawned);
    if (!isdefined(level.var_491f7949)) {
        level.var_491f7949 = &function_1363fefe;
    }
    level flag::init("story_playing");
}

// Namespace zm_vo/zm_vo
// Params 0, eflags: 0x0
// Checksum 0xcb421e24, Offset: 0x280
// Size: 0x40
function __main__() {
    self endon(#"_zombie_game_over");
    level waittill(#"all_players_spawned");
    level thread [[ level.var_491f7949 ]]();
}

// Namespace zm_vo/zm_vo
// Params 0, eflags: 0x4
// Checksum 0x39ceec35, Offset: 0x2c8
// Size: 0x1a
function private on_player_connect() {
    self.isspeaking = 0;
    self.n_vo_priority = 0;
}

// Namespace zm_vo/zm_vo
// Params 0, eflags: 0x4
// Checksum 0x30c40c41, Offset: 0x2f0
// Size: 0xe
function private on_player_spawned() {
    self.isspeaking = 0;
}

// Namespace zm_vo/zm_vo
// Params 0, eflags: 0x4
// Checksum 0xaa76b342, Offset: 0x308
// Size: 0x11e
function private function_1363fefe() {
    level endon(#"end_game");
    level waittill(#"start_of_round");
    function_820c60bb(0);
    do {
        n_round = level.round_number;
        level waittill(#"end_of_round");
        wait 1;
        var_90da2dd = function_820c60bb(n_round);
    } while (!isdefined(var_90da2dd) || var_90da2dd);
    while (true) {
        if (!zm_round_spawning::function_6a9f7d77() && !zm_audio::sndvoxoverride()) {
            _play_banter();
        }
        level waittill(#"end_of_round");
        wait 1;
    }
}

// Namespace zm_vo/zm_vo
// Params 4, eflags: 0x0
// Checksum 0x1eaa842, Offset: 0x430
// Size: 0x54
function function_da6b9f3b(var_cfde20a9, var_e6e816ad, a_players, b_force = 1) {
    _play_banter(var_e6e816ad, var_cfde20a9, a_players, b_force);
}

// Namespace zm_vo/zm_vo
// Params 4, eflags: 0x0
// Checksum 0x9d32d03a, Offset: 0x490
// Size: 0x54
function play_banter(var_e6e816ad, var_cfde20a9, a_players, b_force = 1) {
    _play_banter(var_e6e816ad, var_cfde20a9, a_players, b_force);
}

// Namespace zm_vo/zm_vo
// Params 4, eflags: 0x4
// Checksum 0x8aecc222, Offset: 0x4f0
// Size: 0x4c4
function private _play_banter(var_e6e816ad = isdefined(level.var_e6e816ad) ? level.var_e6e816ad : "banter", var_cfde20a9, a_players, b_force = 0) {
    if (isdefined(var_cfde20a9)) {
        function_646c38ba(var_cfde20a9, 1, var_e6e816ad);
    }
    __timeout__ = 5;
    var_6eb52594 = gettime();
    do {
        var_a1530c07 = function_7bddfedd(!b_force, a_players);
        var_ef033484 = array::randomize(getarraykeys(var_a1530c07));
        foreach (var_6e7d46c1 in var_ef033484) {
            function_17d8a019(var_6e7d46c1, var_e6e816ad);
            player1 = var_a1530c07[var_6e7d46c1][0];
            player2 = var_a1530c07[var_6e7d46c1][1];
            if (!is_player_valid(player1) || !is_player_valid(player2)) {
                continue;
            }
            do {
                n_index = isdefined(var_cfde20a9) ? var_cfde20a9 : function_a575b777(var_6e7d46c1, var_e6e816ad);
                if (function_940a0864(n_index, var_e6e816ad)) {
                    var_a428fc5a = function_a3239326(var_e6e816ad, n_index, player1, player2);
                    if (var_a428fc5a.var_fde65505.size) {
                        /#
                            if (getdvarint(#"zm_debug_vo", 0)) {
                                iprintlnbold(var_e6e816ad + "<dev string:x30>" + function_15979fa9(var_6e7d46c1) + "<dev string:x30>" + n_index);
                            }
                            println(var_e6e816ad + "<dev string:x30>" + function_15979fa9(var_6e7d46c1) + "<dev string:x30>" + n_index);
                        #/
                        if (function_7aa5324a(var_a428fc5a.var_fde65505, var_a428fc5a.var_df2bf81b, 1)) {
                            function_c5115fcb(var_6e7d46c1, var_e6e816ad);
                            return true;
                        } else {
                            break;
                        }
                    }
                    if (isdefined(var_cfde20a9)) {
                        break;
                    } else {
                        function_c5115fcb(var_6e7d46c1, var_e6e816ad);
                    }
                    continue;
                }
                /#
                    if (getdvarint(#"zm_debug_vo", 0)) {
                        iprintlnbold(var_e6e816ad + "<dev string:x30>" + function_15979fa9(var_6e7d46c1) + "<dev string:x30>" + n_index + "<dev string:x34>");
                    }
                    println(var_e6e816ad + "<dev string:x30>" + function_15979fa9(var_6e7d46c1) + "<dev string:x30>" + n_index + "<dev string:x34>");
                #/
                break;
            } while (n_index <= 20);
            waitframe(1);
        }
        wait randomfloatrange(0.333333, 0.666667);
    } while (!(__timeout__ >= 0 && __timeout__ - float(gettime() - var_6eb52594) / 1000 <= 0));
    return false;
}

// Namespace zm_vo/zm_vo
// Params 2, eflags: 0x0
// Checksum 0x3edf8826, Offset: 0x9c0
// Size: 0x8c
function function_32bfa028(var_cfde20a9, var_e6e816ad = isdefined(level.var_e6e816ad) ? level.var_e6e816ad : "banter") {
    if (!isdefined(level.var_c047eae4[var_e6e816ad])) {
        level.var_c047eae4[var_e6e816ad] = [];
    }
    level.var_c047eae4[var_e6e816ad][var_cfde20a9] = 1;
}

// Namespace zm_vo/zm_vo
// Params 3, eflags: 0x0
// Checksum 0x711a09f8, Offset: 0xa58
// Size: 0xc4
function function_646c38ba(var_cfde20a9, var_fc76ef8f = 1, var_e6e816ad = isdefined(level.var_e6e816ad) ? level.var_e6e816ad : "banter") {
    if (!isdefined(level.var_c047eae4[var_e6e816ad])) {
        level.var_c047eae4[var_e6e816ad] = [];
    }
    level.var_c047eae4[var_e6e816ad][var_cfde20a9] = undefined;
    if (var_fc76ef8f) {
        function_ad26d33("skipto", var_e6e816ad, var_cfde20a9);
    }
}

// Namespace zm_vo/zm_vo
// Params 2, eflags: 0x0
// Checksum 0x21a91c35, Offset: 0xb28
// Size: 0x78
function function_940a0864(var_cfde20a9, var_e6e816ad = isdefined(level.var_e6e816ad) ? level.var_e6e816ad : "banter") {
    if (isdefined(level.var_c047eae4[var_e6e816ad])) {
        return !isdefined(level.var_c047eae4[var_e6e816ad][var_cfde20a9]);
    }
    return true;
}

// Namespace zm_vo/zm_vo
// Params 2, eflags: 0x4
// Checksum 0xd78fa85c, Offset: 0xba8
// Size: 0xd4
function private function_17d8a019(var_6e7d46c1, var_e6e816ad) {
    if (!isdefined(level.var_d9c1686c[#"skipto"])) {
        level.var_d9c1686c[#"skipto"] = [];
    }
    if (isdefined(level.var_d9c1686c[#"skipto"][var_e6e816ad])) {
        var_f429e3f3 = level.var_d9c1686c[#"skipto"][var_e6e816ad];
        if (function_a575b777(var_6e7d46c1, var_e6e816ad) < var_f429e3f3) {
            function_ad26d33(var_6e7d46c1, var_e6e816ad, var_f429e3f3);
        }
    }
}

// Namespace zm_vo/zm_vo
// Params 2, eflags: 0x0
// Checksum 0x38ed9ad0, Offset: 0xc88
// Size: 0xba
function function_a575b777(var_6e7d46c1, var_e6e816ad = isdefined(level.var_e6e816ad) ? level.var_e6e816ad : "banter") {
    if (!isdefined(level.var_d9c1686c[var_6e7d46c1])) {
        level.var_d9c1686c[var_6e7d46c1] = [];
    }
    if (!isdefined(level.var_d9c1686c[var_6e7d46c1][var_e6e816ad])) {
        level.var_d9c1686c[var_6e7d46c1][var_e6e816ad] = 0;
    }
    return level.var_d9c1686c[var_6e7d46c1][var_e6e816ad];
}

// Namespace zm_vo/zm_vo
// Params 3, eflags: 0x0
// Checksum 0x25fb95ee, Offset: 0xd50
// Size: 0x94
function function_ad26d33(var_6e7d46c1, var_e6e816ad = isdefined(level.var_e6e816ad) ? level.var_e6e816ad : "banter", n_index) {
    if (!isdefined(level.var_d9c1686c[var_6e7d46c1])) {
        level.var_d9c1686c[var_6e7d46c1] = [];
    }
    level.var_d9c1686c[var_6e7d46c1][var_e6e816ad] = n_index;
}

// Namespace zm_vo/zm_vo
// Params 2, eflags: 0x4
// Checksum 0x88a11697, Offset: 0xdf0
// Size: 0x88
function private function_c5115fcb(var_6e7d46c1, var_e6e816ad) {
    n_index = int(min(function_a575b777(var_6e7d46c1, var_e6e816ad) + 1, 21));
    function_ad26d33(var_6e7d46c1, var_e6e816ad, n_index);
    return n_index;
}

// Namespace zm_vo/zm_vo
// Params 4, eflags: 0x4
// Checksum 0xdcd18673, Offset: 0xe80
// Size: 0x6bc
function private function_a3239326(var_e6e816ad = isdefined(level.var_e6e816ad) ? level.var_e6e816ad : "banter", var_cfde20a9, var_c6fae4e6, e_player_2) {
    var_f73f0bfc = var_c6fae4e6 zm_characters::function_82f5ce1a();
    var_9a5263c2 = var_c6fae4e6 function_d70b100f();
    var_69467b37 = e_player_2 zm_characters::function_82f5ce1a();
    var_744fe959 = e_player_2 function_d70b100f();
    a_test = [];
    if (!isdefined(a_test)) {
        a_test = [];
    } else if (!isarray(a_test)) {
        a_test = array(a_test);
    }
    a_test[a_test.size] = "vox_plr_" + var_f73f0bfc + "_" + var_cfde20a9 + "_" + var_e6e816ad + "_" + var_9a5263c2 + "_" + var_744fe959;
    if (!isdefined(a_test)) {
        a_test = [];
    } else if (!isarray(a_test)) {
        a_test = array(a_test);
    }
    a_test[a_test.size] = "vox_plr_" + var_f73f0bfc + "_" + var_cfde20a9 + "_" + var_e6e816ad + "_" + var_744fe959 + "_" + var_9a5263c2;
    if (!isdefined(a_test)) {
        a_test = [];
    } else if (!isarray(a_test)) {
        a_test = array(a_test);
    }
    a_test[a_test.size] = "vox_plr_" + var_69467b37 + "_" + var_cfde20a9 + "_" + var_e6e816ad + "_" + var_9a5263c2 + "_" + var_744fe959;
    if (!isdefined(a_test)) {
        a_test = [];
    } else if (!isarray(a_test)) {
        a_test = array(a_test);
    }
    a_test[a_test.size] = "vox_plr_" + var_69467b37 + "_" + var_cfde20a9 + "_" + var_e6e816ad + "_" + var_744fe959 + "_" + var_9a5263c2;
    if (var_cfde20a9 == 0) {
        if (!isdefined(a_test)) {
            a_test = [];
        } else if (!isarray(a_test)) {
            a_test = array(a_test);
        }
        a_test[a_test.size] = "vox_plr_" + var_f73f0bfc + "_" + var_e6e816ad + "_" + var_9a5263c2 + "_" + var_744fe959;
        if (!isdefined(a_test)) {
            a_test = [];
        } else if (!isarray(a_test)) {
            a_test = array(a_test);
        }
        a_test[a_test.size] = "vox_plr_" + var_f73f0bfc + "_" + var_e6e816ad + "_" + var_744fe959 + "_" + var_9a5263c2;
        if (!isdefined(a_test)) {
            a_test = [];
        } else if (!isarray(a_test)) {
            a_test = array(a_test);
        }
        a_test[a_test.size] = "vox_plr_" + var_69467b37 + "_" + var_e6e816ad + "_" + var_9a5263c2 + "_" + var_744fe959;
        if (!isdefined(a_test)) {
            a_test = [];
        } else if (!isarray(a_test)) {
            a_test = array(a_test);
        }
        a_test[a_test.size] = "vox_plr_" + var_69467b37 + "_" + var_e6e816ad + "_" + var_744fe959 + "_" + var_9a5263c2;
    }
    var_f6ac0425 = [];
    foreach (str_test in a_test) {
        foreach (str_line in zm_audio::get_valid_lines(str_test)) {
            array::add_sorted(var_f6ac0425, str_line, 0, &function_2ca0fb49);
        }
    }
    return {#var_fde65505:var_f6ac0425, #var_df2bf81b:array(0, 0.5)};
}

// Namespace zm_vo/zm_vo
// Params 1, eflags: 0x4
// Checksum 0xf91719bb, Offset: 0x1548
// Size: 0x2f8
function private function_820c60bb(var_3ef9e565) {
    if (zm_round_spawning::function_6a9f7d77()) {
        return 0;
    }
    b_played = 0;
    /#
        level endoncallback(&function_4ece47c8, #"kill_round");
    #/
    function_218256bd(1);
    if (level.players.size == 1) {
        e_player = level.players[0];
        if (var_3ef9e565 == 0) {
            str_suffix = "solo_game_start";
        } else {
            str_suffix = "solo_end_round" + var_3ef9e565;
        }
        b_played = e_player function_59635cc4(str_suffix, 0, 1);
    } else {
        var_f6ac0425 = [];
        a_str_vo = [];
        foreach (e_player in level.players) {
            n_character_index = e_player zm_characters::function_82f5ce1a();
            str_prefix = "vox_plr_" + n_character_index + "_";
            if (var_3ef9e565 == 0) {
                str_suffix = "co_op_game_start";
            } else {
                str_suffix = "co_op_end_round" + var_3ef9e565;
            }
            var_f6ac0425 = zm_audio::get_valid_lines(str_prefix + str_suffix);
            if (!isdefined(a_str_vo)) {
                a_str_vo = [];
            } else if (!isarray(a_str_vo)) {
                a_str_vo = array(a_str_vo);
            }
            a_str_vo[a_str_vo.size] = array::random(var_f6ac0425);
        }
        if (a_str_vo.size) {
            a_str_vo = array::merge_sort(a_str_vo, &function_2ca0fb49);
            var_df2bf81b = array(0, 0.5);
            b_played = function_7aa5324a(a_str_vo, var_df2bf81b, 1, undefined, 0, 0);
        }
    }
    function_218256bd(0);
    return b_played;
}

// Namespace zm_vo/zm_vo
// Params 1, eflags: 0x0
// Checksum 0x3dd2dcf3, Offset: 0x1848
// Size: 0x44
function function_4ece47c8(var_efb865a0) {
    function_218256bd(0);
    array::notify_all(level.players, "kill_early_round_vo");
}

// Namespace zm_vo/zm_vo
// Params 2, eflags: 0x0
// Checksum 0x3ab361f, Offset: 0x1898
// Size: 0x8c
function function_2ca0fb49(str_line1, str_line2) {
    var_ead24e19 = strtok(str_line1, "_");
    var_10d4c882 = strtok(str_line2, "_");
    return var_ead24e19[var_ead24e19.size - 1] < var_10d4c882[var_10d4c882.size - 1];
}

// Namespace zm_vo/zm_vo
// Params 2, eflags: 0x4
// Checksum 0xbd38944a, Offset: 0x1930
// Size: 0x1d6
function private function_7bddfedd(var_aaf038d2 = 1, a_players = array::randomize(function_9dfc8f57())) {
    var_a1530c07 = [];
    for (i = 0; i < a_players.size; i++) {
        for (j = 0; j < a_players.size; j++) {
            if (a_players[i] != a_players[j]) {
                player1 = a_players[i];
                player2 = a_players[j];
                var_5489ea89 = player1 zm_characters::function_82f5ce1a();
                var_7a8c64f2 = player2 zm_characters::function_82f5ce1a();
                var_6e7d46c1 = min(var_5489ea89, var_7a8c64f2) + "-" + max(var_5489ea89, var_7a8c64f2);
                if (!isdefined(var_a1530c07[var_6e7d46c1])) {
                    if (!var_aaf038d2 || function_13f3ccb9(player1, player2)) {
                        var_a1530c07[var_6e7d46c1] = array(player1, player2);
                    }
                }
            }
        }
    }
    return var_a1530c07;
}

// Namespace zm_vo/zm_vo
// Params 3, eflags: 0x0
// Checksum 0x45870316, Offset: 0x1b10
// Size: 0xce
function function_cfa5f8a9(n_timeout, var_aaf038d2, a_players) {
    __timeout__ = n_timeout;
    var_6eb52594 = gettime();
    do {
        var_a1530c07 = function_7bddfedd(var_aaf038d2, a_players);
        if (var_a1530c07.size) {
            break;
        }
        wait randomfloatrange(0.2, 0.4);
    } while (!(__timeout__ >= 0 && __timeout__ - float(gettime() - var_6eb52594) / 1000 <= 0));
    return var_a1530c07;
}

// Namespace zm_vo/zm_vo
// Params 2, eflags: 0x0
// Checksum 0xd49b1f71, Offset: 0x1be8
// Size: 0xde
function function_13f3ccb9(var_211dd637, var_af1666fc) {
    if (distancesquared(var_211dd637.origin, var_af1666fc.origin) < 589824) {
        if (abs(var_211dd637.origin[2] - var_af1666fc.origin[2]) < 96) {
            if (sighttracepassed(var_211dd637.origin + (0, 0, 64), var_af1666fc.origin + (0, 0, 64), 0, var_211dd637, var_af1666fc)) {
                return true;
            }
        }
    }
    return false;
}

// Namespace zm_vo/zm_vo
// Params 1, eflags: 0x0
// Checksum 0x97253f06, Offset: 0x1cd0
// Size: 0xf6
function vo_clear(str_endon) {
    if (isstring(str_endon)) {
        /#
            if (getdvarint(#"zm_debug_vo", 0)) {
                iprintlnbold("<dev string:x43>");
            }
            println("<dev string:x43>");
        #/
        self stopsound(self.str_vo_being_spoken);
    }
    self.str_vo_being_spoken = "";
    self.n_vo_priority = 0;
    self.isspeaking = 0;
    self.var_230a3f82 = 0;
    zm_audio::sndvoxoverride(0);
    self notify(#"done_speaking");
}

// Namespace zm_vo/zm_vo
// Params 1, eflags: 0x4
// Checksum 0x30b167ef, Offset: 0x1dd0
// Size: 0x88
function private function_218256bd(var_eca8128e) {
    foreach (player in level.activeplayers) {
        player function_cf8fccfe(var_eca8128e);
    }
}

// Namespace zm_vo/zm_vo
// Params 1, eflags: 0x4
// Checksum 0x286a8437, Offset: 0x1e60
// Size: 0x74
function private function_cf8fccfe(var_eca8128e) {
    self.dontspeak = var_eca8128e;
    self clientfield::set_to_player("isspeaking", var_eca8128e);
    if (var_eca8128e) {
        while (isdefined(self) && isdefined(self.isspeaking) && self.isspeaking) {
            wait 0.1;
        }
    }
}

// Namespace zm_vo/zm_vo
// Params 2, eflags: 0x4
// Checksum 0xcf9d400b, Offset: 0x1ee0
// Size: 0x80
function private function_5803cf05(n_max, var_6e653641) {
    assert(!isdefined(var_6e653641) || var_6e653641 < n_max, "<dev string:x4c>");
    do {
        n_new_value = randomint(n_max);
    } while (n_new_value === var_6e653641);
    return n_new_value;
}

// Namespace zm_vo/zm_vo
// Params 3, eflags: 0x4
// Checksum 0x14651a02, Offset: 0x1f68
// Size: 0x6e
function private function_5313ebe2(e1, e2, b_lowest_first = 1) {
    if (b_lowest_first) {
        return (e1.characterindex <= e2.characterindex);
    }
    return e1.characterindex > e2.characterindex;
}

// Namespace zm_vo/zm_vo
// Params 1, eflags: 0x0
// Checksum 0xcd7e8759, Offset: 0x1fe0
// Size: 0x2a
function is_player_valid(e_player) {
    return zm_utility::is_player_valid(e_player, 0, 0, 0);
}

// Namespace zm_vo/zm_vo
// Params 0, eflags: 0x0
// Checksum 0x4a41aa16, Offset: 0x2018
// Size: 0xe8
function function_9dfc8f57() {
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
// Checksum 0xd617f264, Offset: 0x2108
// Size: 0x60
function function_422b325b(var_230d3fab = 1) {
    while (true) {
        a_valid_players = function_9dfc8f57();
        if (a_valid_players.size >= var_230d3fab) {
            break;
        }
        waitframe(5);
    }
    return a_valid_players;
}

// Namespace zm_vo/zm_vo
// Params 0, eflags: 0x0
// Checksum 0xc8eabf4f, Offset: 0x2170
// Size: 0x58
function function_68ee653() {
    for (i = 0; i < level.activeplayers.size; i++) {
        if (is_player_speaking(level.activeplayers[i])) {
            return true;
        }
    }
    return false;
}

// Namespace zm_vo/zm_vo
// Params 1, eflags: 0x0
// Checksum 0xdc8b9648, Offset: 0x21d0
// Size: 0x4e
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
// Params 6, eflags: 0x0
// Checksum 0xf601a504, Offset: 0x2228
// Size: 0x16c
function function_59635cc4(var_a7fd41f8, n_delay = 0, b_wait_if_busy = 0, n_priority = 0, var_d1295208 = 0, var_c92d889f = 0) {
    assert(isplayer(self), "<invalid>" + "<dev string:xa0>");
    n_index = zm_characters::function_82f5ce1a();
    str_vo_alias = "vox_plr_" + n_index + "_" + var_a7fd41f8;
    a_variants = zm_audio::get_valid_lines(str_vo_alias);
    b_ret = vo_say(array::random(a_variants), n_delay, b_wait_if_busy, n_priority, var_d1295208, var_c92d889f);
    return isdefined(b_ret) && b_ret;
}

// Namespace zm_vo/zm_vo
// Params 6, eflags: 0x0
// Checksum 0x149c4965, Offset: 0x23a0
// Size: 0x216
function vo_say(str_vo_alias, n_delay = 0, b_wait_if_busy = 0, n_priority = 0, var_d1295208 = 0, var_c92d889f = 0) {
    self endoncallback(&vo_clear, #"death", #"kill_early_round_vo");
    if (!isdefined(str_vo_alias)) {
        return false;
    }
    if (zm_trial::is_trial_mode() || zm_utility::is_standard()) {
        return false;
    }
    if (level flag::get("story_playing")) {
        return false;
    }
    if (isplayer(self) && !is_player_valid(self)) {
        return false;
    }
    __timeout__ = n_delay;
    var_6eb52594 = gettime();
    if (!can_speak(var_d1295208, var_c92d889f)) {
        if (isdefined(b_wait_if_busy) && b_wait_if_busy) {
            do {
                waitframe(1);
            } while (!can_speak(var_d1295208, var_c92d889f));
        } else {
            return false;
        }
    }
    self thread function_10df3c37(__timeout__ - float(gettime() - var_6eb52594) / 1000, str_vo_alias, var_c92d889f);
    self waittill(#"done_speaking");
    return true;
}

// Namespace zm_vo/zm_vo
// Params 3, eflags: 0x0
// Checksum 0x61446e8d, Offset: 0x25c0
// Size: 0x23c
function function_10df3c37(n_delay, str_vo_alias, var_c92d889f) {
    self endoncallback(&vo_clear, #"death", #"kill_early_round_vo");
    if (var_c92d889f) {
        self.var_230a3f82 = 1;
    } else {
        self.isspeaking = 1;
    }
    zm_audio::sndvoxoverride(1);
    /#
        if (getdvarint(#"zm_debug_vo", 0)) {
            iprintlnbold("<dev string:xbd>" + str_vo_alias);
        }
        println("<dev string:xbd>" + str_vo_alias);
    #/
    if (n_delay > 0) {
        wait n_delay;
    }
    self notify(str_vo_alias + "_vo_started");
    self.str_vo_being_spoken = str_vo_alias;
    var_2df3d133 = str_vo_alias + "_vo_done";
    if (isactor(self) || isplayer(self)) {
        if (var_c92d889f) {
            self playsoundtoplayer(str_vo_alias, self);
            wait float(soundgetplaybacktime(str_vo_alias)) / 1000;
        } else {
            self playsoundwithnotify(str_vo_alias, var_2df3d133, "J_head");
            self waittill(var_2df3d133);
        }
    } else {
        self playsoundwithnotify(str_vo_alias, var_2df3d133);
        self waittill(var_2df3d133);
    }
    self.last_vo_played_time = gettime();
    self vo_clear();
}

// Namespace zm_vo/zm_vo
// Params 2, eflags: 0x0
// Checksum 0x7999465a, Offset: 0x2808
// Size: 0x94
function can_speak(var_d1295208, var_20bd3ee4) {
    if (isdefined(self.isspeaking) && self.isspeaking || isdefined(self.var_230a3f82) && self.var_230a3f82) {
        return false;
    }
    if (!var_d1295208 && zm_audio::function_bbc477e0(10000, var_20bd3ee4)) {
        return false;
    }
    if (isdefined(self.zmannouncertalking) && self.zmannouncertalking) {
        return false;
    }
    return true;
}

// Namespace zm_vo/zm_vo
// Params 5, eflags: 0x0
// Checksum 0x1b5a8bcc, Offset: 0x28a8
// Size: 0x188
function function_63c44c5a(a_str_vo, var_e21e86b8 = [], b_wait_if_busy = 0, n_priority = 0, var_d1295208 = 0) {
    b_played = 0;
    function_218256bd(1);
    foreach (i, str_vo in a_str_vo) {
        var_e27770b1 = isdefined(var_e21e86b8[i]) ? var_e21e86b8[i] : 0.5;
        b_said = vo_say(str_vo, var_e27770b1, b_wait_if_busy, n_priority, var_d1295208);
        if (isdefined(b_said) && b_said) {
            b_played = 1;
            continue;
        }
        break;
    }
    function_218256bd(0);
    return b_played;
}

// Namespace zm_vo/zm_vo
// Params 6, eflags: 0x0
// Checksum 0xce7f4110, Offset: 0x2a38
// Size: 0x188
function function_7aa5324a(a_str_vo, var_e21e86b8 = [], b_wait_if_busy = 0, n_priority = 0, var_d1295208 = 0, var_9f8e4a08 = 1) {
    b_played = 0;
    function_218256bd(1);
    foreach (i, str_vo in a_str_vo) {
        var_e27770b1 = isdefined(var_e21e86b8[i]) ? var_e21e86b8[i] : 0.5;
        if (function_897246e4(str_vo, var_e27770b1, b_wait_if_busy, n_priority, var_d1295208)) {
            b_played = 1;
            continue;
        }
        if (var_9f8e4a08) {
            break;
        }
    }
    function_218256bd(0);
    return b_played;
}

// Namespace zm_vo/zm_vo
// Params 5, eflags: 0x0
// Checksum 0x9624d53, Offset: 0x2bc8
// Size: 0x17e
function function_897246e4(str_vo_alias, n_wait = 0, b_wait_if_busy = 0, n_priority = 0, var_d1295208 = 0) {
    a_str_tokens = strtok(str_vo_alias, "_");
    if (a_str_tokens[1] === "plr") {
        var_edf0b06 = int(a_str_tokens[2]);
        e_speaker = zm_utility::function_a157d632(var_edf0b06);
        if (is_player_valid(e_speaker)) {
            b_played = e_speaker vo_say(str_vo_alias, n_wait, b_wait_if_busy, n_priority);
            return (isdefined(b_played) && b_played);
        }
    } else {
        e_speaker = undefined;
        assert(0, "<dev string:xc6>" + str_vo_alias + "<dev string:xe3>");
    }
    return false;
}

// Namespace zm_vo/zm_vo
// Params 2, eflags: 0x0
// Checksum 0xbbd1e242, Offset: 0x2d50
// Size: 0xc4
function function_8ac5430(var_b20e186c = 0, v_position = (0, 0, 0)) {
    if (var_b20e186c) {
        level zm_audio::sndvoxoverride(1);
        level flag::set("story_playing");
        function_2426269b(v_position, 9999);
        return;
    }
    level flag::clear("story_playing");
    level zm_audio::sndvoxoverride(0);
}

// Namespace zm_vo/zm_vo
// Params 5, eflags: 0x0
// Checksum 0x7bb220f3, Offset: 0x2e20
// Size: 0x124
function function_5eded46b(str_vo_line, n_wait = 0, b_wait_if_busy, n_priority = 99, var_d1295208 = 0) {
    function_218256bd(1);
    for (i = 1; i < level.activeplayers.size; i++) {
        level.activeplayers[i] thread vo_say(str_vo_line, n_wait + 0.1, b_wait_if_busy, n_priority, var_d1295208);
    }
    level.activeplayers[0] vo_say(str_vo_line, n_wait, b_wait_if_busy, n_priority, var_d1295208);
    function_218256bd(0);
}

// Namespace zm_vo/zm_vo
// Params 0, eflags: 0x0
// Checksum 0xdfe3b226, Offset: 0x2f50
// Size: 0x54
function vo_stop() {
    if (isdefined(self.str_vo_being_spoken) && self.str_vo_being_spoken != "") {
        self stopsound(self.str_vo_being_spoken);
    }
    vo_clear();
}

// Namespace zm_vo/zm_vo
// Params 2, eflags: 0x0
// Checksum 0x16aeaf82, Offset: 0x2fb0
// Size: 0x120
function function_2426269b(v_pos, n_range = 1000) {
    foreach (player in level.players) {
        if (!isdefined(v_pos) || distancesquared(player.origin, v_pos) <= n_range * n_range) {
            if (isdefined(player.str_vo_being_spoken) && player.str_vo_being_spoken != "") {
                player stopsound(player.str_vo_being_spoken);
                player vo_clear();
            }
        }
    }
}

// Namespace zm_vo/zm_vo
// Params 0, eflags: 0x0
// Checksum 0x5a77de1c, Offset: 0x30d8
// Size: 0xb2
function function_d70b100f() {
    fields = getcharacterfields(player_role::get(), currentsessionmode());
    if (isdefined(fields) && isdefined(fields.chrname) && fields.chrname != "") {
        return fields.chrname;
    }
    assert("<dev string:x113>");
    return "NONE";
}

// Namespace zm_vo/zm_vo
// Params 1, eflags: 0x0
// Checksum 0x1dbb99f7, Offset: 0x3198
// Size: 0x1a
function function_1a6f1ed1(func_banter) {
    level.var_491f7949 = func_banter;
}

