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
#using scripts\core_common\scene_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\throttle_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\zm_common\ai\zm_ai_utility;
#using scripts\zm_common\util;
#using scripts\zm_common\zm;
#using scripts\zm_common\zm_ai_faller;
#using scripts\zm_common\zm_audio;
#using scripts\zm_common\zm_bgb;
#using scripts\zm_common\zm_camos;
#using scripts\zm_common\zm_characters;
#using scripts\zm_common\zm_cleanup_mgr;
#using scripts\zm_common\zm_customgame;
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
// Params 0, eflags: 0x6
// Checksum 0x62df45b0, Offset: 0x810
// Size: 0x4c
function private autoexec __init__system__() {
    system::register(#"zm_utility", &function_70a657d8, &postinit, undefined, undefined);
}

// Namespace zm_utility/zm_utility
// Params 0, eflags: 0x5 linked
// Checksum 0xad644b76, Offset: 0x868
// Size: 0x14c
function private function_70a657d8() {
    clientfield::register_clientuimodel("hudItems.armorType", 1, 2, "int", 0);
    clientfield::register_clientuimodel("hudItems.armorPercent", 1, 7, "float", 0);
    clientfield::register_clientuimodel("hudItems.scrap", 1, 16, "int");
    clientfield::register("scriptmover", "zm_zone_edge_marker_count", 1, getminbitcountfornum(15), "int");
    clientfield::register("toplayer", "zm_zone_out_of_bounds", 1, 1, "int");
    clientfield::register("actor", "flame_corpse_fx", 1, 1, "int");
    clientfield::register("scriptmover", "model_rarity_rob", 1, 3, "int");
}

// Namespace zm_utility/zm_utility
// Params 0, eflags: 0x5 linked
// Checksum 0x80f724d1, Offset: 0x9c0
// Size: 0x4
function private postinit() {
    
}

// Namespace zm_utility/zm_utility
// Params 0, eflags: 0x1 linked
// Checksum 0xe8711634, Offset: 0x9d0
// Size: 0x1c
function init_utility() {
    level thread check_solo_status();
}

// Namespace zm_utility/zm_utility
// Params 0, eflags: 0x1 linked
// Checksum 0x19225132, Offset: 0x9f8
// Size: 0x40
function is_classic() {
    str_gametype = util::get_game_type();
    if (str_gametype == #"zclassic") {
        return true;
    }
    return false;
}

// Namespace zm_utility/zm_utility
// Params 0, eflags: 0x1 linked
// Checksum 0x76ebaa4c, Offset: 0xa40
// Size: 0x40
function is_survival() {
    str_gametype = util::get_game_type();
    if (str_gametype == #"zsurvival") {
        return true;
    }
    return false;
}

// Namespace zm_utility/zm_utility
// Params 0, eflags: 0x1 linked
// Checksum 0x48082000, Offset: 0xa88
// Size: 0x40
function function_c200446c() {
    str_gametype = util::get_game_type();
    if (str_gametype == #"zonslaught") {
        return true;
    }
    return false;
}

// Namespace zm_utility/zm_utility
// Params 0, eflags: 0x1 linked
// Checksum 0x130b38cc, Offset: 0xad0
// Size: 0x40
function is_standard() {
    str_gametype = util::get_game_type();
    if (str_gametype == #"zstandard") {
        return true;
    }
    return false;
}

// Namespace zm_utility/zm_utility
// Params 0, eflags: 0x1 linked
// Checksum 0xf2deba41, Offset: 0xb18
// Size: 0x68
function is_trials() {
    str_gametype = util::get_game_type();
    if (str_gametype == #"ztrials" || level flag::exists(#"ztrial")) {
        return true;
    }
    return false;
}

// Namespace zm_utility/zm_utility
// Params 0, eflags: 0x1 linked
// Checksum 0x298ed7e8, Offset: 0xb88
// Size: 0x40
function is_tutorial() {
    str_gametype = util::get_game_type();
    if (str_gametype == #"ztutorial") {
        return true;
    }
    return false;
}

// Namespace zm_utility/zm_utility
// Params 0, eflags: 0x1 linked
// Checksum 0xf15b50ff, Offset: 0xbd0
// Size: 0x40
function is_grief() {
    str_gametype = util::get_game_type();
    if (str_gametype == #"zgrief") {
        return true;
    }
    return false;
}

// Namespace zm_utility/zm_utility
// Params 6, eflags: 0x1 linked
// Checksum 0xc475a9f, Offset: 0xc18
// Size: 0xfa
function function_d6046228(var_67441581, var_756ee4e5, var_bcb9de3e, var_299ea954, var_787a5e25, var_1e31f083) {
    if (is_trials()) {
        if (self function_8b1a219a() && isdefined(var_1e31f083)) {
            return var_1e31f083;
        } else if (isdefined(var_787a5e25)) {
            return var_787a5e25;
        }
    } else if (is_standard()) {
        if (self function_8b1a219a() && isdefined(var_299ea954)) {
            return var_299ea954;
        } else if (isdefined(var_bcb9de3e)) {
            return var_bcb9de3e;
        }
    }
    if (self function_8b1a219a() && isdefined(var_756ee4e5)) {
        return var_756ee4e5;
    }
    return var_67441581;
}

// Namespace zm_utility/zm_utility
// Params 0, eflags: 0x0
// Checksum 0x6b338ee1, Offset: 0xd20
// Size: 0x12
function get_cast() {
    return zm_maptable::get_cast();
}

// Namespace zm_utility/zm_utility
// Params 0, eflags: 0x1 linked
// Checksum 0x49442934, Offset: 0xd40
// Size: 0x12
function get_story() {
    return zm_maptable::get_story();
}

// Namespace zm_utility/zm_utility
// Params 0, eflags: 0x1 linked
// Checksum 0x9702f888, Offset: 0xd60
// Size: 0x80
function check_solo_status() {
    if (getnumexpectedplayers() == 1 && (!sessionmodeisonlinegame() || !sessionmodeisprivate() || zm_trial::is_trial_mode())) {
        level.is_forever_solo_game = 1;
        return;
    }
    level.is_forever_solo_game = 0;
}

// Namespace zm_utility/zm_utility
// Params 0, eflags: 0x1 linked
// Checksum 0x89d0c8fc, Offset: 0xde8
// Size: 0x1b4
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
// Params 0, eflags: 0x1 linked
// Checksum 0xb111d958, Offset: 0xfa8
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
// Checksum 0x44ed488d, Offset: 0x1028
// Size: 0x24
function make_supersprinter() {
    self zombie_utility::set_zombie_run_cycle("super_sprint");
}

// Namespace zm_utility/zm_utility
// Params 0, eflags: 0x1 linked
// Checksum 0x5a1a6f30, Offset: 0x1058
// Size: 0x34
function speed_change_watcher() {
    self waittill(#"death");
    if (level.speed_change_num > 0) {
        level.speed_change_num--;
    }
}

// Namespace zm_utility/zm_utility
// Params 1, eflags: 0x1 linked
// Checksum 0x2df9da43, Offset: 0x1098
// Size: 0x4f2
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
            if (!is_true(self.dontshow)) {
                self show();
            }
            self notify(#"risen", {#find_flesh_struct_string:spot.script_string});
        }
    }
}

// Namespace zm_utility/zm_utility
// Params 1, eflags: 0x1 linked
// Checksum 0x34f5858a, Offset: 0x1598
// Size: 0x5c
function anchor_delete_failsafe(ai_zombie) {
    ai_zombie endon(#"risen");
    ai_zombie waittill(#"death");
    if (isdefined(self)) {
        self delete();
    }
}

// Namespace zm_utility/zm_utility
// Params 2, eflags: 0x1 linked
// Checksum 0x52f52ba7, Offset: 0x1600
// Size: 0xc8
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
// Params 2, eflags: 0x1 linked
// Checksum 0x535f28f5, Offset: 0x16d0
// Size: 0xb0
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
// Params 0, eflags: 0x1 linked
// Checksum 0x7403ac0d, Offset: 0x1788
// Size: 0x6
function is_encounter() {
    return false;
}

// Namespace zm_utility/zm_utility
// Params 2, eflags: 0x1 linked
// Checksum 0x834fcdcc, Offset: 0x1798
// Size: 0x128
function all_chunks_destroyed(barrier, barrier_chunks) {
    if (isdefined(barrier.zbarrier)) {
        pieces = arraycombine(barrier.zbarrier getzbarrierpieceindicesinstate("open"), barrier.zbarrier getzbarrierpieceindicesinstate("opening"), 1, 0);
        if (pieces.size != barrier.zbarrier getnumzbarrierpieces()) {
            return false;
        }
    } else if (isdefined(barrier_chunks)) {
        assert(isdefined(barrier_chunks), "<dev string:x38>");
        for (i = 0; i < barrier_chunks.size; i++) {
            if (barrier_chunks[i] get_chunk_state() != "destroyed") {
                return false;
            }
        }
    }
    return true;
}

// Namespace zm_utility/zm_utility
// Params 1, eflags: 0x1 linked
// Checksum 0xdccb33c7, Offset: 0x18c8
// Size: 0x1fe
function check_point_in_playable_area(origin) {
    if (function_21f4ac36() && !isdefined(level.var_a2a9b2de)) {
        level.var_a2a9b2de = getnodearray("player_region", "script_noteworthy");
    }
    if (function_c85ebbbc() && !isdefined(level.playable_area)) {
        level.playable_area = getentarray("player_volume", "script_noteworthy");
    }
    valid_point = 0;
    if (isdefined(level.var_a2a9b2de)) {
        node = function_52c1730(origin + (0, 0, 40), level.var_a2a9b2de, 500);
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
// Params 4, eflags: 0x1 linked
// Checksum 0xe486c352, Offset: 0x1ad0
// Size: 0x36e
function check_point_in_enabled_zone(origin, zone_is_active, player_zones, player_regions) {
    if (isdefined(level.var_304d38af) && ![[ level.var_304d38af ]](origin)) {
        return 0;
    }
    if (function_c85ebbbc() && !isdefined(level.playable_area)) {
        level.playable_area = getentarray("player_volume", "script_noteworthy");
    }
    if (!isdefined(player_zones)) {
        player_zones = level.playable_area;
    }
    if (function_21f4ac36() && !isdefined(level.player_regions)) {
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
        node = function_52c1730(origin + (0, 0, 40), player_regions, 500);
        if (isdefined(node)) {
            zone = level.zones[node.targetname];
            if (isdefined(zone) && is_true(zone.is_enabled)) {
                if (zone_is_active === 1 && !is_true(zone.is_active)) {
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
            if (isdefined(zone) && is_true(zone.is_enabled)) {
                if (isdefined(zone_is_active) && zone_is_active == 1 && !is_true(zone.is_active)) {
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
// Params 1, eflags: 0x1 linked
// Checksum 0x5cea9a05, Offset: 0x1e48
// Size: 0x3e
function round_up_to_ten(score) {
    new_score = score - score % 10;
    if (new_score < score) {
        new_score += 10;
    }
    return new_score;
}

// Namespace zm_utility/zm_utility
// Params 2, eflags: 0x1 linked
// Checksum 0xe70b40ea, Offset: 0x1e90
// Size: 0x5c
function round_up_score(score, value) {
    score = int(score);
    new_score = score - score % value;
    if (new_score < score) {
        new_score += value;
    }
    return new_score;
}

// Namespace zm_utility/zm_utility
// Params 1, eflags: 0x1 linked
// Checksum 0xa72ad5b9, Offset: 0x1ef8
// Size: 0x3a
function halve_score(n_score) {
    n_score /= 2;
    n_score = round_up_score(n_score, 10);
    return n_score;
}

// Namespace zm_utility/zm_utility
// Params 7, eflags: 0x1 linked
// Checksum 0xe8bba28c, Offset: 0x1f40
// Size: 0x1e4
function create_zombie_point_of_interest(attract_dist, num_attractors, added_poi_value, start_turned_on, initial_attract_func, arrival_attract_func, poi_team) {
    if (!is_point_inside_enabled_zone(self.origin)) {
        return;
    }
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
// Params 0, eflags: 0x1 linked
// Checksum 0xcc1b82de, Offset: 0x2130
// Size: 0x54
function watch_for_poi_death() {
    self waittill(#"death");
    if (isinarray(level.zombie_poi_array, self)) {
        arrayremovevalue(level.zombie_poi_array, self);
    }
}

// Namespace zm_utility/zm_utility
// Params 0, eflags: 0x0
// Checksum 0x41fc7b67, Offset: 0x2190
// Size: 0x13a
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
// Params 4, eflags: 0x1 linked
// Checksum 0xb2713e71, Offset: 0x22d8
// Size: 0x50c
function create_zombie_point_of_interest_attractor_positions(var_b09c2334 = 15, n_height = 60, var_6b5dd73c, var_7262d151 = 0) {
    self endon(#"death");
    if (!isdefined(self.num_poi_attracts) || isdefined(self.script_noteworthy) && self.script_noteworthy != "zombie_poi") {
        return false;
    }
    queryresult = positionquery_source_navigation(self.origin, var_b09c2334 / 2, isdefined(var_6b5dd73c) ? var_6b5dd73c : self.max_attractor_dist, n_height / 2, var_b09c2334 / 2, 1, var_b09c2334 / 2);
    if (var_7262d151) {
        var_7162cf15 = getclosestpointonnavmesh(self.origin, var_6b5dd73c);
    } else {
        var_7162cf15 = getclosestpointonnavmesh(self.origin);
    }
    if (!isdefined(var_7162cf15)) {
        return false;
    }
    if (queryresult.data.size < self.num_poi_attracts) {
        self.num_poi_attracts = queryresult.data.size;
    }
    var_6b998daf = 0;
    for (i = 0; i < queryresult.data.size; i++) {
        if (!tracepassedonnavmesh(var_7162cf15, queryresult.data[i].origin, 15)) {
            /#
                if (is_true(level.var_565d6ce0)) {
                    recordstar(queryresult.data[i].origin, (1, 0, 0));
                    record3dtext("<dev string:x7b>", queryresult.data[i].origin + (0, 0, 8), (1, 0, 0));
                }
            #/
            continue;
        }
        if (is_true(level.validate_poi_attractors)) {
            passed = bullettracepassed(queryresult.data[i].origin + (0, 0, 24), self.origin + (0, 0, 24), 0, self);
            if (passed) {
                self.attractor_positions[var_6b998daf] = queryresult.data[i].origin;
                var_6b998daf++;
            } else {
                /#
                    if (is_true(level.var_565d6ce0)) {
                        recordstar(queryresult.data[i].origin, (1, 0, 0));
                        record3dtext("<dev string:x93>", queryresult.data[i].origin + (0, 0, 8), (1, 0, 0));
                    }
                #/
            }
        } else if (is_true(self.var_abfcb0d9)) {
            if (check_point_in_enabled_zone(queryresult.data[i].origin) && check_point_in_playable_area(queryresult.data[i].origin)) {
                self.attractor_positions[var_6b998daf] = queryresult.data[i].origin;
                var_6b998daf++;
            }
        } else {
            self.attractor_positions[var_6b998daf] = queryresult.data[i].origin;
            var_6b998daf++;
            /#
                if (is_true(level.var_565d6ce0)) {
                    recordstar(queryresult.data[i].origin, (0, 1, 0));
                }
            #/
        }
        if (self.num_poi_attracts == var_6b998daf) {
            break;
        }
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
// Checksum 0xf9ff92dc, Offset: 0x27f0
// Size: 0x3e6
function generated_radius_attract_positions(forward, offset, num_positions, attract_radius) {
    self endon(#"death");
    failed = 0;
    degs_per_pos = 360 / num_positions;
    for (i = offset; i < 360 + offset; i += degs_per_pos) {
        altforward = forward * attract_radius;
        rotated_forward = (cos(i) * altforward[0] - sin(i) * altforward[1], sin(i) * altforward[0] + cos(i) * altforward[1], altforward[2]);
        if (isdefined(level.poi_positioning_func)) {
            pos = [[ level.poi_positioning_func ]](self.origin, rotated_forward);
        } else if (is_true(level.use_alternate_poi_positioning)) {
            pos = zm_server_throttle::server_safe_ground_trace("poi_trace", 10, self.origin + rotated_forward + (0, 0, 10));
        } else {
            pos = zm_server_throttle::server_safe_ground_trace("poi_trace", 10, self.origin + rotated_forward + (0, 0, 100));
        }
        if (!isdefined(pos)) {
            failed++;
            continue;
        }
        if (is_true(level.use_alternate_poi_positioning)) {
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
    // Checksum 0xdf60b5dc, Offset: 0x2be0
    // Size: 0x98
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
    // Checksum 0x2ed82d30, Offset: 0x2c80
    // Size: 0x98
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
// Params 2, eflags: 0x1 linked
// Checksum 0x6723d545, Offset: 0x2d20
// Size: 0x400
function get_zombie_point_of_interest(origin, poi_array) {
    aiprofile_beginentry("get_zombie_point_of_interest");
    if (is_true(self.ignore_all_poi)) {
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
        if (is_true(best_poi._new_ground_trace)) {
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
// Checksum 0xe42231ee, Offset: 0x3128
// Size: 0x26
function activate_zombie_point_of_interest() {
    if (self.script_noteworthy != "zombie_poi") {
        return;
    }
    self.poi_active = 1;
}

// Namespace zm_utility/zm_utility
// Params 1, eflags: 0x1 linked
// Checksum 0xa52b3746, Offset: 0x3158
// Size: 0x11c
function deactivate_zombie_point_of_interest(dont_remove) {
    if (!isdefined(self.script_noteworthy) || self.script_noteworthy != "zombie_poi") {
        return;
    }
    arrayremovevalue(self.attractor_array, undefined);
    for (i = 0; i < self.attractor_array.size; i++) {
        self.attractor_array[i] notify(#"kill_poi");
    }
    self.attractor_array = [];
    self.claimed_attractor_positions = [];
    self.attractor_positions = [];
    self.poi_active = 0;
    if (is_true(dont_remove)) {
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
// Checksum 0xc4e23643, Offset: 0x3280
// Size: 0x108
function assign_zombie_point_of_interest(*origin, poi) {
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
// Params 1, eflags: 0x1 linked
// Checksum 0x2453d394, Offset: 0x3390
// Size: 0xce
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
// Params 3, eflags: 0x1 linked
// Checksum 0xe26153a5, Offset: 0x3468
// Size: 0x5a
function array_check_for_dupes_using_compare(array, single, is_equal_fn) {
    for (i = 0; i < array.size; i++) {
        if ([[ is_equal_fn ]](array[i], single)) {
            return false;
        }
    }
    return true;
}

// Namespace zm_utility/zm_utility
// Params 2, eflags: 0x1 linked
// Checksum 0x8514b302, Offset: 0x34d0
// Size: 0x22
function poi_locations_equal(loc1, loc2) {
    return loc1[0] == loc2[0];
}

// Namespace zm_utility/zm_utility
// Params 1, eflags: 0x1 linked
// Checksum 0x68375b6c, Offset: 0x3500
// Size: 0x39e
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
            if (is_true(level.validate_poi_attractors)) {
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
// Params 1, eflags: 0x1 linked
// Checksum 0xbb745de5, Offset: 0x38a8
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
// Params 1, eflags: 0x1 linked
// Checksum 0xda01e8cb, Offset: 0x3958
// Size: 0x4c
function update_poi_on_death(zombie_poi) {
    self endon(#"kill_poi");
    self waittill(#"death");
    self remove_poi_attractor(zombie_poi);
}

// Namespace zm_utility/zm_utility
// Params 1, eflags: 0x1 linked
// Checksum 0x8cde1b0e, Offset: 0x39b0
// Size: 0xac
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
// Checksum 0xde59490b, Offset: 0x3a68
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
// Checksum 0x46de34cd, Offset: 0x3c08
// Size: 0x8e
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
// Checksum 0xf3729d7d, Offset: 0x3ca0
// Size: 0xa8
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
// Params 1, eflags: 0x1 linked
// Checksum 0xdc931804, Offset: 0x3d50
// Size: 0x54
function default_validate_enemy_path_length(player) {
    d = distancesquared(self.origin, player.origin);
    if (d <= 1296) {
        return true;
    }
    return false;
}

// Namespace zm_utility/zm_utility
// Params 1, eflags: 0x1 linked
// Checksum 0x61d699f9, Offset: 0x3db0
// Size: 0xc8
function function_d0f02e71(archetype) {
    if (!isdefined(level.var_58903b1f)) {
        level.var_58903b1f = [];
    }
    if (!isdefined(level.var_58903b1f)) {
        level.var_58903b1f = [];
    } else if (!isarray(level.var_58903b1f)) {
        level.var_58903b1f = array(level.var_58903b1f);
    }
    if (!isinarray(level.var_58903b1f, archetype)) {
        level.var_58903b1f[level.var_58903b1f.size] = archetype;
    }
}

// Namespace zm_utility/zm_utility
// Params 0, eflags: 0x1 linked
// Checksum 0xe6114b5f, Offset: 0x3e80
// Size: 0x25c
function function_55295a16() {
    level waittill(#"start_of_round");
    while (true) {
        reset_closest_player = 1;
        zombies = [];
        if (isdefined(level.var_58903b1f)) {
            foreach (archetype in level.var_58903b1f) {
                ai = getaiarchetypearray(archetype, level.zombie_team);
                if (ai.size) {
                    zombies = arraycombine(zombies, ai, 0, 0);
                }
            }
        }
        foreach (zombie in zombies) {
            if (is_true(zombie.need_closest_player)) {
                reset_closest_player = 0;
                zombie.var_3a610ea4 = undefined;
                break;
            }
            zombie.var_3a610ea4 = undefined;
        }
        if (reset_closest_player) {
            foreach (zombie in zombies) {
                if (isdefined(zombie.need_closest_player)) {
                    zombie.need_closest_player = 1;
                    /#
                        zombie.var_26f25576 = undefined;
                    #/
                }
            }
        }
        waitframe(1);
    }
}

// Namespace zm_utility/zm_utility
// Params 1, eflags: 0x5 linked
// Checksum 0xc181c0e9, Offset: 0x40e8
// Size: 0xf2
function private function_5dcc54a8(players) {
    if (isdefined(self.last_closest_player) && is_true(self.last_closest_player.am_i_valid)) {
        return;
    }
    self.need_closest_player = 1;
    foreach (player in players) {
        if (is_true(player.am_i_valid)) {
            self.last_closest_player = player;
            return;
        }
    }
    self.last_closest_player = undefined;
}

// Namespace zm_utility/zm_utility
// Params 2, eflags: 0x1 linked
// Checksum 0x6fe27f7e, Offset: 0x41e8
// Size: 0x722
function function_c52e1749(origin, players) {
    if (players.size == 0) {
        return undefined;
    }
    if (isdefined(self.zombie_poi)) {
        return undefined;
    }
    if (players.size == 1) {
        self.last_closest_player = players[0];
        self.var_c6e0686b = distancesquared(players[0].origin, origin);
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
    var_88e86621 = spawnstruct();
    var_88e86621.height = self function_6a9ae71();
    var_88e86621.radius = self getpathfindingradius();
    var_88e86621.origin = origin;
    if (isdefined(self.var_6392b6c4)) {
        var_448ee423 = self [[ self.var_6392b6c4 ]](origin, players);
        playerpositions = [];
        if (isdefined(var_448ee423)) {
            foreach (var_5063dbdc in var_448ee423) {
                if (isdefined(var_5063dbdc.origin)) {
                    if (!isdefined(playerpositions)) {
                        playerpositions = [];
                    } else if (!isarray(playerpositions)) {
                        playerpositions = array(playerpositions);
                    }
                    playerpositions[playerpositions.size] = var_5063dbdc.origin;
                }
            }
        } else {
            var_448ee423 = [];
        }
    } else {
        playerpositions = [];
        var_448ee423 = [];
        foreach (player in players) {
            player_pos = player.last_valid_position;
            if (!isdefined(player_pos)) {
                player_pos = getclosestpointonnavmesh(player.origin, 100, var_88e86621.radius);
                if (!isdefined(player_pos)) {
                    continue;
                }
            }
            if (var_88e86621.radius > player getpathfindingradius()) {
                player_pos = getclosestpointonnavmesh(player.origin, 100, var_88e86621.radius);
            }
            pos = isdefined(player_pos) ? player_pos : player.origin;
            if (!isdefined(playerpositions)) {
                playerpositions = [];
            } else if (!isarray(playerpositions)) {
                playerpositions = array(playerpositions);
            }
            playerpositions[playerpositions.size] = pos;
            if (getdvarint(#"hash_4477ab37a00b1492", 1) == 1) {
                position_info = {#player:player, #origin:pos};
                if (!isdefined(var_448ee423)) {
                    var_448ee423 = [];
                } else if (!isarray(var_448ee423)) {
                    var_448ee423 = array(var_448ee423);
                }
                var_448ee423[var_448ee423.size] = position_info;
            }
        }
    }
    closestplayer = undefined;
    self.var_c6e0686b = undefined;
    if (ispointonnavmesh(var_88e86621.origin, self)) {
        pathdata = generatenavmeshpath(var_88e86621.origin, playerpositions, self);
        if (isdefined(pathdata) && pathdata.status === "succeeded") {
            goalpos = pathdata.pathpoints[pathdata.pathpoints.size - 1];
            if (getdvarint(#"hash_4477ab37a00b1492", 1) == 1) {
                position_info = arraygetclosest(goalpos, var_448ee423);
                if (isdefined(position_info)) {
                    closestplayer = position_info.player;
                }
            } else {
                foreach (index, position in playerpositions) {
                    if (isdefined(level.var_cd24b30)) {
                        if (distance2dsquared(position, goalpos) < function_a3f6cdac(16) && abs(position[2] - goalpos[2]) <= level.var_cd24b30) {
                            closestplayer = players[index];
                        }
                        continue;
                    }
                    if (distancesquared(position, goalpos) < function_a3f6cdac(16)) {
                        closestplayer = players[index];
                        break;
                    }
                }
            }
        }
    }
    /#
        self.var_26f25576 = gettime();
    #/
    self.last_closest_player = closestplayer;
    if (isdefined(closestplayer)) {
        self.var_c6e0686b = function_a3f6cdac(pathdata.pathdistance);
    }
    self function_5dcc54a8(players);
    return self.last_closest_player;
}

// Namespace zm_utility/zm_utility
// Params 3, eflags: 0x1 linked
// Checksum 0xd859514b, Offset: 0x4918
// Size: 0x590
function get_closest_valid_player(origin, ignore_player = array(), var_b106b254 = 0) {
    aiprofile_beginentry("get_closest_valid_player");
    players = getplayers();
    if (isdefined(level.zombie_targets) && level.zombie_targets.size > 0) {
        function_1eaaceab(level.zombie_targets);
        arrayremovevalue(level.zombie_targets, undefined);
        players = arraycombine(players, level.zombie_targets, 0, 0);
    }
    b_designated_target_exists = 0;
    foreach (player in players) {
        if (!is_true(player.am_i_valid)) {
            continue;
        }
        if (isdefined(level.var_63707e9c)) {
            if (![[ level.var_63707e9c ]](player)) {
                array::add(ignore_player, player);
            }
        }
        if (is_true(player.b_is_designated_target)) {
            b_designated_target_exists = 1;
        }
        if (isdefined(level.var_6f6cc58)) {
            if (![[ level.var_6f6cc58 ]](player)) {
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
            if (!is_true(player.am_i_valid)) {
                arrayremovevalue(players, player);
                done = 0;
                break;
            }
            if (b_designated_target_exists && !is_true(player.b_is_designated_target)) {
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
    if (!var_b106b254 && isdefined(self.closest_player_override)) {
        player = [[ self.closest_player_override ]](origin, players);
    } else if (!var_b106b254 && isdefined(level.closest_player_override)) {
        player = [[ level.closest_player_override ]](origin, players);
    } else {
        player = arraygetclosest(origin, players);
    }
    if (!isdefined(player)) {
        aiprofile_endentry();
        return undefined;
    }
    if (!isdefined(player.last_valid_position) || !getdvarint(#"hash_36389ea046a2ce6", 0) && !is_true(player.cached_zone_volume.var_8e4005b6) || abs(player.last_valid_position[2] - player.origin[2]) < 32 && distance2dsquared(player.last_valid_position, player.origin) < function_a3f6cdac(32)) {
        zm_ai_utility::function_4d22f6d1(self);
    } else {
        zm_ai_utility::function_68ab868a(self);
    }
    aiprofile_endentry();
    return player;
}

// Namespace zm_utility/zm_utility
// Params 2, eflags: 0x1 linked
// Checksum 0x71871927, Offset: 0x4eb0
// Size: 0x354
function update_valid_players(*origin, ignore_player) {
    aiprofile_beginentry("update_valid_players");
    players = arraycopy(level.players);
    foreach (player in players) {
        self setignoreent(player, 1);
    }
    b_designated_target_exists = 0;
    for (i = 0; i < players.size; i++) {
        player = players[i];
        if (!is_true(player.am_i_valid)) {
            continue;
        }
        if (isdefined(level.var_63707e9c)) {
            if (![[ level.var_63707e9c ]](player)) {
                array::add(ignore_player, player);
            }
        }
        if (is_true(player.b_is_designated_target)) {
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
            if (!is_true(player.am_i_valid)) {
                arrayremovevalue(players, player);
                done = 0;
                break;
            }
            if (b_designated_target_exists && !is_true(player.b_is_designated_target)) {
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
// Params 5, eflags: 0x1 linked
// Checksum 0xa923550e, Offset: 0x5210
// Size: 0x204
function is_player_valid(e_player, var_11e899f9 = 0, var_67fee570 = 0, var_6eefd462 = 1, var_da861165 = 1) {
    if (!isdefined(e_player)) {
        return 0;
    }
    if (!isentity(e_player)) {
        return 0;
    }
    if (!isplayer(e_player)) {
        return 0;
    }
    if (!isalive(e_player)) {
        return 0;
    }
    if (is_true(e_player.is_zombie)) {
        return 0;
    }
    if (e_player.sessionstate == "spectator" || e_player.sessionstate == "intermission") {
        return 0;
    }
    if (is_true(level.intermission)) {
        return 0;
    }
    if (!var_67fee570) {
        if (e_player laststand::player_is_in_laststand()) {
            return 0;
        }
    }
    if (var_11e899f9) {
        if (e_player.ignoreme || e_player isnotarget()) {
            return 0;
        }
    }
    if (!var_6eefd462) {
        if (e_player isplayerunderwater()) {
            return 0;
        }
    }
    if (!var_da861165 && e_player scene::is_igc_active()) {
        return 0;
    }
    if (isdefined(level.is_player_valid_override)) {
        return [[ level.is_player_valid_override ]](e_player);
    }
    return 1;
}

// Namespace zm_utility/zm_utility
// Params 0, eflags: 0x1 linked
// Checksum 0x4be90f19, Offset: 0x5420
// Size: 0x78
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
// Params 0, eflags: 0x1 linked
// Checksum 0x2a5ed9a2, Offset: 0x54a0
// Size: 0xec
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
// Params 2, eflags: 0x1 linked
// Checksum 0xec76dccf, Offset: 0x5598
// Size: 0x45c
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
// Params 2, eflags: 0x1 linked
// Checksum 0x9c188d9d, Offset: 0x5a00
// Size: 0x494
function non_destroyed_grate_order(*origin, chunks_grate) {
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
                            iprintlnbold("<dev string:xaa>");
                        #/
                        grate_order3[i] thread show_grate_pull();
                        return grate_order2[i];
                    }
                    if (grate_order3[i].state == "repaired") {
                        /#
                            iprintlnbold("<dev string:xb9>");
                        #/
                        grate_order4[i] thread show_grate_pull();
                        return grate_order3[i];
                    }
                    if (grate_order4[i].state == "repaired") {
                        /#
                            iprintlnbold("<dev string:xc8>");
                        #/
                        grate_order5[i] thread show_grate_pull();
                        return grate_order4[i];
                    }
                    if (grate_order5[i].state == "repaired") {
                        /#
                            iprintlnbold("<dev string:xd7>");
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
// Params 0, eflags: 0x1 linked
// Checksum 0x62eaa575, Offset: 0x5ea0
// Size: 0x5c
function show_grate_pull() {
    wait 0.53;
    self show();
    self vibrate((0, 270, 0), 0.2, 0.4, 0.4);
}

// Namespace zm_utility/zm_utility
// Params 2, eflags: 0x1 linked
// Checksum 0x6a27e6a7, Offset: 0x5f08
// Size: 0x1c6
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
// Params 0, eflags: 0x1 linked
// Checksum 0x80fb094, Offset: 0x60d8
// Size: 0x196
function in_playable_area() {
    if (function_21f4ac36() && !isdefined(level.var_a2a9b2de)) {
        level.var_a2a9b2de = getnodearray("player_region", "script_noteworthy");
    }
    if (function_c85ebbbc() && !isdefined(level.playable_area)) {
        level.playable_area = getentarray("player_volume", "script_noteworthy");
    }
    if (!isdefined(level.playable_area) && !isdefined(level.var_a2a9b2de)) {
        println("<dev string:xe6>");
        return true;
    }
    if (isdefined(level.var_a2a9b2de)) {
        node = function_52c1730(self.origin, level.var_a2a9b2de, 500);
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
// Params 3, eflags: 0x1 linked
// Checksum 0xa519bc2e, Offset: 0x6278
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
// Params 2, eflags: 0x1 linked
// Checksum 0xdaa236da, Offset: 0x6390
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
// Params 1, eflags: 0x1 linked
// Checksum 0x59c79eec, Offset: 0x64b0
// Size: 0x9e
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
// Params 2, eflags: 0x1 linked
// Checksum 0xd80f6c80, Offset: 0x6558
// Size: 0x38a
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
// Params 2, eflags: 0x1 linked
// Checksum 0x35e6ebe, Offset: 0x68f0
// Size: 0xdc
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
// Params 1, eflags: 0x1 linked
// Checksum 0x2d3cec4a, Offset: 0x69d8
// Size: 0x1a0
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
// Params 1, eflags: 0x1 linked
// Checksum 0x16478908, Offset: 0x6b80
// Size: 0x4c4
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
                        iprintlnbold("<dev string:x12d>");
                    #/
                    return grate_repair_order6[i];
                }
                if (grate_repair_order5[i].state == "destroyed") {
                    /#
                        iprintlnbold("<dev string:x13d>");
                    #/
                    grate_repair_order6[i] thread show_grate_repair();
                    return grate_repair_order5[i];
                }
                if (grate_repair_order4[i].state == "destroyed") {
                    /#
                        iprintlnbold("<dev string:x14d>");
                    #/
                    grate_repair_order5[i] thread show_grate_repair();
                    return grate_repair_order4[i];
                }
                if (grate_repair_order3[i].state == "destroyed") {
                    /#
                        iprintlnbold("<dev string:x15d>");
                    #/
                    grate_repair_order4[i] thread show_grate_repair();
                    return grate_repair_order3[i];
                }
                if (grate_repair_order2[i].state == "destroyed") {
                    /#
                        iprintlnbold("<dev string:x16d>");
                    #/
                    grate_repair_order3[i] thread show_grate_repair();
                    return grate_repair_order2[i];
                }
                if (grate_repair_order1[i].state == "destroyed") {
                    /#
                        iprintlnbold("<dev string:x17d>");
                    #/
                    grate_repair_order2[i] thread show_grate_repair();
                    return grate_repair_order1[i];
                }
            }
        }
    }
}

// Namespace zm_utility/zm_utility
// Params 0, eflags: 0x1 linked
// Checksum 0xb84b8fa7, Offset: 0x7050
// Size: 0x24
function show_grate_repair() {
    wait 0.34;
    self hide();
}

// Namespace zm_utility/zm_utility
// Params 0, eflags: 0x1 linked
// Checksum 0xdacdbadf, Offset: 0x7080
// Size: 0x2a
function get_chunk_state() {
    assert(isdefined(self.state));
    return self.state;
}

// Namespace zm_utility/zm_utility
// Params 2, eflags: 0x1 linked
// Checksum 0x6d97e236, Offset: 0x70b8
// Size: 0x138
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
// Params 2, eflags: 0x1 linked
// Checksum 0xd4e3a5a6, Offset: 0x71f8
// Size: 0x40
function add_zombie_hint(ref, text) {
    if (!isdefined(level.zombie_hints)) {
        level.zombie_hints = [];
    }
    level.zombie_hints[ref] = text;
}

// Namespace zm_utility/zm_utility
// Params 1, eflags: 0x1 linked
// Checksum 0x50f94eea, Offset: 0x7240
// Size: 0x6c
function get_zombie_hint(ref) {
    if (isdefined(level.zombie_hints[ref])) {
        return level.zombie_hints[ref];
    }
    println("<dev string:x18d>" + ref);
    return level.zombie_hints[#"undefined"];
}

// Namespace zm_utility/zm_utility
// Params 3, eflags: 0x1 linked
// Checksum 0x30bb2173, Offset: 0x72b8
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
// Params 3, eflags: 0x1 linked
// Checksum 0xdb143cd1, Offset: 0x7368
// Size: 0x5a
function get_hint_string(ent, default_ref, *cost) {
    ref = cost;
    if (isdefined(default_ref.script_hint)) {
        ref = default_ref.script_hint;
    }
    return get_zombie_hint(ref);
}

// Namespace zm_utility/zm_utility
// Params 2, eflags: 0x1 linked
// Checksum 0xf263d478, Offset: 0x73d0
// Size: 0x40
function add_sound(ref, alias) {
    if (!isdefined(level.zombie_sounds)) {
        level.zombie_sounds = [];
    }
    level.zombie_sounds[ref] = alias;
}

// Namespace zm_utility/zm_utility
// Params 3, eflags: 0x1 linked
// Checksum 0x22c9df01, Offset: 0x7418
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
        assertmsg("<dev string:x1ac>" + ref + "<dev string:x1b7>");
        return;
    }
    playsoundatposition(level.zombie_sounds[ref], pos);
}

// Namespace zm_utility/zm_utility
// Params 1, eflags: 0x1 linked
// Checksum 0xa68a2d8c, Offset: 0x7510
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
        assertmsg("<dev string:x1ac>" + ref + "<dev string:x1b7>");
        return;
    }
    self playsound(level.zombie_sounds[ref]);
}

// Namespace zm_utility/zm_utility
// Params 1, eflags: 0x0
// Checksum 0x8d16723d, Offset: 0x75e0
// Size: 0x94
function play_loopsound_on_ent(ref) {
    if (isdefined(self.script_firefxsound)) {
        ref = self.script_firefxsound;
    }
    if (ref == "none") {
        return;
    }
    if (!isdefined(level.zombie_sounds[ref])) {
        assertmsg("<dev string:x1ac>" + ref + "<dev string:x1b7>");
        return;
    }
    self playsound(level.zombie_sounds[ref]);
}

/#

    // Namespace zm_utility/zm_utility
    // Params 2, eflags: 0x0
    // Checksum 0x5cd1da70, Offset: 0x7680
    // Size: 0xa6
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
    // Checksum 0x54ad6c4d, Offset: 0x7730
    // Size: 0xbe
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
    // Checksum 0x74509b65, Offset: 0x77f8
    // Size: 0x5c
    function debug_print(msg) {
        if (getdvarint(#"zombie_debug", 0) > 0) {
            println("<dev string:x222>" + msg);
        }
    }

    // Namespace zm_utility/zm_utility
    // Params 3, eflags: 0x0
    // Checksum 0x1b5ec98b, Offset: 0x7860
    // Size: 0x98
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
    // Checksum 0x8f721f2b, Offset: 0x7900
    // Size: 0x234
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
    // Checksum 0x4b754515, Offset: 0x7b40
    // Size: 0x170
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
            msg = "<dev string:x238>" + count + "<dev string:x23c>" + self.attack_spots_taken.size;
            print3d(self.origin, msg);
        }
    }

    // Namespace zm_utility/zm_utility
    // Params 2, eflags: 0x0
    // Checksum 0x1b681732, Offset: 0x7cb8
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
// Params 2, eflags: 0x1 linked
// Checksum 0x87a4cb06, Offset: 0x7d68
// Size: 0x114
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
// Params 1, eflags: 0x1 linked
// Checksum 0x9e2302d1, Offset: 0x7e88
// Size: 0x34
function is_magic_bullet_shield_enabled(ent) {
    if (!isdefined(ent)) {
        return false;
    }
    return !is_true(ent.allowdeath);
}

// Namespace zm_utility/zm_utility
// Params 1, eflags: 0x0
// Checksum 0xb5ded698, Offset: 0x7ec8
// Size: 0x8c
function play_sound_2d(sound) {
    temp_ent = spawn("script_origin", (0, 0, 0));
    temp_ent playsoundwithnotify(sound, sound + "wait");
    temp_ent waittill(sound + "wait");
    waitframe(1);
    temp_ent delete();
}

// Namespace zm_utility/zm_utility
// Params 2, eflags: 0x1 linked
// Checksum 0x66639705, Offset: 0x7f60
// Size: 0x6c
function include_weapon(weapon_name, in_box) {
    println("<dev string:x243>" + function_9e72a96(weapon_name));
    if (!isdefined(in_box)) {
        in_box = 1;
    }
    zm_weapons::include_zombie_weapon(weapon_name, in_box);
}

// Namespace zm_utility/zm_utility
// Params 6, eflags: 0x0
// Checksum 0xf4c37f96, Offset: 0x7fd8
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
        while (!is_true(level.disable_print3d_ent)) {
            print3d(self.origin + offset, self._debug_print3d_msg, color, scale);
            waitframe(1);
        }
    #/
}

// Namespace zm_utility/zm_utility
// Params 0, eflags: 0x1 linked
// Checksum 0x2db35373, Offset: 0x8128
// Size: 0x30
function function_21f4ac36() {
    return getdvarint(#"hash_42c75b39576494a5", 1) == 1;
}

// Namespace zm_utility/zm_utility
// Params 0, eflags: 0x1 linked
// Checksum 0x45c4fe3b, Offset: 0x8160
// Size: 0x30
function function_c85ebbbc() {
    return getdvarint(#"hash_6ec233a56690f409", 1) == 1;
}

// Namespace zm_utility/zm_utility
// Params 2, eflags: 0x0
// Checksum 0x77f96088, Offset: 0x8198
// Size: 0x3a
function function_b0eeaada(location, max_drop_distance = 500) {
    return function_9cc082d2(location, max_drop_distance);
}

// Namespace zm_utility/zm_utility
// Params 2, eflags: 0x0
// Checksum 0x51621756, Offset: 0x81e0
// Size: 0x46
function function_a1055d95(location, node) {
    return isdefined(location) && location[#"region"] === getnoderegion(node);
}

// Namespace zm_utility/zm_utility
// Params 2, eflags: 0x1 linked
// Checksum 0x62c01f38, Offset: 0x8230
// Size: 0x40c
function get_current_zone(return_zone = 0, immediate = 1) {
    if (!isdefined(self)) {
        return undefined;
    }
    self endon(#"death");
    level flag::wait_till("zones_initialized");
    if (function_c85ebbbc()) {
        foreach (zone in level.zones) {
            for (i = 0; i < zone.volumes.size; i++) {
                if (self istouching(zone.volumes[i])) {
                    if (zone !== self.cached_zone) {
                        self.cached_zone = zone;
                        self.cached_zone_name = zone.name;
                        self.var_3b65cdd7 = undefined;
                        self notify(#"zone_change", {#zone:zone, #zone_name:zone.name});
                    }
                    self.cached_zone_volume = zone.volumes[i];
                    if (is_true(return_zone)) {
                        return zone;
                    }
                    return zone.name;
                }
            }
        }
    }
    if (!immediate) {
        waitframe(1);
    }
    if (function_21f4ac36()) {
        node = self.var_3b65cdd7;
        var_3e5dca65 = self.origin;
        if (isplayer(self)) {
            if (isdefined(self.last_valid_position) && distancesquared(self.origin, self.last_valid_position) < function_a3f6cdac(32)) {
                var_3e5dca65 = self.last_valid_position;
            }
        }
        self.var_3b65cdd7 = function_52c1730(var_3e5dca65, level.zone_nodes, 500);
        if (isdefined(self.var_3b65cdd7)) {
            if (node !== self.var_3b65cdd7 || isdefined(node) && node.targetname !== self.var_3b65cdd7.targetname) {
                self.cached_zone = level.zones[self.var_3b65cdd7.targetname];
                self.cached_zone_name = self.cached_zone.name;
                self notify(#"zone_change", {#zone:self.cached_zone, #zone_name:self.cached_zone_name});
            }
            self.cached_zone_volume = undefined;
            if (return_zone) {
                return level.zones[self.var_3b65cdd7.targetname];
            } else {
                return self.var_3b65cdd7.targetname;
            }
        }
    }
    self.cached_zone = undefined;
    self.cached_zone_name = undefined;
    self.cached_zone_volume = undefined;
    self.var_3b65cdd7 = undefined;
    return undefined;
}

// Namespace zm_utility/zm_utility
// Params 0, eflags: 0x1 linked
// Checksum 0xd7479828, Offset: 0x8648
// Size: 0x78
function update_zone_name() {
    self notify("74a2d22587f8a60e");
    self endon("74a2d22587f8a60e");
    self endon(#"death");
    while (isdefined(self)) {
        self.zone_name = get_current_zone(0, 0);
        wait randomfloatrange(0.5, 1);
    }
}

// Namespace zm_utility/zm_utility
// Params 0, eflags: 0x1 linked
// Checksum 0x9c3e2c3a, Offset: 0x86c8
// Size: 0x300
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
            if (is_true(self.is_burning)) {
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
// Params 3, eflags: 0x1 linked
// Checksum 0xadc422cd, Offset: 0x89d0
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
// Params 1, eflags: 0x1 linked
// Checksum 0xc8da8924, Offset: 0x8ae8
// Size: 0xb0
function increment_is_drinking(var_12d2689b = 0) {
    /#
        if (is_true(level.devgui_dpad_watch)) {
            self.is_drinking++;
            return;
        }
    #/
    if (!isdefined(self.is_drinking)) {
        self.is_drinking = 0;
    }
    if (self.is_drinking == 0) {
        if (!var_12d2689b) {
            self disableoffhandweapons();
        }
        self disableweaponcycling();
    }
    self.is_drinking++;
}

// Namespace zm_utility/zm_utility
// Params 0, eflags: 0x1 linked
// Checksum 0x328ab65e, Offset: 0x8ba0
// Size: 0x4e
function is_drinking() {
    return isdefined(self.is_drinking) && self.is_drinking > 0 || isplayer(self) && self function_55acff10();
}

// Namespace zm_utility/zm_utility
// Params 0, eflags: 0x1 linked
// Checksum 0x2c853713, Offset: 0x8bf8
// Size: 0x1e
function is_multiple_drinking() {
    return isdefined(self.is_drinking) && self.is_drinking > 1;
}

// Namespace zm_utility/zm_utility
// Params 0, eflags: 0x1 linked
// Checksum 0xf97a3b95, Offset: 0x8c20
// Size: 0x74
function decrement_is_drinking() {
    if (self.is_drinking > 0) {
        self.is_drinking--;
    } else {
        assertmsg("<dev string:x25e>");
    }
    if (self.is_drinking == 0) {
        self enableoffhandweapons();
        self enableweaponcycling();
    }
}

// Namespace zm_utility/zm_utility
// Params 0, eflags: 0x1 linked
// Checksum 0xe089a678, Offset: 0x8ca0
// Size: 0x3c
function clear_is_drinking() {
    self.is_drinking = 0;
    self enableoffhandweapons();
    self enableweaponcycling();
}

// Namespace zm_utility/zm_utility
// Params 0, eflags: 0x1 linked
// Checksum 0x39b6a1a9, Offset: 0x8ce8
// Size: 0x2e
function function_91403f47() {
    if (!isdefined(level.var_1d72fbba)) {
        level.var_1d72fbba = 0;
    }
    return level.var_1d72fbba > 0;
}

// Namespace zm_utility/zm_utility
// Params 0, eflags: 0x0
// Checksum 0xd5194906, Offset: 0x8d20
// Size: 0x2c
function function_3e549e65() {
    if (!isdefined(level.var_1d72fbba)) {
        level.var_1d72fbba = 0;
    }
    level.var_1d72fbba++;
}

// Namespace zm_utility/zm_utility
// Params 0, eflags: 0x0
// Checksum 0x1b56b7d9, Offset: 0x8d58
// Size: 0x74
function function_b7e5029f() {
    if (!isdefined(level.var_1d72fbba)) {
        level.var_1d72fbba = 0;
    }
    if (level.var_1d72fbba > 0) {
        level.var_1d72fbba--;
    } else {
        assertmsg("<dev string:x280>");
    }
    level zm_player::function_8ef51109();
}

// Namespace zm_utility/zm_utility
// Params 3, eflags: 0x1 linked
// Checksum 0xefd8d5b, Offset: 0x8dd8
// Size: 0x178
function can_use(e_player, b_is_weapon = 0, var_67fee570 = 0) {
    if (!is_player_valid(e_player, 0, var_67fee570) || e_player in_revive_trigger() || e_player isthrowinggrenade() || e_player isswitchingweapons() || e_player is_drinking()) {
        return false;
    }
    if (b_is_weapon) {
        w_current = e_player getcurrentweapon();
        if (!e_player zm_magicbox::can_buy_weapon(0) || e_player bgb::is_enabled(#"zm_bgb_disorderly_combat") || zm_loadout::is_placeable_mine(w_current) || zm_equipment::is_equipment(w_current) || ability_util::is_weapon_gadget(w_current)) {
            return false;
        }
    }
    return true;
}

// Namespace zm_utility/zm_utility
// Params 1, eflags: 0x1 linked
// Checksum 0xca1aaddd, Offset: 0x8f58
// Size: 0xfc
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
// Params 5, eflags: 0x1 linked
// Checksum 0xca1b4421, Offset: 0x9060
// Size: 0xc0
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
// Params 5, eflags: 0x1 linked
// Checksum 0x4005a5ef, Offset: 0x9128
// Size: 0xe0
function spawn_buildkit_weapon_model(player, weapon, var_3ded6a21, origin, angles) {
    weapon_model = spawn("script_model", origin);
    if (isdefined(angles)) {
        weapon_model.angles = angles;
    }
    upgraded = zm_weapons::is_weapon_upgraded(weapon);
    if (upgraded && (!isdefined(var_3ded6a21) || 0 > var_3ded6a21)) {
        var_3ded6a21 = player zm_camos::function_4f727cf5(weapon);
    }
    weapon_model usebuildkitweaponmodel(player, weapon, var_3ded6a21);
    return weapon_model;
}

// Namespace zm_utility/zm_utility
// Params 1, eflags: 0x1 linked
// Checksum 0x8c4cab1, Offset: 0x9210
// Size: 0x3a
function is_player_revive_tool(weapon) {
    if (weapon == level.weaponrevivetool || weapon === self.weaponrevivetool) {
        return true;
    }
    return false;
}

// Namespace zm_utility/zm_utility
// Params 1, eflags: 0x0
// Checksum 0x99f3bc92, Offset: 0x9258
// Size: 0x3c
function is_limited_weapon(weapon) {
    if (isdefined(level.limited_weapons) && isdefined(level.limited_weapons[weapon])) {
        return true;
    }
    return false;
}

// Namespace zm_utility/zm_utility
// Params 0, eflags: 0x1 linked
// Checksum 0x58483482, Offset: 0x92a0
// Size: 0x1a
function should_watch_for_emp() {
    return is_true(level.should_watch_for_emp);
}

// Namespace zm_utility/zm_utility
// Params 1, eflags: 0x1 linked
// Checksum 0x6150b46d, Offset: 0x92c8
// Size: 0x44
function groundpos(origin) {
    return bullettrace(origin, origin + (0, 0, -100000), 0, self)[#"position"];
}

// Namespace zm_utility/zm_utility
// Params 1, eflags: 0x1 linked
// Checksum 0x79768018, Offset: 0x9318
// Size: 0x4c
function groundpos_ignore_water(origin) {
    return bullettrace(origin, origin + (0, 0, -100000), 0, self, 1)[#"position"];
}

// Namespace zm_utility/zm_utility
// Params 1, eflags: 0x1 linked
// Checksum 0x679f49df, Offset: 0x9370
// Size: 0x4c
function groundpos_ignore_water_new(origin) {
    return groundtrace(origin, origin + (0, 0, -100000), 0, self, 1)[#"position"];
}

// Namespace zm_utility/zm_utility
// Params 0, eflags: 0x1 linked
// Checksum 0xd817d3ff, Offset: 0x93c8
// Size: 0x24
function self_delete() {
    if (isdefined(self)) {
        self delete();
    }
}

// Namespace zm_utility/zm_utility
// Params 1, eflags: 0x1 linked
// Checksum 0xd8ed1794, Offset: 0x93f8
// Size: 0x5a
function ignore_triggers(timer) {
    if (!isdefined(self)) {
        return;
    }
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
// Params 2, eflags: 0x1 linked
// Checksum 0xd6d1b20a, Offset: 0x9460
// Size: 0x174
function function_659819fa(achievement, all_players = 0) {
    if (achievement == "") {
        return;
    }
    if (is_true(level.zm_disable_recording_stats)) {
        return;
    }
    assert(ishash(achievement), "<dev string:x2b2>");
    if (all_players) {
        foreach (player in getplayers()) {
            player giveachievement(achievement);
        }
        return;
    }
    if (!isplayer(self)) {
        assertmsg("<dev string:x2d4>");
        return;
    }
    self giveachievement(achievement);
}

// Namespace zm_utility/zm_utility
// Params 1, eflags: 0x1 linked
// Checksum 0xd39318e5, Offset: 0x95e0
// Size: 0x3e
function getyaw(org) {
    angles = vectortoangles(org - self.origin);
    return angles[1];
}

// Namespace zm_utility/zm_utility
// Params 1, eflags: 0x1 linked
// Checksum 0x396a589a, Offset: 0x9628
// Size: 0x62
function getyawtospot(spot) {
    pos = spot;
    yaw = self.angles[1] - getyaw(pos);
    yaw = angleclamp180(yaw);
    return yaw;
}

// Namespace zm_utility/zm_utility
// Params 0, eflags: 0x1 linked
// Checksum 0x8ba109e1, Offset: 0x9698
// Size: 0x3e
function disable_react() {
    assert(isalive(self), "<dev string:x301>");
    self.allowreact = 0;
}

// Namespace zm_utility/zm_utility
// Params 0, eflags: 0x0
// Checksum 0x5d5751e3, Offset: 0x96e0
// Size: 0x42
function enable_react() {
    assert(isalive(self), "<dev string:x327>");
    self.allowreact = 1;
}

// Namespace zm_utility/zm_utility
// Params 0, eflags: 0x1 linked
// Checksum 0x6471d131, Offset: 0x9730
// Size: 0x8a
function is_ee_enabled() {
    if (is_true(level.var_73d1e054)) {
        return false;
    }
    if (!getdvarint(#"zm_ee_enabled", 0)) {
        return false;
    }
    if (!zm_custom::function_901b751c(#"hash_3c5363541b97ca3e")) {
        return false;
    }
    if (level.gamedifficulty === 0) {
        return false;
    }
    return true;
}

// Namespace zm_utility/zm_utility
// Params 0, eflags: 0x1 linked
// Checksum 0x244f12b0, Offset: 0x97c8
// Size: 0x36
function function_7ab3b826() {
    if (!getdvarint(#"hash_2184263c92bdc58d", 1)) {
        return false;
    }
    return true;
}

// Namespace zm_utility/zm_utility
// Params 1, eflags: 0x0
// Checksum 0x313da5d4, Offset: 0x9808
// Size: 0x30
function bullet_attack(type) {
    if (type == "MOD_PISTOL_BULLET") {
        return true;
    }
    return type == "MOD_RIFLE_BULLET";
}

// Namespace zm_utility/zm_utility
// Params 0, eflags: 0x1 linked
// Checksum 0xfe02f155, Offset: 0x9840
// Size: 0x9c
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
// Params 0, eflags: 0x1 linked
// Checksum 0x5175550c, Offset: 0x98e8
// Size: 0x98
function function_ab9a9770() {
    s_trace = groundtrace(self.origin + (0, 0, 70), self.origin + (0, 0, -100), 0, self);
    if (isdefined(s_trace[#"entity"]) && s_trace[#"entity"] ismovingplatform()) {
        return true;
    }
    return false;
}

// Namespace zm_utility/zm_utility
// Params 0, eflags: 0x0
// Checksum 0x78e125e9, Offset: 0x9988
// Size: 0x82
function function_52046128() {
    s_trace = groundtrace(self.origin + (0, 0, 70), self.origin + (0, 0, -100), 0, self);
    if (isdefined(s_trace[#"entity"])) {
        return s_trace[#"entity"];
    }
    return undefined;
}

// Namespace zm_utility/zm_utility
// Params 0, eflags: 0x1 linked
// Checksum 0xb7e73135, Offset: 0x9a18
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
// Params 1, eflags: 0x1 linked
// Checksum 0xe3dcd303, Offset: 0x9ad0
// Size: 0x78
function get_closest_player(org) {
    players = [];
    players = getplayers();
    if (players.size) {
        if (players.size > 1 && isdefined(org)) {
            return arraygetclosest(org, players);
        }
        return players[0];
    }
}

// Namespace zm_utility/zm_utility
// Params 0, eflags: 0x0
// Checksum 0xdacc9edf, Offset: 0x9b50
// Size: 0x8c
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
// Params 1, eflags: 0x1 linked
// Checksum 0x9d9b43ee, Offset: 0x9be8
// Size: 0x40
function ent_flag_wait_ai_standards(message) {
    self endon(#"death");
    self waittill(message);
    self.ent_flag[message] = 1;
}

// Namespace zm_utility/zm_utility
// Params 1, eflags: 0x0
// Checksum 0xf4c21649, Offset: 0x9c30
// Size: 0x2a
function flat_angle(angle) {
    rangle = (0, angle[1], 0);
    return rangle;
}

// Namespace zm_utility/zm_utility
// Params 0, eflags: 0x0
// Checksum 0x25eaab8b, Offset: 0x9c68
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
// Params 0, eflags: 0x1 linked
// Checksum 0x4a7ec7b8, Offset: 0x9cb8
// Size: 0x8e6
function track_players_intersection_tracker() {
    level endon(#"end_game");
    wait 5;
    var_76013453 = [];
    /#
        if (!isdefined(level.var_9db63456)) {
            level.var_9db63456 = 0;
        }
    #/
    if (!isdefined(level.var_9db63456)) {
        level.var_9db63456 = 1;
    }
    while (true) {
        var_1a1f860b = 0;
        players = getplayers();
        /#
            foreach (player in players) {
                if (!isdefined(player.var_ab8c5e97)) {
                    player.var_ab8c5e97 = [];
                }
                if (!isdefined(player.var_d28c72e5)) {
                    player.var_d28c72e5 = 1000;
                }
            }
        #/
        var_93bba48c = [];
        for (i = 0; i < players.size; i++) {
            if (is_true(players[i].var_f4e33249) || players[i] isplayerswimming() || players[i] laststand::player_is_in_laststand() || "playing" != players[i].sessionstate) {
                continue;
            }
            if (isbot(players[i])) {
                continue;
            }
            if (lengthsquared(players[i] getvelocity()) > 15625) {
                continue;
            }
            if (is_true(players[i].var_c5e36086)) {
                continue;
            }
            for (j = 0; j < players.size; j++) {
                if (i == j || is_true(players[j].var_f4e33249) || players[j] isplayerswimming() || players[j] laststand::player_is_in_laststand() || "playing" != players[j].sessionstate) {
                    continue;
                }
                if (isbot(players[j])) {
                    continue;
                }
                if (lengthsquared(players[j] getvelocity()) > 15625) {
                    continue;
                }
                if (is_true(players[j].var_c5e36086)) {
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
                    if (!isdefined(players[i].var_ab8c5e97[j])) {
                        players[i].var_ab8c5e97[j] = 1000;
                    }
                    players[i].var_ab8c5e97[j] = min(players[i].var_ab8c5e97[j], distance_apart);
                    players[i].var_d28c72e5 = min(players[i].var_d28c72e5, distance_apart);
                    if (abs(distance_apart) > 30) {
                        if (players[i].var_ab8c5e97[j] === players[i].var_d28c72e5) {
                            players[i].var_d28c72e5 = 1000;
                        }
                        players[i].var_ab8c5e97[j] = 1000;
                    }
                #/
                if (abs(distance_apart) > 9) {
                    continue;
                }
                if (!isdefined(var_93bba48c)) {
                    var_93bba48c = [];
                } else if (!isarray(var_93bba48c)) {
                    var_93bba48c = array(var_93bba48c);
                }
                if (!isinarray(var_93bba48c, players[i])) {
                    var_93bba48c[var_93bba48c.size] = players[i];
                }
                if (!isdefined(var_93bba48c)) {
                    var_93bba48c = [];
                } else if (!isarray(var_93bba48c)) {
                    var_93bba48c = array(var_93bba48c);
                }
                if (!isinarray(var_93bba48c, players[j])) {
                    var_93bba48c[var_93bba48c.size] = players[j];
                }
            }
        }
        foreach (var_e42ab7b4 in var_93bba48c) {
            /#
                if (!level.var_9db63456) {
                    iprintlnbold("<dev string:x34c>" + var_e42ab7b4.var_d28c72e5);
                    continue;
                }
            #/
            if (isinarray(var_76013453, var_e42ab7b4)) {
                if (isdefined(var_e42ab7b4.maxhealth) && var_e42ab7b4.maxhealth > 0) {
                    n_damage = var_e42ab7b4.maxhealth / 3 + 1;
                } else {
                    n_damage = 51;
                }
                if (isdefined(var_e42ab7b4) && isvec(var_e42ab7b4.origin)) {
                    self.var_dad8bef6 = 1;
                    var_e42ab7b4 dodamage(n_damage, var_e42ab7b4.origin);
                    self.var_dad8bef6 = undefined;
                    var_e42ab7b4 zm_stats::increment_map_cheat_stat("cheat_too_friendly");
                    var_e42ab7b4 zm_stats::increment_client_stat("cheat_too_friendly", 0);
                    var_e42ab7b4 zm_stats::increment_client_stat("cheat_total", 0);
                }
            }
            if (!var_1a1f860b) {
                /#
                    iprintlnbold("<dev string:x378>" + var_e42ab7b4.var_d28c72e5);
                #/
                foreach (e_player in level.players) {
                    e_player playlocalsound(level.zmb_laugh_alias);
                }
                var_1a1f860b = 1;
            }
        }
        var_76013453 = var_93bba48c;
        wait 1;
    }
}

// Namespace zm_utility/zm_utility
// Params 4, eflags: 0x1 linked
// Checksum 0xda68092d, Offset: 0xa5a8
// Size: 0x158
function is_player_looking_at(origin, dot, do_trace, ignore_ent) {
    assert(isplayer(self), "<dev string:x399>");
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
// Checksum 0xb9eaf739, Offset: 0xa708
// Size: 0x24
function add_gametype(*gt, *dummy1, *name, *dummy2) {
    
}

// Namespace zm_utility/zm_utility
// Params 4, eflags: 0x0
// Checksum 0x300c473, Offset: 0xa738
// Size: 0x24
function add_gameloc(*gl, *dummy1, *name, *dummy2) {
    
}

// Namespace zm_utility/zm_utility
// Params 3, eflags: 0x0
// Checksum 0xbdb69601, Offset: 0xa768
// Size: 0xc8
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
// Checksum 0x1017ddeb, Offset: 0xa838
// Size: 0xd6
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
// Checksum 0x1017e7d7, Offset: 0xa918
// Size: 0x110
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
// Params 2, eflags: 0x1 linked
// Checksum 0xdc1e45db, Offset: 0xaa30
// Size: 0x40
function set_gamemode_var(gvar, val) {
    if (!isdefined(game.gamemode_match)) {
        game.gamemode_match = [];
    }
    game.gamemode_match[gvar] = val;
}

// Namespace zm_utility/zm_utility
// Params 2, eflags: 0x1 linked
// Checksum 0xf4340d70, Offset: 0xaa78
// Size: 0x54
function set_gamemode_var_once(gvar, val) {
    if (!isdefined(game.gamemode_match)) {
        game.gamemode_match = [];
    }
    if (!isdefined(game.gamemode_match[gvar])) {
        game.gamemode_match[gvar] = val;
    }
}

// Namespace zm_utility/zm_utility
// Params 1, eflags: 0x1 linked
// Checksum 0x29a3d398, Offset: 0xaad8
// Size: 0x48
function get_gamemode_var(gvar) {
    if (isdefined(game.gamemode_match) && isdefined(game.gamemode_match[gvar])) {
        return game.gamemode_match[gvar];
    }
    return undefined;
}

// Namespace zm_utility/zm_utility
// Params 6, eflags: 0x0
// Checksum 0x343d5158, Offset: 0xab28
// Size: 0x1c8
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
// Params 4, eflags: 0x1 linked
// Checksum 0xeeb9043e, Offset: 0xacf8
// Size: 0x18a
function is_headshot(*weapon, shitloc, smeansofdeath, var_f8c15d58 = 1) {
    if (smeansofdeath == "MOD_MELEE" || smeansofdeath == "MOD_UNKNOWN") {
        return false;
    }
    if (var_f8c15d58 && isdefined(self.var_e6675d2d) && (smeansofdeath == "MOD_PROJECTILE" || smeansofdeath == "MOD_PROJECTILE_SPLASH" || smeansofdeath == "MOD_GRENADE" || smeansofdeath == "MOD_GRENADE_SPLASH")) {
        v_head = self gettagorigin("j_head");
        if (!isdefined(v_head)) {
            return false;
        }
        n_distance_squared = distancesquared(self.var_e6675d2d, v_head);
        if (n_distance_squared < 80) {
            return true;
        }
    }
    if (!isdefined(shitloc) || shitloc == "none") {
        return false;
    }
    if (shitloc != "head" && shitloc != "helmet" && shitloc != "neck") {
        return false;
    }
    return true;
}

// Namespace zm_utility/zm_utility
// Params 1, eflags: 0x1 linked
// Checksum 0xfeca4324, Offset: 0xae90
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
// Params 1, eflags: 0x1 linked
// Checksum 0xcc42ae87, Offset: 0xaf18
// Size: 0x8c
function function_7a35b1d7(var_c857a96d) {
    if (isplayer(self)) {
        self luinotifyevent(#"zombie_notification", 2, var_c857a96d, self getentitynumber());
        return;
    }
    luinotifyevent(#"zombie_notification", 1, var_c857a96d);
}

// Namespace zm_utility/zm_utility
// Params 2, eflags: 0x0
// Checksum 0xbdc3fe61, Offset: 0xafb0
// Size: 0x84
function function_846eb7dd(type_id, var_c857a96d) {
    if (isplayer(self)) {
        self luinotifyevent(type_id, 2, var_c857a96d, self getentitynumber());
        return;
    }
    luinotifyevent(type_id, 1, var_c857a96d);
}

// Namespace zm_utility/zm_utility
// Params 2, eflags: 0x0
// Checksum 0xb88c5614, Offset: 0xb040
// Size: 0x9c
function function_e64ac3b6(type_id, var_c857a96d) {
    if (isplayer(self)) {
        self luinotifyevent(#"zombie_special_notification", 3, type_id, var_c857a96d, self getentitynumber());
        return;
    }
    luinotifyevent(#"zombie_special_notification", 2, type_id, var_c857a96d);
}

// Namespace zm_utility/zm_utility
// Params 1, eflags: 0x0
// Checksum 0xb5998dd, Offset: 0xb0e8
// Size: 0x6a
function sndswitchannouncervox(who) {
    switch (who) {
    case #"sam":
        game.var_85e678a1[#"prefix"] = "vox_zmba_sam";
        level.zmb_laugh_alias = "zmb_player_outofbounds";
        level.sndannouncerisrich = 0;
        break;
    }
}

// Namespace zm_utility/zm_utility
// Params 4, eflags: 0x0
// Checksum 0xdc055fef, Offset: 0xb160
// Size: 0xbc
function do_player_general_vox(category, type, timer, *chance) {
    if (isdefined(chance) && isdefined(level.votimer[timer]) && level.votimer[timer] > 0) {
        return;
    }
    self thread zm_audio::create_and_play_dialog(type, timer);
    if (isdefined(chance)) {
        level.votimer[timer] = chance;
        level thread general_vox_timer(level.votimer[timer], timer);
    }
}

// Namespace zm_utility/zm_utility
// Params 2, eflags: 0x1 linked
// Checksum 0x32a58cb8, Offset: 0xb228
// Size: 0xcc
function general_vox_timer(timer, type) {
    level endon(#"end_game");
    println("<dev string:x3ca>" + type + "<dev string:x3eb>" + timer + "<dev string:x3f2>");
    while (timer > 0) {
        wait 1;
        timer--;
    }
    level.votimer[type] = timer;
    println("<dev string:x3f7>" + type + "<dev string:x3eb>" + timer + "<dev string:x3f2>");
}

// Namespace zm_utility/zm_utility
// Params 3, eflags: 0x0
// Checksum 0xe15ced9d, Offset: 0xb300
// Size: 0x1c
function play_vox_to_player(*category, *type, *force_variant) {
    
}

// Namespace zm_utility/zm_utility
// Params 1, eflags: 0x0
// Checksum 0xc71a3b20, Offset: 0xb328
// Size: 0x9c
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
// Params 0, eflags: 0x1 linked
// Checksum 0x31f58901, Offset: 0xb3d0
// Size: 0x1dc
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
// Checksum 0xffdc645e, Offset: 0xb5b8
// Size: 0x34
function register_map_navcard(navcard_on_map, navcard_needed_for_computer) {
    level.navcard_needed = navcard_needed_for_computer;
    level.map_navcard = navcard_on_map;
}

// Namespace zm_utility/zm_utility
// Params 1, eflags: 0x0
// Checksum 0x7a53764a, Offset: 0xb5f8
// Size: 0x2a
function does_player_have_map_navcard(player) {
    return player zm_stats::get_global_stat(level.map_navcard);
}

// Namespace zm_utility/zm_utility
// Params 1, eflags: 0x0
// Checksum 0x2afc6c3b, Offset: 0xb630
// Size: 0x3a
function does_player_have_correct_navcard(player) {
    if (!isdefined(level.navcard_needed)) {
        return 0;
    }
    return player zm_stats::get_global_stat(level.navcard_needed);
}

// Namespace zm_utility/zm_utility
// Params 1, eflags: 0x1 linked
// Checksum 0x758caf25, Offset: 0xb678
// Size: 0xdc
function disable_player_move_states(forcestancechange) {
    self allowcrouch(1);
    self allowads(0);
    self allowsprint(0);
    self allowprone(0);
    self allowmelee(0);
    if (is_true(forcestancechange)) {
        if (self getstance() == "prone") {
            self setstance("crouch");
        }
    }
}

// Namespace zm_utility/zm_utility
// Params 0, eflags: 0x1 linked
// Checksum 0xcdf30c85, Offset: 0xb760
// Size: 0x10c
function enable_player_move_states() {
    if (!isdefined(self)) {
        return;
    }
    if (!isplayer(self)) {
        return;
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
// Checksum 0x27c1b3e4, Offset: 0xb878
// Size: 0xfe
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
// Params 6, eflags: 0x1 linked
// Checksum 0xe6d87a64, Offset: 0xb980
// Size: 0xb6
function spawn_path_node_internal(origin, angles, k1, v1, k2, v2) {
    if (isdefined(k2)) {
        return spawnpathnode("node_pathnode", origin, angles, undefined, k1, v1, k2, v2);
    } else if (isdefined(k1)) {
        return spawnpathnode("node_pathnode", origin, angles, undefined, k1, v1);
    } else {
        return spawnpathnode("node_pathnode", origin, angles);
    }
    return undefined;
}

// Namespace zm_utility/zm_utility
// Params 0, eflags: 0x1 linked
// Checksum 0x80f724d1, Offset: 0xba40
// Size: 0x4
function delete_spawned_path_nodes() {
    
}

// Namespace zm_utility/zm_utility
// Params 0, eflags: 0x1 linked
// Checksum 0xf9bbb6df, Offset: 0xba50
// Size: 0xca
function respawn_path_nodes() {
    if (!isdefined(level._spawned_path_nodes)) {
        return;
    }
    for (i = 0; i < level._spawned_path_nodes.size; i++) {
        node_struct = level._spawned_path_nodes[i];
        println("<dev string:x416>" + node_struct.origin);
        node_struct.node = spawn_path_node_internal(node_struct.origin, node_struct.angles, node_struct.k1, node_struct.v1, node_struct.k2, node_struct.v2);
    }
}

// Namespace zm_utility/zm_utility
// Params 0, eflags: 0x1 linked
// Checksum 0x739afb2a, Offset: 0xbb28
// Size: 0x64
function undo_link_changes() {
    /#
        println("<dev string:x43a>");
        println("<dev string:x43a>");
        println("<dev string:x441>");
    #/
    delete_spawned_path_nodes();
}

// Namespace zm_utility/zm_utility
// Params 0, eflags: 0x1 linked
// Checksum 0x201b51cd, Offset: 0xbb98
// Size: 0x64
function redo_link_changes() {
    /#
        println("<dev string:x43a>");
        println("<dev string:x43a>");
        println("<dev string:x45d>");
    #/
    respawn_path_nodes();
}

// Namespace zm_utility/zm_utility
// Params 1, eflags: 0x0
// Checksum 0xf87d5072, Offset: 0xbc08
// Size: 0x92
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
// Checksum 0xf2a8a693, Offset: 0xbca8
// Size: 0x40
function register_custom_spawner_entry(spot_noteworthy, func) {
    if (!isdefined(level.custom_spawner_entry)) {
        level.custom_spawner_entry = [];
    }
    level.custom_spawner_entry[spot_noteworthy] = func;
}

// Namespace zm_utility/zm_utility
// Params 1, eflags: 0x1 linked
// Checksum 0xcb23c9ef, Offset: 0xbcf0
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
// Params 2, eflags: 0x1 linked
// Checksum 0xe73d0903, Offset: 0xbd88
// Size: 0x62
function function_e05ac4ad(e_player, n_cost) {
    if (isdefined(level.var_236b9f7a) && [[ level.var_236b9f7a ]](e_player, self.clientfieldname)) {
        return 0;
    }
    return e_player zm_score::can_player_purchase(n_cost);
}

// Namespace zm_utility/zm_utility
// Params 0, eflags: 0x1 linked
// Checksum 0x9e8ed23f, Offset: 0xbdf8
// Size: 0x42
function get_player_perk_purchase_limit() {
    n_perk_purchase_limit_override = level.perk_purchase_limit;
    if (isdefined(level.get_player_perk_purchase_limit)) {
        n_perk_purchase_limit_override = self [[ level.get_player_perk_purchase_limit ]]();
    }
    return n_perk_purchase_limit_override;
}

// Namespace zm_utility/zm_utility
// Params 0, eflags: 0x1 linked
// Checksum 0x73081974, Offset: 0xbe48
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
// Params 0, eflags: 0x0
// Checksum 0xccf6d007, Offset: 0xbec0
// Size: 0x36
function wait_for_attractor_positions_complete() {
    self endon(#"death");
    self waittill(#"attractor_positions_generated");
    self.attract_to_origin = 0;
}

// Namespace zm_utility/zm_utility
// Params 1, eflags: 0x1 linked
// Checksum 0xcb6f6e26, Offset: 0xbf00
// Size: 0xd6
function get_player_index(player) {
    assert(isplayer(player));
    assert(isdefined(player.characterindex));
    /#
        if (player.entity_num == 0 && getdvarstring(#"zombie_player_vo_overwrite") != "<dev string:x238>") {
            new_vo_index = getdvarint(#"zombie_player_vo_overwrite", 0);
            return new_vo_index;
        }
    #/
    return player.characterindex;
}

// Namespace zm_utility/zm_utility
// Params 1, eflags: 0x1 linked
// Checksum 0x136f77b9, Offset: 0xbfe0
// Size: 0xa0
function function_828bac1(n_character_index) {
    foreach (character in level.players) {
        if (character zm_characters::function_dc232a80() === n_character_index) {
            return character;
        }
    }
    return undefined;
}

// Namespace zm_utility/zm_utility
// Params 1, eflags: 0x0
// Checksum 0x9690546f, Offset: 0xc088
// Size: 0xbc
function zombie_goto_round(n_target_round) {
    level notify(#"restart_round");
    if (n_target_round < 1) {
        n_target_round = 1;
    }
    level.zombie_total = 0;
    zm_round_logic::set_round_number(n_target_round);
    zombies = zombie_utility::get_round_enemy_array();
    if (isdefined(zombies)) {
        array::run_all(zombies, &kill);
    }
    level.sndgotoroundoccurred = 1;
    level waittill(#"between_round_over");
}

// Namespace zm_utility/zm_utility
// Params 2, eflags: 0x1 linked
// Checksum 0x151e2c03, Offset: 0xc150
// Size: 0x246
function is_point_inside_enabled_zone(v_origin, ignore_zone) {
    if (function_c200446c()) {
        return true;
    }
    if (function_21f4ac36()) {
        node = function_52c1730(v_origin, level.zone_nodes, 500);
        if (isdefined(node)) {
            zone = level.zones[node.targetname];
            if (isdefined(zone) && zone.is_enabled && zone !== ignore_zone) {
                return true;
            }
        }
    }
    if (function_c85ebbbc()) {
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
// Params 0, eflags: 0x1 linked
// Checksum 0x602c2b59, Offset: 0xc3a0
// Size: 0x46
function clear_streamer_hint() {
    if (isdefined(self.streamer_hint)) {
        self.streamer_hint delete();
        self.streamer_hint = undefined;
    }
    self notify(#"wait_clear_streamer_hint");
}

// Namespace zm_utility/zm_utility
// Params 1, eflags: 0x1 linked
// Checksum 0x82be3666, Offset: 0xc3f0
// Size: 0x44
function wait_clear_streamer_hint(lifetime) {
    self endon(#"wait_clear_streamer_hint");
    wait lifetime;
    if (isdefined(self)) {
        self clear_streamer_hint();
    }
}

// Namespace zm_utility/zm_utility
// Params 4, eflags: 0x1 linked
// Checksum 0xd44fc339, Offset: 0xc440
// Size: 0x1ac
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
// Checksum 0xddb70078, Offset: 0xc5f8
// Size: 0x130
function approximate_path_dist(player) {
    aiprofile_beginentry("approximate_path_dist");
    goal_pos = player.origin;
    if (isdefined(player.last_valid_position)) {
        goal_pos = player.last_valid_position;
    }
    if (is_true(player.b_teleporting)) {
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
// Params 1, eflags: 0x0
// Checksum 0xa5202efc, Offset: 0xc730
// Size: 0x6a
function get_player_closest_to(e_target) {
    a_players = function_a1ef346b();
    arrayremovevalue(a_players, e_target);
    e_closest_player = arraygetclosest(e_target.origin, a_players);
    return e_closest_player;
}

// Namespace zm_utility/zm_utility
// Params 3, eflags: 0x0
// Checksum 0xcec2074, Offset: 0xc7a8
// Size: 0x15c
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
// Checksum 0x4ee21afb, Offset: 0xc910
// Size: 0x3c
function is_solo_ranked_game() {
    return level.players.size == 1 && getdvarint(#"zm_private_rankedmatch", 0);
}

// Namespace zm_utility/zm_utility
// Params 0, eflags: 0x0
// Checksum 0xb051756a, Offset: 0xc958
// Size: 0x34
function function_e63cdbef() {
    return level.rankedmatch || getdvarint(#"zm_private_rankedmatch", 0);
}

// Namespace zm_utility/zm_utility
// Params 0, eflags: 0x1 linked
// Checksum 0xeea64e70, Offset: 0xc998
// Size: 0x50
function function_a3648315() {
    if (!isdefined(level.var_b03a2fc8)) {
        level.var_b03a2fc8 = new throttle();
        [[ level.var_b03a2fc8 ]]->initialize(1, 0.1);
    }
}

// Namespace zm_utility/zm_utility
// Params 4, eflags: 0x1 linked
// Checksum 0xd60297af, Offset: 0xc9f0
// Size: 0x44
function function_ffc279(v_magnitude, e_attacker, n_damage, weapon) {
    self thread function_315c8e4(v_magnitude, e_attacker, n_damage, weapon);
}

// Namespace zm_utility/zm_utility
// Params 4, eflags: 0x5 linked
// Checksum 0x575ad6bc, Offset: 0xca40
// Size: 0x104
function private function_315c8e4(v_magnitude, e_attacker, n_damage = self.health, weapon) {
    self endon(#"death");
    if (!isdefined(weapon)) {
        weapon = level.weaponnone;
    }
    self.var_bfffc79e = 1;
    [[ level.var_b03a2fc8 ]]->waitinqueue(self);
    self startragdoll();
    self launchragdoll(v_magnitude);
    util::wait_network_frame();
    if (isdefined(self)) {
        self.var_bfffc79e = undefined;
        self dodamage(n_damage, self.origin, e_attacker, undefined, "none", "MOD_UNKNOWN", 0, weapon);
    }
}

// Namespace zm_utility/zm_utility
// Params 1, eflags: 0x1 linked
// Checksum 0x4b5e0d4a, Offset: 0xcb50
// Size: 0x6a
function set_max_health(var_54cb21f6 = 0) {
    if (self.health < self.var_66cb03ad) {
        self.health = self.var_66cb03ad;
    }
    if (var_54cb21f6) {
        if (self.health > self.var_66cb03ad) {
            self.health = self.var_66cb03ad;
        }
    }
}

// Namespace zm_utility/zm_utility
// Params 0, eflags: 0x1 linked
// Checksum 0xc294b7fc, Offset: 0xcbc8
// Size: 0xea
function function_13cc9756() {
    self endon(#"death");
    while (true) {
        waitresult = self waittill(#"zone_change");
        if (isdefined(waitresult.zone)) {
            self.inner_zigzag_radius = waitresult.zone.inner_zigzag_radius;
            self.outer_zigzag_radius = waitresult.zone.outer_zigzag_radius;
            self.zigzag_distance_min = waitresult.zone.zigzag_distance_min;
            self.zigzag_distance_max = waitresult.zone.zigzag_distance_max;
            self.zigzag_activation_distance = waitresult.zone.zigzag_activation_distance;
            self.var_592a8227 = waitresult.zone.zigzag_enabled;
        }
    }
}

// Namespace zm_utility/zm_utility
// Params 1, eflags: 0x1 linked
// Checksum 0xd3ada2df, Offset: 0xccc0
// Size: 0x88
function function_45492cc4(var_cf5e7324 = 1) {
    if (!isdefined(self)) {
        return false;
    }
    if (!isdefined(self.owner)) {
        return false;
    }
    if (!(self.classname === "script_vehicle")) {
        return false;
    }
    if (var_cf5e7324 && isplayer(self.owner)) {
        return true;
    }
    return isdefined(self.owner);
}

// Namespace zm_utility/zm_utility
// Params 0, eflags: 0x1 linked
// Checksum 0x92149139, Offset: 0xcd50
// Size: 0xae
function function_1a4d2910() {
    if (isdefined(level.var_2456c78a)) {
        foreach (var_92254a2f in level.var_2456c78a) {
            if (distancesquared(self.origin, var_92254a2f) < 10000) {
                return true;
            }
        }
    }
    return false;
}

// Namespace zm_utility/zm_utility
// Params 2, eflags: 0x1 linked
// Checksum 0x27141409, Offset: 0xce08
// Size: 0x96
function function_64259898(position, search_radius = 128) {
    goal_pos = getclosestpointonnavmesh(position, search_radius, self getpathfindingradius());
    if (isdefined(goal_pos)) {
        self setgoal(goal_pos);
        return true;
    }
    self setgoal(self.origin);
    return false;
}

// Namespace zm_utility/zm_utility
// Params 0, eflags: 0x0
// Checksum 0xf94bcabb, Offset: 0xcea8
// Size: 0xfe
function function_372a1e12() {
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
// Params 4, eflags: 0x1 linked
// Checksum 0xbbd443b1, Offset: 0xcfb0
// Size: 0xb8
function function_d7db256e(var_eaf129a0, var_6cc77d4e, var_888cf948 = 1, var_b96be97f = undefined) {
    if (isdefined(var_6cc77d4e)) {
        var_1b808f25 = struct::get(var_eaf129a0);
        n_obj_id = function_f5a222a8(var_6cc77d4e, var_1b808f25.origin, var_b96be97f);
    }
    if (var_888cf948) {
        level thread function_75fd65f9(var_eaf129a0, 1);
    }
    return n_obj_id;
}

// Namespace zm_utility/zm_utility
// Params 2, eflags: 0x1 linked
// Checksum 0xa3c9da38, Offset: 0xd070
// Size: 0x54
function function_b1f3be5c(n_obj_id, var_eaf129a0) {
    if (isdefined(n_obj_id)) {
        gameobjects::release_obj_id(n_obj_id);
    }
    level thread function_75fd65f9(var_eaf129a0, 0);
}

// Namespace zm_utility/zm_utility
// Params 2, eflags: 0x0
// Checksum 0xfbaefec4, Offset: 0xd0d0
// Size: 0x6c
function function_ba39d198(n_obj_id, b_show = 1) {
    if (isdefined(n_obj_id)) {
        if (b_show) {
            objective_setvisibletoplayer(n_obj_id, self);
            return;
        }
        objective_setinvisibletoplayer(n_obj_id, self);
    }
}

// Namespace zm_utility/zm_utility
// Params 3, eflags: 0x1 linked
// Checksum 0xcb098ff5, Offset: 0xd148
// Size: 0x11c
function function_f5a222a8(var_6cc77d4e, v_origin_or_ent, var_b96be97f = undefined) {
    n_obj_id = gameobjects::get_next_obj_id();
    objective_add(n_obj_id, "active", v_origin_or_ent, var_6cc77d4e);
    function_6da98133(n_obj_id);
    if (isdefined(var_b96be97f)) {
        foreach (player in getplayers()) {
            player thread function_71071944(n_obj_id, var_b96be97f);
        }
    }
    return n_obj_id;
}

// Namespace zm_utility/zm_utility
// Params 2, eflags: 0x1 linked
// Checksum 0x3fec391f, Offset: 0xd270
// Size: 0x194
function function_71071944(n_obj_id, var_b96be97f) {
    level endon(#"game_ended", #"hash_1dabaf25a56177a1");
    self endon(#"disconnect");
    self.var_fbb52104 = n_obj_id;
    self.var_d4778e21 = var_b96be97f;
    while ([[ var_b96be97f ]]()) {
        objective_setinvisibletoplayer(n_obj_id, self);
        waitframe(1);
    }
    objective_setvisibletoplayer(n_obj_id, self);
    if (is_true(level.var_81c681aa)) {
        var_880caa89 = 1;
        foreach (e_player in getplayers()) {
            if (e_player [[ var_b96be97f ]]()) {
                var_880caa89 = 0;
            }
        }
        if (var_880caa89) {
            level flag::set(#"disable_fast_travel");
        }
    }
}

// Namespace zm_utility/zm_utility
// Params 1, eflags: 0x0
// Checksum 0x1c2dad7d, Offset: 0xd410
// Size: 0x24
function function_bc5a54a8(n_obj_id) {
    gameobjects::release_obj_id(n_obj_id);
}

// Namespace zm_utility/zm_utility
// Params 2, eflags: 0x1 linked
// Checksum 0x6e492628, Offset: 0xd440
// Size: 0x218
function function_75fd65f9(str_targetname, b_enable = 1) {
    if (!isdefined(str_targetname)) {
        return;
    }
    var_f8f0b389 = struct::get(str_targetname);
    var_2a7c782 = struct::get_array(var_f8f0b389.target);
    foreach (var_bf20477f in var_2a7c782) {
        if (b_enable) {
            if (isdefined(var_bf20477f.var_8e8faeba)) {
                var_bf20477f.var_8e8faeba clientfield::set("zm_zone_edge_marker_count", 0);
                util::wait_network_frame();
            } else {
                var_bf20477f.var_8e8faeba = util::spawn_model("tag_origin", var_bf20477f.origin, var_bf20477f.angles);
            }
            var_eb0f1280 = 3;
            if (isdefined(var_bf20477f.var_d229e574) && var_bf20477f.var_d229e574 > 0) {
                var_eb0f1280 = var_bf20477f.var_d229e574;
            }
            var_bf20477f.var_8e8faeba clientfield::set("zm_zone_edge_marker_count", var_eb0f1280);
            continue;
        }
        if (isdefined(var_bf20477f.var_8e8faeba)) {
            var_bf20477f.var_8e8faeba clientfield::set("zm_zone_edge_marker_count", 0);
            var_bf20477f.var_8e8faeba thread util::delayed_delete(1);
        }
    }
}

// Namespace zm_utility/zm_utility
// Params 0, eflags: 0x1 linked
// Checksum 0x318b46bd, Offset: 0xd660
// Size: 0x186
function function_ebb2f490() {
    var_400c259d = self getweaponslistprimaries();
    var_dc69b88b = [];
    foreach (var_5d22227d in var_400c259d) {
        if (!isdefined(var_dc69b88b)) {
            var_dc69b88b = [];
        } else if (!isarray(var_dc69b88b)) {
            var_dc69b88b = array(var_dc69b88b);
        }
        var_dc69b88b[var_dc69b88b.size] = zm_weapons::function_93cd8e76(var_5d22227d);
        if (var_5d22227d.splitweapon != level.weaponnone) {
            if (!isdefined(var_dc69b88b)) {
                var_dc69b88b = [];
            } else if (!isarray(var_dc69b88b)) {
                var_dc69b88b = array(var_dc69b88b);
            }
            var_dc69b88b[var_dc69b88b.size] = zm_weapons::function_93cd8e76(var_5d22227d.splitweapon);
        }
    }
    return var_dc69b88b;
}

// Namespace zm_utility/zm_utility
// Params 2, eflags: 0x0
// Checksum 0x2e279c69, Offset: 0xd7f0
// Size: 0xce
function function_aa45670f(weapon, var_3a36e0dc) {
    root_weapon = zm_weapons::function_93cd8e76(weapon);
    if (isdefined(self.var_f6d3c3[var_3a36e0dc]) && isinarray(self.var_f6d3c3[var_3a36e0dc], root_weapon)) {
        var_dc69b88b = function_ebb2f490();
        if (isinarray(var_dc69b88b, root_weapon) || zm_weapons::function_93cd8e76(self.currentweapon) === root_weapon) {
            return true;
        }
    }
    return false;
}

// Namespace zm_utility/zm_utility
// Params 3, eflags: 0x0
// Checksum 0x57244e3, Offset: 0xd8c8
// Size: 0x24c
function function_28ee38f4(weapon, var_3a36e0dc, var_87f6ae5) {
    root_weapon = zm_weapons::function_93cd8e76(weapon);
    if (isdefined(self.var_f6d3c3[var_3a36e0dc]) && isinarray(self.var_f6d3c3[var_3a36e0dc], root_weapon)) {
        return false;
    }
    var_dc69b88b = function_ebb2f490();
    if (isinarray(var_dc69b88b, root_weapon) || zm_weapons::function_93cd8e76(self.currentweapon) === root_weapon) {
        if (!isdefined(self.var_f6d3c3[var_3a36e0dc])) {
            self.var_f6d3c3[var_3a36e0dc] = [];
        } else if (!isarray(self.var_f6d3c3[var_3a36e0dc])) {
            self.var_f6d3c3[var_3a36e0dc] = array(self.var_f6d3c3[var_3a36e0dc]);
        }
        self.var_f6d3c3[var_3a36e0dc][self.var_f6d3c3[var_3a36e0dc].size] = root_weapon;
        if (root_weapon.splitweapon !== level.weaponnone) {
            if (!isdefined(self.var_f6d3c3[var_3a36e0dc])) {
                self.var_f6d3c3[var_3a36e0dc] = [];
            } else if (!isarray(self.var_f6d3c3[var_3a36e0dc])) {
                self.var_f6d3c3[var_3a36e0dc] = array(self.var_f6d3c3[var_3a36e0dc]);
            }
            self.var_f6d3c3[var_3a36e0dc][self.var_f6d3c3[var_3a36e0dc].size] = root_weapon.splitweapon;
        }
        self thread function_13f40482();
        if (var_87f6ae5) {
            self zm_weapons::ammo_give(weapon);
        }
        return true;
    }
    return false;
}

// Namespace zm_utility/zm_utility
// Params 2, eflags: 0x1 linked
// Checksum 0xf20c0ac0, Offset: 0xdb20
// Size: 0xf0
function function_18ce0c8(weapon, var_3a36e0dc) {
    root_weapon = zm_weapons::function_93cd8e76(weapon);
    if (!isdefined(self.var_f6d3c3[var_3a36e0dc]) || !isinarray(self.var_f6d3c3[var_3a36e0dc], root_weapon)) {
        return;
    }
    self.var_f6d3c3[var_3a36e0dc] = array::exclude(self.var_f6d3c3[var_3a36e0dc], root_weapon);
    if (root_weapon.splitweapon != level.weaponnone) {
        self.var_f6d3c3[var_3a36e0dc] = array::exclude(self.var_f6d3c3[var_3a36e0dc], root_weapon.splitweapon);
    }
}

// Namespace zm_utility/zm_utility
// Params 0, eflags: 0x1 linked
// Checksum 0x4eb2f3f3, Offset: 0xdc18
// Size: 0x174
function function_13f40482() {
    self notify("2df0788ff25f98e2");
    self endon("2df0788ff25f98e2");
    self endon(#"disconnect");
    while (true) {
        self waittill(#"weapon_change");
        if (self scene::function_c935c42() || level flag::get("round_reset")) {
            continue;
        }
        var_dc69b88b = function_ebb2f490();
        for (i = 0; i < 1; i++) {
            foreach (var_406a430d in self.var_f6d3c3[i]) {
                if (!isinarray(var_dc69b88b, var_406a430d)) {
                    self function_18ce0c8(var_406a430d, i);
                }
            }
        }
    }
}

// Namespace zm_utility/zm_utility
// Params 2, eflags: 0x1 linked
// Checksum 0xe60637f5, Offset: 0xdd98
// Size: 0x8e
function function_fdb0368(n_round_number, str_endon) {
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
// Params 6, eflags: 0x1 linked
// Checksum 0xf2077d48, Offset: 0xde30
// Size: 0x598
function function_9ad5aeb1(var_a8d0b313 = 1, var_82ea43f2 = 1, b_hide_body = 0, var_b0e62e21 = 1, var_814b69d3 = 1, var_87c98387 = "white") {
    var_4b9821e4 = 0;
    a_players = function_a1ef346b();
    foreach (player in a_players) {
        player val::set(#"hash_2f1b514922b9901e", "takedamage", 0);
    }
    if (!isarray(var_b0e62e21)) {
        if (var_b0e62e21) {
            if (var_814b69d3) {
                level thread lui::screen_flash(1, 1, 0.5, 1, var_87c98387);
            } else {
                level thread lui::screen_flash(0.2, 0.5, 1, 0.8, var_87c98387);
            }
        }
    } else {
        var_72487f42 = var_b0e62e21[0];
        n_hold = var_b0e62e21[1];
        var_7012f1e9 = var_b0e62e21[2];
        n_alpha = array(0.8, 1)[var_814b69d3];
        level thread lui::screen_flash(var_72487f42, n_hold, var_7012f1e9, n_alpha, var_87c98387);
    }
    foreach (ai in getaiteamarray(level.zombie_team)) {
        if (isalive(ai) && !is_true(ai.var_d45ca662) && !is_true(ai.marked_for_death)) {
            if (var_a8d0b313) {
                ai zm_cleanup::function_23621259(0);
            }
            if (var_82ea43f2 || ai.var_6f84b820 !== #"normal") {
                if (is_magic_bullet_shield_enabled(ai)) {
                    ai util::stop_magic_bullet_shield();
                }
                ai.allowdeath = 1;
                ai.no_powerups = 1;
                ai.deathpoints_already_given = 1;
                ai.marked_for_death = 1;
                if (!b_hide_body && ai.var_6f84b820 === #"normal" && var_4b9821e4 < 6) {
                    var_4b9821e4++;
                    ai thread zombie_death::flame_death_fx();
                    if (!is_true(ai.no_gib)) {
                        ai zombie_utility::zombie_head_gib();
                    }
                }
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
    foreach (player in a_players) {
        if (isdefined(player)) {
            player val::reset(#"hash_2f1b514922b9901e", "takedamage");
        }
    }
}

// Namespace zm_utility/zm_utility
// Params 0, eflags: 0x0
// Checksum 0xa16f3222, Offset: 0xe3d0
// Size: 0x2c
function function_508f636d() {
    level function_9ad5aeb1(0, 1, 0, 1, "black");
}

// Namespace zm_utility/zm_utility
// Params 2, eflags: 0x1 linked
// Checksum 0xdfeb8e8f, Offset: 0xe408
// Size: 0xb2
function function_850e7499(weapon, var_20c27a34 = 0) {
    if (weapon === getweapon(#"eq_wraith_fire") || weapon === getweapon(#"eq_wraith_fire_extra")) {
        return true;
    }
    if (var_20c27a34 && weapon === getweapon(#"wraith_fire_fire")) {
        return true;
    }
    return false;
}

// Namespace zm_utility/zm_utility
// Params 1, eflags: 0x1 linked
// Checksum 0x9e46d1b7, Offset: 0xe4c8
// Size: 0x6a
function is_claymore(weapon) {
    if (weapon === getweapon(#"claymore") || weapon === getweapon(#"claymore_extra")) {
        return true;
    }
    return false;
}

// Namespace zm_utility/zm_utility
// Params 1, eflags: 0x1 linked
// Checksum 0x882e9533, Offset: 0xe540
// Size: 0x6a
function function_b797694c(weapon) {
    if (weapon === getweapon(#"eq_acid_bomb") || weapon === getweapon(#"eq_acid_bomb_extra")) {
        return true;
    }
    return false;
}

// Namespace zm_utility/zm_utility
// Params 1, eflags: 0x1 linked
// Checksum 0xdd185f9, Offset: 0xe5b8
// Size: 0x6a
function is_frag_grenade(weapon) {
    if (weapon === getweapon(#"eq_frag_grenade") || weapon === getweapon(#"eq_frag_grenade_extra")) {
        return true;
    }
    return false;
}

// Namespace zm_utility/zm_utility
// Params 2, eflags: 0x1 linked
// Checksum 0x81adddf9, Offset: 0xe630
// Size: 0x8a
function is_mini_turret(weapon, var_b69165c7 = 0) {
    if (weapon === getweapon(#"mini_turret")) {
        return true;
    }
    if (var_b69165c7 && weapon === getweapon(#"gun_mini_turret")) {
        return true;
    }
    return false;
}

// Namespace zm_utility/zm_utility
// Params 1, eflags: 0x1 linked
// Checksum 0xc94b777c, Offset: 0xe6c8
// Size: 0x2e
function function_a2541519(var_da4af4df) {
    if (is_standard()) {
        var_da4af4df = level.var_aaf21bbb;
    }
    return var_da4af4df;
}

// Namespace zm_utility/zm_utility
// Params 7, eflags: 0x1 linked
// Checksum 0xf3d04246, Offset: 0xe700
// Size: 0x53c
function function_4a25b584(v_start_pos, var_487ba56d, n_radius = 512, b_randomize = 1, var_79ced64 = 0.2, n_half_height = 4, var_21aae2c6 = undefined) {
    level endon(#"end_game");
    var_bf08dccd = [];
    v_start_pos = groundtrace(v_start_pos + (0, 0, 8), v_start_pos + (0, 0, -100000), 0, undefined)[#"position"];
    if (isdefined(var_21aae2c6)) {
        s_result = positionquery_source_navigation(var_21aae2c6, 32, n_radius, n_half_height, 16, 1, 32);
    } else {
        s_result = positionquery_source_navigation(v_start_pos, 32, n_radius, n_half_height, 16, 1, 32);
    }
    if (isdefined(s_result) && isarray(s_result.data)) {
        if (b_randomize) {
            s_result.data = array::randomize(s_result.data);
        }
        foreach (var_c310df8c in s_result.data) {
            if (function_25e3484e(var_c310df8c.origin, 24, var_bf08dccd)) {
                var_7a4cb7eb = var_c310df8c.origin;
                n_height_diff = abs(var_7a4cb7eb[2] - v_start_pos[2]);
                if (n_height_diff > 60) {
                    continue;
                }
                if (!isdefined(var_bf08dccd)) {
                    var_bf08dccd = [];
                } else if (!isarray(var_bf08dccd)) {
                    var_bf08dccd = array(var_bf08dccd);
                }
                var_bf08dccd[var_bf08dccd.size] = var_7a4cb7eb;
                if (var_bf08dccd.size > var_487ba56d + 20) {
                    break;
                }
            }
        }
    }
    if (b_randomize) {
        var_bf08dccd = array::randomize(var_bf08dccd);
    }
    level.var_ec45f213 = 0;
    switch (level.players.size) {
    case 1:
        var_487ba56d = int(var_487ba56d * 0.5);
        break;
    case 2:
        var_487ba56d = int(var_487ba56d * 0.75);
        break;
    }
    if (var_487ba56d > var_bf08dccd.size) {
        var_487ba56d = var_bf08dccd.size;
    }
    var_487ba56d = int(max(var_487ba56d, 1));
    for (i = 0; i < var_487ba56d; i++) {
        e_powerup = function_ce46d95e(v_start_pos, 0, 0, 1);
        if (!isdefined(e_powerup)) {
            continue;
        }
        if (isdefined(var_bf08dccd[i])) {
            var_96bdce8a = length(v_start_pos - var_bf08dccd[i]);
            n_move_time = e_powerup fake_physicslaunch(var_bf08dccd[i] + (0, 0, 35), var_96bdce8a);
        } else {
            n_move_time = e_powerup fake_physicslaunch(v_start_pos + (0, 0, 35), n_radius / 3.5);
        }
        if (isdefined(level.var_b4ff4ec)) {
            e_powerup thread [[ level.var_b4ff4ec ]](n_move_time);
        }
        wait var_79ced64;
    }
    if (is_standard()) {
        level.var_ec45f213 = 1;
    }
}

// Namespace zm_utility/zm_utility
// Params 3, eflags: 0x1 linked
// Checksum 0x8bf707cb, Offset: 0xec48
// Size: 0x160
function function_25e3484e(v_pos, n_spacing = 400, var_3e807a14) {
    var_91890e6 = zm_powerups::get_powerups(v_pos, n_spacing);
    if (var_91890e6.size > 0) {
        return false;
    }
    if (isarray(var_3e807a14)) {
        foreach (var_a8f85c02 in var_3e807a14) {
            if (distance(v_pos, var_a8f85c02) < n_spacing) {
                return false;
            }
        }
    }
    if (isdefined(level.var_3e96c707)) {
        if (![[ level.var_3e96c707 ]](v_pos)) {
            return false;
        }
    }
    if (check_point_in_playable_area(v_pos) && check_point_in_enabled_zone(v_pos)) {
        return true;
    }
    return false;
}

// Namespace zm_utility/zm_utility
// Params 4, eflags: 0x1 linked
// Checksum 0xfdacb8ba, Offset: 0xedb0
// Size: 0x112
function function_ce46d95e(v_origin, b_permanent = 1, var_4ecce348 = 1, var_9a5654a5) {
    if (var_4ecce348) {
        while (level.active_powerups.size >= 75) {
            waitframe(1);
        }
    }
    if (level.active_powerups.size < 75) {
        e_powerup = zm_powerups::specific_powerup_drop("bonus_points_player", v_origin, undefined, var_9a5654a5, undefined, b_permanent, 1);
        if (isdefined(e_powerup)) {
            if (isdefined(level.var_48e2ab90)) {
                e_powerup setscale(level.var_48e2ab90);
            }
            if (isdefined(level.var_6463d67c)) {
                e_powerup.var_258c5fbc = level.var_6463d67c;
            }
        }
    }
    return e_powerup;
}

// Namespace zm_utility/zm_utility
// Params 0, eflags: 0x0
// Checksum 0xa37b36aa, Offset: 0xeed0
// Size: 0x2c
function is_jumping() {
    ground_ent = self getgroundent();
    return !isdefined(ground_ent);
}

// Namespace zm_utility/zm_utility
// Params 3, eflags: 0x0
// Checksum 0xb9ccea7d, Offset: 0xef08
// Size: 0x272
function function_9f7fd525(var_c61df77f = "zombie_location", a_str_zones, var_a6f0ec9f = 1) {
    a_s_locs = [];
    if (isdefined(a_str_zones)) {
        if (!isdefined(a_str_zones)) {
            a_str_zones = [];
        } else if (!isarray(a_str_zones)) {
            a_str_zones = array(a_str_zones);
        }
        if (var_a6f0ec9f) {
            var_5386ca1d = level.zm_loc_types[var_c61df77f];
        } else {
            var_5386ca1d = struct::get_array("spawn_location", "script_noteworthy");
        }
        foreach (str_zone in a_str_zones) {
            foreach (s_loc in var_5386ca1d) {
                if (str_zone === s_loc.zone_name) {
                    if (!isdefined(a_s_locs)) {
                        a_s_locs = [];
                    } else if (!isarray(a_s_locs)) {
                        a_s_locs = array(a_s_locs);
                    }
                    if (!isinarray(a_s_locs, s_loc)) {
                        a_s_locs[a_s_locs.size] = s_loc;
                    }
                }
            }
        }
    } else if (var_a6f0ec9f) {
        var_5386ca1d = level.zm_loc_types[var_c61df77f];
    } else {
        var_5386ca1d = struct::get_array("spawn_location", "script_noteworthy");
    }
    return a_s_locs;
}

// Namespace zm_utility/zm_utility
// Params 1, eflags: 0x0
// Checksum 0x234879e2, Offset: 0xf188
// Size: 0xc2
function function_7618c8ef(var_6e4c63cc = 0.0667) {
    n_damage_multiplier = 1;
    if (is_true(self.ignore_health_regen_delay)) {
        n_damage_multiplier += 1.25;
        if (self hasperk(#"hash_7f98b3dd3cce95aa")) {
            n_damage_multiplier += 0.75;
        }
    }
    var_16e6b8ea = int(self.maxhealth * var_6e4c63cc * n_damage_multiplier);
    return var_16e6b8ea;
}

// Namespace zm_utility/zm_utility
// Params 0, eflags: 0x1 linked
// Checksum 0x177277c8, Offset: 0xf258
// Size: 0x1a
function function_10e38d86() {
    return getscriptbundle("zombie_vars_settings");
}

// Namespace zm_utility/zm_utility
// Params 1, eflags: 0x1 linked
// Checksum 0x6737ce85, Offset: 0xf280
// Size: 0x1ea
function function_36eb0acc(var_13f9dee7 = #"none") {
    switch (var_13f9dee7) {
    case #"none":
        self clientfield::set("model_rarity_rob", 1);
        break;
    case #"resource":
        self clientfield::set("model_rarity_rob", 2);
        break;
    case #"uncommon":
        self clientfield::set("model_rarity_rob", 3);
        break;
    case #"rare":
        self clientfield::set("model_rarity_rob", 4);
        break;
    case #"epic":
        self clientfield::set("model_rarity_rob", 5);
        break;
    case #"legendary":
        self clientfield::set("model_rarity_rob", 6);
        break;
    case #"ultra":
        self clientfield::set("model_rarity_rob", 7);
        break;
    default:
        self clientfield::set("model_rarity_rob", 0);
        break;
    }
}

// Namespace zm_utility/zm_utility
// Params 0, eflags: 0x1 linked
// Checksum 0xa552c3c6, Offset: 0xf478
// Size: 0x82
function function_e3025ca5() {
    if (is_survival() || function_c200446c()) {
        var_3afe334f = level.var_b48509f9;
    } else {
        var_3afe334f = ceil(level.round_number / 5);
    }
    return int(var_3afe334f);
}

// Namespace zm_utility/zm_utility
// Params 0, eflags: 0x1 linked
// Checksum 0x5ed823b7, Offset: 0xf508
// Size: 0xc2
function get_round_number() {
    if (is_survival()) {
        var_88710b09 = zombie_utility::function_d2dfacfd(#"hash_6ba259e60f87bb15");
        n_round_number = isdefined(var_88710b09[level.var_b48509f9 - 1].round) ? var_88710b09[level.var_b48509f9 - 1].round : 0;
    } else {
        n_round_number = isdefined(self._starting_round_number) ? self._starting_round_number : level.round_number;
    }
    return int(n_round_number);
}

