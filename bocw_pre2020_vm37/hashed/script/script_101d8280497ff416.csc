#using script_19c6c147c637b960;
#using script_20055f2f97341caa;
#using script_2009cc4c4ecc010f;
#using script_3d35e2ff167b3a82;
#using script_680dddbda86931fa;
#using script_6942b08b05c26c89;
#using scripts\core_common\flag_shared;
#using scripts\core_common\struct;

#namespace namespace_65181344;

// Namespace namespace_65181344/namespace_65181344
// Params 0, eflags: 0x5 linked
// Checksum 0xdb2d7ba1, Offset: 0x1c8
// Size: 0x1d8
function private function_2c4d3d40() {
    function_4233b851();
    level.var_de3d5d56 = [];
    if (issplitscreen()) {
        level.var_de3d5d56 = undefined;
    }
    var_3a1737b4 = getscriptbundles(#"itemspawnentry");
    var_cce250bc = function_d634ed59();
    index = 0;
    offsetorigin = (0, 0, -64000);
    foreach (var_1461de43, var_28f8f6a9 in var_3a1737b4) {
        if (isdefined(level.var_de3d5d56)) {
            level.var_de3d5d56[var_1461de43] = var_28f8f6a9;
        }
        function_43cd95f4(index, var_1461de43);
        function_54ca5536(index, 1);
        function_b97dfce0(index, offsetorigin);
        index++;
        if (getrealtime() - level.var_d0676b07 > level.var_3e9c9a35) {
            waitframe(1);
            level.var_d0676b07 = getrealtime();
        }
    }
}

// Namespace namespace_65181344/namespace_65181344
// Params 1, eflags: 0x5 linked
// Checksum 0xf5ae2a1d, Offset: 0x3a8
// Size: 0x324
function private function_440f0490(var_b91441dd) {
    assert(isdefined(var_b91441dd) && var_b91441dd.type === "<dev string:x38>");
    assert(var_b91441dd.itemlist.size > 0, "<dev string:x4e>" + var_b91441dd.name + "<dev string:x65>");
    if (var_b91441dd.itemlist.size <= 0) {
        return;
    }
    weights = [];
    weighttotal = 0;
    for (rowindex = 0; rowindex < var_b91441dd.itemlist.size; rowindex++) {
        if (!isdefined(var_b91441dd.itemlist[rowindex].var_a6762160)) {
            continue;
        }
        var_35843db5 = isdefined(var_b91441dd.itemlist[rowindex].minweight) ? var_b91441dd.itemlist[rowindex].minweight : 0;
        var_ccef9e25 = isdefined(var_b91441dd.itemlist[rowindex].maxweight) ? var_b91441dd.itemlist[rowindex].maxweight : 0;
        minweight = int(min(var_35843db5, var_ccef9e25));
        maxweight = int(max(var_35843db5, var_ccef9e25));
        diff = maxweight - minweight;
        randomint = function_d59c2d03(diff + 1);
        weight = randomint + minweight;
        weights[weights.size] = weight;
        weighttotal += weight;
    }
    if (weighttotal <= 0) {
        return;
    }
    var_d54615ef = function_d59c2d03(weighttotal);
    currentweight = 0;
    for (weightindex = 0; weightindex < weights.size; weightindex++) {
        if (!isdefined(var_b91441dd.itemlist[weightindex].var_a6762160)) {
            continue;
        }
        currentweight += weights[weightindex];
        if (var_d54615ef <= currentweight) {
            var_b91441dd = getscriptbundle(var_b91441dd.itemlist[weightindex].var_a6762160);
            assert(var_b91441dd.type === "<dev string:x72>");
            break;
        }
    }
    return var_b91441dd;
}

// Namespace namespace_65181344/namespace_65181344
// Params 0, eflags: 0x5 linked
// Checksum 0x6703650, Offset: 0x6d8
// Size: 0xe
function private function_6a5c090c() {
    level.var_de3d5d56 = undefined;
}

// Namespace namespace_65181344/namespace_65181344
// Params 0, eflags: 0x1 linked
// Checksum 0xc52be851, Offset: 0x6f0
// Size: 0x210
function function_9e9f43cd() {
    if (!level flag::get(#"hash_67b445a4b1d59922") && !level flag::get(#"hash_11c9cde7b522c5a9")) {
        assert(0);
        return;
    }
    foreach (targetname, points in level.var_1d777960) {
        for (index = 0; index < points.size; index++) {
            origin = points[index].origin;
            angles = points[index].angles;
            ground_pos = physicstraceex(origin + (0, 0, 24), origin - (0, 0, 96), (0, 0, 0), (0, 0, 0), undefined, 32);
            position = ground_pos[#"position"];
            function_53a81463(position, angles, targetname, #"");
        }
        if (getrealtime() - level.var_d0676b07 > level.var_3e9c9a35) {
            waitframe(1);
            level.var_d0676b07 = getrealtime();
        }
    }
}

// Namespace namespace_65181344/namespace_65181344
// Params 0, eflags: 0x1 linked
// Checksum 0x2f9c68f2, Offset: 0x908
// Size: 0x1c4
function function_e88ecf7f() {
    if (!level flag::get(#"hash_67b445a4b1d59922") && !level flag::get(#"hash_11c9cde7b522c5a9")) {
        assert(0);
        return;
    }
    assert(level.var_bf9b06d3.size == level.var_8d50adaa.size);
    for (index = 0; index < level.var_bf9b06d3.size; index++) {
        points = function_abaeb170(level.var_bf9b06d3[index], undefined, undefined, level.var_8d50adaa[index], undefined, 0);
        for (pointindex = 0; pointindex < points.size; pointindex++) {
            function_b2cf8bc6(points[pointindex].id, #"");
            if (isdefined(points[pointindex].targetname)) {
                level.var_28cd0b1f[points[pointindex].targetname] = 1;
            }
        }
        if (getrealtime() - level.var_d0676b07 > level.var_3e9c9a35) {
            waitframe(1);
            level.var_d0676b07 = getrealtime();
        }
    }
}

// Namespace namespace_65181344/namespace_65181344
// Params 4, eflags: 0x5 linked
// Checksum 0xd4057f87, Offset: 0xad8
// Size: 0x24
function private function_35461e5f(*index, *row, *stashitem, *falling) {
    
}

// Namespace namespace_65181344/namespace_65181344
// Params 4, eflags: 0x5 linked
// Checksum 0xf445fa6a, Offset: 0xb08
// Size: 0x24
function private function_62c0d32d(*index, *item_name, *stashitem, *falling) {
    
}

// Namespace namespace_65181344/namespace_65181344
// Params 1, eflags: 0x5 linked
// Checksum 0xa171ab16, Offset: 0xb38
// Size: 0x84
function private function_98013deb(row) {
    numchildren = 0;
    for (index = 1; index <= 5; index++) {
        item_name = self.var_b91441dd.itemlist[row].("childitementry_" + index);
        if (isdefined(item_name)) {
            numchildren++;
        }
    }
    return numchildren;
}

// Namespace namespace_65181344/namespace_65181344
// Params 3, eflags: 0x5 linked
// Checksum 0x66ecab81, Offset: 0xbc8
// Size: 0x83c
function private _spawn_item(point, row, stashitem = 0) {
    if (!isdefined(point)) {
        return;
    }
    item_name = self.var_b91441dd.itemlist[row].var_a6762160;
    if (isdefined(item_name) && isdefined(level.var_4afb8f5a[item_name])) {
        item_name = level.var_4afb8f5a[item_name];
    }
    if (!isdefined(item_name) || item_name == "") {
        function_43cd95f4(point.id, "");
        /#
            if (!isdefined(level.var_d80c35aa[#"blank"])) {
                level.var_d80c35aa[#"blank"] = 0;
            }
            level.var_d80c35aa[#"blank"]++;
        #/
        return;
    }
    var_a6762160 = isdefined(level.var_de3d5d56) ? level.var_de3d5d56[item_name] : getscriptbundle(item_name);
    /#
        if (!stashitem && isdefined(var_a6762160) && isdefined(var_a6762160.itemtype)) {
            if (!isdefined(level.var_d80c35aa[var_a6762160.itemtype])) {
                level.var_d80c35aa[var_a6762160.itemtype] = 0;
            }
            level.var_d80c35aa[var_a6762160.itemtype]++;
        }
    #/
    if (!isdefined(var_a6762160) || !isdefined(var_a6762160.itemtype) || var_a6762160.itemtype == #"blank") {
        function_43cd95f4(point.id, "");
        return;
    } else if (var_a6762160.itemtype == #"vehicle") {
        function_43cd95f4(point.id, "");
        /#
            level.var_f2db6a7f++;
        #/
        if (getrealtime() - level.var_d0676b07 > level.var_3e9c9a35) {
            waitframe(1);
            level.var_d0676b07 = getrealtime();
        }
        return;
    } else if (!sessionmodeiszombiesgame() && is_true(getgametypesetting(#"hash_36c2645732ad1c3b"))) {
        return;
    }
    numchildren = self function_98013deb(row);
    if (!stashitem) {
        origin = point.origin;
        angles = point.angles;
        if (numchildren > 0) {
            if (!isdefined(var_a6762160.var_47f145b4)) {
                angles = (0, angleclamp180(origin[0] + origin[1] + origin[2]), 0);
                forward = anglestoforward(angles) * level.var_69dda516[0];
                offset = rotatepoint(forward, (0, level.var_cc113617[0], 0));
                origin += offset;
                ground_pos = physicstraceex(origin + (0, 0, 24), origin - (0, 0, 96), (0, 0, 0), (0, 0, 0), undefined, 32);
                origin = ground_pos[#"position"];
                normal = ground_pos[#"normal"];
                angles = function_c1fa62a2(angles, normal);
            }
        } else if (!isdefined(var_a6762160.var_47f145b4)) {
            angles = combineangles(angles, (0, angleclamp180(origin[0] + origin[1] + origin[2]), 0));
        } else {
            angles = (0, angles[1], 0);
        }
        angles = combineangles(angles, (isdefined(var_a6762160.var_7adcadc1) ? var_a6762160.var_7adcadc1 : 0, isdefined(var_a6762160.var_6731866b) ? var_a6762160.var_6731866b : 0, isdefined(var_a6762160.var_e6ac0592) ? var_a6762160.var_e6ac0592 : 0));
        originoffset = (isdefined(var_a6762160.var_ada071fe) ? var_a6762160.var_ada071fe : 0, isdefined(var_a6762160.var_5ab74bb1) ? var_a6762160.var_5ab74bb1 : 0, isdefined(var_a6762160.var_50773731) ? var_a6762160.var_50773731 : 0);
        origin += originoffset;
        if (numchildren > 0 || isdefined(var_a6762160.var_47f145b4)) {
            point = function_53a81463(origin, angles, point.targetname, item_name);
        } else {
            function_b97dfce0(point.id, origin);
            function_3eab95b5(point.id, angles);
            point.angles = angles;
        }
    }
    function_43cd95f4(point.id, item_name);
    if (isdefined(var_a6762160.var_a53e9db0)) {
        function_126ac556(point.id, function_67456242(var_a6762160));
    }
    if (stashitem) {
        function_54ca5536(point.id, -1);
    }
    /#
        if (stashitem) {
            if (!isdefined(level.var_ecf16fd3[var_a6762160.itemtype])) {
                level.var_ecf16fd3[var_a6762160.itemtype] = 0;
            }
            level.var_ecf16fd3[var_a6762160.itemtype]++;
            level.var_2850ef5++;
        } else {
            level.var_136445c0++;
        }
    #/
    if (numchildren > 0) {
        for (index = 1; index <= 5; index++) {
            item_name = self.var_b91441dd.itemlist[row].("childitementry_" + index);
            if (isdefined(item_name)) {
                function_f0e5262b(item_name, point, index, stashitem, point.targetname);
            }
        }
    }
}

// Namespace namespace_65181344/namespace_65181344
// Params 5, eflags: 0x5 linked
// Checksum 0x3092a2b6, Offset: 0x1410
// Size: 0x4d4
function private function_f0e5262b(item_name, point, childindex, stashitem = 0, targetname) {
    if (isdefined(level.var_4afb8f5a[item_name])) {
        item_name = level.var_4afb8f5a[item_name];
    }
    var_a6762160 = isdefined(level.var_de3d5d56) ? level.var_de3d5d56[item_name] : getscriptbundle(item_name);
    offset = (0, 0, 0);
    angles = (0, 0, 0);
    origin = point.origin;
    if (!stashitem) {
        assert(childindex > 0 && childindex <= 5);
        parentangles = (0, point.angles[1], 0);
        degree = level.var_cc113617[childindex];
        distance = level.var_69dda516[childindex];
        offset = (cos(degree) * distance, sin(degree) * distance, 0);
        offset = rotatepoint(offset, parentangles);
        origin += offset;
        ground_pos = physicstraceex(origin + (0, 0, 24), origin - (0, 0, 96), (0, 0, 0), (0, 0, 0), undefined, 32);
        var_f05b52fe = (isdefined(var_a6762160.var_ada071fe) ? var_a6762160.var_ada071fe : 0, isdefined(var_a6762160.var_5ab74bb1) ? var_a6762160.var_5ab74bb1 : 0, isdefined(var_a6762160.var_50773731) ? var_a6762160.var_50773731 : 0);
        origin = ground_pos[#"position"] + var_f05b52fe;
        normal = ground_pos[#"normal"];
        angles += (0, level.var_82e94a26[childindex], 0);
        angles += (0, point.angles[1], 0);
        angles = function_c1fa62a2(angles, normal);
        angles = combineangles(angles, (isdefined(var_a6762160.var_7adcadc1) ? var_a6762160.var_7adcadc1 : 0, isdefined(var_a6762160.var_6731866b) ? var_a6762160.var_6731866b : 0, isdefined(var_a6762160.var_e6ac0592) ? var_a6762160.var_e6ac0592 : 0));
        if (getrealtime() - level.var_d0676b07 > level.var_3e9c9a35) {
            waitframe(1);
            level.var_d0676b07 = getrealtime();
        }
    }
    var_23972ae0 = function_53a81463(origin, angles, targetname, item_name);
    if (stashitem) {
        function_54ca5536(var_23972ae0.id, -1);
    }
    /#
        if (stashitem) {
            if (!isdefined(level.var_ecf16fd3[var_a6762160.itemtype])) {
                level.var_ecf16fd3[var_a6762160.itemtype] = 0;
            }
            level.var_ecf16fd3[var_a6762160.itemtype]++;
            level.var_2850ef5++;
            return;
        }
        if (!isdefined(level.var_8d9ad8e8[var_a6762160.itemtype])) {
            level.var_8d9ad8e8[var_a6762160.itemtype] = 0;
        }
        level.var_8d9ad8e8[var_a6762160.itemtype]++;
        level.var_5720c09a++;
    #/
}

// Namespace namespace_65181344/namespace_65181344
// Params 1, eflags: 0x5 linked
// Checksum 0x8d3a1a2c, Offset: 0x18f0
// Size: 0x6b2
function private function_ea39d1fa(stash) {
    stash.var_aa9f8f87 = self.scriptbundlename;
    var_aa9f8f87 = self.var_b91441dd;
    if (isdefined(var_aa9f8f87) && isdefined(level.var_fb9a8536[var_aa9f8f87.name])) {
        var_aa9f8f87 = getscriptbundle(level.var_fb9a8536[var_aa9f8f87.name]);
    }
    var_eff83f3 = var_aa9f8f87;
    if (isdefined(level.var_93c59949[var_aa9f8f87.name])) {
        var_cf36f90d = level.var_93c59949[var_aa9f8f87.name];
        for (index = 0; index < var_cf36f90d.size; index++) {
            randindex = function_d59c2d03(var_cf36f90d.size);
            var_ec7042e9 = var_cf36f90d[index];
            var_cf36f90d[index] = var_cf36f90d[randindex];
            var_cf36f90d[randindex] = var_ec7042e9;
        }
        foreach (var_ee110db8 in var_cf36f90d) {
            if (isdefined(var_ee110db8.var_52a66db0)) {
                if (stash.targetname !== var_ee110db8.var_52a66db0) {
                    continue;
                }
            }
            if (var_ee110db8.count == 0) {
                continue;
            }
            var_1dd9b7f1 = getscriptbundle(var_ee110db8.replacement);
            if (var_1dd9b7f1.type !== #"itemspawnlist") {
                assert(0, "<dev string:x83>" + var_ee110db8);
                continue;
            }
            var_eff83f3 = var_1dd9b7f1;
            self.var_b91441dd = var_eff83f3;
            if (var_ee110db8.count > 0) {
                var_ee110db8.count--;
            }
            break;
        }
    }
    stash.var_b91441dd = var_eff83f3;
    if (is_true(var_eff83f3.var_4f220d03)) {
        function_f0e5262b(#"hash_b52c813369f685d", stash, -1, 1, stash.targetname);
        spawncount = 0;
        for (row = 0; row < var_eff83f3.itemlist.size; row++) {
            available = isdefined(var_eff83f3.itemlist[row].available) ? var_eff83f3.itemlist[row].available : 0;
            available = int(max(available, 0));
            spawncount += available;
        }
        stash.available = spawncount;
    } else {
        var_f16b79a = 0;
        for (row = 0; row < var_eff83f3.itemlist.size; row++) {
            if (!isdefined(var_eff83f3.itemlist[row].var_a6762160)) {
                continue;
            }
            var_b91441dd = getscriptbundle(var_eff83f3.itemlist[row].var_a6762160);
            if (var_b91441dd.name == "defaultscriptbundle") {
                continue;
            }
            var_bbe618cc = var_b91441dd.type == #"itemspawnlist" || var_b91441dd.type == #"itemspawnlistalias";
            available = isdefined(var_eff83f3.itemlist[row].available) ? var_eff83f3.itemlist[row].available : 0;
            var_8107154f = [];
            do {
                point = function_53a81463(stash.origin + stash.var_94e291ab, stash.angles, isdefined(stash.targetname) ? stash.targetname : stash.target, "");
                var_8107154f[var_8107154f.size] = point.id;
                if (!var_bbe618cc) {
                    _spawn_item(point, row, 1);
                }
                available--;
            } while (available > 0);
            if (var_bbe618cc) {
                if (var_b91441dd.type == #"itemspawnlistalias") {
                    var_12ab6449 = function_440f0490(var_b91441dd);
                    if (!isdefined(var_12ab6449)) {
                        continue;
                    }
                    var_b91441dd = var_12ab6449;
                }
                if (isdefined(var_b91441dd) && isdefined(level.var_fb9a8536[var_b91441dd.name])) {
                    var_b91441dd = getscriptbundle(level.var_fb9a8536[var_b91441dd.name]);
                }
                itemspawnlist = spawnstruct();
                itemspawnlist.var_b91441dd = var_b91441dd;
                items = itemspawnlist function_e25c9d12(var_f16b79a, var_8107154f, var_8107154f.size, 1);
                var_f16b79a += items.size;
            }
            if (getrealtime() - level.var_d0676b07 > level.var_3e9c9a35) {
                waitframe(1);
                level.var_d0676b07 = getrealtime();
            }
        }
    }
    self.var_b91441dd = var_aa9f8f87;
}

// Namespace namespace_65181344/namespace_65181344
// Params 2, eflags: 0x5 linked
// Checksum 0xb05bf5c8, Offset: 0x1fb0
// Size: 0x8ae
function private function_216a69d6(var_9f19fcb6, reset) {
    dynents = array();
    if (isdefined(self.target)) {
        dynents = getdynentarray(self.target, 1);
    }
    if (isdefined(self.targetname)) {
        var_ed91073b = function_c79d31c4(self.targetname, 1);
        dynents = arraycombine(dynents, var_ed91073b, 1, 0);
    }
    for (index = 0; index < self.points.size; index++) {
        randindex = function_d59c2d03(self.points.size);
        tempid = self.points[index];
        self.points[index] = self.points[randindex];
        self.points[randindex] = tempid;
    }
    if (getrealtime() - level.var_d0676b07 > level.var_3e9c9a35) {
        waitframe(1);
        level.var_d0676b07 = getrealtime();
    }
    var_a31ad4de = isdefined(self.var_b91441dd.var_9b009839) ? self.var_b91441dd.var_9b009839 : 0;
    var_418a2e03 = [];
    foreach (dynent in dynents) {
        level.item_spawn_stashes[level.item_spawn_stashes.size] = dynent;
        dynent.lootlocker = self.var_b91441dd.lootlocker;
        if (is_true(dynent.lootlocker)) {
        }
        randint = function_d59c2d03(100);
        shouldspawn = randint <= var_9f19fcb6;
        if (var_a31ad4de > -1 && var_418a2e03.size >= var_a31ad4de) {
            shouldspawn = 0;
        }
        if (shouldspawn && reset) {
            var_418a2e03[var_418a2e03.size] = dynent;
            continue;
        }
        setdynentenabled(dynent, 0);
        if (isdefined(dynent.fx)) {
            deletefx(0, dynent.fx);
            dynent.fx = undefined;
        }
    }
    if (getrealtime() - level.var_d0676b07 > level.var_3e9c9a35) {
        waitframe(1);
        level.var_d0676b07 = getrealtime();
    }
    var_c041d1bd = 0;
    var_a9826383 = 0;
    for (pointindex = 0; var_c041d1bd < var_418a2e03.size; pointindex++) {
        if (pointindex >= self.points.size) {
            if (var_a9826383) {
                break;
            }
            var_a9826383 = 1;
            pointindex = 0;
        }
        if (self.points[pointindex] == -1) {
            continue;
        }
        point = function_b1702735(self.points[pointindex]);
        if (point.hidetime == -1) {
            continue;
        }
        if (isdefined(self.var_b91441dd.var_7fb0967b) && !var_a9826383) {
            var_1ba7b9c8 = arraysortclosest(level.var_5ce07338, point.origin, 1, 0, self.var_b91441dd.var_7fb0967b);
            if (var_1ba7b9c8.size > 0) {
                continue;
            }
        }
        function_54ca5536(self.points[pointindex], -1);
        self.points[pointindex] = -1;
        dynent = var_418a2e03[var_c041d1bd];
        var_94e291ab = (0, 0, 0);
        if (isdefined(dynent.var_15d44120)) {
            var_94e291ab = getxmodelcenteroffset(dynent.var_15d44120);
        }
        dynent.angles = point.angles;
        dynent.origin = point.origin;
        dynent.var_94e291ab = var_94e291ab;
        dynent.hintstring = self.var_b91441dd.hintstring;
        dynent.displayname = self.var_b91441dd.displayname;
        dynent.var_3d685b35 = isdefined(self.var_b91441dd.var_3d685b35) ? self.var_b91441dd.var_3d685b35 : 0;
        level.var_5ce07338[level.var_5ce07338.size] = dynent;
        targetname = isdefined(dynent.targetname) ? dynent.targetname : dynent.target;
        if (!isdefined(level.var_93d08989[targetname])) {
            level.var_93d08989[targetname] = array();
        }
        var_2a4308b9 = level.var_93d08989[targetname].size;
        level.var_93d08989[targetname][var_2a4308b9] = dynent;
        if (function_ffdbe8c2(dynent) !== 3) {
            setdynentenabled(dynent, 1);
        }
        bundle = function_489009c1(dynent);
        if (isdefined(bundle) && isdefined(bundle.dynentstates) && isdefined(bundle.dynentstates[0])) {
            newstate = bundle.dynentstates[0];
            if (isdefined(newstate.statefx)) {
                if (isdefined(dynent.fx)) {
                    deletefx(0, dynent.fx);
                    dynent.fx = undefined;
                }
                if (newstate.statefx !== #"hash_633319dd8957ddbb") {
                    dynent.fx = playfxondynent(newstate.statefx, dynent);
                }
            }
        }
        self function_ea39d1fa(dynent);
        var_c041d1bd++;
    }
    if (getrealtime() - level.var_d0676b07 > level.var_3e9c9a35) {
        waitframe(1);
        level.var_d0676b07 = getrealtime();
    }
    for (var_63d7a070 = var_c041d1bd; var_63d7a070 < var_418a2e03.size; var_63d7a070++) {
        dynent = var_418a2e03[var_63d7a070];
        setdynentenabled(dynent, 0);
        if (isdefined(dynent.fx)) {
            deletefx(0, dynent.fx);
            dynent.fx = undefined;
        }
    }
}

// Namespace namespace_65181344/namespace_65181344
// Params 1, eflags: 0x5 linked
// Checksum 0xdb35686f, Offset: 0x2868
// Size: 0x9c
function private _spawn(reset) {
    if (is_true(self.var_b91441dd.supplystash)) {
        self function_216a69d6(isdefined(self.var_b91441dd.var_fde72c94) ? self.var_b91441dd.var_fde72c94 : 100, reset);
        return;
    }
    self function_e25c9d12(0, self.var_8107154f, self.var_8107154f.size);
}

// Namespace namespace_65181344/namespace_65181344
// Params 0, eflags: 0x5 linked
// Checksum 0xfb1bd847, Offset: 0x2910
// Size: 0x1fa
function private _setup() {
    self.var_b91441dd = getscriptbundle(self.scriptbundlename);
    if (isdefined(self.var_b91441dd) && isdefined(level.var_fb9a8536[self.var_b91441dd.name])) {
        self.var_b91441dd = getscriptbundle(level.var_fb9a8536[self.var_b91441dd.name]);
    }
    assert(isdefined(self.var_b91441dd), "<dev string:xcb>" + self.scriptbundlename + "<dev string:xdd>");
    if (!isdefined(self.var_b91441dd.itemlist)) {
        self.var_b91441dd.itemlist = [];
    }
    self.remaining = isdefined(self.count) ? self.count : 0;
    self.points = function_d0dc448b(self.target);
    self.var_8107154f = [];
    foreach (pointid in self.points) {
        self.var_8107154f[pointid] = pointid;
    }
    if (!isdefined(level.var_28cd0b1f[self.target]) && self.target !== #"hash_4f6d836b1441bd94") {
    }
    if (!isdefined(self.points)) {
        self.points = [];
    }
}

// Namespace namespace_65181344/namespace_65181344
// Params 0, eflags: 0x5 linked
// Checksum 0x88774555, Offset: 0x2b18
// Size: 0x76
function private _teardown() {
    self.points = undefined;
    self.var_8107154f = undefined;
    self.var_b91441dd = undefined;
    self.angles = undefined;
    self.available = undefined;
    self.var_ccc6d5b7 = undefined;
    self.modelscale = undefined;
    self.remaining = undefined;
    self.var_3ddde668 = undefined;
    self.var_5d3a106 = undefined;
    self.var_202d2992 = undefined;
    self.rows = undefined;
    self.weights = undefined;
    self.weighttotal = undefined;
}

// Namespace namespace_65181344/namespace_65181344
// Params 0, eflags: 0x1 linked
// Checksum 0x6627f06e, Offset: 0x2b98
// Size: 0x44
function function_3095d12a() {
    if (isdefined(level.var_ccc3aaf)) {
        return;
    }
    level.var_ccc3aaf = 1;
    flag::set(#"item_world_traces");
}

// Namespace namespace_65181344/namespace_65181344
// Params 0, eflags: 0x5 linked
// Checksum 0xfbb9d51e, Offset: 0x2be8
// Size: 0xa4
function private function_9db93def() {
    assert(isdefined(self.target) && self.target != "<dev string:xeb>", "<dev string:xef>" + self.origin + "<dev string:x10d>");
    assert(self.target !== self.targetname, "<dev string:xef>" + self.origin + "<dev string:x130>" + self.target + "<dev string:x16d>");
}

// Namespace namespace_65181344/namespace_65181344
// Params 1, eflags: 0x1 linked
// Checksum 0x381b3470, Offset: 0x2c98
// Size: 0x8ca
function function_67456242(var_a6762160) {
    assert(isstruct(var_a6762160));
    assert(var_a6762160.itemtype == #"weapon");
    assert(isdefined(var_a6762160.var_a53e9db0));
    weapon = item_world_util::function_35e06774(var_a6762160, 1);
    attachments = weapon.attachments;
    availableslots = [];
    foreach (slot in array("attachSlotOptics", "attachSlotMuzzle", "attachSlotBarrel", "attachSlotUnderbarrel", "attachSlotBody", "attachSlotMagazine", "attachSlotHandle", "attachSlotStock")) {
        availableslots[slot] = is_true(var_a6762160.(slot));
    }
    foreach (attachment in attachments) {
        var_41ade915 = item_world_util::function_6a0ee21a(attachment);
        var_fe35755b = getscriptbundle(var_41ade915);
        if (!isstruct(var_fe35755b)) {
            assert(0);
            continue;
        }
        foreach (slot in array("attachSlotOptics", "attachSlotMuzzle", "attachSlotBarrel", "attachSlotUnderbarrel", "attachSlotBody", "attachSlotMagazine", "attachSlotHandle", "attachSlotStock")) {
            if (is_true(var_fe35755b.(slot))) {
                availableslots[slot] = 0;
            }
        }
    }
    if (isdefined(var_a6762160.var_a53e9db0)) {
        possibleattachments = var_a6762160.var_a53e9db0;
        var_1f5af2f9 = getarraykeys(possibleattachments);
        for (index = 0; index < possibleattachments.size; index++) {
            randindex = function_d59c2d03(possibleattachments.size);
            tempid = possibleattachments[var_1f5af2f9[randindex]];
            possibleattachments[var_1f5af2f9[randindex]] = possibleattachments[var_1f5af2f9[index]];
            possibleattachments[var_1f5af2f9[index]] = tempid;
        }
        var_a3a56d95 = int(min(var_a6762160.var_8e212f46, possibleattachments.size));
        maxattachments = int(min(var_a6762160.var_d0e99a2a, possibleattachments.size));
        assert(maxattachments >= var_a3a56d95);
        var_5f5def05 = var_a3a56d95;
        var_ac516129 = maxattachments - var_a3a56d95;
        if (var_ac516129 > 0) {
            var_5f5def05 += function_d59c2d03(var_ac516129);
        }
        var_5f5def05 = min(var_5f5def05 - attachments.size, 6);
        for (index = 0; index < possibleattachments.size && attachments.size < var_5f5def05; index++) {
            var_41ade915 = possibleattachments[index].var_6be1bec7;
            var_fe35755b = getscriptbundle(var_41ade915);
            if (!isstruct(var_fe35755b)) {
                assert(0);
                continue;
            }
            var_e77f982 = 1;
            foreach (slot in array("attachSlotOptics", "attachSlotMuzzle", "attachSlotBarrel", "attachSlotUnderbarrel", "attachSlotBody", "attachSlotMagazine", "attachSlotHandle", "attachSlotStock")) {
                if (is_true(var_fe35755b.(slot)) && !is_true(availableslots[slot])) {
                    var_e77f982 = 0;
                    break;
                }
            }
            if (!var_e77f982) {
                continue;
            }
            var_8d5b1d0 = arraycopy(attachments);
            foreach (attachment in var_fe35755b.attachments) {
                var_8d5b1d0[var_8d5b1d0.size] = attachment.var_6be1bec7;
            }
            weapon = getweapon(var_a6762160.weapon.name, var_8d5b1d0);
            weapon = function_1242e467(weapon);
            if (weapon.attachments.size == var_8d5b1d0.size) {
                attachments = var_8d5b1d0;
                foreach (slot in array("attachSlotOptics", "attachSlotMuzzle", "attachSlotBarrel", "attachSlotUnderbarrel", "attachSlotBody", "attachSlotMagazine", "attachSlotHandle", "attachSlotStock")) {
                    if (is_true(var_fe35755b.(slot))) {
                        availableslots[slot] = 0;
                    }
                }
            }
        }
        weapon = getweapon(var_a6762160.weapon.name, attachments);
        weapon = function_1242e467(weapon);
    }
    return weapon;
}

// Namespace namespace_65181344/namespace_65181344
// Params 6, eflags: 0x5 linked
// Checksum 0x2cb7cb52, Offset: 0x3570
// Size: 0x1632
function private function_e25c9d12(var_f16b79a, &var_8107154f, spawncount, stashitem = 0, falling = 2, &var_a1b91de4 = undefined) {
    if (!isstruct(self)) {
        assert(0);
        return;
    }
    /#
        if (isdefined(self.points) && isdefined(self.target)) {
            level.var_2e96a450[self.target] = self.points.size;
        }
    #/
    assert(isstruct(self));
    assert(isarray(var_8107154f));
    assert(isint(spawncount));
    assert(isdefined(self.var_b91441dd));
    assert(!is_true(self.vehiclespawner));
    assert(!is_true(self.supplystash));
    if (spawncount <= 0) {
        return;
    }
    items = [];
    self.rows = isdefined(self.var_b91441dd.itemlist.size) ? self.var_b91441dd.itemlist.size : 0;
    self.count = spawncount;
    self.var_5b4935 = [];
    self.available = [];
    self.weights = [];
    self.weighttotal = 0;
    for (row = 0; row < self.rows; row++) {
        item_name = self.var_b91441dd.itemlist[row].var_a6762160;
        if (!isdefined(item_name) || item_name == "") {
            continue;
        }
        if (isdefined(item_name) && isdefined(level.var_4afb8f5a[item_name])) {
            item_name = level.var_4afb8f5a[item_name];
        }
        var_a6762160 = isdefined(level.var_de3d5d56) && isdefined(level.var_de3d5d56[item_name]) ? level.var_de3d5d56[item_name] : getscriptbundle(item_name);
        if (!isdefined(var_a6762160) || var_a6762160.name == "defaultscriptbundle") {
            self.var_5b4935[row] = 1;
        }
    }
    for (row = 0; row < self.rows; row++) {
        self.available[row] = isdefined(self.var_b91441dd.itemlist[row].available) ? self.var_b91441dd.itemlist[row].available : 0;
        if (is_true(self.var_5b4935[row])) {
            self.available[row] = 0;
        }
        if (self.available[row] != 0) {
            var_35843db5 = isdefined(self.var_b91441dd.itemlist[row].minweight) ? self.var_b91441dd.itemlist[row].minweight : 0;
            var_ccef9e25 = isdefined(self.var_b91441dd.itemlist[row].maxweight) ? self.var_b91441dd.itemlist[row].maxweight : 0;
            minweight = int(min(var_35843db5, var_ccef9e25));
            maxweight = int(max(var_35843db5, var_ccef9e25));
            diff = maxweight - minweight;
            weight = function_d59c2d03(diff + 1) + minweight;
            self.weights[row] = weight;
            self.weighttotal += self.weights[row];
        }
    }
    if (getrealtime() - level.var_d0676b07 > level.var_3e9c9a35) {
        waitframe(1);
        level.var_d0676b07 = getrealtime();
    }
    var_399d601b = spawncount;
    var_413b71b8 = self.weighttotal;
    self.weighttotal = 0;
    for (row = 0; row < self.rows; row++) {
        if (self.available[row] == 0) {
            continue;
        }
        if (self.available[row] < 0) {
            self.weighttotal += self.weights[row];
            continue;
        }
        points = 0;
        if (var_413b71b8 > 0 && var_399d601b > 0) {
            points = self.weights[row] / var_413b71b8 * var_399d601b;
        }
        if (points > self.available[row]) {
            self.weights[row] = 2147483647;
            spawncount -= self.available[row];
            continue;
        }
        self.weighttotal += self.weights[row];
    }
    if (getrealtime() - level.var_d0676b07 > level.var_3e9c9a35) {
        waitframe(1);
        level.var_d0676b07 = getrealtime();
    }
    self.var_202d2992 = [];
    self.var_3ddde668 = [];
    self.var_43feff59 = 0;
    self.var_5d3a106 = 0;
    totalspawncount = spawncount / max(self.weighttotal, 1);
    for (row = 0; row < self.rows; row++) {
        if (self.available[row] != 0) {
            if (self.weights[row] == 2147483647) {
                points = self.available[row];
            } else {
                points = self.weights[row] * totalspawncount;
            }
            self.var_202d2992[row] = int(floor(points));
            self.var_3ddde668[row] = int((points - self.var_202d2992[row]) * 1000);
            self.var_43feff59 += self.var_202d2992[row];
            self.var_5d3a106 += self.var_3ddde668[row];
        }
    }
    if (getrealtime() - level.var_d0676b07 > level.var_3e9c9a35) {
        waitframe(1);
        level.var_d0676b07 = getrealtime();
    }
    arrayremovevalue(self.var_202d2992, 0, 1);
    arrayremovevalue(self.var_3ddde668, 0, 1);
    assert(self.var_43feff59 <= var_399d601b);
    var_c499a7fa = getarraykeys(self.var_3ddde668);
    if (self.var_5d3a106 > 0) {
        for (pointindex = self.var_43feff59; pointindex < spawncount && self.var_5d3a106 > 0; pointindex++) {
            randomval = function_d59c2d03(self.var_5d3a106);
            var_28ef6352 = 0;
            for (var_56c03814 = 0; var_56c03814 < self.var_3ddde668.size; var_56c03814++) {
                var_75aa5cbb = var_c499a7fa[var_c499a7fa.size - var_56c03814 - 1];
                if (self.available[var_75aa5cbb] != 0) {
                    var_cc5fea3d = var_28ef6352 + self.var_3ddde668[var_75aa5cbb];
                    if (var_28ef6352 <= randomval && randomval <= var_cc5fea3d) {
                        self.var_5d3a106 -= self.var_3ddde668[var_75aa5cbb];
                        self.var_3ddde668[var_75aa5cbb] = 0;
                        self.var_202d2992[var_75aa5cbb] = (isdefined(self.var_202d2992[var_75aa5cbb]) ? self.var_202d2992[var_75aa5cbb] : 0) + 1;
                        self.var_43feff59++;
                        break;
                    }
                    var_28ef6352 = var_cc5fea3d;
                }
            }
        }
    }
    if (getrealtime() - level.var_d0676b07 > level.var_3e9c9a35) {
        waitframe(1);
        level.var_d0676b07 = getrealtime();
    }
    assert(self.var_43feff59 <= var_399d601b);
    if (!isdefined(var_a1b91de4)) {
        var_a1b91de4 = getarraykeys(var_8107154f);
        for (index = 0; index < var_8107154f.size; index++) {
            randindex = function_d59c2d03(var_8107154f.size);
            tempid = var_8107154f[var_a1b91de4[randindex]];
            var_8107154f[var_a1b91de4[randindex]] = var_8107154f[var_a1b91de4[index]];
            var_8107154f[var_a1b91de4[index]] = tempid;
        }
    }
    if (getrealtime() - level.var_d0676b07 > level.var_3e9c9a35) {
        waitframe(1);
        level.var_d0676b07 = getrealtime();
    }
    self.var_ccc6d5b7 = [];
    var_7a7ab6bf = 0;
    var_a9826383 = 0;
    arraykeys = getarraykeys(self.var_202d2992);
    var_f5111345 = 0;
    for (pointindex = 0; var_f5111345 < arraykeys.size && var_7a7ab6bf < self.count; pointindex++) {
        if (getrealtime() - level.var_d0676b07 > level.var_3e9c9a35) {
            waitframe(1);
            level.var_d0676b07 = getrealtime();
        }
        var_75aa5cbb = arraykeys[var_f5111345];
        if (pointindex >= var_8107154f.size) {
            assert(var_a9826383 === 0);
            var_a9826383 = 1;
            pointindex = 0;
        }
        if (var_8107154f[var_a1b91de4[pointindex]] == -1) {
            continue;
        }
        var_a6762160 = self.var_b91441dd.itemlist[var_75aa5cbb].var_a6762160;
        if (isdefined(var_a6762160) && var_a6762160 != "") {
            scriptbundle = isdefined(level.var_de3d5d56) && isdefined(level.var_de3d5d56[var_a6762160]) ? level.var_de3d5d56[var_a6762160] : getscriptbundle(var_a6762160);
            if (isdefined(scriptbundle) && isdefined(scriptbundle.type) && (scriptbundle.type == #"itemspawnlist" || scriptbundle.type == #"itemspawnlistalias")) {
                self.var_ccc6d5b7[var_75aa5cbb] = self.var_202d2992[var_75aa5cbb];
                self.var_202d2992[var_75aa5cbb] = 0;
                var_f5111345++;
                continue;
            }
        }
        if (var_8107154f[var_a1b91de4[pointindex]] == -2) {
            spawnitems = self function_35461e5f(var_f16b79a + items.size, var_75aa5cbb, stashitem, falling);
            items = arraycombine(items, spawnitems, 1, 0);
        } else {
            itemspawnpoint = function_b1702735(var_8107154f[var_a1b91de4[pointindex]]);
            if (isdefined(self.var_b91441dd.var_7fb0967b) && !var_a9826383) {
                var_8822f354 = 0;
                itemtype = undefined;
                if (isdefined(var_a6762160)) {
                    scriptbundle = isdefined(level.var_de3d5d56) && isdefined(level.var_de3d5d56[var_a6762160]) ? level.var_de3d5d56[var_a6762160] : getscriptbundle(var_a6762160);
                    if (isdefined(scriptbundle)) {
                        itemtype = scriptbundle.itemtype;
                    }
                }
                if (isdefined(self.var_b91441dd.var_dc7ffbef) && isdefined(itemtype)) {
                    if (itemtype == #"vehicle") {
                    } else {
                        var_f4b807cb = function_abaeb170(itemspawnpoint.origin, undefined, undefined, self.var_b91441dd.var_7fb0967b, -1, 1, -2147483647);
                        for (var_55879fe2 = 0; var_55879fe2 < var_f4b807cb.size; var_55879fe2++) {
                            if (isdefined(var_f4b807cb[var_55879fe2]) && isdefined(var_f4b807cb[var_55879fe2].var_a6762160) && var_f4b807cb[var_55879fe2].var_a6762160.itemtype == itemtype) {
                                var_8822f354++;
                                break;
                            }
                        }
                        var_f4b807cb = [];
                    }
                } else {
                    var_8822f354 = function_6de8969b(itemspawnpoint.origin, undefined, self.var_b91441dd.var_7fb0967b, -1, 1, -2147483647);
                }
                if (var_8822f354 > 0) {
                    continue;
                }
            }
            self _spawn_item(itemspawnpoint, var_75aa5cbb, stashitem);
        }
        var_8107154f[var_a1b91de4[pointindex]] = -1;
        self.var_202d2992[var_75aa5cbb]--;
        var_7a7ab6bf++;
        if (self.var_202d2992[var_75aa5cbb] == 0) {
            var_f5111345++;
        }
    }
    if (getrealtime() - level.var_d0676b07 > level.var_3e9c9a35) {
        waitframe(1);
        level.var_d0676b07 = getrealtime();
    }
    for (index = 0; index < self.var_b91441dd.itemlist.size; index++) {
        if (!isdefined(self.var_ccc6d5b7[index])) {
            continue;
        }
        itemlist = self.var_b91441dd.itemlist[index];
        if (!isdefined(itemlist.var_a6762160) || itemlist.var_a6762160 === "") {
            continue;
        }
        var_b91441dd = getscriptbundle(itemlist.var_a6762160);
        if (!isdefined(var_b91441dd.type) || var_b91441dd.type != #"itemspawnlist" && var_b91441dd.type != #"itemspawnlistalias") {
            continue;
        }
        if (var_b91441dd.type == #"itemspawnlistalias") {
            var_12ab6449 = function_440f0490(var_b91441dd);
            if (!isdefined(var_12ab6449)) {
                continue;
            }
            var_b91441dd = var_12ab6449;
        }
        if (isdefined(var_b91441dd) && isdefined(level.var_fb9a8536[var_b91441dd.name])) {
            var_12ab6449 = getscriptbundle(level.var_fb9a8536[var_b91441dd.name]);
            if (!isdefined(var_12ab6449)) {
                println("<dev string:x173>" + var_b91441dd.name);
                assert(0);
                continue;
            }
            var_b91441dd = var_12ab6449;
        }
        if (isdefined(level.var_9af526f0) && var_b91441dd.name !== level.var_9af526f0 && getdvarint(#"hash_362cb8a4f269c52c", 0) == 0) {
            var_45749876 = function_d59c2d03(100);
            if (!isdefined(level.var_50cd96dc)) {
                level.var_50cd96dc = 0;
            }
            level.var_50cd96dc++;
            if (var_45749876 < (isdefined(level.var_546946af) ? level.var_546946af : 100)) {
                var_3224b39a = 0;
                if (isdefined(var_b91441dd.itemlist) && var_b91441dd.itemlist.size > 0 && isdefined(var_b91441dd.itemlist[0].var_a6762160)) {
                    var_9c6a2603 = getscriptbundle(var_b91441dd.itemlist[0].var_a6762160);
                    var_3224b39a = var_9c6a2603.type !== "itemspawnlist";
                }
                if (var_3224b39a) {
                    var_b91441dd = getscriptbundle(level.var_9af526f0);
                }
            }
        }
        itemspawnlist = spawnstruct();
        itemspawnlist.var_b91441dd = var_b91441dd;
        itemspawnlist.origin = self.origin;
        itemspawnlist.angles = self.angles;
        var_4168f4f3 = itemspawnlist function_e25c9d12(var_f16b79a + items.size, var_8107154f, self.var_ccc6d5b7[index], stashitem, falling, var_a1b91de4);
        items = arraycombine(items, var_4168f4f3, 1, 0);
    }
    return items;
}

// Namespace namespace_65181344/namespace_65181344
// Params 0, eflags: 0x1 linked
// Checksum 0x7964bee5, Offset: 0x4bb0
// Size: 0x13c
function function_62fdaf9e() {
    if (isarray(level.struct)) {
        foreach (key, value in level.struct) {
            if (!isdefined(value)) {
                continue;
            }
            if (isdefined(value.classname) && value.classname == #"scriptbundle_itemspawnlist") {
                level.struct[key] = undefined;
            }
            if (getrealtime() - level.var_d0676b07 > level.var_3e9c9a35) {
                waitframe(1);
                level.var_d0676b07 = getrealtime();
            }
        }
        arrayremovevalue(level.struct, undefined, 0);
    }
}

// Namespace namespace_65181344/namespace_65181344
// Params 0, eflags: 0x1 linked
// Checksum 0xedce0da3, Offset: 0x4cf8
// Size: 0x4c
function init_spawn_system() {
    level.var_d0676b07 = getrealtime();
    level.var_3e9c9a35 = 4;
    function_2c4d3d40();
    function_3095d12a();
}

// Namespace namespace_65181344/namespace_65181344
// Params 0, eflags: 0x1 linked
// Checksum 0xb0f2fd1c, Offset: 0x4d50
// Size: 0x298
function reset_items() {
    originalpoints = function_c77ddcd6();
    for (pointid = 0; pointid < originalpoints; pointid++) {
        point = function_b1702735(pointid);
        var_a6762160 = point.var_a6762160;
        if (!isdefined(var_a6762160)) {
            continue;
        }
        origin = point.origin;
        angles = point.angles;
        angles = function_bdd10bae(angles, (isdefined(var_a6762160.var_7adcadc1) ? var_a6762160.var_7adcadc1 : 0, isdefined(var_a6762160.var_6731866b) ? var_a6762160.var_6731866b : 0, isdefined(var_a6762160.var_e6ac0592) ? var_a6762160.var_e6ac0592 : 0));
        if (!isdefined(var_a6762160.var_47f145b4)) {
            angles = function_bdd10bae(angles, (0, angleclamp180(origin[0] + origin[1] + origin[2]), 0));
        }
        originoffset = ((isdefined(var_a6762160.var_ada071fe) ? var_a6762160.var_ada071fe : 0) * -1, (isdefined(var_a6762160.var_5ab74bb1) ? var_a6762160.var_5ab74bb1 : 0) * -1, (isdefined(var_a6762160.var_50773731) ? var_a6762160.var_50773731 : 0) * -1);
        origin += originoffset;
        function_b97dfce0(point.id, origin);
        function_3eab95b5(point.id, angles);
        if (getrealtime() - level.var_d0676b07 > level.var_3e9c9a35) {
            waitframe(1);
            level.var_d0676b07 = getrealtime();
        }
    }
    function_682385e7();
    level.item_spawn_drops = [];
}

// Namespace namespace_65181344/namespace_65181344
// Params 0, eflags: 0x1 linked
// Checksum 0xedb679f5, Offset: 0x4ff0
// Size: 0xca
function function_ca77960f() {
    var_1d9375fc = struct::get_array("scriptbundle_itemspawnlist", "classname");
    if (isdefined(level.var_9af526f0)) {
        var_52096b93 = spawnstruct();
        var_52096b93.scriptbundlename = level.var_9af526f0;
        var_52096b93.angles = (0, 0, 0);
        var_52096b93.origin = (0, 0, 0);
        var_52096b93.classname = "scriptbundle_itemspawnlist";
        var_52096b93.count = -1;
        var_52096b93.modelscale = 1;
        var_52096b93.target = #"hash_4f6d836b1441bd94";
        var_1d9375fc[var_1d9375fc.size] = var_52096b93;
    }
    return var_1d9375fc;
}

// Namespace namespace_65181344/namespace_65181344
// Params 3, eflags: 0x1 linked
// Checksum 0x6e9990ed, Offset: 0x50c8
// Size: 0x30c
function function_50a2c746(&var_f38d5b52, reset = 1, var_87e9f374 = 0) {
    assert(isarray(var_f38d5b52));
    /#
        if (var_87e9f374) {
        }
    #/
    var_1d9375fc = function_ca77960f();
    foreach (group in var_1d9375fc) {
        if (!isdefined(group.target)) {
            continue;
        }
        var_b91441dd = getscriptbundle(group.scriptbundlename);
        if (isdefined(var_b91441dd) && isdefined(level.var_fb9a8536[var_b91441dd.name])) {
            var_b91441dd = getscriptbundle(level.var_fb9a8536[var_b91441dd.name]);
        }
        if (!isdefined(var_b91441dd)) {
            continue;
        }
        if (var_87e9f374) {
            if (!is_true(var_b91441dd.var_dc91e192) || !is_true(var_b91441dd.supplystash)) {
                continue;
            }
        } else if (is_true(var_b91441dd.var_dc91e192) && is_true(var_b91441dd.supplystash)) {
            continue;
        }
        if (isdefined(var_f38d5b52[group.target])) {
            if (!is_true(var_b91441dd.supplystash)) {
                continue;
            }
        }
        var_f38d5b52[group.target] = 1;
        group function_9db93def();
        group _setup();
        group _spawn(reset);
        group _teardown();
        if (getrealtime() - level.var_d0676b07 > level.var_3e9c9a35) {
            waitframe(1);
            level.var_d0676b07 = getrealtime();
        }
    }
    return var_f38d5b52;
}

// Namespace namespace_65181344/namespace_65181344
// Params 0, eflags: 0x5 linked
// Checksum 0x70341773, Offset: 0x53e0
// Size: 0x5c
function private function_4233b851() {
    /#
        if (!isdefined(level.var_55f723bd)) {
            level.var_3683df16 = 0;
            level.var_3062619 = "<dev string:xeb>";
            level.var_55f723bd = openfile("<dev string:x1bd>", "<dev string:x1dc>");
        }
    #/
}

// Namespace namespace_65181344/namespace_65181344
// Params 1, eflags: 0x1 linked
// Checksum 0xa6377839, Offset: 0x5448
// Size: 0x764
function setup_groups(reset = 1) {
    self notify("1c23aec1cac89d9");
    self endon("1c23aec1cac89d9");
    while (level.var_21f73755 !== 1) {
        waitframe(1);
    }
    if (reset) {
        level flag::set(#"hash_67b445a4b1d59922");
    } else {
        level flag::set(#"hash_11c9cde7b522c5a9");
    }
    flag::wait_till(#"item_world_traces");
    function_4233b851();
    /#
        if (reset) {
        }
    #/
    starttime = gettime();
    level.var_d0676b07 = getrealtime();
    level.var_4afb8f5a = reset ? level.itemreplacement : level.var_ee46a98d;
    foreach (key, value in level.var_4afb8f5a) {
    }
    level.var_fb9a8536 = reset ? level.var_ee110db8 : level.var_db0e7b82;
    foreach (value in level.var_fb9a8536) {
    }
    if (!isdefined(level.var_28cd0b1f)) {
        level.var_28cd0b1f = [];
    }
    if (reset) {
        reset_items();
    }
    function_e88ecf7f();
    function_9e9f43cd();
    level.item_spawn_stashes = [];
    level.var_5ce07338 = [];
    level.var_93d08989 = [];
    level.item_vehicles = [];
    level.var_8819644a = [];
    level.var_cc113617 = [-130, 50, 120, 315, 225, 270];
    level.var_82e94a26 = [1:10, 2:-5, 3:-15, 4:5, 5:0];
    level.var_69dda516 = [17, 34, 32, 25, 25, 25];
    /#
        level.var_136445c0 = 0;
        level.var_d80c35aa = [];
        level.var_5720c09a = 0;
        level.var_8d9ad8e8 = [];
        level.var_2850ef5 = 0;
        level.var_ecf16fd3 = [];
        level.var_f2db6a7f = 0;
    #/
    var_f38d5b52 = [];
    function_50a2c746(var_f38d5b52, reset, 1);
    if (getrealtime() - level.var_d0676b07 > level.var_3e9c9a35) {
        waitframe(1);
        level.var_d0676b07 = getrealtime();
    }
    function_50a2c746(var_f38d5b52, reset, 0);
    /#
        level.var_a7247d85 = function_8322cf16();
        level.var_66e56764 = level.var_136445c0 + level.var_5720c09a + level.var_2850ef5;
        level.var_efeab371 = [];
        foreach (type, count in level.var_d80c35aa) {
            level.var_efeab371[type] = (isdefined(count) ? count : 0) + (isdefined(level.var_8d9ad8e8[type]) ? level.var_8d9ad8e8[type] : 0) + (isdefined(level.var_ecf16fd3[type]) ? level.var_ecf16fd3[type] : 0);
        }
    #/
    /#
        foreach (type, count in level.var_efeab371) {
        }
    #/
    if (reset) {
        function_62fdaf9e();
        function_6a5c090c();
    }
    var_282e0a11 = function_d59c2d03(65536 - 1);
    /#
        if (reset) {
            closefile(level.var_55f723bd);
            level.var_55f723bd = undefined;
        }
    #/
    level.var_f1f90fd3 = float(gettime() - starttime) / 1000;
    /#
        println("<dev string:x1e5>" + var_282e0a11);
        println("<dev string:x20b>" + (isdefined(level.var_ac56bfa4) ? level.var_ac56bfa4 : "<dev string:x23d>"));
        if (level.var_ac56bfa4 === var_282e0a11) {
            println("<dev string:x24a>");
            return;
        }
        println("<dev string:x27f>");
    #/
}

// Namespace namespace_65181344/namespace_65181344
// Params 2, eflags: 0x0
// Checksum 0xcf303252, Offset: 0x5bb8
// Size: 0x546
function function_5eada592(scriptbundlename, linkto = 1) {
    if (!isdefined(self)) {
        assert(0);
        return;
    }
    if (!isdefined(scriptbundlename)) {
        assert(0);
        return;
    }
    self.var_b91441dd = getscriptbundle(scriptbundlename);
    if (!isdefined(self.var_b91441dd)) {
        assert(0);
        return;
    }
    items = [];
    if (is_true(self.var_b91441dd.var_4f220d03)) {
        item = function_62c0d32d(0, #"hash_b52c813369f685d", 1, 1);
        items[items.size] = item;
        spawncount = 0;
        for (row = 0; row < self.var_b91441dd.itemlist.size; row++) {
            available = isdefined(self.var_b91441dd.itemlist[row].available) ? self.var_b91441dd.itemlist[row].available : 0;
            available = int(max(available, 0));
            spawncount += available;
        }
        self.available = spawncount;
    } else {
        for (row = 0; row < self.var_b91441dd.itemlist.size; row++) {
            if (!isdefined(self.var_b91441dd.itemlist[row].var_a6762160)) {
                continue;
            }
            var_b91441dd = getscriptbundle(self.var_b91441dd.itemlist[row].var_a6762160);
            var_bbe618cc = var_b91441dd.type == #"itemspawnlist" || var_b91441dd.type == #"itemspawnlistalias";
            available = isdefined(self.var_b91441dd.itemlist[row].available) ? self.var_b91441dd.itemlist[row].available : 0;
            var_8107154f = [];
            do {
                var_8107154f[var_8107154f.size] = -2;
                if (!var_bbe618cc) {
                    spawnitems = function_35461e5f(items.size, row, 1, 1);
                    items = arraycombine(items, spawnitems, 1, 0);
                }
                available--;
            } while (available > 0);
            if (var_bbe618cc) {
                if (var_b91441dd.type == #"itemspawnlistalias") {
                    var_12ab6449 = function_440f0490(var_b91441dd);
                    if (!isdefined(var_12ab6449)) {
                        continue;
                    }
                    var_b91441dd = var_12ab6449;
                }
                if (isdefined(var_b91441dd) && isdefined(level.var_fb9a8536[var_b91441dd.name])) {
                    var_b91441dd = getscriptbundle(level.var_fb9a8536[var_b91441dd.name]);
                }
                itemspawnlist = spawnstruct();
                itemspawnlist.var_b91441dd = var_b91441dd;
                spawnitems = itemspawnlist function_e25c9d12(items.size, var_8107154f, var_8107154f.size, 1);
                items = arraycombine(items, spawnitems, 1, 0);
            }
        }
    }
    foreach (item in items) {
        if (!isdefined(item)) {
            continue;
        }
        item.targetnamehash = self.targetname;
        item.origin = self.origin;
        if (linkto) {
            item linkto(self);
        }
        item.spawning = 0;
    }
    return items;
}

// Namespace namespace_65181344/namespace_65181344
// Params 3, eflags: 0x0
// Checksum 0x9d5f2f33, Offset: 0x6108
// Size: 0x3a0
function function_fd87c780(scriptbundlename, itemcount, falling = 2) {
    if (!isdefined(self)) {
        assert(0);
        return;
    }
    if (!isdefined(scriptbundlename)) {
        assert(0);
        return;
    }
    if (!isint(itemcount) || itemcount <= 0) {
        assert(0);
        return;
    }
    scriptbundle = getscriptbundle(scriptbundlename);
    if (!isdefined(scriptbundle)) {
        assert(0);
        return;
    }
    assert(isdefined(self.origin));
    itemgroup = spawnstruct();
    itemgroup.var_b91441dd = scriptbundle;
    itemgroup.origin = self.origin;
    itemgroup.angles = isdefined(self.angles) ? self.angles : (0, 0, 0);
    if (isvec(self.anglesoffset)) {
        itemgroup.angles += self.anglesoffset;
    }
    var_8107154f = [];
    for (pointid = 0; pointid < itemcount; pointid++) {
        var_8107154f[var_8107154f.size] = -2;
    }
    items = itemgroup function_e25c9d12(0, var_8107154f, var_8107154f.size, 0, falling);
    foreach (item in items) {
        item.spawning = 0;
        if (isentity(item) && isdefined(item.var_627c698b.attachments) && !isdefined(item.attachments)) {
            attachments = item.var_627c698b.attachments;
            foreach (attachment in attachments) {
                var_41ade915 = item_world_util::function_6a0ee21a(attachment);
                attachmentitem = function_4ba8fde(var_41ade915);
                namespace_a0d533d1::function_8b7b98f(item, attachmentitem);
            }
        }
    }
    return items;
}

