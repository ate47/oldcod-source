#using script_44b0b8420eabacad;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\gametypes\spawnlogic;
#using scripts\zm_common\util;

#namespace spawning;

// Namespace spawning/spawning
// Params 0, eflags: 0x4
// Checksum 0x87f10036, Offset: 0x328
// Size: 0x20c
function private function_70a657d8() {
    level init_spawn_system();
    level.recently_deceased = [];
    foreach (team, _ in level.teams) {
        level.recently_deceased[team] = util::spawn_array_struct();
    }
    callback::on_connecting(&on_player_connecting);
    level.spawnprotectiontime = getgametypesetting(#"spawnprotectiontime");
    level.spawnprotectiontimems = int((isdefined(level.spawnprotectiontime) ? level.spawnprotectiontime : 0) * 1000);
    /#
        setdvar(#"scr_debug_spawn_player", "<dev string:x38>");
        setdvar(#"scr_debug_render_spawn_data", 1);
        setdvar(#"scr_debug_render_snapshotmode", 0);
        setdvar(#"scr_spawn_point_test_mode", 0);
        level.test_spawn_point_index = 0;
        setdvar(#"scr_debug_render_spawn_text", 1);
    #/
}

// Namespace spawning/spawning
// Params 0, eflags: 0x1 linked
// Checksum 0x1bb4c43, Offset: 0x540
// Size: 0x17c
function init_spawn_system() {
    level.spawnsystem = spawnstruct();
    spawnsystem = level.spawnsystem;
    if (!isdefined(spawnsystem.unifiedsideswitching)) {
        spawnsystem.unifiedsideswitching = 1;
    }
    spawnsystem.objective_facing_bonus = 0;
    spawnsystem.ispawn_teammask = [];
    spawnsystem.ispawn_teammask_free = 1;
    spawnsystem.ispawn_teammask[#"none"] = spawnsystem.ispawn_teammask_free;
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
// Params 0, eflags: 0x1 linked
// Checksum 0x2a7ae011, Offset: 0x6c8
// Size: 0x8c
function on_player_connecting() {
    level endon(#"game_ended");
    self setentertime(gettime());
    callback::on_spawned(&on_player_spawned);
    callback::on_joined_team(&on_joined_team);
    self thread ongrenadethrow();
}

// Namespace spawning/spawning
// Params 0, eflags: 0x1 linked
// Checksum 0x98624487, Offset: 0x760
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
// Params 0, eflags: 0x1 linked
// Checksum 0xb989805d, Offset: 0x7e0
// Size: 0x8c
function ondeath() {
    self endon(#"disconnect");
    level endon(#"game_ended");
    self waittill(#"death");
    self enable_player_influencers(0);
    level create_friendly_influencer("friend_dead", self.origin, self.team);
}

// Namespace spawning/spawning
// Params 1, eflags: 0x1 linked
// Checksum 0xf7199e86, Offset: 0x878
// Size: 0x44
function on_joined_team(*params) {
    self endon(#"disconnect");
    level endon(#"game_ended");
    self player_influencers_set_team();
}

// Namespace spawning/spawning
// Params 0, eflags: 0x1 linked
// Checksum 0x3f5ca029, Offset: 0x8c8
// Size: 0xbe
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
// Params 1, eflags: 0x1 linked
// Checksum 0xdeb7f79f, Offset: 0x990
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
// Params 1, eflags: 0x1 linked
// Checksum 0x4e3d4335, Offset: 0x9f0
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
// Params 3, eflags: 0x1 linked
// Checksum 0x2481c922, Offset: 0xa50
// Size: 0x60
function create_influencer(name, origin, team_mask) {
    self.influencers[name] = addinfluencer(name, origin, team_mask);
    self thread watch_remove_influencer();
    return self.influencers[name];
}

// Namespace spawning/spawning
// Params 3, eflags: 0x1 linked
// Checksum 0x3e5e1e5d, Offset: 0xab8
// Size: 0x6c
function create_friendly_influencer(name, origin, team) {
    team_mask = self get_friendly_team_mask(team);
    self.influencersfriendly[name] = create_influencer(name, origin, team_mask);
    return self.influencersfriendly[name];
}

// Namespace spawning/spawning
// Params 3, eflags: 0x1 linked
// Checksum 0xe8eefde7, Offset: 0xb30
// Size: 0x6c
function create_enemy_influencer(name, origin, team) {
    team_mask = self get_enemy_team_mask(team);
    self.influencersenemy[name] = create_influencer(name, origin, team_mask);
    return self.influencersenemy[name];
}

// Namespace spawning/spawning
// Params 2, eflags: 0x1 linked
// Checksum 0xe403184c, Offset: 0xba8
// Size: 0x44
function create_entity_influencer(name, team_mask) {
    self.influencers[name] = addentityinfluencer(name, self, team_mask);
    return self.influencers[name];
}

// Namespace spawning/spawning
// Params 1, eflags: 0x0
// Checksum 0x43958b07, Offset: 0xbf8
// Size: 0x4a
function create_entity_friendly_influencer(name) {
    team_mask = self get_friendly_team_mask();
    return self create_entity_masked_friendly_influencer(name, team_mask);
}

// Namespace spawning/spawning
// Params 1, eflags: 0x0
// Checksum 0x8c8a0182, Offset: 0xc50
// Size: 0x4a
function create_entity_enemy_influencer(name) {
    team_mask = self get_enemy_team_mask();
    return self create_entity_masked_enemy_influencer(name, team_mask);
}

// Namespace spawning/spawning
// Params 2, eflags: 0x1 linked
// Checksum 0xb4e3a1b8, Offset: 0xca8
// Size: 0x44
function create_entity_masked_friendly_influencer(name, team_mask) {
    self.influencersfriendly[name] = self create_entity_influencer(name, team_mask);
    return self.influencersfriendly[name];
}

// Namespace spawning/spawning
// Params 2, eflags: 0x1 linked
// Checksum 0xa734a3b0, Offset: 0xcf8
// Size: 0x44
function create_entity_masked_enemy_influencer(name, team_mask) {
    self.influencersenemy[name] = self create_entity_influencer(name, team_mask);
    return self.influencersenemy[name];
}

// Namespace spawning/spawning
// Params 0, eflags: 0x1 linked
// Checksum 0xab20c2a7, Offset: 0xd48
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
// Checksum 0x75bbcc47, Offset: 0xfa8
// Size: 0xc2
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
// Params 0, eflags: 0x1 linked
// Checksum 0x13681fad, Offset: 0x1078
// Size: 0xdc
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
// Params 1, eflags: 0x1 linked
// Checksum 0x7258aac2, Offset: 0x1160
// Size: 0x90
function enable_influencers(enabled) {
    foreach (influencer in self.influencers) {
        enableinfluencer(influencer, enabled);
    }
}

// Namespace spawning/spawning
// Params 1, eflags: 0x1 linked
// Checksum 0xdc5da74f, Offset: 0x11f8
// Size: 0x44
function enable_player_influencers(enabled) {
    if (!isdefined(self.influencers)) {
        self create_player_influencers();
    }
    self enable_influencers(enabled);
}

// Namespace spawning/spawning
// Params 0, eflags: 0x1 linked
// Checksum 0xb8305742, Offset: 0x1248
// Size: 0x1b8
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
// Params 3, eflags: 0x1 linked
// Checksum 0x5ad18d28, Offset: 0x1408
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
// Params 0, eflags: 0x1 linked
// Checksum 0x5c05961e, Offset: 0x1520
// Size: 0x74
function create_map_placed_influencers() {
    staticinfluencerents = getentarray("mp_uspawn_influencer", "classname");
    for (i = 0; i < staticinfluencerents.size; i++) {
        staticinfluencerent = staticinfluencerents[i];
        create_map_placed_influencer(staticinfluencerent);
    }
}

// Namespace spawning/spawning
// Params 1, eflags: 0x1 linked
// Checksum 0xcf887409, Offset: 0x15a0
// Size: 0x98
function create_map_placed_influencer(influencer_entity) {
    influencer_id = -1;
    if (isdefined(influencer_entity.script_noteworty)) {
        team_mask = util::getteammask(influencer_entity.script_team);
        level create_enemy_influencer(influencer_entity.script_noteworty, influencer_entity.origin, team_mask);
    } else {
        assertmsg("<dev string:x3c>");
    }
    return influencer_id;
}

// Namespace spawning/spawning
// Params 0, eflags: 0x0
// Checksum 0xf4c03e49, Offset: 0x1640
// Size: 0x1bc
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
            spawnlogic::addspawnpoints(#"none", level.unified_spawn_points[team].a);
        }
    }
    remove_unused_spawn_entities();
}

// Namespace spawning/spawning
// Params 1, eflags: 0x1 linked
// Checksum 0xf42d9d91, Offset: 0x1808
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
    if (usestartspawns()) {
        use_new_spawn_system = 0;
    }
    if (level.gametype == "sd") {
        use_new_spawn_system = 0;
    }
    function_5ac4dc99("scr_spawn_force_unified", "0");
    [[ level.onspawnplayer ]](predictedspawn);
    if (!predictedspawn) {
        self.uspawn_already_spawned = 1;
    }
}

// Namespace spawning/spawning
// Params 2, eflags: 0x0
// Checksum 0xab0d0f3, Offset: 0x1958
// Size: 0x13a
function getspawnpoint(player_entity, predictedspawn = 0) {
    if (level.teambased) {
        point_team = player_entity.pers[#"team"];
        influencer_team = player_entity.pers[#"team"];
    } else {
        point_team = #"none";
        influencer_team = #"none";
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
// Checksum 0xef41dd0a, Offset: 0x1aa0
// Size: 0x25a
function get_debug_spawnpoint(player) {
    if (level.teambased) {
        team = player.pers[#"team"];
    } else {
        team = #"none";
    }
    index = level.test_spawn_point_index;
    level.test_spawn_point_index++;
    if (team == #"none") {
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
// Params 4, eflags: 0x1 linked
// Checksum 0xcc05a51e, Offset: 0x1d08
// Size: 0x188
function get_best_spawnpoint(point_team, influencer_team, player, predictedspawn) {
    if (level.teambased) {
        vis_team_mask = util::getotherteamsmask(player.pers[#"team"]);
    } else {
        vis_team_mask = level.spawnsystem.ispawn_teammask_free;
    }
    spawn_point = getbestspawnpoint(point_team, influencer_team, vis_team_mask, player, predictedspawn);
    if (!predictedspawn) {
        var_48eba3a3 = {#reason:"point used", #var_c734ddf2:getplayerspawnid(player), #x:spawn_point[#"origin"][0], #y:spawn_point[#"origin"][1], #z:spawn_point[#"origin"][2]};
        function_92d1707f(#"hash_263d9506f7e11fdd", var_48eba3a3);
    }
    return spawn_point;
}

// Namespace spawning/spawning
// Params 1, eflags: 0x1 linked
// Checksum 0x4e862f2b, Offset: 0x1e98
// Size: 0xb4
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
// Checksum 0xa6188390, Offset: 0x1f58
// Size: 0x20
function is_hardcore() {
    return isdefined(level.hardcoremode) && level.hardcoremode;
}

// Namespace spawning/spawning
// Params 2, eflags: 0x0
// Checksum 0x4f020a9, Offset: 0x1f80
// Size: 0x82
function teams_have_enmity(team1, team2) {
    if (!isdefined(team1) || !isdefined(team2) || level.gametype == "dm") {
        return true;
    }
    return team1 != #"neutral" && team2 != #"neutral" && team1 != team2;
}

// Namespace spawning/spawning
// Params 0, eflags: 0x1 linked
// Checksum 0x60d5d870, Offset: 0x2010
// Size: 0x21c
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
// Params 1, eflags: 0x1 linked
// Checksum 0x25375111, Offset: 0x2238
// Size: 0x44
function delete_all_spawns(spawnpoints) {
    for (i = 0; i < spawnpoints.size; i++) {
        spawnpoints[i] delete();
    }
}

// Namespace spawning/spawning
// Params 1, eflags: 0x1 linked
// Checksum 0x79752440, Offset: 0x2288
// Size: 0x6a
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
// Checksum 0x980bbf12, Offset: 0x2300
// Size: 0xe4
function initialspawnprotection(specialtyname, *spawnmonitorspeed) {
    self endon(#"death", #"disconnect");
    if (!isdefined(level.spawnprotectiontime) || level.spawnprotectiontime == 0) {
        return;
    }
    if (spawnmonitorspeed == "specialty_nottargetedbyairsupport") {
        self.specialty_nottargetedbyairsupport = 1;
        wait level.spawnprotectiontime;
        self.specialty_nottargetedbyairsupport = undefined;
        return;
    }
    if (!self hasperk(spawnmonitorspeed)) {
        self setperk(spawnmonitorspeed);
        wait level.spawnprotectiontime;
        self unsetperk(spawnmonitorspeed);
    }
}

