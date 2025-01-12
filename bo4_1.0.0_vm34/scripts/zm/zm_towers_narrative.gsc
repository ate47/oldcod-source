#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\struct;
#using scripts\core_common\trigger_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\zm_unitrigger;
#using scripts\zm_common\zm_utility;

#namespace zm_towers_narrative;

// Namespace zm_towers_narrative/zm_towers_narrative
// Params 0, eflags: 0x0
// Checksum 0xb623c420, Offset: 0x438
// Size: 0x444
function init() {
    level flag::init(#"hash_64e187377acec152");
    level flag::init(#"hash_61f2d2e8517e7f57");
    level flag::init(#"hash_407e0345ce2708de");
    level flag::init(#"hash_3bdb012f2eaac96");
    level flag::init(#"hash_506f1fac74cfdd86");
    level flag::init(#"hash_4ea18d3d5847ab0c");
    level flag::init(#"hash_aab8ed14df98649");
    level flag::init(#"hash_3af375942a1c2785");
    level flag::init(#"hash_7b6594521dfb7bb1");
    level flag::init(#"hash_3e90f82a2802b3");
    level flag::init(#"hash_26c9e53e0e558572");
    if (!getdvarint(#"zm_ee_enabled", 0)) {
        hidemiscmodels("mdl_narrative_ix");
        hidemiscmodels("mdl_narrative_ink");
    }
    a_s_scrolls = struct::get_array(#"hash_4ff4d74fc1ff150d");
    array::thread_all(a_s_scrolls, &function_697e3d14, 1);
    a_s_skulls = struct::get_array(#"hash_70b8946b02777c1d");
    array::thread_all(a_s_skulls, &function_697e3d14);
    level thread function_e23fc11c("narrative_whispers", array("vox_orac_ee_prima_intro_0", "vox_orac_ee_prima_theorem_0", "vox_orac_ee_library_0", "vox_orac_ee_alexandria_0"));
    level thread function_e23fc11c("narrative_warning", array("vox_sku1_ee_skull_1_interact_0", "vox_sku2_ee_skull_2_interact_0", "vox_sku3_ee_skull_3_interact_0", "vox_sku4_ee_skull_4_interact_0", "vox_sku5_ee_skull_5_interact_0"), 1);
    level thread function_5aadc57a();
    level thread function_8dd14812();
    level thread function_4a8ba57();
    level thread function_b1631f8d();
    level thread function_39ef3ff9();
    level thread function_1c93bc4d();
    level thread acid_trap_think();
    level thread function_9f27200();
    level thread function_c1e20981();
    if (getdvarint(#"zm_ee_enabled", 0)) {
        var_62dfb6c0 = getent("mdl_narrative_lead", "targetname");
        var_62dfb6c0 clientfield::set("" + #"hash_2407f687f7d24a83", 1);
    }
}

// Namespace zm_towers_narrative/zm_towers_narrative
// Params 1, eflags: 0x0
// Checksum 0x9e1a030b, Offset: 0x888
// Size: 0x134
function function_697e3d14(var_cd485d6d = 0) {
    level endon(#"end_game");
    if (!getdvarint(#"zm_ee_enabled", 0)) {
        if (var_cd485d6d) {
            hidemiscmodels(self.target);
        }
        self struct::delete();
        return;
    }
    e_player = self zm_unitrigger::function_b7e350e6(&function_b8970c36);
    if (var_cd485d6d) {
        hidemiscmodels(self.target);
    }
    if (isdefined(self.var_6cba086a)) {
    }
    if (isdefined(self.script_notify)) {
        level notify(self.script_notify, {#e_player:e_player, #v_origin:self.origin});
    }
    self struct::delete();
}

// Namespace zm_towers_narrative/zm_towers_narrative
// Params 1, eflags: 0x0
// Checksum 0x524c304d, Offset: 0x9c8
// Size: 0x86
function function_b8970c36(e_player) {
    var_b56ce5b9 = e_player zm_utility::is_player_looking_at(self.stub.related_parent.origin, 0.99, 0);
    var_627f6cbf = level flag::get(#"hash_64e187377acec152");
    return !var_627f6cbf && var_b56ce5b9;
}

// Namespace zm_towers_narrative/zm_towers_narrative
// Params 3, eflags: 0x0
// Checksum 0xc56ad469, Offset: 0xa58
// Size: 0x230
function function_e23fc11c(str_notify, a_str_vo, var_b2cb41f3 = 0) {
    level endon(#"end_game");
    if (!getdvarint(#"zm_ee_enabled", 0)) {
        return;
    }
    if (!isdefined(a_str_vo)) {
        a_str_vo = [];
    } else if (!isarray(a_str_vo)) {
        a_str_vo = array(a_str_vo);
    }
    foreach (str_vo in a_str_vo) {
        s_waitresult = level waittill(str_notify);
        level flag::set(#"hash_64e187377acec152");
        if (var_b2cb41f3) {
            v_origin = s_waitresult.v_origin;
            playsoundatposition(str_vo, v_origin);
        } else {
            foreach (e_player in level.players) {
                e_player playsoundtoplayer(str_vo, e_player);
            }
        }
        function_644f5ce5(str_vo);
        level flag::clear(#"hash_64e187377acec152");
    }
}

// Namespace zm_towers_narrative/zm_towers_narrative
// Params 1, eflags: 0x0
// Checksum 0x2fcccf2, Offset: 0xc90
// Size: 0x56
function function_644f5ce5(str_vo) {
    n_duration = soundgetplaybacktime(str_vo);
    n_duration = float(n_duration) / 1000;
    wait n_duration;
}

// Namespace zm_towers_narrative/zm_towers_narrative
// Params 0, eflags: 0x0
// Checksum 0xe502977e, Offset: 0xcf0
// Size: 0x28e
function function_5aadc57a() {
    level endon(#"end_game");
    if (!getdvarint(#"zm_ee_enabled", 0)) {
        return;
    }
    for (i = 0; i < 4; i++) {
        level waittill(#"narrative_explore");
        level flag::set(#"hash_64e187377acec152");
        switch (i) {
        case 0:
            str_scene = "quest";
            break;
        case 1:
            str_scene = "four_gods";
            break;
        case 2:
            str_scene = "sacrifice";
            break;
        case 3:
            str_scene = "appeasement";
            break;
        }
        for (n_line = 0; true; n_line++) {
            str_vo = "vox_bart_ee_" + str_scene + "_" + n_line;
            if (!soundexists(str_vo)) {
                str_vo = "vox_brat_ee_" + str_scene + "_" + n_line;
                if (!soundexists(str_vo)) {
                    break;
                }
            }
            foreach (e_player in level.players) {
                e_player playsoundtoplayer(str_vo, e_player);
            }
            function_644f5ce5(str_vo);
        }
        level flag::clear(#"hash_64e187377acec152");
    }
}

// Namespace zm_towers_narrative/zm_towers_narrative
// Params 0, eflags: 0x0
// Checksum 0xbb75c59a, Offset: 0xf88
// Size: 0x36c
function function_8dd14812() {
    level endon(#"end_game");
    var_a93a8b28 = getent("mdl_narrative_dirt", "targetname");
    a_t_braziers = getentarray("t_narrative_hoop", "targetname");
    if (!getdvarint(#"zm_ee_enabled", 0)) {
        var_a93a8b28 delete();
    } else {
        level.var_3a5c7e61 = 0;
        level.var_b285d488 = a_t_braziers.size;
        foreach (t_brazier in a_t_braziers) {
            t_brazier flag::init(#"hash_6e4b1162d4626a6e");
            t_brazier thread function_d67535ac();
        }
        level flag::wait_till(#"hash_61f2d2e8517e7f57");
        callback::on_connect(&function_754367d2);
        array::thread_all(level.players, &function_754367d2);
        level flag::wait_till(#"hash_407e0345ce2708de");
        callback::remove_on_connect(&function_754367d2);
    }
    foreach (t_brazier in a_t_braziers) {
        mdl_fx = getent(t_brazier.target, "targetname");
        if (getdvarint(#"zm_ee_enabled", 0)) {
            mdl_fx clientfield::set("" + #"hash_5afda864f8b64f5c", 0);
        }
        mdl_fx delete();
        t_brazier delete();
    }
    vol_pedestal = getent("vol_narrative_smash", "targetname");
    vol_pedestal delete();
}

// Namespace zm_towers_narrative/zm_towers_narrative
// Params 0, eflags: 0x0
// Checksum 0x598b706a, Offset: 0x1300
// Size: 0x2e4
function function_d67535ac() {
    self notify("534f8efb26cde85d");
    self endon("534f8efb26cde85d");
    level endon(#"end_game");
    self endon(#"death");
    mdl_fx = getent(self.target, "targetname");
    if (self flag::get(#"hash_6e4b1162d4626a6e")) {
        mdl_fx clientfield::set("" + #"hash_5afda864f8b64f5c", 0);
        self flag::clear(#"hash_6e4b1162d4626a6e");
    }
    while (true) {
        s_waitresult = self waittill(#"damage");
        w_weapon = s_waitresult.weapon;
        v_origin = s_waitresult.position;
        if (istouching(v_origin, self) && w_weapon === getweapon(#"eq_wraith_fire")) {
            break;
        }
    }
    var_c83e8680 = level.var_3a5c7e61 + 1;
    if (var_c83e8680 == self.script_int) {
        level.var_3a5c7e61 = var_c83e8680;
        self flag::set(#"hash_6e4b1162d4626a6e");
        mdl_fx clientfield::set("" + #"hash_5afda864f8b64f5c", 1);
        if (level.var_3a5c7e61 >= level.var_b285d488) {
            level flag::set(#"hash_61f2d2e8517e7f57");
        }
        return;
    }
    level.var_3a5c7e61 = 0;
    a_t_braziers = getentarray("t_narrative_hoop", "targetname");
    arrayremovevalue(a_t_braziers, self);
    array::thread_all(a_t_braziers, &function_d67535ac);
    self thread function_d67535ac();
}

// Namespace zm_towers_narrative/zm_towers_narrative
// Params 0, eflags: 0x0
// Checksum 0x8a0e5ab5, Offset: 0x15f0
// Size: 0x11a
function function_754367d2() {
    self notify("663fff6c241ed463");
    self endon("663fff6c241ed463");
    level endon(#"end_game", #"hash_407e0345ce2708de");
    self endon(#"disconnect");
    vol_pedestal = getent("vol_narrative_smash", "targetname");
    while (true) {
        for (e_storm = self.e_storm; !isdefined(e_storm); e_storm = self.e_storm) {
            waitframe(1);
        }
        if (e_storm istouching(vol_pedestal)) {
            e_storm thread function_47317fdb();
            level flag::set(#"hash_407e0345ce2708de");
            break;
        }
        waitframe(1);
    }
}

// Namespace zm_towers_narrative/zm_towers_narrative
// Params 0, eflags: 0x0
// Checksum 0x35e499df, Offset: 0x1718
// Size: 0xcc
function function_47317fdb() {
    level endon(#"end_game");
    if (!isdefined(self)) {
        return;
    }
    var_a93a8b28 = getent("mdl_narrative_dirt", "targetname");
    var_a93a8b28 clientfield::set("" + #"hash_2407f687f7d24a83", 1);
    self waittill(#"death");
    var_a93a8b28 clientfield::set("" + #"hash_2407f687f7d24a83", 0);
}

// Namespace zm_towers_narrative/zm_towers_narrative
// Params 0, eflags: 0x0
// Checksum 0x2269c9c7, Offset: 0x17f0
// Size: 0x1dc
function function_4a8ba57() {
    level endon(#"end_game");
    var_a93a8b28 = getent("mdl_narrative_flop", "targetname");
    s_loc = struct::get(#"hash_41008b60aedc6f40");
    s_hand = struct::get(#"hash_723303fe45c13f65");
    if (!getdvarint(#"zm_ee_enabled", 0)) {
        var_a93a8b28 delete();
        s_loc struct::delete();
        scene::add_scene_func(s_hand.var_39e7934a, &function_8d868cac, "init");
        s_hand struct::delete();
        return;
    }
    s_loc zm_unitrigger::function_b7e350e6(&function_1bf7cb4f);
    level thread scene::play(s_hand.var_39e7934a);
    s_loc struct::delete();
    s_hand struct::delete();
    var_a93a8b28 clientfield::set("" + #"hash_2407f687f7d24a83", 1);
}

// Namespace zm_towers_narrative/zm_towers_narrative
// Params 1, eflags: 0x0
// Checksum 0x10fd07c2, Offset: 0x19d8
// Size: 0x8c
function function_8d868cac(a_ents) {
    level scene::remove_scene_func(self.scriptbundlename, &function_8d868cac, "init");
    self scene::stop();
    mdl_hand = a_ents[#"prop 1"];
    mdl_hand delete();
}

// Namespace zm_towers_narrative/zm_towers_narrative
// Params 1, eflags: 0x0
// Checksum 0x911da0bf, Offset: 0x1a70
// Size: 0xc8
function function_1bf7cb4f(e_player) {
    s_hand = struct::get(#"hash_723303fe45c13f65");
    str_stance = e_player getstance();
    var_e12f52f6 = e_player zm_utility::is_player_looking_at(s_hand.origin, 0.99, 0);
    var_2a6b6876 = str_stance == "crouch" || str_stance == "prone";
    return var_e12f52f6 && var_2a6b6876;
}

// Namespace zm_towers_narrative/zm_towers_narrative
// Params 0, eflags: 0x0
// Checksum 0x83283360, Offset: 0x1b40
// Size: 0x1e4
function function_b1631f8d() {
    level endon(#"end_game");
    var_a93a8b28 = getent("mdl_narrative_crawl", "targetname");
    if (!getdvarint(#"zm_ee_enabled", 0)) {
        var_a93a8b28 delete();
        return;
    }
    while (true) {
        level flag::wait_till("special_round");
        level thread function_84eb3c55();
        level thread function_524ab589();
        level flag::wait_till_any(array(#"hash_3bdb012f2eaac96", #"hash_506f1fac74cfdd86"));
        if (level flag::get(#"hash_3bdb012f2eaac96")) {
            break;
        }
        level flag::clear(#"hash_506f1fac74cfdd86");
    }
    t_trigger = getent("t_narrative_crawl", "targetname");
    t_trigger delete();
    var_a93a8b28 clientfield::set("" + #"hash_2407f687f7d24a83", 1);
}

// Namespace zm_towers_narrative/zm_towers_narrative
// Params 0, eflags: 0x0
// Checksum 0x503fd244, Offset: 0x1d30
// Size: 0x64
function function_84eb3c55() {
    level endon(#"end_game", #"hash_506f1fac74cfdd86");
    trigger::wait_till("t_narrative_crawl");
    level flag::set(#"hash_3bdb012f2eaac96");
}

// Namespace zm_towers_narrative/zm_towers_narrative
// Params 0, eflags: 0x0
// Checksum 0x35a01790, Offset: 0x1da0
// Size: 0x64
function function_524ab589() {
    level endon(#"end_game", #"hash_3bdb012f2eaac96");
    level flag::wait_till_clear("special_round");
    level flag::set(#"hash_506f1fac74cfdd86");
}

// Namespace zm_towers_narrative/zm_towers_narrative
// Params 0, eflags: 0x0
// Checksum 0xf0512d77, Offset: 0x1e10
// Size: 0x15c
function function_39ef3ff9() {
    level endon(#"end_game");
    var_a93a8b28 = getent("mdl_narrative_soak", "targetname");
    var_8b18da63 = getentarray("t_narrative_soak", "targetname");
    if (!getdvarint(#"zm_ee_enabled", 0)) {
        var_a93a8b28 delete();
    } else {
        level.var_7f2b3930 = 0;
        level.var_8a4cd8fc = var_8b18da63.size;
        array::thread_all(var_8b18da63, &function_6ed0b447);
        level flag::wait_till(#"hash_4ea18d3d5847ab0c");
        var_a93a8b28 clientfield::set("" + #"hash_2407f687f7d24a83", 1);
    }
    array::delete_all(var_8b18da63);
}

// Namespace zm_towers_narrative/zm_towers_narrative
// Params 0, eflags: 0x0
// Checksum 0x41cb3752, Offset: 0x1f78
// Size: 0x1e4
function function_6ed0b447() {
    self notify("664f4656fa0fb903");
    self endon("664f4656fa0fb903");
    level endon(#"end_game");
    self endon(#"death");
    while (true) {
        s_waitresult = self waittill(#"damage");
        w_weapon = s_waitresult.weapon;
        v_origin = s_waitresult.position;
        if (istouching(v_origin, self) && w_weapon === getweapon(#"eq_frag_grenade")) {
            break;
        }
    }
    var_82679847 = level.var_7f2b3930 + 1;
    if (var_82679847 == self.script_int) {
        level.var_7f2b3930 = var_82679847;
        if (level.var_7f2b3930 >= level.var_8a4cd8fc) {
            level flag::set(#"hash_4ea18d3d5847ab0c");
        }
        return;
    }
    level.var_7f2b3930 = 0;
    var_8b18da63 = getentarray("t_narrative_soak", "targetname");
    arrayremovevalue(var_8b18da63, self);
    array::thread_all(var_8b18da63, &function_6ed0b447);
    self thread function_6ed0b447();
}

// Namespace zm_towers_narrative/zm_towers_narrative
// Params 0, eflags: 0x0
// Checksum 0x5acafbdf, Offset: 0x2168
// Size: 0x1a4
function function_1c93bc4d() {
    level endon(#"end_game");
    var_a93a8b28 = getent("mdl_narrative_payback", "targetname");
    a_vol_statues = getentarray("vol_narrative_payback", "targetname");
    if (!getdvarint(#"zm_ee_enabled", 0)) {
        var_a93a8b28 delete();
    } else {
        level.var_e9fb558f = 0;
        level.var_99aa32b4 = a_vol_statues.size;
        callback::on_connect(&function_f5f12b1d);
        array::thread_all(level.players, &function_f5f12b1d);
        level flag::wait_till(#"hash_aab8ed14df98649");
        callback::remove_on_connect(&function_f5f12b1d);
        var_a93a8b28 clientfield::set("" + #"hash_2407f687f7d24a83", 1);
    }
    array::delete_all(a_vol_statues);
}

// Namespace zm_towers_narrative/zm_towers_narrative
// Params 0, eflags: 0x0
// Checksum 0xe602cc00, Offset: 0x2318
// Size: 0x352
function function_f5f12b1d() {
    self notify("c2edb9d54366fcb");
    self endon("c2edb9d54366fcb");
    level endon(#"end_game", #"hash_aab8ed14df98649");
    self endon(#"disconnect");
    a_w_pistols = array(level.hero_weapon[#"sword_pistol"][0].dualwieldweapon, level.hero_weapon[#"sword_pistol"][1].dualwieldweapon, level.hero_weapon[#"sword_pistol"][2].dualwieldweapon);
    while (true) {
        s_waitresult = self waittill(#"weapon_fired");
        w_weapon = s_waitresult.weapon;
        if (isdefined(w_weapon) && isinarray(a_w_pistols, w_weapon)) {
            v_origin = self getweaponmuzzlepoint();
            v_dir = self getweaponforwarddir();
            n_range = level.hero_weapon_stats[#"sword_pistol"][#"hash_579056d441d637d"];
            v_end = v_origin + vectorscale(v_dir, n_range);
            a_trace = beamtrace(v_origin, v_end, 0, self);
            v_hit = a_trace[#"position"];
            if (isdefined(v_hit)) {
                a_vol_statues = getentarray("vol_narrative_payback", "targetname");
                foreach (vol_statue in a_vol_statues) {
                    if (istouching(v_hit, vol_statue)) {
                        var_ed97ecf5 = level.var_e9fb558f + 1;
                        if (var_ed97ecf5 == vol_statue.script_int) {
                            level.var_e9fb558f = var_ed97ecf5;
                            if (level.var_e9fb558f >= level.var_99aa32b4) {
                                level flag::set(#"hash_aab8ed14df98649");
                            }
                        } else {
                            level.var_e9fb558f = 0;
                        }
                        break;
                    }
                }
            }
        }
    }
}

// Namespace zm_towers_narrative/zm_towers_narrative
// Params 0, eflags: 0x0
// Checksum 0x453757fd, Offset: 0x2678
// Size: 0x220
function acid_trap_think() {
    level endon(#"end_game");
    var_a93a8b28 = getent("mdl_narrative_burn", "targetname");
    if (!getdvarint(#"zm_ee_enabled", 0)) {
        var_a93a8b28 delete();
        return;
    }
    scene::add_scene_func(#"p8_fxanim_zm_towers_trap_acid_02_bundle", &function_96aa6111, "play");
    var_a168b48c = level.var_174215c8;
    var_3f782535 = arraygetclosest(var_a93a8b28.origin, var_a168b48c);
    var_3f782535 thread function_711566fc();
    var_3f782535 thread function_12693fc2();
    while (true) {
        level flag::wait_till_all(array(#"hash_3e90f82a2802b3", #"hash_26c9e53e0e558572"));
        var_a93a8b28 clientfield::set("" + #"hash_2407f687f7d24a83", 1);
        level flag::wait_till_clear_any(array(#"hash_3e90f82a2802b3", #"hash_26c9e53e0e558572"));
        var_a93a8b28 clientfield::set("" + #"hash_2407f687f7d24a83", 0);
    }
}

// Namespace zm_towers_narrative/zm_towers_narrative
// Params 1, eflags: 0x0
// Checksum 0x5cc0415a, Offset: 0x28a0
// Size: 0x104
function function_96aa6111(a_ents) {
    var_a93a8b28 = getent("mdl_narrative_burn", "targetname");
    a_s_scenes = struct::get_array(self.scriptbundlename, "scriptbundlename");
    s_closest = arraygetclosest(var_a93a8b28.origin, a_s_scenes);
    if (s_closest == self) {
        level scene::remove_scene_func(self.scriptbundlename, &function_96aa6111, "play");
        var_a43b3070 = a_ents[#"prop 1"];
        var_a93a8b28 linkto(var_a43b3070, var_a93a8b28.var_2a4381ea);
    }
}

// Namespace zm_towers_narrative/zm_towers_narrative
// Params 0, eflags: 0x0
// Checksum 0x2b4b0bc4, Offset: 0x29b0
// Size: 0x108
function function_711566fc() {
    level endon(#"end_game");
    self endon(#"death");
    str_id = self.script_string;
    while (true) {
        var_82c817b7 = level waittill(#"trap_activate");
        if (var_82c817b7 === self) {
            level flag::set(#"hash_3e90f82a2802b3");
            s_waitresult = level waittill(#"traps_cooldown");
            str_off = s_waitresult.var_f6bb8854;
            if (str_off === str_id) {
                level flag::clear(#"hash_3e90f82a2802b3");
            }
        }
    }
}

// Namespace zm_towers_narrative/zm_towers_narrative
// Params 0, eflags: 0x0
// Checksum 0xdcc649c1, Offset: 0x2ac0
// Size: 0x148
function function_12693fc2() {
    level endon(#"end_game");
    self endon(#"death");
    while (true) {
        wait 1;
        var_4cab8967 = 0;
        foreach (e_player in level.players) {
            if (zm_utility::is_player_valid(e_player, 0, 0) && e_player istouching(self)) {
                var_4cab8967 = 1;
                break;
            }
        }
        if (var_4cab8967) {
            level flag::set(#"hash_26c9e53e0e558572");
            continue;
        }
        level flag::clear(#"hash_26c9e53e0e558572");
    }
}

// Namespace zm_towers_narrative/zm_towers_narrative
// Params 0, eflags: 0x0
// Checksum 0x2f81d002, Offset: 0x2c10
// Size: 0x23c
function function_9f27200() {
    level endon(#"end_game");
    var_a93a8b28 = getent("mdl_narrative_destiny", "targetname");
    a_t_shields = getentarray("t_narrative_destiny", "targetname");
    if (!getdvarint(#"zm_ee_enabled", 0)) {
        var_a93a8b28 delete();
    } else {
        var_b4ca388 = 0;
        var_fa0a0e58 = a_t_shields.size;
        while (true) {
            t_shield = trigger::wait_till("t_narrative_destiny");
            if (var_b4ca388 != t_shield.script_int) {
                var_182f0452 = var_b4ca388 + 1;
                if (var_182f0452 == t_shield.script_int) {
                    var_b4ca388 = var_182f0452;
                    if (var_b4ca388 >= var_fa0a0e58) {
                        break;
                    }
                    continue;
                }
                var_b4ca388 = 0;
            }
        }
        mdl_shield = getent("mdl_narrative_bash", "targetname");
        mdl_shield movex(-2, 0.5);
        mdl_shield rotatepitch(15, 0.5);
        var_a93a8b28 clientfield::set("" + #"hash_2407f687f7d24a83", 1);
    }
    array::delete_all(a_t_shields);
}

// Namespace zm_towers_narrative/zm_towers_narrative
// Params 0, eflags: 0x0
// Checksum 0x2ec1d987, Offset: 0x2e58
// Size: 0x11c
function function_c1e20981() {
    level endon(#"end_game");
    var_a93a8b28 = getent("mdl_narrative_slash", "targetname");
    if (!getdvarint(#"zm_ee_enabled", 0)) {
        var_a93a8b28 delete();
        return;
    }
    callback::on_ai_killed(&function_48ebada7);
    level flag::wait_till(#"hash_7b6594521dfb7bb1");
    callback::remove_on_ai_killed(&function_48ebada7);
    var_a93a8b28 clientfield::set("" + #"hash_2407f687f7d24a83", 1);
}

// Namespace zm_towers_narrative/zm_towers_narrative
// Params 1, eflags: 0x0
// Checksum 0xcc4cd9d7, Offset: 0x2f80
// Size: 0x154
function function_48ebada7(s_params) {
    level endon(#"end_game");
    e_player = s_params.eattacker;
    str_mod = s_params.smeansofdeath;
    var_20358f43 = getent("e_challenge_center_stage", "targetname");
    if (self.archetype == "blight_father" && isdefined(self.var_dd309789) && self.var_dd309789 && self istouching(var_20358f43) && isplayer(e_player) && e_player istouching(var_20358f43) && str_mod === "MOD_UNKNOWN" && isdefined(e_player.var_5d346c5c) && e_player.var_5d346c5c) {
        level flag::set(#"hash_7b6594521dfb7bb1");
    }
}

