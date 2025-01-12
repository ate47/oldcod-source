#using scripts\abilities\ability_util;
#using scripts\core_common\ai\zombie_death;
#using scripts\core_common\ai\zombie_utility;
#using scripts\core_common\array_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\gameobjects_shared;
#using scripts\core_common\hud_message_shared;
#using scripts\core_common\laststand_shared;
#using scripts\core_common\lui_shared;
#using scripts\core_common\player\player_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\throttle_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\zm_common\util;
#using scripts\zm_common\zm;
#using scripts\zm_common\zm_ai_faller;
#using scripts\zm_common\zm_audio;
#using scripts\zm_common\zm_bgb;
#using scripts\zm_common\zm_characters;
#using scripts\zm_common\zm_cleanup_mgr;
#using scripts\zm_common\zm_equipment;
#using scripts\zm_common\zm_laststand;
#using scripts\zm_common\zm_loadout;
#using scripts\zm_common\zm_magicbox;
#using scripts\zm_common\zm_maptable;
#using scripts\zm_common\zm_perks;
#using scripts\zm_common\zm_player;
#using scripts\zm_common\zm_power;
#using scripts\zm_common\zm_powerups;
#using scripts\zm_common\zm_round_logic;
#using scripts\zm_common\zm_score;
#using scripts\zm_common\zm_server_throttle;
#using scripts\zm_common\zm_spawner;
#using scripts\zm_common\zm_stats;
#using scripts\zm_common\zm_trial;
#using scripts\zm_common\zm_weapons;
#using scripts\zm_common\zm_zonemgr;

#namespace zm_utility;

// Namespace zm_utility/zm_utility
// Params 0, eflags: 0x2
// Checksum 0x827e0ae5, Offset: 0x688
// Size: 0x44
function autoexec __init__system__() {
    system::register(#"zm_utility", &__init__, &__main__, undefined);
}

// Namespace zm_utility/zm_utility
// Params 0, eflags: 0x0
// Checksum 0x681eefaa, Offset: 0x6d8
// Size: 0x74
function __init__() {
    clientfield::register("scriptmover", "zm_zone_edge_marker_count", 1, getminbitcountfornum(15), "int");
    clientfield::register("toplayer", "zm_zone_out_of_bounds", 1, 1, "int");
}

// Namespace zm_utility/zm_utility
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x758
// Size: 0x4
function __main__() {
    
}

// Namespace zm_utility/zm_utility
// Params 0, eflags: 0x0
// Checksum 0xbf73c8d1, Offset: 0x768
// Size: 0x1c
function init_utility() {
    level thread check_solo_status();
}

// Namespace zm_utility/zm_utility
// Params 0, eflags: 0x0
// Checksum 0xe4581ccc, Offset: 0x790
// Size: 0x40
function is_classic() {
    str_gametype = util::get_game_type();
    if (str_gametype == #"zclassic") {
        return true;
    }
    return false;
}

// Namespace zm_utility/zm_utility
// Params 0, eflags: 0x0
// Checksum 0x7231a678, Offset: 0x7d8
// Size: 0x40
function is_standard() {
    str_gametype = util::get_game_type();
    if (str_gametype == #"zstandard") {
        return true;
    }
    return false;
}

// Namespace zm_utility/zm_utility
// Params 0, eflags: 0x0
// Checksum 0x20ac739e, Offset: 0x820
// Size: 0x68
function is_trials() {
    str_gametype = util::get_game_type();
    if (str_gametype == #"ztrials" || level flag::exists(#"ztrial")) {
        return true;
    }
    return false;
}

// Namespace zm_utility/zm_utility
// Params 0, eflags: 0x0
// Checksum 0x737b61fa, Offset: 0x890
// Size: 0x40
function is_tutorial() {
    str_gametype = util::get_game_type();
    if (str_gametype == #"ztutorial") {
        return true;
    }
    return false;
}

// Namespace zm_utility/zm_utility
// Params 0, eflags: 0x0
// Checksum 0x6016d692, Offset: 0x8d8
// Size: 0x40
function is_grief() {
    str_gametype = util::get_game_type();
    if (str_gametype == #"zgrief") {
        return true;
    }
    return false;
}

// Namespace zm_utility/zm_utility
// Params 0, eflags: 0x0
// Checksum 0x9d4aab1, Offset: 0x920
// Size: 0x12
function get_cast() {
    return zm_maptable::get_cast();
}

// Namespace zm_utility/zm_utility
// Params 0, eflags: 0x0
// Checksum 0xd82048ca, Offset: 0x940
// Size: 0x12
function get_story() {
    return zm_maptable::get_story();
}

// Namespace zm_utility/zm_utility
// Params 0, eflags: 0x0
// Checksum 0x97cd7e3c, Offset: 0x960
// Size: 0x82
function check_solo_status() {
    if (getnumexpectedplayers() == 1 && (!sessionmodeisonlinegame() || !sessionmodeisprivate() || zm_trial::is_trial_mode())) {
        level.is_forever_solo_game = 1;
        return;
    }
    level.is_forever_solo_game = 0;
}

// Namespace zm_utility/zm_utility
// Params 0, eflags: 0x0
// Checksum 0x7cd2e614, Offset: 0x9f0
// Size: 0x1bc
function init_zombie_run_cycle() {
    if (isdefined(level.speed_change_round)) {
        if (!isdefined(self._starting_round_number)) {
            self._starting_round_number = level.round_number;
        }
        if (self._starting_round_number >= level.speed_change_round) {
            speed_percent = 0.2 + (self._starting_round_number - level.speed_change_round) * 0.2;
            speed_percent = min(speed_percent, 1);
            change_round_max = int(level.speed_change_max * speed_percent);
            change_left = change_round_max - level.speed_change_num;
            if (change_left == 0) {
                self zombie_utility::set_zombie_run_cycle();
                return;
            }
            change_speed = randomint(100);
            if (change_speed > 80) {
                self change_zombie_run_cycle();
                return;
            }
            zombie_count = zombie_utility::get_current_zombie_count();
            zombie_left = level.zombie_ai_limit - zombie_count;
            if (zombie_left == change_left) {
                self change_zombie_run_cycle();
                return;
            }
        }
    }
    self zombie_utility::set_zombie_run_cycle();
}

// Namespace zm_utility/zm_utility
// Params 0, eflags: 0x0
// Checksum 0xa72955a7, Offset: 0xbb8
// Size: 0x74
function change_zombie_run_cycle() {
    level.speed_change_num++;
    if (level.gamedifficulty == 0) {
        self zombie_utility::set_zombie_run_cycle("sprint");
    } else {
        self zombie_utility::set_zombie_run_cycle("run");
    }
    self thread speed_change_watcher();
}

// Namespace zm_utility/zm_utility
// Params 0, eflags: 0x0
// Checksum 0xb62c549e, Offset: 0xc38
// Size: 0x24
function make_supersprinter() {
    self zombie_utility::set_zombie_run_cycle("super_sprint");
}

// Namespace zm_utility/zm_utility
// Params 0, eflags: 0x0
// Checksum 0xd96366ae, Offset: 0xc68
// Size: 0x34
function speed_change_watcher() {
    self waittill(#"death");
    if (level.speed_change_num > 0) {
        level.speed_change_num--;
    }
}

// Namespace zm_utility/zm_utility
// Params 1, eflags: 0x0
// Checksum 0xf1bcd8e7, Offset: 0xca8
// Size: 0x522
function move_zombie_spawn_location(spot) {
    self endon(#"death");
    if (isdefined(self.spawn_pos)) {
        self notify(#"risen", {#find_flesh_struct_string:self.spawn_pos.script_string});
        return;
    }
    self.spawn_pos = spot;
    if (isdefined(spot.target)) {
        self.target = spot.target;
    }
    if (isdefined(spot.zone_name)) {
        self.zone_name = spot.zone_name;
        self.previous_zone_name = spot.zone_name;
    }
    if (isdefined(spot.script_parameters)) {
        self.script_parameters = spot.script_parameters;
    }
    if (!isdefined(spot.script_noteworthy)) {
        spot.script_noteworthy = "spawn_location";
    }
    tokens = strtok(spot.script_noteworthy, " ");
    foreach (index, token in tokens) {
        if (isdefined(self.spawn_point_override)) {
            spot = self.spawn_point_override;
            token = spot.script_noteworthy;
        }
        if (token == "custom_spawner_entry") {
            next_token = index + 1;
            if (isdefined(tokens[next_token])) {
                str_spawn_entry = tokens[next_token];
                if (isdefined(level.custom_spawner_entry) && isdefined(level.custom_spawner_entry[str_spawn_entry])) {
                    self thread [[ level.custom_spawner_entry[str_spawn_entry] ]](spot);
                    continue;
                }
            }
        }
        if (token == "riser_location") {
            self thread zm_spawner::do_zombie_rise(spot);
            continue;
        }
        if (token == "faller_location") {
            self thread zm_ai_faller::do_zombie_fall(spot);
            continue;
        }
        if (token == "spawn_location") {
            if (isdefined(self.anchor)) {
                return;
            }
            self.anchor = spawn("script_origin", self.origin);
            self.anchor.angles = self.angles;
            self linkto(self.anchor);
            self.anchor thread anchor_delete_failsafe(self);
            if (!isdefined(spot.angles)) {
                spot.angles = (0, 0, 0);
            }
            self ghost();
            self.anchor moveto(spot.origin, 0.05);
            self.anchor waittill(#"movedone");
            target_org = zombie_utility::get_desired_origin();
            if (isdefined(target_org)) {
                anim_ang = vectortoangles(target_org - self.origin);
                self.anchor rotateto((0, anim_ang[1], 0), 0.05);
                self.anchor waittill(#"rotatedone");
            }
            if (isdefined(level.zombie_spawn_fx)) {
                playfx(level.zombie_spawn_fx, spot.origin);
            }
            self unlink();
            if (isdefined(self.anchor)) {
                self.anchor delete();
            }
            if (!(isdefined(self.dontshow) && self.dontshow)) {
                self show();
            }
            self notify(#"risen", {#find_flesh_struct_string:spot.script_string});
        }
    }
}

// Namespace zm_utility/zm_utility
// Params 1, eflags: 0x0
// Checksum 0xd37c5a88, Offset: 0x11d8
// Size: 0x5c
function anchor_delete_failsafe(ai_zombie) {
    ai_zombie endon(#"risen");
    ai_zombie waittill(#"death");
    if (isdefined(self)) {
        self delete();
    }
}

// Namespace zm_utility/zm_utility
// Params 2, eflags: 0x0
// Checksum 0x835b8618, Offset: 0x1240
// Size: 0xd2
function all_chunks_intact(barrier, barrier_chunks) {
    if (isdefined(barrier.zbarrier)) {
        pieces = barrier.zbarrier getzbarrierpieceindicesinstate("closed");
        if (pieces.size != barrier.zbarrier getnumzbarrierpieces()) {
            return false;
        }
    } else {
        for (i = 0; i < barrier_chunks.size; i++) {
            if (barrier_chunks[i] get_chunk_state() != "repaired") {
                return false;
            }
        }
    }
    return true;
}

// Namespace zm_utility/zm_utility
// Params 2, eflags: 0x0
// Checksum 0x55957b05, Offset: 0x1320
// Size: 0xba
function no_valid_repairable_boards(barrier, barrier_chunks) {
    if (isdefined(barrier.zbarrier)) {
        pieces = barrier.zbarrier getzbarrierpieceindicesinstate("open");
        if (pieces.size) {
            return false;
        }
    } else {
        for (i = 0; i < barrier_chunks.size; i++) {
            if (barrier_chunks[i] get_chunk_state() == "destroyed") {
                return false;
            }
        }
    }
    return true;
}

// Namespace zm_utility/zm_utility
// Params 0, eflags: 0x0
// Checksum 0xa07362f7, Offset: 0x13e8
// Size: 0x6
function is_survival() {
    return false;
}

// Namespace zm_utility/zm_utility
// Params 0, eflags: 0x0
// Checksum 0xe6750054, Offset: 0x13f8
// Size: 0x6
function is_encounter() {
    return false;
}

// Namespace zm_utility/zm_utility
// Params 2, eflags: 0x0
// Checksum 0xb8ac3ce1, Offset: 0x1408
// Size: 0x13a
function all_chunks_destroyed(barrier, barrier_chunks) {
    if (isdefined(barrier.zbarrier)) {
        pieces = arraycombine(barrier.zbarrier getzbarrierpieceindicesinstate("open"), barrier.zbarrier getzbarrierpieceindicesinstate("opening"), 1, 0);
        if (pieces.size != barrier.zbarrier getnumzbarrierpieces()) {
            return false;
        }
    } else if (isdefined(barrier_chunks)) {
        assert(isdefined(barrier_chunks), "<dev string:x30>");
        for (i = 0; i < barrier_chunks.size; i++) {
            if (barrier_chunks[i] get_chunk_state() != "destroyed") {
                return false;
            }
        }
    }
    return true;
}

// Namespace zm_utility/zm_utility
// Params 1, eflags: 0x0
// Checksum 0x6db7ea9, Offset: 0x1550
// Size: 0x210
function check_point_in_playable_area(origin) {
    if (function_be4cf12d() && !isdefined(level.var_4b530519)) {
        level.var_4b530519 = getnodearray("player_region", "script_noteworthy");
    }
    if (function_a70772a9() && !isdefined(level.playable_area)) {
        level.playable_area = getentarray("player_volume", "script_noteworthy");
    }
    valid_point = 0;
    if (isdefined(level.var_4b530519)) {
        node = function_e910fb8c(origin + (0, 0, 40), level.var_4b530519, 500);
        if (isdefined(node)) {
            valid_point = 1;
        }
    }
    if (isdefined(level.playable_area) && !valid_point) {
        if (!isdefined(level.check_model)) {
            level.check_model = spawn("script_model", origin + (0, 0, 40));
        } else {
            level.check_model.origin = origin + (0, 0, 40);
        }
        for (i = 0; i < level.playable_area.size; i++) {
            if (level.check_model istouching(level.playable_area[i])) {
                valid_point = 1;
                break;
            }
        }
    }
    return valid_point;
}

// Namespace zm_utility/zm_utility
// Params 4, eflags: 0x0
// Checksum 0x3cf26d26, Offset: 0x1768
// Size: 0x368
function check_point_in_enabled_zone(origin, zone_is_active, player_zones, player_regions) {
    if (function_a70772a9() && !isdefined(level.playable_area)) {
        level.playable_area = getentarray("player_volume", "script_noteworthy");
    }
    if (!isdefined(player_zones)) {
        player_zones = level.playable_area;
    }
    if (function_be4cf12d() && !isdefined(level.player_regions)) {
        level.player_regions = getnodearray("player_region", "script_noteworthy");
    }
    if (!isdefined(player_regions)) {
        player_regions = level.player_regions;
    }
    if (!isdefined(level.zones) || !isdefined(player_zones) && !isdefined(player_regions)) {
        return 1;
    }
    one_valid_zone = 0;
    if (isdefined(player_regions)) {
        node = function_e910fb8c(origin + (0, 0, 40), player_regions, 500);
        if (isdefined(node)) {
            zone = level.zones[node.targetname];
            if (isdefined(zone) && isdefined(zone.is_enabled) && zone.is_enabled) {
                if (zone_is_active === 1 && !(isdefined(zone.is_active) && zone.is_active)) {
                    one_valid_zone = 0;
                } else {
                    one_valid_zone = 1;
                }
            }
        }
    }
    if (isdefined(player_zones) && !one_valid_zone) {
        if (!isdefined(level.e_check_point)) {
            level.e_check_point = spawn("script_origin", origin + (0, 0, 40));
        } else {
            level.e_check_point.origin = origin + (0, 0, 40);
        }
        for (i = 0; i < player_zones.size; i++) {
            zone = level.zones[player_zones[i].targetname];
            if (isdefined(zone) && isdefined(zone.is_enabled) && zone.is_enabled) {
                if (isdefined(zone_is_active) && zone_is_active == 1 && !(isdefined(zone.is_active) && zone.is_active)) {
                    continue;
                }
                if (level.e_check_point istouching(player_zones[i])) {
                    one_valid_zone = 1;
                    break;
                }
            }
        }
    }
    return one_valid_zone;
}

// Namespace zm_utility/zm_utility
// Params 1, eflags: 0x0
// Checksum 0x352e40d1, Offset: 0x1ad8
// Size: 0x46
function round_up_to_ten(score) {
    new_score = score - score % 10;
    if (new_score < score) {
        new_score += 10;
    }
    return new_score;
}

// Namespace zm_utility/zm_utility
// Params 2, eflags: 0x0
// Checksum 0x616690ad, Offset: 0x1b28
// Size: 0x68
function round_up_score(score, value) {
    score = int(score);
    new_score = score - score % value;
    if (new_score < score) {
        new_score += value;
    }
    return new_score;
}

// Namespace zm_utility/zm_utility
// Params 1, eflags: 0x0
// Checksum 0xc46b8176, Offset: 0x1b98
// Size: 0x3a
function halve_score(n_score) {
    n_score /= 2;
    n_score = round_up_score(n_score, 10);
    return n_score;
}

// Namespace zm_utility/zm_utility
// Params 7, eflags: 0x0
// Checksum 0x86286dbb, Offset: 0x1be0
// Size: 0x1d4
function create_zombie_point_of_interest(attract_dist, num_attractors, added_poi_value, start_turned_on, initial_attract_func, arrival_attract_func, poi_team) {
    if (!isdefined(added_poi_value)) {
        self.added_poi_value = 0;
    } else {
        self.added_poi_value = added_poi_value;
    }
    if (!isdefined(start_turned_on)) {
        start_turned_on = 1;
    }
    if (!isdefined(attract_dist)) {
        attract_dist = 1536;
    }
    self.script_noteworthy = "zombie_poi";
    self.poi_active = start_turned_on;
    if (isdefined(attract_dist)) {
        self.max_attractor_dist = attract_dist;
        self.poi_radius = attract_dist * attract_dist;
    } else {
        self.poi_radius = undefined;
    }
    self.num_poi_attracts = num_attractors;
    self.attract_to_origin = 1;
    self.attractor_array = [];
    self.initial_attract_func = undefined;
    self.arrival_attract_func = undefined;
    if (isdefined(poi_team)) {
        self._team = poi_team;
    }
    if (isdefined(initial_attract_func)) {
        self.initial_attract_func = initial_attract_func;
    }
    if (isdefined(arrival_attract_func)) {
        self.arrival_attract_func = arrival_attract_func;
    }
    if (!isdefined(level.zombie_poi_array)) {
        level.zombie_poi_array = [];
    } else if (!isarray(level.zombie_poi_array)) {
        level.zombie_poi_array = array(level.zombie_poi_array);
    }
    level.zombie_poi_array[level.zombie_poi_array.size] = self;
    self thread watch_for_poi_death();
}

// Namespace zm_utility/zm_utility
// Params 0, eflags: 0x0
// Checksum 0x6b68ab27, Offset: 0x1dc0
// Size: 0x54
function watch_for_poi_death() {
    self waittill(#"death");
    if (isinarray(level.zombie_poi_array, self)) {
        arrayremovevalue(level.zombie_poi_array, self);
    }
}

// Namespace zm_utility/zm_utility
// Params 0, eflags: 0x0
// Checksum 0x4de4c96f, Offset: 0x1e20
// Size: 0x132
function debug_draw_new_attractor_positions() {
    self endon(#"death");
    while (true) {
        foreach (attract in self.attractor_positions) {
            passed = bullettracepassed(attract[0] + (0, 0, 24), self.origin + (0, 0, 24), 0, self);
            if (passed) {
                /#
                    debugstar(attract[0], 6, (1, 1, 1));
                #/
                continue;
            }
            /#
                debugstar(attract[0], 6, (1, 0, 0));
            #/
        }
        waitframe(1);
    }
}

// Namespace zm_utility/zm_utility
// Params 3, eflags: 0x0
// Checksum 0x9ade1c2d, Offset: 0x1f60
// Size: 0x44c
function create_zombie_point_of_interest_attractor_positions(var_f238d4ca = 15, n_height = 60, var_7e86a3c) {
    self endon(#"death");
    if (!isdefined(self.num_poi_attracts) || isdefined(self.script_noteworthy) && self.script_noteworthy != "zombie_poi") {
        return false;
    }
    queryresult = positionquery_source_navigation(self.origin, var_f238d4ca / 2, isdefined(var_7e86a3c) ? var_7e86a3c : self.max_attractor_dist, n_height / 2, var_f238d4ca / 2, 1, var_f238d4ca / 2);
    var_c9672c88 = getclosestpointonnavmesh(self.origin);
    if (!isdefined(var_c9672c88)) {
        return false;
    }
    if (queryresult.data.size < self.num_poi_attracts) {
        self.num_poi_attracts = queryresult.data.size;
    }
    for (i = 0; i < self.num_poi_attracts; i++) {
        if (!tracepassedonnavmesh(var_c9672c88, queryresult.data[i].origin, 15)) {
            /#
                if (isdefined(level.var_72a0f44) && level.var_72a0f44) {
                    recordstar(queryresult.data[i].origin, (1, 0, 0));
                    record3dtext("<dev string:x70>", queryresult.data[i].origin + (0, 0, 8), (1, 0, 0));
                }
            #/
            continue;
        }
        if (isdefined(level.validate_poi_attractors) && level.validate_poi_attractors) {
            passed = bullettracepassed(queryresult.data[i].origin + (0, 0, 24), self.origin + (0, 0, 24), 0, self);
            if (passed) {
                self.attractor_positions[i] = queryresult.data[i].origin;
            } else {
                /#
                    if (isdefined(level.var_72a0f44) && level.var_72a0f44) {
                        recordstar(queryresult.data[i].origin, (1, 0, 0));
                        record3dtext("<dev string:x85>", queryresult.data[i].origin + (0, 0, 8), (1, 0, 0));
                    }
                #/
            }
            continue;
        }
        self.attractor_positions[i] = queryresult.data[i].origin;
        /#
            if (isdefined(level.var_72a0f44) && level.var_72a0f44) {
                recordstar(queryresult.data[i].origin, (0, 1, 0));
            }
        #/
    }
    if (!isdefined(self.attractor_positions)) {
        self.attractor_positions = [];
    }
    self.attract_to_origin = 0;
    self notify(#"attractor_positions_generated");
    level notify(#"attractor_positions_generated");
    return true;
}

// Namespace zm_utility/zm_utility
// Params 4, eflags: 0x0
// Checksum 0xe93039af, Offset: 0x23b8
// Size: 0x416
function generated_radius_attract_positions(forward, offset, num_positions, attract_radius) {
    self endon(#"death");
    failed = 0;
    degs_per_pos = 360 / num_positions;
    for (i = offset; i < 360 + offset; i += degs_per_pos) {
        altforward = forward * attract_radius;
        rotated_forward = (cos(i) * altforward[0] - sin(i) * altforward[1], sin(i) * altforward[0] + cos(i) * altforward[1], altforward[2]);
        if (isdefined(level.poi_positioning_func)) {
            pos = [[ level.poi_positioning_func ]](self.origin, rotated_forward);
        } else if (isdefined(level.use_alternate_poi_positioning) && level.use_alternate_poi_positioning) {
            pos = zm_server_throttle::server_safe_ground_trace("poi_trace", 10, self.origin + rotated_forward + (0, 0, 10));
        } else {
            pos = zm_server_throttle::server_safe_ground_trace("poi_trace", 10, self.origin + rotated_forward + (0, 0, 100));
        }
        if (!isdefined(pos)) {
            failed++;
            continue;
        }
        if (isdefined(level.use_alternate_poi_positioning) && level.use_alternate_poi_positioning) {
            if (isdefined(self) && isdefined(self.origin)) {
                if (self.origin[2] >= pos[2] - 1 && self.origin[2] - pos[2] <= 150) {
                    pos_array = [];
                    pos_array[0] = pos;
                    pos_array[1] = self;
                    if (!isdefined(self.attractor_positions)) {
                        self.attractor_positions = [];
                    } else if (!isarray(self.attractor_positions)) {
                        self.attractor_positions = array(self.attractor_positions);
                    }
                    self.attractor_positions[self.attractor_positions.size] = pos_array;
                }
            } else {
                failed++;
            }
            continue;
        }
        if (abs(pos[2] - self.origin[2]) < 60) {
            pos_array = [];
            pos_array[0] = pos;
            pos_array[1] = self;
            if (!isdefined(self.attractor_positions)) {
                self.attractor_positions = [];
            } else if (!isarray(self.attractor_positions)) {
                self.attractor_positions = array(self.attractor_positions);
            }
            self.attractor_positions[self.attractor_positions.size] = pos_array;
            continue;
        }
        failed++;
    }
    return failed;
}

/#

    // Namespace zm_utility/zm_utility
    // Params 0, eflags: 0x0
    // Checksum 0xce5ebc33, Offset: 0x27d8
    // Size: 0x9a
    function debug_draw_attractor_positions() {
        while (true) {
            while (!isdefined(self.attractor_positions)) {
                waitframe(1);
                continue;
            }
            for (i = 0; i < self.attractor_positions.size; i++) {
                line(self.origin, self.attractor_positions[i][0], (1, 0, 0), 1, 1);
            }
            waitframe(1);
            if (!isdefined(self)) {
                return;
            }
        }
    }

    // Namespace zm_utility/zm_utility
    // Params 0, eflags: 0x0
    // Checksum 0xbe91c194, Offset: 0x2880
    // Size: 0x9a
    function debug_draw_claimed_attractor_positions() {
        while (true) {
            while (!isdefined(self.claimed_attractor_positions)) {
                waitframe(1);
                continue;
            }
            for (i = 0; i < self.claimed_attractor_positions.size; i++) {
                line(self.origin, self.claimed_attractor_positions[i][0], (0, 1, 0), 1, 1);
            }
            waitframe(1);
            if (!isdefined(self)) {
                return;
            }
        }
    }

#/

// Namespace zm_utility/zm_utility
// Params 2, eflags: 0x0
// Checksum 0xfee62386, Offset: 0x2928
// Size: 0x458
function get_zombie_point_of_interest(origin, poi_array) {
    aiprofile_beginentry("get_zombie_point_of_interest");
    if (isdefined(self.ignore_all_poi) && self.ignore_all_poi) {
        aiprofile_endentry();
        return undefined;
    }
    curr_radius = undefined;
    if (isdefined(poi_array)) {
        ent_array = poi_array;
    } else {
        ent_array = level.zombie_poi_array;
    }
    best_poi = undefined;
    position = undefined;
    best_dist = 100000000;
    for (i = 0; i < ent_array.size; i++) {
        if (!isdefined(ent_array[i]) || !isdefined(ent_array[i].poi_active) || !ent_array[i].poi_active) {
            continue;
        }
        if (isdefined(self.ignore_poi_targetname) && self.ignore_poi_targetname.size > 0 && isinarray(self.ignore_poi_targetname, ent_array[i].targetname)) {
            continue;
        }
        if (isdefined(self.ignore_poi) && self.ignore_poi.size > 0 && isinarray(self.ignore_poi, ent_array[i])) {
            continue;
        }
        dist = distancesquared(origin, ent_array[i].origin);
        dist -= ent_array[i].added_poi_value;
        if (isdefined(ent_array[i].poi_radius)) {
            curr_radius = ent_array[i].poi_radius;
        }
        if ((!isdefined(curr_radius) || dist < curr_radius) && dist < best_dist && ent_array[i] can_attract(self)) {
            best_poi = ent_array[i];
            best_dist = dist;
        }
    }
    if (isdefined(best_poi)) {
        if (isdefined(best_poi._team)) {
            if (isdefined(self._race_team) && self._race_team != best_poi._team) {
                aiprofile_endentry();
                return undefined;
            }
        }
        if (isdefined(best_poi._new_ground_trace) && best_poi._new_ground_trace) {
            position = [];
            position[0] = groundpos_ignore_water_new(best_poi.origin + (0, 0, 100));
            position[1] = self;
        } else if (isdefined(best_poi.attract_to_origin) && best_poi.attract_to_origin) {
            position = [];
            position[0] = groundpos(best_poi.origin + (0, 0, 100));
            position[1] = self;
        } else {
            position = self add_poi_attractor(best_poi);
        }
        if (isdefined(best_poi.initial_attract_func)) {
            self thread [[ best_poi.initial_attract_func ]](best_poi);
        }
        if (isdefined(best_poi.arrival_attract_func)) {
            self thread [[ best_poi.arrival_attract_func ]](best_poi);
        }
    }
    aiprofile_endentry();
    return position;
}

// Namespace zm_utility/zm_utility
// Params 0, eflags: 0x0
// Checksum 0x305bc55d, Offset: 0x2d88
// Size: 0x26
function activate_zombie_point_of_interest() {
    if (self.script_noteworthy != "zombie_poi") {
        return;
    }
    self.poi_active = 1;
}

// Namespace zm_utility/zm_utility
// Params 1, eflags: 0x0
// Checksum 0xd9cad74d, Offset: 0x2db8
// Size: 0x124
function deactivate_zombie_point_of_interest(dont_remove) {
    if (!isdefined(self.script_noteworthy) || self.script_noteworthy != "zombie_poi") {
        return;
    }
    self.attractor_array = array::remove_undefined(self.attractor_array);
    for (i = 0; i < self.attractor_array.size; i++) {
        self.attractor_array[i] notify(#"kill_poi");
    }
    self.attractor_array = [];
    self.claimed_attractor_positions = [];
    self.attractor_positions = [];
    self.poi_active = 0;
    if (isdefined(dont_remove) && dont_remove) {
        return;
    }
    if (isdefined(self)) {
        if (isinarray(level.zombie_poi_array, self)) {
            arrayremovevalue(level.zombie_poi_array, self);
        }
    }
}

// Namespace zm_utility/zm_utility
// Params 2, eflags: 0x0
// Checksum 0x1ef1887d, Offset: 0x2ee8
// Size: 0x110
function assign_zombie_point_of_interest(origin, poi) {
    position = undefined;
    doremovalthread = 0;
    if (isdefined(poi) && poi can_attract(self)) {
        if (!isdefined(poi.attractor_array) || isdefined(poi.attractor_array) && !isinarray(poi.attractor_array, self)) {
            doremovalthread = 1;
        }
        position = self add_poi_attractor(poi);
        if (isdefined(position) && doremovalthread && isinarray(poi.attractor_array, self)) {
            self thread update_on_poi_removal(poi);
        }
    }
    return position;
}

// Namespace zm_utility/zm_utility
// Params 1, eflags: 0x0
// Checksum 0x3c3abb67, Offset: 0x3000
// Size: 0xe0
function remove_poi_attractor(zombie_poi) {
    if (!isdefined(zombie_poi) || !isdefined(zombie_poi.attractor_array)) {
        return;
    }
    for (i = 0; i < zombie_poi.attractor_array.size; i++) {
        if (zombie_poi.attractor_array[i] == self) {
            arrayremovevalue(zombie_poi.attractor_array, zombie_poi.attractor_array[i]);
            arrayremovevalue(zombie_poi.claimed_attractor_positions, zombie_poi.claimed_attractor_positions[i]);
            if (isdefined(self)) {
                self notify(#"kill_poi");
            }
        }
    }
}

// Namespace zm_utility/zm_utility
// Params 3, eflags: 0x0
// Checksum 0x35d59554, Offset: 0x30e8
// Size: 0x64
function array_check_for_dupes_using_compare(array, single, is_equal_fn) {
    for (i = 0; i < array.size; i++) {
        if ([[ is_equal_fn ]](array[i], single)) {
            return false;
        }
    }
    return true;
}

// Namespace zm_utility/zm_utility
// Params 2, eflags: 0x0
// Checksum 0xa62659a6, Offset: 0x3158
// Size: 0x26
function poi_locations_equal(loc1, loc2) {
    return loc1[0] == loc2[0];
}

// Namespace zm_utility/zm_utility
// Params 1, eflags: 0x0
// Checksum 0x2d743742, Offset: 0x3188
// Size: 0x410
function add_poi_attractor(zombie_poi) {
    if (!isdefined(zombie_poi)) {
        return;
    }
    if (!isdefined(zombie_poi.attractor_array)) {
        zombie_poi.attractor_array = [];
    }
    if (!isinarray(zombie_poi.attractor_array, self)) {
        if (!isdefined(zombie_poi.claimed_attractor_positions)) {
            zombie_poi.claimed_attractor_positions = [];
        }
        if (!isdefined(zombie_poi.attractor_positions) || zombie_poi.attractor_positions.size <= 0) {
            return undefined;
        }
        best_dist = 100000000;
        best_pos = undefined;
        for (i = 0; i <= zombie_poi.attractor_positions.size; i++) {
            if (!isdefined(zombie_poi.attractor_positions[i])) {
                continue;
            }
            if (!isinarray(zombie_poi.claimed_attractor_positions, zombie_poi.attractor_positions[i])) {
                if (isdefined(zombie_poi.attractor_positions[i]) && isdefined(self.origin)) {
                    dist = distancesquared(zombie_poi.attractor_positions[i], zombie_poi.origin);
                    if (dist < best_dist || !isdefined(best_pos)) {
                        best_dist = dist;
                        best_pos = zombie_poi.attractor_positions[i];
                    }
                }
            }
        }
        if (!isdefined(best_pos)) {
            if (isdefined(level.validate_poi_attractors) && level.validate_poi_attractors) {
                valid_pos = [];
                valid_pos[0] = zombie_poi.origin;
                valid_pos[1] = zombie_poi;
                return valid_pos;
            }
            return undefined;
        }
        if (!isdefined(zombie_poi.attractor_array)) {
            zombie_poi.attractor_array = [];
        } else if (!isarray(zombie_poi.attractor_array)) {
            zombie_poi.attractor_array = array(zombie_poi.attractor_array);
        }
        zombie_poi.attractor_array[zombie_poi.attractor_array.size] = self;
        self thread update_poi_on_death(zombie_poi);
        if (!isdefined(zombie_poi.claimed_attractor_positions)) {
            zombie_poi.claimed_attractor_positions = [];
        } else if (!isarray(zombie_poi.claimed_attractor_positions)) {
            zombie_poi.claimed_attractor_positions = array(zombie_poi.claimed_attractor_positions);
        }
        zombie_poi.claimed_attractor_positions[zombie_poi.claimed_attractor_positions.size] = best_pos;
        return array(best_pos, zombie_poi);
    } else {
        for (i = 0; i < zombie_poi.attractor_array.size; i++) {
            if (zombie_poi.attractor_array[i] == self) {
                if (isdefined(zombie_poi.claimed_attractor_positions) && isdefined(zombie_poi.claimed_attractor_positions[i])) {
                    return array(zombie_poi.claimed_attractor_positions[i], zombie_poi);
                }
            }
        }
    }
    return undefined;
}

// Namespace zm_utility/zm_utility
// Params 1, eflags: 0x0
// Checksum 0xf9118f48, Offset: 0x35a0
// Size: 0xa6
function can_attract(attractor) {
    if (!isdefined(self.attractor_array)) {
        self.attractor_array = [];
    }
    if (isdefined(self.attracted_array) && !isinarray(self.attracted_array, attractor)) {
        return false;
    }
    if (isinarray(self.attractor_array, attractor)) {
        return true;
    }
    if (isdefined(self.num_poi_attracts) && self.attractor_array.size >= self.num_poi_attracts) {
        return false;
    }
    return true;
}

// Namespace zm_utility/zm_utility
// Params 1, eflags: 0x0
// Checksum 0xf9d8b78a, Offset: 0x3650
// Size: 0x4c
function update_poi_on_death(zombie_poi) {
    self endon(#"kill_poi");
    self waittill(#"death");
    self remove_poi_attractor(zombie_poi);
}

// Namespace zm_utility/zm_utility
// Params 1, eflags: 0x0
// Checksum 0xd962322d, Offset: 0x36a8
// Size: 0xb6
function update_on_poi_removal(zombie_poi) {
    zombie_poi waittill(#"death");
    if (!isdefined(zombie_poi.attractor_array)) {
        return;
    }
    for (i = 0; i < zombie_poi.attractor_array.size; i++) {
        if (zombie_poi.attractor_array[i] == self) {
            arrayremoveindex(zombie_poi.attractor_array, i);
            arrayremoveindex(zombie_poi.claimed_attractor_positions, i);
        }
    }
}

// Namespace zm_utility/zm_utility
// Params 2, eflags: 0x0
// Checksum 0xe2c16b05, Offset: 0x3768
// Size: 0x192
function invalidate_attractor_pos(attractor_pos, zombie) {
    if (!isdefined(self) || !isdefined(attractor_pos)) {
        wait 0.1;
        return undefined;
    }
    if (isdefined(self.attractor_positions) && !array_check_for_dupes_using_compare(self.attractor_positions, attractor_pos, &poi_locations_equal)) {
        index = 0;
        for (i = 0; i < self.attractor_positions.size; i++) {
            if (poi_locations_equal(self.attractor_positions[i], attractor_pos)) {
                index = i;
            }
        }
        arrayremovevalue(self.attractor_array, zombie);
        arrayremovevalue(self.attractor_positions, attractor_pos);
        for (i = 0; i < self.claimed_attractor_positions.size; i++) {
            if (self.claimed_attractor_positions[i][0] == attractor_pos[0]) {
                arrayremovevalue(self.claimed_attractor_positions, self.claimed_attractor_positions[i]);
            }
        }
    } else {
        wait 0.1;
    }
    return get_zombie_point_of_interest(zombie.origin);
}

// Namespace zm_utility/zm_utility
// Params 1, eflags: 0x0
// Checksum 0x7982de5, Offset: 0x3908
// Size: 0x90
function remove_poi_from_ignore_list(poi) {
    if (isdefined(self.ignore_poi) && self.ignore_poi.size > 0) {
        for (i = 0; i < self.ignore_poi.size; i++) {
            if (self.ignore_poi[i] == poi) {
                arrayremovevalue(self.ignore_poi, self.ignore_poi[i]);
                return;
            }
        }
    }
}

// Namespace zm_utility/zm_utility
// Params 1, eflags: 0x0
// Checksum 0xe8cd0dd5, Offset: 0x39a0
// Size: 0xae
function add_poi_to_ignore_list(poi) {
    if (!isdefined(self.ignore_poi)) {
        self.ignore_poi = [];
    }
    add_poi = 1;
    if (self.ignore_poi.size > 0) {
        for (i = 0; i < self.ignore_poi.size; i++) {
            if (self.ignore_poi[i] == poi) {
                add_poi = 0;
                break;
            }
        }
    }
    if (add_poi) {
        self.ignore_poi[self.ignore_poi.size] = poi;
    }
}

// Namespace zm_utility/zm_utility
// Params 1, eflags: 0x0
// Checksum 0x61251876, Offset: 0x3a58
// Size: 0x54
function default_validate_enemy_path_length(player) {
    d = distancesquared(self.origin, player.origin);
    if (d <= 1296) {
        return true;
    }
    return false;
}

// Namespace zm_utility/zm_utility
// Params 1, eflags: 0x0
// Checksum 0x7d28323f, Offset: 0x3ab8
// Size: 0xca
function function_81bbcc91(archetype) {
    if (!isdefined(level.var_96b05454)) {
        level.var_96b05454 = [];
    }
    if (!isdefined(level.var_96b05454)) {
        level.var_96b05454 = [];
    } else if (!isarray(level.var_96b05454)) {
        level.var_96b05454 = array(level.var_96b05454);
    }
    if (!isinarray(level.var_96b05454, archetype)) {
        level.var_96b05454[level.var_96b05454.size] = archetype;
    }
}

// Namespace zm_utility/zm_utility
// Params 0, eflags: 0x0
// Checksum 0xafa97665, Offset: 0x3b90
// Size: 0x238
function function_ff0f610d() {
    level waittill(#"start_of_round");
    while (true) {
        reset_closest_player = 1;
        zombies = [];
        if (isdefined(level.var_96b05454)) {
            foreach (archetype in level.var_96b05454) {
                ai = getaiarchetypearray(archetype, level.zombie_team);
                if (ai.size) {
                    zombies = arraycombine(zombies, ai, 0, 0);
                }
            }
        }
        foreach (zombie in zombies) {
            if (isdefined(zombie.need_closest_player) && zombie.need_closest_player) {
                reset_closest_player = 0;
                zombie.var_9ba3bab6 = undefined;
                break;
            }
            zombie.var_9ba3bab6 = undefined;
        }
        if (reset_closest_player) {
            foreach (zombie in zombies) {
                if (isdefined(zombie.need_closest_player)) {
                    zombie.need_closest_player = 1;
                    /#
                        zombie.var_bdbf35e5 = undefined;
                    #/
                }
            }
        }
        waitframe(1);
    }
}

// Namespace zm_utility/zm_utility
// Params 1, eflags: 0x4
// Checksum 0x40a96079, Offset: 0x3dd0
// Size: 0xea
function private function_221d7006(players) {
    if (isdefined(self.last_closest_player) && isdefined(self.last_closest_player.am_i_valid) && self.last_closest_player.am_i_valid) {
        return;
    }
    self.need_closest_player = 1;
    foreach (player in players) {
        if (isdefined(player.am_i_valid) && player.am_i_valid) {
            self.last_closest_player = player;
            return;
        }
    }
    self.last_closest_player = undefined;
}

// Namespace zm_utility/zm_utility
// Params 2, eflags: 0x0
// Checksum 0x95211533, Offset: 0x3ec8
// Size: 0x4ba
function function_87d568c4(origin, players) {
    if (players.size == 0) {
        return undefined;
    }
    if (isdefined(self.zombie_poi)) {
        return undefined;
    }
    if (players.size == 1) {
        self.last_closest_player = players[0];
        self.var_abbcbd32 = distancesquared(players[0].origin, origin);
        return self.last_closest_player;
    }
    if (!isdefined(self.last_closest_player)) {
        self.last_closest_player = players[0];
    }
    if (!isdefined(self.need_closest_player)) {
        self.need_closest_player = 1;
    }
    level.last_closest_time = level.time;
    self.need_closest_player = 0;
    var_98d1c791 = spawnstruct();
    var_98d1c791.height = self function_5c52d4ac();
    var_98d1c791.radius = self getpathfindingradius();
    var_98d1c791.origin = origin;
    if (isdefined(self.var_12d658d7)) {
        playerpositions = self [[ self.var_12d658d7 ]](origin, players);
    } else {
        playerpositions = [];
        foreach (player in players) {
            player_pos = player.last_valid_position;
            if (!isdefined(player_pos)) {
                player_pos = getclosestpointonnavmesh(player.origin, 100, var_98d1c791.radius);
                if (!isdefined(player_pos)) {
                    continue;
                }
            }
            if (var_98d1c791.radius > player getpathfindingradius()) {
                player_pos = getclosestpointonnavmesh(player.origin, 100, var_98d1c791.radius);
            }
            if (!isdefined(playerpositions)) {
                playerpositions = [];
            } else if (!isarray(playerpositions)) {
                playerpositions = array(playerpositions);
            }
            playerpositions[playerpositions.size] = isdefined(player_pos) ? player_pos : player.origin;
        }
    }
    closestplayer = undefined;
    self.var_abbcbd32 = undefined;
    if (ispointonnavmesh(var_98d1c791.origin, self)) {
        pathdata = generatenavmeshpath(var_98d1c791.origin, playerpositions, self);
        if (isdefined(pathdata) && pathdata.status === "succeeded") {
            goalpos = pathdata.pathpoints[pathdata.pathpoints.size - 1];
            foreach (index, position in playerpositions) {
                if (distancesquared(position, goalpos) < 16 * 16) {
                    closestplayer = players[index];
                    break;
                }
            }
        }
    }
    /#
        self.var_bdbf35e5 = gettime();
    #/
    self.last_closest_player = closestplayer;
    if (isdefined(closestplayer)) {
        self.var_abbcbd32 = pathdata.pathdistance * pathdata.pathdistance;
    }
    self function_221d7006(players);
    return self.last_closest_player;
}

// Namespace zm_utility/zm_utility
// Params 3, eflags: 0x0
// Checksum 0x564d9302, Offset: 0x4390
// Size: 0x460
function get_closest_valid_player(origin, ignore_player = array(), var_53af44d = 0) {
    aiprofile_beginentry("get_closest_valid_player");
    players = getplayers();
    if (isdefined(level.zombie_targets) && level.zombie_targets.size > 0) {
        function_526005d6(level.zombie_targets);
        arrayremovevalue(level.zombie_targets, undefined);
        players = arraycombine(players, level.zombie_targets, 0, 0);
    }
    b_designated_target_exists = 0;
    foreach (player in players) {
        if (!player.am_i_valid) {
            continue;
        }
        if (isdefined(level.var_59b7b808)) {
            if (![[ level.var_59b7b808 ]](player)) {
                array::add(ignore_player, player);
            }
        }
        if (isdefined(player.b_is_designated_target) && player.b_is_designated_target) {
            b_designated_target_exists = 1;
        }
        if (isdefined(level.var_c69b1b9b)) {
            if (![[ level.var_c69b1b9b ]](player)) {
                array::add(ignore_player, player);
            }
        }
    }
    if (isdefined(ignore_player)) {
        foreach (ignored_player in ignore_player) {
            arrayremovevalue(players, ignored_player);
        }
    }
    done = 0;
    while (players.size && !done) {
        done = 1;
        for (i = 0; i < players.size; i++) {
            player = players[i];
            if (!player.am_i_valid) {
                arrayremovevalue(players, player);
                done = 0;
                break;
            }
            if (b_designated_target_exists && !(isdefined(player.b_is_designated_target) && player.b_is_designated_target)) {
                arrayremovevalue(players, player);
                done = 0;
                break;
            }
        }
    }
    if (players.size == 0) {
        aiprofile_endentry();
        return undefined;
    }
    if (!var_53af44d && isdefined(self.closest_player_override)) {
        player = [[ self.closest_player_override ]](origin, players);
    } else if (!var_53af44d && isdefined(level.closest_player_override)) {
        player = [[ level.closest_player_override ]](origin, players);
    } else {
        player = arraygetclosest(origin, players);
    }
    if (!isdefined(player)) {
        aiprofile_endentry();
        return undefined;
    }
    aiprofile_endentry();
    return player;
}

// Namespace zm_utility/zm_utility
// Params 2, eflags: 0x0
// Checksum 0xd6be78d7, Offset: 0x47f8
// Size: 0x344
function update_valid_players(origin, ignore_player) {
    aiprofile_beginentry("update_valid_players");
    players = arraycopy(level.players);
    foreach (player in players) {
        self setignoreent(player, 1);
    }
    b_designated_target_exists = 0;
    for (i = 0; i < players.size; i++) {
        player = players[i];
        if (!player.am_i_valid) {
            continue;
        }
        if (isdefined(level.var_59b7b808)) {
            if (![[ level.var_59b7b808 ]](player)) {
                array::add(ignore_player, player);
            }
        }
        if (isdefined(player.b_is_designated_target) && player.b_is_designated_target) {
            b_designated_target_exists = 1;
        }
    }
    if (isdefined(ignore_player)) {
        for (i = 0; i < ignore_player.size; i++) {
            arrayremovevalue(players, ignore_player[i]);
        }
    }
    done = 0;
    while (players.size && !done) {
        done = 1;
        for (i = 0; i < players.size; i++) {
            player = players[i];
            if (!player.am_i_valid) {
                arrayremovevalue(players, player);
                done = 0;
                break;
            }
            if (b_designated_target_exists && !(isdefined(player.b_is_designated_target) && player.b_is_designated_target)) {
                arrayremovevalue(players, player);
                done = 0;
                break;
            }
        }
    }
    foreach (player in players) {
        self setignoreent(player, 0);
        self getperfectinfo(player);
    }
    aiprofile_endentry();
}

// Namespace zm_utility/zm_utility
// Params 4, eflags: 0x0
// Checksum 0xc20104be, Offset: 0x4b48
// Size: 0x1a0
function is_player_valid(e_player, var_de778006 = 0, var_4aace1d7 = 0, var_45dcc2fc = 1) {
    if (!isalive(e_player)) {
        return 0;
    }
    if (!isplayer(e_player)) {
        return 0;
    }
    if (isdefined(e_player.is_zombie) && e_player.is_zombie) {
        return 0;
    }
    if (e_player.sessionstate == "spectator" || e_player.sessionstate == "intermission") {
        return 0;
    }
    if (isdefined(level.intermission) && level.intermission) {
        return 0;
    }
    if (!var_4aace1d7) {
        if (e_player laststand::player_is_in_laststand()) {
            return 0;
        }
    }
    if (var_de778006) {
        if (e_player.ignoreme || e_player isnotarget()) {
            return 0;
        }
    }
    if (!var_45dcc2fc) {
        if (e_player isplayerunderwater()) {
            return 0;
        }
    }
    if (isdefined(level.is_player_valid_override)) {
        return [[ level.is_player_valid_override ]](e_player);
    }
    return 1;
}

// Namespace zm_utility/zm_utility
// Params 0, eflags: 0x0
// Checksum 0x784aebc2, Offset: 0x4cf0
// Size: 0x82
function get_number_of_valid_players() {
    players = getplayers();
    num_player_valid = 0;
    for (i = 0; i < players.size; i++) {
        if (is_player_valid(players[i])) {
            num_player_valid += 1;
        }
    }
    return num_player_valid;
}

// Namespace zm_utility/zm_utility
// Params 0, eflags: 0x0
// Checksum 0x2b81f2df, Offset: 0x4d80
// Size: 0xf8
function in_revive_trigger() {
    if (isdefined(self.rt_time) && self.rt_time + 100 >= gettime()) {
        return self.in_rt_cached;
    }
    self.rt_time = gettime();
    players = level.players;
    for (i = 0; i < players.size; i++) {
        current_player = players[i];
        if (isdefined(current_player) && isdefined(current_player.revivetrigger) && isalive(current_player)) {
            if (self istouching(current_player.revivetrigger)) {
                self.in_rt_cached = 1;
                return 1;
            }
        }
    }
    self.in_rt_cached = 0;
    return 0;
}

// Namespace zm_utility/zm_utility
// Params 2, eflags: 0x0
// Checksum 0xf5d94da1, Offset: 0x4e80
// Size: 0x506
function non_destroyed_bar_board_order(origin, chunks) {
    first_bars = [];
    first_bars1 = [];
    first_bars2 = [];
    for (i = 0; i < chunks.size; i++) {
        if (isdefined(chunks[i].script_team) && chunks[i].script_team == "classic_boards") {
            if (isdefined(chunks[i].script_parameters) && chunks[i].script_parameters == "board") {
                return get_closest_2d(origin, chunks);
            } else if (isdefined(chunks[i].script_team) && chunks[i].script_team == "bar_board_variant1" || chunks[i].script_team == "bar_board_variant2" || chunks[i].script_team == "bar_board_variant4" || chunks[i].script_team == "bar_board_variant5") {
                return undefined;
            }
            continue;
        }
        if (isdefined(chunks[i].script_team) && chunks[i].script_team == "new_barricade") {
            if (isdefined(chunks[i].script_parameters) && (chunks[i].script_parameters == "repair_board" || chunks[i].script_parameters == "barricade_vents")) {
                return get_closest_2d(origin, chunks);
            }
        }
    }
    for (i = 0; i < chunks.size; i++) {
        if (isdefined(chunks[i].script_team) && chunks[i].script_team == "6_bars_bent" || chunks[i].script_team == "6_bars_prestine") {
            if (isdefined(chunks[i].script_parameters) && chunks[i].script_parameters == "bar") {
                if (isdefined(chunks[i].script_noteworthy)) {
                    if (chunks[i].script_noteworthy == "4" || chunks[i].script_noteworthy == "6") {
                        first_bars[first_bars.size] = chunks[i];
                    }
                }
            }
        }
    }
    for (i = 0; i < first_bars.size; i++) {
        if (isdefined(chunks[i].script_team) && chunks[i].script_team == "6_bars_bent" || chunks[i].script_team == "6_bars_prestine") {
            if (isdefined(chunks[i].script_parameters) && chunks[i].script_parameters == "bar") {
                if (!first_bars[i].destroyed) {
                    return first_bars[i];
                }
            }
        }
    }
    for (i = 0; i < chunks.size; i++) {
        if (isdefined(chunks[i].script_team) && chunks[i].script_team == "6_bars_bent" || chunks[i].script_team == "6_bars_prestine") {
            if (isdefined(chunks[i].script_parameters) && chunks[i].script_parameters == "bar") {
                if (!chunks[i].destroyed) {
                    return get_closest_2d(origin, chunks);
                }
            }
        }
    }
}

// Namespace zm_utility/zm_utility
// Params 2, eflags: 0x0
// Checksum 0x789d1a48, Offset: 0x5390
// Size: 0x532
function non_destroyed_grate_order(origin, chunks_grate) {
    grate_order = [];
    grate_order1 = [];
    grate_order2 = [];
    grate_order3 = [];
    grate_order4 = [];
    grate_order5 = [];
    grate_order6 = [];
    if (isdefined(chunks_grate)) {
        for (i = 0; i < chunks_grate.size; i++) {
            if (isdefined(chunks_grate[i].script_parameters) && chunks_grate[i].script_parameters == "grate") {
                if (isdefined(chunks_grate[i].script_noteworthy) && chunks_grate[i].script_noteworthy == "1") {
                    grate_order1[grate_order1.size] = chunks_grate[i];
                }
                if (isdefined(chunks_grate[i].script_noteworthy) && chunks_grate[i].script_noteworthy == "2") {
                    grate_order2[grate_order2.size] = chunks_grate[i];
                }
                if (isdefined(chunks_grate[i].script_noteworthy) && chunks_grate[i].script_noteworthy == "3") {
                    grate_order3[grate_order3.size] = chunks_grate[i];
                }
                if (isdefined(chunks_grate[i].script_noteworthy) && chunks_grate[i].script_noteworthy == "4") {
                    grate_order4[grate_order4.size] = chunks_grate[i];
                }
                if (isdefined(chunks_grate[i].script_noteworthy) && chunks_grate[i].script_noteworthy == "5") {
                    grate_order5[grate_order5.size] = chunks_grate[i];
                }
                if (isdefined(chunks_grate[i].script_noteworthy) && chunks_grate[i].script_noteworthy == "6") {
                    grate_order6[grate_order6.size] = chunks_grate[i];
                }
            }
        }
        for (i = 0; i < chunks_grate.size; i++) {
            if (isdefined(chunks_grate[i].script_parameters) && chunks_grate[i].script_parameters == "grate") {
                if (isdefined(grate_order1[i])) {
                    if (grate_order1[i].state == "repaired") {
                        grate_order2[i] thread show_grate_pull();
                        return grate_order1[i];
                    }
                    if (grate_order2[i].state == "repaired") {
                        /#
                            iprintlnbold("<dev string:x99>");
                        #/
                        grate_order3[i] thread show_grate_pull();
                        return grate_order2[i];
                    }
                    if (grate_order3[i].state == "repaired") {
                        /#
                            iprintlnbold("<dev string:xa5>");
                        #/
                        grate_order4[i] thread show_grate_pull();
                        return grate_order3[i];
                    }
                    if (grate_order4[i].state == "repaired") {
                        /#
                            iprintlnbold("<dev string:xb1>");
                        #/
                        grate_order5[i] thread show_grate_pull();
                        return grate_order4[i];
                    }
                    if (grate_order5[i].state == "repaired") {
                        /#
                            iprintlnbold("<dev string:xbd>");
                        #/
                        grate_order6[i] thread show_grate_pull();
                        return grate_order5[i];
                    }
                    if (grate_order6[i].state == "repaired") {
                        return grate_order6[i];
                    }
                }
            }
        }
    }
}

// Namespace zm_utility/zm_utility
// Params 0, eflags: 0x0
// Checksum 0xa7f3676c, Offset: 0x58d0
// Size: 0x5c
function show_grate_pull() {
    wait 0.53;
    self show();
    self vibrate((0, 270, 0), 0.2, 0.4, 0.4);
}

// Namespace zm_utility/zm_utility
// Params 2, eflags: 0x0
// Checksum 0x1d08524b, Offset: 0x5938
// Size: 0x1f0
function get_closest_2d(origin, ents) {
    if (!isdefined(ents)) {
        return undefined;
    }
    dist = distance2d(origin, ents[0].origin);
    index = 0;
    temp_array = [];
    for (i = 1; i < ents.size; i++) {
        if (isdefined(ents[i].unbroken) && ents[i].unbroken == 1) {
            ents[i].index = i;
            if (!isdefined(temp_array)) {
                temp_array = [];
            } else if (!isarray(temp_array)) {
                temp_array = array(temp_array);
            }
            temp_array[temp_array.size] = ents[i];
        }
    }
    if (temp_array.size > 0) {
        index = temp_array[randomintrange(0, temp_array.size)].index;
        return ents[index];
    }
    for (i = 1; i < ents.size; i++) {
        temp_dist = distance2d(origin, ents[i].origin);
        if (temp_dist < dist) {
            dist = temp_dist;
            index = i;
        }
    }
    return ents[index];
}

// Namespace zm_utility/zm_utility
// Params 0, eflags: 0x0
// Checksum 0xeb6053, Offset: 0x5b30
// Size: 0x1a0
function in_playable_area() {
    if (function_be4cf12d() && !isdefined(level.var_4b530519)) {
        level.var_4b530519 = getnodearray("player_region", "script_noteworthy");
    }
    if (function_a70772a9() && !isdefined(level.playable_area)) {
        level.playable_area = getentarray("player_volume", "script_noteworthy");
    }
    if (!isdefined(level.playable_area) && !isdefined(level.var_4b530519)) {
        println("<dev string:xc9>");
        return true;
    }
    if (isdefined(level.var_4b530519)) {
        node = function_e910fb8c(self.origin, level.var_4b530519, 500);
        if (isdefined(node)) {
            return true;
        }
    }
    if (isdefined(level.playable_area)) {
        for (i = 0; i < level.playable_area.size; i++) {
            if (self istouching(level.playable_area[i])) {
                return true;
            }
        }
    }
    return false;
}

// Namespace zm_utility/zm_utility
// Params 3, eflags: 0x0
// Checksum 0x85fb6b16, Offset: 0x5cd8
// Size: 0x10e
function get_closest_non_destroyed_chunk(origin, barrier, barrier_chunks) {
    chunks = undefined;
    chunks_grate = undefined;
    chunks_grate = get_non_destroyed_chunks_grate(barrier, barrier_chunks);
    chunks = get_non_destroyed_chunks(barrier, barrier_chunks);
    if (isdefined(barrier.zbarrier)) {
        if (isdefined(chunks)) {
            return array::randomize(chunks)[0];
        }
        if (isdefined(chunks_grate)) {
            return array::randomize(chunks_grate)[0];
        }
    } else if (isdefined(chunks)) {
        return non_destroyed_bar_board_order(origin, chunks);
    } else if (isdefined(chunks_grate)) {
        return non_destroyed_grate_order(origin, chunks_grate);
    }
    return undefined;
}

// Namespace zm_utility/zm_utility
// Params 2, eflags: 0x0
// Checksum 0xb44d7ebf, Offset: 0x5df0
// Size: 0x118
function get_random_destroyed_chunk(barrier, barrier_chunks) {
    if (isdefined(barrier.zbarrier)) {
        ret = undefined;
        pieces = barrier.zbarrier getzbarrierpieceindicesinstate("open");
        if (pieces.size) {
            ret = array::randomize(pieces)[0];
        }
        return ret;
    }
    chunks_repair_grate = undefined;
    chunks = get_destroyed_chunks(barrier_chunks);
    chunks_repair_grate = get_destroyed_repair_grates(barrier_chunks);
    if (isdefined(chunks)) {
        return chunks[randomint(chunks.size)];
    } else if (isdefined(chunks_repair_grate)) {
        return grate_order_destroyed(chunks_repair_grate);
    }
    return undefined;
}

// Namespace zm_utility/zm_utility
// Params 1, eflags: 0x0
// Checksum 0xcdbbf10c, Offset: 0x5f10
// Size: 0xb6
function get_destroyed_repair_grates(barrier_chunks) {
    array = [];
    for (i = 0; i < barrier_chunks.size; i++) {
        if (isdefined(barrier_chunks[i])) {
            if (isdefined(barrier_chunks[i].script_parameters) && barrier_chunks[i].script_parameters == "grate") {
                array[array.size] = barrier_chunks[i];
            }
        }
    }
    if (array.size == 0) {
        return undefined;
    }
    return array;
}

// Namespace zm_utility/zm_utility
// Params 2, eflags: 0x0
// Checksum 0x5edc85a9, Offset: 0x5fd0
// Size: 0x42a
function get_non_destroyed_chunks(barrier, barrier_chunks) {
    if (isdefined(barrier.zbarrier)) {
        return barrier.zbarrier getzbarrierpieceindicesinstate("closed");
    }
    array = [];
    for (i = 0; i < barrier_chunks.size; i++) {
        if (isdefined(barrier_chunks[i].script_team) && barrier_chunks[i].script_team == "classic_boards") {
            if (isdefined(barrier_chunks[i].script_parameters) && barrier_chunks[i].script_parameters == "board") {
                if (barrier_chunks[i] get_chunk_state() == "repaired") {
                    if (barrier_chunks[i].origin == barrier_chunks[i].og_origin) {
                        array[array.size] = barrier_chunks[i];
                    }
                }
            }
        }
        if (isdefined(barrier_chunks[i].script_team) && barrier_chunks[i].script_team == "new_barricade") {
            if (isdefined(barrier_chunks[i].script_parameters) && (barrier_chunks[i].script_parameters == "repair_board" || barrier_chunks[i].script_parameters == "barricade_vents")) {
                if (barrier_chunks[i] get_chunk_state() == "repaired") {
                    if (barrier_chunks[i].origin == barrier_chunks[i].og_origin) {
                        array[array.size] = barrier_chunks[i];
                    }
                }
            }
            continue;
        }
        if (isdefined(barrier_chunks[i].script_team) && barrier_chunks[i].script_team == "6_bars_bent") {
            if (isdefined(barrier_chunks[i].script_parameters) && barrier_chunks[i].script_parameters == "bar") {
                if (barrier_chunks[i] get_chunk_state() == "repaired") {
                    if (barrier_chunks[i].origin == barrier_chunks[i].og_origin) {
                        array[array.size] = barrier_chunks[i];
                    }
                }
            }
            continue;
        }
        if (isdefined(barrier_chunks[i].script_team) && barrier_chunks[i].script_team == "6_bars_prestine") {
            if (isdefined(barrier_chunks[i].script_parameters) && barrier_chunks[i].script_parameters == "bar") {
                if (barrier_chunks[i] get_chunk_state() == "repaired") {
                    if (barrier_chunks[i].origin == barrier_chunks[i].og_origin) {
                        array[array.size] = barrier_chunks[i];
                    }
                }
            }
        }
    }
    if (array.size == 0) {
        return undefined;
    }
    return array;
}

// Namespace zm_utility/zm_utility
// Params 2, eflags: 0x0
// Checksum 0x2c354908, Offset: 0x6408
// Size: 0xfc
function get_non_destroyed_chunks_grate(barrier, barrier_chunks) {
    if (isdefined(barrier.zbarrier)) {
        return barrier.zbarrier getzbarrierpieceindicesinstate("closed");
    }
    array = [];
    for (i = 0; i < barrier_chunks.size; i++) {
        if (isdefined(barrier_chunks[i].script_parameters) && barrier_chunks[i].script_parameters == "grate") {
            if (isdefined(barrier_chunks[i])) {
                array[array.size] = barrier_chunks[i];
            }
        }
    }
    if (array.size == 0) {
        return undefined;
    }
    return array;
}

// Namespace zm_utility/zm_utility
// Params 1, eflags: 0x0
// Checksum 0x9a354680, Offset: 0x6510
// Size: 0x1da
function get_destroyed_chunks(barrier_chunks) {
    array = [];
    for (i = 0; i < barrier_chunks.size; i++) {
        if (barrier_chunks[i] get_chunk_state() == "destroyed") {
            if (isdefined(barrier_chunks[i].script_parameters) && barrier_chunks[i].script_parameters == "board") {
                array[array.size] = barrier_chunks[i];
                continue;
            }
            if (isdefined(barrier_chunks[i].script_parameters) && barrier_chunks[i].script_parameters == "repair_board" || barrier_chunks[i].script_parameters == "barricade_vents") {
                array[array.size] = barrier_chunks[i];
                continue;
            }
            if (isdefined(barrier_chunks[i].script_parameters) && barrier_chunks[i].script_parameters == "bar") {
                array[array.size] = barrier_chunks[i];
                continue;
            }
            if (isdefined(barrier_chunks[i].script_parameters) && barrier_chunks[i].script_parameters == "grate") {
                return undefined;
            }
        }
    }
    if (array.size == 0) {
        return undefined;
    }
    return array;
}

// Namespace zm_utility/zm_utility
// Params 1, eflags: 0x0
// Checksum 0xe5931c3b, Offset: 0x66f8
// Size: 0x55a
function grate_order_destroyed(chunks_repair_grate) {
    grate_repair_order = [];
    grate_repair_order1 = [];
    grate_repair_order2 = [];
    grate_repair_order3 = [];
    grate_repair_order4 = [];
    grate_repair_order5 = [];
    grate_repair_order6 = [];
    for (i = 0; i < chunks_repair_grate.size; i++) {
        if (isdefined(chunks_repair_grate[i].script_parameters) && chunks_repair_grate[i].script_parameters == "grate") {
            if (isdefined(chunks_repair_grate[i].script_noteworthy) && chunks_repair_grate[i].script_noteworthy == "1") {
                grate_repair_order1[grate_repair_order1.size] = chunks_repair_grate[i];
            }
            if (isdefined(chunks_repair_grate[i].script_noteworthy) && chunks_repair_grate[i].script_noteworthy == "2") {
                grate_repair_order2[grate_repair_order2.size] = chunks_repair_grate[i];
            }
            if (isdefined(chunks_repair_grate[i].script_noteworthy) && chunks_repair_grate[i].script_noteworthy == "3") {
                grate_repair_order3[grate_repair_order3.size] = chunks_repair_grate[i];
            }
            if (isdefined(chunks_repair_grate[i].script_noteworthy) && chunks_repair_grate[i].script_noteworthy == "4") {
                grate_repair_order4[grate_repair_order4.size] = chunks_repair_grate[i];
            }
            if (isdefined(chunks_repair_grate[i].script_noteworthy) && chunks_repair_grate[i].script_noteworthy == "5") {
                grate_repair_order5[grate_repair_order5.size] = chunks_repair_grate[i];
            }
            if (isdefined(chunks_repair_grate[i].script_noteworthy) && chunks_repair_grate[i].script_noteworthy == "6") {
                grate_repair_order6[grate_repair_order6.size] = chunks_repair_grate[i];
            }
        }
    }
    for (i = 0; i < chunks_repair_grate.size; i++) {
        if (isdefined(chunks_repair_grate[i].script_parameters) && chunks_repair_grate[i].script_parameters == "grate") {
            if (isdefined(grate_repair_order1[i])) {
                if (grate_repair_order6[i].state == "destroyed") {
                    /#
                        iprintlnbold("<dev string:x10d>");
                    #/
                    return grate_repair_order6[i];
                }
                if (grate_repair_order5[i].state == "destroyed") {
                    /#
                        iprintlnbold("<dev string:x11a>");
                    #/
                    grate_repair_order6[i] thread show_grate_repair();
                    return grate_repair_order5[i];
                }
                if (grate_repair_order4[i].state == "destroyed") {
                    /#
                        iprintlnbold("<dev string:x127>");
                    #/
                    grate_repair_order5[i] thread show_grate_repair();
                    return grate_repair_order4[i];
                }
                if (grate_repair_order3[i].state == "destroyed") {
                    /#
                        iprintlnbold("<dev string:x134>");
                    #/
                    grate_repair_order4[i] thread show_grate_repair();
                    return grate_repair_order3[i];
                }
                if (grate_repair_order2[i].state == "destroyed") {
                    /#
                        iprintlnbold("<dev string:x141>");
                    #/
                    grate_repair_order3[i] thread show_grate_repair();
                    return grate_repair_order2[i];
                }
                if (grate_repair_order1[i].state == "destroyed") {
                    /#
                        iprintlnbold("<dev string:x14e>");
                    #/
                    grate_repair_order2[i] thread show_grate_repair();
                    return grate_repair_order1[i];
                }
            }
        }
    }
}

// Namespace zm_utility/zm_utility
// Params 0, eflags: 0x0
// Checksum 0x39594627, Offset: 0x6c60
// Size: 0x24
function show_grate_repair() {
    wait 0.34;
    self hide();
}

// Namespace zm_utility/zm_utility
// Params 0, eflags: 0x0
// Checksum 0x899a093e, Offset: 0x6c90
// Size: 0x2a
function get_chunk_state() {
    assert(isdefined(self.state));
    return self.state;
}

// Namespace zm_utility/zm_utility
// Params 2, eflags: 0x0
// Checksum 0x472722ed, Offset: 0x6cc8
// Size: 0x150
function fake_physicslaunch(target_pos, power) {
    start_pos = self.origin;
    gravity = getdvarint(#"bg_gravity", 0) * -1;
    dist = distance(start_pos, target_pos);
    time = dist / power;
    delta = target_pos - start_pos;
    drop = 0.5 * gravity * time * time;
    velocity = (delta[0] / time, delta[1] / time, (delta[2] - drop) / time);
    /#
        level thread draw_line_ent_to_pos(self, target_pos);
    #/
    self movegravity(velocity, time);
    return time;
}

// Namespace zm_utility/zm_utility
// Params 2, eflags: 0x0
// Checksum 0x33f0ebef, Offset: 0x6e20
// Size: 0x4a
function add_zombie_hint(ref, text) {
    if (!isdefined(level.zombie_hints)) {
        level.zombie_hints = [];
    }
    level.zombie_hints[ref] = text;
}

// Namespace zm_utility/zm_utility
// Params 1, eflags: 0x0
// Checksum 0xce20472e, Offset: 0x6e78
// Size: 0x6c
function get_zombie_hint(ref) {
    if (isdefined(level.zombie_hints[ref])) {
        return level.zombie_hints[ref];
    }
    println("<dev string:x15b>" + ref);
    return level.zombie_hints[#"undefined"];
}

// Namespace zm_utility/zm_utility
// Params 3, eflags: 0x0
// Checksum 0x8176c651, Offset: 0x6ef0
// Size: 0xa4
function set_hint_string(ent, default_ref, cost) {
    ref = default_ref;
    if (isdefined(ent.script_hint)) {
        ref = ent.script_hint;
    }
    hint = get_zombie_hint(ref);
    if (isdefined(cost)) {
        self sethintstring(hint, cost);
        return;
    }
    self sethintstring(hint);
}

// Namespace zm_utility/zm_utility
// Params 3, eflags: 0x0
// Checksum 0xa8e5cf2c, Offset: 0x6fa0
// Size: 0x5a
function get_hint_string(ent, default_ref, cost) {
    ref = default_ref;
    if (isdefined(ent.script_hint)) {
        ref = ent.script_hint;
    }
    return get_zombie_hint(ref);
}

// Namespace zm_utility/zm_utility
// Params 2, eflags: 0x0
// Checksum 0xe34786be, Offset: 0x7008
// Size: 0x4a
function add_sound(ref, alias) {
    if (!isdefined(level.zombie_sounds)) {
        level.zombie_sounds = [];
    }
    level.zombie_sounds[ref] = alias;
}

// Namespace zm_utility/zm_utility
// Params 3, eflags: 0x0
// Checksum 0x7a9bb4c8, Offset: 0x7060
// Size: 0xec
function play_sound_at_pos(ref, pos, ent) {
    if (isdefined(ent)) {
        if (isdefined(ent.script_soundalias)) {
            playsoundatposition(ent.script_soundalias, pos);
            return;
        }
        if (isdefined(self.script_sound)) {
            ref = self.script_sound;
        }
    }
    if (ref == "none") {
        return;
    }
    if (!isdefined(level.zombie_sounds[ref])) {
        assertmsg("<dev string:x177>" + ref + "<dev string:x17f>");
        return;
    }
    playsoundatposition(level.zombie_sounds[ref], pos);
}

// Namespace zm_utility/zm_utility
// Params 1, eflags: 0x0
// Checksum 0x948bdab7, Offset: 0x7158
// Size: 0xc4
function play_sound_on_ent(ref) {
    if (isdefined(self.script_soundalias)) {
        self playsound(self.script_soundalias);
        return;
    }
    if (isdefined(self.script_sound)) {
        ref = self.script_sound;
    }
    if (ref == "none") {
        return;
    }
    if (!isdefined(level.zombie_sounds[ref])) {
        assertmsg("<dev string:x177>" + ref + "<dev string:x17f>");
        return;
    }
    self playsound(level.zombie_sounds[ref]);
}

// Namespace zm_utility/zm_utility
// Params 1, eflags: 0x0
// Checksum 0xeda2c1a9, Offset: 0x7228
// Size: 0x94
function play_loopsound_on_ent(ref) {
    if (isdefined(self.script_firefxsound)) {
        ref = self.script_firefxsound;
    }
    if (ref == "none") {
        return;
    }
    if (!isdefined(level.zombie_sounds[ref])) {
        assertmsg("<dev string:x177>" + ref + "<dev string:x17f>");
        return;
    }
    self playsound(level.zombie_sounds[ref]);
}

/#

    // Namespace zm_utility/zm_utility
    // Params 2, eflags: 0x0
    // Checksum 0x183fe420, Offset: 0x72c8
    // Size: 0xae
    function draw_line_ent_to_ent(ent1, ent2) {
        if (getdvarint(#"zombie_debug", 0) != 1) {
            return;
        }
        ent1 endon(#"death");
        ent2 endon(#"death");
        while (true) {
            line(ent1.origin, ent2.origin);
            waitframe(1);
        }
    }

    // Namespace zm_utility/zm_utility
    // Params 3, eflags: 0x0
    // Checksum 0x657eec2c, Offset: 0x7380
    // Size: 0xc6
    function draw_line_ent_to_pos(ent, pos, end_on) {
        if (getdvarint(#"zombie_debug", 0) != 1) {
            return;
        }
        ent notify(#"stop_draw_line_ent_to_pos");
        ent endon(#"stop_draw_line_ent_to_pos", #"death");
        if (isdefined(end_on)) {
            ent endon(end_on);
        }
        while (true) {
            line(ent.origin, pos);
            waitframe(1);
        }
    }

    // Namespace zm_utility/zm_utility
    // Params 1, eflags: 0x0
    // Checksum 0xd465eaaf, Offset: 0x7450
    // Size: 0x5c
    function debug_print(msg) {
        if (getdvarint(#"zombie_debug", 0) > 0) {
            println("<dev string:x1e7>" + msg);
        }
    }

    // Namespace zm_utility/zm_utility
    // Params 3, eflags: 0x0
    // Checksum 0x9d2d3c34, Offset: 0x74b8
    // Size: 0xa0
    function debug_blocker(pos, rad, height) {
        self notify(#"stop_debug_blocker");
        self endon(#"stop_debug_blocker");
        for (;;) {
            if (getdvarint(#"zombie_debug", 0) != 1) {
                return;
            }
            waitframe(1);
            drawcylinder(pos, rad, height);
        }
    }

    // Namespace zm_utility/zm_utility
    // Params 3, eflags: 0x0
    // Checksum 0x48aaabee, Offset: 0x7560
    // Size: 0x23e
    function drawcylinder(pos, rad, height) {
        currad = rad;
        curheight = height;
        for (r = 0; r < 20; r++) {
            theta = r / 20 * 360;
            theta2 = (r + 1) / 20 * 360;
            line(pos + (cos(theta) * currad, sin(theta) * currad, 0), pos + (cos(theta2) * currad, sin(theta2) * currad, 0));
            line(pos + (cos(theta) * currad, sin(theta) * currad, curheight), pos + (cos(theta2) * currad, sin(theta2) * currad, curheight));
            line(pos + (cos(theta) * currad, sin(theta) * currad, 0), pos + (cos(theta) * currad, sin(theta) * currad, curheight));
        }
    }

    // Namespace zm_utility/zm_utility
    // Params 0, eflags: 0x0
    // Checksum 0xbaa634d2, Offset: 0x77a8
    // Size: 0x178
    function debug_attack_spots_taken() {
        self notify(#"stop_debug_breadcrumbs");
        self endon(#"stop_debug_breadcrumbs");
        while (true) {
            if (getdvarint(#"zombie_debug", 0) != 2) {
                wait 1;
                continue;
            }
            waitframe(1);
            count = 0;
            for (i = 0; i < self.attack_spots_taken.size; i++) {
                if (self.attack_spots_taken[i]) {
                    count++;
                    circle(self.attack_spots[i], 12, (1, 0, 0), 0, 1, 1);
                    continue;
                }
                circle(self.attack_spots[i], 12, (0, 1, 0), 0, 1, 1);
            }
            msg = "<dev string:x1fa>" + count + "<dev string:x1fb>" + self.attack_spots_taken.size;
            print3d(self.origin, msg);
        }
    }

    // Namespace zm_utility/zm_utility
    // Params 2, eflags: 0x0
    // Checksum 0xe651c1e, Offset: 0x7928
    // Size: 0xa6
    function float_print3d(msg, time) {
        self endon(#"death");
        time = gettime() + time * 1000;
        offset = (0, 0, 72);
        while (gettime() < time) {
            offset += (0, 0, 2);
            print3d(self.origin + offset, msg, (1, 1, 1));
            waitframe(1);
        }
    }

#/

// Namespace zm_utility/zm_utility
// Params 2, eflags: 0x0
// Checksum 0xaef946ab, Offset: 0x79d8
// Size: 0x116
function do_player_vo(snd, variation_count) {
    index = get_player_index(self);
    sound = "zmb_vox_plr_" + index + "_" + snd;
    if (isdefined(variation_count)) {
        sound = sound + "_" + randomintrange(0, variation_count);
    }
    if (!isdefined(level.player_is_speaking)) {
        level.player_is_speaking = 0;
    }
    if (level.player_is_speaking == 0) {
        level.player_is_speaking = 1;
        self playsoundwithnotify(sound, "sound_done");
        self waittill(#"sound_done");
        wait 2;
        level.player_is_speaking = 0;
    }
}

// Namespace zm_utility/zm_utility
// Params 1, eflags: 0x0
// Checksum 0xdb0c25c, Offset: 0x7af8
// Size: 0x36
function is_magic_bullet_shield_enabled(ent) {
    if (!isdefined(ent)) {
        return false;
    }
    return !(isdefined(ent.allowdeath) && ent.allowdeath);
}

// Namespace zm_utility/zm_utility
// Params 1, eflags: 0x0
// Checksum 0x87d9f3d0, Offset: 0x7b38
// Size: 0x8c
function play_sound_2d(sound) {
    temp_ent = spawn("script_origin", (0, 0, 0));
    temp_ent playsoundwithnotify(sound, sound + "wait");
    temp_ent waittill(sound + "wait");
    waitframe(1);
    temp_ent delete();
}

// Namespace zm_utility/zm_utility
// Params 2, eflags: 0x0
// Checksum 0x66cd3e31, Offset: 0x7bd0
// Size: 0x6c
function include_weapon(weapon_name, in_box) {
    println("<dev string:x1ff>" + function_15979fa9(weapon_name));
    if (!isdefined(in_box)) {
        in_box = 1;
    }
    zm_weapons::include_zombie_weapon(weapon_name, in_box);
}

// Namespace zm_utility/zm_utility
// Params 6, eflags: 0x0
// Checksum 0xd3b9d7bf, Offset: 0x7c48
// Size: 0x146
function print3d_ent(text, color, scale, offset, end_msg, overwrite) {
    self endon(#"death");
    if (isdefined(overwrite) && overwrite && isdefined(self._debug_print3d_msg)) {
        self notify(#"end_print3d");
        waitframe(1);
    }
    self endon(#"end_print3d");
    if (!isdefined(color)) {
        color = (1, 1, 1);
    }
    if (!isdefined(scale)) {
        scale = 1;
    }
    if (!isdefined(offset)) {
        offset = (0, 0, 0);
    }
    if (isdefined(end_msg)) {
        self endon(end_msg);
    }
    self._debug_print3d_msg = text;
    /#
        while (!(isdefined(level.disable_print3d_ent) && level.disable_print3d_ent)) {
            print3d(self.origin + offset, self._debug_print3d_msg, color, scale);
            waitframe(1);
        }
    #/
}

// Namespace zm_utility/zm_utility
// Params 0, eflags: 0x0
// Checksum 0xfc45ddcf, Offset: 0x7d98
// Size: 0x30
function function_be4cf12d() {
    return getdvarint(#"hash_42c75b39576494a5", 1) == 1;
}

// Namespace zm_utility/zm_utility
// Params 0, eflags: 0x0
// Checksum 0x568cb8f9, Offset: 0x7dd0
// Size: 0x30
function function_a70772a9() {
    return getdvarint(#"hash_6ec233a56690f409", 1) == 1;
}

// Namespace zm_utility/zm_utility
// Params 2, eflags: 0x0
// Checksum 0x52cd7467, Offset: 0x7e08
// Size: 0x3a
function function_eb5eb205(location, max_drop_distance = 500) {
    return function_cfee2a04(location, max_drop_distance);
}

// Namespace zm_utility/zm_utility
// Params 2, eflags: 0x0
// Checksum 0x2a14db89, Offset: 0x7e50
// Size: 0x46
function function_b0f92007(location, node) {
    return isdefined(location) && location[#"region"] === getnoderegion(node);
}

// Namespace zm_utility/zm_utility
// Params 1, eflags: 0x0
// Checksum 0xd74245d2, Offset: 0x7ea0
// Size: 0x3a4
function get_current_zone(return_zone = 0) {
    level flag::wait_till("zones_initialized");
    if (function_be4cf12d()) {
        node = self.var_d87fc66f;
        var_e52b88cc = self.origin;
        if (isplayer(self)) {
            if (isdefined(self.last_valid_position) && distancesquared(self.origin, self.last_valid_position) < 32 * 32) {
                var_e52b88cc = self.last_valid_position;
            }
        }
        self.var_d87fc66f = function_e910fb8c(var_e52b88cc, level.zone_nodes, 500);
        if (isdefined(self.var_d87fc66f)) {
            if (node !== self.var_d87fc66f || isdefined(node) && node.targetname !== self.var_d87fc66f.targetname) {
                self.cached_zone = level.zones[self.var_d87fc66f.targetname];
                self.cached_zone_name = self.cached_zone.name;
                self.cached_zone_volume = undefined;
                self notify(#"zone_change", {#zone:self.cached_zone, #zone_name:self.cached_zone_name});
            }
            if (return_zone) {
                return level.zones[self.var_d87fc66f.targetname];
            } else {
                return self.var_d87fc66f.targetname;
            }
        }
    }
    if (function_a70772a9()) {
        for (z = 0; z < level.zone_keys.size; z++) {
            zone_name = level.zones[level.zone_keys[z]].name;
            zone = level.zones[zone_name];
            for (i = 0; i < zone.volumes.size; i++) {
                if (self istouching(zone.volumes[i])) {
                    if (zone !== self.cached_zone) {
                        self.cached_zone = zone;
                        self.cached_zone_name = zone_name;
                        self.cached_zone_volume = i;
                        self.var_d87fc66f = undefined;
                        self notify(#"zone_change", {#zone:zone, #zone_name:zone_name});
                    }
                    if (isdefined(return_zone) && return_zone) {
                        return zone;
                    }
                    return zone_name;
                }
            }
        }
    }
    self.cached_zone = undefined;
    self.cached_zone_name = undefined;
    self.cached_zone_volume = undefined;
    self.var_d87fc66f = undefined;
    return undefined;
}

// Namespace zm_utility/zm_utility
// Params 0, eflags: 0x0
// Checksum 0x798eba27, Offset: 0x8250
// Size: 0xd8
function update_zone_name() {
    self notify("2188f2e4cb37294");
    self endon("2188f2e4cb37294");
    self endon(#"death");
    self.zone_name = get_current_zone();
    if (isdefined(self.zone_name)) {
        self.previous_zone_name = self.zone_name;
    }
    while (isdefined(self)) {
        if (isdefined(self.zone_name)) {
            self.previous_zone_name = self.zone_name;
        }
        self.zone_name = get_current_zone();
        zm_zonemgr::function_2bc6b41d();
        wait randomfloatrange(0.5, 1);
    }
}

// Namespace zm_utility/zm_utility
// Params 0, eflags: 0x0
// Checksum 0x5518ef24, Offset: 0x8330
// Size: 0x310
function shock_onpain() {
    self notify(#"stop_shock_onpain");
    self endon(#"stop_shock_onpain", #"death");
    if (getdvarstring(#"blurpain") == "") {
        setdvar(#"blurpain", "on");
    }
    while (true) {
        oldhealth = self.health;
        waitresult = self waittill(#"damage");
        mod = waitresult.mod;
        damage = waitresult.amount;
        attacker = waitresult.attacker;
        direction_vec = waitresult.direction;
        point = waitresult.position;
        if (isdefined(level.shock_onpain) && !level.shock_onpain) {
            continue;
        }
        if (isdefined(self.shock_onpain) && !self.shock_onpain) {
            continue;
        }
        if (self.health < 1) {
            continue;
        }
        if (isdefined(attacker) && isdefined(attacker.custom_player_shellshock)) {
            self [[ attacker.custom_player_shellshock ]](damage, attacker, direction_vec, point, mod);
            continue;
        }
        if (mod == "MOD_PROJECTILE" || mod == "MOD_PROJECTILE_SPLASH") {
            continue;
        }
        if (mod == "MOD_GRENADE_SPLASH" || mod == "MOD_GRENADE" || mod == "MOD_EXPLOSIVE") {
            shocktype = undefined;
            shocklight = undefined;
            if (isdefined(self.is_burning) && self.is_burning) {
                shocktype = "lava";
                shocklight = "lava_small";
            }
            self shock_onexplosion(damage, shocktype, shocklight);
            continue;
        }
        if (getdvarstring(#"blurpain") == "on") {
            self shellshock(#"pain_zm", 0.5);
        }
    }
}

// Namespace zm_utility/zm_utility
// Params 3, eflags: 0x0
// Checksum 0xef12ca24, Offset: 0x8648
// Size: 0x10c
function shock_onexplosion(damage, shocktype, shocklight) {
    time = 0;
    scaled_damage = 100 * damage / self.maxhealth;
    if (scaled_damage >= 90) {
        time = 4;
    } else if (scaled_damage >= 50) {
        time = 3;
    } else if (scaled_damage >= 25) {
        time = 2;
    } else if (scaled_damage > 10) {
        time = 1;
    }
    if (time) {
        if (!isdefined(shocktype)) {
            shocktype = "explosion_zm";
        }
        self shellshock(shocktype, time);
        return;
    }
    if (isdefined(shocklight)) {
        self shellshock(shocklight, time);
    }
}

// Namespace zm_utility/zm_utility
// Params 1, eflags: 0x0
// Checksum 0xe0da347e, Offset: 0x8760
// Size: 0xb0
function increment_is_drinking(var_e03d46f4 = 0) {
    /#
        if (isdefined(level.devgui_dpad_watch) && level.devgui_dpad_watch) {
            self.is_drinking++;
            return;
        }
    #/
    if (!isdefined(self.is_drinking)) {
        self.is_drinking = 0;
    }
    if (self.is_drinking == 0) {
        if (!var_e03d46f4) {
            self disableoffhandweapons();
        }
        self disableweaponcycling();
    }
    self.is_drinking++;
}

// Namespace zm_utility/zm_utility
// Params 0, eflags: 0x0
// Checksum 0xfe83de31, Offset: 0x8818
// Size: 0x24
function is_drinking() {
    return self.is_drinking > 0 || self function_1b77f4ea();
}

// Namespace zm_utility/zm_utility
// Params 0, eflags: 0x0
// Checksum 0x37f57e33, Offset: 0x8848
// Size: 0x10
function is_multiple_drinking() {
    return self.is_drinking > 1;
}

// Namespace zm_utility/zm_utility
// Params 0, eflags: 0x0
// Checksum 0x7d998dc1, Offset: 0x8860
// Size: 0x74
function decrement_is_drinking() {
    if (self.is_drinking > 0) {
        self.is_drinking--;
    } else {
        assertmsg("<dev string:x217>");
    }
    if (self.is_drinking == 0) {
        self enableoffhandweapons();
        self enableweaponcycling();
    }
}

// Namespace zm_utility/zm_utility
// Params 0, eflags: 0x0
// Checksum 0xb2be2fd0, Offset: 0x88e0
// Size: 0x3c
function clear_is_drinking() {
    self.is_drinking = 0;
    self enableoffhandweapons();
    self enableweaponcycling();
}

// Namespace zm_utility/zm_utility
// Params 0, eflags: 0x0
// Checksum 0x29e34a7b, Offset: 0x8928
// Size: 0x2e
function function_322da1e0() {
    if (!isdefined(level.var_8a337225)) {
        level.var_8a337225 = 0;
    }
    return level.var_8a337225 > 0;
}

// Namespace zm_utility/zm_utility
// Params 0, eflags: 0x0
// Checksum 0x6f544356, Offset: 0x8960
// Size: 0x30
function function_29616508() {
    if (!isdefined(level.var_8a337225)) {
        level.var_8a337225 = 0;
    }
    level.var_8a337225++;
}

// Namespace zm_utility/zm_utility
// Params 0, eflags: 0x0
// Checksum 0xa24fbeb5, Offset: 0x8998
// Size: 0x74
function function_6c8e0750() {
    if (!isdefined(level.var_8a337225)) {
        level.var_8a337225 = 0;
    }
    if (level.var_8a337225 > 0) {
        level.var_8a337225--;
    } else {
        assertmsg("<dev string:x236>");
    }
    level zm_player::function_cb9259f5();
}

// Namespace zm_utility/zm_utility
// Params 3, eflags: 0x0
// Checksum 0xb40c9fd2, Offset: 0x8a18
// Size: 0x178
function can_use(e_player, b_is_weapon = 0, var_4aace1d7 = 0) {
    if (!is_player_valid(e_player, 0, var_4aace1d7) || e_player in_revive_trigger() || e_player isthrowinggrenade() || e_player isswitchingweapons() || e_player is_drinking()) {
        return false;
    }
    if (b_is_weapon) {
        w_current = e_player getcurrentweapon();
        if (!e_player zm_magicbox::can_buy_weapon() || e_player bgb::is_enabled(#"zm_bgb_disorderly_combat") || zm_loadout::is_placeable_mine(w_current) || zm_equipment::is_equipment(w_current) || ability_util::is_weapon_gadget(w_current)) {
            return false;
        }
    }
    return true;
}

// Namespace zm_utility/zm_utility
// Params 1, eflags: 0x0
// Checksum 0x2815c345, Offset: 0x8b98
// Size: 0x10c
function getweaponclasszm(weapon) {
    assert(isdefined(weapon));
    if (!isdefined(weapon)) {
        return undefined;
    }
    if (!isdefined(level.weaponclassarray)) {
        level.weaponclassarray = [];
    }
    if (isdefined(level.weaponclassarray[weapon])) {
        return level.weaponclassarray[weapon];
    }
    baseweaponindex = getbaseweaponitemindex(weapon);
    weaponinfo = getunlockableiteminfofromindex(baseweaponindex, 1);
    if (isdefined(weaponinfo)) {
        level.weaponclassarray[weapon] = weaponinfo.itemgroupname;
    } else {
        level.weaponclassarray[weapon] = "";
    }
    return level.weaponclassarray[weapon];
}

// Namespace zm_utility/zm_utility
// Params 5, eflags: 0x0
// Checksum 0x9a2cd6ed, Offset: 0x8cb0
// Size: 0xc8
function spawn_weapon_model(weapon, model = weapon.worldmodel, origin, angles, options) {
    weapon_model = spawn("script_model", origin);
    if (isdefined(angles)) {
        weapon_model.angles = angles;
    }
    if (isdefined(options)) {
        weapon_model useweaponmodel(weapon, model, options);
    } else {
        weapon_model useweaponmodel(weapon, model);
    }
    return weapon_model;
}

// Namespace zm_utility/zm_utility
// Params 5, eflags: 0x0
// Checksum 0xdd470eaf, Offset: 0x8d80
// Size: 0xe0
function spawn_buildkit_weapon_model(player, weapon, camo, origin, angles) {
    weapon_model = spawn("script_model", origin);
    if (isdefined(angles)) {
        weapon_model.angles = angles;
    }
    upgraded = zm_weapons::is_weapon_upgraded(weapon);
    if (upgraded && (!isdefined(camo) || 0 > camo)) {
        camo = zm_weapons::function_11a37a(undefined);
    }
    weapon_model usebuildkitweaponmodel(player, weapon, camo);
    return weapon_model;
}

// Namespace zm_utility/zm_utility
// Params 1, eflags: 0x0
// Checksum 0x666aca9, Offset: 0x8e68
// Size: 0x3a
function is_player_revive_tool(weapon) {
    if (weapon == level.weaponrevivetool || weapon === self.weaponrevivetool) {
        return true;
    }
    return false;
}

// Namespace zm_utility/zm_utility
// Params 1, eflags: 0x0
// Checksum 0x9c4fca9e, Offset: 0x8eb0
// Size: 0x3c
function is_limited_weapon(weapon) {
    if (isdefined(level.limited_weapons) && isdefined(level.limited_weapons[weapon])) {
        return true;
    }
    return false;
}

// Namespace zm_utility/zm_utility
// Params 0, eflags: 0x0
// Checksum 0xcc16d380, Offset: 0x8ef8
// Size: 0x20
function should_watch_for_emp() {
    return isdefined(level.should_watch_for_emp) && level.should_watch_for_emp;
}

// Namespace zm_utility/zm_utility
// Params 1, eflags: 0x0
// Checksum 0x2eba3597, Offset: 0x8f20
// Size: 0x44
function groundpos(origin) {
    return bullettrace(origin, origin + (0, 0, -100000), 0, self)[#"position"];
}

// Namespace zm_utility/zm_utility
// Params 1, eflags: 0x0
// Checksum 0xdbcadd0a, Offset: 0x8f70
// Size: 0x4c
function groundpos_ignore_water(origin) {
    return bullettrace(origin, origin + (0, 0, -100000), 0, self, 1)[#"position"];
}

// Namespace zm_utility/zm_utility
// Params 1, eflags: 0x0
// Checksum 0xaf0ce78b, Offset: 0x8fc8
// Size: 0x4c
function groundpos_ignore_water_new(origin) {
    return groundtrace(origin, origin + (0, 0, -100000), 0, self, 1)[#"position"];
}

// Namespace zm_utility/zm_utility
// Params 0, eflags: 0x0
// Checksum 0xf022395e, Offset: 0x9020
// Size: 0x24
function self_delete() {
    if (isdefined(self)) {
        self delete();
    }
}

// Namespace zm_utility/zm_utility
// Params 1, eflags: 0x0
// Checksum 0x779c2f3d, Offset: 0x9050
// Size: 0x52
function ignore_triggers(timer) {
    self endon(#"death");
    self.ignoretriggers = 1;
    if (isdefined(timer)) {
        wait timer;
    } else {
        wait 0.5;
    }
    self.ignoretriggers = 0;
}

// Namespace zm_utility/zm_utility
// Params 2, eflags: 0x0
// Checksum 0x33d5a01c, Offset: 0x90b0
// Size: 0x234
function giveachievement_wrapper(achievement, all_players) {
    if (achievement == "") {
        return;
    }
    if (isdefined(level.zm_disable_recording_stats) && level.zm_disable_recording_stats) {
        return;
    }
    achievement_lower = tolower(achievement);
    global_counter = 0;
    if (isdefined(all_players) && all_players) {
        players = getplayers();
        for (i = 0; i < players.size; i++) {
            players[i] giveachievement(achievement);
            has_achievement = 0;
            if (!(isdefined(has_achievement) && has_achievement)) {
                global_counter++;
            }
            if (issplitscreen() && i == 0 || !issplitscreen()) {
                if (isdefined(level.achievement_sound_func)) {
                    players[i] thread [[ level.achievement_sound_func ]](achievement_lower);
                }
            }
        }
    } else {
        if (!isplayer(self)) {
            println("<dev string:x265>");
            return;
        }
        self giveachievement(achievement);
        has_achievement = 0;
        if (!(isdefined(has_achievement) && has_achievement)) {
            global_counter++;
        }
        if (isdefined(level.achievement_sound_func)) {
            self thread [[ level.achievement_sound_func ]](achievement_lower);
        }
    }
    if (global_counter) {
        incrementcounter(#"global_" + achievement_lower, global_counter);
    }
}

// Namespace zm_utility/zm_utility
// Params 1, eflags: 0x0
// Checksum 0x6523b82e, Offset: 0x92f0
// Size: 0x40
function getyaw(org) {
    angles = vectortoangles(org - self.origin);
    return angles[1];
}

// Namespace zm_utility/zm_utility
// Params 1, eflags: 0x0
// Checksum 0x28af49ad, Offset: 0x9338
// Size: 0x62
function getyawtospot(spot) {
    pos = spot;
    yaw = self.angles[1] - getyaw(pos);
    yaw = angleclamp180(yaw);
    return yaw;
}

// Namespace zm_utility/zm_utility
// Params 0, eflags: 0x0
// Checksum 0xefe7c06d, Offset: 0x93a8
// Size: 0x3e
function disable_react() {
    assert(isalive(self), "<dev string:x2a5>");
    self.allowreact = 0;
}

// Namespace zm_utility/zm_utility
// Params 0, eflags: 0x0
// Checksum 0x2401ffa7, Offset: 0x93f0
// Size: 0x42
function enable_react() {
    assert(isalive(self), "<dev string:x2c8>");
    self.allowreact = 1;
}

// Namespace zm_utility/zm_utility
// Params 1, eflags: 0x0
// Checksum 0x46228c95, Offset: 0x9440
// Size: 0x30
function bullet_attack(type) {
    if (type == "MOD_PISTOL_BULLET") {
        return true;
    }
    return type == "MOD_RIFLE_BULLET";
}

// Namespace zm_utility/zm_utility
// Params 0, eflags: 0x0
// Checksum 0xa3e68b0c, Offset: 0x9478
// Size: 0xa4
function pick_up() {
    player = self.owner;
    self delete();
    clip_ammo = player getweaponammoclip(self.weapon);
    clip_max_ammo = self.weapon.clipsize;
    if (clip_ammo < clip_max_ammo) {
        clip_ammo++;
    }
    player setweaponammoclip(self.weapon, clip_ammo);
}

// Namespace zm_utility/zm_utility
// Params 0, eflags: 0x0
// Checksum 0xa49bc62a, Offset: 0x9528
// Size: 0xae
function waittill_not_moving() {
    self endon(#"death", #"detonated");
    level endon(#"game_ended");
    if (self.classname == "grenade") {
        self waittill(#"stationary");
        return;
    }
    for (prevorigin = self.origin; true; prevorigin = self.origin) {
        wait 0.15;
        if (self.origin == prevorigin) {
            break;
        }
    }
}

// Namespace zm_utility/zm_utility
// Params 1, eflags: 0x0
// Checksum 0xc5b872ab, Offset: 0x95e0
// Size: 0x42
function get_closest_player(org) {
    players = [];
    players = getplayers();
    return arraygetclosest(org, players);
}

// Namespace zm_utility/zm_utility
// Params 0, eflags: 0x0
// Checksum 0x6bb962d9, Offset: 0x9630
// Size: 0x9e
function ent_flag_init_ai_standards() {
    message_array = [];
    message_array[message_array.size] = "goal";
    message_array[message_array.size] = "damage";
    for (i = 0; i < message_array.size; i++) {
        self flag::init(message_array[i]);
        self thread ent_flag_wait_ai_standards(message_array[i]);
    }
}

// Namespace zm_utility/zm_utility
// Params 1, eflags: 0x0
// Checksum 0x1acda993, Offset: 0x96d8
// Size: 0x42
function ent_flag_wait_ai_standards(message) {
    self endon(#"death");
    self waittill(message);
    self.ent_flag[message] = 1;
}

// Namespace zm_utility/zm_utility
// Params 1, eflags: 0x0
// Checksum 0x80fe7398, Offset: 0x9728
// Size: 0x2c
function flat_angle(angle) {
    rangle = (0, angle[1], 0);
    return rangle;
}

// Namespace zm_utility/zm_utility
// Params 0, eflags: 0x0
// Checksum 0x46b6ebfd, Offset: 0x9760
// Size: 0x42
function clear_run_anim() {
    self.alwaysrunforward = undefined;
    self.a.combatrunanim = undefined;
    self.run_noncombatanim = undefined;
    self.walk_combatanim = undefined;
    self.walk_noncombatanim = undefined;
    self.precombatrunenabled = 1;
}

// Namespace zm_utility/zm_utility
// Params 0, eflags: 0x0
// Checksum 0x64541d55, Offset: 0x97b0
// Size: 0x916
function track_players_intersection_tracker() {
    self endon(#"death");
    level endon(#"end_game");
    wait 5;
    var_f10fa4d9 = [];
    /#
        if (!isdefined(level.var_429bf677)) {
            level.var_429bf677 = 0;
        }
    #/
    if (!isdefined(level.var_429bf677)) {
        level.var_429bf677 = 1;
    }
    while (true) {
        var_89fd15a4 = 0;
        players = getplayers();
        /#
            foreach (player in players) {
                if (!isdefined(player.var_97d05977)) {
                    player.var_97d05977 = [];
                }
                if (!isdefined(player.var_376d76c4)) {
                    player.var_376d76c4 = 1000;
                }
            }
        #/
        var_582e2276 = [];
        for (i = 0; i < players.size; i++) {
            if (isdefined(players[i].var_de91f30f) && players[i].var_de91f30f || players[i] isplayerswimming() || players[i] laststand::player_is_in_laststand() || "playing" != players[i].sessionstate) {
                continue;
            }
            if (isbot(players[i])) {
                continue;
            }
            if (lengthsquared(players[i] getvelocity()) > 15625) {
                continue;
            }
            if (isdefined(players[i].var_2c8b91cd) && players[i].var_2c8b91cd) {
                continue;
            }
            for (j = 0; j < players.size; j++) {
                if (i == j || isdefined(players[j].var_de91f30f) && players[j].var_de91f30f || players[j] isplayerswimming() || players[j] laststand::player_is_in_laststand() || "playing" != players[j].sessionstate) {
                    continue;
                }
                if (isbot(players[j])) {
                    continue;
                }
                if (lengthsquared(players[j] getvelocity()) > 15625) {
                    continue;
                }
                if (isdefined(players[j].var_2c8b91cd) && players[j].var_2c8b91cd) {
                    continue;
                }
                if (isdefined(level.player_intersection_tracker_override)) {
                    if (players[i] [[ level.player_intersection_tracker_override ]](players[j])) {
                        continue;
                    }
                }
                playeri_origin = players[i].origin;
                playerj_origin = players[j].origin;
                if (abs(playeri_origin[2] - playerj_origin[2]) > 60) {
                    continue;
                }
                distance_apart = distance2d(playeri_origin, playerj_origin);
                /#
                    if (!isdefined(players[i].var_97d05977[j])) {
                        players[i].var_97d05977[j] = 1000;
                    }
                    players[i].var_97d05977[j] = min(players[i].var_97d05977[j], distance_apart);
                    players[i].var_376d76c4 = min(players[i].var_376d76c4, distance_apart);
                    if (abs(distance_apart) > 30) {
                        if (players[i].var_97d05977[j] === players[i].var_376d76c4) {
                            players[i].var_376d76c4 = 1000;
                        }
                        players[i].var_97d05977[j] = 1000;
                    }
                #/
                if (abs(distance_apart) > 9) {
                    continue;
                }
                if (!isdefined(var_582e2276)) {
                    var_582e2276 = [];
                } else if (!isarray(var_582e2276)) {
                    var_582e2276 = array(var_582e2276);
                }
                if (!isinarray(var_582e2276, players[i])) {
                    var_582e2276[var_582e2276.size] = players[i];
                }
                if (!isdefined(var_582e2276)) {
                    var_582e2276 = [];
                } else if (!isarray(var_582e2276)) {
                    var_582e2276 = array(var_582e2276);
                }
                if (!isinarray(var_582e2276, players[j])) {
                    var_582e2276[var_582e2276.size] = players[j];
                }
            }
        }
        foreach (var_fb770c8 in var_582e2276) {
            /#
                if (!level.var_429bf677) {
                    iprintlnbold("<dev string:x2ea>" + var_fb770c8.var_376d76c4);
                    continue;
                }
            #/
            if (isinarray(var_f10fa4d9, var_fb770c8)) {
                var_fb770c8 dodamage(50, self.origin);
                var_fb770c8 zm_stats::increment_map_cheat_stat("cheat_too_friendly");
                var_fb770c8 zm_stats::increment_client_stat("cheat_too_friendly", 0);
                var_fb770c8 zm_stats::increment_client_stat("cheat_total", 0);
            }
            if (!var_89fd15a4) {
                /#
                    iprintlnbold("<dev string:x313>" + var_fb770c8.var_376d76c4);
                #/
                foreach (e_player in level.players) {
                    e_player playlocalsound(level.zmb_laugh_alias);
                }
                var_89fd15a4 = 1;
            }
        }
        var_f10fa4d9 = var_582e2276;
        wait 1;
    }
}

// Namespace zm_utility/zm_utility
// Params 4, eflags: 0x0
// Checksum 0x5f6678bd, Offset: 0xa0d0
// Size: 0x160
function is_player_looking_at(origin, dot, do_trace, ignore_ent) {
    assert(isplayer(self), "<dev string:x331>");
    if (!isdefined(dot)) {
        dot = 0.7;
    }
    if (!isdefined(do_trace)) {
        do_trace = 1;
    }
    eye = self util::get_eye();
    delta_vec = anglestoforward(vectortoangles(origin - eye));
    view_vec = anglestoforward(self getplayerangles());
    new_dot = vectordot(delta_vec, view_vec);
    if (new_dot >= dot) {
        if (do_trace) {
            return bullettracepassed(origin, eye, 0, ignore_ent);
        } else {
            return 1;
        }
    }
    return 0;
}

// Namespace zm_utility/zm_utility
// Params 4, eflags: 0x0
// Checksum 0x40e18cc5, Offset: 0xa238
// Size: 0x24
function add_gametype(gt, dummy1, name, dummy2) {
    
}

// Namespace zm_utility/zm_utility
// Params 4, eflags: 0x0
// Checksum 0x7208b9e9, Offset: 0xa268
// Size: 0x24
function add_gameloc(gl, dummy1, name, dummy2) {
    
}

// Namespace zm_utility/zm_utility
// Params 3, eflags: 0x0
// Checksum 0xa02c5cd0, Offset: 0xa298
// Size: 0xde
function get_closest_index(org, array, dist = 9999999) {
    distsq = dist * dist;
    if (array.size < 1) {
        return;
    }
    index = undefined;
    for (i = 0; i < array.size; i++) {
        newdistsq = distancesquared(array[i].origin, org);
        if (newdistsq >= distsq) {
            continue;
        }
        distsq = newdistsq;
        index = i;
    }
    return index;
}

// Namespace zm_utility/zm_utility
// Params 1, eflags: 0x0
// Checksum 0x5d6fc5ba, Offset: 0xa380
// Size: 0xde
function is_valid_zombie_spawn_point(point) {
    liftedorigin = point.origin + (0, 0, 5);
    size = 48;
    height = 64;
    mins = (-1 * size, -1 * size, 0);
    maxs = (size, size, height);
    absmins = liftedorigin + mins;
    absmaxs = liftedorigin + maxs;
    if (boundswouldtelefrag(absmins, absmaxs)) {
        return false;
    }
    return true;
}

// Namespace zm_utility/zm_utility
// Params 4, eflags: 0x0
// Checksum 0x2f475a3c, Offset: 0xa468
// Size: 0x126
function get_closest_index_to_entity(entity, array, dist, extra_check) {
    org = entity.origin;
    if (!isdefined(dist)) {
        dist = 9999999;
    }
    distsq = dist * dist;
    if (array.size < 1) {
        return;
    }
    index = undefined;
    for (i = 0; i < array.size; i++) {
        if (isdefined(extra_check) && ![[ extra_check ]](entity, array[i])) {
            continue;
        }
        newdistsq = distancesquared(array[i].origin, org);
        if (newdistsq >= distsq) {
            continue;
        }
        distsq = newdistsq;
        index = i;
    }
    return index;
}

// Namespace zm_utility/zm_utility
// Params 2, eflags: 0x0
// Checksum 0x3158a358, Offset: 0xa598
// Size: 0x4a
function set_gamemode_var(gvar, val) {
    if (!isdefined(game.gamemode_match)) {
        game.gamemode_match = [];
    }
    game.gamemode_match[gvar] = val;
}

// Namespace zm_utility/zm_utility
// Params 2, eflags: 0x0
// Checksum 0xc5532fa8, Offset: 0xa5f0
// Size: 0x5e
function set_gamemode_var_once(gvar, val) {
    if (!isdefined(game.gamemode_match)) {
        game.gamemode_match = [];
    }
    if (!isdefined(game.gamemode_match[gvar])) {
        game.gamemode_match[gvar] = val;
    }
}

// Namespace zm_utility/zm_utility
// Params 1, eflags: 0x0
// Checksum 0x18dca56b, Offset: 0xa658
// Size: 0x48
function get_gamemode_var(gvar) {
    if (isdefined(game.gamemode_match) && isdefined(game.gamemode_match[gvar])) {
        return game.gamemode_match[gvar];
    }
    return undefined;
}

// Namespace zm_utility/zm_utility
// Params 6, eflags: 0x0
// Checksum 0x93b2f736, Offset: 0xa6a8
// Size: 0x1d0
function waittill_subset(min_num, string1, string2, string3, string4, string5) {
    self endon(#"death");
    ent = spawnstruct();
    ent.threads = 0;
    returned_threads = 0;
    if (isdefined(string1)) {
        self thread util::waittill_string(string1, ent);
        ent.threads++;
    }
    if (isdefined(string2)) {
        self thread util::waittill_string(string2, ent);
        ent.threads++;
    }
    if (isdefined(string3)) {
        self thread util::waittill_string(string3, ent);
        ent.threads++;
    }
    if (isdefined(string4)) {
        self thread util::waittill_string(string4, ent);
        ent.threads++;
    }
    if (isdefined(string5)) {
        self thread util::waittill_string(string5, ent);
        ent.threads++;
    }
    while (ent.threads) {
        ent waittill(#"returned");
        ent.threads--;
        returned_threads++;
        if (returned_threads >= min_num) {
            break;
        }
    }
    ent notify(#"die");
}

// Namespace zm_utility/zm_utility
// Params 3, eflags: 0x0
// Checksum 0x44fd9b11, Offset: 0xa880
// Size: 0xaa
function is_headshot(weapon, shitloc, smeansofdeath) {
    if (!isdefined(shitloc)) {
        return false;
    }
    if (shitloc != "head" && shitloc != "helmet") {
        return false;
    }
    if (smeansofdeath == "MOD_IMPACT" && weapon.isballisticknife) {
        return true;
    }
    return smeansofdeath != "MOD_MELEE" && smeansofdeath != "MOD_IMPACT" && smeansofdeath != "MOD_UNKNOWN";
}

// Namespace zm_utility/zm_utility
// Params 1, eflags: 0x0
// Checksum 0x29c5f03f, Offset: 0xa938
// Size: 0x7e
function is_explosive_damage(mod) {
    if (!isdefined(mod)) {
        return false;
    }
    if (mod == "MOD_GRENADE" || mod == "MOD_GRENADE_SPLASH" || mod == "MOD_PROJECTILE" || mod == "MOD_PROJECTILE_SPLASH" || mod == "MOD_EXPLOSIVE") {
        return true;
    }
    return false;
}

// Namespace zm_utility/zm_utility
// Params 1, eflags: 0x0
// Checksum 0x6a82bdbc, Offset: 0xa9c0
// Size: 0x8c
function function_d7a33664(var_9978921c) {
    if (isplayer(self)) {
        self luinotifyevent(#"zombie_notification", 2, var_9978921c, self getentitynumber());
        return;
    }
    luinotifyevent(#"zombie_notification", 1, var_9978921c);
}

// Namespace zm_utility/zm_utility
// Params 2, eflags: 0x0
// Checksum 0x503760a1, Offset: 0xaa58
// Size: 0x84
function function_fc24c484(type_id, var_9978921c) {
    if (isplayer(self)) {
        self luinotifyevent(type_id, 2, var_9978921c, self getentitynumber());
        return;
    }
    luinotifyevent(type_id, 1, var_9978921c);
}

// Namespace zm_utility/zm_utility
// Params 1, eflags: 0x0
// Checksum 0x4fae2fcb, Offset: 0xaae8
// Size: 0x7a
function sndswitchannouncervox(who) {
    switch (who) {
    case #"sam":
        game.zmbdialog[#"prefix"] = "vox_zmba_sam";
        level.zmb_laugh_alias = "zmb_player_outofbounds";
        level.sndannouncerisrich = 0;
        break;
    }
}

// Namespace zm_utility/zm_utility
// Params 4, eflags: 0x0
// Checksum 0x901625b7, Offset: 0xab70
// Size: 0xc4
function do_player_general_vox(category, type, timer, chance) {
    if (isdefined(timer) && isdefined(level.votimer[type]) && level.votimer[type] > 0) {
        return;
    }
    self thread zm_audio::create_and_play_dialog(category, type);
    if (isdefined(timer)) {
        level.votimer[type] = timer;
        level thread general_vox_timer(level.votimer[type], type);
    }
}

// Namespace zm_utility/zm_utility
// Params 2, eflags: 0x0
// Checksum 0xe7da3485, Offset: 0xac40
// Size: 0xd4
function general_vox_timer(timer, type) {
    level endon(#"end_game");
    println("<dev string:x35f>" + type + "<dev string:x37d>" + timer + "<dev string:x381>");
    while (timer > 0) {
        wait 1;
        timer--;
    }
    level.votimer[type] = timer;
    println("<dev string:x383>" + type + "<dev string:x37d>" + timer + "<dev string:x381>");
}

// Namespace zm_utility/zm_utility
// Params 1, eflags: 0x0
// Checksum 0xb8e29c7c, Offset: 0xad20
// Size: 0x22
function function_a9e0d67d(type) {
    level.votimer[type] = 0;
}

// Namespace zm_utility/zm_utility
// Params 3, eflags: 0x0
// Checksum 0x61443f61, Offset: 0xad50
// Size: 0x1c
function play_vox_to_player(category, type, force_variant) {
    
}

// Namespace zm_utility/zm_utility
// Params 1, eflags: 0x0
// Checksum 0x523e4994, Offset: 0xad78
// Size: 0x92
function is_favorite_weapon(weapon_to_check) {
    if (!isdefined(self.favorite_wall_weapons_list)) {
        return false;
    }
    foreach (weapon in self.favorite_wall_weapons_list) {
        if (weapon_to_check == weapon) {
            return true;
        }
    }
    return false;
}

// Namespace zm_utility/zm_utility
// Params 0, eflags: 0x0
// Checksum 0xde1a43c, Offset: 0xae18
// Size: 0x1ec
function set_demo_intermission_point() {
    spawnpoints = getentarray("mp_global_intermission", "classname");
    if (!spawnpoints.size) {
        return;
    }
    spawnpoint = spawnpoints[0];
    match_string = "";
    location = level.scr_zm_map_start_location;
    if ((location == "default" || location == "") && isdefined(level.default_start_location)) {
        location = level.default_start_location;
    }
    match_string = level.scr_zm_ui_gametype + "_" + location;
    for (i = 0; i < spawnpoints.size; i++) {
        if (isdefined(spawnpoints[i].script_string)) {
            tokens = strtok(spawnpoints[i].script_string, " ");
            foreach (token in tokens) {
                if (token == match_string) {
                    spawnpoint = spawnpoints[i];
                    i = spawnpoints.size;
                    break;
                }
            }
        }
    }
    setdemointermissionpoint(spawnpoint.origin, spawnpoint.angles);
}

// Namespace zm_utility/zm_utility
// Params 2, eflags: 0x0
// Checksum 0xb2a9be48, Offset: 0xb010
// Size: 0x32
function register_map_navcard(navcard_on_map, navcard_needed_for_computer) {
    level.navcard_needed = navcard_needed_for_computer;
    level.map_navcard = navcard_on_map;
}

// Namespace zm_utility/zm_utility
// Params 1, eflags: 0x0
// Checksum 0xc1895390, Offset: 0xb050
// Size: 0x2a
function does_player_have_map_navcard(player) {
    return player zm_stats::get_global_stat(level.map_navcard);
}

// Namespace zm_utility/zm_utility
// Params 1, eflags: 0x0
// Checksum 0xe3726215, Offset: 0xb088
// Size: 0x3a
function does_player_have_correct_navcard(player) {
    if (!isdefined(level.navcard_needed)) {
        return 0;
    }
    return player zm_stats::get_global_stat(level.navcard_needed);
}

// Namespace zm_utility/zm_utility
// Params 4, eflags: 0x0
// Checksum 0x62e74e54, Offset: 0xb0d0
// Size: 0x34c
function function_e9e262a6(str_model, var_d7f161b3, org, angles) {
    var_cdb03d1a = spawn("script_model", org);
    var_cdb03d1a setmodel(str_model);
    var_cdb03d1a.angles = angles;
    wait 1;
    var_81aba672 = spawn("trigger_radius_use", org, 0, 84, 72);
    var_81aba672 setcursorhint("HINT_NOICON");
    var_81aba672 sethintstring(#"hash_9674617e664600c");
    var_81aba672 triggerignoreteam();
    var_fefc736a = array("navcard_held_zm_transit", "navcard_held_zm_highrise", "navcard_held_zm_buried");
    var_6f17e5d2 = 0;
    var_98b4d62c = undefined;
    while (true) {
        waitresult = var_81aba672 waittill(#"trigger");
        who = waitresult.activator;
        if (is_player_valid(who)) {
            foreach (var_28ca1df6 in var_fefc736a) {
                if (who zm_stats::get_global_stat(var_28ca1df6)) {
                    var_98b4d62c = var_28ca1df6;
                    var_6f17e5d2 = 1;
                    who zm_stats::set_global_stat(var_28ca1df6, 0);
                }
            }
            who playsound(#"hash_7f868f0915fa1268");
            who zm_stats::set_global_stat(var_d7f161b3, 1);
            who.var_3d88e938 = var_d7f161b3;
            util::wait_network_frame();
            var_b523d12 = who zm_stats::get_global_stat(var_d7f161b3);
            thread function_580634e9();
            break;
        }
    }
    var_cdb03d1a delete();
    var_81aba672 delete();
    if (var_6f17e5d2) {
        level thread function_e9e262a6(str_model, var_98b4d62c, org, angles);
    }
}

// Namespace zm_utility/zm_utility
// Params 0, eflags: 0x0
// Checksum 0x83c3a556, Offset: 0xb428
// Size: 0xa8
function function_580634e9() {
    if (!isdefined(level.var_20955c15)) {
        return;
    }
    players = getplayers();
    foreach (player in players) {
        player thread function_a3334d57();
    }
}

// Namespace zm_utility/zm_utility
// Params 0, eflags: 0x0
// Checksum 0x58b3d72d, Offset: 0xb4d8
// Size: 0x144
function function_a3334d57() {
    self endon(#"disconnect");
    var_8336cbb5 = 0;
    for (i = 0; i < level.var_20955c15.size; i++) {
        var_d033858 = self zm_stats::get_global_stat(level.var_20955c15[i]);
        if (isdefined(self.var_3d88e938) && self.var_3d88e938 == level.var_20955c15[i]) {
            var_d033858 = 1;
        }
        if (var_d033858) {
            var_8336cbb5 += 1 << i;
        }
    }
    util::wait_network_frame();
    self clientfield::set("navcard_held", 0);
    if (var_8336cbb5 > 0) {
        util::wait_network_frame();
        self clientfield::set("navcard_held", var_8336cbb5);
    }
}

// Namespace zm_utility/zm_utility
// Params 1, eflags: 0x0
// Checksum 0x4c4a6c93, Offset: 0xb628
// Size: 0xf4
function disable_player_move_states(forcestancechange) {
    self allowcrouch(1);
    self allowlean(0);
    self allowads(0);
    self allowsprint(0);
    self allowprone(0);
    self allowmelee(0);
    if (isdefined(forcestancechange) && forcestancechange == 1) {
        if (self getstance() == "prone") {
            self setstance("crouch");
        }
    }
}

// Namespace zm_utility/zm_utility
// Params 0, eflags: 0x0
// Checksum 0xa951a2a2, Offset: 0xb728
// Size: 0x11c
function enable_player_move_states() {
    if (!isdefined(self.var_64e767ea) || self.var_64e767ea == 1) {
        self allowlean(1);
    }
    if (!isdefined(self._allow_ads) || self._allow_ads == 1) {
        self allowads(1);
    }
    if (!isdefined(self._allow_sprint) || self._allow_sprint == 1) {
        self allowsprint(1);
    }
    if (!isdefined(self._allow_prone) || self._allow_prone == 1) {
        self allowprone(1);
    }
    if (!isdefined(self._allow_melee) || self._allow_melee == 1) {
        self allowmelee(1);
    }
}

// Namespace zm_utility/zm_utility
// Params 6, eflags: 0x0
// Checksum 0x35ddd743, Offset: 0xb850
// Size: 0x126
function spawn_path_node(origin, angles, k1, v1, k2, v2) {
    if (!isdefined(level._spawned_path_nodes)) {
        level._spawned_path_nodes = [];
    }
    node = spawnstruct();
    node.origin = origin;
    node.angles = angles;
    node.k1 = k1;
    node.v1 = v1;
    node.k2 = k2;
    node.v2 = v2;
    node.node = spawn_path_node_internal(origin, angles, k1, v1, k2, v2);
    level._spawned_path_nodes[level._spawned_path_nodes.size] = node;
    return node.node;
}

// Namespace zm_utility/zm_utility
// Params 6, eflags: 0x0
// Checksum 0xb8a49f98, Offset: 0xb980
// Size: 0xbe
function spawn_path_node_internal(origin, angles, k1, v1, k2, v2) {
    if (isdefined(k2)) {
        return spawnpathnode("node_pathnode", origin, angles, k1, v1, k2, v2);
    } else if (isdefined(k1)) {
        return spawnpathnode("node_pathnode", origin, angles, k1, v1);
    } else {
        return spawnpathnode("node_pathnode", origin, angles);
    }
    return undefined;
}

// Namespace zm_utility/zm_utility
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0xba48
// Size: 0x4
function delete_spawned_path_nodes() {
    
}

// Namespace zm_utility/zm_utility
// Params 0, eflags: 0x0
// Checksum 0xe84e8b6a, Offset: 0xba58
// Size: 0xf0
function respawn_path_nodes() {
    if (!isdefined(level._spawned_path_nodes)) {
        return;
    }
    for (i = 0; i < level._spawned_path_nodes.size; i++) {
        node_struct = level._spawned_path_nodes[i];
        println("<dev string:x39f>" + node_struct.origin);
        node_struct.node = spawn_path_node_internal(node_struct.origin, node_struct.angles, node_struct.k1, node_struct.v1, node_struct.k2, node_struct.v2);
    }
}

// Namespace zm_utility/zm_utility
// Params 0, eflags: 0x0
// Checksum 0x4c802dec, Offset: 0xbb50
// Size: 0x64
function undo_link_changes() {
    /#
        println("<dev string:x3c0>");
        println("<dev string:x3c0>");
        println("<dev string:x3c4>");
    #/
    delete_spawned_path_nodes();
}

// Namespace zm_utility/zm_utility
// Params 0, eflags: 0x0
// Checksum 0xd4c4e7a7, Offset: 0xbbc0
// Size: 0x64
function redo_link_changes() {
    /#
        println("<dev string:x3c0>");
        println("<dev string:x3c0>");
        println("<dev string:x3dd>");
    #/
    respawn_path_nodes();
}

// Namespace zm_utility/zm_utility
// Params 1, eflags: 0x0
// Checksum 0x25b33c5d, Offset: 0xbc30
// Size: 0x98
function is_gametype_active(a_gametypes) {
    b_is_gametype_active = 0;
    if (!isarray(a_gametypes)) {
        a_gametypes = array(a_gametypes);
    }
    for (i = 0; i < a_gametypes.size; i++) {
        if (util::get_game_type() == a_gametypes[i]) {
            b_is_gametype_active = 1;
        }
    }
    return b_is_gametype_active;
}

// Namespace zm_utility/zm_utility
// Params 2, eflags: 0x0
// Checksum 0x78d1490f, Offset: 0xbcd0
// Size: 0x4a
function register_custom_spawner_entry(spot_noteworthy, func) {
    if (!isdefined(level.custom_spawner_entry)) {
        level.custom_spawner_entry = [];
    }
    level.custom_spawner_entry[spot_noteworthy] = func;
}

// Namespace zm_utility/zm_utility
// Params 1, eflags: 0x0
// Checksum 0x62ea7c81, Offset: 0xbd28
// Size: 0x8e
function get_player_weapon_limit(player) {
    if (isdefined(self.get_player_weapon_limit)) {
        return [[ self.get_player_weapon_limit ]](player);
    }
    if (isdefined(level.get_player_weapon_limit)) {
        return [[ level.get_player_weapon_limit ]](player);
    }
    weapon_limit = 2;
    if (player hasperk(#"specialty_additionalprimaryweapon")) {
        weapon_limit = level.additionalprimaryweapon_limit;
    }
    return weapon_limit;
}

// Namespace zm_utility/zm_utility
// Params 2, eflags: 0x0
// Checksum 0xfcfcb3ae, Offset: 0xbdc0
// Size: 0x62
function function_4b3c286(e_player, n_cost) {
    if (isdefined(level.var_f5d2de23) && [[ level.var_f5d2de23 ]](e_player, self.clientfieldname)) {
        return 0;
    }
    return e_player zm_score::can_player_purchase(n_cost);
}

// Namespace zm_utility/zm_utility
// Params 0, eflags: 0x0
// Checksum 0x6f514994, Offset: 0xbe30
// Size: 0x42
function get_player_perk_purchase_limit() {
    n_perk_purchase_limit_override = level.perk_purchase_limit;
    if (isdefined(level.get_player_perk_purchase_limit)) {
        n_perk_purchase_limit_override = self [[ level.get_player_perk_purchase_limit ]]();
    }
    return n_perk_purchase_limit_override;
}

// Namespace zm_utility/zm_utility
// Params 0, eflags: 0x0
// Checksum 0x76939211, Offset: 0xbe80
// Size: 0x70
function can_player_purchase_perk() {
    if (self.num_perks < self get_player_perk_purchase_limit()) {
        return true;
    }
    if (self bgb::is_enabled(#"zm_bgb_unquenchable") || self bgb::is_enabled(#"zm_bgb_soda_fountain")) {
        return true;
    }
    return false;
}

// Namespace zm_utility/zm_utility
// Params 1, eflags: 0x0
// Checksum 0xc92b38e5, Offset: 0xbef8
// Size: 0x17c
function function_82a5cc4(var_bfc9d652 = 0) {
    a_str_perks = getarraykeys(level._custom_perks);
    foreach (str_perk in a_str_perks) {
        if (str_perk == #"specialty_quickrevive" && var_bfc9d652) {
            continue;
        }
        if (!self hasperk(str_perk)) {
            var_ff2247e3 = zm_perks::function_ec1dff78(str_perk);
            if (var_ff2247e3 >= 0) {
                self zm_perks::function_79567d8a(str_perk, var_ff2247e3);
                continue;
            }
            if (!zm_perks::function_39e56b81(str_perk)) {
                self zm_perks::give_perk(str_perk, 0);
                if (isdefined(level.var_7b162f9e)) {
                    self [[ level.var_7b162f9e ]](str_perk);
                }
            }
        }
    }
}

// Namespace zm_utility/zm_utility
// Params 0, eflags: 0x0
// Checksum 0x8a508dd, Offset: 0xc080
// Size: 0x36
function wait_for_attractor_positions_complete() {
    self endon(#"death");
    self waittill(#"attractor_positions_generated");
    self.attract_to_origin = 0;
}

// Namespace zm_utility/zm_utility
// Params 1, eflags: 0x0
// Checksum 0x71848584, Offset: 0xc0c0
// Size: 0xd6
function get_player_index(player) {
    assert(isplayer(player));
    assert(isdefined(player.characterindex));
    /#
        if (player.entity_num == 0 && getdvarstring(#"zombie_player_vo_overwrite") != "<dev string:x1fa>") {
            new_vo_index = getdvarint(#"zombie_player_vo_overwrite", 0);
            return new_vo_index;
        }
    #/
    return player.characterindex;
}

// Namespace zm_utility/zm_utility
// Params 1, eflags: 0x0
// Checksum 0x7db5937, Offset: 0xc1a0
// Size: 0x98
function function_a157d632(n_character_index) {
    foreach (character in level.players) {
        if (character zm_characters::function_82f5ce1a() == n_character_index) {
            return character;
        }
    }
    return undefined;
}

// Namespace zm_utility/zm_utility
// Params 1, eflags: 0x0
// Checksum 0x6f8b5142, Offset: 0xc240
// Size: 0xfc
function zombie_goto_round(n_target_round) {
    level notify(#"restart_round");
    if (n_target_round < 1) {
        n_target_round = 1;
    }
    level.zombie_total = 0;
    level.zombie_health = zombie_utility::ai_calculate_health(zombie_utility::get_zombie_var(#"zombie_health_start"), n_target_round);
    zm_round_logic::set_round_number(n_target_round);
    zombies = zombie_utility::get_round_enemy_array();
    if (isdefined(zombies)) {
        array::run_all(zombies, &kill);
    }
    level.sndgotoroundoccurred = 1;
    level waittill(#"between_round_over");
}

// Namespace zm_utility/zm_utility
// Params 2, eflags: 0x0
// Checksum 0x822a5ad, Offset: 0xc348
// Size: 0x226
function is_point_inside_enabled_zone(v_origin, ignore_zone) {
    if (function_be4cf12d()) {
        node = function_e910fb8c(v_origin, level.zone_nodes, 500);
        if (isdefined(node)) {
            zone = level.zones[node.targetname];
            if (isdefined(zone) && zone.is_enabled && zone !== ignore_zone) {
                return true;
            }
        }
    }
    if (function_a70772a9()) {
        temp_ent = spawn("script_origin", v_origin);
        foreach (zone in level.zones) {
            if (!zone.is_enabled) {
                continue;
            }
            if (isdefined(ignore_zone) && zone == ignore_zone) {
                continue;
            }
            foreach (e_volume in zone.volumes) {
                if (temp_ent istouching(e_volume)) {
                    temp_ent delete();
                    return true;
                }
            }
        }
        temp_ent delete();
    }
    return false;
}

// Namespace zm_utility/zm_utility
// Params 0, eflags: 0x0
// Checksum 0x7a17fe99, Offset: 0xc578
// Size: 0x46
function clear_streamer_hint() {
    if (isdefined(self.streamer_hint)) {
        self.streamer_hint delete();
        self.streamer_hint = undefined;
    }
    self notify(#"wait_clear_streamer_hint");
}

// Namespace zm_utility/zm_utility
// Params 1, eflags: 0x0
// Checksum 0x37c710f0, Offset: 0xc5c8
// Size: 0x44
function wait_clear_streamer_hint(lifetime) {
    self endon(#"wait_clear_streamer_hint");
    wait lifetime;
    if (isdefined(self)) {
        self clear_streamer_hint();
    }
}

// Namespace zm_utility/zm_utility
// Params 4, eflags: 0x0
// Checksum 0x96ca294c, Offset: 0xc618
// Size: 0x19c
function create_streamer_hint(origin, angles, value, lifetime) {
    if (self == level) {
        foreach (player in getplayers()) {
            player clear_streamer_hint();
        }
    }
    self clear_streamer_hint();
    self.streamer_hint = createstreamerhint(origin, value);
    if (isdefined(angles)) {
        self.streamer_hint.angles = angles;
    }
    if (self != level) {
        self.streamer_hint setinvisibletoall();
        self.streamer_hint setvisibletoplayer(self);
    }
    self.streamer_hint setincludemeshes(1);
    self notify(#"wait_clear_streamer_hint");
    if (isdefined(lifetime) && lifetime > 0) {
        self thread wait_clear_streamer_hint(lifetime);
    }
}

// Namespace zm_utility/zm_utility
// Params 1, eflags: 0x0
// Checksum 0x760a55ed, Offset: 0xc7c0
// Size: 0x138
function approximate_path_dist(player) {
    aiprofile_beginentry("approximate_path_dist");
    goal_pos = player.origin;
    if (isdefined(player.last_valid_position)) {
        goal_pos = player.last_valid_position;
    }
    if (isdefined(player.b_teleporting) && player.b_teleporting) {
        if (isdefined(player.teleport_location)) {
            goal_pos = player.teleport_location;
            if (!ispointonnavmesh(goal_pos, self)) {
                position = getclosestpointonnavmesh(goal_pos, 100, 15);
                if (isdefined(position)) {
                    goal_pos = position;
                }
            }
        }
    }
    approx_dist = pathdistance(self.origin, goal_pos, 1, self);
    aiprofile_endentry();
    return approx_dist;
}

// Namespace zm_utility/zm_utility
// Params 3, eflags: 0x0
// Checksum 0x509a4896, Offset: 0xc900
// Size: 0xa6
function register_slowdown(str_type, n_rate, n_duration = -1) {
    if (!isdefined(level.var_7311ccb3)) {
        level.var_7311ccb3 = [];
    }
    level.var_f7007373[str_type] = spawnstruct();
    level.var_f7007373[str_type].n_rate = n_rate;
    level.var_f7007373[str_type].n_duration = n_duration;
}

// Namespace zm_utility/zm_utility
// Params 2, eflags: 0x0
// Checksum 0x8183fdad, Offset: 0xc9b0
// Size: 0x3ac
function function_447d3917(str_type, var_f2e751e9) {
    if (isdefined(self.var_130c089b) && self.var_130c089b) {
        return;
    }
    self notify(#"starting_slowdown_ai");
    level endon(#"end_game");
    self endoncallback(&function_e6087602, #"starting_slowdown_ai", #"death");
    assert(isdefined(level.var_f7007373[str_type]), "<dev string:x3f6>" + str_type + "<dev string:x401>");
    if (!isdefined(self.a_n_slowdown_timeouts)) {
        self.a_n_slowdown_timeouts = [];
    }
    n_time = gettime();
    n_timeout = n_time + int(level.var_f7007373[str_type].n_duration * 1000);
    if (!isdefined(self.a_n_slowdown_timeouts[str_type]) || self.a_n_slowdown_timeouts[str_type] < n_timeout) {
        self.a_n_slowdown_timeouts[str_type] = n_timeout;
    }
    for (var_6788858 = self.a_n_slowdown_timeouts.size; var_6788858; var_6788858 = self.a_n_slowdown_timeouts.size) {
        str_lowest_type = undefined;
        n_lowest_rate = 10;
        self function_d9420c30();
        foreach (str_index, n_slowdown_timeout in self.a_n_slowdown_timeouts) {
            if (str_index == str_type && isdefined(var_f2e751e9)) {
                n_rate = var_f2e751e9;
            } else {
                n_rate = level.var_f7007373[str_index].n_rate;
            }
            if (n_rate < n_lowest_rate) {
                str_lowest_type = str_index;
                n_lowest_rate = n_rate;
            }
        }
        if (isdefined(str_lowest_type)) {
            self asmsetanimationrate(n_lowest_rate);
            if (level.var_f7007373[str_lowest_type].n_duration == -1) {
                self waittill(#"hash_62a477d53a6bbad");
            } else {
                n_duration = self.a_n_slowdown_timeouts[str_lowest_type] - n_time;
                self waittilltimeout(float(n_duration) / 1000, #"hash_62a477d53a6bbad");
            }
            if (self.a_n_slowdown_timeouts[str_lowest_type] < gettime() && level.var_f7007373[str_lowest_type].n_duration != -1) {
                self.a_n_slowdown_timeouts[str_lowest_type] = undefined;
            }
        }
        self function_d9420c30();
    }
    self asmsetanimationrate(1);
}

// Namespace zm_utility/zm_utility
// Params 0, eflags: 0x4
// Checksum 0xdf7f1c71, Offset: 0xcd68
// Size: 0xe4
function private function_d9420c30() {
    n_time = gettime();
    foreach (str_index, n_slowdown_timeout in self.a_n_slowdown_timeouts) {
        if (level.var_f7007373[str_index].n_duration != -1 && n_slowdown_timeout <= n_time || n_slowdown_timeout == -1) {
            self.a_n_slowdown_timeouts[str_index] = undefined;
        }
    }
    arrayremovevalue(self.a_n_slowdown_timeouts, undefined, 1);
}

// Namespace zm_utility/zm_utility
// Params 1, eflags: 0x0
// Checksum 0x4fa4acd9, Offset: 0xce58
// Size: 0x5e
function function_95398de5(str_type) {
    if (isdefined(str_type) && isdefined(self.a_n_slowdown_timeouts) && isdefined(self.a_n_slowdown_timeouts[str_type])) {
        self.a_n_slowdown_timeouts[str_type] = -1;
    }
    self notify(#"hash_62a477d53a6bbad");
}

// Namespace zm_utility/zm_utility
// Params 1, eflags: 0x0
// Checksum 0xc94cd55a, Offset: 0xcec0
// Size: 0x5c
function function_e6087602(str_notify) {
    if (isalive(self) && hasasm(self)) {
        self asmsetanimationrate(1);
    }
}

// Namespace zm_utility/zm_utility
// Params 3, eflags: 0x0
// Checksum 0xb7c65ad5, Offset: 0xcf28
// Size: 0x96
function function_c8316536(str_type, n_rate, n_duration) {
    if (!isdefined(level.var_7311ccb3)) {
        level.var_14b79a19 = [];
    }
    level.var_14b79a19[str_type] = spawnstruct();
    level.var_14b79a19[str_type].n_rate = n_rate;
    level.var_14b79a19[str_type].n_duration = n_duration;
}

// Namespace zm_utility/zm_utility
// Params 2, eflags: 0x0
// Checksum 0x99b00719, Offset: 0xcfc8
// Size: 0x2d4
function function_50a99546(str_type, var_f2e751e9) {
    if (isdefined(self.var_130c089b) && self.var_130c089b) {
        return;
    }
    self notify(#"hash_31eac0065ba118f5");
    self endoncallback(&function_130865b7, #"hash_31eac0065ba118f5", #"death", #"hash_28af7943f07d93e2");
    assert(isdefined(level.var_14b79a19[str_type]), "<dev string:x3f6>" + str_type + "<dev string:x401>");
    if (!isdefined(self.a_n_slowdown_timeouts)) {
        self.a_n_slowdown_timeouts = [];
    }
    n_time = gettime();
    n_timeout = n_time + level.var_14b79a19[str_type].n_duration;
    if (!isdefined(self.a_n_slowdown_timeouts[str_type]) || self.a_n_slowdown_timeouts[str_type] < n_timeout) {
        self.a_n_slowdown_timeouts[str_type] = n_timeout;
    }
    while (self.a_n_slowdown_timeouts.size) {
        str_lowest_type = undefined;
        n_lowest_rate = 10;
        foreach (str_index, n_slowdown_timeout in self.a_n_slowdown_timeouts) {
            if (n_slowdown_timeout <= n_time) {
                self.a_n_slowdown_timeouts[str_index] = undefined;
                continue;
            }
            if (str_index == str_type && isdefined(var_f2e751e9)) {
                n_rate = var_f2e751e9;
            } else {
                n_rate = level.var_14b79a19[str_index].n_rate;
            }
            if (n_rate < n_lowest_rate) {
                str_lowest_type = str_index;
                n_lowest_rate = n_rate;
            }
        }
        if (isdefined(str_lowest_type)) {
            self setmovespeedscale(n_lowest_rate);
            n_duration = self.a_n_slowdown_timeouts[str_lowest_type] - n_time;
            wait n_duration;
            self.a_n_slowdown_timeouts[str_lowest_type] = undefined;
        }
    }
    self setmovespeedscale(1);
}

// Namespace zm_utility/zm_utility
// Params 0, eflags: 0x0
// Checksum 0x5b3f122b, Offset: 0xd2a8
// Size: 0x16
function function_76c4a888() {
    self notify(#"hash_28af7943f07d93e2");
}

// Namespace zm_utility/zm_utility
// Params 1, eflags: 0x0
// Checksum 0xfc56fb3c, Offset: 0xd2c8
// Size: 0x2c
function function_130865b7(str_notify) {
    self setmovespeedscale(1);
}

// Namespace zm_utility/zm_utility
// Params 0, eflags: 0x0
// Checksum 0x87b532dc, Offset: 0xd300
// Size: 0xe6
function freeze_ai() {
    assert(isactor(self), "<dev string:x436>");
    if (isdefined(self.var_e6d9ae4b)) {
        self.var_e6d9ae4b.n_count++;
    } else {
        self.var_e6d9ae4b = {#n_count:1, #b_ignore_cleanup:self.b_ignore_cleanup, #var_c47ce878:self.is_inert};
    }
    self thread function_37c079cb();
    self setentitypaused(1);
    self.b_ignore_cleanup = 1;
    self.is_inert = 1;
}

// Namespace zm_utility/zm_utility
// Params 0, eflags: 0x0
// Checksum 0xa09f5d95, Offset: 0xd3f0
// Size: 0xc2
function function_31a2964e() {
    assert(isactor(self), "<dev string:x462>");
    self notify(#"hash_55e2fa9139b08b3e");
    var_e6d9ae4b = self.var_e6d9ae4b;
    var_e6d9ae4b.n_count--;
    if (var_e6d9ae4b.n_count == 0) {
        self setentitypaused(0);
        self.is_inert = var_e6d9ae4b.var_c47ce878;
        self.b_ignore_cleanup = var_e6d9ae4b.b_ignore_cleanup;
        self.var_e6d9ae4b = undefined;
    }
}

// Namespace zm_utility/zm_utility
// Params 0, eflags: 0x4
// Checksum 0xb36890fe, Offset: 0xd4c0
// Size: 0x9c
function private function_37c079cb() {
    self notify(#"hash_55e2fa9139b08b3e");
    self endon(#"hash_55e2fa9139b08b3e");
    self waittill(#"death");
    if (isdefined(self) && self ispaused()) {
        self setentitypaused(0);
        if (!self isragdoll()) {
            self startragdoll();
        }
    }
}

// Namespace zm_utility/zm_utility
// Params 1, eflags: 0x0
// Checksum 0xc419db17, Offset: 0xd568
// Size: 0x72
function get_player_closest_to(e_target) {
    a_players = arraycopy(level.activeplayers);
    arrayremovevalue(a_players, e_target);
    e_closest_player = arraygetclosest(e_target.origin, a_players);
    return e_closest_player;
}

// Namespace zm_utility/zm_utility
// Params 3, eflags: 0x0
// Checksum 0xfa2a0cff, Offset: 0xd5e8
// Size: 0x168
function is_facing(facee, requireddot = 0.5, b_2d = 1) {
    orientation = self getplayerangles();
    v_forward = anglestoforward(orientation);
    v_to_facee = facee.origin - self.origin;
    if (b_2d) {
        v_forward_computed = (v_forward[0], v_forward[1], 0);
        v_to_facee_computed = (v_to_facee[0], v_to_facee[1], 0);
    } else {
        v_forward_computed = v_forward;
        v_to_facee_computed = v_to_facee;
    }
    v_unit_forward_computed = vectornormalize(v_forward_computed);
    v_unit_to_facee_computed = vectornormalize(v_to_facee_computed);
    dotproduct = vectordot(v_unit_forward_computed, v_unit_to_facee_computed);
    return dotproduct > requireddot;
}

// Namespace zm_utility/zm_utility
// Params 0, eflags: 0x0
// Checksum 0xc0b0b1bc, Offset: 0xd758
// Size: 0x3c
function is_solo_ranked_game() {
    return level.players.size == 1 && getdvarint(#"zm_private_rankedmatch", 0);
}

// Namespace zm_utility/zm_utility
// Params 0, eflags: 0x0
// Checksum 0xe11c3f1b, Offset: 0xd7a0
// Size: 0x34
function function_35f92ae2() {
    return level.rankedmatch || getdvarint(#"zm_private_rankedmatch", 0);
}

// Namespace zm_utility/zm_utility
// Params 0, eflags: 0x0
// Checksum 0x96e397fb, Offset: 0xd7e0
// Size: 0x3c
function function_47c04da0() {
    level.var_edb57d85 = new throttle();
    [[ level.var_edb57d85 ]]->initialize(1, 0.1);
}

// Namespace zm_utility/zm_utility
// Params 2, eflags: 0x0
// Checksum 0xca7357a1, Offset: 0xd828
// Size: 0x2c
function function_620780d9(v_magnitude, e_attacker) {
    self thread launch_ragdoll(v_magnitude, e_attacker);
}

// Namespace zm_utility/zm_utility
// Params 2, eflags: 0x4
// Checksum 0xcfbdcb90, Offset: 0xd860
// Size: 0xac
function private launch_ragdoll(v_magnitude, e_attacker) {
    self endon(#"death");
    [[ level.var_edb57d85 ]]->waitinqueue(self);
    self startragdoll();
    self launchragdoll(v_magnitude);
    util::wait_network_frame();
    if (isdefined(self)) {
        self dodamage(self.health, self.origin, e_attacker);
    }
}

// Namespace zm_utility/zm_utility
// Params 1, eflags: 0x0
// Checksum 0xa317bf07, Offset: 0xd918
// Size: 0x6a
function set_max_health(var_68b2d7ae = 0) {
    if (self.health < self.var_63f2cd6e) {
        self.health = self.var_63f2cd6e;
    }
    if (var_68b2d7ae) {
        if (self.health > self.var_63f2cd6e) {
            self.health = self.var_63f2cd6e;
        }
    }
}

// Namespace zm_utility/zm_utility
// Params 3, eflags: 0x0
// Checksum 0xfff46d3, Offset: 0xd990
// Size: 0x1ac
function add_armor(var_c80ca065, var_e8fefd78, var_c2bdefb6) {
    if (!isdefined(self.var_9c4ffa57)) {
        self.var_9c4ffa57 = [];
    }
    if (!isdefined(self.var_9c4ffa57)) {
        self.var_9c4ffa57 = [];
    } else if (!isarray(self.var_9c4ffa57)) {
        self.var_9c4ffa57 = array(self.var_9c4ffa57);
    }
    if (!isinarray(self.var_9c4ffa57, var_c80ca065)) {
        self.var_9c4ffa57[self.var_9c4ffa57.size] = var_c80ca065;
    }
    var_405b8cdf = 0;
    if (isdefined(var_c2bdefb6)) {
        var_71e321d9 = var_c2bdefb6 - self get_armor(var_c80ca065);
        if (var_e8fefd78 <= var_71e321d9) {
            self.armor += var_e8fefd78;
            var_405b8cdf = var_e8fefd78;
        } else {
            self.armor += var_71e321d9;
            var_405b8cdf = var_71e321d9;
        }
    } else {
        self.armor += var_e8fefd78;
        var_405b8cdf = var_e8fefd78;
    }
    var_405b8cdf += self get_armor(var_c80ca065);
    self player::function_129882c1(var_c80ca065, var_405b8cdf);
}

// Namespace zm_utility/zm_utility
// Params 2, eflags: 0x0
// Checksum 0xc2ca79bb, Offset: 0xdb48
// Size: 0xb4
function function_34517e89(var_c80ca065, var_7df8cfe3 = 0) {
    if (isdefined(self.var_759e1044[var_c80ca065]) && self.var_759e1044[var_c80ca065] > 0) {
        if (var_7df8cfe3) {
            self.armor -= self.var_759e1044[var_c80ca065];
        }
        self player::function_20786ad7(var_c80ca065);
    }
    if (isdefined(self.var_9c4ffa57)) {
        arrayremovevalue(self.var_9c4ffa57, var_c80ca065);
    }
}

// Namespace zm_utility/zm_utility
// Params 1, eflags: 0x0
// Checksum 0xa04f7488, Offset: 0xdc08
// Size: 0x30
function get_armor(var_c80ca065) {
    if (isdefined(self.var_759e1044[var_c80ca065])) {
        return self.var_759e1044[var_c80ca065];
    }
    return 0;
}

// Namespace zm_utility/zm_utility
// Params 3, eflags: 0x0
// Checksum 0xa4e130b0, Offset: 0xdc40
// Size: 0x222
function damage_armor(n_damage, mod_type, e_attacker) {
    if (self.armor <= 0) {
        return n_damage;
    }
    var_fe1605ca = int(self.armor * 2);
    if (n_damage > var_fe1605ca) {
        while (self.var_9c4ffa57.size) {
            self function_34517e89(self.var_9c4ffa57[0], 1);
        }
        return (n_damage - var_fe1605ca);
    }
    var_fe1605ca = int(n_damage / 2);
    self.armor -= var_fe1605ca;
    var_609fde54 = 0;
    while (var_609fde54 < var_fe1605ca && self.var_9c4ffa57.size) {
        str_armor = self.var_9c4ffa57[self.var_9c4ffa57.size - 1];
        if (self get_armor(str_armor) > var_fe1605ca) {
            var_899353bc = self get_armor(str_armor) - var_fe1605ca - var_609fde54;
            self player::function_129882c1(str_armor, var_899353bc);
            var_609fde54 += var_fe1605ca;
            continue;
        }
        var_609fde54 += self get_armor(str_armor);
        self function_34517e89(str_armor);
    }
    self notify(#"damage_armor", {#mod:mod_type, #attacker:e_attacker});
    return 0;
}

// Namespace zm_utility/zm_utility
// Params 0, eflags: 0x0
// Checksum 0xcb1b7872, Offset: 0xde70
// Size: 0xf6
function function_eada9bee() {
    self endon(#"death");
    while (true) {
        waitresult = self waittill(#"zone_change");
        if (isdefined(waitresult.zone)) {
            self.inner_zigzag_radius = waitresult.zone.inner_zigzag_radius;
            self.outer_zigzag_radius = waitresult.zone.outer_zigzag_radius;
            self.zigzag_distance_min = waitresult.zone.zigzag_distance_min;
            self.zigzag_distance_max = waitresult.zone.zigzag_distance_max;
            self.zigzag_activation_distance = waitresult.zone.zigzag_activation_distance;
            self.var_bf3d3b68 = waitresult.zone.zigzag_enabled;
        }
    }
}

// Namespace zm_utility/zm_utility
// Params 0, eflags: 0x0
// Checksum 0x7f2006c9, Offset: 0xdf70
// Size: 0x40
function function_b1b590cc() {
    if (self.classname == "script_vehicle" && isplayer(self.owner)) {
        return true;
    }
    return false;
}

// Namespace zm_utility/zm_utility
// Params 0, eflags: 0x0
// Checksum 0x6b04d946, Offset: 0xdfb8
// Size: 0x9e
function function_e8fc435c() {
    if (isdefined(level.var_c2c388dd)) {
        foreach (var_fe02b3ff in level.var_c2c388dd) {
            if (distancesquared(self.origin, var_fe02b3ff) < 10000) {
                return true;
            }
        }
    }
    return false;
}

// Namespace zm_utility/zm_utility
// Params 2, eflags: 0x0
// Checksum 0xb471acb9, Offset: 0xe060
// Size: 0x9e
function function_23a24406(position, search_radius = 128) {
    goal_pos = getclosestpointonnavmesh(position, search_radius, self getpathfindingradius());
    if (isdefined(goal_pos)) {
        self function_3c8dce03(goal_pos);
        return true;
    }
    self function_3c8dce03(self.origin);
    return false;
}

// Namespace zm_utility/zm_utility
// Params 0, eflags: 0x0
// Checksum 0x4983f9dd, Offset: 0xe108
// Size: 0xfa
function function_c0225f18() {
    a_e_players = getplayers();
    e_least_hunted = undefined;
    foreach (e_player in a_e_players) {
        if (!isdefined(e_player.hunted_by)) {
            e_player.hunted_by = 0;
        }
        if (!is_player_valid(e_player)) {
            continue;
        }
        if (!isdefined(e_least_hunted) || e_player.hunted_by < e_least_hunted.hunted_by) {
            e_least_hunted = e_player;
        }
    }
    return e_least_hunted;
}

// Namespace zm_utility/zm_utility
// Params 3, eflags: 0x0
// Checksum 0x2de184b, Offset: 0xe210
// Size: 0xe0
function function_6e3c4e7b(var_8d7a5087, var_da14fa07, var_607b6d97 = 1) {
    if (isdefined(var_da14fa07)) {
        s_objective_loc = struct::get(var_8d7a5087);
        n_obj_id = gameobjects::get_next_obj_id();
        objective_add(n_obj_id, "active", s_objective_loc.origin, var_da14fa07);
        function_eeba3a5c(n_obj_id, 1);
    }
    if (var_607b6d97) {
        function_ebffa94b(var_8d7a5087, 1);
    }
    return n_obj_id;
}

// Namespace zm_utility/zm_utility
// Params 2, eflags: 0x0
// Checksum 0xdabb36e9, Offset: 0xe2f8
// Size: 0x4c
function function_a6a6b4cc(n_obj_id, var_8d7a5087) {
    if (isdefined(n_obj_id)) {
        gameobjects::release_obj_id(n_obj_id);
    }
    function_ebffa94b(var_8d7a5087, 0);
}

// Namespace zm_utility/zm_utility
// Params 2, eflags: 0x0
// Checksum 0x77f89d62, Offset: 0xe350
// Size: 0x6c
function function_447e7c95(n_obj_id, b_show = 1) {
    if (isdefined(n_obj_id)) {
        if (b_show) {
            objective_setvisibletoplayer(n_obj_id, self);
            return;
        }
        objective_setinvisibletoplayer(n_obj_id, self);
    }
}

// Namespace zm_utility/zm_utility
// Params 2, eflags: 0x0
// Checksum 0x25e89e57, Offset: 0xe3c8
// Size: 0x1f0
function function_ebffa94b(str_targetname, b_enable = 1) {
    if (!isdefined(str_targetname)) {
        return;
    }
    var_7637cb2d = struct::get(str_targetname);
    var_5ea8b6f1 = struct::get_array(var_7637cb2d.target);
    foreach (var_44c3aeae in var_5ea8b6f1) {
        if (b_enable) {
            if (!isdefined(var_44c3aeae.var_ad112164)) {
                var_44c3aeae.var_ad112164 = util::spawn_model("tag_origin", var_44c3aeae.origin, var_44c3aeae.angles);
                var_44c3aeae.script_int = var_44c3aeae.script_int;
            }
            var_4267da6 = 6;
            if (isdefined(var_44c3aeae.var_d4108fff)) {
                var_4267da6 = var_44c3aeae.var_d4108fff;
            }
            var_44c3aeae.var_ad112164 clientfield::set("zm_zone_edge_marker_count", var_4267da6);
            continue;
        }
        if (isdefined(var_44c3aeae.var_ad112164)) {
            var_44c3aeae.var_ad112164 clientfield::set("zm_zone_edge_marker_count", 0);
            var_44c3aeae.var_ad112164 thread util::delayed_delete(0.1);
        }
    }
}

// Namespace zm_utility/zm_utility
// Params 1, eflags: 0x0
// Checksum 0x549af9ea, Offset: 0xe5c0
// Size: 0xaa
function function_828cdc5(weapon) {
    a_w_list = self getweaponslistprimaries();
    for (i = 0; i < a_w_list.size; i++) {
        if (a_w_list[i] == weapon && isdefined(self.var_77f503ec) && weapon.name + "_silver" === self.var_77f503ec[i]) {
            return true;
        }
    }
    return false;
}

// Namespace zm_utility/zm_utility
// Params 1, eflags: 0x0
// Checksum 0xbe363887, Offset: 0xe678
// Size: 0xb2
function function_2a166315(weapon) {
    a_w_list = self getweaponslistprimaries();
    for (i = 0; i < a_w_list.size; i++) {
        if (a_w_list[i] == weapon && isdefined(self.var_77f503ec) && weapon.name + "_silver" === self.var_77f503ec[i]) {
            self.var_77f503ec[i] = undefined;
        }
    }
}

// Namespace zm_utility/zm_utility
// Params 2, eflags: 0x0
// Checksum 0xfd7f49e6, Offset: 0xe738
// Size: 0x92
function function_a5e87276(n_round_number, str_endon) {
    if (isdefined(str_endon)) {
        self endon(str_endon);
    }
    if (!isdefined(level.round_number) || level.round_number < n_round_number) {
        while (true) {
            s_waitresult = level waittill(#"start_of_round");
            if (s_waitresult.n_round_number >= n_round_number) {
                return;
            }
        }
    }
}

// Namespace zm_utility/zm_utility
// Params 5, eflags: 0x0
// Checksum 0x4f324723, Offset: 0xe7d8
// Size: 0x3e8
function function_1a046290(var_c5a1c1de = 1, var_1aa01c2d = 1, b_hide_body = 0, var_4e873cbd = 1, var_a678bc51 = "white") {
    a_players = util::get_active_players();
    foreach (player in a_players) {
        player val::set(#"hash_2f1b514922b9901e", "takedamage", 0);
    }
    foreach (ai in getaiteamarray(level.zombie_team)) {
        if (isalive(ai) && !(isdefined(ai.var_8141c75) && ai.var_8141c75)) {
            if (var_c5a1c1de) {
                ai zm_cleanup::function_9d243698(0);
            }
            if (var_1aa01c2d || ai.archetype === "blight_father") {
                if (is_magic_bullet_shield_enabled(ai)) {
                    ai util::stop_magic_bullet_shield();
                }
                ai.allowdeath = 1;
                ai thread zombie_death::flame_death_fx();
                ai dodamage(ai.health + 666, ai.origin);
                if (b_hide_body) {
                    ai hide();
                    ai notsolid();
                }
            } else {
                ai delete();
            }
        }
        waitframe(1);
    }
    if (var_4e873cbd) {
        level thread lui::screen_flash(1, 1, 0.5, 1, var_a678bc51);
    } else {
        level thread lui::screen_flash(0.2, 0.5, 1, 0.8, "white");
    }
    foreach (player in a_players) {
        if (isdefined(player)) {
            player val::reset(#"hash_2f1b514922b9901e", "takedamage");
        }
    }
}

// Namespace zm_utility/zm_utility
// Params 0, eflags: 0x0
// Checksum 0xfe09c5f0, Offset: 0xebc8
// Size: 0x2c
function function_17b1a4d4() {
    level function_1a046290(0, 1, 0, 1, "black");
}

