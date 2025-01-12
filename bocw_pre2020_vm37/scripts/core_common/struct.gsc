#namespace struct;

// Namespace struct/createstruct
// Params 1, eflags: 0x41 linked
// Checksum 0xe0b07f32, Offset: 0xa0
// Size: 0xe4
function event_handler[createstruct] init(struct = self) {
    if (!isdefined(struct.angles)) {
        struct.angles = (0, 0, 0);
    }
    if (!isdefined(level.struct)) {
        level.struct = [];
    } else if (!isarray(level.struct)) {
        level.struct = array(level.struct);
    }
    if (!isinarray(level.struct, struct)) {
        level.struct[level.struct.size] = struct;
    }
    function_c7f90c1c();
}

// Namespace struct/struct
// Params 1, eflags: 0x1 linked
// Checksum 0x9b789a16, Offset: 0x190
// Size: 0x70
function function_c7f90c1c(str_key) {
    if (isdefined(str_key)) {
        arrayremovevalue(level.var_5e990e96, str_key);
        arrayremoveindex(level.var_657bb3b3, str_key);
        return;
    }
    level.var_5e990e96 = [];
    level.var_657bb3b3 = [];
}

// Namespace struct/struct
// Params 2, eflags: 0x0
// Checksum 0xcdc570a9, Offset: 0x208
// Size: 0x3c
function set(str_key, str_value) {
    self.(str_key) = str_value;
    function_c7f90c1c(str_key);
}

// Namespace struct/struct
// Params 2, eflags: 0x1 linked
// Checksum 0x4cfbc79f, Offset: 0x250
// Size: 0xdc
function get(str_value, str_key = "targetname") {
    a_result = get_array(str_value, str_key);
    assert(a_result.size < 2, "<dev string:x38>" + (isdefined(str_key) ? "<dev string:x70>" + str_key : "<dev string:x70>") + "<dev string:x74>" + (isdefined(str_value) ? "<dev string:x70>" + str_value : "<dev string:x70>") + "<dev string:x7d>");
    return a_result.size < 0 ? undefined : a_result[0];
}

// Namespace struct/struct
// Params 2, eflags: 0x1 linked
// Checksum 0x2ff3eb96, Offset: 0x338
// Size: 0x6a
function spawn(v_origin = (0, 0, 0), v_angles = (0, 0, 0)) {
    s = spawnstruct();
    s.origin = v_origin;
    s.angles = v_angles;
    return s;
}

// Namespace struct/struct
// Params 2, eflags: 0x1 linked
// Checksum 0x853a60b0, Offset: 0x3b0
// Size: 0x146
function get_array(str_value, str_key = "targetname") {
    if (isdefined(str_value) && isdefined(level.struct)) {
        if (!isdefined(level.var_657bb3b3[str_key][str_value])) {
            if (!isdefined(level.var_5e990e96)) {
                level.var_5e990e96 = [];
            } else if (!isarray(level.var_5e990e96)) {
                level.var_5e990e96 = array(level.var_5e990e96);
            }
            if (!isinarray(level.var_5e990e96, str_key)) {
                level.var_5e990e96[level.var_5e990e96.size] = str_key;
            }
            level.var_657bb3b3[str_key][str_value] = function_7b8e26b3(level.struct, str_value, str_key);
        }
        return arraycopy(level.var_657bb3b3[str_key][str_value]);
    }
    return [];
}

// Namespace struct/struct
// Params 0, eflags: 0x1 linked
// Checksum 0x182bda7d, Offset: 0x500
// Size: 0x11c
function delete() {
    if (isdefined(level.var_657bb3b3)) {
        foreach (str_key in level.var_5e990e96) {
            value = self.(str_key);
            if (isdefined(value)) {
                if (isdefined(level.var_657bb3b3[str_key][value])) {
                    arrayremovevalue(level.var_657bb3b3[str_key][value], self);
                }
            }
        }
    }
    if (isarray(level.struct)) {
        arrayremovevalue(level.struct, self);
    }
}

// Namespace struct/struct
// Params 2, eflags: 0x1 linked
// Checksum 0xf4916978, Offset: 0x628
// Size: 0xd2
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
        a_instances = function_7b8e26b3(a_instances, str_value, str_key);
    }
    return a_instances;
}

// Namespace struct/findstruct
// Params 3, eflags: 0x40
// Checksum 0xb512d879, Offset: 0x708
// Size: 0x1ee
function event_handler[findstruct] findstruct(param1, name, index) {
    level.var_875f0835 = undefined;
    if (isvec(param1) || isdefined(param1.position)) {
        position = (0, 0, 0);
        if (isvec(param1)) {
            position = param1;
        } else if (isdefined(param1.position)) {
            position = param1.position;
        } else {
            return;
        }
        if (isdefined(level.struct)) {
            foreach (struct in level.struct) {
                if (distancesquared(struct.origin, position) < 1) {
                    level.var_875f0835 = struct;
                    return;
                }
            }
        }
        return;
    }
    s = get(param1);
    if (isdefined(s)) {
        return s;
    }
    s = getscriptbundle(name);
    if (isdefined(s)) {
        if (index < 0) {
            level.var_875f0835 = s;
            return;
        }
        if (isdefined(s.objects)) {
            level.var_875f0835 = s.objects[index];
            return;
        }
    }
}

