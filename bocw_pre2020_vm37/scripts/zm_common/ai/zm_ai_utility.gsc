#using script_2c5daa95f8fec03c;
#using script_62caa307a394c18c;
#using scripts\core_common\ai\systems\ai_interface;
#using scripts\core_common\ai\systems\gib;
#using scripts\core_common\ai\zombie_utility;
#using scripts\core_common\ai_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\laststand_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\zm_common\zm_powerups;
#using scripts\zm_common\zm_utility;
#using scripts\zm_common\zm_zonemgr;

#namespace zm_ai_utility;

// Namespace zm_ai_utility/zm_ai_utility
// Params 0, eflags: 0x6
// Checksum 0xc6d725aa, Offset: 0x168
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"zm_ai_utility", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace zm_ai_utility/zm_ai_utility
// Params 0, eflags: 0x5 linked
// Checksum 0xc7165b69, Offset: 0x1b0
// Size: 0x60
function private function_70a657d8() {
    spawner::add_ai_spawn_function(&function_8d30564f);
    callback::on_vehicle_spawned(&function_8d30564f);
    level.var_41dd92fd = [];
    /#
        level.var_87df97b5 = [];
    #/
}

// Namespace zm_ai_utility/zm_ai_utility
// Params 0, eflags: 0x5 linked
// Checksum 0x1d6087aa, Offset: 0x218
// Size: 0x24
function private function_8d30564f() {
    self.spawn_time = gettime();
    self function_637778cf();
}

// Namespace zm_ai_utility/zm_ai_utility
// Params 0, eflags: 0x5 linked
// Checksum 0x2060d170, Offset: 0x248
// Size: 0x1d4
function private function_637778cf() {
    self.var_716c0cc9 = [];
    settingsbundle = self ai::function_9139c839();
    if (!isdefined(settingsbundle)) {
        return;
    }
    self callback::function_d8abfc3d(#"hash_2f825f8e38a8b04d", &function_5540d5f9);
    self.var_6f84b820 = settingsbundle.category;
    self.var_28aab32a = settingsbundle.var_10460f1e;
    self.var_95d94ac4 = settingsbundle.stunduration;
    self.var_a0193213 = isdefined(settingsbundle.var_a3160086) ? settingsbundle.var_a3160086 : 0;
    self.maxhealth = function_f7014c3d(self.health);
    self.health = self.maxhealth;
    self.var_716c0cc9[#"kill"] = settingsbundle.scoreevent;
    self.var_716c0cc9[#"assist"] = settingsbundle.var_dc706c6c;
    self.var_7b22b800 = settingsbundle.var_7b22b800;
    self.var_19f5037 = namespace_42457a0::function_9caeb2f3(settingsbundle.var_349be1e8);
    if (isdefined(settingsbundle.var_5c3586f3)) {
        self.powerups = arraycopy(settingsbundle.var_5c3586f3);
        self thread function_3edc6292();
    }
    if (isdefined(settingsbundle.weapondamagescaleoverrides)) {
        function_a19d7104(settingsbundle);
    }
}

// Namespace zm_ai_utility/zm_ai_utility
// Params 1, eflags: 0x5 linked
// Checksum 0xb63ff3ac, Offset: 0x428
// Size: 0x1c2
function private function_a19d7104(settingsbundle) {
    if (is_true(settingsbundle.var_6199bcd5)) {
        return;
    }
    if (!isdefined(level.var_532264f5)) {
        level.var_532264f5 = [];
    }
    if (!isdefined(level.var_532264f5[settingsbundle.name])) {
        level.var_532264f5[settingsbundle.name] = [];
    }
    foreach (var_e8d7c6d7 in settingsbundle.weapondamagescaleoverrides) {
        if (!isdefined(var_e8d7c6d7.weaponid) || !isdefined(var_e8d7c6d7.damagescale)) {
            println("<dev string:x38>" + settingsbundle.name);
            continue;
        }
        level.var_532264f5[settingsbundle.name][var_e8d7c6d7.weaponid] = {#var_c6cc6205:var_e8d7c6d7.damagescale, #var_fff93f95:var_e8d7c6d7.var_628192b0, #var_8e22aa87:var_e8d7c6d7.var_fc420d71, #var_fac896db:var_e8d7c6d7.var_97b22faa};
    }
    settingsbundle.var_6199bcd5 = 1;
}

// Namespace zm_ai_utility/zm_ai_utility
// Params 1, eflags: 0x1 linked
// Checksum 0x5b930bc8, Offset: 0x5f8
// Size: 0x7a
function function_94d76123(weapon) {
    if (isdefined(self.var_76167463) && isdefined(weapon) && isdefined(level.var_532264f5) && isdefined(level.var_532264f5[self.var_76167463]) && isdefined(level.var_532264f5[self.var_76167463][weapon.name])) {
        return true;
    }
    return false;
}

// Namespace zm_ai_utility/zm_ai_utility
// Params 1, eflags: 0x1 linked
// Checksum 0xa339c5, Offset: 0x680
// Size: 0x2a
function function_86cb3728(weapon) {
    return level.var_532264f5[self.var_76167463][weapon.name];
}

// Namespace zm_ai_utility/zm_ai_utility
// Params 2, eflags: 0x0
// Checksum 0x617870ed, Offset: 0x6b8
// Size: 0xf2
function function_2ad308c4(archetype, drop_func) {
    if (!isdefined(level.var_1029f68)) {
        level.var_1029f68 = [];
    }
    if (!isdefined(level.var_1029f68[archetype])) {
        level.var_1029f68[archetype] = [];
    }
    if (!isdefined(level.var_1029f68[archetype])) {
        level.var_1029f68[archetype] = [];
    } else if (!isarray(level.var_1029f68[archetype])) {
        level.var_1029f68[archetype] = array(level.var_1029f68[archetype]);
    }
    level.var_1029f68[archetype][level.var_1029f68[archetype].size] = drop_func;
}

// Namespace zm_ai_utility/zm_ai_utility
// Params 1, eflags: 0x0
// Checksum 0xfa77eddb, Offset: 0x7b8
// Size: 0x190
function function_594bb7bd(player) {
    if (!isdefined(level.var_1029f68)) {
        return;
    }
    foreach (archetype, callback_array in level.var_1029f68) {
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
// Checksum 0xb89f1c1f, Offset: 0x950
// Size: 0x14c
function get_pathnode_path(pathnode) {
    path_struct = {#path:array(pathnode), #loops:0};
    var_592eaf7 = pathnode;
    while (isdefined(var_592eaf7.target)) {
        var_592eaf7 = getnode(var_592eaf7.target, "targetname");
        if (!isdefined(var_592eaf7)) {
            break;
        }
        if (isinarray(path_struct.path, var_592eaf7)) {
            path_struct.loops = 1;
            break;
        }
        if (!isdefined(path_struct.path)) {
            path_struct.path = [];
        } else if (!isarray(path_struct.path)) {
            path_struct.path = array(path_struct.path);
        }
        path_struct.path[path_struct.path.size] = var_592eaf7;
    }
    return path_struct;
}

// Namespace zm_ai_utility/zm_ai_utility
// Params 5, eflags: 0x0
// Checksum 0xfe25ed0, Offset: 0xaa8
// Size: 0x4c
function start_patrol(entity, patrol_path, var_b90f0f49, var_73fcb9ff, var_572b1f58) {
    entity thread update_patrol(entity, patrol_path, var_b90f0f49, var_73fcb9ff, var_572b1f58);
}

// Namespace zm_ai_utility/zm_ai_utility
// Params 1, eflags: 0x0
// Checksum 0xe9c38821, Offset: 0xb00
// Size: 0x60
function stop_patrol(entity) {
    if (entity ai::has_behavior_attribute("patrol")) {
        entity ai::set_behavior_attribute("patrol", 0);
    }
    entity notify(#"stop_patrol");
}

// Namespace zm_ai_utility/zm_ai_utility
// Params 5, eflags: 0x5 linked
// Checksum 0x319acf13, Offset: 0xb68
// Size: 0x204
function private update_patrol(entity, patrol_path, var_b90f0f49, var_73fcb9ff, var_572b1f58) {
    entity notify(#"stop_patrol");
    entity endon(#"death", #"stop_patrol");
    if (!entity ai::has_behavior_attribute("patrol")) {
        return;
    }
    entity ai::set_behavior_attribute("patrol", 1);
    while (entity ai::get_behavior_attribute("patrol") && patrol_path.size > 0) {
        for (i = 0; i < patrol_path.size; i++) {
            var_cf88d3eb = patrol_path[i];
            next_goal = getclosestpointonnavmesh(var_cf88d3eb.origin, 100, entity getpathfindingradius());
            if (!isdefined(next_goal)) {
                break;
            }
            entity setgoal(next_goal);
            entity waittill(#"goal_changed");
            entity waittill(#"goal");
            if (isdefined(var_73fcb9ff)) {
                entity [[ var_73fcb9ff ]](var_cf88d3eb);
            }
            if (entity ai::get_behavior_attribute("patrol") == 0) {
                break;
            }
        }
        if (!is_true(var_b90f0f49)) {
            break;
        }
    }
    if (isdefined(var_572b1f58)) {
        entity [[ var_572b1f58 ]]();
    }
}

// Namespace zm_ai_utility/zm_ai_utility
// Params 1, eflags: 0x1 linked
// Checksum 0x31cd95e4, Offset: 0xd78
// Size: 0x46a
function function_f7014c3d(base_health) {
    current_round = zm_utility::get_round_number();
    register_archetype = self ai::function_9139c839().var_3e8f6c97;
    base_health = isdefined(base_health) ? base_health : 100;
    var_6c0639a1 = self.aitype;
    if (is_true(register_archetype) || isdefined(level.var_41dd92fd[self.archetype])) {
        var_6c0639a1 = self.archetype;
    }
    /#
        if (isdefined(level.var_87df97b5[self.archetype])) {
            assert(level.var_87df97b5[self.archetype] === base_health, "<dev string:x68>");
        }
        if (is_true(register_archetype)) {
            level.var_87df97b5[self.archetype] = base_health;
        }
    #/
    if (!isdefined(level.var_41dd92fd[var_6c0639a1]) || level.var_41dd92fd[var_6c0639a1].round != current_round) {
        base = isdefined(base_health) ? base_health : 100;
        max = isdefined(self ai::function_9139c839().maxhealth) ? self ai::function_9139c839().maxhealth : base;
        flat = isdefined(self ai::function_9139c839().var_250a1683) ? self ai::function_9139c839().var_250a1683 : 0;
        var_7ea96e55 = isdefined(self ai::function_9139c839().var_68a36495) ? self ai::function_9139c839().var_68a36495 : 0;
        var_57531557 = isdefined(self ai::function_9139c839().var_83299c8) ? self ai::function_9139c839().var_83299c8 : 0;
        var_5d195d82 = self ai::function_9139c839().var_854eebd;
        var_751a7625 = 0;
        if (current_round < var_7ea96e55) {
            var_751a7625 = base + flat * (current_round - 1);
        } else {
            var_548d3734 = base + flat * (var_7ea96e55 - 1);
            var_751a7625 = var_548d3734 * pow(1 + var_57531557, current_round - var_7ea96e55);
        }
        self callback::callback(#"hash_2f825f8e38a8b04d", {#var_751a7625:var_751a7625, #base:base});
        if (var_751a7625 > max) {
            var_751a7625 = max;
        }
        if (isdefined(var_5d195d82) && level.players.size > 1) {
            var_751a7625 += var_751a7625 * (level.players.size - 1) * var_5d195d82;
        }
        level.var_41dd92fd[var_6c0639a1] = {#health:int(var_751a7625), #round:current_round};
    }
    return level.var_41dd92fd[var_6c0639a1].health;
}

// Namespace zm_ai_utility/zm_ai_utility
// Params 1, eflags: 0x1 linked
// Checksum 0x4e274106, Offset: 0x11f0
// Size: 0x5a
function function_5540d5f9(params) {
    if (isdefined(params.var_751a7625) && isdefined(params.base)) {
        self.var_41e87ed9 = round(params.var_751a7625 / params.base);
    }
}

// Namespace zm_ai_utility/zm_ai_utility
// Params 0, eflags: 0x1 linked
// Checksum 0x9e35c934, Offset: 0x1258
// Size: 0x1a6
function function_db610082() {
    if (!isdefined(self)) {
        return false;
    }
    if (!isalive(self)) {
        return false;
    }
    if (self.archetype !== #"zombie") {
        return false;
    }
    if (is_true(self.aat_turned)) {
        return false;
    }
    if (is_true(self.missinglegs)) {
        return false;
    }
    if (is_true(self.knockdown)) {
        return false;
    }
    if (gibserverutils::isgibbed(self, 56)) {
        return false;
    }
    if (isdefined(self.traversal) || self function_dd070839()) {
        return false;
    }
    if (is_true(self.var_69a981e6)) {
        return false;
    }
    if (is_true(self.barricade_enter)) {
        return false;
    }
    if (is_true(self.is_leaping)) {
        return false;
    }
    if (!is_true(self.completed_emerging_into_playable_area)) {
        return false;
    }
    if (!is_true(self zm_utility::in_playable_area())) {
        return false;
    }
    return true;
}

// Namespace zm_ai_utility/zm_ai_utility
// Params 11, eflags: 0x0
// Checksum 0x4aa0d46b, Offset: 0x1408
// Size: 0x40c
function function_422fdfd4(entity, attacker, weapon, var_5457dc44, hitloc, point, var_ebcb86d6, var_b85996d4, var_159ce525, var_ddd319d6, var_d2314927) {
    var_8d3f5b7d = isalive(attacker) && isplayer(attacker);
    var_201ce857 = var_8d3f5b7d && attacker zm_powerups::is_insta_kill_active();
    var_84ed9a13 = function_de3dda83(var_5457dc44, hitloc, point, var_ebcb86d6);
    registerzombie_bgb_used_reinforce = isdefined(var_84ed9a13) && namespace_81245006::function_f29756fe(var_84ed9a13) == 1;
    var_30362eca = registerzombie_bgb_used_reinforce && var_84ed9a13.type !== #"armor";
    if (entity function_94d76123(weapon)) {
        var_532264f5 = entity function_86cb3728(weapon);
        var_c6cc6205 = isdefined(var_b85996d4) ? var_b85996d4 : var_532264f5.var_c6cc6205;
        var_fff93f95 = isdefined(var_159ce525) ? var_159ce525 : var_532264f5.var_fff93f95;
        var_cee56a92 = isdefined(var_ddd319d6) ? var_ddd319d6 : var_532264f5.var_8e22aa87;
        var_e008ecea = isdefined(var_d2314927) ? var_d2314927 : var_532264f5.var_fac896db;
    } else {
        var_c6cc6205 = var_b85996d4;
        var_fff93f95 = var_159ce525;
        var_cee56a92 = var_ddd319d6;
        var_e008ecea = var_d2314927;
    }
    if (!var_201ce857 && !var_30362eca) {
        var_b1c1c5cf = isdefined(var_c6cc6205) ? var_c6cc6205 : entity ai::function_9139c839().damagescale;
    } else if (!var_201ce857 && var_30362eca) {
        var_b1c1c5cf = isdefined(var_fff93f95) ? var_fff93f95 : entity ai::function_9139c839().var_628192b0;
    } else if (var_201ce857 && !var_30362eca) {
        var_b1c1c5cf = isdefined(var_cee56a92) ? var_cee56a92 : entity ai::function_9139c839().var_fc420d71;
    } else {
        var_b1c1c5cf = isdefined(var_e008ecea) ? var_e008ecea : entity ai::function_9139c839().var_97b22faa;
    }
    if (var_8d3f5b7d) {
        has_weakpoints = isdefined(namespace_81245006::function_fab3ee3e(self));
        if (var_30362eca && attacker hasperk(#"specialty_mod_awareness")) {
            if (var_b1c1c5cf < 1) {
                var_b1c1c5cf += 0.2;
            } else {
                var_b1c1c5cf *= 1.2;
            }
        }
    }
    return {#damage_scale:var_b1c1c5cf, #var_84ed9a13:var_84ed9a13, #registerzombie_bgb_used_reinforce:registerzombie_bgb_used_reinforce, #var_201ce857:var_201ce857};
}

// Namespace zm_ai_utility/zm_ai_utility
// Params 4, eflags: 0x1 linked
// Checksum 0xf6eddc7, Offset: 0x1820
// Size: 0xaa
function function_de3dda83(var_5457dc44, hitloc, point, var_ebcb86d6) {
    if (isdefined(var_ebcb86d6)) {
        var_84ed9a13 = var_ebcb86d6;
    } else {
        var_84ed9a13 = namespace_81245006::function_3131f5dd(self, hitloc, 1);
        if (!isdefined(var_84ed9a13)) {
            var_84ed9a13 = namespace_81245006::function_37e3f011(self, var_5457dc44);
        }
        if (!isdefined(var_84ed9a13)) {
            var_84ed9a13 = namespace_81245006::function_73ab4754(self, point, 1);
        }
    }
    return var_84ed9a13;
}

// Namespace zm_ai_utility/zm_ai_utility
// Params 3, eflags: 0x1 linked
// Checksum 0x330dc5d7, Offset: 0x18d8
// Size: 0x1ae
function function_a2e8fd7b(entity, player, var_3f120c4d = 4) {
    assert(isplayer(player), "<dev string:xa9>");
    if (getdvarint(#"zm_zone_pathing", 1) && level.zones.size) {
        zone_path = zm_zonemgr::function_54fc7938(player, entity);
        if (isdefined(zone_path) && zone_path.cost >= var_3f120c4d) {
            to_zone = level.zones[zone_path.to_zone];
            for (var_3a38abb0 = 0; is_true(to_zone.var_458fe8a) && var_3a38abb0 < 4; var_3a38abb0++) {
                zone_path = zm_zonemgr::function_54fc7938(player, zone_path.to_zone);
                if (!isdefined(zone_path)) {
                    return player;
                }
                to_zone = level.zones[zone_path.to_zone];
            }
            if (isdefined(to_zone) && to_zone.nodes.size > 0) {
                return to_zone.nodes[0];
            }
        }
    }
    return player;
}

// Namespace zm_ai_utility/zm_ai_utility
// Params 1, eflags: 0x0
// Checksum 0x441d9764, Offset: 0x1a90
// Size: 0x19c
function make_zombie_target(entity) {
    if (isinarray(level.zombie_targets, entity)) {
        /#
            iprintlnbold("<dev string:xe0>" + entity getentitynumber() + "<dev string:xeb>");
        #/
        return false;
    }
    function_1eaaceab(level.zombie_targets);
    arrayremovevalue(level.zombie_targets, undefined);
    if (level.zombie_targets.size + 4 >= 16) {
        /#
            iprintlnbold("<dev string:x10a>" + entity getentitynumber() + "<dev string:x124>");
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
// Checksum 0x3dbb70a5, Offset: 0x1c38
// Size: 0x2a
function is_zombie_target(entity) {
    return isinarray(level.zombie_targets, entity);
}

// Namespace zm_ai_utility/zm_ai_utility
// Params 1, eflags: 0x0
// Checksum 0x3e59f1a0, Offset: 0x1c70
// Size: 0x88
function remove_zombie_target(entity) {
    if (!isinarray(level.zombie_targets, entity)) {
        /#
            iprintlnbold("<dev string:xe0>" + entity getentitynumber() + "<dev string:x151>");
        #/
        return false;
    }
    arrayremovevalue(level.zombie_targets, entity);
    return true;
}

// Namespace zm_ai_utility/zm_ai_utility
// Params 0, eflags: 0x1 linked
// Checksum 0x245be387, Offset: 0x1d00
// Size: 0xa8
function function_3edc6292() {
    if (!isdefined(self.powerups)) {
        return 0;
    }
    if (!isdefined(self.var_d0686fde)) {
        self.var_d0686fde = [];
    } else if (!isarray(self.var_d0686fde)) {
        self.var_d0686fde = array(self.var_d0686fde);
    }
    for (i = 0; i < self.powerups.size; i++) {
        self.var_d0686fde[i] = self.powerups[i].dropid;
    }
}

// Namespace zm_ai_utility/zm_ai_utility
// Params 2, eflags: 0x0
// Checksum 0xf13c24ca, Offset: 0x1db0
// Size: 0x120
function function_991333ce(entity, ai_array) {
    enemies = ai_array;
    if (!isdefined(enemies)) {
        enemies = getaiteamarray(level.zombie_team);
    }
    foreach (enemy in enemies) {
        if (enemy.favoriteenemy === entity) {
            if (isdefined(enemy.var_ef1ed308)) {
                [[ enemy.var_ef1ed308 ]](enemy);
            } else {
                enemy.favoriteenemy = undefined;
            }
            enemy.var_93a62fe = undefined;
            enemy setgoal(enemy.origin);
        }
    }
}

// Namespace zm_ai_utility/zm_ai_utility
// Params 0, eflags: 0x5 linked
// Checksum 0x7ef54fd7, Offset: 0x1ed8
// Size: 0x92
function private function_f1b557c6() {
    if (self isplayinganimscripted()) {
        return false;
    }
    if (isactor(self) && (self.isarriving || self function_dd070839() || self asmistransdecrunning() || self asmistransitionrunning())) {
        return false;
    }
    return true;
}

// Namespace zm_ai_utility/zm_ai_utility
// Params 1, eflags: 0x1 linked
// Checksum 0x7cc5389b, Offset: 0x1f78
// Size: 0x234
function function_a8dc3363(s_location) {
    if (isalive(self)) {
        self endon(#"death");
        self val::set(#"ai_cleanup", "hide", 2);
        util::wait_network_frame();
        self pathmode("dont move", 1);
        while (!self function_f1b557c6()) {
            println("<dev string:x16c>" + self getentitynumber() + "<dev string:x195>");
            waitframe(1);
        }
        self dontinterpolate();
        self forceteleport(s_location.origin, self.angles, 0, 1);
        self pathmode("move allowed");
        self val::reset(#"ai_cleanup", "hide");
        self zombie_utility::reset_attack_spot();
        self.completed_emerging_into_playable_area = 0;
        self.find_flesh_struct_string = s_location.script_string;
        self.got_to_entrance = undefined;
        self.at_entrance_tear_spot = undefined;
        self.spawn_time = gettime();
        if (self.var_6f84b820 == #"normal" && s_location.script_noteworthy != "spawn_location" && s_location.script_noteworthy != "blight_father_location") {
            self.spawn_pos = undefined;
            self zm_utility::move_zombie_spawn_location(s_location);
        }
    }
}

// Namespace zm_ai_utility/zm_ai_utility
// Params 1, eflags: 0x1 linked
// Checksum 0x30c134d7, Offset: 0x21b8
// Size: 0xda
function function_54054394(entity) {
    if (!isdefined(level.var_5fa2f970)) {
        level.var_5fa2f970 = getentarray("no_powerups", "targetname");
    }
    foreach (volume in level.var_5fa2f970) {
        if (entity istouching(volume)) {
            return true;
        }
    }
    return false;
}

// Namespace zm_ai_utility/zm_ai_utility
// Params 2, eflags: 0x1 linked
// Checksum 0x1e5b12ca, Offset: 0x22a0
// Size: 0x96
function hashelmet(hitloc, enemy) {
    weakpoint = namespace_81245006::function_3131f5dd(enemy, hitloc, 1);
    if (isdefined(weakpoint) && weakpoint.type === #"armor" && weakpoint.var_f371ebb0 === "helmet" && namespace_81245006::function_f29756fe(weakpoint) !== 3) {
        return true;
    }
    return false;
}

// Namespace zm_ai_utility/zm_ai_utility
// Params 1, eflags: 0x1 linked
// Checksum 0xba365b2d, Offset: 0x2340
// Size: 0x26
function function_68ab868a(entity) {
    entity.var_1fa24724 = 1;
    entity.var_4ca11261 = gettime();
}

// Namespace zm_ai_utility/zm_ai_utility
// Params 1, eflags: 0x1 linked
// Checksum 0xcc4cb0f1, Offset: 0x2370
// Size: 0x22
function function_4d22f6d1(entity) {
    entity.var_1fa24724 = undefined;
    entity.var_4ca11261 = undefined;
}

