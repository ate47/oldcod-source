#using scripts/core_common/array_shared;
#using scripts/core_common/flag_shared;

#namespace system;

// Namespace system/system_shared
// Params 4, eflags: 0x0
// Checksum 0x2e5c8f54, Offset: 0xe0
// Size: 0x1a0
function register(str_name, func_preinit, func_postinit, reqs) {
    if (!isdefined(reqs)) {
        reqs = [];
    }
    if (isdefined(level.system_funcs) && isdefined(level.system_funcs[str_name])) {
        /#
            assertmsg("<dev string:x28>" + str_name + "<dev string:x31>");
        #/
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
// Checksum 0xc7c5351e, Offset: 0x288
// Size: 0xd4
function exec_post_system(str_name) {
    /#
        if (!isdefined(level.system_funcs[str_name])) {
            /#
                assertmsg("<dev string:x28>" + str_name + "<dev string:x79>");
            #/
        }
    #/
    if (level.system_funcs[str_name].ignore) {
        return;
    }
    if (!level.system_funcs[str_name].postdone) {
        [[ level.system_funcs[str_name].postfunc ]]();
        level.system_funcs[str_name].postdone = 1;
    }
}

// Namespace system/system_shared
// Params 0, eflags: 0x0
// Checksum 0x5ae1fcba, Offset: 0x368
// Size: 0x1f4
function run_post_systems() {
    foreach (key, func in level.system_funcs) {
        /#
            assert(func.predone || func.ignore, "<dev string:x8b>");
        #/
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
// Checksum 0x393fe649, Offset: 0x568
// Size: 0xd4
function exec_pre_system(str_name) {
    /#
        if (!isdefined(level.system_funcs[str_name])) {
            /#
                assertmsg("<dev string:x28>" + str_name + "<dev string:x79>");
            #/
        }
    #/
    if (level.system_funcs[str_name].ignore) {
        return;
    }
    if (!level.system_funcs[str_name].predone) {
        [[ level.system_funcs[str_name].prefunc ]]();
        level.system_funcs[str_name].predone = 1;
    }
}

// Namespace system/system_shared
// Params 0, eflags: 0x0
// Checksum 0xe5c1e8a8, Offset: 0x648
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
// Checksum 0x755c7262, Offset: 0x7b8
// Size: 0x6c
function wait_till(required_systems) {
    if (!level flag::exists("system_init_complete")) {
        level flag::init("system_init_complete", 0);
    }
    level flag::wait_till("system_init_complete");
}

// Namespace system/system_shared
// Params 1, eflags: 0x0
// Checksum 0x5f6c60fa, Offset: 0x830
// Size: 0xa4
function ignore(str_name) {
    /#
        assert(!isdefined(level.gametype), "<dev string:xf4>");
    #/
    if (!isdefined(level.system_funcs) || !isdefined(level.system_funcs[str_name])) {
        register(str_name, undefined, undefined, undefined);
    }
    level.system_funcs[str_name].ignore = 1;
}

// Namespace system/system_shared
// Params 1, eflags: 0x0
// Checksum 0x307d2bcc, Offset: 0x8e0
// Size: 0x56
function function_85aec44f(str_name) {
    if (!isdefined(level.system_funcs) || !isdefined(level.system_funcs[str_name])) {
        return 0;
    }
    return level.system_funcs[str_name].postdone;
}

