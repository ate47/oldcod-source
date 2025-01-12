#using scripts/core_common/array_shared;
#using scripts/core_common/callbacks_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/flag_shared;
#using scripts/core_common/flagsys_shared;
#using scripts/core_common/gameobjects_shared;
#using scripts/core_common/influencers_shared;
#using scripts/core_common/math_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;
#using scripts/core_common/weapons/tacticalinsertion;

#namespace spawning;

// Namespace spawning/spawning_shared
// Params 0, eflags: 0x2
// Checksum 0x623c8fa8, Offset: 0x490
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("spawning_shared", &__init__, undefined, undefined);
}

// Namespace spawning/spawning_shared
// Params 0, eflags: 0x0
// Checksum 0x7ab97a8e, Offset: 0x4d0
// Size: 0x37c
function __init__() {
    level init_spawn_system();
    level.spawnprotectiontime = getgametypesetting("spawnprotectiontime");
    level.spawnprotectiontimems = int((isdefined(level.spawnprotectiontime) ? level.spawnprotectiontime : 0) * 1000);
    level.spawntraptriggertime = getgametypesetting("spawntraptriggertime");
    level.players = [];
    level.numplayerswaitingtoenterkillcam = 0;
    if (!isdefined(level.requirespawnpointstoexistinlevel)) {
        level.requirespawnpointstoexistinlevel = 1;
    }
    level.convert_spawns_to_structs = getdvarint("spawnsystem_convert_spawns_to_structs");
    /#
        println("<dev string:x28>");
    #/
    level.spawnmins = (0, 0, 0);
    level.spawnmaxs = (0, 0, 0);
    level.spawnminsmaxsprimed = 0;
    level.default_spawn_lists = [];
    if (!isdefined(level.default_spawn_lists)) {
        level.default_spawn_lists = [];
    } else if (!isarray(level.default_spawn_lists)) {
        level.default_spawn_lists = array(level.default_spawn_lists);
    }
    level.default_spawn_lists[level.default_spawn_lists.size] = "normal";
    foreach (team in level.teams) {
        level.teamspawnpoints[team] = [];
        level.spawn_point_team_class_names[team] = [];
    }
    callback::on_spawned(&on_player_spawned);
    callback::on_laststand(&on_player_laststand);
    callback::on_revived(&on_player_revived);
    callback::on_player_killed(&on_player_killed);
    level thread update_spawn_points();
    level thread update_explored_spawn_points();
    /#
        level.spawnpoint_triggers = [];
        level thread spawnpoint_debug();
    #/
}

// Namespace spawning/spawning_shared
// Params 1, eflags: 0x0
// Checksum 0x13ba2fdf, Offset: 0x858
// Size: 0x96
function add_default_spawnlist(spawnlist) {
    if (!isdefined(level.default_spawn_lists)) {
        level.default_spawn_lists = [];
    } else if (!isarray(level.default_spawn_lists)) {
        level.default_spawn_lists = array(level.default_spawn_lists);
    }
    level.default_spawn_lists[level.default_spawn_lists.size] = spawnlist;
}

// Namespace spawning/spawning_shared
// Params 0, eflags: 0x0
// Checksum 0x1b3714fc, Offset: 0x8f8
// Size: 0x64
function on_player_spawned() {
    if (!self flag::exists("spawn_exploration_active")) {
        self flag::init("spawn_exploration_active", 1);
    }
    self flag::set("spawn_exploration_active");
}

// Namespace spawning/spawning_shared
// Params 0, eflags: 0x0
// Checksum 0x970622a5, Offset: 0x968
// Size: 0x44
function on_player_laststand() {
    if (self flag::exists("spawn_exploration_active")) {
        self flag::clear("spawn_exploration_active");
    }
}

// Namespace spawning/spawning_shared
// Params 0, eflags: 0x0
// Checksum 0x153d03c8, Offset: 0x9b8
// Size: 0x44
function on_player_revived() {
    if (self flag::exists("spawn_exploration_active")) {
        self flag::set("spawn_exploration_active");
    }
}

// Namespace spawning/spawning_shared
// Params 0, eflags: 0x0
// Checksum 0x7fd2d4b7, Offset: 0xa08
// Size: 0x44
function on_player_killed() {
    if (self flag::exists("spawn_exploration_active")) {
        self flag::clear("spawn_exploration_active");
    }
}

// Namespace spawning/spawning_shared
// Params 0, eflags: 0x4
// Checksum 0xccd66d0d, Offset: 0xa58
// Size: 0x1be
function private init_spawn_system() {
    level.spawnsystem = spawnstruct();
    spawnsystem = level.spawnsystem;
    if (!isdefined(spawnsystem.var_23df778)) {
        spawnsystem.var_23df778 = 1;
    }
    spawnsystem.objective_facing_bonus = 0;
    spawnsystem.ispawn_teammask = [];
    spawnsystem.ispawn_teammask_free = 1;
    spawnsystem.ispawn_teammask["free"] = spawnsystem.ispawn_teammask_free;
    all = spawnsystem.ispawn_teammask_free;
    count = 1;
    foreach (team in level.teams) {
        spawnsystem.ispawn_teammask[team] = 1 << count;
        all |= spawnsystem.ispawn_teammask[team];
        count++;
    }
    spawnsystem.ispawn_teammask["all"] = all;
}

// Namespace spawning/spawning_shared
// Params 0, eflags: 0x0
// Checksum 0xf96382cc, Offset: 0xc20
// Size: 0x1d2
function updateallspawnpoints() {
    clearspawnpoints("normal");
    if (level.teambased) {
        foreach (team in level.teams) {
            addspawnpoints(team, level.teamspawnpoints[team], "normal");
            enablespawnpointlist("normal", util::getteammask(team));
        }
        return;
    }
    foreach (team in level.teams) {
        addspawnpoints("free", level.teamspawnpoints[team], "normal");
        enablespawnpointlist("normal", util::getteammask(team));
    }
}

// Namespace spawning/spawning_shared
// Params 0, eflags: 0x0
// Checksum 0x82639aa1, Offset: 0xe00
// Size: 0x182
function update_fallback_spawnpoints() {
    clearspawnpoints("fallback");
    if (!isdefined(level.player_fallback_points)) {
        return;
    }
    if (level.teambased) {
        foreach (team in level.teams) {
            addspawnpoints(team, level.player_fallback_points[team], "fallback");
        }
        return;
    }
    foreach (team in level.teams) {
        addspawnpoints("free", level.player_fallback_points[team], "fallback");
    }
}

// Namespace spawning/spawning_shared
// Params 2, eflags: 0x0
// Checksum 0x8c68b401, Offset: 0xf90
// Size: 0x1bc
function add_fallback_spawnpoints(team, point_class) {
    if (!isdefined(level.player_fallback_points)) {
        level.player_fallback_points = [];
        foreach (level_team in level.teams) {
            level.player_fallback_points[level_team] = [];
        }
    }
    add_spawn_point_classname(point_class);
    spawnpoints = get_spawnpoint_array(point_class);
    for (i = spawnpoints.size - 1; i >= 0; i--) {
        if (!gameobjects::entity_is_allowed(spawnpoints[i], level.allowedgameobjects)) {
            spawnpoints[i] = undefined;
        }
    }
    arrayremovevalue(spawnpoints, undefined);
    level.player_fallback_points[team] = spawnpoints;
    enablespawnpointlist("fallback", util::getteammask(team));
}

// Namespace spawning/spawning_shared
// Params 2, eflags: 0x0
// Checksum 0xcf0fd285, Offset: 0x1158
// Size: 0x166
function add_start_spawn_points(str_team, classname) {
    str_team = util::get_team_mapping(str_team);
    if (!isdefined(level.spawn_start)) {
        level.spawn_start = [];
    }
    if (!isdefined(level.spawn_start[str_team])) {
        level.spawn_start[str_team] = [];
    }
    spawnpoints = get_spawnpoint_array(classname);
    if (isdefined(level.var_75ff7f7a)) {
        if (isdefined(level.var_75ff7f7a.obj)) {
            spawnpoints = level.var_75ff7f7a.obj [[ level.var_75ff7f7a.func ]](spawnpoints);
        } else {
            spawnpoints = [[ level.var_75ff7f7a.func ]](spawnpoints);
        }
    }
    level.spawn_start[str_team] = arraycombine(level.spawn_start[str_team], spawnpoints, 0, 0);
}

// Namespace spawning/spawning_shared
// Params 1, eflags: 0x4
// Checksum 0x6c5b1640, Offset: 0x12c8
// Size: 0xba
function private is_spawn_trapped(team) {
    /#
        level.spawntraptriggertime = getgametypesetting("<dev string:x5c>");
    #/
    if (!level.rankedmatch) {
        return false;
    }
    if (isdefined(level.alivetimesaverage) && isdefined(level.alivetimesaverage[team]) && level.alivetimesaverage[team] != 0 && level.alivetimesaverage[team] < level.spawntraptriggertime * 1000) {
        return true;
    }
    return false;
}

// Namespace spawning/spawning_shared
// Params 1, eflags: 0x4
// Checksum 0x2829d3bb, Offset: 0x1390
// Size: 0x148
function private use_start_spawns(predictedspawn) {
    if (isdefined(level.alwaysusestartspawns) && level.alwaysusestartspawns) {
        return true;
    }
    if (!(isdefined(level.usestartspawns) && level.usestartspawns)) {
        return false;
    }
    if (level.teambased) {
        spawnteam = self.pers["team"];
        if (level.aliveplayers[spawnteam].size + level.spawningplayers[self.team].size >= level.spawn_start[spawnteam].size) {
            if (!predictedspawn) {
                level.usestartspawns = 0;
            }
            return false;
        }
    } else if (level.aliveplayers["free"].size + level.spawningplayers["free"].size >= level.spawn_start.size) {
        if (!predictedspawn) {
            level.usestartspawns = 0;
        }
        return false;
    }
    return true;
}

// Namespace spawning/spawning_shared
// Params 1, eflags: 0x0
// Checksum 0xa8876fab, Offset: 0x14e0
// Size: 0x434
function onspawnplayer(predictedspawn) {
    if (!isdefined(predictedspawn)) {
        predictedspawn = 0;
    }
    spawnoverride = self tacticalinsertion::overridespawn(predictedspawn);
    spawnresurrect = 0;
    if (isdefined(level.resurrect_override_spawn)) {
        spawnresurrect = self [[ level.resurrect_override_spawn ]](predictedspawn);
    }
    /#
        if (isdefined(self.devguilockspawn) && self.devguilockspawn) {
            spawnresurrect = 1;
        }
    #/
    spawn_origin = undefined;
    spawn_angles = undefined;
    if (spawnresurrect) {
        spawn_origin = self.resurrect_origin;
        spawn_angles = self.resurrect_angles;
    } else if (spawnoverride) {
        if (predictedspawn && isdefined(self.tacticalinsertion)) {
            self predictspawnpoint(self.tacticalinsertion.origin, self.tacticalinsertion.angles);
        }
        return;
    } else if (self use_start_spawns(predictedspawn)) {
        if (!predictedspawn) {
            if (level.teambased) {
                array::add(level.spawningplayers[self.team], self);
            } else {
                array::add(level.spawningplayers["free"], self);
            }
        }
        if (level.teambased) {
            spawnteam = self.pers["team"];
            if (game.switchedsides && level.spawnsystem.var_23df778) {
                spawnteam = util::getotherteam(spawnteam);
            }
            spawnpoint = get_spawnpoint_random(level.spawn_start[spawnteam], predictedspawn);
        } else {
            spawnpoint = get_spawnpoint_random(level.spawn_start, predictedspawn);
        }
        if (isdefined(spawnpoint)) {
            spawn_origin = spawnpoint.origin;
            spawn_angles = spawnpoint.angles;
        }
    } else {
        spawn_point = getspawnpoint(self, predictedspawn);
        if (isdefined(spawn_point)) {
            spawn_origin = spawn_point["origin"];
            spawn_angles = spawn_point["angles"];
        }
    }
    if (!isdefined(spawn_origin)) {
        /#
            println("<dev string:x71>");
        #/
        callback::abort_level();
    }
    if (predictedspawn) {
        self predictspawnpoint(spawn_origin, spawn_angles);
        return;
    }
    self spawn(spawn_origin, spawn_angles);
    self.lastspawntime = gettime();
    if (!flag::exists("spawn_exploration_active")) {
        self flag::init("spawn_exploration_active", 1);
    }
    if (!spawnresurrect && !spawnoverride) {
        influencers::create_player_spawn_influencers(spawn_origin);
    }
}

// Namespace spawning/spawning_shared
// Params 2, eflags: 0x4
// Checksum 0x72c804fe, Offset: 0x1920
// Size: 0x1a0
function private getspawnpoint(player_entity, predictedspawn) {
    if (!isdefined(predictedspawn)) {
        predictedspawn = 0;
    }
    if (level.teambased) {
        point_team = player_entity.pers["team"];
        influencer_team = player_entity.pers["team"];
    } else {
        point_team = "free";
        influencer_team = "free";
    }
    if (level.teambased && isdefined(game.switchedsides) && game.switchedsides && level.spawnsystem.var_23df778) {
        point_team = util::getotherteam(point_team);
    }
    use_fallback_points = 0;
    spawn_trapped = is_spawn_trapped(point_team);
    if (spawn_trapped) {
        use_fallback_points = 1;
    }
    best_spawn = get_best_spawnpoint(point_team, influencer_team, player_entity, predictedspawn, use_fallback_points);
    if (!predictedspawn) {
        player_entity.last_spawn_origin = best_spawn["origin"];
    }
    return best_spawn;
}

// Namespace spawning/spawning_shared
// Params 5, eflags: 0x4
// Checksum 0xbe22725a, Offset: 0x1ac8
// Size: 0x280
function private get_best_spawnpoint(point_team, influencer_team, player, predictedspawn, use_fallback_points) {
    if (level.teambased) {
        vis_team_mask = util::getotherteamsmask(player.pers["team"]);
    } else {
        vis_team_mask = level.spawnsystem.ispawn_teammask["all"];
    }
    lists = [];
    foreach (spawnlist in level.default_spawn_lists) {
        if (!isdefined(lists)) {
            lists = [];
        } else if (!isarray(lists)) {
            lists = array(lists);
        }
        lists[lists.size] = spawnlist;
    }
    if (use_fallback_points) {
        if (!isdefined(lists)) {
            lists = [];
        } else if (!isarray(lists)) {
            lists = array(lists);
        }
        lists[lists.size] = "fallback";
    }
    if (isdefined(level.var_bef1a9a4)) {
        player [[ level.var_bef1a9a4 ]](lists);
    }
    spawn_point = getbestspawnpoint(point_team, influencer_team, vis_team_mask, player, predictedspawn, lists);
    if (!predictedspawn) {
        bbprint("mpspawnpointsused", "reason %s x %d y %d z %d", "point used", spawn_point["origin"]);
    }
    return spawn_point;
}

// Namespace spawning/spawning_shared
// Params 1, eflags: 0x4
// Checksum 0xfa388566, Offset: 0x1d50
// Size: 0x4e
function private spawn_point_class_name_being_used(name) {
    if (!isdefined(level.spawn_point_class_names)) {
        return false;
    }
    if (isinarray(level.spawn_point_class_names, name)) {
        return true;
    }
    return false;
}

// Namespace spawning/spawnpoints_update
// Params 1, eflags: 0x40
// Checksum 0xbece176b, Offset: 0x1da8
// Size: 0xac
function event_handler[spawnpoints_update] codecallback_updatespawnpoints(eventstruct) {
    foreach (team in level.teams) {
        rebuild_spawn_points(team);
    }
    updateallspawnpoints();
}

// Namespace spawning/spawning_shared
// Params 2, eflags: 0x0
// Checksum 0x871bb92d, Offset: 0x1e60
// Size: 0x60
function function_ce88d07a(filter_func, obj) {
    level.var_75ff7f7a = spawnstruct();
    level.var_75ff7f7a.func = filter_func;
    level.var_75ff7f7a.obj = obj;
}

// Namespace spawning/spawning_shared
// Params 0, eflags: 0x0
// Checksum 0x7be17824, Offset: 0x1ec8
// Size: 0xe
function function_1787a0e() {
    level.var_75ff7f7a = undefined;
}

// Namespace spawning/spawning_shared
// Params 3, eflags: 0x4
// Checksum 0xb58f46b7, Offset: 0x1ee0
// Size: 0x426
function private add_spawn_points_internal(team, spawnpoints, list) {
    if (!isdefined(list)) {
        list = 0;
    }
    if (isdefined(level.var_75ff7f7a)) {
        if (isdefined(level.var_75ff7f7a.obj)) {
            filteredspawnpoints = level.var_75ff7f7a.obj [[ level.var_75ff7f7a.func ]](spawnpoints);
        } else {
            filteredspawnpoints = [[ level.var_75ff7f7a.func ]](spawnpoints);
        }
        foreach (spawnpoint in spawnpoints) {
            if (isinarray(filteredspawnpoints, spawnpoint)) {
                spawnpoint.filter_enabled = 1;
                spawnpoint function_7d02437f();
                continue;
            }
            spawnpoint.filter_enabled = 0;
            spawnpoint function_7d02437f();
        }
        if (getdvarint("spawnsystem_use_code_point_enabled") == 0) {
            spawnpoints = filteredspawnpoints;
        }
    }
    oldspawnpoints = [];
    if (level.teamspawnpoints[team].size) {
        oldspawnpoints = level.teamspawnpoints[team];
    }
    for (i = spawnpoints.size - 1; i >= 0; i--) {
        if (!gameobjects::entity_is_allowed(spawnpoints[i], level.allowedgameobjects)) {
            spawnpoints[i] = undefined;
        }
    }
    arrayremovevalue(spawnpoints, undefined);
    level.teamspawnpoints[team] = spawnpoints;
    if (!isdefined(level.spawnpoints)) {
        level.spawnpoints = [];
    }
    for (index = 0; index < level.teamspawnpoints[team].size; index++) {
        spawnpoint = level.teamspawnpoints[team][index];
        if (!isdefined(spawnpoint.inited)) {
            spawnpoint spawnpoint_init();
        }
        array::add(level.spawnpoints, spawnpoint, 0);
    }
    for (index = 0; index < oldspawnpoints.size; index++) {
        origin = oldspawnpoints[index].origin;
        level.spawnmins = math::expand_mins(level.spawnmins, origin);
        level.spawnmaxs = math::expand_maxs(level.spawnmaxs, origin);
        array::add(level.teamspawnpoints[team], oldspawnpoints[index]);
    }
}

// Namespace spawning/spawning_shared
// Params 3, eflags: 0x20 variadic
// Checksum 0x6ec39f2, Offset: 0x2310
// Size: 0x250
function clear_and_add_spawn_points(str_team, classnames, ...) {
    str_team = util::get_team_mapping(str_team);
    /#
        assert(vararg.size % 2 == 0, "<dev string:xa9>");
    #/
    clear_spawn_points();
    team_array = array(str_team);
    classnames_array = array(classnames);
    for (index = 0; index < vararg.size; index++) {
        if (index % 2 == 0) {
            if (!isdefined(team_array)) {
                team_array = [];
            } else if (!isarray(team_array)) {
                team_array = array(team_array);
            }
            team_array[team_array.size] = util::get_team_mapping(vararg[index]);
            continue;
        }
        if (!isdefined(classnames_array)) {
            classnames_array = [];
        } else if (!isarray(classnames_array)) {
            classnames_array = array(classnames_array);
        }
        classnames_array[classnames_array.size] = vararg[index];
    }
    for (team_index = 0; team_index < team_array.size; team_index++) {
        for (classname_index = 0; classname_index < classnames_array[team_index].size; classname_index++) {
            add_spawn_points(team_array[team_index], classnames_array[team_index][classname_index]);
        }
    }
}

// Namespace spawning/spawning_shared
// Params 0, eflags: 0x0
// Checksum 0x963d5195, Offset: 0x2568
// Size: 0xc4
function clear_spawn_points() {
    foreach (team in level.teams) {
        level.teamspawnpoints[team] = [];
        level.spawn_start[team] = [];
        level.spawn_point_team_class_names[team] = [];
    }
    level.spawnpoints = [];
}

// Namespace spawning/spawning_shared
// Params 0, eflags: 0x4
// Checksum 0x38ea3ad9, Offset: 0x2638
// Size: 0xf6
function private update_spawn_points() {
    while (true) {
        level flagsys::wait_till("spawnpoints_dirty");
        foreach (team in level.teams) {
            rebuild_spawn_points(team);
        }
        updateallspawnpoints();
        level flagsys::clear("spawnpoints_dirty");
        waitframe(1);
    }
}

// Namespace spawning/spawning_shared
// Params 0, eflags: 0x4
// Checksum 0x3320ab9a, Offset: 0x2738
// Size: 0x112
function private update_explored_spawn_points() {
    level flagsys::wait_till("spawn_point_exploration_enabled");
    explored_radius = getdvarfloat("spawnsystem_player_explored_radius");
    explored_radius_sq = explored_radius * explored_radius;
    foreach (team in level.teams) {
        level thread update_explored_start_spawn_points_for_team(team);
        level thread update_explored_spawn_points_for_team(team, explored_radius_sq);
    }
}

// Namespace spawning/spawning_shared
// Params 1, eflags: 0x4
// Checksum 0xe67de597, Offset: 0x2858
// Size: 0x254
function private update_explored_start_spawn_points_for_team(team) {
    level notify("update_explored_start_spawn_points_for_team" + team);
    level endon("update_explored_start_spawn_points_for_team" + team);
    while (true) {
        if (!isdefined(level.spawn_start[team])) {
            wait 0.5;
            continue;
        }
        players = getplayers();
        allplayersspawned = 0;
        if (players.size >= getdvarint("com_maxclients")) {
            allplayersspawned = 1;
        }
        foreach (spawnpoint in level.spawn_start[team]) {
            if (!isdefined(spawnpoint.explored)) {
                spawnpoint.explored = 0;
            }
            foreach (player in players) {
                if (!isdefined(player)) {
                    continue;
                }
                if (player.team === team) {
                    set_player_explored_spawn_point(spawnpoint, player);
                    continue;
                }
                clear_spawn_point_explored_for_player(spawnpoint, player);
            }
            spawn_exploration_wait_for_one_frame();
        }
        if (allplayersspawned) {
            break;
        }
        wait 0.5;
    }
}

// Namespace spawning/spawning_shared
// Params 2, eflags: 0x4
// Checksum 0x5aa68baf, Offset: 0x2ab8
// Size: 0x284
function private update_explored_spawn_points_for_team(team, explored_radius_sq) {
    level notify("update_explored_spawn_points_for_team" + team);
    level endon("update_explored_spawn_points_for_team" + team);
    while (true) {
        if (!isdefined(level.teamspawnpoints[team])) {
            wait 1;
            continue;
        }
        players = getplayers();
        foreach (spawnpoint in level.teamspawnpoints[team]) {
            if (!isdefined(spawnpoint.explored)) {
                spawnpoint.explored = 0;
            }
            foreach (player in players) {
                if (!isdefined(player)) {
                    continue;
                }
                if (player util::function_4f5dd9d2()) {
                    continue;
                }
                if (!should_update_exploration_for_player(spawnpoint, player)) {
                    continue;
                }
                if (abs(player.origin[2] - spawnpoint.origin[2]) < 100 && distancesquared(spawnpoint.origin, player.origin) <= explored_radius_sq) {
                    set_player_explored_spawn_point(spawnpoint, player);
                }
            }
            spawn_exploration_wait_for_one_frame();
        }
        wait 1;
    }
}

// Namespace spawning/spawning_shared
// Params 2, eflags: 0x4
// Checksum 0x4ae19bd1, Offset: 0x2d48
// Size: 0xae
function private should_update_exploration_for_player(spawnpoint, player) {
    if (!player flag::exists("spawn_exploration_active")) {
        return false;
    }
    if (!player flag::get("spawn_exploration_active") || player isplayinganimscripted() || player.sessionstate != "playing") {
        return false;
    }
    if (has_player_explored_spawn_point(spawnpoint, player)) {
        return false;
    }
    return true;
}

// Namespace spawning/spawning_shared
// Params 0, eflags: 0x0
// Checksum 0xebaac05, Offset: 0x2e00
// Size: 0xa
function spawn_exploration_wait_for_one_frame() {
    waitframe(1);
}

// Namespace spawning/spawning_shared
// Params 2, eflags: 0x4
// Checksum 0x779db2, Offset: 0x2e18
// Size: 0x3e
function private has_player_explored_spawn_point(spawnpoint, player) {
    return spawnpoint.explored & 1 << player getentitynumber();
}

// Namespace spawning/spawning_shared
// Params 2, eflags: 0x4
// Checksum 0x50fe5d76, Offset: 0x2e60
// Size: 0xa4
function private set_player_explored_spawn_point(spawnpoint, player) {
    spawnpoint.explored |= 1 << player getentitynumber();
    if (isdefined(player.companion)) {
        spawnpoint.explored |= 1 << player.companion getentitynumber();
    }
}

// Namespace spawning/spawning_shared
// Params 0, eflags: 0x0
// Checksum 0x2799a21b, Offset: 0x2f10
// Size: 0x104
function clear_all_spawn_point_explored() {
    foreach (team in level.teams) {
        foreach (spawnpoint in level.teamspawnpoints[team]) {
            spawnpoint.explored = 0;
        }
    }
}

// Namespace spawning/spawning_shared
// Params 2, eflags: 0x0
// Checksum 0x99631d4, Offset: 0x3020
// Size: 0xc0
function clear_spawn_point_explored_for_player(spawnpoint, player) {
    if (isdefined(spawnpoint.explored)) {
        spawnpoint.explored &= ~(1 << player getentitynumber());
    }
    if (isdefined(player.companion)) {
        spawnpoint.explored &= ~(1 << player.companion getentitynumber());
    }
}

// Namespace spawning/spawning_shared
// Params 0, eflags: 0x0
// Checksum 0xe9f615e0, Offset: 0x30e8
// Size: 0x24
function enable_spawn_point_exploration() {
    level flagsys::set("spawn_point_exploration_enabled");
}

// Namespace spawning/spawning_shared
// Params 1, eflags: 0x0
// Checksum 0xa50c1793, Offset: 0x3118
// Size: 0x64
function disable_spawn_point_exploration(clear) {
    if (!isdefined(clear)) {
        clear = 1;
    }
    level flagsys::clear("spawn_point_exploration_enabled");
    if (isdefined(clear) && clear) {
        clear_all_spawn_point_explored();
    }
}

// Namespace spawning/spawning_shared
// Params 1, eflags: 0x0
// Checksum 0x16ab46c8, Offset: 0x3188
// Size: 0x2c
function set_spawn_point_exploration_radius(radius) {
    setdvar("spawnsystem_player_explored_radius", radius);
}

// Namespace spawning/spawning_shared
// Params 2, eflags: 0x0
// Checksum 0x8fc78c68, Offset: 0x31c0
// Size: 0xd4
function add_spawn_points(team, spawnpointname) {
    add_spawn_point_classname(spawnpointname);
    add_spawn_point_team_classname(team, spawnpointname);
    enabled_spawn_points = setup_trigger_enabled_spawn_points(get_spawnpoint_array(spawnpointname, 1));
    enabled_spawn_points = remove_disabled_on_start_spawn_points(enabled_spawn_points);
    add_spawn_points_internal(team, enabled_spawn_points);
    level flagsys::set("spawnpoints_dirty");
}

// Namespace spawning/spawning_shared
// Params 1, eflags: 0x4
// Checksum 0xaed8cb7f, Offset: 0x32a0
// Size: 0x194
function private remove_disabled_on_start_spawn_points(spawn_points) {
    disable_spawn_points = [];
    foreach (spawn_point in spawn_points) {
        if (isdefined(spawn_point.script_start_disabled) && spawn_point.script_start_disabled) {
            if (getdvarint("spawnsystem_use_code_point_enabled") == 0) {
                spawn_point.disabled = 1;
                if (!isdefined(disable_spawn_points)) {
                    disable_spawn_points = [];
                } else if (!isarray(disable_spawn_points)) {
                    disable_spawn_points = array(disable_spawn_points);
                }
                disable_spawn_points[disable_spawn_points.size] = spawn_point;
            }
            spawn_point.trigger_enabled = 0;
            spawn_point function_7d02437f();
        }
    }
    enabled_spawn_points = array::exclude(spawn_points, disable_spawn_points);
    return enabled_spawn_points;
}

// Namespace spawning/spawning_shared
// Params 1, eflags: 0x4
// Checksum 0x5adfc1b9, Offset: 0x3440
// Size: 0x3b4
function private setup_trigger_enabled_spawn_points(spawn_points) {
    enabled_spawn_points = [];
    foreach (spawn_point in spawn_points) {
        if (isdefined(spawn_point.script_spawn_disable)) {
            triggers = getentarray(spawn_point.script_spawn_disable, "script_spawn_disable", 1);
            foreach (trig in triggers) {
                if (!isdefined(trig.spawn_points_to_disable)) {
                    trig.spawnpoints_enabled = 1;
                    trig.spawn_points_to_disable = [];
                    trig thread _disable_spawn_points();
                }
                array::add(trig.spawn_points_to_disable, spawn_point, 0);
                spawn_point.disabled = undefined;
                /#
                    array::add(level.spawnpoint_triggers, trig, 0);
                #/
            }
        }
        if (isdefined(spawn_point.script_spawn_enable)) {
            triggers = getentarray(spawn_point.script_spawn_enable, "script_spawn_enable", 1);
            foreach (trig in triggers) {
                if (!isdefined(trig.spawn_points_to_enable)) {
                    trig.spawnpoints_enabled = undefined;
                    trig.spawn_points_to_enable = [];
                    trig thread _enable_spawn_points();
                }
                array::add(trig.spawn_points_to_enable, spawn_point, 0);
                /#
                    array::add(level.spawnpoint_triggers, trig, 0);
                #/
            }
        }
        if (!(isdefined(spawn_point.disabled) && spawn_point.disabled)) {
            if (!isdefined(enabled_spawn_points)) {
                enabled_spawn_points = [];
            } else if (!isarray(enabled_spawn_points)) {
                enabled_spawn_points = array(enabled_spawn_points);
            }
            enabled_spawn_points[enabled_spawn_points.size] = spawn_point;
        }
    }
    return enabled_spawn_points;
}

// Namespace spawning/spawning_shared
// Params 0, eflags: 0x4
// Checksum 0xf6f2e217, Offset: 0x3800
// Size: 0x156
function private _disable_spawn_points() {
    self endon(#"death");
    self notify(#"end_disable_spawn_points");
    self endon(#"end_disable_spawn_points");
    while (true) {
        waitresult = self waittill("trigger");
        self.spawnpoints_enabled = undefined;
        foreach (spawn_point in self.spawn_points_to_disable) {
            if (spawn_point.disabled !== 1 && getdvarint("spawnsystem_use_code_point_enabled") == 0) {
                level flagsys::set("spawnpoints_dirty");
            }
            spawn_point.disabled = 1;
            spawn_point.trigger_enabled = 0;
            spawn_point function_7d02437f();
        }
    }
}

// Namespace spawning/spawning_shared
// Params 0, eflags: 0x4
// Checksum 0x3ea6450c, Offset: 0x3960
// Size: 0x166
function private _enable_spawn_points() {
    self endon(#"death");
    self notify(#"end_enable_spawn_points");
    self endon(#"end_enable_spawn_points");
    while (true) {
        waitresult = self waittill("trigger");
        self.spawnpoints_enabled = 1;
        foreach (spawn_point in self.spawn_points_to_enable) {
            if (isdefined(spawn_point.disabled) && spawn_point.disabled && getdvarint("spawnsystem_use_code_point_enabled") == 0) {
                level flagsys::set("spawnpoints_dirty");
            }
            spawn_point.disabled = undefined;
            spawn_point.trigger_enabled = 1;
            spawn_point function_7d02437f();
        }
    }
}

// Namespace spawning/spawning_shared
// Params 0, eflags: 0x4
// Checksum 0x94df1535, Offset: 0x3ad0
// Size: 0x74
function private function_7d02437f() {
    self.enabled = 1;
    self.enabled = !isdefined(self.trigger_enabled) || self.enabled && self.trigger_enabled;
    self.enabled = !isdefined(self.filter_enabled) || self.enabled && self.filter_enabled;
}

// Namespace spawning/spawning_shared
// Params 1, eflags: 0x4
// Checksum 0xe9f028ca, Offset: 0x3b50
// Size: 0x96
function private rebuild_spawn_points(team) {
    level.teamspawnpoints[team] = [];
    for (index = 0; index < level.spawn_point_team_class_names[team].size; index++) {
        add_spawn_points_internal(team, get_spawnpoint_array(level.spawn_point_team_class_names[team][index]));
    }
}

// Namespace spawning/spawning_shared
// Params 1, eflags: 0x0
// Checksum 0xef581e57, Offset: 0x3bf0
// Size: 0x11e
function place_spawn_points(spawnpointname) {
    add_spawn_point_classname(spawnpointname);
    spawnpoints = get_spawnpoint_array(spawnpointname);
    if (!spawnpoints.size && level.requirespawnpointstoexistinlevel) {
        /#
            println("<dev string:xf1>" + spawnpointname + "<dev string:xf7>");
        #/
        /#
            assert(spawnpoints.size, "<dev string:xf1>" + spawnpointname + "<dev string:xf7>");
        #/
        callback::abort_level();
        wait 1;
        return;
    }
    for (index = 0; index < spawnpoints.size; index++) {
        spawnpoints[index] spawnpoint_init();
    }
}

// Namespace spawning/spawning_shared
// Params 1, eflags: 0x0
// Checksum 0xb6dcbc76, Offset: 0x3d18
// Size: 0xae
function drop_spawn_points(spawnpointname) {
    spawnpoints = get_spawnpoint_array(spawnpointname);
    if (!spawnpoints.size) {
        /#
            println("<dev string:xf1>" + spawnpointname + "<dev string:xf7>");
        #/
        return;
    }
    for (index = 0; index < spawnpoints.size; index++) {
        placespawnpoint(spawnpoints[index]);
    }
}

// Namespace spawning/spawning_shared
// Params 1, eflags: 0x4
// Checksum 0xc7cc0618, Offset: 0x3dd0
// Size: 0x4c
function private add_spawn_point_classname(spawnpointclassname) {
    if (!isdefined(level.spawn_point_class_names)) {
        level.spawn_point_class_names = [];
    }
    array::add(level.spawn_point_class_names, spawnpointclassname, 0);
}

// Namespace spawning/spawning_shared
// Params 2, eflags: 0x4
// Checksum 0x9d4f461, Offset: 0x3e28
// Size: 0x3c
function private add_spawn_point_team_classname(team, spawnpointclassname) {
    array::add(level.spawn_point_team_class_names[team], spawnpointclassname, 0);
}

// Namespace spawning/spawning_shared
// Params 2, eflags: 0x0
// Checksum 0xa08133fe, Offset: 0x3e70
// Size: 0x186
function get_spawnpoint_array(classname, include_disabled) {
    if (!isdefined(include_disabled)) {
        include_disabled = 0;
    }
    spawn_points = struct::get_array(classname, "targetname");
    if (!include_disabled && getdvarint("spawnsystem_use_code_point_enabled") == 0) {
        enabled_spawn_points = [];
        foreach (spawn_point in spawn_points) {
            if (!(isdefined(spawn_point.disabled) && spawn_point.disabled)) {
                if (!isdefined(enabled_spawn_points)) {
                    enabled_spawn_points = [];
                } else if (!isarray(enabled_spawn_points)) {
                    enabled_spawn_points = array(enabled_spawn_points);
                }
                enabled_spawn_points[enabled_spawn_points.size] = spawn_point;
            }
        }
        spawn_points = enabled_spawn_points;
    }
    return spawn_points;
}

// Namespace spawning/spawning_shared
// Params 0, eflags: 0x4
// Checksum 0xcb75e5d8, Offset: 0x4000
// Size: 0x178
function private spawnpoint_init() {
    spawnpoint = self;
    origin = spawnpoint.origin;
    if (!level.spawnminsmaxsprimed) {
        level.spawnmins = origin;
        level.spawnmaxs = origin;
        level.spawnminsmaxsprimed = 1;
    } else {
        level.spawnmins = math::expand_mins(level.spawnmins, origin);
        level.spawnmaxs = math::expand_maxs(level.spawnmaxs, origin);
    }
    placespawnpoint(spawnpoint);
    spawnpoint.forward = anglestoforward(spawnpoint.angles);
    spawnpoint.sighttracepoint = spawnpoint.origin + (0, 0, 50);
    if (!isdefined(spawnpoint.enabled)) {
        spawnpoint.enabled = 1;
    }
    spawnpoint.inited = 1;
}

// Namespace spawning/spawning_shared
// Params 3, eflags: 0x0
// Checksum 0x4bca57d7, Offset: 0x4180
// Size: 0x258
function get_spawnpoint_final(spawnpoints, predictedspawn, isintermmissionspawn) {
    if (!isdefined(isintermmissionspawn)) {
        isintermmissionspawn = 0;
    }
    bestspawnpoint = undefined;
    if (!isdefined(spawnpoints) || spawnpoints.size == 0) {
        return undefined;
    }
    if (!isdefined(predictedspawn)) {
        predictedspawn = 0;
    }
    if (isdefined(self.lastspawnpoint) && self.lastspawnpoint.lastspawnpredicted && !predictedspawn && !isintermmissionspawn) {
        if (!positionwouldtelefrag(self.lastspawnpoint.origin)) {
            bestspawnpoint = self.lastspawnpoint;
        }
    }
    if (!isdefined(bestspawnpoint)) {
        for (i = 0; i < spawnpoints.size; i++) {
            if (isdefined(self.lastspawnpoint) && self.lastspawnpoint == spawnpoints[i] && !self.lastspawnpoint.lastspawnpredicted) {
                continue;
            }
            if (positionwouldtelefrag(spawnpoints[i].origin)) {
                continue;
            }
            bestspawnpoint = spawnpoints[i];
            break;
        }
    }
    if (!isdefined(bestspawnpoint)) {
        if (isdefined(self.lastspawnpoint) && !positionwouldtelefrag(self.lastspawnpoint.origin)) {
            for (i = 0; i < spawnpoints.size; i++) {
                if (spawnpoints[i] == self.lastspawnpoint) {
                    bestspawnpoint = spawnpoints[i];
                    break;
                }
            }
        }
    }
    if (!isdefined(bestspawnpoint)) {
        bestspawnpoint = spawnpoints[0];
    }
    self finalize_spawnpoint_choice(bestspawnpoint, predictedspawn);
    return bestspawnpoint;
}

// Namespace spawning/spawning_shared
// Params 2, eflags: 0x0
// Checksum 0x592a6b28, Offset: 0x43e0
// Size: 0x7c
function finalize_spawnpoint_choice(spawnpoint, predictedspawn) {
    time = gettime();
    self.lastspawnpoint = spawnpoint;
    self.lastspawntime = time;
    spawnpoint.lastspawnedplayer = self;
    spawnpoint.lastspawntime = time;
    spawnpoint.lastspawnpredicted = predictedspawn;
}

// Namespace spawning/spawning_shared
// Params 3, eflags: 0x0
// Checksum 0xcf895e34, Offset: 0x4468
// Size: 0xe2
function get_spawnpoint_random(spawnpoints, predictedspawn, isintermissionspawn) {
    if (!isdefined(isintermissionspawn)) {
        isintermissionspawn = 0;
    }
    if (!isdefined(spawnpoints)) {
        return undefined;
    }
    for (i = 0; i < spawnpoints.size; i++) {
        j = randomint(spawnpoints.size);
        spawnpoint = spawnpoints[i];
        spawnpoints[i] = spawnpoints[j];
        spawnpoints[j] = spawnpoint;
    }
    return get_spawnpoint_final(spawnpoints, predictedspawn, isintermissionspawn);
}

// Namespace spawning/spawning_shared
// Params 0, eflags: 0x0
// Checksum 0x152020b, Offset: 0x4558
// Size: 0xc4
function get_random_intermission_point() {
    spawnpoints = get_spawnpoint_array("mp_global_intermission");
    if (!spawnpoints.size) {
        spawnpoints = get_spawnpoint_array("cp_global_intermission");
    }
    if (!spawnpoints.size) {
        spawnpoints = get_spawnpoint_array("info_player_start");
    }
    /#
        assert(spawnpoints.size);
    #/
    spawnpoint = get_spawnpoint_random(spawnpoints, undefined, 1);
    return spawnpoint;
}

// Namespace spawning/spawning_shared
// Params 4, eflags: 0x0
// Checksum 0x5aa5dc64, Offset: 0x4628
// Size: 0xe4
function move_spawn_point(targetname, start_point, new_point, new_angles) {
    spawn_points = get_spawnpoint_array(targetname);
    for (i = 0; i < spawn_points.size; i++) {
        if (distancesquared(spawn_points[i].origin, start_point) < 1) {
            spawn_points[i].origin = new_point;
            if (isdefined(new_angles)) {
                spawn_points[i].angles = new_angles;
            }
            return;
        }
    }
}

// Namespace spawning/spawning_shared
// Params 1, eflags: 0x0
// Checksum 0xf26bf691, Offset: 0x4718
// Size: 0x1c
function function_5dfe159a(callbackfunc) {
    level.var_bef1a9a4 = callbackfunc;
}

// Namespace spawning/spawning_shared
// Params 0, eflags: 0x0
// Checksum 0x4693f506, Offset: 0x4740
// Size: 0xe
function function_364aa0b() {
    level.var_bef1a9a4 = undefined;
}

/#

    // Namespace spawning/spawning_shared
    // Params 0, eflags: 0x0
    // Checksum 0x7744be0a, Offset: 0x4758
    // Size: 0x4c8
    function spawnpoint_debug() {
        a_spawnlists = getspawnlists();
        index = 0;
        foreach (s_list in a_spawnlists) {
            adddebugcommand("<dev string:x114>" + s_list + "<dev string:x137>" + index + "<dev string:x156>");
            index++;
        }
        adddebugcommand("<dev string:x114>" + "<dev string:x158>" + "<dev string:x15c>");
        adddebugcommand("<dev string:x17f>");
        adddebugcommand("<dev string:x1d9>");
        while (true) {
            spawnsystem_debug_command = getdvarstring("<dev string:x22a>");
            switch (spawnsystem_debug_command) {
            case #"next_best":
                selectedplayerindex = getdvarint("<dev string:x24e>");
                foreach (player in level.players) {
                    if (player getentitynumber() == selectedplayerindex) {
                        selectedplayer = player;
                        break;
                    }
                }
                if (!isdefined(selectedplayer)) {
                    continue;
                }
                if (level.teambased) {
                    point_team = selectedplayer.pers["<dev string:x26f>"];
                    influencer_team = selectedplayer.pers["<dev string:x26f>"];
                    vis_team_mask = util::getotherteamsmask(selectedplayer.pers["<dev string:x26f>"]);
                } else {
                    point_team = "<dev string:x274>";
                    influencer_team = "<dev string:x274>";
                    vis_team_mask = level.spawnsystem.ispawn_teammask["<dev string:x279>"];
                }
                nextbestspawnpoint = getbestspawnpoint(point_team, influencer_team, vis_team_mask, selectedplayer, 0);
                selectedplayer setorigin(nextbestspawnpoint["<dev string:x27d>"]);
                selectedplayer setplayerangles(nextbestspawnpoint["<dev string:x284>"]);
                break;
            case #"refresh":
                level flagsys::set("<dev string:x293>");
                break;
            }
            setdvar("<dev string:x22a>", "<dev string:x2a5>");
            if (isdefined(getdvarint("<dev string:x2a6>", 0)) && getdvarint("<dev string:x2a6>", 0)) {
                foreach (trig in level.spawnpoint_triggers) {
                    render_spawnpoints_triggers(trig);
                }
            }
            wait 0.5;
        }
    }

    // Namespace spawning/spawning_shared
    // Params 1, eflags: 0x0
    // Checksum 0xfbdb60a7, Offset: 0x4c28
    // Size: 0x2da
    function render_spawnpoints_triggers(trig) {
        box(trig.origin, trig getmins(), trig getmaxs(), 0, (0, 0, 1), 1, 0, 10);
        if (isdefined(trig.spawn_points_to_enable)) {
            foreach (spawn_point in trig.spawn_points_to_enable) {
                box(spawn_point.origin, (-4, -4, 0), (4, 4, 8), 0, isdefined(spawn_point.disabled) && spawn_point.disabled ? (1, 0, 0) : (0, 1, 0), 1, 0, 10);
                line(trig.origin, spawn_point.origin, (0, 1, 0), 1, 0, 10);
            }
        }
        if (isdefined(trig.spawn_points_to_disable)) {
            foreach (spawn_point in trig.spawn_points_to_disable) {
                box(spawn_point.origin, (-4, -4, 0), (4, 4, 8), 0, isdefined(spawn_point.disabled) && spawn_point.disabled ? (1, 0, 0) : (0, 1, 0), 1, 0, 10);
                line(trig.origin, spawn_point.origin, (1, 0, 0), 1, 0, 10);
            }
        }
    }

#/
