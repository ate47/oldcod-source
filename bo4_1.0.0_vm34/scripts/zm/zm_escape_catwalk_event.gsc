#using scripts\core_common\ai\zombie_utility;
#using scripts\core_common\ai_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\laststand_shared;
#using scripts\core_common\music_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\struct;
#using scripts\core_common\trigger_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\zm\zm_escape_util;
#using scripts\zm\zm_escape_vo_hooks;
#using scripts\zm_common\util\ai_brutus_util;
#using scripts\zm_common\util\ai_dog_util;
#using scripts\zm_common\zm_audio;
#using scripts\zm_common\zm_customgame;
#using scripts\zm_common\zm_powerups;
#using scripts\zm_common\zm_utility;
#using scripts\zm_common\zm_vo;
#using scripts\zm_common\zm_zonemgr;

#namespace zm_escape_catwalk_event;

// Namespace zm_escape_catwalk_event/zm_escape_catwalk_event
// Params 0, eflags: 0x0
// Checksum 0xe9d12420, Offset: 0x590
// Size: 0x84
function init_clientfields() {
    clientfield::register("scriptmover", "" + #"hash_144c7c2895ed95c", 1, 1, "int");
    clientfield::register("scriptmover", "" + #"hash_48f1f50c412d80c7", 1, 1, "counter");
}

// Namespace zm_escape_catwalk_event/zm_escape_catwalk_event
// Params 0, eflags: 0x0
// Checksum 0xe4295829, Offset: 0x620
// Size: 0x324
function function_2a17bca0() {
    level flag::init(#"hash_6019aeb57ae7e6b5");
    level flag::init(#"catwalk_event_completed");
    level flag::init(#"catwalk_door_open");
    var_c596feec = getent("t_catwalk_door_open", "targetname");
    var_c596feec sethintstring(#"zombie/need_power");
    level.var_eae836f4 = getent("mdl_ca_l", "targetname");
    a_e_door = getentarray("door_model_west_side_exterior_to_catwalk", "targetname");
    foreach (e_door in a_e_door) {
        if (e_door.classname == "script_model") {
            level.var_eae836f4 linkto(e_door);
            break;
        }
    }
    scene::add_scene_func(#"aib_zm_mob_brutus_summon_brutus", &function_26443ec8, "init");
    scene::add_scene_func(#"aib_zm_mob_brutus_summon_brutus", &function_75432d7c, "Shot 1");
    scene::add_scene_func(#"aib_zm_mob_brutus_summon_brutus", &play_brutus_scene_done, "done");
    scene::add_scene_func(#"aib_vign_zm_mob_brutus_summon_hellhounds", &function_7d1a3661, "Shot 1");
    var_49fc5c19 = getent("t_rocks_b_bundle_play_scene", "targetname");
    var_aa100250 = getent("t_rocks_c_bundle_play_scene", "targetname");
    var_49fc5c19 thread function_17fd60df();
    var_aa100250 thread function_f1fae676();
    level thread function_ebbbe405();
    level thread function_f3033e1b();
}

// Namespace zm_escape_catwalk_event/zm_escape_catwalk_event
// Params 0, eflags: 0x0
// Checksum 0x88f2e726, Offset: 0x950
// Size: 0x8cc
function function_ebbbe405() {
    level endon(#"hash_7bf357f5c916ca4e");
    if (zm_custom::function_5638f689(#"zmpowerdoorstate") != 2) {
        if (zm_utility::is_standard()) {
            level waittill(#"hash_545d84d6e7f5c7a6");
        } else {
            level flag::wait_till_any(array("power_on2", "power_on"));
        }
    }
    var_c596feec = getent("t_catwalk_door_open", "targetname");
    t_catwalk_door = getent("door_model_west_side_exterior_to_catwalk", "target");
    var_10ddd304 = getentarray("catwalk_event_triggers", "script_noteworthy");
    foreach (t_catwalk_event in var_10ddd304) {
        trigger::add_function(t_catwalk_event, "enemies_spawned", &function_15859b75, t_catwalk_event);
    }
    if (zm_custom::function_5638f689(#"zmpowerstate") == 1 && zm_custom::function_5638f689(#"zmpowerdoorstate") != 2) {
        var_c596feec sethintstring(#"hash_52803ee9fe3f2ea5");
        t_catwalk_door sethintstring(#"");
        level.var_eae836f4 setmodel(#"p8_zm_esc_catwalk_door_light_green");
        var_c596feec sethintstring(#"hash_52803ee9fe3f2ea5");
        t_catwalk_door sethintstring(#"");
        waitresult = var_c596feec waittill(#"trigger");
        level flag::set(#"catwalk_door_open");
        if (isplayer(waitresult.activator)) {
            waitresult.activator thread zm_audio::create_and_play_dialog("catwalk", "open", undefined, 1);
        }
        var_c596feec sethintstring(#"");
        t_catwalk_door notify(#"power_on");
        playsoundatposition(#"hash_97aff7905795396", (8223, 10111, 817));
        level.musicsystemoverride = 1;
        music::setmusicstate("escape_catwalk");
        s_sparks = struct::get("catwalk_door_spark");
        mdl_sparks = util::spawn_model("tag_origin", s_sparks.origin, s_sparks.angles);
        mdl_sparks clientfield::set("" + #"hash_144c7c2895ed95c", 1);
        mdl_gate = undefined;
        foreach (mdl_door in t_catwalk_door.doors) {
            if (mdl_door.classname == "script_model") {
                mdl_gate = mdl_door;
                break;
            }
        }
        if (isdefined(mdl_gate)) {
            level thread function_71572d66(mdl_sparks, mdl_gate);
        }
        level.var_eae836f4 clientfield::increment("" + #"hash_48f1f50c412d80c7");
    } else if (zm_custom::function_5638f689("zmPowerState") == 2 || zm_custom::function_5638f689(#"zmpowerdoorstate") == 2) {
        var_c596feec sethintstring(#"");
        t_catwalk_door sethintstring(#"");
        var_c596feec setinvisibletoall();
        t_catwalk_door setinvisibletoall();
        if (isdefined(level.var_eae836f4)) {
            level.var_eae836f4 delete();
        }
    }
    level.var_2d4e3645 = &function_2232b1b8;
    trigger::wait_till("t_catwalk_event_00");
    level flag::set(#"hash_6019aeb57ae7e6b5");
    foreach (s_powerup in level.zombie_powerups) {
        s_powerup.var_bada6901 = s_powerup.func_should_drop_with_regular_powerups;
        s_powerup.func_should_drop_with_regular_powerups = &zm_powerups::func_should_never_drop;
    }
    level thread function_bd2b3eea();
    level thread function_b029d798();
    foreach (e_player in level.activeplayers) {
        e_player thread function_67edc290();
    }
    callback::on_connect(&function_67edc290);
    t_catwalk_event_10 = getent("t_catwalk_event_10", "targetname");
    t_catwalk_event_10 waittill(#"enemies_spawned");
    while (level.var_ce255064) {
        waitframe(1);
    }
    for (var_91f1e72a = getentarray("catwalk_event_zombie", "script_noteworthy"); var_91f1e72a.size > 0; var_91f1e72a = getentarray("catwalk_event_zombie", "script_noteworthy")) {
        waitframe(1);
    }
    flag::wait_till_timeout(61, "trig_catwalk_event_completed");
    level thread function_850db698();
}

// Namespace zm_escape_catwalk_event/zm_escape_catwalk_event
// Params 0, eflags: 0x0
// Checksum 0x51c12411, Offset: 0x1228
// Size: 0xac
function function_f3033e1b() {
    mdl_wire = getent("catwalk_wires", "targetname");
    bundle = #"p8_fxanim_zm_esc_wires_catwalk_bundle";
    mdl_wire thread scene::play(bundle, "LOOP", mdl_wire);
    level flag::wait_till(#"catwalk_door_open");
    mdl_wire thread scene::play(bundle, "SHOCKED", mdl_wire);
}

// Namespace zm_escape_catwalk_event/zm_escape_catwalk_event
// Params 0, eflags: 0x0
// Checksum 0x287224ce, Offset: 0x12e0
// Size: 0xbc
function function_17fd60df() {
    while (true) {
        s_info = self waittill(#"trigger");
        if (isplayer(s_info.activator) && !s_info.activator laststand::player_is_in_laststand()) {
            break;
        }
    }
    var_c114b43e = struct::get("p8_fxanim_zm_esc_recreationyard_rocks_b_bundle", "scriptbundlename");
    var_c114b43e thread scene::play("Main & Idle Loop Out");
}

// Namespace zm_escape_catwalk_event/zm_escape_catwalk_event
// Params 0, eflags: 0x0
// Checksum 0x3072c4b1, Offset: 0x13a8
// Size: 0xbc
function function_f1fae676() {
    while (true) {
        s_info = self waittill(#"trigger");
        if (isplayer(s_info.activator) && !s_info.activator laststand::player_is_in_laststand()) {
            break;
        }
    }
    var_c114b43e = struct::get("p8_fxanim_zm_esc_recreationyard_rocks_c_bundle", "scriptbundlename");
    var_c114b43e thread scene::play("Main & Idle Loop Out");
}

// Namespace zm_escape_catwalk_event/zm_escape_catwalk_event
// Params 2, eflags: 0x0
// Checksum 0x352d5863, Offset: 0x1470
// Size: 0x84
function function_71572d66(mdl_sparks, mdl_gate) {
    v_new_position = mdl_sparks.origin + mdl_gate.script_vector;
    mdl_sparks moveto(v_new_position, 1, 0.25, 0.25);
    wait 1.25;
    mdl_sparks delete();
}

// Namespace zm_escape_catwalk_event/zm_escape_catwalk_event
// Params 1, eflags: 0x0
// Checksum 0x79cd93fa, Offset: 0x1500
// Size: 0x144
function function_e99be9ba(var_e74c8bcd) {
    a_spots = struct::get_array(var_e74c8bcd, "catwalk_spawner");
    if (a_spots.size > 0) {
        foreach (s_spot in a_spots) {
            s_spot thread function_1d963237();
        }
        level flag::wait_till_clear(#"hash_6019aeb57ae7e6b5");
        foreach (s_spot in a_spots) {
            s_spot notify(#"restore");
        }
    }
}

// Namespace zm_escape_catwalk_event/zm_escape_catwalk_event
// Params 0, eflags: 0x0
// Checksum 0x465e253f, Offset: 0x1650
// Size: 0x2e
function function_1d963237() {
    self.is_enabled = 0;
    self waittill(#"restore");
    self.is_enabled = 1;
}

// Namespace zm_escape_catwalk_event/zm_escape_catwalk_event
// Params 1, eflags: 0x0
// Checksum 0x695871e1, Offset: 0x1688
// Size: 0x386
function function_15859b75(t_spawner) {
    if (isdefined(t_spawner.catwalk_spawner)) {
        level thread function_e99be9ba(t_spawner.catwalk_spawner);
    }
    if (isdefined(t_spawner.var_921263da)) {
        a_str_sets = strtok(t_spawner.var_921263da, " ");
        foreach (str_set in a_str_sets) {
            a_s_spots = struct::get_array(str_set, "catwalk_spawner");
            foreach (s_spot in a_s_spots) {
                s_spot notify(#"restore");
            }
        }
    }
    t_spawner notify(#"enemies_spawned");
    level.var_ce255064 = 1;
    var_a1da963b = struct::get_array(t_spawner.target);
    foreach (var_55be642d in var_a1da963b) {
        if (level.activeplayers.size == 1 && isdefined(var_55be642d.var_7d0383d5) && var_55be642d.var_7d0383d5) {
            continue;
        }
        e_enemy = undefined;
        if (var_55be642d.script_noteworthy == "spawn_location") {
            while (!isdefined(e_enemy)) {
                e_enemy = zombie_utility::spawn_zombie(level.zombie_spawners[0], undefined, var_55be642d);
                waitframe(1);
            }
            e_enemy thread zm_escape_util::function_1332d61("catwalk_event_zombie", 1);
            continue;
        }
        if (var_55be642d.script_noteworthy == "dog_location") {
            while (!isdefined(e_enemy)) {
                e_enemy = zombie_utility::spawn_zombie(level.dog_spawners[0]);
                waitframe(1);
            }
            e_enemy thread zm_escape_util::function_389bc4e7(var_55be642d);
            e_enemy ai::set_behavior_attribute("sprint", 1);
        }
    }
    level.var_ce255064 = 0;
}

// Namespace zm_escape_catwalk_event/zm_escape_catwalk_event
// Params 0, eflags: 0x0
// Checksum 0x1fc4ee2b, Offset: 0x1a18
// Size: 0x3b2
function function_bd2b3eea() {
    level endon(#"catwalk_event_completed");
    level.var_ce255064 = 0;
    while (true) {
        n_check_time = function_df62db55();
        e_leader = function_167ea6d();
        e_leader waittilltimeout(n_check_time, #"damage");
        while (zm_escape_util::function_6b6f3b8e("catwalk_event_zombie") && !level.var_ce255064) {
            a_ai_zombies = zombie_utility::get_zombie_array();
            a_ai_zombies = arraysort(a_ai_zombies, e_leader.origin, 0);
            var_1662a184 = arraycopy(a_ai_zombies);
            var_69a6cad9 = 0;
            foreach (ai_zombie in a_ai_zombies) {
                if (isdefined(ai_zombie) && isdefined(ai_zombie.var_7402a17a)) {
                    arrayremovevalue(var_1662a184, ai_zombie);
                    var_69a6cad9++;
                    continue;
                }
                b_can_see = 0;
                foreach (player in level.activeplayers) {
                    if (player cansee(ai_zombie)) {
                        b_can_see = 1;
                    }
                }
                if (b_can_see) {
                    arrayremovevalue(var_1662a184, ai_zombie);
                    var_69a6cad9++;
                }
            }
            a_ai_zombies = var_1662a184;
            if (var_69a6cad9 < level.var_dab4f794) {
                var_65c4cc85 = level.var_dab4f794 - var_69a6cad9;
                for (i = 1; i <= var_65c4cc85; i++) {
                    array::pop(a_ai_zombies);
                    var_69a6cad9++;
                }
            }
            foreach (ai_zombie in a_ai_zombies) {
                if (!isalive(ai_zombie)) {
                    continue;
                }
                ai_zombie kill();
                level.zombie_total++;
                level.zombie_respawns++;
                waitframe(1);
            }
            waitframe(1);
        }
        waitframe(1);
    }
}

// Namespace zm_escape_catwalk_event/zm_escape_catwalk_event
// Params 0, eflags: 0x0
// Checksum 0x23eb333e, Offset: 0x1dd8
// Size: 0xce
function function_df62db55() {
    switch (level.activeplayers.size) {
    case 1:
        n_time = 0.05;
        break;
    case 2:
        n_time = 2.9;
        break;
    case 3:
        n_time = 3.9;
        break;
    default:
        n_time = 6.1;
        break;
    }
    return n_time;
}

// Namespace zm_escape_catwalk_event/zm_escape_catwalk_event
// Params 0, eflags: 0x0
// Checksum 0x869d6c0d, Offset: 0x1eb0
// Size: 0xb0
function function_167ea6d() {
    e_leader = level.activeplayers[0];
    foreach (e_player in level.activeplayers) {
        if (e_player.origin[0] < e_leader.origin[0]) {
            e_leader = e_player;
        }
    }
    return e_leader;
}

// Namespace zm_escape_catwalk_event/zm_escape_catwalk_event
// Params 1, eflags: 0x0
// Checksum 0xa24741ff, Offset: 0x1f68
// Size: 0x346
function function_a2efdbbc(s_loc) {
    self endon(#"death");
    self.b_ignore_cleanup = 1;
    self.ignore_enemy_count = 1;
    self val::set(#"dog_spawn", "ignoreall", 1);
    self val::set(#"dog_spawn", "ignoreme", 1);
    self setfreecameralockonallowed(0);
    self forceteleport(s_loc.origin, s_loc.angles);
    self hide();
    playfx(level._effect[#"lightning_dog_spawn"], s_loc.origin);
    playsoundatposition(#"zmb_hellhound_prespawn", s_loc.origin);
    wait 1.5;
    playsoundatposition(#"zmb_hellhound_bolt", s_loc.origin);
    earthquake(0.5, 0.75, s_loc.origin, 1000);
    playsoundatposition(#"hash_42894a8e6bfacf66", (5085, 10424, 1102));
    playsoundatposition(#"zmb_hellhound_spawn", s_loc.origin);
    assert(isdefined(self), "<dev string:x30>");
    assert(isalive(self), "<dev string:x49>");
    assert(zm_utility::is_magic_bullet_shield_enabled(self), "<dev string:x5c>");
    self zombie_dog_util::zombie_setup_attack_properties_dog();
    self util::stop_magic_bullet_shield();
    wait 0.1;
    self show();
    self setfreecameralockonallowed(1);
    self val::reset(#"dog_spawn", "ignoreme");
    self val::reset(#"dog_spawn", "ignoreall");
    self notify(#"visible");
}

// Namespace zm_escape_catwalk_event/zm_escape_catwalk_event
// Params 0, eflags: 0x0
// Checksum 0x742bcfc, Offset: 0x22b8
// Size: 0x3c
function function_b029d798() {
    trigger::wait_till("t_catwalk_event_03");
    level flag::clear("spawn_zombies");
}

// Namespace zm_escape_catwalk_event/zm_escape_catwalk_event
// Params 1, eflags: 0x0
// Checksum 0xe0e0abec, Offset: 0x2300
// Size: 0x104
function function_26443ec8(a_ents) {
    e_brutus = a_ents[#"brutus"];
    if (level.brutus_count > 0) {
        var_1746b856 = getaiarchetypearray("brutus")[0];
        if (var_1746b856 != e_brutus) {
            level thread zm_escape_util::function_ddd7ade1(var_1746b856);
            level.var_e13b5b80 = 1;
        }
    }
    e_brutus.b_ignore_cleanup = 1;
    if (isdefined(a_ents[#"brutus"].var_6bc96b9)) {
        a_ents[#"brutus"].var_6bc96b9 delete();
    }
    e_brutus thread function_c4636b29();
}

// Namespace zm_escape_catwalk_event/zm_escape_catwalk_event
// Params 1, eflags: 0x0
// Checksum 0x4a79220b, Offset: 0x2410
// Size: 0x12c
function function_75432d7c(a_ents) {
    e_brutus = a_ents[#"brutus"];
    var_c114b43e = struct::get("p8_fxanim_zm_esc_recreationyard_rocks_a_bundle", "scriptbundlename");
    var_c114b43e thread scene::play("Main & Idle Loop Out");
    e_brutus = a_ents[#"brutus"];
    playsoundatposition(#"hash_2c72bd3d8ff198c9", e_brutus gettagorigin("tag_eye"));
    e_brutus waittill(#"start_teleport");
    level thread function_d9f83503();
    e_brutus waittill(#"teleport");
    e_brutus hide();
}

// Namespace zm_escape_catwalk_event/zm_escape_catwalk_event
// Params 1, eflags: 0x0
// Checksum 0x593259f2, Offset: 0x2548
// Size: 0x11e
function play_brutus_scene_done(a_ents) {
    level flag::set("spawn_zombies");
    a_enemy = getaiarchetypearray("brutus");
    level.brutus_count = a_enemy.size;
    if (isdefined(level.var_e13b5b80) && level.var_e13b5b80) {
        if (level.zones[#"zone_catwalk_04"].is_active) {
            zombie_brutus_util::attempt_brutus_spawn(1, "zone_catwalk_04");
        } else if (level.zones[#"zone_catwalk_03"].is_active) {
            zombie_brutus_util::attempt_brutus_spawn(1, "zone_catwalk_03");
        } else {
            zombie_brutus_util::attempt_brutus_spawn(1);
        }
        level.var_e13b5b80 = undefined;
    }
}

// Namespace zm_escape_catwalk_event/zm_escape_catwalk_event
// Params 0, eflags: 0x0
// Checksum 0xe17409f8, Offset: 0x2670
// Size: 0x82
function function_c4636b29() {
    self setcandamage(1);
    self.health = 10000000;
    s_result = self waittill(#"damage", #"teleport");
    if (s_result._notify == "damage") {
        level.var_e13b5b80 = 1;
    }
}

// Namespace zm_escape_catwalk_event/zm_escape_catwalk_event
// Params 1, eflags: 0x0
// Checksum 0x1fda36cd, Offset: 0x2700
// Size: 0xc8
function function_7d1a3661(a_ents) {
    foreach (var_76e89db2 in a_ents) {
        var_76e89db2.b_ignore_cleanup = 1;
        var_76e89db2 thread function_a8ba58eb();
        var_76e89db2 thread function_1adb50c();
        var_76e89db2 clientfield::set("dog_fx", 1);
    }
}

// Namespace zm_escape_catwalk_event/zm_escape_catwalk_event
// Params 0, eflags: 0x0
// Checksum 0x5225bfbb, Offset: 0x27d0
// Size: 0x9a
function function_a8ba58eb() {
    self notify(#"hash_2c989e619ebfe50a");
    self endon(#"hash_2c989e619ebfe50a");
    s_result = self waittill(#"death", #"hash_4ebd4db45f2d673a");
    if (s_result._notify == "death") {
        level thread zombie_dog_util::dog_explode_fx(self, self.origin);
        level.var_e13b5b80 = 1;
    }
}

// Namespace zm_escape_catwalk_event/zm_escape_catwalk_event
// Params 0, eflags: 0x4
// Checksum 0xb3a6976, Offset: 0x2878
// Size: 0x84
function private function_1adb50c() {
    self endon(#"death");
    self waittill(#"hash_64dded563a93f9c0");
    self notify(#"hash_4ebd4db45f2d673a");
    self ghost();
    self forceteleport(self.origin - (0, 0, 100));
}

// Namespace zm_escape_catwalk_event/zm_escape_catwalk_event
// Params 0, eflags: 0x0
// Checksum 0x62416b08, Offset: 0x2908
// Size: 0x4c
function function_d9f83503() {
    var_1ed8a1a0 = struct::get("p8_fxanim_zm_esc_catwalk_pole_electrical_bundle", "scriptbundlename");
    var_1ed8a1a0 thread scene::play("Shot 2");
}

// Namespace zm_escape_catwalk_event/zm_escape_catwalk_event
// Params 0, eflags: 0x0
// Checksum 0xf4f8ed09, Offset: 0x2960
// Size: 0x2ec
function function_850db698() {
    level notify(#"hash_7bf357f5c916ca4e");
    level endon(#"hash_7bf357f5c916ca4e");
    a_t_catwalk_event = getentarray("catwalk_event_triggers", "script_noteworthy");
    foreach (t_catwalk_event in a_t_catwalk_event) {
        if (isdefined(t_catwalk_event)) {
            t_catwalk_event delete();
        }
    }
    level flag::clear(#"hash_6019aeb57ae7e6b5");
    level.var_2d4e3645 = undefined;
    foreach (s_powerup in level.zombie_powerups) {
        if (isdefined(s_powerup.var_bada6901)) {
            s_powerup.func_should_drop_with_regular_powerups = s_powerup.var_bada6901;
            s_powerup.var_bada6901 = undefined;
        }
    }
    if (!level.var_459c76d) {
        level.var_e1c867db = level.round_number + 1;
        level thread zombie_dog_util::dog_enable_rounds();
    }
    if (isdefined(level.var_eae836f4)) {
        level.var_eae836f4 delete();
    }
    foreach (e_player in level.players) {
        e_player zm_audio::function_bb36029("surrounded", "self");
    }
    callback::remove_on_connect(&function_67edc290);
    music::setmusicstate("none");
    level.musicsystemoverride = 0;
    level flag::set(#"catwalk_event_completed");
}

// Namespace zm_escape_catwalk_event/zm_escape_catwalk_event
// Params 1, eflags: 0x0
// Checksum 0x191f2867, Offset: 0x2c58
// Size: 0x1a8
function function_2232b1b8(a_s_valid_respawn_points) {
    var_34598f60 = [];
    foreach (s_respawn_point in a_s_valid_respawn_points) {
        if (s_respawn_point.script_noteworthy == "zone_model_industries" || s_respawn_point.script_noteworthy == "zone_model_industries_upper" || s_respawn_point.script_noteworthy == "zone_west_side_exterior_upper" || s_respawn_point.script_noteworthy == "zone_west_side_exterior_upper_02" || s_respawn_point.script_noteworthy == "zone_west_side_exterior_lower" || s_respawn_point.script_noteworthy == "zone_west_side_exterior_tunnel" || s_respawn_point.script_noteworthy == "zone_powerhouse" || s_respawn_point.script_noteworthy == "zone_new_industries") {
            if (!isdefined(var_34598f60)) {
                var_34598f60 = [];
            } else if (!isarray(var_34598f60)) {
                var_34598f60 = array(var_34598f60);
            }
            var_34598f60[var_34598f60.size] = s_respawn_point;
        }
    }
    return var_34598f60;
}

// Namespace zm_escape_catwalk_event/zm_escape_catwalk_event
// Params 0, eflags: 0x0
// Checksum 0xa70575f1, Offset: 0x2e08
// Size: 0x174
function function_67edc290() {
    self endon(#"disconnect");
    a_str_zones = array("zone_catwalk_01", "zone_catwalk_02");
    while (true) {
        str_zone = self zm_zonemgr::get_player_zone();
        if (isdefined(str_zone) && isinarray(a_str_zones, str_zone) && !(isdefined(self.var_d7ed205f) && self.var_d7ed205f)) {
            self zm_audio::function_6a8ba59b("surrounded", "self", "catwalk", "surrounded");
            self.var_d7ed205f = 1;
        } else if (isdefined(str_zone) && !isinarray(a_str_zones, str_zone) && isdefined(self.var_d7ed205f) && self.var_d7ed205f) {
            self zm_audio::function_bb36029("surrounded", "self");
            self.var_d7ed205f = undefined;
        }
        wait 1;
    }
}

