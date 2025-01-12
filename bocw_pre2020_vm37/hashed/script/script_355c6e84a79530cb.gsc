#using script_1029986e2bc8ca8e;
#using script_113dd7f0ea2a1d4f;
#using script_1cc417743d7c262d;
#using script_215d7818c548cb51;
#using script_23ffc3f9567be80c;
#using script_25be5471a9c31833;
#using script_2618e0f3e5e11649;
#using script_4ccfb58a9443a60b;
#using script_6b2d896ac43eb90;
#using script_6fc2be37feeb317b;
#using script_7a5293d92c61c788;
#using script_7fc996fe8678852;
#using scripts\core_common\armor;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\gameobjects_shared;
#using scripts\core_common\laststand_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\zm_common\zm_score;

#namespace namespace_73df937d;

// Namespace namespace_73df937d/namespace_73df937d
// Params 0, eflags: 0x6
// Checksum 0x77e3d8f5, Offset: 0x260
// Size: 0x54
function private autoexec __init__system__() {
    system::register(#"hash_5ff56dba9074b0b4", &function_70a657d8, undefined, &finalize, #"hash_f81b9dea74f0ee");
}

// Namespace namespace_73df937d/namespace_73df937d
// Params 0, eflags: 0x1 linked
// Checksum 0x235c42ed, Offset: 0x2c0
// Size: 0x15c
function function_70a657d8() {
    namespace_8b6a9d79::function_b3464a7c("safehouse", &function_d0e7af66);
    level clientfield::register("scriptmover", "safehouse_beam_fx", 1, 1, "int");
    level clientfield::register("scriptmover", "safehouse_claim_fx", 1, 1, "int");
    level clientfield::register("scriptmover", "safehouse_machine_spawn_rob", 1, 1, "int");
    callback::add_callback(#"hash_17028f0b9883e5be", &function_83b6d24a);
    callback::add_callback(#"objective_ended", &function_2b1da4a6);
    clientfield::register_clientuimodel("hudItems.survivalOverlayOpen", 1, 1, "int");
}

// Namespace namespace_73df937d/namespace_73df937d
// Params 0, eflags: 0x1 linked
// Checksum 0x14f58e6a, Offset: 0x428
// Size: 0x2a
function finalize() {
    level.var_7d45d0d4.var_a4bccdb2 = [];
    level.var_7d45d0d4.var_bb7e7804 = 1;
}

// Namespace namespace_73df937d/namespace_73df937d
// Params 1, eflags: 0x1 linked
// Checksum 0xe674db32, Offset: 0x460
// Size: 0x11c
function function_de302547(destination) {
    foreach (location in destination.locations) {
        safehouse = location.instances[#"safehouse"];
        if (isdefined(safehouse)) {
            objective_manager::function_9d4e6125(safehouse.content_script_name);
            namespace_8b6a9d79::function_20d7e9c7(safehouse);
            level.var_7d45d0d4.var_c4181ea = safehouse;
            namespace_ce1f29cc::function_12c2f41f(safehouse.origin, 2000);
            break;
        }
    }
}

// Namespace namespace_73df937d/namespace_73df937d
// Params 1, eflags: 0x1 linked
// Checksum 0xadd0e7c3, Offset: 0x588
// Size: 0xd4
function function_d0e7af66(instance) {
    assert(isarray(instance.var_fe2612fe[#"hash_71b89bdce48d11f6"]), "<dev string:x38>");
    assert(instance.var_fe2612fe[#"hash_71b89bdce48d11f6"].size == 1, "<dev string:x66>");
    var_7d0e37f8 = instance.var_fe2612fe[#"hash_71b89bdce48d11f6"][0];
    function_e9bd72e8(var_7d0e37f8, instance);
}

// Namespace namespace_73df937d/namespace_73df937d
// Params 0, eflags: 0x1 linked
// Checksum 0x81d530a0, Offset: 0x668
// Size: 0x34
function function_2b0784c1() {
    self luinotifyevent(#"hash_5159e35a62fb7083", 3, 1, 0, 0);
}

// Namespace namespace_73df937d/namespace_73df937d
// Params 1, eflags: 0x1 linked
// Checksum 0xa86c06d8, Offset: 0x6a8
// Size: 0x2d4
function function_d9ea0e09(eventstruct) {
    assert(isdefined(self.instance), "<dev string:x89>");
    if (flag::get("objective_locked")) {
        return;
    }
    player = eventstruct.activator;
    instance = self.instance;
    scriptmodel = self.scriptmodel;
    if (isplayer(player) && player zm_score::can_player_purchase(0) && !is_true(self.var_c1e1d9cb)) {
        self.var_c1e1d9cb = 1;
        scriptmodel clientfield::set("safehouse_claim_fx", 0);
        level thread function_e1fab6a9(instance, scriptmodel.origin);
        level thread util::delay(2.5, undefined, &globallogic_audio::leader_dialog, "safehouseSecure");
        level thread util::delay(2.5, undefined, &globallogic_audio::leader_dialog, "safehouseSecureResponse");
        playrumbleonposition("sr_prototype_safehouse_rumble", self.origin);
        playsoundatposition(#"hash_4838c0bb2e18c3d7", scriptmodel.origin);
        player thread function_2b0784c1();
        player zm_score::minus_to_player_score(0);
        objid = instance.objectiveid;
        objective_setinvisibletoall(objid);
        waittillframeend();
        util::wait_network_frame();
        level notify(#"hash_581a9d913f67821a");
        if (isdefined(self)) {
            if (isdefined(scriptmodel)) {
                scriptmodel delete();
            }
            self delete();
        }
        return;
    }
    playsoundatposition(#"hash_331360fb3bc61a2e", scriptmodel.origin + (0, 0, 50));
}

// Namespace namespace_73df937d/namespace_73df937d
// Params 2, eflags: 0x1 linked
// Checksum 0x3a7a25e6, Offset: 0x988
// Size: 0x1b0
function function_e1fab6a9(instance, v_center) {
    assert(isdefined(instance), "<dev string:xb3>");
    a_machines = namespace_8b6a9d79::function_f703a5a(instance);
    a_machines = arraysortclosest(a_machines, v_center);
    n_time_elapsed = 0;
    wait 2.4;
    foreach (s_machine in a_machines) {
        n_dist = distance(s_machine.origin, v_center);
        n_wait = n_dist / 600 * 1.5 - n_time_elapsed - 0.1;
        if (n_wait > 0 && n_time_elapsed < 1.5) {
            wait n_wait;
            n_time_elapsed += n_wait;
        }
        level thread function_ae44cb3d(instance, s_machine.content_key);
    }
}

// Namespace namespace_73df937d/namespace_73df937d
// Params 2, eflags: 0x1 linked
// Checksum 0xb4e832f6, Offset: 0xb40
// Size: 0x1da
function function_ae44cb3d(instance, var_eece1f6a) {
    switch (var_eece1f6a) {
    case #"perk_machine_choice":
        namespace_82b4c2d1::function_999594fe(instance.var_fe2612fe[#"perk_machine_choice"], #"hash_4af85251966549b8", #"hash_7394911732c68226", #"hash_3eac5ec7a888ddfb", 0);
        break;
    case #"hash_629e563c2ebf707a":
        namespace_dd7e54e3::function_1cbc3614(instance.var_fe2612fe[#"hash_629e563c2ebf707a"]);
        break;
    case #"crafting_table":
        namespace_1cc7b406::function_7dddb953(instance.var_fe2612fe[#"crafting_table"]);
        break;
    case #"hash_448adaf187bbb953":
        namespace_4b9fccd8::function_cb9d309b(instance.var_fe2612fe[#"hash_448adaf187bbb953"]);
        break;
    case #"hash_5aa51584db09513":
        namespace_c71c7ca5::function_1142ba4a(instance.var_fe2612fe[#"hash_5aa51584db09513"]);
        break;
    case #"beacon":
        namespace_dbb31ff3::function_67dce9cd(instance.var_fe2612fe[#"beacon"]);
        break;
    }
}

// Namespace namespace_73df937d/namespace_73df937d
// Params 1, eflags: 0x0
// Checksum 0xcee5343f, Offset: 0xd28
// Size: 0x17a
function function_f1bc8a08(player) {
    self endon(#"death");
    if (isdefined(player.armortier)) {
        switch (player.armortier) {
        case 0:
            self sethintstring(#"hash_5a07d4e777cd962a", "Armor Lv. 1", 500);
            break;
        case 1:
            self sethintstring(#"hash_5a07d4e777cd962a", "Armor Lv. 2", 1000);
            break;
        case 2:
            self sethintstring(#"hash_5a07d4e777cd962a", "Armor Lv. 3", 1500);
            break;
        case 3:
            if (player armor::at_peak_armor_bars()) {
                self sethintstring(#"hash_7dfea1c8f4ee103");
            } else {
                self sethintstring(#"hash_3ed2de51f2aea0ff", 1000);
            }
            break;
        }
    }
}

// Namespace namespace_73df937d/namespace_73df937d
// Params 2, eflags: 0x1 linked
// Checksum 0xda4461f8, Offset: 0xeb0
// Size: 0x1ca
function function_e9bd72e8(var_7d0e37f8, instance) {
    scriptmodel = namespace_8b6a9d79::spawn_script_model(var_7d0e37f8, "tag_origin");
    scriptmodel.origin += (0, 0, 40);
    scriptmodel clientfield::set("safehouse_claim_fx", 1);
    scriptmodel.targetname = "unclaimed_safehouse";
    if (!isdefined(instance.objectiveid)) {
        objid = gameobjects::get_next_obj_id();
        instance.objectiveid = objid;
        objective_add(objid, "active", var_7d0e37f8.origin + (0, 0, 20), #"hash_5eb3b916fdb77012");
    } else {
        objective_setvisibletoall(instance.objectiveid);
    }
    trigger = namespace_8b6a9d79::function_214737c7(var_7d0e37f8, &function_d9ea0e09, #"hash_5ecd49cccca29d87");
    trigger.origin += (0, 0, 40);
    trigger.instance = instance;
    trigger.scriptmodel = scriptmodel;
    trigger sethintstring(#"hash_5ecd49cccca29d87", 0);
    var_7d0e37f8.claimtrigger = trigger;
}

// Namespace namespace_73df937d/namespace_73df937d
// Params 0, eflags: 0x1 linked
// Checksum 0x80cebb89, Offset: 0x1088
// Size: 0x120
function function_83b6d24a() {
    foreach (location in level.var_7d45d0d4.locations) {
        safehouse = location.instances[#"safehouse"];
        if (isdefined(safehouse.var_fe2612fe[#"hash_71b89bdce48d11f6"][0].claimtrigger)) {
            trigger = safehouse.var_fe2612fe[#"hash_71b89bdce48d11f6"][0].claimtrigger;
            trigger sethintstring(#"hash_6d645426c03ab096");
        }
    }
}

// Namespace namespace_73df937d/namespace_73df937d
// Params 0, eflags: 0x1 linked
// Checksum 0x37950e00, Offset: 0x11b0
// Size: 0x120
function function_2b1da4a6() {
    foreach (location in level.var_7d45d0d4.locations) {
        safehouse = location.instances[#"safehouse"];
        if (isdefined(safehouse.var_fe2612fe[#"hash_71b89bdce48d11f6"][0].claimtrigger)) {
            trigger = safehouse.var_fe2612fe[#"hash_71b89bdce48d11f6"][0].claimtrigger;
            trigger sethintstring(#"hash_5ecd49cccca29d87", 0);
        }
    }
}

// Namespace namespace_73df937d/namespace_73df937d
// Params 2, eflags: 0x0
// Checksum 0x76f0e6e2, Offset: 0x12d8
// Size: 0x22
function function_7fa49a26(instance, var_56fa2ec1) {
    instance.var_1dab08f1 = var_56fa2ec1;
}

