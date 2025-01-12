#using script_1cc417743d7c262d;
#using scripts\core_common\array_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\killcam_shared;
#using scripts\core_common\music_shared;
#using scripts\core_common\player\player_role;
#using scripts\core_common\player\player_shared;
#using scripts\core_common\potm_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;
#using scripts\mp_common\gametypes\globallogic;
#using scripts\mp_common\gametypes\globallogic_audio;
#using scripts\mp_common\gametypes\hud_message;
#using scripts\mp_common\gametypes\match;
#using scripts\mp_common\gametypes\outcome;
#using scripts\mp_common\gametypes\overtime;
#using scripts\mp_common\player\player_utils;

#namespace display_transition;

// Namespace display_transition/display_transition
// Params 0, eflags: 0x1 linked
// Checksum 0x183d751f, Offset: 0x1e8
// Size: 0x24
function init_shared() {
    registerclientfields();
    function_7e74281();
}

// Namespace display_transition/display_transition
// Params 0, eflags: 0x5 linked
// Checksum 0xbc43f433, Offset: 0x218
// Size: 0x84
function private registerclientfields() {
    if (sessionmodeiswarzonegame()) {
        clientfield::register("toplayer", "eliminated_postfx", 12000, 1, "int");
    }
    if (sessionmodeismultiplayergame()) {
        clientfield::register("world", "top_squad_begin", 1, 1, "int");
    }
}

// Namespace display_transition/display_transition
// Params 1, eflags: 0x5 linked
// Checksum 0xca4653b5, Offset: 0x2a8
// Size: 0x3c
function private function_a5ce91f1(val) {
    if (sessionmodeiswarzonegame()) {
        self clientfield::set_to_player("eliminated_postfx", val);
    }
}

// Namespace display_transition/display_transition
// Params 0, eflags: 0x1 linked
// Checksum 0x53348e46, Offset: 0x2f0
// Size: 0x52
function using_new_transitions() {
    if (isdefined(level.var_d1455682)) {
        if (!isdefined(level.var_d1455682.finaldisplaytransition) || level.var_d1455682.finaldisplaytransition.size == 0) {
            return false;
        }
    }
    return true;
}

// Namespace display_transition/display_transition
// Params 5, eflags: 0x5 linked
// Checksum 0x8ce1ad32, Offset: 0x350
// Size: 0x8c
function private function_b8e20f5f(transition, outcome, var_f6e1baec, var_b6818fc8, func) {
    if (is_true(var_f6e1baec)) {
        if ((isdefined(var_b6818fc8) ? var_b6818fc8 : 0) != 0) {
            wait float(var_b6818fc8) / 1000;
        }
        [[ func ]](transition, outcome);
    }
}

// Namespace display_transition/display_transition
// Params 1, eflags: 0x1 linked
// Checksum 0x28bb082e, Offset: 0x3e8
// Size: 0x54
function function_e6b4f2f7(outcome) {
    function_76f27db3(outcome.var_c1e98979, outcome::function_2e00fa44(outcome), #"none", outcome.team, outcome.players);
}

// Namespace display_transition/display_transition
// Params 1, eflags: 0x1 linked
// Checksum 0xe2e29147, Offset: 0x448
// Size: 0x64
function function_12d1f62a(outcome) {
    function_2fa975e0(util::getroundsplayed(), outcome.var_c1e98979, outcome::function_2e00fa44(outcome), #"none", outcome.team, outcome.players);
}

// Namespace display_transition/display_transition
// Params 1, eflags: 0x1 linked
// Checksum 0xfeae14e7, Offset: 0x4b8
// Size: 0xd4
function display_match_end(outcome) {
    player::function_2f80d95b(&function_3f65d5d3);
    function_e6b4f2f7(outcome);
    array::run_all(level.players, &hud_message::can_bg_draw, outcome);
    level thread function_73d36f61();
    function_15e28b1a(outcome);
    globallogic::function_452e18ad();
    array::run_all(level.players, &hud_message::hide_outcome);
}

// Namespace display_transition/display_transition
// Params 0, eflags: 0x1 linked
// Checksum 0x76da045, Offset: 0x598
// Size: 0x44
function function_73d36f61() {
    level thread globallogic_audio::set_music_global("matchend_start");
    waitframe(1);
    level thread globallogic_audio::set_music_global("matchend");
}

// Namespace display_transition/display_transition
// Params 1, eflags: 0x1 linked
// Checksum 0x8f209877, Offset: 0x5e8
// Size: 0xbc
function display_round_end(outcome) {
    player::function_2f80d95b(&function_3f65d5d3);
    function_12d1f62a(outcome);
    if (!util::waslastround()) {
        level thread function_ee8c4421();
    }
    function_cf3d556b(outcome);
    globallogic::function_452e18ad();
    array::run_all(level.players, &hud_message::hide_outcome);
}

// Namespace display_transition/display_transition
// Params 0, eflags: 0x1 linked
// Checksum 0xe7d14a91, Offset: 0x6b0
// Size: 0x44
function function_ee8c4421() {
    level thread globallogic_audio::set_music_global("roundend_start");
    waitframe(1);
    level thread globallogic_audio::set_music_global("roundend_loop");
}

// Namespace display_transition/display_transition
// Params 1, eflags: 0x5 linked
// Checksum 0xf466e0a1, Offset: 0x700
// Size: 0xb6
function private function_91b514e8(menuname) {
    player = self;
    player endon(#"disconnect");
    while (true) {
        waitresult = player waittill(#"menuresponse");
        menu = waitresult.menu;
        response = waitresult.response;
        if (isdefined(menuname)) {
            if (menu == menuname) {
                return;
            }
            continue;
        }
        if (menu == "GameEndScore") {
            return;
        }
    }
}

// Namespace display_transition/display_transition
// Params 2, eflags: 0x1 linked
// Checksum 0xab911fa4, Offset: 0x7c0
// Size: 0x208
function function_61d01718(transitions, lui_event) {
    if (!isdefined(transitions)) {
        return;
    }
    player = self;
    player endon(#"disconnect");
    foreach (index, transition in transitions) {
        player function_b797319e(lui_event, index + 1);
        if ((isdefined(transition.time) ? transition.time : 0) != 0) {
            round_end_wait(float(transition.time) / 1000);
            continue;
        }
        if ((isdefined(transition.var_bda115b5) ? transition.var_bda115b5 : 0) != 0) {
            self function_a5ce91f1(1);
            self thread function_c6f81aa1(float(transition.var_f4df0630) / 1000);
            player function_91b514e8(transition.menuresponse);
            self function_a5ce91f1(0);
            continue;
        }
        player function_91b514e8(transition.menuresponse);
    }
}

// Namespace display_transition/display_transition
// Params 1, eflags: 0x1 linked
// Checksum 0x773abdf, Offset: 0x9d0
// Size: 0xd6
function function_c6f81aa1(time) {
    if (!isdefined(time)) {
        return;
    }
    player = self;
    player endon(#"disconnect", #"spawned");
    player.var_686890d5 = 1;
    if (time <= 0) {
        time = 0.1;
    }
    wait time;
    if (!isdefined(player)) {
        return;
    }
    player.var_686890d5 = undefined;
    player.sessionstate = "spectator";
    player.spectatorclient = -1;
    player.killcamentity = -1;
    player.archivetime = 0;
    player.psoffsettime = 0;
    player.spectatekillcam = 0;
}

// Namespace display_transition/display_transition
// Params 0, eflags: 0x1 linked
// Checksum 0x7842164a, Offset: 0xab0
// Size: 0x54
function function_9b2bd02c() {
    player = self;
    player function_3f65d5d3();
    player function_61d01718(level.var_d1455682.eliminateddisplaytransition, #"elimination_transition");
}

// Namespace display_transition/display_transition
// Params 0, eflags: 0x1 linked
// Checksum 0x1711b9f0, Offset: 0xb10
// Size: 0xa4
function function_b3964dc9() {
    /#
        if (getdvarint(#"scr_disable_infiltration", 0)) {
            return;
        }
    #/
    if (is_true(level.var_a4c48e88)) {
        return;
    }
    player = self;
    player function_3f65d5d3();
    player function_61d01718(level.var_d1455682.eliminateddisplaytransition, #"hash_ee32e40c182320b");
}

// Namespace display_transition/display_transition
// Params 0, eflags: 0x0
// Checksum 0x504efe01, Offset: 0xbc0
// Size: 0x5c
function function_f4c03c3b() {
    if (is_true(self.var_58f00ca2)) {
        return;
    }
    self.var_58f00ca2 = 1;
    self thread function_61d01718(level.var_d1455682.eliminateddisplaytransition, #"hash_4a3306cfce6719bc");
}

// Namespace display_transition/display_transition
// Params 1, eflags: 0x1 linked
// Checksum 0xbffaeb47, Offset: 0xc28
// Size: 0x14c
function function_1caf5c87(team) {
    players = getplayers(team);
    player::function_4dcd9a89(players, &function_3f65d5d3);
    foreach (player in players) {
        if (player != self) {
            player.var_58f00ca2 = 1;
            player thread function_61d01718(level.var_d1455682.eliminateddisplaytransition, #"hash_4a3306cfce6719bc");
        }
    }
    if (self.team == team) {
        self.var_58f00ca2 = 1;
        self function_61d01718(level.var_d1455682.eliminateddisplaytransition, #"hash_4a3306cfce6719bc");
    }
}

// Namespace display_transition/display_transition
// Params 0, eflags: 0x1 linked
// Checksum 0x297b6e44, Offset: 0xd80
// Size: 0x40
function function_3f65d5d3() {
    if (!isdefined(self.pers[#"team"])) {
        self [[ level.spawnintermission ]](1);
        return true;
    }
    return false;
}

// Namespace display_transition/display_transition
// Params 0, eflags: 0x5 linked
// Checksum 0xd6c35d7, Offset: 0xdc8
// Size: 0x34
function private freeze_player_for_round_end() {
    self player::freeze_player_for_round_end();
    self thread globallogic::roundenddof();
}

// Namespace display_transition/display_transition
// Params 0, eflags: 0x5 linked
// Checksum 0x1a04b148, Offset: 0xe08
// Size: 0x38
function private function_ba94df6c() {
    self setclientuivisibilityflag("hud_visible", 0);
    self thread [[ level.spawnintermission ]](0);
}

// Namespace display_transition/display_transition
// Params 2, eflags: 0x1 linked
// Checksum 0x8dc90c39, Offset: 0xe48
// Size: 0x5c
function function_9185f489(transition, *outcome) {
    globallogic::function_2556afb5(outcome.var_20c0730c, outcome.var_18d4b2ad, float(outcome.var_3efb751d) / 1000);
}

// Namespace display_transition/display_transition
// Params 2, eflags: 0x5 linked
// Checksum 0x22785c7f, Offset: 0xeb0
// Size: 0xf4
function private function_e22f5208(*transition, *outcome) {
    var_9914886a = 0;
    foreach (player in level.players) {
        if (isdefined(player getlinkedent())) {
            player unlink();
            var_9914886a = 1;
        }
    }
    if (var_9914886a) {
        waitframe(1);
    }
    player::function_2f80d95b(&function_ba94df6c);
}

// Namespace display_transition/display_transition
// Params 2, eflags: 0x5 linked
// Checksum 0x1e093862, Offset: 0xfb0
// Size: 0x34
function private function_a3b4d41d(*transition, *outcome) {
    player::function_2f80d95b(&freeze_player_for_round_end);
}

// Namespace display_transition/display_transition
// Params 2, eflags: 0x5 linked
// Checksum 0x1597828b, Offset: 0xff0
// Size: 0x4c
function private function_654c0030(*transition, outcome) {
    player::function_2f80d95b(&function_d7b5082e);
    thread globallogic_audio::announce_game_winner(outcome);
}

// Namespace display_transition/display_transition
// Params 2, eflags: 0x5 linked
// Checksum 0x7ddc5462, Offset: 0x1048
// Size: 0x2c
function private function_d9d842b2(*transition, outcome) {
    thread globallogic_audio::function_57678746(outcome);
}

// Namespace display_transition/display_transition
// Params 2, eflags: 0x5 linked
// Checksum 0x48d9341d, Offset: 0x1080
// Size: 0x2c
function private function_b7fec738(*transition, *outcome) {
    thread globallogic_audio::announce_round_winner(0);
}

// Namespace display_transition/display_transition
// Params 2, eflags: 0x5 linked
// Checksum 0x5b6dfa20, Offset: 0x10b8
// Size: 0x24
function private function_66713ac(*transition, *outcome) {
    thread globallogic_audio::function_5e0a6842();
}

// Namespace display_transition/display_transition
// Params 2, eflags: 0x5 linked
// Checksum 0xfb2bc467, Offset: 0x10e8
// Size: 0x24
function private function_8feabee3(*transition, *outcome) {
    thread globallogic_audio::function_dfd17bd3();
}

// Namespace display_transition/display_transition
// Params 2, eflags: 0x5 linked
// Checksum 0x8490a58b, Offset: 0x1118
// Size: 0x24
function private function_a3c90acf(*transition, *outcome) {
    thread globallogic_audio::function_1f89b047();
}

// Namespace display_transition/display_transition
// Params 2, eflags: 0x5 linked
// Checksum 0x79081b56, Offset: 0x1148
// Size: 0x1c4
function private function_26bbb839(transition, outcome) {
    thread function_b8e20f5f(transition, outcome, transition.slowdown, transition.var_d7f20c92, &function_9185f489);
    thread function_b8e20f5f(transition, outcome, transition.freezeplayers, transition.freezetime, &function_a3b4d41d);
    thread function_b8e20f5f(transition, outcome, transition.var_b0bc6ae0, transition.var_8d7c57a2, &function_8feabee3);
    thread function_b8e20f5f(transition, outcome, transition.var_738bf790, transition.var_8dc11094, &function_a3c90acf);
    thread function_b8e20f5f(transition, outcome, transition.var_619875ca, transition.var_73f860db, &function_b7fec738);
    thread function_b8e20f5f(transition, outcome, transition.var_7a712c7, transition.var_a803fe51, &function_66713ac);
    thread function_b8e20f5f(transition, outcome, transition.var_93a95648, transition.var_de820e2d, &function_654c0030);
    thread function_b8e20f5f(transition, outcome, transition.var_f9995c63, transition.var_41fc87a8, &function_d9d842b2);
    thread function_b8e20f5f(transition, outcome, transition.pickup_message, transition.var_5026a297, &function_e22f5208);
}

// Namespace display_transition/display_transition
// Params 0, eflags: 0x1 linked
// Checksum 0x7c1bb76b, Offset: 0x1318
// Size: 0x90
function checkroundswitch() {
    if (!isdefined(level.roundswitch) || !level.roundswitch) {
        return false;
    }
    if (!isdefined(level.onroundswitch)) {
        return false;
    }
    assert(game.roundsplayed > 0);
    if (game.roundsplayed % level.roundswitch == 0) {
        [[ level.onroundswitch ]]();
        return true;
    }
    return false;
}

// Namespace display_transition/display_transition
// Params 2, eflags: 0x5 linked
// Checksum 0x35b26ee7, Offset: 0x13b0
// Size: 0x8c
function private function_e3855f6d(transition, outcome) {
    if (util::waslastround()) {
        return;
    }
    if (!is_true(level.var_3e7c197f) && !checkroundswitch()) {
        return;
    }
    level.var_3e7c197f = 1;
    function_26bbb839(transition, outcome);
}

// Namespace display_transition/display_transition
// Params 2, eflags: 0x5 linked
// Checksum 0x34c10f40, Offset: 0x1448
// Size: 0x5c
function private function_a2d39e40(*transition, *outcome) {
    globallogic::function_452e18ad();
    array::run_all(level.players, &hud_message::hide_outcome);
    killcam::post_round_final_killcam();
}

// Namespace display_transition/display_transition
// Params 2, eflags: 0x5 linked
// Checksum 0x3a755a7f, Offset: 0x14b0
// Size: 0x5c
function private function_e3442abc(*transition, *outcome) {
    globallogic::function_452e18ad();
    array::run_all(level.players, &hud_message::hide_outcome);
    potm::post_round_potm();
}

// Namespace display_transition/display_transition
// Params 3, eflags: 0x5 linked
// Checksum 0xaad965b3, Offset: 0x1518
// Size: 0x5e
function private function_7285f7e1(e1, e2, b_lowest_first = 0) {
    if (b_lowest_first) {
        return (e1.score <= e2.score);
    }
    return e1.score > e2.score;
}

// Namespace display_transition/display_transition
// Params 0, eflags: 0x4
// Checksum 0x23a2f0cb, Offset: 0x1580
// Size: 0x174
function private function_6b33e951() {
    max_team_size = 6;
    winning_team = match::get_winning_team();
    if (winning_team == #"none") {
        winning_team = #"allies";
    }
    winners = getplayers(winning_team);
    winners = array::merge_sort(winners, &function_7285f7e1, 0);
    var_860af94a = array();
    for (i = 0; i < max_team_size; i++) {
        client_num = isdefined(winners[i]) ? winners[i].entnum : -1;
        array::add(var_860af94a, client_num);
    }
    luinotifyevent(#"top_squad", max_team_size, var_860af94a[0], var_860af94a[1], var_860af94a[2], var_860af94a[3], var_860af94a[4], var_860af94a[5]);
}

// Namespace display_transition/display_transition
// Params 2, eflags: 0x5 linked
// Checksum 0xc1fff051, Offset: 0x1700
// Size: 0x3c
function private function_87a832a5(transition, outcome) {
    if (sessionmodeismultiplayergame()) {
    }
    function_26bbb839(transition, outcome);
}

// Namespace display_transition/display_transition
// Params 2, eflags: 0x5 linked
// Checksum 0x50880ee2, Offset: 0x1748
// Size: 0x44
function private function_721d8d6e(*transition, *outcome) {
    globallogic::function_452e18ad();
    level clientfield::set("top_squad_begin", 1);
}

// Namespace display_transition/display_transition
// Params 0, eflags: 0x1 linked
// Checksum 0xf653e86d, Offset: 0x1798
// Size: 0x16c
function function_7e74281() {
    level.var_3a309902[#"blank"] = &function_26bbb839;
    level.var_3a309902[#"outcome"] = &function_87a832a5;
    level.var_3a309902[#"outcome_with_score"] = &function_26bbb839;
    level.var_3a309902[#"outcome_with_time"] = &function_26bbb839;
    level.var_3a309902[#"switch_sides"] = &function_e3855f6d;
    level.var_3a309902[#"final_killcam"] = &function_a2d39e40;
    level.var_3a309902[#"play_of_the_match"] = &function_e3442abc;
    level.var_3a309902[#"high_value_operatives"] = &function_26bbb839;
    level.var_3a309902[#"top_squad"] = &function_721d8d6e;
}

// Namespace display_transition/display_transition
// Params 2, eflags: 0x1 linked
// Checksum 0xe7ca0123, Offset: 0x1910
// Size: 0x34
function function_b797319e(transition_type, var_e6825eda) {
    self luinotifyevent(transition_type, 1, var_e6825eda);
}

// Namespace display_transition/display_transition
// Params 0, eflags: 0x1 linked
// Checksum 0x32cc653d, Offset: 0x1950
// Size: 0x24
function function_752a920f() {
    self luinotifyevent(#"clear_transition");
}

// Namespace display_transition/display_transition
// Params 0, eflags: 0x1 linked
// Checksum 0x5e090c56, Offset: 0x1980
// Size: 0x5c
function function_d7b5082e() {
    if (isdefined(self.pers[#"totalmatchbonus"])) {
        self luinotifyevent(#"hash_9dfc8d44ea4547e", 1, self.pers[#"totalmatchbonus"]);
    }
}

// Namespace display_transition/display_transition
// Params 4, eflags: 0x1 linked
// Checksum 0x59ef456d, Offset: 0x19e8
// Size: 0x72
function display_transition(transition, var_e6825eda, outcome, lui_event) {
    player::function_e7f18b20(&function_b797319e, lui_event, var_e6825eda + 1);
    [[ level.var_3a309902[transition.type] ]](transition, outcome);
}

// Namespace display_transition/display_transition
// Params 3, eflags: 0x1 linked
// Checksum 0x43f9b3fa, Offset: 0x1a68
// Size: 0x5a
function function_f2ffece2(transition, outcome, var_61f85cf) {
    if (isdefined(level.var_5d720398[transition.type])) {
        level thread [[ level.var_5d720398[transition.type] ]](transition, outcome, var_61f85cf);
    }
}

// Namespace display_transition/display_transition
// Params 0, eflags: 0x1 linked
// Checksum 0x5752f36e, Offset: 0x1ad0
// Size: 0x4c
function clear_transition() {
    player::function_2f80d95b(&function_752a920f);
    array::run_all(level.players, &hud_message::hide_outcome);
}

// Namespace display_transition/display_transition
// Params 2, eflags: 0x1 linked
// Checksum 0xa22ac3bf, Offset: 0x1b28
// Size: 0x24e
function function_40a46b5b(transition, outcome) {
    if (is_true(transition.disable)) {
        return true;
    }
    if (is_true(transition.var_b5dabc6b)) {
        if (util::waslastround() || util::isoneround()) {
            return true;
        }
    }
    var_860cd9fa = isdefined(level.shouldplayovertimeround) && [[ level.shouldplayovertimeround ]]();
    if (isdefined(level.shouldplayovertimeround) && [[ level.shouldplayovertimeround ]]()) {
        if (is_true(transition.var_d0f2da62)) {
            return true;
        }
    } else if (is_true(transition.var_fb87c2b4)) {
        return true;
    }
    if (overtime::is_overtime_round()) {
        if (is_true(transition.var_e0d86f3)) {
            return true;
        }
    } else if (is_true(transition.var_7b778818)) {
        return true;
    }
    if (transition.type == "team_pose") {
        if (outcome.team == #"none") {
            return true;
        }
        if (!isdefined(struct::get("team_pose_cam", "targetname"))) {
            return true;
        }
    }
    if (transition.type == "switch_sides") {
        if (!is_true(level.roundswitch)) {
            return true;
        }
    }
    if (transition.type == "outcome") {
        if (is_true(level.var_67a68459)) {
            return true;
        }
    }
    return false;
}

// Namespace display_transition/display_transition
// Params 3, eflags: 0x1 linked
// Checksum 0x52f12146, Offset: 0x1d80
// Size: 0x174
function function_7e8f8c47(transitions, outcome, lui_event) {
    foreach (index, transition in transitions) {
        if (function_40a46b5b(transition, outcome)) {
            continue;
        }
        level notify(#"display_transition", index);
        display_transition(transition, index, outcome, lui_event);
        if ((isdefined(transition.time) ? transition.time : 0) != 0) {
            round_end_wait(float(transition.time) / 1000);
        }
        function_f2ffece2(transition, outcome, transitions[index + 1]);
    }
    clear_transition();
}

// Namespace display_transition/display_transition
// Params 1, eflags: 0x1 linked
// Checksum 0x99b12ef6, Offset: 0x1f00
// Size: 0x3c
function function_15e28b1a(outcome) {
    function_7e8f8c47(level.var_d1455682.finaldisplaytransition, outcome, #"match_transition");
}

// Namespace display_transition/display_transition
// Params 1, eflags: 0x1 linked
// Checksum 0xf0f0907f, Offset: 0x1f48
// Size: 0xac
function function_cf3d556b(outcome) {
    if (is_true(level.var_d1455682.var_e779605d)) {
        if (util::waslastround() || util::isoneround()) {
            return;
        }
    }
    transitions = level.var_d1455682.rounddisplaytransition;
    if (!isdefined(transitions)) {
        return;
    }
    function_7e8f8c47(transitions, outcome, #"round_transition");
}

// Namespace display_transition/display_transition
// Params 1, eflags: 0x1 linked
// Checksum 0xd9226d4b, Offset: 0x2000
// Size: 0x42
function round_end_wait(time) {
    if (time <= 0) {
        return;
    }
    level waittilltimeout(time * level.var_49d9aa70, #"hash_197c640e2f684a74");
}

// Namespace display_transition/display_transition
// Params 1, eflags: 0x0
// Checksum 0xac8398f5, Offset: 0x2050
// Size: 0xd8
function function_ad717b18(var_c139bfe2) {
    assert(isdefined(level.roundenddelay[var_c139bfe2]));
    delay = level.roundenddelay[var_c139bfe2] * level.var_49d9aa70;
    if (delay) {
        return;
    }
    var_f05b8779 = delay / 2;
    if (var_f05b8779 > 0) {
        wait var_f05b8779;
        var_f05b8779 = delay / 2;
    } else {
        var_f05b8779 = delay / 2 + var_f05b8779;
    }
    level notify(#"give_match_bonus");
    if (var_f05b8779 > 0) {
        wait var_f05b8779;
    }
}

