#using script_cb32d07c95e5628;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\oob;
#using scripts\core_common\player_insertion;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\vehicle_shared;
#using scripts\mp_common\item_drop;

#namespace item_supply_drop;

// Namespace item_supply_drop/item_supply_drop
// Params 0, eflags: 0x2
// Checksum 0x2bba476f, Offset: 0x248
// Size: 0x44
function autoexec __init__system__() {
    system::register(#"item_supply_drop", &__init__, undefined, #"item_world");
}

// Namespace item_supply_drop/item_supply_drop
// Params 0, eflags: 0x4
// Checksum 0x2d9e340a, Offset: 0x298
// Size: 0xac
function private __init__() {
    if (!isdefined(getgametypesetting(#"useitemspawns")) || getgametypesetting(#"useitemspawns") == 0) {
        return;
    }
    level.item_supply_drops = [];
    /#
        level thread _setup_devgui();
    #/
    clientfield::register("scriptmover", "supply_drop_fx", 1, 1, "int");
}

/#

    // Namespace item_supply_drop/item_supply_drop
    // Params 0, eflags: 0x4
    // Checksum 0x8fdb330a, Offset: 0x350
    // Size: 0x13e
    function private function_d29bfc4b() {
        while (true) {
            if (getdvarint(#"wz_supply_drop", 0) > 0) {
                function_50a4cbe6();
                setdvar(#"wz_supply_drop", 0);
            }
            if (getdvarint(#"hash_5dc24c61c66f6fee", 0) > 0) {
                debug_supply_drop();
            }
            if (getdvarint(#"hash_40d4ca5923d72b3d", 0) > 0) {
                players = getplayers();
                if (isdefined(players[0])) {
                    drop_supply_drop(players[0].origin, 0);
                }
                setdvar(#"hash_40d4ca5923d72b3d", 0);
            }
            waitframe(1);
        }
    }

    // Namespace item_supply_drop/item_supply_drop
    // Params 0, eflags: 0x4
    // Checksum 0x777deadd, Offset: 0x498
    // Size: 0xd4
    function private _setup_devgui() {
        while (!canadddebugcommand()) {
            waitframe(1);
        }
        mapname = util::get_map_name();
        adddebugcommand("<dev string:x30>" + mapname + "<dev string:x3e>");
        adddebugcommand("<dev string:x30>" + mapname + "<dev string:x76>");
        adddebugcommand("<dev string:x30>" + mapname + "<dev string:xa8>");
        level thread function_d29bfc4b();
    }

    // Namespace item_supply_drop/item_supply_drop
    // Params 0, eflags: 0x4
    // Checksum 0x4ea9c897, Offset: 0x578
    // Size: 0x4a4
    function private debug_supply_drop() {
        if (isdefined(level.supplydropveh)) {
            deathcircleindex = isdefined(level.deathcircleindex) ? level.deathcircleindex : 0;
            deathcircle = level.deathcircles[deathcircleindex];
            nextdeathcircle = isdefined(level.deathcircles[deathcircleindex + 1]) ? level.deathcircles[deathcircleindex + 1] : deathcircle;
            height = nextdeathcircle.origin[2];
            radius = 200;
            sphere(level.var_ebe249b9, radius, (1, 0, 0));
            sphere(level.var_bcaa4b64, radius, (1, 0, 0));
            if (isdefined(level.var_25b349b5)) {
                sphere(level.var_25b349b5, radius, (0, 1, 0));
                var_d7265ae2 = (level.var_25b349b5[0], level.var_25b349b5[1], height);
                line(level.var_25b349b5, var_d7265ae2, (0, 1, 0));
                sphere(var_d7265ae2, radius, (0, 1, 0));
            }
            if (isdefined(level.var_13d2ae4f)) {
                sphere(level.var_13d2ae4f, radius, (0, 1, 0));
                var_fe4e768c = (level.var_13d2ae4f[0], level.var_13d2ae4f[1], height);
                line(level.var_13d2ae4f, var_fe4e768c, (0, 1, 0));
                sphere(var_fe4e768c, radius, (0, 1, 0));
            }
            sphere(level.var_be844fc7, radius, (1, 0.5, 0));
            for (index = 1; index < level.var_efcf64ae.size; index++) {
                line(level.var_efcf64ae[index - 1], level.var_efcf64ae[index], (1, 0, 0));
            }
            if (isdefined(level.supplydropmax) && isdefined(level.supplydropmin)) {
                mintop = level.supplydropmin;
                var_8b56a12 = (level.supplydropmin[0], level.supplydropmax[1], level.supplydropmax[2]);
                var_23de2c72 = (level.supplydropmax[0], level.supplydropmin[1], level.supplydropmin[2]);
                var_47601d68 = level.supplydropmax;
                line(mintop, var_8b56a12, (1, 1, 1));
                line(mintop, var_23de2c72, (1, 1, 1));
                line(var_47601d68, var_8b56a12, (1, 1, 1));
                line(var_47601d68, var_23de2c72, (1, 1, 1));
                sphere(mintop, radius, (1, 1, 1));
                sphere(var_23de2c72, radius, (1, 1, 1));
                sphere(var_8b56a12, radius, (1, 1, 1));
                sphere(var_47601d68, radius, (1, 1, 1));
            }
        }
    }

#/

// Namespace item_supply_drop/item_supply_drop
// Params 2, eflags: 0x4
// Checksum 0x145c02f, Offset: 0xa28
// Size: 0x39c
function private function_dae42667(point, startpoint) {
    assert(isvec(point));
    assert(isvec(startpoint));
    if (function_72c18993(point)) {
        return point;
    }
    assert(function_72c18993(startpoint));
    min = level.supplydropmin;
    max = level.supplydropmax;
    var_d52c98b8 = (point[0], point[1], 0);
    var_cef02fbc = (startpoint[0], startpoint[1], 0);
    if (var_d52c98b8[0] < min[0]) {
        toend = vectornormalize(var_d52c98b8 - var_cef02fbc);
        assert(toend[0] != 0);
        t = (min[0] - var_cef02fbc[0]) / toend[0];
        var_d52c98b8 = var_cef02fbc + toend * t;
    } else if (var_d52c98b8[0] > max[0]) {
        toend = vectornormalize(var_d52c98b8 - var_cef02fbc);
        assert(toend[0] != 0);
        t = (max[0] - var_cef02fbc[0]) / toend[0];
        var_d52c98b8 = var_cef02fbc + toend * t;
    }
    if (var_d52c98b8[1] < min[1]) {
        toend = vectornormalize(var_d52c98b8 - var_cef02fbc);
        assert(toend[1] != 0);
        t = (min[1] - var_cef02fbc[1]) / toend[1];
        var_d52c98b8 = var_cef02fbc + toend * t;
    } else if (var_d52c98b8[1] > max[1]) {
        toend = vectornormalize(var_d52c98b8 - var_cef02fbc);
        assert(toend[1] != 0);
        t = (max[1] - var_cef02fbc[1]) / toend[1];
        var_d52c98b8 = var_cef02fbc + toend * t;
    }
    point = (var_d52c98b8[0], var_d52c98b8[1], point[2]);
    return point;
}

// Namespace item_supply_drop/item_supply_drop
// Params 0, eflags: 0x4
// Checksum 0xad1eb3cd, Offset: 0xdd0
// Size: 0x16c
function private function_d9f0694e() {
    self endon(#"death");
    self animscripted("parachute_open", self.origin, self.angles, #"hash_4f2b2f1b4df13119", "normal", "root", 1, 0);
    self waittill(#"parachute_open");
    self animscripted("parachute_idle", self.origin, self.angles, #"hash_39265b4ed372175a", "normal", "root", 1, 0);
    self waittill(#"parachute_close");
    self unlink();
    self animscripted("parachute_closed", self.origin, self.angles, #"hash_32ad963f25f115d2", "normal", "root", 1, 0);
    self waittill(#"parachute_closed");
    self delete();
}

// Namespace item_supply_drop/item_supply_drop
// Params 0, eflags: 0x4
// Checksum 0xf3853251, Offset: 0xf48
// Size: 0x354
function private function_cc2021a1() {
    if (isdefined(self.supplydrop)) {
        supplydrop = self.supplydrop;
        self.supplydrop = undefined;
        supplydrop endon(#"death");
        supplydrop unlink();
        supplydrop show();
        startpoint = (supplydrop.origin[0], supplydrop.origin[1], min(10000, supplydrop.origin[2] - 200));
        endpoint = (supplydrop.origin[0], supplydrop.origin[1], -10000);
        travelspeed = 200;
        groundtrace = physicstraceex(startpoint, endpoint, (-0.5, -0.5, -0.5), (0.5, 0.5, 0.5), supplydrop, 32);
        groundpoint = groundtrace[#"position"] + (0, 0, 120);
        traveldistance = startpoint - groundpoint;
        movetime = traveldistance[2] / travelspeed;
        supplydrop moveto(groundpoint, movetime);
        supplydrop playsound("evt_supply_drop");
        var_afcdd49 = 1;
        wait var_afcdd49;
        supplydropparachute = spawn("script_model", (0, 0, 0));
        supplydropparachute.origin = supplydrop.origin;
        supplydropparachute.angles = supplydrop.angles;
        supplydropparachute setforcenocull();
        supplydropparachute setmodel("p8_fxanim_wz_parachute_supplydrop_mod");
        supplydropparachute useanimtree("generic");
        supplydropparachute linkto(supplydrop, "tag_origin", (0, 0, 0));
        supplydropparachute thread function_d9f0694e();
        supplydrop waittill(#"movedone");
        supplydropparachute notify(#"parachute_close");
        supplydrop physicslaunch();
        supplydrop thread function_42e596a6();
    }
}

// Namespace item_supply_drop/item_supply_drop
// Params 0, eflags: 0x4
// Checksum 0x330f6b11, Offset: 0x12a8
// Size: 0x204
function private function_e3e23f4a() {
    self endon(#"death");
    self notify(#"emergency_exit");
    exitangle = 60;
    right = anglestoforward(self.angles + (0, exitangle, 0));
    left = anglestoforward(self.angles + (0, exitangle * -1, 0));
    var_841ec0b7 = function_d744e134();
    startpoint = self.origin;
    leftpoint = function_dae42667(startpoint + left * var_841ec0b7, startpoint);
    rightpoint = function_dae42667(startpoint + right * var_841ec0b7, startpoint);
    endpoint = rightpoint;
    if (distance2d(startpoint, leftpoint) < distance2d(startpoint, rightpoint)) {
        endpoint = leftpoint;
    }
    var_efcf64ae = function_e9cde02(startpoint, endpoint);
    self.var_efcf64ae = var_efcf64ae;
    self setspeed(50);
    wait 0.5;
    self thread function_7c49a646(var_efcf64ae);
    wait 0.5;
    self setspeed(100);
}

// Namespace item_supply_drop/item_supply_drop
// Params 0, eflags: 0x4
// Checksum 0x5640ad09, Offset: 0x14b8
// Size: 0x70
function private function_985e0b79() {
    var_9665e422 = getentarray("map_corner", "targetname");
    if (var_9665e422.size) {
        return math::find_box_center(var_9665e422[0].origin, var_9665e422[1].origin);
    }
    return (0, 0, 0);
}

// Namespace item_supply_drop/item_supply_drop
// Params 0, eflags: 0x4
// Checksum 0xba6583b7, Offset: 0x1530
// Size: 0xe6
function private function_d744e134() {
    var_9665e422 = getentarray("map_corner", "targetname");
    if (var_9665e422.size) {
        x = abs(var_9665e422[0].origin[0] - var_9665e422[1].origin[0]);
        y = abs(var_9665e422[0].origin[1] - var_9665e422[1].origin[1]);
        return (max(x, y) / 2);
    }
    return 1000;
}

// Namespace item_supply_drop/item_supply_drop
// Params 1, eflags: 0x4
// Checksum 0xb0852c7f, Offset: 0x1620
// Size: 0x110
function private function_556584ce(var_d7c0d6f9) {
    supplydrop = spawn("script_model", (0, 0, 0));
    supplydrop setmodel("wpn_t7_drop_box_wz");
    supplydrop setforcenocull();
    supplydrop.var_1597e770 = 0;
    supplydrop.var_5adbea02 = 0;
    supplydrop.targetname = supplydrop getentitynumber() + "_stash_" + randomint(2147483647);
    supplydrop clientfield::set("dynamic_stash", 1);
    supplydrop.supplydropveh = var_d7c0d6f9;
    supplydrop namespace_f68e9756::function_865ee5ce("supply_drop_stash_parent");
    return supplydrop;
}

// Namespace item_supply_drop/item_supply_drop
// Params 1, eflags: 0x4
// Checksum 0xf980d8f3, Offset: 0x1738
// Size: 0x212
function private function_72c18993(point) {
    if (!isdefined(level.supplydropmin) || !isdefined(level.supplydropmax)) {
        var_9665e422 = getentarray("map_corner", "targetname");
        minx = min(var_9665e422[0].origin[0], var_9665e422[1].origin[0]);
        miny = min(var_9665e422[0].origin[1], var_9665e422[1].origin[1]);
        minz = -10;
        level.supplydropmin = (minx, miny, minz);
        maxx = max(var_9665e422[0].origin[0], var_9665e422[1].origin[0]);
        maxy = max(var_9665e422[0].origin[1], var_9665e422[1].origin[1]);
        maxz = 10;
        level.supplydropmax = (maxx, maxy, maxz);
    }
    testpoint = (point[0], point[1], 0);
    return function_4d318532(level.supplydropmin, level.supplydropmax, testpoint);
}

// Namespace item_supply_drop/item_supply_drop
// Params 15, eflags: 0x4
// Checksum 0xbab57b8a, Offset: 0x1958
// Size: 0xc8
function private function_63441715(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal) {
    if (self.health - idamage <= self.var_66f32a7b) {
        self thread function_cc2021a1();
        self thread function_e3e23f4a();
    }
    return idamage;
}

// Namespace item_supply_drop/item_supply_drop
// Params 3, eflags: 0x4
// Checksum 0xe28b7fbf, Offset: 0x1a28
// Size: 0x1f6
function private function_e9cde02(startpoint, endpoint, droppoint) {
    points = [];
    startpoint = trace_point(startpoint);
    endpoint = trace_point(endpoint);
    var_388607dd = vectornormalize(endpoint - startpoint);
    pathlength = distance2d(startpoint, endpoint);
    var_1739c3ba = int(pathlength / 5000);
    points[0] = startpoint;
    if (isdefined(droppoint)) {
        var_bba08690 = distancesquared(startpoint, droppoint);
    }
    for (var_5897fab8 = 1; var_5897fab8 <= var_1739c3ba; var_5897fab8++) {
        var_79242840 = startpoint + var_388607dd * 5000 * var_5897fab8;
        if (isdefined(droppoint)) {
            if (distancesquared(startpoint, var_79242840) >= var_bba08690 && distancesquared(startpoint, points[points.size - 1]) <= var_bba08690) {
                points[points.size] = droppoint;
            }
        }
        points[points.size] = trace_point(var_79242840, undefined);
        waitframe(1);
    }
    points[points.size] = endpoint;
    return points;
}

// Namespace item_supply_drop/item_supply_drop
// Params 4, eflags: 0x4
// Checksum 0x62cc18f2, Offset: 0x1c28
// Size: 0x14c
function private trace_point(point, var_4ffcc385 = 1, maxheight = 10000, minheight = 5000) {
    startpoint = (point[0], point[1], maxheight);
    endpoint = (point[0], point[1], minheight);
    trace = groundtrace(startpoint, endpoint, 0, undefined, var_4ffcc385);
    if (!var_4ffcc385) {
        if (trace[#"surfacetype"] == "water" || trace[#"surfacetype"] == "watershallow") {
            return;
        }
    }
    if (isdefined(trace[#"position"])) {
        return (trace[#"position"] + (0, 0, 2000));
    }
    return startpoint;
}

// Namespace item_supply_drop/item_supply_drop
// Params 0, eflags: 0x4
// Checksum 0x9109a829, Offset: 0x1d80
// Size: 0xbc
function private function_42e596a6() {
    self endon(#"death");
    self thread item_drop::function_819ad62d(1, 80, 24, (-12, -12, -12), (12, 12, 12));
    self waittill(#"stationary");
    self clientfield::set("supply_drop_fx", 1);
    wait 60;
    if (isdefined(self)) {
        self clientfield::set("supply_drop_fx", 0);
    }
}

// Namespace item_supply_drop/item_supply_drop
// Params 0, eflags: 0x4
// Checksum 0x433f6980, Offset: 0x1e48
// Size: 0x2c
function private function_b084ed83() {
    self waittill(#"death");
    self thread function_cc2021a1();
}

// Namespace item_supply_drop/item_supply_drop
// Params 3, eflags: 0x4
// Checksum 0xc95bbdff, Offset: 0x1e80
// Size: 0x1bc
function private function_7c49a646(path, droppoint, var_f82ee654 = 1) {
    self endon(#"death");
    self endon(#"emergency_exit");
    for (pathindex = 1; pathindex < path.size; pathindex++) {
        var_f4668854 = 0;
        if (isdefined(droppoint)) {
            var_f4668854 = distancesquared(path[pathindex], droppoint) < 128 * 128;
        }
        self function_3c8dce03(path[pathindex], var_f4668854 && var_f82ee654, 0);
        while (true) {
            if (var_f4668854) {
                if (distancesquared(droppoint, self.origin) < 128 * 128) {
                    if (var_f82ee654) {
                        wait 2;
                    }
                    self thread function_cc2021a1();
                    if (var_f82ee654) {
                        wait 1;
                    }
                    break;
                }
            } else if (distancesquared(path[pathindex], self.origin) < 1500 * 1500) {
                break;
            }
            waitframe(1);
        }
    }
    self delete();
}

// Namespace item_supply_drop/item_supply_drop
// Params 1, eflags: 0x0
// Checksum 0x8673da70, Offset: 0x2048
// Size: 0x5be
function function_50a4cbe6(helicopter = 0) {
    if (!(isdefined(level.var_3b2d97c0) && level.var_3b2d97c0)) {
        return;
    }
    if (!isdefined(level.deathcircles) || level.deathcircles.size <= 0) {
        return;
    }
    var_a7d74ce3 = helicopter ? 10000 : 35000;
    deathcircleindex = isdefined(level.deathcircleindex) ? level.deathcircleindex : 0;
    deathcircle = level.deathcircles[deathcircleindex];
    nextdeathcircle = isdefined(level.deathcircles[deathcircleindex + 1]) ? level.deathcircles[deathcircleindex + 1] : deathcircle;
    if (helicopter) {
        var_67bd51be = 5000;
    } else {
        var_67bd51be = 20000;
    }
    var_4f8d4e24 = 2000 + var_67bd51be;
    mapcenter = player_insertion::function_af3c10c2();
    mapwidth = player_insertion::function_b64da31b();
    deathcirclecenter = nextdeathcircle.origin;
    deathcirclecenter = (deathcirclecenter[0], deathcirclecenter[1], var_4f8d4e24);
    var_3e0a387b = nextdeathcircle.radius;
    if (!function_72c18993(deathcirclecenter)) {
        return;
    }
    var_326772a5 = deathcircle.radius;
    var_7c3dbbbd = deathcircle.radius - var_3e0a387b;
    degrees = randomint(360);
    var_3f7a23b = (cos(degrees) * var_3e0a387b, sin(degrees) * var_3e0a387b, var_4f8d4e24) + deathcirclecenter;
    exitpoint = (cos(degrees) * -1 * var_3e0a387b, sin(degrees) * -1 * var_3e0a387b, var_4f8d4e24) + deathcirclecenter;
    waitframe(1);
    var_c2e6f458 = 10;
    droppoint = undefined;
    for (index = 0; index < var_c2e6f458; index++) {
        randompoint = lerpvector(var_3f7a23b, exitpoint, randomfloatrange(0, 1));
        if (function_72c18993(randompoint) && !oob::function_f84f2990(randompoint)) {
            droppoint = trace_point(randompoint, 0, undefined, -5000);
            if (isdefined(droppoint)) {
                droppoint = trace_point(randompoint, 0, var_a7d74ce3, var_67bd51be);
                break;
            }
        }
        waitframe(1);
    }
    if (!isdefined(droppoint)) {
        return;
    }
    var_3f7a23b = function_dae42667(var_3f7a23b, droppoint);
    var_3f7a23b = trace_point(var_3f7a23b, undefined, var_a7d74ce3, var_67bd51be);
    exitpoint = function_dae42667(exitpoint, droppoint);
    exitpoint = trace_point(exitpoint, undefined, var_a7d74ce3, var_67bd51be);
    var_388607dd = vectornormalize(exitpoint - var_3f7a23b);
    var_7aaa2a83 = max(var_326772a5, 15000);
    spawnpoint = var_3f7a23b - var_388607dd * var_7aaa2a83;
    spawnpoint = function_dae42667(spawnpoint, droppoint);
    endpoint = exitpoint + var_388607dd * var_7aaa2a83;
    endpoint = function_dae42667(endpoint, droppoint);
    if (isdefined(level.supplydropveh)) {
        level.supplydropveh delete();
    }
    if (helicopter) {
        var_efcf64ae = function_95dd2a62(spawnpoint, endpoint, droppoint);
    } else {
        var_efcf64ae = function_8b0f63e2(spawnpoint, endpoint, droppoint);
    }
    level.var_25b349b5 = var_3f7a23b;
    level.var_13d2ae4f = exitpoint;
}

// Namespace item_supply_drop/item_supply_drop
// Params 3, eflags: 0x0
// Checksum 0xbf22f366, Offset: 0x2610
// Size: 0x26e
function function_8b0f63e2(startpoint, endpoint, droppoint) {
    var_efcf64ae = array(startpoint, droppoint, endpoint);
    supplydropveh = spawnvehicle("vehicle_t8_mil_air_transport_infiltration", startpoint, vectortoangles(vectornormalize(endpoint - startpoint)));
    if (!isdefined(supplydropveh)) {
        return;
    }
    supplydropveh setforcenocull();
    voiceevent("warSupplyDropIncoming");
    supplydropveh.goalradius = 128;
    supplydropveh.goalheight = 128;
    supplydropveh.var_efcf64ae = var_efcf64ae;
    supplydropveh.maxhealth = supplydropveh.health;
    supplydropveh.var_66f32a7b = supplydropveh.maxhealth * 0.5;
    supplydropveh setspeed(100);
    supplydropveh setrotorspeed(1);
    supplydropveh vehicle::toggle_tread_fx(1);
    supplydropveh vehicle::toggle_exhaust_fx(1);
    supplydropveh vehicle::toggle_sounds(1);
    supplydropveh.var_3bee8dcf = 1;
    supplydrop = function_556584ce(supplydropveh);
    supplydrop linkto(supplydropveh, "tag_origin", (0, 0, -120));
    supplydropveh.supplydrop = supplydrop;
    supplydropveh thread function_7c49a646(var_efcf64ae, droppoint, 0);
    supplydropveh thread function_b084ed83();
    level.item_supply_drops[level.item_supply_drops.size] = supplydrop;
    return var_efcf64ae;
}

// Namespace item_supply_drop/item_supply_drop
// Params 3, eflags: 0x0
// Checksum 0x4910e217, Offset: 0x2888
// Size: 0x33e
function function_95dd2a62(startpoint, endpoint, droppoint) {
    var_efcf64ae = function_e9cde02(startpoint, endpoint, droppoint);
    assert(var_efcf64ae.size >= 2);
    startpoint = var_efcf64ae[0];
    endpoint = var_efcf64ae[var_efcf64ae.size - 1];
    supplydropveh = spawnvehicle("vehicle_t8_mil_helicopter_transport_dark_wz", startpoint, vectortoangles(vectornormalize(endpoint - startpoint)));
    if (!isdefined(supplydropveh)) {
        return;
    }
    supplydropveh setforcenocull();
    voiceevent("warSupplyDropIncoming");
    target_set(supplydropveh, (0, 0, 0));
    supplydropveh.goalradius = 128;
    supplydropveh.goalheight = 128;
    supplydropveh.var_efcf64ae = var_efcf64ae;
    supplydropveh.maxhealth = supplydropveh.health;
    supplydropveh.var_66f32a7b = supplydropveh.maxhealth * 0.5;
    supplydropveh.overridevehicledamage = &function_63441715;
    supplydropveh setspeed(100);
    supplydropveh setrotorspeed(1);
    supplydropveh vehicle::toggle_tread_fx(1);
    supplydropveh vehicle::toggle_exhaust_fx(1);
    supplydropveh vehicle::toggle_sounds(1);
    supplydropveh.var_3bee8dcf = 1;
    supplydrop = function_556584ce(supplydropveh);
    supplydrop linkto(supplydropveh, "tag_cargo_attach", (0, 0, -30));
    supplydropveh.supplydrop = supplydrop;
    supplydropveh thread function_7c49a646(var_efcf64ae, droppoint);
    supplydropveh thread function_b084ed83();
    level.item_supply_drops[level.item_supply_drops.size] = supplydrop;
    level.supplydrop = supplydrop;
    level.supplydropveh = supplydropveh;
    level.var_efcf64ae = var_efcf64ae;
    level.var_be844fc7 = droppoint;
    level.var_ebe249b9 = startpoint;
    level.var_bcaa4b64 = endpoint;
    return var_efcf64ae;
}

// Namespace item_supply_drop/item_supply_drop
// Params 2, eflags: 0x0
// Checksum 0xc643ff62, Offset: 0x2bd0
// Size: 0x1ae
function drop_supply_drop(droppoint, helicopter = 0) {
    assert(isvec(droppoint));
    if (!function_72c18993(droppoint)) {
        return;
    }
    droppoint = trace_point(droppoint, 0);
    mapcenter = function_985e0b79();
    var_841ec0b7 = function_d744e134();
    if (var_841ec0b7 == 0) {
        var_841ec0b7 = 10000;
    }
    var_ab67ce77 = vectornormalize(droppoint - mapcenter);
    spawnpoint = function_dae42667(mapcenter + var_ab67ce77 * var_841ec0b7, droppoint);
    endpoint = function_dae42667(mapcenter - var_ab67ce77 * var_841ec0b7, droppoint);
    if (helicopter) {
        var_efcf64ae = function_95dd2a62(spawnpoint, endpoint, droppoint);
        return;
    }
    var_efcf64ae = function_8b0f63e2(spawnpoint, endpoint, droppoint);
}

