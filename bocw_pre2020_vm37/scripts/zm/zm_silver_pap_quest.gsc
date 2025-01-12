#using script_432a18be09b697bd;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\exploder_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;
#using scripts\zm\zm_silver;
#using scripts\zm_common\zm_devgui;
#using scripts\zm_common\zm_fasttravel;
#using scripts\zm_common\zm_sq;
#using scripts\zm_common\zm_unitrigger;
#using scripts\zm_common\zm_zonemgr;

#namespace zm_silver_pap_quest;

// Namespace zm_silver_pap_quest/zm_silver_pap_quest
// Params 0, eflags: 0x1 linked
// Checksum 0xebdb6493, Offset: 0xa70
// Size: 0x414
function init() {
    /#
        execdevgui("<dev string:x38>");
        level thread function_1579f31();
    #/
    clientfield::register("toplayer", "" + #"hash_5cf186464ce9cdd6", 1, 1, "int");
    clientfield::register("toplayer", "" + #"hash_1fa45e1c3652d753", 1, 1, "int");
    clientfield::register("toplayer", "" + #"hash_63af42145e260fb5", 1, 2, "int");
    clientfield::register("scriptmover", "" + #"hash_6cfa6a77c2e81774", 1, 1, "int");
    clientfield::register("scriptmover", "" + #"hash_7ec80a02e9bb051a", 1, 1, "int");
    clientfield::register("scriptmover", "" + #"hash_5a293ad1c677dc7e", 1, 1, "int");
    clientfield::register("scriptmover", "" + #"hash_7919b736a767a0f5", 1, 1, "int");
    clientfield::register("scriptmover", "" + #"hash_54d221181b1a11f", 1, 1, "int");
    level.var_14947a3a = ["zone_proto_upstairs", "zone_proto_interior_cave", "zone_proto_interior_lower", "zone_proto_upstairs_2", "zone_tunnel_interior", "zone_power_room", "zone_power_trans_north", "zone_power_trans_south", "zone_trans_north", "zone_trans_south", "zone_center_upper_west", "zone_center_upper_north", "zone_center_upper", "zone_center_lower", "zone_power_tunnel"];
    function_e21028db("init");
    level thread pap_quest_init();
    callback::on_spawned(&on_player_spawned);
    var_7692d390 = getentarray("script_plane_collision", "targetname");
    array::run_all(var_7692d390, &disconnectpaths);
    truckcollision = getent("script_truck_collision", "targetname");
    truckcollision disconnectpaths();
}

// Namespace zm_silver_pap_quest/zm_silver_pap_quest
// Params 0, eflags: 0x1 linked
// Checksum 0x9abe627e, Offset: 0xe90
// Size: 0x6c
function on_player_spawned() {
    if (!level flag::get(#"dark_aether_active")) {
        self clientfield::set_to_player("" + #"hash_5cf186464ce9cdd6", 0);
    }
    self thread function_23c31b4e();
}

// Namespace zm_silver_pap_quest/zm_silver_pap_quest
// Params 0, eflags: 0x1 linked
// Checksum 0xd6e81383, Offset: 0xf08
// Size: 0x19e
function function_23c31b4e() {
    self endon(#"death");
    while (true) {
        if (!level flag::get("power_on")) {
            if (level flag::get(#"dark_aether_active")) {
                self clientfield::set_to_player("" + #"hash_63af42145e260fb5", 2);
            } else if (self zm_zonemgr::is_player_in_zone(level.var_14947a3a)) {
                self clientfield::set_to_player("" + #"hash_63af42145e260fb5", 1);
            } else {
                self clientfield::set_to_player("" + #"hash_63af42145e260fb5", 0);
            }
        } else if (level flag::get(#"dark_aether_active")) {
            self clientfield::set_to_player("" + #"hash_63af42145e260fb5", 2);
        } else {
            self clientfield::set_to_player("" + #"hash_63af42145e260fb5", 0);
        }
        waitframe(1);
    }
}

// Namespace zm_silver_pap_quest/zm_silver_pap_quest
// Params 0, eflags: 0x1 linked
// Checksum 0xe55783d0, Offset: 0x10b0
// Size: 0xa4
function pap_quest_init() {
    level endon(#"end_game");
    level.var_ce45839f = #"pap_quest_completed";
    level flag::wait_till("all_players_spawned");
    function_ce84849b();
    level.var_7bfbe1fc = getent("pap_machine_clip", "script_noteworthy");
    level.var_7bfbe1fc notsolid();
}

// Namespace zm_silver_pap_quest/zm_silver_pap_quest
// Params 0, eflags: 0x1 linked
// Checksum 0x696b4d54, Offset: 0x1160
// Size: 0x684
function function_af722d1c() {
    level flag::wait_till("start_zombie_round_logic");
    wait 2;
    var_77a62dfb = struct::get("pap_tunnel_door_location", "targetname");
    zm_sq::function_266d66eb(#"hash_502a7a67764fd94e", var_77a62dfb.origin, undefined, #"hash_6edeea551fa2827c");
    var_77a62dfb waittill(#"open_tunnel_door");
    zm_sq::objective_complete(#"hash_502a7a67764fd94e");
    wait 5;
    var_7b6eae07 = getent("elec_switch", "script_noteworthy");
    zm_sq::function_266d66eb(#"hash_502a7967764fd79b", var_7b6eae07, undefined, #"hash_77e138106f2c72b7");
    level flag::wait_till("power_on");
    zm_sq::objective_complete(#"hash_502a7967764fd79b", var_7b6eae07);
    wait 4;
    zm_sq::function_266d66eb(#"hash_502a7867764fd5e8", level.var_f2484ed9, undefined, #"hash_2f6ada38af7b4a6a");
    level flag::wait_till(#"dark_aether_active");
    zm_sq::function_3029d343(#"hash_502a7867764fd5e8", level.var_f2484ed9);
    if (!isdefined(level.var_f070b39a)) {
        level waittill(#"hash_61531cd15f11f543");
    }
    var_4bcd7eea = struct::get(level.var_f070b39a.var_3ae542cd, "script_string");
    zm_sq::function_266d66eb(#"hash_502a7f67764fe1cd", var_4bcd7eea, undefined, #"hash_570634faa6508f0d");
    while (!level flag::get(#"piece_is_found")) {
        s_waitresult = level waittill(#"piece_is_found", #"dark_aether_active", level.var_f070b39a.var_254001bd);
        switch (s_waitresult._notify) {
        case #"piece_is_found":
            zm_sq::objective_complete(#"hash_502a7f67764fe1cd", level.var_f070b39a);
            break;
        case #"dark_aether_active":
            if (level flag::get(#"dark_aether_active")) {
                zm_sq::function_aee0b4b4(#"hash_502a7f67764fe1cd", var_4bcd7eea);
                zm_sq::function_aee0b4b4(#"hash_502a7f67764fe1cd", level.var_f070b39a);
                zm_sq::function_3029d343(#"hash_502a7867764fd5e8");
            } else {
                zm_sq::function_3029d343(#"hash_502a7f67764fe1cd", var_4bcd7eea);
                zm_sq::function_aee0b4b4(#"hash_502a7f67764fe1cd", level.var_f070b39a);
                zm_sq::function_aee0b4b4(#"hash_502a7867764fd5e8");
            }
            break;
        default:
            zm_sq::objective_complete(#"hash_502a7f67764fe1cd", var_4bcd7eea);
            zm_sq::function_266d66eb(#"hash_502a7f67764fe1cd", level.var_f070b39a, undefined, #"hash_570634faa6508f0d");
            break;
        }
    }
    wait 1;
    zm_sq::function_266d66eb(#"hash_502a7e67764fe01a", level.var_241be029, undefined, #"hash_74ad706cf06d3af0");
    while (!level flag::get(#"pap_quest_completed")) {
        s_waitresult = level waittill(#"pap_quest_completed", #"dark_aether_active");
        if (s_waitresult._notify == #"dark_aether_active") {
            if (level flag::get(#"dark_aether_active")) {
                zm_sq::function_aee0b4b4(#"hash_502a7e67764fe01a", level.var_241be029);
                zm_sq::function_3029d343(#"hash_502a7867764fd5e8");
                continue;
            }
            zm_sq::function_3029d343(#"hash_502a7e67764fe01a", level.var_241be029);
            zm_sq::function_aee0b4b4(#"hash_502a7867764fd5e8");
        }
    }
    zm_sq::objective_complete(#"hash_502a7867764fd5e8");
    zm_sq::objective_complete(#"hash_502a7e67764fe01a", level.var_241be029);
}

// Namespace zm_silver_pap_quest/zm_silver_pap_quest
// Params 0, eflags: 0x1 linked
// Checksum 0x1ef58c60, Offset: 0x17f0
// Size: 0x7c
function function_ce84849b() {
    level thread function_af722d1c();
    level thread function_da48420c();
    level thread function_cd3e7a69();
    level thread function_3c6501c9();
    level thread function_6c1800f0();
}

// Namespace zm_silver_pap_quest/zm_silver_pap_quest
// Params 0, eflags: 0x1 linked
// Checksum 0xb3115512, Offset: 0x1878
// Size: 0x230
function function_cd3e7a69() {
    var_77a62dfb = struct::get("pap_tunnel_door_location");
    while (!var_77a62dfb flag::get("open_tunnel_door")) {
        foreach (player in getplayers()) {
            if (distancesquared(var_77a62dfb.origin, player.origin) <= 262144) {
                var_77a62dfb flag::set("open_tunnel_door");
            }
        }
        wait 1;
    }
    var_1c023374 = getentarray(var_77a62dfb.target, "targetname");
    foreach (door in var_1c023374) {
        if (isdefined(door.script_vector)) {
            var_cf64509e = getent(door.target, "targetname");
            var_cf64509e linkto(door);
            door moveto(door.origin + door.script_vector, 5);
        }
    }
}

// Namespace zm_silver_pap_quest/zm_silver_pap_quest
// Params 0, eflags: 0x1 linked
// Checksum 0xcd6d34ec, Offset: 0x1ab0
// Size: 0x42c
function function_da48420c() {
    hidemiscmodels("zm_silver_normal_computers");
    hidemiscmodels("mq_terminal_1_screen_active");
    hidemiscmodels("mq_terminal_2_screen_active");
    hidemiscmodels("mq_terminal_1_screen_inactive");
    hidemiscmodels("mq_terminal_2_screen_inactive");
    exploder::exploder("lgt_env_default");
    exploder::exploder("lgt_env_dark_aether_off_crystal");
    exploder::exploder("lgt_env_dark_aether_off_bio_01");
    exploder::exploder("lgt_env_dark_aether_off_bio_02");
    exploder::exploder("lgt_env_powered_off_room_04");
    exploder::exploder("lgt_env_powered_off_room_05");
    exploder::exploder("lgt_env_powered_off_room_06");
    exploder::exploder("lgt_env_powered_off_room_07");
    exploder::exploder("lgt_env_powered_off_room_08");
    exploder::exploder("lgt_env_powered_off_room_09");
    exploder::exploder("lgt_env_powered_off_room_10");
    level flag::wait_till("power_on");
    array::delete_all(getentarray("power_arrow", "targetname"));
    level.var_b2371398 = getent("mq_researcher_computer", "script_noteworthy");
    level.var_59b6e9a5 = getent("mq_researcher_computer_screen", "targetname");
    level.var_59b6e9a5 setmodel(#"hash_6966be6d33d1985b");
    level.var_6c682532 = util::spawn_model(#"hash_2a7c96f5ca0f16a4", level.var_b2371398.origin, level.var_b2371398.angles);
    showmiscmodels("zm_silver_normal_computers");
    exploder::kill_exploder("lgt_env_default");
    exploder::exploder("lgt_env_powered_fx_on");
    exploder::kill_exploder("lgt_env_powered_off_room_06");
    exploder::exploder("lgt_env_powered_on_room_06");
    exploder::kill_exploder("lgt_env_powered_off_room_09");
    exploder::exploder("lgt_env_powered_on_room_09");
    exploder::kill_exploder("lgt_env_powered_off_room_07");
    exploder::exploder("lgt_env_powered_on_room_07");
    exploder::kill_exploder("lgt_env_powered_off_room_08");
    exploder::exploder("lgt_env_powered_on_room_08");
    exploder::kill_exploder("lgt_env_powered_off_room_10");
    exploder::exploder("lgt_env_powered_on_room_10");
    exploder::kill_exploder("lgt_env_powered_off_room_05");
    exploder::exploder("lgt_env_powered_on_room_05");
    exploder::kill_exploder("lgt_env_powered_off_room_04");
    exploder::exploder("lgt_env_powered_on_room_04");
}

// Namespace zm_silver_pap_quest/zm_silver_pap_quest
// Params 0, eflags: 0x1 linked
// Checksum 0x7ca51c78, Offset: 0x1ee8
// Size: 0x29c
function function_c1bd7e55() {
    self notify("624401be12dd2b9a");
    self endon("624401be12dd2b9a");
    level endon(#"end_game");
    plane = getent("script_plane", "targetname");
    var_7692d390 = getentarray("script_plane_collision", "targetname");
    foreach (collision in var_7692d390) {
        collision connectpaths();
        collision notsolid();
    }
    plane notsolid();
    plane scene::play(#"hash_2f425040d5e62683", "rise", plane);
    plane thread scene::play(#"hash_2f425040d5e62683", "loop", plane);
    level waittill(#"dark_side_timeout", #"hash_61e8a39b3a4bee6a");
    if (!level flag::get(#"hash_268c943ffdd74fa")) {
        foreach (collision in var_7692d390) {
            collision disconnectpaths();
            collision solid();
        }
        plane solid();
        plane scene::play(#"hash_2f425040d5e62683", "drop", plane);
    }
}

// Namespace zm_silver_pap_quest/zm_silver_pap_quest
// Params 0, eflags: 0x1 linked
// Checksum 0x6b85dee8, Offset: 0x2190
// Size: 0x1d4
function function_40102053() {
    self notify("1a758281d54394b5");
    self endon("1a758281d54394b5");
    level endon(#"end_game");
    truck = getent("script_truck", "targetname");
    truckcollision = getent("script_truck_collision", "targetname");
    truckcollision connectpaths();
    truckcollision notsolid();
    truck notsolid();
    truck scene::play(#"hash_3b239490a05b582e", "rise", truck);
    truck thread scene::play(#"hash_3b239490a05b582e", "loop", truck);
    level waittill(#"dark_side_timeout", #"hash_61e8a39b3a4bee6a");
    if (!level flag::get(#"hash_268c943ffdd74fa")) {
        truckcollision disconnectpaths();
        truckcollision solid();
        truck solid();
        truck scene::play(#"hash_3b239490a05b582e", "drop", truck);
    }
}

// Namespace zm_silver_pap_quest/zm_silver_pap_quest
// Params 0, eflags: 0x1 linked
// Checksum 0xad2f493, Offset: 0x2370
// Size: 0x308
function function_3c6501c9() {
    level endon(#"end_game");
    level flag::wait_till("power_on");
    level.var_7f76a0b6 = struct::get("pap_dark_aether_tear", "script_noteworthy");
    level.var_f2484ed9 = util::spawn_model("tag_origin", level.var_7f76a0b6.origin);
    level thread function_2efdaf37();
    level thread function_c95d2c8();
    level thread function_716add58();
    while (!level flag::get("pap_quest_completed")) {
        level.var_f2484ed9 clientfield::set("" + #"hash_7ec80a02e9bb051a", 1);
        level.var_f2484ed9 clientfield::set("" + #"hash_5a293ad1c677dc7e", 1);
        if (!level flag::get(#"hash_447ca5049bb26ab6")) {
            foreach (player in getplayers()) {
                player clientfield::set_to_player("" + #"hash_1fa45e1c3652d753", 1);
            }
        }
        level.var_f2484ed9 zm_unitrigger::function_fac87205(#"hash_622731cfc9a72bfa", 96);
        level notify(#"into_the_dark_side");
        level.var_f2484ed9 clientfield::set("" + #"hash_7ec80a02e9bb051a", 0);
        level flag::set(#"hash_447ca5049bb26ab6");
        level waittill(#"dark_side_timeout", #"pap_quest_completed", #"hash_61e8a39b3a4bee6a");
    }
}

// Namespace zm_silver_pap_quest/zm_silver_pap_quest
// Params 0, eflags: 0x1 linked
// Checksum 0x786c3f8a, Offset: 0x2680
// Size: 0x240
function function_2efdaf37() {
    level flag::wait_till(#"dark_aether_active");
    var_d858bf07 = struct::get_array("jelly_fish", "script_noteworthy");
    foreach (node in var_d858bf07) {
        switch (node.script_string) {
        case #"small":
            var_d46652ea = util::spawn_model(#"hash_2093e55b5e21d3e3", node.origin, undefined, undefined, 1);
            var_d46652ea setscale(0.2);
            var_d46652ea thread function_b310c85e(node);
            break;
        case #"med":
            var_d46652ea = util::spawn_model(#"hash_2093e55b5e21d3e3", node.origin, undefined, undefined, 1);
            var_d46652ea setscale(0.6);
            break;
        case #"large":
            var_d46652ea = util::spawn_model(#"hash_2093e55b5e21d3e3", node.origin, undefined, undefined, 1);
            var_d46652ea setscale(1.8);
            break;
        }
        var_d46652ea thread function_e42aed4c();
    }
}

// Namespace zm_silver_pap_quest/zm_silver_pap_quest
// Params 1, eflags: 0x1 linked
// Checksum 0xfbbd5155, Offset: 0x28c8
// Size: 0xcc
function function_b310c85e(node) {
    self notify(#"hash_4880884cb92fc8ed");
    self endon(#"hash_4880884cb92fc8ed");
    self endon(#"death");
    nd_next = struct::get(node.target, "targetname");
    self moveto(nd_next.origin, 10, 1, 1);
    self waittill(#"movedone");
    self thread function_b310c85e(nd_next);
}

// Namespace zm_silver_pap_quest/zm_silver_pap_quest
// Params 0, eflags: 0x1 linked
// Checksum 0x4abaaf08, Offset: 0x29a0
// Size: 0xb0
function function_e42aed4c() {
    level endon(#"end_game");
    self endon(#"death");
    while (true) {
        level flag::wait_till_clear(#"dark_aether_active");
        self hide();
        level flag::wait_till(#"dark_aether_active");
        self show();
    }
}

// Namespace zm_silver_pap_quest/zm_silver_pap_quest
// Params 0, eflags: 0x1 linked
// Checksum 0xeee12c1d, Offset: 0x2a58
// Size: 0x640
function function_c95d2c8() {
    level flag::wait_till(#"dark_aether_active");
    level.var_5a7fab04 = util::spawn_model(#"hash_60ff3af8550fd7fb", struct::get("pap_ghost_machine_loc", "script_noteworthy").origin, struct::get("pap_ghost_machine_loc", "script_noteworthy").angles);
    level.var_7bfbe1fc solid();
    wait 5;
    level.var_5a7fab04 clientfield::set("" + #"hash_54d221181b1a11f", 1);
    level.var_5a7fab04 scene::play(#"hash_1154016a5d6867c2", level.var_5a7fab04);
    level.var_7bfbe1fc notsolid();
    level.var_28c2a122 = util::spawn_model(#"hash_283c06f4e464e3ef", level.var_5a7fab04 gettagorigin("tag_top"), level.var_5a7fab04 gettagangles("tag_top"));
    level.var_6cddddd9 = util::spawn_model(#"hash_137dd49721288cba", level.var_5a7fab04 gettagorigin("tag_mid"), level.var_5a7fab04 gettagangles("tag_mid"));
    level.var_b5f520cf = util::spawn_model(#"hash_33548980bf322815", level.var_5a7fab04 gettagorigin("tag_btm"), level.var_5a7fab04 gettagangles("tag_btm"));
    level.var_5a7fab04 hide();
    wait 1;
    if (zm_zonemgr::zone_is_enabled("zone_trans_north") && zm_zonemgr::zone_is_enabled("zone_trans_south")) {
        if (math::cointoss()) {
            level.var_6cddddd9.origin = struct::get("piece_midway_mid", "script_noteworthy").origin;
            level.var_6cddddd9.angles = struct::get("piece_midway_mid", "script_noteworthy").angles;
            level.var_f070b39a = level.var_6cddddd9;
            level.var_f070b39a.var_3ae542cd = "fasttravel_loc_pond_down";
            level.var_f070b39a.var_254001bd = #"hash_426979dda15dd76f";
        } else {
            level.var_b5f520cf.origin = struct::get("piece_midway_btm", "script_noteworthy").origin;
            level.var_b5f520cf.angles = struct::get("piece_midway_btm", "script_noteworthy").angles;
            level.var_f070b39a = level.var_b5f520cf;
            level.var_f070b39a.var_3ae542cd = "fasttravel_loc_crash_site_down";
            level.var_f070b39a.var_254001bd = #"hash_5674ed1aa008ba97";
        }
    } else if (zm_zonemgr::zone_is_enabled("zone_trans_north")) {
        level.var_6cddddd9.origin = struct::get("piece_midway_mid", "script_noteworthy").origin;
        level.var_6cddddd9.angles = struct::get("piece_midway_mid", "script_noteworthy").angles;
        level.var_f070b39a = level.var_6cddddd9;
        level.var_f070b39a.var_3ae542cd = "fasttravel_loc_pond_down";
        level.var_f070b39a.var_254001bd = #"hash_426979dda15dd76f";
    } else {
        level.var_b5f520cf.origin = struct::get("piece_midway_btm", "script_noteworthy").origin;
        level.var_b5f520cf.angles = struct::get("piece_midway_btm", "script_noteworthy").angles;
        level.var_f070b39a = level.var_b5f520cf;
        level.var_f070b39a.var_3ae542cd = "fasttravel_loc_crash_site_down";
        level.var_f070b39a.var_254001bd = #"hash_5674ed1aa008ba97";
    }
    level.var_f070b39a thread function_530c2230();
    level.var_28c2a122 thread function_931d1962();
    level.var_6cddddd9 thread function_931d1962();
    level.var_b5f520cf thread function_931d1962();
    level notify(#"hash_61531cd15f11f543");
}

// Namespace zm_silver_pap_quest/zm_silver_pap_quest
// Params 0, eflags: 0x1 linked
// Checksum 0x1fdc71d, Offset: 0x30a0
// Size: 0x154
function function_530c2230() {
    self playloopsound(#"hash_224c4ffb3e869259");
    self zm_unitrigger::function_fac87205(&function_557b8c82, (128, 128, 128));
    self playsound(#"hash_7d9f66386174bd52");
    self stoploopsound();
    if (self === level.var_6cddddd9) {
        self.origin = level.var_5a7fab04 gettagorigin("tag_mid");
        self.angles = level.var_5a7fab04 gettagangles("tag_mid");
    } else {
        self.origin = level.var_5a7fab04 gettagorigin("tag_btm");
        self.angles = level.var_5a7fab04 gettagangles("tag_btm");
    }
    level flag::set("piece_is_found");
}

// Namespace zm_silver_pap_quest/zm_silver_pap_quest
// Params 1, eflags: 0x1 linked
// Checksum 0x9bc1c39a, Offset: 0x3200
// Size: 0x54
function function_557b8c82(*e_player) {
    if (level flag::get(#"dark_aether_active")) {
        self sethintstring(#"hash_53a4565555d8b22c");
        return true;
    }
    return false;
}

// Namespace zm_silver_pap_quest/zm_silver_pap_quest
// Params 0, eflags: 0x1 linked
// Checksum 0xc2a29d7a, Offset: 0x3260
// Size: 0xb0
function function_931d1962() {
    level endon(#"end_game");
    self endon(#"death");
    while (true) {
        level flag::wait_till_clear(#"dark_aether_active");
        self hide();
        level flag::wait_till(#"dark_aether_active");
        self show();
    }
}

// Namespace zm_silver_pap_quest/zm_silver_pap_quest
// Params 1, eflags: 0x1 linked
// Checksum 0x26afc0ef, Offset: 0x3318
// Size: 0x2cc
function function_238564ee(nodes) {
    if (nodes.size > 2) {
        var_f938d563 = array::random(nodes);
        var_d2bace38 = function_5b45a5eb(var_f938d563);
        if (!isdefined(level.var_de52201d)) {
            level.var_de52201d = [];
        } else if (!isarray(level.var_de52201d)) {
            level.var_de52201d = array(level.var_de52201d);
        }
        level.var_de52201d[level.var_de52201d.size] = var_d2bace38;
        while (true) {
            var_ad3f899 = array::random(nodes);
            if (var_f938d563 != var_ad3f899) {
                break;
            }
        }
        var_ec6c01a6 = function_5b45a5eb(var_ad3f899);
        if (!isdefined(level.var_de52201d)) {
            level.var_de52201d = [];
        } else if (!isarray(level.var_de52201d)) {
            level.var_de52201d = array(level.var_de52201d);
        }
        level.var_de52201d[level.var_de52201d.size] = var_ec6c01a6;
    } else {
        foreach (node in nodes) {
            crystal = function_5b45a5eb(node);
            if (!isdefined(level.var_de52201d)) {
                level.var_de52201d = [];
            } else if (!isarray(level.var_de52201d)) {
                level.var_de52201d = array(level.var_de52201d);
            }
            level.var_de52201d[level.var_de52201d.size] = crystal;
        }
    }
    arrayremovevalue(level.var_de52201d, undefined);
}

// Namespace zm_silver_pap_quest/zm_silver_pap_quest
// Params 0, eflags: 0x1 linked
// Checksum 0x8b81998a, Offset: 0x35f0
// Size: 0xf4
function function_48d84a49() {
    self endon(#"death");
    self setcandamage(1);
    self waittill(#"damage");
    self clientfield::set("" + #"hash_7919b736a767a0f5", 0);
    if (self.model == #"hash_608da839b1edf856") {
        self setmodel(#"hash_3c3c40375febff35");
        return;
    }
    if (self.model == #"hash_608da739b1edf6a3") {
        self setmodel(#"hash_50aa2075dbc5e6e0");
    }
}

// Namespace zm_silver_pap_quest/zm_silver_pap_quest
// Params 1, eflags: 0x1 linked
// Checksum 0xc87081ad, Offset: 0x36f0
// Size: 0xe0
function function_5b45a5eb(node) {
    if (math::cointoss()) {
        crystal = util::spawn_model(#"hash_608da839b1edf856", node.origin, node.angles);
    } else {
        crystal = util::spawn_model(#"hash_608da739b1edf6a3", node.origin, node.angles);
    }
    crystal.modelscale = node.modelscale;
    crystal clientfield::set("" + #"hash_7919b736a767a0f5", 1);
    return crystal;
}

// Namespace zm_silver_pap_quest/zm_silver_pap_quest
// Params 1, eflags: 0x1 linked
// Checksum 0x6ec508e4, Offset: 0x37d8
// Size: 0x4d4
function function_e21028db(state) {
    if (state == "init") {
        level.var_6db07af2 = struct::get_array("dark_aether_crystal_medium_yard", "targetname");
        level.var_f1f8d667 = struct::get_array("dark_aether_crystal_medium_pond", "targetname");
        level.var_2040cc70 = struct::get_array("dark_aether_crystal_medium_crash ", "targetname");
        array::run_all(getentarray("aether_corpse", "targetname"), &hide);
        level.var_de52201d = [];
        hidemiscmodels("dark_aether_crystal");
        hidemiscmodels("pond_crystal");
        array::run_all(getentarray("pond_crystal_clip", "targetname"), &notsolid);
        array::run_all(getentarray("pond_crystal_clip", "targetname"), &connectpaths);
        return;
    }
    if (state == "on") {
        function_238564ee(level.var_6db07af2);
        function_238564ee(level.var_f1f8d667);
        function_238564ee(level.var_2040cc70);
        foreach (crystal in level.var_de52201d) {
            crystal thread function_48d84a49();
        }
        hidemiscmodels("pond_rock");
        showmiscmodels("dark_aether_crystal");
        showmiscmodels("pond_crystal");
        array::run_all(getentarray("pond_crystal_clip", "targetname"), &solid);
        array::run_all(getentarray("pond_crystal_clip", "targetname"), &disconnectpaths);
        return;
    }
    if (state == "off") {
        foreach (crystal in level.var_de52201d) {
            arrayremovevalue(level.var_de52201d, crystal);
            crystal clientfield::set("" + #"hash_7919b736a767a0f5", 0);
            if (isdefined(crystal)) {
                crystal delete();
            }
        }
        arrayremovevalue(level.var_de52201d, undefined);
        hidemiscmodels("dark_aether_crystal");
        hidemiscmodels("pond_crystal");
        array::run_all(getentarray("pond_crystal_clip", "targetname"), &hide);
        showmiscmodels("pond_rock");
    }
}

// Namespace zm_silver_pap_quest/zm_silver_pap_quest
// Params 2, eflags: 0x1 linked
// Checksum 0x37e85e43, Offset: 0x3cb8
// Size: 0x9e4
function function_5ea16763(state, var_cbc8cfb4) {
    all_players = getplayers();
    if (state == "on") {
        level clientfield::set("newtonian_negation", 1);
        level thread function_b006234c();
        function_e21028db("on");
        level util::set_lighting_state(1);
        if (isdefined(var_cbc8cfb4)) {
            var_4eed9ccb = struct::get_array(var_cbc8cfb4.target, "targetname");
            foreach (player in all_players) {
                n_index = zm_fasttravel::get_player_index(player);
                var_10fb1677 = var_4eed9ccb[n_index];
                if (isalive(player)) {
                    player thread zm_fasttravel::function_66d020b0(undefined, undefined, undefined, undefined, var_10fb1677, undefined, undefined, 1, 0);
                }
            }
        } else {
            foreach (player in all_players) {
                var_33b97794 = spawn("script_origin", player.origin);
                var_33b97794.angles = player.angles;
                if (isalive(player)) {
                    player thread zm_fasttravel::function_66d020b0(undefined, undefined, undefined, undefined, var_33b97794, undefined, undefined, 1, 0);
                }
            }
        }
        exploder::kill_exploder("lgt_central_ring_powered_on");
        exploder::exploder("lgt_central_ring_dark_aether");
        exploder::exploder("lgt_env_dark_aether");
        exploder::exploder("lgt_env_dark_aether_on_crystal");
        exploder::exploder("lgt_env_dark_aether_on_bio_01");
        exploder::exploder("lgt_env_dark_aether_on_bio_02");
        exploder::kill_exploder("lgt_env_powered_fx_on");
        exploder::kill_exploder("lgt_env_powered_on_room_06");
        exploder::kill_exploder("lgt_env_powered_on_room_09");
        exploder::kill_exploder("lgt_env_powered_on_room_07");
        exploder::kill_exploder("lgt_env_powered_on_room_08");
        exploder::kill_exploder("lgt_env_powered_on_room_10");
        exploder::kill_exploder("lgt_env_powered_on_room_05");
        exploder::kill_exploder("lgt_env_powered_on_room_04");
        level flag::set(#"dark_aether_active");
        level.var_ba3a0e1f = 120;
        while (level.var_ba3a0e1f > 0) {
            wait 1;
            level.var_ba3a0e1f -= 1;
        }
        level notify(#"dark_side_timeout");
        return;
    }
    array::run_all(getentarray("aether_corpse", "targetname"), &hide);
    array::run_all(getentarray("aether_corpse", "targetname"), &stoploopsound);
    level clientfield::set("newtonian_negation", 0);
    function_e21028db("off");
    if (isdefined(var_cbc8cfb4)) {
        var_4eed9ccb = struct::get_array(var_cbc8cfb4.target, "targetname");
        foreach (player in all_players) {
            n_index = zm_fasttravel::get_player_index(player);
            var_10fb1677 = var_4eed9ccb[n_index];
            if (isalive(player)) {
                player thread zm_fasttravel::function_66d020b0(undefined, undefined, undefined, undefined, var_10fb1677, undefined, undefined, 1, 0);
            }
        }
    } else {
        foreach (player in all_players) {
            var_33b97794 = spawn("script_origin", player.origin);
            var_33b97794.angles = player.angles;
            if (isalive(player)) {
                if (istouching(var_33b97794.origin, level.var_7bfbe1fc)) {
                    n_index = zm_fasttravel::get_player_index(player);
                    var_33b97794 = struct::get_array(level.var_7f76a0b6.target)[n_index];
                }
                player thread zm_fasttravel::function_66d020b0(undefined, undefined, undefined, undefined, var_33b97794, undefined, undefined, 1, 0);
            }
        }
    }
    level util::set_lighting_state(0);
    exploder::kill_exploder("lgt_central_ring_dark_aether");
    exploder::kill_exploder("lgt_env_dark_aether");
    exploder::kill_exploder("lgt_env_dark_aether_on_crystal");
    exploder::kill_exploder("lgt_env_dark_aether_on_bio_01");
    exploder::kill_exploder("lgt_env_dark_aether_on_bio_02");
    if (level flag::get_all(["terminal_1_is_on", "terminal_2_is_on"])) {
        exploder::exploder("lgt_central_ring_powered_on");
    }
    exploder::exploder("lgt_env_dark_aether_off_crystal");
    exploder::exploder("lgt_env_dark_aether_off_bio_01");
    exploder::exploder("lgt_env_dark_aether_off_bio_02");
    exploder::exploder("lgt_env_powered_fx_on");
    exploder::exploder("lgt_env_powered_on_room_06");
    exploder::exploder("lgt_env_powered_on_room_09");
    exploder::exploder("lgt_env_powered_on_room_07");
    exploder::exploder("lgt_env_powered_on_room_08");
    if (!level flag::get(#"hash_94bda7ad49639f5")) {
        exploder::kill_exploder("lgt_env_powered_off_room_10");
        exploder::exploder("lgt_env_powered_on_room_10");
    }
    exploder::kill_exploder("lgt_env_powered_off_room_05");
    exploder::exploder("lgt_env_powered_on_room_05");
    exploder::kill_exploder("lgt_env_powered_off_room_04");
    exploder::exploder("lgt_env_powered_on_room_04");
    level flag::clear(#"dark_aether_active");
}

// Namespace zm_silver_pap_quest/zm_silver_pap_quest
// Params 0, eflags: 0x1 linked
// Checksum 0x5dcf075d, Offset: 0x46a8
// Size: 0x31c
function function_716add58() {
    level endon(#"end_game");
    while (true) {
        waitresult = level waittill(#"into_the_dark_side");
        if (!level flag::get(#"hash_268c943ffdd74fa")) {
            level thread function_c1bd7e55();
            level thread function_40102053();
        }
        level thread function_b1b484d();
        var_5e93c025 = struct::get_array("placement_monkey", "targetname");
        array::thread_all(var_5e93c025, &function_647c7f);
        foreach (player in getplayers()) {
            player clientfield::set_to_player("" + #"hash_5cf186464ce9cdd6", 1);
        }
        wait 7;
        level thread function_5ea16763("on", waitresult.var_cbc8cfb4);
        waitresult = level waittill(#"dark_side_timeout", #"pap_quest_completed", #"hash_61e8a39b3a4bee6a");
        if (waitresult._notify != "dark_side_timeout") {
            level.var_ba3a0e1f = 0;
        }
        foreach (player in getplayers()) {
            player clientfield::set_to_player("" + #"hash_5cf186464ce9cdd6", 0);
        }
        wait 7;
        level thread function_5ea16763("off", waitresult.var_cbc8cfb4);
        level notify(#"hash_40cd2e6f2c496d75");
    }
}

// Namespace zm_silver_pap_quest/zm_silver_pap_quest
// Params 0, eflags: 0x1 linked
// Checksum 0x8c31c780, Offset: 0x49d0
// Size: 0x18c
function function_647c7f() {
    var_b6a08ca5 = randomint(3);
    var_bdd70f6a = util::spawn_model("c_t8_cottontop_monkey_fb1", self.origin, self.angles);
    switch (var_b6a08ca5) {
    case 0:
        var_bdd70f6a thread scene::play(#"p9_fxanim_zm_monkey_idle_bundle", "idle_01", var_bdd70f6a);
        break;
    case 1:
        var_bdd70f6a thread scene::play(#"p9_fxanim_zm_monkey_idle_bundle", "idle_02", var_bdd70f6a);
        break;
    case 2:
        var_bdd70f6a thread scene::play(#"p9_fxanim_zm_monkey_idle_bundle", "idle_03", var_bdd70f6a);
        break;
    default:
        break;
    }
    level waittill(#"dark_side_timeout", #"pap_quest_completed", #"hash_61e8a39b3a4bee6a");
    var_bdd70f6a delete();
}

// Namespace zm_silver_pap_quest/zm_silver_pap_quest
// Params 0, eflags: 0x1 linked
// Checksum 0xb4dc7cb2, Offset: 0x4b68
// Size: 0x21c
function function_6c1800f0() {
    level endon(#"end_game", #"pap_quest_completed");
    level waittill(#"piece_is_found");
    level.var_241be029 = util::spawn_model("tag_origin", struct::get("pap_ghost_machine_loc", "script_noteworthy").origin);
    level.var_241be029 playloopsound(#"hash_4d743fb901081e97");
    level.var_241be029 zm_unitrigger::function_fac87205(&function_2ad61161, (64, 64, 64));
    level.var_241be029 stoploopsound();
    level.var_28c2a122 delete();
    level.var_6cddddd9 delete();
    level.var_b5f520cf delete();
    level.var_5a7fab04 show();
    level.var_5a7fab04 scene::play(#"hash_6f09914beb313c", level.var_5a7fab04);
    level.var_7bfbe1fc solid();
    level.var_5a7fab04 delete();
    level.var_241be029 playsound(#"hash_7a3209563667ad5e");
    level.var_34cbb2a4 = level.round_number;
    level flag::set("pap_quest_completed");
}

// Namespace zm_silver_pap_quest/zm_silver_pap_quest
// Params 1, eflags: 0x1 linked
// Checksum 0x4c4c3571, Offset: 0x4d90
// Size: 0x54
function function_2ad61161(*e_player) {
    if (level flag::get(#"dark_aether_active")) {
        self sethintstring(#"hash_22453a3bdc9b43d8");
        return true;
    }
    return false;
}

// Namespace zm_silver_pap_quest/zm_silver_pap_quest
// Params 0, eflags: 0x1 linked
// Checksum 0x8ce946ea, Offset: 0x4df0
// Size: 0x1b8
function function_b006234c() {
    a_corpses = getentarray("aether_corpse", "targetname");
    foreach (corpse in a_corpses) {
        corpse show();
        corpse playloopsound(#"hash_1eca9d5afa3a47d8");
        corpse bobbing((0, 0, 1), randomfloatrange(2, 10), randomfloatrange(5, 7));
        if (math::cointoss()) {
            corpse rotate((randomintrange(20 * -1, 20), randomintrange(20 * -1, 20), randomintrange(20 * -1, 20)));
        }
    }
}

// Namespace zm_silver_pap_quest/zm_silver_pap_quest
// Params 0, eflags: 0x1 linked
// Checksum 0x89270d9f, Offset: 0x4fb0
// Size: 0x220
function function_b1b484d() {
    level endon(#"hash_40cd2e6f2c496d75");
    self endon(#"disconnect");
    var_f3b29ae8 = 0;
    while (true) {
        wait randomfloatrange(3, 20);
        for (i = 0; i < 2; i++) {
            self.var_3643da89 = 1;
            level util::set_lighting_state(2);
            var_cd6bd640 = randomintrange(1, 6);
            if (var_cd6bd640 === var_f3b29ae8) {
                var_cd6bd640 = math::clamp(var_cd6bd640 + 1, 1, 6);
            }
            var_f3b29ae8 = var_cd6bd640;
            exploder::exploder("fxexp_script_lightning_0" + var_cd6bd640);
            level thread function_2d4f5b73();
            if (i == 0) {
                wait randomfloatrange(0.3, 0.5);
            } else {
                wait randomfloatrange(0.1, 0.3);
            }
            if (is_true(self.var_3643da89)) {
                level util::set_lighting_state(1);
            }
            exploder::stop_exploder("fxexp_script_lightning_0" + var_cd6bd640);
            if (i == 0) {
                wait randomfloatrange(0.2, 0.4);
            }
        }
    }
}

// Namespace zm_silver_pap_quest/zm_silver_pap_quest
// Params 0, eflags: 0x1 linked
// Checksum 0x732bbcc2, Offset: 0x51d8
// Size: 0x78
function function_2d4f5b73() {
    if (!isdefined(level.var_4b695095)) {
        level.var_4b695095 = 0;
    }
    if (!level.var_4b695095) {
        level.var_4b695095 = 1;
        playsoundatposition("amb_thunder_strike_script", (6559, 17376, 3893));
        wait 3;
        level.var_4b695095 = 0;
    }
}

/#

    // Namespace zm_silver_pap_quest/zm_silver_pap_quest
    // Params 0, eflags: 0x4
    // Checksum 0x7cfcb812, Offset: 0x5258
    // Size: 0xa4
    function private function_1579f31() {
        level flag::wait_till("<dev string:x5c>");
        zm_devgui::add_custom_devgui_callback(&function_bde52114);
        level waittill(#"open_sesame");
        var_77a62dfb = struct::get("<dev string:x78>", "<dev string:x94>");
        var_77a62dfb flag::set("<dev string:xa2>");
    }

    // Namespace zm_silver_pap_quest/zm_silver_pap_quest
    // Params 1, eflags: 0x4
    // Checksum 0x7e4dca8a, Offset: 0x5308
    // Size: 0x262
    function private function_bde52114(cmd) {
        switch (cmd) {
        case #"hash_1e2814b98de6d98d":
            if (isdefined(level.var_f2484ed9)) {
                level.var_f2484ed9 notify(#"trigger_activated");
            }
            if (level flag::get("<dev string:xb6>")) {
                level notify(#"into_the_dark_side");
            }
            break;
        case #"hash_2bceb571f82616ef":
            if (isdefined(level.var_f070b39a)) {
                level.var_f070b39a notify(#"trigger_activated");
            }
            break;
        case #"hash_3eaff69edfc6cd75":
            if (level flag::get("<dev string:xb6>") && level flag::get(#"dark_aether_active")) {
                level notify(#"hash_61e8a39b3a4bee6a");
            }
            if (isdefined(level.var_241be029)) {
                level.var_241be029 notify(#"trigger_activated");
            }
            break;
        case #"hash_50d92ca3c6c7c2a8":
            zm_devgui::zombie_devgui_open_sesame();
            wait 5;
            if (isdefined(level.var_f2484ed9)) {
                level.var_f2484ed9 notify(#"trigger_activated");
            }
            if (level flag::get("<dev string:xb6>")) {
                level notify(#"into_the_dark_side");
            }
            wait 5;
            if (isdefined(level.var_f070b39a)) {
                level.var_f070b39a notify(#"trigger_activated");
            }
            wait 5;
            if (isdefined(level.var_241be029)) {
                level.var_241be029 notify(#"trigger_activated");
            }
            break;
        default:
            break;
        }
    }

#/
