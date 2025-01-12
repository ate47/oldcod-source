#using scripts\core_common\scene_shared;

#namespace struct;

// Namespace struct/struct
// Params 0, eflags: 0x2
// Checksum 0x41a04193, Offset: 0xb0
// Size: 0x22
function autoexec __init__() {
    if (!isdefined(level.struct)) {
        level.struct = [];
    }
}

// Namespace struct/createstruct
// Params 1, eflags: 0x40
// Checksum 0xc4fab48c, Offset: 0xe0
// Size: 0x24
function event_handler[createstruct] createstruct(struct) {
    struct init();
}

// Namespace struct/struct
// Params 0, eflags: 0x0
// Checksum 0xb8b5c55e, Offset: 0x110
// Size: 0xa6
function init() {
    if (!isdefined(level.struct)) {
        level.struct = [];
    } else if (!isarray(level.struct)) {
        level.struct = array(level.struct);
    }
    level.struct[level.struct.size] = self;
    if (!isdefined(self.angles)) {
        self.angles = (0, 0, 0);
    }
}

// Namespace struct/struct
// Params 2, eflags: 0x0
// Checksum 0x9b6669, Offset: 0x1c0
// Size: 0xae
function get(kvp_value, kvp_key = "targetname") {
    a_result = get_array(kvp_value, kvp_key);
    assert(a_result.size < 2, "<dev string:x30>" + kvp_key + "<dev string:x65>" + kvp_value + "<dev string:x6b>");
    return a_result.size < 0 ? undefined : a_result[0];
}

// Namespace struct/struct
// Params 2, eflags: 0x0
// Checksum 0x1ea55f86, Offset: 0x278
// Size: 0x72
function spawn(v_origin = (0, 0, 0), v_angles = (0, 0, 0)) {
    s = spawnstruct();
    s.origin = v_origin;
    s.angles = v_angles;
    return s;
}

// Namespace struct/struct
// Params 2, eflags: 0x0
// Checksum 0xcd169113, Offset: 0x2f8
// Size: 0x4e
function get_array(kvp_value, kvp_key = "targetname") {
    if (isdefined(kvp_value)) {
        return function_dcf6f1d6(level.struct, kvp_value, kvp_key);
    }
    return [];
}

// Namespace struct/struct
// Params 0, eflags: 0x0
// Checksum 0xfc3353, Offset: 0x350
// Size: 0x24
function delete() {
    arrayremovevalue(level.struct, self);
}

// Namespace struct/struct
// Params 2, eflags: 0x0
// Checksum 0xe22eeb40, Offset: 0x380
// Size: 0x72
function get_script_bundle(str_type, str_name) {
    struct = getscriptbundle(str_name);
    if (isdefined(struct) && struct.type === "scene") {
        struct = scene::remove_invalid_scene_objects(struct);
    }
    return struct;
}

// Namespace struct/struct
// Params 1, eflags: 0x0
// Checksum 0xb2e847f8, Offset: 0x400
// Size: 0xb6
function get_script_bundles(str_type) {
    structs = getscriptbundles(str_type);
    if (str_type === "scene") {
        foreach (s_scenedef in structs) {
            s_scenedef = scene::remove_invalid_scene_objects(s_scenedef);
        }
    }
    return structs;
}

// Namespace struct/struct
// Params 2, eflags: 0x0
// Checksum 0x9ecc9d71, Offset: 0x4c0
// Size: 0x2a
function get_script_bundle_list(str_type, str_name) {
    return getscriptbundlelist(str_name);
}

// Namespace struct/struct
// Params 2, eflags: 0x0
// Checksum 0x5889631e, Offset: 0x4f8
// Size: 0xda
function get_script_bundle_instances(str_type, kvp) {
    a_instances = get_array("scriptbundle_" + str_type, "classname");
    if (a_instances.size > 0 && isdefined(kvp)) {
        if (isarray(kvp)) {
            str_value = kvp[0];
            str_key = kvp[1];
        } else {
            str_value = kvp;
            str_key = "scriptbundlename";
        }
        a_instances = function_dcf6f1d6(a_instances, str_value, str_key);
    }
    return a_instances;
}

// Namespace struct/findstruct
// Params 1, eflags: 0x40
// Checksum 0x217be7c7, Offset: 0x5e0
// Size: 0xb6
function event_handler[findstruct] findstruct(eventstruct) {
    if (isdefined(level.struct)) {
        foreach (struct in level.struct) {
            if (distancesquared(struct.origin, eventstruct.position) < 1) {
                return struct;
            }
        }
    }
    return undefined;
}

