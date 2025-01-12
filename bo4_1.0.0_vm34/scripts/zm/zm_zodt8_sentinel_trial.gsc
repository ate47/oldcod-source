#using scripts\core_common\aat_shared;
#using scripts\core_common\ai\zombie_utility;
#using scripts\core_common\ai_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\exploder_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\flagsys_shared;
#using scripts\core_common\fx_shared;
#using scripts\core_common\laststand_shared;
#using scripts\core_common\lui_shared;
#using scripts\core_common\music_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\core_common\vehicle_shared;
#using scripts\zm\ai\zm_ai_stoker;
#using scripts\zm\zm_zodt8;
#using scripts\zm\zm_zodt8_eye;
#using scripts\zm_common\ai\zm_ai_utility;
#using scripts\zm_common\zm_audio;
#using scripts\zm_common\zm_cleanup_mgr;
#using scripts\zm_common\zm_customgame;
#using scripts\zm_common\zm_devgui;
#using scripts\zm_common\zm_fasttravel;
#using scripts\zm_common\zm_magicbox;
#using scripts\zm_common\zm_pack_a_punch;
#using scripts\zm_common\zm_perks;
#using scripts\zm_common\zm_player;
#using scripts\zm_common\zm_powerups;
#using scripts\zm_common\zm_round_logic;
#using scripts\zm_common\zm_round_spawning;
#using scripts\zm_common\zm_sq;
#using scripts\zm_common\zm_sq_modules;
#using scripts\zm_common\zm_transformation;
#using scripts\zm_common\zm_ui_inventory;
#using scripts\zm_common\zm_unitrigger;
#using scripts\zm_common\zm_utility;
#using scripts\zm_common\zm_weapons;
#using scripts\zm_common\zm_zonemgr;

#namespace zodt8_sentinel;

// Namespace zodt8_sentinel/zm_zodt8_sentinel_trial
// Params 0, eflags: 0x0
// Checksum 0x30decc34, Offset: 0xb48
// Size: 0xcc
function init() {
    init_fx();
    init_clientfields();
    init_flags();
    init_steps();
    function_5c165ebf();
    function_a8574349();
    function_44dd495();
    level thread function_faf25db();
    if (zm_custom::function_5638f689(#"hash_3c5363541b97ca3e")) {
        zm_sq::start(#"main_quest");
    }
}

// Namespace zodt8_sentinel/zm_zodt8_sentinel_trial
// Params 0, eflags: 0x0
// Checksum 0x14155b1e, Offset: 0xc20
// Size: 0xf2
function init_fx() {
    level._effect[#"hash_41a5c5168ffb2a97"] = #"hash_7b0d80c48289dd0b";
    level._effect[#"hash_400a481490a4e390"] = #"hash_29138c752c86a486";
    level._effect[#"hash_5562e324d230f057"] = #"hash_495fc19edc59bb4e";
    level._effect[#"hash_41fae186552f1259"] = #"hash_22decafaaa11e437";
    level._effect[#"freezing_mist"] = #"hash_7379a044e62d65f";
}

// Namespace zodt8_sentinel/zm_zodt8_sentinel_trial
// Params 0, eflags: 0x0
// Checksum 0x16618edc, Offset: 0xd20
// Size: 0x594
function init_clientfields() {
    clientfield::register("world", "" + #"hash_3c58464f16d8a1be", 1, 1, "int");
    clientfield::register("scriptmover", "" + #"essence_fx", 1, 1, "int");
    clientfield::register("scriptmover", "" + #"land_fx", 1, 1, "int");
    clientfield::register("scriptmover", "" + #"planet_light", 1, getminbitcountfornum(9), "int");
    clientfield::register("scriptmover", "" + #"pulse_shader", 1, 1, "int");
    clientfield::register("scriptmover", "" + #"sentinel_shader", 1, 1, "int");
    clientfield::register("scriptmover", "" + #"hash_3400ccffbd3d73b3", 1, 2, "int");
    clientfield::register("scriptmover", "" + #"hash_15b23de7589e61a", 1, 1, "int");
    clientfield::register("scriptmover", "" + #"blocker_fx", 1, 1, "int");
    clientfield::register("scriptmover", "" + #"hash_68e2384b254175da", 1, 1, "counter");
    clientfield::register("scriptmover", "" + #"pipe_fx", 1, 2, "int");
    clientfield::register("scriptmover", "" + #"teleport_sigil", 1, 1, "int");
    clientfield::register("scriptmover", "" + #"hash_46e2ed49fb0f55c6", 1, 1, "int");
    clientfield::register("scriptmover", "" + #"water_props", 1, 1, "int");
    clientfield::register("toplayer", "" + #"boiler_fx", 1, 1, "int");
    clientfield::register("toplayer", "" + #"main_flash", 1, 1, "int");
    clientfield::register("toplayer", "" + #"iceberg_rumbles", 1, 1, "int");
    clientfield::register("toplayer", "" + #"hash_7a927551ca199a1c", 1, 1, "counter");
    clientfield::register("toplayer", "" + #"icy_bubbles", 1, 1, "int");
    clientfield::register("toplayer", "" + #"hash_58b44c320123e829", 1, 1, "int");
    clientfield::register("toplayer", "" + #"camera_snow", 1, 1, "int");
    clientfield::register("vehicle", "" + #"orb_fx", 1, 1, "int");
}

// Namespace zodt8_sentinel/zm_zodt8_sentinel_trial
// Params 0, eflags: 0x0
// Checksum 0xbbaa94fc, Offset: 0x12c0
// Size: 0x2e4
function init_flags() {
    level flag::init(#"hash_2d1cd18f39ac5fa7");
    level flag::init(#"hash_515a88d1cbabc18e");
    level flag::init(#"hash_1322dd3a3d7411a5");
    level flag::init(#"hash_2f5be8d749b4e88e");
    level flag::init(#"hash_33a5d8dd1204080e");
    level flag::init(#"hash_652ae68711aa37c1");
    level flag::init(#"hash_63ebf7fc2afa76ea");
    level flag::init(#"hash_70eb07a177cf8881");
    level flag::init(#"hash_65e37079e0d22d47");
    level flag::init(#"catalyst_encounters_completed");
    level flag::init(#"hash_7a31252c7c941976");
    level flag::init(#"hash_27a2746eb30e61c");
    level flag::init(#"hash_3e80d503318a5674");
    level flag::init(#"hash_452df3df817c57f9");
    level flag::init(#"hash_63a102a7ae564e99");
    level flag::init(#"orrery_activated");
    level flag::init(#"hash_76dd603f61fa542d");
    level flag::init(#"hash_77f76266b597a1f7");
    level flag::init(#"planet_step_completed");
    level flag::init(#"hash_1a742576c41a0ab9");
    level flag::init(#"hash_767ce45fce848b88");
    level flag::init(#"hash_349bc60cedc7491e");
    level flag::init(#"hash_280d10a2ac060edb");
}

// Namespace zodt8_sentinel/zm_zodt8_sentinel_trial
// Params 0, eflags: 0x0
// Checksum 0x727ee5b4, Offset: 0x15b0
// Size: 0x3cc
function init_steps() {
    zm_sq::register(#"main_quest", #"step_1", #"main_quest_step_1", &function_43d46804, &function_d8b55ea7);
    zm_sq::register(#"main_quest", #"step_2", #"main_quest_step_2", &function_1d045be3, &function_cde2fbd8);
    zm_sq::register(#"main_quest", #"step_3", #"main_quest_step_3", &function_45fda04a, &function_5bb4ccf1);
    zm_sq::register(#"main_quest", #"step_4", #"main_quest_step_4", &function_3abe93b1, &function_e0a92ca);
    zm_sq::register(#"main_quest", #"step_5", #"main_quest_step_5", &function_f1924978, &function_5a4ff6c3);
    zm_sq::register(#"main_quest", #"step_6", #"main_quest_step_6", &function_ab1beec7, &function_73e46b4);
    zm_sq::register(#"main_quest", #"step_7", #"main_quest_step_7", &function_dcc0419e, &function_6dc1a9ad);
    zm_sq::register(#"main_quest", #"step_8", #"main_quest_step_8", &function_5b246e85, &function_7d6b6ff6);
    zm_sq::register(#"main_quest", #"step_9", #"main_quest_step_9", &function_3c987f5c, &function_1f3697df);
    zm_sq::register(#"main_quest", #"outro_igc", #"main_quest_step_10", &function_4693caa8, &function_d6d4f9b3, 1);
}

// Namespace zodt8_sentinel/zm_zodt8_sentinel_trial
// Params 0, eflags: 0x0
// Checksum 0x8a514a17, Offset: 0x1988
// Size: 0x2ec
function function_5c165ebf() {
    level.a_s_sparks = array::randomize(struct::get_array(#"hash_b29f24eab97a1d"));
    var_eb6e71e4 = array(#"hash_41a5c5168ffb2a97", #"hash_400a481490a4e390", #"hash_5562e324d230f057", #"hash_41fae186552f1259");
    while (level.a_s_sparks.size > var_eb6e71e4.size) {
        arrayremoveindex(level.a_s_sparks, 0, 0);
    }
    foreach (s_spark in level.a_s_sparks) {
        s_spark.script_noteworthy = var_eb6e71e4[0];
        arrayremovevalue(var_eb6e71e4, var_eb6e71e4[0], 0);
        zm_sq_modules::function_8ab612a3(s_spark.script_noteworthy, 1, s_spark, &function_7098b55f, &function_afec37f7);
    }
    zm_sq_modules::function_8ab612a3(#"hash_7182a46bb3cdf577", 1, #"hash_7182a46bb3cdf577", &function_a0dc6b8b, &function_cc49529d);
    zm_sq_modules::function_8ab612a3(#"hash_466c2764cc790370", 1, #"hash_466c2764cc790370", &function_a0dc6b8b, &function_cc49529d);
    zm_sq_modules::function_8ab612a3(#"hash_34f2b4c4f7d74137", 1, #"hash_34f2b4c4f7d74137", &function_a0dc6b8b, &function_cc49529d);
    zm_sq_modules::function_8ab612a3(#"hash_49ad34a64ecaebb9", 1, #"hash_49ad34a64ecaebb9", &function_a0dc6b8b, &function_cc49529d);
}

// Namespace zodt8_sentinel/zm_zodt8_sentinel_trial
// Params 0, eflags: 0x0
// Checksum 0x708a2013, Offset: 0x1c80
// Size: 0xb8
function function_a8574349() {
    a_blockers = getentarray("cat_script_blocker", "targetname");
    foreach (e_blocker in a_blockers) {
        e_blocker hide();
        e_blocker notsolid();
    }
}

// Namespace zodt8_sentinel/zm_zodt8_sentinel_trial
// Params 0, eflags: 0x0
// Checksum 0x75fdae64, Offset: 0x1d40
// Size: 0xa0
function function_44dd495() {
    a_iceberg = getentarray("forget_what_you_know", "targetname");
    foreach (mdl in a_iceberg) {
        mdl hide();
    }
}

// Namespace zodt8_sentinel/zm_zodt8_sentinel_trial
// Params 0, eflags: 0x0
// Checksum 0xea1b2f29, Offset: 0x1de8
// Size: 0x2cc
function function_faf25db() {
    a_s_telegraphs = struct::get_array(#"s_telegraph");
    foreach (s_telegraph in a_s_telegraphs) {
        s_telegraph flag::init(s_telegraph.script_flag);
        s_telegraph zm_unitrigger::create(undefined, (64, 64, 72), &function_58f9bff4, 1);
        zm_unitrigger::function_7fcb11a8(s_telegraph.s_unitrigger, 1);
        s_telegraph thread function_a16d48ce();
    }
    var_badf18c8 = getentarray("mdl_short", "targetname");
    var_2a7dda9e = getentarray("mdl_long", "targetname");
    foreach (var_b0b5d301 in var_badf18c8) {
        var_b0b5d301.original_angles = var_b0b5d301.angles;
        var_b0b5d301 rotateroll(-350, 0.1);
    }
    foreach (var_8f1b3107 in var_2a7dda9e) {
        var_8f1b3107.original_angles = var_8f1b3107.angles;
        var_8f1b3107 rotateroll(-240, 0.1);
    }
    level waittill(#"start_zombie_round_logic");
    hidemiscmodels("bridge_controls");
}

// Namespace zodt8_sentinel/zm_zodt8_sentinel_trial
// Params 0, eflags: 0x0
// Checksum 0xd47ec3fc, Offset: 0x20c0
// Size: 0xf8
function function_a4497323() {
    var_592cfd5d = struct::get_array(#"planet_glyph", "script_noteworthy");
    foreach (s_loc in var_592cfd5d) {
        s_loc.mdl_glyph = util::spawn_model(s_loc.model, s_loc.origin, s_loc.angles);
        s_loc.mdl_glyph setscale(0.666);
    }
}

// Namespace zodt8_sentinel/zm_zodt8_sentinel_trial
// Params 1, eflags: 0x0
// Checksum 0x8c596bc3, Offset: 0x21c0
// Size: 0x8c
function function_43d46804(var_758116d) {
    function_a4497323();
    level flag::wait_till("all_players_spawned");
    level zm_ui_inventory::function_31a39683(#"zm_zodt8_sentinel_trial", 1);
    if (!var_758116d) {
        level flag::wait_till("power_on");
    }
}

// Namespace zodt8_sentinel/zm_zodt8_sentinel_trial
// Params 2, eflags: 0x0
// Checksum 0x384d6576, Offset: 0x2258
// Size: 0x54
function function_d8b55ea7(var_758116d, ended_early) {
    level flag::set("power_on");
    level flag::set(#"hash_3e80d503318a5674");
}

// Namespace zodt8_sentinel/zm_zodt8_sentinel_trial
// Params 1, eflags: 0x0
// Checksum 0x999be7e, Offset: 0x22b8
// Size: 0x5c
function function_1d045be3(var_758116d) {
    level zm_ui_inventory::function_31a39683(#"zm_zodt8_sentinel_trial", 2);
    if (!var_758116d) {
        level flag::wait_till("pap_quest_complete");
    }
}

// Namespace zodt8_sentinel/zm_zodt8_sentinel_trial
// Params 2, eflags: 0x0
// Checksum 0x80de2b7d, Offset: 0x2320
// Size: 0x94
function function_cde2fbd8(var_758116d, ended_early) {
    if (var_758116d || ended_early) {
        if (isdefined(level.s_pap_quest)) {
            level.s_pap_quest.var_d6c419fd = 0;
        }
    }
    if (!var_758116d) {
        playsoundatposition(#"hash_e0f3a75083de89a", (0, 0, 0));
    }
    level flag::set("pap_quest_complete");
}

// Namespace zodt8_sentinel/zm_zodt8_sentinel_trial
// Params 1, eflags: 0x0
// Checksum 0x2b2b791c, Offset: 0x23c0
// Size: 0x15c
function function_45fda04a(var_758116d) {
    level zm_ui_inventory::function_31a39683(#"zm_zodt8_sentinel_trial", 3);
    if (!var_758116d) {
        level.a_str_zones = array(#"bridge", #"grand_staircase", #"mail_rooms", #"hash_f434aec906b7c76", #"hash_5236cc7d71cc92b3", #"galley");
        /#
        #/
        function_23e3a99f(#"hash_122c834b72722973");
        function_23e3a99f(#"hash_1cd2e394d963233b");
        function_23e3a99f(#"hash_2697e0e48c225c27");
        function_23e3a99f(#"hash_154f3a12365359d");
        level flag::wait_till(#"hash_2d1cd18f39ac5fa7");
    }
}

// Namespace zodt8_sentinel/zm_zodt8_sentinel_trial
// Params 2, eflags: 0x0
// Checksum 0x4367147c, Offset: 0x2528
// Size: 0x18a
function function_5bb4ccf1(var_758116d, ended_early) {
    if (!var_758116d) {
        hidemiscmodels("bridge_controls");
        foreach (var_fe6dc4c3 in level.var_4991a9d2) {
            var_fe6dc4c3 delete();
        }
        level.var_4991a9d2 = undefined;
        playsoundatposition(#"hash_e0f3b75083dea4d", (0, 0, 0));
    }
    a_s_telegraphs = struct::get_array(#"s_telegraph");
    foreach (s_telegraph in a_s_telegraphs) {
        zm_unitrigger::unregister_unitrigger(s_telegraph.s_unitrigger);
    }
    level.a_str_zones = undefined;
}

// Namespace zodt8_sentinel/zm_zodt8_sentinel_trial
// Params 1, eflags: 0x0
// Checksum 0xcc4fe721, Offset: 0x26c0
// Size: 0x554
function function_23e3a99f(str_script_noteworthy) {
    n_index = randomint(level.a_str_zones.size);
    str_zone = level.a_str_zones[n_index];
    arrayremoveindex(level.a_str_zones, n_index);
    var_9b6e3e51 = struct::get(str_script_noteworthy, "script_noteworthy");
    var_6e0b5d99 = struct::get(var_9b6e3e51.var_e5027e1e, "script_noteworthy");
    var_9b6e3e51.var_440637ef = function_52e17c68(var_9b6e3e51);
    var_6e0b5d99.var_440637ef = function_52e17c68(var_6e0b5d99);
    while (var_6e0b5d99.var_440637ef == 11 && var_9b6e3e51.var_440637ef == 8) {
        var_6e0b5d99.var_440637ef = 8;
        var_9b6e3e51.var_440637ef = 11;
    }
    var_badf18c8 = getentarray("mdl_short", "targetname");
    var_2a7dda9e = getentarray("mdl_long", "targetname");
    foreach (var_b0b5d301 in var_badf18c8) {
        if (isdefined(var_b0b5d301.script_zone)) {
            if (var_b0b5d301.script_zone == str_zone) {
                var_b0b5d301 thread function_22b76a7c(var_6e0b5d99.var_440637ef, -10, 0.166667);
            }
            continue;
        }
        assertmsg("<dev string:x30>");
    }
    foreach (var_8f1b3107 in var_2a7dda9e) {
        if (isdefined(var_8f1b3107.script_zone)) {
            if (var_8f1b3107.script_zone == str_zone) {
                var_8f1b3107 thread function_22b76a7c(var_9b6e3e51.var_440637ef, -120, 2);
            }
            continue;
        }
        assertmsg("<dev string:x55>");
    }
    var_4722fc54 = struct::get_array(var_9b6e3e51.var_75cde0f3, "script_noteworthy");
    foreach (var_333bdea5 in var_4722fc54) {
        if (!isdefined(var_333bdea5.script_zone) || var_333bdea5.script_zone == str_zone) {
            var_fe6dc4c3 = util::spawn_model(var_333bdea5.model, var_333bdea5.origin, var_333bdea5.angles);
            if (!isdefined(level.var_4991a9d2)) {
                level.var_4991a9d2 = [];
            } else if (!isarray(level.var_4991a9d2)) {
                level.var_4991a9d2 = array(level.var_4991a9d2);
            }
            if (!isinarray(level.var_4991a9d2, var_fe6dc4c3)) {
                level.var_4991a9d2[level.var_4991a9d2.size] = var_fe6dc4c3;
            }
            if (isdefined(var_333bdea5.scale)) {
                var_fe6dc4c3 setscale(var_333bdea5.scale);
            }
        }
    }
    showmiscmodels("bridge_controls");
}

// Namespace zodt8_sentinel/zm_zodt8_sentinel_trial
// Params 3, eflags: 0x0
// Checksum 0x949681bf, Offset: 0x2c20
// Size: 0x314
function function_22b76a7c(var_440637ef, var_9d31c33d, var_54e0dc2f) {
    n_angle = -30 * var_440637ef;
    self rotateroll(n_angle + var_9d31c33d, 0.5 * var_440637ef + var_54e0dc2f);
    self waittill(#"rotatedone");
    var_f94f5c08 = combineangles(-1 * self.original_angles, self.angles);
    for (var_9d98607a = var_f94f5c08[2]; var_9d98607a >= 0; var_9d98607a -= 360) {
    }
    while (var_9d98607a < -360) {
        var_9d98607a += 360;
    }
    if (var_9d98607a > n_angle + 10 || var_9d98607a < n_angle - 10) {
        /#
            if (getdvarint(#"hash_7919e37cd5d57659", 0)) {
                iprintlnbold("<dev string:x7c>" + self.script_zone + "<dev string:x99>" + self.targetname);
                println("<dev string:x7c>" + self.script_zone + "<dev string:x99>" + self.targetname);
            }
        #/
        /#
            if (getdvarint(#"hash_7919e37cd5d57659", 0)) {
                iprintlnbold("<dev string:x9c>" + var_440637ef + "<dev string:xb1>");
                println("<dev string:x9c>" + var_440637ef + "<dev string:xb1>");
            }
        #/
        /#
            if (getdvarint(#"hash_7919e37cd5d57659", 0)) {
                iprintlnbold("<dev string:xba>" + var_9d98607a / -30 + "<dev string:xb1>");
                println("<dev string:xba>" + var_9d98607a / -30 + "<dev string:xb1>");
            }
        #/
        self.angles = self.original_angles;
        self rotateroll(n_angle, 0.1);
    }
}

// Namespace zodt8_sentinel/zm_zodt8_sentinel_trial
// Params 3, eflags: 0x0
// Checksum 0x7c42e589, Offset: 0x2f40
// Size: 0x26e
function function_52e17c68(s_telegraph, var_91901186 = undefined, var_440637ef = undefined) {
    if (!isdefined(var_91901186)) {
        var_91901186 = s_telegraph.var_91901186;
    }
    if (s_telegraph.var_e6b206fb == 11) {
        if (!isdefined(var_440637ef)) {
            var_440637ef = randomintrangeinclusive(1, 10);
        }
        if (var_440637ef >= min(var_91901186, 6)) {
            var_440637ef += 1;
        }
        if (var_440637ef >= max(var_91901186, 6)) {
            var_440637ef += 1;
        }
    } else if (s_telegraph.var_e6b206fb == 7) {
        if (!isdefined(var_440637ef)) {
            var_440637ef = randomintrangeinclusive(1, 6);
        }
        if (var_440637ef >= 4 || var_440637ef >= var_91901186) {
            if (var_91901186 <= 4) {
                var_440637ef += 1;
                if (var_440637ef >= 4) {
                    var_440637ef += 5;
                }
            } else {
                var_440637ef += 5;
                if (var_440637ef >= var_91901186) {
                    var_440637ef += 1;
                }
            }
        }
    } else if (s_telegraph.var_e6b206fb == 5) {
        if (!isdefined(var_440637ef)) {
            var_440637ef = randomintrangeinclusive(1, 4);
        }
        if (var_440637ef >= 3 || var_440637ef >= var_91901186) {
            if (var_91901186 <= 3) {
                var_440637ef += 1;
                if (var_440637ef >= 3) {
                    var_440637ef += 7;
                }
            } else {
                var_440637ef += 7;
                if (var_440637ef >= var_91901186) {
                    var_440637ef += 1;
                }
            }
        }
    }
    return var_440637ef;
}

/#

    // Namespace zodt8_sentinel/zm_zodt8_sentinel_trial
    // Params 1, eflags: 0x4
    // Checksum 0xdf7c358b, Offset: 0x31b8
    // Size: 0x2d4
    function private function_f7fba466(str_script_noteworthy) {
        s_telegraph = struct::get(str_script_noteworthy, "<dev string:xc8>");
        println("<dev string:xda>");
        println(s_telegraph.script_noteworthy);
        for (i = 1; i <= 12; i++) {
            if (s_telegraph.var_e6b206fb == 11 && (i < 6 || i > 6)) {
                for (j = 1; j <= 10; j++) {
                    s_telegraph.var_440637ef = function_52e17c68(s_telegraph, i, j);
                    print(s_telegraph.var_440637ef + "<dev string:xda>");
                }
                println("<dev string:xda>");
                continue;
            }
            if (s_telegraph.var_e6b206fb == 7 && (i < 4 || i > 8)) {
                for (j = 1; j <= 6; j++) {
                    s_telegraph.var_440637ef = function_52e17c68(s_telegraph, i, j);
                    print(s_telegraph.var_440637ef + "<dev string:xda>");
                }
                println("<dev string:xda>");
                continue;
            }
            if (s_telegraph.var_e6b206fb == 5 && (i < 3 || i > 9)) {
                for (j = 1; j <= 4; j++) {
                    s_telegraph.var_440637ef = function_52e17c68(s_telegraph, i, j);
                    print(s_telegraph.var_440637ef + "<dev string:xda>");
                }
                println("<dev string:xda>");
            }
        }
        println("<dev string:xda>");
    }

#/

// Namespace zodt8_sentinel/zm_zodt8_sentinel_trial
// Params 0, eflags: 0x0
// Checksum 0xcee59666, Offset: 0x3498
// Size: 0x84
function function_58f9bff4() {
    level endon(#"hash_2d1cd18f39ac5fa7", #"end_game");
    self endon(#"death");
    function_3d250f19(self, self.stub.related_parent.usetime);
    self zm_unitrigger::function_d59c1914();
}

// Namespace zodt8_sentinel/zm_zodt8_sentinel_trial
// Params 0, eflags: 0x0
// Checksum 0xfa42da0, Offset: 0x3528
// Size: 0x834
function function_a16d48ce() {
    level endon(#"hash_2d1cd18f39ac5fa7", #"end_game");
    self.var_91901186 = 12;
    if (isdefined(self.var_fc4f6549)) {
        self.var_dfcaefa6 = getent(self.var_fc4f6549, "script_noteworthy");
    } else {
        assertmsg("<dev string:xdc>" + self.script_noteworthy);
    }
    if (isdefined(self.var_99264ebd)) {
        self.var_3eba8010 = getent(self.var_99264ebd, "script_noteworthy");
    }
    if (isdefined(self.var_7dd6dece)) {
        self.var_badda601 = getent(self.var_7dd6dece, "script_noteworthy");
    } else {
        assertmsg("<dev string:x10e>" + self.script_noteworthy);
    }
    if (isdefined(self.var_c785aba8)) {
        self.var_ca966b65 = getent(self.var_c785aba8, "script_noteworthy");
    }
    var_6e0b5d99 = struct::get(self.var_e5027e1e, "script_noteworthy");
    a_s_telegraphs = struct::get_array(#"s_telegraph");
    a_mdl_symbols = getentarray(self.var_75cde0f3, "script_noteworthy");
    if (self.script_noteworthy === #"hash_5db5a7e2cb1cab66" || self.script_noteworthy === #"hash_3f671b17f96b861a") {
        self thread function_f83c2a2d();
    }
    while (true) {
        waitresult = self waittill(#"trigger_activated");
        if (waitresult.e_who function_3d700ed3(self)) {
            var_a938ccef = 1;
            var_c1869f9a = waitresult.e_who function_151adef6(self, self.var_dfcaefa6);
        } else {
            var_a938ccef = 0;
            var_c1869f9a = waitresult.e_who function_151adef6(self, self.var_3eba8010);
        }
        if (var_a938ccef && var_c1869f9a || !var_a938ccef && !var_c1869f9a) {
            var_6750fcb6 = self function_36e21e23(1);
        } else {
            var_6750fcb6 = self function_36e21e23(0);
        }
        if (var_6750fcb6 != 0) {
            var_6e0b5d99.var_badda601 rotatepitch(var_6750fcb6, 0.1);
            var_6e0b5d99.var_badda601 playsound(#"hash_27a4629b68e4d58f");
            if (isdefined(var_6e0b5d99.var_ca966b65)) {
                var_6e0b5d99.var_ca966b65 rotatepitch(-1 * var_6750fcb6, 0.1);
            }
            self.var_dfcaefa6 rotatepitch(var_6750fcb6, 0.1);
            self.var_dfcaefa6 playsound(#"hash_7bc6c78f3cf8d7da");
            if (isdefined(self.var_3eba8010)) {
                self.var_3eba8010 rotatepitch(-1 * var_6750fcb6, 0.1);
            }
            self.var_dfcaefa6 waittill(#"rotatedone");
            /#
                if (getdvarint(#"zm_debug_ee", 0)) {
                    if (isdefined(self.var_440637ef)) {
                        print3d(self.origin + anglestoright(self.angles) * 24, "<dev string:x142>" + self.var_440637ef, (1, 1, 0), 1, 0.25, 100);
                    }
                }
            #/
            if (isdefined(self.var_440637ef)) {
                if (self.var_91901186 == self.var_440637ef) {
                    self flag::set_val(self.script_flag, 1);
                    if (var_6e0b5d99 flag::get(var_6e0b5d99.script_flag)) {
                        foreach (mdl_symbol in a_mdl_symbols) {
                            mdl_symbol flag::set_val(mdl_symbol.script_flag, 1);
                        }
                    }
                    var_3a37d26a = 1;
                    foreach (s_telegraph in a_s_telegraphs) {
                        if (s_telegraph flag::get(s_telegraph.script_flag) == 0) {
                            var_3a37d26a = 0;
                            break;
                        }
                    }
                    if (var_3a37d26a) {
                        level flag::set(#"hash_2d1cd18f39ac5fa7");
                    } else {
                        /#
                            if (getdvarint(#"hash_7919e37cd5d57659", 0)) {
                                iprintlnbold("<dev string:x14f>" + self.script_noteworthy);
                                println("<dev string:x14f>" + self.script_noteworthy);
                            }
                        #/
                    }
                    continue;
                }
                if (self flag::get(self.script_flag)) {
                    self flag::set_val(self.script_flag, 0);
                    if (var_6e0b5d99 flag::get(var_6e0b5d99.script_flag)) {
                        foreach (mdl_symbol in a_mdl_symbols) {
                            mdl_symbol flag::set_val(mdl_symbol.script_flag, 0);
                        }
                    }
                }
            }
        }
    }
}

// Namespace zodt8_sentinel/zm_zodt8_sentinel_trial
// Params 0, eflags: 0x0
// Checksum 0x90a25a0b, Offset: 0x3d68
// Size: 0x31a
function function_f83c2a2d() {
    level flagsys::wait_till(#"power_on");
    zm_unitrigger::unregister_unitrigger(self.s_unitrigger);
    var_ceb9c0dc = scene::get_inactive_scenes(#"p8_fxanim_zm_zod_sentinel_chaos_bundle");
    var_38d31e7c = var_ceb9c0dc[0];
    var_602c157c = var_38d31e7c.scene_ents[#"prop 3"];
    var_d2822b0b = self.script_noteworthy === #"hash_5db5a7e2cb1cab66" ? "chaos_tops_left_jnt" : "chaos_tops_right_jnt";
    self.var_badda601.var_c1757528 = self.var_badda601.angles;
    self.var_ca966b65.var_c1757528 = self.var_ca966b65.angles;
    self.var_dfcaefa6.var_c1757528 = self.var_dfcaefa6.angles;
    self.var_3eba8010.var_c1757528 = self.var_3eba8010.angles;
    self.var_badda601 linkto(var_602c157c, var_d2822b0b);
    self.var_ca966b65 linkto(var_602c157c, var_d2822b0b);
    self.var_dfcaefa6 linkto(var_602c157c, var_d2822b0b);
    self.var_3eba8010 linkto(var_602c157c, var_d2822b0b);
    level waittill(#"hash_332f0f61c1829f65");
    zm_unitrigger::register_static_unitrigger(self.s_unitrigger, &function_58f9bff4);
    zm_unitrigger::function_7fcb11a8(self.s_unitrigger, 1);
    self.var_badda601 unlink();
    self.var_ca966b65 unlink();
    self.var_dfcaefa6 unlink();
    self.var_3eba8010 unlink();
    self.var_badda601.angles = self.var_badda601.var_c1757528;
    self.var_ca966b65.angles = self.var_ca966b65.var_c1757528;
    self.var_dfcaefa6.angles = self.var_dfcaefa6.var_c1757528;
    self.var_3eba8010.angles = self.var_3eba8010.var_c1757528;
}

// Namespace zodt8_sentinel/zm_zodt8_sentinel_trial
// Params 1, eflags: 0x0
// Checksum 0x2a93fe9, Offset: 0x4090
// Size: 0xa8
function function_3d700ed3(s_telegraph) {
    if (!isdefined(s_telegraph.var_3eba8010)) {
        return 1;
    }
    v_delta = vectornormalize(self.origin - s_telegraph.origin);
    v_facing = anglestoforward(s_telegraph.angles);
    if (vectordot(v_delta, v_facing) >= 0) {
        return 1;
    }
    return 0;
}

// Namespace zodt8_sentinel/zm_zodt8_sentinel_trial
// Params 2, eflags: 0x0
// Checksum 0x6fc225e, Offset: 0x4140
// Size: 0x1c6
function function_151adef6(s_telegraph, var_dfcaefa6) {
    v_delta = vectornormalize(var_dfcaefa6.origin - self geteye());
    v_view = anglestoforward(self getplayerangles());
    v_cross = vectorcross(v_view, v_delta);
    var_720577e5 = vectordot(v_cross, anglestoup(var_dfcaefa6.angles));
    var_41211938 = vectordot(v_cross, (0, 0, 1));
    if (s_telegraph.var_91901186 < 6) {
        if (var_720577e5 >= 0 && var_41211938 >= 0) {
            return 1;
        } else {
            return 0;
        }
        return;
    }
    if (s_telegraph.var_91901186 > 6 && s_telegraph.var_91901186 < 12) {
        if (var_720577e5 <= 0 && var_41211938 <= 0) {
            return 0;
        } else {
            return 1;
        }
        return;
    }
    if (var_720577e5 >= 0) {
        return 1;
    }
    return 0;
}

// Namespace zodt8_sentinel/zm_zodt8_sentinel_trial
// Params 1, eflags: 0x0
// Checksum 0x69e1cf7d, Offset: 0x4310
// Size: 0x796
function function_36e21e23(b_clockwise) {
    if (b_clockwise) {
        if (self.var_e6b206fb == 11) {
            switch (self.var_91901186) {
            case 12:
                var_6750fcb6 = 23.75;
                self.var_91901186 = 1;
                break;
            case 1:
            case 2:
            case 3:
            case 4:
            case 7:
            case 8:
            case 9:
            case 10:
            case 11:
                var_6750fcb6 = 23.75;
                self.var_91901186 += 1;
                break;
            case 5:
                var_6750fcb6 = 0;
                break;
            default:
                assertmsg("<dev string:x169>" + self.var_91901186);
                break;
            }
        } else if (self.var_e6b206fb == 7) {
            switch (self.var_91901186) {
            case 12:
                var_6750fcb6 = 34.25;
                self.var_91901186 = 1;
                break;
            case 1:
            case 2:
            case 9:
            case 10:
            case 11:
                var_6750fcb6 = 34.25;
                self.var_91901186 += 1;
                break;
            case 3:
                var_6750fcb6 = 0;
                break;
            default:
                assertmsg("<dev string:x169>" + self.var_91901186);
                break;
            }
        } else if (self.var_e6b206fb == 5) {
            switch (self.var_91901186) {
            case 12:
                var_6750fcb6 = 33.5;
                self.var_91901186 = 1;
                break;
            case 1:
            case 10:
            case 11:
                var_6750fcb6 = 33.5;
                self.var_91901186 += 1;
                break;
            case 2:
                var_6750fcb6 = 0;
                break;
            default:
                assertmsg("<dev string:x169>" + self.var_91901186);
                break;
            }
        }
    } else if (self.var_e6b206fb == 11) {
        switch (self.var_91901186) {
        case 1:
            var_6750fcb6 = 23.75 * -1;
            self.var_91901186 = 12;
            break;
        case 2:
        case 3:
        case 4:
        case 5:
        case 8:
        case 9:
        case 10:
        case 11:
        case 12:
            var_6750fcb6 = 23.75 * -1;
            self.var_91901186 -= 1;
            break;
        case 7:
            var_6750fcb6 = 0;
            break;
        default:
            assertmsg("<dev string:x169>" + self.var_91901186);
            break;
        }
    } else if (self.var_e6b206fb == 7) {
        switch (self.var_91901186) {
        case 1:
            var_6750fcb6 = 34.25 * -1;
            self.var_91901186 = 12;
            break;
        case 2:
        case 3:
        case 10:
        case 11:
        case 12:
            var_6750fcb6 = 34.25 * -1;
            self.var_91901186 -= 1;
            break;
        case 9:
            var_6750fcb6 = 0;
            break;
        default:
            assertmsg("<dev string:x169>" + self.var_91901186);
            break;
        }
    } else if (self.var_e6b206fb == 5) {
        switch (self.var_91901186) {
        case 1:
            var_6750fcb6 = 33.5 * -1;
            self.var_91901186 = 12;
            break;
        case 2:
        case 11:
        case 12:
            var_6750fcb6 = 33.5 * -1;
            self.var_91901186 -= 1;
            break;
        case 10:
            var_6750fcb6 = 0;
            break;
        default:
            assertmsg("<dev string:x169>" + self.var_91901186);
            break;
        }
    }
    return var_6750fcb6;
}

// Namespace zodt8_sentinel/zm_zodt8_sentinel_trial
// Params 1, eflags: 0x0
// Checksum 0xf88014a4, Offset: 0x4ab0
// Size: 0xb4
function function_3abe93b1(var_758116d) {
    level zm_ui_inventory::function_31a39683(#"zm_zodt8_sentinel_trial", 4);
    function_ef1b6a8();
    /#
        if (getdvarint(#"hash_7919e37cd5d57659", 0)) {
            gear_up(1, 0);
        }
    #/
    if (!var_758116d) {
        level thread function_95c45d2c();
        function_3c4601fb();
    }
}

// Namespace zodt8_sentinel/zm_zodt8_sentinel_trial
// Params 2, eflags: 0x0
// Checksum 0x2ad0e354, Offset: 0x4b70
// Size: 0x24c
function function_e0a92ca(var_758116d, ended_early) {
    level flag::set(#"catalyst_encounters_completed");
    level flag::set(#"hash_65e37079e0d22d47");
    level.var_9871cdf5 = undefined;
    level.var_6aa69b24 = undefined;
    if (!var_758116d) {
        playsoundatposition(#"hash_e0f3475083dde68", (0, 0, 0));
    }
    /#
        if (var_758116d || ended_early) {
            foreach (player in util::get_players()) {
                player thread function_8572be87();
            }
            callback::on_spawned(&function_8572be87);
            hidemiscmodels("<dev string:x184>");
            showmiscmodels("<dev string:x18e>");
        }
        if (ended_early) {
            zm_sq_modules::function_c39c525(#"hash_41a5c5168ffb2a97");
            zm_sq_modules::function_c39c525(#"hash_400a481490a4e390");
            zm_sq_modules::function_c39c525(#"hash_5562e324d230f057");
            zm_sq_modules::function_c39c525(#"hash_41fae186552f1259");
            level notify(#"hash_7b7d380d73a2ba58");
        }
    #/
    exploder::exploder("exp_lgt_boiler_overheat");
    exploder::exploder("exp_boiler_overheat");
}

// Namespace zodt8_sentinel/zm_zodt8_sentinel_trial
// Params 0, eflags: 0x0
// Checksum 0x5ffc6761, Offset: 0x4dc8
// Size: 0x1cc
function function_ef1b6a8() {
    sp_catalyst = getent("zombie_spawn_1", "script_string");
    zm_transform::function_17652056(sp_catalyst, #"transform1", &zm_ai_utility::function_4f5236d3, 0, undefined, &function_fa3a18b0, "aib_vign_zm_zod_catalyst_corrosive_spawn_pre_split", "aib_vign_zm_zod_catalyst_corrosive_spawn_post_split");
    sp_catalyst = getent("zombie_spawn_2", "script_string");
    zm_transform::function_17652056(sp_catalyst, #"transform2", &zm_ai_utility::function_4f5236d3, 0, undefined, &function_fa3a18b0, "aib_vign_zm_zod_catalyst_water_spawn_pre_split", "aib_vign_zm_zod_catalyst_water_spawn_post_split");
    sp_catalyst = getent("zombie_spawn_3", "script_string");
    zm_transform::function_17652056(sp_catalyst, #"transform3", &zm_ai_utility::function_4f5236d3, 0, undefined, &function_fa3a18b0, "aib_vign_zm_zod_catalyst_electric_spawn_pre_split", "aib_vign_zm_zod_catalyst_electric_spawn_post_split");
    sp_catalyst = getent("zombie_spawn_4", "script_string");
    zm_transform::function_17652056(sp_catalyst, #"transform4", &zm_ai_utility::function_4f5236d3, 0, undefined, &function_fa3a18b0, "aib_vign_zm_zod_catalyst_plasma_spawn_pre_split", "aib_vign_zm_zod_catalyst_plasma_spawn_post_split");
}

// Namespace zodt8_sentinel/zm_zodt8_sentinel_trial
// Params 0, eflags: 0x0
// Checksum 0xc610e7b7, Offset: 0x4fa0
// Size: 0x2c8
function function_95c45d2c() {
    while (zm_round_logic::get_round_number() < 9) {
        level waittill(#"start_of_round");
    }
    a_str_ids = array(#"transform1", #"transform2", #"transform3", #"transform4", #"transform1", #"transform2", #"transform3", #"transform4");
    while (!level flag::get(#"catalyst_encounters_completed")) {
        if (!zm_round_spawning::function_f172115b("stoker") && isdefined(level.var_ae2b7a0b) && level.var_ae2b7a0b.size == 1) {
            level waittill(#"hash_5d3012139f083ccb");
            waitframe(1);
            continue;
        }
        n_round = zm_round_logic::get_round_number();
        var_250ca60f = array::randomize(a_str_ids);
        for (i = 0; i < 3; i++) {
            var_250ca60f = array::remove_index(var_250ca60f, 0);
        }
        foreach (str_id in var_250ca60f) {
            wait randomintrange(11, 22);
            if (level flag::get(#"hash_7a31252c7c941976")) {
                break;
            }
            zm_transform::function_5dbbf742(str_id);
        }
        if (n_round == zm_round_logic::get_round_number()) {
            level waittill(#"start_of_round");
        }
    }
}

// Namespace zodt8_sentinel/zm_zodt8_sentinel_trial
// Params 0, eflags: 0x0
// Checksum 0xe7d99684, Offset: 0x5270
// Size: 0x5dc
function function_3c4601fb() {
    /#
        level endon(#"hash_7b7d380d73a2ba58");
    #/
    a_flags = array(#"hash_515a88d1cbabc18e", #"hash_1322dd3a3d7411a5", #"hash_2f5be8d749b4e88e", #"hash_33a5d8dd1204080e");
    while (true) {
        foreach (s_spark in level.a_s_sparks) {
            level thread function_83f8b25e(s_spark);
            zm_sq_modules::function_b4f7eda8(s_spark.script_noteworthy);
        }
        foreach (str_flag in a_flags) {
            level flag::clear(str_flag);
        }
        s_result = level flag::wait_till_any(a_flags);
        if (s_result._notify !== #"hash_515a88d1cbabc18e") {
            function_18eb2195(0);
            continue;
        }
        level flag::set(#"hash_652ae68711aa37c1");
        level flag::clear(#"hash_515a88d1cbabc18e");
        function_18eb2195();
        s_result = level flag::wait_till_any(a_flags);
        if (s_result._notify !== #"hash_1322dd3a3d7411a5") {
            function_18eb2195(0);
            continue;
        }
        level flag::set(#"hash_63ebf7fc2afa76ea");
        level flag::clear(#"hash_1322dd3a3d7411a5");
        function_18eb2195();
        s_result = level flag::wait_till_any(a_flags);
        if (s_result._notify !== #"hash_2f5be8d749b4e88e") {
            function_18eb2195(0);
            continue;
        }
        level flag::set(#"hash_70eb07a177cf8881");
        level flag::clear(#"hash_2f5be8d749b4e88e");
        function_18eb2195();
        if (!level flag::get(#"water_drained_aft")) {
            level thread zm_zodt8::change_water_height_aft(1);
            level notify(#"hash_47d532bd5a3fa1f5");
        }
        s_result = level flag::wait_till_any(a_flags);
        if (s_result._notify !== #"hash_33a5d8dd1204080e") {
            function_18eb2195(0);
            continue;
        }
        level flag::set(#"hash_65e37079e0d22d47");
        level flag::clear(#"hash_33a5d8dd1204080e");
        hidemiscmodels("coal_cold");
        hidemiscmodels("coal_warm");
        showmiscmodels("coal_hot");
        foreach (player in util::get_players()) {
            player util::delay(3.5, "death", &function_8572be87);
        }
        callback::on_spawned(&function_8572be87);
        function_18eb2195();
        level flag::wait_till(#"hash_3e80d503318a5674");
        level flag::set(#"catalyst_encounters_completed");
        break;
    }
}

// Namespace zodt8_sentinel/zm_zodt8_sentinel_trial
// Params 1, eflags: 0x0
// Checksum 0x8ecf423e, Offset: 0x5858
// Size: 0x84
function function_18eb2195(b_success = 1) {
    wait 3;
    music::setmusicstate("none");
    level.musicsystemoverride = 0;
    function_c5097b43(b_success);
    wait 5;
    if (b_success) {
        wait 5;
    }
    function_f51f256c();
}

// Namespace zodt8_sentinel/zm_zodt8_sentinel_trial
// Params 1, eflags: 0x0
// Checksum 0x8ee0609c, Offset: 0x58e8
// Size: 0x1ee
function function_83f8b25e(s_spark) {
    s_spark notify(#"hash_20b1bfb7761ba3a2");
    s_spark endon(#"hash_20b1bfb7761ba3a2");
    level endon(s_spark.script_noteworthy + "_completed");
    str_alias = #"hash_73169d47085b2d";
    switch (s_spark.script_noteworthy) {
    case #"hash_41a5c5168ffb2a97":
        str_alias = #"hash_73169d47085b2d";
        break;
    case #"hash_400a481490a4e390":
        str_alias = #"hash_3b2c49194741ffda";
        break;
    case #"hash_5562e324d230f057":
        str_alias = #"hash_3e9d8c755fa909a5";
        break;
    case #"hash_41fae186552f1259":
        str_alias = #"hash_3d879b8999812127";
        break;
    }
    while (!level flag::get(#"catalyst_encounters_completed")) {
        if (!level flag::get(#"hash_27a2746eb30e61c") && s_spark.var_7a783ef2 !== 1) {
            fx::play(s_spark.script_noteworthy, s_spark.origin, s_spark.angles, 1.5);
            playsoundatposition(str_alias, s_spark.origin);
        }
        wait 4;
    }
}

// Namespace zodt8_sentinel/zm_zodt8_sentinel_trial
// Params 2, eflags: 0x0
// Checksum 0xeffc9fdd, Offset: 0x5ae0
// Size: 0x156
function function_7098b55f(s_struct, ai_killed) {
    if (level flag::get(#"hash_27a2746eb30e61c")) {
        return false;
    }
    switch (s_struct.script_noteworthy) {
    case #"hash_41a5c5168ffb2a97":
        if (ai_killed.catalyst_type === 1) {
            break;
        }
        return false;
    case #"hash_400a481490a4e390":
        if (ai_killed.catalyst_type === 4) {
            break;
        }
        return false;
    case #"hash_5562e324d230f057":
        if (ai_killed.catalyst_type === 3) {
            break;
        }
        return false;
    case #"hash_41fae186552f1259":
        if (ai_killed.catalyst_type === 2) {
            break;
        }
        return false;
    }
    e_volume = getent(s_struct.target, "targetname");
    if (ai_killed istouching(e_volume)) {
        return true;
    }
    return false;
}

// Namespace zodt8_sentinel/zm_zodt8_sentinel_trial
// Params 2, eflags: 0x0
// Checksum 0xe8cd26f5, Offset: 0x5c40
// Size: 0x2c
function function_afec37f7(s_struct, ai_killed) {
    level thread function_988b28c1(s_struct);
}

// Namespace zodt8_sentinel/zm_zodt8_sentinel_trial
// Params 1, eflags: 0x0
// Checksum 0x29f8bce7, Offset: 0x5c78
// Size: 0x12c
function function_988b28c1(s_struct) {
    zm_sq_modules::function_c39c525(s_struct.script_noteworthy);
    level flag::set(#"hash_27a2746eb30e61c");
    util::delay("end_of_round", undefined, &flag::clear, #"hash_27a2746eb30e61c");
    s_portal = struct::get(s_struct.target);
    streamermodelhint(#"p8_zm_zod_teleport_symbol", 10);
    streamermodelhint(#"hash_15e8ba772c745d63", 10);
    wait 3;
    level thread function_4b4c52d6(s_struct, s_portal);
    level thread function_887a0b10(s_struct, s_portal);
}

// Namespace zodt8_sentinel/zm_zodt8_sentinel_trial
// Params 2, eflags: 0x0
// Checksum 0x60720f0a, Offset: 0x5db0
// Size: 0x214
function function_4b4c52d6(s_struct, s_portal) {
    s_struct.var_7a783ef2 = 1;
    v_offset = (0, 0, 2);
    n_scale = 0.1;
    s_portal.mdl_portal = util::spawn_model(#"hash_15e8ba772c745d63", s_portal.origin + v_offset, s_portal.angles);
    s_portal.mdl_portal playsound(#"hash_2333d58ae8bcec49");
    s_portal.mdl_portal playloopsound(#"hash_7519aa807bfee90f");
    while (n_scale < 1) {
        s_portal.mdl_portal setscale(n_scale);
        wait 0.1;
        n_scale += 0.05;
    }
    s_portal.mdl_portal bobbing((0, 0, 1), 0.5, 5);
    s_portal.mdl_portal.var_2638ea5e = 1;
    level thread function_4e5ced81(s_portal.origin, #"hash_19fca744d8d369fa");
    while (s_struct.var_7a783ef2 == 1) {
        wait 2;
    }
    s_portal.mdl_portal stoploopsound();
    s_portal.mdl_portal playsound(#"hash_10ab4113bd828143");
    s_portal.mdl_portal delete();
}

// Namespace zodt8_sentinel/zm_zodt8_sentinel_trial
// Params 2, eflags: 0x0
// Checksum 0xf652f9d8, Offset: 0x5fd0
// Size: 0x41c
function function_887a0b10(s_struct, s_portal) {
    s_portal function_745d78b(64);
    if (!level flag::get(#"hash_3e80d503318a5674")) {
        level thread function_887a0b10(s_struct, s_portal);
        return;
    }
    s_struct.var_7a783ef2 = 0;
    level flag::clear("spawn_zombies");
    level flag::clear("zombie_drop_powerups");
    level flag::set(#"hash_7a31252c7c941976");
    level flag::set(#"disable_fast_travel");
    level flag::set(#"pause_round_timeout");
    zm_transform::function_204b0737();
    level.var_9871cdf5 = 0;
    level.zm_bgb_anywhere_but_here_validation_override = &return_false;
    level clientfield::set("fasttravel_exploder", 0);
    level thread function_d6d7f516(s_struct.script_noteworthy, s_portal);
    level waittill(#"hash_332a98e65f5dce4");
    function_38d7e7b5(s_struct.script_noteworthy, 1);
    s_powerup = struct::get(s_struct.script_noteworthy, "script_powerup");
    if (level.var_6aa69b24 !== 1) {
        if (isdefined(s_powerup)) {
            powerup = zm_powerups::specific_powerup_drop("full_ammo", s_powerup.origin, undefined, undefined, undefined, 1);
            level.var_6aa69b24 = 1;
        }
    } else {
        level.var_6aa69b24 = 0;
    }
    function_116a741();
    level.musicsystemoverride = 1;
    music::setmusicstate("quest_catalyst_portals");
    switch (s_struct.script_noteworthy) {
    case #"hash_41a5c5168ffb2a97":
        level thread function_adb25a15("earth");
        function_5d990b6b();
        break;
    case #"hash_400a481490a4e390":
        level thread function_adb25a15("water");
        function_10af967a();
        break;
    case #"hash_5562e324d230f057":
        level thread function_adb25a15("air");
        function_cd578c23();
        break;
    case #"hash_41fae186552f1259":
        level thread function_adb25a15("fire");
        function_cbbe64c1();
        break;
    }
    if (isdefined(powerup)) {
        powerup thread zm_powerups::powerup_timeout();
    }
    wait 2.5;
    level.zm_bgb_anywhere_but_here_validation_override = &zm_zodt8::function_869d6f66;
    function_38d7e7b5(s_struct.script_noteworthy, 0);
}

// Namespace zodt8_sentinel/zm_zodt8_sentinel_trial
// Params 0, eflags: 0x0
// Checksum 0xd9e73618, Offset: 0x63f8
// Size: 0x6
function return_false() {
    return false;
}

// Namespace zodt8_sentinel/zm_zodt8_sentinel_trial
// Params 0, eflags: 0x0
// Checksum 0x93d8ba4e, Offset: 0x6408
// Size: 0xc4
function function_f51f256c() {
    level flag::set("spawn_zombies");
    level flag::set("zombie_drop_powerups");
    level flag::clear(#"hash_7a31252c7c941976");
    level flag::clear(#"disable_fast_travel");
    level flag::clear(#"pause_round_timeout");
    level clientfield::set("fasttravel_exploder", 1);
}

// Namespace zodt8_sentinel/zm_zodt8_sentinel_trial
// Params 2, eflags: 0x0
// Checksum 0x73f51980, Offset: 0x64d8
// Size: 0x52e
function function_38d7e7b5(var_556a0d53, b_solid) {
    switch (var_556a0d53) {
    case #"hash_41a5c5168ffb2a97":
        str_blocker = "loc1";
        break;
    case #"hash_400a481490a4e390":
        str_blocker = "loc2";
        break;
    case #"hash_5562e324d230f057":
        str_blocker = "loc3";
        break;
    case #"hash_41fae186552f1259":
        str_blocker = "loc4";
        break;
    }
    a_blockers = getentarray(str_blocker, "script_blocker");
    foreach (e_blocker in a_blockers) {
        if (b_solid) {
            e_blocker solid();
            e_blocker show();
            if (isdefined(e_blocker.var_ce0c68db)) {
                v_angles = e_blocker.var_ce0c68db;
            } else {
                v_angles = (0, 0, 0);
            }
            mdl_fx = util::spawn_model(#"p8_zm_power_door_symbol_01", e_blocker.origin, v_angles);
            mdl_fx.objectid = "symbol_front_power";
            mdl_fx clientfield::set("" + #"blocker_fx", 1);
            e_blocker.a_mdl_fx = [];
            if (!isdefined(e_blocker.a_mdl_fx)) {
                e_blocker.a_mdl_fx = [];
            } else if (!isarray(e_blocker.a_mdl_fx)) {
                e_blocker.a_mdl_fx = array(e_blocker.a_mdl_fx);
            }
            e_blocker.a_mdl_fx[e_blocker.a_mdl_fx.size] = mdl_fx;
            a_s_fx = struct::get_array(str_blocker, "script_blocker_fx");
            foreach (s_fx in a_s_fx) {
                mdl_fx = util::spawn_model(#"p8_zm_power_door_symbol_01", s_fx.origin, s_fx.angles);
                mdl_fx.objectid = "symbol_front_power";
                mdl_fx clientfield::set("" + #"blocker_fx", 1);
                if (!isdefined(e_blocker.a_mdl_fx)) {
                    e_blocker.a_mdl_fx = [];
                } else if (!isarray(e_blocker.a_mdl_fx)) {
                    e_blocker.a_mdl_fx = array(e_blocker.a_mdl_fx);
                }
                e_blocker.a_mdl_fx[e_blocker.a_mdl_fx.size] = mdl_fx;
            }
            continue;
        }
        e_blocker notsolid();
        e_blocker hide();
        if (isdefined(e_blocker.a_mdl_fx)) {
            foreach (mdl_fx in e_blocker.a_mdl_fx) {
                mdl_fx thread function_e776d4af();
                mdl_fx clientfield::set("" + #"blocker_fx", 0);
            }
            e_blocker.a_mdl_fx = undefined;
        }
    }
}

// Namespace zodt8_sentinel/zm_zodt8_sentinel_trial
// Params 0, eflags: 0x0
// Checksum 0xb9cd2a10, Offset: 0x6a10
// Size: 0x7c
function function_e776d4af() {
    self clientfield::set("doorbuy_bought_fx", 1);
    util::wait_network_frame();
    self clientfield::set("doorbuy_ambient_fx", 0);
    util::wait_network_frame();
    self delete();
}

// Namespace zodt8_sentinel/zm_zodt8_sentinel_trial
// Params 0, eflags: 0x0
// Checksum 0xa7529611, Offset: 0x6a98
// Size: 0x2fc
function function_5d990b6b() {
    wait 2.5;
    n_players = util::get_active_players().size;
    var_83d2b573 = (26 + n_players * 12) / 3;
    n_spawn_delay = 1.25 / n_players;
    n_max_zombies = 12 + n_players * 3;
    a_spawnpoints = struct::get_array(#"hash_62b6792c95a50741");
    function_743ed9f(a_spawnpoints, var_83d2b573, undefined, 20, #"transform1", n_spawn_delay);
    level thread spawn_blightfather();
    function_743ed9f(a_spawnpoints, var_83d2b573, undefined, 20 + 5, #"transform1", n_spawn_delay / 2);
    wait 8 / n_players;
    spawner = array::random(level.zombie_spawners);
    a_spawnpoints = array::randomize(struct::get_array(#"hash_7b568aaabdad38ae"));
    n_players = util::get_active_players().size;
    var_b75b77ef = 12 / n_players;
    var_f4e3daa = 0;
    var_52f6f94c = 0;
    for (i = 0; i < n_players; i++) {
        ai_blightfather = spawn_blightfather();
        if (isdefined(ai_blightfather)) {
            if (!var_52f6f94c) {
                var_52f6f94c = 1;
                level thread function_743ed9f(a_spawnpoints, var_83d2b573, undefined, 20, #"transform1", n_spawn_delay);
            }
            var_f4e3daa++;
            ai_blightfather waittilltimeout(var_b75b77ef * var_f4e3daa, #"death");
        }
    }
    level notify(#"hash_215a84542b11208c");
    function_f424b9bc();
    level flag::set(#"hash_515a88d1cbabc18e");
}

// Namespace zodt8_sentinel/zm_zodt8_sentinel_trial
// Params 0, eflags: 0x0
// Checksum 0x257201f0, Offset: 0x6da0
// Size: 0x27c
function function_10af967a() {
    wait 5;
    if (level flag::get("water_drained_fore")) {
        var_f31296bc = 1;
        util::delay(10, undefined, &zm_zodt8::change_water_height_fore, 0);
    }
    a_spawnpoints = arraycombine(struct::get_array("zone_cargo_spawns"), struct::get_array(#"hash_17233d37983e8ef3"), 0, 0);
    a_spawnpoints = function_c3e29f21(a_spawnpoints);
    n_players = util::get_active_players().size;
    n_spawns = 28 + n_players * 16;
    n_max_active = 14 + n_players * 2.5;
    n_spawn_delay = 1 / n_players;
    function_743ed9f(a_spawnpoints, n_spawns * 0.6, n_max_active, 15, #"transform2", n_spawn_delay);
    wait 4;
    level thread spawn_blightfather();
    function_743ed9f(a_spawnpoints, n_spawns * 0.4, n_max_active, 15, #"transform2", n_spawn_delay * 0.6);
    level notify(#"hash_215a84542b11208c");
    if (n_players > 2) {
        level thread spawn_blightfather();
    }
    function_f424b9bc();
    if (var_f31296bc === 1) {
        level thread zm_zodt8::change_water_height_fore(1);
    }
    level flag::set(#"hash_1322dd3a3d7411a5");
}

// Namespace zodt8_sentinel/zm_zodt8_sentinel_trial
// Params 0, eflags: 0x0
// Checksum 0x70d2fff4, Offset: 0x7028
// Size: 0x2f4
function function_cd578c23() {
    wait 1;
    n_players = util::get_active_players().size;
    var_d7a579ca = 36 + n_players * 12;
    var_3b74ee0b = 16 + n_players * 2;
    n_spawn_delay = 0.75 / n_players;
    a_spawnpoints = arraycombine(struct::get_array(#"hash_2ddf7f822f34714f"), struct::get_array(#"hash_1e415296e149d2fb"), 0, 0);
    a_spawnpoints = arraycombine(a_spawnpoints, struct::get_array(#"hash_64e18832c1d29752"), 0, 0);
    a_spawnpoints = function_c3e29f21(a_spawnpoints);
    util::delay(5, #"hash_2f5be8d749b4e88e", &spawn_blightfather);
    if (n_players > 2) {
        util::delay(10, #"hash_2f5be8d749b4e88e", &spawn_blightfather);
    }
    function_743ed9f(a_spawnpoints, var_d7a579ca / 2, var_3b74ee0b, 40, #"transform3", n_spawn_delay, array(10, 15));
    wait 8 / n_players;
    if (n_players > 3) {
        level thread spawn_blightfather();
    }
    function_743ed9f(a_spawnpoints, var_d7a579ca / 2, var_3b74ee0b, 40, #"transform3", n_spawn_delay / 2, array(5, 10));
    level thread spawn_blightfather();
    level notify(#"hash_215a84542b11208c");
    function_f424b9bc();
    level flag::set(#"hash_2f5be8d749b4e88e");
}

// Namespace zodt8_sentinel/zm_zodt8_sentinel_trial
// Params 0, eflags: 0x0
// Checksum 0xf0528962, Offset: 0x7328
// Size: 0x3b4
function function_cbbe64c1() {
    wait 3;
    var_a5b6d3fe = struct::get_array(#"stoker_spawn");
    a_spawnpoints = struct::get_array(#"hash_1ee3c805146f5ec4", "script_encounter");
    var_119f5a36 = 0;
    n_players = util::get_active_players().size;
    n_stokers = max(4, n_players * 2.5);
    var_f46b3adf = n_players + n_players / 2;
    n_delay = 25;
    var_caf17e0c = (n_players + 1) * 6;
    var_2b2f7634 = 1 / n_players;
    ai_stoker = undefined;
    n_round = max(level.round_number, 15);
    while (var_119f5a36 < n_stokers) {
        a_stokers = [];
        foreach (s_spawnpoint in var_a5b6d3fe) {
            while (!isdefined(ai_stoker)) {
                ai_stoker = zombie_utility::spawn_zombie(level.a_sp_stoker[0], "stoker", s_spawnpoint, n_round);
                waitframe(1);
            }
            if (!isdefined(a_stokers)) {
                a_stokers = [];
            } else if (!isarray(a_stokers)) {
                a_stokers = array(a_stokers);
            }
            a_stokers[a_stokers.size] = ai_stoker;
            ai_stoker.var_f7038080 = 1;
            var_119f5a36++;
            ai_stoker = undefined;
            if (a_stokers.size >= var_f46b3adf) {
                break;
            }
            wait randomfloat(1);
        }
        if (var_119f5a36 >= n_stokers / 2) {
            function_743ed9f(a_spawnpoints, var_caf17e0c, undefined, 25, #"transform4", var_2b2f7634, array(5, 10));
        }
        function_526005d6(a_stokers, 0);
        if (a_stokers.size) {
            array::wait_till(a_stokers, "death", n_delay);
        }
        n_delay -= 5;
    }
    level notify(#"hash_215a84542b11208c");
    function_f424b9bc();
    level flag::set(#"hash_33a5d8dd1204080e");
}

// Namespace zodt8_sentinel/zm_zodt8_sentinel_trial
// Params 1, eflags: 0x0
// Checksum 0xaff0adb9, Offset: 0x76e8
// Size: 0x4ac
function function_adb25a15(str_element) {
    zm_sq_modules::function_b4f7eda8(#"hash_34f827c2750a5a25" + str_element);
    s_artifact = struct::get(#"hash_34f827c2750a5a25" + str_element);
    s_moveto = struct::get(s_artifact.target);
    level flag::clear(#"hash_3e80d503318a5674");
    mdl_artifact = util::spawn_model(#"hash_2b14d34cb1bc161a", s_artifact.origin, s_artifact.angles);
    mdl_artifact notsolid();
    mdl_artifact setscale(1.25);
    mdl_artifact playloopsound(#"hash_5c7e9911ac98f633");
    if (isdefined(s_moveto)) {
        wait 4;
        v_offset = (0, 0, -16);
        mdl_artifact moveto(s_moveto.origin + v_offset, 6, 1, 1);
        mdl_artifact waittill(#"movedone");
        if (s_artifact.angles != s_moveto.angles) {
            mdl_artifact rotateto(s_moveto.angles, 1);
            mdl_artifact waittill(#"rotatedone");
        }
        waitframe(1);
    }
    mdl_artifact bobbing((0, 0, 1), 2, 3);
    level flag::wait_till(#"hash_317170e3689d18aa" + str_element);
    zm_sq_modules::function_c39c525(#"hash_34f827c2750a5a25" + str_element);
    waitframe(1);
    if (level flag::get(#"hash_511653209a0c8cc5" + str_element + "_completed")) {
        wait 5;
        if (str_element == #"fire") {
            mdl_artifact setmodel(#"hash_2b14d34cb1bc161a");
            mdl_artifact playloopsound(#"hash_66df9cab2c64f968");
        }
        wait 1.5;
        mdl_artifact moveto(s_artifact.origin, 2.5, 1, 1);
        mdl_artifact waittill(#"movedone");
        mdl_artifact bobbing((0, 0, 1), 0.5, 5);
        player = s_artifact zm_unitrigger::function_b7e350e6(#"hash_14754dac7b0290c6");
        if (str_element == #"fire") {
            mdl_artifact playsound(#"hash_58d1c989a1ea4137");
            if (isdefined(player)) {
                player thread zm_audio::create_and_play_dialog(#"m_quest", #"cat_sentinel", 0, 1);
            }
        } else {
            mdl_artifact playsound(#"hash_5de064f33e9e49b8");
        }
    }
    level flag::set(#"hash_3e80d503318a5674");
    mdl_artifact delete();
}

// Namespace zodt8_sentinel/zm_zodt8_sentinel_trial
// Params 2, eflags: 0x0
// Checksum 0x77630ceb, Offset: 0x7ba0
// Size: 0x6a
function function_a0dc6b8b(s_struct, ai_killed) {
    if (ai_killed.archetype === "stoker" || ai_killed.archetype === "blight_father" || ai_killed.archetype === "catalyst") {
        return true;
    }
    return false;
}

// Namespace zodt8_sentinel/zm_zodt8_sentinel_trial
// Params 2, eflags: 0x0
// Checksum 0x4a258200, Offset: 0x7c18
// Size: 0x14
function function_cc49529d(s_struct, ai_killed) {
    
}

// Namespace zodt8_sentinel/zm_zodt8_sentinel_trial
// Params 7, eflags: 0x0
// Checksum 0xf03c25f3, Offset: 0x7c38
// Size: 0x254
function function_743ed9f(a_spawnpoints, n_spawns, n_max_active = 24, var_7a69ce47, var_e19cdf84, n_spawn_delay = 0.1, var_3c6243c0 = 0.1) {
    var_f77eb79d = 0;
    var_8e08307a = arraycopy(a_spawnpoints);
    n_round_number = max(level.round_number, 15);
    while (var_f77eb79d < n_spawns) {
        function_b0f1d507(n_max_active);
        spawner = array::random(level.zombie_spawners);
        s_spawnpoint = array::random(var_8e08307a);
        ai = zombie_utility::spawn_zombie(spawner, spawner.targetname, s_spawnpoint, n_round_number);
        if (isdefined(ai)) {
            ai.b_ignore_cleanup = 1;
            ai.var_f7038080 = 1;
            if (isarray(var_3c6243c0)) {
                var_3c6243c0 = randomintrange(var_3c6243c0[0], var_3c6243c0[1]);
            }
            if (isdefined(var_e19cdf84)) {
                ai util::delay(var_3c6243c0, "death", &function_75d759c6, var_7a69ce47, var_e19cdf84);
            }
            var_f77eb79d++;
            arrayremovevalue(var_8e08307a, s_spawnpoint, 0);
            wait n_spawn_delay;
            if (!var_8e08307a.size) {
                var_8e08307a = arraycopy(a_spawnpoints);
            }
            continue;
        }
        waitframe(1);
    }
}

// Namespace zodt8_sentinel/zm_zodt8_sentinel_trial
// Params 2, eflags: 0x0
// Checksum 0x991fab8e, Offset: 0x7e98
// Size: 0x128
function function_75d759c6(var_7fcfc8e7, var_61189662) {
    level endon(#"hash_215a84542b11208c", #"hash_349bc60cedc7491e");
    while (isalive(self) && isdefined(level.var_9871cdf5)) {
        n_enemies = getaiteamarray(level.zombie_team).size;
        if (n_enemies && level.var_9871cdf5 / n_enemies * 100 < var_7fcfc8e7) {
            var_4fef5b74 = 1;
        } else {
            var_4fef5b74 = 0;
        }
        if (var_4fef5b74 && !zm_transform::function_5836d278(var_61189662) && zm_ai_utility::function_4f5236d3()) {
            zm_transform::function_3b866d7e(self, var_61189662);
            return;
        }
        wait 3;
    }
}

// Namespace zodt8_sentinel/zm_zodt8_sentinel_trial
// Params 1, eflags: 0x0
// Checksum 0x21d16d05, Offset: 0x7fc8
// Size: 0xec
function function_fa3a18b0(n_health) {
    if (level flag::get(#"hash_7a31252c7c941976") || level flag::get(#"hash_767ce45fce848b88")) {
        self.b_ignore_cleanup = 1;
        self.var_f7038080 = 1;
        level.var_9871cdf5++;
        level thread function_adb57dd2(self);
        waitframe(1);
        if (self.catalyst_type == 1) {
            self zombie_utility::set_zombie_run_cycle("sprint");
            return;
        }
        self zombie_utility::set_zombie_run_cycle("run");
    }
}

// Namespace zodt8_sentinel/zm_zodt8_sentinel_trial
// Params 1, eflags: 0x0
// Checksum 0xf86e3aa9, Offset: 0x80c0
// Size: 0x48
function function_adb57dd2(ai) {
    ai waittill(#"death");
    if (isdefined(level.var_9871cdf5)) {
        level.var_9871cdf5--;
    }
}

// Namespace zodt8_sentinel/zm_zodt8_sentinel_trial
// Params 0, eflags: 0x0
// Checksum 0x5f7a16b7, Offset: 0x8110
// Size: 0x1f4
function spawn_blightfather() {
    for (i = 0; i < 5; i++) {
        n_attempts = 0;
        var_bca3c057 = undefined;
        while (!isdefined(var_bca3c057) && n_attempts < 10) {
            n_attempts++;
            foreach (ai in getaiteamarray(level.zombie_team)) {
                waitframe(0);
                if (ai zm_ai_utility::function_4f5236d3()) {
                    var_bca3c057 = ai;
                    break;
                }
            }
        }
        if (isalive(var_bca3c057)) {
            zm_transform::function_3b866d7e(var_bca3c057, "blight_father");
            s_notify = function_b6f26afd();
            if (isdefined(s_notify) && isdefined(s_notify.new_ai[0])) {
                ai_bf = s_notify.new_ai[0];
                ai_bf.var_f7038080 = 1;
                ai_bf.b_ignore_cleanup = 1;
                ai_bf ai::set_behavior_attribute("lockdown_enabled", 0);
                return s_notify.new_ai[0];
            }
            continue;
        }
        wait 1;
    }
    return undefined;
}

// Namespace zodt8_sentinel/zm_zodt8_sentinel_trial
// Params 0, eflags: 0x0
// Checksum 0x3b104747, Offset: 0x8310
// Size: 0xbe
function function_b6f26afd() {
    if (isdefined(15)) {
        __s = spawnstruct();
        __s endon(#"timeout");
        __s util::delay_notify(15, "timeout");
    }
    for (s_notify = level waittill(#"transformation_complete"); s_notify.id !== "blight_father"; s_notify = level waittill(#"transformation_complete")) {
    }
    return s_notify;
}

// Namespace zodt8_sentinel/zm_zodt8_sentinel_trial
// Params 1, eflags: 0x0
// Checksum 0xc1d2d181, Offset: 0x83d8
// Size: 0x112
function function_c3e29f21(a_spawnpoints) {
    foreach (s_spawnpoint in a_spawnpoints) {
        if (s_spawnpoint.script_noteworthy === #"stoker_location" || s_spawnpoint.script_noteworthy === #"blight_father_location" || s_spawnpoint.script_noteworthy === #"wait_location") {
            arrayremovevalue(a_spawnpoints, s_spawnpoint, 1);
        }
    }
    a_spawnpoints = array::remove_undefined(a_spawnpoints, 0);
    return a_spawnpoints;
}

// Namespace zodt8_sentinel/zm_zodt8_sentinel_trial
// Params 0, eflags: 0x0
// Checksum 0x5664c31a, Offset: 0x84f8
// Size: 0x11c
function function_f424b9bc() {
    level endon(#"hash_20ba9a0874996fda");
    util::delay_notify(300, #"hash_20ba9a0874996fda", #"catalyst_encounters_completed");
    while (true) {
        wait 1;
        b_wait = 0;
        a_ai = getaiteamarray(level.zombie_team);
        foreach (ai in a_ai) {
            if (isalive(ai)) {
                b_wait = 1;
                break;
            }
        }
        if (!b_wait) {
            return;
        }
    }
}

// Namespace zodt8_sentinel/zm_zodt8_sentinel_trial
// Params 1, eflags: 0x0
// Checksum 0x7dad7ce8, Offset: 0x8620
// Size: 0x4c
function function_b0f1d507(n_max) {
    while (getaiteamarray(level.zombie_team).size > int(n_max)) {
        wait 0.1;
    }
}

// Namespace zodt8_sentinel/zm_zodt8_sentinel_trial
// Params 1, eflags: 0x0
// Checksum 0x2aa318e0, Offset: 0x8678
// Size: 0xc4
function function_f1924978(var_758116d) {
    level zm_ui_inventory::function_31a39683(#"zm_zodt8_sentinel_trial", 5);
    if (!var_758116d) {
        /#
            if (getdvarint(#"zm_debug_ee", 0) && !level flag::get(#"water_drained_aft")) {
                level thread zm_zodt8::change_water_height_aft(1);
            }
        #/
        function_2e76a016();
        function_cdc635ca();
    }
}

// Namespace zodt8_sentinel/zm_zodt8_sentinel_trial
// Params 2, eflags: 0x0
// Checksum 0xe5aeee2e, Offset: 0x8748
// Size: 0xdc
function function_5a4ff6c3(var_758116d, ended_early) {
    if (!var_758116d) {
        level thread function_ce41ae3d();
        playsoundatposition(#"hash_e0f3575083de01b", (0, 0, 0));
        if (ended_early) {
            level thread function_c0e7bc48();
        }
        return;
    }
    if (level flag::get(#"water_drained_fore")) {
        level flag::set(#"hash_76dd603f61fa542d");
        return;
    }
    level thread function_c0e7bc48();
}

// Namespace zodt8_sentinel/zm_zodt8_sentinel_trial
// Params 0, eflags: 0x0
// Checksum 0x79fbb02, Offset: 0x8830
// Size: 0x1bc
function function_8572be87() {
    a_zones = array("zone_engine", "zone_boiler_room", "zone_turbine_room", "zone_upper_engine_room");
    self callback::on_death(&function_d0d19cd2);
    while (isalive(self) && !level flag::get(#"planet_step_completed")) {
        if (!(isdefined(self.var_56c7266a) && self.var_56c7266a) && self.origin[2] < 500 && zm_zonemgr::is_player_in_zone(a_zones)) {
            self clientfield::set_to_player("" + #"boiler_fx", 1);
        } else if (self clientfield::get_to_player("" + #"boiler_fx")) {
            self clientfield::set_to_player("" + #"boiler_fx", 0);
        }
        wait 0.5;
    }
    if (isdefined(self)) {
        self clientfield::set_to_player("" + #"boiler_fx", 0);
    }
}

// Namespace zodt8_sentinel/zm_zodt8_sentinel_trial
// Params 1, eflags: 0x0
// Checksum 0xc465e986, Offset: 0x89f8
// Size: 0x5c
function function_d0d19cd2(params) {
    if (isdefined(self)) {
        self clientfield::set_to_player("" + #"boiler_fx", 0);
        self callback::remove_on_death(&function_d0d19cd2);
    }
}

// Namespace zodt8_sentinel/zm_zodt8_sentinel_trial
// Params 0, eflags: 0x0
// Checksum 0xdff31b8c, Offset: 0x8a60
// Size: 0x2b2
function function_2e76a016() {
    a_s_pipes = struct::get_array(#"hash_bf15c9f5060cda0");
    var_27b50acc = [];
    foreach (s_pipe in a_s_pipes) {
        mdl_pipe = util::spawn_model("tag_origin", s_pipe.origin, s_pipe.angles);
        mdl_pipe clientfield::set("" + #"pipe_fx", 1);
        mdl_pipe thread function_ee9a8177();
        var_27b50acc[var_27b50acc.size] = mdl_pipe;
        waitframe(0);
    }
    array::wait_till(var_27b50acc, #"hash_6ad372c0b5c6245a");
    level thread scene::stop("p8_fxanim_zm_zod_skybox_bundle");
    level thread scene::play("p8_fxanim_zm_zod_skybox_bundle", "event_impact");
    array::thread_all(var_27b50acc, &function_c13000ea);
    level thread zm_zodt8::change_water_height_aft(0);
    level thread zm_zodt8::change_water_height_fore(0);
    level thread function_c0e7bc48();
    wait 5;
    if (isalive(level.var_fa8f6bb7)) {
        level.var_fa8f6bb7 thread zm_audio::create_and_play_dialog(#"m_quest", #"hash_d70e28ab6ed340e", 0, 1);
        level.var_fa8f6bb7 = undefined;
    } else {
        level thread zm_audio::function_709246c9(#"m_quest", #"hash_d70e28ab6ed340e", 0, 1);
    }
    wait 10;
}

// Namespace zodt8_sentinel/zm_zodt8_sentinel_trial
// Params 0, eflags: 0x0
// Checksum 0x7cb619de, Offset: 0x8d20
// Size: 0x8c
function function_c0e7bc48() {
    level flag::wait_till_clear(#"water_drained_fore");
    zm_zodt8::function_ec11ded0(1, 0);
    while (level.e_clip_water_fore.origin[2] > 580) {
        wait 0.2;
    }
    level flag::set(#"hash_76dd603f61fa542d");
}

// Namespace zodt8_sentinel/zm_zodt8_sentinel_trial
// Params 0, eflags: 0x0
// Checksum 0xca79b56c, Offset: 0x8db8
// Size: 0x1d0
function function_ee9a8177() {
    wait 1;
    trigger = spawn("trigger_damage", self.origin, 0, 12, 24);
    w_earth = getweapon(#"ww_tricannon_earth_t8");
    var_9bdde800 = getweapon(#"ww_tricannon_earth_t8_upgraded");
    while (true) {
        s_result = trigger waittill(#"trigger");
        if (isdefined(s_result.activator) && isplayer(s_result.activator)) {
            w_weapon = s_result.activator getcurrentweapon();
            if (w_weapon == w_earth || w_weapon == var_9bdde800) {
                self notify(#"hash_6ad372c0b5c6245a");
                self clientfield::set("" + #"pipe_fx", 2);
                s_result.activator util::show_hit_marker(1);
                trigger delete();
                level.var_fa8f6bb7 = s_result.activator;
                return;
            }
        }
    }
}

// Namespace zodt8_sentinel/zm_zodt8_sentinel_trial
// Params 0, eflags: 0x0
// Checksum 0x96de5624, Offset: 0x8f90
// Size: 0x44
function function_c13000ea() {
    self clientfield::set("" + #"pipe_fx", 0);
    wait 30;
    self delete();
}

// Namespace zodt8_sentinel/zm_zodt8_sentinel_trial
// Params 0, eflags: 0x0
// Checksum 0x392518a2, Offset: 0x8fe0
// Size: 0x464
function function_cdc635ca() {
    if (level.s_pap_quest.var_d6c419fd === 2 || level flag::get(#"hash_598d4e6af1cf4c39")) {
        level.var_9b1767c1++;
    } else {
        level.s_pap_quest.var_6aee16f4 = 2;
        level flag::set(#"hash_452df3df817c57f9");
        level.var_9b1767c1 = level.round_number + 1;
        level waittill(#"pap_moved");
        waitframe(1);
        level flag::clear(#"hash_452df3df817c57f9");
        level.s_pap_quest.var_6aee16f4 = undefined;
    }
    for (var_5eba9df1 = 0; var_5eba9df1 !== 1; var_5eba9df1 = function_a4d7c07c()) {
    }
    v_spawn = level.pap_machine.origin + (0, -32, 40);
    mdl_artifact = util::spawn_model(#"hash_2b14d34cb1bc161a", v_spawn, (0, -90, 0));
    mdl_artifact notsolid();
    mdl_artifact playsound(#"hash_2d125a0883ae10c4");
    mdl_artifact playloopsound(#"hash_66df9cab2c64f968");
    mdl_artifact thread function_c65b0f40();
    mdl_artifact moveto(level.pap_machine.origin + (0, 2, 48), 3);
    mdl_artifact waittill(#"movedone");
    mdl_artifact setmodel(#"hash_3cdbd25e43a09930");
    wait 2.5;
    mdl_artifact playloopsound(#"hash_e2c71c7dece38ee");
    mdl_artifact clientfield::set("" + #"sentinel_shader", 1);
    mdl_artifact moveto(v_spawn, 3);
    mdl_artifact playsound(#"zmb_perks_packa_ready");
    wait 1.5;
    mdl_artifact playsound(#"hash_6bae336584399f4d");
    level thread function_82e137b7();
    s_pickup = spawnstruct();
    s_pickup.origin = v_spawn;
    e_player = s_pickup zm_unitrigger::function_b7e350e6(#"hash_14754dac7b0290c6");
    if (isdefined(e_player)) {
        e_player thread zm_audio::create_and_play_dialog(#"m_quest", #"sentinel_artifact", 0, 1);
    }
    mdl_artifact playsound(#"hash_58d1c989a1ea4137");
    s_pickup struct::delete();
    mdl_artifact clientfield::set("" + #"sentinel_shader", 0);
    mdl_artifact delete();
}

// Namespace zodt8_sentinel/zm_zodt8_sentinel_trial
// Params 0, eflags: 0x0
// Checksum 0xe19d12ed, Offset: 0x9450
// Size: 0x2c
function function_c65b0f40() {
    wait 2;
    self playsound(#"zmb_perks_packa_upgrade");
}

// Namespace zodt8_sentinel/zm_zodt8_sentinel_trial
// Params 0, eflags: 0x0
// Checksum 0x6b0ee9da, Offset: 0x9488
// Size: 0x2c
function function_82e137b7() {
    wait 5;
    level.pap_machine zm_pack_a_punch::function_b4713b3b(1);
}

// Namespace zodt8_sentinel/zm_zodt8_sentinel_trial
// Params 0, eflags: 0x0
// Checksum 0x681d3913, Offset: 0x94c0
// Size: 0x13e
function function_a4d7c07c() {
    if (level.s_pap_quest.var_d6c419fd === 2) {
        level endon(#"pap_moved");
        level.pap_machine zm_pack_a_punch::function_b4713b3b(0);
        s_stub = spawnstruct();
        s_stub.origin = level.pap_machine.origin;
        s_stub zm_unitrigger::create(#"hash_6b86bf43a35e502b", 96, &function_28a75e9f);
        s_stub waittill(#"trigger_activated");
        zm_unitrigger::unregister_unitrigger(s_stub.s_unitrigger);
        s_stub struct::delete();
        return true;
    } else {
        level.pap_machine zm_pack_a_punch::function_b4713b3b(1);
        level waittill(#"pap_moved");
    }
    return false;
}

// Namespace zodt8_sentinel/zm_zodt8_sentinel_trial
// Params 0, eflags: 0x0
// Checksum 0x49dc9257, Offset: 0x9608
// Size: 0x84
function function_28a75e9f() {
    self endon(#"death", #"kill_trigger");
    self thread zm_unitrigger::function_d59c1914();
    level waittill(#"pap_moved");
    zm_unitrigger::unregister_unitrigger(self.s_unitrigger);
    self delete();
}

// Namespace zodt8_sentinel/zm_zodt8_sentinel_trial
// Params 0, eflags: 0x0
// Checksum 0xe6fb433e, Offset: 0x9698
// Size: 0x3c
function function_ce41ae3d() {
    level flag::wait_till_clear(#"water_drained_aft");
    zm_zodt8::function_ec11ded0(0, 1);
}

// Namespace zodt8_sentinel/zm_zodt8_sentinel_trial
// Params 1, eflags: 0x0
// Checksum 0xdee48250, Offset: 0x96e0
// Size: 0x2b4
function function_ab1beec7(var_758116d) {
    level zm_ui_inventory::function_31a39683(#"zm_zodt8_sentinel_artifact", 1);
    level zm_ui_inventory::function_31a39683(#"zm_zodt8_sentinel_trial", 6);
    /#
        if (getdvarint(#"hash_7919e37cd5d57659", 0)) {
            level flag::set(#"hash_76dd603f61fa542d");
        }
    #/
    if (!var_758116d) {
        foreach (player in util::get_active_players()) {
            player thread function_4b598a89();
        }
        callback::on_spawned(&function_4b598a89);
        level.a_planets = [];
        level thread function_de0049f9();
        function_36d7081a();
        /#
            if (getdvarint(#"hash_7919e37cd5d57659", 0)) {
                a_glyphs = struct::get_array(#"planet_glyph", "<dev string:xc8>");
                foreach (s_glyph in a_glyphs) {
                    waitframe(1);
                    if (isdefined(s_glyph.s_unitrigger.trigger)) {
                        s_glyph.s_unitrigger.trigger notify(#"trigger");
                    }
                }
            }
        #/
        level flag::wait_till(#"hash_63a102a7ae564e99");
        function_871ee8a1();
    }
}

// Namespace zodt8_sentinel/zm_zodt8_sentinel_trial
// Params 2, eflags: 0x0
// Checksum 0x20541f30, Offset: 0x99a0
// Size: 0x22c
function function_73e46b4(var_758116d, ended_early) {
    if (!var_758116d) {
        callback::remove_on_spawned(&function_4b598a89);
        playsoundatposition(#"hash_e0f3675083de1ce", (0, 0, 0));
    }
    callback::remove_on_spawned(&function_8572be87);
    hidemiscmodels("coal_hot");
    if (level flag::get("water_drained_aft")) {
        showmiscmodels("coal_warm");
        hidemiscmodels("coal_cold");
    } else {
        hidemiscmodels("coal_warm");
        showmiscmodels("coal_cold");
    }
    if (isdefined(level.var_e669398a) && isarray(level.var_e669398a)) {
        foreach (planet in level.var_e669398a) {
            planet delete();
        }
        level.var_e669398a = undefined;
    }
    level.a_planets = undefined;
    level flag::clear(#"infinite_round_spawning");
    exploder::exploder_stop("exp_lgt_boiler_overheat");
    exploder::exploder_stop("exp_boiler_overheat");
}

// Namespace zodt8_sentinel/zm_zodt8_sentinel_trial
// Params 0, eflags: 0x0
// Checksum 0x1320fb00, Offset: 0x9bd8
// Size: 0xc0
function function_36d7081a() {
    a_glyphs = struct::get_array(#"planet_glyph", "script_noteworthy");
    foreach (s_glyph in a_glyphs) {
        s_glyph zm_unitrigger::create(undefined, undefined, &function_816eeb9d);
    }
}

// Namespace zodt8_sentinel/zm_zodt8_sentinel_trial
// Params 0, eflags: 0x0
// Checksum 0x44d459c4, Offset: 0x9ca0
// Size: 0x3f4
function function_816eeb9d() {
    self endon(#"death");
    s_glyph = self.stub.related_parent;
    while (!level flag::get(#"hash_63a102a7ae564e99")) {
        s_glyph.mdl_glyph show();
        self waittill(#"trigger");
        s_glyph.mdl_glyph clientfield::increment("" + #"hash_68e2384b254175da", 1);
        s_glyph.mdl_glyph util::delay(0.5, #"hash_158580acc65694d5", &hide_self);
        mdl_planet = getent(s_glyph.targetname, "str_object_name");
        if (!isdefined(mdl_planet)) {
            mdl_planet = util::spawn_model("tag_origin");
        }
        mdl_planet.str_object_name = s_glyph.targetname;
        s_glyph.mdl_glyph playsound(#"hash_72c7d128172a1be4" + s_glyph.targetname + "_0");
        if (!isdefined(level.var_e669398a)) {
            level.var_e669398a = [];
        } else if (!isarray(level.var_e669398a)) {
            level.var_e669398a = array(level.var_e669398a);
        }
        if (!isinarray(level.var_e669398a, mdl_planet)) {
            level.var_e669398a[level.var_e669398a.size] = mdl_planet;
        }
        if (!isdefined(level.a_planets)) {
            level.a_planets = [];
        } else if (!isarray(level.a_planets)) {
            level.a_planets = array(level.a_planets);
        }
        if (!isinarray(level.a_planets, mdl_planet)) {
            level.a_planets[level.a_planets.size] = mdl_planet;
        }
        /#
            if (getdvarint(#"hash_7919e37cd5d57659", 0)) {
                iprintlnbold(s_glyph.targetname + "<dev string:x197>");
                println(s_glyph.targetname + "<dev string:x197>");
            }
        #/
        level thread planet_behavior(mdl_planet);
        level waittill(#"hash_158580acc65694d5", #"hash_63a102a7ae564e99");
    }
    if (isdefined(s_glyph) && isdefined(s_glyph.mdl_glyph)) {
        s_glyph.mdl_glyph delete();
    }
    zm_unitrigger::unregister_unitrigger(self.s_unitrigger);
}

// Namespace zodt8_sentinel/zm_zodt8_sentinel_trial
// Params 0, eflags: 0x0
// Checksum 0xf1ede464, Offset: 0xa0a0
// Size: 0x1c
function hide_self() {
    self hide();
}

// Namespace zodt8_sentinel/zm_zodt8_sentinel_trial
// Params 0, eflags: 0x0
// Checksum 0xb6da3f11, Offset: 0xa0c8
// Size: 0xb4
function function_f9a162e2() {
    if (level.a_planets.size < 9) {
        return;
    }
    foreach (mdl_planet in level.a_planets) {
        if (mdl_planet.var_68d6d1c0 !== 1) {
            return;
        }
    }
    waitframe(0);
    level flag::set(#"hash_63a102a7ae564e99");
}

// Namespace zodt8_sentinel/zm_zodt8_sentinel_trial
// Params 0, eflags: 0x0
// Checksum 0x954c6a01, Offset: 0xa188
// Size: 0x4f8
function function_871ee8a1() {
    a_glyphs = struct::get_array(#"planet_glyph", "script_noteworthy");
    do {
        a_glyphs = array::randomize(a_glyphs);
    } while (a_glyphs[0].targetname == #"moon");
    foreach (s_glyph in a_glyphs) {
        if (s_glyph.targetname == #"sun") {
            var_cb6d2ea4 = s_glyph;
            break;
        }
    }
    arrayremovevalue(a_glyphs, var_cb6d2ea4, 0);
    a_glyphs[a_glyphs.size] = var_cb6d2ea4;
    a_str_flags = [];
    foreach (s_glyph in a_glyphs) {
        if (!isdefined(a_str_flags)) {
            a_str_flags = [];
        } else if (!isarray(a_str_flags)) {
            a_str_flags = array(a_str_flags);
        }
        a_str_flags[a_str_flags.size] = s_glyph.targetname;
    }
    var_bfcf179e = getent("secret_device", "targetname");
    level thread function_b15f829c(a_glyphs, var_bfcf179e);
    while (true) {
        level flag::wait_till(#"orrery_activated");
        level notify(#"hash_e9d5238dbce48ca");
        level thread function_fb126d9a(a_glyphs, var_bfcf179e);
        function_6f20a94e(a_glyphs, var_bfcf179e);
        if (level flag::get(#"hash_1a742576c41a0ab9")) {
            level flag::wait_till_any(array(#"planet_step_completed", #"hash_77f76266b597a1f7"));
            if (level flag::get(#"planet_step_completed")) {
                break;
            }
        }
        /#
            if (getdvarint(#"hash_7919e37cd5d57659", 0)) {
                iprintlnbold("<dev string:x1a8>");
                println("<dev string:x1a8>");
            }
        #/
        foreach (str_flag in a_str_flags) {
            if (level flag::exists(str_flag + "_done")) {
                level flag::delete(str_flag + "_done");
            }
            if (level flag::exists(str_flag + "_pickup")) {
                level flag::delete(str_flag + "_pickup");
            }
        }
        level flag::clear(#"hash_1a742576c41a0ab9");
        level flag::clear(#"orrery_activated");
        var_bfcf179e clientfield::set("" + #"planet_light", 0);
    }
}

// Namespace zodt8_sentinel/zm_zodt8_sentinel_trial
// Params 2, eflags: 0x0
// Checksum 0x87648ed6, Offset: 0xa688
// Size: 0x148
function function_6f20a94e(a_glyphs, mdl_light) {
    level endon(#"hash_77f76266b597a1f7");
    for (i = 0; i < a_glyphs.size; i++) {
        str_planet_name = a_glyphs[i].targetname;
        level flag::init(str_planet_name + "_done");
        level flag::wait_till(str_planet_name + "_done");
        level thread function_edabc76a(str_planet_name, i + 1);
        level flag::delete(str_planet_name + "_done");
    }
    level flag::set(#"hash_1a742576c41a0ab9");
    level thread function_b15f829c(a_glyphs, mdl_light);
    waitframe(1);
    level notify(#"hash_e9d5238dbce48ca");
}

// Namespace zodt8_sentinel/zm_zodt8_sentinel_trial
// Params 2, eflags: 0x0
// Checksum 0xb8346079, Offset: 0xa7d8
// Size: 0x10c
function function_fb126d9a(a_glyphs, mdl_light) {
    level endon(#"hash_77f76266b597a1f7");
    for (i = 0; i < a_glyphs.size; i++) {
        str_planet_name = a_glyphs[i].targetname;
        level flag::init(str_planet_name + "_pickup");
        level flag::wait_till(str_planet_name + "_pickup");
        level flag::delete(str_planet_name + "_pickup");
    }
    level flag::set(#"planet_step_completed");
    level flag::set(#"disable_fast_travel");
}

// Namespace zodt8_sentinel/zm_zodt8_sentinel_trial
// Params 2, eflags: 0x0
// Checksum 0x6bdaa2f8, Offset: 0xa8f0
// Size: 0x424
function function_edabc76a(str_planet_name, n_number) {
    level endoncallback(&function_3641ab7, str_planet_name + "_pickup", #"planet_step_completed");
    while (!level flag::exists(str_planet_name + "_pickup")) {
        waitframe(1);
    }
    level flag::clear("spawn_zombies");
    level.str_planet_name = str_planet_name;
    level.no_target_override = &function_7eb8307a;
    a_zones = function_f0c5a0e2(str_planet_name);
    if (!isdefined(a_zones)) {
        a_zones = [];
    } else if (!isarray(a_zones)) {
        a_zones = array(a_zones);
    }
    level thread function_3fc79dc(a_zones);
    level thread function_f8304004(a_zones, str_planet_name);
    a_s_spawnpoints = [];
    foreach (str_zone in a_zones) {
        var_39b0b810 = getnodearray(str_zone, "targetname");
        var_d9576cf0 = struct::get_array(var_39b0b810[0].target);
        a_s_spawnpoints = arraycombine(a_s_spawnpoints, var_d9576cf0, 0, 0);
    }
    var_c11e5a64 = function_17d21ea6(a_s_spawnpoints, #"stoker_location");
    a_s_spawnpoints = function_c3e29f21(a_s_spawnpoints);
    n_max_zombies = 16 + util::get_active_players().size * 2;
    if (n_number == 2 || n_number == 8) {
        if (var_c11e5a64.size) {
            s_stoker_spawn = array::random(var_c11e5a64);
        }
        ai = zm_ai_stoker::spawn_single(1, s_stoker_spawn);
        ai.b_ignore_cleanup = 1;
        if (util::get_active_players().size > 2) {
            level thread function_db61f676(s_stoker_spawn, 5);
        }
    }
    if (n_number == 5 || n_number == 8) {
        util::delay(10, undefined, &spawn_blightfather);
    }
    while (true) {
        function_743ed9f(a_s_spawnpoints, 99, n_max_zombies);
    }
    /#
        if (getdvarint(#"hash_7919e37cd5d57659", 0)) {
            iprintlnbold("<dev string:x1c8>" + str_zone);
            println("<dev string:x1c8>" + str_zone);
        }
    #/
}

// Namespace zodt8_sentinel/zm_zodt8_sentinel_trial
// Params 1, eflags: 0x0
// Checksum 0x8ff1e418, Offset: 0xad20
// Size: 0x76
function function_3641ab7(s_result) {
    level flag::set("spawn_zombies");
    level flag::clear(#"infinite_round_spawning");
    level flag::clear(#"pause_round_timeout");
    level.no_target_override = undefined;
}

// Namespace zodt8_sentinel/zm_zodt8_sentinel_trial
// Params 2, eflags: 0x0
// Checksum 0x1e90c67d, Offset: 0xada0
// Size: 0x4e
function function_db61f676(s_stoker_spawn, n_delay) {
    wait n_delay;
    ai = zm_ai_stoker::spawn_single(1, s_stoker_spawn);
    ai.b_ignore_cleanup = 1;
}

// Namespace zodt8_sentinel/zm_zodt8_sentinel_trial
// Params 2, eflags: 0x0
// Checksum 0x33705b05, Offset: 0xadf8
// Size: 0xe8
function function_17d21ea6(a_spawnpoints, str_type) {
    var_497279b3 = [];
    foreach (s_spawnpoint in a_spawnpoints) {
        if (s_spawnpoint.script_noteworthy === str_type) {
            if (!isdefined(var_497279b3)) {
                var_497279b3 = [];
            } else if (!isarray(var_497279b3)) {
                var_497279b3 = array(var_497279b3);
            }
            var_497279b3[var_497279b3.size] = s_spawnpoint;
        }
    }
    return var_497279b3;
}

// Namespace zodt8_sentinel/zm_zodt8_sentinel_trial
// Params 1, eflags: 0x0
// Checksum 0xc62d478c, Offset: 0xaee8
// Size: 0x6c
function function_7eb8307a(ai) {
    v_goal = struct::get(level.str_planet_name + "_gather").origin;
    if (isdefined(v_goal)) {
        self setgoal(v_goal, 0, 0, 256);
    }
}

// Namespace zodt8_sentinel/zm_zodt8_sentinel_trial
// Params 2, eflags: 0x0
// Checksum 0xee75aef, Offset: 0xaf60
// Size: 0x310
function function_f8304004(a_zones, str_planet_name) {
    wait 10;
    while (level flag::exists(str_planet_name + "_pickup") && !level flag::get(str_planet_name + "_pickup")) {
        if (zm_zonemgr::any_player_in_zone(a_zones[0])) {
            foreach (player in util::get_active_players()) {
                player val::reset(#"planet_ignore", "ignoreme");
            }
        } else {
            foreach (player in util::get_active_players()) {
                player val::set(#"planet_ignore", "ignoreme", 1);
            }
        }
        wait 1;
        if (randomint(100) >= 66) {
            ai = array::random(getaiarchetypearray("zombie", level.zombie_team));
            if (zm_utility::is_magic_bullet_shield_enabled(ai)) {
                ai util::stop_magic_bullet_shield();
            }
            assert(ai.allowdeath);
            ai kill();
        }
    }
    foreach (player in util::get_active_players()) {
        player val::reset(#"planet_ignore", "ignoreme");
    }
}

// Namespace zodt8_sentinel/zm_zodt8_sentinel_trial
// Params 1, eflags: 0x0
// Checksum 0x1b226cd7, Offset: 0xb278
// Size: 0x18c
function function_3fc79dc(a_zones) {
    wait 10;
    foreach (ai in getaiarchetypearray("zombie", level.zombie_team)) {
        foreach (str_zone in a_zones) {
            if (isalive(ai) && ai.zone_name !== str_zone) {
                if (zm_utility::is_magic_bullet_shield_enabled(ai)) {
                    ai util::stop_magic_bullet_shield();
                }
                ai dodamage(ai.health + 999, ai.origin);
                waitframe(randomint(15));
            }
        }
    }
}

// Namespace zodt8_sentinel/zm_zodt8_sentinel_trial
// Params 1, eflags: 0x0
// Checksum 0x706b6dbc, Offset: 0xb410
// Size: 0x13a
function function_f0c5a0e2(str_planet_name) {
    switch (str_planet_name) {
    case #"sun":
        return array("zone_forecastle_upper", "zone_forecastle_lower");
    case #"saturn":
        return "zone_bridge";
    case #"neptune":
        return "zone_aft_deck";
    case #"jupiter":
        return array("zone_engine", "zone_upper_engine_room");
    case #"moon":
        return "zone_grand_stairs_c_deck";
    case #"uranus":
        return array("zone_state_rooms_rear", "zone_state_rooms_front");
    case #"mercury":
        return "zone_mail_room";
    case #"mars":
        return "zone_boiler_room";
    case #"venus":
        return "millionaire_suite_zone";
    }
}

// Namespace zodt8_sentinel/zm_zodt8_sentinel_trial
// Params 2, eflags: 0x0
// Checksum 0x70f90e12, Offset: 0xb558
// Size: 0x284
function function_b15f829c(a_glyphs, mdl_light) {
    mdl_light endon(#"death");
    while (!level flag::get(#"planet_step_completed")) {
        level waittill(#"hash_e9d5238dbce48ca");
        if (mdl_light.var_5392d29 === 1) {
            return;
        }
        mdl_light.var_5392d29 = 1;
        mdl_light notify(#"stop_blinking");
        waitframe(0);
        mdl_light clientfield::set("" + #"planet_light", 0);
        wait 0.5;
        for (i = 0; i < a_glyphs.size; i++) {
            mdl_light function_cfca83cb(a_glyphs[i].targetname);
            wait 1.25;
        }
        mdl_light clientfield::set("" + #"planet_light", 0);
        wait 1.25;
        str_current = undefined;
        for (i = 0; i < a_glyphs.size; i++) {
            if (level flag::exists(a_glyphs[i].targetname + "_done")) {
                str_current = a_glyphs[i].targetname;
            }
        }
        if (!isdefined(str_current)) {
            for (i = 0; i < a_glyphs.size; i++) {
                if (level flag::exists(a_glyphs[i].targetname + "_pickup")) {
                    str_current = a_glyphs[i].targetname;
                }
            }
        }
        if (isdefined(str_current)) {
        }
        mdl_light.var_5392d29 = 0;
        level notify(#"hash_2b98a5e784a514cf");
    }
}

// Namespace zodt8_sentinel/zm_zodt8_sentinel_trial
// Params 1, eflags: 0x0
// Checksum 0x1ef3f34c, Offset: 0xb7e8
// Size: 0x262
function function_cfca83cb(str_planet_name) {
    switch (str_planet_name) {
    case #"sun":
        self clientfield::set("" + #"planet_light", 1);
        break;
    case #"mercury":
        self clientfield::set("" + #"planet_light", 2);
        break;
    case #"venus":
        self clientfield::set("" + #"planet_light", 3);
        break;
    case #"moon":
        self clientfield::set("" + #"planet_light", 4);
        break;
    case #"mars":
        self clientfield::set("" + #"planet_light", 5);
        break;
    case #"jupiter":
        self clientfield::set("" + #"planet_light", 6);
        break;
    case #"saturn":
        self clientfield::set("" + #"planet_light", 7);
        break;
    case #"uranus":
        self clientfield::set("" + #"planet_light", 8);
        break;
    case #"neptune":
        self clientfield::set("" + #"planet_light", 9);
        break;
    }
}

// Namespace zodt8_sentinel/zm_zodt8_sentinel_trial
// Params 0, eflags: 0x0
// Checksum 0x1235a818, Offset: 0xba58
// Size: 0x5ec
function function_de0049f9() {
    level flag::wait_till(#"hash_76dd603f61fa542d");
    exploder::exploder("exp_crate_blast");
    wait 0.2;
    a_crate = getentarray("generic_crate_sides", "targetname");
    foreach (e_crate in a_crate) {
        e_crate delete();
    }
    level flag::wait_till(#"hash_63a102a7ae564e99");
    /#
        if (getdvarint(#"hash_7919e37cd5d57659", 0)) {
            iprintlnbold("<dev string:x1ed>");
            println("<dev string:x1ed>");
        }
    #/
    a_glyphs = struct::get_array(#"planet_glyph", "script_noteworthy");
    var_681027f0 = struct::get(#"loc_sun");
    var_681027f0 zm_unitrigger::create();
    while (!level flag::get(#"planet_step_completed")) {
        s_result = var_681027f0 waittill(#"trigger_activated");
        if (isdefined(s_result.e_who)) {
            s_result.e_who zm_audio::create_and_play_dialog(#"m_quest", #"hash_7ccac254437d97c2");
        }
        playsoundatposition(#"hash_1321699865d55fc2", var_681027f0.origin);
        foreach (player in util::get_active_players()) {
            player playrumbleonentity("zm_power_on_rumble");
        }
        level scene::stop("p8_fxanim_zm_zod_skybox_bundle");
        level thread scene::play("p8_fxanim_zm_zod_skybox_bundle", "event_impact");
        level flag::set(#"orrery_activated");
        level flag::set(#"pause_round_timeout");
        level flag::set(#"infinite_round_spawning");
        level.a_planets = arraycopy(level.var_e669398a);
        if (level flag::get(#"hash_77f76266b597a1f7")) {
            level flag::clear(#"hash_77f76266b597a1f7");
        }
        waitframe(0);
        foreach (player in util::get_active_players()) {
            player thread function_4b598a89();
        }
        foreach (mdl_planet in level.a_planets) {
            level thread planet_behavior(mdl_planet);
        }
        var_681027f0 thread function_aad1db53();
        level flag::wait_till_clear(#"orrery_activated");
        level flag::clear(#"infinite_round_spawning");
        level flag::clear(#"pause_round_timeout");
        level waittill(#"end_of_round", #"start_of_round");
        var_681027f0 notify(#"hash_3ff9c95fe61d398c");
    }
    zm_unitrigger::unregister_unitrigger(var_681027f0.s_unitrigger);
    var_681027f0 struct::delete();
}

// Namespace zodt8_sentinel/zm_zodt8_sentinel_trial
// Params 0, eflags: 0x0
// Checksum 0x72f819bb, Offset: 0xc050
// Size: 0xb2
function function_aad1db53() {
    while (!level flag::get(#"planet_step_completed")) {
        s_result = self waittill(#"trigger_activated", #"hash_3ff9c95fe61d398c");
        if (s_result._notify === "trigger_activated") {
            waitframe(1);
            if (level flag::get(#"orrery_activated")) {
                level notify(#"hash_e9d5238dbce48ca");
            }
            continue;
        }
        return;
    }
}

// Namespace zodt8_sentinel/zm_zodt8_sentinel_trial
// Params 1, eflags: 0x0
// Checksum 0x52a7aca, Offset: 0xc110
// Size: 0x34e
function planet_behavior(mdl_planet) {
    if (mdl_planet.var_68d6d1c0 === 1) {
        return;
    }
    str_planet_name = mdl_planet.str_object_name;
    if (str_planet_name !== #"moon") {
        mdl_planet setmodel(#"p8_zm_zod_planets_" + str_planet_name + "_large");
        switch (str_planet_name) {
        case #"uranus":
            mdl_planet setscale(2);
            break;
        case #"saturn":
            mdl_planet setscale(3);
            break;
        case #"jupiter":
            mdl_planet setscale(2.5);
            break;
        default:
            mdl_planet setscale(1.25);
            break;
        }
    }
    mdl_planet notsolid();
    mdl_planet hide();
    mdl_planet.var_68d6d1c0 = 1;
    function_f9a162e2();
    level thread planet_visibility(mdl_planet);
    level thread planet_cleanup(mdl_planet);
    if (str_planet_name !== #"moon") {
        var_47ee7db6 = getent("veh_fasttravel_cam", "targetname");
        nd_path = array::random(getvehiclenodearray(str_planet_name + "_path", "targetname"));
        var_9b6a5aff = spawner::simple_spawn_single(var_47ee7db6);
        mdl_planet.var_9b6a5aff = var_9b6a5aff;
        mdl_planet.origin = var_9b6a5aff.origin;
        mdl_planet linkto(var_9b6a5aff);
        while (!level flag::get(#"hash_77f76266b597a1f7")) {
            if (isdefined(var_9b6a5aff)) {
                var_9b6a5aff vehicle::get_on_and_go_path(nd_path);
                if (isdefined(var_9b6a5aff) && (str_planet_name === #"uranus" || str_planet_name === #"saturn")) {
                    wait randomintrange(10, 20);
                }
                continue;
            }
            return;
        }
    }
}

// Namespace zodt8_sentinel/zm_zodt8_sentinel_trial
// Params 1, eflags: 0x0
// Checksum 0xdb625d41, Offset: 0xc468
// Size: 0xfc
function planet_cleanup(mdl_planet) {
    level waittill(#"hash_77f76266b597a1f7", mdl_planet.str_object_name + "_pickup");
    if (isdefined(mdl_planet)) {
        mdl_planet.var_68d6d1c0 = 0;
        mdl_planet clientfield::set("" + #"essence_fx", 0);
        mdl_planet setmodel("tag_origin");
        if (isdefined(mdl_planet.var_9b6a5aff)) {
            mdl_planet unlink();
            mdl_planet.var_9b6a5aff notify(#"stop path");
            mdl_planet.var_9b6a5aff delete();
        }
    }
}

// Namespace zodt8_sentinel/zm_zodt8_sentinel_trial
// Params 1, eflags: 0x0
// Checksum 0xdb050552, Offset: 0xc570
// Size: 0x74
function planet_visibility(mdl_planet) {
    mdl_planet clientfield::set("" + #"land_fx", 0);
    mdl_planet hide();
    wait 0.5;
    mdl_planet show();
}

// Namespace zodt8_sentinel/zm_zodt8_sentinel_trial
// Params 0, eflags: 0x0
// Checksum 0x31a340f7, Offset: 0xc5f0
// Size: 0x49e
function function_4b598a89() {
    self notify("4a65359263797313");
    self endon("4a65359263797313");
    self endon(#"death");
    var_c67d8009 = gettime();
    var_9a38016e = level.hero_weapon[#"chakram"];
    while (!level flag::get(#"hash_1a742576c41a0ab9")) {
        s_result = self waittill(#"weapon_fired");
        if (!isdefined(level.a_planets) || level.a_planets.size == 0) {
            continue;
        }
        if (gettime() - var_c67d8009 < 100) {
            continue;
        }
        var_f9c0b7cc = 0;
        foreach (weapon in var_9a38016e) {
            if (weapon.dualwieldweapon == s_result.weapon || weapon == s_result.weapon) {
                var_f9c0b7cc = 1;
                break;
            }
        }
        if (var_f9c0b7cc) {
            continue;
        }
        v_forward = self getweaponforwarddir();
        v_start = self getweaponmuzzlepoint();
        foreach (mdl_planet in level.a_planets) {
            if (!isdefined(mdl_planet.str_object_name) || v_forward[2] < 0.3 && mdl_planet.str_object_name != #"neptune" || v_forward[2] > 0.1 && mdl_planet.str_object_name == #"neptune") {
                continue;
            }
            if (mdl_planet.var_68d6d1c0 !== 1) {
                continue;
            }
            v_end = v_start + v_forward * 200000;
            b_hit = self function_e10cdf90(mdl_planet, v_start, v_end, v_forward);
            if (b_hit) {
                v_trace_end = v_start + v_forward * 10000;
                a_trace = bullettrace(v_start, v_trace_end, 1, self);
                if (isdefined(a_trace[#"entity"]) || a_trace[#"surfacetype"] !== "default" && a_trace[#"surfacetype"] !== "none") {
                    break;
                }
                self util::show_hit_marker(1);
                self thread zm_audio::create_and_play_dialog(#"m_quest", #"hash_45e36c01ad8ad25c", 0, 1);
                if (isdefined(mdl_planet.var_9b6a5aff)) {
                    mdl_planet unlink();
                    mdl_planet.var_9b6a5aff delete();
                }
                level thread function_1d7e5e11(mdl_planet);
                break;
            }
        }
        var_c67d8009 = gettime();
    }
}

// Namespace zodt8_sentinel/zm_zodt8_sentinel_trial
// Params 4, eflags: 0x0
// Checksum 0x59e0b6a5, Offset: 0xca98
// Size: 0x252
function function_e10cdf90(mdl_planet, v_start, v_end, v_forward) {
    if (mdl_planet.str_object_name === #"moon") {
        v_angles = self getplayerangles();
        if (abs(abs(v_angles[0]) - abs(-26.6)) + abs(abs(v_angles[1]) - abs(-29.35)) <= 2.2 && abs(abs(v_angles[2]) - abs(0)) <= 1) {
            mdl_planet.origin = v_start + v_forward * 100000;
            return true;
        }
        return false;
    } else {
        v_target = mdl_planet.origin;
    }
    if (mdl_planet.str_object_name === #"neptune") {
        n_min_dist = 10000;
    } else {
        n_min_dist = 1048576;
    }
    v_shot = pointonsegmentnearesttopoint(v_start, v_end, v_target);
    n_dist_squared = distancesquared(v_shot, v_target);
    if (n_dist_squared < n_min_dist) {
        return true;
    }
    return false;
}

// Namespace zodt8_sentinel/zm_zodt8_sentinel_trial
// Params 1, eflags: 0x0
// Checksum 0xee886c5c, Offset: 0xccf8
// Size: 0x640
function function_1d7e5e11(mdl_planet) {
    n_move_time = 9;
    n_accel = 5;
    str_planet_name = mdl_planet.str_object_name;
    arrayremovevalue(level.a_planets, mdl_planet, 0);
    mdl_planet setmodel(#"tag_origin");
    if (str_planet_name != #"neptune") {
        if (str_planet_name == #"moon") {
            util::wait_network_frame();
        }
        mdl_planet clientfield::set("" + #"essence_fx", 1);
    }
    mdl_planet playsound(#"hash_2380c4a79ebb093c");
    mdl_planet playloopsound(#"hash_5a4997dc84f6d680");
    if (level flag::exists(str_planet_name + "_done")) {
        level flag::set(str_planet_name + "_done");
        if (str_planet_name == #"neptune") {
            mdl_planet clientfield::set("" + #"essence_fx", 1);
            function_a138f903(mdl_planet);
            n_move_time = 3;
            n_accel = 1;
        }
        s_landing = struct::get(str_planet_name + "_landing");
        mdl_planet moveto(s_landing.origin + (0, 0, 20), n_move_time, n_accel, 0.5);
        mdl_planet waittill(#"movedone");
        mdl_planet clientfield::set("" + #"land_fx", 1);
        mdl_planet rotate((15, 50, 0));
        mdl_planet playsound(#"hash_6e67e59759b21e8e");
        if (!level flag::get(#"hash_77f76266b597a1f7")) {
            mdl_planet playloopsound(#"hash_733ab9b8fda8f02b");
            level thread function_242c4b2a(str_planet_name);
            if (str_planet_name == #"sun") {
                s_landing function_745d78b(undefined, #"hash_77f76266b597a1f7");
            } else {
                s_landing zm_unitrigger::create();
                s_landing function_5beeaf34();
            }
            level.var_8f67ba1d = undefined;
            if (level flag::exists(str_planet_name + "_pickup")) {
                level flag::set(str_planet_name + "_pickup");
                mdl_planet stoploopsound();
                mdl_planet playsound(#"hash_134115584a37eb8a");
            } else {
                level flag::set(#"hash_77f76266b597a1f7");
                zm_unitrigger::unregister_unitrigger(s_landing.s_unitrigger);
            }
        }
    } else {
        mdl_planet clientfield::set("" + #"land_fx", 1);
        s_landing = array::get_all_closest(mdl_planet.origin, struct::get_array(#"hash_3947a14d3fd90f0f"), undefined, 1)[0];
        mdl_planet moveto(s_landing.origin, n_move_time);
        mdl_planet waittill(#"movedone");
        mdl_planet stoploopsound();
        mdl_planet playsound(#"hash_7007602a9c1e2b84");
        mdl_planet clientfield::set("" + #"land_fx", 0);
        level flag::set(#"hash_77f76266b597a1f7");
        /#
            iprintlnbold("<dev string:x200>");
        #/
    }
    if (!level flag::get(#"hash_63a102a7ae564e99")) {
        waitframe(1);
        level flag::clear(#"hash_77f76266b597a1f7");
        level notify(#"hash_158580acc65694d5");
    }
}

// Namespace zodt8_sentinel/zm_zodt8_sentinel_trial
// Params 0, eflags: 0x0
// Checksum 0xfddb09be, Offset: 0xd340
// Size: 0x8c
function function_5beeaf34() {
    level endon(#"hash_77f76266b597a1f7");
    s_result = self waittill(#"trigger_activated");
    if (isdefined(s_result.e_who)) {
        s_result.e_who thread zm_audio::create_and_play_dialog(#"m_quest", #"hash_75e9e3640a38273", 0, 1);
    }
}

// Namespace zodt8_sentinel/zm_zodt8_sentinel_trial
// Params 1, eflags: 0x0
// Checksum 0x793bf21, Offset: 0xd3d8
// Size: 0x174
function function_242c4b2a(str_planet_name) {
    level endon(#"hash_77f76266b597a1f7", str_planet_name + "_pickup");
    n_interval = 10;
    n_current_time = 0;
    while (n_current_time < 30) {
        if (!isdefined(level.var_8f67ba1d)) {
            level.var_8f67ba1d = str_planet_name;
        }
        wait n_interval;
        n_current_time += n_interval;
        n_interval = max(1, n_interval * 0.666);
        if (level.var_8f67ba1d === str_planet_name) {
            playsoundatposition(#"hash_1e42da88156af69f", (0, 0, 0));
            /#
                if (getdvarint(#"hash_7919e37cd5d57659", 0)) {
                    iprintlnbold("<dev string:x205>");
                    println("<dev string:x205>");
                }
            #/
        }
    }
    level flag::set(#"hash_77f76266b597a1f7");
}

// Namespace zodt8_sentinel/zm_zodt8_sentinel_trial
// Params 1, eflags: 0x0
// Checksum 0xd43619ec, Offset: 0xd558
// Size: 0x8c
function function_a138f903(mdl_planet) {
    s_rising = struct::get(#"hash_38c9156b019d766b");
    mdl_planet moveto(s_rising.origin, 5, 1, 3);
    mdl_planet waittill(#"movedone");
    wait 0.15;
}

// Namespace zodt8_sentinel/zm_zodt8_sentinel_trial
// Params 1, eflags: 0x0
// Checksum 0xd97dc80c, Offset: 0xd5f0
// Size: 0x3be
function function_dcc0419e(var_758116d) {
    level zm_ui_inventory::function_31a39683(#"zm_zodt8_sentinel_trial", 7);
    /#
        if (getdvarint(#"hash_7919e37cd5d57659", 0)) {
            gear_up();
        }
    #/
    if (!var_758116d) {
        level.zm_bgb_anywhere_but_here_validation_override = &return_false;
        level flag::set(#"hash_767ce45fce848b88");
        foreach (player in util::get_players()) {
            if (player util::is_spectating()) {
                player thread zm_player::spectator_respawn_player();
            }
            player clientfield::set_to_player("" + #"camera_snow", 1);
        }
        level.musicsystemoverride = 1;
        music::setmusicstate("frozen");
        function_afb3e1ec();
        level thread function_d77f495e();
        level thread function_916a2011();
        util::delay(5, undefined, &zm_audio::function_709246c9, #"m_quest", #"ambient_change");
        level flag::wait_till(#"hash_349bc60cedc7491e");
        streamermodelhint(#"p8_zm_zod_teleport_symbol", 10);
        streamermodelhint(#"hash_15e8ba772c745d63", 10);
        level thread function_c5097b43();
        music::setmusicstate("none");
        level.musicsystemoverride = 0;
        wait 1;
        foreach (player in util::get_active_players()) {
            player clientfield::set("bs_player_ice_br_cf", 0);
            player clientfield::set_to_player("" + #"camera_snow", 0);
        }
        function_116a741(0, 0);
        level.zm_bgb_anywhere_but_here_validation_override = &zm_zodt8::function_869d6f66;
    }
}

// Namespace zodt8_sentinel/zm_zodt8_sentinel_trial
// Params 2, eflags: 0x0
// Checksum 0x95ea2457, Offset: 0xd9b8
// Size: 0x218
function function_6dc1a9ad(var_758116d, ended_early) {
    if (ended_early) {
        level flag::set(#"hash_349bc60cedc7491e");
    }
    if (!var_758116d) {
        playsoundatposition(#"hash_e0f3775083de381", (0, 0, 0));
        function_5bb589b4();
    }
    level.a_mdl_blockers = undefined;
    level.var_64cb91 = undefined;
    level.var_9871cdf5 = undefined;
    level.var_fe52218 = undefined;
    level flag::set("spawn_zombies");
    level flag::set("zombie_drop_powerups");
    level flag::clear(#"hash_767ce45fce848b88");
    level flag::clear(#"disable_fast_travel");
    level flag::clear(#"pause_round_timeout");
    level clientfield::set("fasttravel_exploder", 1);
    foreach (player in util::get_active_players()) {
        player clientfield::set("bs_player_ice_br_cf", 0);
        player clientfield::set_to_player("" + #"camera_snow", 0);
    }
}

// Namespace zodt8_sentinel/zm_zodt8_sentinel_trial
// Params 0, eflags: 0x0
// Checksum 0x2f928f0c, Offset: 0xdbd8
// Size: 0x4e4
function function_916a2011() {
    level endon(#"hash_349bc60cedc7491e");
    n_round = zm_round_logic::get_round_number();
    a_players = util::get_active_players();
    n_players = a_players.size;
    foreach (player in a_players) {
        player clientfield::set("bs_player_ice_br_cf", 1);
    }
    switch (n_players) {
    case 1:
        n_time = 165;
        break;
    case 2:
        n_time = 150;
        break;
    case 3:
        n_time = 135;
        break;
    case 4:
        n_time = 120;
        break;
    }
    n_increment = n_time / 9;
    var_8e71d029 = n_time;
    while (var_8e71d029 > 0) {
        streamermodelhint(#"hash_55657a69ddb2f287" + "dmg_01", n_increment);
        streamermodelhint(#"hash_55657a69ddb2f287" + "dmg_02", n_increment);
        streamermodelhint(#"hash_55657a69ddb2f287" + "dmg_03", n_increment);
        if (var_8e71d029 < n_increment) {
            wait var_8e71d029;
        } else {
            wait n_increment;
        }
        foreach (player in a_players) {
            if (isdefined(player)) {
                player clientfield::increment_to_player("" + #"hash_7a927551ca199a1c", 1);
            }
        }
        var_8e71d029 -= n_increment;
        /#
            if (var_8e71d029 > 0) {
                iprintlnbold(int(var_8e71d029) + "<dev string:x20f>");
            }
        #/
    }
    level notify(#"frozen_timeout");
    foreach (player in a_players) {
        if (isdefined(player)) {
            player clientfield::increment_to_player("" + #"hash_7a927551ca199a1c", 1);
            player clientfield::set_to_player("" + #"camera_snow", 0);
            player clientfield::set("bs_player_ice_br_cf", 0);
        }
    }
    level thread function_6e476f9(n_round);
    function_5bb589b4();
    level flag::set("spawn_zombies");
    level flag::set("zombie_drop_powerups");
    level flag::clear(#"disable_fast_travel");
    level flag::clear(#"pause_round_timeout");
    level.var_fe52218 = undefined;
    level clientfield::set("fasttravel_exploder", 1);
}

// Namespace zodt8_sentinel/zm_zodt8_sentinel_trial
// Params 1, eflags: 0x0
// Checksum 0xb39afe4c, Offset: 0xe0c8
// Size: 0x3ac
function function_6e476f9(n_round) {
    level thread function_c5097b43(0);
    music::setmusicstate("none");
    level.musicsystemoverride = 0;
    wait 0.5;
    function_116a741(0, 0);
    if (n_round == zm_round_logic::get_round_number()) {
        level waittill(#"end_of_round");
    }
    s_reset = struct::get(#"hash_ac4daece2f09a95");
    mdl_sun = util::spawn_model("tag_origin", s_reset.origin + (0, 0, 90000));
    mdl_sun moveto(s_reset.origin + (0, 0, 20), 9, 5, 0.5);
    mdl_sun clientfield::set("" + #"essence_fx", 1);
    mdl_sun playloopsound(#"hash_5a4997dc84f6d680");
    mdl_sun waittill(#"movedone");
    mdl_sun clientfield::set("" + #"land_fx", 1);
    mdl_sun rotate((15, 50, 0));
    mdl_sun playsound(#"hash_6e67e59759b21e8e");
    mdl_sun playloopsound(#"hash_733ab9b8fda8f02b");
    s_reset function_745d78b();
    mdl_sun clientfield::set("" + #"essence_fx", 0);
    mdl_sun delete();
    s_blockers = struct::get_array(#"mq_block", "script_noteworthy");
    foreach (s_blocker in s_blockers) {
        s_blocker.b_spawned = undefined;
    }
    level.musicsystemoverride = 1;
    music::setmusicstate("frozen");
    function_afb3e1ec();
    level thread function_d77f495e();
    function_916a2011();
}

// Namespace zodt8_sentinel/zm_zodt8_sentinel_trial
// Params 0, eflags: 0x0
// Checksum 0xe4e303ec, Offset: 0xe480
// Size: 0x19c
function function_afb3e1ec() {
    level flag::set(#"disable_fast_travel");
    level clientfield::set("fasttravel_exploder", 0);
    level thread function_c5097b43();
    wait 0.5;
    function_116a741();
    s_blockers = struct::get_array(#"hash_653ae82f1c11d82c");
    level.a_mdl_blockers = [];
    level.var_64cb91 = 0;
    n_players = util::get_active_players().size;
    n_health = int(20000 * 0.2 + 20000 * 0.8 * n_players);
    foreach (s_blocker in s_blockers) {
        function_784ddccf(s_blocker, n_health);
        waitframe(0);
    }
}

// Namespace zodt8_sentinel/zm_zodt8_sentinel_trial
// Params 2, eflags: 0x0
// Checksum 0x97ab9da5, Offset: 0xe628
// Size: 0x172
function function_784ddccf(s_blocker, n_health) {
    mdl_blocker = util::spawn_model(#"hash_55657a69ddb2f287" + "full", s_blocker.origin, s_blocker.angles);
    mdl_blocker function_908a655e();
    mdl_blocker disconnectpaths();
    mdl_blocker.health = n_health;
    mdl_blocker.var_29ed62b2 = #"inanimate";
    mdl_blocker thread function_cbee8983(s_blocker, n_health);
    s_blocker thread function_6aa8c536(mdl_blocker);
    if (!isdefined(level.a_mdl_blockers)) {
        level.a_mdl_blockers = [];
    } else if (!isarray(level.a_mdl_blockers)) {
        level.a_mdl_blockers = array(level.a_mdl_blockers);
    }
    level.a_mdl_blockers[level.a_mdl_blockers.size] = mdl_blocker;
}

// Namespace zodt8_sentinel/zm_zodt8_sentinel_trial
// Params 2, eflags: 0x0
// Checksum 0x6a1a5f82, Offset: 0xe7a8
// Size: 0x464
function function_cbee8983(s_blocker, n_health) {
    level endon(#"frozen_timeout", #"hash_349bc60cedc7491e");
    self val::set(#"mq_block", "takedamage", 1);
    self clientfield::set("" + #"hash_3400ccffbd3d73b3", 1);
    b_shrunk = 0;
    var_52ca1311 = 0;
    var_6a74ab80 = n_health * 0.666;
    var_c420d452 = n_health * 0.333;
    var_3c72b1a0 = int(n_health / 6);
    while (self.health > 0) {
        s_result = self waittill(#"damage");
        if (s_result.amount >= var_3c72b1a0 && self.health > var_3c72b1a0) {
            self.health += s_result.amount - var_3c72b1a0;
        }
        var_ec58dae3 = s_result.amount >= self.health;
        s_result.attacker util::show_hit_marker(var_ec58dae3);
        if (!var_52ca1311 && self.health < var_6a74ab80) {
            if (self.health < var_c420d452) {
                var_52ca1311 = 1;
                self setmodel(#"hash_55657a69ddb2f287" + "dmg_02");
                self clientfield::set("" + #"hash_3400ccffbd3d73b3", 3);
                continue;
            }
            if (!b_shrunk) {
                b_shrunk = 1;
                self setmodel(#"hash_55657a69ddb2f287" + "dmg_01");
                self clientfield::set("" + #"hash_3400ccffbd3d73b3", 2);
            }
        }
    }
    level.var_64cb91++;
    self connectpaths();
    self setmodel(#"hash_55657a69ddb2f287" + "dmg_03");
    self clientfield::set("" + #"hash_3400ccffbd3d73b3", 0);
    foreach (var_965702a0 in struct::get_array(s_blocker.target)) {
        if (var_965702a0.b_spawned !== 1) {
            var_965702a0.b_spawned = 1;
            function_784ddccf(var_965702a0, n_health);
            waitframe(1);
        }
    }
    if (s_blocker.script_string === #"hash_3f00f45f819284ba") {
        level flag::set(#"hash_349bc60cedc7491e");
        return;
    }
    if (level.var_64cb91 == 5) {
        zm_powerups::specific_powerup_drop("full_ammo", s_blocker.origin);
    }
}

// Namespace zodt8_sentinel/zm_zodt8_sentinel_trial
// Params 0, eflags: 0x0
// Checksum 0x10783e34, Offset: 0xec18
// Size: 0xb0
function function_5bb589b4() {
    array::remove_undefined(level.a_mdl_blockers);
    foreach (mdl_blocker in level.a_mdl_blockers) {
        mdl_blocker connectpaths();
        mdl_blocker delete();
    }
}

// Namespace zodt8_sentinel/zm_zodt8_sentinel_trial
// Params 0, eflags: 0x0
// Checksum 0x353d8922, Offset: 0xecd0
// Size: 0x492
function function_d77f495e() {
    level flag::clear("spawn_zombies");
    level flag::clear("zombie_drop_powerups");
    level flag::set(#"pause_round_timeout");
    level.var_fe52218 = 1;
    level thread stoker_cleanup();
    level endon(#"spawn_zombies", #"hash_349bc60cedc7491e");
    n_round_number = max(level.round_number, 20);
    n_max = zombie_utility::get_zombie_var(#"zombie_max_ai");
    var_2ab019b7 = array(#"transform1", #"transform2", #"transform3", #"transform4");
    level.var_9871cdf5 = 0;
    while (true) {
        a_s_spawnpoints = get_spawnpoints(1, 5);
        if (!a_s_spawnpoints.size) {
            wait 0.1;
            continue;
        }
        foreach (s_spawnpoint in a_s_spawnpoints) {
            spawner = array::random(level.zombie_spawners);
            ai = zombie_utility::spawn_zombie(spawner, spawner.targetname, s_spawnpoint, n_round_number);
            if (isdefined(ai)) {
                ai.var_f7038080 = 1;
                ai.exclude_cleanup_adding_to_total = 1;
                ai util::delay(15, "death", &function_75d759c6, 9, array::random(var_2ab019b7));
                s_spawnpoint.var_a5751315 = 1;
                s_spawnpoint util::delay(1, undefined, &clear_spawnpoint);
                waitframe(randomintrange(10, 15));
            }
            for (a_ai_enemies = getaiteamarray(level.zombie_team); getaiteamarray(level.zombie_team).size >= n_max; a_ai_enemies = getaiteamarray(level.zombie_team)) {
                var_bf43e1ef = 0;
                foreach (ai_enemy in a_ai_enemies) {
                    ai_enemy zm_cleanup::do_cleanup_check(1048576);
                    util::wait_network_frame();
                    var_dd5555ac = getaiteamarray(level.zombie_team);
                    if (var_dd5555ac.size < n_max - 5) {
                        var_bf43e1ef = 1;
                        break;
                    }
                }
                if (var_bf43e1ef) {
                    break;
                }
            }
        }
    }
}

// Namespace zodt8_sentinel/zm_zodt8_sentinel_trial
// Params 0, eflags: 0x0
// Checksum 0x3ac14815, Offset: 0xf170
// Size: 0xe
function clear_spawnpoint() {
    self.var_a5751315 = undefined;
}

// Namespace zodt8_sentinel/zm_zodt8_sentinel_trial
// Params 2, eflags: 0x0
// Checksum 0x5a529efe, Offset: 0xf188
// Size: 0x312
function get_spawnpoints(var_f08505be = 1, var_94a270f2) {
    a_s_spawnpoints = [];
    foreach (player in util::get_active_players()) {
        if (!isalive(player)) {
            continue;
        }
        s_zone = player zm_utility::get_current_zone(1);
        if (!isdefined(s_zone)) {
            continue;
        }
        a_s_spawnpoints = arraycombine(a_s_spawnpoints, struct::get_array(s_zone.name + "_spawns"), 0, 0);
        if (var_f08505be) {
            var_ba54090 = getarraykeys(s_zone.adjacent_zones);
            foreach (str_zone in var_ba54090) {
                if (s_zone.adjacent_zones[str_zone].is_connected) {
                    a_s_spawnpoints = arraycombine(a_s_spawnpoints, struct::get_array(str_zone + "_spawns"), 0, 0);
                }
            }
        }
    }
    a_s_spawnpoints = function_c3e29f21(a_s_spawnpoints);
    foreach (s_spawn in a_s_spawnpoints) {
        if (s_spawn.var_a5751315 === 1) {
            arrayremovevalue(a_s_spawnpoints, s_spawn, 1);
        }
    }
    if (a_s_spawnpoints.size) {
        s_final = struct::get(#"hash_3f00f45f819284ba", "script_string");
        a_s_spawnpoints = arraysortclosest(a_s_spawnpoints, s_final.origin, var_94a270f2);
    }
    return a_s_spawnpoints;
}

// Namespace zodt8_sentinel/zm_zodt8_sentinel_trial
// Params 1, eflags: 0x0
// Checksum 0x1312873f, Offset: 0xf4a8
// Size: 0x3ec
function function_6aa8c536(mdl_blocker) {
    level endon(#"frozen_timeout", #"hash_349bc60cedc7491e", #"spawn_zombies");
    mdl_blocker waittill(#"death");
    waitframe(randomint(5));
    a_players = util::get_active_players();
    a_spawn_structs = struct::get_array(self.script_spawn, "script_spawn");
    var_cf5c514d = arraycopy(a_spawn_structs);
    foreach (s_spawn in a_spawn_structs) {
        if (s_spawn.targetname !== #"step7_stoker" && s_spawn.targetname !== #"hash_21b17b50ba89b6ae" || isdefined(s_spawn.script_int) && s_spawn.script_int > a_players.size) {
            arrayremovevalue(var_cf5c514d, s_spawn, 1);
            continue;
        }
        foreach (player in a_players) {
            if (isdefined(player) && player util::is_looking_at(s_spawn.origin, undefined, 1, (0, 0, 32))) {
                arrayremovevalue(var_cf5c514d, s_spawn, 1);
                continue;
            }
            waitframe(0);
        }
    }
    n_round_number = max(level.round_number, 20);
    var_cf5c514d = array::remove_undefined(var_cf5c514d);
    var_cf5c514d = arraysortclosest(var_cf5c514d, self.origin, a_players.size);
    foreach (s_spawn in var_cf5c514d) {
        if (s_spawn.targetname == #"step7_stoker") {
            ai_stoker = zombie_utility::spawn_zombie(level.a_sp_stoker[0], "stoker", s_spawn, n_round_number);
            if (isdefined(ai_stoker)) {
                ai_stoker.var_f7038080 = 1;
            }
        } else if (s_spawn.targetname == #"hash_21b17b50ba89b6ae") {
            function_e106810(s_spawn, n_round_number);
        }
        waitframe(0);
    }
}

// Namespace zodt8_sentinel/zm_zodt8_sentinel_trial
// Params 2, eflags: 0x0
// Checksum 0x9cdded50, Offset: 0xf8a0
// Size: 0xd4
function function_e106810(s_spawn_point, n_round_number) {
    var_72b1d5c = getspawnerarray("zombie_blight_father_spawner", "script_noteworthy");
    var_72b1d5c[0].script_forcespawn = 1;
    ai_blight_father = zombie_utility::spawn_zombie(var_72b1d5c[0], undefined, s_spawn_point, n_round_number);
    if (!isdefined(ai_blight_father)) {
        return;
    }
    ai_blight_father.var_f7038080 = 1;
    ai_blight_father zm_transform::function_b028c09b();
    ai_blight_father forceteleport(s_spawn_point.origin, s_spawn_point.angles);
}

// Namespace zodt8_sentinel/zm_zodt8_sentinel_trial
// Params 0, eflags: 0x0
// Checksum 0x9364c85d, Offset: 0xf980
// Size: 0x276
function stoker_cleanup() {
    n_max_dist = 2500;
    while (!level flag::get("spawn_zombies") && !level flag::get(#"hash_349bc60cedc7491e")) {
        var_a4efa591 = undefined;
        a_stokers = getaiarchetypearray("stoker");
        if (a_stokers.size > 5) {
            foreach (stoker in a_stokers) {
                foreach (player in util::get_active_players()) {
                    if (stoker cansee(player)) {
                        arrayremovevalue(a_stokers, stoker);
                        break;
                    }
                    n_dist = distancesquared(player.origin, stoker.origin);
                    if (n_dist > n_max_dist) {
                        n_max_dist = n_dist;
                        var_a4efa591 = stoker;
                    }
                    waitframe(1);
                }
            }
            if (isdefined(var_a4efa591)) {
                if (zm_utility::is_magic_bullet_shield_enabled(var_a4efa591)) {
                    var_a4efa591 util::stop_magic_bullet_shield();
                }
                assert(var_a4efa591.allowdeath);
                var_a4efa591 kill();
            }
        }
        wait 3;
    }
}

// Namespace zodt8_sentinel/zm_zodt8_sentinel_trial
// Params 1, eflags: 0x0
// Checksum 0x87f2bde0, Offset: 0xfc00
// Size: 0x5c
function function_5b246e85(var_758116d) {
    level zm_ui_inventory::function_31a39683(#"zm_zodt8_sentinel_trial", 8);
    if (!var_758116d) {
        function_164f3009();
        function_895e3443();
    }
}

// Namespace zodt8_sentinel/zm_zodt8_sentinel_trial
// Params 2, eflags: 0x0
// Checksum 0xe97511fb, Offset: 0xfc68
// Size: 0x64
function function_7d6b6ff6(var_758116d, ended_early) {
    level flag::clear(#"hash_280d10a2ac060edb");
    if (!var_758116d) {
        playsoundatposition(#"hash_e0f3075083dd79c", (0, 0, 0));
    }
}

// Namespace zodt8_sentinel/zm_zodt8_sentinel_trial
// Params 0, eflags: 0x0
// Checksum 0x53d67c75, Offset: 0xfcd8
// Size: 0x1dc
function function_164f3009() {
    s_struct = struct::get(#"final_portal");
    s_struct.var_617a0e15 = 1;
    level thread function_4b4c52d6(s_struct, s_struct);
    util::delay(5, undefined, &function_4e5ced81, s_struct.origin, #"circle_appears");
    s_struct function_745d78b();
    s_struct.var_7a783ef2 = 0;
    function_e5f7e1a7(getent("iceberg_water", "targetname") getentitynumber());
    level clientfield::set("" + #"hash_3c58464f16d8a1be", 1);
    level flag::set(#"hash_280d10a2ac060edb");
    level flag::clear("spawn_zombies");
    level flag::set(#"pause_round_timeout");
    level flag::set(#"disable_fast_travel");
    level clientfield::set("fasttravel_exploder", 0);
}

// Namespace zodt8_sentinel/zm_zodt8_sentinel_trial
// Params 0, eflags: 0x0
// Checksum 0x6b936285, Offset: 0xfec0
// Size: 0x3d8
function function_e74baa6() {
    a_spawns = struct::get_array(#"water_corpse");
    var_4743a8e3 = getspawnerarray("spawner_zombie_water", "targetname")[0];
    a_corpses = [];
    var_f7e5b03 = 0;
    level thread function_d0cb691b();
    foreach (spawn in a_spawns) {
        ai_corpse = var_4743a8e3 spawnfromspawner(0, 1, 1, 1);
        if (!isdefined(ai_corpse)) {
            var_f7e5b03++;
            if (var_f7e5b03 < 20) {
                if (!isdefined(a_spawns)) {
                    a_spawns = [];
                } else if (!isarray(a_spawns)) {
                    a_spawns = array(a_spawns);
                }
                a_spawns[a_spawns.size] = spawn;
            }
            waitframe(1);
            continue;
        }
        if (!isdefined(a_corpses)) {
            a_corpses = [];
        } else if (!isarray(a_corpses)) {
            a_corpses = array(a_corpses);
        }
        a_corpses[a_corpses.size] = ai_corpse;
        ai_corpse.var_7f76d1b2 = 1;
        ai_corpse.b_ignore_cleanup = 1;
        ai_corpse.dont_throw_gib = 1;
        ai_corpse forceteleport(spawn.origin, spawn.angles);
        util::wait_network_frame();
        ai_corpse kill();
        ai_corpse startragdoll(1);
        waitframe(1);
    }
    foreach (player in util::get_active_players()) {
        player clientfield::set_to_player("" + #"hash_58b44c320123e829", 1);
    }
    level flag::wait_till_clear(#"hash_280d10a2ac060edb");
    foreach (ai in a_corpses) {
        if (isdefined(ai)) {
            ai delete();
        }
    }
}

// Namespace zodt8_sentinel/zm_zodt8_sentinel_trial
// Params 0, eflags: 0x0
// Checksum 0x41cf324d, Offset: 0x102a0
// Size: 0x3b8
function function_d0cb691b() {
    a_props = [];
    a_str_models = array("p7_shr_weapon_axe_03", "p7_shr_weapon_axe_04", "p7_shr_weapon_spear_med", "p7_shr_weapon_spear_sml", "p7_shr_weapon_bow_02", "p7_shr_suit_armor_helmet_03", "p7_shr_weapon_axe_03", "p7_shr_weapon_spear_med", "p7_shr_weapon_bow_02", "p7_shr_suit_armor_helmet_03");
    a_str_models = array::randomize(a_str_models);
    a_spots = array::randomize(struct::get_array(#"water_prop", "script_noteworthy"));
    foreach (spot in a_spots) {
        n_x_offset = randomintrange(-128, 128);
        n_y_offset = randomintrange(-128, 128);
        n_z_offset = randomintrange(-64, 64);
        str_model = array::pop_front(a_str_models);
        mdl_prop = util::spawn_model(str_model, spot.origin + (n_x_offset, n_y_offset, n_z_offset), spot.angles + (n_x_offset, n_y_offset, n_z_offset));
        if (!isdefined(a_props)) {
            a_props = [];
        } else if (!isarray(a_props)) {
            a_props = array(a_props);
        }
        a_props[a_props.size] = mdl_prop;
        mdl_prop rotate((randomint(10), randomint(10), randomint(10)));
        mdl_prop clientfield::set("" + #"water_props", 1);
        if (!a_str_models.size) {
            return;
        }
        waitframe(1);
    }
    level waittill(#"hash_78e23a0f092a6560");
    foreach (mdl_prop in a_props) {
        if (isdefined(mdl_prop)) {
            mdl_prop delete();
        }
    }
}

// Namespace zodt8_sentinel/zm_zodt8_sentinel_trial
// Params 0, eflags: 0x0
// Checksum 0xfafad479, Offset: 0x10660
// Size: 0xacc
function function_895e3443() {
    var_cf043a88 = getent("forget_what_you_know", "targetname");
    a_scenes = scene::get_active_scenes("p8_fxanim_zm_zod_skybox_bundle");
    if (!isdefined(a_scenes)) {
        a_scenes = scene::get_inactive_scenes("p8_fxanim_zm_zod_skybox_bundle");
    }
    if (!a_scenes.size) {
        a_icebergs = array();
    } else {
        a_icebergs = a_scenes[0].scene_ents;
    }
    a_names = getarraykeys(a_icebergs);
    level scene::stop("p8_fxanim_zm_zod_skybox_bundle");
    for (i = 0; i < a_icebergs.size; i++) {
        if (!isdefined(a_names[i]) || !isdefined(a_icebergs[a_names[i]]) || !ishash(a_names[i]) || a_names[i] === #"skybox_water") {
            arrayremovevalue(a_icebergs, a_icebergs[a_names[i]], 0);
        }
    }
    if (!isdefined(a_icebergs)) {
        a_icebergs = [];
    } else if (!isarray(a_icebergs)) {
        a_icebergs = array(a_icebergs);
    }
    a_icebergs[a_icebergs.size] = var_cf043a88;
    s_tree = struct::get(#"hash_1022226235c54b6");
    if (!getdvarint(#"hash_7919e37cd5d57659", 0)) {
        level.zm_bgb_anywhere_but_here_validation_override = &return_false;
        s_loc = struct::get(#"hash_3f00f45f819284ba", "script_string");
        level thread function_d6d7f516(#"interior_interact", s_loc);
        foreach (player in util::get_active_players()) {
            player clientfield::set_to_player("" + #"icy_bubbles", 1);
        }
        level thread function_e74baa6();
        level waittill(#"hash_332a98e65f5dce4");
        level.musicsystemoverride = 1;
        music::setmusicstate("location_tree");
        a_players = util::get_active_players();
        foreach (player in a_players) {
            player.var_8105b7f6 = 1;
            player val::set(#"iceberg_event", "takedamage", 0);
            player val::set(#"iceberg_event", "ignoreme", 1);
        }
        var_67b6d91b = getent("special_entity", "targetname");
        if (isdefined(var_67b6d91b)) {
            var_67b6d91b clientfield::set("" + #"pulse_shader", 1);
        }
        level thread function_116a741();
        var_28d1a02 = spawn("script_origin", s_tree.origin);
        var_28d1a02 playloopsound(#"hash_73e107b21dfb7f37");
        s_tree function_745d78b(128);
        var_28d1a02 delete();
        function_4a750308(s_tree);
    }
    foreach (player in util::get_active_players()) {
        player clientfield::set_to_player("" + #"icy_bubbles", 0);
    }
    var_cf043a88 show();
    level thread function_d6d7f516(#"iceberg_viewing", s_tree);
    level waittill(#"hash_332a98e65f5dce4");
    level clientfield::set("" + #"hash_3c58464f16d8a1be", 0);
    music::setmusicstate("none");
    level.musicsystemoverride = 0;
    waitframe(1);
    util::delay(5, undefined, &zm_audio::function_709246c9, #"m_quest", #"hash_64499c01670a6e");
    a_players = util::get_active_players();
    foreach (player in a_players) {
        player.var_8105b7f6 = 0;
        player val::reset(#"iceberg_event", "freezecontrols_allowlook");
        player val::set(#"iceberg_event", "freezecontrols", 1);
        player playrumbleonentity(#"hash_676e72d4bae843ff");
    }
    exploder::exploder("exp_lgt_ice_rise");
    var_cf043a88.origin -= (0, 0, 14400);
    var_cf043a88 playsound(#"hash_56a05b30f7dab873");
    foreach (ent in a_icebergs) {
        ent moveto(ent.origin + (0, 0, 14400), 45, 10, 10);
    }
    var_cf043a88 clientfield::set("" + #"hash_15b23de7589e61a", 1);
    exploder::exploder("exp_iceberg_splashes");
    wait 7.5;
    level flag::clear(#"hash_280d10a2ac060edb");
    level thread zodt8_eye::function_3f0fcd31("boss_blocker_stage_pd", 1);
    foreach (player in a_players) {
        if (isdefined(player)) {
            player val::reset(#"iceberg_event", "freezecontrols");
            player val::reset(#"iceberg_event", "disable_weapons");
            player val::reset(#"iceberg_event", "takedamage");
            player val::reset(#"iceberg_event", "ignoreme");
        }
    }
    var_cf043a88 waittill(#"movedone");
    level thread function_d87e96fe(var_cf043a88, a_icebergs, 14400);
}

// Namespace zodt8_sentinel/zm_zodt8_sentinel_trial
// Params 3, eflags: 0x0
// Checksum 0x833103f3, Offset: 0x11138
// Size: 0x134
function function_d87e96fe(var_a6e2f905, a_icebergs, var_b3413122) {
    wait 5;
    var_a6e2f905 playsound(#"hash_474e149664b1d903");
    foreach (mdl in a_icebergs) {
        mdl moveto(mdl.origin - (0, 0, var_b3413122), 15, 13, 2);
    }
    mdl waittill(#"movedone");
    var_a6e2f905 clientfield::set("" + #"hash_15b23de7589e61a", 0);
}

// Namespace zodt8_sentinel/zm_zodt8_sentinel_trial
// Params 1, eflags: 0x0
// Checksum 0xfc256c89, Offset: 0x11278
// Size: 0x6b0
function function_4a750308(s_tree) {
    mdl_artifact = util::spawn_model(#"hash_3cdbd25e43a09930", s_tree.origin + (-48, 0, 0), s_tree.angles + (0, 180, 0));
    mdl_artifact notsolid();
    mdl_artifact playloopsound(#"hash_e2c71c7dece38ee");
    mdl_artifact playsound(#"hash_7e9d06805545fcfe");
    v_offset = (-4, 0, 16);
    mdl_artifact moveto(s_tree.origin + v_offset, 4);
    var_edc03be6 = struct::get_array(#"hash_78dd4413a014e785");
    a_players = util::get_active_players();
    a_players = arraysort(a_players, s_tree.origin, 0);
    foreach (player in a_players) {
        player playersetgroundreferenceent(undefined);
        player clientfield::set_to_player("" + #"iceberg_rumbles", 1);
        var_edc03be6 = arraysortclosest(var_edc03be6, player.origin);
        var_a62b38b1 = struct::get(var_edc03be6[0].target);
        var_e27f6d44 = util::spawn_model("tag_origin", player.origin, player.angles);
        player playerlinktodelta(var_e27f6d44, "tag_origin", 1, 30, 30, 30, 30, 1, 1);
        player ghost();
        player val::set(#"iceberg_event", "freezecontrols", 1);
        player val::set(#"iceberg_event", "disable_weapons", 1);
        var_e27f6d44 thread function_8192f641(var_edc03be6[0], var_a62b38b1, player);
        arrayremoveindex(var_edc03be6, 0);
        waitframe(0);
    }
    level waittill(#"hash_78e23a0f092a6560");
    mdl_artifact clientfield::set("" + #"hash_46e2ed49fb0f55c6", 1);
    var_47ee7db6 = getent("veh_fasttravel_cam", "targetname");
    n_wait = 5;
    for (i = 0; i < 9; i++) {
        nd_path = getvehiclenode("orb_path_" + i, "targetname");
        if (isdefined(nd_path)) {
            veh_orb = spawner::simple_spawn_single(var_47ee7db6);
            veh_orb clientfield::set("" + #"orb_fx", 1);
            veh_orb thread function_9f15d5a1(nd_path);
        }
        if (i == 8) {
            veh_orb playrumbleonentity(#"hash_107ea3f0e402de58");
            veh_orb playsound(#"hash_36c85a4ee28dd7a");
        }
        wait n_wait;
        n_wait *= 0.6;
        if (i == 2 || i == 4) {
            n_wait += 1;
        }
    }
    mdl_artifact clientfield::set("" + #"hash_46e2ed49fb0f55c6", 0);
    veh_orb waittilltimeout(10, #"reached_end_node");
    playsoundatposition(#"hash_1a6436fc53efe56f", (0, 0, 0));
    level thread function_c5097b43(1);
    wait 1;
    foreach (player in a_players) {
        if (isdefined(player)) {
            player playersetgroundreferenceent(level.e_sway);
        }
    }
}

// Namespace zodt8_sentinel/zm_zodt8_sentinel_trial
// Params 1, eflags: 0x0
// Checksum 0xbe6e8b53, Offset: 0x11930
// Size: 0x264
function function_9f15d5a1(nd_path) {
    self vehicle::get_on_and_go_path(nd_path);
    self clientfield::set("" + #"orb_fx", 0);
    if (isdefined(nd_path.targetname)) {
        switch (nd_path.targetname) {
        case #"hash_7762924fc6051394":
            str_model = #"p8_zm_zod_planets_mercury_large";
            break;
        case #"hash_7762954fc60518ad":
            str_model = #"p8_zm_zod_planets_venus_large";
            break;
        case #"hash_7762944fc60516fa":
            str_model = #"p8_zm_zod_planets_mars_large";
            break;
        case #"hash_77628f4fc6050e7b":
            str_model = #"p8_zm_zod_planets_jupiter_large";
            break;
        case #"hash_77628e4fc6050cc8":
            str_model = #"p8_zm_zod_planets_saturn_large";
            break;
        case #"hash_7762914fc60511e1":
            str_model = #"p8_zm_zod_planets_uranus_large";
            break;
        case #"hash_7762904fc605102e":
            str_model = #"p8_zm_zod_planets_neptune_large";
            break;
        case #"hash_7762934fc6051547":
            str_model = #"p8_zm_zod_planets_sun_large";
            break;
        }
        if (isdefined(str_model)) {
            mdl_planet = util::spawn_model(str_model, self.origin, nd_path.angles);
            mdl_planet setscale(nd_path.n_scale);
        }
    }
    level waittill(#"hash_332a98e65f5dce4");
    if (isdefined(mdl_planet)) {
        mdl_planet delete();
    }
    self delete();
}

// Namespace zodt8_sentinel/zm_zodt8_sentinel_trial
// Params 3, eflags: 0x0
// Checksum 0x4ec40d9c, Offset: 0x11ba0
// Size: 0x224
function function_8192f641(s_setup, s_pushback, player) {
    self moveto(s_setup.origin, 2);
    wait 0.5;
    self rotateto(s_setup.angles, 1.5);
    player playerlinktoblend(self, "tag_origin");
    wait 3.5;
    level notify(#"hash_78e23a0f092a6560");
    wait 0.1;
    player clientfield::set_to_player("" + #"iceberg_rumbles", 0);
    player val::reset(#"iceberg_event", "freezecontrols");
    player val::set(#"iceberg_event", "freezecontrols_allowlook", 1);
    self moveto(s_pushback.origin, 8, 0.1, 6);
    self rotateto(s_pushback.angles, 8);
    player playerlinktoblend(self, "tag_origin");
    self waittill(#"movedone");
    s_setup struct::delete();
    s_pushback struct::delete();
    self delete();
}

// Namespace zodt8_sentinel/zm_zodt8_sentinel_trial
// Params 1, eflags: 0x0
// Checksum 0xf897ed5e, Offset: 0x11dd0
// Size: 0x274
function function_3c987f5c(var_758116d) {
    level zm_ui_inventory::function_31a39683(#"zm_zodt8_sentinel_trial", 9);
    foreach (s_magic_box in level.chests) {
        for (i = 0; i < s_magic_box.zbarrier getnumzbarrierpieces(); i++) {
            s_magic_box.zbarrier hidezbarrierpiece(i);
        }
        if (isdefined(s_magic_box.zbarrier.var_bc9343a5)) {
            s_magic_box.zbarrier.var_bc9343a5 thread scene::stop(1);
        }
    }
    if (!var_758116d) {
        foreach (player in util::get_players()) {
            if (player util::is_spectating()) {
                player thread zm_player::spectator_respawn_player();
            }
        }
        level.zm_bgb_anywhere_but_here_validation_override = &return_false;
        zm_sq::start(#"boss_fight");
        util::delay(15, undefined, &zm_audio::function_709246c9, #"m_quest", #"hash_678e2313c5dd09fa");
        level flag::wait_till(#"hash_25d8c88ff3f91ee5");
    }
}

// Namespace zodt8_sentinel/zm_zodt8_sentinel_trial
// Params 2, eflags: 0x0
// Checksum 0x2c727d80, Offset: 0x12050
// Size: 0x14
function function_1f3697df(var_758116d, ended_early) {
    
}

// Namespace zodt8_sentinel/zm_zodt8_sentinel_trial
// Params 1, eflags: 0x0
// Checksum 0x21a108, Offset: 0x12070
// Size: 0x410
function function_4693caa8(var_758116d) {
    level clientfield::set("" + #"hash_3c58464f16d8a1be", 1);
    level flag::clear("spawn_zombies");
    level flag::set(#"pause_round_timeout");
    /#
        if (getdvarint(#"zm_debug_ee", 0)) {
            zm_devgui::zombie_devgui_open_sesame();
            wait 10;
        }
    #/
    level thread function_116a741(0, 0);
    level thread function_84c28957();
    if (!level flag::get("water_drained_fore")) {
        level notify(#"hash_5625f76c55116195");
        level.e_clip_water_fore.origin = (level.e_clip_water_fore.origin[0], level.e_clip_water_fore.origin[1], level.var_ed90adf6);
        level.e_clip_water_fore rotateroll(-1.5, 0.1);
        util::wait_network_frame();
        level.e_clip_water_fore clientfield::increment("update_wave_water_height", 1);
    }
    level.e_sway clientfield::set("tilt", 0);
    level scene::stop("p8_fxanim_zm_zod_skybox_bundle");
    getent("ocean_water_hidden", "script_noteworthy") hide();
    if (level.chest_index != -1) {
        e_chest = level.chests[level.chest_index];
        e_chest zm_magicbox::hide_chest(0);
        hidemiscmodels("mdl_magic_box_base");
    }
    hidemiscmodels("pancakerabbit");
    foreach (ent in getentarray("pancakerabbit", "targetname")) {
        ent delete();
    }
    scene::delete_scene_spawned_ents("p8_fxanim_zm_zod_cargo_hold_net_bundle");
    level clientfield::set("fasttravel_exploder", 0);
    scene::function_e62681ef("cin_zm_zod_outro", &function_bdb53379, "Shot090");
    level scene::play("cin_zm_zod_outro");
    if (!getdvarint(#"zm_debug_ee", 0)) {
        level notify(#"end_game");
    }
}

// Namespace zodt8_sentinel/zm_zodt8_sentinel_trial
// Params 2, eflags: 0x0
// Checksum 0x99122d7b, Offset: 0x12488
// Size: 0x74
function function_d6d4f9b3(var_758116d, ended_early) {
    if (level.chest_index != -1) {
        e_chest = level.chests[level.chest_index];
        e_chest zm_magicbox::show_chest();
        showmiscmodels("mdl_magic_box_base");
    }
}

// Namespace zodt8_sentinel/zm_zodt8_sentinel_trial
// Params 0, eflags: 0x0
// Checksum 0xefdc908e, Offset: 0x12508
// Size: 0xf0
function function_bdb53379() {
    a_scenes = scene::get_active_scenes("p8_fxanim_zm_zod_smokestack_01_bundle");
    if (!a_scenes.size) {
        a_scenes = scene::get_inactive_scenes("p8_fxanim_zm_zod_smokestack_01_bundle");
    }
    if (a_scenes.size) {
        a_ents = a_scenes[0].scene_ents;
        if (isdefined(a_ents)) {
            foreach (ent in a_ents) {
                ent hide();
            }
        }
    }
}

// Namespace zodt8_sentinel/zm_zodt8_sentinel_trial
// Params 0, eflags: 0x0
// Checksum 0xa62034b5, Offset: 0x12600
// Size: 0x1d6
function function_84c28957() {
    setdvar(#"zombie_unlock_all", 1);
    players = getplayers();
    zombie_doors = getentarray("zombie_door", "targetname");
    for (i = 0; i < zombie_doors.size; i++) {
        if (!(isdefined(zombie_doors[i].has_been_opened) && zombie_doors[i].has_been_opened)) {
            zombie_doors[i] notify(#"trigger", {#activator:players[0]});
        }
        if (isdefined(zombie_doors[i].power_door_ignore_flag_wait) && zombie_doors[i].power_door_ignore_flag_wait) {
            zombie_doors[i] notify(#"power_on");
        }
        waitframe(1);
    }
    zombie_debris = getentarray("zombie_debris", "targetname");
    for (i = 0; i < zombie_debris.size; i++) {
        if (isdefined(zombie_debris[i])) {
            zombie_debris[i] notify(#"trigger", {#activator:players[0]});
        }
        waitframe(1);
    }
}

// Namespace zodt8_sentinel/zm_zodt8_sentinel_trial
// Params 2, eflags: 0x0
// Checksum 0x440fe85a, Offset: 0x127e0
// Size: 0xbc
function function_745d78b(n_radius = 96, str_endon) {
    s_unitrigger = self zm_unitrigger::function_87d8e33b(n_radius, 0);
    s_unitrigger.related_parent = self;
    zm_unitrigger::register_static_unitrigger(s_unitrigger, &function_ff6e319a);
    if (isdefined(str_endon)) {
        level endon(str_endon);
        level thread function_7766d9b7(s_unitrigger, str_endon);
    }
    s_unitrigger waittill(#"hash_4993ab35c53e0b5c");
}

// Namespace zodt8_sentinel/zm_zodt8_sentinel_trial
// Params 0, eflags: 0x0
// Checksum 0xd25d63d0, Offset: 0x128a8
// Size: 0x24c
function function_ff6e319a() {
    self endon(#"death");
    s_unitrigger = self.stub;
    self thread function_52128ba0(self.stub.related_parent);
    while (true) {
        self waittill(#"trigger");
        b_using = 1;
        for (n_time = 0; n_time < 0.5; n_time += 0.1) {
            foreach (player in util::get_active_players()) {
                if (player util::is_spectating()) {
                    continue;
                }
                if (!player usebuttonpressed() || !zm_utility::can_use(player) || player isinmovemode("ufo", "noclip") || !player istouching(self)) {
                    b_using = 0;
                    n_time = 0;
                    break;
                }
            }
            if (b_using == 0 || util::get_active_players().size == 0) {
                break;
            }
            wait 0.1;
        }
        if (b_using == 1) {
            break;
        }
        wait 0.1;
    }
    s_unitrigger notify(#"hash_4993ab35c53e0b5c");
    zm_unitrigger::unregister_unitrigger(s_unitrigger);
}

// Namespace zodt8_sentinel/zm_zodt8_sentinel_trial
// Params 1, eflags: 0x0
// Checksum 0xa5045275, Offset: 0x12b00
// Size: 0x3c0
function function_52128ba0(s_portal) {
    if (isdefined(s_portal.mdl_portal)) {
        self endon(#"death");
        s_portal.mdl_portal clientfield::set("" + #"teleport_sigil", 1);
        waitframe(0);
        while (true) {
            streamermodelhint(#"p8_zm_zod_teleport_symbol", 0.5);
            streamermodelhint(#"hash_15e8ba772c745d63", 0.5);
            if (s_portal.mdl_portal.var_2638ea5e === 1) {
                b_activate = 1;
                foreach (player in util::get_active_players()) {
                    if (!zm_utility::can_use(player) || !player istouching(self)) {
                        b_activate = 0;
                        break;
                    }
                }
                if (b_activate == 1 && util::get_active_players().size > 0) {
                    if (s_portal.mdl_portal.model !== #"p8_zm_zod_teleport_symbol") {
                        s_portal.mdl_portal setmodel(#"p8_zm_zod_teleport_symbol");
                        s_portal.mdl_portal playsound(#"hash_1644d20be9e19c9f");
                        s_portal.mdl_portal clientfield::set("" + #"teleport_sigil", 0);
                        if (isdefined(self.stub.related_parent.var_617a0e15) && self.stub.related_parent.var_617a0e15) {
                            self sethintstring(#"hash_6d663dca450595ef");
                        }
                    }
                } else if (s_portal.mdl_portal.model !== #"hash_15e8ba772c745d63") {
                    s_portal.mdl_portal setmodel(#"hash_15e8ba772c745d63");
                    s_portal.mdl_portal playsound(#"hash_68f60cc0248fcc9b");
                    s_portal.mdl_portal clientfield::set("" + #"teleport_sigil", 1);
                    self sethintstring("");
                }
            }
            wait 0.5;
        }
    }
}

// Namespace zodt8_sentinel/zm_zodt8_sentinel_trial
// Params 2, eflags: 0x0
// Checksum 0xe128a34c, Offset: 0x12ec8
// Size: 0x4c
function function_7766d9b7(s_unitrigger, str_endon) {
    s_unitrigger endon(#"hash_4993ab35c53e0b5c");
    level waittill(str_endon);
    zm_unitrigger::unregister_unitrigger(s_unitrigger);
}

// Namespace zodt8_sentinel/zm_zodt8_sentinel_trial
// Params 2, eflags: 0x0
// Checksum 0xb4184cc6, Offset: 0x12f20
// Size: 0x134
function function_d6d7f516(var_e5049b83, s_loc) {
    a_s_locs = struct::get_array(var_e5049b83, "script_teleport");
    a_players = util::get_active_players();
    i = 0;
    level thread function_4bdb1ac6(a_players);
    foreach (player in a_players) {
        player thread zm_fasttravel::function_fa685767(undefined, undefined, undefined, #"hash_1d62cb1087778988", a_s_locs[i], s_loc);
        i++;
    }
    level waittill(#"hash_1d62cb1087778988");
}

// Namespace zodt8_sentinel/zm_zodt8_sentinel_trial
// Params 1, eflags: 0x0
// Checksum 0x764eabf8, Offset: 0x13060
// Size: 0x48
function function_4bdb1ac6(a_players) {
    array::wait_till(a_players, #"hash_1c35eb15aa210d6", 1);
    level notify(#"hash_332a98e65f5dce4");
}

// Namespace zodt8_sentinel/zm_zodt8_sentinel_trial
// Params 3, eflags: 0x0
// Checksum 0x460775d0, Offset: 0x130b0
// Size: 0x1dc
function function_116a741(var_1aa01c2d = 0, var_c5a1c1de = 1, b_hide_body = 1) {
    foreach (ai in getaiteamarray(level.zombie_team)) {
        if (isalive(ai) && !(isdefined(ai.var_7f76d1b2) && ai.var_7f76d1b2)) {
            if (var_c5a1c1de) {
                level.zombie_total++;
                level.zombie_respawns++;
            }
            if (var_1aa01c2d || ai.archetype === "blight_father") {
                if (zm_utility::is_magic_bullet_shield_enabled(ai)) {
                    ai util::stop_magic_bullet_shield();
                }
                ai.allowdeath = 1;
                ai kill();
                if (b_hide_body) {
                    ai hide();
                    ai notsolid();
                }
            } else {
                ai delete();
            }
        }
        waitframe(0);
    }
}

// Namespace zodt8_sentinel/zm_zodt8_sentinel_trial
// Params 2, eflags: 0x0
// Checksum 0x41aa39a6, Offset: 0x13298
// Size: 0x288
function function_c5097b43(b_success = 1, var_8dc4a5ea = 1) {
    a_players = util::get_active_players();
    foreach (player in a_players) {
        player val::set(#"hash_519b32068605d08f", "takedamage", 0);
        if (var_8dc4a5ea) {
            player val::set(#"hash_519b32068605d08f", "freezecontrols", 1);
        }
        player clientfield::set_to_player("" + #"main_flash", b_success);
    }
    if (!b_success) {
        lui::screen_flash(0.5, 2, 0.5, 1, "black");
    }
    wait 0.5 + 2;
    foreach (player in a_players) {
        if (isdefined(player)) {
            player val::reset(#"hash_519b32068605d08f", "takedamage");
            if (var_8dc4a5ea) {
                player val::reset(#"hash_519b32068605d08f", "freezecontrols");
            }
            player clientfield::set_to_player("" + #"main_flash", 0);
        }
    }
}

// Namespace zodt8_sentinel/zm_zodt8_sentinel_trial
// Params 3, eflags: 0x0
// Checksum 0xc44631ac, Offset: 0x13528
// Size: 0xf2
function function_4e5ced81(v_origin, var_41750e29, str_category = #"m_quest") {
    level endon(var_41750e29 + "vo_end");
    level util::delay_notify(10, var_41750e29 + "vo_end", var_41750e29 + "vo_played");
    do {
        var_61a4871c = zm_utility::get_closest_player(v_origin);
        b_played = var_61a4871c zm_audio::create_and_play_dialog(str_category, var_41750e29);
        waitframe(1);
    } while (b_played !== 1);
    level notify(var_41750e29 + "vo_played");
    return true;
}

/#

    // Namespace zodt8_sentinel/zm_zodt8_sentinel_trial
    // Params 2, eflags: 0x0
    // Checksum 0x12436606, Offset: 0x13628
    // Size: 0x4f0
    function gear_up(b_packed, var_9eec07a2) {
        if (!isdefined(b_packed)) {
            b_packed = 1;
        }
        if (!isdefined(var_9eec07a2)) {
            var_9eec07a2 = 1;
        }
        players = getplayers();
        a_krakens = array(#"ww_tricannon_water_t8", #"ww_tricannon_air_t8", #"ww_tricannon_fire_t8");
        var_a186ad95 = array::randomize(array(#"ar_mg1909_t8", #"ww_tricannon_earth_t8", #"lmg_double_t8", array::random(a_krakens)));
        var_c78927fe = array::randomize(array(#"ar_damage_t8", #"tr_powersemi_t8", #"ar_accurate_t8", #"lmg_standard_t8"));
        foreach (player in players) {
            if (!player laststand::player_is_in_laststand()) {
                if (isdefined(player.var_871d24d3)) {
                    for (var_fe90c651 = 0; var_fe90c651 < player.var_871d24d3.size; var_fe90c651++) {
                        if (isdefined(player.var_871d24d3[var_fe90c651])) {
                            player thread zm_perks::function_79567d8a(player.var_871d24d3[var_fe90c651], var_fe90c651);
                        }
                    }
                }
                foreach (w_primary in player getweaponslistprimaries()) {
                    player takeweapon(w_primary);
                }
                weapon1 = getweapon(var_c78927fe[0]);
                weapon2 = getweapon(var_a186ad95[0]);
                arrayremovevalue(var_c78927fe, var_c78927fe[0], 0);
                arrayremovevalue(var_a186ad95, var_a186ad95[0], 0);
                if (b_packed) {
                    weapon1 = zm_devgui::get_upgrade(weapon1.rootweapon);
                    weapon2 = zm_devgui::get_upgrade(weapon2.rootweapon);
                }
                waitframe(1);
                player zm_devgui::zombie_devgui_weapon_give(#"zhield_dw");
                waitframe(1);
                player giveweapon(weapon1);
                if (var_9eec07a2 && isdefined(level.aat_in_use) && level.aat_in_use && zm_weapons::weapon_supports_aat(weapon1)) {
                    waitframe(1);
                    player aat::acquire(weapon1);
                }
                waitframe(1);
                player giveweapon(weapon2);
                if (var_9eec07a2 && isdefined(level.aat_in_use) && level.aat_in_use && zm_weapons::weapon_supports_aat(weapon2)) {
                    waitframe(1);
                    player thread aat::acquire(weapon2);
                }
            }
        }
    }

    // Namespace zodt8_sentinel/zm_zodt8_sentinel_trial
    // Params 1, eflags: 0x0
    // Checksum 0xfa7beeb6, Offset: 0x13b20
    // Size: 0x7c
    function function_fd239058(s_spark) {
        if (getdvarint(#"zm_debug_ee", 0)) {
            level waittill(#"all_players_spawned");
            level thread function_83f8b25e(s_spark);
            function_988b28c1(s_spark);
        }
    }

#/
