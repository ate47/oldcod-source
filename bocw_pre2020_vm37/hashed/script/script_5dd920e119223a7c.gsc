#using script_1029986e2bc8ca8e;
#using script_113dd7f0ea2a1d4f;
#using script_12538a87a80a2978;
#using script_1cc417743d7c262d;
#using script_27347f09888ad15;
#using script_3357acf79ce92f4b;
#using script_3411bb48d41bd3b;
#using script_5a0c35b811c39bea;
#using script_7c3f86aa290a6354;
#using scripts\core_common\ai\systems\gib;
#using scripts\core_common\animation_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\gameobjects_shared;
#using scripts\core_common\laststand_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\zm_common\zm_score;

#namespace namespace_662ff671;

// Namespace namespace_662ff671/level_init
// Params 1, eflags: 0x40
// Checksum 0xb97a5ee8, Offset: 0x578
// Size: 0x13c
function event_handler[level_init] main(*eventstruct) {
    clientfield::register("actor", "" + #"hash_74382f598f4de051", 1, getminbitcountfornum(4), "counter");
    clientfield::register("actor", "" + #"hash_b74182bd1e44a44", 1, 1, "int");
    clientfield::register("actor", "" + #"hash_435db79c304e12a5", 1, 1, "counter");
    objective_manager::function_b3464a7c(#"kill_hvt", &spawn_func, &start_callback, #"hunt", #"hash_5a76d5e2fa7e03c0");
}

// Namespace namespace_662ff671/namespace_662ff671
// Params 1, eflags: 0x4
// Checksum 0xf5bcee62, Offset: 0x6c0
// Size: 0x22c
function private spawn_func(s_instance) {
    var_3afe334f = level.var_b48509f9;
    n_players = function_a1ef346b().size;
    n_count_total = 0;
    foreach (var_109708e0 in isdefined(s_instance.var_fe2612fe[#"hvt"]) ? s_instance.var_fe2612fe[#"hvt"] : []) {
        n_count = int(isdefined(var_109708e0.count) ? var_109708e0.count : 1);
        if (var_109708e0.ai_type === "raz" && var_3afe334f > 1 && n_players >= 3) {
            n_count++;
        }
        n_count_total += n_count;
        if (var_109708e0.ai_type === "raz") {
            level.var_971bd29a = 1;
            continue;
        }
        level.var_971bd29a = 0;
    }
    if (n_count_total > 1) {
        level thread objective_manager::function_98da2ed1(s_instance.var_4272a188.origin, "objectiveKillHVTsApproach");
    } else {
        level thread objective_manager::function_98da2ed1(s_instance.var_4272a188.origin, "objectiveKillHVTApproach");
    }
    function_86a476ea(s_instance);
}

// Namespace namespace_662ff671/namespace_662ff671
// Params 1, eflags: 0x0
// Checksum 0x5af3ca70, Offset: 0x8f8
// Size: 0xca
function function_86a476ea(s_instance) {
    s_instance.var_72e31bf2 = #"objective_hvt_flood_ailist_1";
    s_instance.var_3579a11c = #"objective_hvt_flood_ailist_2";
    s_instance.var_6427fe78 = #"objective_hvt_flood_ailist_3";
    s_instance.var_9903e833 = #"objective_hvt_flood_ailist_4";
    s_instance.var_fa4b6d81 = #"objective_hvt_zombie_ailist_1";
    s_instance.var_dba43033 = #"objective_hvt_zombie_ailist_2";
    s_instance.var_d1371b59 = #"objective_hvt_zombie_ailist_3";
    s_instance.var_43897ffc = #"objective_hvt_zombie_ailist_4";
}

// Namespace namespace_662ff671/namespace_662ff671
// Params 2, eflags: 0x4
// Checksum 0x8e4589cc, Offset: 0x9d0
// Size: 0x748
function private start_callback(instance, activator) {
    foreach (model in instance.var_344a6a1a) {
        if (model.model === #"hash_5214487a660b06b9") {
            var_2972bc14 = model;
        }
    }
    if (isdefined(var_2972bc14)) {
        wait 1;
        var_2972bc14 rotateyaw(60, 3);
        var_2972bc14 waittill(#"rotatedone");
    }
    instance.a_ai_spawned = [];
    instance.a_ai_raz = [];
    instance.var_bcd37ed4 = [];
    instance.var_9fcaacff = 0;
    instance.var_4675adc1 = 0;
    instance.var_894bb3c9 = 0;
    instance.var_5ba1d698 = 0;
    instance.var_c42980f6 = 0;
    n_players = function_a1ef346b().size;
    foreach (var_109708e0 in isdefined(instance.var_fe2612fe[#"hvt"]) ? instance.var_fe2612fe[#"hvt"] : []) {
        instance.var_c42980f6++;
        var_109708e0.count = int(isdefined(var_109708e0.count) ? var_109708e0.count : 1);
        if (!is_true(instance.var_9ef060ec) && var_109708e0.ai_type === "raz" && level.var_b48509f9 > 1 && n_players >= 3) {
            var_109708e0.count++;
        }
        if (var_109708e0.ai_type === "avogadro") {
            var_109708e0.count *= 3;
        }
        instance.var_894bb3c9 += var_109708e0.count;
        var_109708e0 thread function_92f52c04(instance, activator);
    }
    if (instance.var_894bb3c9 > 1) {
        activator thread util::delay(2.5, "death", &globallogic_audio::leader_dialog_on_player, "objectiveKillHVTsStart");
    } else {
        activator thread util::delay(2.5, "death", &globallogic_audio::leader_dialog_on_player, "objectiveKillHVTStart");
    }
    level thread function_fa7f10a(instance);
    foreach (var_a1042f77 in isdefined(instance.var_fe2612fe[#"hash_203a7ea942db54bb"]) ? instance.var_fe2612fe[#"hash_203a7ea942db54bb"] : []) {
        var_a1042f77 thread function_4b4ffd20(instance, activator);
    }
    foreach (var_43bd42d in isdefined(instance.var_fe2612fe[#"hash_c12641cffad619b"]) ? instance.var_fe2612fe[#"hash_c12641cffad619b"] : []) {
        var_43bd42d thread function_3eef9ba0(instance);
    }
    if (is_true(instance.var_f1a13487)) {
        level thread function_daf7835b(instance);
    }
    s_waitresult = instance waittill(#"complete", #"failed", #"objective_ended");
    if (s_waitresult._notify != #"objective_ended") {
        b_success = 1;
        if (s_waitresult._notify == "failed") {
            b_success = 0;
        }
        objective_manager::objective_ended(instance, b_success);
    }
    instance flag::set("complete");
    function_1eaaceab(instance.a_ai_spawned);
    foreach (ai_spawned in instance.a_ai_spawned) {
        if (is_true(ai_spawned.var_e3238e2b)) {
            ai_spawned val::reset("intro_avogadro_allowdeath", "allowdeath");
            ai_spawned val::reset("intro_avogadro_takedamage", "takedamage");
        }
        ai_spawned thread function_d38842d3();
    }
}

// Namespace namespace_662ff671/namespace_662ff671
// Params 1, eflags: 0x4
// Checksum 0x11fd9a4c, Offset: 0x1120
// Size: 0x2b8
function private function_fa7f10a(s_instance) {
    foreach (player in getplayers()) {
        level.var_31028c5d prototype_hud::function_7491d6c5(player, #"hash_36989b23ebea2980");
    }
    s_instance waittilltimeout(5, #"complete");
    if (!s_instance flag::get("complete")) {
        foreach (e_player in getplayers()) {
            level.var_31028c5d prototype_hud::set_active_objective_string(e_player, #"hash_36989b23ebea2980");
            level.var_31028c5d prototype_hud::function_817e4d10(e_player, 1);
        }
        objective_manager::function_9f6de950(s_instance.var_894bb3c9);
        s_instance flag::wait_till("complete");
    }
    foreach (e_player in getplayers()) {
        level.var_31028c5d prototype_hud::function_7491d6c5(e_player, #"");
        level.var_31028c5d prototype_hud::set_active_objective_string(e_player, #"");
        level.var_31028c5d prototype_hud::function_817e4d10(e_player, 0);
    }
}

// Namespace namespace_662ff671/namespace_662ff671
// Params 0, eflags: 0x4
// Checksum 0x6d211bf3, Offset: 0x13e0
// Size: 0x96
function private function_5ad6340d() {
    self notify("3b65b66901a98675");
    self endon("3b65b66901a98675");
    self endon(#"stop_timer");
    n_time = 300;
    /#
        if (getdvarint(#"hash_69bc53d159fd305c", 0) > 0) {
            n_time = 10;
        }
    #/
    objective_manager::start_timer(n_time);
    self notify(#"failed");
}

// Namespace namespace_662ff671/namespace_662ff671
// Params 2, eflags: 0x4
// Checksum 0x7587516d, Offset: 0x1480
// Size: 0xc30
function private function_4b4ffd20(s_instance, e_activator) {
    s_instance endon(#"complete");
    self endon(#"death");
    var_b35d8ad0 = float(isdefined(self.var_2fd49ac3) ? self.var_2fd49ac3 : 1);
    n_roll = randomfloat(1);
    if (n_roll > var_b35d8ad0) {
        return;
    }
    if (!is_true(self.blocking)) {
        foreach (var_a1042f77 in isdefined(self.var_fe2612fe[#"hash_203a7ea942db54bb"]) ? self.var_fe2612fe[#"hash_203a7ea942db54bb"] : []) {
            var_a1042f77 thread function_4b4ffd20(s_instance, e_activator);
        }
    }
    if (isdefined(self.wait_for_flag) && self.wait_for_flag != "") {
        level flag::wait_till(self.wait_for_flag);
    } else {
        var_3d5ea915 = isdefined(self.var_fe2612fe[#"hash_15796c0d1beb39c3"]) ? self.var_fe2612fe[#"hash_15796c0d1beb39c3"] : [];
        if (var_3d5ea915.size > 0) {
            self function_bb9468f8(var_3d5ea915);
        }
    }
    foreach (var_43bd42d in isdefined(self.var_fe2612fe[#"hash_c12641cffad619b"]) ? self.var_fe2612fe[#"hash_c12641cffad619b"] : []) {
        var_43bd42d thread function_3eef9ba0(s_instance);
    }
    a_s_spawns = arraycopy(isdefined(self.var_fe2612fe[#"spawn"]) ? self.var_fe2612fe[#"spawn"] : []);
    a_s_spawns = array::randomize(a_s_spawns);
    if (a_s_spawns.size > 0) {
        n_players = function_a1ef346b().size;
        if (n_players <= 2) {
            n_size = 10;
        } else if (n_players <= 4) {
            n_size = 16;
        } else {
            n_size = 12;
        }
        if (is_true(self.half)) {
            n_size = int(n_size / 2);
        }
        a_ai = [];
        var_e905c444 = isdefined(self.var_fe2612fe[#"hash_46c4b051187d03ee"]) ? self.var_fe2612fe[#"hash_46c4b051187d03ee"] : [];
        var_ff81609a = var_e905c444.size <= 0;
        for (i = 0; i < n_size; i++) {
            if (a_s_spawns.size <= 0) {
                a_s_spawns = arraycopy(isdefined(self.var_fe2612fe[#"spawn"]) ? self.var_fe2612fe[#"spawn"] : []);
                a_s_spawns = array::randomize(a_s_spawns);
            }
            s_spawn = a_s_spawns[0];
            arrayremoveindex(a_s_spawns, 0);
            var_d7cf1504 = isdefined(self.var_4c92b2ac) ? self.var_4c92b2ac : "";
            var_d7cf1504 = strtok(var_d7cf1504, ", ");
            var_865d8aac = [];
            foreach (var_929141c6 in var_d7cf1504) {
                var_7ecdee63 = get_spawner(var_929141c6);
                if (!isdefined(var_865d8aac)) {
                    var_865d8aac = [];
                } else if (!isarray(var_865d8aac)) {
                    var_865d8aac = array(var_865d8aac);
                }
                var_865d8aac[var_865d8aac.size] = var_7ecdee63;
            }
            var_82706add = function_4674880c(s_instance);
            ai = s_spawn function_41f7333b(var_82706add, (0, randomfloat(360), 0));
            if (!isdefined(s_instance.a_ai_spawned)) {
                s_instance.a_ai_spawned = [];
            } else if (!isarray(s_instance.a_ai_spawned)) {
                s_instance.a_ai_spawned = array(s_instance.a_ai_spawned);
            }
            s_instance.a_ai_spawned[s_instance.a_ai_spawned.size] = ai;
            if (!isdefined(a_ai)) {
                a_ai = [];
            } else if (!isarray(a_ai)) {
                a_ai = array(a_ai);
            }
            a_ai[a_ai.size] = ai;
            if (var_ff81609a) {
                if (is_true(self.var_9d2375f4)) {
                    ai thread function_a810bd2f();
                }
                if (is_true(self.var_6337858d)) {
                    ai.var_12ec333b = 1;
                    ai callback::function_d8abfc3d(#"hash_4afe635f36531659", &function_b42b5f72);
                }
            }
            if (i + 1 < n_size) {
                util::wait_network_frame();
            }
        }
        if (!var_ff81609a) {
            var_e905c444 = isdefined(self.var_fe2612fe[#"hash_46c4b051187d03ee"]) ? self.var_fe2612fe[#"hash_46c4b051187d03ee"] : [];
            if (var_e905c444.size > 0) {
                function_1eaaceab(a_ai, 1);
                foreach (ai in a_ai) {
                    ai thread function_83c20994(self);
                }
                self function_bb9468f8(var_e905c444);
            }
            if (isdefined(self.var_cac36ea9) && self.var_cac36ea9 != "") {
                level flag::set(self.var_cac36ea9);
            }
            function_1eaaceab(a_ai, 1);
            if (is_true(self.var_9d2375f4)) {
                foreach (ai in a_ai) {
                    ai thread function_a810bd2f();
                }
            }
            if (is_true(self.var_6337858d)) {
                foreach (ai in a_ai) {
                    ai.var_12ec333b = 1;
                    ai callback::function_d8abfc3d(#"hash_4afe635f36531659", &function_b42b5f72);
                }
            }
        }
        if (is_true(self.blocking)) {
            n_limit = int(n_size / 5);
            while (a_ai.size > n_limit) {
                function_1eaaceab(a_ai);
                waitframe(1);
            }
        }
    }
    if (is_true(self.blocking)) {
        foreach (var_a1042f77 in isdefined(self.var_fe2612fe[#"hash_203a7ea942db54bb"]) ? self.var_fe2612fe[#"hash_203a7ea942db54bb"] : []) {
            var_a1042f77 thread function_4b4ffd20(s_instance, e_activator);
        }
    }
}

// Namespace namespace_662ff671/namespace_662ff671
// Params 4, eflags: 0x4
// Checksum 0xd78a9a79, Offset: 0x20b8
// Size: 0x6b4
function private function_cf54aadd(var_1f73a372, var_f5064815, s_instance, *var_e905c444) {
    var_e905c444 endon(#"complete");
    var_f5064815 endon(#"death");
    switch (function_a1ef346b().size) {
    case 1:
    default:
        if (s_instance.var_1f73a372.aitype === #"hash_60d7855358ceb53d") {
            n_to_spawn = 12;
        } else if (s_instance.var_1f73a372.aitype === #"hash_acac3fe7a341329") {
            n_to_spawn = 12;
        } else {
            n_to_spawn = 15;
        }
        break;
    case 2:
    case 3:
        if (s_instance.var_1f73a372.aitype === #"hash_60d7855358ceb53d") {
            n_to_spawn = 16;
        } else if (s_instance.var_1f73a372.aitype === #"hash_acac3fe7a341329") {
            n_to_spawn = 16;
        } else {
            n_to_spawn = 20;
        }
        break;
    case 4:
        if (s_instance.var_1f73a372.aitype === #"hash_60d7855358ceb53d") {
            n_to_spawn = 22;
        } else if (s_instance.var_1f73a372.aitype === #"hash_acac3fe7a341329") {
            n_to_spawn = 22;
        } else {
            n_to_spawn = 25;
        }
        break;
    }
    self.radius = float(self.radius);
    self.spawn_points = [];
    self.var_9b178666 = self.radius;
    self.var_48d0f926 = 64;
    self.var_783fc5e = 64;
    self.spawn_points = namespace_85745671::function_e4791424(self.origin, self.var_783fc5e, self.var_48d0f926, self.var_9b178666, int(self.var_9b178666 * 0.5), 0);
    var_2eb61c8a = arraycopy(self.spawn_points);
    var_2eb61c8a = array::randomize(var_2eb61c8a);
    var_d7cf1504 = isdefined(self.var_4c92b2ac) ? self.var_4c92b2ac : "";
    var_d7cf1504 = strtok(var_d7cf1504, ", ");
    var_865d8aac = [];
    foreach (var_929141c6 in var_d7cf1504) {
        var_7ecdee63 = get_spawner(var_929141c6);
        if (!isdefined(var_865d8aac)) {
            var_865d8aac = [];
        } else if (!isarray(var_865d8aac)) {
            var_865d8aac = array(var_865d8aac);
        }
        var_865d8aac[var_865d8aac.size] = var_7ecdee63;
    }
    var_f5064815 waittill(#"attack");
    for (i = 0; i < n_to_spawn; i++) {
        if (var_2eb61c8a.size <= 0) {
            var_2eb61c8a = arraycopy(self.spawn_points);
            var_2eb61c8a = array::randomize(var_2eb61c8a);
        }
        v_spawn = var_2eb61c8a[0];
        arrayremoveindex(var_2eb61c8a, 0);
        v_spawn = v_spawn.origin;
        var_82706add = function_4674880c(var_e905c444);
        var_900d7dee = spawn_ai(var_82706add, v_spawn, (0, randomfloat(360), 0));
        if (isdefined(var_900d7dee)) {
            if (!isdefined(var_e905c444.a_ai_spawned)) {
                var_e905c444.a_ai_spawned = [];
            } else if (!isarray(var_e905c444.a_ai_spawned)) {
                var_e905c444.a_ai_spawned = array(var_e905c444.a_ai_spawned);
            }
            var_e905c444.a_ai_spawned[var_e905c444.a_ai_spawned.size] = var_900d7dee;
            if (!isdefined(s_instance.a_ai_spawned)) {
                s_instance.a_ai_spawned = [];
            } else if (!isarray(s_instance.a_ai_spawned)) {
                s_instance.a_ai_spawned = array(s_instance.a_ai_spawned);
            }
            s_instance.a_ai_spawned[s_instance.a_ai_spawned.size] = var_900d7dee;
            var_900d7dee.wander_radius = self.radius;
            if (var_e905c444.targetname === "kill_hvt_golova_steiner" && self.script_string === "rusher") {
                var_900d7dee thread function_a810bd2f();
            }
        }
        if (i + 1 < n_to_spawn) {
            util::wait_network_frame();
        }
    }
}

// Namespace namespace_662ff671/namespace_662ff671
// Params 0, eflags: 0x0
// Checksum 0xa1cd6932, Offset: 0x2778
// Size: 0x24
function function_fd68cae4() {
    self namespace_85745671::function_9758722("sprint");
}

// Namespace namespace_662ff671/namespace_662ff671
// Params 2, eflags: 0x0
// Checksum 0x74a0c43f, Offset: 0x27a8
// Size: 0x64
function function_bf606a73(var_f5064815, var_e905c444) {
    self endon(#"death");
    if (var_e905c444.size > 0) {
        var_f5064815 function_bb9468f8(var_e905c444);
        self thread function_a810bd2f();
    }
}

// Namespace namespace_662ff671/namespace_662ff671
// Params 4, eflags: 0x0
// Checksum 0xbfea3b6d, Offset: 0x2818
// Size: 0x1ec
function zombie_death_watcher(var_a1042f77, s_instance, var_f5064815, var_82706add) {
    self waittill(#"death");
    var_9e3d8264 = namespace_85745671::function_e4791424(var_a1042f77.origin, 8, 100, 300, undefined, 0);
    var_900d7dee = spawn_ai(var_82706add, array::random(var_9e3d8264).origin, (0, randomfloat(360), 0));
    if (isdefined(var_900d7dee)) {
        if (!isdefined(s_instance.a_ai_spawned)) {
            s_instance.a_ai_spawned = [];
        } else if (!isarray(s_instance.a_ai_spawned)) {
            s_instance.a_ai_spawned = array(s_instance.a_ai_spawned);
        }
        s_instance.a_ai_spawned[s_instance.a_ai_spawned.size] = var_900d7dee;
        if (!isdefined(var_f5064815.a_ai_spawned)) {
            var_f5064815.a_ai_spawned = [];
        } else if (!isarray(var_f5064815.a_ai_spawned)) {
            var_f5064815.a_ai_spawned = array(var_f5064815.a_ai_spawned);
        }
        var_f5064815.a_ai_spawned[var_f5064815.a_ai_spawned.size] = var_900d7dee;
        var_900d7dee callback::function_d8abfc3d(#"hash_4afe635f36531659", &function_fd68cae4);
    }
}

// Namespace namespace_662ff671/namespace_662ff671
// Params 3, eflags: 0x4
// Checksum 0x823c575c, Offset: 0x2a10
// Size: 0x5c0
function private function_dd27cb14(var_1f73a372, var_f5064815, s_instance) {
    self endon(#"hash_316bee96eded77ba");
    var_1f73a372 endon(#"death");
    s_instance endon(#"complete");
    self.n_spawned = 0;
    while (true) {
        switch (function_a1ef346b().size) {
        case 1:
        default:
            var_a87aeae6 = 3;
            break;
        case 2:
            var_a87aeae6 = 5;
            break;
        case 3:
            var_a87aeae6 = 7;
            break;
        case 4:
            var_a87aeae6 = 9;
            break;
        }
        n_to_spawn = var_a87aeae6;
        function_1eaaceab(var_f5064815.var_f186cef3);
        while (n_to_spawn > 0 && n_to_spawn + var_f5064815.var_f186cef3.size > var_a87aeae6) {
            n_to_spawn--;
            function_1eaaceab(var_f5064815.var_f186cef3);
        }
        if (n_to_spawn <= 0) {
            waitframe(1);
            continue;
        }
        s_center = {#origin:self.origin, #angles:self.angles};
        if (isdefined(self.radius)) {
            s_center.radius = self.radius;
        } else {
            s_center.radius = 500;
        }
        s_center.spawn_points = [];
        s_center.var_9b178666 = s_center.radius;
        s_center.var_48d0f926 = 64;
        s_center.var_783fc5e = n_to_spawn;
        s_center.spawn_points = namespace_85745671::function_e4791424(s_center.origin, s_center.var_783fc5e, s_center.var_48d0f926, s_center.var_9b178666);
        var_2eb61c8a = arraycopy(s_center.spawn_points);
        var_2eb61c8a = array::randomize(var_2eb61c8a);
        for (i = 0; i < n_to_spawn; i++) {
            if (var_2eb61c8a.size <= 0) {
                var_2eb61c8a = arraycopy(s_center.spawn_points);
                var_2eb61c8a = array::randomize(var_2eb61c8a);
            }
            v_spawn = var_2eb61c8a[0];
            arrayremoveindex(var_2eb61c8a, 0);
            v_spawn = v_spawn.origin;
            var_82706add = function_4674880c(s_instance);
            var_4af2a1f2 = spawn_ai(var_82706add, v_spawn, (0, randomfloat(360), 0));
            if (isdefined(var_4af2a1f2)) {
                self.n_spawned++;
                if (!isdefined(s_instance.a_ai_spawned)) {
                    s_instance.a_ai_spawned = [];
                } else if (!isarray(s_instance.a_ai_spawned)) {
                    s_instance.a_ai_spawned = array(s_instance.a_ai_spawned);
                }
                s_instance.a_ai_spawned[s_instance.a_ai_spawned.size] = var_4af2a1f2;
                if (!isdefined(var_f5064815.a_ai_spawned)) {
                    var_f5064815.a_ai_spawned = [];
                } else if (!isarray(var_f5064815.a_ai_spawned)) {
                    var_f5064815.a_ai_spawned = array(var_f5064815.a_ai_spawned);
                }
                var_f5064815.a_ai_spawned[var_f5064815.a_ai_spawned.size] = var_4af2a1f2;
                if (!isdefined(var_f5064815.var_f186cef3)) {
                    var_f5064815.var_f186cef3 = [];
                } else if (!isarray(var_f5064815.var_f186cef3)) {
                    var_f5064815.var_f186cef3 = array(var_f5064815.var_f186cef3);
                }
                var_f5064815.var_f186cef3[var_f5064815.var_f186cef3.size] = var_4af2a1f2;
                var_4af2a1f2 thread function_a810bd2f();
                if (self.n_spawned >= var_a87aeae6) {
                    self notify(#"hash_316bee96eded77ba");
                }
                if (i + 1 < n_to_spawn) {
                    util::wait_network_frame();
                }
            }
        }
        s_center struct::delete();
        wait randomfloatrange(5, 15);
    }
}

// Namespace namespace_662ff671/namespace_662ff671
// Params 1, eflags: 0x4
// Checksum 0xd9803038, Offset: 0x2fd8
// Size: 0xe6
function private function_4674880c(s_instance) {
    switch (level.var_b48509f9) {
    case 1:
        s_instance.var_6ec779fd = s_instance.var_72e31bf2;
        break;
    case 2:
        s_instance.var_6ec779fd = s_instance.var_3579a11c;
        break;
    case 3:
        s_instance.var_6ec779fd = s_instance.var_6427fe78;
        break;
    default:
        s_instance.var_6ec779fd = s_instance.var_9903e833;
        break;
    }
    var_6017f33e = namespace_679a22ba::function_ca209564(s_instance.var_6ec779fd);
    return var_6017f33e.var_990b33df;
}

// Namespace namespace_662ff671/namespace_662ff671
// Params 1, eflags: 0x0
// Checksum 0x4b087214, Offset: 0x30c8
// Size: 0xfa
function function_a45cb92c(s_instance) {
    switch (level.var_b48509f9) {
    case 1:
        var_6017f33e = namespace_679a22ba::function_ca209564(s_instance.var_fa4b6d81);
        break;
    case 2:
        var_6017f33e = namespace_679a22ba::function_ca209564(s_instance.var_dba43033);
        break;
    case 3:
        var_6017f33e = namespace_679a22ba::function_ca209564(s_instance.var_d1371b59);
        break;
    default:
        var_6017f33e = namespace_679a22ba::function_ca209564(s_instance.var_43897ffc);
        break;
    }
    return var_6017f33e.var_990b33df;
}

// Namespace namespace_662ff671/namespace_662ff671
// Params 2, eflags: 0x4
// Checksum 0x943d0ed6, Offset: 0x31d0
// Size: 0x3ac
function private function_92f52c04(s_instance, *e_activator) {
    e_activator endon(#"complete");
    self endon(#"death");
    if (is_true(e_activator.var_f1a13487)) {
        e_activator flag::wait_till("avogadro_intro_complete");
    }
    self.var_4675adc1 = 0;
    self.var_894bb3c9 = 0;
    a_s_spawns = arraycopy(isdefined(self.var_fe2612fe[#"spawn"]) ? self.var_fe2612fe[#"spawn"] : []);
    if (a_s_spawns.size > 0) {
        var_3d5ea915 = isdefined(self.var_fe2612fe[#"hash_15796c0d1beb39c3"]) ? self.var_fe2612fe[#"hash_15796c0d1beb39c3"] : [];
        if (var_3d5ea915.size > 0) {
            self function_bb9468f8(var_3d5ea915);
        }
        n_spawns = int(isdefined(self.count) ? self.count : 1);
        var_d189de45 = int(isdefined(self.lives) ? self.lives : 1);
        self.var_894bb3c9 = n_spawns * var_d189de45;
        for (i = 0; i < n_spawns; i++) {
            if (a_s_spawns.size <= 0) {
                a_s_spawns = arraycopy(isdefined(self.var_fe2612fe[#"spawn"]) ? self.var_fe2612fe[#"spawn"] : []);
            }
            s_spawn = array::random(a_s_spawns);
            arrayremovevalue(a_s_spawns, s_spawn);
            var_f5064815 = spawnstruct();
            var_f5064815 thread function_15bda870(s_spawn, self, e_activator);
            if (i + 1 < n_spawns) {
                util::wait_network_frame();
            }
        }
        while (self.var_4675adc1 < self.var_894bb3c9) {
            waitframe(1);
        }
    }
    e_activator.var_5ba1d698++;
    if (e_activator.var_5ba1d698 >= e_activator.var_c42980f6) {
        if (isdefined(e_activator.var_8d0c68a3)) {
            level thread namespace_cda50904::function_a92a93e9(e_activator.var_8d0c68a3 + (0, 0, 48), undefined, 1);
        }
        e_activator flag::set("complete");
    }
}

// Namespace namespace_662ff671/namespace_662ff671
// Params 1, eflags: 0x0
// Checksum 0xb9ddbd0, Offset: 0x3588
// Size: 0x32
function function_72213470(s_instance) {
    self waittill(#"death");
    s_instance.var_8d0c68a3 = self.origin;
}

// Namespace namespace_662ff671/namespace_662ff671
// Params 3, eflags: 0x4
// Checksum 0x1d3c745, Offset: 0x35c8
// Size: 0x92c
function private function_15bda870(s_spawn, var_109708e0, s_instance) {
    self.a_ai_spawned = [];
    self.var_f186cef3 = [];
    self.var_ed0a75a3 = [];
    foreach (var_5054ec97 in isdefined(var_109708e0.var_fe2612fe[#"hash_2a7f095c144edd97"]) ? var_109708e0.var_fe2612fe[#"hash_2a7f095c144edd97"] : []) {
        if (!is_true(var_5054ec97.var_af51daa7)) {
            var_d76c3f03 = spawnstruct();
            var_d76c3f03.var_6c2313dc = [];
            var_d76c3f03.var_4b28d8c4 = var_5054ec97.var_4b28d8c4;
            var_d76c3f03 thread function_a96eb06b(self, var_5054ec97, s_instance);
            if (!isdefined(self.var_ed0a75a3)) {
                self.var_ed0a75a3 = [];
            } else if (!isarray(self.var_ed0a75a3)) {
                self.var_ed0a75a3 = array(self.var_ed0a75a3);
            }
            self.var_ed0a75a3[self.var_ed0a75a3.size] = var_d76c3f03;
        }
    }
    v_spawn = s_spawn.origin;
    v_angles = s_spawn.angles;
    var_82706add = var_109708e0.ai_type;
    if (!isdefined(var_82706add)) {
        var_82706add = s_spawn.ai_type;
    }
    self.mdl_portal = util::spawn_model("tag_origin", v_spawn, v_angles);
    wait 0.1;
    if (isdefined(self.mdl_portal)) {
        self.mdl_portal clientfield::set("payload_teleport", 2);
        wait 2.7;
        self.mdl_portal clientfield::set("final_battle_cloud_fx", 1);
        wait 2.5;
        self.mdl_portal clientfield::set("final_battle_cloud_fx", 0);
        wait 1;
    }
    self.var_1f73a372 = spawn_ai(var_82706add, v_spawn, v_angles, 1);
    self.var_1f73a372.var_f5064815 = self;
    self.var_1f73a372.var_dd6fe31f = 1;
    self.var_1f73a372.var_6a4ec994 = 0;
    if (isdefined(self.mdl_portal)) {
        self.mdl_portal delete();
    }
    if (!isdefined(s_instance.a_ai_spawned)) {
        s_instance.a_ai_spawned = [];
    } else if (!isarray(s_instance.a_ai_spawned)) {
        s_instance.a_ai_spawned = array(s_instance.a_ai_spawned);
    }
    s_instance.a_ai_spawned[s_instance.a_ai_spawned.size] = self.var_1f73a372;
    wait 2;
    self.var_1f73a372 thread function_fc515700(s_spawn, self, var_109708e0, s_instance);
    self.var_1f73a372 thread function_72213470(s_instance);
    foreach (var_1af8e2ec in isdefined(s_spawn.var_fe2612fe[#"hash_61bf7f7a2c84e479"]) ? s_spawn.var_fe2612fe[#"hash_61bf7f7a2c84e479"] : []) {
        var_1af8e2ec thread function_dd27cb14(self.var_1f73a372, self, s_instance);
    }
    s_waitresult = self.var_1f73a372 waittill(#"death");
    self.var_1f73a372 thread function_8da8f6cf(s_instance);
    v_death = self.var_1f73a372.origin;
    e_killer = s_waitresult.attacker;
    if (self.var_1f73a372.aitype === #"hash_acac3fe7a341329") {
        s_instance.var_ea2fea11 = 0;
        function_445f3f8e(s_instance);
    } else {
        var_d8f8912 = util::spawn_model("tag_origin", v_death);
        waitframe(1);
        var_d8f8912 clientfield::set("final_battle_cloud_fx", 1);
        wait 2.5;
        var_d8f8912 clientfield::set("final_battle_cloud_fx", 0);
    }
    var_88f24b00 = util::spawn_model(#"hash_8b8c98dda08574e", v_death + (0, 0, 20));
    if (isdefined(var_88f24b00)) {
        var_88f24b00 thread function_3dce2703();
        s_instance.var_344a6a1a[s_instance.var_344a6a1a.size] = var_88f24b00;
    }
    s_instance.var_4675adc1++;
    var_109708e0.var_4675adc1++;
    s_instance thread function_78b9913f(s_waitresult.attacker);
    objective_manager::function_d28e25e7(s_instance.var_4675adc1);
    arrayremovevalue(self.var_ed0a75a3, undefined);
    foreach (var_d76c3f03 in self.var_ed0a75a3) {
        if (isdefined(var_d76c3f03.var_6c2313dc)) {
            function_1eaaceab(var_d76c3f03.var_6c2313dc);
            foreach (ai in var_d76c3f03.var_6c2313dc) {
                ai thread function_d38842d3();
            }
        }
        var_d76c3f03 struct::delete();
    }
    function_1eaaceab(s_instance.a_ai_spawned);
    foreach (ai in s_instance.a_ai_spawned) {
        gibserverutils::annihilate(ai);
        if (isalive(ai)) {
            ai.allowdeath = 1;
            ai kill(undefined, undefined, undefined, undefined, undefined, 1);
        }
    }
    if (isdefined(var_d8f8912)) {
        var_d8f8912 delete();
    }
    self notify(#"hash_61065e42888f1894");
    self struct::delete();
}

// Namespace namespace_662ff671/namespace_662ff671
// Params 0, eflags: 0x0
// Checksum 0xfd94cbce, Offset: 0x3f00
// Size: 0x154
function function_3dce2703() {
    self setscale(0.5);
    self.var_3aee78d5 = spawn("trigger_radius_use", self.origin, 0, 80, 80);
    self.var_3aee78d5 triggerignoreteam();
    self.var_3aee78d5 setcursorhint("HINT_NOICON");
    self.var_3aee78d5 sethintstring(#"hash_1f4dfe99a27799dd");
    self.var_3aee78d5 usetriggerrequirelookat(1);
    s_result = self.var_3aee78d5 waittill(#"trigger");
    s_result.activator thread zm_score::add_to_player_score(250);
    self.var_3aee78d5 delete();
    self delete();
}

// Namespace namespace_662ff671/namespace_662ff671
// Params 1, eflags: 0x0
// Checksum 0xc0da8640, Offset: 0x4060
// Size: 0x100
function function_445f3f8e(s_instance) {
    var_5f59f064 = getaiarchetypearray(#"hash_7c0d83ac1e845ac2");
    if (!isdefined(var_5f59f064) || isdefined(var_5f59f064) && !var_5f59f064.size) {
        return;
    }
    foreach (var_ff251b7 in var_5f59f064) {
        var_ff251b7 thread function_6af3ebd6(s_instance);
    }
    while (s_instance.var_ea2fea11 < var_5f59f064.size) {
        wait 0.1;
    }
}

// Namespace namespace_662ff671/namespace_662ff671
// Params 1, eflags: 0x0
// Checksum 0xf056dc00, Offset: 0x4168
// Size: 0x108
function function_6af3ebd6(s_instance) {
    if (self.aitype === #"hash_7f957e36b4f6160f") {
        self.str_objective = #"hash_719909f3c3ecf188";
    } else if (self.aitype === #"hash_6904f5c7bef64405") {
        self.str_objective = #"hash_71990af3c3ecf33b";
    }
    if (isdefined(self.str_objective)) {
        self.n_objective_id = gameobjects::get_next_obj_id();
        objective_add(self.n_objective_id, "active", self, self.str_objective);
    }
    self waittill(#"death");
    if (isdefined(self.str_objective)) {
        objective_delete(self.n_objective_id);
    }
    s_instance.var_ea2fea11++;
}

// Namespace namespace_662ff671/namespace_662ff671
// Params 1, eflags: 0x0
// Checksum 0xb85fd1ec, Offset: 0x4278
// Size: 0x12c
function function_78b9913f(e_player) {
    if (self.var_4675adc1 >= self.var_894bb3c9) {
        if (self.var_894bb3c9 > 1) {
            if (isplayer(e_player)) {
                e_player thread util::delay(2.5, "death", &globallogic_audio::leader_dialog_on_player, "objectiveKillHVTsEndSuccess");
            }
            level thread util::delay(2.5, undefined, &globallogic_audio::leader_dialog, "objectiveKillHVTsEndSuccessResponse");
            return;
        }
        if (isplayer(e_player)) {
            e_player thread util::delay(2.5, "death", &globallogic_audio::leader_dialog_on_player, "objectiveKillHVTEndSuccess");
        }
        level thread util::delay(2.5, undefined, &globallogic_audio::leader_dialog, "objectiveKillHVTEndSuccessResponse");
    }
}

// Namespace namespace_662ff671/namespace_662ff671
// Params 4, eflags: 0x4
// Checksum 0xef3a324, Offset: 0x43b0
// Size: 0x684
function private function_fc515700(s_spawn, var_f5064815, var_109708e0, s_instance) {
    self endon(#"death");
    self.ignore_nuke = 1;
    if (isdefined(s_spawn.radius)) {
        self.var_21249dfb = s_spawn.radius;
    }
    if (!var_f5064815 flag::get("first_spawn")) {
        var_f5064815 flag::set("first_spawn");
        self callback::function_d8abfc3d(#"hash_4afe635f36531659", &function_4cf80702);
        self.var_12ec333b = 1;
        self thread hvt_waypoint_think(s_instance, var_f5064815);
        self thread function_667a319b(s_instance, 1);
        if (is_true(s_instance.var_9ef060ec)) {
            s_instance.var_fe987b5c = 1;
            s_instance function_d91f142f(var_109708e0);
        }
    } else {
        self thread function_667a319b(s_instance, 0);
    }
    var_f5064815 flag::clear("hvt_attack");
    if (self.archetype != #"zombie") {
        self thread function_c93772c();
    }
    var_e905c444 = isdefined(s_spawn.var_fe2612fe[#"hash_46c4b051187d03ee"]) ? s_spawn.var_fe2612fe[#"hash_46c4b051187d03ee"] : [];
    if (is_true(s_instance.var_9ef060ec)) {
        self thread function_90591f67(var_f5064815, var_109708e0, s_instance);
        foreach (var_a1042f77 in isdefined(s_spawn.var_fe2612fe[#"hash_203a7ea942db54bb"]) ? s_spawn.var_fe2612fe[#"hash_203a7ea942db54bb"] : []) {
            var_a1042f77 thread function_cf54aadd(self, var_f5064815, s_instance, var_e905c444);
        }
    }
    self thread function_e13574ed(var_f5064815);
    if (var_e905c444.size > 0) {
        self flag::wait_till_clear("kill_hvt_teleporting");
        wait 0.1;
        awareness::pause(self);
        self val::set("hvt_ignoreall", "ignoreall", 1);
        self thread function_45965a1(s_instance, var_f5064815, var_109708e0, var_e905c444);
        if (s_instance.targetname === "kill_hvt_golova_steiner") {
            var_f5064815 function_bb9468f8(var_e905c444);
        } else if (isdefined(self.var_21249dfb)) {
            self thread function_47de2d14();
            self thread function_4e1e24ae();
            self waittill(#"attack");
        }
        self notify(#"attacking");
        self val::reset("hvt_ignoreall", "ignoreall");
        awareness::resume(self);
        var_f5064815 flag::set("hvt_attack");
    } else {
        awareness::resume(self);
        if (is_true(var_109708e0.var_9d2375f4)) {
            var_f5064815 flag::set("hvt_attack");
        }
    }
    var_f5064815 flag::wait_till("hvt_attack");
    if (is_true(var_109708e0.var_9d2375f4)) {
        self thread function_a810bd2f();
    }
    if (isdefined(var_109708e0.var_cac36ea9) && var_109708e0.var_cac36ea9 != "") {
        level flag::set(var_109708e0.var_cac36ea9);
    }
    foreach (var_43bd42d in isdefined(s_spawn.var_fe2612fe[#"hash_c12641cffad619b"]) ? s_spawn.var_fe2612fe[#"hash_c12641cffad619b"] : []) {
        var_43bd42d thread function_3eef9ba0(s_instance);
    }
    if (self.var_6a4ec994) {
        self thread function_d20a3932(s_instance, var_f5064815, self.var_6a4ec994);
    }
}

// Namespace namespace_662ff671/namespace_662ff671
// Params 3, eflags: 0x0
// Checksum 0x97d126ea, Offset: 0x4a40
// Size: 0x29c
function function_d20a3932(s_instance, var_f5064815, var_6a4ec994) {
    self endon(#"death");
    switch (self.aitype) {
    case #"hash_3ff43755c44e6d3d":
        var_7ecdee63 = #"hash_2855f060aad4ae87";
        break;
    case #"hash_acac3fe7a341329":
        var_7ecdee63 = #"hash_42cbb8cb19ae56dd";
        break;
    case #"hash_60d7855358ceb53d":
        var_7ecdee63 = #"spawner_bo5_avogadro_sr";
        break;
    }
    var_e00b0988 = function_336cb6b9(var_7ecdee63);
    if (var_6a4ec994 == 1) {
        var_e00b0988 -= 1;
    }
    a_s_pts = namespace_85745671::function_e4791424(self.origin, 16, 40, 300, 100, 0, 1);
    for (i = 0; i < var_e00b0988; i++) {
        if (isdefined(a_s_pts[i])) {
            ai_dog = spawn_ai(var_7ecdee63, a_s_pts[i].origin, self.angles);
            wait 0.1;
            if (isdefined(ai_dog)) {
                if (!isdefined(s_instance.a_ai_spawned)) {
                    s_instance.a_ai_spawned = [];
                } else if (!isarray(s_instance.a_ai_spawned)) {
                    s_instance.a_ai_spawned = array(s_instance.a_ai_spawned);
                }
                s_instance.a_ai_spawned[s_instance.a_ai_spawned.size] = ai_dog;
                if (!isdefined(var_f5064815.a_ai_spawned)) {
                    var_f5064815.a_ai_spawned = [];
                } else if (!isarray(var_f5064815.a_ai_spawned)) {
                    var_f5064815.a_ai_spawned = array(var_f5064815.a_ai_spawned);
                }
                var_f5064815.a_ai_spawned[var_f5064815.a_ai_spawned.size] = ai_dog;
            }
        }
    }
}

// Namespace namespace_662ff671/namespace_662ff671
// Params 1, eflags: 0x0
// Checksum 0x20668467, Offset: 0x4ce8
// Size: 0x136
function function_336cb6b9(var_7ecdee63) {
    switch (getplayers().size) {
    case 1:
        if (var_7ecdee63 == #"spawner_bo5_avogadro_sr") {
            var_e00b0988 = 2;
        } else {
            var_e00b0988 = 3;
        }
        break;
    case 2:
        if (var_7ecdee63 == #"spawner_bo5_avogadro_sr") {
            var_e00b0988 = 2;
        } else {
            var_e00b0988 = 4;
        }
        break;
    case 3:
        if (var_7ecdee63 == #"spawner_bo5_avogadro_sr") {
            var_e00b0988 = 2;
        } else {
            var_e00b0988 = 5;
        }
        break;
    case 4:
        if (var_7ecdee63 == #"spawner_bo5_avogadro_sr") {
            var_e00b0988 = 3;
        } else {
            var_e00b0988 = 7;
        }
        break;
    }
    return var_e00b0988;
}

// Namespace namespace_662ff671/namespace_662ff671
// Params 4, eflags: 0x0
// Checksum 0x180ee9ae, Offset: 0x4e28
// Size: 0x408
function function_45965a1(s_instance, var_f5064815, var_109708e0, var_e905c444) {
    self endon(#"death");
    var_f5064815 function_bb9468f8(var_e905c444);
    foreach (var_d76c3f03 in var_f5064815.var_ed0a75a3) {
        function_1eaaceab(var_d76c3f03.var_6c2313dc);
        foreach (var_a491491c in var_d76c3f03.var_6c2313dc) {
            var_a491491c thread function_a810bd2f();
        }
        if (is_true(var_d76c3f03.var_4b28d8c4)) {
            var_d76c3f03 notify(#"hash_459d7d9161613634");
            var_d76c3f03 struct::delete();
        }
    }
    arrayremovevalue(var_f5064815.var_ed0a75a3, undefined);
    foreach (var_5054ec97 in isdefined(var_109708e0.var_fe2612fe[#"hash_2a7f095c144edd97"]) ? var_109708e0.var_fe2612fe[#"hash_2a7f095c144edd97"] : []) {
        if (is_true(var_5054ec97.var_af51daa7)) {
            var_d76c3f03 = spawnstruct();
            var_d76c3f03 thread function_a96eb06b(var_f5064815, var_5054ec97, s_instance);
            if (!isdefined(var_f5064815.var_ed0a75a3)) {
                var_f5064815.var_ed0a75a3 = [];
            } else if (!isarray(var_f5064815.var_ed0a75a3)) {
                var_f5064815.var_ed0a75a3 = array(var_f5064815.var_ed0a75a3);
            }
            var_f5064815.var_ed0a75a3[var_f5064815.var_ed0a75a3.size] = var_d76c3f03;
        }
    }
    if (is_true(s_instance.var_9ef060ec)) {
        var_f5064815 notify(#"hash_61065e42888f1894");
        function_1eaaceab(var_f5064815.a_ai_spawned);
        foreach (ai in var_f5064815.a_ai_spawned) {
            ai thread function_a810bd2f();
        }
    }
}

// Namespace namespace_662ff671/namespace_662ff671
// Params 0, eflags: 0x0
// Checksum 0x7ebc46c5, Offset: 0x5238
// Size: 0x9a
function function_47de2d14() {
    self endon(#"death", #"attacking");
    while (true) {
        s_result = self waittill(#"damage");
        if (isdefined(s_result.attacker) && isplayer(s_result.attacker)) {
            self notify(#"attack");
        }
    }
}

// Namespace namespace_662ff671/namespace_662ff671
// Params 0, eflags: 0x0
// Checksum 0xf873388d, Offset: 0x52e0
// Size: 0x100
function function_4e1e24ae() {
    self endon(#"death", #"attacking");
    while (true) {
        a_e_players = function_a1ef346b(undefined, self.origin, self.var_21249dfb);
        foreach (e_player in a_e_players) {
            if (!e_player laststand::player_is_in_laststand()) {
                self notify(#"attack");
            }
        }
        wait 0.5;
    }
}

// Namespace namespace_662ff671/namespace_662ff671
// Params 0, eflags: 0x4
// Checksum 0x32947965, Offset: 0x53e8
// Size: 0x150
function private function_c93772c() {
    self endon(#"death");
    var_82cf0f69 = getaiarchetypearray(self.archetype);
    arrayremovevalue(var_82cf0f69, self);
    var_82cf0f69 = arraysortclosest(var_82cf0f69, self.origin, undefined, 0, 10000);
    foreach (var_e0f93904 in var_82cf0f69) {
        if (isdefined(var_e0f93904) && var_e0f93904.targetname !== "kill_hvt_ai" && var_e0f93904.targetname !== "kill_hvt_hvt") {
            var_e0f93904 thread function_d38842d3();
        }
        util::wait_network_frame();
    }
}

// Namespace namespace_662ff671/namespace_662ff671
// Params 1, eflags: 0x4
// Checksum 0xe54cf384, Offset: 0x5540
// Size: 0x94
function private function_d91f142f(var_109708e0) {
    var_59980149 = isdefined(var_109708e0.var_fe2612fe[#"hvt"]) ? var_109708e0.var_fe2612fe[#"hvt"] : [];
    var_a2b4a7d6 = var_59980149[0];
    if (isdefined(var_a2b4a7d6)) {
        self.var_fe987b5c++;
        self function_d91f142f(var_a2b4a7d6);
    }
}

// Namespace namespace_662ff671/namespace_662ff671
// Params 3, eflags: 0x4
// Checksum 0xdc58eddc, Offset: 0x55e0
// Size: 0x6e4
function private function_90591f67(var_f5064815, var_109708e0, s_instance) {
    self endoncallback(&function_ba70a728, #"death");
    var_59980149 = isdefined(var_109708e0.var_fe2612fe[#"hvt"]) ? var_109708e0.var_fe2612fe[#"hvt"] : [];
    var_a2b4a7d6 = var_59980149[0];
    if (!isdefined(var_a2b4a7d6)) {
        return;
    }
    var_fe987b5c = isdefined(s_instance.var_fe987b5c) ? s_instance.var_fe987b5c : 1;
    n_start_health = self.health;
    var_1b8d5495 = n_start_health - self.maxhealth / var_fe987b5c;
    while (self.health > var_1b8d5495) {
        waitframe(1);
    }
    self flag::set("kill_hvt_teleporting");
    var_f5064815 notify(#"hash_61065e42888f1894");
    self val::set("hvt_teleport_takedamage", "takedamage", 0);
    switch (self.aitype) {
    case #"hash_3ff43755c44e6d3d":
        str_anim = "ai_zm_dlc3_armored_zombie_enrage";
        n_wait = 1.5;
        break;
    case #"hash_acac3fe7a341329":
        str_anim = "ai_t9_zm_steiner_base_com_stn_atk_blast_01_quick_charging";
        n_wait = 1.2;
        break;
    case #"hash_60d7855358ceb53d":
        str_anim = "ai_t9_zm_mechz_berserk_2";
        n_wait = 1.5;
        break;
    }
    self thread animation::play(str_anim);
    wait n_wait;
    self animation::stop(0.3, 1);
    self clientfield::set("" + #"hash_b74182bd1e44a44", 1);
    self thread function_8da8f6cf(s_instance);
    wait 0.5;
    self clientfield::set("" + #"hash_b74182bd1e44a44", 0);
    wait 0.25;
    self clientfield::increment("" + #"hash_435db79c304e12a5");
    wait 0.1;
    radiusdamage(self.origin, 1000, 20, 5);
    objective_setinvisibletoall(var_f5064815.n_objective_id);
    self.mdl_trail = util::spawn_model("tag_origin", self.origin);
    self ghost();
    var_7901ee14 = (0, 0, 20000);
    self forceteleport(var_7901ee14);
    self.var_bcf2b2b9 = util::spawn_model("tag_origin", var_7901ee14);
    self linkto(self.var_bcf2b2b9);
    function_1eaaceab(var_f5064815.a_ai_spawned);
    foreach (ai in var_f5064815.a_ai_spawned) {
        gibserverutils::annihilate(ai);
        if (isalive(ai)) {
            ai.allowdeath = 1;
            ai kill(undefined, undefined, undefined, undefined, undefined, 1);
        }
    }
    var_6e468adf = isdefined(var_a2b4a7d6.var_fe2612fe[#"spawn"]) ? var_a2b4a7d6.var_fe2612fe[#"spawn"] : [];
    var_1e001170 = var_6e468adf[0];
    if (isdefined(self.mdl_trail)) {
        self.mdl_trail function_42fbf5d9(self, var_1e001170, s_instance, var_f5064815);
        self.var_6a4ec994++;
    }
    self.var_bcf2b2b9 delete();
    self forceteleport(var_1e001170.origin, var_1e001170.angles);
    util::wait_network_frame();
    self val::reset("hvt_teleport_takedamage", "takedamage");
    self setgoal(var_1e001170.origin);
    objective_setvisibletoall(var_f5064815.n_objective_id);
    self thread function_fc515700(var_1e001170, var_f5064815, var_a2b4a7d6, s_instance);
    self show();
    self flag::clear("kill_hvt_teleporting");
    util::wait_network_frame();
    self clientfield::set("" + #"hash_b74182bd1e44a44", 1);
    wait 1;
    self clientfield::set("" + #"hash_b74182bd1e44a44", 0);
}

// Namespace namespace_662ff671/namespace_662ff671
// Params 4, eflags: 0x0
// Checksum 0x12bd41e3, Offset: 0x5cd0
// Size: 0x38c
function function_42fbf5d9(var_1f73a372, s_dest, s_instance, var_f5064815) {
    self clientfield::set("" + #"hash_85dd1e407a282d9", 1);
    wait 2;
    n_dist = distance(self.origin, s_dest.origin);
    n_time = n_dist / 1000;
    var_7fd007f9 = distance2d(self.origin, s_dest.origin) * 0.5;
    n_inc = int(n_dist);
    while (true) {
        var_ed0c1ff8 = distance2d(self.origin, s_dest.origin);
        if (var_ed0c1ff8 <= 100) {
            break;
        }
        v_dest = s_dest.origin + (0, 0, n_inc);
        n_inc -= 50;
        if (v_dest[2] <= s_dest.origin[2]) {
            break;
        }
        self moveto(v_dest, n_time);
        waitframe(1);
    }
    n_dist = distance(self.origin, s_dest.origin);
    n_time = n_dist / 1000;
    self moveto(s_dest.origin + (0, 0, 40), n_time);
    self waittill(#"movedone");
    foreach (var_1af8e2ec in isdefined(s_dest.var_fe2612fe[#"hash_61bf7f7a2c84e479"]) ? s_dest.var_fe2612fe[#"hash_61bf7f7a2c84e479"] : []) {
        var_1af8e2ec thread function_dd27cb14(var_1f73a372, var_f5064815, s_instance);
    }
    self clientfield::set("payload_teleport", 2);
    wait 4;
    self clientfield::set("final_battle_cloud_fx", 1);
    wait 2.5;
    self clientfield::set("final_battle_cloud_fx", 0);
    wait 1;
    self delete();
}

// Namespace namespace_662ff671/namespace_662ff671
// Params 1, eflags: 0x4
// Checksum 0x74ce9187, Offset: 0x6068
// Size: 0x34
function private function_ba70a728(*notifyhash) {
    if (isdefined(self.var_bcf2b2b9)) {
        self.var_bcf2b2b9 delete();
    }
}

// Namespace namespace_662ff671/namespace_662ff671
// Params 1, eflags: 0x4
// Checksum 0xd55eee73, Offset: 0x60a8
// Size: 0x228
function private function_e13574ed(var_f5064815) {
    self endon(#"death");
    var_f5064815 endon(#"hash_733ab6814f36e8ee");
    var_1b8d5495 = self.health - 50;
    while (true) {
        if (self.health <= var_1b8d5495) {
            break;
        }
        var_bfb8f3ce = 0;
        foreach (e_player in function_a1ef346b(undefined, self.origin, 1024)) {
            if (!e_player laststand::player_is_in_laststand() && abs(self.origin[2] - e_player.origin[2]) <= 32 && self math::get_dot_forward(e_player.origin) > 0.25 && bullettracepassed(self util::get_eye(), e_player.origin, 0, self)) {
                var_bfb8f3ce = 1;
                break;
            }
        }
        if (var_bfb8f3ce) {
            break;
        }
        wait 1;
    }
    var_f5064815 flag::set("hvt_attack");
    var_f5064815 notify(#"hash_733ab6814f36e8ee");
}

// Namespace namespace_662ff671/namespace_662ff671
// Params 2, eflags: 0x0
// Checksum 0xe4c30bc5, Offset: 0x62d8
// Size: 0x1e0
function function_667a319b(s_instance, b_play_vo = 0) {
    level endon(#"hash_6e9f32e31f8d1c6f");
    self endon(#"death");
    while (true) {
        v_origin = self getcentroid();
        foreach (player in getplayers()) {
            if (player util::is_player_looking_at(v_origin, 0.6, 1, self) && distancesquared(v_origin, player.origin) < 6250000) {
                self function_8da8f6cf(s_instance);
                if (b_play_vo && s_instance.var_894bb3c9 > 1) {
                    player thread util::delay(3, "death", &globallogic_audio::leader_dialog_on_player, "objectiveKillHVTsSpotted");
                }
                level notify(#"hash_6e9f32e31f8d1c6f");
                return;
            }
        }
        wait 1;
    }
}

// Namespace namespace_662ff671/namespace_662ff671
// Params 1, eflags: 0x4
// Checksum 0x42415481, Offset: 0x64c0
// Size: 0x90
function private function_83c20994(var_31891b5a) {
    self endon(#"death");
    var_31891b5a endon(#"hash_733ab6814f36e8ee");
    while (true) {
        s_waitresult = self waittill(#"damage");
        if (isplayer(s_waitresult.attacker)) {
            var_31891b5a notify(#"hash_733ab6814f36e8ee");
            break;
        }
    }
}

// Namespace namespace_662ff671/namespace_662ff671
// Params 0, eflags: 0x4
// Checksum 0x9af44f, Offset: 0x6558
// Size: 0x8c
function private function_4cf80702() {
    if (self.current_state.name == #"chase") {
        if (self.archetype == #"zombie") {
            self namespace_85745671::function_9758722("super_sprint");
        }
        if (isdefined(self.var_f5064815)) {
            self.var_f5064815 flag::set("hvt_attack");
        }
    }
}

// Namespace namespace_662ff671/namespace_662ff671
// Params 0, eflags: 0x4
// Checksum 0xd2729923, Offset: 0x65f0
// Size: 0x94
function private function_b42b5f72() {
    if (self.current_state.name == #"chase") {
        if (self.archetype == #"zombie") {
            var_481bf1b8 = isdefined(level.var_b48509f9) ? level.var_b48509f9 : 1;
            if (var_481bf1b8 > 1) {
                self namespace_85745671::function_9758722("super_sprint");
            }
        }
    }
}

// Namespace namespace_662ff671/namespace_662ff671
// Params 1, eflags: 0x4
// Checksum 0xf8bc7328, Offset: 0x6690
// Size: 0x26e
function private function_bb9468f8(var_c79f5f0) {
    self endon(#"hash_733ab6814f36e8ee");
    foreach (s_trigger in var_c79f5f0) {
        s_trigger.radius = float(s_trigger.radius);
        s_trigger.trigger_height = float(isdefined(s_trigger.trigger_height) ? s_trigger.trigger_height : 1024);
    }
    while (true) {
        foreach (s_trigger in var_c79f5f0) {
            a_e_players = function_a1ef346b(undefined, s_trigger.origin, s_trigger.radius);
            if (isdefined(a_e_players) && a_e_players.size > 0) {
                foreach (e_player in a_e_players) {
                    if (!e_player laststand::player_is_in_laststand() && abs(s_trigger.origin[2] - e_player.origin[2]) <= s_trigger.trigger_height) {
                        return;
                    }
                }
            }
        }
        waitframe(1);
    }
}

// Namespace namespace_662ff671/namespace_662ff671
// Params 2, eflags: 0x4
// Checksum 0xad6a826d, Offset: 0x6908
// Size: 0x42
function private function_41f7333b(var_82706add, v_angles = self.angles) {
    return spawn_ai(var_82706add, self.origin, v_angles);
}

// Namespace namespace_662ff671/namespace_662ff671
// Params 4, eflags: 0x4
// Checksum 0xd4202b0b, Offset: 0x6958
// Size: 0xde
function private spawn_ai(var_82706add, v_origin = (0, 0, 0), v_angles = (0, 0, 0), var_94d02b5b = 0) {
    str_targetname = "kill_hvt_ai";
    if (var_94d02b5b) {
        str_targetname = "kill_hvt_hvt";
    }
    while (true) {
        var_7ecdee63 = get_spawner(var_82706add);
        ai = namespace_85745671::function_9d3ad056(var_7ecdee63, v_origin, v_angles, str_targetname);
        if (isdefined(ai)) {
            return ai;
        }
        waitframe(1);
    }
}

// Namespace namespace_662ff671/namespace_662ff671
// Params 2, eflags: 0x4
// Checksum 0xfec5d6e7, Offset: 0x6a40
// Size: 0x24e
function private hvt_waypoint_think(s_instance, var_f5064815) {
    str_objective = #"hash_71990cf3c3ecf6a1";
    if (isdefined(s_instance.var_9fcaacff)) {
        switch (s_instance.var_9fcaacff) {
        case 1:
            str_objective = #"hash_719909f3c3ecf188";
            break;
        case 2:
            str_objective = #"hash_71990af3c3ecf33b";
            break;
        case 3:
            str_objective = #"hash_71990ff3c3ecfbba";
            break;
        case 4:
            str_objective = #"hash_719910f3c3ecfd6d";
            break;
        case 5:
            str_objective = #"hash_71990df3c3ecf854";
            break;
        }
        s_instance.var_9fcaacff++;
    }
    if (self.archetype == #"zombie_dog") {
        wait 1.6;
    }
    if (isdefined(self)) {
        n_objective_id = gameobjects::get_next_obj_id();
        objective_add(n_objective_id, "active", self, str_objective);
        if (isdefined(var_f5064815)) {
            var_f5064815.n_objective_id = n_objective_id;
        }
        n_start_health = self.health;
        while (isdefined(self) && self.health > 0) {
            n_percent = self.health / n_start_health;
            objective_setprogress(n_objective_id, n_percent);
            waitframe(1);
        }
        objective_delete(n_objective_id);
        gameobjects::release_obj_id(n_objective_id);
        if (isdefined(var_f5064815)) {
            var_f5064815.n_objective_id = undefined;
        }
    }
}

// Namespace namespace_662ff671/namespace_662ff671
// Params 3, eflags: 0x4
// Checksum 0xdaeb5b62, Offset: 0x6c98
// Size: 0xa8c
function private function_a96eb06b(var_f5064815, var_6cd7585c, s_instance) {
    s_instance endon(#"complete");
    self endon(#"death", #"hash_459d7d9161613634");
    var_b35d8ad0 = float(isdefined(var_6cd7585c.var_2fd49ac3) ? var_6cd7585c.var_2fd49ac3 : 1);
    if (var_b35d8ad0 < 1) {
        n_roll = randomfloat(1);
        if (n_roll > var_b35d8ad0) {
            return;
        }
    }
    if (var_6cd7585c.ai_type != "hellhound") {
        wait 2;
    }
    if (var_6cd7585c.ai_type == "raz") {
        if (level.var_b48509f9 <= 1) {
            return;
        }
        function_1eaaceab(s_instance.a_ai_raz);
        if (s_instance.a_ai_raz.size >= 2) {
            return;
        }
        n_time = float(gettime()) / 1000;
        if (!isdefined(s_instance.var_bd3fb0dd) || n_time - s_instance.var_bd3fb0dd >= 120) {
            s_instance.var_bd3fb0dd = n_time;
        } else {
            return;
        }
    }
    n_players = function_a1ef346b().size;
    if (n_players <= 2) {
        var_428f5c67 = 3;
        if (level.var_b48509f9 <= 1 && var_6cd7585c.ai_type == "hellhound") {
            var_428f5c67--;
        }
        if (var_6cd7585c.ai_type == "avogadro") {
            var_428f5c67 = 1;
        }
    } else if (n_players <= 4) {
        var_428f5c67 = 4;
        if (var_6cd7585c.ai_type == "avogadro") {
            var_428f5c67 = 1;
        }
    } else {
        var_428f5c67 = 5;
        if (var_6cd7585c.ai_type == "avogadro") {
            var_428f5c67 = 2;
        }
    }
    if (var_6cd7585c.ai_type === "raz") {
        var_428f5c67 = 1;
        if (n_players >= 3) {
            var_428f5c67 = 2;
        }
    }
    var_719f528b = 256;
    if (var_6cd7585c.ai_type == "hellhound" || var_6cd7585c.ai_type == "avogadro") {
        var_719f528b += 128;
    }
    self.var_6c2313dc = [];
    for (i = 0; i < 3; i++) {
        var_49471b11 = 0;
        while (!var_49471b11) {
            function_1eaaceab(self.var_6c2313dc);
            for (var_25398dbe = var_428f5c67; var_25398dbe > 0; var_25398dbe--) {
                if (self.var_6c2313dc.size + var_25398dbe <= var_428f5c67) {
                    break;
                }
            }
            if (isdefined(var_f5064815.var_1f73a372) && isalive(var_f5064815.var_1f73a372) && var_25398dbe > 0) {
                if (!function_c9a44b0b(var_f5064815.var_1f73a372.origin)) {
                    v_origin = var_f5064815.var_1f73a372.origin;
                    v_angles = var_f5064815.var_1f73a372.angles;
                    e_closest = get_closest_player(v_origin);
                    if (isdefined(e_closest)) {
                        v_facing = vectortoangles(e_closest.origin - v_origin);
                        v_right = anglestoright(v_facing);
                        v_dir = anglestoforward(v_facing);
                    } else {
                        v_right = anglestoright(v_angles);
                        v_dir = anglestoforward(v_angles);
                        v_facing = v_dir;
                    }
                    v_center = checknavmeshdirection(v_origin, vectornormalize(v_dir), var_719f528b);
                    var_7168e01b = function_c9a44b0b(v_center);
                    if (!var_7168e01b) {
                        b_right = 1;
                        var_3a0b4224 = 1;
                        var_16379b1d = 1;
                        var_2eb61c8a = array(v_center);
                        for (j = 0; j < var_25398dbe - 1; j++) {
                            if (var_3a0b4224 >= 3) {
                                var_719f528b += 128;
                                var_3a0b4224 = 0;
                                v_center = checknavmeshdirection(v_origin, vectornormalize(v_dir), var_719f528b);
                                var_7168e01b = function_c9a44b0b(v_center);
                                if (var_7168e01b) {
                                    break;
                                }
                            }
                            if (var_3a0b4224 == 0) {
                                v_spawn = v_center;
                            } else {
                                var_4027630a = v_right;
                                if (!b_right) {
                                    var_4027630a *= -1;
                                }
                                v_spawn = checknavmeshdirection(v_center, vectornormalize(var_4027630a), 128 * var_16379b1d);
                                b_right = !b_right;
                            }
                            var_7168e01b = function_c9a44b0b(v_spawn);
                            if (var_7168e01b) {
                                break;
                            }
                            var_3a0b4224++;
                            if (!isdefined(var_2eb61c8a)) {
                                var_2eb61c8a = [];
                            } else if (!isarray(var_2eb61c8a)) {
                                var_2eb61c8a = array(var_2eb61c8a);
                            }
                            var_2eb61c8a[var_2eb61c8a.size] = v_spawn;
                        }
                        if (!var_7168e01b) {
                            foreach (v_spawn in var_2eb61c8a) {
                                if (var_6cd7585c.ai_type === "zombie_random" || var_6cd7585c.ai_type === "zombie") {
                                    var_6cd7585c.ai_type = function_a45cb92c(s_instance);
                                }
                                var_a491491c = spawn_ai(var_6cd7585c.ai_type, v_spawn, v_facing);
                                if (!isdefined(s_instance.a_ai_spawned)) {
                                    s_instance.a_ai_spawned = [];
                                } else if (!isarray(s_instance.a_ai_spawned)) {
                                    s_instance.a_ai_spawned = array(s_instance.a_ai_spawned);
                                }
                                s_instance.a_ai_spawned[s_instance.a_ai_spawned.size] = var_a491491c;
                                if (!isdefined(self.var_6c2313dc)) {
                                    self.var_6c2313dc = [];
                                } else if (!isarray(self.var_6c2313dc)) {
                                    self.var_6c2313dc = array(self.var_6c2313dc);
                                }
                                self.var_6c2313dc[self.var_6c2313dc.size] = var_a491491c;
                                if (var_6cd7585c.ai_type == "raz") {
                                    if (!isdefined(s_instance.a_ai_raz)) {
                                        s_instance.a_ai_raz = [];
                                    } else if (!isarray(s_instance.a_ai_raz)) {
                                        s_instance.a_ai_raz = array(s_instance.a_ai_raz);
                                    }
                                    s_instance.a_ai_raz[s_instance.a_ai_raz.size] = var_a491491c;
                                }
                                if (is_true(var_6cd7585c.var_9d2375f4)) {
                                    var_a491491c thread function_a810bd2f();
                                }
                                if (j + 1 < var_25398dbe) {
                                    util::wait_network_frame();
                                }
                            }
                            var_49471b11 = 1;
                            if (var_6cd7585c.ai_type == "raz") {
                                return;
                            }
                        }
                    }
                }
            }
            if (!var_49471b11) {
                waitframe(1);
            }
        }
        wait randomfloatrange(45, 60);
    }
}

// Namespace namespace_662ff671/namespace_662ff671
// Params 1, eflags: 0x4
// Checksum 0x393de2fa, Offset: 0x7730
// Size: 0xc8
function private get_closest_player(v_origin) {
    a_e_players = function_a1ef346b();
    a_e_players = arraysortclosest(a_e_players, v_origin);
    foreach (e_player in a_e_players) {
        if (!e_player laststand::player_is_in_laststand()) {
            return e_player;
        }
    }
}

// Namespace namespace_662ff671/namespace_662ff671
// Params 1, eflags: 0x4
// Checksum 0x352456f6, Offset: 0x7800
// Size: 0xf2
function private function_c9a44b0b(v_point) {
    foreach (e_player in function_a1ef346b()) {
        if (!e_player laststand::player_is_in_laststand()) {
            var_91d1913b = distancesquared(v_point, e_player.origin);
            if (var_91d1913b < function_a3f6cdac(256)) {
                return true;
            }
        }
    }
    return false;
}

// Namespace namespace_662ff671/namespace_662ff671
// Params 0, eflags: 0x4
// Checksum 0x725bff7b, Offset: 0x7900
// Size: 0x8e
function private function_a810bd2f() {
    self endon(#"death");
    self callback::function_d8abfc3d(#"hash_4afe635f36531659", &function_fd68cae4);
    while (true) {
        awareness::function_c241ef9a(self, get_closest_player(self.origin), 10);
        wait 10;
    }
}

// Namespace namespace_662ff671/namespace_662ff671
// Params 1, eflags: 0x4
// Checksum 0x6588375c, Offset: 0x7998
// Size: 0x1d2
function private get_spawner(var_82706add = "") {
    switch (var_82706add) {
    default:
        return #"hash_7cba8a05511ceedf";
    case #"hash_338eb4103e0ed797":
    case #"hash_7d0b1229ae633c6c":
        return #"hash_338eb4103e0ed797";
    case #"hash_46c917a1b5ed91e7":
    case #"hash_7d0b1329ae633e1f":
        return #"hash_46c917a1b5ed91e7";
    case #"spawner_bo5_avogadro_sr":
    case #"avogadro":
        return #"spawner_bo5_avogadro_sr";
    case #"mechz":
    case #"hash_60d7855358ceb53d":
        return #"hash_60d7855358ceb53d";
    case #"steiner":
    case #"hash_acac3fe7a341329":
        return #"hash_acac3fe7a341329";
    case #"hash_2f039c4706f6f243":
    case #"hash_42cbb8cb19ae56dd":
        return #"hash_42cbb8cb19ae56dd";
    case #"hash_2855f060aad4ae87":
    case #"hellhound":
        return #"hash_2855f060aad4ae87";
    case #"raz":
    case #"hash_3ff43755c44e6d3d":
        return #"hash_3ff43755c44e6d3d";
    }
}

// Namespace namespace_662ff671/namespace_662ff671
// Params 1, eflags: 0x4
// Checksum 0xec0faea4, Offset: 0x7b78
// Size: 0x164
function private function_8da8f6cf(s_instance) {
    n_time = float(gettime()) / 1000;
    if (!isdefined(s_instance.var_1bb7b5d7) || n_time - s_instance.var_1bb7b5d7 >= 3) {
        s_instance.var_1bb7b5d7 = n_time;
        switch (self.archetype) {
        case #"zombie":
            n_cf = 1;
            break;
        case #"hash_7c0d83ac1e845ac2":
            n_cf = 2;
            break;
        case #"raz":
            n_cf = 3;
            break;
        case #"mechz":
            n_cf = 4;
            break;
        default:
            /#
                iprintlnbold("<dev string:x38>");
            #/
            return;
        }
        self clientfield::increment("" + #"hash_74382f598f4de051", n_cf);
    }
}

// Namespace namespace_662ff671/namespace_662ff671
// Params 0, eflags: 0x4
// Checksum 0x348680a0, Offset: 0x7ce8
// Size: 0x8c
function private function_d38842d3() {
    self endon(#"death");
    while (is_false(self.allowdeath)) {
        waitframe(1);
    }
    self kill(self.origin, getplayers()[0], getplayers()[0], undefined, undefined, 1);
}

// Namespace namespace_662ff671/namespace_662ff671
// Params 1, eflags: 0x4
// Checksum 0x41a33d05, Offset: 0x7d80
// Size: 0x2c8
function private function_3eef9ba0(s_instance) {
    s_instance endon(#"complete");
    if (isdefined(self.delay)) {
        self.delay = float(self.delay);
        if (self.delay > 0) {
            wait self.delay;
        }
    }
    self.radius = float(isdefined(self.radius) ? self.radius : 128);
    var_809de660 = struct::get_array("survival_door");
    var_809de660 = arraysortclosest(var_809de660, self.origin, undefined, 0, self.radius);
    foreach (var_e4ce698a in var_809de660) {
        mdl_door = var_e4ce698a.door;
        if (isdefined(mdl_door)) {
            mdl_door.damage_level = 100;
            mdl_door namespace_4faef43b::function_ae47792b();
        }
    }
    foreach (dyn in function_c3d68575(self.origin, (self.radius, self.radius, self.radius))) {
        bundle = function_489009c1(dyn);
        if (isdefined(bundle.destroyed) && isdefined(dyn.health)) {
            dyn dodamage(dyn.health, dyn.origin, undefined, undefined, "none", "MOD_EXPLOSIVE");
            continue;
        }
        function_e2a06860(dyn, bundle.dynentstates.size - 1);
    }
}

// Namespace namespace_662ff671/namespace_662ff671
// Params 1, eflags: 0x4
// Checksum 0x74b3bfd3, Offset: 0x8050
// Size: 0x444
function private function_daf7835b(s_instance) {
    s_instance endon(#"complete");
    a_s_spawns = isdefined(s_instance.var_fe2612fe[#"hash_75c1be2b9c000f53"]) ? s_instance.var_fe2612fe[#"hash_75c1be2b9c000f53"] : [];
    if (a_s_spawns.size > 0) {
        var_bcd37ed4 = [];
        foreach (s_spawn in a_s_spawns) {
            var_3cdfebb4 = s_spawn function_41f7333b("avogadro");
            if (!isdefined(s_instance.a_ai_spawned)) {
                s_instance.a_ai_spawned = [];
            } else if (!isarray(s_instance.a_ai_spawned)) {
                s_instance.a_ai_spawned = array(s_instance.a_ai_spawned);
            }
            s_instance.a_ai_spawned[s_instance.a_ai_spawned.size] = var_3cdfebb4;
            if (!isdefined(var_bcd37ed4)) {
                var_bcd37ed4 = [];
            } else if (!isarray(var_bcd37ed4)) {
                var_bcd37ed4 = array(var_bcd37ed4);
            }
            var_bcd37ed4[var_bcd37ed4.size] = var_3cdfebb4;
            var_3cdfebb4.var_e3238e2b = 1;
            var_3cdfebb4 val::set("intro_avogadro_allowdeath", "allowdeath", 0);
            var_3cdfebb4 val::set("intro_avogadro_takedamage", "takedamage", 0);
            var_3cdfebb4 val::set("intro_avogadro_ignoreme", "ignoreme", 1);
            var_3cdfebb4 val::set("intro_avogadro_ignoreall", "ignoreall", 1);
            var_3cdfebb4 dontinterpolate();
            var_3cdfebb4 forceteleport(s_spawn.origin, s_spawn.angles);
            var_67ae4496 = util::spawn_model("tag_origin", s_spawn.origin, s_spawn.angles);
            var_3cdfebb4 thread util::delete_on_death(var_67ae4496);
            var_3cdfebb4 linkto(var_67ae4496);
            playfxontag("sr/fx9_zmb_vip_target_identify", var_3cdfebb4, "j_spine4");
            var_3cdfebb4 thread hvt_waypoint_think(s_instance);
        }
        wait 3;
        var_3cdfebb4 thread function_667a319b(s_instance, 0);
        function_1eaaceab(var_bcd37ed4);
        foreach (var_3cdfebb4 in var_bcd37ed4) {
            var_3cdfebb4 thread function_64377b7c();
        }
        wait 6;
        s_instance.var_9fcaacff = 0;
        s_instance flag::set("avogadro_intro_complete");
    }
}

// Namespace namespace_662ff671/namespace_662ff671
// Params 0, eflags: 0x4
// Checksum 0xef81aa16, Offset: 0x84a0
// Size: 0x94
function private function_64377b7c() {
    self endon(#"death");
    self namespace_9f3d3e9::onallcracks(self);
    self val::reset("intro_avogadro_allowdeath", "allowdeath");
    self val::reset("intro_avogadro_takedamage", "takedamage");
    self thread function_d38842d3();
}

