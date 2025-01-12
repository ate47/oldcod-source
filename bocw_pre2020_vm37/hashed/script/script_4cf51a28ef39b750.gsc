#using scripts\core_common\array_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm\zm_silver_pap_quest;
#using scripts\zm_common\callbacks;
#using scripts\zm_common\zm_fasttravel;
#using scripts\zm_common\zm_utility;

#namespace namespace_9d3ef6c5;

// Namespace namespace_9d3ef6c5/namespace_9d3ef6c5
// Params 0, eflags: 0x6
// Checksum 0xf290dfab, Offset: 0x170
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"hash_3c412421c33b7764", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace namespace_9d3ef6c5/namespace_9d3ef6c5
// Params 0, eflags: 0x1 linked
// Checksum 0xb675ab34, Offset: 0x1b8
// Size: 0x13c
function function_70a657d8() {
    level.var_9d19ea6d = 1;
    level.var_ce0f67cf = 5;
    level.var_e9737821 = &function_c52e8ba;
    level.var_d0fafce1 = 1;
    clientfield::register("scriptmover", "" + #"hash_56ce10c39906bf70", 1, 1, "int");
    callback::function_74872db6(&function_786c864d);
    level thread function_76138a38();
    level thread function_d794f3ac();
    level thread function_e663b61e();
    level thread function_9780725f();
    level thread function_ebb262ad();
    level thread function_ca8f3b73();
}

// Namespace namespace_9d3ef6c5/namespace_9d3ef6c5
// Params 0, eflags: 0x1 linked
// Checksum 0xa851eec5, Offset: 0x300
// Size: 0x130
function function_9780725f() {
    level endon(#"end_game");
    level flag::wait_till("all_players_spawned");
    level flag::wait_till(level.var_5bfd847e);
    var_1d1bbd52 = struct::get_array("fasttravel_trigger", "targetname");
    foreach (s_loc in var_1d1bbd52) {
        if (isdefined(s_loc.unitrigger_stub.delay)) {
            s_loc.unitrigger_stub flag::delay_set(s_loc.unitrigger_stub.delay, "delayed");
        }
    }
}

// Namespace namespace_9d3ef6c5/namespace_9d3ef6c5
// Params 0, eflags: 0x1 linked
// Checksum 0xc8385ae0, Offset: 0x438
// Size: 0x54
function function_786c864d() {
    if (isdefined(level.var_3161430e) && level.round_number == level.var_3161430e + 10) {
        level flag::set(#"hash_268c943ffdd74fa");
    }
}

// Namespace namespace_9d3ef6c5/namespace_9d3ef6c5
// Params 2, eflags: 0x1 linked
// Checksum 0xa8f0f9a8, Offset: 0x498
// Size: 0x3d4
function function_c52e8ba(player, var_8d5d092c) {
    b_result = 0;
    if (!isdefined(self.hint_string)) {
        self.hint_string = [];
    }
    n_player_index = player getentitynumber();
    if (level flag::get(#"hash_268c943ffdd74fa")) {
        self.hint_string[n_player_index] = player zm_utility::function_d6046228(#"hash_2731cc5c1208e2e4", #"hash_47b20f457b370888");
        b_result = 1;
    } else if (!level flag::get(#"dark_aether_active")) {
        self.hint_string[n_player_index] = #"";
    } else if (!self zm_fasttravel::function_d06e636b(player)) {
        self.hint_string[n_player_index] = #"";
    } else if (isdefined(self.stub.var_a92d1b24) && !level flag::get_all(self.stub.var_a92d1b24)) {
        self.hint_string[n_player_index] = #"";
    } else if (is_true(player.var_9c7b96ed[var_8d5d092c])) {
        self.hint_string[n_player_index] = #"hash_7667bd0f83307360";
        b_result = 1;
    } else if (isdefined(self.stub.delay) && !self.stub flag::get("delayed")) {
        self.hint_string[n_player_index] = #"zombie/fasttravel_delay";
        b_result = 1;
    } else {
        switch (self.stub.script_string) {
        case #"hash_63156dac534aede7":
            hint_string = #"hash_1b5d024264e26e98";
            break;
        case #"hash_15d6fece382a5cbe":
            hint_string = #"hash_19ae69436c39da09";
            break;
        case #"fasttravel_loc_crash_site_down":
            hint_string = #"hash_3be004aaa3ef2edd";
            break;
        case #"hash_2b732b2cff505c84":
            hint_string = #"hash_5a1913d1fec350f9";
            break;
        case #"hash_5af6096260ab857c":
            hint_string = #"hash_5c514164da699bed";
            break;
        case #"fasttravel_loc_pond_down":
            hint_string = #"hash_5de92cc1bf44a38a";
            break;
        default:
            break;
        }
        if (isdefined(hint_string)) {
            self.hint_string[n_player_index] = hint_string;
        } else {
            self.hint_string[n_player_index] = player zm_utility::function_d6046228(#"hash_2731cc5c1208e2e4", #"hash_47b20f457b370888");
        }
        b_result = 1;
    }
    return b_result;
}

// Namespace namespace_9d3ef6c5/namespace_9d3ef6c5
// Params 0, eflags: 0x5 linked
// Checksum 0xe4f0975c, Offset: 0x878
// Size: 0x134
function private function_76138a38() {
    level endon(#"end_game");
    function_130d4334();
    a_s_fasttravel = struct::get_array("fasttravel_trigger");
    foreach (s_fasttravel in a_s_fasttravel) {
        if (isdefined(s_fasttravel.target)) {
            a_ents = getentarray(s_fasttravel.target, "targetname");
            array::run_all(a_ents, &hide);
        }
    }
    level clientfield::set("fasttravel_exploder", 1);
}

// Namespace namespace_9d3ef6c5/namespace_9d3ef6c5
// Params 0, eflags: 0x1 linked
// Checksum 0x8d064225, Offset: 0x9b8
// Size: 0x90
function function_ebb262ad() {
    level endon(#"end_game");
    while (true) {
        level flag::wait_till(#"dark_aether_active");
        level thread function_1fad5dd0();
        level flag::wait_till_clear(#"dark_aether_active");
        function_2b30b25d();
    }
}

// Namespace namespace_9d3ef6c5/namespace_9d3ef6c5
// Params 0, eflags: 0x1 linked
// Checksum 0x78f83dfe, Offset: 0xa50
// Size: 0x204
function function_130d4334() {
    level endon(#"hash_268c943ffdd74fa");
    while (true) {
        level flag::wait_till(#"dark_aether_active");
        a_s_fasttravel = struct::get_array("fasttravel_trigger");
        foreach (s_fasttravel in a_s_fasttravel) {
            if (isdefined(s_fasttravel.target)) {
                a_ents = getentarray(s_fasttravel.target, "targetname");
                array::run_all(a_ents, &hide);
            }
        }
        level flag::wait_till_clear(#"dark_aether_active");
        foreach (s_fasttravel in a_s_fasttravel) {
            if (isdefined(s_fasttravel.target)) {
                a_ents = getentarray(s_fasttravel.target, "targetname");
                array::run_all(a_ents, &show);
            }
        }
    }
}

// Namespace namespace_9d3ef6c5/namespace_9d3ef6c5
// Params 0, eflags: 0x5 linked
// Checksum 0x77339054, Offset: 0xc60
// Size: 0x11c
function private function_d794f3ac() {
    level endon(#"end_game");
    level waittill(#"hash_5674ed1aa008ba97");
    var_192a77dd = getent("medical_door", "targetname");
    var_bc3a592b = getent(var_192a77dd.target, "targetname");
    var_ceb9f97e = getent("medical_door_shaft", "targetname");
    var_bc3a592b linkto(var_192a77dd);
    var_192a77dd linkto(var_ceb9f97e);
    var_ceb9f97e rotateto(var_ceb9f97e.angles + (0, -120, 0), 1, 0.25, 0.25);
}

// Namespace namespace_9d3ef6c5/namespace_9d3ef6c5
// Params 0, eflags: 0x5 linked
// Checksum 0xb0c88dba, Offset: 0xd88
// Size: 0xdc
function private function_e663b61e() {
    level endon(#"end_game");
    level waittill(#"hash_426979dda15dd76f");
    var_8e0d050c = getent("armory_door", "targetname");
    var_a801f97d = getent(var_8e0d050c.target, "targetname");
    var_a801f97d linkto(var_8e0d050c);
    var_8e0d050c moveto(var_8e0d050c.origin + (0, 0, 90), 2, 0.5, 0.5);
}

// Namespace namespace_9d3ef6c5/namespace_9d3ef6c5
// Params 0, eflags: 0x1 linked
// Checksum 0x9ba481ba, Offset: 0xe70
// Size: 0x21c
function function_1fad5dd0() {
    level endon(#"dark_side_timeout", #"hash_61e8a39b3a4bee6a", #"end_game");
    a_s_fasttravel = struct::get_array("fasttravel_trigger");
    var_7f26d025 = 0;
    if (!level flag::get(#"hash_268c943ffdd74fa")) {
        while (true) {
            foreach (s_fasttravel in a_s_fasttravel) {
                if (!isdefined(s_fasttravel.unitrigger_stub.b_play)) {
                    if (level flag::get_all(s_fasttravel.unitrigger_stub.var_a92d1b24)) {
                        var_b76ed368 = struct::get(s_fasttravel.unitrigger_stub.script_string, "targetname");
                        s_fasttravel.unitrigger_stub.var_4eadb6a8 = util::spawn_model("tag_origin", var_b76ed368.origin, var_b76ed368.angles);
                        s_fasttravel.unitrigger_stub.var_4eadb6a8 clientfield::set("" + #"hash_56ce10c39906bf70", 1);
                        s_fasttravel.unitrigger_stub.b_play = 1;
                        var_7f26d025++;
                    }
                }
            }
            if (var_7f26d025 === a_s_fasttravel.size) {
                break;
            }
            waitframe(1);
        }
    }
}

// Namespace namespace_9d3ef6c5/namespace_9d3ef6c5
// Params 0, eflags: 0x1 linked
// Checksum 0x2f05e76, Offset: 0x1098
// Size: 0x142
function function_2b30b25d() {
    level endon(#"end_game");
    a_s_fasttravel = struct::get_array("fasttravel_trigger");
    foreach (s_fasttravel in a_s_fasttravel) {
        if (is_true(s_fasttravel.unitrigger_stub.b_play)) {
            s_fasttravel.unitrigger_stub.var_4eadb6a8 clientfield::set("" + #"hash_56ce10c39906bf70", 0);
            s_fasttravel.unitrigger_stub.var_4eadb6a8 delete();
            s_fasttravel.unitrigger_stub.b_play = undefined;
        }
    }
}

// Namespace namespace_9d3ef6c5/namespace_9d3ef6c5
// Params 0, eflags: 0x1 linked
// Checksum 0x66d325d6, Offset: 0x11e8
// Size: 0x74
function function_ca8f3b73() {
    level flag::wait_till(#"hash_268c943ffdd74fa");
    level clientfield::set("fasttravel_exploder", 1);
    level thread zm_silver_pap_quest::function_c1bd7e55();
    level thread zm_silver_pap_quest::function_40102053();
}

