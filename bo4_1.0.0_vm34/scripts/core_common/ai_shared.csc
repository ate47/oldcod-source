#using scripts\core_common\util_shared;

#namespace ai_shared;

// Namespace ai_shared/ai_shared
// Params 0, eflags: 0x2
// Checksum 0x31c3ac47, Offset: 0x78
// Size: 0x1e
function autoexec main() {
    level._customactorcbfunc = &ai::spawned_callback;
}

#namespace ai;

// Namespace ai/ai_shared
// Params 2, eflags: 0x20 variadic
// Checksum 0xfc3df203, Offset: 0xa0
// Size: 0x132
function add_ai_spawn_function(func_spawn, ...) {
    if (!isdefined(level.var_720840a6)) {
        level.var_720840a6 = [];
    } else if (!isarray(level.var_720840a6)) {
        level.var_720840a6 = array(level.var_720840a6);
    }
    var_58eb44c6 = {#func:func_spawn, #params:vararg};
    if (!isdefined(level.var_720840a6)) {
        level.var_720840a6 = [];
    } else if (!isarray(level.var_720840a6)) {
        level.var_720840a6 = array(level.var_720840a6);
    }
    level.var_720840a6[level.var_720840a6.size] = var_58eb44c6;
}

// Namespace ai/ai_shared
// Params 1, eflags: 0x0
// Checksum 0x6f720f97, Offset: 0x1e0
// Size: 0xb2
function function_692f6be5(func_spawn) {
    if (!isdefined(level.var_720840a6)) {
        return;
    }
    foreach (var_58eb44c6 in level.var_720840a6) {
        if (var_58eb44c6.func == func_spawn) {
            arrayremovevalue(level.var_720840a6, var_58eb44c6);
            return;
        }
    }
}

// Namespace ai/ai_shared
// Params 3, eflags: 0x20 variadic
// Checksum 0x77b4570a, Offset: 0x2a0
// Size: 0x1e0
function add_archetype_spawn_function(str_archetype, func_spawn, ...) {
    if (!isdefined(level.var_f2d29d45)) {
        level.var_f2d29d45 = [];
    } else if (!isarray(level.var_f2d29d45)) {
        level.var_f2d29d45 = array(level.var_f2d29d45);
    }
    if (!isdefined(level.var_f2d29d45[str_archetype])) {
        level.var_f2d29d45[str_archetype] = [];
    } else if (!isarray(level.var_f2d29d45[str_archetype])) {
        level.var_f2d29d45[str_archetype] = array(level.var_f2d29d45[str_archetype]);
    }
    var_bafac65 = {#func:func_spawn, #params:vararg};
    if (!isdefined(level.var_f2d29d45[str_archetype])) {
        level.var_f2d29d45[str_archetype] = [];
    } else if (!isarray(level.var_f2d29d45[str_archetype])) {
        level.var_f2d29d45[str_archetype] = array(level.var_f2d29d45[str_archetype]);
    }
    level.var_f2d29d45[str_archetype][level.var_f2d29d45[str_archetype].size] = var_bafac65;
}

// Namespace ai/ai_shared
// Params 1, eflags: 0x0
// Checksum 0x699439d6, Offset: 0x488
// Size: 0x1d8
function spawned_callback(localclientnum) {
    if (isdefined(level.var_720840a6)) {
        foreach (var_58eb44c6 in level.var_720840a6) {
            a_args = arraycombine(array(localclientnum), var_58eb44c6.params, 1, 0);
            util::single_func_argarray(self, var_58eb44c6.func, a_args);
        }
    }
    if (isdefined(level.var_f2d29d45) && isdefined(level.var_f2d29d45[self.archetype])) {
        foreach (var_bafac65 in level.var_f2d29d45[self.archetype]) {
            a_args = arraycombine(array(localclientnum), var_bafac65.params, 1, 0);
            util::single_func_argarray(self, var_bafac65.func, a_args);
        }
    }
}

// Namespace ai/ai_shared
// Params 1, eflags: 0x0
// Checksum 0x2f9b3d93, Offset: 0x668
// Size: 0x52
function shouldregisterclientfieldforarchetype(archetype) {
    if (isdefined(level.clientfieldaicheck) && level.clientfieldaicheck && !isarchetypeloaded(archetype)) {
        return false;
    }
    return true;
}

// Namespace ai/ai_shared
// Params 0, eflags: 0x0
// Checksum 0x53a095f7, Offset: 0x6c8
// Size: 0xf4
function function_a0dbf10a() {
    if (!isdefined(self.var_105bdc9c)) {
        if (isdefined(self.aisettingsbundle)) {
            settingsbundle = self.aisettingsbundle;
        } else if (isdefined(self.scriptbundlesettings)) {
            settingsbundle = getscriptbundle(self.scriptbundlesettings).aisettingsbundle;
        }
        if (!isdefined(settingsbundle)) {
            return undefined;
        }
        self.var_105bdc9c = settingsbundle;
        if (!isdefined(level.var_48d9e777)) {
            level.var_48d9e777 = [];
        }
        if (!isdefined(level.var_48d9e777[self.var_105bdc9c])) {
            level.var_48d9e777[self.var_105bdc9c] = getscriptbundle(self.var_105bdc9c);
        }
    }
    return level.var_48d9e777[self.var_105bdc9c];
}

// Namespace ai/ai_shared
// Params 3, eflags: 0x0
// Checksum 0x130d6164, Offset: 0x7c8
// Size: 0xda
function function_f338efae(var_79ee70c4, fieldname, archetype) {
    if (!isdefined(level.var_48d9e777)) {
        level.var_48d9e777 = [];
    }
    if (!isdefined(level.var_48d9e777[var_79ee70c4])) {
        level.var_48d9e777[var_79ee70c4] = getscriptbundle(var_79ee70c4);
    }
    if (isdefined(level.var_48d9e777[var_79ee70c4])) {
        if (isdefined(archetype)) {
            return level.var_48d9e777[var_79ee70c4].(archetype + "_" + fieldname);
        }
        return level.var_48d9e777[var_79ee70c4].(fieldname);
    }
    return undefined;
}

