#using scripts\core_common\array_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\trigger_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\bb;
#using scripts\zm_common\gametypes\zm_gametype;
#using scripts\zm_common\util;
#using scripts\zm_common\zm_audio;
#using scripts\zm_common\zm_customgame;
#using scripts\zm_common\zm_utility;

#namespace zm_zonemgr;

// Namespace zm_zonemgr/zm_zonemgr
// Params 0, eflags: 0x2
// Checksum 0x11598830, Offset: 0x280
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"zm_zonemgr", &__init__, undefined, undefined);
}

// Namespace zm_zonemgr/zm_zonemgr
// Params 0, eflags: 0x0
// Checksum 0x8ecbaae1, Offset: 0x2c8
// Size: 0xd4
function __init__() {
    println("<dev string:x30>");
    level flag::init("zones_initialized");
    level.zones = [];
    level.zone_flags = [];
    level.zone_paths = [];
    level.var_b4c5832b = [];
    level.zone_nodes = [];
    level.zone_scanning_active = 0;
    level.str_zone_mgr_mode = "occupied_and_adjacent";
    level.create_spawner_list_func = &create_spawner_list;
    level thread function_2bc6b41d();
}

// Namespace zm_zonemgr/zm_zonemgr
// Params 1, eflags: 0x0
// Checksum 0xd13abe41, Offset: 0x3a8
// Size: 0x5a
function zone_is_enabled(zone_name) {
    if (!isdefined(level.zones) || !isdefined(level.zones[zone_name]) || !level.zones[zone_name].is_enabled) {
        return false;
    }
    return true;
}

// Namespace zm_zonemgr/zm_zonemgr
// Params 1, eflags: 0x0
// Checksum 0x87be10cd, Offset: 0x410
// Size: 0x34
function zone_wait_till_enabled(zone_name) {
    if (!zone_is_enabled(zone_name)) {
        level waittill(zone_name);
    }
}

// Namespace zm_zonemgr/zm_zonemgr
// Params 1, eflags: 0x0
// Checksum 0xcf827eaf, Offset: 0x450
// Size: 0xd4
function function_6fd39598(a_str_zone_names) {
    if (!isdefined(a_str_zone_names)) {
        a_str_zone_names = [];
    } else if (!isarray(a_str_zone_names)) {
        a_str_zone_names = array(a_str_zone_names);
    }
    foreach (str_zone_name in a_str_zone_names) {
        if (zone_is_enabled(str_zone_name)) {
            return str_zone_name;
        }
    }
    return level waittill(a_str_zone_names);
}

// Namespace zm_zonemgr/zm_zonemgr
// Params 1, eflags: 0x0
// Checksum 0x895924cb, Offset: 0x530
// Size: 0xb6
function function_739edae3(a_str_zone_names) {
    if (!isdefined(a_str_zone_names)) {
        a_str_zone_names = [];
    } else if (!isarray(a_str_zone_names)) {
        a_str_zone_names = array(a_str_zone_names);
    }
    for (i = 0; i < a_str_zone_names.size; i++) {
        str_zone_name = a_str_zone_names[i];
        if (!zone_is_enabled(str_zone_name)) {
            level waittill(str_zone_name);
            i = -1;
        }
    }
}

// Namespace zm_zonemgr/zm_zonemgr
// Params 0, eflags: 0x0
// Checksum 0xceea3afa, Offset: 0x5f0
// Size: 0x12
function get_player_zone() {
    return zm_utility::get_current_zone();
}

// Namespace zm_zonemgr/zm_zonemgr
// Params 2, eflags: 0x0
// Checksum 0x4ed100c7, Offset: 0x610
// Size: 0xa6
function get_zone_from_position(v_pos, ignore_enabled_check = 0) {
    if (zm_utility::function_be4cf12d()) {
        node = function_e910fb8c(v_pos, level.zone_nodes, 500);
        if (isdefined(node)) {
            if (ignore_enabled_check || zone_is_enabled(node.targetname)) {
                return node.targetname;
            }
        }
    }
    return undefined;
}

// Namespace zm_zonemgr/zm_zonemgr
// Params 2, eflags: 0x0
// Checksum 0xb3fe42d8, Offset: 0x6c0
// Size: 0xa6
function function_40267fe8(v_pos, ignore_enabled_check) {
    zone = undefined;
    keys = getarraykeys(level.zones);
    for (i = 0; i < keys.size; i++) {
        if (function_9dc42ccc(v_pos, keys[i], ignore_enabled_check)) {
            zone = keys[i];
            break;
        }
    }
    return zone;
}

// Namespace zm_zonemgr/zm_zonemgr
// Params 2, eflags: 0x0
// Checksum 0x865d39df, Offset: 0x770
// Size: 0x88
function function_45020920(v_pos, ignore_enabled_check) {
    keys = getarraykeys(level.zones);
    for (i = 0; i < keys.size; i++) {
        if (function_9dc42ccc(v_pos, keys[i], ignore_enabled_check)) {
            return true;
        }
    }
    return false;
}

// Namespace zm_zonemgr/zm_zonemgr
// Params 1, eflags: 0x0
// Checksum 0x8e394b40, Offset: 0x800
// Size: 0x76
function get_zone_magic_boxes(zone_name) {
    if (isdefined(zone_name) && !zone_is_enabled(zone_name)) {
        return undefined;
    }
    zone = level.zones[zone_name];
    assert(isdefined(zone_name));
    return zone.magic_boxes;
}

// Namespace zm_zonemgr/zm_zonemgr
// Params 1, eflags: 0x0
// Checksum 0xbf3b6fc0, Offset: 0x880
// Size: 0x76
function get_zone_zbarriers(zone_name) {
    if (isdefined(zone_name) && !zone_is_enabled(zone_name)) {
        return undefined;
    }
    zone = level.zones[zone_name];
    assert(isdefined(zone_name));
    return zone.zbarriers;
}

// Namespace zm_zonemgr/zm_zonemgr
// Params 2, eflags: 0x0
// Checksum 0x8b83fdfd, Offset: 0x900
// Size: 0x2b4
function get_players_in_zone(zone_name, return_players) {
    wait_zone_flags_updating();
    if (!zone_is_enabled(zone_name)) {
        return 0;
    }
    zone = level.zones[zone_name];
    players_in_zone = [];
    players = getplayers();
    if (zm_utility::function_be4cf12d()) {
        foreach (player in players) {
            node = function_e910fb8c(player.origin, zone.nodes, 500);
            if (isdefined(node)) {
                if (!isdefined(players_in_zone)) {
                    players_in_zone = [];
                } else if (!isarray(players_in_zone)) {
                    players_in_zone = array(players_in_zone);
                }
                if (!isinarray(players_in_zone, player)) {
                    players_in_zone[players_in_zone.size] = player;
                }
            }
        }
    }
    if (zm_utility::function_a70772a9()) {
        for (j = 0; j < players.size; j++) {
            for (i = 0; i < zone.volumes.size; i++) {
                if (players[j] istouching(zone.volumes[i])) {
                    if (!isdefined(players_in_zone)) {
                        players_in_zone = [];
                    } else if (!isarray(players_in_zone)) {
                        players_in_zone = array(players_in_zone);
                    }
                    if (!isinarray(players_in_zone, player)) {
                        players_in_zone[players_in_zone.size] = player;
                    }
                    break;
                }
            }
        }
    }
    if (isdefined(return_players)) {
        return players_in_zone;
    }
    return players_in_zone.size;
}

// Namespace zm_zonemgr/zm_zonemgr
// Params 1, eflags: 0x0
// Checksum 0x48b1c40, Offset: 0xbc0
// Size: 0x26e
function any_player_in_zone(zone_name) {
    pixbeginevent("any_player_in_zone");
    if (!zone_is_enabled(zone_name)) {
        pixendevent();
        return false;
    }
    zone = level.zones[zone_name];
    if (zm_utility::function_be4cf12d()) {
        foreach (player in getplayers()) {
            node = function_e910fb8c(player.origin, zone.nodes, 500);
            if (isdefined(node) && player.sessionstate != "spectator") {
                pixendevent();
                return true;
            }
        }
    }
    if (zm_utility::function_a70772a9()) {
        for (i = 0; i < zone.volumes.size; i++) {
            players = getplayers();
            for (j = 0; j < players.size; j++) {
                if (players[j] istouching(zone.volumes[i]) && !(players[j].sessionstate == "spectator")) {
                    pixendevent();
                    return true;
                }
            }
        }
    }
    pixendevent();
    return false;
}

// Namespace zm_zonemgr/zm_zonemgr
// Params 3, eflags: 0x0
// Checksum 0xd94ae3c0, Offset: 0xe38
// Size: 0x15a
function function_a3b4552b(location, zone_name, ignore_enabled_check = 0) {
    if (!zone_is_enabled(zone_name) && !ignore_enabled_check) {
        return false;
    }
    zone = level.zones[zone_name];
    if (zm_utility::function_be4cf12d()) {
        node = function_e910fb8c(location, zone.nodes, 500);
        if (isdefined(node)) {
            return true;
        }
    }
    if (zm_utility::function_a70772a9()) {
        foreach (e_volume in zone.volumes) {
            if (istouching(location, e_volume)) {
                return true;
            }
        }
    }
    return false;
}

// Namespace zm_zonemgr/zm_zonemgr
// Params 3, eflags: 0x0
// Checksum 0x22fb6dd9, Offset: 0xfa0
// Size: 0xbe
function function_9dc42ccc(location, zone_name, ignore_enabled_check = 0) {
    if (!zone_is_enabled(zone_name) && !ignore_enabled_check) {
        return false;
    }
    zone = level.zones[zone_name];
    if (zm_utility::function_be4cf12d()) {
        node = function_e910fb8c(location, zone.nodes, 500);
        if (isdefined(node)) {
            return true;
        }
    }
    return false;
}

// Namespace zm_zonemgr/zm_zonemgr
// Params 2, eflags: 0x0
// Checksum 0xbd9c8cc1, Offset: 0x1068
// Size: 0x17a
function entity_in_zone(zone_name, ignore_enabled_check = 0) {
    if (isplayer(self) && self.sessionstate == "spectator") {
        return false;
    }
    if (!zone_is_enabled(zone_name) && !ignore_enabled_check) {
        return false;
    }
    zone = level.zones[zone_name];
    if (zm_utility::function_be4cf12d()) {
        node = function_e910fb8c(self.origin, zone.nodes, 500);
        if (isdefined(node)) {
            return true;
        }
    }
    if (zm_utility::function_a70772a9()) {
        foreach (e_volume in zone.volumes) {
            if (self istouching(e_volume)) {
                return true;
            }
        }
    }
    return false;
}

// Namespace zm_zonemgr/zm_zonemgr
// Params 1, eflags: 0x0
// Checksum 0xc53a7359, Offset: 0x11f0
// Size: 0xe2
function entity_in_active_zone(ignore_enabled_check = 0) {
    if (isplayer(self) && self.sessionstate == "spectator") {
        return false;
    }
    foreach (str_adj_zone in level.active_zone_names) {
        b_in_zone = entity_in_zone(str_adj_zone, ignore_enabled_check);
        if (b_in_zone) {
            return true;
        }
    }
    return false;
}

// Namespace zm_zonemgr/zm_zonemgr
// Params 0, eflags: 0x0
// Checksum 0xf53fcb6a, Offset: 0x12e0
// Size: 0x9e
function deactivate_initial_barrier_goals() {
    special_goals = struct::get_array("exterior_goal", "targetname");
    for (i = 0; i < special_goals.size; i++) {
        if (isdefined(special_goals[i].script_noteworthy)) {
            special_goals[i].is_active = 0;
            special_goals[i] triggerenable(0);
        }
    }
}

// Namespace zm_zonemgr/zm_zonemgr
// Params 2, eflags: 0x0
// Checksum 0xec3e68d2, Offset: 0x1388
// Size: 0xca4
function zone_init(zone_name, zone_tag) {
    if (isdefined(level.zones[zone_name])) {
        return;
    }
    println("<dev string:x67>" + zone_name);
    level.zones[zone_name] = spawnstruct();
    zone = level.zones[zone_name];
    zone.name = zone_name;
    zone.is_enabled = 0;
    zone.is_occupied = 0;
    zone.is_active = 0;
    zone.adjacent_zones = [];
    zone.is_spawning_allowed = 0;
    if (isdefined(zone_tag)) {
        zone_name_tokens = strtok(zone_name, "_");
        zone.district = zone_name_tokens[1];
        zone.area = zone_tag;
    }
    zone.nodes = getnodearray(zone_name, "targetname");
    level.zone_nodes = arraycombine(level.zone_nodes, zone.nodes, 0, 0);
    var_edc1598d = array("inner_zigzag_radius", "outer_zigzag_radius", "zigzag_distance_min", "zigzag_distance_max", "zigzag_activation_distance", "zigzag_enabled");
    foreach (node in zone.nodes) {
        foreach (override_name in var_edc1598d) {
            if (isdefined(node.(override_name))) {
                assert(!isdefined(zone.(override_name)), "<dev string:x7e>" + override_name + "<dev string:x90>" + zone_name);
                zone.(override_name) = node.(override_name);
            }
        }
    }
    zone.volumes = [];
    volumes = getentarray(zone_name, "targetname");
    println("<dev string:xad>" + volumes.size + "<dev string:xd2>" + zone.nodes.size);
    for (i = 0; i < volumes.size; i++) {
        if (volumes[i].classname == "info_volume") {
            zone.volumes[zone.volumes.size] = volumes[i];
        }
    }
    assert(isdefined(zone.volumes[0]) || isdefined(zone.nodes[0]), "<dev string:xe3>" + zone_name);
    /#
        zone.total_spawn_count = 0;
        zone.round_spawn_count = 0;
    #/
    zone.a_loc_types = [];
    zone.a_loc_types[#"zombie_location"] = [];
    zone.zbarriers = [];
    zone.magic_boxes = [];
    if (zm_utility::function_be4cf12d() && zone.nodes.size > 0) {
        zone_target = zone.nodes[0].target;
    } else if (zm_utility::function_a70772a9() && zone.volumes[0].size > 0) {
        zone_target = zone.volumes[0].target;
    }
    if (isdefined(zone_target)) {
        spots = struct::get_array(zone_target, "targetname");
        barricades = struct::get_array("exterior_goal", "targetname");
        box_locs = struct::get_array("treasure_chest_use", "targetname");
        foreach (spot in spots) {
            spot.zone_name = zone_name;
            if (!(isdefined(spot.is_blocked) && spot.is_blocked)) {
                spot.is_enabled = 1;
            } else {
                spot.is_enabled = 0;
            }
            tokens = strtok(spot.script_noteworthy, " ");
            foreach (token in tokens) {
                switch (token) {
                case #"custom_spawner_entry":
                case #"spawn_location":
                case #"riser_location":
                case #"faller_location":
                    spot.spawned_timestamp = gettime();
                    if (!isdefined(zone.a_loc_types[#"zombie_location"])) {
                        zone.a_loc_types[#"zombie_location"] = [];
                    } else if (!isarray(zone.a_loc_types[#"zombie_location"])) {
                        zone.a_loc_types[#"zombie_location"] = array(zone.a_loc_types[#"zombie_location"]);
                    }
                    zone.a_loc_types[#"zombie_location"][zone.a_loc_types[#"zombie_location"].size] = spot;
                    break;
                default:
                    if (!isdefined(zone.a_loc_types[token])) {
                        zone.a_loc_types[token] = [];
                    }
                    if (!isdefined(zone.a_loc_types[token])) {
                        zone.a_loc_types[token] = [];
                    } else if (!isarray(zone.a_loc_types[token])) {
                        zone.a_loc_types[token] = array(zone.a_loc_types[token]);
                    }
                    zone.a_loc_types[token][zone.a_loc_types[token].size] = spot;
                    break;
                }
            }
            if (isdefined(spot.script_string)) {
                barricade_id = spot.script_string;
                for (k = 0; k < barricades.size; k++) {
                    if (isdefined(barricades[k].script_string) && barricades[k].script_string == barricade_id) {
                        nodes = getnodearray(barricades[k].target, "targetname");
                        for (j = 0; j < nodes.size; j++) {
                            if (isdefined(nodes[j].type) && nodes[j].type == #"begin") {
                                spot.target = nodes[j].targetname;
                            }
                        }
                    }
                }
            }
        }
        for (i = 0; i < barricades.size; i++) {
            targets = getentarray(barricades[i].target, "targetname");
            for (j = 0; j < targets.size; j++) {
                if (targets[j] iszbarrier() && isdefined(targets[j].script_string) && targets[j].script_string == zone_name) {
                    if (!isdefined(zone.zbarriers)) {
                        zone.zbarriers = [];
                    } else if (!isarray(zone.zbarriers)) {
                        zone.zbarriers = array(zone.zbarriers);
                    }
                    zone.zbarriers[zone.zbarriers.size] = targets[j];
                }
            }
        }
        for (i = 0; i < box_locs.size; i++) {
            chest_ent = getent(box_locs[i].script_noteworthy + "_zbarrier", "script_noteworthy");
            if (chest_ent entity_in_zone(zone_name, 1)) {
                if (!isdefined(zone.magic_boxes)) {
                    zone.magic_boxes = [];
                } else if (!isarray(zone.magic_boxes)) {
                    zone.magic_boxes = array(zone.magic_boxes);
                }
                zone.magic_boxes[zone.magic_boxes.size] = box_locs[i];
            }
        }
    }
}

// Namespace zm_zonemgr/zm_zonemgr
// Params 0, eflags: 0x0
// Checksum 0xe14543f0, Offset: 0x2038
// Size: 0x564
function reinit_zone_spawners() {
    zkeys = getarraykeys(level.zones);
    for (i = 0; i < level.zones.size; i++) {
        zone = level.zones[zkeys[i]];
        zone.a_loc_types = [];
        zone.a_loc_types[#"zombie_location"] = [];
        if (zm_utility::function_be4cf12d() && zone.nodes.size > 0) {
            zone_target = zone.nodes[0].target;
        } else if (zm_utility::function_a70772a9() && zone.volumes[0].size > 0) {
            zone_target = zone.volumes[0].target;
        }
        if (isdefined(zone_target)) {
            spots = struct::get_array(zone_target, "targetname");
            foreach (n_index, spot in spots) {
                spot.zone_name = zkeys[n_index];
                if (!(isdefined(spot.is_blocked) && spot.is_blocked)) {
                    spot.is_enabled = 1;
                } else {
                    spot.is_enabled = 0;
                }
                tokens = strtok(spot.script_noteworthy, " ");
                foreach (token in tokens) {
                    switch (token) {
                    case #"custom_spawner_entry":
                    case #"spawn_location":
                    case #"riser_location":
                    case #"spawner_location":
                    case #"faller_location":
                        if (!isdefined(zone.a_loc_types[#"zombie_location"])) {
                            zone.a_loc_types[#"zombie_location"] = [];
                        } else if (!isarray(zone.a_loc_types[#"zombie_location"])) {
                            zone.a_loc_types[#"zombie_location"] = array(zone.a_loc_types[#"zombie_location"]);
                        }
                        zone.a_loc_types[#"zombie_location"][zone.a_loc_types[#"zombie_location"].size] = spot;
                        break;
                    default:
                        if (!isdefined(zone.a_loc_types[token])) {
                            zone.a_loc_types[token] = [];
                        } else if (!isarray(zone.a_loc_types[token])) {
                            zone.a_loc_types[token] = array(zone.a_loc_types[token]);
                        }
                        if (!isdefined(zone.a_loc_types[token])) {
                            zone.a_loc_types[token] = [];
                        } else if (!isarray(zone.a_loc_types[token])) {
                            zone.a_loc_types[token] = array(zone.a_loc_types[token]);
                        }
                        zone.a_loc_types[token][zone.a_loc_types[token].size] = spot;
                        break;
                    }
                }
            }
        }
    }
}

// Namespace zm_zonemgr/zm_zonemgr
// Params 1, eflags: 0x0
// Checksum 0x96fdaea1, Offset: 0x25a8
// Size: 0x324
function enable_zone(zone_name) {
    assert(isdefined(level.zones) && isdefined(level.zones[zone_name]), "<dev string:x115>");
    if (level.zones[zone_name].is_enabled) {
        return;
    }
    level.zones[zone_name].is_enabled = 1;
    level.zones[zone_name].is_spawning_allowed = 1;
    level notify(zone_name);
    level notify(#"hash_7f3e3ea9f03a4f3a", {#str_zone_name:zone_name});
    spawn_points = zm_gametype::get_player_spawns_for_gametype();
    for (i = 0; i < spawn_points.size; i++) {
        if (spawn_points[i].script_noteworthy == zone_name) {
            spawn_points[i].locked = 0;
        }
    }
    entry_points = struct::get_array(zone_name + "_barriers", "script_noteworthy");
    for (i = 0; i < entry_points.size; i++) {
        entry_points[i].is_active = 1;
        entry_points[i] triggerenable(1);
    }
    foreach (node in level.zones[zone_name].nodes) {
        if (!isdefined(level.var_b4c5832b)) {
            level.var_b4c5832b = [];
        } else if (!isarray(level.var_b4c5832b)) {
            level.var_b4c5832b = array(level.var_b4c5832b);
        }
        if (!isinarray(level.var_b4c5832b, getnoderegion(node))) {
            level.var_b4c5832b[level.var_b4c5832b.size] = getnoderegion(node);
        }
    }
    bb::logroundevent("zone_enable_" + zone_name);
}

// Namespace zm_zonemgr/zm_zonemgr
// Params 3, eflags: 0x0
// Checksum 0x578e7841, Offset: 0x28d8
// Size: 0x176
function make_zone_adjacent(main_zone_name, adj_zone_name, flag_name) {
    main_zone = level.zones[main_zone_name];
    if (!isdefined(main_zone.adjacent_zones[adj_zone_name])) {
        main_zone.adjacent_zones[adj_zone_name] = spawnstruct();
        adj_zone = main_zone.adjacent_zones[adj_zone_name];
        adj_zone.is_connected = 0;
        adj_zone.flags_do_or_check = 0;
        if (isarray(flag_name)) {
            adj_zone.flags = flag_name;
        } else {
            adj_zone.flags[0] = flag_name;
        }
        return;
    }
    assert(!isarray(flag_name), "<dev string:x140>");
    adj_zone = main_zone.adjacent_zones[adj_zone_name];
    size = adj_zone.flags.size;
    adj_zone.flags_do_or_check = 1;
    adj_zone.flags[size] = flag_name;
}

// Namespace zm_zonemgr/zm_zonemgr
// Params 2, eflags: 0x0
// Checksum 0xfdf8dd6, Offset: 0x2a58
// Size: 0x11e
function add_zone_flags(wait_flag, add_flags) {
    if (!isdefined(add_flags)) {
        add_flags = [];
    } else if (!isarray(add_flags)) {
        add_flags = array(add_flags);
    }
    keys = getarraykeys(level.zone_flags);
    for (i = 0; i < keys.size; i++) {
        if (keys[i] == wait_flag) {
            level.zone_flags[keys[i]] = arraycombine(level.zone_flags[keys[i]], add_flags, 1, 0);
            return;
        }
    }
    level.zone_flags[wait_flag] = add_flags;
}

// Namespace zm_zonemgr/zm_zonemgr
// Params 6, eflags: 0x0
// Checksum 0x89333c0f, Offset: 0x2b80
// Size: 0xec
function add_adjacent_zone(zone_name_a, zone_name_b, flag_name, one_way = 1, zone_tag_a, zone_tag_b) {
    if (!isdefined(level.flag[flag_name])) {
        level flag::init(flag_name);
    }
    zone_init(zone_name_a, zone_tag_a);
    zone_init(zone_name_b, zone_tag_b);
    make_zone_adjacent(zone_name_a, zone_name_b, flag_name);
    if (!one_way) {
        make_zone_adjacent(zone_name_b, zone_name_a, flag_name);
    }
}

// Namespace zm_zonemgr/zm_zonemgr
// Params 0, eflags: 0x0
// Checksum 0xde2ed50f, Offset: 0x2c78
// Size: 0x1ee
function setup_zone_flag_waits() {
    flags = [];
    zkeys = getarraykeys(level.zones);
    for (z = 0; z < level.zones.size; z++) {
        zone = level.zones[zkeys[z]];
        azkeys = getarraykeys(zone.adjacent_zones);
        for (az = 0; az < zone.adjacent_zones.size; az++) {
            azone = zone.adjacent_zones[azkeys[az]];
            for (f = 0; f < azone.flags.size; f++) {
                if (!isdefined(flags)) {
                    flags = [];
                } else if (!isarray(flags)) {
                    flags = array(flags);
                }
                if (!isinarray(flags, azone.flags[f])) {
                    flags[flags.size] = azone.flags[f];
                }
            }
        }
    }
    for (i = 0; i < flags.size; i++) {
        level thread zone_flag_wait(flags[i]);
    }
}

// Namespace zm_zonemgr/zm_zonemgr
// Params 0, eflags: 0x0
// Checksum 0xa5999f0c, Offset: 0x2e70
// Size: 0x3a
function wait_zone_flags_updating() {
    if (!isdefined(level.zone_flags_updating)) {
        level.zone_flags_updating = 0;
    }
    while (level.zone_flags_updating > 0) {
        waitframe(1);
    }
}

// Namespace zm_zonemgr/zm_zonemgr
// Params 0, eflags: 0x0
// Checksum 0x689d7087, Offset: 0x2eb8
// Size: 0x54
function zone_flag_wait_throttle() {
    if (!isdefined(level.zone_flag_wait_throttle)) {
        level.zone_flag_wait_throttle = 0;
    }
    level.zone_flag_wait_throttle++;
    if (level.zone_flag_wait_throttle > 3) {
        level.zone_flag_wait_throttle = 0;
        waitframe(1);
    }
}

// Namespace zm_zonemgr/zm_zonemgr
// Params 1, eflags: 0x0
// Checksum 0x35c6d744, Offset: 0x2f18
// Size: 0x564
function zone_flag_wait(flag_name) {
    if (!isdefined(level.flag[flag_name])) {
        level flag::init(flag_name);
    }
    if (flag_name == "power_on" && zm_custom::function_5638f689(#"zmpowerdoorstate") == 2) {
        waitframe(1);
    }
    level flag::wait_till(flag_name);
    if (!isdefined(level.zone_flags_updating)) {
        level.zone_flags_updating = 0;
    }
    level.zone_flags_updating++;
    flags_set = 0;
    for (z = 0; z < level.zones.size; z++) {
        zkeys = getarraykeys(level.zones);
        zone = level.zones[zkeys[z]];
        for (az = 0; az < zone.adjacent_zones.size; az++) {
            azkeys = getarraykeys(zone.adjacent_zones);
            azone = zone.adjacent_zones[azkeys[az]];
            if (!azone.is_connected) {
                if (azone.flags_do_or_check) {
                    flags_set = 0;
                    if (azone.flags.size == 1 && azone.flags[0] == "power_on" && zm_custom::function_5638f689(#"zmpowerdoorstate") == 2) {
                        flags_set = 1;
                    } else {
                        for (f = 0; f < azone.flags.size; f++) {
                            if (level flag::get(azone.flags[f])) {
                                flags_set = 1;
                                break;
                            }
                        }
                    }
                } else {
                    flags_set = 1;
                    if (azone.flags.size == 1 && azone.flags[0] == "power_on" && zm_custom::function_5638f689(#"zmpowerdoorstate") == 2) {
                        flags_set = 1;
                    } else {
                        for (f = 0; f < azone.flags.size; f++) {
                            if (!level flag::get(azone.flags[f])) {
                                flags_set = 0;
                            }
                        }
                    }
                }
                if (flags_set) {
                    enable_zone(level.zones[zkeys[z]].name);
                    azone.is_connected = 1;
                    if (!level.zones[azkeys[az]].is_enabled) {
                        enable_zone(level.zones[azkeys[az]].name);
                    }
                    if (level flag::get("door_can_close")) {
                        azone thread door_close_disconnect(flag_name);
                    }
                }
            }
        }
        zone_flag_wait_throttle();
    }
    keys = getarraykeys(level.zone_flags);
    for (i = 0; i < keys.size; i++) {
        if (keys[i] == flag_name) {
            check_flag = level.zone_flags[keys[i]];
            for (k = 0; k < check_flag.size; k++) {
                if (check_flag[k] != #"power_on") {
                    level flag::set(check_flag[k]);
                }
            }
            break;
        }
        zone_flag_wait_throttle();
    }
    level.zone_flags_updating--;
    function_2bc6b41d(1);
}

// Namespace zm_zonemgr/zm_zonemgr
// Params 1, eflags: 0x0
// Checksum 0x8916504b, Offset: 0x3488
// Size: 0x54
function door_close_disconnect(flag_name) {
    while (level flag::get(flag_name)) {
        wait 1;
    }
    self.is_connected = 0;
    level thread zone_flag_wait(flag_name);
}

// Namespace zm_zonemgr/zm_zonemgr
// Params 1, eflags: 0x0
// Checksum 0xbdb5cc1f, Offset: 0x34e8
// Size: 0x860
function manage_zones(initial_zone) {
    assert(isdefined(initial_zone), "<dev string:x179>");
    deactivate_initial_barrier_goals();
    level.player_zone_found = 1;
    zone_choke = 0;
    spawn_points = zm_gametype::get_player_spawns_for_gametype();
    for (i = 0; i < spawn_points.size; i++) {
        assert(isdefined(spawn_points[i].script_noteworthy), "<dev string:x1a4>");
        spawn_points[i].locked = 1;
    }
    if (isdefined(level.zone_manager_init_func)) {
        [[ level.zone_manager_init_func ]]();
    }
    println("<dev string:x1f2>" + initial_zone.size);
    if (isarray(initial_zone)) {
        println("<dev string:x21d>" + initial_zone[0]);
        for (i = 0; i < initial_zone.size; i++) {
            zone_init(initial_zone[i]);
            enable_zone(initial_zone[i]);
        }
    } else {
        println("<dev string:x248>" + initial_zone);
        zone_init(initial_zone);
        enable_zone(initial_zone);
    }
    setup_zone_flag_waits();
    zkeys = getarraykeys(level.zones);
    level.zone_keys = zkeys;
    level.newzones = [];
    for (z = 0; z < zkeys.size; z++) {
        level.newzones[zkeys[z]] = spawnstruct();
    }
    oldzone = undefined;
    level flag::set("zones_initialized");
    level flag::wait_till("begin_spawning");
    /#
        level thread _debug_zones();
    #/
    while (getdvarint(#"noclip", 0) == 0 || getdvarint(#"notarget", 0) != 0) {
        wait_zone_flags_updating();
        for (z = 0; z < zkeys.size; z++) {
            level.newzones[zkeys[z]].is_active = 0;
            level.newzones[zkeys[z]].is_occupied = 0;
        }
        a_zone_is_active = 0;
        a_zone_is_spawning_allowed = 0;
        level.zone_scanning_active = 1;
        for (z = 0; z < zkeys.size; z++) {
            zone = level.zones[zkeys[z]];
            newzone = level.newzones[zkeys[z]];
            if (!zone.is_enabled) {
                continue;
            }
            if (isdefined(level.var_4af51a33)) {
                newzone.is_occupied = [[ level.var_4af51a33 ]](zkeys[z]);
            } else {
                newzone.is_occupied = any_player_in_zone(zkeys[z]);
            }
            if (newzone.is_occupied) {
                newzone.is_active = 1;
                a_zone_is_active = 1;
                if (zone.is_spawning_allowed) {
                    a_zone_is_spawning_allowed = 1;
                }
                if (!isdefined(oldzone) || oldzone != newzone) {
                    level notify(#"newzoneactive", {#zone:zkeys[z]});
                    oldzone = newzone;
                }
                azkeys = getarraykeys(zone.adjacent_zones);
                for (az = 0; az < zone.adjacent_zones.size; az++) {
                    if (zone.adjacent_zones[azkeys[az]].is_connected && level.zones[azkeys[az]].is_enabled) {
                        level.newzones[azkeys[az]].is_active = 1;
                        if (level.zones[azkeys[az]].is_spawning_allowed) {
                            a_zone_is_spawning_allowed = 1;
                        }
                    }
                }
            }
            zone_choke++;
            if (zone_choke >= 3) {
                zone_choke = 0;
                waitframe(1);
                wait_zone_flags_updating();
            }
        }
        level.zone_scanning_active = 0;
        for (z = 0; z < zkeys.size; z++) {
            level.zones[zkeys[z]].is_active = level.newzones[zkeys[z]].is_active;
            level.zones[zkeys[z]].is_occupied = level.newzones[zkeys[z]].is_occupied;
        }
        if (!a_zone_is_active || !a_zone_is_spawning_allowed) {
            if (isarray(initial_zone)) {
                level.zones[initial_zone[0]].is_active = 1;
                level.zones[initial_zone[0]].is_occupied = 1;
                level.zones[initial_zone[0]].is_spawning_allowed = 1;
            } else {
                level.zones[initial_zone].is_active = 1;
                level.zones[initial_zone].is_occupied = 1;
                level.zones[initial_zone].is_spawning_allowed = 1;
            }
            level.player_zone_found = 0;
        } else {
            level.player_zone_found = 1;
        }
        [[ level.create_spawner_list_func ]](zkeys);
        /#
            debug_show_spawn_locations();
        #/
        level.active_zone_names = get_active_zone_names();
        wait 1;
    }
}

/#

    // Namespace zm_zonemgr/zm_zonemgr
    // Params 0, eflags: 0x0
    // Checksum 0x40d6d7c4, Offset: 0x3d50
    // Size: 0x178
    function debug_show_spawn_locations() {
        if (isdefined(level.toggle_show_spawn_locations) && level.toggle_show_spawn_locations) {
            host_player = util::gethostplayer();
            foreach (location in level.zm_loc_types[#"zombie_location"]) {
                distance = distance(location.origin, host_player.origin);
                color = (0, 1, 1);
                if (distance > getdvarint(#"scr_spawner_location_distance", 0) * 12) {
                    color = (1, 0, 0);
                }
                debugstar(location.origin, getdvarint(#"scr_spawner_location_time", 0), color);
            }
        }
    }

#/

// Namespace zm_zonemgr/zm_zonemgr
// Params 1, eflags: 0x0
// Checksum 0xd99e4908, Offset: 0x3ed0
// Size: 0x5a2
function create_spawner_list(zkeys) {
    foreach (str_index, a_locs in level.zm_loc_types) {
        level.zm_loc_types[str_index] = [];
    }
    for (z = 0; z < zkeys.size; z++) {
        zone = level.zones[zkeys[z]];
        if (zone.is_enabled && zone.is_active && zone.is_spawning_allowed) {
            foreach (a_locs in zone.a_loc_types) {
                foreach (loc in a_locs) {
                    if (isdefined(loc.is_enabled) && loc.is_enabled == 0) {
                        continue;
                    }
                    tokens = strtok(loc.script_noteworthy, " ");
                    foreach (token in tokens) {
                        switch (token) {
                        case #"custom_spawner_entry":
                        case #"spawn_location":
                        case #"riser_location":
                        case #"faller_location":
                            if (!isdefined(level.zm_loc_types[#"zombie_location"])) {
                                level.zm_loc_types[#"zombie_location"] = [];
                            } else if (!isarray(level.zm_loc_types[#"zombie_location"])) {
                                level.zm_loc_types[#"zombie_location"] = array(level.zm_loc_types[#"zombie_location"]);
                            }
                            if (!isinarray(level.zm_loc_types[#"zombie_location"], loc)) {
                                level.zm_loc_types[#"zombie_location"][level.zm_loc_types[#"zombie_location"].size] = loc;
                            }
                            break;
                        default:
                            if (!isdefined(level.zm_loc_types[token])) {
                                level.zm_loc_types[token] = [];
                            }
                            if (!isdefined(level.zm_loc_types[token])) {
                                level.zm_loc_types[token] = [];
                            } else if (!isarray(level.zm_loc_types[token])) {
                                level.zm_loc_types[token] = array(level.zm_loc_types[token]);
                            }
                            if (!isinarray(level.zm_loc_types[token], loc)) {
                                level.zm_loc_types[token][level.zm_loc_types[token].size] = loc;
                            }
                            break;
                        }
                    }
                }
            }
        }
    }
    var_8bd31a0e = getarraykeys(level.zm_loc_types);
    foreach (key in var_8bd31a0e) {
        level.zm_loc_types[key] = array::randomize(level.zm_loc_types[key]);
    }
}

// Namespace zm_zonemgr/zm_zonemgr
// Params 0, eflags: 0x0
// Checksum 0xa727d5fd, Offset: 0x4480
// Size: 0xac
function get_active_zone_names() {
    ret_list = [];
    if (!isdefined(level.zone_keys)) {
        return ret_list;
    }
    while (level.zone_scanning_active) {
        waitframe(1);
    }
    for (i = 0; i < level.zone_keys.size; i++) {
        if (level.zones[level.zone_keys[i]].is_active) {
            ret_list[ret_list.size] = level.zone_keys[i];
        }
    }
    return ret_list;
}

// Namespace zm_zonemgr/zm_zonemgr
// Params 0, eflags: 0x0
// Checksum 0x6a877981, Offset: 0x4538
// Size: 0xda
function get_active_zones_entities() {
    a_player_zones = getentarray("player_volume", "script_noteworthy");
    a_active_zones = [];
    for (i = 0; i < a_player_zones.size; i++) {
        e_zone = a_player_zones[i];
        zone = level.zones[e_zone.targetname];
        if (isdefined(zone) && isdefined(zone.is_enabled) && zone.is_enabled) {
            a_active_zones[a_active_zones.size] = e_zone;
        }
    }
    return a_active_zones;
}

// Namespace zm_zonemgr/zm_zonemgr
// Params 3, eflags: 0x0
// Checksum 0xcdd21760, Offset: 0x4620
// Size: 0x110
function _debug_show_zone(zone, color, alpha) {
    if (isdefined(zone)) {
        foreach (volume in zone.volumes) {
            if (!isdefined(color) || !isdefined(alpha)) {
                showinfovolume(volume getentitynumber(), (0.2, 0.5, 0), 0.05);
                continue;
            }
            showinfovolume(volume getentitynumber(), color, alpha);
        }
    }
}

// Namespace zm_zonemgr/zm_zonemgr
// Params 0, eflags: 0x0
// Checksum 0x3a45ad7, Offset: 0x4738
// Size: 0x38c
function _debug_zones() {
    enabled = 0;
    while (true) {
        wasenabled = enabled;
        enabled = getdvarint(#"zombiemode_debug_zones", 0);
        occupied_zone = undefined;
        n_spacer = 0;
        foreach (zone in level.zones) {
            if (zone.name.size > n_spacer) {
                n_spacer = zone.name.size;
            }
        }
        if (enabled) {
            n = 0;
            foreach (zone in level.zones) {
                var_1635c27a = "";
                var_b62e617d = "";
                for (i = 0; i < n_spacer - zone.name.size; i++) {
                    var_b62e617d += " ";
                }
                var_1635c27a += zone.name + var_b62e617d + " | ";
                if (zone.is_enabled) {
                    var_1635c27a += "Enabled | ";
                } else {
                    var_1635c27a += "        | ";
                }
                if (zone.is_active) {
                    var_1635c27a += "Active | ";
                } else {
                    var_1635c27a += "       | ";
                }
                if (zone.is_occupied) {
                    var_1635c27a += "Occupied | ";
                    occupied_zone = zone;
                } else {
                    var_1635c27a += "         | ";
                }
                if (zone.is_spawning_allowed) {
                    var_1635c27a += "SpawnOK | ";
                } else {
                    var_1635c27a += "        | ";
                }
                /#
                    var_1635c27a += zone.a_loc_types[#"zombie_location"].size + "<dev string:x26d>" + zone.total_spawn_count + "<dev string:x26d>" + zone.round_spawn_count;
                    v_pos = 100 + 18 * n;
                    debug2dtext((400, v_pos, 0), var_1635c27a, (1, 1, 0), undefined, (0, 0, 0), 0.75, 0.85, 2);
                #/
                n++;
            }
        }
        wait 0.1;
    }
}

// Namespace zm_zonemgr/zm_zonemgr
// Params 2, eflags: 0x0
// Checksum 0xbe91a07c, Offset: 0x4ad0
// Size: 0x128
function function_a5972886(player_ent, ent) {
    assert(isplayer(player_ent));
    assert(isentity(ent));
    if (isplayer(player_ent) && isentity(ent)) {
        ent_number = player_ent getentitynumber();
        zone_name = ent zm_utility::get_current_zone();
        if (isdefined(zone_name) && isdefined(level.zone_paths[ent_number]) && isdefined(level.zone_paths[ent_number][zone_name])) {
            return level.zone_paths[ent_number][zone_name];
        }
    }
}

// Namespace zm_zonemgr/zm_zonemgr
// Params 1, eflags: 0x0
// Checksum 0xb64022d1, Offset: 0x4c00
// Size: 0x4d4
function function_2bc6b41d(force_update = 0) {
    pixbeginevent(#"hash_62bff2437ffcdbcd");
    if (getdvarint(#"zm_zone_pathing", 1)) {
        if (force_update) {
            level.zone_paths = [];
        }
        players = getplayers();
        active_players = [];
        zone_paths = [];
        foreach (player in getplayers()) {
            if (player.sessionstate !== "spectator") {
                active_players[active_players.size] = player;
            }
        }
        foreach (player in active_players) {
            var_26a05cb = player get_player_zone();
            if (!isdefined(var_26a05cb)) {
                continue;
            }
            ent_number = player getentitynumber();
            if (isdefined(level.zone_paths[ent_number]) && isdefined(level.zone_paths[ent_number][var_26a05cb])) {
                if (level.zone_paths[ent_number][var_26a05cb].cost == 0) {
                    zone_paths[ent_number] = level.zone_paths[ent_number];
                    continue;
                }
            }
            zone = level.zones[var_26a05cb];
            var_d980ec5c = [];
            zone_info = spawnstruct();
            zone_info.cost = 0;
            var_d980ec5c[zone.name] = zone_info;
            var_709d388a = 0;
            zone_queue = [];
            zone_queue[zone_queue.size] = zone.name;
            while (zone_queue.size > var_709d388a) {
                zone = level.zones[zone_queue[var_709d388a]];
                if (isdefined(zone.var_f0b4b2ce) && zone.var_f0b4b2ce) {
                    var_709d388a++;
                    continue;
                }
                zone_info = var_d980ec5c[zone.name];
                foreach (var_9aec8c2a, adjacent_zone in zone.adjacent_zones) {
                    if (isdefined(var_d980ec5c[var_9aec8c2a]) || isdefined(level.zones[var_9aec8c2a].var_f0b4b2ce) && level.zones[var_9aec8c2a].var_f0b4b2ce) {
                        continue;
                    }
                    if (adjacent_zone.is_connected) {
                        var_35911c4c = spawnstruct();
                        var_35911c4c.to_zone = zone.name;
                        var_35911c4c.cost = zone_info.cost + 1;
                        var_d980ec5c[var_9aec8c2a] = var_35911c4c;
                        zone_queue[zone_queue.size] = var_9aec8c2a;
                    }
                }
                var_709d388a++;
            }
            zone_paths[ent_number] = var_d980ec5c;
        }
        level.zone_paths = zone_paths;
    }
    pixendevent();
}

// Namespace zm_zonemgr/zm_zonemgr
// Params 1, eflags: 0x0
// Checksum 0xeb429e18, Offset: 0x50e0
// Size: 0xa4
function function_f0b4b2ce(zone_name) {
    if (isdefined(level.zones) && isdefined(level.zones[zone_name]) && !(isdefined(level.zones[zone_name].var_f0b4b2ce) && level.zones[zone_name].var_f0b4b2ce)) {
        level.zones[zone_name].var_f0b4b2ce = 1;
        function_2bc6b41d(1);
    }
}

// Namespace zm_zonemgr/zm_zonemgr
// Params 1, eflags: 0x0
// Checksum 0xba3cb790, Offset: 0x5190
// Size: 0x9c
function function_66686f8d(zone_name) {
    if (isdefined(level.zones) && isdefined(level.zones[zone_name]) && isdefined(level.zones[zone_name].var_f0b4b2ce) && level.zones[zone_name].var_f0b4b2ce) {
        level.zones[zone_name].var_f0b4b2ce = undefined;
        function_2bc6b41d(1);
    }
}

// Namespace zm_zonemgr/zm_zonemgr
// Params 1, eflags: 0x0
// Checksum 0xb80485d0, Offset: 0x5238
// Size: 0xe2
function is_player_in_zone(a_str_zones) {
    if (!isdefined(a_str_zones)) {
        a_str_zones = [];
    } else if (!isarray(a_str_zones)) {
        a_str_zones = array(a_str_zones);
    }
    str_player_zone = self get_player_zone();
    foreach (str_zone in a_str_zones) {
        if (str_player_zone === str_zone) {
            return true;
        }
    }
    return false;
}

