#using script_1029986e2bc8ca8e;
#using script_113dd7f0ea2a1d4f;
#using script_12538a87a80a2978;
#using script_3411bb48d41bd3b;
#using script_4163291d6e693552;
#using script_7fc996fe8678852;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\struct;
#using scripts\core_common\values_shared;
#using scripts\core_common\vehicle_shared;

#namespace namespace_de7e3a45;

// Namespace namespace_de7e3a45/level_init
// Params 1, eflags: 0x40
// Checksum 0x1fbf714e, Offset: 0x188
// Size: 0x6c
function event_handler[level_init] main(*eventstruct) {
    objective_manager::function_b3464a7c(#"hash_3eb0da94cd242359", &function_60363d07, &function_eced5dc3, #"hash_3eb0da94cd242359", #"hash_5478dfd9053cfa95");
}

// Namespace namespace_de7e3a45/namespace_de7e3a45
// Params 1, eflags: 0x0
// Checksum 0x1d22df21, Offset: 0x200
// Size: 0x28c
function function_60363d07(s_instance) {
    var_b4ee3cbe = s_instance.var_fe2612fe[#"vehicle_spawn"];
    n_player_count = getplayers().size;
    s_instance.a_vehicles = [];
    s_instance.a_targets = [];
    s_instance.var_c0c91a34 = [];
    s_instance.var_b7e3ebe5 = 0;
    s_instance.var_a4f70b85 = 300;
    s_instance.var_aa7fd124 = 0;
    s_instance.var_aa7fd124 = s_instance.script_string;
    foreach (var_50b7449f in var_b4ee3cbe) {
        var_22e1dc7 = function_d3dc11aa(var_50b7449f);
        vh = spawnvehicle(var_22e1dc7, var_50b7449f.origin, var_50b7449f.angles, "vh_arm_ass");
        vh callback::function_d8abfc3d(#"hash_666d48a558881a36", &function_23416d96);
        s_instance.a_vehicles[s_instance.a_vehicles.size] = vh;
    }
    a_s_targets = function_2e268449();
    s_instance.var_376c2fa2 = a_s_targets.size;
    foreach (s_target in a_s_targets) {
        model = namespace_8b6a9d79::spawn_script_model(s_target, s_target.model);
        s_instance.var_c0c91a34[s_instance.var_c0c91a34.size] = model;
    }
}

// Namespace namespace_de7e3a45/namespace_de7e3a45
// Params 1, eflags: 0x0
// Checksum 0x5c45b563, Offset: 0x498
// Size: 0x41c
function function_eced5dc3(s_instance) {
    foreach (player in getplayers()) {
        level.var_31028c5d prototype_hud::function_7491d6c5(player, #"hash_2b4b50b6d6ced931");
    }
    foreach (e_player in getplayers()) {
        level.var_31028c5d prototype_hud::set_active_objective_string(e_player, #"hash_2b4b50b6d6ced931");
        level.var_31028c5d prototype_hud::function_817e4d10(e_player, 1);
    }
    objective_manager::function_9f6de950(s_instance.var_376c2fa2);
    foreach (vehicle in s_instance.a_vehicles) {
        vehicle makevehicleusable();
    }
    foreach (var_f65aced2 in s_instance.var_fe2612fe[#"hash_8085f1917671915"]) {
        var_f65aced2 function_baa85b22(#"hash_7cba8a05511ceedf");
    }
    foreach (var_41702d2e in s_instance.var_fe2612fe[#"hash_243be8ccd7afb845"]) {
        var_41702d2e thread function_baa85b22(#"hash_4f87aa2a203d37d0", 3);
    }
    foreach (mdl_target in s_instance.var_c0c91a34) {
        mdl_target function_d5566653(s_instance);
        mdl_target thread namespace_7589cf5c::function_8eafd734();
        mdl_target objective_manager::function_3b0ab786();
    }
    level thread objective_complete(s_instance);
}

// Namespace namespace_de7e3a45/namespace_de7e3a45
// Params 1, eflags: 0x0
// Checksum 0xf1f6c878, Offset: 0x8c0
// Size: 0xc2
function function_d3dc11aa(var_e56f5f30) {
    var_adfb6456 = var_e56f5f30.script_string;
    if (!isdefined(var_adfb6456)) {
        return "veh_mil_ru_fav_heavy";
    }
    switch (var_adfb6456) {
    default:
        return "veh_mil_ru_fav_heavy";
    case #"tank":
        return "vehicle_t9_mil_ru_tank_t72";
    case #"heli":
        return "vehicle_t9_mil_ru_heli_gunship_hind";
    case #"fav":
        return "vehicle_t9_mil_fav_light";
    case #"hash_651e19135e5ba3":
        return "veh_mil_ru_fav_heavy";
    }
}

// Namespace namespace_de7e3a45/namespace_de7e3a45
// Params 1, eflags: 0x0
// Checksum 0x2916b985, Offset: 0x990
// Size: 0x4c
function function_23416d96(params) {
    player = params.player;
    level.var_31028c5d prototype_hud::set_active_objective_string(player, #"hash_55b4a3c38d58604");
}

// Namespace namespace_de7e3a45/namespace_de7e3a45
// Params 0, eflags: 0x0
// Checksum 0xa19019db, Offset: 0x9e8
// Size: 0x2da
function function_2e268449() {
    n_difficulty = level.var_72a4153b;
    switch (level.var_72a4153b) {
    case 0:
        var_1d2c345c = 5;
        var_22ab5a42 = 3;
        var_94b6a3f1 = 1;
        break;
    case 1:
        var_1d2c345c = 3;
        var_22ab5a42 = 5;
        var_94b6a3f1 = 1;
        break;
    case 2:
        var_1d2c345c = 1;
        var_22ab5a42 = 3;
        var_94b6a3f1 = 3;
        break;
    default:
        var_1d2c345c = 5;
        var_22ab5a42 = 3;
        var_94b6a3f1 = 1;
        break;
    }
    var_f8ac6bbd = struct::get_array(#"hash_133158f1ba9b6a0c", "content_key");
    var_ece85435 = struct::get_array(#"hash_13315bf1ba9b6f25", "content_key");
    var_d332a0c2 = struct::get_array(#"hash_13315af1ba9b6d72", "content_key");
    /#
        if (var_f8ac6bbd.size < var_1d2c345c) {
            errormsg("<dev string:x38>");
        }
        if (var_ece85435.size < var_22ab5a42) {
            errormsg("<dev string:x55>");
        }
        if (var_d332a0c2.size < var_94b6a3f1) {
            errormsg("<dev string:x72>");
        }
    #/
    var_ee4f1696 = function_42eb3d20(array::randomize(var_f8ac6bbd), var_1d2c345c);
    var_4aeed91e = function_42eb3d20(array::randomize(var_ece85435), var_22ab5a42);
    var_8f4719e8 = function_42eb3d20(array::randomize(var_d332a0c2), var_94b6a3f1);
    a_targets = arraycombine(var_ee4f1696, var_4aeed91e, 0);
    a_targets = arraycombine(a_targets, var_8f4719e8, 0);
    return a_targets;
}

// Namespace namespace_de7e3a45/namespace_de7e3a45
// Params 2, eflags: 0x0
// Checksum 0x594b829f, Offset: 0xcd0
// Size: 0x60
function function_42eb3d20(a_targets, n_count) {
    var_ff5233a3 = [];
    for (i = 0; i < n_count; i++) {
        array::add(var_ff5233a3, a_targets[i]);
    }
    return var_ff5233a3;
}

// Namespace namespace_de7e3a45/namespace_de7e3a45
// Params 1, eflags: 0x0
// Checksum 0xc149df9, Offset: 0xd38
// Size: 0xf4
function function_d5566653(s_instance) {
    switch (self.model) {
    case #"p8_fxanim_zm_red_omphalos_crystal_left_mod":
        var_3d014474 = 250;
        break;
    case #"p8_fxanim_zm_red_omphalos_crystal_right_mod":
        var_3d014474 = 550;
        break;
    case #"p8_fxanim_zm_red_omphalos_crystal_front_mod":
        var_3d014474 = 1050;
        break;
    }
    self.health = var_3d014474 * level.realm;
    self val::set("arm_ass_obj", "takedamage", 1);
    self function_2baad8fc();
    self thread function_5583a37f(s_instance);
}

// Namespace namespace_de7e3a45/namespace_de7e3a45
// Params 1, eflags: 0x0
// Checksum 0xc30f8410, Offset: 0xe38
// Size: 0xe4
function function_5583a37f(s_instance) {
    level endon(#"objective_ended", #"game_over");
    self waittill(#"death");
    if (isinarray(s_instance.var_c0c91a34, self)) {
        arrayremovevalue(s_instance.var_c0c91a34, self, 0);
    }
    s_instance.var_b7e3ebe5++;
    objective_manager::function_d28e25e7(s_instance.var_b7e3ebe5);
    self scene::play(#"hash_3bf0c346e621e068", self);
    self objective_manager::function_811514c3();
}

// Namespace namespace_de7e3a45/namespace_de7e3a45
// Params 1, eflags: 0x0
// Checksum 0x16f58c45, Offset: 0xf28
// Size: 0x18c
function objective_complete(s_instance) {
    level endon(#"game_over");
    while (s_instance.var_b7e3ebe5 < s_instance.var_376c2fa2) {
        wait 0.01;
    }
    var_3faba32e = array::random(s_instance.var_fe2612fe[#"hash_41ae283ea203de66"]);
    if (!isdefined(var_3faba32e)) {
        var_3faba32e = self;
    }
    level thread namespace_cda50904::function_a92a93e9(var_3faba32e.origin, var_3faba32e.angles);
    objective_manager::objective_ended(s_instance);
    foreach (player in getplayers()) {
        level.var_31028c5d prototype_hud::function_817e4d10(player, 0);
    }
    objective_manager::function_1571bce9(3);
    level thread namespace_7589cf5c::function_83eb80af(var_3faba32e.origin);
}

// Namespace namespace_de7e3a45/namespace_de7e3a45
// Params 2, eflags: 0x0
// Checksum 0x96fe66dc, Offset: 0x10c0
// Size: 0x100
function function_baa85b22(aitype, n_count = 15) {
    a_v_points = getrandomnavpoints(self.origin, 1000, n_count);
    n_spawn_count = min(n_count, a_v_points.size);
    for (i = 0; i < n_spawn_count; i++) {
        var_8b84b3ce = a_v_points[i] + (0, 0, 64);
        ai_spawned = namespace_85745671::function_9d3ad056(aitype, var_8b84b3ce, self.angles, "mob_zombie");
        if (isdefined(ai_spawned)) {
            ai_spawned.wander_radius = 200;
        }
        waitframe(1);
    }
}

