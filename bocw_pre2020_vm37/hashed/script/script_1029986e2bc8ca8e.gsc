#using script_113dd7f0ea2a1d4f;
#using script_193d6fcd3b319d05;
#using script_1cc417743d7c262d;
#using script_5961deb533dad533;
#using script_6a4a2311f8a4697;
#using script_7d7ac1f663edcdc8;
#using script_7fc996fe8678852;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\gameobjects_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\zm_common\zm_laststand;
#using scripts\zm_common\zm_player;
#using scripts\zm_common\zm_utility;

#namespace objective_manager;

// Namespace objective_manager/objective_manager
// Params 0, eflags: 0x6
// Checksum 0x46074c9b, Offset: 0x238
// Size: 0x54
function private autoexec __init__system__() {
    system::register(#"objective_manager", &function_70a657d8, undefined, &finalize, #"hash_f81b9dea74f0ee");
}

// Namespace objective_manager/objective_manager
// Params 0, eflags: 0x5 linked
// Checksum 0xd7ff84ab, Offset: 0x298
// Size: 0x1cc
function private function_70a657d8() {
    clientfield::register("actor", "" + #"hash_501374858f77990b", 1, 1, "int");
    clientfield::register("actor", "objective_cf_callout_rob", 1, 2, "int");
    clientfield::register("toplayer", "sr_defend_timer", 18000, getminbitcountfornum(540), "int");
    clientfield::register("scriptmover", "" + #"hash_501374858f77990b", 1, 1, "int");
    clientfield::register("scriptmover", "objective_cf_callout_rob", 1, 2, "int");
    clientfield::register("vehicle", "objective_cf_callout_rob", 1, 2, "int");
    clientfield::function_5b7d846d("hudItems.warzone.objectiveTotal", 1, 5, "int");
    clientfield::function_5b7d846d("hudItems.warzone.objectivesCompleted", 1, 5, "int");
    level.var_cf558bf = 0;
    level.var_4f12f6d0 = sr_objective_timer::register();
}

// Namespace objective_manager/objective_manager
// Params 0, eflags: 0x5 linked
// Checksum 0x2cd0c445, Offset: 0x470
// Size: 0x1c
function private finalize() {
    /#
        level thread init_devgui();
    #/
}

// Namespace objective_manager/objective_manager
// Params 5, eflags: 0x1 linked
// Checksum 0xf106edfa, Offset: 0x498
// Size: 0x1b6
function function_b3464a7c(scriptname, spawncallback, startcallback, category, var_3fc9b09f = #"hash_248bfcefe7e51481") {
    assert(isstring(scriptname) || ishash(scriptname));
    assert(isfunctionptr(startcallback));
    assert(ishash(category));
    if (category == #"exfil") {
        script = namespace_8b6a9d79::function_b3464a7c(scriptname, &function_39eec401);
    } else {
        assert(isfunctionptr(spawncallback));
        script = namespace_8b6a9d79::function_b3464a7c(scriptname, &function_4e8b29ac);
    }
    script.var_32523552 = spawncallback;
    script.var_11dcc37e = startcallback;
    script.objectivecategory = category;
    script.var_331b7cc3 = function_4371154a(category);
    script.var_9ddbb7c = var_3fc9b09f;
}

// Namespace objective_manager/objective_manager
// Params 2, eflags: 0x1 linked
// Checksum 0x3b48c717, Offset: 0x658
// Size: 0x224
function objective_ended(instance, completed = 1) {
    assert(isstruct(instance));
    assert(level.var_7d45d0d4.activeobjective == instance);
    assert(isint(completed));
    level.var_7d45d0d4.var_1d9d92ba = level.var_7d45d0d4.activeobjective;
    level.var_7d45d0d4.activeobjective = undefined;
    level flag::clear("objective_locked");
    level.var_cf558bf++;
    function_2fe379cd();
    if (completed) {
        function_2f9d355c();
        level function_dc7dedf9();
    } else {
        level flag::set("failed_any_objective");
        level function_cad28879();
    }
    level notify(#"objective_ended", {#completed:completed});
    level callback::callback(#"objective_ended", {#instance:instance, #completed:completed});
    instance.success = completed;
    instance notify(#"objective_ended");
    thread function_1571bce9();
}

// Namespace objective_manager/objective_manager
// Params 1, eflags: 0x1 linked
// Checksum 0xf2e1e21f, Offset: 0x888
// Size: 0x6c
function function_d28e25e7(objectivescompleted) {
    assert(objectivescompleted <= 16, "<dev string:x38>");
    if (clientfield::can_set("hudItems.warzone.objectivesCompleted")) {
        level clientfield::set_world_uimodel("hudItems.warzone.objectivesCompleted", objectivescompleted);
    }
}

// Namespace objective_manager/objective_manager
// Params 1, eflags: 0x1 linked
// Checksum 0x83494e2d, Offset: 0x900
// Size: 0x6c
function function_9f6de950(objectivetotal) {
    assert(objectivetotal <= 16, "<dev string:x38>");
    if (clientfield::can_set("hudItems.warzone.objectiveTotal")) {
        level clientfield::set_world_uimodel("hudItems.warzone.objectiveTotal", objectivetotal);
    }
}

// Namespace objective_manager/objective_manager
// Params 1, eflags: 0x1 linked
// Checksum 0x26347433, Offset: 0x978
// Size: 0x64
function function_1571bce9(n_display_time = 10) {
    level endon(#"game_ended");
    wait n_display_time;
    function_9f6de950(0);
    function_d28e25e7(0);
}

// Namespace objective_manager/objective_manager
// Params 0, eflags: 0x0
// Checksum 0xe192c60, Offset: 0x9e8
// Size: 0x24
function function_db1c6627() {
    self clientfield::set("objective_cf_callout_rob", 1);
}

// Namespace objective_manager/objective_manager
// Params 0, eflags: 0x0
// Checksum 0x602d9a0b, Offset: 0xa18
// Size: 0x24
function function_3b0ab786() {
    self clientfield::set("objective_cf_callout_rob", 2);
}

// Namespace objective_manager/objective_manager
// Params 0, eflags: 0x0
// Checksum 0x21933f10, Offset: 0xa48
// Size: 0x24
function function_811514c3() {
    self clientfield::set("objective_cf_callout_rob", 0);
}

// Namespace objective_manager/objective_manager
// Params 1, eflags: 0x4
// Checksum 0xa328560b, Offset: 0xa78
// Size: 0x11a
function private function_20f53e16(&instances) {
    level endon(#"game_ended");
    foreach (instance in instances) {
        namespace_8b6a9d79::function_20d7e9c7(instance);
        s_result = level waittill(#"objective_ended");
        if (s_result.completed === 0 && getdvarint(#"hash_15b141da1584bd0d", 1)) {
            namespace_553954de::end_match(0);
            return;
        }
    }
}

// Namespace objective_manager/objective_manager
// Params 2, eflags: 0x1 linked
// Checksum 0x8027b384, Offset: 0xba0
// Size: 0x454
function function_b06af8e3(destination, var_2923cf48 = 0) {
    foreach (category in level.var_aaa6544c) {
        variant = undefined;
        if (category == #"hash_401d37614277df42" || category == #"exfil") {
            continue;
        } else if (category === #"payload_teleport" || category === #"payload_noteleport") {
            variant = category;
            category = #"payload";
        } else if (category === #"hunt_steiner" || category === #"hash_45f927c8af6cf356" || category === #"hunt_raz") {
            variant = category;
            category = #"hunt";
        }
        instances = destination.var_e859e591[category];
        if (!isdefined(instances)) {
            continue;
        }
        if (isdefined(destination.var_cd5ba489[category]) && !var_2923cf48) {
            continue;
        }
        instances = array::randomize(instances);
        if (isdefined(variant)) {
            category = variant;
            foreach (s_instance in instances) {
                if (s_instance.variant === variant) {
                    instance = s_instance;
                    break;
                }
            }
        } else if (!var_2923cf48 && level.var_cf558bf < 1 && (category === #"hunt" || category === #"payload")) {
            foreach (s_instance in instances) {
                if (s_instance.variant !== #"hunt_steiner" && s_instance.variant !== #"hash_45f927c8af6cf356" && s_instance.variant !== #"payload_teleport") {
                    instance = s_instance;
                    break;
                }
            }
        }
        if (!isdefined(instance)) {
            instance = instances[0];
        }
        arrayremovevalue(level.var_aaa6544c, category);
        level.var_aaa6544c[level.var_aaa6544c.size] = category;
        level.var_7d45d0d4.nextobjective = instance;
        destination.var_cd5ba489[category] = instance;
        return;
    }
    if (!isdefined(instance) && !var_2923cf48) {
        function_b06af8e3(destination, 1);
    }
}

// Namespace objective_manager/objective_manager
// Params 0, eflags: 0x1 linked
// Checksum 0xe1e375e0, Offset: 0x1000
// Size: 0x86
function spawn_objective() {
    if (!isdefined(level.var_7d45d0d4.nextobjective)) {
        function_b06af8e3(level.var_7d45d0d4.currentdestination);
    }
    if (isdefined(level.var_7d45d0d4.nextobjective)) {
        namespace_8b6a9d79::function_20d7e9c7(level.var_7d45d0d4.nextobjective);
        level.var_7d45d0d4.nextobjective = undefined;
    }
}

// Namespace objective_manager/objective_manager
// Params 1, eflags: 0x1 linked
// Checksum 0x8c3e266d, Offset: 0x1090
// Size: 0x5dc
function function_c700a68b(categories) {
    var_d0303ab0 = getdvarstring(#"hash_4c7a7b0813c6765d");
    if (var_d0303ab0 !== "") {
        level.var_aaa6544c = array(var_d0303ab0);
        return;
    }
    level.var_aaa6544c = array::randomize(categories);
    if (is_false(getgametypesetting(#"hash_1a61e028f785b11b")) || is_false(getdvarint(#"hash_1a61e028f785b11b", 1))) {
        arrayremovevalue(level.var_aaa6544c, #"destroy");
    }
    if (is_false(getgametypesetting(#"hash_7a6bdc0af120a35f")) || is_false(getdvarint(#"hash_7a6bdc0af120a35f", 1))) {
        arrayremovevalue(level.var_aaa6544c, #"defend");
    }
    if (is_false(getgametypesetting(#"hash_23331c459fc1fe23")) || is_false(getdvarint(#"hash_23331c459fc1fe23", 1))) {
        arrayremovevalue(level.var_aaa6544c, #"hunt");
    }
    if (is_false(getgametypesetting(#"hash_7d1368d8d487beed")) || is_false(getdvarint(#"hash_7d1368d8d487beed", 1))) {
        arrayremovevalue(level.var_aaa6544c, #"exfil");
    }
    if (is_false(getgametypesetting(#"hash_4ddf1b97bee2b93")) || is_false(getdvarint(#"hash_4ddf1b97bee2b93", 1))) {
        arrayremovevalue(level.var_aaa6544c, #"payload");
    }
    if (is_false(getgametypesetting(#"hash_70343e0c02c9f7b9")) || is_false(getdvarint(#"hash_70343e0c02c9f7b9", 1))) {
        arrayremovevalue(level.var_aaa6544c, #"retrieval");
    }
    if (is_false(getgametypesetting(#"hash_bdf13864e52da12")) || is_false(getdvarint(#"hash_bdf13864e52da12", 1))) {
        arrayremovevalue(level.var_aaa6544c, #"secure");
    }
    if (is_false(getgametypesetting(#"hash_64a988c3a72dea56")) || is_false(getdvarint(#"hash_64a988c3a72dea56", 1))) {
        arrayremovevalue(level.var_aaa6544c, #"hash_3eb0da94cd242359");
    }
    if (is_false(getgametypesetting(#"hash_183fac0f1cab9dc6")) || is_false(getdvarint(#"hash_183fac0f1cab9dc6", 1))) {
        arrayremovevalue(level.var_aaa6544c, #"holdout");
    }
}

// Namespace objective_manager/objective_manager
// Params 2, eflags: 0x4
// Checksum 0x465193f8, Offset: 0x1678
// Size: 0x16e
function private function_ac07f9d8(&destinations, &categories) {
    destination = destinations[0];
    foreach (category in categories) {
        if (category == #"hash_401d37614277df42" || category == #"exfil") {
            continue;
        }
        instances = destination.var_e859e591[category];
        if (!isdefined(instances)) {
            continue;
        }
        instance = instances[randomint(instances.size)];
        namespace_8b6a9d79::function_20d7e9c7(instance);
        destination.var_e859e591 = undefined;
        arrayremovevalue(destinations, destination);
        arrayremovevalue(categories, category);
        categories[categories.size] = category;
        return;
    }
}

// Namespace objective_manager/objective_manager
// Params 0, eflags: 0x4
// Checksum 0xe0e28081, Offset: 0x17f0
// Size: 0x104
function private function_f5cd7b55() {
    destinations = [];
    categories = [];
    function_ef3a1d04(destinations, categories);
    destinations = array::randomize(destinations);
    categories = array::randomize(categories);
    while (destinations.size > 0) {
        foreach (category in categories) {
            function_1df85442(destinations, category);
        }
    }
}

// Namespace objective_manager/objective_manager
// Params 2, eflags: 0x1 linked
// Checksum 0xa22c5f0a, Offset: 0x1900
// Size: 0x2d6
function function_ef3a1d04(&destinations, &categories) {
    foreach (destination in level.var_7d45d0d4.destinations) {
        var_e859e591 = [];
        foreach (location in destination.locations) {
            if (namespace_8b6a9d79::function_fe9fb6fd(location)) {
                continue;
            }
            foreach (scriptname, instance in location.instances) {
                script = namespace_8b6a9d79::function_85255d0f(scriptname);
                category = script.objectivecategory;
                if (!isdefined(category)) {
                    continue;
                }
                if (!isinarray(categories, category)) {
                    categories[categories.size] = category;
                }
                if (!isdefined(var_e859e591[category])) {
                    var_e859e591[category] = [];
                }
                instances = var_e859e591[category];
                instances[instances.size] = instance;
            }
        }
        if (var_e859e591.size > 0) {
            foreach (category, instances in var_e859e591) {
                var_e859e591[category] = array::randomize(instances);
            }
            destination.var_e859e591 = var_e859e591;
            destinations[destinations.size] = destination;
        }
    }
}

// Namespace objective_manager/objective_manager
// Params 2, eflags: 0x5 linked
// Checksum 0x435d51db, Offset: 0x1be0
// Size: 0xfa
function private function_1df85442(&destinations, category) {
    foreach (destination in destinations) {
        instances = destination.var_e859e591[category];
        if (!isdefined(instances)) {
            continue;
        }
        instance = instances[randomint(instances.size)];
        namespace_8b6a9d79::function_20d7e9c7(instance);
        destination.var_e859e591 = undefined;
        arrayremovevalue(destinations, destination);
        return;
    }
}

// Namespace objective_manager/objective_manager
// Params 1, eflags: 0x5 linked
// Checksum 0x6c141f34, Offset: 0x1ce8
// Size: 0x154
function private function_39eec401(instance) {
    script = namespace_8b6a9d79::function_85255d0f(instance.content_script_name);
    if (!getdvarint(#"hash_33b0be96bf3cd69a", 0)) {
        s_result = level waittill(#"hash_345e9169ebba28fb", #"hash_3e765c26047c9f54");
    }
    if (s_result._notify === #"hash_3e765c26047c9f54" || getdvarint(#"hash_33b0be96bf3cd69a", 0)) {
        function_3e365c4f(instance);
        function_9751c453(script.var_331b7cc3, instance.var_fe2612fe[#"hash_216188a7e7b381a6"][0].origin, instance);
        return;
    }
    if (isdefined(instance.var_e55c8b4e)) {
        objective_delete(instance.var_e55c8b4e);
    }
}

// Namespace objective_manager/objective_manager
// Params 1, eflags: 0x5 linked
// Checksum 0x5f7aec51, Offset: 0x1e48
// Size: 0x210
function private function_4e8b29ac(instance) {
    assert(isarray(instance.var_fe2612fe[#"hash_3966465c498df3a6"]));
    assert(instance.var_fe2612fe[#"hash_3966465c498df3a6"].size == 1);
    function_9d4e6125(instance.content_script_name);
    var_7d0e37f8 = instance.var_fe2612fe[#"hash_3966465c498df3a6"][0];
    script = namespace_8b6a9d79::function_85255d0f(instance.content_script_name);
    trigger = function_8239a941(var_7d0e37f8, instance, script.var_9ddbb7c);
    function_9751c453(script.var_331b7cc3, trigger.origin, instance);
    /#
        level.var_d56035 = instance;
    #/
    level thread [[ script.var_32523552 ]](instance);
    if (isdefined(instance.var_fe2612fe[#"hash_74440ced95db880d"])) {
        foreach (var_3fb152a3 in instance.var_fe2612fe[#"hash_74440ced95db880d"]) {
            var_3fb152a3 thread function_15399312();
        }
    }
}

// Namespace objective_manager/objective_manager
// Params 0, eflags: 0x5 linked
// Checksum 0xdc024d3, Offset: 0x2060
// Size: 0x5c
function private function_15399312() {
    v_org = self.origin;
    if (!isdefined(self.radius)) {
        n_radius = 2500;
    } else {
        n_radius = self.radius;
    }
    namespace_60c38ce9::function_e3a05cb9(v_org, n_radius);
}

// Namespace objective_manager/objective_manager
// Params 4, eflags: 0x0
// Checksum 0xd189a015, Offset: 0x20c8
// Size: 0x14c
function function_98da2ed1(var_c860e2f, str_alias, var_981bcebe, var_5850eaf2 = 4000000) {
    self notify("2ee709e951085f1b");
    self endon("2ee709e951085f1b");
    level flag::wait_till("all_players_spawned");
    while (true) {
        foreach (player in getplayers()) {
            if (distancesquared(player.origin, var_c860e2f) < var_5850eaf2) {
                level thread globallogic_audio::leader_dialog(str_alias);
                level thread globallogic_audio::leader_dialog(var_981bcebe);
                return;
            }
        }
        wait 1;
    }
}

// Namespace objective_manager/objective_manager
// Params 3, eflags: 0x5 linked
// Checksum 0x9348af0, Offset: 0x2220
// Size: 0x18e
function private function_8239a941(struct, instance, hintstring) {
    var_3be0acae = [];
    var_3be0acae = instance.var_fe2612fe[#"hash_310e58f653ae315d"];
    if (isdefined(var_3be0acae) && var_3be0acae.size > 0) {
        foreach (var_528a3a32 in var_3be0acae) {
            namespace_8b6a9d79::spawn_script_model(var_528a3a32, var_528a3a32.model, 1);
        }
    }
    scriptmodel = namespace_8b6a9d79::spawn_script_model(struct, #"tag_origin");
    trigger = namespace_8b6a9d79::function_214737c7(struct, &function_cec3c94c, hintstring);
    trigger.origin += (0, 0, 0);
    trigger.instance = instance;
    trigger.scriptmodel = scriptmodel;
    instance.var_4272a188 = trigger;
    return trigger;
}

// Namespace objective_manager/objective_manager
// Params 1, eflags: 0x5 linked
// Checksum 0x2b25d95e, Offset: 0x23b8
// Size: 0x54
function private function_cec3c94c(params) {
    if (!function_3e365c4f(self.instance, params.activator)) {
        return;
    }
    waittillframeend();
    self.instance.var_4272a188 = undefined;
    self delete();
}

// Namespace objective_manager/objective_manager
// Params 2, eflags: 0x5 linked
// Checksum 0x4c86ab69, Offset: 0x2418
// Size: 0x1c8
function private function_3e365c4f(instance, activator = undefined) {
    if (isdefined(level.var_7d45d0d4.activeobjective)) {
        return false;
    }
    level.var_7d45d0d4.activeobjective = instance;
    level flag::set("objective_locked");
    if (isdefined(instance.var_e55c8b4e)) {
        objective_delete(instance.var_e55c8b4e);
        instance.var_e55c8b4e = undefined;
    }
    function_654c5d3b();
    script = namespace_8b6a9d79::function_85255d0f(instance.content_script_name);
    level thread [[ script.var_11dcc37e ]](instance, activator);
    if (instance.content_script_name === #"holdout") {
        instance waittill(#"hash_4a46a299d2376baf");
    }
    level notify(#"hash_17028f0b9883e5be");
    level callback::callback(#"hash_17028f0b9883e5be", {#instance:instance, #activator:activator});
    level thread function_fa47c63e(script.scriptname);
    playsoundatposition(#"hash_56dca21276e6d29c", (0, 0, 0));
    return true;
}

// Namespace objective_manager/objective_manager
// Params 0, eflags: 0x0
// Checksum 0xa7316251, Offset: 0x25e8
// Size: 0xd8
function function_c4f169d6() {
    var_344a6a1a = level.var_7d45d0d4.var_1d9d92ba.var_344a6a1a;
    level.var_7d45d0d4.var_1d9d92ba = undefined;
    if (isdefined(var_344a6a1a)) {
        foreach (model in var_344a6a1a) {
            if (isdefined(model)) {
                model delete();
                util::wait_network_frame();
            }
        }
    }
}

// Namespace objective_manager/objective_manager
// Params 1, eflags: 0x4
// Checksum 0x54cd7ba, Offset: 0x26c8
// Size: 0x158
function private function_1e8b7f8(scriptmodel) {
    scriptmodel endon(#"death");
    toppos = scriptmodel.origin + (0, 0, 4);
    bottompos = scriptmodel.origin - (0, 0, 4);
    while (true) {
        scriptmodel moveto(toppos, 0.5, 0.15, 0.15);
        scriptmodel rotateyaw(scriptmodel.angles[2] + 45, 0.5);
        wait 0.5;
        scriptmodel moveto(bottompos, 0.5, 0.15, 0.15);
        scriptmodel rotateyaw(scriptmodel.angles[2] + 45, 0.5);
        wait 0.5;
    }
}

// Namespace objective_manager/objective_manager
// Params 1, eflags: 0x5 linked
// Checksum 0x68e26cce, Offset: 0x2828
// Size: 0x1da
function private function_4371154a(category) {
    switch (category) {
    case #"hash_3eb0da94cd242359":
        return #"hash_5d02b40da208412";
    case #"destroy":
        return #"hash_755c15de2052dbce";
    case #"defend":
        return #"hash_2e632d14a18ddc0";
    case #"hunt":
        return #"hash_59cd8f2a488c0201";
    case #"exfil":
        return #"hash_550113857d521cf0";
    case #"hash_235c12d261984c1d":
        return #"hash_20babce62e30408";
    case #"payload":
        return #"hash_6df9aea076cea4ba";
    case #"retrieval":
        return #"hash_449cd1c65196f3a8";
    case #"secure":
        return #"hash_2764807c1ab1eabd";
    case #"hash_401d37614277df42":
        return #"hash_46740dbc7cc40693";
    case #"hash_5077900a6875c57":
        return #"hash_7a9cda9e23193db2";
    case #"holdout":
        return #"hash_12475c4fdd2e51cb";
    }
    assert(0, "<dev string:x6e>" + function_9e72a96(category));
    return #"headicon_dead_wz";
}

// Namespace objective_manager/objective_manager
// Params 3, eflags: 0x5 linked
// Checksum 0x555dcfb0, Offset: 0x2a10
// Size: 0x64
function private function_9751c453(var_331b7cc3, origin, instance) {
    objid = gameobjects::get_next_obj_id();
    instance.var_e55c8b4e = objid;
    objective_add(objid, "active", origin, var_331b7cc3);
}

// Namespace objective_manager/objective_manager
// Params 0, eflags: 0x5 linked
// Checksum 0x1f37e5df, Offset: 0x2a80
// Size: 0x184
function private function_654c5d3b() {
    foreach (group in level.var_7d45d0d4.var_5eba96b3) {
        foreach (instance in group) {
            if (isdefined(instance.var_e55c8b4e)) {
                objective_setstate(instance.var_e55c8b4e, "invisible");
            }
            if (isdefined(instance.var_4272a188)) {
                instance.var_4272a188 triggerenable(0);
                if (isdefined(instance.var_4272a188.scriptmodel)) {
                    instance.var_4272a188.scriptmodel ghost();
                }
            }
        }
    }
}

// Namespace objective_manager/objective_manager
// Params 0, eflags: 0x5 linked
// Checksum 0x57073287, Offset: 0x2c10
// Size: 0x184
function private function_2fe379cd() {
    foreach (group in level.var_7d45d0d4.var_5eba96b3) {
        foreach (instance in group) {
            if (isdefined(instance.var_e55c8b4e)) {
                objective_setstate(instance.var_e55c8b4e, "active");
            }
            if (isdefined(instance.var_4272a188)) {
                instance.var_4272a188 triggerenable(1);
                if (isdefined(instance.var_4272a188.scriptmodel)) {
                    instance.var_4272a188.scriptmodel show();
                }
            }
        }
    }
}

// Namespace objective_manager/objective_manager
// Params 1, eflags: 0x5 linked
// Checksum 0x8bdb92d4, Offset: 0x2da0
// Size: 0x1d8
function private function_fa47c63e(scriptname) {
    var_5fc990bf = 0;
    if (isdefined(scriptname)) {
        switch (scriptname) {
        case #"exfil":
            var_5fc990bf = 4;
            break;
        case #"hash_3386f30228d9a983":
            var_5fc990bf = 2;
            break;
        case #"destroy":
            var_5fc990bf = 1;
            break;
        case #"hash_401d37614277df42":
            var_5fc990bf = 3;
            break;
        case #"hash_24a710d5fc2ed834":
            var_5fc990bf = 5;
            break;
        case #"payload":
            var_5fc990bf = 6;
            break;
        case #"retrieval":
            var_5fc990bf = 7;
            break;
        case #"secure":
            var_5fc990bf = 8;
            break;
        }
    }
    players = getplayers();
    foreach (player in players) {
        player luinotifyevent(#"hash_5159e35a62fb7083", 3, 0, var_5fc990bf, level.var_b48509f9);
    }
}

// Namespace objective_manager/objective_manager
// Params 0, eflags: 0x5 linked
// Checksum 0xef47ca5, Offset: 0x2f80
// Size: 0x24
function private function_dc7dedf9() {
    level thread function_fbb3a986(&prototype_hud::set_fanfare_visibility);
}

// Namespace objective_manager/objective_manager
// Params 0, eflags: 0x5 linked
// Checksum 0x5c3aac7c, Offset: 0x2fb0
// Size: 0x24
function private function_cad28879() {
    level thread function_fbb3a986(&prototype_hud::set_fail_fanfare_visibility);
}

// Namespace objective_manager/objective_manager
// Params 1, eflags: 0x5 linked
// Checksum 0xd2fd0764, Offset: 0x2fe0
// Size: 0x1a4
function private function_fbb3a986(var_aa7aeff5) {
    flag::wait_till_clear(#"hash_2bd443d05df202fe");
    flag::set(#"hash_2bd443d05df202fe");
    foreach (player in getplayers()) {
        level.var_31028c5d [[ var_aa7aeff5 ]](player, 1);
    }
    level waittilltimeout(6, #"game_ended");
    flag::clear(#"hash_2bd443d05df202fe");
    foreach (player in getplayers()) {
        level.var_31028c5d [[ var_aa7aeff5 ]](player, 0);
    }
}

// Namespace objective_manager/objective_manager
// Params 7, eflags: 0x0
// Checksum 0xd2ebb097, Offset: 0x3190
// Size: 0x190
function function_91574ec1(luielem_bar, xpos = 91, ypos = 420, n_width = 38, var_743c16e0, var_f00ef145 = 0, n_num) {
    if (isplayer(self)) {
        a_players = array(self);
    } else {
        a_players = getplayers();
    }
    foreach (player in a_players) {
        if (isdefined(n_num)) {
            player thread function_10ad6cbc(luielem_bar, xpos, ypos, n_width, var_743c16e0, var_f00ef145, n_num);
            continue;
        }
        player thread function_10ad6cbc(luielem_bar, xpos, ypos, n_width, var_743c16e0, var_f00ef145);
    }
}

// Namespace objective_manager/objective_manager
// Params 7, eflags: 0x5 linked
// Checksum 0x7e09f7fa, Offset: 0x3328
// Size: 0x314
function private function_10ad6cbc(luielem_bar, xpos = 91, ypos = 420, n_width = 38, var_743c16e0, var_f00ef145 = 0, n_num) {
    self endon(#"death");
    self thread function_8f481c50(var_743c16e0);
    if (isdefined(self.var_c088c2dd)) {
        self.var_c088c2dd luielembar::close(self);
        self.var_c088c2dd = undefined;
        waitframe(1);
    }
    if (isdefined(n_num)) {
        if (!isdefined(self.var_1948045d)) {
            self.var_1948045d = [];
        }
        self.var_1948045d[n_num] = luielem_bar;
        self.var_1948045d[n_num] luielembar::open(self);
        self.var_1948045d[n_num] luielembar::set_color(self, 0, 1, 0);
        self.var_1948045d[n_num] luielembar::set_alpha(self, 1);
        self.var_1948045d[n_num] luielembar::set_width(self, n_width);
        self.var_1948045d[n_num] luielembar::set_height(self, 4);
        self.var_1948045d[n_num] luielembar::function_f97e9049(self, xpos, ypos);
        self.var_1948045d[n_num] luielembar::set_bar_percent(self, var_f00ef145);
        return;
    }
    self.var_c088c2dd = luielem_bar;
    self.var_c088c2dd luielembar::open(self);
    self.var_c088c2dd luielembar::set_color(self, 0, 1, 0);
    self.var_c088c2dd luielembar::set_alpha(self, 1);
    self.var_c088c2dd luielembar::set_width(self, n_width);
    self.var_c088c2dd luielembar::set_height(self, 4);
    self.var_c088c2dd luielembar::function_f97e9049(self, xpos, ypos);
    self.var_c088c2dd luielembar::set_bar_percent(self, var_f00ef145);
}

// Namespace objective_manager/objective_manager
// Params 2, eflags: 0x0
// Checksum 0xe1247c78, Offset: 0x3648
// Size: 0x118
function function_5d1c184(n_frac, n_num) {
    if (isplayer(self)) {
        a_players = array(self);
    } else {
        a_players = getplayers();
    }
    foreach (player in a_players) {
        if (isdefined(player)) {
            if (isdefined(n_num)) {
                player thread function_b4cb0c5c(n_frac, n_num);
                continue;
            }
            player thread function_b4cb0c5c(n_frac);
        }
    }
}

// Namespace objective_manager/objective_manager
// Params 2, eflags: 0x5 linked
// Checksum 0xfa9fd0ea, Offset: 0x3768
// Size: 0x16e
function private function_b4cb0c5c(n_frac, n_num) {
    if (isdefined(n_num) && isdefined(self.var_1948045d)) {
        self.var_1948045d[n_num] luielembar::set_bar_percent(self, n_frac);
        return;
    }
    if (isdefined(self.var_c088c2dd) && isdefined(self.var_c088c2dd)) {
        self.var_c088c2dd luielembar::set_bar_percent(self, n_frac);
        if (n_frac <= 0.66 && n_frac > 0.33 && !is_true(self.var_c088c2dd.var_b2ad28ef)) {
            self.var_c088c2dd luielembar::set_color(self, 1, 1, 0);
            self.var_c088c2dd.var_b2ad28ef = 1;
            return;
        }
        if (n_frac <= 0.33 && !is_true(self.var_c088c2dd.var_38ae4622)) {
            self.var_c088c2dd luielembar::set_color(self, 1, 0, 0);
            self.var_c088c2dd.var_38ae4622 = 1;
        }
    }
}

// Namespace objective_manager/objective_manager
// Params 1, eflags: 0x1 linked
// Checksum 0x371c787e, Offset: 0x38e0
// Size: 0x14e
function function_8f481c50(var_743c16e0) {
    self notify("6b3ccf815cad4867");
    self endon("6b3ccf815cad4867");
    if (isdefined(var_743c16e0)) {
        level waittill(var_743c16e0);
    }
    if (isdefined(self) && isdefined(self.var_c088c2dd) && self.var_c088c2dd luielembar::is_open(self)) {
        self.var_c088c2dd luielembar::close(self);
        self.var_c088c2dd = undefined;
    }
    if (isdefined(self) && isdefined(self.var_1948045d)) {
        for (i = 0; i < 3; i++) {
            if (isdefined(self.var_1948045d[i]) && self.var_1948045d[i] luielembar::is_open(self)) {
                self.var_1948045d[i] luielembar::close(self);
                self.var_1948045d[i] = undefined;
            }
        }
        self.var_1948045d = undefined;
    }
}

// Namespace objective_manager/objective_manager
// Params 2, eflags: 0x1 linked
// Checksum 0xc25bbc2, Offset: 0x3a38
// Size: 0x194
function start_timer(n_seconds, str_label = #"") {
    level endon(#"game_ended", #"timer_stop");
    assert(n_seconds <= 540);
    foreach (player in getplayers()) {
        player clientfield::set_to_player("sr_defend_timer", 0);
        if (!level.var_4f12f6d0 sr_objective_timer::is_open(player)) {
            level.var_4f12f6d0 sr_objective_timer::open(player, 0);
        }
        player clientfield::set_to_player("sr_defend_timer", n_seconds);
    }
    wait n_seconds;
    level notify("timer_" + str_label);
    stop_timer();
}

// Namespace objective_manager/objective_manager
// Params 2, eflags: 0x0
// Checksum 0x7c42b2da, Offset: 0x3bd8
// Size: 0x12c
function function_b8278876(n_seconds, str_label = #"") {
    level endon(#"game_ended", #"timer_stop");
    self endon(#"death");
    assert(n_seconds <= 540);
    self clientfield::set_to_player("sr_defend_timer", 0);
    if (!level.var_4f12f6d0 sr_objective_timer::is_open(self)) {
        level.var_4f12f6d0 sr_objective_timer::open(self, 0);
    }
    self clientfield::set_to_player("sr_defend_timer", n_seconds);
    wait n_seconds;
    self notify("timer_" + str_label);
    stop_timer();
}

// Namespace objective_manager/objective_manager
// Params 0, eflags: 0x1 linked
// Checksum 0x9a8277d, Offset: 0x3d10
// Size: 0x108
function stop_timer() {
    foreach (player in getplayers()) {
        if (level.var_4f12f6d0 sr_objective_timer::is_open(player)) {
            level.var_4f12f6d0 sr_objective_timer::close(player);
        }
        player clientfield::set_to_player("sr_defend_timer", 0);
    }
    level notify(#"hash_5a7f014b541eb7a6");
    level notify(#"timer_stop");
}

// Namespace objective_manager/objective_manager
// Params 0, eflags: 0x1 linked
// Checksum 0x3a271c9f, Offset: 0x3e20
// Size: 0xe
function function_7bfeebe3() {
    return level.var_cf558bf;
}

// Namespace objective_manager/objective_manager
// Params 1, eflags: 0x0
// Checksum 0x4f790b2f, Offset: 0x3e38
// Size: 0x27a
function function_aece4588(var_3afe334f) {
    switch (var_3afe334f) {
    case 0:
    case 1:
        var_de82b392 = [#"hash_7cba8a05511ceedf"];
        break;
    case 2:
        var_de82b392 = [#"hash_7cba8a05511ceedf", #"hash_7cba8a05511ceedf", #"hash_7cba8a05511ceedf", #"hash_338eb4103e0ed797", #"hash_338eb4103e0ed797"];
        break;
    case 3:
        var_de82b392 = [#"hash_7cba8a05511ceedf", #"hash_7cba8a05511ceedf", #"hash_7cba8a05511ceedf", #"hash_338eb4103e0ed797", #"hash_338eb4103e0ed797", #"hash_46c917a1b5ed91e7"];
        break;
    default:
        var_de82b392 = [#"hash_7cba8a05511ceedf", #"hash_7cba8a05511ceedf", #"hash_7cba8a05511ceedf", #"hash_338eb4103e0ed797", #"hash_338eb4103e0ed797", #"hash_46c917a1b5ed91e7", #"hash_46c917a1b5ed91e7"];
        break;
    }
    var_7ecdee63 = array::random(var_de82b392);
    return var_7ecdee63;
}

// Namespace objective_manager/objective_manager
// Params 1, eflags: 0x1 linked
// Checksum 0x104c7ec8, Offset: 0x40c0
// Size: 0x100
function function_9d4e6125(scriptname) {
    wait 5;
    var_5fc990bf = 0;
    if (isdefined(scriptname)) {
        var_5fc990bf = function_ae039b4(scriptname);
    } else {
        return;
    }
    players = getplayers();
    foreach (player in players) {
        player luinotifyevent(#"hash_5159e35a62fb7083", 3, 2, var_5fc990bf, level.var_b48509f9);
    }
}

// Namespace objective_manager/objective_manager
// Params 1, eflags: 0x1 linked
// Checksum 0x1fdf2d17, Offset: 0x41c8
// Size: 0x12e
function function_ae039b4(objective) {
    var_5fc990bf = 0;
    switch (objective) {
    case #"exfil":
        var_5fc990bf = 4;
        break;
    case #"hash_3386f30228d9a983":
        var_5fc990bf = 2;
        break;
    case #"destroy":
        var_5fc990bf = 1;
        break;
    case #"hash_401d37614277df42":
        var_5fc990bf = 3;
        break;
    case #"hash_24a710d5fc2ed834":
        var_5fc990bf = 5;
        break;
    case #"payload":
        var_5fc990bf = 6;
        break;
    case #"retrieval":
        var_5fc990bf = 7;
        break;
    case #"secure":
        var_5fc990bf = 8;
        break;
    case #"hash_5077900a6875c57":
        var_5fc990bf = 9;
        break;
    }
    return var_5fc990bf;
}

// Namespace objective_manager/objective_manager
// Params 0, eflags: 0x1 linked
// Checksum 0xa73565a0, Offset: 0x4300
// Size: 0x108
function function_2f9d355c() {
    foreach (e_player in getplayers()) {
        if (e_player inlaststand()) {
            e_player zm_laststand::revive_force_revive();
            e_player notify(#"player_revived", {#reviver:self});
            continue;
        }
        if (e_player util::is_spectating()) {
            e_player thread zm_player::spectator_respawn_player();
        }
    }
}

/#

    // Namespace objective_manager/objective_manager
    // Params 0, eflags: 0x0
    // Checksum 0x3b13a0b1, Offset: 0x4410
    // Size: 0x2b4
    function init_devgui() {
        util::waittill_can_add_debug_command();
        level thread function_7a7ab1a2();
        adddebugcommand("<dev string:x8e>");
        util::add_devgui(namespace_8b6a9d79::devgui_path("<dev string:xb6>", 100), "<dev string:xd9>");
        adddebugcommand("<dev string:xfd>");
        util::add_devgui(namespace_8b6a9d79::devgui_path("<dev string:x125>", 101), "<dev string:x148>");
        adddebugcommand("<dev string:x16c>");
        util::add_devgui(namespace_8b6a9d79::devgui_path("<dev string:x193>", 102), "<dev string:x1ad>");
        adddebugcommand("<dev string:x1d0>");
        util::add_devgui(namespace_8b6a9d79::devgui_path("<dev string:x1f8>", 102), "<dev string:x216>");
        adddebugcommand("<dev string:x23a>");
        util::add_devgui(namespace_8b6a9d79::devgui_path("<dev string:x25e>", 102), "<dev string:x278>");
        setdvar(#"hash_5ec9d9c47f22480b", 0);
        adddebugcommand("<dev string:x298>");
        util::add_devgui(namespace_8b6a9d79::devgui_path("<dev string:x2c6>", 103), "<dev string:x2e9>");
        function_cd140ee9(#"hash_5ec9d9c47f22480b", &function_a8417c4a);
        adddebugcommand("<dev string:x313>");
        util::add_devgui(namespace_8b6a9d79::devgui_path("<dev string:x33e>", 104), "<dev string:x357>");
    }

    // Namespace objective_manager/objective_manager
    // Params 1, eflags: 0x0
    // Checksum 0x4b7888ac, Offset: 0x46d0
    // Size: 0x50
    function function_a8417c4a(params) {
        if (params.value) {
            level thread function_67b313bb();
            return;
        }
        level notify(#"hash_473116b92ba013b9");
    }

    // Namespace objective_manager/objective_manager
    // Params 0, eflags: 0x0
    // Checksum 0x7c8a16b9, Offset: 0x4728
    // Size: 0x3c2
    function function_67b313bb() {
        level notify(#"hash_473116b92ba013b9");
        level endon(#"hash_473116b92ba013b9");
        var_b49d430f = array("<dev string:x37e>", "<dev string:x38a>", "<dev string:x39c>", "<dev string:x3a7>", "<dev string:x3b9>", "<dev string:x3c6>", "<dev string:x3d2>", "<dev string:x3dc>", "<dev string:x3e5>", "<dev string:x3f5>", "<dev string:x408>");
        var_9986d9d6 = array((1, 0, 0), (0, 1, 0), (0, 0, 1), (1, 1, 0), (1, 0.5, 0), (0, 1, 1), (1, 0, 1), (0.439216, 0.501961, 0.564706), (0, 0, 0), (0.501961, 0.501961, 0), (0.545098, 0.270588, 0.0745098));
        while (true) {
            foreach (index, var_83aaaa47 in var_b49d430f) {
                v_color = var_9986d9d6[index];
                var_2cd4e005 = struct::get_array(var_83aaaa47, "<dev string:x418>");
                foreach (s_objective in var_2cd4e005) {
                    print3d(s_objective.origin, "<dev string:x42f>" + var_83aaaa47 + "<dev string:x440>" + (isdefined(s_objective.targetname) ? s_objective.targetname : "<dev string:x451>"), (1, 1, 0), undefined, 1);
                    n_distance = distance(getplayers()[0].origin, s_objective.origin);
                    var_5d97a083 = 150 * n_distance * 0.0001;
                    var_5d97a083 = max(150 / 1.5, var_5d97a083);
                    sphere(s_objective.origin, var_5d97a083, v_color);
                }
                debug2dtext((100, 500 + 25 * index, 0), var_83aaaa47 + "<dev string:x464>" + var_2cd4e005.size + "<dev string:x469>", v_color, undefined, undefined, undefined, 1.5);
            }
            waitframe(1);
        }
    }

    // Namespace objective_manager/objective_manager
    // Params 1, eflags: 0x0
    // Checksum 0x8c0a979b, Offset: 0x4af8
    // Size: 0x2c
    function function_caba1575(instance) {
        self setorigin(instance.origin);
    }

    // Namespace objective_manager/objective_manager
    // Params 0, eflags: 0x0
    // Checksum 0xd76ad82b, Offset: 0x4b30
    // Size: 0x47c
    function function_7a7ab1a2() {
        while (true) {
            if (getdvarint(#"hash_f6faed38fbaaaa5", 0)) {
                level.var_cf558bf++;
                namespace_553954de::function_7c97e961(level.var_b48509f9 + 1);
                setdvar(#"hash_f6faed38fbaaaa5", 0);
                foreach (player in getplayers()) {
                    player luinotifyevent(#"hash_5b1ff06d07e9002a", 3, 2, level.var_b48509f9, 0);
                }
            }
            if (getdvarint(#"hash_7c2f98129d7c2219", 0)) {
                level.var_cf558bf--;
                namespace_553954de::function_7c97e961(level.var_b48509f9 - 1);
                setdvar(#"hash_7c2f98129d7c2219", 0);
                foreach (player in getplayers()) {
                    player luinotifyevent(#"hash_5b1ff06d07e9002a", 3, 2, level.var_b48509f9, 0);
                }
            }
            if (getdvarint(#"hash_6b5cf36b6de48f0a", 0)) {
                setdvar(#"hash_6b5cf36b6de48f0a", 0);
                if (isdefined(level.var_7d45d0d4.activeobjective)) {
                    objective_ended(level.var_7d45d0d4.activeobjective, 1);
                }
            } else if (getdvarint(#"hash_41c8b0af55de9e31", 0)) {
                setdvar(#"hash_41c8b0af55de9e31", 0);
                if (isdefined(level.var_7d45d0d4.activeobjective)) {
                    objective_ended(level.var_7d45d0d4.activeobjective, 0);
                }
            }
            if (getdvarint(#"hash_56fb5b3dc9a94fb6", 0)) {
                setdvar(#"hash_56fb5b3dc9a94fb6", 0);
                instance = level.var_7d45d0d4.activeobjective;
                if (!isdefined(instance)) {
                    instance = level.var_d56035;
                }
                if (isdefined(instance)) {
                    foreach (player in getplayers()) {
                        player function_caba1575(instance);
                    }
                }
            }
            wait 0.1;
        }
    }

#/
