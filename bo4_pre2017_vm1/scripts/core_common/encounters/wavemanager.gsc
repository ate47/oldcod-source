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

#namespace wavemanagersys;

// Namespace wavemanagersys
// Method(s) 11 Total 11
class wavemanager {

    var a_spawnfunctionsinfo;
    var activeaitypes;
    var currentwave;

    // Namespace wavemanager/wavemanager
    // Params 0, eflags: 0x0
    // Checksum 0x80f724d1, Offset: 0x3d0
    // Size: 0x4
    function __destructor() {
        
    }

    // Namespace wavemanager/wavemanager
    // Params 1, eflags: 0x0
    // Checksum 0x12d59e18, Offset: 0x3148
    // Size: 0x74
    function stop_wave_manager(n_wave_manager_id) {
        /#
            assert(isdefined(n_wave_manager_id));
        #/
        wavemanager = get_wave_manager(n_wave_manager_id);
        if (isdefined(wavemanager)) {
            wavemanagersys::stopwavemanager(wavemanager);
        }
    }

    // Namespace wavemanager/wavemanager
    // Params 2, eflags: 0x0
    // Checksum 0x32590964, Offset: 0x3000
    // Size: 0x13e
    function remove_spawn_function(n_wave_manager_id, func_spawn_function) {
        /#
            assert(isdefined(n_wave_manager_id));
        #/
        /#
            assert(isdefined(func_spawn_function));
        #/
        wavemanager = get_wave_manager(n_wave_manager_id);
        if (isdefined(wavemanager)) {
            foreach (spawn_function_info in wavemanager.a_spawnfunctionsinfo) {
                if (spawn_function_info.function_ptr === func_spawn_function) {
                    wavemanager.a_spawnfunctionsinfo = array::exclude(wavemanager.a_spawnfunctionsinfo, spawn_function_info);
                }
            }
        }
    }

    // Namespace wavemanager/wavemanager
    // Params 3, eflags: 0x20 variadic
    // Checksum 0x8eaa97a0, Offset: 0x2e68
    // Size: 0x18a
    function add_spawn_function(n_wave_manager_id, func_spawn_function, ...) {
        /#
            assert(isdefined(n_wave_manager_id));
        #/
        /#
            assert(isdefined(func_spawn_function));
        #/
        wavemanager = get_wave_manager(n_wave_manager_id);
        [[ new spawnfunctioninfo ]]->__constructor();
        spawn_function_info = <error pop>;
        spawn_function_info.function_ptr = func_spawn_function;
        spawn_function_info.params = vararg;
        if (isdefined(wavemanager)) {
            if (!isdefined(wavemanager.a_spawnfunctionsinfo)) {
                wavemanager.a_spawnfunctionsinfo = [];
            } else if (!isarray(wavemanager.a_spawnfunctionsinfo)) {
                wavemanager.a_spawnfunctionsinfo = array(wavemanager.a_spawnfunctionsinfo);
            }
            if (!isinarray(wavemanager.a_spawnfunctionsinfo, spawn_function_info)) {
                wavemanager.a_spawnfunctionsinfo[wavemanager.a_spawnfunctionsinfo.size] = spawn_function_info;
            }
        }
    }

    // Namespace wavemanager/wavemanager
    // Params 2, eflags: 0x0
    // Checksum 0x1e6d7ad8, Offset: 0x2ce0
    // Size: 0x17a
    function get_ai(n_wave_manager_id, n_type) {
        wavemanager = get_wave_manager(n_wave_manager_id);
        if (isdefined(n_type)) {
            return wavemanager.activeaitypes[n_type].a_ai;
        }
        a_ret = [];
        foreach (o_type in wavemanager.activeaitypes) {
            foreach (ai in o_type.a_ai) {
                a_ret[a_ret.size] = ai;
            }
        }
        return a_ret;
    }

    // Namespace wavemanager/wavemanager
    // Params 2, eflags: 0x0
    // Checksum 0x2f48c2dc, Offset: 0x2c80
    // Size: 0x54
    function wait_till_cleared(n_wave_manager_id, n_wave) {
        wavemanager = get_wave_manager(n_wave_manager_id);
        wavemanagersys::waittillwavecleared(wavemanager, n_wave);
    }

    // Namespace wavemanager/wavemanager
    // Params 2, eflags: 0x0
    // Checksum 0xd587c3c6, Offset: 0x2c20
    // Size: 0x54
    function wait_till_complete(n_wave_manager_id, n_wave) {
        wavemanager = get_wave_manager(n_wave_manager_id);
        wavemanagersys::waittillwavecomplete(wavemanager, n_wave);
    }

    // Namespace wavemanager/wavemanager
    // Params 4, eflags: 0x20 variadic
    // Checksum 0x8055e556, Offset: 0x2b88
    // Size: 0x8a
    function start_wave_manager_by_name(str_wavemanager, str_team, func_spawn_function, ...) {
        [[ new spawnfunctioninfo ]]->__constructor();
        spawn_function_info = <error pop>;
        spawn_function_info.function_ptr = func_spawn_function;
        spawn_function_info.params = vararg;
        return wavemanagersys::startwavemanagerinternal(undefined, str_team, str_wavemanager, spawn_function_info);
    }

    // Namespace wavemanager/wavemanager
    // Params 5, eflags: 0x20 variadic
    // Checksum 0xf9c6b263, Offset: 0x2ad0
    // Size: 0xaa
    function start_wave_manager(s_wave_manager_struct, str_team, str_wavemanager, func_spawn_function, ...) {
        [[ new spawnfunctioninfo ]]->__constructor();
        spawn_function_info = <error pop>;
        spawn_function_info.function_ptr = func_spawn_function;
        spawn_function_info.params = vararg;
        if (!isdefined(str_team)) {
            str_team = s_wave_manager_struct.script_team;
        }
        return wavemanagersys::startwavemanagerinternal(s_wave_manager_struct, str_team, str_wavemanager, spawn_function_info);
    }

    // Namespace wavemanager/wavemanager
    // Params 1, eflags: 0x0
    // Checksum 0xc299d665, Offset: 0x2aa8
    // Size: 0x1c
    function get_wave_manager(n_id) {
        return level._activewavemanagers[n_id];
    }

    // Namespace wavemanager/wavemanager
    // Params 0, eflags: 0x0
    // Checksum 0x35ae7634, Offset: 0x398
    // Size: 0x2c
    function __constructor() {
        activeaitypes = [];
        currentwave = 1;
        a_spawnfunctionsinfo = [];
    }

}

// Namespace wavemanagersys
// Method(s) 2 Total 2
class activeaitype {

    var a_ai;
    var spawnedcount;
    var variants;

    // Namespace activeaitype/wavemanager
    // Params 0, eflags: 0x0
    // Checksum 0x80f724d1, Offset: 0x650
    // Size: 0x4
    function __destructor() {
        
    }

    // Namespace activeaitype/wavemanager
    // Params 0, eflags: 0x0
    // Checksum 0xafb50d7e, Offset: 0x620
    // Size: 0x28
    function __constructor() {
        variants = [];
        spawnedcount = 0;
        a_ai = [];
    }

}

#namespace wavemanager;

// Namespace wavemanager
// Method(s) 2 Total 2
class spawnfunctioninfo {

    var params;

    // Namespace spawnfunctioninfo/wavemanager
    // Params 0, eflags: 0x0
    // Checksum 0x80f724d1, Offset: 0x2a08
    // Size: 0x4
    function __destructor() {
        
    }

    // Namespace spawnfunctioninfo/wavemanager
    // Params 0, eflags: 0x0
    // Checksum 0x2426e601, Offset: 0x29f0
    // Size: 0x10
    function __constructor() {
        params = [];
    }

}

#namespace wavemanagersys;

// Namespace wavemanagersys/wavemanager
// Params 0, eflags: 0x2
// Checksum 0x3af8f7cb, Offset: 0x358
// Size: 0x34
function autoexec __init__sytem__() {
    system::register("wavemanager", &__init__, undefined, undefined);
}

// Namespace wavemanagersys/wavemanager
// Params 0, eflags: 0x4
// Checksum 0xd1089fa5, Offset: 0x6f0
// Size: 0x14
function private __init__() {
    level._activewavemanagers = [];
}

// Namespace wavemanagersys/wavemanager
// Params 1, eflags: 0x4
// Checksum 0xd05ceeef, Offset: 0x710
// Size: 0xfe
function private wavemanagerinitflags(wavemanager) {
    /#
        assert(isdefined(wavemanager));
    #/
    wavemanager flag::init("complete");
    wavemanager flag::init("cleared");
    for (n_wave = 1; n_wave <= wavemanager.wavecount; n_wave++) {
        wavemanager flag::init("wave" + n_wave + "_complete");
        wavemanager flag::init("wave" + n_wave + "_cleared");
    }
}

// Namespace wavemanagersys/wavemanager
// Params 1, eflags: 0x4
// Checksum 0x3aceee3, Offset: 0x818
// Size: 0x84
function private setwavecomplete(wavemanager) {
    wavemanager flag::set("wave" + wavemanager.currentwave + "_complete");
    if (wavemanager.currentwave == wavemanager.wavecount) {
        wavemanager flag::set("complete");
    }
}

// Namespace wavemanagersys/wavemanager
// Params 2, eflags: 0x4
// Checksum 0x6edf3acc, Offset: 0x8a8
// Size: 0x6c
function private iswavecomplete(wavemanager, n_wave) {
    if (isdefined(n_wave)) {
        return wavemanager flag::get("wave" + n_wave + "_complete");
    }
    return wavemanager flag::get("complete");
}

// Namespace wavemanagersys/wavemanager
// Params 2, eflags: 0x4
// Checksum 0x50a043ed, Offset: 0x920
// Size: 0x6c
function private waittillwavecomplete(wavemanager, n_wave) {
    if (isdefined(n_wave)) {
        wavemanager flag::wait_till("wave" + n_wave + "_complete");
        return;
    }
    wavemanager flag::wait_till("complete");
}

// Namespace wavemanagersys/wavemanager
// Params 1, eflags: 0x4
// Checksum 0xff07b3d, Offset: 0x998
// Size: 0x7c
function private setwavecleared(wavemanager) {
    wavemanager flag::set("wave" + wavemanager.currentwave + "_cleared");
    if (wavemanager.currentwave == wavemanager.wavecount) {
        wavemanagercleared(wavemanager);
    }
}

// Namespace wavemanagersys/wavemanager
// Params 2, eflags: 0x4
// Checksum 0x37b8b6eb, Offset: 0xa20
// Size: 0x6c
function private iswavecleared(wavemanager, n_wave) {
    if (isdefined(n_wave)) {
        return wavemanager flag::get("wave" + n_wave + "_cleared");
    }
    return wavemanager flag::get("cleared");
}

// Namespace wavemanagersys/wavemanager
// Params 2, eflags: 0x4
// Checksum 0x2bc3e764, Offset: 0xa98
// Size: 0x6c
function private waittillwavecleared(wavemanager, n_wave) {
    if (isdefined(n_wave)) {
        wavemanager flag::wait_till("wave" + n_wave + "_cleared");
        return;
    }
    wavemanager flag::wait_till("cleared");
}

// Namespace wavemanagersys/wavemanager
// Params 1, eflags: 0x4
// Checksum 0x62d355fa, Offset: 0xb10
// Size: 0x8e
function private wavemanagercleared(wavemanager) {
    wavemanager flag::set("cleared");
    wavemanager.originalwavestruct = undefined;
    wavemanager.wavemanagerbundle = undefined;
    wavemanager.activeaitypes = undefined;
    wavemanager.currentwave = undefined;
    wavemanager.wavecount = undefined;
    wavemanager.transitioncount = undefined;
    wavemanager.m_str_team = undefined;
    wavemanager.a_spawnfunctionsinfo = undefined;
}

// Namespace wavemanagersys/wavemanager
// Params 1, eflags: 0x4
// Checksum 0x19c09d6e, Offset: 0xba8
// Size: 0xd8
function private stopwavemanager(wavemanager) {
    wavemanager flag::set("complete");
    for (n_wave = 1; n_wave <= wavemanager.wavecount; n_wave++) {
        wavemanager flag::set("wave" + n_wave + "_complete");
        if (wavemanager.currentwave < n_wave) {
            setwavecleared(wavemanager);
        }
    }
    wavemanager.wavecount = wavemanager.currentwave;
}

// Namespace wavemanagersys/wavemanager
// Params 4, eflags: 0x4
// Checksum 0xfd205a57, Offset: 0xc88
// Size: 0x242
function private startwavemanagerinternal(s_wave_manager_struct, str_team, str_wavemanager, spawn_function_info) {
    wavemanagerbundle = struct::get_script_bundle("wavemanager", isdefined(str_wavemanager) ? str_wavemanager : s_wave_manager_struct.scriptbundlename);
    [[ new wavemanager ]]->__constructor();
    wavemanager = <error pop>;
    wavemanager.m_str_team = util::get_team_mapping(str_team);
    wavemanager.uniqueid = getwavemanageruniqueid();
    wavemanager.wavemanagerbundle = wavemanagerbundle;
    wavemanager.originalwavestruct = s_wave_manager_struct;
    if (isdefined(s_wave_manager_struct)) {
        if (isdefined(s_wave_manager_struct.target)) {
            wavemanager.str_spawpoint_targetname = s_wave_manager_struct.target;
        }
    }
    wavemanager.wavecount = wavemanagerbundle.("wavecount");
    if (isdefined(spawn_function_info)) {
        if (!isdefined(wavemanager.a_spawnfunctionsinfo)) {
            wavemanager.a_spawnfunctionsinfo = [];
        } else if (!isarray(wavemanager.a_spawnfunctionsinfo)) {
            wavemanager.a_spawnfunctionsinfo = array(wavemanager.a_spawnfunctionsinfo);
        }
        wavemanager.a_spawnfunctionsinfo[wavemanager.a_spawnfunctionsinfo.size] = spawn_function_info;
    }
    level._activewavemanagers[wavemanager.uniqueid] = wavemanager;
    wavemanagerinitflags(wavemanager);
    wavemanager thread wavemanagerthink(wavemanager);
    return wavemanager.uniqueid;
}

// Namespace wavemanagersys/wavemanager
// Params 1, eflags: 0x4
// Checksum 0x9ab95fc8, Offset: 0xed8
// Size: 0x672
function private wavemanagerthink(wavemanager) {
    while (true) {
        if (wavemanager flag::get("complete")) {
            break;
        }
        if (wavemanager.currentwave > wavemanager.wavecount) {
            break;
        }
        prefix = waveprefix(wavemanager.currentwave);
        transitioncount = wavemanager.wavemanagerbundle.(prefix + "goToNextWaveCount");
        transitiondelaymin = wavemanager.wavemanagerbundle.(prefix + "transitionDelayMin");
        transitiondelaymax = wavemanager.wavemanagerbundle.(prefix + "transitionDelayMax");
        transitiondelay = 0;
        if (isdefined(transitiondelaymin) && isdefined(transitiondelaymax)) {
            if (transitiondelaymin < transitiondelaymax) {
                transitiondelay = randomfloatrange(transitiondelaymin, transitiondelaymax);
            }
        }
        wavemanager.activeaitypes = [];
        for (aitypeindex = 0; aitypeindex < 5; aitypeindex++) {
            validaitype = isaitypevalid(wavemanager, aitypeindex);
            if (validaitype) {
                [[ new activeaitype ]]->__constructor();
                activeaitype = <error pop>;
                activeaitype.wavemanagerbundle = wavemanager.wavemanagerbundle;
                if (!isdefined(wavemanager.activeaitypes)) {
                    wavemanager.activeaitypes = [];
                } else if (!isarray(wavemanager.activeaitypes)) {
                    wavemanager.activeaitypes = array(wavemanager.activeaitypes);
                }
                wavemanager.activeaitypes[wavemanager.activeaitypes.size] = activeaitype;
                thread activeaitypethink(wavemanager, activeaitype, aitypeindex);
            }
        }
        while (true) {
            b_transition_into_next_wave = 1;
            b_wave_complete = 1;
            b_wave_cleared = 1;
            foreach (activeaitype in wavemanager.activeaitypes) {
                if (!isactiveaitypecomplete(activeaitype)) {
                    b_wave_complete = 0;
                    break;
                }
            }
            if (!isdefined(transitioncount) || transitioncount == 0) {
                foreach (activeaitype in wavemanager.activeaitypes) {
                    if (!isactiveaitypecleared(activeaitype)) {
                        b_wave_cleared = 0;
                        b_transition_into_next_wave = 0;
                        break;
                    }
                }
            } else if (b_wave_complete) {
                totalalivecount = 0;
                foreach (activeaitype in wavemanager.activeaitypes) {
                    aliveai = getactiveaitypealiveai(activeaitype);
                    if (isdefined(aliveai) && isarray(aliveai)) {
                        totalalivecount += aliveai.size;
                    }
                }
                if (totalalivecount > transitioncount) {
                    b_wave_cleared = 0;
                    b_transition_into_next_wave = 0;
                }
            } else {
                foreach (activeaitype in wavemanager.activeaitypes) {
                    if (!isactiveaitypecleared(activeaitype)) {
                        b_wave_cleared = 0;
                        b_transition_into_next_wave = 0;
                        break;
                    }
                }
            }
            if (b_wave_complete) {
                setwavecomplete(wavemanager);
            }
            if (b_wave_cleared) {
                setwavecleared(wavemanager);
            }
            if (b_transition_into_next_wave) {
                break;
            }
            wait 0.1;
        }
        if (isdefined(wavemanager.currentwave)) {
            wavemanager.currentwave++;
        }
        wait transitiondelay + 0.1;
    }
}

// Namespace wavemanagersys/wavemanager
// Params 2, eflags: 0x4
// Checksum 0x494be7d9, Offset: 0x1558
// Size: 0x122
function private wavemanagerexecutespawnfunctions(wavemanager, e_ai) {
    /#
        assert(isdefined(wavemanager));
    #/
    /#
        assert(isdefined(e_ai));
    #/
    if (isdefined(wavemanager.a_spawnfunctionsinfo)) {
        foreach (spawnfunction in wavemanager.a_spawnfunctionsinfo) {
            if (isdefined(spawnfunction.function_ptr)) {
                util::single_thread_argarray(e_ai, spawnfunction.function_ptr, spawnfunction.params);
            }
        }
    }
}

// Namespace wavemanagersys/wavemanager
// Params 1, eflags: 0x4
// Checksum 0xccbc15e5, Offset: 0x1688
// Size: 0x9c
function private activeaitypeinitflags(activeaitype) {
    /#
        assert(isdefined(activeaitype));
    #/
    activeaitype flag::init("activeaitype_" + activeaitype.index + "_complete");
    activeaitype flag::init("activeaitype_" + activeaitype.index + "_cleared");
}

// Namespace wavemanagersys/wavemanager
// Params 1, eflags: 0x4
// Checksum 0xe1081438, Offset: 0x1730
// Size: 0x44
function private setactiveaitypecomplete(activeaitype) {
    activeaitype flag::set("activeaitype_" + activeaitype.index + "_complete");
}

// Namespace wavemanagersys/wavemanager
// Params 1, eflags: 0x4
// Checksum 0xee973f78, Offset: 0x1780
// Size: 0x42
function private isactiveaitypecomplete(activeaitype) {
    return activeaitype flag::get("activeaitype_" + activeaitype.index + "_complete");
}

// Namespace wavemanagersys/wavemanager
// Params 1, eflags: 0x4
// Checksum 0x3394b9d0, Offset: 0x17d0
// Size: 0x44
function private setactiveaitypecleared(activeaitype) {
    activeaitype flag::set("activeaitype_" + activeaitype.index + "_cleared");
}

// Namespace wavemanagersys/wavemanager
// Params 1, eflags: 0x4
// Checksum 0xb7a592c, Offset: 0x1820
// Size: 0x42
function private isactiveaitypecleared(activeaitype) {
    return activeaitype flag::get("activeaitype_" + activeaitype.index + "_cleared");
}

// Namespace wavemanagersys/wavemanager
// Params 1, eflags: 0x4
// Checksum 0xa0da63e, Offset: 0x1870
// Size: 0x1a
function private getactiveaitypealiveai(activeaitype) {
    return activeaitype.a_ai;
}

// Namespace wavemanagersys/wavemanager
// Params 3, eflags: 0x4
// Checksum 0x62ad8cac, Offset: 0x1898
// Size: 0xb8c
function private activeaitypethink(wavemanager, activeaitype, aitypeindex) {
    /#
        assert(isaitypevalid(wavemanager, aitypeindex));
    #/
    activeaitype.index = aitypeindex;
    activeaitypeinitflags(activeaitype);
    activeaitype.variants = getaitypelist(wavemanager, aitypeindex);
    /#
        assert(activeaitype.variants.size);
    #/
    activeaitype.activecount = getaitypeintfield(wavemanager, aitypeindex, "activecount");
    activeaitype.totalcount = getaitypeintfield(wavemanager, aitypeindex, "totalcount");
    spawngroupsizemin = getaitypeintfield(wavemanager, aitypeindex, "groupsizemin");
    spawngroupsizemax = getaitypeintfield(wavemanager, aitypeindex, "groupsizemax");
    if (spawngroupsizemin == spawngroupsizemax) {
        activeaitype.spawngroupsize = spawngroupsizemin;
    } else {
        activeaitype.spawngroupsize = randomintrange(spawngroupsizemin, spawngroupsizemax);
    }
    activeaitype.mixedgroup = getaitypeintfield(wavemanager, aitypeindex, "mixedgroup");
    spawndelaymin = getaitypeintfield(wavemanager, aitypeindex, "spawndelaymin");
    spawndelaymax = getaitypeintfield(wavemanager, aitypeindex, "spawndelaymax");
    if (spawndelaymin == spawndelaymax) {
        activeaitype.spawndelay = spawndelaymin;
    } else {
        activeaitype.spawndelay = randomintrange(spawndelaymin, spawndelaymax);
    }
    lastspawnedtime = undefined;
    firsttime = 1;
    while (true) {
        if (wavemanager flag::get("complete")) {
            break;
        }
        if (activeaitype.spawnedcount >= activeaitype.totalcount) {
            break;
        }
        needspawning = 0;
        availableslots = undefined;
        if (isdefined(activeaitype.a_ai)) {
            activeaitype.a_ai = array::remove_dead(activeaitype.a_ai);
        }
        if (!isdefined(activeaitype.a_ai) || activeaitype.a_ai.size < activeaitype.activecount) {
            availableslots = activeaitype.activecount - activeaitype.a_ai.size;
            if (availableslots >= activeaitype.spawngroupsize) {
                if (!isdefined(lastspawnedtime) || gettime() > lastspawnedtime + activeaitype.spawndelay) {
                    needspawning = 1;
                }
            }
        }
        if (!needspawning) {
            wait 0.1;
            continue;
        }
        localspawnedcount = 0;
        spawngroupsize = activeaitype.spawngroupsize;
        /#
            assert(isdefined(availableslots));
        #/
        if (spawngroupsize > availableslots) {
            spawngroupsize = availableslots;
        }
        if (activeaitype.spawnedcount + spawngroupsize > activeaitype.totalcount) {
            spawngroupsize = activeaitype.totalcount - activeaitype.spawnedcount;
        }
        lastaitype = undefined;
        lastspawnpoint = undefined;
        while (localspawnedcount < spawngroupsize) {
            if (spawngroupsize <= 1) {
                lastspawnpoint = undefined;
            }
            if (wavemanager flag::get("complete")) {
                break;
            }
            if (isdefined(activeaitype.mixedgroup) && activeaitype.mixedgroup && isdefined(lastaitype)) {
                randomvariant = lastaitype;
            } else {
                randomvariant = randomint(activeaitype.variants.size);
                randomvariant = activeaitype.variants[randomvariant];
                randomvariant = aimappingtableutility::getspawnerforai(randomvariant, wavemanager.m_str_team);
                /#
                    assert(isdefined(randomvariant));
                #/
            }
            spawner::global_spawn_throttle();
            isaitype = isassetloaded("aitype", randomvariant);
            if (!isdefined(lastspawnpoint)) {
                if (isaitype) {
                    spawnpoint = aispawningutility::get_best_ai_spawnpoint_for_classname(randomvariant, wavemanager.m_str_team, wavemanager.str_spawpoint_targetname);
                } else {
                    spawnpoint = aispawningutility::get_best_ai_spawnpoint_for_classname(randomvariant, wavemanager.m_str_team, wavemanager.str_spawpoint_targetname);
                }
                if (!isdefined(spawnpoint)) {
                    if (isdefined(wavemanager.str_spawpoint_targetname)) {
                        /#
                            assert("<dev string:x28>" + wavemanager.str_spawpoint_targetname + "<dev string:x36>" + getarchetypefromclassname(randomvariant) + "<dev string:x81>" + wavemanager.m_str_team + "<dev string:x8e>");
                        #/
                    } else {
                        /#
                            assert("<dev string:x28>" + wavemanager.wavemanagerbundle.name + "<dev string:xab>" + getarchetypefromclassname(randomvariant) + "<dev string:x81>" + wavemanager.m_str_team + "<dev string:x8e>");
                        #/
                    }
                }
            }
            v_origin = isdefined(spawnpoint) ? spawnpoint["origin"] : (0, 0, 0);
            v_angles = isdefined(spawnpoint) ? spawnpoint["angles"] : (0, 0, 0);
            e_spawner = isdefined(spawnpoint) ? spawnpoint["spawner"] : undefined;
            if (spawngroupsize > 1) {
                lastspawnpoint = spawnpoint;
            }
            if (isaitype) {
                /#
                    assert(isassetloaded("<dev string:xda>", randomvariant), "<dev string:xe1>" + randomvariant);
                #/
                if (isdefined(e_spawner)) {
                    ai = e_spawner spawnfromspawner(spawnpoint["spawner"].targetname, 1, 0, 1, "actor_" + randomvariant);
                } else {
                    ai = spawnactor(randomvariant, v_origin, v_angles, undefined, 1);
                }
            } else {
                /#
                    assert(isassetloaded("<dev string:x111>", randomvariant), "<dev string:x119>" + randomvariant);
                #/
                if (isdefined(e_spawner)) {
                    ai = e_spawner spawnfromspawner(spawnpoint["spawner"].targetname, 1, 0, 1, randomvariant);
                } else {
                    ai = spawnvehicle(randomvariant, v_origin, v_angles, "xyz");
                }
            }
            if (isdefined(ai)) {
                wavemanagerexecutespawnfunctions(wavemanager, ai);
                if (!isdefined(activeaitype.a_ai)) {
                    activeaitype.a_ai = [];
                } else if (!isarray(activeaitype.a_ai)) {
                    activeaitype.a_ai = array(activeaitype.a_ai);
                }
                activeaitype.a_ai[activeaitype.a_ai.size] = ai;
                lastspawnedtime = gettime();
                activeaitype.spawnedcount++;
                localspawnedcount++;
                ai setteam(wavemanager.m_str_team);
            }
            lastaitype = randomvariant;
            wait 0.1;
        }
        wait 0.1;
    }
    setactiveaitypecomplete(activeaitype);
    while (true) {
        activeaitype.a_ai = array::remove_dead(activeaitype.a_ai);
        if (!activeaitype.a_ai.size) {
            setactiveaitypecleared(activeaitype);
            return;
        }
        wait 0.1;
    }
}

// Namespace wavemanagersys/wavemanager
// Params 0, eflags: 0x4
// Checksum 0x33fae4c8, Offset: 0x2430
// Size: 0x4c
function private getwavemanageruniqueid() {
    if (!isdefined(level.wavemanagerid)) {
        level.wavemanagerid = 0;
    }
    id = level.wavemanagerid;
    level.wavemanagerid++;
    return id;
}

// Namespace wavemanagersys/wavemanager
// Params 1, eflags: 0x4
// Checksum 0x457ccc06, Offset: 0x2488
// Size: 0x20
function private waveprefix(index) {
    return "wave" + index + "_";
}

// Namespace wavemanagersys/wavemanager
// Params 2, eflags: 0x4
// Checksum 0xd31095ed, Offset: 0x24b0
// Size: 0x144
function private isaitypevalid(wavemanager, aitypeindex) {
    /#
        assert(isdefined(wavemanager.wavemanagerbundle));
    #/
    prefix = waveprefix(wavemanager.currentwave);
    variant1 = wavemanager.wavemanagerbundle.(prefix + aitypeindex + "_" + "variant1");
    variant2 = wavemanager.wavemanagerbundle.(prefix + aitypeindex + "_" + "variant2");
    variant3 = wavemanager.wavemanagerbundle.(prefix + aitypeindex + "_" + "variant3");
    if (isdefined(variant1) || isdefined(variant2) || isdefined(variant3)) {
        return true;
    }
    return false;
}

// Namespace wavemanagersys/wavemanager
// Params 2, eflags: 0x4
// Checksum 0x3ddb787, Offset: 0x2600
// Size: 0x28e
function private getaitypelist(wavemanager, aitypeindex) {
    /#
        assert(isdefined(wavemanager.wavemanagerbundle));
    #/
    /#
        assert(isaitypevalid(wavemanager, aitypeindex));
    #/
    prefix = waveprefix(wavemanager.currentwave);
    aitypeprefixfromwave = aitypeprefixfromwave(prefix, aitypeindex);
    variant1 = wavemanager.wavemanagerbundle.(aitypeprefixfromwave + "variant1");
    variant2 = wavemanager.wavemanagerbundle.(aitypeprefixfromwave + "variant2");
    variant3 = wavemanager.wavemanagerbundle.(aitypeprefixfromwave + "variant3");
    aitypes = [];
    if (isdefined(variant1)) {
        if (!isdefined(aitypes)) {
            aitypes = [];
        } else if (!isarray(aitypes)) {
            aitypes = array(aitypes);
        }
        aitypes[aitypes.size] = variant1;
    }
    if (isdefined(variant2)) {
        if (!isdefined(aitypes)) {
            aitypes = [];
        } else if (!isarray(aitypes)) {
            aitypes = array(aitypes);
        }
        aitypes[aitypes.size] = variant2;
    }
    if (isdefined(variant3)) {
        if (!isdefined(aitypes)) {
            aitypes = [];
        } else if (!isarray(aitypes)) {
            aitypes = array(aitypes);
        }
        aitypes[aitypes.size] = variant3;
    }
    return aitypes;
}

// Namespace wavemanagersys/wavemanager
// Params 2, eflags: 0x4
// Checksum 0x60124b2c, Offset: 0x2898
// Size: 0x28
function private aitypeprefixfromwave(waveprefix, aitypeindex) {
    return waveprefix + aitypeindex + "_";
}

// Namespace wavemanagersys/wavemanager
// Params 3, eflags: 0x4
// Checksum 0xf9e191f6, Offset: 0x28c8
// Size: 0x11a
function private getaitypeintfield(wavemanager, aitypeindex, field) {
    /#
        assert(isdefined(wavemanager.wavemanagerbundle));
    #/
    /#
        assert(isaitypevalid(wavemanager, aitypeindex));
    #/
    prefix = waveprefix(wavemanager.currentwave);
    aitypeprefix = aitypeprefixfromwave(prefix, aitypeindex);
    value = wavemanager.wavemanagerbundle.(aitypeprefix + field);
    if (!isdefined(value)) {
        value = 0;
    }
    return int(value);
}

