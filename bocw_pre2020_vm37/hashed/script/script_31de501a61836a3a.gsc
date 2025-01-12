#using script_1029986e2bc8ca8e;
#using script_113dd7f0ea2a1d4f;
#using script_12538a87a80a2978;
#using script_1cc417743d7c262d;
#using script_1cd491b1807da8f7;
#using script_215d7818c548cb51;
#using script_27347f09888ad15;
#using script_3357acf79ce92f4b;
#using script_3411bb48d41bd3b;
#using script_4163291d6e693552;
#using script_7fc996fe8678852;
#using scripts\core_common\ai\systems\gib;
#using scripts\core_common\animation_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\gameobjects_shared;
#using scripts\core_common\laststand_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\core_common\vehicle_shared;

#namespace namespace_fa1c4f0a;

// Namespace namespace_fa1c4f0a/level_init
// Params 1, eflags: 0x40
// Checksum 0x141e5340, Offset: 0x508
// Size: 0x15c
function event_handler[level_init] main(*eventstruct) {
    clientfield::register("scriptmover", "payload_teleport", 1, 2, "int");
    clientfield::register("scriptmover", "" + #"hash_85dd1e407a282d9", 1, 1, "int");
    clientfield::register("toplayer", "" + #"hash_19f93b2cb70ea2c5", 1, 1, "int");
    clientfield::register("vehicle", "" + #"hash_75190371f51baf5f", 1, 1, "counter");
    objective_manager::function_b3464a7c(#"payload_escort", &init, &function_d137dbd4, #"payload", #"hash_7cd75fcb4650df62");
}

// Namespace namespace_fa1c4f0a/namespace_fa1c4f0a
// Params 1, eflags: 0x0
// Checksum 0x23d793d6, Offset: 0x670
// Size: 0x6bc
function init(instance) {
    foreach (s_instance in instance.var_fe2612fe[#"payload"]) {
        if (isdefined(s_instance.var_fe2612fe[#"truck"])) {
            s_instance.var_738e322b = namespace_8b6a9d79::spawn_script_model(s_instance.var_fe2612fe[#"truck"][0], #"hash_476204ed994318f", 1);
        }
        wait 0.1;
        s_instance.var_b8ca9d7 = spawnvehicle(#"hash_d069dee6a0076c8", s_instance.origin, s_instance.angles, "vehicle_payload");
        s_instance.var_b8ca9d7.s_portal = s_instance.var_fe2612fe[#"portal"][0];
        s_instance.var_b8ca9d7.s_start = s_instance.var_fe2612fe[#"hash_13077c2a8907f2fe"][0];
        s_instance.var_b8ca9d7.var_559503f1 = s_instance.var_fe2612fe[#"hash_3d588f728a53044"];
        s_instance.var_b8ca9d7 vehicle::toggle_sounds(0);
        wait 1;
        s_instance.var_b8ca9d7 thread function_27033bf7(instance);
    }
    instance.var_4d0b3b87 = s_instance.var_fe2612fe[#"hash_41ae283ea203de66"][0];
    instance.var_1ac40948 = s_instance.var_738e322b;
    instance.var_b8ca9d7 = s_instance.var_b8ca9d7;
    instance.var_b8ca9d7.var_6a4ec994 = 0;
    instance.var_b8ca9d7.var_55b751c2 = array(#"c_t8_cottontop_monkey_fb1", #"hash_1dc27078a0cade2e", #"c_t8_zmb_homunculus_fb1");
    instance.var_b8ca9d7.var_dd6fe31f = 1;
    instance.var_b8ca9d7.var_43123efe = util::spawn_model(instance.var_b8ca9d7.var_55b751c2[instance.var_b8ca9d7.var_6a4ec994], instance.var_b8ca9d7 gettagorigin("tag_cage_attach"));
    if (isdefined(instance.var_b8ca9d7.var_43123efe)) {
        instance.var_b8ca9d7.var_43123efe linkto(instance.var_b8ca9d7, "tag_cage_attach", (0, 0, 0), (0, -180, 0));
    }
    if (isdefined(s_instance.var_fe2612fe[#"rift"])) {
        instance.var_d4f4d124 = s_instance.var_fe2612fe[#"rift"];
    }
    if (isdefined(instance.var_fe2612fe[#"hash_441da645c3f27eea"])) {
        instance thread function_9bf6c44a();
    }
    if (isdefined(instance.var_fe2612fe[#"hash_130c46547a55657e"])) {
        var_111c92a8 = namespace_8b6a9d79::function_cfa4f1a0(instance.var_fe2612fe[#"hash_130c46547a55657e"], #"hash_d1690065401e43a", 0);
        foreach (var_3cefdbf5 in var_111c92a8) {
            var_3cefdbf5 ghost();
        }
    }
    if (isdefined(instance.var_fe2612fe[#"hash_26ce2cbc6b535bb"])) {
        var_111c92a8 = namespace_8b6a9d79::function_cfa4f1a0(instance.var_fe2612fe[#"hash_26ce2cbc6b535bb"], #"hash_1435198d5240ac8c", 0);
        foreach (var_3cefdbf5 in var_111c92a8) {
            var_3cefdbf5 ghost();
        }
    }
    instance thread function_6e7546c5();
    instance thread function_f5087df2();
    instance thread function_83e5a141();
    instance.var_4272a188 thread objective_manager::function_98da2ed1(instance.var_4272a188.origin, "objectivePayloadApproach");
    if (instance.targetname === #"hash_38b51590859572ce" || instance.targetname === #"hash_65ab893bc664cd9e") {
        instance thread function_8853b577();
        return;
    }
    if (instance.targetname === #"hash_57f0a312931f2fb8") {
        instance thread function_68ec5e25();
        return;
    }
    if (instance.targetname === #"hash_4167bb06bca79ef8") {
        instance thread function_c7fdb1c1();
    }
}

// Namespace namespace_fa1c4f0a/namespace_fa1c4f0a
// Params 0, eflags: 0x0
// Checksum 0xfcc2ecf4, Offset: 0xd38
// Size: 0x26c
function function_c7fdb1c1() {
    self endon(#"objective_ended");
    self.var_b8ca9d7 endon(#"death");
    self.var_b8ca9d7 waittill(#"hash_38d901fbedc7bdc9");
    s_pt = struct::get(#"hash_38d901fbedc7bdc9");
    a_s_pts = namespace_85745671::function_e4791424(s_pt.origin, 32, 40, s_pt.radius);
    n_spawns = function_cb32786d();
    for (i = 0; i < n_spawns; i++) {
        if (isdefined(a_s_pts[i])) {
            self.var_b8ca9d7 thread function_dd9b1007(self, a_s_pts[i].origin, a_s_pts[i].angles);
        }
        waitframe(1);
    }
    wait 1;
    var_b54d7065 = getdynentarray("dynent_garage_button");
    doors = array::get_all_closest(s_pt.origin, var_b54d7065);
    var_dd05b6d = array(doors[0], doors[1]);
    foreach (door in var_dd05b6d) {
        if (function_ffdbe8c2(door)) {
            return;
        }
    }
    for (i = 0; i < 2; i++) {
        dynent_use::use_dynent(var_dd05b6d[i]);
        wait 1;
    }
}

// Namespace namespace_fa1c4f0a/namespace_fa1c4f0a
// Params 0, eflags: 0x0
// Checksum 0x77d76218, Offset: 0xfb0
// Size: 0x134
function function_68ec5e25() {
    self endon(#"objective_ended");
    self.var_b8ca9d7 endon(#"death");
    n_spawns = function_1fdb6ebc();
    self.var_b8ca9d7 waittill(#"ambush");
    a_s_pts = array::get_all_closest(self.var_b8ca9d7.origin, struct::get_array(#"hash_5b5314019699b18e"));
    for (i = 0; i < a_s_pts.size; i++) {
        for (j = 0; j < n_spawns; j++) {
            self.var_b8ca9d7 thread function_dd9b1007(self, a_s_pts[i].origin, a_s_pts[i].angles);
            wait 0.1;
        }
        wait 0.5;
    }
}

// Namespace namespace_fa1c4f0a/namespace_fa1c4f0a
// Params 0, eflags: 0x0
// Checksum 0x2bde90af, Offset: 0x10f0
// Size: 0xb0
function function_83e5a141() {
    self waittill(#"hash_79ba3aede845bbcc");
    if (isdefined(self.var_fe2612fe[#"hash_5615a127abad1354"])) {
        self.var_bce10cdf = namespace_8b6a9d79::spawn_script_model(self.var_fe2612fe[#"hash_5615a127abad1354"][0], #"hash_6a83a06a639fcc6b", 1);
        self.var_bce10cdf ghost();
    }
    self.var_b8ca9d7 waittill(#"deployed");
}

// Namespace namespace_fa1c4f0a/namespace_fa1c4f0a
// Params 0, eflags: 0x0
// Checksum 0xa63cdead, Offset: 0x11a8
// Size: 0x10c
function function_8853b577() {
    self endon(#"objective_ended");
    s_pos = struct::get(#"hash_d39d324a1e0fd99");
    self.var_b4418894 = spawn("trigger_radius", s_pos.origin, 0, s_pos.radius, 96);
    while (true) {
        s_result = self.var_b4418894 waittill(#"trigger");
        e_activator = s_result.activator;
        if (isdefined(e_activator) && isplayer(e_activator)) {
            self thread function_2ee9a08a(e_activator, s_pos);
            break;
        }
    }
}

// Namespace namespace_fa1c4f0a/namespace_fa1c4f0a
// Params 2, eflags: 0x0
// Checksum 0xcf0c27eb, Offset: 0x12c0
// Size: 0x1a4
function function_2ee9a08a(player, s_pos) {
    n_spawns = function_32cfca3a();
    a_s_spawns = struct::get_array(s_pos.target);
    for (i = 0; i < n_spawns; i++) {
        var_7ecdee63 = function_aece4588(level.var_b48509f9);
        s_pt = array::random(a_s_spawns);
        ai_spawned = namespace_85745671::function_9d3ad056(var_7ecdee63, s_pt.origin, s_pt.angles, "bridge_zombie");
        wait 0.1;
        if (isdefined(ai_spawned)) {
            ai_spawned.var_ed0e316b = "super_sprint";
            ai_spawned callback::function_d8abfc3d(#"hash_4afe635f36531659", &function_fd68cae4);
            if (!isalive(player)) {
                player = array::random(getplayers());
            }
            if (isdefined(player)) {
                awareness::function_c241ef9a(ai_spawned, player, 15);
            }
        }
    }
}

// Namespace namespace_fa1c4f0a/namespace_fa1c4f0a
// Params 2, eflags: 0x0
// Checksum 0xf17da406, Offset: 0x1470
// Size: 0x164
function function_7ee743d1(player, s_pt) {
    self waittill(#"death");
    var_7ecdee63 = function_aece4588(level.var_b48509f9);
    s_spawnpt = struct::get(s_pt.target);
    ai_spawned = namespace_85745671::function_9d3ad056(var_7ecdee63, s_spawnpt.origin, s_spawnpt.angles, "bridge_zombie");
    wait 0.1;
    if (isdefined(ai_spawned)) {
        ai_spawned.var_ed0e316b = "super_sprint";
        ai_spawned callback::function_d8abfc3d(#"hash_4afe635f36531659", &function_fd68cae4);
        if (!isalive(player)) {
            player = array::random(getplayers());
        }
        if (isdefined(player)) {
            awareness::function_c241ef9a(ai_spawned, player, 15);
        }
    }
}

// Namespace namespace_fa1c4f0a/namespace_fa1c4f0a
// Params 0, eflags: 0x0
// Checksum 0x95a08599, Offset: 0x15e0
// Size: 0x9e
function function_32cfca3a() {
    switch (getplayers().size) {
    case 1:
        n_spawns = 16;
        break;
    case 2:
        n_spawns = 20;
        break;
    case 3:
        n_spawns = 24;
        break;
    case 4:
        n_spawns = 28;
        break;
    }
    return n_spawns;
}

// Namespace namespace_fa1c4f0a/namespace_fa1c4f0a
// Params 0, eflags: 0x0
// Checksum 0xacb03566, Offset: 0x1688
// Size: 0x13c
function function_f5087df2() {
    self waittill(#"objective_ended");
    foreach (player in getplayers()) {
        level.var_31028c5d prototype_hud::function_817e4d10(player, 0);
    }
    if (self.success) {
        level thread namespace_cda50904::function_a92a93e9(self.var_4d0b3b87.origin, self.var_4d0b3b87.angles);
        return;
    }
    wait 1;
    if (isdefined(self.var_b8ca9d7)) {
        self.var_b8ca9d7 dodamage(self.var_b8ca9d7.health, self.var_b8ca9d7.origin);
    }
}

// Namespace namespace_fa1c4f0a/namespace_fa1c4f0a
// Params 5, eflags: 0x0
// Checksum 0x4578ee2d, Offset: 0x17d0
// Size: 0x132
function function_de42eeef(str_model, v_offset, v_ang, n_forward, n_scale) {
    self setbrake(1);
    wait 0.5;
    v_forward = self.origin + vectornormalize(anglestoforward(self.angles)) * n_forward;
    var_6d29abb0 = util::spawn_model(str_model, v_forward + v_offset, v_ang);
    if (isdefined(var_6d29abb0)) {
        wait 0.1;
        var_6d29abb0.health = int(self.health * 0.4);
        var_6d29abb0 setscale(n_scale);
        var_6d29abb0 linkto(self);
        self.var_a04ece6e = var_6d29abb0;
    }
}

// Namespace namespace_fa1c4f0a/namespace_fa1c4f0a
// Params 2, eflags: 0x0
// Checksum 0x334d79db, Offset: 0x1910
// Size: 0x240
function function_d137dbd4(instance, activator) {
    if (isplayer(activator)) {
        activator playrumbleonentity("damage_light");
        activator thread util::delay(2.5, undefined, &globallogic_audio::leader_dialog_on_player, "objectivePayloadStart");
        level thread util::delay(2.5, undefined, &globallogic_audio::leader_dialog, "objectivePayloadStartResponse");
        instance notify(#"hash_79ba3aede845bbcc");
        instance.var_74ec00fb = 0;
        instance.n_zombies_max = function_23ab0822();
        foreach (player in getplayers()) {
            level.var_31028c5d prototype_hud::function_7491d6c5(player, #"hash_838284821745ec7");
        }
        wait 6;
        foreach (player in getplayers()) {
            level.var_31028c5d prototype_hud::set_active_objective_string(player, #"hash_838284821745ec7");
            level.var_31028c5d prototype_hud::function_817e4d10(player, 2);
        }
    }
}

// Namespace namespace_fa1c4f0a/namespace_fa1c4f0a
// Params 0, eflags: 0x0
// Checksum 0xc51c3ebb, Offset: 0x1b58
// Size: 0x9e
function function_23ab0822() {
    switch (getplayers().size) {
    case 1:
        n_spawns = 8;
        break;
    case 2:
        n_spawns = 12;
        break;
    case 3:
        n_spawns = 16;
        break;
    case 4:
        n_spawns = 20;
        break;
    }
    return n_spawns;
}

// Namespace namespace_fa1c4f0a/namespace_fa1c4f0a
// Params 1, eflags: 0x0
// Checksum 0xb209e3ff, Offset: 0x1c00
// Size: 0x4dc
function function_27033bf7(instance) {
    self endon(#"death");
    self val::set("payload", "takedamage", 1);
    self.overridevehicledamage = &function_ae595d6e;
    self.var_aa4b496 = 0;
    self.health = 6400;
    self.var_265cb589 = 1;
    self thread function_eb89f65f(instance);
    nd_start = getvehiclenode(self.s_start.target, "targetname");
    nd_start.var_d5ebc20b = getvehiclenode(nd_start.script_string, "targetname");
    n_time = nd_start.script_int;
    self vehicle::get_on_path(nd_start);
    instance waittill(#"hash_79ba3aede845bbcc");
    instance.var_1ac40948 playrumblelooponentity(#"hash_1903f70fddbadc53");
    instance.var_1ac40948 scene::play(#"p9_fxanim_sv_payload_delivery_open_bundle", instance.var_1ac40948);
    instance.var_1ac40948 stoprumble(#"hash_1903f70fddbadc53");
    self notify(#"hash_13077c2a8907f2fe");
    wait 1;
    self thread vehicle::go_path();
    self thread function_87de8025(instance);
    self thread function_6ae999c2(instance);
    self thread function_8469f022(instance);
    self.var_a123c71 = 1;
    self waittill(#"deployed");
    self.var_a123c71 = 0;
    self thread function_77c42a22(instance);
    self thread function_79ae8e99(instance);
    self thread function_9c54feb0(instance);
    self thread function_fe857bf3(instance);
    self thread function_612a9925();
    self thread function_7dc0fd48(instance);
    self thread payload_teleport(instance);
    self thread function_7d3ebd69(instance);
    self thread function_6fb6800a(instance);
    self thread function_738143f5(instance);
    self thread function_7ba09434(instance);
    if (instance.targetname === #"hash_38b51590859572ce") {
        self thread function_dcf94cdf(instance);
    }
    self waittill(#"hash_d737648ea5715c3");
    self.mdl_portal = util::spawn_model("tag_origin", nd_start.var_d5ebc20b.origin, (0, 90, 0));
    self.mdl_portal clientfield::set("final_battle_cloud_fx", 1);
    self.var_edbf8a99 = util::spawn_model("collision_player_cylinder_192", self.mdl_portal.origin, self.mdl_portal.angles);
    self.var_3e5ed63d = util::spawn_model("tag_origin", self.mdl_portal.origin + (0, 0, -1000), self.mdl_portal.angles);
    self.mdl_portal thread function_96e4980f(instance);
    if (isdefined(self.var_edbf8a99)) {
        self.var_edbf8a99 ghost();
    }
}

// Namespace namespace_fa1c4f0a/namespace_fa1c4f0a
// Params 15, eflags: 0x0
// Checksum 0xb8f3c1ff, Offset: 0x20e8
// Size: 0x14a
function function_ae595d6e(*einflictor, eattacker, idamage, *idflags, smeansofdeath, *weapon, *vpoint, *vdir, *shitloc, *vdamageorigin, *psoffsettime, *damagefromunderneath, *modelindex, *partname, *vsurfacenormal) {
    if (isdefined(modelindex) && isplayer(modelindex)) {
        partname = 0;
    } else if (isalive(modelindex)) {
        if (!self.var_aa4b496) {
            self thread function_d5c3d218();
        }
        if (vsurfacenormal === "MOD_MELEE") {
            partname = int(partname * 0.1);
            self playsound(#"hash_52e02ca86c5fa117");
        }
    } else if (vsurfacenormal === "MOD_EXPLOSIVE") {
        return partname;
    }
    return partname;
}

// Namespace namespace_fa1c4f0a/namespace_fa1c4f0a
// Params 0, eflags: 0x0
// Checksum 0xd5e8f5b9, Offset: 0x2240
// Size: 0x36c
function function_6e7546c5() {
    self endon(#"objective_ended");
    self.var_b8ca9d7 endon(#"death");
    self.var_fa6b9965 = [];
    for (i = 0; i < self.var_d4f4d124.size; i++) {
        foreach (var_2b357ce9 in self.var_d4f4d124) {
            if (var_2b357ce9.script_int == i) {
                self.var_fa6b9965[i] = var_2b357ce9;
            }
        }
    }
    self waittill(#"hash_79ba3aede845bbcc");
    self thread function_1c8e1b20();
    self.var_f16db373 = util::spawn_model("tag_origin", self.var_fa6b9965[0].origin);
    wait 0.1;
    if (isdefined(self.var_f16db373)) {
        self thread function_4ef90aaa();
        for (i = 1; i < self.var_d4f4d124.size; i++) {
            s_result = self.var_b8ca9d7 waittill(#"rift", #"reached_end_node");
            self.var_b8ca9d7.var_f5d0e3f6 = 1;
            if (s_result._notify === #"rift") {
                foreach (player in getplayers()) {
                    player thread namespace_77bd50da::function_cc8342e0(#"hash_77b143b26eb21b9f", 4);
                }
                self.var_f16db373 playrumblelooponentity(#"hash_1903f70fddbadc53");
                wait 4;
                self.var_f16db373 stoprumble(#"hash_1903f70fddbadc53");
            }
            self.var_f16db373 moveto(self.var_fa6b9965[i].origin, 0.05);
            self.var_b8ca9d7 notify(#"hash_d737648ea5715c3");
            self.var_b8ca9d7.var_f5d0e3f6 = 0;
            self thread function_4ef90aaa();
        }
    }
}

// Namespace namespace_fa1c4f0a/namespace_fa1c4f0a
// Params 0, eflags: 0x0
// Checksum 0xb303f194, Offset: 0x25b8
// Size: 0xd8
function function_4ef90aaa() {
    self endon(#"objective_ended");
    self.var_b8ca9d7 endon(#"death", #"hash_d737648ea5715c3");
    self.var_f16db373 endon(#"death");
    while (true) {
        self.var_f16db373 clientfield::set("" + #"hash_501374858f77990b", 1);
        wait 1.5;
        self.var_f16db373 clientfield::set("" + #"hash_501374858f77990b", 0);
        wait 0.1;
    }
}

// Namespace namespace_fa1c4f0a/namespace_fa1c4f0a
// Params 0, eflags: 0x0
// Checksum 0x1cf0d861, Offset: 0x2698
// Size: 0x6c
function function_1c8e1b20() {
    self endon(#"objective_ended");
    self.var_b8ca9d7 endon(#"death");
    self.var_b8ca9d7 waittill(#"hash_193c92bb1c6df0e7");
    if (isdefined(self.var_f16db373)) {
        self.var_f16db373 delete();
    }
}

// Namespace namespace_fa1c4f0a/namespace_fa1c4f0a
// Params 1, eflags: 0x0
// Checksum 0x3c04b198, Offset: 0x2710
// Size: 0x144
function function_96e4980f(instance) {
    self notify("62c81d1096cf3b8c");
    self endon("62c81d1096cf3b8c");
    self endon(#"death");
    instance endon(#"objective_ended");
    while (true) {
        foreach (player in function_a1ef346b()) {
            if (distance(player.origin, self.origin) < 3000 && player util::is_player_looking_at(self.origin, 0.6, 1, self)) {
                player globallogic_audio::play_taacom_dialog("objectivePayloadRiftAhead");
                return;
            }
        }
        wait 1;
    }
}

// Namespace namespace_fa1c4f0a/namespace_fa1c4f0a
// Params 0, eflags: 0x0
// Checksum 0x27ae4874, Offset: 0x2860
// Size: 0x6e
function function_d5c3d218() {
    self endon(#"death");
    self.var_aa4b496 = 1;
    self playloopsound(#"hash_2a034c2643fc1322");
    wait 4.75;
    self stoploopsound();
    self.var_aa4b496 = 0;
}

// Namespace namespace_fa1c4f0a/namespace_fa1c4f0a
// Params 0, eflags: 0x0
// Checksum 0xcbfab7cf, Offset: 0x28d8
// Size: 0x1d0
function function_612a9925() {
    self endon(#"death");
    n_start_health = self.health;
    objective_manager::function_91574ec1(level.progress_bar, undefined, undefined, undefined, "objective_ended", 1);
    var_8da3e170 = self.health / n_start_health;
    objective_manager::function_5d1c184(var_8da3e170);
    while (true) {
        var_c3a3ae13 = self.health / n_start_health;
        if (var_c3a3ae13 >= 0 && var_8da3e170 != var_c3a3ae13) {
            objective_manager::function_5d1c184(var_c3a3ae13);
        }
        var_8da3e170 = var_c3a3ae13;
        if (var_c3a3ae13 <= 0.5 && !is_true(self.var_5e22f781)) {
            self.var_5e22f781 = 1;
            array::thread_all(function_a1ef346b(), &globallogic_audio::play_taacom_dialog, "objectivePayloadHalfHealth");
        }
        if (var_c3a3ae13 <= 0.15 && !is_true(self.var_2eb5c0e8)) {
            self.var_2eb5c0e8 = 1;
            array::thread_all(function_a1ef346b(), &globallogic_audio::play_taacom_dialog, "objectivePayloadCritical");
        }
        wait 0.1;
    }
}

// Namespace namespace_fa1c4f0a/namespace_fa1c4f0a
// Params 1, eflags: 0x0
// Checksum 0xccd21375, Offset: 0x2ab0
// Size: 0x1ac
function function_7ae9616f(instance) {
    self endon(#"death");
    instance endon(#"objective_ended");
    var_d730bd8c = getvehiclenode("sanatorium_path", "targetname");
    var_b54d7065 = getdynentarray("dynent_garage_button");
    doors = array::get_all_closest(var_d730bd8c.origin, var_b54d7065);
    var_dd05b6d = array(doors[0], doors[1]);
    foreach (door in var_dd05b6d) {
        if (function_ffdbe8c2(door)) {
            return;
        }
    }
    for (i = 0; i < 2; i++) {
        dynent_use::use_dynent(var_dd05b6d[i]);
        wait randomfloatrange(0.2, 0.5);
    }
}

// Namespace namespace_fa1c4f0a/namespace_fa1c4f0a
// Params 1, eflags: 0x0
// Checksum 0xc581b297, Offset: 0x2c68
// Size: 0x150
function function_7dc0fd48(instance) {
    self endon(#"death");
    instance endon(#"objective_ended");
    self waittill(#"door");
    var_4b03566e = (100, 100, 75);
    var_bcdc6e24 = self getcentroid();
    var_e86a4d9 = function_db4bc717(var_bcdc6e24, var_4b03566e);
    foreach (dynent in var_e86a4d9) {
        if (isdefined(dynent)) {
            dynent dodamage(dynent.health, dynent.origin, undefined, undefined, "none", "MOD_EXPLOSIVE");
        }
    }
}

// Namespace namespace_fa1c4f0a/namespace_fa1c4f0a
// Params 1, eflags: 0x0
// Checksum 0x3c952c4d, Offset: 0x2dc0
// Size: 0x174
function function_dcf94cdf(instance) {
    self endon(#"death");
    instance endon(#"objective_ended");
    self waittill(#"custom");
    s_pt = struct::get(#"hash_36e0ba5eb8ca6cf1");
    a_s_pts = namespace_85745671::function_e4791424(s_pt.origin, 16, 40, s_pt.radius);
    if (!isdefined(a_s_pts)) {
        return;
    }
    var_559503f1 = array::randomize(a_s_pts);
    n_spawns = function_cb32786d();
    for (i = 0; i < n_spawns; i++) {
        if (isdefined(var_559503f1[i])) {
            self thread function_dd9b1007(instance, var_559503f1[i].origin, var_559503f1[i].angles);
        }
        wait randomfloatrange(0.5, 1);
    }
}

// Namespace namespace_fa1c4f0a/namespace_fa1c4f0a
// Params 0, eflags: 0x0
// Checksum 0x2705f21e, Offset: 0x2f40
// Size: 0xae
function function_cb32786d() {
    n_players = getplayers().size;
    switch (n_players) {
    case 1:
        n_spawns = 8;
        break;
    case 2:
        n_spawns = 12;
        break;
    case 3:
        n_spawns = 16;
        break;
    case 4:
        n_spawns = 20;
        break;
    }
    return n_spawns;
}

// Namespace namespace_fa1c4f0a/namespace_fa1c4f0a
// Params 1, eflags: 0x0
// Checksum 0x7f2e24f2, Offset: 0x2ff8
// Size: 0x70
function function_6fb6800a(instance) {
    self endon(#"death");
    instance endon(#"objective_ended");
    while (true) {
        self waittill(#"attack");
        self thread function_9d51d729(instance);
    }
}

// Namespace namespace_fa1c4f0a/namespace_fa1c4f0a
// Params 1, eflags: 0x0
// Checksum 0x1c361737, Offset: 0x3070
// Size: 0x224
function function_9d51d729(instance) {
    self endon(#"death");
    instance endon(#"objective_ended");
    if (isdefined(self.currentnode.script_height)) {
        var_9df66c84 = (0, 0, self.currentnode.script_height);
    } else {
        var_9df66c84 = (0, 0, 0);
    }
    v_forward = vectornormalize(anglestoforward(self.currentnode.angles)) * self.currentnode.radius + self.currentnode.origin;
    if (!isdefined(v_forward)) {
        return;
    }
    if (isdefined(self.currentnode.script_radius)) {
        n_radius = self.currentnode.script_radius;
    } else {
        n_radius = 100;
    }
    a_s_pts = namespace_85745671::function_e4791424(v_forward + var_9df66c84, 16, 40, n_radius);
    if (!isdefined(a_s_pts)) {
        return;
    }
    var_559503f1 = array::randomize(a_s_pts);
    n_spawns = function_1fdb6ebc();
    for (i = 0; i < n_spawns; i++) {
        if (isdefined(var_559503f1[i]) && instance.var_74ec00fb < instance.n_zombies_max) {
            self thread function_dd9b1007(instance, var_559503f1[i].origin, var_559503f1[i].angles);
        }
        wait randomfloatrange(0.5, 1);
    }
}

// Namespace namespace_fa1c4f0a/namespace_fa1c4f0a
// Params 0, eflags: 0x0
// Checksum 0xd734a659, Offset: 0x32a0
// Size: 0xfe
function function_1fdb6ebc() {
    n_players = getplayers().size;
    switch (n_players) {
    case 1:
        n_spawns = randomintrange(2, 5);
        break;
    case 2:
        n_spawns = randomintrange(2, 5);
        break;
    case 3:
        n_spawns = randomintrange(3, 5);
        break;
    case 4:
        n_spawns = randomintrange(4, 6);
        break;
    }
    return n_spawns;
}

// Namespace namespace_fa1c4f0a/namespace_fa1c4f0a
// Params 1, eflags: 0x0
// Checksum 0xf852e3c7, Offset: 0x33a8
// Size: 0x70
function function_738143f5(instance) {
    self endon(#"death");
    instance endon(#"objective_ended");
    while (true) {
        self waittill(#"assault");
        self thread function_95015f9a(instance);
    }
}

// Namespace namespace_fa1c4f0a/namespace_fa1c4f0a
// Params 1, eflags: 0x0
// Checksum 0xfed9d1e2, Offset: 0x3420
// Size: 0x120
function function_7ba09434(instance) {
    self endon(#"death");
    instance endon(#"objective_ended");
    while (true) {
        self waittill(#"special");
        n_players = getplayers().size;
        if (!isdefined(n_players)) {
            continue;
        }
        v_ground = self function_6d122cef();
        if (!isdefined(v_ground)) {
            return;
        }
        a_s_pts = namespace_85745671::function_e4791424(v_ground, 24, 80, 200);
        if (!isdefined(a_s_pts)) {
            return;
        }
        var_559503f1 = array::randomize(a_s_pts);
        self function_d2ee3e36(instance, n_players, var_559503f1);
    }
}

// Namespace namespace_fa1c4f0a/namespace_fa1c4f0a
// Params 1, eflags: 0x0
// Checksum 0xa6fd13e5, Offset: 0x3548
// Size: 0x144
function function_7d3ebd69(instance) {
    self endon(#"death");
    instance endon(#"objective_ended");
    self waittill(#"heavy");
    var_3955def4 = self.s_portal.origin;
    v_ang = self.s_portal.angles;
    var_e4c6e64a = namespace_85745671::function_9d3ad056(#"hash_4f87aa2a203d37d0", var_3955def4, v_ang, "payload_zombie");
    wait 0.1;
    if (isdefined(var_e4c6e64a)) {
        a_players = array::get_all_closest(var_e4c6e64a.origin, getplayers());
        player = a_players[0];
        awareness::function_c241ef9a(var_e4c6e64a, player, 10);
        var_e4c6e64a thread function_6f9744dc(instance, self);
    }
}

// Namespace namespace_fa1c4f0a/namespace_fa1c4f0a
// Params 2, eflags: 0x0
// Checksum 0xefe317b3, Offset: 0x3698
// Size: 0x8c
function function_6f9744dc(instance, var_b8ca9d7) {
    instance endon(#"objective_ended");
    self endon(#"death");
    var_b8ca9d7 endon(#"death");
    var_b8ca9d7 waittill(#"hash_32687071c727f6e4");
    self animation::play("ai_zm_dlc3_armored_zombie_enrage");
}

// Namespace namespace_fa1c4f0a/namespace_fa1c4f0a
// Params 1, eflags: 0x0
// Checksum 0xc45c3311, Offset: 0x3730
// Size: 0x14c
function function_95015f9a(instance) {
    self endon(#"death");
    instance endon(#"objective_ended");
    v_ground = self function_6d122cef();
    if (!isdefined(v_ground)) {
        return;
    }
    a_s_pts = namespace_85745671::function_e4791424(v_ground, 32, 40, 1200);
    if (!isdefined(a_s_pts)) {
        return;
    }
    var_559503f1 = array::randomize(a_s_pts);
    n_spawns = function_dae1a57b();
    for (i = 0; i < n_spawns; i++) {
        if (isdefined(var_559503f1[i]) && instance.var_74ec00fb < instance.n_zombies_max) {
            self thread function_dd9b1007(instance, var_559503f1[i].origin, var_559503f1[i].angles);
        }
        wait 0.1;
    }
}

// Namespace namespace_fa1c4f0a/namespace_fa1c4f0a
// Params 0, eflags: 0x0
// Checksum 0x108b6b06, Offset: 0x3888
// Size: 0x14a
function function_6d122cef() {
    self endon(#"death");
    nd_current = self.currentnode;
    if (isdefined(nd_current)) {
        v_forward = vectornormalize(anglestoforward(nd_current.angles)) * 2400 + nd_current.origin;
    } else {
        v_forward = vectornormalize(anglestoforward(self.angles)) * 2400 + self.origin;
    }
    if (isdefined(v_forward)) {
        v_ground = groundtrace(v_forward + (0, 0, 1000), v_forward + (0, 0, -1000), 0, self)[#"position"];
    }
    if (!isdefined(v_ground)) {
        if (isdefined(self.nextnode)) {
            v_ground = self.nextnode.origin;
        } else {
            v_ground = self.origin;
        }
    }
    return v_ground;
}

// Namespace namespace_fa1c4f0a/namespace_fa1c4f0a
// Params 3, eflags: 0x0
// Checksum 0xcf9153b1, Offset: 0x39e0
// Size: 0xdc
function function_dd9b1007(instance, v_spawnpt, v_ang) {
    self endon(#"death");
    instance endon(#"objective_ended");
    var_7ecdee63 = function_aece4588(level.var_b48509f9);
    ai_spawned = namespace_85745671::function_9d3ad056(var_7ecdee63, v_spawnpt, v_ang, "payload_zombie");
    wait 0.1;
    if (isdefined(ai_spawned)) {
        instance.var_74ec00fb++;
        ai_spawned thread function_84d85877(instance);
        ai_spawned thread function_bf606a73(self, instance);
    }
}

// Namespace namespace_fa1c4f0a/namespace_fa1c4f0a
// Params 1, eflags: 0x0
// Checksum 0xaef1af80, Offset: 0x3ac8
// Size: 0x44
function function_84d85877(instance) {
    instance endon(#"objective_ended");
    self waittill(#"death");
    instance.var_74ec00fb--;
}

// Namespace namespace_fa1c4f0a/namespace_fa1c4f0a
// Params 3, eflags: 0x0
// Checksum 0xbe9f6c15, Offset: 0x3b18
// Size: 0x35c
function function_d2ee3e36(instance, n_players, var_559503f1) {
    self endon(#"death");
    instance endon(#"objective_ended");
    var_de82b392 = [];
    switch (level.var_b48509f9) {
    case 0:
    case 1:
    case 2:
        instance.var_fcf94480 = randomintrangeinclusive(n_players + 1, n_players + 4);
        if (math::cointoss()) {
            var_6b2ccc6b = #"hash_2855f060aad4ae87";
        } else if (level.var_b48509f9 < 2) {
            var_6b2ccc6b = #"hash_2855f060aad4ae87";
        } else {
            var_6b2ccc6b = #"hash_42cbb8cb19ae56dd";
        }
        for (i = 0; i < instance.var_fcf94480; i++) {
            if (math::cointoss(60)) {
                var_de82b392[var_de82b392.size] = var_6b2ccc6b;
                continue;
            }
            var_de82b392[var_de82b392.size] = var_6b2ccc6b;
        }
        break;
    case 3:
    case 4:
        if (math::cointoss()) {
            instance.var_fcf94480 = 1;
            var_de82b392[var_de82b392.size] = #"spawner_bo5_avogadro_sr";
        } else {
            instance.var_fcf94480 = randomintrangeinclusive(n_players + 1, n_players + 4);
            var_de82b392[var_de82b392.size] = #"hash_42cbb8cb19ae56dd";
        }
        break;
    default:
        instance.var_fcf94480 = 1;
        if (math::cointoss()) {
            var_de82b392[var_de82b392.size] = #"spawner_bo5_avogadro_sr";
        } else {
            var_de82b392[var_de82b392.size] = #"hash_4f87aa2a203d37d0";
        }
        break;
    }
    for (i = 0; i < var_de82b392.size; i++) {
        if (isdefined(var_559503f1[i])) {
            ai_spawned = namespace_85745671::function_9d3ad056(var_de82b392[i], var_559503f1[i].origin, var_559503f1[i].angles, "payload_zombie");
            wait 0.1;
            if (isdefined(ai_spawned)) {
                ai_spawned thread function_bf606a73(self, instance);
            }
        }
        wait randomfloatrange(0.5, 1);
    }
}

// Namespace namespace_fa1c4f0a/namespace_fa1c4f0a
// Params 1, eflags: 0x0
// Checksum 0xfe0c77a0, Offset: 0x3e80
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

// Namespace namespace_fa1c4f0a/namespace_fa1c4f0a
// Params 1, eflags: 0x0
// Checksum 0x23967d6a, Offset: 0x3f10
// Size: 0x194
function function_77c42a22(instance) {
    self endon(#"death");
    instance endon(#"objective_ended");
    self waittill(#"hash_32687071c727f6e4");
    var_559503f1 = array::randomize(self.var_559503f1);
    n_spawned = 0;
    n_total = function_ce92dcb0();
    for (i = 0; i < n_total; i++) {
        var_7ecdee63 = function_aece4588(level.var_b48509f9);
        ai_spawned = namespace_85745671::function_9d3ad056(var_7ecdee63, var_559503f1[i].origin, var_559503f1[i].angles, "payload_zombie");
        if (isdefined(ai_spawned)) {
            ai_spawned.var_8046dccf = 1;
            ai_spawned thread function_bf606a73(self, instance);
            n_spawned++;
            if (n_spawned >= n_total) {
                break;
            }
        }
        if (i >= self.var_559503f1.size - 1) {
            i = 0;
        }
        waitframe(1);
    }
    self thread function_9b6490c4(instance);
}

// Namespace namespace_fa1c4f0a/namespace_fa1c4f0a
// Params 1, eflags: 0x0
// Checksum 0x43eefe9b, Offset: 0x40b0
// Size: 0x178
function function_9b6490c4(instance) {
    instance endon(#"objective_ended");
    self endon(#"death", #"approach");
    instance.n_active = function_dae1a57b();
    instance.n_spawned = 0;
    self waittill(#"portal");
    while (true) {
        if (instance.n_spawned < instance.n_active) {
            var_7ecdee63 = function_aece4588(level.var_b48509f9);
            ai_spawned = namespace_85745671::function_9d3ad056(var_7ecdee63, self.s_portal.origin, self.s_portal.angles, "payload_zombie");
            if (isdefined(ai_spawned)) {
                instance.n_spawned++;
                ai_spawned thread zombie_death_watcher(instance);
                ai_spawned thread function_bf606a73(self, instance);
            }
        }
        wait randomfloatrange(0.1, 0.25);
    }
}

// Namespace namespace_fa1c4f0a/namespace_fa1c4f0a
// Params 1, eflags: 0x0
// Checksum 0x9a719eff, Offset: 0x4230
// Size: 0x44
function zombie_death_watcher(instance) {
    instance endon(#"objective_ended");
    self waittill(#"death");
    instance.n_spawned--;
}

// Namespace namespace_fa1c4f0a/namespace_fa1c4f0a
// Params 0, eflags: 0x0
// Checksum 0x6775fa53, Offset: 0x4280
// Size: 0xae
function function_dae1a57b() {
    n_players = getplayers().size;
    switch (n_players) {
    case 1:
        n_spawns = 4;
        break;
    case 2:
        n_spawns = 6;
        break;
    case 3:
        n_spawns = 9;
        break;
    case 4:
        n_spawns = 13;
        break;
    }
    return n_spawns;
}

// Namespace namespace_fa1c4f0a/namespace_fa1c4f0a
// Params 0, eflags: 0x0
// Checksum 0xfe0b984e, Offset: 0x4338
// Size: 0xae
function function_ce92dcb0() {
    n_players = getplayers().size;
    switch (n_players) {
    case 1:
        n_spawns = 8;
        break;
    case 2:
        n_spawns = 12;
        break;
    case 3:
        n_spawns = 16;
        break;
    case 4:
        n_spawns = 20;
        break;
    }
    return n_spawns;
}

// Namespace namespace_fa1c4f0a/namespace_fa1c4f0a
// Params 1, eflags: 0x0
// Checksum 0xc5ce934a, Offset: 0x43f0
// Size: 0x270
function function_785ea4f4(instance) {
    self endon(#"death");
    objective_setinvisibletoall(self.n_objective_id);
    self ghost();
    if (self.var_6a4ec994 == 2) {
        self.var_43123efe scene::stop();
    }
    self.var_43123efe delete();
    wait 2;
    self notify(#"approach");
    self clientfield::increment("" + #"hash_75190371f51baf5f");
    wait 0.25;
    self thread function_68598c43(instance);
    wait 4;
    self.mdl_portal clientfield::set("final_battle_cloud_fx", 0);
    wait 0.1;
    self playrumbleonentity(#"sr_payload_portal_final_rumble");
    if (isdefined(self.mdl_portal)) {
        self.mdl_portal delete();
    }
    if (isdefined(self.var_3e5ed63d)) {
        self.var_3e5ed63d delete();
    }
    if (isdefined(self.var_edbf8a99)) {
        self.var_edbf8a99 delete();
    }
    foreach (player in getplayers()) {
        player.var_d23362c = 0;
        player clientfield::set_to_player("" + #"hash_19f93b2cb70ea2c5", 0);
    }
}

// Namespace namespace_fa1c4f0a/namespace_fa1c4f0a
// Params 1, eflags: 0x0
// Checksum 0x6c963e82, Offset: 0x4668
// Size: 0x138
function function_68598c43(instance) {
    instance endon(#"objective_ended");
    self endon(#"death");
    a_zombies = function_a38db454(self.origin, 5000);
    foreach (zombie in a_zombies) {
        if (isdefined(zombie)) {
            zombie.allowdeath = 1;
            if (zombie.archetype === #"zombie") {
                gibserverutils::annihilate(zombie);
            }
            zombie kill(undefined, undefined, undefined, undefined, undefined, 1);
        }
    }
}

// Namespace namespace_fa1c4f0a/namespace_fa1c4f0a
// Params 2, eflags: 0x0
// Checksum 0x45a3054d, Offset: 0x47a8
// Size: 0xa4
function function_cd8da208(var_b8ca9d7, instance) {
    self endon(#"death");
    var_b8ca9d7 endon(#"death");
    instance endon(#"objective_ended");
    if (math::cointoss()) {
        awareness::function_c241ef9a(self, var_b8ca9d7, 15);
        return;
    }
    self thread function_bf606a73(var_b8ca9d7, instance);
}

// Namespace namespace_fa1c4f0a/namespace_fa1c4f0a
// Params 2, eflags: 0x0
// Checksum 0x1afe515, Offset: 0x4858
// Size: 0x196
function function_bf606a73(var_b8ca9d7, instance) {
    self endon(#"death");
    var_b8ca9d7 endon(#"death");
    instance endon(#"objective_ended");
    if (is_true(self.var_8046dccf)) {
        self.var_ed0e316b = "super_sprint";
    } else {
        self.var_ed0e316b = "sprint";
    }
    self callback::function_d8abfc3d(#"hash_4afe635f36531659", &function_fd68cae4);
    wait 0.1;
    while (true) {
        a_players = getplayers();
        player = array::get_all_closest(var_b8ca9d7.origin, a_players)[0];
        if (!isdefined(self.var_b7e90547) && isalive(self) && isalive(player)) {
            self.var_b7e90547 = 1;
            awareness::function_c241ef9a(self, player, 15);
        }
        wait 15;
        self.var_b7e90547 = undefined;
    }
}

// Namespace namespace_fa1c4f0a/namespace_fa1c4f0a
// Params 0, eflags: 0x0
// Checksum 0x561a4633, Offset: 0x49f8
// Size: 0x3c
function function_fd68cae4() {
    if (self.archetype == #"zombie") {
        self namespace_85745671::function_9758722(self.var_ed0e316b);
    }
}

// Namespace namespace_fa1c4f0a/namespace_fa1c4f0a
// Params 1, eflags: 0x0
// Checksum 0x7b0437b2, Offset: 0x4a40
// Size: 0x1b4
function function_9049ebf8(instance) {
    self endon(#"death", #"reached_end_node");
    instance endon(#"objective_ended");
    level waittill(#"hash_681a588173f0b1d7");
    if (is_true(self.var_a123c71)) {
        foreach (player in getplayers()) {
            player thread namespace_77bd50da::function_cc8342e0(#"hash_6f586260feee0e75", 8);
        }
    }
    while (is_true(self.var_a123c71)) {
        wait 0.1;
    }
    self thread function_dd677e5d();
    self notify(#"destruct");
    self setbrake(1);
    wait 2;
    self dodamage(self.health, self.origin);
}

// Namespace namespace_fa1c4f0a/namespace_fa1c4f0a
// Params 0, eflags: 0x0
// Checksum 0xf2673f01, Offset: 0x4c00
// Size: 0x108
function function_dd677e5d() {
    if (isdefined(self.mdl_portal)) {
        self.mdl_portal delete();
    }
    if (isdefined(self.var_3e5ed63d)) {
        self.var_3e5ed63d delete();
    }
    foreach (player in getplayers()) {
        player.var_d23362c = 0;
        player clientfield::set_to_player("" + #"hash_19f93b2cb70ea2c5", 0);
    }
}

// Namespace namespace_fa1c4f0a/namespace_fa1c4f0a
// Params 1, eflags: 0x0
// Checksum 0x19f182, Offset: 0x4d10
// Size: 0x64
function function_fe857bf3(instance) {
    instance endon(#"objective_ended");
    self waittill(#"death");
    if (isdefined(self)) {
        self.var_a123c71 = 0;
    }
    objective_manager::objective_ended(instance, 0);
}

// Namespace namespace_fa1c4f0a/namespace_fa1c4f0a
// Params 1, eflags: 0x0
// Checksum 0xa18a6e87, Offset: 0x4d80
// Size: 0x44
function function_87de8025(instance) {
    instance waittill(#"objective_ended");
    if (instance.success) {
        self delete();
    }
}

// Namespace namespace_fa1c4f0a/namespace_fa1c4f0a
// Params 1, eflags: 0x0
// Checksum 0x5544fc7c, Offset: 0x4dd0
// Size: 0xd0
function function_1bd45984(instance) {
    self endon(#"death");
    instance endon(#"objective_ended");
    while (true) {
        if (is_true(self.var_a123c71)) {
            if (!self getspeed()) {
                wait 0.2;
                if (!self getspeed()) {
                    self launchvehicle(anglestoforward(self.angles) * 10, self.origin);
                }
            }
        }
        wait 0.1;
    }
}

// Namespace namespace_fa1c4f0a/namespace_fa1c4f0a
// Params 1, eflags: 0x0
// Checksum 0x6e5c565, Offset: 0x4ea8
// Size: 0x4c0
function function_6ae999c2(instance) {
    self endon(#"death", #"destruct");
    instance endon(#"objective_ended");
    self.var_a123c71 = 0;
    self.var_f8edfabd = 0;
    self.var_f5d0e3f6 = 0;
    self.var_59078fae = 0;
    self.var_b591d382 = 0;
    self waittill(#"deployed");
    self thread function_1e88c470(instance);
    if (getplayers().size === 1) {
        var_2a9d371 = 5;
    } else {
        var_2a9d371 = 4;
    }
    while (true) {
        self.var_f4bd7934 = 0;
        self.n_players = 0;
        a_players = getplayers();
        foreach (player in a_players) {
            if (distancesquared(self.origin, player.origin) <= function_a3f6cdac(300) && !player laststand::player_is_in_laststand()) {
                self.var_f4bd7934 = 1;
                self.n_players++;
            }
        }
        n_speed = max(self.n_players + var_2a9d371, 6);
        wait 0.25;
        if (!self.var_f4bd7934 || is_true(self.abnormal_status.emped) || is_true(self.var_f5d0e3f6)) {
            if (is_true(self.var_a123c71)) {
                self thread function_58c00013(instance);
            }
            self setspeed(0, 5, 3);
            self.var_a123c71 = 0;
            self setbrake(1);
            self vehicle::toggle_lights_group(4, 1);
            self notify(#"hash_734e3e2063a699a2");
            if (is_true(self.abnormal_status.emped) && !is_true(self.var_a2c49add)) {
                self.var_a2c49add = 1;
                array::thread_all(getplayers(), &globallogic_audio::play_taacom_dialog, "objectivePayloadMalfunction");
            }
            if (!isdefined(self.var_b79a8ac7) && !self.var_f8edfabd && !self.var_b591d382) {
                self thread function_fa1230e0(instance);
            }
            continue;
        }
        self notify(#"hash_76f907c580cdbbc6");
        self setspeed(n_speed, 5, 3);
        self.var_a123c71 = 1;
        self setbrake(0);
        self vehicle::toggle_lights_group(4, 0);
        self.var_a2c49add = undefined;
        self.var_f8edfabd = 0;
        namespace_85745671::function_b70e2a37(self);
        if (self.var_59078fae) {
            self.var_59078fae = 0;
            self connectpaths();
        }
    }
}

// Namespace namespace_fa1c4f0a/namespace_fa1c4f0a
// Params 1, eflags: 0x0
// Checksum 0xc705385e, Offset: 0x5370
// Size: 0x14e
function function_fa1230e0(instance) {
    instance endon(#"objective_ended");
    self endon(#"hash_76f907c580cdbbc6", #"death");
    self.var_f8edfabd = 1;
    wait 2;
    slots = namespace_85745671::function_bdb2b85b(self, self.origin + (0, 0, 16), self.angles, 48, 4, 16);
    if (!isdefined(slots) || slots.size <= 0) {
        self.var_f8edfabd = 0;
        return;
    }
    self.var_b79a8ac7 = {#var_f019ea1a:1000, #slots:slots};
    level.attackables[level.attackables.size] = self;
    self disconnectpaths();
    self.var_59078fae = 1;
    self.var_f8edfabd = 0;
}

// Namespace namespace_fa1c4f0a/namespace_fa1c4f0a
// Params 1, eflags: 0x0
// Checksum 0x4573df4c, Offset: 0x54c8
// Size: 0x204
function function_49ae80f0(instance) {
    self notify("3b211597e8198467");
    self endon("3b211597e8198467");
    instance endon(#"objective_ended");
    self endon(#"hash_76f907c580cdbbc6", #"death");
    wait 20;
    a_s_pts = namespace_85745671::function_e4791424(self.origin, 24, 40, 1200, 1000);
    n_spawns = function_4bed5fd6();
    for (i = 0; i < n_spawns; i++) {
        if (math::cointoss()) {
            var_7ecdee63 = #"hash_2855f060aad4ae87";
        } else if (level.var_b48509f9 > 2) {
            var_7ecdee63 = #"hash_46c917a1b5ed91e7";
        } else if (level.var_b48509f9 > 1) {
            var_7ecdee63 = #"hash_338eb4103e0ed797";
        } else {
            var_7ecdee63 = #"hash_7cba8a05511ceedf";
        }
        if (isdefined(a_s_pts[i])) {
            ai_spawned = namespace_85745671::function_9d3ad056(var_7ecdee63, a_s_pts[i].origin, self.angles, "payload_zombie");
            wait 0.1;
            if (isdefined(ai_spawned)) {
                instance.var_74ec00fb++;
                ai_spawned thread function_84d85877(instance);
                ai_spawned thread function_bf606a73(self, instance);
            }
        }
    }
}

// Namespace namespace_fa1c4f0a/namespace_fa1c4f0a
// Params 0, eflags: 0x0
// Checksum 0x445f1f5, Offset: 0x56d8
// Size: 0x9e
function function_4bed5fd6() {
    switch (getplayers().size) {
    case 1:
        n_spawns = 8;
        break;
    case 2:
        n_spawns = 12;
        break;
    case 3:
        n_spawns = 16;
        break;
    case 4:
        n_spawns = 20;
        break;
    }
    return n_spawns;
}

// Namespace namespace_fa1c4f0a/namespace_fa1c4f0a
// Params 1, eflags: 0x0
// Checksum 0xd958beb9, Offset: 0x5780
// Size: 0xae
function function_58c00013(instance) {
    self notify("78c9053dce95f7a9");
    self endon("78c9053dce95f7a9");
    self endon(#"hash_76f907c580cdbbc6", #"death");
    instance endon(#"objective_ended");
    while (true) {
        wait 10;
        array::thread_all(getplayers(), &globallogic_audio::play_taacom_dialog, "objectivePayloadProximity");
        wait 15;
    }
}

// Namespace namespace_fa1c4f0a/namespace_fa1c4f0a
// Params 1, eflags: 0x0
// Checksum 0xb3addf2d, Offset: 0x5838
// Size: 0x120
function function_8469f022(instance) {
    self endon(#"death");
    instance endon(#"objective_ended");
    var_ad5fcb11 = 0;
    while (true) {
        if (self.var_a123c71 == 1) {
            if (var_ad5fcb11 != 1) {
                self playsound(#"hash_432c591c600ef4d2");
                self playloopsound(#"hash_d47b9beea0c408d", 2);
                var_ad5fcb11 = 1;
            }
        } else if (var_ad5fcb11 != 0) {
            self playsound(#"hash_5d9bb1a3ab5cf792");
            self playloopsound(#"hash_61af81dfad29327c", 2);
            var_ad5fcb11 = 0;
        }
        wait 0.25;
    }
}

// Namespace namespace_fa1c4f0a/namespace_fa1c4f0a
// Params 1, eflags: 0x0
// Checksum 0xba2ba33a, Offset: 0x5960
// Size: 0x7e
function function_1e88c470(instance) {
    self endon(#"death");
    instance endon(#"objective_ended");
    while (true) {
        if (!is_true(self.var_a123c71)) {
            self playsound(#"hash_52af5fa9a4db69a2");
        }
        wait 3;
    }
}

// Namespace namespace_fa1c4f0a/namespace_fa1c4f0a
// Params 1, eflags: 0x0
// Checksum 0xb2d28c6d, Offset: 0x59e8
// Size: 0x84
function function_9c54feb0(instance) {
    self.n_objective_id = gameobjects::get_next_obj_id();
    objective_add(self.n_objective_id, "active", self, #"hash_33a2a5933ee65208");
    instance waittill(#"objective_ended");
    objective_delete(self.n_objective_id);
}

// Namespace namespace_fa1c4f0a/namespace_fa1c4f0a
// Params 1, eflags: 0x0
// Checksum 0x12bee401, Offset: 0x5a78
// Size: 0x5f4
function payload_teleport(instance) {
    self endon(#"death");
    instance endon(#"objective_ended");
    while (true) {
        self waittill(#"reached_end_node");
        if (isdefined(self.mdl_portal)) {
            self.mdl_portal playrumblelooponentity(#"sr_payload_portal_rumble");
        }
        self.var_b591d382 = 1;
        self setbrake(1);
        self objective_manager::function_811514c3();
        if (isdefined(self.currentnode.script_string)) {
            self.var_6a4ec994++;
            var_b5ec4cd3 = getvehiclenode(self.currentnode.script_string, "targetname");
            var_b5ec4cd3.var_d5ebc20b = getvehiclenode(var_b5ec4cd3.script_string, "targetname");
            if (isdefined(var_b5ec4cd3)) {
                n_time = var_b5ec4cd3.script_int;
            }
            self ghost();
            if (isdefined(self.var_43123efe)) {
                self.var_43123efe delete();
            }
            objective_setinvisibletoall(self.n_objective_id);
            wait 2;
            self clientfield::increment("" + #"hash_75190371f51baf5f");
            wait 0.25;
            self thread function_68598c43(instance);
            wait 4;
            if (isdefined(self.mdl_portal)) {
                self.mdl_portal clientfield::set("final_battle_cloud_fx", 0);
                self.mdl_portal clientfield::set("payload_teleport", 1);
            }
            wait 0.1;
            if (isdefined(self.mdl_portal)) {
                self.mdl_portal stoprumble(#"sr_payload_portal_rumble");
                self.mdl_portal delete();
            }
            if (isdefined(self.var_edbf8a99)) {
                self.var_edbf8a99 notsolid();
            }
            self vehicle::get_off_path();
            self function_42fbf5d9(instance, var_b5ec4cd3);
            wait 0.5;
            self vehicle::get_on_path(var_b5ec4cd3);
            wait 0.5;
            self thread vehicle::go_path();
            level thread globallogic_audio::leader_dialog("objectivePayloadRiftFake");
            wait 2;
            if (isdefined(self.var_cb43e7ed)) {
                self.var_cb43e7ed clientfield::set("final_battle_cloud_fx", 0);
                self.var_cb43e7ed delete();
            }
            self.mdl_portal = util::spawn_model("tag_origin", var_b5ec4cd3.var_d5ebc20b.origin, (0, 90, 0));
            self.mdl_portal clientfield::set("final_battle_cloud_fx", 1);
            if (isdefined(self.var_edbf8a99)) {
                self.var_edbf8a99 moveto(self.mdl_portal.origin, 0.05);
                self.var_edbf8a99 waittill(#"movedone");
                self.var_edbf8a99 solid();
            }
            self setbrake(0);
            self.var_b591d382 = 0;
            foreach (player in function_a1ef346b()) {
                player globallogic_audio::play_taacom_dialog("objectivePayloadRiftCollapse");
            }
            continue;
        }
        self function_785ea4f4(instance);
        level thread util::delay(2.5, undefined, &globallogic_audio::leader_dialog, "objectivePayloadEndSuccess");
        level thread util::delay(2.5, undefined, &globallogic_audio::leader_dialog, "objectivePayloadEndSuccessResponse");
        objective_manager::objective_ended(instance);
        break;
    }
}

// Namespace namespace_fa1c4f0a/namespace_fa1c4f0a
// Params 1, eflags: 0x0
// Checksum 0x5977ce16, Offset: 0x6078
// Size: 0x414
function function_fd3059d0(instance) {
    instance endon(#"objective_ended");
    self endon(#"death");
    foreach (player in getplayers()) {
        player.var_d23362c = 0;
    }
    while (true) {
        foreach (player in getplayers()) {
            if (isalive(player)) {
                if (distance2dsquared(self.origin, player.origin) <= function_a3f6cdac(120) && !player.var_d23362c) {
                    player dodamage(20, self.origin, self, self, undefined, "MOD_DEATH_CIRCLE");
                    player clientfield::set_to_player("" + #"hash_19f93b2cb70ea2c5", 1);
                    player.var_d23362c = 1;
                    continue;
                }
                if (distance2dsquared(self.origin, player.origin) <= function_a3f6cdac(150) && !player.var_d23362c) {
                    player dodamage(10, self.origin, self, self, undefined, "MOD_DEATH_CIRCLE");
                    player clientfield::set_to_player("" + #"hash_19f93b2cb70ea2c5", 1);
                    player.var_d23362c = 1;
                    continue;
                }
                if (distance2dsquared(self.origin, player.origin) <= function_a3f6cdac(180) && !player.var_d23362c) {
                    player dodamage(5, self.origin, self, self, undefined, "MOD_DEATH_CIRCLE");
                    player clientfield::set_to_player("" + #"hash_19f93b2cb70ea2c5", 1);
                    player.var_d23362c = 1;
                    continue;
                }
                if (is_true(player.var_d23362c)) {
                    player.var_d23362c = 0;
                    player clientfield::set_to_player("" + #"hash_19f93b2cb70ea2c5", 0);
                }
            }
        }
        wait 1;
    }
}

// Namespace namespace_fa1c4f0a/namespace_fa1c4f0a
// Params 2, eflags: 0x0
// Checksum 0x256b1e72, Offset: 0x6498
// Size: 0x57c
function function_42fbf5d9(instance, var_f00d1e) {
    instance endon(#"objective_ended");
    self endon(#"death");
    self.var_a0bd9710 = util::spawn_model("tag_origin", self.origin, var_f00d1e.angles);
    self.var_a0bd9710 rotateto(var_f00d1e.angles + (randomintrange(120, 270), randomintrange(120, 270), randomintrange(120, 270)), 0.05);
    wait 0.1;
    self linkto(self.var_a0bd9710);
    wait 0.1;
    n_dist = distance(self.var_a0bd9710.origin, var_f00d1e.origin);
    n_time = n_dist / 1000;
    var_7fd007f9 = distance2d(self.var_a0bd9710.origin, var_f00d1e.origin) * 0.5;
    n_inc = int(n_dist);
    self show();
    self.var_a0bd9710 rotatepitch(720, n_time + 1.5);
    self thread function_4ebec20d(var_f00d1e);
    self.var_a0bd9710 playrumbleonentity(#"hash_2d43d9987e4a73a8");
    while (true) {
        var_ed0c1ff8 = distance2d(self.var_a0bd9710.origin, var_f00d1e.origin);
        if (var_ed0c1ff8 <= 100) {
            break;
        }
        v_dest = var_f00d1e.origin + (0, 0, n_inc);
        n_inc -= 50;
        if (v_dest[2] <= var_f00d1e.origin[2]) {
            break;
        }
        self.var_a0bd9710 moveto(v_dest, n_time);
        waitframe(1);
    }
    foreach (player in getplayers()) {
        player.var_d23362c = 0;
        player clientfield::set_to_player("" + #"hash_19f93b2cb70ea2c5", 0);
    }
    n_dist = distance(self.var_a0bd9710.origin, var_f00d1e.origin);
    n_time = n_dist / 1000;
    self.var_a0bd9710 moveto(var_f00d1e.origin + (0, 0, 40), n_time);
    self.var_a0bd9710 waittill(#"movedone");
    self unlink();
    self.var_43123efe = util::spawn_model(self.var_55b751c2[self.var_6a4ec994], self gettagorigin("tag_cage_attach"));
    if (isdefined(self.var_43123efe)) {
        self.var_43123efe linkto(self, "tag_cage_attach", (0, 0, 0), (0, -180, 0));
        if (self.var_6a4ec994 == 2) {
            self.var_43123efe thread scene::play(#"aib_t8_zm_zod_homunculus_idle_01", self.var_43123efe);
        }
    }
    wait 0.1;
    self.angles = var_f00d1e.angles;
    self.var_a0bd9710 delete();
    wait 2;
    objective_setvisibletoall(self.n_objective_id);
}

// Namespace namespace_fa1c4f0a/namespace_fa1c4f0a
// Params 1, eflags: 0x0
// Checksum 0x13dc6716, Offset: 0x6a20
// Size: 0x84
function function_4ebec20d(var_f00d1e) {
    self endon(#"death");
    if (!isdefined(self.var_cb43e7ed)) {
        self.var_cb43e7ed = util::spawn_model("tag_origin", var_f00d1e.origin, (0, 90, 0));
        self.var_cb43e7ed clientfield::set("payload_teleport", 2);
    }
}

// Namespace namespace_fa1c4f0a/namespace_fa1c4f0a
// Params 2, eflags: 0x0
// Checksum 0x77ff1aa2, Offset: 0x6ab0
// Size: 0x74
function function_6c09e96b(instance, n_time) {
    instance endon(#"objective_ended");
    self endon(#"death");
    self waittilltimeout(8, #"hash_76f907c580cdbbc6");
    instance thread objective_manager::start_timer(n_time, "payload");
}

// Namespace namespace_fa1c4f0a/namespace_fa1c4f0a
// Params 1, eflags: 0x0
// Checksum 0xc5d61b1a, Offset: 0x6b30
// Size: 0x94
function function_eb89f65f(instance) {
    instance endon(#"objective_ended");
    self endon(#"death");
    self vehicle::lights_off();
    self waittill(#"hash_13077c2a8907f2fe");
    self vehicle::toggle_sounds(1);
    self vehicle::lights_on();
}

// Namespace namespace_fa1c4f0a/namespace_fa1c4f0a
// Params 1, eflags: 0x0
// Checksum 0xf5c969b8, Offset: 0x6bd0
// Size: 0x3dc
function function_79ae8e99(instance) {
    instance endon(#"objective_ended");
    self endon(#"death");
    while (true) {
        a_zombies = function_a38db454(self.origin, 200);
        foreach (zombie in a_zombies) {
            if (zombie.archetype === #"zombie" && is_true(self.var_a123c71) && !is_true(zombie.knockdown)) {
                if (distance2dsquared(self.origin, zombie.origin) > function_a3f6cdac(60)) {
                    continue;
                }
                zombie.knockdown = 1;
                zombie.knockdown_type = "knockdown_shoved";
                var_7d6a995e = self.origin - zombie.origin;
                var_1040735c = vectornormalize((var_7d6a995e[0], var_7d6a995e[1], 0));
                zombie_forward = anglestoforward(zombie.angles);
                zombie_forward_2d = vectornormalize((zombie_forward[0], zombie_forward[1], 0));
                zombie_right = anglestoright(zombie.angles);
                zombie_right_2d = vectornormalize((zombie_right[0], zombie_right[1], 0));
                dot = vectordot(var_1040735c, zombie_forward_2d);
                if (dot >= 0.5) {
                    zombie.knockdown_direction = "front";
                    zombie.getup_direction = "getup_back";
                    zombie thread function_c93a6362(self);
                    continue;
                }
                if (dot < 0.5 && dot > -0.5) {
                    dot = vectordot(var_1040735c, zombie_right_2d);
                    if (dot > 0) {
                        zombie.knockdown_direction = "right";
                        if (math::cointoss()) {
                            zombie.getup_direction = "getup_back";
                        } else {
                            zombie.getup_direction = "getup_belly";
                        }
                    } else {
                        zombie.knockdown_direction = "left";
                        zombie.getup_direction = "getup_belly";
                    }
                    continue;
                }
                zombie.knockdown_direction = "back";
                zombie.getup_direction = "getup_belly";
            }
        }
        wait 0.1;
    }
}

// Namespace namespace_fa1c4f0a/namespace_fa1c4f0a
// Params 1, eflags: 0x0
// Checksum 0x81586c9d, Offset: 0x6fb8
// Size: 0xfc
function function_c93a6362(var_b8ca9d7) {
    self endon(#"death");
    var_b8ca9d7 endon(#"death");
    wait 1;
    if (isdefined(self.knockdown_type) && isalive(self) && distance2dsquared(var_b8ca9d7.origin, self.origin) < function_a3f6cdac(70)) {
        if (self.knockdown_direction == "front") {
            self.allowdeath = 1;
            self thread function_1b4b0c63();
            self kill(undefined, undefined, undefined, undefined, undefined, 1);
        }
    }
}

// Namespace namespace_fa1c4f0a/namespace_fa1c4f0a
// Params 0, eflags: 0x0
// Checksum 0xc6d9ea86, Offset: 0x70c0
// Size: 0x2c
function function_1b4b0c63() {
    self waittill(#"death");
    gibserverutils::annihilate(self);
}

// Namespace namespace_fa1c4f0a/namespace_fa1c4f0a
// Params 0, eflags: 0x0
// Checksum 0xe19a53e6, Offset: 0x70f8
// Size: 0x210
function function_9bf6c44a() {
    self.a_s_blockers = self.var_fe2612fe[#"hash_441da645c3f27eea"];
    self.a_mdl_blockers = [];
    foreach (s_blocker in self.a_s_blockers) {
        self.a_mdl_blockers[self.a_mdl_blockers.size] = namespace_8b6a9d79::spawn_script_model(s_blocker, s_blocker.model, 1);
    }
    foreach (mdl_blocker in self.a_mdl_blockers) {
        mdl_blocker ghost();
    }
    self waittill(#"objective_ended");
    foreach (mdl_blocker in self.a_mdl_blockers) {
        mdl_blocker connectpaths();
        wait 0.1;
        mdl_blocker delete();
    }
}

// Namespace namespace_fa1c4f0a/namespace_fa1c4f0a
// Params 1, eflags: 0x0
// Checksum 0x73ea8a5c, Offset: 0x7310
// Size: 0xe6
function function_aece4588(var_3afe334f) {
    switch (var_3afe334f) {
    case 1:
        var_e7a1cbae = #"objective_payload_ailist_1";
        break;
    case 2:
        var_e7a1cbae = #"objective_payload_ailist_2";
        break;
    case 3:
        var_e7a1cbae = #"objective_payload_ailist_3";
        break;
    default:
        var_e7a1cbae = #"objective_payload_ailist_4";
        break;
    }
    var_6017f33e = namespace_679a22ba::function_ca209564(var_e7a1cbae);
    return var_6017f33e.var_990b33df;
}

