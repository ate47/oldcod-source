#using scripts\core_common\array_shared;
#using scripts\core_common\killcam_shared;
#using scripts\core_common\player\player_role;
#using scripts\core_common\player\player_shared;
#using scripts\core_common\potm_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;
#using scripts\mp_common\gametypes\globallogic;
#using scripts\mp_common\gametypes\globallogic_audio;
#using scripts\mp_common\gametypes\hud_message;
#using scripts\mp_common\gametypes\outcome;
#using scripts\mp_common\player\player_utils;

#namespace display_transition;

// Namespace display_transition/display_transition
// Params 0, eflags: 0x0
// Checksum 0xc214ad4c, Offset: 0x140
// Size: 0x52
function function_7ba795bd() {
    if (isdefined(level.var_b77eff6f)) {
        if (!isdefined(level.var_b77eff6f.finaldisplaytransition) || level.var_b77eff6f.finaldisplaytransition.size == 0) {
            return false;
        }
    }
    return true;
}

// Namespace display_transition/display_transition
// Params 5, eflags: 0x4
// Checksum 0xc38829e5, Offset: 0x1a0
// Size: 0x88
function private function_776b1477(transition, outcome, feature_enabled, feature_time, func) {
    if (isdefined(feature_enabled) && feature_enabled) {
        if ((isdefined(feature_time) ? feature_time : 0) != 0) {
            wait float(feature_time) / 1000;
        }
        [[ func ]](transition, outcome);
    }
}

// Namespace display_transition/display_transition
// Params 1, eflags: 0x0
// Checksum 0xd506c76c, Offset: 0x230
// Size: 0x9c
function function_a744e1b4(outcome) {
    if (level.teambased) {
        function_ab7cbac6(outcome.var_c3d87d03, outcome::function_fcece5f9(outcome), outcome.team);
        return;
    }
    function_ab7cbac6(outcome.var_c3d87d03, outcome::function_fcece5f9(outcome), outcome.team, outcome.players);
}

// Namespace display_transition/display_transition
// Params 1, eflags: 0x0
// Checksum 0xa475387c, Offset: 0x2d8
// Size: 0xcc
function function_3648fa6b(outcome) {
    if (level.teambased) {
        function_a088d35b(util::getroundsplayed(), outcome.var_c3d87d03, outcome::function_fcece5f9(outcome), outcome.team);
        return;
    }
    function_a088d35b(util::getroundsplayed(), outcome.var_c3d87d03, outcome::function_fcece5f9(outcome), outcome.team, outcome.players);
}

// Namespace display_transition/display_transition
// Params 1, eflags: 0x0
// Checksum 0x2a8af214, Offset: 0x3b0
// Size: 0x94
function function_76bbac9d(outcome) {
    player::function_15b6b25d(&function_decca9ea);
    function_a744e1b4(outcome);
    function_da749172(outcome);
    globallogic::function_f7f33c6d();
    array::run_all(level.players, &hud_message::hide_outcome);
}

// Namespace display_transition/display_transition
// Params 1, eflags: 0x0
// Checksum 0x1d1a43da, Offset: 0x450
// Size: 0xb4
function display_round_end(outcome) {
    player::function_15b6b25d(&function_decca9ea);
    player::function_15b6b25d(&function_367cfd19);
    function_3648fa6b(outcome);
    function_924e59d1(outcome);
    globallogic::function_f7f33c6d();
    array::run_all(level.players, &hud_message::hide_outcome);
}

// Namespace display_transition/display_transition
// Params 0, eflags: 0x4
// Checksum 0x1eeee730, Offset: 0x510
// Size: 0x9e
function private function_5b3be0ee() {
    player = self;
    player endon(#"disconnect");
    while (true) {
        waitresult = player waittill(#"menuresponse");
        menu = waitresult.menu;
        response = waitresult.response;
        if (menu == "GameEndScore") {
            return;
        }
    }
}

// Namespace display_transition/display_transition
// Params 2, eflags: 0x0
// Checksum 0x363a0b11, Offset: 0x5b8
// Size: 0x174
function function_775b32b4(transitions, lui_event) {
    player = self;
    player setclientuivisibilityflag("hud_visible", 0);
    foreach (index, transition in transitions) {
        player function_f3ae8392(lui_event, index + 1);
        if ((isdefined(transition.time) ? transition.time : 0) != 0) {
            round_end_wait(float(transition.time) / 1000);
            continue;
        }
        player function_5b3be0ee();
    }
    player function_c31ae8dc();
    player setclientuivisibilityflag("hud_visible", 1);
}

// Namespace display_transition/display_transition
// Params 0, eflags: 0x0
// Checksum 0xe83c42b3, Offset: 0x738
// Size: 0x54
function function_3541df96() {
    player = self;
    player function_decca9ea();
    player function_775b32b4(level.var_b77eff6f.eliminateddisplaytransition, #"elimination_transition");
}

// Namespace display_transition/display_transition
// Params 1, eflags: 0x0
// Checksum 0xe1d190b9, Offset: 0x798
// Size: 0xd8
function function_d66ee9aa(team) {
    players = getplayers(team);
    player::function_40a2a4fd(players, &function_decca9ea);
    foreach (player in players) {
        player thread function_775b32b4(level.var_b77eff6f.eliminateddisplaytransition, #"elimination_transition");
    }
}

// Namespace display_transition/display_transition
// Params 0, eflags: 0x0
// Checksum 0xb643400d, Offset: 0x878
// Size: 0x40
function function_decca9ea() {
    if (!isdefined(self.pers[#"team"])) {
        self [[ level.spawnintermission ]](1);
        return true;
    }
    return false;
}

// Namespace display_transition/display_transition
// Params 0, eflags: 0x0
// Checksum 0x54c8ecb9, Offset: 0x8c0
// Size: 0x9e
function function_367cfd19() {
    if (!util::waslastround()) {
        self playlocalsound(#"hash_7353399f9153966f");
        self thread globallogic_audio::set_music_on_player("none");
        if (isdefined(self.pers[#"music"].spawn)) {
            self.pers[#"music"].spawn = 0;
        }
    }
}

// Namespace display_transition/display_transition
// Params 0, eflags: 0x4
// Checksum 0x95319517, Offset: 0x968
// Size: 0x34
function private freeze_player_for_round_end() {
    self player::freeze_player_for_round_end();
    self thread globallogic::roundenddof();
}

// Namespace display_transition/display_transition
// Params 0, eflags: 0x4
// Checksum 0x1edcf574, Offset: 0x9a8
// Size: 0x38
function private function_625d662() {
    self setclientuivisibilityflag("hud_visible", 0);
    self thread [[ level.spawnintermission ]](0);
}

// Namespace display_transition/display_transition
// Params 2, eflags: 0x0
// Checksum 0x3c523741, Offset: 0x9e8
// Size: 0x64
function function_75fc59a7(transition, outcome) {
    globallogic::function_c81eabc3(transition.var_12d26890, transition.var_c6f506a3, float(transition.var_2b58b569) / 1000);
}

// Namespace display_transition/display_transition
// Params 2, eflags: 0x4
// Checksum 0xe23a4552, Offset: 0xa58
// Size: 0x34
function private function_7fb42b16(transition, outcome) {
    player::function_15b6b25d(&function_625d662);
}

// Namespace display_transition/display_transition
// Params 2, eflags: 0x4
// Checksum 0x99dddc55, Offset: 0xa98
// Size: 0x34
function private function_e57e6525(transition, outcome) {
    player::function_15b6b25d(&freeze_player_for_round_end);
}

// Namespace display_transition/display_transition
// Params 2, eflags: 0x4
// Checksum 0x41123b10, Offset: 0xad8
// Size: 0x8c
function private function_5dfdd47a(transition, outcome) {
    player::function_15b6b25d(&function_40c85426);
    thread globallogic_audio::announce_game_winner(outcome);
    player::function_15b6b25d(&globallogic_audio::function_fa0ee392, outcome::get_flag(outcome, "tie"));
}

// Namespace display_transition/display_transition
// Params 2, eflags: 0x4
// Checksum 0x8141692c, Offset: 0xb70
// Size: 0x2c
function private function_fcb5c675(transition, outcome) {
    thread globallogic_audio::function_e89544a8(outcome);
}

// Namespace display_transition/display_transition
// Params 2, eflags: 0x4
// Checksum 0x4f6ba187, Offset: 0xba8
// Size: 0x2c
function private function_71f5a689(transition, outcome) {
    thread globallogic_audio::announce_round_winner(0);
}

// Namespace display_transition/display_transition
// Params 2, eflags: 0x4
// Checksum 0xc099da5e, Offset: 0xbe0
// Size: 0x24
function private function_d012385c(transition, outcome) {
    thread globallogic_audio::function_8065d7d5();
}

// Namespace display_transition/display_transition
// Params 2, eflags: 0x4
// Checksum 0xc6f48339, Offset: 0xc10
// Size: 0x24
function private function_a5fc522e(transition, outcome) {
    thread globallogic_audio::function_eb44731f();
}

// Namespace display_transition/display_transition
// Params 2, eflags: 0x4
// Checksum 0x88874212, Offset: 0xc40
// Size: 0x214
function private function_539e1cac(transition, outcome) {
    thread function_776b1477(transition, outcome, transition.slowdown, transition.var_c4fd13a7, &function_75fc59a7);
    thread function_776b1477(transition, outcome, transition.freezeplayers, transition.freezetime, &function_e57e6525);
    thread function_776b1477(transition, outcome, transition.var_f75345e8, transition.var_d43b8e83, &function_a5fc522e);
    thread function_776b1477(transition, outcome, transition.var_9938bd03, transition.var_bd1b0138, &function_71f5a689);
    thread function_776b1477(transition, outcome, transition.var_974168d4, transition.var_1f6ac637, &function_d012385c);
    thread function_776b1477(transition, outcome, transition.var_41272d1d, transition.var_357b351a, &function_5dfdd47a);
    thread function_776b1477(transition, outcome, transition.var_ecdb2916, transition.var_ab2945e9, &function_fcb5c675);
    thread function_776b1477(transition, outcome, transition.var_7ac1cd87, transition.var_e044b7a9, &function_7fb42b16);
}

// Namespace display_transition/display_transition
// Params 2, eflags: 0x4
// Checksum 0xb6544d81, Offset: 0xe60
// Size: 0x2c
function private function_8b93f493(transition, outcome) {
    function_539e1cac(transition, outcome);
}

// Namespace display_transition/display_transition
// Params 2, eflags: 0x4
// Checksum 0xb03c7074, Offset: 0xe98
// Size: 0x2c
function private function_30e1af5(transition, outcome) {
    function_539e1cac(transition, outcome);
}

// Namespace display_transition/display_transition
// Params 0, eflags: 0x0
// Checksum 0x4d90f460, Offset: 0xed0
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
// Params 2, eflags: 0x4
// Checksum 0xbe93d998, Offset: 0xf68
// Size: 0x5c
function private function_2b03322c(transition, outcome) {
    if (util::waslastround()) {
        return;
    }
    if (!checkroundswitch()) {
        return;
    }
    function_539e1cac(transition, outcome);
}

// Namespace display_transition/display_transition
// Params 2, eflags: 0x4
// Checksum 0x5a42746e, Offset: 0xfd0
// Size: 0x5c
function private function_715b9d2f(transition, outcome) {
    globallogic::function_f7f33c6d();
    array::run_all(level.players, &hud_message::hide_outcome);
    killcam::post_round_final_killcam();
}

// Namespace display_transition/display_transition
// Params 2, eflags: 0x4
// Checksum 0x27ddc722, Offset: 0x1038
// Size: 0x5c
function private function_cc09569b(transition, outcome) {
    globallogic::function_f7f33c6d();
    array::run_all(level.players, &hud_message::hide_outcome);
    potm::post_round_potm();
}

// Namespace display_transition/display_transition
// Params 2, eflags: 0x4
// Checksum 0xf6e06a04, Offset: 0x10a0
// Size: 0x6c
function private function_f9222b07(p1, p2) {
    if (p1.score != p2.score) {
        return (p1.score > p2.score);
    }
    return p1 getentitynumber() <= p2 getentitynumber();
}

// Namespace display_transition/display_transition
// Params 2, eflags: 0x4
// Checksum 0x9b2d06e, Offset: 0x1118
// Size: 0x33c
function private function_cc0d074a(transition, outcome) {
    var_2182910c = array();
    foreach (player in level.players) {
        if (player.team == outcome.team && player player_role::get() != 0) {
            array::add(var_2182910c, player);
        }
    }
    player_positions = array();
    for (i = 0; ; i++) {
        pos = struct::get("team_pose_" + i, "targetname");
        if (isdefined(pos)) {
            array::add(player_positions, pos);
            continue;
        }
        break;
    }
    var_5b3bea78 = struct::get("team_pose_cam", "targetname");
    if (var_2182910c.size == 0 || player_positions.size == 0 || !isdefined(var_5b3bea78)) {
        return;
    }
    function_539e1cac(transition, outcome);
    var_2182910c = array::quick_sort(var_2182910c, &function_f9222b07);
    for (i = 0; i < min(var_2182910c.size, player_positions.size); i++) {
        player = var_2182910c[i];
        player.sessionstate = "playing";
        player takeallweapons();
        fields = getcharacterfields(player player_role::get(), currentsessionmode());
        if (i == 0) {
            player_positions[i] thread scene::play(fields.heroicscenes[0].scene, player);
            continue;
        }
        player_positions[i] thread scene::play(fields.heroicposes[0].scene, player);
    }
    var_5b3bea78 thread scene::play("team_pose_cam");
}

// Namespace display_transition/display_transition
// Params 3, eflags: 0x0
// Checksum 0x4a896289, Offset: 0x1460
// Size: 0x9c
function function_19b1ef83(transition, outcome, next_transition) {
    if (isdefined(next_transition)) {
        if (next_transition.type == "play_of_the_match") {
            level waittill(#"hash_4ead2cd3fa59f29b");
        }
        var_5b3bea78 = struct::get("team_pose_cam", "targetname");
        var_5b3bea78 thread scene::stop("team_pose_cam");
    }
}

// Namespace display_transition/display_transition
// Params 0, eflags: 0x0
// Checksum 0xaa93101d, Offset: 0x1508
// Size: 0x1b2
function function_e1efa707() {
    level.var_812c2d64[#"blank"] = &function_539e1cac;
    level.var_812c2d64[#"outcome"] = &function_8b93f493;
    level.var_812c2d64[#"outcome_with_score"] = &function_30e1af5;
    level.var_812c2d64[#"switch_sides"] = &function_2b03322c;
    level.var_812c2d64[#"final_killcam"] = &function_715b9d2f;
    level.var_812c2d64[#"play_of_the_match"] = &function_cc09569b;
    level.var_812c2d64[#"team_pose"] = &function_cc0d074a;
    level.var_812c2d64[#"high_value_operatives"] = &function_539e1cac;
    level.var_f9a10aff[#"team_pose"] = &function_19b1ef83;
}

// Namespace display_transition/display_transition
// Params 2, eflags: 0x0
// Checksum 0x3e3b3fab, Offset: 0x16c8
// Size: 0x34
function function_f3ae8392(transition_type, transition_index) {
    self luinotifyevent(transition_type, 1, transition_index);
}

// Namespace display_transition/display_transition
// Params 0, eflags: 0x0
// Checksum 0x6b1c0285, Offset: 0x1708
// Size: 0x24
function function_c31ae8dc() {
    self luinotifyevent(#"clear_transition");
}

// Namespace display_transition/display_transition
// Params 0, eflags: 0x0
// Checksum 0xaff681b2, Offset: 0x1738
// Size: 0x5c
function function_40c85426() {
    if (isdefined(self.pers[#"totalmatchbonus"])) {
        self luinotifyevent(#"hash_9dfc8d44ea4547e", 1, self.pers[#"totalmatchbonus"]);
    }
}

// Namespace display_transition/display_transition
// Params 4, eflags: 0x0
// Checksum 0xc171a4df, Offset: 0x17a0
// Size: 0x8e
function display_transition(transition, transition_index, outcome, lui_event) {
    level thread globallogic::sndsetmatchsnapshot(2);
    player::function_b8a53d1a(&function_f3ae8392, lui_event, transition_index + 1);
    [[ level.var_812c2d64[transition.type] ]](transition, outcome);
}

// Namespace display_transition/display_transition
// Params 3, eflags: 0x0
// Checksum 0x8bfa1549, Offset: 0x1838
// Size: 0x62
function shutdown_transition(transition, outcome, next_transition) {
    if (isdefined(level.var_f9a10aff[transition.type])) {
        level thread [[ level.var_f9a10aff[transition.type] ]](transition, outcome, next_transition);
    }
}

// Namespace display_transition/display_transition
// Params 0, eflags: 0x0
// Checksum 0x17d14b28, Offset: 0x18a8
// Size: 0x4c
function clear_transition() {
    player::function_15b6b25d(&function_c31ae8dc);
    array::run_all(level.players, &hud_message::hide_outcome);
}

// Namespace display_transition/display_transition
// Params 2, eflags: 0x0
// Checksum 0x2eef768d, Offset: 0x1900
// Size: 0xf8
function function_b26731cd(transition, outcome) {
    if (isdefined(transition.disable) && transition.disable) {
        return true;
    }
    if (isdefined(transition.var_bf1cd724) && transition.var_bf1cd724) {
        if (util::waslastround() || util::isoneround()) {
            return true;
        }
    }
    if (transition.type == "team_pose") {
        if (outcome.team == #"free") {
            return true;
        }
        if (!isdefined(struct::get("team_pose_cam", "targetname"))) {
            return true;
        }
    }
    return false;
}

// Namespace display_transition/display_transition
// Params 3, eflags: 0x0
// Checksum 0x501387ed, Offset: 0x1a00
// Size: 0x174
function function_772f7d10(transitions, outcome, lui_event) {
    foreach (index, transition in transitions) {
        if (function_b26731cd(transition, outcome)) {
            continue;
        }
        level notify(#"display_transition", index);
        display_transition(transition, index, outcome, lui_event);
        if ((isdefined(transition.time) ? transition.time : 0) != 0) {
            round_end_wait(float(transition.time) / 1000);
        }
        shutdown_transition(transition, outcome, transitions[index + 1]);
    }
    clear_transition();
}

// Namespace display_transition/display_transition
// Params 1, eflags: 0x0
// Checksum 0x4a345939, Offset: 0x1b80
// Size: 0x3c
function function_da749172(outcome) {
    function_772f7d10(level.var_b77eff6f.finaldisplaytransition, outcome, #"match_transition");
}

// Namespace display_transition/display_transition
// Params 1, eflags: 0x0
// Checksum 0xad7d902d, Offset: 0x1bc8
// Size: 0xbc
function function_924e59d1(outcome) {
    if (isdefined(level.var_b77eff6f.var_aa2ffd3c) && level.var_b77eff6f.var_aa2ffd3c) {
        if (util::waslastround() || util::isoneround()) {
            return;
        }
    }
    transitions = level.var_b77eff6f.rounddisplaytransition;
    if (!isdefined(transitions)) {
        return;
    }
    function_772f7d10(transitions, outcome, #"round_transition");
}

// Namespace display_transition/display_transition
// Params 1, eflags: 0x0
// Checksum 0x14acd016, Offset: 0x1c90
// Size: 0x2a
function round_end_wait(time) {
    if (time <= 0) {
        return;
    }
    wait time * level.var_74db4b88;
}

// Namespace display_transition/display_transition
// Params 1, eflags: 0x0
// Checksum 0xb1e12e5c, Offset: 0x1cc8
// Size: 0xd8
function function_bf8ff9dd(var_e8709981) {
    assert(isdefined(level.roundenddelay[var_e8709981]));
    delay = level.roundenddelay[var_e8709981] * level.var_74db4b88;
    if (delay) {
        return;
    }
    var_42afe552 = delay / 2;
    if (var_42afe552 > 0) {
        wait var_42afe552;
        var_42afe552 = delay / 2;
    } else {
        var_42afe552 = delay / 2 + var_42afe552;
    }
    level notify(#"give_match_bonus");
    if (var_42afe552 > 0) {
        wait var_42afe552;
    }
}

