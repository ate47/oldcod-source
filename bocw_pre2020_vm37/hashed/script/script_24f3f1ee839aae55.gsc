#using script_1029986e2bc8ca8e;
#using script_113dd7f0ea2a1d4f;
#using script_12538a87a80a2978;
#using script_1cc417743d7c262d;
#using script_27347f09888ad15;
#using script_3357acf79ce92f4b;
#using script_3411bb48d41bd3b;
#using script_4163291d6e693552;
#using script_5961deb533dad533;
#using script_7fc996fe8678852;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\fx_shared;
#using scripts\core_common\gameobjects_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\music_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\sound_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\struct;
#using scripts\core_common\trigger_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\core_common\vehicle_shared;

#namespace namespace_767001c4;

// Namespace namespace_767001c4/level_init
// Params 1, eflags: 0x40
// Checksum 0x16b2cb88, Offset: 0x2c0
// Size: 0xec
function event_handler[level_init] main(*eventstruct) {
    clientfield::register("scriptmover", "" + #"hash_487b1e88cb277c0e", 1, 2, "int");
    clientfield::register("scriptmover", "" + #"hash_4d8a65c820ef791", 1, 1, "int");
    objective_manager::function_b3464a7c(#"destroy", &init, &function_ceee31fb, #"destroy", #"hash_6d5fcba0c769bf54");
}

// Namespace namespace_767001c4/namespace_1b47c84a
// Params 1, eflags: 0x0
// Checksum 0x24f20cab, Offset: 0x3b8
// Size: 0x26c
function init(s_instance) {
    s_instance.a_gameobjects = [];
    s_instance.var_aeba4321 = namespace_8b6a9d79::function_cfa4f1a0(s_instance.var_fe2612fe[#"console"], #"hash_34bcdb9dbd1fa23e", 1);
    s_instance.var_56356783 = namespace_8b6a9d79::function_cfa4f1a0(s_instance.var_fe2612fe[#"hash_7ce81d9430ea7921"], #"tag_origin", 1);
    if (isdefined(s_instance.var_fe2612fe[#"hash_4e3810cf0c8aa18d"][0].modelscale)) {
        s_instance.var_e9e88745 setscale(s_instance.var_fe2612fe[#"hash_4e3810cf0c8aa18d"][0].modelscale);
    }
    s_instance.s_portal = s_instance.var_fe2612fe[#"portal"][0];
    foreach (var_4a416ea9 in s_instance.var_aeba4321) {
        var_4a416ea9 fx::play("sr/fx9_obj_portal_console_corrupted", undefined, undefined, #"hash_58a6e06e2767306a", 1, "tag_origin");
    }
    s_instance.s_portal fx::play("sr/fx9_obj_portal_loop", s_instance.s_portal.origin, undefined, "kill_fx");
    s_instance.var_4272a188 thread objective_manager::function_98da2ed1(s_instance.var_4272a188.origin, "objectiveDestroyApproach");
    function_86a476ea(s_instance);
    /#
        level thread function_742ab591(s_instance);
    #/
}

// Namespace namespace_767001c4/namespace_1b47c84a
// Params 1, eflags: 0x0
// Checksum 0x5b01f5bd, Offset: 0x630
// Size: 0xca
function function_86a476ea(s_instance) {
    s_instance.var_47971731 = #"hash_3d4d31b3b925a887";
    s_instance.var_fca3014a = #"hash_3d4d32b3b925aa3a";
    s_instance.var_6ae3ddca = #"hash_3d4d33b3b925abed";
    s_instance.var_8e4b249c = #"hash_3d4d2cb3b925a008";
    s_instance.var_b858b2bb = #"hash_7d30e84b7bb4f782";
    s_instance.var_85894d1d = #"hash_7d30e74b7bb4f5cf";
    s_instance.var_4e685ee8 = #"hash_7d30e64b7bb4f41c";
    s_instance.var_5c16fa45 = #"hash_7d30e54b7bb4f269";
}

// Namespace namespace_767001c4/namespace_1b47c84a
// Params 0, eflags: 0x0
// Checksum 0x75461573, Offset: 0x708
// Size: 0x54
function function_80aa11f() {
    array::thread_all(getplayers(), &callback::function_d8abfc3d, #"weapon_fired", &on_weapon_fired);
}

// Namespace namespace_767001c4/namespace_1b47c84a
// Params 1, eflags: 0x0
// Checksum 0xd7f690c6, Offset: 0x768
// Size: 0x154
function on_weapon_fired(*params) {
    if (!isdefined(level.var_7d45d0d4.activeobjective) || !isdefined(level.var_7d75c960.var_35360422.var_e9e88745)) {
        return;
    }
    s_instance = level.var_7d45d0d4.activeobjective;
    var_e9e88745 = level.var_7d75c960.var_35360422.var_e9e88745;
    if (!s_instance flag::get(#"assault_start") && self util::is_looking_at(var_e9e88745, 0.97, 0) && distancesquared(self.origin, var_e9e88745.origin) < 900000000) {
        self thread globallogic_audio::leader_dialog_on_player("objectiveDestroyGeneratorHint");
        self callback::function_52ac9652(#"weapon_fired", &on_weapon_fired);
    }
}

// Namespace namespace_767001c4/namespace_1b47c84a
// Params 2, eflags: 0x0
// Checksum 0x99f8977, Offset: 0x8c8
// Size: 0x614
function function_ceee31fb(s_instance, activator) {
    level endon(#"hash_37675afbec21249c", #"objective_ended");
    if (isplayer(activator)) {
        activator thread util::delay(2.5, undefined, &globallogic_audio::leader_dialog_on_player, "objectiveDestroyStart");
        foreach (var_ba0e0085 in level.var_7d45d0d4.activeobjective.var_56356783) {
            var_ba0e0085 notify(#"hash_3078cfceb987c941");
        }
        foreach (player in getplayers()) {
            level.var_31028c5d prototype_hud::function_7491d6c5(player, #"hash_333a3c9fb2088115");
        }
        s_instance.var_ec9554ad = 45;
        switch (getplayers().size) {
        case 1:
            s_instance.n_max_active = 8;
            s_instance.var_47b4a0f4 = 15;
            s_instance.var_33e2a47e = 1;
            s_instance.var_93492881 = 6;
            s_instance.var_32826780 = 6;
            s_instance.var_ec9554ad = 30;
            break;
        case 2:
            s_instance.n_max_active = 9;
            s_instance.var_47b4a0f4 = 10;
            s_instance.var_33e2a47e = 1;
            s_instance.var_93492881 = 8;
            s_instance.var_32826780 = 8;
            break;
        case 3:
            s_instance.n_max_active = 10;
            s_instance.var_47b4a0f4 = 8;
            s_instance.var_33e2a47e = 1;
            s_instance.var_93492881 = 8;
            s_instance.var_32826780 = 8;
            break;
        case 4:
            s_instance.n_max_active = 10;
            s_instance.var_47b4a0f4 = 5;
            s_instance.var_33e2a47e = 2;
            s_instance.var_93492881 = 10;
            s_instance.var_32826780 = 10;
        case 5:
            s_instance.n_max_active = 10;
            s_instance.var_47b4a0f4 = 5;
            s_instance.var_33e2a47e = 2;
            s_instance.var_93492881 = 10;
            s_instance.var_32826780 = 10;
            break;
        }
        function_83eb80af(activator.origin);
        level thread function_e015cc87(s_instance);
        level thread function_75f26c19(s_instance);
        var_1a4e62c8 = arraysortclosest(s_instance.var_56356783, activator.origin);
        for (i = 0; i < var_1a4e62c8.size; i++) {
            var_1a4e62c8[i].var_4a416ea9 = array::get_all_closest(var_1a4e62c8[i].origin, s_instance.var_aeba4321)[0];
            s_instance.n_progress = 0;
            var_1a4e62c8[i] thread function_15f3c92(i);
            n_group_size = level.var_7d45d0d4.activeobjective.var_93492881;
            var_1a4e62c8[i] thread function_20c61a40(s_instance, n_group_size);
            foreach (player in getplayers()) {
                level.var_31028c5d prototype_hud::set_active_objective_string(player, #"hash_333a3c9fb2088115");
                level.var_31028c5d prototype_hud::function_817e4d10(player, 2);
            }
            level.var_7d45d0d4.activeobjective.var_32826780 = int(level.var_7d45d0d4.activeobjective.var_32826780 * 1.5);
            level waittill(#"hash_592fc6e7a73f96b2");
            s_instance.var_73229dfa = 0;
        }
        level objective_manager::stop_timer();
        wait 5;
        function_2dddf171(s_instance);
        objective_manager::objective_ended(s_instance);
    }
}

// Namespace namespace_767001c4/namespace_1b47c84a
// Params 1, eflags: 0x0
// Checksum 0xc33709ca, Offset: 0xee8
// Size: 0x22c
function function_15f3c92(n_index) {
    self.var_e9e88745 = level.var_7d45d0d4.activeobjective.var_e9e88745;
    self.var_d6a77850 = level.var_7d45d0d4.activeobjective.var_fe2612fe[#"hash_1c6137ee434c8d79"];
    switch (n_index) {
    case 0:
        str_objective = #"hash_5d4a1a7be54ae04c";
        break;
    case 1:
        str_objective = #"hash_5d4a1d7be54ae565";
        break;
    case 2:
        str_objective = #"hash_5d4a1c7be54ae3b2";
        break;
    case 3:
        str_objective = #"hash_5d4a177be54adb33";
        break;
    default:
        str_objective = #"hash_2a31894d25cdb758";
        break;
    }
    self gameobjects::init_game_objects(#"hash_78cf5659aa814509", undefined, undefined, undefined, undefined, str_objective);
    self gameobjects::set_onbeginuse_event(&function_42f940);
    self gameobjects::set_onuse_event(&function_cf7a0ea8);
    self gameobjects::set_onenduse_event(&function_e620b7ff);
    self.mdl_gameobject.b_available = 1;
    self.mdl_gameobject thread function_b60facb5();
    level.var_7d45d0d4.activeobjective.a_gameobjects[level.var_7d45d0d4.activeobjective.a_gameobjects.size] = self;
}

// Namespace namespace_767001c4/namespace_1b47c84a
// Params 0, eflags: 0x0
// Checksum 0x6d8a8684, Offset: 0x1120
// Size: 0x98
function function_b60facb5() {
    level endon(#"hash_592fc6e7a73f96b2");
    while (true) {
        level waittill(#"hash_15f154848bb2b33e");
        self gameobjects::disable_object(1, 1);
        level waittill(#"timer_stop");
        self gameobjects::enable_object(1, 1);
    }
}

// Namespace namespace_767001c4/namespace_1b47c84a
// Params 3, eflags: 0x0
// Checksum 0x23cd38b9, Offset: 0x11c0
// Size: 0xa8
function function_cf7a0ea8(activator, *laststate, *state) {
    level endon(#"hash_68c9737a7650da7f");
    if (isplayer(state)) {
        self.e_object.var_4a416ea9 thread function_effab90b();
        level notify(#"hash_15f154848bb2b33e", {#gameobject:self, #model:self.e_object.var_4a416ea9});
    }
}

// Namespace namespace_767001c4/namespace_1b47c84a
// Params 0, eflags: 0x0
// Checksum 0x3abf9687, Offset: 0x1270
// Size: 0x3c
function function_effab90b() {
    s_instance = level.var_7d45d0d4.activeobjective;
    self thread function_16566585(s_instance);
}

// Namespace namespace_767001c4/namespace_1b47c84a
// Params 1, eflags: 0x0
// Checksum 0xf0065296, Offset: 0x12b8
// Size: 0xfc
function function_16566585(*s_instance) {
    level endon(#"objective_ended", #"game_over");
    slots = namespace_85745671::function_bdb2b85b(self, self.origin, self.angles, 50, 4, 16);
    if (!isdefined(slots) || slots.size <= 0) {
        return;
    }
    self.var_b79a8ac7 = {#var_f019ea1a:3000, #slots:slots};
    level.attackables[level.attackables.size] = self;
    level waittill(#"hash_592fc6e7a73f96b2");
    namespace_85745671::function_b70e2a37(self);
}

// Namespace namespace_767001c4/namespace_1b47c84a
// Params 1, eflags: 0x0
// Checksum 0x8820658d, Offset: 0x13c0
// Size: 0x220
function function_75f26c19(s_instance) {
    self notify("43975dba9f0b4ee4");
    self endon("43975dba9f0b4ee4");
    level endon(#"objective_ended");
    s_instance.var_73229dfa = 0;
    while (true) {
        s_params = level waittill(#"hash_15f154848bb2b33e");
        s_instance.var_73229dfa++;
        level thread function_b30bde5(s_instance, s_params.model.origin);
        s_params.model thread function_feb69530();
        n_time = level.var_7d45d0d4.activeobjective.var_ec9554ad - level.var_7d45d0d4.activeobjective.n_progress;
        level thread function_2dd22f01();
        level thread function_4dd4c049(s_instance, s_params.model);
        foreach (player in getplayers()) {
            level.var_31028c5d prototype_hud::set_active_objective_string(player, #"hash_1d535befe3851a71");
            level.var_31028c5d prototype_hud::function_817e4d10(player, 2);
        }
        level objective_manager::start_timer(n_time, "repulsor_defend");
    }
}

// Namespace namespace_767001c4/namespace_1b47c84a
// Params 0, eflags: 0x0
// Checksum 0x1ea93a6f, Offset: 0x15e8
// Size: 0x1d4
function function_feb69530() {
    level endon(#"hash_592fc6e7a73f96b2", #"game_over", #"objective_ended");
    self val::set("objective", "takedamage", 1);
    while (true) {
        s_notify = self waittill(#"damage");
        if (isai(s_notify.attacker)) {
            /#
                iprintlnbold("<dev string:x38>");
            #/
            level objective_manager::stop_timer();
            level notify(#"hash_6e98003e3b602119");
            foreach (player in getplayers()) {
                level.var_31028c5d prototype_hud::set_active_objective_string(player, #"hash_333a3c9fb2088115");
                level.var_31028c5d prototype_hud::function_817e4d10(player, 2);
            }
            namespace_85745671::function_b70e2a37(self);
            break;
        }
    }
}

// Namespace namespace_767001c4/namespace_1b47c84a
// Params 0, eflags: 0x0
// Checksum 0xfc8eab6a, Offset: 0x17c8
// Size: 0x76
function function_2dd22f01() {
    level endon(#"hash_592fc6e7a73f96b2", #"hash_6e98003e3b602119", #"game_over", #"objective_ended");
    while (true) {
        level.var_7d45d0d4.activeobjective.n_progress++;
        wait 1;
    }
}

// Namespace namespace_767001c4/namespace_1b47c84a
// Params 2, eflags: 0x0
// Checksum 0x5c24413, Offset: 0x1848
// Size: 0x114
function function_b30bde5(s_instance, v_loc) {
    s_spawn_loc = array::get_all_closest(v_loc, level.var_7d45d0d4.activeobjective.var_fe2612fe[#"defend_spawn"]);
    var_32826780 = level.var_7d45d0d4.activeobjective.var_32826780;
    if (!isdefined(s_instance.var_79052acb)) {
        s_instance.var_79052acb = 0;
    }
    var_82d2d51a = int(var_32826780 * 0.4);
    if (s_instance.var_73229dfa > 1 && s_instance.var_79052acb > var_82d2d51a) {
        return;
    }
    s_spawn_loc[0] thread function_20c61a40(s_instance, var_32826780, 1);
}

// Namespace namespace_767001c4/namespace_1b47c84a
// Params 2, eflags: 0x0
// Checksum 0xe6fd1049, Offset: 0x1968
// Size: 0xb4
function function_4dd4c049(*s_instance, var_d143311e) {
    level waittill(#"hash_592fc6e7a73f96b2");
    var_d143311e notify(#"hash_58a6e06e2767306a");
    var_d143311e clientfield::set("" + #"hash_487b1e88cb277c0e", 2);
    var_d143311e playsound(#"hash_4c9a1dc204c6f183");
    var_d143311e scene::play(#"hash_6ce544c477f98b26", var_d143311e);
}

// Namespace namespace_767001c4/namespace_1b47c84a
// Params 3, eflags: 0x0
// Checksum 0xd50ddc07, Offset: 0x1a28
// Size: 0x5c
function function_42f940(activator, *laststate, *state) {
    level endon(#"hash_68c9737a7650da7f");
    if (isplayer(state)) {
        state thread function_a7726198();
    }
}

// Namespace namespace_767001c4/namespace_1b47c84a
// Params 3, eflags: 0x0
// Checksum 0xe169f717, Offset: 0x1a90
// Size: 0x3c
function function_e620b7ff(*str_team, *e_player, *b_result) {
    self playsound(#"zmb_switch_flip");
}

// Namespace namespace_767001c4/namespace_1b47c84a
// Params 0, eflags: 0x0
// Checksum 0xf7b6052, Offset: 0x1ad8
// Size: 0x8c
function function_a7726198() {
    self endon(#"death");
    var_a940cf88 = array::get_all_closest(self.origin, getaiarray(), undefined, 800);
    if (isalive(var_a940cf88[0])) {
        awareness::function_c241ef9a(var_a940cf88[0], self, 15);
    }
}

/#

    // Namespace namespace_767001c4/namespace_1b47c84a
    // Params 1, eflags: 0x0
    // Checksum 0x49f72beb, Offset: 0x1b70
    // Size: 0xe0
    function function_742ab591(s_instance) {
        level waittill(#"objective_ended");
        function_2dddf171(s_instance);
        level notify(#"hash_592fc6e7a73f96b2");
        foreach (gameobject in s_instance.a_gameobjects) {
            gameobject gameobjects::destroy_object(1, 1);
        }
    }

#/

// Namespace namespace_767001c4/namespace_1b47c84a
// Params 1, eflags: 0x0
// Checksum 0xccd321ba, Offset: 0x1c58
// Size: 0x280
function function_2dddf171(s_instance) {
    s_portal = s_instance.s_portal;
    level notify(#"hash_68c9737a7650da7f");
    playfx("sr/fx9_obj_portal_dest_exp", s_portal.origin);
    playrumbleonposition("sr_prototype_generator_explosion", s_portal.origin);
    playsoundatposition(#"hash_6c3605b8f63a902f", s_portal.origin);
    s_portal notify(#"kill_fx");
    var_3faba32e = array::random(s_instance.var_fe2612fe[#"hash_41ae283ea203de66"]);
    if (!isdefined(var_3faba32e)) {
        var_3faba32e = s_portal;
    }
    level thread namespace_cda50904::function_a92a93e9(var_3faba32e.origin, var_3faba32e.angles);
    foreach (player in getplayers()) {
        level.var_31028c5d prototype_hud::function_817e4d10(player, 0);
    }
    level thread namespace_7589cf5c::function_83eb80af(s_portal.origin);
    wait 0.1;
    foreach (var_4a416ea9 in s_instance.var_aeba4321) {
        var_4a416ea9 clientfield::set("" + #"hash_487b1e88cb277c0e", 0);
    }
}

// Namespace namespace_767001c4/namespace_1b47c84a
// Params 1, eflags: 0x0
// Checksum 0x4cbec9de, Offset: 0x1ee0
// Size: 0x1ac
function function_e015cc87(s_instance) {
    level endon(#"hash_68c9737a7650da7f");
    s_instance.var_7de9fe61 = 0;
    while (true) {
        if (s_instance.var_7de9fe61 < s_instance.n_max_active) {
            s_spawn_point = array::random(s_instance.var_fe2612fe[#"spawn_pt"]);
            var_82706add = function_a45cb92c(s_instance.var_47971731, s_instance.var_fca3014a, s_instance.var_6ae3ddca, s_instance.var_8e4b249c);
            if (isdefined(var_82706add)) {
                ai_spawned = namespace_85745671::function_9d3ad056(var_82706add, s_spawn_point.origin, s_spawn_point.angles, "generator_zombie");
            }
            wait 0.1;
            if (isdefined(ai_spawned)) {
                s_instance.var_7de9fe61++;
                ai_spawned clientfield::set("" + #"hash_501374858f77990b", 1);
                ai_spawned thread function_ee076e63(s_instance);
                if (math::cointoss(75)) {
                    ai_spawned thread function_98446b63();
                }
            }
        }
        wait s_instance.var_47b4a0f4;
    }
}

// Namespace namespace_767001c4/namespace_1b47c84a
// Params 0, eflags: 0x0
// Checksum 0x58cf4420, Offset: 0x2098
// Size: 0x84
function function_98446b63() {
    self endon(#"death");
    a_players = array::get_all_closest(self.origin, function_a1ef346b());
    if (isalive(a_players[0])) {
        awareness::function_c241ef9a(self, a_players[0], 30);
    }
}

// Namespace namespace_767001c4/namespace_1b47c84a
// Params 1, eflags: 0x0
// Checksum 0xb607062a, Offset: 0x2128
// Size: 0x2c
function function_ee076e63(instance) {
    self waittill(#"death");
    instance.var_7de9fe61--;
}

// Namespace namespace_767001c4/namespace_1b47c84a
// Params 1, eflags: 0x0
// Checksum 0x5e68d84e, Offset: 0x2160
// Size: 0xf2
function function_83eb80af(v_org) {
    var_a940cf88 = getaiarray();
    for (i = 0; i < var_a940cf88.size; i++) {
        if (is_true(var_a940cf88[i].allowdeath) && isalive(var_a940cf88[i]) && distancesquared(v_org, var_a940cf88[i].origin) <= function_a3f6cdac(5000)) {
            var_a940cf88[i] kill(undefined, undefined, undefined, undefined, undefined, 1);
        }
        waitframe(1);
    }
}

// Namespace namespace_767001c4/namespace_1b47c84a
// Params 3, eflags: 0x0
// Checksum 0xb4c362a4, Offset: 0x2260
// Size: 0x22c
function function_20c61a40(s_instance, n_group_size, var_b65109c = 0) {
    a_v_points = array::randomize(namespace_85745671::function_e4791424(self.origin, n_group_size, 80, 250));
    n_spawn_count = min(n_group_size, a_v_points.size);
    for (i = 0; i < n_spawn_count; i++) {
        var_82706add = function_a45cb92c(s_instance.var_b858b2bb, s_instance.var_85894d1d, s_instance.var_4e685ee8, s_instance.var_5c16fa45);
        if (isdefined(var_82706add)) {
            ai_spawned = namespace_85745671::function_9d3ad056(var_82706add, a_v_points[i].origin, a_v_points[i].angles, "switch_zombie");
        }
        if (isdefined(ai_spawned)) {
            ai_spawned clientfield::set("" + #"hash_501374858f77990b", 1);
            if (var_b65109c) {
                if (math::cointoss()) {
                    ai_spawned namespace_85745671::function_9758722("super_sprint");
                } else {
                    ai_spawned namespace_85745671::function_9758722("sprint");
                }
                ai_spawned thread function_98446b63();
                ai_spawned thread function_ef1909da(s_instance);
                namespace_85745671::function_744beb04(ai_spawned);
            } else {
                ai_spawned.wander_radius = 75;
            }
        }
        waitframe(1);
    }
}

// Namespace namespace_767001c4/namespace_1b47c84a
// Params 1, eflags: 0x0
// Checksum 0xf4477ccb, Offset: 0x2498
// Size: 0x34
function function_ef1909da(s_instance) {
    s_instance.var_79052acb++;
    self waittill(#"death");
    s_instance.var_79052acb--;
}

// Namespace namespace_767001c4/namespace_1b47c84a
// Params 4, eflags: 0x0
// Checksum 0x1c02ddbd, Offset: 0x24d8
// Size: 0x102
function function_a45cb92c(var_3f96c2ae, var_1d077d90, var_eadc993b, var_39fb3777) {
    switch (level.var_b48509f9) {
    case 1:
    default:
        var_6017f33e = namespace_679a22ba::function_ca209564(var_3f96c2ae);
        break;
    case 2:
        var_6017f33e = namespace_679a22ba::function_ca209564(var_1d077d90);
        break;
    case 3:
        var_6017f33e = namespace_679a22ba::function_ca209564(var_eadc993b);
        break;
    case 4:
        var_6017f33e = namespace_679a22ba::function_ca209564(var_39fb3777);
        break;
    }
    return var_6017f33e.var_990b33df;
}

