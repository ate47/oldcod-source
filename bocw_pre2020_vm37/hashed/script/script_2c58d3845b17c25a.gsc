#using script_1029986e2bc8ca8e;
#using script_113dd7f0ea2a1d4f;
#using script_165beea08a63a243;
#using script_1cc417743d7c262d;
#using script_3357acf79ce92f4b;
#using script_340a2e805e35f7a2;
#using script_3411bb48d41bd3b;
#using script_7fc996fe8678852;
#using scripts\core_common\ai\archetype_avogadro;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\death_circle;
#using scripts\core_common\flag_shared;
#using scripts\core_common\fx_shared;
#using scripts\core_common\gameobjects_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\weapons\mechz_firebomb;
#using scripts\zm_common\zm_score;

#namespace namespace_473c9869;

// Namespace namespace_473c9869/level_init
// Params 1, eflags: 0x40
// Checksum 0xada68b7f, Offset: 0x420
// Size: 0x10c
function event_handler[level_init] main(*eventstruct) {
    clientfield::register("actor", "final_battle_orb_fx", 1, 1, "int");
    clientfield::register("scriptmover", "final_battle_cloud_fx", 1, 1, "int");
    var_a2e8327a = getdvarstring(#"hash_30b9d30859759a2b", "");
    if (var_a2e8327a !== "") {
        setdvar(#"hash_4fd21096bcb24e82", 1);
        level flag::wait_till("all_players_spawned");
        function_519b1751(var_a2e8327a);
    }
}

// Namespace namespace_473c9869/namespace_473c9869
// Params 1, eflags: 0x0
// Checksum 0xd96d69f7, Offset: 0x538
// Size: 0x2c6
function init(instance) {
    var_90c6de98 = instance.var_fe2612fe[#"hash_748a9c377c21e242"][0];
    instance.var_bddcc19c = namespace_8b6a9d79::spawn_script_model(var_90c6de98, "tag_origin");
    instance.var_bddcc19c val::set("aether_orb", "allowdeath", 0);
    instance.var_bddcc19c clientfield::set("final_battle_cloud_fx", 1);
    var_758436f2 = instance.var_fe2612fe[#"harvester"][0];
    instance.var_b3fb5814 = namespace_8b6a9d79::spawn_script_model(var_758436f2, #"hash_41778dc519d899c4", 1);
    instance.var_b3fb5814 setscale(var_758436f2.modelscale);
    level.var_e6c9dd9b = instance;
    level util::delay(2.5, undefined, &globallogic_audio::leader_dialog, "objectiveFinalHeadToExfil");
    if (getdvarstring(#"hash_30b9d30859759a2b", "") !== "") {
        teleport_players(instance, 1);
        wait 5;
        for (i = 0; i < getplayers().size + 1; i++) {
            items = instance namespace_65181344::function_fd87c780(#"sr_zombie_drop_guns_orange", 3);
            foreach (item in items) {
                item thread namespace_7da6f8ca::function_7a1e21a9(undefined, instance.var_b3fb5814.origin + (0, 0, 300), 64, 128);
                waitframe(3);
            }
        }
    }
}

// Namespace namespace_473c9869/namespace_473c9869
// Params 1, eflags: 0x0
// Checksum 0x6b0722a5, Offset: 0x808
// Size: 0x1b2
function function_519b1751(str_destination) {
    level.var_b48509f9 = 4;
    foreach (player in getplayers()) {
        player zm_score::add_to_player_score(5000);
        player zm_score::add_to_player_score(5000);
        player zm_score::add_to_player_score(5000);
    }
    s_destination = struct::get(str_destination);
    foreach (location in s_destination.locations) {
        var_12073955 = location.instances[#"hash_401d37614277df42"];
        if (isdefined(var_12073955)) {
            namespace_8b6a9d79::function_20d7e9c7(var_12073955);
            return;
        }
    }
}

// Namespace namespace_473c9869/namespace_473c9869
// Params 0, eflags: 0x0
// Checksum 0x32dbe9b2, Offset: 0x9c8
// Size: 0x74
function function_dab03ae5() {
    level globallogic_audio::leader_dialog("objectiveFinalKickoff");
    array::thread_all(getplayers(), &callback::function_d8abfc3d, #"weapon_fired", &on_weapon_fired);
}

// Namespace namespace_473c9869/namespace_473c9869
// Params 2, eflags: 0x0
// Checksum 0x2b54d93d, Offset: 0xa48
// Size: 0x154
function function_80059f8(instance, *activator) {
    level endon(#"final_battle_over");
    activator.n_round = 1;
    function_1d7e3d68(activator);
    level thread function_dab03ae5();
    function_fd551fe0(activator);
    function_5401cf72(activator);
    activator.n_round++;
    function_b6ff6241(activator);
    function_fd551fe0(activator);
    function_5401cf72(activator);
    activator.n_round++;
    function_b6ff6241(activator);
    function_fd551fe0(activator);
    function_5401cf72(activator);
    activator.n_round++;
    function_894761f0(activator);
}

// Namespace namespace_473c9869/namespace_473c9869
// Params 1, eflags: 0x0
// Checksum 0x72f14611, Offset: 0xba8
// Size: 0x40c
function function_1d7e3d68(instance) {
    foreach (player in getplayers()) {
        level.var_31028c5d prototype_hud::function_7491d6c5(player, #"hash_584f24e8ed52b259");
    }
    function_bee954a8(instance);
    function_c8836272(instance);
    instance.s_orb = instance.var_fe2612fe[#"orb"][0];
    instance.var_bddcc19c clientfield::set("final_battle_cloud_fx", 0);
    instance.var_bddcc19c moveto(instance.s_orb.origin, 1);
    instance.var_bddcc19c waittill(#"movedone");
    wait 1;
    do {
        waitframe(1);
        instance.var_7dfacf36 = namespace_85745671::function_9d3ad056(instance.var_2bc65d64, instance.var_bddcc19c.origin, instance.s_orb.angles, "the_antagonist");
    } while (!isdefined(instance.var_7dfacf36));
    instance.var_bddcc19c clientfield::set("final_battle_cloud_fx", 1);
    instance.var_7dfacf36 clientfield::set("final_battle_orb_fx", 1);
    wait 0.5;
    instance.var_bddcc19c bobbing((0, 0, 1), 7, 4);
    foreach (player in getplayers()) {
        level.var_31028c5d prototype_hud::set_active_objective_string(player, #"hash_584f24e8ed52b259");
        level.var_31028c5d prototype_hud::function_817e4d10(player, 2);
    }
    teleport_players(instance);
    function_3cbe6b88(instance);
    level.deathcircle = death_circle::function_a8749d88(instance.s_orb.origin, 64, 10, 1);
    death_circle::function_9229c3b3(level.deathcircle, instance.s_orb.radius, instance.s_orb.origin, 2.5);
    level thread death_circle::function_dc15ad60(level.deathcircle);
    wait 1;
    level thread function_918a9de4(instance.s_orb.origin);
    callback::on_ai_killed(&function_d75649f4);
}

// Namespace namespace_473c9869/namespace_473c9869
// Params 1, eflags: 0x0
// Checksum 0x7de9e32b, Offset: 0xfc0
// Size: 0x74
function function_fd551fe0(instance) {
    function_4c938c32(instance);
    n_time = 7 * instance.n_round / 1.5;
    util::delay(n_time, "wave_cleared", &function_25d601a5, instance);
}

// Namespace namespace_473c9869/namespace_473c9869
// Params 1, eflags: 0x0
// Checksum 0xb0d14edc, Offset: 0x1040
// Size: 0x256
function function_4c938c32(instance) {
    level endon(#"end_projectile_attacks");
    /#
        iprintlnbold("<dev string:x38>");
    #/
    if (instance.n_round > 1) {
        instance.var_7dfacf36 flag::wait_till(#"hash_61b51e2cbe33f667");
        wait 1;
    }
    level util::delay_notify(10 + getplayers().size, "end_projectile_attacks", "end_projectile_attacks");
    while (true) {
        var_4edcb52f = 0;
        var_10426ae6 = 0;
        a_players = function_a1ef346b();
        if (a_players.size) {
            a_players = array::randomize(a_players);
            foreach (player in a_players) {
                if (isalive(player)) {
                    level thread function_ceec5e21(instance, instance.var_7dfacf36, player);
                    var_4edcb52f++;
                    n_wait = randomfloatrange(1, 2);
                    var_10426ae6 = var_10426ae6 + 2 - n_wait;
                    if (var_4edcb52f > 3) {
                        break;
                    }
                    wait max(0.25, n_wait / a_players.size);
                }
            }
            wait 1 + var_10426ae6 / a_players.size;
            continue;
        }
        wait 1;
    }
}

// Namespace namespace_473c9869/namespace_473c9869
// Params 3, eflags: 0x0
// Checksum 0x15941e20, Offset: 0x12a0
// Size: 0x20c
function function_ceec5e21(instance, e_source, e_target) {
    v_target = e_target.origin;
    v_source = e_source gettagorigin("j_spinelower");
    dir = vectortoangles(v_target - v_source + (0, 0, 250));
    fx::play("sr/fx9_boss_orb_aether_projectile_tell_mltv", v_source, dir, 1);
    playsoundatposition(#"hash_149c970e953c5009", v_source);
    wait 1;
    v_launch = anglestoforward(dir) * 120 + v_source;
    if (isdefined(e_target)) {
        v_target = e_target.origin;
    }
    dist = distance(v_launch, v_target);
    dir = vectortoangles(v_target - v_launch);
    dir = anglestoforward(dir);
    velocity = dir * dist;
    velocity += (0, 0, 250);
    weapon = getweapon(instance.var_cef0ec25);
    projectile = e_source magicgrenadetype(weapon, v_launch, velocity);
    if (isdefined(instance.var_3998aa26)) {
        projectile thread [[ instance.var_3998aa26 ]](e_source, weapon);
    }
}

// Namespace namespace_473c9869/namespace_473c9869
// Params 1, eflags: 0x0
// Checksum 0x2c4ad587, Offset: 0x14b8
// Size: 0x64c
function function_5401cf72(instance) {
    level notify(#"new_wave_started");
    level endon(#"wave_timeout", #"final_battle_over", #"new_wave_started");
    /#
        iprintlnbold("<dev string:x4e>");
    #/
    level thread util::delay_notify(55, "wave_timeout", "new_wave_started");
    a_ai = [];
    var_73babac5 = [];
    var_aebb8dc = [];
    var_acd0b246 = instance.var_fe2612fe[#"spawn_point"][0];
    a_s_spawnpoints = struct::get_array(var_acd0b246.targetname, "target");
    instance.var_ffba700b = instance.var_e88bcd6e[instance.n_round - 1];
    if (!isdefined(instance.var_ffba700b)) {
        instance.var_ffba700b = 999;
    }
    if (instance.n_round < 4) {
        function_e91a6c87(instance);
    }
    var_a1919686 = instance.var_77a7bfd3;
    var_3da88710 = instance.var_ffba700b + instance.var_7a21f8da;
    n_spawns = 0;
    n_delay = 2 / getplayers().size;
    while (n_spawns < var_3da88710) {
        a_s_locs = array::randomize(a_s_spawnpoints);
        for (i = 0; i < a_s_locs.size; i++) {
            if (n_spawns >= var_3da88710) {
                break;
            }
            var_bf46c1d0 = arraycopy(var_aebb8dc);
            arrayremovevalue(var_bf46c1d0, undefined);
            if (var_a1919686 == #"hash_2855f060aad4ae87" && var_bf46c1d0.size > 3) {
                var_a1919686 = #"hash_7cba8a05511ceedf";
                var_2803b20e = 1;
            }
            if (var_a1919686 == #"spawner_bo5_avogadro_sr" && var_bf46c1d0.size > 4) {
                var_a1919686 = #"hash_7cba8a05511ceedf";
                var_2803b20e = 1;
            }
            if (var_aebb8dc.size >= instance.var_7a21f8da && var_a1919686 == instance.var_77a7bfd3) {
                var_a1919686 = #"hash_7cba8a05511ceedf";
            }
            if (var_a1919686 == #"hash_7cba8a05511ceedf" && var_73babac5.size >= instance.var_ffba700b / 2) {
                var_a1919686 = #"hash_338eb4103e0ed797";
            }
            if (var_a1919686 == #"hash_338eb4103e0ed797" && var_73babac5.size >= instance.var_ffba700b * 3 / 4) {
                var_a1919686 = #"hash_46c917a1b5ed91e7";
            }
            if (var_a1919686 !== instance.var_77a7bfd3 && var_73babac5.size >= instance.var_ffba700b) {
                wait 0.25;
            } else {
                ai_spawned = namespace_85745671::function_9d3ad056(var_a1919686, a_s_locs[i].origin, a_s_locs[i].angles, "final_battle_zombie");
                if (isdefined(ai_spawned)) {
                    if (!isdefined(a_ai)) {
                        a_ai = [];
                    } else if (!isarray(a_ai)) {
                        a_ai = array(a_ai);
                    }
                    a_ai[a_ai.size] = ai_spawned;
                    if (ai_spawned.archetype !== #"zombie") {
                        if (!isdefined(var_aebb8dc)) {
                            var_aebb8dc = [];
                        } else if (!isarray(var_aebb8dc)) {
                            var_aebb8dc = array(var_aebb8dc);
                        }
                        var_aebb8dc[var_aebb8dc.size] = ai_spawned;
                    } else {
                        if (!isdefined(var_73babac5)) {
                            var_73babac5 = [];
                        } else if (!isarray(var_73babac5)) {
                            var_73babac5 = array(var_73babac5);
                        }
                        var_73babac5[var_73babac5.size] = ai_spawned;
                    }
                    n_spawns++;
                    e_target_player = array::get_all_closest(ai_spawned.origin, function_a1ef346b(), undefined, 1)[0];
                    awareness::function_c241ef9a(ai_spawned, e_target_player, 60);
                }
            }
            wait n_delay;
            if (is_true(var_2803b20e) && var_aebb8dc.size < instance.var_7a21f8da) {
                var_2803b20e = 0;
                var_a1919686 = instance.var_77a7bfd3;
            }
        }
        wait 0.1;
    }
    if (instance.var_7dfacf36.var_740d4b8a !== 1) {
        level waittill(#"antagonist_retreated");
    }
    function_a22efdd8(instance, a_ai);
}

// Namespace namespace_473c9869/namespace_473c9869
// Params 2, eflags: 0x0
// Checksum 0xfbc8e0c0, Offset: 0x1b10
// Size: 0xd0
function function_a22efdd8(instance, a_ai) {
    level endon(#"wave_timeout", #"final_battle_over", #"new_wave_started");
    while (a_ai.size > randomint(3) || a_ai.size > 0 && instance.var_77a7bfd3 === #"hash_4f87aa2a203d37d0") {
        arrayremovevalue(a_ai, undefined);
        wait 0.25;
    }
    level notify(#"wave_cleared");
}

// Namespace namespace_473c9869/namespace_473c9869
// Params 1, eflags: 0x0
// Checksum 0x865e6252, Offset: 0x1be8
// Size: 0x13a
function function_b6ff6241(instance) {
    level thread function_3cbe6b88(instance);
    switch (instance.n_round) {
    case 2:
        level notify(#"hash_6adadb0779eac3c6");
        level thread death_circle::function_9229c3b3(level.deathcircle, 2 * instance.s_orb.radius / 3, instance.s_orb.origin, 15);
        break;
    case 3:
        level notify(#"hash_6adadb0779eac3c6");
        level thread death_circle::function_9229c3b3(level.deathcircle, instance.s_orb.radius / 3, instance.s_orb.origin, 15);
        break;
    default:
        return;
    }
}

// Namespace namespace_473c9869/namespace_473c9869
// Params 1, eflags: 0x0
// Checksum 0xc3659b50, Offset: 0x1d30
// Size: 0x24
function function_894761f0(instance) {
    function_25d601a5(instance);
}

// Namespace namespace_473c9869/namespace_473c9869
// Params 1, eflags: 0x0
// Checksum 0xa6c5e4af, Offset: 0x1d60
// Size: 0xdc
function function_d75649f4(params) {
    if (isdefined(self)) {
        if (self.archetype !== #"zombie" && self.archetype !== #"zombie_dog") {
            self namespace_7da6f8ca::function_d92e3c5a(params.eattacker, undefined, #"sr_default_list_ammo", 0, 90);
            return;
        }
        if (randomint(100) < 50) {
            self namespace_7da6f8ca::function_d92e3c5a(params.eattacker, undefined, #"sr_default_list_ammo_small", 0, 90);
        }
    }
}

// Namespace namespace_473c9869/namespace_473c9869
// Params 1, eflags: 0x0
// Checksum 0xd5fa6ec7, Offset: 0x1e48
// Size: 0x16a
function function_c8836272(instance) {
    a_players = getplayers();
    n_players = a_players.size;
    switch (n_players) {
    case 1:
        instance.var_e88bcd6e = array(12, 18, 24);
        break;
    case 2:
        instance.var_e88bcd6e = array(15, 22, 30);
        break;
    case 3:
        instance.var_e88bcd6e = array(20, 30, 40);
        break;
    case 4:
        instance.var_e88bcd6e = array(27, 37, 47);
        break;
    case 5:
        instance.var_e88bcd6e = array(33, 44, 55);
        break;
    }
}

// Namespace namespace_473c9869/namespace_473c9869
// Params 1, eflags: 0x0
// Checksum 0x3314518c, Offset: 0x1fc0
// Size: 0x256
function function_e91a6c87(instance) {
    if (!isdefined(instance.var_de82b392) || !instance.var_de82b392.size) {
        instance.var_de82b392 = array(#"spawner_bo5_avogadro_sr", #"hash_2855f060aad4ae87", #"hash_4f87aa2a203d37d0");
    }
    var_7ecdee63 = array::random(instance.var_de82b392);
    switch (var_7ecdee63) {
    case #"spawner_bo5_avogadro_sr":
        n_percent = 0.1;
        var_43e8f2b5 = 0.7;
        break;
    case #"hash_2855f060aad4ae87":
        n_percent = 0.3;
        var_43e8f2b5 = 0.7;
        break;
    case #"hash_4f87aa2a203d37d0":
        if (instance.n_round > 1 && !is_true(instance.var_9a37d00e)) {
            var_7ecdee63 = #"hash_4f87aa2a203d37d0";
            n_percent = 0.09;
            var_43e8f2b5 = 0.6;
            instance.var_9a37d00e = 1;
        } else {
            function_e91a6c87(instance);
            return;
        }
        break;
    }
    if (var_7ecdee63 == instance.var_2bc65d64) {
        function_e91a6c87(instance);
        return;
    }
    arrayremovevalue(instance.var_de82b392, var_7ecdee63, 0);
    instance.var_7a21f8da = int(instance.var_ffba700b * n_percent);
    instance.var_ffba700b = int(instance.var_ffba700b * var_43e8f2b5);
    instance.var_77a7bfd3 = var_7ecdee63;
}

// Namespace namespace_473c9869/namespace_473c9869
// Params 1, eflags: 0x0
// Checksum 0xb9c1726f, Offset: 0x2220
// Size: 0x174
function function_bee954a8(instance) {
    var_6db7bf8 = 2;
    switch (var_6db7bf8) {
    case 0:
        instance.var_2bc65d64 = #"spawner_bo5_avogadro_sr";
        instance.str_archetype = #"avogadro";
        instance.var_3dad7955 = 7;
        instance.var_cef0ec25 = "sr_final_battle_avogadro_bolt";
        instance.var_3998aa26 = &archetype_avogadro::function_b1b41f33;
        instance.v_link_offset = (0, 0, 32);
        break;
    default:
        instance.var_2bc65d64 = #"spawner_bo5_mechz_sr";
        instance.str_archetype = #"mechz";
        instance.var_3dad7955 = 2;
        instance.var_cef0ec25 = "eq_sr_final_battle_firebomb";
        instance.var_3998aa26 = &mechzfirebomb::function_1cdbb1e5;
        instance.v_link_offset = (0, 0, -32);
        break;
    }
    spawner::add_global_spawn_function(#"axis", &function_fa2cab42);
}

// Namespace namespace_473c9869/namespace_473c9869
// Params 0, eflags: 0x0
// Checksum 0x12563f3f, Offset: 0x23a0
// Size: 0x8c
function function_fa2cab42() {
    if (isdefined(level.var_e6c9dd9b)) {
        instance = level.var_e6c9dd9b;
    } else {
        return;
    }
    if (self === instance.var_7dfacf36) {
        self.var_83fa6083 = 1;
        instance.var_7dfacf36 linkto(instance.var_bddcc19c);
        self function_4f2c1b60();
    }
}

// Namespace namespace_473c9869/namespace_473c9869
// Params 2, eflags: 0x0
// Checksum 0xe37f5ba9, Offset: 0x2438
// Size: 0x2c
function function_e4e23b3b(e_source, *weapon) {
    self archetype_avogadro::function_b1b41f33(weapon);
}

// Namespace namespace_473c9869/namespace_473c9869
// Params 1, eflags: 0x0
// Checksum 0x48e6ad9a, Offset: 0x2470
// Size: 0xd4
function on_weapon_fired(*params) {
    ai_enemy = level.var_e6c9dd9b.var_7dfacf36;
    if (isalive(ai_enemy) && is_true(ai_enemy.var_740d4b8a) && self util::is_looking_at(ai_enemy, 0.99, 1)) {
        self thread globallogic_audio::leader_dialog_on_player("objectiveFinalBossImpenetrable");
        self callback::function_52ac9652(#"weapon_fired", &on_weapon_fired);
    }
}

// Namespace namespace_473c9869/namespace_473c9869
// Params 0, eflags: 0x0
// Checksum 0x39d216e4, Offset: 0x2550
// Size: 0x328
function function_4f2c1b60() {
    wait 0.2;
    instance = level.var_e6c9dd9b;
    if (self !== instance.var_7dfacf36) {
        return;
    }
    spawner::remove_global_spawn_function(#"axis", &function_fa2cab42);
    self flag::wait_till("objective_set");
    objective_manager::function_91574ec1(level.progress_bar, undefined, undefined, 27, "final_battle_over", 0);
    objective_manager::function_5d1c184(1);
    objective_setprogress(instance.n_objective_id, 1);
    v_fx = self gettagorigin("j_spinelower");
    if (isdefined(v_fx)) {
        self fx::play("sr/fx9_zmb_vip_target_identify", v_fx, undefined, "death", 1);
    }
    n_start_health = self.health;
    var_11a3b152 = self.health - int(n_start_health / 3);
    for (s_result = undefined; true; s_result = self waittill(#"damage", #"death", #"antagonist_retreated")) {
        if (s_result._notify === "death" || self.health <= 0) {
            level thread end_match(instance, self.origin);
            return;
        } else if (instance.n_round < 4 && (self.health < var_11a3b152 || s_result._notify === "antagonist_retreated" || is_true(self.var_740d4b8a))) {
            level thread function_3cbe6b88(instance);
            var_11a3b152 = self.health - int(n_start_health / 3);
        } else {
            var_c3a3ae13 = self.health / n_start_health;
            if (var_c3a3ae13 >= 0) {
                objective_manager::function_5d1c184(var_c3a3ae13);
                objective_setprogress(instance.n_objective_id, var_c3a3ae13);
            }
        }
        s_result = undefined;
    }
}

// Namespace namespace_473c9869/namespace_473c9869
// Params 1, eflags: 0x0
// Checksum 0x6171ed7f, Offset: 0x2880
// Size: 0x2f4
function function_3cbe6b88(instance) {
    if (!is_true(instance.var_7dfacf36.var_740d4b8a) && isalive(instance.var_7dfacf36)) {
        instance.var_7dfacf36 endon(#"death");
        instance.var_7dfacf36 notsolid();
        instance.var_7dfacf36.var_740d4b8a = 1;
        instance.var_7dfacf36 val::set("antagonist_orb", "ignoreall", 1);
        instance.var_7dfacf36 val::set("antagonist_orb", "takedamage", 0);
        instance.var_7dfacf36 val::set("antagonist_orb", "ignoreme", 1);
        instance.var_7dfacf36 clientfield::set("final_battle_orb_fx", 1);
        instance.var_bddcc19c.origin = instance.var_7dfacf36.origin;
        instance.var_7dfacf36 linkto(instance.var_bddcc19c);
        if (isdefined(instance.n_objective_id)) {
            objective_setinvisibletoall(instance.n_objective_id);
        }
        instance.var_bddcc19c scene::play(#"hash_c8f06127c68a3b0", "init", instance.var_7dfacf36);
        instance.var_bddcc19c thread scene::play(#"hash_c8f06127c68a3b0", "loop", instance.var_7dfacf36);
        wait 1;
        instance.var_bddcc19c moveto(instance.s_orb.origin, 2, 0.5);
        instance.var_bddcc19c waittill(#"movedone");
        instance.var_bddcc19c bobbing((0, 0, 1), 7, 4);
        instance.var_7dfacf36 notify(#"antagonist_retreated");
        level notify(#"antagonist_retreated");
        instance.var_7dfacf36 flag::set(#"hash_61b51e2cbe33f667");
    }
}

// Namespace namespace_473c9869/namespace_473c9869
// Params 1, eflags: 0x0
// Checksum 0x305476a2, Offset: 0x2b80
// Size: 0x36e
function function_25d601a5(instance) {
    if (!isdefined(instance.n_objective_id)) {
        instance.n_objective_id = gameobjects::get_next_obj_id();
        objective_add(instance.n_objective_id, "active", instance.var_7dfacf36, #"hash_5c39569d28e1d9f7");
        instance.var_7dfacf36 flag::set("objective_set");
    }
    if (is_true(instance.var_7dfacf36.var_740d4b8a)) {
        instance.var_7dfacf36 endon(#"death");
        instance.var_7dfacf36 solid();
        instance.var_7dfacf36.var_740d4b8a = undefined;
        instance.var_7dfacf36 flag::clear(#"hash_61b51e2cbe33f667");
        objective_setvisibletoall(instance.n_objective_id);
        s_landing = array::random(instance.s_orb.var_fe2612fe[#"hash_1f1cc7b0009eab89"]);
        instance.var_bddcc19c moveto(s_landing.origin, 2.5, 0.1, 2);
        instance.var_bddcc19c waittill(#"movedone");
        instance.var_7dfacf36 clientfield::set("final_battle_orb_fx", 0);
        instance.var_bddcc19c scene::stop(#"hash_c8f06127c68a3b0");
        instance.var_bddcc19c thread scene::play(#"hash_c8f06127c68a3b0", "out", instance.var_7dfacf36);
        wait 0.8;
        instance.var_7dfacf36 unlink();
        instance.var_7dfacf36 val::reset("antagonist_orb", "takedamage");
        instance.var_7dfacf36 val::reset("antagonist_orb", "ignoreall");
        instance.var_7dfacf36 val::reset("antagonist_orb", "ignoreme");
        player = arraygetclosest(instance.var_7dfacf36.origin, function_a1ef346b(), 3000);
        if (isdefined(player)) {
            level thread awareness::function_c241ef9a(instance.var_7dfacf36, player, 15);
        }
        instance.var_bddcc19c.origin = instance.s_orb.origin;
    }
}

// Namespace namespace_473c9869/namespace_473c9869
// Params 2, eflags: 0x0
// Checksum 0x3b6663f3, Offset: 0x2ef8
// Size: 0x19c
function end_match(instance, var_6b6241ac) {
    objective_delete(instance.n_objective_id);
    level notify(#"hash_12a8f2c59a67e4fc");
    level notify(#"final_battle_over");
    level.deathcircle delete();
    foreach (player in getplayers()) {
        level.var_31028c5d prototype_hud::function_817e4d10(player, 0);
        player val::set("battle_over", "takedamage", 0);
        player objective_manager::function_8f481c50();
    }
    if (!isdefined(var_6b6241ac)) {
        var_6b6241ac = instance.s_orb.origin;
    }
    fx::play("sr/fx9_boss_orb_aether_dest", var_6b6241ac);
    waitframe(1);
    objective_manager::objective_ended(instance);
}

// Namespace namespace_473c9869/namespace_473c9869
// Params 2, eflags: 0x0
// Checksum 0xbc961e03, Offset: 0x30a0
// Size: 0x1b4
function teleport_players(instance, b_force = 0) {
    var_91562d8c = instance.var_fe2612fe[#"hash_fffea75a54ab5fb"];
    assert(var_91562d8c.size > 4, "<dev string:x59>" + instance.targetname);
    i = 0;
    foreach (player in getplayers()) {
        if (b_force || distance2dsquared(player.origin, instance.s_orb.origin) > function_a3f6cdac(instance.s_orb.radius + 256)) {
            player setorigin(var_91562d8c[i].origin);
            player setplayerangles(var_91562d8c[i].angles);
            i++;
        }
    }
}

// Namespace namespace_473c9869/namespace_473c9869
// Params 1, eflags: 0x0
// Checksum 0xe88cca30, Offset: 0x3260
// Size: 0x136
function function_918a9de4(v_loc) {
    a_triggers = getentarray("explore_chest_trigger", "targetname");
    foreach (trigger in a_triggers) {
        if (distance2dsquared(v_loc, trigger.origin) > function_a3f6cdac(5000)) {
            if (isdefined(trigger.struct.scriptmodel)) {
                trigger.struct.scriptmodel delete();
            }
            trigger delete();
        }
        waitframe(1);
    }
}

