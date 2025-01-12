#namespace ai_shared;

// Namespace ai_shared/ai_shared
// Params 0, eflags: 0x2
// Checksum 0x579ba170, Offset: 0x88
// Size: 0x20
function autoexec main() {
    level._customactorcbfunc = &ai::spawned_callback;
}

#namespace ai;

// Namespace ai/ai_shared
// Params 1, eflags: 0x0
// Checksum 0x3e64e7cf, Offset: 0xb0
// Size: 0x6e
function add_ai_spawn_function(spawn_func) {
    if (!isdefined(level.var_ba02f75c)) {
        level.var_ba02f75c = [];
    }
    func = [];
    func["function"] = spawn_func;
    level.var_ba02f75c[level.var_ba02f75c.size] = func;
}

// Namespace ai/ai_shared
// Params 2, eflags: 0x0
// Checksum 0x152ee4bc, Offset: 0x128
// Size: 0x13c
function add_archetype_spawn_function(archetype, spawn_func) {
    if (!isdefined(level.spawn_funcs)) {
        level.spawn_funcs = [];
    }
    if (!isdefined(level.spawn_funcs[archetype])) {
        level.spawn_funcs[archetype] = [];
    }
    func = [];
    func["function"] = spawn_func;
    if (!isdefined(level.spawn_funcs[archetype])) {
        level.spawn_funcs[archetype] = [];
    } else if (!isarray(level.spawn_funcs[archetype])) {
        level.spawn_funcs[archetype] = array(level.spawn_funcs[archetype]);
    }
    level.spawn_funcs[archetype][level.spawn_funcs[archetype].size] = func;
}

// Namespace ai/ai_shared
// Params 1, eflags: 0x0
// Checksum 0xeecfa312, Offset: 0x270
// Size: 0x128
function spawned_callback(localclientnum) {
    if (isdefined(level.var_ba02f75c)) {
        for (index = 0; index < level.var_ba02f75c.size; index++) {
            func = level.var_ba02f75c[index];
            self thread [[ func["function"] ]](localclientnum);
        }
    }
    if (isdefined(level.spawn_funcs) && isdefined(level.spawn_funcs[self.archetype])) {
        for (index = 0; index < level.spawn_funcs[self.archetype].size; index++) {
            func = level.spawn_funcs[self.archetype][index];
            self thread [[ func["function"] ]](localclientnum);
        }
    }
}

// Namespace ai/ai_shared
// Params 1, eflags: 0x0
// Checksum 0xa48c6a83, Offset: 0x3a0
// Size: 0x50
function shouldregisterclientfieldforarchetype(archetype) {
    if (isdefined(level.clientfieldaicheck) && level.clientfieldaicheck && !isarchetypeloaded(archetype)) {
        return false;
    }
    return true;
}

