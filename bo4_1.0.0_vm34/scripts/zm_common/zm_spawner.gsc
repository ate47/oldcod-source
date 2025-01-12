#using scripts\core_common\ai\systems\gib;
#using scripts\core_common\ai\zombie_death;
#using scripts\core_common\ai\zombie_shared;
#using scripts\core_common\ai\zombie_utility;
#using scripts\core_common\ai_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\demo_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\laststand_shared;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\scene_shared;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\zm_common\util;
#using scripts\zm_common\zm;
#using scripts\zm_common\zm_audio;
#using scripts\zm_common\zm_behavior;
#using scripts\zm_common\zm_behavior_utility;
#using scripts\zm_common\zm_bgb;
#using scripts\zm_common\zm_blockers;
#using scripts\zm_common\zm_equipment;
#using scripts\zm_common\zm_laststand;
#using scripts\zm_common\zm_loadout;
#using scripts\zm_common\zm_net;
#using scripts\zm_common\zm_player;
#using scripts\zm_common\zm_powerups;
#using scripts\zm_common\zm_puppet;
#using scripts\zm_common\zm_quick_spawning;
#using scripts\zm_common\zm_score;
#using scripts\zm_common\zm_stats;
#using scripts\zm_common\zm_utility;
#using scripts\zm_common\zm_weapons;
#using scripts\zm_common\zm_zonemgr;

#namespace zm_spawner;

// Namespace zm_spawner/zm_spawner
// Params 0, eflags: 0x0
// Checksum 0x16d555c4, Offset: 0x718
// Size: 0x22c
function init() {
    level._contextual_grab_lerp_time = 0.3;
    level.zombie_spawners = getentarray("zombie_spawner", "script_noteworthy");
    level.var_831bfaed = [];
    level.var_22060a89 = [];
    if (isdefined(level.use_multiple_spawns) && level.use_multiple_spawns) {
        level.zombie_spawn = [];
        for (i = 0; i < level.zombie_spawners.size; i++) {
            if (isdefined(level.zombie_spawners[i].script_int)) {
                int = level.zombie_spawners[i].script_int;
                if (!isdefined(level.zombie_spawn[int])) {
                    level.zombie_spawn[int] = [];
                }
                level.zombie_spawn[int][level.zombie_spawn[int].size] = level.zombie_spawners[i];
            }
        }
    }
    if (isdefined(level.ignore_spawner_func)) {
        for (i = 0; i < level.zombie_spawners.size; i++) {
            ignore = [[ level.ignore_spawner_func ]](level.zombie_spawners[i]);
            if (ignore) {
                arrayremovevalue(level.zombie_spawners, level.zombie_spawners[i]);
            }
        }
    }
    if (!isdefined(level.attack_player_thru_boards_range)) {
        level.attack_player_thru_boards_range = 109.8;
    }
    if (isdefined(level._game_module_custom_spawn_init_func)) {
        [[ level._game_module_custom_spawn_init_func ]]();
    }
    /#
        level thread debug_show_exterior_goals();
    #/
}

/#

    // Namespace zm_spawner/zm_spawner
    // Params 0, eflags: 0x0
    // Checksum 0x8cb965d4, Offset: 0x950
    // Size: 0x3fa
    function debug_show_exterior_goals() {
        while (true) {
            if (isdefined(level.toggle_show_exterior_goals) && level.toggle_show_exterior_goals) {
                color = (1, 1, 1);
                color_red = (1, 0, 0);
                color_blue = (0, 0, 1);
                foreach (zone in level.zones) {
                    foreach (location in zone.a_loc_types[#"zombie_location"]) {
                        recordstar(location.origin, color);
                    }
                }
                foreach (zone in level.zones) {
                    foreach (location in zone.a_loc_types[#"zombie_location"]) {
                        foreach (goal in level.exterior_goals) {
                            if (goal.script_string == location.script_string) {
                                recordline(location.origin, goal.origin, color);
                                goal.has_spawner = 1;
                                break;
                            }
                        }
                    }
                }
                foreach (goal in level.exterior_goals) {
                    if (isdefined(goal.has_spawner) && goal.has_spawner) {
                        recordcircle(goal.origin, 16, color);
                        continue;
                    }
                    if (isdefined(goal.script_string) && goal.script_string == "<dev string:x30>") {
                        recordcircle(goal.origin, 16, color_blue);
                        continue;
                    }
                    recordcircle(goal.origin, 16, color_red);
                }
            }
            waitframe(1);
        }
    }

#/

// Namespace zm_spawner/zm_spawner
// Params 1, eflags: 0x0
// Checksum 0x9f753066, Offset: 0xd58
// Size: 0xf0
function is_spawner_targeted_by_blocker(ent) {
    if (isdefined(ent.targetname)) {
        targeters = getentarray(ent.targetname, "target");
        for (i = 0; i < targeters.size; i++) {
            if (targeters[i].targetname == "zombie_door" || targeters[i].targetname == "zombie_debris") {
                return true;
            }
            result = is_spawner_targeted_by_blocker(targeters[i]);
            if (result) {
                return true;
            }
        }
    }
    return false;
}

// Namespace zm_spawner/zm_spawner
// Params 1, eflags: 0x0
// Checksum 0x3aa05b1d, Offset: 0xe50
// Size: 0x46
function add_custom_zombie_spawn_logic(func) {
    if (!isdefined(level._zombie_custom_spawn_logic)) {
        level._zombie_custom_spawn_logic = [];
    }
    level._zombie_custom_spawn_logic[level._zombie_custom_spawn_logic.size] = func;
}

// Namespace zm_spawner/zm_spawner
// Params 0, eflags: 0x0
// Checksum 0x395a364d, Offset: 0xea0
// Size: 0x564
function zombie_spawn_init() {
    self.targetname = "zombie";
    self.script_noteworthy = undefined;
    self.var_e9e45f3f = 1;
    self.var_ad0da952 = 1;
    self.var_84a54f57 = 1;
    if (isdefined(zm_utility::get_gamemode_var("pre_init_zombie_spawn_func"))) {
        self [[ zm_utility::get_gamemode_var("pre_init_zombie_spawn_func") ]]();
    }
    self thread zm_audio::play_ambient_zombie_vocals();
    self thread zm_audio::zmbaivox_notifyconvert();
    self.zmb_vocals_attack = "zmb_vocals_zombie_attack";
    self.allowdeath = 1;
    self.force_gib = 1;
    self.is_zombie = 1;
    self allowedstances("stand");
    self.attackercountthreatscale = 0;
    self.currentenemythreatscale = 0;
    self.recentattackerthreatscale = 0;
    self.coverthreatscale = 0;
    self.fovcosine = 0;
    self.fovcosinebusy = 0;
    self.zombie_damaged_by_bar_knockdown = 0;
    self.gibbed = 0;
    self.head_gibbed = 0;
    self.goalradius = 32;
    self.disablearrivals = 1;
    self.disableexits = 1;
    self.grenadeawareness = 0;
    self.badplaceawareness = 1;
    self.ignoresuppression = 1;
    self.suppressionthreshold = 1;
    self.nododgemove = 1;
    self.dontshootwhilemoving = 1;
    self.pathenemylookahead = 0;
    self.holdfire = 1;
    self.chatinitialized = 0;
    self zombie_utility::function_9c628842(0);
    self.canbetargetedbyturnedzombies = 1;
    self.var_7d06ae6a = 1;
    if (!isdefined(self.zombie_arms_position)) {
        if (randomint(2) == 0) {
            self.zombie_arms_position = "up";
        } else {
            self.zombie_arms_position = "down";
        }
    }
    if (randomint(100) < 25) {
        self.canstumble = 1;
    }
    self zm_utility::disable_react();
    if (!isdefined(level.zombie_health)) {
        level.zombie_health = zombie_utility::ai_calculate_health(zombie_utility::get_zombie_var(#"zombie_health_start"), level.round_number);
    }
    self.maxhealth = int(level.zombie_health * (isdefined(level.var_b326c393) ? level.var_b326c393 : 1));
    self.health = self.maxhealth;
    self.freezegun_damage = 0;
    self setavoidancemask("avoid none");
    self pathmode("dont move");
    level thread zombie_death_event(self);
    self thread zombie_utility::zombie_gib_on_damage();
    self thread zombie_damage_failsafe();
    self.deathfunction = &zombie_death_animscript;
    self.flame_damage_time = 0;
    self.meleedamage = 60;
    self.no_powerups = 1;
    /#
        self zombie_history("<dev string:x3b>" + self.origin);
    #/
    self.thundergun_knockdown_func = level.basic_zombie_thundergun_knockdown;
    self.tesla_head_gib_func = &zombie_tesla_head_gib;
    self.team = level.zombie_team;
    self.updatesight = 0;
    if (isdefined(level.var_e3fd39be)) {
        self.heroweapon_kill_power = level.var_e3fd39be;
        self.sword_kill_power = level.var_e3fd39be;
    } else {
        self.heroweapon_kill_power = 2;
        self.sword_kill_power = 2;
    }
    if (isdefined(level.var_9aca36e2)) {
        self [[ level.var_9aca36e2 ]]();
    }
    if (isdefined(zm_utility::get_gamemode_var("post_init_zombie_spawn_func"))) {
        self [[ zm_utility::get_gamemode_var("post_init_zombie_spawn_func") ]]();
    }
    if (isdefined(level.var_a7873a6) && level.var_a7873a6) {
        self thread zombie_utility::makezombiecrawler();
    }
}

// Namespace zm_spawner/zm_spawner
// Params 0, eflags: 0x0
// Checksum 0xdf7f86fe, Offset: 0x1410
// Size: 0x3c
function function_7034100b() {
    self endon(#"death");
    self waittill(#"completed_emerging_into_playable_area");
    self zombie_utility::makezombiecrawler();
}

// Namespace zm_spawner/zm_spawner
// Params 0, eflags: 0x0
// Checksum 0xbc8374f6, Offset: 0x1458
// Size: 0x1ea
function zombie_damage_failsafe() {
    self endon(#"death");
    for (var_370bf1e2 = 0; true; var_370bf1e2 = 0) {
        wait 0.5;
        if (!isdefined(self.enemy) || !isplayer(self.enemy)) {
            continue;
        }
        if (self istouching(self.enemy)) {
            old_org = self.origin;
            if (!var_370bf1e2) {
                wait 5;
            }
            if (!isdefined(self.enemy) || !isplayer(self.enemy) || self.enemy hasperk(#"specialty_armorvest")) {
                continue;
            }
            if (self istouching(self.enemy) && !self.enemy laststand::player_is_in_laststand() && isalive(self.enemy)) {
                if (distancesquared(old_org, self.origin) < 3600) {
                    self.enemy dodamage(self.enemy.health + 1000, self.enemy.origin, self, self, "none", "MOD_RIFLE_BULLET");
                    var_370bf1e2 = 1;
                }
            }
            continue;
        }
    }
}

// Namespace zm_spawner/zm_spawner
// Params 1, eflags: 0x0
// Checksum 0x78286a6f, Offset: 0x1650
// Size: 0x34
function should_skip_teardown(find_flesh_struct_string) {
    if (!isdefined(find_flesh_struct_string)) {
        return true;
    }
    if (find_flesh_struct_string === "find_flesh") {
        return true;
    }
    return false;
}

// Namespace zm_spawner/zm_spawner
// Params 0, eflags: 0x0
// Checksum 0x2f861936, Offset: 0x1690
// Size: 0x1ba
function zombie_think() {
    self endon(#"death");
    assert(!self.isdog);
    self.ai_state = "zombie_think";
    find_flesh_struct_string = undefined;
    if (isdefined(level.zombie_custom_think_logic)) {
        shouldwait = self [[ level.zombie_custom_think_logic ]]();
        if (shouldwait) {
            self waittill(#"zombie_custom_think_done", find_flesh_struct_string);
        }
    } else if (isdefined(self.start_inert) && self.start_inert) {
        find_flesh_struct_string = "find_flesh";
    } else {
        if (isdefined(self.custom_location)) {
            self thread [[ self.custom_location ]]();
        } else {
            self thread do_zombie_spawn();
        }
        waitresult = self waittill(#"risen");
        find_flesh_struct_string = waitresult.find_flesh_struct_string;
    }
    self.find_flesh_struct_string = find_flesh_struct_string;
    /#
        self.backupnode = self.first_node;
        self thread zm_puppet::wait_for_puppet_pickup();
    #/
    self setgoal(self.origin);
    self pathmode("move allowed");
    self.zombie_think_done = 1;
}

// Namespace zm_spawner/zm_spawner
// Params 0, eflags: 0x0
// Checksum 0x9e470b9, Offset: 0x1858
// Size: 0x1cc
function zombie_entered_playable() {
    self endon(#"death");
    if (zm_utility::function_be4cf12d()) {
        if (!isdefined(level.var_4b530519)) {
            level.var_4b530519 = getnodearray("player_region", "script_noteworthy");
        }
    }
    if (zm_utility::function_a70772a9()) {
        if (!isdefined(level.playable_areas)) {
            level.playable_areas = getentarray("player_volume", "script_noteworthy");
        }
    }
    while (true) {
        if (isdefined(level.var_4b530519)) {
            node = function_e910fb8c(self.origin, level.var_4b530519, 500);
            if (isdefined(node)) {
                self zombie_complete_emerging_into_playable_area();
                return;
            }
        }
        if (isdefined(level.playable_areas)) {
            foreach (area in level.playable_areas) {
                if (self istouching(area)) {
                    self zombie_complete_emerging_into_playable_area();
                    return;
                }
            }
        }
        wait 1;
    }
}

// Namespace zm_spawner/zm_spawner
// Params 0, eflags: 0x0
// Checksum 0x42e6df81, Offset: 0x1a30
// Size: 0x3bc
function zombie_assure_node() {
    self endon(#"death", #"goal");
    level endon(#"intermission");
    start_pos = self.origin;
    if (isdefined(self.entrance_nodes)) {
        for (i = 0; i < self.entrance_nodes.size; i++) {
            if (self zombie_bad_path()) {
                /#
                    self zombie_history("<dev string:x5b>" + self.entrance_nodes[i].origin);
                    println("<dev string:x8a>" + self.origin + "<dev string:x96>" + self.entrance_nodes[i].origin);
                    level thread zm_utility::draw_line_ent_to_pos(self, self.entrance_nodes[i].origin, "<dev string:xd0>");
                #/
                self.first_node = self.entrance_nodes[i];
                self setgoal(self.entrance_nodes[i].origin);
                continue;
            }
            return;
        }
    }
    wait 2;
    nodes = array::get_all_closest(self.origin, level.exterior_goals, undefined, 20);
    if (isdefined(nodes)) {
        self.entrance_nodes = nodes;
        for (i = 0; i < self.entrance_nodes.size; i++) {
            if (self zombie_bad_path()) {
                /#
                    self zombie_history("<dev string:x5b>" + self.entrance_nodes[i].origin);
                    println("<dev string:x8a>" + self.origin + "<dev string:x96>" + self.entrance_nodes[i].origin);
                    level thread zm_utility::draw_line_ent_to_pos(self, self.entrance_nodes[i].origin, "<dev string:xd0>");
                #/
                self.first_node = self.entrance_nodes[i];
                self setgoal(self.entrance_nodes[i].origin);
                continue;
            }
            return;
        }
    }
    /#
        self zombie_history("<dev string:xd5>");
    #/
    wait 20;
    self dodamage(self.health + 10, self.origin);
    if (isdefined(level.put_timed_out_zombies_back_in_queue) && level.put_timed_out_zombies_back_in_queue && !(isdefined(self.has_been_damaged_by_player) && self.has_been_damaged_by_player)) {
        level.zombie_total++;
        level.zombie_total_subtract++;
    }
    level.zombies_timeout_spawn++;
}

// Namespace zm_spawner/zm_spawner
// Params 0, eflags: 0x0
// Checksum 0x489f76b0, Offset: 0x1df8
// Size: 0x48
function zombie_bad_path() {
    var_3551d88 = self waittilltimeout(2, #"bad_path");
    if (var_3551d88._notify === "bad_path") {
        return true;
    }
    return false;
}

// Namespace zm_spawner/zm_spawner
// Params 0, eflags: 0x0
// Checksum 0x5db9cac, Offset: 0x1e48
// Size: 0x20c
function do_a_taunt() {
    self endon(#"death");
    if (self.missinglegs) {
        return 0;
    }
    if (!self.first_node.zbarrier zbarriersupportszombietaunts()) {
        return;
    }
    self.old_origin = self.origin;
    if (getdvarstring(#"zombie_taunt_freq") == "") {
        setdvar(#"zombie_taunt_freq", 5);
    }
    freq = getdvarint(#"zombie_taunt_freq", 0);
    if (freq >= randomint(100)) {
        bhtnactionstartevent(self, "taunt");
        self notify(#"bhtn_action_notify", {#action:"taunt"});
        tauntstate = "zm_taunt";
        if (isdefined(self.first_node.zbarrier) && self.first_node.zbarrier getzbarriertauntanimstate() != "") {
            tauntstate = self.first_node.zbarrier getzbarriertauntanimstate();
        }
        self animscripted("taunt_anim", self.origin, self.angles, "ai_zombie_taunts_4");
        self taunt_notetracks("taunt_anim");
    }
}

// Namespace zm_spawner/zm_spawner
// Params 1, eflags: 0x0
// Checksum 0xf4d72e9a, Offset: 0x2060
// Size: 0x7a
function taunt_notetracks(msg) {
    self endon(#"death");
    while (true) {
        waitresult = self waittill(msg);
        if (waitresult.notetrack == "end") {
            self forceteleport(self.old_origin);
            return;
        }
    }
}

// Namespace zm_spawner/zm_spawner
// Params 0, eflags: 0x0
// Checksum 0x7b3de1af, Offset: 0x20e8
// Size: 0x328
function should_attack_player_thru_boards() {
    if (self.missinglegs) {
        return false;
    }
    if (isdefined(self.first_node.zbarrier)) {
        if (!self.first_node.zbarrier zbarriersupportszombiereachthroughattacks()) {
            return false;
        }
    }
    if (getdvarstring(#"zombie_reachin_freq") == "") {
        setdvar(#"zombie_reachin_freq", 50);
    }
    freq = getdvarint(#"zombie_reachin_freq", 0);
    players = getplayers();
    attack = 0;
    self.player_targets = [];
    for (i = 0; i < players.size; i++) {
        if (isalive(players[i]) && !isdefined(players[i].revivetrigger) && distance2d(self.origin, players[i].origin) <= level.attack_player_thru_boards_range) {
            self.player_targets[self.player_targets.size] = players[i];
            attack = 1;
        }
    }
    if (!attack || freq < randomint(100)) {
        return false;
    }
    self.old_origin = self.origin;
    attackanimstate = "zm_window_melee";
    if (isdefined(self.first_node.zbarrier) && self.first_node.zbarrier getzbarrierreachthroughattackanimstate() != "") {
        attackanimstate = self.first_node.zbarrier getzbarrierreachthroughattackanimstate();
    }
    bhtnactionstartevent(self, "attack");
    self notify(#"bhtn_action_notify", {#action:"attack"});
    self animscripted("window_melee_anim", self.origin, self.angles, "ai_zombie_window_attack_arm_l_out");
    self window_notetracks("window_melee_anim");
    return true;
}

// Namespace zm_spawner/zm_spawner
// Params 1, eflags: 0x0
// Checksum 0x84c6d469, Offset: 0x2418
// Size: 0x2e8
function window_notetracks(msg) {
    self endon(#"death");
    while (true) {
        waitresult = self waittill(msg);
        if (waitresult.notetrack == "end") {
            self teleport(self.old_origin);
            return;
        }
        if (waitresult.notetrack == "fire") {
            if (self.ignoreall) {
                self val::reset(#"attack_properties", "ignoreall");
            }
            if (isdefined(self.first_node)) {
                var_987be0da = 8100;
                if (isdefined(level.attack_player_thru_boards_range)) {
                    var_987be0da = level.attack_player_thru_boards_range * level.attack_player_thru_boards_range;
                }
                for (i = 0; i < self.player_targets.size; i++) {
                    playerdistsq = distance2dsquared(self.player_targets[i].origin, self.origin);
                    heightdiff = abs(self.player_targets[i].origin[2] - self.origin[2]);
                    if (playerdistsq < var_987be0da && heightdiff * heightdiff < var_987be0da) {
                        triggerdistsq = distance2dsquared(self.player_targets[i].origin, self.first_node.trigger_location.origin);
                        heightdiff = abs(self.player_targets[i].origin[2] - self.first_node.trigger_location.origin[2]);
                        if (triggerdistsq < 2601 && heightdiff * heightdiff < 2601) {
                            self.player_targets[i] dodamage(self.meleedamage, self.origin, self, self, "none", "MOD_MELEE");
                            break;
                        }
                    }
                }
                continue;
            }
            self melee();
        }
    }
}

// Namespace zm_spawner/zm_spawner
// Params 1, eflags: 0x0
// Checksum 0x39c1a5f9, Offset: 0x2708
// Size: 0xd2
function get_attack_spot(node) {
    index = get_attack_spot_index(node);
    if (!isdefined(index)) {
        return false;
    }
    /#
        val = getdvarint(#"zombie_attack_spot", 0);
        if (val > -1) {
            index = val;
        }
    #/
    self.attacking_node = node;
    self.attacking_spot_index = index;
    node.attack_spots_taken[index] = 1;
    self.attacking_spot = node.attack_spots[index];
    return true;
}

// Namespace zm_spawner/zm_spawner
// Params 1, eflags: 0x0
// Checksum 0x72227ed5, Offset: 0x27e8
// Size: 0xb8
function get_attack_spot_index(node) {
    indexes = [];
    if (!isdefined(node.attack_spots)) {
        node.attack_spots = [];
    }
    for (i = 0; i < node.attack_spots.size; i++) {
        if (!node.attack_spots_taken[i]) {
            indexes[indexes.size] = i;
        }
    }
    if (indexes.size == 0) {
        return undefined;
    }
    return indexes[randomint(indexes.size)];
}

// Namespace zm_spawner/zm_spawner
// Params 3, eflags: 0x0
// Checksum 0x42663113, Offset: 0x28a8
// Size: 0x110
function zombie_tear_notetracks(msg, chunk, node) {
    self endon(#"death");
    while (true) {
        waitresult = self waittill(msg);
        if (waitresult.notetrack == "end") {
            return;
        }
        if (waitresult.notetrack == "board" || waitresult.notetrack == "destroy_piece" || waitresult.notetrack == "bar") {
            if (isdefined(level.zbarrier_zombie_tear_notetrack_override)) {
                self thread [[ level.zbarrier_zombie_tear_notetrack_override ]](node, chunk);
            }
            node.zbarrier setzbarrierpiecestate(chunk, "opening");
        }
    }
}

// Namespace zm_spawner/zm_spawner
// Params 2, eflags: 0x0
// Checksum 0x7dd59a4, Offset: 0x29c0
// Size: 0x394
function zombie_boardtear_offset_fx_horizontle(chunk, node) {
    if (isdefined(chunk.script_parameters) && (chunk.script_parameters == "repair_board" || chunk.script_parameters == "board")) {
        if (isdefined(chunk.unbroken) && chunk.unbroken == 1) {
            if (isdefined(chunk.material) && chunk.material == "glass") {
                playfx(level._effect[#"glass_break"], chunk.origin, node.angles);
                chunk.unbroken = 0;
            } else if (isdefined(chunk.material) && chunk.material == "metal") {
                playfx(level._effect[#"fx_zombie_bar_break"], chunk.origin);
                chunk.unbroken = 0;
            } else if (isdefined(chunk.material) && chunk.material == "rock") {
                if (isdefined(level.use_clientside_rock_tearin_fx) && level.use_clientside_rock_tearin_fx) {
                    chunk clientfield::set("tearin_rock_fx", 1);
                } else {
                    playfx(level._effect[#"wall_break"], chunk.origin);
                }
                chunk.unbroken = 0;
            }
        }
    }
    if (isdefined(chunk.script_parameters) && chunk.script_parameters == "barricade_vents") {
        if (isdefined(level.use_clientside_board_fx) && level.use_clientside_board_fx) {
            chunk clientfield::set("tearin_board_vertical_fx", 1);
        } else {
            playfx(level._effect[#"fx_zombie_bar_break"], chunk.origin);
        }
        return;
    }
    if (isdefined(chunk.material) && chunk.material == "rock") {
        if (isdefined(level.use_clientside_rock_tearin_fx) && level.use_clientside_rock_tearin_fx) {
            chunk clientfield::set("tearin_rock_fx", 1);
        }
        return;
    }
    if (isdefined(level.use_clientside_board_fx)) {
        chunk clientfield::set("tearin_board_vertical_fx", 1);
        return;
    }
    wait randomfloatrange(0.2, 0.4);
}

// Namespace zm_spawner/zm_spawner
// Params 2, eflags: 0x0
// Checksum 0xb0d0c376, Offset: 0x2d60
// Size: 0x384
function zombie_boardtear_offset_fx_verticle(chunk, node) {
    if (isdefined(chunk.script_parameters) && (chunk.script_parameters == "repair_board" || chunk.script_parameters == "board")) {
        if (isdefined(chunk.unbroken) && chunk.unbroken == 1) {
            if (isdefined(chunk.material) && chunk.material == "glass") {
                playfx(level._effect[#"glass_break"], chunk.origin, node.angles);
                chunk.unbroken = 0;
            } else if (isdefined(chunk.material) && chunk.material == "metal") {
                playfx(level._effect[#"fx_zombie_bar_break"], chunk.origin);
                chunk.unbroken = 0;
            } else if (isdefined(chunk.material) && chunk.material == "rock") {
                if (isdefined(level.use_clientside_rock_tearin_fx) && level.use_clientside_rock_tearin_fx) {
                    chunk clientfield::set("tearin_rock_fx", 1);
                } else {
                    playfx(level._effect[#"wall_break"], chunk.origin);
                }
                chunk.unbroken = 0;
            }
        }
    }
    if (isdefined(chunk.script_parameters) && chunk.script_parameters == "barricade_vents") {
        if (isdefined(level.use_clientside_board_fx)) {
            chunk clientfield::set("tearin_board_horizontal_fx", 1);
        } else {
            playfx(level._effect[#"fx_zombie_bar_break"], chunk.origin);
        }
        return;
    }
    if (isdefined(chunk.material) && chunk.material == "rock") {
        if (isdefined(level.use_clientside_rock_tearin_fx) && level.use_clientside_rock_tearin_fx) {
            chunk clientfield::set("tearin_rock_fx", 1);
        }
        return;
    }
    if (isdefined(level.use_clientside_board_fx)) {
        chunk clientfield::set("tearin_board_horizontal_fx", 1);
        return;
    }
    wait randomfloatrange(0.2, 0.4);
}

// Namespace zm_spawner/zm_spawner
// Params 1, eflags: 0x0
// Checksum 0x3c0ae628, Offset: 0x30f0
// Size: 0x622
function zombie_bartear_offset_fx_verticle(chunk) {
    if (isdefined(chunk.script_parameters) && chunk.script_parameters == "bar" || chunk.script_noteworthy == "board") {
        possible_tag_array_1 = [];
        possible_tag_array_1[0] = "Tag_fx_top";
        possible_tag_array_1[1] = "";
        possible_tag_array_1[2] = "Tag_fx_top";
        possible_tag_array_1[3] = "";
        possible_tag_array_2 = [];
        possible_tag_array_2[0] = "";
        possible_tag_array_2[1] = "Tag_fx_bottom";
        possible_tag_array_2[2] = "";
        possible_tag_array_2[3] = "Tag_fx_bottom";
        possible_tag_array_2 = array::randomize(possible_tag_array_2);
        random_fx = [];
        random_fx[0] = level._effect[#"fx_zombie_bar_break"];
        random_fx[1] = level._effect[#"fx_zombie_bar_break_lite"];
        random_fx[2] = level._effect[#"fx_zombie_bar_break"];
        random_fx[3] = level._effect[#"fx_zombie_bar_break_lite"];
        random_fx = array::randomize(random_fx);
        switch (randomint(9)) {
        case 0:
            playfxontag(level._effect[#"fx_zombie_bar_break_lite"], chunk, "Tag_fx_top");
            wait randomfloatrange(0, 0.3);
            playfxontag(level._effect[#"fx_zombie_bar_break_lite"], chunk, "Tag_fx_bottom");
            break;
        case 1:
            playfxontag(level._effect[#"fx_zombie_bar_break"], chunk, "Tag_fx_top");
            wait randomfloatrange(0, 0.3);
            playfxontag(level._effect[#"fx_zombie_bar_break"], chunk, "Tag_fx_bottom");
            break;
        case 2:
            playfxontag(level._effect[#"fx_zombie_bar_break_lite"], chunk, "Tag_fx_top");
            wait randomfloatrange(0, 0.3);
            playfxontag(level._effect[#"fx_zombie_bar_break"], chunk, "Tag_fx_bottom");
            break;
        case 3:
            playfxontag(level._effect[#"fx_zombie_bar_break"], chunk, "Tag_fx_top");
            wait randomfloatrange(0, 0.3);
            playfxontag(level._effect[#"fx_zombie_bar_break_lite"], chunk, "Tag_fx_bottom");
            break;
        case 4:
            playfxontag(level._effect[#"fx_zombie_bar_break_lite"], chunk, "Tag_fx_top");
            wait randomfloatrange(0, 0.3);
            playfxontag(level._effect[#"fx_zombie_bar_break_lite"], chunk, "Tag_fx_bottom");
            break;
        case 5:
            playfxontag(level._effect[#"fx_zombie_bar_break_lite"], chunk, "Tag_fx_top");
            break;
        case 6:
            playfxontag(level._effect[#"fx_zombie_bar_break_lite"], chunk, "Tag_fx_bottom");
            break;
        case 7:
            playfxontag(level._effect[#"fx_zombie_bar_break"], chunk, "Tag_fx_top");
            break;
        case 8:
            playfxontag(level._effect[#"fx_zombie_bar_break"], chunk, "Tag_fx_bottom");
            break;
        }
    }
}

// Namespace zm_spawner/zm_spawner
// Params 1, eflags: 0x0
// Checksum 0x4871316b, Offset: 0x3720
// Size: 0x4ba
function zombie_bartear_offset_fx_horizontle(chunk) {
    if (isdefined(chunk.script_parameters) && chunk.script_parameters == "bar" || chunk.script_noteworthy == "board") {
        switch (randomint(10)) {
        case 0:
            playfxontag(level._effect[#"fx_zombie_bar_break_lite"], chunk, "Tag_fx_left");
            wait randomfloatrange(0, 0.3);
            playfxontag(level._effect[#"fx_zombie_bar_break_lite"], chunk, "Tag_fx_right");
            break;
        case 1:
            playfxontag(level._effect[#"fx_zombie_bar_break"], chunk, "Tag_fx_left");
            wait randomfloatrange(0, 0.3);
            playfxontag(level._effect[#"fx_zombie_bar_break"], chunk, "Tag_fx_right");
            break;
        case 2:
            playfxontag(level._effect[#"fx_zombie_bar_break_lite"], chunk, "Tag_fx_left");
            wait randomfloatrange(0, 0.3);
            playfxontag(level._effect[#"fx_zombie_bar_break"], chunk, "Tag_fx_right");
            break;
        case 3:
            playfxontag(level._effect[#"fx_zombie_bar_break"], chunk, "Tag_fx_left");
            wait randomfloatrange(0, 0.3);
            playfxontag(level._effect[#"fx_zombie_bar_break_lite"], chunk, "Tag_fx_right");
            break;
        case 4:
            playfxontag(level._effect[#"fx_zombie_bar_break_lite"], chunk, "Tag_fx_left");
            wait randomfloatrange(0, 0.3);
            playfxontag(level._effect[#"fx_zombie_bar_break_lite"], chunk, "Tag_fx_right");
            break;
        case 5:
            playfxontag(level._effect[#"fx_zombie_bar_break_lite"], chunk, "Tag_fx_left");
            break;
        case 6:
            playfxontag(level._effect[#"fx_zombie_bar_break_lite"], chunk, "Tag_fx_right");
            break;
        case 7:
            playfxontag(level._effect[#"fx_zombie_bar_break"], chunk, "Tag_fx_right");
            break;
        case 8:
            playfxontag(level._effect[#"fx_zombie_bar_break"], chunk, "Tag_fx_right");
            break;
        }
    }
}

// Namespace zm_spawner/zm_spawner
// Params 3, eflags: 0x0
// Checksum 0x6634c57, Offset: 0x3be8
// Size: 0x94
function check_zbarrier_piece_for_zombie_inert(chunk_index, zbarrier, zombie) {
    zombie endon(#"completed_emerging_into_playable_area");
    zombie waittill(#"stop_zombie_goto_entrance");
    if (zbarrier getzbarrierpiecestate(chunk_index) == "targetted_by_zombie") {
        zbarrier setzbarrierpiecestate(chunk_index, "closed");
    }
}

// Namespace zm_spawner/zm_spawner
// Params 3, eflags: 0x0
// Checksum 0xcac12f3d, Offset: 0x3c88
// Size: 0xa0
function check_zbarrier_piece_for_zombie_death(chunk_index, zbarrier, zombie) {
    while (true) {
        if (zbarrier getzbarrierpiecestate(chunk_index) != "targetted_by_zombie") {
            return;
        }
        if (!isdefined(zombie) || !isalive(zombie)) {
            zbarrier setzbarrierpiecestate(chunk_index, "closed");
            return;
        }
        waitframe(1);
    }
}

// Namespace zm_spawner/zm_spawner
// Params 1, eflags: 0x0
// Checksum 0x1cc962d7, Offset: 0x3d30
// Size: 0x44
function check_for_zombie_death(zombie) {
    self endon(#"destroyed");
    wait 2.5;
    self zm_blockers::update_states("repaired");
}

// Namespace zm_spawner/zm_spawner
// Params 0, eflags: 0x0
// Checksum 0xe48eba78, Offset: 0x3d80
// Size: 0x2e
function player_can_score_from_zombies() {
    if (isdefined(self) && isdefined(self.inhibit_scoring_from_zombies) && self.inhibit_scoring_from_zombies) {
        return false;
    }
    return true;
}

// Namespace zm_spawner/zm_spawner
// Params 1, eflags: 0x0
// Checksum 0x9fbd874c, Offset: 0x3db8
// Size: 0x1aa
function zombie_can_drop_powerups(zombie) {
    if (zm_loadout::is_tactical_grenade(zombie.damageweapon) || !level flag::get("zombie_drop_powerups")) {
        return false;
    }
    if (isdefined(zombie.no_powerups) && zombie.no_powerups || isdefined(zombie.damageweapon) && isdefined(zombie.damageweapon.isheroweapon) && zombie.damageweapon.isheroweapon) {
        return false;
    }
    if (isdefined(level.no_powerups) && level.no_powerups) {
        return false;
    }
    if (isdefined(level.use_powerup_volumes) && level.use_powerup_volumes) {
        volumes = getentarray("no_powerups", "targetname");
        foreach (volume in volumes) {
            if (zombie istouching(volume)) {
                return false;
            }
        }
    }
    return true;
}

// Namespace zm_spawner/zm_spawner
// Params 1, eflags: 0x0
// Checksum 0xa5ba4f57, Offset: 0x3f70
// Size: 0x34
function function_1b6af62e(origin) {
    util::wait_network_frame();
    level thread zm_powerups::powerup_drop(origin);
}

// Namespace zm_spawner/zm_spawner
// Params 6, eflags: 0x0
// Checksum 0xaf1fdee2, Offset: 0x3fb0
// Size: 0x3c4
function zombie_death_points(origin, mod, hit_location, attacker, zombie, team) {
    if (!isdefined(attacker) || !isplayer(attacker) && !isplayer(attacker.owner)) {
        return;
    }
    if (isdefined(attacker.owner)) {
        player = attacker.owner;
    } else {
        player = attacker;
    }
    if (!player player_can_score_from_zombies()) {
        zombie.marked_for_recycle = 1;
        return;
    }
    if (zombie_can_drop_powerups(zombie)) {
        if (isdefined(zombie.in_the_ground) && zombie.in_the_ground == 1) {
            trace = bullettrace(zombie.origin + (0, 0, 100), zombie.origin + (0, 0, -100), 0, undefined);
            origin = trace[#"position"];
            level thread function_1b6af62e(origin);
        } else {
            trace = groundtrace(zombie.origin + (0, 0, 5), zombie.origin + (0, 0, -300), 0, undefined);
            origin = trace[#"position"];
            level thread function_1b6af62e(origin);
        }
    }
    if (isdefined(zombie.deathpoints_already_given) && zombie.deathpoints_already_given) {
        return;
    }
    zombie.deathpoints_already_given = 1;
    if (zm_equipment::is_equipment(zombie.damageweapon)) {
        return;
    }
    death_weapon = player.currentweapon;
    if (isdefined(zombie.damageweapon)) {
        death_weapon = zombie.damageweapon;
    }
    str_event = "death";
    if (isdefined(player)) {
        if (isdefined(zombie.var_3059fa07) && zombie.var_3059fa07) {
            if (isdefined(zombie.var_bf80c633)) {
                player zm_score::add_to_player_score(zombie.var_bf80c633, 1, "", zombie.var_f7038080);
            } else {
                player zm_score::add_to_player_score(50, 1, "", zombie.var_f7038080);
            }
        }
        player zm_score::player_add_points(str_event, mod, hit_location, zombie, team, death_weapon, undefined, zombie.var_f7038080);
    }
    if (isdefined(level.hero_power_update)) {
        level thread [[ level.hero_power_update ]](player, zombie, str_event);
    }
}

// Namespace zm_spawner/zm_spawner
// Params 2, eflags: 0x0
// Checksum 0x49b5a074, Offset: 0x4380
// Size: 0x17c
function zombie_ragdoll_then_explode(launchvector, attacker) {
    if (!isdefined(self)) {
        return;
    }
    self zombie_utility::zombie_eye_glow_stop();
    self clientfield::set("zombie_ragdoll_explode", 1);
    self notify(#"exploding");
    self notify(#"end_melee");
    self notify(#"death", attacker);
    self.dont_die_on_me = 1;
    self.exploding = 1;
    self.a.nodeath = 1;
    self.dont_throw_gib = 1;
    self startragdoll();
    self setplayercollision(0);
    self zombie_utility::reset_attack_spot();
    if (isdefined(launchvector)) {
        self launchragdoll(launchvector);
    }
    wait 2.1;
    if (isdefined(self)) {
        self ghost();
        self util::delay(0.25, undefined, &zm_utility::self_delete);
    }
}

// Namespace zm_spawner/zm_spawner
// Params 8, eflags: 0x0
// Checksum 0x11d9c7bf, Offset: 0x4508
// Size: 0x31a
function zombie_death_animscript(einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime) {
    team = undefined;
    if (isdefined(self._race_team)) {
        team = self._race_team;
    }
    self zombie_utility::reset_attack_spot();
    if (self check_zombie_death_animscript_callbacks()) {
        return false;
    }
    if (isdefined(level.var_9ca5d500)) {
        self [[ level.var_9ca5d500 ]]();
    }
    self.grenadeammo = 0;
    if (isdefined(self.nuked)) {
        if (zombie_can_drop_powerups(self)) {
            if (isdefined(self.in_the_ground) && self.in_the_ground == 1) {
                trace = bullettrace(self.origin + (0, 0, 100), self.origin + (0, 0, -100), 0, undefined);
                origin = trace[#"position"];
                level thread function_1b6af62e(origin);
            } else {
                trace = groundtrace(self.origin + (0, 0, 5), self.origin + (0, 0, -300), 0, undefined);
                origin = trace[#"position"];
                level thread function_1b6af62e(self.origin);
            }
        }
    } else {
        level zombie_death_points(self.origin, self.damagemod, self.damagelocation, self.attacker, self, team);
    }
    if (isdefined(self.attacker) && isai(self.attacker)) {
        self.attacker notify(#"killed", {#victim:self});
    }
    if (self.damagemod == "MOD_BURNED") {
        self thread zombie_death::flame_death_fx();
    }
    if (self.damagemod == "MOD_GRENADE" || self.damagemod == "MOD_GRENADE_SPLASH") {
        level notify(#"zombie_grenade_death", self.origin);
    }
    return false;
}

// Namespace zm_spawner/zm_spawner
// Params 0, eflags: 0x0
// Checksum 0xc6a82880, Offset: 0x4830
// Size: 0x66
function check_zombie_death_animscript_callbacks() {
    if (!isdefined(level.zombie_death_animscript_callbacks)) {
        return false;
    }
    for (i = 0; i < level.zombie_death_animscript_callbacks.size; i++) {
        if (self [[ level.zombie_death_animscript_callbacks[i] ]]()) {
            return true;
        }
    }
    return false;
}

// Namespace zm_spawner/zm_spawner
// Params 1, eflags: 0x0
// Checksum 0xf7e41f01, Offset: 0x48a0
// Size: 0x46
function register_zombie_death_animscript_callback(func) {
    if (!isdefined(level.zombie_death_animscript_callbacks)) {
        level.zombie_death_animscript_callbacks = [];
    }
    level.zombie_death_animscript_callbacks[level.zombie_death_animscript_callbacks.size] = func;
}

// Namespace zm_spawner/zm_spawner
// Params 1, eflags: 0x0
// Checksum 0x178fabb7, Offset: 0x48f0
// Size: 0x1e8
function damage_on_fire(player) {
    self endon(#"death", #"stop_flame_damage");
    wait 2;
    while (isdefined(self.is_on_fire) && self.is_on_fire) {
        if (level.round_number < 6) {
            dmg = level.zombie_health * randomfloatrange(0.2, 0.3);
        } else if (level.round_number < 9) {
            dmg = level.zombie_health * randomfloatrange(0.15, 0.25);
        } else if (level.round_number < 11) {
            dmg = level.zombie_health * randomfloatrange(0.1, 0.2);
        } else {
            dmg = level.zombie_health * randomfloatrange(0.1, 0.15);
        }
        if (isdefined(player) && isalive(player)) {
            self dodamage(dmg, self.origin, player, player, undefined, "MOD_BURNED");
        } else {
            self dodamage(dmg, self.origin);
        }
        wait randomfloatrange(1, 3);
    }
}

// Namespace zm_spawner/zm_spawner
// Params 1, eflags: 0x0
// Checksum 0x4d95b474, Offset: 0x4ae0
// Size: 0x68
function player_using_hi_score_weapon(player) {
    if (isplayer(player)) {
        weapon = player getcurrentweapon();
        return (weapon == level.weaponnone || weapon.issemiauto);
    }
    return false;
}

// Namespace zm_spawner/zm_spawner
// Params 3, eflags: 0x0
// Checksum 0x87ac8477, Offset: 0x4b50
// Size: 0x196
function function_112edd9(mod, player, amount) {
    if (zm_utility::is_magic_bullet_shield_enabled(self)) {
        return amount;
    }
    if (isdefined(self.marked_for_death)) {
        return amount;
    }
    if (isdefined(self.var_101fcd59) && self.var_101fcd59) {
        return amount;
    }
    if (!isdefined(player)) {
        return amount;
    }
    if (self zombie_flame_damage(mod, player)) {
    } else if (mod == "MOD_GRENADE" || mod == "MOD_GRENADE_SPLASH") {
        if (isdefined(player) && isalive(player)) {
            player.grenade_multiattack_count++;
            player.grenade_multiattack_ent = self;
        }
        amount += level.round_number + randomintrange(100, 200);
    } else if (mod == "MOD_PROJECTILE" || mod == "MOD_EXPLOSIVE" || mod == "MOD_PROJECTILE_SPLASH") {
        amount += level.round_number * randomintrange(0, 100);
    }
    return amount;
}

/#

    // Namespace zm_spawner/zm_spawner
    // Params 1, eflags: 0x0
    // Checksum 0xcaf5f41b, Offset: 0x4cf0
    // Size: 0x2c
    function register_zombie_damage_callback(func) {
        assertmsg("<dev string:x110>");
    }

#/

// Namespace zm_spawner/zm_spawner
// Params 2, eflags: 0x0
// Checksum 0x4581b835, Offset: 0x4d28
// Size: 0x154
function zombie_flame_damage(mod, player) {
    if (mod == "MOD_BURNED") {
        if (!isdefined(self.is_on_fire) || isdefined(self.is_on_fire) && !self.is_on_fire) {
            self thread damage_on_fire(player);
        }
        do_flame_death = 1;
        ai = getaiteamarray(level.zombie_team);
        for (i = 0; i < ai.size; i++) {
            if (isdefined(ai[i].is_on_fire) && ai[i].is_on_fire) {
                if (distancesquared(ai[i].origin, self.origin) < 10000) {
                    do_flame_death = 0;
                    break;
                }
            }
        }
        if (do_flame_death) {
            self thread zombie_death::flame_death_fx();
        }
        return true;
    }
    return false;
}

// Namespace zm_spawner/zm_spawner
// Params 1, eflags: 0x0
// Checksum 0xa272afe8, Offset: 0x4e88
// Size: 0x20
function is_weapon_shotgun(weapon) {
    return weapon.weapclass == "spread";
}

// Namespace zm_spawner/zm_spawner
// Params 1, eflags: 0x0
// Checksum 0x43cc670e, Offset: 0x4eb0
// Size: 0x13c
function zombie_explodes_intopieces(random_gibs) {
    if (isdefined(self) && isactor(self)) {
        if (!random_gibs || randomint(100) < 50) {
            gibserverutils::gibhead(self);
        }
        if (!random_gibs || randomint(100) < 50) {
            gibserverutils::gibleftarm(self);
        }
        if (!random_gibs || randomint(100) < 50) {
            gibserverutils::gibrightarm(self);
        }
        if (!random_gibs || randomint(100) < 50) {
            gibserverutils::giblegs(self);
        }
    }
}

// Namespace zm_spawner/zm_spawner
// Params 1, eflags: 0x0
// Checksum 0x7e35524d, Offset: 0x4ff8
// Size: 0xcf4
function zombie_death_event(zombie) {
    zombie.marked_for_recycle = 0;
    force_head_gib = 0;
    waitresult = zombie waittill(#"death");
    attacker = waitresult.attacker;
    time_of_death = gettime();
    if (isdefined(zombie)) {
        zombie stopsounds();
    }
    if (isdefined(zombie) && isdefined(zombie.marked_for_insta_upgraded_death)) {
        force_head_gib = 1;
    }
    if (isdefined(zombie) && !isdefined(zombie.damagehit_origin) && isdefined(attacker) && isalive(attacker) && !isvehicle(attacker)) {
        zombie.damagehit_origin = attacker getweaponmuzzlepoint();
    }
    if (isdefined(attacker) && isplayer(attacker) && attacker player_can_score_from_zombies()) {
        if (isdefined(zombie.script_parameters)) {
            attacker notify(#"zombie_death_params", {#params:zombie.script_parameters, #var_4a54a0fe:isdefined(zombie.completed_emerging_into_playable_area) && zombie.completed_emerging_into_playable_area});
        }
        if (isdefined(zombie.b_widows_wine_cocoon) && isdefined(zombie.e_widows_wine_player)) {
            attacker notify(#"widows_wine_kill", {#player:zombie.e_widows_wine_player});
        }
        if (isdefined(zombie) && isdefined(zombie.damagelocation)) {
            if (zm_utility::is_headshot(zombie.damageweapon, zombie.damagelocation, zombie.damagemod)) {
                attacker.headshots++;
                attacker zm_stats::increment_client_stat("headshots");
                attacker stats::function_4f10b697(zombie.damageweapon, #"headshots", 1);
                attacker zm_stats::increment_player_stat("headshots");
                attacker zm_stats::function_ed968b89("headshots");
                attacker zm_stats::increment_challenge_stat("ZOMBIE_HUNTER_KILL_HEADSHOT");
            } else {
                attacker notify(#"zombie_death_no_headshot");
            }
        }
        if (isdefined(zombie) && isdefined(zombie.damagemod) && zombie.damagemod == "MOD_MELEE") {
            attacker zm_stats::increment_client_stat("melee_kills");
            attacker zm_stats::increment_player_stat("melee_kills");
            attacker notify(#"melee_kill");
            attacker zm_stats::increment_challenge_stat("ZOMBIE_HUNTER_KILL_MELEE");
        }
        attacker demo::add_actor_bookmark_kill_time();
        attacker.kills++;
        attacker zm_stats::increment_client_stat("kills");
        attacker zm_stats::increment_player_stat("kills");
        attacker zm_stats::function_ed968b89("kills");
        if (isdefined(zombie) && isdefined(zombie.damageweapon)) {
            attacker stats::function_4f10b697(zombie.damageweapon, #"kills", 1);
            if (zm_weapons::is_weapon_upgraded(zombie.damageweapon)) {
                attacker zm_stats::increment_challenge_stat("ZOMBIE_HUNTER_KILL_PACKAPUNCH");
            }
        }
        if (isdefined(zombie) && isdefined(zombie.missinglegs) && zombie.missinglegs) {
            attacker zm_stats::increment_challenge_stat("ZOMBIE_HUNTER_KILL_CRAWLER");
        }
        if (force_head_gib) {
            zombie zombie_utility::zombie_head_gib();
        }
    }
    if (!isdefined(zombie)) {
        return;
    }
    if (isplayer(attacker) && isdefined(attacker.n_health_on_kill)) {
        attacker.health += attacker.n_health_on_kill;
        if (attacker.health >= attacker.maxhealth) {
            attacker zm_utility::set_max_health(1);
        }
    }
    if (isdefined(zombie.nuked) && zombie.nuked) {
        foreach (player in level.activeplayers) {
            if (isdefined(player.n_health_on_kill)) {
                player.health += player.n_health_on_kill;
                if (player.health >= player.maxhealth) {
                    player zm_utility::set_max_health(1);
                }
            }
        }
    }
    level.global_zombies_killed++;
    if (isdefined(zombie.marked_for_death) && !isdefined(zombie.nuked)) {
        level.zombie_trap_killed_count++;
    }
    zombie check_zombie_death_event_callbacks(attacker);
    zombie bgb::actor_death_override(attacker);
    if (!isdefined(zombie)) {
        return;
    }
    name = zombie.animname;
    if (isdefined(zombie.sndname)) {
        name = zombie.sndname;
    }
    bhtnactionstartevent(zombie, "death");
    self notify(#"bhtn_action_notify", {#action:"death"});
    zombie thread zombie_utility::zombie_eye_glow_stop();
    if (isactor(zombie)) {
        if (isdefined(zombie.damageweapon.dogibbing) && zombie.damageweapon.dogibbing) {
            zombie zombie_explodes_intopieces(0);
        } else if (isdefined(zombie.damageweapon.doannihilate) && zombie.damageweapon.doannihilate || is_weapon_shotgun(zombie.damageweapon) && zm_weapons::is_weapon_upgraded(zombie.damageweapon) || zm_loadout::is_placeable_mine(zombie.damageweapon) || zombie.damagemod === "MOD_GRENADE" || zombie.damagemod === "MOD_GRENADE_SPLASH" || zombie.damagemod === "MOD_EXPLOSIVE") {
            if (isdefined(zombie.damageweapon.doannihilate) && zombie.damageweapon.doannihilate || isdefined(zombie.damagehit_origin) && distancesquared(zombie.origin, zombie.damagehit_origin) < 180 * 180) {
                tag = "J_SpineLower";
                if (isdefined(zombie.isdog) && zombie.isdog) {
                    tag = "tag_origin";
                }
                if (isdefined(zombie.var_84a54f57) && zombie.var_84a54f57 && !(isdefined(zombie.is_on_fire) && zombie.is_on_fire) && !(isdefined(zombie.guts_explosion) && zombie.guts_explosion)) {
                    zombie thread zombie_utility::zombie_gut_explosion();
                }
            }
            if (isdefined(attacker) && isplayer(attacker) && !is_weapon_shotgun(zombie.damageweapon)) {
                attacker zm_stats::increment_challenge_stat("ZOMBIE_HUNTER_KILL_EXPLOSIVES");
            }
        }
        if (zombie.damagemod === "MOD_GRENADE" || zombie.damagemod === "MOD_GRENADE_SPLASH") {
            if (isdefined(attacker) && isalive(attacker) && isplayer(attacker)) {
                attacker.grenade_multiattack_count++;
                attacker.grenade_multiattack_ent = zombie;
                attacker.grenade_multikill_count++;
            }
        }
    }
    if (!(isdefined(zombie.has_been_damaged_by_player) && zombie.has_been_damaged_by_player) && isdefined(zombie.marked_for_recycle) && zombie.marked_for_recycle) {
        level.zombie_total++;
        level.zombie_total_subtract++;
    } else if (isdefined(zombie.attacker) && isplayer(zombie.attacker)) {
        level.zombie_player_killed_count++;
        if (isdefined(zombie.sound_damage_player) && zombie.sound_damage_player == zombie.attacker) {
            zombie.attacker zm_audio::create_and_play_dialog("kill", "damage");
        }
        zombie.attacker notify(#"zom_kill", {#zombie:zombie});
    } else if (zombie.ignoreall && !(isdefined(zombie.marked_for_death) && zombie.marked_for_death)) {
        level.zombies_timeout_spawn++;
    }
    level notify(#"zom_kill");
    level.total_zombies_killed++;
}

// Namespace zm_spawner/zm_spawner
// Params 1, eflags: 0x0
// Checksum 0x7bcec966, Offset: 0x5cf8
// Size: 0x64
function check_zombie_death_event_callbacks(attacker) {
    if (!isdefined(level.zombie_death_event_callbacks)) {
        return;
    }
    for (i = 0; i < level.zombie_death_event_callbacks.size; i++) {
        self [[ level.zombie_death_event_callbacks[i] ]](attacker);
    }
}

// Namespace zm_spawner/zm_spawner
// Params 1, eflags: 0x0
// Checksum 0x59cc803, Offset: 0x5d68
// Size: 0x46
function register_zombie_death_event_callback(func) {
    if (!isdefined(level.zombie_death_event_callbacks)) {
        level.zombie_death_event_callbacks = [];
    }
    level.zombie_death_event_callbacks[level.zombie_death_event_callbacks.size] = func;
}

// Namespace zm_spawner/zm_spawner
// Params 1, eflags: 0x0
// Checksum 0x375307c9, Offset: 0x5db8
// Size: 0x3c
function deregister_zombie_death_event_callback(func) {
    if (isdefined(level.zombie_death_event_callbacks)) {
        arrayremovevalue(level.zombie_death_event_callbacks, func);
    }
}

// Namespace zm_spawner/zm_spawner
// Params 0, eflags: 0x0
// Checksum 0x5916fcd3, Offset: 0x5e00
// Size: 0x6e
function attractors_generated_listener() {
    self endon(#"death", #"stop_find_flesh", #"path_timer_done");
    level endon(#"intermission");
    level waittill(#"attractor_positions_generated");
    self.zombie_path_timer = 0;
}

/#

    // Namespace zm_spawner/zm_spawner
    // Params 1, eflags: 0x0
    // Checksum 0x59cf13e5, Offset: 0x5e78
    // Size: 0x5a
    function zombie_history(msg) {
        if (!isdefined(self.zombie_history) || 32 <= self.zombie_history.size) {
            self.zombie_history = [];
        }
        self.zombie_history[self.zombie_history.size] = msg;
    }

#/

// Namespace zm_spawner/zm_spawner
// Params 3, eflags: 0x0
// Checksum 0xe0f636ec, Offset: 0x5ee0
// Size: 0x58
function filter_spawn_points(point, player, player_dir) {
    if (vectordot(point.origin - player.origin, player_dir) > 0) {
        return true;
    }
    return false;
}

// Namespace zm_spawner/zm_spawner
// Params 1, eflags: 0x0
// Checksum 0xcd496283, Offset: 0x5f40
// Size: 0x944
function function_581bd9ee(spots) {
    pixbeginevent(#"hash_40d2624346096cb1");
    players = getplayers();
    var_765453b8 = [];
    foreach (player in players) {
        var_765453b8[player getentitynumber()] = {#player:player, #count:0, #valid:zombie_utility::is_player_valid(player, 1, 1), #zone:player zm_utility::get_current_zone(1)};
    }
    zombies = getaiteamarray(level.zombie_team);
    foreach (zombie in zombies) {
        if (!isalive(zombie)) {
            continue;
        }
        if (!(isdefined(zombie.need_closest_player) && zombie.need_closest_player) && isdefined(zombie.last_closest_player) && zombie_utility::is_player_valid(zombie.last_closest_player, 1, 1)) {
            var_765453b8[zombie.last_closest_player getentitynumber()].count++;
            continue;
        }
        if (isdefined(zombie.completed_emerging_into_playable_area) && zombie.completed_emerging_into_playable_area) {
            zone_name = zombie zm_utility::get_current_zone();
        } else if (isdefined(zombie.spawn_point)) {
            zone_name = zombie.spawn_point.zone_name;
        }
        if (!isdefined(zone_name)) {
            continue;
        }
        foreach (info in var_765453b8) {
            if (!info.valid) {
                continue;
            }
            if (!isdefined(info.zone)) {
                continue;
            }
            if (zone_name == info.zone.name || isinarray(info.zone.adjacent_zones, zone_name)) {
                info.count++;
            }
        }
    }
    var_7c5d5da3 = 2147483647;
    foreach (info in var_765453b8) {
        if (info.valid && info.count < var_7c5d5da3) {
            var_7c5d5da3 = info.count;
            player_info = info;
        }
    }
    a_candidates = [];
    if (isdefined(player_info)) {
        v_player_dir = player_info.player zm_quick_spawning::function_dd6c5a27();
        if (lengthsquared(v_player_dir) > 0) {
            zones = zm_quick_spawning::function_13fedb5(player_info.player, v_player_dir, 1);
            for (i = 0; i < spots.size; i++) {
                if (isdefined(spots[i].spawned_timestamp) && gettime() - spots[i].spawned_timestamp < 3000) {
                    continue;
                }
                if (isdefined(player_info.zone) && spots[i].zone_name == player_info.zone.name) {
                    if (!isdefined(a_candidates)) {
                        a_candidates = [];
                    } else if (!isarray(a_candidates)) {
                        a_candidates = array(a_candidates);
                    }
                    a_candidates[a_candidates.size] = spots[i];
                    continue;
                }
                var_4bafb5e = 0;
                foreach (zone in zones) {
                    if (zone.name == spots[i].zone_name || isinarray(zone.adjacent_zones, spots[i].zone_name)) {
                        if (!isdefined(a_candidates)) {
                            a_candidates = [];
                        } else if (!isarray(a_candidates)) {
                            a_candidates = array(a_candidates);
                        }
                        a_candidates[a_candidates.size] = spots[i];
                        var_4bafb5e = 1;
                        break;
                    }
                }
                if (var_4bafb5e) {
                    continue;
                }
                if (vectordot(spots[i].origin - player_info.player.origin, v_player_dir) > 0) {
                    if (!isdefined(a_candidates)) {
                        a_candidates = [];
                    } else if (!isarray(a_candidates)) {
                        a_candidates = array(a_candidates);
                    }
                    a_candidates[a_candidates.size] = spots[i];
                }
            }
            a_candidates = arraysortclosest(a_candidates, player_info.player.origin);
        }
        /#
            if (getdvarint(#"hash_72ad1fcf80c5738d", -1) > -1 && level.players[getdvarint(#"hash_72ad1fcf80c5738d", -1)] == player_info.player) {
                foreach (index, spot in a_candidates) {
                    record3dtext(index, spot.origin, (0, 1, 0));
                }
            }
        #/
    }
    pixendevent();
    player = undefined;
    if (isdefined(player_info)) {
        player = player_info.player;
    }
    return {#spot:array::random(a_candidates), #player:player};
}

// Namespace zm_spawner/zm_spawner
// Params 0, eflags: 0x0
// Checksum 0x75ffd96e, Offset: 0x6890
// Size: 0x894
function do_zombie_spawn() {
    self endon(#"death");
    spots = [];
    if (isdefined(self._rise_spot)) {
        spot = self._rise_spot;
        self thread do_zombie_rise(spot);
        return;
    }
    if (isdefined(level.use_multiple_spawns) && level.use_multiple_spawns && isdefined(self.script_int)) {
        foreach (loc in level.zm_loc_types[#"zombie_location"]) {
            if (!(isdefined(level.spawner_int) && level.spawner_int == self.script_int) && !(isdefined(loc.script_int) || isdefined(level.zones[loc.zone_name].script_int))) {
                continue;
            }
            if (isdefined(loc.script_int) && loc.script_int != self.script_int) {
                continue;
            } else if (isdefined(level.zones[loc.zone_name].script_int) && level.zones[loc.zone_name].script_int != self.script_int) {
                continue;
            }
            spots[spots.size] = loc;
        }
    } else {
        spots = level.zm_loc_types[#"zombie_location"];
    }
    if (getdvarint(#"scr_zombie_spawn_in_view", 0)) {
        player = getplayers()[0];
        spots = [];
        max_dot = 0;
        look_loc = undefined;
        foreach (loc in level.zm_loc_types[#"zombie_location"]) {
            player_vec = vectornormalize(anglestoforward(player getplayerangles()));
            player_vec_2d = (player_vec[0], player_vec[1], 0);
            player_spawn = vectornormalize(loc.origin - player.origin);
            player_spawn_2d = (player_spawn[0], player_spawn[1], 0);
            dot = vectordot(player_vec_2d, player_spawn_2d);
            dist = distance(loc.origin, player.origin);
            if (dot > 0.707 && dist <= getdvarint(#"scr_zombie_spawn_in_view_dist", 0)) {
                if (dot > max_dot) {
                    look_loc = loc;
                    max_dot = dot;
                }
                /#
                    debugstar(loc.origin, 1000, (1, 1, 1));
                #/
            }
        }
        if (isdefined(look_loc)) {
            spots[spots.size] = look_loc;
            /#
                debugstar(look_loc.origin, 1000, (0, 1, 0));
            #/
        }
        if (spots.size <= 0) {
            spots[spots.size] = level.zm_loc_types[#"zombie_location"][0];
            iprintln("no spawner in view");
        }
    }
    var_a36a6b38 = getdvarint(#"hash_32f24948d4a09f0e", 1);
    if (spots.size == 0) {
        spots = struct::get_array("zombie_spawn_loc");
    }
    assert(spots.size > 0, "<dev string:x16e>");
    if (isdefined(level.zm_custom_spawn_location_selection) && !var_a36a6b38) {
        spot = [[ level.zm_custom_spawn_location_selection ]](spots);
    } else if (var_a36a6b38) {
        spawn_info = function_581bd9ee(spots);
        spot = spawn_info.spot;
        player = spawn_info.player;
    }
    if (!isdefined(spot)) {
        spot = function_224adf58(spots);
        if (!isdefined(spot)) {
            spot = array::random(spots);
        }
    }
    spot.spawned_timestamp = gettime();
    self.spawn_point = spot;
    /#
        if (getdvarint(#"zombiemode_debug_zones", 0)) {
            level.zones[spot.zone_name].total_spawn_count++;
            level.zones[spot.zone_name].round_spawn_count++;
            self.zone_spawned_from = spot.zone_name;
            self thread draw_zone_spawned_from();
        }
    #/
    /#
        if (isdefined(level.toggle_show_spawn_locations) && level.toggle_show_spawn_locations) {
            debugstar(spot.origin, getdvarint(#"scr_spawner_location_time", 0), (0, 1, 0));
            host_player = util::gethostplayer();
            distance = distance(spot.origin, host_player.origin);
            iprintln("<dev string:x187>" + distance / 12 + "<dev string:x19c>");
        }
    #/
    if (isdefined(player) && getdvarint(#"hash_24e49958fe736182", 0) && (isdefined(self.var_be67606) && self.var_be67606 || isdefined(level.var_d307b969) && level.var_d307b969 > 0) && isdefined(level.var_97009e3f)) {
        self thread [[ level.var_97009e3f ]](spot, player);
        return;
    }
    if (isdefined(level.move_spawn_func)) {
        self thread [[ level.move_spawn_func ]](spot);
    }
}

// Namespace zm_spawner/zm_spawner
// Params 2, eflags: 0x0
// Checksum 0xd25d8ac6, Offset: 0x7130
// Size: 0xb8
function function_224adf58(spawn_points, var_f346dd5a = 5000) {
    foreach (point in spawn_points) {
        if (isdefined(point.spawned_timestamp) && gettime() - point.spawned_timestamp > var_f346dd5a) {
            return point;
        }
    }
    return undefined;
}

/#

    // Namespace zm_spawner/zm_spawner
    // Params 0, eflags: 0x0
    // Checksum 0x252041f6, Offset: 0x71f0
    // Size: 0x5e
    function draw_zone_spawned_from() {
        self endon(#"death");
        while (true) {
            print3d(self.origin + (0, 0, 64), self.zone_spawned_from, (1, 1, 1));
            waitframe(1);
        }
    }

#/

// Namespace zm_spawner/zm_spawner
// Params 1, eflags: 0x0
// Checksum 0x358f8704, Offset: 0x7258
// Size: 0x44e
function do_zombie_rise(spot) {
    self endon(#"death");
    self.in_the_ground = 1;
    if (isdefined(self.anchor)) {
        self.anchor delete();
    }
    self.anchor = spawn("script_origin", self.origin);
    self.anchor.angles = self.angles;
    self linkto(self.anchor);
    if (!isdefined(spot.angles)) {
        spot.angles = (0, 0, 0);
    }
    anim_org = spot.origin;
    anim_ang = spot.angles;
    anim_org += (0, 0, 0);
    self ghost();
    self.anchor moveto(anim_org, 0.05);
    self.anchor waittill(#"movedone");
    target_org = zombie_utility::get_desired_origin();
    if (isdefined(target_org)) {
        anim_ang = vectortoangles(target_org - self.origin);
        self.anchor rotateto((0, anim_ang[1], 0), 0.05);
        self.anchor waittill(#"rotatedone");
    }
    self unlink();
    if (isdefined(self.anchor)) {
        self.anchor delete();
    }
    self thread zombie_utility::hide_pop();
    level thread zombie_utility::zombie_rise_death(self, spot);
    spot thread zombie_rise_fx(self);
    substate = 0;
    if (self.zombie_move_speed == "walk") {
        substate = randomint(2);
    } else if (self.zombie_move_speed == "run") {
        substate = 2;
    } else if (self.zombie_move_speed == "sprint") {
        substate = 3;
    }
    self orientmode("face default");
    if (isdefined(level.custom_riseanim)) {
        self animscripted("rise_anim", self.origin, spot.angles, level.custom_riseanim);
    } else if (isdefined(level.var_8a723769)) {
        self [[ level.var_8a723769 ]](spot);
    } else {
        self animscripted("rise_anim", self.origin, spot.angles, "ai_zombie_base_traverse_ground_climbout_fast", "normal");
    }
    self zombie_shared::donotetracks("rise_anim", &zombie_utility::handle_rise_notetracks, spot);
    self notify(#"rise_anim_finished");
    spot notify(#"stop_zombie_rise_fx");
    self.in_the_ground = 0;
    self notify(#"risen", {#find_flesh_struct_string:spot.script_string});
}

// Namespace zm_spawner/zm_spawner
// Params 1, eflags: 0x0
// Checksum 0x1d20070, Offset: 0x76b0
// Size: 0xc6
function zombie_rise_fx(zombie) {
    if (!(isdefined(level.riser_fx_on_client) && level.riser_fx_on_client)) {
        self thread zombie_rise_dust_fx(zombie);
        self thread zombie_rise_burst_fx(zombie);
    } else {
        self thread zombie_rise_burst_fx(zombie);
    }
    zombie endon(#"death");
    self endon(#"stop_zombie_rise_fx");
    wait 1;
    if (zombie.zombie_move_speed != "sprint") {
        wait 1;
    }
}

// Namespace zm_spawner/zm_spawner
// Params 1, eflags: 0x0
// Checksum 0x61d091ae, Offset: 0x7780
// Size: 0x254
function zombie_rise_burst_fx(zombie) {
    self endon(#"stop_zombie_rise_fx", #"rise_anim_finished");
    if (isdefined(self.script_parameters) && self.script_parameters == "in_water" && !(isdefined(level._no_water_risers) && level._no_water_risers)) {
        zombie clientfield::set("zombie_riser_fx_water", 1);
        return;
    }
    if (isdefined(self.script_parameters) && self.script_parameters == "in_foliage" && isdefined(level._foliage_risers) && level._foliage_risers) {
        zombie clientfield::set("zombie_riser_fx_foliage", 1);
        return;
    }
    if (isdefined(self.script_parameters) && self.script_parameters == "in_snow") {
        zombie clientfield::set("zombie_riser_fx", 1);
        return;
    }
    if (isdefined(zombie.zone_name) && isdefined(level.zones[zombie.zone_name])) {
        low_g_zones = getentarray(zombie.zone_name, "targetname");
        if (low_g_zones.size && isdefined(low_g_zones[0].script_string) && low_g_zones[0].script_string == "lowgravity") {
            zombie clientfield::set("zombie_riser_fx_lowg", 1);
        } else {
            zombie clientfield::set("zombie_riser_fx", 1);
        }
        return;
    }
    zombie clientfield::set("zombie_riser_fx", 1);
}

// Namespace zm_spawner/zm_spawner
// Params 1, eflags: 0x0
// Checksum 0xf4b09f6d, Offset: 0x79e0
// Size: 0x160
function zombie_rise_dust_fx(ai_zombie) {
    ai_zombie endon(#"death");
    wait 2;
    if (!isdefined(self.script_string)) {
        str_fx = "rise_dust";
    } else {
        switch (self.script_string) {
        case #"in_water":
            str_fx = "rise_dust_water";
            break;
        case #"in_snow":
            str_fx = "rise_dust_snow";
            break;
        case #"in_foliage":
            str_fx = "rise_dust_foliage";
            break;
        default:
            str_fx = "rise_dust";
            break;
        }
    }
    for (t = 0; t < 5.5; t += 0.3) {
        playfxontag(level._effect[str_fx], ai_zombie, "J_SpineUpper");
        wait 0.3;
    }
}

// Namespace zm_spawner/zm_spawner
// Params 0, eflags: 0x0
// Checksum 0xa58f6c19, Offset: 0x7b48
// Size: 0xdc
function zombie_tesla_head_gib() {
    self endon(#"death");
    if (self.animname === "quad_zombie") {
        return;
    }
    if (randomint(100) < zombie_utility::get_zombie_var(#"tesla_head_gib_chance")) {
        wait randomfloatrange(0.53, 1);
        self zombie_utility::zombie_head_gib();
        return;
    }
    zm_net::network_safe_play_fx_on_tag("tesla_death_fx", 2, level._effect[#"tesla_shock_eyes"], self, "J_Eyeball_LE");
}

// Namespace zm_spawner/zm_spawner
// Params 0, eflags: 0x0
// Checksum 0x5fd72604, Offset: 0x7c30
// Size: 0x1ec
function zombie_complete_emerging_into_playable_area() {
    self.should_turn = 0;
    self.completed_emerging_into_playable_area = 1;
    self.no_powerups = 0;
    self notify(#"completed_emerging_into_playable_area");
    if (isdefined(self.backedupgoal)) {
        self setgoal(self.backedupgoal);
        self.backedupgoal = undefined;
    } else {
        self.var_532a149b = zm_utility::get_closest_valid_player(self.origin, self.ignore_player, 1);
        if (isdefined(self.var_532a149b) && (!ai::has_behavior_attribute("scripted_mode") || ai::get_behavior_attribute("scripted_mode") !== 1)) {
            if (isdefined(self.var_532a149b.last_valid_position)) {
                self setgoal(self.var_532a149b.last_valid_position);
            } else {
                goalpos = getclosestpointonnavmesh(self.var_532a149b.origin, 100, self getpathfindingradius());
                if (!isdefined(goalpos)) {
                    goalpos = self.origin;
                }
                self setgoal(goalpos);
            }
        } else {
            self setgoal(self.origin);
        }
    }
    self thread function_9bb07fc5();
    self thread zm_utility::update_zone_name();
}

// Namespace zm_spawner/zm_spawner
// Params 0, eflags: 0x0
// Checksum 0x3edc2c08, Offset: 0x7e28
// Size: 0x54
function function_9bb07fc5() {
    self endon(#"death");
    self collidewithactors(1);
    wait 1.5;
    self setfreecameralockonallowed(1);
}

// Namespace zm_spawner/zm_spawner
// Params 1, eflags: 0x0
// Checksum 0x2f919c04, Offset: 0x7e88
// Size: 0x23c
function function_48cfc7df(spot) {
    self endoncallback(&function_91178273, #"death");
    self.var_2be9fa75 = 1;
    self function_91178273();
    self.mdl_anchor = util::spawn_model("tag_origin", self.origin, self.angles);
    self ghost();
    if (!isdefined(spot.angles)) {
        spot.angles = (0, 0, 0);
    }
    self.mdl_anchor moveto(spot.origin, 0.05);
    self.mdl_anchor rotateto(spot.angles, 0.05);
    self.mdl_anchor waittill(#"movedone");
    wait 0.05;
    self.create_eyes = 1;
    self show();
    if (!isdefined(self.var_f3f83845)) {
        self.var_f3f83845 = self function_effb2fc();
    }
    self pushplayer(1);
    self.mdl_anchor scene::play(spot.scriptbundlename, self);
    if (isdefined(self.var_f3f83845)) {
        self pushplayer(self.var_f3f83845);
        self.var_f3f83845 = undefined;
    }
    self.var_2be9fa75 = 0;
    self thread function_a2fbf756();
    self notify(#"risen", spot.script_string);
    self zombie_complete_emerging_into_playable_area();
}

// Namespace zm_spawner/zm_spawner
// Params 0, eflags: 0x0
// Checksum 0x7b6830bb, Offset: 0x80d0
// Size: 0x3c
function function_a2fbf756() {
    waitresult = self waittilltimeout(1, #"death");
    self function_91178273();
}

// Namespace zm_spawner/zm_spawner
// Params 1, eflags: 0x0
// Checksum 0x86bcfcc8, Offset: 0x8118
// Size: 0x3e
function function_91178273(notifyhash) {
    if (isdefined(self.mdl_anchor)) {
        self.mdl_anchor delete();
        self.mdl_anchor = undefined;
    }
}

