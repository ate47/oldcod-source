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

#namespace display_transition;

// Namespace display_transition/display_transition
// Params 0, eflags: 0x1 linked
// Checksum 0xa36e974b, Offset: 0x180
// Size: 0x24
function init_shared() {
    registerclientfields();
    function_7e74281();
}

// Namespace display_transition/display_transition
// Params 0, eflags: 0x5 linked
// Checksum 0x69b4e08a, Offset: 0x1b0
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
// Checksum 0x855d8a0e, Offset: 0x240
// Size: 0x3c
function private function_a5ce91f1(val) {
    if (sessionmodeiswarzonegame()) {
        self clientfield::set_to_player("eliminated_postfx", val);
    }
}

// Namespace display_transition/display_transition
// Params 0, eflags: 0x0
// Checksum 0x8772aeec, Offset: 0x288
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
// Checksum 0xfec6716b, Offset: 0x2e8
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
// Checksum 0xeb195af6, Offset: 0x380
// Size: 0x44
function function_e6b4f2f7(outcome) {
    function_76f27db3(outcome.var_c1e98979, 1, #"none", outcome.team, outcome.players);
}

// Namespace display_transition/display_transition
// Params 1, eflags: 0x1 linked
// Checksum 0xd94ea255, Offset: 0x3d0
// Size: 0x5c
function function_12d1f62a(outcome) {
    function_2fa975e0(util::getroundsplayed(), outcome.var_c1e98979, 1, #"none", outcome.team, outcome.players);
}

// Namespace display_transition/display_transition
// Params 1, eflags: 0x0
// Checksum 0x2dc355e7, Offset: 0x438
// Size: 0x5c
function display_match_end(outcome) {
    player::function_2f80d95b(&function_3f65d5d3);
    function_e6b4f2f7(outcome);
    function_15e28b1a(outcome);
}

// Namespace display_transition/display_transition
// Params 1, eflags: 0x0
// Checksum 0xe7d36768, Offset: 0x4a0
// Size: 0x7c
function display_round_end(outcome) {
    player::function_2f80d95b(&function_3f65d5d3);
    player::function_2f80d95b(&function_3cfb29e1);
    function_12d1f62a(outcome);
    function_cf3d556b(outcome);
}

// Namespace display_transition/display_transition
// Params 1, eflags: 0x5 linked
// Checksum 0xab3361f0, Offset: 0x528
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
// Checksum 0x4be56a90, Offset: 0x5e8
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
// Checksum 0x8c1e34d8, Offset: 0x7f8
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
// Params 0, eflags: 0x0
// Checksum 0x4a1c144c, Offset: 0x8d8
// Size: 0x54
function function_9b2bd02c() {
    player = self;
    player function_3f65d5d3();
    player function_61d01718(level.var_d1455682.eliminateddisplaytransition, #"elimination_transition");
}

// Namespace display_transition/display_transition
// Params 0, eflags: 0x0
// Checksum 0x25dec1cf, Offset: 0x938
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
// Checksum 0x871f157, Offset: 0x9e8
// Size: 0x5c
function function_f4c03c3b() {
    if (is_true(self.var_58f00ca2)) {
        return;
    }
    self.var_58f00ca2 = 1;
    self thread function_61d01718(level.var_d1455682.eliminateddisplaytransition, #"hash_4a3306cfce6719bc");
}

// Namespace display_transition/display_transition
// Params 1, eflags: 0x0
// Checksum 0xe48a4dd7, Offset: 0xa50
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
// Checksum 0xaf922e86, Offset: 0xba8
// Size: 0x40
function function_3f65d5d3() {
    if (!isdefined(self.pers[#"team"])) {
        self [[ level.spawnintermission ]](1);
        return true;
    }
    return false;
}

// Namespace display_transition/display_transition
// Params 0, eflags: 0x1 linked
// Checksum 0x716b9b10, Offset: 0xbf0
// Size: 0x76
function function_3cfb29e1() {
    if (!util::waslastround()) {
        music::setmusicstate("roundend");
        if (isdefined(self.pers[#"music"].spawn)) {
            self.pers[#"music"].spawn = 0;
        }
    }
}

// Namespace display_transition/display_transition
// Params 0, eflags: 0x5 linked
// Checksum 0x80f724d1, Offset: 0xc70
// Size: 0x4
function private freeze_player_for_round_end() {
    
}

// Namespace display_transition/display_transition
// Params 0, eflags: 0x5 linked
// Checksum 0xb8f14971, Offset: 0xc80
// Size: 0x38
function private function_ba94df6c() {
    self setclientuivisibilityflag("hud_visible", 0);
    self thread [[ level.spawnintermission ]](0);
}

// Namespace display_transition/display_transition
// Params 2, eflags: 0x1 linked
// Checksum 0xb007b461, Offset: 0xcc0
// Size: 0x14
function function_9185f489(*transition, *outcome) {
    
}

// Namespace display_transition/display_transition
// Params 2, eflags: 0x5 linked
// Checksum 0xbe224d64, Offset: 0xce0
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
// Checksum 0x93b647ca, Offset: 0xde0
// Size: 0x34
function private function_a3b4d41d(*transition, *outcome) {
    player::function_2f80d95b(&freeze_player_for_round_end);
}

// Namespace display_transition/display_transition
// Params 2, eflags: 0x5 linked
// Checksum 0x2ba9c18f, Offset: 0xe20
// Size: 0x34
function private function_654c0030(*transition, *outcome) {
    player::function_2f80d95b(&function_d7b5082e);
}

// Namespace display_transition/display_transition
// Params 2, eflags: 0x5 linked
// Checksum 0x2df278eb, Offset: 0xe60
// Size: 0x14
function private function_d9d842b2(*transition, *outcome) {
    
}

// Namespace display_transition/display_transition
// Params 2, eflags: 0x5 linked
// Checksum 0xfc415160, Offset: 0xe80
// Size: 0x14
function private function_b7fec738(*transition, *outcome) {
    
}

// Namespace display_transition/display_transition
// Params 2, eflags: 0x5 linked
// Checksum 0x2ee8d884, Offset: 0xea0
// Size: 0x14
function private function_66713ac(*transition, *outcome) {
    
}

// Namespace display_transition/display_transition
// Params 2, eflags: 0x5 linked
// Checksum 0xd4871d17, Offset: 0xec0
// Size: 0x14
function private function_8feabee3(*transition, *outcome) {
    
}

// Namespace display_transition/display_transition
// Params 2, eflags: 0x5 linked
// Checksum 0x69e25a5a, Offset: 0xee0
// Size: 0x14
function private function_a3c90acf(*transition, *outcome) {
    
}

// Namespace display_transition/display_transition
// Params 2, eflags: 0x5 linked
// Checksum 0xbb4952db, Offset: 0xf00
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
// Checksum 0xb9ef116e, Offset: 0x10d0
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
// Checksum 0xab1a4e12, Offset: 0x1168
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
// Checksum 0x88db0259, Offset: 0x1200
// Size: 0x24
function private function_a2d39e40(*transition, *outcome) {
    killcam::post_round_final_killcam();
}

// Namespace display_transition/display_transition
// Params 2, eflags: 0x5 linked
// Checksum 0xc613d572, Offset: 0x1230
// Size: 0x24
function private function_e3442abc(*transition, *outcome) {
    potm::post_round_potm();
}

// Namespace display_transition/display_transition
// Params 3, eflags: 0x5 linked
// Checksum 0x459d5fe3, Offset: 0x1260
// Size: 0x5e
function private function_7285f7e1(e1, e2, b_lowest_first = 0) {
    if (b_lowest_first) {
        return (e1.score <= e2.score);
    }
    return e1.score > e2.score;
}

// Namespace display_transition/display_transition
// Params 0, eflags: 0x4
// Checksum 0x8fd420ac, Offset: 0x12c8
// Size: 0x174
function private function_6b33e951() {
    max_team_size = 6;
    winning_team = #"allies";
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
// Checksum 0xe1215d85, Offset: 0x1448
// Size: 0x3c
function private function_87a832a5(transition, outcome) {
    if (sessionmodeismultiplayergame()) {
    }
    function_26bbb839(transition, outcome);
}

// Namespace display_transition/display_transition
// Params 2, eflags: 0x5 linked
// Checksum 0xe207f0d4, Offset: 0x1490
// Size: 0x34
function private function_721d8d6e(*transition, *outcome) {
    level clientfield::set("top_squad_begin", 1);
}

// Namespace display_transition/display_transition
// Params 0, eflags: 0x1 linked
// Checksum 0xf367fcd2, Offset: 0x14d0
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
// Checksum 0xf71a316c, Offset: 0x1648
// Size: 0x34
function function_b797319e(transition_type, var_e6825eda) {
    self luinotifyevent(transition_type, 1, var_e6825eda);
}

// Namespace display_transition/display_transition
// Params 0, eflags: 0x1 linked
// Checksum 0x899f0f6b, Offset: 0x1688
// Size: 0x24
function function_752a920f() {
    self luinotifyevent(#"clear_transition");
}

// Namespace display_transition/display_transition
// Params 0, eflags: 0x1 linked
// Checksum 0x72bf9344, Offset: 0x16b8
// Size: 0x5c
function function_d7b5082e() {
    if (isdefined(self.pers[#"totalmatchbonus"])) {
        self luinotifyevent(#"hash_9dfc8d44ea4547e", 1, self.pers[#"totalmatchbonus"]);
    }
}

// Namespace display_transition/display_transition
// Params 4, eflags: 0x1 linked
// Checksum 0x69e50ddd, Offset: 0x1720
// Size: 0x72
function display_transition(transition, var_e6825eda, outcome, lui_event) {
    player::function_e7f18b20(&function_b797319e, lui_event, var_e6825eda + 1);
    [[ level.var_3a309902[transition.type] ]](transition, outcome);
}

// Namespace display_transition/display_transition
// Params 3, eflags: 0x1 linked
// Checksum 0x379972f8, Offset: 0x17a0
// Size: 0x5a
function function_f2ffece2(transition, outcome, var_61f85cf) {
    if (isdefined(level.var_5d720398[transition.type])) {
        level thread [[ level.var_5d720398[transition.type] ]](transition, outcome, var_61f85cf);
    }
}

// Namespace display_transition/display_transition
// Params 0, eflags: 0x1 linked
// Checksum 0x4f2ae183, Offset: 0x1808
// Size: 0x24
function clear_transition() {
    player::function_2f80d95b(&function_752a920f);
}

// Namespace display_transition/display_transition
// Params 2, eflags: 0x1 linked
// Checksum 0x7ae99a95, Offset: 0x1838
// Size: 0x1ee
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
// Checksum 0xcac8b8ff, Offset: 0x1a30
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
// Checksum 0x77430b0d, Offset: 0x1bb0
// Size: 0x3c
function function_15e28b1a(outcome) {
    function_7e8f8c47(level.var_d1455682.finaldisplaytransition, outcome, #"match_transition");
}

// Namespace display_transition/display_transition
// Params 1, eflags: 0x1 linked
// Checksum 0xd65bc2f3, Offset: 0x1bf8
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
// Checksum 0xd63d3d13, Offset: 0x1cb0
// Size: 0x42
function round_end_wait(time) {
    if (time <= 0) {
        return;
    }
    level waittilltimeout(time * level.var_49d9aa70, #"hash_197c640e2f684a74");
}

// Namespace display_transition/display_transition
// Params 1, eflags: 0x0
// Checksum 0x13de88be, Offset: 0x1d00
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

