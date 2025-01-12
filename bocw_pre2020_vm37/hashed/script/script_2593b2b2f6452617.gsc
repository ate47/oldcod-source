#using script_1029986e2bc8ca8e;
#using script_113dd7f0ea2a1d4f;
#using script_12538a87a80a2978;
#using script_1cc417743d7c262d;
#using script_1cd491b1807da8f7;
#using script_27347f09888ad15;
#using script_3357acf79ce92f4b;
#using script_3411bb48d41bd3b;
#using script_4163291d6e693552;
#using script_7fc996fe8678852;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\gameobjects_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;

#namespace namespace_bff7ce85;

// Namespace namespace_bff7ce85/level_init
// Params 1, eflags: 0x40
// Checksum 0x167fa409, Offset: 0x348
// Size: 0x16c
function event_handler[level_init] main(*eventstruct) {
    objective_manager::function_b3464a7c(#"hash_3386f30228d9a983", &init, &defend_start, #"defend", #"hash_568700cc399c09f0");
    clientfield::register("scriptmover", "" + #"hash_74d70bb7fe52c00", 1, 1, "int");
    clientfield::register("scriptmover", "" + #"hash_3eeee7f3f5bdb9ff", 1, 1, "int");
    clientfield::register("scriptmover", "" + #"hash_18bcf106c476dfeb", 1, 1, "counter");
    clientfield::register("scriptmover", "" + #"hash_186c35405f4624bc", 1, 2, "int");
}

// Namespace namespace_bff7ce85/namespace_cb308359
// Params 1, eflags: 0x0
// Checksum 0x3209abc8, Offset: 0x4c0
// Size: 0x374
function init(instance) {
    foreach (s_instance in instance.var_fe2612fe[#"console"]) {
        s_instance.var_a43a7410 = namespace_8b6a9d79::spawn_script_model(s_instance.var_fe2612fe[#"platform"][0], #"hash_35b9c02d1d33868f", 1);
        s_instance.var_4a416ea9 = namespace_8b6a9d79::spawn_script_model(s_instance, #"hash_5cb2edd3633e3fdb", 1);
        s_instance.var_4a416ea9.targetname = "defend_object";
        s_instance.var_4a416ea9.var_4d0b3b87 = s_instance.var_fe2612fe[#"hash_41ae283ea203de66"][0];
        s_instance.var_4a416ea9.var_559503f1 = s_instance.var_fe2612fe[#"spawn_pt"];
        s_instance.var_4a416ea9.var_a74eba1b = s_instance.var_fe2612fe[#"spawn_dog"];
        s_instance.var_4a416ea9.var_ac77e384 = s_instance.var_fe2612fe[#"hash_794fd61036053410"];
        s_instance.var_720e353b = s_instance.var_fe2612fe[#"specimen"];
    }
    if (isdefined(instance.var_fe2612fe[#"blocker"])) {
        instance thread function_3a6b15fd();
    }
    instance.var_586c917d = array::random(s_instance.var_fe2612fe[#"specimen"]);
    instance.var_43123efe = namespace_8b6a9d79::spawn_script_model(instance.var_586c917d, instance.var_586c917d.model, 0);
    instance.var_43123efe ghost();
    instance.var_4a416ea9 = s_instance.var_4a416ea9;
    instance.var_4a416ea9 function_41b29ff0(#"hash_46b1078a533a5a9f");
    instance.var_a43a7410 = s_instance.var_a43a7410;
    instance thread function_7cf83691();
    instance thread function_86a476ea();
    instance thread function_f5087df2();
    instance.var_4272a188 thread objective_manager::function_98da2ed1(instance.var_4272a188.origin, "objectiveDefendApproach", "objectiveDefendApproachResponse");
    if (instance.targetname === #"hash_bc73cc49e8ec146") {
        instance thread function_bc04a76b();
    }
}

// Namespace namespace_bff7ce85/namespace_cb308359
// Params 0, eflags: 0x0
// Checksum 0x8a29f32a, Offset: 0x840
// Size: 0x180
function function_3a6b15fd() {
    if (isdefined(self.var_fe2612fe[#"blocker"])) {
        self.a_mdl_blockers = [];
        foreach (s_blocker in self.var_fe2612fe[#"blocker"]) {
            self.a_mdl_blockers[self.a_mdl_blockers.size] = namespace_8b6a9d79::spawn_script_model(s_blocker, s_blocker.model, 1);
        }
        foreach (mdl_blocker in self.a_mdl_blockers) {
            mdl_blocker disconnectpaths();
            mdl_blocker ghost();
        }
    }
}

// Namespace namespace_bff7ce85/namespace_cb308359
// Params 0, eflags: 0x0
// Checksum 0xb67b4fbf, Offset: 0x9c8
// Size: 0x128
function function_bc04a76b() {
    self endon(#"objective_ended");
    level flag::wait_till("all_players_spawned");
    wait 5;
    var_b54d7065 = getdynentarray("dynent_garage_button");
    doors = array::get_all_closest(self.origin, var_b54d7065, undefined, 4, self.script_radius);
    foreach (door in doors) {
        if (!function_ffdbe8c2(door)) {
            dynent_use::use_dynent(door);
        }
    }
}

// Namespace namespace_bff7ce85/namespace_cb308359
// Params 0, eflags: 0x0
// Checksum 0x55b3a7b6, Offset: 0xaf8
// Size: 0x22c
function function_f5087df2() {
    self waittill(#"objective_ended");
    objective_manager::stop_timer();
    foreach (player in getplayers()) {
        level.var_31028c5d prototype_hud::function_817e4d10(player, 0);
    }
    self.var_4a416ea9 stoploopsound();
    level thread namespace_7589cf5c::function_3899cfea(self.var_4a416ea9.origin, 5000);
    if (self.success) {
        level thread namespace_cda50904::function_a92a93e9(self.var_4a416ea9.var_4d0b3b87.origin, self.var_4a416ea9.var_4d0b3b87.angles);
        self.var_4a416ea9 clientfield::set("" + #"hash_3eeee7f3f5bdb9ff", 1);
        self.var_4a416ea9 playrumbleonentity("sr_prototype_generator_explosion");
        level thread util::delay(2.5, undefined, &globallogic_audio::leader_dialog, "objectiveDefendEndSuccess");
        return;
    }
    self.var_4a416ea9 thread function_b11358ce();
    level thread util::delay(2.5, undefined, &globallogic_audio::leader_dialog, "objectiveDefendEndFailure");
}

// Namespace namespace_bff7ce85/namespace_cb308359
// Params 0, eflags: 0x0
// Checksum 0x5060cfd8, Offset: 0xd30
// Size: 0x7a
function function_86a476ea() {
    self.var_5b4ffff9 = #"objective_defend_ailist_1";
    self.var_48e40408 = #"objective_defend_ailist_2";
    self.var_642e1c7a = #"objective_defend_ailist_3";
    self.var_1a7040e5 = #"objective_defend_ailist_4";
    self.var_161306c3 = #"objective_defend_ailist_5";
}

// Namespace namespace_bff7ce85/namespace_cb308359
// Params 2, eflags: 0x0
// Checksum 0x7268edac, Offset: 0xdb8
// Size: 0x1a0
function defend_start(instance, activator) {
    instance endon(#"objective_ended");
    if (isplayer(activator)) {
        instance.var_4a416ea9 thread function_b9fb6c3a(instance);
        instance.var_4a416ea9 thread function_677356aa(instance);
        activator thread util::delay(2.5, undefined, &globallogic_audio::leader_dialog_on_player, "objectiveDefendStart");
        level thread util::delay(2.5, undefined, &globallogic_audio::leader_dialog, "objectiveDefendStartResponse");
        wait 5;
        foreach (player in getplayers()) {
            level.var_31028c5d prototype_hud::set_active_objective_string(player, #"hash_594c7fecba757862");
            level.var_31028c5d prototype_hud::function_817e4d10(player, 2);
        }
    }
}

// Namespace namespace_bff7ce85/namespace_cb308359
// Params 1, eflags: 0x0
// Checksum 0xf1f32590, Offset: 0xf60
// Size: 0xac
function function_9c54feb0(instance) {
    n_objective_id = gameobjects::get_next_obj_id();
    objective_add(n_objective_id, "active", self.origin + (0, 0, 50), #"hash_48db6906777e28d6");
    self thread function_80ba1bc8(instance, n_objective_id);
    instance waittill(#"objective_ended");
    objective_delete(n_objective_id);
}

// Namespace namespace_bff7ce85/namespace_cb308359
// Params 0, eflags: 0x0
// Checksum 0x638f4f24, Offset: 0x1018
// Size: 0x37c
function function_7cf83691() {
    self endon(#"objective_ended");
    self.var_4272a188 triggerenable(0);
    objective_setinvisibletoall(self.var_e55c8b4e);
    self thread function_5839db26();
    var_43123efe = self.var_43123efe;
    var_43123efe show();
    n_objective_id = gameobjects::get_next_obj_id();
    e_obj = util::spawn_model("tag_origin", var_43123efe.origin + (100, 100, 68));
    objective_add(n_objective_id, "active", e_obj, #"hash_a7e9aa24c3b886d");
    var_f4bd7934 = 0;
    while (true) {
        foreach (player in getplayers()) {
            if (distance2dsquared(var_43123efe.origin, player.origin) <= function_a3f6cdac(500)) {
                var_f4bd7934 = 1;
            }
        }
        if (var_f4bd7934) {
            break;
        }
        wait 1;
    }
    e_obj moveto(var_43123efe.origin + (0, 0, 68), 0.05);
    var_3aee78d5 = spawn("trigger_radius_use", var_43123efe.origin + (0, 0, 64), 0, 96, 96);
    var_3aee78d5 triggerignoreteam();
    var_3aee78d5 setcursorhint("HINT_NOICON");
    var_3aee78d5 sethintstring(#"hash_28e56945b8319509");
    var_3aee78d5 usetriggerrequirelookat(1);
    var_3aee78d5 waittill(#"trigger");
    self notify(#"pickup");
    var_3aee78d5 delete();
    objective_delete(n_objective_id);
    var_43123efe delete();
    self thread function_57cc3128();
}

// Namespace namespace_bff7ce85/namespace_cb308359
// Params 0, eflags: 0x0
// Checksum 0x5ee71432, Offset: 0x13a0
// Size: 0x334
function function_57cc3128() {
    self endon(#"objective_ended");
    foreach (player in getplayers()) {
        level.var_31028c5d prototype_hud::set_active_objective_string(player, #"hash_4546417366cc7a50");
        level.var_31028c5d prototype_hud::function_817e4d10(player, 2);
    }
    var_4a416ea9 = self.var_4a416ea9;
    n_objective_id = gameobjects::get_next_obj_id();
    objective_add(n_objective_id, "active", var_4a416ea9.origin + (0, 0, 30), #"hash_a7e9aa24c3b886d");
    var_7631cbaa = spawn("trigger_radius_use", var_4a416ea9.origin + (0, 0, 24), 0, 96, 96);
    var_7631cbaa triggerignoreteam();
    var_7631cbaa setcursorhint("HINT_NOICON");
    var_7631cbaa sethintstring(#"hash_6442cecaf6cfb0dc");
    var_7631cbaa usetriggerrequirelookat(1);
    s_result = var_7631cbaa waittill(#"trigger");
    var_7631cbaa delete();
    objective_delete(n_objective_id);
    self notify(#"hash_58630d3c070cc829");
    foreach (player in getplayers()) {
        level.var_31028c5d prototype_hud::function_817e4d10(player, 0);
    }
    self.var_4272a188 triggerenable(1);
    self.var_4272a188 useby(s_result.activator);
}

// Namespace namespace_bff7ce85/namespace_cb308359
// Params 0, eflags: 0x0
// Checksum 0xbba08d4a, Offset: 0x16e0
// Size: 0x110
function function_5839db26() {
    self endon(#"objective_ended");
    n_spawns = randomintrange(2, 5);
    a_s_pts = namespace_85745671::function_e4791424(self.var_43123efe.origin, 32, 80, 400);
    for (i = 0; i < n_spawns; i++) {
        if (isdefined(a_s_pts[i])) {
            var_7ecdee63 = function_2631fff1(self, level.var_b48509f9);
            ai_spawned = namespace_85745671::function_9d3ad056(var_7ecdee63, a_s_pts[i].origin, self.var_43123efe.angles, "defend_zombie");
        }
        wait 0.1;
    }
}

// Namespace namespace_bff7ce85/namespace_cb308359
// Params 0, eflags: 0x0
// Checksum 0xbc2ce6ff, Offset: 0x17f8
// Size: 0x9e
function function_662e9068() {
    switch (getplayers().size) {
    case 1:
        var_d7272180 = 10;
        break;
    case 2:
        var_d7272180 = 15;
        break;
    case 3:
        var_d7272180 = 20;
        break;
    case 4:
        var_d7272180 = 25;
        break;
    }
    return var_d7272180;
}

// Namespace namespace_bff7ce85/namespace_cb308359
// Params 1, eflags: 0x0
// Checksum 0xe93aaa04, Offset: 0x18a0
// Size: 0xa4
function function_5f91d0c7(instance) {
    instance endon(#"objective_ended");
    self endon(#"death");
    wait 5.5;
    self thread function_9c54feb0(instance);
    level thread objective_manager::start_timer(180, "defend");
    instance thread function_c043100e(180);
    instance thread function_b3615a60();
}

// Namespace namespace_bff7ce85/namespace_cb308359
// Params 1, eflags: 0x0
// Checksum 0x54bd1c51, Offset: 0x1950
// Size: 0x96
function function_c043100e(n_time) {
    self endon(#"objective_ended");
    while (true) {
        if (n_time == 60) {
            level thread globallogic_audio::leader_dialog("objectiveDefendOneMinute");
        }
        if (n_time == 30) {
            level thread globallogic_audio::leader_dialog("objectiveDefendThirtySeconds");
            return;
        }
        wait 1;
        n_time -= 1;
    }
}

// Namespace namespace_bff7ce85/namespace_cb308359
// Params 1, eflags: 0x0
// Checksum 0x250823ca, Offset: 0x19f0
// Size: 0x384
function function_677356aa(instance) {
    instance endon(#"objective_ended");
    instance.b_pause = 0;
    var_adbef398 = 0;
    level flag::set("obj_defend_start");
    self thread function_763876af(instance);
    self thread function_5f91d0c7(instance);
    self thread function_b3b2e060(instance);
    a_players = getplayers();
    n_players = a_players.size;
    switch (n_players) {
    case 1:
        var_fd6a4001 = 5;
        var_102fe58c = 6;
        var_3b743c0c = 7;
        var_7dbbc09a = 12;
        break;
    case 2:
        var_fd6a4001 = 7;
        var_102fe58c = 9;
        var_3b743c0c = 11;
        var_7dbbc09a = 15;
        break;
    case 3:
        var_fd6a4001 = 9;
        var_102fe58c = 12;
        var_3b743c0c = 15;
        var_7dbbc09a = 18;
        break;
    case 4:
        var_fd6a4001 = 12;
        var_102fe58c = 15;
        var_3b743c0c = 18;
        var_7dbbc09a = 22;
        break;
    }
    self thread function_34ac205(instance, var_fd6a4001, self.var_559503f1, 1);
    wait 15;
    if (math::cointoss()) {
        self thread function_22281e97(instance);
        var_adbef398 = 1;
        var_f8b1c5ab = 0;
    } else {
        self thread function_b682235b(instance);
        var_f8b1c5ab = 1;
    }
    instance waittill(#"wave_start");
    self thread function_34ac205(instance, var_102fe58c, self.var_559503f1, 2);
    wait 20;
    if (is_true(var_adbef398) && !is_true(var_f8b1c5ab)) {
        self thread function_b682235b(instance);
    } else {
        self thread function_22281e97(instance);
    }
    instance waittill(#"wave_start");
    self thread function_34ac205(instance, var_3b743c0c, self.var_559503f1, 3);
    instance waittill(#"wave_start");
    self thread function_34ac205(instance, var_7dbbc09a, self.var_559503f1, 4);
}

// Namespace namespace_bff7ce85/namespace_cb308359
// Params 0, eflags: 0x0
// Checksum 0x59f941a3, Offset: 0x1d80
// Size: 0xa6
function function_b3615a60() {
    self endon(#"objective_ended");
    wait 30;
    self notify(#"wave_done");
    wait 15;
    self notify(#"wave_start");
    wait 35;
    self notify(#"wave_done");
    wait 15;
    self notify(#"wave_start");
    wait 35;
    self notify(#"wave_done");
    wait 15;
    self notify(#"wave_start");
}

// Namespace namespace_bff7ce85/namespace_cb308359
// Params 2, eflags: 0x0
// Checksum 0x3f76b1ce, Offset: 0x1e30
// Size: 0xf2
function function_a2254b83(instance, n_time) {
    instance endon(#"objective_ended", #"wave_done");
    self endon(#"death");
    n_count = 0;
    while (true) {
        a_ai_zombies = getentarray("defend_zombie", "targetname");
        if (!isdefined(a_ai_zombies) || a_ai_zombies.size < 3) {
            instance notify(#"wave_done");
        } else {
            n_count++;
            if (n_count >= n_time) {
                instance notify(#"wave_done");
            }
        }
        wait 1;
    }
}

// Namespace namespace_bff7ce85/namespace_cb308359
// Params 0, eflags: 0x0
// Checksum 0x6ddd7e34, Offset: 0x1f30
// Size: 0x4c
function function_fd68cae4() {
    self endon(#"death");
    if (self.archetype == #"zombie") {
        self namespace_85745671::function_9758722("sprint");
    }
}

// Namespace namespace_bff7ce85/namespace_cb308359
// Params 0, eflags: 0x0
// Checksum 0x6acab37a, Offset: 0x1f88
// Size: 0x176
function function_bf606a73() {
    self endon(#"death");
    self callback::function_d8abfc3d(#"hash_4afe635f36531659", &function_fd68cae4);
    while (true) {
        a_players = getplayers();
        player = array::get_all_closest(self.origin, a_players)[0];
        if (math::cointoss(25)) {
            if (isalive(player)) {
                self.var_ff290a61 = player;
            }
        }
        namespace_85745671::function_744beb04(self);
        if (!isdefined(self.var_b7e90547) && isalive(self) && !isdefined(self.var_b238ef38) && isalive(player)) {
            self.var_b7e90547 = 1;
            awareness::function_c241ef9a(self, player, 15);
        }
        wait 15;
        self.var_ff290a61 = undefined;
        self.var_b7e90547 = undefined;
    }
}

// Namespace namespace_bff7ce85/namespace_cb308359
// Params 4, eflags: 0x0
// Checksum 0x38831e0a, Offset: 0x2108
// Size: 0x264
function function_34ac205(instance, n_active, var_559503f1, n_wave) {
    instance endon(#"objective_ended", #"wave_done");
    self endon(#"death");
    instance.n_wave = n_wave;
    instance.n_active = 0;
    n_spawns = 0;
    var_8ccf092d = 0;
    n_players = getplayers().size;
    n_delay = 1 / n_wave * 3;
    a_s_locs = instance function_94e50668(var_559503f1, n_wave);
    while (true) {
        for (i = 0; i < a_s_locs.size; i++) {
            if (instance.n_active < n_active) {
                var_7ecdee63 = function_2631fff1(instance, level.var_b48509f9);
                if (var_7ecdee63 == #"hash_4f87aa2a203d37d0" && var_8ccf092d >= n_players) {
                    continue;
                }
                if (!instance.b_pause) {
                    ai_spawned = namespace_85745671::function_9d3ad056(var_7ecdee63, a_s_locs[i].origin, a_s_locs[i].angles, "defend_zombie");
                    if (isdefined(ai_spawned)) {
                        if (var_7ecdee63 == #"hash_4f87aa2a203d37d0" && var_8ccf092d < n_players) {
                            var_8ccf092d++;
                        }
                        ai_spawned thread function_bf606a73();
                        ai_spawned thread zombie_death_watcher(instance);
                        instance.n_active++;
                        n_spawns++;
                    }
                }
                if (i >= a_s_locs.size - 1) {
                    i = 0;
                }
            }
            wait n_delay;
        }
        wait 1;
    }
}

// Namespace namespace_bff7ce85/namespace_cb308359
// Params 1, eflags: 0x0
// Checksum 0x455ad3d7, Offset: 0x2378
// Size: 0x212
function function_22281e97(instance) {
    instance endon(#"objective_ended", #"hash_49d2713028fdc353");
    self endon(#"death");
    instance.b_pause = 1;
    n_players = getplayers().size;
    n_total = function_b37294d5(n_players);
    a_s_pts = array::randomize(self.var_a74eba1b);
    i = 0;
    if (level.var_b48509f9 < 2) {
        var_ac011846 = #"objective_dog_molotov_ailist";
    } else if (math::cointoss()) {
        var_ac011846 = #"objective_dog_molotov_ailist";
    } else {
        var_ac011846 = #"objective_dog_plague_ailist";
    }
    for (j = 0; j < n_total; j++) {
        var_6017f33e = namespace_679a22ba::function_ca209564(var_ac011846);
        var_7ecdee63 = var_6017f33e.var_990b33df;
        ai_spawned = namespace_85745671::function_9d3ad056(var_7ecdee63, a_s_pts[i].origin, a_s_pts[i].angles, "defend_zombie");
        if (isdefined(ai_spawned)) {
            ai_spawned thread function_bf606a73();
        }
        i++;
        if (i >= a_s_pts.size - 1) {
            i = 0;
        }
        wait 0.5;
    }
    wait 2;
    instance.b_pause = 0;
}

// Namespace namespace_bff7ce85/namespace_cb308359
// Params 1, eflags: 0x0
// Checksum 0xa2038c79, Offset: 0x2598
// Size: 0x284
function function_b682235b(instance) {
    instance endon(#"objective_ended", #"hash_49d2713028fdc353");
    self endon(#"death");
    n_players = getplayers().size;
    s_pt = array::random(self.var_ac77e384);
    n_spawns = 1;
    if (math::cointoss() && getplayers().size > 1) {
        var_7ecdee63 = #"hash_4f87aa2a203d37d0";
    } else {
        var_7ecdee63 = #"spawner_bo5_avogadro_sr";
        n_spawns = function_f8e69aeb(n_players);
    }
    for (i = 0; i < n_spawns; i++) {
        ai_spawned = namespace_85745671::function_9d3ad056(var_7ecdee63, s_pt.origin, s_pt.angles, "defend_zombie");
        wait 0.1;
        if (isalive(ai_spawned)) {
            ai_spawned.var_12af7864 = 0;
            if (var_7ecdee63 == #"spawner_bo5_avogadro_sr") {
                ai_spawned thread function_3bce0f99(instance, self.var_ac77e384, #"spawner_bo5_avogadro_sr");
            } else if (var_7ecdee63 == #"hash_4f87aa2a203d37d0" && n_players > 2) {
                ai_spawned thread function_3bce0f99(instance, self.var_ac77e384, #"hash_4f87aa2a203d37d0");
            }
            if (var_7ecdee63 == #"hash_4f87aa2a203d37d0" || var_7ecdee63 == #"spawner_bo5_avogadro_sr") {
                ai_spawned thread function_58ec23ca(instance, self);
            }
        }
    }
}

// Namespace namespace_bff7ce85/namespace_cb308359
// Params 3, eflags: 0x0
// Checksum 0x75a7e4d7, Offset: 0x2828
// Size: 0xbe
function function_3bce0f99(instance, var_ac77e384, var_7ecdee63) {
    instance endon(#"objective_ended");
    s_pt = array::random(var_ac77e384);
    self waittill(#"death");
    wait randomfloatrange(2, 3);
    ai_spawned = namespace_85745671::function_9d3ad056(var_7ecdee63, s_pt.origin, s_pt.angles, "defend_zombie");
}

// Namespace namespace_bff7ce85/namespace_cb308359
// Params 1, eflags: 0x0
// Checksum 0x8132b92, Offset: 0x28f0
// Size: 0x86
function function_f8e69aeb(n_players) {
    switch (n_players) {
    case 1:
    case 2:
        var_40b4f16b = 1;
        break;
    case 3:
    case 4:
        var_40b4f16b = 2;
        break;
    }
    return var_40b4f16b;
}

// Namespace namespace_bff7ce85/namespace_cb308359
// Params 1, eflags: 0x0
// Checksum 0x67f8d277, Offset: 0x2980
// Size: 0x9e
function function_b37294d5(n_players) {
    switch (n_players) {
    case 1:
        var_e00b0988 = 4;
        break;
    case 2:
        var_e00b0988 = 6;
        break;
    case 3:
        var_e00b0988 = 8;
        break;
    case 4:
        var_e00b0988 = 10;
        break;
    }
    return var_e00b0988;
}

// Namespace namespace_bff7ce85/namespace_cb308359
// Params 0, eflags: 0x0
// Checksum 0x4b6c6e45, Offset: 0x2a28
// Size: 0x6e
function function_43a1096c() {
    self endon(#"death");
    self.var_aa4b496 = 1;
    self playloopsound(#"hash_1d3eb7370ddcfbfd");
    wait 4.75;
    self stoploopsound();
    self.var_aa4b496 = 0;
}

// Namespace namespace_bff7ce85/namespace_cb308359
// Params 1, eflags: 0x0
// Checksum 0x3054f5f9, Offset: 0x2aa0
// Size: 0xcc
function function_b3b2e060(instance) {
    instance endon(#"objective_ended");
    self endon(#"death");
    var_e967a767 = spawn("script_origin", self.origin);
    wait 2;
    var_e967a767 playsound(#"hash_75e3f14724902164");
    var_e967a767 playloopsound(#"hash_59fb8b1370a411a6", 1);
    var_e967a767 thread function_8afca2ff(instance);
}

// Namespace namespace_bff7ce85/namespace_cb308359
// Params 1, eflags: 0x0
// Checksum 0x49ef0681, Offset: 0x2b78
// Size: 0x3c
function function_8afca2ff(instance) {
    instance waittill(#"objective_ended");
    wait 1;
    self delete();
}

// Namespace namespace_bff7ce85/namespace_cb308359
// Params 2, eflags: 0x0
// Checksum 0x55d6749f, Offset: 0x2bc0
// Size: 0x12a
function function_2631fff1(instance, var_661691aa) {
    switch (var_661691aa) {
    case 1:
        var_6017f33e = namespace_679a22ba::function_ca209564(instance.var_5b4ffff9);
        break;
    case 2:
        var_6017f33e = namespace_679a22ba::function_ca209564(instance.var_48e40408);
        break;
    case 3:
        var_6017f33e = namespace_679a22ba::function_ca209564(instance.var_642e1c7a);
        break;
    case 4:
        var_6017f33e = namespace_679a22ba::function_ca209564(instance.var_1a7040e5);
        break;
    default:
        var_6017f33e = namespace_679a22ba::function_ca209564(instance.var_161306c3);
        break;
    }
    return var_6017f33e.var_990b33df;
}

// Namespace namespace_bff7ce85/namespace_cb308359
// Params 1, eflags: 0x0
// Checksum 0x8ab46592, Offset: 0x2cf8
// Size: 0x38
function zombie_death_watcher(instance) {
    self waittill(#"death");
    if (instance.n_active) {
        instance.n_active--;
    }
}

// Namespace namespace_bff7ce85/namespace_cb308359
// Params 2, eflags: 0x0
// Checksum 0xc0f7bc0b, Offset: 0x2d38
// Size: 0x1c2
function function_94e50668(a_s_pts, n_wave) {
    var_559503f1 = [];
    foreach (s_pt in a_s_pts) {
        if (n_wave == 4) {
            if (s_pt.script_int === 4) {
                var_559503f1[var_559503f1.size] = s_pt;
            }
            continue;
        }
        if (n_wave == 1) {
            if (s_pt.script_int === 1) {
                var_559503f1[var_559503f1.size] = s_pt;
            }
            continue;
        }
        if (n_wave == 2) {
            if (s_pt.script_int === 1 || s_pt.script_int === 2) {
                var_559503f1[var_559503f1.size] = s_pt;
            }
            continue;
        }
        if (n_wave == 3) {
            if (s_pt.script_int === 1 || s_pt.script_int === 2 || s_pt.script_int === 3) {
                var_559503f1[var_559503f1.size] = s_pt;
            }
            continue;
        }
        var_559503f1 = a_s_pts;
    }
    if (!isdefined(var_559503f1)) {
        return a_s_pts;
    }
    var_559503f1 = array::randomize(var_559503f1);
    return var_559503f1;
}

// Namespace namespace_bff7ce85/namespace_cb308359
// Params 1, eflags: 0x0
// Checksum 0x1c2413ab, Offset: 0x2f08
// Size: 0x114
function function_763876af(instance) {
    instance endon(#"objective_ended");
    self endon(#"death");
    self thread function_b70e2a37(instance);
    slots = namespace_85745671::function_bdb2b85b(self, self.origin, self.angles, 50, 5, 16);
    if (!isdefined(slots) || slots.size <= 0) {
        return;
    }
    self.var_b79a8ac7 = {#var_f019ea1a:6000, #slots:slots};
    level.attackables[level.attackables.size] = self;
    level waittill(#"timer_defend");
    objective_manager::objective_ended(instance);
}

// Namespace namespace_bff7ce85/namespace_cb308359
// Params 0, eflags: 0x0
// Checksum 0xa02ee164, Offset: 0x3028
// Size: 0x74
function function_b11358ce() {
    self clientfield::set("" + #"hash_74d70bb7fe52c00", 1);
    self playrumbleonentity("sr_prototype_generator_explosion");
    wait 0.1;
    self delete();
}

// Namespace namespace_bff7ce85/namespace_cb308359
// Params 1, eflags: 0x0
// Checksum 0xb9a00e9d, Offset: 0x30a8
// Size: 0x3c
function function_b70e2a37(instance) {
    instance waittill(#"objective_ended");
    namespace_85745671::function_b70e2a37(self);
}

// Namespace namespace_bff7ce85/namespace_cb308359
// Params 1, eflags: 0x0
// Checksum 0x216d20c5, Offset: 0x30f0
// Size: 0x26c
function function_b9fb6c3a(instance) {
    instance endon(#"objective_ended");
    switch (getplayers().size) {
    case 1:
        self.health = 2800;
        break;
    case 2:
        self.health = 2700;
        break;
    case 3:
        self.health = 2550;
        break;
    case 4:
        self.health = 2400;
        break;
    }
    self.var_aa4b496 = 0;
    self val::set("defend", "takedamage", 1);
    self thread function_51779021(instance, 3, 10);
    while (true) {
        s_result = self waittill(#"damage");
        if (isdefined(s_result.attacker) && isplayer(s_result.attacker)) {
            if (isdefined(s_result.amount)) {
                self.health += s_result.amount;
            }
        } else if (!isplayer(s_result.attacker)) {
            if (!self.var_aa4b496) {
                self thread function_43a1096c();
            }
            self clientfield::increment("" + #"hash_18bcf106c476dfeb");
            if (s_result.mod === "MOD_MELEE") {
                self playsound(#"hash_52e02ca86c5fa117");
            }
        }
        if (self.health <= 0) {
            break;
        }
    }
    objective_manager::objective_ended(instance, 0);
}

// Namespace namespace_bff7ce85/namespace_cb308359
// Params 3, eflags: 0x0
// Checksum 0xd9631421, Offset: 0x3368
// Size: 0x184
function function_51779021(instance, var_63e8f3af = 3, var_321cde74 = 10) {
    instance endon(#"objective_ended");
    self endon(#"death");
    var_3057025e = 0;
    for (var_1a944fca = gettime(); true; var_1a944fca = gettime()) {
        s_result = self waittill(#"damage");
        if (self.health <= 0) {
            break;
        }
        if (isai(s_result.attacker)) {
            var_c4bac09b = gettime() - var_1a944fca;
            if (float(var_c4bac09b) / 1000 < var_63e8f3af) {
                var_3057025e += var_c4bac09b;
            } else {
                var_3057025e = 0;
            }
            if (float(var_3057025e) / 1000 >= var_321cde74) {
                level thread globallogic_audio::leader_dialog("objectiveDefendUnderAttack");
                var_3057025e = 0;
            }
        }
    }
}

// Namespace namespace_bff7ce85/namespace_cb308359
// Params 2, eflags: 0x0
// Checksum 0x8a44f955, Offset: 0x34f8
// Size: 0x260
function function_80ba1bc8(instance, n_objective_id) {
    instance endon(#"objective_ended");
    self endon(#"death");
    n_start_health = self.health;
    var_359ac97a = 0;
    objective_manager::function_91574ec1(level.progress_bar, undefined, undefined, undefined, "timer_stop", 1);
    var_8da3e170 = self.health / n_start_health;
    objective_manager::function_5d1c184(var_8da3e170);
    while (true) {
        var_c3a3ae13 = self.health / n_start_health;
        if (var_c3a3ae13 >= 0 && var_8da3e170 != var_c3a3ae13) {
            objective_manager::function_5d1c184(var_c3a3ae13);
            objective_setprogress(n_objective_id, var_c3a3ae13);
        }
        var_8da3e170 = var_c3a3ae13;
        if (var_c3a3ae13 <= 0.66 && var_c3a3ae13 > 0.33) {
            if (!self clientfield::get("" + #"hash_186c35405f4624bc")) {
                self clientfield::set("" + #"hash_186c35405f4624bc", 1);
            }
        } else if (var_c3a3ae13 <= 0.33) {
            if (!var_359ac97a) {
                var_359ac97a = 1;
                self playloopsound(#"hash_1d3eb7370ddcfbfd");
            }
            if (self clientfield::get("" + #"hash_186c35405f4624bc") == 1) {
                self clientfield::set("" + #"hash_186c35405f4624bc", 2);
            }
        }
        wait 0.1;
    }
}

// Namespace namespace_bff7ce85/namespace_cb308359
// Params 0, eflags: 0x0
// Checksum 0xb3b6c1b3, Offset: 0x3760
// Size: 0xb8
function function_c10cfcb5() {
    wait 2;
    a_ai_zombies = getentarray("defend_zombie", "targetname");
    foreach (ai_zombie in a_ai_zombies) {
        ai_zombie thread cleanup_zombie();
    }
}

// Namespace namespace_bff7ce85/namespace_cb308359
// Params 0, eflags: 0x0
// Checksum 0xd1b0fda1, Offset: 0x3820
// Size: 0x154
function cleanup_zombie() {
    self endon(#"death");
    while (true) {
        wait 0.1;
        a_players = getplayers();
        foreach (player in a_players) {
            if (distance2dsquared(self.origin, player.origin) <= function_a3f6cdac(1000)) {
            }
        }
        break;
    }
    wait randomfloatrange(0.1, 0.5);
    self.allowdeath = 1;
    self kill(undefined, undefined, undefined, undefined, 0, 1);
}

// Namespace namespace_bff7ce85/namespace_cb308359
// Params 2, eflags: 0x0
// Checksum 0x8f7e5539, Offset: 0x3980
// Size: 0x264
function function_58ec23ca(instance, defend_object) {
    self endon(#"death");
    instance endon(#"objective_ended");
    var_dbe41436 = 50;
    var_ca639dc3 = 0;
    var_9543c27c = self.health;
    var_dbe41436 = 40;
    current_target = 0;
    self.time_to_wait = 0;
    self thread function_df9979de(instance);
    self.var_cdf71d99 = 0;
    while (true) {
        if (current_target == 1) {
            current_time = gettime();
            if (isdefined(defend_object)) {
                if (current_time > self.time_to_wait || distance(defend_object.origin, self.origin) > 2500) {
                    if (distance(defend_object.origin, self.origin) > 2500) {
                        self.var_cdf71d99 = gettime() + 8000;
                    } else {
                        self.var_cdf71d99 = gettime() + 3000;
                    }
                    self.var_ff290a61 = undefined;
                    self.attackable = defend_object;
                    current_target = 0;
                }
            }
        } else if (current_target == 0) {
            if (isdefined(self.var_cdf71d99) && self.var_cdf71d99 < gettime()) {
                var_ca639dc3 = var_9543c27c - self.health;
                if (var_ca639dc3 > var_dbe41436) {
                    if (isdefined(self.attacker) && isplayer(self.attacker)) {
                        if (isalive(self.attacker)) {
                            if (distance(self.attacker.origin, self.origin) < 2500) {
                                self.var_ff290a61 = self.attacker;
                                current_target = 1;
                            }
                        }
                    }
                    var_ca639dc3 = 0;
                    var_9543c27c = self.health;
                }
            }
        }
        wait 1;
    }
}

// Namespace namespace_bff7ce85/namespace_cb308359
// Params 1, eflags: 0x4
// Checksum 0x33518d09, Offset: 0x3bf0
// Size: 0x72
function private function_df9979de(instance) {
    self endon(#"death");
    instance endon(#"objective_ended");
    while (true) {
        waitresult = self waittill(#"damage");
        self.time_to_wait = gettime() + 8000;
    }
}

