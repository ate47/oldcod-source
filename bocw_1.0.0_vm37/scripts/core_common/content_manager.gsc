#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\gameobjects_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace content_manager;

// Namespace content_manager/content_manager
// Params 0, eflags: 0x6
// Checksum 0x1095efa, Offset: 0xe0
// Size: 0x44
function private autoexec __init__system__() {
    system::register(#"content_manager", &preinit, undefined, &finalize, undefined);
}

// Namespace content_manager/content_manager
// Params 0, eflags: 0x4
// Checksum 0x7b9a2bd1, Offset: 0x130
// Size: 0x42
function private preinit() {
    level.contentmanager = spawnstruct();
    level.contentmanager.registeredscripts = [];
    level.contentmanager.scriptcategories = [];
}

// Namespace content_manager/content_manager
// Params 0, eflags: 0x4
// Checksum 0xc1a4144e, Offset: 0x180
// Size: 0x54
function private finalize() {
    setup_destinations();
    setup_locations();
    level.contentmanager.spawnedinstances = [];
    /#
        level thread init_devgui();
    #/
}

// Namespace content_manager/content_manager
// Params 2, eflags: 0x0
// Checksum 0x8b3a09dc, Offset: 0x1e0
// Size: 0xfe
function register_script(scriptname, spawncallback) {
    assert(isstring(scriptname) || ishash(scriptname));
    assert(isfunctionptr(spawncallback));
    registeredscripts = level.contentmanager.registeredscripts;
    assert(!isdefined(registeredscripts[scriptname]));
    script = {#scriptname:scriptname, #spawncallback:spawncallback};
    registeredscripts[scriptname] = script;
    return script;
}

// Namespace content_manager/content_manager
// Params 1, eflags: 0x0
// Checksum 0x28c5d044, Offset: 0x2e8
// Size: 0x64
function get_script(scriptname) {
    assert(isstring(scriptname) || ishash(scriptname));
    return level.contentmanager.registeredscripts[scriptname];
}

// Namespace content_manager/content_manager
// Params 2, eflags: 0x0
// Checksum 0x1b93c78d, Offset: 0x358
// Size: 0x1de
function function_31e8da78(destination, content_category) {
    locations = array::randomize(get_children(destination));
    for (i = 0; i < locations.size; i++) {
        if (locations[i].variantname !== #"content_location") {
            arrayremoveindex(locations, i, 1);
        }
    }
    arrayremovevalue(locations, undefined);
    foreach (location in locations) {
        instances = array::randomize(get_children(location));
        foreach (instance in instances) {
            if (instance.content_script_name === content_category) {
                return instance;
            }
        }
    }
}

// Namespace content_manager/content_manager
// Params 0, eflags: 0x4
// Checksum 0x408c869, Offset: 0x540
// Size: 0x43a
function private setup_destinations() {
    mapdestinations = struct::get_array(#"content_destination", "variantname");
    destinations = [];
    level.contentmanager.destinations = destinations;
    foreach (destination in mapdestinations) {
        assert(isdefined(destination.targetname));
        assert(!isdefined(destinations[destination.targetname]));
        destinations[destination.targetname] = destination;
        function_656a32f0(destination);
        locations = [];
        destination.locations = locations;
        children = get_children(destination);
        foreach (child in children) {
            if (child.variantname != #"content_location") {
                continue;
            }
            assert(isdefined(child.targetname));
            assert(!isdefined(locations[child.targetname]));
            locations[child.targetname] = child;
        }
    }
    var_e5f80f4e = getmapfields(util::get_map_name());
    if (isdefined(var_e5f80f4e.var_dd9e5316)) {
        foreach (destination in var_e5f80f4e.var_dd9e5316) {
            struct::get(destination.targetname).var_8d629117 = !is_true(destination.var_a15fd6d3);
            if (!isdefined(destination.var_7774bfaf)) {
                continue;
            }
            enabled = getgametypesetting(destination.var_7774bfaf);
            assert(isdefined(enabled), "<dev string:x38>" + destination.var_7774bfaf + "<dev string:x4c>");
            if (is_false(enabled) && getdvarstring(#"hash_36112559be5dfe28", "") != destination.targetname) {
                arrayremovevalue(destinations, struct::get(destination.targetname));
            }
        }
    }
    level.contentmanager.destinations = array::randomize(destinations);
}

// Namespace content_manager/content_manager
// Params 2, eflags: 0x0
// Checksum 0x591be191, Offset: 0x988
// Size: 0x144
function setup_adjacencies(str_destination, var_2d26f85c) {
    assert(isdefined(level.contentmanager.destinations[str_destination]) && isdefined("<dev string:x5e>" + str_destination));
    i = 0;
    foreach (var_fc091632 in var_2d26f85c) {
        adjacency = struct::get(var_fc091632);
        assert(isdefined(adjacency) && isdefined("<dev string:x8d>" + var_fc091632));
        level.contentmanager.destinations[str_destination].adjacencies[i] = adjacency;
        i++;
    }
}

// Namespace content_manager/content_manager
// Params 1, eflags: 0x0
// Checksum 0xef4eec4f, Offset: 0xad8
// Size: 0x9e
function function_fe9fb6fd(location) {
    assert(isstruct(location));
    assert(location.variantname == #"content_location");
    spawned_instances = isarray(location.spawnedinstances) && location.spawnedinstances.size > 0;
    return spawned_instances;
}

// Namespace content_manager/content_manager
// Params 0, eflags: 0x4
// Checksum 0xd2323535, Offset: 0xb80
// Size: 0x2ba
function private setup_locations() {
    maplocations = struct::get_array(#"content_location", "variantname");
    locations = [];
    level.contentmanager.locations = locations;
    foreach (location in maplocations) {
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
        children = get_children(location);
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

// Namespace content_manager/content_manager
// Params 1, eflags: 0x0
// Checksum 0xf733b01e, Offset: 0xe48
// Size: 0x164
function spawn_instance(instance) {
    assert(isstruct(instance));
    assert(instance.variantname == #"content_instance");
    assert(isstring(instance.content_script_name) || ishash(instance.content_script_name));
    assert(isstruct(instance.location));
    function_656a32f0(instance);
    script = level.contentmanager.registeredscripts[instance.content_script_name];
    if (isdefined(script.spawncallback)) {
        level thread [[ script.spawncallback ]](instance);
    }
    function_130f0da3(instance);
}

// Namespace content_manager/content_manager
// Params 1, eflags: 0x0
// Checksum 0xad2ddd34, Offset: 0xfb8
// Size: 0xfc
function function_1c78a45d(instance) {
    assert(isstruct(instance));
    assert(instance.variantname == #"content_instance");
    assert(isstring(instance.content_script_name) || ishash(instance.content_script_name));
    assert(isstruct(instance.location));
    return !function_fe9fb6fd(instance.location);
}

// Namespace content_manager/content_manager
// Params 1, eflags: 0x4
// Checksum 0x4b9950c, Offset: 0x10c0
// Size: 0xfe
function private function_130f0da3(instance) {
    assert(isarray(level.contentmanager.spawnedinstances));
    if (!isdefined(instance.location.spawnedinstances)) {
        instance.location.spawnedinstances = [];
    }
    instance.location.spawnedinstances[instance.location.spawnedinstances.size] = instance;
    spawnedinstances = level.contentmanager.spawnedinstances;
    if (!isdefined(spawnedinstances[instance.content_script_name])) {
        spawnedinstances[instance.content_script_name] = [];
    }
    instances = spawnedinstances[instance.content_script_name];
    instances[instances.size] = instance;
}

// Namespace content_manager/content_manager
// Params 4, eflags: 0x0
// Checksum 0xd163b585, Offset: 0x11c8
// Size: 0x152
function function_76c93f39(contentstructs, usecallback, hintstring, radius) {
    assert(isarray(contentstructs));
    assert(isfunctionptr(usecallback));
    assert(ishash(hintstring));
    triggers = [];
    foreach (struct in contentstructs) {
        trigger = spawn_interact(struct, usecallback, hintstring, undefined, radius);
        triggers[trigger.size] = trigger;
    }
    return triggers;
}

// Namespace content_manager/content_manager
// Params 9, eflags: 0x0
// Checksum 0x5a994c9c, Offset: 0x1328
// Size: 0x240
function spawn_interact(struct, usecallback, hintstring, var_e0355bdc, radius = 64, height = 128, centered = 1, offset = (0, 0, 0), var_499de507) {
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

// Namespace content_manager/content_manager
// Params 3, eflags: 0x0
// Checksum 0x81f27b3c, Offset: 0x1570
// Size: 0xda
function function_cfa4f1a0(contentstructs, modelname, var_bfbc537c = 0) {
    models = [];
    foreach (struct in contentstructs) {
        model = spawn_script_model(struct, modelname, var_bfbc537c);
        models[models.size] = model;
    }
    return models;
}

// Namespace content_manager/content_manager
// Params 3, eflags: 0x0
// Checksum 0x3eca0bf3, Offset: 0x1658
// Size: 0x1ba
function spawn_script_model(struct, modelname, var_bfbc537c = 0) {
    model = util::spawn_model(modelname, struct.origin, struct.angles);
    if (isdefined(struct.targetname)) {
        model.targetname = struct.targetname;
    }
    if (isdefined(struct.script_noteworthy)) {
        model.script_noteworthy = struct.script_noteworthy;
    }
    if (var_bfbc537c) {
        model disconnectpaths();
    }
    parent = struct;
    while (true) {
        if (parent.variantname === #"content_instance") {
            if (!isdefined(parent.a_models)) {
                parent.a_models = [];
            } else if (!isarray(parent.a_models)) {
                parent.a_models = array(parent.a_models);
            }
            if (!isinarray(parent.a_models, model)) {
                parent.a_models[parent.a_models.size] = model;
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

// Namespace content_manager/content_manager
// Params 3, eflags: 0x0
// Checksum 0x1c2e4d52, Offset: 0x1820
// Size: 0x182
function spawn_zbarrier(struct, zbarrier_classname, var_e546275c = 0) {
    zbarrier = spawn(zbarrier_classname, struct.origin);
    zbarrier.angles = struct.angles;
    if (var_e546275c) {
        zbarrier disconnectpaths();
    }
    parent = struct;
    while (true) {
        if (parent.variantname === #"content_instance") {
            if (!isdefined(parent.a_models)) {
                parent.a_models = [];
            } else if (!isarray(parent.a_models)) {
                parent.a_models = array(parent.a_models);
            }
            if (!isinarray(parent.a_models, zbarrier)) {
                parent.a_models[parent.a_models.size] = zbarrier;
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

// Namespace content_manager/content_manager
// Params 0, eflags: 0x0
// Checksum 0xd57de951, Offset: 0x19b0
// Size: 0x3bc
function function_690c4abe() {
    level notify(#"hash_4a140b223cb0019d");
    models_cleaned = 0;
    foreach (group in level.contentmanager.spawnedinstances) {
        foreach (instance in group) {
            if (isdefined(instance.a_models)) {
                foreach (model in instance.a_models) {
                    if (isdefined(model)) {
                        if (isdefined(model.trigger)) {
                            model.trigger delete();
                        }
                        if (isdefined(model.var_e55c8b4e)) {
                            if (isdefined(level.var_49f8cef4)) {
                                [[ level.var_49f8cef4 ]](model.var_e55c8b4e);
                            } else {
                                objective_delete(model.var_e55c8b4e);
                                gameobjects::release_obj_id(model.var_e55c8b4e);
                            }
                        }
                        if (isdefined(model.objectiveid)) {
                            if (isdefined(level.var_49f8cef4)) {
                                [[ level.var_49f8cef4 ]](model.objectiveid);
                            } else {
                                objective_delete(model.objectiveid);
                                gameobjects::release_obj_id(model.objectiveid);
                            }
                        }
                        model scene::stop();
                        model delete();
                        models_cleaned += 1;
                        if (models_cleaned % 10 == 0) {
                            waitframe(1);
                        }
                    }
                }
                arrayremovevalue(instance.a_models, undefined);
            }
            arrayremovevalue(group, instance, 1);
            arrayremovevalue(instance.location.spawnedinstances, instance, 1);
        }
        arrayremovevalue(group, undefined);
        arrayremovevalue(level.contentmanager.spawnedinstances, group, 1);
    }
    arrayremovevalue(level.contentmanager.spawnedinstances, undefined);
}

// Namespace content_manager/content_manager
// Params 1, eflags: 0x4
// Checksum 0x7680daa5, Offset: 0x1d78
// Size: 0x120
function private function_656a32f0(parent) {
    children = get_children(parent);
    contentgroups = function_bedd4c47(children);
    parent.contentgroups = contentgroups;
    foreach (child in children) {
        if (child.variantname != #"content_struct" || !isdefined(child.content_key)) {
            continue;
        }
        child.parent = parent;
        function_656a32f0(child);
    }
}

// Namespace content_manager/content_manager
// Params 1, eflags: 0x4
// Checksum 0x305a4c47, Offset: 0x1ea0
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

// Namespace content_manager/content_manager
// Params 1, eflags: 0x0
// Checksum 0x2c5a7f1c, Offset: 0x1fb8
// Size: 0x42
function get_children(parent) {
    if (!isdefined(parent.targetname)) {
        return [];
    }
    return struct::get_array(parent.targetname, "target");
}

/#

    // Namespace content_manager/content_manager
    // Params 0, eflags: 0x4
    // Checksum 0x4cc0cdd5, Offset: 0x2008
    // Size: 0x3dc
    function private init_devgui() {
        util::waittill_can_add_debug_command();
        adddebugcommand("<dev string:xc6>");
        util::add_devgui(devgui_path("<dev string:xf3>", 0), "<dev string:x108>");
        foreach (destination in level.contentmanager.destinations) {
            foreach (location in destination.locations) {
                foreach (instance in location.instances) {
                    instancekey = location.targetname + "<dev string:x131>" + instance.content_script_name;
                    path = devgui_path("<dev string:x136>", 1, destination.targetname, location.targetname, instance.content_script_name);
                    util::add_devgui(path, "<dev string:x146>" + instancekey);
                }
            }
        }
        foreach (location in level.contentmanager.locations) {
            foreach (instance in location.instances) {
                instancekey = location.targetname + "<dev string:x131>" + instance.content_script_name;
                path = devgui_path("<dev string:x16b>", 2, location.targetname, instance.content_script_name);
                util::add_devgui(path, "<dev string:x146>" + instancekey);
            }
        }
        level thread debug_draw();
        level thread function_b3843ca7();
    }

    // Namespace content_manager/content_manager
    // Params 1, eflags: 0x20 variadic
    // Checksum 0x49c0e464, Offset: 0x23f0
    // Size: 0xd8
    function devgui_path(...) {
        path = "<dev string:x178>";
        foreach (arg in vararg) {
            if (isint(arg)) {
                path += "<dev string:x131>";
            } else {
                path += "<dev string:x192>";
            }
            path += arg;
        }
        return path;
    }

    // Namespace content_manager/content_manager
    // Params 0, eflags: 0x4
    // Checksum 0xad4c2bdc, Offset: 0x24d0
    // Size: 0x158
    function private function_b3843ca7() {
        while (true) {
            setdvar(#"hash_6d5a45dcdc3af9b5", "<dev string:x197>");
            waitframe(1);
            instancekey = getdvarstring(#"hash_6d5a45dcdc3af9b5", "<dev string:x197>");
            if (instancekey == "<dev string:x197>") {
                continue;
            }
            keys = strtok(instancekey, "<dev string:x131>");
            if (keys.size != 2) {
                continue;
            }
            location = level.contentmanager.locations[keys[0]];
            if (!isdefined(location)) {
                continue;
            }
            if (isdefined(location.spawnedinstance)) {
                continue;
            }
            instance = location.instances[keys[1]];
            if (!isdefined(instance)) {
                continue;
            }
            spawn_instance(instance);
        }
    }

    // Namespace content_manager/content_manager
    // Params 0, eflags: 0x4
    // Checksum 0x4a0b8d08, Offset: 0x2630
    // Size: 0x162
    function private debug_draw() {
        while (true) {
            if (getdvarint(#"hash_55e098bf3549b14d", 0)) {
                foreach (destination in level.contentmanager.destinations) {
                    draw_destination(destination);
                }
                foreach (location in level.contentmanager.locations) {
                    draw_location(location, location.destination);
                }
            }
            waitframe(1);
        }
    }

    // Namespace content_manager/content_manager
    // Params 1, eflags: 0x0
    // Checksum 0xfe7d44c1, Offset: 0x27a0
    // Size: 0x34
    function draw_destination(destination) {
        draw_struct(destination, (0, 1, 0), undefined, destination.targetname);
    }

    // Namespace content_manager/content_manager
    // Params 2, eflags: 0x0
    // Checksum 0x693b54f6, Offset: 0x27e0
    // Size: 0xe0
    function draw_location(location, destination) {
        if (!isdefined(destination)) {
            destination = undefined;
        }
        draw_struct(location, (0, 1, 1), destination, location.targetname);
        foreach (instance in location.instances) {
            draw_instance(instance, location);
        }
    }

    // Namespace content_manager/content_manager
    // Params 2, eflags: 0x0
    // Checksum 0x3ab4e04a, Offset: 0x28c8
    // Size: 0x5c
    function draw_instance(instance, location) {
        if (!isdefined(location)) {
            location = undefined;
        }
        draw_struct(instance, (0, 0, 1), location);
        function_b2b08c09(instance);
    }

    // Namespace content_manager/content_manager
    // Params 1, eflags: 0x0
    // Checksum 0xc0ff4aee, Offset: 0x2930
    // Size: 0x13c
    function function_b2b08c09(node) {
        if (isarray(node.contentgroups)) {
            foreach (group in node.contentgroups) {
                foreach (child in group) {
                    draw_struct(child, (1, 0, 1), node);
                    function_b2b08c09(child);
                }
            }
        }
    }

    // Namespace content_manager/content_manager
    // Params 4, eflags: 0x0
    // Checksum 0xd5abe02, Offset: 0x2a78
    // Size: 0x13c
    function draw_struct(struct, color, parent, extrastr) {
        if (!isdefined(parent)) {
            parent = undefined;
        }
        if (!isdefined(extrastr)) {
            extrastr = undefined;
        }
        debugstr = undefined;
        debugstr = function_4636f4cb(debugstr, struct.variantname);
        debugstr = function_4636f4cb(debugstr, struct.content_script_name);
        debugstr = function_4636f4cb(debugstr, struct.content_key);
        debugstr = function_4636f4cb(debugstr, extrastr);
        if (isdefined(parent)) {
            line(struct.origin, parent.origin, color);
        }
        sphere(struct.origin, 8, color);
        print3d(struct.origin, debugstr);
    }

    // Namespace content_manager/content_manager
    // Params 2, eflags: 0x0
    // Checksum 0xb62fa324, Offset: 0x2bc0
    // Size: 0x7a
    function function_4636f4cb(str, append) {
        if (ishash(append)) {
            append = function_9e72a96(append);
        }
        if (!isdefined(str)) {
            return append;
        } else if (isdefined(append)) {
            return (str + "<dev string:x19b>" + append);
        }
        return str;
    }

#/
