#using scripts\core_common\flag_shared;

#namespace system;

// Namespace system/system_shared
// Params 5, eflags: 0x0
// Checksum 0xfb952a97, Offset: 0x88
// Size: 0x194
function register(str_name, func_preinit, func_postinit, var_e9137475, reqs) {
    if (isdefined(level.system_funcs[str_name])) {
        assert(level.system_funcs[str_name].flags & 1, "<dev string:x38>" + function_9e72a96(str_name) + "<dev string:x44>");
        return;
    }
    if (!isdefined(level.system_funcs)) {
        level.system_funcs = [];
    }
    system = {#prefunc:func_preinit, #postfunc:func_postinit, #var_f30a1800:var_e9137475, #reqs:reqs, #flags:0};
    system.flags |= isdefined(func_preinit) ? 0 : 2;
    system.flags |= isdefined(func_postinit) ? 0 : 4;
    system.flags |= isdefined(var_e9137475) ? 0 : 8;
    level.system_funcs[str_name] = system;
}

// Namespace system/system_shared
// Params 1, eflags: 0x0
// Checksum 0x4ef6ec70, Offset: 0x228
// Size: 0x90
function exec_post_system(func) {
    if (!isdefined(func) || func.flags & 1) {
        return;
    }
    if (!(func.flags & 4)) {
        if (isdefined(func.reqs)) {
            function_5095b2c6(func);
        }
        func.flags |= 4;
        [[ func.postfunc ]]();
    }
}

// Namespace system/system_shared
// Params 1, eflags: 0x0
// Checksum 0x2c761bb5, Offset: 0x2c0
// Size: 0x1e4
function function_5095b2c6(func) {
    assert(func.flags & 2 || func.flags & 1, "<dev string:x8f>");
    if (isdefined(func.reqs)) {
        if (isarray(func.reqs)) {
            foreach (req in func.reqs) {
                assert(isdefined(req), "<dev string:xfb>" + req + "<dev string:x124>");
                thread exec_post_system(level.system_funcs[req]);
            }
            return;
        }
        assert(isdefined(level.system_funcs[func.reqs]), "<dev string:xfb>" + (ishash(func.reqs) ? function_9e72a96(func.reqs) : func.reqs) + "<dev string:x124>");
        thread exec_post_system(level.system_funcs[func.reqs]);
    }
}

// Namespace system/system_shared
// Params 0, eflags: 0x0
// Checksum 0x4c2f2192, Offset: 0x4b0
// Size: 0xbc
function run_post_systems() {
    foreach (func in level.system_funcs) {
        function_5095b2c6(func);
        thread exec_post_system(func);
    }
    level flag::set("system_postinit_complete");
}

// Namespace system/system_shared
// Params 1, eflags: 0x0
// Checksum 0x32e67231, Offset: 0x578
// Size: 0x8e
function exec_pre_system(func) {
    if (!isdefined(func) || func.flags & 1) {
        return;
    }
    if (!(func.flags & 2)) {
        if (isdefined(func.reqs)) {
            function_8dfa23e0(func);
        }
        [[ func.prefunc ]]();
        func.flags |= 2;
    }
}

// Namespace system/system_shared
// Params 1, eflags: 0x0
// Checksum 0xcdfee0ce, Offset: 0x610
// Size: 0x1a4
function function_8dfa23e0(func) {
    if (isdefined(func.reqs)) {
        if (isarray(func.reqs)) {
            foreach (req in func.reqs) {
                assert(isdefined(req), "<dev string:xfb>" + req + "<dev string:x124>");
                thread exec_pre_system(level.system_funcs[req]);
            }
            return;
        }
        assert(isdefined(level.system_funcs[func.reqs]), "<dev string:xfb>" + (ishash(func.reqs) ? function_9e72a96(func.reqs) : func.reqs) + "<dev string:x124>");
        thread exec_pre_system(level.system_funcs[func.reqs]);
    }
}

// Namespace system/system_shared
// Params 0, eflags: 0x0
// Checksum 0x755c6be4, Offset: 0x7c0
// Size: 0xa0
function run_pre_systems() {
    foreach (func in level.system_funcs) {
        function_8dfa23e0(func);
        thread exec_pre_system(func);
    }
}

// Namespace system/system_shared
// Params 1, eflags: 0x0
// Checksum 0x5e412fa0, Offset: 0x868
// Size: 0x8e
function function_6cc01f0(func) {
    if (!isdefined(func) || func.flags & 1) {
        return;
    }
    if (!(func.flags & 8)) {
        if (isdefined(func.reqs)) {
            function_3e3686fa(func);
        }
        [[ func.var_f30a1800 ]]();
        func.flags |= 8;
    }
}

// Namespace system/system_shared
// Params 1, eflags: 0x0
// Checksum 0x7871f0d6, Offset: 0x900
// Size: 0x1a4
function function_3e3686fa(func) {
    if (isdefined(func.reqs)) {
        if (isarray(func.reqs)) {
            foreach (req in func.reqs) {
                assert(isdefined(req), "<dev string:xfb>" + req + "<dev string:x124>");
                thread function_6cc01f0(level.system_funcs[req]);
            }
            return;
        }
        assert(isdefined(level.system_funcs[func.reqs]), "<dev string:xfb>" + (ishash(func.reqs) ? function_9e72a96(func.reqs) : func.reqs) + "<dev string:x124>");
        thread function_6cc01f0(level.system_funcs[func.reqs]);
    }
}

// Namespace system/system_shared
// Params 0, eflags: 0x0
// Checksum 0xca2df8f3, Offset: 0xab0
// Size: 0xaa
function function_b1553822() {
    foreach (func in level.system_funcs) {
        function_3e3686fa(func);
        thread function_6cc01f0(func);
    }
    level.system_funcs = undefined;
}

// Namespace system/system_shared
// Params 0, eflags: 0x0
// Checksum 0x54b5aa9e, Offset: 0xb68
// Size: 0x24
function function_c11b0642() {
    level flag::wait_till(#"system_postinit_complete");
}

// Namespace system/system_shared
// Params 1, eflags: 0x0
// Checksum 0xd1d6836b, Offset: 0xb98
// Size: 0x92
function ignore(str_name) {
    assert(!isdefined(level.gametype), "<dev string:x129>");
    if (!isdefined(level.system_funcs[str_name])) {
        register(str_name);
    }
    level.system_funcs[str_name].flags = level.system_funcs[str_name].flags | 1;
}

