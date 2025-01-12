#namespace region_utility;

// Namespace region_utility/region_utility
// Params 0, eflags: 0x0
// Checksum 0x335cc3cf, Offset: 0x88
// Size: 0x116
function function_a20797f5() {
    level.lanedata = spawnstruct();
    i = 0;
    level.lanedata.var_70187d4c = [];
    for (var_70187d4c = getentarray("vol_tregion_lane_" + i, "targetname"); isdefined(var_70187d4c) && isarray(var_70187d4c) && var_70187d4c.size > 0; var_70187d4c = getentarray("vol_tregion_lane_" + i, "targetname")) {
        level.lanedata.var_70187d4c[i] = var_70187d4c;
        waitframe(1);
        i++;
    }
    level.lanedata.numlanes = i - 1;
}

// Namespace region_utility/region_utility
// Params 0, eflags: 0x0
// Checksum 0x4af8922c, Offset: 0x1a8
// Size: 0x2a
function function_46a6789c() {
    if (!isdefined(level.lanedata)) {
        return 0;
    }
    return level.lanedata.numlanes;
}

// Namespace region_utility/region_utility
// Params 3, eflags: 0x0
// Checksum 0xefa61370, Offset: 0x1e0
// Size: 0x82
function function_5f6c15b2(startpos, endpos, lanenum) {
    function_f2ea8069();
    volumes = function_d50b003f(lanenum);
    function_dc402576(volumes, 0.2);
    return function_4affe2a7(startpos, endpos);
}

// Namespace region_utility/region_utility
// Params 3, eflags: 0x0
// Checksum 0xb437776f, Offset: 0x270
// Size: 0x82
function function_e5e2785c(var_b5034f47, var_e16bc9b0, lanenum) {
    function_f2ea8069();
    volumes = function_d50b003f(lanenum);
    function_dc402576(volumes, 0.2);
    return function_6191551e(var_b5034f47, var_e16bc9b0);
}

// Namespace region_utility/region_utility
// Params 0, eflags: 0x4
// Checksum 0x39578108, Offset: 0x300
// Size: 0x6e
function private function_f2ea8069() {
    for (i = 1; i < 128; i++) {
        info = function_ff3d61bd(i);
        if (!isdefined(info)) {
            break;
        }
        function_1354dbf3(i, 1);
    }
}

// Namespace region_utility/region_utility
// Params 1, eflags: 0x4
// Checksum 0x40db908, Offset: 0x378
// Size: 0x24
function private function_d50b003f(lanenum) {
    return level.lanedata.var_70187d4c[lanenum];
}

// Namespace region_utility/region_utility
// Params 2, eflags: 0x4
// Checksum 0xa442ff28, Offset: 0x3a8
// Size: 0x13e
function private function_dc402576(volumes, score) {
    if (!isarray(volumes)) {
        return;
    }
    for (i = 1; i < 128; i++) {
        info = function_ff3d61bd(i);
        if (!isdefined(info)) {
            break;
        }
        desired = 0;
        foreach (volume in volumes) {
            if (volume istouching(info.origin)) {
                desired = 1;
                break;
            }
        }
        if (desired) {
            function_1354dbf3(i, score);
        }
    }
}

