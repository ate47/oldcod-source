#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\gameobjects_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace namespace_8b6a9d79;

// Namespace namespace_8b6a9d79/namespace_8b6a9d79
// Params 0, eflags: 0x6
// Checksum 0xc6061cbb, Offset: 0xf0
// Size: 0x44
function private autoexec __init__system__() {
    system::register(#"hash_f81b9dea74f0ee", &function_70a657d8, undefined, &finalize, undefined);
}

// Namespace namespace_8b6a9d79/namespace_8b6a9d79
// Params 0, eflags: 0x5 linked
// Checksum 0xad8ace3d, Offset: 0x140
// Size: 0x42
function private function_70a657d8() {
    level.var_7d45d0d4 = spawnstruct();
    level.var_7d45d0d4.var_405f83af = [];
    level.var_7d45d0d4.var_ef2adaf8 = [];
}

// Namespace namespace_8b6a9d79/namespace_8b6a9d79
// Params 0, eflags: 0x5 linked
// Checksum 0x6508d26f, Offset: 0x190
// Size: 0x54
function private finalize() {
    function_81d05c4f();
    function_e97ef0d4();
    level.var_7d45d0d4.var_5eba96b3 = [];
    /#
        level thread init_devgui();
    #/
}

// Namespace namespace_8b6a9d79/namespace_8b6a9d79
// Params 2, eflags: 0x1 linked
// Checksum 0xafef2820, Offset: 0x1f0
// Size: 0xfe
function function_b3464a7c(scriptname, spawncallback) {
    assert(isstring(scriptname) || ishash(scriptname));
    assert(isfunctionptr(spawncallback));
    var_405f83af = level.var_7d45d0d4.var_405f83af;
    assert(!isdefined(var_405f83af[scriptname]));
    script = {#scriptname:scriptname, #spawncallback:spawncallback};
    var_405f83af[scriptname] = script;
    return script;
}

// Namespace namespace_8b6a9d79/namespace_8b6a9d79
// Params 1, eflags: 0x1 linked
// Checksum 0x837d2807, Offset: 0x2f8
// Size: 0x64
function function_85255d0f(scriptname) {
    assert(isstring(scriptname) || ishash(scriptname));
    return level.var_7d45d0d4.var_405f83af[scriptname];
}

// Namespace namespace_8b6a9d79/namespace_8b6a9d79
// Params 2, eflags: 0x1 linked
// Checksum 0x3889410c, Offset: 0x368
// Size: 0x1de
function function_31e8da78(destination, var_100faab4) {
    locations = array::randomize(function_f703a5a(destination));
    for (i = 0; i < locations.size; i++) {
        if (locations[i].variantname !== #"content_location") {
            arrayremoveindex(locations, i, 1);
        }
    }
    arrayremovevalue(locations, undefined);
    foreach (location in locations) {
        instances = array::randomize(function_f703a5a(location));
        foreach (instance in instances) {
            if (instance.content_script_name === var_100faab4) {
                return instance;
            }
        }
    }
}

// Namespace namespace_8b6a9d79/namespace_8b6a9d79
// Params 0, eflags: 0x5 linked
// Checksum 0x6dcd9d85, Offset: 0x550
// Size: 0xa8a
function private function_81d05c4f() {
    var_f5ae494f = struct::get_array(#"content_destination", "variantname");
    destinations = [];
    level.var_7d45d0d4.destinations = destinations;
    foreach (destination in var_f5ae494f) {
        assert(isdefined(destination.targetname));
        assert(!isdefined(destinations[destination.targetname]));
        destinations[destination.targetname] = destination;
        function_656a32f0(destination);
        locations = [];
        destination.locations = locations;
        children = function_f703a5a(destination);
        foreach (child in children) {
            if (child.variantname != #"content_location") {
                continue;
            }
            assert(isdefined(child.targetname));
            assert(!isdefined(locations[child.targetname]));
            locations[child.targetname] = child;
        }
    }
    if (isdefined(level.var_2da0be29)) {
        [[ level.var_2da0be29 ]]();
        var_42d2e0bf = arraycopy(destinations);
        foreach (destination in destinations) {
            if (!isdefined(destination.var_d0d3add6) && getdvarstring(#"hash_36112559be5dfe28", "") !== destination.targetname) {
                arrayremovevalue(var_42d2e0bf, destination);
            }
        }
        var_53be964f = array::randomize(var_42d2e0bf);
    } else {
        var_53be964f = destinations;
    }
    if (is_false(getgametypesetting(#"hash_3a16dccdcb82e664")) && getdvarstring(#"hash_36112559be5dfe28", "") !== #"destination_zoo") {
        arrayremovevalue(var_53be964f, struct::get(#"destination_zoo"));
    }
    if (is_false(getgametypesetting(#"hash_4eabe0978dc92ef7")) && getdvarstring(#"hash_36112559be5dfe28", "") !== #"destination_sanatorium") {
        arrayremovevalue(var_53be964f, struct::get(#"destination_sanatorium"));
    }
    if (is_false(getgametypesetting(#"hash_45f866da7af3a609")) && getdvarstring(#"hash_36112559be5dfe28", "") !== #"destination_forest") {
        arrayremovevalue(var_53be964f, struct::get(#"destination_forest"));
    }
    if (is_false(getgametypesetting(#"hash_d9c18f112ff4552")) && getdvarstring(#"hash_36112559be5dfe28", "") !== #"destination_golova") {
        arrayremovevalue(var_53be964f, struct::get(#"destination_golova"));
    }
    if (is_false(getgametypesetting(#"hash_15e3cdab677aed")) && getdvarstring(#"hash_36112559be5dfe28", "") !== #"destination_ski") {
        arrayremovevalue(var_53be964f, struct::get(#"destination_ski"));
    }
    if (is_false(getgametypesetting(#"hash_7fafd95fb5eeb3cd")) && getdvarstring(#"hash_36112559be5dfe28", "") !== #"hash_2041750e8a960d7d") {
        arrayremovevalue(var_53be964f, struct::get(#"hash_2041750e8a960d7d"));
    }
    if (is_false(getgametypesetting(#"hash_7322ca6ba3d467f0")) && getdvarstring(#"hash_36112559be5dfe28", "") !== #"hash_677d5923437f98ef") {
        arrayremovevalue(var_53be964f, struct::get(#"hash_677d5923437f98ef"));
    }
    if (is_false(getgametypesetting(#"hash_6b4d9c563903b948")) && getdvarstring(#"hash_36112559be5dfe28", "") !== #"hash_5377c6139b94f878") {
        arrayremovevalue(var_53be964f, struct::get(#"hash_5377c6139b94f878"));
    }
    if (is_false(getgametypesetting(#"hash_19c3b46e9dd9d7c5")) && getdvarstring(#"hash_36112559be5dfe28", "") !== #"hash_607058eb6f433e35") {
        arrayremovevalue(var_53be964f, struct::get(#"hash_607058eb6f433e35"));
    }
    if (is_false(getgametypesetting(#"hash_64069be594107ddf")) && getdvarstring(#"hash_36112559be5dfe28", "") !== #"hash_725519cecb127be4") {
        arrayremovevalue(var_53be964f, struct::get(#"hash_725519cecb127be4"));
    }
    if (is_false(getgametypesetting(#"hash_444f9d0410b85ddf")) && getdvarstring(#"hash_36112559be5dfe28", "") !== #"destination_duga") {
        arrayremovevalue(var_53be964f, struct::get(#"destination_duga"));
    }
    level.var_7d45d0d4.destinations = array::randomize(var_53be964f);
}

// Namespace namespace_8b6a9d79/namespace_8b6a9d79
// Params 2, eflags: 0x0
// Checksum 0xf7b41c45, Offset: 0xfe8
// Size: 0x144
function function_316bd0e6(str_destination, var_2d26f85c) {
    assert(isdefined(level.var_7d45d0d4.destinations[str_destination]) && isdefined("<dev string:x38>" + str_destination));
    i = 0;
    foreach (var_fc091632 in var_2d26f85c) {
        adjacency = struct::get(var_fc091632);
        assert(isdefined(adjacency) && isdefined("<dev string:x67>" + var_fc091632));
        level.var_7d45d0d4.destinations[str_destination].var_d0d3add6[i] = adjacency;
        i++;
    }
}

// Namespace namespace_8b6a9d79/namespace_8b6a9d79
// Params 1, eflags: 0x1 linked
// Checksum 0x705afd17, Offset: 0x1138
// Size: 0x9e
function function_fe9fb6fd(location) {
    assert(isstruct(location));
    assert(location.variantname == #"content_location");
    var_e599dbfd = isarray(location.var_5eba96b3) && location.var_5eba96b3.size > 0;
    return var_e599dbfd;
}

// Namespace namespace_8b6a9d79/namespace_8b6a9d79
// Params 0, eflags: 0x5 linked
// Checksum 0xb37d1e53, Offset: 0x11e0
// Size: 0x2ba
function private function_e97ef0d4() {
    var_b8a20df4 = struct::get_array(#"content_location", "variantname");
    locations = [];
    level.var_7d45d0d4.locations = locations;
    foreach (location in var_b8a20df4) {
        assert(isdefined(location.targetname));
        assert(!isdefined(locations[location.targetname]));
        locations[location.targetname] = location;
        if (isdefined(location.target)) {
            parent = struct::get(location.target);
            if (parent.variantname == #"content_destination") {
                location.destination = parent;
            }
        }
        function_656a32f0(location);
        instances = [];
        location.instances = instances;
        children = function_f703a5a(location);
        foreach (child in children) {
            if (child.variantname != #"content_instance") {
                continue;
            }
            assert(isdefined(child.content_script_name));
            assert(!isdefined(instances[child.content_script_name]));
            instances[child.content_script_name] = child;
            child.location = location;
        }
    }
}

// Namespace namespace_8b6a9d79/namespace_8b6a9d79
// Params 1, eflags: 0x1 linked
// Checksum 0xf0f2ce0b, Offset: 0x14a8
// Size: 0x164
function function_20d7e9c7(instance) {
    assert(isstruct(instance));
    assert(instance.variantname == #"content_instance");
    assert(isstring(instance.content_script_name) || ishash(instance.content_script_name));
    assert(isstruct(instance.location));
    function_656a32f0(instance);
    script = level.var_7d45d0d4.var_405f83af[instance.content_script_name];
    if (isdefined(script.spawncallback)) {
        level thread [[ script.spawncallback ]](instance);
    }
    function_130f0da3(instance);
}

// Namespace namespace_8b6a9d79/namespace_8b6a9d79
// Params 1, eflags: 0x0
// Checksum 0xd3984f7b, Offset: 0x1618
// Size: 0xfc
function function_1c78a45d(instance) {
    assert(isstruct(instance));
    assert(instance.variantname == #"content_instance");
    assert(isstring(instance.content_script_name) || ishash(instance.content_script_name));
    assert(isstruct(instance.location));
    return !function_fe9fb6fd(instance.location);
}

// Namespace namespace_8b6a9d79/namespace_8b6a9d79
// Params 1, eflags: 0x5 linked
// Checksum 0x37721faf, Offset: 0x1720
// Size: 0xfe
function private function_130f0da3(instance) {
    assert(isarray(level.var_7d45d0d4.var_5eba96b3));
    if (!isdefined(instance.location.var_5eba96b3)) {
        instance.location.var_5eba96b3 = [];
    }
    instance.location.var_5eba96b3[instance.location.var_5eba96b3.size] = instance;
    var_5eba96b3 = level.var_7d45d0d4.var_5eba96b3;
    if (!isdefined(var_5eba96b3[instance.content_script_name])) {
        var_5eba96b3[instance.content_script_name] = [];
    }
    instances = var_5eba96b3[instance.content_script_name];
    instances[instances.size] = instance;
}

// Namespace namespace_8b6a9d79/namespace_8b6a9d79
// Params 4, eflags: 0x0
// Checksum 0x79c9019e, Offset: 0x1828
// Size: 0x152
function function_76c93f39(var_832fa4bc, usecallback, hintstring, radius) {
    assert(isarray(var_832fa4bc));
    assert(isfunctionptr(usecallback));
    assert(ishash(hintstring));
    triggers = [];
    foreach (struct in var_832fa4bc) {
        trigger = function_214737c7(struct, usecallback, hintstring, undefined, radius);
        triggers[trigger.size] = trigger;
    }
    return triggers;
}

// Namespace namespace_8b6a9d79/namespace_8b6a9d79
// Params 9, eflags: 0x1 linked
// Checksum 0x70836442, Offset: 0x1988
// Size: 0x240
function function_214737c7(struct, usecallback, hintstring, var_e0355bdc, radius = 64, height = 128, centered = 0, offset = (0, 0, 0), var_499de507) {
    assert(isstruct(struct));
    assert(isfunctionptr(usecallback));
    assert(ishash(hintstring));
    if (isdefined(struct.radius)) {
        radius = struct.radius;
    }
    usetrigger = spawn("trigger_radius_use", struct.origin + offset, 0, radius, height, centered);
    usetrigger triggerignoreteam();
    usetrigger setcursorhint("HINT_NOICON");
    usetrigger usetriggerrequirelookat();
    if (isdefined(var_e0355bdc) && isdefined(var_499de507)) {
        usetrigger sethintstring(hintstring, var_e0355bdc, var_499de507);
    } else if (isdefined(var_e0355bdc)) {
        usetrigger sethintstring(hintstring, var_e0355bdc);
    } else {
        usetrigger sethintstring(hintstring);
    }
    usetrigger callback::on_trigger(usecallback);
    return usetrigger;
}

// Namespace namespace_8b6a9d79/namespace_8b6a9d79
// Params 3, eflags: 0x0
// Checksum 0xfc23e192, Offset: 0x1bd0
// Size: 0xda
function function_cfa4f1a0(var_832fa4bc, modelname, var_bfbc537c = 0) {
    models = [];
    foreach (struct in var_832fa4bc) {
        model = spawn_script_model(struct, modelname, var_bfbc537c);
        models[models.size] = model;
    }
    return models;
}

// Namespace namespace_8b6a9d79/namespace_8b6a9d79
// Params 3, eflags: 0x1 linked
// Checksum 0x2ef8cfc7, Offset: 0x1cb8
// Size: 0x19a
function spawn_script_model(struct, modelname, var_bfbc537c = 0) {
    model = spawn("script_model", struct.origin);
    model.angles = struct.angles;
    model setmodel(modelname);
    if (var_bfbc537c) {
        model disconnectpaths();
    }
    parent = struct;
    while (true) {
        if (parent.variantname === #"content_instance") {
            if (!isdefined(parent.var_344a6a1a)) {
                parent.var_344a6a1a = [];
            } else if (!isarray(parent.var_344a6a1a)) {
                parent.var_344a6a1a = array(parent.var_344a6a1a);
            }
            if (!isinarray(parent.var_344a6a1a, model)) {
                parent.var_344a6a1a[parent.var_344a6a1a.size] = model;
            }
            break;
        }
        parent = struct::get(parent.target);
        if (!isdefined(parent)) {
            break;
        }
    }
    return model;
}

// Namespace namespace_8b6a9d79/namespace_8b6a9d79
// Params 3, eflags: 0x1 linked
// Checksum 0x23a6f86f, Offset: 0x1e60
// Size: 0x182
function function_94974eef(struct, var_145b9057, var_e546275c = 0) {
    zbarrier = spawn(var_145b9057, struct.origin);
    zbarrier.angles = struct.angles;
    if (var_e546275c) {
        zbarrier disconnectpaths();
    }
    parent = struct;
    while (true) {
        if (parent.variantname === #"content_instance") {
            if (!isdefined(parent.var_344a6a1a)) {
                parent.var_344a6a1a = [];
            } else if (!isarray(parent.var_344a6a1a)) {
                parent.var_344a6a1a = array(parent.var_344a6a1a);
            }
            if (!isinarray(parent.var_344a6a1a, zbarrier)) {
                parent.var_344a6a1a[parent.var_344a6a1a.size] = zbarrier;
            }
            break;
        }
        parent = struct::get(parent.target);
        if (!isdefined(parent)) {
            break;
        }
    }
    return zbarrier;
}

// Namespace namespace_8b6a9d79/namespace_8b6a9d79
// Params 0, eflags: 0x1 linked
// Checksum 0xfd776e3e, Offset: 0x1ff0
// Size: 0x324
function cleanup_spawned_instances() {
    level notify(#"cleanup_spawned_instances");
    foreach (group in level.var_7d45d0d4.var_5eba96b3) {
        foreach (instance in group) {
            if (isdefined(instance.var_344a6a1a)) {
                foreach (model in instance.var_344a6a1a) {
                    if (isdefined(model)) {
                        if (isdefined(model.trigger)) {
                            model.trigger delete();
                        }
                        if (isdefined(model.var_e55c8b4e)) {
                            objective_delete(model.var_e55c8b4e);
                            gameobjects::release_obj_id(model.var_e55c8b4e);
                        }
                        if (isdefined(model.objectiveid)) {
                            objective_delete(model.objectiveid);
                            gameobjects::release_obj_id(model.objectiveid);
                        }
                        model scene::stop();
                        model delete();
                    }
                }
                arrayremovevalue(instance.var_344a6a1a, undefined);
            }
            arrayremovevalue(group, instance, 1);
            arrayremovevalue(instance.location.var_5eba96b3, instance, 1);
        }
        arrayremovevalue(group, undefined);
        arrayremovevalue(level.var_7d45d0d4.var_5eba96b3, group, 1);
    }
    arrayremovevalue(level.var_7d45d0d4.var_5eba96b3, undefined);
}

// Namespace namespace_8b6a9d79/namespace_8b6a9d79
// Params 1, eflags: 0x5 linked
// Checksum 0xb8bd0270, Offset: 0x2320
// Size: 0x120
function private function_656a32f0(parent) {
    children = function_f703a5a(parent);
    var_fe2612fe = function_bedd4c47(children);
    parent.var_fe2612fe = var_fe2612fe;
    foreach (child in children) {
        if (child.variantname != #"content_struct" || !isdefined(child.content_key)) {
            continue;
        }
        child.parent = parent;
        function_656a32f0(child);
    }
}

// Namespace namespace_8b6a9d79/namespace_8b6a9d79
// Params 1, eflags: 0x5 linked
// Checksum 0x4fcd326c, Offset: 0x2448
// Size: 0x10a
function private function_bedd4c47(children) {
    groups = [];
    foreach (child in children) {
        if (child.variantname != #"content_struct" || !isdefined(child.content_key)) {
            continue;
        }
        if (!isdefined(groups[child.content_key])) {
            groups[child.content_key] = [];
        }
        group = groups[child.content_key];
        group[group.size] = child;
    }
    return groups;
}

// Namespace namespace_8b6a9d79/namespace_8b6a9d79
// Params 1, eflags: 0x1 linked
// Checksum 0x5e09f724, Offset: 0x2560
// Size: 0x42
function function_f703a5a(parent) {
    if (!isdefined(parent.targetname)) {
        return [];
    }
    return struct::get_array(parent.targetname, "target");
}

/#

    // Namespace namespace_8b6a9d79/namespace_8b6a9d79
    // Params 0, eflags: 0x4
    // Checksum 0xe041ef00, Offset: 0x25b0
    // Size: 0x3dc
    function private init_devgui() {
        util::waittill_can_add_debug_command();
        adddebugcommand("<dev string:xa0>");
        util::add_devgui(devgui_path("<dev string:xcd>", 0), "<dev string:xe2>");
        foreach (destination in level.var_7d45d0d4.destinations) {
            foreach (location in destination.locations) {
                foreach (instance in location.instances) {
                    var_4eb7bd13 = location.targetname + "<dev string:x10b>" + instance.content_script_name;
                    path = devgui_path("<dev string:x110>", 1, destination.targetname, location.targetname, instance.content_script_name);
                    util::add_devgui(path, "<dev string:x120>" + var_4eb7bd13);
                }
            }
        }
        foreach (location in level.var_7d45d0d4.locations) {
            foreach (instance in location.instances) {
                var_4eb7bd13 = location.targetname + "<dev string:x10b>" + instance.content_script_name;
                path = devgui_path("<dev string:x145>", 2, location.targetname, instance.content_script_name);
                util::add_devgui(path, "<dev string:x120>" + var_4eb7bd13);
            }
        }
        level thread debug_draw();
        level thread function_b3843ca7();
    }

    // Namespace namespace_8b6a9d79/namespace_8b6a9d79
    // Params 1, eflags: 0x20 variadic
    // Checksum 0xde314885, Offset: 0x2998
    // Size: 0xd8
    function devgui_path(...) {
        path = "<dev string:x152>";
        foreach (arg in vararg) {
            if (isint(arg)) {
                path += "<dev string:x10b>";
            } else {
                path += "<dev string:x16c>";
            }
            path += arg;
        }
        return path;
    }

    // Namespace namespace_8b6a9d79/namespace_8b6a9d79
    // Params 0, eflags: 0x4
    // Checksum 0x924e51e6, Offset: 0x2a78
    // Size: 0x158
    function private function_b3843ca7() {
        while (true) {
            setdvar(#"hash_6d5a45dcdc3af9b5", "<dev string:x171>");
            waitframe(1);
            var_4eb7bd13 = getdvarstring(#"hash_6d5a45dcdc3af9b5", "<dev string:x171>");
            if (var_4eb7bd13 == "<dev string:x171>") {
                continue;
            }
            keys = strtok(var_4eb7bd13, "<dev string:x10b>");
            if (keys.size != 2) {
                continue;
            }
            location = level.var_7d45d0d4.locations[keys[0]];
            if (!isdefined(location)) {
                continue;
            }
            if (isdefined(location.var_dcb924fd)) {
                continue;
            }
            instance = location.instances[keys[1]];
            if (!isdefined(instance)) {
                continue;
            }
            function_20d7e9c7(instance);
        }
    }

    // Namespace namespace_8b6a9d79/namespace_8b6a9d79
    // Params 0, eflags: 0x4
    // Checksum 0x71096513, Offset: 0x2bd8
    // Size: 0x162
    function private debug_draw() {
        while (true) {
            if (getdvarint(#"hash_55e098bf3549b14d", 0)) {
                foreach (destination in level.var_7d45d0d4.destinations) {
                    function_930df82f(destination);
                }
                foreach (location in level.var_7d45d0d4.locations) {
                    function_540bcd15(location, location.destination);
                }
            }
            waitframe(1);
        }
    }

    // Namespace namespace_8b6a9d79/namespace_8b6a9d79
    // Params 1, eflags: 0x0
    // Checksum 0xce8f3350, Offset: 0x2d48
    // Size: 0x34
    function function_930df82f(destination) {
        function_56a6441e(destination, (0, 1, 0), undefined, destination.targetname);
    }

    // Namespace namespace_8b6a9d79/namespace_8b6a9d79
    // Params 2, eflags: 0x0
    // Checksum 0x398b5421, Offset: 0x2d88
    // Size: 0xe0
    function function_540bcd15(location, destination) {
        if (!isdefined(destination)) {
            destination = undefined;
        }
        function_56a6441e(location, (0, 1, 1), destination, location.targetname);
        foreach (instance in location.instances) {
            function_c01c2807(instance, location);
        }
    }

    // Namespace namespace_8b6a9d79/namespace_8b6a9d79
    // Params 2, eflags: 0x0
    // Checksum 0xcc2b0310, Offset: 0x2e70
    // Size: 0x5c
    function function_c01c2807(instance, location) {
        if (!isdefined(location)) {
            location = undefined;
        }
        function_56a6441e(instance, (0, 0, 1), location);
        function_b2b08c09(instance);
    }

    // Namespace namespace_8b6a9d79/namespace_8b6a9d79
    // Params 1, eflags: 0x0
    // Checksum 0xbaa93d9c, Offset: 0x2ed8
    // Size: 0x13c
    function function_b2b08c09(node) {
        if (isarray(node.var_fe2612fe)) {
            foreach (group in node.var_fe2612fe) {
                foreach (child in group) {
                    function_56a6441e(child, (1, 0, 1), node);
                    function_b2b08c09(child);
                }
            }
        }
    }

    // Namespace namespace_8b6a9d79/namespace_8b6a9d79
    // Params 4, eflags: 0x0
    // Checksum 0x9d683a76, Offset: 0x3020
    // Size: 0x13c
    function function_56a6441e(struct, color, parent, var_f5b09155) {
        if (!isdefined(parent)) {
            parent = undefined;
        }
        if (!isdefined(var_f5b09155)) {
            var_f5b09155 = undefined;
        }
        debugstr = undefined;
        debugstr = function_4636f4cb(debugstr, struct.variantname);
        debugstr = function_4636f4cb(debugstr, struct.content_script_name);
        debugstr = function_4636f4cb(debugstr, struct.content_key);
        debugstr = function_4636f4cb(debugstr, var_f5b09155);
        if (isdefined(parent)) {
            line(struct.origin, parent.origin, color);
        }
        sphere(struct.origin, 8, color);
        print3d(struct.origin, debugstr);
    }

    // Namespace namespace_8b6a9d79/namespace_8b6a9d79
    // Params 2, eflags: 0x0
    // Checksum 0x356c99d9, Offset: 0x3168
    // Size: 0x7a
    function function_4636f4cb(str, append) {
        if (ishash(append)) {
            append = function_9e72a96(append);
        }
        if (!isdefined(str)) {
            return append;
        } else if (isdefined(append)) {
            return (str + "<dev string:x175>" + append);
        }
        return str;
    }

#/
