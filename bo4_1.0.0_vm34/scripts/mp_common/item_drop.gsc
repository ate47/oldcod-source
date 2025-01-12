#using script_cb32d07c95e5628;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\oob;
#using scripts\core_common\system_shared;
#using scripts\core_common\throttle_shared;
#using scripts\core_common\util_shared;
#using scripts\mp_common\item_inventory;
#using scripts\mp_common\item_world;
#using scripts\mp_common\item_world_util;

#namespace item_drop;

// Namespace item_drop/item_drop
// Params 0, eflags: 0x2
// Checksum 0x28755b0d, Offset: 0x1b0
// Size: 0x44
function autoexec __init__system__() {
    system::register(#"item_drop", &__init__, undefined, #"item_world");
}

// Namespace item_drop/item_drop
// Params 0, eflags: 0x0
// Checksum 0xc05cda0d, Offset: 0x200
// Size: 0x1cc
function __init__() {
    if (!isdefined(getgametypesetting(#"useitemspawns")) || getgametypesetting(#"useitemspawns") == 0) {
        return;
    }
    clientfield::register("missile", "dynamic_item_drop", 1, 2, "int");
    clientfield::register("scriptmover", "dynamic_item_drop", 1, 2, "int");
    clientfield::register("scriptmover", "dynamic_stash", 1, 2, "int");
    if (!isdefined(level.var_8a4b1693)) {
        level.var_8a4b1693 = new throttle();
        [[ level.var_8a4b1693 ]]->initialize(2, 0.05);
    }
    if (!isdefined(level.var_dece2fb1)) {
        level.var_dece2fb1 = new throttle();
        [[ level.var_dece2fb1 ]]->initialize(2, 0.05);
    }
    level.disableweapondrop = 1;
    level.var_47028219 = [];
    level.item_spawn_drops = [];
    level.var_12a9e573 = [];
    level.var_42e8d419 = [];
    /#
        function_7914732();
    #/
}

/#

    // Namespace item_drop/item_drop
    // Params 0, eflags: 0x4
    // Checksum 0xc65b6fe2, Offset: 0x3d8
    // Size: 0x54
    function private function_7914732() {
        adddebugcommand("<dev string:x30>" + util::get_map_name() + "<dev string:x3e>");
        level thread function_68ce7faf();
    }

    // Namespace item_drop/item_drop
    // Params 0, eflags: 0x4
    // Checksum 0x5876d8ec, Offset: 0x438
    // Size: 0x76
    function private function_68ce7faf() {
        while (true) {
            if (getdvarint(#"hash_9fd3c7ff85dca2c", 0)) {
                setdvar(#"hash_9fd3c7ff85dca2c", 0);
                function_b16a292b();
            }
            waitframe(1);
        }
    }

#/

// Namespace item_drop/item_drop
// Params 4, eflags: 0x4
// Checksum 0x50b5f8e8, Offset: 0x4b8
// Size: 0xea
function private function_2d73736e(origin, angles, normal, itementry) {
    angles = function_f828c08c(angles, normal);
    angles = combineangles(angles, namespace_f68e9756::function_a19b8c4(origin));
    if (isdefined(itementry)) {
        angles = combineangles(angles, (isdefined(itementry.angleoffsetx) ? itementry.angleoffsetx : 0, isdefined(itementry.angleoffsety) ? itementry.angleoffsety : 0, isdefined(itementry.angleoffsetz) ? itementry.angleoffsetz : 0));
    }
    return angles;
}

// Namespace item_drop/item_drop
// Params 0, eflags: 0x4
// Checksum 0xa5a464fa, Offset: 0x5b0
// Size: 0x4c
function private function_252cddec() {
    return (randomintrange(-10, 10), randomintrange(-180, 180), randomintrange(-10, 10));
}

// Namespace item_drop/item_drop
// Params 1, eflags: 0x4
// Checksum 0x2526641b, Offset: 0x608
// Size: 0x7a
function private function_23ab9bf7(degree) {
    distance = randomintrange(48, 60);
    return (cos(degree) * distance, sin(degree) * distance, randomintrange(24, 36));
}

// Namespace item_drop/item_drop
// Params 2, eflags: 0x4
// Checksum 0xe9461f51, Offset: 0x690
// Size: 0x4c6
function private function_822b1824(player, position) {
    if (isplayer(player)) {
        centerpoint = player.origin;
        var_388607dd = position - centerpoint;
        var_388607dd = (var_388607dd[0], var_388607dd[1], 0);
        var_388607dd = vectornormalize(var_388607dd);
        forward = (1, 0, 0);
        theta = vectortoangles(var_388607dd)[1] - vectortoangles(forward)[1];
        var_64efe11 = 10;
        var_58f66e81 = var_64efe11 * var_64efe11;
        var_44adb977 = array(15, 15, 15, 15);
        var_1b62b07 = array(180 / var_44adb977[0], 240 / var_44adb977[1], 360 / var_44adb977[2], 360 / var_44adb977[3]);
        var_7b6828e0 = array(0, 0, int(var_1b62b07[2] - var_1b62b07[0]), int(var_1b62b07[3] - var_1b62b07[1]));
        distance = distance(position, centerpoint);
        distances = array(distance, distance * 1.5, distance, distance * 1.5);
        checkdistance = distance * 3;
        assert(distances.size == var_7b6828e0.size);
        assert(distances.size == var_44adb977.size);
        assert(distances.size == var_1b62b07.size);
        var_2cd4142c = item_world::function_33d2057a(centerpoint, undefined, undefined, checkdistance, undefined, 1);
        for (distancechecks = 0; distancechecks < distances.size; distancechecks++) {
            currentdistance = distances[distancechecks];
            for (check = var_7b6828e0[distancechecks]; check < var_1b62b07[distancechecks]; check++) {
                var_c4fd6694 = check % 2 == 1 ? int(ceil(check / -2)) : int(ceil(check / 2));
                angle = theta + var_44adb977[distancechecks] * var_c4fd6694;
                checkpoint = currentdistance * (cos(angle), sin(angle), 0) + centerpoint;
                var_1858cec = 0;
                for (var_305877df = 0; var_305877df < var_2cd4142c.size; var_305877df++) {
                    if (distance2dsquared(var_2cd4142c[var_305877df].origin, checkpoint) < var_58f66e81) {
                        var_1858cec = 1;
                        break;
                    }
                }
                if (!var_1858cec) {
                    return checkpoint;
                }
            }
        }
    }
    return position;
}

// Namespace item_drop/item_drop
// Params 5, eflags: 0x4
// Checksum 0xab54a94e, Offset: 0xb60
// Size: 0x8f4
function private function_9e62dbc8(player, position, angles, itementry, var_a49418b7 = 0) {
    assert(isentity(self));
    assert(isentity(player));
    assert(isvec(position));
    assert(isvec(angles));
    self notsolid();
    ignoreent = player;
    if (isplayer(player) && player isinvehicle()) {
        occupiedvehicle = player getvehicleoccupied();
        dontignore = 0;
        foreach (vehicle in array(#"hash_774fc84bcca96f3d")) {
            if (vehicle == occupiedvehicle.vehmodel) {
                dontignore = 1;
                break;
            }
        }
        if (!dontignore) {
            ignoreent = occupiedvehicle;
        } else {
            ignoreent = undefined;
        }
    }
    origin = function_822b1824(player, position);
    var_3fb54aa2 = origin + (0, 0, 24);
    var_c0a14271 = origin - (0, 0, 128);
    if (isplayer(player)) {
        eyepos = player geteye();
        sighttrace = bullettrace(eyepos, var_3fb54aa2, 0, ignoreent, 0, 0);
        if (sighttrace[#"startsolid"] || sighttrace[#"fraction"] < 1) {
            var_3fb54aa2 = player.origin + (0, 0, 24);
            var_c0a14271 = player.origin - (0, 0, 128);
        }
    }
    var_22ffa66d = 5;
    onground = 0;
    for (index = 0; index < var_22ffa66d; index++) {
        var_b5a54b54 = physicstraceex(var_3fb54aa2, var_c0a14271, (-0.5, -0.5, -0.5), (0.5, 0.5, 0.5), ignoreent, 32);
        if (isdefined(var_b5a54b54[#"startsolid"]) && var_b5a54b54[#"startsolid"]) {
            var_3fb54aa2 = player.origin + (0, 0, 24);
            var_c0a14271 = player.origin - (0, 0, 128);
            continue;
        } else if (var_b5a54b54[#"fraction"] < 1 && vectordot(var_b5a54b54[#"normal"], (0, 0, 1)) >= 0.707) {
            if (var_b5a54b54[#"position"][2] > -10000) {
                origin = var_b5a54b54[#"position"];
            }
            if (isdefined(itementry)) {
                originoffset = (isdefined(itementry.positionoffsetx) ? itementry.positionoffsetx : 0, isdefined(itementry.positionoffsety) ? itementry.positionoffsety : 0, isdefined(itementry.positionoffsetz) ? itementry.positionoffsetz : 0);
                origin += originoffset;
            }
            normal = var_b5a54b54[#"normal"];
            angles = function_2d73736e(origin, angles, normal, itementry);
            self.origin = origin;
            self.angles = angles;
            parentent = var_b5a54b54[#"entity"];
            if (isdefined(parentent) && parentent.model != "") {
                if (isplayer(parentent)) {
                    ignoreent = parentent;
                    var_3fb54aa2 = var_b5a54b54[#"position"];
                    continue;
                }
                if (parentent.classname == "script_vehicle") {
                    var_453e6e20 = 0;
                    foreach (vehicle in array(#"veh_t8_mil_atv_recon", #"hash_251f2f6007d78e")) {
                        if (vehicle == parentent.vehmodel) {
                            var_453e6e20 = 1;
                            break;
                        }
                    }
                    if (!var_453e6e20 && isdefined(parentent.var_1e72c17a) && !var_a49418b7) {
                        arrayremovevalue(parentent.var_1e72c17a, undefined, 0);
                        var_453e6e20 = parentent.var_1e72c17a.size >= 5;
                    }
                    if (var_453e6e20) {
                        continue;
                    }
                }
                if (self == parentent) {
                    ignoreent = self;
                    continue;
                }
                self linkto(parentent);
                if (!var_a49418b7) {
                    if (!isdefined(parentent.var_1e72c17a)) {
                        parentent.var_1e72c17a = [];
                    } else if (!isarray(parentent.var_1e72c17a)) {
                        parentent.var_1e72c17a = array(parentent.var_1e72c17a);
                    }
                    parentent.var_1e72c17a[parentent.var_1e72c17a.size] = self;
                }
            }
            onground = 1;
            break;
        }
        break;
    }
    if (!onground) {
        self.angles = function_2d73736e(self.origin, self.angles, (0, 0, 1), itementry);
        self setcontents(self setcontents(0) & ~(32768 | 67108864 | 8388608 | 33554432));
        self physicslaunch();
        self thread function_819ad62d();
        return true;
    }
    return false;
}

// Namespace item_drop/item_drop
// Params 5, eflags: 0x0
// Checksum 0x2cffae41, Offset: 0x1460
// Size: 0x4f6
function function_819ad62d(var_53966308 = 1, tracedistance = 24, originheightoffset = 0, min = (0, 0, 0), max = (0, 0, 0)) {
    self endon(#"death");
    self waittill(#"stationary");
    var_3491f0cd = undefined;
    var_40d086a3 = undefined;
    var_26b1982d = undefined;
    parentent = undefined;
    var_70b5ecf2 = undefined;
    var_385f6ff4 = undefined;
    while (true) {
        origin = self.origin + anglestoup(self.angles) * originheightoffset;
        var_b5a54b54 = physicstrace(origin + (0, 0, 1), origin - (0, 0, tracedistance), min, max, self, 32);
        parentent = var_b5a54b54[#"entity"];
        if (var_b5a54b54[#"startsolid"]) {
            self physicslaunch();
        } else if (!isdefined(parentent)) {
            return;
        } else if (isdefined(parentent) && parentent.model != "" && !isplayer(parentent)) {
            var_453e6e20 = 0;
            if (!var_53966308) {
                var_453e6e20 = 1;
            }
            if (!var_453e6e20 && parentent.classname == "script_vehicle") {
                foreach (vehicle in array(#"veh_t8_mil_atv_recon", #"hash_251f2f6007d78e")) {
                    if (vehicle == parentent.vehmodel) {
                        var_453e6e20 = 1;
                        break;
                    }
                }
                if (!var_453e6e20 && isdefined(parentent.var_1e72c17a)) {
                    arrayremovevalue(parentent.var_1e72c17a, undefined, 0);
                    var_453e6e20 = parentent.var_1e72c17a.size >= 5;
                }
            }
            if (!var_453e6e20 && self !== parentent) {
                self linkto(parentent);
                if (!isdefined(parentent.var_1e72c17a)) {
                    parentent.var_1e72c17a = [];
                } else if (!isarray(parentent.var_1e72c17a)) {
                    parentent.var_1e72c17a = array(parentent.var_1e72c17a);
                }
                parentent.var_1e72c17a[parentent.var_1e72c17a.size] = self;
                return;
            }
            if (!isdefined(var_3491f0cd)) {
                var_3491f0cd = parentent;
                var_40d086a3 = parentent.origin;
                var_26b1982d = parentent.angles;
            }
            var_70b5ecf2 = parentent.origin;
            var_385f6ff4 = parentent.angles;
        }
        [[ level.var_dece2fb1 ]]->waitinqueue(self);
        if (isdefined(var_3491f0cd) && isdefined(parentent) && var_3491f0cd === parentent && distancesquared(var_40d086a3, var_70b5ecf2) <= 2 && distancesquared(var_26b1982d, var_385f6ff4) <= 2) {
            waitframe(1);
            continue;
        }
        self physicslaunch();
        waitframe(1);
    }
}

// Namespace item_drop/player_killed
// Params 1, eflags: 0x40
// Checksum 0xdd673b44, Offset: 0x1960
// Size: 0x5e
function event_handler[player_killed] codecallback_playerkilled(eventstruct) {
    if (sessionmodeiswarzonegame() && isplayer(self)) {
        drop_inventory(self);
        if (isdefined(self)) {
            self.inventory = undefined;
        }
    }
}

// Namespace item_drop/player_disconnect
// Params 1, eflags: 0x40
// Checksum 0x7acf4668, Offset: 0x19c8
// Size: 0x9e
function event_handler[player_disconnect] codecallback_playerdisconnect(eventstruct) {
    if (sessionmodeiswarzonegame() && isplayer(self)) {
        if (!(isdefined(level.inprematchperiod) && level.inprematchperiod) && isdefined(self.var_66961c6f) && self.var_66961c6f) {
            drop_inventory(self);
            if (isdefined(self)) {
                self.inventory = undefined;
            }
        }
    }
}

// Namespace item_drop/item_drop
// Params 0, eflags: 0x0
// Checksum 0xad8e766f, Offset: 0x1a70
// Size: 0x1fc
function function_b16a292b() {
    foreach (item in level.item_spawn_drops) {
        if (isdefined(item)) {
            item delete();
        }
    }
    arrayremovevalue(level.item_spawn_drops, undefined, 0);
    arrayremovevalue(level.var_12a9e573, undefined, 0);
    foreach (stash in level.var_47028219) {
        if (isdefined(stash)) {
            stash delete();
        }
    }
    arrayremovevalue(level.var_47028219, undefined, 0);
    foreach (stash in level.var_42e8d419) {
        if (isdefined(stash)) {
            stash delete();
        }
    }
    arrayremovevalue(level.var_42e8d419, undefined, 0);
}

// Namespace item_drop/item_drop
// Params 1, eflags: 0x0
// Checksum 0x3854ecb, Offset: 0x1c78
// Size: 0x822
function drop_inventory(player) {
    if (!item_world::function_61cbd38b()) {
        return;
    }
    assert(isplayer(player));
    items = [];
    if (!isplayer(player) || !isdefined(player.inventory) || player oob::isoutofbounds()) {
        return items;
    }
    if (isdefined(player.laststandparams) && isdefined(player.laststandparams.smeansofdeath) && player.laststandparams.smeansofdeath == #"mod_trigger_hurt" && player.laststandparams.sweapon.name === #"none") {
        return items;
    }
    if (!item_world_util::function_4b1b9689(player.origin)) {
        return items;
    }
    drop_items = [];
    drop_count = [];
    drop_amount = [];
    drop_item_id = [];
    deathstash = spawn("script_model", player.origin);
    deathstash setmodel("p8_fxanim_wz_death_stash_mod");
    deathstash useanimtree("generic");
    deathstash notsolid();
    targetname = player getentitynumber() + "_death_stash_" + randomint(2147483647);
    deathstash.targetname = targetname;
    deathstash.var_5adbea02 = 0;
    inphysics = deathstash function_9e62dbc8(player, player.origin, player.angles, undefined, 1);
    level.var_42e8d419[level.var_42e8d419.size] = deathstash;
    deathstashitems = 0;
    foreach (inventoryitem in player.inventory.items) {
        itemid = inventoryitem.id;
        if (itemid == 32767) {
            continue;
        }
        if (!(isdefined(inventoryitem.itementry.var_d017ccc9) && inventoryitem.itementry.var_d017ccc9)) {
            continue;
        }
        item_weapon = item_world_util::function_4f1a8d4a(itemid);
        count = isdefined(inventoryitem.count) ? inventoryitem.count : 1;
        amount = inventoryitem.amount;
        player item_inventory::function_d880c838(inventoryitem.networkid);
        if (isdefined(item_weapon)) {
            drop_items[drop_item_id.size] = item_weapon;
        }
        drop_count[drop_item_id.size] = count;
        drop_amount[drop_item_id.size] = amount;
        drop_item_id[drop_item_id.size] = itemid;
    }
    foreach (ammoweapon, itemid in player.inventory.ammo) {
        weapon = getweapon(ammoweapon);
        ammostock = player getweaponammostock(weapon);
        player setweaponammostock(weapon, 0);
        if (ammostock > 0) {
            drop_items[drop_item_id.size] = weapon;
            drop_amount[drop_item_id.size] = ammostock;
            drop_count[drop_item_id.size] = 1;
            drop_item_id[drop_item_id.size] = itemid;
        }
    }
    if (deathstashitems <= 0 && drop_item_id.size <= 0) {
        deathstash endon(#"death");
        if (inphysics) {
            deathstash waittill(#"stationary");
        }
        deathstash animscripted("death_stash_open", deathstash.origin, deathstash.angles, "p8_fxanim_wz_death_stash_used_anim", "normal", "root", 1, 0);
        deathstash waittill(#"death_stash_open");
        deathstash animscripted("death_stash_empty", deathstash.origin, deathstash.angles, "p8_fxanim_wz_death_stash_empty_anim", "normal", "root", 1, 0);
        deathstash.var_5adbea02 = 2;
        deathstash clientfield::set("dynamic_stash", 2);
    } else {
        deathstash clientfield::set("dynamic_stash", 1);
    }
    if (drop_item_id.size <= 0) {
        return items;
    }
    degree = 0;
    var_26c7f79e = drop_item_id.size;
    var_574efb0d = int(360 / var_26c7f79e * 2);
    even = drop_item_id.size % 2 == 0;
    for (index = 0; index < drop_item_id.size; index++) {
        items[items.size] = player drop_item(drop_items[index], drop_count[index], drop_amount[index], drop_item_id[index], deathstash.origin, deathstash.angles, 1, 1, targetname, deathstash);
    }
    level.var_47028219[level.var_47028219.size] = deathstash;
    return items;
}

// Namespace item_drop/item_drop
// Params 11, eflags: 0x0
// Checksum 0x7493e159, Offset: 0x24a8
// Size: 0x592
function drop_item(weapon = undefined, count = 0, amount = 0, itemid, position, angles = (0, 0, 0), stashitem = 0, deathstash = 0, targetname = undefined, parentent = undefined, attachments = undefined) {
    assert(!isdefined(deathstash) || deathstash === 1 || deathstash === 0);
    if (!item_world::function_61cbd38b()) {
        return;
    }
    assert(item_world_util::function_a04a2a1f(itemid));
    if (count <= 0) {
        return;
    }
    [[ level.var_8a4b1693 ]]->waitinqueue();
    arrayremovevalue(level.var_12a9e573, undefined);
    if (level.var_12a9e573.size > 200) {
        level.var_12a9e573[0] delete();
    }
    item = function_9c3c6ff2(itemid);
    if (!item_world_util::function_4b1b9689(position)) {
        return;
    }
    dropitem = spawn("script_model", position);
    dropitem.angles = angles;
    dropitem.attachments = attachments;
    dropitem.var_3e4720d3 = weapon;
    dropitem.targetnamehash = targetname;
    dropitem.deathstash = deathstash;
    dropitem.id = itemid;
    dropitem.networkid = item_world_util::function_4dec3654(dropitem);
    dropitem.itementry = item.itementry;
    dropitem clientfield::set("dynamic_item_drop", 1);
    dropitem function_5d3f60ae(itemid);
    dropitem notsolid();
    dropitem setforcenocull();
    if (stashitem) {
        dropitem.hidetime = -1;
        dropitem ghost();
    } else {
        dropitem.hidetime = 0;
    }
    dropitem.amount = amount;
    dropitem.count = count;
    if (isdefined(dropitem.itementry.model)) {
        dropitem setmodel(dropitem.itementry.model);
    } else if (isdefined(weapon)) {
        dropitem setmodel(weapon.worldmodel);
    }
    if (isdefined(weapon)) {
        dropitem setweapon(weapon);
    }
    if (isdefined(dropitem.itementry.modelscale)) {
        dropitem setscale(dropitem.itementry.modelscale);
    }
    if (!stashitem) {
        dropitem function_9e62dbc8(isentity(self) ? self : dropitem, position, angles, item.itementry);
    }
    if (isentity(parentent) && dropitem !== parentent) {
        dropitem.origin = parentent.origin;
        dropitem linkto(parentent);
    }
    arrayremovevalue(level.item_spawn_drops, undefined, 1);
    if (isdefined(level.item_spawn_drops[dropitem.networkid])) {
        level.item_spawn_drops[dropitem.networkid] delete();
    }
    level.item_spawn_drops[dropitem.networkid] = dropitem;
    level.var_12a9e573[level.var_12a9e573.size] = dropitem;
    return dropitem;
}

// Namespace item_drop/item_drop
// Params 3, eflags: 0x0
// Checksum 0x3eae28dd, Offset: 0x2a48
// Size: 0x212
function function_64de448c(origin, radius, time) {
    assert(isvec(origin));
    assert(isfloat(radius) || isint(radius));
    assert(isfloat(time) || isint(time));
    if (time < 0) {
        return;
    }
    var_ec57a7a1 = arraysortclosest(level.item_spawn_drops, origin, 24, 0, radius);
    var_5fec5c25 = arraysortclosest(level.var_47028219, origin, 24, 0, radius);
    var_2cd4142c = arraycombine(var_ec57a7a1, var_5fec5c25, 1, 0);
    starttime = gettime();
    while (float(gettime() - starttime) / 1000 < time) {
        foreach (item in var_2cd4142c) {
            if (isdefined(item)) {
                item physicslaunch();
            }
        }
        waitframe(1);
    }
}

// Namespace item_drop/item_drop
// Params 1, eflags: 0x0
// Checksum 0xc13ea556, Offset: 0x2c68
// Size: 0x8c
function function_76bdc4bd(item) {
    if (isdefined(item) && isdefined(item.networkid) && isdefined(level.item_spawn_drops[item.networkid])) {
        item clientfield::set("dynamic_item_drop", 0);
        arrayremoveindex(level.item_spawn_drops, item.networkid, 1);
    }
}

