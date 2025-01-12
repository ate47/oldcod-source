#using scripts\core_common\flagsys_shared;

#namespace system;

// Namespace system/system_shared
// Params 4, eflags: 0x0
// Checksum 0x788e52de, Offset: 0x88
// Size: 0x18e
function register(str_name, func_preinit, func_postinit, reqs) {
    if (isdefined(level.system_funcs) && isdefined(level.system_funcs[str_name])) {
        assert(level.system_funcs[str_name].ignore, "<dev string:x30>" + function_15979fa9(str_name) + "<dev string:x39>");
        return;
    }
    if (!isdefined(level.system_funcs)) {
        level.system_funcs = [];
    }
    level.system_funcs[str_name] = spawnstruct();
    level.system_funcs[str_name].prefunc = func_preinit;
    level.system_funcs[str_name].postfunc = func_postinit;
    level.system_funcs[str_name].reqs = reqs;
    level.system_funcs[str_name].predone = !isdefined(func_preinit);
    level.system_funcs[str_name].postdone = !isdefined(func_postinit);
    level.system_funcs[str_name].ignore = 0;
}

// Namespace system/system_shared
// Params 1, eflags: 0x0
// Checksum 0xbd9bacdc, Offset: 0x220
// Size: 0x94
function exec_post_system(func) {
    if (!isdefined(func) || isdefined(func.ignore) && func.ignore) {
        return;
    }
    if (!func.postdone) {
        if (isdefined(func.reqs)) {
            function_ac1d86a6(func);
        }
        func.postdone = 1;
        [[ func.postfunc ]]();
    }
}

// Namespace system/system_shared
// Params 1, eflags: 0x0
// Checksum 0x9ef5b023, Offset: 0x2c0
// Size: 0x1e4
function function_ac1d86a6(func) {
    assert(func.predone || func.ignore, "<dev string:x81>");
    if (isdefined(func.reqs)) {
        if (isarray(func.reqs)) {
            foreach (req in func.reqs) {
                assert(isdefined(req), "<dev string:xea>" + req + "<dev string:x110>");
                thread exec_post_system(level.system_funcs[req]);
            }
            return;
        }
        assert(isdefined(level.system_funcs[func.reqs]), "<dev string:xea>" + (ishash(func.reqs) ? function_15979fa9(func.reqs) : func.reqs) + "<dev string:x110>");
        thread exec_post_system(level.system_funcs[func.reqs]);
    }
}

// Namespace system/system_shared
// Params 0, eflags: 0x0
// Checksum 0x280e0355, Offset: 0x4b0
// Size: 0xbe
function run_post_systems() {
    foreach (func in level.system_funcs) {
        function_ac1d86a6(func);
        thread exec_post_system(func);
    }
    level flagsys::set("system_init_complete");
    level.system_funcs = undefined;
}

// Namespace system/system_shared
// Params 1, eflags: 0x0
// Checksum 0xef0a763a, Offset: 0x578
// Size: 0x92
function exec_pre_system(func) {
    if (!isdefined(func) || isdefined(func.ignore) && func.ignore) {
        return;
    }
    if (!func.predone) {
        if (isdefined(func.reqs)) {
            function_e6626f77(func);
        }
        [[ func.prefunc ]]();
        func.predone = 1;
    }
}

// Namespace system/system_shared
// Params 1, eflags: 0x0
// Checksum 0xed46cbb, Offset: 0x618
// Size: 0x1a4
function function_e6626f77(func) {
    if (isdefined(func.reqs)) {
        if (isarray(func.reqs)) {
            foreach (req in func.reqs) {
                assert(isdefined(req), "<dev string:xea>" + req + "<dev string:x110>");
                thread exec_pre_system(level.system_funcs[req]);
            }
            return;
        }
        assert(isdefined(level.system_funcs[func.reqs]), "<dev string:xea>" + (ishash(func.reqs) ? function_15979fa9(func.reqs) : func.reqs) + "<dev string:x110>");
        thread exec_pre_system(level.system_funcs[func.reqs]);
    }
}

// Namespace system/system_shared
// Params 0, eflags: 0x0
// Checksum 0x87c16f36, Offset: 0x7c8
// Size: 0x98
function run_pre_systems() {
    foreach (func in level.system_funcs) {
        function_e6626f77(func);
        thread exec_pre_system(func);
    }
}

// Namespace system/system_shared
// Params 1, eflags: 0x0
// Checksum 0x188fd153, Offset: 0x868
// Size: 0x2c
function wait_till(required_systems) {
    level flagsys::wait_till("system_init_complete");
}

// Namespace system/system_shared
// Params 1, eflags: 0x0
// Checksum 0x7a0e4617, Offset: 0x8a0
// Size: 0x9a
function ignore(str_name) {
    assert(!isdefined(level.gametype), "<dev string:x112>");
    if (!isdefined(level.system_funcs) || !isdefined(level.system_funcs[str_name])) {
        register(str_name, undefined, undefined, undefined);
    }
    level.system_funcs[str_name].ignore = 1;
}

