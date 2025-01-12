#using script_556e19065f09f8a2;
#using scripts\core_common\ai\systems\gib;
#using scripts\core_common\ai\zombie_utility;
#using scripts\core_common\ai_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\values_shared;

#namespace zm_transform;

// Namespace zm_transform/zm_transformation
// Params 0, eflags: 0x0
// Checksum 0x7b742636, Offset: 0x150
// Size: 0xd4
function function_70a657d8() {
    level.var_b175714d = [];
    level thread update();
    clientfield::register("actor", "transformation_spawn", 1, 1, "int");
    clientfield::register("actor", "transformation_stream_split", 1, 1, "int");
    level flag::init(#"hash_670ec83e1acfadff");
    level.var_50f7dbd5 = [];
    level.var_ebccd551 = [];
    /#
        level thread devgui();
    #/
}

// Namespace zm_transform/zm_transformation
// Params 1, eflags: 0x0
// Checksum 0xd9acca37, Offset: 0x230
// Size: 0x100
function function_4da8230b(var_736940b3) {
    assert(ishash(var_736940b3), "<dev string:x38>");
    if (!isdefined(level.var_50f7dbd5)) {
        level.var_50f7dbd5 = [];
    } else if (!isarray(level.var_50f7dbd5)) {
        level.var_50f7dbd5 = array(level.var_50f7dbd5);
    }
    level.var_50f7dbd5[level.var_50f7dbd5.size] = var_736940b3;
    if (level.var_50f7dbd5.size == 1) {
        level flag::set(#"hash_670ec83e1acfadff");
        level notify(#"hash_239ebc19aab5a60b");
    }
}

// Namespace zm_transform/zm_transformation
// Params 1, eflags: 0x0
// Checksum 0x4833df63, Offset: 0x338
// Size: 0x12c
function function_6b183c78(var_736940b3) {
    assert(ishash(var_736940b3), "<dev string:x73>");
    foreach (index, name_hash in level.var_50f7dbd5) {
        if (name_hash == var_736940b3) {
            var_689205d = index;
            break;
        }
    }
    if (!isdefined(var_689205d)) {
        return;
    }
    arrayremoveindex(level.var_50f7dbd5, var_689205d);
    if (level.var_50f7dbd5.size == 0) {
        level flag::clear(#"hash_670ec83e1acfadff");
    }
}

// Namespace zm_transform/zm_transformation
// Params 0, eflags: 0x0
// Checksum 0x1bc38132, Offset: 0x470
// Size: 0x22
function function_770908a2() {
    return level flag::get(#"hash_670ec83e1acfadff");
}

// Namespace zm_transform/zm_transformation
// Params 9, eflags: 0x1 linked
// Checksum 0x338e682b, Offset: 0x4a0
// Size: 0x49c
function function_cfca77a7(var_42de336c, id, condition_func, cooldown_time, intro_func, outro_func, var_44c5827d, var_99fca475, var_accb1c92) {
    assert(!isdefined(level.var_b175714d[id]));
    /#
        if (!isdefined(var_42de336c)) {
            println("<dev string:xaf>" + id + "<dev string:xcd>");
            return;
        }
        if (isdefined(var_99fca475) && isentity(var_42de336c)) {
            spawner = var_42de336c;
            if (!isdefined(spawner.targetname) || spawner.targetname == "<dev string:x107>") {
                println("<dev string:xaf>" + id + "<dev string:x10b>" + var_99fca475 + "<dev string:x12b>");
                return;
            }
            var_de6be79a = 0;
            scenedef = scene::get_scenedef(var_99fca475);
            foreach (object in scenedef.objects) {
                if (object.type === "<dev string:x141>" && object.name === spawner.targetname) {
                    var_de6be79a = 1;
                    break;
                }
            }
            if (!var_de6be79a) {
                println("<dev string:xaf>" + id + "<dev string:x14a>" + spawner.targetname);
                return;
            }
        }
        if (isdefined(var_44c5827d) && !isdefined(var_99fca475)) {
            println("<dev string:xaf>" + id + "<dev string:x190>");
            return;
        }
        if (!isdefined(var_44c5827d) && isdefined(var_99fca475)) {
            println("<dev string:xaf>" + id + "<dev string:x1de>");
            return;
        }
        if (!isentity(var_42de336c) && !isassetloaded("<dev string:x22c>", var_42de336c)) {
            println("<dev string:xaf>" + id + "<dev string:x236>" + (ishash(var_42de336c) ? function_9e72a96(var_42de336c) : var_42de336c) + "<dev string:x252>");
            return;
        }
    #/
    level.var_b175714d[id] = {#condition:condition_func, #intro_func:intro_func, #outro_func:outro_func, #var_accb1c92:var_accb1c92, #var_44c5827d:var_44c5827d, #var_99fca475:var_99fca475, #cooldown_time:cooldown_time, #var_ebaa8de9:0, #var_33e393a7:0, #var_2939a01a:[]};
    if (isentity(var_42de336c)) {
        level.var_b175714d[id].spawner = var_42de336c;
        return;
    }
    level.var_b175714d[id].aitype = var_42de336c;
    if (!isdefined(level.var_170852dc)) {
        level.var_170852dc = [];
    }
}

// Namespace zm_transform/zm_transformation
// Params 1, eflags: 0x1 linked
// Checksum 0xd25e261e, Offset: 0x948
// Size: 0x106
function function_abf1dcb4(id) {
    if (level.var_ebccd551.size >= 10) {
        return true;
    }
    if (isdefined(level.var_88de5053) && level.var_ebccd551.size >= level.var_88de5053) {
        return true;
    }
    if (isdefined(level.var_b175714d[id]) && isdefined(level.var_b175714d[id].spawner)) {
        return isdefined(level.var_b175714d[id].spawner.var_ab46c56);
    } else if (isdefined(level.var_b175714d[id]) && isdefined(level.var_b175714d[id].aitype)) {
        return isdefined(level.var_170852dc[level.var_b175714d[id].aitype]);
    }
    return false;
}

// Namespace zm_transform/zm_transformation
// Params 4, eflags: 0x0
// Checksum 0xe45820a0, Offset: 0xa58
// Size: 0x17c
function function_9acf76e6(entity, id, var_c2a69066, var_2cf708f4 = 1) {
    if (!isdefined(level.var_b175714d[id])) {
        /#
            iprintlnbold("<dev string:x26a>" + id + "<dev string:x294>");
        #/
        return;
    }
    if (!isdefined(entity) || is_true(entity.var_69a981e6)) {
        /#
            iprintlnbold("<dev string:x2ab>" + id + "<dev string:x2cd>");
        #/
        return;
    }
    if (function_abf1dcb4(id)) {
        /#
            iprintlnbold("<dev string:x2ab>" + id + "<dev string:x2f5>");
        #/
        return;
    }
    if (function_331869(entity)) {
        function_1afce5aa(entity);
    }
    var_167b5341 = level.var_b175714d[id];
    entity thread transform(id, var_c2a69066, var_2cf708f4);
}

// Namespace zm_transform/zm_transformation
// Params 1, eflags: 0x1 linked
// Checksum 0x9c790886, Offset: 0xbe0
// Size: 0x68
function function_bdd8aba6(id) {
    if (!isdefined(level.var_b175714d[id])) {
        /#
            iprintlnbold("<dev string:x32c>" + id + "<dev string:x294>");
        #/
        return;
    }
    level.var_b175714d[id].var_33e393a7++;
}

// Namespace zm_transform/zm_transformation
// Params 1, eflags: 0x0
// Checksum 0x58fe10fc, Offset: 0xc50
// Size: 0x58
function function_3f502557(id) {
    assert(level.var_b175714d[id].var_33e393a7 > 0);
    level.var_b175714d[id].var_33e393a7--;
}

// Namespace zm_transform/zm_transformation
// Params 2, eflags: 0x1 linked
// Checksum 0x1dc27489, Offset: 0xcb0
// Size: 0x1a4
function function_d2374144(entity, id) {
    assert(!is_true(entity.var_69a981e6));
    assert(!isinarray(level.var_b175714d[id].var_2939a01a, entity));
    assert(!is_true(entity.var_d41ca76d));
    entity.var_d41ca76d = id;
    if (!isdefined(level.var_b175714d[id].var_2939a01a)) {
        level.var_b175714d[id].var_2939a01a = [];
    } else if (!isarray(level.var_b175714d[id].var_2939a01a)) {
        level.var_b175714d[id].var_2939a01a = array(level.var_b175714d[id].var_2939a01a);
    }
    level.var_b175714d[id].var_2939a01a[level.var_b175714d[id].var_2939a01a.size] = entity;
    entity thread function_525526be(id);
}

// Namespace zm_transform/zm_transformation
// Params 1, eflags: 0x1 linked
// Checksum 0xe9cab024, Offset: 0xe60
// Size: 0x80
function function_1afce5aa(entity) {
    assert(isdefined(entity.var_d41ca76d));
    assert(isinarray(level.var_b175714d[entity.var_d41ca76d].var_2939a01a, entity));
    entity notify(#"hash_610e5a8c0ec1a4b6");
}

// Namespace zm_transform/zm_transformation
// Params 1, eflags: 0x1 linked
// Checksum 0xa8f1f308, Offset: 0xee8
// Size: 0x18
function function_331869(entity) {
    return isdefined(entity.var_d41ca76d);
}

// Namespace zm_transform/zm_transformation
// Params 1, eflags: 0x1 linked
// Checksum 0xd93b7369, Offset: 0xf08
// Size: 0x110
function function_e95ec8df(*clear_active) {
    foreach (transformation in level.var_b175714d) {
        transformation.var_33e393a7 = 0;
        foreach (var_d41ca76d in transformation.var_2939a01a) {
            var_d41ca76d notify(#"hash_610e5a8c0ec1a4b6");
        }
    }
}

// Namespace zm_transform/zm_transformation
// Params 0, eflags: 0x1 linked
// Checksum 0x7bbf470a, Offset: 0x1020
// Size: 0x1ce
function function_fb608075() {
    if (!isdefined(level.var_ebccd551) || level.var_ebccd551.size == 0) {
        return;
    }
    var_4ff6ca41 = [];
    foreach (transformation in level.var_ebccd551) {
        if (isinarray(var_4ff6ca41, transformation.id)) {
            continue;
        }
        var_167b5341 = level.var_b175714d[transformation.id];
        if (is_true(transformation.var_ad4fb608)) {
            level scene::function_f81475ae(var_167b5341.var_99fca475);
            transformation.var_ad4fb608 = 0;
        }
        level scene::stop(var_167b5341.var_44c5827d, 1);
        level scene::stop(var_167b5341.var_99fca475, 1);
        if (!isdefined(var_4ff6ca41)) {
            var_4ff6ca41 = [];
        } else if (!isarray(var_4ff6ca41)) {
            var_4ff6ca41 = array(var_4ff6ca41);
        }
        var_4ff6ca41[var_4ff6ca41.size] = transformation.id;
    }
}

// Namespace zm_transform/zm_transformation
// Params 2, eflags: 0x0
// Checksum 0xff15385, Offset: 0x11f8
// Size: 0x98
function function_5db4f2f5(entity, var_8763d10e) {
    if (!isdefined(entity) || is_true(entity.var_69a981e6)) {
        return false;
    }
    entity.var_982f937 = 1;
    if (is_true(var_8763d10e) && function_331869(entity)) {
        function_1afce5aa(entity);
    }
    return true;
}

// Namespace zm_transform/zm_transformation
// Params 1, eflags: 0x0
// Checksum 0xb4431cef, Offset: 0x1298
// Size: 0x16
function function_1a1cb53(entity) {
    entity.var_982f937 = undefined;
}

// Namespace zm_transform/zm_transformation
// Params 1, eflags: 0x1 linked
// Checksum 0xbb63792, Offset: 0x12b8
// Size: 0x1c
function function_a261938f(entity) {
    return entity.var_982f937 !== 1;
}

// Namespace zm_transform/zm_transformation
// Params 1, eflags: 0x5 linked
// Checksum 0xb3c77217, Offset: 0x12e0
// Size: 0xb6
function private function_525526be(id) {
    waitresult = self waittill(#"death", #"transformation_started", #"hash_610e5a8c0ec1a4b6");
    if (waitresult._notify != "death") {
        self.var_d41ca76d = undefined;
    }
    arrayremovevalue(level.var_b175714d[id].var_2939a01a, self);
    /#
        self notify(#"hash_6e3d9f8c484e3d01");
    #/
}

// Namespace zm_transform/zm_transformation
// Params 2, eflags: 0x5 linked
// Checksum 0x6310fe83, Offset: 0x13a0
// Size: 0x5c
function private function_4e679db4(id, def) {
    if (isdefined(def.spawner)) {
        def.spawner.var_ab46c56 = id;
        return;
    }
    if (isdefined(def.aitype)) {
        level.var_170852dc[def.aitype] = id;
    }
}

// Namespace zm_transform/zm_transformation
// Params 2, eflags: 0x5 linked
// Checksum 0x605616a2, Offset: 0x1408
// Size: 0xc8
function private function_c81eb299(id, def) {
    if (isdefined(def.spawner)) {
        assert(def.spawner.var_ab46c56 == id, "<dev string:x356>");
        def.spawner.var_ab46c56 = undefined;
        return;
    }
    if (isdefined(def.aitype)) {
        assert(level.var_170852dc[def.aitype] == id, "<dev string:x356>");
        level.var_170852dc[def.aitype] = undefined;
    }
}

// Namespace zm_transform/zm_transformation
// Params 1, eflags: 0x5 linked
// Checksum 0x6dde196b, Offset: 0x14d8
// Size: 0x74
function private function_1050ba72(def) {
    if (isdefined(def.spawner)) {
        return def.spawner spawnfromspawner(0, 1);
    }
    if (isdefined(def.aitype)) {
        return spawnactor(def.aitype, (0, 0, 0), (0, 0, 0), undefined, 1);
    }
}

// Namespace zm_transform/zm_transformation
// Params 3, eflags: 0x5 linked
// Checksum 0x48e703e9, Offset: 0x1558
// Size: 0xbb6
function private transform(id, var_c2a69066, var_2cf708f4 = 1) {
    level endon(#"end_game");
    if (function_abf1dcb4(id)) {
        return;
    }
    var_167b5341 = level.var_b175714d[id];
    function_4e679db4(id, var_167b5341);
    var_e236d061 = {#id:id, #var_1a90140:self};
    if (!isdefined(level.var_ebccd551)) {
        level.var_ebccd551 = [];
    } else if (!isarray(level.var_ebccd551)) {
        level.var_ebccd551 = array(level.var_ebccd551);
    }
    level.var_ebccd551[level.var_ebccd551.size] = var_e236d061;
    aitype = isdefined(var_167b5341.spawner) ? var_167b5341.spawner.aitype : var_167b5341.aitype;
    if (isdefined(aitype)) {
        var_e236d061.archetype = getarchetypefromclassname(aitype);
    }
    self.var_69a981e6 = 1;
    self.var_e236d061 = var_e236d061;
    var_e3920264 = self.var_e3920264;
    n_health_percent = min(self.health / self.maxhealth, 1);
    self notify(#"transformation_started");
    if (isdefined(var_167b5341.intro_func)) {
        self [[ var_167b5341.intro_func ]]();
    }
    if (!isdefined(self) || !isalive(self)) {
        arrayremovevalue(level.var_ebccd551, var_e236d061);
        function_c81eb299(id, var_167b5341);
        level notify(#"transformation_interrupted", {#id:id});
        return;
    }
    if (!isdefined(var_167b5341.var_44c5827d)) {
        var_944250d2 = function_1050ba72(var_167b5341);
        if (!isdefined(var_944250d2) || !isalive(var_944250d2)) {
            function_c81eb299(id, var_167b5341);
            arrayremovevalue(level.var_ebccd551, var_e236d061);
            level notify(#"transformation_interrupted", {#id:id});
            return;
        }
        var_e236d061.var_944250d2 = var_944250d2;
        var_944250d2.health = int(max(var_944250d2.health * n_health_percent, 1));
        var_944250d2.var_e236d061 = var_e236d061;
        var_944250d2._starting_round_number = self._starting_round_number;
        function_c81eb299(id, var_167b5341);
        if (isdefined(var_167b5341.outro_func)) {
            var_944250d2 [[ var_167b5341.outro_func ]](n_health_percent);
        }
        var_944250d2 forceteleport(self.origin, self.angles);
        self zombie_utility::gib_random_parts();
        gibserverutils::annihilate(self);
        self val::set(#"zm_transformation", "hide", 2);
        if (var_2cf708f4) {
            self kill();
        }
        if (isdefined(var_c2a69066)) {
            thread [[ var_c2a69066 ]](var_944250d2);
        }
    } else {
        script_origin = {#origin:self.origin, #angles:self.angles};
        self val::set(#"zm_transformation", "ignoreall");
        a_ents = undefined;
        a_ents = array(self);
        self.animname = "spawner_zm_zombie";
        if (!isdefined(var_167b5341.var_accb1c92)) {
            self clientfield::set("transformation_stream_split", 1);
        }
        var_e236d061.var_ad4fb608 = 1;
        level scene::function_27f5972e(var_167b5341.var_99fca475);
        script_origin scene::play(var_167b5341.var_44c5827d, a_ents);
        if (!isdefined(self) || !isalive(self)) {
            if (isdefined(self)) {
                self clientfield::set("transformation_stream_split", 0);
            }
            var_e236d061.var_ad4fb608 = 0;
            level scene::function_f81475ae(var_167b5341.var_99fca475);
            arrayremovevalue(level.var_ebccd551, var_e236d061);
            function_c81eb299(id, var_167b5341);
            level notify(#"transformation_interrupted", {#id:id});
            return;
        }
        if (isdefined(var_167b5341.var_accb1c92)) {
            [[ var_167b5341.var_accb1c92 ]](self, var_167b5341);
        } else {
            settingsbundle = self ai::function_9139c839();
            if (isdefined(settingsbundle) && isdefined(settingsbundle.var_d354164e)) {
                foreach (var_127d3a7a in settingsbundle.var_d354164e) {
                    if (self.model === var_127d3a7a.var_a3c9023c) {
                        self.no_gib = 1;
                        self setmodel(var_127d3a7a.var_cdf1f53d);
                        break;
                    }
                }
            }
        }
        self clientfield::set("transformation_stream_split", 0);
        var_e236d061.var_ad4fb608 = 0;
        level scene::function_f81475ae(var_167b5341.var_99fca475);
        self zombie_eye_glow::function_95cae3e3();
        var_944250d2 = function_1050ba72(var_167b5341);
        if (!isalive(var_944250d2)) {
            arrayremovevalue(level.var_ebccd551, var_e236d061);
            function_c81eb299(id, var_167b5341);
            level notify(#"transformation_interrupted", {#id:id});
            return;
        }
        var_e236d061.var_944250d2 = var_944250d2;
        var_944250d2 function_bbaec2fd();
        var_944250d2.var_e236d061 = var_e236d061;
        var_944250d2._starting_round_number = self._starting_round_number;
        function_c81eb299(id, var_167b5341);
        if (isdefined(var_167b5341.outro_func)) {
            var_944250d2 [[ var_167b5341.outro_func ]](n_health_percent);
        }
        if (!isdefined(var_944250d2) || !isalive(var_944250d2)) {
            arrayremovevalue(level.var_ebccd551, var_e236d061);
            level notify(#"transformation_interrupted", {#id:id});
            return;
        }
        a_ents = array(var_944250d2, self);
        self callback::function_d8abfc3d(#"on_ai_killed", &function_a51fe6f9, undefined, array(var_944250d2));
        script_origin scene::play(var_167b5341.var_99fca475, a_ents);
        if (isdefined(self)) {
            self callback::function_52ac9652(#"on_ai_killed", &function_a51fe6f9);
        }
        if (!isdefined(var_944250d2) || !isalive(var_944250d2)) {
            if (isdefined(self) && isalive(self) && self.allowdeath) {
                self kill();
            }
            arrayremovevalue(level.var_ebccd551, var_e236d061);
            level notify(#"transformation_interrupted", {#id:id});
            return;
        }
    }
    var_944250d2.var_e236d061 = undefined;
    arrayremovevalue(level.var_ebccd551, var_e236d061);
    level notify(#"transformation_complete", {#var_944250d2:array(var_944250d2), #id:id, #data:var_e3920264});
    if (isdefined(var_c2a69066)) {
        thread [[ var_c2a69066 ]](var_944250d2);
    }
}

// Namespace zm_transform/zm_transformation
// Params 2, eflags: 0x5 linked
// Checksum 0x91cd6fe7, Offset: 0x2118
// Size: 0xb4
function private function_a51fe6f9(params, var_944250d2) {
    if (isdefined(var_944250d2) && isalive(var_944250d2) && var_944250d2.allowdeath && isdefined(params.eattacker) && isplayer(params.eattacker)) {
        var_944250d2 kill(undefined, params.eattacker, params.einflictor, params.weapon, 0, 1);
    }
}

// Namespace zm_transform/zm_transformation
// Params 0, eflags: 0x5 linked
// Checksum 0x8f8fdf25, Offset: 0x21d8
// Size: 0x8e
function private function_c3a1379e() {
    return !is_true(level.var_c9f5947d) && zombie_utility::get_current_zombie_count() + level.zombie_total <= 10 && !is_true(level.var_78acec0a) && !level flag::get(#"infinite_round_spawning");
}

// Namespace zm_transform/zm_transformation
// Params 2, eflags: 0x5 linked
// Checksum 0xa9391fb5, Offset: 0x2270
// Size: 0x2b2
function private function_fad54d94(id, var_167b5341) {
    level endon(#"hash_670ec83e1acfadff", #"game_ended");
    if (var_167b5341.var_2939a01a.size > 0) {
        foreach (zombie in var_167b5341.var_2939a01a) {
            if (function_a261938f(zombie) && isdefined(var_167b5341.condition) && zombie [[ var_167b5341.condition ]]()) {
                zombie thread transform(id);
                return true;
            }
        }
    }
    if (var_167b5341.var_33e393a7 > 0) {
        zombies = zombie_utility::get_round_enemy_array();
        foreach (zombie in zombies) {
            if (!isdefined(zombie) || !isalive(zombie) || function_331869(zombie)) {
                continue;
            }
            if (function_a261938f(zombie) && isdefined(var_167b5341.condition) && zombie [[ var_167b5341.condition ]]()) {
                zombie thread transform(id);
                var_167b5341.var_33e393a7--;
                level.var_138b37c4++;
                if (level.var_138b37c4 >= 6) {
                    waitframe(1);
                    level.var_138b37c4 = 0;
                }
                return true;
            }
            level.var_138b37c4++;
            if (level.var_138b37c4 >= 6) {
                waitframe(1);
                level.var_138b37c4 = 0;
            }
        }
    }
    return false;
}

// Namespace zm_transform/zm_transformation
// Params 0, eflags: 0x5 linked
// Checksum 0xf358bbb1, Offset: 0x2530
// Size: 0x342
function private update() {
    level endoncallback(&function_4c0d0d28, #"end_game");
    var_52f926ed = 0;
    level.var_138b37c4 = 0;
    var_f38e5f93 = isdefined(level.var_f38e5f93) ? level.var_f38e5f93 : 1;
    while (true) {
        if (is_true(var_52f926ed)) {
            wait var_f38e5f93;
        } else {
            wait 0.2;
        }
        level flag::wait_till_clear(#"hash_670ec83e1acfadff");
        if (function_c3a1379e()) {
            level notify(#"hash_239ebc19aab5a60b");
            function_e95ec8df();
            level waittill(#"start_of_round", #"force_transformations");
        }
        var_52f926ed = 0;
        time = gettime();
        keys = array::randomize(getarraykeys(level.var_b175714d));
        foreach (id in keys) {
            transformation = level.var_b175714d[id];
            if (level flag::get(#"hash_670ec83e1acfadff") || function_c3a1379e()) {
                break;
            }
            pixbeginevent("zm_transformation_update");
            if (transformation.var_ebaa8de9 > time) {
                pixendevent();
                continue;
            }
            if (function_abf1dcb4(id)) {
                pixendevent();
                continue;
            }
            var_52f926ed = function_fad54d94(id, transformation);
            pixendevent();
            if (is_true(var_52f926ed)) {
                transformation.var_ebaa8de9 = is_true(level.var_78acec0a) ? gettime() : gettime() + transformation.cooldown_time * 1000;
                break;
            }
        }
    }
}

// Namespace zm_transform/zm_transformation
// Params 1, eflags: 0x5 linked
// Checksum 0x8a883f1c, Offset: 0x2880
// Size: 0x2c
function private function_4c0d0d28(*var_201c5b1f) {
    function_e95ec8df();
    function_fb608075();
}

// Namespace zm_transform/zm_transformation
// Params 0, eflags: 0x1 linked
// Checksum 0xc046e54f, Offset: 0x28b8
// Size: 0x24
function function_bbaec2fd() {
    self clientfield::set("transformation_spawn", 1);
}

/#

    // Namespace zm_transform/zm_transformation
    // Params 0, eflags: 0x4
    // Checksum 0xfedcaa6d, Offset: 0x28e8
    // Size: 0x4de
    function private devgui() {
        level waittill(#"start_zombie_round_logic");
        adddebugcommand("<dev string:x392>");
        adddebugcommand("<dev string:x3ef>");
        adddebugcommand("<dev string:x43e>");
        adddebugcommand("<dev string:x48f>");
        foreach (id, transformation in level.var_b175714d) {
            adddebugcommand("<dev string:x4fc>" + function_9e72a96(id) + "<dev string:x524>" + function_9e72a96(id) + "<dev string:x54f>");
            adddebugcommand("<dev string:x555>" + function_9e72a96(id) + "<dev string:x57d>" + function_9e72a96(id) + "<dev string:x54f>");
            adddebugcommand("<dev string:x5a8>" + function_9e72a96(id) + "<dev string:x5d0>" + function_9e72a96(id) + "<dev string:x54f>");
        }
        registershack_walla = 0;
        while (true) {
            wait 0.2;
            cmd = getdvarstring(#"hash_439ed91bbc9ac4c0", "<dev string:x107>");
            if (cmd == "<dev string:x107>") {
                continue;
            }
            setdvar(#"hash_439ed91bbc9ac4c0", "<dev string:x107>");
            cmd = strtok(cmd, "<dev string:x5fb>");
            switch (cmd[0]) {
            case #"toggle_status":
                registershack_walla = !registershack_walla;
                if (!registershack_walla) {
                    level notify(#"hash_53f34619e212c4cd");
                } else {
                    level thread show_status();
                }
                break;
            case #"force":
                var_167b5341 = level.var_b175714d[cmd[1]];
                if (!isdefined(var_167b5341)) {
                    break;
                }
                level thread function_3d080ace(cmd[1]);
                break;
            case #"spawn":
                var_167b5341 = level.var_b175714d[cmd[1]];
                if (!isdefined(var_167b5341)) {
                    break;
                }
                level.var_78acec0a = 1;
                level notify(#"force_transformations");
                level thread function_2f40be20(cmd[1]);
                break;
            case #"queue":
                level.var_78acec0a = 1;
                level notify(#"force_transformations");
                function_bdd8aba6(cmd[1]);
                break;
            case #"pause":
                function_4da8230b(#"hash_7a79688cef85b533");
                break;
            case #"resume":
                function_6b183c78(#"hash_7a79688cef85b533");
                break;
            case #"hash_5893e94d64f92905":
                function_6bcb49b5();
                break;
            }
        }
    }

    // Namespace zm_transform/zm_transformation
    // Params 0, eflags: 0x0
    // Checksum 0x81566130, Offset: 0x2dd0
    // Size: 0x22
    function function_ece5c99c() {
        self.zombie_think_done = 1;
        self.completed_emerging_into_playable_area = 1;
    }

    // Namespace zm_transform/zm_transformation
    // Params 0, eflags: 0x0
    // Checksum 0xb1a73a8e, Offset: 0x2e00
    // Size: 0x1ea
    function function_3f433f41() {
        if (!isdefined(level.zombie_spawners)) {
            return;
        }
        player = level.players[0];
        direction = player getplayerangles();
        direction_vec = anglestoforward(direction);
        eye = player geteye();
        scale = 8000;
        direction_vec = (direction_vec[0] * scale, direction_vec[1] * scale, direction_vec[2] * scale);
        trace = bullettrace(eye, eye + direction_vec, 0, undefined);
        if (trace[#"fraction"] >= 1) {
            return;
        }
        random_spawner = array::random(level.zombie_spawners);
        zombie = random_spawner spawnfromspawner(random_spawner.targetname, 1, 0, 1);
        zombie.custom_location = &function_ece5c99c;
        zombie.b_ignore_cleanup = 1;
        if (!isdefined(zombie)) {
            return;
        }
        zombie forceteleport(trace[#"position"], player.angles + (0, 180, 0));
        return zombie;
    }

    // Namespace zm_transform/zm_transformation
    // Params 1, eflags: 0x4
    // Checksum 0x913ad951, Offset: 0x2ff8
    // Size: 0x94
    function private function_3d080ace(var_70d26bfb) {
        zombie = function_3f433f41();
        if (!isdefined(zombie)) {
            return;
        }
        zombie endon(#"death");
        wait 0.5;
        while (function_abf1dcb4(var_70d26bfb)) {
            waitframe(1);
        }
        function_9acf76e6(zombie, var_70d26bfb);
    }

    // Namespace zm_transform/zm_transformation
    // Params 1, eflags: 0x4
    // Checksum 0xdb69967f, Offset: 0x3098
    // Size: 0x74
    function private function_2f40be20(var_70d26bfb) {
        zombie = function_3f433f41();
        if (!isdefined(zombie)) {
            return;
        }
        zombie endon(#"death");
        zombie.var_641025d6 = gettime() + 500;
        function_d2374144(zombie, var_70d26bfb);
    }

    // Namespace zm_transform/zm_transformation
    // Params 1, eflags: 0x4
    // Checksum 0x8f6f32cd, Offset: 0x3118
    // Size: 0x110
    function private function_4bad29d9(*notifyhash) {
        foreach (var_deb567a8 in level.var_deb567a8) {
            if (!isdefined(var_deb567a8.id)) {
                var_deb567a8.var_735311f0 destroy();
            }
            var_deb567a8.title destroy();
            var_deb567a8.var_d189697d destroy();
            var_deb567a8.var_b99573ec destroy();
        }
        level.var_deb567a8 = undefined;
        level notify(#"hash_6e3d9f8c484e3d01");
    }

    // Namespace zm_transform/zm_transformation
    // Params 2, eflags: 0x4
    // Checksum 0x8979ac26, Offset: 0x3230
    // Size: 0xa4
    function private create_hudelem(y, x) {
        if (!isdefined(x)) {
            x = 0;
        }
        var_aa917a22 = newdebughudelem();
        var_aa917a22.alignx = "<dev string:x600>";
        var_aa917a22.horzalign = "<dev string:x600>";
        var_aa917a22.aligny = "<dev string:x608>";
        var_aa917a22.vertalign = "<dev string:x612>";
        var_aa917a22.y = y;
        var_aa917a22.x = x;
        return var_aa917a22;
    }

    // Namespace zm_transform/zm_transformation
    // Params 0, eflags: 0x4
    // Checksum 0x287d2395, Offset: 0x32e0
    // Size: 0x494
    function private setup_status() {
        level.var_deb567a8 = array();
        y = 10;
        colors = array((1, 1, 1));
        var_e859a426 = create_hudelem(y);
        var_e859a426 settext("<dev string:x619>");
        y += 10;
        var_735311f0 = create_hudelem(y);
        var_af5fbf35 = create_hudelem(y, 160);
        var_af5fbf35 settext("<dev string:x639>");
        var_f4676cb4 = create_hudelem(y, 220);
        var_f4676cb4 settext("<dev string:x64c>");
        if (!isdefined(level.var_deb567a8)) {
            level.var_deb567a8 = [];
        } else if (!isarray(level.var_deb567a8)) {
            level.var_deb567a8 = array(level.var_deb567a8);
        }
        level.var_deb567a8[level.var_deb567a8.size] = {#title:var_e859a426, #var_d189697d:var_af5fbf35, #var_b99573ec:var_f4676cb4, #var_735311f0:var_735311f0};
        i = 0;
        foreach (id, transformation in level.var_b175714d) {
            y += 10;
            current_color = colors[i % colors.size];
            id_elem = create_hudelem(y);
            id_elem settext(function_9e72a96(id));
            id_elem.color = current_color;
            id_elem.fontscale = 1.2;
            var_83db7237 = create_hudelem(y, 160);
            var_83db7237 settext(0);
            var_83db7237.color = current_color;
            var_83db7237.fontscale = 1.2;
            var_82f71158 = create_hudelem(y, 220);
            var_82f71158 settext(0);
            var_82f71158.color = current_color;
            var_82f71158.fontscale = 1.2;
            if (!isdefined(level.var_deb567a8)) {
                level.var_deb567a8 = [];
            } else if (!isarray(level.var_deb567a8)) {
                level.var_deb567a8 = array(level.var_deb567a8);
            }
            level.var_deb567a8[level.var_deb567a8.size] = {#title:id_elem, #var_d189697d:var_83db7237, #var_b99573ec:var_82f71158, #id:id, #color:current_color};
            i++;
        }
    }

    // Namespace zm_transform/zm_transformation
    // Params 1, eflags: 0x4
    // Checksum 0x9f2ef8f0, Offset: 0x3780
    // Size: 0x1a
    function private function_9aa982db(*notifyhash) {
        self.var_30acf8aa = undefined;
    }

    // Namespace zm_transform/zm_transformation
    // Params 2, eflags: 0x4
    // Checksum 0x304fc527, Offset: 0x37a8
    // Size: 0xce
    function private function_4a065e66(id, color) {
        self endoncallback(&function_9aa982db, #"death", #"hash_6e3d9f8c484e3d01");
        level endoncallback(&function_9aa982db, #"hash_6e3d9f8c484e3d01");
        self.var_30acf8aa = 1;
        while (true) {
            record3dtext(function_9e72a96(id), self.origin + (0, 0, self.maxs[2]), color);
            waitframe(1);
        }
    }

    // Namespace zm_transform/zm_transformation
    // Params 0, eflags: 0x4
    // Checksum 0x65123561, Offset: 0x3880
    // Size: 0x260
    function private show_status() {
        level notify(#"hash_53f34619e212c4cd");
        level endoncallback(&function_4bad29d9, #"hash_53f34619e212c4cd");
        setup_status();
        while (true) {
            waitframe(1);
            foreach (var_deb567a8 in level.var_deb567a8) {
                if (!isdefined(var_deb567a8.id)) {
                    var_deb567a8.var_735311f0 settext(function_770908a2() ? "<dev string:x668>" : "<dev string:x107>");
                    continue;
                }
                var_deb567a8.var_d189697d settext(level.var_b175714d[var_deb567a8.id].var_33e393a7);
                var_deb567a8.var_b99573ec settext(level.var_b175714d[var_deb567a8.id].var_2939a01a.size);
                foreach (ai in level.var_b175714d[var_deb567a8.id].var_2939a01a) {
                    if (!is_true(ai.var_30acf8aa)) {
                        ai thread function_4a065e66(var_deb567a8.id, var_deb567a8.color);
                    }
                }
            }
        }
    }

    // Namespace zm_transform/zm_transformation
    // Params 0, eflags: 0x4
    // Checksum 0x2ad18a40, Offset: 0x3ae8
    // Size: 0x54
    function private function_6bcb49b5() {
        level.var_dfd1a1c0 = !is_true(level.var_dfd1a1c0);
        if (level.var_dfd1a1c0) {
            level thread function_dfd1a1c0();
        }
    }

    // Namespace zm_transform/zm_transformation
    // Params 0, eflags: 0x4
    // Checksum 0x87b5d45a, Offset: 0x3b48
    // Size: 0x168
    function private function_dfd1a1c0() {
        self notify("<dev string:x672>");
        self endon("<dev string:x672>");
        while (level.var_dfd1a1c0) {
            var_c2624dfc = 200;
            var_b010a959 = 100;
            debug2dtext((var_c2624dfc, var_b010a959, 0), "<dev string:x686>", (1, 1, 0), 1, (0, 0, 0), 0.8, 1);
            var_b010a959 += 25;
            foreach (pauser in level.var_50f7dbd5) {
                debug2dtext((var_c2624dfc, var_b010a959, 0), function_9e72a96(pauser), (1, 1, 1), 1, (0, 0, 0), 0.8, 1);
                var_b010a959 += 25;
            }
            waitframe(1);
        }
    }

#/