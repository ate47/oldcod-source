#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\exploder_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\trigger_shared;
#using scripts\core_common\util_shared;
#using scripts\zm\zm_escape_travel;
#using scripts\zm_common\zm_audio;
#using scripts\zm_common\zm_characters;
#using scripts\zm_common\zm_customgame;
#using scripts\zm_common\zm_devgui;
#using scripts\zm_common\zm_powerups;
#using scripts\zm_common\zm_spawner;
#using scripts\zm_common\zm_unitrigger;
#using scripts\zm_common\zm_utility;
#using scripts\zm_common\zm_vo;
#using scripts\zm_common\zm_zonemgr;

#namespace zm_escape_vo_hooks;

// Namespace zm_escape_vo_hooks/zm_escape_vo_hooks
// Params 0, eflags: 0x2
// Checksum 0xb601d81f, Offset: 0x2f0
// Size: 0x44
function autoexec __init__system__() {
    system::register(#"zm_escape_vo_hooks", &__init__, &__main__, undefined);
}

// Namespace zm_escape_vo_hooks/zm_escape_vo_hooks
// Params 0, eflags: 0x0
// Checksum 0x4dc8f63c, Offset: 0x340
// Size: 0x54
function __init__() {
    callback::on_connect(&on_player_connect);
    level init_flags();
    level thread init_announcer();
}

// Namespace zm_escape_vo_hooks/zm_escape_vo_hooks
// Params 0, eflags: 0x0
// Checksum 0x98565fc6, Offset: 0x3a0
// Size: 0x114
function __main__() {
    level flag::wait_till(#"all_players_spawned");
    level thread function_4ac0f530();
    level thread function_ebc33316();
    level thread function_24b23d35();
    level thread function_2ce55b90();
    level thread function_f085677c();
    level thread function_858254b8();
    level thread function_142c4848();
    level thread function_3c2267e8();
    level thread function_3283c6c2();
    level thread function_eeee7e9f();
}

// Namespace zm_escape_vo_hooks/zm_escape_vo_hooks
// Params 0, eflags: 0x0
// Checksum 0x50132669, Offset: 0x4c0
// Size: 0x84
function init_flags() {
    level flag::init(#"hash_20ac26ecda866c45");
    level flag::init(#"hash_59cfca3c898df56d");
    level flag::init(#"hash_779398f97110e7b8");
    level flag::init(#"hash_732657441f7793dc");
}

// Namespace zm_escape_vo_hooks/zm_escape_vo_hooks
// Params 0, eflags: 0x0
// Checksum 0xc51dd312, Offset: 0x550
// Size: 0x2c
function init_announcer() {
    zm_audio::sndannouncervoxadd(#"catwalk_warden_0_0", "catwalk_warden_0_0");
}

// Namespace zm_escape_vo_hooks/zm_escape_vo_hooks
// Params 0, eflags: 0x0
// Checksum 0x317fef41, Offset: 0x588
// Size: 0x6c
function on_player_connect() {
    self flag::init(#"hash_1308e79a11093c1e");
    self thread function_733cfb2e();
    self thread function_1d4421b6();
    self thread function_3283c6c2();
}

// Namespace zm_escape_vo_hooks/zm_escape_vo_hooks
// Params 0, eflags: 0x0
// Checksum 0x8b1724a8, Offset: 0x600
// Size: 0x94
function function_3283c6c2() {
    var_140ee320 = getent("t_v_o_exam", "targetname");
    s_info = var_140ee320 waittill(#"trigger");
    e_player = s_info.activator;
    e_player thread zm_audio::create_and_play_dialog("exam_room", "exam_room_react", undefined, 1);
}

// Namespace zm_escape_vo_hooks/zm_escape_vo_hooks
// Params 0, eflags: 0x0
// Checksum 0x81388090, Offset: 0x6a0
// Size: 0x94
function function_eeee7e9f() {
    var_140ee320 = getent("t_v_o_docks", "targetname");
    s_info = var_140ee320 waittill(#"trigger");
    e_player = s_info.activator;
    e_player thread zm_audio::create_and_play_dialog("exam_room", "exam_room_react", undefined, 1);
}

// Namespace zm_escape_vo_hooks/zm_escape_vo_hooks
// Params 0, eflags: 0x0
// Checksum 0x1583338c, Offset: 0x740
// Size: 0x60
function function_1d4421b6() {
    self endon(#"disconnect");
    while (true) {
        self waittill(#"hash_1413599b710f10bd");
        self thread zm_audio::create_and_play_dialog("brutus", "helm_off", undefined, 1);
    }
}

// Namespace zm_escape_vo_hooks/zm_escape_vo_hooks
// Params 0, eflags: 0x4
// Checksum 0xe51ed6c3, Offset: 0x7a8
// Size: 0xc4
function private function_142c4848() {
    level endon(#"end_game");
    s_escape_plan_vo_react = struct::get("s_map_react_vo_rich_lab");
    s_escape_plan_vo_react.s_unitrigger_stub = s_escape_plan_vo_react zm_unitrigger::create(undefined, 64, &function_ea0ab0ee);
    if (level flag::exists(#"hash_40e9ad323fe8402a")) {
        level flag::wait_till(#"hash_40e9ad323fe8402a");
        zm_unitrigger::unregister_unitrigger(s_escape_plan_vo_react.s_unitrigger_stub);
    }
}

// Namespace zm_escape_vo_hooks/zm_escape_vo_hooks
// Params 0, eflags: 0x0
// Checksum 0xea3cd7e6, Offset: 0x878
// Size: 0x88
function function_ea0ab0ee() {
    level endon(#"hash_40e9ad323fe8402a");
    while (true) {
        s_result = self waittill(#"trigger");
        e_player = s_result.activator;
        e_player thread zm_audio::create_and_play_dialog("map", "react", undefined, 1);
    }
}

// Namespace zm_escape_vo_hooks/zm_escape_vo_hooks
// Params 0, eflags: 0x4
// Checksum 0x7d8c28ca, Offset: 0x908
// Size: 0x178
function private function_4ac0f530() {
    var_3a635f6c = struct::get_array("s_pods_react");
    foreach (s_pod in var_3a635f6c) {
        s_pod.s_unitrigger_stub = s_pod zm_unitrigger::create(&function_315f2a5a, 96, &function_296362e2);
    }
    if (level flag::exists(#"hash_40e9ad323fe8402a")) {
        level flag::wait_till(#"hash_40e9ad323fe8402a");
        foreach (s_pod in var_3a635f6c) {
            zm_unitrigger::unregister_unitrigger(s_pod.s_unitrigger_stub);
        }
    }
}

// Namespace zm_escape_vo_hooks/zm_escape_vo_hooks
// Params 1, eflags: 0x0
// Checksum 0x3762a568, Offset: 0xa88
// Size: 0x5a
function function_315f2a5a(player) {
    if (!(isdefined(player.var_94b48394) && player.var_94b48394)) {
        self sethintstring(#"");
        return 1;
    }
    return 0;
}

// Namespace zm_escape_vo_hooks/zm_escape_vo_hooks
// Params 0, eflags: 0x0
// Checksum 0x869d6064, Offset: 0xaf0
// Size: 0x112
function function_296362e2() {
    while (true) {
        s_result = self waittill(#"trigger");
        if (isplayer(s_result.activator) && isalive(s_result.activator)) {
            s_result.activator thread zm_audio::create_and_play_dialog("vpods", "react", undefined, 1);
            s_result.activator.var_94b48394 = 1;
            if (isdefined(self.stub.related_parent.script_string) && self.stub.related_parent.script_string == "stuh") {
                s_result.activator.var_c6724157 = 1;
            }
        }
    }
}

// Namespace zm_escape_vo_hooks/zm_escape_vo_hooks
// Params 0, eflags: 0x0
// Checksum 0x8bb98d79, Offset: 0xc10
// Size: 0x110
function function_733cfb2e() {
    level endon(#"hash_59cfca3c898df56d", #"hash_732657441f7793dc", #"end_game");
    while (!level flag::get(#"hash_59cfca3c898df56d") || !level flag::get(#"hash_732657441f7793dc")) {
        t_cell_block_vista_vo = trigger::wait_till("t_cell_block_vista_vo", "targetname");
        t_cell_block_vista_vo.who thread zm_audio::create_and_play_dialog("vista", "react", undefined, 1);
        level flag::set(#"hash_59cfca3c898df56d");
    }
}

// Namespace zm_escape_vo_hooks/zm_escape_vo_hooks
// Params 0, eflags: 0x4
// Checksum 0x14304284, Offset: 0xd28
// Size: 0xa4
function private function_ebc33316() {
    var_34ad693e = getent("power_house_power_switch", "script_noteworthy");
    var_34ad693e endon(#"death");
    s_info = var_34ad693e waittill(#"trigger");
    e_player = s_info.activator;
    e_player thread zm_audio::create_and_play_dialog("powerplant", "turn_on");
}

// Namespace zm_escape_vo_hooks/zm_escape_vo_hooks
// Params 0, eflags: 0x0
// Checksum 0x9dbc46a2, Offset: 0xdd8
// Size: 0x6c
function function_44b23be2() {
    self endon(#"death");
    s_info = self waittill(#"trigger");
    e_player = s_info.activator;
    e_player thread zm_audio::create_and_play_dialog("build_64", "turn_on");
}

// Namespace zm_escape_vo_hooks/zm_escape_vo_hooks
// Params 0, eflags: 0x4
// Checksum 0xe164c3d9, Offset: 0xe50
// Size: 0xa4
function private function_24b23d35() {
    s_catwalk_lava_exp = struct::get("s_catwalk_lava_exp");
    s_catwalk_lava_exp.var_936b57e0 = s_catwalk_lava_exp zm_unitrigger::create(&function_281f79c6, s_catwalk_lava_exp.radius, &function_fcb27b36, 0, 0);
    level flag::wait_till(#"hash_779398f97110e7b8");
    zm_unitrigger::unregister_unitrigger(s_catwalk_lava_exp.var_936b57e0);
}

// Namespace zm_escape_vo_hooks/zm_escape_vo_hooks
// Params 1, eflags: 0x0
// Checksum 0xf1fd3c0, Offset: 0xf00
// Size: 0x2c
function function_281f79c6(e_player) {
    return !level flag::get(#"hash_779398f97110e7b8");
}

// Namespace zm_escape_vo_hooks/zm_escape_vo_hooks
// Params 0, eflags: 0x0
// Checksum 0xb3743df0, Offset: 0xf38
// Size: 0x21c
function function_fcb27b36() {
    self endon(#"death");
    s_info = self waittill(#"trigger");
    e_player = s_info.activator;
    exploder::exploder("fxexplo_catwalk_lava_burst");
    level clientfield::set("" + #"hash_24deaa9795e06d41", 1);
    wait 5;
    if (!e_player zm_characters::is_character(array(#"hash_59f3598ad57dadd8", #"hash_2bcebdf1bef33311"))) {
        e_player zm_vo::function_59635cc4("catwalk_warden_1");
        foreach (player in level.activeplayers) {
            if (player zm_characters::is_character(array(#"hash_59f3598ad57dadd8", #"hash_2bcebdf1bef33311")) && distancesquared(e_player.origin, player.origin) < 1000000) {
                player zm_vo::function_59635cc4("catwalk_warden_1");
            }
        }
    }
    level flag::set(#"hash_779398f97110e7b8");
}

// Namespace zm_escape_vo_hooks/zm_escape_vo_hooks
// Params 0, eflags: 0x4
// Checksum 0x19492399, Offset: 0x1160
// Size: 0xf4
function private function_2ce55b90() {
    var_6b228b7d = getent("t_reached_cellbock_vo", "targetname");
    var_6b228b7d endon(#"death");
    while (true) {
        s_info = var_6b228b7d waittill(#"trigger");
        e_player = s_info.activator;
        if (isplayer(e_player)) {
            break;
        }
    }
    e_player thread zm_audio::create_and_play_dialog("cell_block", "react", undefined, 1);
    level flag::set(#"hash_732657441f7793dc");
}

// Namespace zm_escape_vo_hooks/zm_escape_vo_hooks
// Params 0, eflags: 0x0
// Checksum 0xc8c6fabc, Offset: 0x1260
// Size: 0x134
function function_3c2267e8() {
    var_17c07dbb = getent("t_infir_full_react", "targetname");
    var_17c07dbb endon(#"death");
    while (true) {
        s_info = var_17c07dbb waittill(#"trigger");
        e_player = s_info.activator;
        if (isplayer(e_player) && e_player flag::get(#"hash_30ae3926b2d211db")) {
            break;
        }
    }
    if (!level flag::get(#"hash_1a367a4a0dfb0471")) {
        e_player zm_audio::create_and_play_dialog("bathtub", "react", undefined, 1);
        var_17c07dbb delete();
    }
}

// Namespace zm_escape_vo_hooks/zm_escape_vo_hooks
// Params 0, eflags: 0x4
// Checksum 0x4877cefc, Offset: 0x13a0
// Size: 0x54
function private function_f085677c() {
    s_escape_plan_vo_react = struct::get("s_escape_plan_vo_react");
    s_escape_plan_vo_react zm_unitrigger::create(undefined, 64, &function_91f58a9a, 1);
}

// Namespace zm_escape_vo_hooks/zm_escape_vo_hooks
// Params 0, eflags: 0x0
// Checksum 0x1043faaf, Offset: 0x1400
// Size: 0x80
function function_91f58a9a() {
    self endon(#"death");
    while (true) {
        s_info = self waittill(#"trigger");
        e_player = s_info.activator;
        e_player thread zm_audio::create_and_play_dialog("escape_plan", "react", undefined, 1);
    }
}

// Namespace zm_escape_vo_hooks/zm_escape_vo_hooks
// Params 0, eflags: 0x4
// Checksum 0xd83922f6, Offset: 0x1488
// Size: 0x13e
function private function_858254b8() {
    for (var_3474a371 = 0; var_3474a371 < 3; var_3474a371++) {
        while (true) {
            level waittill(#"gondola_moving");
            var_1ec914fc = 1;
            foreach (player in getplayers()) {
                if (player zm_escape_travel::function_250c012e()) {
                    var_1ec914fc = 0;
                    break;
                }
            }
            if (var_1ec914fc == 0) {
                continue;
            }
            break;
        }
        if (isdefined(level.var_224d0ed4)) {
            level.var_224d0ed4 thread zm_audio::create_and_play_dialog("gondola", "call");
        }
    }
}

// Namespace zm_escape_vo_hooks/zm_escape_vo_hooks
// Params 0, eflags: 0x0
// Checksum 0xe8a1a379, Offset: 0x15d0
// Size: 0xcc
function function_e6273db3() {
    self endon(#"death");
    self endon(#"disconnect");
    wait 1;
    if (!isdefined(self)) {
        return;
    }
    if (!self flag::get(#"hash_1308e79a11093c1e")) {
        self flag::set(#"hash_1308e79a11093c1e");
        self thread zm_audio::create_and_play_dialog("hellhole", "enter_first");
        return;
    }
    self thread zm_audio::create_and_play_dialog("hellhole", "enter");
}

// Namespace zm_escape_vo_hooks/zm_escape_vo_hooks
// Params 0, eflags: 0x0
// Checksum 0x877c4d90, Offset: 0x16a8
// Size: 0xf4
function function_65b3a0a() {
    level endon(#"hash_dd62a8822ea4a38", #"end_game");
    level waittill(#"hash_231c2abba527e2e4");
    a_e_players = zm_zonemgr::get_players_in_zone("zone_citadel_stairs", 1);
    if (isarray(a_e_players) && a_e_players.size > 0) {
        e_player = array::random(a_e_players);
        if (isalive(e_player)) {
            e_player thread zm_audio::create_and_play_dialog("elev_crash", "react");
        }
    }
}

// Namespace zm_escape_vo_hooks/zm_escape_vo_hooks
// Params 0, eflags: 0x0
// Checksum 0xe3ed6094, Offset: 0x17a8
// Size: 0x2a
function function_485a7ec5() {
    e_player = array::random(level.activeplayers);
    return e_player;
}

