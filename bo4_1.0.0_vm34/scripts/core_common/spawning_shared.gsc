#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\flagsys_shared;
#using scripts\core_common\gameobjects_shared;
#using scripts\core_common\influencers_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\weapons\tacticalinsertion;

#namespace spawning;

// Namespace spawning/spawning_shared
// Params 0, eflags: 0x2
// Checksum 0x5487b637, Offset: 0x200
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"spawning_shared", &__init__, undefined, undefined);
}

// Namespace spawning/spawning_shared
// Params 0, eflags: 0x0
// Checksum 0x4a318c7c, Offset: 0x248
// Size: 0x35c
function __init__() {
    level init_spawn_system();
    level.spawnprotectiontime = getgametypesetting(#"spawnprotectiontime");
    level.spawnprotectiontimems = int(int((isdefined(level.spawnprotectiontime) ? level.spawnprotectiontime : 0) * 1000));
    level.spawntraptriggertime = getgametypesetting(#"spawntraptriggertime");
    level.players = [];
    level.numplayerswaitingtoenterkillcam = 0;
    if (!isdefined(level.requirespawnpointstoexistinlevel)) {
        level.requirespawnpointstoexistinlevel = 1;
    }
    level.convert_spawns_to_structs = getdvarint(#"spawnsystem_convert_spawns_to_structs", 0);
    level.spawnmins = (0, 0, 0);
    level.spawnmaxs = (0, 0, 0);
    level.spawnminsmaxsprimed = 0;
    if (!isdefined(level.default_spawn_lists)) {
        level.default_spawn_lists = [];
    }
    if (!isdefined(level.default_spawn_lists)) {
        level.default_spawn_lists = [];
    } else if (!isarray(level.default_spawn_lists)) {
        level.default_spawn_lists = array(level.default_spawn_lists);
    }
    level.default_spawn_lists[level.default_spawn_lists.size] = "normal";
    foreach (team, _ in level.teams) {
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
// Checksum 0xa2be2a77, Offset: 0x5b0
// Size: 0x92
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
// Checksum 0x8c0e0a25, Offset: 0x650
// Size: 0x64
function on_player_spawned() {
    if (!self flag::exists("spawn_exploration_active")) {
        self flag::init("spawn_exploration_active", 1);
    }
    self flag::set("spawn_exploration_active");
}

// Namespace spawning/spawning_shared
// Params 0, eflags: 0x0
// Checksum 0xab02445e, Offset: 0x6c0
// Size: 0x44
function on_player_laststand() {
    if (self flag::exists("spawn_exploration_active")) {
        self flag::clear("spawn_exploration_active");
    }
}

// Namespace spawning/spawning_shared
// Params 0, eflags: 0x0
// Checksum 0x66523193, Offset: 0x710
// Size: 0x44
function on_player_revived() {
    if (self flag::exists("spawn_exploration_active")) {
        self flag::set("spawn_exploration_active");
    }
}

// Namespace spawning/spawning_shared
// Params 0, eflags: 0x0
// Checksum 0x281ef312, Offset: 0x760
// Size: 0x44
function on_player_killed() {
    if (self flag::exists("spawn_exploration_active")) {
        self flag::clear("spawn_exploration_active");
    }
}

// Namespace spawning/spawning_shared
// Params 0, eflags: 0x4
// Checksum 0x6ab4d4b4, Offset: 0x7b0
// Size: 0x124
function private init_spawn_system() {
    level.spawnsystem = spawnstruct();
    spawnsystem = level.spawnsystem;
    if (!isdefined(spawnsystem.var_65fd4eef)) {
        spawnsystem.var_65fd4eef = 1;
    }
    spawnsystem.objective_facing_bonus = 0;
    spawnsystem.ispawn_teammask = [];
    spawnsystem.ispawn_teammask_free = 1;
    spawnsystem.ispawn_teammask_free = 1;
    spawnsystem.ispawn_teammask[#"free"] = spawnsystem.ispawn_teammask_free;
    spawnsystem.ispawn_teammask[#"neutral"] = spawnsystem.var_a5755715;
    init_teams();
    callback::add_callback(#"init_teams", &init_teams);
}

// Namespace spawning/spawning_shared
// Params 0, eflags: 0x0
// Checksum 0xe6a78143, Offset: 0x8e0
// Size: 0x122
function init_teams() {
    spawnsystem = level.spawnsystem;
    all = spawnsystem.ispawn_teammask_free;
    count = 1;
    if (!isdefined(level.teams)) {
        level.teams = [];
    }
    foreach (team, _ in level.teams) {
        spawnsystem.ispawn_teammask[team] = 1 << count;
        all |= spawnsystem.ispawn_teammask[team];
        count++;
    }
    spawnsystem.ispawn_teammask[#"all"] = all;
}

// Namespace spawning/spawning_shared
// Params 0, eflags: 0x0
// Checksum 0x301797a, Offset: 0xa10
// Size: 0x198
function updateallspawnpoints() {
    clearspawnpoints("normal");
    if (level.teambased) {
        foreach (team, _ in level.teams) {
            addspawnpoints(team, level.teamspawnpoints[team], "normal");
            enablespawnpointlist("normal", util::getteammask(team));
        }
        return;
    }
    foreach (team, _ in level.teams) {
        addspawnpoints("free", level.teamspawnpoints[team], "normal");
        enablespawnpointlist("normal", util::getteammask(team));
    }
}

// Namespace spawning/spawning_shared
// Params 0, eflags: 0x0
// Checksum 0x42311ae9, Offset: 0xbb0
// Size: 0x148
function update_fallback_spawnpoints() {
    clearspawnpoints("fallback");
    if (!isdefined(level.player_fallback_points)) {
        return;
    }
    if (level.teambased) {
        foreach (team, _ in level.teams) {
            addspawnpoints(team, level.player_fallback_points[team], "fallback");
        }
        return;
    }
    foreach (team, _ in level.teams) {
        addspawnpoints("free", level.player_fallback_points[team], "fallback");
    }
}

// Namespace spawning/spawning_shared
// Params 2, eflags: 0x0
// Checksum 0xa0fb471c, Offset: 0xd00
// Size: 0x1c4
function add_fallback_spawnpoints(team, point_class) {
    if (!isdefined(level.player_fallback_points)) {
        level.player_fallback_points = [];
        foreach (level_team, _ in level.teams) {
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
    str_team = util::get_team_mapping(team);
    level.player_fallback_points[str_team] = spawnpoints;
    enablespawnpointlist("fallback", util::getteammask(str_team));
}

// Namespace spawning/spawning_shared
// Params 0, eflags: 0x0
// Checksum 0x6a4526f5, Offset: 0xed0
// Size: 0x3a
function function_2b4d76ea() {
    if (game.switchedsides == 0) {
        return false;
    }
    if (level.spawnsystem.var_65fd4eef == 0) {
        return true;
    }
    return false;
}

// Namespace spawning/spawning_shared
// Params 2, eflags: 0x0
// Checksum 0xb63284e0, Offset: 0xf18
// Size: 0x10e
function add_start_spawn_points(str_team, classname) {
    str_team = util::get_team_mapping(str_team);
    if (!isdefined(level.spawn_start)) {
        level.spawn_start = [];
    }
    if (!isdefined(level.spawn_start[str_team])) {
        level.spawn_start[str_team] = [];
    }
    spawnpoints = get_spawnpoint_array(classname);
    teamforspawns = function_2b4d76ea() ? util::getotherteam(str_team) : str_team;
    level.spawn_start[str_team] = arraycombine(level.spawn_start[str_team], spawnpoints, 0, 0);
}

// Namespace spawning/spawning_shared
// Params 1, eflags: 0x4
// Checksum 0x2cb6a87, Offset: 0x1030
// Size: 0xd2
function private is_spawn_trapped(team) {
    /#
        level.spawntraptriggertime = getgametypesetting(#"spawntraptriggertime");
    #/
    if (!level.rankedmatch) {
        return false;
    }
    if (isdefined(level.alivetimesaverage) && isdefined(level.alivetimesaverage[team]) && level.alivetimesaverage[team] != 0 && level.alivetimesaverage[team] < int(level.spawntraptriggertime * 1000)) {
        return true;
    }
    return false;
}

// Namespace spawning/spawning_shared
// Params 2, eflags: 0x4
// Checksum 0x107f6dc8, Offset: 0x1110
// Size: 0x5e
function private function_b2408480(spawn_origin, spawn_angles) {
    self predictspawnpoint(spawn_origin, spawn_angles);
    self.predicted_spawn_point = {#origin:spawn_origin, #angles:spawn_angles};
}

// Namespace spawning/spawning_shared
// Params 1, eflags: 0x4
// Checksum 0xafc53c3e, Offset: 0x1178
// Size: 0x146
function private use_start_spawns(predictedspawn) {
    if (isdefined(level.alwaysusestartspawns) && level.alwaysusestartspawns) {
        return true;
    }
    if (!(isdefined(level.usestartspawns) && level.usestartspawns)) {
        return false;
    }
    if (level.teambased) {
        spawnteam = self.pers[#"team"];
        if (level.aliveplayers[spawnteam].size + level.spawningplayers[self.team].size >= level.spawn_start[spawnteam].size) {
            if (!predictedspawn) {
                level.usestartspawns = 0;
            }
            return false;
        }
    } else if (level.aliveplayers[#"free"].size + level.spawningplayers[#"free"].size >= level.spawn_start.size) {
        if (!predictedspawn) {
            level.usestartspawns = 0;
        }
        return false;
    }
    return true;
}

// Namespace spawning/spawning_shared
// Params 1, eflags: 0x0
// Checksum 0xe1e5516a, Offset: 0x12c8
// Size: 0x45c
function onspawnplayer(predictedspawn = 0) {
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
            self function_b2408480(self.tacticalinsertion.origin, self.tacticalinsertion.angles);
        }
        return;
    } else if (self use_start_spawns(predictedspawn)) {
        spawnpoint = undefined;
        if (!predictedspawn) {
            if (level.teambased) {
                array::add(level.spawningplayers[self.team], self);
            } else {
                array::add(level.spawningplayers[#"free"], self);
            }
        }
        if (level.teambased) {
            spawnteam = self.pers[#"team"];
            if (game.switchedsides && level.spawnsystem.var_65fd4eef) {
                spawnteam = util::getotherteam(spawnteam);
            }
            var_b9c73858 = undefined;
            if (isdefined(level.var_a36df600)) {
                var_b9c73858 = self [[ level.var_a36df600 ]](level.spawn_start[spawnteam]);
            }
            if (!isdefined(var_b9c73858) || !var_b9c73858.size) {
                var_b9c73858 = level.spawn_start[spawnteam];
            }
            spawnpoint = get_spawnpoint_random(var_b9c73858, predictedspawn);
        } else {
            spawnpoint = get_spawnpoint_random(level.spawn_start[self.team], predictedspawn);
        }
        if (isdefined(spawnpoint)) {
            spawn_origin = spawnpoint.origin;
            spawn_angles = spawnpoint.angles;
        }
    } else {
        spawn_point = getspawnpoint(self, predictedspawn);
        if (isdefined(spawn_point)) {
            spawn_origin = spawn_point[#"origin"];
            spawn_angles = spawn_point[#"angles"];
        }
    }
    if (!isdefined(spawn_origin)) {
        println("<dev string:x30>");
        callback::abort_level();
    }
    if (predictedspawn) {
        self function_b2408480(spawn_origin, spawn_angles);
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
// Checksum 0x25bb33e4, Offset: 0x1730
// Size: 0x1ce
function private getspawnpoint(player_entity, predictedspawn = 0) {
    if (sessionmodeiswarzonegame()) {
        point_team = "free";
        influencer_team = player_entity.pers[#"team"];
    } else if (level.teambased) {
        point_team = player_entity.pers[#"team"];
        influencer_team = player_entity.pers[#"team"];
    } else {
        point_team = "free";
        influencer_team = "free";
    }
    if (level.teambased && isdefined(game.switchedsides) && game.switchedsides && level.spawnsystem.var_65fd4eef) {
        point_team = util::getotherteam(point_team);
    }
    use_fallback_points = 0;
    spawn_trapped = is_spawn_trapped(point_team);
    if (spawn_trapped) {
        use_fallback_points = 1;
    }
    best_spawn = get_best_spawnpoint(point_team, influencer_team, player_entity, predictedspawn, use_fallback_points);
    if (!predictedspawn) {
        player_entity.last_spawn_origin = best_spawn[#"origin"];
    }
    return best_spawn;
}

// Namespace spawning/spawning_shared
// Params 5, eflags: 0x0
// Checksum 0x790fee59, Offset: 0x1908
// Size: 0x450
function get_best_spawnpoint(point_team, influencer_team, player, predictedspawn, use_fallback_points) {
    if (level.teambased) {
        vis_team_mask = util::getotherteamsmask(player.pers[#"team"]);
    } else {
        vis_team_mask = level.spawnsystem.ispawn_teammask[#"all"];
    }
    lists = [];
    if (isdefined(level.var_2ff68ddb) && level.var_2ff68ddb.size) {
        lists = function_53db560c(player);
    }
    if (!lists.size) {
        foreach (spawnlist in level.default_spawn_lists) {
            if (!isdefined(lists)) {
                lists = [];
            } else if (!isarray(lists)) {
                lists = array(lists);
            }
            lists[lists.size] = spawnlist;
        }
    }
    if (use_fallback_points) {
        if (!isdefined(lists)) {
            lists = [];
        } else if (!isarray(lists)) {
            lists = array(lists);
        }
        lists[lists.size] = "fallback";
    }
    spawn_point = getbestspawnpoint(point_team, influencer_team, vis_team_mask, player, predictedspawn, lists);
    assert(isdefined(spawn_point), "<dev string:x68>");
    if (!isdefined(spawn_point)) {
        spawn_point = getbestspawnpoint(point_team, influencer_team, vis_team_mask, player, predictedspawn, level.default_spawn_lists);
        assert(isdefined(spawn_point), "<dev string:xcd>");
        if (!isdefined(spawn_point)) {
            spawn_point = [];
            spawn_point[#"origin"] = (0, 0, 0);
            spawn_point[#"angles"] = (0, 0, 0);
        }
    }
    if (!predictedspawn) {
        var_3f13cff0 = 0;
        if (isdefined(level.var_a55ab915)) {
            var_3f13cff0 = [[ level.var_a55ab915 ]](player);
        }
        if (sessionmodeismultiplayergame()) {
            mpspawnpointsused = {#reason:"point used", #var_b2e83e10:getplayerspawnid(player), #x:spawn_point[#"origin"][0], #y:spawn_point[#"origin"][1], #z:spawn_point[#"origin"][2], #var_e1354d39:var_3f13cff0};
            function_b1f6086c(#"hash_608dde355fff78f5", mpspawnpointsused);
        }
    }
    return spawn_point;
}

// Namespace spawning/spawning_shared
// Params 1, eflags: 0x4
// Checksum 0x4ef023b4, Offset: 0x1d60
// Size: 0x46
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
// Checksum 0xa74c83fd, Offset: 0x1db0
// Size: 0x9c
function event_handler[spawnpoints_update] codecallback_updatespawnpoints(eventstruct) {
    foreach (team, _ in level.teams) {
        rebuild_spawn_points(team);
    }
    updateallspawnpoints();
}

// Namespace spawning/spawning_shared
// Params 3, eflags: 0x4
// Checksum 0xe00519d2, Offset: 0x1e58
// Size: 0x25e
function private add_spawn_points_internal(team, spawnpoints, list = 0) {
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
// Checksum 0xa72f8321, Offset: 0x20c0
// Size: 0x238
function clear_and_add_spawn_points(str_team, classnames, ...) {
    str_team = util::get_team_mapping(str_team);
    assert(vararg.size % 2 == 0, "<dev string:x136>");
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
// Checksum 0x374fbbda, Offset: 0x2300
// Size: 0xb2
function clear_spawn_points() {
    foreach (team, _ in level.teams) {
        level.teamspawnpoints[team] = [];
        level.spawn_start[team] = [];
        level.spawn_point_team_class_names[team] = [];
    }
    level.spawnpoints = [];
}

// Namespace spawning/spawning_shared
// Params 0, eflags: 0x4
// Checksum 0x962f340f, Offset: 0x23c0
// Size: 0xe6
function private update_spawn_points() {
    while (true) {
        level flagsys::wait_till("spawnpoints_dirty");
        foreach (team, _ in level.teams) {
            rebuild_spawn_points(team);
        }
        updateallspawnpoints();
        level flagsys::clear(#"spawnpoints_dirty");
        waitframe(1);
    }
}

// Namespace spawning/spawning_shared
// Params 0, eflags: 0x4
// Checksum 0x9727c12d, Offset: 0x24b0
// Size: 0x100
function private update_explored_spawn_points() {
    level flagsys::wait_till("spawn_point_exploration_enabled");
    explored_radius = getdvarfloat(#"spawnsystem_player_explored_radius", 0);
    explored_radius_sq = explored_radius * explored_radius;
    foreach (team, _ in level.teams) {
        level thread update_explored_start_spawn_points_for_team(team);
        level thread update_explored_spawn_points_for_team(team, explored_radius_sq);
    }
}

// Namespace spawning/spawning_shared
// Params 1, eflags: 0x4
// Checksum 0x39b9a6ef, Offset: 0x25b8
// Size: 0x250
function private update_explored_start_spawn_points_for_team(team) {
    level notify("update_explored_start_spawn_points_for_team" + string(team));
    level endon("update_explored_start_spawn_points_for_team" + string(team));
    while (true) {
        if (!isdefined(level.spawn_start[team])) {
            wait 0.5;
            continue;
        }
        players = getplayers();
        allplayersspawned = 0;
        if (players.size >= getdvarint(#"com_maxclients", 0)) {
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
// Checksum 0xc4fd08e4, Offset: 0x2810
// Size: 0x252
function private update_explored_spawn_points_for_team(team, explored_radius_sq) {
    level notify("update_explored_spawn_points_for_team" + string(team));
    level endon("update_explored_spawn_points_for_team" + string(team));
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
// Checksum 0x6435133d, Offset: 0x2a70
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
// Checksum 0x2a086f81, Offset: 0x2b28
// Size: 0xa
function spawn_exploration_wait_for_one_frame() {
    waitframe(1);
}

// Namespace spawning/spawning_shared
// Params 2, eflags: 0x4
// Checksum 0xcc8610b9, Offset: 0x2b40
// Size: 0x36
function private has_player_explored_spawn_point(spawnpoint, player) {
    return spawnpoint.explored & 1 << player getentitynumber();
}

// Namespace spawning/spawning_shared
// Params 2, eflags: 0x4
// Checksum 0x83367a45, Offset: 0x2b80
// Size: 0x8a
function private set_player_explored_spawn_point(spawnpoint, player) {
    spawnpoint.explored |= 1 << player getentitynumber();
    if (isdefined(player.companion)) {
        spawnpoint.explored |= 1 << player.companion getentitynumber();
    }
}

// Namespace spawning/spawning_shared
// Params 0, eflags: 0x0
// Checksum 0x137b291c, Offset: 0x2c18
// Size: 0xde
function clear_all_spawn_point_explored() {
    foreach (team, _ in level.teams) {
        foreach (spawnpoint in level.teamspawnpoints[team]) {
            spawnpoint.explored = 0;
        }
    }
}

// Namespace spawning/spawning_shared
// Params 2, eflags: 0x0
// Checksum 0x9a27574a, Offset: 0x2d00
// Size: 0x9a
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
// Checksum 0x95cc019f, Offset: 0x2da8
// Size: 0x24
function enable_spawn_point_exploration() {
    level flagsys::set(#"spawn_point_exploration_enabled");
}

// Namespace spawning/spawning_shared
// Params 1, eflags: 0x0
// Checksum 0x7697997b, Offset: 0x2dd8
// Size: 0x64
function disable_spawn_point_exploration(clear = 1) {
    level flagsys::clear(#"spawn_point_exploration_enabled");
    if (isdefined(clear) && clear) {
        clear_all_spawn_point_explored();
    }
}

// Namespace spawning/spawning_shared
// Params 1, eflags: 0x0
// Checksum 0x45ac4318, Offset: 0x2e48
// Size: 0x2c
function set_spawn_point_exploration_radius(radius) {
    setdvar(#"spawnsystem_player_explored_radius", radius);
}

// Namespace spawning/spawning_shared
// Params 2, eflags: 0x0
// Checksum 0x4e1d1e6a, Offset: 0x2e80
// Size: 0xe4
function add_spawn_points(team, spawnpointname) {
    team = util::get_team_mapping(team);
    add_spawn_point_classname(spawnpointname);
    add_spawn_point_team_classname(team, spawnpointname);
    enabled_spawn_points = setup_trigger_enabled_spawn_points(get_spawnpoint_array(spawnpointname, 1));
    enabled_spawn_points = remove_disabled_on_start_spawn_points(enabled_spawn_points);
    add_spawn_points_internal(team, enabled_spawn_points);
    level flagsys::set(#"spawnpoints_dirty");
}

// Namespace spawning/spawning_shared
// Params 1, eflags: 0x4
// Checksum 0xb26f77e4, Offset: 0x2f70
// Size: 0x172
function private remove_disabled_on_start_spawn_points(spawn_points) {
    disable_spawn_points = [];
    foreach (spawn_point in spawn_points) {
        if (isdefined(spawn_point.script_start_disabled) && spawn_point.script_start_disabled) {
            if (getdvarint(#"spawnsystem_use_code_point_enabled", 0) == 0) {
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
// Checksum 0x9b57805e, Offset: 0x30f0
// Size: 0x330
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
// Checksum 0x7502cb1f, Offset: 0x3428
// Size: 0x164
function private _disable_spawn_points() {
    self endon(#"death");
    self notify(#"end_disable_spawn_points");
    self endon(#"end_disable_spawn_points");
    while (true) {
        waitresult = self waittill(#"trigger");
        self.spawnpoints_enabled = undefined;
        foreach (spawn_point in self.spawn_points_to_disable) {
            if (spawn_point.disabled !== 1 && getdvarint(#"spawnsystem_use_code_point_enabled", 0) == 0) {
                level flagsys::set(#"spawnpoints_dirty");
            }
            spawn_point.disabled = 1;
            spawn_point.trigger_enabled = 0;
            spawn_point function_7d02437f();
        }
    }
}

// Namespace spawning/spawning_shared
// Params 0, eflags: 0x4
// Checksum 0x71f156c4, Offset: 0x3598
// Size: 0x174
function private _enable_spawn_points() {
    self endon(#"death");
    self notify(#"end_enable_spawn_points");
    self endon(#"end_enable_spawn_points");
    while (true) {
        waitresult = self waittill(#"trigger");
        self.spawnpoints_enabled = 1;
        foreach (spawn_point in self.spawn_points_to_enable) {
            if (isdefined(spawn_point.disabled) && spawn_point.disabled && getdvarint(#"spawnsystem_use_code_point_enabled", 0) == 0) {
                level flagsys::set(#"spawnpoints_dirty");
            }
            spawn_point.disabled = undefined;
            spawn_point.trigger_enabled = 1;
            spawn_point function_7d02437f();
        }
    }
}

// Namespace spawning/spawning_shared
// Params 0, eflags: 0x4
// Checksum 0xc8f03a39, Offset: 0x3718
// Size: 0x72
function private function_7d02437f() {
    self.enabled = 1;
    self.enabled = self.enabled && (!isdefined(self.trigger_enabled) || self.trigger_enabled);
    self.enabled = self.enabled && (!isdefined(self.filter_enabled) || self.filter_enabled);
}

// Namespace spawning/spawning_shared
// Params 1, eflags: 0x4
// Checksum 0x252b17cf, Offset: 0x3798
// Size: 0x8e
function private rebuild_spawn_points(team) {
    level.teamspawnpoints[team] = [];
    for (index = 0; index < level.spawn_point_team_class_names[team].size; index++) {
        add_spawn_points_internal(team, get_spawnpoint_array(level.spawn_point_team_class_names[team][index]));
    }
}

// Namespace spawning/spawning_shared
// Params 1, eflags: 0x0
// Checksum 0xf84429da, Offset: 0x3830
// Size: 0x116
function place_spawn_points(spawnpointname) {
    add_spawn_point_classname(spawnpointname);
    spawnpoints = get_spawnpoint_array(spawnpointname);
    if (!spawnpoints.size && level.requirespawnpointstoexistinlevel) {
        println("<dev string:x17e>" + spawnpointname + "<dev string:x184>");
        assert(spawnpoints.size, "<dev string:x17e>" + spawnpointname + "<dev string:x184>");
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
// Checksum 0x2142075, Offset: 0x3950
// Size: 0xa6
function drop_spawn_points(spawnpointname) {
    spawnpoints = get_spawnpoint_array(spawnpointname);
    if (!spawnpoints.size) {
        println("<dev string:x17e>" + spawnpointname + "<dev string:x184>");
        return;
    }
    for (index = 0; index < spawnpoints.size; index++) {
        placespawnpoint(spawnpoints[index]);
    }
}

// Namespace spawning/spawning_shared
// Params 1, eflags: 0x4
// Checksum 0x46eb7cf0, Offset: 0x3a00
// Size: 0x4c
function private add_spawn_point_classname(spawnpointclassname) {
    if (!isdefined(level.spawn_point_class_names)) {
        level.spawn_point_class_names = [];
    }
    array::add(level.spawn_point_class_names, spawnpointclassname, 0);
}

// Namespace spawning/spawning_shared
// Params 2, eflags: 0x4
// Checksum 0xef69ecca, Offset: 0x3a58
// Size: 0x3c
function private add_spawn_point_team_classname(team, spawnpointclassname) {
    array::add(level.spawn_point_team_class_names[team], spawnpointclassname, 0);
}

// Namespace spawning/spawning_shared
// Params 2, eflags: 0x0
// Checksum 0x1428f1e3, Offset: 0x3aa0
// Size: 0x168
function get_spawnpoint_array(classname, include_disabled = 0) {
    spawn_points = struct::get_array(classname, "targetname");
    if (!include_disabled && getdvarint(#"spawnsystem_use_code_point_enabled", 0) == 0) {
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
// Checksum 0xae1a795, Offset: 0x3c10
// Size: 0x146
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
// Checksum 0xd1240d62, Offset: 0x3d60
// Size: 0x240
function get_spawnpoint_final(spawnpoints, predictedspawn, isintermmissionspawn = 0) {
    bestspawnpoint = undefined;
    if (!isdefined(spawnpoints) || spawnpoints.size == 0) {
        return undefined;
    }
    if (!isdefined(predictedspawn)) {
        predictedspawn = 0;
    }
    if (isdefined(self.lastspawnpoint) && self.lastspawnpoint.lastspawnpredicted && !predictedspawn && !isintermmissionspawn && (!isdefined(self.var_b05340ee) || !self.var_b05340ee)) {
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
// Checksum 0x5515f639, Offset: 0x3fa8
// Size: 0x72
function finalize_spawnpoint_choice(spawnpoint, predictedspawn) {
    time = gettime();
    self.lastspawnpoint = spawnpoint;
    self.lastspawntime = time;
    self.var_b05340ee = 0;
    spawnpoint.lastspawnedplayer = self;
    spawnpoint.lastspawntime = time;
    spawnpoint.lastspawnpredicted = predictedspawn;
}

// Namespace spawning/spawning_shared
// Params 3, eflags: 0x0
// Checksum 0x3d8dc907, Offset: 0x4028
// Size: 0xda
function get_spawnpoint_random(spawnpoints, predictedspawn, isintermissionspawn = 0) {
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
// Checksum 0x948e9a6a, Offset: 0x4110
// Size: 0xc2
function get_random_intermission_point() {
    spawnpoints = get_spawnpoint_array("mp_global_intermission");
    if (!spawnpoints.size) {
        spawnpoints = get_spawnpoint_array("cp_global_intermission");
    }
    if (!spawnpoints.size) {
        spawnpoints = get_spawnpoint_array("info_player_start");
    }
    assert(spawnpoints.size);
    spawnpoint = get_spawnpoint_random(spawnpoints, undefined, 1);
    return spawnpoint;
}

// Namespace spawning/spawning_shared
// Params 4, eflags: 0x0
// Checksum 0xe7b6193, Offset: 0x41e0
// Size: 0x1a8
function move_spawn_point(var_1346c657, start_point, new_point, new_angles) {
    targetnamearray = [];
    if (isarray(var_1346c657)) {
        targetnamearray = var_1346c657;
    } else {
        if (!isdefined(targetnamearray)) {
            targetnamearray = [];
        } else if (!isarray(targetnamearray)) {
            targetnamearray = array(targetnamearray);
        }
        targetnamearray[targetnamearray.size] = var_1346c657;
    }
    foreach (targetname in targetnamearray) {
        spawn_points = get_spawnpoint_array(targetname);
        for (i = 0; i < spawn_points.size; i++) {
            if (distancesquared(spawn_points[i].origin, start_point) < 1) {
                spawn_points[i].origin = new_point;
                if (isdefined(new_angles)) {
                    spawn_points[i].angles = new_angles;
                }
            }
        }
    }
}

// Namespace spawning/spawning_shared
// Params 1, eflags: 0x0
// Checksum 0x3f56b7c8, Offset: 0x4390
// Size: 0x44
function function_5b468440(func_callback) {
    if (!isdefined(level.var_2ff68ddb)) {
        level.var_2ff68ddb = [];
    }
    array::add(level.var_2ff68ddb, func_callback);
}

// Namespace spawning/spawning_shared
// Params 1, eflags: 0x0
// Checksum 0xeee8788d, Offset: 0x43e0
// Size: 0xda
function function_7821992d(func_callback) {
    assert(isdefined(level.var_2ff68ddb) && level.var_2ff68ddb.size, "<dev string:x1a1>");
    foreach (index, func in level.var_2ff68ddb) {
        if (func == func_callback) {
            arrayremoveindex(level.var_2ff68ddb, index, 0);
            return;
        }
    }
}

// Namespace spawning/spawning_shared
// Params 1, eflags: 0x0
// Checksum 0x5dfe6b87, Offset: 0x44c8
// Size: 0xbc
function function_53db560c(e_player) {
    var_f088450f = [];
    foreach (func in level.var_2ff68ddb) {
        var_605ceb91 = [[ func ]](e_player);
        if (isdefined(var_605ceb91)) {
            array::add(var_f088450f, var_605ceb91);
        }
    }
    return var_f088450f;
}

/#

    // Namespace spawning/spawning_shared
    // Params 0, eflags: 0x0
    // Checksum 0xe5336f7c, Offset: 0x4590
    // Size: 0x4dc
    function spawnpoint_debug() {
        a_spawnlists = getspawnlists();
        index = 0;
        foreach (s_list in a_spawnlists) {
            adddebugcommand("<dev string:x1d2>" + s_list + "<dev string:x1fe>" + index + "<dev string:x21d>");
            index++;
        }
        adddebugcommand("<dev string:x1d2>" + "<dev string:x21f>" + "<dev string:x223>");
        adddebugcommand("<dev string:x246>");
        adddebugcommand("<dev string:x2a5>");
        while (true) {
            spawnsystem_debug_command = getdvarstring(#"spawnsystem_debug_command");
            switch (spawnsystem_debug_command) {
            case #"next_best":
                selectedplayerindex = getdvarint(#"spawnsystem_debug_current_player", 0);
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
                    point_team = selectedplayer.pers[#"team"];
                    influencer_team = selectedplayer.pers[#"team"];
                    vis_team_mask = util::getotherteamsmask(selectedplayer.pers[#"team"]);
                } else {
                    point_team = "<dev string:x2fb>";
                    influencer_team = "<dev string:x2fb>";
                    vis_team_mask = level.spawnsystem.ispawn_teammask[#"all"];
                }
                nextbestspawnpoint = getbestspawnpoint(point_team, influencer_team, vis_team_mask, selectedplayer, 0);
                selectedplayer setorigin(nextbestspawnpoint[#"origin"]);
                selectedplayer setplayerangles(nextbestspawnpoint[#"angles"]);
                break;
            case #"refresh":
                level flagsys::set(#"spawnpoints_dirty");
                break;
            }
            setdvar(#"spawnsystem_debug_command", "<dev string:x300>");
            if (isdefined(getdvarint(#"spawnsystem_debug_triggers", 0)) && getdvarint(#"spawnsystem_debug_triggers", 0)) {
                foreach (trig in level.spawnpoint_triggers) {
                    render_spawnpoints_triggers(trig);
                }
            }
            wait 0.5;
        }
    }

    // Namespace spawning/spawning_shared
    // Params 1, eflags: 0x0
    // Checksum 0xc01e73ae, Offset: 0x4a78
    // Size: 0x288
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
