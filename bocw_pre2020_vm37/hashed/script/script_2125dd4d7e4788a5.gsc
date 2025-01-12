#using script_1029986e2bc8ca8e;
#using script_113dd7f0ea2a1d4f;
#using script_12538a87a80a2978;
#using script_1cc417743d7c262d;
#using script_215d7818c548cb51;
#using script_27347f09888ad15;
#using script_3357acf79ce92f4b;
#using script_3411bb48d41bd3b;
#using script_3751b21462a54a7d;
#using script_4163291d6e693552;
#using script_5f261a5d57de5f7c;
#using script_7fc996fe8678852;
#using scripts\core_common\animation_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\gameobjects_shared;
#using scripts\core_common\laststand_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\util_shared;

#namespace objective_retrieval;

// Namespace objective_retrieval/level_init
// Params 1, eflags: 0x40
// Checksum 0xbd59c195, Offset: 0x398
// Size: 0x10c
function event_handler[level_init] main(*eventstruct) {
    clientfield::register("toplayer", "" + #"hash_24d873496283af6e", 1, 1, "int");
    clientfield::register("scriptmover", "" + #"hash_24d873496283af6e", 1, 1, "int");
    objective_manager::function_b3464a7c(#"retrieval", &init, &function_44ae8976, #"retrieval", #"hash_ed63c368c1fca8f");
    callback::on_laststand(&function_f1ae312a);
}

// Namespace objective_retrieval/objective_retrieval
// Params 1, eflags: 0x0
// Checksum 0x2e863ebf, Offset: 0x4b0
// Size: 0x4f8
function init(instance) {
    instance.var_9caeed13 = [];
    instance.var_344a6a1a = [];
    foreach (s_instance in instance.var_fe2612fe[#"retrieval"]) {
        s_instance.s_start = s_instance.var_fe2612fe[#"hash_55beda67733e86c0"][0];
        s_instance.var_90de5 = namespace_8b6a9d79::spawn_script_model(s_instance, #"hash_572ef2c74e1d80ef");
        s_instance.var_90de5.var_809a5ab9[0] = s_instance.var_fe2612fe[#"component_a"];
        s_instance.var_90de5.var_809a5ab9[1] = s_instance.var_fe2612fe[#"hash_43131190cc1b7b5d"];
        if (isdefined(s_instance.var_fe2612fe[#"hash_7e2234980528a279"])) {
            s_instance.var_1ac40948 = namespace_8b6a9d79::spawn_script_model(s_instance.var_fe2612fe[#"hash_7e2234980528a279"][0], #"hash_2dc80625b5b6627a", 1);
        }
        if (isdefined(s_instance.var_fe2612fe[#"hash_6c270f0e2716312b"])) {
            s_instance.var_90de5.var_7be19157 = namespace_8b6a9d79::spawn_script_model(s_instance.var_fe2612fe[#"hash_6c270f0e2716312b"][0], #"tag_origin", 1);
        }
        for (i = 0; i < 2; i++) {
            var_9ed85498 = array::random(s_instance.var_90de5.var_809a5ab9[i]);
            var_7ec5859c = util::spawn_model(#"hash_3809afadab1ef65f", var_9ed85498.origin, var_9ed85498.angles + (0, -90, 0));
            var_7ec5859c.targetname = "retrieval_component";
            var_7ec5859c.n_id = i;
            var_7ec5859c.n_index = var_9ed85498.script_int;
            instance.var_344a6a1a[instance.var_344a6a1a.size] = var_7ec5859c;
            var_7ec5859c.var_e16d0db5 = namespace_8b6a9d79::spawn_script_model(var_9ed85498, #"hash_35f0729ec291b85b", 1);
            var_7ec5859c.var_e16d0db5.targetname = "retrieval_case";
            var_7ec5859c thread function_6acbc957(instance);
            var_7ec5859c thread function_5238fe78(instance);
            var_7ec5859c thread function_6d863da0(instance);
        }
        s_instance.var_90de5 thread function_d3122380(instance);
    }
    instance.var_1ac40948 = s_instance.var_1ac40948;
    instance.var_4d0b3b87 = s_instance.var_fe2612fe[#"hash_41ae283ea203de66"][0];
    instance.var_90de5 = s_instance.var_90de5;
    instance.var_734a26a4 = s_instance.var_fe2612fe[#"hash_28b58e644a932211"][0];
    instance.var_9a67455 = s_instance.var_fe2612fe[#"hash_99db954262ad107"];
    instance.var_b69e83ca = s_instance.var_fe2612fe[#"hash_3a45264baef61335"];
    instance.var_ba44fadd = s_instance.var_fe2612fe[#"hash_78b9734c21337ad9"];
    instance thread function_eae9567f();
    instance thread function_f5087df2();
    instance.var_4272a188 thread objective_manager::function_98da2ed1(instance.var_4272a188.origin, "objectiveRetrievalApproach");
    instance.var_90de5.var_5542906 = 0;
    instance.n_zombies = 0;
    level.var_5881dcbe = [];
}

// Namespace objective_retrieval/objective_retrieval
// Params 0, eflags: 0x0
// Checksum 0x5738a1db, Offset: 0x9b0
// Size: 0x18c
function function_eae9567f() {
    self.var_90de5 ghost();
    self.var_1ac40948 scene::play(#"p9_fxanim_sv_rocket_take_off_bundle", "Shot 1", self.var_1ac40948);
    self waittill(#"hash_3630518d6dc9aeda");
    self.var_1ac40948 scene::play(#"p9_fxanim_sv_rocket_take_off_bundle", "Shot 2", self.var_1ac40948);
    wait 1;
    self.var_1ac40948 scene::play(#"p9_fxanim_sv_rocket_take_off_bundle", "Shot 3", self.var_1ac40948);
    self waittill(#"objective_ended");
    if (self.success) {
        wait 10;
        self.var_90de5 linkto(self.var_1ac40948, "tag_fx_rocket_exhaust_0");
        self.var_90de5 playrumbleonentity("sr_retrieval_rocket_takeoff");
        self.var_1ac40948 scene::play(#"p9_fxanim_sv_rocket_take_off_bundle", "Shot 4", self.var_1ac40948);
    }
}

// Namespace objective_retrieval/objective_retrieval
// Params 0, eflags: 0x0
// Checksum 0xebda7634, Offset: 0xb48
// Size: 0x298
function function_f5087df2() {
    self waittill(#"objective_ended");
    objective_manager::stop_timer();
    foreach (player in getplayers()) {
        player thread function_f1ae312a();
        level.var_31028c5d thread prototype_hud::function_817e4d10(player, 0);
    }
    if (!self.success) {
        foreach (var_7ec5859c in getentarray("retrieval_component", "targetname")) {
            if (isdefined(var_7ec5859c)) {
                var_7ec5859c delete();
            }
        }
        return;
    }
    self thread objective_manager::stop_timer();
    namespace_cda50904::function_a92a93e9(self.var_4d0b3b87.origin, self.var_4d0b3b87.angles);
    level thread namespace_7589cf5c::function_3899cfea(self.origin, 5000);
    foreach (var_e16d0db5 in getentarray("retrieval_case", "targetname")) {
        if (isdefined(var_e16d0db5)) {
            var_e16d0db5 delete();
        }
    }
}

// Namespace objective_retrieval/objective_retrieval
// Params 1, eflags: 0x0
// Checksum 0x29204bed, Offset: 0xde8
// Size: 0x1f4
function function_d3122380(instance) {
    instance endon(#"objective_ended");
    instance waittill(#"hash_3630518d6dc9aeda");
    instance thread objective_manager::start_timer(300, "retrieval");
    self thread monitor_timer(instance);
    self.var_c1c0db3c = 0;
    self thread function_9c54feb0(instance);
    self thread function_63544551(instance);
    objective_add(self.n_objective_id, "active", self, self.var_805ed574);
    wait 0.1;
    self thread function_9d2e5887(instance);
    instance.var_734a26a4.var_90de5 = self;
    instance.var_734a26a4 gameobjects::init_game_objects(#"sr_obj_retrieval_gameobject");
    instance.var_734a26a4 gameobjects::set_onbeginuse_event(&function_1fc51f74);
    instance.var_734a26a4 gameobjects::set_onenduse_event(&function_c8bfd10b);
    instance.var_734a26a4.mdl_gameobject.script_int = instance.var_734a26a4.script_int;
    instance.var_734a26a4.mdl_gameobject thread function_223e16e6(instance);
    instance.var_734a26a4.mdl_gameobject thread function_b11e170c(instance);
}

// Namespace objective_retrieval/objective_retrieval
// Params 1, eflags: 0x0
// Checksum 0xaaa173f0, Offset: 0xfe8
// Size: 0xcc
function function_1fc51f74(player) {
    if (isplayer(player)) {
        if (!is_true(self.var_dbee315d) && player namespace_e86ffa8::function_efb6dedf(4)) {
            self.var_dbee315d = 1;
            self.var_16d3705c = self.usetime;
            time = float(self.usetime * 0.5) / 1000;
            self gameobjects::set_use_time(time);
        }
    }
}

// Namespace objective_retrieval/objective_retrieval
// Params 3, eflags: 0x0
// Checksum 0x4d0d95a5, Offset: 0x10c0
// Size: 0x4d6
function function_c8bfd10b(*str_team, e_player, b_result) {
    if (b_result) {
        var_67aa3392 = e_player.var_67aa3392;
        v_org = self.e_object.origin;
        v_ang = self.e_object.angles;
        level.var_31028c5d prototype_hud::function_4dfb5783(e_player, 0);
        var_fe043be4 = util::spawn_model(#"hash_1744560d6ac554dc", self.e_object.origin);
        e_player clientfield::set_to_player("" + #"hash_24d873496283af6e", 0);
        e_player.var_5bf2e751 = 0;
        e_player notify(#"hash_6d2d12b8afe43c8e");
        e_player detach(#"hash_21d86a803010e3e9", "tag_stowed_back");
        e_player.var_67aa3392 = undefined;
        e_player thread function_bd0bc40b(0);
        e_player thread globallogic_audio::leader_dialog_on_player("objectiveRetrievalBatteryInstalled");
        if (isinarray(level.var_5881dcbe, e_player)) {
            arrayremovevalue(level.var_5881dcbe, e_player);
        }
        var_67aa3392 rotateto(self.e_object.angles, 0.05);
        var_67aa3392 moveto(self.e_object.origin, 0.05);
        var_67aa3392 waittill(#"movedone");
        var_67aa3392 show();
        var_67aa3392 notify(#"installed");
        var_67aa3392 notify(#"hash_2ccfddebdf6bcf98");
        var_67aa3392.var_2e5efdc7 = 1;
        var_67aa3392.var_3aee78d5 delete();
        self.e_object.var_90de5 notify(#"installed", {#player:e_player});
        var_9caeed13 = getentarray("retrieval_component", "targetname");
        foreach (var_7ec5859c in var_9caeed13) {
            if (var_7ec5859c != var_67aa3392 && isdefined(var_7ec5859c.n_objective_id) && !is_true(var_7ec5859c.var_2e5efdc7)) {
                objective_setvisibletoplayer(var_7ec5859c.n_objective_id, e_player);
            }
        }
        if (isdefined(var_fe043be4)) {
            var_fe043be4 thread function_457be561(v_org, v_ang);
        }
        var_67aa3392 thread function_457be561(v_org, v_ang);
        if (self.e_object.var_90de5.var_c1c0db3c > 1) {
            self gameobjects::destroy_object(1, 1);
            wait 5;
        } else {
            self.e_object.var_90de5.var_5542906 = 1;
            wait 5;
            self.e_object.var_90de5.var_5542906 = 0;
        }
        return;
    }
    if (isdefined(self.var_16d3705c)) {
        self.var_dbee315d = 0;
        self gameobjects::set_use_time(self.var_16d3705c);
        self.var_16d3705c = undefined;
    }
}

// Namespace objective_retrieval/objective_retrieval
// Params 2, eflags: 0x0
// Checksum 0xe5fab0e1, Offset: 0x15a0
// Size: 0x1fc
function function_457be561(v_org, v_ang) {
    if (is_true(self.var_2e5efdc7)) {
        self scene::play(#"p9_fxanim_sv_canister_pod_bundle", self);
        self scene::stop();
        self setmodel(#"hash_21d86a803010e3e9");
    } else {
        self rotateyaw(90, 0.05);
    }
    v_forward = vectornormalize(anglestoforward(v_ang)) * 20;
    v_org += v_forward;
    self moveto(v_org, 0.05);
    self waittill(#"movedone");
    if (is_true(self.var_2e5efdc7)) {
        v_launch = v_forward * 0.2 + (self.n_id, self.n_id, randomintrange(10, 13));
    } else {
        v_launch = v_forward * 0.15 + (randomintrange(1, 3), randomintrange(1, 3), 5);
    }
    self physicslaunch(self.origin, v_launch);
}

// Namespace objective_retrieval/objective_retrieval
// Params 1, eflags: 0x0
// Checksum 0xa3f1f492, Offset: 0x17a8
// Size: 0x5c
function function_b11e170c(instance) {
    self endon(#"death");
    instance waittill(#"objective_ended");
    if (isdefined(self)) {
        self gameobjects::destroy_object(1, 1);
    }
}

// Namespace objective_retrieval/objective_retrieval
// Params 1, eflags: 0x0
// Checksum 0x93195cff, Offset: 0x1810
// Size: 0x26c
function function_63544551(instance) {
    instance endon(#"objective_ended");
    while (true) {
        s_waitresult = self waittill(#"installed");
        self.var_c1c0db3c++;
        if (self.var_c1c0db3c === 1) {
            self thread function_f4562137(instance);
        } else if (self.var_c1c0db3c === 2) {
            foreach (player in getplayers()) {
                level.var_31028c5d prototype_hud::function_817e4d10(player, 0);
            }
            level thread namespace_7589cf5c::function_3899cfea(self.origin, 30000);
            s_waitresult.player thread util::delay(2.5, undefined, &globallogic_audio::leader_dialog_on_player, "objectiveRetrievalEndSuccess");
            level thread util::delay(2.5, undefined, &globallogic_audio::leader_dialog, "objectiveRetrievalEndSuccessResponse");
            objective_manager::objective_ended(instance);
        }
        foreach (player in getplayers()) {
            player luinotifyevent(#"hash_5159e35a62fb7083", 2, 3, 1);
        }
    }
}

// Namespace objective_retrieval/objective_retrieval
// Params 1, eflags: 0x0
// Checksum 0xa8bbacf7, Offset: 0x1a88
// Size: 0x164
function function_223e16e6(instance) {
    instance endon(#"objective_ended");
    while (true) {
        foreach (player in getplayers()) {
            if (is_true(player.var_5bf2e751) && !instance.var_90de5.var_5542906) {
                self gameobjects::function_664b40(player);
                objective_setinvisibletoplayer(instance.var_90de5.n_objective_id, player);
                continue;
            }
            self gameobjects::function_7a00d78c(player);
            objective_setvisibletoplayer(instance.var_90de5.n_objective_id, player);
        }
        wait 0.25;
    }
}

// Namespace objective_retrieval/objective_retrieval
// Params 1, eflags: 0x0
// Checksum 0xf7dc1e0a, Offset: 0x1bf8
// Size: 0x1f4
function function_f4562137(instance) {
    instance endon(#"objective_ended");
    self.var_7be19157.n_objective_id = gameobjects::get_next_obj_id();
    self.var_7be19157.var_db7449cf = #"hash_336d05892f9a780e";
    objective_add(self.var_7be19157.n_objective_id, "active", self.var_7be19157, self.var_7be19157.var_db7449cf);
    while (true) {
        foreach (player in getplayers()) {
            if (is_true(player.var_5bf2e751) && !self.var_5542906) {
                objective_setinvisibletoplayer(self.var_7be19157.n_objective_id, player);
                continue;
            }
            if (is_true(player.var_5bf2e751)) {
                objective_setvisibletoplayer(self.var_7be19157.n_objective_id, player);
                continue;
            }
            objective_setinvisibletoplayer(self.var_7be19157.n_objective_id, player);
        }
        wait 0.25;
    }
}

// Namespace objective_retrieval/objective_retrieval
// Params 1, eflags: 0x0
// Checksum 0x218fb539, Offset: 0x1df8
// Size: 0x21c
function monitor_timer(instance) {
    instance endon(#"objective_ended");
    level waittill(#"hash_4aac43df22b1d42d");
    self thread function_54ad8bd3(instance);
    var_42f3b393 = 0;
    while (true) {
        var_dc9a9acc = 0;
        foreach (var_7ec5859c in instance.var_9caeed13) {
            if (is_true(var_7ec5859c.b_pickedup) || is_true(var_7ec5859c.var_2e5efdc7)) {
                var_dc9a9acc++;
            }
        }
        if (var_dc9a9acc < 2) {
            break;
        }
        if (!var_42f3b393) {
            var_42f3b393 = 1;
            foreach (player in getplayers()) {
                player thread namespace_77bd50da::function_cc8342e0(#"hash_6a89bb99e54d4e8f", 8);
            }
        }
        waitframe(1);
    }
    wait 0.2;
    objective_manager::objective_ended(instance, 0);
}

// Namespace objective_retrieval/objective_retrieval
// Params 1, eflags: 0x0
// Checksum 0xa4a49fa1, Offset: 0x2020
// Size: 0x188
function function_54ad8bd3(instance) {
    instance endon(#"objective_ended");
    wait 0.3;
    foreach (var_7ec5859c in instance.var_9caeed13) {
        if (!var_7ec5859c.b_pickedup && !var_7ec5859c.var_2e5efdc7) {
            foreach (player in getplayers()) {
                player thread function_f1ae312a();
                level.var_31028c5d prototype_hud::function_817e4d10(player, 0);
            }
            objective_manager::objective_ended(instance, 0);
        }
    }
}

// Namespace objective_retrieval/objective_retrieval
// Params 1, eflags: 0x0
// Checksum 0x705568d9, Offset: 0x21b0
// Size: 0x354
function function_6acbc957(instance) {
    instance endon(#"objective_ended");
    self endon(#"death");
    instance.var_9caeed13[instance.var_9caeed13.size] = self;
    self hide();
    self notsolid();
    self.b_pickedup = 0;
    self.var_2e5efdc7 = 0;
    self rotateyaw(90, 0.05);
    self.var_e16d0db5 hide();
    self.var_e16d0db5 notsolid();
    instance waittill(#"hash_3630518d6dc9aeda");
    self.var_e16d0db5 show();
    self.var_3aee78d5 = spawn("trigger_radius_use", self.origin + (0, 0, 24), 0, 96, 96);
    self.var_3aee78d5 triggerignoreteam();
    self.var_3aee78d5 setcursorhint("HINT_NOICON");
    self.var_3aee78d5 sethintstring(#"hash_c90fb1f338973f7");
    self.var_3aee78d5 usetriggerrequirelookat(1);
    self.var_3aee78d5 enablelinkto();
    self.var_3aee78d5 linkto(self);
    self.var_3aee78d5 triggerenable(0);
    self.var_1b32f535 = spawn("trigger_radius_use", self.origin + (0, 0, 24), 0, 96, 96);
    self.var_1b32f535 triggerignoreteam();
    self.var_1b32f535 setcursorhint("HINT_NOICON");
    self.var_1b32f535 sethintstring(#"hash_110f0b36c2354f6b");
    self.var_1b32f535 usetriggerrequirelookat(1);
    self thread function_9c54feb0(instance);
    self thread function_20ab9060(instance);
    self thread function_95aeefa7(instance);
    self waittill(#"ready");
    self.var_3aee78d5 triggerenable(1);
}

// Namespace objective_retrieval/objective_retrieval
// Params 1, eflags: 0x0
// Checksum 0x1c455656, Offset: 0x2510
// Size: 0x2c0
function function_5238fe78(instance) {
    instance endon(#"objective_ended");
    self endon(#"death", #"hash_3e146dbb1f7248f8");
    instance waittill(#"hash_3630518d6dc9aeda");
    n_spawns = function_e97e2683(1);
    n_spawned = 0;
    foreach (var_2064decc in instance.var_9a67455) {
        if (var_2064decc.script_int === self.n_index) {
            s_pt = var_2064decc;
        }
    }
    if (!isdefined(s_pt)) {
        return;
    }
    a_s_pts = namespace_85745671::function_e4791424(s_pt.origin, 32, 80, s_pt.radius);
    while (true) {
        while (instance.n_zombies >= instance.n_max_zombies) {
            wait 0.1;
        }
        if (isdefined(s_pt)) {
            var_7ecdee63 = function_aece4588(level.var_b48509f9);
            s_spawnpt = array::random(a_s_pts);
            wait randomfloatrange(0.1, 0.3);
            if (isdefined(s_spawnpt)) {
                ai_spawned = namespace_85745671::function_9d3ad056(var_7ecdee63, s_pt.origin, self.angles, "retrieval_zombie");
                wait 0.1;
                if (isalive(ai_spawned)) {
                    instance.n_zombies++;
                    n_spawned++;
                    if (n_spawned >= n_spawns) {
                        self notify(#"hash_3e146dbb1f7248f8");
                    }
                    ai_spawned thread zombie_death_watcher(instance);
                    ai_spawned thread function_bf606a73();
                }
            }
        }
        wait 0.1;
    }
}

// Namespace objective_retrieval/objective_retrieval
// Params 1, eflags: 0x0
// Checksum 0x3056d354, Offset: 0x27d8
// Size: 0x1e8
function function_9d2e5887(instance) {
    instance endon(#"objective_ended", #"defend");
    instance waittill(#"hash_3630518d6dc9aeda");
    n_spawns = function_e97e2683(1);
    n_spawned = 0;
    a_s_pts = instance.var_b69e83ca;
    while (true) {
        while (instance.n_zombies >= instance.n_max_zombies) {
            wait 0.1;
        }
        s_pt = array::random(a_s_pts);
        if (isdefined(s_pt)) {
            var_7ecdee63 = function_aece4588(level.var_b48509f9);
            wait randomfloatrange(0.1, 0.3);
            ai_spawned = namespace_85745671::function_9d3ad056(var_7ecdee63, s_pt.origin, self.angles, "retrieval_zombie");
            wait 0.1;
            if (isdefined(ai_spawned)) {
                instance.n_zombies++;
                n_spawned++;
                if (isalive(ai_spawned)) {
                    ai_spawned.var_b4e37a30 = 1;
                    ai_spawned thread zombie_death_watcher(instance);
                    ai_spawned thread function_bf606a73();
                }
            }
        }
        wait 0.1;
    }
}

// Namespace objective_retrieval/objective_retrieval
// Params 1, eflags: 0x0
// Checksum 0xa9a615de, Offset: 0x29c8
// Size: 0x2cc
function function_6d863da0(instance) {
    self endon(#"death", #"hash_2376553f8598c3f8");
    instance endon(#"objective_ended");
    self.var_c948271a = 0;
    self.var_d7272180 = 0;
    instance waittill(#"hash_3630518d6dc9aeda");
    n_spawns = function_e97e2683();
    a_s_pts = namespace_85745671::function_e4791424(self.origin, 32, 80, 400);
    if (isdefined(a_s_pts)) {
        var_559503f1 = array::randomize(a_s_pts);
    }
    while (!self.var_c948271a) {
        foreach (player in getplayers()) {
            if (distance2dsquared(self.origin, player.origin) <= function_a3f6cdac(3000)) {
                self.var_c948271a = 1;
            }
        }
        wait 0.5;
    }
    while (true) {
        for (i = 0; i < n_spawns; i++) {
            if (isdefined(var_559503f1[i])) {
                var_7ecdee63 = function_aece4588(level.var_b48509f9);
                ai_spawned = namespace_85745671::function_9d3ad056(var_7ecdee63, var_559503f1[i].origin, self.angles, "retrieval_zombie");
                wait 0.1;
                if (isdefined(ai_spawned)) {
                    self.var_d7272180++;
                    instance.n_zombies++;
                    ai_spawned thread zombie_death_watcher(instance);
                    if (self.var_d7272180 >= n_spawns) {
                        self notify(#"hash_2376553f8598c3f8");
                    }
                }
            }
        }
        wait 0.1;
    }
}

// Namespace objective_retrieval/objective_retrieval
// Params 0, eflags: 0x0
// Checksum 0x4e60e3d2, Offset: 0x2ca0
// Size: 0x88
function function_d153c0f0() {
    self endon(#"objective_ended");
    while (true) {
        if (self.n_zombies < self.n_max_zombies) {
            s_pt = array::random(self.var_ba44fadd);
            if (isdefined(s_pt)) {
                self thread function_dd9b1007(s_pt.origin);
            }
        }
        wait 0.1;
    }
}

// Namespace objective_retrieval/objective_retrieval
// Params 1, eflags: 0x0
// Checksum 0x9ebf3248, Offset: 0x2d30
// Size: 0xe4
function function_dd9b1007(var_3955def4) {
    self endon(#"objective_ended");
    var_7ecdee63 = function_aece4588(level.var_b48509f9);
    wait randomfloatrange(0.1, 0.3);
    ai_spawned = namespace_85745671::function_9d3ad056(var_7ecdee63, var_3955def4, self.angles, "retrieval_zombie");
    wait 0.1;
    if (isdefined(ai_spawned)) {
        self.n_zombies++;
        ai_spawned thread function_bf606a73();
        ai_spawned thread zombie_death_watcher(self);
    }
}

// Namespace objective_retrieval/objective_retrieval
// Params 1, eflags: 0x0
// Checksum 0x3c070891, Offset: 0x2e20
// Size: 0xee
function function_95aeefa7(instance) {
    instance endon(#"objective_ended");
    self.var_1b32f535 waittill(#"trigger");
    self.var_1b32f535 delete();
    self.var_e16d0db5 scene::play(#"hash_3014af291c7bce4d", "Shot 1", self.var_e16d0db5);
    self.var_e16d0db5 hidepart("p9_sur_console_control_01_canister_jnt", "", 1);
    self show();
    self notify(#"ready");
}

// Namespace objective_retrieval/objective_retrieval
// Params 1, eflags: 0x0
// Checksum 0x31edbd1e, Offset: 0x2f18
// Size: 0x560
function function_20ab9060(instance) {
    self endon(#"installed", #"death");
    instance endon(#"objective_ended");
    while (true) {
        s_result = self.var_3aee78d5 waittill(#"trigger");
        e_activator = s_result.activator;
        if (isdefined(e_activator) && isplayer(e_activator) && !is_true(e_activator.var_5bf2e751) && !is_true(self.b_pickedup)) {
            player = e_activator;
            foreach (e_player in getplayers()) {
                if (e_player != player) {
                    self.var_3aee78d5 setinvisibletoplayer(e_player);
                }
            }
            var_9caeed13 = getentarray("retrieval_component", "targetname");
            foreach (var_7ec5859c in var_9caeed13) {
                if (var_7ec5859c != self) {
                    objective_setinvisibletoplayer(var_7ec5859c.n_objective_id, player);
                }
            }
            self.b_pickedup = 1;
            tagname = "tag_stowed_back";
            if (!player haspart(tagname)) {
                tagname = undefined;
            }
            self linkto(player, tagname);
            self hide();
            self.var_3aee78d5 usetriggerrequirelookat(0);
            self.var_3aee78d5 sethintstring(#"hash_1bdc30d1c55f4de");
            objective_add(self.n_objective_id, "active", player, self.var_805ed574);
            objective_setinvisibletoplayer(self.n_objective_id, player);
            level.var_31028c5d prototype_hud::function_4dfb5783(player, 1);
            player.var_5bf2e751 = 1;
            player.var_67aa3392 = self;
            player attach(#"hash_21d86a803010e3e9", "tag_stowed_back");
            player clientfield::set_to_player("" + #"hash_24d873496283af6e", 1);
            if (!isinarray(level.var_5881dcbe, player)) {
                if (!isdefined(level.var_5881dcbe)) {
                    level.var_5881dcbe = [];
                } else if (!isarray(level.var_5881dcbe)) {
                    level.var_5881dcbe = array(level.var_5881dcbe);
                }
                level.var_5881dcbe[level.var_5881dcbe.size] = player;
            }
            if (!is_true(player.var_7cd1b025)) {
                player.var_7cd1b025 = 1;
                player thread globallogic_audio::leader_dialog_on_player("objectiveRetrievalBatteryCollected");
                instance thread function_d153c0f0();
                instance notify(#"defend");
            }
            player thread function_bd0bc40b(1);
            player thread function_61ee3ab0(instance, self);
            player thread function_50a7d571(self);
            player thread function_40285fbe(instance);
        }
    }
}

// Namespace objective_retrieval/objective_retrieval
// Params 1, eflags: 0x0
// Checksum 0x57631a6d, Offset: 0x3480
// Size: 0x156
function function_40285fbe(instance) {
    instance endon(#"objective_ended");
    self endon(#"disconnect", #"player_downed", #"hash_6d2d12b8afe43c8e");
    while (true) {
        if (distance2dsquared(instance.var_fe2612fe[#"retrieval"][0].var_90de5.origin, self.origin) < function_a3f6cdac(100) && is_true(self.var_5bf2e751)) {
            if (isdefined(self.var_67aa3392.var_3aee78d5)) {
                self.var_67aa3392.var_3aee78d5 setinvisibletoplayer(self);
            }
        } else if (isdefined(self.var_67aa3392.var_3aee78d5)) {
            self.var_67aa3392.var_3aee78d5 setvisibletoplayer(self);
        }
        waitframe(1);
    }
}

// Namespace objective_retrieval/objective_retrieval
// Params 1, eflags: 0x0
// Checksum 0x9e1758e1, Offset: 0x35e0
// Size: 0x7e
function function_50a7d571(*var_67aa3392) {
    self endon(#"disconnect", #"player_downed", #"hash_6d2d12b8afe43c8e");
    while (true) {
        if (self stancebuttonpressed()) {
            self thread function_f1ae312a();
        }
        waitframe(1);
    }
}

// Namespace objective_retrieval/objective_retrieval
// Params 1, eflags: 0x0
// Checksum 0x849a0d24, Offset: 0x3668
// Size: 0x174
function function_bd0bc40b(b_enabled) {
    if (b_enabled) {
        self allowjump(0);
        self allowsprint(0);
        self allowcrouch(0);
        self allowprone(0);
        self setstance("stand");
        if (getplayers().size < 2) {
            self setmovespeedscale(0.8);
        } else {
            self setmovespeedscale(0.7);
        }
        return;
    }
    self allowjump(1);
    self allowsprint(1);
    self allowcrouch(1);
    self allowprone(1);
    self setmovespeedscale(1);
}

// Namespace objective_retrieval/objective_retrieval
// Params 1, eflags: 0x0
// Checksum 0x52460a6d, Offset: 0x37e8
// Size: 0x54
function zombie_death_watcher(instance) {
    instance endon(#"objective_ended");
    self waittill(#"death");
    if (isdefined(instance.n_zombies)) {
        instance.n_zombies--;
    }
}

// Namespace objective_retrieval/objective_retrieval
// Params 0, eflags: 0x0
// Checksum 0xc8f21b22, Offset: 0x3848
// Size: 0x9e
function function_d583b222() {
    switch (getplayers().size) {
    case 1:
        n_spawns = 8;
        break;
    case 2:
        n_spawns = 12;
        break;
    case 3:
        n_spawns = 15;
        break;
    case 4:
        n_spawns = 22;
        break;
    }
    return n_spawns;
}

// Namespace objective_retrieval/objective_retrieval
// Params 1, eflags: 0x0
// Checksum 0x9313a3e7, Offset: 0x38f0
// Size: 0xf6
function function_e97e2683(b_initial) {
    switch (getplayers().size) {
    case 1:
        if (!isdefined(b_initial)) {
            n_spawns = 8;
        } else {
            n_spawns = 10;
        }
        break;
    case 2:
        if (!isdefined(b_initial)) {
            n_spawns = 14;
        } else {
            n_spawns = 16;
        }
        break;
    case 3:
        if (!isdefined(b_initial)) {
            n_spawns = 16;
        } else {
            n_spawns = 18;
        }
        break;
    case 4:
        if (!isdefined(b_initial)) {
            n_spawns = 18;
        } else {
            n_spawns = 20;
        }
        break;
    }
    return n_spawns;
}

// Namespace objective_retrieval/objective_retrieval
// Params 0, eflags: 0x0
// Checksum 0xb209688e, Offset: 0x39f0
// Size: 0x1ee
function function_bf606a73() {
    self endon(#"death");
    self callback::function_d8abfc3d(#"hash_4afe635f36531659", &function_fd68cae4);
    while (true) {
        a_players = array::randomize(getplayers());
        for (i = 0; i < a_players.size; i++) {
            if (is_true(a_players[i].var_5bf2e751)) {
                if (is_true(self.var_b7e90547) && isalive(self) && isalive(a_players[i])) {
                    self.var_b7e90547 = 1;
                    awareness::function_c241ef9a(self, a_players[i], 30);
                    break;
                }
            }
        }
        if (!isdefined(self.var_b7e90547) && isalive(self)) {
            player = array::random(getplayers());
            if (isalive(player)) {
                self.var_b7e90547 = 1;
                awareness::function_c241ef9a(self, player, 30);
            }
        }
        wait 30;
        self.var_b7e90547 = undefined;
    }
}

// Namespace objective_retrieval/objective_retrieval
// Params 0, eflags: 0x0
// Checksum 0xc44e0f19, Offset: 0x3be8
// Size: 0x6c
function function_fd68cae4() {
    if (self.archetype == #"zombie") {
        if (isdefined(self.var_b4e37a30)) {
            self namespace_85745671::function_9758722("super_sprint");
        }
        self namespace_85745671::function_9758722("sprint");
    }
}

// Namespace objective_retrieval/objective_retrieval
// Params 2, eflags: 0x0
// Checksum 0x9af27c6a, Offset: 0x3c60
// Size: 0x3b0
function function_61ee3ab0(instance, var_7ec5859c) {
    instance endon(#"objective_ended");
    self endon(#"disconnect");
    var_7ec5859c endon(#"installed");
    self waittill(#"hash_6d2d12b8afe43c8e");
    v_point = getclosestpointonnavmesh(self.origin, 120, 16);
    if (isdefined(v_point)) {
        v_ground = groundtrace(v_point + (0, 0, 50), v_point + (0, 0, -1000), 1, self)[#"position"];
    }
    if (!isdefined(v_ground)) {
        v_ground = self.origin;
    }
    var_7ec5859c.b_pickedup = 0;
    var_7ec5859c unlink();
    var_7ec5859c moveto(v_ground + (0, 0, -31), 0.05);
    var_7ec5859c waittill(#"movedone");
    var_7ec5859c show();
    var_7ec5859c.angles = (0, 0, 0);
    var_7ec5859c.var_3aee78d5 usetriggerrequirelookat(1);
    var_7ec5859c.var_3aee78d5 sethintstring(#"hash_c90fb1f338973f7");
    objective_add(var_7ec5859c.n_objective_id, "active", var_7ec5859c, var_7ec5859c.var_805ed574);
    foreach (player in getplayers()) {
        var_7ec5859c.var_3aee78d5 setvisibletoplayer(player);
    }
    objective_setvisibletoplayer(var_7ec5859c.n_objective_id, self);
    var_9caeed13 = getentarray("retrieval_component", "targetname");
    foreach (var_67aa3392 in var_9caeed13) {
        if (var_67aa3392 != var_7ec5859c && isdefined(var_67aa3392.n_objective_id) && !is_true(var_67aa3392.var_2e5efdc7)) {
            objective_setvisibletoplayer(var_67aa3392.n_objective_id, player);
        }
    }
}

// Namespace objective_retrieval/objective_retrieval
// Params 0, eflags: 0x0
// Checksum 0xb683564c, Offset: 0x4018
// Size: 0x11c
function function_f1ae312a() {
    if (is_true(self.var_5bf2e751)) {
        level.var_31028c5d prototype_hud::function_4dfb5783(self, 0);
        self clientfield::set_to_player("" + #"hash_24d873496283af6e", 0);
        self.var_5bf2e751 = 0;
        self.var_67aa3392 = undefined;
        self detach(#"hash_21d86a803010e3e9", "tag_stowed_back");
        self notify(#"hash_6d2d12b8afe43c8e");
        self thread function_bd0bc40b(0);
        self thread function_1c0f0238();
        if (isinarray(level.var_5881dcbe, self)) {
            arrayremovevalue(level.var_5881dcbe, self);
        }
    }
}

// Namespace objective_retrieval/objective_retrieval
// Params 0, eflags: 0x0
// Checksum 0x601f7723, Offset: 0x4140
// Size: 0x6c
function function_1c0f0238() {
    self notify("38f322d9cdc678");
    self endon("38f322d9cdc678");
    self endon(#"disconnect");
    waitframe(1);
    if (self laststand::player_is_in_laststand()) {
        self thread globallogic_audio::leader_dialog_on_player("objectiveRetrievalBatteryDropped");
    }
}

// Namespace objective_retrieval/objective_retrieval
// Params 2, eflags: 0x0
// Checksum 0x3dbdd745, Offset: 0x41b8
// Size: 0x218
function function_44ae8976(instance, activator) {
    if (isplayer(activator)) {
        instance notify(#"hash_3630518d6dc9aeda");
        activator thread util::delay(2.5, undefined, &globallogic_audio::leader_dialog_on_player, "objectiveRetrievalStart");
        level thread util::delay(2.5, undefined, &globallogic_audio::leader_dialog, "objectiveRetrievalStartResponse");
        foreach (player in getplayers()) {
            level.var_31028c5d prototype_hud::function_7491d6c5(player, #"hash_69606c9e75f74ab0");
        }
        instance.n_max_zombies = function_d583b222();
        wait 6;
        foreach (player in getplayers()) {
            level.var_31028c5d prototype_hud::set_active_objective_string(player, #"hash_69606c9e75f74ab0");
            level.var_31028c5d prototype_hud::function_817e4d10(player, 2);
        }
    }
}

// Namespace objective_retrieval/objective_retrieval
// Params 1, eflags: 0x0
// Checksum 0xf08dbdb8, Offset: 0x43d8
// Size: 0x1ec
function function_9c54feb0(instance) {
    instance endon(#"objective_ended");
    self.n_objective_id = gameobjects::get_next_obj_id();
    if (!isdefined(self.n_id)) {
        self.var_805ed574 = #"hash_449cd1c65196f3a8";
    } else {
        switch (self.n_id) {
        case 0:
            self.var_805ed574 = #"hash_3084c6ecc7696cb4";
            self.var_7017d40 = #"hash_2fc69f49d36f4c3c";
            break;
        case 1:
            self.var_805ed574 = #"hash_3084c9ecc76971cd";
            self.var_7017d40 = #"hash_2fc6a249d36f5155";
            break;
        }
    }
    self thread function_b4184b43(instance);
    if (isdefined(self.n_id)) {
        objective_add(self.n_objective_id, "active", self, self.var_805ed574);
        self waittill(#"ready");
        objective_delete(self.n_objective_id);
        self.n_objective_id = gameobjects::get_next_obj_id();
        objective_add(self.n_objective_id, "active", self, self.var_7017d40);
        self waittill(#"installed");
        objective_delete(self.n_objective_id);
    }
}

// Namespace objective_retrieval/objective_retrieval
// Params 1, eflags: 0x0
// Checksum 0xd64ed772, Offset: 0x45d0
// Size: 0xd4
function function_b4184b43(instance) {
    self endon(#"death");
    instance waittill(#"objective_ended");
    wait 0.1;
    if (isdefined(self.n_objective_id)) {
        objective_delete(self.n_objective_id);
    }
    if (isdefined(self.var_3aee78d5)) {
        self.var_3aee78d5 delete();
    }
    if (isdefined(self) && !is_true(self.var_2e5efdc7) && isdefined(self.n_id)) {
        self delete();
    }
}

// Namespace objective_retrieval/objective_retrieval
// Params 1, eflags: 0x0
// Checksum 0x5fb428ec, Offset: 0x46b0
// Size: 0xe6
function function_aece4588(var_3afe334f) {
    switch (var_3afe334f) {
    case 1:
        var_e7a1cbae = #"objective_retrieval_ailist_1";
        break;
    case 2:
        var_e7a1cbae = #"objective_retrieval_ailist_2";
        break;
    case 3:
        var_e7a1cbae = #"objective_retrieval_ailist_3";
        break;
    default:
        var_e7a1cbae = #"objective_retrieval_ailist_4";
        break;
    }
    var_6017f33e = namespace_679a22ba::function_ca209564(var_e7a1cbae);
    return var_6017f33e.var_990b33df;
}

