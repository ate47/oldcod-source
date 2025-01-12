#using script_2c5daa95f8fec03c;
#using scripts\core_common\ai\systems\ai_interface;
#using scripts\core_common\ai\systems\gib;
#using scripts\core_common\ai_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\system_shared;
#using scripts\zm_common\zm_powerups;
#using scripts\zm_common\zm_utility;
#using scripts\zm_common\zm_zonemgr;

#namespace zm_ai_utility;

// Namespace zm_ai_utility/zm_ai_utility
// Params 0, eflags: 0x2
// Checksum 0x1939e3d0, Offset: 0xe0
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"zm_ai_utility", &__init__, undefined, undefined);
}

// Namespace zm_ai_utility/zm_ai_utility
// Params 0, eflags: 0x4
// Checksum 0xf023ceb5, Offset: 0x128
// Size: 0x44
function private __init__() {
    spawner::add_ai_spawn_function(&function_999228ec);
    callback::on_vehicle_spawned(&function_999228ec);
}

// Namespace zm_ai_utility/zm_ai_utility
// Params 0, eflags: 0x4
// Checksum 0x50a48ff7, Offset: 0x178
// Size: 0x24
function private function_999228ec() {
    self.spawn_time = gettime();
    self function_5dd73316();
}

// Namespace zm_ai_utility/zm_ai_utility
// Params 0, eflags: 0x4
// Checksum 0x94410ea4, Offset: 0x1a8
// Size: 0xec
function private function_5dd73316() {
    settingsbundle = self ai::function_a0dbf10a();
    if (!isdefined(settingsbundle)) {
        return;
    }
    self.var_29ed62b2 = settingsbundle.category;
    self.var_206e9b33 = settingsbundle.var_2a109647;
    self.var_6499b5b2 = settingsbundle.stunduration;
    self.score_event = settingsbundle.scoreevent;
    if (isdefined(settingsbundle.var_895f1a64)) {
        self.powerups = arraycopy(settingsbundle.var_895f1a64);
        self thread function_effd5ef5();
    }
    if (isdefined(settingsbundle.weapondamagescaleoverrides)) {
        function_e7e3413d(settingsbundle);
    }
}

// Namespace zm_ai_utility/zm_ai_utility
// Params 1, eflags: 0x4
// Checksum 0x55ae971, Offset: 0x2a0
// Size: 0x1de
function private function_e7e3413d(settingsbundle) {
    if (isdefined(settingsbundle.var_9859f548) && settingsbundle.var_9859f548) {
        return;
    }
    if (!isdefined(level.var_d9942776)) {
        level.var_d9942776 = [];
    }
    if (!isdefined(level.var_d9942776[settingsbundle.name])) {
        level.var_d9942776[settingsbundle.name] = [];
    }
    foreach (var_aa9a7a7 in settingsbundle.weapondamagescaleoverrides) {
        if (!isdefined(var_aa9a7a7.weaponid) || !isdefined(var_aa9a7a7.damagescale)) {
            println("<dev string:x30>" + settingsbundle.name);
            continue;
        }
        level.var_d9942776[settingsbundle.name][var_aa9a7a7.weaponid] = {#var_29c5071b:var_aa9a7a7.damagescale, #var_1377d834:var_aa9a7a7.var_41262008, #var_e5b96e91:var_aa9a7a7.var_905bc785, #var_d362ae34:var_aa9a7a7.var_5f2bd92b};
    }
    settingsbundle.var_9859f548 = 1;
}

// Namespace zm_ai_utility/zm_ai_utility
// Params 1, eflags: 0x0
// Checksum 0x97fb9365, Offset: 0x488
// Size: 0x7a
function function_2d622750(weapon) {
    if (isdefined(self.var_105bdc9c) && isdefined(weapon) && isdefined(level.var_d9942776) && isdefined(level.var_d9942776[self.var_105bdc9c]) && isdefined(level.var_d9942776[self.var_105bdc9c][weapon.name])) {
        return true;
    }
    return false;
}

// Namespace zm_ai_utility/zm_ai_utility
// Params 1, eflags: 0x0
// Checksum 0xa22a8ea4, Offset: 0x510
// Size: 0x2a
function function_6bbce724(weapon) {
    return level.var_d9942776[self.var_105bdc9c][weapon.name];
}

// Namespace zm_ai_utility/zm_ai_utility
// Params 2, eflags: 0x0
// Checksum 0xed467b75, Offset: 0x548
// Size: 0x100
function function_dd6daffa(archetype, drop_func) {
    if (!isdefined(level.var_c779851b)) {
        level.var_c779851b = [];
    }
    if (!isdefined(level.var_c779851b[archetype])) {
        level.var_c779851b[archetype] = [];
    }
    if (!isdefined(level.var_c779851b[archetype])) {
        level.var_c779851b[archetype] = [];
    } else if (!isarray(level.var_c779851b[archetype])) {
        level.var_c779851b[archetype] = array(level.var_c779851b[archetype]);
    }
    level.var_c779851b[archetype][level.var_c779851b[archetype].size] = drop_func;
}

// Namespace zm_ai_utility/zm_ai_utility
// Params 1, eflags: 0x0
// Checksum 0x102ff690, Offset: 0x650
// Size: 0x170
function function_9e2bcbcf(player) {
    if (!isdefined(level.var_c779851b)) {
        return;
    }
    foreach (archetype, callback_array in level.var_c779851b) {
        ai_array = getaiarchetypearray(archetype);
        foreach (ai in ai_array) {
            foreach (callback in callback_array) {
                ai [[ callback ]](player);
            }
        }
    }
}

// Namespace zm_ai_utility/zm_ai_utility
// Params 1, eflags: 0x0
// Checksum 0xc1d1d209, Offset: 0x7c8
// Size: 0x16e
function get_pathnode_path(pathnode) {
    path_struct = {#path:array(pathnode), #loops:0};
    var_1f4554e = pathnode;
    while (isdefined(var_1f4554e.target)) {
        var_1f4554e = getnode(var_1f4554e.target, "targetname");
        if (!isdefined(var_1f4554e)) {
            break;
        }
        if (isinarray(path_struct.path, var_1f4554e)) {
            path_struct.loops = 1;
            break;
        }
        if (!isdefined(path_struct.path)) {
            path_struct.path = [];
        } else if (!isarray(path_struct.path)) {
            path_struct.path = array(path_struct.path);
        }
        path_struct.path[path_struct.path.size] = var_1f4554e;
    }
    return path_struct;
}

// Namespace zm_ai_utility/zm_ai_utility
// Params 5, eflags: 0x0
// Checksum 0xa0f4c872, Offset: 0x940
// Size: 0x54
function start_patrol(entity, patrol_path, var_99ce2835, var_a5206197, var_84a9620) {
    entity thread update_patrol(entity, patrol_path, var_99ce2835, var_a5206197, var_84a9620);
}

// Namespace zm_ai_utility/zm_ai_utility
// Params 1, eflags: 0x0
// Checksum 0x851ca5d8, Offset: 0x9a0
// Size: 0x60
function stop_patrol(entity) {
    if (entity ai::has_behavior_attribute("patrol")) {
        entity ai::set_behavior_attribute("patrol", 0);
    }
    entity notify(#"stop_patrol");
}

// Namespace zm_ai_utility/zm_ai_utility
// Params 5, eflags: 0x4
// Checksum 0xb5562602, Offset: 0xa08
// Size: 0x218
function private update_patrol(entity, patrol_path, var_99ce2835, var_a5206197, var_84a9620) {
    entity notify(#"stop_patrol");
    entity endon(#"death", #"stop_patrol");
    if (!entity ai::has_behavior_attribute("patrol")) {
        return;
    }
    entity ai::set_behavior_attribute("patrol", 1);
    while (entity ai::get_behavior_attribute("patrol") && patrol_path.size > 0) {
        for (i = 0; i < patrol_path.size; i++) {
            var_2c834c30 = patrol_path[i];
            next_goal = getclosestpointonnavmesh(var_2c834c30.origin, 100, entity getpathfindingradius());
            if (!isdefined(next_goal)) {
                break;
            }
            entity setgoal(next_goal);
            entity waittill(#"goal_changed");
            entity waittill(#"goal");
            if (isdefined(var_a5206197)) {
                entity [[ var_a5206197 ]](var_2c834c30);
            }
            if (entity ai::get_behavior_attribute("patrol") == 0) {
                break;
            }
        }
        if (!(isdefined(var_99ce2835) && var_99ce2835)) {
            break;
        }
    }
    if (isdefined(var_84a9620)) {
        entity [[ var_84a9620 ]]();
    }
}

// Namespace zm_ai_utility/zm_ai_utility
// Params 2, eflags: 0x0
// Checksum 0x7887afaf, Offset: 0xc28
// Size: 0x15a
function function_55a1bfd1(var_5c17decd, var_eeed034b) {
    n_min = self ai::function_a0dbf10a().minhealth;
    n_max = self ai::function_a0dbf10a().maxhealth;
    var_238b71e3 = self ai::function_a0dbf10a().var_2f87e855;
    var_dba3d2ce = self ai::function_a0dbf10a().var_e63097b4;
    n_health = n_min + var_238b71e3 * (isdefined(var_eeed034b) ? var_eeed034b : level.round_number);
    if (var_5c17decd && level.players.size > 1) {
        n_health += n_health * (level.players.size - 1) * var_dba3d2ce;
    }
    return int(math::clamp(n_health, n_min, n_max));
}

// Namespace zm_ai_utility/zm_ai_utility
// Params 0, eflags: 0x0
// Checksum 0xb3b77e36, Offset: 0xd90
// Size: 0x178
function function_4f5236d3() {
    if (!isdefined(self)) {
        return false;
    }
    if (!isalive(self)) {
        return false;
    }
    if (self.archetype !== "zombie") {
        return false;
    }
    if (isdefined(self.aat_turned) && self.aat_turned) {
        return false;
    }
    if (isdefined(self.missinglegs) && self.missinglegs) {
        return false;
    }
    if (isdefined(self.knockdown) && self.knockdown) {
        return false;
    }
    if (gibserverutils::isgibbed(self, 56)) {
        return false;
    }
    if (isdefined(self.traversal)) {
        return false;
    }
    if (isdefined(self.var_3059fa07) && self.var_3059fa07) {
        return false;
    }
    if (isdefined(self.barricade_enter) && self.barricade_enter) {
        return false;
    }
    if (isdefined(self.is_leaping) && self.is_leaping) {
        return false;
    }
    if (!(isdefined(self.completed_emerging_into_playable_area) && self.completed_emerging_into_playable_area)) {
        return false;
    }
    if (!(isdefined(self zm_utility::in_playable_area()) && self zm_utility::in_playable_area())) {
        return false;
    }
    return true;
}

// Namespace zm_ai_utility/zm_ai_utility
// Params 9, eflags: 0x0
// Checksum 0x20f6e3b5, Offset: 0xf10
// Size: 0x3e4
function function_9094ed69(entity, attacker, weapon, var_701d29e8, var_cc1fce07, var_e4ffdafe, var_f0f1b7ab, var_c7ebcb33, var_1c9e2cac) {
    var_8ba64008 = isalive(attacker) && isplayer(attacker);
    var_cda98e9a = var_8ba64008 && attacker zm_powerups::is_insta_kill_active();
    if (isdefined(var_cc1fce07)) {
        var_b750d1c8 = var_cc1fce07;
    } else {
        var_b750d1c8 = namespace_9088c704::function_fc6ac723(entity, var_701d29e8);
    }
    var_9c192fd2 = isdefined(var_b750d1c8) && namespace_9088c704::function_4abac7be(var_b750d1c8) == 1;
    var_44cc0b9 = var_9c192fd2 && var_b750d1c8.type !== #"armor";
    if (entity function_2d622750(weapon)) {
        var_d9942776 = entity function_6bbce724(weapon);
        var_29c5071b = isdefined(var_e4ffdafe) ? var_e4ffdafe : var_d9942776.var_29c5071b;
        var_1377d834 = isdefined(var_f0f1b7ab) ? var_f0f1b7ab : var_d9942776.var_1377d834;
        var_350606dc = isdefined(var_c7ebcb33) ? var_c7ebcb33 : var_d9942776.var_e5b96e91;
        var_febc9c91 = isdefined(var_1c9e2cac) ? var_1c9e2cac : var_d9942776.var_d362ae34;
    } else {
        var_29c5071b = var_e4ffdafe;
        var_1377d834 = var_f0f1b7ab;
        var_350606dc = var_c7ebcb33;
        var_febc9c91 = var_1c9e2cac;
    }
    if (!var_cda98e9a && !var_44cc0b9) {
        var_49a8454 = isdefined(var_29c5071b) ? var_29c5071b : entity ai::function_a0dbf10a().damagescale;
    } else if (!var_cda98e9a && var_44cc0b9) {
        var_49a8454 = isdefined(var_1377d834) ? var_1377d834 : entity ai::function_a0dbf10a().var_41262008;
    } else if (var_cda98e9a && !var_44cc0b9) {
        var_49a8454 = isdefined(var_350606dc) ? var_350606dc : entity ai::function_a0dbf10a().var_905bc785;
    } else {
        var_49a8454 = isdefined(var_febc9c91) ? var_febc9c91 : entity ai::function_a0dbf10a().var_5f2bd92b;
    }
    if (var_44cc0b9 && var_8ba64008 && attacker hasperk(#"specialty_mod_awareness")) {
        var_49a8454 *= 1.2;
    }
    return {#damage_scale:var_49a8454, #var_b750d1c8:var_b750d1c8, #var_9c192fd2:var_9c192fd2, #var_cda98e9a:var_cda98e9a};
}

// Namespace zm_ai_utility/zm_ai_utility
// Params 3, eflags: 0x0
// Checksum 0xd58302e, Offset: 0x1300
// Size: 0x116
function function_93d978d(entity, player, var_2ea3598b = 4) {
    assert(isplayer(player), "<dev string:x5d>");
    if (getdvarint(#"zm_zone_pathing", 1)) {
        zone_path = zm_zonemgr::function_a5972886(player, entity);
        if (isdefined(zone_path)) {
            if (zone_path.cost >= var_2ea3598b) {
                to_zone = level.zones[zone_path.to_zone];
                if (isdefined(to_zone) && to_zone.nodes.size > 0) {
                    return to_zone.nodes[0];
                }
            }
        }
    }
    return player;
}

// Namespace zm_ai_utility/zm_ai_utility
// Params 1, eflags: 0x0
// Checksum 0xcc17e4a6, Offset: 0x1420
// Size: 0x1a6
function make_zombie_target(entity) {
    if (isinarray(level.zombie_targets, entity)) {
        /#
            iprintlnbold("<dev string:x91>" + entity getentitynumber() + "<dev string:x99>");
        #/
        return false;
    }
    function_526005d6(level.zombie_targets);
    arrayremovevalue(level.zombie_targets, undefined);
    if (level.zombie_targets.size + 4 >= 16) {
        /#
            iprintlnbold("<dev string:xb5>" + entity getentitynumber() + "<dev string:xcc>");
        #/
        return false;
    }
    if (!isdefined(entity.am_i_valid)) {
        entity.am_i_valid = 1;
    }
    if (!isdefined(level.zombie_targets)) {
        level.zombie_targets = [];
    } else if (!isarray(level.zombie_targets)) {
        level.zombie_targets = array(level.zombie_targets);
    }
    level.zombie_targets[level.zombie_targets.size] = entity;
    return true;
}

// Namespace zm_ai_utility/zm_ai_utility
// Params 1, eflags: 0x0
// Checksum 0x5d0d6d40, Offset: 0x15d0
// Size: 0x2a
function is_zombie_target(entity) {
    return isinarray(level.zombie_targets, entity);
}

// Namespace zm_ai_utility/zm_ai_utility
// Params 1, eflags: 0x0
// Checksum 0x8e5a94c6, Offset: 0x1608
// Size: 0x88
function remove_zombie_target(entity) {
    if (!isinarray(level.zombie_targets, entity)) {
        /#
            iprintlnbold("<dev string:x91>" + entity getentitynumber() + "<dev string:xf6>");
        #/
        return false;
    }
    arrayremovevalue(level.zombie_targets, entity);
    return true;
}

// Namespace zm_ai_utility/zm_ai_utility
// Params 0, eflags: 0x0
// Checksum 0x6eaf9932, Offset: 0x1698
// Size: 0xac
function function_effd5ef5() {
    if (!isdefined(self.powerups)) {
        return 0;
    }
    if (!isdefined(self.var_a11baa62)) {
        self.var_a11baa62 = [];
    } else if (!isarray(self.var_a11baa62)) {
        self.var_a11baa62 = array(self.var_a11baa62);
    }
    for (i = 0; i < self.powerups.size; i++) {
        self.var_a11baa62[i] = self.powerups[i].dropid;
    }
}

// Namespace zm_ai_utility/zm_ai_utility
// Params 2, eflags: 0x0
// Checksum 0xdc5ab90d, Offset: 0x1750
// Size: 0x118
function function_66bc9d2f(entity, ai_array) {
    enemies = ai_array;
    if (!isdefined(enemies)) {
        enemies = getaiteamarray(level.zombie_team);
    }
    foreach (enemy in enemies) {
        if (enemy.favoriteenemy === entity) {
            if (isdefined(enemy.var_a015e2e5)) {
                [[ enemy.var_a015e2e5 ]](enemy);
            } else {
                enemy.favoriteenemy = undefined;
            }
            enemy.var_532a149b = undefined;
            enemy setgoal(enemy.origin);
        }
    }
}

