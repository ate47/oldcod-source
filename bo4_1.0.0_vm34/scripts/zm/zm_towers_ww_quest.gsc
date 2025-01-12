#using script_43bba08258745838;
#using scripts\core_common\ai\zombie_utility;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\fx_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\struct;
#using scripts\core_common\trigger_shared;
#using scripts\core_common\util_shared;
#using scripts\zm\zm_towers_crowd;
#using scripts\zm_common\zm_audio;
#using scripts\zm_common\zm_crafting;
#using scripts\zm_common\zm_magicbox;
#using scripts\zm_common\zm_powerups;
#using scripts\zm_common\zm_sq;
#using scripts\zm_common\zm_ui_inventory;
#using scripts\zm_common\zm_unitrigger;
#using scripts\zm_common\zm_utility;
#using scripts\zm_common\zm_vo;
#using scripts\zm_common\zm_weapons;

#namespace zm_towers_ww_quest;

// Namespace zm_towers_ww_quest/zm_towers_ww_quest
// Params 0, eflags: 0x0
// Checksum 0x1e441127, Offset: 0x548
// Size: 0xafc
function init() {
    level._effect[#"hash_42cc4bf5e47478c5"] = #"hash_387c78244f5f45e5";
    level._effect[#"hash_5b4e7c178480d885"] = #"hash_62eafc17a432322a";
    level flag::init(#"hash_57454e59c155098d");
    level flag::init(#"hash_2fb4b4431d3ed627");
    level flag::init(#"hash_40f20925227353f4");
    level flag::init(#"hash_5cdf5c960293141a");
    level flag::init(#"hash_6af037519dceda7a");
    level flag::init(#"hash_30e0e4bbbfc9b7d8");
    level flag::init(#"hash_d9ce740cc4b8285");
    level flag::init(#"hash_200151b21f16734f");
    level flag::init(#"hash_45259bb6368fc0d3");
    level flag::init(#"hash_5649f57b918f85f8");
    level flag::init(#"hash_30ca6a723fbb84e9");
    level flag::init(#"hash_1c66e5c351c08de1");
    level flag::init(#"hash_77ff9a8101ea687b");
    level flag::init(#"hash_631e8676a2fa932b");
    level flag::init(#"hash_3ac6f9944962bd4c");
    level flag::init(#"hash_786b9153c754d127");
    zm_sq::register(#"ww_quest", #"destroy_wall", #"destroy_wall", &destroy_wall_setup, &destroy_wall_cleanup);
    zm_sq::register(#"ww_quest", #"knock_brazier", #"knock_brazier", &knock_brazier_setup, &knock_brazier_cleanup);
    zm_sq::register(#"ww_quest", #"hash_32b57ffc37ccf79a", #"hash_32b57ffc37ccf79a", &function_5676e416, &function_ea51d6c5);
    zm_sq::register(#"ww_quest", #"hash_2e681afa5f81f37", #"hash_2e681afa5f81f37", &function_69645ea5, &function_c1515116);
    zm_sq::register(#"ww_quest", #"hash_27967f916a97a057", #"hash_27967f916a97a057", &function_562d2709, &function_d76e1e22);
    zm_sq::register(#"ww_quest", #"hash_34d18772151ea4fa", #"hash_34d18772151ea4fa", &function_fd7602c2, &function_8c2a7e89);
    zm_sq::register(#"ww_quest", #"hash_2e126c422fbf5654", #"hash_2e126c422fbf5654", &function_5ab6a84, &function_d6166527);
    zm_sq::register(#"ww_quest", #"hash_396293edac63aa6f", #"hash_396293edac63aa6f", &function_954019d1, &function_42fe3dea);
    zm_sq::register(#"ww_quest", #"hash_776efec5f9b03a68", #"hash_776efec5f9b03a68", &function_fd8a4508, &function_ac06b913);
    zm_sq::register(#"ww_quest", #"hash_7e929133c03a391b", #"hash_7e929133c03a391b", &function_1b8b65a5, &function_7aa93016);
    zm_sq::register(#"ww_quest", #"hash_1ab84b282c179562", #"hash_1ab84b282c179562", &function_f9a16f5a, &function_6275da01);
    zm_sq::register(#"ww_quest", #"hash_530b93342f7f39ae", #"hash_530b93342f7f39ae", &function_e0c2f8d2, &function_d6745b99);
    zm_sq::register(#"ww_quest", #"hash_38a9bcd55c0565ca", #"hash_38a9bcd55c0565ca", &function_747d88e6, &function_591d5b15);
    zm_sq::register(#"ww_quest", #"hash_2512f1281c5c7237", #"hash_2512f1281c5c7237", &function_c7ad4b1d, &function_7be8c2e);
    zm_sq::register(#"ww_quest", #"hash_4e767f415b51d0a1", #"hash_4e767f415b51d0a1", &function_afebda6b, &function_ffe88820);
    zm_sq::start(#"ww_quest", 1);
    namespace_96796d10::function_60c07221(getweapon(#"ww_crossbow_t8"));
    level scene::add_scene_func("p8_fxanim_zm_towers_ww_quest_bowl_bundle", &function_33202d12, "init");
    var_5ef98e6 = array("danu", "ra", "odin", "zeus");
    level.var_736da35d = array::random(var_5ef98e6);
    var_dc9a1b89 = var_5ef98e6;
    arrayremovevalue(var_dc9a1b89, level.var_736da35d);
    foreach (var_427b0876 in var_dc9a1b89) {
        s_unitrigger = struct::get("s_ww_quest_rough_statue_unitrigger_" + var_427b0876);
        var_9cf0730d = struct::get(s_unitrigger.target);
        var_9cf0730d struct::delete();
        s_unitrigger struct::delete();
    }
    var_9cf0730d = struct::get("s_ww_quest_rough_statue_" + level.var_736da35d);
    v_origin = var_9cf0730d.origin;
    v_angles = var_9cf0730d.angles;
    var_9cf0730d struct::delete();
    level.var_f31e81cd = util::spawn_model(#"p8_zm_gla_spile_serket_head_01", v_origin, v_angles);
    a_s_acid_traps = struct::get_array("s_ww_quest_acid_trap_unitrigger");
    array::thread_all(a_s_acid_traps, &function_205499dc);
    zm_crafting::function_80bf4df3(#"zblueprint_trap_hellpools", &function_e823b7cd);
}

// Namespace zm_towers_ww_quest/zm_towers_ww_quest
// Params 1, eflags: 0x0
// Checksum 0xa9c3eacd, Offset: 0x1050
// Size: 0x13c
function function_33202d12(a_ents) {
    mdl_brazier = a_ents[#"prop 1"];
    s_fx = struct::get(#"hash_495fb43788e05676");
    mdl_fx = util::spawn_model("tag_origin", s_fx.origin, s_fx.angles);
    s_fx struct::delete();
    mdl_fx linkto(mdl_brazier, "tag_fx_jnt");
    mdl_fx clientfield::set("" + #"hash_42cc4bf5e47478c5", 1);
    level.var_85cec387 = mdl_fx;
    level scene::remove_scene_func("p8_fxanim_zm_towers_ww_quest_bowl_bundle", &function_33202d12, "init");
}

// Namespace zm_towers_ww_quest/zm_towers_ww_quest
// Params 1, eflags: 0x0
// Checksum 0xe1776d99, Offset: 0x1198
// Size: 0x34
function destroy_wall_setup(b_skipped) {
    if (b_skipped) {
        return;
    }
    level flag::wait_till("zm_towers_pap_quest_completed");
}

// Namespace zm_towers_ww_quest/zm_towers_ww_quest
// Params 2, eflags: 0x0
// Checksum 0x927b23fd, Offset: 0x11d8
// Size: 0x34
function destroy_wall_cleanup(b_skipped, var_c86ff890) {
    level thread scene::play("p8_fxanim_zm_towers_ww_quest_wall_bundle");
}

// Namespace zm_towers_ww_quest/zm_towers_ww_quest
// Params 1, eflags: 0x0
// Checksum 0xdfb6e353, Offset: 0x1218
// Size: 0x94
function knock_brazier_setup(b_skipped) {
    if (b_skipped) {
        return;
    }
    t_trigger = trigger::wait_till("t_ww_quest_knock_brazier");
    e_player = t_trigger.who;
    e_player zm_vo::vo_stop();
    e_player thread zm_vo::function_59635cc4("fire_trail_active", 4, 0, 9999, 1);
}

// Namespace zm_towers_ww_quest/zm_towers_ww_quest
// Params 2, eflags: 0x0
// Checksum 0x63d18f51, Offset: 0x12b8
// Size: 0x1e4
function knock_brazier_cleanup(b_skipped, var_c86ff890) {
    wait 0.05;
    level.var_85cec387 clientfield::set("" + #"hash_42cc4bf5e47478c5", 0);
    level.var_85cec387 clientfield::set("" + #"hash_3b746cf6eec416b2", 1);
    level scene::play("p8_fxanim_zm_towers_ww_quest_bowl_bundle");
    level clientfield::set("" + #"hash_584e8f7433246444", 1);
    wait 1;
    switch (level.var_736da35d) {
    case #"danu":
        str_clientfield = "" + #"hash_418c1c843450232b";
        break;
    case #"ra":
        str_clientfield = "" + #"hash_4d547bf36c6cb2d8";
        break;
    case #"odin":
        str_clientfield = "" + #"hash_38ba3ad0902aa355";
        break;
    case #"zeus":
        str_clientfield = "" + #"hash_24d7233bb17e6558";
        break;
    }
    level clientfield::set(str_clientfield, 1);
}

// Namespace zm_towers_ww_quest/zm_towers_ww_quest
// Params 1, eflags: 0x0
// Checksum 0x46baa0b0, Offset: 0x14a8
// Size: 0xac
function function_5676e416(b_skipped) {
    if (b_skipped) {
        return;
    }
    s_loc = struct::get("s_ww_quest_rough_statue_unitrigger_" + level.var_736da35d);
    e_player = s_loc zm_unitrigger::function_b7e350e6(&function_736ad93c);
    e_player zm_vo::vo_stop();
    e_player thread zm_vo::function_59635cc4("rough_statue_pickup", 0, 0, 9999, 1);
}

// Namespace zm_towers_ww_quest/zm_towers_ww_quest
// Params 1, eflags: 0x0
// Checksum 0xa7a8141f, Offset: 0x1560
// Size: 0x4a
function function_736ad93c(e_player) {
    var_b56ce5b9 = e_player zm_utility::is_player_looking_at(level.var_f31e81cd.origin, 0.9, 0);
    return var_b56ce5b9;
}

// Namespace zm_towers_ww_quest/zm_towers_ww_quest
// Params 2, eflags: 0x0
// Checksum 0x57eb0962, Offset: 0x15b8
// Size: 0x74
function function_ea51d6c5(b_skipped, var_c86ff890) {
    level flag::set(#"hash_5cdf5c960293141a");
    level.var_f31e81cd delete();
    level zm_ui_inventory::function_31a39683(#"hash_46e7cf2b7aa7c22", 1);
}

// Namespace zm_towers_ww_quest/zm_towers_ww_quest
// Params 0, eflags: 0x0
// Checksum 0x8b2c0b0e, Offset: 0x1638
// Size: 0xde
function function_205499dc() {
    a_s_parts = struct::get_array(self.target);
    foreach (s_part in a_s_parts) {
        switch (s_part.script_noteworthy) {
        case #"rough_statue":
            self.var_6f882a43 = s_part;
            break;
        case #"serket_spile":
            self.var_c43e8d1 = s_part;
            break;
        }
    }
}

// Namespace zm_towers_ww_quest/zm_towers_ww_quest
// Params 0, eflags: 0x0
// Checksum 0x46841b29, Offset: 0x1720
// Size: 0x44
function function_e823b7cd() {
    str_tower = self.script_noteworthy;
    level.var_2f6ae9f2 = str_tower;
    level flag::set(#"hash_57454e59c155098d");
}

// Namespace zm_towers_ww_quest/zm_towers_ww_quest
// Params 1, eflags: 0x0
// Checksum 0x876b4f44, Offset: 0x1770
// Size: 0x34
function function_69645ea5(b_skipped) {
    if (b_skipped) {
        return;
    }
    level flag::wait_till(#"hash_57454e59c155098d");
}

// Namespace zm_towers_ww_quest/zm_towers_ww_quest
// Params 2, eflags: 0x0
// Checksum 0xb632c167, Offset: 0x17b0
// Size: 0x39c
function function_c1515116(b_skipped, var_c86ff890) {
    if ((b_skipped || var_c86ff890) && !isdefined(level.var_2f6ae9f2)) {
        level.var_2f6ae9f2 = "ra";
        var_64ae39f = getentarray("zm_towers_hellpool_ra", "script_noteworthy");
        foreach (part in var_64ae39f) {
            if (part trigger::is_trigger_of_type("trigger_use_new")) {
                part triggerenable(1);
                continue;
            }
            part show();
        }
        zm_crafting::function_4b55c808(#"zblueprint_trap_hellpools");
        /#
            iprintlnbold("<dev string:x30>");
        #/
    }
    s_unitrigger = struct::get(level.var_2f6ae9f2, "script_ww_quest_acid_trap_unitrigger");
    level.var_4cc2b4bc = s_unitrigger;
    level.var_bc093e0d = s_unitrigger.var_6f882a43;
    level.var_7b72b543 = s_unitrigger.var_c43e8d1;
    var_62e1a8e4 = array("danu", "ra", "odin", "zeus");
    arrayremovevalue(var_62e1a8e4, level.var_2f6ae9f2);
    foreach (var_650fd884 in var_62e1a8e4) {
        s_acid_trap = struct::get(var_650fd884, "script_ww_quest_acid_trap_unitrigger");
        a_s_parts = struct::get_array(s_acid_trap.target);
        foreach (s_part in a_s_parts) {
            s_part struct::delete();
        }
        s_acid_trap struct::delete();
    }
    level flag::set(#"hash_57454e59c155098d");
    level thread function_40e7ec38();
}

// Namespace zm_towers_ww_quest/zm_towers_ww_quest
// Params 1, eflags: 0x0
// Checksum 0xd8252d83, Offset: 0x1b58
// Size: 0x7c
function function_562d2709(b_skipped) {
    if (b_skipped) {
        return;
    }
    level.var_4cc2b4bc zm_unitrigger::create(&function_122f5fa8, 128);
    level thread function_d103de15();
    level flag::wait_till(#"hash_6af037519dceda7a");
}

// Namespace zm_towers_ww_quest/zm_towers_ww_quest
// Params 2, eflags: 0x0
// Checksum 0x3b980298, Offset: 0x1be0
// Size: 0x10c
function function_d76e1e22(b_skipped, var_c86ff890) {
    level flag::set(#"hash_6af037519dceda7a");
    v_origin = level.var_bc093e0d.origin;
    v_angles = level.var_bc093e0d.angles;
    level.var_bc093e0d struct::delete();
    level.var_f6d96577 = util::spawn_model(#"p8_zm_gla_spile_serket_head_01", v_origin, v_angles);
    level zm_ui_inventory::function_31a39683(#"hash_46e7cf2b7aa7c22", 0);
    if (!b_skipped) {
        zm_unitrigger::unregister_unitrigger(level.var_4cc2b4bc.s_unitrigger);
    }
}

// Namespace zm_towers_ww_quest/zm_towers_ww_quest
// Params 1, eflags: 0x0
// Checksum 0x3a68548b, Offset: 0x1cf8
// Size: 0x4a
function function_122f5fa8(e_player) {
    var_b56ce5b9 = e_player zm_utility::is_player_looking_at(level.var_bc093e0d.origin, 0.9, 0);
    return var_b56ce5b9;
}

// Namespace zm_towers_ww_quest/zm_towers_ww_quest
// Params 0, eflags: 0x0
// Checksum 0x1f04529f, Offset: 0x1d50
// Size: 0x148
function function_40e7ec38() {
    level endon(#"hash_30e0e4bbbfc9b7d8");
    while (true) {
        s_notify = level waittill(#"trap_activated");
        e_trap = s_notify.trap;
        if (isdefined(e_trap)) {
            str_type = e_trap.script_noteworthy;
            if (str_type === "hellpool") {
                level flag::set(#"hash_40f20925227353f4");
                b_active = 1;
                str_id = e_trap.script_string;
                while (b_active) {
                    s_notify = level waittill(#"traps_cooldown");
                    if (s_notify.var_f6bb8854 === str_id) {
                        b_active = 0;
                        break;
                    }
                }
                level flag::clear(#"hash_40f20925227353f4");
            }
        }
    }
}

// Namespace zm_towers_ww_quest/zm_towers_ww_quest
// Params 1, eflags: 0x0
// Checksum 0xfe228408, Offset: 0x1ea0
// Size: 0x5c
function function_d103de15(notifyhash) {
    level endon(#"hash_6af037519dceda7a");
    level flag::wait_till_clear(#"hash_40f20925227353f4");
    level thread function_9279b0e8();
}

// Namespace zm_towers_ww_quest/zm_towers_ww_quest
// Params 0, eflags: 0x0
// Checksum 0x91b57a2a, Offset: 0x1f08
// Size: 0x6c
function function_9279b0e8() {
    level endoncallback(&function_d103de15, #"hash_40f20925227353f4");
    level.var_4cc2b4bc waittill(#"trigger_activated");
    level flag::set(#"hash_6af037519dceda7a");
}

// Namespace zm_towers_ww_quest/zm_towers_ww_quest
// Params 1, eflags: 0x0
// Checksum 0x372426ef, Offset: 0x1f80
// Size: 0x3a
function function_fd7602c2(b_skipped) {
    if (!b_skipped) {
        level flag::wait_till(#"hash_40f20925227353f4");
        wait 5;
    }
}

// Namespace zm_towers_ww_quest/zm_towers_ww_quest
// Params 2, eflags: 0x0
// Checksum 0x12eacb41, Offset: 0x1fc8
// Size: 0xbc
function function_8c2a7e89(b_skipped, var_c86ff890) {
    v_origin = level.var_7b72b543.origin;
    v_angles = level.var_7b72b543.angles;
    level.var_7b72b543 struct::delete();
    level.var_59acca15 = util::spawn_model(#"p8_zm_gla_spile_serket_01", v_origin, v_angles);
    level.var_f6d96577 delete();
}

// Namespace zm_towers_ww_quest/zm_towers_ww_quest
// Params 1, eflags: 0x0
// Checksum 0x1d269418, Offset: 0x2090
// Size: 0x9c
function function_5ab6a84(b_skipped) {
    if (b_skipped) {
        return;
    }
    level flag::wait_till_clear(#"hash_40f20925227353f4");
    level.var_4cc2b4bc zm_unitrigger::create(&function_5a70fdaf, 128);
    level thread function_9139d30d();
    level flag::wait_till(#"hash_30e0e4bbbfc9b7d8");
}

// Namespace zm_towers_ww_quest/zm_towers_ww_quest
// Params 2, eflags: 0x0
// Checksum 0x9c20fe28, Offset: 0x2138
// Size: 0xb4
function function_d6166527(b_skipped, var_c86ff890) {
    level flag::set(#"hash_30e0e4bbbfc9b7d8");
    level.var_4cc2b4bc struct::delete();
    level.var_59acca15 delete();
    level zm_ui_inventory::function_31a39683(#"hash_46e7cf2b7aa7c22", 2);
    if (!b_skipped) {
        zm_unitrigger::unregister_unitrigger(level.var_4cc2b4bc.s_unitrigger);
    }
}

// Namespace zm_towers_ww_quest/zm_towers_ww_quest
// Params 1, eflags: 0x0
// Checksum 0x467d6aff, Offset: 0x21f8
// Size: 0x5a
function function_5a70fdaf(e_player) {
    var_2ad73e90 = level.var_59acca15;
    var_b56ce5b9 = e_player zm_utility::is_player_looking_at(var_2ad73e90.origin, 0.9, 0);
    return var_b56ce5b9;
}

// Namespace zm_towers_ww_quest/zm_towers_ww_quest
// Params 1, eflags: 0x0
// Checksum 0xf76da02c, Offset: 0x2260
// Size: 0x5c
function function_9139d30d(notifyhash) {
    level endon(#"hash_30e0e4bbbfc9b7d8");
    level flag::wait_till_clear(#"hash_40f20925227353f4");
    level thread function_b1af6304();
}

// Namespace zm_towers_ww_quest/zm_towers_ww_quest
// Params 0, eflags: 0x0
// Checksum 0x97f849ee, Offset: 0x22c8
// Size: 0xc4
function function_b1af6304() {
    level endoncallback(&function_9139d30d, #"hash_40f20925227353f4");
    s_waitresult = level.var_4cc2b4bc waittill(#"trigger_activated");
    level flag::set(#"hash_30e0e4bbbfc9b7d8");
    e_player = s_waitresult.e_who;
    e_player zm_vo::vo_stop();
    e_player thread zm_vo::function_59635cc4("serket_spile_pickup", 0, 0, 9999, 1);
}

// Namespace zm_towers_ww_quest/zm_towers_ww_quest
// Params 1, eflags: 0x0
// Checksum 0xaad3d1ff, Offset: 0x2398
// Size: 0x2f6
function function_954019d1(b_skipped) {
    if (b_skipped) {
        return;
    }
    var_191e0a24 = 1;
    /#
        if (getdvarint(#"zm_debug_ee", 0)) {
            var_191e0a24 = 0;
        }
    #/
    var_a13c1c92 = 0;
    while (!var_a13c1c92) {
        var_b7857101 = 0;
        while (!var_b7857101) {
            var_a70a00e7 = [];
            if (var_191e0a24) {
                level waittill(#"start_of_round");
            }
            foreach (e_player in util::get_active_players()) {
                var_7229b2ab = e_player.var_7229b2ab;
                if (isdefined(var_7229b2ab)) {
                    var_1cfaf808 = var_7229b2ab.var_1cfaf808;
                    if (e_player zm_towers_crowd::function_c5e4b9a6()) {
                        if (!isdefined(var_a70a00e7)) {
                            var_a70a00e7 = [];
                        } else if (!isarray(var_a70a00e7)) {
                            var_a70a00e7 = array(var_a70a00e7);
                        }
                        var_a70a00e7[var_a70a00e7.size] = e_player;
                    }
                }
            }
            if (var_a70a00e7.size > 0) {
                var_b7857101 = 1;
                break;
            }
            waitframe(1);
        }
        level flag::clear(#"hash_d9ce740cc4b8285");
        level thread function_229db0ed();
        foreach (e_player in var_a70a00e7) {
            if (isdefined(e_player)) {
                e_player thread function_6c8f85ad();
            }
        }
        level flag::wait_till_any(array(#"hash_d9ce740cc4b8285", #"hash_200151b21f16734f"));
        if (level flag::get(#"hash_200151b21f16734f")) {
            var_a13c1c92 = 1;
            break;
        }
    }
}

// Namespace zm_towers_ww_quest/zm_towers_ww_quest
// Params 2, eflags: 0x0
// Checksum 0x573f5e85, Offset: 0x2698
// Size: 0x34
function function_42fe3dea(b_skipped, var_c86ff890) {
    level flag::set(#"hash_200151b21f16734f");
}

// Namespace zm_towers_ww_quest/zm_towers_ww_quest
// Params 0, eflags: 0x0
// Checksum 0x73384543, Offset: 0x26d8
// Size: 0x54
function function_229db0ed() {
    level endon(#"hash_d9ce740cc4b8285");
    level waittill(#"end_of_round");
    level flag::set(#"hash_200151b21f16734f");
}

// Namespace zm_towers_ww_quest/zm_towers_ww_quest
// Params 0, eflags: 0x0
// Checksum 0xfc8f1b37, Offset: 0x2738
// Size: 0xd4
function function_6c8f85ad() {
    level endon(#"hash_d9ce740cc4b8285", #"hash_200151b21f16734f");
    self endon(#"death");
    var_cd9df473 = 0;
    while (!var_cd9df473) {
        var_7229b2ab = self.var_7229b2ab;
        if (isdefined(var_7229b2ab)) {
            var_1cfaf808 = var_7229b2ab.var_1cfaf808;
            if (!self zm_towers_crowd::function_c5e4b9a6()) {
                var_cd9df473 = 1;
                break;
            }
        }
        waitframe(1);
    }
    level flag::set(#"hash_d9ce740cc4b8285");
}

// Namespace zm_towers_ww_quest/zm_towers_ww_quest
// Params 1, eflags: 0x0
// Checksum 0xcee965af, Offset: 0x2818
// Size: 0x4f4
function function_fd8a4508(b_skipped) {
    if (b_skipped) {
        return;
    }
    var_67acf46b = struct::get_array("s_ww_quest_impervious_jar_start");
    var_9f732b76 = [];
    foreach (e_player in util::get_active_players()) {
        if (isdefined(e_player)) {
            foreach (s_option in var_67acf46b) {
                if (e_player util::is_player_looking_at(s_option.origin, 0.9, 0)) {
                    if (!isdefined(var_9f732b76)) {
                        var_9f732b76 = [];
                    } else if (!isarray(var_9f732b76)) {
                        var_9f732b76 = array(var_9f732b76);
                    }
                    if (!isinarray(var_9f732b76, s_option)) {
                        var_9f732b76[var_9f732b76.size] = s_option;
                    }
                }
            }
        }
    }
    if (var_9f732b76.size == 0) {
        var_6491f8cb = array::random(var_67acf46b);
    } else {
        var_6491f8cb = array::random(var_9f732b76);
    }
    arrayremovevalue(var_67acf46b, var_6491f8cb);
    foreach (s_option in var_67acf46b) {
        s_end = struct::get(s_option.target);
        s_end struct::delete();
        s_option struct::delete();
    }
    level thread zm_audio::sndannouncerplayvox(#"hash_28dbb5b91d8a954e");
    var_a075b828 = struct::get(var_6491f8cb.target);
    mdl_jar = util::spawn_model(#"p8_zm_gla_jar_gold_01", var_6491f8cb.origin, var_6491f8cb.angles);
    mdl_jar notsolid();
    mdl_jar clientfield::set("" + #"hash_2c6f04d08665dbda", 1);
    n_time = mdl_jar zm_utility::fake_physicslaunch(var_a075b828.origin, 1000);
    wait n_time;
    mdl_jar.origin = var_a075b828.origin;
    mdl_jar.angles = var_a075b828.angles;
    mdl_jar clientfield::set("" + #"hash_2a332df32456c86f", 1);
    mdl_jar clientfield::set("" + #"hash_2c6f04d08665dbda", 0);
    s_loc = struct::get(var_a075b828.target);
    s_loc.var_c8a78c4e = mdl_jar;
    e_player = s_loc zm_unitrigger::function_b7e350e6(&function_b6027926);
    mdl_jar delete();
    e_player zm_vo::vo_stop();
    e_player thread zm_vo::function_59635cc4("imp_jar_pickup", 0, 0, 9999, 1);
}

// Namespace zm_towers_ww_quest/zm_towers_ww_quest
// Params 2, eflags: 0x0
// Checksum 0xd683838, Offset: 0x2d18
// Size: 0x5c
function function_ac06b913(b_skipped, var_c86ff890) {
    level flag::set(#"hash_45259bb6368fc0d3");
    level zm_ui_inventory::function_31a39683(#"hash_d3e328bb2670edf", 1);
}

// Namespace zm_towers_ww_quest/zm_towers_ww_quest
// Params 1, eflags: 0x0
// Checksum 0x396560e9, Offset: 0x2d80
// Size: 0x6a
function function_b6027926(e_player) {
    mdl_jar = self.stub.related_parent.var_c8a78c4e;
    var_b56ce5b9 = e_player zm_utility::is_player_looking_at(mdl_jar.origin, 0.9, 0);
    return var_b56ce5b9;
}

// Namespace zm_towers_ww_quest/zm_towers_ww_quest
// Params 1, eflags: 0x0
// Checksum 0x8a847674, Offset: 0x2df8
// Size: 0x8e
function function_1b8b65a5(b_skipped) {
    if (b_skipped) {
        return;
    }
    b_planted = 0;
    while (!b_planted) {
        s_waitresult = trigger::wait_till("t_ww_quest_spile_damage_trigger");
        e_player = s_waitresult.who;
        if (isplayer(e_player)) {
            b_planted = 1;
            break;
        }
    }
}

// Namespace zm_towers_ww_quest/zm_towers_ww_quest
// Params 2, eflags: 0x0
// Checksum 0x358bad4, Offset: 0x2e90
// Size: 0x144
function function_7aa93016(b_skipped, var_c86ff890) {
    level flag::set(#"hash_5649f57b918f85f8");
    s_spile = struct::get("s_ww_quest_spile_in_tree");
    v_origin = s_spile.origin;
    v_angles = s_spile.angles;
    s_spile struct::delete();
    var_2ad73e90 = util::spawn_model(#"p8_zm_gla_spile_serket_01", v_origin, v_angles);
    var_2ad73e90 thread function_68ad7c31();
    t_trigger = getent("t_ww_quest_spile_damage_trigger", "targetname");
    t_trigger delete();
    level zm_ui_inventory::function_31a39683(#"hash_46e7cf2b7aa7c22", 0);
}

// Namespace zm_towers_ww_quest/zm_towers_ww_quest
// Params 0, eflags: 0x0
// Checksum 0x93df3b1b, Offset: 0x2fe0
// Size: 0x5c
function function_68ad7c31() {
    level endon(#"end_game");
    self endon(#"death");
    wait 3;
    self clientfield::increment("" + #"hash_48ad84f9cf6a33f0");
}

// Namespace zm_towers_ww_quest/zm_towers_ww_quest
// Params 1, eflags: 0x0
// Checksum 0x31b83cc6, Offset: 0x3048
// Size: 0x54
function function_f9a16f5a(b_skipped) {
    if (b_skipped) {
        return;
    }
    s_loc = struct::get("s_ww_quest_place_impervious_jar");
    s_loc zm_unitrigger::function_b7e350e6(&function_a9c6caa0);
}

// Namespace zm_towers_ww_quest/zm_towers_ww_quest
// Params 2, eflags: 0x0
// Checksum 0xbb803131, Offset: 0x30a8
// Size: 0x13c
function function_6275da01(b_skipped, var_c86ff890) {
    level flag::set(#"hash_30ca6a723fbb84e9");
    s_jar = struct::get("s_ww_quest_jar_under_tree");
    v_origin = s_jar.origin;
    v_angles = s_jar.angles;
    mdl_jar = util::spawn_model(#"p8_zm_gla_jar_gold_01", v_origin, v_angles);
    mdl_jar_filled = util::spawn_model(#"p8_zm_gla_jar_gold_01_full", v_origin - (0, 0, 2048), v_angles);
    level.var_c8a78c4e = mdl_jar;
    level.var_448b5a5 = mdl_jar_filled;
    level zm_ui_inventory::function_31a39683(#"hash_d3e328bb2670edf", 0);
}

// Namespace zm_towers_ww_quest/zm_towers_ww_quest
// Params 1, eflags: 0x0
// Checksum 0xed290983, Offset: 0x31f0
// Size: 0x6a
function function_a9c6caa0(e_player) {
    s_jar = struct::get("s_ww_quest_jar_under_tree");
    var_b56ce5b9 = e_player zm_utility::is_player_looking_at(s_jar.origin, 0.9, 0);
    return var_b56ce5b9;
}

// Namespace zm_towers_ww_quest/zm_towers_ww_quest
// Params 1, eflags: 0x0
// Checksum 0xf9dd8d6e, Offset: 0x3268
// Size: 0x3c
function function_e0c2f8d2(b_skipped) {
    if (b_skipped) {
        return;
    }
    level waittill(#"end_of_round", #"between_round_over");
}

// Namespace zm_towers_ww_quest/zm_towers_ww_quest
// Params 2, eflags: 0x0
// Checksum 0xf53bab69, Offset: 0x32b0
// Size: 0x64
function function_d6745b99(b_skipped, var_c86ff890) {
    level.var_448b5a5.origin += (0, 0, 2048);
    waitframe(1);
    level.var_c8a78c4e delete();
}

// Namespace zm_towers_ww_quest/zm_towers_ww_quest
// Params 1, eflags: 0x0
// Checksum 0xfe64a89, Offset: 0x3320
// Size: 0x154
function function_747d88e6(b_skipped) {
    level.disable_firesale_drop = 1;
    a_mdl_powerups = zm_powerups::get_powerups();
    foreach (mdl_powerup in a_mdl_powerups) {
        if (mdl_powerup.powerup_name === "fire_sale") {
            mdl_powerup thread zm_powerups::powerup_delete();
        }
    }
    if (b_skipped) {
        return;
    }
    s_loc = struct::get("s_ww_quest_place_impervious_jar");
    e_player = s_loc zm_unitrigger::function_b7e350e6(&function_a9c6caa0);
    e_player zm_vo::vo_stop();
    e_player thread zm_vo::function_59635cc4("imp_jar_fill_pickup", 0, 0, 9999, 1);
}

// Namespace zm_towers_ww_quest/zm_towers_ww_quest
// Params 2, eflags: 0x0
// Checksum 0x56e221b1, Offset: 0x3480
// Size: 0x74
function function_591d5b15(b_skipped, var_c86ff890) {
    level flag::set(#"hash_1c66e5c351c08de1");
    level.var_448b5a5 delete();
    level zm_ui_inventory::function_31a39683(#"hash_d3e328bb2670edf", 2);
}

// Namespace zm_towers_ww_quest/zm_towers_ww_quest
// Params 1, eflags: 0x0
// Checksum 0x2a6e8d2d, Offset: 0x3500
// Size: 0x398
function function_c7ad4b1d(b_skipped) {
    a_str_chests = array("tower_a_chest", "tower_b_chest", "tower_c_chest", "tower_d_chest", "tower_a_lower_chest", "tower_b_lower_chest", "tower_c_lower_chest", "tower_d_lower_chest", "danu_zeus_tunnel_chest", "ra_odin_tunnel_chest");
    level.var_b84cb625 = [];
    level.var_4b5b047f = [];
    foreach (str_chest in a_str_chests) {
        e_chest = getent(str_chest, "targetname");
        s_chest = struct::get(str_chest, "script_noteworthy");
        if (!isdefined(level.var_b84cb625)) {
            level.var_b84cb625 = [];
        } else if (!isarray(level.var_b84cb625)) {
            level.var_b84cb625 = array(level.var_b84cb625);
        }
        level.var_b84cb625[level.var_b84cb625.size] = e_chest;
        if (!isdefined(level.var_4b5b047f)) {
            level.var_4b5b047f = [];
        } else if (!isarray(level.var_4b5b047f)) {
            level.var_4b5b047f = array(level.var_4b5b047f);
        }
        level.var_4b5b047f[level.var_4b5b047f.size] = s_chest;
    }
    level thread function_52018115();
    if (b_skipped) {
        return;
    }
    foreach (e_chest in level.var_b84cb625) {
        e_chest function_657cfc18();
        e_chest thread function_3283043c();
        e_chest thread function_edbe1101();
    }
    level flag::wait_till(#"hash_77ff9a8101ea687b");
    foreach (e_chest in level.var_b84cb625) {
        e_chest function_22bc0490();
    }
}

// Namespace zm_towers_ww_quest/zm_towers_ww_quest
// Params 2, eflags: 0x0
// Checksum 0xa098bf5e, Offset: 0x38a0
// Size: 0x114
function function_7be8c2e(b_skipped, var_c86ff890) {
    level flag::set(#"hash_77ff9a8101ea687b");
    zm_weapons::function_55d25350(getweapon(#"ww_crossbow_t8"));
    callback::on_spawned(&function_5526ddc4);
    array::thread_all(level.players, &function_5526ddc4);
    level.customrandomweaponweights = &function_ec699f57;
    level zm_ui_inventory::function_31a39683(#"hash_d3e328bb2670edf", 0);
    /#
        if (b_skipped) {
            iprintlnbold("<dev string:x51>");
        }
    #/
}

// Namespace zm_towers_ww_quest/zm_towers_ww_quest
// Params 0, eflags: 0x0
// Checksum 0x1a6fd6fa, Offset: 0x39c0
// Size: 0x26
function function_5526ddc4() {
    if (isdefined(self.var_f15dc7c3)) {
        self.var_7430b0b9 = self.var_f15dc7c3;
        self.var_f15dc7c3 = undefined;
    }
}

// Namespace zm_towers_ww_quest/zm_towers_ww_quest
// Params 0, eflags: 0x0
// Checksum 0xd94d97b9, Offset: 0x39f0
// Size: 0x26
function function_a4ce920b() {
    if (isdefined(self.var_7430b0b9)) {
        self.var_f15dc7c3 = self.var_7430b0b9;
        self.var_7430b0b9 = undefined;
    }
}

// Namespace zm_towers_ww_quest/zm_towers_ww_quest
// Params 0, eflags: 0x0
// Checksum 0x2c2ab6da, Offset: 0x3a20
// Size: 0x12e
function function_3283043c() {
    level endon(#"hash_77ff9a8101ea687b", #"fire_sale_on");
    while (true) {
        str_state = self zm_magicbox::get_magic_box_zbarrier_state();
        n_index = array::find(level.chests, self.owner);
        switch (str_state) {
        case #"close":
        case #"arriving":
        case #"initial":
            if (level.chest_index === n_index) {
                self thread function_f7a4a993();
            }
            break;
        default:
            self thread function_22bc0490();
            break;
        }
        self waittill(#"zbarrier_state_change");
    }
}

// Namespace zm_towers_ww_quest/zm_towers_ww_quest
// Params 0, eflags: 0x0
// Checksum 0x6c9f2f72, Offset: 0x3b58
// Size: 0x88
function function_edbe1101() {
    level endon(#"hash_77ff9a8101ea687b");
    while (true) {
        level waittill(#"fire_sale_on");
        self function_22bc0490();
        level waittill(#"fire_sale_off");
        self thread function_3283043c();
    }
}

// Namespace zm_towers_ww_quest/zm_towers_ww_quest
// Params 0, eflags: 0x0
// Checksum 0xcf75f659, Offset: 0x3be8
// Size: 0x1aa
function function_657cfc18() {
    str_targetname = self.targetname;
    switch (str_targetname) {
    case #"tower_a_chest":
        str_loc = "odin_top_floor";
        break;
    case #"tower_b_chest":
        str_loc = "zeus_top_floor";
        break;
    case #"tower_c_chest":
        str_loc = "danu_top_floor";
        break;
    case #"tower_d_chest":
        str_loc = "ra_top_floor";
        break;
    case #"tower_a_lower_chest":
        str_loc = "odin_basement";
        break;
    case #"tower_b_lower_chest":
        str_loc = "zeus_basement";
        break;
    case #"tower_c_lower_chest":
        str_loc = "danu_basement";
        break;
    case #"tower_d_lower_chest":
        str_loc = "ra_basement";
        break;
    case #"ra_odin_tunnel_chest":
        str_loc = "ra_odin_tunnel";
        break;
    case #"danu_zeus_tunnel_chest":
        str_loc = "danu_zeus_tunnel";
        break;
    }
    s_loc = struct::get("s_ww_quest_magic_box_unitrigger_" + str_loc);
    self.var_c620f20 = s_loc;
}

// Namespace zm_towers_ww_quest/zm_towers_ww_quest
// Params 0, eflags: 0x0
// Checksum 0xe842f1e5, Offset: 0x3da0
// Size: 0x12c
function function_f7a4a993() {
    self notify("2b83be1a30494279");
    self endon("2b83be1a30494279");
    level endon(#"hash_77ff9a8101ea687b");
    self endon(#"hash_34af1b1562febca4");
    s_loc = self.var_c620f20;
    if (!isdefined(self.var_96a1fee7)) {
        self.var_96a1fee7 = s_loc zm_unitrigger::create(&function_2630a85c);
    }
    s_waitresult = s_loc waittill(#"trigger_activated");
    e_player = s_waitresult.e_who;
    e_player zm_vo::vo_stop();
    e_player thread zm_vo::function_59635cc4("box_feed_elixir", 0, 0, 9999, 1);
    level flag::set(#"hash_77ff9a8101ea687b");
}

// Namespace zm_towers_ww_quest/zm_towers_ww_quest
// Params 1, eflags: 0x0
// Checksum 0x3edb33dd, Offset: 0x3ed8
// Size: 0x8a
function function_2630a85c(e_player) {
    if (zombie_utility::get_zombie_var(#"zombie_powerup_fire_sale_on") === 1) {
        self sethintstringforplayer(e_player, "");
        return 0;
    }
    self sethintstringforplayer(e_player, #"hash_a57efeec61b5a4e");
    return 1;
}

// Namespace zm_towers_ww_quest/zm_towers_ww_quest
// Params 0, eflags: 0x0
// Checksum 0x13ab9fa5, Offset: 0x3f70
// Size: 0x5e
function function_22bc0490() {
    self notify(#"hash_34af1b1562febca4");
    s_loc = self.var_c620f20;
    if (isdefined(self.var_96a1fee7)) {
        zm_unitrigger::unregister_unitrigger(s_loc.s_unitrigger);
        self.var_96a1fee7 = undefined;
    }
}

// Namespace zm_towers_ww_quest/zm_towers_ww_quest
// Params 0, eflags: 0x0
// Checksum 0xfa2f50e, Offset: 0x3fd8
// Size: 0x234
function function_52018115() {
    level endon(#"end_game");
    level flag::wait_till(#"hash_77ff9a8101ea687b");
    var_75ded614 = level.chests[level.chest_index].zbarrier;
    playsoundatposition(#"hash_5fed0c8cb27e5156", var_75ded614.origin);
    var_75ded614 clientfield::set("" + #"hash_3974bea828fbf7f7", 1);
    while (var_75ded614 getzbarrierpiecestate(2) !== "opening") {
        waitframe(1);
    }
    var_75ded614 clientfield::set("" + #"hash_3974bea828fbf7f7", 0);
    var_75ded614 clientfield::set("" + #"hash_5dc6f97e5850e1d1", 1);
    var_75ded614 clientfield::set("" + #"hash_1add6939914df65a", 1);
    level flag::wait_till_any(array(#"hash_3ac6f9944962bd4c", #"hash_786b9153c754d127"));
    var_75ded614 clientfield::set("" + #"hash_5dc6f97e5850e1d1", 0);
    var_75ded614 clientfield::set("" + #"hash_1add6939914df65a", 0);
}

// Namespace zm_towers_ww_quest/zm_towers_ww_quest
// Params 1, eflags: 0x0
// Checksum 0x89bf30e5, Offset: 0x4218
// Size: 0x50
function function_ec699f57(a_keys) {
    level.customrandomweaponweights = undefined;
    arrayinsert(a_keys, getweapon(#"ww_crossbow_t8"), 0);
    return a_keys;
}

// Namespace zm_towers_ww_quest/zm_towers_ww_quest
// Params 1, eflags: 0x0
// Checksum 0x4e9a6ff0, Offset: 0x4270
// Size: 0x290
function function_afebda6b(b_skipped) {
    foreach (s_chest in level.var_4b5b047f) {
        if (!isdefined(s_chest.no_fly_away)) {
            s_chest.no_fly_away = 1;
            s_chest.var_d76d15f8 = 1;
        }
    }
    array::thread_all(level.var_b84cb625, &function_e7bce86c);
    level.chests[0].zbarrier clientfield::set("force_stream_magicbox", 1);
    level flag::wait_till_any(array(#"hash_3ac6f9944962bd4c", #"hash_786b9153c754d127"));
    callback::remove_on_spawned(&function_5526ddc4);
    array::thread_all(level.players, &function_a4ce920b);
    foreach (s_chest in level.var_4b5b047f) {
        if (isdefined(s_chest.var_d76d15f8)) {
            s_chest.no_fly_away = undefined;
            s_chest.var_d76d15f8 = undefined;
        }
    }
    foreach (e_player in level.players) {
        e_player clientfield::increment_to_player("" + #"ww_quest_earthquake");
    }
}

// Namespace zm_towers_ww_quest/zm_towers_ww_quest
// Params 2, eflags: 0x0
// Checksum 0xcc484162, Offset: 0x4508
// Size: 0x14
function function_ffe88820(b_skipped, var_c86ff890) {
    
}

// Namespace zm_towers_ww_quest/zm_towers_ww_quest
// Params 0, eflags: 0x0
// Checksum 0x6a096f3a, Offset: 0x4528
// Size: 0x9c
function function_e7bce86c() {
    level endon(#"hash_631e8676a2fa932b");
    self waittill(#"opened");
    level.var_e2f39a08 = self.owner;
    level.var_e2f39a08 thread function_bdb89127();
    self thread function_1e099e48();
    level flag::set(#"hash_631e8676a2fa932b");
}

// Namespace zm_towers_ww_quest/zm_towers_ww_quest
// Params 0, eflags: 0x0
// Checksum 0xdb90c9fc, Offset: 0x45d0
// Size: 0x64
function function_bdb89127() {
    level endon(#"hash_3ac6f9944962bd4c", #"hash_786b9153c754d127");
    self waittill(#"user_grabbed_weapon");
    level flag::set(#"hash_3ac6f9944962bd4c");
}

// Namespace zm_towers_ww_quest/zm_towers_ww_quest
// Params 0, eflags: 0x0
// Checksum 0x48770383, Offset: 0x4640
// Size: 0x7c
function function_1e099e48() {
    level endon(#"hash_786b9153c754d127", #"hash_3ac6f9944962bd4c");
    while (self getzbarrierpiecestate(2) !== "closing") {
        waitframe(1);
    }
    level flag::set(#"hash_786b9153c754d127");
}

