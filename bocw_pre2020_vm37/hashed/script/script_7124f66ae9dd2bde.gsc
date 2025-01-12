#namespace namespace_4567f5de;

// Namespace namespace_4567f5de/namespace_4567f5de
// Params 0, eflags: 0x1 linked
// Checksum 0x516a56cd, Offset: 0x80
// Size: 0xd4
function function_70a657d8() {
    if (currentsessionmode() != 1 || function_548ca110() <= 0) {
        return;
    }
    var_adda5a0 = function_9fe0704c();
    function_9988d243(var_adda5a0, getdvarint(#"hash_105a4075f0f007f7", 2000));
    function_c54ac225(var_adda5a0);
    /#
        level thread debug(var_adda5a0);
    #/
    level.var_8706e44e = var_adda5a0;
}

// Namespace namespace_4567f5de/namespace_4567f5de
// Params 2, eflags: 0x1 linked
// Checksum 0xf7ddd9d3, Offset: 0x160
// Size: 0x136
function function_a9de216e(var_adda5a0, origin) {
    if (origin[0] < var_adda5a0.absmins[0] || origin[0] > var_adda5a0.absmaxs[0] || origin[1] < var_adda5a0.absmins[1] || origin[1] > var_adda5a0.absmaxs[1]) {
        return undefined;
    }
    var_49550edc = origin[0] - var_adda5a0.absmins[0];
    var_1983c9e8 = origin[1] - var_adda5a0.absmins[1];
    i = int(var_49550edc / var_adda5a0.cellwidth);
    j = int(var_1983c9e8 / var_adda5a0.cellheight);
    return var_adda5a0.cells[i][j];
}

// Namespace namespace_4567f5de/namespace_4567f5de
// Params 4, eflags: 0x1 linked
// Checksum 0xdc414fb3, Offset: 0x2a0
// Size: 0x162
function function_89751246(var_adda5a0, start, end, var_28edea35 = 0) {
    startpoint = getclosesttacpoint(start);
    endpoint = getclosesttacpoint(end);
    if (!isdefined(startpoint) || !isdefined(endpoint) || startpoint.region == endpoint.region) {
        return [];
    }
    if (var_28edea35 == 0) {
        function_f0af04e5(var_adda5a0, start, end);
    } else {
        dir = end - start;
        angles = vectortoangles(dir);
        var_eccc5f2f = anglestoright(angles);
        if (var_28edea35 == 1) {
            var_eccc5f2f = (0, 0, 0) - var_eccc5f2f;
        }
        function_170ca7c1(var_adda5a0, start, end, var_eccc5f2f);
    }
    return function_e86822f4(start, end);
}

// Namespace namespace_4567f5de/namespace_4567f5de
// Params 3, eflags: 0x5 linked
// Checksum 0xb079df95, Offset: 0x410
// Size: 0x94
function private function_f0af04e5(var_adda5a0, start, end) {
    radius = var_adda5a0.cellwidth * getdvarint(#"hash_511ed045f90afb51", 1);
    function_4e2e138f(1);
    function_e23eb6a(start, end, radius, 0.2);
}

// Namespace namespace_4567f5de/namespace_4567f5de
// Params 4, eflags: 0x5 linked
// Checksum 0x6f648318, Offset: 0x4b0
// Size: 0x1fc
function private function_170ca7c1(var_adda5a0, start, end, var_eccc5f2f) {
    var_62e7e499 = var_adda5a0.cellwidth * getdvarint(#"hash_79035c603ac574a9", 2);
    var_137586c3 = function_414421b0(var_adda5a0, start + var_eccc5f2f * var_62e7e499);
    var_2540aa59 = function_414421b0(var_adda5a0, end + var_eccc5f2f * var_62e7e499);
    /#
        if (getdvarint(#"hash_619b9445b4a73998", 0)) {
            recordline(start, var_137586c3, (1, 0, 1));
            recordline(var_137586c3, var_2540aa59, (1, 0, 1));
            recordline(var_2540aa59, end, (1, 0, 1));
        }
    #/
    function_4e2e138f(1);
    radius = var_adda5a0.cellwidth * getdvarint(#"hash_511ed045f90afb51", 1);
    function_e23eb6a(start, end, radius, 5);
    function_e23eb6a(start, var_137586c3, radius, 0.2);
    function_e23eb6a(var_137586c3, var_2540aa59, radius, 0.2);
    function_e23eb6a(var_2540aa59, end, radius, 0.2);
}

// Namespace namespace_4567f5de/namespace_4567f5de
// Params 4, eflags: 0x5 linked
// Checksum 0x5b4156fa, Offset: 0x6b8
// Size: 0x2cc
function private function_e23eb6a(start, end, radius, weight) {
    dir = end - start;
    length = length(dir);
    angles = vectortoangles(dir);
    fwd = anglestoforward(angles);
    right = anglestoright(angles);
    radiussq = radius * radius;
    numregions = function_548ca110();
    /#
        color = weight >= 1 ? (0, 1, 0) : (1, 0, 0);
    #/
    for (i = 1; i < numregions; i++) {
        info = function_b507a336(i);
        var_4e6d4b85 = 0;
        if (distance2dsquared(info.origin, start) < radiussq || distance2dsquared(info.origin, end) < radiussq) {
            var_4e6d4b85 = 1;
        } else {
            vec = info.origin - start;
            var_5c9047d7 = vectordot(vec, fwd);
            var_4e6d4b85 = var_5c9047d7 > 0 && var_5c9047d7 < length && abs(vectordot(vec, right)) <= radius;
        }
        if (var_4e6d4b85) {
            function_e563d6b7(i, weight);
            /#
                if (getdvarint(#"hash_290e57c173945ce", 0)) {
                    recordline(info.origin, info.origin + (0, 0, 128), color);
                }
            #/
        }
    }
}

// Namespace namespace_4567f5de/namespace_4567f5de
// Params 2, eflags: 0x5 linked
// Checksum 0x659ac794, Offset: 0x990
// Size: 0x2be
function private function_9988d243(var_adda5a0, var_8c39eefe) {
    var_4d8901e3 = function_953ff1a6(var_adda5a0.width, var_8c39eefe);
    var_caa7fc27 = function_953ff1a6(var_adda5a0.height, var_8c39eefe);
    cellwidth = var_adda5a0.width / var_4d8901e3;
    cellheight = var_adda5a0.height / var_caa7fc27;
    halfwidth = cellwidth / 2;
    halfheight = cellheight / 2;
    mins = (halfwidth * -1, halfheight * -1, var_adda5a0.mins[2]);
    maxs = (halfwidth, halfheight, var_adda5a0.maxs[2]);
    cells = [];
    for (i = 0; i < var_4d8901e3; i++) {
        cells[i] = [];
        for (j = 0; j < var_caa7fc27; j++) {
            x = var_adda5a0.absmins[0] + i * cellwidth + cellwidth / 2;
            y = var_adda5a0.absmins[1] + j * cellheight + cellheight / 2;
            var_a3e9c2a0 = (x, y, var_adda5a0.origin[2]);
            regions = function_5fd7ca72(var_a3e9c2a0, mins, maxs);
            if (regions.size > 0) {
                cells[i][j] = {#origin:var_a3e9c2a0, #regions:regions};
            }
        }
    }
    var_adda5a0.cells = cells;
    var_adda5a0.var_4d8901e3 = var_4d8901e3;
    var_adda5a0.var_caa7fc27 = var_caa7fc27;
    var_adda5a0.cellwidth = cellwidth;
    var_adda5a0.cellheight = cellheight;
    var_adda5a0.var_eb6d633b = mins;
    var_adda5a0.var_cf04cb3e = maxs;
    var_adda5a0.var_2fdc3a51 = (maxs[0], maxs[1], maxs[2]);
}

// Namespace namespace_4567f5de/namespace_4567f5de
// Params 2, eflags: 0x5 linked
// Checksum 0xe7794847, Offset: 0xc58
// Size: 0x7a
function private function_953ff1a6(length, var_8c39eefe) {
    var_eb786747 = length / var_8c39eefe;
    count = round(var_eb786747);
    if (count > var_eb786747) {
        return int(count);
    }
    return int(count + 1);
}

// Namespace namespace_4567f5de/namespace_4567f5de
// Params 3, eflags: 0x5 linked
// Checksum 0x5737f96a, Offset: 0xce0
// Size: 0x14a
function private function_5fd7ca72(origin, mins, maxs) {
    absmins = origin + mins;
    absmaxs = origin + maxs;
    regions = [];
    numregions = function_548ca110();
    for (i = 1; i < numregions; i++) {
        info = function_b507a336(i);
        if (info.neighbors.size <= 0) {
            continue;
        }
        var_9b181eca = info.origin;
        if (var_9b181eca[0] >= absmins[0] && var_9b181eca[0] <= absmaxs[0] && var_9b181eca[1] >= absmins[1] && var_9b181eca[1] <= absmaxs[1]) {
            regions[regions.size] = info.id;
        }
    }
    return regions;
}

// Namespace namespace_4567f5de/namespace_4567f5de
// Params 1, eflags: 0x5 linked
// Checksum 0xe1fddc0a, Offset: 0xe38
// Size: 0x106
function private function_c54ac225(var_adda5a0) {
    var_ec070c72 = 0;
    var_cf1fef5c = 0;
    maxradius = 0;
    numregions = function_548ca110();
    for (i = 1; i < numregions; i++) {
        info = function_b507a336(i);
        if (info.neighbors.size <= 0) {
            continue;
        }
        if (info.radius > maxradius) {
            maxradius = info.radius;
        }
        if (info.radius > 0) {
            var_cf1fef5c++;
            var_ec070c72 += info.radius;
        }
    }
    var_adda5a0.var_87b6e861 = var_ec070c72 / var_cf1fef5c;
    var_adda5a0.var_8b4601a1 = maxradius;
}

// Namespace namespace_4567f5de/namespace_4567f5de
// Params 2, eflags: 0x5 linked
// Checksum 0x6b08cf01, Offset: 0xf48
// Size: 0x144
function private function_414421b0(var_adda5a0, origin) {
    if (origin[0] >= var_adda5a0.absmins[0] && origin[0] <= var_adda5a0.absmaxs[0] && origin[1] >= var_adda5a0.absmins[1] && origin[1] <= var_adda5a0.absmaxs[1]) {
        return origin;
    }
    x = min(var_adda5a0.absmaxs[0], max(var_adda5a0.absmins[0], origin[0]));
    y = min(var_adda5a0.absmaxs[1], max(var_adda5a0.absmins[1], origin[1]));
    return (x, y, origin[2]);
}

// Namespace namespace_4567f5de/namespace_4567f5de
// Params 0, eflags: 0x5 linked
// Checksum 0xdb6754f0, Offset: 0x1098
// Size: 0xaa
function private function_9fe0704c() {
    bounds = function_5ac49687();
    if (isdefined(bounds)) {
        bounds.width = bounds.maxs[0] - bounds.mins[0];
        bounds.height = bounds.maxs[1] - bounds.mins[1];
        bounds.var_f521d351 = (bounds.maxs[0], bounds.maxs[1], bounds.mins[2]);
    }
    return bounds;
}

// Namespace namespace_4567f5de/namespace_4567f5de
// Params 0, eflags: 0x4
// Checksum 0x380744aa, Offset: 0x1150
// Size: 0x27c
function private function_c09d9f39() {
    corners = getentarray("minimap_corner", "targetname");
    if (corners.size != 2) {
        return undefined;
    }
    absmins = [];
    absmaxs = [];
    for (i = 0; i < 2; i++) {
        absmins[i] = min(corners[0].origin[i], corners[1].origin[i]);
        absmaxs[i] = max(corners[0].origin[i], corners[1].origin[i]);
    }
    x = (absmins[0] + absmaxs[0]) / 2;
    y = (absmins[1] + absmaxs[1]) / 2;
    origin = (x, y, 0);
    width = absmaxs[0] - absmins[0];
    height = absmaxs[1] - absmins[1];
    halfwidth = width / 2;
    halfheight = height / 2;
    return {#absmins:(absmins[0], absmins[1], 0), #absmaxs:(absmaxs[0], absmaxs[1], 0), #origin:(x, y, 0), #width:width, #height:height, #mins:(halfwidth * -1, halfheight * -1, 0), #maxs:(halfwidth, halfheight, 0)};
}

/#

    // Namespace namespace_4567f5de/namespace_4567f5de
    // Params 1, eflags: 0x4
    // Checksum 0xc2188054, Offset: 0x13d8
    // Size: 0x266
    function private debug(var_adda5a0) {
        adddebugcommand("<dev string:x38>");
        adddebugcommand("<dev string:x52>");
        adddebugcommand("<dev string:x72>");
        adddebugcommand("<dev string:x99>");
        adddebugcommand("<dev string:xba>");
        adddebugcommand("<dev string:xda>");
        adddebugcommand("<dev string:x118>");
        adddebugcommand("<dev string:x162>");
        adddebugcommand("<dev string:x1ba>");
        adddebugcommand("<dev string:x206>");
        var_8c39eefe = getdvarint(#"hash_105a4075f0f007f7", 2000);
        while (true) {
            if (var_8c39eefe != getdvarint(#"hash_105a4075f0f007f7", 2000)) {
                function_9988d243(var_adda5a0, getdvarint(#"hash_105a4075f0f007f7", 2000));
                var_8c39eefe = getdvarint(#"hash_105a4075f0f007f7", 2000);
            }
            if (getdvarint(#"hash_430340d8cfee887d", 0)) {
                function_c971730a(var_adda5a0);
                if (getdvarint(#"hash_1156f0a56ba87637", 0)) {
                    function_bb62652e(var_adda5a0, getdvarint(#"hash_6a43f1a0a550378", 0));
                }
            }
            waitframe(1);
        }
    }

    // Namespace namespace_4567f5de/namespace_4567f5de
    // Params 2, eflags: 0x4
    // Checksum 0x335805f9, Offset: 0x1648
    // Size: 0x12c
    function private function_bb62652e(var_adda5a0, var_6fd60ba8) {
        if (!isdefined(var_6fd60ba8)) {
            var_6fd60ba8 = 0;
        }
        cells = var_adda5a0.cells;
        foreach (col in cells) {
            foreach (var_d3a2864f in col) {
                function_2b71718(var_adda5a0, var_d3a2864f, var_6fd60ba8);
            }
        }
    }

    // Namespace namespace_4567f5de/namespace_4567f5de
    // Params 3, eflags: 0x4
    // Checksum 0xf4f7b501, Offset: 0x1780
    // Size: 0x218
    function private function_2b71718(var_adda5a0, var_d3a2864f, var_6fd60ba8) {
        if (!isdefined(var_6fd60ba8)) {
            var_6fd60ba8 = 0;
        }
        box(var_d3a2864f.origin, var_adda5a0.var_eb6d633b, var_adda5a0.var_cf04cb3e, 0, (0, 1, 0));
        var_49550edc = var_d3a2864f.origin[0] - var_adda5a0.absmins[0];
        var_1983c9e8 = var_d3a2864f.origin[1] - var_adda5a0.absmins[1];
        i = int(var_49550edc / var_adda5a0.cellwidth);
        j = int(var_1983c9e8 / var_adda5a0.cellheight);
        print3d(var_d3a2864f.origin, i + "<dev string:x250>" + j, (0, 1, 0));
        if (var_6fd60ba8) {
            foreach (id in var_d3a2864f.regions) {
                info = function_b507a336(id);
                line(info.origin, info.origin + (0, 0, 64), (1, 1, 1));
                print3d(info.origin, id, (1, 1, 1));
            }
        }
    }

    // Namespace namespace_4567f5de/namespace_4567f5de
    // Params 1, eflags: 0x4
    // Checksum 0x6af8e3a5, Offset: 0x19a0
    // Size: 0x44
    function private function_c971730a(var_adda5a0) {
        box(var_adda5a0.origin, var_adda5a0.mins, var_adda5a0.var_f521d351, 0, (1, 0, 0));
    }

#/
