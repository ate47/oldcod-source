#using scripts\core_common\callbacks_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\gametypes\spawnlogic;
#using scripts\zm_common\util;

#namespace spawning;

// Namespace spawning/spawning
// Params 0, eflags: 0x0
// Checksum 0x95c1d996, Offset: 0x2d0
// Size: 0x204
function __init__() {
    level init_spawn_system();
    level.recently_deceased = [];
    foreach (team, _ in level.teams) {
        level.recently_deceased[team] = util::spawn_array_struct();
    }
    callback::on_connecting(&on_player_connecting);
    level.spawnprotectiontime = getgametypesetting(#"spawnprotectiontime");
    level.spawnprotectiontimems = int((isdefined(level.spawnprotectiontime) ? level.spawnprotectiontime : 0) * 1000);
    /#
        setdvar(#"scr_debug_spawn_player", "<dev string:x30>");
        setdvar(#"scr_debug_render_spawn_data", 1);
        setdvar(#"scr_debug_render_snapshotmode", 0);
        setdvar(#"scr_spawn_point_test_mode", 0);
        level.test_spawn_point_index = 0;
        setdvar(#"scr_debug_render_spawn_text", 1);
    #/
}

// Namespace spawning/spawning
// Params 0, eflags: 0x0
// Checksum 0xedc96119, Offset: 0x4e0
// Size: 0x192
function init_spawn_system() {
    level.spawnsystem = spawnstruct();
    spawnsystem = level.spawnsystem;
    if (!isdefined(spawnsystem.unifiedsideswitching)) {
        spawnsystem.unifiedsideswitching = 1;
    }
    spawnsystem.objective_facing_bonus = 0;
    spawnsystem.ispawn_teammask = [];
    spawnsystem.ispawn_teammask_free = 1;
    spawnsystem.ispawn_teammask[#"free"] = spawnsystem.ispawn_teammask_free;
    all = spawnsystem.ispawn_teammask_free;
    count = 1;
    foreach (team, _ in level.teams) {
        spawnsystem.ispawn_teammask[team] = 1 << count;
        all |= spawnsystem.ispawn_teammask[team];
        count++;
    }
    spawnsystem.ispawn_teammask[#"all"] = all;
}

// Namespace spawning/spawning
// Params 0, eflags: 0x0
// Checksum 0xad4eb4d2, Offset: 0x680
// Size: 0x8c
function on_player_connecting() {
    level endon(#"game_ended");
    self setentertime(gettime());
    callback::on_spawned(&on_player_spawned);
    callback::on_joined_team(&on_joined_team);
    self thread ongrenadethrow();
}

// Namespace spawning/spawning
// Params 0, eflags: 0x0
// Checksum 0xb3ae2023, Offset: 0x718
// Size: 0x78
function on_player_spawned() {
    self endon(#"disconnect");
    level endon(#"game_ended");
    for (;;) {
        self waittill(#"spawned_player");
        self enable_player_influencers(1);
        self thread ondeath();
    }
}

// Namespace spawning/spawning
// Params 0, eflags: 0x0
// Checksum 0xee760e13, Offset: 0x798
// Size: 0x8c
function ondeath() {
    self endon(#"disconnect");
    level endon(#"game_ended");
    self waittill(#"death");
    self enable_player_influencers(0);
    level create_friendly_influencer("friend_dead", self.origin, self.team);
}

// Namespace spawning/spawning
// Params 1, eflags: 0x0
// Checksum 0x1f1d48b5, Offset: 0x830
// Size: 0x44
function on_joined_team(params) {
    self endon(#"disconnect");
    level endon(#"game_ended");
    self player_influencers_set_team();
}

// Namespace spawning/spawning
// Params 0, eflags: 0x0
// Checksum 0x7c31891e, Offset: 0x880
// Size: 0xc6
function ongrenadethrow() {
    self endon(#"disconnect");
    level endon(#"game_ended");
    while (true) {
        waitresult = self waittill(#"grenade_fire");
        grenade = waitresult.projectile;
        weapon = waitresult.weapon;
        level thread create_grenade_influencers(self.pers[#"team"], weapon, grenade);
        waitframe(1);
    }
}

// Namespace spawning/spawning
// Params 1, eflags: 0x0
// Checksum 0x73e84c58, Offset: 0x950
// Size: 0x52
function get_friendly_team_mask(team) {
    if (level.teambased) {
        team_mask = util::getteammask(team);
    } else {
        team_mask = level.spawnsystem.ispawn_teammask_free;
    }
    return team_mask;
}

// Namespace spawning/spawning
// Params 1, eflags: 0x0
// Checksum 0x5a33960c, Offset: 0x9b0
// Size: 0x52
function get_enemy_team_mask(team) {
    if (level.teambased) {
        team_mask = util::getotherteamsmask(team);
    } else {
        team_mask = level.spawnsystem.ispawn_teammask_free;
    }
    return team_mask;
}

// Namespace spawning/spawning
// Params 3, eflags: 0x0
// Checksum 0x6445bf9b, Offset: 0xa10
// Size: 0x68
function create_influencer(name, origin, team_mask) {
    self.influencers[name] = addinfluencer(name, origin, team_mask);
    self thread watch_remove_influencer();
    return self.influencers[name];
}

// Namespace spawning/spawning
// Params 3, eflags: 0x0
// Checksum 0xf3083b2f, Offset: 0xa80
// Size: 0x78
function create_friendly_influencer(name, origin, team) {
    team_mask = self get_friendly_team_mask(team);
    self.influencersfriendly[name] = create_influencer(name, origin, team_mask);
    return self.influencersfriendly[name];
}

// Namespace spawning/spawning
// Params 3, eflags: 0x0
// Checksum 0xec3e35f9, Offset: 0xb00
// Size: 0x78
function create_enemy_influencer(name, origin, team) {
    team_mask = self get_enemy_team_mask(team);
    self.influencersenemy[name] = create_influencer(name, origin, team_mask);
    return self.influencersenemy[name];
}

// Namespace spawning/spawning
// Params 2, eflags: 0x0
// Checksum 0x4720d840, Offset: 0xb80
// Size: 0x48
function create_entity_influencer(name, team_mask) {
    self.influencers[name] = addentityinfluencer(name, self, team_mask);
    return self.influencers[name];
}

// Namespace spawning/spawning
// Params 1, eflags: 0x0
// Checksum 0xfb878d3, Offset: 0xbd0
// Size: 0x4a
function create_entity_friendly_influencer(name) {
    team_mask = self get_friendly_team_mask();
    return self create_entity_masked_friendly_influencer(name, team_mask);
}

// Namespace spawning/spawning
// Params 1, eflags: 0x0
// Checksum 0xc6c11304, Offset: 0xc28
// Size: 0x4a
function create_entity_enemy_influencer(name) {
    team_mask = self get_enemy_team_mask();
    return self create_entity_masked_enemy_influencer(name, team_mask);
}

// Namespace spawning/spawning
// Params 2, eflags: 0x0
// Checksum 0xcb8465b3, Offset: 0xc80
// Size: 0x48
function create_entity_masked_friendly_influencer(name, team_mask) {
    self.influencersfriendly[name] = self create_entity_influencer(name, team_mask);
    return self.influencersfriendly[name];
}

// Namespace spawning/spawning
// Params 2, eflags: 0x0
// Checksum 0x925ddf66, Offset: 0xcd0
// Size: 0x48
function create_entity_masked_enemy_influencer(name, team_mask) {
    self.influencersenemy[name] = self create_entity_influencer(name, team_mask);
    return self.influencersenemy[name];
}

// Namespace spawning/spawning
// Params 0, eflags: 0x0
// Checksum 0xb22813c5, Offset: 0xd20
// Size: 0x254
function create_player_influencers() {
    assert(!isdefined(self.influencers));
    assert(!isdefined(self.influencers));
    if (!level.teambased) {
        team_mask = level.spawnsystem.ispawn_teammask_free;
        other_team_mask = level.spawnsystem.ispawn_teammask_free;
        weapon_team_mask = level.spawnsystem.ispawn_teammask_free;
    } else if (isdefined(self.pers[#"team"])) {
        team = self.pers[#"team"];
        team_mask = util::getteammask(team);
        enemy_teams_mask = util::getotherteamsmask(team);
    } else {
        team_mask = 0;
        enemy_teams_mask = 0;
    }
    angles = self.angles;
    origin = self.origin;
    up = (0, 0, 1);
    forward = (1, 0, 0);
    self.influencers = [];
    self.friendlyinfluencers = [];
    self.enemyinfluencers = [];
    self create_entity_masked_enemy_influencer(#"enemy", enemy_teams_mask);
    if (level.teambased) {
        self create_entity_masked_friendly_influencer("friend", team_mask);
    }
    if (!isdefined(self.pers[#"team"]) || self.pers[#"team"] == "spectator") {
        self enable_influencers(0);
    }
}

// Namespace spawning/spawning
// Params 0, eflags: 0x0
// Checksum 0x440ccb59, Offset: 0xf80
// Size: 0xb2
function remove_influencers() {
    foreach (influencer in self.influencers) {
        removeinfluencer(influencer);
    }
    self.influencers = [];
    if (isdefined(self.influencersfriendly)) {
        self.influencersfriendly = [];
    }
    if (isdefined(self.influencersenemy)) {
        self.influencersenemy = [];
    }
}

// Namespace spawning/spawning
// Params 0, eflags: 0x0
// Checksum 0xbea9be09, Offset: 0x1040
// Size: 0xd4
function watch_remove_influencer() {
    self endon(#"death");
    self notify(#"watch_remove_influencer");
    self endon(#"watch_remove_influencer");
    waitresult = self waittill(#"influencer_removed");
    arrayremovevalue(self.influencers, waitresult.index);
    arrayremovevalue(self.influencersfriendly, waitresult.index);
    arrayremovevalue(self.influencersenemy, waitresult.index);
    self thread watch_remove_influencer();
}

// Namespace spawning/spawning
// Params 1, eflags: 0x0
// Checksum 0x8f23a7b0, Offset: 0x1120
// Size: 0x88
function enable_influencers(enabled) {
    foreach (influencer in self.influencers) {
        enableinfluencer(influencer, enabled);
    }
}

// Namespace spawning/spawning
// Params 1, eflags: 0x0
// Checksum 0xab545eb3, Offset: 0x11b0
// Size: 0x44
function enable_player_influencers(enabled) {
    if (!isdefined(self.influencers)) {
        self create_player_influencers();
    }
    self enable_influencers(enabled);
}

// Namespace spawning/spawning
// Params 0, eflags: 0x0
// Checksum 0x242e7efc, Offset: 0x1200
// Size: 0x1a8
function player_influencers_set_team() {
    if (!level.teambased) {
        team_mask = level.spawnsystem.ispawn_teammask_free;
        enemy_teams_mask = level.spawnsystem.ispawn_teammask_free;
    } else {
        team = self.pers[#"team"];
        team_mask = util::getteammask(team);
        enemy_teams_mask = util::getotherteamsmask(team);
    }
    if (isdefined(self.influencersfriendly)) {
        foreach (influencer in self.influencersfriendly) {
            setinfluencerteammask(influencer, team_mask);
        }
    }
    if (isdefined(self.influencersenemy)) {
        foreach (influencer in self.influencersenemy) {
            setinfluencerteammask(influencer, enemy_teams_mask);
        }
    }
}

// Namespace spawning/spawning
// Params 3, eflags: 0x0
// Checksum 0xdbc69976, Offset: 0x13b0
// Size: 0x10c
function create_grenade_influencers(parent_team, weapon, grenade) {
    pixbeginevent(#"create_grenade_influencers");
    spawn_influencer = weapon.spawninfluencer;
    if (isdefined(grenade.origin) && spawn_influencer != "") {
        if (!level.teambased) {
            weapon_team_mask = level.spawnsystem.ispawn_teammask_free;
        } else {
            weapon_team_mask = util::getotherteamsmask(parent_team);
            if (level.friendlyfire) {
                weapon_team_mask |= util::getteammask(parent_team);
            }
        }
        grenade create_entity_masked_enemy_influencer(spawn_influencer, weapon_team_mask);
    }
    pixendevent();
}

// Namespace spawning/spawning
// Params 0, eflags: 0x0
// Checksum 0xb25490ce, Offset: 0x14c8
// Size: 0x7e
function create_map_placed_influencers() {
    staticinfluencerents = getentarray("mp_uspawn_influencer", "classname");
    for (i = 0; i < staticinfluencerents.size; i++) {
        staticinfluencerent = staticinfluencerents[i];
        create_map_placed_influencer(staticinfluencerent);
    }
}

// Namespace spawning/spawning
// Params 1, eflags: 0x0
// Checksum 0x1903cbd6, Offset: 0x1550
// Size: 0xa0
function create_map_placed_influencer(influencer_entity) {
    influencer_id = -1;
    if (isdefined(influencer_entity.script_noteworty)) {
        team_mask = util::getteammask(influencer_entity.script_team);
        level create_enemy_influencer(influencer_entity.script_noteworty, influencer_entity.origin, team_mask);
    } else {
        assertmsg("<dev string:x31>");
    }
    return influencer_id;
}

// Namespace spawning/spawning
// Params 0, eflags: 0x0
// Checksum 0x721f8c9a, Offset: 0x15f8
// Size: 0x1ac
function updateallspawnpoints() {
    foreach (team, _ in level.teams) {
        gatherspawnpoints(team);
    }
    spawnlogic::clearspawnpoints();
    if (level.teambased) {
        foreach (team, _ in level.teams) {
            spawnlogic::addspawnpoints(team, level.unified_spawn_points[team].a);
        }
    } else {
        foreach (team, _ in level.teams) {
            spawnlogic::addspawnpoints("free", level.unified_spawn_points[team].a);
        }
    }
    remove_unused_spawn_entities();
}

// Namespace spawning/spawning
// Params 1, eflags: 0x0
// Checksum 0x4bdf703b, Offset: 0x17b0
// Size: 0x146
function onspawnplayer_unified(predictedspawn = 0) {
    /#
        if (getdvarint(#"scr_spawn_point_test_mode", 0) != 0) {
            spawn_point = get_debug_spawnpoint(self);
            self spawn(spawn_point.origin, spawn_point.angles);
            return;
        }
    #/
    use_new_spawn_system = 0;
    initial_spawn = 1;
    if (isdefined(self.uspawn_already_spawned)) {
        initial_spawn = !self.uspawn_already_spawned;
    }
    if (level.usestartspawns) {
        use_new_spawn_system = 0;
    }
    if (level.gametype == "sd") {
        use_new_spawn_system = 0;
    }
    util::set_dvar_if_unset("scr_spawn_force_unified", "0");
    [[ level.onspawnplayer ]](predictedspawn);
    if (!predictedspawn) {
        self.uspawn_already_spawned = 1;
    }
}

// Namespace spawning/spawning
// Params 2, eflags: 0x0
// Checksum 0x627e7155, Offset: 0x1900
// Size: 0x13e
function getspawnpoint(player_entity, predictedspawn = 0) {
    if (level.teambased) {
        point_team = player_entity.pers[#"team"];
        influencer_team = player_entity.pers[#"team"];
    } else {
        point_team = "free";
        influencer_team = "free";
    }
    if (level.teambased && isdefined(game.switchedsides) && game.switchedsides && level.spawnsystem.unifiedsideswitching) {
        point_team = util::getotherteam(point_team);
    }
    best_spawn = get_best_spawnpoint(point_team, influencer_team, player_entity, predictedspawn);
    if (!predictedspawn) {
        player_entity.last_spawn_origin = best_spawn[#"origin"];
    }
    return best_spawn;
}

// Namespace spawning/spawning
// Params 1, eflags: 0x0
// Checksum 0x27c62050, Offset: 0x1a48
// Size: 0x252
function get_debug_spawnpoint(player) {
    if (level.teambased) {
        team = player.pers[#"team"];
    } else {
        team = "free";
    }
    index = level.test_spawn_point_index;
    level.test_spawn_point_index++;
    if (team == "free") {
        spawn_counts = 0;
        foreach (team, _ in level.teams) {
            spawn_counts += level.unified_spawn_points[team].a.size;
        }
        if (level.test_spawn_point_index >= spawn_counts) {
            level.test_spawn_point_index = 0;
        }
        count = 0;
        foreach (team, _ in level.teams) {
            size = level.unified_spawn_points[team].a.size;
            if (level.test_spawn_point_index < count + size) {
                return level.unified_spawn_points[team].a[level.test_spawn_point_index - count];
            }
            count += size;
        }
        return;
    }
    if (level.test_spawn_point_index >= level.unified_spawn_points[team].a.size) {
        level.test_spawn_point_index = 0;
    }
    return level.unified_spawn_points[team].a[level.test_spawn_point_index];
}

// Namespace spawning/spawning
// Params 4, eflags: 0x0
// Checksum 0xdb5e763f, Offset: 0x1ca8
// Size: 0x1b0
function get_best_spawnpoint(point_team, influencer_team, player, predictedspawn) {
    if (level.teambased) {
        vis_team_mask = util::getotherteamsmask(player.pers[#"team"]);
    } else {
        vis_team_mask = level.spawnsystem.ispawn_teammask_free;
    }
    spawn_point = getbestspawnpoint(point_team, influencer_team, vis_team_mask, player, predictedspawn);
    if (!predictedspawn) {
        var_287c357d = {#reason:"point used", #var_b2e83e10:getplayerspawnid(player), #x:spawn_point[#"origin"][0], #y:spawn_point[#"origin"][1], #z:spawn_point[#"origin"][2]};
        function_b1f6086c(#"hash_263d9506f7e11fdd", var_287c357d);
    }
    return spawn_point;
}

// Namespace spawning/spawning
// Params 1, eflags: 0x0
// Checksum 0x32af0ccd, Offset: 0x1e60
// Size: 0xca
function gatherspawnpoints(player_team) {
    if (!isdefined(level.unified_spawn_points)) {
        level.unified_spawn_points = [];
    } else if (isdefined(level.unified_spawn_points[player_team])) {
        return level.unified_spawn_points[player_team];
    }
    spawn_entities_s = util::spawn_array_struct();
    spawn_entities_s.a = spawnlogic::getteamspawnpoints(player_team);
    if (!isdefined(spawn_entities_s.a)) {
        spawn_entities_s.a = [];
    }
    level.unified_spawn_points[player_team] = spawn_entities_s;
    return spawn_entities_s;
}

// Namespace spawning/spawning
// Params 0, eflags: 0x0
// Checksum 0x2240a9bc, Offset: 0x1f38
// Size: 0x20
function is_hardcore() {
    return isdefined(level.hardcoremode) && level.hardcoremode;
}

// Namespace spawning/spawning
// Params 2, eflags: 0x0
// Checksum 0x385c3c13, Offset: 0x1f60
// Size: 0x86
function teams_have_enmity(team1, team2) {
    if (!isdefined(team1) || !isdefined(team2) || level.gametype == "dm") {
        return true;
    }
    return team1 != #"neutral" && team2 != #"neutral" && team1 != team2;
}

// Namespace spawning/spawning
// Params 0, eflags: 0x0
// Checksum 0x47a34870, Offset: 0x1ff0
// Size: 0x226
function remove_unused_spawn_entities() {
    spawn_entity_types = [];
    spawn_entity_types[spawn_entity_types.size] = "mp_dm_spawn";
    spawn_entity_types[spawn_entity_types.size] = "mp_tdm_spawn_allies_start";
    spawn_entity_types[spawn_entity_types.size] = "mp_tdm_spawn_axis_start";
    spawn_entity_types[spawn_entity_types.size] = "mp_tdm_spawn";
    spawn_entity_types[spawn_entity_types.size] = "mp_ctf_spawn_allies_start";
    spawn_entity_types[spawn_entity_types.size] = "mp_ctf_spawn_axis_start";
    spawn_entity_types[spawn_entity_types.size] = "mp_ctf_spawn_allies";
    spawn_entity_types[spawn_entity_types.size] = "mp_ctf_spawn_axis";
    spawn_entity_types[spawn_entity_types.size] = "mp_dom_spawn_allies_start";
    spawn_entity_types[spawn_entity_types.size] = "mp_dom_spawn_axis_start";
    spawn_entity_types[spawn_entity_types.size] = "mp_dom_spawn";
    spawn_entity_types[spawn_entity_types.size] = "mp_sab_spawn_allies_start";
    spawn_entity_types[spawn_entity_types.size] = "mp_sab_spawn_axis_start";
    spawn_entity_types[spawn_entity_types.size] = "mp_sab_spawn_allies";
    spawn_entity_types[spawn_entity_types.size] = "mp_sab_spawn_axis";
    spawn_entity_types[spawn_entity_types.size] = "mp_sd_spawn_attacker";
    spawn_entity_types[spawn_entity_types.size] = "mp_sd_spawn_defender";
    spawn_entity_types[spawn_entity_types.size] = "mp_twar_spawn_axis_start";
    spawn_entity_types[spawn_entity_types.size] = "mp_twar_spawn_allies_start";
    spawn_entity_types[spawn_entity_types.size] = "mp_twar_spawn";
    for (i = 0; i < spawn_entity_types.size; i++) {
        if (spawn_point_class_name_being_used(spawn_entity_types[i])) {
            continue;
        }
        spawnpoints = spawnlogic::getspawnpointarray(spawn_entity_types[i]);
        delete_all_spawns(spawnpoints);
    }
}

// Namespace spawning/spawning
// Params 1, eflags: 0x0
// Checksum 0xb2787c6e, Offset: 0x2220
// Size: 0x4e
function delete_all_spawns(spawnpoints) {
    for (i = 0; i < spawnpoints.size; i++) {
        spawnpoints[i] delete();
    }
}

// Namespace spawning/spawning
// Params 1, eflags: 0x0
// Checksum 0x871550b2, Offset: 0x2278
// Size: 0x6c
function spawn_point_class_name_being_used(name) {
    if (!isdefined(level.spawn_point_class_names)) {
        return false;
    }
    for (i = 0; i < level.spawn_point_class_names.size; i++) {
        if (level.spawn_point_class_names[i] == name) {
            return true;
        }
    }
    return false;
}

// Namespace spawning/spawning
// Params 2, eflags: 0x0
// Checksum 0x2555a31b, Offset: 0x22f0
// Size: 0xe4
function initialspawnprotection(specialtyname, spawnmonitorspeed) {
    self endon(#"death");
    self endon(#"disconnect");
    if (!isdefined(level.spawnprotectiontime) || level.spawnprotectiontime == 0) {
        return;
    }
    if (specialtyname == "specialty_nottargetedbyairsupport") {
        self.specialty_nottargetedbyairsupport = 1;
        wait level.spawnprotectiontime;
        self.specialty_nottargetedbyairsupport = undefined;
        return;
    }
    if (!self hasperk(specialtyname)) {
        self setperk(specialtyname);
        wait level.spawnprotectiontime;
        self unsetperk(specialtyname);
    }
}

