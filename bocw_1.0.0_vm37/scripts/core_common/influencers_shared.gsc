#using scripts\core_common\callbacks_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace influencers;

// Namespace influencers/influencers_shared
// Params 0, eflags: 0x6
// Checksum 0xfee9aa27, Offset: 0x108
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"influencers_shared", &preinit, undefined, undefined, undefined);
}

// Namespace influencers/influencers_shared
// Params 0, eflags: 0x4
// Checksum 0xd850fdd9, Offset: 0x150
// Size: 0x104
function private preinit() {
    if (!isdefined(level.var_3d984b4c)) {
        level.var_3d984b4c = 1;
    }
    sessionmode = currentsessionmode();
    level.var_a3e7732d = sessionmode == 1 || sessionmode == 3;
    if (level.var_3d984b4c && level.var_a3e7732d) {
        callback::on_grenade_fired(&on_grenade_fired);
        callback::on_player_killed(&on_player_death);
        callback::on_joined_team(&on_joined_team);
        callback::on_spawned(&on_spawned);
    }
}

// Namespace influencers/influencers_shared
// Params 0, eflags: 0x0
// Checksum 0x28baea70, Offset: 0x260
// Size: 0x34
function on_spawned() {
    removeallinfluencersfromentity(self);
    self create_player_influencers();
}

// Namespace influencers/influencers_shared
// Params 1, eflags: 0x0
// Checksum 0xe8611ddf, Offset: 0x2a0
// Size: 0x54
function on_player_death(*params) {
    if (game.state != #"playing") {
        return;
    }
    level create_friendly_influencer("friend_dead", self.origin, self.team);
}

// Namespace influencers/influencers_shared
// Params 1, eflags: 0x0
// Checksum 0x3288274, Offset: 0x300
// Size: 0x16
function on_joined_team(*params) {
    self.lastspawnpoint = undefined;
}

// Namespace influencers/influencers_shared
// Params 1, eflags: 0x0
// Checksum 0x36d1f896, Offset: 0x320
// Size: 0x84
function on_grenade_fired(params) {
    grenade = params.projectile;
    weapon = params.weapon;
    team = undefined;
    if (isdefined(self.pers)) {
        team = self.pers[#"team"];
    }
    level thread create_grenade_influencers(team, weapon, grenade);
}

// Namespace influencers/influencers_shared
// Params 1, eflags: 0x0
// Checksum 0xd8c7b06e, Offset: 0x3b0
// Size: 0x52
function get_friendly_team_mask(team) {
    if (level.teambased) {
        team_mask = util::getteammask(team);
    } else {
        team_mask = level.spawnsystem.var_c2989de;
    }
    return team_mask;
}

// Namespace influencers/influencers_shared
// Params 1, eflags: 0x0
// Checksum 0xd6a12315, Offset: 0x410
// Size: 0x52
function get_enemy_team_mask(team) {
    if (level.teambased) {
        team_mask = util::getotherteamsmask(team);
    } else {
        team_mask = level.spawnsystem.var_c2989de;
    }
    return team_mask;
}

// Namespace influencers/influencers_shared
// Params 2, eflags: 0x4
// Checksum 0xf1c73b31, Offset: 0x470
// Size: 0xde
function private add_influencer_tracker(influencer, name) {
    if (!isdefined(self.influencers)) {
        self.influencers = [];
    }
    if (!isdefined(self.influencers[name])) {
        self.influencers[name] = [];
    }
    if (!isdefined(self.influencers[name])) {
        self.influencers[name] = [];
    } else if (!isarray(self.influencers[name])) {
        self.influencers[name] = array(self.influencers[name]);
    }
    self.influencers[name][self.influencers[name].size] = influencer;
}

// Namespace influencers/influencers_shared
// Params 4, eflags: 0x0
// Checksum 0x3379f5fd, Offset: 0x558
// Size: 0x178
function create_influencer_generic(str_name, origin_or_entity, str_team, is_for_enemy = 0) {
    if (!is_true(level.var_3d984b4c)) {
        return;
    }
    if (str_team === #"any") {
        team_mask = level.spawnsystem.ispawn_teammask[#"all"];
    } else if (is_for_enemy) {
        team_mask = self get_enemy_team_mask(str_team);
    } else {
        team_mask = self get_friendly_team_mask(str_team);
    }
    if (isentity(origin_or_entity)) {
        influencer = addentityinfluencer(str_name, origin_or_entity, team_mask);
    } else if (isvec(origin_or_entity)) {
        influencer = addinfluencer(str_name, origin_or_entity, team_mask);
    }
    if (!isentity(origin_or_entity)) {
        self add_influencer_tracker(influencer, str_name);
    }
    return influencer;
}

// Namespace influencers/influencers_shared
// Params 3, eflags: 0x0
// Checksum 0x73f5dd86, Offset: 0x6d8
// Size: 0x4c
function create_influencer(name, origin, team_mask) {
    if (is_true(level.var_3d984b4c)) {
        return addinfluencer(name, origin, team_mask);
    }
}

// Namespace influencers/influencers_shared
// Params 3, eflags: 0x0
// Checksum 0xd45c7ab4, Offset: 0x730
// Size: 0x62
function create_friendly_influencer(name, origin, team) {
    team_mask = self get_friendly_team_mask(team);
    influencer = create_influencer(name, origin, team_mask);
    return influencer;
}

// Namespace influencers/influencers_shared
// Params 3, eflags: 0x0
// Checksum 0x3cb7c70c, Offset: 0x7a0
// Size: 0x62
function create_enemy_influencer(name, origin, team) {
    team_mask = self get_enemy_team_mask(team);
    influencer = create_influencer(name, origin, team_mask);
    return influencer;
}

// Namespace influencers/influencers_shared
// Params 2, eflags: 0x0
// Checksum 0x9d34de6a, Offset: 0x810
// Size: 0x4c
function create_entity_influencer(name, team_mask) {
    if (is_true(level.var_3d984b4c)) {
        return addentityinfluencer(name, self, team_mask);
    }
}

// Namespace influencers/influencers_shared
// Params 3, eflags: 0x0
// Checksum 0x92687062, Offset: 0x868
// Size: 0x4c
function function_f15009ad(name, origin, var_f317c70c) {
    if (is_true(level.var_3d984b4c)) {
        return function_a116c91b(name, origin, var_f317c70c);
    }
}

// Namespace influencers/influencers_shared
// Params 2, eflags: 0x0
// Checksum 0x53aa9b5c, Offset: 0x8c0
// Size: 0x5a
function create_entity_friendly_influencer(name, team) {
    team_mask = self get_friendly_team_mask(team);
    influencer = create_entity_influencer(name, team_mask);
    return influencer;
}

// Namespace influencers/influencers_shared
// Params 2, eflags: 0x0
// Checksum 0xe57d52cb, Offset: 0x928
// Size: 0x5a
function create_entity_enemy_influencer(name, team) {
    team_mask = self get_enemy_team_mask(team);
    influencer = create_entity_influencer(name, team_mask);
    return influencer;
}

// Namespace influencers/influencers_shared
// Params 0, eflags: 0x0
// Checksum 0xec42c6d9, Offset: 0x990
// Size: 0x1ea
function create_player_influencers() {
    if (!is_true(level.var_3d984b4c)) {
        return;
    }
    if (!isdefined(self.pers[#"team"]) || self.pers[#"team"] == #"spectator") {
        return;
    }
    if (self.influencers_created === 0) {
        return;
    }
    if (!level.teambased) {
        team_mask = level.spawnsystem.var_c2989de;
        enemy_teams_mask = level.spawnsystem.var_c2989de;
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
    self create_entity_influencer("enemy", enemy_teams_mask);
    if (level.teambased) {
        self create_entity_influencer("friend", team_mask);
    }
    self.influencers_created = 1;
}

// Namespace influencers/influencers_shared
// Params 1, eflags: 0x0
// Checksum 0x43dc515, Offset: 0xb88
// Size: 0x7c
function create_player_spawn_influencers(spawn_origin) {
    level create_enemy_influencer("enemy_spawn", spawn_origin, self.pers[#"team"]);
    level create_friendly_influencer("friendly_spawn", spawn_origin, self.pers[#"team"]);
}

// Namespace influencers/influencers_shared
// Params 1, eflags: 0x4
// Checksum 0x57fe1aa8, Offset: 0xc10
// Size: 0xa0
function private remove_influencer_tracking(to_be_removed) {
    if (isdefined(self.influencers)) {
        foreach (influencer_name_array in self.influencers) {
            arrayremovevalue(influencer_name_array, to_be_removed);
        }
    }
}

// Namespace influencers/influencers_shared
// Params 1, eflags: 0x4
// Checksum 0x2b1a9edb, Offset: 0xcb8
// Size: 0xaa
function private is_influencer_tracked(influencer) {
    if (isdefined(self.influencers)) {
        foreach (influencer_name_array in self.influencers) {
            if (isinarray(influencer_name_array, influencer)) {
                return true;
            }
        }
    }
    return false;
}

// Namespace influencers/influencers_shared
// Params 1, eflags: 0x0
// Checksum 0xa8ec5a83, Offset: 0xd70
// Size: 0x6c
function remove_influencer(to_be_removed) {
    if (is_true(level.var_3d984b4c)) {
        if (is_influencer_tracked(to_be_removed)) {
            self remove_influencer_tracking(to_be_removed);
        }
        removeinfluencer(to_be_removed);
    }
}

// Namespace influencers/influencers_shared
// Params 0, eflags: 0x0
// Checksum 0x92c14a71, Offset: 0xde8
// Size: 0x17e
function remove_influencers() {
    if (!isdefined(self)) {
        return;
    }
    if (!is_true(level.var_3d984b4c)) {
        return;
    }
    if (isentity(self)) {
        removeallinfluencersfromentity(self);
    } else if (isdefined(self.influencers)) {
        foreach (influencer_name_array in self.influencers) {
            foreach (influencer in influencer_name_array) {
                self remove_influencer_tracking(influencer);
                removeinfluencer(influencer);
            }
        }
    }
    self.influencers = [];
}

// Namespace influencers/influencers_shared
// Params 3, eflags: 0x0
// Checksum 0xa2ad2e28, Offset: 0xf70
// Size: 0x11e
function create_grenade_influencers(parent_team, weapon, grenade) {
    if (!is_true(level.var_3d984b4c)) {
        return;
    }
    pixbeginevent(#"");
    spawn_influencer = weapon.spawninfluencer;
    if (isdefined(grenade.origin) && spawn_influencer != "" && isdefined(level.spawnsystem)) {
        if (!level.teambased || !isdefined(parent_team)) {
            weapon_team_mask = level.spawnsystem.var_c2989de;
        } else {
            weapon_team_mask = util::getotherteamsmask(parent_team);
            if (level.friendlyfire) {
                weapon_team_mask |= util::getteammask(parent_team);
            }
        }
        grenade create_entity_influencer(spawn_influencer, weapon_team_mask);
    }
    profilestop();
}

// Namespace influencers/influencers_shared
// Params 0, eflags: 0x0
// Checksum 0x1b266005, Offset: 0x1098
// Size: 0x94
function create_map_placed_influencers() {
    if (!is_true(level.var_3d984b4c)) {
        return;
    }
    staticinfluencerents = getentarray("mp_uspawn_influencer", "classname");
    for (i = 0; i < staticinfluencerents.size; i++) {
        staticinfluencerent = staticinfluencerents[i];
        create_map_placed_influencer(staticinfluencerent);
    }
}

// Namespace influencers/influencers_shared
// Params 1, eflags: 0x0
// Checksum 0x5041da46, Offset: 0x1138
// Size: 0xb8
function create_map_placed_influencer(influencer_entity) {
    if (!is_true(level.var_3d984b4c)) {
        return;
    }
    influencer_id = -1;
    if (isdefined(influencer_entity.script_noteworty)) {
        team_mask = util::getteammask(influencer_entity.script_team);
        level create_enemy_influencer(influencer_entity.script_noteworty, influencer_entity.origin, team_mask);
    } else {
        assertmsg("<dev string:x38>");
    }
    return influencer_id;
}

// Namespace influencers/influencers_shared
// Params 1, eflags: 0x0
// Checksum 0xc66f9971, Offset: 0x11f8
// Size: 0xda
function create_turret_influencer(name) {
    if (!is_true(level.var_3d984b4c)) {
        return;
    }
    turret = self;
    preset = getinfluencerpreset(name);
    if (!isdefined(preset)) {
        return;
    }
    projected_point = turret.origin + vectorscale(anglestoforward(turret.angles), preset[#"radius"] * 0.7);
    return create_enemy_influencer(name, turret.origin, turret.team);
}

