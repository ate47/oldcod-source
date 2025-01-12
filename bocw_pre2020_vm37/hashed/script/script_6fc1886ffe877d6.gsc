#using script_1029986e2bc8ca8e;
#using script_113dd7f0ea2a1d4f;
#using script_12538a87a80a2978;
#using script_1cd491b1807da8f7;
#using script_27347f09888ad15;
#using script_3357acf79ce92f4b;
#using script_3411bb48d41bd3b;
#using script_4163291d6e693552;
#using script_5a525a75a8f1f7e4;
#using script_6b2d896ac43eb90;
#using script_7c3f86aa290a6354;
#using script_7fc996fe8678852;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\gestures;
#using scripts\core_common\math_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\zm_common\zm_barricade;
#using scripts\zm_common\zm_fasttravel;

#namespace namespace_4db53432;

// Namespace namespace_4db53432/level_init
// Params 1, eflags: 0x40
// Checksum 0x3bab2a27, Offset: 0x540
// Size: 0xfc
function event_handler[level_init] main(*eventstruct) {
    clientfield::register("toplayer", "" + #"hash_69409daf95eb8ffe", 1, 1, "int");
    clientfield::register("scriptmover", "" + #"hash_7a1ca107322a0dbc", 1, 1, "counter");
    start_hint = #"hash_ccc16cf6360464b";
    objective_manager::function_b3464a7c(#"holdout", &init, &function_f16ac62c, #"holdout", start_hint);
}

// Namespace namespace_4db53432/namespace_4db53432
// Params 1, eflags: 0x0
// Checksum 0xaa0382fd, Offset: 0x648
// Size: 0x404
function init(instance) {
    instance.s_start = instance.var_fe2612fe[#"hash_3966465c498df3a6"][0];
    instance.var_f2ec33dd = instance.var_fe2612fe[#"barrier_player"][0];
    instance.a_s_barriers = instance.var_fe2612fe[#"barrier"];
    instance.var_75bfdd78 = instance.var_fe2612fe[#"hash_4bf4d3ae0a837717"];
    instance.var_d0682dc2 = instance.var_fe2612fe[#"hash_54ca9cfca796e0f1"];
    instance.var_4d0b3b87 = instance.var_fe2612fe[#"hash_41ae283ea203de66"][0];
    instance.var_7b2422b6 = instance.var_fe2612fe[#"hash_5d93de0c1cf69a98"][0];
    instance.var_1c417c7e = instance.var_fe2612fe[#"hash_51bc33e4360f4d65"][0];
    instance.var_fc1420f = instance.var_fe2612fe[#"charge"];
    if (isdefined(instance.var_1c417c7e)) {
        instance.var_205d9fb = namespace_8b6a9d79::spawn_script_model(instance.var_1c417c7e, instance.var_1c417c7e.model, 1);
        instance.var_205d9fb thread function_b9cbbef3(instance);
    }
    if (isdefined(instance.var_7b2422b6)) {
        instance.var_e3532743 = namespace_8b6a9d79::spawn_script_model(instance.var_7b2422b6, instance.var_7b2422b6.model, 1);
        instance.var_e3532743 ghost();
    }
    if (isdefined(instance.var_fe2612fe[#"hash_6873efb1dfa0ebea"])) {
        instance.var_3a745f8c = instance.var_fe2612fe[#"hash_6873efb1dfa0ebea"][0];
        namespace_c09ae6c3::function_9ed7339b(instance);
    }
    instance.var_220bb810 = instance.var_fe2612fe[#"hash_2bb7342aab04b85c"];
    instance.var_10cc9592 = arraycombine(instance.var_fe2612fe[#"hash_2bb7372aab04bd75"], instance.var_220bb810);
    instance.var_2250b89e = arraycombine(instance.var_fe2612fe[#"hash_2bb7362aab04bbc2"], instance.var_10cc9592);
    instance.var_10019400 = arraycombine(instance.var_fe2612fe[#"hash_2bb7312aab04b343"], instance.var_2250b89e);
    instance.var_37fa3d92 = array(instance.var_220bb810, instance.var_10cc9592, instance.var_2250b89e, instance.var_10019400);
    instance.var_99ddab53 = 240;
    instance.var_5b4ffff9 = #"objective_holdout_wave_1";
    instance.var_48e40408 = #"objective_holdout_wave_2";
    instance.var_642e1c7a = #"objective_holdout_wave_3";
    instance.var_1a7040e5 = #"objective_holdout_wave_4";
    instance.var_344a6a1a = [];
    instance thread function_4b48e88b();
    instance thread function_90725ab1();
    instance thread function_f5087df2();
}

// Namespace namespace_4db53432/namespace_4db53432
// Params 0, eflags: 0x0
// Checksum 0xa5772a80, Offset: 0xa58
// Size: 0x16c
function function_f5087df2() {
    self waittill(#"objective_ended");
    callback::remove_on_ai_killed(&function_30bf60c2);
    objective_manager::stop_timer();
    foreach (player in getplayers()) {
        level.var_31028c5d thread prototype_hud::function_817e4d10(player, 0);
    }
    if (self.success) {
        namespace_cda50904::function_a92a93e9(self.var_4d0b3b87.origin, self.var_4d0b3b87.angles);
        level thread namespace_7589cf5c::function_3899cfea(self.origin, 5000);
    }
    wait 1;
    if (isdefined(self.var_a0e46e99)) {
        self.var_a0e46e99 delete();
    }
}

// Namespace namespace_4db53432/namespace_4db53432
// Params 0, eflags: 0x0
// Checksum 0xe56ee213, Offset: 0xbd0
// Size: 0x1ce
function bomb_timer() {
    self endon(#"death");
    playsoundatposition(#"hash_44a5cce47822696a", self.origin);
    for (n_timer = 240; n_timer; n_timer -= 1) {
        var_67c95546 = int(n_timer / 60);
        var_16782a41 = int(n_timer % 60 / 10);
        var_b30bc24e = n_timer % 60 % 10;
        if (isdefined(self)) {
            self thread function_e02a26f6();
            self showpart("tag_slot1_digi_" + 0);
            self showpart("tag_slot2_digi_" + var_67c95546);
            self showpart("tag_slot3_digi_" + var_16782a41);
            self showpart("tag_slot4_digi_" + var_b30bc24e);
            self showpart("tag_sign");
        }
        wait 0.5;
        if (isdefined(self)) {
            self hidepart("tag_sign");
        }
        wait 0.5;
    }
}

// Namespace namespace_4db53432/namespace_4db53432
// Params 0, eflags: 0x0
// Checksum 0xa726ef4e, Offset: 0xda8
// Size: 0x38c
function function_e02a26f6() {
    if (isdefined(self)) {
        self hidepart("tag_slot1_digi_0");
        self hidepart("tag_slot1_digi_1");
        self hidepart("tag_slot2_digi_0");
        self hidepart("tag_slot2_digi_1");
        self hidepart("tag_slot2_digi_2");
        self hidepart("tag_slot2_digi_3");
        self hidepart("tag_slot2_digi_4");
        self hidepart("tag_slot2_digi_5");
        self hidepart("tag_slot2_digi_6");
        self hidepart("tag_slot2_digi_7");
        self hidepart("tag_slot2_digi_8");
        self hidepart("tag_slot2_digi_9");
        self hidepart("tag_slot3_digi_0");
        self hidepart("tag_slot3_digi_1");
        self hidepart("tag_slot3_digi_2");
        self hidepart("tag_slot3_digi_3");
        self hidepart("tag_slot3_digi_4");
        self hidepart("tag_slot3_digi_5");
        self hidepart("tag_slot4_digi_0");
        self hidepart("tag_slot4_digi_1");
        self hidepart("tag_slot4_digi_2");
        self hidepart("tag_slot4_digi_3");
        self hidepart("tag_slot4_digi_4");
        self hidepart("tag_slot4_digi_5");
        self hidepart("tag_slot4_digi_6");
        self hidepart("tag_slot4_digi_7");
        self hidepart("tag_slot4_digi_8");
        self hidepart("tag_slot4_digi_9");
    }
}

// Namespace namespace_4db53432/namespace_4db53432
// Params 0, eflags: 0x0
// Checksum 0xce838ade, Offset: 0x1140
// Size: 0x554
function function_90725ab1() {
    self.var_4272a188 triggerenable(0);
    self.var_5c6a2bf5 = namespace_8b6a9d79::function_cfa4f1a0(self.var_fc1420f, #"hash_397d38a359aae4e6", 0);
    foreach (var_e35c2428 in self.var_5c6a2bf5) {
        var_e35c2428 ghost();
    }
    var_23e96cb3 = spawn("trigger_radius_use", self.var_205d9fb.origin + (0, 0, 32), 0, 140, 96);
    var_23e96cb3 triggerignoreteam();
    var_23e96cb3 setcursorhint("HINT_NOICON");
    var_23e96cb3 sethintstring(#"hash_b044f24a01e8b24");
    var_23e96cb3 usetriggerrequirelookat(1);
    s_result = var_23e96cb3 waittill(#"trigger");
    level flag::clear(#"hash_44074059e3987765");
    foreach (var_e35c2428 in self.var_5c6a2bf5) {
        var_e35c2428 show();
        var_e35c2428 thread bomb_timer();
    }
    var_23e96cb3 delete();
    wait 1;
    self thread function_cf2842fb();
    self thread function_26a50e5e();
    self thread function_44fe71e3();
    self thread function_582f2cb();
    self thread function_ca5f0c9();
    self thread function_1c798ee9();
    self thread function_40c4c7ae();
    wait 0.5;
    foreach (player in getplayers()) {
        player clientfield::set_to_player("" + #"hash_69409daf95eb8ffe", 1);
    }
    wait 1;
    self.var_205d9fb clientfield::increment("" + #"hash_7a1ca107322a0dbc");
    wait 0.1;
    level thread namespace_7589cf5c::function_3899cfea(self.var_205d9fb.origin, 2000);
    wait 3.5;
    foreach (player in getplayers()) {
        player clientfield::set_to_player("" + #"hash_69409daf95eb8ffe", 0);
    }
    wait 0.1;
    self thread teleport_players();
    self.var_4272a188 triggerenable(1);
    self.var_4272a188 useby(s_result.activator);
}

// Namespace namespace_4db53432/namespace_4db53432
// Params 0, eflags: 0x0
// Checksum 0x2672d4c8, Offset: 0x16a0
// Size: 0x260
function function_40c4c7ae() {
    var_d3b70fb0 = getvehiclearray();
    var_453e0a89 = [];
    foreach (var_f5304f7 in var_d3b70fb0) {
        if (distance2dsquared(self.origin, var_f5304f7.origin) <= function_a3f6cdac(1200)) {
            var_f5304f7.e_linkto = util::spawn_model("tag_origin", var_f5304f7.origin);
            waitframe(1);
            var_f5304f7 linkto(var_f5304f7.e_linkto);
            var_f5304f7 ghost();
            var_f5304f7.e_linkto movez(1000, 2);
            var_453e0a89[var_453e0a89.size] = var_f5304f7;
        }
    }
    self waittill(#"objective_ended");
    foreach (var_f5304f7 in var_453e0a89) {
        var_f5304f7 show();
        var_f5304f7.e_linkto movez(-1000, 2);
        var_f5304f7.e_linkto waittill(#"movedone");
        wait 1;
        var_f5304f7.e_linkto delete();
    }
}

// Namespace namespace_4db53432/namespace_4db53432
// Params 1, eflags: 0x0
// Checksum 0xc8fef58c, Offset: 0x1908
// Size: 0x18c
function function_b9cbbef3(instance) {
    instance endon(#"objective_ended", #"hash_4a46a299d2376baf");
    while (true) {
        foreach (player in getplayers()) {
            if (distance2dsquared(player.origin, self.origin) < 160000 && player util::is_player_looking_at(self.origin, 0.6, 1, self)) {
                if (!is_true(player.var_e758cbce)) {
                    player.var_e758cbce = 1;
                    player gestures::function_56e00fbf(#"hash_271cf84de195bb95", undefined, 1);
                }
                continue;
            }
            player.var_e758cbce = 0;
            player stopgestureviewmodel();
        }
        wait 0.5;
    }
}

// Namespace namespace_4db53432/namespace_4db53432
// Params 0, eflags: 0x0
// Checksum 0x2dd70d9e, Offset: 0x1aa0
// Size: 0x102
function function_4b48e88b() {
    self.var_1bf25a28 = 0;
    self.var_c90118 = 0;
    self.var_88123135 = 0;
    self.var_947f415 = 0;
    self.var_8f288078 = 0;
    self.var_4745c8ea = function_2e35a302(#"hash_4f87aa2a203d37d0");
    self.var_b3447789 = function_2e35a302(#"spawner_bo5_mechz_sr");
    self.var_eb0cabca = function_2e35a302(#"spawner_zm_steiner");
    self.var_37a3acf2 = function_2e35a302(#"hash_2855f060aad4ae87");
    self.var_85347db0 = function_2e35a302(#"hash_42cbb8cb19ae56dd");
}

// Namespace namespace_4db53432/namespace_4db53432
// Params 2, eflags: 0x0
// Checksum 0x5bc83f00, Offset: 0x1bb0
// Size: 0x1c0
function function_f16ac62c(instance, activator) {
    if (isplayer(activator)) {
        wait 5;
        instance notify(#"hash_4a46a299d2376baf");
        instance thread function_2d1c1fb2();
        foreach (player in getplayers()) {
            level.var_31028c5d prototype_hud::function_7491d6c5(player, #"hash_65641bd73530220a");
        }
        wait 5;
        foreach (player in getplayers()) {
            level.var_31028c5d prototype_hud::set_active_objective_string(player, #"hash_65641bd73530220a");
            level.var_31028c5d prototype_hud::function_817e4d10(player, 2);
        }
    }
}

// Namespace namespace_4db53432/namespace_4db53432
// Params 0, eflags: 0x0
// Checksum 0x730d39af, Offset: 0x1d78
// Size: 0xbc
function function_2d1c1fb2() {
    self thread function_70cfe9f9();
    self thread function_cd1515dc();
    self thread function_e65606fc();
    self thread spawn_zombies();
    objective_manager::start_timer(self.var_99ddab53, #"hash_65641bd73530220a");
    self notify(#"hash_36719991d2a7edc6");
    level flag::set(#"hash_44074059e3987765");
}

// Namespace namespace_4db53432/namespace_4db53432
// Params 0, eflags: 0x0
// Checksum 0x9e4121e2, Offset: 0x1e40
// Size: 0x5c
function function_cf2842fb() {
    self.var_e3532743 playrumblelooponentity(#"sr_holdout_aether_mass_rumble");
    wait 5;
    self.var_e3532743 stoprumble(#"sr_holdout_aether_mass_rumble");
}

// Namespace namespace_4db53432/namespace_4db53432
// Params 0, eflags: 0x0
// Checksum 0xd07110a0, Offset: 0x1ea8
// Size: 0x1ac
function function_e65606fc() {
    self endon(#"objective_ended");
    if (isdefined(self.var_205d9fb)) {
        self.var_a0e46e99 = util::spawn_model("tag_origin", self.var_205d9fb.origin + (0, 0, 20));
        self.var_205d9fb delete();
    }
    if (isdefined(self.var_5c6a2bf5)) {
        foreach (var_e35c2428 in self.var_5c6a2bf5) {
            var_e35c2428 delete();
        }
    }
    self waittill(#"return");
    self.var_a0e46e99 clientfield::set("final_battle_cloud_fx", 1);
    wait 6;
    self.var_a0e46e99 clientfield::set("final_battle_cloud_fx", 0);
    wait 1.5;
    if (isdefined(self.var_e3532743)) {
        self.var_e3532743 delete();
    }
    objective_manager::objective_ended(self, 1);
}

// Namespace namespace_4db53432/namespace_4db53432
// Params 0, eflags: 0x0
// Checksum 0x6f67f605, Offset: 0x2060
// Size: 0x210
function function_cd1515dc() {
    a_doors = [];
    foreach (barrier in self.a_s_barriers) {
        if (barrier.model === "barrier_door_single") {
            doors = function_c3d68575(barrier.origin, (20, 20, 20));
            foreach (door in doors) {
                if (door.script_noteworthy === #"hash_4d1fb8524fdfd254") {
                    a_doors[a_doors.size] = door;
                    setdynentenabled(door, 0);
                }
            }
        }
    }
    self waittill(#"objective_ended");
    foreach (door in a_doors) {
        if (isdefined(door)) {
            setdynentenabled(door, 1);
        }
    }
}

// Namespace namespace_4db53432/namespace_4db53432
// Params 0, eflags: 0x0
// Checksum 0xd82a96da, Offset: 0x2278
// Size: 0x190
function function_70cfe9f9() {
    a_vehicles = getvehiclearray();
    foreach (vehicle in a_vehicles) {
        if (isdefined(vehicle) && is_true(vehicle.isplayervehicle)) {
            vehicle makeunusable();
        }
    }
    self waittill(#"objective_ended");
    a_vehicles = getvehiclearray();
    foreach (vehicle in a_vehicles) {
        if (isdefined(vehicle) && is_true(vehicle.isplayervehicle)) {
            vehicle makeusable();
        }
    }
}

// Namespace namespace_4db53432/namespace_4db53432
// Params 0, eflags: 0x0
// Checksum 0x67716c81, Offset: 0x2410
// Size: 0x238
function function_582f2cb() {
    if (isdefined(self.var_fe2612fe[#"hash_441da645c3f27eea"])) {
        self.a_mdl_blockers = [];
        foreach (s_blocker in self.var_fe2612fe[#"hash_441da645c3f27eea"]) {
            self.a_mdl_blockers[self.a_mdl_blockers.size] = namespace_8b6a9d79::spawn_script_model(s_blocker, s_blocker.model, 1);
        }
        foreach (mdl_blocker in self.a_mdl_blockers) {
            mdl_blocker disconnectpaths();
            mdl_blocker ghost();
        }
    }
    self waittill(#"objective_ended");
    if (isdefined(self.a_mdl_blockers)) {
        foreach (mdl_blocker in self.a_mdl_blockers) {
            mdl_blocker connectpaths();
            wait 0.1;
            mdl_blocker delete();
        }
    }
}

// Namespace namespace_4db53432/namespace_4db53432
// Params 0, eflags: 0x0
// Checksum 0xd68d119d, Offset: 0x2650
// Size: 0x394
function function_44fe71e3() {
    self.var_f9bfb787 = [];
    foreach (s_barrier in self.a_s_barriers) {
        self.var_f9bfb787[self.var_f9bfb787.size] = namespace_8b6a9d79::spawn_script_model(s_barrier, s_barrier.model, 1);
    }
    foreach (var_936c52b5 in self.var_f9bfb787) {
        var_936c52b5 disconnectpaths();
        var_936c52b5.a_nodes = getnodesinradius(var_936c52b5.origin, 60, 20, 50);
        foreach (node in var_936c52b5.a_nodes) {
            setenablenode(node, 0);
        }
    }
    self waittill(#"objective_ended");
    if (isdefined(self.var_2b6c2b8e)) {
        self.var_2b6c2b8e connectpaths();
    }
    foreach (var_936c52b5 in self.var_f9bfb787) {
        foreach (node in var_936c52b5.a_nodes) {
            setenablenode(node, 1);
        }
        var_936c52b5 connectpaths();
        wait 0.1;
        var_936c52b5 delete();
    }
    if (isdefined(self.var_2b6c2b8e)) {
        self.var_2b6c2b8e delete();
    }
    if (isdefined(self.mdl_blocker)) {
        self.mdl_blocker delete();
    }
}

// Namespace namespace_4db53432/namespace_4db53432
// Params 0, eflags: 0x0
// Checksum 0xdf45782c, Offset: 0x29f0
// Size: 0x2b4
function teleport_players() {
    self endon(#"objective_ended");
    a_players = getplayers();
    for (i = 0; i < a_players.size; i++) {
        a_players[i] util::create_streamer_hint(self.origin, self.angles, 1);
        a_players[i] thread function_54a46b15(self.var_75bfdd78[i]);
    }
    self waittill(#"hash_36719991d2a7edc6");
    level thread namespace_7589cf5c::function_3899cfea(self.var_75bfdd78[0].origin, 2000);
    wait 10;
    foreach (player in getplayers()) {
        player clientfield::set_to_player("" + #"hash_69409daf95eb8ffe", 1);
    }
    wait 3;
    self notify(#"return");
    foreach (player in getplayers()) {
        player clientfield::set_to_player("" + #"hash_69409daf95eb8ffe", 0);
    }
    a_players = getplayers();
    for (i = 0; i < a_players.size; i++) {
        a_players[i] thread function_54a46b15(self.var_d0682dc2[i]);
    }
}

// Namespace namespace_4db53432/namespace_4db53432
// Params 1, eflags: 0x0
// Checksum 0x8f429687, Offset: 0x2cb0
// Size: 0x74
function function_54a46b15(s_pos) {
    self endon(#"disconnect");
    self zm_fasttravel::function_66d020b0(undefined, undefined, undefined, "survival_holdout_dest", s_pos, undefined, undefined, 1, 1);
    self setplayerangles(s_pos.angles);
}

// Namespace namespace_4db53432/namespace_4db53432
// Params 0, eflags: 0x0
// Checksum 0x6b550a06, Offset: 0x2d30
// Size: 0x17a
function function_ca5f0c9() {
    namespace_1367bdba::function_fdc4ca3c();
    self.var_13ba88d2 = self.var_fe2612fe[#"barricade_window"];
    if (!isarray(self.var_13ba88d2)) {
        return;
    }
    foreach (var_c67ba39f in self.var_13ba88d2) {
        var_c67ba39f thread namespace_1367bdba::function_14354831();
    }
    self waittill(#"objective_ended");
    foreach (var_c67ba39f in self.var_13ba88d2) {
        if (isdefined(var_c67ba39f.e_barricade)) {
            var_c67ba39f.e_barricade delete();
        }
    }
    self.var_13ba88d2 = undefined;
}

// Namespace namespace_4db53432/namespace_4db53432
// Params 0, eflags: 0x0
// Checksum 0xdceedcbe, Offset: 0x2eb8
// Size: 0x1ea
function function_1c798ee9() {
    self endon(#"objective_ended");
    switch (self.targetname) {
    case #"objective_duga_holdout":
        str_trigger = "trigger_holdout_duga";
        break;
    case #"hash_667dbf380c0e0a74":
        str_trigger = "trigger_holdout_forest";
        break;
    case #"objective_golova_holdout":
        str_trigger = "trigger_holdout_golova";
        break;
    case #"objective_sanatorium_holdout":
        str_trigger = "trigger_holdout_sanatorium";
        break;
    case #"objective_ski_holdout":
        str_trigger = "trigger_holdout_ski";
        break;
    case #"hash_29783b5c80e9b4c":
        str_trigger = "trigger_holdout_weather_station";
        break;
    case #"objective_zoo_holdout":
        str_trigger = "trigger_holdout_zoo";
        break;
    }
    if (isdefined(str_trigger)) {
        var_520491cd = getent(str_trigger, "targetname");
        while (true) {
            s_result = var_520491cd waittill(#"trigger");
            if (is_true(s_result.activator.var_98f1f37c)) {
                s_result.activator.var_98f1f37c = undefined;
            }
            if (is_true(s_result.activator.no_powerups)) {
                s_result.activator.no_powerups = undefined;
            }
        }
    }
}

// Namespace namespace_4db53432/namespace_4db53432
// Params 0, eflags: 0x0
// Checksum 0x3d570ac0, Offset: 0x30b0
// Size: 0x184
function function_26a50e5e() {
    switch (self.targetname) {
    case #"objective_duga_holdout":
        var_9b7aaa46 = undefined;
        break;
    case #"hash_667dbf380c0e0a74":
        var_9b7aaa46 = #"hash_51f0196411090cbd";
        break;
    case #"objective_golova_holdout":
        var_9b7aaa46 = undefined;
        break;
    case #"objective_sanatorium_holdout":
        var_9b7aaa46 = #"hash_1b28315ea7945f57";
        break;
    case #"objective_ski_holdout":
        var_9b7aaa46 = undefined;
        break;
    case #"hash_29783b5c80e9b4c":
        var_9b7aaa46 = #"hash_214ca66f30db9345";
        break;
    case #"objective_zoo_holdout":
        var_9b7aaa46 = #"hash_573279570cd485e4";
        break;
    }
    if (isdefined(var_9b7aaa46)) {
        self.var_2b6c2b8e = util::spawn_model(var_9b7aaa46, self.var_f2ec33dd.origin, self.var_f2ec33dd.angles);
        self.var_344a6a1a[self.var_344a6a1a.size] = self.var_2b6c2b8e;
        self.var_2b6c2b8e ghost();
    }
}

// Namespace namespace_4db53432/namespace_4db53432
// Params 1, eflags: 0x0
// Checksum 0xd20c3800, Offset: 0x3240
// Size: 0x196
function function_2e35a302(var_7ecdee63) {
    n_players = getplayers().size;
    switch (var_7ecdee63) {
    case #"hash_4f87aa2a203d37d0":
        if (n_players == 1) {
            n_limit = min(level.var_b48509f9, 2);
        } else {
            n_limit = min(level.var_b48509f9, 3);
        }
        break;
    case #"spawner_zm_steiner":
    case #"spawner_bo5_mechz_sr":
        if (n_players == 1) {
            n_limit = min(level.var_b48509f9 - 2, 1);
        } else {
            n_limit = min(level.var_b48509f9 - 2, 2);
        }
        break;
    case #"hash_2855f060aad4ae87":
        n_limit = level.var_b48509f9 * 6;
        break;
    case #"hash_42cbb8cb19ae56dd":
        n_limit = level.var_b48509f9 * 4;
        break;
    }
    if (n_limit < 0) {
        n_limit = 0;
    }
    return n_limit;
}

// Namespace namespace_4db53432/namespace_4db53432
// Params 0, eflags: 0x0
// Checksum 0x3ca7dbb2, Offset: 0x33e0
// Size: 0x22c
function spawn_zombies() {
    self endon(#"objective_ended", #"hash_36719991d2a7edc6");
    switch (getplayers().size) {
    case 1:
        var_fd6a4001 = 3;
        var_102fe58c = 4;
        var_3b743c0c = 5;
        break;
    case 2:
        var_fd6a4001 = 6;
        var_102fe58c = 8;
        var_3b743c0c = 10;
        break;
    case 3:
        var_fd6a4001 = 9;
        var_102fe58c = 12;
        var_3b743c0c = 15;
        break;
    case 4:
        var_fd6a4001 = 12;
        var_102fe58c = 15;
        var_3b743c0c = 18;
        break;
    default:
        var_fd6a4001 = 15;
        var_102fe58c = 17;
        var_3b743c0c = 22;
        break;
    }
    callback::on_ai_killed(&function_30bf60c2);
    wait 3;
    self thread function_b2bc128b();
    self thread function_34ac205(var_fd6a4001 + level.var_b48509f9, 0);
    self waittill(#"wave_start");
    self thread function_34ac205(var_102fe58c + level.var_b48509f9, 1);
    self waittill(#"wave_start");
    self thread function_34ac205(var_3b743c0c + level.var_b48509f9, 2);
}

// Namespace namespace_4db53432/namespace_4db53432
// Params 0, eflags: 0x0
// Checksum 0xb54d5d81, Offset: 0x3618
// Size: 0x86
function function_b2bc128b() {
    self endon(#"objective_ended", #"hash_36719991d2a7edc6");
    wait 50;
    self notify(#"wave_done");
    wait 25;
    self notify(#"wave_start");
    wait 65;
    self notify(#"wave_done");
    wait 25;
    self notify(#"wave_start");
}

// Namespace namespace_4db53432/namespace_4db53432
// Params 2, eflags: 0x0
// Checksum 0x4ea3568c, Offset: 0x36a8
// Size: 0x1e2
function function_34ac205(n_active, n_wave) {
    self endon(#"objective_ended", #"hash_36719991d2a7edc6", #"wave_done");
    self.n_active = 0;
    n_players = getplayers().size;
    n_delay = 3 - n_wave;
    var_559503f1 = self function_94e50668(n_wave);
    a_s_locs = arraycopy(var_559503f1);
    while (true) {
        if (self.n_active < n_active) {
            var_7ecdee63 = function_2631fff1(self, level.var_b48509f9);
            if (!a_s_locs.size) {
                a_s_locs = arraycopy(var_559503f1);
            }
            s_loc = a_s_locs[0];
            arrayremovevalue(a_s_locs, a_s_locs[0]);
            ai_spawned = namespace_85745671::function_9d3ad056(var_7ecdee63, s_loc.origin, s_loc.angles, "holdout_zombie");
            wait 0.1;
            if (isdefined(ai_spawned)) {
                ai_spawned.var_98f1f37c = 1;
                ai_spawned.no_powerups = 1;
                ai_spawned thread function_bf606a73();
                self.n_active++;
            }
        }
        wait n_delay;
    }
}

// Namespace namespace_4db53432/namespace_4db53432
// Params 2, eflags: 0x0
// Checksum 0x175032c8, Offset: 0x3898
// Size: 0x2c6
function function_2631fff1(instance, var_661691aa) {
    var_908ce45b = 0;
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
    default:
        var_6017f33e = namespace_679a22ba::function_ca209564(instance.var_1a7040e5);
        break;
    }
    switch (var_6017f33e.var_990b33df) {
    case #"hash_4f87aa2a203d37d0":
        instance.var_1bf25a28++;
        if (instance.var_1bf25a28 >= instance.var_4745c8ea) {
            var_908ce45b = 1;
        }
        break;
    case #"spawner_bo5_mechz_sr":
        instance.var_c90118++;
        if (instance.var_c90118 >= instance.var_b3447789) {
            var_908ce45b = 1;
        }
        break;
    case #"spawner_zm_steiner":
        instance.var_88123135++;
        if (instance.var_88123135 >= instance.var_eb0cabca) {
            var_908ce45b = 1;
        }
        break;
    case #"hash_2855f060aad4ae87":
        instance.var_947f415++;
        if (instance.var_947f415 >= instance.var_37a3acf2) {
            var_908ce45b = 1;
        }
        break;
    case #"hash_42cbb8cb19ae56dd":
        instance.var_8f288078++;
        if (instance.var_8f288078 >= instance.var_85347db0) {
            var_908ce45b = 1;
        }
        break;
    }
    if (var_908ce45b) {
        if (level.var_b48509f9 < 3) {
            return #"hash_7cba8a05511ceedf";
        } else if (level.var_b48509f9 < 5) {
            return #"hash_338eb4103e0ed797";
        } else {
            return #"hash_46c917a1b5ed91e7";
        }
    }
    return var_6017f33e.var_990b33df;
}

// Namespace namespace_4db53432/namespace_4db53432
// Params 0, eflags: 0x0
// Checksum 0x575baca3, Offset: 0x3b68
// Size: 0xe6
function function_bf606a73() {
    self endon(#"death");
    self callback::function_d8abfc3d(#"hash_4afe635f36531659", &function_fd68cae4);
    while (true) {
        if (isalive(self)) {
            player = array::get_all_closest(self.origin, getplayers())[0];
            if (isalive(player)) {
                awareness::function_c241ef9a(self, player, 10);
            }
        }
        wait 10;
    }
}

// Namespace namespace_4db53432/namespace_4db53432
// Params 0, eflags: 0x0
// Checksum 0x8b2767cd, Offset: 0x3c58
// Size: 0x3c
function function_fd68cae4() {
    if (self.archetype === #"zombie") {
        self namespace_85745671::function_9758722("sprint");
    }
}

// Namespace namespace_4db53432/namespace_4db53432
// Params 1, eflags: 0x0
// Checksum 0xbe369d3, Offset: 0x3ca0
// Size: 0x80
function function_30bf60c2(*s_params) {
    if (self.targetname !== "holdout_zombie") {
        return;
    }
    if (isdefined(level.var_7d45d0d4.activeobjective.n_active) && level.var_7d45d0d4.activeobjective.n_active > 0) {
        level.var_7d45d0d4.activeobjective.n_active--;
    }
}

// Namespace namespace_4db53432/namespace_4db53432
// Params 1, eflags: 0x0
// Checksum 0x2eb56805, Offset: 0x3d28
// Size: 0x142
function function_94e50668(n_wave) {
    var_559503f1 = [];
    n_players = getplayers().size;
    switch (n_players) {
    case 1:
        var_559503f1 = self.var_37fa3d92[n_wave];
        break;
    case 2:
        var_559503f1 = self.var_37fa3d92[n_wave + 1];
        break;
    case 3:
        if (n_wave == 2) {
            var_559503f1 = self.var_37fa3d92[3];
        } else {
            var_559503f1 = self.var_37fa3d92[n_wave + 2];
        }
        break;
    case 4:
        var_559503f1 = self.var_37fa3d92[3];
        break;
    }
    if (!isdefined(var_559503f1)) {
        var_559503f1 = self.var_2250b89e;
    }
    var_559503f1 = array::randomize(var_559503f1);
    return var_559503f1;
}

