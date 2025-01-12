#using scripts\core_common\ai\zombie_utility;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\zm_audio;
#using scripts\zm_common\zm_customgame;

#namespace zm_round_spawning;

// Namespace zm_round_spawning
// Method(s) 2 Total 2
class class_de2067fa {

    var var_266bfc5;
    var var_8eb53fb4;
    var var_d12b2891;
    var var_e7dd90e8;
    var var_ee9cde2b;
    var var_f89d354b;

    // Namespace class_de2067fa/zm_round_spawning
    // Params 0, eflags: 0x8
    // Checksum 0x759a96b, Offset: 0x1838
    // Size: 0x4a
    constructor() {
        var_8eb53fb4 = 0;
        var_ee9cde2b = 0;
        var_e7dd90e8 = 0;
        var_d12b2891 = [];
        var_f89d354b = [];
        var_266bfc5 = 0;
    }

}

// Namespace zm_round_spawning
// Method(s) 2 Total 2
class class_c7576f28 {

    var var_5a1e1821;

    // Namespace class_c7576f28/zm_round_spawning
    // Params 0, eflags: 0x8
    // Checksum 0xbf686f62, Offset: 0x1930
    // Size: 0xe
    constructor() {
        var_5a1e1821 = [];
    }

}

// Namespace zm_round_spawning/zm_round_spawning
// Params 0, eflags: 0x2
// Checksum 0xd289986e, Offset: 0x158
// Size: 0x44
function autoexec __init__system__() {
    system::register(#"zm_round_spawning", &__init__, &__main__, undefined);
}

// Namespace zm_round_spawning/zm_round_spawning
// Params 2, eflags: 0x0
// Checksum 0xdb35a8cc, Offset: 0x1a8
// Size: 0xec
function function_2b3870c9(str_archetype, n_round) {
    function_4aae82b(n_round);
    if (!isdefined(level.var_5f72b11b)) {
        level.var_5f72b11b = [];
    } else if (!isarray(level.var_5f72b11b)) {
        level.var_5f72b11b = array(level.var_5f72b11b);
    }
    level.var_5f72b11b[n_round] = str_archetype;
    /#
        level.var_e7256e10[n_round] = str_archetype;
        array::add_sorted(level.var_8d027dc3, n_round, 0);
    #/
}

// Namespace zm_round_spawning/zm_round_spawning
// Params 2, eflags: 0x0
// Checksum 0x7afcea35, Offset: 0x2a0
// Size: 0x21c
function function_c9b9ab96(str_archetype, n_round) {
    assert(isdefined(level.var_27587e21), "<dev string:x30>");
    assert(isdefined(level.var_27587e21[str_archetype]), str_archetype + "<dev string:x87>");
    if (isdefined(n_round) && level.round_number < n_round) {
        if (!isdefined(level.var_8211e404)) {
            level.var_8211e404 = [];
        } else if (!isarray(level.var_8211e404)) {
            level.var_8211e404 = array(level.var_8211e404);
        }
        if (!isdefined(level.var_8211e404[n_round])) {
            level.var_8211e404[n_round] = [];
        } else if (!isarray(level.var_8211e404[n_round])) {
            level.var_8211e404[n_round] = array(level.var_8211e404[n_round]);
        }
        if (!isinarray(level.var_8211e404[n_round], str_archetype)) {
            level.var_8211e404[n_round][level.var_8211e404[n_round].size] = str_archetype;
        }
        /#
            level.var_e7256e10[n_round] = str_archetype;
            array::add_sorted(level.var_8d027dc3, n_round, 0);
        #/
        return;
    }
    function_95adbaf0(str_archetype, level.round_number);
}

// Namespace zm_round_spawning/zm_round_spawning
// Params 2, eflags: 0x0
// Checksum 0x717ef658, Offset: 0x4c8
// Size: 0x17a
function function_1a28bc99(str_archetype, var_4537aa6d) {
    assert(isdefined(level.var_27587e21), "<dev string:x30>");
    assert(isdefined(level.var_27587e21[str_archetype]), str_archetype + "<dev string:x87>");
    assert(!level.var_27587e21[str_archetype].var_266bfc5, "<dev string:xa5>");
    if (!isdefined(level.var_27587e21[str_archetype].var_d12b2891)) {
        level.var_27587e21[str_archetype].var_d12b2891 = [];
    } else if (!isarray(level.var_27587e21[str_archetype].var_d12b2891)) {
        level.var_27587e21[str_archetype].var_d12b2891 = array(level.var_27587e21[str_archetype].var_d12b2891);
    }
    level.var_27587e21[str_archetype].var_d12b2891[level.var_27587e21[str_archetype].var_d12b2891.size] = var_4537aa6d;
}

// Namespace zm_round_spawning/zm_round_spawning
// Params 7, eflags: 0x0
// Checksum 0x881d4f3c, Offset: 0x650
// Size: 0x214
function function_5788a6e7(var_633814d, n_round, func_start, func_end, var_c2be7ded, var_428d67c9, b_ignore_cleanup = 1) {
    function_4aae82b(n_round);
    if (!isdefined(level.var_73f9d658)) {
        level.var_73f9d658 = [];
    } else if (!isarray(level.var_73f9d658)) {
        level.var_73f9d658 = array(level.var_73f9d658);
    }
    var_aed9fdd1 = new class_c7576f28();
    if (isfunctionptr(var_633814d)) {
        var_aed9fdd1.var_b3a0b071 = var_633814d;
    } else {
        if (!isdefined(var_633814d)) {
            var_633814d = [];
        } else if (!isarray(var_633814d)) {
            var_633814d = array(var_633814d);
        }
        var_aed9fdd1.var_5a1e1821 = var_633814d;
    }
    var_aed9fdd1.m_func_start = func_start;
    var_aed9fdd1.m_func_end = func_end;
    var_aed9fdd1.var_3e528579 = var_c2be7ded;
    var_aed9fdd1.var_f1bc011d = var_428d67c9;
    var_aed9fdd1.var_e88d743f = b_ignore_cleanup;
    level.var_73f9d658[n_round] = var_aed9fdd1;
    /#
        level.var_182a13bf[n_round] = var_aed9fdd1;
        array::add_sorted(level.var_b1940f0e, n_round, 0);
    #/
}

// Namespace zm_round_spawning/zm_round_spawning
// Params 1, eflags: 0x0
// Checksum 0x5917936e, Offset: 0x870
// Size: 0xc4
function function_238c1e66(n_round) {
    if (isdefined(level.var_73f9d658) && isdefined(level.var_73f9d658[n_round])) {
        arrayremoveindex(level.var_73f9d658, n_round, 1);
        arrayremovevalue(level.var_7698c308, n_round);
        /#
            arrayremoveindex(level.var_182a13bf, n_round, 1);
            arrayremovevalue(level.var_b1940f0e, n_round);
        #/
        return true;
    }
    return false;
}

// Namespace zm_round_spawning/zm_round_spawning
// Params 1, eflags: 0x0
// Checksum 0x548e21a1, Offset: 0x940
// Size: 0x44
function function_6a9f7d77(n_round = level.round_number) {
    return isdefined(level.var_73f9d658) && isdefined(level.var_73f9d658[n_round]);
}

// Namespace zm_round_spawning/zm_round_spawning
// Params 2, eflags: 0x0
// Checksum 0x504eb21, Offset: 0x990
// Size: 0x20c
function function_b261b00e(n_round, var_9a5d0d46 = 1) {
    if (isdefined(level.var_73f9d658) && isdefined(level.var_73f9d658[n_round])) {
        var_aed9fdd1 = level.var_73f9d658[n_round];
        arrayremoveindex(level.var_73f9d658, n_round, 1);
        arrayremovevalue(level.var_7698c308, n_round);
        /#
            arrayremoveindex(level.var_182a13bf, n_round, 1);
            arrayremovevalue(level.var_b1940f0e, n_round);
        #/
        for (var_fd39da6f = n_round + var_9a5d0d46; isinarray(level.var_7698c308, var_fd39da6f); var_fd39da6f++) {
        }
        level.var_73f9d658[var_fd39da6f] = var_aed9fdd1;
        if (!isdefined(level.var_7698c308)) {
            level.var_7698c308 = [];
        } else if (!isarray(level.var_7698c308)) {
            level.var_7698c308 = array(level.var_7698c308);
        }
        level.var_7698c308[level.var_7698c308.size] = var_fd39da6f;
        /#
            level.var_182a13bf[var_fd39da6f] = var_aed9fdd1;
            array::add_sorted(level.var_b1940f0e, var_fd39da6f, 0);
        #/
        return true;
    }
    return false;
}

// Namespace zm_round_spawning/zm_round_spawning
// Params 1, eflags: 0x0
// Checksum 0x5b4dc8d8, Offset: 0xba8
// Size: 0x166
function function_e7543004(var_ef2fd6a3 = 0) {
    if (isdefined(level.var_73f9d658)) {
        var_2e002577 = undefined;
        foreach (n_round, var_aed9fdd1 in level.var_73f9d658) {
            if (var_ef2fd6a3 && n_round >= level.round_number || n_round > level.round_number) {
                if (!isdefined(var_2e002577) || n_round < var_2e002577) {
                    var_2e002577 = n_round;
                }
            }
        }
        if (isdefined(var_2e002577)) {
            var_aed9fdd1 = level.var_73f9d658[var_2e002577];
            s_special_round = {#n_round:var_2e002577, #archetypes:isdefined(var_aed9fdd1.var_5a1e1821) ? var_aed9fdd1.var_5a1e1821 : var_aed9fdd1.var_b3a0b071};
            return s_special_round;
        }
    }
}

// Namespace zm_round_spawning/zm_round_spawning
// Params 1, eflags: 0x0
// Checksum 0x202e010, Offset: 0xd18
// Size: 0x124
function function_abfc4548(var_14c9c2e3) {
    if (!isdefined(level.var_328041df[#"on_ai_killed"])) {
        level.var_328041df[#"on_ai_killed"] = [];
    } else if (!isarray(level.var_328041df[#"on_ai_killed"])) {
        level.var_328041df[#"on_ai_killed"] = array(level.var_328041df[#"on_ai_killed"]);
    }
    if (!isinarray(level.var_328041df[#"on_ai_killed"], var_14c9c2e3)) {
        level.var_328041df[#"on_ai_killed"][level.var_328041df[#"on_ai_killed"].size] = var_14c9c2e3;
    }
}

// Namespace zm_round_spawning/zm_round_spawning
// Params 1, eflags: 0x0
// Checksum 0x9ad7d253, Offset: 0xe48
// Size: 0x6c
function function_41772c69(var_14c9c2e3) {
    assert(isdefined(level.var_328041df[#"on_ai_killed"]), "<dev string:xd9>");
    arrayremovevalue(level.var_328041df[#"on_ai_killed"], var_14c9c2e3);
}

// Namespace zm_round_spawning/zm_round_spawning
// Params 1, eflags: 0x0
// Checksum 0xfd15ed54, Offset: 0xec0
// Size: 0x124
function function_6f7eee39(var_14c9c2e3) {
    if (!isdefined(level.var_328041df[#"hash_23d7b4f508f08db0"])) {
        level.var_328041df[#"hash_23d7b4f508f08db0"] = [];
    } else if (!isarray(level.var_328041df[#"hash_23d7b4f508f08db0"])) {
        level.var_328041df[#"hash_23d7b4f508f08db0"] = array(level.var_328041df[#"hash_23d7b4f508f08db0"]);
    }
    if (!isinarray(level.var_328041df[#"hash_23d7b4f508f08db0"], var_14c9c2e3)) {
        level.var_328041df[#"hash_23d7b4f508f08db0"][level.var_328041df[#"hash_23d7b4f508f08db0"].size] = var_14c9c2e3;
    }
}

// Namespace zm_round_spawning/zm_round_spawning
// Params 1, eflags: 0x0
// Checksum 0x1248bf43, Offset: 0xff0
// Size: 0x6c
function function_e1f24e0a(var_14c9c2e3) {
    assert(isdefined(level.var_328041df[#"on_ai_killed"]), "<dev string:xd9>");
    arrayremovevalue(level.var_328041df[#"hash_23d7b4f508f08db0"], var_14c9c2e3);
}

// Namespace zm_round_spawning/zm_round_spawning
// Params 2, eflags: 0x0
// Checksum 0xf5446df3, Offset: 0x1068
// Size: 0x142
function function_f1a0928(str_archetype, tag_rotor_fl) {
    assert(isdefined(level.var_27587e21), "<dev string:x30>");
    assert(isdefined(level.var_27587e21[str_archetype]), str_archetype + "<dev string:x87>");
    if (!isdefined(level.var_27587e21[str_archetype].var_f89d354b)) {
        level.var_27587e21[str_archetype].var_f89d354b = [];
    } else if (!isarray(level.var_27587e21[str_archetype].var_f89d354b)) {
        level.var_27587e21[str_archetype].var_f89d354b = array(level.var_27587e21[str_archetype].var_f89d354b);
    }
    level.var_27587e21[str_archetype].var_f89d354b[level.var_27587e21[str_archetype].var_f89d354b.size] = tag_rotor_fl;
}

// Namespace zm_round_spawning/zm_round_spawning
// Params 2, eflags: 0x0
// Checksum 0x7c653f3e, Offset: 0x11b8
// Size: 0x9c
function function_36256795(str_archetype, tag_rotor_fl) {
    assert(isdefined(level.var_27587e21), "<dev string:x30>");
    assert(isdefined(level.var_27587e21[str_archetype]), str_archetype + "<dev string:x87>");
    arrayremovevalue(level.var_27587e21[str_archetype].var_f89d354b, tag_rotor_fl, 0);
}

// Namespace zm_round_spawning/zm_round_spawning
// Params 1, eflags: 0x0
// Checksum 0xb58515a0, Offset: 0x1260
// Size: 0x2a
function function_f172115b(str_archetype) {
    return isinarray(level.var_c45b9dee, str_archetype);
}

// Namespace zm_round_spawning/zm_round_spawning
// Params 1, eflags: 0x0
// Checksum 0x65c67272, Offset: 0x1298
// Size: 0x92
function function_c615ce5b(var_1bf66cd8) {
    if (!isdefined(level.var_7f9d60f3)) {
        level.var_7f9d60f3 = [];
    } else if (!isarray(level.var_7f9d60f3)) {
        level.var_7f9d60f3 = array(level.var_7f9d60f3);
    }
    level.var_7f9d60f3[level.var_7f9d60f3.size] = var_1bf66cd8;
}

// Namespace zm_round_spawning/zm_round_spawning
// Params 1, eflags: 0x0
// Checksum 0x189cc0f3, Offset: 0x1338
// Size: 0x2c
function function_62af52f6(var_1bf66cd8) {
    arrayremovevalue(level.var_7f9d60f3, var_1bf66cd8);
}

// Namespace zm_round_spawning/zm_round_spawning
// Params 1, eflags: 0x0
// Checksum 0x9a1096fa, Offset: 0x1370
// Size: 0x92
function function_1707d338(var_605848bc) {
    if (!isdefined(level.var_e3881d30)) {
        level.var_e3881d30 = [];
    } else if (!isarray(level.var_e3881d30)) {
        level.var_e3881d30 = array(level.var_e3881d30);
    }
    level.var_e3881d30[level.var_e3881d30.size] = var_605848bc;
}

// Namespace zm_round_spawning/zm_round_spawning
// Params 1, eflags: 0x0
// Checksum 0x40784cfa, Offset: 0x1410
// Size: 0x2c
function function_5a8ad6e5(var_605848bc) {
    arrayremovevalue(level.var_e3881d30, var_605848bc);
}

// Namespace zm_round_spawning/zm_round_spawning
// Params 5, eflags: 0x0
// Checksum 0x7b3f886b, Offset: 0x1448
// Size: 0x276
function register_archetype(str_archetype, var_c18f793, func_round_spawn, var_906fb797, var_436ef09c) {
    if (!isdefined(level.var_f4bfb17a)) {
        level.var_f4bfb17a = [];
    } else if (!isarray(level.var_f4bfb17a)) {
        level.var_f4bfb17a = array(level.var_f4bfb17a);
    }
    if (!isdefined(level.var_27587e21)) {
        level.var_27587e21 = [];
    } else if (!isarray(level.var_27587e21)) {
        level.var_27587e21 = array(level.var_27587e21);
    }
    var_a9e7c9fa = new class_de2067fa();
    var_a9e7c9fa.var_97b2346 = str_archetype;
    var_a9e7c9fa.var_2b1448bf = var_c18f793;
    var_a9e7c9fa.var_77000eae = func_round_spawn;
    if (isdefined(var_906fb797)) {
        var_a9e7c9fa.var_c9c64233 = var_906fb797;
    }
    var_436ef09c = function_47e1b8e1(str_archetype, var_436ef09c);
    var_a9e7c9fa.var_e7dd90e8 = var_436ef09c;
    if (!isdefined(level.var_f4bfb17a[var_436ef09c])) {
        level.var_f4bfb17a[var_436ef09c] = [];
    } else if (!isarray(level.var_f4bfb17a[var_436ef09c])) {
        level.var_f4bfb17a[var_436ef09c] = array(level.var_f4bfb17a[var_436ef09c]);
    }
    if (!isinarray(level.var_f4bfb17a[var_436ef09c], var_a9e7c9fa)) {
        level.var_f4bfb17a[var_436ef09c][level.var_f4bfb17a[var_436ef09c].size] = var_a9e7c9fa;
    }
    level.var_27587e21[str_archetype] = var_a9e7c9fa;
}

// Namespace zm_round_spawning/zm_round_spawning
// Params 0, eflags: 0x0
// Checksum 0x46305ba, Offset: 0x16c8
// Size: 0x13c
function __init__() {
    level.var_9b88bc81 = array({#var_f34feb3f:array(0.75, 0.25), #var_d6281bd3:array(2, 2)}, {#var_f34feb3f:array(0.25, 0.25, 0.25, 0.25), #var_d6281bd3:array(1, 1, 1, 1)});
    level.var_c45b9dee = [];
    level.var_328041df = [];
    level.var_d58b2083 = 0;
    level flag::init(#"disable_special_rounds");
}

// Namespace zm_round_spawning/zm_round_spawning
// Params 0, eflags: 0x0
// Checksum 0x5f8347f8, Offset: 0x1810
// Size: 0x1c
function __main__() {
    /#
        level thread devgui();
    #/
}

// Namespace zm_round_spawning/zm_round_spawning
// Params 0, eflags: 0x0
// Checksum 0xc4ec7204, Offset: 0x19e8
// Size: 0x190
function function_77a8d740() {
    if (!isdefined(level.var_f4bfb17a)) {
        return;
    }
    level.var_533f8942 = array(0, 0, 0, 0);
    level.var_1a919772 = [];
    level.var_c45b9dee = [];
    level.var_e7242b29 = undefined;
    /#
        level.var_b78f8b1f = array(0, 0, 0, 0);
        level.var_2c8e098b = array(0, 0, 0, 0);
        level.var_872cefd9 = array([], [], [], []);
        level.var_d77700e9 = [];
        level.var_c051a9c3 = [];
        level.var_faf3afd4 = 0;
        level.var_f1d80b = 0;
    #/
    if (!level function_8f75920e()) {
        var_e14d9cae = function_3dba070e();
        /#
            level.var_bc05d72f = var_e14d9cae;
        #/
        if (var_e14d9cae > 0) {
            function_34b5062e(var_e14d9cae);
        }
    }
    level notify(#"hash_5d3012139f083ccb");
}

// Namespace zm_round_spawning/zm_round_spawning
// Params 0, eflags: 0x0
// Checksum 0xfbe7c5d9, Offset: 0x1b80
// Size: 0x22a
function function_8f55c671() {
    if (!isdefined(level.var_f4bfb17a)) {
        return 0;
    }
    var_6fe94a09 = 0;
    if (level.var_1a919772.size) {
        if (level flag::get(#"infinite_round_spawning") && level.zombie_total <= 0) {
            if (!isdefined(level.var_e7242b29) || level.var_e7242b29 <= 0) {
                function_e99c6fa();
            }
            var_114e5ed8 = level.var_e7242b29;
            level.var_e7242b29--;
        } else {
            var_114e5ed8 = level.zombie_total;
        }
        var_de739773 = 1 + level.var_229b59d - var_114e5ed8;
        if (isdefined(level.var_1a919772[var_de739773])) {
            var_a9e7c9fa = level.var_27587e21[level.var_1a919772[var_de739773]];
            var_6fe94a09 = [[ var_a9e7c9fa.var_77000eae ]]();
            /#
                foreach (var_2686c959 in level.var_872cefd9) {
                    foreach (var_34fe6c39 in var_2686c959) {
                        if (var_34fe6c39.n_spawn == var_de739773) {
                            var_34fe6c39.b_spawned = 1;
                        }
                    }
                }
            #/
        }
    }
    return var_6fe94a09;
}

// Namespace zm_round_spawning/zm_round_spawning
// Params 1, eflags: 0x4
// Checksum 0x5b4ed7eb, Offset: 0x1db8
// Size: 0x246
function private function_8851c394(str_archetype) {
    if (!isdefined(level.var_c45b9dee)) {
        level.var_c45b9dee = [];
    } else if (!isarray(level.var_c45b9dee)) {
        level.var_c45b9dee = array(level.var_c45b9dee);
    }
    if (!isinarray(level.var_c45b9dee, str_archetype)) {
        level.var_c45b9dee[level.var_c45b9dee.size] = str_archetype;
    }
    var_a6de5b6a = randomintrangeinclusive(6, int(min(10, level.zombie_total)));
    level.var_1a919772[var_a6de5b6a] = str_archetype;
    /#
        var_34fe6c39 = {#str_archetype:str_archetype, #n_spawn:var_a6de5b6a, #b_spawned:0};
        if (!isdefined(level.var_872cefd9[0])) {
            level.var_872cefd9[0] = [];
        } else if (!isarray(level.var_872cefd9[0])) {
            level.var_872cefd9[0] = array(level.var_872cefd9[0]);
        }
        level.var_872cefd9[0][level.var_872cefd9[0].size] = var_34fe6c39;
        if (!isdefined(level.var_d77700e9[str_archetype])) {
            level.var_d77700e9[str_archetype] = 0;
        }
        level.var_d77700e9[str_archetype]++;
    #/
}

// Namespace zm_round_spawning/zm_round_spawning
// Params 0, eflags: 0x4
// Checksum 0xf75dc0ca, Offset: 0x2008
// Size: 0x16e
function private function_8f75920e() {
    var_f4cdb407 = 0;
    if (isdefined(level.var_5f72b11b)) {
        var_ea61c7c2 = getarraykeys(level.var_5f72b11b);
        foreach (var_9fc712f3 in var_ea61c7c2) {
            if (var_9fc712f3 <= level.round_number) {
                str_archetype = level.var_5f72b11b[var_9fc712f3];
                function_95adbaf0(str_archetype, var_9fc712f3);
                arrayremoveindex(level.var_5f72b11b, var_9fc712f3, 1);
                if (var_9fc712f3 == level.round_number) {
                    var_f4cdb407 = 1;
                    /#
                        level.var_faf3afd4 = 1;
                    #/
                    function_8851c394(str_archetype);
                }
            }
        }
        if (!level.var_5f72b11b.size) {
            level.var_5f72b11b = undefined;
        }
    }
    return var_f4cdb407;
}

// Namespace zm_round_spawning/zm_round_spawning
// Params 0, eflags: 0x4
// Checksum 0x9bc2b02c, Offset: 0x2180
// Size: 0x15a
function private function_508f0349() {
    if (isdefined(level.var_8211e404)) {
        foreach (n_round in getarraykeys(level.var_8211e404)) {
            if (n_round <= level.round_number) {
                foreach (str_archetype in level.var_8211e404[n_round]) {
                    function_95adbaf0(str_archetype, n_round);
                }
                arrayremoveindex(level.var_8211e404, n_round, 1);
            }
        }
        if (!level.var_8211e404.size) {
            level.var_8211e404 = undefined;
        }
    }
}

// Namespace zm_round_spawning/zm_round_spawning
// Params 2, eflags: 0x4
// Checksum 0x1d9b0e42, Offset: 0x22e8
// Size: 0xb2
function private function_95adbaf0(str_archetype, n_round) {
    foreach (var_4537aa6d in level.var_27587e21[str_archetype].var_d12b2891) {
        level thread [[ var_4537aa6d ]](n_round);
    }
    level.var_27587e21[str_archetype].var_266bfc5 = 1;
}

// Namespace zm_round_spawning/zm_round_spawning
// Params 0, eflags: 0x0
// Checksum 0xb0d10e89, Offset: 0x23a8
// Size: 0x154
function function_6f26880f() {
    level function_508f0349();
    if (isdefined(level.var_73f9d658) && isdefined(level.var_73f9d658[level.round_number])) {
        if (level flag::get(#"disable_special_rounds")) {
            arrayremoveindex(level.var_73f9d658, level.round_number, 1);
            /#
                level.var_182a13bf[level.round_number].b_skipped = 1;
            #/
            return false;
        }
        if (zm_custom::function_7b20008e(level.var_73f9d658[level.round_number].var_5a1e1821)) {
            if (isdefined(level.var_73f9d658[level.round_number].m_func_end)) {
                level [[ level.var_73f9d658[level.round_number].m_func_end ]](0);
                return false;
            }
        }
        level function_fe0fbec6();
        return true;
    }
    return false;
}

// Namespace zm_round_spawning/zm_round_spawning
// Params 0, eflags: 0x4
// Checksum 0xb3f51e04, Offset: 0x2508
// Size: 0x11c
function private function_fe0fbec6() {
    level flag::set("special_round");
    level.var_c45b9dee = [];
    var_aed9fdd1 = level.var_73f9d658[level.round_number];
    var_aed9fdd1.var_ca042ea8 = level.round_wait_func;
    level.round_wait_func = &function_a12c4645;
    level.zombie_total = level [[ var_aed9fdd1.var_3e528579 ]]();
    level.var_635a6446 = level.zombie_total;
    level.var_2941c97b = 0;
    level callback::on_ai_killed(&function_d9d63a08);
    level notify(#"zombie_total_set");
    /#
        level.var_f1d80b = 1;
    #/
    level thread function_114672eb(var_aed9fdd1);
}

// Namespace zm_round_spawning/zm_round_spawning
// Params 1, eflags: 0x4
// Checksum 0x58ea95f6, Offset: 0x2630
// Size: 0x9c
function private function_114672eb(var_aed9fdd1) {
    level [[ var_aed9fdd1.m_func_start ]]();
    wait 1;
    level zm_audio::function_709246c9("roundstart", "special", undefined, 1);
    wait 2;
    var_1569ac92 = level function_b6816710(var_aed9fdd1);
    level thread function_466fc6c9(var_aed9fdd1, var_1569ac92);
}

// Namespace zm_round_spawning/zm_round_spawning
// Params 1, eflags: 0x4
// Checksum 0x541df1c9, Offset: 0x26d8
// Size: 0x2dc
function private function_b6816710(var_aed9fdd1) {
    level endon(#"intermission", #"end_of_round", #"restart_round", #"kill_round");
    while (true) {
        var_6117c0c3 = zombie_utility::get_current_zombie_count();
        if (var_6117c0c3 >= level.zombie_ai_limit) {
            wait 0.25;
            continue;
        }
        level flag::wait_till("spawn_zombies");
        if (isdefined(var_aed9fdd1.var_b3a0b071)) {
            str_archetype = level [[ var_aed9fdd1.var_b3a0b071 ]]();
        } else if (var_aed9fdd1.var_5a1e1821.size == 1) {
            str_archetype = var_aed9fdd1.var_5a1e1821[0];
        } else {
            str_archetype = array::random(var_aed9fdd1.var_5a1e1821);
        }
        if (!isdefined(level.var_c45b9dee)) {
            level.var_c45b9dee = [];
        } else if (!isarray(level.var_c45b9dee)) {
            level.var_c45b9dee = array(level.var_c45b9dee);
        }
        if (!isinarray(level.var_c45b9dee, str_archetype)) {
            level.var_c45b9dee[level.var_c45b9dee.size] = str_archetype;
        }
        var_a9e7c9fa = level.var_27587e21[str_archetype];
        assert(isdefined(var_a9e7c9fa.var_c9c64233), "<dev string:x126>" + str_archetype);
        if (level.zombie_total > 0) {
            ai = [[ var_a9e7c9fa.var_c9c64233 ]]();
        }
        if (isdefined(ai)) {
            ai.b_ignore_cleanup = var_aed9fdd1.var_e88d743f;
            ai.var_64d09bee = 1;
            level.zombie_total--;
        }
        ai = undefined;
        if (level.zombie_total <= 0 && zombie_utility::get_current_zombie_count() <= 0) {
            return 1;
        }
        level [[ var_aed9fdd1.var_f1bc011d ]]();
    }
}

// Namespace zm_round_spawning/zm_round_spawning
// Params 2, eflags: 0x0
// Checksum 0x397de15a, Offset: 0x29c0
// Size: 0xca
function function_466fc6c9(var_aed9fdd1, var_1569ac92 = 0) {
    level.round_wait_func = var_aed9fdd1.var_ca042ea8;
    level [[ var_aed9fdd1.m_func_end ]](var_1569ac92);
    level callback::remove_on_ai_killed(&function_d9d63a08);
    arrayremovevalue(level.var_73f9d658, var_aed9fdd1, 1);
    level flag::clear("special_round");
    level.var_635a6446 = undefined;
    level.var_2941c97b = undefined;
}

// Namespace zm_round_spawning/zm_round_spawning
// Params 0, eflags: 0x0
// Checksum 0xdacd06bf, Offset: 0x2a98
// Size: 0x24
function function_a12c4645() {
    level flag::wait_till_clear("special_round");
}

// Namespace zm_round_spawning/zm_round_spawning
// Params 1, eflags: 0x0
// Checksum 0xde51b22e, Offset: 0x2ac8
// Size: 0x22e
function function_d9d63a08(s_params) {
    if (isdefined(self.var_4470ae57) && self.var_4470ae57) {
        return;
    }
    if (!(isdefined(self.var_64d09bee) && self.var_64d09bee)) {
        return;
    }
    if (isdefined(self.var_3059fa07) && self.var_3059fa07 && (!isdefined(s_params.eattacker) || s_params.eattacker.classname == "worldspawn")) {
        return;
    }
    level.var_2941c97b++;
    assert(level flag::get("<dev string:x152>"), "<dev string:x160>");
    if (isdefined(level.var_328041df[#"on_ai_killed"])) {
        foreach (var_14c9c2e3 in level.var_328041df[#"on_ai_killed"]) {
            self thread [[ var_14c9c2e3 ]](s_params);
        }
    }
    if (isdefined(level.var_328041df[#"hash_23d7b4f508f08db0"]) && level.var_2941c97b == level.var_635a6446) {
        foreach (var_14c9c2e3 in level.var_328041df[#"hash_23d7b4f508f08db0"]) {
            self thread [[ var_14c9c2e3 ]](s_params);
        }
    }
}

// Namespace zm_round_spawning/zm_round_spawning
// Params 0, eflags: 0x4
// Checksum 0xd3d72f2e, Offset: 0x2d00
// Size: 0x212
function private function_e99c6fa() {
    level.var_e7242b29 = level.var_229b59d;
    var_4c4e748e = array::randomize(getarraykeys(level.var_1a919772));
    var_4658f42d = [];
    foreach (i, var_d052d16b in getarraykeys(level.var_1a919772)) {
        var_47ae10be = var_4c4e748e[i];
        var_f8827923 = level.var_1a919772[var_d052d16b];
        var_4658f42d[var_47ae10be] = var_f8827923;
        /#
            foreach (var_77592039 in level.var_872cefd9) {
                foreach (var_234e4626 in var_77592039) {
                    if (var_234e4626.n_spawn == var_47ae10be) {
                        var_234e4626.str_archetype = var_f8827923;
                        var_234e4626.b_spawned = 0;
                    }
                }
            }
        #/
    }
    level.var_1a919772 = var_4658f42d;
}

// Namespace zm_round_spawning/zm_round_spawning
// Params 0, eflags: 0x4
// Checksum 0xabf80d42, Offset: 0x2f20
// Size: 0x26a
function private function_3dba070e() {
    n_points = function_b2d94d6d();
    if (isdefined(level.var_7f9d60f3)) {
        foreach (var_b6975af8 in level.var_7f9d60f3) {
            n_points = level [[ var_b6975af8 ]](n_points);
            assert(isdefined(n_points), "<dev string:x1a1>");
        }
    }
    if (n_points == 0) {
        return 0;
    }
    var_bc7e087e = array::random(level.var_9b88bc81);
    var_2160a397 = array::randomize(array(0, 1, 2, 3));
    var_f34feb3f = var_bc7e087e.var_f34feb3f;
    var_d6281bd3 = var_bc7e087e.var_d6281bd3;
    for (i = 0; i < var_f34feb3f.size; i++) {
        var_5bcb2f6c = [];
        for (j = 0; j < var_d6281bd3[i]; j++) {
            if (!isdefined(var_5bcb2f6c)) {
                var_5bcb2f6c = [];
            } else if (!isarray(var_5bcb2f6c)) {
                var_5bcb2f6c = array(var_5bcb2f6c);
            }
            var_5bcb2f6c[var_5bcb2f6c.size] = array::pop(var_2160a397, undefined, 0);
        }
        function_912c9b78(int(n_points * var_f34feb3f[i]), var_5bcb2f6c);
    }
    return n_points;
}

// Namespace zm_round_spawning/zm_round_spawning
// Params 0, eflags: 0x4
// Checksum 0x83c77efc, Offset: 0x3198
// Size: 0xa8
function private function_b2d94d6d() {
    if (level.round_number >= 20) {
        return (level.round_number * level.round_number * 2);
    }
    switch (level.round_number) {
    case 1:
        return 5;
    case 2:
        return 10;
    case 3:
        return 15;
    case 4:
        return 20;
    case 5:
    case 6:
    case 7:
        return 25;
    case 8:
    case 9:
        return 50;
    case 10:
    case 11:
        return 100;
    case 12:
    case 13:
    case 14:
        return (150 + 50 * (level.round_number - 12));
    default:
        return (300 + 100 * (level.round_number - 15));
    }
}

// Namespace zm_round_spawning/zm_round_spawning
// Params 2, eflags: 0x4
// Checksum 0x7b005819, Offset: 0x3348
// Size: 0x114
function private function_912c9b78(n_points, var_d6281bd3) {
    for (i = 0; i < var_d6281bd3.size; i++) {
        if (i == var_d6281bd3.size - 1) {
            level.var_533f8942[var_d6281bd3[i]] = n_points;
        } else {
            if (n_points < 5) {
                var_3cc70ca2 = n_points;
            } else {
                var_3cc70ca2 = randomintrangeinclusive(5, n_points - 5);
            }
            level.var_533f8942[var_d6281bd3[i]] = var_3cc70ca2;
            n_points -= var_3cc70ca2;
        }
        /#
            level.var_b78f8b1f[var_d6281bd3[i]] = level.var_533f8942[var_d6281bd3[i]];
        #/
    }
}

// Namespace zm_round_spawning/zm_round_spawning
// Params 1, eflags: 0x4
// Checksum 0xaa34cce7, Offset: 0x3468
// Size: 0xcc2
function private function_34b5062e(var_e14d9cae) {
    var_1c748f5e = [];
    foreach (var_a9e7c9fa in level.var_27587e21) {
        function_c9f8255a(var_a9e7c9fa, var_e14d9cae);
        var_a9e7c9fa.var_ee9cde2b = 0;
        var_1c748f5e[var_a9e7c9fa.var_97b2346] = 0;
    }
    var_f82082ff = array::sort_by_value(getarraykeys(level.var_f4bfb17a));
    foreach (var_436ef09c in var_f82082ff) {
        var_d09eeb4a = 0;
        while (var_436ef09c <= var_e14d9cae && !var_d09eeb4a) {
            var_d09eeb4a = 1;
            foreach (var_a9e7c9fa in level.var_f4bfb17a[var_436ef09c]) {
                if (var_1c748f5e[var_a9e7c9fa.var_97b2346] == var_a9e7c9fa.var_8eb53fb4) {
                    continue;
                }
                if (var_436ef09c > var_e14d9cae) {
                    break;
                }
                var_1c748f5e[var_a9e7c9fa.var_97b2346]++;
                if (!isdefined(level.var_c45b9dee)) {
                    level.var_c45b9dee = [];
                } else if (!isarray(level.var_c45b9dee)) {
                    level.var_c45b9dee = array(level.var_c45b9dee);
                }
                if (!isinarray(level.var_c45b9dee, var_a9e7c9fa.var_97b2346)) {
                    level.var_c45b9dee[level.var_c45b9dee.size] = var_a9e7c9fa.var_97b2346;
                }
                var_e14d9cae -= var_436ef09c;
                var_d09eeb4a = 0;
            }
            function_b9d02103();
        }
    }
    if (isdefined(level.var_e3881d30)) {
        foreach (var_c0beed59 in level.var_e3881d30) {
            var_1c748f5e = level [[ var_c0beed59 ]](var_1c748f5e);
            assert(isdefined(var_1c748f5e), "<dev string:x1e7>");
        }
    }
    var_8cb096b3 = 0;
    foreach (var_a9e7c9fa in level.var_27587e21) {
        var_a9e7c9fa.var_ee9cde2b = var_1c748f5e[var_a9e7c9fa.var_97b2346];
        var_8cb096b3 += var_1c748f5e[var_a9e7c9fa.var_97b2346];
    }
    var_2e6632d3 = 5 + level.var_ad508a8d;
    var_fd23310b = level.zombie_total - var_2e6632d3 - 10;
    if (var_fd23310b < var_8cb096b3) {
        var_fd23310b = var_8cb096b3;
        var_2e6632d3 = 0;
    }
    var_1c5deabc = int(floor(var_fd23310b / 4));
    var_d810bf1c = array(var_1c5deabc, var_1c5deabc, var_1c5deabc, var_1c5deabc);
    for (i = 0; i < var_fd23310b % 4; i++) {
        var_d810bf1c[i]++;
    }
    var_445e895e = array([], [], [], []);
    foreach (var_436ef09c in var_f82082ff) {
        foreach (var_a9e7c9fa in level.var_f4bfb17a[var_436ef09c]) {
            if (var_a9e7c9fa.var_ee9cde2b == 0) {
                continue;
            }
            var_358c087a = 1;
            var_4fb341ea = 1;
            while (var_358c087a) {
                if (var_4fb341ea) {
                    var_d6281bd3 = array::randomize(getarraykeys(level.var_533f8942));
                    var_4fb341ea = 0;
                    foreach (var_bdaa2398 in var_d6281bd3) {
                        if (level.var_533f8942[var_bdaa2398] >= var_436ef09c && var_445e895e[var_bdaa2398].size < var_d810bf1c[var_bdaa2398]) {
                            if (!isdefined(var_445e895e[var_bdaa2398])) {
                                var_445e895e[var_bdaa2398] = [];
                            } else if (!isarray(var_445e895e[var_bdaa2398])) {
                                var_445e895e[var_bdaa2398] = array(var_445e895e[var_bdaa2398]);
                            }
                            var_445e895e[var_bdaa2398][var_445e895e[var_bdaa2398].size] = var_a9e7c9fa.var_97b2346;
                            level.var_533f8942[var_bdaa2398] = level.var_533f8942[var_bdaa2398] - var_436ef09c;
                            /#
                                level.var_2c8e098b[var_bdaa2398] = level.var_2c8e098b[var_bdaa2398] + var_436ef09c;
                            #/
                            var_a9e7c9fa.var_ee9cde2b--;
                            var_4fb341ea = 1;
                        }
                        if (var_a9e7c9fa.var_ee9cde2b == 0) {
                            var_358c087a = 0;
                            break;
                        }
                    }
                    function_b9d02103();
                    continue;
                }
                while (true) {
                    var_bdaa2398 = function_a966c478(var_445e895e, var_d810bf1c);
                    if (!isdefined(var_bdaa2398)) {
                        var_358c087a = 0;
                        break;
                    }
                    if (!isdefined(var_445e895e[var_bdaa2398])) {
                        var_445e895e[var_bdaa2398] = [];
                    } else if (!isarray(var_445e895e[var_bdaa2398])) {
                        var_445e895e[var_bdaa2398] = array(var_445e895e[var_bdaa2398]);
                    }
                    var_445e895e[var_bdaa2398][var_445e895e[var_bdaa2398].size] = var_a9e7c9fa.var_97b2346;
                    level.var_533f8942[var_bdaa2398] = level.var_533f8942[var_bdaa2398] - var_436ef09c;
                    /#
                        level.var_2c8e098b[var_bdaa2398] = level.var_2c8e098b[var_bdaa2398] + var_436ef09c;
                    #/
                    var_a9e7c9fa.var_ee9cde2b--;
                    function_b9d02103();
                    if (var_a9e7c9fa.var_ee9cde2b == 0) {
                        var_358c087a = 0;
                        break;
                    }
                }
            }
            waitframe(1);
        }
    }
    foreach (n_index, var_e42af3e in var_445e895e) {
        var_445e895e[n_index] = array::randomize(var_e42af3e);
    }
    for (i = 0; i < 4; i++) {
        n_spawn = var_2e6632d3 + var_d810bf1c[i] * i;
        if (isdefined(var_445e895e[i]) && var_445e895e[i].size) {
            var_54a1f39 = int(floor(var_d810bf1c[i] / var_445e895e[i].size));
            foreach (str_archetype in var_445e895e[i]) {
                n_spawn += var_54a1f39;
                level.var_1a919772[n_spawn] = str_archetype;
                /#
                    var_34fe6c39 = {#str_archetype:str_archetype, #n_spawn:n_spawn, #b_spawned:0};
                    if (!isdefined(level.var_872cefd9[i])) {
                        level.var_872cefd9[i] = [];
                    } else if (!isarray(level.var_872cefd9[i])) {
                        level.var_872cefd9[i] = array(level.var_872cefd9[i]);
                    }
                    level.var_872cefd9[i][level.var_872cefd9[i].size] = var_34fe6c39;
                    if (!isdefined(level.var_d77700e9[str_archetype])) {
                        level.var_d77700e9[str_archetype] = 0;
                    }
                    level.var_d77700e9[str_archetype]++;
                #/
                function_b9d02103();
            }
        }
    }
}

// Namespace zm_round_spawning/zm_round_spawning
// Params 2, eflags: 0x4
// Checksum 0xb95f0ce5, Offset: 0x4138
// Size: 0x18e
function private function_c9f8255a(var_a9e7c9fa, var_e14d9cae) {
    /#
        level.var_c051a9c3[var_a9e7c9fa.var_97b2346] = 0;
    #/
    if (var_a9e7c9fa.var_266bfc5) {
        var_52180a60 = [[ var_a9e7c9fa.var_2b1448bf ]](var_e14d9cae);
        if (var_a9e7c9fa.var_f89d354b.size) {
            /#
                level.var_c051a9c3[var_a9e7c9fa.var_97b2346] = 1;
            #/
            var_57eab021 = undefined;
            foreach (tag_rotor_fl in var_a9e7c9fa.var_f89d354b) {
                var_66e27c45 = [[ tag_rotor_fl ]](var_52180a60);
                if (!isdefined(var_57eab021) || var_66e27c45 < var_57eab021) {
                    var_57eab021 = var_66e27c45;
                }
            }
            var_52180a60 = var_57eab021;
        }
        var_52180a60 = function_2351b739(var_52180a60, var_a9e7c9fa.var_97b2346);
        var_a9e7c9fa.var_8eb53fb4 = var_52180a60;
        return;
    }
    var_a9e7c9fa.var_8eb53fb4 = 0;
}

// Namespace zm_round_spawning/zm_round_spawning
// Params 2, eflags: 0x4
// Checksum 0x478465c0, Offset: 0x42d0
// Size: 0xe6
function private function_a966c478(var_445e895e, var_d810bf1c) {
    var_64d31777 = undefined;
    var_4f096b9 = -1;
    for (i = 0; i < 4; i++) {
        if (var_445e895e[i].size < var_d810bf1c[i]) {
            if (level.var_533f8942[i] > var_4f096b9) {
                var_64d31777 = i;
                var_4f096b9 = level.var_533f8942[i];
                continue;
            }
            if (level.var_533f8942[i] == var_4f096b9 && math::cointoss()) {
                var_64d31777 = i;
            }
        }
    }
    return var_64d31777;
}

// Namespace zm_round_spawning/zm_round_spawning
// Params 2, eflags: 0x4
// Checksum 0x59848b4a, Offset: 0x43c0
// Size: 0x2cc
function private function_2351b739(var_52180a60, str_archetype) {
    if (isinarray(array(hash("blight_father")), hash(str_archetype))) {
        var_52180a60 *= isdefined(level.var_7a71e248) ? level.var_7a71e248 : 1;
    } else if (isinarray(array(hash("stoker"), hash("brutus"), hash("gladiator"), hash("gladiator_marauder"), hash("gladiator_destroyer")), hash(str_archetype))) {
        var_52180a60 *= isdefined(level.var_2e9e915f) ? level.var_2e9e915f : 1;
    } else if (hash(str_archetype) == "catalyst") {
        var_52180a60 *= isdefined(level.var_269a9bf7) ? level.var_269a9bf7 : 1;
    } else if (isinarray(array(hash("bat"), hash("dog"), hash("nosferatu"), hash("tiger")), hash(str_archetype))) {
        var_52180a60 *= isdefined(level.var_92839a29) ? level.var_92839a29 : 1;
    }
    if (math::cointoss()) {
        return floor(var_52180a60);
    }
    return ceil(var_52180a60);
}

// Namespace zm_round_spawning/zm_round_spawning
// Params 2, eflags: 0x4
// Checksum 0x537cfb31, Offset: 0x4698
// Size: 0x28a
function private function_47e1b8e1(str_archetype, var_436ef09c) {
    if (isinarray(array(hash("blight_father")), hash(str_archetype))) {
        var_436ef09c /= isdefined(level.var_7a71e248) ? level.var_7a71e248 : 1;
    } else if (isinarray(array(hash("stoker"), hash("brutus"), hash("gladiator"), hash("gladiator_marauder"), hash("gladiator_destroyer")), hash(str_archetype))) {
        var_436ef09c /= isdefined(level.var_2e9e915f) ? level.var_2e9e915f : 1;
    } else if (str_archetype == "catalyst") {
        var_436ef09c /= isdefined(level.var_269a9bf7) ? level.var_269a9bf7 : 1;
    } else if (isinarray(array(hash("bat"), hash("dog"), hash("nosferatu"), hash("tiger")), hash(str_archetype))) {
        var_436ef09c /= isdefined(level.var_92839a29) ? level.var_92839a29 : 1;
    }
    return int(var_436ef09c);
}

// Namespace zm_round_spawning/zm_round_spawning
// Params 0, eflags: 0x4
// Checksum 0xf2fe9d38, Offset: 0x4930
// Size: 0x3e
function private function_b9d02103() {
    level.var_d58b2083++;
    if (level.var_d58b2083 > 20) {
        waitframe(1);
        level.var_d58b2083 = 0;
    }
}

// Namespace zm_round_spawning/zm_round_spawning
// Params 1, eflags: 0x4
// Checksum 0x4b5bed97, Offset: 0x4978
// Size: 0x14a
function private function_4aae82b(n_round) {
    if (!isdefined(level.var_7698c308)) {
        level.var_7698c308 = [];
    } else if (!isarray(level.var_7698c308)) {
        level.var_7698c308 = array(level.var_7698c308);
    }
    if (isinarray(level.var_7698c308, n_round)) {
        assertmsg("<dev string:x233>" + n_round + "<dev string:x267>");
        return;
    }
    if (!isdefined(level.var_7698c308)) {
        level.var_7698c308 = [];
    } else if (!isarray(level.var_7698c308)) {
        level.var_7698c308 = array(level.var_7698c308);
    }
    level.var_7698c308[level.var_7698c308.size] = n_round;
}

/#

    // Namespace zm_round_spawning/zm_round_spawning
    // Params 0, eflags: 0x4
    // Checksum 0xbc930b30, Offset: 0x4ad0
    // Size: 0x448
    function private devgui() {
        if (!isdefined(level.var_bc05d72f)) {
            level.var_bc05d72f = 0;
        }
        if (!isdefined(level.var_e7256e10)) {
            level.var_e7256e10 = [];
        }
        if (!isdefined(level.var_8d027dc3)) {
            level.var_8d027dc3 = [];
        }
        if (!isdefined(level.var_182a13bf)) {
            level.var_182a13bf = [];
        }
        if (!isdefined(level.var_b1940f0e)) {
            level.var_b1940f0e = [];
        }
        if (!isdefined(level.var_d77700e9)) {
            level.var_d77700e9 = [];
        }
        if (!isdefined(level.var_c051a9c3)) {
            level.var_c051a9c3 = [];
        }
        if (!isdefined(level.var_b78f8b1f)) {
            level.var_b78f8b1f = array(0, 0, 0, 0);
        }
        if (!isdefined(level.var_2c8e098b)) {
            level.var_2c8e098b = array(0, 0, 0, 0);
        }
        if (!isdefined(level.var_872cefd9)) {
            level.var_872cefd9 = array([], [], [], []);
        }
        level.var_741e3d7e = 0;
        level.var_332e4647 = 0;
        level.var_ce30876a = 0;
        level.var_fc56ed3e = 0;
        level.var_a58470a8 = 0;
        level.var_8470e12f = 0;
        level thread function_5117f24e();
        adddebugcommand("<dev string:x28a>");
        adddebugcommand("<dev string:x2e3>");
        adddebugcommand("<dev string:x346>");
        adddebugcommand("<dev string:x3ad>");
        adddebugcommand("<dev string:x40e>");
        adddebugcommand("<dev string:x47d>");
        adddebugcommand("<dev string:x4e4>");
        while (true) {
            waitframe(1);
            str_command = getdvarstring(#"hash_5996494c7608f933", "<dev string:x53c>");
            switch (str_command) {
            case #"summary":
                level.var_741e3d7e = !level.var_741e3d7e;
                break;
            case #"intro_rounds":
                level.var_332e4647 = !level.var_332e4647;
                break;
            case #"special_rounds":
                level.var_ce30876a = !level.var_ce30876a;
                break;
            case #"hash_4c928e124b9db907":
                level.var_8470e12f = !level.var_8470e12f;
                break;
            case #"point_distribution":
                level.var_fc56ed3e = !level.var_fc56ed3e;
                break;
            case #"ai_composition":
                level.var_a58470a8 = !level.var_a58470a8;
                break;
            case #"all_off":
                level.var_741e3d7e = 0;
                level.var_332e4647 = 0;
                level.var_ce30876a = 0;
                level.var_8470e12f = 0;
                level.var_fc56ed3e = 0;
                level.var_a58470a8 = 0;
                break;
            default:
                break;
            }
            setdvar(#"hash_5996494c7608f933", "<dev string:x53c>");
        }
    }

    // Namespace zm_round_spawning/zm_round_spawning
    // Params 0, eflags: 0x4
    // Checksum 0x8d89f5c, Offset: 0x4f20
    // Size: 0x1802
    function private function_5117f24e() {
        while (true) {
            var_81e9aa1a = 120;
            if (level.var_741e3d7e) {
                debug2dtext((510, var_81e9aa1a, 0), "<dev string:x53d>", (0, 1, 0), 1, (0, 0, 0), 0.8, 1.5, 2);
                var_81e9aa1a += 33;
                debug2dtext((510, var_81e9aa1a, 0), "<dev string:x555>", (0, 1, 0), 1, (0, 0, 0), 0.8, 1, 2);
                var_81e9aa1a += 22;
                debug2dtext((510, var_81e9aa1a, 0), "<dev string:x57d>" + level.var_229b59d + "<dev string:x592>", (0, 1, 0), 1, (0, 0, 0), 0.8, 1, 2);
                var_81e9aa1a += 22;
                debug2dtext((510, var_81e9aa1a, 0), "<dev string:x594>" + level.var_bc05d72f + "<dev string:x592>", (0, 1, 0), 1, (0, 0, 0), 0.8, 1, 2);
                var_81e9aa1a += 22;
                debug2dtext((510, var_81e9aa1a, 0), "<dev string:x5a3>", (0, 1, 0), 1, (0, 0, 0), 0.8, 1, 2);
                var_81e9aa1a += 22;
                foreach (str_archetype in level.var_c45b9dee) {
                    str_text = "<dev string:x5b0>" + str_archetype;
                    if (isdefined(level.var_d77700e9[str_archetype])) {
                        str_text += "<dev string:x5b4>" + level.var_d77700e9[str_archetype];
                    }
                    str_text += "<dev string:x592>";
                    debug2dtext((510, var_81e9aa1a, 0), str_text, (0, 1, 1), 1, (0, 0, 0), 0.8, 0.85, 2);
                    var_81e9aa1a += 18.7;
                }
                var_81e9aa1a += 33;
            }
            if (level.var_332e4647) {
                debug2dtext((510, var_81e9aa1a, 0), "<dev string:x5b7>", (0, 1, 0), 1, (0, 0, 0), 0.8, 1.5, 2);
                var_81e9aa1a += 33;
                debug2dtext((510, var_81e9aa1a, 0), "<dev string:x555>", (0, 1, 0), 1, (0, 0, 0), 0.8, 1, 2);
                foreach (var_9fc712f3 in level.var_8d027dc3) {
                    str_archetype = level.var_e7256e10[var_9fc712f3];
                    var_81e9aa1a += 22;
                    if (level.var_27587e21[str_archetype].var_266bfc5) {
                        str_color = (0, 1, 1);
                    } else {
                        str_color = (1, 0, 0);
                    }
                    str_text = "<dev string:x5c5>" + var_9fc712f3 + "<dev string:x5b4>" + function_15979fa9(str_archetype) + "<dev string:x592>";
                    debug2dtext((510, var_81e9aa1a, 0), str_text, str_color, 1, (0, 0, 0), 0.8, 1, 2);
                }
                var_81e9aa1a += 33;
            }
            if (level.var_ce30876a) {
                debug2dtext((510, var_81e9aa1a, 0), "<dev string:x5cc>", (0, 1, 0), 1, (0, 0, 0), 0.8, 1.5, 2);
                var_81e9aa1a += 33;
                debug2dtext((510, var_81e9aa1a, 0), "<dev string:x555>", (0, 1, 0), 1, (0, 0, 0), 0.8, 1, 2);
                var_81e9aa1a += 22;
                if (level flag::get(#"disable_special_rounds")) {
                    debug2dtext((510, var_81e9aa1a, 0), "<dev string:x5dc>", (1, 0, 0), 1, (0, 0, 0), 0.8, 1, 2);
                    var_81e9aa1a += 22;
                }
                foreach (n_special_round in level.var_b1940f0e) {
                    var_aed9fdd1 = level.var_182a13bf[n_special_round];
                    str_text = "<dev string:x5c5>" + n_special_round + "<dev string:x5b4>";
                    if (level flag::get(#"disable_special_rounds") || isdefined(var_aed9fdd1.b_skipped) && var_aed9fdd1.b_skipped) {
                        str_color = (1, 0, 0);
                    } else if (level.round_number > n_special_round) {
                        str_color = (0, 1, 1);
                    } else if (level.round_number == n_special_round) {
                        str_color = (1, 0.5, 0);
                        var_5552df1c = "<dev string:x5f5>" + (isdefined(level.var_635a6446) ? level.var_635a6446 : "<dev string:x60d>") + "<dev string:x592>";
                        var_a7543cce = "<dev string:x615>" + level.zombie_total + "<dev string:x592>";
                        var_5ee6a956 = "<dev string:x631>" + zombie_utility::get_current_zombie_count() + "<dev string:x592>";
                    } else {
                        str_color = (1, 0, 0);
                    }
                    if (isdefined(var_aed9fdd1.var_b3a0b071)) {
                        str_text += "<dev string:x644>";
                    } else {
                        foreach (str_archetype in var_aed9fdd1.var_5a1e1821) {
                            str_text += str_archetype + "<dev string:x592>";
                        }
                    }
                    if (isdefined(var_aed9fdd1.b_skipped) && var_aed9fdd1.b_skipped) {
                        str_text += "<dev string:x654>";
                    }
                    debug2dtext((510, var_81e9aa1a, 0), str_text, str_color, 1, (0, 0, 0), 0.8, 1, 2);
                    var_81e9aa1a += 22;
                    if (level.round_number == n_special_round && !level flag::get(#"disable_special_rounds")) {
                        debug2dtext((510, var_81e9aa1a, 0), var_5552df1c, str_color, 1, (0, 0, 0), 0.8, 0.85, 2);
                        var_81e9aa1a += 18.7;
                        debug2dtext((510, var_81e9aa1a, 0), var_a7543cce, str_color, 1, (0, 0, 0), 0.8, 0.85, 2);
                        var_81e9aa1a += 18.7;
                        debug2dtext((510, var_81e9aa1a, 0), var_5ee6a956, str_color, 1, (0, 0, 0), 0.8, 0.85, 2);
                        var_81e9aa1a += 18.7;
                    }
                }
                var_81e9aa1a += 33;
            }
            if (level.var_8470e12f) {
                debug2dtext((510, var_81e9aa1a, 0), "<dev string:x65f>", (0, 1, 0), 1, (0, 0, 0), 0.8, 1.5, 2);
                var_81e9aa1a += 33;
                debug2dtext((510, var_81e9aa1a, 0), "<dev string:x555>", (0, 1, 0), 1, (0, 0, 0), 0.8, 1, 2);
                foreach (var_e4c953bb in level.var_f4bfb17a) {
                    foreach (var_f65532db in var_e4c953bb) {
                        var_81e9aa1a += 22;
                        str_archetype = var_f65532db.var_97b2346;
                        str_text = str_archetype + "<dev string:x5b4>" + var_f65532db.var_8eb53fb4 + "<dev string:x592>";
                        if (var_f65532db.var_266bfc5) {
                            if (level.var_e7256e10[level.round_number] === str_archetype && level.var_faf3afd4) {
                                str_color = (1, 0, 1);
                                str_text = str_archetype + "<dev string:x66c>";
                            } else if (isdefined(level.var_c051a9c3[str_archetype]) && level.var_c051a9c3[str_archetype]) {
                                str_color = (1, 0.5, 0);
                                str_text += "<dev string:x67f>";
                            } else {
                                str_color = (0, 1, 1);
                            }
                        } else {
                            str_color = (1, 0, 0);
                            str_text += "<dev string:x692>";
                        }
                        debug2dtext((510, var_81e9aa1a, 0), str_text, str_color, 1, (0, 0, 0), 0.8, 1, 2);
                    }
                }
                var_81e9aa1a += 33;
            }
            var_81e9aa1a = 120;
            if (level.var_fc56ed3e) {
                debug2dtext((1020, var_81e9aa1a, 0), "<dev string:x6a4>", (0, 1, 0), 1, (0, 0, 0), 0.8, 1.5, 2);
                var_81e9aa1a += 33;
                debug2dtext((1020, var_81e9aa1a, 0), "<dev string:x555>", (0, 1, 0), 1, (0, 0, 0), 0.8, 1, 2);
                var_81e9aa1a += 22;
                if (level.var_faf3afd4) {
                    str_text = "<dev string:x6b8>";
                    debug2dtext((1020, var_81e9aa1a, 0), str_text, (0, 1, 0), 1, (0, 0, 0), 0.8, 1, 2);
                } else if (isdefined(level.var_e7242b29)) {
                    str_text = "<dev string:x6db>" + level.var_bc05d72f + "<dev string:x6f0>";
                    debug2dtext((1020, var_81e9aa1a, 0), str_text, (0, 1, 0), 1, (0, 0, 0), 0.8, 1, 2);
                } else {
                    var_b90c9453 = 0;
                    foreach (n_spent_points in level.var_2c8e098b) {
                        var_b90c9453 += n_spent_points;
                    }
                    str_text = "<dev string:x71d>" + level.var_bc05d72f + "<dev string:x725>" + var_b90c9453 + "<dev string:x736>";
                    debug2dtext((1020, var_81e9aa1a, 0), str_text, (0, 1, 0), 1, (0, 0, 0), 0.8, 1, 2);
                    for (i = 0; i < 4; i++) {
                        var_81e9aa1a += 22;
                        str_text = "<dev string:x745>" + i + 1 + "<dev string:x5b4>" + level.var_b78f8b1f[i] + "<dev string:x74e>" + level.var_2c8e098b[i] + "<dev string:x736>";
                        debug2dtext((1020, var_81e9aa1a, 0), str_text, (0, 1, 0), 1, (0, 0, 0), 0.8, 1, 2);
                    }
                }
                var_81e9aa1a += 33;
            }
            if (level.var_a58470a8) {
                debug2dtext((1020, var_81e9aa1a, 0), "<dev string:x762>", (0, 1, 0), 1, (0, 0, 0), 0.8, 1.5, 2);
                var_81e9aa1a += 33;
                debug2dtext((1020, var_81e9aa1a, 0), "<dev string:x555>", (0, 1, 0), 1, (0, 0, 0), 0.8, 1, 2);
                if (level.var_faf3afd4) {
                    var_81e9aa1a += 22;
                    str_text = "<dev string:x772>";
                    debug2dtext((1020, var_81e9aa1a, 0), str_text, (1, 0, 0), 1, (0, 0, 0), 0.8, 1, 2);
                } else if (level.var_f1d80b) {
                    var_81e9aa1a += 22;
                    str_text = "<dev string:x77f>";
                    debug2dtext((1020, var_81e9aa1a, 0), str_text, (1, 0, 0), 1, (0, 0, 0), 0.8, 1, 2);
                } else if (isdefined(level.var_e7242b29)) {
                    var_81e9aa1a += 22;
                    str_text = "<dev string:x78e>";
                    debug2dtext((1020, var_81e9aa1a, 0), str_text, (1, 0, 0), 1, (0, 0, 0), 0.8, 1, 2);
                }
                var_81e9aa1a += 22;
                debug2dtext((1020, var_81e9aa1a, 0), "<dev string:x57d>" + level.var_229b59d + "<dev string:x592>", (0, 1, 0), 1, (0, 0, 0), 0.8, 1, 2);
                var_81e9aa1a += 22;
                var_8cb096b3 = 0;
                foreach (var_6bcbb5f1 in level.var_d77700e9) {
                    var_8cb096b3 += var_6bcbb5f1;
                }
                debug2dtext((1020, var_81e9aa1a, 0), "<dev string:x7a1>" + var_8cb096b3 + "<dev string:x592>", (0, 1, 0), 1, (0, 0, 0), 0.8, 1, 2);
                var_81e9aa1a += 22;
                foreach (str_archetype in level.var_c45b9dee) {
                    if (isdefined(level.var_d77700e9[str_archetype])) {
                        str_text = "<dev string:x5b0>" + str_archetype + "<dev string:x5b4>" + level.var_d77700e9[str_archetype];
                        debug2dtext((1020, var_81e9aa1a, 0), str_text, (0, 1, 1), 1, (0, 0, 0), 0.8, 0.85, 2);
                        var_81e9aa1a += 18.7;
                    }
                }
                if (level.var_faf3afd4) {
                    debug2dtext((1020, var_81e9aa1a, 0), "<dev string:x7b4>", (0, 1, 0), 1, (0, 0, 0), 0.8, 1, 2);
                    var_81e9aa1a += 22;
                    var_34fe6c39 = level.var_872cefd9[0][0];
                    if (isdefined(var_34fe6c39)) {
                        if (var_34fe6c39.b_spawned) {
                            str_color = (0, 1, 1);
                        } else {
                            str_color = (1, 0, 0);
                        }
                        str_text = "<dev string:x7c2>" + var_34fe6c39.n_spawn + "<dev string:x5b4>" + var_34fe6c39.str_archetype + "<dev string:x592>";
                        debug2dtext((1020, var_81e9aa1a, 0), str_text, str_color, 1, (0, 0, 0), 0.8, 0.85, 2);
                        var_81e9aa1a += 18.7;
                    }
                } else {
                    for (i = 0; i < 4; i++) {
                        str_text = "<dev string:x745>" + i + 1 + "<dev string:x5b4>" + level.var_872cefd9[i].size + "<dev string:x592>";
                        debug2dtext((1020, var_81e9aa1a, 0), str_text, (0, 1, 0), 1, (0, 0, 0), 0.8, 1, 2);
                        var_81e9aa1a += 22;
                        if (level.var_872cefd9[i].size < 10) {
                            foreach (var_34fe6c39 in level.var_872cefd9[i]) {
                                if (var_34fe6c39.b_spawned) {
                                    str_color = (0, 1, 1);
                                } else {
                                    str_color = (1, 0, 0);
                                }
                                str_text = "<dev string:x7c2>" + var_34fe6c39.n_spawn + "<dev string:x5b4>" + var_34fe6c39.str_archetype + "<dev string:x592>";
                                debug2dtext((1020, var_81e9aa1a, 0), str_text, str_color, 1, (0, 0, 0), 0.8, 0.85, 2);
                                var_81e9aa1a += 18.7;
                            }
                            continue;
                        }
                        str_text = "<dev string:x7cc>";
                        debug2dtext((1020, var_81e9aa1a, 0), str_text, (0, 1, 1), 1, (0, 0, 0), 0.8, 0.85, 2);
                        var_81e9aa1a += 18.7;
                    }
                }
                var_81e9aa1a += 18.7;
            }
            waitframe(2);
        }
    }

#/
