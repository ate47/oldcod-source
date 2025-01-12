#using scripts/core_common/array_shared;
#using scripts/core_common/callbacks_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;

#namespace influencers;

// Namespace influencers/influencers_shared
// Params 0, eflags: 0x2
// Checksum 0x69bcfeb8, Offset: 0x210
// Size: 0x34
function autoexec __init__sytem__() {
    system::register("influencers_shared", &__init__, undefined, undefined);
}

// Namespace influencers/influencers_shared
// Params 0, eflags: 0x0
// Checksum 0x29fdbcfb, Offset: 0x250
// Size: 0x24
function __init__() {
    callback::on_connecting(&onplayerconnect);
}

// Namespace influencers/influencers_shared
// Params 0, eflags: 0x0
// Checksum 0x603b17ea, Offset: 0x280
// Size: 0x54
function onplayerconnect() {
    level endon(#"game_ended");
    self thread onplayerspawned();
    self thread onteamchange();
    self thread ongrenadethrow();
}

// Namespace influencers/influencers_shared
// Params 0, eflags: 0x0
// Checksum 0x9088a1c1, Offset: 0x2e0
// Size: 0x48
function onplayerspawned() {
    self endon(#"disconnect");
    level endon(#"game_ended");
    for (;;) {
        self waittill("spawned_player");
        self thread ondeath();
    }
}

// Namespace influencers/influencers_shared
// Params 0, eflags: 0x0
// Checksum 0x2850e18f, Offset: 0x330
// Size: 0x5c
function ondeath() {
    self endon(#"disconnect");
    level endon(#"game_ended");
    self waittill("death");
    level create_friendly_influencer("friend_dead", self.origin, self.team);
}

// Namespace influencers/influencers_shared
// Params 0, eflags: 0x0
// Checksum 0x6cde4221, Offset: 0x398
// Size: 0x76
function onteamchange() {
    self endon(#"disconnect");
    level endon(#"game_ended");
    while (true) {
        self waittill("joined_team");
        self.lastspawnpoint = undefined;
        removeallinfluencersfromentity(self);
        self create_player_influencers();
        waitframe(1);
    }
}

// Namespace influencers/influencers_shared
// Params 0, eflags: 0x0
// Checksum 0x21d40df9, Offset: 0x418
// Size: 0xb6
function ongrenadethrow() {
    self endon(#"disconnect");
    level endon(#"game_ended");
    while (true) {
        waitresult = self waittill("grenade_fire");
        grenade = waitresult.projectile;
        weapon = waitresult.weapon;
        level thread create_grenade_influencers(self.pers["team"], weapon, grenade);
        waitframe(1);
    }
}

// Namespace influencers/influencers_shared
// Params 1, eflags: 0x0
// Checksum 0xb0e761b0, Offset: 0x4d8
// Size: 0x60
function get_friendly_team_mask(team) {
    if (level.teambased) {
        team_mask = util::getteammask(team);
    } else {
        team_mask = level.spawnsystem.ispawn_teammask_free;
    }
    return team_mask;
}

// Namespace influencers/influencers_shared
// Params 1, eflags: 0x0
// Checksum 0xcf01692b, Offset: 0x540
// Size: 0x60
function get_enemy_team_mask(team) {
    if (level.teambased) {
        team_mask = util::getotherteamsmask(team);
    } else {
        team_mask = level.spawnsystem.ispawn_teammask_free;
    }
    return team_mask;
}

// Namespace influencers/influencers_shared
// Params 2, eflags: 0x4
// Checksum 0x2490d960, Offset: 0x5a8
// Size: 0x108
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
// Checksum 0x2bf1058e, Offset: 0x6b8
// Size: 0x170
function create_influencer_generic(str_name, origin_or_entity, str_team, is_for_enemy) {
    if (!isdefined(is_for_enemy)) {
        is_for_enemy = 0;
    }
    if (str_team === "any") {
        team_mask = level.spawnsystem.ispawn_teammask["all"];
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
// Checksum 0xca0e8f39, Offset: 0x830
// Size: 0x3a
function create_influencer(name, origin, team_mask) {
    return addinfluencer(name, origin, team_mask);
}

// Namespace influencers/influencers_shared
// Params 3, eflags: 0x0
// Checksum 0xd590210c, Offset: 0x878
// Size: 0x6c
function create_friendly_influencer(name, origin, team) {
    team_mask = self get_friendly_team_mask(team);
    influencer = create_influencer(name, origin, team_mask);
    return influencer;
}

// Namespace influencers/influencers_shared
// Params 3, eflags: 0x0
// Checksum 0x991833a5, Offset: 0x8f0
// Size: 0x6c
function create_enemy_influencer(name, origin, team) {
    team_mask = self get_enemy_team_mask(team);
    influencer = create_influencer(name, origin, team_mask);
    return influencer;
}

// Namespace influencers/influencers_shared
// Params 2, eflags: 0x0
// Checksum 0x8c149925, Offset: 0x968
// Size: 0x32
function create_entity_influencer(name, team_mask) {
    return addentityinfluencer(name, self, team_mask);
}

// Namespace influencers/influencers_shared
// Params 2, eflags: 0x0
// Checksum 0xab16e0cc, Offset: 0x9a8
// Size: 0x52
function create_entity_friendly_influencer(name, team) {
    team_mask = self get_friendly_team_mask(team);
    return self create_entity_influencer(name, team_mask);
}

// Namespace influencers/influencers_shared
// Params 2, eflags: 0x0
// Checksum 0x4ef04318, Offset: 0xa08
// Size: 0x52
function create_entity_enemy_influencer(name, team) {
    team_mask = self get_enemy_team_mask(team);
    return self create_entity_influencer(name, team_mask);
}

// Namespace influencers/influencers_shared
// Params 0, eflags: 0x0
// Checksum 0x8370eeea, Offset: 0xa68
// Size: 0x1d4
function create_player_influencers() {
    if (!isdefined(self.pers["team"]) || self.pers["team"] == "spectator") {
        return;
    }
    if (self.influencers_created === 0) {
        return;
    }
    if (!level.teambased) {
        team_mask = level.spawnsystem.ispawn_teammask_free;
        enemy_teams_mask = level.spawnsystem.ispawn_teammask_free;
    } else if (isdefined(self.pers["team"])) {
        team = self.pers["team"];
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
// Checksum 0x49f6076f, Offset: 0xc48
// Size: 0x6c
function create_player_spawn_influencers(spawn_origin) {
    level create_enemy_influencer("enemy_spawn", spawn_origin, self.pers["team"]);
    level create_friendly_influencer("friendly_spawn", spawn_origin, self.pers["team"]);
}

// Namespace influencers/influencers_shared
// Params 1, eflags: 0x4
// Checksum 0x44ac689c, Offset: 0xcc0
// Size: 0xaa
function private remove_influencer_tracking(to_be_removed) {
    if (isdefined(self.influencers)) {
        foreach (influencer_name_array in self.influencers) {
            arrayremovevalue(influencer_name_array, to_be_removed);
        }
    }
}

// Namespace influencers/influencers_shared
// Params 1, eflags: 0x4
// Checksum 0x23a89a4, Offset: 0xd78
// Size: 0xb4
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
// Checksum 0x2ed10629, Offset: 0xe38
// Size: 0x54
function remove_influencer(to_be_removed) {
    if (is_influencer_tracked(to_be_removed)) {
        self remove_influencer_tracking(to_be_removed);
        removeinfluencer(to_be_removed);
    }
}

// Namespace influencers/influencers_shared
// Params 0, eflags: 0x0
// Checksum 0x857384bb, Offset: 0xe98
// Size: 0x164
function remove_influencers() {
    if (isentity(self)) {
        removeallinfluencersfromentity(self);
    }
    if (isdefined(self.influencers)) {
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
// Checksum 0x4197a522, Offset: 0x1008
// Size: 0x124
function create_grenade_influencers(parent_team, weapon, grenade) {
    pixbeginevent("create_grenade_influencers");
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
        grenade create_entity_influencer(spawn_influencer, weapon_team_mask);
    }
    pixendevent();
}

// Namespace influencers/influencers_shared
// Params 0, eflags: 0x0
// Checksum 0xc3d8c42d, Offset: 0x1138
// Size: 0x86
function create_map_placed_influencers() {
    staticinfluencerents = getentarray("mp_uspawn_influencer", "classname");
    for (i = 0; i < staticinfluencerents.size; i++) {
        staticinfluencerent = staticinfluencerents[i];
        create_map_placed_influencer(staticinfluencerent);
    }
}

// Namespace influencers/influencers_shared
// Params 1, eflags: 0x0
// Checksum 0x125f9a35, Offset: 0x11c8
// Size: 0xb0
function create_map_placed_influencer(influencer_entity) {
    influencer_id = -1;
    if (isdefined(influencer_entity.script_noteworty)) {
        team_mask = util::getteammask(influencer_entity.script_team);
        level create_enemy_influencer(influencer_entity.script_noteworty, influencer_entity.origin, team_mask);
    } else {
        assertmsg("<dev string:x28>");
    }
    return influencer_id;
}

