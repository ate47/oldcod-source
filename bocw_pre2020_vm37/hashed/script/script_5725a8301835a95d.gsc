#using script_340a2e805e35f7a2;
#using script_7fc996fe8678852;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace namespace_1ab3fb7b;

// Namespace namespace_1ab3fb7b/namespace_1ab3fb7b
// Params 0, eflags: 0x6
// Checksum 0xa04c7db9, Offset: 0xe0
// Size: 0x54
function private autoexec __init__system__() {
    system::register(#"hash_4e995bd55f8098d6", &function_70a657d8, undefined, &finalize, #"hash_f81b9dea74f0ee");
}

// Namespace namespace_1ab3fb7b/namespace_1ab3fb7b
// Params 0, eflags: 0x4
// Checksum 0xbd100db5, Offset: 0x140
// Size: 0x7c
function private function_70a657d8() {
    namespace_8b6a9d79::function_b3464a7c("harvest_essence", &function_a4cec352);
    namespace_8b6a9d79::function_b3464a7c("harvest_essence_small", &function_225965a4);
    namespace_8b6a9d79::function_b3464a7c("harvest_scrap", &function_7a918a3f);
}

// Namespace namespace_1ab3fb7b/namespace_1ab3fb7b
// Params 0, eflags: 0x4
// Checksum 0x6c82075d, Offset: 0x1c8
// Size: 0x1c
function private finalize() {
    /#
        level thread init_devgui();
    #/
}

// Namespace namespace_1ab3fb7b/namespace_1ab3fb7b
// Params 1, eflags: 0x0
// Checksum 0x6f258608, Offset: 0x1f0
// Size: 0x44
function function_a4cec352(instance) {
    function_871649b9(instance, #"hash_797f22647c9675c5", #"sr_harvesting_zombie_essence", 5);
}

// Namespace namespace_1ab3fb7b/namespace_1ab3fb7b
// Params 1, eflags: 0x0
// Checksum 0x17a54d1e, Offset: 0x240
// Size: 0x44
function function_225965a4(instance) {
    function_871649b9(instance, #"essence_spawn_small", #"sr_harvesting_zombie_essence_small", 25);
}

// Namespace namespace_1ab3fb7b/namespace_1ab3fb7b
// Params 1, eflags: 0x0
// Checksum 0x3a795bbb, Offset: 0x290
// Size: 0x44
function function_7a918a3f(instance) {
    function_871649b9(instance, #"hash_773e201984b53b32", #"sr_harvesting_scrap", 5);
}

// Namespace namespace_1ab3fb7b/namespace_1ab3fb7b
// Params 4, eflags: 0x4
// Checksum 0x8a990397, Offset: 0x2e0
// Size: 0x36c
function private function_871649b9(instance, var_eece1f6a, var_f8dfa2cf, n_spawns) {
    level flag::wait_till(#"gameplay_started");
    instance flag::wait_till_clear(#"hash_788aaa9d57c1fa71");
    a_spawns = array::randomize(isdefined(instance.var_fe2612fe[var_eece1f6a]) ? instance.var_fe2612fe[var_eece1f6a] : []);
    if (!a_spawns.size) {
        return;
    }
    /#
        if (getdvarint(#"hash_3a6e54c134a6a916", 0) || n_spawns == -1) {
            n_spawns = a_spawns.size;
        }
    #/
    a_items = [];
    for (i = 0; i < n_spawns; i++) {
        if (isdefined(a_spawns[i])) {
            var_7acb5180 = a_spawns[i] namespace_65181344::function_fd87c780(var_f8dfa2cf, 1);
            if (isdefined(var_7acb5180[0])) {
                var_1a517f12 = getscriptbundle(var_7acb5180[0].var_a6762160.name);
                var_7adcadc1 = var_1a517f12.var_7adcadc1;
                var_6731866b = var_1a517f12.var_6731866b;
                var_e6ac0592 = var_1a517f12.var_e6ac0592;
                var_ada071fe = var_1a517f12.var_ada071fe;
                var_5ab74bb1 = var_1a517f12.var_5ab74bb1;
                var_50773731 = var_1a517f12.var_50773731;
                if (!isdefined(var_7adcadc1)) {
                    var_7adcadc1 = 0;
                }
                if (!isdefined(var_6731866b)) {
                    var_6731866b = 0;
                }
                if (!isdefined(var_e6ac0592)) {
                    var_e6ac0592 = 0;
                }
                if (!isdefined(var_ada071fe)) {
                    var_ada071fe = 0;
                }
                if (!isdefined(var_5ab74bb1)) {
                    var_5ab74bb1 = 0;
                }
                if (!isdefined(var_50773731)) {
                    var_50773731 = 0;
                }
                var_7acb5180[0].origin = a_spawns[i].origin + (var_ada071fe, var_5ab74bb1, var_50773731);
                var_7acb5180[0].angles = a_spawns[i].angles + (var_7adcadc1, var_6731866b, var_e6ac0592);
                /#
                    a_spawns[i].var_b215c441 = 1;
                #/
                a_items = arraycombine(a_items, var_7acb5180);
            }
        }
    }
    instance.a_items = a_items;
    instance callback::function_d8abfc3d(#"hash_345e9169ebba28fb", &function_149da5dd);
    /#
        level util::delay(1, undefined, &function_95da1d88, instance, function_9e72a96(var_eece1f6a), var_f8dfa2cf);
    #/
}

// Namespace namespace_1ab3fb7b/namespace_1ab3fb7b
// Params 0, eflags: 0x4
// Checksum 0xe594b94d, Offset: 0x658
// Size: 0x1cc
function private function_149da5dd() {
    self flag::set(#"hash_788aaa9d57c1fa71");
    self callback::function_52ac9652(#"hash_345e9169ebba28fb", &function_149da5dd);
    /#
        a_spawns = struct::get_array(self.targetname, "<dev string:x38>");
        foreach (spawn in a_spawns) {
            spawn.var_b215c441 = undefined;
        }
    #/
    if (isdefined(self.a_items)) {
        foreach (item in self.a_items) {
            /#
                self.var_b215c441 = undefined;
            #/
            if (isdefined(item)) {
                item delete();
                waitframe(1);
            }
        }
        self.a_items = undefined;
    }
    self flag::clear(#"hash_788aaa9d57c1fa71");
}

/#

    // Namespace namespace_1ab3fb7b/namespace_1ab3fb7b
    // Params 0, eflags: 0x4
    // Checksum 0xfbfc582a, Offset: 0x830
    // Size: 0x13c
    function private init_devgui() {
        util::waittill_can_add_debug_command();
        util::add_devgui("<dev string:x42>", "<dev string:x74>");
        util::add_devgui("<dev string:x94>", "<dev string:xcc>");
        util::add_devgui("<dev string:xe7>", "<dev string:x110>");
        util::add_devgui("<dev string:x12b>", "<dev string:x15f>");
        util::add_devgui("<dev string:x181>", "<dev string:x1bd>");
        util::add_devgui("<dev string:x1da>", "<dev string:x207>");
        util::add_devgui("<dev string:x224>", "<dev string:x25e>");
        util::add_devgui("<dev string:x286>", "<dev string:x2c0>");
        util::add_devgui("<dev string:x2e3>", "<dev string:x31c>");
    }

    // Namespace namespace_1ab3fb7b/namespace_1ab3fb7b
    // Params 3, eflags: 0x4
    // Checksum 0x4bc47473, Offset: 0x978
    // Size: 0x3ee
    function private function_95da1d88(instance, var_eece1f6a, var_f8dfa2cf) {
        instance notify(#"hash_554bb5d130031f06");
        instance endon(#"hash_554bb5d130031f06");
        a_spawns = isdefined(instance.var_fe2612fe[var_eece1f6a]) ? instance.var_fe2612fe[var_eece1f6a] : [];
        if (!a_spawns.size) {
            return;
        }
        n_spawn = 0;
        var_9911be33 = "<dev string:x33f>" + var_eece1f6a;
        while (true) {
            var_794c9d5f = getdvarint(var_9911be33, 0);
            if (var_794c9d5f) {
                if (var_794c9d5f == 2) {
                    setdvar(var_9911be33, 1);
                    iprintlnbold("<dev string:x349>" + function_9e72a96(var_eece1f6a) + "<dev string:x35a>");
                    instance function_149da5dd();
                    function_871649b9(instance, var_eece1f6a, var_f8dfa2cf, -1);
                    iprintlnbold("<dev string:x36e>");
                }
                foreach (spawn in a_spawns) {
                    if (is_true(spawn.var_b215c441)) {
                        str_color = (1, 0.5, 0);
                    } else {
                        str_color = (0.75, 0.75, 0.75);
                    }
                    n_radius = 64;
                    n_dist = distance(spawn.origin, getplayers()[0].origin);
                    n_radius *= n_dist / 3000;
                    sphere(spawn.origin, n_radius, str_color, 1, 0, 7, 5);
                }
                if (var_794c9d5f == 3) {
                    setdvar(var_9911be33, 1);
                    if (n_spawn >= a_spawns.size - 1) {
                        n_spawn = 0;
                    }
                    s_spawn = a_spawns[n_spawn];
                    if (isdefined(s_spawn)) {
                        foreach (player in function_a1ef346b()) {
                            player setorigin(s_spawn.origin);
                        }
                        n_spawn++;
                    }
                }
            }
            waitframe(5);
        }
    }

#/
