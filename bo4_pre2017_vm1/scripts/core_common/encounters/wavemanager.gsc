#using scripts/core_common/ai_shared;
#using scripts/core_common/array_shared;
#using scripts/core_common/encounters/aimappingtable;
#using scripts/core_common/encounters/aispawning;
#using scripts/core_common/flag_shared;
#using scripts/core_common/flagsys_shared;
#using scripts/core_common/spawner_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;
#using scripts/core_common/vehicle_shared;

#namespace namespace_153814c2;

// Namespace namespace_153814c2/namespace_d4676dbf
// Params 0, eflags: 0x2
// Checksum 0x3af8f7cb, Offset: 0x358
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("wavemanager", &__init__, undefined, undefined);
}

#namespace namespace_d4676dbf;

// Namespace namespace_d4676dbf/namespace_d4676dbf
// Params 0, eflags: 0x0
// Checksum 0x35ae7634, Offset: 0x398
// Size: 0x2c
function __constructor() {
    self.var_ad987d30 = [];
    self.var_3426d573 = 1;
    self.var_aeada929 = [];
}

// Namespace namespace_d4676dbf/namespace_d4676dbf
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x3d0
// Size: 0x4
function __destructor() {
    
}

#namespace namespace_153814c2;

// Namespace namespace_153814c2/namespace_d4676dbf
// Params 0, eflags: 0x6
// Checksum 0xfca74beb, Offset: 0x3e0
// Size: 0x236
function private autoexec function_d4676dbf() {
    classes.var_d4676dbf[0] = spawnstruct();
    classes.var_d4676dbf[0].__vtable[1606033458] = &namespace_d4676dbf::__destructor;
    classes.var_d4676dbf[0].__vtable[1317606827] = &namespace_d4676dbf::function_4e8915ab;
    classes.var_d4676dbf[0].__vtable[136023932] = &namespace_d4676dbf::remove_spawn_function;
    classes.var_d4676dbf[0].__vtable[-1723321667] = &namespace_d4676dbf::add_spawn_function;
    classes.var_d4676dbf[0].__vtable[1111404112] = &namespace_d4676dbf::function_423eae50;
    classes.var_d4676dbf[0].__vtable[1927535925] = &namespace_d4676dbf::wait_till_cleared;
    classes.var_d4676dbf[0].__vtable[880706394] = &namespace_d4676dbf::wait_till_complete;
    classes.var_d4676dbf[0].__vtable[1513221879] = &namespace_d4676dbf::function_5a31eef7;
    classes.var_d4676dbf[0].__vtable[-176129371] = &namespace_d4676dbf::function_f5807aa5;
    classes.var_d4676dbf[0].__vtable[-378603407] = &namespace_d4676dbf::function_e96ef871;
    classes.var_d4676dbf[0].__vtable[-1690805083] = &namespace_d4676dbf::__constructor;
}

#namespace namespace_e8d4a9f9;

// Namespace namespace_e8d4a9f9/namespace_d4676dbf
// Params 0, eflags: 0x0
// Checksum 0xafb50d7e, Offset: 0x620
// Size: 0x28
function __constructor() {
    self.variants = [];
    self.var_9403f8be = 0;
    self.a_ai = [];
}

// Namespace namespace_e8d4a9f9/namespace_d4676dbf
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x650
// Size: 0x4
function __destructor() {
    
}

#namespace namespace_153814c2;

// Namespace namespace_153814c2/namespace_d4676dbf
// Params 0, eflags: 0x6
// Checksum 0x44216237, Offset: 0x660
// Size: 0x86
function private autoexec function_e8d4a9f9() {
    classes.var_e8d4a9f9[0] = spawnstruct();
    classes.var_e8d4a9f9[0].__vtable[1606033458] = &namespace_e8d4a9f9::__destructor;
    classes.var_e8d4a9f9[0].__vtable[-1690805083] = &namespace_e8d4a9f9::__constructor;
}

// Namespace namespace_153814c2/namespace_d4676dbf
// Params 0, eflags: 0x4
// Checksum 0xd1089fa5, Offset: 0x6f0
// Size: 0x14
function private __init__() {
    level.var_38ebfef1 = [];
}

// Namespace namespace_153814c2/namespace_d4676dbf
// Params 1, eflags: 0x4
// Checksum 0xd05ceeef, Offset: 0x710
// Size: 0xfe
function private function_2634be7e(var_d4676dbf) {
    /#
        assert(isdefined(var_d4676dbf));
    #/
    var_d4676dbf flag::init("complete");
    var_d4676dbf flag::init("cleared");
    for (n_wave = 1; n_wave <= var_d4676dbf.wavecount; n_wave++) {
        var_d4676dbf flag::init("wave" + n_wave + "_complete");
        var_d4676dbf flag::init("wave" + n_wave + "_cleared");
    }
}

// Namespace namespace_153814c2/namespace_d4676dbf
// Params 1, eflags: 0x4
// Checksum 0x3aceee3, Offset: 0x818
// Size: 0x84
function private function_238194b1(var_d4676dbf) {
    var_d4676dbf flag::set("wave" + var_d4676dbf.var_3426d573 + "_complete");
    if (var_d4676dbf.var_3426d573 == var_d4676dbf.wavecount) {
        var_d4676dbf flag::set("complete");
    }
}

// Namespace namespace_153814c2/namespace_d4676dbf
// Params 2, eflags: 0x4
// Checksum 0x6edf3acc, Offset: 0x8a8
// Size: 0x6c
function private function_49ab51cb(var_d4676dbf, n_wave) {
    if (isdefined(n_wave)) {
        return var_d4676dbf flag::get("wave" + n_wave + "_complete");
    }
    return var_d4676dbf flag::get("complete");
}

// Namespace namespace_153814c2/namespace_d4676dbf
// Params 2, eflags: 0x4
// Checksum 0x50a043ed, Offset: 0x920
// Size: 0x6c
function private function_ee1f18d9(var_d4676dbf, n_wave) {
    if (isdefined(n_wave)) {
        var_d4676dbf flag::wait_till("wave" + n_wave + "_complete");
        return;
    }
    var_d4676dbf flag::wait_till("complete");
}

// Namespace namespace_153814c2/namespace_d4676dbf
// Params 1, eflags: 0x4
// Checksum 0xff07b3d, Offset: 0x998
// Size: 0x7c
function private function_9a621470(var_d4676dbf) {
    var_d4676dbf flag::set("wave" + var_d4676dbf.var_3426d573 + "_cleared");
    if (var_d4676dbf.var_3426d573 == var_d4676dbf.wavecount) {
        function_7a3cc429(var_d4676dbf);
    }
}

// Namespace namespace_153814c2/namespace_d4676dbf
// Params 2, eflags: 0x4
// Checksum 0x37b8b6eb, Offset: 0xa20
// Size: 0x6c
function private function_dbfbc9be(var_d4676dbf, n_wave) {
    if (isdefined(n_wave)) {
        return var_d4676dbf flag::get("wave" + n_wave + "_cleared");
    }
    return var_d4676dbf flag::get("cleared");
}

// Namespace namespace_153814c2/namespace_d4676dbf
// Params 2, eflags: 0x4
// Checksum 0x2bc3e764, Offset: 0xa98
// Size: 0x6c
function private function_1d686448(var_d4676dbf, n_wave) {
    if (isdefined(n_wave)) {
        var_d4676dbf flag::wait_till("wave" + n_wave + "_cleared");
        return;
    }
    var_d4676dbf flag::wait_till("cleared");
}

// Namespace namespace_153814c2/namespace_d4676dbf
// Params 1, eflags: 0x4
// Checksum 0x62d355fa, Offset: 0xb10
// Size: 0x8e
function private function_7a3cc429(var_d4676dbf) {
    var_d4676dbf flag::set("cleared");
    var_d4676dbf.var_3f4de188 = undefined;
    var_d4676dbf.var_47e07f7f = undefined;
    var_d4676dbf.var_ad987d30 = undefined;
    var_d4676dbf.var_3426d573 = undefined;
    var_d4676dbf.wavecount = undefined;
    var_d4676dbf.transitioncount = undefined;
    var_d4676dbf.m_str_team = undefined;
    var_d4676dbf.var_aeada929 = undefined;
}

// Namespace namespace_153814c2/namespace_d4676dbf
// Params 1, eflags: 0x4
// Checksum 0x19c09d6e, Offset: 0xba8
// Size: 0xd8
function private function_c50cb407(var_d4676dbf) {
    var_d4676dbf flag::set("complete");
    for (n_wave = 1; n_wave <= var_d4676dbf.wavecount; n_wave++) {
        var_d4676dbf flag::set("wave" + n_wave + "_complete");
        if (var_d4676dbf.var_3426d573 < n_wave) {
            function_9a621470(var_d4676dbf);
        }
    }
    var_d4676dbf.wavecount = var_d4676dbf.var_3426d573;
}

// Namespace namespace_153814c2/namespace_d4676dbf
// Params 4, eflags: 0x4
// Checksum 0xfd205a57, Offset: 0xc88
// Size: 0x242
function private function_e9cc55ce(s_wave_manager_struct, str_team, str_wavemanager, var_e2932c64) {
    var_47e07f7f = struct::get_script_bundle("wavemanager", isdefined(str_wavemanager) ? str_wavemanager : s_wave_manager_struct.scriptbundlename);
    [[ new class_d4676dbf ]]->__constructor();
    var_d4676dbf = <error pop>;
    var_d4676dbf.m_str_team = util::get_team_mapping(str_team);
    var_d4676dbf.uniqueid = function_44fdb853();
    var_d4676dbf.var_47e07f7f = var_47e07f7f;
    var_d4676dbf.var_3f4de188 = s_wave_manager_struct;
    if (isdefined(s_wave_manager_struct)) {
        if (isdefined(s_wave_manager_struct.target)) {
            var_d4676dbf.var_3331f3db = s_wave_manager_struct.target;
        }
    }
    var_d4676dbf.wavecount = var_47e07f7f.("wavecount");
    if (isdefined(var_e2932c64)) {
        if (!isdefined(var_d4676dbf.var_aeada929)) {
            var_d4676dbf.var_aeada929 = [];
        } else if (!isarray(var_d4676dbf.var_aeada929)) {
            var_d4676dbf.var_aeada929 = array(var_d4676dbf.var_aeada929);
        }
        var_d4676dbf.var_aeada929[var_d4676dbf.var_aeada929.size] = var_e2932c64;
    }
    level.var_38ebfef1[var_d4676dbf.uniqueid] = var_d4676dbf;
    function_2634be7e(var_d4676dbf);
    var_d4676dbf thread function_6e49a661(var_d4676dbf);
    return var_d4676dbf.uniqueid;
}

// Namespace namespace_153814c2/namespace_d4676dbf
// Params 1, eflags: 0x4
// Checksum 0x9ab95fc8, Offset: 0xed8
// Size: 0x672
function private function_6e49a661(var_d4676dbf) {
    while (true) {
        if (var_d4676dbf flag::get("complete")) {
            break;
        }
        if (var_d4676dbf.var_3426d573 > var_d4676dbf.wavecount) {
            break;
        }
        prefix = function_cc96db4e(var_d4676dbf.var_3426d573);
        transitioncount = var_d4676dbf.var_47e07f7f.(prefix + "goToNextWaveCount");
        transitiondelaymin = var_d4676dbf.var_47e07f7f.(prefix + "transitionDelayMin");
        transitiondelaymax = var_d4676dbf.var_47e07f7f.(prefix + "transitionDelayMax");
        var_97439f7d = 0;
        if (isdefined(transitiondelaymin) && isdefined(transitiondelaymax)) {
            if (transitiondelaymin < transitiondelaymax) {
                var_97439f7d = randomfloatrange(transitiondelaymin, transitiondelaymax);
            }
        }
        var_d4676dbf.var_ad987d30 = [];
        for (var_88b2fb05 = 0; var_88b2fb05 < 5; var_88b2fb05++) {
            var_7739b397 = function_9693a3a3(var_d4676dbf, var_88b2fb05);
            if (var_7739b397) {
                [[ new class_e8d4a9f9 ]]->__constructor();
                var_e8d4a9f9 = <error pop>;
                var_e8d4a9f9.var_47e07f7f = var_d4676dbf.var_47e07f7f;
                if (!isdefined(var_d4676dbf.var_ad987d30)) {
                    var_d4676dbf.var_ad987d30 = [];
                } else if (!isarray(var_d4676dbf.var_ad987d30)) {
                    var_d4676dbf.var_ad987d30 = array(var_d4676dbf.var_ad987d30);
                }
                var_d4676dbf.var_ad987d30[var_d4676dbf.var_ad987d30.size] = var_e8d4a9f9;
                thread function_c9e4c57f(var_d4676dbf, var_e8d4a9f9, var_88b2fb05);
            }
        }
        while (true) {
            b_transition_into_next_wave = 1;
            b_wave_complete = 1;
            b_wave_cleared = 1;
            foreach (var_e8d4a9f9 in var_d4676dbf.var_ad987d30) {
                if (!function_369912e4(var_e8d4a9f9)) {
                    b_wave_complete = 0;
                    break;
                }
            }
            if (!isdefined(transitioncount) || transitioncount == 0) {
                foreach (var_e8d4a9f9 in var_d4676dbf.var_ad987d30) {
                    if (!function_593a0163(var_e8d4a9f9)) {
                        b_wave_cleared = 0;
                        b_transition_into_next_wave = 0;
                        break;
                    }
                }
            } else if (b_wave_complete) {
                totalalivecount = 0;
                foreach (var_e8d4a9f9 in var_d4676dbf.var_ad987d30) {
                    var_a5cc9aba = function_1feb954(var_e8d4a9f9);
                    if (isdefined(var_a5cc9aba) && isarray(var_a5cc9aba)) {
                        totalalivecount += var_a5cc9aba.size;
                    }
                }
                if (totalalivecount > transitioncount) {
                    b_wave_cleared = 0;
                    b_transition_into_next_wave = 0;
                }
            } else {
                foreach (var_e8d4a9f9 in var_d4676dbf.var_ad987d30) {
                    if (!function_593a0163(var_e8d4a9f9)) {
                        b_wave_cleared = 0;
                        b_transition_into_next_wave = 0;
                        break;
                    }
                }
            }
            if (b_wave_complete) {
                function_238194b1(var_d4676dbf);
            }
            if (b_wave_cleared) {
                function_9a621470(var_d4676dbf);
            }
            if (b_transition_into_next_wave) {
                break;
            }
            wait 0.1;
        }
        if (isdefined(var_d4676dbf.var_3426d573)) {
            var_d4676dbf.var_3426d573++;
        }
        wait var_97439f7d + 0.1;
    }
}

// Namespace namespace_153814c2/namespace_d4676dbf
// Params 2, eflags: 0x4
// Checksum 0x494be7d9, Offset: 0x1558
// Size: 0x122
function private function_7aef40f4(var_d4676dbf, var_f4b1d057) {
    /#
        assert(isdefined(var_d4676dbf));
    #/
    /#
        assert(isdefined(var_f4b1d057));
    #/
    if (isdefined(var_d4676dbf.var_aeada929)) {
        foreach (spawnfunction in var_d4676dbf.var_aeada929) {
            if (isdefined(spawnfunction.var_43d2bcde)) {
                util::single_thread_argarray(var_f4b1d057, spawnfunction.var_43d2bcde, spawnfunction.params);
            }
        }
    }
}

// Namespace namespace_153814c2/namespace_d4676dbf
// Params 1, eflags: 0x4
// Checksum 0xccbc15e5, Offset: 0x1688
// Size: 0x9c
function private function_148ef5cc(var_e8d4a9f9) {
    /#
        assert(isdefined(var_e8d4a9f9));
    #/
    var_e8d4a9f9 flag::init("activeaitype_" + var_e8d4a9f9.index + "_complete");
    var_e8d4a9f9 flag::init("activeaitype_" + var_e8d4a9f9.index + "_cleared");
}

// Namespace namespace_153814c2/namespace_d4676dbf
// Params 1, eflags: 0x4
// Checksum 0xe1081438, Offset: 0x1730
// Size: 0x44
function private function_252f5b9a(var_e8d4a9f9) {
    var_e8d4a9f9 flag::set("activeaitype_" + var_e8d4a9f9.index + "_complete");
}

// Namespace namespace_153814c2/namespace_d4676dbf
// Params 1, eflags: 0x4
// Checksum 0xee973f78, Offset: 0x1780
// Size: 0x42
function private function_369912e4(var_e8d4a9f9) {
    return var_e8d4a9f9 flag::get("activeaitype_" + var_e8d4a9f9.index + "_complete");
}

// Namespace namespace_153814c2/namespace_d4676dbf
// Params 1, eflags: 0x4
// Checksum 0x3394b9d0, Offset: 0x17d0
// Size: 0x44
function private function_206d8775(var_e8d4a9f9) {
    var_e8d4a9f9 flag::set("activeaitype_" + var_e8d4a9f9.index + "_cleared");
}

// Namespace namespace_153814c2/namespace_d4676dbf
// Params 1, eflags: 0x4
// Checksum 0xb7a592c, Offset: 0x1820
// Size: 0x42
function private function_593a0163(var_e8d4a9f9) {
    return var_e8d4a9f9 flag::get("activeaitype_" + var_e8d4a9f9.index + "_cleared");
}

// Namespace namespace_153814c2/namespace_d4676dbf
// Params 1, eflags: 0x4
// Checksum 0xa0da63e, Offset: 0x1870
// Size: 0x1a
function private function_1feb954(var_e8d4a9f9) {
    return var_e8d4a9f9.a_ai;
}

// Namespace namespace_153814c2/namespace_d4676dbf
// Params 3, eflags: 0x4
// Checksum 0x62ad8cac, Offset: 0x1898
// Size: 0xb8c
function private function_c9e4c57f(var_d4676dbf, var_e8d4a9f9, var_88b2fb05) {
    /#
        assert(function_9693a3a3(var_d4676dbf, var_88b2fb05));
    #/
    var_e8d4a9f9.index = var_88b2fb05;
    function_148ef5cc(var_e8d4a9f9);
    var_e8d4a9f9.variants = function_789e33b9(var_d4676dbf, var_88b2fb05);
    /#
        assert(var_e8d4a9f9.variants.size);
    #/
    var_e8d4a9f9.activecount = function_f82e0258(var_d4676dbf, var_88b2fb05, "activecount");
    var_e8d4a9f9.totalcount = function_f82e0258(var_d4676dbf, var_88b2fb05, "totalcount");
    var_9c8a5d38 = function_f82e0258(var_d4676dbf, var_88b2fb05, "groupsizemin");
    var_f7303bc6 = function_f82e0258(var_d4676dbf, var_88b2fb05, "groupsizemax");
    if (var_9c8a5d38 == var_f7303bc6) {
        var_e8d4a9f9.var_43f783bc = var_9c8a5d38;
    } else {
        var_e8d4a9f9.var_43f783bc = randomintrange(var_9c8a5d38, var_f7303bc6);
    }
    var_e8d4a9f9.var_3024bfe3 = function_f82e0258(var_d4676dbf, var_88b2fb05, "mixedgroup");
    spawndelaymin = function_f82e0258(var_d4676dbf, var_88b2fb05, "spawndelaymin");
    spawndelaymax = function_f82e0258(var_d4676dbf, var_88b2fb05, "spawndelaymax");
    if (spawndelaymin == spawndelaymax) {
        var_e8d4a9f9.spawndelay = spawndelaymin;
    } else {
        var_e8d4a9f9.spawndelay = randomintrange(spawndelaymin, spawndelaymax);
    }
    var_abb0d516 = undefined;
    firsttime = 1;
    while (true) {
        if (var_d4676dbf flag::get("complete")) {
            break;
        }
        if (var_e8d4a9f9.var_9403f8be >= var_e8d4a9f9.totalcount) {
            break;
        }
        var_91cc5e2e = 0;
        availableslots = undefined;
        if (isdefined(var_e8d4a9f9.a_ai)) {
            var_e8d4a9f9.a_ai = array::remove_dead(var_e8d4a9f9.a_ai);
        }
        if (!isdefined(var_e8d4a9f9.a_ai) || var_e8d4a9f9.a_ai.size < var_e8d4a9f9.activecount) {
            availableslots = var_e8d4a9f9.activecount - var_e8d4a9f9.a_ai.size;
            if (availableslots >= var_e8d4a9f9.var_43f783bc) {
                if (!isdefined(var_abb0d516) || gettime() > var_abb0d516 + var_e8d4a9f9.spawndelay) {
                    var_91cc5e2e = 1;
                }
            }
        }
        if (!var_91cc5e2e) {
            wait 0.1;
            continue;
        }
        var_a03e7071 = 0;
        var_43f783bc = var_e8d4a9f9.var_43f783bc;
        /#
            assert(isdefined(availableslots));
        #/
        if (var_43f783bc > availableslots) {
            var_43f783bc = availableslots;
        }
        if (var_e8d4a9f9.var_9403f8be + var_43f783bc > var_e8d4a9f9.totalcount) {
            var_43f783bc = var_e8d4a9f9.totalcount - var_e8d4a9f9.var_9403f8be;
        }
        var_facb1ae3 = undefined;
        lastspawnpoint = undefined;
        while (var_a03e7071 < var_43f783bc) {
            if (var_43f783bc <= 1) {
                lastspawnpoint = undefined;
            }
            if (var_d4676dbf flag::get("complete")) {
                break;
            }
            if (isdefined(var_e8d4a9f9.var_3024bfe3) && var_e8d4a9f9.var_3024bfe3 && isdefined(var_facb1ae3)) {
                var_61de7fc3 = var_facb1ae3;
            } else {
                var_61de7fc3 = randomint(var_e8d4a9f9.variants.size);
                var_61de7fc3 = var_e8d4a9f9.variants[var_61de7fc3];
                var_61de7fc3 = aimappingtableutility::getspawnerforai(var_61de7fc3, var_d4676dbf.m_str_team);
                /#
                    assert(isdefined(var_61de7fc3));
                #/
            }
            spawner::global_spawn_throttle();
            var_3dd72bdf = isassetloaded("aitype", var_61de7fc3);
            if (!isdefined(lastspawnpoint)) {
                if (var_3dd72bdf) {
                    spawnpoint = aispawningutility::function_ce3753e1(var_61de7fc3, var_d4676dbf.m_str_team, var_d4676dbf.var_3331f3db);
                } else {
                    spawnpoint = aispawningutility::function_ce3753e1(var_61de7fc3, var_d4676dbf.m_str_team, var_d4676dbf.var_3331f3db);
                }
                if (!isdefined(spawnpoint)) {
                    if (isdefined(var_d4676dbf.var_3331f3db)) {
                        /#
                            assert("<dev string:x28>" + var_d4676dbf.var_3331f3db + "<dev string:x36>" + getarchetypefromclassname(var_61de7fc3) + "<dev string:x81>" + var_d4676dbf.m_str_team + "<dev string:x8e>");
                        #/
                    } else {
                        /#
                            assert("<dev string:x28>" + var_d4676dbf.var_47e07f7f.name + "<dev string:xab>" + getarchetypefromclassname(var_61de7fc3) + "<dev string:x81>" + var_d4676dbf.m_str_team + "<dev string:x8e>");
                        #/
                    }
                }
            }
            v_origin = isdefined(spawnpoint) ? spawnpoint["origin"] : (0, 0, 0);
            v_angles = isdefined(spawnpoint) ? spawnpoint["angles"] : (0, 0, 0);
            e_spawner = isdefined(spawnpoint) ? spawnpoint["spawner"] : undefined;
            if (var_43f783bc > 1) {
                lastspawnpoint = spawnpoint;
            }
            if (var_3dd72bdf) {
                /#
                    assert(isassetloaded("<dev string:xda>", var_61de7fc3), "<dev string:xe1>" + var_61de7fc3);
                #/
                if (isdefined(e_spawner)) {
                    ai = e_spawner spawnfromspawner(spawnpoint["spawner"].targetname, 1, 0, 1, "actor_" + var_61de7fc3);
                } else {
                    ai = spawnactor(var_61de7fc3, v_origin, v_angles, undefined, 1);
                }
            } else {
                /#
                    assert(isassetloaded("<dev string:x111>", var_61de7fc3), "<dev string:x119>" + var_61de7fc3);
                #/
                if (isdefined(e_spawner)) {
                    ai = e_spawner spawnfromspawner(spawnpoint["spawner"].targetname, 1, 0, 1, var_61de7fc3);
                } else {
                    ai = spawnvehicle(var_61de7fc3, v_origin, v_angles, "xyz");
                }
            }
            if (isdefined(ai)) {
                function_7aef40f4(var_d4676dbf, ai);
                if (!isdefined(var_e8d4a9f9.a_ai)) {
                    var_e8d4a9f9.a_ai = [];
                } else if (!isarray(var_e8d4a9f9.a_ai)) {
                    var_e8d4a9f9.a_ai = array(var_e8d4a9f9.a_ai);
                }
                var_e8d4a9f9.a_ai[var_e8d4a9f9.a_ai.size] = ai;
                var_abb0d516 = gettime();
                var_e8d4a9f9.var_9403f8be++;
                var_a03e7071++;
                ai setteam(var_d4676dbf.m_str_team);
            }
            var_facb1ae3 = var_61de7fc3;
            wait 0.1;
        }
        wait 0.1;
    }
    function_252f5b9a(var_e8d4a9f9);
    while (true) {
        var_e8d4a9f9.a_ai = array::remove_dead(var_e8d4a9f9.a_ai);
        if (!var_e8d4a9f9.a_ai.size) {
            function_206d8775(var_e8d4a9f9);
            return;
        }
        wait 0.1;
    }
}

// Namespace namespace_153814c2/namespace_d4676dbf
// Params 0, eflags: 0x4
// Checksum 0x33fae4c8, Offset: 0x2430
// Size: 0x4c
function private function_44fdb853() {
    if (!isdefined(level.var_5ba1bd40)) {
        level.var_5ba1bd40 = 0;
    }
    id = level.var_5ba1bd40;
    level.var_5ba1bd40++;
    return id;
}

// Namespace namespace_153814c2/namespace_d4676dbf
// Params 1, eflags: 0x4
// Checksum 0x457ccc06, Offset: 0x2488
// Size: 0x20
function private function_cc96db4e(index) {
    return "wave" + index + "_";
}

// Namespace namespace_153814c2/namespace_d4676dbf
// Params 2, eflags: 0x4
// Checksum 0xd31095ed, Offset: 0x24b0
// Size: 0x144
function private function_9693a3a3(var_d4676dbf, var_88b2fb05) {
    /#
        assert(isdefined(var_d4676dbf.var_47e07f7f));
    #/
    prefix = function_cc96db4e(var_d4676dbf.var_3426d573);
    var_ac6a43f9 = var_d4676dbf.var_47e07f7f.(prefix + var_88b2fb05 + "_" + "variant1");
    var_d26cbe62 = var_d4676dbf.var_47e07f7f.(prefix + var_88b2fb05 + "_" + "variant2");
    var_f86f38cb = var_d4676dbf.var_47e07f7f.(prefix + var_88b2fb05 + "_" + "variant3");
    if (isdefined(var_ac6a43f9) || isdefined(var_d26cbe62) || isdefined(var_f86f38cb)) {
        return true;
    }
    return false;
}

// Namespace namespace_153814c2/namespace_d4676dbf
// Params 2, eflags: 0x4
// Checksum 0x3ddb787, Offset: 0x2600
// Size: 0x28e
function private function_789e33b9(var_d4676dbf, var_88b2fb05) {
    /#
        assert(isdefined(var_d4676dbf.var_47e07f7f));
    #/
    /#
        assert(function_9693a3a3(var_d4676dbf, var_88b2fb05));
    #/
    prefix = function_cc96db4e(var_d4676dbf.var_3426d573);
    var_d5d8cbec = function_d5d8cbec(prefix, var_88b2fb05);
    var_ac6a43f9 = var_d4676dbf.var_47e07f7f.(var_d5d8cbec + "variant1");
    var_d26cbe62 = var_d4676dbf.var_47e07f7f.(var_d5d8cbec + "variant2");
    var_f86f38cb = var_d4676dbf.var_47e07f7f.(var_d5d8cbec + "variant3");
    aitypes = [];
    if (isdefined(var_ac6a43f9)) {
        if (!isdefined(aitypes)) {
            aitypes = [];
        } else if (!isarray(aitypes)) {
            aitypes = array(aitypes);
        }
        aitypes[aitypes.size] = var_ac6a43f9;
    }
    if (isdefined(var_d26cbe62)) {
        if (!isdefined(aitypes)) {
            aitypes = [];
        } else if (!isarray(aitypes)) {
            aitypes = array(aitypes);
        }
        aitypes[aitypes.size] = var_d26cbe62;
    }
    if (isdefined(var_f86f38cb)) {
        if (!isdefined(aitypes)) {
            aitypes = [];
        } else if (!isarray(aitypes)) {
            aitypes = array(aitypes);
        }
        aitypes[aitypes.size] = var_f86f38cb;
    }
    return aitypes;
}

// Namespace namespace_153814c2/namespace_d4676dbf
// Params 2, eflags: 0x4
// Checksum 0x60124b2c, Offset: 0x2898
// Size: 0x28
function private function_d5d8cbec(var_cc96db4e, var_88b2fb05) {
    return var_cc96db4e + var_88b2fb05 + "_";
}

// Namespace namespace_153814c2/namespace_d4676dbf
// Params 3, eflags: 0x4
// Checksum 0xf9e191f6, Offset: 0x28c8
// Size: 0x11a
function private function_f82e0258(var_d4676dbf, var_88b2fb05, field) {
    /#
        assert(isdefined(var_d4676dbf.var_47e07f7f));
    #/
    /#
        assert(function_9693a3a3(var_d4676dbf, var_88b2fb05));
    #/
    prefix = function_cc96db4e(var_d4676dbf.var_3426d573);
    var_be40ab7f = function_d5d8cbec(prefix, var_88b2fb05);
    value = var_d4676dbf.var_47e07f7f.(var_be40ab7f + field);
    if (!isdefined(value)) {
        value = 0;
    }
    return int(value);
}

#namespace namespace_7eb9d47a;

// Namespace namespace_7eb9d47a/namespace_d4676dbf
// Params 0, eflags: 0x0
// Checksum 0x2426e601, Offset: 0x29f0
// Size: 0x10
function __constructor() {
    self.params = [];
}

// Namespace namespace_7eb9d47a/namespace_d4676dbf
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x2a08
// Size: 0x4
function __destructor() {
    
}

#namespace namespace_d4676dbf;

// Namespace namespace_d4676dbf/namespace_d4676dbf
// Params 0, eflags: 0x6
// Checksum 0xcceb92c8, Offset: 0x2a18
// Size: 0x86
function private autoexec function_7eb9d47a() {
    classes.var_7eb9d47a[0] = spawnstruct();
    classes.var_7eb9d47a[0].__vtable[1606033458] = &namespace_7eb9d47a::__destructor;
    classes.var_7eb9d47a[0].__vtable[-1690805083] = &namespace_7eb9d47a::__constructor;
}

// Namespace namespace_d4676dbf/namespace_d4676dbf
// Params 1, eflags: 0x0
// Checksum 0xc299d665, Offset: 0x2aa8
// Size: 0x1c
function function_e96ef871(n_id) {
    return level.var_38ebfef1[n_id];
}

// Namespace namespace_d4676dbf/namespace_d4676dbf
// Params 5, eflags: 0x20 variadic
// Checksum 0xf9c6b263, Offset: 0x2ad0
// Size: 0xaa
function function_f5807aa5(s_wave_manager_struct, str_team, str_wavemanager, var_6b452fb6, ...) {
    [[ new class_7eb9d47a ]]->__constructor();
    var_e2932c64 = <error pop>;
    var_e2932c64.var_43d2bcde = var_6b452fb6;
    var_e2932c64.params = vararg;
    if (!isdefined(str_team)) {
        str_team = s_wave_manager_struct.script_team;
    }
    return namespace_153814c2::function_e9cc55ce(s_wave_manager_struct, str_team, str_wavemanager, var_e2932c64);
}

// Namespace namespace_d4676dbf/namespace_d4676dbf
// Params 4, eflags: 0x20 variadic
// Checksum 0x8055e556, Offset: 0x2b88
// Size: 0x8a
function function_5a31eef7(str_wavemanager, str_team, var_6b452fb6, ...) {
    [[ new class_7eb9d47a ]]->__constructor();
    var_e2932c64 = <error pop>;
    var_e2932c64.var_43d2bcde = var_6b452fb6;
    var_e2932c64.params = vararg;
    return namespace_153814c2::function_e9cc55ce(undefined, str_team, str_wavemanager, var_e2932c64);
}

// Namespace namespace_d4676dbf/namespace_d4676dbf
// Params 2, eflags: 0x0
// Checksum 0xd587c3c6, Offset: 0x2c20
// Size: 0x54
function wait_till_complete(n_wave_manager_id, n_wave) {
    var_d4676dbf = function_e96ef871(n_wave_manager_id);
    namespace_153814c2::function_ee1f18d9(var_d4676dbf, n_wave);
}

// Namespace namespace_d4676dbf/namespace_d4676dbf
// Params 2, eflags: 0x0
// Checksum 0x2f48c2dc, Offset: 0x2c80
// Size: 0x54
function wait_till_cleared(n_wave_manager_id, n_wave) {
    var_d4676dbf = function_e96ef871(n_wave_manager_id);
    namespace_153814c2::function_1d686448(var_d4676dbf, n_wave);
}

// Namespace namespace_d4676dbf/namespace_d4676dbf
// Params 2, eflags: 0x0
// Checksum 0x1e6d7ad8, Offset: 0x2ce0
// Size: 0x17a
function function_423eae50(n_wave_manager_id, n_type) {
    var_d4676dbf = function_e96ef871(n_wave_manager_id);
    if (isdefined(n_type)) {
        return var_d4676dbf.var_ad987d30[n_type].a_ai;
    }
    a_ret = [];
    foreach (var_397a099f in var_d4676dbf.var_ad987d30) {
        foreach (ai in var_397a099f.a_ai) {
            a_ret[a_ret.size] = ai;
        }
    }
    return a_ret;
}

// Namespace namespace_d4676dbf/namespace_d4676dbf
// Params 3, eflags: 0x20 variadic
// Checksum 0x8eaa97a0, Offset: 0x2e68
// Size: 0x18a
function add_spawn_function(n_wave_manager_id, var_6b452fb6, ...) {
    /#
        assert(isdefined(n_wave_manager_id));
    #/
    /#
        assert(isdefined(var_6b452fb6));
    #/
    var_d4676dbf = function_e96ef871(n_wave_manager_id);
    [[ new class_7eb9d47a ]]->__constructor();
    var_e2932c64 = <error pop>;
    var_e2932c64.var_43d2bcde = var_6b452fb6;
    var_e2932c64.params = vararg;
    if (isdefined(var_d4676dbf)) {
        if (!isdefined(var_d4676dbf.var_aeada929)) {
            var_d4676dbf.var_aeada929 = [];
        } else if (!isarray(var_d4676dbf.var_aeada929)) {
            var_d4676dbf.var_aeada929 = array(var_d4676dbf.var_aeada929);
        }
        if (!isinarray(var_d4676dbf.var_aeada929, var_e2932c64)) {
            var_d4676dbf.var_aeada929[var_d4676dbf.var_aeada929.size] = var_e2932c64;
        }
    }
}

// Namespace namespace_d4676dbf/namespace_d4676dbf
// Params 2, eflags: 0x0
// Checksum 0x32590964, Offset: 0x3000
// Size: 0x13e
function remove_spawn_function(n_wave_manager_id, var_6b452fb6) {
    /#
        assert(isdefined(n_wave_manager_id));
    #/
    /#
        assert(isdefined(var_6b452fb6));
    #/
    var_d4676dbf = function_e96ef871(n_wave_manager_id);
    if (isdefined(var_d4676dbf)) {
        foreach (var_e2932c64 in var_d4676dbf.var_aeada929) {
            if (var_e2932c64.var_43d2bcde === var_6b452fb6) {
                var_d4676dbf.var_aeada929 = array::exclude(var_d4676dbf.var_aeada929, var_e2932c64);
            }
        }
    }
}

// Namespace namespace_d4676dbf/namespace_d4676dbf
// Params 1, eflags: 0x0
// Checksum 0x12d59e18, Offset: 0x3148
// Size: 0x74
function function_4e8915ab(n_wave_manager_id) {
    /#
        assert(isdefined(n_wave_manager_id));
    #/
    var_d4676dbf = function_e96ef871(n_wave_manager_id);
    if (isdefined(var_d4676dbf)) {
        namespace_153814c2::function_c50cb407(var_d4676dbf);
    }
}

