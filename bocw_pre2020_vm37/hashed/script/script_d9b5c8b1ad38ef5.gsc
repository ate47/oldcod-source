#using script_75da5547b1822294;
#using scripts\core_common\array_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\compass;
#using scripts\core_common\oob;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace territory;

// Namespace territory/territory
// Params 0, eflags: 0x6
// Checksum 0xd5e8d189, Offset: 0x108
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"territory", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace territory/territory
// Params 0, eflags: 0x5 linked
// Checksum 0x217acd7b, Offset: 0x150
// Size: 0x3d0
function private function_70a657d8() {
    clientfield::register("world", "territory_id", 1, 4, "int");
    var_e9308982 = struct::get_array("territory", "variantName");
    for (index = 1; index <= var_e9308982.size; index++) {
        var_e9308982[index - 1].id = index;
    }
    var_97191da8 = getdvarstring(#"hash_31435ea827fda47b", "");
    var_45072867 = strtok(var_97191da8, " ");
    var_45072867 = array::randomize(var_45072867);
    foreach (var_8f246125 in var_45072867) {
        level.territory = struct::get(var_8f246125, "targetname");
        if (isdefined(level.territory)) {
            break;
        }
    }
    if (!isdefined(level.territory)) {
        var_97191da8 = "";
    }
    if (!isdefined(level.territory)) {
        level.territory = {};
    }
    level.territory.name = var_97191da8;
    if (level.territory.name == "") {
        if (var_e9308982.size > 0) {
            level.territory = array::random(var_e9308982);
            level.territory.name = isdefined(level.territory.target) ? level.territory.target : isdefined(level.territory.targetname) ? level.territory.targetname : "";
        }
    }
    if (level.territory.name != "") {
        level thread function_7904ef68(level.territory);
    }
    /#
        mapname = util::get_map_name();
        foreach (territory in var_e9308982) {
            adddebugcommand("<dev string:x38>" + mapname + "<dev string:x49>" + territory.targetname + "<dev string:x5d>" + territory.targetname + "<dev string:x74>");
        }
    #/
}

// Namespace territory/territory
// Params 4, eflags: 0x5 linked
// Checksum 0x566a40a3, Offset: 0x528
// Size: 0x156
function private function_49695e98(center, mins, maxs, origin) {
    if (mins[0] + origin[0] < center.mins[0]) {
        center.mins = (mins[0] + origin[0], center.mins[1], 0);
    }
    if (mins[1] + origin[1] < center.mins[1]) {
        center.mins = (center.mins[0], mins[1] + origin[1], 0);
    }
    if (maxs[0] + origin[0] > center.maxs[0]) {
        center.maxs = (maxs[0] + origin[0], center.maxs[1], 0);
    }
    if (maxs[1] + origin[1] > center.maxs[1]) {
        center.maxs = (center.maxs[0], maxs[1] + origin[1], 0);
    }
}

// Namespace territory/territory
// Params 1, eflags: 0x5 linked
// Checksum 0x2715e988, Offset: 0x688
// Size: 0x45a
function private function_7904ef68(territory) {
    if (!isdefined(territory)) {
        assert(0);
        return;
    }
    while (!loadnavvolume(territory.name)) {
        waitframe(1);
    }
    level clientfield::set("territory_id", territory.id);
    territory.bounds = [];
    if (isdefined(territory.target)) {
        entities = getentarray(territory.target, "targetname");
        center = spawnstruct();
        center.mins = (2.14748e+09, 2.14748e+09, 0);
        center.maxs = (-2.14748e+09, -2.14748e+09, 0);
        foreach (entity in entities) {
            if (isdefined(entity.classname) && entity.classname == #"trigger_within_bounds") {
                territory.bounds[territory.bounds.size] = entity;
                function_49695e98(center, entity.mins, entity.maxs, entity.origin);
            }
        }
        center.origin = ((center.mins[0] + center.maxs[0]) / 2, (center.mins[1] + center.maxs[1]) / 2, 0);
        if (territory.bounds.size > 0) {
            oob::function_5e18416d(territory.bounds);
        }
        structs = struct::get_array(territory.target, "targetname");
        foreach (struct in structs) {
            if (isdefined(struct.variantname) && struct.variantname == "territory_circle") {
                territory.circle = struct;
                oob::function_376ddafd(struct.origin, struct.radius);
                halfwidth = struct.radius * 1.02;
                compass::function_d6cba2e9("", struct.origin[0] - halfwidth, struct.origin[1] + halfwidth, struct.origin[0] + halfwidth, struct.origin[1] - halfwidth);
                center.origin = struct.origin;
                center.mins = center.origin - (struct.radius, struct.radius, 0);
                center.maxs = center.origin + (struct.radius, struct.radius, 0);
                break;
            }
        }
        level.territory.var_f1dda100 = center;
    }
}

// Namespace territory/territory
// Params 3, eflags: 0x1 linked
// Checksum 0xfe6205bb, Offset: 0xaf0
// Size: 0x122
function function_1deaf019(name, key, territory = level.territory) {
    var_3e8b00df = [];
    entities = getentarray(name, key);
    foreach (entity in entities) {
        if (!is_valid(entity, territory)) {
            continue;
        }
        if (is_inside(entity.origin, undefined, territory)) {
            var_3e8b00df[var_3e8b00df.size] = entity;
        }
    }
    return var_3e8b00df;
}

// Namespace territory/territory
// Params 3, eflags: 0x1 linked
// Checksum 0x6870bfb7, Offset: 0xc20
// Size: 0x7a
function function_1f583d2e(name, key = "targetname", territory = level.territory) {
    entities = getentarray(name, key);
    return function_39dd704c(entities, territory);
}

