#using scripts/core_common/delete;
#using scripts/core_common/scene_shared;

#namespace struct;

// Namespace struct/struct
// Params 0, eflags: 0x2
// Checksum 0x108d39ec, Offset: 0x178
// Size: 0x24
function autoexec __init__() {
    if (!isdefined(level.struct)) {
        init_structs();
    }
}

// Namespace struct/struct
// Params 0, eflags: 0x0
// Checksum 0xaccea635, Offset: 0x1a8
// Size: 0x12e
function init_structs() {
    level.struct = [];
    level.struct_class_names = [];
    level.struct_class_names["target"] = [];
    level.struct_class_names["targetname"] = [];
    level.struct_class_names["script_noteworthy"] = [];
    level.struct_class_names["script_linkname"] = [];
    level.struct_class_names["script_label"] = [];
    level.struct_class_names["classname"] = [];
    level.struct_class_names["variantname"] = [];
    level.struct_class_names["script_unitrigger_type"] = [];
    level.struct_class_names["scriptbundlename"] = [];
    level.struct_class_names["prefabname"] = [];
    level.struct_class_names["script_igc_teleport_location"] = [];
}

// Namespace struct/struct
// Params 1, eflags: 0x0
// Checksum 0x9180142a, Offset: 0x2e0
// Size: 0x5c
function function_aa4875d1(struct) {
    struct.configstringfiletype = undefined;
    /#
        devstate = struct.devstate;
    #/
    struct.devstate = undefined;
    /#
        struct.devstate = devstate;
    #/
}

// Namespace struct/createstruct
// Params 1, eflags: 0x40
// Checksum 0x60221add, Offset: 0x348
// Size: 0x44
function event_handler[createstruct] createstruct(struct) {
    if (!isdefined(level.struct)) {
        init_structs();
    }
    struct init();
}

// Namespace struct/struct
// Params 0, eflags: 0x0
// Checksum 0x7460e015, Offset: 0x398
// Size: 0x290
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
    foreach (str_key, _ in level.struct_class_names) {
        if (isdefined(self.(str_key))) {
            if (str_key == "script_linkname") {
                /#
                    assert(!isdefined(level.struct_class_names[str_key][self.(str_key)]), "<dev string:x28>" + str_key);
                #/
            }
            if (!isdefined(level.struct_class_names[str_key][self.(str_key)])) {
                level.struct_class_names[str_key][self.(str_key)] = [];
            } else if (!isarray(level.struct_class_names[str_key][self.(str_key)])) {
                level.struct_class_names[str_key][self.(str_key)] = array(level.struct_class_names[str_key][self.(str_key)]);
            }
            level.struct_class_names[str_key][self.(str_key)][level.struct_class_names[str_key][self.(str_key)].size] = self;
        }
    }
}

// Namespace struct/struct
// Params 2, eflags: 0x0
// Checksum 0x34362e04, Offset: 0x630
// Size: 0x174
function get(kvp_value, kvp_key) {
    if (!isdefined(kvp_key)) {
        kvp_key = "targetname";
    }
    if (isdefined(level.struct_class_names[kvp_key]) && isdefined(level.struct_class_names[kvp_key][kvp_value])) {
        /#
            if (level.struct_class_names[kvp_key][kvp_value].size > 1) {
                /#
                    assertmsg("<dev string:x43>" + kvp_key + "<dev string:x78>" + kvp_value + "<dev string:x7e>");
                #/
                return undefined;
            }
        #/
        return level.struct_class_names[kvp_key][kvp_value][0];
    }
    for (i = 0; i < level.struct.size; i++) {
        if (isdefined(level.struct[i].(kvp_key)) && level.struct[i].(kvp_key) === kvp_value) {
            return level.struct[i];
        }
    }
}

// Namespace struct/struct
// Params 2, eflags: 0x0
// Checksum 0x965540c8, Offset: 0x7b0
// Size: 0x84
function spawn(v_origin, v_angles) {
    if (!isdefined(v_origin)) {
        v_origin = (0, 0, 0);
    }
    if (!isdefined(v_angles)) {
        v_angles = (0, 0, 0);
    }
    s = spawnstruct();
    s.origin = v_origin;
    s.angles = v_angles;
    return s;
}

// Namespace struct/struct
// Params 2, eflags: 0x0
// Checksum 0x5b2eb0a3, Offset: 0x840
// Size: 0x186
function get_array(kvp_value, kvp_key) {
    if (!isdefined(kvp_key)) {
        kvp_key = "targetname";
    }
    if (isdefined(level.struct_class_names[kvp_key]) && isdefined(level.struct_class_names[kvp_key][kvp_value])) {
        return arraycopy(level.struct_class_names[kvp_key][kvp_value]);
    }
    a_structs = [];
    for (i = 0; i < level.struct.size; i++) {
        if (isdefined(level.struct[i].(kvp_key)) && level.struct[i].(kvp_key) === kvp_value) {
            if (!isdefined(a_structs)) {
                a_structs = [];
            } else if (!isarray(a_structs)) {
                a_structs = array(a_structs);
            }
            a_structs[a_structs.size] = level.struct[i];
        }
    }
    return a_structs;
}

// Namespace struct/struct
// Params 0, eflags: 0x0
// Checksum 0xb6ef15db, Offset: 0x9d0
// Size: 0xba
function delete() {
    foreach (str_key, _ in level.struct_class_names) {
        if (isdefined(self.(str_key))) {
            arrayremovevalue(level.struct_class_names[str_key][self.(str_key)], self);
        }
    }
}

// Namespace struct/struct
// Params 2, eflags: 0x0
// Checksum 0x91c5f6e9, Offset: 0xa98
// Size: 0x3c
function get_script_bundle(str_type, str_name) {
    struct = getscriptbundle(str_name);
    return struct;
}

// Namespace struct/struct
// Params 2, eflags: 0x0
// Checksum 0x67d00324, Offset: 0xae0
// Size: 0x14
function function_368120a1(str_type, str_name) {
    
}

// Namespace struct/struct
// Params 1, eflags: 0x0
// Checksum 0x23a31ddb, Offset: 0xb00
// Size: 0x34
function get_script_bundles(str_type) {
    structs = getscriptbundles(str_type);
    return structs;
}

// Namespace struct/struct
// Params 2, eflags: 0x0
// Checksum 0x1ba9eb73, Offset: 0xb40
// Size: 0x2a
function get_script_bundle_list(str_type, str_name) {
    return getscriptbundlelist(str_name);
}

// Namespace struct/struct
// Params 2, eflags: 0x0
// Checksum 0xe3d8c677, Offset: 0xb78
// Size: 0x116
function get_script_bundle_instances(str_type, str_name) {
    if (!isdefined(str_name)) {
        str_name = "";
    }
    a_instances = get_array("scriptbundle_" + str_type, "classname");
    if (str_name != "") {
        foreach (i, s_instance in a_instances) {
            if (s_instance.scriptbundlename != str_name) {
                arrayremoveindex(a_instances, i, 1);
            }
        }
    }
    return a_instances;
}

// Namespace struct/findstruct
// Params 3, eflags: 0x40
// Checksum 0x5bb68081, Offset: 0xc98
// Size: 0x324
function event_handler[findstruct] findstruct(param1, name, index) {
    if (isvec(param1)) {
        position = param1;
        foreach (key, _ in level.struct_class_names) {
            foreach (s_array in level.struct_class_names[key]) {
                foreach (struct in s_array) {
                    if (distancesquared(struct.origin, position) < 1) {
                        return struct;
                    }
                }
            }
        }
        if (isdefined(level.struct)) {
            foreach (struct in level.struct) {
                if (distancesquared(struct.origin, position) < 1) {
                    return struct;
                }
            }
        }
    } else {
        s = get(param1);
        if (isdefined(s)) {
            return s;
        }
        s = get_script_bundle(param1, name);
        if (isdefined(s)) {
            if (index < 0) {
                return s;
            } else if (isdefined(s.objects)) {
                return s.objects[index];
            }
        }
    }
    return undefined;
}

