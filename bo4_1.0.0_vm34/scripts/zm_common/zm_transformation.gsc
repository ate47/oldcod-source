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
// Params 0, eflags: 0x2
// Checksum 0x33789203, Offset: 0x138
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"zm_transform", &__init__, undefined, undefined);
}

// Namespace zm_transform/zm_transformation
// Params 0, eflags: 0x0
// Checksum 0x6f44438e, Offset: 0x180
// Size: 0xe4
function __init__() {
    level.var_deb579ca = [];
    level thread update();
    clientfield::register("actor", "transformation_spawn", 1, 1, "int");
    clientfield::register("actor", "transformation_stream_split", 1, 1, "int");
    level flag::init(#"hash_670ec83e1acfadff");
    level.var_3fe0cd = [];
    level.var_19efff41 = [];
    /#
        level thread devgui();
    #/
}

// Namespace zm_transform/zm_transformation
// Params 1, eflags: 0x0
// Checksum 0xeeafe097, Offset: 0x270
// Size: 0x108
function function_bfc50dca(var_518f4754) {
    assert(ishash(var_518f4754), "<dev string:x30>");
    if (!isdefined(level.var_3fe0cd)) {
        level.var_3fe0cd = [];
    } else if (!isarray(level.var_3fe0cd)) {
        level.var_3fe0cd = array(level.var_3fe0cd);
    }
    level.var_3fe0cd[level.var_3fe0cd.size] = var_518f4754;
    if (level.var_3fe0cd.size == 1) {
        level flag::set(#"hash_670ec83e1acfadff");
        level notify(#"hash_239ebc19aab5a60b");
    }
}

// Namespace zm_transform/zm_transformation
// Params 1, eflags: 0x0
// Checksum 0x1d500fff, Offset: 0x380
// Size: 0x124
function function_5eefd607(var_518f4754) {
    assert(ishash(var_518f4754), "<dev string:x68>");
    foreach (index, name_hash in level.var_3fe0cd) {
        if (name_hash == var_518f4754) {
            var_43d67a7a = index;
            break;
        }
    }
    if (!isdefined(var_43d67a7a)) {
        return;
    }
    arrayremoveindex(level.var_3fe0cd, var_43d67a7a);
    if (level.var_3fe0cd.size == 0) {
        level flag::clear(#"hash_670ec83e1acfadff");
    }
}

// Namespace zm_transform/zm_transformation
// Params 0, eflags: 0x0
// Checksum 0xa0edc8ab, Offset: 0x4b0
// Size: 0x22
function function_b312d5a2() {
    return level flag::get(#"hash_670ec83e1acfadff");
}

// Namespace zm_transform/zm_transformation
// Params 9, eflags: 0x0
// Checksum 0xde379578, Offset: 0x4e0
// Size: 0x37e
function function_17652056(spawner, id, condition_func, cooldown_time, intro_func, outro_func, var_2cf5cfec, var_3048f365, var_4cc7cab2) {
    assert(!isdefined(level.var_deb579ca[id]));
    /#
        if (!isdefined(spawner)) {
            println("<dev string:xa1>" + id + "<dev string:xbc>");
            return;
        }
        if (isdefined(var_3048f365)) {
            if (!isdefined(spawner.targetname) || spawner.targetname == "<dev string:xe5>") {
                println("<dev string:xa1>" + id + "<dev string:xe6>" + var_3048f365 + "<dev string:x103>");
                return;
            }
            var_26fd24d7 = 0;
            scenedef = scene::get_scenedef(var_3048f365);
            foreach (object in scenedef.objects) {
                if (object.type === "<dev string:x116>" && object.name === spawner.targetname) {
                    var_26fd24d7 = 1;
                    break;
                }
            }
            if (!var_26fd24d7) {
                println("<dev string:xa1>" + id + "<dev string:x11c>" + spawner.targetname);
                return;
            }
        }
        if (isdefined(var_2cf5cfec) && !isdefined(var_3048f365)) {
            println("<dev string:xa1>" + id + "<dev string:x15f>");
            return;
        }
        if (!isdefined(var_2cf5cfec) && isdefined(var_3048f365)) {
            println("<dev string:xa1>" + id + "<dev string:x1aa>");
            return;
        }
    #/
    level.var_deb579ca[id] = {#spawner:spawner, #condition:condition_func, #intro_func:intro_func, #outro_func:outro_func, #var_4cc7cab2:var_4cc7cab2, #var_2cf5cfec:var_2cf5cfec, #var_3048f365:var_3048f365, #cooldown_time:cooldown_time, #var_b39e10c4:0, #var_39491bdc:0, #var_10663a7f:[]};
}

// Namespace zm_transform/zm_transformation
// Params 1, eflags: 0x0
// Checksum 0x361665ec, Offset: 0x868
// Size: 0x60
function function_5836d278(id) {
    if (level.var_19efff41.size >= 10) {
        return true;
    }
    if (isdefined(level.var_deb579ca[id])) {
        return isdefined(level.var_deb579ca[id].spawner.var_1b360588);
    }
    return false;
}

// Namespace zm_transform/zm_transformation
// Params 3, eflags: 0x0
// Checksum 0x3f94b539, Offset: 0x8d0
// Size: 0x15c
function function_3b866d7e(entity, id, var_ee406a8f) {
    if (!isdefined(level.var_deb579ca[id])) {
        /#
            iprintlnbold("<dev string:x1f5>" + id + "<dev string:x21c>");
        #/
        return;
    }
    if (isdefined(entity.var_3059fa07) && entity.var_3059fa07) {
        /#
            iprintlnbold("<dev string:x230>" + id + "<dev string:x24f>");
        #/
        return;
    }
    if (function_5836d278(id)) {
        /#
            iprintlnbold("<dev string:x230>" + id + "<dev string:x274>");
        #/
        return;
    }
    if (function_49c8ea64(entity)) {
        function_a0a2a734(entity);
    }
    var_50281e3a = level.var_deb579ca[id];
    entity thread transform(id, var_ee406a8f);
}

// Namespace zm_transform/zm_transformation
// Params 1, eflags: 0x0
// Checksum 0x6b5dad20, Offset: 0xa38
// Size: 0x68
function function_5dbbf742(id) {
    if (!isdefined(level.var_deb579ca[id])) {
        /#
            iprintlnbold("<dev string:x2a8>" + id + "<dev string:x21c>");
        #/
        return;
    }
    level.var_deb579ca[id].var_39491bdc++;
}

// Namespace zm_transform/zm_transformation
// Params 1, eflags: 0x0
// Checksum 0x75f4c8d9, Offset: 0xaa8
// Size: 0x58
function function_58822cc7(id) {
    assert(level.var_deb579ca[id].var_39491bdc > 0);
    level.var_deb579ca[id].var_39491bdc--;
}

// Namespace zm_transform/zm_transformation
// Params 2, eflags: 0x0
// Checksum 0x681b96a3, Offset: 0xb08
// Size: 0x1ac
function function_78f90f3b(entity, id) {
    assert(!(isdefined(entity.var_3059fa07) && entity.var_3059fa07));
    assert(!isinarray(level.var_deb579ca[id].var_10663a7f, entity));
    assert(!(isdefined(entity.var_767adb17) && entity.var_767adb17));
    entity.var_767adb17 = id;
    if (!isdefined(level.var_deb579ca[id].var_10663a7f)) {
        level.var_deb579ca[id].var_10663a7f = [];
    } else if (!isarray(level.var_deb579ca[id].var_10663a7f)) {
        level.var_deb579ca[id].var_10663a7f = array(level.var_deb579ca[id].var_10663a7f);
    }
    level.var_deb579ca[id].var_10663a7f[level.var_deb579ca[id].var_10663a7f.size] = entity;
    entity thread function_cde671d4(id);
}

// Namespace zm_transform/zm_transformation
// Params 1, eflags: 0x0
// Checksum 0xca896912, Offset: 0xcc0
// Size: 0x88
function function_a0a2a734(entity) {
    assert(isdefined(entity.var_767adb17));
    assert(isinarray(level.var_deb579ca[entity.var_767adb17].var_10663a7f, entity));
    entity notify(#"hash_610e5a8c0ec1a4b6");
}

// Namespace zm_transform/zm_transformation
// Params 1, eflags: 0x0
// Checksum 0xbbbf7111, Offset: 0xd50
// Size: 0x18
function function_49c8ea64(entity) {
    return isdefined(entity.var_767adb17);
}

// Namespace zm_transform/zm_transformation
// Params 1, eflags: 0x0
// Checksum 0x5bbf8adc, Offset: 0xd70
// Size: 0x108
function function_204b0737(clear_active = 0) {
    foreach (transformation in level.var_deb579ca) {
        transformation.var_39491bdc = 0;
        foreach (var_767adb17 in transformation.var_10663a7f) {
            var_767adb17 notify(#"hash_610e5a8c0ec1a4b6");
        }
    }
}

// Namespace zm_transform/zm_transformation
// Params 0, eflags: 0x0
// Checksum 0x9d6d0825, Offset: 0xe80
// Size: 0x1d4
function function_21175562() {
    if (!isdefined(level.var_19efff41) || level.var_19efff41.size == 0) {
        return;
    }
    var_246ff38e = [];
    foreach (transformation in level.var_19efff41) {
        if (isinarray(var_246ff38e, transformation.id)) {
            continue;
        }
        var_50281e3a = level.var_deb579ca[transformation.id];
        if (isdefined(transformation.var_3ff537b) && transformation.var_3ff537b) {
            level scene::function_a87de75b(var_50281e3a.var_3048f365);
            transformation.var_3ff537b = 0;
        }
        level scene::stop(var_50281e3a.var_2cf5cfec, 1);
        level scene::stop(var_50281e3a.var_3048f365, 1);
        if (!isdefined(var_246ff38e)) {
            var_246ff38e = [];
        } else if (!isarray(var_246ff38e)) {
            var_246ff38e = array(var_246ff38e);
        }
        var_246ff38e[var_246ff38e.size] = transformation.id;
    }
}

// Namespace zm_transform/zm_transformation
// Params 2, eflags: 0x0
// Checksum 0x40f4e4d8, Offset: 0x1060
// Size: 0x88
function function_244dda40(entity, var_f3eee679) {
    if (isdefined(entity.var_3059fa07) && entity.var_3059fa07) {
        return false;
    }
    entity.var_5a6f8c0c = 1;
    if (isdefined(var_f3eee679) && var_f3eee679 && function_49c8ea64(entity)) {
        function_a0a2a734(entity);
    }
    return true;
}

// Namespace zm_transform/zm_transformation
// Params 1, eflags: 0x0
// Checksum 0xaf2ab93e, Offset: 0x10f0
// Size: 0x16
function function_a4831f1b(entity) {
    entity.var_5a6f8c0c = undefined;
}

// Namespace zm_transform/zm_transformation
// Params 1, eflags: 0x0
// Checksum 0x69eb5a68, Offset: 0x1110
// Size: 0x1c
function function_9b049157(entity) {
    return entity.var_5a6f8c0c !== 1;
}

// Namespace zm_transform/zm_transformation
// Params 1, eflags: 0x4
// Checksum 0x2124a75c, Offset: 0x1138
// Size: 0xae
function private function_cde671d4(id) {
    waitresult = self waittill(#"death", #"transformation_started", #"hash_610e5a8c0ec1a4b6");
    if (waitresult._notify != "death") {
        self.var_767adb17 = undefined;
    }
    arrayremovevalue(level.var_deb579ca[id].var_10663a7f, self);
    /#
        self notify(#"hash_6e3d9f8c484e3d01");
    #/
}

// Namespace zm_transform/zm_transformation
// Params 2, eflags: 0x4
// Checksum 0x339a230a, Offset: 0x11f0
// Size: 0x2a
function private function_47b11cc(id, def) {
    def.spawner.var_1b360588 = id;
}

// Namespace zm_transform/zm_transformation
// Params 2, eflags: 0x4
// Checksum 0x2360da5f, Offset: 0x1228
// Size: 0x5e
function private function_69645903(id, def) {
    assert(def.spawner.var_1b360588 == id, "<dev string:x2cf>");
    def.spawner.var_1b360588 = undefined;
}

// Namespace zm_transform/zm_transformation
// Params 2, eflags: 0x4
// Checksum 0xe2996d83, Offset: 0x1290
// Size: 0xb3e
function private transform(id, var_ee406a8f) {
    level endon(#"end_game");
    if (function_5836d278(id)) {
        return;
    }
    var_50281e3a = level.var_deb579ca[id];
    function_47b11cc(id, var_50281e3a);
    var_9063ed50 = {#id:id, #var_b83ecf3c:self};
    if (!isdefined(level.var_19efff41)) {
        level.var_19efff41 = [];
    } else if (!isarray(level.var_19efff41)) {
        level.var_19efff41 = array(level.var_19efff41);
    }
    level.var_19efff41[level.var_19efff41.size] = var_9063ed50;
    if (isdefined(var_50281e3a.spawner.aitype)) {
        var_9063ed50.archetype = getarchetypefromclassname(var_50281e3a.spawner.aitype);
    }
    self.var_3059fa07 = 1;
    self.var_9063ed50 = var_9063ed50;
    var_6a9408c5 = self.var_6a9408c5;
    n_health_percent = min(self.health / self.maxhealth, 1);
    self notify(#"transformation_started");
    if (isdefined(var_50281e3a.intro_func)) {
        self [[ var_50281e3a.intro_func ]]();
    }
    if (!isdefined(self) || !isalive(self)) {
        arrayremovevalue(level.var_19efff41, var_9063ed50);
        function_69645903(id, var_50281e3a);
        level notify(#"transformation_interrupted", {#id:id});
        return;
    }
    if (!isdefined(var_50281e3a.var_2cf5cfec)) {
        new_ai = var_50281e3a.spawner spawnfromspawner(0, 1);
        var_9063ed50.new_ai = new_ai;
        new_ai.health = int(max(new_ai.health * n_health_percent, 1));
        new_ai.var_9063ed50 = var_9063ed50;
        new_ai._starting_round_number = self._starting_round_number;
        function_69645903(id, var_50281e3a);
        if (isdefined(var_50281e3a.outro_func)) {
            new_ai [[ var_50281e3a.outro_func ]](n_health_percent);
        }
        if (!isdefined(new_ai) || !isalive(new_ai)) {
            arrayremovevalue(level.var_19efff41, var_9063ed50);
            level notify(#"transformation_interrupted", {#id:id});
            return;
        }
        new_ai forceteleport(self.origin, self.angles);
        self zombie_utility::gib_random_parts();
        gibserverutils::annihilate(self);
        self val::set(#"zm_transformation", "hide", 2);
        self kill();
        if (isdefined(var_ee406a8f)) {
            thread [[ var_ee406a8f ]](new_ai);
        }
    } else {
        script_origin = {#origin:self.origin, #angles:self.angles};
        self val::set(#"zm_transformation", "ignoreall");
        a_ents = undefined;
        a_ents = array(self);
        self.animname = "spawner_zm_zombie";
        if (!isdefined(var_50281e3a.var_4cc7cab2)) {
            self clientfield::set("transformation_stream_split", 1);
        }
        var_9063ed50.var_3ff537b = 1;
        level scene::function_4fc601a9(var_50281e3a.var_3048f365);
        script_origin scene::play(var_50281e3a.var_2cf5cfec, a_ents);
        if (!isdefined(self) || !isalive(self)) {
            if (isdefined(self)) {
                self clientfield::set("transformation_stream_split", 0);
            }
            var_9063ed50.var_3ff537b = 0;
            level scene::function_a87de75b(var_50281e3a.var_3048f365);
            arrayremovevalue(level.var_19efff41, var_9063ed50);
            function_69645903(id, var_50281e3a);
            level notify(#"transformation_interrupted", {#id:id});
            return;
        }
        if (isdefined(var_50281e3a.var_4cc7cab2)) {
            [[ var_50281e3a.var_4cc7cab2 ]](self, var_50281e3a);
        } else {
            settingsbundle = self ai::function_a0dbf10a();
            if (isdefined(settingsbundle) && isdefined(settingsbundle.var_7e53f5f9)) {
                foreach (var_e27d1aca in settingsbundle.var_7e53f5f9) {
                    if (self.model === var_e27d1aca.var_6120fa15) {
                        self setmodel(var_e27d1aca.var_174f1680);
                        break;
                    }
                }
            }
        }
        self clientfield::set("transformation_stream_split", 0);
        var_9063ed50.var_3ff537b = 0;
        level scene::function_a87de75b(var_50281e3a.var_3048f365);
        self zombie_utility::zombie_eye_glow_stop();
        new_ai = var_50281e3a.spawner spawnfromspawner(0, 1);
        var_9063ed50.new_ai = new_ai;
        new_ai function_b028c09b();
        new_ai.var_9063ed50 = var_9063ed50;
        new_ai._starting_round_number = self._starting_round_number;
        function_69645903(id, var_50281e3a);
        if (isdefined(var_50281e3a.outro_func)) {
            new_ai [[ var_50281e3a.outro_func ]](n_health_percent);
        }
        if (!isdefined(new_ai) || !isalive(new_ai)) {
            arrayremovevalue(level.var_19efff41, var_9063ed50);
            level notify(#"transformation_interrupted", {#id:id});
            return;
        }
        a_ents = array(new_ai, self);
        self callback::function_1dea870d(#"on_ai_killed", &function_5b5c96b2, undefined, array(new_ai));
        script_origin scene::play(var_50281e3a.var_3048f365, a_ents);
        if (isdefined(self)) {
            self callback::function_1f42556c(#"on_ai_killed", &function_5b5c96b2);
        }
        if (!isdefined(new_ai) || !isalive(new_ai)) {
            if (isdefined(self) && isalive(self) && self.allowdeath) {
                self kill();
            }
            arrayremovevalue(level.var_19efff41, var_9063ed50);
            level notify(#"transformation_interrupted", {#id:id});
            return;
        }
    }
    new_ai.var_9063ed50 = undefined;
    arrayremovevalue(level.var_19efff41, var_9063ed50);
    level notify(#"transformation_complete", {#new_ai:array(new_ai), #id:id, #data:var_6a9408c5});
    if (isdefined(var_ee406a8f)) {
        thread [[ var_ee406a8f ]](new_ai);
    }
}

// Namespace zm_transform/zm_transformation
// Params 2, eflags: 0x4
// Checksum 0x3f621b17, Offset: 0x1dd8
// Size: 0xbc
function private function_5b5c96b2(params, new_ai) {
    if (isdefined(new_ai) && isalive(new_ai) && new_ai.allowdeath && isdefined(params.eattacker) && isplayer(params.eattacker)) {
        new_ai kill(undefined, params.eattacker, params.einflictor, params.weapon, 0, 1);
    }
}

// Namespace zm_transform/zm_transformation
// Params 0, eflags: 0x4
// Checksum 0xc400f565, Offset: 0x1ea0
// Size: 0x96
function private function_ca6efc27() {
    return !(isdefined(level.var_f83f8181) && level.var_f83f8181) && zombie_utility::get_current_zombie_count() + level.zombie_total <= 10 && !(isdefined(level.var_cc46bee) && level.var_cc46bee) && !level flag::get(#"infinite_round_spawning");
}

// Namespace zm_transform/zm_transformation
// Params 2, eflags: 0x4
// Checksum 0x81d9271c, Offset: 0x1f40
// Size: 0x2b0
function private function_584ec63c(id, var_50281e3a) {
    level endon(#"hash_670ec83e1acfadff", #"game_ended");
    if (var_50281e3a.var_10663a7f.size > 0) {
        foreach (zombie in var_50281e3a.var_10663a7f) {
            if (function_9b049157(zombie) && isdefined(var_50281e3a.condition) && zombie [[ var_50281e3a.condition ]]()) {
                zombie thread transform(id);
                return true;
            }
        }
    }
    if (var_50281e3a.var_39491bdc > 0) {
        zombies = zombie_utility::get_round_enemy_array();
        foreach (zombie in zombies) {
            if (!isdefined(zombie) || !isalive(zombie) || function_49c8ea64(zombie)) {
                continue;
            }
            if (function_9b049157(zombie) && isdefined(var_50281e3a.condition) && zombie [[ var_50281e3a.condition ]]()) {
                zombie thread transform(id);
                var_50281e3a.var_39491bdc--;
                level.var_4dcfacd3++;
                if (level.var_4dcfacd3 >= 6) {
                    waitframe(1);
                    level.var_4dcfacd3 = 0;
                }
                return true;
            }
            level.var_4dcfacd3++;
            if (level.var_4dcfacd3 >= 6) {
                waitframe(1);
                level.var_4dcfacd3 = 0;
            }
        }
    }
    return false;
}

// Namespace zm_transform/zm_transformation
// Params 0, eflags: 0x4
// Checksum 0xc67f9bc6, Offset: 0x21f8
// Size: 0x2fe
function private update() {
    level endoncallback(&function_99bc49e0, #"end_game");
    var_ba538315 = 0;
    level.var_4dcfacd3 = 0;
    while (true) {
        if (isdefined(var_ba538315) && var_ba538315) {
            wait 1;
        } else {
            wait 0.2;
        }
        level flag::wait_till_clear(#"hash_670ec83e1acfadff");
        if (function_ca6efc27()) {
            level notify(#"hash_239ebc19aab5a60b");
            function_204b0737();
            level waittill(#"start_of_round", #"force_transformations");
        }
        var_ba538315 = 0;
        time = gettime();
        keys = array::randomize(getarraykeys(level.var_deb579ca));
        foreach (id in keys) {
            transformation = level.var_deb579ca[id];
            if (level flag::get(#"hash_670ec83e1acfadff") || function_ca6efc27()) {
                break;
            }
            pixbeginevent("zm_transformation_update");
            if (transformation.var_b39e10c4 > time) {
                pixendevent();
                continue;
            }
            if (function_5836d278(id)) {
                pixendevent();
                continue;
            }
            var_ba538315 = function_584ec63c(id, transformation);
            pixendevent();
            if (isdefined(var_ba538315) && var_ba538315) {
                transformation.var_b39e10c4 = isdefined(level.var_cc46bee) && level.var_cc46bee ? gettime() : gettime() + transformation.cooldown_time * 1000;
                break;
            }
        }
    }
}

// Namespace zm_transform/zm_transformation
// Params 1, eflags: 0x4
// Checksum 0x2eec8f63, Offset: 0x2500
// Size: 0x2c
function private function_99bc49e0(var_a6d32d) {
    function_204b0737();
    function_21175562();
}

// Namespace zm_transform/zm_transformation
// Params 0, eflags: 0x0
// Checksum 0x55a0e219, Offset: 0x2538
// Size: 0x24
function function_b028c09b() {
    self clientfield::set("transformation_spawn", 1);
}

/#

    // Namespace zm_transform/zm_transformation
    // Params 0, eflags: 0x4
    // Checksum 0x67c568ce, Offset: 0x2568
    // Size: 0x4de
    function private devgui() {
        level waittill(#"start_zombie_round_logic");
        adddebugcommand("<dev string:x308>");
        adddebugcommand("<dev string:x362>");
        adddebugcommand("<dev string:x3ae>");
        adddebugcommand("<dev string:x3fc>");
        foreach (id, transformation in level.var_deb579ca) {
            adddebugcommand("<dev string:x466>" + function_15979fa9(id) + "<dev string:x48b>" + function_15979fa9(id) + "<dev string:x4b3>");
            adddebugcommand("<dev string:x4b6>" + function_15979fa9(id) + "<dev string:x4db>" + function_15979fa9(id) + "<dev string:x4b3>");
            adddebugcommand("<dev string:x503>" + function_15979fa9(id) + "<dev string:x528>" + function_15979fa9(id) + "<dev string:x4b3>");
        }
        var_7495eabc = 0;
        while (true) {
            wait 0.2;
            cmd = getdvarstring(#"hash_439ed91bbc9ac4c0", "<dev string:xe5>");
            if (cmd == "<dev string:xe5>") {
                continue;
            }
            setdvar(#"hash_439ed91bbc9ac4c0", "<dev string:xe5>");
            cmd = strtok(cmd, "<dev string:x550>");
            switch (cmd[0]) {
            case #"toggle_status":
                var_7495eabc = !var_7495eabc;
                if (!var_7495eabc) {
                    level notify(#"hash_53f34619e212c4cd");
                } else {
                    level thread show_status();
                }
                break;
            case #"force":
                var_50281e3a = level.var_deb579ca[cmd[1]];
                if (!isdefined(var_50281e3a)) {
                    break;
                }
                level thread function_db92341a(cmd[1]);
                break;
            case #"spawn":
                var_50281e3a = level.var_deb579ca[cmd[1]];
                if (!isdefined(var_50281e3a)) {
                    break;
                }
                level.var_cc46bee = 1;
                level notify(#"force_transformations");
                level thread function_8a32f822(cmd[1]);
                break;
            case #"queue":
                level.var_cc46bee = 1;
                level notify(#"force_transformations");
                function_5dbbf742(cmd[1]);
                break;
            case #"pause":
                function_bfc50dca(#"hash_7a79688cef85b533");
                break;
            case #"resume":
                function_5eefd607(#"hash_7a79688cef85b533");
                break;
            case #"hash_5893e94d64f92905":
                function_739307fe();
                break;
            }
        }
    }

    // Namespace zm_transform/zm_transformation
    // Params 0, eflags: 0x0
    // Checksum 0xa834a57b, Offset: 0x2a50
    // Size: 0x22
    function function_628876fa() {
        self.zombie_think_done = 1;
        self.completed_emerging_into_playable_area = 1;
    }

    // Namespace zm_transform/zm_transformation
    // Params 0, eflags: 0x0
    // Checksum 0xf274722d, Offset: 0x2a80
    // Size: 0x202
    function function_5da7d51b() {
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
        zombie.custom_location = &function_628876fa;
        zombie.b_ignore_cleanup = 1;
        if (!isdefined(zombie)) {
            return;
        }
        zombie forceteleport(trace[#"position"], player.angles + (0, 180, 0));
        return zombie;
    }

    // Namespace zm_transform/zm_transformation
    // Params 1, eflags: 0x4
    // Checksum 0x8e2354b5, Offset: 0x2c90
    // Size: 0x94
    function private function_db92341a(var_2d06b356) {
        zombie = function_5da7d51b();
        if (!isdefined(zombie)) {
            return;
        }
        zombie endon(#"death");
        wait 0.5;
        while (function_5836d278(var_2d06b356)) {
            waitframe(1);
        }
        function_3b866d7e(zombie, var_2d06b356);
    }

    // Namespace zm_transform/zm_transformation
    // Params 1, eflags: 0x4
    // Checksum 0x9e262090, Offset: 0x2d30
    // Size: 0x74
    function private function_8a32f822(var_2d06b356) {
        zombie = function_5da7d51b();
        if (!isdefined(zombie)) {
            return;
        }
        zombie endon(#"death");
        zombie.var_8c40dbcb = gettime() + 500;
        function_78f90f3b(zombie, var_2d06b356);
    }

    // Namespace zm_transform/zm_transformation
    // Params 1, eflags: 0x4
    // Checksum 0xcf6aa8ab, Offset: 0x2db0
    // Size: 0x108
    function private function_2ba5935(notifyhash) {
        foreach (var_c0c328eb in level.var_c0c328eb) {
            if (!isdefined(var_c0c328eb.id)) {
                var_c0c328eb.var_d8d8a2f7 destroy();
            }
            var_c0c328eb.title destroy();
            var_c0c328eb.var_a369772a destroy();
            var_c0c328eb.var_2486ff00 destroy();
        }
        level.var_c0c328eb = undefined;
        level notify(#"hash_6e3d9f8c484e3d01");
    }

    // Namespace zm_transform/zm_transformation
    // Params 2, eflags: 0x4
    // Checksum 0x7690c3c0, Offset: 0x2ec0
    // Size: 0xbc
    function private create_hudelem(y, x) {
        if (!isdefined(x)) {
            x = 0;
        }
        var_587f26ea = newdebughudelem();
        var_587f26ea.alignx = "<dev string:x552>";
        var_587f26ea.horzalign = "<dev string:x552>";
        var_587f26ea.aligny = "<dev string:x557>";
        var_587f26ea.vertalign = "<dev string:x55e>";
        var_587f26ea.y = y;
        var_587f26ea.x = x;
        return var_587f26ea;
    }

    // Namespace zm_transform/zm_transformation
    // Params 0, eflags: 0x4
    // Checksum 0xbd98ca75, Offset: 0x2f88
    // Size: 0x4b0
    function private setup_status() {
        level.var_c0c328eb = array();
        y = 10;
        colors = array((1, 1, 1));
        var_7b7a4f09 = create_hudelem(y);
        var_7b7a4f09 settext("<dev string:x562>");
        y += 10;
        var_d8d8a2f7 = create_hudelem(y);
        var_ef89291 = create_hudelem(y, 160);
        var_ef89291 settext("<dev string:x57f>");
        var_5caa2a3b = create_hudelem(y, 220);
        var_5caa2a3b settext("<dev string:x58f>");
        if (!isdefined(level.var_c0c328eb)) {
            level.var_c0c328eb = [];
        } else if (!isarray(level.var_c0c328eb)) {
            level.var_c0c328eb = array(level.var_c0c328eb);
        }
        level.var_c0c328eb[level.var_c0c328eb.size] = {#title:var_7b7a4f09, #var_a369772a:var_ef89291, #var_2486ff00:var_5caa2a3b, #var_d8d8a2f7:var_d8d8a2f7};
        i = 0;
        foreach (id, transformation in level.var_deb579ca) {
            y += 10;
            current_color = colors[i % colors.size];
            id_elem = create_hudelem(y);
            id_elem settext(function_15979fa9(id));
            id_elem.color = current_color;
            id_elem.fontscale = 1.2;
            var_3a2d0bcc = create_hudelem(y, 160);
            var_3a2d0bcc settext(0);
            var_3a2d0bcc.color = current_color;
            var_3a2d0bcc.fontscale = 1.2;
            var_12f0565a = create_hudelem(y, 220);
            var_12f0565a settext(0);
            var_12f0565a.color = current_color;
            var_12f0565a.fontscale = 1.2;
            if (!isdefined(level.var_c0c328eb)) {
                level.var_c0c328eb = [];
            } else if (!isarray(level.var_c0c328eb)) {
                level.var_c0c328eb = array(level.var_c0c328eb);
            }
            level.var_c0c328eb[level.var_c0c328eb.size] = {#title:id_elem, #var_a369772a:var_3a2d0bcc, #var_2486ff00:var_12f0565a, #id:id, #color:current_color};
            i++;
        }
    }

    // Namespace zm_transform/zm_transformation
    // Params 1, eflags: 0x4
    // Checksum 0x7f744b27, Offset: 0x3440
    // Size: 0x1a
    function private function_d12f76(notifyhash) {
        self.var_4f084947 = undefined;
    }

    // Namespace zm_transform/zm_transformation
    // Params 2, eflags: 0x4
    // Checksum 0x70d6dc72, Offset: 0x3468
    // Size: 0xce
    function private function_b5283868(id, color) {
        self endoncallback(&function_d12f76, #"death", #"hash_6e3d9f8c484e3d01");
        level endoncallback(&function_d12f76, #"hash_6e3d9f8c484e3d01");
        self.var_4f084947 = 1;
        while (true) {
            record3dtext(function_15979fa9(id), self.origin + (0, 0, self.maxs[2]), color);
            waitframe(1);
        }
    }

    // Namespace zm_transform/zm_transformation
    // Params 0, eflags: 0x4
    // Checksum 0x2732aaad, Offset: 0x3540
    // Size: 0x248
    function private show_status() {
        level notify(#"hash_53f34619e212c4cd");
        level endoncallback(&function_2ba5935, #"hash_53f34619e212c4cd");
        setup_status();
        while (true) {
            waitframe(1);
            foreach (var_c0c328eb in level.var_c0c328eb) {
                if (!isdefined(var_c0c328eb.id)) {
                    var_c0c328eb.var_d8d8a2f7 settext(function_b312d5a2() ? "<dev string:x5a8>" : "<dev string:xe5>");
                    continue;
                }
                var_c0c328eb.var_a369772a settext(level.var_deb579ca[var_c0c328eb.id].var_39491bdc);
                var_c0c328eb.var_2486ff00 settext(level.var_deb579ca[var_c0c328eb.id].var_10663a7f.size);
                foreach (ai in level.var_deb579ca[var_c0c328eb.id].var_10663a7f) {
                    if (!(isdefined(ai.var_4f084947) && ai.var_4f084947)) {
                        ai thread function_b5283868(var_c0c328eb.id, var_c0c328eb.color);
                    }
                }
            }
        }
    }

    // Namespace zm_transform/zm_transformation
    // Params 0, eflags: 0x4
    // Checksum 0xa8d3254b, Offset: 0x3790
    // Size: 0x54
    function private function_739307fe() {
        level.var_11d16099 = !(isdefined(level.var_11d16099) && level.var_11d16099);
        if (level.var_11d16099) {
            level thread function_11d16099();
        }
    }

    // Namespace zm_transform/zm_transformation
    // Params 0, eflags: 0x4
    // Checksum 0x6c39f8ab, Offset: 0x37f0
    // Size: 0x158
    function private function_11d16099() {
        self notify("<invalid>");
        self endon("<invalid>");
        while (level.var_11d16099) {
            var_e1da76c = 200;
            var_342021d5 = 100;
            debug2dtext((var_e1da76c, var_342021d5, 0), "<dev string:x5c0>", (1, 1, 0), 1, (0, 0, 0), 0.8, 1);
            var_342021d5 += 25;
            foreach (pauser in level.var_3fe0cd) {
                debug2dtext((var_e1da76c, var_342021d5, 0), function_15979fa9(pauser), (1, 1, 1), 1, (0, 0, 0), 0.8, 1);
                var_342021d5 += 25;
            }
            waitframe(1);
        }
    }

#/
