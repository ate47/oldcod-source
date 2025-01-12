#using scripts\core_common\flagsys_shared;
#using scripts\core_common\struct;
#using scripts\mp_common\item_drop;
#using scripts\mp_common\item_world_util;

#namespace namespace_f68e9756;

// Namespace namespace_f68e9756/namespace_f68e9756
// Params 0, eflags: 0x4
// Checksum 0xad58bd58, Offset: 0x110
// Size: 0x116
function private function_c3cb2fe4() {
    var_4c7796af = getscriptbundles("itemspawnentry");
    var_18d66fde = function_a6df0c16();
    index = 0;
    offsetorigin = (0, 0, -64000);
    foreach (var_e0466e8d, var_eb1267ac in var_4c7796af) {
        function_825389f7(index, var_e0466e8d);
        function_98497bc7(index, 1);
        function_1ef8cb12(index, offsetorigin);
        index++;
    }
}

// Namespace namespace_f68e9756/namespace_f68e9756
// Params 1, eflags: 0x0
// Checksum 0x5f48810a, Offset: 0x230
// Size: 0x46
function function_a19b8c4(origin) {
    return (0, angleclamp180(origin[0] + origin[1] + origin[2]), 0);
}

// Namespace namespace_f68e9756/namespace_f68e9756
// Params 0, eflags: 0x4
// Checksum 0x735ec43f, Offset: 0x280
// Size: 0xe2
function private function_42e443c() {
    assert(self.points.size > 0, "<dev string:x30>");
    var_11632de2 = function_5531c064(self.points.size);
    var_52283e7b = self.points[var_11632de2];
    self.points[var_11632de2] = self.points[self.points.size - 1];
    self.points[self.points.size - 1] = undefined;
    point = function_9c3c6ff2(var_52283e7b);
    return point;
}

// Namespace namespace_f68e9756/namespace_f68e9756
// Params 2, eflags: 0x4
// Checksum 0x72932e83, Offset: 0x370
// Size: 0x22
function private function_5fea8372(row, stashitem = 0) {
    
}

// Namespace namespace_f68e9756/namespace_f68e9756
// Params 2, eflags: 0x4
// Checksum 0x441c3f1b, Offset: 0x3a0
// Size: 0x22
function private function_40602803(item_name, stashitem = 0) {
    
}

// Namespace namespace_f68e9756/namespace_f68e9756
// Params 3, eflags: 0x4
// Checksum 0x4954f6c4, Offset: 0x3d0
// Size: 0x5de
function private _spawn_item(point, row, stashitem = 0) {
    /#
        if (isdefined(self.points) && isdefined(self.target)) {
            level.var_1ec2e08[self.target] = self.points.size;
        }
    #/
    if (!isdefined(point)) {
        return;
    }
    item_name = self.itemlistbundle.itemlist[row].itementry;
    if (!isdefined(item_name) || item_name == "") {
        function_825389f7(point.id, "");
        if (!isdefined(level.var_e8a238c0[#"blank"])) {
            level.var_e8a238c0[#"blank"] = 0;
        }
        level.var_e8a238c0[#"blank"]++;
        return;
    }
    itementry = getscriptbundle(item_name);
    if (!stashitem) {
        if (!isdefined(level.var_e8a238c0[itementry.itemtype])) {
            level.var_e8a238c0[itementry.itemtype] = 0;
        }
        level.var_e8a238c0[itementry.itemtype]++;
    }
    if (itementry.itemtype === "backpack") {
        level.var_ba0c7ff7 = point.id;
    } else if (itementry.itemtype === "blank") {
        function_825389f7(point.id, "");
        return;
    } else if (itementry.itemtype === "vehicle") {
        function_825389f7(point.id, "");
        level.var_4b9cc2c2++;
        waitframe(1);
        return;
    } else if (isdefined(itementry.weapon) && itementry.weapon.name == #"hatchet") {
        level.var_42b4036a = point.id;
    } else if (isdefined(itementry.weapon) && itementry.weapon.name == #"basketball") {
        level.var_e2e52904 = point.id;
    }
    origin = point.origin;
    angles = point.angles;
    originoffset = (isdefined(itementry.positionoffsetx) ? itementry.positionoffsetx : 0, isdefined(itementry.positionoffsety) ? itementry.positionoffsety : 0, isdefined(itementry.positionoffsetz) ? itementry.positionoffsetz : 0);
    origin += originoffset;
    if (!stashitem) {
        angles = combineangles(angles, function_a19b8c4(origin));
        angles = combineangles(angles, (isdefined(itementry.angleoffsetx) ? itementry.angleoffsetx : 0, isdefined(itementry.angleoffsety) ? itementry.angleoffsety : 0, isdefined(itementry.angleoffsetz) ? itementry.angleoffsetz : 0));
    }
    function_825389f7(point.id, item_name);
    function_1ef8cb12(point.id, origin);
    function_bce96614(point.id, angles);
    point.angles = angles;
    if (stashitem) {
        function_98497bc7(point.id, -1);
        if (!isdefined(level.var_b4fb55ee[itementry.itemtype])) {
            level.var_b4fb55ee[itementry.itemtype] = 0;
        }
        level.var_b4fb55ee[itementry.itemtype]++;
        level.var_c8f26663++;
    } else {
        level.var_ec72fe2d++;
    }
    for (index = 1; index <= 5; index++) {
        function_55267fc4(point, row, index, stashitem, point.targetname);
    }
}

// Namespace namespace_f68e9756/namespace_f68e9756
// Params 5, eflags: 0x4
// Checksum 0x38d9d0f5, Offset: 0x9b8
// Size: 0x558
function private function_55267fc4(point, row, childindex, stashitem = 0, targetname) {
    item_name = self.itemlistbundle.itemlist[row].("childitementry_" + childindex);
    if (isdefined(item_name)) {
        degrees = [1:300, 2:240, 3:45, 4:135, 5:90];
        distances = [1:16, 2:16, 3:22, 4:22, 5:22];
        itementry = getscriptbundle(item_name);
        offset = (0, 0, 0);
        angles = (0, 0, 0);
        origin = point.origin;
        if (!stashitem) {
            assert(childindex > 0 && childindex <= 5);
            parentangles = (0, point.angles[1], 0);
            degree = degrees[childindex];
            distance = distances[childindex];
            offset = (cos(degree) * distance, sin(degree) * distance, 0);
            offset = rotatepoint(offset, parentangles);
            origin += offset;
            ground_pos = physicstraceex(origin + (0, 0, 24), origin - (0, 0, 96), (0, 0, 0), (0, 0, 0), undefined, 32);
            var_ee47ad67 = (0, 0, 0);
            final_pos = ground_pos[#"position"] + var_ee47ad67;
            var_2d019a81 = (isdefined(itementry.positionoffsetx) ? itementry.positionoffsetx : 0, isdefined(itementry.positionoffsety) ? itementry.positionoffsety : 0, isdefined(itementry.positionoffsetz) ? itementry.positionoffsetz : 0);
            origin = final_pos + var_2d019a81;
            normal = ground_pos[#"normal"];
            angles += function_a19b8c4(offset);
            angles += (0, point.angles[1], 0);
            angles = function_f828c08c(angles, normal);
            angles = combineangles(angles, (isdefined(itementry.angleoffsetx) ? itementry.angleoffsetx : 0, isdefined(itementry.angleoffsety) ? itementry.angleoffsety : 0, isdefined(itementry.angleoffsetz) ? itementry.angleoffsetz : 0));
            if (level.var_c27994fc % 25 == 0) {
                waitframe(1);
            }
        }
        var_4284f6f5 = function_e43a7685(origin, angles, targetname, item_name);
        if (stashitem) {
            function_98497bc7(var_4284f6f5.id, -1);
            if (!isdefined(level.var_b4fb55ee[itementry.itemtype])) {
                level.var_b4fb55ee[itementry.itemtype] = 0;
            }
            level.var_b4fb55ee[itementry.itemtype]++;
            level.var_c8f26663++;
            return;
        }
        if (!isdefined(level.var_8531ea67[itementry.itemtype])) {
            level.var_8531ea67[itementry.itemtype] = 0;
        }
        level.var_8531ea67[itementry.itemtype]++;
        level.var_c27994fc++;
    }
}

// Namespace namespace_f68e9756/namespace_f68e9756
// Params 1, eflags: 0x4
// Checksum 0x930d00a4, Offset: 0xf18
// Size: 0x206
function private function_757c056e(stash) {
    for (row = 0; row < self.itemlistbundle.itemlist.size; row++) {
        if (!isdefined(self.itemlistbundle.itemlist[row].itementry)) {
            continue;
        }
        itemlistbundle = getscriptbundle(self.itemlistbundle.itemlist[row].itementry);
        var_6ba7dc26 = itemlistbundle.type === "itemspawnlist";
        available = isdefined(self.itemlistbundle.itemlist[row].available) ? self.itemlistbundle.itemlist[row].available : 0;
        var_d9190a12 = [];
        do {
            point = function_e43a7685(stash.origin, stash.angles, stash.targetname, "");
            var_d9190a12[var_d9190a12.size] = point.id;
            if (!var_6ba7dc26) {
                _spawn_item(point, row, 1);
            }
            available--;
        } while (available > 0);
        if (var_6ba7dc26) {
            itemspawnlist = spawnstruct();
            itemspawnlist.itemlistbundle = itemlistbundle;
            itemspawnlist function_1fa8c068(var_d9190a12, var_d9190a12.size, 1);
        }
    }
}

// Namespace namespace_f68e9756/namespace_f68e9756
// Params 2, eflags: 0x4
// Checksum 0xe1ce23fd, Offset: 0x1128
// Size: 0x1d0
function private function_2847494b(spawnchance, reset) {
    dynents = getdynentarray(self.target);
    foreach (dynent in dynents) {
        level.item_spawn_stashes[level.item_spawn_stashes.size] = dynent;
        shouldspawn = function_5531c064(100) <= spawnchance;
        if (shouldspawn && reset && self.points.size > 0) {
            point = function_42e443c();
            dynent.angles = point.angles;
            dynent.origin = point.origin;
            dynent.hintstring = self.itemlistbundle.hintstring;
            if (function_7f51b166(dynent) !== 3) {
                setdynentenabled(dynent, 1);
            }
            self function_757c056e(dynent);
            continue;
        }
        setdynentenabled(dynent, 0);
    }
}

// Namespace namespace_f68e9756/namespace_f68e9756
// Params 1, eflags: 0x4
// Checksum 0x1a96b004, Offset: 0x1300
// Size: 0x9c
function private _spawn(reset) {
    if (isdefined(self.itemlistbundle.supplystash) && self.itemlistbundle.supplystash) {
        self function_2847494b(isdefined(self.itemlistbundle.var_7e86bc5b) ? self.itemlistbundle.var_7e86bc5b : 100, reset);
        return;
    }
    self function_1fa8c068(self.var_d9190a12, self.var_d9190a12.size);
}

// Namespace namespace_f68e9756/namespace_f68e9756
// Params 0, eflags: 0x4
// Checksum 0x1288f22d, Offset: 0x13a8
// Size: 0x1b4
function private _setup() {
    self.itemlistbundle = getscriptbundle(self.scriptbundlename);
    assert(isdefined(self.itemlistbundle), "<dev string:x49>" + self.scriptbundlename + "<dev string:x58>");
    assert(isdefined(self.itemlistbundle.itemlist), "<dev string:x49>" + self.scriptbundlename + "<dev string:x63>");
    self.remaining = isdefined(self.count) ? self.count : 0;
    self.points = function_69874da8(self.target);
    self.var_d9190a12 = [];
    foreach (pointid in self.points) {
        self.var_d9190a12[pointid] = pointid;
    }
    assert(isdefined(self.points) && self.points.size > 0, "<dev string:x6d>" + self.target + "<dev string:xad>" + self.itemlistbundle.name);
}

// Namespace namespace_f68e9756/namespace_f68e9756
// Params 0, eflags: 0x4
// Checksum 0x7f4d7063, Offset: 0x1568
// Size: 0x16
function private _teardown() {
    self.points = undefined;
    self.var_d9190a12 = undefined;
}

// Namespace namespace_f68e9756/namespace_f68e9756
// Params 0, eflags: 0x0
// Checksum 0x2b575f19, Offset: 0x1588
// Size: 0x1cc
function function_56c1e1cf() {
    if (isdefined(level.var_a8c22bda)) {
        return;
    }
    level.var_a8c22bda = 1;
    var_11fcbdfa = function_74d8e06a();
    for (pointid = 0; pointid < var_11fcbdfa; pointid++) {
        point = function_9c3c6ff2(pointid);
        origin = point.origin;
        ground_pos = physicstraceex(origin + (0, 0, 24), origin - (0, 0, 96), (0, 0, 0), (0, 0, 0), undefined, 32);
        var_ee47ad67 = (0, 0, 0);
        origin = ground_pos[#"position"] + var_ee47ad67;
        normal = ground_pos[#"normal"];
        angles = function_f828c08c(point.angles, normal);
        function_1ef8cb12(pointid, origin);
        function_bce96614(pointid, angles);
        if (pointid % 50 == 0) {
            waitframe(1);
        }
    }
    flagsys::set(#"item_world_traces");
}

// Namespace namespace_f68e9756/namespace_f68e9756
// Params 0, eflags: 0x4
// Checksum 0x49cd9c33, Offset: 0x1760
// Size: 0xa4
function private function_9bcd1464() {
    assert(isdefined(self.target) && self.target != "<dev string:xb1>", "<dev string:xb2>" + self.origin + "<dev string:xcd>");
    assert(self.target !== self.targetname, "<dev string:xb2>" + self.origin + "<dev string:xed>" + self.target + "<dev string:x127>");
}

// Namespace namespace_f68e9756/namespace_f68e9756
// Params 0, eflags: 0x4
// Checksum 0xbcca47f1, Offset: 0x1810
// Size: 0x2a
function private function_3e1ff51e() {
    return getdvarint(#"hash_21e070fbb56cf0f", 1);
}

// Namespace namespace_f68e9756/namespace_f68e9756
// Params 4, eflags: 0x4
// Checksum 0xf075f781, Offset: 0x1848
// Size: 0xfb4
function private function_1fa8c068(&var_d9190a12, spawncount, stashitem = 0, &var_ad66e0be = undefined) {
    if (!isstruct(self)) {
        assert(0);
        return;
    }
    assert(isstruct(self));
    assert(isarray(var_d9190a12));
    assert(isint(spawncount));
    assert(isdefined(self.itemlistbundle));
    assert(!(isdefined(self.vehiclespawner) && self.vehiclespawner));
    assert(!(isdefined(self.supplystash) && self.supplystash));
    if (spawncount <= 0) {
        return;
    }
    if (spawncount >= 100) {
        waitframe(1);
    }
    items = [];
    self.rows = isdefined(self.itemlistbundle.itemlist.size) ? self.itemlistbundle.itemlist.size : 0;
    self.count = spawncount;
    self.available = [];
    self.weights = [];
    self.weighttotal = 0;
    for (row = 0; row < self.rows; row++) {
        self.available[row] = int(isdefined(self.itemlistbundle.itemlist[row].available) ? self.itemlistbundle.itemlist[row].available : 0);
        if (self.available[row] != 0) {
            minweight = int(isdefined(self.itemlistbundle.itemlist[row].minweight) ? self.itemlistbundle.itemlist[row].minweight : 0);
            maxweight = int(isdefined(self.itemlistbundle.itemlist[row].maxweight) ? self.itemlistbundle.itemlist[row].maxweight : 0);
            minweight = int(min(minweight, maxweight));
            maxweight = int(max(minweight, maxweight));
            diff = maxweight - minweight;
            weight = function_5531c064(diff + 1) + minweight;
            self.weights[row] = weight;
            self.weighttotal += self.weights[row];
        }
    }
    var_b21fa7e2 = spawncount;
    var_bd489b2e = self.weighttotal;
    self.weighttotal = 0;
    for (row = 0; row < self.rows; row++) {
        if (self.available[row] == 0) {
            continue;
        }
        if (self.available[row] < 0) {
            self.weighttotal += self.weights[row];
            continue;
        }
        points = self.weights[row] / var_bd489b2e * var_b21fa7e2;
        if (points > self.available[row]) {
            self.weights[row] = 2147483647;
            spawncount -= self.available[row];
            continue;
        }
        self.weighttotal += self.weights[row];
    }
    self.var_ad82a72a = [];
    self.var_84839118 = [];
    self.var_f4ed9457 = 0;
    self.var_cac9d385 = 0;
    for (row = 0; row < self.rows; row++) {
        if (self.available[row] != 0) {
            if (self.weights[row] == 2147483647) {
                points = self.available[row];
            } else {
                points = self.weights[row] / self.weighttotal * spawncount;
            }
            self.var_ad82a72a[row] = int(floor(points));
            self.var_84839118[row] = int((points - self.var_ad82a72a[row]) * 1000);
            self.var_f4ed9457 += self.var_ad82a72a[row];
            self.var_cac9d385 += self.var_84839118[row];
        }
    }
    arrayremovevalue(self.var_ad82a72a, 0, 1);
    arrayremovevalue(self.var_84839118, 0, 1);
    assert(self.var_f4ed9457 <= var_b21fa7e2);
    var_f757e61f = getarraykeys(self.var_84839118);
    if (self.var_cac9d385 > 0) {
        for (pointindex = self.var_f4ed9457; pointindex < spawncount && self.var_cac9d385 > 0; pointindex++) {
            randomval = function_5531c064(self.var_cac9d385);
            var_27037ef4 = 0;
            for (var_f9e3bd15 = 0; var_f9e3bd15 < self.var_84839118.size; var_f9e3bd15++) {
                var_ae3c72dc = var_f757e61f[var_f757e61f.size - var_f9e3bd15 - 1];
                if (self.available[var_ae3c72dc] != 0) {
                    var_c22caf6e = var_27037ef4 + self.var_84839118[var_ae3c72dc];
                    if (var_27037ef4 <= randomval && randomval <= var_c22caf6e) {
                        self.var_cac9d385 -= self.var_84839118[var_ae3c72dc];
                        self.var_84839118[var_ae3c72dc] = 0;
                        self.var_ad82a72a[var_ae3c72dc] = (isdefined(self.var_ad82a72a[var_ae3c72dc]) ? self.var_ad82a72a[var_ae3c72dc] : 0) + 1;
                        self.var_f4ed9457++;
                        break;
                    }
                    var_27037ef4 = var_c22caf6e;
                }
            }
        }
    }
    assert(self.var_f4ed9457 <= var_b21fa7e2);
    if (!isdefined(var_ad66e0be)) {
        var_ad66e0be = getarraykeys(var_d9190a12);
        for (index = 0; index < var_d9190a12.size; index++) {
            randindex = function_5531c064(var_d9190a12.size);
            tempid = var_d9190a12[var_ad66e0be[randindex]];
            var_d9190a12[var_ad66e0be[randindex]] = var_d9190a12[var_ad66e0be[index]];
            var_d9190a12[var_ad66e0be[index]] = tempid;
        }
    }
    self.var_ed885b8e = [];
    var_2029adc7 = 0;
    var_e62ccb82 = 0;
    for (pointindex = 0; self.var_ad82a72a.size > 0 && var_2029adc7 < self.count; pointindex++) {
        arraykeys = getarraykeys(self.var_ad82a72a);
        var_ae3c72dc = arraykeys[0];
        if (pointindex >= var_d9190a12.size) {
            assert(var_e62ccb82 === 0);
            var_e62ccb82 = 1;
            pointindex = 0;
        }
        if (var_d9190a12[var_ad66e0be[pointindex]] == -1) {
            continue;
        }
        itementry = self.itemlistbundle.itemlist[var_ae3c72dc].itementry;
        if (isdefined(itementry) && itementry != "") {
            if (getscriptbundle(itementry).type === "itemspawnlist") {
                self.var_ed885b8e[var_ae3c72dc] = self.var_ad82a72a[var_ae3c72dc];
                self.var_ad82a72a[var_ae3c72dc] = 0;
                arrayremovevalue(self.var_ad82a72a, 0, 1);
                continue;
            }
        }
        if (var_d9190a12[var_ad66e0be[pointindex]] == -2) {
            spawnitems = self function_5fea8372(var_ae3c72dc, stashitem);
            items = arraycombine(items, spawnitems, 0, 0);
        } else {
            itemspawnpoint = function_9c3c6ff2(var_d9190a12[var_ad66e0be[pointindex]]);
            if (isdefined(self.itemlistbundle.var_50468982) && !var_e62ccb82) {
                var_604f95f2 = 0;
                itemtype = isdefined(itementry) ? getscriptbundle(itementry).itemtype : undefined;
                if (isdefined(self.itemlistbundle.var_21bec34e) && isdefined(itemtype)) {
                    if (itemtype == #"vehicle") {
                    } else {
                        var_2cd4142c = function_f89bdb99(itemspawnpoint.origin, undefined, undefined, self.itemlistbundle.var_50468982, -1, 1, -2147483647);
                        for (var_5fa93744 = 0; var_5fa93744 < var_2cd4142c.size; var_5fa93744++) {
                            if (var_2cd4142c[var_5fa93744].itementry.itemtype == itemtype) {
                                var_604f95f2++;
                                break;
                            }
                        }
                        var_2cd4142c = [];
                    }
                } else {
                    var_604f95f2 = function_406f4da6(itemspawnpoint.origin, undefined, self.itemlistbundle.var_50468982, -1, 1, -2147483647);
                }
                if (!isdefined(level.var_9686deb3)) {
                    level.var_9686deb3 = 0;
                }
                level.var_9686deb3++;
                if (level.var_9686deb3 % 100 == 0) {
                    waitframe(1);
                }
                if (var_604f95f2 > 0) {
                    continue;
                }
            }
            self _spawn_item(itemspawnpoint, var_ae3c72dc, stashitem);
        }
        var_d9190a12[var_ad66e0be[pointindex]] = -1;
        self.var_ad82a72a[var_ae3c72dc]--;
        var_2029adc7++;
        arrayremovevalue(self.var_ad82a72a, 0, 1);
    }
    for (index = 0; index < self.itemlistbundle.itemlist.size; index++) {
        if (!isdefined(self.var_ed885b8e[index])) {
            continue;
        }
        itemlist = self.itemlistbundle.itemlist[index];
        if (!isdefined(itemlist.itementry) || itemlist.itementry === "") {
            continue;
        }
        itemlistbundle = getscriptbundle(itemlist.itementry);
        if (itemlistbundle.type !== "itemspawnlist") {
            continue;
        }
        itemspawnlist = spawnstruct();
        itemspawnlist.itemlistbundle = itemlistbundle;
        itemspawnlist.origin = self.origin;
        itemspawnlist.angles = self.angles;
        var_14cc01c9 = itemspawnlist function_1fa8c068(var_d9190a12, self.var_ed885b8e[index], stashitem, var_ad66e0be);
        items = arraycombine(items, var_14cc01c9, 0, 0);
    }
    return items;
}

// Namespace namespace_f68e9756/namespace_f68e9756
// Params 1, eflags: 0x4
// Checksum 0x9a9b6c28, Offset: 0x2808
// Size: 0x4b4
function private function_73c47ccb(reset) {
    override = spawnstruct();
    override.scriptbundlename = "prematch_override_list";
    override.itemlistbundle = getscriptbundle(override.scriptbundlename);
    override.var_d9acc0c4 = function_6a1c8e6f();
    var_d9190a12 = [];
    for (index = 0; index < override.var_d9acc0c4; index++) {
        var_d9190a12[index] = index;
    }
    item_spawn_groups = struct::get_array("scriptbundle_itemspawnlist", "classname");
    foreach (group in item_spawn_groups) {
        group.itemlistbundle = getscriptbundle(group.scriptbundlename);
        if (isdefined(group.itemlistbundle.vehiclespawner) && group.itemlistbundle.vehiclespawner) {
            spawnpoints = function_60374d7d(group.target);
            foreach (spawnpoint in spawnpoints) {
                var_d9190a12[spawnpoint.id] = -1;
                override.var_d9acc0c4--;
            }
            group function_9bcd1464();
            group _setup();
            group _spawn(reset);
        }
    }
    foreach (group in item_spawn_groups) {
        group.itemlistbundle = getscriptbundle(group.scriptbundlename);
        if (isdefined(group.itemlistbundle.supplystash) && group.itemlistbundle.supplystash) {
            dynents = getdynentarray(group.target);
            foreach (dynent in dynents) {
                level.item_spawn_stashes[level.item_spawn_stashes.size] = dynent;
                setdynentenabled(dynent, 0);
            }
            spawnpoints = function_60374d7d(group.target);
            foreach (spawnpoint in spawnpoints) {
                var_d9190a12[spawnpoint.id] = -1;
                override.var_d9acc0c4--;
            }
        }
    }
    override function_1fa8c068(var_d9190a12, override.var_d9acc0c4);
}

// Namespace namespace_f68e9756/namespace_f68e9756
// Params 0, eflags: 0x0
// Checksum 0x42dcd758, Offset: 0x2cc8
// Size: 0x24
function init_spawn_system() {
    function_c3cb2fe4();
    function_56c1e1cf();
}

// Namespace namespace_f68e9756/namespace_f68e9756
// Params 0, eflags: 0x0
// Checksum 0xfb24071f, Offset: 0x2cf8
// Size: 0x4c
function is_enabled() {
    return isdefined(getgametypesetting(#"useitemspawns")) && getgametypesetting(#"useitemspawns");
}

// Namespace namespace_f68e9756/namespace_f68e9756
// Params 0, eflags: 0x0
// Checksum 0xf7f43fc8, Offset: 0x2d50
// Size: 0x252
function reset_items() {
    originalpoints = function_74d8e06a();
    for (pointid = 0; pointid < originalpoints; pointid++) {
        point = function_9c3c6ff2(pointid);
        itementry = point.itementry;
        if (!isdefined(itementry)) {
            continue;
        }
        origin = point.origin;
        angles = point.angles;
        angles = function_b38e659c(angles, (isdefined(itementry.angleoffsetx) ? itementry.angleoffsetx : 0, isdefined(itementry.angleoffsety) ? itementry.angleoffsety : 0, isdefined(itementry.angleoffsetz) ? itementry.angleoffsetz : 0));
        angles = function_b38e659c(angles, function_a19b8c4(origin));
        originoffset = ((isdefined(itementry.positionoffsetx) ? itementry.positionoffsetx : 0) * -1, (isdefined(itementry.positionoffsety) ? itementry.positionoffsety : 0) * -1, (isdefined(itementry.positionoffsetz) ? itementry.positionoffsetz : 0) * -1);
        origin += originoffset;
        function_1ef8cb12(point.id, origin);
        function_bce96614(point.id, angles);
    }
    function_9ecab3e9();
    level.item_spawn_drops = [];
}

// Namespace namespace_f68e9756/namespace_f68e9756
// Params 1, eflags: 0x0
// Checksum 0x38bff0ba, Offset: 0x2fb0
// Size: 0x476
function setup_groups(reset = 1) {
    flagsys::wait_till(#"item_world_traces");
    reset_items();
    level.item_spawn_stashes = [];
    level.item_vehicles = [];
    level.var_251a5eb0 = [];
    level.var_ec72fe2d = 0;
    level.var_e8a238c0 = [];
    level.var_c27994fc = 0;
    level.var_8531ea67 = [];
    level.var_c8f26663 = 0;
    level.var_b4fb55ee = [];
    level.var_4b9cc2c2 = 0;
    if (isdefined(function_3e1ff51e()) && function_3e1ff51e() == 1) {
        function_73c47ccb(reset);
    } else {
        item_spawn_groups = struct::get_array("scriptbundle_itemspawnlist", "classname");
        var_839d4f62 = [];
        foreach (group in item_spawn_groups) {
            if (!isdefined(group.target)) {
                continue;
            }
            if (isdefined(var_839d4f62[group.target])) {
                continue;
            }
            var_839d4f62[group.target] = 1;
            itemspawnlist = getscriptbundle(group.scriptbundlename);
            if (getdvarint(#"hash_424f2e897e67b1ba", 0)) {
                if (!(isdefined(itemspawnlist.var_aff3e3e7) && itemspawnlist.var_aff3e3e7) && !(isdefined(itemspawnlist.supplystash) && itemspawnlist.supplystash) && !(isdefined(itemspawnlist.vehiclespawner) && itemspawnlist.vehiclespawner)) {
                    continue;
                }
            } else if (isdefined(itemspawnlist.var_aff3e3e7) && itemspawnlist.var_aff3e3e7) {
                continue;
            }
            group function_9bcd1464();
            group _setup();
            group _spawn(reset);
            group _teardown();
        }
        waitframe(1);
    }
    level.var_c962ba6e = function_6a1c8e6f();
    level.var_ca061808 = level.var_ec72fe2d + level.var_c27994fc + level.var_c8f26663;
    level.var_38f49aaf = [];
    foreach (type, count in level.var_e8a238c0) {
        level.var_38f49aaf[type] = (isdefined(count) ? count : 0) + (isdefined(level.var_8531ea67[type]) ? level.var_8531ea67[type] : 0) + (isdefined(level.var_b4fb55ee[type]) ? level.var_b4fb55ee[type] : 0);
    }
}

// Namespace namespace_f68e9756/namespace_f68e9756
// Params 1, eflags: 0x0
// Checksum 0x4152ee5d, Offset: 0x3430
// Size: 0x31a
function function_865ee5ce(scriptbundlename) {
    if (!isdefined(self)) {
        assert(0);
        return;
    }
    if (!isdefined(scriptbundlename)) {
        assert(0);
        return;
    }
    self.itemlistbundle = getscriptbundle(scriptbundlename);
    items = [];
    for (row = 0; row < self.itemlistbundle.itemlist.size; row++) {
        if (!isdefined(self.itemlistbundle.itemlist[row].itementry)) {
            continue;
        }
        itemlistbundle = getscriptbundle(self.itemlistbundle.itemlist[row].itementry);
        var_6ba7dc26 = itemlistbundle.type === "itemspawnlist";
        available = isdefined(self.itemlistbundle.itemlist[row].available) ? self.itemlistbundle.itemlist[row].available : 0;
        var_d9190a12 = [];
        do {
            var_d9190a12[var_d9190a12.size] = -2;
            if (!var_6ba7dc26) {
                spawnitems = function_5fea8372(row, 1);
                items = arraycombine(items, spawnitems, 0, 0);
            }
            available--;
        } while (available > 0);
        if (var_6ba7dc26) {
            itemspawnlist = spawnstruct();
            itemspawnlist.itemlistbundle = itemlistbundle;
            spawnitems = itemspawnlist function_1fa8c068(var_d9190a12, var_d9190a12.size, 1);
            items = arraycombine(items, spawnitems, 0, 0);
        }
    }
    foreach (item in items) {
        item.targetnamehash = self.targetname;
        item.origin = self.origin;
        item linkto(self);
        item.spawning = 0;
    }
    return items;
}

// Namespace namespace_f68e9756/namespace_f68e9756
// Params 2, eflags: 0x0
// Checksum 0xe59269cd, Offset: 0x3758
// Size: 0x1de
function function_99b7eb57(scriptbundlename, itemcount) {
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
    itemgroup = spawnstruct();
    itemgroup.itemlistbundle = getscriptbundle(scriptbundlename);
    itemgroup.origin = self.origin;
    itemgroup.angles = self.angles;
    var_d9190a12 = [];
    for (pointid = 0; pointid < itemcount; pointid++) {
        var_d9190a12[var_d9190a12.size] = -2;
    }
    items = itemgroup function_1fa8c068(var_d9190a12, var_d9190a12.size, 0);
    foreach (item in items) {
        item.spawning = 0;
    }
    return items;
}

