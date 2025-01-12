#using scripts\core_common\ai\zombie_utility;
#using scripts\core_common\array_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\fx_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\struct;
#using scripts\zm_common\trials\zm_trial_disable_buys;
#using scripts\zm_common\zm_audio;
#using scripts\zm_common\zm_customgame;
#using scripts\zm_common\zm_lockdown_util;
#using scripts\zm_common\zm_pack_a_punch;
#using scripts\zm_common\zm_pack_a_punch_util;
#using scripts\zm_common\zm_unitrigger;
#using scripts\zm_common\zm_utility;

#namespace zodt8_pap_quest;

// Namespace zodt8_pap_quest/zm_zodt8_pap_quest
// Params 0, eflags: 0x0
// Checksum 0xe39bdfd4, Offset: 0x298
// Size: 0x3e8
function init() {
    clientfield::register("zbarrier", "pap_chunk_small_rune", 1, getminbitcountfornum(16), "int");
    clientfield::register("zbarrier", "pap_chunk_big_rune", 1, getminbitcountfornum(5), "int");
    clientfield::register("zbarrier", "pap_machine_rune", 1, getminbitcountfornum(5), "int");
    level flag::init("pap_quest_complete");
    if (zm_custom::function_5638f689(#"zmpapenabled") == 0) {
        var_14cd4145 = [];
        var_5c8370e6 = array("stairs_pap_location", "poop_deck_pap_location", "engine_room_pap_location", "cargo_pap_location");
        foreach (var_17a264bf in var_5c8370e6) {
            var_14cd4145 = arraycombine(var_14cd4145, getentarray(var_17a264bf, "prefabname"), 0, 0);
        }
        foreach (e_chunk in var_14cd4145) {
            e_chunk hide();
        }
        return;
    }
    level.s_pap_quest = struct::spawn();
    level.s_pap_quest.a_s_locations = struct::get_array("pap_quest_interact");
    level.s_pap_quest.var_35fadadb = level.s_pap_quest.a_s_locations.size;
    level.s_pap_quest.var_966c6a3f = 0;
    foreach (s_loc in level.s_pap_quest.a_s_locations) {
        level thread function_e61e54c8(s_loc);
    }
    level.pack_a_punch.custom_power_think = &function_ed66fefd;
    if (!zm_utility::is_standard()) {
        level thread function_ba5b512d();
    }
    if (zm_custom::function_5638f689(#"zmpapenabled") == 2) {
        level thread function_bf2e9c20();
    }
    /#
    #/
}

// Namespace zodt8_pap_quest/zm_zodt8_pap_quest
// Params 0, eflags: 0x0
// Checksum 0x45608255, Offset: 0x688
// Size: 0x154
function function_bf2e9c20() {
    level waittill(#"all_players_spawned");
    array::thread_all(level.s_pap_quest.a_s_locations, &function_86c03c92, 1);
    if (!zm_utility::is_standard()) {
        level.s_pap_quest.var_d6c419fd = randomintrange(0, level.s_pap_quest.a_s_locations.size);
    }
    level flag::wait_till("start_zombie_round_logic");
    foreach (s_loc in level.s_pap_quest.a_s_locations) {
        s_loc.unitrigger_stub thread function_7e9ee9fa();
    }
    waitframe(1);
    function_a239b8a1();
}

// Namespace zodt8_pap_quest/zm_zodt8_pap_quest
// Params 1, eflags: 0x0
// Checksum 0x40c182f4, Offset: 0x7e8
// Size: 0x2c4
function function_e61e54c8(s_loc) {
    s_loc.unitrigger_stub = spawnstruct();
    s_loc.unitrigger_stub.origin = s_loc.origin;
    s_loc.unitrigger_stub.angles = s_loc.angles;
    s_loc.unitrigger_stub.script_unitrigger_type = "unitrigger_box_use";
    s_loc.unitrigger_stub.cursor_hint = "HINT_NOICON";
    s_loc.unitrigger_stub.script_width = 96;
    s_loc.unitrigger_stub.script_height = 96;
    s_loc.unitrigger_stub.script_length = 96;
    s_loc.unitrigger_stub.require_look_at = 0;
    s_loc.unitrigger_stub.target = s_loc.target;
    s_loc.unitrigger_stub.b_used = 0;
    s_loc.unitrigger_stub.prompt_and_visibility_func = &function_92d37052;
    var_e30bcaa1 = getentarray(s_loc.prefabname, "prefabname");
    foreach (var_eb70661e in var_e30bcaa1) {
        if (var_eb70661e iszbarrier()) {
            s_loc.unitrigger_stub.pap_machine = var_eb70661e;
            continue;
        }
        s_loc.unitrigger_stub.var_7ad20d64 = var_eb70661e;
    }
    s_loc.unitrigger_stub.var_7ad20d64 notsolid();
    hidemiscmodels(s_loc.prefabname);
    while (!level flag::exists("power_on")) {
        waitframe(1);
    }
    level flag::wait_till("power_on");
    s_loc thread function_86c03c92();
}

// Namespace zodt8_pap_quest/zm_zodt8_pap_quest
// Params 1, eflags: 0x0
// Checksum 0xa2bb26f4, Offset: 0xab8
// Size: 0x1ec
function function_86c03c92(var_7946b437 = 0) {
    if (isdefined(self.b_revealed) && self.b_revealed) {
        return;
    }
    self.unitrigger_stub.pap_machine clientfield::set("pap_chunk_small_rune", 1);
    if (var_7946b437) {
        level flag::wait_till("start_zombie_round_logic");
    } else if (!zm_utility::is_standard()) {
        level waittill(self.prefabname);
    }
    self.b_revealed = 1;
    self.unitrigger_stub.var_7ad20d64 solid();
    showmiscmodels(self.prefabname);
    self.unitrigger_stub.pap_machine zm_pack_a_punch::set_state_initial();
    if (self.prefabname == "poop_deck_pap_location") {
        getent("poop_deck_PAP_box", "targetname") delete();
    }
    if (!var_7946b437) {
        self.unitrigger_stub.pap_machine pap_chunk_big_rune_on();
    }
    zm_unitrigger::register_static_unitrigger(self.unitrigger_stub, &function_cdac598a);
    zm_unitrigger::function_9946242d(self.unitrigger_stub, 1);
    self thread function_d5554776();
}

// Namespace zodt8_pap_quest/zm_zodt8_pap_quest
// Params 0, eflags: 0x0
// Checksum 0x129a253e, Offset: 0xcb0
// Size: 0xc8
function function_d5554776() {
    while (true) {
        level waittill(#"pap_moved");
        if (level.s_pap_quest.a_s_locations[level.s_pap_quest.var_d6c419fd] == self) {
            zm_unitrigger::unregister_unitrigger(self.unitrigger_stub);
            continue;
        }
        if (!(isdefined(self.unitrigger_stub.registered) && self.unitrigger_stub.registered)) {
            zm_unitrigger::register_static_unitrigger(self.unitrigger_stub, &function_cdac598a);
        }
    }
}

// Namespace zodt8_pap_quest/zm_zodt8_pap_quest
// Params 0, eflags: 0x0
// Checksum 0x2ff7101, Offset: 0xd80
// Size: 0xc8
function function_cdac598a() {
    while (!(isdefined(self.stub.b_used) && self.stub.b_used)) {
        waitresult = self waittill(#"trigger");
        player = waitresult.activator;
        if (player zm_utility::in_revive_trigger()) {
            continue;
        }
        if (player zm_utility::is_drinking()) {
            continue;
        }
        if (!zm_utility::is_player_valid(player)) {
            continue;
        }
        self.stub thread function_7e9ee9fa(player);
    }
}

// Namespace zodt8_pap_quest/zm_zodt8_pap_quest
// Params 1, eflags: 0x0
// Checksum 0xcc44adb1, Offset: 0xe50
// Size: 0x164
function function_7e9ee9fa(player) {
    level.s_pap_quest.var_966c6a3f++;
    self.b_used = 1;
    self.pap_machine.var_8c37118f = 1;
    if (isdefined(player)) {
        player playrumbleonentity("zm_castle_interact_rumble");
    }
    for (i = 0; i < level.s_pap_quest.a_s_locations.size; i++) {
        if (!zm_utility::is_standard() && level.s_pap_quest.a_s_locations[i].unitrigger_stub == self) {
            level.s_pap_quest.var_d6c419fd = i;
        }
    }
    self.pap_machine function_433b63bc();
    level function_d9f9960c();
    if (!level flag::get("pap_quest_complete")) {
        player thread zm_audio::create_and_play_dialog("altar", "activate_generic");
    }
}

// Namespace zodt8_pap_quest/zm_zodt8_pap_quest
// Params 0, eflags: 0x0
// Checksum 0xcf32b86, Offset: 0xfc0
// Size: 0x3c
function function_433b63bc() {
    self clientfield::set("pap_chunk_big_rune", 1);
    wait 1.8;
    function_f5639e30();
}

// Namespace zodt8_pap_quest/zm_zodt8_pap_quest
// Params 0, eflags: 0x0
// Checksum 0x31858d11, Offset: 0x1008
// Size: 0xa0
function function_78f8a66d() {
    foreach (s_loc in level.s_pap_quest.a_s_locations) {
        s_loc.unitrigger_stub.pap_machine clientfield::set("pap_chunk_small_rune", 1);
    }
}

// Namespace zodt8_pap_quest/zm_zodt8_pap_quest
// Params 0, eflags: 0x0
// Checksum 0x409515b4, Offset: 0x10b0
// Size: 0x4c
function function_d9f9960c() {
    wait 1;
    if (level.s_pap_quest.var_966c6a3f >= level.s_pap_quest.var_35fadadb) {
        level flag::set("pap_quest_complete");
    }
}

// Namespace zodt8_pap_quest/zm_zodt8_pap_quest
// Params 1, eflags: 0x0
// Checksum 0xfc285ee5, Offset: 0x1108
// Size: 0x410
function function_92d37052(e_player) {
    if (!level flag::get("pap_quest_complete")) {
        var_a3338832 = self function_df462a02(e_player);
        if (isdefined(self.hint_string)) {
            self sethintstring(self.hint_string);
        }
        return var_a3338832;
    }
    var_bfbe63d4 = !isdefined(level.s_pap_quest.var_a58aed48);
    var_e7c9f931 = level.s_pap_quest.a_s_locations[level.s_pap_quest.var_d6c419fd].unitrigger_stub === self.stub;
    var_10b8113f = isdefined(level.s_pap_quest.var_a58aed48) && level.s_pap_quest.var_a58aed48.unitrigger_stub === self.stub;
    if (!(isdefined(level.var_543d4469) && level.var_543d4469) && var_e7c9f931 || isdefined(level.var_e5a9a6c4) && level.var_e5a9a6c4 && var_bfbe63d4 || isdefined(level.var_e5a9a6c4) && level.var_e5a9a6c4 && var_e7c9f931 || isdefined(level.var_d5c6e5d0) && level.var_d5c6e5d0 && var_10b8113f || isdefined(level.var_52e58148) && level.var_52e58148 || level flag::exists(#"hash_598d4e6af1cf4c39") && level flag::get(#"hash_598d4e6af1cf4c39") || zm_custom::function_5638f689(#"zmpapenabled") == 2) {
        return 0;
    }
    if (isdefined(level.var_543d4469) && level.var_543d4469) {
        self sethintstring(#"hash_73bbee9df5d3c2b1");
    } else {
        switch (level.s_pap_quest.a_s_locations[level.s_pap_quest.var_d6c419fd].prefabname) {
        case #"stairs_pap_location":
            self sethintstring(#"hash_15783325b3eeefd5");
            break;
        case #"poop_deck_pap_location":
            self sethintstring(#"hash_250613266b9a4223");
            break;
        case #"engine_room_pap_location":
            self sethintstring(#"hash_4c5f8e23d8258199");
            break;
        case #"cargo_pap_location":
            self sethintstring(#"hash_1deb745365a6cfdd");
            break;
        default:
            self sethintstring(#"");
            break;
        }
    }
    return 1;
}

// Namespace zodt8_pap_quest/zm_zodt8_pap_quest
// Params 1, eflags: 0x0
// Checksum 0x8e6382cc, Offset: 0x1520
// Size: 0x106
function function_df462a02(e_player) {
    b_result = 0;
    if (!(isdefined(e_player zombie_utility::is_player_valid(e_player)) && e_player zombie_utility::is_player_valid(e_player))) {
        self.hint_string = #"";
    } else if (isdefined(self.stub.b_used) && self.stub.b_used) {
        self.hint_string = #"";
    } else if (level flag::get("pap_quest_complete")) {
        self.hint_string = #"";
    } else {
        self.hint_string = #"hash_15494c7927282ad6";
        b_result = 1;
    }
    return b_result;
}

// Namespace zodt8_pap_quest/zm_zodt8_pap_quest
// Params 1, eflags: 0x0
// Checksum 0x6143e1bd, Offset: 0x1630
// Size: 0xbe
function function_ed66fefd(is_powered) {
    self zm_pack_a_punch::set_state_hidden();
    if (!isdefined(level.var_3e92a909)) {
        level.var_3e92a909 = [];
    } else if (!isarray(level.var_3e92a909)) {
        level.var_3e92a909 = array(level.var_3e92a909);
    }
    level.var_3e92a909[self.prefabname] = self;
    self.var_c03c8b32 = 1;
    self.var_de6cbdbb = 1;
}

// Namespace zodt8_pap_quest/zm_zodt8_pap_quest
// Params 0, eflags: 0x0
// Checksum 0x6f8c3395, Offset: 0x16f8
// Size: 0xf0
function function_ba5b512d() {
    if (zm_custom::function_5638f689(#"zmpapenabled") == 2) {
        return;
    }
    level flag::wait_till("pap_quest_complete");
    function_5e2ad5f4(1);
    level.var_9b1767c1++;
    /#
        iprintlnbold("<dev string:x30>");
    #/
    while (true) {
        level waittill(#"end_of_round");
        if (level.round_number >= level.var_9b1767c1 && !zm_utility::is_standard()) {
            function_5e2ad5f4();
        }
    }
}

// Namespace zodt8_pap_quest/zm_zodt8_pap_quest
// Params 1, eflags: 0x0
// Checksum 0x2b7bae2b, Offset: 0x17f0
// Size: 0x2a6
function function_5e2ad5f4(b_initial = 0) {
    if (!b_initial) {
        function_2187d93b();
        var_17596ada = level.s_pap_quest.var_d6c419fd;
        level.s_pap_quest.var_a58aed48 = level.s_pap_quest.a_s_locations[var_17596ada];
        if (!isdefined(level.var_9898fc7d)) {
            level.var_9898fc7d = [];
        }
        if (!level.var_9898fc7d.size) {
            for (i = 0; i < level.s_pap_quest.a_s_locations.size; i++) {
                level.var_9898fc7d[i] = i;
            }
            while (level.var_9898fc7d[0] == var_17596ada) {
                level.var_9898fc7d = array::randomize(level.var_9898fc7d);
            }
        }
        if (!level flag::get(#"hash_452df3df817c57f9") || !isdefined(level.s_pap_quest.var_6aee16f4) || level flag::get(#"hash_598d4e6af1cf4c39")) {
            level.s_pap_quest.var_d6c419fd = level.var_9898fc7d[0];
            level.var_9898fc7d = array::exclude(level.var_9898fc7d, level.var_9898fc7d[0]);
        } else {
            level.s_pap_quest.var_d6c419fd = level.s_pap_quest.var_6aee16f4;
            level.var_9898fc7d = array::exclude(level.var_9898fc7d, level.s_pap_quest.var_6aee16f4);
        }
        level.var_543d4469 = 1;
    } else {
        function_78f8a66d();
    }
    function_29c316c0();
    level.var_543d4469 = 0;
    level.var_9b1767c1 = level.round_number + randomintrange(2, 4);
}

// Namespace zodt8_pap_quest/zm_zodt8_pap_quest
// Params 0, eflags: 0x0
// Checksum 0x42c5379a, Offset: 0x1aa0
// Size: 0x22a
function function_2187d93b() {
    if (!isdefined(level.pap_machine)) {
        return;
    }
    if (isdefined(level.pap_machine.unitrigger_stub.var_367a0246)) {
        level.pap_machine.unitrigger_stub thread zm_lockdown_util::function_403f1f1b();
    }
    level.pap_machine flag::wait_till("pap_waiting_for_user");
    function_78f8a66d();
    level.var_d5c6e5d0 = 1;
    playrumbleonposition("zm_castle_pap_tp", level.pap_machine.origin);
    playsoundatposition(#"hash_5944b4f78bf382e8", level.pap_machine.origin);
    var_a6956ec4 = level.s_pap_quest.var_a6956ec4;
    if (!isdefined(var_a6956ec4)) {
        var_a6956ec4 = level.s_pap_quest.a_s_locations[level.s_pap_quest.var_d6c419fd];
    }
    if (isdefined(var_a6956ec4)) {
        hidemiscmodels(var_a6956ec4.prefabname);
    }
    level.pap_machine clientfield::set("pap_machine_rune", 1);
    level.pap_machine thread zm_pack_a_punch::function_e95839cd(0, "leaving", "leave_anim_done");
    level.pap_machine waittill(#"leave_anim_done");
    level.var_d5c6e5d0 = 0;
    level.pap_machine zm_pack_a_punch::set_state_initial();
    if (isdefined(var_a6956ec4)) {
        showmiscmodels(var_a6956ec4.prefabname);
    }
    level.var_52e58148 = 1;
}

// Namespace zodt8_pap_quest/zm_zodt8_pap_quest
// Params 0, eflags: 0x0
// Checksum 0xbe726b88, Offset: 0x1cd8
// Size: 0x1b0
function function_29c316c0() {
    level.s_pap_quest.var_a6956ec4 = level.s_pap_quest.a_s_locations[level.s_pap_quest.var_d6c419fd];
    s_new_loc = level.s_pap_quest.var_a6956ec4;
    level.pap_machine = s_new_loc.unitrigger_stub.pap_machine;
    if (!isdefined(level.pap_machine)) {
        return;
    }
    level.var_52e58148 = 0;
    level.var_e5a9a6c4 = 1;
    level.pap_machine clientfield::set("pap_machine_rune", 1);
    hidemiscmodels(s_new_loc.prefabname);
    level.pap_machine thread zm_pack_a_punch::function_e95839cd(1, "arriving", "arrive_anim_done");
    level.pap_machine waittill(#"arrive_anim_done");
    level.var_e5a9a6c4 = 0;
    showmiscmodels(s_new_loc.prefabname);
    level.pap_machine pap_machine_rune_on();
    level.pap_machine thread function_5f17a55c();
    level thread function_f5639e30();
    level notify(#"pap_moved");
}

// Namespace zodt8_pap_quest/zm_zodt8_pap_quest
// Params 0, eflags: 0x0
// Checksum 0xc7389e4b, Offset: 0x1e90
// Size: 0x118
function function_a239b8a1() {
    level.var_52e58148 = 0;
    level.var_e5a9a6c4 = 0;
    foreach (s_loc in level.s_pap_quest.a_s_locations) {
        s_machine = s_loc.unitrigger_stub.pap_machine;
        hidemiscmodels(s_loc.prefabname);
        s_machine thread zm_pack_a_punch::function_e95839cd(1, "arriving", "arrive_anim_done");
        s_machine waittill(#"arrive_anim_done");
        showmiscmodels(s_loc.prefabname);
    }
}

// Namespace zodt8_pap_quest/zm_zodt8_pap_quest
// Params 0, eflags: 0x0
// Checksum 0xc3966c84, Offset: 0x1fb0
// Size: 0xf0
function function_5f17a55c() {
    a_ai_enemies = array::get_all_closest(self.origin, getaiteamarray(level.zombie_team), undefined, 40, 100);
    foreach (ai_zombie in a_ai_enemies) {
        ai_zombie dodamage(ai_zombie.health + 100, ai_zombie.origin + (0, 100, 0));
    }
}

// Namespace zodt8_pap_quest/zm_zodt8_pap_quest
// Params 0, eflags: 0x0
// Checksum 0xb009d1c6, Offset: 0x20a8
// Size: 0xb4
function pap_chunk_big_rune_on() {
    switch (self.prefabname) {
    case #"engine_room_pap_location":
        var_135251fe = 4;
        break;
    case #"stairs_pap_location":
        var_135251fe = 2;
        break;
    case #"cargo_pap_location":
        var_135251fe = 5;
        break;
    case #"poop_deck_pap_location":
        var_135251fe = 3;
        break;
    }
    self clientfield::set("pap_chunk_big_rune", var_135251fe);
}

// Namespace zodt8_pap_quest/zm_zodt8_pap_quest
// Params 0, eflags: 0x0
// Checksum 0x87241261, Offset: 0x2168
// Size: 0x4b8
function function_f5639e30() {
    if (!level flag::get("pap_quest_complete")) {
        foreach (s_loc in level.s_pap_quest.a_s_locations) {
            if (isdefined(s_loc.unitrigger_stub.pap_machine.var_8c37118f) && s_loc.unitrigger_stub.pap_machine.var_8c37118f) {
                switch (s_loc.prefabname) {
                case #"engine_room_pap_location":
                    var_65a9b281 = 1;
                    break;
                case #"stairs_pap_location":
                    var_9e6bd9a1 = 1;
                    break;
                case #"cargo_pap_location":
                    var_3852570 = 1;
                    break;
                case #"poop_deck_pap_location":
                    var_128761d1 = 1;
                    break;
                }
            }
        }
        if (isdefined(var_9e6bd9a1) && var_9e6bd9a1) {
            var_135251fe = 2;
            if (isdefined(var_128761d1) && var_128761d1) {
                var_135251fe = 3;
                if (isdefined(var_65a9b281) && var_65a9b281) {
                    var_135251fe = 4;
                    if (isdefined(var_3852570) && var_3852570) {
                        var_135251fe = 16;
                    }
                } else if (isdefined(var_3852570) && var_3852570) {
                    var_135251fe = 5;
                }
            } else if (isdefined(var_65a9b281) && var_65a9b281) {
                var_135251fe = 6;
                if (isdefined(var_3852570) && var_3852570) {
                    var_135251fe = 7;
                }
            } else if (isdefined(var_3852570) && var_3852570) {
                var_135251fe = 8;
            }
        } else if (isdefined(var_128761d1) && var_128761d1) {
            var_135251fe = 9;
            if (isdefined(var_65a9b281) && var_65a9b281) {
                var_135251fe = 10;
                if (isdefined(var_3852570) && var_3852570) {
                    var_135251fe = 11;
                }
            } else if (isdefined(var_3852570) && var_3852570) {
                var_135251fe = 12;
            }
        } else if (isdefined(var_65a9b281) && var_65a9b281) {
            var_135251fe = 13;
            if (isdefined(var_3852570) && var_3852570) {
                var_135251fe = 14;
            }
        } else if (isdefined(var_3852570) && var_3852570) {
            var_135251fe = 15;
        } else {
            var_135251fe = 1;
        }
    } else if (isdefined(level.pap_machine) && !(isdefined(level.var_e5a9a6c4) && level.var_e5a9a6c4) && !(isdefined(level.var_d5c6e5d0) && level.var_d5c6e5d0)) {
        switch (level.pap_machine.prefabname) {
        case #"engine_room_pap_location":
            var_135251fe = 13;
            break;
        case #"stairs_pap_location":
            var_135251fe = 2;
            break;
        case #"cargo_pap_location":
            var_135251fe = 15;
            break;
        case #"poop_deck_pap_location":
            var_135251fe = 9;
            break;
        }
    }
    if (isdefined(var_135251fe)) {
        foreach (s_loc in level.s_pap_quest.a_s_locations) {
            s_loc.unitrigger_stub.pap_machine clientfield::set("pap_chunk_small_rune", var_135251fe);
        }
    }
}

// Namespace zodt8_pap_quest/zm_zodt8_pap_quest
// Params 0, eflags: 0x0
// Checksum 0xc0f24dce, Offset: 0x2628
// Size: 0xb4
function pap_machine_rune_on() {
    switch (self.prefabname) {
    case #"engine_room_pap_location":
        var_135251fe = 4;
        break;
    case #"stairs_pap_location":
        var_135251fe = 2;
        break;
    case #"cargo_pap_location":
        var_135251fe = 5;
        break;
    case #"poop_deck_pap_location":
        var_135251fe = 3;
        break;
    }
    self clientfield::set("pap_machine_rune", var_135251fe);
}

/#

    // Namespace zodt8_pap_quest/zm_zodt8_pap_quest
    // Params 0, eflags: 0x0
    // Checksum 0x3094799a, Offset: 0x26e8
    // Size: 0x74
    function function_b254f888() {
        level.s_pap_quest.var_d6c419fd = 0;
        if (!level flag::get("<dev string:x46>")) {
            level waittill(#"stairs_pap_location");
        }
        wait 0.1;
        level flag::set("<dev string:x72>");
    }

    // Namespace zodt8_pap_quest/zm_zodt8_pap_quest
    // Params 0, eflags: 0x0
    // Checksum 0x7c7142eb, Offset: 0x2768
    // Size: 0xba
    function function_2737d594() {
        level flag::wait_till("<dev string:x85>");
        var_f6b4f92d = getent("<dev string:x99>", "<dev string:xaf>");
        if (!isdefined(var_f6b4f92d)) {
            return;
        }
        var_f6b4f92d zm_pack_a_punch::set_state_arriving();
        while (true) {
            for (i = 2; i <= 5; i++) {
                var_f6b4f92d function_bdec7efc(i);
            }
        }
    }

    // Namespace zodt8_pap_quest/zm_zodt8_pap_quest
    // Params 1, eflags: 0x0
    // Checksum 0x9d9f2324, Offset: 0x2830
    // Size: 0x82
    function function_57515a0(var_87c8152d) {
        self clientfield::set("<dev string:xba>", var_87c8152d);
        wait 3;
        self clientfield::set("<dev string:xcd>", var_87c8152d);
        wait 3;
        self clientfield::set("<dev string:xcd>", 0);
        wait 2;
    }

    // Namespace zodt8_pap_quest/zm_zodt8_pap_quest
    // Params 1, eflags: 0x0
    // Checksum 0xc7faa739, Offset: 0x28c0
    // Size: 0x5a
    function function_bdec7efc(var_87c8152d) {
        self clientfield::set("<dev string:xe2>", var_87c8152d);
        wait 3;
        self clientfield::set("<dev string:xe2>", 1);
        wait 2;
    }

    // Namespace zodt8_pap_quest/zm_zodt8_pap_quest
    // Params 0, eflags: 0x0
    // Checksum 0xafdf532e, Offset: 0x2928
    // Size: 0x37e
    function function_93cc6ffb() {
        level endon(#"pap_moved");
        var_f614cb16 = self.origin + vectornormalize(anglestoforward(self.angles)) * 160 + (0, 0, 100);
        var_98d6031d = self.origin + vectornormalize(anglestoforward(self.angles)) * 160 + (0, 0, 80);
        var_3d8f1db4 = self.origin + vectornormalize(anglestoforward(self.angles)) * 160 + (0, 0, 60);
        var_572b9773 = self.origin + vectornormalize(anglestoforward(self.angles)) * 160 + (0, 0, 40);
        var_9822eb0a = self.origin + vectornormalize(anglestoforward(self.angles)) * 160 + (0, 0, 20);
        var_1458c101 = self.origin + vectornormalize(anglestoforward(self.angles)) * 160 + (0, 0, 0);
        while (true) {
            print3d(var_f614cb16, "<dev string:xf3>" + self getzbarrierpiecestate(0));
            print3d(var_98d6031d, "<dev string:xfa>" + self getzbarrierpiecestate(1));
            print3d(var_3d8f1db4, "<dev string:x101>" + self getzbarrierpiecestate(2));
            print3d(var_572b9773, "<dev string:x108>" + self getzbarrierpiecestate(3));
            print3d(var_9822eb0a, "<dev string:x10f>" + self getzbarrierpiecestate(4));
            print3d(var_1458c101, "<dev string:x116>" + self getzbarrierpiecestate(5));
            waitframe(1);
        }
    }

#/
