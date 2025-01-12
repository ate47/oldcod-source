#using scripts/core_common/array_shared;
#using scripts/core_common/flag_shared;

#namespace system;

// Namespace system/system_shared
// Params 4, eflags: 0x0
// Checksum 0x16107e, Offset: 0xe0
// Size: 0x170
function register(var_f6d58016, func_preinit, func_postinit, reqs) {
    if (!isdefined(reqs)) {
        reqs = [];
    }
    if (isdefined(level.system_funcs) && isdefined(level.system_funcs[var_f6d58016])) {
        return;
    }
    if (!isdefined(level.system_funcs)) {
        level.system_funcs = [];
    }
    level.system_funcs[var_f6d58016] = spawnstruct();
    level.system_funcs[var_f6d58016].prefunc = func_preinit;
    level.system_funcs[var_f6d58016].postfunc = func_postinit;
    level.system_funcs[var_f6d58016].reqs = reqs;
    level.system_funcs[var_f6d58016].predone = !isdefined(func_preinit);
    level.system_funcs[var_f6d58016].postdone = !isdefined(func_postinit);
    level.system_funcs[var_f6d58016].ignore = 0;
}

// Namespace system/system_shared
// Params 1, eflags: 0x0
// Checksum 0x13842ee6, Offset: 0x258
// Size: 0xd4
function exec_post_system(req) {
    /#
        if (!isdefined(level.system_funcs[req])) {
            assertmsg("<dev string:x28>" + req + "<dev string:x31>");
        }
    #/
    if (level.system_funcs[req].ignore) {
        return;
    }
    if (!level.system_funcs[req].postdone) {
        [[ level.system_funcs[req].postfunc ]]();
        level.system_funcs[req].postdone = 1;
    }
}

// Namespace system/system_shared
// Params 0, eflags: 0x0
// Checksum 0x4c31eb63, Offset: 0x338
// Size: 0x1f4
function run_post_systems() {
    foreach (key, func in level.system_funcs) {
        assert(func.predone || func.ignore, "<dev string:x43>");
        if (isarray(func.reqs)) {
            foreach (req in func.reqs) {
                thread exec_post_system(req);
            }
        } else {
            thread exec_post_system(func.reqs);
        }
        thread exec_post_system(key);
    }
    if (!level flag::exists("system_init_complete")) {
        level flag::init("system_init_complete", 0);
    }
    level flag::set("system_init_complete");
}

// Namespace system/system_shared
// Params 1, eflags: 0x0
// Checksum 0xb0da2bf8, Offset: 0x538
// Size: 0xd4
function exec_pre_system(req) {
    /#
        if (!isdefined(level.system_funcs[req])) {
            assertmsg("<dev string:x28>" + req + "<dev string:x31>");
        }
    #/
    if (level.system_funcs[req].ignore) {
        return;
    }
    if (!level.system_funcs[req].predone) {
        [[ level.system_funcs[req].prefunc ]]();
        level.system_funcs[req].predone = 1;
    }
}

// Namespace system/system_shared
// Params 0, eflags: 0x0
// Checksum 0xd06a73e1, Offset: 0x618
// Size: 0x162
function run_pre_systems() {
    foreach (key, func in level.system_funcs) {
        if (isarray(func.reqs)) {
            foreach (req in func.reqs) {
                thread exec_pre_system(req);
            }
        } else {
            thread exec_pre_system(func.reqs);
        }
        thread exec_pre_system(key);
    }
}

// Namespace system/system_shared
// Params 1, eflags: 0x0
// Checksum 0xb7bf5edc, Offset: 0x788
// Size: 0x6c
function wait_till(required_systems) {
    if (!level flag::exists("system_init_complete")) {
        level flag::init("system_init_complete", 0);
    }
    level flag::wait_till("system_init_complete");
}

// Namespace system/system_shared
// Params 1, eflags: 0x0
// Checksum 0x8e642307, Offset: 0x800
// Size: 0xa4
function ignore(var_f6d58016) {
    assert(!isdefined(level.gametype), "<dev string:xac>");
    if (!isdefined(level.system_funcs) || !isdefined(level.system_funcs[var_f6d58016])) {
        register(var_f6d58016, undefined, undefined, undefined);
    }
    level.system_funcs[var_f6d58016].ignore = 1;
}

// Namespace system/system_shared
// Params 1, eflags: 0x0
// Checksum 0x4abe3cdb, Offset: 0x8b0
// Size: 0x56
function function_85aec44f(var_f6d58016) {
    if (!isdefined(level.system_funcs) || !isdefined(level.system_funcs[var_f6d58016])) {
        return 0;
    }
    return level.system_funcs[var_f6d58016].postdone;
}

