#using scripts\core_common\ai\systems\blackboard;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;

#namespace mimic_prop_spawn;

// Namespace mimic_prop_spawn/namespace_4aff7b6b
// Params 0, eflags: 0x1 linked
// Checksum 0xcddd257e, Offset: 0x120
// Size: 0x20
function init() {
    if (!isdefined(level.var_b7c1e1d2)) {
        level.var_b7c1e1d2 = [];
    }
}

// Namespace mimic_prop_spawn/namespace_4aff7b6b
// Params 3, eflags: 0x0
// Checksum 0xac63afd8, Offset: 0x148
// Size: 0x52
function function_8743cb1d(origin, radius, var_9b487a9b) {
    var_a6fe91fd = function_4cc90533(origin, radius, var_9b487a9b);
    return function_913ecbbc(var_a6fe91fd);
}

// Namespace mimic_prop_spawn/namespace_4aff7b6b
// Params 2, eflags: 0x0
// Checksum 0xc8a08176, Offset: 0x1a8
// Size: 0x4a
function function_8c6c017a(&spawn_points, var_9b487a9b) {
    var_a6fe91fd = function_c928b745(spawn_points, var_9b487a9b);
    return function_913ecbbc(var_a6fe91fd);
}

// Namespace mimic_prop_spawn/namespace_4aff7b6b
// Params 1, eflags: 0x1 linked
// Checksum 0x266cac18, Offset: 0x200
// Size: 0x178
function function_913ecbbc(&var_a6fe91fd) {
    if (!var_a6fe91fd.size) {
        return;
    }
    mimic = spawnactor(#"spawner_bo5_mimic", (0, 0, 0), (0, 0, 0));
    var_faa3dbdd = array::randomize(var_a6fe91fd);
    var_1386d828 = undefined;
    foreach (prop in var_faa3dbdd) {
        if (is_true(prop.var_3e64167)) {
            var_1386d828 = prop;
            break;
        }
    }
    if (!isdefined(var_1386d828)) {
        var_1386d828 = var_faa3dbdd[0];
    }
    if (!isdefined(var_1386d828)) {
        return;
    }
    function_cad34798(mimic, var_a6fe91fd);
    function_4540d40c(mimic, var_1386d828);
    function_80335b6(var_1386d828, var_a6fe91fd);
    return var_1386d828;
}

// Namespace mimic_prop_spawn/namespace_4aff7b6b
// Params 1, eflags: 0x0
// Checksum 0xbf1d0f56, Offset: 0x380
// Size: 0x9e
function function_4237218(pause) {
    foreach (prop in function_2e8c33f6()) {
        prop.var_3a3cdab8 = is_true(pause);
    }
}

// Namespace mimic_prop_spawn/namespace_4aff7b6b
// Params 0, eflags: 0x1 linked
// Checksum 0x13a21852, Offset: 0x428
// Size: 0xd2
function function_2e8c33f6() {
    arrayremovevalue(level.var_b7c1e1d2, undefined);
    var_2a1f535d = [];
    foreach (prop in level.var_b7c1e1d2) {
        if (is_true(prop.var_3e64167)) {
            var_2a1f535d[var_2a1f535d.size] = prop;
        }
    }
    return var_2a1f535d;
}

// Namespace mimic_prop_spawn/namespace_4aff7b6b
// Params 3, eflags: 0x1 linked
// Checksum 0xf1bdf3b, Offset: 0x508
// Size: 0x7a
function function_4cc90533(origin, radius, var_9b487a9b) {
    var_79422067 = struct::get_array("mimic_prop_spawn", "targetname");
    var_79422067 = function_72d3bca6(var_79422067, origin, undefined, undefined, radius);
    return function_c928b745(var_79422067, var_9b487a9b);
}

// Namespace mimic_prop_spawn/namespace_4aff7b6b
// Params 2, eflags: 0x1 linked
// Checksum 0xfba70b5, Offset: 0x590
// Size: 0x1b0
function function_c928b745(&spawn_points, var_9b487a9b) {
    arrayremovevalue(level.var_b7c1e1d2, undefined);
    var_a6fe91fd = [];
    if (20 - level.var_b7c1e1d2.size < var_9b487a9b) {
        /#
            if (is_true(level.var_bce8fb65)) {
                println("<dev string:x38>" + "<dev string:x45>" + 20 - level.var_b7c1e1d2.size + "<dev string:x65>" + var_9b487a9b);
            }
        #/
        return var_a6fe91fd;
    }
    if (!spawn_points.size) {
        /#
            if (is_true(level.var_bce8fb65)) {
                println("<dev string:x38>" + "<dev string:x75>");
            }
        #/
        return var_a6fe91fd;
    }
    spawn_points = array::randomize(spawn_points);
    for (index = 0; index < var_9b487a9b; index++) {
        loc = spawn_points[index];
        prop = function_fc585b51(loc);
        var_a6fe91fd[var_a6fe91fd.size] = prop;
        level.var_b7c1e1d2[level.var_b7c1e1d2.size] = prop;
    }
    return var_a6fe91fd;
}

// Namespace mimic_prop_spawn/namespace_4aff7b6b
// Params 1, eflags: 0x1 linked
// Checksum 0xa7518932, Offset: 0x748
// Size: 0x3a
function function_fc585b51(spawn_loc) {
    return util::spawn_anim_model(#"hash_4897a060371b1c76", spawn_loc.origin, spawn_loc.angles);
}

// Namespace mimic_prop_spawn/namespace_4aff7b6b
// Params 2, eflags: 0x1 linked
// Checksum 0xd5788e87, Offset: 0x790
// Size: 0x54
function function_cad34798(entity, &var_a6fe91fd) {
    entity.var_a6fe91fd = var_a6fe91fd;
    entity callback::function_d8abfc3d(#"on_ai_killed", &function_1187de9);
}

// Namespace mimic_prop_spawn/namespace_4aff7b6b
// Params 3, eflags: 0x1 linked
// Checksum 0xe7bdd4bc, Offset: 0x7f0
// Size: 0xb4
function function_80335b6(prop, &var_a6fe91fd, condition_func = &function_708fe162) {
    prop.var_3e64167 = 1;
    prop thread function_6f7ce46e(var_a6fe91fd, condition_func);
    prop.health = 50000;
    prop.takedamage = 1;
    prop.var_10c5271 = 0;
    prop.var_b31a1e22 = 0;
    callback::function_9d78f548(&function_24811d29, prop);
}

// Namespace mimic_prop_spawn/namespace_4aff7b6b
// Params 0, eflags: 0x1 linked
// Checksum 0x580f3580, Offset: 0x8b0
// Size: 0x22
function function_708fe162() {
    return getplayers(undefined, self.origin, 96);
}

// Namespace mimic_prop_spawn/namespace_4aff7b6b
// Params 2, eflags: 0x1 linked
// Checksum 0x7adaf0d6, Offset: 0x8e0
// Size: 0xba
function function_6f7ce46e(&var_a6fe91fd, condition_func) {
    self endon(#"death", #"damage_transform");
    level endon(#"game_ended");
    while (true) {
        waitframe(1);
        if (is_true(self.var_3a3cdab8)) {
            continue;
        }
        var_ef7458f2 = self [[ condition_func ]]();
        if (var_ef7458f2.size) {
            function_f021ef67(self, var_ef7458f2);
            return;
        }
    }
}

// Namespace mimic_prop_spawn/namespace_4aff7b6b
// Params 2, eflags: 0x1 linked
// Checksum 0x7a38bb5e, Offset: 0x9a8
// Size: 0x176
function function_24811d29(prop, s_info) {
    prop.health = 50000;
    if (is_true(self.var_3a3cdab8)) {
        return;
    }
    if (!isplayer(s_info.einflictor) && !isplayer(s_info.eattacker)) {
        return;
    }
    if (gettime() - prop.var_b31a1e22 > int(3 * 1000)) {
        prop.var_10c5271 = 0;
    }
    prop.var_10c5271 += s_info.idamage;
    prop.var_b31a1e22 = gettime();
    if (prop.var_10c5271 >= 100) {
        player = isplayer(s_info.einflictor) ? s_info.einflictor : s_info.eattacker;
        prop notify(#"damage_transform");
        profilestart();
        function_f021ef67(prop, [player]);
        profilestop();
    }
}

// Namespace mimic_prop_spawn/namespace_4aff7b6b
// Params 2, eflags: 0x1 linked
// Checksum 0xbe114390, Offset: 0xb28
// Size: 0x154
function function_f021ef67(prop, &var_ef7458f2) {
    if (isdefined(prop.var_3c964886)) {
        [[ prop.var_3c964886 ]](prop);
    }
    if (!isdefined(prop.var_1626d18c)) {
        return;
    }
    foreach (entity in prop.var_1626d18c) {
        entity callback::callback(#"on_entity_revealed", {#var_ef7458f2:var_ef7458f2});
    }
    prop val::set(#"mimic_spawn", "hide", 1);
    prop notsolid();
    callback::function_f125b93a(&function_24811d29, prop);
}

// Namespace mimic_prop_spawn/namespace_4aff7b6b
// Params 2, eflags: 0x1 linked
// Checksum 0x9688e749, Offset: 0xc88
// Size: 0x1b8
function function_4540d40c(entity, prop) {
    entity endon(#"death");
    prop endon(#"death");
    entity.var_83fa6083 = 1;
    entity val::set(#"hash_263a780666aef25", "hide", 1);
    entity notsolid();
    entity pathmode("dont move", 1);
    entity dontinterpolate();
    entity forceteleport(prop.origin, prop.angles);
    entity setentitypaused(1);
    entity callback::callback(#"on_entity_hidden_in_prop", {#prop:prop});
    entity callback::function_d8abfc3d(#"on_entity_revealed", &on_entity_revealed, undefined, [prop]);
    if (!isdefined(prop.var_1626d18c)) {
        prop.var_1626d18c = [];
    }
    prop.var_1626d18c[prop.var_1626d18c.size] = entity;
}

// Namespace mimic_prop_spawn/namespace_4aff7b6b
// Params 2, eflags: 0x1 linked
// Checksum 0x905553d2, Offset: 0xe48
// Size: 0xec
function on_entity_revealed(*params, prop) {
    if (self ispaused()) {
        self setentitypaused(0);
    }
    self solid();
    self pathmode("move allowed");
    self val::reset(#"hash_263a780666aef25", "hide");
    self animscripted("ai_t9_zm_mimic_com_emerge_prop_quick_f_01", prop.origin, prop.angles, "ai_t9_zm_mimic_com_emerge_prop_quick_f_01", "normal");
}

// Namespace mimic_prop_spawn/namespace_4aff7b6b
// Params 1, eflags: 0x1 linked
// Checksum 0x665d1392, Offset: 0xf40
// Size: 0xc8
function function_1187de9(*params) {
    arrayremovevalue(self.var_a6fe91fd, undefined);
    foreach (prop in self.var_a6fe91fd) {
        if (isdefined(prop.var_33960526)) {
            [[ prop.var_33960526 ]]();
        }
        prop deletedelay();
    }
}

// Namespace mimic_prop_spawn/namespace_4aff7b6b
// Params 1, eflags: 0x1 linked
// Checksum 0x23bdb32a, Offset: 0x1010
// Size: 0xfc
function clean_up_prop(prop) {
    if (isdefined(prop.var_1626d18c)) {
        function_1eaaceab(prop.var_1626d18c);
        foreach (var_e2986be9 in prop.var_1626d18c) {
            if (var_e2986be9 ispaused()) {
                var_e2986be9 setentitypaused(0);
            }
            var_e2986be9 deletedelay();
        }
    }
    prop deletedelay();
}

// Namespace mimic_prop_spawn/namespace_4aff7b6b
// Params 0, eflags: 0x0
// Checksum 0x9d80deff, Offset: 0x1118
// Size: 0xa8
function function_fd24f982() {
    arrayremovevalue(level.var_b7c1e1d2, undefined);
    foreach (prop in level.var_b7c1e1d2) {
        clean_up_prop(prop);
    }
}

