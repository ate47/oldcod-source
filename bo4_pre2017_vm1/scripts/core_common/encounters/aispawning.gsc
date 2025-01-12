#using scripts/core_common/array_shared;
#using scripts/core_common/callbacks_shared;
#using scripts/core_common/flag_shared;
#using scripts/core_common/influencers_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;

#namespace aispawning;

// Namespace aispawning/aispawning
// Params 0, eflags: 0x2
// Checksum 0xc88b36fc, Offset: 0x200
// Size: 0x34
function autoexec __init__sytem__() {
    system::register("aispawning", &__init__, undefined, undefined);
}

// Namespace aispawning/aispawning
// Params 0, eflags: 0x0
// Checksum 0x85a41858, Offset: 0x240
// Size: 0xac
function __init__() {
    level.a_ai_spawn_points = [];
    level flag::init("ai_spawnpoints_dirty");
    level thread ai_spawn_system_think();
    init_ai_spawn_points();
    init_ai_spawn_triggers();
    callback::on_ai_spawned(&on_ai_spawned);
    callback::on_ai_killed(&on_ai_killed);
}

// Namespace aispawning/aispawning
// Params 0, eflags: 0x4
// Checksum 0x278f3301, Offset: 0x2f8
// Size: 0x1c
function private on_ai_spawned() {
    self thread add_ai_influencers(self);
}

// Namespace aispawning/aispawning
// Params 1, eflags: 0x4
// Checksum 0x6aba68e1, Offset: 0x320
// Size: 0x24
function private on_ai_killed(params) {
    self thread add_ai_death_influencers(self);
}

// Namespace aispawning/aispawning
// Params 1, eflags: 0x4
// Checksum 0x70f500e4, Offset: 0x350
// Size: 0x10c
function private add_ai_influencers(e_ai) {
    e_ai endon(#"death");
    wait 1;
    level influencers::create_friendly_influencer("ai_spawn_friendly", e_ai.origin, e_ai.team);
    level influencers::create_enemy_influencer("ai_spawn_enemy", e_ai.origin, e_ai.team);
    if (isdefined(e_ai.spawninfluencerfriendly)) {
        e_ai influencers::create_entity_friendly_influencer(e_ai.spawninfluencerfriendly, e_ai.team);
    }
    if (isdefined(e_ai.spawninfluencerenemy)) {
        e_ai influencers::create_entity_enemy_influencer(e_ai.spawninfluencerenemy, e_ai.team);
    }
}

// Namespace aispawning/aispawning
// Params 1, eflags: 0x4
// Checksum 0x14fdd027, Offset: 0x468
// Size: 0x44
function private add_ai_death_influencers(e_ai) {
    level influencers::create_friendly_influencer("ai_death_friendly", e_ai.origin, e_ai.team);
}

// Namespace aispawning/aispawning
// Params 0, eflags: 0x4
// Checksum 0x332171d3, Offset: 0x4b8
// Size: 0x60
function private ai_spawn_system_think() {
    while (true) {
        level flag::wait_till("ai_spawnpoints_dirty");
        add_ai_spawn_points();
        level flag::clear("ai_spawnpoints_dirty");
    }
}

// Namespace aispawning/aispawning
// Params 0, eflags: 0x4
// Checksum 0x471907fd, Offset: 0x520
// Size: 0x43c
function private init_ai_spawn_points() {
    a_spawners = getspawnerarray();
    a_archetypes = [];
    foreach (o_spawner in a_spawners) {
        if (!isinarray(a_archetypes, o_spawner.archetype)) {
            if (!isdefined(a_archetypes)) {
                a_archetypes = [];
            } else if (!isarray(a_archetypes)) {
                a_archetypes = array(a_archetypes);
            }
            a_archetypes[a_archetypes.size] = o_spawner.archetype;
        }
    }
    foreach (o_archetype in a_archetypes) {
        foreach (o_spawner in a_spawners) {
            if (o_archetype == o_spawner.archetype) {
                if (!isdefined(level.a_ai_spawn_points[o_archetype])) {
                    level.a_ai_spawn_points[o_archetype] = [];
                }
                if (!isdefined(level.a_ai_spawn_points[o_archetype][o_spawner.team])) {
                    level.a_ai_spawn_points[o_archetype][o_spawner.team] = [];
                }
                if (!isdefined(level.a_ai_spawn_points[o_archetype][o_spawner.team])) {
                    level.a_ai_spawn_points[o_archetype][o_spawner.team] = [];
                } else if (!isarray(level.a_ai_spawn_points[o_archetype][o_spawner.team])) {
                    level.a_ai_spawn_points[o_archetype][o_spawner.team] = array(level.a_ai_spawn_points[o_archetype][o_spawner.team]);
                }
                if (!isinarray(level.a_ai_spawn_points[o_archetype][o_spawner.team], o_spawner)) {
                    level.a_ai_spawn_points[o_archetype][o_spawner.team][level.a_ai_spawn_points[o_archetype][o_spawner.team].size] = o_spawner;
                }
                if (isdefined(o_spawner.script_start_disabled) && o_spawner.script_start_disabled) {
                    o_spawner.sp_disabled = 1;
                }
            }
        }
    }
    level flag::set("ai_spawnpoints_dirty");
}

// Namespace aispawning/aispawning
// Params 0, eflags: 0x4
// Checksum 0x3f04f8a9, Offset: 0x968
// Size: 0x318
function private add_ai_spawn_points() {
    a_archetypes = getarraykeys(level.a_ai_spawn_points);
    a_spawnlists = getspawnlists();
    foreach (str_archetype in a_archetypes) {
        if (!isinarray(a_spawnlists, str_archetype)) {
            continue;
        }
        a_teams = getarraykeys(level.a_ai_spawn_points[str_archetype]);
        foreach (str_team in a_teams) {
            a_enabled_spawn_points = [];
            foreach (spawn_point in level.a_ai_spawn_points[str_archetype][str_team]) {
                if (isdefined(spawn_point)) {
                    if (!(isdefined(spawn_point.sp_disabled) && spawn_point.sp_disabled)) {
                        spawn_point.enabled = -1;
                    } else {
                        spawn_point.enabled = 0;
                    }
                    if (!isdefined(a_enabled_spawn_points)) {
                        a_enabled_spawn_points = [];
                    } else if (!isarray(a_enabled_spawn_points)) {
                        a_enabled_spawn_points = array(a_enabled_spawn_points);
                    }
                    if (!isinarray(a_enabled_spawn_points, spawn_point)) {
                        a_enabled_spawn_points[a_enabled_spawn_points.size] = spawn_point;
                    }
                }
            }
            if (a_enabled_spawn_points.size) {
                addspawnpoints(str_team, level.a_ai_spawn_points[str_archetype][str_team], str_archetype);
            }
        }
    }
}

// Namespace aispawning/aispawning
// Params 0, eflags: 0x4
// Checksum 0x3718bbaa, Offset: 0xc88
// Size: 0xda
function private init_ai_spawn_triggers() {
    a_trigger = getentarraybytype(23);
    foreach (o_trigger in a_trigger) {
        if (isdefined(o_trigger.script_spawn_enable) || isdefined(o_trigger.script_spawn_disable)) {
            o_trigger thread ai_spawn_trigger_think(o_trigger);
        }
    }
}

// Namespace aispawning/aispawning
// Params 1, eflags: 0x4
// Checksum 0x2d1d51ce, Offset: 0xd70
// Size: 0x394
function private ai_spawn_trigger_think(trigger) {
    trigger endon(#"death");
    trigger waittill("trigger");
    b_mark_dirty_flag = 0;
    a_archetypes = getarraykeys(level.a_ai_spawn_points);
    foreach (str_archetype in a_archetypes) {
        a_teams = getarraykeys(level.a_ai_spawn_points[str_archetype]);
        foreach (str_team in a_teams) {
            spawn_points = level.a_ai_spawn_points[str_archetype][str_team];
            if (isdefined(trigger.script_spawn_enable)) {
                foreach (spawn_point in spawn_points) {
                    if (isdefined(spawn_point)) {
                        if (spawn_point.script_spawn_enable === trigger.script_spawn_enable) {
                            if (isdefined(spawn_point.sp_disabled) && spawn_point.sp_disabled) {
                                b_mark_dirty_flag = 1;
                                spawn_point.sp_disabled = 0;
                            }
                        }
                    }
                }
            }
            if (isdefined(trigger.script_spawn_disable)) {
                foreach (spawn_point in spawn_points) {
                    if (isdefined(spawn_point)) {
                        if (spawn_point.script_spawn_disable === trigger.script_spawn_disable) {
                            if (!(isdefined(spawn_point.sp_disabled) && spawn_point.sp_disabled)) {
                                b_mark_dirty_flag = 1;
                                spawn_point.sp_disabled = 1;
                            }
                        }
                    }
                }
            }
        }
        waitframe(1);
    }
    if (b_mark_dirty_flag) {
        level flag::set("ai_spawnpoints_dirty");
    }
}

// Namespace aispawning/aispawning
// Params 2, eflags: 0x4
// Checksum 0x9c494976, Offset: 0x1110
// Size: 0x190
function private ai_spawnpoints_exist(str_archetype, str_team) {
    b_found_potential_spawn_points = 0;
    a_archetypes = getarraykeys(level.a_ai_spawn_points);
    if (isinarray(a_archetypes, str_archetype)) {
        a_teams = getarraykeys(level.a_ai_spawn_points[str_archetype]);
        if (isinarray(a_teams, str_team)) {
            foreach (spawn_point in level.a_ai_spawn_points[str_archetype][str_team]) {
                if (isdefined(spawn_point) && !(isdefined(spawn_point.sp_disabled) && spawn_point.sp_disabled)) {
                    b_found_potential_spawn_points = 1;
                    break;
                }
            }
        }
    }
    if (b_found_potential_spawn_points) {
        return true;
    }
    return false;
}

#namespace aispawningutility;

// Namespace aispawningutility/aispawning
// Params 3, eflags: 0x0
// Checksum 0x186d112e, Offset: 0x12a8
// Size: 0x378
function get_best_ai_spawnpoint_for_classname(str_classname, str_team, spawn_point_targetname) {
    str_influencer_team = str_team;
    str_point_team = str_team;
    vis_team_mask = util::getotherteamsmask(str_team);
    str_archetype_name = getarchetypefromclassname(str_classname);
    if (isdefined(spawn_point_targetname)) {
        targetted_spawners = getentarray(spawn_point_targetname, "targetname");
        fitting_targetted_spawn_points = [];
        foreach (o_spawner in targetted_spawners) {
            if (isspawner(o_spawner) && str_archetype_name === o_spawner.archetype) {
                if (!isdefined(fitting_targetted_spawn_points)) {
                    fitting_targetted_spawn_points = [];
                } else if (!isarray(fitting_targetted_spawn_points)) {
                    fitting_targetted_spawn_points = array(fitting_targetted_spawn_points);
                }
                if (!isinarray(fitting_targetted_spawn_points, o_spawner)) {
                    fitting_targetted_spawn_points[fitting_targetted_spawn_points.size] = o_spawner;
                }
            }
        }
        if (fitting_targetted_spawn_points.size) {
            a_lists = [];
            if (!isdefined(a_lists)) {
                a_lists = [];
            } else if (!isarray(a_lists)) {
                a_lists = array(a_lists);
            }
            a_lists[a_lists.size] = "wavemanager";
            clearspawnpoints("wavemanager");
            addspawnpoints(str_team, fitting_targetted_spawn_points, "wavemanager");
            spawn_point = getbestspawnpoint(str_point_team, str_influencer_team, vis_team_mask, undefined, 0, a_lists);
            return spawn_point;
        }
    } else if (aispawning::ai_spawnpoints_exist(str_archetype_name, str_team)) {
        a_lists = [];
        if (!isdefined(a_lists)) {
            a_lists = [];
        } else if (!isarray(a_lists)) {
            a_lists = array(a_lists);
        }
        a_lists[a_lists.size] = str_archetype_name;
        spawn_point = getbestspawnpoint(str_point_team, str_influencer_team, vis_team_mask, undefined, 0, a_lists);
        return spawn_point;
    }
    return undefined;
}

