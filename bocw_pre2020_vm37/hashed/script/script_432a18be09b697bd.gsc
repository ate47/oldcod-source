#using script_7fc996fe8678852;
#using scripts\core_common\aat_shared;
#using scripts\core_common\animation_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\exploder_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\item_inventory;
#using scripts\core_common\item_supply_drop;
#using scripts\core_common\laststand_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\killstreaks\killstreaks_shared;
#using scripts\killstreaks\killstreaks_util;
#using scripts\zm_common\aats\zm_aat;
#using scripts\zm_common\zm_devgui;
#using scripts\zm_common\zm_magicbox;
#using scripts\zm_common\zm_powerups;
#using scripts\zm_common\zm_round_logic;
#using scripts\zm_common\zm_score;
#using scripts\zm_common\zm_sq;
#using scripts\zm_common\zm_utility;
#using scripts\zm_common\zm_weapons;

#namespace namespace_45690bb8;

// Namespace namespace_45690bb8/namespace_45690bb8
// Params 0, eflags: 0x1 linked
// Checksum 0x6f597a30, Offset: 0x5b0
// Size: 0x5c
function init() {
    init_clientfields();
    init_quests();
    /#
        execdevgui("<dev string:x38>");
        level thread function_4b06b46e();
    #/
}

// Namespace namespace_45690bb8/namespace_45690bb8
// Params 0, eflags: 0x1 linked
// Checksum 0xc1fc833a, Offset: 0x618
// Size: 0xc4
function init_clientfields() {
    clientfield::register("scriptmover", "" + #"hash_18735ccb22cdefb5", 1, 1, "int");
    clientfield::register("scriptmover", "" + #"hash_1df73c94e87e145c", 1, 1, "int");
    clientfield::register("scriptmover", "" + #"hash_7e481cd16f021d79", 1, 1, "int");
}

// Namespace namespace_45690bb8/namespace_45690bb8
// Params 0, eflags: 0x1 linked
// Checksum 0x267fdd78, Offset: 0x6e8
// Size: 0x3e4
function init_quests() {
    level zm_sq::register(#"hash_c4b3458de63120f", #"step_1", #"hash_c4b3458de63120f", &function_6dcf4b9f, &function_cf9f04);
    level zm_sq::register(#"hash_17fcaf4800f6a2a6", #"step_1", #"hash_17fcaf4800f6a2a6", &function_49052c6a, &function_773749a4);
    level zm_sq::register(#"hash_6ffd792c789fdc3e", #"step_1", #"hash_6ffd792c789fdc3e", &function_953a87da, &function_8a3b8ea1);
    level zm_sq::register(#"hash_b530c7a7a304116", #"step_1", #"hash_b530c7a7a304116", &function_beb26915, &function_64ca4757);
    level zm_sq::register(#"hash_4481398b3702806", #"step_1", #"hash_4481398b3702806", &function_55b7455c, &function_8d254596);
    level zm_sq::register(#"hash_27afeec3970b3b60", #"step_1", #"hash_1a3b58a38cdde9eb", &function_21c1b671, &function_51bd2bd5);
    level zm_sq::register(#"hash_27afeec3970b3b60", #"step_2", #"hash_1a3b59a38cddeb9e", &function_8d749d26, &function_dd843411);
    level zm_sq::register(#"hash_bac7d727e093e91", #"step_1", #"hash_17f11bdabf28a22c", &function_79f95e6e, &function_6d60894b);
    level zm_sq::register(#"hash_bac7d727e093e91", #"step_2", #"hash_17f11edabf28a745", &function_de12a4a9, &function_332fa187);
    level zm_sq::register(#"hash_71e04a201d2b2586", #"step_1", #"hash_71e04a201d2b2586", &function_2d90874d, &function_3822111d);
    level.var_c49b0cf5 = 0;
    level thread function_2abef8da();
}

// Namespace namespace_45690bb8/namespace_45690bb8
// Params 0, eflags: 0x5 linked
// Checksum 0xc7bbb949, Offset: 0xad8
// Size: 0x104
function private function_2abef8da() {
    level zm_sq::start(#"hash_c4b3458de63120f");
    level zm_sq::start(#"hash_b530c7a7a304116");
    level zm_sq::start(#"hash_27afeec3970b3b60");
    level zm_sq::start(#"hash_4481398b3702806");
    level zm_sq::start(#"hash_bac7d727e093e91");
    level zm_sq::start(#"hash_6ffd792c789fdc3e");
    level zm_sq::start(#"hash_71e04a201d2b2586");
    level zm_sq::start(#"hash_17fcaf4800f6a2a6");
}

// Namespace namespace_45690bb8/namespace_45690bb8
// Params 1, eflags: 0x1 linked
// Checksum 0xba62c0b1, Offset: 0xbe8
// Size: 0x2c2
function function_6dcf4b9f(*var_a276c861) {
    level endon(#"hash_2d0433bbc2675311");
    for (var_9586717b = 0; true; var_9586717b = level.round_number) {
        level waittill(#"into_the_dark_side", #"end_of_round");
        waitframe(1);
        if (level.round_number <= var_9586717b || !level flag::get(#"dark_aether_active")) {
            continue;
        }
        var_f6ed35c4 = getent("sq_hh_5th_door", "targetname");
        var_3cfbb4bb = struct::get("sq_hh_5th_door_init_loc", "targetname");
        waitframe(1);
        var_f6ed35c4 rotateto(var_3cfbb4bb.angles, 0.1);
        if (isdefined(level.var_864118a2)) {
            var_dfef3ad2 = struct::get("sq_hh_s_summoner_hand_loc", "targetname");
            level.var_864118a2 moveto(var_dfef3ad2.origin, 0.1);
        }
        var_c2a74bf5 = [];
        var_c2a74bf5 = getentarray("sq_helping_hand_door_button", "targetname");
        level.var_903a6494 = var_c2a74bf5.size;
        if (level flag::get(#"hash_46113ff0abdbbbb8")) {
            level thread function_a8dc8da3();
            continue;
        }
        foreach (var_801eb7e8 in var_c2a74bf5) {
            t_damage = getent(var_801eb7e8.target, "targetname");
            var_801eb7e8 thread function_3ebb9aa4(t_damage);
        }
    }
}

// Namespace namespace_45690bb8/namespace_45690bb8
// Params 1, eflags: 0x1 linked
// Checksum 0x30ac25cf, Offset: 0xeb8
// Size: 0x134
function function_3ebb9aa4(t_damage) {
    level endon(#"hash_2d0433bbc2675311", #"dark_side_timeout");
    while (true) {
        waitresult = t_damage waittill(#"damage");
        if (isdefined(waitresult) && isplayer(waitresult.attacker) && zm_weapons::is_weapon_upgraded(waitresult.weapon)) {
            level.var_903a6494--;
            var_b40be993 = self.script_noteworthy;
            exploder::exploder("lgt_env_helping_hand_" + var_b40be993);
            if (level.var_903a6494 == 0) {
                level thread function_a8dc8da3();
                level flag::set(#"hash_46113ff0abdbbbb8");
            }
            break;
        }
    }
}

// Namespace namespace_45690bb8/namespace_45690bb8
// Params 0, eflags: 0x1 linked
// Checksum 0x88e4ddc5, Offset: 0xff8
// Size: 0x17c
function function_a8dc8da3() {
    level endon(#"hash_2d0433bbc2675311", #"dark_side_timeout");
    var_2c8ebaf = struct::get("sq_hh_5th_door_button_loc", "targetname");
    var_82a319ce = util::spawn_model(#"p8_zm_ori_button_alarm", var_2c8ebaf.origin, var_2c8ebaf.angles);
    var_82a319ce moveto(var_82a319ce.origin + (15, 0, 0), 2);
    t_damage = getent(var_2c8ebaf.target, "targetname");
    var_7f729179 = t_damage waittill(#"damage");
    level.var_a4a95081 = var_7f729179.attacker;
    var_b40be993 = var_2c8ebaf.script_noteworthy;
    exploder::exploder("lgt_env_helping_hand_" + var_b40be993);
    level function_9a4f25ac();
}

// Namespace namespace_45690bb8/namespace_45690bb8
// Params 0, eflags: 0x1 linked
// Checksum 0x466cf004, Offset: 0x1180
// Size: 0x42c
function function_9a4f25ac() {
    level endon(#"hash_2d0433bbc2675311", #"dark_side_timeout");
    var_dfef3ad2 = struct::get("sq_hh_s_summoner_hand_loc", "targetname");
    var_695c4d69 = struct::get("sq_hh_s_summoner_hand_dest_loc", "targetname");
    if (!isdefined(level.var_864118a2)) {
        level.var_864118a2 = util::spawn_model(#"hash_223f38609fe72722", var_dfef3ad2.origin, var_dfef3ad2.angles);
    }
    var_f6ed35c4 = getent("sq_hh_5th_door", "targetname");
    var_f6ed35c4 rotateto(var_f6ed35c4.angles + (0, 90, 0), 0.5, 0.1, 0.1);
    wait 0.5;
    if (!isdefined(level.var_fe0060a)) {
        level.var_fe0060a = getent("sq_hh_hand_trigger_kill", "targetname");
        level.var_fe0060a enablelinkto();
        level.var_fe0060a linkto(level.var_864118a2);
    }
    level.var_fe0060a thread function_e3c937ee();
    level notify(#"hash_9be4bc3b1815505");
    level.var_864118a2 moveto(var_695c4d69.origin, 0.5);
    level.var_864118a2 rotateto(var_695c4d69.angles, 0.5);
    wait 0.5;
    level.var_864118a2 rotateto(var_695c4d69.angles + (10, 10, 5), 0.5);
    wait 0.5;
    level.var_864118a2 rotateto(var_695c4d69.angles + (-10, -10, 5), 0.5);
    wait 0.5;
    level.var_864118a2 rotateto(var_695c4d69.angles + (10, 10, 5), 0.5);
    wait 0.5;
    level.var_864118a2 rotateto(var_695c4d69.angles + (-10, -10, -5), 0.5);
    wait 0.5;
    level.var_864118a2 rotateto(var_695c4d69.angles + (10, 10, 5), 0.5);
    wait 0.5;
    level.var_864118a2 rotateto(var_695c4d69.angles, 0.5);
    wait 0.5;
    var_f6ed35c4 rotateto(var_f6ed35c4.angles + (0, -90, 0), 0.5, 0.1, 0.1);
    level.var_864118a2 notify(#"hash_2a99af380310fcbb");
    level.var_864118a2 moveto(var_dfef3ad2.origin, 0.6);
}

// Namespace namespace_45690bb8/namespace_45690bb8
// Params 0, eflags: 0x1 linked
// Checksum 0xe8c3ba37, Offset: 0x15b8
// Size: 0x114
function function_e3c937ee() {
    level endon(#"hash_2d0433bbc2675311", #"dark_side_timeout");
    self endon(#"hash_2a99af380310fcbb");
    while (true) {
        s_result = self waittill(#"trigger");
        if (isalive(s_result.activator) && s_result.activator.archetype == #"zombie") {
            s_result.activator kill();
            level.var_c49b0cf5 += 1;
            if (level.var_c49b0cf5 >= 40) {
                level thread function_76f53c53();
                break;
            }
        }
    }
}

// Namespace namespace_45690bb8/namespace_45690bb8
// Params 0, eflags: 0x1 linked
// Checksum 0xbae18e0a, Offset: 0x16d8
// Size: 0xf4
function function_76f53c53() {
    player = level.var_a4a95081;
    if (!player laststand::player_is_in_laststand() && player.sessionstate !== "spectator") {
        weap = player getcurrentweapon();
        item = player item_inventory::function_230ceec4(weap);
        if (item.var_a8bccf69 == 3) {
            player zm_score::add_to_player_score(1000);
        } else {
            player item_inventory::function_73ae3380(item, 3);
        }
    }
    level flag::set(#"hash_2d0433bbc2675311");
}

// Namespace namespace_45690bb8/namespace_45690bb8
// Params 2, eflags: 0x1 linked
// Checksum 0xe903bff6, Offset: 0x17d8
// Size: 0x44
function function_cf9f04(var_a276c861, var_19e802fa) {
    if (var_a276c861 || var_19e802fa) {
        level flag::set(#"hash_2d0433bbc2675311");
    }
}

// Namespace namespace_45690bb8/namespace_45690bb8
// Params 1, eflags: 0x1 linked
// Checksum 0xdd11f3c7, Offset: 0x1828
// Size: 0xa0
function function_49052c6a(*var_a276c861) {
    level endon(#"distance_monster_finished");
    var_172621cc = struct::get("sq_distance_monster_loc", "targetname");
    while (!level flag::get("distance_monster_anim_start_play")) {
        level waittill(#"into_the_dark_side");
        var_172621cc thread function_3e37f363();
    }
}

// Namespace namespace_45690bb8/namespace_45690bb8
// Params 0, eflags: 0x1 linked
// Checksum 0xe98c4310, Offset: 0x18d0
// Size: 0x15c
function function_3e37f363() {
    level endon(#"distance_monster_finished", #"dark_side_timeout");
    if (zm_round_logic::get_round_number() >= 40) {
        playsoundatposition(#"hash_4ec7d60ade69984c", (1616, 741, -270));
        t_trigger = getent("sq_distance_monster_loc_trigger", "targetname");
        t_trigger waittill(#"trigger");
        wait 3;
        var_a921b87b = util::spawn_anim_model(#"hash_3f1f327e179d79ca", self.origin, self.angles);
        level flag::set("distance_monster_anim_start_play");
        var_a921b87b scene::play(#"hash_2f425040d5e62683", "walk");
        level flag::set("distance_monster_finished");
    }
}

// Namespace namespace_45690bb8/namespace_45690bb8
// Params 2, eflags: 0x1 linked
// Checksum 0xf82eef58, Offset: 0x1a38
// Size: 0x44
function function_773749a4(var_a276c861, var_19e802fa) {
    if (var_a276c861 || var_19e802fa) {
        level flag::set(#"distance_monster_finished");
    }
}

// Namespace namespace_45690bb8/namespace_45690bb8
// Params 1, eflags: 0x1 linked
// Checksum 0x5b621ca2, Offset: 0x1a88
// Size: 0x6ac
function function_953a87da(*var_a276c861) {
    level endon(#"heavy_footfalls_finished");
    while (true) {
        level waittill(#"start_of_round");
        if (level.round_number <= 15) {
            continue;
        }
        wait randomintrange(60, 120);
        if (!level flag::get(#"dark_aether_active")) {
            continue;
        }
        var_64a4aebe = [];
        if (!isdefined(var_64a4aebe)) {
            var_64a4aebe = [];
        } else if (!isarray(var_64a4aebe)) {
            var_64a4aebe = array(var_64a4aebe);
        }
        var_64a4aebe[var_64a4aebe.size] = #"zone_proto_start";
        if (!isdefined(var_64a4aebe)) {
            var_64a4aebe = [];
        } else if (!isarray(var_64a4aebe)) {
            var_64a4aebe = array(var_64a4aebe);
        }
        var_64a4aebe[var_64a4aebe.size] = #"zone_proto_start2";
        if (!isdefined(var_64a4aebe)) {
            var_64a4aebe = [];
        } else if (!isarray(var_64a4aebe)) {
            var_64a4aebe = array(var_64a4aebe);
        }
        var_64a4aebe[var_64a4aebe.size] = #"zone_proto_interior_lower";
        if (!isdefined(var_64a4aebe)) {
            var_64a4aebe = [];
        } else if (!isarray(var_64a4aebe)) {
            var_64a4aebe = array(var_64a4aebe);
        }
        var_64a4aebe[var_64a4aebe.size] = #"zone_proto_interior_cave";
        if (!isdefined(var_64a4aebe)) {
            var_64a4aebe = [];
        } else if (!isarray(var_64a4aebe)) {
            var_64a4aebe = array(var_64a4aebe);
        }
        var_64a4aebe[var_64a4aebe.size] = #"zone_proto_upstairs";
        if (!isdefined(var_64a4aebe)) {
            var_64a4aebe = [];
        } else if (!isarray(var_64a4aebe)) {
            var_64a4aebe = array(var_64a4aebe);
        }
        var_64a4aebe[var_64a4aebe.size] = #"zone_proto_upstairs_2";
        if (!isdefined(var_64a4aebe)) {
            var_64a4aebe = [];
        } else if (!isarray(var_64a4aebe)) {
            var_64a4aebe = array(var_64a4aebe);
        }
        var_64a4aebe[var_64a4aebe.size] = #"zone_proto_roof_plane";
        if (!isdefined(var_64a4aebe)) {
            var_64a4aebe = [];
        } else if (!isarray(var_64a4aebe)) {
            var_64a4aebe = array(var_64a4aebe);
        }
        var_64a4aebe[var_64a4aebe.size] = #"zone_proto_exterior_rear";
        if (!isdefined(var_64a4aebe)) {
            var_64a4aebe = [];
        } else if (!isarray(var_64a4aebe)) {
            var_64a4aebe = array(var_64a4aebe);
        }
        var_64a4aebe[var_64a4aebe.size] = #"zone_proto_exterior_rear2";
        if (!isdefined(var_64a4aebe)) {
            var_64a4aebe = [];
        } else if (!isarray(var_64a4aebe)) {
            var_64a4aebe = array(var_64a4aebe);
        }
        var_64a4aebe[var_64a4aebe.size] = #"zone_proto_plane_exterior";
        if (!isdefined(var_64a4aebe)) {
            var_64a4aebe = [];
        } else if (!isarray(var_64a4aebe)) {
            var_64a4aebe = array(var_64a4aebe);
        }
        var_64a4aebe[var_64a4aebe.size] = #"zone_proto_plane_exterior2";
        if (!isdefined(var_64a4aebe)) {
            var_64a4aebe = [];
        } else if (!isarray(var_64a4aebe)) {
            var_64a4aebe = array(var_64a4aebe);
        }
        var_64a4aebe[var_64a4aebe.size] = #"zone_power_tunnel";
        if (!isdefined(var_64a4aebe)) {
            var_64a4aebe = [];
        } else if (!isarray(var_64a4aebe)) {
            var_64a4aebe = array(var_64a4aebe);
        }
        var_64a4aebe[var_64a4aebe.size] = #"zone_tunnel_interior";
        var_7a4815da = 1;
        foreach (zone_name in var_64a4aebe) {
            if (level.zones[zone_name].is_occupied) {
                var_7a4815da = 0;
            }
        }
        if (!is_true(var_7a4815da)) {
            continue;
        }
        if (!math::cointoss(10)) {
            continue;
        }
        var_64a4aebe thread function_b21d09cb();
        if (flag::get(#"hash_3ccb64b9306f3030")) {
            break;
        }
    }
    level waittill(#"end_of_round");
    s_max_ammo_loc = struct::get("s_max_ammo_loc", "targetname");
    level zm_powerups::specific_powerup_drop("full_ammo", s_max_ammo_loc.origin, undefined, undefined, undefined, 1, undefined, undefined, undefined, 1);
}

// Namespace namespace_45690bb8/namespace_45690bb8
// Params 1, eflags: 0x1 linked
// Checksum 0x95a83c2b, Offset: 0x2140
// Size: 0xe4
function function_b21d09cb(*var_a276c861) {
    level endon(#"heavy_footfalls_finished", #"end_of_round");
    level flag::set(#"hash_3ccb64b9306f3030");
    var_169fc18f = struct::get("s_sq_heavy_footfalls_snd_loc", "targetname");
    var_24be5744 = spawn("script_origin", var_169fc18f.origin);
    var_24be5744 playsound(#"hash_4ec7d60ade69984c");
    self thread function_ee554505(var_24be5744);
}

// Namespace namespace_45690bb8/namespace_45690bb8
// Params 1, eflags: 0x1 linked
// Checksum 0x8216cdd4, Offset: 0x2230
// Size: 0xe4
function function_ee554505(var_24be5744) {
    level endon(#"dark_side_timeout");
    while (true) {
        waitresult = level waittill(#"newzoneactive");
        activezone = waitresult.zone;
        if (isinarray(self, activezone)) {
            break;
        }
    }
    level flag::set("heavy_footfalls_finished");
    var_24be5744 stopsounds();
    wait 1;
    var_24be5744 playsound(#"hash_189fe24269ad58d");
}

// Namespace namespace_45690bb8/namespace_45690bb8
// Params 2, eflags: 0x1 linked
// Checksum 0xeb54f31c, Offset: 0x2320
// Size: 0x44
function function_8a3b8ea1(var_a276c861, var_19e802fa) {
    if (var_a276c861 || var_19e802fa) {
        level flag::set(#"heavy_footfalls_finished");
    }
}

// Namespace namespace_45690bb8/namespace_45690bb8
// Params 1, eflags: 0x1 linked
// Checksum 0x9abf1e39, Offset: 0x2370
// Size: 0x120
function function_beb26915(*var_a276c861) {
    level endon(#"hash_59a98cc550dbc416");
    level flag::wait_till(#"pap_quest_completed");
    level.var_e5a3bba0 = 0;
    level.var_8290e497 = 1;
    while (true) {
        level thread function_eb87e687();
        waitresult = level waittill(#"all_players_on_rooftop", #"end_of_round");
        if (waitresult._notify == "all_players_on_rooftop" && level.round_number > level.var_e5a3bba0 && is_true(level.var_8290e497)) {
            level thread care_package_drop();
        }
    }
}

// Namespace namespace_45690bb8/namespace_45690bb8
// Params 0, eflags: 0x1 linked
// Checksum 0x3fa3059a, Offset: 0x2498
// Size: 0x1a0
function function_eb87e687() {
    level endon(#"hash_59a98cc550dbc416", #"end_of_round");
    var_4045962d = 0;
    var_de5f56d8 = getent("t_sq_crpkg_all_players_in", "targetname");
    var_1dc85dfd = 0;
    waitframe(1);
    while (true) {
        if (var_1dc85dfd >= 300) {
            break;
        }
        players = getplayers();
        foreach (player in players) {
            if (player istouching(var_de5f56d8) && isalive(player)) {
                var_4045962d += 1;
            }
        }
        wait 1;
        var_1dc85dfd++;
        if (var_4045962d >= players.size) {
            continue;
        }
        var_4045962d = 0;
        var_1dc85dfd = 0;
    }
    level notify(#"all_players_on_rooftop");
}

// Namespace namespace_45690bb8/namespace_45690bb8
// Params 0, eflags: 0x1 linked
// Checksum 0x21c4b547, Offset: 0x2640
// Size: 0x23c
function care_package_drop() {
    level endon(#"hash_59a98cc550dbc416");
    foreach (var_e9e0c9c2, destination in level.var_7d45d0d4.destinations) {
        if (destination.targetname === #"hash_86dbad917999c92") {
            foreach (location in destination.locations) {
                var_30cea8e0 = location.instances[#"hash_b72834e821a0e34"];
                if (isdefined(var_30cea8e0)) {
                    namespace_8b6a9d79::function_20d7e9c7(var_30cea8e0);
                    var_44292111 = array::random(var_30cea8e0.var_fe2612fe[#"hash_42043afbdf06011b"]);
                    s_portal = var_44292111.var_fe2612fe[#"hash_6bbb00324d163e11"][0];
                    var_60470a92 = item_supply_drop::function_9771c7db(s_portal.origin, #"hash_24069cdc9a392c4b");
                    level.var_8290e497 = 0;
                    var_60470a92 thread function_ed4fed04();
                    level.var_e5a3bba0 = level.round_number;
                }
            }
        }
    }
    assert(var_e9e0c9c2 == 1);
}

// Namespace namespace_45690bb8/namespace_45690bb8
// Params 0, eflags: 0x1 linked
// Checksum 0x7f45adb5, Offset: 0x2888
// Size: 0x5c
function function_ed4fed04() {
    level endon(#"hash_59a98cc550dbc416");
    while (true) {
        if (is_true(self.var_32ed1056)) {
            break;
        }
        wait 1;
    }
    level.var_8290e497 = 1;
}

// Namespace namespace_45690bb8/namespace_45690bb8
// Params 2, eflags: 0x1 linked
// Checksum 0xe12ba209, Offset: 0x28f0
// Size: 0x44
function function_64ca4757(var_a276c861, var_19e802fa) {
    if (var_a276c861 || var_19e802fa) {
        level flag::set(#"hash_59a98cc550dbc416");
    }
}

// Namespace namespace_45690bb8/namespace_45690bb8
// Params 1, eflags: 0x1 linked
// Checksum 0x34dbf013, Offset: 0x2940
// Size: 0x2f0
function function_55b7455c(*var_a276c861) {
    level endon(#"hash_5bd6478fda3ecd66");
    level.var_3dbbe6fd = [];
    dish_top_0 = getent("sq_dish_reception_top_0", "targetname");
    dish_top_1 = getent("sq_dish_reception_top_1", "targetname");
    dish_top_2 = getent("sq_dish_reception_top_2", "targetname");
    if (!isdefined(level.var_3dbbe6fd)) {
        level.var_3dbbe6fd = [];
    } else if (!isarray(level.var_3dbbe6fd)) {
        level.var_3dbbe6fd = array(level.var_3dbbe6fd);
    }
    level.var_3dbbe6fd[level.var_3dbbe6fd.size] = dish_top_0;
    if (!isdefined(level.var_3dbbe6fd)) {
        level.var_3dbbe6fd = [];
    } else if (!isarray(level.var_3dbbe6fd)) {
        level.var_3dbbe6fd = array(level.var_3dbbe6fd);
    }
    level.var_3dbbe6fd[level.var_3dbbe6fd.size] = dish_top_1;
    if (!isdefined(level.var_3dbbe6fd)) {
        level.var_3dbbe6fd = [];
    } else if (!isarray(level.var_3dbbe6fd)) {
        level.var_3dbbe6fd = array(level.var_3dbbe6fd);
    }
    level.var_3dbbe6fd[level.var_3dbbe6fd.size] = dish_top_2;
    foreach (var_e0293c9f in level.var_3dbbe6fd) {
        var_e0293c9f setcandamage(1);
        var_e0293c9f.var_6bcfddd1 = 0;
        var_e0293c9f.allowdeath = 0;
        var_e0293c9f.var_473cfebb = 0;
        var_e0293c9f thread function_b0f7f657();
    }
}

// Namespace namespace_45690bb8/namespace_45690bb8
// Params 0, eflags: 0x1 linked
// Checksum 0xcf1c0520, Offset: 0x2c38
// Size: 0x1f4
function function_b0f7f657() {
    level endon(#"game_ended");
    while (true) {
        waitresult = self waittill(#"damage");
        weaponclass = waitresult util::getweaponclass(waitresult.weapon);
        str_name = waitresult.attacker.aat[aat::function_702fb333(waitresult.weapon)];
        if (!isdefined(str_name)) {
            continue;
        }
        var_5980e1ed = zm_aat::function_296cde87(str_name);
        if (isdefined(waitresult) && isplayer(waitresult.attacker) && weaponclass === #"weapon_sniper" && var_5980e1ed === "ammomod_deadwire") {
            self function_8e6fde15();
            self.var_6bcfddd1++;
            if (self.var_6bcfddd1 % 4 == self.script_noteworthy) {
                self.var_473cfebb = 1;
                if (level.var_3dbbe6fd[0].var_473cfebb && level.var_3dbbe6fd[1].var_473cfebb && level.var_3dbbe6fd[2].var_473cfebb) {
                    break;
                }
                continue;
            }
            self.var_473cfebb = 0;
        }
    }
    level thread function_58fea01e();
}

// Namespace namespace_45690bb8/namespace_45690bb8
// Params 0, eflags: 0x1 linked
// Checksum 0xbd733957, Offset: 0x2e38
// Size: 0x4c
function function_8e6fde15() {
    level endon(#"game_ended");
    self rotateto(self.angles - (0, 90, 0), 0.5);
}

// Namespace namespace_45690bb8/namespace_45690bb8
// Params 0, eflags: 0x1 linked
// Checksum 0x3cbc0e04, Offset: 0x2e90
// Size: 0x1a0
function function_58fea01e() {
    level endon(#"game_ended");
    antenna = getent("sq_dish_reception_antenna", "targetname");
    antenna clientfield::set("" + #"hash_1df73c94e87e145c", 1);
    var_46358077 = getent("sq_dish_reception_boom_box", "targetname");
    playsoundatposition(#"hash_4ec7d60ade69984c", var_46358077.origin);
    var_22481c68 = struct::get_array("essence_pickup_spawner", "targetname");
    foreach (var_2db4f648 in var_22481c68) {
        level zm_powerups::specific_powerup_drop("bonus_points_player", var_2db4f648.origin, undefined, undefined, undefined, undefined, undefined, undefined, undefined, 1);
    }
}

// Namespace namespace_45690bb8/namespace_45690bb8
// Params 2, eflags: 0x1 linked
// Checksum 0xbdc08641, Offset: 0x3038
// Size: 0x44
function function_8d254596(var_a276c861, var_19e802fa) {
    if (var_a276c861 || var_19e802fa) {
        level flag::set(#"hash_5bd6478fda3ecd66");
    }
}

// Namespace namespace_45690bb8/namespace_45690bb8
// Params 1, eflags: 0x1 linked
// Checksum 0x5877e108, Offset: 0x3088
// Size: 0x1e4
function function_21c1b671(*var_a276c861) {
    level endon(#"hash_41d853f73964918a");
    var_17c3271a = [];
    var_17c3271a = struct::get_array("sq_dance_party_light_ball_spawn_loc", "targetname");
    level.var_1aa09a0 = var_17c3271a.size;
    level flag::wait_till(#"pap_quest_completed");
    var_a8964e4e = [];
    var_a75f9486 = 0;
    foreach (var_a75f9486, var_764631a2 in var_17c3271a) {
        var_a8964e4e[var_a75f9486] = util::spawn_model("tag_origin", var_764631a2.origin, var_764631a2.angles);
        var_a8964e4e[var_a75f9486] clientfield::set("" + #"hash_18735ccb22cdefb5", 1);
        t_damage = getent(var_764631a2.target, "targetname");
        level thread function_d54434e2(var_a8964e4e[var_a75f9486], t_damage);
    }
    level flag::wait_till(#"hash_76b83a765dea94a5");
}

// Namespace namespace_45690bb8/namespace_45690bb8
// Params 2, eflags: 0x1 linked
// Checksum 0xbab8bb10, Offset: 0x3278
// Size: 0x11c
function function_d54434e2(var_33aa4c59, t_damage) {
    s_result = t_damage waittill(#"damage");
    if (isdefined(t_damage) && isdefined(level.var_1aa09a0) && isdefined(var_33aa4c59) && isplayer(s_result.attacker)) {
        level.var_1aa09a0--;
        var_33aa4c59 clientfield::set("" + #"hash_18735ccb22cdefb5", 0);
        t_damage.in_use = 0;
        waitframe(1);
        if (isdefined(t_damage)) {
            t_damage delete();
        }
    }
    if (level.var_1aa09a0 == 0) {
        level flag::set(#"hash_76b83a765dea94a5");
    }
}

// Namespace namespace_45690bb8/namespace_45690bb8
// Params 2, eflags: 0x1 linked
// Checksum 0xdf3d70a5, Offset: 0x33a0
// Size: 0x44
function function_51bd2bd5(var_a276c861, var_19e802fa) {
    if (var_a276c861 || var_19e802fa) {
        level flag::set(#"hash_76b83a765dea94a5");
    }
}

// Namespace namespace_45690bb8/namespace_45690bb8
// Params 1, eflags: 0x1 linked
// Checksum 0xa8d50e26, Offset: 0x33f0
// Size: 0x11c
function function_8d749d26(*var_a276c861) {
    function_7c1dec03();
    var_dce62e8d = [];
    var_dce62e8d = struct::get_array("sq_dance_party_anim_spot_zombie", "targetname");
    var_295860a = [];
    for (var_d4285804 = 0; var_d4285804 < 4; var_d4285804++) {
        var_295860a[var_d4285804] = util::spawn_anim_model(#"hash_28ac44535e703a6d", var_dce62e8d[var_d4285804].origin, var_dce62e8d[var_d4285804].angles);
        var_295860a[var_d4285804].index = var_d4285804;
        var_295860a[var_d4285804] thread function_d65e852();
    }
    exploder::kill_exploder("lgt_env_powered_on_room_10");
    exploder::exploder("lgt_env_dance_party");
}

// Namespace namespace_45690bb8/namespace_45690bb8
// Params 0, eflags: 0x1 linked
// Checksum 0x71221748, Offset: 0x3518
// Size: 0x70
function function_7c1dec03() {
    level.var_1dec84bc = [];
    level.var_1dec84bc[0] = #"hash_493c0b66761878f8";
    level.var_1dec84bc[1] = #"hash_493c0e6676187e11";
    level.var_1dec84bc[2] = #"hash_6870872425c8f545";
    level.var_1dec84bc[3] = #"hash_4db27b47b5007c1a";
}

// Namespace namespace_45690bb8/namespace_45690bb8
// Params 0, eflags: 0x1 linked
// Checksum 0xb5eca021, Offset: 0x3590
// Size: 0x84
function function_d65e852() {
    var_63987e05 = self.index;
    wait 1;
    self animation::play(level.var_1dec84bc[var_63987e05], self.origin, self.angles);
    wait 5;
    exploder::kill_exploder("lgt_env_dance_party");
    exploder::exploder("lgt_env_powered_on_room_10");
}

// Namespace namespace_45690bb8/namespace_45690bb8
// Params 2, eflags: 0x1 linked
// Checksum 0xaaedc3fe, Offset: 0x3620
// Size: 0x44
function function_dd843411(var_a276c861, var_19e802fa) {
    if (var_a276c861 || var_19e802fa) {
        level flag::set(#"hash_6f9137e153db482");
    }
}

// Namespace namespace_45690bb8/namespace_45690bb8
// Params 1, eflags: 0x1 linked
// Checksum 0xc0efa345, Offset: 0x3670
// Size: 0x44
function function_79f95e6e(*var_a276c861) {
    level thread function_526cdf65();
    level flag::wait_till(#"hash_2911197b2e79b446");
}

// Namespace namespace_45690bb8/namespace_45690bb8
// Params 0, eflags: 0x1 linked
// Checksum 0x2d73cc70, Offset: 0x36c0
// Size: 0x2e0
function function_526cdf65() {
    level endon(#"hash_2911197b2e79b446");
    var_538ce99a = [];
    var_538ce99a = struct::get_array("eye_in_dark_loc", "targetname");
    level.var_5120faba = var_538ce99a.size;
    level.var_f7e25971 = [];
    var_a75f9486 = 0;
    foreach (var_a75f9486, var_a778542f in var_538ce99a) {
        level.var_f7e25971[var_a75f9486] = util::spawn_model("p7_corpse_zsf_male_bentover_01", var_a778542f.origin, var_a778542f.angles);
        level.var_f7e25971[var_a75f9486].location_name = var_a778542f.script_string;
        level.var_f7e25971[var_a75f9486].script_noteworthy = var_a778542f.script_noteworthy;
        level.var_f7e25971[var_a75f9486] hide();
        level.var_f7e25971[var_a75f9486].killed = 0;
    }
    while (true) {
        level waittill(#"into_the_dark_side");
        if (level.var_5120faba <= 0) {
            level flag::set(#"hash_2911197b2e79b446");
            break;
        }
        while (true) {
            var_c9e11aea = array::random(level.var_f7e25971);
            if (!is_true(var_c9e11aea.killed)) {
                var_c9e11aea thread function_fd27a338();
                var_218c22c5 = var_c9e11aea.script_noteworthy;
                exploder::exploder("lgt_env_eyes_in_dark_" + var_218c22c5);
                iprintlnbold("Corpse is Spawned: " + var_c9e11aea.location_name);
                iprintln("Corpse is Spawned: " + var_c9e11aea.location_name);
                break;
            }
        }
    }
}

// Namespace namespace_45690bb8/namespace_45690bb8
// Params 0, eflags: 0x1 linked
// Checksum 0x5d7d9e66, Offset: 0x39a8
// Size: 0x228
function function_fd27a338() {
    level endon(#"hash_2911197b2e79b446", #"dark_side_timeout");
    self show();
    self setcandamage(1);
    self bobbing((0, 0, 1), randomfloatrange(2, 10), randomfloatrange(5, 7));
    if (math::cointoss()) {
        self rotate((randomintrange(20 * -1, 20), randomintrange(20 * -1, 20), randomintrange(20 * -1, 20)));
    }
    while (true) {
        waitresult = self waittill(#"damage");
        if (isplayer(waitresult.attacker)) {
            self setcandamage(0);
            self.killed = 1;
            self clientfield::set("" + #"hash_7e481cd16f021d79", 1);
            self hide();
            var_218c22c5 = self.script_noteworthy;
            exploder::kill_exploder("lgt_env_eyes_in_dark_" + var_218c22c5);
            level.var_5120faba--;
            break;
        }
    }
}

// Namespace namespace_45690bb8/namespace_45690bb8
// Params 2, eflags: 0x1 linked
// Checksum 0xf009e545, Offset: 0x3bd8
// Size: 0x44
function function_6d60894b(var_a276c861, var_19e802fa) {
    if (var_a276c861 || var_19e802fa) {
        level flag::set(#"hash_2911197b2e79b446");
    }
}

// Namespace namespace_45690bb8/namespace_45690bb8
// Params 1, eflags: 0x1 linked
// Checksum 0x9e589f0f, Offset: 0x3c28
// Size: 0xac
function function_de12a4a9(*var_a276c861) {
    level endon(#"hash_7e1e35ba97e10de9");
    var_30925401 = struct::get("eye_in_dark_final_loc", "targetname");
    var_adeed566 = util::spawn_model("p7_corpse_zsf_male_bentover_01", var_30925401.origin, var_30925401.angles);
    var_adeed566.script_noteworthy = var_30925401.script_noteworthy;
    var_adeed566 thread function_58095ffb();
}

// Namespace namespace_45690bb8/namespace_45690bb8
// Params 0, eflags: 0x1 linked
// Checksum 0x754ce127, Offset: 0x3ce0
// Size: 0x174
function function_58095ffb() {
    level endon(#"hash_7e1e35ba97e10de9");
    self setcandamage(1);
    self bobbing((0, 0, 1), randomfloatrange(2, 10), randomfloatrange(5, 7));
    if (math::cointoss()) {
        self rotate((randomintrange(20 * -1, 20), randomintrange(20 * -1, 20), randomintrange(20 * -1, 20)));
    }
    var_218c22c5 = self.script_noteworthy;
    exploder::exploder("lgt_env_eyes_in_dark_" + var_218c22c5);
    self thread function_f05d7d5b();
    self thread function_98908135();
}

// Namespace namespace_45690bb8/namespace_45690bb8
// Params 0, eflags: 0x1 linked
// Checksum 0x36b93362, Offset: 0x3e60
// Size: 0x210
function function_f05d7d5b() {
    level endon(#"hash_7e1e35ba97e10de9");
    self endon(#"hash_ded7646063b7a4d");
    while (true) {
        waitresult = self waittill(#"damage");
        if (isplayer(waitresult.attacker)) {
            self notify(#"hash_472280df4a5df5a9");
            self setcandamage(0);
            self.killed = 1;
            self hide();
            var_218c22c5 = self.script_noteworthy;
            exploder::kill_exploder("lgt_env_eyes_in_dark_" + var_218c22c5);
            self clientfield::set("" + #"hash_7e481cd16f021d79", 1);
            break;
        }
    }
    wait 3;
    var_f4485dae = getplayers();
    foreach (player in var_f4485dae) {
        if (isalive(player)) {
            killstreak_name = array::random(level.killstreaks).usagekey;
            player killstreaks::give(killstreak_name);
        }
    }
}

// Namespace namespace_45690bb8/namespace_45690bb8
// Params 0, eflags: 0x1 linked
// Checksum 0x531a5093, Offset: 0x4078
// Size: 0x12c
function function_98908135() {
    level endon(#"hash_7e1e35ba97e10de9");
    self endon(#"hash_472280df4a5df5a9");
    trigger = getent("t_final_corpse", "targetname");
    waitresult = trigger waittill(#"trigger");
    self notify(#"hash_ded7646063b7a4d");
    self setcandamage(0);
    self.killed = 1;
    self hide();
    var_218c22c5 = self.script_noteworthy;
    exploder::kill_exploder("lgt_env_eyes_in_dark_" + var_218c22c5);
    self clientfield::set("" + #"hash_7e481cd16f021d79", 1);
}

// Namespace namespace_45690bb8/namespace_45690bb8
// Params 2, eflags: 0x1 linked
// Checksum 0xf9d88e42, Offset: 0x41b0
// Size: 0x44
function function_332fa187(var_a276c861, var_19e802fa) {
    if (var_a276c861 || var_19e802fa) {
        level flag::set(#"hash_7e1e35ba97e10de9");
    }
}

// Namespace namespace_45690bb8/namespace_45690bb8
// Params 1, eflags: 0x1 linked
// Checksum 0xc1aed7f2, Offset: 0x4200
// Size: 0x304
function function_2d90874d(*var_a276c861) {
    level endon(#"hash_3c62d3b6b67922c0");
    var_c64cebdb = 0;
    while (!var_c64cebdb) {
        waitresult = level waittill(#"hash_39b0256c6c9885fc");
        var_89e3316b = waitresult.var_c192c739;
        magic_box = var_89e3316b.s_chest;
        magic_box.zbarrier waittill(#"randomization_done");
        weapon = magic_box.zbarrier.weapon;
        /#
            if (!is_true(level.var_b6c03aaa)) {
                break;
            }
        #/
        foreach (player in getplayers()) {
            dist = distance2d(magic_box.origin, player.origin);
            if (dist <= 36) {
                v_angles = player getplayerangles();
                if (util::within_fov(player.origin, v_angles, magic_box.origin, 0.3)) {
                    var_f2535f5c = player getenemiesinradius(player.origin, 256);
                    if (isdefined(var_f2535f5c)) {
                        var_80320e3c = math::cointoss(10);
                        if (var_80320e3c && isdefined(weapon) && weapon != level.weaponnone) {
                            var_c64cebdb = 1;
                            level.var_2f57e2d2 = &function_8a4a003d;
                            magic_box.grab_weapon_hint = 0;
                            magic_box.zbarrier.owner.var_c639ca3e = undefined;
                            magic_box.zbarrier.weapon_model hide();
                            level function_1fcc39f1(player);
                            var_89e3316b function_d12a9c3();
                        }
                    }
                }
            }
        }
    }
}

// Namespace namespace_45690bb8/namespace_45690bb8
// Params 1, eflags: 0x1 linked
// Checksum 0x63645e2e, Offset: 0x4510
// Size: 0xe
function function_8a4a003d(*player) {
    return false;
}

// Namespace namespace_45690bb8/namespace_45690bb8
// Params 1, eflags: 0x1 linked
// Checksum 0x4564aa8f, Offset: 0x4528
// Size: 0x244
function function_1fcc39f1(player) {
    level endon(#"hash_3c62d3b6b67922c0");
    level notify(#"hash_27e412fb2665725e");
    var_6a798feb = player.origin + anglestoforward(player.angles) * 45;
    v_to_player = player.origin - var_6a798feb;
    v_angles = vectortoangles(v_to_player);
    var_b7c784c2 = util::spawn_model("tag_origin", var_6a798feb, v_angles);
    player freezecontrols(1);
    player setstance("stand");
    player val::set(#"hash_740a4b953289badd", "ignoreme", 1);
    player thread function_93a73f43();
    var_b7c784c2 scene::play("p9_fxanim_zm_grab_attack", "bite");
    var_b7c784c2 scene::play("p9_fxanim_zm_grab_attack", "bite");
    player flag::set("grab_done");
    player freezecontrols(0);
    var_b7c784c2 thread scene::play("p9_fxanim_zm_grab_attack", "disappear");
    wait 0.1;
    var_b7c784c2 scene::delete_scene_spawned_ents("p9_fxanim_zm_grab_attack");
    player thread function_dd3f7bec();
}

// Namespace namespace_45690bb8/namespace_45690bb8
// Params 0, eflags: 0x1 linked
// Checksum 0x492fe64e, Offset: 0x4778
// Size: 0xd0
function function_93a73f43() {
    level endon(#"hash_3c62d3b6b67922c0");
    player = self;
    player endon(#"death", #"grab_done");
    while (true) {
        player viewkick(10, player.origin + (randomfloatrange(-25, 25), randomfloatrange(-25, 25), 0));
        wait randomfloatrange(0.5, 0.8);
    }
}

// Namespace namespace_45690bb8/namespace_45690bb8
// Params 0, eflags: 0x1 linked
// Checksum 0x7f2d957e, Offset: 0x4850
// Size: 0x6c
function function_dd3f7bec() {
    level endon(#"hash_3c62d3b6b67922c0");
    player = self;
    player endon(#"death");
    wait 15;
    player val::reset(#"hash_740a4b953289badd", "ignoreme");
}

// Namespace namespace_45690bb8/namespace_45690bb8
// Params 0, eflags: 0x1 linked
// Checksum 0xe425c64a, Offset: 0x48c8
// Size: 0xb4
function function_d12a9c3() {
    self endon(#"death");
    level endon(#"hash_3c62d3b6b67922c0");
    wait 0.3;
    s_chest = self.s_chest;
    s_chest.weapon_out = 1;
    s_chest.var_7672d70d = 1;
    self notify(#"trigger", {#activator:level});
    level.var_2f57e2d2 = undefined;
    level flag::set(#"hash_3c62d3b6b67922c0");
}

// Namespace namespace_45690bb8/namespace_45690bb8
// Params 2, eflags: 0x1 linked
// Checksum 0x6394d24f, Offset: 0x4988
// Size: 0x44
function function_3822111d(var_a276c861, var_19e802fa) {
    if (var_a276c861 || var_19e802fa) {
        level flag::set(#"hash_3c62d3b6b67922c0");
    }
}

/#

    // Namespace namespace_45690bb8/namespace_45690bb8
    // Params 0, eflags: 0x4
    // Checksum 0x8131dbce, Offset: 0x49d8
    // Size: 0x2c
    function private function_4b06b46e() {
        zm_devgui::add_custom_devgui_callback(&function_dfe8c2c1);
    }

    // Namespace namespace_45690bb8/namespace_45690bb8
    // Params 1, eflags: 0x4
    // Checksum 0x633a31f9, Offset: 0x4a10
    // Size: 0x92
    function private function_dfe8c2c1(cmd) {
        switch (cmd) {
        case #"hash_312a5d140fb23817":
            array::thread_all(getplayers(), &function_4bb7eb36);
            level thread function_97d80e41();
            break;
        default:
            break;
        }
    }

    // Namespace namespace_45690bb8/namespace_45690bb8
    // Params 0, eflags: 0x0
    // Checksum 0x822a39c5, Offset: 0x4ab0
    // Size: 0x1c
    function function_4bb7eb36() {
        zm_devgui::function_4bb7eb36();
    }

    // Namespace namespace_45690bb8/namespace_45690bb8
    // Params 0, eflags: 0x0
    // Checksum 0xe0e3aaa2, Offset: 0x4ad8
    // Size: 0x160
    function function_97d80e41() {
        level.var_b6c03aaa = 1;
        while (true) {
            waitresult = level waittill(#"hash_39b0256c6c9885fc");
            var_89e3316b = waitresult.var_c192c739;
            magic_box = var_89e3316b.s_chest;
            magic_box.zbarrier waittill(#"randomization_done");
            level.chest_accessed = 0;
            weapon = magic_box.zbarrier.weapon;
            level.var_2f57e2d2 = &function_8a4a003d;
            magic_box.grab_weapon_hint = 0;
            magic_box.zbarrier.owner.var_c639ca3e = undefined;
            magic_box.zbarrier.weapon_model hide();
            player = util::gethostplayer();
            level function_1fcc39f1(player);
            var_89e3316b function_d12a9c3();
        }
    }

#/
