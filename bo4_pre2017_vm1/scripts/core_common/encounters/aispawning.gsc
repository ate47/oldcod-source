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
function autoexec function_2dc19561() {
    system::register("aispawning", &__init__, undefined, undefined);
}

// Namespace aispawning/aispawning
// Params 0, eflags: 0x0
// Checksum 0x85a41858, Offset: 0x240
// Size: 0xac
function __init__() {
    level.var_e2e1cfef = [];
    level flag::init("ai_spawnpoints_dirty");
    level thread function_627e3834();
    function_8c878f2a();
    function_30e81628();
    callback::on_ai_spawned(&on_ai_spawned);
    callback::on_ai_killed(&on_ai_killed);
}

// Namespace aispawning/aispawning
// Params 0, eflags: 0x4
// Checksum 0x278f3301, Offset: 0x2f8
// Size: 0x1c
function private on_ai_spawned() {
    self thread function_83ab8396(self);
}

// Namespace aispawning/aispawning
// Params 1, eflags: 0x4
// Checksum 0x6aba68e1, Offset: 0x320
// Size: 0x24
function private on_ai_killed(params) {
    self thread function_88ebf63d(self);
}

// Namespace aispawning/aispawning
// Params 1, eflags: 0x4
// Checksum 0x70f500e4, Offset: 0x350
// Size: 0x10c
function private function_83ab8396(var_f4b1d057) {
    var_f4b1d057 endon(#"death");
    wait 1;
    level influencers::create_friendly_influencer("ai_spawn_friendly", var_f4b1d057.origin, var_f4b1d057.team);
    level influencers::create_enemy_influencer("ai_spawn_enemy", var_f4b1d057.origin, var_f4b1d057.team);
    if (isdefined(var_f4b1d057.spawninfluencerfriendly)) {
        var_f4b1d057 influencers::create_entity_friendly_influencer(var_f4b1d057.spawninfluencerfriendly, var_f4b1d057.team);
    }
    if (isdefined(var_f4b1d057.spawninfluencerenemy)) {
        var_f4b1d057 influencers::create_entity_enemy_influencer(var_f4b1d057.spawninfluencerenemy, var_f4b1d057.team);
    }
}

// Namespace aispawning/aispawning
// Params 1, eflags: 0x4
// Checksum 0x14fdd027, Offset: 0x468
// Size: 0x44
function private function_88ebf63d(var_f4b1d057) {
    level influencers::create_friendly_influencer("ai_death_friendly", var_f4b1d057.origin, var_f4b1d057.team);
}

// Namespace aispawning/aispawning
// Params 0, eflags: 0x4
// Checksum 0x332171d3, Offset: 0x4b8
// Size: 0x60
function private function_627e3834() {
    while (true) {
        level flag::wait_till("ai_spawnpoints_dirty");
        function_f631022f();
        level flag::clear("ai_spawnpoints_dirty");
    }
}

// Namespace aispawning/aispawning
// Params 0, eflags: 0x4
// Checksum 0x471907fd, Offset: 0x520
// Size: 0x43c
function private function_8c878f2a() {
    a_spawners = getspawnerarray();
    var_e8cab4d1 = [];
    foreach (var_a82c4a95 in a_spawners) {
        if (!isinarray(var_e8cab4d1, var_a82c4a95.archetype)) {
            if (!isdefined(var_e8cab4d1)) {
                var_e8cab4d1 = [];
            } else if (!isarray(var_e8cab4d1)) {
                var_e8cab4d1 = array(var_e8cab4d1);
            }
            var_e8cab4d1[var_e8cab4d1.size] = var_a82c4a95.archetype;
        }
    }
    foreach (var_9437a76c in var_e8cab4d1) {
        foreach (var_a82c4a95 in a_spawners) {
            if (var_9437a76c == var_a82c4a95.archetype) {
                if (!isdefined(level.var_e2e1cfef[var_9437a76c])) {
                    level.var_e2e1cfef[var_9437a76c] = [];
                }
                if (!isdefined(level.var_e2e1cfef[var_9437a76c][var_a82c4a95.team])) {
                    level.var_e2e1cfef[var_9437a76c][var_a82c4a95.team] = [];
                }
                if (!isdefined(level.var_e2e1cfef[var_9437a76c][var_a82c4a95.team])) {
                    level.var_e2e1cfef[var_9437a76c][var_a82c4a95.team] = [];
                } else if (!isarray(level.var_e2e1cfef[var_9437a76c][var_a82c4a95.team])) {
                    level.var_e2e1cfef[var_9437a76c][var_a82c4a95.team] = array(level.var_e2e1cfef[var_9437a76c][var_a82c4a95.team]);
                }
                if (!isinarray(level.var_e2e1cfef[var_9437a76c][var_a82c4a95.team], var_a82c4a95)) {
                    level.var_e2e1cfef[var_9437a76c][var_a82c4a95.team][level.var_e2e1cfef[var_9437a76c][var_a82c4a95.team].size] = var_a82c4a95;
                }
                if (isdefined(var_a82c4a95.script_start_disabled) && var_a82c4a95.script_start_disabled) {
                    var_a82c4a95.var_330ed46b = 1;
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
function private function_f631022f() {
    var_e8cab4d1 = getarraykeys(level.var_e2e1cfef);
    a_spawnlists = getspawnlists();
    foreach (str_archetype in var_e8cab4d1) {
        if (!isinarray(a_spawnlists, str_archetype)) {
            continue;
        }
        var_299705c5 = getarraykeys(level.var_e2e1cfef[str_archetype]);
        foreach (str_team in var_299705c5) {
            var_7d975d26 = [];
            foreach (spawn_point in level.var_e2e1cfef[str_archetype][str_team]) {
                if (isdefined(spawn_point)) {
                    if (!(isdefined(spawn_point.var_330ed46b) && spawn_point.var_330ed46b)) {
                        spawn_point.enabled = -1;
                    } else {
                        spawn_point.enabled = 0;
                    }
                    if (!isdefined(var_7d975d26)) {
                        var_7d975d26 = [];
                    } else if (!isarray(var_7d975d26)) {
                        var_7d975d26 = array(var_7d975d26);
                    }
                    if (!isinarray(var_7d975d26, spawn_point)) {
                        var_7d975d26[var_7d975d26.size] = spawn_point;
                    }
                }
            }
            if (var_7d975d26.size) {
                addspawnpoints(str_team, level.var_e2e1cfef[str_archetype][str_team], str_archetype);
            }
        }
    }
}

// Namespace aispawning/aispawning
// Params 0, eflags: 0x4
// Checksum 0x3718bbaa, Offset: 0xc88
// Size: 0xda
function private function_30e81628() {
    var_3f213c83 = getentarraybytype(23);
    foreach (var_1ef90ff1 in var_3f213c83) {
        if (isdefined(var_1ef90ff1.script_spawn_enable) || isdefined(var_1ef90ff1.script_spawn_disable)) {
            var_1ef90ff1 thread function_3e1e2d13(var_1ef90ff1);
        }
    }
}

// Namespace aispawning/aispawning
// Params 1, eflags: 0x4
// Checksum 0x2d1d51ce, Offset: 0xd70
// Size: 0x394
function private function_3e1e2d13(trigger) {
    trigger endon(#"death");
    trigger waittill("trigger");
    var_84df6203 = 0;
    var_e8cab4d1 = getarraykeys(level.var_e2e1cfef);
    foreach (str_archetype in var_e8cab4d1) {
        var_299705c5 = getarraykeys(level.var_e2e1cfef[str_archetype]);
        foreach (str_team in var_299705c5) {
            spawn_points = level.var_e2e1cfef[str_archetype][str_team];
            if (isdefined(trigger.script_spawn_enable)) {
                foreach (spawn_point in spawn_points) {
                    if (isdefined(spawn_point)) {
                        if (spawn_point.script_spawn_enable === trigger.script_spawn_enable) {
                            if (isdefined(spawn_point.var_330ed46b) && spawn_point.var_330ed46b) {
                                var_84df6203 = 1;
                                spawn_point.var_330ed46b = 0;
                            }
                        }
                    }
                }
            }
            if (isdefined(trigger.script_spawn_disable)) {
                foreach (spawn_point in spawn_points) {
                    if (isdefined(spawn_point)) {
                        if (spawn_point.script_spawn_disable === trigger.script_spawn_disable) {
                            if (!(isdefined(spawn_point.var_330ed46b) && spawn_point.var_330ed46b)) {
                                var_84df6203 = 1;
                                spawn_point.var_330ed46b = 1;
                            }
                        }
                    }
                }
            }
        }
        waitframe(1);
    }
    if (var_84df6203) {
        level flag::set("ai_spawnpoints_dirty");
    }
}

// Namespace aispawning/aispawning
// Params 2, eflags: 0x4
// Checksum 0x9c494976, Offset: 0x1110
// Size: 0x190
function private function_581e3f7a(str_archetype, str_team) {
    var_4a9c24f7 = 0;
    var_e8cab4d1 = getarraykeys(level.var_e2e1cfef);
    if (isinarray(var_e8cab4d1, str_archetype)) {
        var_299705c5 = getarraykeys(level.var_e2e1cfef[str_archetype]);
        if (isinarray(var_299705c5, str_team)) {
            foreach (spawn_point in level.var_e2e1cfef[str_archetype][str_team]) {
                if (isdefined(spawn_point) && !(isdefined(spawn_point.var_330ed46b) && spawn_point.var_330ed46b)) {
                    var_4a9c24f7 = 1;
                    break;
                }
            }
        }
    }
    if (var_4a9c24f7) {
        return true;
    }
    return false;
}

#namespace aispawningutility;

// Namespace aispawningutility/aispawning
// Params 3, eflags: 0x0
// Checksum 0x186d112e, Offset: 0x12a8
// Size: 0x378
function function_ce3753e1(str_classname, str_team, var_eced91fe) {
    var_41f14464 = str_team;
    var_e9b6901f = str_team;
    vis_team_mask = util::getotherteamsmask(str_team);
    var_4616f080 = getarchetypefromclassname(str_classname);
    if (isdefined(var_eced91fe)) {
        var_c6d02513 = getentarray(var_eced91fe, "targetname");
        var_53e33e29 = [];
        foreach (var_a82c4a95 in var_c6d02513) {
            if (isspawner(var_a82c4a95) && var_4616f080 === var_a82c4a95.archetype) {
                if (!isdefined(var_53e33e29)) {
                    var_53e33e29 = [];
                } else if (!isarray(var_53e33e29)) {
                    var_53e33e29 = array(var_53e33e29);
                }
                if (!isinarray(var_53e33e29, var_a82c4a95)) {
                    var_53e33e29[var_53e33e29.size] = var_a82c4a95;
                }
            }
        }
        if (var_53e33e29.size) {
            var_f5036844 = [];
            if (!isdefined(var_f5036844)) {
                var_f5036844 = [];
            } else if (!isarray(var_f5036844)) {
                var_f5036844 = array(var_f5036844);
            }
            var_f5036844[var_f5036844.size] = "wavemanager";
            clearspawnpoints("wavemanager");
            addspawnpoints(str_team, var_53e33e29, "wavemanager");
            spawn_point = getbestspawnpoint(var_e9b6901f, var_41f14464, vis_team_mask, undefined, 0, var_f5036844);
            return spawn_point;
        }
    } else if (aispawning::function_581e3f7a(var_4616f080, str_team)) {
        var_f5036844 = [];
        if (!isdefined(var_f5036844)) {
            var_f5036844 = [];
        } else if (!isarray(var_f5036844)) {
            var_f5036844 = array(var_f5036844);
        }
        var_f5036844[var_f5036844.size] = var_4616f080;
        spawn_point = getbestspawnpoint(var_e9b6901f, var_41f14464, vis_team_mask, undefined, 0, var_f5036844);
        return spawn_point;
    }
    return undefined;
}

