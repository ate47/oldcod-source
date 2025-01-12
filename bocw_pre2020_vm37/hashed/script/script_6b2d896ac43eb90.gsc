#using script_1029986e2bc8ca8e;
#using script_1287f54612f9bfce;
#using script_215d7818c548cb51;
#using script_32b18d9fb454babf;
#using script_4364094db7b986ff;
#using script_55b68e9c3e3a915b;
#using script_5a8a1aa32dea1a04;
#using script_5fb26eef020f9958;
#using script_7d7ac1f663edcdc8;
#using script_7fc996fe8678852;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\gameobjects_shared;
#using scripts\core_common\popups_shared;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\zm_common\zm_fasttravel;

#namespace namespace_dbb31ff3;

// Namespace namespace_dbb31ff3/level_init
// Params 1, eflags: 0x40
// Checksum 0x9b408336, Offset: 0x1e8
// Size: 0x4c
function event_handler[level_init] main(*eventstruct) {
    clientfield::register("toplayer", "" + #"hash_5616eb8cc6b9c498", 1, 1, "counter");
}

// Namespace namespace_dbb31ff3/namespace_dbb31ff3
// Params 1, eflags: 0x1 linked
// Checksum 0xa3cc20bc, Offset: 0x240
// Size: 0x84
function function_67dce9cd(var_beee4994) {
    s_beacon = var_beee4994[0];
    if (isdefined(s_beacon)) {
        level thread function_445a939(s_beacon);
        wait 1.5;
        s_portal = s_beacon.var_fe2612fe[#"portal"][0];
        level thread function_a2ac4589(s_portal);
    }
}

// Namespace namespace_dbb31ff3/namespace_dbb31ff3
// Params 1, eflags: 0x1 linked
// Checksum 0x961d3c8, Offset: 0x2d0
// Size: 0x274
function function_445a939(struct) {
    struct.objid = gameobjects::get_next_obj_id();
    objective_add(struct.objid, "active", struct.origin, #"hash_550113857d521cf0");
    var_6afa034c = namespace_8b6a9d79::spawn_script_model(struct, #"hash_3540bd8c522bc98f");
    var_6afa034c thread function_22aada64();
    var_6afa034c clientfield::set("safehouse_machine_spawn_rob", 1);
    v_trigger_offset = (0, 0, 32);
    trigger = namespace_8b6a9d79::function_214737c7(struct, &function_981ec35b, #"hash_24961462354ea22", undefined, 100, undefined, undefined, v_trigger_offset);
    trigger.var_9d7362a4 = #"hash_24961462354ea22";
    trigger usetriggerrequirelookat(0);
    level.var_1ea1d494 = trigger;
    while (true) {
        s_result = level waittill(#"hash_3e765c26047c9f54", #"hash_345e9169ebba28fb", #"hash_e7e1a3e982f9d78");
        if (s_result._notify !== #"hash_e7e1a3e982f9d78") {
            break;
        }
        objective_setinvisibletoall(struct.objid);
        level flag::wait_till_clear(#"hash_e7e1a3e982f9d78");
        objective_setvisibletoall(struct.objid);
    }
    objective_delete(struct.objid);
    gameobjects::release_obj_id(struct.objid);
    trigger delete();
}

// Namespace namespace_dbb31ff3/namespace_dbb31ff3
// Params 1, eflags: 0x1 linked
// Checksum 0xcc940a49, Offset: 0x550
// Size: 0xb8
function function_981ec35b(eventstruct) {
    if (level flag::get(#"hash_e7e1a3e982f9d78")) {
        return;
    }
    if (getgametypesetting(#"hash_704e4a94667cfe72")) {
        var_8e862768 = function_c65468ef(eventstruct.activator, #"hash_575d68cca86c8df4", #"hash_37a354c147ec32f0");
        if (!var_8e862768) {
            return;
        }
    }
    level notify(#"hash_3e765c26047c9f54");
}

// Namespace namespace_dbb31ff3/namespace_dbb31ff3
// Params 0, eflags: 0x1 linked
// Checksum 0xdf9035d1, Offset: 0x610
// Size: 0x114
function function_22aada64() {
    self endon(#"death");
    self val::set(#"beacon", "takedamage", 1);
    n_damage = 0;
    n_threshold = 1000 * getplayers().size * level.var_b48509f9;
    while (true) {
        s_result = self waittill(#"damage");
        n_damage += s_result.amount;
        if (n_damage > n_threshold) {
            namespace_553954de::function_7c97e961(level.var_b48509f9 + 2);
            self val::function_e681e68e(#"beacon");
            break;
        }
    }
}

// Namespace namespace_dbb31ff3/namespace_dbb31ff3
// Params 1, eflags: 0x1 linked
// Checksum 0x3a1fe883, Offset: 0x730
// Size: 0x2b4
function function_a2ac4589(struct) {
    v_offset = (0, 0, 48);
    mdl_portal = util::spawn_model(#"hash_4a8d0b5e400e39f3", struct.origin + v_offset, struct.angles + (0, 90, 0));
    mdl_portal setscale(5);
    struct.objid = gameobjects::get_next_obj_id();
    objective_add(struct.objid, "active", struct.origin, #"hash_788f637c735eb34d");
    trigger = namespace_8b6a9d79::function_214737c7(struct, &function_9e0d6568, #"hash_57837a8d475db7d", undefined, undefined, undefined, undefined, v_offset);
    trigger.var_9d7362a4 = #"hash_57837a8d475db7d";
    level.var_bbf3bf5d = trigger;
    while (true) {
        s_result = level waittill(#"hash_3e765c26047c9f54", #"hash_345e9169ebba28fb", #"hash_e7e1a3e982f9d78");
        if (s_result._notify !== #"hash_e7e1a3e982f9d78") {
            break;
        }
        objective_setinvisibletoall(struct.objid);
        level.var_1ea1d494 sethintstring("");
        level flag::wait_till_clear(#"hash_e7e1a3e982f9d78");
        level.var_1ea1d494 sethintstring(level.var_1ea1d494.var_9d7362a4);
        objective_setvisibletoall(struct.objid);
    }
    objective_delete(struct.objid);
    gameobjects::release_obj_id(struct.objid);
    mdl_portal delete();
    trigger delete();
}

// Namespace namespace_dbb31ff3/namespace_dbb31ff3
// Params 1, eflags: 0x1 linked
// Checksum 0x8489c03c, Offset: 0x9f0
// Size: 0x5a8
function function_9e0d6568(eventstruct) {
    if (level flag::get(#"hash_e7e1a3e982f9d78")) {
        return;
    }
    level flag::set(#"hash_e7e1a3e982f9d78");
    if (getgametypesetting(#"hash_704e4a94667cfe72")) {
        var_8e862768 = function_c65468ef(eventstruct.activator, #"hash_2ab4a12f6a32c41a", #"hash_4ef08498325828d6");
        if (!var_8e862768) {
            level flag::clear(#"hash_e7e1a3e982f9d78");
            return;
        }
    }
    if (isdefined(level.var_fdcaf3a6)) {
        level flag::clear(#"hash_e7e1a3e982f9d78");
        return;
    }
    self setinvisibletoall();
    foreach (player in getplayers()) {
        player thread namespace_77bd50da::function_cc8342e0(#"hash_f6cc0b554836950", 10);
        player clientfield::increment_to_player("" + #"hash_5616eb8cc6b9c498", 1);
    }
    playsoundatposition(#"hash_56185c2ecbecfafb", (0, 0, 0));
    destination = level.var_7d45d0d4.var_d60029a6[level.var_7d45d0d4.var_46849b1b];
    level thread namespace_18bbc38e::function_ab94c270(destination);
    objective_manager::start_timer(10);
    playsoundatposition(#"hash_5ccf2f0b27ccbf41", (0, 0, 0));
    objective_manager::function_b06af8e3(destination);
    var_b2e24cfc = namespace_18bbc38e::function_f3be07d7(destination);
    assert(var_b2e24cfc.size >= 4, "<dev string:x38>" + destination.targetname);
    level flag::clear(#"hash_e7e1a3e982f9d78");
    level notify(#"hash_345e9169ebba28fb");
    if (!isdefined(level.var_16fecec8)) {
        level.var_16fecec8 = 1;
    }
    foreach (player in getplayers()) {
        player thread function_7b3dca17(var_b2e24cfc[0]);
        if (var_b2e24cfc.size > 1) {
            arrayremoveindex(var_b2e24cfc, 0, 0);
        }
    }
    var_e8f53400 = 1;
    while (var_e8f53400) {
        var_e8f53400 = 0;
        foreach (player in getplayers()) {
            if (is_true(player.var_16735873)) {
                var_e8f53400 = 1;
                break;
            }
        }
        if (!var_e8f53400) {
            break;
        }
        wait 1;
    }
    wait 1;
    foreach (player in getplayers()) {
        player luinotifyevent(#"hash_5b1ff06d07e9002a", 3, 2, level.var_b48509f9, 0);
    }
}

// Namespace namespace_dbb31ff3/namespace_dbb31ff3
// Params 1, eflags: 0x1 linked
// Checksum 0xa0dd0e9b, Offset: 0xfa0
// Size: 0x54
function function_7b3dca17(s_spawn) {
    self function_8319d39();
    self zm_fasttravel::function_66d020b0(undefined, undefined, undefined, "survival_next_dest", s_spawn, undefined, undefined, 1, 1);
}

// Namespace namespace_dbb31ff3/namespace_dbb31ff3
// Params 0, eflags: 0x1 linked
// Checksum 0xb2015a77, Offset: 0x1000
// Size: 0xac
function function_8319d39() {
    self notify(#"hash_6dd2905cac0ff8d0");
    level.var_2457162c sr_weapon_upgrade_menu::close(self);
    level.var_5df76d0 sr_perk_machine_choice::close(self);
    level.var_2a994cc0 sr_armor_menu::close(self);
    level.var_3ed9fd33 sr_crafting_table_menu::close(self);
    self namespace_553954de::function_548f282();
}

// Namespace namespace_dbb31ff3/namespace_dbb31ff3
// Params 3, eflags: 0x1 linked
// Checksum 0xb3beb9f3, Offset: 0x10b8
// Size: 0x4ac
function function_c65468ef(var_2d1ee75a, var_5c765806, var_f965fa7) {
    if (is_true(level.var_6f754d87)) {
        return 0;
    }
    a_e_players = function_a1ef346b();
    arrayremovevalue(a_e_players, var_2d1ee75a);
    var_ff27a24 = 0;
    /#
        var_ff27a24 = getdvarint(#"hash_23982855c95ec06", 0) > 0;
    #/
    if (a_e_players.size > 0 || var_ff27a24) {
        level.var_6f754d87 = 1;
        if (isdefined(level.var_1ea1d494)) {
            level.var_1ea1d494 sethintstring("");
        }
        if (isdefined(level.var_bbf3bf5d)) {
            level.var_bbf3bf5d sethintstring("");
        }
        var_8b9e1fe4 = spawnstruct();
        var_8b9e1fe4.var_2d1ee75a = var_2d1ee75a;
        var_8b9e1fe4.var_8cab39d9 = [];
        var_8b9e1fe4.var_5c765806 = var_5c765806;
        var_8b9e1fe4.var_f965fa7 = var_f965fa7;
        level.var_c5beea37 = var_8b9e1fe4;
        callback::on_spawned(&function_287ce935);
        callback::on_death(&function_3728d19b);
        if (!var_ff27a24) {
            var_2d1ee75a thread function_287ce935(var_8b9e1fe4, 1);
        } else {
            a_e_players = getplayers();
        }
        foreach (e_player in a_e_players) {
            e_player thread function_287ce935(var_8b9e1fe4);
        }
        var_8b9e1fe4 thread function_e7c57e4();
        var_8e862768 = var_8b9e1fe4 function_4b4f57db();
        level.var_6f754d87 = 0;
        if (is_true(var_8e862768)) {
            var_8b9e1fe4 notify(#"hash_2a14368bde086f2e");
        } else {
            var_8e862768 = 0;
            if (isdefined(level.var_1ea1d494)) {
                level.var_1ea1d494 sethintstring(level.var_1ea1d494.var_9d7362a4);
            }
            if (isdefined(level.var_bbf3bf5d)) {
                level.var_bbf3bf5d sethintstring(level.var_bbf3bf5d.var_9d7362a4);
            }
            level thread popups::displayteammessagetoall(var_f965fa7, var_2d1ee75a);
        }
        callback::remove_on_spawned(&function_287ce935);
        callback::remove_on_death(&function_3728d19b);
        foreach (e_player in getplayers()) {
            if (level.var_a8831379 sr_vote_prompt::is_open(e_player)) {
                level.var_a8831379 sr_vote_prompt::close(e_player);
            }
        }
        level.var_c5beea37 = undefined;
        var_8b9e1fe4 struct::delete();
    } else {
        var_8e862768 = 1;
    }
    return var_8e862768;
}

// Namespace namespace_dbb31ff3/namespace_dbb31ff3
// Params 0, eflags: 0x1 linked
// Checksum 0x9b761d2, Offset: 0x1570
// Size: 0x116
function function_4b4f57db() {
    self endon(#"hash_2c37ff2ab3cc12c5");
    while (true) {
        switch (function_a1ef346b().size) {
        case 2:
            var_79dbc69 = 2;
            break;
        case 3:
            var_79dbc69 = 2;
            break;
        case 4:
            var_79dbc69 = 3;
            break;
        case 5:
            var_79dbc69 = 3;
            break;
        default:
            var_79dbc69 = 1;
            break;
        }
        function_1eaaceab(self.var_8cab39d9);
        if (self.var_8cab39d9.size >= var_79dbc69) {
            return 1;
        }
        waitframe(1);
    }
}

// Namespace namespace_dbb31ff3/namespace_dbb31ff3
// Params 0, eflags: 0x1 linked
// Checksum 0x1914dd84, Offset: 0x1690
// Size: 0x3e
function function_e7c57e4() {
    self endon(#"hash_2a14368bde086f2e", #"hash_2c37ff2ab3cc12c5");
    wait 30;
    self notify(#"hash_2c37ff2ab3cc12c5");
}

// Namespace namespace_dbb31ff3/namespace_dbb31ff3
// Params 2, eflags: 0x1 linked
// Checksum 0x8dabe223, Offset: 0x16d8
// Size: 0x478
function function_287ce935(var_8b9e1fe4, var_e058812d = 0) {
    var_8b9e1fe4 = isdefined(var_8b9e1fe4) ? var_8b9e1fe4 : level.var_c5beea37;
    if (!isdefined(var_8b9e1fe4)) {
        return;
    }
    self notify("2b92d69a55ddd4c6");
    self endon("2b92d69a55ddd4c6");
    var_8b9e1fe4 endon(#"hash_2a14368bde086f2e", #"hash_2c37ff2ab3cc12c5");
    self endon(#"death");
    if (!level.var_a8831379 sr_vote_prompt::is_open(self)) {
        level.var_a8831379 sr_vote_prompt::open(self, 0);
    }
    level.var_a8831379 sr_vote_prompt::function_7308be62(self, var_8b9e1fe4.var_5c765806);
    level.var_a8831379 sr_vote_prompt::function_cd2610bc(self, var_8b9e1fe4.var_2d1ee75a getentitynumber());
    if (!var_e058812d) {
        level.var_a8831379 sr_vote_prompt::function_1dc82d57(self, 0);
        var_87b860ab = 0;
        while (!var_87b860ab) {
            level.var_a8831379 sr_vote_prompt::function_9d1ae78b(self, 0);
            while (true) {
                self function_eb5582d7();
                if (self gamepadusedlast() && self actionslottwobuttonpressed() || !self gamepadusedlast() && self usebuttonpressed()) {
                    break;
                }
                waitframe(1);
            }
            n_start_time = gettime();
            while (true) {
                self function_eb5582d7();
                if (self gamepadusedlast() && !self actionslottwobuttonpressed() || !self gamepadusedlast() && !self usebuttonpressed()) {
                    break;
                }
                n_time_passed = float(gettime() - n_start_time) / 1000;
                if (n_time_passed > 0.1) {
                    n_percent = (n_time_passed - 0.1) / 1;
                    level.var_a8831379 sr_vote_prompt::function_9d1ae78b(self, n_percent);
                    if (n_percent >= 1) {
                        var_87b860ab = 1;
                        break;
                    }
                }
                waitframe(1);
            }
        }
    }
    wait 0.1;
    level.var_a8831379 sr_vote_prompt::function_ed78f536(self, 0);
    level.var_a8831379 sr_vote_prompt::function_ee141c89(self, 0);
    level.var_a8831379 sr_vote_prompt::function_1dc82d57(self, 1);
    if (!isdefined(var_8b9e1fe4.var_8cab39d9)) {
        var_8b9e1fe4.var_8cab39d9 = [];
    } else if (!isarray(var_8b9e1fe4.var_8cab39d9)) {
        var_8b9e1fe4.var_8cab39d9 = array(var_8b9e1fe4.var_8cab39d9);
    }
    if (!isinarray(var_8b9e1fe4.var_8cab39d9, self)) {
        var_8b9e1fe4.var_8cab39d9[var_8b9e1fe4.var_8cab39d9.size] = self;
    }
}

// Namespace namespace_dbb31ff3/namespace_dbb31ff3
// Params 0, eflags: 0x1 linked
// Checksum 0x3e579838, Offset: 0x1b58
// Size: 0x11c
function function_eb5582d7() {
    if (self gamepadusedlast()) {
        if (!self flag::get("sr_vote_prompt_using_gamepad")) {
            self flag::set("sr_vote_prompt_using_gamepad");
            level.var_a8831379 sr_vote_prompt::function_ed78f536(self, 0);
            level.var_a8831379 sr_vote_prompt::function_ee141c89(self, 1);
        }
        return;
    }
    if (self flag::get("sr_vote_prompt_using_gamepad")) {
        self flag::clear("sr_vote_prompt_using_gamepad");
        level.var_a8831379 sr_vote_prompt::function_ed78f536(self, 1);
        level.var_a8831379 sr_vote_prompt::function_ee141c89(self, 0);
    }
}

// Namespace namespace_dbb31ff3/namespace_dbb31ff3
// Params 0, eflags: 0x1 linked
// Checksum 0x69df25ef, Offset: 0x1c80
// Size: 0x40
function function_3728d19b() {
    var_8b9e1fe4 = level.var_c5beea37;
    if (self === var_8b9e1fe4.var_2d1ee75a) {
        var_8b9e1fe4 notify(#"hash_2c37ff2ab3cc12c5");
    }
}

// Namespace namespace_dbb31ff3/namespace_dbb31ff3
// Params 0, eflags: 0x1 linked
// Checksum 0x50bb848f, Offset: 0x1cc8
// Size: 0x230
function function_5a22584f() {
    level endon(#"end_game");
    level endon(#"hash_3e765c26047c9f54");
    v_trigger_offset = (0, 0, 32);
    s_beacon = struct::get("exfil_radio");
    if (!isdefined(s_beacon)) {
        return;
    }
    level flag::set("rbz_exfil_allowed");
    var_6afa034c = namespace_8b6a9d79::spawn_script_model(s_beacon, #"hash_347b4659dbd0b318");
    while (true) {
        level flag::wait_till("rbz_exfil_beacon_active");
        s_beacon.objid = gameobjects::get_next_obj_id();
        objective_add(s_beacon.objid, "active", s_beacon.origin, #"hash_550113857d521cf0");
        trigger = namespace_8b6a9d79::function_214737c7(s_beacon, &function_981ec35b, #"hash_24961462354ea22", undefined, 100, undefined, undefined, v_trigger_offset);
        trigger.var_9d7362a4 = #"hash_24961462354ea22";
        trigger usetriggerrequirelookat(0);
        level thread function_7d929478(s_beacon, trigger);
        level flag::wait_till_clear("rbz_exfil_beacon_active");
        level notify(#"hash_7da56c59360538c");
        function_992dc59a(s_beacon, trigger);
    }
}

// Namespace namespace_dbb31ff3/namespace_dbb31ff3
// Params 2, eflags: 0x1 linked
// Checksum 0xbd10c9b3, Offset: 0x1f00
// Size: 0x254
function function_7d929478(s_beacon, trigger) {
    level endon(#"hash_7da56c59360538c");
    level.var_1ea1d494 = trigger;
    while (true) {
        s_result = level waittill(#"hash_3e765c26047c9f54", #"hash_345e9169ebba28fb");
        if (s_result._notify !== #"hash_e7e1a3e982f9d78") {
            break;
        }
        objective_setinvisibletoall(s_beacon.objid);
        level flag::wait_till_clear(#"hash_e7e1a3e982f9d78");
        objective_setvisibletoall(s_beacon.objid);
    }
    if (isdefined(level.var_ad5e81fe)) {
        foreach (zone in level.var_ad5e81fe) {
            var_a0ee7be4 = getentarray(zone, "script_flag");
            foreach (door in var_a0ee7be4) {
                door notify(#"trigger", {#activator:getplayers()[0]});
            }
        }
    }
    function_992dc59a(s_beacon, trigger);
}

// Namespace namespace_dbb31ff3/namespace_dbb31ff3
// Params 2, eflags: 0x1 linked
// Checksum 0x905a5a54, Offset: 0x2160
// Size: 0x6c
function function_992dc59a(s_beacon, trigger) {
    level.var_1ea1d494 = undefined;
    objective_delete(s_beacon.objid);
    gameobjects::release_obj_id(s_beacon.objid);
    trigger delete();
}

// Namespace namespace_dbb31ff3/namespace_dbb31ff3
// Params 1, eflags: 0x1 linked
// Checksum 0x90d04b16, Offset: 0x21d8
// Size: 0x24
function function_fa5bd408(a_zones) {
    if (isdefined(a_zones)) {
        level.var_ad5e81fe = a_zones;
    }
}

