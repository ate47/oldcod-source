#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;
#using scripts\zm_common\zm_powerups;
#using scripts\zm_common\zm_unitrigger;

#namespace namespace_d8b81d0b;

// Namespace namespace_d8b81d0b/namespace_9088ffd
// Params 0, eflags: 0x0
// Checksum 0xa2529990, Offset: 0x1d8
// Size: 0x84
function init_clientfields() {
    clientfield::register("scriptmover", "" + #"hash_3e57db9b106dff0a", 1, 1, "int");
    clientfield::register("scriptmover", "" + #"hash_4ccf2ce25e0dc836", 1, 1, "int");
}

// Namespace namespace_d8b81d0b/namespace_9088ffd
// Params 0, eflags: 0x0
// Checksum 0x92a0c151, Offset: 0x268
// Size: 0x252
function function_f17dfc5e() {
    if (getdvarint(#"zm_ee_enabled", 0)) {
        level.var_6d1783e6[0] = array(1, 1, 5);
        level.var_6d1783e6[1] = array(8, 7, 2);
        level.var_6d1783e6[2] = array(6, 6, 6);
    }
    level flag::init(#"hash_6429ffd7bef6f720");
    level flag::init(#"hash_7ebd1255a2e91e3e");
    level flag::init(#"hash_795bde5570f8b67c");
    var_92731274 = getent("nixie_door_trigger", "targetname");
    var_92731274 thread function_45feff52();
    var_7ddf10a = struct::get_array("nixie_tubes", "script_noteworthy");
    foreach (s_tube in var_7ddf10a) {
        mdl_tube = util::spawn_model(#"p8_zm_esc_nixie_tubes", s_tube.origin, s_tube.angles);
        mdl_tube.script_noteworthy = "blast_attack_interactables";
        mdl_tube.script_string = "mdl_nixie_tubes";
        s_tube.mdl_tube = mdl_tube;
    }
}

// Namespace namespace_d8b81d0b/namespace_9088ffd
// Params 0, eflags: 0x0
// Checksum 0xf964d91, Offset: 0x4c8
// Size: 0x42c
function function_45feff52() {
    self sethintstring(#"hash_2f5a14e8bf175422");
    self.var_1b22c709 = 0;
    level flag::wait_till(#"hash_7039457b1cc827de");
    self sethintstring(#"hash_7b303154f29d09c6");
    self waittill(#"trigger");
    mdl_lock = getent("masterkey_lock_3", "targetname");
    if (isdefined(mdl_lock)) {
        mdl_lock delete();
    }
    playsoundatposition(#"hash_b0382b7432f8232", self.origin);
    mdl_door_left = getent("nixie_door_left", "targetname");
    mdl_door_right = getent("nixie_door_right", "targetname");
    mdl_door_left notsolid();
    mdl_door_right notsolid();
    mdl_door_left rotateyaw(-94, 1, 0.2, 0.2);
    mdl_door_right rotateyaw(195, 1, 0.2, 0.2);
    level thread function_d2ad1b46();
    self delete();
    level flag::set(#"hash_6429ffd7bef6f720");
    level thread function_970daa73();
    wait 1;
    mdl_door_left rotateyaw(8, 1, 0.2, 0.2);
    mdl_door_right rotateyaw(-10, 1, 0.2, 0.2);
    wait 1;
    mdl_door_left rotateyaw(-5, 1, 0.2, 0.2);
    mdl_door_right rotateyaw(7, 1, 0.2, 0.2);
    wait 1;
    mdl_door_left rotateyaw(3, 1, 0.2, 0.2);
    mdl_door_right rotateyaw(-5, 1, 0.2, 0.2);
    wait 1;
    mdl_door_left rotateyaw(-2, 1, 0.2, 0.2);
    mdl_door_right rotateyaw(3, 1, 0.2, 0.2);
}

// Namespace namespace_d8b81d0b/namespace_9088ffd
// Params 0, eflags: 0x0
// Checksum 0xeed38790, Offset: 0x900
// Size: 0x12c
function function_970daa73() {
    while (true) {
        a_mdl_tubes = getentarray("mdl_nixie_tubes", "script_string");
        foreach (mdl_tube in a_mdl_tubes) {
            mdl_tube thread function_82448910();
        }
        level waittill(#"hash_dfac532bccdb293");
        function_a11064d5();
        level thread function_5fa167bb();
        level flag::wait_till_clear(#"hash_7ebd1255a2e91e3e");
        function_583d177();
        level notify(#"hash_59db65b924f851e4");
    }
}

// Namespace namespace_d8b81d0b/namespace_9088ffd
// Params 0, eflags: 0x0
// Checksum 0xd9cd150c, Offset: 0xa38
// Size: 0x70
function function_82448910() {
    level endon(#"hash_7ebd1255a2e91e3e");
    self waittill(#"blast_attack");
    self thread clientfield::set("" + #"hash_4ccf2ce25e0dc836", 1);
    level notify(#"hash_dfac532bccdb293");
}

// Namespace namespace_d8b81d0b/namespace_9088ffd
// Params 0, eflags: 0x0
// Checksum 0xaec4d938, Offset: 0xab0
// Size: 0x120
function function_a11064d5() {
    var_22f9c9d9 = struct::get_array("nixie_tubes", "script_noteworthy");
    foreach (s_tube in var_22f9c9d9) {
        mdl_tube = s_tube.mdl_tube;
        mdl_tube setmodel(#"p8_zm_esc_nixie_tubes_on");
        s_tube thread function_8746d6f9(0.75);
        if (s_tube.targetname == "nixie_tube_2") {
            s_tube thread function_78a88241(1);
        }
    }
    wait 0.75;
}

// Namespace namespace_d8b81d0b/namespace_9088ffd
// Params 0, eflags: 0x0
// Checksum 0x1e79d49f, Offset: 0xbd8
// Size: 0xa8
function function_5fa167bb() {
    level endon(#"hash_59db65b924f851e4", #"hash_795bde5570f8b67c");
    level flag::set(#"hash_7ebd1255a2e91e3e");
    wait 25;
    level flag::wait_till_clear(#"hash_795bde5570f8b67c");
    level flag::clear(#"hash_7ebd1255a2e91e3e");
    level notify(#"hash_59db65b924f851e4");
}

// Namespace namespace_d8b81d0b/namespace_9088ffd
// Params 0, eflags: 0x0
// Checksum 0x30bd1f21, Offset: 0xc88
// Size: 0x1a0
function function_583d177() {
    var_22f9c9d9 = struct::get_array("nixie_tubes", "script_noteworthy");
    foreach (s_tube in var_22f9c9d9) {
        s_tube.script_int = 0;
        mdl_tube = s_tube.mdl_tube;
        mdl_tube setmodel(#"p8_zm_esc_nixie_tubes");
        for (i = 0; i < 10; i++) {
            mdl_tube hidepart("tag_nixie_" + i);
        }
        mdl_tube thread clientfield::set("" + #"hash_4ccf2ce25e0dc836", 0);
        mdl_tube showpart("tag_nixie_off");
        if (s_tube.targetname == "nixie_tube_2") {
            s_tube thread function_78a88241(0);
        }
    }
}

// Namespace namespace_d8b81d0b/namespace_9088ffd
// Params 1, eflags: 0x0
// Checksum 0x7435eb81, Offset: 0xe30
// Size: 0x1fe
function function_8746d6f9(n_max_time) {
    mdl_tube = self.mdl_tube;
    mdl_tube hidepart("tag_nixie_off");
    n_start_time = gettime();
    n_total_time = 0;
    var_487dd448 = self.script_int;
    while (n_total_time < n_max_time) {
        for (n_part = randomint(10); n_part == var_487dd448; n_part = randomint(10)) {
        }
        mdl_tube showpart("tag_nixie_" + n_part);
        if (isdefined(var_487dd448)) {
            mdl_tube hidepart("tag_nixie_" + var_487dd448);
        }
        mdl_tube playsound(#"hash_12da80f02ef99473");
        var_487dd448 = n_part;
        wait 0.1;
        n_current_time = gettime();
        n_total_time = (n_current_time - n_start_time) / 1000;
    }
    for (i = 1; i < 10; i++) {
        mdl_tube hidepart("tag_nixie_" + i);
    }
    mdl_tube showpart("tag_nixie_0");
    mdl_tube playsound(#"hash_12da80f02ef99473");
    self.script_int = 0;
}

// Namespace namespace_d8b81d0b/namespace_9088ffd
// Params 1, eflags: 0x0
// Checksum 0x4aeacd1c, Offset: 0x1038
// Size: 0xfc
function function_78a88241(b_turn_on) {
    if (b_turn_on) {
        self.e_sound = spawn("script_origin", self.origin);
        playsoundatposition(#"hash_5870f3024077503", self.origin);
        self.e_sound playloopsound(#"hash_589f33024097b46");
        return;
    }
    if (isdefined(self.e_sound)) {
        playsoundatposition(#"hash_6c0f63cd38c393e7", self.origin);
        self.e_sound stoploopsound();
        wait 0.5;
        self.e_sound delete();
    }
}

// Namespace namespace_d8b81d0b/namespace_9088ffd
// Params 0, eflags: 0x0
// Checksum 0xa1638175, Offset: 0x1140
// Size: 0x1a4
function function_d2ad1b46() {
    var_bf6e40b = struct::get("nixie_tube_2");
    var_bf6e40b.unitrigger_stub = spawnstruct();
    var_bf6e40b.unitrigger_stub.origin = var_bf6e40b.origin;
    var_bf6e40b.unitrigger_stub.angles = var_bf6e40b.angles;
    var_bf6e40b.unitrigger_stub.script_unitrigger_type = "unitrigger_box_use";
    var_bf6e40b.unitrigger_stub.script_width = 96;
    var_bf6e40b.unitrigger_stub.script_length = 128;
    var_bf6e40b.unitrigger_stub.script_height = 96;
    var_bf6e40b.unitrigger_stub.cursor_hint = "HINT_NOICON";
    var_bf6e40b.unitrigger_stub.targetname = var_bf6e40b.script_string;
    var_bf6e40b.unitrigger_stub.s_tube = var_bf6e40b;
    var_bf6e40b.unitrigger_stub.prompt_and_visibility_func = &function_176a947b;
    zm_unitrigger::unitrigger_force_per_player_triggers(var_bf6e40b.unitrigger_stub, 1);
    zm_unitrigger::register_static_unitrigger(var_bf6e40b.unitrigger_stub, &function_80b75dc3);
}

// Namespace namespace_d8b81d0b/namespace_9088ffd
// Params 1, eflags: 0x0
// Checksum 0x1ddfeea4, Offset: 0x12f0
// Size: 0x150
function function_176a947b(player) {
    if (level flag::get(#"hash_7ebd1255a2e91e3e") && !level flag::get(#"hash_795bde5570f8b67c")) {
        self setvisibletoplayer(player);
        switch (self.targetname) {
        case #"nixie_tube_trigger_1":
            self sethintstring(#"");
            break;
        case #"nixie_tube_trigger_2":
            self sethintstring(#"");
            break;
        case #"nixie_tube_trigger_3":
            self sethintstring(#"");
            break;
        }
        return 1;
    }
    self setinvisibletoplayer(player);
    return 0;
}

// Namespace namespace_d8b81d0b/namespace_9088ffd
// Params 0, eflags: 0x0
// Checksum 0xca02a27c, Offset: 0x1448
// Size: 0x276
function function_80b75dc3() {
    function_3d250f19(self, 0.05);
    a_s_tubes = struct::get_array("nixie_tubes", "script_noteworthy");
    while (true) {
        s_result = self waittill(#"trigger");
        a_s_tubes = struct::get_array("nixie_tubes", "script_noteworthy");
        foreach (s_tube in a_s_tubes) {
            var_44a0fc5b = s_tube.mdl_tube sightconetrace(s_result.activator getweaponmuzzlepoint(), s_result.activator, s_result.activator getweaponforwarddir(), 10);
            if (isdefined(var_44a0fc5b) && var_44a0fc5b) {
                s_tube.mdl_tube hidepart("tag_nixie_" + s_tube.script_int);
                s_tube.script_int = (s_tube.script_int + 1) % 10;
                s_tube.mdl_tube showpart("tag_nixie_" + s_tube.script_int);
                break;
            }
        }
        playsoundatposition(#"hash_1aead9e7cdebe7d2", self.stub.s_tube.origin);
        if (getdvarint(#"zm_ee_enabled", 0)) {
            level thread function_e7d8dc56();
        }
        waitframe(1);
    }
}

// Namespace namespace_d8b81d0b/namespace_9088ffd
// Params 0, eflags: 0x0
// Checksum 0xa52c2d15, Offset: 0x16c8
// Size: 0x6c
function function_e7d8dc56() {
    level notify(#"hash_2f586f8df1e6596d");
    level endon(#"hash_2f586f8df1e6596d", #"hash_59db65b924f851e4", #"hash_f787bd652d7a4b");
    wait 2;
    level thread function_32cc71d3();
}

// Namespace namespace_d8b81d0b/namespace_9088ffd
// Params 0, eflags: 0x0
// Checksum 0x32b04dc5, Offset: 0x1740
// Size: 0x494
function function_32cc71d3() {
    level endon(#"hash_59db65b924f851e4");
    level notify(#"hash_f787bd652d7a4b");
    var_8148144d = struct::get("nixie_tube_1");
    var_a74a8eb6 = struct::get("nixie_tube_2");
    var_cd4d091f = struct::get("nixie_tube_3");
    var_c25932f7 = var_8148144d.script_int;
    var_5051c3bc = var_a74a8eb6.script_int;
    var_76543e25 = var_cd4d091f.script_int;
    var_ff67a852 = 0;
    var_cbbca326 = 0;
    if (var_c25932f7 == var_8148144d.var_df0ccd26 && var_5051c3bc == var_a74a8eb6.var_df0ccd26 && var_76543e25 == var_cd4d091f.var_df0ccd26) {
        var_ff67a852 = 1;
    } else {
        for (i = 0; i < level.var_6d1783e6.size; i++) {
            if (var_c25932f7 == level.var_6d1783e6[i][0] && var_5051c3bc == level.var_6d1783e6[i][1] && var_76543e25 == level.var_6d1783e6[i][2]) {
                if (var_c25932f7 == 9 && var_5051c3bc == 3 && var_76543e25 == 5 && isdefined(level.var_cba54fe8) && level.var_cba54fe8) {
                    var_cbbca326 = 0;
                    continue;
                }
                var_cbbca326 = 1;
            }
        }
    }
    if (var_cbbca326 || var_ff67a852 && !level flag::get(#"hash_ed90925c898d1b0")) {
        var_452fccfa = 1;
    }
    if (isdefined(var_452fccfa) && var_452fccfa) {
        level flag::set(#"hash_795bde5570f8b67c");
        var_8148144d thread function_f20bff4(1.5);
        var_a74a8eb6 thread function_f20bff4(1.5);
        var_cd4d091f thread function_f20bff4(1.5);
        wait 1.5 + 0.25;
        if (var_cbbca326) {
            str_code = "" + var_c25932f7 + var_5051c3bc + var_76543e25;
            level thread function_7c61a30a(str_code);
        }
        var_8148144d function_8746d6f9(0.75);
        var_a74a8eb6 function_8746d6f9(0.75);
        var_cd4d091f function_8746d6f9(0.75);
        wait 2;
        if (var_ff67a852 && level flag::exists(#"hash_ed90925c898d1b0") && !level flag::get(#"hash_ed90925c898d1b0")) {
            level flag::set(#"hash_ed90925c898d1b0");
        }
        level flag::clear(#"hash_795bde5570f8b67c");
        level flag::clear(#"hash_7ebd1255a2e91e3e");
    }
}

// Namespace namespace_d8b81d0b/namespace_9088ffd
// Params 1, eflags: 0x0
// Checksum 0x10f82090, Offset: 0x1be0
// Size: 0xda
function function_7c61a30a(str_code) {
    level notify(#"hash_1ba800da972b0558", {#str_code:str_code});
    switch (str_code) {
    case #"115":
        /#
            iprintlnbold("<dev string:x30>");
        #/
        break;
    case #"872":
        level thread function_d4f5a84f();
        break;
    case #"666":
        level thread function_9db15d64();
        break;
    default:
        break;
    }
}

// Namespace namespace_d8b81d0b/namespace_9088ffd
// Params 0, eflags: 0x4
// Checksum 0x266be4fe, Offset: 0x1cc8
// Size: 0x204
function private function_d4f5a84f() {
    if (isdefined(level.var_cba54fe8) && level.var_cba54fe8) {
        return;
    }
    level.var_cba54fe8 = 1;
    s_spawn_location = struct::get("nixie_tube_2");
    s_spawn_location = struct::get(s_spawn_location.target);
    mdl_powerup = util::spawn_model(s_spawn_location.model, s_spawn_location.origin, s_spawn_location.angles);
    mdl_powerup clientfield::set("" + #"hash_3e57db9b106dff0a", 1);
    for (s_target = struct::get(s_spawn_location.target); isdefined(s_target); s_target = struct::get(s_target.target)) {
        n_time = distance(mdl_powerup.origin, s_target.origin) / 300;
        mdl_powerup moveto(s_target.origin, n_time);
        mdl_powerup waittill(#"movedone");
    }
    zm_powerups::specific_powerup_drop("zombie_blood", mdl_powerup.origin - (0, 0, 40));
    mdl_powerup delete();
    level thread function_b4c370ea();
}

// Namespace namespace_d8b81d0b/namespace_9088ffd
// Params 0, eflags: 0x4
// Checksum 0xd4170fca, Offset: 0x1ed8
// Size: 0x26
function private function_b4c370ea() {
    level waittill(#"between_round_over");
    level.var_cba54fe8 = undefined;
}

// Namespace namespace_d8b81d0b/namespace_9088ffd
// Params 0, eflags: 0x4
// Checksum 0x2da5051d, Offset: 0x1f08
// Size: 0x54
function private function_9db15d64() {
    var_57e1f962 = struct::get("nixie_tube_2");
    playsoundatposition(#"hash_1588095b858588d", var_57e1f962.origin);
}

// Namespace namespace_d8b81d0b/namespace_9088ffd
// Params 1, eflags: 0x0
// Checksum 0xe7560863, Offset: 0x1f68
// Size: 0x1ec
function function_f20bff4(n_max_time) {
    mdl_tube = self.mdl_tube;
    n_start_time = gettime();
    n_total_time = 0;
    var_487dd448 = undefined;
    b_hidden = 1;
    var_4b4df1aa = randomfloat(0.2);
    wait var_4b4df1aa;
    n_current_time = gettime();
    for (n_total_time = (n_current_time - n_start_time) / 1000; n_total_time < n_max_time; n_total_time = (n_current_time - n_start_time) / 1000) {
        if (b_hidden) {
            mdl_tube hidepart("tag_nixie_" + self.script_int);
            mdl_tube showpart("tag_nixie_off");
            b_hidden = 0;
        } else {
            mdl_tube showpart("tag_nixie_" + self.script_int);
            mdl_tube hidepart("tag_nixie_off");
            b_hidden = 1;
            mdl_tube playsound(#"hash_12da80f02ef99473");
        }
        wait 0.1;
        n_current_time = gettime();
    }
    mdl_tube showpart("tag_nixie_" + self.script_int);
    mdl_tube hidepart("tag_nixie_off");
}

// Namespace namespace_d8b81d0b/namespace_9088ffd
// Params 0, eflags: 0x0
// Checksum 0xac8fb38e, Offset: 0x2160
// Size: 0x11e
function function_30b0d12b() {
    mdl_tube = self.mdl_tube;
    for (i = 0; i < 10; i++) {
        mdl_tube hidepart("tag_nixie_" + i);
    }
    mdl_tube hidepart("tag_nixie_off");
    for (i = 0; i <= self.script_int; i++) {
        if (i > 0) {
            mdl_tube hidepart("tag_nixie_" + i - 1);
        }
        mdl_tube showpart("tag_nixie_" + i);
        mdl_tube playsound(#"hash_12da80f02ef99473");
        wait 0.1;
    }
}

// Namespace namespace_d8b81d0b/namespace_9088ffd
// Params 3, eflags: 0x0
// Checksum 0xe5f037e8, Offset: 0x2288
// Size: 0x186
function function_7bf90968(var_c25932f7, var_5051c3bc, var_76543e25) {
    var_1a161fef = 1;
    if (var_c25932f7 == 0 || var_5051c3bc == 0 || var_76543e25 == 0) {
        var_1a161fef = 0;
    }
    if (var_c25932f7 == 0 && var_5051c3bc == 0 && var_76543e25 == 0) {
        var_1a161fef = 0;
    }
    if (var_c25932f7 == 6 && var_5051c3bc == 6 && var_76543e25 == 6) {
        var_1a161fef = 0;
    }
    if (var_c25932f7 == 7 && var_5051c3bc == 7 && var_76543e25 == 7) {
        var_1a161fef = 0;
    }
    for (i = 0; i < level.var_6d1783e6.size; i++) {
        if (var_c25932f7 == level.var_6d1783e6[i][0] && var_5051c3bc == level.var_6d1783e6[i][1] && var_76543e25 == level.var_6d1783e6[i][2]) {
            var_1a161fef = 0;
            break;
        }
    }
    return var_1a161fef;
}

